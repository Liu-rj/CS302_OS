#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <limits.h>
#define CMD_LEN 20
#define PATH_LEN 256

char *user_name;
char path[PATH_LEN];


void reset_signal()
{
    signal (SIGINT, SIG_DFL);
    signal (SIGQUIT, SIG_DFL);
    signal (SIGTSTP, SIG_DFL);
    signal (SIGTTIN, SIG_DFL);
    signal (SIGTTOU, SIG_DFL);
    signal (SIGCHLD, SIG_DFL);
}

void process_str(char *cmd[], char str[])
{
    const char split[2] = " ";
    for(int i=0; i < CMD_LEN; i++)
    {
        cmd[i]=(char*)malloc(10);
    }
    char *token;
    int len = 0;
    token = strtok(str, split);
    while(token != NULL) 
    {
        strcpy(cmd[len], token);
        token = strtok(NULL, split);
        len ++;
    }
    cmd[len] = NULL;
}


void process_bg(char *cmd[])
{
    pid_t pid = fork();
    if (pid == 0)
    {
        reset_signal();
        setpgid(0, 0);
        dup(STDIN_FILENO);
        dup(STDOUT_FILENO);
        dup(STDERR_FILENO);
        execvp(cmd[0], cmd);
        exit(0);
    }
}


void process_cd(char *cmd[])
{
    int cd_res;
    if (strcmp(cmd[1], "~") == 0)
    {
        cd_res = chdir(getenv("HOME"));
    }
    else
    {
        cd_res = chdir(cmd[1]);
    }
    if (cd_res != 0)
    {
        printf("Check your path!\n");
    }
    char *cd = getcwd(path, sizeof(path));
    if (cd == NULL)
    {
        printf("Check your path!\n");
    }
}


void process_pipe(char output_str[], char input_str[])
{
    char *input_cmd[CMD_LEN];
    char *output_cmd[CMD_LEN];
    process_str(output_cmd, output_str);
    process_str(input_cmd, input_str);
    int my_pipe[2];
    if (pipe(my_pipe) < 0)
    {
        perror("pipe");
    }
    pid_t pid = fork();
    if (pid == 0)
    {
        reset_signal();
        close(my_pipe[0]);
        dup2(my_pipe[1], STDOUT_FILENO);
        execvp(output_cmd[0], output_cmd);
    }
    else
    {
        waitpid(pid, NULL, 0);
        close(my_pipe[1]);
        dup2(my_pipe[0], STDIN_FILENO);
        execvp(input_cmd[0], input_cmd);
    }
}


void process_redi(char output_str[], char input_str[])
{
    char *output_cmd[CMD_LEN];
    process_str(output_cmd, output_str);
    pid_t pid = fork();
    if (pid == 0)
    {
        int file = open(input_str, O_WRONLY|O_CREAT|O_TRUNC, 7777);
        dup2(file, STDOUT_FILENO);
        execvp(output_cmd[0], output_cmd);
    }
    else
    {
        waitpid(pid, NULL, 0);
    }
}


void free_mem(char *cmd[])
{
    for(int i=0; i < CMD_LEN; i++)
    {
        free(cmd[i]);
    }
}

int main()
{
    user_name = getenv("LOGNAME");
    char hostname[HOST_NAME_MAX + 1];
    if(gethostname(hostname, HOST_NAME_MAX + 1))
    {
        perror("gethostname");
        return (1);
    }
    getcwd(path, sizeof(path));
    signal (SIGINT, SIG_IGN);
    signal (SIGQUIT, SIG_IGN);
    signal (SIGTSTP, SIG_IGN);
    signal (SIGTTIN, SIG_IGN);
    signal (SIGTTOU, SIG_IGN);
    signal (SIGCHLD, SIG_IGN);
    while(1)
    {
        printf("%s@%s:%s$", user_name, hostname, path);
        char *cmd[CMD_LEN];
        char str[256];
        fgets(str, 256, stdin);
        if ((strlen(str) == 1) && str[0] == '\n')
        {
            continue;
        }
        char *p = strchr(str, '\n');
        if (p)  *p = 0;
        int bg_flag = 0;
        if (str[strlen(str) - 1] == '&')
        {
            bg_flag = 1;
            str[strlen(str) - 1] = '\0';
            str[strlen(str) - 1] = '\0';
            process_str(cmd, str);
            process_bg(cmd);
            continue;
        }
        int pipe_flag = 0;
        if (!bg_flag)
        {
            char output_str[128], input_str[128];
            memset(output_str, 0x00, 128);
            memset(input_str, 0x00, 128);
            for (int i = 0; i < strlen(str); i++)
            {
                if (str[i] == '|')
                {
                    for (int j = 0; j < i-1; j++)
                    {
                        output_str[j] = str[j];
                    }
                    output_str[i-1] = '\0';
                    for (int j = 0; j < strlen(str)-i; j++)
                    {
                        input_str[j] = str[i+j+2];
                    }
                    input_str[strlen(str)-i] = '\0';
                    pipe_flag = 1;
                    break;
                }
            }
            if (pipe_flag)
            {
                pid_t pid = fork();
                if (pid == 0)
                {
                    process_pipe(output_str, input_str);
                }
                else
                {
                    waitpid(pid, NULL, 0);
                }
                continue;
            }
        }
        if (bg_flag == 0 && pipe_flag == 0)
        {            
            char output_str[128], input_str[128];
            memset(output_str, 0x00, 128);
            memset(input_str, 0x00, 128);
            int redi_flag = 0;
            for(int i = 0; i < strlen(str); i++)
            {
                if (str[i] == '>')
                {
                    redi_flag = 1;
                    for (int j = 0; j < i-1; j++)
                    {
                        output_str[j] = str[j];
                    }
                    output_str[i-1] = '\0';
                    for (int j = 0; j < strlen(str)-i; j++)
                    {
                        input_str[j] = str[i+j+2];
                    }
                    input_str[strlen(str)-i] = '\0';
                    break;
                }                
            }
            if (redi_flag == 1)
            {
                process_redi(output_str, input_str);
                continue;
            }
        }
        process_str(cmd, str);
        if (strcmp("pwd", cmd[0]) == 0)
        {
            printf("%s\n", path);
        }
        else if (strcmp("cd", cmd[0]) == 0)
        {
            process_cd(cmd);
        }
        else if (strcmp("exit", cmd[0]) == 0)
        {
            free_mem(cmd);
            exit(0);
        }
        else
        {
            pid_t pid = fork();
            if (pid)
            {
                waitpid(pid, NULL, 0);
            }
            else
            {
                reset_signal();
                execvp(cmd[0], cmd);
                perror("execvp");
                exit(0);
            }
        }
        free_mem(cmd);
    }
    return 0;
}