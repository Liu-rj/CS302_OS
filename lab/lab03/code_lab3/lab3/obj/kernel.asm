
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <kern_entry>:
    80200000:	00003117          	auipc	sp,0x3
    80200004:	00010113          	mv	sp,sp
    80200008:	a009                	j	8020000a <kern_init>

000000008020000a <kern_init>:
    8020000a:	00003517          	auipc	a0,0x3
    8020000e:	ffe50513          	addi	a0,a0,-2 # 80203008 <edata>
    80200012:	00003617          	auipc	a2,0x3
    80200016:	ff660613          	addi	a2,a2,-10 # 80203008 <edata>
    8020001a:	1141                	addi	sp,sp,-16
    8020001c:	8e09                	sub	a2,a2,a0
    8020001e:	4581                	li	a1,0
    80200020:	e406                	sd	ra,8(sp)
    80200022:	0be000ef          	jal	ra,802000e0 <memset>
    80200026:	00000517          	auipc	a0,0x0
    8020002a:	0ea50513          	addi	a0,a0,234 # 80200110 <sbi_console_putchar+0x1e>
    8020002e:	01e000ef          	jal	ra,8020004c <cputs>
    80200032:	00000517          	auipc	a0,0x0
    80200036:	0f650513          	addi	a0,a0,246 # 80200128 <sbi_console_putchar+0x36>
    8020003a:	012000ef          	jal	ra,8020004c <cputs>
    8020003e:	00000517          	auipc	a0,0x0
    80200042:	0fa50513          	addi	a0,a0,250 # 80200138 <sbi_console_putchar+0x46>
    80200046:	046000ef          	jal	ra,8020008c <double_puts>
    8020004a:	a001                	j	8020004a <kern_init+0x40>

000000008020004c <cputs>:
    8020004c:	1101                	addi	sp,sp,-32
    8020004e:	e822                	sd	s0,16(sp)
    80200050:	ec06                	sd	ra,24(sp)
    80200052:	e426                	sd	s1,8(sp)
    80200054:	842a                	mv	s0,a0
    80200056:	00054503          	lbu	a0,0(a0)
    8020005a:	c51d                	beqz	a0,80200088 <cputs+0x3c>
    8020005c:	0405                	addi	s0,s0,1
    8020005e:	4485                	li	s1,1
    80200060:	9c81                	subw	s1,s1,s0
    80200062:	078000ef          	jal	ra,802000da <cons_putc>
    80200066:	00044503          	lbu	a0,0(s0)
    8020006a:	008487bb          	addw	a5,s1,s0
    8020006e:	0405                	addi	s0,s0,1
    80200070:	f96d                	bnez	a0,80200062 <cputs+0x16>
    80200072:	0017841b          	addiw	s0,a5,1
    80200076:	4529                	li	a0,10
    80200078:	062000ef          	jal	ra,802000da <cons_putc>
    8020007c:	60e2                	ld	ra,24(sp)
    8020007e:	8522                	mv	a0,s0
    80200080:	6442                	ld	s0,16(sp)
    80200082:	64a2                	ld	s1,8(sp)
    80200084:	6105                	addi	sp,sp,32
    80200086:	8082                	ret
    80200088:	4405                	li	s0,1
    8020008a:	b7f5                	j	80200076 <cputs+0x2a>

000000008020008c <double_puts>:
    8020008c:	1101                	addi	sp,sp,-32
    8020008e:	e426                	sd	s1,8(sp)
    80200090:	ec06                	sd	ra,24(sp)
    80200092:	e822                	sd	s0,16(sp)
    80200094:	e04a                	sd	s2,0(sp)
    80200096:	84aa                	mv	s1,a0
    80200098:	00054503          	lbu	a0,0(a0)
    8020009c:	cd0d                	beqz	a0,802000d6 <double_puts+0x4a>
    8020009e:	0485                	addi	s1,s1,1
    802000a0:	4901                	li	s2,0
    802000a2:	0005041b          	sext.w	s0,a0
    802000a6:	8522                	mv	a0,s0
    802000a8:	032000ef          	jal	ra,802000da <cons_putc>
    802000ac:	8522                	mv	a0,s0
    802000ae:	02c000ef          	jal	ra,802000da <cons_putc>
    802000b2:	0004c503          	lbu	a0,0(s1)
    802000b6:	0485                	addi	s1,s1,1
    802000b8:	87ca                	mv	a5,s2
    802000ba:	2909                	addiw	s2,s2,2
    802000bc:	f17d                	bnez	a0,802000a2 <double_puts+0x16>
    802000be:	0037841b          	addiw	s0,a5,3
    802000c2:	4529                	li	a0,10
    802000c4:	016000ef          	jal	ra,802000da <cons_putc>
    802000c8:	60e2                	ld	ra,24(sp)
    802000ca:	8522                	mv	a0,s0
    802000cc:	6442                	ld	s0,16(sp)
    802000ce:	64a2                	ld	s1,8(sp)
    802000d0:	6902                	ld	s2,0(sp)
    802000d2:	6105                	addi	sp,sp,32
    802000d4:	8082                	ret
    802000d6:	4405                	li	s0,1
    802000d8:	b7ed                	j	802000c2 <double_puts+0x36>

00000000802000da <cons_putc>:
    802000da:	0ff57513          	andi	a0,a0,255
    802000de:	a811                	j	802000f2 <sbi_console_putchar>

00000000802000e0 <memset>:
    802000e0:	ca01                	beqz	a2,802000f0 <memset+0x10>
    802000e2:	962a                	add	a2,a2,a0
    802000e4:	87aa                	mv	a5,a0
    802000e6:	0785                	addi	a5,a5,1
    802000e8:	feb78fa3          	sb	a1,-1(a5)
    802000ec:	fec79de3          	bne	a5,a2,802000e6 <memset+0x6>
    802000f0:	8082                	ret

00000000802000f2 <sbi_console_putchar>:
    802000f2:	4781                	li	a5,0
    802000f4:	00003717          	auipc	a4,0x3
    802000f8:	f0c73703          	ld	a4,-244(a4) # 80203000 <SBI_CONSOLE_PUTCHAR>
    802000fc:	88ba                	mv	a7,a4
    802000fe:	852a                	mv	a0,a0
    80200100:	85be                	mv	a1,a5
    80200102:	863e                	mv	a2,a5
    80200104:	00000073          	ecall
    80200108:	87aa                	mv	a5,a0
    8020010a:	8082                	ret
