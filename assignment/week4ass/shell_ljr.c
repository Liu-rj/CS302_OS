#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <ctype.h>

//Get current path
char* get_my_path(char* tmphome){
        char *pwd=getcwd(NULL,0);// the absolute directory
	char *home=(char*)malloc(strlen(tmphome));
	strcpy(home,tmphome);//copy the home directory
        int counter=0;
        char *home_split=strtok(home,"/");
        while (home_split){ //count how many layers the home directory has, e.g. /home/jiaruiluo11911419 has 2 layers
                counter++;
                home_split=strtok(NULL,"/");
        }
        // the next a few lines are to check whether the absolute directory contains home directory
	if (strlen(pwd)>=strlen(tmphome)){
		char *part_pwd=(char*)malloc(strlen(tmphome));
		int i=0;
		while (*(tmphome+i)!='\0'){
			*(part_pwd+i)=*(pwd+i);
			i++;
		}
		*(part_pwd+i)='\0';
		if (strcmp(part_pwd,tmphome)==0){ //if the absolute directory contains home directory, then ~ should be used
			char *final_path="~";
        		char *pwd_split=strtok(pwd,"/");
        		for (int i=0;i<counter;i++){
                		pwd_split=strtok(NULL,"/");
        		}
        		while (pwd_split){
                		char* temp=(char*) malloc(strlen(final_path)+strlen(pwd_split)+strlen("/"));
                		strcpy(temp,final_path);
                		strcat(temp,"/");
                		strcat(temp,pwd_split);
                		final_path=temp;
                		pwd_split=strtok(NULL,"/");
        		}
			free(home);
			return final_path;
		}
		free(part_pwd);
	}
	return pwd; //if not contains, then directly output the absolute path
}

//ctrlc child process
pid_t child=-1;
void ctrlc_child(pid_t child){
	if (child>1) kill(child,2);
}

int main(){
	//Get machine name
	char ff_s[128];
	gethostname(ff_s,sizeof(ff_s)-1);
	//Get UserName
	char *user_name=getenv("USER");
	//Get current path
	char *home=getenv("HOME");
	char *final_path=get_my_path(home);
	//start reading input
	while (1){
		//read the input command
		char command[1024];
		printf("%s@%s:%s$ ",user_name,ff_s,final_path);
		fflush(stdout);
		ssize_t readFlag=read(0,command,sizeof(command)-1);
		if (readFlag>0){command[readFlag-1]='\0';}
		else{
			printf("Wrong Input\n");
			break;
		}
		char* argv[128];
		argv[0]=command;
		int iter=1;
		char* pointer=command;
		//convert the command into a list of arguments
		while (*pointer){
			if (isspace(*pointer)){
				*pointer='\0';
				pointer++;
				argv[iter++]=pointer;
			}
			else{
				pointer++;
			}
		}
		argv[iter]=NULL;
		//exit
		if (strcmp(command,"exit")==0) break;
		//cd
		if (strcmp(argv[0],"cd")==0){
                                if (iter==1){
                                        printf("[myshell] cd: missing argument\n");
                                }
                                else{
					if (strcmp(argv[1],"~")==0){
						argv[1]=getenv("HOME"); //implement cd ~
					}
                                        chdir(argv[1]);
                                        final_path=get_my_path(home);
                                }
				continue;
                }
		//which
		if (strcmp(argv[0],"which")==0){
			if (iter==1){
				printf("[myshell] which: missing argument\n");
			}
			else{
				char *tmppaths=getenv("PATH");
				char *paths=(char*)malloc(strlen(tmppaths));
				int ii=0;
				while (*(tmppaths+ii)){
					*(paths+ii)=*(tmppaths+ii);
					ii++;
				}
                                char *sp_path=strtok(paths,":");
                                while (*sp_path){
                                        char *temp_comm1=(char*) malloc(strlen(sp_path)+strlen(argv[1])+1);
                                        strcpy(temp_comm1,sp_path);
                                        strcat(temp_comm1,"/");
                                        strcat(temp_comm1,argv[1]);
                                        if (access(temp_comm1,X_OK)==0){
                                                printf("%s\n",temp_comm1);
                                                free(temp_comm1);
                                                break;
                                        }
                                        sp_path=strtok(NULL,":");
                                        free(temp_comm1);
                                }
				free(paths);

			}
			continue;
		}
		//other command--create child process
		child=-1;
		child=fork();
		if (child){
			//The parent process, when receive SIGINT, interrupts child, which also prevents itself from being interrupted. The parent process should also wait for the child process.
			signal(SIGINT,(void (*)(int))ctrlc_child);
			wait(NULL);
		}
		else{
			//child process
			char* temp_comm;
			int flag=0;
			//check whether the current path has the executable file, if yes, run it directly
			if (access(argv[0],X_OK)==0){
				temp_comm=argv[0];
                        	execvp(temp_comm,argv);
				flag=1;	
			}
			//if not, search the environment variable $PATH to find the executable file. If found, run it.
			else{
				char *paths=getenv("PATH");
				char *sp_path=strtok(paths,":");
				while (*sp_path){
					temp_comm=(char*) malloc(strlen(sp_path)+strlen(argv[0])+1);
					strcpy(temp_comm,sp_path);
					strcat(temp_comm,"/");
					strcat(temp_comm,argv[0]);
					if (access(temp_comm,X_OK)==0){
                        			execvp(temp_comm,argv);
						free(temp_comm);
						flag=1;
						break;
					}
					sp_path=strtok(NULL,":");
					free(temp_comm);
				}
			}
			if (flag==0) printf("No command found.\n");
			exit(0);
		}
	}
	return 0;
}
