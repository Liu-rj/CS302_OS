#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <pthread.h>
#include <semaphore.h>

sem_t fri_lock;
sem_t milk_lock;
sem_t mutex;

void *mom(int *num)
{
    for (int i = 0; i < 10; i++)
    {
        printf("Mom comes home.\n");
        sleep(rand() % 2 + 1);
        sem_wait(&milk_lock);
        printf("Mom goes to buy milk.\n");
        sem_wait(&mutex);
        *num += 1;
        sem_post(&mutex);
        sem_post(&fri_lock);
        if (*num > 2)
        {
            printf("What a waste of food! The fridge can not hold so much milk!\n");
            while (1)
                printf("TAT~");
        }
        printf("Mom puts milk in fridge and leaves.\n");
    }
}

void *dad(int *num)
{
    for (int i = 0; i < 10; i++)
    {
        printf("Dad comes home.\n");
        sleep(rand() % 2 + 1);
        sem_wait(&milk_lock);
        printf("Dad goes to buy milk.\n");
        sem_wait(&mutex);
        *num += 1;
        sem_post(&mutex);
        sem_post(&fri_lock);
        if (*num > 2)
        {
            printf("What a waste of food! The fridge can not hold so much milk!\n");
            while (1)
                printf("TAT~");
        }
        printf("Dad puts milk in fridge and leaves.\n");
    }
}

void *grandfather(int *num)
{
    for (int i = 0; i < 10; i++)
    {
        printf("Grandfather comes home.\n");
        sleep(rand() % 2 + 1);
        sem_wait(&milk_lock);
        printf("Grandfather goes to buy milk.\n");
        sem_wait(&mutex);
        *num += 1;
        sem_post(&mutex);
        sem_post(&fri_lock);
        if (*num > 2)
        {
            printf("What a waste of food! The fridge can not hold so much milk!\n");
            while (1)
            {
                printf("TAT~");
            }
        }
        printf("Grandfather puts milk in fridge and leaves.\n");
    }
}

void *son(int *num)
{
    for (int i = 0; i < 30; i++)
    {
        printf("Son comes home.\n");
        sem_wait(&fri_lock);
        if (*num == 0)
        {
            printf("The fridge is empty!\n");
            while (1)
            {
                printf("TAT~");
            }
        }
        printf("Son fetches a milk\n");
        sem_wait(&mutex);
        *num -= 1;
        sem_post(&mutex);
        sem_post(&milk_lock);
        printf("Son leaves\n");
    }
}

int main(int argc, char *argv[])
{
    srand(time(0));

    int num_milk = 0;
    pthread_t p1, p2, p3, p4;
    sem_init(&fri_lock, 1, 0);
    sem_init(&milk_lock, 1, 2);
    sem_init(&mutex, 1, 1);

    // Create two threads (both run func)
    pthread_create(&p1, NULL, mom, &num_milk);
    pthread_create(&p2, NULL, dad, &num_milk);
    pthread_create(&p3, NULL, grandfather, &num_milk);
    pthread_create(&p4, NULL, son, &num_milk);

    // Wait for the threads to end.
    pthread_join(p1, NULL);
    pthread_join(p2, NULL);
    pthread_join(p3, NULL);
    pthread_join(p4, NULL);

    printf("success!\n");
}
