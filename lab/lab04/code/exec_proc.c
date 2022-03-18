#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>  
#include <sys/wait.h>

int main()
{
    if (fork())
    {
        printf("I'm parent process %d.\n", getpid());
        wait(NULL);
        printf("Parent process %d exit.\n", getpid());
    }
    else
    {
        printf("I'm child process %d.\n", getpid());
        execl("/bin/ps", "/bin/ps", "-al", NULL);
    }
    return 0;
}