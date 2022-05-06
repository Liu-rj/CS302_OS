# CS302 OS Week11 Assignment - Report

Name: 刘仁杰
SID: 11911808

## EX0. CPU Scheduling

| Time                  | HRRN | FIFO/FCFS |  RR  | SJF  | Priority |
| --------------------- | :--: | :-------: | :--: | :--: | :------: |
| 1                     |  A   |     A     |  A   |  A   |    A     |
| 2                     |  A   |     A     |  A   |  A   |    B     |
| 3                     |  A   |     A     |  B   |  A   |    A     |
| 4                     |  A   |     A     |  A   |  A   |    D     |
| 5                     |  B   |     B     |  D   |  B   |    D     |
| 6                     |  D   |     D     |  A   |  D   |    C     |
| 7                     |  D   |     D     |  C   |  D   |    C     |
| 8                     |  C   |     C     |  D   |  C   |    C     |
| 9                     |  C   |     C     |  C   |  C   |    A     |
| 10                    |  C   |     C     |  C   |  C   |    A     |
| Avg. Turn-around Time | 4.5  |    4.5    | 4.75 | 4.5  |   4.25   |

## EX1. Implement a syscall that can set the priority of current process

Design idea:

* First, since `ex1.c` includes `ulib.h`, we can create a function `set_priority()` in `ulib.c` and define it in `ulib.h`. Then the user program can call this function to set priority.
* In the implementation of `set_priority()`, we invoke call to `sys_setpriority()` which is implemented in `user/libs/syscall.c`.
* In `sys_setpriority()`, `syscall()` is invoked with parameter `SYS_labschedule_set_priority` and `priority`.
* `ecall` then trigger trap into the kernel `syscall()`, where we register `SYS_labschedule_set_priority` with function `sys_setpriority()`.
* In kernel's `sys_setpriority()`, current process's priority is set to the passed priority.

Modified codes:

ulib.h and ulib.c:

![Screenshot from 2022-05-06 15-19-12](/home/lrj11911808/Pictures/Screenshot from 2022-05-06 15-19-12.png)

![Screenshot from 2022-05-06 15-18-58](/home/lrj11911808/Pictures/Screenshot from 2022-05-06 15-18-58.png)

user/libs/syscall.h and user/libs/syscall.c:

![Screenshot from 2022-05-06 15-19-31](/home/lrj11911808/Pictures/Screenshot from 2022-05-06 15-19-31.png)

![Screenshot from 2022-05-06 15-19-22](/home/lrj11911808/Pictures/Screenshot from 2022-05-06 15-19-22.png)

kernel/syscall/syscall.c:

![Screenshot from 2022-05-06 15-19-50](/home/lrj11911808/Pictures/Screenshot from 2022-05-06 15-19-50.png)

Result:

![Screenshot from 2022-05-06 15-21-44](/home/lrj11911808/Pictures/Screenshot from 2022-05-06 15-21-44.png)

## EX2. the RR scheduling Algorithm based on Priority

Design idea:

* For proiority based RR, we just need to modify the time slice to be `max_time_slice * priority` when a process is enqueued into `run_queue`.

Modified codes:

![Screenshot from 2022-05-06 16-05-41](/home/lrj11911808/Pictures/Screenshot from 2022-05-06 16-05-41.png)

Results:

![Screenshot from 2022-05-06 16-08-15](/home/lrj11911808/Pictures/Screenshot from 2022-05-06 16-08-15.png)

