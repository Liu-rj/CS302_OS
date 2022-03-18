# CS302 OS Lab05 - Report

Name: 刘仁杰
SID: 11911808

## Answers

### 1.**总结执行`ebreak`后，我们的操作系统是如何进行断点中断处理的**

* `ebreak`中断触发后，cpu会寻找`stvec`寄存器中的值，然后跳转到这个位置进行中断处理
* 在中断处理初始化函数中，把`stvec`设置成所有中断都要跳到 trapentry.S 进行处理
* 在trapentry.S中，`__alltraps`函数作为中断入口点执行
* `__alltraps`中先通过`SAVE_ALL`来保存上下文，具体操作是保存所有36个寄存器到栈顶
* 然后`move  a0, sp`来传递参数，`jal trap`跳转到`trap.c`里面的`trap`函数，`a0`寄存器作为参数
* 在`trap`中断处理函数中，根据`scause`将异常处理的工作分发给了`interrupt_handler()`和`exception_handler()`，再根据类型作不同处理，`ebreak`会给`exception_handler`进行处理，打印错误信息并对`sepc`进行加2操作，防止重复调用
* 中断处理完成后，跳转回`trapentry.S`，执行`__trapret`里面的内容
* `RESTORE_ALL`恢复上下文，从栈顶反向写入36个寄存器，最后再恢复栈顶指针
* 最后执行`sret`，从S 态中断返回到 U 态，实际作用为pc←sepc

### 2.**触发一条非法指令异常（ILLEGAL_INSTRUCTION），在 `kern/trap/trap.c`的异常处理函数中捕获，并对其进行处理，简单输出异常类型和指令即可。**

![Screenshot from 2022-03-16 18-21-41](/home/lrj11911808/Pictures/Screenshot from 2022-03-16 18-21-41.png)

![Screenshot from 2022-03-16 18-18-14](/home/lrj11911808/Pictures/Screenshot from 2022-03-16 18-18-14.png)