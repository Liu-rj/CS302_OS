# CS302 OS Lab13 - Report

Name: 刘仁杰
SID: 11911808

## Answers

### 1.解释 local_intr_save(intr_flag);的作用

Disable the interrupt.

### 2.在proc.c中，init_main在852行执行了check_sync()方法。方法通过sync/check_sync.c中part1的算法解决哲学家吃饭问题。

* （1）请描述part1的算法，并回答该算法是否能避免死锁？为什么？

Yes, because at one time, only one philosopher can eat.

* （2）注释掉part1，并在part2中实现理论课件中哲学家问题的final solution算法（代码截图，运行结果截图）

![Screenshot from 2022-05-11 17-33-10](/home/lrj11911808/Pictures/Screenshot from 2022-05-11 17-33-10.png)

![Screenshot from 2022-05-11 17-33-33](/home/lrj11911808/Pictures/Screenshot from 2022-05-11 17-33-33.png)
