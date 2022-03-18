# CS302 OS Lab04 - Report

Name: 刘仁杰
SID: 11911808

## Answers

### 1.代码中如何区分父子进程？父子进程的执行顺序是否是固定的？

* 如何区分父子进程：

父进程`fork()`返回值是子进程pid，而子进程`fork()`返回值是0。

* 父子进程的执行顺序：

父子进程的执行顺序不固定，由OS来调度。

### 2.waitpid()函数的原型是什么，参数的含义是什么，具体功能是什么？

* 函数原型：

```c
#include <sys/types.h> 
#include <sys/wait.h>
pid_t waitpid(pid_t pid,int *status,int options)
```

* 参数含义：

pid：

1. pid>0时，只等待进程ID等于pid的子进程。
2. pid=-1时，等待任何一个子进程，此时waitpid和wait的作用一模一样。
3. pid=0时，等待同一个进程组中的任何子进程。
4. pid<-1时，等待一个指定进程组中的任何子进程，这个进程组的ID等于pid的绝对值。

status：

如果`status`不为`NULL`，那么`waitpid()`将会把子进程结束返回的状态信息作为一个整形值存到传进来的指针。

options：一些额外的选项来控制waitpid，支持三个选项，可以用`or`运算符把它们连接起来使用

1. `WNOHANG`：即使没有子进程退出，它也会立即返回。
2. `WUNTRACED`：同时也会返回子进程是否停止的信息，以及停止的子进程的状态信息。
3. `WCONTINUED`：同时也会返回一个停止的子进程是否通过`SIGCONT`被恢复运行了。

* 具体功能：

suspends execution of the calling thread  until  a  child specified by pid argument has changed state.

### 3.请回答第四步僵尸进程中列举的第4种情况的结果会是什么？

当父进程结束时，子进程会被过继给init进程或者注册过的祖父进程，在子进程结束后，新的父进程会回收僵尸进程。

### 4.请编写一段c语言代码（截图），用于产生僵尸进程，并截图僵尸进程的状态(ps)。

代码：

![Screenshot from 2022-03-09 18-24-38](/home/lrj11911808/Pictures/Screenshot from 2022-03-09 18-24-38.png)

状态：

![Screenshot from 2022-03-09 18-23-39](/home/lrj11911808/Pictures/Screenshot from 2022-03-09 18-23-39.png)

### 5.请编写一段c语言代码（截图），使程序产生一个子进程，子进程通过exec()实现"ps -al"指令的功能后退出，父进程等待子进程结束后退出，运行效果截图。

代码：

![Screenshot from 2022-03-09 17-46-58](/home/lrj11911808/Pictures/Screenshot from 2022-03-09 17-46-58.png)

效果：

![Screenshot from 2022-03-09 17-46-48](/home/lrj11911808/Pictures/Screenshot from 2022-03-09 17-46-48.png)

### 6.请详细描述手册第七步pipe相关代码中父子进程的功能。

子进程：

* 将本进程`SIGALRM`注册为`write_data`函数。
* 将本进程`SIGINT`注册为`finish_write`函数。

父进程：

* 将本进程`SIGALRM`注册为`read_data`函数。
* 将本进程`SIGINT`注册为`finish_read`函数。

然后，子进程调用`kill(getpid(), SIGALRM);`，实际上是调用了`write_data`函数，向管道中写入得到的字符串，然后通过`kill(getppid(), SIGALRM);`调用父进程的`read_data`函数，父进程在`read_data`函数中从管道读取子进程写入的字符串，然后通过`kill(pid, SIGALRM);`调用子进程的`write_data`函数，如此循环，读写往复。

如果我们从terminal按下`ctrl+c`，则会通过`SIGINT`触发父进程和子进程的handler，即`finish_write`和`finish_read`函数，关闭管道的读写并结束进程。