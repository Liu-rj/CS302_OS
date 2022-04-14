# CS302 OS Week6 Assignment - Report

Name: 刘仁杰
SID: 11911808

## 1. explain what happens when the process accesses a memory page not present in the physical memory.

When the process accesses a memory page not present in the physical memory, it can be roughly divided into two cases.

* One is that when the process first access a page that has not been allocated in physical memory, then OS will allocate a new page in physical memory and may flush some pages out to disk according to page replacement algorithm if the physical memory is full.
* The other is that if a page is not present and has been swapped to disk, the OS will need to swap the page into memory in order to service the page fault. When the OS receives a page fault for a page in this case, it looks in the PTE to find the address, and issues the request to disk to fetch the page into memory. If the memory is full, OS will need to swap some pages out according to page replacement algorithm.

## 2. Consider the following reference string 7 0 1 2 0 3 0 4 2 3 0 3 2 1 2 0 1 7 0 1. Consider 4 pages. What are the number of page faults with the following policy: Optimal (MIN), LRU, FIFO.

* MIN: #page faults=8

| page | 7    | 0    | 1    | 2    | 0    | 3    | 0    | 4    | 2    | 3    | 0    | 3    | 2    | 1    | 2    | 0    | 1    | 7    | 0    | 1    |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| 0    | 7    |      |      |      |      | 3    |      |      |      | h    |      | h    |      | 1    |      |      | h    |      |      | h    |
| 1    |      | 0    |      |      | h    |      | h    |      |      |      | h    |      |      |      |      | h    |      |      | h    |      |
| 2    |      |      | 1    |      |      |      |      | 4    |      |      |      |      |      |      |      |      |      |      |      |      |
| 3    |      |      |      | 2    |      |      |      |      | h    |      |      |      | h    |      | h    |      |      | 7    |      |      |

* LRU: #page faults=8

| page | 7    | 0    | 1    | 2    | 0    | 3    | 0    | 4    | 2    | 3    | 0    | 3    | 2    | 1    | 2    | 0    | 1    | 7    | 0    | 1    |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| 0    | 7    |      |      |      |      | 3    |      |      |      | h    |      | h    |      |      |      |      |      | 7    |      |      |
| 1    |      | 0    |      |      | h    |      | h    |      |      |      | h    |      |      |      |      | h    |      |      | h    |      |
| 2    |      |      | 1    |      |      |      |      | 4    |      |      |      |      |      | 1    |      |      | h    |      |      | h    |
| 3    |      |      |      | 2    |      |      |      |      | h    |      |      |      | h    |      | h    |      |      |      |      |      |

* FIFO: #page faults=10

| page | 7    | 0    | 1    | 2    | 0    | 3    | 0    | 4    | 2    | 3    | 0    | 3    | 2    | 1    | 2    | 0    | 1    | 7    | 0    | 1    |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| 0    | 7    |      |      |      |      | 3    |      |      |      | h    |      | h    |      |      | 2    |      |      |      |      |      |
| 1    |      | 0    |      |      | h    |      | h    | 4    |      |      |      |      |      |      |      |      |      | 7    |      |      |
| 2    |      |      | 1    |      |      |      |      |      |      |      | 0    |      |      |      |      | h    |      |      | h    |      |
| 3    |      |      |      | 2    |      |      |      |      | h    |      |      |      | h    | 1    |      |      | h    |      |      | h    |

## 3. Realize Clock algorithm in swap_clock.c

![Screenshot from 2022-04-14 18-07-53](/home/lrj11911808/Pictures/Screenshot from 2022-04-14 18-07-53.png)

![Screenshot from 2022-04-14 18-08-35](/home/lrj11911808/Pictures/Screenshot from 2022-04-14 18-08-35.png)

![Screenshot from 2022-04-14 18-09-55](/home/lrj11911808/Pictures/Screenshot from 2022-04-14 18-09-55.png)

## 4. Realize LRU algorithm in swap_lru.c

![Screenshot from 2022-04-14 18-08-50](/home/lrj11911808/Pictures/Screenshot from 2022-04-14 18-08-50.png)

![Screenshot from 2022-04-14 18-09-04](/home/lrj11911808/Pictures/Screenshot from 2022-04-14 18-09-04.png)

![Screenshot from 2022-04-14 18-10-22](/home/lrj11911808/Pictures/Screenshot from 2022-04-14 18-10-22.png)
