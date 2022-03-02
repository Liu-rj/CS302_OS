#include <mmu.h>
#include <memlayout.h>

    .section .text,"ax",%progbits
    # ax alloction and execute 
    # "progbits" is a type
    .globl kern_entry
kern_entry:
    la sp, bootstacktop

    tail kern_init

.section .data
    # .align 2^12
    .align PGSHIFT
    .global bootstack
bootstack:
    .space KSTACKSIZE
    .global bootstacktop
bootstacktop: