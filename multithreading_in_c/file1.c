#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <pthread.h>

void* routine()
{
    printf("Test from threads.\n");
    sleep(2);
    printf("Ending thread.\n");
}

int main(int argc, char* argv[])
{
    pthread_t t1, t2;
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

    if (pthread_join(t1, NULL) != 0)
    {
        return 3;
    }

    if (pthread_join(t2, NULL) != 0)
    {
        return 4;
    }

    return 0;
}

/*
for compiling-







--------------------------------
gcc -g -pthread file1.c -o file1
--------------------------------
*/