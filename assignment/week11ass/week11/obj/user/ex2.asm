
obj/__user_ex2.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <__panic>:
#include <stdio.h>
#include <ulib.h>
#include <error.h>

void
__panic(const char *file, int line, const char *fmt, ...) {
  800020:	715d                	addi	sp,sp,-80
  800022:	8e2e                	mv	t3,a1
  800024:	e822                	sd	s0,16(sp)
    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
    cprintf("user panic at %s:%d:\n    ", file, line);
  800026:	85aa                	mv	a1,a0
__panic(const char *file, int line, const char *fmt, ...) {
  800028:	8432                	mv	s0,a2
  80002a:	fc3e                	sd	a5,56(sp)
    cprintf("user panic at %s:%d:\n    ", file, line);
  80002c:	8672                	mv	a2,t3
    va_start(ap, fmt);
  80002e:	103c                	addi	a5,sp,40
    cprintf("user panic at %s:%d:\n    ", file, line);
  800030:	00000517          	auipc	a0,0x0
  800034:	6a050513          	addi	a0,a0,1696 # 8006d0 <main+0x148>
__panic(const char *file, int line, const char *fmt, ...) {
  800038:	ec06                	sd	ra,24(sp)
  80003a:	f436                	sd	a3,40(sp)
  80003c:	f83a                	sd	a4,48(sp)
  80003e:	e0c2                	sd	a6,64(sp)
  800040:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  800042:	e43e                	sd	a5,8(sp)
    cprintf("user panic at %s:%d:\n    ", file, line);
  800044:	0e6000ef          	jal	ra,80012a <cprintf>
    vcprintf(fmt, ap);
  800048:	65a2                	ld	a1,8(sp)
  80004a:	8522                	mv	a0,s0
  80004c:	0be000ef          	jal	ra,80010a <vcprintf>
    cprintf("\n");
  800050:	00000517          	auipc	a0,0x0
  800054:	6a050513          	addi	a0,a0,1696 # 8006f0 <main+0x168>
  800058:	0d2000ef          	jal	ra,80012a <cprintf>
    va_end(ap);
    exit(-E_PANIC);
  80005c:	5559                	li	a0,-10
  80005e:	06a000ef          	jal	ra,8000c8 <exit>

0000000000800062 <syscall>:
#include <syscall.h>

#define MAX_ARGS            5

static inline int
syscall(int64_t num, ...) {
  800062:	7175                	addi	sp,sp,-144
  800064:	f8ba                	sd	a4,112(sp)
    va_list ap;
    va_start(ap, num);
    uint64_t a[MAX_ARGS];
    int i, ret;
    for (i = 0; i < MAX_ARGS; i ++) {
        a[i] = va_arg(ap, uint64_t);
  800066:	e0ba                	sd	a4,64(sp)
  800068:	0118                	addi	a4,sp,128
syscall(int64_t num, ...) {
  80006a:	e42a                	sd	a0,8(sp)
  80006c:	ecae                	sd	a1,88(sp)
  80006e:	f0b2                	sd	a2,96(sp)
  800070:	f4b6                	sd	a3,104(sp)
  800072:	fcbe                	sd	a5,120(sp)
  800074:	e142                	sd	a6,128(sp)
  800076:	e546                	sd	a7,136(sp)
        a[i] = va_arg(ap, uint64_t);
  800078:	f42e                	sd	a1,40(sp)
  80007a:	f832                	sd	a2,48(sp)
  80007c:	fc36                	sd	a3,56(sp)
  80007e:	f03a                	sd	a4,32(sp)
  800080:	e4be                	sd	a5,72(sp)
    }
    va_end(ap);
    asm volatile (
  800082:	4522                	lw	a0,8(sp)
  800084:	55a2                	lw	a1,40(sp)
  800086:	5642                	lw	a2,48(sp)
  800088:	56e2                	lw	a3,56(sp)
  80008a:	4706                	lw	a4,64(sp)
  80008c:	47a6                	lw	a5,72(sp)
  80008e:	00000073          	ecall
  800092:	ce2a                	sw	a0,28(sp)
          "m" (a[3]),
          "m" (a[4])
        : "memory"
      );
    return ret;
}
  800094:	4572                	lw	a0,28(sp)
  800096:	6149                	addi	sp,sp,144
  800098:	8082                	ret

000000000080009a <sys_exit>:

int
sys_exit(int64_t error_code) {
  80009a:	85aa                	mv	a1,a0
    return syscall(SYS_exit, error_code);
  80009c:	4505                	li	a0,1
  80009e:	b7d1                	j	800062 <syscall>

00000000008000a0 <sys_fork>:
}

int
sys_fork(void) {
    return syscall(SYS_fork);
  8000a0:	4509                	li	a0,2
  8000a2:	b7c1                	j	800062 <syscall>

00000000008000a4 <sys_wait>:
}

int
sys_wait(int64_t pid, int *store) {
  8000a4:	862e                	mv	a2,a1
    return syscall(SYS_wait, pid, store);
  8000a6:	85aa                	mv	a1,a0
  8000a8:	450d                	li	a0,3
  8000aa:	bf65                	j	800062 <syscall>

00000000008000ac <sys_kill>:
sys_yield(void) {
    return syscall(SYS_yield);
}

int
sys_kill(int64_t pid) {
  8000ac:	85aa                	mv	a1,a0
    return syscall(SYS_kill, pid);
  8000ae:	4531                	li	a0,12
  8000b0:	bf4d                	j	800062 <syscall>

00000000008000b2 <sys_getpid>:
}

int
sys_getpid(void) {
    return syscall(SYS_getpid);
  8000b2:	4549                	li	a0,18
  8000b4:	b77d                	j	800062 <syscall>

00000000008000b6 <sys_putc>:
}

int
sys_putc(int64_t c) {
  8000b6:	85aa                	mv	a1,a0
    return syscall(SYS_putc, c);
  8000b8:	4579                	li	a0,30
  8000ba:	b765                	j	800062 <syscall>

00000000008000bc <sys_gettime>:
}

int
sys_gettime(void) {
    return syscall(SYS_gettime);
  8000bc:	4545                	li	a0,17
  8000be:	b755                	j	800062 <syscall>

00000000008000c0 <sys_setpriority>:
}

void
sys_setpriority(int priority) {
  8000c0:	85aa                	mv	a1,a0
    syscall(SYS_labschedule_set_priority, priority);
  8000c2:	0ff00513          	li	a0,255
  8000c6:	bf71                	j	800062 <syscall>

00000000008000c8 <exit>:
#include <syscall.h>
#include <stdio.h>
#include <ulib.h>

void
exit(int error_code) {
  8000c8:	1141                	addi	sp,sp,-16
  8000ca:	e406                	sd	ra,8(sp)
    //cprintf("eee\n");
    sys_exit(error_code);
  8000cc:	fcfff0ef          	jal	ra,80009a <sys_exit>
    cprintf("BUG: exit failed.\n");
  8000d0:	00000517          	auipc	a0,0x0
  8000d4:	62850513          	addi	a0,a0,1576 # 8006f8 <main+0x170>
  8000d8:	052000ef          	jal	ra,80012a <cprintf>
    while (1);
  8000dc:	a001                	j	8000dc <exit+0x14>

00000000008000de <fork>:
}

int
fork(void) {
    return sys_fork();
  8000de:	b7c9                	j	8000a0 <sys_fork>

00000000008000e0 <waitpid>:
    return sys_wait(0, NULL);
}

int
waitpid(int pid, int *store) {
    return sys_wait(pid, store);
  8000e0:	b7d1                	j	8000a4 <sys_wait>

00000000008000e2 <kill>:
    sys_yield();
}

int
kill(int pid) {
    return sys_kill(pid);
  8000e2:	b7e9                	j	8000ac <sys_kill>

00000000008000e4 <getpid>:
}

int
getpid(void) {
    return sys_getpid();
  8000e4:	b7f9                	j	8000b2 <sys_getpid>

00000000008000e6 <gettime_msec>:
}

unsigned int
gettime_msec(void) {
    return (unsigned int)sys_gettime();
  8000e6:	bfd9                	j	8000bc <sys_gettime>

00000000008000e8 <set_priority>:
}

void
set_priority(int priority) {
    sys_setpriority(priority);
  8000e8:	bfe1                	j	8000c0 <sys_setpriority>

00000000008000ea <_start>:
    # move down the esp register
    # since it may cause page fault in backtrace
    // subl $0x20, %esp

    # call user-program function
    call umain
  8000ea:	076000ef          	jal	ra,800160 <umain>
1:  j 1b
  8000ee:	a001                	j	8000ee <_start+0x4>

00000000008000f0 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  8000f0:	1141                	addi	sp,sp,-16
  8000f2:	e022                	sd	s0,0(sp)
  8000f4:	e406                	sd	ra,8(sp)
  8000f6:	842e                	mv	s0,a1
    sys_putc(c);
  8000f8:	fbfff0ef          	jal	ra,8000b6 <sys_putc>
    (*cnt) ++;
  8000fc:	401c                	lw	a5,0(s0)
}
  8000fe:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
  800100:	2785                	addiw	a5,a5,1
  800102:	c01c                	sw	a5,0(s0)
}
  800104:	6402                	ld	s0,0(sp)
  800106:	0141                	addi	sp,sp,16
  800108:	8082                	ret

000000000080010a <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  80010a:	1101                	addi	sp,sp,-32
  80010c:	862a                	mv	a2,a0
  80010e:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  800110:	00000517          	auipc	a0,0x0
  800114:	fe050513          	addi	a0,a0,-32 # 8000f0 <cputch>
  800118:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
  80011a:	ec06                	sd	ra,24(sp)
    int cnt = 0;
  80011c:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  80011e:	0e8000ef          	jal	ra,800206 <vprintfmt>
    return cnt;
}
  800122:	60e2                	ld	ra,24(sp)
  800124:	4532                	lw	a0,12(sp)
  800126:	6105                	addi	sp,sp,32
  800128:	8082                	ret

000000000080012a <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  80012a:	711d                	addi	sp,sp,-96
    va_list ap;

    va_start(ap, fmt);
  80012c:	02810313          	addi	t1,sp,40
cprintf(const char *fmt, ...) {
  800130:	8e2a                	mv	t3,a0
  800132:	f42e                	sd	a1,40(sp)
  800134:	f832                	sd	a2,48(sp)
  800136:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  800138:	00000517          	auipc	a0,0x0
  80013c:	fb850513          	addi	a0,a0,-72 # 8000f0 <cputch>
  800140:	004c                	addi	a1,sp,4
  800142:	869a                	mv	a3,t1
  800144:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
  800146:	ec06                	sd	ra,24(sp)
  800148:	e0ba                	sd	a4,64(sp)
  80014a:	e4be                	sd	a5,72(sp)
  80014c:	e8c2                	sd	a6,80(sp)
  80014e:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
  800150:	e41a                	sd	t1,8(sp)
    int cnt = 0;
  800152:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  800154:	0b2000ef          	jal	ra,800206 <vprintfmt>
    int cnt = vcprintf(fmt, ap);
    va_end(ap);

    return cnt;
}
  800158:	60e2                	ld	ra,24(sp)
  80015a:	4512                	lw	a0,4(sp)
  80015c:	6125                	addi	sp,sp,96
  80015e:	8082                	ret

0000000000800160 <umain>:
#include <ulib.h>

int main(void);

void
umain(void) {
  800160:	1141                	addi	sp,sp,-16
  800162:	e406                	sd	ra,8(sp)
    int ret = main();
  800164:	424000ef          	jal	ra,800588 <main>
    exit(ret);
  800168:	f61ff0ef          	jal	ra,8000c8 <exit>

000000000080016c <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  80016c:	872a                	mv	a4,a0
    size_t cnt = 0;
  80016e:	4501                	li	a0,0
    while (cnt < len && *s ++ != '\0') {
  800170:	e589                	bnez	a1,80017a <strnlen+0xe>
  800172:	a811                	j	800186 <strnlen+0x1a>
        cnt ++;
  800174:	0505                	addi	a0,a0,1
    while (cnt < len && *s ++ != '\0') {
  800176:	00a58763          	beq	a1,a0,800184 <strnlen+0x18>
  80017a:	00a707b3          	add	a5,a4,a0
  80017e:	0007c783          	lbu	a5,0(a5)
  800182:	fbed                	bnez	a5,800174 <strnlen+0x8>
    }
    return cnt;
}
  800184:	8082                	ret
  800186:	8082                	ret

0000000000800188 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
  800188:	ca01                	beqz	a2,800198 <memset+0x10>
  80018a:	962a                	add	a2,a2,a0
    char *p = s;
  80018c:	87aa                	mv	a5,a0
        *p ++ = c;
  80018e:	0785                	addi	a5,a5,1
  800190:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
  800194:	fec79de3          	bne	a5,a2,80018e <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  800198:	8082                	ret

000000000080019a <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
  80019a:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  80019e:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
  8001a0:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  8001a4:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
  8001a6:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
  8001aa:	f022                	sd	s0,32(sp)
  8001ac:	ec26                	sd	s1,24(sp)
  8001ae:	e84a                	sd	s2,16(sp)
  8001b0:	f406                	sd	ra,40(sp)
  8001b2:	e44e                	sd	s3,8(sp)
  8001b4:	84aa                	mv	s1,a0
  8001b6:	892e                	mv	s2,a1
  8001b8:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
  8001bc:	2a01                	sext.w	s4,s4

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  8001be:	03067e63          	bgeu	a2,a6,8001fa <printnum+0x60>
  8001c2:	89be                	mv	s3,a5
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  8001c4:	00805763          	blez	s0,8001d2 <printnum+0x38>
  8001c8:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
  8001ca:	85ca                	mv	a1,s2
  8001cc:	854e                	mv	a0,s3
  8001ce:	9482                	jalr	s1
        while (-- width > 0)
  8001d0:	fc65                	bnez	s0,8001c8 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  8001d2:	1a02                	slli	s4,s4,0x20
  8001d4:	020a5a13          	srli	s4,s4,0x20
  8001d8:	00000797          	auipc	a5,0x0
  8001dc:	53878793          	addi	a5,a5,1336 # 800710 <main+0x188>
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
  8001e0:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
  8001e2:	9a3e                	add	s4,s4,a5
  8001e4:	000a4503          	lbu	a0,0(s4)
}
  8001e8:	70a2                	ld	ra,40(sp)
  8001ea:	69a2                	ld	s3,8(sp)
  8001ec:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
  8001ee:	85ca                	mv	a1,s2
  8001f0:	8326                	mv	t1,s1
}
  8001f2:	6942                	ld	s2,16(sp)
  8001f4:	64e2                	ld	s1,24(sp)
  8001f6:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
  8001f8:	8302                	jr	t1
        printnum(putch, putdat, result, base, width - 1, padc);
  8001fa:	03065633          	divu	a2,a2,a6
  8001fe:	8722                	mv	a4,s0
  800200:	f9bff0ef          	jal	ra,80019a <printnum>
  800204:	b7f9                	j	8001d2 <printnum+0x38>

0000000000800206 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  800206:	7119                	addi	sp,sp,-128
  800208:	f4a6                	sd	s1,104(sp)
  80020a:	f0ca                	sd	s2,96(sp)
  80020c:	ecce                	sd	s3,88(sp)
  80020e:	e8d2                	sd	s4,80(sp)
  800210:	e4d6                	sd	s5,72(sp)
  800212:	e0da                	sd	s6,64(sp)
  800214:	fc5e                	sd	s7,56(sp)
  800216:	f06a                	sd	s10,32(sp)
  800218:	fc86                	sd	ra,120(sp)
  80021a:	f8a2                	sd	s0,112(sp)
  80021c:	f862                	sd	s8,48(sp)
  80021e:	f466                	sd	s9,40(sp)
  800220:	ec6e                	sd	s11,24(sp)
  800222:	892a                	mv	s2,a0
  800224:	84ae                	mv	s1,a1
  800226:	8d32                	mv	s10,a2
  800228:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  80022a:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
  80022e:	5b7d                	li	s6,-1
  800230:	00000a97          	auipc	s5,0x0
  800234:	514a8a93          	addi	s5,s5,1300 # 800744 <main+0x1bc>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  800238:	00000b97          	auipc	s7,0x0
  80023c:	728b8b93          	addi	s7,s7,1832 # 800960 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800240:	000d4503          	lbu	a0,0(s10)
  800244:	001d0413          	addi	s0,s10,1
  800248:	01350a63          	beq	a0,s3,80025c <vprintfmt+0x56>
            if (ch == '\0') {
  80024c:	c121                	beqz	a0,80028c <vprintfmt+0x86>
            putch(ch, putdat);
  80024e:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800250:	0405                	addi	s0,s0,1
            putch(ch, putdat);
  800252:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800254:	fff44503          	lbu	a0,-1(s0)
  800258:	ff351ae3          	bne	a0,s3,80024c <vprintfmt+0x46>
  80025c:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
  800260:	02000793          	li	a5,32
        lflag = altflag = 0;
  800264:	4c81                	li	s9,0
  800266:	4881                	li	a7,0
        width = precision = -1;
  800268:	5c7d                	li	s8,-1
  80026a:	5dfd                	li	s11,-1
  80026c:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
  800270:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
  800272:	fdd6059b          	addiw	a1,a2,-35
  800276:	0ff5f593          	andi	a1,a1,255
  80027a:	00140d13          	addi	s10,s0,1
  80027e:	04b56263          	bltu	a0,a1,8002c2 <vprintfmt+0xbc>
  800282:	058a                	slli	a1,a1,0x2
  800284:	95d6                	add	a1,a1,s5
  800286:	4194                	lw	a3,0(a1)
  800288:	96d6                	add	a3,a3,s5
  80028a:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  80028c:	70e6                	ld	ra,120(sp)
  80028e:	7446                	ld	s0,112(sp)
  800290:	74a6                	ld	s1,104(sp)
  800292:	7906                	ld	s2,96(sp)
  800294:	69e6                	ld	s3,88(sp)
  800296:	6a46                	ld	s4,80(sp)
  800298:	6aa6                	ld	s5,72(sp)
  80029a:	6b06                	ld	s6,64(sp)
  80029c:	7be2                	ld	s7,56(sp)
  80029e:	7c42                	ld	s8,48(sp)
  8002a0:	7ca2                	ld	s9,40(sp)
  8002a2:	7d02                	ld	s10,32(sp)
  8002a4:	6de2                	ld	s11,24(sp)
  8002a6:	6109                	addi	sp,sp,128
  8002a8:	8082                	ret
            padc = '0';
  8002aa:	87b2                	mv	a5,a2
            goto reswitch;
  8002ac:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  8002b0:	846a                	mv	s0,s10
  8002b2:	00140d13          	addi	s10,s0,1
  8002b6:	fdd6059b          	addiw	a1,a2,-35
  8002ba:	0ff5f593          	andi	a1,a1,255
  8002be:	fcb572e3          	bgeu	a0,a1,800282 <vprintfmt+0x7c>
            putch('%', putdat);
  8002c2:	85a6                	mv	a1,s1
  8002c4:	02500513          	li	a0,37
  8002c8:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
  8002ca:	fff44783          	lbu	a5,-1(s0)
  8002ce:	8d22                	mv	s10,s0
  8002d0:	f73788e3          	beq	a5,s3,800240 <vprintfmt+0x3a>
  8002d4:	ffed4783          	lbu	a5,-2(s10)
  8002d8:	1d7d                	addi	s10,s10,-1
  8002da:	ff379de3          	bne	a5,s3,8002d4 <vprintfmt+0xce>
  8002de:	b78d                	j	800240 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
  8002e0:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
  8002e4:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  8002e8:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
  8002ea:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
  8002ee:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  8002f2:	02d86463          	bltu	a6,a3,80031a <vprintfmt+0x114>
                ch = *fmt;
  8002f6:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
  8002fa:	002c169b          	slliw	a3,s8,0x2
  8002fe:	0186873b          	addw	a4,a3,s8
  800302:	0017171b          	slliw	a4,a4,0x1
  800306:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
  800308:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
  80030c:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
  80030e:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
  800312:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  800316:	fed870e3          	bgeu	a6,a3,8002f6 <vprintfmt+0xf0>
            if (width < 0)
  80031a:	f40ddce3          	bgez	s11,800272 <vprintfmt+0x6c>
                width = precision, precision = -1;
  80031e:	8de2                	mv	s11,s8
  800320:	5c7d                	li	s8,-1
  800322:	bf81                	j	800272 <vprintfmt+0x6c>
            if (width < 0)
  800324:	fffdc693          	not	a3,s11
  800328:	96fd                	srai	a3,a3,0x3f
  80032a:	00ddfdb3          	and	s11,s11,a3
  80032e:	00144603          	lbu	a2,1(s0)
  800332:	2d81                	sext.w	s11,s11
        switch (ch = *(unsigned char *)fmt ++) {
  800334:	846a                	mv	s0,s10
            goto reswitch;
  800336:	bf35                	j	800272 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
  800338:	000a2c03          	lw	s8,0(s4)
            goto process_precision;
  80033c:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
  800340:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
  800342:	846a                	mv	s0,s10
            goto process_precision;
  800344:	bfd9                	j	80031a <vprintfmt+0x114>
    if (lflag >= 2) {
  800346:	4705                	li	a4,1
  800348:	008a0593          	addi	a1,s4,8
  80034c:	01174463          	blt	a4,a7,800354 <vprintfmt+0x14e>
    else if (lflag) {
  800350:	1a088e63          	beqz	a7,80050c <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
  800354:	000a3603          	ld	a2,0(s4)
  800358:	46c1                	li	a3,16
  80035a:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
  80035c:	2781                	sext.w	a5,a5
  80035e:	876e                	mv	a4,s11
  800360:	85a6                	mv	a1,s1
  800362:	854a                	mv	a0,s2
  800364:	e37ff0ef          	jal	ra,80019a <printnum>
            break;
  800368:	bde1                	j	800240 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
  80036a:	000a2503          	lw	a0,0(s4)
  80036e:	85a6                	mv	a1,s1
  800370:	0a21                	addi	s4,s4,8
  800372:	9902                	jalr	s2
            break;
  800374:	b5f1                	j	800240 <vprintfmt+0x3a>
    if (lflag >= 2) {
  800376:	4705                	li	a4,1
  800378:	008a0593          	addi	a1,s4,8
  80037c:	01174463          	blt	a4,a7,800384 <vprintfmt+0x17e>
    else if (lflag) {
  800380:	18088163          	beqz	a7,800502 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
  800384:	000a3603          	ld	a2,0(s4)
  800388:	46a9                	li	a3,10
  80038a:	8a2e                	mv	s4,a1
  80038c:	bfc1                	j	80035c <vprintfmt+0x156>
            goto reswitch;
  80038e:	00144603          	lbu	a2,1(s0)
            altflag = 1;
  800392:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
  800394:	846a                	mv	s0,s10
            goto reswitch;
  800396:	bdf1                	j	800272 <vprintfmt+0x6c>
            putch(ch, putdat);
  800398:	85a6                	mv	a1,s1
  80039a:	02500513          	li	a0,37
  80039e:	9902                	jalr	s2
            break;
  8003a0:	b545                	j	800240 <vprintfmt+0x3a>
            lflag ++;
  8003a2:	00144603          	lbu	a2,1(s0)
  8003a6:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
  8003a8:	846a                	mv	s0,s10
            goto reswitch;
  8003aa:	b5e1                	j	800272 <vprintfmt+0x6c>
    if (lflag >= 2) {
  8003ac:	4705                	li	a4,1
  8003ae:	008a0593          	addi	a1,s4,8
  8003b2:	01174463          	blt	a4,a7,8003ba <vprintfmt+0x1b4>
    else if (lflag) {
  8003b6:	14088163          	beqz	a7,8004f8 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
  8003ba:	000a3603          	ld	a2,0(s4)
  8003be:	46a1                	li	a3,8
  8003c0:	8a2e                	mv	s4,a1
  8003c2:	bf69                	j	80035c <vprintfmt+0x156>
            putch('0', putdat);
  8003c4:	03000513          	li	a0,48
  8003c8:	85a6                	mv	a1,s1
  8003ca:	e03e                	sd	a5,0(sp)
  8003cc:	9902                	jalr	s2
            putch('x', putdat);
  8003ce:	85a6                	mv	a1,s1
  8003d0:	07800513          	li	a0,120
  8003d4:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  8003d6:	0a21                	addi	s4,s4,8
            goto number;
  8003d8:	6782                	ld	a5,0(sp)
  8003da:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  8003dc:	ff8a3603          	ld	a2,-8(s4)
            goto number;
  8003e0:	bfb5                	j	80035c <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
  8003e2:	000a3403          	ld	s0,0(s4)
  8003e6:	008a0713          	addi	a4,s4,8
  8003ea:	e03a                	sd	a4,0(sp)
  8003ec:	14040263          	beqz	s0,800530 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
  8003f0:	0fb05763          	blez	s11,8004de <vprintfmt+0x2d8>
  8003f4:	02d00693          	li	a3,45
  8003f8:	0cd79163          	bne	a5,a3,8004ba <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8003fc:	00044783          	lbu	a5,0(s0)
  800400:	0007851b          	sext.w	a0,a5
  800404:	cf85                	beqz	a5,80043c <vprintfmt+0x236>
  800406:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
  80040a:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  80040e:	000c4563          	bltz	s8,800418 <vprintfmt+0x212>
  800412:	3c7d                	addiw	s8,s8,-1
  800414:	036c0263          	beq	s8,s6,800438 <vprintfmt+0x232>
                    putch('?', putdat);
  800418:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
  80041a:	0e0c8e63          	beqz	s9,800516 <vprintfmt+0x310>
  80041e:	3781                	addiw	a5,a5,-32
  800420:	0ef47b63          	bgeu	s0,a5,800516 <vprintfmt+0x310>
                    putch('?', putdat);
  800424:	03f00513          	li	a0,63
  800428:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  80042a:	000a4783          	lbu	a5,0(s4)
  80042e:	3dfd                	addiw	s11,s11,-1
  800430:	0a05                	addi	s4,s4,1
  800432:	0007851b          	sext.w	a0,a5
  800436:	ffe1                	bnez	a5,80040e <vprintfmt+0x208>
            for (; width > 0; width --) {
  800438:	01b05963          	blez	s11,80044a <vprintfmt+0x244>
  80043c:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
  80043e:	85a6                	mv	a1,s1
  800440:	02000513          	li	a0,32
  800444:	9902                	jalr	s2
            for (; width > 0; width --) {
  800446:	fe0d9be3          	bnez	s11,80043c <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
  80044a:	6a02                	ld	s4,0(sp)
  80044c:	bbd5                	j	800240 <vprintfmt+0x3a>
    if (lflag >= 2) {
  80044e:	4705                	li	a4,1
  800450:	008a0c93          	addi	s9,s4,8
  800454:	01174463          	blt	a4,a7,80045c <vprintfmt+0x256>
    else if (lflag) {
  800458:	08088d63          	beqz	a7,8004f2 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
  80045c:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
  800460:	0a044d63          	bltz	s0,80051a <vprintfmt+0x314>
            num = getint(&ap, lflag);
  800464:	8622                	mv	a2,s0
  800466:	8a66                	mv	s4,s9
  800468:	46a9                	li	a3,10
  80046a:	bdcd                	j	80035c <vprintfmt+0x156>
            err = va_arg(ap, int);
  80046c:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  800470:	4761                	li	a4,24
            err = va_arg(ap, int);
  800472:	0a21                	addi	s4,s4,8
            if (err < 0) {
  800474:	41f7d69b          	sraiw	a3,a5,0x1f
  800478:	8fb5                	xor	a5,a5,a3
  80047a:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  80047e:	02d74163          	blt	a4,a3,8004a0 <vprintfmt+0x29a>
  800482:	00369793          	slli	a5,a3,0x3
  800486:	97de                	add	a5,a5,s7
  800488:	639c                	ld	a5,0(a5)
  80048a:	cb99                	beqz	a5,8004a0 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
  80048c:	86be                	mv	a3,a5
  80048e:	00000617          	auipc	a2,0x0
  800492:	2b260613          	addi	a2,a2,690 # 800740 <main+0x1b8>
  800496:	85a6                	mv	a1,s1
  800498:	854a                	mv	a0,s2
  80049a:	0ce000ef          	jal	ra,800568 <printfmt>
  80049e:	b34d                	j	800240 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
  8004a0:	00000617          	auipc	a2,0x0
  8004a4:	29060613          	addi	a2,a2,656 # 800730 <main+0x1a8>
  8004a8:	85a6                	mv	a1,s1
  8004aa:	854a                	mv	a0,s2
  8004ac:	0bc000ef          	jal	ra,800568 <printfmt>
  8004b0:	bb41                	j	800240 <vprintfmt+0x3a>
                p = "(null)";
  8004b2:	00000417          	auipc	s0,0x0
  8004b6:	27640413          	addi	s0,s0,630 # 800728 <main+0x1a0>
                for (width -= strnlen(p, precision); width > 0; width --) {
  8004ba:	85e2                	mv	a1,s8
  8004bc:	8522                	mv	a0,s0
  8004be:	e43e                	sd	a5,8(sp)
  8004c0:	cadff0ef          	jal	ra,80016c <strnlen>
  8004c4:	40ad8dbb          	subw	s11,s11,a0
  8004c8:	01b05b63          	blez	s11,8004de <vprintfmt+0x2d8>
  8004cc:	67a2                	ld	a5,8(sp)
  8004ce:	00078a1b          	sext.w	s4,a5
  8004d2:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
  8004d4:	85a6                	mv	a1,s1
  8004d6:	8552                	mv	a0,s4
  8004d8:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
  8004da:	fe0d9ce3          	bnez	s11,8004d2 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8004de:	00044783          	lbu	a5,0(s0)
  8004e2:	00140a13          	addi	s4,s0,1
  8004e6:	0007851b          	sext.w	a0,a5
  8004ea:	d3a5                	beqz	a5,80044a <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
  8004ec:	05e00413          	li	s0,94
  8004f0:	bf39                	j	80040e <vprintfmt+0x208>
        return va_arg(*ap, int);
  8004f2:	000a2403          	lw	s0,0(s4)
  8004f6:	b7ad                	j	800460 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
  8004f8:	000a6603          	lwu	a2,0(s4)
  8004fc:	46a1                	li	a3,8
  8004fe:	8a2e                	mv	s4,a1
  800500:	bdb1                	j	80035c <vprintfmt+0x156>
  800502:	000a6603          	lwu	a2,0(s4)
  800506:	46a9                	li	a3,10
  800508:	8a2e                	mv	s4,a1
  80050a:	bd89                	j	80035c <vprintfmt+0x156>
  80050c:	000a6603          	lwu	a2,0(s4)
  800510:	46c1                	li	a3,16
  800512:	8a2e                	mv	s4,a1
  800514:	b5a1                	j	80035c <vprintfmt+0x156>
                    putch(ch, putdat);
  800516:	9902                	jalr	s2
  800518:	bf09                	j	80042a <vprintfmt+0x224>
                putch('-', putdat);
  80051a:	85a6                	mv	a1,s1
  80051c:	02d00513          	li	a0,45
  800520:	e03e                	sd	a5,0(sp)
  800522:	9902                	jalr	s2
                num = -(long long)num;
  800524:	6782                	ld	a5,0(sp)
  800526:	8a66                	mv	s4,s9
  800528:	40800633          	neg	a2,s0
  80052c:	46a9                	li	a3,10
  80052e:	b53d                	j	80035c <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
  800530:	03b05163          	blez	s11,800552 <vprintfmt+0x34c>
  800534:	02d00693          	li	a3,45
  800538:	f6d79de3          	bne	a5,a3,8004b2 <vprintfmt+0x2ac>
                p = "(null)";
  80053c:	00000417          	auipc	s0,0x0
  800540:	1ec40413          	addi	s0,s0,492 # 800728 <main+0x1a0>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800544:	02800793          	li	a5,40
  800548:	02800513          	li	a0,40
  80054c:	00140a13          	addi	s4,s0,1
  800550:	bd6d                	j	80040a <vprintfmt+0x204>
  800552:	00000a17          	auipc	s4,0x0
  800556:	1d7a0a13          	addi	s4,s4,471 # 800729 <main+0x1a1>
  80055a:	02800513          	li	a0,40
  80055e:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
  800562:	05e00413          	li	s0,94
  800566:	b565                	j	80040e <vprintfmt+0x208>

0000000000800568 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  800568:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
  80056a:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  80056e:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
  800570:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  800572:	ec06                	sd	ra,24(sp)
  800574:	f83a                	sd	a4,48(sp)
  800576:	fc3e                	sd	a5,56(sp)
  800578:	e0c2                	sd	a6,64(sp)
  80057a:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  80057c:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
  80057e:	c89ff0ef          	jal	ra,800206 <vprintfmt>
}
  800582:	60e2                	ld	ra,24(sp)
  800584:	6161                	addi	sp,sp,80
  800586:	8082                	ret

0000000000800588 <main>:




int
main(void) {
  800588:	711d                	addi	sp,sp,-96
     //open this!
     int i,time;
     memset(pids, 0, sizeof(pids));
  80058a:	4651                	li	a2,20
  80058c:	4581                	li	a1,0
  80058e:	00001517          	auipc	a0,0x1
  800592:	aa250513          	addi	a0,a0,-1374 # 801030 <pids>
main(void) {
  800596:	e8a2                	sd	s0,80(sp)
  800598:	e4a6                	sd	s1,72(sp)
  80059a:	e0ca                	sd	s2,64(sp)
  80059c:	fc4e                	sd	s3,56(sp)
  80059e:	f852                	sd	s4,48(sp)
  8005a0:	f456                	sd	s5,40(sp)
  8005a2:	ec86                	sd	ra,88(sp)
     memset(pids, 0, sizeof(pids));
  8005a4:	be5ff0ef          	jal	ra,800188 <memset>
     int prior[TOTAL]= {3,1,4,5,2};
  8005a8:	4795                	li	a5,5
  8005aa:	4705                	li	a4,1
  8005ac:	1782                	slli	a5,a5,0x20
  8005ae:	0791                	addi	a5,a5,4
  8005b0:	1702                	slli	a4,a4,0x20
  8005b2:	00001a17          	auipc	s4,0x1
  8005b6:	a4ea0a13          	addi	s4,s4,-1458 # 801000 <acc>
  8005ba:	00001497          	auipc	s1,0x1
  8005be:	a7648493          	addi	s1,s1,-1418 # 801030 <pids>
  8005c2:	070d                	addi	a4,a4,3
  8005c4:	e83e                	sd	a5,16(sp)
  8005c6:	4789                	li	a5,2
  8005c8:	e43a                	sd	a4,8(sp)
  8005ca:	cc3e                	sw	a5,24(sp)
     for (i = 0; i < TOTAL; i ++) {
  8005cc:	89d2                	mv	s3,s4
     int prior[TOTAL]= {3,1,4,5,2};
  8005ce:	8926                	mv	s2,s1
     for (i = 0; i < TOTAL; i ++) {
  8005d0:	4401                	li	s0,0
  8005d2:	4a95                	li	s5,5
          acc[i]=0;
  8005d4:	0009a023          	sw	zero,0(s3)
          if ((pids[i] = fork()) == 0) {
  8005d8:	b07ff0ef          	jal	ra,8000de <fork>
  8005dc:	00a92023          	sw	a0,0(s2)
  8005e0:	c125                	beqz	a0,800640 <main+0xb8>
                         exit(acc[i]);
                    }

               }
          }
          if (pids[i] < 0) {
  8005e2:	0a054d63          	bltz	a0,80069c <main+0x114>
     for (i = 0; i < TOTAL; i ++) {
  8005e6:	2405                	addiw	s0,s0,1
  8005e8:	0991                	addi	s3,s3,4
  8005ea:	0911                	addi	s2,s2,4
  8005ec:	ff5414e3          	bne	s0,s5,8005d4 <main+0x4c>
               goto failed;
          }
     }

     cprintf("main: fork ok,now need to wait pids.\n");
  8005f0:	00000517          	auipc	a0,0x0
  8005f4:	45850513          	addi	a0,a0,1112 # 800a48 <error_string+0xe8>
  8005f8:	b33ff0ef          	jal	ra,80012a <cprintf>

     for (i = 0; i < TOTAL; i ++) {
  8005fc:	00001417          	auipc	s0,0x1
  800600:	a1c40413          	addi	s0,s0,-1508 # 801018 <status>
  800604:	00001917          	auipc	s2,0x1
  800608:	a2890913          	addi	s2,s2,-1496 # 80102c <status+0x14>
         status[i]=0;
         waitpid(pids[i],&status[i]);
  80060c:	4088                	lw	a0,0(s1)
         status[i]=0;
  80060e:	00042023          	sw	zero,0(s0)
         waitpid(pids[i],&status[i]);
  800612:	85a2                	mv	a1,s0
  800614:	0411                	addi	s0,s0,4
  800616:	acbff0ef          	jal	ra,8000e0 <waitpid>
     for (i = 0; i < TOTAL; i ++) {
  80061a:	0491                	addi	s1,s1,4
  80061c:	ff2418e3          	bne	s0,s2,80060c <main+0x84>
     }
     cprintf("main: wait pids over\n");
  800620:	00000517          	auipc	a0,0x0
  800624:	45050513          	addi	a0,a0,1104 # 800a70 <error_string+0x110>
  800628:	b03ff0ef          	jal	ra,80012a <cprintf>
          if (pids[i] > 0) {
               kill(pids[i]);
          }
     }
     panic("FAIL: T.T\n");
}
  80062c:	60e6                	ld	ra,88(sp)
  80062e:	6446                	ld	s0,80(sp)
  800630:	64a6                	ld	s1,72(sp)
  800632:	6906                	ld	s2,64(sp)
  800634:	79e2                	ld	s3,56(sp)
  800636:	7a42                	ld	s4,48(sp)
  800638:	7aa2                	ld	s5,40(sp)
  80063a:	4501                	li	a0,0
  80063c:	6125                	addi	sp,sp,96
  80063e:	8082                	ret
               set_priority(prior[i]);
  800640:	040a                	slli	s0,s0,0x2
  800642:	101c                	addi	a5,sp,32
  800644:	97a2                	add	a5,a5,s0
  800646:	fe87a503          	lw	a0,-24(a5)
  80064a:	a9fff0ef          	jal	ra,8000e8 <set_priority>
  80064e:	003d16b7          	lui	a3,0x3d1
  800652:	90168693          	addi	a3,a3,-1791 # 3d0901 <__panic-0x42f71f>
  800656:	0c800713          	li	a4,200
          j = !j;
  80065a:	4792                	lw	a5,4(sp)
  80065c:	377d                	addiw	a4,a4,-1
  80065e:	2781                	sext.w	a5,a5
  800660:	0017b793          	seqz	a5,a5
  800664:	c23e                	sw	a5,4(sp)
     for (i = 0; i != 200; ++ i)
  800666:	fb75                	bnez	a4,80065a <main+0xd2>
                    if(acc[i]>4000000) {
  800668:	36fd                	addiw	a3,a3,-1
  80066a:	f6f5                	bnez	a3,800656 <main+0xce>
  80066c:	003d17b7          	lui	a5,0x3d1
  800670:	9017879b          	addiw	a5,a5,-1791
  800674:	9452                	add	s0,s0,s4
  800676:	c01c                	sw	a5,0(s0)
                         time=gettime_msec();
  800678:	a6fff0ef          	jal	ra,8000e6 <gettime_msec>
  80067c:	0005049b          	sext.w	s1,a0
                         cprintf("child pid %d, acc %d, time %d\n",getpid(),acc[i],time);
  800680:	a65ff0ef          	jal	ra,8000e4 <getpid>
  800684:	4010                	lw	a2,0(s0)
  800686:	85aa                	mv	a1,a0
  800688:	86a6                	mv	a3,s1
  80068a:	00000517          	auipc	a0,0x0
  80068e:	39e50513          	addi	a0,a0,926 # 800a28 <error_string+0xc8>
  800692:	a99ff0ef          	jal	ra,80012a <cprintf>
                         exit(acc[i]);
  800696:	4008                	lw	a0,0(s0)
  800698:	a31ff0ef          	jal	ra,8000c8 <exit>
  80069c:	00001417          	auipc	s0,0x1
  8006a0:	9a840413          	addi	s0,s0,-1624 # 801044 <pids+0x14>
          if (pids[i] > 0) {
  8006a4:	4088                	lw	a0,0(s1)
  8006a6:	00a05463          	blez	a0,8006ae <main+0x126>
               kill(pids[i]);
  8006aa:	a39ff0ef          	jal	ra,8000e2 <kill>
     for (i = 0; i < TOTAL; i ++) {
  8006ae:	0491                	addi	s1,s1,4
  8006b0:	fe941ae3          	bne	s0,s1,8006a4 <main+0x11c>
     panic("FAIL: T.T\n");
  8006b4:	00000617          	auipc	a2,0x0
  8006b8:	3d460613          	addi	a2,a2,980 # 800a88 <error_string+0x128>
  8006bc:	04700593          	li	a1,71
  8006c0:	00000517          	auipc	a0,0x0
  8006c4:	3d850513          	addi	a0,a0,984 # 800a98 <error_string+0x138>
  8006c8:	959ff0ef          	jal	ra,800020 <__panic>
