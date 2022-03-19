#include <stdio.h>
#include <unistd.h>

int main()
{
    if (fork())
    {
        printf("I'm parent process %d.\n", getpid());
        while (1);
        printf("Parent process %d exit.\n", getpid());
    }
    else
    {
        printf("I'm child process %d.\n", getpid());
        printf("Child process %d exit.\n", getpid());
    }
    return 0;
}