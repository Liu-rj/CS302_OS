
obj/__user_ex3.out:     file format elf64-littleriscv


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
  800034:	6a050513          	addi	a0,a0,1696 # 8006d0 <main+0x14e>
__panic(const char *file, int line, const char *fmt, ...) {
  800038:	ec06                	sd	ra,24(sp)
  80003a:	f436                	sd	a3,40(sp)
  80003c:	f83a                	sd	a4,48(sp)
  80003e:	e0c2                	sd	a6,64(sp)
  800040:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  800042:	e43e                	sd	a5,8(sp)
    cprintf("user panic at %s:%d:\n    ", file, line);
  800044:	0e0000ef          	jal	ra,800124 <cprintf>
    vcprintf(fmt, ap);
  800048:	65a2                	ld	a1,8(sp)
  80004a:	8522                	mv	a0,s0
  80004c:	0b8000ef          	jal	ra,800104 <vcprintf>
    cprintf("\n");
  800050:	00000517          	auipc	a0,0x0
  800054:	6a050513          	addi	a0,a0,1696 # 8006f0 <main+0x16e>
  800058:	0cc000ef          	jal	ra,800124 <cprintf>
    va_end(ap);
    exit(-E_PANIC);
  80005c:	5559                	li	a0,-10
  80005e:	066000ef          	jal	ra,8000c4 <exit>

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

00000000008000bc <sys_setgood>:
sys_setpriority(int priority) {
    syscall(SYS_labschedule_set_priority, priority);
}

void
sys_setgood(int good) {
  8000bc:	85aa                	mv	a1,a0
    syscall(SYS_labschedule_set_good, good);
  8000be:	10000513          	li	a0,256
  8000c2:	b745                	j	800062 <syscall>

00000000008000c4 <exit>:
#include <syscall.h>
#include <stdio.h>
#include <ulib.h>

void
exit(int error_code) {
  8000c4:	1141                	addi	sp,sp,-16
  8000c6:	e406                	sd	ra,8(sp)
    //cprintf("eee\n");
    sys_exit(error_code);
  8000c8:	fd3ff0ef          	jal	ra,80009a <sys_exit>
    cprintf("BUG: exit failed.\n");
  8000cc:	00000517          	auipc	a0,0x0
  8000d0:	62c50513          	addi	a0,a0,1580 # 8006f8 <main+0x176>
  8000d4:	050000ef          	jal	ra,800124 <cprintf>
    while (1);
  8000d8:	a001                	j	8000d8 <exit+0x14>

00000000008000da <fork>:
}

int
fork(void) {
    return sys_fork();
  8000da:	b7d9                	j	8000a0 <sys_fork>

00000000008000dc <waitpid>:
    return sys_wait(0, NULL);
}

int
waitpid(int pid, int *store) {
    return sys_wait(pid, store);
  8000dc:	b7e1                	j	8000a4 <sys_wait>

00000000008000de <kill>:
    sys_yield();
}

int
kill(int pid) {
    return sys_kill(pid);
  8000de:	b7f9                	j	8000ac <sys_kill>

00000000008000e0 <getpid>:
}

int
getpid(void) {
    return sys_getpid();
  8000e0:	bfc9                	j	8000b2 <sys_getpid>

00000000008000e2 <set_good>:
    sys_setpriority(priority);
}

void
set_good(int good) {
    sys_setgood(good);
  8000e2:	bfe9                	j	8000bc <sys_setgood>

00000000008000e4 <_start>:
    # move down the esp register
    # since it may cause page fault in backtrace
    // subl $0x20, %esp

    # call user-program function
    call umain
  8000e4:	076000ef          	jal	ra,80015a <umain>
1:  j 1b
  8000e8:	a001                	j	8000e8 <_start+0x4>

00000000008000ea <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  8000ea:	1141                	addi	sp,sp,-16
  8000ec:	e022                	sd	s0,0(sp)
  8000ee:	e406                	sd	ra,8(sp)
  8000f0:	842e                	mv	s0,a1
    sys_putc(c);
  8000f2:	fc5ff0ef          	jal	ra,8000b6 <sys_putc>
    (*cnt) ++;
  8000f6:	401c                	lw	a5,0(s0)
}
  8000f8:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
  8000fa:	2785                	addiw	a5,a5,1
  8000fc:	c01c                	sw	a5,0(s0)
}
  8000fe:	6402                	ld	s0,0(sp)
  800100:	0141                	addi	sp,sp,16
  800102:	8082                	ret

0000000000800104 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  800104:	1101                	addi	sp,sp,-32
  800106:	862a                	mv	a2,a0
  800108:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  80010a:	00000517          	auipc	a0,0x0
  80010e:	fe050513          	addi	a0,a0,-32 # 8000ea <cputch>
  800112:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
  800114:	ec06                	sd	ra,24(sp)
    int cnt = 0;
  800116:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  800118:	0e8000ef          	jal	ra,800200 <vprintfmt>
    return cnt;
}
  80011c:	60e2                	ld	ra,24(sp)
  80011e:	4532                	lw	a0,12(sp)
  800120:	6105                	addi	sp,sp,32
  800122:	8082                	ret

