#include <stdio.h>
#include <stdlib.h>
#include <time.h> 
#include <pthread.h>
#include <semaphore.h>


pthread_mutex_t fri_lock;

void *mom(int *num){
    for(int i=0;i<10;i++){
        pthread_mutex_lock(&fri_lock);
        printf("Mom comes home.\n");
        sleep(rand()%2+1);
        printf("Mom goes to buy milk.\n");
        *num += 1;
        if (*num > 2){
            printf("What a waste of food! The fridge can not hold so much milk!\n");
            while(1)printf("TAT~");
        }
        printf("Mom puts milk in fridge and leaves.\n");
        pthread_mutex_unlock(&fri_lock);
    }

}

void *dad(int *num){
    for(int i=0;i<10;i++){
        pthread_mutex_lock(&fri_lock);
        printf("Dad comes home.\n");
        sleep(rand()%2+1);
        printf("Dad goes to buy milk.\n");
        *num += 1;
        if (*num > 2){
            printf("What a waste of food! The fridge can not hold so much milk!\n");
            while(1)printf("TAT~");
        }
        printf("Dad puts milk in fridge and leaves.\n");  
        pthread_mutex_unlock(&fri_lock);
    }
}

void *grandfather(int *num){
    for(int i=0;i<10;i++){
        pthread_mutex_lock(&fri_lock);
        printf("Grandfather comes home.\n");
        sleep(rand()%2+1);
        printf("Grandfather goes to buy milk.\n");
        *num += 1;
        if (*num > 2){
            printf("What a waste of food! The fridge can not hold so much milk!\n");
            while(1){
            	printf("TAT~");
            }
        }
        printf("Grandfather puts milk in fridge and leaves.\n");
        pthread_mutex_unlock(&fri_lock);
    }
}

void *son(int *num){
    for(int i = 0; i < 30 ; i++){
        pthread_mutex_lock(&fri_lock);
        printf("Son comes home.\n");
        if(*num == 0){
            printf("The fridge is empty!\n");
            while(1){
            	printf("TAT~");
            }
        }
        printf("Son fetches a milk\n");
        *num -= 1;
        printf("Son leaves\n");
        pthread_mutex_unlock(&fri_lock);
    }
}

int main(int argc, char * argv[]) {
    srand(time(0));

    int num_milk = 0;
    pthread_t p1, p2, p3, p4;
    pthread_mutex_init(&fri_lock,NULL);

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
