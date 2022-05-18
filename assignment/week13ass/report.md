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

   