0000000000800124 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  800124:	711d                	addi	sp,sp,-96
    va_list ap;

    va_start(ap, fmt);
  800126:	02810313          	addi	t1,sp,40
cprintf(const char *fmt, ...) {
  80012a:	8e2a                	mv	t3,a0
  80012c:	f42e                	sd	a1,40(sp)
  80012e:	f832                	sd	a2,48(sp)
  800130:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  800132:	00000517          	auipc	a0,0x0
  800136:	fb850513          	addi	a0,a0,-72 # 8000ea <cputch>
  80013a:	004c                	addi	a1,sp,4
  80013c:	869a                	mv	a3,t1
  80013e:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
  800140:	ec06                	sd	ra,24(sp)
  800142:	e0ba                	sd	a4,64(sp)
  800144:	e4be                	sd	a5,72(sp)
  800146:	e8c2                	sd	a6,80(sp)
  800148:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
  80014a:	e41a                	sd	t1,8(sp)
    int cnt = 0;
  80014c:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  80014e:	0b2000ef          	jal	ra,800200 <vprintfmt>
    int cnt = vcprintf(fmt, ap);
    va_end(ap);

    return cnt;
}
  800152:	60e2                	ld	ra,24(sp)
  800154:	4512                	lw	a0,4(sp)
  800156:	6125                	addi	sp,sp,96
  800158:	8082                	ret

000000000080015a <umain>:
#include <ulib.h>

int main(void);

void
umain(void) {
  80015a:	1141                	addi	sp,sp,-16
  80015c:	e406                	sd	ra,8(sp)
    int ret = main();
  80015e:	424000ef          	jal	ra,800582 <main>
    exit(ret);
  800162:	f63ff0ef          	jal	ra,8000c4 <exit>

0000000000800166 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  800166:	872a                	mv	a4,a0
    size_t cnt = 0;
  800168:	4501                	li	a0,0
    while (cnt < len && *s ++ != '\0') {
  80016a:	e589                	bnez	a1,800174 <strnlen+0xe>
  80016c:	a811                	j	800180 <strnlen+0x1a>
        cnt ++;
  80016e:	0505                	addi	a0,a0,1
    while (cnt < len && *s ++ != '\0') {
  800170:	00a58763          	beq	a1,a0,80017e <strnlen+0x18>
  800174:	00a707b3          	add	a5,a4,a0
  800178:	0007c783          	lbu	a5,0(a5)
  80017c:	fbed                	bnez	a5,80016e <strnlen+0x8>
    }
    return cnt;
}
  80017e:	8082                	ret
  800180:	8082                	ret

0000000000800182 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
  800182:	ca01                	beqz	a2,800192 <memset+0x10>
  800184:	962a                	add	a2,a2,a0
    char *p = s;
  800186:	87aa                	mv	a5,a0
        *p ++ = c;
  800188:	0785                	addi	a5,a5,1
  80018a:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
  80018e:	fec79de3          	bne	a5,a2,800188 <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  800192:	8082                	ret

0000000000800194 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
  800194:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  800198:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
  80019a:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  80019e:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
  8001a0:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
  8001a4:	f022                	sd	s0,32(sp)
  8001a6:	ec26                	sd	s1,24(sp)
  8001a8:	e84a                	sd	s2,16(sp)
  8001aa:	f406                	sd	ra,40(sp)
  8001ac:	e44e                	sd	s3,8(sp)
  8001ae:	84aa                	mv	s1,a0
  8001b0:	892e                	mv	s2,a1
  8001b2:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
  8001b6:	2a01                	sext.w	s4,s4

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  8001b8:	03067e63          	bgeu	a2,a6,8001f4 <printnum+0x60>
  8001bc:	89be                	mv	s3,a5
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  8001be:	00805763          	blez	s0,8001cc <printnum+0x38>
  8001c2:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
  8001c4:	85ca                	mv	a1,s2
  8001c6:	854e                	mv	a0,s3
  8001c8:	9482                	jalr	s1
        while (-- width > 0)
  8001ca:	fc65                	bnez	s0,8001c2 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  8001cc:	1a02                	slli	s4,s4,0x20
  8001ce:	020a5a13          	srli	s4,s4,0x20
  8001d2:	00000797          	auipc	a5,0x0
  8001d6:	53e78793          	addi	a5,a5,1342 # 800710 <main+0x18e>
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
  8001da:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
  8001dc:	9a3e                	add	s4,s4,a5
  8001de:	000a4503          	lbu	a0,0(s4)
}
  8001e2:	70a2                	ld	ra,40(sp)
  8001e4:	69a2                	ld	s3,8(sp)
  8001e6:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
  8001e8:	85ca                	mv	a1,s2
  8001ea:	8326                	mv	t1,s1
}
  8001ec:	6942                	ld	s2,16(sp)
  8001ee:	64e2                	ld	s1,24(sp)
  8001f0:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
  8001f2:	8302                	jr	t1
        printnum(putch, putdat, result, base, width - 1, padc);
  8001f4:	03065633          	divu	a2,a2,a6
  8001f8:	8722                	mv	a4,s0
  8001fa:	f9bff0ef          	jal	ra,800194 <printnum>
  8001fe:	b7f9                	j	8001cc <printnum+0x38>