```
memory management: default_pmm_manager
physcial memory map:
  memory: 0x08800000, [0x80200000, 0x885fffff].
sched class: RR_scheduler
pid: 1's time slice is 5
SWAP: manager = fifo swap manager
setup timer interrupts
The next proc is pid:1
pid: 2's time slice is 5
The next proc is pid:2
kernel_execve: pid = 2, name = "ex2".
Breakpoint
pid: 3's time slice is 5
pid: 4's time slice is 5
pid: 5's time slice is 5
pid: 6's time slice is 5
pid: 7's time slice is 5
main: fork ok,now need to wait pids.
The next proc is pid:3
set priority to 3
pid: 3's time slice is 15
The next proc is pid:4
set priority to 1
pid: 4's time slice is 5
The next proc is pid:5
set priority to 4
pid: 5's time slice is 20
The next proc is pid:6
set priority to 5
pid: 6's time slice is 25
The next proc is pid:7
set priority to 2
pid: 7's time slice is 10
The next proc is pid:3
pid: 3's time slice is 15
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:5
pid: 5's time slice is 20
The next proc is pid:6
pid: 6's time slice is 25
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:3
pid: 3's time slice is 15
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:5
pid: 5's time slice is 20
The next proc is pid:6
pid: 6's time slice is 25
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:3
pid: 3's time slice is 15
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:5
pid: 5's time slice is 20
The next proc is pid:6
pid: 6's time slice is 25
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:3
pid: 3's time slice is 15
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:5
pid: 5's time slice is 20
The next proc is pid:6
pid: 6's time slice is 25
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:3
pid: 3's time slice is 15
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:5
pid: 5's time slice is 20
The next proc is pid:6
pid: 6's time slice is 25
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:3
pid: 3's time slice is 15
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:5
pid: 5's time slice is 20
The next proc is pid:6
pid: 6's time slice is 25
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:3
pid: 3's time slice is 15
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:5
pid: 5's time slice is 20
The next proc is pid:6
pid: 6's time slice is 25
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:3
pid: 3's time slice is 15
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:5
pid: 5's time slice is 20
The next proc is pid:6
pid: 6's time slice is 25
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:3
pid: 3's time slice is 15
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:5
pid: 5's time slice is 20
The next proc is pid:6
child pid 6, acc 4000001, time 6880
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:3
pid: 3's time slice is 15
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:5
pid: 5's time slice is 20
The next proc is pid:2
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:3
pid: 3's time slice is 15
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:5
child pid 5, acc 4000001, time 7760
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:3
pid: 3's time slice is 15
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:2
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:3
pid: 3's time slice is 15
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:3
pid: 3's time slice is 15
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:3
child pid 3, acc 4000001, time 8840
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:2
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:7
pid: 7's time slice is 10
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:7
child pid 7, acc 4000001, time 9950
The next proc is pid:4
pid: 4's time slice is 5
The next proc is pid:2
The next proc is pid:4
pid: 4's time slice is 5
pid: 4's time slice is 5
pid: 4's time slice is 5
pid: 4's time slice is 5
pid: 4's time slice is 5
pid: 4's time slice is 5
pid: 4's time slice is 5
pid: 4's time slice is 5
pid: 4's time slice is 5
pid: 4's time slice is 5
pid: 4's time slice is 5
pid: 4's time slice is 5
pid: 4's time slice is 5
pid: 4's time slice is 5
pid: 4's time slice is 5
pid: 4's time slice is 5
pid: 4's time slice is 5
pid: 4's time slice is 5
pid: 4's time slice is 5
pid: 4's time slice is 5
child pid 4, acc 4000001, time 11010
The next proc is pid:2
main: wait pids over
The next proc is pid:1
all user-mode processes have quit.
The end of init_main
kernel panic at kern/process/proc.c:418:
    initproc exit.
```

## EX3. Preemptive process scheduling [40pts]

Design idea:

* Nearly the same as EX1, first we need to implment `set_good` syscall along the invoking trace.
* After implementing `set_good`, we need to overwrite a new preemptive scheduling functions in `default_schedule.c` and register it as the member function of `default_sched_class`.

Modified codes:

ulib.h and ulib.c:

![Screenshot from 2022-05-06 16-13-05](/home/lrj11911808/Pictures/Screenshot from 2022-05-06 16-13-05.png)

![Screenshot from 2022-05-06 16-13-11](/home/lrj11911808/Pictures/Screenshot from 2022-05-06 16-13-11.png)

user/libs/syscall.h and syscall.c:

![Screenshot from 2022-05-06 16-13-24](/home/lrj11911808/Pictures/Screenshot from 2022-05-06 16-13-24.png)

![Screenshot from 2022-05-06 16-13-31](/home/lrj11911808/Pictures/Screenshot from 2022-05-06 16-13-31.png)

kernel/syscall/syscall.c:

![Screenshot from 2022-05-06 16-13-53](/home/lrj11911808/Pictures/Screenshot from 2022-05-06 16-13-53.png)

default_sched.c:

![Screenshot from 2022-05-06 16-14-15](/home/lrj11911808/Pictures/Screenshot from 2022-05-06 16-14-15.png)

![Screenshot from 2022-05-06 16-14-33](/home/lrj11911808/Pictures/Screenshot from 2022-05-06 16-14-33.png)

Results:

![Screenshot from 2022-05-06 16-17-57](/home/lrj11911808/Pictures/Screenshot from 2022-05-06 16-17-57.png)
