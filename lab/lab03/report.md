# CS302 OS Lab03 - Report

Name: 刘仁杰
SID: 11911808

## Answers

### 1.请详细描述本节课最小化内核的启动过程

* 把entry.S和init.c，stdio.c等几个c文件编译成为.o目标文件
* 链接器将.o文件链接成可执行文件（elf文件）
* objcopy把elf文件转化成为ucore.bin文件，即最小化内核的硬盘
* 在QEMU模拟的riscv计算机里，OpenSBI固件充当bootloader，此时计算机运行在M态，OpenSBI访问最小化内核的硬盘（ucore.bin文件），将二进制可执行文件读取到内存的特定位置，然后将program counter跳转到内存地址为0x80200000的位置，并且将计算机切换到S态，program counter开始读取相应内存地址的指令，开始执行内核代码。

### 2.ELF和BIN文件的区别是什么

1. ELF：

包含一个文件头(ELF header), 包含冗余的调试信息，指定程序每个section的内存布局，需要解析program header才能知道各段(section)的信息，每个section的被加载到哪个内存地址块是不确定的。

2. BIN：

没有多余的信息，简单地在文件头之后解释自己应该被加载到什么起始位置，OpenSBI可以很好的处理。

### 3.链接脚本的作用是什么

把输入文件(往往是 .o文件)链接成输出文件(往往是elf文件)，描述怎样把输入文件的section映射到输出文件的section, 同时规定这些section的内存布局。

### 4.在init.c （截图）使用cputs函数，使得在最小化内核启动后通过cputs打印出“SUSTech OS”（截图）

![](/home/lrj11911808/Pictures/Screenshot from 2022-03-02 17-17-57.png)

![](/home/lrj11911808/Pictures/Screenshot from 2022-03-02 17-15-45.png)

### 5.在stdio.c中参考cputs()函数实现double_puts()函数（截图），将输出的字符串每个字符打印两次，如double_puts("SUSTech")应输出"SSUUSSTTeecchh"。在init.c中调用该函数（截图），并使得最小化内核启动后输出“IILLOOVVEEOOSS”（截图）

![](/home/lrj11911808/Pictures/Screenshot from 2022-03-02 17-18-23.png)

![](/home/lrj11911808/Pictures/Screenshot from 2022-03-02 17-17-57.png)

![](/home/lrj11911808/Pictures/Screenshot from 2022-03-02 17-15-45.png)