0000000000800200 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  800200:	7119                	addi	sp,sp,-128
  800202:	f4a6                	sd	s1,104(sp)
  800204:	f0ca                	sd	s2,96(sp)
  800206:	ecce                	sd	s3,88(sp)
  800208:	e8d2                	sd	s4,80(sp)
  80020a:	e4d6                	sd	s5,72(sp)
  80020c:	e0da                	sd	s6,64(sp)
  80020e:	fc5e                	sd	s7,56(sp)
  800210:	f06a                	sd	s10,32(sp)
  800212:	fc86                	sd	ra,120(sp)
  800214:	f8a2                	sd	s0,112(sp)
  800216:	f862                	sd	s8,48(sp)
  800218:	f466                	sd	s9,40(sp)
  80021a:	ec6e                	sd	s11,24(sp)
  80021c:	892a                	mv	s2,a0
  80021e:	84ae                	mv	s1,a1
  800220:	8d32                	mv	s10,a2
  800222:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800224:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
  800228:	5b7d                	li	s6,-1
  80022a:	00000a97          	auipc	s5,0x0
  80022e:	51aa8a93          	addi	s5,s5,1306 # 800744 <main+0x1c2>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  800232:	00000b97          	auipc	s7,0x0
  800236:	72eb8b93          	addi	s7,s7,1838 # 800960 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  80023a:	000d4503          	lbu	a0,0(s10)
  80023e:	001d0413          	addi	s0,s10,1
  800242:	01350a63          	beq	a0,s3,800256 <vprintfmt+0x56>
            if (ch == '\0') {
  800246:	c121                	beqz	a0,800286 <vprintfmt+0x86>
            putch(ch, putdat);
  800248:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  80024a:	0405                	addi	s0,s0,1
            putch(ch, putdat);
  80024c:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  80024e:	fff44503          	lbu	a0,-1(s0)
  800252:	ff351ae3          	bne	a0,s3,800246 <vprintfmt+0x46>
  800256:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
  80025a:	02000793          	li	a5,32
        lflag = altflag = 0;
  80025e:	4c81                	li	s9,0
  800260:	4881                	li	a7,0
        width = precision = -1;
  800262:	5c7d                	li	s8,-1
  800264:	5dfd                	li	s11,-1
  800266:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
  80026a:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
  80026c:	fdd6059b          	addiw	a1,a2,-35
  800270:	0ff5f593          	andi	a1,a1,255
  800274:	00140d13          	addi	s10,s0,1
  800278:	04b56263          	bltu	a0,a1,8002bc <vprintfmt+0xbc>
  80027c:	058a                	slli	a1,a1,0x2
  80027e:	95d6                	add	a1,a1,s5
  800280:	4194                	lw	a3,0(a1)
  800282:	96d6                	add	a3,a3,s5
  800284:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  800286:	70e6                	ld	ra,120(sp)
  800288:	7446                	ld	s0,112(sp)
  80028a:	74a6                	ld	s1,104(sp)
  80028c:	7906                	ld	s2,96(sp)
  80028e:	69e6                	ld	s3,88(sp)
  800290:	6a46                	ld	s4,80(sp)
  800292:	6aa6                	ld	s5,72(sp)
  800294:	6b06                	ld	s6,64(sp)
  800296:	7be2                	ld	s7,56(sp)
  800298:	7c42                	ld	s8,48(sp)
  80029a:	7ca2                	ld	s9,40(sp)
  80029c:	7d02                	ld	s10,32(sp)
  80029e:	6de2                	ld	s11,24(sp)
  8002a0:	6109                	addi	sp,sp,128
  8002a2:	8082                	ret
            padc = '0';
  8002a4:	87b2                	mv	a5,a2
            goto reswitch;
  8002a6:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  8002aa:	846a                	mv	s0,s10
  8002ac:	00140d13          	addi	s10,s0,1
  8002b0:	fdd6059b          	addiw	a1,a2,-35
  8002b4:	0ff5f593          	andi	a1,a1,255
  8002b8:	fcb572e3          	bgeu	a0,a1,80027c <vprintfmt+0x7c>
            putch('%', putdat);
  8002bc:	85a6                	mv	a1,s1
  8002be:	02500513          	li	a0,37
  8002c2:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
  8002c4:	fff44783          	lbu	a5,-1(s0)
  8002c8:	8d22                	mv	s10,s0
  8002ca:	f73788e3          	beq	a5,s3,80023a <vprintfmt+0x3a>
  8002ce:	ffed4783          	lbu	a5,-2(s10)
  8002d2:	1d7d                	addi	s10,s10,-1
  8002d4:	ff379de3          	bne	a5,s3,8002ce <vprintfmt+0xce>
  8002d8:	b78d                	j	80023a <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
  8002da:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
  8002de:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  8002e2:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
  8002e4:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
  8002e8:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  8002ec:	02d86463          	bltu	a6,a3,800314 <vprintfmt+0x114>
                ch = *fmt;
  8002f0:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
  8002f4:	002c169b          	slliw	a3,s8,0x2
  8002f8:	0186873b          	addw	a4,a3,s8
  8002fc:	0017171b          	slliw	a4,a4,0x1
  800300:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
  800302:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
  800306:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
  800308:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
  80030c:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  800310:	fed870e3          	bgeu	a6,a3,8002f0 <vprintfmt+0xf0>
            if (width < 0)
  800314:	f40ddce3          	bgez	s11,80026c <vprintfmt+0x6c>
                width = precision, precision = -1;
  800318:	8de2                	mv	s11,s8
  80031a:	5c7d                	li	s8,-1
  80031c:	bf81                	j	80026c <vprintfmt+0x6c>
            if (width < 0)
  80031e:	fffdc693          	not	a3,s11
  800322:	96fd                	srai	a3,a3,0x3f
  800324:	00ddfdb3          	and	s11,s11,a3
  800328:	00144603          	lbu	a2,1(s0)
  80032c:	2d81                	sext.w	s11,s11
        switch (ch = *(unsigned char *)fmt ++) {
  80032e:	846a                	mv	s0,s10
            goto reswitch;
  800330:	bf35                	j	80026c <vprintfmt+0x6c>
            precision = va_arg(ap, int);
  800332:	000a2c03          	lw	s8,0(s4)
            goto process_precision;
  800336:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
  80033a:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
  80033c:	846a                	mv	s0,s10
            goto process_precision;
  80033e:	bfd9                	j	800314 <vprintfmt+0x114>
    if (lflag >= 2) {
  800340:	4705                	li	a4,1
  800342:	008a0593          	addi	a1,s4,8
  800346:	01174463          	blt	a4,a7,80034e <vprintfmt+0x14e>
    else if (lflag) {
  80034a:	1a088e63          	beqz	a7,800506 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
  80034e:	000a3603          	ld	a2,0(s4)
  800352:	46c1                	li	a3,16
  800354:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
  800356:	2781                	sext.w	a5,a5
  800358:	876e                	mv	a4,s11
  80035a:	85a6                	mv	a1,s1
  80035c:	854a                	mv	a0,s2
  80035e:	e37ff0ef          	jal	ra,800194 <printnum>
            break;
  800362:	bde1                	j	80023a <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
  800364:	000a2503          	lw	a0,0(s4)
  800368:	85a6                	mv	a1,s1
  80036a:	0a21                	addi	s4,s4,8
  80036c:	9902                	jalr	s2
            break;
  80036e:	b5f1                	j	80023a <vprintfmt+0x3a>
    if (lflag >= 2) {
  800370:	4705                	li	a4,1
  800372:	008a0593          	addi	a1,s4,8
  800376:	01174463          	blt	a4,a7,80037e <vprintfmt+0x17e>
    else if (lflag) {
  80037a:	18088163          	beqz	a7,8004fc <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
  80037e:	000a3603          	ld	a2,0(s4)
  800382:	46a9                	li	a3,10
  800384:	8a2e                	mv	s4,a1
  800386:	bfc1                	j	800356 <vprintfmt+0x156>
            goto reswitch;
  800388:	00144603          	lbu	a2,1(s0)
            altflag = 1;
  80038c:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
  80038e:	846a                	mv	s0,s10
            goto reswitch;
  800390:	bdf1                	j	80026c <vprintfmt+0x6c>
            putch(ch, putdat);
  800392:	85a6                	mv	a1,s1
  800394:	02500513          	li	a0,37
  800398:	9902                	jalr	s2
            break;
  80039a:	b545                	j	80023a <vprintfmt+0x3a>
            lflag ++;
  80039c:	00144603          	lbu	a2,1(s0)
  8003a0:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
  8003a2:	846a                	mv	s0,s10
            goto reswitch;
  8003a4:	b5e1                	j	80026c <vprintfmt+0x6c>
    if (lflag >= 2) {
  8003a6:	4705                	li	a4,1
  8003a8:	008a0593          	addi	a1,s4,8
  8003ac:	01174463          	blt	a4,a7,8003b4 <vprintfmt+0x1b4>
    else if (lflag) {
  8003b0:	14088163          	beqz	a7,8004f2 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
  8003b4:	000a3603          	ld	a2,0(s4)
  8003b8:	46a1                	li	a3,8
  8003ba:	8a2e                	mv	s4,a1
  8003bc:	bf69                	j	800356 <vprintfmt+0x156>
            putch('0', putdat);
  8003be:	03000513          	li	a0,48
  8003c2:	85a6                	mv	a1,s1
  8003c4:	e03e                	sd	a5,0(sp)
  8003c6:	9902                	jalr	s2
            putch('x', putdat);
  8003c8:	85a6                	mv	a1,s1
  8003ca:	07800513          	li	a0,120
  8003ce:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  8003d0:	0a21                	addi	s4,s4,8
            goto number;
  8003d2:	6782                	ld	a5,0(sp)
  8003d4:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  8003d6:	ff8a3603          	ld	a2,-8(s4)
            goto number;
  8003da:	bfb5                	j	800356 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
  8003dc:	000a3403          	ld	s0,0(s4)
  8003e0:	008a0713          	addi	a4,s4,8
  8003e4:	e03a                	sd	a4,0(sp)
  8003e6:	14040263          	beqz	s0,80052a <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
  8003ea:	0fb05763          	blez	s11,8004d8 <vprintfmt+0x2d8>
  8003ee:	02d00693          	li	a3,45
  8003f2:	0cd79163          	bne	a5,a3,8004b4 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8003f6:	00044783          	lbu	a5,0(s0)
  8003fa:	0007851b          	sext.w	a0,a5
  8003fe:	cf85                	beqz	a5,800436 <vprintfmt+0x236>
  800400:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
  800404:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800408:	000c4563          	bltz	s8,800412 <vprintfmt+0x212>
  80040c:	3c7d                	addiw	s8,s8,-1
  80040e:	036c0263          	beq	s8,s6,800432 <vprintfmt+0x232>
                    putch('?', putdat);
  800412:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
  800414:	0e0c8e63          	beqz	s9,800510 <vprintfmt+0x310>
  800418:	3781                	addiw	a5,a5,-32
  80041a:	0ef47b63          	bgeu	s0,a5,800510 <vprintfmt+0x310>
                    putch('?', putdat);
  80041e:	03f00513          	li	a0,63
  800422:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800424:	000a4783          	lbu	a5,0(s4)
  800428:	3dfd                	addiw	s11,s11,-1
  80042a:	0a05                	addi	s4,s4,1
  80042c:	0007851b          	sext.w	a0,a5
  800430:	ffe1                	bnez	a5,800408 <vprintfmt+0x208>
            for (; width > 0; width --) {
  800432:	01b05963          	blez	s11,800444 <vprintfmt+0x244>
  800436:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
  800438:	85a6                	mv	a1,s1
  80043a:	02000513          	li	a0,32
  80043e:	9902                	jalr	s2
            for (; width > 0; width --) {
  800440:	fe0d9be3          	bnez	s11,800436 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
  800444:	6a02                	ld	s4,0(sp)
  800446:	bbd5                	j	80023a <vprintfmt+0x3a>
    if (lflag >= 2) {
  800448:	4705                	li	a4,1
  80044a:	008a0c93          	addi	s9,s4,8
  80044e:	01174463          	blt	a4,a7,800456 <vprintfmt+0x256>
    else if (lflag) {
  800452:	08088d63          	beqz	a7,8004ec <vprintfmt+0x2ec>
        return va_arg(*ap, long);
  800456:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
  80045a:	0a044d63          	bltz	s0,800514 <vprintfmt+0x314>
            num = getint(&ap, lflag);
  80045e:	8622                	mv	a2,s0
  800460:	8a66                	mv	s4,s9
  800462:	46a9                	li	a3,10
  800464:	bdcd                	j	800356 <vprintfmt+0x156>
            err = va_arg(ap, int);
  800466:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  80046a:	4761                	li	a4,24
            err = va_arg(ap, int);
  80046c:	0a21                	addi	s4,s4,8
            if (err < 0) {
  80046e:	41f7d69b          	sraiw	a3,a5,0x1f
  800472:	8fb5                	xor	a5,a5,a3
  800474:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  800478:	02d74163          	blt	a4,a3,80049a <vprintfmt+0x29a>
  80047c:	00369793          	slli	a5,a3,0x3
  800480:	97de                	add	a5,a5,s7
  800482:	639c                	ld	a5,0(a5)
  800484:	cb99                	beqz	a5,80049a <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
  800486:	86be                	mv	a3,a5
  800488:	00000617          	auipc	a2,0x0
  80048c:	2b860613          	addi	a2,a2,696 # 800740 <main+0x1be>
  800490:	85a6                	mv	a1,s1
  800492:	854a                	mv	a0,s2
  800494:	0ce000ef          	jal	ra,800562 <printfmt>
  800498:	b34d                	j	80023a <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
  80049a:	00000617          	auipc	a2,0x0
  80049e:	29660613          	addi	a2,a2,662 # 800730 <main+0x1ae>
  8004a2:	85a6                	mv	a1,s1
  8004a4:	854a                	mv	a0,s2
  8004a6:	0bc000ef          	jal	ra,800562 <printfmt>
  8004aa:	bb41                	j	80023a <vprintfmt+0x3a>
                p = "(null)";
  8004ac:	00000417          	auipc	s0,0x0
  8004b0:	27c40413          	addi	s0,s0,636 # 800728 <main+0x1a6>
                for (width -= strnlen(p, precision); width > 0; width --) {
  8004b4:	85e2                	mv	a1,s8
  8004b6:	8522                	mv	a0,s0
  8004b8:	e43e                	sd	a5,8(sp)
  8004ba:	cadff0ef          	jal	ra,800166 <strnlen>
  8004be:	40ad8dbb          	subw	s11,s11,a0
  8004c2:	01b05b63          	blez	s11,8004d8 <vprintfmt+0x2d8>
  8004c6:	67a2                	ld	a5,8(sp)
  8004c8:	00078a1b          	sext.w	s4,a5
  8004cc:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
  8004ce:	85a6                	mv	a1,s1
  8004d0:	8552                	mv	a0,s4
  8004d2:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
  8004d4:	fe0d9ce3          	bnez	s11,8004cc <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8004d8:	00044783          	lbu	a5,0(s0)
  8004dc:	00140a13          	addi	s4,s0,1
  8004e0:	0007851b          	sext.w	a0,a5
  8004e4:	d3a5                	beqz	a5,800444 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
  8004e6:	05e00413          	li	s0,94
  8004ea:	bf39                	j	800408 <vprintfmt+0x208>
        return va_arg(*ap, int);
  8004ec:	000a2403          	lw	s0,0(s4)
  8004f0:	b7ad                	j	80045a <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
  8004f2:	000a6603          	lwu	a2,0(s4)
  8004f6:	46a1                	li	a3,8
  8004f8:	8a2e                	mv	s4,a1
  8004fa:	bdb1                	j	800356 <vprintfmt+0x156>
  8004fc:	000a6603          	lwu	a2,0(s4)
  800500:	46a9                	li	a3,10
  800502:	8a2e                	mv	s4,a1
  800504:	bd89                	j	800356 <vprintfmt+0x156>
  800506:	000a6603          	lwu	a2,0(s4)
  80050a:	46c1                	li	a3,16
  80050c:	8a2e                	mv	s4,a1
  80050e:	b5a1                	j	800356 <vprintfmt+0x156>
                    putch(ch, putdat);
  800510:	9902                	jalr	s2
  800512:	bf09                	j	800424 <vprintfmt+0x224>
                putch('-', putdat);
  800514:	85a6                	mv	a1,s1
  800516:	02d00513          	li	a0,45
  80051a:	e03e                	sd	a5,0(sp)
  80051c:	9902                	jalr	s2
                num = -(long long)num;
  80051e:	6782                	ld	a5,0(sp)
  800520:	8a66                	mv	s4,s9
  800522:	40800633          	neg	a2,s0
  800526:	46a9                	li	a3,10
  800528:	b53d                	j	800356 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
  80052a:	03b05163          	blez	s11,80054c <vprintfmt+0x34c>
  80052e:	02d00693          	li	a3,45
  800532:	f6d79de3          	bne	a5,a3,8004ac <vprintfmt+0x2ac>
                p = "(null)";
  800536:	00000417          	auipc	s0,0x0
  80053a:	1f240413          	addi	s0,s0,498 # 800728 <main+0x1a6>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  80053e:	02800793          	li	a5,40
  800542:	02800513          	li	a0,40
  800546:	00140a13          	addi	s4,s0,1
  80054a:	bd6d                	j	800404 <vprintfmt+0x204>
  80054c:	00000a17          	auipc	s4,0x0
  800550:	1dda0a13          	addi	s4,s4,477 # 800729 <main+0x1a7>
  800554:	02800513          	li	a0,40
  800558:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
  80055c:	05e00413          	li	s0,94
  800560:	b565                	j	800408 <vprintfmt+0x208>

0000000000800562 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  800562:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
  800564:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  800568:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
  80056a:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  80056c:	ec06                	sd	ra,24(sp)
  80056e:	f83a                	sd	a4,48(sp)
  800570:	fc3e                	sd	a5,56(sp)
  800572:	e0c2                	sd	a6,64(sp)
  800574:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  800576:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
  800578:	c89ff0ef          	jal	ra,800200 <vprintfmt>
}
  80057c:	60e2                	ld	ra,24(sp)
  80057e:	6161                	addi	sp,sp,80
  800580:	8082                	ret

0000000000800582 <main>:
          j = !j;
     }
}

int
main(void) {
  800582:	711d                	addi	sp,sp,-96
     //open this
     int i,time;
     memset(pids, 0, sizeof(pids));
  800584:	4651                	li	a2,20
  800586:	4581                	li	a1,0
  800588:	00001517          	auipc	a0,0x1
  80058c:	aa850513          	addi	a0,a0,-1368 # 801030 <pids>
main(void) {
  800590:	e8a2                	sd	s0,80(sp)
  800592:	e4a6                	sd	s1,72(sp)
  800594:	e0ca                	sd	s2,64(sp)
  800596:	fc4e                	sd	s3,56(sp)
  800598:	f852                	sd	s4,48(sp)
  80059a:	f456                	sd	s5,40(sp)
  80059c:	ec86                	sd	ra,88(sp)
     memset(pids, 0, sizeof(pids));
  80059e:	be5ff0ef          	jal	ra,800182 <memset>
     int goods[TOTAL]= {3,1,4,5,2};
  8005a2:	4795                	li	a5,5
  8005a4:	4705                	li	a4,1
  8005a6:	1782                	slli	a5,a5,0x20
  8005a8:	0791                	addi	a5,a5,4
  8005aa:	1702                	slli	a4,a4,0x20
  8005ac:	00001a17          	auipc	s4,0x1
  8005b0:	a54a0a13          	addi	s4,s4,-1452 # 801000 <acc>
  8005b4:	00001497          	auipc	s1,0x1
  8005b8:	a7c48493          	addi	s1,s1,-1412 # 801030 <pids>
  8005bc:	070d                	addi	a4,a4,3
  8005be:	e83e                	sd	a5,16(sp)
  8005c0:	4789                	li	a5,2
  8005c2:	e43a                	sd	a4,8(sp)
  8005c4:	cc3e                	sw	a5,24(sp)
     for (i = 0; i < TOTAL; i ++) {
  8005c6:	89d2                	mv	s3,s4
     int goods[TOTAL]= {3,1,4,5,2};
  8005c8:	8926                	mv	s2,s1
     for (i = 0; i < TOTAL; i ++) {
  8005ca:	4401                	li	s0,0
  8005cc:	4a95                	li	s5,5
          acc[i]=0;
  8005ce:	0009a023          	sw	zero,0(s3)
          if ((pids[i] = fork()) == 0) {
  8005d2:	b09ff0ef          	jal	ra,8000da <fork>
  8005d6:	00a92023          	sw	a0,0(s2)
  8005da:	c125                	beqz	a0,80063a <main+0xb8>
                         exit(acc[i]);
                    }

               }
          }
          if (pids[i] < 0) {
  8005dc:	0c054263          	bltz	a0,8006a0 <main+0x11e>
     for (i = 0; i < TOTAL; i ++) {
  8005e0:	2405                	addiw	s0,s0,1
  8005e2:	0991                	addi	s3,s3,4
  8005e4:	0911                	addi	s2,s2,4
  8005e6:	ff5414e3          	bne	s0,s5,8005ce <main+0x4c>
               goto failed;
          }
     }
     cprintf("main: fork ok,now need to wait pids.\n");
  8005ea:	00000517          	auipc	a0,0x0
  8005ee:	45650513          	addi	a0,a0,1110 # 800a40 <error_string+0xe0>
  8005f2:	b33ff0ef          	jal	ra,800124 <cprintf>

     for (i = 0; i < TOTAL; i ++) {
  8005f6:	00001417          	auipc	s0,0x1
  8005fa:	a2240413          	addi	s0,s0,-1502 # 801018 <status>
  8005fe:	00001917          	auipc	s2,0x1
  800602:	a2e90913          	addi	s2,s2,-1490 # 80102c <status+0x14>
         status[i]=0;
         waitpid(pids[i],&status[i]);
  800606:	4088                	lw	a0,0(s1)
         status[i]=0;
  800608:	00042023          	sw	zero,0(s0)
         waitpid(pids[i],&status[i]);
  80060c:	85a2                	mv	a1,s0
  80060e:	0411                	addi	s0,s0,4
  800610:	acdff0ef          	jal	ra,8000dc <waitpid>
     for (i = 0; i < TOTAL; i ++) {
  800614:	0491                	addi	s1,s1,4
  800616:	ff2418e3          	bne	s0,s2,800606 <main+0x84>
     }
     cprintf("main: wait pids over\n");
  80061a:	00000517          	auipc	a0,0x0
  80061e:	44e50513          	addi	a0,a0,1102 # 800a68 <error_string+0x108>
  800622:	b03ff0ef          	jal	ra,800124 <cprintf>
          if (pids[i] > 0) {
               kill(pids[i]);
          }
     }
     panic("FAIL: T.T\n");
}
  800626:	60e6                	ld	ra,88(sp)
  800628:	6446                	ld	s0,80(sp)
  80062a:	64a6                	ld	s1,72(sp)
  80062c:	6906                	ld	s2,64(sp)
  80062e:	79e2                	ld	s3,56(sp)
  800630:	7a42                	ld	s4,48(sp)
  800632:	7aa2                	ld	s5,40(sp)
  800634:	4501                	li	a0,0
  800636:	6125                	addi	sp,sp,96
  800638:	8082                	ret
               acc[i] = 0;
  80063a:	040a                	slli	s0,s0,0x2
  80063c:	008a04b3          	add	s1,s4,s0
                    if(acc[i]==200000){
  800640:	000319b7          	lui	s3,0x31
                         set_good(goods[i]);
  800644:	101c                	addi	a5,sp,32
                    if(acc[i]>4000000) {
  800646:	003d1937          	lui	s2,0x3d1
               acc[i] = 0;
  80064a:	0004a023          	sw	zero,0(s1)
                    if(acc[i]==200000){
  80064e:	d4098993          	addi	s3,s3,-704 # 30d40 <__panic-0x7cf2e0>
                         set_good(goods[i]);
  800652:	943e                	add	s0,s0,a5
                    if(acc[i]>4000000) {
  800654:	90090913          	addi	s2,s2,-1792 # 3d0900 <__panic-0x42f720>
     for (i = 0; i < TOTAL; i ++) {
  800658:	0c800713          	li	a4,200
          j = !j;
  80065c:	4792                	lw	a5,4(sp)
  80065e:	377d                	addiw	a4,a4,-1
  800660:	2781                	sext.w	a5,a5
  800662:	0017b793          	seqz	a5,a5
  800666:	c23e                	sw	a5,4(sp)
     for (i = 0; i != 200; ++ i)
  800668:	fb75                	bnez	a4,80065c <main+0xda>
                    ++ acc[i];
  80066a:	409c                	lw	a5,0(s1)
  80066c:	0017871b          	addiw	a4,a5,1
  800670:	c098                	sw	a4,0(s1)
                    if(acc[i]==200000){
  800672:	03370263          	beq	a4,s3,800696 <main+0x114>
                    if(acc[i]>4000000) {
  800676:	409c                	lw	a5,0(s1)
  800678:	fef970e3          	bgeu	s2,a5,800658 <main+0xd6>
                         cprintf("child pid %d, acc %d\n",getpid(),acc[i]);
  80067c:	a65ff0ef          	jal	ra,8000e0 <getpid>
  800680:	4090                	lw	a2,0(s1)
  800682:	85aa                	mv	a1,a0
  800684:	00000517          	auipc	a0,0x0
  800688:	3a450513          	addi	a0,a0,932 # 800a28 <error_string+0xc8>
  80068c:	a99ff0ef          	jal	ra,800124 <cprintf>
                         exit(acc[i]);
  800690:	4088                	lw	a0,0(s1)
  800692:	a33ff0ef          	jal	ra,8000c4 <exit>
                         set_good(goods[i]);
  800696:	fe842503          	lw	a0,-24(s0)
  80069a:	a49ff0ef          	jal	ra,8000e2 <set_good>
  80069e:	bfe1                	j	800676 <main+0xf4>
  8006a0:	00001417          	auipc	s0,0x1
  8006a4:	9a440413          	addi	s0,s0,-1628 # 801044 <pids+0x14>
          if (pids[i] > 0) {
  8006a8:	4088                	lw	a0,0(s1)
  8006aa:	00a05463          	blez	a0,8006b2 <main+0x130>
               kill(pids[i]);
  8006ae:	a31ff0ef          	jal	ra,8000de <kill>
     for (i = 0; i < TOTAL; i ++) {
  8006b2:	0491                	addi	s1,s1,4
  8006b4:	fe849ae3          	bne	s1,s0,8006a8 <main+0x126>
     panic("FAIL: T.T\n");
  8006b8:	00000617          	auipc	a2,0x0
  8006bc:	3c860613          	addi	a2,a2,968 # 800a80 <error_string+0x120>
  8006c0:	04500593          	li	a1,69
  8006c4:	00000517          	auipc	a0,0x0
  8006c8:	3cc50513          	addi	a0,a0,972 # 800a90 <error_string+0x130>
  8006cc:	955ff0ef          	jal	ra,800020 <__panic>
