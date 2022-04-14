# CS302 OS Lab09 - Report

Name: 刘仁杰
SID: 11911808

## Answers

### 1.**详细描述do_fork的函数调用过程，具体请包括do_fork内部调用（跳转至）了哪些函数，调用过程是怎样的，每个函数（包括do_fork）的作用是什么。**

1. 首先，do_fork函数是用来创建管理进程的结构体，填充对应的信息，同时根据传入的参数，即trapframe将完成的内容写入进程。
1. do_fork函数内部首先调用alloc_proc来创建一个新的结构体，为其分配内存空间。
1. 然后调用setup_kstack，里面通过alloc_pages(2)和page2kva来为将要创建的进程分配2个page的kernel stack。
1. 然后调用copy_mm，在当前project中没有做操作。
1. 然后调用copy_thread，在其中将将要创建的进程的kernel stack的栈顶trapframe指针指向传入的trapframe，同时设置a0, ra和sp寄存器。
1. 然后通过getpid函数来拿到一个unique的pid，并将他赋给新进程。
1. 然后调用list_add将新进程对应的hash_link插入到hash队列，将proc_link插入到proc队列。
1. 最后调用wakeup_proc将新进程设置为runnable，至此新进程已经可以运行。
1. 最后返回新进程pid。

### 2.**详细描述schedule的函数调用过程，具体请包括 schedule内部调用（跳转至）了哪些函数，调用过程是怎样的，每个函数（包括schedule）的作用是什么。**

1. 首先，schedule函数是用来做进程调度和切换的。
2. 在schedule函数中，首先在process_link找到下一个runnable的process。
3. 然后调用proc_run，运行该target process。
4. 在proc_run函数中，首先将current，当前进程结构体指向传入的进程结构体。
5. 然后调用lcr3函数，设置页表寄存器。
6. 然后调用switch_to函数，做当前运行进程和传入进程的上下文切换。
7. 在switch_to函数中，将需要保存的寄存器进行保存和调换。
8. 返回时，ra寄存器被设置为forkret，即会返回到forkret函数中。
9. 在forkret函数中，将进程的中断帧放在了sp，然后调转到__trapret，在其中从中断帧中恢复所有寄存器。
10. 由于中断帧的epc寄存器指向kernel_thread_entry，则会进入kernel_thread_entry函数。
11. 在kernel_thread_entry函数中，将s1寄存器里的内容，即传给函数的参数放入a1寄存器，然后jump到s0寄存器指向的地址，即新进程要执行的函数，这样就正式开始运行新进程，完成了调度。