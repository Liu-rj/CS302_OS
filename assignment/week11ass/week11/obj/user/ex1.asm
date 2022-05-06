
obj/__user_ex1.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <syscall>:
#include <syscall.h>

#define MAX_ARGS            5

static inline int
syscall(int64_t num, ...) {
  800020:	7175                	addi	sp,sp,-144
  800022:	f8ba                	sd	a4,112(sp)
    va_list ap;
    va_start(ap, num);
    uint64_t a[MAX_ARGS];
    int i, ret;
    for (i = 0; i < MAX_ARGS; i ++) {
        a[i] = va_arg(ap, uint64_t);
  800024:	e0ba                	sd	a4,64(sp)
  800026:	0118                	addi	a4,sp,128
syscall(int64_t num, ...) {
  800028:	e42a                	sd	a0,8(sp)
  80002a:	ecae                	sd	a1,88(sp)
  80002c:	f0b2                	sd	a2,96(sp)
  80002e:	f4b6                	sd	a3,104(sp)
  800030:	fcbe                	sd	a5,120(sp)
  800032:	e142                	sd	a6,128(sp)
  800034:	e546                	sd	a7,136(sp)
        a[i] = va_arg(ap, uint64_t);
  800036:	f42e                	sd	a1,40(sp)
  800038:	f832                	sd	a2,48(sp)
  80003a:	fc36                	sd	a3,56(sp)
  80003c:	f03a                	sd	a4,32(sp)
  80003e:	e4be                	sd	a5,72(sp)
    }
    va_end(ap);
    asm volatile (
  800040:	4522                	lw	a0,8(sp)
  800042:	55a2                	lw	a1,40(sp)
  800044:	5642                	lw	a2,48(sp)
  800046:	56e2                	lw	a3,56(sp)
  800048:	4706                	lw	a4,64(sp)
  80004a:	47a6                	lw	a5,72(sp)
  80004c:	00000073          	ecall
  800050:	ce2a                	sw	a0,28(sp)
          "m" (a[3]),
          "m" (a[4])
        : "memory"
      );
    return ret;
}
  800052:	4572                	lw	a0,28(sp)
  800054:	6149                	addi	sp,sp,144
  800056:	8082                	ret

0000000000800058 <sys_exit>:

int
sys_exit(int64_t error_code) {
  800058:	85aa                	mv	a1,a0
    return syscall(SYS_exit, error_code);
  80005a:	4505                	li	a0,1
  80005c:	b7d1                	j	800020 <syscall>

000000000080005e <sys_putc>:
sys_getpid(void) {
    return syscall(SYS_getpid);
}

int
sys_putc(int64_t c) {
  80005e:	85aa                	mv	a1,a0
    return syscall(SYS_putc, c);
  800060:	4579                	li	a0,30
  800062:	bf7d                	j	800020 <syscall>

0000000000800064 <sys_setpriority>:
sys_gettime(void) {
    return syscall(SYS_gettime);
}

void
sys_setpriority(int priority) {
  800064:	85aa                	mv	a1,a0
    syscall(SYS_labschedule_set_priority, priority);
  800066:	0ff00513          	li	a0,255
  80006a:	bf5d                	j	800020 <syscall>

000000000080006c <exit>:
#include <syscall.h>
#include <stdio.h>
#include <ulib.h>

void
exit(int error_code) {
  80006c:	1141                	addi	sp,sp,-16
  80006e:	e406                	sd	ra,8(sp)
    //cprintf("eee\n");
    sys_exit(error_code);
  800070:	fe9ff0ef          	jal	ra,800058 <sys_exit>
    cprintf("BUG: exit failed.\n");
  800074:	00000517          	auipc	a0,0x0
  800078:	4ac50513          	addi	a0,a0,1196 # 800520 <main+0x30>
  80007c:	028000ef          	jal	ra,8000a4 <cprintf>
    while (1);
  800080:	a001                	j	800080 <exit+0x14>

0000000000800082 <set_priority>:
    return (unsigned int)sys_gettime();
}

void
set_priority(int priority) {
    sys_setpriority(priority);
  800082:	b7cd                	j	800064 <sys_setpriority>

0000000000800084 <_start>:
    # move down the esp register
    # since it may cause page fault in backtrace
    // subl $0x20, %esp

    # call user-program function
    call umain
  800084:	056000ef          	jal	ra,8000da <umain>
1:  j 1b
  800088:	a001                	j	800088 <_start+0x4>

000000000080008a <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  80008a:	1141                	addi	sp,sp,-16
  80008c:	e022                	sd	s0,0(sp)
  80008e:	e406                	sd	ra,8(sp)
  800090:	842e                	mv	s0,a1
    sys_putc(c);
  800092:	fcdff0ef          	jal	ra,80005e <sys_putc>
    (*cnt) ++;
  800096:	401c                	lw	a5,0(s0)
}
  800098:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
  80009a:	2785                	addiw	a5,a5,1
  80009c:	c01c                	sw	a5,0(s0)
}
  80009e:	6402                	ld	s0,0(sp)
  8000a0:	0141                	addi	sp,sp,16
  8000a2:	8082                	ret

00000000008000a4 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  8000a4:	711d                	addi	sp,sp,-96
    va_list ap;

    va_start(ap, fmt);
  8000a6:	02810313          	addi	t1,sp,40
cprintf(const char *fmt, ...) {
  8000aa:	8e2a                	mv	t3,a0
  8000ac:	f42e                	sd	a1,40(sp)
  8000ae:	f832                	sd	a2,48(sp)
  8000b0:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  8000b2:	00000517          	auipc	a0,0x0
  8000b6:	fd850513          	addi	a0,a0,-40 # 80008a <cputch>
  8000ba:	004c                	addi	a1,sp,4
  8000bc:	869a                	mv	a3,t1
  8000be:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
  8000c0:	ec06                	sd	ra,24(sp)
  8000c2:	e0ba                	sd	a4,64(sp)
  8000c4:	e4be                	sd	a5,72(sp)
  8000c6:	e8c2                	sd	a6,80(sp)
  8000c8:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
  8000ca:	e41a                	sd	t1,8(sp)
    int cnt = 0;
  8000cc:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  8000ce:	0a0000ef          	jal	ra,80016e <vprintfmt>
    int cnt = vcprintf(fmt, ap);
    va_end(ap);

    return cnt;
}
  8000d2:	60e2                	ld	ra,24(sp)
  8000d4:	4512                	lw	a0,4(sp)
  8000d6:	6125                	addi	sp,sp,96
  8000d8:	8082                	ret

00000000008000da <umain>:
#include <ulib.h>

int main(void);

void
umain(void) {
  8000da:	1141                	addi	sp,sp,-16
  8000dc:	e406                	sd	ra,8(sp)
    int ret = main();
  8000de:	412000ef          	jal	ra,8004f0 <main>
    exit(ret);
  8000e2:	f8bff0ef          	jal	ra,80006c <exit>

00000000008000e6 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  8000e6:	872a                	mv	a4,a0
    size_t cnt = 0;
  8000e8:	4501                	li	a0,0
    while (cnt < len && *s ++ != '\0') {
  8000ea:	e589                	bnez	a1,8000f4 <strnlen+0xe>
  8000ec:	a811                	j	800100 <strnlen+0x1a>
        cnt ++;
  8000ee:	0505                	addi	a0,a0,1
    while (cnt < len && *s ++ != '\0') {
  8000f0:	00a58763          	beq	a1,a0,8000fe <strnlen+0x18>
  8000f4:	00a707b3          	add	a5,a4,a0
  8000f8:	0007c783          	lbu	a5,0(a5)
  8000fc:	fbed                	bnez	a5,8000ee <strnlen+0x8>
    }
    return cnt;
}
  8000fe:	8082                	ret
  800100:	8082                	ret

0000000000800102 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
  800102:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  800106:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
  800108:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  80010c:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
  80010e:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
  800112:	f022                	sd	s0,32(sp)
  800114:	ec26                	sd	s1,24(sp)
  800116:	e84a                	sd	s2,16(sp)
  800118:	f406                	sd	ra,40(sp)
  80011a:	e44e                	sd	s3,8(sp)
  80011c:	84aa                	mv	s1,a0
  80011e:	892e                	mv	s2,a1
  800120:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
  800124:	2a01                	sext.w	s4,s4

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  800126:	03067e63          	bgeu	a2,a6,800162 <printnum+0x60>
  80012a:	89be                	mv	s3,a5
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  80012c:	00805763          	blez	s0,80013a <printnum+0x38>
  800130:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
  800132:	85ca                	mv	a1,s2
  800134:	854e                	mv	a0,s3
  800136:	9482                	jalr	s1
        while (-- width > 0)
  800138:	fc65                	bnez	s0,800130 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  80013a:	1a02                	slli	s4,s4,0x20
  80013c:	020a5a13          	srli	s4,s4,0x20
  800140:	00000797          	auipc	a5,0x0
  800144:	3f878793          	addi	a5,a5,1016 # 800538 <main+0x48>
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
  800148:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
  80014a:	9a3e                	add	s4,s4,a5
  80014c:	000a4503          	lbu	a0,0(s4)
}
  800150:	70a2                	ld	ra,40(sp)
  800152:	69a2                	ld	s3,8(sp)
  800154:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
  800156:	85ca                	mv	a1,s2
  800158:	8326                	mv	t1,s1
}
  80015a:	6942                	ld	s2,16(sp)
  80015c:	64e2                	ld	s1,24(sp)
  80015e:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
  800160:	8302                	jr	t1
        printnum(putch, putdat, result, base, width - 1, padc);
  800162:	03065633          	divu	a2,a2,a6
  800166:	8722                	mv	a4,s0
  800168:	f9bff0ef          	jal	ra,800102 <printnum>
  80016c:	b7f9                	j	80013a <printnum+0x38>

000000000080016e <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  80016e:	7119                	addi	sp,sp,-128
  800170:	f4a6                	sd	s1,104(sp)
  800172:	f0ca                	sd	s2,96(sp)
  800174:	ecce                	sd	s3,88(sp)
  800176:	e8d2                	sd	s4,80(sp)
  800178:	e4d6                	sd	s5,72(sp)
  80017a:	e0da                	sd	s6,64(sp)
  80017c:	fc5e                	sd	s7,56(sp)
  80017e:	f06a                	sd	s10,32(sp)
  800180:	fc86                	sd	ra,120(sp)
  800182:	f8a2                	sd	s0,112(sp)
  800184:	f862                	sd	s8,48(sp)
  800186:	f466                	sd	s9,40(sp)
  800188:	ec6e                	sd	s11,24(sp)
  80018a:	892a                	mv	s2,a0
  80018c:	84ae                	mv	s1,a1
  80018e:	8d32                	mv	s10,a2
  800190:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800192:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
  800196:	5b7d                	li	s6,-1
  800198:	00000a97          	auipc	s5,0x0
  80019c:	3d4a8a93          	addi	s5,s5,980 # 80056c <main+0x7c>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  8001a0:	00000b97          	auipc	s7,0x0
  8001a4:	5e8b8b93          	addi	s7,s7,1512 # 800788 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001a8:	000d4503          	lbu	a0,0(s10)
  8001ac:	001d0413          	addi	s0,s10,1
  8001b0:	01350a63          	beq	a0,s3,8001c4 <vprintfmt+0x56>
            if (ch == '\0') {
  8001b4:	c121                	beqz	a0,8001f4 <vprintfmt+0x86>
            putch(ch, putdat);
  8001b6:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001b8:	0405                	addi	s0,s0,1
            putch(ch, putdat);
  8001ba:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001bc:	fff44503          	lbu	a0,-1(s0)
  8001c0:	ff351ae3          	bne	a0,s3,8001b4 <vprintfmt+0x46>
  8001c4:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
  8001c8:	02000793          	li	a5,32
        lflag = altflag = 0;
  8001cc:	4c81                	li	s9,0
  8001ce:	4881                	li	a7,0
        width = precision = -1;
  8001d0:	5c7d                	li	s8,-1
  8001d2:	5dfd                	li	s11,-1
  8001d4:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
  8001d8:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
  8001da:	fdd6059b          	addiw	a1,a2,-35
  8001de:	0ff5f593          	andi	a1,a1,255
  8001e2:	00140d13          	addi	s10,s0,1
  8001e6:	04b56263          	bltu	a0,a1,80022a <vprintfmt+0xbc>
  8001ea:	058a                	slli	a1,a1,0x2
  8001ec:	95d6                	add	a1,a1,s5
  8001ee:	4194                	lw	a3,0(a1)
  8001f0:	96d6                	add	a3,a3,s5
  8001f2:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  8001f4:	70e6                	ld	ra,120(sp)
  8001f6:	7446                	ld	s0,112(sp)
  8001f8:	74a6                	ld	s1,104(sp)
  8001fa:	7906                	ld	s2,96(sp)
  8001fc:	69e6                	ld	s3,88(sp)
  8001fe:	6a46                	ld	s4,80(sp)
  800200:	6aa6                	ld	s5,72(sp)
  800202:	6b06                	ld	s6,64(sp)
  800204:	7be2                	ld	s7,56(sp)
  800206:	7c42                	ld	s8,48(sp)
  800208:	7ca2                	ld	s9,40(sp)
  80020a:	7d02                	ld	s10,32(sp)
  80020c:	6de2                	ld	s11,24(sp)
  80020e:	6109                	addi	sp,sp,128
  800210:	8082                	ret
            padc = '0';
  800212:	87b2                	mv	a5,a2
            goto reswitch;
  800214:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  800218:	846a                	mv	s0,s10
  80021a:	00140d13          	addi	s10,s0,1
  80021e:	fdd6059b          	addiw	a1,a2,-35
  800222:	0ff5f593          	andi	a1,a1,255
  800226:	fcb572e3          	bgeu	a0,a1,8001ea <vprintfmt+0x7c>
            putch('%', putdat);
  80022a:	85a6                	mv	a1,s1
  80022c:	02500513          	li	a0,37
  800230:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
  800232:	fff44783          	lbu	a5,-1(s0)
  800236:	8d22                	mv	s10,s0
  800238:	f73788e3          	beq	a5,s3,8001a8 <vprintfmt+0x3a>
  80023c:	ffed4783          	lbu	a5,-2(s10)
  800240:	1d7d                	addi	s10,s10,-1
  800242:	ff379de3          	bne	a5,s3,80023c <vprintfmt+0xce>
  800246:	b78d                	j	8001a8 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
  800248:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
  80024c:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  800250:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
  800252:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
  800256:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  80025a:	02d86463          	bltu	a6,a3,800282 <vprintfmt+0x114>
                ch = *fmt;
  80025e:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
  800262:	002c169b          	slliw	a3,s8,0x2
  800266:	0186873b          	addw	a4,a3,s8
  80026a:	0017171b          	slliw	a4,a4,0x1
  80026e:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
  800270:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
  800274:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
  800276:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
  80027a:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  80027e:	fed870e3          	bgeu	a6,a3,80025e <vprintfmt+0xf0>
            if (width < 0)
  800282:	f40ddce3          	bgez	s11,8001da <vprintfmt+0x6c>
                width = precision, precision = -1;
  800286:	8de2                	mv	s11,s8
  800288:	5c7d                	li	s8,-1
  80028a:	bf81                	j	8001da <vprintfmt+0x6c>
            if (width < 0)
  80028c:	fffdc693          	not	a3,s11
  800290:	96fd                	srai	a3,a3,0x3f
  800292:	00ddfdb3          	and	s11,s11,a3
  800296:	00144603          	lbu	a2,1(s0)
  80029a:	2d81                	sext.w	s11,s11
        switch (ch = *(unsigned char *)fmt ++) {
  80029c:	846a                	mv	s0,s10
            goto reswitch;
  80029e:	bf35                	j	8001da <vprintfmt+0x6c>
            precision = va_arg(ap, int);
  8002a0:	000a2c03          	lw	s8,0(s4)
            goto process_precision;
  8002a4:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
  8002a8:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
  8002aa:	846a                	mv	s0,s10
            goto process_precision;
  8002ac:	bfd9                	j	800282 <vprintfmt+0x114>
    if (lflag >= 2) {
  8002ae:	4705                	li	a4,1
  8002b0:	008a0593          	addi	a1,s4,8
  8002b4:	01174463          	blt	a4,a7,8002bc <vprintfmt+0x14e>
    else if (lflag) {
  8002b8:	1a088e63          	beqz	a7,800474 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
  8002bc:	000a3603          	ld	a2,0(s4)
  8002c0:	46c1                	li	a3,16
  8002c2:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
  8002c4:	2781                	sext.w	a5,a5
  8002c6:	876e                	mv	a4,s11
  8002c8:	85a6                	mv	a1,s1
  8002ca:	854a                	mv	a0,s2
  8002cc:	e37ff0ef          	jal	ra,800102 <printnum>
            break;
  8002d0:	bde1                	j	8001a8 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
  8002d2:	000a2503          	lw	a0,0(s4)
  8002d6:	85a6                	mv	a1,s1
  8002d8:	0a21                	addi	s4,s4,8
  8002da:	9902                	jalr	s2
            break;
  8002dc:	b5f1                	j	8001a8 <vprintfmt+0x3a>
    if (lflag >= 2) {
  8002de:	4705                	li	a4,1
  8002e0:	008a0593          	addi	a1,s4,8
  8002e4:	01174463          	blt	a4,a7,8002ec <vprintfmt+0x17e>
    else if (lflag) {
  8002e8:	18088163          	beqz	a7,80046a <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
  8002ec:	000a3603          	ld	a2,0(s4)
  8002f0:	46a9                	li	a3,10
  8002f2:	8a2e                	mv	s4,a1
  8002f4:	bfc1                	j	8002c4 <vprintfmt+0x156>
            goto reswitch;
  8002f6:	00144603          	lbu	a2,1(s0)
            altflag = 1;
  8002fa:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
  8002fc:	846a                	mv	s0,s10
            goto reswitch;
  8002fe:	bdf1                	j	8001da <vprintfmt+0x6c>
            putch(ch, putdat);
  800300:	85a6                	mv	a1,s1
  800302:	02500513          	li	a0,37
  800306:	9902                	jalr	s2
            break;
  800308:	b545                	j	8001a8 <vprintfmt+0x3a>
            lflag ++;
  80030a:	00144603          	lbu	a2,1(s0)
  80030e:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
  800310:	846a                	mv	s0,s10
            goto reswitch;
  800312:	b5e1                	j	8001da <vprintfmt+0x6c>
    if (lflag >= 2) {
  800314:	4705                	li	a4,1
  800316:	008a0593          	addi	a1,s4,8
  80031a:	01174463          	blt	a4,a7,800322 <vprintfmt+0x1b4>
    else if (lflag) {
  80031e:	14088163          	beqz	a7,800460 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
  800322:	000a3603          	ld	a2,0(s4)
  800326:	46a1                	li	a3,8
  800328:	8a2e                	mv	s4,a1
  80032a:	bf69                	j	8002c4 <vprintfmt+0x156>
            putch('0', putdat);
  80032c:	03000513          	li	a0,48
  800330:	85a6                	mv	a1,s1
  800332:	e03e                	sd	a5,0(sp)
  800334:	9902                	jalr	s2
            putch('x', putdat);
  800336:	85a6                	mv	a1,s1
  800338:	07800513          	li	a0,120
  80033c:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  80033e:	0a21                	addi	s4,s4,8
            goto number;
  800340:	6782                	ld	a5,0(sp)
  800342:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  800344:	ff8a3603          	ld	a2,-8(s4)
            goto number;
  800348:	bfb5                	j	8002c4 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
  80034a:	000a3403          	ld	s0,0(s4)
  80034e:	008a0713          	addi	a4,s4,8
  800352:	e03a                	sd	a4,0(sp)
  800354:	14040263          	beqz	s0,800498 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
  800358:	0fb05763          	blez	s11,800446 <vprintfmt+0x2d8>
  80035c:	02d00693          	li	a3,45
  800360:	0cd79163          	bne	a5,a3,800422 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800364:	00044783          	lbu	a5,0(s0)
  800368:	0007851b          	sext.w	a0,a5
  80036c:	cf85                	beqz	a5,8003a4 <vprintfmt+0x236>
  80036e:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
  800372:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800376:	000c4563          	bltz	s8,800380 <vprintfmt+0x212>
  80037a:	3c7d                	addiw	s8,s8,-1
  80037c:	036c0263          	beq	s8,s6,8003a0 <vprintfmt+0x232>
                    putch('?', putdat);
  800380:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
  800382:	0e0c8e63          	beqz	s9,80047e <vprintfmt+0x310>
  800386:	3781                	addiw	a5,a5,-32
  800388:	0ef47b63          	bgeu	s0,a5,80047e <vprintfmt+0x310>
                    putch('?', putdat);
  80038c:	03f00513          	li	a0,63
  800390:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800392:	000a4783          	lbu	a5,0(s4)
  800396:	3dfd                	addiw	s11,s11,-1
  800398:	0a05                	addi	s4,s4,1
  80039a:	0007851b          	sext.w	a0,a5
  80039e:	ffe1                	bnez	a5,800376 <vprintfmt+0x208>
            for (; width > 0; width --) {
  8003a0:	01b05963          	blez	s11,8003b2 <vprintfmt+0x244>
  8003a4:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
  8003a6:	85a6                	mv	a1,s1
  8003a8:	02000513          	li	a0,32
  8003ac:	9902                	jalr	s2
            for (; width > 0; width --) {
  8003ae:	fe0d9be3          	bnez	s11,8003a4 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
  8003b2:	6a02                	ld	s4,0(sp)
  8003b4:	bbd5                	j	8001a8 <vprintfmt+0x3a>
    if (lflag >= 2) {
  8003b6:	4705                	li	a4,1
  8003b8:	008a0c93          	addi	s9,s4,8
  8003bc:	01174463          	blt	a4,a7,8003c4 <vprintfmt+0x256>
    else if (lflag) {
  8003c0:	08088d63          	beqz	a7,80045a <vprintfmt+0x2ec>
        return va_arg(*ap, long);
  8003c4:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
  8003c8:	0a044d63          	bltz	s0,800482 <vprintfmt+0x314>
            num = getint(&ap, lflag);
  8003cc:	8622                	mv	a2,s0
  8003ce:	8a66                	mv	s4,s9
  8003d0:	46a9                	li	a3,10
  8003d2:	bdcd                	j	8002c4 <vprintfmt+0x156>
            err = va_arg(ap, int);
  8003d4:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  8003d8:	4761                	li	a4,24
            err = va_arg(ap, int);
  8003da:	0a21                	addi	s4,s4,8
            if (err < 0) {
  8003dc:	41f7d69b          	sraiw	a3,a5,0x1f
  8003e0:	8fb5                	xor	a5,a5,a3
  8003e2:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  8003e6:	02d74163          	blt	a4,a3,800408 <vprintfmt+0x29a>
  8003ea:	00369793          	slli	a5,a3,0x3
  8003ee:	97de                	add	a5,a5,s7
  8003f0:	639c                	ld	a5,0(a5)
  8003f2:	cb99                	beqz	a5,800408 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
  8003f4:	86be                	mv	a3,a5
  8003f6:	00000617          	auipc	a2,0x0
  8003fa:	17260613          	addi	a2,a2,370 # 800568 <main+0x78>
  8003fe:	85a6                	mv	a1,s1
  800400:	854a                	mv	a0,s2
  800402:	0ce000ef          	jal	ra,8004d0 <printfmt>
  800406:	b34d                	j	8001a8 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
  800408:	00000617          	auipc	a2,0x0
  80040c:	15060613          	addi	a2,a2,336 # 800558 <main+0x68>
  800410:	85a6                	mv	a1,s1
  800412:	854a                	mv	a0,s2
  800414:	0bc000ef          	jal	ra,8004d0 <printfmt>
  800418:	bb41                	j	8001a8 <vprintfmt+0x3a>
                p = "(null)";
  80041a:	00000417          	auipc	s0,0x0
  80041e:	13640413          	addi	s0,s0,310 # 800550 <main+0x60>
                for (width -= strnlen(p, precision); width > 0; width --) {
  800422:	85e2                	mv	a1,s8
  800424:	8522                	mv	a0,s0
  800426:	e43e                	sd	a5,8(sp)
  800428:	cbfff0ef          	jal	ra,8000e6 <strnlen>
  80042c:	40ad8dbb          	subw	s11,s11,a0
  800430:	01b05b63          	blez	s11,800446 <vprintfmt+0x2d8>
  800434:	67a2                	ld	a5,8(sp)
  800436:	00078a1b          	sext.w	s4,a5
  80043a:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
  80043c:	85a6                	mv	a1,s1
  80043e:	8552                	mv	a0,s4
  800440:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
  800442:	fe0d9ce3          	bnez	s11,80043a <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800446:	00044783          	lbu	a5,0(s0)
  80044a:	00140a13          	addi	s4,s0,1
  80044e:	0007851b          	sext.w	a0,a5
  800452:	d3a5                	beqz	a5,8003b2 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
  800454:	05e00413          	li	s0,94
  800458:	bf39                	j	800376 <vprintfmt+0x208>
        return va_arg(*ap, int);
  80045a:	000a2403          	lw	s0,0(s4)
  80045e:	b7ad                	j	8003c8 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
  800460:	000a6603          	lwu	a2,0(s4)
  800464:	46a1                	li	a3,8
  800466:	8a2e                	mv	s4,a1
  800468:	bdb1                	j	8002c4 <vprintfmt+0x156>
  80046a:	000a6603          	lwu	a2,0(s4)
  80046e:	46a9                	li	a3,10
  800470:	8a2e                	mv	s4,a1
  800472:	bd89                	j	8002c4 <vprintfmt+0x156>
  800474:	000a6603          	lwu	a2,0(s4)
  800478:	46c1                	li	a3,16
  80047a:	8a2e                	mv	s4,a1
  80047c:	b5a1                	j	8002c4 <vprintfmt+0x156>
                    putch(ch, putdat);
  80047e:	9902                	jalr	s2
  800480:	bf09                	j	800392 <vprintfmt+0x224>
                putch('-', putdat);
  800482:	85a6                	mv	a1,s1
  800484:	02d00513          	li	a0,45
  800488:	e03e                	sd	a5,0(sp)
  80048a:	9902                	jalr	s2
                num = -(long long)num;
  80048c:	6782                	ld	a5,0(sp)
  80048e:	8a66                	mv	s4,s9
  800490:	40800633          	neg	a2,s0
  800494:	46a9                	li	a3,10
  800496:	b53d                	j	8002c4 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
  800498:	03b05163          	blez	s11,8004ba <vprintfmt+0x34c>
  80049c:	02d00693          	li	a3,45
  8004a0:	f6d79de3          	bne	a5,a3,80041a <vprintfmt+0x2ac>
                p = "(null)";
  8004a4:	00000417          	auipc	s0,0x0
  8004a8:	0ac40413          	addi	s0,s0,172 # 800550 <main+0x60>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8004ac:	02800793          	li	a5,40
  8004b0:	02800513          	li	a0,40
  8004b4:	00140a13          	addi	s4,s0,1
  8004b8:	bd6d                	j	800372 <vprintfmt+0x204>
  8004ba:	00000a17          	auipc	s4,0x0
  8004be:	097a0a13          	addi	s4,s4,151 # 800551 <main+0x61>
  8004c2:	02800513          	li	a0,40
  8004c6:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
  8004ca:	05e00413          	li	s0,94
  8004ce:	b565                	j	800376 <vprintfmt+0x208>

00000000008004d0 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004d0:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
  8004d2:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004d6:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
  8004d8:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004da:	ec06                	sd	ra,24(sp)
  8004dc:	f83a                	sd	a4,48(sp)
  8004de:	fc3e                	sd	a5,56(sp)
  8004e0:	e0c2                	sd	a6,64(sp)
  8004e2:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  8004e4:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
  8004e6:	c89ff0ef          	jal	ra,80016e <vprintfmt>
}
  8004ea:	60e2                	ld	ra,24(sp)
  8004ec:	6161                	addi	sp,sp,80
  8004ee:	8082                	ret

00000000008004f0 <main>:
#include <string.h>
#include <stdlib.h>


int
main(void) {
  8004f0:	1141                	addi	sp,sp,-16
    //open this!
    cprintf("\n-------ex1---start------\n");
  8004f2:	00000517          	auipc	a0,0x0
  8004f6:	35e50513          	addi	a0,a0,862 # 800850 <error_string+0xc8>
main(void) {
  8004fa:	e406                	sd	ra,8(sp)
    cprintf("\n-------ex1---start------\n");
  8004fc:	ba9ff0ef          	jal	ra,8000a4 <cprintf>
    set_priority(5);
  800500:	4515                	li	a0,5
  800502:	b81ff0ef          	jal	ra,800082 <set_priority>
    cprintf("-------ex1----end-------\n\n");
  800506:	00000517          	auipc	a0,0x0
  80050a:	36a50513          	addi	a0,a0,874 # 800870 <error_string+0xe8>
  80050e:	b97ff0ef          	jal	ra,8000a4 <cprintf>
}
  800512:	60a2                	ld	ra,8(sp)
  800514:	4501                	li	a0,0
  800516:	0141                	addi	sp,sp,16
  800518:	8082                	ret
