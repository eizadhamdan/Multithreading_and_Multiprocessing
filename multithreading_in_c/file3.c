#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <pthread.h>

int mails = 0;
pthread_mutex_t mutex;

void* routine()
{
    for(int i = 0; i < 1000000; i++)
    {
        pthread_mutex_lock(&mutex);
        mails++;
        pthread_mutex_unlock(&mutex);
    }
}
//to solve the race condition we use mutex
//race condition can only occur on multi-core processors

int main(int argc, char* argv[])
{
    pthread_mutex_init(&mutex, NULL);       //initialising the mutex

    pthread_t t1, t2, t3;
    if (pthread_create(&t1, NULL, &routine, NULL) != 0)
    {
        printf("Failed to create a thread 1.\n");
        return 1;
    }

    if (pthread_create(&t2, NULL, &routine, NULL) != 0)
    {
        printf("Failed to create a thread 2.\n");
        return 2;
    }

    if (pthread_create(&t3, NULL, &routine, NULL) != 0)
    {
        printf("Failed to create a thread 3.\n");
        return 3;
    }

    if (pthread_join(t1, NULL) != 0)
    {
        return 4;
    }

    if (pthread_join(t2, NULL) != 0)
    {
        return 5;
    }
    
    if (pthread_join(t3, NULL) != 0)
    {
        return 6;
    }

    pthread_mutex_destroy(&mutex);              //need to destroy the mutex
    printf("Number of mails: %d\n", mails);

    return 0;
}

/*
for compiling-

--------------------------------
gcc -g -pthread file3.c -o file3
--------------------------------
*/
