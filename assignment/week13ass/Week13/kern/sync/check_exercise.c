// kern/sync/check_exercise.c
#include <stdio.h>
#include <proc.h>
#include <sem.h>
#include <assert.h>
#include <condvar.h>

struct proc_struct *pworker1, *pworker2, *pworker3;

condvar_t cond1, cond2, cond3;
semaphore_t mutex;

void worker1(int i)
{
    do_sleep(2);
    down(&mutex);
    cprintf("make a bike rack\n");
    cond_signal(&cond1);
    up(&mutex);
    while (1)
    {
        do_sleep(2);
        down(&mutex);
        cond_wait(&cond3, &mutex);
        cprintf("make a bike rack\n");
        cond_signal(&cond1);
        up(&mutex);
    }
}

void worker2(int i)
{
    while (1)
    {
        do_sleep(2);
        down(&mutex);
        cond_wait(&cond1, &mutex);
        cprintf("make two wheels\n");
        cond_signal(&cond2);
        up(&mutex);
    }
}

void worker3(int i)
{
    while (1)
    {
        do_sleep(2);
        down(&mutex);
        cond_wait(&cond2, &mutex);
        cprintf("assemble a bike\n");
        cond_signal(&cond3);
        up(&mutex);
    }
}

void check_exercise(void)
{

    // initial
    cond_init(&cond1);
    cond_init(&cond2);
    cond_init(&cond3);
    sem_init(&mutex, 1);

    int pids[3];
    int i = 0;
    pids[0] = kernel_thread(worker1, (void *)i, 0);
    pids[1] = kernel_thread(worker2, (void *)i, 0);
    pids[2] = kernel_thread(worker3, (void *)i, 0);
    pworker1 = find_proc(pids[0]);
    set_proc_name(pworker1, "worker1");
    pworker2 = find_proc(pids[1]);
    set_proc_name(pworker2, "worker2");
    pworker3 = find_proc(pids[2]);
    set_proc_name(pworker3, "worker3");
}
