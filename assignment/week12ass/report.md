# CS302 OS Week12 Assignment - Report

Name: 刘仁杰
SID: 11911808

## 1. Deadlock

Need Matrix:

|      |  A   |  B   |  C   |  D   |
| ---- | :--: | :--: | :--: | :--: |
| P1   |  2   |  1   |  0   |  0   |
| P2   |  0   |  0   |  2   |  1   |
| P3   |  1   |  0   |  0   |  1   |
| P4   |  0   |  1   |  1   |  1   |

### (1) Is the operating system in a safe state? Why？

|      | Available | Status  |
| :--: | :-------: | :-----: |
|  T0  | (1,0,1,2) | P3 done |
|  T1  | (1,0,2,2) | P2 done |
|  T2  | (1,1,2,3) | P4 done |
|  T3  | (2,2,2,3) | P1 done |

So, the OS is in a safe state.

### (2) If P4 requests (0,0,1,1), please run the Banker’s algorithm to determine if the request should be granted.

If P4 is granted with (0,0,1,1), then:

Need Matrix:

|      |  A   |  B   |  C   |  D   |
| ---- | :--: | :--: | :--: | :--: |
| P1   |  2   |  1   |  0   |  0   |
| P2   |  0   |  0   |  2   |  1   |
| P3   |  1   |  0   |  0   |  1   |
| P4   |  0   |  1   |  0   |  0   |

|      | Available |         Status         |
| :--: | :-------: | :--------------------: |
|  T0  | (1,0,0,1) |        P3 done         |
|  T1  | (1,0,1,1) | no process can be done |

This time the OS is in dead lock. So, the request from P4 should not be granted.

### (3) Let’s assume P4’s request was granted anyway (regardless of the answer to question 2). If then the processes request additional resources as follows, is the system in a deadlock state? Why?

If P4 is granted with (0,0,1,1), then available is (1,0,0,1).

|      | Available | Status  |
| :--: | :-------: | :-----: |
|  T0  | (1,0,0,1) | P3 done |
|  T1  | (1,0,1,1) | P2 done |
|  T2  | (1,1,1,2) | P4 done |
|  T3  | (2,2,1,2) | P1 done |

All processes are done, the system is not in a deadlock state.

## 2. Dining philosophers problem

* The first solution is that we just let one philosopher to eat at one time, so there are no cyclic use of resources.

![Screenshot from 2022-05-11 17-59-25](/home/lrj11911808/Pictures/Screenshot from 2022-05-11 17-59-25.png)

![Screenshot from 2022-05-11 19-32-31](/home/lrj11911808/Pictures/Screenshot from 2022-05-11 19-32-31.png)

* The second solution is that we can let as many as philosophers to eat but one philosopher can eat only when his left neighbors and right neighbors are not eating. Moreover, when a philosopher ends eating, he will notify his left and right neighbors and ask them if they want to eat.

![Screenshot from 2022-05-11 19-47-02](/home/lrj11911808/Pictures/Screenshot from 2022-05-11 19-47-02.png)

![Screenshot from 2022-05-11 19-47-11](/home/lrj11911808/Pictures/Screenshot from 2022-05-11 19-47-11.png)

![Screenshot from 2022-05-11 19-47-21](/home/lrj11911808/Pictures/Screenshot from 2022-05-11 19-47-21.png)

![Screenshot from 2022-05-11 19-49-07](/home/lrj11911808/Pictures/Screenshot from 2022-05-11 19-49-07.png)

## 3. The too much milk problem.

Design idea: 

* To solve this problem, we can use three semaphores to prevent deadlock and guarantee the syncronization.
* The first semaphore is named `mutex` which is to guarantee the only unique access to the modification of milk numbers at a time.
* The second semaphore is named `fri_lock` which is used to indicate how many bottles of milk are currently in the fridge. Every time someone buys a bottle of milk, the `fri_lock` will be posted while son will first wait for a `fri_lock` semaphore before he opens the fridge. 
* The third semaphore is name `milk_lock` which is used to indicate how many bottles of milk should the buyers buy. Every time someone wants to buy a bottle of milk, he will first wait for a `milk_lock` semaphore. Also, whenever son fetches a bottle a milk, he will post a `milk_lock` semaphore.

![Screenshot from 2022-05-11 20-39-19](/home/lrj11911808/Pictures/Screenshot from 2022-05-11 20-39-19.png)

![Screenshot from 2022-05-11 20-39-30](/home/lrj11911808/Pictures/Screenshot from 2022-05-11 20-39-30.png)

![Screenshot from 2022-05-11 20-39-39](/home/lrj11911808/Pictures/Screenshot from 2022-05-11 20-39-39.png)

![Screenshot from 2022-05-11 20-39-49](/home/lrj11911808/Pictures/Screenshot from 2022-05-11 20-39-49.png)

![Screenshot from 2022-05-11 20-39-56](/home/lrj11911808/Pictures/Screenshot from 2022-05-11 20-39-56.png)

![Screenshot from 2022-05-11 20-40-13](/home/lrj11911808/Pictures/Screenshot from 2022-05-11 20-40-13.png)
