# CS302 OS Week12 Assignment - Report

Name: 刘仁杰
SID: 11911808

## 1. I/O

1. What are the pros and cons of polling and interrupt-based I/O?

   * polling: 
     * Pros: Simple and relatively lower overhead when the device is fast.
     * Cons: Inefficient, may waste many cycles on polling when the device is slow.
   * interrupt-based I/O:
     * Pros: Fully utilize CPU during I/O operations when the device is slow.
     * Cons: interrupts cost relatively high overhead when the device is fast.

2. What are the differences between PIO and DMA?

   In PIO, each byte is transferred via processor load/store. So the disk controller is simple and easy to program. However, this consumes processor cycles proportional to data size. In DMA, disk controller can directly access memory bus, so data blocks can be directly transferred to/from memory in parallel with the processor.

3. How to protect memory-mapped I/O and explicit I/O instructions from being abused by malicious user process?

   When the use processes launch memory-mapped I/O and explicit I/O instructions, OS is the only entity that can communicate with the device. Therefore, OS will guarantee that no harm will be caused by user processes.

## 2. Condition variable

* Design Idea:

We just need to use a semaphore to implement our conditional variable. When initiating the conditional variable, we just initiate the semaphore with value 0. Then in `cond_signal`, we just release a semaphore signal by `up`. In `cond_wait`, we first release the mutex semaphore and grab a conditional variable's semaphore. After we grab the semaphore by `down`, we just re-hold the mutex semaphore.

* Code:

![Screenshot from 2022-05-18 18-07-22](/home/lrj11911808/Pictures/Screenshot from 2022-05-18 18-07-22.png)

![Screenshot from 2022-05-18 18-07-35](/home/lrj11911808/Pictures/Screenshot from 2022-05-18 18-07-35.png)

* Running Results:

![Screenshot from 2022-05-18 18-07-50](/home/lrj11911808/Pictures/Screenshot from 2022-05-18 18-07-50.png)

## 3. Bike

* Design Idea:

We can use three conditional variables and one mutex to complete the implementation. First worker1 makes a bike rack, then he release a conditional signal. Then the woker2 wait and receive this conditional signal. starts making two bike wheels and then releases the second conditional signal. Then the worker3 wait and receive the second conditional signal and starts assembling the bike. After this cycle, the worker3 release a third conditional signal to be taken by worker1 for the next cycle. Whenever a worker starts this work, he will first grab the mutex and release it when he finishes.

* Code:

![Screenshot from 2022-05-18 20-14-33](/home/lrj11911808/Pictures/Screenshot from 2022-05-18 20-14-33.png)

![Screenshot from 2022-05-18 20-14-44](/home/lrj11911808/Pictures/Screenshot from 2022-05-18 20-14-44.png)

![Screenshot from 2022-05-18 20-14-51](/home/lrj11911808/Pictures/Screenshot from 2022-05-18 20-14-51.png)

* Running Result:

![Screenshot from 2022-05-18 20-15-08](/home/lrj11911808/Pictures/Screenshot from 2022-05-18 20-15-08.png)
