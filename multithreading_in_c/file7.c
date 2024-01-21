/*
Summing numbers from an array
*/

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>


int primes[10] = { 2, 3, 5, 7, 11, 13, 17, 19, 23, 29 };

void* routine(void* arg);

int main(int argc, char* argv[])
{
    pthread_t th[2];
    
    for (int i = 0; i < 2; i++)
    {
        int* a = malloc(sizeof(int));
        *a = i * 5;
        if (pthread_create(&th[i], NULL, &routine, a) != 0)
        {
            perror("Failed to create thread.\n");
        }
    }

    int totalSum = 0;

    for (int i = 0; i < 2; i++)
    {
        void* r;
        if (pthread_join(th[i], &r) != 0)
        {
            perror("Failed to join thread.\n");
        }

        totalSum += *(int*)r;
        free(r);
    }

    printf("Sum of array: %d\n", totalSum);

    return 0;
}

void* routine(void* arg)
{
    int index = *(int*)arg;
    int sum = 0;
    for (int i = 0; i < 5; i++)
    {
        sum += primes[index + i];
    }

    *(int*)arg = sum;
    
    return arg;
}