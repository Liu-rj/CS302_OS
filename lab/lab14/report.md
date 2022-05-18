# CS302 OS Lab14 - Report

Name: 刘仁杰
SID: 11911808

## Answers

### 1. 手册第二部分中的inode，如果blcck_size是4KB，指针大小是4B，一个inode能管理的最大文件大小是多少，写出计算过程。

direct block: 12 * 4KB = 48KB

single indirect block: 2^10 * 4KB = 4MB

double indirect block: 2^10 * 2^10 * 4KB = 4GB

triple indirect block: 2^10 * 2^10 * 2^10 * 4KB = 4TB

Total size: 48KB + 4MB + 4GB + 4TB

### 2. SFS中的inode可以管理的最大文件大小是多少，写出计算过程。

direct block: 12 * 4KB = 48KB

indirect block: 2^10 * 4KB = 4MB

Total size: 48KB + 4MB

### 3. SFS中sfs_disk_inode和sfs_disk_entry的关系是什么。

sfs_disk_entry唯一标识一个sfs_disk_inode，里面存有文件夹下文件inode的名字信息和索引节点所占数据块索引值（磁盘块）。
