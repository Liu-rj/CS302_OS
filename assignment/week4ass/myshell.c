#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>

void maySimplifyPwd(char *pwd, char *userName)
{
    char *homePath = "/home/";
    char path[128];
    strcpy(path, homePath);
    strcat(path, userName);
    char *p = strstr(pwd, path);
    if (p == pwd)
    {
        strcpy(pwd + 1, pwd + strlen(path));
        pwd[0] = '~';
    }
}

int pid = 0;
void ctrlc_child()
{
    if (pid > 0)
    {
        kill(pid, 2);
        printf("\n");
    }
}

int main()
{
    signal(SIGINT, ctrlc_child);
    char hostName[128];
    char *pwd = (char *)malloc(128 * sizeof(char));
    char *userName;
    char line[1024], *args[128];
    while (1)
    {
        userName = getenv("USER");
        gethostname(hostName, 128);
        getcwd(pwd, 128);
        maySimplifyPwd(pwd, userName);
        printf("%s@%s:%s$ ", userName, hostName, pwd);

        fgets(line, 1024, stdin);
        if (strcmp(line, "\n") == 0)
        {
            continue;
        }
        line[strlen(line) - 1] = '\0';
        // perserve the string for further use
        char command[1024];
        strcpy(command, line);
        // start split the string
        char *p = strtok(line, " ");
        int index = 0;
        while (p)
        {
            args[index++] = p;
            p = strtok(NULL, " ");
        }
        args[index] = NULL;

        if (strcmp(args[0], "exit") == 0)
        {
            break;
        }
        else if (strcmp(args[0], "cd") == 0)
        {
            if (index == 1 || !strcmp(args[1], "~"))
            {
                args[1] = getenv("HOME");
            }
            chdir(args[1]);
        }
        else
        {
            if ((pid = fork()))
            {
                wait(NULL);
                pid = 0;
            }
            else
            {
                int error = 0;
                error = execvp(args[0], args);
                if (error == -1)
                {
                    printf("Command '%s' not found\n", command);
                }
                return 0;
            }
            // if (strcmp(args[0], "nohup") != 0)
            // {
            //     wait(NULL);
            // }
        }
    }
    return 0;
}