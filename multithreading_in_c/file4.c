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

int main(int argc, char* argv[])
{
    pthread_mutex_init(&mutex, NULL);

    pthread_t th[6];

    for(int i = 0; i < 6; i++)
    {
        if (pthread_create(th + i, NULL, &routine, NULL) != 0)
        {
            perror("Failed to create thread.\n");
            return 1;
        }
        printf("Thread %d has started.\n", i);
    }

    for(int i = 0; i < 6; i++)
    {
        if (pthread_join(th[i], NULL) != 0)
        {
            return 2;
        }
        printf("Thread %d has finished execution.\n", i);
    }
    
    pthread_mutex_destroy(&mutex);
    printf("Number of mails: %d\n", mails);

    return 0;
}

