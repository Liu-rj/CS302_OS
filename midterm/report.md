# CS302 OS Mid-term Homework

> Name: 刘仁杰
>
> SID: 11911808

## 1. Terminologies of virtualization

#### (1) Define virtualization in 100 words?

#### (2) Please explain the three usage models of virtualization: workload isolation, workload consolidation, workload migration.

* workload isolation: workload isolation by utilizing virtualization has benefits to the overall system in two perspectives. One is system security, which will be improved because instructions executed are confined to the VM in which they occur, so vicious instructions won't do harm to the hardware. The other is system reliability, which can be enhanced because software programs are isolated in different VMs, so software failure on one VM do not affect the other VMs.

#### (3) List 3 well-known VMMs.



#### (4) Explain the following terms: paravirtualization, full virtualization, binary translation, hardware-assisted virtualization, hybrid virtualization.

## 2. Privilege levels

#### (1) How many privilege levels does x86 (IA-32) provide? How are they used by OS and user processes (considering an ordinary OS without virtualization)? Please provide three examples of the importance of privilege separation.

#### (2) What is ring compression?

#### (3) Without Intel VT-x, how does Xen address ring compression for X86 (IA-32)?

#### (4) Without Intel VT-x, how does Xen address ring compression for x86-64?

#### (5) What is ring aliasing?

#### (6) What are VMX root and VMX non-root in VT-x?

#### (7) How does Intel VT-x address the challenges of ring aliasing and ring compression?

## 3. System calls, interrupts and exceptions

#### (1) In the context of ordinary OS without virtualization, what are the purpose of system calls? What is the main difference between system calls and function calls? On x86-64 Linux, how are system call parameters passed to the kernel?

#### (2) What is a hypercall in Xen?

#### (3) How does Xen virtualize exceptions on x86 (IA-32)? What modifications does Xen make to the original x86 exception handlers?

#### (4) What are the challenges of virtualizing interrupts (especially regarding interrupt masking) on x86 (IA-32)?

#### (5) How does Xen virtualize interrupts on x86 (IA-32)? What is the benefit of such a design?

#### (6) What is VMCS in Intel VT-x? What are VM exits and VM entry? How are VMCS used during VM exits and VM entry

#### (7) How does Xen leverage Intel VT-x to virtualize interrupts?

#### (8) How does Intel VT-x support exception virtualization?

## 4. Address translation

#### (1) Explain x86 (IA-32) address translation.

#### (2) Explain x86-64 address translation

#### (3) Explain the relationship between guest virtual memory, guest physical memory, and machine memory.

#### (4) How does Xen manage the per-process page table in the VM and the per-OS page table in the VMM?

#### (5) What does “Address-space compression” mean?

#### (6) How does Xen address the problem of “Address-space compression”?

#### (7) What is Intel EPT? How to do MMU virtualization with Intel EPT?

#### (8) How does Xen allocate physical memory to each domain?