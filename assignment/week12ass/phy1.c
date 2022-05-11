#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>
#include <assert.h>
#include <semaphore.h>
#include <fcntl.h>
#include <sys/stat.h>

#define N 200

pthread_t philosophers[5];
pthread_mutex_t forks[5];

pthread_mutex_t printer_lock;

void update_bar(int percent_done)
{
    pthread_mutex_lock(&printer_lock);
    if (percent_done < 1)
    {
        pthread_mutex_unlock(&printer_lock);
        return;
    }
    printf("\r[");
    for (int i = 0; i < 100; ++i)
    {
        if (i < percent_done)
        {
            printf("-");
        }
        else if (i == percent_done)
        {
            printf(">");
        }
        else
        {
            printf(" ");
        }
    }
    printf("] %d%% done ", percent_done);
    fflush(stdout);
    pthread_mutex_unlock(&printer_lock);
}

int eat_cnt = 0;
int pick_cnt = 0;

void pick_fork(int fork_no)
{
    pthread_mutex_lock(&forks[fork_no]);
    __sync_fetch_and_add(&pick_cnt, 1);
}

void put_fork(int fork_no)
{
    pthread_mutex_unlock(&forks[fork_no]);
}

int left_fork_no(int p_no)
{
    return p_no;
}

int right_fork_no(int p_no)
{
    return (p_no + 1) % 5;
}

void pick_left_fork(int p_no)
{
    pick_fork(left_fork_no(p_no));
}

void pick_right_fork(int p_no)
{
    pick_fork(right_fork_no(p_no));
}

void put_left_fork(int p_no)
{
    put_fork(left_fork_no(p_no));
}

void put_right_fork(int p_no)
{
    put_fork(right_fork_no(p_no));
}

void eat(int p_no)
{
    __sync_fetch_and_add(&eat_cnt, 1);
    update_bar(eat_cnt * 100 / (N * 5));
    usleep(1000);
}
//-----------------start----------------------
// you can only modify this part
pthread_mutex_t mutex;

void init()
{
    pthread_mutex_init(&mutex, NULL);
}

void wants_to_eat(int p_no)
{
    pthread_mutex_lock(&mutex);
    pick_left_fork(p_no);
    pick_right_fork(p_no);

    eat(p_no);

    put_left_fork(p_no);
    put_right_fork(p_no);
    pthread_mutex_unlock(&mutex);
}

//----------------------end---------------------

void *eat_many_times(void *arg)
{
    int p_no = *(int *)arg;
    for (int i = 0; i < N; ++i)
    {
        wants_to_eat(p_no);
    }
    return NULL;
}

int main()
{
    init();
    pthread_mutex_init(&printer_lock, NULL);
    for (int i = 0; i < 5; ++i)
    {
        pthread_mutex_init(&forks[i], NULL);
    }

    for (int i = 0; i < 5; ++i)
    {
        int *no = malloc(sizeof(int));
        *no = i;
        pthread_create(&philosophers[i], NULL, eat_many_times, (void *)no);
    }

    for (int i = 0; i < N; ++i)
    {
        pthread_join(philosophers[i], NULL);
    }

    assert(pick_cnt == 2 * eat_cnt);
    assert(eat_cnt == N * 5);
    printf("ok.\n");
    return 0;
}