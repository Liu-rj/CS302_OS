# CS302 OS Week4 Assignment - Report

Name: 刘仁杰
SID: 11911808

## 1. Read Chapter 2 of "Three Easy Pieces"

1) “three easy pieces” of operating systems

* Virtualization: transform a physical resource (cpu, memory, disk, ...) into a more general easy-to-use virtual form, which further allows many programs to run and share physical resources concurrently. 
* Concurrency: working on many things concurrently in the same program or by multi-threaded programs without incurring incorrect results.
* Persistence: How the os take control of file system to store data persistently, access device, enhance performance with typical mechanisms and recover data from crash for failure.

2. How do these “three easy pieces” map to the chapters in the “dinosaur book”?

* Virtualization: Chapter 3,5,9,10
* Concurrency: Chapter 3,4,5,6,7,8
* Persistence: Chapter 11,12,13,14,15

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
* 

(2) Explain what happens when the kernel handles the exit() system call

## 4) Describe how to call `ecall` instruction step by step after the kernel boot up
* When the kernel boot up, the first instruction to execute is set to `kern_entry` in `kernel.ld`.

* Then in `entry.S`, the function `kern_init` in `init.c` is invoked in `kern_entry`.
* In function `kern_init`, `cputs` function is invoked.
* Then in `stdio.c`, `cputs` invokes `cputch` which further invokes `cons_putc` in `console.c`.
* In `console.c`, `cons_putc` invokes `sbi_console_putchar` in `sbi.c`.
* Finally, in `sbi.c`, `sbi_console_putchar` invokes `sbi_call` where `ecall` is called.

## 5) Refer to `ecall`, Implement `shutdown()` to shutdown the system.
* Modified codes:

![Screenshot from 2022-03-07 11-26-56](/home/lrj11911808/Pictures/Screenshot from 2022-03-07 11-26-56.png)

![Screenshot from 2022-03-07 11-27-10](/home/lrj11911808/Pictures/Screenshot from 2022-03-07 11-27-10.png)

![Screenshot from 2022-03-07 11-27-23](/home/lrj11911808/Pictures/Screenshot from 2022-03-07 11-27-23.png)

![Screenshot from 2022-03-07 11-27-33](/home/lrj11911808/Pictures/Screenshot from 2022-03-07 11-27-33.png)

* Result:

![Screenshot from 2022-03-07 11-26-32](/home/lrj11911808/Pictures/Screenshot from 2022-03-07 11-26-32.png)