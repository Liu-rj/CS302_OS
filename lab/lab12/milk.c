/*dad_mem_mutex.c*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <time.h>
#include <sys/stat.h>
#include <pthread.h>

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
int milk_num = 0;
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;

void *mom()
{
    while (1)
    {
        sleep(rand() % 2 + 1);
        pthread_mutex_lock(&mutex);
        while (milk_num > 0)
        {
            printf("Mom checks the fridge.\n");
            pthread_cond_wait(&cond, &mutex);
        }
        printf("Mom buys 10 milks.\n");
        milk_num = 10;
        pthread_mutex_unlock(&mutex);
    }
    // int fd;
    // printf("Mom comes home.\n");
    // sleep(rand() % 2 + 1);
    // pthread_mutex_lock(&mutex);
    // printf("Mom checks the fridge.\n");
    // fd = open("fridge", O_CREAT | O_RDWR | O_APPEND, 0777);
    // if (lseek(fd, 0, SEEK_END) == 0)
    // {
    //     printf("Mom goes to buy milk...\n");
    //     // sleep(rand()%2+1);
    //     printf("Mon comes back.\n");
    //     if (lseek(fd, 0, SEEK_END) > 0)
    //         printf("What a waste of food! The fridge can not hold so much milk!\n");
    //     else
    //     {
    //         write(fd, "milk", 4);
    //         printf("Mom puts milk in fridge and leaves.\n");
    //     }
    // }
    // else
    // {
    //     printf("Mom closes the fridge and leaves.\n");
    // }
    // close(fd);
    // pthread_mutex_unlock(&mutex);
}

void *dad()
{
    while (1)
    {
        sleep(rand() % 2 + 1);
        pthread_mutex_lock(&mutex);
        if (milk_num > 0)
        {
            printf("Dad takes 1 milk.\n");
            milk_num--;
        }
        else
        {
            printf("Dad notices there is no milk.\n");
            pthread_cond_signal(&cond);
        }
        pthread_mutex_unlock(&mutex);
    }
    // int fd;
    // printf("Dad comes home.\n");
    // sleep(rand() % 2 + 1);
    // pthread_mutex_lock(&mutex);
    // printf("Dad checks the fridge.\n");
    // fd = open("fridge", O_CREAT | O_RDWR | O_APPEND, 0777);
    // if (lseek(fd, 0, SEEK_END) == 0)
    // {
    //     printf("Dad goes to buy milk...\n");
    //     // sleep(rand()%2+1);
    //     printf("Dad comes back.\n");
    //     if (lseek(fd, 0, SEEK_END) > 0)
    //         printf("What a waste of food! The fridge can not hold so much milk!\n");
    //     else
    //     {
    //         write(fd, "milk", 4);
    //         printf("Dad puts milk in fridge and leaves.\n");
    //     }
    // }
    // else
    // {
    //     printf("Dad closes the fridge and leaves.\n");
    // }
    // close(fd);
    // pthread_mutex_unlock(&mutex);
}

void *you()
{
    while (1)
    {
        sleep(rand() % 2 + 1);
        pthread_mutex_lock(&mutex);
        if (milk_num > 0)
        {
            printf("You take 1 milk.\n");
            milk_num--;
        }
        else
        {
            printf("You notice there is no milk.\n");
            pthread_cond_signal(&cond);
        }
        pthread_mutex_unlock(&mutex);
    }
}

void *sister()
{
    while (1)
    {
        sleep(rand() % 2 + 1);
        pthread_mutex_lock(&mutex);
        while (milk_num > 0)
        {
            printf("Sister checks the fridge.\n");
            pthread_cond_wait(&cond, &mutex);
        }
        printf("Sister buys 10 milks.\n");
        milk_num = 10;
        pthread_mutex_unlock(&mutex);
    }
}

int main(int argc, char *argv[])
{
    srand(time(0));
    pthread_t p1, p2, p3, p4;
    // int fd = open("fridge", O_CREAT | O_RDWR | O_TRUNC, 0777); // empty the fridge
    // close(fd);
    // Create two threads (both run func)
    pthread_create(&p1, NULL, mom, NULL);
    pthread_create(&p2, NULL, dad, NULL);
    pthread_create(&p3, NULL, you, NULL);
    pthread_create(&p4, NULL, sister, NULL);

    // Wait for the threads to end.
    pthread_join(p1, NULL);
    pthread_join(p2, NULL);
    pthread_join(p3, NULL);
    pthread_join(p4, NULL);
}
