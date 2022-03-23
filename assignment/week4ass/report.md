# CS302 OS Week4 Assignment - Report

Name: 刘仁杰
SID: 11911808

## 1. Read Chapter 2 of "Three Easy Pieces"

1) “three easy pieces” of operating systems

* Virtualization: transform a physical resource (cpu, memory, disk, ...) into a more general easy-to-use virtual form, which further allows many programs to run and share physical resources concurrently. 
* Concurrency: working on many things concurrently in the same program or by multi-threaded programs without incurring incorrect results.
* Persistence: How the os take control of file system to store data persistently, access device, enhance performance with typical mechanisms and recover data from crash for failure.

2. How do these “three easy pieces” map to the chapters in the “dinosaur book”?

* Virtualization: Chapter 5,10
* Concurrency: Chapter 4,6,7,8
* Persistence: Chapter 12,13,14,15

## 2. What happens during context switch in detail?
* Process A is running
* Interrupted by timer
* Hardware saves A's registers onto its kernel stack and switch to the kernel mode
* Trap handler call `switch()` routine which saves current register values into the process structure of A and restores the registers of Process B from its process structure entry.
* Change the stack pointer to use B’s kernel stack
* OS returns-from-trap, which restores B’s registers from B's kernel stack and starts running Process B

## 3. Read slides “L03 Processes I” and “L04 Processes II” and answer questions:

(1) Explain what happens when the kernel handles the fork() system call

* When fork() system call is invoked, the program switch from user mode to kernel mode (save and restore context)
* In OS kernel, new address space is created for the child process, and copy the kernel space (PCB) of parent process to the newly created address space
* OS kernel does the kernel update of the child kernel space, which includes PID, running time, and a pointer to its parent
* OS kernel will also create a pointer in parent process's kernel space which points to the forked child
* Add the child process to the task list
* User space of the child process is also copied and updated
* fork() is completed, return value is set in both the parent process and newly forked child process respectively to be the child process PID and 0
* CPU scheduler decide which process to be executed next
* If parent process is to be executed next, the child PID is returned, program switch back to user mode and the process is continued
* If child process is to be executed next, there will be a context switch from parent process to child process which involves PCB reload, pc rebase and switch from kernel mode to user mode, starting running process B

(2) Explain what happens when the kernel handles the exit() system call

* When exit() system call is invoked, the program switch from user mode to kernel mode
* The kernel frees all allocated memory in kernel space, except the PID and the list of opened files are closed
* The kernel frees everything on the user-space memory about the concerned process, including program code and allocated memory
* The kernel sends a SIGCHLD signal to its parent process which notifies the child process has now terminated
* If its parent process invoked wait() system call
  * the kernel will register a signal handling routine for parent process and the process is blocked
  * When it receives SIGCHLD, the corresponding signal handling routine is invoked
  * The SIGCHLD handler accepts and removes the SIGCHLD signal and destroys the child process in the kernel-space (remove it from process table, task-list, etc.)
  * Now the child process is truly dead and recycled
* If the parent process hasn't invoked wait() system call
  * the parent process doesn't respond to the SIGCHLD signal
  * Thus, the child process becomes a zombie until the parent process invoked wait() and receive its SIGCHLD signal

## 4. What are the three methods of transferring the control of the CPU from a user process to OS kernel?

* system call: system calls in user program require the switch from user mode to kernel mode, which typically ask for the control of kernel resources
* interrupt: Typically invoked by interrupt signals, the signals received is passed to trap handler who further dispatches the task to the corresponding interrupt handler function
* exception: Typically invoked by exception signals, the signals received is passed to trap handler who further dispatches the task to the corresponding exception handler function

## 5. Describe the life cycle of a process

* Birth: Except the first process “init”, every process is created using fork()
* After one process is just forked or OS scheduler choose another process to run or a process is just returning from blocked states, the process will enter `ready state`
* When OS chooses this process to be running on the CPU, the process state is adjusted to `running state`
* While the process the running, it may wait for some resources, which will cause the process to be in `blocking state`
* In `blocking state`, when response arrives, the status of the process changes back to `ready state`
* When the process goes to an end or is forced to terminate, the process enters `Zombie(terminated) state`

## 6. Realize a shell of your own in myshell.c through fork () + exec () + wait ()

* start the shell

![Screenshot from 2022-03-23 19-45-29](/home/lrj11911808/Pictures/Screenshot from 2022-03-23 19-45-29.png)

* Basic Instructions -- ps, ls, ls -al, pwd

![Screenshot from 2022-03-23 19-51-06](/home/lrj11911808/Pictures/Screenshot from 2022-03-23 19-51-06.png)

* Basic Instructions -- which, echo, touch, cat, rm

![Screenshot from 2022-03-23 19-56-28](/home/lrj11911808/Pictures/Screenshot from 2022-03-23 19-56-28.png)


* cd .., cd, cd ~, cd /home, cd /

![Screenshot from 2022-03-23 19-58-22](/home/lrj11911808/Pictures/Screenshot from 2022-03-23 19-58-22.png)


* exit

![Screenshot from 2022-03-23 19-58-49](/home/lrj11911808/Pictures/Screenshot from 2022-03-23 19-58-49.png)

* background process

One can launch background process using `&` and the terminal goes without being blocked

![Screenshot from 2022-03-23 20-00-06](/home/lrj11911808/Pictures/Screenshot from 2022-03-23 20-00-06.png)

* pipe

![Screenshot from 2022-03-23 20-01-31](/home/lrj11911808/Pictures/Screenshot from 2022-03-23 20-01-31.png)

* FIFO

one can launch a FIFO as usual and it will be blocked until someone reads

![Screenshot from 2022-03-23 20-02-43](/home/lrj11911808/Pictures/Screenshot from 2022-03-23 20-02-43.png)

![Screenshot from 2022-03-23 20-03-03](/home/lrj11911808/Pictures/Screenshot from 2022-03-23 20-03-03.png)

* ctrl + c

ctrl + c can terminate child process while it loses efficacy on the shell itself

![Screenshot from 2022-03-23 20-04-20](/home/lrj11911808/Pictures/Screenshot from 2022-03-23 20-04-20.png)
