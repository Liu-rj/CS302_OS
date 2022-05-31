# CS302 OS Week15 Assignment - Report

Name: 刘仁杰
SID: 11911808

## 1. Disk scheduling

1.  READ/WRITE data time = Seek time + Rotational latency + Transfer time
2. Use FIFO\SSTF\SCAN\CSCAN algorithm to read the six sectors
   * FIFO:
     * sequence: 70, 30, 90, 120, 60, 20
     * time: $(30+40+60+30+60+40)\times 1+6\times \frac{60000}{12000\times 2}=275ms$
   * SSTF
     * sequence: 90, 70, 60, 30, 20, 120
     * time: $(10+20+10+30+10+100)\times 1+6\times \frac{60000}{12000\times 2}=195ms$
   * SCAN
     * sequence: 120, 200, 90, 70, 60, 30, 20
     * time: $(20+80+110+20+10+30+10)\times 1+6\times \frac{60000}{12000\times 2}=295ms$
   * CSCAN
     * sequence: 120, 200, 0, 20, 30, 60, 70, 90
     * time: $(20+80+200+20+10+30+10+20)\times 1+6\times \frac{60000}{12000\times 2}=405ms$

## 2. Simple File System
