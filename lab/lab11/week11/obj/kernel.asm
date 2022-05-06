
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:

    .section .text,"ax",%progbits
    .globl kern_entry
kern_entry:
    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200000:	c02092b7          	lui	t0,0xc0209
    # t1 := 0xffffffff40000000 即虚实映射偏移量
    li      t1, 0xffffffffc0000000 - 0x80000000
ffffffffc0200004:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200008:	037a                	slli	t1,t1,0x1e
    # t0 减去虚实映射偏移量 0xffffffff40000000，变为三级页表的物理地址
    sub     t0, t0, t1
ffffffffc020000a:	406282b3          	sub	t0,t0,t1
    # t0 >>= 12，变为三级页表的物理页号
    srli    t0, t0, 12
ffffffffc020000e:	00c2d293          	srli	t0,t0,0xc

    # t1 := 8 << 60，设置 satp 的 MODE 字段为 Sv39
    li      t1, 8 << 60
ffffffffc0200012:	fff0031b          	addiw	t1,zero,-1
ffffffffc0200016:	137e                	slli	t1,t1,0x3f
    # 将刚才计算出的预设三级页表物理页号附加到 satp 中
    or      t0, t0, t1
ffffffffc0200018:	0062e2b3          	or	t0,t0,t1
    # 将算出的 t0(即新的MODE|页表基址物理页号) 覆盖到 satp 中
    csrw    satp, t0
ffffffffc020001c:	18029073          	csrw	satp,t0
    # 使用 sfence.vma 指令刷新 TLB
    sfence.vma
ffffffffc0200020:	12000073          	sfence.vma
    # 从此，我们给内核搭建出了一个完美的虚拟内存空间！
    #nop # 可能映射的位置有些bug。。插入一个nop
    
    # 我们在虚拟内存空间中：随意将 sp 设置为虚拟地址！
    lui sp, %hi(bootstacktop)
ffffffffc0200024:	c0209137          	lui	sp,0xc0209

    # 我们在虚拟内存空间中：随意跳转到虚拟地址！
    # 跳转到 kern_init
    lui t0, %hi(kern_init)
ffffffffc0200028:	c02002b7          	lui	t0,0xc0200
    addi t0, t0, %lo(kern_init)
ffffffffc020002c:	03228293          	addi	t0,t0,50 # ffffffffc0200032 <kern_init>
    jr t0
ffffffffc0200030:	8282                	jr	t0

ffffffffc0200032 <kern_init>:

int kern_init(void) __attribute__((noreturn));
int
kern_init(void) {
    extern char edata[], end[];
    memset(edata, 0, end - edata);
ffffffffc0200032:	00029517          	auipc	a0,0x29
ffffffffc0200036:	84650513          	addi	a0,a0,-1978 # ffffffffc0228878 <buf>
ffffffffc020003a:	00034617          	auipc	a2,0x34
ffffffffc020003e:	e0660613          	addi	a2,a2,-506 # ffffffffc0233e40 <end>
kern_init(void) {
ffffffffc0200042:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc0200044:	8e09                	sub	a2,a2,a0
ffffffffc0200046:	4581                	li	a1,0
kern_init(void) {
ffffffffc0200048:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc020004a:	00b040ef          	jal	ra,ffffffffc0204854 <memset>
    cons_init();                // init the console
ffffffffc020004e:	56c000ef          	jal	ra,ffffffffc02005ba <cons_init>

    const char *message = "OS is loading ...";
    cprintf("%s\n\n", message);
ffffffffc0200052:	00005597          	auipc	a1,0x5
ffffffffc0200056:	c3658593          	addi	a1,a1,-970 # ffffffffc0204c88 <etext+0x6>
ffffffffc020005a:	00005517          	auipc	a0,0x5
ffffffffc020005e:	c4650513          	addi	a0,a0,-954 # ffffffffc0204ca0 <etext+0x1e>
ffffffffc0200062:	066000ef          	jal	ra,ffffffffc02000c8 <cprintf>

    pmm_init();                 // init physical memory management
ffffffffc0200066:	5fd000ef          	jal	ra,ffffffffc0200e62 <pmm_init>

    idt_init();                 // init interrupt descriptor table
ffffffffc020006a:	5ce000ef          	jal	ra,ffffffffc0200638 <idt_init>

    vmm_init();                 // init virtual memory management
ffffffffc020006e:	23f010ef          	jal	ra,ffffffffc0201aac <vmm_init>
    sched_init();
ffffffffc0200072:	40a040ef          	jal	ra,ffffffffc020447c <sched_init>
    proc_init();                // init process table
ffffffffc0200076:	28c040ef          	jal	ra,ffffffffc0204302 <proc_init>
    
    ide_init();                 // init ide devices
ffffffffc020007a:	4a2000ef          	jal	ra,ffffffffc020051c <ide_init>
    swap_init();                // init swap
ffffffffc020007e:	3c7010ef          	jal	ra,ffffffffc0201c44 <swap_init>

    clock_init();               // init clock interrupt
ffffffffc0200082:	4f0000ef          	jal	ra,ffffffffc0200572 <clock_init>
    intr_enable();              // enable irq interrupt
ffffffffc0200086:	5a6000ef          	jal	ra,ffffffffc020062c <intr_enable>
    
    cpu_idle();                 // run idle process
ffffffffc020008a:	3ae040ef          	jal	ra,ffffffffc0204438 <cpu_idle>

ffffffffc020008e <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
ffffffffc020008e:	1141                	addi	sp,sp,-16
ffffffffc0200090:	e022                	sd	s0,0(sp)
ffffffffc0200092:	e406                	sd	ra,8(sp)
ffffffffc0200094:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc0200096:	526000ef          	jal	ra,ffffffffc02005bc <cons_putc>
    (*cnt) ++;
ffffffffc020009a:	401c                	lw	a5,0(s0)
}
ffffffffc020009c:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
ffffffffc020009e:	2785                	addiw	a5,a5,1
ffffffffc02000a0:	c01c                	sw	a5,0(s0)
}
ffffffffc02000a2:	6402                	ld	s0,0(sp)
ffffffffc02000a4:	0141                	addi	sp,sp,16
ffffffffc02000a6:	8082                	ret

ffffffffc02000a8 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000a8:	1101                	addi	sp,sp,-32
ffffffffc02000aa:	862a                	mv	a2,a0
ffffffffc02000ac:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000ae:	00000517          	auipc	a0,0x0
ffffffffc02000b2:	fe050513          	addi	a0,a0,-32 # ffffffffc020008e <cputch>
ffffffffc02000b6:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000b8:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc02000ba:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000bc:	02f040ef          	jal	ra,ffffffffc02048ea <vprintfmt>
    return cnt;
}
ffffffffc02000c0:	60e2                	ld	ra,24(sp)
ffffffffc02000c2:	4532                	lw	a0,12(sp)
ffffffffc02000c4:	6105                	addi	sp,sp,32
ffffffffc02000c6:	8082                	ret

ffffffffc02000c8 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
ffffffffc02000c8:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc02000ca:	02810313          	addi	t1,sp,40 # ffffffffc0209028 <boot_page_table_sv39+0x28>
cprintf(const char *fmt, ...) {
ffffffffc02000ce:	8e2a                	mv	t3,a0
ffffffffc02000d0:	f42e                	sd	a1,40(sp)
ffffffffc02000d2:	f832                	sd	a2,48(sp)
ffffffffc02000d4:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000d6:	00000517          	auipc	a0,0x0
ffffffffc02000da:	fb850513          	addi	a0,a0,-72 # ffffffffc020008e <cputch>
ffffffffc02000de:	004c                	addi	a1,sp,4
ffffffffc02000e0:	869a                	mv	a3,t1
ffffffffc02000e2:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
ffffffffc02000e4:	ec06                	sd	ra,24(sp)
ffffffffc02000e6:	e0ba                	sd	a4,64(sp)
ffffffffc02000e8:	e4be                	sd	a5,72(sp)
ffffffffc02000ea:	e8c2                	sd	a6,80(sp)
ffffffffc02000ec:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc02000ee:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc02000f0:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000f2:	7f8040ef          	jal	ra,ffffffffc02048ea <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc02000f6:	60e2                	ld	ra,24(sp)
ffffffffc02000f8:	4512                	lw	a0,4(sp)
ffffffffc02000fa:	6125                	addi	sp,sp,96
ffffffffc02000fc:	8082                	ret

ffffffffc02000fe <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
    cons_putc(c);
ffffffffc02000fe:	a97d                	j	ffffffffc02005bc <cons_putc>

ffffffffc0200100 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
ffffffffc0200100:	1101                	addi	sp,sp,-32
ffffffffc0200102:	e822                	sd	s0,16(sp)
ffffffffc0200104:	ec06                	sd	ra,24(sp)
ffffffffc0200106:	e426                	sd	s1,8(sp)
ffffffffc0200108:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
ffffffffc020010a:	00054503          	lbu	a0,0(a0)
ffffffffc020010e:	c51d                	beqz	a0,ffffffffc020013c <cputs+0x3c>
ffffffffc0200110:	0405                	addi	s0,s0,1
ffffffffc0200112:	4485                	li	s1,1
ffffffffc0200114:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc0200116:	4a6000ef          	jal	ra,ffffffffc02005bc <cons_putc>
    while ((c = *str ++) != '\0') {
ffffffffc020011a:	00044503          	lbu	a0,0(s0)
ffffffffc020011e:	008487bb          	addw	a5,s1,s0
ffffffffc0200122:	0405                	addi	s0,s0,1
ffffffffc0200124:	f96d                	bnez	a0,ffffffffc0200116 <cputs+0x16>
ffffffffc0200126:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc020012a:	4529                	li	a0,10
ffffffffc020012c:	490000ef          	jal	ra,ffffffffc02005bc <cons_putc>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc0200130:	60e2                	ld	ra,24(sp)
ffffffffc0200132:	8522                	mv	a0,s0
ffffffffc0200134:	6442                	ld	s0,16(sp)
ffffffffc0200136:	64a2                	ld	s1,8(sp)
ffffffffc0200138:	6105                	addi	sp,sp,32
ffffffffc020013a:	8082                	ret
    while ((c = *str ++) != '\0') {
ffffffffc020013c:	4405                	li	s0,1
ffffffffc020013e:	b7f5                	j	ffffffffc020012a <cputs+0x2a>

ffffffffc0200140 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
ffffffffc0200140:	1141                	addi	sp,sp,-16
ffffffffc0200142:	e406                	sd	ra,8(sp)
    int c;
    while ((c = cons_getc()) == 0)
ffffffffc0200144:	4ac000ef          	jal	ra,ffffffffc02005f0 <cons_getc>
ffffffffc0200148:	dd75                	beqz	a0,ffffffffc0200144 <getchar+0x4>
        /* do nothing */;
    return c;
}
ffffffffc020014a:	60a2                	ld	ra,8(sp)
ffffffffc020014c:	0141                	addi	sp,sp,16
ffffffffc020014e:	8082                	ret

ffffffffc0200150 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
ffffffffc0200150:	715d                	addi	sp,sp,-80
ffffffffc0200152:	e486                	sd	ra,72(sp)
ffffffffc0200154:	e0a6                	sd	s1,64(sp)
ffffffffc0200156:	fc4a                	sd	s2,56(sp)
ffffffffc0200158:	f84e                	sd	s3,48(sp)
ffffffffc020015a:	f452                	sd	s4,40(sp)
ffffffffc020015c:	f056                	sd	s5,32(sp)
ffffffffc020015e:	ec5a                	sd	s6,24(sp)
ffffffffc0200160:	e85e                	sd	s7,16(sp)
    if (prompt != NULL) {
ffffffffc0200162:	c901                	beqz	a0,ffffffffc0200172 <readline+0x22>
ffffffffc0200164:	85aa                	mv	a1,a0
        cprintf("%s", prompt);
ffffffffc0200166:	00005517          	auipc	a0,0x5
ffffffffc020016a:	b4250513          	addi	a0,a0,-1214 # ffffffffc0204ca8 <etext+0x26>
ffffffffc020016e:	f5bff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
readline(const char *prompt) {
ffffffffc0200172:	4481                	li	s1,0
    while (1) {
        c = getchar();
        if (c < 0) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0200174:	497d                	li	s2,31
            cputchar(c);
            buf[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
ffffffffc0200176:	49a1                	li	s3,8
            cputchar(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
ffffffffc0200178:	4aa9                	li	s5,10
ffffffffc020017a:	4b35                	li	s6,13
            buf[i ++] = c;
ffffffffc020017c:	00028b97          	auipc	s7,0x28
ffffffffc0200180:	6fcb8b93          	addi	s7,s7,1788 # ffffffffc0228878 <buf>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0200184:	3fe00a13          	li	s4,1022
        c = getchar();
ffffffffc0200188:	fb9ff0ef          	jal	ra,ffffffffc0200140 <getchar>
        if (c < 0) {
ffffffffc020018c:	00054a63          	bltz	a0,ffffffffc02001a0 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0200190:	00a95a63          	bge	s2,a0,ffffffffc02001a4 <readline+0x54>
ffffffffc0200194:	029a5263          	bge	s4,s1,ffffffffc02001b8 <readline+0x68>
        c = getchar();
ffffffffc0200198:	fa9ff0ef          	jal	ra,ffffffffc0200140 <getchar>
        if (c < 0) {
ffffffffc020019c:	fe055ae3          	bgez	a0,ffffffffc0200190 <readline+0x40>
            return NULL;
ffffffffc02001a0:	4501                	li	a0,0
ffffffffc02001a2:	a091                	j	ffffffffc02001e6 <readline+0x96>
        else if (c == '\b' && i > 0) {
ffffffffc02001a4:	03351463          	bne	a0,s3,ffffffffc02001cc <readline+0x7c>
ffffffffc02001a8:	e8a9                	bnez	s1,ffffffffc02001fa <readline+0xaa>
        c = getchar();
ffffffffc02001aa:	f97ff0ef          	jal	ra,ffffffffc0200140 <getchar>
        if (c < 0) {
ffffffffc02001ae:	fe0549e3          	bltz	a0,ffffffffc02001a0 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02001b2:	fea959e3          	bge	s2,a0,ffffffffc02001a4 <readline+0x54>
ffffffffc02001b6:	4481                	li	s1,0
            cputchar(c);
ffffffffc02001b8:	e42a                	sd	a0,8(sp)
ffffffffc02001ba:	f45ff0ef          	jal	ra,ffffffffc02000fe <cputchar>
            buf[i ++] = c;
ffffffffc02001be:	6522                	ld	a0,8(sp)
ffffffffc02001c0:	009b87b3          	add	a5,s7,s1
ffffffffc02001c4:	2485                	addiw	s1,s1,1
ffffffffc02001c6:	00a78023          	sb	a0,0(a5)
ffffffffc02001ca:	bf7d                	j	ffffffffc0200188 <readline+0x38>
        else if (c == '\n' || c == '\r') {
ffffffffc02001cc:	01550463          	beq	a0,s5,ffffffffc02001d4 <readline+0x84>
ffffffffc02001d0:	fb651ce3          	bne	a0,s6,ffffffffc0200188 <readline+0x38>
            cputchar(c);
ffffffffc02001d4:	f2bff0ef          	jal	ra,ffffffffc02000fe <cputchar>
            buf[i] = '\0';
ffffffffc02001d8:	00028517          	auipc	a0,0x28
ffffffffc02001dc:	6a050513          	addi	a0,a0,1696 # ffffffffc0228878 <buf>
ffffffffc02001e0:	94aa                	add	s1,s1,a0
ffffffffc02001e2:	00048023          	sb	zero,0(s1)
            return buf;
        }
    }
}
ffffffffc02001e6:	60a6                	ld	ra,72(sp)
ffffffffc02001e8:	6486                	ld	s1,64(sp)
ffffffffc02001ea:	7962                	ld	s2,56(sp)
ffffffffc02001ec:	79c2                	ld	s3,48(sp)
ffffffffc02001ee:	7a22                	ld	s4,40(sp)
ffffffffc02001f0:	7a82                	ld	s5,32(sp)
ffffffffc02001f2:	6b62                	ld	s6,24(sp)
ffffffffc02001f4:	6bc2                	ld	s7,16(sp)
ffffffffc02001f6:	6161                	addi	sp,sp,80
ffffffffc02001f8:	8082                	ret
            cputchar(c);
ffffffffc02001fa:	4521                	li	a0,8
ffffffffc02001fc:	f03ff0ef          	jal	ra,ffffffffc02000fe <cputchar>
            i --;
ffffffffc0200200:	34fd                	addiw	s1,s1,-1
ffffffffc0200202:	b759                	j	ffffffffc0200188 <readline+0x38>

ffffffffc0200204 <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
    if (is_panic) {
ffffffffc0200204:	00034317          	auipc	t1,0x34
ffffffffc0200208:	aa430313          	addi	t1,t1,-1372 # ffffffffc0233ca8 <is_panic>
ffffffffc020020c:	00033e03          	ld	t3,0(t1)
__panic(const char *file, int line, const char *fmt, ...) {
ffffffffc0200210:	715d                	addi	sp,sp,-80
ffffffffc0200212:	ec06                	sd	ra,24(sp)
ffffffffc0200214:	e822                	sd	s0,16(sp)
ffffffffc0200216:	f436                	sd	a3,40(sp)
ffffffffc0200218:	f83a                	sd	a4,48(sp)
ffffffffc020021a:	fc3e                	sd	a5,56(sp)
ffffffffc020021c:	e0c2                	sd	a6,64(sp)
ffffffffc020021e:	e4c6                	sd	a7,72(sp)
    if (is_panic) {
ffffffffc0200220:	020e1a63          	bnez	t3,ffffffffc0200254 <__panic+0x50>
        goto panic_dead;
    }
    is_panic = 1;
ffffffffc0200224:	4785                	li	a5,1
ffffffffc0200226:	00f33023          	sd	a5,0(t1)

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
ffffffffc020022a:	8432                	mv	s0,a2
ffffffffc020022c:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc020022e:	862e                	mv	a2,a1
ffffffffc0200230:	85aa                	mv	a1,a0
ffffffffc0200232:	00005517          	auipc	a0,0x5
ffffffffc0200236:	a7e50513          	addi	a0,a0,-1410 # ffffffffc0204cb0 <etext+0x2e>
    va_start(ap, fmt);
ffffffffc020023a:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc020023c:	e8dff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    vcprintf(fmt, ap);
ffffffffc0200240:	65a2                	ld	a1,8(sp)
ffffffffc0200242:	8522                	mv	a0,s0
ffffffffc0200244:	e65ff0ef          	jal	ra,ffffffffc02000a8 <vcprintf>
    cprintf("\n");
ffffffffc0200248:	00006517          	auipc	a0,0x6
ffffffffc020024c:	f1050513          	addi	a0,a0,-240 # ffffffffc0206158 <default_pmm_manager+0xe8>
ffffffffc0200250:	e79ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
#endif
}

static inline void sbi_shutdown(void)
{
	SBI_CALL_0(SBI_SHUTDOWN);
ffffffffc0200254:	4501                	li	a0,0
ffffffffc0200256:	4581                	li	a1,0
ffffffffc0200258:	4601                	li	a2,0
ffffffffc020025a:	48a1                	li	a7,8
ffffffffc020025c:	00000073          	ecall
    va_end(ap);

panic_dead:
    // No debug monitor here
    sbi_shutdown();
    intr_disable();
ffffffffc0200260:	3d2000ef          	jal	ra,ffffffffc0200632 <intr_disable>
    while (1) {
        kmonitor(NULL);
ffffffffc0200264:	4501                	li	a0,0
ffffffffc0200266:	174000ef          	jal	ra,ffffffffc02003da <kmonitor>
    while (1) {
ffffffffc020026a:	bfed                	j	ffffffffc0200264 <__panic+0x60>

ffffffffc020026c <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc020026c:	715d                	addi	sp,sp,-80
ffffffffc020026e:	832e                	mv	t1,a1
ffffffffc0200270:	e822                	sd	s0,16(sp)
    va_list ap;
    va_start(ap, fmt);
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200272:	85aa                	mv	a1,a0
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc0200274:	8432                	mv	s0,a2
ffffffffc0200276:	fc3e                	sd	a5,56(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200278:	861a                	mv	a2,t1
    va_start(ap, fmt);
ffffffffc020027a:	103c                	addi	a5,sp,40
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc020027c:	00005517          	auipc	a0,0x5
ffffffffc0200280:	a5450513          	addi	a0,a0,-1452 # ffffffffc0204cd0 <etext+0x4e>
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc0200284:	ec06                	sd	ra,24(sp)
ffffffffc0200286:	f436                	sd	a3,40(sp)
ffffffffc0200288:	f83a                	sd	a4,48(sp)
ffffffffc020028a:	e0c2                	sd	a6,64(sp)
ffffffffc020028c:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc020028e:	e43e                	sd	a5,8(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200290:	e39ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    vcprintf(fmt, ap);
ffffffffc0200294:	65a2                	ld	a1,8(sp)
ffffffffc0200296:	8522                	mv	a0,s0
ffffffffc0200298:	e11ff0ef          	jal	ra,ffffffffc02000a8 <vcprintf>
    cprintf("\n");
ffffffffc020029c:	00006517          	auipc	a0,0x6
ffffffffc02002a0:	ebc50513          	addi	a0,a0,-324 # ffffffffc0206158 <default_pmm_manager+0xe8>
ffffffffc02002a4:	e25ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    va_end(ap);
}
ffffffffc02002a8:	60e2                	ld	ra,24(sp)
ffffffffc02002aa:	6442                	ld	s0,16(sp)
ffffffffc02002ac:	6161                	addi	sp,sp,80
ffffffffc02002ae:	8082                	ret

ffffffffc02002b0 <print_kerninfo>:
/* *
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void) {
ffffffffc02002b0:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
ffffffffc02002b2:	00005517          	auipc	a0,0x5
ffffffffc02002b6:	a3e50513          	addi	a0,a0,-1474 # ffffffffc0204cf0 <etext+0x6e>
void print_kerninfo(void) {
ffffffffc02002ba:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc02002bc:	e0dff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  entry  0x%08x (virtual)\n", kern_init);
ffffffffc02002c0:	00000597          	auipc	a1,0x0
ffffffffc02002c4:	d7258593          	addi	a1,a1,-654 # ffffffffc0200032 <kern_init>
ffffffffc02002c8:	00005517          	auipc	a0,0x5
ffffffffc02002cc:	a4850513          	addi	a0,a0,-1464 # ffffffffc0204d10 <etext+0x8e>
ffffffffc02002d0:	df9ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  etext  0x%08x (virtual)\n", etext);
ffffffffc02002d4:	00005597          	auipc	a1,0x5
ffffffffc02002d8:	9ae58593          	addi	a1,a1,-1618 # ffffffffc0204c82 <etext>
ffffffffc02002dc:	00005517          	auipc	a0,0x5
ffffffffc02002e0:	a5450513          	addi	a0,a0,-1452 # ffffffffc0204d30 <etext+0xae>
ffffffffc02002e4:	de5ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  edata  0x%08x (virtual)\n", edata);
ffffffffc02002e8:	00028597          	auipc	a1,0x28
ffffffffc02002ec:	59058593          	addi	a1,a1,1424 # ffffffffc0228878 <buf>
ffffffffc02002f0:	00005517          	auipc	a0,0x5
ffffffffc02002f4:	a6050513          	addi	a0,a0,-1440 # ffffffffc0204d50 <etext+0xce>
ffffffffc02002f8:	dd1ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  end    0x%08x (virtual)\n", end);
ffffffffc02002fc:	00034597          	auipc	a1,0x34
ffffffffc0200300:	b4458593          	addi	a1,a1,-1212 # ffffffffc0233e40 <end>
ffffffffc0200304:	00005517          	auipc	a0,0x5
ffffffffc0200308:	a6c50513          	addi	a0,a0,-1428 # ffffffffc0204d70 <etext+0xee>
ffffffffc020030c:	dbdff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
ffffffffc0200310:	00034597          	auipc	a1,0x34
ffffffffc0200314:	f2f58593          	addi	a1,a1,-209 # ffffffffc023423f <end+0x3ff>
ffffffffc0200318:	00000797          	auipc	a5,0x0
ffffffffc020031c:	d1a78793          	addi	a5,a5,-742 # ffffffffc0200032 <kern_init>
ffffffffc0200320:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200324:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc0200328:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc020032a:	3ff5f593          	andi	a1,a1,1023
ffffffffc020032e:	95be                	add	a1,a1,a5
ffffffffc0200330:	85a9                	srai	a1,a1,0xa
ffffffffc0200332:	00005517          	auipc	a0,0x5
ffffffffc0200336:	a5e50513          	addi	a0,a0,-1442 # ffffffffc0204d90 <etext+0x10e>
}
ffffffffc020033a:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc020033c:	b371                	j	ffffffffc02000c8 <cprintf>

ffffffffc020033e <print_stackframe>:
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before
 * jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the
 * boundary.
 * */
void print_stackframe(void) {
ffffffffc020033e:	1141                	addi	sp,sp,-16
     * and line number, etc.
     *    (3.5) popup a calling stackframe
     *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
     *                   the calling funciton's ebp = ss:[ebp]
     */
    panic("Not Implemented!");
ffffffffc0200340:	00005617          	auipc	a2,0x5
ffffffffc0200344:	a8060613          	addi	a2,a2,-1408 # ffffffffc0204dc0 <etext+0x13e>
ffffffffc0200348:	05b00593          	li	a1,91
ffffffffc020034c:	00005517          	auipc	a0,0x5
ffffffffc0200350:	a8c50513          	addi	a0,a0,-1396 # ffffffffc0204dd8 <etext+0x156>
void print_stackframe(void) {
ffffffffc0200354:	e406                	sd	ra,8(sp)
    panic("Not Implemented!");
ffffffffc0200356:	eafff0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020035a <mon_help>:
    }
}

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc020035a:	1141                	addi	sp,sp,-16
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc020035c:	00005617          	auipc	a2,0x5
ffffffffc0200360:	a9460613          	addi	a2,a2,-1388 # ffffffffc0204df0 <etext+0x16e>
ffffffffc0200364:	00005597          	auipc	a1,0x5
ffffffffc0200368:	aac58593          	addi	a1,a1,-1364 # ffffffffc0204e10 <etext+0x18e>
ffffffffc020036c:	00005517          	auipc	a0,0x5
ffffffffc0200370:	aac50513          	addi	a0,a0,-1364 # ffffffffc0204e18 <etext+0x196>
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc0200374:	e406                	sd	ra,8(sp)
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc0200376:	d53ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
ffffffffc020037a:	00005617          	auipc	a2,0x5
ffffffffc020037e:	aae60613          	addi	a2,a2,-1362 # ffffffffc0204e28 <etext+0x1a6>
ffffffffc0200382:	00005597          	auipc	a1,0x5
ffffffffc0200386:	ace58593          	addi	a1,a1,-1330 # ffffffffc0204e50 <etext+0x1ce>
ffffffffc020038a:	00005517          	auipc	a0,0x5
ffffffffc020038e:	a8e50513          	addi	a0,a0,-1394 # ffffffffc0204e18 <etext+0x196>
ffffffffc0200392:	d37ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
ffffffffc0200396:	00005617          	auipc	a2,0x5
ffffffffc020039a:	aca60613          	addi	a2,a2,-1334 # ffffffffc0204e60 <etext+0x1de>
ffffffffc020039e:	00005597          	auipc	a1,0x5
ffffffffc02003a2:	ae258593          	addi	a1,a1,-1310 # ffffffffc0204e80 <etext+0x1fe>
ffffffffc02003a6:	00005517          	auipc	a0,0x5
ffffffffc02003aa:	a7250513          	addi	a0,a0,-1422 # ffffffffc0204e18 <etext+0x196>
ffffffffc02003ae:	d1bff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    }
    return 0;
}
ffffffffc02003b2:	60a2                	ld	ra,8(sp)
ffffffffc02003b4:	4501                	li	a0,0
ffffffffc02003b6:	0141                	addi	sp,sp,16
ffffffffc02003b8:	8082                	ret

ffffffffc02003ba <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
ffffffffc02003ba:	1141                	addi	sp,sp,-16
ffffffffc02003bc:	e406                	sd	ra,8(sp)
    print_kerninfo();
ffffffffc02003be:	ef3ff0ef          	jal	ra,ffffffffc02002b0 <print_kerninfo>
    return 0;
}
ffffffffc02003c2:	60a2                	ld	ra,8(sp)
ffffffffc02003c4:	4501                	li	a0,0
ffffffffc02003c6:	0141                	addi	sp,sp,16
ffffffffc02003c8:	8082                	ret

ffffffffc02003ca <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
ffffffffc02003ca:	1141                	addi	sp,sp,-16
ffffffffc02003cc:	e406                	sd	ra,8(sp)
    print_stackframe();
ffffffffc02003ce:	f71ff0ef          	jal	ra,ffffffffc020033e <print_stackframe>
    return 0;
}
ffffffffc02003d2:	60a2                	ld	ra,8(sp)
ffffffffc02003d4:	4501                	li	a0,0
ffffffffc02003d6:	0141                	addi	sp,sp,16
ffffffffc02003d8:	8082                	ret

ffffffffc02003da <kmonitor>:
kmonitor(struct trapframe *tf) {
ffffffffc02003da:	7115                	addi	sp,sp,-224
ffffffffc02003dc:	e962                	sd	s8,144(sp)
ffffffffc02003de:	8c2a                	mv	s8,a0
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc02003e0:	00005517          	auipc	a0,0x5
ffffffffc02003e4:	ab050513          	addi	a0,a0,-1360 # ffffffffc0204e90 <etext+0x20e>
kmonitor(struct trapframe *tf) {
ffffffffc02003e8:	ed86                	sd	ra,216(sp)
ffffffffc02003ea:	e9a2                	sd	s0,208(sp)
ffffffffc02003ec:	e5a6                	sd	s1,200(sp)
ffffffffc02003ee:	e1ca                	sd	s2,192(sp)
ffffffffc02003f0:	fd4e                	sd	s3,184(sp)
ffffffffc02003f2:	f952                	sd	s4,176(sp)
ffffffffc02003f4:	f556                	sd	s5,168(sp)
ffffffffc02003f6:	f15a                	sd	s6,160(sp)
ffffffffc02003f8:	ed5e                	sd	s7,152(sp)
ffffffffc02003fa:	e566                	sd	s9,136(sp)
ffffffffc02003fc:	e16a                	sd	s10,128(sp)
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc02003fe:	ccbff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
ffffffffc0200402:	00005517          	auipc	a0,0x5
ffffffffc0200406:	ab650513          	addi	a0,a0,-1354 # ffffffffc0204eb8 <etext+0x236>
ffffffffc020040a:	cbfff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    if (tf != NULL) {
ffffffffc020040e:	000c0563          	beqz	s8,ffffffffc0200418 <kmonitor+0x3e>
        print_trapframe(tf);
ffffffffc0200412:	8562                	mv	a0,s8
ffffffffc0200414:	40c000ef          	jal	ra,ffffffffc0200820 <print_trapframe>
ffffffffc0200418:	00005c97          	auipc	s9,0x5
ffffffffc020041c:	b10c8c93          	addi	s9,s9,-1264 # ffffffffc0204f28 <commands>
        if ((buf = readline("K> ")) != NULL) {
ffffffffc0200420:	00005997          	auipc	s3,0x5
ffffffffc0200424:	ac098993          	addi	s3,s3,-1344 # ffffffffc0204ee0 <etext+0x25e>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200428:	00005917          	auipc	s2,0x5
ffffffffc020042c:	ac090913          	addi	s2,s2,-1344 # ffffffffc0204ee8 <etext+0x266>
        if (argc == MAXARGS - 1) {
ffffffffc0200430:	4a3d                	li	s4,15
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc0200432:	00005b17          	auipc	s6,0x5
ffffffffc0200436:	abeb0b13          	addi	s6,s6,-1346 # ffffffffc0204ef0 <etext+0x26e>
ffffffffc020043a:	00005a97          	auipc	s5,0x5
ffffffffc020043e:	9d6a8a93          	addi	s5,s5,-1578 # ffffffffc0204e10 <etext+0x18e>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200442:	4b8d                	li	s7,3
        if ((buf = readline("K> ")) != NULL) {
ffffffffc0200444:	854e                	mv	a0,s3
ffffffffc0200446:	d0bff0ef          	jal	ra,ffffffffc0200150 <readline>
ffffffffc020044a:	842a                	mv	s0,a0
ffffffffc020044c:	dd65                	beqz	a0,ffffffffc0200444 <kmonitor+0x6a>
ffffffffc020044e:	00054583          	lbu	a1,0(a0)
    int argc = 0;
ffffffffc0200452:	4481                	li	s1,0
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200454:	c999                	beqz	a1,ffffffffc020046a <kmonitor+0x90>
ffffffffc0200456:	854a                	mv	a0,s2
ffffffffc0200458:	3e6040ef          	jal	ra,ffffffffc020483e <strchr>
ffffffffc020045c:	c925                	beqz	a0,ffffffffc02004cc <kmonitor+0xf2>
            *buf ++ = '\0';
ffffffffc020045e:	00144583          	lbu	a1,1(s0)
ffffffffc0200462:	00040023          	sb	zero,0(s0)
ffffffffc0200466:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200468:	f5fd                	bnez	a1,ffffffffc0200456 <kmonitor+0x7c>
    if (argc == 0) {
ffffffffc020046a:	dce9                	beqz	s1,ffffffffc0200444 <kmonitor+0x6a>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc020046c:	6582                	ld	a1,0(sp)
ffffffffc020046e:	00005d17          	auipc	s10,0x5
ffffffffc0200472:	abad0d13          	addi	s10,s10,-1350 # ffffffffc0204f28 <commands>
ffffffffc0200476:	8556                	mv	a0,s5
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200478:	4401                	li	s0,0
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc020047a:	0d61                	addi	s10,s10,24
ffffffffc020047c:	3a4040ef          	jal	ra,ffffffffc0204820 <strcmp>
ffffffffc0200480:	c919                	beqz	a0,ffffffffc0200496 <kmonitor+0xbc>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200482:	2405                	addiw	s0,s0,1
ffffffffc0200484:	09740463          	beq	s0,s7,ffffffffc020050c <kmonitor+0x132>
ffffffffc0200488:	000d3503          	ld	a0,0(s10)
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc020048c:	6582                	ld	a1,0(sp)
ffffffffc020048e:	0d61                	addi	s10,s10,24
ffffffffc0200490:	390040ef          	jal	ra,ffffffffc0204820 <strcmp>
ffffffffc0200494:	f57d                	bnez	a0,ffffffffc0200482 <kmonitor+0xa8>
            return commands[i].func(argc - 1, argv + 1, tf);
ffffffffc0200496:	00141793          	slli	a5,s0,0x1
ffffffffc020049a:	97a2                	add	a5,a5,s0
ffffffffc020049c:	078e                	slli	a5,a5,0x3
ffffffffc020049e:	97e6                	add	a5,a5,s9
ffffffffc02004a0:	6b9c                	ld	a5,16(a5)
ffffffffc02004a2:	8662                	mv	a2,s8
ffffffffc02004a4:	002c                	addi	a1,sp,8
ffffffffc02004a6:	fff4851b          	addiw	a0,s1,-1
ffffffffc02004aa:	9782                	jalr	a5
            if (runcmd(buf, tf) < 0) {
ffffffffc02004ac:	f8055ce3          	bgez	a0,ffffffffc0200444 <kmonitor+0x6a>
}
ffffffffc02004b0:	60ee                	ld	ra,216(sp)
ffffffffc02004b2:	644e                	ld	s0,208(sp)
ffffffffc02004b4:	64ae                	ld	s1,200(sp)
ffffffffc02004b6:	690e                	ld	s2,192(sp)
ffffffffc02004b8:	79ea                	ld	s3,184(sp)
ffffffffc02004ba:	7a4a                	ld	s4,176(sp)
ffffffffc02004bc:	7aaa                	ld	s5,168(sp)
ffffffffc02004be:	7b0a                	ld	s6,160(sp)
ffffffffc02004c0:	6bea                	ld	s7,152(sp)
ffffffffc02004c2:	6c4a                	ld	s8,144(sp)
ffffffffc02004c4:	6caa                	ld	s9,136(sp)
ffffffffc02004c6:	6d0a                	ld	s10,128(sp)
ffffffffc02004c8:	612d                	addi	sp,sp,224
ffffffffc02004ca:	8082                	ret
        if (*buf == '\0') {
ffffffffc02004cc:	00044783          	lbu	a5,0(s0)
ffffffffc02004d0:	dfc9                	beqz	a5,ffffffffc020046a <kmonitor+0x90>
        if (argc == MAXARGS - 1) {
ffffffffc02004d2:	03448863          	beq	s1,s4,ffffffffc0200502 <kmonitor+0x128>
        argv[argc ++] = buf;
ffffffffc02004d6:	00349793          	slli	a5,s1,0x3
ffffffffc02004da:	0118                	addi	a4,sp,128
ffffffffc02004dc:	97ba                	add	a5,a5,a4
ffffffffc02004de:	f887b023          	sd	s0,-128(a5)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02004e2:	00044583          	lbu	a1,0(s0)
        argv[argc ++] = buf;
ffffffffc02004e6:	2485                	addiw	s1,s1,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02004e8:	e591                	bnez	a1,ffffffffc02004f4 <kmonitor+0x11a>
ffffffffc02004ea:	b749                	j	ffffffffc020046c <kmonitor+0x92>
ffffffffc02004ec:	00144583          	lbu	a1,1(s0)
            buf ++;
ffffffffc02004f0:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02004f2:	ddad                	beqz	a1,ffffffffc020046c <kmonitor+0x92>
ffffffffc02004f4:	854a                	mv	a0,s2
ffffffffc02004f6:	348040ef          	jal	ra,ffffffffc020483e <strchr>
ffffffffc02004fa:	d96d                	beqz	a0,ffffffffc02004ec <kmonitor+0x112>
ffffffffc02004fc:	00044583          	lbu	a1,0(s0)
ffffffffc0200500:	bf91                	j	ffffffffc0200454 <kmonitor+0x7a>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc0200502:	45c1                	li	a1,16
ffffffffc0200504:	855a                	mv	a0,s6
ffffffffc0200506:	bc3ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
ffffffffc020050a:	b7f1                	j	ffffffffc02004d6 <kmonitor+0xfc>
    cprintf("Unknown command '%s'\n", argv[0]);
ffffffffc020050c:	6582                	ld	a1,0(sp)
ffffffffc020050e:	00005517          	auipc	a0,0x5
ffffffffc0200512:	a0250513          	addi	a0,a0,-1534 # ffffffffc0204f10 <etext+0x28e>
ffffffffc0200516:	bb3ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    return 0;
ffffffffc020051a:	b72d                	j	ffffffffc0200444 <kmonitor+0x6a>

ffffffffc020051c <ide_init>:
#include <stdio.h>
#include <string.h>
#include <trap.h>
#include <riscv.h>

void ide_init(void) {}
ffffffffc020051c:	8082                	ret

ffffffffc020051e <ide_device_valid>:

#define MAX_IDE 2
#define MAX_DISK_NSECS 56
static char ide[MAX_DISK_NSECS * SECTSIZE];

bool ide_device_valid(unsigned short ideno) { return ideno < MAX_IDE; }
ffffffffc020051e:	00253513          	sltiu	a0,a0,2
ffffffffc0200522:	8082                	ret

ffffffffc0200524 <ide_device_size>:

size_t ide_device_size(unsigned short ideno) { return MAX_DISK_NSECS; }
ffffffffc0200524:	03800513          	li	a0,56
ffffffffc0200528:	8082                	ret

ffffffffc020052a <ide_read_secs>:

int ide_read_secs(unsigned short ideno, uint32_t secno, void *dst,
                  size_t nsecs) {
    int iobase = secno * SECTSIZE;
    memcpy(dst, &ide[iobase], nsecs * SECTSIZE);
ffffffffc020052a:	00028797          	auipc	a5,0x28
ffffffffc020052e:	74e78793          	addi	a5,a5,1870 # ffffffffc0228c78 <ide>
    int iobase = secno * SECTSIZE;
ffffffffc0200532:	0095959b          	slliw	a1,a1,0x9
                  size_t nsecs) {
ffffffffc0200536:	1141                	addi	sp,sp,-16
ffffffffc0200538:	8532                	mv	a0,a2
    memcpy(dst, &ide[iobase], nsecs * SECTSIZE);
ffffffffc020053a:	95be                	add	a1,a1,a5
ffffffffc020053c:	00969613          	slli	a2,a3,0x9
                  size_t nsecs) {
ffffffffc0200540:	e406                	sd	ra,8(sp)
    memcpy(dst, &ide[iobase], nsecs * SECTSIZE);
ffffffffc0200542:	324040ef          	jal	ra,ffffffffc0204866 <memcpy>
    return 0;
}
ffffffffc0200546:	60a2                	ld	ra,8(sp)
ffffffffc0200548:	4501                	li	a0,0
ffffffffc020054a:	0141                	addi	sp,sp,16
ffffffffc020054c:	8082                	ret

ffffffffc020054e <ide_write_secs>:

int ide_write_secs(unsigned short ideno, uint32_t secno, const void *src,
                   size_t nsecs) {
    int iobase = secno * SECTSIZE;
ffffffffc020054e:	0095979b          	slliw	a5,a1,0x9
    memcpy(&ide[iobase], src, nsecs * SECTSIZE);
ffffffffc0200552:	00028517          	auipc	a0,0x28
ffffffffc0200556:	72650513          	addi	a0,a0,1830 # ffffffffc0228c78 <ide>
                   size_t nsecs) {
ffffffffc020055a:	1141                	addi	sp,sp,-16
ffffffffc020055c:	85b2                	mv	a1,a2
    memcpy(&ide[iobase], src, nsecs * SECTSIZE);
ffffffffc020055e:	953e                	add	a0,a0,a5
ffffffffc0200560:	00969613          	slli	a2,a3,0x9
                   size_t nsecs) {
ffffffffc0200564:	e406                	sd	ra,8(sp)
    memcpy(&ide[iobase], src, nsecs * SECTSIZE);
ffffffffc0200566:	300040ef          	jal	ra,ffffffffc0204866 <memcpy>
    return 0;
}
ffffffffc020056a:	60a2                	ld	ra,8(sp)
ffffffffc020056c:	4501                	li	a0,0
ffffffffc020056e:	0141                	addi	sp,sp,16
ffffffffc0200570:	8082                	ret

ffffffffc0200572 <clock_init>:

static uint64_t timebase = 100000;


void clock_init(void) {
    set_csr(sie, MIP_STIP);
ffffffffc0200572:	02000793          	li	a5,32
ffffffffc0200576:	1047a7f3          	csrrs	a5,sie,a5
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc020057a:	c0102573          	rdtime	a0
    ticks = 0;

    cprintf("setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc020057e:	67e1                	lui	a5,0x18
ffffffffc0200580:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_obj___user_rr_out_size+0xdc90>
ffffffffc0200584:	953e                	add	a0,a0,a5
	SBI_CALL_1(SBI_SET_TIMER, stime_value);
ffffffffc0200586:	4581                	li	a1,0
ffffffffc0200588:	4601                	li	a2,0
ffffffffc020058a:	4881                	li	a7,0
ffffffffc020058c:	00000073          	ecall
    cprintf("setup timer interrupts\n");
ffffffffc0200590:	00005517          	auipc	a0,0x5
ffffffffc0200594:	9e050513          	addi	a0,a0,-1568 # ffffffffc0204f70 <commands+0x48>
    ticks = 0;
ffffffffc0200598:	00033797          	auipc	a5,0x33
ffffffffc020059c:	7607bc23          	sd	zero,1912(a5) # ffffffffc0233d10 <ticks>
    cprintf("setup timer interrupts\n");
ffffffffc02005a0:	b625                	j	ffffffffc02000c8 <cprintf>

ffffffffc02005a2 <clock_set_next_event>:
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc02005a2:	c0102573          	rdtime	a0
void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc02005a6:	67e1                	lui	a5,0x18
ffffffffc02005a8:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_obj___user_rr_out_size+0xdc90>
ffffffffc02005ac:	953e                	add	a0,a0,a5
ffffffffc02005ae:	4581                	li	a1,0
ffffffffc02005b0:	4601                	li	a2,0
ffffffffc02005b2:	4881                	li	a7,0
ffffffffc02005b4:	00000073          	ecall
ffffffffc02005b8:	8082                	ret

ffffffffc02005ba <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc02005ba:	8082                	ret

ffffffffc02005bc <cons_putc>:
#include <riscv.h>
#include <assert.h>
#include <atomic.h>

static inline bool __intr_save(void) {
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02005bc:	100027f3          	csrr	a5,sstatus
ffffffffc02005c0:	8b89                	andi	a5,a5,2
ffffffffc02005c2:	0ff57513          	andi	a0,a0,255
ffffffffc02005c6:	e799                	bnez	a5,ffffffffc02005d4 <cons_putc+0x18>
	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
ffffffffc02005c8:	4581                	li	a1,0
ffffffffc02005ca:	4601                	li	a2,0
ffffffffc02005cc:	4885                	li	a7,1
ffffffffc02005ce:	00000073          	ecall
    }
    return 0;
}

static inline void __intr_restore(bool flag) {
    if (flag) {
ffffffffc02005d2:	8082                	ret

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) {
ffffffffc02005d4:	1101                	addi	sp,sp,-32
ffffffffc02005d6:	ec06                	sd	ra,24(sp)
ffffffffc02005d8:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02005da:	058000ef          	jal	ra,ffffffffc0200632 <intr_disable>
ffffffffc02005de:	6522                	ld	a0,8(sp)
ffffffffc02005e0:	4581                	li	a1,0
ffffffffc02005e2:	4601                	li	a2,0
ffffffffc02005e4:	4885                	li	a7,1
ffffffffc02005e6:	00000073          	ecall
    local_intr_save(intr_flag);
    {
        sbi_console_putchar((unsigned char)c);
    }
    local_intr_restore(intr_flag);
}
ffffffffc02005ea:	60e2                	ld	ra,24(sp)
ffffffffc02005ec:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc02005ee:	a83d                	j	ffffffffc020062c <intr_enable>

ffffffffc02005f0 <cons_getc>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02005f0:	100027f3          	csrr	a5,sstatus
ffffffffc02005f4:	8b89                	andi	a5,a5,2
ffffffffc02005f6:	eb89                	bnez	a5,ffffffffc0200608 <cons_getc+0x18>
	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
ffffffffc02005f8:	4501                	li	a0,0
ffffffffc02005fa:	4581                	li	a1,0
ffffffffc02005fc:	4601                	li	a2,0
ffffffffc02005fe:	4889                	li	a7,2
ffffffffc0200600:	00000073          	ecall
ffffffffc0200604:	2501                	sext.w	a0,a0
    {
        c = sbi_console_getchar();
    }
    local_intr_restore(intr_flag);
    return c;
}
ffffffffc0200606:	8082                	ret
int cons_getc(void) {
ffffffffc0200608:	1101                	addi	sp,sp,-32
ffffffffc020060a:	ec06                	sd	ra,24(sp)
        intr_disable();
ffffffffc020060c:	026000ef          	jal	ra,ffffffffc0200632 <intr_disable>
ffffffffc0200610:	4501                	li	a0,0
ffffffffc0200612:	4581                	li	a1,0
ffffffffc0200614:	4601                	li	a2,0
ffffffffc0200616:	4889                	li	a7,2
ffffffffc0200618:	00000073          	ecall
ffffffffc020061c:	2501                	sext.w	a0,a0
ffffffffc020061e:	e42a                	sd	a0,8(sp)
        intr_enable();
ffffffffc0200620:	00c000ef          	jal	ra,ffffffffc020062c <intr_enable>
}
ffffffffc0200624:	60e2                	ld	ra,24(sp)
ffffffffc0200626:	6522                	ld	a0,8(sp)
ffffffffc0200628:	6105                	addi	sp,sp,32
ffffffffc020062a:	8082                	ret

ffffffffc020062c <intr_enable>:
#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt */
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }
ffffffffc020062c:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc0200630:	8082                	ret

ffffffffc0200632 <intr_disable>:

/* intr_disable - disable irq interrupt */
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
ffffffffc0200632:	100177f3          	csrrci	a5,sstatus,2
ffffffffc0200636:	8082                	ret

ffffffffc0200638 <idt_init>:
void
idt_init(void) {
    extern void __alltraps(void);
    /* Set sscratch register to 0, indicating to exception vector that we are
     * presently executing in the kernel */
    write_csr(sscratch, 0);
ffffffffc0200638:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
ffffffffc020063c:	00000797          	auipc	a5,0x0
ffffffffc0200640:	62c78793          	addi	a5,a5,1580 # ffffffffc0200c68 <__alltraps>
ffffffffc0200644:	10579073          	csrw	stvec,a5
    /* Allow kernel to access user memory */
    set_csr(sstatus, SSTATUS_SUM);
ffffffffc0200648:	000407b7          	lui	a5,0x40
ffffffffc020064c:	1007a7f3          	csrrs	a5,sstatus,a5
}
ffffffffc0200650:	8082                	ret

ffffffffc0200652 <print_regs>:
    cprintf("  tval 0x%08x\n", tf->tval);
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs* gpr) {
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200652:	610c                	ld	a1,0(a0)
void print_regs(struct pushregs* gpr) {
ffffffffc0200654:	1141                	addi	sp,sp,-16
ffffffffc0200656:	e022                	sd	s0,0(sp)
ffffffffc0200658:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc020065a:	00005517          	auipc	a0,0x5
ffffffffc020065e:	92e50513          	addi	a0,a0,-1746 # ffffffffc0204f88 <commands+0x60>
void print_regs(struct pushregs* gpr) {
ffffffffc0200662:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200664:	a65ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
ffffffffc0200668:	640c                	ld	a1,8(s0)
ffffffffc020066a:	00005517          	auipc	a0,0x5
ffffffffc020066e:	93650513          	addi	a0,a0,-1738 # ffffffffc0204fa0 <commands+0x78>
ffffffffc0200672:	a57ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
ffffffffc0200676:	680c                	ld	a1,16(s0)
ffffffffc0200678:	00005517          	auipc	a0,0x5
ffffffffc020067c:	94050513          	addi	a0,a0,-1728 # ffffffffc0204fb8 <commands+0x90>
ffffffffc0200680:	a49ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
ffffffffc0200684:	6c0c                	ld	a1,24(s0)
ffffffffc0200686:	00005517          	auipc	a0,0x5
ffffffffc020068a:	94a50513          	addi	a0,a0,-1718 # ffffffffc0204fd0 <commands+0xa8>
ffffffffc020068e:	a3bff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
ffffffffc0200692:	700c                	ld	a1,32(s0)
ffffffffc0200694:	00005517          	auipc	a0,0x5
ffffffffc0200698:	95450513          	addi	a0,a0,-1708 # ffffffffc0204fe8 <commands+0xc0>
ffffffffc020069c:	a2dff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
ffffffffc02006a0:	740c                	ld	a1,40(s0)
ffffffffc02006a2:	00005517          	auipc	a0,0x5
ffffffffc02006a6:	95e50513          	addi	a0,a0,-1698 # ffffffffc0205000 <commands+0xd8>
ffffffffc02006aa:	a1fff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
ffffffffc02006ae:	780c                	ld	a1,48(s0)
ffffffffc02006b0:	00005517          	auipc	a0,0x5
ffffffffc02006b4:	96850513          	addi	a0,a0,-1688 # ffffffffc0205018 <commands+0xf0>
ffffffffc02006b8:	a11ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
ffffffffc02006bc:	7c0c                	ld	a1,56(s0)
ffffffffc02006be:	00005517          	auipc	a0,0x5
ffffffffc02006c2:	97250513          	addi	a0,a0,-1678 # ffffffffc0205030 <commands+0x108>
ffffffffc02006c6:	a03ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
ffffffffc02006ca:	602c                	ld	a1,64(s0)
ffffffffc02006cc:	00005517          	auipc	a0,0x5
ffffffffc02006d0:	97c50513          	addi	a0,a0,-1668 # ffffffffc0205048 <commands+0x120>
ffffffffc02006d4:	9f5ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
ffffffffc02006d8:	642c                	ld	a1,72(s0)
ffffffffc02006da:	00005517          	auipc	a0,0x5
ffffffffc02006de:	98650513          	addi	a0,a0,-1658 # ffffffffc0205060 <commands+0x138>
ffffffffc02006e2:	9e7ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
ffffffffc02006e6:	682c                	ld	a1,80(s0)
ffffffffc02006e8:	00005517          	auipc	a0,0x5
ffffffffc02006ec:	99050513          	addi	a0,a0,-1648 # ffffffffc0205078 <commands+0x150>
ffffffffc02006f0:	9d9ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
ffffffffc02006f4:	6c2c                	ld	a1,88(s0)
ffffffffc02006f6:	00005517          	auipc	a0,0x5
ffffffffc02006fa:	99a50513          	addi	a0,a0,-1638 # ffffffffc0205090 <commands+0x168>
ffffffffc02006fe:	9cbff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
ffffffffc0200702:	702c                	ld	a1,96(s0)
ffffffffc0200704:	00005517          	auipc	a0,0x5
ffffffffc0200708:	9a450513          	addi	a0,a0,-1628 # ffffffffc02050a8 <commands+0x180>
ffffffffc020070c:	9bdff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
ffffffffc0200710:	742c                	ld	a1,104(s0)
ffffffffc0200712:	00005517          	auipc	a0,0x5
ffffffffc0200716:	9ae50513          	addi	a0,a0,-1618 # ffffffffc02050c0 <commands+0x198>
ffffffffc020071a:	9afff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
ffffffffc020071e:	782c                	ld	a1,112(s0)
ffffffffc0200720:	00005517          	auipc	a0,0x5
ffffffffc0200724:	9b850513          	addi	a0,a0,-1608 # ffffffffc02050d8 <commands+0x1b0>
ffffffffc0200728:	9a1ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
ffffffffc020072c:	7c2c                	ld	a1,120(s0)
ffffffffc020072e:	00005517          	auipc	a0,0x5
ffffffffc0200732:	9c250513          	addi	a0,a0,-1598 # ffffffffc02050f0 <commands+0x1c8>
ffffffffc0200736:	993ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
ffffffffc020073a:	604c                	ld	a1,128(s0)
ffffffffc020073c:	00005517          	auipc	a0,0x5
ffffffffc0200740:	9cc50513          	addi	a0,a0,-1588 # ffffffffc0205108 <commands+0x1e0>
ffffffffc0200744:	985ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
ffffffffc0200748:	644c                	ld	a1,136(s0)
ffffffffc020074a:	00005517          	auipc	a0,0x5
ffffffffc020074e:	9d650513          	addi	a0,a0,-1578 # ffffffffc0205120 <commands+0x1f8>
ffffffffc0200752:	977ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
ffffffffc0200756:	684c                	ld	a1,144(s0)
ffffffffc0200758:	00005517          	auipc	a0,0x5
ffffffffc020075c:	9e050513          	addi	a0,a0,-1568 # ffffffffc0205138 <commands+0x210>
ffffffffc0200760:	969ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
ffffffffc0200764:	6c4c                	ld	a1,152(s0)
ffffffffc0200766:	00005517          	auipc	a0,0x5
ffffffffc020076a:	9ea50513          	addi	a0,a0,-1558 # ffffffffc0205150 <commands+0x228>
ffffffffc020076e:	95bff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
ffffffffc0200772:	704c                	ld	a1,160(s0)
ffffffffc0200774:	00005517          	auipc	a0,0x5
ffffffffc0200778:	9f450513          	addi	a0,a0,-1548 # ffffffffc0205168 <commands+0x240>
ffffffffc020077c:	94dff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
ffffffffc0200780:	744c                	ld	a1,168(s0)
ffffffffc0200782:	00005517          	auipc	a0,0x5
ffffffffc0200786:	9fe50513          	addi	a0,a0,-1538 # ffffffffc0205180 <commands+0x258>
ffffffffc020078a:	93fff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
ffffffffc020078e:	784c                	ld	a1,176(s0)
ffffffffc0200790:	00005517          	auipc	a0,0x5
ffffffffc0200794:	a0850513          	addi	a0,a0,-1528 # ffffffffc0205198 <commands+0x270>
ffffffffc0200798:	931ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
ffffffffc020079c:	7c4c                	ld	a1,184(s0)
ffffffffc020079e:	00005517          	auipc	a0,0x5
ffffffffc02007a2:	a1250513          	addi	a0,a0,-1518 # ffffffffc02051b0 <commands+0x288>
ffffffffc02007a6:	923ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
ffffffffc02007aa:	606c                	ld	a1,192(s0)
ffffffffc02007ac:	00005517          	auipc	a0,0x5
ffffffffc02007b0:	a1c50513          	addi	a0,a0,-1508 # ffffffffc02051c8 <commands+0x2a0>
ffffffffc02007b4:	915ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
ffffffffc02007b8:	646c                	ld	a1,200(s0)
ffffffffc02007ba:	00005517          	auipc	a0,0x5
ffffffffc02007be:	a2650513          	addi	a0,a0,-1498 # ffffffffc02051e0 <commands+0x2b8>
ffffffffc02007c2:	907ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
ffffffffc02007c6:	686c                	ld	a1,208(s0)
ffffffffc02007c8:	00005517          	auipc	a0,0x5
ffffffffc02007cc:	a3050513          	addi	a0,a0,-1488 # ffffffffc02051f8 <commands+0x2d0>
ffffffffc02007d0:	8f9ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
ffffffffc02007d4:	6c6c                	ld	a1,216(s0)
ffffffffc02007d6:	00005517          	auipc	a0,0x5
ffffffffc02007da:	a3a50513          	addi	a0,a0,-1478 # ffffffffc0205210 <commands+0x2e8>
ffffffffc02007de:	8ebff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
ffffffffc02007e2:	706c                	ld	a1,224(s0)
ffffffffc02007e4:	00005517          	auipc	a0,0x5
ffffffffc02007e8:	a4450513          	addi	a0,a0,-1468 # ffffffffc0205228 <commands+0x300>
ffffffffc02007ec:	8ddff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
ffffffffc02007f0:	746c                	ld	a1,232(s0)
ffffffffc02007f2:	00005517          	auipc	a0,0x5
ffffffffc02007f6:	a4e50513          	addi	a0,a0,-1458 # ffffffffc0205240 <commands+0x318>
ffffffffc02007fa:	8cfff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
ffffffffc02007fe:	786c                	ld	a1,240(s0)
ffffffffc0200800:	00005517          	auipc	a0,0x5
ffffffffc0200804:	a5850513          	addi	a0,a0,-1448 # ffffffffc0205258 <commands+0x330>
ffffffffc0200808:	8c1ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc020080c:	7c6c                	ld	a1,248(s0)
}
ffffffffc020080e:	6402                	ld	s0,0(sp)
ffffffffc0200810:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200812:	00005517          	auipc	a0,0x5
ffffffffc0200816:	a5e50513          	addi	a0,a0,-1442 # ffffffffc0205270 <commands+0x348>
}
ffffffffc020081a:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc020081c:	8adff06f          	j	ffffffffc02000c8 <cprintf>

ffffffffc0200820 <print_trapframe>:
print_trapframe(struct trapframe *tf) {
ffffffffc0200820:	1141                	addi	sp,sp,-16
ffffffffc0200822:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200824:	85aa                	mv	a1,a0
print_trapframe(struct trapframe *tf) {
ffffffffc0200826:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
ffffffffc0200828:	00005517          	auipc	a0,0x5
ffffffffc020082c:	a6050513          	addi	a0,a0,-1440 # ffffffffc0205288 <commands+0x360>
print_trapframe(struct trapframe *tf) {
ffffffffc0200830:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200832:	897ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    print_regs(&tf->gpr);
ffffffffc0200836:	8522                	mv	a0,s0
ffffffffc0200838:	e1bff0ef          	jal	ra,ffffffffc0200652 <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
ffffffffc020083c:	10043583          	ld	a1,256(s0)
ffffffffc0200840:	00005517          	auipc	a0,0x5
ffffffffc0200844:	a6050513          	addi	a0,a0,-1440 # ffffffffc02052a0 <commands+0x378>
ffffffffc0200848:	881ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
ffffffffc020084c:	10843583          	ld	a1,264(s0)
ffffffffc0200850:	00005517          	auipc	a0,0x5
ffffffffc0200854:	a6850513          	addi	a0,a0,-1432 # ffffffffc02052b8 <commands+0x390>
ffffffffc0200858:	871ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  tval 0x%08x\n", tf->tval);
ffffffffc020085c:	11043583          	ld	a1,272(s0)
ffffffffc0200860:	00005517          	auipc	a0,0x5
ffffffffc0200864:	a7050513          	addi	a0,a0,-1424 # ffffffffc02052d0 <commands+0x3a8>
ffffffffc0200868:	861ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc020086c:	11843583          	ld	a1,280(s0)
}
ffffffffc0200870:	6402                	ld	s0,0(sp)
ffffffffc0200872:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200874:	00005517          	auipc	a0,0x5
ffffffffc0200878:	a6c50513          	addi	a0,a0,-1428 # ffffffffc02052e0 <commands+0x3b8>
}
ffffffffc020087c:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc020087e:	84bff06f          	j	ffffffffc02000c8 <cprintf>

ffffffffc0200882 <pgfault_handler>:
            trap_in_kernel(tf) ? 'K' : 'U',
            tf->cause == CAUSE_STORE_PAGE_FAULT ? 'W' : 'R');
}

static int
pgfault_handler(struct trapframe *tf) {
ffffffffc0200882:	1101                	addi	sp,sp,-32
ffffffffc0200884:	e426                	sd	s1,8(sp)
    extern struct mm_struct *check_mm_struct;
    if(check_mm_struct !=NULL) { 
ffffffffc0200886:	00033497          	auipc	s1,0x33
ffffffffc020088a:	4b248493          	addi	s1,s1,1202 # ffffffffc0233d38 <check_mm_struct>
ffffffffc020088e:	609c                	ld	a5,0(s1)
pgfault_handler(struct trapframe *tf) {
ffffffffc0200890:	e822                	sd	s0,16(sp)
ffffffffc0200892:	ec06                	sd	ra,24(sp)
ffffffffc0200894:	842a                	mv	s0,a0
    if(check_mm_struct !=NULL) { 
ffffffffc0200896:	cbad                	beqz	a5,ffffffffc0200908 <pgfault_handler+0x86>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200898:	10053783          	ld	a5,256(a0)
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc020089c:	11053583          	ld	a1,272(a0)
ffffffffc02008a0:	04b00613          	li	a2,75
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc02008a4:	1007f793          	andi	a5,a5,256
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc02008a8:	c7b1                	beqz	a5,ffffffffc02008f4 <pgfault_handler+0x72>
ffffffffc02008aa:	11843703          	ld	a4,280(s0)
ffffffffc02008ae:	47bd                	li	a5,15
ffffffffc02008b0:	05700693          	li	a3,87
ffffffffc02008b4:	00f70463          	beq	a4,a5,ffffffffc02008bc <pgfault_handler+0x3a>
ffffffffc02008b8:	05200693          	li	a3,82
ffffffffc02008bc:	00005517          	auipc	a0,0x5
ffffffffc02008c0:	a3c50513          	addi	a0,a0,-1476 # ffffffffc02052f8 <commands+0x3d0>
ffffffffc02008c4:	805ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            print_pgfault(tf);
        }
    struct mm_struct *mm;
    if (check_mm_struct != NULL) {
ffffffffc02008c8:	6088                	ld	a0,0(s1)
ffffffffc02008ca:	cd1d                	beqz	a0,ffffffffc0200908 <pgfault_handler+0x86>
        assert(current == idleproc);
ffffffffc02008cc:	00033717          	auipc	a4,0x33
ffffffffc02008d0:	41473703          	ld	a4,1044(a4) # ffffffffc0233ce0 <current>
ffffffffc02008d4:	00033797          	auipc	a5,0x33
ffffffffc02008d8:	4147b783          	ld	a5,1044(a5) # ffffffffc0233ce8 <idleproc>
ffffffffc02008dc:	04f71663          	bne	a4,a5,ffffffffc0200928 <pgfault_handler+0xa6>
            print_pgfault(tf);
            panic("unhandled page fault.\n");
        }
        mm = current->mm;
    }
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc02008e0:	11043603          	ld	a2,272(s0)
ffffffffc02008e4:	11843583          	ld	a1,280(s0)
}
ffffffffc02008e8:	6442                	ld	s0,16(sp)
ffffffffc02008ea:	60e2                	ld	ra,24(sp)
ffffffffc02008ec:	64a2                	ld	s1,8(sp)
ffffffffc02008ee:	6105                	addi	sp,sp,32
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc02008f0:	1be0106f          	j	ffffffffc0201aae <do_pgfault>
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc02008f4:	11843703          	ld	a4,280(s0)
ffffffffc02008f8:	47bd                	li	a5,15
ffffffffc02008fa:	05500613          	li	a2,85
ffffffffc02008fe:	05700693          	li	a3,87
ffffffffc0200902:	faf71be3          	bne	a4,a5,ffffffffc02008b8 <pgfault_handler+0x36>
ffffffffc0200906:	bf5d                	j	ffffffffc02008bc <pgfault_handler+0x3a>
        if (current == NULL) {
ffffffffc0200908:	00033797          	auipc	a5,0x33
ffffffffc020090c:	3d87b783          	ld	a5,984(a5) # ffffffffc0233ce0 <current>
ffffffffc0200910:	cf85                	beqz	a5,ffffffffc0200948 <pgfault_handler+0xc6>
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc0200912:	11043603          	ld	a2,272(s0)
ffffffffc0200916:	11843583          	ld	a1,280(s0)
}
ffffffffc020091a:	6442                	ld	s0,16(sp)
ffffffffc020091c:	60e2                	ld	ra,24(sp)
ffffffffc020091e:	64a2                	ld	s1,8(sp)
        mm = current->mm;
ffffffffc0200920:	7788                	ld	a0,40(a5)
}
ffffffffc0200922:	6105                	addi	sp,sp,32
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc0200924:	18a0106f          	j	ffffffffc0201aae <do_pgfault>
        assert(current == idleproc);
ffffffffc0200928:	00005697          	auipc	a3,0x5
ffffffffc020092c:	9f068693          	addi	a3,a3,-1552 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0200930:	00005617          	auipc	a2,0x5
ffffffffc0200934:	a0060613          	addi	a2,a2,-1536 # ffffffffc0205330 <commands+0x408>
ffffffffc0200938:	06800593          	li	a1,104
ffffffffc020093c:	00005517          	auipc	a0,0x5
ffffffffc0200940:	a0c50513          	addi	a0,a0,-1524 # ffffffffc0205348 <commands+0x420>
ffffffffc0200944:	8c1ff0ef          	jal	ra,ffffffffc0200204 <__panic>
            print_trapframe(tf);
ffffffffc0200948:	8522                	mv	a0,s0
ffffffffc020094a:	ed7ff0ef          	jal	ra,ffffffffc0200820 <print_trapframe>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc020094e:	10043783          	ld	a5,256(s0)
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc0200952:	11043583          	ld	a1,272(s0)
ffffffffc0200956:	04b00613          	li	a2,75
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc020095a:	1007f793          	andi	a5,a5,256
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc020095e:	e399                	bnez	a5,ffffffffc0200964 <pgfault_handler+0xe2>
ffffffffc0200960:	05500613          	li	a2,85
ffffffffc0200964:	11843703          	ld	a4,280(s0)
ffffffffc0200968:	47bd                	li	a5,15
ffffffffc020096a:	02f70663          	beq	a4,a5,ffffffffc0200996 <pgfault_handler+0x114>
ffffffffc020096e:	05200693          	li	a3,82
ffffffffc0200972:	00005517          	auipc	a0,0x5
ffffffffc0200976:	98650513          	addi	a0,a0,-1658 # ffffffffc02052f8 <commands+0x3d0>
ffffffffc020097a:	f4eff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            panic("unhandled page fault.\n");
ffffffffc020097e:	00005617          	auipc	a2,0x5
ffffffffc0200982:	9e260613          	addi	a2,a2,-1566 # ffffffffc0205360 <commands+0x438>
ffffffffc0200986:	06f00593          	li	a1,111
ffffffffc020098a:	00005517          	auipc	a0,0x5
ffffffffc020098e:	9be50513          	addi	a0,a0,-1602 # ffffffffc0205348 <commands+0x420>
ffffffffc0200992:	873ff0ef          	jal	ra,ffffffffc0200204 <__panic>
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc0200996:	05700693          	li	a3,87
ffffffffc020099a:	bfe1                	j	ffffffffc0200972 <pgfault_handler+0xf0>

ffffffffc020099c <interrupt_handler>:

static volatile int in_swap_tick_event = 0;
extern struct mm_struct *check_mm_struct;

void interrupt_handler(struct trapframe *tf) {
    intptr_t cause = (tf->cause << 1) >> 1;
ffffffffc020099c:	11853783          	ld	a5,280(a0)
ffffffffc02009a0:	472d                	li	a4,11
ffffffffc02009a2:	0786                	slli	a5,a5,0x1
ffffffffc02009a4:	8385                	srli	a5,a5,0x1
ffffffffc02009a6:	06f76d63          	bltu	a4,a5,ffffffffc0200a20 <interrupt_handler+0x84>
ffffffffc02009aa:	00005717          	auipc	a4,0x5
ffffffffc02009ae:	a6e70713          	addi	a4,a4,-1426 # ffffffffc0205418 <commands+0x4f0>
ffffffffc02009b2:	078a                	slli	a5,a5,0x2
ffffffffc02009b4:	97ba                	add	a5,a5,a4
ffffffffc02009b6:	439c                	lw	a5,0(a5)
ffffffffc02009b8:	97ba                	add	a5,a5,a4
ffffffffc02009ba:	8782                	jr	a5
            break;
        case IRQ_H_SOFT:
            cprintf("Hypervisor software interrupt\n");
            break;
        case IRQ_M_SOFT:
            cprintf("Machine software interrupt\n");
ffffffffc02009bc:	00005517          	auipc	a0,0x5
ffffffffc02009c0:	a1c50513          	addi	a0,a0,-1508 # ffffffffc02053d8 <commands+0x4b0>
ffffffffc02009c4:	f04ff06f          	j	ffffffffc02000c8 <cprintf>
            cprintf("Hypervisor software interrupt\n");
ffffffffc02009c8:	00005517          	auipc	a0,0x5
ffffffffc02009cc:	9f050513          	addi	a0,a0,-1552 # ffffffffc02053b8 <commands+0x490>
ffffffffc02009d0:	ef8ff06f          	j	ffffffffc02000c8 <cprintf>
            cprintf("User software interrupt\n");
ffffffffc02009d4:	00005517          	auipc	a0,0x5
ffffffffc02009d8:	9a450513          	addi	a0,a0,-1628 # ffffffffc0205378 <commands+0x450>
ffffffffc02009dc:	eecff06f          	j	ffffffffc02000c8 <cprintf>
            cprintf("Supervisor software interrupt\n");
ffffffffc02009e0:	00005517          	auipc	a0,0x5
ffffffffc02009e4:	9b850513          	addi	a0,a0,-1608 # ffffffffc0205398 <commands+0x470>
ffffffffc02009e8:	ee0ff06f          	j	ffffffffc02000c8 <cprintf>
void interrupt_handler(struct trapframe *tf) {
ffffffffc02009ec:	1141                	addi	sp,sp,-16
ffffffffc02009ee:	e406                	sd	ra,8(sp)
            break;
        case IRQ_U_TIMER:
            cprintf("User software interrupt\n");
            break;
        case IRQ_S_TIMER:
            clock_set_next_event();
ffffffffc02009f0:	bb3ff0ef          	jal	ra,ffffffffc02005a2 <clock_set_next_event>
            if (++ticks % TICK_NUM == 0 ) {
ffffffffc02009f4:	00033717          	auipc	a4,0x33
ffffffffc02009f8:	31c70713          	addi	a4,a4,796 # ffffffffc0233d10 <ticks>
ffffffffc02009fc:	631c                	ld	a5,0(a4)
                //print_ticks()
            }
            if (current){
ffffffffc02009fe:	00033517          	auipc	a0,0x33
ffffffffc0200a02:	2e253503          	ld	a0,738(a0) # ffffffffc0233ce0 <current>
            if (++ticks % TICK_NUM == 0 ) {
ffffffffc0200a06:	0785                	addi	a5,a5,1
ffffffffc0200a08:	e31c                	sd	a5,0(a4)
            if (current){
ffffffffc0200a0a:	cd01                	beqz	a0,ffffffffc0200a22 <interrupt_handler+0x86>
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
ffffffffc0200a0c:	60a2                	ld	ra,8(sp)
ffffffffc0200a0e:	0141                	addi	sp,sp,16
                sched_class_proc_tick(current); 
ffffffffc0200a10:	2430306f          	j	ffffffffc0204452 <sched_class_proc_tick>
            cprintf("Supervisor external interrupt\n");
ffffffffc0200a14:	00005517          	auipc	a0,0x5
ffffffffc0200a18:	9e450513          	addi	a0,a0,-1564 # ffffffffc02053f8 <commands+0x4d0>
ffffffffc0200a1c:	eacff06f          	j	ffffffffc02000c8 <cprintf>
            print_trapframe(tf);
ffffffffc0200a20:	b501                	j	ffffffffc0200820 <print_trapframe>
}
ffffffffc0200a22:	60a2                	ld	ra,8(sp)
ffffffffc0200a24:	0141                	addi	sp,sp,16
ffffffffc0200a26:	8082                	ret

ffffffffc0200a28 <exception_handler>:

void exception_handler(struct trapframe *tf) {
    int ret;
    switch (tf->cause) {
ffffffffc0200a28:	11853783          	ld	a5,280(a0)
void exception_handler(struct trapframe *tf) {
ffffffffc0200a2c:	1101                	addi	sp,sp,-32
ffffffffc0200a2e:	e822                	sd	s0,16(sp)
ffffffffc0200a30:	ec06                	sd	ra,24(sp)
ffffffffc0200a32:	e426                	sd	s1,8(sp)
ffffffffc0200a34:	473d                	li	a4,15
ffffffffc0200a36:	842a                	mv	s0,a0
ffffffffc0200a38:	16f76163          	bltu	a4,a5,ffffffffc0200b9a <exception_handler+0x172>
ffffffffc0200a3c:	00005717          	auipc	a4,0x5
ffffffffc0200a40:	ba470713          	addi	a4,a4,-1116 # ffffffffc02055e0 <commands+0x6b8>
ffffffffc0200a44:	078a                	slli	a5,a5,0x2
ffffffffc0200a46:	97ba                	add	a5,a5,a4
ffffffffc0200a48:	439c                	lw	a5,0(a5)
ffffffffc0200a4a:	97ba                	add	a5,a5,a4
ffffffffc0200a4c:	8782                	jr	a5
            //cprintf("Environment call from U-mode\n");
            tf->epc += 4;
            syscall();
            break;
        case CAUSE_SUPERVISOR_ECALL:
            cprintf("Environment call from S-mode\n");
ffffffffc0200a4e:	00005517          	auipc	a0,0x5
ffffffffc0200a52:	aea50513          	addi	a0,a0,-1302 # ffffffffc0205538 <commands+0x610>
ffffffffc0200a56:	e72ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            tf->epc += 4;
ffffffffc0200a5a:	10843783          	ld	a5,264(s0)
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
ffffffffc0200a5e:	60e2                	ld	ra,24(sp)
ffffffffc0200a60:	64a2                	ld	s1,8(sp)
            tf->epc += 4;
ffffffffc0200a62:	0791                	addi	a5,a5,4
ffffffffc0200a64:	10f43423          	sd	a5,264(s0)
}
ffffffffc0200a68:	6442                	ld	s0,16(sp)
ffffffffc0200a6a:	6105                	addi	sp,sp,32
            syscall();
ffffffffc0200a6c:	4ff0306f          	j	ffffffffc020476a <syscall>
            cprintf("Environment call from H-mode\n");
ffffffffc0200a70:	00005517          	auipc	a0,0x5
ffffffffc0200a74:	ae850513          	addi	a0,a0,-1304 # ffffffffc0205558 <commands+0x630>
}
ffffffffc0200a78:	6442                	ld	s0,16(sp)
ffffffffc0200a7a:	60e2                	ld	ra,24(sp)
ffffffffc0200a7c:	64a2                	ld	s1,8(sp)
ffffffffc0200a7e:	6105                	addi	sp,sp,32
            cprintf("Instruction access fault\n");
ffffffffc0200a80:	e48ff06f          	j	ffffffffc02000c8 <cprintf>
            cprintf("Environment call from M-mode\n");
ffffffffc0200a84:	00005517          	auipc	a0,0x5
ffffffffc0200a88:	af450513          	addi	a0,a0,-1292 # ffffffffc0205578 <commands+0x650>
ffffffffc0200a8c:	b7f5                	j	ffffffffc0200a78 <exception_handler+0x50>
            cprintf("Instruction page fault\n");
ffffffffc0200a8e:	00005517          	auipc	a0,0x5
ffffffffc0200a92:	b0a50513          	addi	a0,a0,-1270 # ffffffffc0205598 <commands+0x670>
ffffffffc0200a96:	b7cd                	j	ffffffffc0200a78 <exception_handler+0x50>
            cprintf("Load page fault\n");
ffffffffc0200a98:	00005517          	auipc	a0,0x5
ffffffffc0200a9c:	b1850513          	addi	a0,a0,-1256 # ffffffffc02055b0 <commands+0x688>
ffffffffc0200aa0:	e28ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200aa4:	8522                	mv	a0,s0
ffffffffc0200aa6:	dddff0ef          	jal	ra,ffffffffc0200882 <pgfault_handler>
ffffffffc0200aaa:	84aa                	mv	s1,a0
ffffffffc0200aac:	10051963          	bnez	a0,ffffffffc0200bbe <exception_handler+0x196>
}
ffffffffc0200ab0:	60e2                	ld	ra,24(sp)
ffffffffc0200ab2:	6442                	ld	s0,16(sp)
ffffffffc0200ab4:	64a2                	ld	s1,8(sp)
ffffffffc0200ab6:	6105                	addi	sp,sp,32
ffffffffc0200ab8:	8082                	ret
            cprintf("Store/AMO page fault\n");
ffffffffc0200aba:	00005517          	auipc	a0,0x5
ffffffffc0200abe:	b0e50513          	addi	a0,a0,-1266 # ffffffffc02055c8 <commands+0x6a0>
ffffffffc0200ac2:	e06ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200ac6:	8522                	mv	a0,s0
ffffffffc0200ac8:	dbbff0ef          	jal	ra,ffffffffc0200882 <pgfault_handler>
ffffffffc0200acc:	84aa                	mv	s1,a0
ffffffffc0200ace:	d16d                	beqz	a0,ffffffffc0200ab0 <exception_handler+0x88>
                print_trapframe(tf);
ffffffffc0200ad0:	8522                	mv	a0,s0
ffffffffc0200ad2:	d4fff0ef          	jal	ra,ffffffffc0200820 <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200ad6:	86a6                	mv	a3,s1
ffffffffc0200ad8:	00005617          	auipc	a2,0x5
ffffffffc0200adc:	a1060613          	addi	a2,a2,-1520 # ffffffffc02054e8 <commands+0x5c0>
ffffffffc0200ae0:	0f100593          	li	a1,241
ffffffffc0200ae4:	00005517          	auipc	a0,0x5
ffffffffc0200ae8:	86450513          	addi	a0,a0,-1948 # ffffffffc0205348 <commands+0x420>
ffffffffc0200aec:	f18ff0ef          	jal	ra,ffffffffc0200204 <__panic>
            cprintf("Instruction address misaligned\n");
ffffffffc0200af0:	00005517          	auipc	a0,0x5
ffffffffc0200af4:	95850513          	addi	a0,a0,-1704 # ffffffffc0205448 <commands+0x520>
ffffffffc0200af8:	b741                	j	ffffffffc0200a78 <exception_handler+0x50>
            cprintf("Instruction access fault\n");
ffffffffc0200afa:	00005517          	auipc	a0,0x5
ffffffffc0200afe:	96e50513          	addi	a0,a0,-1682 # ffffffffc0205468 <commands+0x540>
ffffffffc0200b02:	bf9d                	j	ffffffffc0200a78 <exception_handler+0x50>
            cprintf("Illegal instruction\n");
ffffffffc0200b04:	00005517          	auipc	a0,0x5
ffffffffc0200b08:	98450513          	addi	a0,a0,-1660 # ffffffffc0205488 <commands+0x560>
ffffffffc0200b0c:	b7b5                	j	ffffffffc0200a78 <exception_handler+0x50>
            cprintf("Breakpoint\n");
ffffffffc0200b0e:	00005517          	auipc	a0,0x5
ffffffffc0200b12:	99250513          	addi	a0,a0,-1646 # ffffffffc02054a0 <commands+0x578>
ffffffffc0200b16:	db2ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            if(tf->gpr.a7 == 10){
ffffffffc0200b1a:	6458                	ld	a4,136(s0)
ffffffffc0200b1c:	47a9                	li	a5,10
ffffffffc0200b1e:	f8f719e3          	bne	a4,a5,ffffffffc0200ab0 <exception_handler+0x88>
ffffffffc0200b22:	bf25                	j	ffffffffc0200a5a <exception_handler+0x32>
            cprintf("Load address misaligned\n");
ffffffffc0200b24:	00005517          	auipc	a0,0x5
ffffffffc0200b28:	98c50513          	addi	a0,a0,-1652 # ffffffffc02054b0 <commands+0x588>
ffffffffc0200b2c:	b7b1                	j	ffffffffc0200a78 <exception_handler+0x50>
            cprintf("Load access fault\n");
ffffffffc0200b2e:	00005517          	auipc	a0,0x5
ffffffffc0200b32:	9a250513          	addi	a0,a0,-1630 # ffffffffc02054d0 <commands+0x5a8>
ffffffffc0200b36:	d92ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200b3a:	8522                	mv	a0,s0
ffffffffc0200b3c:	d47ff0ef          	jal	ra,ffffffffc0200882 <pgfault_handler>
ffffffffc0200b40:	84aa                	mv	s1,a0
ffffffffc0200b42:	d53d                	beqz	a0,ffffffffc0200ab0 <exception_handler+0x88>
                print_trapframe(tf);
ffffffffc0200b44:	8522                	mv	a0,s0
ffffffffc0200b46:	cdbff0ef          	jal	ra,ffffffffc0200820 <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200b4a:	86a6                	mv	a3,s1
ffffffffc0200b4c:	00005617          	auipc	a2,0x5
ffffffffc0200b50:	99c60613          	addi	a2,a2,-1636 # ffffffffc02054e8 <commands+0x5c0>
ffffffffc0200b54:	0c600593          	li	a1,198
ffffffffc0200b58:	00004517          	auipc	a0,0x4
ffffffffc0200b5c:	7f050513          	addi	a0,a0,2032 # ffffffffc0205348 <commands+0x420>
ffffffffc0200b60:	ea4ff0ef          	jal	ra,ffffffffc0200204 <__panic>
            cprintf("Store/AMO access fault\n");
ffffffffc0200b64:	00005517          	auipc	a0,0x5
ffffffffc0200b68:	9bc50513          	addi	a0,a0,-1604 # ffffffffc0205520 <commands+0x5f8>
ffffffffc0200b6c:	d5cff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200b70:	8522                	mv	a0,s0
ffffffffc0200b72:	d11ff0ef          	jal	ra,ffffffffc0200882 <pgfault_handler>
ffffffffc0200b76:	84aa                	mv	s1,a0
ffffffffc0200b78:	dd05                	beqz	a0,ffffffffc0200ab0 <exception_handler+0x88>
                print_trapframe(tf);
ffffffffc0200b7a:	8522                	mv	a0,s0
ffffffffc0200b7c:	ca5ff0ef          	jal	ra,ffffffffc0200820 <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200b80:	86a6                	mv	a3,s1
ffffffffc0200b82:	00005617          	auipc	a2,0x5
ffffffffc0200b86:	96660613          	addi	a2,a2,-1690 # ffffffffc02054e8 <commands+0x5c0>
ffffffffc0200b8a:	0d000593          	li	a1,208
ffffffffc0200b8e:	00004517          	auipc	a0,0x4
ffffffffc0200b92:	7ba50513          	addi	a0,a0,1978 # ffffffffc0205348 <commands+0x420>
ffffffffc0200b96:	e6eff0ef          	jal	ra,ffffffffc0200204 <__panic>
            print_trapframe(tf);
ffffffffc0200b9a:	8522                	mv	a0,s0
}
ffffffffc0200b9c:	6442                	ld	s0,16(sp)
ffffffffc0200b9e:	60e2                	ld	ra,24(sp)
ffffffffc0200ba0:	64a2                	ld	s1,8(sp)
ffffffffc0200ba2:	6105                	addi	sp,sp,32
            print_trapframe(tf);
ffffffffc0200ba4:	b9b5                	j	ffffffffc0200820 <print_trapframe>
            panic("AMO address misaligned\n");
ffffffffc0200ba6:	00005617          	auipc	a2,0x5
ffffffffc0200baa:	96260613          	addi	a2,a2,-1694 # ffffffffc0205508 <commands+0x5e0>
ffffffffc0200bae:	0ca00593          	li	a1,202
ffffffffc0200bb2:	00004517          	auipc	a0,0x4
ffffffffc0200bb6:	79650513          	addi	a0,a0,1942 # ffffffffc0205348 <commands+0x420>
ffffffffc0200bba:	e4aff0ef          	jal	ra,ffffffffc0200204 <__panic>
                print_trapframe(tf);
ffffffffc0200bbe:	8522                	mv	a0,s0
ffffffffc0200bc0:	c61ff0ef          	jal	ra,ffffffffc0200820 <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200bc4:	86a6                	mv	a3,s1
ffffffffc0200bc6:	00005617          	auipc	a2,0x5
ffffffffc0200bca:	92260613          	addi	a2,a2,-1758 # ffffffffc02054e8 <commands+0x5c0>
ffffffffc0200bce:	0ea00593          	li	a1,234
ffffffffc0200bd2:	00004517          	auipc	a0,0x4
ffffffffc0200bd6:	77650513          	addi	a0,a0,1910 # ffffffffc0205348 <commands+0x420>
ffffffffc0200bda:	e2aff0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0200bde <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
ffffffffc0200bde:	1101                	addi	sp,sp,-32
ffffffffc0200be0:	e822                	sd	s0,16(sp)

    if (current == NULL) {
ffffffffc0200be2:	00033417          	auipc	s0,0x33
ffffffffc0200be6:	0fe40413          	addi	s0,s0,254 # ffffffffc0233ce0 <current>
ffffffffc0200bea:	6018                	ld	a4,0(s0)
trap(struct trapframe *tf) {
ffffffffc0200bec:	ec06                	sd	ra,24(sp)
ffffffffc0200bee:	e426                	sd	s1,8(sp)
ffffffffc0200bf0:	e04a                	sd	s2,0(sp)
ffffffffc0200bf2:	11853683          	ld	a3,280(a0)
    if (current == NULL) {
ffffffffc0200bf6:	cf1d                	beqz	a4,ffffffffc0200c34 <trap+0x56>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200bf8:	10053483          	ld	s1,256(a0)
        trap_dispatch(tf);
    } else {
        struct trapframe *otf = current->tf;
ffffffffc0200bfc:	0a073903          	ld	s2,160(a4)
        current->tf = tf;
ffffffffc0200c00:	f348                	sd	a0,160(a4)
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200c02:	1004f493          	andi	s1,s1,256
    if ((intptr_t)tf->cause < 0) {
ffffffffc0200c06:	0206c463          	bltz	a3,ffffffffc0200c2e <trap+0x50>
        exception_handler(tf);
ffffffffc0200c0a:	e1fff0ef          	jal	ra,ffffffffc0200a28 <exception_handler>

        bool in_kernel = trap_in_kernel(tf);

        trap_dispatch(tf);

        current->tf = otf;
ffffffffc0200c0e:	601c                	ld	a5,0(s0)
ffffffffc0200c10:	0b27b023          	sd	s2,160(a5)
        if (!in_kernel) {
ffffffffc0200c14:	e499                	bnez	s1,ffffffffc0200c22 <trap+0x44>
            if (current->flags & PF_EXITING) {
ffffffffc0200c16:	0b07a703          	lw	a4,176(a5)
ffffffffc0200c1a:	8b05                	andi	a4,a4,1
ffffffffc0200c1c:	e329                	bnez	a4,ffffffffc0200c5e <trap+0x80>
                do_exit(-E_KILLED);
            }
            if (current->need_resched) {
ffffffffc0200c1e:	6f9c                	ld	a5,24(a5)
ffffffffc0200c20:	eb85                	bnez	a5,ffffffffc0200c50 <trap+0x72>
                schedule();
            }
        }
    }
}
ffffffffc0200c22:	60e2                	ld	ra,24(sp)
ffffffffc0200c24:	6442                	ld	s0,16(sp)
ffffffffc0200c26:	64a2                	ld	s1,8(sp)
ffffffffc0200c28:	6902                	ld	s2,0(sp)
ffffffffc0200c2a:	6105                	addi	sp,sp,32
ffffffffc0200c2c:	8082                	ret
        interrupt_handler(tf);
ffffffffc0200c2e:	d6fff0ef          	jal	ra,ffffffffc020099c <interrupt_handler>
ffffffffc0200c32:	bff1                	j	ffffffffc0200c0e <trap+0x30>
    if ((intptr_t)tf->cause < 0) {
ffffffffc0200c34:	0006c863          	bltz	a3,ffffffffc0200c44 <trap+0x66>
}
ffffffffc0200c38:	6442                	ld	s0,16(sp)
ffffffffc0200c3a:	60e2                	ld	ra,24(sp)
ffffffffc0200c3c:	64a2                	ld	s1,8(sp)
ffffffffc0200c3e:	6902                	ld	s2,0(sp)
ffffffffc0200c40:	6105                	addi	sp,sp,32
        exception_handler(tf);
ffffffffc0200c42:	b3dd                	j	ffffffffc0200a28 <exception_handler>
}
ffffffffc0200c44:	6442                	ld	s0,16(sp)
ffffffffc0200c46:	60e2                	ld	ra,24(sp)
ffffffffc0200c48:	64a2                	ld	s1,8(sp)
ffffffffc0200c4a:	6902                	ld	s2,0(sp)
ffffffffc0200c4c:	6105                	addi	sp,sp,32
        interrupt_handler(tf);
ffffffffc0200c4e:	b3b9                	j	ffffffffc020099c <interrupt_handler>
}
ffffffffc0200c50:	6442                	ld	s0,16(sp)
ffffffffc0200c52:	60e2                	ld	ra,24(sp)
ffffffffc0200c54:	64a2                	ld	s1,8(sp)
ffffffffc0200c56:	6902                	ld	s2,0(sp)
ffffffffc0200c58:	6105                	addi	sp,sp,32
                schedule();
ffffffffc0200c5a:	1270306f          	j	ffffffffc0204580 <schedule>
                do_exit(-E_KILLED);
ffffffffc0200c5e:	555d                	li	a0,-9
ffffffffc0200c60:	521020ef          	jal	ra,ffffffffc0203980 <do_exit>
ffffffffc0200c64:	601c                	ld	a5,0(s0)
ffffffffc0200c66:	bf65                	j	ffffffffc0200c1e <trap+0x40>

ffffffffc0200c68 <__alltraps>:
    LOAD x2, 2*REGBYTES(sp)
    .endm

    .globl __alltraps
__alltraps:
    SAVE_ALL
ffffffffc0200c68:	14011173          	csrrw	sp,sscratch,sp
ffffffffc0200c6c:	00011463          	bnez	sp,ffffffffc0200c74 <__alltraps+0xc>
ffffffffc0200c70:	14002173          	csrr	sp,sscratch
ffffffffc0200c74:	712d                	addi	sp,sp,-288
ffffffffc0200c76:	e002                	sd	zero,0(sp)
ffffffffc0200c78:	e406                	sd	ra,8(sp)
ffffffffc0200c7a:	ec0e                	sd	gp,24(sp)
ffffffffc0200c7c:	f012                	sd	tp,32(sp)
ffffffffc0200c7e:	f416                	sd	t0,40(sp)
ffffffffc0200c80:	f81a                	sd	t1,48(sp)
ffffffffc0200c82:	fc1e                	sd	t2,56(sp)
ffffffffc0200c84:	e0a2                	sd	s0,64(sp)
ffffffffc0200c86:	e4a6                	sd	s1,72(sp)
ffffffffc0200c88:	e8aa                	sd	a0,80(sp)
ffffffffc0200c8a:	ecae                	sd	a1,88(sp)
ffffffffc0200c8c:	f0b2                	sd	a2,96(sp)
ffffffffc0200c8e:	f4b6                	sd	a3,104(sp)
ffffffffc0200c90:	f8ba                	sd	a4,112(sp)
ffffffffc0200c92:	fcbe                	sd	a5,120(sp)
ffffffffc0200c94:	e142                	sd	a6,128(sp)
ffffffffc0200c96:	e546                	sd	a7,136(sp)
ffffffffc0200c98:	e94a                	sd	s2,144(sp)
ffffffffc0200c9a:	ed4e                	sd	s3,152(sp)
ffffffffc0200c9c:	f152                	sd	s4,160(sp)
ffffffffc0200c9e:	f556                	sd	s5,168(sp)
ffffffffc0200ca0:	f95a                	sd	s6,176(sp)
ffffffffc0200ca2:	fd5e                	sd	s7,184(sp)
ffffffffc0200ca4:	e1e2                	sd	s8,192(sp)
ffffffffc0200ca6:	e5e6                	sd	s9,200(sp)
ffffffffc0200ca8:	e9ea                	sd	s10,208(sp)
ffffffffc0200caa:	edee                	sd	s11,216(sp)
ffffffffc0200cac:	f1f2                	sd	t3,224(sp)
ffffffffc0200cae:	f5f6                	sd	t4,232(sp)
ffffffffc0200cb0:	f9fa                	sd	t5,240(sp)
ffffffffc0200cb2:	fdfe                	sd	t6,248(sp)
ffffffffc0200cb4:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200cb8:	100024f3          	csrr	s1,sstatus
ffffffffc0200cbc:	14102973          	csrr	s2,sepc
ffffffffc0200cc0:	143029f3          	csrr	s3,stval
ffffffffc0200cc4:	14202a73          	csrr	s4,scause
ffffffffc0200cc8:	e822                	sd	s0,16(sp)
ffffffffc0200cca:	e226                	sd	s1,256(sp)
ffffffffc0200ccc:	e64a                	sd	s2,264(sp)
ffffffffc0200cce:	ea4e                	sd	s3,272(sp)
ffffffffc0200cd0:	ee52                	sd	s4,280(sp)

    move  a0, sp
ffffffffc0200cd2:	850a                	mv	a0,sp
    jal trap
ffffffffc0200cd4:	f0bff0ef          	jal	ra,ffffffffc0200bde <trap>

ffffffffc0200cd8 <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
ffffffffc0200cd8:	6492                	ld	s1,256(sp)
ffffffffc0200cda:	6932                	ld	s2,264(sp)
ffffffffc0200cdc:	1004f413          	andi	s0,s1,256
ffffffffc0200ce0:	e401                	bnez	s0,ffffffffc0200ce8 <__trapret+0x10>
ffffffffc0200ce2:	1200                	addi	s0,sp,288
ffffffffc0200ce4:	14041073          	csrw	sscratch,s0
ffffffffc0200ce8:	10049073          	csrw	sstatus,s1
ffffffffc0200cec:	14191073          	csrw	sepc,s2
ffffffffc0200cf0:	60a2                	ld	ra,8(sp)
ffffffffc0200cf2:	61e2                	ld	gp,24(sp)
ffffffffc0200cf4:	7202                	ld	tp,32(sp)
ffffffffc0200cf6:	72a2                	ld	t0,40(sp)
ffffffffc0200cf8:	7342                	ld	t1,48(sp)
ffffffffc0200cfa:	73e2                	ld	t2,56(sp)
ffffffffc0200cfc:	6406                	ld	s0,64(sp)
ffffffffc0200cfe:	64a6                	ld	s1,72(sp)
ffffffffc0200d00:	6546                	ld	a0,80(sp)
ffffffffc0200d02:	65e6                	ld	a1,88(sp)
ffffffffc0200d04:	7606                	ld	a2,96(sp)
ffffffffc0200d06:	76a6                	ld	a3,104(sp)
ffffffffc0200d08:	7746                	ld	a4,112(sp)
ffffffffc0200d0a:	77e6                	ld	a5,120(sp)
ffffffffc0200d0c:	680a                	ld	a6,128(sp)
ffffffffc0200d0e:	68aa                	ld	a7,136(sp)
ffffffffc0200d10:	694a                	ld	s2,144(sp)
ffffffffc0200d12:	69ea                	ld	s3,152(sp)
ffffffffc0200d14:	7a0a                	ld	s4,160(sp)
ffffffffc0200d16:	7aaa                	ld	s5,168(sp)
ffffffffc0200d18:	7b4a                	ld	s6,176(sp)
ffffffffc0200d1a:	7bea                	ld	s7,184(sp)
ffffffffc0200d1c:	6c0e                	ld	s8,192(sp)
ffffffffc0200d1e:	6cae                	ld	s9,200(sp)
ffffffffc0200d20:	6d4e                	ld	s10,208(sp)
ffffffffc0200d22:	6dee                	ld	s11,216(sp)
ffffffffc0200d24:	7e0e                	ld	t3,224(sp)
ffffffffc0200d26:	7eae                	ld	t4,232(sp)
ffffffffc0200d28:	7f4e                	ld	t5,240(sp)
ffffffffc0200d2a:	7fee                	ld	t6,248(sp)
ffffffffc0200d2c:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
ffffffffc0200d2e:	10200073          	sret

ffffffffc0200d32 <forkrets>:
 
    .globl forkrets
forkrets:
    # set stack to this new process's trapframe
    move sp, a0
ffffffffc0200d32:	812a                	mv	sp,a0
    j __trapret
ffffffffc0200d34:	b755                	j	ffffffffc0200cd8 <__trapret>

ffffffffc0200d36 <pa2page.part.0>:
page2pa(struct Page *page) {
    return page2ppn(page) << PGSHIFT;
}

static inline struct Page *
pa2page(uintptr_t pa) {
ffffffffc0200d36:	1141                	addi	sp,sp,-16
    if (PPN(pa) >= npage) {
        panic("pa2page called with invalid pa");
ffffffffc0200d38:	00005617          	auipc	a2,0x5
ffffffffc0200d3c:	8e860613          	addi	a2,a2,-1816 # ffffffffc0205620 <commands+0x6f8>
ffffffffc0200d40:	06200593          	li	a1,98
ffffffffc0200d44:	00005517          	auipc	a0,0x5
ffffffffc0200d48:	8fc50513          	addi	a0,a0,-1796 # ffffffffc0205640 <commands+0x718>
pa2page(uintptr_t pa) {
ffffffffc0200d4c:	e406                	sd	ra,8(sp)
        panic("pa2page called with invalid pa");
ffffffffc0200d4e:	cb6ff0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0200d52 <alloc_pages>:
    pmm_manager->init_memmap(base, n);
}

// alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE
// memory
struct Page *alloc_pages(size_t n) {
ffffffffc0200d52:	7139                	addi	sp,sp,-64
ffffffffc0200d54:	f426                	sd	s1,40(sp)
ffffffffc0200d56:	f04a                	sd	s2,32(sp)
ffffffffc0200d58:	ec4e                	sd	s3,24(sp)
ffffffffc0200d5a:	e852                	sd	s4,16(sp)
ffffffffc0200d5c:	e456                	sd	s5,8(sp)
ffffffffc0200d5e:	e05a                	sd	s6,0(sp)
ffffffffc0200d60:	fc06                	sd	ra,56(sp)
ffffffffc0200d62:	f822                	sd	s0,48(sp)
ffffffffc0200d64:	84aa                	mv	s1,a0
ffffffffc0200d66:	00033917          	auipc	s2,0x33
ffffffffc0200d6a:	fb290913          	addi	s2,s2,-78 # ffffffffc0233d18 <pmm_manager>
        {
            page = pmm_manager->alloc_pages(n);
        }
        local_intr_restore(intr_flag);

        if (page != NULL || n > 1 || swap_init_ok == 0) break;
ffffffffc0200d6e:	4a05                	li	s4,1
ffffffffc0200d70:	00033a97          	auipc	s5,0x33
ffffffffc0200d74:	f60a8a93          	addi	s5,s5,-160 # ffffffffc0233cd0 <swap_init_ok>

        extern struct mm_struct *check_mm_struct;
        // cprintf("page %x, call swap_out in alloc_pages %d\n",page, n);
        swap_out(check_mm_struct, n, 0);
ffffffffc0200d78:	0005099b          	sext.w	s3,a0
ffffffffc0200d7c:	00033b17          	auipc	s6,0x33
ffffffffc0200d80:	fbcb0b13          	addi	s6,s6,-68 # ffffffffc0233d38 <check_mm_struct>
ffffffffc0200d84:	a01d                	j	ffffffffc0200daa <alloc_pages+0x58>
            page = pmm_manager->alloc_pages(n);
ffffffffc0200d86:	00093783          	ld	a5,0(s2)
ffffffffc0200d8a:	6f9c                	ld	a5,24(a5)
ffffffffc0200d8c:	9782                	jalr	a5
ffffffffc0200d8e:	842a                	mv	s0,a0
        swap_out(check_mm_struct, n, 0);
ffffffffc0200d90:	4601                	li	a2,0
ffffffffc0200d92:	85ce                	mv	a1,s3
        if (page != NULL || n > 1 || swap_init_ok == 0) break;
ffffffffc0200d94:	ec0d                	bnez	s0,ffffffffc0200dce <alloc_pages+0x7c>
ffffffffc0200d96:	029a6c63          	bltu	s4,s1,ffffffffc0200dce <alloc_pages+0x7c>
ffffffffc0200d9a:	000aa783          	lw	a5,0(s5)
ffffffffc0200d9e:	2781                	sext.w	a5,a5
ffffffffc0200da0:	c79d                	beqz	a5,ffffffffc0200dce <alloc_pages+0x7c>
        swap_out(check_mm_struct, n, 0);
ffffffffc0200da2:	000b3503          	ld	a0,0(s6)
ffffffffc0200da6:	741000ef          	jal	ra,ffffffffc0201ce6 <swap_out>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0200daa:	100027f3          	csrr	a5,sstatus
ffffffffc0200dae:	8b89                	andi	a5,a5,2
            page = pmm_manager->alloc_pages(n);
ffffffffc0200db0:	8526                	mv	a0,s1
ffffffffc0200db2:	dbf1                	beqz	a5,ffffffffc0200d86 <alloc_pages+0x34>
        intr_disable();
ffffffffc0200db4:	87fff0ef          	jal	ra,ffffffffc0200632 <intr_disable>
ffffffffc0200db8:	00093783          	ld	a5,0(s2)
ffffffffc0200dbc:	8526                	mv	a0,s1
ffffffffc0200dbe:	6f9c                	ld	a5,24(a5)
ffffffffc0200dc0:	9782                	jalr	a5
ffffffffc0200dc2:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0200dc4:	869ff0ef          	jal	ra,ffffffffc020062c <intr_enable>
        swap_out(check_mm_struct, n, 0);
ffffffffc0200dc8:	4601                	li	a2,0
ffffffffc0200dca:	85ce                	mv	a1,s3
        if (page != NULL || n > 1 || swap_init_ok == 0) break;
ffffffffc0200dcc:	d469                	beqz	s0,ffffffffc0200d96 <alloc_pages+0x44>
    }
    // cprintf("n %d,get page %x, No %d in alloc_pages\n",n,page,(page-pages));
    return page;
}
ffffffffc0200dce:	70e2                	ld	ra,56(sp)
ffffffffc0200dd0:	8522                	mv	a0,s0
ffffffffc0200dd2:	7442                	ld	s0,48(sp)
ffffffffc0200dd4:	74a2                	ld	s1,40(sp)
ffffffffc0200dd6:	7902                	ld	s2,32(sp)
ffffffffc0200dd8:	69e2                	ld	s3,24(sp)
ffffffffc0200dda:	6a42                	ld	s4,16(sp)
ffffffffc0200ddc:	6aa2                	ld	s5,8(sp)
ffffffffc0200dde:	6b02                	ld	s6,0(sp)
ffffffffc0200de0:	6121                	addi	sp,sp,64
ffffffffc0200de2:	8082                	ret

ffffffffc0200de4 <free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0200de4:	100027f3          	csrr	a5,sstatus
ffffffffc0200de8:	8b89                	andi	a5,a5,2
ffffffffc0200dea:	eb81                	bnez	a5,ffffffffc0200dfa <free_pages+0x16>
// free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory
void free_pages(struct Page *base, size_t n) {
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
ffffffffc0200dec:	00033797          	auipc	a5,0x33
ffffffffc0200df0:	f2c7b783          	ld	a5,-212(a5) # ffffffffc0233d18 <pmm_manager>
ffffffffc0200df4:	0207b303          	ld	t1,32(a5)
ffffffffc0200df8:	8302                	jr	t1
void free_pages(struct Page *base, size_t n) {
ffffffffc0200dfa:	1101                	addi	sp,sp,-32
ffffffffc0200dfc:	ec06                	sd	ra,24(sp)
ffffffffc0200dfe:	e822                	sd	s0,16(sp)
ffffffffc0200e00:	e426                	sd	s1,8(sp)
ffffffffc0200e02:	842a                	mv	s0,a0
ffffffffc0200e04:	84ae                	mv	s1,a1
        intr_disable();
ffffffffc0200e06:	82dff0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0200e0a:	00033797          	auipc	a5,0x33
ffffffffc0200e0e:	f0e7b783          	ld	a5,-242(a5) # ffffffffc0233d18 <pmm_manager>
ffffffffc0200e12:	739c                	ld	a5,32(a5)
ffffffffc0200e14:	85a6                	mv	a1,s1
ffffffffc0200e16:	8522                	mv	a0,s0
ffffffffc0200e18:	9782                	jalr	a5
    }
    local_intr_restore(intr_flag);
}
ffffffffc0200e1a:	6442                	ld	s0,16(sp)
ffffffffc0200e1c:	60e2                	ld	ra,24(sp)
ffffffffc0200e1e:	64a2                	ld	s1,8(sp)
ffffffffc0200e20:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0200e22:	80bff06f          	j	ffffffffc020062c <intr_enable>

ffffffffc0200e26 <nr_free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0200e26:	100027f3          	csrr	a5,sstatus
ffffffffc0200e2a:	8b89                	andi	a5,a5,2
ffffffffc0200e2c:	eb81                	bnez	a5,ffffffffc0200e3c <nr_free_pages+0x16>
size_t nr_free_pages(void) {
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
ffffffffc0200e2e:	00033797          	auipc	a5,0x33
ffffffffc0200e32:	eea7b783          	ld	a5,-278(a5) # ffffffffc0233d18 <pmm_manager>
ffffffffc0200e36:	0287b303          	ld	t1,40(a5)
ffffffffc0200e3a:	8302                	jr	t1
size_t nr_free_pages(void) {
ffffffffc0200e3c:	1141                	addi	sp,sp,-16
ffffffffc0200e3e:	e406                	sd	ra,8(sp)
ffffffffc0200e40:	e022                	sd	s0,0(sp)
        intr_disable();
ffffffffc0200e42:	ff0ff0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0200e46:	00033797          	auipc	a5,0x33
ffffffffc0200e4a:	ed27b783          	ld	a5,-302(a5) # ffffffffc0233d18 <pmm_manager>
ffffffffc0200e4e:	779c                	ld	a5,40(a5)
ffffffffc0200e50:	9782                	jalr	a5
ffffffffc0200e52:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0200e54:	fd8ff0ef          	jal	ra,ffffffffc020062c <intr_enable>
    }
    local_intr_restore(intr_flag);
    return ret;
}
ffffffffc0200e58:	60a2                	ld	ra,8(sp)
ffffffffc0200e5a:	8522                	mv	a0,s0
ffffffffc0200e5c:	6402                	ld	s0,0(sp)
ffffffffc0200e5e:	0141                	addi	sp,sp,16
ffffffffc0200e60:	8082                	ret

ffffffffc0200e62 <pmm_init>:
    pmm_manager = &default_pmm_manager;
ffffffffc0200e62:	00005797          	auipc	a5,0x5
ffffffffc0200e66:	20e78793          	addi	a5,a5,526 # ffffffffc0206070 <default_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200e6a:	638c                	ld	a1,0(a5)
}

// pmm_init - setup a pmm to manage physical memory, build PDT&PT to setup
// paging mechanism
//         - check the correctness of pmm & paging mechanism, print PDT&PT
void pmm_init(void) {
ffffffffc0200e6c:	1101                	addi	sp,sp,-32
ffffffffc0200e6e:	e426                	sd	s1,8(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200e70:	00004517          	auipc	a0,0x4
ffffffffc0200e74:	7e050513          	addi	a0,a0,2016 # ffffffffc0205650 <commands+0x728>
    pmm_manager = &default_pmm_manager;
ffffffffc0200e78:	00033497          	auipc	s1,0x33
ffffffffc0200e7c:	ea048493          	addi	s1,s1,-352 # ffffffffc0233d18 <pmm_manager>
void pmm_init(void) {
ffffffffc0200e80:	ec06                	sd	ra,24(sp)
ffffffffc0200e82:	e822                	sd	s0,16(sp)
    pmm_manager = &default_pmm_manager;
ffffffffc0200e84:	e09c                	sd	a5,0(s1)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200e86:	a42ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    pmm_manager->init();
ffffffffc0200e8a:	609c                	ld	a5,0(s1)
    va_pa_offset = KERNBASE - 0x80200000;
ffffffffc0200e8c:	00033417          	auipc	s0,0x33
ffffffffc0200e90:	e9440413          	addi	s0,s0,-364 # ffffffffc0233d20 <va_pa_offset>
    pmm_manager->init();
ffffffffc0200e94:	679c                	ld	a5,8(a5)
ffffffffc0200e96:	9782                	jalr	a5
    va_pa_offset = KERNBASE - 0x80200000;
ffffffffc0200e98:	57f5                	li	a5,-3
ffffffffc0200e9a:	07fa                	slli	a5,a5,0x1e
    cprintf("physcial memory map:\n");
ffffffffc0200e9c:	00004517          	auipc	a0,0x4
ffffffffc0200ea0:	7cc50513          	addi	a0,a0,1996 # ffffffffc0205668 <commands+0x740>
    va_pa_offset = KERNBASE - 0x80200000;
ffffffffc0200ea4:	e01c                	sd	a5,0(s0)
    cprintf("physcial memory map:\n");
ffffffffc0200ea6:	a22ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  memory: 0x%08lx, [0x%08lx, 0x%08lx].\n", mem_size, mem_begin,
ffffffffc0200eaa:	44300693          	li	a3,1091
ffffffffc0200eae:	06d6                	slli	a3,a3,0x15
ffffffffc0200eb0:	40100613          	li	a2,1025
ffffffffc0200eb4:	0656                	slli	a2,a2,0x15
ffffffffc0200eb6:	088005b7          	lui	a1,0x8800
ffffffffc0200eba:	16fd                	addi	a3,a3,-1
ffffffffc0200ebc:	00004517          	auipc	a0,0x4
ffffffffc0200ec0:	7c450513          	addi	a0,a0,1988 # ffffffffc0205680 <commands+0x758>
ffffffffc0200ec4:	a04ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0200ec8:	777d                	lui	a4,0xfffff
ffffffffc0200eca:	00034797          	auipc	a5,0x34
ffffffffc0200ece:	f7578793          	addi	a5,a5,-139 # ffffffffc0234e3f <end+0xfff>
ffffffffc0200ed2:	8ff9                	and	a5,a5,a4
    npage = maxpa / PGSIZE;
ffffffffc0200ed4:	00088737          	lui	a4,0x88
ffffffffc0200ed8:	60070713          	addi	a4,a4,1536 # 88600 <_binary_obj___user_rr_out_size+0x7dbf0>
ffffffffc0200edc:	00033597          	auipc	a1,0x33
ffffffffc0200ee0:	ddc58593          	addi	a1,a1,-548 # ffffffffc0233cb8 <npage>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0200ee4:	00033617          	auipc	a2,0x33
ffffffffc0200ee8:	e4c60613          	addi	a2,a2,-436 # ffffffffc0233d30 <pages>
    npage = maxpa / PGSIZE;
ffffffffc0200eec:	e198                	sd	a4,0(a1)
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0200eee:	e21c                	sd	a5,0(a2)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200ef0:	4701                	li	a4,0
 *
 * Note that @nr may be almost arbitrarily large; this function is not
 * restricted to acting on a single-word quantity.
 * */
static inline void set_bit(int nr, volatile void *addr) {
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0200ef2:	4505                	li	a0,1
ffffffffc0200ef4:	fff80837          	lui	a6,0xfff80
ffffffffc0200ef8:	a011                	j	ffffffffc0200efc <pmm_init+0x9a>
ffffffffc0200efa:	621c                	ld	a5,0(a2)
        SetPageReserved(pages + i);
ffffffffc0200efc:	00671693          	slli	a3,a4,0x6
ffffffffc0200f00:	97b6                	add	a5,a5,a3
ffffffffc0200f02:	07a1                	addi	a5,a5,8
ffffffffc0200f04:	40a7b02f          	amoor.d	zero,a0,(a5)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200f08:	0005b883          	ld	a7,0(a1)
ffffffffc0200f0c:	0705                	addi	a4,a4,1
ffffffffc0200f0e:	010886b3          	add	a3,a7,a6
ffffffffc0200f12:	fed764e3          	bltu	a4,a3,ffffffffc0200efa <pmm_init+0x98>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200f16:	6208                	ld	a0,0(a2)
ffffffffc0200f18:	069a                	slli	a3,a3,0x6
ffffffffc0200f1a:	c02007b7          	lui	a5,0xc0200
ffffffffc0200f1e:	96aa                	add	a3,a3,a0
ffffffffc0200f20:	06f6e263          	bltu	a3,a5,ffffffffc0200f84 <pmm_init+0x122>
ffffffffc0200f24:	601c                	ld	a5,0(s0)
    if (freemem < mem_end) {
ffffffffc0200f26:	44300593          	li	a1,1091
ffffffffc0200f2a:	05d6                	slli	a1,a1,0x15
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200f2c:	8e9d                	sub	a3,a3,a5
    if (freemem < mem_end) {
ffffffffc0200f2e:	02b6f363          	bgeu	a3,a1,ffffffffc0200f54 <pmm_init+0xf2>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc0200f32:	6785                	lui	a5,0x1
ffffffffc0200f34:	17fd                	addi	a5,a5,-1
ffffffffc0200f36:	96be                	add	a3,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc0200f38:	00c6d793          	srli	a5,a3,0xc
ffffffffc0200f3c:	0717fc63          	bgeu	a5,a7,ffffffffc0200fb4 <pmm_init+0x152>
    pmm_manager->init_memmap(base, n);
ffffffffc0200f40:	6098                	ld	a4,0(s1)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0200f42:	767d                	lui	a2,0xfffff
ffffffffc0200f44:	8ef1                	and	a3,a3,a2
    }
    return &pages[PPN(pa) - nbase];
ffffffffc0200f46:	97c2                	add	a5,a5,a6
    pmm_manager->init_memmap(base, n);
ffffffffc0200f48:	6b18                	ld	a4,16(a4)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0200f4a:	8d95                	sub	a1,a1,a3
ffffffffc0200f4c:	079a                	slli	a5,a5,0x6
    pmm_manager->init_memmap(base, n);
ffffffffc0200f4e:	81b1                	srli	a1,a1,0xc
ffffffffc0200f50:	953e                	add	a0,a0,a5
ffffffffc0200f52:	9702                	jalr	a4
    // pmm
    //check_alloc_page();

    // create boot_pgdir, an initial page directory(Page Directory Table, PDT)
    extern char boot_page_table_sv39[];
    boot_pgdir = (pte_t*)boot_page_table_sv39;
ffffffffc0200f54:	00008697          	auipc	a3,0x8
ffffffffc0200f58:	0ac68693          	addi	a3,a3,172 # ffffffffc0209000 <boot_page_table_sv39>
ffffffffc0200f5c:	00033797          	auipc	a5,0x33
ffffffffc0200f60:	d4d7ba23          	sd	a3,-684(a5) # ffffffffc0233cb0 <boot_pgdir>
    boot_cr3 = PADDR(boot_pgdir);
ffffffffc0200f64:	c02007b7          	lui	a5,0xc0200
ffffffffc0200f68:	02f6ea63          	bltu	a3,a5,ffffffffc0200f9c <pmm_init+0x13a>
ffffffffc0200f6c:	601c                	ld	a5,0(s0)
    // check the correctness of the basic virtual memory map.
    //check_boot_pgdir();


    kmalloc_init();
}
ffffffffc0200f6e:	6442                	ld	s0,16(sp)
ffffffffc0200f70:	60e2                	ld	ra,24(sp)
ffffffffc0200f72:	64a2                	ld	s1,8(sp)
    boot_cr3 = PADDR(boot_pgdir);
ffffffffc0200f74:	8e9d                	sub	a3,a3,a5
ffffffffc0200f76:	00033797          	auipc	a5,0x33
ffffffffc0200f7a:	dad7b923          	sd	a3,-590(a5) # ffffffffc0233d28 <boot_cr3>
}
ffffffffc0200f7e:	6105                	addi	sp,sp,32
    kmalloc_init();
ffffffffc0200f80:	0f00106f          	j	ffffffffc0202070 <kmalloc_init>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200f84:	00004617          	auipc	a2,0x4
ffffffffc0200f88:	72460613          	addi	a2,a2,1828 # ffffffffc02056a8 <commands+0x780>
ffffffffc0200f8c:	07f00593          	li	a1,127
ffffffffc0200f90:	00004517          	auipc	a0,0x4
ffffffffc0200f94:	74050513          	addi	a0,a0,1856 # ffffffffc02056d0 <commands+0x7a8>
ffffffffc0200f98:	a6cff0ef          	jal	ra,ffffffffc0200204 <__panic>
    boot_cr3 = PADDR(boot_pgdir);
ffffffffc0200f9c:	00004617          	auipc	a2,0x4
ffffffffc0200fa0:	70c60613          	addi	a2,a2,1804 # ffffffffc02056a8 <commands+0x780>
ffffffffc0200fa4:	0c100593          	li	a1,193
ffffffffc0200fa8:	00004517          	auipc	a0,0x4
ffffffffc0200fac:	72850513          	addi	a0,a0,1832 # ffffffffc02056d0 <commands+0x7a8>
ffffffffc0200fb0:	a54ff0ef          	jal	ra,ffffffffc0200204 <__panic>
ffffffffc0200fb4:	d83ff0ef          	jal	ra,ffffffffc0200d36 <pa2page.part.0>

ffffffffc0200fb8 <get_pte>:
     *   PTE_W           0x002                   // page table/directory entry
     * flags bit : Writeable
     *   PTE_U           0x004                   // page table/directory entry
     * flags bit : User can access
     */
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0200fb8:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0200fbc:	1ff7f793          	andi	a5,a5,511
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc0200fc0:	7139                	addi	sp,sp,-64
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0200fc2:	078e                	slli	a5,a5,0x3
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc0200fc4:	f426                	sd	s1,40(sp)
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0200fc6:	00f504b3          	add	s1,a0,a5
    if (!(*pdep1 & PTE_V)) {
ffffffffc0200fca:	6094                	ld	a3,0(s1)
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc0200fcc:	f04a                	sd	s2,32(sp)
ffffffffc0200fce:	ec4e                	sd	s3,24(sp)
ffffffffc0200fd0:	e852                	sd	s4,16(sp)
ffffffffc0200fd2:	fc06                	sd	ra,56(sp)
ffffffffc0200fd4:	f822                	sd	s0,48(sp)
ffffffffc0200fd6:	e456                	sd	s5,8(sp)
ffffffffc0200fd8:	e05a                	sd	s6,0(sp)
    if (!(*pdep1 & PTE_V)) {
ffffffffc0200fda:	0016f793          	andi	a5,a3,1
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc0200fde:	892e                	mv	s2,a1
ffffffffc0200fe0:	89b2                	mv	s3,a2
ffffffffc0200fe2:	00033a17          	auipc	s4,0x33
ffffffffc0200fe6:	cd6a0a13          	addi	s4,s4,-810 # ffffffffc0233cb8 <npage>
    if (!(*pdep1 & PTE_V)) {
ffffffffc0200fea:	e7b5                	bnez	a5,ffffffffc0201056 <get_pte+0x9e>
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL) {
ffffffffc0200fec:	12060b63          	beqz	a2,ffffffffc0201122 <get_pte+0x16a>
ffffffffc0200ff0:	4505                	li	a0,1
ffffffffc0200ff2:	d61ff0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0200ff6:	842a                	mv	s0,a0
ffffffffc0200ff8:	12050563          	beqz	a0,ffffffffc0201122 <get_pte+0x16a>
    return page - pages + nbase;
ffffffffc0200ffc:	00033b17          	auipc	s6,0x33
ffffffffc0201000:	d34b0b13          	addi	s6,s6,-716 # ffffffffc0233d30 <pages>
ffffffffc0201004:	000b3503          	ld	a0,0(s6)
ffffffffc0201008:	00080ab7          	lui	s5,0x80
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc020100c:	00033a17          	auipc	s4,0x33
ffffffffc0201010:	caca0a13          	addi	s4,s4,-852 # ffffffffc0233cb8 <npage>
ffffffffc0201014:	40a40533          	sub	a0,s0,a0
ffffffffc0201018:	8519                	srai	a0,a0,0x6
ffffffffc020101a:	9556                	add	a0,a0,s5
ffffffffc020101c:	000a3703          	ld	a4,0(s4)
ffffffffc0201020:	00c51793          	slli	a5,a0,0xc
    return page->ref;
}

static inline void
set_page_ref(struct Page *page, int val) {
    page->ref = val;
ffffffffc0201024:	4685                	li	a3,1
ffffffffc0201026:	c014                	sw	a3,0(s0)
ffffffffc0201028:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc020102a:	0532                	slli	a0,a0,0xc
ffffffffc020102c:	14e7f263          	bgeu	a5,a4,ffffffffc0201170 <get_pte+0x1b8>
ffffffffc0201030:	00033797          	auipc	a5,0x33
ffffffffc0201034:	cf07b783          	ld	a5,-784(a5) # ffffffffc0233d20 <va_pa_offset>
ffffffffc0201038:	6605                	lui	a2,0x1
ffffffffc020103a:	4581                	li	a1,0
ffffffffc020103c:	953e                	add	a0,a0,a5
ffffffffc020103e:	017030ef          	jal	ra,ffffffffc0204854 <memset>
    return page - pages + nbase;
ffffffffc0201042:	000b3683          	ld	a3,0(s6)
ffffffffc0201046:	40d406b3          	sub	a3,s0,a3
ffffffffc020104a:	8699                	srai	a3,a3,0x6
ffffffffc020104c:	96d6                	add	a3,a3,s5
  asm volatile("sfence.vm");
}

// construct PTE from a page and permission bits
static inline pte_t pte_create(uintptr_t ppn, int type) {
  return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc020104e:	06aa                	slli	a3,a3,0xa
ffffffffc0201050:	0116e693          	ori	a3,a3,17
        *pdep1 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc0201054:	e094                	sd	a3,0(s1)
    }

    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0201056:	77fd                	lui	a5,0xfffff
ffffffffc0201058:	068a                	slli	a3,a3,0x2
ffffffffc020105a:	000a3703          	ld	a4,0(s4)
ffffffffc020105e:	8efd                	and	a3,a3,a5
ffffffffc0201060:	00c6d793          	srli	a5,a3,0xc
ffffffffc0201064:	0ce7f163          	bgeu	a5,a4,ffffffffc0201126 <get_pte+0x16e>
ffffffffc0201068:	00033a97          	auipc	s5,0x33
ffffffffc020106c:	cb8a8a93          	addi	s5,s5,-840 # ffffffffc0233d20 <va_pa_offset>
ffffffffc0201070:	000ab403          	ld	s0,0(s5)
ffffffffc0201074:	01595793          	srli	a5,s2,0x15
ffffffffc0201078:	1ff7f793          	andi	a5,a5,511
ffffffffc020107c:	96a2                	add	a3,a3,s0
ffffffffc020107e:	00379413          	slli	s0,a5,0x3
ffffffffc0201082:	9436                	add	s0,s0,a3
    if (!(*pdep0 & PTE_V)) {
ffffffffc0201084:	6014                	ld	a3,0(s0)
ffffffffc0201086:	0016f793          	andi	a5,a3,1
ffffffffc020108a:	e3ad                	bnez	a5,ffffffffc02010ec <get_pte+0x134>
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL) {
ffffffffc020108c:	08098b63          	beqz	s3,ffffffffc0201122 <get_pte+0x16a>
ffffffffc0201090:	4505                	li	a0,1
ffffffffc0201092:	cc1ff0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0201096:	84aa                	mv	s1,a0
ffffffffc0201098:	c549                	beqz	a0,ffffffffc0201122 <get_pte+0x16a>
    return page - pages + nbase;
ffffffffc020109a:	00033b17          	auipc	s6,0x33
ffffffffc020109e:	c96b0b13          	addi	s6,s6,-874 # ffffffffc0233d30 <pages>
ffffffffc02010a2:	000b3503          	ld	a0,0(s6)
ffffffffc02010a6:	000809b7          	lui	s3,0x80
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc02010aa:	000a3703          	ld	a4,0(s4)
ffffffffc02010ae:	40a48533          	sub	a0,s1,a0
ffffffffc02010b2:	8519                	srai	a0,a0,0x6
ffffffffc02010b4:	954e                	add	a0,a0,s3
ffffffffc02010b6:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc02010ba:	4685                	li	a3,1
ffffffffc02010bc:	c094                	sw	a3,0(s1)
ffffffffc02010be:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc02010c0:	0532                	slli	a0,a0,0xc
ffffffffc02010c2:	08e7fa63          	bgeu	a5,a4,ffffffffc0201156 <get_pte+0x19e>
ffffffffc02010c6:	000ab783          	ld	a5,0(s5)
ffffffffc02010ca:	6605                	lui	a2,0x1
ffffffffc02010cc:	4581                	li	a1,0
ffffffffc02010ce:	953e                	add	a0,a0,a5
ffffffffc02010d0:	784030ef          	jal	ra,ffffffffc0204854 <memset>
    return page - pages + nbase;
ffffffffc02010d4:	000b3683          	ld	a3,0(s6)
ffffffffc02010d8:	40d486b3          	sub	a3,s1,a3
ffffffffc02010dc:	8699                	srai	a3,a3,0x6
ffffffffc02010de:	96ce                	add	a3,a3,s3
  return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc02010e0:	06aa                	slli	a3,a3,0xa
ffffffffc02010e2:	0116e693          	ori	a3,a3,17
        *pdep0 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc02010e6:	e014                	sd	a3,0(s0)
ffffffffc02010e8:	000a3703          	ld	a4,0(s4)
        }
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc02010ec:	068a                	slli	a3,a3,0x2
ffffffffc02010ee:	757d                	lui	a0,0xfffff
ffffffffc02010f0:	8ee9                	and	a3,a3,a0
ffffffffc02010f2:	00c6d793          	srli	a5,a3,0xc
ffffffffc02010f6:	04e7f463          	bgeu	a5,a4,ffffffffc020113e <get_pte+0x186>
ffffffffc02010fa:	000ab503          	ld	a0,0(s5)
ffffffffc02010fe:	00c95913          	srli	s2,s2,0xc
ffffffffc0201102:	1ff97913          	andi	s2,s2,511
ffffffffc0201106:	96aa                	add	a3,a3,a0
ffffffffc0201108:	00391513          	slli	a0,s2,0x3
ffffffffc020110c:	9536                	add	a0,a0,a3
}
ffffffffc020110e:	70e2                	ld	ra,56(sp)
ffffffffc0201110:	7442                	ld	s0,48(sp)
ffffffffc0201112:	74a2                	ld	s1,40(sp)
ffffffffc0201114:	7902                	ld	s2,32(sp)
ffffffffc0201116:	69e2                	ld	s3,24(sp)
ffffffffc0201118:	6a42                	ld	s4,16(sp)
ffffffffc020111a:	6aa2                	ld	s5,8(sp)
ffffffffc020111c:	6b02                	ld	s6,0(sp)
ffffffffc020111e:	6121                	addi	sp,sp,64
ffffffffc0201120:	8082                	ret
            return NULL;
ffffffffc0201122:	4501                	li	a0,0
ffffffffc0201124:	b7ed                	j	ffffffffc020110e <get_pte+0x156>
    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0201126:	00004617          	auipc	a2,0x4
ffffffffc020112a:	5ba60613          	addi	a2,a2,1466 # ffffffffc02056e0 <commands+0x7b8>
ffffffffc020112e:	0fe00593          	li	a1,254
ffffffffc0201132:	00004517          	auipc	a0,0x4
ffffffffc0201136:	59e50513          	addi	a0,a0,1438 # ffffffffc02056d0 <commands+0x7a8>
ffffffffc020113a:	8caff0ef          	jal	ra,ffffffffc0200204 <__panic>
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc020113e:	00004617          	auipc	a2,0x4
ffffffffc0201142:	5a260613          	addi	a2,a2,1442 # ffffffffc02056e0 <commands+0x7b8>
ffffffffc0201146:	10900593          	li	a1,265
ffffffffc020114a:	00004517          	auipc	a0,0x4
ffffffffc020114e:	58650513          	addi	a0,a0,1414 # ffffffffc02056d0 <commands+0x7a8>
ffffffffc0201152:	8b2ff0ef          	jal	ra,ffffffffc0200204 <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0201156:	86aa                	mv	a3,a0
ffffffffc0201158:	00004617          	auipc	a2,0x4
ffffffffc020115c:	58860613          	addi	a2,a2,1416 # ffffffffc02056e0 <commands+0x7b8>
ffffffffc0201160:	10600593          	li	a1,262
ffffffffc0201164:	00004517          	auipc	a0,0x4
ffffffffc0201168:	56c50513          	addi	a0,a0,1388 # ffffffffc02056d0 <commands+0x7a8>
ffffffffc020116c:	898ff0ef          	jal	ra,ffffffffc0200204 <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0201170:	86aa                	mv	a3,a0
ffffffffc0201172:	00004617          	auipc	a2,0x4
ffffffffc0201176:	56e60613          	addi	a2,a2,1390 # ffffffffc02056e0 <commands+0x7b8>
ffffffffc020117a:	0fa00593          	li	a1,250
ffffffffc020117e:	00004517          	auipc	a0,0x4
ffffffffc0201182:	55250513          	addi	a0,a0,1362 # ffffffffc02056d0 <commands+0x7a8>
ffffffffc0201186:	87eff0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020118a <unmap_range>:
        *ptep = 0;                  //(5) clear second page table entry
        tlb_invalidate(pgdir, la);  //(6) flush tlb
    }
}

void unmap_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc020118a:	711d                	addi	sp,sp,-96
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020118c:	00c5e7b3          	or	a5,a1,a2
void unmap_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc0201190:	ec86                	sd	ra,88(sp)
ffffffffc0201192:	e8a2                	sd	s0,80(sp)
ffffffffc0201194:	e4a6                	sd	s1,72(sp)
ffffffffc0201196:	e0ca                	sd	s2,64(sp)
ffffffffc0201198:	fc4e                	sd	s3,56(sp)
ffffffffc020119a:	f852                	sd	s4,48(sp)
ffffffffc020119c:	f456                	sd	s5,40(sp)
ffffffffc020119e:	f05a                	sd	s6,32(sp)
ffffffffc02011a0:	ec5e                	sd	s7,24(sp)
ffffffffc02011a2:	e862                	sd	s8,16(sp)
ffffffffc02011a4:	e466                	sd	s9,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02011a6:	17d2                	slli	a5,a5,0x34
ffffffffc02011a8:	ebf1                	bnez	a5,ffffffffc020127c <unmap_range+0xf2>
    assert(USER_ACCESS(start, end));
ffffffffc02011aa:	002007b7          	lui	a5,0x200
ffffffffc02011ae:	842e                	mv	s0,a1
ffffffffc02011b0:	0af5e663          	bltu	a1,a5,ffffffffc020125c <unmap_range+0xd2>
ffffffffc02011b4:	8932                	mv	s2,a2
ffffffffc02011b6:	0ac5f363          	bgeu	a1,a2,ffffffffc020125c <unmap_range+0xd2>
ffffffffc02011ba:	4785                	li	a5,1
ffffffffc02011bc:	07fe                	slli	a5,a5,0x1f
ffffffffc02011be:	08c7ef63          	bltu	a5,a2,ffffffffc020125c <unmap_range+0xd2>
ffffffffc02011c2:	89aa                	mv	s3,a0
            continue;
        }
        if (*ptep != 0) {
            page_remove_pte(pgdir, start, ptep);
        }
        start += PGSIZE;
ffffffffc02011c4:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage) {
ffffffffc02011c6:	00033c97          	auipc	s9,0x33
ffffffffc02011ca:	af2c8c93          	addi	s9,s9,-1294 # ffffffffc0233cb8 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc02011ce:	00033c17          	auipc	s8,0x33
ffffffffc02011d2:	b62c0c13          	addi	s8,s8,-1182 # ffffffffc0233d30 <pages>
ffffffffc02011d6:	fff80bb7          	lui	s7,0xfff80
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc02011da:	00200b37          	lui	s6,0x200
ffffffffc02011de:	ffe00ab7          	lui	s5,0xffe00
        pte_t *ptep = get_pte(pgdir, start, 0);
ffffffffc02011e2:	4601                	li	a2,0
ffffffffc02011e4:	85a2                	mv	a1,s0
ffffffffc02011e6:	854e                	mv	a0,s3
ffffffffc02011e8:	dd1ff0ef          	jal	ra,ffffffffc0200fb8 <get_pte>
ffffffffc02011ec:	84aa                	mv	s1,a0
        if (ptep == NULL) {
ffffffffc02011ee:	cd21                	beqz	a0,ffffffffc0201246 <unmap_range+0xbc>
        if (*ptep != 0) {
ffffffffc02011f0:	611c                	ld	a5,0(a0)
ffffffffc02011f2:	e38d                	bnez	a5,ffffffffc0201214 <unmap_range+0x8a>
        start += PGSIZE;
ffffffffc02011f4:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc02011f6:	ff2466e3          	bltu	s0,s2,ffffffffc02011e2 <unmap_range+0x58>
}
ffffffffc02011fa:	60e6                	ld	ra,88(sp)
ffffffffc02011fc:	6446                	ld	s0,80(sp)
ffffffffc02011fe:	64a6                	ld	s1,72(sp)
ffffffffc0201200:	6906                	ld	s2,64(sp)
ffffffffc0201202:	79e2                	ld	s3,56(sp)
ffffffffc0201204:	7a42                	ld	s4,48(sp)
ffffffffc0201206:	7aa2                	ld	s5,40(sp)
ffffffffc0201208:	7b02                	ld	s6,32(sp)
ffffffffc020120a:	6be2                	ld	s7,24(sp)
ffffffffc020120c:	6c42                	ld	s8,16(sp)
ffffffffc020120e:	6ca2                	ld	s9,8(sp)
ffffffffc0201210:	6125                	addi	sp,sp,96
ffffffffc0201212:	8082                	ret
    if (*ptep & PTE_V) {  //(1) check if this page table entry is
ffffffffc0201214:	0017f713          	andi	a4,a5,1
ffffffffc0201218:	df71                	beqz	a4,ffffffffc02011f4 <unmap_range+0x6a>
    if (PPN(pa) >= npage) {
ffffffffc020121a:	000cb703          	ld	a4,0(s9)
    return pa2page(PTE_ADDR(pte));
ffffffffc020121e:	078a                	slli	a5,a5,0x2
ffffffffc0201220:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc0201222:	06e7fd63          	bgeu	a5,a4,ffffffffc020129c <unmap_range+0x112>
    return &pages[PPN(pa) - nbase];
ffffffffc0201226:	000c3503          	ld	a0,0(s8)
ffffffffc020122a:	97de                	add	a5,a5,s7
ffffffffc020122c:	079a                	slli	a5,a5,0x6
ffffffffc020122e:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc0201230:	411c                	lw	a5,0(a0)
ffffffffc0201232:	fff7871b          	addiw	a4,a5,-1
ffffffffc0201236:	c118                	sw	a4,0(a0)
        if (page_ref(page) ==
ffffffffc0201238:	cf11                	beqz	a4,ffffffffc0201254 <unmap_range+0xca>
        *ptep = 0;                  //(5) clear second page table entry
ffffffffc020123a:	0004b023          	sd	zero,0(s1)
}

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void tlb_invalidate(pde_t *pgdir, uintptr_t la) {
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc020123e:	12040073          	sfence.vma	s0
        start += PGSIZE;
ffffffffc0201242:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc0201244:	bf4d                	j	ffffffffc02011f6 <unmap_range+0x6c>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc0201246:	945a                	add	s0,s0,s6
ffffffffc0201248:	01547433          	and	s0,s0,s5
    } while (start != 0 && start < end);
ffffffffc020124c:	d45d                	beqz	s0,ffffffffc02011fa <unmap_range+0x70>
ffffffffc020124e:	f9246ae3          	bltu	s0,s2,ffffffffc02011e2 <unmap_range+0x58>
ffffffffc0201252:	b765                	j	ffffffffc02011fa <unmap_range+0x70>
            free_page(page);
ffffffffc0201254:	4585                	li	a1,1
ffffffffc0201256:	b8fff0ef          	jal	ra,ffffffffc0200de4 <free_pages>
ffffffffc020125a:	b7c5                	j	ffffffffc020123a <unmap_range+0xb0>
    assert(USER_ACCESS(start, end));
ffffffffc020125c:	00004697          	auipc	a3,0x4
ffffffffc0201260:	4dc68693          	addi	a3,a3,1244 # ffffffffc0205738 <commands+0x810>
ffffffffc0201264:	00004617          	auipc	a2,0x4
ffffffffc0201268:	0cc60613          	addi	a2,a2,204 # ffffffffc0205330 <commands+0x408>
ffffffffc020126c:	14100593          	li	a1,321
ffffffffc0201270:	00004517          	auipc	a0,0x4
ffffffffc0201274:	46050513          	addi	a0,a0,1120 # ffffffffc02056d0 <commands+0x7a8>
ffffffffc0201278:	f8dfe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020127c:	00004697          	auipc	a3,0x4
ffffffffc0201280:	48c68693          	addi	a3,a3,1164 # ffffffffc0205708 <commands+0x7e0>
ffffffffc0201284:	00004617          	auipc	a2,0x4
ffffffffc0201288:	0ac60613          	addi	a2,a2,172 # ffffffffc0205330 <commands+0x408>
ffffffffc020128c:	14000593          	li	a1,320
ffffffffc0201290:	00004517          	auipc	a0,0x4
ffffffffc0201294:	44050513          	addi	a0,a0,1088 # ffffffffc02056d0 <commands+0x7a8>
ffffffffc0201298:	f6dfe0ef          	jal	ra,ffffffffc0200204 <__panic>
ffffffffc020129c:	a9bff0ef          	jal	ra,ffffffffc0200d36 <pa2page.part.0>

ffffffffc02012a0 <exit_range>:
void exit_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc02012a0:	715d                	addi	sp,sp,-80
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02012a2:	00c5e7b3          	or	a5,a1,a2
void exit_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc02012a6:	e486                	sd	ra,72(sp)
ffffffffc02012a8:	e0a2                	sd	s0,64(sp)
ffffffffc02012aa:	fc26                	sd	s1,56(sp)
ffffffffc02012ac:	f84a                	sd	s2,48(sp)
ffffffffc02012ae:	f44e                	sd	s3,40(sp)
ffffffffc02012b0:	f052                	sd	s4,32(sp)
ffffffffc02012b2:	ec56                	sd	s5,24(sp)
ffffffffc02012b4:	e85a                	sd	s6,16(sp)
ffffffffc02012b6:	e45e                	sd	s7,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02012b8:	17d2                	slli	a5,a5,0x34
ffffffffc02012ba:	e3f1                	bnez	a5,ffffffffc020137e <exit_range+0xde>
    assert(USER_ACCESS(start, end));
ffffffffc02012bc:	002007b7          	lui	a5,0x200
ffffffffc02012c0:	08f5ef63          	bltu	a1,a5,ffffffffc020135e <exit_range+0xbe>
ffffffffc02012c4:	89b2                	mv	s3,a2
ffffffffc02012c6:	08c5fc63          	bgeu	a1,a2,ffffffffc020135e <exit_range+0xbe>
ffffffffc02012ca:	4785                	li	a5,1
    start = ROUNDDOWN(start, PTSIZE);
ffffffffc02012cc:	ffe004b7          	lui	s1,0xffe00
    assert(USER_ACCESS(start, end));
ffffffffc02012d0:	07fe                	slli	a5,a5,0x1f
    start = ROUNDDOWN(start, PTSIZE);
ffffffffc02012d2:	8ced                	and	s1,s1,a1
    assert(USER_ACCESS(start, end));
ffffffffc02012d4:	08c7e563          	bltu	a5,a2,ffffffffc020135e <exit_range+0xbe>
ffffffffc02012d8:	8a2a                	mv	s4,a0
    if (PPN(pa) >= npage) {
ffffffffc02012da:	00033b17          	auipc	s6,0x33
ffffffffc02012de:	9deb0b13          	addi	s6,s6,-1570 # ffffffffc0233cb8 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc02012e2:	00033b97          	auipc	s7,0x33
ffffffffc02012e6:	a4eb8b93          	addi	s7,s7,-1458 # ffffffffc0233d30 <pages>
ffffffffc02012ea:	fff80937          	lui	s2,0xfff80
        start += PTSIZE;
ffffffffc02012ee:	00200ab7          	lui	s5,0x200
ffffffffc02012f2:	a019                	j	ffffffffc02012f8 <exit_range+0x58>
    } while (start != 0 && start < end);
ffffffffc02012f4:	0334fe63          	bgeu	s1,s3,ffffffffc0201330 <exit_range+0x90>
        int pde_idx = PDX1(start);
ffffffffc02012f8:	01e4d413          	srli	s0,s1,0x1e
        if (pgdir[pde_idx] & PTE_V) {
ffffffffc02012fc:	1ff47413          	andi	s0,s0,511
ffffffffc0201300:	040e                	slli	s0,s0,0x3
ffffffffc0201302:	9452                	add	s0,s0,s4
ffffffffc0201304:	601c                	ld	a5,0(s0)
ffffffffc0201306:	0017f713          	andi	a4,a5,1
ffffffffc020130a:	c30d                	beqz	a4,ffffffffc020132c <exit_range+0x8c>
    if (PPN(pa) >= npage) {
ffffffffc020130c:	000b3703          	ld	a4,0(s6)
    return pa2page(PDE_ADDR(pde));
ffffffffc0201310:	078a                	slli	a5,a5,0x2
ffffffffc0201312:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc0201314:	02e7f963          	bgeu	a5,a4,ffffffffc0201346 <exit_range+0xa6>
    return &pages[PPN(pa) - nbase];
ffffffffc0201318:	000bb503          	ld	a0,0(s7)
ffffffffc020131c:	97ca                	add	a5,a5,s2
ffffffffc020131e:	079a                	slli	a5,a5,0x6
            free_page(pde2page(pgdir[pde_idx]));
ffffffffc0201320:	4585                	li	a1,1
ffffffffc0201322:	953e                	add	a0,a0,a5
ffffffffc0201324:	ac1ff0ef          	jal	ra,ffffffffc0200de4 <free_pages>
            pgdir[pde_idx] = 0;
ffffffffc0201328:	00043023          	sd	zero,0(s0)
        start += PTSIZE;
ffffffffc020132c:	94d6                	add	s1,s1,s5
    } while (start != 0 && start < end);
ffffffffc020132e:	f0f9                	bnez	s1,ffffffffc02012f4 <exit_range+0x54>
}
ffffffffc0201330:	60a6                	ld	ra,72(sp)
ffffffffc0201332:	6406                	ld	s0,64(sp)
ffffffffc0201334:	74e2                	ld	s1,56(sp)
ffffffffc0201336:	7942                	ld	s2,48(sp)
ffffffffc0201338:	79a2                	ld	s3,40(sp)
ffffffffc020133a:	7a02                	ld	s4,32(sp)
ffffffffc020133c:	6ae2                	ld	s5,24(sp)
ffffffffc020133e:	6b42                	ld	s6,16(sp)
ffffffffc0201340:	6ba2                	ld	s7,8(sp)
ffffffffc0201342:	6161                	addi	sp,sp,80
ffffffffc0201344:	8082                	ret
        panic("pa2page called with invalid pa");
ffffffffc0201346:	00004617          	auipc	a2,0x4
ffffffffc020134a:	2da60613          	addi	a2,a2,730 # ffffffffc0205620 <commands+0x6f8>
ffffffffc020134e:	06200593          	li	a1,98
ffffffffc0201352:	00004517          	auipc	a0,0x4
ffffffffc0201356:	2ee50513          	addi	a0,a0,750 # ffffffffc0205640 <commands+0x718>
ffffffffc020135a:	eabfe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc020135e:	00004697          	auipc	a3,0x4
ffffffffc0201362:	3da68693          	addi	a3,a3,986 # ffffffffc0205738 <commands+0x810>
ffffffffc0201366:	00004617          	auipc	a2,0x4
ffffffffc020136a:	fca60613          	addi	a2,a2,-54 # ffffffffc0205330 <commands+0x408>
ffffffffc020136e:	15200593          	li	a1,338
ffffffffc0201372:	00004517          	auipc	a0,0x4
ffffffffc0201376:	35e50513          	addi	a0,a0,862 # ffffffffc02056d0 <commands+0x7a8>
ffffffffc020137a:	e8bfe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020137e:	00004697          	auipc	a3,0x4
ffffffffc0201382:	38a68693          	addi	a3,a3,906 # ffffffffc0205708 <commands+0x7e0>
ffffffffc0201386:	00004617          	auipc	a2,0x4
ffffffffc020138a:	faa60613          	addi	a2,a2,-86 # ffffffffc0205330 <commands+0x408>
ffffffffc020138e:	15100593          	li	a1,337
ffffffffc0201392:	00004517          	auipc	a0,0x4
ffffffffc0201396:	33e50513          	addi	a0,a0,830 # ffffffffc02056d0 <commands+0x7a8>
ffffffffc020139a:	e6bfe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020139e <page_insert>:
int page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
ffffffffc020139e:	7179                	addi	sp,sp,-48
ffffffffc02013a0:	e44e                	sd	s3,8(sp)
ffffffffc02013a2:	89b2                	mv	s3,a2
ffffffffc02013a4:	f022                	sd	s0,32(sp)
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc02013a6:	4605                	li	a2,1
int page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
ffffffffc02013a8:	842e                	mv	s0,a1
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc02013aa:	85ce                	mv	a1,s3
int page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
ffffffffc02013ac:	ec26                	sd	s1,24(sp)
ffffffffc02013ae:	f406                	sd	ra,40(sp)
ffffffffc02013b0:	e84a                	sd	s2,16(sp)
ffffffffc02013b2:	e052                	sd	s4,0(sp)
ffffffffc02013b4:	84b6                	mv	s1,a3
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc02013b6:	c03ff0ef          	jal	ra,ffffffffc0200fb8 <get_pte>
    if (ptep == NULL) {
ffffffffc02013ba:	cd41                	beqz	a0,ffffffffc0201452 <page_insert+0xb4>
    page->ref += 1;
ffffffffc02013bc:	4014                	lw	a3,0(s0)
    if (*ptep & PTE_V) {
ffffffffc02013be:	611c                	ld	a5,0(a0)
ffffffffc02013c0:	892a                	mv	s2,a0
ffffffffc02013c2:	0016871b          	addiw	a4,a3,1
ffffffffc02013c6:	c018                	sw	a4,0(s0)
ffffffffc02013c8:	0017f713          	andi	a4,a5,1
ffffffffc02013cc:	eb1d                	bnez	a4,ffffffffc0201402 <page_insert+0x64>
ffffffffc02013ce:	00033717          	auipc	a4,0x33
ffffffffc02013d2:	96273703          	ld	a4,-1694(a4) # ffffffffc0233d30 <pages>
    return page - pages + nbase;
ffffffffc02013d6:	8c19                	sub	s0,s0,a4
ffffffffc02013d8:	000807b7          	lui	a5,0x80
ffffffffc02013dc:	8419                	srai	s0,s0,0x6
ffffffffc02013de:	943e                	add	s0,s0,a5
  return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc02013e0:	042a                	slli	s0,s0,0xa
ffffffffc02013e2:	8c45                	or	s0,s0,s1
ffffffffc02013e4:	00146413          	ori	s0,s0,1
    *ptep = pte_create(page2ppn(page), PTE_V | perm);
ffffffffc02013e8:	00893023          	sd	s0,0(s2) # fffffffffff80000 <end+0x3fd4c1c0>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02013ec:	12098073          	sfence.vma	s3
    return 0;
ffffffffc02013f0:	4501                	li	a0,0
}
ffffffffc02013f2:	70a2                	ld	ra,40(sp)
ffffffffc02013f4:	7402                	ld	s0,32(sp)
ffffffffc02013f6:	64e2                	ld	s1,24(sp)
ffffffffc02013f8:	6942                	ld	s2,16(sp)
ffffffffc02013fa:	69a2                	ld	s3,8(sp)
ffffffffc02013fc:	6a02                	ld	s4,0(sp)
ffffffffc02013fe:	6145                	addi	sp,sp,48
ffffffffc0201400:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc0201402:	078a                	slli	a5,a5,0x2
ffffffffc0201404:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc0201406:	00033717          	auipc	a4,0x33
ffffffffc020140a:	8b273703          	ld	a4,-1870(a4) # ffffffffc0233cb8 <npage>
ffffffffc020140e:	04e7f463          	bgeu	a5,a4,ffffffffc0201456 <page_insert+0xb8>
    return &pages[PPN(pa) - nbase];
ffffffffc0201412:	00033a17          	auipc	s4,0x33
ffffffffc0201416:	91ea0a13          	addi	s4,s4,-1762 # ffffffffc0233d30 <pages>
ffffffffc020141a:	000a3703          	ld	a4,0(s4)
ffffffffc020141e:	fff80537          	lui	a0,0xfff80
ffffffffc0201422:	97aa                	add	a5,a5,a0
ffffffffc0201424:	079a                	slli	a5,a5,0x6
ffffffffc0201426:	97ba                	add	a5,a5,a4
        if (p == page) {
ffffffffc0201428:	00f40a63          	beq	s0,a5,ffffffffc020143c <page_insert+0x9e>
    page->ref -= 1;
ffffffffc020142c:	4394                	lw	a3,0(a5)
ffffffffc020142e:	fff6861b          	addiw	a2,a3,-1
ffffffffc0201432:	c390                	sw	a2,0(a5)
        if (page_ref(page) ==
ffffffffc0201434:	c611                	beqz	a2,ffffffffc0201440 <page_insert+0xa2>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0201436:	12098073          	sfence.vma	s3
}
ffffffffc020143a:	bf71                	j	ffffffffc02013d6 <page_insert+0x38>
ffffffffc020143c:	c014                	sw	a3,0(s0)
    return page->ref;
ffffffffc020143e:	bf61                	j	ffffffffc02013d6 <page_insert+0x38>
            free_page(page);
ffffffffc0201440:	4585                	li	a1,1
ffffffffc0201442:	853e                	mv	a0,a5
ffffffffc0201444:	9a1ff0ef          	jal	ra,ffffffffc0200de4 <free_pages>
ffffffffc0201448:	000a3703          	ld	a4,0(s4)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc020144c:	12098073          	sfence.vma	s3
ffffffffc0201450:	b759                	j	ffffffffc02013d6 <page_insert+0x38>
        return -E_NO_MEM;
ffffffffc0201452:	5571                	li	a0,-4
ffffffffc0201454:	bf79                	j	ffffffffc02013f2 <page_insert+0x54>
ffffffffc0201456:	8e1ff0ef          	jal	ra,ffffffffc0200d36 <pa2page.part.0>

ffffffffc020145a <copy_range>:
               bool share) {
ffffffffc020145a:	7159                	addi	sp,sp,-112
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020145c:	00d667b3          	or	a5,a2,a3
               bool share) {
ffffffffc0201460:	f486                	sd	ra,104(sp)
ffffffffc0201462:	f0a2                	sd	s0,96(sp)
ffffffffc0201464:	eca6                	sd	s1,88(sp)
ffffffffc0201466:	e8ca                	sd	s2,80(sp)
ffffffffc0201468:	e4ce                	sd	s3,72(sp)
ffffffffc020146a:	e0d2                	sd	s4,64(sp)
ffffffffc020146c:	fc56                	sd	s5,56(sp)
ffffffffc020146e:	f85a                	sd	s6,48(sp)
ffffffffc0201470:	f45e                	sd	s7,40(sp)
ffffffffc0201472:	f062                	sd	s8,32(sp)
ffffffffc0201474:	ec66                	sd	s9,24(sp)
ffffffffc0201476:	e86a                	sd	s10,16(sp)
ffffffffc0201478:	e46e                	sd	s11,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020147a:	17d2                	slli	a5,a5,0x34
ffffffffc020147c:	1e079763          	bnez	a5,ffffffffc020166a <copy_range+0x210>
    assert(USER_ACCESS(start, end));
ffffffffc0201480:	002007b7          	lui	a5,0x200
ffffffffc0201484:	8432                	mv	s0,a2
ffffffffc0201486:	16f66a63          	bltu	a2,a5,ffffffffc02015fa <copy_range+0x1a0>
ffffffffc020148a:	8936                	mv	s2,a3
ffffffffc020148c:	16d67763          	bgeu	a2,a3,ffffffffc02015fa <copy_range+0x1a0>
ffffffffc0201490:	4785                	li	a5,1
ffffffffc0201492:	07fe                	slli	a5,a5,0x1f
ffffffffc0201494:	16d7e363          	bltu	a5,a3,ffffffffc02015fa <copy_range+0x1a0>
    return KADDR(page2pa(page));
ffffffffc0201498:	5b7d                	li	s6,-1
ffffffffc020149a:	8aaa                	mv	s5,a0
ffffffffc020149c:	89ae                	mv	s3,a1
        start += PGSIZE;
ffffffffc020149e:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage) {
ffffffffc02014a0:	00033c97          	auipc	s9,0x33
ffffffffc02014a4:	818c8c93          	addi	s9,s9,-2024 # ffffffffc0233cb8 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc02014a8:	00033c17          	auipc	s8,0x33
ffffffffc02014ac:	888c0c13          	addi	s8,s8,-1912 # ffffffffc0233d30 <pages>
    return page - pages + nbase;
ffffffffc02014b0:	00080bb7          	lui	s7,0x80
    return KADDR(page2pa(page));
ffffffffc02014b4:	00cb5b13          	srli	s6,s6,0xc
        pte_t *ptep = get_pte(from, start, 0), *nptep;
ffffffffc02014b8:	4601                	li	a2,0
ffffffffc02014ba:	85a2                	mv	a1,s0
ffffffffc02014bc:	854e                	mv	a0,s3
ffffffffc02014be:	afbff0ef          	jal	ra,ffffffffc0200fb8 <get_pte>
ffffffffc02014c2:	84aa                	mv	s1,a0
        if (ptep == NULL) {
ffffffffc02014c4:	c175                	beqz	a0,ffffffffc02015a8 <copy_range+0x14e>
        if (*ptep & PTE_V) {
ffffffffc02014c6:	611c                	ld	a5,0(a0)
ffffffffc02014c8:	8b85                	andi	a5,a5,1
ffffffffc02014ca:	e785                	bnez	a5,ffffffffc02014f2 <copy_range+0x98>
        start += PGSIZE;
ffffffffc02014cc:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc02014ce:	ff2465e3          	bltu	s0,s2,ffffffffc02014b8 <copy_range+0x5e>
    return 0;
ffffffffc02014d2:	4501                	li	a0,0
}
ffffffffc02014d4:	70a6                	ld	ra,104(sp)
ffffffffc02014d6:	7406                	ld	s0,96(sp)
ffffffffc02014d8:	64e6                	ld	s1,88(sp)
ffffffffc02014da:	6946                	ld	s2,80(sp)
ffffffffc02014dc:	69a6                	ld	s3,72(sp)
ffffffffc02014de:	6a06                	ld	s4,64(sp)
ffffffffc02014e0:	7ae2                	ld	s5,56(sp)
ffffffffc02014e2:	7b42                	ld	s6,48(sp)
ffffffffc02014e4:	7ba2                	ld	s7,40(sp)
ffffffffc02014e6:	7c02                	ld	s8,32(sp)
ffffffffc02014e8:	6ce2                	ld	s9,24(sp)
ffffffffc02014ea:	6d42                	ld	s10,16(sp)
ffffffffc02014ec:	6da2                	ld	s11,8(sp)
ffffffffc02014ee:	6165                	addi	sp,sp,112
ffffffffc02014f0:	8082                	ret
            if ((nptep = get_pte(to, start, 1)) == NULL) {
ffffffffc02014f2:	4605                	li	a2,1
ffffffffc02014f4:	85a2                	mv	a1,s0
ffffffffc02014f6:	8556                	mv	a0,s5
ffffffffc02014f8:	ac1ff0ef          	jal	ra,ffffffffc0200fb8 <get_pte>
ffffffffc02014fc:	c161                	beqz	a0,ffffffffc02015bc <copy_range+0x162>
            uint32_t perm = (*ptep & PTE_USER);
ffffffffc02014fe:	609c                	ld	a5,0(s1)
    if (!(pte & PTE_V)) {
ffffffffc0201500:	0017f713          	andi	a4,a5,1
ffffffffc0201504:	01f7f493          	andi	s1,a5,31
ffffffffc0201508:	14070563          	beqz	a4,ffffffffc0201652 <copy_range+0x1f8>
    if (PPN(pa) >= npage) {
ffffffffc020150c:	000cb683          	ld	a3,0(s9)
    return pa2page(PTE_ADDR(pte));
ffffffffc0201510:	078a                	slli	a5,a5,0x2
ffffffffc0201512:	00c7d713          	srli	a4,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc0201516:	12d77263          	bgeu	a4,a3,ffffffffc020163a <copy_range+0x1e0>
    return &pages[PPN(pa) - nbase];
ffffffffc020151a:	000c3783          	ld	a5,0(s8)
ffffffffc020151e:	fff806b7          	lui	a3,0xfff80
ffffffffc0201522:	9736                	add	a4,a4,a3
ffffffffc0201524:	071a                	slli	a4,a4,0x6
            struct Page *npage = alloc_page();
ffffffffc0201526:	4505                	li	a0,1
ffffffffc0201528:	00e78db3          	add	s11,a5,a4
ffffffffc020152c:	827ff0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0201530:	8d2a                	mv	s10,a0
            assert(page != NULL);
ffffffffc0201532:	0a0d8463          	beqz	s11,ffffffffc02015da <copy_range+0x180>
            assert(npage != NULL);
ffffffffc0201536:	c175                	beqz	a0,ffffffffc020161a <copy_range+0x1c0>
    return page - pages + nbase;
ffffffffc0201538:	000c3703          	ld	a4,0(s8)
    return KADDR(page2pa(page));
ffffffffc020153c:	000cb603          	ld	a2,0(s9)
    return page - pages + nbase;
ffffffffc0201540:	40ed86b3          	sub	a3,s11,a4
ffffffffc0201544:	8699                	srai	a3,a3,0x6
ffffffffc0201546:	96de                	add	a3,a3,s7
    return KADDR(page2pa(page));
ffffffffc0201548:	0166f7b3          	and	a5,a3,s6
    return page2ppn(page) << PGSHIFT;
ffffffffc020154c:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc020154e:	06c7fa63          	bgeu	a5,a2,ffffffffc02015c2 <copy_range+0x168>
    return page - pages + nbase;
ffffffffc0201552:	40e507b3          	sub	a5,a0,a4
    return KADDR(page2pa(page));
ffffffffc0201556:	00032717          	auipc	a4,0x32
ffffffffc020155a:	7ca70713          	addi	a4,a4,1994 # ffffffffc0233d20 <va_pa_offset>
ffffffffc020155e:	6308                	ld	a0,0(a4)
    return page - pages + nbase;
ffffffffc0201560:	8799                	srai	a5,a5,0x6
ffffffffc0201562:	97de                	add	a5,a5,s7
    return KADDR(page2pa(page));
ffffffffc0201564:	0167f733          	and	a4,a5,s6
ffffffffc0201568:	00a685b3          	add	a1,a3,a0
    return page2ppn(page) << PGSHIFT;
ffffffffc020156c:	07b2                	slli	a5,a5,0xc
    return KADDR(page2pa(page));
ffffffffc020156e:	04c77963          	bgeu	a4,a2,ffffffffc02015c0 <copy_range+0x166>
            memcpy(kva_dst, kva_src, PGSIZE);
ffffffffc0201572:	6605                	lui	a2,0x1
ffffffffc0201574:	953e                	add	a0,a0,a5
ffffffffc0201576:	2f0030ef          	jal	ra,ffffffffc0204866 <memcpy>
            ret = page_insert(to, npage, start, perm);
ffffffffc020157a:	86a6                	mv	a3,s1
ffffffffc020157c:	8622                	mv	a2,s0
ffffffffc020157e:	85ea                	mv	a1,s10
ffffffffc0201580:	8556                	mv	a0,s5
ffffffffc0201582:	e1dff0ef          	jal	ra,ffffffffc020139e <page_insert>
            assert(ret == 0);
ffffffffc0201586:	d139                	beqz	a0,ffffffffc02014cc <copy_range+0x72>
ffffffffc0201588:	00004697          	auipc	a3,0x4
ffffffffc020158c:	21068693          	addi	a3,a3,528 # ffffffffc0205798 <commands+0x870>
ffffffffc0201590:	00004617          	auipc	a2,0x4
ffffffffc0201594:	da060613          	addi	a2,a2,-608 # ffffffffc0205330 <commands+0x408>
ffffffffc0201598:	19900593          	li	a1,409
ffffffffc020159c:	00004517          	auipc	a0,0x4
ffffffffc02015a0:	13450513          	addi	a0,a0,308 # ffffffffc02056d0 <commands+0x7a8>
ffffffffc02015a4:	c61fe0ef          	jal	ra,ffffffffc0200204 <__panic>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc02015a8:	00200637          	lui	a2,0x200
ffffffffc02015ac:	9432                	add	s0,s0,a2
ffffffffc02015ae:	ffe00637          	lui	a2,0xffe00
ffffffffc02015b2:	8c71                	and	s0,s0,a2
    } while (start != 0 && start < end);
ffffffffc02015b4:	dc19                	beqz	s0,ffffffffc02014d2 <copy_range+0x78>
ffffffffc02015b6:	f12461e3          	bltu	s0,s2,ffffffffc02014b8 <copy_range+0x5e>
ffffffffc02015ba:	bf21                	j	ffffffffc02014d2 <copy_range+0x78>
                return -E_NO_MEM;
ffffffffc02015bc:	5571                	li	a0,-4
ffffffffc02015be:	bf19                	j	ffffffffc02014d4 <copy_range+0x7a>
ffffffffc02015c0:	86be                	mv	a3,a5
ffffffffc02015c2:	00004617          	auipc	a2,0x4
ffffffffc02015c6:	11e60613          	addi	a2,a2,286 # ffffffffc02056e0 <commands+0x7b8>
ffffffffc02015ca:	06900593          	li	a1,105
ffffffffc02015ce:	00004517          	auipc	a0,0x4
ffffffffc02015d2:	07250513          	addi	a0,a0,114 # ffffffffc0205640 <commands+0x718>
ffffffffc02015d6:	c2ffe0ef          	jal	ra,ffffffffc0200204 <__panic>
            assert(page != NULL);
ffffffffc02015da:	00004697          	auipc	a3,0x4
ffffffffc02015de:	19e68693          	addi	a3,a3,414 # ffffffffc0205778 <commands+0x850>
ffffffffc02015e2:	00004617          	auipc	a2,0x4
ffffffffc02015e6:	d4e60613          	addi	a2,a2,-690 # ffffffffc0205330 <commands+0x408>
ffffffffc02015ea:	17e00593          	li	a1,382
ffffffffc02015ee:	00004517          	auipc	a0,0x4
ffffffffc02015f2:	0e250513          	addi	a0,a0,226 # ffffffffc02056d0 <commands+0x7a8>
ffffffffc02015f6:	c0ffe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc02015fa:	00004697          	auipc	a3,0x4
ffffffffc02015fe:	13e68693          	addi	a3,a3,318 # ffffffffc0205738 <commands+0x810>
ffffffffc0201602:	00004617          	auipc	a2,0x4
ffffffffc0201606:	d2e60613          	addi	a2,a2,-722 # ffffffffc0205330 <commands+0x408>
ffffffffc020160a:	16a00593          	li	a1,362
ffffffffc020160e:	00004517          	auipc	a0,0x4
ffffffffc0201612:	0c250513          	addi	a0,a0,194 # ffffffffc02056d0 <commands+0x7a8>
ffffffffc0201616:	beffe0ef          	jal	ra,ffffffffc0200204 <__panic>
            assert(npage != NULL);
ffffffffc020161a:	00004697          	auipc	a3,0x4
ffffffffc020161e:	16e68693          	addi	a3,a3,366 # ffffffffc0205788 <commands+0x860>
ffffffffc0201622:	00004617          	auipc	a2,0x4
ffffffffc0201626:	d0e60613          	addi	a2,a2,-754 # ffffffffc0205330 <commands+0x408>
ffffffffc020162a:	17f00593          	li	a1,383
ffffffffc020162e:	00004517          	auipc	a0,0x4
ffffffffc0201632:	0a250513          	addi	a0,a0,162 # ffffffffc02056d0 <commands+0x7a8>
ffffffffc0201636:	bcffe0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc020163a:	00004617          	auipc	a2,0x4
ffffffffc020163e:	fe660613          	addi	a2,a2,-26 # ffffffffc0205620 <commands+0x6f8>
ffffffffc0201642:	06200593          	li	a1,98
ffffffffc0201646:	00004517          	auipc	a0,0x4
ffffffffc020164a:	ffa50513          	addi	a0,a0,-6 # ffffffffc0205640 <commands+0x718>
ffffffffc020164e:	bb7fe0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("pte2page called with invalid pte");
ffffffffc0201652:	00004617          	auipc	a2,0x4
ffffffffc0201656:	0fe60613          	addi	a2,a2,254 # ffffffffc0205750 <commands+0x828>
ffffffffc020165a:	07400593          	li	a1,116
ffffffffc020165e:	00004517          	auipc	a0,0x4
ffffffffc0201662:	fe250513          	addi	a0,a0,-30 # ffffffffc0205640 <commands+0x718>
ffffffffc0201666:	b9ffe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020166a:	00004697          	auipc	a3,0x4
ffffffffc020166e:	09e68693          	addi	a3,a3,158 # ffffffffc0205708 <commands+0x7e0>
ffffffffc0201672:	00004617          	auipc	a2,0x4
ffffffffc0201676:	cbe60613          	addi	a2,a2,-834 # ffffffffc0205330 <commands+0x408>
ffffffffc020167a:	16900593          	li	a1,361
ffffffffc020167e:	00004517          	auipc	a0,0x4
ffffffffc0201682:	05250513          	addi	a0,a0,82 # ffffffffc02056d0 <commands+0x7a8>
ffffffffc0201686:	b7ffe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020168a <tlb_invalidate>:
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc020168a:	12058073          	sfence.vma	a1
}
ffffffffc020168e:	8082                	ret

ffffffffc0201690 <pgdir_alloc_page>:

// pgdir_alloc_page - call alloc_page & page_insert functions to
//                  - allocate a page size memory & setup an addr map
//                  - pa<->la with linear address la and the PDT pgdir
struct Page *pgdir_alloc_page(pde_t *pgdir, uintptr_t la, uint32_t perm) {
ffffffffc0201690:	7179                	addi	sp,sp,-48
ffffffffc0201692:	e84a                	sd	s2,16(sp)
ffffffffc0201694:	892a                	mv	s2,a0
    struct Page *page = alloc_page();
ffffffffc0201696:	4505                	li	a0,1
struct Page *pgdir_alloc_page(pde_t *pgdir, uintptr_t la, uint32_t perm) {
ffffffffc0201698:	f022                	sd	s0,32(sp)
ffffffffc020169a:	ec26                	sd	s1,24(sp)
ffffffffc020169c:	e44e                	sd	s3,8(sp)
ffffffffc020169e:	f406                	sd	ra,40(sp)
ffffffffc02016a0:	84ae                	mv	s1,a1
ffffffffc02016a2:	89b2                	mv	s3,a2
    struct Page *page = alloc_page();
ffffffffc02016a4:	eaeff0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc02016a8:	842a                	mv	s0,a0
    if (page != NULL) {
ffffffffc02016aa:	cd05                	beqz	a0,ffffffffc02016e2 <pgdir_alloc_page+0x52>
        if (page_insert(pgdir, page, la, perm) != 0) {
ffffffffc02016ac:	85aa                	mv	a1,a0
ffffffffc02016ae:	86ce                	mv	a3,s3
ffffffffc02016b0:	8626                	mv	a2,s1
ffffffffc02016b2:	854a                	mv	a0,s2
ffffffffc02016b4:	cebff0ef          	jal	ra,ffffffffc020139e <page_insert>
ffffffffc02016b8:	ed0d                	bnez	a0,ffffffffc02016f2 <pgdir_alloc_page+0x62>
            free_page(page);
            return NULL;
        }
        if (swap_init_ok) {
ffffffffc02016ba:	00032797          	auipc	a5,0x32
ffffffffc02016be:	6167a783          	lw	a5,1558(a5) # ffffffffc0233cd0 <swap_init_ok>
ffffffffc02016c2:	c385                	beqz	a5,ffffffffc02016e2 <pgdir_alloc_page+0x52>
            if (check_mm_struct != NULL) {
ffffffffc02016c4:	00032517          	auipc	a0,0x32
ffffffffc02016c8:	67453503          	ld	a0,1652(a0) # ffffffffc0233d38 <check_mm_struct>
ffffffffc02016cc:	c919                	beqz	a0,ffffffffc02016e2 <pgdir_alloc_page+0x52>
                swap_map_swappable(check_mm_struct, la, page, 0);
ffffffffc02016ce:	4681                	li	a3,0
ffffffffc02016d0:	8622                	mv	a2,s0
ffffffffc02016d2:	85a6                	mv	a1,s1
ffffffffc02016d4:	604000ef          	jal	ra,ffffffffc0201cd8 <swap_map_swappable>
                page->pra_vaddr = la;
                assert(page_ref(page) == 1);
ffffffffc02016d8:	4018                	lw	a4,0(s0)
                page->pra_vaddr = la;
ffffffffc02016da:	fc04                	sd	s1,56(s0)
                assert(page_ref(page) == 1);
ffffffffc02016dc:	4785                	li	a5,1
ffffffffc02016de:	02f71063          	bne	a4,a5,ffffffffc02016fe <pgdir_alloc_page+0x6e>
            }
        }
    }

    return page;
}
ffffffffc02016e2:	70a2                	ld	ra,40(sp)
ffffffffc02016e4:	8522                	mv	a0,s0
ffffffffc02016e6:	7402                	ld	s0,32(sp)
ffffffffc02016e8:	64e2                	ld	s1,24(sp)
ffffffffc02016ea:	6942                	ld	s2,16(sp)
ffffffffc02016ec:	69a2                	ld	s3,8(sp)
ffffffffc02016ee:	6145                	addi	sp,sp,48
ffffffffc02016f0:	8082                	ret
            free_page(page);
ffffffffc02016f2:	8522                	mv	a0,s0
ffffffffc02016f4:	4585                	li	a1,1
ffffffffc02016f6:	eeeff0ef          	jal	ra,ffffffffc0200de4 <free_pages>
            return NULL;
ffffffffc02016fa:	4401                	li	s0,0
ffffffffc02016fc:	b7dd                	j	ffffffffc02016e2 <pgdir_alloc_page+0x52>
                assert(page_ref(page) == 1);
ffffffffc02016fe:	00004697          	auipc	a3,0x4
ffffffffc0201702:	0aa68693          	addi	a3,a3,170 # ffffffffc02057a8 <commands+0x880>
ffffffffc0201706:	00004617          	auipc	a2,0x4
ffffffffc020170a:	c2a60613          	addi	a2,a2,-982 # ffffffffc0205330 <commands+0x408>
ffffffffc020170e:	1d800593          	li	a1,472
ffffffffc0201712:	00004517          	auipc	a0,0x4
ffffffffc0201716:	fbe50513          	addi	a0,a0,-66 # ffffffffc02056d0 <commands+0x7a8>
ffffffffc020171a:	aebfe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020171e <check_vma_overlap.isra.0.part.0>:
}


// check_vma_overlap - check if vma1 overlaps vma2 ?
static inline void
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next) {
ffffffffc020171e:	1141                	addi	sp,sp,-16
    assert(prev->vm_start < prev->vm_end);
    assert(prev->vm_end <= next->vm_start);
    assert(next->vm_start < next->vm_end);
ffffffffc0201720:	00004697          	auipc	a3,0x4
ffffffffc0201724:	0a068693          	addi	a3,a3,160 # ffffffffc02057c0 <commands+0x898>
ffffffffc0201728:	00004617          	auipc	a2,0x4
ffffffffc020172c:	c0860613          	addi	a2,a2,-1016 # ffffffffc0205330 <commands+0x408>
ffffffffc0201730:	06d00593          	li	a1,109
ffffffffc0201734:	00004517          	auipc	a0,0x4
ffffffffc0201738:	0ac50513          	addi	a0,a0,172 # ffffffffc02057e0 <commands+0x8b8>
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next) {
ffffffffc020173c:	e406                	sd	ra,8(sp)
    assert(next->vm_start < next->vm_end);
ffffffffc020173e:	ac7fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201742 <mm_create>:
mm_create(void) {
ffffffffc0201742:	1141                	addi	sp,sp,-16
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0201744:	04000513          	li	a0,64
mm_create(void) {
ffffffffc0201748:	e022                	sd	s0,0(sp)
ffffffffc020174a:	e406                	sd	ra,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc020174c:	12b000ef          	jal	ra,ffffffffc0202076 <kmalloc>
ffffffffc0201750:	842a                	mv	s0,a0
    if (mm != NULL) {
ffffffffc0201752:	c505                	beqz	a0,ffffffffc020177a <mm_create+0x38>
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc0201754:	e408                	sd	a0,8(s0)
ffffffffc0201756:	e008                	sd	a0,0(s0)
        mm->mmap_cache = NULL;
ffffffffc0201758:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc020175c:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc0201760:	02052023          	sw	zero,32(a0)
        if (swap_init_ok) swap_init_mm(mm);
ffffffffc0201764:	00032797          	auipc	a5,0x32
ffffffffc0201768:	56c7a783          	lw	a5,1388(a5) # ffffffffc0233cd0 <swap_init_ok>
ffffffffc020176c:	ef81                	bnez	a5,ffffffffc0201784 <mm_create+0x42>
        else mm->sm_priv = NULL;
ffffffffc020176e:	02053423          	sd	zero,40(a0)
    return mm->mm_count;
}

static inline void
set_mm_count(struct mm_struct *mm, int val) {
    mm->mm_count = val;
ffffffffc0201772:	02042823          	sw	zero,48(s0)

typedef volatile bool lock_t;

static inline void
lock_init(lock_t *lock) {
    *lock = 0;
ffffffffc0201776:	02043c23          	sd	zero,56(s0)
}
ffffffffc020177a:	60a2                	ld	ra,8(sp)
ffffffffc020177c:	8522                	mv	a0,s0
ffffffffc020177e:	6402                	ld	s0,0(sp)
ffffffffc0201780:	0141                	addi	sp,sp,16
ffffffffc0201782:	8082                	ret
        if (swap_init_ok) swap_init_mm(mm);
ffffffffc0201784:	546000ef          	jal	ra,ffffffffc0201cca <swap_init_mm>
ffffffffc0201788:	b7ed                	j	ffffffffc0201772 <mm_create+0x30>

ffffffffc020178a <find_vma>:
find_vma(struct mm_struct *mm, uintptr_t addr) {
ffffffffc020178a:	86aa                	mv	a3,a0
    if (mm != NULL) {
ffffffffc020178c:	c505                	beqz	a0,ffffffffc02017b4 <find_vma+0x2a>
        vma = mm->mmap_cache;
ffffffffc020178e:	6908                	ld	a0,16(a0)
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr)) {
ffffffffc0201790:	c501                	beqz	a0,ffffffffc0201798 <find_vma+0xe>
ffffffffc0201792:	651c                	ld	a5,8(a0)
ffffffffc0201794:	02f5f263          	bgeu	a1,a5,ffffffffc02017b8 <find_vma+0x2e>
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc0201798:	669c                	ld	a5,8(a3)
                while ((le = list_next(le)) != list) {
ffffffffc020179a:	00f68d63          	beq	a3,a5,ffffffffc02017b4 <find_vma+0x2a>
                    if (vma->vm_start<=addr && addr < vma->vm_end) {
ffffffffc020179e:	fe87b703          	ld	a4,-24(a5)
ffffffffc02017a2:	00e5e663          	bltu	a1,a4,ffffffffc02017ae <find_vma+0x24>
ffffffffc02017a6:	ff07b703          	ld	a4,-16(a5)
ffffffffc02017aa:	00e5ec63          	bltu	a1,a4,ffffffffc02017c2 <find_vma+0x38>
ffffffffc02017ae:	679c                	ld	a5,8(a5)
                while ((le = list_next(le)) != list) {
ffffffffc02017b0:	fef697e3          	bne	a3,a5,ffffffffc020179e <find_vma+0x14>
    struct vma_struct *vma = NULL;
ffffffffc02017b4:	4501                	li	a0,0
}
ffffffffc02017b6:	8082                	ret
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr)) {
ffffffffc02017b8:	691c                	ld	a5,16(a0)
ffffffffc02017ba:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0201798 <find_vma+0xe>
            mm->mmap_cache = vma;
ffffffffc02017be:	ea88                	sd	a0,16(a3)
ffffffffc02017c0:	8082                	ret
                    vma = le2vma(le, list_link);
ffffffffc02017c2:	fe078513          	addi	a0,a5,-32
            mm->mmap_cache = vma;
ffffffffc02017c6:	ea88                	sd	a0,16(a3)
ffffffffc02017c8:	8082                	ret

ffffffffc02017ca <insert_vma_struct>:


// insert_vma_struct -insert vma in mm's list link
void
insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma) {
    assert(vma->vm_start < vma->vm_end);
ffffffffc02017ca:	6590                	ld	a2,8(a1)
ffffffffc02017cc:	0105b803          	ld	a6,16(a1)
insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma) {
ffffffffc02017d0:	1141                	addi	sp,sp,-16
ffffffffc02017d2:	e406                	sd	ra,8(sp)
ffffffffc02017d4:	87aa                	mv	a5,a0
    assert(vma->vm_start < vma->vm_end);
ffffffffc02017d6:	01066763          	bltu	a2,a6,ffffffffc02017e4 <insert_vma_struct+0x1a>
ffffffffc02017da:	a085                	j	ffffffffc020183a <insert_vma_struct+0x70>
    list_entry_t *le_prev = list, *le_next;

        list_entry_t *le = list;
        while ((le = list_next(le)) != list) {
            struct vma_struct *mmap_prev = le2vma(le, list_link);
            if (mmap_prev->vm_start > vma->vm_start) {
ffffffffc02017dc:	fe87b703          	ld	a4,-24(a5)
ffffffffc02017e0:	04e66863          	bltu	a2,a4,ffffffffc0201830 <insert_vma_struct+0x66>
ffffffffc02017e4:	86be                	mv	a3,a5
ffffffffc02017e6:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list) {
ffffffffc02017e8:	fef51ae3          	bne	a0,a5,ffffffffc02017dc <insert_vma_struct+0x12>
        }

    le_next = list_next(le_prev);

    /* check overlap */
    if (le_prev != list) {
ffffffffc02017ec:	02a68463          	beq	a3,a0,ffffffffc0201814 <insert_vma_struct+0x4a>
        check_vma_overlap(le2vma(le_prev, list_link), vma);
ffffffffc02017f0:	ff06b703          	ld	a4,-16(a3)
    assert(prev->vm_start < prev->vm_end);
ffffffffc02017f4:	fe86b883          	ld	a7,-24(a3)
ffffffffc02017f8:	08e8f163          	bgeu	a7,a4,ffffffffc020187a <insert_vma_struct+0xb0>
    assert(prev->vm_end <= next->vm_start);
ffffffffc02017fc:	04e66f63          	bltu	a2,a4,ffffffffc020185a <insert_vma_struct+0x90>
    }
    if (le_next != list) {
ffffffffc0201800:	00f50a63          	beq	a0,a5,ffffffffc0201814 <insert_vma_struct+0x4a>
ffffffffc0201804:	fe87b703          	ld	a4,-24(a5)
    assert(prev->vm_end <= next->vm_start);
ffffffffc0201808:	05076963          	bltu	a4,a6,ffffffffc020185a <insert_vma_struct+0x90>
    assert(next->vm_start < next->vm_end);
ffffffffc020180c:	ff07b603          	ld	a2,-16(a5)
ffffffffc0201810:	02c77363          	bgeu	a4,a2,ffffffffc0201836 <insert_vma_struct+0x6c>
    }

    vma->vm_mm = mm;
    list_add_after(le_prev, &(vma->list_link));

    mm->map_count ++;
ffffffffc0201814:	5118                	lw	a4,32(a0)
    vma->vm_mm = mm;
ffffffffc0201816:	e188                	sd	a0,0(a1)
    list_add_after(le_prev, &(vma->list_link));
ffffffffc0201818:	02058613          	addi	a2,a1,32
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
ffffffffc020181c:	e390                	sd	a2,0(a5)
ffffffffc020181e:	e690                	sd	a2,8(a3)
}
ffffffffc0201820:	60a2                	ld	ra,8(sp)
    elm->next = next;
ffffffffc0201822:	f59c                	sd	a5,40(a1)
    elm->prev = prev;
ffffffffc0201824:	f194                	sd	a3,32(a1)
    mm->map_count ++;
ffffffffc0201826:	0017079b          	addiw	a5,a4,1
ffffffffc020182a:	d11c                	sw	a5,32(a0)
}
ffffffffc020182c:	0141                	addi	sp,sp,16
ffffffffc020182e:	8082                	ret
    if (le_prev != list) {
ffffffffc0201830:	fca690e3          	bne	a3,a0,ffffffffc02017f0 <insert_vma_struct+0x26>
ffffffffc0201834:	bfd1                	j	ffffffffc0201808 <insert_vma_struct+0x3e>
ffffffffc0201836:	ee9ff0ef          	jal	ra,ffffffffc020171e <check_vma_overlap.isra.0.part.0>
    assert(vma->vm_start < vma->vm_end);
ffffffffc020183a:	00004697          	auipc	a3,0x4
ffffffffc020183e:	fb668693          	addi	a3,a3,-74 # ffffffffc02057f0 <commands+0x8c8>
ffffffffc0201842:	00004617          	auipc	a2,0x4
ffffffffc0201846:	aee60613          	addi	a2,a2,-1298 # ffffffffc0205330 <commands+0x408>
ffffffffc020184a:	07400593          	li	a1,116
ffffffffc020184e:	00004517          	auipc	a0,0x4
ffffffffc0201852:	f9250513          	addi	a0,a0,-110 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc0201856:	9affe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(prev->vm_end <= next->vm_start);
ffffffffc020185a:	00004697          	auipc	a3,0x4
ffffffffc020185e:	fd668693          	addi	a3,a3,-42 # ffffffffc0205830 <commands+0x908>
ffffffffc0201862:	00004617          	auipc	a2,0x4
ffffffffc0201866:	ace60613          	addi	a2,a2,-1330 # ffffffffc0205330 <commands+0x408>
ffffffffc020186a:	06c00593          	li	a1,108
ffffffffc020186e:	00004517          	auipc	a0,0x4
ffffffffc0201872:	f7250513          	addi	a0,a0,-142 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc0201876:	98ffe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(prev->vm_start < prev->vm_end);
ffffffffc020187a:	00004697          	auipc	a3,0x4
ffffffffc020187e:	f9668693          	addi	a3,a3,-106 # ffffffffc0205810 <commands+0x8e8>
ffffffffc0201882:	00004617          	auipc	a2,0x4
ffffffffc0201886:	aae60613          	addi	a2,a2,-1362 # ffffffffc0205330 <commands+0x408>
ffffffffc020188a:	06b00593          	li	a1,107
ffffffffc020188e:	00004517          	auipc	a0,0x4
ffffffffc0201892:	f5250513          	addi	a0,a0,-174 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc0201896:	96ffe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020189a <mm_destroy>:

// mm_destroy - free mm and mm internal fields
void
mm_destroy(struct mm_struct *mm) {
    assert(mm_count(mm) == 0);
ffffffffc020189a:	591c                	lw	a5,48(a0)
mm_destroy(struct mm_struct *mm) {
ffffffffc020189c:	1141                	addi	sp,sp,-16
ffffffffc020189e:	e406                	sd	ra,8(sp)
ffffffffc02018a0:	e022                	sd	s0,0(sp)
    assert(mm_count(mm) == 0);
ffffffffc02018a2:	e78d                	bnez	a5,ffffffffc02018cc <mm_destroy+0x32>
ffffffffc02018a4:	842a                	mv	s0,a0
    return listelm->next;
ffffffffc02018a6:	6508                	ld	a0,8(a0)

    list_entry_t *list = &(mm->mmap_list), *le;
    while ((le = list_next(list)) != list) {
ffffffffc02018a8:	00a40c63          	beq	s0,a0,ffffffffc02018c0 <mm_destroy+0x26>
    __list_del(listelm->prev, listelm->next);
ffffffffc02018ac:	6118                	ld	a4,0(a0)
ffffffffc02018ae:	651c                	ld	a5,8(a0)
        list_del(le);
        kfree(le2vma(le, list_link));  //kfree vma        
ffffffffc02018b0:	1501                	addi	a0,a0,-32
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc02018b2:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc02018b4:	e398                	sd	a4,0(a5)
ffffffffc02018b6:	071000ef          	jal	ra,ffffffffc0202126 <kfree>
    return listelm->next;
ffffffffc02018ba:	6408                	ld	a0,8(s0)
    while ((le = list_next(list)) != list) {
ffffffffc02018bc:	fea418e3          	bne	s0,a0,ffffffffc02018ac <mm_destroy+0x12>
    }
    kfree(mm); //kfree mm
ffffffffc02018c0:	8522                	mv	a0,s0
    mm=NULL;
}
ffffffffc02018c2:	6402                	ld	s0,0(sp)
ffffffffc02018c4:	60a2                	ld	ra,8(sp)
ffffffffc02018c6:	0141                	addi	sp,sp,16
    kfree(mm); //kfree mm
ffffffffc02018c8:	05f0006f          	j	ffffffffc0202126 <kfree>
    assert(mm_count(mm) == 0);
ffffffffc02018cc:	00004697          	auipc	a3,0x4
ffffffffc02018d0:	f8468693          	addi	a3,a3,-124 # ffffffffc0205850 <commands+0x928>
ffffffffc02018d4:	00004617          	auipc	a2,0x4
ffffffffc02018d8:	a5c60613          	addi	a2,a2,-1444 # ffffffffc0205330 <commands+0x408>
ffffffffc02018dc:	09400593          	li	a1,148
ffffffffc02018e0:	00004517          	auipc	a0,0x4
ffffffffc02018e4:	f0050513          	addi	a0,a0,-256 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc02018e8:	91dfe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02018ec <mm_map>:

int
mm_map(struct mm_struct *mm, uintptr_t addr, size_t len, uint32_t vm_flags,
       struct vma_struct **vma_store) {
ffffffffc02018ec:	7139                	addi	sp,sp,-64
ffffffffc02018ee:	f822                	sd	s0,48(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc02018f0:	6405                	lui	s0,0x1
ffffffffc02018f2:	147d                	addi	s0,s0,-1
ffffffffc02018f4:	77fd                	lui	a5,0xfffff
ffffffffc02018f6:	9622                	add	a2,a2,s0
ffffffffc02018f8:	962e                	add	a2,a2,a1
       struct vma_struct **vma_store) {
ffffffffc02018fa:	f426                	sd	s1,40(sp)
ffffffffc02018fc:	fc06                	sd	ra,56(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc02018fe:	00f5f4b3          	and	s1,a1,a5
       struct vma_struct **vma_store) {
ffffffffc0201902:	f04a                	sd	s2,32(sp)
ffffffffc0201904:	ec4e                	sd	s3,24(sp)
ffffffffc0201906:	e852                	sd	s4,16(sp)
ffffffffc0201908:	e456                	sd	s5,8(sp)
    if (!USER_ACCESS(start, end)) {
ffffffffc020190a:	002005b7          	lui	a1,0x200
ffffffffc020190e:	00f67433          	and	s0,a2,a5
ffffffffc0201912:	06b4e363          	bltu	s1,a1,ffffffffc0201978 <mm_map+0x8c>
ffffffffc0201916:	0684f163          	bgeu	s1,s0,ffffffffc0201978 <mm_map+0x8c>
ffffffffc020191a:	4785                	li	a5,1
ffffffffc020191c:	07fe                	slli	a5,a5,0x1f
ffffffffc020191e:	0487ed63          	bltu	a5,s0,ffffffffc0201978 <mm_map+0x8c>
ffffffffc0201922:	89aa                	mv	s3,a0
        return -E_INVAL;
    }

    assert(mm != NULL);
ffffffffc0201924:	cd21                	beqz	a0,ffffffffc020197c <mm_map+0x90>

    int ret = -E_INVAL;

    struct vma_struct *vma;
    if ((vma = find_vma(mm, start)) != NULL && end > vma->vm_start) {
ffffffffc0201926:	85a6                	mv	a1,s1
ffffffffc0201928:	8ab6                	mv	s5,a3
ffffffffc020192a:	8a3a                	mv	s4,a4
ffffffffc020192c:	e5fff0ef          	jal	ra,ffffffffc020178a <find_vma>
ffffffffc0201930:	c501                	beqz	a0,ffffffffc0201938 <mm_map+0x4c>
ffffffffc0201932:	651c                	ld	a5,8(a0)
ffffffffc0201934:	0487e263          	bltu	a5,s0,ffffffffc0201978 <mm_map+0x8c>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0201938:	03000513          	li	a0,48
ffffffffc020193c:	73a000ef          	jal	ra,ffffffffc0202076 <kmalloc>
ffffffffc0201940:	892a                	mv	s2,a0
        goto out;
    }
    ret = -E_NO_MEM;
ffffffffc0201942:	5571                	li	a0,-4
    if (vma != NULL) {
ffffffffc0201944:	02090163          	beqz	s2,ffffffffc0201966 <mm_map+0x7a>

    if ((vma = vma_create(start, end, vm_flags)) == NULL) {
        goto out;
    }
    insert_vma_struct(mm, vma);
ffffffffc0201948:	854e                	mv	a0,s3
        vma->vm_start = vm_start;
ffffffffc020194a:	00993423          	sd	s1,8(s2)
        vma->vm_end = vm_end;
ffffffffc020194e:	00893823          	sd	s0,16(s2)
        vma->vm_flags = vm_flags;
ffffffffc0201952:	01592c23          	sw	s5,24(s2)
    insert_vma_struct(mm, vma);
ffffffffc0201956:	85ca                	mv	a1,s2
ffffffffc0201958:	e73ff0ef          	jal	ra,ffffffffc02017ca <insert_vma_struct>
    if (vma_store != NULL) {
        *vma_store = vma;
    }
    ret = 0;
ffffffffc020195c:	4501                	li	a0,0
    if (vma_store != NULL) {
ffffffffc020195e:	000a0463          	beqz	s4,ffffffffc0201966 <mm_map+0x7a>
        *vma_store = vma;
ffffffffc0201962:	012a3023          	sd	s2,0(s4) # 1000 <_binary_obj___user_hello_out_size-0x88b8>

out:
    return ret;
}
ffffffffc0201966:	70e2                	ld	ra,56(sp)
ffffffffc0201968:	7442                	ld	s0,48(sp)
ffffffffc020196a:	74a2                	ld	s1,40(sp)
ffffffffc020196c:	7902                	ld	s2,32(sp)
ffffffffc020196e:	69e2                	ld	s3,24(sp)
ffffffffc0201970:	6a42                	ld	s4,16(sp)
ffffffffc0201972:	6aa2                	ld	s5,8(sp)
ffffffffc0201974:	6121                	addi	sp,sp,64
ffffffffc0201976:	8082                	ret
        return -E_INVAL;
ffffffffc0201978:	5575                	li	a0,-3
ffffffffc020197a:	b7f5                	j	ffffffffc0201966 <mm_map+0x7a>
    assert(mm != NULL);
ffffffffc020197c:	00004697          	auipc	a3,0x4
ffffffffc0201980:	eec68693          	addi	a3,a3,-276 # ffffffffc0205868 <commands+0x940>
ffffffffc0201984:	00004617          	auipc	a2,0x4
ffffffffc0201988:	9ac60613          	addi	a2,a2,-1620 # ffffffffc0205330 <commands+0x408>
ffffffffc020198c:	0a700593          	li	a1,167
ffffffffc0201990:	00004517          	auipc	a0,0x4
ffffffffc0201994:	e5050513          	addi	a0,a0,-432 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc0201998:	86dfe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020199c <dup_mmap>:

int
dup_mmap(struct mm_struct *to, struct mm_struct *from) {
ffffffffc020199c:	7139                	addi	sp,sp,-64
ffffffffc020199e:	fc06                	sd	ra,56(sp)
ffffffffc02019a0:	f822                	sd	s0,48(sp)
ffffffffc02019a2:	f426                	sd	s1,40(sp)
ffffffffc02019a4:	f04a                	sd	s2,32(sp)
ffffffffc02019a6:	ec4e                	sd	s3,24(sp)
ffffffffc02019a8:	e852                	sd	s4,16(sp)
ffffffffc02019aa:	e456                	sd	s5,8(sp)
    assert(to != NULL && from != NULL);
ffffffffc02019ac:	c52d                	beqz	a0,ffffffffc0201a16 <dup_mmap+0x7a>
ffffffffc02019ae:	892a                	mv	s2,a0
ffffffffc02019b0:	84ae                	mv	s1,a1
    list_entry_t *list = &(from->mmap_list), *le = list;
ffffffffc02019b2:	842e                	mv	s0,a1
    assert(to != NULL && from != NULL);
ffffffffc02019b4:	e595                	bnez	a1,ffffffffc02019e0 <dup_mmap+0x44>
ffffffffc02019b6:	a085                	j	ffffffffc0201a16 <dup_mmap+0x7a>
        nvma = vma_create(vma->vm_start, vma->vm_end, vma->vm_flags);
        if (nvma == NULL) {
            return -E_NO_MEM;
        }

        insert_vma_struct(to, nvma);
ffffffffc02019b8:	854a                	mv	a0,s2
        vma->vm_start = vm_start;
ffffffffc02019ba:	0155b423          	sd	s5,8(a1) # 200008 <_binary_obj___user_rr_out_size+0x1f55f8>
        vma->vm_end = vm_end;
ffffffffc02019be:	0145b823          	sd	s4,16(a1)
        vma->vm_flags = vm_flags;
ffffffffc02019c2:	0135ac23          	sw	s3,24(a1)
        insert_vma_struct(to, nvma);
ffffffffc02019c6:	e05ff0ef          	jal	ra,ffffffffc02017ca <insert_vma_struct>

        bool share = 0;
        if (copy_range(to->pgdir, from->pgdir, vma->vm_start, vma->vm_end, share) != 0) {
ffffffffc02019ca:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_obj___user_hello_out_size-0x88c8>
ffffffffc02019ce:	fe843603          	ld	a2,-24(s0)
ffffffffc02019d2:	6c8c                	ld	a1,24(s1)
ffffffffc02019d4:	01893503          	ld	a0,24(s2)
ffffffffc02019d8:	4701                	li	a4,0
ffffffffc02019da:	a81ff0ef          	jal	ra,ffffffffc020145a <copy_range>
ffffffffc02019de:	e105                	bnez	a0,ffffffffc02019fe <dup_mmap+0x62>
    return listelm->prev;
ffffffffc02019e0:	6000                	ld	s0,0(s0)
    while ((le = list_prev(le)) != list) {
ffffffffc02019e2:	02848863          	beq	s1,s0,ffffffffc0201a12 <dup_mmap+0x76>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc02019e6:	03000513          	li	a0,48
        nvma = vma_create(vma->vm_start, vma->vm_end, vma->vm_flags);
ffffffffc02019ea:	fe843a83          	ld	s5,-24(s0)
ffffffffc02019ee:	ff043a03          	ld	s4,-16(s0)
ffffffffc02019f2:	ff842983          	lw	s3,-8(s0)
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc02019f6:	680000ef          	jal	ra,ffffffffc0202076 <kmalloc>
ffffffffc02019fa:	85aa                	mv	a1,a0
    if (vma != NULL) {
ffffffffc02019fc:	fd55                	bnez	a0,ffffffffc02019b8 <dup_mmap+0x1c>
            return -E_NO_MEM;
ffffffffc02019fe:	5571                	li	a0,-4
            return -E_NO_MEM;
        }
    }
    return 0;
}
ffffffffc0201a00:	70e2                	ld	ra,56(sp)
ffffffffc0201a02:	7442                	ld	s0,48(sp)
ffffffffc0201a04:	74a2                	ld	s1,40(sp)
ffffffffc0201a06:	7902                	ld	s2,32(sp)
ffffffffc0201a08:	69e2                	ld	s3,24(sp)
ffffffffc0201a0a:	6a42                	ld	s4,16(sp)
ffffffffc0201a0c:	6aa2                	ld	s5,8(sp)
ffffffffc0201a0e:	6121                	addi	sp,sp,64
ffffffffc0201a10:	8082                	ret
    return 0;
ffffffffc0201a12:	4501                	li	a0,0
ffffffffc0201a14:	b7f5                	j	ffffffffc0201a00 <dup_mmap+0x64>
    assert(to != NULL && from != NULL);
ffffffffc0201a16:	00004697          	auipc	a3,0x4
ffffffffc0201a1a:	e6268693          	addi	a3,a3,-414 # ffffffffc0205878 <commands+0x950>
ffffffffc0201a1e:	00004617          	auipc	a2,0x4
ffffffffc0201a22:	91260613          	addi	a2,a2,-1774 # ffffffffc0205330 <commands+0x408>
ffffffffc0201a26:	0c000593          	li	a1,192
ffffffffc0201a2a:	00004517          	auipc	a0,0x4
ffffffffc0201a2e:	db650513          	addi	a0,a0,-586 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc0201a32:	fd2fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201a36 <exit_mmap>:

void
exit_mmap(struct mm_struct *mm) {
ffffffffc0201a36:	1101                	addi	sp,sp,-32
ffffffffc0201a38:	ec06                	sd	ra,24(sp)
ffffffffc0201a3a:	e822                	sd	s0,16(sp)
ffffffffc0201a3c:	e426                	sd	s1,8(sp)
ffffffffc0201a3e:	e04a                	sd	s2,0(sp)
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc0201a40:	c531                	beqz	a0,ffffffffc0201a8c <exit_mmap+0x56>
ffffffffc0201a42:	591c                	lw	a5,48(a0)
ffffffffc0201a44:	84aa                	mv	s1,a0
ffffffffc0201a46:	e3b9                	bnez	a5,ffffffffc0201a8c <exit_mmap+0x56>
    return listelm->next;
ffffffffc0201a48:	6500                	ld	s0,8(a0)
    pde_t *pgdir = mm->pgdir;
ffffffffc0201a4a:	01853903          	ld	s2,24(a0)
    list_entry_t *list = &(mm->mmap_list), *le = list;
    while ((le = list_next(le)) != list) {
ffffffffc0201a4e:	02850663          	beq	a0,s0,ffffffffc0201a7a <exit_mmap+0x44>
        struct vma_struct *vma = le2vma(le, list_link);
        unmap_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc0201a52:	ff043603          	ld	a2,-16(s0)
ffffffffc0201a56:	fe843583          	ld	a1,-24(s0)
ffffffffc0201a5a:	854a                	mv	a0,s2
ffffffffc0201a5c:	f2eff0ef          	jal	ra,ffffffffc020118a <unmap_range>
ffffffffc0201a60:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list) {
ffffffffc0201a62:	fe8498e3          	bne	s1,s0,ffffffffc0201a52 <exit_mmap+0x1c>
ffffffffc0201a66:	6400                	ld	s0,8(s0)
    }
    while ((le = list_next(le)) != list) {
ffffffffc0201a68:	00848c63          	beq	s1,s0,ffffffffc0201a80 <exit_mmap+0x4a>
        struct vma_struct *vma = le2vma(le, list_link);
        exit_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc0201a6c:	ff043603          	ld	a2,-16(s0)
ffffffffc0201a70:	fe843583          	ld	a1,-24(s0)
ffffffffc0201a74:	854a                	mv	a0,s2
ffffffffc0201a76:	82bff0ef          	jal	ra,ffffffffc02012a0 <exit_range>
ffffffffc0201a7a:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list) {
ffffffffc0201a7c:	fe8498e3          	bne	s1,s0,ffffffffc0201a6c <exit_mmap+0x36>
    }
}
ffffffffc0201a80:	60e2                	ld	ra,24(sp)
ffffffffc0201a82:	6442                	ld	s0,16(sp)
ffffffffc0201a84:	64a2                	ld	s1,8(sp)
ffffffffc0201a86:	6902                	ld	s2,0(sp)
ffffffffc0201a88:	6105                	addi	sp,sp,32
ffffffffc0201a8a:	8082                	ret
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc0201a8c:	00004697          	auipc	a3,0x4
ffffffffc0201a90:	e0c68693          	addi	a3,a3,-500 # ffffffffc0205898 <commands+0x970>
ffffffffc0201a94:	00004617          	auipc	a2,0x4
ffffffffc0201a98:	89c60613          	addi	a2,a2,-1892 # ffffffffc0205330 <commands+0x408>
ffffffffc0201a9c:	0d600593          	li	a1,214
ffffffffc0201aa0:	00004517          	auipc	a0,0x4
ffffffffc0201aa4:	d4050513          	addi	a0,a0,-704 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc0201aa8:	f5cfe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201aac <vmm_init>:
// vmm_init - initialize virtual memory management
//          - now just call check_vmm to check correctness of vmm
void
vmm_init(void) {
    //check_vmm();
}
ffffffffc0201aac:	8082                	ret

ffffffffc0201aae <do_pgfault>:
 *            was a read (0) or write (1).
 *         -- The U/S flag (bit 2) indicates whether the processor was executing at user mode (1)
 *            or supervisor mode (0) at the time of the exception.
 */
int
do_pgfault(struct mm_struct *mm, uint_t error_code, uintptr_t addr) {
ffffffffc0201aae:	7139                	addi	sp,sp,-64
    int ret = -E_INVAL;
    //try to find a vma which include addr
    struct vma_struct *vma = find_vma(mm, addr);
ffffffffc0201ab0:	85b2                	mv	a1,a2
do_pgfault(struct mm_struct *mm, uint_t error_code, uintptr_t addr) {
ffffffffc0201ab2:	f822                	sd	s0,48(sp)
ffffffffc0201ab4:	f426                	sd	s1,40(sp)
ffffffffc0201ab6:	fc06                	sd	ra,56(sp)
ffffffffc0201ab8:	f04a                	sd	s2,32(sp)
ffffffffc0201aba:	ec4e                	sd	s3,24(sp)
ffffffffc0201abc:	8432                	mv	s0,a2
ffffffffc0201abe:	84aa                	mv	s1,a0
    struct vma_struct *vma = find_vma(mm, addr);
ffffffffc0201ac0:	ccbff0ef          	jal	ra,ffffffffc020178a <find_vma>

    pgfault_num++;
ffffffffc0201ac4:	00032797          	auipc	a5,0x32
ffffffffc0201ac8:	1fc7a783          	lw	a5,508(a5) # ffffffffc0233cc0 <pgfault_num>
ffffffffc0201acc:	2785                	addiw	a5,a5,1
ffffffffc0201ace:	00032717          	auipc	a4,0x32
ffffffffc0201ad2:	1ef72923          	sw	a5,498(a4) # ffffffffc0233cc0 <pgfault_num>
    //If the addr is in the range of a mm's vma?
    if (vma == NULL || vma->vm_start > addr) {
ffffffffc0201ad6:	c545                	beqz	a0,ffffffffc0201b7e <do_pgfault+0xd0>
ffffffffc0201ad8:	651c                	ld	a5,8(a0)
ffffffffc0201ada:	0af46263          	bltu	s0,a5,ffffffffc0201b7e <do_pgfault+0xd0>
     *    (read  an non_existed addr && addr is readable)
     * THEN
     *    continue process
     */
    uint32_t perm = PTE_U;
    if (vma->vm_flags & VM_WRITE) {
ffffffffc0201ade:	4d1c                	lw	a5,24(a0)
    uint32_t perm = PTE_U;
ffffffffc0201ae0:	49c1                	li	s3,16
    if (vma->vm_flags & VM_WRITE) {
ffffffffc0201ae2:	8b89                	andi	a5,a5,2
ffffffffc0201ae4:	efb1                	bnez	a5,ffffffffc0201b40 <do_pgfault+0x92>
        perm |= READ_WRITE;
    }
    addr = ROUNDDOWN(addr, PGSIZE);
ffffffffc0201ae6:	75fd                	lui	a1,0xfffff
    *   mm->pgdir : the PDT of these vma
    *
    */
    // try to find a pte, if pte's PT(Page Table) isn't existed, then create a PT.
    // (notice the 3th parameter '1')
    if ((ptep = get_pte(mm->pgdir, addr, 1)) == NULL) {
ffffffffc0201ae8:	6c88                	ld	a0,24(s1)
    addr = ROUNDDOWN(addr, PGSIZE);
ffffffffc0201aea:	8c6d                	and	s0,s0,a1
    if ((ptep = get_pte(mm->pgdir, addr, 1)) == NULL) {
ffffffffc0201aec:	4605                	li	a2,1
ffffffffc0201aee:	85a2                	mv	a1,s0
ffffffffc0201af0:	cc8ff0ef          	jal	ra,ffffffffc0200fb8 <get_pte>
ffffffffc0201af4:	c555                	beqz	a0,ffffffffc0201ba0 <do_pgfault+0xf2>
        cprintf("get_pte in do_pgfault failed\n");
        goto failed;
    }
    
    if (*ptep == 0) { // if the phy addr isn't exist, then alloc a page & map the phy addr with logical addr
ffffffffc0201af6:	610c                	ld	a1,0(a0)
ffffffffc0201af8:	c5a5                	beqz	a1,ffffffffc0201b60 <do_pgfault+0xb2>
            goto failed;
        }
    }
    else { // if this pte is a swap entry, then load data from disk to a page with phy addr
           // and call page_insert to map the phy addr with logical addr
        if(swap_init_ok) {
ffffffffc0201afa:	00032797          	auipc	a5,0x32
ffffffffc0201afe:	1d67a783          	lw	a5,470(a5) # ffffffffc0233cd0 <swap_init_ok>
ffffffffc0201b02:	c7d9                	beqz	a5,ffffffffc0201b90 <do_pgfault+0xe2>
            struct Page *page=NULL;
            if ((ret = swap_in(mm, addr, &page)) != 0) {
ffffffffc0201b04:	0030                	addi	a2,sp,8
ffffffffc0201b06:	85a2                	mv	a1,s0
ffffffffc0201b08:	8526                	mv	a0,s1
            struct Page *page=NULL;
ffffffffc0201b0a:	e402                	sd	zero,8(sp)
            if ((ret = swap_in(mm, addr, &page)) != 0) {
ffffffffc0201b0c:	2ee000ef          	jal	ra,ffffffffc0201dfa <swap_in>
ffffffffc0201b10:	892a                	mv	s2,a0
ffffffffc0201b12:	e90d                	bnez	a0,ffffffffc0201b44 <do_pgfault+0x96>
                cprintf("swap_in in do_pgfault failed\n");
                goto failed;
            }    
            page_insert(mm->pgdir, page, addr, perm);
ffffffffc0201b14:	65a2                	ld	a1,8(sp)
ffffffffc0201b16:	6c88                	ld	a0,24(s1)
ffffffffc0201b18:	86ce                	mv	a3,s3
ffffffffc0201b1a:	8622                	mv	a2,s0
ffffffffc0201b1c:	883ff0ef          	jal	ra,ffffffffc020139e <page_insert>
            swap_map_swappable(mm, addr, page, 1);
ffffffffc0201b20:	6622                	ld	a2,8(sp)
ffffffffc0201b22:	4685                	li	a3,1
ffffffffc0201b24:	85a2                	mv	a1,s0
ffffffffc0201b26:	8526                	mv	a0,s1
ffffffffc0201b28:	1b0000ef          	jal	ra,ffffffffc0201cd8 <swap_map_swappable>
            page->pra_vaddr = addr;
ffffffffc0201b2c:	67a2                	ld	a5,8(sp)
ffffffffc0201b2e:	ff80                	sd	s0,56(a5)
        }
   }
   ret = 0;
failed:
    return ret;
}
ffffffffc0201b30:	70e2                	ld	ra,56(sp)
ffffffffc0201b32:	7442                	ld	s0,48(sp)
ffffffffc0201b34:	74a2                	ld	s1,40(sp)
ffffffffc0201b36:	69e2                	ld	s3,24(sp)
ffffffffc0201b38:	854a                	mv	a0,s2
ffffffffc0201b3a:	7902                	ld	s2,32(sp)
ffffffffc0201b3c:	6121                	addi	sp,sp,64
ffffffffc0201b3e:	8082                	ret
        perm |= READ_WRITE;
ffffffffc0201b40:	49dd                	li	s3,23
ffffffffc0201b42:	b755                	j	ffffffffc0201ae6 <do_pgfault+0x38>
                cprintf("swap_in in do_pgfault failed\n");
ffffffffc0201b44:	00004517          	auipc	a0,0x4
ffffffffc0201b48:	dec50513          	addi	a0,a0,-532 # ffffffffc0205930 <commands+0xa08>
ffffffffc0201b4c:	d7cfe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
}
ffffffffc0201b50:	70e2                	ld	ra,56(sp)
ffffffffc0201b52:	7442                	ld	s0,48(sp)
ffffffffc0201b54:	74a2                	ld	s1,40(sp)
ffffffffc0201b56:	69e2                	ld	s3,24(sp)
ffffffffc0201b58:	854a                	mv	a0,s2
ffffffffc0201b5a:	7902                	ld	s2,32(sp)
ffffffffc0201b5c:	6121                	addi	sp,sp,64
ffffffffc0201b5e:	8082                	ret
        if (pgdir_alloc_page(mm->pgdir, addr, perm) == NULL) {
ffffffffc0201b60:	6c88                	ld	a0,24(s1)
ffffffffc0201b62:	864e                	mv	a2,s3
ffffffffc0201b64:	85a2                	mv	a1,s0
ffffffffc0201b66:	b2bff0ef          	jal	ra,ffffffffc0201690 <pgdir_alloc_page>
   ret = 0;
ffffffffc0201b6a:	4901                	li	s2,0
        if (pgdir_alloc_page(mm->pgdir, addr, perm) == NULL) {
ffffffffc0201b6c:	f171                	bnez	a0,ffffffffc0201b30 <do_pgfault+0x82>
            cprintf("pgdir_alloc_page in do_pgfault failed\n");
ffffffffc0201b6e:	00004517          	auipc	a0,0x4
ffffffffc0201b72:	d9a50513          	addi	a0,a0,-614 # ffffffffc0205908 <commands+0x9e0>
ffffffffc0201b76:	d52fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    ret = -E_NO_MEM;
ffffffffc0201b7a:	5971                	li	s2,-4
            goto failed;
ffffffffc0201b7c:	bf55                	j	ffffffffc0201b30 <do_pgfault+0x82>
        cprintf("not valid addr %x, and  can not find it in vma\n", addr);
ffffffffc0201b7e:	85a2                	mv	a1,s0
ffffffffc0201b80:	00004517          	auipc	a0,0x4
ffffffffc0201b84:	d3850513          	addi	a0,a0,-712 # ffffffffc02058b8 <commands+0x990>
ffffffffc0201b88:	d40fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    int ret = -E_INVAL;
ffffffffc0201b8c:	5975                	li	s2,-3
        goto failed;
ffffffffc0201b8e:	b74d                	j	ffffffffc0201b30 <do_pgfault+0x82>
            cprintf("no swap_init_ok but ptep is %x, failed\n",*ptep);
ffffffffc0201b90:	00004517          	auipc	a0,0x4
ffffffffc0201b94:	dc050513          	addi	a0,a0,-576 # ffffffffc0205950 <commands+0xa28>
ffffffffc0201b98:	d30fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    ret = -E_NO_MEM;
ffffffffc0201b9c:	5971                	li	s2,-4
            goto failed;
ffffffffc0201b9e:	bf49                	j	ffffffffc0201b30 <do_pgfault+0x82>
        cprintf("get_pte in do_pgfault failed\n");
ffffffffc0201ba0:	00004517          	auipc	a0,0x4
ffffffffc0201ba4:	d4850513          	addi	a0,a0,-696 # ffffffffc02058e8 <commands+0x9c0>
ffffffffc0201ba8:	d20fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    ret = -E_NO_MEM;
ffffffffc0201bac:	5971                	li	s2,-4
        goto failed;
ffffffffc0201bae:	b749                	j	ffffffffc0201b30 <do_pgfault+0x82>

ffffffffc0201bb0 <user_mem_check>:

bool
user_mem_check(struct mm_struct *mm, uintptr_t addr, size_t len, bool write) {
ffffffffc0201bb0:	7179                	addi	sp,sp,-48
ffffffffc0201bb2:	f022                	sd	s0,32(sp)
ffffffffc0201bb4:	f406                	sd	ra,40(sp)
ffffffffc0201bb6:	ec26                	sd	s1,24(sp)
ffffffffc0201bb8:	e84a                	sd	s2,16(sp)
ffffffffc0201bba:	e44e                	sd	s3,8(sp)
ffffffffc0201bbc:	e052                	sd	s4,0(sp)
ffffffffc0201bbe:	842e                	mv	s0,a1
    if (mm != NULL) {
ffffffffc0201bc0:	c135                	beqz	a0,ffffffffc0201c24 <user_mem_check+0x74>
        if (!USER_ACCESS(addr, addr + len)) {
ffffffffc0201bc2:	002007b7          	lui	a5,0x200
ffffffffc0201bc6:	04f5e663          	bltu	a1,a5,ffffffffc0201c12 <user_mem_check+0x62>
ffffffffc0201bca:	00c584b3          	add	s1,a1,a2
ffffffffc0201bce:	0495f263          	bgeu	a1,s1,ffffffffc0201c12 <user_mem_check+0x62>
ffffffffc0201bd2:	4785                	li	a5,1
ffffffffc0201bd4:	07fe                	slli	a5,a5,0x1f
ffffffffc0201bd6:	0297ee63          	bltu	a5,s1,ffffffffc0201c12 <user_mem_check+0x62>
ffffffffc0201bda:	892a                	mv	s2,a0
ffffffffc0201bdc:	89b6                	mv	s3,a3
            }
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
                return 0;
            }
            if (write && (vma->vm_flags & VM_STACK)) {
                if (start < vma->vm_start + PGSIZE) { //check stack start & size
ffffffffc0201bde:	6a05                	lui	s4,0x1
ffffffffc0201be0:	a821                	j	ffffffffc0201bf8 <user_mem_check+0x48>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
ffffffffc0201be2:	0027f693          	andi	a3,a5,2
                if (start < vma->vm_start + PGSIZE) { //check stack start & size
ffffffffc0201be6:	9752                	add	a4,a4,s4
            if (write && (vma->vm_flags & VM_STACK)) {
ffffffffc0201be8:	8ba1                	andi	a5,a5,8
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
ffffffffc0201bea:	c685                	beqz	a3,ffffffffc0201c12 <user_mem_check+0x62>
            if (write && (vma->vm_flags & VM_STACK)) {
ffffffffc0201bec:	c399                	beqz	a5,ffffffffc0201bf2 <user_mem_check+0x42>
                if (start < vma->vm_start + PGSIZE) { //check stack start & size
ffffffffc0201bee:	02e46263          	bltu	s0,a4,ffffffffc0201c12 <user_mem_check+0x62>
                    return 0;
                }
            }
            start = vma->vm_end;
ffffffffc0201bf2:	6900                	ld	s0,16(a0)
        while (start < end) {
ffffffffc0201bf4:	04947663          	bgeu	s0,s1,ffffffffc0201c40 <user_mem_check+0x90>
            if ((vma = find_vma(mm, start)) == NULL || start < vma->vm_start) {
ffffffffc0201bf8:	85a2                	mv	a1,s0
ffffffffc0201bfa:	854a                	mv	a0,s2
ffffffffc0201bfc:	b8fff0ef          	jal	ra,ffffffffc020178a <find_vma>
ffffffffc0201c00:	c909                	beqz	a0,ffffffffc0201c12 <user_mem_check+0x62>
ffffffffc0201c02:	6518                	ld	a4,8(a0)
ffffffffc0201c04:	00e46763          	bltu	s0,a4,ffffffffc0201c12 <user_mem_check+0x62>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
ffffffffc0201c08:	4d1c                	lw	a5,24(a0)
ffffffffc0201c0a:	fc099ce3          	bnez	s3,ffffffffc0201be2 <user_mem_check+0x32>
ffffffffc0201c0e:	8b85                	andi	a5,a5,1
ffffffffc0201c10:	f3ed                	bnez	a5,ffffffffc0201bf2 <user_mem_check+0x42>
            return 0;
ffffffffc0201c12:	4501                	li	a0,0
        }
        return 1;
    }
    return KERN_ACCESS(addr, addr + len);
}
ffffffffc0201c14:	70a2                	ld	ra,40(sp)
ffffffffc0201c16:	7402                	ld	s0,32(sp)
ffffffffc0201c18:	64e2                	ld	s1,24(sp)
ffffffffc0201c1a:	6942                	ld	s2,16(sp)
ffffffffc0201c1c:	69a2                	ld	s3,8(sp)
ffffffffc0201c1e:	6a02                	ld	s4,0(sp)
ffffffffc0201c20:	6145                	addi	sp,sp,48
ffffffffc0201c22:	8082                	ret
    return KERN_ACCESS(addr, addr + len);
ffffffffc0201c24:	c02007b7          	lui	a5,0xc0200
ffffffffc0201c28:	4501                	li	a0,0
ffffffffc0201c2a:	fef5e5e3          	bltu	a1,a5,ffffffffc0201c14 <user_mem_check+0x64>
ffffffffc0201c2e:	962e                	add	a2,a2,a1
ffffffffc0201c30:	fec5f2e3          	bgeu	a1,a2,ffffffffc0201c14 <user_mem_check+0x64>
ffffffffc0201c34:	c8000537          	lui	a0,0xc8000
ffffffffc0201c38:	0505                	addi	a0,a0,1
ffffffffc0201c3a:	00a63533          	sltu	a0,a2,a0
ffffffffc0201c3e:	bfd9                	j	ffffffffc0201c14 <user_mem_check+0x64>
        return 1;
ffffffffc0201c40:	4505                	li	a0,1
ffffffffc0201c42:	bfc9                	j	ffffffffc0201c14 <user_mem_check+0x64>

ffffffffc0201c44 <swap_init>:

static void check_swap(void);

int
swap_init(void)
{
ffffffffc0201c44:	1101                	addi	sp,sp,-32
ffffffffc0201c46:	ec06                	sd	ra,24(sp)
ffffffffc0201c48:	e822                	sd	s0,16(sp)
ffffffffc0201c4a:	e426                	sd	s1,8(sp)
     swapfs_init();
ffffffffc0201c4c:	462010ef          	jal	ra,ffffffffc02030ae <swapfs_init>

     // Since the IDE is faked, it can only store 7 pages at most to pass the test
     if (!(7 <= max_swap_offset &&
ffffffffc0201c50:	00032697          	auipc	a3,0x32
ffffffffc0201c54:	1786b683          	ld	a3,376(a3) # ffffffffc0233dc8 <max_swap_offset>
ffffffffc0201c58:	010007b7          	lui	a5,0x1000
ffffffffc0201c5c:	ff968713          	addi	a4,a3,-7
ffffffffc0201c60:	17e1                	addi	a5,a5,-8
ffffffffc0201c62:	04e7e863          	bltu	a5,a4,ffffffffc0201cb2 <swap_init+0x6e>
        max_swap_offset < MAX_SWAP_OFFSET_LIMIT)) {
        panic("bad max_swap_offset %08x.\n", max_swap_offset);
     }
     

     sm = &swap_manager_fifo;
ffffffffc0201c66:	00027797          	auipc	a5,0x27
ffffffffc0201c6a:	b9278793          	addi	a5,a5,-1134 # ffffffffc02287f8 <swap_manager_fifo>
     int r = sm->init();
ffffffffc0201c6e:	6798                	ld	a4,8(a5)
     sm = &swap_manager_fifo;
ffffffffc0201c70:	00032497          	auipc	s1,0x32
ffffffffc0201c74:	05848493          	addi	s1,s1,88 # ffffffffc0233cc8 <sm>
ffffffffc0201c78:	e09c                	sd	a5,0(s1)
     int r = sm->init();
ffffffffc0201c7a:	9702                	jalr	a4
ffffffffc0201c7c:	842a                	mv	s0,a0
     
     if (r == 0)
ffffffffc0201c7e:	c519                	beqz	a0,ffffffffc0201c8c <swap_init+0x48>
          cprintf("SWAP: manager = %s\n", sm->name);
          //check_swap();
     }

     return r;
}
ffffffffc0201c80:	60e2                	ld	ra,24(sp)
ffffffffc0201c82:	8522                	mv	a0,s0
ffffffffc0201c84:	6442                	ld	s0,16(sp)
ffffffffc0201c86:	64a2                	ld	s1,8(sp)
ffffffffc0201c88:	6105                	addi	sp,sp,32
ffffffffc0201c8a:	8082                	ret
          cprintf("SWAP: manager = %s\n", sm->name);
ffffffffc0201c8c:	609c                	ld	a5,0(s1)
ffffffffc0201c8e:	00004517          	auipc	a0,0x4
ffffffffc0201c92:	d1a50513          	addi	a0,a0,-742 # ffffffffc02059a8 <commands+0xa80>
ffffffffc0201c96:	638c                	ld	a1,0(a5)
          swap_init_ok = 1;
ffffffffc0201c98:	4785                	li	a5,1
ffffffffc0201c9a:	00032717          	auipc	a4,0x32
ffffffffc0201c9e:	02f72b23          	sw	a5,54(a4) # ffffffffc0233cd0 <swap_init_ok>
          cprintf("SWAP: manager = %s\n", sm->name);
ffffffffc0201ca2:	c26fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
}
ffffffffc0201ca6:	60e2                	ld	ra,24(sp)
ffffffffc0201ca8:	8522                	mv	a0,s0
ffffffffc0201caa:	6442                	ld	s0,16(sp)
ffffffffc0201cac:	64a2                	ld	s1,8(sp)
ffffffffc0201cae:	6105                	addi	sp,sp,32
ffffffffc0201cb0:	8082                	ret
        panic("bad max_swap_offset %08x.\n", max_swap_offset);
ffffffffc0201cb2:	00004617          	auipc	a2,0x4
ffffffffc0201cb6:	cc660613          	addi	a2,a2,-826 # ffffffffc0205978 <commands+0xa50>
ffffffffc0201cba:	02800593          	li	a1,40
ffffffffc0201cbe:	00004517          	auipc	a0,0x4
ffffffffc0201cc2:	cda50513          	addi	a0,a0,-806 # ffffffffc0205998 <commands+0xa70>
ffffffffc0201cc6:	d3efe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201cca <swap_init_mm>:

int
swap_init_mm(struct mm_struct *mm)
{
     return sm->init_mm(mm);
ffffffffc0201cca:	00032797          	auipc	a5,0x32
ffffffffc0201cce:	ffe7b783          	ld	a5,-2(a5) # ffffffffc0233cc8 <sm>
ffffffffc0201cd2:	0107b303          	ld	t1,16(a5)
ffffffffc0201cd6:	8302                	jr	t1

ffffffffc0201cd8 <swap_map_swappable>:
}

int
swap_map_swappable(struct mm_struct *mm, uintptr_t addr, struct Page *page, int swap_in)
{
     return sm->map_swappable(mm, addr, page, swap_in);
ffffffffc0201cd8:	00032797          	auipc	a5,0x32
ffffffffc0201cdc:	ff07b783          	ld	a5,-16(a5) # ffffffffc0233cc8 <sm>
ffffffffc0201ce0:	0207b303          	ld	t1,32(a5)
ffffffffc0201ce4:	8302                	jr	t1

ffffffffc0201ce6 <swap_out>:

volatile unsigned int swap_out_num=0;

int
swap_out(struct mm_struct *mm, int n, int in_tick)
{
ffffffffc0201ce6:	711d                	addi	sp,sp,-96
ffffffffc0201ce8:	ec86                	sd	ra,88(sp)
ffffffffc0201cea:	e8a2                	sd	s0,80(sp)
ffffffffc0201cec:	e4a6                	sd	s1,72(sp)
ffffffffc0201cee:	e0ca                	sd	s2,64(sp)
ffffffffc0201cf0:	fc4e                	sd	s3,56(sp)
ffffffffc0201cf2:	f852                	sd	s4,48(sp)
ffffffffc0201cf4:	f456                	sd	s5,40(sp)
ffffffffc0201cf6:	f05a                	sd	s6,32(sp)
ffffffffc0201cf8:	ec5e                	sd	s7,24(sp)
ffffffffc0201cfa:	e862                	sd	s8,16(sp)
     int i;
     for (i = 0; i != n; ++ i)
ffffffffc0201cfc:	cde9                	beqz	a1,ffffffffc0201dd6 <swap_out+0xf0>
ffffffffc0201cfe:	8a2e                	mv	s4,a1
ffffffffc0201d00:	892a                	mv	s2,a0
ffffffffc0201d02:	8ab2                	mv	s5,a2
ffffffffc0201d04:	4401                	li	s0,0
ffffffffc0201d06:	00032997          	auipc	s3,0x32
ffffffffc0201d0a:	fc298993          	addi	s3,s3,-62 # ffffffffc0233cc8 <sm>
                    cprintf("SWAP: failed to save\n");
                    sm->map_swappable(mm, v, page, 0);
                    continue;
          }
          else {
                    cprintf("swap_out: i %d, store page in vaddr 0x%x to disk swap entry %d\n", i, v, page->pra_vaddr/PGSIZE+1);
ffffffffc0201d0e:	00004b17          	auipc	s6,0x4
ffffffffc0201d12:	d12b0b13          	addi	s6,s6,-750 # ffffffffc0205a20 <commands+0xaf8>
                    cprintf("SWAP: failed to save\n");
ffffffffc0201d16:	00004b97          	auipc	s7,0x4
ffffffffc0201d1a:	cf2b8b93          	addi	s7,s7,-782 # ffffffffc0205a08 <commands+0xae0>
ffffffffc0201d1e:	a825                	j	ffffffffc0201d56 <swap_out+0x70>
                    cprintf("swap_out: i %d, store page in vaddr 0x%x to disk swap entry %d\n", i, v, page->pra_vaddr/PGSIZE+1);
ffffffffc0201d20:	67a2                	ld	a5,8(sp)
ffffffffc0201d22:	8626                	mv	a2,s1
ffffffffc0201d24:	85a2                	mv	a1,s0
ffffffffc0201d26:	7f94                	ld	a3,56(a5)
ffffffffc0201d28:	855a                	mv	a0,s6
     for (i = 0; i != n; ++ i)
ffffffffc0201d2a:	2405                	addiw	s0,s0,1
                    cprintf("swap_out: i %d, store page in vaddr 0x%x to disk swap entry %d\n", i, v, page->pra_vaddr/PGSIZE+1);
ffffffffc0201d2c:	82b1                	srli	a3,a3,0xc
ffffffffc0201d2e:	0685                	addi	a3,a3,1
ffffffffc0201d30:	b98fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
                    *ptep = (page->pra_vaddr/PGSIZE+1)<<8;
ffffffffc0201d34:	6522                	ld	a0,8(sp)
                    free_page(page);
ffffffffc0201d36:	4585                	li	a1,1
                    *ptep = (page->pra_vaddr/PGSIZE+1)<<8;
ffffffffc0201d38:	7d1c                	ld	a5,56(a0)
ffffffffc0201d3a:	83b1                	srli	a5,a5,0xc
ffffffffc0201d3c:	0785                	addi	a5,a5,1
ffffffffc0201d3e:	07a2                	slli	a5,a5,0x8
ffffffffc0201d40:	00fc3023          	sd	a5,0(s8)
                    free_page(page);
ffffffffc0201d44:	8a0ff0ef          	jal	ra,ffffffffc0200de4 <free_pages>
          }
          
          tlb_invalidate(mm->pgdir, v);
ffffffffc0201d48:	01893503          	ld	a0,24(s2)
ffffffffc0201d4c:	85a6                	mv	a1,s1
ffffffffc0201d4e:	93dff0ef          	jal	ra,ffffffffc020168a <tlb_invalidate>
     for (i = 0; i != n; ++ i)
ffffffffc0201d52:	048a0d63          	beq	s4,s0,ffffffffc0201dac <swap_out+0xc6>
          int r = sm->swap_out_victim(mm, &page, in_tick);
ffffffffc0201d56:	0009b783          	ld	a5,0(s3)
ffffffffc0201d5a:	8656                	mv	a2,s5
ffffffffc0201d5c:	002c                	addi	a1,sp,8
ffffffffc0201d5e:	7b9c                	ld	a5,48(a5)
ffffffffc0201d60:	854a                	mv	a0,s2
ffffffffc0201d62:	9782                	jalr	a5
          if (r != 0) {
ffffffffc0201d64:	e12d                	bnez	a0,ffffffffc0201dc6 <swap_out+0xe0>
          v=page->pra_vaddr; 
ffffffffc0201d66:	67a2                	ld	a5,8(sp)
          pte_t *ptep = get_pte(mm->pgdir, v, 0);
ffffffffc0201d68:	01893503          	ld	a0,24(s2)
ffffffffc0201d6c:	4601                	li	a2,0
          v=page->pra_vaddr; 
ffffffffc0201d6e:	7f84                	ld	s1,56(a5)
          pte_t *ptep = get_pte(mm->pgdir, v, 0);
ffffffffc0201d70:	85a6                	mv	a1,s1
ffffffffc0201d72:	a46ff0ef          	jal	ra,ffffffffc0200fb8 <get_pte>
          assert((*ptep & PTE_V) != 0);
ffffffffc0201d76:	611c                	ld	a5,0(a0)
          pte_t *ptep = get_pte(mm->pgdir, v, 0);
ffffffffc0201d78:	8c2a                	mv	s8,a0
          assert((*ptep & PTE_V) != 0);
ffffffffc0201d7a:	8b85                	andi	a5,a5,1
ffffffffc0201d7c:	cfb9                	beqz	a5,ffffffffc0201dda <swap_out+0xf4>
          if (swapfs_write( (page->pra_vaddr/PGSIZE+1)<<8, page) != 0) {
ffffffffc0201d7e:	65a2                	ld	a1,8(sp)
ffffffffc0201d80:	7d9c                	ld	a5,56(a1)
ffffffffc0201d82:	83b1                	srli	a5,a5,0xc
ffffffffc0201d84:	0785                	addi	a5,a5,1
ffffffffc0201d86:	00879513          	slli	a0,a5,0x8
ffffffffc0201d8a:	3ea010ef          	jal	ra,ffffffffc0203174 <swapfs_write>
ffffffffc0201d8e:	d949                	beqz	a0,ffffffffc0201d20 <swap_out+0x3a>
                    cprintf("SWAP: failed to save\n");
ffffffffc0201d90:	855e                	mv	a0,s7
ffffffffc0201d92:	b36fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
                    sm->map_swappable(mm, v, page, 0);
ffffffffc0201d96:	0009b783          	ld	a5,0(s3)
ffffffffc0201d9a:	6622                	ld	a2,8(sp)
ffffffffc0201d9c:	4681                	li	a3,0
ffffffffc0201d9e:	739c                	ld	a5,32(a5)
ffffffffc0201da0:	85a6                	mv	a1,s1
ffffffffc0201da2:	854a                	mv	a0,s2
     for (i = 0; i != n; ++ i)
ffffffffc0201da4:	2405                	addiw	s0,s0,1
                    sm->map_swappable(mm, v, page, 0);
ffffffffc0201da6:	9782                	jalr	a5
     for (i = 0; i != n; ++ i)
ffffffffc0201da8:	fa8a17e3          	bne	s4,s0,ffffffffc0201d56 <swap_out+0x70>
     }
     return i;
}
ffffffffc0201dac:	60e6                	ld	ra,88(sp)
ffffffffc0201dae:	8522                	mv	a0,s0
ffffffffc0201db0:	6446                	ld	s0,80(sp)
ffffffffc0201db2:	64a6                	ld	s1,72(sp)
ffffffffc0201db4:	6906                	ld	s2,64(sp)
ffffffffc0201db6:	79e2                	ld	s3,56(sp)
ffffffffc0201db8:	7a42                	ld	s4,48(sp)
ffffffffc0201dba:	7aa2                	ld	s5,40(sp)
ffffffffc0201dbc:	7b02                	ld	s6,32(sp)
ffffffffc0201dbe:	6be2                	ld	s7,24(sp)
ffffffffc0201dc0:	6c42                	ld	s8,16(sp)
ffffffffc0201dc2:	6125                	addi	sp,sp,96
ffffffffc0201dc4:	8082                	ret
                    cprintf("i %d, swap_out: call swap_out_victim failed\n",i);
ffffffffc0201dc6:	85a2                	mv	a1,s0
ffffffffc0201dc8:	00004517          	auipc	a0,0x4
ffffffffc0201dcc:	bf850513          	addi	a0,a0,-1032 # ffffffffc02059c0 <commands+0xa98>
ffffffffc0201dd0:	af8fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
                  break;
ffffffffc0201dd4:	bfe1                	j	ffffffffc0201dac <swap_out+0xc6>
     for (i = 0; i != n; ++ i)
ffffffffc0201dd6:	4401                	li	s0,0
ffffffffc0201dd8:	bfd1                	j	ffffffffc0201dac <swap_out+0xc6>
          assert((*ptep & PTE_V) != 0);
ffffffffc0201dda:	00004697          	auipc	a3,0x4
ffffffffc0201dde:	c1668693          	addi	a3,a3,-1002 # ffffffffc02059f0 <commands+0xac8>
ffffffffc0201de2:	00003617          	auipc	a2,0x3
ffffffffc0201de6:	54e60613          	addi	a2,a2,1358 # ffffffffc0205330 <commands+0x408>
ffffffffc0201dea:	06800593          	li	a1,104
ffffffffc0201dee:	00004517          	auipc	a0,0x4
ffffffffc0201df2:	baa50513          	addi	a0,a0,-1110 # ffffffffc0205998 <commands+0xa70>
ffffffffc0201df6:	c0efe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201dfa <swap_in>:

int
swap_in(struct mm_struct *mm, uintptr_t addr, struct Page **ptr_result)
{
ffffffffc0201dfa:	7179                	addi	sp,sp,-48
ffffffffc0201dfc:	e84a                	sd	s2,16(sp)
ffffffffc0201dfe:	892a                	mv	s2,a0
     struct Page *result = alloc_page();
ffffffffc0201e00:	4505                	li	a0,1
{
ffffffffc0201e02:	ec26                	sd	s1,24(sp)
ffffffffc0201e04:	e44e                	sd	s3,8(sp)
ffffffffc0201e06:	f406                	sd	ra,40(sp)
ffffffffc0201e08:	f022                	sd	s0,32(sp)
ffffffffc0201e0a:	84ae                	mv	s1,a1
ffffffffc0201e0c:	89b2                	mv	s3,a2
     struct Page *result = alloc_page();
ffffffffc0201e0e:	f45fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
     assert(result!=NULL);
ffffffffc0201e12:	c129                	beqz	a0,ffffffffc0201e54 <swap_in+0x5a>

     pte_t *ptep = get_pte(mm->pgdir, addr, 0);
ffffffffc0201e14:	842a                	mv	s0,a0
ffffffffc0201e16:	01893503          	ld	a0,24(s2)
ffffffffc0201e1a:	4601                	li	a2,0
ffffffffc0201e1c:	85a6                	mv	a1,s1
ffffffffc0201e1e:	99aff0ef          	jal	ra,ffffffffc0200fb8 <get_pte>
ffffffffc0201e22:	892a                	mv	s2,a0
     // cprintf("SWAP: load ptep %x swap entry %d to vaddr 0x%08x, page %x, No %d\n", ptep, (*ptep)>>8, addr, result, (result-pages));
    
     int r;
     if ((r = swapfs_read((*ptep), result)) != 0)
ffffffffc0201e24:	6108                	ld	a0,0(a0)
ffffffffc0201e26:	85a2                	mv	a1,s0
ffffffffc0201e28:	2be010ef          	jal	ra,ffffffffc02030e6 <swapfs_read>
     {
        assert(r!=0);
     }
     cprintf("swap_in: load disk swap entry %d with swap_page in vadr 0x%x\n", (*ptep)>>8, addr);
ffffffffc0201e2c:	00093583          	ld	a1,0(s2)
ffffffffc0201e30:	8626                	mv	a2,s1
ffffffffc0201e32:	00004517          	auipc	a0,0x4
ffffffffc0201e36:	c3e50513          	addi	a0,a0,-962 # ffffffffc0205a70 <commands+0xb48>
ffffffffc0201e3a:	81a1                	srli	a1,a1,0x8
ffffffffc0201e3c:	a8cfe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
     *ptr_result=result;
     return 0;
}
ffffffffc0201e40:	70a2                	ld	ra,40(sp)
     *ptr_result=result;
ffffffffc0201e42:	0089b023          	sd	s0,0(s3)
}
ffffffffc0201e46:	7402                	ld	s0,32(sp)
ffffffffc0201e48:	64e2                	ld	s1,24(sp)
ffffffffc0201e4a:	6942                	ld	s2,16(sp)
ffffffffc0201e4c:	69a2                	ld	s3,8(sp)
ffffffffc0201e4e:	4501                	li	a0,0
ffffffffc0201e50:	6145                	addi	sp,sp,48
ffffffffc0201e52:	8082                	ret
     assert(result!=NULL);
ffffffffc0201e54:	00004697          	auipc	a3,0x4
ffffffffc0201e58:	c0c68693          	addi	a3,a3,-1012 # ffffffffc0205a60 <commands+0xb38>
ffffffffc0201e5c:	00003617          	auipc	a2,0x3
ffffffffc0201e60:	4d460613          	addi	a2,a2,1236 # ffffffffc0205330 <commands+0x408>
ffffffffc0201e64:	07e00593          	li	a1,126
ffffffffc0201e68:	00004517          	auipc	a0,0x4
ffffffffc0201e6c:	b3050513          	addi	a0,a0,-1232 # ffffffffc0205998 <commands+0xa70>
ffffffffc0201e70:	b94fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201e74 <slob_free>:
static void slob_free(void *block, int size)
{
	slob_t *cur, *b = (slob_t *)block;
	unsigned long flags;

	if (!block)
ffffffffc0201e74:	c145                	beqz	a0,ffffffffc0201f14 <slob_free+0xa0>
{
ffffffffc0201e76:	1141                	addi	sp,sp,-16
ffffffffc0201e78:	e022                	sd	s0,0(sp)
ffffffffc0201e7a:	e406                	sd	ra,8(sp)
ffffffffc0201e7c:	842a                	mv	s0,a0
		return;

	if (size)
ffffffffc0201e7e:	edb1                	bnez	a1,ffffffffc0201eda <slob_free+0x66>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0201e80:	100027f3          	csrr	a5,sstatus
ffffffffc0201e84:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0201e86:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0201e88:	e3ad                	bnez	a5,ffffffffc0201eea <slob_free+0x76>
		b->units = SLOB_UNITS(size);

	/* Find reinsertion point */
	spin_lock_irqsave(&slob_lock, flags);
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0201e8a:	00027617          	auipc	a2,0x27
ffffffffc0201e8e:	9de60613          	addi	a2,a2,-1570 # ffffffffc0228868 <slobfree>
ffffffffc0201e92:	621c                	ld	a5,0(a2)
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201e94:	6798                	ld	a4,8(a5)
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0201e96:	0087fa63          	bgeu	a5,s0,ffffffffc0201eaa <slob_free+0x36>
ffffffffc0201e9a:	00e46c63          	bltu	s0,a4,ffffffffc0201eb2 <slob_free+0x3e>
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201e9e:	00e7fa63          	bgeu	a5,a4,ffffffffc0201eb2 <slob_free+0x3e>
    return 0;
ffffffffc0201ea2:	87ba                	mv	a5,a4
ffffffffc0201ea4:	6798                	ld	a4,8(a5)
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0201ea6:	fe87eae3          	bltu	a5,s0,ffffffffc0201e9a <slob_free+0x26>
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201eaa:	fee7ece3          	bltu	a5,a4,ffffffffc0201ea2 <slob_free+0x2e>
ffffffffc0201eae:	fee47ae3          	bgeu	s0,a4,ffffffffc0201ea2 <slob_free+0x2e>
			break;

	if (b + b->units == cur->next) {
ffffffffc0201eb2:	400c                	lw	a1,0(s0)
ffffffffc0201eb4:	00459693          	slli	a3,a1,0x4
ffffffffc0201eb8:	96a2                	add	a3,a3,s0
ffffffffc0201eba:	04d70763          	beq	a4,a3,ffffffffc0201f08 <slob_free+0x94>
		b->units += cur->next->units;
		b->next = cur->next->next;
	} else
		b->next = cur->next;
ffffffffc0201ebe:	e418                	sd	a4,8(s0)

	if (cur + cur->units == b) {
ffffffffc0201ec0:	4394                	lw	a3,0(a5)
ffffffffc0201ec2:	00469713          	slli	a4,a3,0x4
ffffffffc0201ec6:	973e                	add	a4,a4,a5
ffffffffc0201ec8:	02e40a63          	beq	s0,a4,ffffffffc0201efc <slob_free+0x88>
		cur->units += b->units;
		cur->next = b->next;
	} else
		cur->next = b;
ffffffffc0201ecc:	e780                	sd	s0,8(a5)

	slobfree = cur;
ffffffffc0201ece:	e21c                	sd	a5,0(a2)
    if (flag) {
ffffffffc0201ed0:	e10d                	bnez	a0,ffffffffc0201ef2 <slob_free+0x7e>

	spin_unlock_irqrestore(&slob_lock, flags);
}
ffffffffc0201ed2:	60a2                	ld	ra,8(sp)
ffffffffc0201ed4:	6402                	ld	s0,0(sp)
ffffffffc0201ed6:	0141                	addi	sp,sp,16
ffffffffc0201ed8:	8082                	ret
		b->units = SLOB_UNITS(size);
ffffffffc0201eda:	05bd                	addi	a1,a1,15
ffffffffc0201edc:	8191                	srli	a1,a1,0x4
ffffffffc0201ede:	c10c                	sw	a1,0(a0)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0201ee0:	100027f3          	csrr	a5,sstatus
ffffffffc0201ee4:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0201ee6:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0201ee8:	d3cd                	beqz	a5,ffffffffc0201e8a <slob_free+0x16>
        intr_disable();
ffffffffc0201eea:	f48fe0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc0201eee:	4505                	li	a0,1
ffffffffc0201ef0:	bf69                	j	ffffffffc0201e8a <slob_free+0x16>
}
ffffffffc0201ef2:	6402                	ld	s0,0(sp)
ffffffffc0201ef4:	60a2                	ld	ra,8(sp)
ffffffffc0201ef6:	0141                	addi	sp,sp,16
        intr_enable();
ffffffffc0201ef8:	f34fe06f          	j	ffffffffc020062c <intr_enable>
		cur->units += b->units;
ffffffffc0201efc:	4018                	lw	a4,0(s0)
		cur->next = b->next;
ffffffffc0201efe:	640c                	ld	a1,8(s0)
		cur->units += b->units;
ffffffffc0201f00:	9eb9                	addw	a3,a3,a4
ffffffffc0201f02:	c394                	sw	a3,0(a5)
		cur->next = b->next;
ffffffffc0201f04:	e78c                	sd	a1,8(a5)
ffffffffc0201f06:	b7e1                	j	ffffffffc0201ece <slob_free+0x5a>
		b->units += cur->next->units;
ffffffffc0201f08:	4314                	lw	a3,0(a4)
		b->next = cur->next->next;
ffffffffc0201f0a:	6718                	ld	a4,8(a4)
		b->units += cur->next->units;
ffffffffc0201f0c:	9db5                	addw	a1,a1,a3
ffffffffc0201f0e:	c00c                	sw	a1,0(s0)
		b->next = cur->next->next;
ffffffffc0201f10:	e418                	sd	a4,8(s0)
ffffffffc0201f12:	b77d                	j	ffffffffc0201ec0 <slob_free+0x4c>
ffffffffc0201f14:	8082                	ret

ffffffffc0201f16 <__slob_get_free_pages.isra.0>:
  struct Page * page = alloc_pages(1 << order);
ffffffffc0201f16:	4785                	li	a5,1
static void* __slob_get_free_pages(gfp_t gfp, int order)
ffffffffc0201f18:	1141                	addi	sp,sp,-16
  struct Page * page = alloc_pages(1 << order);
ffffffffc0201f1a:	00a7953b          	sllw	a0,a5,a0
static void* __slob_get_free_pages(gfp_t gfp, int order)
ffffffffc0201f1e:	e406                	sd	ra,8(sp)
  struct Page * page = alloc_pages(1 << order);
ffffffffc0201f20:	e33fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
  if(!page)
ffffffffc0201f24:	c91d                	beqz	a0,ffffffffc0201f5a <__slob_get_free_pages.isra.0+0x44>
    return page - pages + nbase;
ffffffffc0201f26:	00032697          	auipc	a3,0x32
ffffffffc0201f2a:	e0a6b683          	ld	a3,-502(a3) # ffffffffc0233d30 <pages>
ffffffffc0201f2e:	8d15                	sub	a0,a0,a3
ffffffffc0201f30:	8519                	srai	a0,a0,0x6
ffffffffc0201f32:	00005697          	auipc	a3,0x5
ffffffffc0201f36:	b766b683          	ld	a3,-1162(a3) # ffffffffc0206aa8 <nbase>
ffffffffc0201f3a:	9536                	add	a0,a0,a3
    return KADDR(page2pa(page));
ffffffffc0201f3c:	00c51793          	slli	a5,a0,0xc
ffffffffc0201f40:	83b1                	srli	a5,a5,0xc
ffffffffc0201f42:	00032717          	auipc	a4,0x32
ffffffffc0201f46:	d7673703          	ld	a4,-650(a4) # ffffffffc0233cb8 <npage>
    return page2ppn(page) << PGSHIFT;
ffffffffc0201f4a:	0532                	slli	a0,a0,0xc
    return KADDR(page2pa(page));
ffffffffc0201f4c:	00e7fa63          	bgeu	a5,a4,ffffffffc0201f60 <__slob_get_free_pages.isra.0+0x4a>
ffffffffc0201f50:	00032697          	auipc	a3,0x32
ffffffffc0201f54:	dd06b683          	ld	a3,-560(a3) # ffffffffc0233d20 <va_pa_offset>
ffffffffc0201f58:	9536                	add	a0,a0,a3
}
ffffffffc0201f5a:	60a2                	ld	ra,8(sp)
ffffffffc0201f5c:	0141                	addi	sp,sp,16
ffffffffc0201f5e:	8082                	ret
ffffffffc0201f60:	86aa                	mv	a3,a0
ffffffffc0201f62:	00003617          	auipc	a2,0x3
ffffffffc0201f66:	77e60613          	addi	a2,a2,1918 # ffffffffc02056e0 <commands+0x7b8>
ffffffffc0201f6a:	06900593          	li	a1,105
ffffffffc0201f6e:	00003517          	auipc	a0,0x3
ffffffffc0201f72:	6d250513          	addi	a0,a0,1746 # ffffffffc0205640 <commands+0x718>
ffffffffc0201f76:	a8efe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201f7a <slob_alloc.isra.0.constprop.0>:
static void *slob_alloc(size_t size, gfp_t gfp, int align)
ffffffffc0201f7a:	1101                	addi	sp,sp,-32
ffffffffc0201f7c:	ec06                	sd	ra,24(sp)
ffffffffc0201f7e:	e822                	sd	s0,16(sp)
ffffffffc0201f80:	e426                	sd	s1,8(sp)
ffffffffc0201f82:	e04a                	sd	s2,0(sp)
  assert( (size + SLOB_UNIT) < PAGE_SIZE );
ffffffffc0201f84:	01050713          	addi	a4,a0,16
ffffffffc0201f88:	6785                	lui	a5,0x1
ffffffffc0201f8a:	0cf77363          	bgeu	a4,a5,ffffffffc0202050 <slob_alloc.isra.0.constprop.0+0xd6>
	int delta = 0, units = SLOB_UNITS(size);
ffffffffc0201f8e:	00f50493          	addi	s1,a0,15
ffffffffc0201f92:	8091                	srli	s1,s1,0x4
ffffffffc0201f94:	2481                	sext.w	s1,s1
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0201f96:	10002673          	csrr	a2,sstatus
ffffffffc0201f9a:	8a09                	andi	a2,a2,2
ffffffffc0201f9c:	e25d                	bnez	a2,ffffffffc0202042 <slob_alloc.isra.0.constprop.0+0xc8>
	prev = slobfree;
ffffffffc0201f9e:	00027917          	auipc	s2,0x27
ffffffffc0201fa2:	8ca90913          	addi	s2,s2,-1846 # ffffffffc0228868 <slobfree>
ffffffffc0201fa6:	00093683          	ld	a3,0(s2)
	for (cur = prev->next; ; prev = cur, cur = cur->next) {
ffffffffc0201faa:	669c                	ld	a5,8(a3)
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc0201fac:	4398                	lw	a4,0(a5)
ffffffffc0201fae:	08975e63          	bge	a4,s1,ffffffffc020204a <slob_alloc.isra.0.constprop.0+0xd0>
		if (cur == slobfree) {
ffffffffc0201fb2:	00d78b63          	beq	a5,a3,ffffffffc0201fc8 <slob_alloc.isra.0.constprop.0+0x4e>
	for (cur = prev->next; ; prev = cur, cur = cur->next) {
ffffffffc0201fb6:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc0201fb8:	4018                	lw	a4,0(s0)
ffffffffc0201fba:	02975a63          	bge	a4,s1,ffffffffc0201fee <slob_alloc.isra.0.constprop.0+0x74>
ffffffffc0201fbe:	00093683          	ld	a3,0(s2)
ffffffffc0201fc2:	87a2                	mv	a5,s0
		if (cur == slobfree) {
ffffffffc0201fc4:	fed799e3          	bne	a5,a3,ffffffffc0201fb6 <slob_alloc.isra.0.constprop.0+0x3c>
    if (flag) {
ffffffffc0201fc8:	ee31                	bnez	a2,ffffffffc0202024 <slob_alloc.isra.0.constprop.0+0xaa>
			cur = (slob_t *)__slob_get_free_page(gfp);
ffffffffc0201fca:	4501                	li	a0,0
ffffffffc0201fcc:	f4bff0ef          	jal	ra,ffffffffc0201f16 <__slob_get_free_pages.isra.0>
ffffffffc0201fd0:	842a                	mv	s0,a0
			if (!cur)
ffffffffc0201fd2:	cd05                	beqz	a0,ffffffffc020200a <slob_alloc.isra.0.constprop.0+0x90>
			slob_free(cur, PAGE_SIZE);
ffffffffc0201fd4:	6585                	lui	a1,0x1
ffffffffc0201fd6:	e9fff0ef          	jal	ra,ffffffffc0201e74 <slob_free>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0201fda:	10002673          	csrr	a2,sstatus
ffffffffc0201fde:	8a09                	andi	a2,a2,2
ffffffffc0201fe0:	ee05                	bnez	a2,ffffffffc0202018 <slob_alloc.isra.0.constprop.0+0x9e>
			cur = slobfree;
ffffffffc0201fe2:	00093783          	ld	a5,0(s2)
	for (cur = prev->next; ; prev = cur, cur = cur->next) {
ffffffffc0201fe6:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc0201fe8:	4018                	lw	a4,0(s0)
ffffffffc0201fea:	fc974ae3          	blt	a4,s1,ffffffffc0201fbe <slob_alloc.isra.0.constprop.0+0x44>
			if (cur->units == units) /* exact fit? */
ffffffffc0201fee:	04e48763          	beq	s1,a4,ffffffffc020203c <slob_alloc.isra.0.constprop.0+0xc2>
				prev->next = cur + units;
ffffffffc0201ff2:	00449693          	slli	a3,s1,0x4
ffffffffc0201ff6:	96a2                	add	a3,a3,s0
ffffffffc0201ff8:	e794                	sd	a3,8(a5)
				prev->next->next = cur->next;
ffffffffc0201ffa:	640c                	ld	a1,8(s0)
				prev->next->units = cur->units - units;
ffffffffc0201ffc:	9f05                	subw	a4,a4,s1
ffffffffc0201ffe:	c298                	sw	a4,0(a3)
				prev->next->next = cur->next;
ffffffffc0202000:	e68c                	sd	a1,8(a3)
				cur->units = units;
ffffffffc0202002:	c004                	sw	s1,0(s0)
			slobfree = prev;
ffffffffc0202004:	00f93023          	sd	a5,0(s2)
    if (flag) {
ffffffffc0202008:	e20d                	bnez	a2,ffffffffc020202a <slob_alloc.isra.0.constprop.0+0xb0>
}
ffffffffc020200a:	60e2                	ld	ra,24(sp)
ffffffffc020200c:	8522                	mv	a0,s0
ffffffffc020200e:	6442                	ld	s0,16(sp)
ffffffffc0202010:	64a2                	ld	s1,8(sp)
ffffffffc0202012:	6902                	ld	s2,0(sp)
ffffffffc0202014:	6105                	addi	sp,sp,32
ffffffffc0202016:	8082                	ret
        intr_disable();
ffffffffc0202018:	e1afe0ef          	jal	ra,ffffffffc0200632 <intr_disable>
			cur = slobfree;
ffffffffc020201c:	00093783          	ld	a5,0(s2)
        return 1;
ffffffffc0202020:	4605                	li	a2,1
ffffffffc0202022:	b7d1                	j	ffffffffc0201fe6 <slob_alloc.isra.0.constprop.0+0x6c>
        intr_enable();
ffffffffc0202024:	e08fe0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc0202028:	b74d                	j	ffffffffc0201fca <slob_alloc.isra.0.constprop.0+0x50>
ffffffffc020202a:	e02fe0ef          	jal	ra,ffffffffc020062c <intr_enable>
}
ffffffffc020202e:	60e2                	ld	ra,24(sp)
ffffffffc0202030:	8522                	mv	a0,s0
ffffffffc0202032:	6442                	ld	s0,16(sp)
ffffffffc0202034:	64a2                	ld	s1,8(sp)
ffffffffc0202036:	6902                	ld	s2,0(sp)
ffffffffc0202038:	6105                	addi	sp,sp,32
ffffffffc020203a:	8082                	ret
				prev->next = cur->next; /* unlink */
ffffffffc020203c:	6418                	ld	a4,8(s0)
ffffffffc020203e:	e798                	sd	a4,8(a5)
ffffffffc0202040:	b7d1                	j	ffffffffc0202004 <slob_alloc.isra.0.constprop.0+0x8a>
        intr_disable();
ffffffffc0202042:	df0fe0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc0202046:	4605                	li	a2,1
ffffffffc0202048:	bf99                	j	ffffffffc0201f9e <slob_alloc.isra.0.constprop.0+0x24>
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc020204a:	843e                	mv	s0,a5
ffffffffc020204c:	87b6                	mv	a5,a3
ffffffffc020204e:	b745                	j	ffffffffc0201fee <slob_alloc.isra.0.constprop.0+0x74>
  assert( (size + SLOB_UNIT) < PAGE_SIZE );
ffffffffc0202050:	00004697          	auipc	a3,0x4
ffffffffc0202054:	a6068693          	addi	a3,a3,-1440 # ffffffffc0205ab0 <commands+0xb88>
ffffffffc0202058:	00003617          	auipc	a2,0x3
ffffffffc020205c:	2d860613          	addi	a2,a2,728 # ffffffffc0205330 <commands+0x408>
ffffffffc0202060:	06400593          	li	a1,100
ffffffffc0202064:	00004517          	auipc	a0,0x4
ffffffffc0202068:	a6c50513          	addi	a0,a0,-1428 # ffffffffc0205ad0 <commands+0xba8>
ffffffffc020206c:	998fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0202070 <kmalloc_init>:

inline void 
kmalloc_init(void) {
    slob_init();
    //cprintf("kmalloc_init() succeeded!\n");
}
ffffffffc0202070:	8082                	ret

ffffffffc0202072 <kallocated>:
}

size_t
kallocated(void) {
   return slob_allocated();
}
ffffffffc0202072:	4501                	li	a0,0
ffffffffc0202074:	8082                	ret

ffffffffc0202076 <kmalloc>:
	return 0;
}

void *
kmalloc(size_t size)
{
ffffffffc0202076:	1101                	addi	sp,sp,-32
ffffffffc0202078:	e04a                	sd	s2,0(sp)
	if (size < PAGE_SIZE - SLOB_UNIT) {
ffffffffc020207a:	6905                	lui	s2,0x1
{
ffffffffc020207c:	e822                	sd	s0,16(sp)
ffffffffc020207e:	ec06                	sd	ra,24(sp)
ffffffffc0202080:	e426                	sd	s1,8(sp)
	if (size < PAGE_SIZE - SLOB_UNIT) {
ffffffffc0202082:	fef90793          	addi	a5,s2,-17 # fef <_binary_obj___user_hello_out_size-0x88c9>
{
ffffffffc0202086:	842a                	mv	s0,a0
	if (size < PAGE_SIZE - SLOB_UNIT) {
ffffffffc0202088:	04a7f963          	bgeu	a5,a0,ffffffffc02020da <kmalloc+0x64>
	bb = slob_alloc(sizeof(bigblock_t), gfp, 0);
ffffffffc020208c:	4561                	li	a0,24
ffffffffc020208e:	eedff0ef          	jal	ra,ffffffffc0201f7a <slob_alloc.isra.0.constprop.0>
ffffffffc0202092:	84aa                	mv	s1,a0
	if (!bb)
ffffffffc0202094:	c929                	beqz	a0,ffffffffc02020e6 <kmalloc+0x70>
	bb->order = find_order(size);
ffffffffc0202096:	0004079b          	sext.w	a5,s0
	int order = 0;
ffffffffc020209a:	4501                	li	a0,0
	for ( ; size > 4096 ; size >>=1)
ffffffffc020209c:	00f95763          	bge	s2,a5,ffffffffc02020aa <kmalloc+0x34>
ffffffffc02020a0:	6705                	lui	a4,0x1
ffffffffc02020a2:	8785                	srai	a5,a5,0x1
		order++;
ffffffffc02020a4:	2505                	addiw	a0,a0,1
	for ( ; size > 4096 ; size >>=1)
ffffffffc02020a6:	fef74ee3          	blt	a4,a5,ffffffffc02020a2 <kmalloc+0x2c>
	bb->order = find_order(size);
ffffffffc02020aa:	c088                	sw	a0,0(s1)
	bb->pages = (void *)__slob_get_free_pages(gfp, bb->order);
ffffffffc02020ac:	e6bff0ef          	jal	ra,ffffffffc0201f16 <__slob_get_free_pages.isra.0>
ffffffffc02020b0:	e488                	sd	a0,8(s1)
ffffffffc02020b2:	842a                	mv	s0,a0
	if (bb->pages) {
ffffffffc02020b4:	c525                	beqz	a0,ffffffffc020211c <kmalloc+0xa6>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02020b6:	100027f3          	csrr	a5,sstatus
ffffffffc02020ba:	8b89                	andi	a5,a5,2
ffffffffc02020bc:	ef8d                	bnez	a5,ffffffffc02020f6 <kmalloc+0x80>
		bb->next = bigblocks;
ffffffffc02020be:	00032797          	auipc	a5,0x32
ffffffffc02020c2:	c1a78793          	addi	a5,a5,-998 # ffffffffc0233cd8 <bigblocks>
ffffffffc02020c6:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc02020c8:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc02020ca:	e898                	sd	a4,16(s1)
  return __kmalloc(size, 0);
}
ffffffffc02020cc:	60e2                	ld	ra,24(sp)
ffffffffc02020ce:	8522                	mv	a0,s0
ffffffffc02020d0:	6442                	ld	s0,16(sp)
ffffffffc02020d2:	64a2                	ld	s1,8(sp)
ffffffffc02020d4:	6902                	ld	s2,0(sp)
ffffffffc02020d6:	6105                	addi	sp,sp,32
ffffffffc02020d8:	8082                	ret
		m = slob_alloc(size + SLOB_UNIT, gfp, 0);
ffffffffc02020da:	0541                	addi	a0,a0,16
ffffffffc02020dc:	e9fff0ef          	jal	ra,ffffffffc0201f7a <slob_alloc.isra.0.constprop.0>
		return m ? (void *)(m + 1) : 0;
ffffffffc02020e0:	01050413          	addi	s0,a0,16
ffffffffc02020e4:	f565                	bnez	a0,ffffffffc02020cc <kmalloc+0x56>
ffffffffc02020e6:	4401                	li	s0,0
}
ffffffffc02020e8:	60e2                	ld	ra,24(sp)
ffffffffc02020ea:	8522                	mv	a0,s0
ffffffffc02020ec:	6442                	ld	s0,16(sp)
ffffffffc02020ee:	64a2                	ld	s1,8(sp)
ffffffffc02020f0:	6902                	ld	s2,0(sp)
ffffffffc02020f2:	6105                	addi	sp,sp,32
ffffffffc02020f4:	8082                	ret
        intr_disable();
ffffffffc02020f6:	d3cfe0ef          	jal	ra,ffffffffc0200632 <intr_disable>
		bb->next = bigblocks;
ffffffffc02020fa:	00032797          	auipc	a5,0x32
ffffffffc02020fe:	bde78793          	addi	a5,a5,-1058 # ffffffffc0233cd8 <bigblocks>
ffffffffc0202102:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc0202104:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc0202106:	e898                	sd	a4,16(s1)
        intr_enable();
ffffffffc0202108:	d24fe0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc020210c:	6480                	ld	s0,8(s1)
}
ffffffffc020210e:	60e2                	ld	ra,24(sp)
ffffffffc0202110:	64a2                	ld	s1,8(sp)
ffffffffc0202112:	8522                	mv	a0,s0
ffffffffc0202114:	6442                	ld	s0,16(sp)
ffffffffc0202116:	6902                	ld	s2,0(sp)
ffffffffc0202118:	6105                	addi	sp,sp,32
ffffffffc020211a:	8082                	ret
	slob_free(bb, sizeof(bigblock_t));
ffffffffc020211c:	45e1                	li	a1,24
ffffffffc020211e:	8526                	mv	a0,s1
ffffffffc0202120:	d55ff0ef          	jal	ra,ffffffffc0201e74 <slob_free>
  return __kmalloc(size, 0);
ffffffffc0202124:	b765                	j	ffffffffc02020cc <kmalloc+0x56>

ffffffffc0202126 <kfree>:
void kfree(void *block)
{
	bigblock_t *bb, **last = &bigblocks;
	unsigned long flags;

	if (!block)
ffffffffc0202126:	c169                	beqz	a0,ffffffffc02021e8 <kfree+0xc2>
{
ffffffffc0202128:	1101                	addi	sp,sp,-32
ffffffffc020212a:	e822                	sd	s0,16(sp)
ffffffffc020212c:	ec06                	sd	ra,24(sp)
ffffffffc020212e:	e426                	sd	s1,8(sp)
		return;

	if (!((unsigned long)block & (PAGE_SIZE-1))) {
ffffffffc0202130:	03451793          	slli	a5,a0,0x34
ffffffffc0202134:	842a                	mv	s0,a0
ffffffffc0202136:	e7c9                	bnez	a5,ffffffffc02021c0 <kfree+0x9a>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0202138:	100027f3          	csrr	a5,sstatus
ffffffffc020213c:	8b89                	andi	a5,a5,2
ffffffffc020213e:	ebc9                	bnez	a5,ffffffffc02021d0 <kfree+0xaa>
		/* might be on the big block list */
		spin_lock_irqsave(&block_lock, flags);
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
ffffffffc0202140:	00032797          	auipc	a5,0x32
ffffffffc0202144:	b987b783          	ld	a5,-1128(a5) # ffffffffc0233cd8 <bigblocks>
    return 0;
ffffffffc0202148:	4601                	li	a2,0
ffffffffc020214a:	cbbd                	beqz	a5,ffffffffc02021c0 <kfree+0x9a>
	bigblock_t *bb, **last = &bigblocks;
ffffffffc020214c:	00032697          	auipc	a3,0x32
ffffffffc0202150:	b8c68693          	addi	a3,a3,-1140 # ffffffffc0233cd8 <bigblocks>
ffffffffc0202154:	a021                	j	ffffffffc020215c <kfree+0x36>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
ffffffffc0202156:	01048693          	addi	a3,s1,16
ffffffffc020215a:	c3a5                	beqz	a5,ffffffffc02021ba <kfree+0x94>
			if (bb->pages == block) {
ffffffffc020215c:	6798                	ld	a4,8(a5)
ffffffffc020215e:	84be                	mv	s1,a5
ffffffffc0202160:	6b9c                	ld	a5,16(a5)
ffffffffc0202162:	fe871ae3          	bne	a4,s0,ffffffffc0202156 <kfree+0x30>
				*last = bb->next;
ffffffffc0202166:	e29c                	sd	a5,0(a3)
    if (flag) {
ffffffffc0202168:	ee2d                	bnez	a2,ffffffffc02021e2 <kfree+0xbc>
    return pa2page(PADDR(kva));
ffffffffc020216a:	c02007b7          	lui	a5,0xc0200
				spin_unlock_irqrestore(&block_lock, flags);
				__slob_free_pages((unsigned long)block, bb->order);
ffffffffc020216e:	4098                	lw	a4,0(s1)
ffffffffc0202170:	08f46963          	bltu	s0,a5,ffffffffc0202202 <kfree+0xdc>
ffffffffc0202174:	00032697          	auipc	a3,0x32
ffffffffc0202178:	bac6b683          	ld	a3,-1108(a3) # ffffffffc0233d20 <va_pa_offset>
ffffffffc020217c:	8c15                	sub	s0,s0,a3
    if (PPN(pa) >= npage) {
ffffffffc020217e:	8031                	srli	s0,s0,0xc
ffffffffc0202180:	00032797          	auipc	a5,0x32
ffffffffc0202184:	b387b783          	ld	a5,-1224(a5) # ffffffffc0233cb8 <npage>
ffffffffc0202188:	06f47163          	bgeu	s0,a5,ffffffffc02021ea <kfree+0xc4>
    return &pages[PPN(pa) - nbase];
ffffffffc020218c:	00005517          	auipc	a0,0x5
ffffffffc0202190:	91c53503          	ld	a0,-1764(a0) # ffffffffc0206aa8 <nbase>
ffffffffc0202194:	8c09                	sub	s0,s0,a0
ffffffffc0202196:	041a                	slli	s0,s0,0x6
  free_pages(kva2page(kva), 1 << order);
ffffffffc0202198:	00032517          	auipc	a0,0x32
ffffffffc020219c:	b9853503          	ld	a0,-1128(a0) # ffffffffc0233d30 <pages>
ffffffffc02021a0:	4585                	li	a1,1
ffffffffc02021a2:	9522                	add	a0,a0,s0
ffffffffc02021a4:	00e595bb          	sllw	a1,a1,a4
ffffffffc02021a8:	c3dfe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
		spin_unlock_irqrestore(&block_lock, flags);
	}

	slob_free((slob_t *)block - 1, 0);
	return;
}
ffffffffc02021ac:	6442                	ld	s0,16(sp)
ffffffffc02021ae:	60e2                	ld	ra,24(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc02021b0:	8526                	mv	a0,s1
}
ffffffffc02021b2:	64a2                	ld	s1,8(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc02021b4:	45e1                	li	a1,24
}
ffffffffc02021b6:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc02021b8:	b975                	j	ffffffffc0201e74 <slob_free>
ffffffffc02021ba:	c219                	beqz	a2,ffffffffc02021c0 <kfree+0x9a>
        intr_enable();
ffffffffc02021bc:	c70fe0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc02021c0:	ff040513          	addi	a0,s0,-16
}
ffffffffc02021c4:	6442                	ld	s0,16(sp)
ffffffffc02021c6:	60e2                	ld	ra,24(sp)
ffffffffc02021c8:	64a2                	ld	s1,8(sp)
	slob_free((slob_t *)block - 1, 0);
ffffffffc02021ca:	4581                	li	a1,0
}
ffffffffc02021cc:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc02021ce:	b15d                	j	ffffffffc0201e74 <slob_free>
        intr_disable();
ffffffffc02021d0:	c62fe0ef          	jal	ra,ffffffffc0200632 <intr_disable>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
ffffffffc02021d4:	00032797          	auipc	a5,0x32
ffffffffc02021d8:	b047b783          	ld	a5,-1276(a5) # ffffffffc0233cd8 <bigblocks>
        return 1;
ffffffffc02021dc:	4605                	li	a2,1
ffffffffc02021de:	f7bd                	bnez	a5,ffffffffc020214c <kfree+0x26>
ffffffffc02021e0:	bff1                	j	ffffffffc02021bc <kfree+0x96>
        intr_enable();
ffffffffc02021e2:	c4afe0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc02021e6:	b751                	j	ffffffffc020216a <kfree+0x44>
ffffffffc02021e8:	8082                	ret
        panic("pa2page called with invalid pa");
ffffffffc02021ea:	00003617          	auipc	a2,0x3
ffffffffc02021ee:	43660613          	addi	a2,a2,1078 # ffffffffc0205620 <commands+0x6f8>
ffffffffc02021f2:	06200593          	li	a1,98
ffffffffc02021f6:	00003517          	auipc	a0,0x3
ffffffffc02021fa:	44a50513          	addi	a0,a0,1098 # ffffffffc0205640 <commands+0x718>
ffffffffc02021fe:	806fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    return pa2page(PADDR(kva));
ffffffffc0202202:	86a2                	mv	a3,s0
ffffffffc0202204:	00003617          	auipc	a2,0x3
ffffffffc0202208:	4a460613          	addi	a2,a2,1188 # ffffffffc02056a8 <commands+0x780>
ffffffffc020220c:	06e00593          	li	a1,110
ffffffffc0202210:	00003517          	auipc	a0,0x3
ffffffffc0202214:	43050513          	addi	a0,a0,1072 # ffffffffc0205640 <commands+0x718>
ffffffffc0202218:	fedfd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020221c <_fifo_init_mm>:
    elm->prev = elm->next = elm;
ffffffffc020221c:	00032797          	auipc	a5,0x32
ffffffffc0202220:	bec78793          	addi	a5,a5,-1044 # ffffffffc0233e08 <pra_list_head>
 */
static int
_fifo_init_mm(struct mm_struct *mm)
{     
     list_init(&pra_list_head);
     mm->sm_priv = &pra_list_head;
ffffffffc0202224:	f51c                	sd	a5,40(a0)
ffffffffc0202226:	e79c                	sd	a5,8(a5)
ffffffffc0202228:	e39c                	sd	a5,0(a5)
     //cprintf(" mm->sm_priv %x in fifo_init_mm\n",mm->sm_priv);
     return 0;
}
ffffffffc020222a:	4501                	li	a0,0
ffffffffc020222c:	8082                	ret

ffffffffc020222e <_fifo_init>:

static int
_fifo_init(void)
{
    return 0;
}
ffffffffc020222e:	4501                	li	a0,0
ffffffffc0202230:	8082                	ret

ffffffffc0202232 <_fifo_set_unswappable>:

static int
_fifo_set_unswappable(struct mm_struct *mm, uintptr_t addr)
{
    return 0;
}
ffffffffc0202232:	4501                	li	a0,0
ffffffffc0202234:	8082                	ret

ffffffffc0202236 <_fifo_tick_event>:

static int
_fifo_tick_event(struct mm_struct *mm)
{ return 0; }
ffffffffc0202236:	4501                	li	a0,0
ffffffffc0202238:	8082                	ret

ffffffffc020223a <_fifo_check_swap>:
_fifo_check_swap(void) {
ffffffffc020223a:	711d                	addi	sp,sp,-96
ffffffffc020223c:	fc4e                	sd	s3,56(sp)
ffffffffc020223e:	f852                	sd	s4,48(sp)
    cprintf("write Virt Page c in fifo_check_swap\n");
ffffffffc0202240:	00004517          	auipc	a0,0x4
ffffffffc0202244:	8a850513          	addi	a0,a0,-1880 # ffffffffc0205ae8 <commands+0xbc0>
    *(unsigned char *)0x3000 = 0x0c;
ffffffffc0202248:	698d                	lui	s3,0x3
ffffffffc020224a:	4a31                	li	s4,12
_fifo_check_swap(void) {
ffffffffc020224c:	e0ca                	sd	s2,64(sp)
ffffffffc020224e:	ec86                	sd	ra,88(sp)
ffffffffc0202250:	e8a2                	sd	s0,80(sp)
ffffffffc0202252:	e4a6                	sd	s1,72(sp)
ffffffffc0202254:	f456                	sd	s5,40(sp)
ffffffffc0202256:	f05a                	sd	s6,32(sp)
ffffffffc0202258:	ec5e                	sd	s7,24(sp)
ffffffffc020225a:	e862                	sd	s8,16(sp)
ffffffffc020225c:	e466                	sd	s9,8(sp)
ffffffffc020225e:	e06a                	sd	s10,0(sp)
    cprintf("write Virt Page c in fifo_check_swap\n");
ffffffffc0202260:	e69fd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x3000 = 0x0c;
ffffffffc0202264:	01498023          	sb	s4,0(s3) # 3000 <_binary_obj___user_hello_out_size-0x68b8>
    assert(pgfault_num==4);
ffffffffc0202268:	00032917          	auipc	s2,0x32
ffffffffc020226c:	a5892903          	lw	s2,-1448(s2) # ffffffffc0233cc0 <pgfault_num>
ffffffffc0202270:	4791                	li	a5,4
ffffffffc0202272:	14f91e63          	bne	s2,a5,ffffffffc02023ce <_fifo_check_swap+0x194>
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc0202276:	00004517          	auipc	a0,0x4
ffffffffc020227a:	8c250513          	addi	a0,a0,-1854 # ffffffffc0205b38 <commands+0xc10>
    *(unsigned char *)0x1000 = 0x0a;
ffffffffc020227e:	6a85                	lui	s5,0x1
ffffffffc0202280:	4b29                	li	s6,10
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc0202282:	e47fd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
ffffffffc0202286:	00032417          	auipc	s0,0x32
ffffffffc020228a:	a3a40413          	addi	s0,s0,-1478 # ffffffffc0233cc0 <pgfault_num>
    *(unsigned char *)0x1000 = 0x0a;
ffffffffc020228e:	016a8023          	sb	s6,0(s5) # 1000 <_binary_obj___user_hello_out_size-0x88b8>
    assert(pgfault_num==4);
ffffffffc0202292:	4004                	lw	s1,0(s0)
ffffffffc0202294:	2481                	sext.w	s1,s1
ffffffffc0202296:	2b249c63          	bne	s1,s2,ffffffffc020254e <_fifo_check_swap+0x314>
    cprintf("write Virt Page d in fifo_check_swap\n");
ffffffffc020229a:	00004517          	auipc	a0,0x4
ffffffffc020229e:	8c650513          	addi	a0,a0,-1850 # ffffffffc0205b60 <commands+0xc38>
    *(unsigned char *)0x4000 = 0x0d;
ffffffffc02022a2:	6b91                	lui	s7,0x4
ffffffffc02022a4:	4c35                	li	s8,13
    cprintf("write Virt Page d in fifo_check_swap\n");
ffffffffc02022a6:	e23fd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x4000 = 0x0d;
ffffffffc02022aa:	018b8023          	sb	s8,0(s7) # 4000 <_binary_obj___user_hello_out_size-0x58b8>
    assert(pgfault_num==4);
ffffffffc02022ae:	00042903          	lw	s2,0(s0)
ffffffffc02022b2:	2901                	sext.w	s2,s2
ffffffffc02022b4:	26991d63          	bne	s2,s1,ffffffffc020252e <_fifo_check_swap+0x2f4>
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc02022b8:	00004517          	auipc	a0,0x4
ffffffffc02022bc:	8d050513          	addi	a0,a0,-1840 # ffffffffc0205b88 <commands+0xc60>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc02022c0:	6c89                	lui	s9,0x2
ffffffffc02022c2:	4d2d                	li	s10,11
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc02022c4:	e05fd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc02022c8:	01ac8023          	sb	s10,0(s9) # 2000 <_binary_obj___user_hello_out_size-0x78b8>
    assert(pgfault_num==4);
ffffffffc02022cc:	401c                	lw	a5,0(s0)
ffffffffc02022ce:	2781                	sext.w	a5,a5
ffffffffc02022d0:	23279f63          	bne	a5,s2,ffffffffc020250e <_fifo_check_swap+0x2d4>
    cprintf("write Virt Page e in fifo_check_swap\n");
ffffffffc02022d4:	00004517          	auipc	a0,0x4
ffffffffc02022d8:	8dc50513          	addi	a0,a0,-1828 # ffffffffc0205bb0 <commands+0xc88>
ffffffffc02022dc:	dedfd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x5000 = 0x0e;
ffffffffc02022e0:	6795                	lui	a5,0x5
ffffffffc02022e2:	4739                	li	a4,14
ffffffffc02022e4:	00e78023          	sb	a4,0(a5) # 5000 <_binary_obj___user_hello_out_size-0x48b8>
    assert(pgfault_num==5);
ffffffffc02022e8:	4004                	lw	s1,0(s0)
ffffffffc02022ea:	4795                	li	a5,5
ffffffffc02022ec:	2481                	sext.w	s1,s1
ffffffffc02022ee:	20f49063          	bne	s1,a5,ffffffffc02024ee <_fifo_check_swap+0x2b4>
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc02022f2:	00004517          	auipc	a0,0x4
ffffffffc02022f6:	89650513          	addi	a0,a0,-1898 # ffffffffc0205b88 <commands+0xc60>
ffffffffc02022fa:	dcffd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc02022fe:	01ac8023          	sb	s10,0(s9)
    assert(pgfault_num==5);
ffffffffc0202302:	401c                	lw	a5,0(s0)
ffffffffc0202304:	2781                	sext.w	a5,a5
ffffffffc0202306:	1c979463          	bne	a5,s1,ffffffffc02024ce <_fifo_check_swap+0x294>
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc020230a:	00004517          	auipc	a0,0x4
ffffffffc020230e:	82e50513          	addi	a0,a0,-2002 # ffffffffc0205b38 <commands+0xc10>
ffffffffc0202312:	db7fd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x1000 = 0x0a;
ffffffffc0202316:	016a8023          	sb	s6,0(s5)
    assert(pgfault_num==6);
ffffffffc020231a:	401c                	lw	a5,0(s0)
ffffffffc020231c:	4719                	li	a4,6
ffffffffc020231e:	2781                	sext.w	a5,a5
ffffffffc0202320:	18e79763          	bne	a5,a4,ffffffffc02024ae <_fifo_check_swap+0x274>
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc0202324:	00004517          	auipc	a0,0x4
ffffffffc0202328:	86450513          	addi	a0,a0,-1948 # ffffffffc0205b88 <commands+0xc60>
ffffffffc020232c:	d9dfd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc0202330:	01ac8023          	sb	s10,0(s9)
    assert(pgfault_num==7);
ffffffffc0202334:	401c                	lw	a5,0(s0)
ffffffffc0202336:	471d                	li	a4,7
ffffffffc0202338:	2781                	sext.w	a5,a5
ffffffffc020233a:	14e79a63          	bne	a5,a4,ffffffffc020248e <_fifo_check_swap+0x254>
    cprintf("write Virt Page c in fifo_check_swap\n");
ffffffffc020233e:	00003517          	auipc	a0,0x3
ffffffffc0202342:	7aa50513          	addi	a0,a0,1962 # ffffffffc0205ae8 <commands+0xbc0>
ffffffffc0202346:	d83fd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x3000 = 0x0c;
ffffffffc020234a:	01498023          	sb	s4,0(s3)
    assert(pgfault_num==8);
ffffffffc020234e:	401c                	lw	a5,0(s0)
ffffffffc0202350:	4721                	li	a4,8
ffffffffc0202352:	2781                	sext.w	a5,a5
ffffffffc0202354:	10e79d63          	bne	a5,a4,ffffffffc020246e <_fifo_check_swap+0x234>
    cprintf("write Virt Page d in fifo_check_swap\n");
ffffffffc0202358:	00004517          	auipc	a0,0x4
ffffffffc020235c:	80850513          	addi	a0,a0,-2040 # ffffffffc0205b60 <commands+0xc38>
ffffffffc0202360:	d69fd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x4000 = 0x0d;
ffffffffc0202364:	018b8023          	sb	s8,0(s7)
    assert(pgfault_num==9);
ffffffffc0202368:	401c                	lw	a5,0(s0)
ffffffffc020236a:	4725                	li	a4,9
ffffffffc020236c:	2781                	sext.w	a5,a5
ffffffffc020236e:	0ee79063          	bne	a5,a4,ffffffffc020244e <_fifo_check_swap+0x214>
    cprintf("write Virt Page e in fifo_check_swap\n");
ffffffffc0202372:	00004517          	auipc	a0,0x4
ffffffffc0202376:	83e50513          	addi	a0,a0,-1986 # ffffffffc0205bb0 <commands+0xc88>
ffffffffc020237a:	d4ffd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x5000 = 0x0e;
ffffffffc020237e:	6795                	lui	a5,0x5
ffffffffc0202380:	4739                	li	a4,14
ffffffffc0202382:	00e78023          	sb	a4,0(a5) # 5000 <_binary_obj___user_hello_out_size-0x48b8>
    assert(pgfault_num==10);
ffffffffc0202386:	4004                	lw	s1,0(s0)
ffffffffc0202388:	47a9                	li	a5,10
ffffffffc020238a:	2481                	sext.w	s1,s1
ffffffffc020238c:	0af49163          	bne	s1,a5,ffffffffc020242e <_fifo_check_swap+0x1f4>
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc0202390:	00003517          	auipc	a0,0x3
ffffffffc0202394:	7a850513          	addi	a0,a0,1960 # ffffffffc0205b38 <commands+0xc10>
ffffffffc0202398:	d31fd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    assert(*(unsigned char *)0x1000 == 0x0a);
ffffffffc020239c:	6785                	lui	a5,0x1
ffffffffc020239e:	0007c783          	lbu	a5,0(a5) # 1000 <_binary_obj___user_hello_out_size-0x88b8>
ffffffffc02023a2:	06979663          	bne	a5,s1,ffffffffc020240e <_fifo_check_swap+0x1d4>
    assert(pgfault_num==11);
ffffffffc02023a6:	401c                	lw	a5,0(s0)
ffffffffc02023a8:	472d                	li	a4,11
ffffffffc02023aa:	2781                	sext.w	a5,a5
ffffffffc02023ac:	04e79163          	bne	a5,a4,ffffffffc02023ee <_fifo_check_swap+0x1b4>
}
ffffffffc02023b0:	60e6                	ld	ra,88(sp)
ffffffffc02023b2:	6446                	ld	s0,80(sp)
ffffffffc02023b4:	64a6                	ld	s1,72(sp)
ffffffffc02023b6:	6906                	ld	s2,64(sp)
ffffffffc02023b8:	79e2                	ld	s3,56(sp)
ffffffffc02023ba:	7a42                	ld	s4,48(sp)
ffffffffc02023bc:	7aa2                	ld	s5,40(sp)
ffffffffc02023be:	7b02                	ld	s6,32(sp)
ffffffffc02023c0:	6be2                	ld	s7,24(sp)
ffffffffc02023c2:	6c42                	ld	s8,16(sp)
ffffffffc02023c4:	6ca2                	ld	s9,8(sp)
ffffffffc02023c6:	6d02                	ld	s10,0(sp)
ffffffffc02023c8:	4501                	li	a0,0
ffffffffc02023ca:	6125                	addi	sp,sp,96
ffffffffc02023cc:	8082                	ret
    assert(pgfault_num==4);
ffffffffc02023ce:	00003697          	auipc	a3,0x3
ffffffffc02023d2:	74268693          	addi	a3,a3,1858 # ffffffffc0205b10 <commands+0xbe8>
ffffffffc02023d6:	00003617          	auipc	a2,0x3
ffffffffc02023da:	f5a60613          	addi	a2,a2,-166 # ffffffffc0205330 <commands+0x408>
ffffffffc02023de:	05100593          	li	a1,81
ffffffffc02023e2:	00003517          	auipc	a0,0x3
ffffffffc02023e6:	73e50513          	addi	a0,a0,1854 # ffffffffc0205b20 <commands+0xbf8>
ffffffffc02023ea:	e1bfd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==11);
ffffffffc02023ee:	00004697          	auipc	a3,0x4
ffffffffc02023f2:	87268693          	addi	a3,a3,-1934 # ffffffffc0205c60 <commands+0xd38>
ffffffffc02023f6:	00003617          	auipc	a2,0x3
ffffffffc02023fa:	f3a60613          	addi	a2,a2,-198 # ffffffffc0205330 <commands+0x408>
ffffffffc02023fe:	07300593          	li	a1,115
ffffffffc0202402:	00003517          	auipc	a0,0x3
ffffffffc0202406:	71e50513          	addi	a0,a0,1822 # ffffffffc0205b20 <commands+0xbf8>
ffffffffc020240a:	dfbfd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(*(unsigned char *)0x1000 == 0x0a);
ffffffffc020240e:	00004697          	auipc	a3,0x4
ffffffffc0202412:	82a68693          	addi	a3,a3,-2006 # ffffffffc0205c38 <commands+0xd10>
ffffffffc0202416:	00003617          	auipc	a2,0x3
ffffffffc020241a:	f1a60613          	addi	a2,a2,-230 # ffffffffc0205330 <commands+0x408>
ffffffffc020241e:	07100593          	li	a1,113
ffffffffc0202422:	00003517          	auipc	a0,0x3
ffffffffc0202426:	6fe50513          	addi	a0,a0,1790 # ffffffffc0205b20 <commands+0xbf8>
ffffffffc020242a:	ddbfd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==10);
ffffffffc020242e:	00003697          	auipc	a3,0x3
ffffffffc0202432:	7fa68693          	addi	a3,a3,2042 # ffffffffc0205c28 <commands+0xd00>
ffffffffc0202436:	00003617          	auipc	a2,0x3
ffffffffc020243a:	efa60613          	addi	a2,a2,-262 # ffffffffc0205330 <commands+0x408>
ffffffffc020243e:	06f00593          	li	a1,111
ffffffffc0202442:	00003517          	auipc	a0,0x3
ffffffffc0202446:	6de50513          	addi	a0,a0,1758 # ffffffffc0205b20 <commands+0xbf8>
ffffffffc020244a:	dbbfd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==9);
ffffffffc020244e:	00003697          	auipc	a3,0x3
ffffffffc0202452:	7ca68693          	addi	a3,a3,1994 # ffffffffc0205c18 <commands+0xcf0>
ffffffffc0202456:	00003617          	auipc	a2,0x3
ffffffffc020245a:	eda60613          	addi	a2,a2,-294 # ffffffffc0205330 <commands+0x408>
ffffffffc020245e:	06c00593          	li	a1,108
ffffffffc0202462:	00003517          	auipc	a0,0x3
ffffffffc0202466:	6be50513          	addi	a0,a0,1726 # ffffffffc0205b20 <commands+0xbf8>
ffffffffc020246a:	d9bfd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==8);
ffffffffc020246e:	00003697          	auipc	a3,0x3
ffffffffc0202472:	79a68693          	addi	a3,a3,1946 # ffffffffc0205c08 <commands+0xce0>
ffffffffc0202476:	00003617          	auipc	a2,0x3
ffffffffc020247a:	eba60613          	addi	a2,a2,-326 # ffffffffc0205330 <commands+0x408>
ffffffffc020247e:	06900593          	li	a1,105
ffffffffc0202482:	00003517          	auipc	a0,0x3
ffffffffc0202486:	69e50513          	addi	a0,a0,1694 # ffffffffc0205b20 <commands+0xbf8>
ffffffffc020248a:	d7bfd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==7);
ffffffffc020248e:	00003697          	auipc	a3,0x3
ffffffffc0202492:	76a68693          	addi	a3,a3,1898 # ffffffffc0205bf8 <commands+0xcd0>
ffffffffc0202496:	00003617          	auipc	a2,0x3
ffffffffc020249a:	e9a60613          	addi	a2,a2,-358 # ffffffffc0205330 <commands+0x408>
ffffffffc020249e:	06600593          	li	a1,102
ffffffffc02024a2:	00003517          	auipc	a0,0x3
ffffffffc02024a6:	67e50513          	addi	a0,a0,1662 # ffffffffc0205b20 <commands+0xbf8>
ffffffffc02024aa:	d5bfd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==6);
ffffffffc02024ae:	00003697          	auipc	a3,0x3
ffffffffc02024b2:	73a68693          	addi	a3,a3,1850 # ffffffffc0205be8 <commands+0xcc0>
ffffffffc02024b6:	00003617          	auipc	a2,0x3
ffffffffc02024ba:	e7a60613          	addi	a2,a2,-390 # ffffffffc0205330 <commands+0x408>
ffffffffc02024be:	06300593          	li	a1,99
ffffffffc02024c2:	00003517          	auipc	a0,0x3
ffffffffc02024c6:	65e50513          	addi	a0,a0,1630 # ffffffffc0205b20 <commands+0xbf8>
ffffffffc02024ca:	d3bfd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==5);
ffffffffc02024ce:	00003697          	auipc	a3,0x3
ffffffffc02024d2:	70a68693          	addi	a3,a3,1802 # ffffffffc0205bd8 <commands+0xcb0>
ffffffffc02024d6:	00003617          	auipc	a2,0x3
ffffffffc02024da:	e5a60613          	addi	a2,a2,-422 # ffffffffc0205330 <commands+0x408>
ffffffffc02024de:	06000593          	li	a1,96
ffffffffc02024e2:	00003517          	auipc	a0,0x3
ffffffffc02024e6:	63e50513          	addi	a0,a0,1598 # ffffffffc0205b20 <commands+0xbf8>
ffffffffc02024ea:	d1bfd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==5);
ffffffffc02024ee:	00003697          	auipc	a3,0x3
ffffffffc02024f2:	6ea68693          	addi	a3,a3,1770 # ffffffffc0205bd8 <commands+0xcb0>
ffffffffc02024f6:	00003617          	auipc	a2,0x3
ffffffffc02024fa:	e3a60613          	addi	a2,a2,-454 # ffffffffc0205330 <commands+0x408>
ffffffffc02024fe:	05d00593          	li	a1,93
ffffffffc0202502:	00003517          	auipc	a0,0x3
ffffffffc0202506:	61e50513          	addi	a0,a0,1566 # ffffffffc0205b20 <commands+0xbf8>
ffffffffc020250a:	cfbfd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==4);
ffffffffc020250e:	00003697          	auipc	a3,0x3
ffffffffc0202512:	60268693          	addi	a3,a3,1538 # ffffffffc0205b10 <commands+0xbe8>
ffffffffc0202516:	00003617          	auipc	a2,0x3
ffffffffc020251a:	e1a60613          	addi	a2,a2,-486 # ffffffffc0205330 <commands+0x408>
ffffffffc020251e:	05a00593          	li	a1,90
ffffffffc0202522:	00003517          	auipc	a0,0x3
ffffffffc0202526:	5fe50513          	addi	a0,a0,1534 # ffffffffc0205b20 <commands+0xbf8>
ffffffffc020252a:	cdbfd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==4);
ffffffffc020252e:	00003697          	auipc	a3,0x3
ffffffffc0202532:	5e268693          	addi	a3,a3,1506 # ffffffffc0205b10 <commands+0xbe8>
ffffffffc0202536:	00003617          	auipc	a2,0x3
ffffffffc020253a:	dfa60613          	addi	a2,a2,-518 # ffffffffc0205330 <commands+0x408>
ffffffffc020253e:	05700593          	li	a1,87
ffffffffc0202542:	00003517          	auipc	a0,0x3
ffffffffc0202546:	5de50513          	addi	a0,a0,1502 # ffffffffc0205b20 <commands+0xbf8>
ffffffffc020254a:	cbbfd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==4);
ffffffffc020254e:	00003697          	auipc	a3,0x3
ffffffffc0202552:	5c268693          	addi	a3,a3,1474 # ffffffffc0205b10 <commands+0xbe8>
ffffffffc0202556:	00003617          	auipc	a2,0x3
ffffffffc020255a:	dda60613          	addi	a2,a2,-550 # ffffffffc0205330 <commands+0x408>
ffffffffc020255e:	05400593          	li	a1,84
ffffffffc0202562:	00003517          	auipc	a0,0x3
ffffffffc0202566:	5be50513          	addi	a0,a0,1470 # ffffffffc0205b20 <commands+0xbf8>
ffffffffc020256a:	c9bfd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020256e <_fifo_swap_out_victim>:
     list_entry_t *head=(list_entry_t*) mm->sm_priv;
ffffffffc020256e:	751c                	ld	a5,40(a0)
{
ffffffffc0202570:	1141                	addi	sp,sp,-16
ffffffffc0202572:	e406                	sd	ra,8(sp)
         assert(head != NULL);
ffffffffc0202574:	cf91                	beqz	a5,ffffffffc0202590 <_fifo_swap_out_victim+0x22>
     assert(in_tick==0);
ffffffffc0202576:	ee0d                	bnez	a2,ffffffffc02025b0 <_fifo_swap_out_victim+0x42>
    return listelm->next;
ffffffffc0202578:	679c                	ld	a5,8(a5)
}
ffffffffc020257a:	60a2                	ld	ra,8(sp)
ffffffffc020257c:	4501                	li	a0,0
    __list_del(listelm->prev, listelm->next);
ffffffffc020257e:	6394                	ld	a3,0(a5)
ffffffffc0202580:	6798                	ld	a4,8(a5)
    *ptr_page = le2page(entry, pra_page_link);
ffffffffc0202582:	fd878793          	addi	a5,a5,-40
    prev->next = next;
ffffffffc0202586:	e698                	sd	a4,8(a3)
    next->prev = prev;
ffffffffc0202588:	e314                	sd	a3,0(a4)
ffffffffc020258a:	e19c                	sd	a5,0(a1)
}
ffffffffc020258c:	0141                	addi	sp,sp,16
ffffffffc020258e:	8082                	ret
         assert(head != NULL);
ffffffffc0202590:	00003697          	auipc	a3,0x3
ffffffffc0202594:	6e068693          	addi	a3,a3,1760 # ffffffffc0205c70 <commands+0xd48>
ffffffffc0202598:	00003617          	auipc	a2,0x3
ffffffffc020259c:	d9860613          	addi	a2,a2,-616 # ffffffffc0205330 <commands+0x408>
ffffffffc02025a0:	04100593          	li	a1,65
ffffffffc02025a4:	00003517          	auipc	a0,0x3
ffffffffc02025a8:	57c50513          	addi	a0,a0,1404 # ffffffffc0205b20 <commands+0xbf8>
ffffffffc02025ac:	c59fd0ef          	jal	ra,ffffffffc0200204 <__panic>
     assert(in_tick==0);
ffffffffc02025b0:	00003697          	auipc	a3,0x3
ffffffffc02025b4:	6d068693          	addi	a3,a3,1744 # ffffffffc0205c80 <commands+0xd58>
ffffffffc02025b8:	00003617          	auipc	a2,0x3
ffffffffc02025bc:	d7860613          	addi	a2,a2,-648 # ffffffffc0205330 <commands+0x408>
ffffffffc02025c0:	04200593          	li	a1,66
ffffffffc02025c4:	00003517          	auipc	a0,0x3
ffffffffc02025c8:	55c50513          	addi	a0,a0,1372 # ffffffffc0205b20 <commands+0xbf8>
ffffffffc02025cc:	c39fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02025d0 <_fifo_map_swappable>:
    list_entry_t *head=(list_entry_t*) mm->sm_priv;
ffffffffc02025d0:	751c                	ld	a5,40(a0)
    assert(entry != NULL && head != NULL);
ffffffffc02025d2:	cb91                	beqz	a5,ffffffffc02025e6 <_fifo_map_swappable+0x16>
    __list_add(elm, listelm->prev, listelm);
ffffffffc02025d4:	6394                	ld	a3,0(a5)
ffffffffc02025d6:	02860713          	addi	a4,a2,40
    prev->next = next->prev = elm;
ffffffffc02025da:	e398                	sd	a4,0(a5)
ffffffffc02025dc:	e698                	sd	a4,8(a3)
}
ffffffffc02025de:	4501                	li	a0,0
    elm->next = next;
ffffffffc02025e0:	fa1c                	sd	a5,48(a2)
    elm->prev = prev;
ffffffffc02025e2:	f614                	sd	a3,40(a2)
ffffffffc02025e4:	8082                	ret
{
ffffffffc02025e6:	1141                	addi	sp,sp,-16
    assert(entry != NULL && head != NULL);
ffffffffc02025e8:	00003697          	auipc	a3,0x3
ffffffffc02025ec:	6a868693          	addi	a3,a3,1704 # ffffffffc0205c90 <commands+0xd68>
ffffffffc02025f0:	00003617          	auipc	a2,0x3
ffffffffc02025f4:	d4060613          	addi	a2,a2,-704 # ffffffffc0205330 <commands+0x408>
ffffffffc02025f8:	03200593          	li	a1,50
ffffffffc02025fc:	00003517          	auipc	a0,0x3
ffffffffc0202600:	52450513          	addi	a0,a0,1316 # ffffffffc0205b20 <commands+0xbf8>
{
ffffffffc0202604:	e406                	sd	ra,8(sp)
    assert(entry != NULL && head != NULL);
ffffffffc0202606:	bfffd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020260a <default_init>:
    elm->prev = elm->next = elm;
ffffffffc020260a:	00032797          	auipc	a5,0x32
ffffffffc020260e:	80e78793          	addi	a5,a5,-2034 # ffffffffc0233e18 <free_area>
ffffffffc0202612:	e79c                	sd	a5,8(a5)
ffffffffc0202614:	e39c                	sd	a5,0(a5)
#define nr_free (free_area.nr_free)

static void
default_init(void) {
    list_init(&free_list);
    nr_free = 0;
ffffffffc0202616:	0007a823          	sw	zero,16(a5)
}
ffffffffc020261a:	8082                	ret

ffffffffc020261c <default_nr_free_pages>:
}

static size_t
default_nr_free_pages(void) {
    return nr_free;
}
ffffffffc020261c:	00032517          	auipc	a0,0x32
ffffffffc0202620:	80c56503          	lwu	a0,-2036(a0) # ffffffffc0233e28 <free_area+0x10>
ffffffffc0202624:	8082                	ret

ffffffffc0202626 <default_check>:
}

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
ffffffffc0202626:	715d                	addi	sp,sp,-80
ffffffffc0202628:	e0a2                	sd	s0,64(sp)
    return listelm->next;
ffffffffc020262a:	00031417          	auipc	s0,0x31
ffffffffc020262e:	7ee40413          	addi	s0,s0,2030 # ffffffffc0233e18 <free_area>
ffffffffc0202632:	641c                	ld	a5,8(s0)
ffffffffc0202634:	e486                	sd	ra,72(sp)
ffffffffc0202636:	fc26                	sd	s1,56(sp)
ffffffffc0202638:	f84a                	sd	s2,48(sp)
ffffffffc020263a:	f44e                	sd	s3,40(sp)
ffffffffc020263c:	f052                	sd	s4,32(sp)
ffffffffc020263e:	ec56                	sd	s5,24(sp)
ffffffffc0202640:	e85a                	sd	s6,16(sp)
ffffffffc0202642:	e45e                	sd	s7,8(sp)
ffffffffc0202644:	e062                	sd	s8,0(sp)
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc0202646:	2a878d63          	beq	a5,s0,ffffffffc0202900 <default_check+0x2da>
    int count = 0, total = 0;
ffffffffc020264a:	4481                	li	s1,0
ffffffffc020264c:	4901                	li	s2,0
 * test_bit - Determine whether a bit is set
 * @nr:     the bit to test
 * @addr:   the address to count from
 * */
static inline bool test_bit(int nr, volatile void *addr) {
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc020264e:	ff07b703          	ld	a4,-16(a5)
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
ffffffffc0202652:	8b09                	andi	a4,a4,2
ffffffffc0202654:	2a070a63          	beqz	a4,ffffffffc0202908 <default_check+0x2e2>
        count ++, total += p->property;
ffffffffc0202658:	ff87a703          	lw	a4,-8(a5)
ffffffffc020265c:	679c                	ld	a5,8(a5)
ffffffffc020265e:	2905                	addiw	s2,s2,1
ffffffffc0202660:	9cb9                	addw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc0202662:	fe8796e3          	bne	a5,s0,ffffffffc020264e <default_check+0x28>
ffffffffc0202666:	89a6                	mv	s3,s1
    }
    assert(total == nr_free_pages());
ffffffffc0202668:	fbefe0ef          	jal	ra,ffffffffc0200e26 <nr_free_pages>
ffffffffc020266c:	6f351e63          	bne	a0,s3,ffffffffc0202d68 <default_check+0x742>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0202670:	4505                	li	a0,1
ffffffffc0202672:	ee0fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0202676:	8aaa                	mv	s5,a0
ffffffffc0202678:	42050863          	beqz	a0,ffffffffc0202aa8 <default_check+0x482>
    assert((p1 = alloc_page()) != NULL);
ffffffffc020267c:	4505                	li	a0,1
ffffffffc020267e:	ed4fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0202682:	89aa                	mv	s3,a0
ffffffffc0202684:	70050263          	beqz	a0,ffffffffc0202d88 <default_check+0x762>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0202688:	4505                	li	a0,1
ffffffffc020268a:	ec8fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc020268e:	8a2a                	mv	s4,a0
ffffffffc0202690:	48050c63          	beqz	a0,ffffffffc0202b28 <default_check+0x502>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0202694:	293a8a63          	beq	s5,s3,ffffffffc0202928 <default_check+0x302>
ffffffffc0202698:	28aa8863          	beq	s5,a0,ffffffffc0202928 <default_check+0x302>
ffffffffc020269c:	28a98663          	beq	s3,a0,ffffffffc0202928 <default_check+0x302>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc02026a0:	000aa783          	lw	a5,0(s5)
ffffffffc02026a4:	2a079263          	bnez	a5,ffffffffc0202948 <default_check+0x322>
ffffffffc02026a8:	0009a783          	lw	a5,0(s3)
ffffffffc02026ac:	28079e63          	bnez	a5,ffffffffc0202948 <default_check+0x322>
ffffffffc02026b0:	411c                	lw	a5,0(a0)
ffffffffc02026b2:	28079b63          	bnez	a5,ffffffffc0202948 <default_check+0x322>
    return page - pages + nbase;
ffffffffc02026b6:	00031797          	auipc	a5,0x31
ffffffffc02026ba:	67a7b783          	ld	a5,1658(a5) # ffffffffc0233d30 <pages>
ffffffffc02026be:	40fa8733          	sub	a4,s5,a5
ffffffffc02026c2:	00004617          	auipc	a2,0x4
ffffffffc02026c6:	3e663603          	ld	a2,998(a2) # ffffffffc0206aa8 <nbase>
ffffffffc02026ca:	8719                	srai	a4,a4,0x6
ffffffffc02026cc:	9732                	add	a4,a4,a2
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc02026ce:	00031697          	auipc	a3,0x31
ffffffffc02026d2:	5ea6b683          	ld	a3,1514(a3) # ffffffffc0233cb8 <npage>
ffffffffc02026d6:	06b2                	slli	a3,a3,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc02026d8:	0732                	slli	a4,a4,0xc
ffffffffc02026da:	28d77763          	bgeu	a4,a3,ffffffffc0202968 <default_check+0x342>
    return page - pages + nbase;
ffffffffc02026de:	40f98733          	sub	a4,s3,a5
ffffffffc02026e2:	8719                	srai	a4,a4,0x6
ffffffffc02026e4:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc02026e6:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc02026e8:	4cd77063          	bgeu	a4,a3,ffffffffc0202ba8 <default_check+0x582>
    return page - pages + nbase;
ffffffffc02026ec:	40f507b3          	sub	a5,a0,a5
ffffffffc02026f0:	8799                	srai	a5,a5,0x6
ffffffffc02026f2:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc02026f4:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc02026f6:	30d7f963          	bgeu	a5,a3,ffffffffc0202a08 <default_check+0x3e2>
    assert(alloc_page() == NULL);
ffffffffc02026fa:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc02026fc:	00043c03          	ld	s8,0(s0)
ffffffffc0202700:	00843b83          	ld	s7,8(s0)
    unsigned int nr_free_store = nr_free;
ffffffffc0202704:	01042b03          	lw	s6,16(s0)
    elm->prev = elm->next = elm;
ffffffffc0202708:	e400                	sd	s0,8(s0)
ffffffffc020270a:	e000                	sd	s0,0(s0)
    nr_free = 0;
ffffffffc020270c:	00031797          	auipc	a5,0x31
ffffffffc0202710:	7007ae23          	sw	zero,1820(a5) # ffffffffc0233e28 <free_area+0x10>
    assert(alloc_page() == NULL);
ffffffffc0202714:	e3efe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0202718:	2c051863          	bnez	a0,ffffffffc02029e8 <default_check+0x3c2>
    free_page(p0);
ffffffffc020271c:	4585                	li	a1,1
ffffffffc020271e:	8556                	mv	a0,s5
ffffffffc0202720:	ec4fe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    free_page(p1);
ffffffffc0202724:	4585                	li	a1,1
ffffffffc0202726:	854e                	mv	a0,s3
ffffffffc0202728:	ebcfe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    free_page(p2);
ffffffffc020272c:	4585                	li	a1,1
ffffffffc020272e:	8552                	mv	a0,s4
ffffffffc0202730:	eb4fe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    assert(nr_free == 3);
ffffffffc0202734:	4818                	lw	a4,16(s0)
ffffffffc0202736:	478d                	li	a5,3
ffffffffc0202738:	28f71863          	bne	a4,a5,ffffffffc02029c8 <default_check+0x3a2>
    assert((p0 = alloc_page()) != NULL);
ffffffffc020273c:	4505                	li	a0,1
ffffffffc020273e:	e14fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0202742:	89aa                	mv	s3,a0
ffffffffc0202744:	26050263          	beqz	a0,ffffffffc02029a8 <default_check+0x382>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0202748:	4505                	li	a0,1
ffffffffc020274a:	e08fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc020274e:	8aaa                	mv	s5,a0
ffffffffc0202750:	3a050c63          	beqz	a0,ffffffffc0202b08 <default_check+0x4e2>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0202754:	4505                	li	a0,1
ffffffffc0202756:	dfcfe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc020275a:	8a2a                	mv	s4,a0
ffffffffc020275c:	38050663          	beqz	a0,ffffffffc0202ae8 <default_check+0x4c2>
    assert(alloc_page() == NULL);
ffffffffc0202760:	4505                	li	a0,1
ffffffffc0202762:	df0fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0202766:	36051163          	bnez	a0,ffffffffc0202ac8 <default_check+0x4a2>
    free_page(p0);
ffffffffc020276a:	4585                	li	a1,1
ffffffffc020276c:	854e                	mv	a0,s3
ffffffffc020276e:	e76fe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    assert(!list_empty(&free_list));
ffffffffc0202772:	641c                	ld	a5,8(s0)
ffffffffc0202774:	20878a63          	beq	a5,s0,ffffffffc0202988 <default_check+0x362>
    assert((p = alloc_page()) == p0);
ffffffffc0202778:	4505                	li	a0,1
ffffffffc020277a:	dd8fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc020277e:	30a99563          	bne	s3,a0,ffffffffc0202a88 <default_check+0x462>
    assert(alloc_page() == NULL);
ffffffffc0202782:	4505                	li	a0,1
ffffffffc0202784:	dcefe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0202788:	2e051063          	bnez	a0,ffffffffc0202a68 <default_check+0x442>
    assert(nr_free == 0);
ffffffffc020278c:	481c                	lw	a5,16(s0)
ffffffffc020278e:	2a079d63          	bnez	a5,ffffffffc0202a48 <default_check+0x422>
    free_page(p);
ffffffffc0202792:	854e                	mv	a0,s3
ffffffffc0202794:	4585                	li	a1,1
    free_list = free_list_store;
ffffffffc0202796:	01843023          	sd	s8,0(s0)
ffffffffc020279a:	01743423          	sd	s7,8(s0)
    nr_free = nr_free_store;
ffffffffc020279e:	01642823          	sw	s6,16(s0)
    free_page(p);
ffffffffc02027a2:	e42fe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    free_page(p1);
ffffffffc02027a6:	4585                	li	a1,1
ffffffffc02027a8:	8556                	mv	a0,s5
ffffffffc02027aa:	e3afe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    free_page(p2);
ffffffffc02027ae:	4585                	li	a1,1
ffffffffc02027b0:	8552                	mv	a0,s4
ffffffffc02027b2:	e32fe0ef          	jal	ra,ffffffffc0200de4 <free_pages>

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
ffffffffc02027b6:	4515                	li	a0,5
ffffffffc02027b8:	d9afe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc02027bc:	89aa                	mv	s3,a0
    assert(p0 != NULL);
ffffffffc02027be:	26050563          	beqz	a0,ffffffffc0202a28 <default_check+0x402>
ffffffffc02027c2:	651c                	ld	a5,8(a0)
ffffffffc02027c4:	8385                	srli	a5,a5,0x1
ffffffffc02027c6:	8b85                	andi	a5,a5,1
    assert(!PageProperty(p0));
ffffffffc02027c8:	54079063          	bnez	a5,ffffffffc0202d08 <default_check+0x6e2>

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);
ffffffffc02027cc:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc02027ce:	00043b03          	ld	s6,0(s0)
ffffffffc02027d2:	00843a83          	ld	s5,8(s0)
ffffffffc02027d6:	e000                	sd	s0,0(s0)
ffffffffc02027d8:	e400                	sd	s0,8(s0)
    assert(alloc_page() == NULL);
ffffffffc02027da:	d78fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc02027de:	50051563          	bnez	a0,ffffffffc0202ce8 <default_check+0x6c2>

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
ffffffffc02027e2:	08098a13          	addi	s4,s3,128
ffffffffc02027e6:	8552                	mv	a0,s4
ffffffffc02027e8:	458d                	li	a1,3
    unsigned int nr_free_store = nr_free;
ffffffffc02027ea:	01042b83          	lw	s7,16(s0)
    nr_free = 0;
ffffffffc02027ee:	00031797          	auipc	a5,0x31
ffffffffc02027f2:	6207ad23          	sw	zero,1594(a5) # ffffffffc0233e28 <free_area+0x10>
    free_pages(p0 + 2, 3);
ffffffffc02027f6:	deefe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    assert(alloc_pages(4) == NULL);
ffffffffc02027fa:	4511                	li	a0,4
ffffffffc02027fc:	d56fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0202800:	4c051463          	bnez	a0,ffffffffc0202cc8 <default_check+0x6a2>
ffffffffc0202804:	0889b783          	ld	a5,136(s3)
ffffffffc0202808:	8385                	srli	a5,a5,0x1
ffffffffc020280a:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc020280c:	48078e63          	beqz	a5,ffffffffc0202ca8 <default_check+0x682>
ffffffffc0202810:	0909a703          	lw	a4,144(s3)
ffffffffc0202814:	478d                	li	a5,3
ffffffffc0202816:	48f71963          	bne	a4,a5,ffffffffc0202ca8 <default_check+0x682>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc020281a:	450d                	li	a0,3
ffffffffc020281c:	d36fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0202820:	8c2a                	mv	s8,a0
ffffffffc0202822:	46050363          	beqz	a0,ffffffffc0202c88 <default_check+0x662>
    assert(alloc_page() == NULL);
ffffffffc0202826:	4505                	li	a0,1
ffffffffc0202828:	d2afe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc020282c:	42051e63          	bnez	a0,ffffffffc0202c68 <default_check+0x642>
    assert(p0 + 2 == p1);
ffffffffc0202830:	418a1c63          	bne	s4,s8,ffffffffc0202c48 <default_check+0x622>

    p2 = p0 + 1;
    free_page(p0);
ffffffffc0202834:	4585                	li	a1,1
ffffffffc0202836:	854e                	mv	a0,s3
ffffffffc0202838:	dacfe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    free_pages(p1, 3);
ffffffffc020283c:	458d                	li	a1,3
ffffffffc020283e:	8552                	mv	a0,s4
ffffffffc0202840:	da4fe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
ffffffffc0202844:	0089b783          	ld	a5,8(s3)
    p2 = p0 + 1;
ffffffffc0202848:	04098c13          	addi	s8,s3,64
ffffffffc020284c:	8385                	srli	a5,a5,0x1
ffffffffc020284e:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0202850:	3c078c63          	beqz	a5,ffffffffc0202c28 <default_check+0x602>
ffffffffc0202854:	0109a703          	lw	a4,16(s3)
ffffffffc0202858:	4785                	li	a5,1
ffffffffc020285a:	3cf71763          	bne	a4,a5,ffffffffc0202c28 <default_check+0x602>
ffffffffc020285e:	008a3783          	ld	a5,8(s4) # 1008 <_binary_obj___user_hello_out_size-0x88b0>
ffffffffc0202862:	8385                	srli	a5,a5,0x1
ffffffffc0202864:	8b85                	andi	a5,a5,1
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0202866:	3a078163          	beqz	a5,ffffffffc0202c08 <default_check+0x5e2>
ffffffffc020286a:	010a2703          	lw	a4,16(s4)
ffffffffc020286e:	478d                	li	a5,3
ffffffffc0202870:	38f71c63          	bne	a4,a5,ffffffffc0202c08 <default_check+0x5e2>

    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0202874:	4505                	li	a0,1
ffffffffc0202876:	cdcfe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc020287a:	36a99763          	bne	s3,a0,ffffffffc0202be8 <default_check+0x5c2>
    free_page(p0);
ffffffffc020287e:	4585                	li	a1,1
ffffffffc0202880:	d64fe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0202884:	4509                	li	a0,2
ffffffffc0202886:	cccfe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc020288a:	32aa1f63          	bne	s4,a0,ffffffffc0202bc8 <default_check+0x5a2>

    free_pages(p0, 2);
ffffffffc020288e:	4589                	li	a1,2
ffffffffc0202890:	d54fe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    free_page(p2);
ffffffffc0202894:	4585                	li	a1,1
ffffffffc0202896:	8562                	mv	a0,s8
ffffffffc0202898:	d4cfe0ef          	jal	ra,ffffffffc0200de4 <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc020289c:	4515                	li	a0,5
ffffffffc020289e:	cb4fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc02028a2:	89aa                	mv	s3,a0
ffffffffc02028a4:	48050263          	beqz	a0,ffffffffc0202d28 <default_check+0x702>
    assert(alloc_page() == NULL);
ffffffffc02028a8:	4505                	li	a0,1
ffffffffc02028aa:	ca8fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc02028ae:	2c051d63          	bnez	a0,ffffffffc0202b88 <default_check+0x562>

    assert(nr_free == 0);
ffffffffc02028b2:	481c                	lw	a5,16(s0)
ffffffffc02028b4:	2a079a63          	bnez	a5,ffffffffc0202b68 <default_check+0x542>
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);
ffffffffc02028b8:	4595                	li	a1,5
ffffffffc02028ba:	854e                	mv	a0,s3
    nr_free = nr_free_store;
ffffffffc02028bc:	01742823          	sw	s7,16(s0)
    free_list = free_list_store;
ffffffffc02028c0:	01643023          	sd	s6,0(s0)
ffffffffc02028c4:	01543423          	sd	s5,8(s0)
    free_pages(p0, 5);
ffffffffc02028c8:	d1cfe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    return listelm->next;
ffffffffc02028cc:	641c                	ld	a5,8(s0)

    le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc02028ce:	00878963          	beq	a5,s0,ffffffffc02028e0 <default_check+0x2ba>
        struct Page *p = le2page(le, page_link);
        count --, total -= p->property;
ffffffffc02028d2:	ff87a703          	lw	a4,-8(a5)
ffffffffc02028d6:	679c                	ld	a5,8(a5)
ffffffffc02028d8:	397d                	addiw	s2,s2,-1
ffffffffc02028da:	9c99                	subw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc02028dc:	fe879be3          	bne	a5,s0,ffffffffc02028d2 <default_check+0x2ac>
    }
    assert(count == 0);
ffffffffc02028e0:	26091463          	bnez	s2,ffffffffc0202b48 <default_check+0x522>
    assert(total == 0);
ffffffffc02028e4:	46049263          	bnez	s1,ffffffffc0202d48 <default_check+0x722>
}
ffffffffc02028e8:	60a6                	ld	ra,72(sp)
ffffffffc02028ea:	6406                	ld	s0,64(sp)
ffffffffc02028ec:	74e2                	ld	s1,56(sp)
ffffffffc02028ee:	7942                	ld	s2,48(sp)
ffffffffc02028f0:	79a2                	ld	s3,40(sp)
ffffffffc02028f2:	7a02                	ld	s4,32(sp)
ffffffffc02028f4:	6ae2                	ld	s5,24(sp)
ffffffffc02028f6:	6b42                	ld	s6,16(sp)
ffffffffc02028f8:	6ba2                	ld	s7,8(sp)
ffffffffc02028fa:	6c02                	ld	s8,0(sp)
ffffffffc02028fc:	6161                	addi	sp,sp,80
ffffffffc02028fe:	8082                	ret
    while ((le = list_next(le)) != &free_list) {
ffffffffc0202900:	4981                	li	s3,0
    int count = 0, total = 0;
ffffffffc0202902:	4481                	li	s1,0
ffffffffc0202904:	4901                	li	s2,0
ffffffffc0202906:	b38d                	j	ffffffffc0202668 <default_check+0x42>
        assert(PageProperty(p));
ffffffffc0202908:	00003697          	auipc	a3,0x3
ffffffffc020290c:	3c068693          	addi	a3,a3,960 # ffffffffc0205cc8 <commands+0xda0>
ffffffffc0202910:	00003617          	auipc	a2,0x3
ffffffffc0202914:	a2060613          	addi	a2,a2,-1504 # ffffffffc0205330 <commands+0x408>
ffffffffc0202918:	0f000593          	li	a1,240
ffffffffc020291c:	00003517          	auipc	a0,0x3
ffffffffc0202920:	3bc50513          	addi	a0,a0,956 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202924:	8e1fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0202928:	00003697          	auipc	a3,0x3
ffffffffc020292c:	44868693          	addi	a3,a3,1096 # ffffffffc0205d70 <commands+0xe48>
ffffffffc0202930:	00003617          	auipc	a2,0x3
ffffffffc0202934:	a0060613          	addi	a2,a2,-1536 # ffffffffc0205330 <commands+0x408>
ffffffffc0202938:	0bd00593          	li	a1,189
ffffffffc020293c:	00003517          	auipc	a0,0x3
ffffffffc0202940:	39c50513          	addi	a0,a0,924 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202944:	8c1fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0202948:	00003697          	auipc	a3,0x3
ffffffffc020294c:	45068693          	addi	a3,a3,1104 # ffffffffc0205d98 <commands+0xe70>
ffffffffc0202950:	00003617          	auipc	a2,0x3
ffffffffc0202954:	9e060613          	addi	a2,a2,-1568 # ffffffffc0205330 <commands+0x408>
ffffffffc0202958:	0be00593          	li	a1,190
ffffffffc020295c:	00003517          	auipc	a0,0x3
ffffffffc0202960:	37c50513          	addi	a0,a0,892 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202964:	8a1fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0202968:	00003697          	auipc	a3,0x3
ffffffffc020296c:	47068693          	addi	a3,a3,1136 # ffffffffc0205dd8 <commands+0xeb0>
ffffffffc0202970:	00003617          	auipc	a2,0x3
ffffffffc0202974:	9c060613          	addi	a2,a2,-1600 # ffffffffc0205330 <commands+0x408>
ffffffffc0202978:	0c000593          	li	a1,192
ffffffffc020297c:	00003517          	auipc	a0,0x3
ffffffffc0202980:	35c50513          	addi	a0,a0,860 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202984:	881fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(!list_empty(&free_list));
ffffffffc0202988:	00003697          	auipc	a3,0x3
ffffffffc020298c:	4d868693          	addi	a3,a3,1240 # ffffffffc0205e60 <commands+0xf38>
ffffffffc0202990:	00003617          	auipc	a2,0x3
ffffffffc0202994:	9a060613          	addi	a2,a2,-1632 # ffffffffc0205330 <commands+0x408>
ffffffffc0202998:	0d900593          	li	a1,217
ffffffffc020299c:	00003517          	auipc	a0,0x3
ffffffffc02029a0:	33c50513          	addi	a0,a0,828 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc02029a4:	861fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc02029a8:	00003697          	auipc	a3,0x3
ffffffffc02029ac:	36868693          	addi	a3,a3,872 # ffffffffc0205d10 <commands+0xde8>
ffffffffc02029b0:	00003617          	auipc	a2,0x3
ffffffffc02029b4:	98060613          	addi	a2,a2,-1664 # ffffffffc0205330 <commands+0x408>
ffffffffc02029b8:	0d200593          	li	a1,210
ffffffffc02029bc:	00003517          	auipc	a0,0x3
ffffffffc02029c0:	31c50513          	addi	a0,a0,796 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc02029c4:	841fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(nr_free == 3);
ffffffffc02029c8:	00003697          	auipc	a3,0x3
ffffffffc02029cc:	48868693          	addi	a3,a3,1160 # ffffffffc0205e50 <commands+0xf28>
ffffffffc02029d0:	00003617          	auipc	a2,0x3
ffffffffc02029d4:	96060613          	addi	a2,a2,-1696 # ffffffffc0205330 <commands+0x408>
ffffffffc02029d8:	0d000593          	li	a1,208
ffffffffc02029dc:	00003517          	auipc	a0,0x3
ffffffffc02029e0:	2fc50513          	addi	a0,a0,764 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc02029e4:	821fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02029e8:	00003697          	auipc	a3,0x3
ffffffffc02029ec:	45068693          	addi	a3,a3,1104 # ffffffffc0205e38 <commands+0xf10>
ffffffffc02029f0:	00003617          	auipc	a2,0x3
ffffffffc02029f4:	94060613          	addi	a2,a2,-1728 # ffffffffc0205330 <commands+0x408>
ffffffffc02029f8:	0cb00593          	li	a1,203
ffffffffc02029fc:	00003517          	auipc	a0,0x3
ffffffffc0202a00:	2dc50513          	addi	a0,a0,732 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202a04:	801fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0202a08:	00003697          	auipc	a3,0x3
ffffffffc0202a0c:	41068693          	addi	a3,a3,1040 # ffffffffc0205e18 <commands+0xef0>
ffffffffc0202a10:	00003617          	auipc	a2,0x3
ffffffffc0202a14:	92060613          	addi	a2,a2,-1760 # ffffffffc0205330 <commands+0x408>
ffffffffc0202a18:	0c200593          	li	a1,194
ffffffffc0202a1c:	00003517          	auipc	a0,0x3
ffffffffc0202a20:	2bc50513          	addi	a0,a0,700 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202a24:	fe0fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(p0 != NULL);
ffffffffc0202a28:	00003697          	auipc	a3,0x3
ffffffffc0202a2c:	48068693          	addi	a3,a3,1152 # ffffffffc0205ea8 <commands+0xf80>
ffffffffc0202a30:	00003617          	auipc	a2,0x3
ffffffffc0202a34:	90060613          	addi	a2,a2,-1792 # ffffffffc0205330 <commands+0x408>
ffffffffc0202a38:	0f800593          	li	a1,248
ffffffffc0202a3c:	00003517          	auipc	a0,0x3
ffffffffc0202a40:	29c50513          	addi	a0,a0,668 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202a44:	fc0fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(nr_free == 0);
ffffffffc0202a48:	00003697          	auipc	a3,0x3
ffffffffc0202a4c:	45068693          	addi	a3,a3,1104 # ffffffffc0205e98 <commands+0xf70>
ffffffffc0202a50:	00003617          	auipc	a2,0x3
ffffffffc0202a54:	8e060613          	addi	a2,a2,-1824 # ffffffffc0205330 <commands+0x408>
ffffffffc0202a58:	0df00593          	li	a1,223
ffffffffc0202a5c:	00003517          	auipc	a0,0x3
ffffffffc0202a60:	27c50513          	addi	a0,a0,636 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202a64:	fa0fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202a68:	00003697          	auipc	a3,0x3
ffffffffc0202a6c:	3d068693          	addi	a3,a3,976 # ffffffffc0205e38 <commands+0xf10>
ffffffffc0202a70:	00003617          	auipc	a2,0x3
ffffffffc0202a74:	8c060613          	addi	a2,a2,-1856 # ffffffffc0205330 <commands+0x408>
ffffffffc0202a78:	0dd00593          	li	a1,221
ffffffffc0202a7c:	00003517          	auipc	a0,0x3
ffffffffc0202a80:	25c50513          	addi	a0,a0,604 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202a84:	f80fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p = alloc_page()) == p0);
ffffffffc0202a88:	00003697          	auipc	a3,0x3
ffffffffc0202a8c:	3f068693          	addi	a3,a3,1008 # ffffffffc0205e78 <commands+0xf50>
ffffffffc0202a90:	00003617          	auipc	a2,0x3
ffffffffc0202a94:	8a060613          	addi	a2,a2,-1888 # ffffffffc0205330 <commands+0x408>
ffffffffc0202a98:	0dc00593          	li	a1,220
ffffffffc0202a9c:	00003517          	auipc	a0,0x3
ffffffffc0202aa0:	23c50513          	addi	a0,a0,572 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202aa4:	f60fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0202aa8:	00003697          	auipc	a3,0x3
ffffffffc0202aac:	26868693          	addi	a3,a3,616 # ffffffffc0205d10 <commands+0xde8>
ffffffffc0202ab0:	00003617          	auipc	a2,0x3
ffffffffc0202ab4:	88060613          	addi	a2,a2,-1920 # ffffffffc0205330 <commands+0x408>
ffffffffc0202ab8:	0b900593          	li	a1,185
ffffffffc0202abc:	00003517          	auipc	a0,0x3
ffffffffc0202ac0:	21c50513          	addi	a0,a0,540 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202ac4:	f40fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202ac8:	00003697          	auipc	a3,0x3
ffffffffc0202acc:	37068693          	addi	a3,a3,880 # ffffffffc0205e38 <commands+0xf10>
ffffffffc0202ad0:	00003617          	auipc	a2,0x3
ffffffffc0202ad4:	86060613          	addi	a2,a2,-1952 # ffffffffc0205330 <commands+0x408>
ffffffffc0202ad8:	0d600593          	li	a1,214
ffffffffc0202adc:	00003517          	auipc	a0,0x3
ffffffffc0202ae0:	1fc50513          	addi	a0,a0,508 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202ae4:	f20fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0202ae8:	00003697          	auipc	a3,0x3
ffffffffc0202aec:	26868693          	addi	a3,a3,616 # ffffffffc0205d50 <commands+0xe28>
ffffffffc0202af0:	00003617          	auipc	a2,0x3
ffffffffc0202af4:	84060613          	addi	a2,a2,-1984 # ffffffffc0205330 <commands+0x408>
ffffffffc0202af8:	0d400593          	li	a1,212
ffffffffc0202afc:	00003517          	auipc	a0,0x3
ffffffffc0202b00:	1dc50513          	addi	a0,a0,476 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202b04:	f00fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0202b08:	00003697          	auipc	a3,0x3
ffffffffc0202b0c:	22868693          	addi	a3,a3,552 # ffffffffc0205d30 <commands+0xe08>
ffffffffc0202b10:	00003617          	auipc	a2,0x3
ffffffffc0202b14:	82060613          	addi	a2,a2,-2016 # ffffffffc0205330 <commands+0x408>
ffffffffc0202b18:	0d300593          	li	a1,211
ffffffffc0202b1c:	00003517          	auipc	a0,0x3
ffffffffc0202b20:	1bc50513          	addi	a0,a0,444 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202b24:	ee0fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0202b28:	00003697          	auipc	a3,0x3
ffffffffc0202b2c:	22868693          	addi	a3,a3,552 # ffffffffc0205d50 <commands+0xe28>
ffffffffc0202b30:	00003617          	auipc	a2,0x3
ffffffffc0202b34:	80060613          	addi	a2,a2,-2048 # ffffffffc0205330 <commands+0x408>
ffffffffc0202b38:	0bb00593          	li	a1,187
ffffffffc0202b3c:	00003517          	auipc	a0,0x3
ffffffffc0202b40:	19c50513          	addi	a0,a0,412 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202b44:	ec0fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(count == 0);
ffffffffc0202b48:	00003697          	auipc	a3,0x3
ffffffffc0202b4c:	4b068693          	addi	a3,a3,1200 # ffffffffc0205ff8 <commands+0x10d0>
ffffffffc0202b50:	00002617          	auipc	a2,0x2
ffffffffc0202b54:	7e060613          	addi	a2,a2,2016 # ffffffffc0205330 <commands+0x408>
ffffffffc0202b58:	12500593          	li	a1,293
ffffffffc0202b5c:	00003517          	auipc	a0,0x3
ffffffffc0202b60:	17c50513          	addi	a0,a0,380 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202b64:	ea0fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(nr_free == 0);
ffffffffc0202b68:	00003697          	auipc	a3,0x3
ffffffffc0202b6c:	33068693          	addi	a3,a3,816 # ffffffffc0205e98 <commands+0xf70>
ffffffffc0202b70:	00002617          	auipc	a2,0x2
ffffffffc0202b74:	7c060613          	addi	a2,a2,1984 # ffffffffc0205330 <commands+0x408>
ffffffffc0202b78:	11a00593          	li	a1,282
ffffffffc0202b7c:	00003517          	auipc	a0,0x3
ffffffffc0202b80:	15c50513          	addi	a0,a0,348 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202b84:	e80fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202b88:	00003697          	auipc	a3,0x3
ffffffffc0202b8c:	2b068693          	addi	a3,a3,688 # ffffffffc0205e38 <commands+0xf10>
ffffffffc0202b90:	00002617          	auipc	a2,0x2
ffffffffc0202b94:	7a060613          	addi	a2,a2,1952 # ffffffffc0205330 <commands+0x408>
ffffffffc0202b98:	11800593          	li	a1,280
ffffffffc0202b9c:	00003517          	auipc	a0,0x3
ffffffffc0202ba0:	13c50513          	addi	a0,a0,316 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202ba4:	e60fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0202ba8:	00003697          	auipc	a3,0x3
ffffffffc0202bac:	25068693          	addi	a3,a3,592 # ffffffffc0205df8 <commands+0xed0>
ffffffffc0202bb0:	00002617          	auipc	a2,0x2
ffffffffc0202bb4:	78060613          	addi	a2,a2,1920 # ffffffffc0205330 <commands+0x408>
ffffffffc0202bb8:	0c100593          	li	a1,193
ffffffffc0202bbc:	00003517          	auipc	a0,0x3
ffffffffc0202bc0:	11c50513          	addi	a0,a0,284 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202bc4:	e40fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0202bc8:	00003697          	auipc	a3,0x3
ffffffffc0202bcc:	3f068693          	addi	a3,a3,1008 # ffffffffc0205fb8 <commands+0x1090>
ffffffffc0202bd0:	00002617          	auipc	a2,0x2
ffffffffc0202bd4:	76060613          	addi	a2,a2,1888 # ffffffffc0205330 <commands+0x408>
ffffffffc0202bd8:	11200593          	li	a1,274
ffffffffc0202bdc:	00003517          	auipc	a0,0x3
ffffffffc0202be0:	0fc50513          	addi	a0,a0,252 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202be4:	e20fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0202be8:	00003697          	auipc	a3,0x3
ffffffffc0202bec:	3b068693          	addi	a3,a3,944 # ffffffffc0205f98 <commands+0x1070>
ffffffffc0202bf0:	00002617          	auipc	a2,0x2
ffffffffc0202bf4:	74060613          	addi	a2,a2,1856 # ffffffffc0205330 <commands+0x408>
ffffffffc0202bf8:	11000593          	li	a1,272
ffffffffc0202bfc:	00003517          	auipc	a0,0x3
ffffffffc0202c00:	0dc50513          	addi	a0,a0,220 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202c04:	e00fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0202c08:	00003697          	auipc	a3,0x3
ffffffffc0202c0c:	36868693          	addi	a3,a3,872 # ffffffffc0205f70 <commands+0x1048>
ffffffffc0202c10:	00002617          	auipc	a2,0x2
ffffffffc0202c14:	72060613          	addi	a2,a2,1824 # ffffffffc0205330 <commands+0x408>
ffffffffc0202c18:	10e00593          	li	a1,270
ffffffffc0202c1c:	00003517          	auipc	a0,0x3
ffffffffc0202c20:	0bc50513          	addi	a0,a0,188 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202c24:	de0fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0202c28:	00003697          	auipc	a3,0x3
ffffffffc0202c2c:	32068693          	addi	a3,a3,800 # ffffffffc0205f48 <commands+0x1020>
ffffffffc0202c30:	00002617          	auipc	a2,0x2
ffffffffc0202c34:	70060613          	addi	a2,a2,1792 # ffffffffc0205330 <commands+0x408>
ffffffffc0202c38:	10d00593          	li	a1,269
ffffffffc0202c3c:	00003517          	auipc	a0,0x3
ffffffffc0202c40:	09c50513          	addi	a0,a0,156 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202c44:	dc0fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(p0 + 2 == p1);
ffffffffc0202c48:	00003697          	auipc	a3,0x3
ffffffffc0202c4c:	2f068693          	addi	a3,a3,752 # ffffffffc0205f38 <commands+0x1010>
ffffffffc0202c50:	00002617          	auipc	a2,0x2
ffffffffc0202c54:	6e060613          	addi	a2,a2,1760 # ffffffffc0205330 <commands+0x408>
ffffffffc0202c58:	10800593          	li	a1,264
ffffffffc0202c5c:	00003517          	auipc	a0,0x3
ffffffffc0202c60:	07c50513          	addi	a0,a0,124 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202c64:	da0fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202c68:	00003697          	auipc	a3,0x3
ffffffffc0202c6c:	1d068693          	addi	a3,a3,464 # ffffffffc0205e38 <commands+0xf10>
ffffffffc0202c70:	00002617          	auipc	a2,0x2
ffffffffc0202c74:	6c060613          	addi	a2,a2,1728 # ffffffffc0205330 <commands+0x408>
ffffffffc0202c78:	10700593          	li	a1,263
ffffffffc0202c7c:	00003517          	auipc	a0,0x3
ffffffffc0202c80:	05c50513          	addi	a0,a0,92 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202c84:	d80fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0202c88:	00003697          	auipc	a3,0x3
ffffffffc0202c8c:	29068693          	addi	a3,a3,656 # ffffffffc0205f18 <commands+0xff0>
ffffffffc0202c90:	00002617          	auipc	a2,0x2
ffffffffc0202c94:	6a060613          	addi	a2,a2,1696 # ffffffffc0205330 <commands+0x408>
ffffffffc0202c98:	10600593          	li	a1,262
ffffffffc0202c9c:	00003517          	auipc	a0,0x3
ffffffffc0202ca0:	03c50513          	addi	a0,a0,60 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202ca4:	d60fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0202ca8:	00003697          	auipc	a3,0x3
ffffffffc0202cac:	24068693          	addi	a3,a3,576 # ffffffffc0205ee8 <commands+0xfc0>
ffffffffc0202cb0:	00002617          	auipc	a2,0x2
ffffffffc0202cb4:	68060613          	addi	a2,a2,1664 # ffffffffc0205330 <commands+0x408>
ffffffffc0202cb8:	10500593          	li	a1,261
ffffffffc0202cbc:	00003517          	auipc	a0,0x3
ffffffffc0202cc0:	01c50513          	addi	a0,a0,28 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202cc4:	d40fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_pages(4) == NULL);
ffffffffc0202cc8:	00003697          	auipc	a3,0x3
ffffffffc0202ccc:	20868693          	addi	a3,a3,520 # ffffffffc0205ed0 <commands+0xfa8>
ffffffffc0202cd0:	00002617          	auipc	a2,0x2
ffffffffc0202cd4:	66060613          	addi	a2,a2,1632 # ffffffffc0205330 <commands+0x408>
ffffffffc0202cd8:	10400593          	li	a1,260
ffffffffc0202cdc:	00003517          	auipc	a0,0x3
ffffffffc0202ce0:	ffc50513          	addi	a0,a0,-4 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202ce4:	d20fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202ce8:	00003697          	auipc	a3,0x3
ffffffffc0202cec:	15068693          	addi	a3,a3,336 # ffffffffc0205e38 <commands+0xf10>
ffffffffc0202cf0:	00002617          	auipc	a2,0x2
ffffffffc0202cf4:	64060613          	addi	a2,a2,1600 # ffffffffc0205330 <commands+0x408>
ffffffffc0202cf8:	0fe00593          	li	a1,254
ffffffffc0202cfc:	00003517          	auipc	a0,0x3
ffffffffc0202d00:	fdc50513          	addi	a0,a0,-36 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202d04:	d00fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(!PageProperty(p0));
ffffffffc0202d08:	00003697          	auipc	a3,0x3
ffffffffc0202d0c:	1b068693          	addi	a3,a3,432 # ffffffffc0205eb8 <commands+0xf90>
ffffffffc0202d10:	00002617          	auipc	a2,0x2
ffffffffc0202d14:	62060613          	addi	a2,a2,1568 # ffffffffc0205330 <commands+0x408>
ffffffffc0202d18:	0f900593          	li	a1,249
ffffffffc0202d1c:	00003517          	auipc	a0,0x3
ffffffffc0202d20:	fbc50513          	addi	a0,a0,-68 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202d24:	ce0fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0202d28:	00003697          	auipc	a3,0x3
ffffffffc0202d2c:	2b068693          	addi	a3,a3,688 # ffffffffc0205fd8 <commands+0x10b0>
ffffffffc0202d30:	00002617          	auipc	a2,0x2
ffffffffc0202d34:	60060613          	addi	a2,a2,1536 # ffffffffc0205330 <commands+0x408>
ffffffffc0202d38:	11700593          	li	a1,279
ffffffffc0202d3c:	00003517          	auipc	a0,0x3
ffffffffc0202d40:	f9c50513          	addi	a0,a0,-100 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202d44:	cc0fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(total == 0);
ffffffffc0202d48:	00003697          	auipc	a3,0x3
ffffffffc0202d4c:	2c068693          	addi	a3,a3,704 # ffffffffc0206008 <commands+0x10e0>
ffffffffc0202d50:	00002617          	auipc	a2,0x2
ffffffffc0202d54:	5e060613          	addi	a2,a2,1504 # ffffffffc0205330 <commands+0x408>
ffffffffc0202d58:	12600593          	li	a1,294
ffffffffc0202d5c:	00003517          	auipc	a0,0x3
ffffffffc0202d60:	f7c50513          	addi	a0,a0,-132 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202d64:	ca0fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(total == nr_free_pages());
ffffffffc0202d68:	00003697          	auipc	a3,0x3
ffffffffc0202d6c:	f8868693          	addi	a3,a3,-120 # ffffffffc0205cf0 <commands+0xdc8>
ffffffffc0202d70:	00002617          	auipc	a2,0x2
ffffffffc0202d74:	5c060613          	addi	a2,a2,1472 # ffffffffc0205330 <commands+0x408>
ffffffffc0202d78:	0f300593          	li	a1,243
ffffffffc0202d7c:	00003517          	auipc	a0,0x3
ffffffffc0202d80:	f5c50513          	addi	a0,a0,-164 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202d84:	c80fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0202d88:	00003697          	auipc	a3,0x3
ffffffffc0202d8c:	fa868693          	addi	a3,a3,-88 # ffffffffc0205d30 <commands+0xe08>
ffffffffc0202d90:	00002617          	auipc	a2,0x2
ffffffffc0202d94:	5a060613          	addi	a2,a2,1440 # ffffffffc0205330 <commands+0x408>
ffffffffc0202d98:	0ba00593          	li	a1,186
ffffffffc0202d9c:	00003517          	auipc	a0,0x3
ffffffffc0202da0:	f3c50513          	addi	a0,a0,-196 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202da4:	c60fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0202da8 <default_free_pages>:
default_free_pages(struct Page *base, size_t n) {
ffffffffc0202da8:	1141                	addi	sp,sp,-16
ffffffffc0202daa:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0202dac:	12058f63          	beqz	a1,ffffffffc0202eea <default_free_pages+0x142>
    for (; p != base + n; p ++) {
ffffffffc0202db0:	00659693          	slli	a3,a1,0x6
ffffffffc0202db4:	96aa                	add	a3,a3,a0
ffffffffc0202db6:	87aa                	mv	a5,a0
ffffffffc0202db8:	02d50263          	beq	a0,a3,ffffffffc0202ddc <default_free_pages+0x34>
ffffffffc0202dbc:	6798                	ld	a4,8(a5)
ffffffffc0202dbe:	8b05                	andi	a4,a4,1
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc0202dc0:	10071563          	bnez	a4,ffffffffc0202eca <default_free_pages+0x122>
ffffffffc0202dc4:	6798                	ld	a4,8(a5)
ffffffffc0202dc6:	8b09                	andi	a4,a4,2
ffffffffc0202dc8:	10071163          	bnez	a4,ffffffffc0202eca <default_free_pages+0x122>
        p->flags = 0;
ffffffffc0202dcc:	0007b423          	sd	zero,8(a5)
    page->ref = val;
ffffffffc0202dd0:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc0202dd4:	04078793          	addi	a5,a5,64
ffffffffc0202dd8:	fed792e3          	bne	a5,a3,ffffffffc0202dbc <default_free_pages+0x14>
    base->property = n;
ffffffffc0202ddc:	2581                	sext.w	a1,a1
ffffffffc0202dde:	c90c                	sw	a1,16(a0)
    SetPageProperty(base);
ffffffffc0202de0:	00850893          	addi	a7,a0,8
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0202de4:	4789                	li	a5,2
ffffffffc0202de6:	40f8b02f          	amoor.d	zero,a5,(a7)
    nr_free += n;
ffffffffc0202dea:	00031697          	auipc	a3,0x31
ffffffffc0202dee:	02e68693          	addi	a3,a3,46 # ffffffffc0233e18 <free_area>
ffffffffc0202df2:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc0202df4:	669c                	ld	a5,8(a3)
ffffffffc0202df6:	01850613          	addi	a2,a0,24
ffffffffc0202dfa:	9db9                	addw	a1,a1,a4
ffffffffc0202dfc:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc0202dfe:	08d78f63          	beq	a5,a3,ffffffffc0202e9c <default_free_pages+0xf4>
            struct Page* page = le2page(le, page_link);
ffffffffc0202e02:	fe878713          	addi	a4,a5,-24
ffffffffc0202e06:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list)) {
ffffffffc0202e0a:	4581                	li	a1,0
            if (base < page) {
ffffffffc0202e0c:	00e56a63          	bltu	a0,a4,ffffffffc0202e20 <default_free_pages+0x78>
    return listelm->next;
ffffffffc0202e10:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc0202e12:	04d70a63          	beq	a4,a3,ffffffffc0202e66 <default_free_pages+0xbe>
    for (; p != base + n; p ++) {
ffffffffc0202e16:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc0202e18:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc0202e1c:	fee57ae3          	bgeu	a0,a4,ffffffffc0202e10 <default_free_pages+0x68>
ffffffffc0202e20:	c199                	beqz	a1,ffffffffc0202e26 <default_free_pages+0x7e>
ffffffffc0202e22:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc0202e26:	6398                	ld	a4,0(a5)
    prev->next = next->prev = elm;
ffffffffc0202e28:	e390                	sd	a2,0(a5)
ffffffffc0202e2a:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0202e2c:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0202e2e:	ed18                	sd	a4,24(a0)
    if (le != &free_list) {
ffffffffc0202e30:	00d70c63          	beq	a4,a3,ffffffffc0202e48 <default_free_pages+0xa0>
        if (p + p->property == base) {
ffffffffc0202e34:	ff872583          	lw	a1,-8(a4) # ff8 <_binary_obj___user_hello_out_size-0x88c0>
        p = le2page(le, page_link);
ffffffffc0202e38:	fe870613          	addi	a2,a4,-24
        if (p + p->property == base) {
ffffffffc0202e3c:	02059793          	slli	a5,a1,0x20
ffffffffc0202e40:	83e9                	srli	a5,a5,0x1a
ffffffffc0202e42:	97b2                	add	a5,a5,a2
ffffffffc0202e44:	02f50b63          	beq	a0,a5,ffffffffc0202e7a <default_free_pages+0xd2>
ffffffffc0202e48:	7118                	ld	a4,32(a0)
    if (le != &free_list) {
ffffffffc0202e4a:	00d70b63          	beq	a4,a3,ffffffffc0202e60 <default_free_pages+0xb8>
        if (base + base->property == p) {
ffffffffc0202e4e:	4910                	lw	a2,16(a0)
        p = le2page(le, page_link);
ffffffffc0202e50:	fe870693          	addi	a3,a4,-24
        if (base + base->property == p) {
ffffffffc0202e54:	02061793          	slli	a5,a2,0x20
ffffffffc0202e58:	83e9                	srli	a5,a5,0x1a
ffffffffc0202e5a:	97aa                	add	a5,a5,a0
ffffffffc0202e5c:	04f68763          	beq	a3,a5,ffffffffc0202eaa <default_free_pages+0x102>
}
ffffffffc0202e60:	60a2                	ld	ra,8(sp)
ffffffffc0202e62:	0141                	addi	sp,sp,16
ffffffffc0202e64:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0202e66:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0202e68:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0202e6a:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0202e6c:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc0202e6e:	02d70463          	beq	a4,a3,ffffffffc0202e96 <default_free_pages+0xee>
    prev->next = next->prev = elm;
ffffffffc0202e72:	8832                	mv	a6,a2
ffffffffc0202e74:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc0202e76:	87ba                	mv	a5,a4
ffffffffc0202e78:	b745                	j	ffffffffc0202e18 <default_free_pages+0x70>
            p->property += base->property;
ffffffffc0202e7a:	491c                	lw	a5,16(a0)
ffffffffc0202e7c:	9dbd                	addw	a1,a1,a5
ffffffffc0202e7e:	feb72c23          	sw	a1,-8(a4)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0202e82:	57f5                	li	a5,-3
ffffffffc0202e84:	60f8b02f          	amoand.d	zero,a5,(a7)
    __list_del(listelm->prev, listelm->next);
ffffffffc0202e88:	6d0c                	ld	a1,24(a0)
ffffffffc0202e8a:	711c                	ld	a5,32(a0)
            base = p;
ffffffffc0202e8c:	8532                	mv	a0,a2
    prev->next = next;
ffffffffc0202e8e:	e59c                	sd	a5,8(a1)
    next->prev = prev;
ffffffffc0202e90:	6718                	ld	a4,8(a4)
ffffffffc0202e92:	e38c                	sd	a1,0(a5)
ffffffffc0202e94:	bf5d                	j	ffffffffc0202e4a <default_free_pages+0xa2>
ffffffffc0202e96:	e290                	sd	a2,0(a3)
        while ((le = list_next(le)) != &free_list) {
ffffffffc0202e98:	873e                	mv	a4,a5
ffffffffc0202e9a:	bf69                	j	ffffffffc0202e34 <default_free_pages+0x8c>
}
ffffffffc0202e9c:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0202e9e:	e390                	sd	a2,0(a5)
ffffffffc0202ea0:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0202ea2:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0202ea4:	ed1c                	sd	a5,24(a0)
ffffffffc0202ea6:	0141                	addi	sp,sp,16
ffffffffc0202ea8:	8082                	ret
            base->property += p->property;
ffffffffc0202eaa:	ff872783          	lw	a5,-8(a4)
ffffffffc0202eae:	ff070693          	addi	a3,a4,-16
ffffffffc0202eb2:	9e3d                	addw	a2,a2,a5
ffffffffc0202eb4:	c910                	sw	a2,16(a0)
ffffffffc0202eb6:	57f5                	li	a5,-3
ffffffffc0202eb8:	60f6b02f          	amoand.d	zero,a5,(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc0202ebc:	6314                	ld	a3,0(a4)
ffffffffc0202ebe:	671c                	ld	a5,8(a4)
}
ffffffffc0202ec0:	60a2                	ld	ra,8(sp)
    prev->next = next;
ffffffffc0202ec2:	e69c                	sd	a5,8(a3)
    next->prev = prev;
ffffffffc0202ec4:	e394                	sd	a3,0(a5)
ffffffffc0202ec6:	0141                	addi	sp,sp,16
ffffffffc0202ec8:	8082                	ret
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc0202eca:	00003697          	auipc	a3,0x3
ffffffffc0202ece:	15668693          	addi	a3,a3,342 # ffffffffc0206020 <commands+0x10f8>
ffffffffc0202ed2:	00002617          	auipc	a2,0x2
ffffffffc0202ed6:	45e60613          	addi	a2,a2,1118 # ffffffffc0205330 <commands+0x408>
ffffffffc0202eda:	08300593          	li	a1,131
ffffffffc0202ede:	00003517          	auipc	a0,0x3
ffffffffc0202ee2:	dfa50513          	addi	a0,a0,-518 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202ee6:	b1efd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(n > 0);
ffffffffc0202eea:	00003697          	auipc	a3,0x3
ffffffffc0202eee:	12e68693          	addi	a3,a3,302 # ffffffffc0206018 <commands+0x10f0>
ffffffffc0202ef2:	00002617          	auipc	a2,0x2
ffffffffc0202ef6:	43e60613          	addi	a2,a2,1086 # ffffffffc0205330 <commands+0x408>
ffffffffc0202efa:	08000593          	li	a1,128
ffffffffc0202efe:	00003517          	auipc	a0,0x3
ffffffffc0202f02:	dda50513          	addi	a0,a0,-550 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202f06:	afefd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0202f0a <default_alloc_pages>:
    assert(n > 0);
ffffffffc0202f0a:	c941                	beqz	a0,ffffffffc0202f9a <default_alloc_pages+0x90>
    if (n > nr_free) {
ffffffffc0202f0c:	00031597          	auipc	a1,0x31
ffffffffc0202f10:	f0c58593          	addi	a1,a1,-244 # ffffffffc0233e18 <free_area>
ffffffffc0202f14:	0105a803          	lw	a6,16(a1)
ffffffffc0202f18:	872a                	mv	a4,a0
ffffffffc0202f1a:	02081793          	slli	a5,a6,0x20
ffffffffc0202f1e:	9381                	srli	a5,a5,0x20
ffffffffc0202f20:	00a7ee63          	bltu	a5,a0,ffffffffc0202f3c <default_alloc_pages+0x32>
    list_entry_t *le = &free_list;
ffffffffc0202f24:	87ae                	mv	a5,a1
ffffffffc0202f26:	a801                	j	ffffffffc0202f36 <default_alloc_pages+0x2c>
        if (p->property >= n) {
ffffffffc0202f28:	ff87a683          	lw	a3,-8(a5)
ffffffffc0202f2c:	02069613          	slli	a2,a3,0x20
ffffffffc0202f30:	9201                	srli	a2,a2,0x20
ffffffffc0202f32:	00e67763          	bgeu	a2,a4,ffffffffc0202f40 <default_alloc_pages+0x36>
    return listelm->next;
ffffffffc0202f36:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != &free_list) {
ffffffffc0202f38:	feb798e3          	bne	a5,a1,ffffffffc0202f28 <default_alloc_pages+0x1e>
        return NULL;
ffffffffc0202f3c:	4501                	li	a0,0
}
ffffffffc0202f3e:	8082                	ret
    return listelm->prev;
ffffffffc0202f40:	0007b883          	ld	a7,0(a5)
    __list_del(listelm->prev, listelm->next);
ffffffffc0202f44:	0087b303          	ld	t1,8(a5)
        struct Page *p = le2page(le, page_link);
ffffffffc0202f48:	fe878513          	addi	a0,a5,-24
    prev->next = next;
ffffffffc0202f4c:	00070e1b          	sext.w	t3,a4
ffffffffc0202f50:	0068b423          	sd	t1,8(a7)
    next->prev = prev;
ffffffffc0202f54:	01133023          	sd	a7,0(t1)
        if (page->property > n) {
ffffffffc0202f58:	02c77863          	bgeu	a4,a2,ffffffffc0202f88 <default_alloc_pages+0x7e>
            struct Page *p = page + n;
ffffffffc0202f5c:	071a                	slli	a4,a4,0x6
ffffffffc0202f5e:	972a                	add	a4,a4,a0
            p->property = page->property - n;
ffffffffc0202f60:	41c686bb          	subw	a3,a3,t3
ffffffffc0202f64:	cb14                	sw	a3,16(a4)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0202f66:	00870613          	addi	a2,a4,8
ffffffffc0202f6a:	4689                	li	a3,2
ffffffffc0202f6c:	40d6302f          	amoor.d	zero,a3,(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc0202f70:	0088b683          	ld	a3,8(a7)
            list_add(prev, &(p->page_link));
ffffffffc0202f74:	01870613          	addi	a2,a4,24
    prev->next = next->prev = elm;
ffffffffc0202f78:	0105a803          	lw	a6,16(a1)
ffffffffc0202f7c:	e290                	sd	a2,0(a3)
ffffffffc0202f7e:	00c8b423          	sd	a2,8(a7)
    elm->next = next;
ffffffffc0202f82:	f314                	sd	a3,32(a4)
    elm->prev = prev;
ffffffffc0202f84:	01173c23          	sd	a7,24(a4)
        nr_free -= n;
ffffffffc0202f88:	41c8083b          	subw	a6,a6,t3
ffffffffc0202f8c:	0105a823          	sw	a6,16(a1)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0202f90:	5775                	li	a4,-3
ffffffffc0202f92:	17c1                	addi	a5,a5,-16
ffffffffc0202f94:	60e7b02f          	amoand.d	zero,a4,(a5)
}
ffffffffc0202f98:	8082                	ret
default_alloc_pages(size_t n) {
ffffffffc0202f9a:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc0202f9c:	00003697          	auipc	a3,0x3
ffffffffc0202fa0:	07c68693          	addi	a3,a3,124 # ffffffffc0206018 <commands+0x10f0>
ffffffffc0202fa4:	00002617          	auipc	a2,0x2
ffffffffc0202fa8:	38c60613          	addi	a2,a2,908 # ffffffffc0205330 <commands+0x408>
ffffffffc0202fac:	06200593          	li	a1,98
ffffffffc0202fb0:	00003517          	auipc	a0,0x3
ffffffffc0202fb4:	d2850513          	addi	a0,a0,-728 # ffffffffc0205cd8 <commands+0xdb0>
default_alloc_pages(size_t n) {
ffffffffc0202fb8:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0202fba:	a4afd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0202fbe <default_init_memmap>:
default_init_memmap(struct Page *base, size_t n) {
ffffffffc0202fbe:	1141                	addi	sp,sp,-16
ffffffffc0202fc0:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0202fc2:	c5f1                	beqz	a1,ffffffffc020308e <default_init_memmap+0xd0>
    for (; p != base + n; p ++) {
ffffffffc0202fc4:	00659693          	slli	a3,a1,0x6
ffffffffc0202fc8:	96aa                	add	a3,a3,a0
ffffffffc0202fca:	87aa                	mv	a5,a0
ffffffffc0202fcc:	00d50f63          	beq	a0,a3,ffffffffc0202fea <default_init_memmap+0x2c>
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0202fd0:	6798                	ld	a4,8(a5)
ffffffffc0202fd2:	8b05                	andi	a4,a4,1
        assert(PageReserved(p));
ffffffffc0202fd4:	cf49                	beqz	a4,ffffffffc020306e <default_init_memmap+0xb0>
        p->flags = p->property = 0;
ffffffffc0202fd6:	0007a823          	sw	zero,16(a5)
ffffffffc0202fda:	0007b423          	sd	zero,8(a5)
ffffffffc0202fde:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc0202fe2:	04078793          	addi	a5,a5,64
ffffffffc0202fe6:	fed795e3          	bne	a5,a3,ffffffffc0202fd0 <default_init_memmap+0x12>
    base->property = n;
ffffffffc0202fea:	2581                	sext.w	a1,a1
ffffffffc0202fec:	c90c                	sw	a1,16(a0)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0202fee:	4789                	li	a5,2
ffffffffc0202ff0:	00850713          	addi	a4,a0,8
ffffffffc0202ff4:	40f7302f          	amoor.d	zero,a5,(a4)
    nr_free += n;
ffffffffc0202ff8:	00031697          	auipc	a3,0x31
ffffffffc0202ffc:	e2068693          	addi	a3,a3,-480 # ffffffffc0233e18 <free_area>
ffffffffc0203000:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc0203002:	669c                	ld	a5,8(a3)
ffffffffc0203004:	01850613          	addi	a2,a0,24
ffffffffc0203008:	9db9                	addw	a1,a1,a4
ffffffffc020300a:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc020300c:	04d78a63          	beq	a5,a3,ffffffffc0203060 <default_init_memmap+0xa2>
            struct Page* page = le2page(le, page_link);
ffffffffc0203010:	fe878713          	addi	a4,a5,-24
ffffffffc0203014:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list)) {
ffffffffc0203018:	4581                	li	a1,0
            if (base < page) {
ffffffffc020301a:	00e56a63          	bltu	a0,a4,ffffffffc020302e <default_init_memmap+0x70>
    return listelm->next;
ffffffffc020301e:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc0203020:	02d70263          	beq	a4,a3,ffffffffc0203044 <default_init_memmap+0x86>
    for (; p != base + n; p ++) {
ffffffffc0203024:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc0203026:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc020302a:	fee57ae3          	bgeu	a0,a4,ffffffffc020301e <default_init_memmap+0x60>
ffffffffc020302e:	c199                	beqz	a1,ffffffffc0203034 <default_init_memmap+0x76>
ffffffffc0203030:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc0203034:	6398                	ld	a4,0(a5)
}
ffffffffc0203036:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0203038:	e390                	sd	a2,0(a5)
ffffffffc020303a:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc020303c:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc020303e:	ed18                	sd	a4,24(a0)
ffffffffc0203040:	0141                	addi	sp,sp,16
ffffffffc0203042:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0203044:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0203046:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0203048:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc020304a:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc020304c:	00d70663          	beq	a4,a3,ffffffffc0203058 <default_init_memmap+0x9a>
    prev->next = next->prev = elm;
ffffffffc0203050:	8832                	mv	a6,a2
ffffffffc0203052:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc0203054:	87ba                	mv	a5,a4
ffffffffc0203056:	bfc1                	j	ffffffffc0203026 <default_init_memmap+0x68>
}
ffffffffc0203058:	60a2                	ld	ra,8(sp)
ffffffffc020305a:	e290                	sd	a2,0(a3)
ffffffffc020305c:	0141                	addi	sp,sp,16
ffffffffc020305e:	8082                	ret
ffffffffc0203060:	60a2                	ld	ra,8(sp)
ffffffffc0203062:	e390                	sd	a2,0(a5)
ffffffffc0203064:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0203066:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0203068:	ed1c                	sd	a5,24(a0)
ffffffffc020306a:	0141                	addi	sp,sp,16
ffffffffc020306c:	8082                	ret
        assert(PageReserved(p));
ffffffffc020306e:	00003697          	auipc	a3,0x3
ffffffffc0203072:	fda68693          	addi	a3,a3,-38 # ffffffffc0206048 <commands+0x1120>
ffffffffc0203076:	00002617          	auipc	a2,0x2
ffffffffc020307a:	2ba60613          	addi	a2,a2,698 # ffffffffc0205330 <commands+0x408>
ffffffffc020307e:	04900593          	li	a1,73
ffffffffc0203082:	00003517          	auipc	a0,0x3
ffffffffc0203086:	c5650513          	addi	a0,a0,-938 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc020308a:	97afd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(n > 0);
ffffffffc020308e:	00003697          	auipc	a3,0x3
ffffffffc0203092:	f8a68693          	addi	a3,a3,-118 # ffffffffc0206018 <commands+0x10f0>
ffffffffc0203096:	00002617          	auipc	a2,0x2
ffffffffc020309a:	29a60613          	addi	a2,a2,666 # ffffffffc0205330 <commands+0x408>
ffffffffc020309e:	04600593          	li	a1,70
ffffffffc02030a2:	00003517          	auipc	a0,0x3
ffffffffc02030a6:	c3650513          	addi	a0,a0,-970 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc02030aa:	95afd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02030ae <swapfs_init>:
#include <ide.h>
#include <pmm.h>
#include <assert.h>

void
swapfs_init(void) {
ffffffffc02030ae:	1141                	addi	sp,sp,-16
    static_assert((PGSIZE % SECTSIZE) == 0);
    if (!ide_device_valid(SWAP_DEV_NO)) {
ffffffffc02030b0:	4505                	li	a0,1
swapfs_init(void) {
ffffffffc02030b2:	e406                	sd	ra,8(sp)
    if (!ide_device_valid(SWAP_DEV_NO)) {
ffffffffc02030b4:	c6afd0ef          	jal	ra,ffffffffc020051e <ide_device_valid>
ffffffffc02030b8:	cd01                	beqz	a0,ffffffffc02030d0 <swapfs_init+0x22>
        panic("swap fs isn't available.\n");
    }
    max_swap_offset = ide_device_size(SWAP_DEV_NO) / (PGSIZE / SECTSIZE);
ffffffffc02030ba:	4505                	li	a0,1
ffffffffc02030bc:	c68fd0ef          	jal	ra,ffffffffc0200524 <ide_device_size>
}
ffffffffc02030c0:	60a2                	ld	ra,8(sp)
    max_swap_offset = ide_device_size(SWAP_DEV_NO) / (PGSIZE / SECTSIZE);
ffffffffc02030c2:	810d                	srli	a0,a0,0x3
ffffffffc02030c4:	00031797          	auipc	a5,0x31
ffffffffc02030c8:	d0a7b223          	sd	a0,-764(a5) # ffffffffc0233dc8 <max_swap_offset>
}
ffffffffc02030cc:	0141                	addi	sp,sp,16
ffffffffc02030ce:	8082                	ret
        panic("swap fs isn't available.\n");
ffffffffc02030d0:	00003617          	auipc	a2,0x3
ffffffffc02030d4:	fd860613          	addi	a2,a2,-40 # ffffffffc02060a8 <default_pmm_manager+0x38>
ffffffffc02030d8:	45b5                	li	a1,13
ffffffffc02030da:	00003517          	auipc	a0,0x3
ffffffffc02030de:	fee50513          	addi	a0,a0,-18 # ffffffffc02060c8 <default_pmm_manager+0x58>
ffffffffc02030e2:	922fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02030e6 <swapfs_read>:

int
swapfs_read(swap_entry_t entry, struct Page *page) {
ffffffffc02030e6:	1141                	addi	sp,sp,-16
ffffffffc02030e8:	e406                	sd	ra,8(sp)
    return ide_read_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc02030ea:	00855793          	srli	a5,a0,0x8
ffffffffc02030ee:	cbb1                	beqz	a5,ffffffffc0203142 <swapfs_read+0x5c>
ffffffffc02030f0:	00031717          	auipc	a4,0x31
ffffffffc02030f4:	cd873703          	ld	a4,-808(a4) # ffffffffc0233dc8 <max_swap_offset>
ffffffffc02030f8:	04e7f563          	bgeu	a5,a4,ffffffffc0203142 <swapfs_read+0x5c>
    return page - pages + nbase;
ffffffffc02030fc:	00031617          	auipc	a2,0x31
ffffffffc0203100:	c3463603          	ld	a2,-972(a2) # ffffffffc0233d30 <pages>
ffffffffc0203104:	8d91                	sub	a1,a1,a2
ffffffffc0203106:	4065d613          	srai	a2,a1,0x6
ffffffffc020310a:	00004717          	auipc	a4,0x4
ffffffffc020310e:	99e73703          	ld	a4,-1634(a4) # ffffffffc0206aa8 <nbase>
ffffffffc0203112:	963a                	add	a2,a2,a4
    return KADDR(page2pa(page));
ffffffffc0203114:	00c61713          	slli	a4,a2,0xc
ffffffffc0203118:	8331                	srli	a4,a4,0xc
ffffffffc020311a:	00031697          	auipc	a3,0x31
ffffffffc020311e:	b9e6b683          	ld	a3,-1122(a3) # ffffffffc0233cb8 <npage>
ffffffffc0203122:	0037959b          	slliw	a1,a5,0x3
    return page2ppn(page) << PGSHIFT;
ffffffffc0203126:	0632                	slli	a2,a2,0xc
    return KADDR(page2pa(page));
ffffffffc0203128:	02d77963          	bgeu	a4,a3,ffffffffc020315a <swapfs_read+0x74>
}
ffffffffc020312c:	60a2                	ld	ra,8(sp)
    return ide_read_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc020312e:	00031797          	auipc	a5,0x31
ffffffffc0203132:	bf27b783          	ld	a5,-1038(a5) # ffffffffc0233d20 <va_pa_offset>
ffffffffc0203136:	46a1                	li	a3,8
ffffffffc0203138:	963e                	add	a2,a2,a5
ffffffffc020313a:	4505                	li	a0,1
}
ffffffffc020313c:	0141                	addi	sp,sp,16
    return ide_read_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc020313e:	becfd06f          	j	ffffffffc020052a <ide_read_secs>
ffffffffc0203142:	86aa                	mv	a3,a0
ffffffffc0203144:	00003617          	auipc	a2,0x3
ffffffffc0203148:	f9c60613          	addi	a2,a2,-100 # ffffffffc02060e0 <default_pmm_manager+0x70>
ffffffffc020314c:	45d1                	li	a1,20
ffffffffc020314e:	00003517          	auipc	a0,0x3
ffffffffc0203152:	f7a50513          	addi	a0,a0,-134 # ffffffffc02060c8 <default_pmm_manager+0x58>
ffffffffc0203156:	8aefd0ef          	jal	ra,ffffffffc0200204 <__panic>
ffffffffc020315a:	86b2                	mv	a3,a2
ffffffffc020315c:	06900593          	li	a1,105
ffffffffc0203160:	00002617          	auipc	a2,0x2
ffffffffc0203164:	58060613          	addi	a2,a2,1408 # ffffffffc02056e0 <commands+0x7b8>
ffffffffc0203168:	00002517          	auipc	a0,0x2
ffffffffc020316c:	4d850513          	addi	a0,a0,1240 # ffffffffc0205640 <commands+0x718>
ffffffffc0203170:	894fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0203174 <swapfs_write>:

int
swapfs_write(swap_entry_t entry, struct Page *page) {
ffffffffc0203174:	1141                	addi	sp,sp,-16
ffffffffc0203176:	e406                	sd	ra,8(sp)
    return ide_write_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc0203178:	00855793          	srli	a5,a0,0x8
ffffffffc020317c:	cbb1                	beqz	a5,ffffffffc02031d0 <swapfs_write+0x5c>
ffffffffc020317e:	00031717          	auipc	a4,0x31
ffffffffc0203182:	c4a73703          	ld	a4,-950(a4) # ffffffffc0233dc8 <max_swap_offset>
ffffffffc0203186:	04e7f563          	bgeu	a5,a4,ffffffffc02031d0 <swapfs_write+0x5c>
    return page - pages + nbase;
ffffffffc020318a:	00031617          	auipc	a2,0x31
ffffffffc020318e:	ba663603          	ld	a2,-1114(a2) # ffffffffc0233d30 <pages>
ffffffffc0203192:	8d91                	sub	a1,a1,a2
ffffffffc0203194:	4065d613          	srai	a2,a1,0x6
ffffffffc0203198:	00004717          	auipc	a4,0x4
ffffffffc020319c:	91073703          	ld	a4,-1776(a4) # ffffffffc0206aa8 <nbase>
ffffffffc02031a0:	963a                	add	a2,a2,a4
    return KADDR(page2pa(page));
ffffffffc02031a2:	00c61713          	slli	a4,a2,0xc
ffffffffc02031a6:	8331                	srli	a4,a4,0xc
ffffffffc02031a8:	00031697          	auipc	a3,0x31
ffffffffc02031ac:	b106b683          	ld	a3,-1264(a3) # ffffffffc0233cb8 <npage>
ffffffffc02031b0:	0037959b          	slliw	a1,a5,0x3
    return page2ppn(page) << PGSHIFT;
ffffffffc02031b4:	0632                	slli	a2,a2,0xc
    return KADDR(page2pa(page));
ffffffffc02031b6:	02d77963          	bgeu	a4,a3,ffffffffc02031e8 <swapfs_write+0x74>
}
ffffffffc02031ba:	60a2                	ld	ra,8(sp)
    return ide_write_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc02031bc:	00031797          	auipc	a5,0x31
ffffffffc02031c0:	b647b783          	ld	a5,-1180(a5) # ffffffffc0233d20 <va_pa_offset>
ffffffffc02031c4:	46a1                	li	a3,8
ffffffffc02031c6:	963e                	add	a2,a2,a5
ffffffffc02031c8:	4505                	li	a0,1
}
ffffffffc02031ca:	0141                	addi	sp,sp,16
    return ide_write_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc02031cc:	b82fd06f          	j	ffffffffc020054e <ide_write_secs>
ffffffffc02031d0:	86aa                	mv	a3,a0
ffffffffc02031d2:	00003617          	auipc	a2,0x3
ffffffffc02031d6:	f0e60613          	addi	a2,a2,-242 # ffffffffc02060e0 <default_pmm_manager+0x70>
ffffffffc02031da:	45e5                	li	a1,25
ffffffffc02031dc:	00003517          	auipc	a0,0x3
ffffffffc02031e0:	eec50513          	addi	a0,a0,-276 # ffffffffc02060c8 <default_pmm_manager+0x58>
ffffffffc02031e4:	820fd0ef          	jal	ra,ffffffffc0200204 <__panic>
ffffffffc02031e8:	86b2                	mv	a3,a2
ffffffffc02031ea:	06900593          	li	a1,105
ffffffffc02031ee:	00002617          	auipc	a2,0x2
ffffffffc02031f2:	4f260613          	addi	a2,a2,1266 # ffffffffc02056e0 <commands+0x7b8>
ffffffffc02031f6:	00002517          	auipc	a0,0x2
ffffffffc02031fa:	44a50513          	addi	a0,a0,1098 # ffffffffc0205640 <commands+0x718>
ffffffffc02031fe:	806fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0203202 <kernel_thread_entry>:
.text
.globl kernel_thread_entry
kernel_thread_entry:        # void kernel_thread(void)
	move a0, s1
ffffffffc0203202:	8526                	mv	a0,s1
	jalr s0
ffffffffc0203204:	9402                	jalr	s0

	jal do_exit
ffffffffc0203206:	77a000ef          	jal	ra,ffffffffc0203980 <do_exit>

ffffffffc020320a <switch_to>:
.text
# void switch_to(struct proc_struct* from, struct proc_struct* to)
.globl switch_to
switch_to:
    # save from's registers
    STORE ra, 0*REGBYTES(a0)
ffffffffc020320a:	00153023          	sd	ra,0(a0)
    STORE sp, 1*REGBYTES(a0)
ffffffffc020320e:	00253423          	sd	sp,8(a0)
    STORE s0, 2*REGBYTES(a0)
ffffffffc0203212:	e900                	sd	s0,16(a0)
    STORE s1, 3*REGBYTES(a0)
ffffffffc0203214:	ed04                	sd	s1,24(a0)
    STORE s2, 4*REGBYTES(a0)
ffffffffc0203216:	03253023          	sd	s2,32(a0)
    STORE s3, 5*REGBYTES(a0)
ffffffffc020321a:	03353423          	sd	s3,40(a0)
    STORE s4, 6*REGBYTES(a0)
ffffffffc020321e:	03453823          	sd	s4,48(a0)
    STORE s5, 7*REGBYTES(a0)
ffffffffc0203222:	03553c23          	sd	s5,56(a0)
    STORE s6, 8*REGBYTES(a0)
ffffffffc0203226:	05653023          	sd	s6,64(a0)
    STORE s7, 9*REGBYTES(a0)
ffffffffc020322a:	05753423          	sd	s7,72(a0)
    STORE s8, 10*REGBYTES(a0)
ffffffffc020322e:	05853823          	sd	s8,80(a0)
    STORE s9, 11*REGBYTES(a0)
ffffffffc0203232:	05953c23          	sd	s9,88(a0)
    STORE s10, 12*REGBYTES(a0)
ffffffffc0203236:	07a53023          	sd	s10,96(a0)
    STORE s11, 13*REGBYTES(a0)
ffffffffc020323a:	07b53423          	sd	s11,104(a0)

    # restore to's registers
    LOAD ra, 0*REGBYTES(a1)
ffffffffc020323e:	0005b083          	ld	ra,0(a1)
    LOAD sp, 1*REGBYTES(a1)
ffffffffc0203242:	0085b103          	ld	sp,8(a1)
    LOAD s0, 2*REGBYTES(a1)
ffffffffc0203246:	6980                	ld	s0,16(a1)
    LOAD s1, 3*REGBYTES(a1)
ffffffffc0203248:	6d84                	ld	s1,24(a1)
    LOAD s2, 4*REGBYTES(a1)
ffffffffc020324a:	0205b903          	ld	s2,32(a1)
    LOAD s3, 5*REGBYTES(a1)
ffffffffc020324e:	0285b983          	ld	s3,40(a1)
    LOAD s4, 6*REGBYTES(a1)
ffffffffc0203252:	0305ba03          	ld	s4,48(a1)
    LOAD s5, 7*REGBYTES(a1)
ffffffffc0203256:	0385ba83          	ld	s5,56(a1)
    LOAD s6, 8*REGBYTES(a1)
ffffffffc020325a:	0405bb03          	ld	s6,64(a1)
    LOAD s7, 9*REGBYTES(a1)
ffffffffc020325e:	0485bb83          	ld	s7,72(a1)
    LOAD s8, 10*REGBYTES(a1)
ffffffffc0203262:	0505bc03          	ld	s8,80(a1)
    LOAD s9, 11*REGBYTES(a1)
ffffffffc0203266:	0585bc83          	ld	s9,88(a1)
    LOAD s10, 12*REGBYTES(a1)
ffffffffc020326a:	0605bd03          	ld	s10,96(a1)
    LOAD s11, 13*REGBYTES(a1)
ffffffffc020326e:	0685bd83          	ld	s11,104(a1)

    ret
ffffffffc0203272:	8082                	ret

ffffffffc0203274 <alloc_proc>:
void forkrets(struct trapframe *tf);
void switch_to(struct context *from, struct context *to);

// alloc_proc - alloc a proc_struct and init all fields of proc_struct
static struct proc_struct *
alloc_proc(void) {
ffffffffc0203274:	1141                	addi	sp,sp,-16
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203276:	14800513          	li	a0,328
alloc_proc(void) {
ffffffffc020327a:	e022                	sd	s0,0(sp)
ffffffffc020327c:	e406                	sd	ra,8(sp)
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc020327e:	df9fe0ef          	jal	ra,ffffffffc0202076 <kmalloc>
ffffffffc0203282:	842a                	mv	s0,a0
    if (proc != NULL) {
ffffffffc0203284:	c535                	beqz	a0,ffffffffc02032f0 <alloc_proc+0x7c>
        proc->state = PROC_UNINIT;
ffffffffc0203286:	57fd                	li	a5,-1
ffffffffc0203288:	1782                	slli	a5,a5,0x20
ffffffffc020328a:	e11c                	sd	a5,0(a0)
        proc->runs = 0;
        proc->kstack = 0;
        proc->need_resched = 0;
        proc->parent = NULL;
        proc->mm = NULL;
        memset(&(proc->context), 0, sizeof(struct context));
ffffffffc020328c:	07000613          	li	a2,112
ffffffffc0203290:	4581                	li	a1,0
        proc->runs = 0;
ffffffffc0203292:	00052423          	sw	zero,8(a0)
        proc->kstack = 0;
ffffffffc0203296:	00053823          	sd	zero,16(a0)
        proc->need_resched = 0;
ffffffffc020329a:	00053c23          	sd	zero,24(a0)
        proc->parent = NULL;
ffffffffc020329e:	02053023          	sd	zero,32(a0)
        proc->mm = NULL;
ffffffffc02032a2:	02053423          	sd	zero,40(a0)
        memset(&(proc->context), 0, sizeof(struct context));
ffffffffc02032a6:	03050513          	addi	a0,a0,48
ffffffffc02032aa:	5aa010ef          	jal	ra,ffffffffc0204854 <memset>
        proc->tf = NULL;
        proc->cr3 = boot_cr3;
ffffffffc02032ae:	00031797          	auipc	a5,0x31
ffffffffc02032b2:	a7a7b783          	ld	a5,-1414(a5) # ffffffffc0233d28 <boot_cr3>
        proc->tf = NULL;
ffffffffc02032b6:	0a043023          	sd	zero,160(s0)
        proc->cr3 = boot_cr3;
ffffffffc02032ba:	f45c                	sd	a5,168(s0)
        proc->flags = 0;
ffffffffc02032bc:	0a042823          	sw	zero,176(s0)
        memset(proc->name, 0, PROC_NAME_LEN);
ffffffffc02032c0:	463d                	li	a2,15
ffffffffc02032c2:	4581                	li	a1,0
ffffffffc02032c4:	0b440513          	addi	a0,s0,180
ffffffffc02032c8:	58c010ef          	jal	ra,ffffffffc0204854 <memset>
        proc->wait_state = 0;
ffffffffc02032cc:	0e042623          	sw	zero,236(s0)
        proc->cptr = proc->optr = proc->yptr = NULL;
ffffffffc02032d0:	0e043c23          	sd	zero,248(s0)
ffffffffc02032d4:	10043023          	sd	zero,256(s0)
ffffffffc02032d8:	0e043823          	sd	zero,240(s0)
        proc->time_slice = 0;
ffffffffc02032dc:	12042023          	sw	zero,288(s0)
        proc->labschedule_run_pool.left = proc->labschedule_run_pool.right = proc->labschedule_run_pool.parent = NULL;
ffffffffc02032e0:	12043423          	sd	zero,296(s0)
ffffffffc02032e4:	12043823          	sd	zero,304(s0)
ffffffffc02032e8:	12043c23          	sd	zero,312(s0)
        proc->labschedule_stride = 0;
ffffffffc02032ec:	14043023          	sd	zero,320(s0)
        proc->labschedule_priority = 0;
    }
    return proc;
}
ffffffffc02032f0:	60a2                	ld	ra,8(sp)
ffffffffc02032f2:	8522                	mv	a0,s0
ffffffffc02032f4:	6402                	ld	s0,0(sp)
ffffffffc02032f6:	0141                	addi	sp,sp,16
ffffffffc02032f8:	8082                	ret

ffffffffc02032fa <forkret>:
// forkret -- the first kernel entry point of a new thread/process
// NOTE: the addr of forkret is setted in copy_thread function
//       after switch_to, the current proc will execute here.
static void
forkret(void) {
    forkrets(current->tf);
ffffffffc02032fa:	00031797          	auipc	a5,0x31
ffffffffc02032fe:	9e67b783          	ld	a5,-1562(a5) # ffffffffc0233ce0 <current>
ffffffffc0203302:	73c8                	ld	a0,160(a5)
ffffffffc0203304:	a2ffd06f          	j	ffffffffc0200d32 <forkrets>

ffffffffc0203308 <user_main>:
static int
user_main(void *arg) {
#ifdef TEST
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
#else
    KERNEL_EXECVE(rr);
ffffffffc0203308:	00031797          	auipc	a5,0x31
ffffffffc020330c:	9d87b783          	ld	a5,-1576(a5) # ffffffffc0233ce0 <current>
ffffffffc0203310:	43cc                	lw	a1,4(a5)
user_main(void *arg) {
ffffffffc0203312:	7139                	addi	sp,sp,-64
    KERNEL_EXECVE(rr);
ffffffffc0203314:	00003617          	auipc	a2,0x3
ffffffffc0203318:	dec60613          	addi	a2,a2,-532 # ffffffffc0206100 <default_pmm_manager+0x90>
ffffffffc020331c:	00003517          	auipc	a0,0x3
ffffffffc0203320:	dec50513          	addi	a0,a0,-532 # ffffffffc0206108 <default_pmm_manager+0x98>
user_main(void *arg) {
ffffffffc0203324:	fc06                	sd	ra,56(sp)
    KERNEL_EXECVE(rr);
ffffffffc0203326:	da3fc0ef          	jal	ra,ffffffffc02000c8 <cprintf>
ffffffffc020332a:	3fe07797          	auipc	a5,0x3fe07
ffffffffc020332e:	6e678793          	addi	a5,a5,1766 # aa10 <_binary_obj___user_rr_out_size>
ffffffffc0203332:	e43e                	sd	a5,8(sp)
ffffffffc0203334:	00003517          	auipc	a0,0x3
ffffffffc0203338:	dcc50513          	addi	a0,a0,-564 # ffffffffc0206100 <default_pmm_manager+0x90>
ffffffffc020333c:	00010797          	auipc	a5,0x10
ffffffffc0203340:	57c78793          	addi	a5,a5,1404 # ffffffffc02138b8 <_binary_obj___user_rr_out_start>
ffffffffc0203344:	f03e                	sd	a5,32(sp)
ffffffffc0203346:	f42a                	sd	a0,40(sp)
    int64_t ret=0, len = strlen(name);
ffffffffc0203348:	e802                	sd	zero,16(sp)
ffffffffc020334a:	4a0010ef          	jal	ra,ffffffffc02047ea <strlen>
ffffffffc020334e:	ec2a                	sd	a0,24(sp)
    asm volatile(
ffffffffc0203350:	4511                	li	a0,4
ffffffffc0203352:	55a2                	lw	a1,40(sp)
ffffffffc0203354:	4662                	lw	a2,24(sp)
ffffffffc0203356:	5682                	lw	a3,32(sp)
ffffffffc0203358:	4722                	lw	a4,8(sp)
ffffffffc020335a:	48a9                	li	a7,10
ffffffffc020335c:	9002                	ebreak
ffffffffc020335e:	c82a                	sw	a0,16(sp)
    cprintf("ret = %d\n", ret);
ffffffffc0203360:	65c2                	ld	a1,16(sp)
ffffffffc0203362:	00003517          	auipc	a0,0x3
ffffffffc0203366:	dce50513          	addi	a0,a0,-562 # ffffffffc0206130 <default_pmm_manager+0xc0>
ffffffffc020336a:	d5ffc0ef          	jal	ra,ffffffffc02000c8 <cprintf>
#endif
    panic("user_main execve failed.\n");
ffffffffc020336e:	00003617          	auipc	a2,0x3
ffffffffc0203372:	dd260613          	addi	a2,a2,-558 # ffffffffc0206140 <default_pmm_manager+0xd0>
ffffffffc0203376:	30700593          	li	a1,775
ffffffffc020337a:	00003517          	auipc	a0,0x3
ffffffffc020337e:	de650513          	addi	a0,a0,-538 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc0203382:	e83fc0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0203386 <put_pgdir>:
    return pa2page(PADDR(kva));
ffffffffc0203386:	6d14                	ld	a3,24(a0)
put_pgdir(struct mm_struct *mm) {
ffffffffc0203388:	1141                	addi	sp,sp,-16
ffffffffc020338a:	e406                	sd	ra,8(sp)
ffffffffc020338c:	c02007b7          	lui	a5,0xc0200
ffffffffc0203390:	02f6ee63          	bltu	a3,a5,ffffffffc02033cc <put_pgdir+0x46>
ffffffffc0203394:	00031517          	auipc	a0,0x31
ffffffffc0203398:	98c53503          	ld	a0,-1652(a0) # ffffffffc0233d20 <va_pa_offset>
ffffffffc020339c:	8e89                	sub	a3,a3,a0
    if (PPN(pa) >= npage) {
ffffffffc020339e:	82b1                	srli	a3,a3,0xc
ffffffffc02033a0:	00031797          	auipc	a5,0x31
ffffffffc02033a4:	9187b783          	ld	a5,-1768(a5) # ffffffffc0233cb8 <npage>
ffffffffc02033a8:	02f6fe63          	bgeu	a3,a5,ffffffffc02033e4 <put_pgdir+0x5e>
    return &pages[PPN(pa) - nbase];
ffffffffc02033ac:	00003517          	auipc	a0,0x3
ffffffffc02033b0:	6fc53503          	ld	a0,1788(a0) # ffffffffc0206aa8 <nbase>
}
ffffffffc02033b4:	60a2                	ld	ra,8(sp)
ffffffffc02033b6:	8e89                	sub	a3,a3,a0
ffffffffc02033b8:	069a                	slli	a3,a3,0x6
    free_page(kva2page(mm->pgdir));
ffffffffc02033ba:	00031517          	auipc	a0,0x31
ffffffffc02033be:	97653503          	ld	a0,-1674(a0) # ffffffffc0233d30 <pages>
ffffffffc02033c2:	4585                	li	a1,1
ffffffffc02033c4:	9536                	add	a0,a0,a3
}
ffffffffc02033c6:	0141                	addi	sp,sp,16
    free_page(kva2page(mm->pgdir));
ffffffffc02033c8:	a1dfd06f          	j	ffffffffc0200de4 <free_pages>
    return pa2page(PADDR(kva));
ffffffffc02033cc:	00002617          	auipc	a2,0x2
ffffffffc02033d0:	2dc60613          	addi	a2,a2,732 # ffffffffc02056a8 <commands+0x780>
ffffffffc02033d4:	06e00593          	li	a1,110
ffffffffc02033d8:	00002517          	auipc	a0,0x2
ffffffffc02033dc:	26850513          	addi	a0,a0,616 # ffffffffc0205640 <commands+0x718>
ffffffffc02033e0:	e25fc0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02033e4:	00002617          	auipc	a2,0x2
ffffffffc02033e8:	23c60613          	addi	a2,a2,572 # ffffffffc0205620 <commands+0x6f8>
ffffffffc02033ec:	06200593          	li	a1,98
ffffffffc02033f0:	00002517          	auipc	a0,0x2
ffffffffc02033f4:	25050513          	addi	a0,a0,592 # ffffffffc0205640 <commands+0x718>
ffffffffc02033f8:	e0dfc0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02033fc <setup_pgdir>:
setup_pgdir(struct mm_struct *mm) {
ffffffffc02033fc:	1101                	addi	sp,sp,-32
ffffffffc02033fe:	e426                	sd	s1,8(sp)
ffffffffc0203400:	84aa                	mv	s1,a0
    if ((page = alloc_page()) == NULL) {
ffffffffc0203402:	4505                	li	a0,1
setup_pgdir(struct mm_struct *mm) {
ffffffffc0203404:	ec06                	sd	ra,24(sp)
ffffffffc0203406:	e822                	sd	s0,16(sp)
    if ((page = alloc_page()) == NULL) {
ffffffffc0203408:	94bfd0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc020340c:	c939                	beqz	a0,ffffffffc0203462 <setup_pgdir+0x66>
    return page - pages + nbase;
ffffffffc020340e:	00031697          	auipc	a3,0x31
ffffffffc0203412:	9226b683          	ld	a3,-1758(a3) # ffffffffc0233d30 <pages>
ffffffffc0203416:	40d506b3          	sub	a3,a0,a3
ffffffffc020341a:	8699                	srai	a3,a3,0x6
ffffffffc020341c:	00003417          	auipc	s0,0x3
ffffffffc0203420:	68c43403          	ld	s0,1676(s0) # ffffffffc0206aa8 <nbase>
ffffffffc0203424:	96a2                	add	a3,a3,s0
    return KADDR(page2pa(page));
ffffffffc0203426:	00c69793          	slli	a5,a3,0xc
ffffffffc020342a:	83b1                	srli	a5,a5,0xc
ffffffffc020342c:	00031717          	auipc	a4,0x31
ffffffffc0203430:	88c73703          	ld	a4,-1908(a4) # ffffffffc0233cb8 <npage>
    return page2ppn(page) << PGSHIFT;
ffffffffc0203434:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0203436:	02e7f863          	bgeu	a5,a4,ffffffffc0203466 <setup_pgdir+0x6a>
ffffffffc020343a:	00031417          	auipc	s0,0x31
ffffffffc020343e:	8e643403          	ld	s0,-1818(s0) # ffffffffc0233d20 <va_pa_offset>
ffffffffc0203442:	9436                	add	s0,s0,a3
    memcpy(pgdir, boot_pgdir, PGSIZE);
ffffffffc0203444:	6605                	lui	a2,0x1
ffffffffc0203446:	00031597          	auipc	a1,0x31
ffffffffc020344a:	86a5b583          	ld	a1,-1942(a1) # ffffffffc0233cb0 <boot_pgdir>
ffffffffc020344e:	8522                	mv	a0,s0
ffffffffc0203450:	416010ef          	jal	ra,ffffffffc0204866 <memcpy>
    return 0;
ffffffffc0203454:	4501                	li	a0,0
    mm->pgdir = pgdir;
ffffffffc0203456:	ec80                	sd	s0,24(s1)
}
ffffffffc0203458:	60e2                	ld	ra,24(sp)
ffffffffc020345a:	6442                	ld	s0,16(sp)
ffffffffc020345c:	64a2                	ld	s1,8(sp)
ffffffffc020345e:	6105                	addi	sp,sp,32
ffffffffc0203460:	8082                	ret
        return -E_NO_MEM;
ffffffffc0203462:	5571                	li	a0,-4
ffffffffc0203464:	bfd5                	j	ffffffffc0203458 <setup_pgdir+0x5c>
ffffffffc0203466:	00002617          	auipc	a2,0x2
ffffffffc020346a:	27a60613          	addi	a2,a2,634 # ffffffffc02056e0 <commands+0x7b8>
ffffffffc020346e:	06900593          	li	a1,105
ffffffffc0203472:	00002517          	auipc	a0,0x2
ffffffffc0203476:	1ce50513          	addi	a0,a0,462 # ffffffffc0205640 <commands+0x718>
ffffffffc020347a:	d8bfc0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020347e <set_proc_name>:
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc020347e:	1101                	addi	sp,sp,-32
ffffffffc0203480:	e822                	sd	s0,16(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0203482:	0b450413          	addi	s0,a0,180
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc0203486:	e426                	sd	s1,8(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0203488:	4641                	li	a2,16
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc020348a:	84ae                	mv	s1,a1
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc020348c:	8522                	mv	a0,s0
ffffffffc020348e:	4581                	li	a1,0
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc0203490:	ec06                	sd	ra,24(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0203492:	3c2010ef          	jal	ra,ffffffffc0204854 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0203496:	8522                	mv	a0,s0
}
ffffffffc0203498:	6442                	ld	s0,16(sp)
ffffffffc020349a:	60e2                	ld	ra,24(sp)
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc020349c:	85a6                	mv	a1,s1
}
ffffffffc020349e:	64a2                	ld	s1,8(sp)
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc02034a0:	463d                	li	a2,15
}
ffffffffc02034a2:	6105                	addi	sp,sp,32
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc02034a4:	3c20106f          	j	ffffffffc0204866 <memcpy>

ffffffffc02034a8 <proc_run>:
proc_run(struct proc_struct *proc) {
ffffffffc02034a8:	7179                	addi	sp,sp,-48
ffffffffc02034aa:	ec4a                	sd	s2,24(sp)
    if (proc != current) {
ffffffffc02034ac:	00031917          	auipc	s2,0x31
ffffffffc02034b0:	83490913          	addi	s2,s2,-1996 # ffffffffc0233ce0 <current>
proc_run(struct proc_struct *proc) {
ffffffffc02034b4:	f026                	sd	s1,32(sp)
    if (proc != current) {
ffffffffc02034b6:	00093483          	ld	s1,0(s2)
proc_run(struct proc_struct *proc) {
ffffffffc02034ba:	f406                	sd	ra,40(sp)
ffffffffc02034bc:	e84e                	sd	s3,16(sp)
    if (proc != current) {
ffffffffc02034be:	02a48863          	beq	s1,a0,ffffffffc02034ee <proc_run+0x46>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02034c2:	100027f3          	csrr	a5,sstatus
ffffffffc02034c6:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02034c8:	4981                	li	s3,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02034ca:	ef9d                	bnez	a5,ffffffffc0203508 <proc_run+0x60>

#define barrier() __asm__ __volatile__ ("fence" ::: "memory")

static inline void
lcr3(unsigned long cr3) {
    write_csr(satp, 0x8000000000000000 | (cr3 >> RISCV_PGSHIFT));
ffffffffc02034cc:	755c                	ld	a5,168(a0)
ffffffffc02034ce:	577d                	li	a4,-1
ffffffffc02034d0:	177e                	slli	a4,a4,0x3f
ffffffffc02034d2:	83b1                	srli	a5,a5,0xc
            current = proc;
ffffffffc02034d4:	00a93023          	sd	a0,0(s2)
ffffffffc02034d8:	8fd9                	or	a5,a5,a4
ffffffffc02034da:	18079073          	csrw	satp,a5
            switch_to(&(prev->context), &(next->context));
ffffffffc02034de:	03050593          	addi	a1,a0,48
ffffffffc02034e2:	03048513          	addi	a0,s1,48
ffffffffc02034e6:	d25ff0ef          	jal	ra,ffffffffc020320a <switch_to>
    if (flag) {
ffffffffc02034ea:	00099863          	bnez	s3,ffffffffc02034fa <proc_run+0x52>
}
ffffffffc02034ee:	70a2                	ld	ra,40(sp)
ffffffffc02034f0:	7482                	ld	s1,32(sp)
ffffffffc02034f2:	6962                	ld	s2,24(sp)
ffffffffc02034f4:	69c2                	ld	s3,16(sp)
ffffffffc02034f6:	6145                	addi	sp,sp,48
ffffffffc02034f8:	8082                	ret
ffffffffc02034fa:	70a2                	ld	ra,40(sp)
ffffffffc02034fc:	7482                	ld	s1,32(sp)
ffffffffc02034fe:	6962                	ld	s2,24(sp)
ffffffffc0203500:	69c2                	ld	s3,16(sp)
ffffffffc0203502:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc0203504:	928fd06f          	j	ffffffffc020062c <intr_enable>
ffffffffc0203508:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc020350a:	928fd0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc020350e:	6522                	ld	a0,8(sp)
ffffffffc0203510:	4985                	li	s3,1
ffffffffc0203512:	bf6d                	j	ffffffffc02034cc <proc_run+0x24>

ffffffffc0203514 <find_proc>:
    if (0 < pid && pid < MAX_PID) {
ffffffffc0203514:	6789                	lui	a5,0x2
ffffffffc0203516:	fff5071b          	addiw	a4,a0,-1
ffffffffc020351a:	17f9                	addi	a5,a5,-2
ffffffffc020351c:	04e7e063          	bltu	a5,a4,ffffffffc020355c <find_proc+0x48>
find_proc(int pid) {
ffffffffc0203520:	1141                	addi	sp,sp,-16
ffffffffc0203522:	e022                	sd	s0,0(sp)
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0203524:	45a9                	li	a1,10
ffffffffc0203526:	842a                	mv	s0,a0
ffffffffc0203528:	2501                	sext.w	a0,a0
find_proc(int pid) {
ffffffffc020352a:	e406                	sd	ra,8(sp)
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc020352c:	740010ef          	jal	ra,ffffffffc0204c6c <hash32>
ffffffffc0203530:	02051693          	slli	a3,a0,0x20
ffffffffc0203534:	0002c797          	auipc	a5,0x2c
ffffffffc0203538:	74478793          	addi	a5,a5,1860 # ffffffffc022fc78 <hash_list>
ffffffffc020353c:	82f1                	srli	a3,a3,0x1c
ffffffffc020353e:	96be                	add	a3,a3,a5
ffffffffc0203540:	87b6                	mv	a5,a3
        while ((le = list_next(le)) != list) {
ffffffffc0203542:	a029                	j	ffffffffc020354c <find_proc+0x38>
            if (proc->pid == pid) {
ffffffffc0203544:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0203548:	00870c63          	beq	a4,s0,ffffffffc0203560 <find_proc+0x4c>
    return listelm->next;
ffffffffc020354c:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list) {
ffffffffc020354e:	fef69be3          	bne	a3,a5,ffffffffc0203544 <find_proc+0x30>
}
ffffffffc0203552:	60a2                	ld	ra,8(sp)
ffffffffc0203554:	6402                	ld	s0,0(sp)
    return NULL;
ffffffffc0203556:	4501                	li	a0,0
}
ffffffffc0203558:	0141                	addi	sp,sp,16
ffffffffc020355a:	8082                	ret
    return NULL;
ffffffffc020355c:	4501                	li	a0,0
}
ffffffffc020355e:	8082                	ret
ffffffffc0203560:	60a2                	ld	ra,8(sp)
ffffffffc0203562:	6402                	ld	s0,0(sp)
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc0203564:	f2878513          	addi	a0,a5,-216
}
ffffffffc0203568:	0141                	addi	sp,sp,16
ffffffffc020356a:	8082                	ret

ffffffffc020356c <do_fork>:
do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf) {
ffffffffc020356c:	7159                	addi	sp,sp,-112
ffffffffc020356e:	e0d2                	sd	s4,64(sp)
    if (nr_process >= MAX_PROCESS) {
ffffffffc0203570:	00030a17          	auipc	s4,0x30
ffffffffc0203574:	788a0a13          	addi	s4,s4,1928 # ffffffffc0233cf8 <nr_process>
ffffffffc0203578:	000a2703          	lw	a4,0(s4)
do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf) {
ffffffffc020357c:	f486                	sd	ra,104(sp)
ffffffffc020357e:	f0a2                	sd	s0,96(sp)
ffffffffc0203580:	eca6                	sd	s1,88(sp)
ffffffffc0203582:	e8ca                	sd	s2,80(sp)
ffffffffc0203584:	e4ce                	sd	s3,72(sp)
ffffffffc0203586:	fc56                	sd	s5,56(sp)
ffffffffc0203588:	f85a                	sd	s6,48(sp)
ffffffffc020358a:	f45e                	sd	s7,40(sp)
ffffffffc020358c:	f062                	sd	s8,32(sp)
ffffffffc020358e:	ec66                	sd	s9,24(sp)
ffffffffc0203590:	e86a                	sd	s10,16(sp)
ffffffffc0203592:	e46e                	sd	s11,8(sp)
    if (nr_process >= MAX_PROCESS) {
ffffffffc0203594:	6785                	lui	a5,0x1
ffffffffc0203596:	2ef75c63          	bge	a4,a5,ffffffffc020388e <do_fork+0x322>
ffffffffc020359a:	89aa                	mv	s3,a0
ffffffffc020359c:	892e                	mv	s2,a1
ffffffffc020359e:	84b2                	mv	s1,a2
    if ((proc = alloc_proc()) == NULL) {
ffffffffc02035a0:	cd5ff0ef          	jal	ra,ffffffffc0203274 <alloc_proc>
ffffffffc02035a4:	842a                	mv	s0,a0
ffffffffc02035a6:	2c050163          	beqz	a0,ffffffffc0203868 <do_fork+0x2fc>
    proc->parent = current;
ffffffffc02035aa:	00030c17          	auipc	s8,0x30
ffffffffc02035ae:	736c0c13          	addi	s8,s8,1846 # ffffffffc0233ce0 <current>
ffffffffc02035b2:	000c3783          	ld	a5,0(s8)
    assert(current->wait_state == 0);
ffffffffc02035b6:	0ec7a703          	lw	a4,236(a5) # 10ec <_binary_obj___user_hello_out_size-0x87cc>
    proc->parent = current;
ffffffffc02035ba:	f11c                	sd	a5,32(a0)
    assert(current->wait_state == 0);
ffffffffc02035bc:	2e071963          	bnez	a4,ffffffffc02038ae <do_fork+0x342>
    struct Page *page = alloc_pages(KSTACKPAGE);
ffffffffc02035c0:	4509                	li	a0,2
ffffffffc02035c2:	f90fd0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
    if (page != NULL) {
ffffffffc02035c6:	28050e63          	beqz	a0,ffffffffc0203862 <do_fork+0x2f6>
    return page - pages + nbase;
ffffffffc02035ca:	00030a97          	auipc	s5,0x30
ffffffffc02035ce:	766a8a93          	addi	s5,s5,1894 # ffffffffc0233d30 <pages>
ffffffffc02035d2:	000ab683          	ld	a3,0(s5)
ffffffffc02035d6:	00003b17          	auipc	s6,0x3
ffffffffc02035da:	4d2b0b13          	addi	s6,s6,1234 # ffffffffc0206aa8 <nbase>
ffffffffc02035de:	000b3783          	ld	a5,0(s6)
ffffffffc02035e2:	40d506b3          	sub	a3,a0,a3
ffffffffc02035e6:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc02035e8:	00030b97          	auipc	s7,0x30
ffffffffc02035ec:	6d0b8b93          	addi	s7,s7,1744 # ffffffffc0233cb8 <npage>
    return page - pages + nbase;
ffffffffc02035f0:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc02035f2:	000bb703          	ld	a4,0(s7)
ffffffffc02035f6:	00c69793          	slli	a5,a3,0xc
ffffffffc02035fa:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc02035fc:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02035fe:	28e7fc63          	bgeu	a5,a4,ffffffffc0203896 <do_fork+0x32a>
    struct mm_struct *mm, *oldmm = current->mm;
ffffffffc0203602:	000c3703          	ld	a4,0(s8)
ffffffffc0203606:	00030c97          	auipc	s9,0x30
ffffffffc020360a:	71ac8c93          	addi	s9,s9,1818 # ffffffffc0233d20 <va_pa_offset>
ffffffffc020360e:	000cb783          	ld	a5,0(s9)
ffffffffc0203612:	02873c03          	ld	s8,40(a4)
ffffffffc0203616:	96be                	add	a3,a3,a5
        proc->kstack = (uintptr_t)page2kva(page);
ffffffffc0203618:	e814                	sd	a3,16(s0)
    if (oldmm == NULL) {
ffffffffc020361a:	020c0863          	beqz	s8,ffffffffc020364a <do_fork+0xde>
    if (clone_flags & CLONE_VM) {
ffffffffc020361e:	1009f993          	andi	s3,s3,256
ffffffffc0203622:	1a098e63          	beqz	s3,ffffffffc02037de <do_fork+0x272>
}

static inline int
mm_count_inc(struct mm_struct *mm) {
    mm->mm_count += 1;
ffffffffc0203626:	030c2703          	lw	a4,48(s8)
    proc->cr3 = PADDR(mm->pgdir);
ffffffffc020362a:	018c3783          	ld	a5,24(s8)
ffffffffc020362e:	c02006b7          	lui	a3,0xc0200
ffffffffc0203632:	2705                	addiw	a4,a4,1
ffffffffc0203634:	02ec2823          	sw	a4,48(s8)
    proc->mm = mm;
ffffffffc0203638:	03843423          	sd	s8,40(s0)
    proc->cr3 = PADDR(mm->pgdir);
ffffffffc020363c:	28d7e963          	bltu	a5,a3,ffffffffc02038ce <do_fork+0x362>
ffffffffc0203640:	000cb703          	ld	a4,0(s9)
ffffffffc0203644:	6814                	ld	a3,16(s0)
ffffffffc0203646:	8f99                	sub	a5,a5,a4
ffffffffc0203648:	f45c                	sd	a5,168(s0)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc020364a:	6789                	lui	a5,0x2
ffffffffc020364c:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_obj___user_hello_out_size-0x79d8>
ffffffffc0203650:	97b6                	add	a5,a5,a3
ffffffffc0203652:	f05c                	sd	a5,160(s0)
    *(proc->tf) = *tf;
ffffffffc0203654:	873e                	mv	a4,a5
ffffffffc0203656:	12048893          	addi	a7,s1,288
ffffffffc020365a:	0004b803          	ld	a6,0(s1)
ffffffffc020365e:	6488                	ld	a0,8(s1)
ffffffffc0203660:	688c                	ld	a1,16(s1)
ffffffffc0203662:	6c90                	ld	a2,24(s1)
ffffffffc0203664:	01073023          	sd	a6,0(a4)
ffffffffc0203668:	e708                	sd	a0,8(a4)
ffffffffc020366a:	eb0c                	sd	a1,16(a4)
ffffffffc020366c:	ef10                	sd	a2,24(a4)
ffffffffc020366e:	02048493          	addi	s1,s1,32
ffffffffc0203672:	02070713          	addi	a4,a4,32
ffffffffc0203676:	ff1492e3          	bne	s1,a7,ffffffffc020365a <do_fork+0xee>
    proc->tf->gpr.a0 = 0;
ffffffffc020367a:	0407b823          	sd	zero,80(a5)
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf - 4 : esp;
ffffffffc020367e:	12090a63          	beqz	s2,ffffffffc02037b2 <do_fork+0x246>
ffffffffc0203682:	0127b823          	sd	s2,16(a5)
    proc->context.ra = (uintptr_t)forkret;
ffffffffc0203686:	00000717          	auipc	a4,0x0
ffffffffc020368a:	c7470713          	addi	a4,a4,-908 # ffffffffc02032fa <forkret>
ffffffffc020368e:	f818                	sd	a4,48(s0)
    proc->context.sp = (uintptr_t)(proc->tf);
ffffffffc0203690:	fc1c                	sd	a5,56(s0)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203692:	100027f3          	csrr	a5,sstatus
ffffffffc0203696:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0203698:	4901                	li	s2,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020369a:	12079e63          	bnez	a5,ffffffffc02037d6 <do_fork+0x26a>
    if (++ last_pid >= MAX_PID) {
ffffffffc020369e:	00025597          	auipc	a1,0x25
ffffffffc02036a2:	1d258593          	addi	a1,a1,466 # ffffffffc0228870 <last_pid.1747>
ffffffffc02036a6:	419c                	lw	a5,0(a1)
ffffffffc02036a8:	6709                	lui	a4,0x2
ffffffffc02036aa:	0017851b          	addiw	a0,a5,1
ffffffffc02036ae:	c188                	sw	a0,0(a1)
ffffffffc02036b0:	08e55b63          	bge	a0,a4,ffffffffc0203746 <do_fork+0x1da>
    if (last_pid >= next_safe) {
ffffffffc02036b4:	00025897          	auipc	a7,0x25
ffffffffc02036b8:	1c088893          	addi	a7,a7,448 # ffffffffc0228874 <next_safe.1746>
ffffffffc02036bc:	0008a783          	lw	a5,0(a7)
ffffffffc02036c0:	00030497          	auipc	s1,0x30
ffffffffc02036c4:	77048493          	addi	s1,s1,1904 # ffffffffc0233e30 <proc_list>
ffffffffc02036c8:	08f55663          	bge	a0,a5,ffffffffc0203754 <do_fork+0x1e8>
        proc->pid = get_pid();
ffffffffc02036cc:	c048                	sw	a0,4(s0)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc02036ce:	45a9                	li	a1,10
ffffffffc02036d0:	2501                	sext.w	a0,a0
ffffffffc02036d2:	59a010ef          	jal	ra,ffffffffc0204c6c <hash32>
ffffffffc02036d6:	1502                	slli	a0,a0,0x20
ffffffffc02036d8:	0002c797          	auipc	a5,0x2c
ffffffffc02036dc:	5a078793          	addi	a5,a5,1440 # ffffffffc022fc78 <hash_list>
ffffffffc02036e0:	8171                	srli	a0,a0,0x1c
ffffffffc02036e2:	953e                	add	a0,a0,a5
    __list_add(elm, listelm, listelm->next);
ffffffffc02036e4:	650c                	ld	a1,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL) {
ffffffffc02036e6:	7014                	ld	a3,32(s0)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc02036e8:	0d840793          	addi	a5,s0,216
    prev->next = next->prev = elm;
ffffffffc02036ec:	e19c                	sd	a5,0(a1)
    __list_add(elm, listelm, listelm->next);
ffffffffc02036ee:	6490                	ld	a2,8(s1)
    prev->next = next->prev = elm;
ffffffffc02036f0:	e51c                	sd	a5,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL) {
ffffffffc02036f2:	7af8                	ld	a4,240(a3)
    list_add(&proc_list, &(proc->list_link));
ffffffffc02036f4:	0c840793          	addi	a5,s0,200
    elm->next = next;
ffffffffc02036f8:	f06c                	sd	a1,224(s0)
    elm->prev = prev;
ffffffffc02036fa:	ec68                	sd	a0,216(s0)
    prev->next = next->prev = elm;
ffffffffc02036fc:	e21c                	sd	a5,0(a2)
ffffffffc02036fe:	e49c                	sd	a5,8(s1)
    elm->next = next;
ffffffffc0203700:	e870                	sd	a2,208(s0)
    elm->prev = prev;
ffffffffc0203702:	e464                	sd	s1,200(s0)
    proc->yptr = NULL;
ffffffffc0203704:	0e043c23          	sd	zero,248(s0)
    if ((proc->optr = proc->parent->cptr) != NULL) {
ffffffffc0203708:	10e43023          	sd	a4,256(s0)
ffffffffc020370c:	c311                	beqz	a4,ffffffffc0203710 <do_fork+0x1a4>
        proc->optr->yptr = proc;
ffffffffc020370e:	ff60                	sd	s0,248(a4)
    nr_process ++;
ffffffffc0203710:	000a2783          	lw	a5,0(s4)
    proc->parent->cptr = proc;
ffffffffc0203714:	fae0                	sd	s0,240(a3)
    nr_process ++;
ffffffffc0203716:	2785                	addiw	a5,a5,1
ffffffffc0203718:	00fa2023          	sw	a5,0(s4)
    if (flag) {
ffffffffc020371c:	14091863          	bnez	s2,ffffffffc020386c <do_fork+0x300>
    wakeup_proc(proc);
ffffffffc0203720:	8522                	mv	a0,s0
ffffffffc0203722:	5ad000ef          	jal	ra,ffffffffc02044ce <wakeup_proc>
    ret = proc->pid;
ffffffffc0203726:	4048                	lw	a0,4(s0)
}
ffffffffc0203728:	70a6                	ld	ra,104(sp)
ffffffffc020372a:	7406                	ld	s0,96(sp)
ffffffffc020372c:	64e6                	ld	s1,88(sp)
ffffffffc020372e:	6946                	ld	s2,80(sp)
ffffffffc0203730:	69a6                	ld	s3,72(sp)
ffffffffc0203732:	6a06                	ld	s4,64(sp)
ffffffffc0203734:	7ae2                	ld	s5,56(sp)
ffffffffc0203736:	7b42                	ld	s6,48(sp)
ffffffffc0203738:	7ba2                	ld	s7,40(sp)
ffffffffc020373a:	7c02                	ld	s8,32(sp)
ffffffffc020373c:	6ce2                	ld	s9,24(sp)
ffffffffc020373e:	6d42                	ld	s10,16(sp)
ffffffffc0203740:	6da2                	ld	s11,8(sp)
ffffffffc0203742:	6165                	addi	sp,sp,112
ffffffffc0203744:	8082                	ret
        last_pid = 1;
ffffffffc0203746:	4785                	li	a5,1
ffffffffc0203748:	c19c                	sw	a5,0(a1)
        goto inside;
ffffffffc020374a:	4505                	li	a0,1
ffffffffc020374c:	00025897          	auipc	a7,0x25
ffffffffc0203750:	12888893          	addi	a7,a7,296 # ffffffffc0228874 <next_safe.1746>
    return listelm->next;
ffffffffc0203754:	00030497          	auipc	s1,0x30
ffffffffc0203758:	6dc48493          	addi	s1,s1,1756 # ffffffffc0233e30 <proc_list>
ffffffffc020375c:	0084b303          	ld	t1,8(s1)
        next_safe = MAX_PID;
ffffffffc0203760:	6789                	lui	a5,0x2
ffffffffc0203762:	00f8a023          	sw	a5,0(a7)
ffffffffc0203766:	4801                	li	a6,0
ffffffffc0203768:	87aa                	mv	a5,a0
        while ((le = list_next(le)) != list) {
ffffffffc020376a:	6e89                	lui	t4,0x2
ffffffffc020376c:	10930c63          	beq	t1,s1,ffffffffc0203884 <do_fork+0x318>
ffffffffc0203770:	8e42                	mv	t3,a6
ffffffffc0203772:	869a                	mv	a3,t1
ffffffffc0203774:	6609                	lui	a2,0x2
ffffffffc0203776:	a811                	j	ffffffffc020378a <do_fork+0x21e>
            else if (proc->pid > last_pid && next_safe > proc->pid) {
ffffffffc0203778:	00e7d663          	bge	a5,a4,ffffffffc0203784 <do_fork+0x218>
ffffffffc020377c:	00c75463          	bge	a4,a2,ffffffffc0203784 <do_fork+0x218>
ffffffffc0203780:	863a                	mv	a2,a4
ffffffffc0203782:	4e05                	li	t3,1
ffffffffc0203784:	6694                	ld	a3,8(a3)
        while ((le = list_next(le)) != list) {
ffffffffc0203786:	00968d63          	beq	a3,s1,ffffffffc02037a0 <do_fork+0x234>
            if (proc->pid == last_pid) {
ffffffffc020378a:	f3c6a703          	lw	a4,-196(a3) # ffffffffc01fff3c <_binary_obj___user_rr_out_size+0xffffffffc01f552c>
ffffffffc020378e:	fee795e3          	bne	a5,a4,ffffffffc0203778 <do_fork+0x20c>
                if (++ last_pid >= next_safe) {
ffffffffc0203792:	2785                	addiw	a5,a5,1
ffffffffc0203794:	0cc7df63          	bge	a5,a2,ffffffffc0203872 <do_fork+0x306>
ffffffffc0203798:	6694                	ld	a3,8(a3)
ffffffffc020379a:	4805                	li	a6,1
        while ((le = list_next(le)) != list) {
ffffffffc020379c:	fe9697e3          	bne	a3,s1,ffffffffc020378a <do_fork+0x21e>
ffffffffc02037a0:	00080463          	beqz	a6,ffffffffc02037a8 <do_fork+0x23c>
ffffffffc02037a4:	c19c                	sw	a5,0(a1)
ffffffffc02037a6:	853e                	mv	a0,a5
ffffffffc02037a8:	f20e02e3          	beqz	t3,ffffffffc02036cc <do_fork+0x160>
ffffffffc02037ac:	00c8a023          	sw	a2,0(a7)
ffffffffc02037b0:	bf31                	j	ffffffffc02036cc <do_fork+0x160>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf - 4 : esp;
ffffffffc02037b2:	6909                	lui	s2,0x2
ffffffffc02037b4:	edc90913          	addi	s2,s2,-292 # 1edc <_binary_obj___user_hello_out_size-0x79dc>
ffffffffc02037b8:	9936                	add	s2,s2,a3
ffffffffc02037ba:	0127b823          	sd	s2,16(a5) # 2010 <_binary_obj___user_hello_out_size-0x78a8>
    proc->context.ra = (uintptr_t)forkret;
ffffffffc02037be:	00000717          	auipc	a4,0x0
ffffffffc02037c2:	b3c70713          	addi	a4,a4,-1220 # ffffffffc02032fa <forkret>
ffffffffc02037c6:	f818                	sd	a4,48(s0)
    proc->context.sp = (uintptr_t)(proc->tf);
ffffffffc02037c8:	fc1c                	sd	a5,56(s0)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02037ca:	100027f3          	csrr	a5,sstatus
ffffffffc02037ce:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02037d0:	4901                	li	s2,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02037d2:	ec0786e3          	beqz	a5,ffffffffc020369e <do_fork+0x132>
        intr_disable();
ffffffffc02037d6:	e5dfc0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc02037da:	4905                	li	s2,1
ffffffffc02037dc:	b5c9                	j	ffffffffc020369e <do_fork+0x132>
    if ((mm = mm_create()) == NULL) {
ffffffffc02037de:	f65fd0ef          	jal	ra,ffffffffc0201742 <mm_create>
ffffffffc02037e2:	89aa                	mv	s3,a0
ffffffffc02037e4:	c539                	beqz	a0,ffffffffc0203832 <do_fork+0x2c6>
    if (setup_pgdir(mm) != 0) {
ffffffffc02037e6:	c17ff0ef          	jal	ra,ffffffffc02033fc <setup_pgdir>
ffffffffc02037ea:	e949                	bnez	a0,ffffffffc020387c <do_fork+0x310>
}

static inline void
lock_mm(struct mm_struct *mm) {
    if (mm != NULL) {
        lock(&(mm->mm_lock));
ffffffffc02037ec:	038c0d93          	addi	s11,s8,56
 * test_and_set_bit - Atomically set a bit and return its old value
 * @nr:     the bit to set
 * @addr:   the address to count from
 * */
static inline bool test_and_set_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02037f0:	4785                	li	a5,1
ffffffffc02037f2:	40fdb7af          	amoor.d	a5,a5,(s11)
    return !test_and_set_bit(0, lock);
}

static inline void
lock(lock_t *lock) {
    while (!try_lock(lock)) {
ffffffffc02037f6:	8b85                	andi	a5,a5,1
ffffffffc02037f8:	4d05                	li	s10,1
ffffffffc02037fa:	c799                	beqz	a5,ffffffffc0203808 <do_fork+0x29c>
        schedule();
ffffffffc02037fc:	585000ef          	jal	ra,ffffffffc0204580 <schedule>
ffffffffc0203800:	41adb7af          	amoor.d	a5,s10,(s11)
    while (!try_lock(lock)) {
ffffffffc0203804:	8b85                	andi	a5,a5,1
ffffffffc0203806:	fbfd                	bnez	a5,ffffffffc02037fc <do_fork+0x290>
        ret = dup_mmap(mm, oldmm);
ffffffffc0203808:	85e2                	mv	a1,s8
ffffffffc020380a:	854e                	mv	a0,s3
ffffffffc020380c:	990fe0ef          	jal	ra,ffffffffc020199c <dup_mmap>
 * test_and_clear_bit - Atomically clear a bit and return its old value
 * @nr:     the bit to clear
 * @addr:   the address to count from
 * */
static inline bool test_and_clear_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0203810:	57f9                	li	a5,-2
ffffffffc0203812:	60fdb7af          	amoand.d	a5,a5,(s11)
ffffffffc0203816:	8b85                	andi	a5,a5,1
    }
}

static inline void
unlock(lock_t *lock) {
    if (!test_and_clear_bit(0, lock)) {
ffffffffc0203818:	cbe1                	beqz	a5,ffffffffc02038e8 <do_fork+0x37c>
good_mm:
ffffffffc020381a:	8c4e                	mv	s8,s3
    if (ret != 0) {
ffffffffc020381c:	e00505e3          	beqz	a0,ffffffffc0203626 <do_fork+0xba>
    exit_mmap(mm);
ffffffffc0203820:	854e                	mv	a0,s3
ffffffffc0203822:	a14fe0ef          	jal	ra,ffffffffc0201a36 <exit_mmap>
    put_pgdir(mm);
ffffffffc0203826:	854e                	mv	a0,s3
ffffffffc0203828:	b5fff0ef          	jal	ra,ffffffffc0203386 <put_pgdir>
    mm_destroy(mm);
ffffffffc020382c:	854e                	mv	a0,s3
ffffffffc020382e:	86cfe0ef          	jal	ra,ffffffffc020189a <mm_destroy>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc0203832:	6814                	ld	a3,16(s0)
    return pa2page(PADDR(kva));
ffffffffc0203834:	c02007b7          	lui	a5,0xc0200
ffffffffc0203838:	0ef6e063          	bltu	a3,a5,ffffffffc0203918 <do_fork+0x3ac>
ffffffffc020383c:	000cb783          	ld	a5,0(s9)
    if (PPN(pa) >= npage) {
ffffffffc0203840:	000bb703          	ld	a4,0(s7)
    return pa2page(PADDR(kva));
ffffffffc0203844:	40f687b3          	sub	a5,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc0203848:	83b1                	srli	a5,a5,0xc
ffffffffc020384a:	0ae7fb63          	bgeu	a5,a4,ffffffffc0203900 <do_fork+0x394>
    return &pages[PPN(pa) - nbase];
ffffffffc020384e:	000b3703          	ld	a4,0(s6)
ffffffffc0203852:	000ab503          	ld	a0,0(s5)
ffffffffc0203856:	4589                	li	a1,2
ffffffffc0203858:	8f99                	sub	a5,a5,a4
ffffffffc020385a:	079a                	slli	a5,a5,0x6
ffffffffc020385c:	953e                	add	a0,a0,a5
ffffffffc020385e:	d86fd0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    kfree(proc);
ffffffffc0203862:	8522                	mv	a0,s0
ffffffffc0203864:	8c3fe0ef          	jal	ra,ffffffffc0202126 <kfree>
    ret = -E_NO_MEM;
ffffffffc0203868:	5571                	li	a0,-4
    return ret;
ffffffffc020386a:	bd7d                	j	ffffffffc0203728 <do_fork+0x1bc>
        intr_enable();
ffffffffc020386c:	dc1fc0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc0203870:	bd45                	j	ffffffffc0203720 <do_fork+0x1b4>
                    if (last_pid >= MAX_PID) {
ffffffffc0203872:	01d7c363          	blt	a5,t4,ffffffffc0203878 <do_fork+0x30c>
                        last_pid = 1;
ffffffffc0203876:	4785                	li	a5,1
                    goto repeat;
ffffffffc0203878:	4805                	li	a6,1
ffffffffc020387a:	bdcd                	j	ffffffffc020376c <do_fork+0x200>
    mm_destroy(mm);
ffffffffc020387c:	854e                	mv	a0,s3
ffffffffc020387e:	81cfe0ef          	jal	ra,ffffffffc020189a <mm_destroy>
ffffffffc0203882:	bf45                	j	ffffffffc0203832 <do_fork+0x2c6>
ffffffffc0203884:	00080763          	beqz	a6,ffffffffc0203892 <do_fork+0x326>
ffffffffc0203888:	c19c                	sw	a5,0(a1)
ffffffffc020388a:	853e                	mv	a0,a5
ffffffffc020388c:	b581                	j	ffffffffc02036cc <do_fork+0x160>
    int ret = -E_NO_FREE_PROC;
ffffffffc020388e:	556d                	li	a0,-5
ffffffffc0203890:	bd61                	j	ffffffffc0203728 <do_fork+0x1bc>
ffffffffc0203892:	4188                	lw	a0,0(a1)
ffffffffc0203894:	bd25                	j	ffffffffc02036cc <do_fork+0x160>
    return KADDR(page2pa(page));
ffffffffc0203896:	00002617          	auipc	a2,0x2
ffffffffc020389a:	e4a60613          	addi	a2,a2,-438 # ffffffffc02056e0 <commands+0x7b8>
ffffffffc020389e:	06900593          	li	a1,105
ffffffffc02038a2:	00002517          	auipc	a0,0x2
ffffffffc02038a6:	d9e50513          	addi	a0,a0,-610 # ffffffffc0205640 <commands+0x718>
ffffffffc02038aa:	95bfc0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(current->wait_state == 0);
ffffffffc02038ae:	00003697          	auipc	a3,0x3
ffffffffc02038b2:	8ca68693          	addi	a3,a3,-1846 # ffffffffc0206178 <default_pmm_manager+0x108>
ffffffffc02038b6:	00002617          	auipc	a2,0x2
ffffffffc02038ba:	a7a60613          	addi	a2,a2,-1414 # ffffffffc0205330 <commands+0x408>
ffffffffc02038be:	17400593          	li	a1,372
ffffffffc02038c2:	00003517          	auipc	a0,0x3
ffffffffc02038c6:	89e50513          	addi	a0,a0,-1890 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc02038ca:	93bfc0ef          	jal	ra,ffffffffc0200204 <__panic>
    proc->cr3 = PADDR(mm->pgdir);
ffffffffc02038ce:	86be                	mv	a3,a5
ffffffffc02038d0:	00002617          	auipc	a2,0x2
ffffffffc02038d4:	dd860613          	addi	a2,a2,-552 # ffffffffc02056a8 <commands+0x780>
ffffffffc02038d8:	14700593          	li	a1,327
ffffffffc02038dc:	00003517          	auipc	a0,0x3
ffffffffc02038e0:	88450513          	addi	a0,a0,-1916 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc02038e4:	921fc0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("Unlock failed.\n");
ffffffffc02038e8:	00003617          	auipc	a2,0x3
ffffffffc02038ec:	8b060613          	addi	a2,a2,-1872 # ffffffffc0206198 <default_pmm_manager+0x128>
ffffffffc02038f0:	03200593          	li	a1,50
ffffffffc02038f4:	00003517          	auipc	a0,0x3
ffffffffc02038f8:	8b450513          	addi	a0,a0,-1868 # ffffffffc02061a8 <default_pmm_manager+0x138>
ffffffffc02038fc:	909fc0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0203900:	00002617          	auipc	a2,0x2
ffffffffc0203904:	d2060613          	addi	a2,a2,-736 # ffffffffc0205620 <commands+0x6f8>
ffffffffc0203908:	06200593          	li	a1,98
ffffffffc020390c:	00002517          	auipc	a0,0x2
ffffffffc0203910:	d3450513          	addi	a0,a0,-716 # ffffffffc0205640 <commands+0x718>
ffffffffc0203914:	8f1fc0ef          	jal	ra,ffffffffc0200204 <__panic>
    return pa2page(PADDR(kva));
ffffffffc0203918:	00002617          	auipc	a2,0x2
ffffffffc020391c:	d9060613          	addi	a2,a2,-624 # ffffffffc02056a8 <commands+0x780>
ffffffffc0203920:	06e00593          	li	a1,110
ffffffffc0203924:	00002517          	auipc	a0,0x2
ffffffffc0203928:	d1c50513          	addi	a0,a0,-740 # ffffffffc0205640 <commands+0x718>
ffffffffc020392c:	8d9fc0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0203930 <kernel_thread>:
kernel_thread(int (*fn)(void *), void *arg, uint32_t clone_flags) {
ffffffffc0203930:	7129                	addi	sp,sp,-320
ffffffffc0203932:	fa22                	sd	s0,304(sp)
ffffffffc0203934:	f626                	sd	s1,296(sp)
ffffffffc0203936:	f24a                	sd	s2,288(sp)
ffffffffc0203938:	84ae                	mv	s1,a1
ffffffffc020393a:	892a                	mv	s2,a0
ffffffffc020393c:	8432                	mv	s0,a2
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc020393e:	4581                	li	a1,0
ffffffffc0203940:	12000613          	li	a2,288
ffffffffc0203944:	850a                	mv	a0,sp
kernel_thread(int (*fn)(void *), void *arg, uint32_t clone_flags) {
ffffffffc0203946:	fe06                	sd	ra,312(sp)
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc0203948:	70d000ef          	jal	ra,ffffffffc0204854 <memset>
    tf.gpr.s0 = (uintptr_t)fn;
ffffffffc020394c:	e0ca                	sd	s2,64(sp)
    tf.gpr.s1 = (uintptr_t)arg;
ffffffffc020394e:	e4a6                	sd	s1,72(sp)
    tf.status = (read_csr(sstatus) | SSTATUS_SPP | SSTATUS_SPIE) & ~SSTATUS_SIE;
ffffffffc0203950:	100027f3          	csrr	a5,sstatus
ffffffffc0203954:	edd7f793          	andi	a5,a5,-291
ffffffffc0203958:	1207e793          	ori	a5,a5,288
ffffffffc020395c:	e23e                	sd	a5,256(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc020395e:	860a                	mv	a2,sp
ffffffffc0203960:	10046513          	ori	a0,s0,256
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc0203964:	00000797          	auipc	a5,0x0
ffffffffc0203968:	89e78793          	addi	a5,a5,-1890 # ffffffffc0203202 <kernel_thread_entry>
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc020396c:	4581                	li	a1,0
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc020396e:	e63e                	sd	a5,264(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc0203970:	bfdff0ef          	jal	ra,ffffffffc020356c <do_fork>
}
ffffffffc0203974:	70f2                	ld	ra,312(sp)
ffffffffc0203976:	7452                	ld	s0,304(sp)
ffffffffc0203978:	74b2                	ld	s1,296(sp)
ffffffffc020397a:	7912                	ld	s2,288(sp)
ffffffffc020397c:	6131                	addi	sp,sp,320
ffffffffc020397e:	8082                	ret

ffffffffc0203980 <do_exit>:
do_exit(int error_code) {
ffffffffc0203980:	7179                	addi	sp,sp,-48
ffffffffc0203982:	f022                	sd	s0,32(sp)
    if (current == idleproc) {
ffffffffc0203984:	00030417          	auipc	s0,0x30
ffffffffc0203988:	35c40413          	addi	s0,s0,860 # ffffffffc0233ce0 <current>
ffffffffc020398c:	601c                	ld	a5,0(s0)
do_exit(int error_code) {
ffffffffc020398e:	f406                	sd	ra,40(sp)
ffffffffc0203990:	ec26                	sd	s1,24(sp)
ffffffffc0203992:	e84a                	sd	s2,16(sp)
ffffffffc0203994:	e44e                	sd	s3,8(sp)
ffffffffc0203996:	e052                	sd	s4,0(sp)
    if (current == idleproc) {
ffffffffc0203998:	00030717          	auipc	a4,0x30
ffffffffc020399c:	35073703          	ld	a4,848(a4) # ffffffffc0233ce8 <idleproc>
ffffffffc02039a0:	0ce78c63          	beq	a5,a4,ffffffffc0203a78 <do_exit+0xf8>
    if (current == initproc) {
ffffffffc02039a4:	00030497          	auipc	s1,0x30
ffffffffc02039a8:	34c48493          	addi	s1,s1,844 # ffffffffc0233cf0 <initproc>
ffffffffc02039ac:	6098                	ld	a4,0(s1)
ffffffffc02039ae:	0ee78b63          	beq	a5,a4,ffffffffc0203aa4 <do_exit+0x124>
    struct mm_struct *mm = current->mm;
ffffffffc02039b2:	0287b983          	ld	s3,40(a5)
ffffffffc02039b6:	892a                	mv	s2,a0
    if (mm != NULL) {
ffffffffc02039b8:	02098663          	beqz	s3,ffffffffc02039e4 <do_exit+0x64>
ffffffffc02039bc:	00030797          	auipc	a5,0x30
ffffffffc02039c0:	36c7b783          	ld	a5,876(a5) # ffffffffc0233d28 <boot_cr3>
ffffffffc02039c4:	577d                	li	a4,-1
ffffffffc02039c6:	177e                	slli	a4,a4,0x3f
ffffffffc02039c8:	83b1                	srli	a5,a5,0xc
ffffffffc02039ca:	8fd9                	or	a5,a5,a4
ffffffffc02039cc:	18079073          	csrw	satp,a5
    mm->mm_count -= 1;
ffffffffc02039d0:	0309a783          	lw	a5,48(s3)
ffffffffc02039d4:	fff7871b          	addiw	a4,a5,-1
ffffffffc02039d8:	02e9a823          	sw	a4,48(s3)
        if (mm_count_dec(mm) == 0) {
ffffffffc02039dc:	cb55                	beqz	a4,ffffffffc0203a90 <do_exit+0x110>
        current->mm = NULL;
ffffffffc02039de:	601c                	ld	a5,0(s0)
ffffffffc02039e0:	0207b423          	sd	zero,40(a5)
    current->state = PROC_ZOMBIE;
ffffffffc02039e4:	601c                	ld	a5,0(s0)
ffffffffc02039e6:	470d                	li	a4,3
ffffffffc02039e8:	c398                	sw	a4,0(a5)
    current->exit_code = error_code;
ffffffffc02039ea:	0f27a423          	sw	s2,232(a5)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02039ee:	100027f3          	csrr	a5,sstatus
ffffffffc02039f2:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02039f4:	4a01                	li	s4,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02039f6:	e3f9                	bnez	a5,ffffffffc0203abc <do_exit+0x13c>
        proc = current->parent;
ffffffffc02039f8:	6018                	ld	a4,0(s0)
        if (proc->wait_state == WT_CHILD) {
ffffffffc02039fa:	800007b7          	lui	a5,0x80000
ffffffffc02039fe:	0785                	addi	a5,a5,1
        proc = current->parent;
ffffffffc0203a00:	7308                	ld	a0,32(a4)
        if (proc->wait_state == WT_CHILD) {
ffffffffc0203a02:	0ec52703          	lw	a4,236(a0)
ffffffffc0203a06:	0af70f63          	beq	a4,a5,ffffffffc0203ac4 <do_exit+0x144>
        while (current->cptr != NULL) {
ffffffffc0203a0a:	6018                	ld	a4,0(s0)
ffffffffc0203a0c:	7b7c                	ld	a5,240(a4)
ffffffffc0203a0e:	c3a1                	beqz	a5,ffffffffc0203a4e <do_exit+0xce>
                if (initproc->wait_state == WT_CHILD) {
ffffffffc0203a10:	800009b7          	lui	s3,0x80000
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203a14:	490d                	li	s2,3
                if (initproc->wait_state == WT_CHILD) {
ffffffffc0203a16:	0985                	addi	s3,s3,1
ffffffffc0203a18:	a021                	j	ffffffffc0203a20 <do_exit+0xa0>
        while (current->cptr != NULL) {
ffffffffc0203a1a:	6018                	ld	a4,0(s0)
ffffffffc0203a1c:	7b7c                	ld	a5,240(a4)
ffffffffc0203a1e:	cb85                	beqz	a5,ffffffffc0203a4e <do_exit+0xce>
            current->cptr = proc->optr;
ffffffffc0203a20:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_obj___user_rr_out_size+0xffffffff7fff56f0>
            if ((proc->optr = initproc->cptr) != NULL) {
ffffffffc0203a24:	6088                	ld	a0,0(s1)
            current->cptr = proc->optr;
ffffffffc0203a26:	fb74                	sd	a3,240(a4)
            if ((proc->optr = initproc->cptr) != NULL) {
ffffffffc0203a28:	7978                	ld	a4,240(a0)
            proc->yptr = NULL;
ffffffffc0203a2a:	0e07bc23          	sd	zero,248(a5)
            if ((proc->optr = initproc->cptr) != NULL) {
ffffffffc0203a2e:	10e7b023          	sd	a4,256(a5)
ffffffffc0203a32:	c311                	beqz	a4,ffffffffc0203a36 <do_exit+0xb6>
                initproc->cptr->yptr = proc;
ffffffffc0203a34:	ff7c                	sd	a5,248(a4)
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203a36:	4398                	lw	a4,0(a5)
            proc->parent = initproc;
ffffffffc0203a38:	f388                	sd	a0,32(a5)
            initproc->cptr = proc;
ffffffffc0203a3a:	f97c                	sd	a5,240(a0)
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203a3c:	fd271fe3          	bne	a4,s2,ffffffffc0203a1a <do_exit+0x9a>
                if (initproc->wait_state == WT_CHILD) {
ffffffffc0203a40:	0ec52783          	lw	a5,236(a0)
ffffffffc0203a44:	fd379be3          	bne	a5,s3,ffffffffc0203a1a <do_exit+0x9a>
                    wakeup_proc(initproc);
ffffffffc0203a48:	287000ef          	jal	ra,ffffffffc02044ce <wakeup_proc>
ffffffffc0203a4c:	b7f9                	j	ffffffffc0203a1a <do_exit+0x9a>
    if (flag) {
ffffffffc0203a4e:	020a1263          	bnez	s4,ffffffffc0203a72 <do_exit+0xf2>
    schedule();
ffffffffc0203a52:	32f000ef          	jal	ra,ffffffffc0204580 <schedule>
    panic("do_exit will not return!! %d.\n", current->pid);
ffffffffc0203a56:	601c                	ld	a5,0(s0)
ffffffffc0203a58:	00002617          	auipc	a2,0x2
ffffffffc0203a5c:	78860613          	addi	a2,a2,1928 # ffffffffc02061e0 <default_pmm_manager+0x170>
ffffffffc0203a60:	1c700593          	li	a1,455
ffffffffc0203a64:	43d4                	lw	a3,4(a5)
ffffffffc0203a66:	00002517          	auipc	a0,0x2
ffffffffc0203a6a:	6fa50513          	addi	a0,a0,1786 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc0203a6e:	f96fc0ef          	jal	ra,ffffffffc0200204 <__panic>
        intr_enable();
ffffffffc0203a72:	bbbfc0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc0203a76:	bff1                	j	ffffffffc0203a52 <do_exit+0xd2>
        panic("idleproc exit.\n");
ffffffffc0203a78:	00002617          	auipc	a2,0x2
ffffffffc0203a7c:	74860613          	addi	a2,a2,1864 # ffffffffc02061c0 <default_pmm_manager+0x150>
ffffffffc0203a80:	19b00593          	li	a1,411
ffffffffc0203a84:	00002517          	auipc	a0,0x2
ffffffffc0203a88:	6dc50513          	addi	a0,a0,1756 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc0203a8c:	f78fc0ef          	jal	ra,ffffffffc0200204 <__panic>
            exit_mmap(mm);
ffffffffc0203a90:	854e                	mv	a0,s3
ffffffffc0203a92:	fa5fd0ef          	jal	ra,ffffffffc0201a36 <exit_mmap>
            put_pgdir(mm);
ffffffffc0203a96:	854e                	mv	a0,s3
ffffffffc0203a98:	8efff0ef          	jal	ra,ffffffffc0203386 <put_pgdir>
            mm_destroy(mm);
ffffffffc0203a9c:	854e                	mv	a0,s3
ffffffffc0203a9e:	dfdfd0ef          	jal	ra,ffffffffc020189a <mm_destroy>
ffffffffc0203aa2:	bf35                	j	ffffffffc02039de <do_exit+0x5e>
        panic("initproc exit.\n");
ffffffffc0203aa4:	00002617          	auipc	a2,0x2
ffffffffc0203aa8:	72c60613          	addi	a2,a2,1836 # ffffffffc02061d0 <default_pmm_manager+0x160>
ffffffffc0203aac:	19e00593          	li	a1,414
ffffffffc0203ab0:	00002517          	auipc	a0,0x2
ffffffffc0203ab4:	6b050513          	addi	a0,a0,1712 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc0203ab8:	f4cfc0ef          	jal	ra,ffffffffc0200204 <__panic>
        intr_disable();
ffffffffc0203abc:	b77fc0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc0203ac0:	4a05                	li	s4,1
ffffffffc0203ac2:	bf1d                	j	ffffffffc02039f8 <do_exit+0x78>
            wakeup_proc(proc);
ffffffffc0203ac4:	20b000ef          	jal	ra,ffffffffc02044ce <wakeup_proc>
ffffffffc0203ac8:	b789                	j	ffffffffc0203a0a <do_exit+0x8a>

ffffffffc0203aca <do_wait.part.0>:
do_wait(int pid, int *code_store) {
ffffffffc0203aca:	7139                	addi	sp,sp,-64
ffffffffc0203acc:	e852                	sd	s4,16(sp)
        current->wait_state = WT_CHILD;
ffffffffc0203ace:	80000a37          	lui	s4,0x80000
do_wait(int pid, int *code_store) {
ffffffffc0203ad2:	f426                	sd	s1,40(sp)
ffffffffc0203ad4:	f04a                	sd	s2,32(sp)
ffffffffc0203ad6:	ec4e                	sd	s3,24(sp)
ffffffffc0203ad8:	e456                	sd	s5,8(sp)
ffffffffc0203ada:	e05a                	sd	s6,0(sp)
ffffffffc0203adc:	fc06                	sd	ra,56(sp)
ffffffffc0203ade:	f822                	sd	s0,48(sp)
ffffffffc0203ae0:	892a                	mv	s2,a0
ffffffffc0203ae2:	8aae                	mv	s5,a1
        proc = current->cptr;
ffffffffc0203ae4:	00030997          	auipc	s3,0x30
ffffffffc0203ae8:	1fc98993          	addi	s3,s3,508 # ffffffffc0233ce0 <current>
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203aec:	448d                	li	s1,3
        current->state = PROC_SLEEPING;
ffffffffc0203aee:	4b05                	li	s6,1
        current->wait_state = WT_CHILD;
ffffffffc0203af0:	2a05                	addiw	s4,s4,1
    if (pid != 0) {
ffffffffc0203af2:	02090f63          	beqz	s2,ffffffffc0203b30 <do_wait.part.0+0x66>
        proc = find_proc(pid);
ffffffffc0203af6:	854a                	mv	a0,s2
ffffffffc0203af8:	a1dff0ef          	jal	ra,ffffffffc0203514 <find_proc>
ffffffffc0203afc:	842a                	mv	s0,a0
        if (proc != NULL && proc->parent == current) {
ffffffffc0203afe:	10050763          	beqz	a0,ffffffffc0203c0c <do_wait.part.0+0x142>
ffffffffc0203b02:	0009b703          	ld	a4,0(s3)
ffffffffc0203b06:	711c                	ld	a5,32(a0)
ffffffffc0203b08:	10e79263          	bne	a5,a4,ffffffffc0203c0c <do_wait.part.0+0x142>
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203b0c:	411c                	lw	a5,0(a0)
ffffffffc0203b0e:	02978c63          	beq	a5,s1,ffffffffc0203b46 <do_wait.part.0+0x7c>
        current->state = PROC_SLEEPING;
ffffffffc0203b12:	01672023          	sw	s6,0(a4)
        current->wait_state = WT_CHILD;
ffffffffc0203b16:	0f472623          	sw	s4,236(a4)
        schedule();
ffffffffc0203b1a:	267000ef          	jal	ra,ffffffffc0204580 <schedule>
        if (current->flags & PF_EXITING) {
ffffffffc0203b1e:	0009b783          	ld	a5,0(s3)
ffffffffc0203b22:	0b07a783          	lw	a5,176(a5)
ffffffffc0203b26:	8b85                	andi	a5,a5,1
ffffffffc0203b28:	d7e9                	beqz	a5,ffffffffc0203af2 <do_wait.part.0+0x28>
            do_exit(-E_KILLED);
ffffffffc0203b2a:	555d                	li	a0,-9
ffffffffc0203b2c:	e55ff0ef          	jal	ra,ffffffffc0203980 <do_exit>
        proc = current->cptr;
ffffffffc0203b30:	0009b703          	ld	a4,0(s3)
ffffffffc0203b34:	7b60                	ld	s0,240(a4)
        for (; proc != NULL; proc = proc->optr) {
ffffffffc0203b36:	e409                	bnez	s0,ffffffffc0203b40 <do_wait.part.0+0x76>
ffffffffc0203b38:	a8d1                	j	ffffffffc0203c0c <do_wait.part.0+0x142>
ffffffffc0203b3a:	10043403          	ld	s0,256(s0)
ffffffffc0203b3e:	d871                	beqz	s0,ffffffffc0203b12 <do_wait.part.0+0x48>
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203b40:	401c                	lw	a5,0(s0)
ffffffffc0203b42:	fe979ce3          	bne	a5,s1,ffffffffc0203b3a <do_wait.part.0+0x70>
    if (proc == idleproc || proc == initproc) {
ffffffffc0203b46:	00030797          	auipc	a5,0x30
ffffffffc0203b4a:	1a27b783          	ld	a5,418(a5) # ffffffffc0233ce8 <idleproc>
ffffffffc0203b4e:	0c878563          	beq	a5,s0,ffffffffc0203c18 <do_wait.part.0+0x14e>
ffffffffc0203b52:	00030797          	auipc	a5,0x30
ffffffffc0203b56:	19e7b783          	ld	a5,414(a5) # ffffffffc0233cf0 <initproc>
ffffffffc0203b5a:	0af40f63          	beq	s0,a5,ffffffffc0203c18 <do_wait.part.0+0x14e>
    if (code_store != NULL) {
ffffffffc0203b5e:	000a8663          	beqz	s5,ffffffffc0203b6a <do_wait.part.0+0xa0>
        *code_store = proc->exit_code;
ffffffffc0203b62:	0e842783          	lw	a5,232(s0)
ffffffffc0203b66:	00faa023          	sw	a5,0(s5)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203b6a:	100027f3          	csrr	a5,sstatus
ffffffffc0203b6e:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0203b70:	4581                	li	a1,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203b72:	efd9                	bnez	a5,ffffffffc0203c10 <do_wait.part.0+0x146>
    __list_del(listelm->prev, listelm->next);
ffffffffc0203b74:	6c70                	ld	a2,216(s0)
ffffffffc0203b76:	7074                	ld	a3,224(s0)
    if (proc->optr != NULL) {
ffffffffc0203b78:	10043703          	ld	a4,256(s0)
ffffffffc0203b7c:	7c7c                	ld	a5,248(s0)
    prev->next = next;
ffffffffc0203b7e:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0203b80:	e290                	sd	a2,0(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc0203b82:	6470                	ld	a2,200(s0)
ffffffffc0203b84:	6874                	ld	a3,208(s0)
    prev->next = next;
ffffffffc0203b86:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0203b88:	e290                	sd	a2,0(a3)
ffffffffc0203b8a:	c319                	beqz	a4,ffffffffc0203b90 <do_wait.part.0+0xc6>
        proc->optr->yptr = proc->yptr;
ffffffffc0203b8c:	ff7c                	sd	a5,248(a4)
ffffffffc0203b8e:	7c7c                	ld	a5,248(s0)
    if (proc->yptr != NULL) {
ffffffffc0203b90:	cbbd                	beqz	a5,ffffffffc0203c06 <do_wait.part.0+0x13c>
        proc->yptr->optr = proc->optr;
ffffffffc0203b92:	10e7b023          	sd	a4,256(a5)
    nr_process --;
ffffffffc0203b96:	00030717          	auipc	a4,0x30
ffffffffc0203b9a:	16270713          	addi	a4,a4,354 # ffffffffc0233cf8 <nr_process>
ffffffffc0203b9e:	431c                	lw	a5,0(a4)
ffffffffc0203ba0:	37fd                	addiw	a5,a5,-1
ffffffffc0203ba2:	c31c                	sw	a5,0(a4)
    if (flag) {
ffffffffc0203ba4:	edb1                	bnez	a1,ffffffffc0203c00 <do_wait.part.0+0x136>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc0203ba6:	6814                	ld	a3,16(s0)
ffffffffc0203ba8:	c02007b7          	lui	a5,0xc0200
ffffffffc0203bac:	08f6ee63          	bltu	a3,a5,ffffffffc0203c48 <do_wait.part.0+0x17e>
ffffffffc0203bb0:	00030797          	auipc	a5,0x30
ffffffffc0203bb4:	1707b783          	ld	a5,368(a5) # ffffffffc0233d20 <va_pa_offset>
ffffffffc0203bb8:	8e9d                	sub	a3,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc0203bba:	82b1                	srli	a3,a3,0xc
ffffffffc0203bbc:	00030797          	auipc	a5,0x30
ffffffffc0203bc0:	0fc7b783          	ld	a5,252(a5) # ffffffffc0233cb8 <npage>
ffffffffc0203bc4:	06f6f663          	bgeu	a3,a5,ffffffffc0203c30 <do_wait.part.0+0x166>
    return &pages[PPN(pa) - nbase];
ffffffffc0203bc8:	00003517          	auipc	a0,0x3
ffffffffc0203bcc:	ee053503          	ld	a0,-288(a0) # ffffffffc0206aa8 <nbase>
ffffffffc0203bd0:	8e89                	sub	a3,a3,a0
ffffffffc0203bd2:	069a                	slli	a3,a3,0x6
ffffffffc0203bd4:	00030517          	auipc	a0,0x30
ffffffffc0203bd8:	15c53503          	ld	a0,348(a0) # ffffffffc0233d30 <pages>
ffffffffc0203bdc:	9536                	add	a0,a0,a3
ffffffffc0203bde:	4589                	li	a1,2
ffffffffc0203be0:	a04fd0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    kfree(proc);
ffffffffc0203be4:	8522                	mv	a0,s0
ffffffffc0203be6:	d40fe0ef          	jal	ra,ffffffffc0202126 <kfree>
    return 0;
ffffffffc0203bea:	4501                	li	a0,0
}
ffffffffc0203bec:	70e2                	ld	ra,56(sp)
ffffffffc0203bee:	7442                	ld	s0,48(sp)
ffffffffc0203bf0:	74a2                	ld	s1,40(sp)
ffffffffc0203bf2:	7902                	ld	s2,32(sp)
ffffffffc0203bf4:	69e2                	ld	s3,24(sp)
ffffffffc0203bf6:	6a42                	ld	s4,16(sp)
ffffffffc0203bf8:	6aa2                	ld	s5,8(sp)
ffffffffc0203bfa:	6b02                	ld	s6,0(sp)
ffffffffc0203bfc:	6121                	addi	sp,sp,64
ffffffffc0203bfe:	8082                	ret
        intr_enable();
ffffffffc0203c00:	a2dfc0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc0203c04:	b74d                	j	ffffffffc0203ba6 <do_wait.part.0+0xdc>
       proc->parent->cptr = proc->optr;
ffffffffc0203c06:	701c                	ld	a5,32(s0)
ffffffffc0203c08:	fbf8                	sd	a4,240(a5)
ffffffffc0203c0a:	b771                	j	ffffffffc0203b96 <do_wait.part.0+0xcc>
    return -E_BAD_PROC;
ffffffffc0203c0c:	5579                	li	a0,-2
ffffffffc0203c0e:	bff9                	j	ffffffffc0203bec <do_wait.part.0+0x122>
        intr_disable();
ffffffffc0203c10:	a23fc0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc0203c14:	4585                	li	a1,1
ffffffffc0203c16:	bfb9                	j	ffffffffc0203b74 <do_wait.part.0+0xaa>
        panic("wait idleproc or initproc.\n");
ffffffffc0203c18:	00002617          	auipc	a2,0x2
ffffffffc0203c1c:	5e860613          	addi	a2,a2,1512 # ffffffffc0206200 <default_pmm_manager+0x190>
ffffffffc0203c20:	2b600593          	li	a1,694
ffffffffc0203c24:	00002517          	auipc	a0,0x2
ffffffffc0203c28:	53c50513          	addi	a0,a0,1340 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc0203c2c:	dd8fc0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0203c30:	00002617          	auipc	a2,0x2
ffffffffc0203c34:	9f060613          	addi	a2,a2,-1552 # ffffffffc0205620 <commands+0x6f8>
ffffffffc0203c38:	06200593          	li	a1,98
ffffffffc0203c3c:	00002517          	auipc	a0,0x2
ffffffffc0203c40:	a0450513          	addi	a0,a0,-1532 # ffffffffc0205640 <commands+0x718>
ffffffffc0203c44:	dc0fc0ef          	jal	ra,ffffffffc0200204 <__panic>
    return pa2page(PADDR(kva));
ffffffffc0203c48:	00002617          	auipc	a2,0x2
ffffffffc0203c4c:	a6060613          	addi	a2,a2,-1440 # ffffffffc02056a8 <commands+0x780>
ffffffffc0203c50:	06e00593          	li	a1,110
ffffffffc0203c54:	00002517          	auipc	a0,0x2
ffffffffc0203c58:	9ec50513          	addi	a0,a0,-1556 # ffffffffc0205640 <commands+0x718>
ffffffffc0203c5c:	da8fc0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0203c60 <init_main>:
}

// init_main - the second kernel thread used to create user_main kernel threads
static int
init_main(void *arg) {
ffffffffc0203c60:	1141                	addi	sp,sp,-16
ffffffffc0203c62:	e406                	sd	ra,8(sp)
    size_t nr_free_pages_store = nr_free_pages();
ffffffffc0203c64:	9c2fd0ef          	jal	ra,ffffffffc0200e26 <nr_free_pages>
    size_t kernel_allocated_store = kallocated();
ffffffffc0203c68:	c0afe0ef          	jal	ra,ffffffffc0202072 <kallocated>

    int pid = kernel_thread(user_main, NULL, 0);
ffffffffc0203c6c:	4601                	li	a2,0
ffffffffc0203c6e:	4581                	li	a1,0
ffffffffc0203c70:	fffff517          	auipc	a0,0xfffff
ffffffffc0203c74:	69850513          	addi	a0,a0,1688 # ffffffffc0203308 <user_main>
ffffffffc0203c78:	cb9ff0ef          	jal	ra,ffffffffc0203930 <kernel_thread>
    if (pid <= 0) {
ffffffffc0203c7c:	00a04563          	bgtz	a0,ffffffffc0203c86 <init_main+0x26>
ffffffffc0203c80:	a071                	j	ffffffffc0203d0c <init_main+0xac>
        panic("create user_main failed.\n");
    }

    while (do_wait(0, NULL) == 0) {
        schedule();
ffffffffc0203c82:	0ff000ef          	jal	ra,ffffffffc0204580 <schedule>
    if (code_store != NULL) {
ffffffffc0203c86:	4581                	li	a1,0
ffffffffc0203c88:	4501                	li	a0,0
ffffffffc0203c8a:	e41ff0ef          	jal	ra,ffffffffc0203aca <do_wait.part.0>
    while (do_wait(0, NULL) == 0) {
ffffffffc0203c8e:	d975                	beqz	a0,ffffffffc0203c82 <init_main+0x22>
    }

    cprintf("all user-mode processes have quit.\n");
ffffffffc0203c90:	00002517          	auipc	a0,0x2
ffffffffc0203c94:	5b050513          	addi	a0,a0,1456 # ffffffffc0206240 <default_pmm_manager+0x1d0>
ffffffffc0203c98:	c30fc0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0203c9c:	00030797          	auipc	a5,0x30
ffffffffc0203ca0:	0547b783          	ld	a5,84(a5) # ffffffffc0233cf0 <initproc>
ffffffffc0203ca4:	7bf8                	ld	a4,240(a5)
ffffffffc0203ca6:	e339                	bnez	a4,ffffffffc0203cec <init_main+0x8c>
ffffffffc0203ca8:	7ff8                	ld	a4,248(a5)
ffffffffc0203caa:	e329                	bnez	a4,ffffffffc0203cec <init_main+0x8c>
ffffffffc0203cac:	1007b703          	ld	a4,256(a5)
ffffffffc0203cb0:	ef15                	bnez	a4,ffffffffc0203cec <init_main+0x8c>
    assert(nr_process == 2);
ffffffffc0203cb2:	00030697          	auipc	a3,0x30
ffffffffc0203cb6:	0466a683          	lw	a3,70(a3) # ffffffffc0233cf8 <nr_process>
ffffffffc0203cba:	4709                	li	a4,2
ffffffffc0203cbc:	0ae69463          	bne	a3,a4,ffffffffc0203d64 <init_main+0x104>
    return listelm->next;
ffffffffc0203cc0:	00030697          	auipc	a3,0x30
ffffffffc0203cc4:	17068693          	addi	a3,a3,368 # ffffffffc0233e30 <proc_list>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc0203cc8:	6698                	ld	a4,8(a3)
ffffffffc0203cca:	0c878793          	addi	a5,a5,200
ffffffffc0203cce:	06f71b63          	bne	a4,a5,ffffffffc0203d44 <init_main+0xe4>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc0203cd2:	629c                	ld	a5,0(a3)
ffffffffc0203cd4:	04f71863          	bne	a4,a5,ffffffffc0203d24 <init_main+0xc4>

    //cprintf("init check memory pass.\n");
    cprintf("The end of init_main\n");
ffffffffc0203cd8:	00002517          	auipc	a0,0x2
ffffffffc0203cdc:	65050513          	addi	a0,a0,1616 # ffffffffc0206328 <default_pmm_manager+0x2b8>
ffffffffc0203ce0:	be8fc0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    return 0;
}
ffffffffc0203ce4:	60a2                	ld	ra,8(sp)
ffffffffc0203ce6:	4501                	li	a0,0
ffffffffc0203ce8:	0141                	addi	sp,sp,16
ffffffffc0203cea:	8082                	ret
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0203cec:	00002697          	auipc	a3,0x2
ffffffffc0203cf0:	57c68693          	addi	a3,a3,1404 # ffffffffc0206268 <default_pmm_manager+0x1f8>
ffffffffc0203cf4:	00001617          	auipc	a2,0x1
ffffffffc0203cf8:	63c60613          	addi	a2,a2,1596 # ffffffffc0205330 <commands+0x408>
ffffffffc0203cfc:	31a00593          	li	a1,794
ffffffffc0203d00:	00002517          	auipc	a0,0x2
ffffffffc0203d04:	46050513          	addi	a0,a0,1120 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc0203d08:	cfcfc0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("create user_main failed.\n");
ffffffffc0203d0c:	00002617          	auipc	a2,0x2
ffffffffc0203d10:	51460613          	addi	a2,a2,1300 # ffffffffc0206220 <default_pmm_manager+0x1b0>
ffffffffc0203d14:	31200593          	li	a1,786
ffffffffc0203d18:	00002517          	auipc	a0,0x2
ffffffffc0203d1c:	44850513          	addi	a0,a0,1096 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc0203d20:	ce4fc0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc0203d24:	00002697          	auipc	a3,0x2
ffffffffc0203d28:	5d468693          	addi	a3,a3,1492 # ffffffffc02062f8 <default_pmm_manager+0x288>
ffffffffc0203d2c:	00001617          	auipc	a2,0x1
ffffffffc0203d30:	60460613          	addi	a2,a2,1540 # ffffffffc0205330 <commands+0x408>
ffffffffc0203d34:	31d00593          	li	a1,797
ffffffffc0203d38:	00002517          	auipc	a0,0x2
ffffffffc0203d3c:	42850513          	addi	a0,a0,1064 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc0203d40:	cc4fc0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc0203d44:	00002697          	auipc	a3,0x2
ffffffffc0203d48:	58468693          	addi	a3,a3,1412 # ffffffffc02062c8 <default_pmm_manager+0x258>
ffffffffc0203d4c:	00001617          	auipc	a2,0x1
ffffffffc0203d50:	5e460613          	addi	a2,a2,1508 # ffffffffc0205330 <commands+0x408>
ffffffffc0203d54:	31c00593          	li	a1,796
ffffffffc0203d58:	00002517          	auipc	a0,0x2
ffffffffc0203d5c:	40850513          	addi	a0,a0,1032 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc0203d60:	ca4fc0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(nr_process == 2);
ffffffffc0203d64:	00002697          	auipc	a3,0x2
ffffffffc0203d68:	55468693          	addi	a3,a3,1364 # ffffffffc02062b8 <default_pmm_manager+0x248>
ffffffffc0203d6c:	00001617          	auipc	a2,0x1
ffffffffc0203d70:	5c460613          	addi	a2,a2,1476 # ffffffffc0205330 <commands+0x408>
ffffffffc0203d74:	31b00593          	li	a1,795
ffffffffc0203d78:	00002517          	auipc	a0,0x2
ffffffffc0203d7c:	3e850513          	addi	a0,a0,1000 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc0203d80:	c84fc0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0203d84 <do_execve>:
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203d84:	7135                	addi	sp,sp,-160
ffffffffc0203d86:	f4d6                	sd	s5,104(sp)
    struct mm_struct *mm = current->mm;
ffffffffc0203d88:	00030a97          	auipc	s5,0x30
ffffffffc0203d8c:	f58a8a93          	addi	s5,s5,-168 # ffffffffc0233ce0 <current>
ffffffffc0203d90:	000ab783          	ld	a5,0(s5)
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203d94:	f8d2                	sd	s4,112(sp)
ffffffffc0203d96:	e526                	sd	s1,136(sp)
    struct mm_struct *mm = current->mm;
ffffffffc0203d98:	0287ba03          	ld	s4,40(a5)
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203d9c:	e14a                	sd	s2,128(sp)
ffffffffc0203d9e:	fcce                	sd	s3,120(sp)
ffffffffc0203da0:	892a                	mv	s2,a0
ffffffffc0203da2:	84ae                	mv	s1,a1
ffffffffc0203da4:	89b2                	mv	s3,a2
    if (!user_mem_check(mm, (uintptr_t)name, len, 0)) {
ffffffffc0203da6:	4681                	li	a3,0
ffffffffc0203da8:	862e                	mv	a2,a1
ffffffffc0203daa:	85aa                	mv	a1,a0
ffffffffc0203dac:	8552                	mv	a0,s4
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203dae:	ed06                	sd	ra,152(sp)
ffffffffc0203db0:	e922                	sd	s0,144(sp)
ffffffffc0203db2:	f0da                	sd	s6,96(sp)
ffffffffc0203db4:	ecde                	sd	s7,88(sp)
ffffffffc0203db6:	e8e2                	sd	s8,80(sp)
ffffffffc0203db8:	e4e6                	sd	s9,72(sp)
ffffffffc0203dba:	e0ea                	sd	s10,64(sp)
ffffffffc0203dbc:	fc6e                	sd	s11,56(sp)
    if (!user_mem_check(mm, (uintptr_t)name, len, 0)) {
ffffffffc0203dbe:	df3fd0ef          	jal	ra,ffffffffc0201bb0 <user_mem_check>
ffffffffc0203dc2:	3e050763          	beqz	a0,ffffffffc02041b0 <do_execve+0x42c>
    memset(local_name, 0, sizeof(local_name));
ffffffffc0203dc6:	4641                	li	a2,16
ffffffffc0203dc8:	4581                	li	a1,0
ffffffffc0203dca:	1008                	addi	a0,sp,32
ffffffffc0203dcc:	289000ef          	jal	ra,ffffffffc0204854 <memset>
    memcpy(local_name, name, len);
ffffffffc0203dd0:	47bd                	li	a5,15
ffffffffc0203dd2:	8626                	mv	a2,s1
ffffffffc0203dd4:	0697ed63          	bltu	a5,s1,ffffffffc0203e4e <do_execve+0xca>
ffffffffc0203dd8:	85ca                	mv	a1,s2
ffffffffc0203dda:	1008                	addi	a0,sp,32
ffffffffc0203ddc:	28b000ef          	jal	ra,ffffffffc0204866 <memcpy>
    if (mm != NULL) {
ffffffffc0203de0:	060a0e63          	beqz	s4,ffffffffc0203e5c <do_execve+0xd8>
        cputs("mm != NULL");
ffffffffc0203de4:	00002517          	auipc	a0,0x2
ffffffffc0203de8:	a8450513          	addi	a0,a0,-1404 # ffffffffc0205868 <commands+0x940>
ffffffffc0203dec:	b14fc0ef          	jal	ra,ffffffffc0200100 <cputs>
ffffffffc0203df0:	00030797          	auipc	a5,0x30
ffffffffc0203df4:	f387b783          	ld	a5,-200(a5) # ffffffffc0233d28 <boot_cr3>
ffffffffc0203df8:	577d                	li	a4,-1
ffffffffc0203dfa:	177e                	slli	a4,a4,0x3f
ffffffffc0203dfc:	83b1                	srli	a5,a5,0xc
ffffffffc0203dfe:	8fd9                	or	a5,a5,a4
ffffffffc0203e00:	18079073          	csrw	satp,a5
ffffffffc0203e04:	030a2783          	lw	a5,48(s4) # ffffffff80000030 <_binary_obj___user_rr_out_size+0xffffffff7fff5620>
ffffffffc0203e08:	fff7871b          	addiw	a4,a5,-1
ffffffffc0203e0c:	02ea2823          	sw	a4,48(s4)
        if (mm_count_dec(mm) == 0) {
ffffffffc0203e10:	28070663          	beqz	a4,ffffffffc020409c <do_execve+0x318>
        current->mm = NULL;
ffffffffc0203e14:	000ab783          	ld	a5,0(s5)
ffffffffc0203e18:	0207b423          	sd	zero,40(a5)
    if ((mm = mm_create()) == NULL) {
ffffffffc0203e1c:	927fd0ef          	jal	ra,ffffffffc0201742 <mm_create>
ffffffffc0203e20:	84aa                	mv	s1,a0
ffffffffc0203e22:	c135                	beqz	a0,ffffffffc0203e86 <do_execve+0x102>
    if (setup_pgdir(mm) != 0) {
ffffffffc0203e24:	dd8ff0ef          	jal	ra,ffffffffc02033fc <setup_pgdir>
ffffffffc0203e28:	e931                	bnez	a0,ffffffffc0203e7c <do_execve+0xf8>
    if (elf->e_magic != ELF_MAGIC) {
ffffffffc0203e2a:	0009a703          	lw	a4,0(s3)
ffffffffc0203e2e:	464c47b7          	lui	a5,0x464c4
ffffffffc0203e32:	57f78793          	addi	a5,a5,1407 # 464c457f <_binary_obj___user_rr_out_size+0x464b9b6f>
ffffffffc0203e36:	04f70a63          	beq	a4,a5,ffffffffc0203e8a <do_execve+0x106>
    put_pgdir(mm);
ffffffffc0203e3a:	8526                	mv	a0,s1
ffffffffc0203e3c:	d4aff0ef          	jal	ra,ffffffffc0203386 <put_pgdir>
    mm_destroy(mm);
ffffffffc0203e40:	8526                	mv	a0,s1
ffffffffc0203e42:	a59fd0ef          	jal	ra,ffffffffc020189a <mm_destroy>
        ret = -E_INVAL_ELF;
ffffffffc0203e46:	5a61                	li	s4,-8
    do_exit(ret);
ffffffffc0203e48:	8552                	mv	a0,s4
ffffffffc0203e4a:	b37ff0ef          	jal	ra,ffffffffc0203980 <do_exit>
    memcpy(local_name, name, len);
ffffffffc0203e4e:	463d                	li	a2,15
ffffffffc0203e50:	85ca                	mv	a1,s2
ffffffffc0203e52:	1008                	addi	a0,sp,32
ffffffffc0203e54:	213000ef          	jal	ra,ffffffffc0204866 <memcpy>
    if (mm != NULL) {
ffffffffc0203e58:	f80a16e3          	bnez	s4,ffffffffc0203de4 <do_execve+0x60>
    if (current->mm != NULL) {
ffffffffc0203e5c:	000ab783          	ld	a5,0(s5)
ffffffffc0203e60:	779c                	ld	a5,40(a5)
ffffffffc0203e62:	dfcd                	beqz	a5,ffffffffc0203e1c <do_execve+0x98>
        panic("load_icode: current->mm must be empty.\n");
ffffffffc0203e64:	00002617          	auipc	a2,0x2
ffffffffc0203e68:	4dc60613          	addi	a2,a2,1244 # ffffffffc0206340 <default_pmm_manager+0x2d0>
ffffffffc0203e6c:	1d100593          	li	a1,465
ffffffffc0203e70:	00002517          	auipc	a0,0x2
ffffffffc0203e74:	2f050513          	addi	a0,a0,752 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc0203e78:	b8cfc0ef          	jal	ra,ffffffffc0200204 <__panic>
    mm_destroy(mm);
ffffffffc0203e7c:	8526                	mv	a0,s1
ffffffffc0203e7e:	a1dfd0ef          	jal	ra,ffffffffc020189a <mm_destroy>
    int ret = -E_NO_MEM;
ffffffffc0203e82:	5a71                	li	s4,-4
ffffffffc0203e84:	b7d1                	j	ffffffffc0203e48 <do_execve+0xc4>
ffffffffc0203e86:	5a71                	li	s4,-4
ffffffffc0203e88:	b7c1                	j	ffffffffc0203e48 <do_execve+0xc4>
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0203e8a:	0389d703          	lhu	a4,56(s3)
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc0203e8e:	0209b903          	ld	s2,32(s3)
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0203e92:	00371793          	slli	a5,a4,0x3
ffffffffc0203e96:	8f99                	sub	a5,a5,a4
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc0203e98:	994e                	add	s2,s2,s3
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0203e9a:	078e                	slli	a5,a5,0x3
ffffffffc0203e9c:	97ca                	add	a5,a5,s2
ffffffffc0203e9e:	ec3e                	sd	a5,24(sp)
    for (; ph < ph_end; ph ++) {
ffffffffc0203ea0:	02f97c63          	bgeu	s2,a5,ffffffffc0203ed8 <do_execve+0x154>
    return KADDR(page2pa(page));
ffffffffc0203ea4:	5bfd                	li	s7,-1
ffffffffc0203ea6:	00cbd793          	srli	a5,s7,0xc
    return page - pages + nbase;
ffffffffc0203eaa:	00030d97          	auipc	s11,0x30
ffffffffc0203eae:	e86d8d93          	addi	s11,s11,-378 # ffffffffc0233d30 <pages>
ffffffffc0203eb2:	00003d17          	auipc	s10,0x3
ffffffffc0203eb6:	bf6d0d13          	addi	s10,s10,-1034 # ffffffffc0206aa8 <nbase>
    return KADDR(page2pa(page));
ffffffffc0203eba:	e43e                	sd	a5,8(sp)
ffffffffc0203ebc:	00030c97          	auipc	s9,0x30
ffffffffc0203ec0:	dfcc8c93          	addi	s9,s9,-516 # ffffffffc0233cb8 <npage>
        if (ph->p_type != ELF_PT_LOAD) {
ffffffffc0203ec4:	00092703          	lw	a4,0(s2)
ffffffffc0203ec8:	4785                	li	a5,1
ffffffffc0203eca:	0ef70463          	beq	a4,a5,ffffffffc0203fb2 <do_execve+0x22e>
    for (; ph < ph_end; ph ++) {
ffffffffc0203ece:	67e2                	ld	a5,24(sp)
ffffffffc0203ed0:	03890913          	addi	s2,s2,56
ffffffffc0203ed4:	fef968e3          	bltu	s2,a5,ffffffffc0203ec4 <do_execve+0x140>
    if ((ret = mm_map(mm, USTACKTOP - USTACKSIZE, USTACKSIZE, vm_flags, NULL)) != 0) {
ffffffffc0203ed8:	4701                	li	a4,0
ffffffffc0203eda:	46ad                	li	a3,11
ffffffffc0203edc:	00100637          	lui	a2,0x100
ffffffffc0203ee0:	7ff005b7          	lui	a1,0x7ff00
ffffffffc0203ee4:	8526                	mv	a0,s1
ffffffffc0203ee6:	a07fd0ef          	jal	ra,ffffffffc02018ec <mm_map>
ffffffffc0203eea:	8a2a                	mv	s4,a0
ffffffffc0203eec:	18051e63          	bnez	a0,ffffffffc0204088 <do_execve+0x304>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-PGSIZE , PTE_USER) != NULL);
ffffffffc0203ef0:	6c88                	ld	a0,24(s1)
ffffffffc0203ef2:	467d                	li	a2,31
ffffffffc0203ef4:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc0203ef8:	f98fd0ef          	jal	ra,ffffffffc0201690 <pgdir_alloc_page>
ffffffffc0203efc:	34050863          	beqz	a0,ffffffffc020424c <do_execve+0x4c8>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-2*PGSIZE , PTE_USER) != NULL);
ffffffffc0203f00:	6c88                	ld	a0,24(s1)
ffffffffc0203f02:	467d                	li	a2,31
ffffffffc0203f04:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc0203f08:	f88fd0ef          	jal	ra,ffffffffc0201690 <pgdir_alloc_page>
ffffffffc0203f0c:	32050063          	beqz	a0,ffffffffc020422c <do_execve+0x4a8>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-3*PGSIZE , PTE_USER) != NULL);
ffffffffc0203f10:	6c88                	ld	a0,24(s1)
ffffffffc0203f12:	467d                	li	a2,31
ffffffffc0203f14:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc0203f18:	f78fd0ef          	jal	ra,ffffffffc0201690 <pgdir_alloc_page>
ffffffffc0203f1c:	2e050863          	beqz	a0,ffffffffc020420c <do_execve+0x488>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-4*PGSIZE , PTE_USER) != NULL);
ffffffffc0203f20:	6c88                	ld	a0,24(s1)
ffffffffc0203f22:	467d                	li	a2,31
ffffffffc0203f24:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc0203f28:	f68fd0ef          	jal	ra,ffffffffc0201690 <pgdir_alloc_page>
ffffffffc0203f2c:	2c050063          	beqz	a0,ffffffffc02041ec <do_execve+0x468>
    mm->mm_count += 1;
ffffffffc0203f30:	589c                	lw	a5,48(s1)
    current->mm = mm;
ffffffffc0203f32:	000ab603          	ld	a2,0(s5)
    current->cr3 = PADDR(mm->pgdir);
ffffffffc0203f36:	6c94                	ld	a3,24(s1)
ffffffffc0203f38:	2785                	addiw	a5,a5,1
ffffffffc0203f3a:	d89c                	sw	a5,48(s1)
    current->mm = mm;
ffffffffc0203f3c:	f604                	sd	s1,40(a2)
    current->cr3 = PADDR(mm->pgdir);
ffffffffc0203f3e:	c02007b7          	lui	a5,0xc0200
ffffffffc0203f42:	28f6e963          	bltu	a3,a5,ffffffffc02041d4 <do_execve+0x450>
ffffffffc0203f46:	00030797          	auipc	a5,0x30
ffffffffc0203f4a:	dda7b783          	ld	a5,-550(a5) # ffffffffc0233d20 <va_pa_offset>
ffffffffc0203f4e:	8e9d                	sub	a3,a3,a5
ffffffffc0203f50:	577d                	li	a4,-1
ffffffffc0203f52:	00c6d793          	srli	a5,a3,0xc
ffffffffc0203f56:	177e                	slli	a4,a4,0x3f
ffffffffc0203f58:	f654                	sd	a3,168(a2)
ffffffffc0203f5a:	8fd9                	or	a5,a5,a4
ffffffffc0203f5c:	18079073          	csrw	satp,a5
    struct trapframe *tf = current->tf;
ffffffffc0203f60:	7240                	ld	s0,160(a2)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc0203f62:	4581                	li	a1,0
ffffffffc0203f64:	12000613          	li	a2,288
ffffffffc0203f68:	8522                	mv	a0,s0
    uintptr_t sstatus = tf->status;
ffffffffc0203f6a:	10043483          	ld	s1,256(s0)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc0203f6e:	0e7000ef          	jal	ra,ffffffffc0204854 <memset>
    tf->epc = elf->e_entry;
ffffffffc0203f72:	0189b703          	ld	a4,24(s3)
    tf->gpr.sp = USTACKTOP;
ffffffffc0203f76:	4785                	li	a5,1
    set_proc_name(current, local_name);
ffffffffc0203f78:	000ab503          	ld	a0,0(s5)
    tf->status = sstatus & ~(SSTATUS_SPP | SSTATUS_SPIE);
ffffffffc0203f7c:	edf4f493          	andi	s1,s1,-289
    tf->gpr.sp = USTACKTOP;
ffffffffc0203f80:	07fe                	slli	a5,a5,0x1f
ffffffffc0203f82:	e81c                	sd	a5,16(s0)
    tf->epc = elf->e_entry;
ffffffffc0203f84:	10e43423          	sd	a4,264(s0)
    tf->status = sstatus & ~(SSTATUS_SPP | SSTATUS_SPIE);
ffffffffc0203f88:	10943023          	sd	s1,256(s0)
    set_proc_name(current, local_name);
ffffffffc0203f8c:	100c                	addi	a1,sp,32
ffffffffc0203f8e:	cf0ff0ef          	jal	ra,ffffffffc020347e <set_proc_name>
}
ffffffffc0203f92:	60ea                	ld	ra,152(sp)
ffffffffc0203f94:	644a                	ld	s0,144(sp)
ffffffffc0203f96:	64aa                	ld	s1,136(sp)
ffffffffc0203f98:	690a                	ld	s2,128(sp)
ffffffffc0203f9a:	79e6                	ld	s3,120(sp)
ffffffffc0203f9c:	7aa6                	ld	s5,104(sp)
ffffffffc0203f9e:	7b06                	ld	s6,96(sp)
ffffffffc0203fa0:	6be6                	ld	s7,88(sp)
ffffffffc0203fa2:	6c46                	ld	s8,80(sp)
ffffffffc0203fa4:	6ca6                	ld	s9,72(sp)
ffffffffc0203fa6:	6d06                	ld	s10,64(sp)
ffffffffc0203fa8:	7de2                	ld	s11,56(sp)
ffffffffc0203faa:	8552                	mv	a0,s4
ffffffffc0203fac:	7a46                	ld	s4,112(sp)
ffffffffc0203fae:	610d                	addi	sp,sp,160
ffffffffc0203fb0:	8082                	ret
        if (ph->p_filesz > ph->p_memsz) {
ffffffffc0203fb2:	02893603          	ld	a2,40(s2)
ffffffffc0203fb6:	02093783          	ld	a5,32(s2)
ffffffffc0203fba:	1ef66f63          	bltu	a2,a5,ffffffffc02041b8 <do_execve+0x434>
        if (ph->p_flags & ELF_PF_X) vm_flags |= VM_EXEC;
ffffffffc0203fbe:	00492783          	lw	a5,4(s2)
ffffffffc0203fc2:	0017f693          	andi	a3,a5,1
ffffffffc0203fc6:	c291                	beqz	a3,ffffffffc0203fca <do_execve+0x246>
ffffffffc0203fc8:	4691                	li	a3,4
        if (ph->p_flags & ELF_PF_W) vm_flags |= VM_WRITE;
ffffffffc0203fca:	0027f713          	andi	a4,a5,2
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc0203fce:	8b91                	andi	a5,a5,4
        if (ph->p_flags & ELF_PF_W) vm_flags |= VM_WRITE;
ffffffffc0203fd0:	0e071063          	bnez	a4,ffffffffc02040b0 <do_execve+0x32c>
        vm_flags = 0, perm = PTE_U | PTE_V;
ffffffffc0203fd4:	4745                	li	a4,17
ffffffffc0203fd6:	e03a                	sd	a4,0(sp)
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc0203fd8:	c789                	beqz	a5,ffffffffc0203fe2 <do_execve+0x25e>
        if (vm_flags & VM_READ) perm |= PTE_R;
ffffffffc0203fda:	47cd                	li	a5,19
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc0203fdc:	0016e693          	ori	a3,a3,1
        if (vm_flags & VM_READ) perm |= PTE_R;
ffffffffc0203fe0:	e03e                	sd	a5,0(sp)
        if (vm_flags & VM_WRITE) perm |= (PTE_W | PTE_R);
ffffffffc0203fe2:	0026f793          	andi	a5,a3,2
ffffffffc0203fe6:	ebe1                	bnez	a5,ffffffffc02040b6 <do_execve+0x332>
        if (vm_flags & VM_EXEC) perm |= PTE_X;
ffffffffc0203fe8:	0046f793          	andi	a5,a3,4
ffffffffc0203fec:	c789                	beqz	a5,ffffffffc0203ff6 <do_execve+0x272>
ffffffffc0203fee:	6782                	ld	a5,0(sp)
ffffffffc0203ff0:	0087e793          	ori	a5,a5,8
ffffffffc0203ff4:	e03e                	sd	a5,0(sp)
        if ((ret = mm_map(mm, ph->p_va, ph->p_memsz, vm_flags, NULL)) != 0) {
ffffffffc0203ff6:	01093583          	ld	a1,16(s2)
ffffffffc0203ffa:	4701                	li	a4,0
ffffffffc0203ffc:	8526                	mv	a0,s1
ffffffffc0203ffe:	8effd0ef          	jal	ra,ffffffffc02018ec <mm_map>
ffffffffc0204002:	8a2a                	mv	s4,a0
ffffffffc0204004:	e151                	bnez	a0,ffffffffc0204088 <do_execve+0x304>
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204006:	01093c03          	ld	s8,16(s2)
        end = ph->p_va + ph->p_filesz;
ffffffffc020400a:	02093a03          	ld	s4,32(s2)
        unsigned char *from = binary + ph->p_offset;
ffffffffc020400e:	00893b03          	ld	s6,8(s2)
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204012:	77fd                	lui	a5,0xfffff
        end = ph->p_va + ph->p_filesz;
ffffffffc0204014:	9a62                	add	s4,s4,s8
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204016:	9b4e                	add	s6,s6,s3
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204018:	00fc7bb3          	and	s7,s8,a5
        while (start < end) {
ffffffffc020401c:	054c6e63          	bltu	s8,s4,ffffffffc0204078 <do_execve+0x2f4>
ffffffffc0204020:	aa51                	j	ffffffffc02041b4 <do_execve+0x430>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204022:	6785                	lui	a5,0x1
ffffffffc0204024:	417c0533          	sub	a0,s8,s7
ffffffffc0204028:	9bbe                	add	s7,s7,a5
ffffffffc020402a:	418b8633          	sub	a2,s7,s8
            if (end < la) {
ffffffffc020402e:	017a7463          	bgeu	s4,s7,ffffffffc0204036 <do_execve+0x2b2>
                size -= la - end;
ffffffffc0204032:	418a0633          	sub	a2,s4,s8
    return page - pages + nbase;
ffffffffc0204036:	000db683          	ld	a3,0(s11)
ffffffffc020403a:	000d3803          	ld	a6,0(s10)
    return KADDR(page2pa(page));
ffffffffc020403e:	67a2                	ld	a5,8(sp)
    return page - pages + nbase;
ffffffffc0204040:	40d406b3          	sub	a3,s0,a3
ffffffffc0204044:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0204046:	000cb583          	ld	a1,0(s9)
    return page - pages + nbase;
ffffffffc020404a:	96c2                	add	a3,a3,a6
    return KADDR(page2pa(page));
ffffffffc020404c:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204050:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204052:	16b87563          	bgeu	a6,a1,ffffffffc02041bc <do_execve+0x438>
ffffffffc0204056:	00030797          	auipc	a5,0x30
ffffffffc020405a:	cca78793          	addi	a5,a5,-822 # ffffffffc0233d20 <va_pa_offset>
ffffffffc020405e:	0007b803          	ld	a6,0(a5)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204062:	85da                	mv	a1,s6
            start += size, from += size;
ffffffffc0204064:	9c32                	add	s8,s8,a2
ffffffffc0204066:	96c2                	add	a3,a3,a6
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204068:	9536                	add	a0,a0,a3
            start += size, from += size;
ffffffffc020406a:	e832                	sd	a2,16(sp)
            memcpy(page2kva(page) + off, from, size);
ffffffffc020406c:	7fa000ef          	jal	ra,ffffffffc0204866 <memcpy>
            start += size, from += size;
ffffffffc0204070:	6642                	ld	a2,16(sp)
ffffffffc0204072:	9b32                	add	s6,s6,a2
        while (start < end) {
ffffffffc0204074:	054c7463          	bgeu	s8,s4,ffffffffc02040bc <do_execve+0x338>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL) {
ffffffffc0204078:	6c88                	ld	a0,24(s1)
ffffffffc020407a:	6602                	ld	a2,0(sp)
ffffffffc020407c:	85de                	mv	a1,s7
ffffffffc020407e:	e12fd0ef          	jal	ra,ffffffffc0201690 <pgdir_alloc_page>
ffffffffc0204082:	842a                	mv	s0,a0
ffffffffc0204084:	fd59                	bnez	a0,ffffffffc0204022 <do_execve+0x29e>
        ret = -E_NO_MEM;
ffffffffc0204086:	5a71                	li	s4,-4
    exit_mmap(mm);
ffffffffc0204088:	8526                	mv	a0,s1
ffffffffc020408a:	9adfd0ef          	jal	ra,ffffffffc0201a36 <exit_mmap>
    put_pgdir(mm);
ffffffffc020408e:	8526                	mv	a0,s1
ffffffffc0204090:	af6ff0ef          	jal	ra,ffffffffc0203386 <put_pgdir>
    mm_destroy(mm);
ffffffffc0204094:	8526                	mv	a0,s1
ffffffffc0204096:	805fd0ef          	jal	ra,ffffffffc020189a <mm_destroy>
    return ret;
ffffffffc020409a:	b37d                	j	ffffffffc0203e48 <do_execve+0xc4>
            exit_mmap(mm);
ffffffffc020409c:	8552                	mv	a0,s4
ffffffffc020409e:	999fd0ef          	jal	ra,ffffffffc0201a36 <exit_mmap>
            put_pgdir(mm);
ffffffffc02040a2:	8552                	mv	a0,s4
ffffffffc02040a4:	ae2ff0ef          	jal	ra,ffffffffc0203386 <put_pgdir>
            mm_destroy(mm);
ffffffffc02040a8:	8552                	mv	a0,s4
ffffffffc02040aa:	ff0fd0ef          	jal	ra,ffffffffc020189a <mm_destroy>
ffffffffc02040ae:	b39d                	j	ffffffffc0203e14 <do_execve+0x90>
        if (ph->p_flags & ELF_PF_W) vm_flags |= VM_WRITE;
ffffffffc02040b0:	0026e693          	ori	a3,a3,2
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc02040b4:	f39d                	bnez	a5,ffffffffc0203fda <do_execve+0x256>
        if (vm_flags & VM_WRITE) perm |= (PTE_W | PTE_R);
ffffffffc02040b6:	47dd                	li	a5,23
ffffffffc02040b8:	e03e                	sd	a5,0(sp)
ffffffffc02040ba:	b73d                	j	ffffffffc0203fe8 <do_execve+0x264>
ffffffffc02040bc:	01093a03          	ld	s4,16(s2)
        end = ph->p_va + ph->p_memsz;
ffffffffc02040c0:	02893683          	ld	a3,40(s2)
ffffffffc02040c4:	9a36                	add	s4,s4,a3
        if (start < la) {
ffffffffc02040c6:	077c7f63          	bgeu	s8,s7,ffffffffc0204144 <do_execve+0x3c0>
            if (start == end) {
ffffffffc02040ca:	e18a02e3          	beq	s4,s8,ffffffffc0203ece <do_execve+0x14a>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc02040ce:	6505                	lui	a0,0x1
ffffffffc02040d0:	9562                	add	a0,a0,s8
ffffffffc02040d2:	41750533          	sub	a0,a0,s7
                size -= la - end;
ffffffffc02040d6:	418a0b33          	sub	s6,s4,s8
            if (end < la) {
ffffffffc02040da:	0d7a7863          	bgeu	s4,s7,ffffffffc02041aa <do_execve+0x426>
    return page - pages + nbase;
ffffffffc02040de:	000db683          	ld	a3,0(s11)
ffffffffc02040e2:	000d3583          	ld	a1,0(s10)
    return KADDR(page2pa(page));
ffffffffc02040e6:	67a2                	ld	a5,8(sp)
    return page - pages + nbase;
ffffffffc02040e8:	40d406b3          	sub	a3,s0,a3
ffffffffc02040ec:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc02040ee:	000cb603          	ld	a2,0(s9)
    return page - pages + nbase;
ffffffffc02040f2:	96ae                	add	a3,a3,a1
    return KADDR(page2pa(page));
ffffffffc02040f4:	00f6f5b3          	and	a1,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc02040f8:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02040fa:	0cc5f163          	bgeu	a1,a2,ffffffffc02041bc <do_execve+0x438>
ffffffffc02040fe:	00030617          	auipc	a2,0x30
ffffffffc0204102:	c2263603          	ld	a2,-990(a2) # ffffffffc0233d20 <va_pa_offset>
ffffffffc0204106:	96b2                	add	a3,a3,a2
            memset(page2kva(page) + off, 0, size);
ffffffffc0204108:	4581                	li	a1,0
ffffffffc020410a:	865a                	mv	a2,s6
ffffffffc020410c:	9536                	add	a0,a0,a3
ffffffffc020410e:	746000ef          	jal	ra,ffffffffc0204854 <memset>
            start += size;
ffffffffc0204112:	018b0733          	add	a4,s6,s8
            assert((end < la && start == end) || (end >= la && start == la));
ffffffffc0204116:	037a7463          	bgeu	s4,s7,ffffffffc020413e <do_execve+0x3ba>
ffffffffc020411a:	daea0ae3          	beq	s4,a4,ffffffffc0203ece <do_execve+0x14a>
ffffffffc020411e:	00002697          	auipc	a3,0x2
ffffffffc0204122:	24a68693          	addi	a3,a3,586 # ffffffffc0206368 <default_pmm_manager+0x2f8>
ffffffffc0204126:	00001617          	auipc	a2,0x1
ffffffffc020412a:	20a60613          	addi	a2,a2,522 # ffffffffc0205330 <commands+0x408>
ffffffffc020412e:	22600593          	li	a1,550
ffffffffc0204132:	00002517          	auipc	a0,0x2
ffffffffc0204136:	02e50513          	addi	a0,a0,46 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc020413a:	8cafc0ef          	jal	ra,ffffffffc0200204 <__panic>
ffffffffc020413e:	ff7710e3          	bne	a4,s7,ffffffffc020411e <do_execve+0x39a>
ffffffffc0204142:	8c5e                	mv	s8,s7
ffffffffc0204144:	00030b17          	auipc	s6,0x30
ffffffffc0204148:	bdcb0b13          	addi	s6,s6,-1060 # ffffffffc0233d20 <va_pa_offset>
        while (start < end) {
ffffffffc020414c:	054c6763          	bltu	s8,s4,ffffffffc020419a <do_execve+0x416>
ffffffffc0204150:	bbbd                	j	ffffffffc0203ece <do_execve+0x14a>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204152:	6785                	lui	a5,0x1
ffffffffc0204154:	417c0533          	sub	a0,s8,s7
ffffffffc0204158:	9bbe                	add	s7,s7,a5
ffffffffc020415a:	418b8633          	sub	a2,s7,s8
            if (end < la) {
ffffffffc020415e:	017a7463          	bgeu	s4,s7,ffffffffc0204166 <do_execve+0x3e2>
                size -= la - end;
ffffffffc0204162:	418a0633          	sub	a2,s4,s8
    return page - pages + nbase;
ffffffffc0204166:	000db683          	ld	a3,0(s11)
ffffffffc020416a:	000d3803          	ld	a6,0(s10)
    return KADDR(page2pa(page));
ffffffffc020416e:	67a2                	ld	a5,8(sp)
    return page - pages + nbase;
ffffffffc0204170:	40d406b3          	sub	a3,s0,a3
ffffffffc0204174:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0204176:	000cb583          	ld	a1,0(s9)
    return page - pages + nbase;
ffffffffc020417a:	96c2                	add	a3,a3,a6
    return KADDR(page2pa(page));
ffffffffc020417c:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204180:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204182:	02b87d63          	bgeu	a6,a1,ffffffffc02041bc <do_execve+0x438>
ffffffffc0204186:	000b3803          	ld	a6,0(s6)
            start += size;
ffffffffc020418a:	9c32                	add	s8,s8,a2
            memset(page2kva(page) + off, 0, size);
ffffffffc020418c:	4581                	li	a1,0
ffffffffc020418e:	96c2                	add	a3,a3,a6
ffffffffc0204190:	9536                	add	a0,a0,a3
ffffffffc0204192:	6c2000ef          	jal	ra,ffffffffc0204854 <memset>
        while (start < end) {
ffffffffc0204196:	d34c7ce3          	bgeu	s8,s4,ffffffffc0203ece <do_execve+0x14a>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL) {
ffffffffc020419a:	6c88                	ld	a0,24(s1)
ffffffffc020419c:	6602                	ld	a2,0(sp)
ffffffffc020419e:	85de                	mv	a1,s7
ffffffffc02041a0:	cf0fd0ef          	jal	ra,ffffffffc0201690 <pgdir_alloc_page>
ffffffffc02041a4:	842a                	mv	s0,a0
ffffffffc02041a6:	f555                	bnez	a0,ffffffffc0204152 <do_execve+0x3ce>
ffffffffc02041a8:	bdf9                	j	ffffffffc0204086 <do_execve+0x302>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc02041aa:	418b8b33          	sub	s6,s7,s8
ffffffffc02041ae:	bf05                	j	ffffffffc02040de <do_execve+0x35a>
        return -E_INVAL;
ffffffffc02041b0:	5a75                	li	s4,-3
ffffffffc02041b2:	b3c5                	j	ffffffffc0203f92 <do_execve+0x20e>
        while (start < end) {
ffffffffc02041b4:	8a62                	mv	s4,s8
ffffffffc02041b6:	b729                	j	ffffffffc02040c0 <do_execve+0x33c>
            ret = -E_INVAL_ELF;
ffffffffc02041b8:	5a61                	li	s4,-8
ffffffffc02041ba:	b5f9                	j	ffffffffc0204088 <do_execve+0x304>
ffffffffc02041bc:	00001617          	auipc	a2,0x1
ffffffffc02041c0:	52460613          	addi	a2,a2,1316 # ffffffffc02056e0 <commands+0x7b8>
ffffffffc02041c4:	06900593          	li	a1,105
ffffffffc02041c8:	00001517          	auipc	a0,0x1
ffffffffc02041cc:	47850513          	addi	a0,a0,1144 # ffffffffc0205640 <commands+0x718>
ffffffffc02041d0:	834fc0ef          	jal	ra,ffffffffc0200204 <__panic>
    current->cr3 = PADDR(mm->pgdir);
ffffffffc02041d4:	00001617          	auipc	a2,0x1
ffffffffc02041d8:	4d460613          	addi	a2,a2,1236 # ffffffffc02056a8 <commands+0x780>
ffffffffc02041dc:	24100593          	li	a1,577
ffffffffc02041e0:	00002517          	auipc	a0,0x2
ffffffffc02041e4:	f8050513          	addi	a0,a0,-128 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc02041e8:	81cfc0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-4*PGSIZE , PTE_USER) != NULL);
ffffffffc02041ec:	00002697          	auipc	a3,0x2
ffffffffc02041f0:	29468693          	addi	a3,a3,660 # ffffffffc0206480 <default_pmm_manager+0x410>
ffffffffc02041f4:	00001617          	auipc	a2,0x1
ffffffffc02041f8:	13c60613          	addi	a2,a2,316 # ffffffffc0205330 <commands+0x408>
ffffffffc02041fc:	23c00593          	li	a1,572
ffffffffc0204200:	00002517          	auipc	a0,0x2
ffffffffc0204204:	f6050513          	addi	a0,a0,-160 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc0204208:	ffdfb0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-3*PGSIZE , PTE_USER) != NULL);
ffffffffc020420c:	00002697          	auipc	a3,0x2
ffffffffc0204210:	22c68693          	addi	a3,a3,556 # ffffffffc0206438 <default_pmm_manager+0x3c8>
ffffffffc0204214:	00001617          	auipc	a2,0x1
ffffffffc0204218:	11c60613          	addi	a2,a2,284 # ffffffffc0205330 <commands+0x408>
ffffffffc020421c:	23b00593          	li	a1,571
ffffffffc0204220:	00002517          	auipc	a0,0x2
ffffffffc0204224:	f4050513          	addi	a0,a0,-192 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc0204228:	fddfb0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-2*PGSIZE , PTE_USER) != NULL);
ffffffffc020422c:	00002697          	auipc	a3,0x2
ffffffffc0204230:	1c468693          	addi	a3,a3,452 # ffffffffc02063f0 <default_pmm_manager+0x380>
ffffffffc0204234:	00001617          	auipc	a2,0x1
ffffffffc0204238:	0fc60613          	addi	a2,a2,252 # ffffffffc0205330 <commands+0x408>
ffffffffc020423c:	23a00593          	li	a1,570
ffffffffc0204240:	00002517          	auipc	a0,0x2
ffffffffc0204244:	f2050513          	addi	a0,a0,-224 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc0204248:	fbdfb0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-PGSIZE , PTE_USER) != NULL);
ffffffffc020424c:	00002697          	auipc	a3,0x2
ffffffffc0204250:	15c68693          	addi	a3,a3,348 # ffffffffc02063a8 <default_pmm_manager+0x338>
ffffffffc0204254:	00001617          	auipc	a2,0x1
ffffffffc0204258:	0dc60613          	addi	a2,a2,220 # ffffffffc0205330 <commands+0x408>
ffffffffc020425c:	23900593          	li	a1,569
ffffffffc0204260:	00002517          	auipc	a0,0x2
ffffffffc0204264:	f0050513          	addi	a0,a0,-256 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc0204268:	f9dfb0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020426c <do_yield>:
    current->need_resched = 1;
ffffffffc020426c:	00030797          	auipc	a5,0x30
ffffffffc0204270:	a747b783          	ld	a5,-1420(a5) # ffffffffc0233ce0 <current>
ffffffffc0204274:	4705                	li	a4,1
ffffffffc0204276:	ef98                	sd	a4,24(a5)
}
ffffffffc0204278:	4501                	li	a0,0
ffffffffc020427a:	8082                	ret

ffffffffc020427c <do_wait>:
do_wait(int pid, int *code_store) {
ffffffffc020427c:	1101                	addi	sp,sp,-32
ffffffffc020427e:	e822                	sd	s0,16(sp)
ffffffffc0204280:	e426                	sd	s1,8(sp)
ffffffffc0204282:	ec06                	sd	ra,24(sp)
ffffffffc0204284:	842e                	mv	s0,a1
ffffffffc0204286:	84aa                	mv	s1,a0
    if (code_store != NULL) {
ffffffffc0204288:	c999                	beqz	a1,ffffffffc020429e <do_wait+0x22>
    struct mm_struct *mm = current->mm;
ffffffffc020428a:	00030797          	auipc	a5,0x30
ffffffffc020428e:	a567b783          	ld	a5,-1450(a5) # ffffffffc0233ce0 <current>
        if (!user_mem_check(mm, (uintptr_t)code_store, sizeof(int), 1)) {
ffffffffc0204292:	7788                	ld	a0,40(a5)
ffffffffc0204294:	4685                	li	a3,1
ffffffffc0204296:	4611                	li	a2,4
ffffffffc0204298:	919fd0ef          	jal	ra,ffffffffc0201bb0 <user_mem_check>
ffffffffc020429c:	c909                	beqz	a0,ffffffffc02042ae <do_wait+0x32>
ffffffffc020429e:	85a2                	mv	a1,s0
}
ffffffffc02042a0:	6442                	ld	s0,16(sp)
ffffffffc02042a2:	60e2                	ld	ra,24(sp)
ffffffffc02042a4:	8526                	mv	a0,s1
ffffffffc02042a6:	64a2                	ld	s1,8(sp)
ffffffffc02042a8:	6105                	addi	sp,sp,32
ffffffffc02042aa:	821ff06f          	j	ffffffffc0203aca <do_wait.part.0>
ffffffffc02042ae:	60e2                	ld	ra,24(sp)
ffffffffc02042b0:	6442                	ld	s0,16(sp)
ffffffffc02042b2:	64a2                	ld	s1,8(sp)
ffffffffc02042b4:	5575                	li	a0,-3
ffffffffc02042b6:	6105                	addi	sp,sp,32
ffffffffc02042b8:	8082                	ret

ffffffffc02042ba <do_kill>:
do_kill(int pid) {
ffffffffc02042ba:	1141                	addi	sp,sp,-16
ffffffffc02042bc:	e406                	sd	ra,8(sp)
ffffffffc02042be:	e022                	sd	s0,0(sp)
    if ((proc = find_proc(pid)) != NULL) {
ffffffffc02042c0:	a54ff0ef          	jal	ra,ffffffffc0203514 <find_proc>
ffffffffc02042c4:	cd0d                	beqz	a0,ffffffffc02042fe <do_kill+0x44>
        if (!(proc->flags & PF_EXITING)) {
ffffffffc02042c6:	0b052703          	lw	a4,176(a0)
ffffffffc02042ca:	00177693          	andi	a3,a4,1
ffffffffc02042ce:	e695                	bnez	a3,ffffffffc02042fa <do_kill+0x40>
            if (proc->wait_state & WT_INTERRUPTED) {
ffffffffc02042d0:	0ec52683          	lw	a3,236(a0)
            proc->flags |= PF_EXITING;
ffffffffc02042d4:	00176713          	ori	a4,a4,1
ffffffffc02042d8:	0ae52823          	sw	a4,176(a0)
            return 0;
ffffffffc02042dc:	4401                	li	s0,0
            if (proc->wait_state & WT_INTERRUPTED) {
ffffffffc02042de:	0006c763          	bltz	a3,ffffffffc02042ec <do_kill+0x32>
}
ffffffffc02042e2:	60a2                	ld	ra,8(sp)
ffffffffc02042e4:	8522                	mv	a0,s0
ffffffffc02042e6:	6402                	ld	s0,0(sp)
ffffffffc02042e8:	0141                	addi	sp,sp,16
ffffffffc02042ea:	8082                	ret
                wakeup_proc(proc);
ffffffffc02042ec:	1e2000ef          	jal	ra,ffffffffc02044ce <wakeup_proc>
}
ffffffffc02042f0:	60a2                	ld	ra,8(sp)
ffffffffc02042f2:	8522                	mv	a0,s0
ffffffffc02042f4:	6402                	ld	s0,0(sp)
ffffffffc02042f6:	0141                	addi	sp,sp,16
ffffffffc02042f8:	8082                	ret
        return -E_KILLED;
ffffffffc02042fa:	545d                	li	s0,-9
ffffffffc02042fc:	b7dd                	j	ffffffffc02042e2 <do_kill+0x28>
    return -E_INVAL;
ffffffffc02042fe:	5475                	li	s0,-3
ffffffffc0204300:	b7cd                	j	ffffffffc02042e2 <do_kill+0x28>

ffffffffc0204302 <proc_init>:

// proc_init - set up the first kernel thread idleproc "idle" by itself and 
//           - create the second kernel thread init_main
void
proc_init(void) {
ffffffffc0204302:	1101                	addi	sp,sp,-32
    elm->prev = elm->next = elm;
ffffffffc0204304:	00030797          	auipc	a5,0x30
ffffffffc0204308:	b2c78793          	addi	a5,a5,-1236 # ffffffffc0233e30 <proc_list>
ffffffffc020430c:	ec06                	sd	ra,24(sp)
ffffffffc020430e:	e822                	sd	s0,16(sp)
ffffffffc0204310:	e426                	sd	s1,8(sp)
ffffffffc0204312:	e04a                	sd	s2,0(sp)
ffffffffc0204314:	e79c                	sd	a5,8(a5)
ffffffffc0204316:	e39c                	sd	a5,0(a5)
    int i;

    list_init(&proc_list);
    for (i = 0; i < HASH_LIST_SIZE; i ++) {
ffffffffc0204318:	00030717          	auipc	a4,0x30
ffffffffc020431c:	96070713          	addi	a4,a4,-1696 # ffffffffc0233c78 <__rq>
ffffffffc0204320:	0002c797          	auipc	a5,0x2c
ffffffffc0204324:	95878793          	addi	a5,a5,-1704 # ffffffffc022fc78 <hash_list>
ffffffffc0204328:	e79c                	sd	a5,8(a5)
ffffffffc020432a:	e39c                	sd	a5,0(a5)
ffffffffc020432c:	07c1                	addi	a5,a5,16
ffffffffc020432e:	fef71de3          	bne	a4,a5,ffffffffc0204328 <proc_init+0x26>
        list_init(hash_list + i);
    }

    if ((idleproc = alloc_proc()) == NULL) {
ffffffffc0204332:	f43fe0ef          	jal	ra,ffffffffc0203274 <alloc_proc>
ffffffffc0204336:	00030417          	auipc	s0,0x30
ffffffffc020433a:	9b240413          	addi	s0,s0,-1614 # ffffffffc0233ce8 <idleproc>
ffffffffc020433e:	e008                	sd	a0,0(s0)
ffffffffc0204340:	c541                	beqz	a0,ffffffffc02043c8 <proc_init+0xc6>
        panic("cannot alloc idleproc.\n");
    }

    idleproc->pid = 0;
    idleproc->state = PROC_RUNNABLE;
ffffffffc0204342:	4709                	li	a4,2
ffffffffc0204344:	e118                	sd	a4,0(a0)
    idleproc->kstack = (uintptr_t)bootstack;
    idleproc->need_resched = 1;
ffffffffc0204346:	4485                	li	s1,1
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204348:	00003717          	auipc	a4,0x3
ffffffffc020434c:	cb870713          	addi	a4,a4,-840 # ffffffffc0207000 <bootstack>
    set_proc_name(idleproc, "idle");
ffffffffc0204350:	00002597          	auipc	a1,0x2
ffffffffc0204354:	19058593          	addi	a1,a1,400 # ffffffffc02064e0 <default_pmm_manager+0x470>
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204358:	e918                	sd	a4,16(a0)
    idleproc->need_resched = 1;
ffffffffc020435a:	ed04                	sd	s1,24(a0)
    set_proc_name(idleproc, "idle");
ffffffffc020435c:	922ff0ef          	jal	ra,ffffffffc020347e <set_proc_name>
    nr_process ++;
ffffffffc0204360:	00030717          	auipc	a4,0x30
ffffffffc0204364:	99870713          	addi	a4,a4,-1640 # ffffffffc0233cf8 <nr_process>
ffffffffc0204368:	431c                	lw	a5,0(a4)

    current = idleproc;
ffffffffc020436a:	6014                	ld	a3,0(s0)

    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc020436c:	4601                	li	a2,0
    nr_process ++;
ffffffffc020436e:	2785                	addiw	a5,a5,1
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204370:	4581                	li	a1,0
ffffffffc0204372:	00000517          	auipc	a0,0x0
ffffffffc0204376:	8ee50513          	addi	a0,a0,-1810 # ffffffffc0203c60 <init_main>
    nr_process ++;
ffffffffc020437a:	c31c                	sw	a5,0(a4)
    current = idleproc;
ffffffffc020437c:	00030797          	auipc	a5,0x30
ffffffffc0204380:	96d7b223          	sd	a3,-1692(a5) # ffffffffc0233ce0 <current>
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204384:	dacff0ef          	jal	ra,ffffffffc0203930 <kernel_thread>
    if (pid <= 0) {
ffffffffc0204388:	08a05c63          	blez	a0,ffffffffc0204420 <proc_init+0x11e>
        panic("create init_main failed.\n");
    }

    initproc = find_proc(pid);
ffffffffc020438c:	988ff0ef          	jal	ra,ffffffffc0203514 <find_proc>
ffffffffc0204390:	00030917          	auipc	s2,0x30
ffffffffc0204394:	96090913          	addi	s2,s2,-1696 # ffffffffc0233cf0 <initproc>
    set_proc_name(initproc, "init");
ffffffffc0204398:	00002597          	auipc	a1,0x2
ffffffffc020439c:	17058593          	addi	a1,a1,368 # ffffffffc0206508 <default_pmm_manager+0x498>
    initproc = find_proc(pid);
ffffffffc02043a0:	00a93023          	sd	a0,0(s2)
    set_proc_name(initproc, "init");
ffffffffc02043a4:	8daff0ef          	jal	ra,ffffffffc020347e <set_proc_name>

    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc02043a8:	601c                	ld	a5,0(s0)
ffffffffc02043aa:	cbb9                	beqz	a5,ffffffffc0204400 <proc_init+0xfe>
ffffffffc02043ac:	43dc                	lw	a5,4(a5)
ffffffffc02043ae:	eba9                	bnez	a5,ffffffffc0204400 <proc_init+0xfe>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc02043b0:	00093783          	ld	a5,0(s2)
ffffffffc02043b4:	c795                	beqz	a5,ffffffffc02043e0 <proc_init+0xde>
ffffffffc02043b6:	43dc                	lw	a5,4(a5)
ffffffffc02043b8:	02979463          	bne	a5,s1,ffffffffc02043e0 <proc_init+0xde>
}
ffffffffc02043bc:	60e2                	ld	ra,24(sp)
ffffffffc02043be:	6442                	ld	s0,16(sp)
ffffffffc02043c0:	64a2                	ld	s1,8(sp)
ffffffffc02043c2:	6902                	ld	s2,0(sp)
ffffffffc02043c4:	6105                	addi	sp,sp,32
ffffffffc02043c6:	8082                	ret
        panic("cannot alloc idleproc.\n");
ffffffffc02043c8:	00002617          	auipc	a2,0x2
ffffffffc02043cc:	10060613          	addi	a2,a2,256 # ffffffffc02064c8 <default_pmm_manager+0x458>
ffffffffc02043d0:	33000593          	li	a1,816
ffffffffc02043d4:	00002517          	auipc	a0,0x2
ffffffffc02043d8:	d8c50513          	addi	a0,a0,-628 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc02043dc:	e29fb0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc02043e0:	00002697          	auipc	a3,0x2
ffffffffc02043e4:	15868693          	addi	a3,a3,344 # ffffffffc0206538 <default_pmm_manager+0x4c8>
ffffffffc02043e8:	00001617          	auipc	a2,0x1
ffffffffc02043ec:	f4860613          	addi	a2,a2,-184 # ffffffffc0205330 <commands+0x408>
ffffffffc02043f0:	34500593          	li	a1,837
ffffffffc02043f4:	00002517          	auipc	a0,0x2
ffffffffc02043f8:	d6c50513          	addi	a0,a0,-660 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc02043fc:	e09fb0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc0204400:	00002697          	auipc	a3,0x2
ffffffffc0204404:	11068693          	addi	a3,a3,272 # ffffffffc0206510 <default_pmm_manager+0x4a0>
ffffffffc0204408:	00001617          	auipc	a2,0x1
ffffffffc020440c:	f2860613          	addi	a2,a2,-216 # ffffffffc0205330 <commands+0x408>
ffffffffc0204410:	34400593          	li	a1,836
ffffffffc0204414:	00002517          	auipc	a0,0x2
ffffffffc0204418:	d4c50513          	addi	a0,a0,-692 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc020441c:	de9fb0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("create init_main failed.\n");
ffffffffc0204420:	00002617          	auipc	a2,0x2
ffffffffc0204424:	0c860613          	addi	a2,a2,200 # ffffffffc02064e8 <default_pmm_manager+0x478>
ffffffffc0204428:	33e00593          	li	a1,830
ffffffffc020442c:	00002517          	auipc	a0,0x2
ffffffffc0204430:	d3450513          	addi	a0,a0,-716 # ffffffffc0206160 <default_pmm_manager+0xf0>
ffffffffc0204434:	dd1fb0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0204438 <cpu_idle>:

// cpu_idle - at the end of kern_init, the first kernel thread idleproc will do below works
void
cpu_idle(void) {
ffffffffc0204438:	1141                	addi	sp,sp,-16
ffffffffc020443a:	e022                	sd	s0,0(sp)
ffffffffc020443c:	e406                	sd	ra,8(sp)
ffffffffc020443e:	00030417          	auipc	s0,0x30
ffffffffc0204442:	8a240413          	addi	s0,s0,-1886 # ffffffffc0233ce0 <current>
    while (1) {
        if (current->need_resched) {
ffffffffc0204446:	6018                	ld	a4,0(s0)
ffffffffc0204448:	6f1c                	ld	a5,24(a4)
ffffffffc020444a:	dffd                	beqz	a5,ffffffffc0204448 <cpu_idle+0x10>
            schedule();
ffffffffc020444c:	134000ef          	jal	ra,ffffffffc0204580 <schedule>
ffffffffc0204450:	bfdd                	j	ffffffffc0204446 <cpu_idle+0xe>

ffffffffc0204452 <sched_class_proc_tick>:
    return sched_class->pick_next(rq);
}

void
sched_class_proc_tick(struct proc_struct *proc) {
    if (proc != idleproc) {
ffffffffc0204452:	00030797          	auipc	a5,0x30
ffffffffc0204456:	8967b783          	ld	a5,-1898(a5) # ffffffffc0233ce8 <idleproc>
sched_class_proc_tick(struct proc_struct *proc) {
ffffffffc020445a:	85aa                	mv	a1,a0
    if (proc != idleproc) {
ffffffffc020445c:	00a78d63          	beq	a5,a0,ffffffffc0204476 <sched_class_proc_tick+0x24>
        sched_class->proc_tick(rq, proc);
ffffffffc0204460:	00030797          	auipc	a5,0x30
ffffffffc0204464:	8a87b783          	ld	a5,-1880(a5) # ffffffffc0233d08 <sched_class>
ffffffffc0204468:	0287b303          	ld	t1,40(a5)
ffffffffc020446c:	00030517          	auipc	a0,0x30
ffffffffc0204470:	89453503          	ld	a0,-1900(a0) # ffffffffc0233d00 <rq>
ffffffffc0204474:	8302                	jr	t1
    }
    else {
        proc->need_resched = 1;
ffffffffc0204476:	4705                	li	a4,1
ffffffffc0204478:	ef98                	sd	a4,24(a5)
    }
}
ffffffffc020447a:	8082                	ret

ffffffffc020447c <sched_init>:

static struct run_queue __rq;

void
sched_init(void) {
ffffffffc020447c:	1141                	addi	sp,sp,-16
    list_init(&timer_list);

    sched_class = &default_sched_class;
ffffffffc020447e:	00024717          	auipc	a4,0x24
ffffffffc0204482:	3ba70713          	addi	a4,a4,954 # ffffffffc0228838 <default_sched_class>
sched_init(void) {
ffffffffc0204486:	e022                	sd	s0,0(sp)
ffffffffc0204488:	e406                	sd	ra,8(sp)
ffffffffc020448a:	00030797          	auipc	a5,0x30
ffffffffc020448e:	80e78793          	addi	a5,a5,-2034 # ffffffffc0233c98 <timer_list>
    //sched_class = &stride_sched_class;

    rq = &__rq;
    rq->max_time_slice = MAX_TIME_SLICE;
    sched_class->init(rq);
ffffffffc0204492:	6714                	ld	a3,8(a4)
    rq = &__rq;
ffffffffc0204494:	0002f517          	auipc	a0,0x2f
ffffffffc0204498:	7e450513          	addi	a0,a0,2020 # ffffffffc0233c78 <__rq>
ffffffffc020449c:	e79c                	sd	a5,8(a5)
ffffffffc020449e:	e39c                	sd	a5,0(a5)
    rq->max_time_slice = MAX_TIME_SLICE;
ffffffffc02044a0:	4795                	li	a5,5
ffffffffc02044a2:	c95c                	sw	a5,20(a0)
    sched_class = &default_sched_class;
ffffffffc02044a4:	00030417          	auipc	s0,0x30
ffffffffc02044a8:	86440413          	addi	s0,s0,-1948 # ffffffffc0233d08 <sched_class>
    rq = &__rq;
ffffffffc02044ac:	00030797          	auipc	a5,0x30
ffffffffc02044b0:	84a7ba23          	sd	a0,-1964(a5) # ffffffffc0233d00 <rq>
    sched_class = &default_sched_class;
ffffffffc02044b4:	e018                	sd	a4,0(s0)
    sched_class->init(rq);
ffffffffc02044b6:	9682                	jalr	a3

    cprintf("sched class: %s\n", sched_class->name);
ffffffffc02044b8:	601c                	ld	a5,0(s0)
}
ffffffffc02044ba:	6402                	ld	s0,0(sp)
ffffffffc02044bc:	60a2                	ld	ra,8(sp)
    cprintf("sched class: %s\n", sched_class->name);
ffffffffc02044be:	638c                	ld	a1,0(a5)
ffffffffc02044c0:	00002517          	auipc	a0,0x2
ffffffffc02044c4:	0a050513          	addi	a0,a0,160 # ffffffffc0206560 <default_pmm_manager+0x4f0>
}
ffffffffc02044c8:	0141                	addi	sp,sp,16
    cprintf("sched class: %s\n", sched_class->name);
ffffffffc02044ca:	bfffb06f          	j	ffffffffc02000c8 <cprintf>

ffffffffc02044ce <wakeup_proc>:

void
wakeup_proc(struct proc_struct *proc) {
    assert(proc->state != PROC_ZOMBIE);
ffffffffc02044ce:	4118                	lw	a4,0(a0)
wakeup_proc(struct proc_struct *proc) {
ffffffffc02044d0:	1101                	addi	sp,sp,-32
ffffffffc02044d2:	ec06                	sd	ra,24(sp)
ffffffffc02044d4:	e822                	sd	s0,16(sp)
ffffffffc02044d6:	e426                	sd	s1,8(sp)
    assert(proc->state != PROC_ZOMBIE);
ffffffffc02044d8:	478d                	li	a5,3
ffffffffc02044da:	08f70363          	beq	a4,a5,ffffffffc0204560 <wakeup_proc+0x92>
ffffffffc02044de:	842a                	mv	s0,a0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02044e0:	100027f3          	csrr	a5,sstatus
ffffffffc02044e4:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02044e6:	4481                	li	s1,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02044e8:	e7bd                	bnez	a5,ffffffffc0204556 <wakeup_proc+0x88>
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        if (proc->state != PROC_RUNNABLE) {
ffffffffc02044ea:	4789                	li	a5,2
ffffffffc02044ec:	04f70863          	beq	a4,a5,ffffffffc020453c <wakeup_proc+0x6e>
            proc->state = PROC_RUNNABLE;
ffffffffc02044f0:	c01c                	sw	a5,0(s0)
            proc->wait_state = 0;
ffffffffc02044f2:	0e042623          	sw	zero,236(s0)
            if (proc != current) {
ffffffffc02044f6:	0002f797          	auipc	a5,0x2f
ffffffffc02044fa:	7ea7b783          	ld	a5,2026(a5) # ffffffffc0233ce0 <current>
ffffffffc02044fe:	02878363          	beq	a5,s0,ffffffffc0204524 <wakeup_proc+0x56>
    if (proc != idleproc) {
ffffffffc0204502:	0002f797          	auipc	a5,0x2f
ffffffffc0204506:	7e67b783          	ld	a5,2022(a5) # ffffffffc0233ce8 <idleproc>
ffffffffc020450a:	00f40d63          	beq	s0,a5,ffffffffc0204524 <wakeup_proc+0x56>
        sched_class->enqueue(rq, proc);
ffffffffc020450e:	0002f797          	auipc	a5,0x2f
ffffffffc0204512:	7fa7b783          	ld	a5,2042(a5) # ffffffffc0233d08 <sched_class>
ffffffffc0204516:	6b9c                	ld	a5,16(a5)
ffffffffc0204518:	85a2                	mv	a1,s0
ffffffffc020451a:	0002f517          	auipc	a0,0x2f
ffffffffc020451e:	7e653503          	ld	a0,2022(a0) # ffffffffc0233d00 <rq>
ffffffffc0204522:	9782                	jalr	a5
    if (flag) {
ffffffffc0204524:	e491                	bnez	s1,ffffffffc0204530 <wakeup_proc+0x62>
        else {
            warn("wakeup runnable process.\n");
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc0204526:	60e2                	ld	ra,24(sp)
ffffffffc0204528:	6442                	ld	s0,16(sp)
ffffffffc020452a:	64a2                	ld	s1,8(sp)
ffffffffc020452c:	6105                	addi	sp,sp,32
ffffffffc020452e:	8082                	ret
ffffffffc0204530:	6442                	ld	s0,16(sp)
ffffffffc0204532:	60e2                	ld	ra,24(sp)
ffffffffc0204534:	64a2                	ld	s1,8(sp)
ffffffffc0204536:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0204538:	8f4fc06f          	j	ffffffffc020062c <intr_enable>
            warn("wakeup runnable process.\n");
ffffffffc020453c:	00002617          	auipc	a2,0x2
ffffffffc0204540:	07460613          	addi	a2,a2,116 # ffffffffc02065b0 <default_pmm_manager+0x540>
ffffffffc0204544:	04900593          	li	a1,73
ffffffffc0204548:	00002517          	auipc	a0,0x2
ffffffffc020454c:	05050513          	addi	a0,a0,80 # ffffffffc0206598 <default_pmm_manager+0x528>
ffffffffc0204550:	d1dfb0ef          	jal	ra,ffffffffc020026c <__warn>
ffffffffc0204554:	bfc1                	j	ffffffffc0204524 <wakeup_proc+0x56>
        intr_disable();
ffffffffc0204556:	8dcfc0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc020455a:	4018                	lw	a4,0(s0)
ffffffffc020455c:	4485                	li	s1,1
ffffffffc020455e:	b771                	j	ffffffffc02044ea <wakeup_proc+0x1c>
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0204560:	00002697          	auipc	a3,0x2
ffffffffc0204564:	01868693          	addi	a3,a3,24 # ffffffffc0206578 <default_pmm_manager+0x508>
ffffffffc0204568:	00001617          	auipc	a2,0x1
ffffffffc020456c:	dc860613          	addi	a2,a2,-568 # ffffffffc0205330 <commands+0x408>
ffffffffc0204570:	03d00593          	li	a1,61
ffffffffc0204574:	00002517          	auipc	a0,0x2
ffffffffc0204578:	02450513          	addi	a0,a0,36 # ffffffffc0206598 <default_pmm_manager+0x528>
ffffffffc020457c:	c89fb0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0204580 <schedule>:

void
schedule(void) {
ffffffffc0204580:	7179                	addi	sp,sp,-48
ffffffffc0204582:	f406                	sd	ra,40(sp)
ffffffffc0204584:	f022                	sd	s0,32(sp)
ffffffffc0204586:	ec26                	sd	s1,24(sp)
ffffffffc0204588:	e84a                	sd	s2,16(sp)
ffffffffc020458a:	e44e                	sd	s3,8(sp)
ffffffffc020458c:	e052                	sd	s4,0(sp)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020458e:	100027f3          	csrr	a5,sstatus
ffffffffc0204592:	8b89                	andi	a5,a5,2
ffffffffc0204594:	4a01                	li	s4,0
ffffffffc0204596:	ebdd                	bnez	a5,ffffffffc020464c <schedule+0xcc>
    bool intr_flag;
    struct proc_struct *next;
    local_intr_save(intr_flag);
    {
        current->need_resched = 0;
ffffffffc0204598:	0002f497          	auipc	s1,0x2f
ffffffffc020459c:	74848493          	addi	s1,s1,1864 # ffffffffc0233ce0 <current>
ffffffffc02045a0:	608c                	ld	a1,0(s1)
ffffffffc02045a2:	0002f997          	auipc	s3,0x2f
ffffffffc02045a6:	76698993          	addi	s3,s3,1894 # ffffffffc0233d08 <sched_class>
ffffffffc02045aa:	0002f917          	auipc	s2,0x2f
ffffffffc02045ae:	75690913          	addi	s2,s2,1878 # ffffffffc0233d00 <rq>
        if (current->state == PROC_RUNNABLE) {
ffffffffc02045b2:	4194                	lw	a3,0(a1)
        current->need_resched = 0;
ffffffffc02045b4:	0005bc23          	sd	zero,24(a1)
        if (current->state == PROC_RUNNABLE) {
ffffffffc02045b8:	4709                	li	a4,2
ffffffffc02045ba:	0009b783          	ld	a5,0(s3)
ffffffffc02045be:	00093503          	ld	a0,0(s2)
ffffffffc02045c2:	04e68763          	beq	a3,a4,ffffffffc0204610 <schedule+0x90>
    return sched_class->pick_next(rq);
ffffffffc02045c6:	739c                	ld	a5,32(a5)
ffffffffc02045c8:	9782                	jalr	a5
ffffffffc02045ca:	842a                	mv	s0,a0
            sched_class_enqueue(current);
        }
        if ((next = sched_class_pick_next()) != NULL) {
ffffffffc02045cc:	c135                	beqz	a0,ffffffffc0204630 <schedule+0xb0>
    sched_class->dequeue(rq, proc);
ffffffffc02045ce:	0009b783          	ld	a5,0(s3)
ffffffffc02045d2:	00093503          	ld	a0,0(s2)
ffffffffc02045d6:	85a2                	mv	a1,s0
ffffffffc02045d8:	6f9c                	ld	a5,24(a5)
ffffffffc02045da:	9782                	jalr	a5
            sched_class_dequeue(next);
        }
        if (next == NULL) {
            next = idleproc;
        }
        next->runs ++;
ffffffffc02045dc:	441c                	lw	a5,8(s0)
        if (next != current) {
ffffffffc02045de:	6098                	ld	a4,0(s1)
        next->runs ++;
ffffffffc02045e0:	2785                	addiw	a5,a5,1
ffffffffc02045e2:	c41c                	sw	a5,8(s0)
        if (next != current) {
ffffffffc02045e4:	00870c63          	beq	a4,s0,ffffffffc02045fc <schedule+0x7c>
            cprintf("The next proc is pid:%d\n",next->pid);
ffffffffc02045e8:	404c                	lw	a1,4(s0)
ffffffffc02045ea:	00002517          	auipc	a0,0x2
ffffffffc02045ee:	fe650513          	addi	a0,a0,-26 # ffffffffc02065d0 <default_pmm_manager+0x560>
ffffffffc02045f2:	ad7fb0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            proc_run(next);
ffffffffc02045f6:	8522                	mv	a0,s0
ffffffffc02045f8:	eb1fe0ef          	jal	ra,ffffffffc02034a8 <proc_run>
    if (flag) {
ffffffffc02045fc:	020a1f63          	bnez	s4,ffffffffc020463a <schedule+0xba>
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc0204600:	70a2                	ld	ra,40(sp)
ffffffffc0204602:	7402                	ld	s0,32(sp)
ffffffffc0204604:	64e2                	ld	s1,24(sp)
ffffffffc0204606:	6942                	ld	s2,16(sp)
ffffffffc0204608:	69a2                	ld	s3,8(sp)
ffffffffc020460a:	6a02                	ld	s4,0(sp)
ffffffffc020460c:	6145                	addi	sp,sp,48
ffffffffc020460e:	8082                	ret
    if (proc != idleproc) {
ffffffffc0204610:	0002f717          	auipc	a4,0x2f
ffffffffc0204614:	6d873703          	ld	a4,1752(a4) # ffffffffc0233ce8 <idleproc>
ffffffffc0204618:	fae587e3          	beq	a1,a4,ffffffffc02045c6 <schedule+0x46>
        sched_class->enqueue(rq, proc);
ffffffffc020461c:	6b9c                	ld	a5,16(a5)
ffffffffc020461e:	9782                	jalr	a5
ffffffffc0204620:	0009b783          	ld	a5,0(s3)
ffffffffc0204624:	00093503          	ld	a0,0(s2)
    return sched_class->pick_next(rq);
ffffffffc0204628:	739c                	ld	a5,32(a5)
ffffffffc020462a:	9782                	jalr	a5
ffffffffc020462c:	842a                	mv	s0,a0
        if ((next = sched_class_pick_next()) != NULL) {
ffffffffc020462e:	f145                	bnez	a0,ffffffffc02045ce <schedule+0x4e>
            next = idleproc;
ffffffffc0204630:	0002f417          	auipc	s0,0x2f
ffffffffc0204634:	6b843403          	ld	s0,1720(s0) # ffffffffc0233ce8 <idleproc>
ffffffffc0204638:	b755                	j	ffffffffc02045dc <schedule+0x5c>
}
ffffffffc020463a:	7402                	ld	s0,32(sp)
ffffffffc020463c:	70a2                	ld	ra,40(sp)
ffffffffc020463e:	64e2                	ld	s1,24(sp)
ffffffffc0204640:	6942                	ld	s2,16(sp)
ffffffffc0204642:	69a2                	ld	s3,8(sp)
ffffffffc0204644:	6a02                	ld	s4,0(sp)
ffffffffc0204646:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc0204648:	fe5fb06f          	j	ffffffffc020062c <intr_enable>
        intr_disable();
ffffffffc020464c:	fe7fb0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc0204650:	4a05                	li	s4,1
ffffffffc0204652:	b799                	j	ffffffffc0204598 <schedule+0x18>

ffffffffc0204654 <RR_init>:
ffffffffc0204654:	e508                	sd	a0,8(a0)
ffffffffc0204656:	e108                	sd	a0,0(a0)
#include <default_sched.h>

static void
RR_init(struct run_queue *rq) {
    list_init(&(rq->run_list));
    rq->proc_num = 0;
ffffffffc0204658:	00052823          	sw	zero,16(a0)
}
ffffffffc020465c:	8082                	ret

ffffffffc020465e <RR_enqueue>:
    __list_add(elm, listelm->prev, listelm);
ffffffffc020465e:	611c                	ld	a5,0(a0)

static void
RR_enqueue(struct run_queue *rq, struct proc_struct *proc) {
    list_add_before(&(rq->run_list), &(proc->run_link));
ffffffffc0204660:	11058713          	addi	a4,a1,272
    prev->next = next->prev = elm;
ffffffffc0204664:	e118                	sd	a4,0(a0)
    if (proc->time_slice == 0 || proc->time_slice > rq->max_time_slice) {
ffffffffc0204666:	1205a683          	lw	a3,288(a1)
ffffffffc020466a:	e798                	sd	a4,8(a5)
    elm->prev = prev;
ffffffffc020466c:	10f5b823          	sd	a5,272(a1)
    elm->next = next;
ffffffffc0204670:	10a5bc23          	sd	a0,280(a1)
ffffffffc0204674:	495c                	lw	a5,20(a0)
ffffffffc0204676:	c299                	beqz	a3,ffffffffc020467c <RR_enqueue+0x1e>
ffffffffc0204678:	00d7d463          	bge	a5,a3,ffffffffc0204680 <RR_enqueue+0x22>
        proc->time_slice = rq->max_time_slice;
ffffffffc020467c:	12f5a023          	sw	a5,288(a1)
    }
    proc->rq = rq;
    rq->proc_num ++;
ffffffffc0204680:	491c                	lw	a5,16(a0)
    proc->rq = rq;
ffffffffc0204682:	10a5b423          	sd	a0,264(a1)
    rq->proc_num ++;
ffffffffc0204686:	2785                	addiw	a5,a5,1
ffffffffc0204688:	c91c                	sw	a5,16(a0)
}
ffffffffc020468a:	8082                	ret

ffffffffc020468c <RR_pick_next>:
    return listelm->next;
ffffffffc020468c:	651c                	ld	a5,8(a0)
}

static struct proc_struct *
RR_pick_next(struct run_queue *rq) {
    list_entry_t *le = list_next(&(rq->run_list));
    if (le != &(rq->run_list)) {
ffffffffc020468e:	00f50563          	beq	a0,a5,ffffffffc0204698 <RR_pick_next+0xc>
        return le2proc(le, run_link);
ffffffffc0204692:	ef078513          	addi	a0,a5,-272
ffffffffc0204696:	8082                	ret
    }
    return NULL;
ffffffffc0204698:	4501                	li	a0,0
}
ffffffffc020469a:	8082                	ret

ffffffffc020469c <RR_proc_tick>:

static void
RR_proc_tick(struct run_queue *rq, struct proc_struct *proc) {
    if (proc->time_slice > 0) {
ffffffffc020469c:	1205a783          	lw	a5,288(a1)
ffffffffc02046a0:	00f05563          	blez	a5,ffffffffc02046aa <RR_proc_tick+0xe>
        proc->time_slice --;
ffffffffc02046a4:	37fd                	addiw	a5,a5,-1
ffffffffc02046a6:	12f5a023          	sw	a5,288(a1)
    }
    if (proc->time_slice == 0) {
ffffffffc02046aa:	e399                	bnez	a5,ffffffffc02046b0 <RR_proc_tick+0x14>
        proc->need_resched = 1;
ffffffffc02046ac:	4785                	li	a5,1
ffffffffc02046ae:	ed9c                	sd	a5,24(a1)
    }
}
ffffffffc02046b0:	8082                	ret

ffffffffc02046b2 <RR_dequeue>:
    return list->next == list;
ffffffffc02046b2:	1185b703          	ld	a4,280(a1)
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc02046b6:	11058793          	addi	a5,a1,272
ffffffffc02046ba:	02e78363          	beq	a5,a4,ffffffffc02046e0 <RR_dequeue+0x2e>
ffffffffc02046be:	1085b683          	ld	a3,264(a1)
ffffffffc02046c2:	00a69f63          	bne	a3,a0,ffffffffc02046e0 <RR_dequeue+0x2e>
    __list_del(listelm->prev, listelm->next);
ffffffffc02046c6:	1105b503          	ld	a0,272(a1)
    rq->proc_num --;
ffffffffc02046ca:	4a90                	lw	a2,16(a3)
    prev->next = next;
ffffffffc02046cc:	e518                	sd	a4,8(a0)
    next->prev = prev;
ffffffffc02046ce:	e308                	sd	a0,0(a4)
    elm->prev = elm->next = elm;
ffffffffc02046d0:	10f5bc23          	sd	a5,280(a1)
ffffffffc02046d4:	10f5b823          	sd	a5,272(a1)
ffffffffc02046d8:	fff6079b          	addiw	a5,a2,-1
ffffffffc02046dc:	ca9c                	sw	a5,16(a3)
ffffffffc02046de:	8082                	ret
RR_dequeue(struct run_queue *rq, struct proc_struct *proc) {
ffffffffc02046e0:	1141                	addi	sp,sp,-16
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc02046e2:	00002697          	auipc	a3,0x2
ffffffffc02046e6:	f0e68693          	addi	a3,a3,-242 # ffffffffc02065f0 <default_pmm_manager+0x580>
ffffffffc02046ea:	00001617          	auipc	a2,0x1
ffffffffc02046ee:	c4660613          	addi	a2,a2,-954 # ffffffffc0205330 <commands+0x408>
ffffffffc02046f2:	45e5                	li	a1,25
ffffffffc02046f4:	00002517          	auipc	a0,0x2
ffffffffc02046f8:	f3450513          	addi	a0,a0,-204 # ffffffffc0206628 <default_pmm_manager+0x5b8>
RR_dequeue(struct run_queue *rq, struct proc_struct *proc) {
ffffffffc02046fc:	e406                	sd	ra,8(sp)
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc02046fe:	b07fb0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0204702 <sys_getpid>:
    return do_kill(pid);
}

static int
sys_getpid(uint64_t arg[]) {
    return current->pid;
ffffffffc0204702:	0002f797          	auipc	a5,0x2f
ffffffffc0204706:	5de7b783          	ld	a5,1502(a5) # ffffffffc0233ce0 <current>
}
ffffffffc020470a:	43c8                	lw	a0,4(a5)
ffffffffc020470c:	8082                	ret

ffffffffc020470e <sys_gettime>:
    cputchar(c);
    return 0;
}

static int sys_gettime(uint64_t arg[]){
    return (int)ticks*10;
ffffffffc020470e:	0002f797          	auipc	a5,0x2f
ffffffffc0204712:	6027b783          	ld	a5,1538(a5) # ffffffffc0233d10 <ticks>
ffffffffc0204716:	0027951b          	slliw	a0,a5,0x2
ffffffffc020471a:	9d3d                	addw	a0,a0,a5
}
ffffffffc020471c:	0015151b          	slliw	a0,a0,0x1
ffffffffc0204720:	8082                	ret

ffffffffc0204722 <sys_putc>:
    cputchar(c);
ffffffffc0204722:	4108                	lw	a0,0(a0)
sys_putc(uint64_t arg[]) {
ffffffffc0204724:	1141                	addi	sp,sp,-16
ffffffffc0204726:	e406                	sd	ra,8(sp)
    cputchar(c);
ffffffffc0204728:	9d7fb0ef          	jal	ra,ffffffffc02000fe <cputchar>
}
ffffffffc020472c:	60a2                	ld	ra,8(sp)
ffffffffc020472e:	4501                	li	a0,0
ffffffffc0204730:	0141                	addi	sp,sp,16
ffffffffc0204732:	8082                	ret

ffffffffc0204734 <sys_kill>:
    return do_kill(pid);
ffffffffc0204734:	4108                	lw	a0,0(a0)
ffffffffc0204736:	b85ff06f          	j	ffffffffc02042ba <do_kill>

ffffffffc020473a <sys_yield>:
    return do_yield();
ffffffffc020473a:	b33ff06f          	j	ffffffffc020426c <do_yield>

ffffffffc020473e <sys_exec>:
    return do_execve(name, len, binary, size);
ffffffffc020473e:	6d14                	ld	a3,24(a0)
ffffffffc0204740:	6910                	ld	a2,16(a0)
ffffffffc0204742:	650c                	ld	a1,8(a0)
ffffffffc0204744:	6108                	ld	a0,0(a0)
ffffffffc0204746:	e3eff06f          	j	ffffffffc0203d84 <do_execve>

ffffffffc020474a <sys_wait>:
    return do_wait(pid, store);
ffffffffc020474a:	650c                	ld	a1,8(a0)
ffffffffc020474c:	4108                	lw	a0,0(a0)
ffffffffc020474e:	b2fff06f          	j	ffffffffc020427c <do_wait>

ffffffffc0204752 <sys_fork>:
    struct trapframe *tf = current->tf;
ffffffffc0204752:	0002f797          	auipc	a5,0x2f
ffffffffc0204756:	58e7b783          	ld	a5,1422(a5) # ffffffffc0233ce0 <current>
ffffffffc020475a:	73d0                	ld	a2,160(a5)
    return do_fork(0, stack, tf);
ffffffffc020475c:	4501                	li	a0,0
ffffffffc020475e:	6a0c                	ld	a1,16(a2)
ffffffffc0204760:	e0dfe06f          	j	ffffffffc020356c <do_fork>

ffffffffc0204764 <sys_exit>:
    return do_exit(error_code);
ffffffffc0204764:	4108                	lw	a0,0(a0)
ffffffffc0204766:	a1aff06f          	j	ffffffffc0203980 <do_exit>

ffffffffc020476a <syscall>:
};

#define NUM_SYSCALLS        ((sizeof(syscalls)) / (sizeof(syscalls[0])))

void
syscall(void) {
ffffffffc020476a:	715d                	addi	sp,sp,-80
ffffffffc020476c:	fc26                	sd	s1,56(sp)
    struct trapframe *tf = current->tf;
ffffffffc020476e:	0002f497          	auipc	s1,0x2f
ffffffffc0204772:	57248493          	addi	s1,s1,1394 # ffffffffc0233ce0 <current>
ffffffffc0204776:	6098                	ld	a4,0(s1)
syscall(void) {
ffffffffc0204778:	e0a2                	sd	s0,64(sp)
ffffffffc020477a:	f84a                	sd	s2,48(sp)
    struct trapframe *tf = current->tf;
ffffffffc020477c:	7340                	ld	s0,160(a4)
syscall(void) {
ffffffffc020477e:	e486                	sd	ra,72(sp)
    uint64_t arg[5];
    int num = tf->gpr.a0;
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc0204780:	47f9                	li	a5,30
    int num = tf->gpr.a0;
ffffffffc0204782:	05042903          	lw	s2,80(s0)
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc0204786:	0327ee63          	bltu	a5,s2,ffffffffc02047c2 <syscall+0x58>
        if (syscalls[num] != NULL) {
ffffffffc020478a:	00391713          	slli	a4,s2,0x3
ffffffffc020478e:	00002797          	auipc	a5,0x2
ffffffffc0204792:	f1278793          	addi	a5,a5,-238 # ffffffffc02066a0 <syscalls>
ffffffffc0204796:	97ba                	add	a5,a5,a4
ffffffffc0204798:	639c                	ld	a5,0(a5)
ffffffffc020479a:	c785                	beqz	a5,ffffffffc02047c2 <syscall+0x58>
            arg[0] = tf->gpr.a1;
ffffffffc020479c:	6c28                	ld	a0,88(s0)
            arg[1] = tf->gpr.a2;
ffffffffc020479e:	702c                	ld	a1,96(s0)
            arg[2] = tf->gpr.a3;
ffffffffc02047a0:	7430                	ld	a2,104(s0)
            arg[3] = tf->gpr.a4;
ffffffffc02047a2:	7834                	ld	a3,112(s0)
            arg[4] = tf->gpr.a5;
ffffffffc02047a4:	7c38                	ld	a4,120(s0)
            arg[0] = tf->gpr.a1;
ffffffffc02047a6:	e42a                	sd	a0,8(sp)
            arg[1] = tf->gpr.a2;
ffffffffc02047a8:	e82e                	sd	a1,16(sp)
            arg[2] = tf->gpr.a3;
ffffffffc02047aa:	ec32                	sd	a2,24(sp)
            arg[3] = tf->gpr.a4;
ffffffffc02047ac:	f036                	sd	a3,32(sp)
            arg[4] = tf->gpr.a5;
ffffffffc02047ae:	f43a                	sd	a4,40(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc02047b0:	0028                	addi	a0,sp,8
ffffffffc02047b2:	9782                	jalr	a5
        }
    }
    print_trapframe(tf);
    panic("undefined syscall %d, pid = %d, name = %s.\n",
            num, current->pid, current->name);
}
ffffffffc02047b4:	60a6                	ld	ra,72(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc02047b6:	e828                	sd	a0,80(s0)
}
ffffffffc02047b8:	6406                	ld	s0,64(sp)
ffffffffc02047ba:	74e2                	ld	s1,56(sp)
ffffffffc02047bc:	7942                	ld	s2,48(sp)
ffffffffc02047be:	6161                	addi	sp,sp,80
ffffffffc02047c0:	8082                	ret
    print_trapframe(tf);
ffffffffc02047c2:	8522                	mv	a0,s0
ffffffffc02047c4:	85cfc0ef          	jal	ra,ffffffffc0200820 <print_trapframe>
    panic("undefined syscall %d, pid = %d, name = %s.\n",
ffffffffc02047c8:	609c                	ld	a5,0(s1)
ffffffffc02047ca:	86ca                	mv	a3,s2
ffffffffc02047cc:	00002617          	auipc	a2,0x2
ffffffffc02047d0:	e8c60613          	addi	a2,a2,-372 # ffffffffc0206658 <default_pmm_manager+0x5e8>
ffffffffc02047d4:	43d8                	lw	a4,4(a5)
ffffffffc02047d6:	06100593          	li	a1,97
ffffffffc02047da:	0b478793          	addi	a5,a5,180
ffffffffc02047de:	00002517          	auipc	a0,0x2
ffffffffc02047e2:	eaa50513          	addi	a0,a0,-342 # ffffffffc0206688 <default_pmm_manager+0x618>
ffffffffc02047e6:	a1ffb0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02047ea <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc02047ea:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc02047ee:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc02047f0:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc02047f2:	cb81                	beqz	a5,ffffffffc0204802 <strlen+0x18>
        cnt ++;
ffffffffc02047f4:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc02047f6:	00a707b3          	add	a5,a4,a0
ffffffffc02047fa:	0007c783          	lbu	a5,0(a5)
ffffffffc02047fe:	fbfd                	bnez	a5,ffffffffc02047f4 <strlen+0xa>
ffffffffc0204800:	8082                	ret
    }
    return cnt;
}
ffffffffc0204802:	8082                	ret

ffffffffc0204804 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
ffffffffc0204804:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc0204806:	4501                	li	a0,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc0204808:	e589                	bnez	a1,ffffffffc0204812 <strnlen+0xe>
ffffffffc020480a:	a811                	j	ffffffffc020481e <strnlen+0x1a>
        cnt ++;
ffffffffc020480c:	0505                	addi	a0,a0,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc020480e:	00a58763          	beq	a1,a0,ffffffffc020481c <strnlen+0x18>
ffffffffc0204812:	00a707b3          	add	a5,a4,a0
ffffffffc0204816:	0007c783          	lbu	a5,0(a5)
ffffffffc020481a:	fbed                	bnez	a5,ffffffffc020480c <strnlen+0x8>
    }
    return cnt;
}
ffffffffc020481c:	8082                	ret
ffffffffc020481e:	8082                	ret

ffffffffc0204820 <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0204820:	00054783          	lbu	a5,0(a0)
ffffffffc0204824:	0005c703          	lbu	a4,0(a1)
ffffffffc0204828:	cb89                	beqz	a5,ffffffffc020483a <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc020482a:	0505                	addi	a0,a0,1
ffffffffc020482c:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc020482e:	fee789e3          	beq	a5,a4,ffffffffc0204820 <strcmp>
ffffffffc0204832:	0007851b          	sext.w	a0,a5
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc0204836:	9d19                	subw	a0,a0,a4
ffffffffc0204838:	8082                	ret
ffffffffc020483a:	4501                	li	a0,0
ffffffffc020483c:	bfed                	j	ffffffffc0204836 <strcmp+0x16>

ffffffffc020483e <strchr>:
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
ffffffffc020483e:	00054783          	lbu	a5,0(a0)
ffffffffc0204842:	c799                	beqz	a5,ffffffffc0204850 <strchr+0x12>
        if (*s == c) {
ffffffffc0204844:	00f58763          	beq	a1,a5,ffffffffc0204852 <strchr+0x14>
    while (*s != '\0') {
ffffffffc0204848:	00154783          	lbu	a5,1(a0)
            return (char *)s;
        }
        s ++;
ffffffffc020484c:	0505                	addi	a0,a0,1
    while (*s != '\0') {
ffffffffc020484e:	fbfd                	bnez	a5,ffffffffc0204844 <strchr+0x6>
    }
    return NULL;
ffffffffc0204850:	4501                	li	a0,0
}
ffffffffc0204852:	8082                	ret

ffffffffc0204854 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0204854:	ca01                	beqz	a2,ffffffffc0204864 <memset+0x10>
ffffffffc0204856:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc0204858:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc020485a:	0785                	addi	a5,a5,1
ffffffffc020485c:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc0204860:	fec79de3          	bne	a5,a2,ffffffffc020485a <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0204864:	8082                	ret

ffffffffc0204866 <memcpy>:
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
#else
    const char *s = src;
    char *d = dst;
    while (n -- > 0) {
ffffffffc0204866:	ca19                	beqz	a2,ffffffffc020487c <memcpy+0x16>
ffffffffc0204868:	962e                	add	a2,a2,a1
    char *d = dst;
ffffffffc020486a:	87aa                	mv	a5,a0
        *d ++ = *s ++;
ffffffffc020486c:	0005c703          	lbu	a4,0(a1)
ffffffffc0204870:	0585                	addi	a1,a1,1
ffffffffc0204872:	0785                	addi	a5,a5,1
ffffffffc0204874:	fee78fa3          	sb	a4,-1(a5)
    while (n -- > 0) {
ffffffffc0204878:	fec59ae3          	bne	a1,a2,ffffffffc020486c <memcpy+0x6>
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
ffffffffc020487c:	8082                	ret

ffffffffc020487e <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc020487e:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0204882:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc0204884:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0204888:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc020488a:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc020488e:	f022                	sd	s0,32(sp)
ffffffffc0204890:	ec26                	sd	s1,24(sp)
ffffffffc0204892:	e84a                	sd	s2,16(sp)
ffffffffc0204894:	f406                	sd	ra,40(sp)
ffffffffc0204896:	e44e                	sd	s3,8(sp)
ffffffffc0204898:	84aa                	mv	s1,a0
ffffffffc020489a:	892e                	mv	s2,a1
ffffffffc020489c:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc02048a0:	2a01                	sext.w	s4,s4

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
ffffffffc02048a2:	03067e63          	bgeu	a2,a6,ffffffffc02048de <printnum+0x60>
ffffffffc02048a6:	89be                	mv	s3,a5
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc02048a8:	00805763          	blez	s0,ffffffffc02048b6 <printnum+0x38>
ffffffffc02048ac:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc02048ae:	85ca                	mv	a1,s2
ffffffffc02048b0:	854e                	mv	a0,s3
ffffffffc02048b2:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc02048b4:	fc65                	bnez	s0,ffffffffc02048ac <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02048b6:	1a02                	slli	s4,s4,0x20
ffffffffc02048b8:	020a5a13          	srli	s4,s4,0x20
ffffffffc02048bc:	00002797          	auipc	a5,0x2
ffffffffc02048c0:	edc78793          	addi	a5,a5,-292 # ffffffffc0206798 <syscalls+0xf8>
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
ffffffffc02048c4:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02048c6:	9a3e                	add	s4,s4,a5
ffffffffc02048c8:	000a4503          	lbu	a0,0(s4)
}
ffffffffc02048cc:	70a2                	ld	ra,40(sp)
ffffffffc02048ce:	69a2                	ld	s3,8(sp)
ffffffffc02048d0:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02048d2:	85ca                	mv	a1,s2
ffffffffc02048d4:	8326                	mv	t1,s1
}
ffffffffc02048d6:	6942                	ld	s2,16(sp)
ffffffffc02048d8:	64e2                	ld	s1,24(sp)
ffffffffc02048da:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02048dc:	8302                	jr	t1
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc02048de:	03065633          	divu	a2,a2,a6
ffffffffc02048e2:	8722                	mv	a4,s0
ffffffffc02048e4:	f9bff0ef          	jal	ra,ffffffffc020487e <printnum>
ffffffffc02048e8:	b7f9                	j	ffffffffc02048b6 <printnum+0x38>

ffffffffc02048ea <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc02048ea:	7119                	addi	sp,sp,-128
ffffffffc02048ec:	f4a6                	sd	s1,104(sp)
ffffffffc02048ee:	f0ca                	sd	s2,96(sp)
ffffffffc02048f0:	ecce                	sd	s3,88(sp)
ffffffffc02048f2:	e8d2                	sd	s4,80(sp)
ffffffffc02048f4:	e4d6                	sd	s5,72(sp)
ffffffffc02048f6:	e0da                	sd	s6,64(sp)
ffffffffc02048f8:	fc5e                	sd	s7,56(sp)
ffffffffc02048fa:	f06a                	sd	s10,32(sp)
ffffffffc02048fc:	fc86                	sd	ra,120(sp)
ffffffffc02048fe:	f8a2                	sd	s0,112(sp)
ffffffffc0204900:	f862                	sd	s8,48(sp)
ffffffffc0204902:	f466                	sd	s9,40(sp)
ffffffffc0204904:	ec6e                	sd	s11,24(sp)
ffffffffc0204906:	892a                	mv	s2,a0
ffffffffc0204908:	84ae                	mv	s1,a1
ffffffffc020490a:	8d32                	mv	s10,a2
ffffffffc020490c:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc020490e:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc0204912:	5b7d                	li	s6,-1
ffffffffc0204914:	00002a97          	auipc	s5,0x2
ffffffffc0204918:	eb0a8a93          	addi	s5,s5,-336 # ffffffffc02067c4 <syscalls+0x124>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc020491c:	00002b97          	auipc	s7,0x2
ffffffffc0204920:	0c4b8b93          	addi	s7,s7,196 # ffffffffc02069e0 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0204924:	000d4503          	lbu	a0,0(s10)
ffffffffc0204928:	001d0413          	addi	s0,s10,1
ffffffffc020492c:	01350a63          	beq	a0,s3,ffffffffc0204940 <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc0204930:	c121                	beqz	a0,ffffffffc0204970 <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc0204932:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0204934:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc0204936:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0204938:	fff44503          	lbu	a0,-1(s0)
ffffffffc020493c:	ff351ae3          	bne	a0,s3,ffffffffc0204930 <vprintfmt+0x46>
ffffffffc0204940:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc0204944:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc0204948:	4c81                	li	s9,0
ffffffffc020494a:	4881                	li	a7,0
        width = precision = -1;
ffffffffc020494c:	5c7d                	li	s8,-1
ffffffffc020494e:	5dfd                	li	s11,-1
ffffffffc0204950:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc0204954:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204956:	fdd6059b          	addiw	a1,a2,-35
ffffffffc020495a:	0ff5f593          	andi	a1,a1,255
ffffffffc020495e:	00140d13          	addi	s10,s0,1
ffffffffc0204962:	04b56263          	bltu	a0,a1,ffffffffc02049a6 <vprintfmt+0xbc>
ffffffffc0204966:	058a                	slli	a1,a1,0x2
ffffffffc0204968:	95d6                	add	a1,a1,s5
ffffffffc020496a:	4194                	lw	a3,0(a1)
ffffffffc020496c:	96d6                	add	a3,a3,s5
ffffffffc020496e:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc0204970:	70e6                	ld	ra,120(sp)
ffffffffc0204972:	7446                	ld	s0,112(sp)
ffffffffc0204974:	74a6                	ld	s1,104(sp)
ffffffffc0204976:	7906                	ld	s2,96(sp)
ffffffffc0204978:	69e6                	ld	s3,88(sp)
ffffffffc020497a:	6a46                	ld	s4,80(sp)
ffffffffc020497c:	6aa6                	ld	s5,72(sp)
ffffffffc020497e:	6b06                	ld	s6,64(sp)
ffffffffc0204980:	7be2                	ld	s7,56(sp)
ffffffffc0204982:	7c42                	ld	s8,48(sp)
ffffffffc0204984:	7ca2                	ld	s9,40(sp)
ffffffffc0204986:	7d02                	ld	s10,32(sp)
ffffffffc0204988:	6de2                	ld	s11,24(sp)
ffffffffc020498a:	6109                	addi	sp,sp,128
ffffffffc020498c:	8082                	ret
            padc = '0';
ffffffffc020498e:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc0204990:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204994:	846a                	mv	s0,s10
ffffffffc0204996:	00140d13          	addi	s10,s0,1
ffffffffc020499a:	fdd6059b          	addiw	a1,a2,-35
ffffffffc020499e:	0ff5f593          	andi	a1,a1,255
ffffffffc02049a2:	fcb572e3          	bgeu	a0,a1,ffffffffc0204966 <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc02049a6:	85a6                	mv	a1,s1
ffffffffc02049a8:	02500513          	li	a0,37
ffffffffc02049ac:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc02049ae:	fff44783          	lbu	a5,-1(s0)
ffffffffc02049b2:	8d22                	mv	s10,s0
ffffffffc02049b4:	f73788e3          	beq	a5,s3,ffffffffc0204924 <vprintfmt+0x3a>
ffffffffc02049b8:	ffed4783          	lbu	a5,-2(s10)
ffffffffc02049bc:	1d7d                	addi	s10,s10,-1
ffffffffc02049be:	ff379de3          	bne	a5,s3,ffffffffc02049b8 <vprintfmt+0xce>
ffffffffc02049c2:	b78d                	j	ffffffffc0204924 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc02049c4:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc02049c8:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02049cc:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc02049ce:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc02049d2:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc02049d6:	02d86463          	bltu	a6,a3,ffffffffc02049fe <vprintfmt+0x114>
                ch = *fmt;
ffffffffc02049da:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc02049de:	002c169b          	slliw	a3,s8,0x2
ffffffffc02049e2:	0186873b          	addw	a4,a3,s8
ffffffffc02049e6:	0017171b          	slliw	a4,a4,0x1
ffffffffc02049ea:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc02049ec:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc02049f0:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc02049f2:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc02049f6:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc02049fa:	fed870e3          	bgeu	a6,a3,ffffffffc02049da <vprintfmt+0xf0>
            if (width < 0)
ffffffffc02049fe:	f40ddce3          	bgez	s11,ffffffffc0204956 <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0204a02:	8de2                	mv	s11,s8
ffffffffc0204a04:	5c7d                	li	s8,-1
ffffffffc0204a06:	bf81                	j	ffffffffc0204956 <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0204a08:	fffdc693          	not	a3,s11
ffffffffc0204a0c:	96fd                	srai	a3,a3,0x3f
ffffffffc0204a0e:	00ddfdb3          	and	s11,s11,a3
ffffffffc0204a12:	00144603          	lbu	a2,1(s0)
ffffffffc0204a16:	2d81                	sext.w	s11,s11
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204a18:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0204a1a:	bf35                	j	ffffffffc0204956 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0204a1c:	000a2c03          	lw	s8,0(s4)
            goto process_precision;
ffffffffc0204a20:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0204a24:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204a26:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0204a28:	bfd9                	j	ffffffffc02049fe <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0204a2a:	4705                	li	a4,1
ffffffffc0204a2c:	008a0593          	addi	a1,s4,8
ffffffffc0204a30:	01174463          	blt	a4,a7,ffffffffc0204a38 <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc0204a34:	1a088e63          	beqz	a7,ffffffffc0204bf0 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc0204a38:	000a3603          	ld	a2,0(s4)
ffffffffc0204a3c:	46c1                	li	a3,16
ffffffffc0204a3e:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc0204a40:	2781                	sext.w	a5,a5
ffffffffc0204a42:	876e                	mv	a4,s11
ffffffffc0204a44:	85a6                	mv	a1,s1
ffffffffc0204a46:	854a                	mv	a0,s2
ffffffffc0204a48:	e37ff0ef          	jal	ra,ffffffffc020487e <printnum>
            break;
ffffffffc0204a4c:	bde1                	j	ffffffffc0204924 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc0204a4e:	000a2503          	lw	a0,0(s4)
ffffffffc0204a52:	85a6                	mv	a1,s1
ffffffffc0204a54:	0a21                	addi	s4,s4,8
ffffffffc0204a56:	9902                	jalr	s2
            break;
ffffffffc0204a58:	b5f1                	j	ffffffffc0204924 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0204a5a:	4705                	li	a4,1
ffffffffc0204a5c:	008a0593          	addi	a1,s4,8
ffffffffc0204a60:	01174463          	blt	a4,a7,ffffffffc0204a68 <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc0204a64:	18088163          	beqz	a7,ffffffffc0204be6 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc0204a68:	000a3603          	ld	a2,0(s4)
ffffffffc0204a6c:	46a9                	li	a3,10
ffffffffc0204a6e:	8a2e                	mv	s4,a1
ffffffffc0204a70:	bfc1                	j	ffffffffc0204a40 <vprintfmt+0x156>
            goto reswitch;
ffffffffc0204a72:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc0204a76:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204a78:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0204a7a:	bdf1                	j	ffffffffc0204956 <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc0204a7c:	85a6                	mv	a1,s1
ffffffffc0204a7e:	02500513          	li	a0,37
ffffffffc0204a82:	9902                	jalr	s2
            break;
ffffffffc0204a84:	b545                	j	ffffffffc0204924 <vprintfmt+0x3a>
            lflag ++;
ffffffffc0204a86:	00144603          	lbu	a2,1(s0)
ffffffffc0204a8a:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204a8c:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0204a8e:	b5e1                	j	ffffffffc0204956 <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc0204a90:	4705                	li	a4,1
ffffffffc0204a92:	008a0593          	addi	a1,s4,8
ffffffffc0204a96:	01174463          	blt	a4,a7,ffffffffc0204a9e <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0204a9a:	14088163          	beqz	a7,ffffffffc0204bdc <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0204a9e:	000a3603          	ld	a2,0(s4)
ffffffffc0204aa2:	46a1                	li	a3,8
ffffffffc0204aa4:	8a2e                	mv	s4,a1
ffffffffc0204aa6:	bf69                	j	ffffffffc0204a40 <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc0204aa8:	03000513          	li	a0,48
ffffffffc0204aac:	85a6                	mv	a1,s1
ffffffffc0204aae:	e03e                	sd	a5,0(sp)
ffffffffc0204ab0:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc0204ab2:	85a6                	mv	a1,s1
ffffffffc0204ab4:	07800513          	li	a0,120
ffffffffc0204ab8:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0204aba:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0204abc:	6782                	ld	a5,0(sp)
ffffffffc0204abe:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0204ac0:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc0204ac4:	bfb5                	j	ffffffffc0204a40 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0204ac6:	000a3403          	ld	s0,0(s4)
ffffffffc0204aca:	008a0713          	addi	a4,s4,8
ffffffffc0204ace:	e03a                	sd	a4,0(sp)
ffffffffc0204ad0:	14040263          	beqz	s0,ffffffffc0204c14 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc0204ad4:	0fb05763          	blez	s11,ffffffffc0204bc2 <vprintfmt+0x2d8>
ffffffffc0204ad8:	02d00693          	li	a3,45
ffffffffc0204adc:	0cd79163          	bne	a5,a3,ffffffffc0204b9e <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204ae0:	00044783          	lbu	a5,0(s0)
ffffffffc0204ae4:	0007851b          	sext.w	a0,a5
ffffffffc0204ae8:	cf85                	beqz	a5,ffffffffc0204b20 <vprintfmt+0x236>
ffffffffc0204aea:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204aee:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204af2:	000c4563          	bltz	s8,ffffffffc0204afc <vprintfmt+0x212>
ffffffffc0204af6:	3c7d                	addiw	s8,s8,-1
ffffffffc0204af8:	036c0263          	beq	s8,s6,ffffffffc0204b1c <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0204afc:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204afe:	0e0c8e63          	beqz	s9,ffffffffc0204bfa <vprintfmt+0x310>
ffffffffc0204b02:	3781                	addiw	a5,a5,-32
ffffffffc0204b04:	0ef47b63          	bgeu	s0,a5,ffffffffc0204bfa <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0204b08:	03f00513          	li	a0,63
ffffffffc0204b0c:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204b0e:	000a4783          	lbu	a5,0(s4)
ffffffffc0204b12:	3dfd                	addiw	s11,s11,-1
ffffffffc0204b14:	0a05                	addi	s4,s4,1
ffffffffc0204b16:	0007851b          	sext.w	a0,a5
ffffffffc0204b1a:	ffe1                	bnez	a5,ffffffffc0204af2 <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0204b1c:	01b05963          	blez	s11,ffffffffc0204b2e <vprintfmt+0x244>
ffffffffc0204b20:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc0204b22:	85a6                	mv	a1,s1
ffffffffc0204b24:	02000513          	li	a0,32
ffffffffc0204b28:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0204b2a:	fe0d9be3          	bnez	s11,ffffffffc0204b20 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0204b2e:	6a02                	ld	s4,0(sp)
ffffffffc0204b30:	bbd5                	j	ffffffffc0204924 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0204b32:	4705                	li	a4,1
ffffffffc0204b34:	008a0c93          	addi	s9,s4,8
ffffffffc0204b38:	01174463          	blt	a4,a7,ffffffffc0204b40 <vprintfmt+0x256>
    else if (lflag) {
ffffffffc0204b3c:	08088d63          	beqz	a7,ffffffffc0204bd6 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc0204b40:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc0204b44:	0a044d63          	bltz	s0,ffffffffc0204bfe <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc0204b48:	8622                	mv	a2,s0
ffffffffc0204b4a:	8a66                	mv	s4,s9
ffffffffc0204b4c:	46a9                	li	a3,10
ffffffffc0204b4e:	bdcd                	j	ffffffffc0204a40 <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc0204b50:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0204b54:	4761                	li	a4,24
            err = va_arg(ap, int);
ffffffffc0204b56:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc0204b58:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0204b5c:	8fb5                	xor	a5,a5,a3
ffffffffc0204b5e:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0204b62:	02d74163          	blt	a4,a3,ffffffffc0204b84 <vprintfmt+0x29a>
ffffffffc0204b66:	00369793          	slli	a5,a3,0x3
ffffffffc0204b6a:	97de                	add	a5,a5,s7
ffffffffc0204b6c:	639c                	ld	a5,0(a5)
ffffffffc0204b6e:	cb99                	beqz	a5,ffffffffc0204b84 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc0204b70:	86be                	mv	a3,a5
ffffffffc0204b72:	00000617          	auipc	a2,0x0
ffffffffc0204b76:	13660613          	addi	a2,a2,310 # ffffffffc0204ca8 <etext+0x26>
ffffffffc0204b7a:	85a6                	mv	a1,s1
ffffffffc0204b7c:	854a                	mv	a0,s2
ffffffffc0204b7e:	0ce000ef          	jal	ra,ffffffffc0204c4c <printfmt>
ffffffffc0204b82:	b34d                	j	ffffffffc0204924 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc0204b84:	00002617          	auipc	a2,0x2
ffffffffc0204b88:	c3460613          	addi	a2,a2,-972 # ffffffffc02067b8 <syscalls+0x118>
ffffffffc0204b8c:	85a6                	mv	a1,s1
ffffffffc0204b8e:	854a                	mv	a0,s2
ffffffffc0204b90:	0bc000ef          	jal	ra,ffffffffc0204c4c <printfmt>
ffffffffc0204b94:	bb41                	j	ffffffffc0204924 <vprintfmt+0x3a>
                p = "(null)";
ffffffffc0204b96:	00002417          	auipc	s0,0x2
ffffffffc0204b9a:	c1a40413          	addi	s0,s0,-998 # ffffffffc02067b0 <syscalls+0x110>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0204b9e:	85e2                	mv	a1,s8
ffffffffc0204ba0:	8522                	mv	a0,s0
ffffffffc0204ba2:	e43e                	sd	a5,8(sp)
ffffffffc0204ba4:	c61ff0ef          	jal	ra,ffffffffc0204804 <strnlen>
ffffffffc0204ba8:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0204bac:	01b05b63          	blez	s11,ffffffffc0204bc2 <vprintfmt+0x2d8>
ffffffffc0204bb0:	67a2                	ld	a5,8(sp)
ffffffffc0204bb2:	00078a1b          	sext.w	s4,a5
ffffffffc0204bb6:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc0204bb8:	85a6                	mv	a1,s1
ffffffffc0204bba:	8552                	mv	a0,s4
ffffffffc0204bbc:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0204bbe:	fe0d9ce3          	bnez	s11,ffffffffc0204bb6 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204bc2:	00044783          	lbu	a5,0(s0)
ffffffffc0204bc6:	00140a13          	addi	s4,s0,1
ffffffffc0204bca:	0007851b          	sext.w	a0,a5
ffffffffc0204bce:	d3a5                	beqz	a5,ffffffffc0204b2e <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204bd0:	05e00413          	li	s0,94
ffffffffc0204bd4:	bf39                	j	ffffffffc0204af2 <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc0204bd6:	000a2403          	lw	s0,0(s4)
ffffffffc0204bda:	b7ad                	j	ffffffffc0204b44 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc0204bdc:	000a6603          	lwu	a2,0(s4)
ffffffffc0204be0:	46a1                	li	a3,8
ffffffffc0204be2:	8a2e                	mv	s4,a1
ffffffffc0204be4:	bdb1                	j	ffffffffc0204a40 <vprintfmt+0x156>
ffffffffc0204be6:	000a6603          	lwu	a2,0(s4)
ffffffffc0204bea:	46a9                	li	a3,10
ffffffffc0204bec:	8a2e                	mv	s4,a1
ffffffffc0204bee:	bd89                	j	ffffffffc0204a40 <vprintfmt+0x156>
ffffffffc0204bf0:	000a6603          	lwu	a2,0(s4)
ffffffffc0204bf4:	46c1                	li	a3,16
ffffffffc0204bf6:	8a2e                	mv	s4,a1
ffffffffc0204bf8:	b5a1                	j	ffffffffc0204a40 <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0204bfa:	9902                	jalr	s2
ffffffffc0204bfc:	bf09                	j	ffffffffc0204b0e <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0204bfe:	85a6                	mv	a1,s1
ffffffffc0204c00:	02d00513          	li	a0,45
ffffffffc0204c04:	e03e                	sd	a5,0(sp)
ffffffffc0204c06:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0204c08:	6782                	ld	a5,0(sp)
ffffffffc0204c0a:	8a66                	mv	s4,s9
ffffffffc0204c0c:	40800633          	neg	a2,s0
ffffffffc0204c10:	46a9                	li	a3,10
ffffffffc0204c12:	b53d                	j	ffffffffc0204a40 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc0204c14:	03b05163          	blez	s11,ffffffffc0204c36 <vprintfmt+0x34c>
ffffffffc0204c18:	02d00693          	li	a3,45
ffffffffc0204c1c:	f6d79de3          	bne	a5,a3,ffffffffc0204b96 <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0204c20:	00002417          	auipc	s0,0x2
ffffffffc0204c24:	b9040413          	addi	s0,s0,-1136 # ffffffffc02067b0 <syscalls+0x110>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204c28:	02800793          	li	a5,40
ffffffffc0204c2c:	02800513          	li	a0,40
ffffffffc0204c30:	00140a13          	addi	s4,s0,1
ffffffffc0204c34:	bd6d                	j	ffffffffc0204aee <vprintfmt+0x204>
ffffffffc0204c36:	00002a17          	auipc	s4,0x2
ffffffffc0204c3a:	b7ba0a13          	addi	s4,s4,-1157 # ffffffffc02067b1 <syscalls+0x111>
ffffffffc0204c3e:	02800513          	li	a0,40
ffffffffc0204c42:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204c46:	05e00413          	li	s0,94
ffffffffc0204c4a:	b565                	j	ffffffffc0204af2 <vprintfmt+0x208>

ffffffffc0204c4c <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0204c4c:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc0204c4e:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0204c52:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0204c54:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0204c56:	ec06                	sd	ra,24(sp)
ffffffffc0204c58:	f83a                	sd	a4,48(sp)
ffffffffc0204c5a:	fc3e                	sd	a5,56(sp)
ffffffffc0204c5c:	e0c2                	sd	a6,64(sp)
ffffffffc0204c5e:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc0204c60:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0204c62:	c89ff0ef          	jal	ra,ffffffffc02048ea <vprintfmt>
}
ffffffffc0204c66:	60e2                	ld	ra,24(sp)
ffffffffc0204c68:	6161                	addi	sp,sp,80
ffffffffc0204c6a:	8082                	ret

ffffffffc0204c6c <hash32>:
 *
 * High bits are more random, so we use them.
 * */
uint32_t
hash32(uint32_t val, unsigned int bits) {
    uint32_t hash = val * GOLDEN_RATIO_PRIME_32;
ffffffffc0204c6c:	9e3707b7          	lui	a5,0x9e370
ffffffffc0204c70:	2785                	addiw	a5,a5,1
ffffffffc0204c72:	02a7853b          	mulw	a0,a5,a0
    return (hash >> (32 - bits));
ffffffffc0204c76:	02000793          	li	a5,32
ffffffffc0204c7a:	9f8d                	subw	a5,a5,a1
}
ffffffffc0204c7c:	00f5553b          	srlw	a0,a0,a5
ffffffffc0204c80:	8082                	ret
