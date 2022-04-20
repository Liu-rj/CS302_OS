# CS302 OS Mid-term Homework

> Name: 刘仁杰
>
> SID: 11911808

## 1. Terminologies of virtualization

#### (1) Define virtualization in 100 words?

virtualization is a technique that relies on software to simulate hardware functionality and enable the possiblity to run serveral different virtual systems on a single hardware which solve the problems such as legacy upgrading and resources underutilization.

#### (2) Please explain the three usage models of virtualization: workload isolation, workload consolidation, workload migration.

* workload isolation: Workload isolation by utilizing virtualization has benefits to the overall system in two perspectives. One is system security, which will be improved because instructions executed are confined to the VM in which they occur, so vicious instructions won't do harm to the hardware. The other is system reliability, which can be enhanced because software programs are isolated in different VMs, so software failure on one VM do not affect the other VMs.
* workload consolidation: There are mainly three benefits that virtualization has brought about to workload consolidation. The first is to solve the problem of proliferation of heterogeneous data and underutilized servers, virtualization make it possible to consolidate individual workloads onto a single physical platform within a single VM regardless of different hardware and systems, reducing the total cost of ownership. The second is that virtualization mitigates the challenges of software-hardware upgrads by allowing systems to run legacy and new operating systems concurrently.
* workload migration: virtualization decouples the guest from the hardware on which it is currently running. So, it is easier to migrate the guest to a different platform. In addition, VM migration can be triggered automatically by workload balancing or failure-prediction agents. This capability delivers improved quality of service at a lower operational cost.

#### (3) List 3 well-known VMMs.

* Xen
* Virtual PC
* VMotion

#### (4) Explain the following terms: paravirtualization, full virtualization, binary translation, hardware-assisted virtualization, hybrid virtualization.

* paravirtualization: paravirtualization is an enhancement of virtualization technology in which a guest OS that has been modified inside a virtual machine (VM) in order to use hypercalls for operations to handle instructions at compile time.
* full virtualization: full virtualization is a virtualization where the virtual hardware exposed is functionally identical to the underlying machine which allows unmodified operating systems to be hosted.
* binary translation: binary translation is where A VMM can support legacy operating systems by making modifications directly to guest-OS binaries, and thus supporting a broader range of operating systems, albeit with higher performance overheads, than VMMs that use paravirtualization.
* hardware-assisted virtualization: In hardware-assited virtualization, VMM runs in the privilege mode and allow a cpu instruction set to run directly without modifying guest OSes.
* hybrid virtualization:  hybrid-virtualization combines paravirtualization and hardware-assisted virtualization. For I/O devices, Timer, Idle handling, Interrupt controllers and MMU are identified to use para-virtualization while maintaining the same cpu behavoir as the hardware-assisted virtualization.

## 2. Privilege levels

#### (1) How many privilege levels does x86 (IA-32) provide? How are they used by OS and user processes (considering an ordinary OS without virtualization)? Please provide three examples of the importance of privilege separation.

1. x86 (IA-32) provides 4 privilege levels, from 0 (highest) to 1 (lowest). 
2. In a nonvirtualized system, OS operates at level 0 and all software applications run at level 3.
3. Three examples of the importance:
   1. This can protect the hardware which will only be accessed by trustedworthy processes with higher previliege, preventing the hardware being messed up by user processes.
   2.  When user processes crashed, this ensure that OS kernel processes with higher privilege won't be blocked by processes at a lower previliege, and can continue to clean up the mess and mantain the stability of the system.
   3. Processes with higher previliege can mitigate the potential damage of a computer security vulnerability if vicious user programs take place.

#### (2) What is ring compression?

Ring deprivileging uses privilege-based mechanisms to protect the VMM from guest software. However, in 64-bit mode, segment limits do not apply, and IA-32 paging does not distinguish privilege levels 0-2. So, the guest OS must run at privilege level 3. Thus, the guest OS will run at the same privilege level as guest applications and will not be protected from them.

#### (3) Without Intel VT-x, how does Xen address ring compression for X86 (IA-32)?

Withour Intel VT-x, Xen run guest OS in ring 1 and application run in ring 3.

#### (4) Without Intel VT-x, how does Xen address ring compression for x86-64?

Without Intel VT-x, hypervisor runs in ring 0 with both gurst kernel and applications run in ring 3. However, guest kernel run in different address space (different page tables) from applications. Then, one process in Xen has two page tables: one is for application context and another for kernel context. The context transition between application and kernel is handled by Xen.

#### (5) What is ring aliasing?

Ring aliasing refers to problems that arise when software is run at a privilege level other than the level for which it was written. First example is that push instruction will push the current privilege level on the stack. Another example is that br.call will store current privilege level into PFS register which can be read at any privilege level. In this two cases, the guest OS can easily know it is not running at privilege level 0.

#### (6) What are VMX root and VMX non-root in VT-x?

VMX root operation and VMX non-root operation are two forms of CPU operation in VT-x architecture. A VMM runs in VMX root and it runs its guest OSes and applications in VMX non-root. Both forms of operation support all four privilege levels, allowing a guest OS to run at its intended privilege level. VMM root has the flexibility to use multiple privilege levels while the software running in VMX non-root is deprivileged.

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