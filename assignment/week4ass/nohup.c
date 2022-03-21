#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>

int main()
{
    if (!fork())
    {
        char *args[7] = {"./test", "&", NULL};
        int status = execvp(args[0], args);
        if (status == -1)
        {
            printf("error exec command");
            return 0;
        }
        
    }
    wait(NULL);
}