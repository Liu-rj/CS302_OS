#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <sys/stat.h>

struct Command
{
    char *args[128];
    int length;
} Command;

struct Redirection
{
    int flag;
    char *file;
} Redirection;

void
maySimplifyPwd(char *pwd, char *userName)
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

int parseLine(struct Command commands[], char *line, struct Redirection* redirection)
{
    char *p = strtok(line, " ");
    int index = 0;
    commands[index].length = 0;
    while (p)
    {
        if (strcmp(p, "|") == 0)
        {
            commands[index].args[commands[index].length] = NULL;
            index++;
            commands[index].length = 0;
            commands[index].args[0] = NULL;
            p = strtok(NULL, " ");
            continue;
        }
        if (strcmp(p, ">") == 0)
        {
            redirection->flag = 1;
            p = strtok(NULL, " ");
            redirection->file = p;
        }
        commands[index].args[commands[index].length++] = p;
        p = strtok(NULL, " ");
    }
    return index + 1;
}

void singleProcess(struct Command command, struct Redirection redirection)
{
    int error = 0;
    int file = open(redirection.file, O_WRONLY|O_CREAT|O_TRUNC, 7777);
    dup2(file, STDOUT_FILENO);
    error = execvp(command.args[0], command.args);
    if (error == -1)
    {
        perror("execvp");
    }
}

void pipeProcess(struct Command commands[], int size, struct Redirection redirection)
{
    int myPipe[2];
    if (pipe(myPipe) < 0)
    {
        perror("pipe");
    }
    for (int i = 0; i < size - 1; i++)
    {
        if (fork() == 0)
        {
            if (i == 0)
            {
                dup2(myPipe[1], STDOUT_FILENO);
            }
            else
            {
                dup2(myPipe[1], STDOUT_FILENO);
                dup2(myPipe[0], STDIN_FILENO);
            }
            int error = 0;
            error = execvp(commands[i].args[0], commands[i].args);
            if (error == -1)
            {
                perror("execvp");
            }
            return;
        }
        wait(NULL);
    }
    close(myPipe[1]);
    dup2(myPipe[0], STDIN_FILENO);
    int error = 0;
    error = execvp(commands[size - 1].args[0], commands[size - 1].args);
    if (error == -1)
    {
        perror("execvp");
    }
    close(myPipe[0]);
}

int main()
{
    signal(SIGINT, SIG_IGN);
    char hostName[128];
    char *pwd = (char *)malloc(128 * sizeof(char));
    char *userName;
    char line[1024], *args[128];
    struct Command commands[128];
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
        // start split the string
        struct Redirection redirection;
        int size = parseLine(commands, line, &redirection);

        if (strcmp(commands[0].args[0], "exit") == 0)
        {
            break;
        }
        else if (strcmp(commands[0].args[0], "cd") == 0)
        {
            if (commands[0].length == 1 || strcmp(commands[0].args[1], "~") == 0)
            {
                commands[0].args[1] = getenv("HOME");
            }
            chdir(commands[0].args[1]);
        }
        else
        {
            int bgFlag = 0;
            if (strcmp(commands[size - 1].args[commands[size - 1].length - 1], "&") == 0)
            {
                bgFlag = 1;
            }
            int pid = fork();
            if (pid)
            {
                if (!bgFlag)
                {
                    waitpid(pid, NULL, 0);
                }
            }
            else
            {
                signal(SIGINT, SIG_DFL);
                if (bgFlag)
                {
                    commands[size - 1].args[commands[size - 1].length - 1] = NULL;
                    setpgid(0, 0);
                    dup(STDIN_FILENO);
                    dup(STDOUT_FILENO);
                    dup(STDERR_FILENO);
                }
                if (size == 1)
                {
                    singleProcess(commands[0], Redirection);
                    return 0;
                }
                else
                {
                    pipeProcess(commands, size, Redirection);
                    return 0;
                }
            }
        }
    }
    return 0;
}