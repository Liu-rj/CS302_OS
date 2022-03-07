# CS302 OS Week3 Assignment - Report

Name: 刘仁杰
SID: 11911808

## 1) Explain the function of each parameter in `make qemu`

* `qemu-system-riscv64`: QEMU riscv64 emulator
* `-machine virt`: select emulated machine type, RISC-V VirtIO board
* `-nographic`: disable graphical output and redirect serial I/Os to console
* `-bios default`: set the filename for the BIOS, here default
* `-device loader,file=bin/ucore.bin,addr=0x80200000`: add device based on "Generic Loader", and sets driver properties, driver file path: `bin/ucore.bin`, driver program counter on start: `0x80200000`.

## 2) Explain the function of each line in `/lab3/tools/kernel.ld`
* `OUTPUT_ARCH(riscv)`: Specify a particular output machine architecture, here `riscv`.
* `ENTRY(kern_entry)`: The first instruction to execute in a program, here set to symbol `kern_entry`.
* `BASE_ADDRESS = 0x80200000;`: Set the variable `BASE_ADDRESS` to `0x80200000`.
* `SECTIONS{}`: Define the regions to set section mapping and memory layout.
* `. = BASE_ADDRESS;`: Set the location counter to be the value of `BASE_ADDRESS`.
* `.text : {*(.text.kern_entry .text .stub .text.* .gnu.linkonce.t.*)}`: Defines an output section `.text`, `*` is a wildcard which matches any file name, here maps all `.text.kern_entry`, `.text`, `.stub`, `.text.*`, `.gnu.linkonce.t.*` input sections in all input files to be placed into `.text` output section at __BASE_ADDRESS__, where `.text.*` and `.gnu.linkonce.t.*` refer to all sections beginning with `.text.` and `.gnu.linkonce.t.` in input files, also the location counter will self-increase when executing this command.
* `PROVIDE(etext = .);`: If the program defines `etext`, the linker will silently use the definition in the program. If the program references `etext` but does not define it, the linker will use the definition set as the current location counter.
* `.rodata : {*(.rodata .rodata.* .gnu.linkonce.r.*)}`: The same as above, defines an output section `.rodata` and maps all `.rodata`, `.rodata.*`, `.gnu.linkonce.r.*` input sections in all input files to be placed into `.rodata` output section at address __immediately after the `.text` output section__ in memory with a __correct alignment__.
* `. = ALIGN(0x1000);`: Insert padding bytes until current location counter becomes aligned on `0x1000-byte` boundary.
* `.data : {*(.data)*(.data.*)}`: The same as above, defines an output section `.data` and maps all `.data`, `.data.*` input sections in all input files to be placed into `.data` output section at address __specified by the location counter__.

* `.sdata : {*(.sdata)*(.sdata.*)}`: The same as above, defines an output section `.sdata` and maps all `.data`, `.sdata.*` input sections in all input files to be placed into `.sdata` output section at address __specified by the location counter__.
* `PROVIDE(edata = .);`: If the program defines `edata`, the linker will silently use the definition in the program. If the program references `edata` but does not define it, the linker will use the definition set as the current location counter.
* `bss : {*(.bss)*(.bss.*)*(.sbss*)}`: The same as above, defines an output section `.bss` and maps all `.bss`, `.bss.*` and `.sbss*` input sections in all input files to be placed into `.bss` output section at address __specified by the location counter__.
* `PROVIDE(end = .);`: If the program defines `end`, the linker will silently use the definition in the program. If the program references `end` but does not define it, the linker will use the definition set as the current location counter.
* `/DISCARD/ : {*(.eh_frame .note.GNU-stack)}`: Drop the sections `.eh_frame` and `.note.GNU-stack` in all input files and thus they will not be contained in the output files.

## 3) Explain the function of `memset(edata, 0, end - edata); ` and parameters

In `kernel.ld`, we have defined `edata` and `end` to be two memory locations. The output `bss` section is in this segment of memory. So this function is to set `end - edata` bytes (the `bss` section) to __0__ starting from the memory location pointed by `edata`.

## 4) Describe how to call `ecall` instruction step by step after the kernel boot up
* When the kernel boot up, the first instruction to execute is set to `kern_entry` in `kernel.ld`.

* Then in `entry.S`, the function `kern_init` in `init.c` is invoked in `kern_entry`.
* In function `kern_init`, `cputs` function is invoked.
* Then in `stdio.c`, `cputs` invokes `cputch` which further invokes `cons_putc` in `console.c`.
* In `console.c`, `cons_putc` invokes `sbi_console_putchar` in `sbi.c`.
* Finally, in `sbi.c`, `sbi_console_putchar` invokes `sbi_call` where `ecall` is called.

## 5) Refer to `ecall`, Implement `shutdown()` to shutdown the system.
* Modified codes:

![Screenshot from 2022-03-07 11-26-56](/home/lrj11911808/Pictures/Screenshot from 2022-03-07 11-26-56.png)

![Screenshot from 2022-03-07 11-27-10](/home/lrj11911808/Pictures/Screenshot from 2022-03-07 11-27-10.png)

![Screenshot from 2022-03-07 11-27-23](/home/lrj11911808/Pictures/Screenshot from 2022-03-07 11-27-23.png)

![Screenshot from 2022-03-07 11-27-33](/home/lrj11911808/Pictures/Screenshot from 2022-03-07 11-27-33.png)

* Result:

![Screenshot from 2022-03-07 11-26-32](/home/lrj11911808/Pictures/Screenshot from 2022-03-07 11-26-32.png)