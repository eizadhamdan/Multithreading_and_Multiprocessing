#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>


pthread_mutex_t mutex;

void* routine(void* arg);

int main(int argc, char* argv[])
{
    pthread_t th[4];
    pthread_mutex_init(&mutex, NULL);

    for (int i = 0; i < 4; i++)
    {
        if (pthread_create(&th[i], NULL, &routine, NULL) != 0)
        {
            perror("Failed to create a thread.\n");
        }
    }

    for (int i = 0; i < 4; i++)
    {
        if (pthread_join(th[i], NULL) != 0)
        {
            perror("Failed to join a thread.\n");
        }
    }

    pthread_mutex_destroy(&mutex);

    return 0;
}

void* routine(void* arg)
{
    //pthread_mutex_trylock returns 0 if lock is acquired and returns EBUSY if lock is not acquired. (EBUSY can be found in errno header file)
    if (pthread_mutex_trylock(&mutex) == 0)
    {
        printf("Mutex lock acquired.\n");
        sleep(1);
        pthread_mutex_unlock(&mutex);
    }
    else
    {
        printf("Mutex lock not acquired!\n");
    }
}
