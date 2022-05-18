
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
ffffffffc0200000:	c020d2b7          	lui	t0,0xc020d
ffffffffc0200004:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200008:	037a                	slli	t1,t1,0x1e
ffffffffc020000a:	406282b3          	sub	t0,t0,t1
ffffffffc020000e:	00c2d293          	srli	t0,t0,0xc
ffffffffc0200012:	fff0031b          	addiw	t1,zero,-1
ffffffffc0200016:	137e                	slli	t1,t1,0x3f
ffffffffc0200018:	0062e2b3          	or	t0,t0,t1
ffffffffc020001c:	18029073          	csrw	satp,t0
ffffffffc0200020:	12000073          	sfence.vma
ffffffffc0200024:	c020d137          	lui	sp,0xc020d
ffffffffc0200028:	c02002b7          	lui	t0,0xc0200
ffffffffc020002c:	03228293          	addi	t0,t0,50 # ffffffffc0200032 <kern_init>
ffffffffc0200030:	8282                	jr	t0

ffffffffc0200032 <kern_init>:
ffffffffc0200032:	0000e517          	auipc	a0,0xe
ffffffffc0200036:	05e50513          	addi	a0,a0,94 # ffffffffc020e090 <buf>
ffffffffc020003a:	00019617          	auipc	a2,0x19
ffffffffc020003e:	6ce60613          	addi	a2,a2,1742 # ffffffffc0219708 <end>
ffffffffc0200042:	1141                	addi	sp,sp,-16
ffffffffc0200044:	8e09                	sub	a2,a2,a0
ffffffffc0200046:	4581                	li	a1,0
ffffffffc0200048:	e406                	sd	ra,8(sp)
ffffffffc020004a:	2cd070ef          	jal	ra,ffffffffc0207b16 <memset>
ffffffffc020004e:	570000ef          	jal	ra,ffffffffc02005be <cons_init>
ffffffffc0200052:	00008597          	auipc	a1,0x8
ffffffffc0200056:	ef658593          	addi	a1,a1,-266 # ffffffffc0207f48 <etext+0x4>
ffffffffc020005a:	00008517          	auipc	a0,0x8
ffffffffc020005e:	f0650513          	addi	a0,a0,-250 # ffffffffc0207f60 <etext+0x1c>
ffffffffc0200062:	06a000ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200066:	5f5000ef          	jal	ra,ffffffffc0200e5a <pmm_init>
ffffffffc020006a:	5c6000ef          	jal	ra,ffffffffc0200630 <pic_init>
ffffffffc020006e:	5d0000ef          	jal	ra,ffffffffc020063e <idt_init>
ffffffffc0200072:	237010ef          	jal	ra,ffffffffc0201aa8 <vmm_init>
ffffffffc0200076:	117040ef          	jal	ra,ffffffffc020498c <sched_init>
ffffffffc020007a:	704040ef          	jal	ra,ffffffffc020477e <proc_init>
ffffffffc020007e:	4a2000ef          	jal	ra,ffffffffc0200520 <ide_init>
ffffffffc0200082:	3bf010ef          	jal	ra,ffffffffc0201c40 <swap_init>
ffffffffc0200086:	4f0000ef          	jal	ra,ffffffffc0200576 <clock_init>
ffffffffc020008a:	5a8000ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc020008e:	027040ef          	jal	ra,ffffffffc02048b4 <cpu_idle>

ffffffffc0200092 <cputch>:
ffffffffc0200092:	1141                	addi	sp,sp,-16
ffffffffc0200094:	e022                	sd	s0,0(sp)
ffffffffc0200096:	e406                	sd	ra,8(sp)
ffffffffc0200098:	842e                	mv	s0,a1
ffffffffc020009a:	526000ef          	jal	ra,ffffffffc02005c0 <cons_putc>
ffffffffc020009e:	401c                	lw	a5,0(s0)
ffffffffc02000a0:	60a2                	ld	ra,8(sp)
ffffffffc02000a2:	2785                	addiw	a5,a5,1
ffffffffc02000a4:	c01c                	sw	a5,0(s0)
ffffffffc02000a6:	6402                	ld	s0,0(sp)
ffffffffc02000a8:	0141                	addi	sp,sp,16
ffffffffc02000aa:	8082                	ret

ffffffffc02000ac <vcprintf>:
ffffffffc02000ac:	1101                	addi	sp,sp,-32
ffffffffc02000ae:	862a                	mv	a2,a0
ffffffffc02000b0:	86ae                	mv	a3,a1
ffffffffc02000b2:	00000517          	auipc	a0,0x0
ffffffffc02000b6:	fe050513          	addi	a0,a0,-32 # ffffffffc0200092 <cputch>
ffffffffc02000ba:	006c                	addi	a1,sp,12
ffffffffc02000bc:	ec06                	sd	ra,24(sp)
ffffffffc02000be:	c602                	sw	zero,12(sp)
ffffffffc02000c0:	2ed070ef          	jal	ra,ffffffffc0207bac <vprintfmt>
ffffffffc02000c4:	60e2                	ld	ra,24(sp)
ffffffffc02000c6:	4532                	lw	a0,12(sp)
ffffffffc02000c8:	6105                	addi	sp,sp,32
ffffffffc02000ca:	8082                	ret

ffffffffc02000cc <cprintf>:
ffffffffc02000cc:	711d                	addi	sp,sp,-96
ffffffffc02000ce:	02810313          	addi	t1,sp,40 # ffffffffc020d028 <boot_page_table_sv39+0x28>
ffffffffc02000d2:	8e2a                	mv	t3,a0
ffffffffc02000d4:	f42e                	sd	a1,40(sp)
ffffffffc02000d6:	f832                	sd	a2,48(sp)
ffffffffc02000d8:	fc36                	sd	a3,56(sp)
ffffffffc02000da:	00000517          	auipc	a0,0x0
ffffffffc02000de:	fb850513          	addi	a0,a0,-72 # ffffffffc0200092 <cputch>
ffffffffc02000e2:	004c                	addi	a1,sp,4
ffffffffc02000e4:	869a                	mv	a3,t1
ffffffffc02000e6:	8672                	mv	a2,t3
ffffffffc02000e8:	ec06                	sd	ra,24(sp)
ffffffffc02000ea:	e0ba                	sd	a4,64(sp)
ffffffffc02000ec:	e4be                	sd	a5,72(sp)
ffffffffc02000ee:	e8c2                	sd	a6,80(sp)
ffffffffc02000f0:	ecc6                	sd	a7,88(sp)
ffffffffc02000f2:	e41a                	sd	t1,8(sp)
ffffffffc02000f4:	c202                	sw	zero,4(sp)
ffffffffc02000f6:	2b7070ef          	jal	ra,ffffffffc0207bac <vprintfmt>
ffffffffc02000fa:	60e2                	ld	ra,24(sp)
ffffffffc02000fc:	4512                	lw	a0,4(sp)
ffffffffc02000fe:	6125                	addi	sp,sp,96
ffffffffc0200100:	8082                	ret

ffffffffc0200102 <cputchar>:
ffffffffc0200102:	a97d                	j	ffffffffc02005c0 <cons_putc>

ffffffffc0200104 <cputs>:
ffffffffc0200104:	1101                	addi	sp,sp,-32
ffffffffc0200106:	e822                	sd	s0,16(sp)
ffffffffc0200108:	ec06                	sd	ra,24(sp)
ffffffffc020010a:	e426                	sd	s1,8(sp)
ffffffffc020010c:	842a                	mv	s0,a0
ffffffffc020010e:	00054503          	lbu	a0,0(a0)
ffffffffc0200112:	c51d                	beqz	a0,ffffffffc0200140 <cputs+0x3c>
ffffffffc0200114:	0405                	addi	s0,s0,1
ffffffffc0200116:	4485                	li	s1,1
ffffffffc0200118:	9c81                	subw	s1,s1,s0
ffffffffc020011a:	4a6000ef          	jal	ra,ffffffffc02005c0 <cons_putc>
ffffffffc020011e:	00044503          	lbu	a0,0(s0)
ffffffffc0200122:	008487bb          	addw	a5,s1,s0
ffffffffc0200126:	0405                	addi	s0,s0,1
ffffffffc0200128:	f96d                	bnez	a0,ffffffffc020011a <cputs+0x16>
ffffffffc020012a:	0017841b          	addiw	s0,a5,1
ffffffffc020012e:	4529                	li	a0,10
ffffffffc0200130:	490000ef          	jal	ra,ffffffffc02005c0 <cons_putc>
ffffffffc0200134:	60e2                	ld	ra,24(sp)
ffffffffc0200136:	8522                	mv	a0,s0
ffffffffc0200138:	6442                	ld	s0,16(sp)
ffffffffc020013a:	64a2                	ld	s1,8(sp)
ffffffffc020013c:	6105                	addi	sp,sp,32
ffffffffc020013e:	8082                	ret
ffffffffc0200140:	4405                	li	s0,1
ffffffffc0200142:	b7f5                	j	ffffffffc020012e <cputs+0x2a>

ffffffffc0200144 <getchar>:
ffffffffc0200144:	1141                	addi	sp,sp,-16
ffffffffc0200146:	e406                	sd	ra,8(sp)
ffffffffc0200148:	4ac000ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc020014c:	dd75                	beqz	a0,ffffffffc0200148 <getchar+0x4>
ffffffffc020014e:	60a2                	ld	ra,8(sp)
ffffffffc0200150:	0141                	addi	sp,sp,16
ffffffffc0200152:	8082                	ret

ffffffffc0200154 <readline>:
ffffffffc0200154:	715d                	addi	sp,sp,-80
ffffffffc0200156:	e486                	sd	ra,72(sp)
ffffffffc0200158:	e0a6                	sd	s1,64(sp)
ffffffffc020015a:	fc4a                	sd	s2,56(sp)
ffffffffc020015c:	f84e                	sd	s3,48(sp)
ffffffffc020015e:	f452                	sd	s4,40(sp)
ffffffffc0200160:	f056                	sd	s5,32(sp)
ffffffffc0200162:	ec5a                	sd	s6,24(sp)
ffffffffc0200164:	e85e                	sd	s7,16(sp)
ffffffffc0200166:	c901                	beqz	a0,ffffffffc0200176 <readline+0x22>
ffffffffc0200168:	85aa                	mv	a1,a0
ffffffffc020016a:	00008517          	auipc	a0,0x8
ffffffffc020016e:	dfe50513          	addi	a0,a0,-514 # ffffffffc0207f68 <etext+0x24>
ffffffffc0200172:	f5bff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200176:	4481                	li	s1,0
ffffffffc0200178:	497d                	li	s2,31
ffffffffc020017a:	49a1                	li	s3,8
ffffffffc020017c:	4aa9                	li	s5,10
ffffffffc020017e:	4b35                	li	s6,13
ffffffffc0200180:	0000eb97          	auipc	s7,0xe
ffffffffc0200184:	f10b8b93          	addi	s7,s7,-240 # ffffffffc020e090 <buf>
ffffffffc0200188:	3fe00a13          	li	s4,1022
ffffffffc020018c:	fb9ff0ef          	jal	ra,ffffffffc0200144 <getchar>
ffffffffc0200190:	00054a63          	bltz	a0,ffffffffc02001a4 <readline+0x50>
ffffffffc0200194:	00a95a63          	bge	s2,a0,ffffffffc02001a8 <readline+0x54>
ffffffffc0200198:	029a5263          	bge	s4,s1,ffffffffc02001bc <readline+0x68>
ffffffffc020019c:	fa9ff0ef          	jal	ra,ffffffffc0200144 <getchar>
ffffffffc02001a0:	fe055ae3          	bgez	a0,ffffffffc0200194 <readline+0x40>
ffffffffc02001a4:	4501                	li	a0,0
ffffffffc02001a6:	a091                	j	ffffffffc02001ea <readline+0x96>
ffffffffc02001a8:	03351463          	bne	a0,s3,ffffffffc02001d0 <readline+0x7c>
ffffffffc02001ac:	e8a9                	bnez	s1,ffffffffc02001fe <readline+0xaa>
ffffffffc02001ae:	f97ff0ef          	jal	ra,ffffffffc0200144 <getchar>
ffffffffc02001b2:	fe0549e3          	bltz	a0,ffffffffc02001a4 <readline+0x50>
ffffffffc02001b6:	fea959e3          	bge	s2,a0,ffffffffc02001a8 <readline+0x54>
ffffffffc02001ba:	4481                	li	s1,0
ffffffffc02001bc:	e42a                	sd	a0,8(sp)
ffffffffc02001be:	f45ff0ef          	jal	ra,ffffffffc0200102 <cputchar>
ffffffffc02001c2:	6522                	ld	a0,8(sp)
ffffffffc02001c4:	009b87b3          	add	a5,s7,s1
ffffffffc02001c8:	2485                	addiw	s1,s1,1
ffffffffc02001ca:	00a78023          	sb	a0,0(a5)
ffffffffc02001ce:	bf7d                	j	ffffffffc020018c <readline+0x38>
ffffffffc02001d0:	01550463          	beq	a0,s5,ffffffffc02001d8 <readline+0x84>
ffffffffc02001d4:	fb651ce3          	bne	a0,s6,ffffffffc020018c <readline+0x38>
ffffffffc02001d8:	f2bff0ef          	jal	ra,ffffffffc0200102 <cputchar>
ffffffffc02001dc:	0000e517          	auipc	a0,0xe
ffffffffc02001e0:	eb450513          	addi	a0,a0,-332 # ffffffffc020e090 <buf>
ffffffffc02001e4:	94aa                	add	s1,s1,a0
ffffffffc02001e6:	00048023          	sb	zero,0(s1)
ffffffffc02001ea:	60a6                	ld	ra,72(sp)
ffffffffc02001ec:	6486                	ld	s1,64(sp)
ffffffffc02001ee:	7962                	ld	s2,56(sp)
ffffffffc02001f0:	79c2                	ld	s3,48(sp)
ffffffffc02001f2:	7a22                	ld	s4,40(sp)
ffffffffc02001f4:	7a82                	ld	s5,32(sp)
ffffffffc02001f6:	6b62                	ld	s6,24(sp)
ffffffffc02001f8:	6bc2                	ld	s7,16(sp)
ffffffffc02001fa:	6161                	addi	sp,sp,80
ffffffffc02001fc:	8082                	ret
ffffffffc02001fe:	4521                	li	a0,8
ffffffffc0200200:	f03ff0ef          	jal	ra,ffffffffc0200102 <cputchar>
ffffffffc0200204:	34fd                	addiw	s1,s1,-1
ffffffffc0200206:	b759                	j	ffffffffc020018c <readline+0x38>

ffffffffc0200208 <__panic>:
ffffffffc0200208:	00019317          	auipc	t1,0x19
ffffffffc020020c:	2b830313          	addi	t1,t1,696 # ffffffffc02194c0 <is_panic>
ffffffffc0200210:	00033e03          	ld	t3,0(t1)
ffffffffc0200214:	715d                	addi	sp,sp,-80
ffffffffc0200216:	ec06                	sd	ra,24(sp)
ffffffffc0200218:	e822                	sd	s0,16(sp)
ffffffffc020021a:	f436                	sd	a3,40(sp)
ffffffffc020021c:	f83a                	sd	a4,48(sp)
ffffffffc020021e:	fc3e                	sd	a5,56(sp)
ffffffffc0200220:	e0c2                	sd	a6,64(sp)
ffffffffc0200222:	e4c6                	sd	a7,72(sp)
ffffffffc0200224:	020e1a63          	bnez	t3,ffffffffc0200258 <__panic+0x50>
ffffffffc0200228:	4785                	li	a5,1
ffffffffc020022a:	00f33023          	sd	a5,0(t1)
ffffffffc020022e:	8432                	mv	s0,a2
ffffffffc0200230:	103c                	addi	a5,sp,40
ffffffffc0200232:	862e                	mv	a2,a1
ffffffffc0200234:	85aa                	mv	a1,a0
ffffffffc0200236:	00008517          	auipc	a0,0x8
ffffffffc020023a:	d3a50513          	addi	a0,a0,-710 # ffffffffc0207f70 <etext+0x2c>
ffffffffc020023e:	e43e                	sd	a5,8(sp)
ffffffffc0200240:	e8dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200244:	65a2                	ld	a1,8(sp)
ffffffffc0200246:	8522                	mv	a0,s0
ffffffffc0200248:	e65ff0ef          	jal	ra,ffffffffc02000ac <vcprintf>
ffffffffc020024c:	00009517          	auipc	a0,0x9
ffffffffc0200250:	5ec50513          	addi	a0,a0,1516 # ffffffffc0209838 <default_pmm_manager+0x500>
ffffffffc0200254:	e79ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200258:	4501                	li	a0,0
ffffffffc020025a:	4581                	li	a1,0
ffffffffc020025c:	4601                	li	a2,0
ffffffffc020025e:	48a1                	li	a7,8
ffffffffc0200260:	00000073          	ecall
ffffffffc0200264:	3d4000ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0200268:	4501                	li	a0,0
ffffffffc020026a:	174000ef          	jal	ra,ffffffffc02003de <kmonitor>
ffffffffc020026e:	bfed                	j	ffffffffc0200268 <__panic+0x60>

ffffffffc0200270 <__warn>:
ffffffffc0200270:	715d                	addi	sp,sp,-80
ffffffffc0200272:	832e                	mv	t1,a1
ffffffffc0200274:	e822                	sd	s0,16(sp)
ffffffffc0200276:	85aa                	mv	a1,a0
ffffffffc0200278:	8432                	mv	s0,a2
ffffffffc020027a:	fc3e                	sd	a5,56(sp)
ffffffffc020027c:	861a                	mv	a2,t1
ffffffffc020027e:	103c                	addi	a5,sp,40
ffffffffc0200280:	00008517          	auipc	a0,0x8
ffffffffc0200284:	d1050513          	addi	a0,a0,-752 # ffffffffc0207f90 <etext+0x4c>
ffffffffc0200288:	ec06                	sd	ra,24(sp)
ffffffffc020028a:	f436                	sd	a3,40(sp)
ffffffffc020028c:	f83a                	sd	a4,48(sp)
ffffffffc020028e:	e0c2                	sd	a6,64(sp)
ffffffffc0200290:	e4c6                	sd	a7,72(sp)
ffffffffc0200292:	e43e                	sd	a5,8(sp)
ffffffffc0200294:	e39ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200298:	65a2                	ld	a1,8(sp)
ffffffffc020029a:	8522                	mv	a0,s0
ffffffffc020029c:	e11ff0ef          	jal	ra,ffffffffc02000ac <vcprintf>
ffffffffc02002a0:	00009517          	auipc	a0,0x9
ffffffffc02002a4:	59850513          	addi	a0,a0,1432 # ffffffffc0209838 <default_pmm_manager+0x500>
ffffffffc02002a8:	e25ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002ac:	60e2                	ld	ra,24(sp)
ffffffffc02002ae:	6442                	ld	s0,16(sp)
ffffffffc02002b0:	6161                	addi	sp,sp,80
ffffffffc02002b2:	8082                	ret

ffffffffc02002b4 <print_kerninfo>:
ffffffffc02002b4:	1141                	addi	sp,sp,-16
ffffffffc02002b6:	00008517          	auipc	a0,0x8
ffffffffc02002ba:	cfa50513          	addi	a0,a0,-774 # ffffffffc0207fb0 <etext+0x6c>
ffffffffc02002be:	e406                	sd	ra,8(sp)
ffffffffc02002c0:	e0dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002c4:	00000597          	auipc	a1,0x0
ffffffffc02002c8:	d6e58593          	addi	a1,a1,-658 # ffffffffc0200032 <kern_init>
ffffffffc02002cc:	00008517          	auipc	a0,0x8
ffffffffc02002d0:	d0450513          	addi	a0,a0,-764 # ffffffffc0207fd0 <etext+0x8c>
ffffffffc02002d4:	df9ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002d8:	00008597          	auipc	a1,0x8
ffffffffc02002dc:	c6c58593          	addi	a1,a1,-916 # ffffffffc0207f44 <etext>
ffffffffc02002e0:	00008517          	auipc	a0,0x8
ffffffffc02002e4:	d1050513          	addi	a0,a0,-752 # ffffffffc0207ff0 <etext+0xac>
ffffffffc02002e8:	de5ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002ec:	0000e597          	auipc	a1,0xe
ffffffffc02002f0:	da458593          	addi	a1,a1,-604 # ffffffffc020e090 <buf>
ffffffffc02002f4:	00008517          	auipc	a0,0x8
ffffffffc02002f8:	d1c50513          	addi	a0,a0,-740 # ffffffffc0208010 <etext+0xcc>
ffffffffc02002fc:	dd1ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200300:	00019597          	auipc	a1,0x19
ffffffffc0200304:	40858593          	addi	a1,a1,1032 # ffffffffc0219708 <end>
ffffffffc0200308:	00008517          	auipc	a0,0x8
ffffffffc020030c:	d2850513          	addi	a0,a0,-728 # ffffffffc0208030 <etext+0xec>
ffffffffc0200310:	dbdff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200314:	00019597          	auipc	a1,0x19
ffffffffc0200318:	7f358593          	addi	a1,a1,2035 # ffffffffc0219b07 <end+0x3ff>
ffffffffc020031c:	00000797          	auipc	a5,0x0
ffffffffc0200320:	d1678793          	addi	a5,a5,-746 # ffffffffc0200032 <kern_init>
ffffffffc0200324:	40f587b3          	sub	a5,a1,a5
ffffffffc0200328:	43f7d593          	srai	a1,a5,0x3f
ffffffffc020032c:	60a2                	ld	ra,8(sp)
ffffffffc020032e:	3ff5f593          	andi	a1,a1,1023
ffffffffc0200332:	95be                	add	a1,a1,a5
ffffffffc0200334:	85a9                	srai	a1,a1,0xa
ffffffffc0200336:	00008517          	auipc	a0,0x8
ffffffffc020033a:	d1a50513          	addi	a0,a0,-742 # ffffffffc0208050 <etext+0x10c>
ffffffffc020033e:	0141                	addi	sp,sp,16
ffffffffc0200340:	b371                	j	ffffffffc02000cc <cprintf>

ffffffffc0200342 <print_stackframe>:
ffffffffc0200342:	1141                	addi	sp,sp,-16
ffffffffc0200344:	00008617          	auipc	a2,0x8
ffffffffc0200348:	d3c60613          	addi	a2,a2,-708 # ffffffffc0208080 <etext+0x13c>
ffffffffc020034c:	05b00593          	li	a1,91
ffffffffc0200350:	00008517          	auipc	a0,0x8
ffffffffc0200354:	d4850513          	addi	a0,a0,-696 # ffffffffc0208098 <etext+0x154>
ffffffffc0200358:	e406                	sd	ra,8(sp)
ffffffffc020035a:	eafff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020035e <mon_help>:
ffffffffc020035e:	1141                	addi	sp,sp,-16
ffffffffc0200360:	00008617          	auipc	a2,0x8
ffffffffc0200364:	d5060613          	addi	a2,a2,-688 # ffffffffc02080b0 <etext+0x16c>
ffffffffc0200368:	00008597          	auipc	a1,0x8
ffffffffc020036c:	d6858593          	addi	a1,a1,-664 # ffffffffc02080d0 <etext+0x18c>
ffffffffc0200370:	00008517          	auipc	a0,0x8
ffffffffc0200374:	d6850513          	addi	a0,a0,-664 # ffffffffc02080d8 <etext+0x194>
ffffffffc0200378:	e406                	sd	ra,8(sp)
ffffffffc020037a:	d53ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020037e:	00008617          	auipc	a2,0x8
ffffffffc0200382:	d6a60613          	addi	a2,a2,-662 # ffffffffc02080e8 <etext+0x1a4>
ffffffffc0200386:	00008597          	auipc	a1,0x8
ffffffffc020038a:	d8a58593          	addi	a1,a1,-630 # ffffffffc0208110 <etext+0x1cc>
ffffffffc020038e:	00008517          	auipc	a0,0x8
ffffffffc0200392:	d4a50513          	addi	a0,a0,-694 # ffffffffc02080d8 <etext+0x194>
ffffffffc0200396:	d37ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020039a:	00008617          	auipc	a2,0x8
ffffffffc020039e:	d8660613          	addi	a2,a2,-634 # ffffffffc0208120 <etext+0x1dc>
ffffffffc02003a2:	00008597          	auipc	a1,0x8
ffffffffc02003a6:	d9e58593          	addi	a1,a1,-610 # ffffffffc0208140 <etext+0x1fc>
ffffffffc02003aa:	00008517          	auipc	a0,0x8
ffffffffc02003ae:	d2e50513          	addi	a0,a0,-722 # ffffffffc02080d8 <etext+0x194>
ffffffffc02003b2:	d1bff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02003b6:	60a2                	ld	ra,8(sp)
ffffffffc02003b8:	4501                	li	a0,0
ffffffffc02003ba:	0141                	addi	sp,sp,16
ffffffffc02003bc:	8082                	ret

ffffffffc02003be <mon_kerninfo>:
ffffffffc02003be:	1141                	addi	sp,sp,-16
ffffffffc02003c0:	e406                	sd	ra,8(sp)
ffffffffc02003c2:	ef3ff0ef          	jal	ra,ffffffffc02002b4 <print_kerninfo>
ffffffffc02003c6:	60a2                	ld	ra,8(sp)
ffffffffc02003c8:	4501                	li	a0,0
ffffffffc02003ca:	0141                	addi	sp,sp,16
ffffffffc02003cc:	8082                	ret

ffffffffc02003ce <mon_backtrace>:
ffffffffc02003ce:	1141                	addi	sp,sp,-16
ffffffffc02003d0:	e406                	sd	ra,8(sp)
ffffffffc02003d2:	f71ff0ef          	jal	ra,ffffffffc0200342 <print_stackframe>
ffffffffc02003d6:	60a2                	ld	ra,8(sp)
ffffffffc02003d8:	4501                	li	a0,0
ffffffffc02003da:	0141                	addi	sp,sp,16
ffffffffc02003dc:	8082                	ret

ffffffffc02003de <kmonitor>:
ffffffffc02003de:	7115                	addi	sp,sp,-224
ffffffffc02003e0:	e962                	sd	s8,144(sp)
ffffffffc02003e2:	8c2a                	mv	s8,a0
ffffffffc02003e4:	00008517          	auipc	a0,0x8
ffffffffc02003e8:	d6c50513          	addi	a0,a0,-660 # ffffffffc0208150 <etext+0x20c>
ffffffffc02003ec:	ed86                	sd	ra,216(sp)
ffffffffc02003ee:	e9a2                	sd	s0,208(sp)
ffffffffc02003f0:	e5a6                	sd	s1,200(sp)
ffffffffc02003f2:	e1ca                	sd	s2,192(sp)
ffffffffc02003f4:	fd4e                	sd	s3,184(sp)
ffffffffc02003f6:	f952                	sd	s4,176(sp)
ffffffffc02003f8:	f556                	sd	s5,168(sp)
ffffffffc02003fa:	f15a                	sd	s6,160(sp)
ffffffffc02003fc:	ed5e                	sd	s7,152(sp)
ffffffffc02003fe:	e566                	sd	s9,136(sp)
ffffffffc0200400:	e16a                	sd	s10,128(sp)
ffffffffc0200402:	ccbff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200406:	00008517          	auipc	a0,0x8
ffffffffc020040a:	d7250513          	addi	a0,a0,-654 # ffffffffc0208178 <etext+0x234>
ffffffffc020040e:	cbfff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200412:	000c0563          	beqz	s8,ffffffffc020041c <kmonitor+0x3e>
ffffffffc0200416:	8562                	mv	a0,s8
ffffffffc0200418:	40e000ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc020041c:	00008c97          	auipc	s9,0x8
ffffffffc0200420:	dccc8c93          	addi	s9,s9,-564 # ffffffffc02081e8 <commands>
ffffffffc0200424:	00008997          	auipc	s3,0x8
ffffffffc0200428:	d7c98993          	addi	s3,s3,-644 # ffffffffc02081a0 <etext+0x25c>
ffffffffc020042c:	00008917          	auipc	s2,0x8
ffffffffc0200430:	d7c90913          	addi	s2,s2,-644 # ffffffffc02081a8 <etext+0x264>
ffffffffc0200434:	4a3d                	li	s4,15
ffffffffc0200436:	00008b17          	auipc	s6,0x8
ffffffffc020043a:	d7ab0b13          	addi	s6,s6,-646 # ffffffffc02081b0 <etext+0x26c>
ffffffffc020043e:	00008a97          	auipc	s5,0x8
ffffffffc0200442:	c92a8a93          	addi	s5,s5,-878 # ffffffffc02080d0 <etext+0x18c>
ffffffffc0200446:	4b8d                	li	s7,3
ffffffffc0200448:	854e                	mv	a0,s3
ffffffffc020044a:	d0bff0ef          	jal	ra,ffffffffc0200154 <readline>
ffffffffc020044e:	842a                	mv	s0,a0
ffffffffc0200450:	dd65                	beqz	a0,ffffffffc0200448 <kmonitor+0x6a>
ffffffffc0200452:	00054583          	lbu	a1,0(a0)
ffffffffc0200456:	4481                	li	s1,0
ffffffffc0200458:	c999                	beqz	a1,ffffffffc020046e <kmonitor+0x90>
ffffffffc020045a:	854a                	mv	a0,s2
ffffffffc020045c:	6a4070ef          	jal	ra,ffffffffc0207b00 <strchr>
ffffffffc0200460:	c925                	beqz	a0,ffffffffc02004d0 <kmonitor+0xf2>
ffffffffc0200462:	00144583          	lbu	a1,1(s0)
ffffffffc0200466:	00040023          	sb	zero,0(s0)
ffffffffc020046a:	0405                	addi	s0,s0,1
ffffffffc020046c:	f5fd                	bnez	a1,ffffffffc020045a <kmonitor+0x7c>
ffffffffc020046e:	dce9                	beqz	s1,ffffffffc0200448 <kmonitor+0x6a>
ffffffffc0200470:	6582                	ld	a1,0(sp)
ffffffffc0200472:	00008d17          	auipc	s10,0x8
ffffffffc0200476:	d76d0d13          	addi	s10,s10,-650 # ffffffffc02081e8 <commands>
ffffffffc020047a:	8556                	mv	a0,s5
ffffffffc020047c:	4401                	li	s0,0
ffffffffc020047e:	0d61                	addi	s10,s10,24
ffffffffc0200480:	662070ef          	jal	ra,ffffffffc0207ae2 <strcmp>
ffffffffc0200484:	c919                	beqz	a0,ffffffffc020049a <kmonitor+0xbc>
ffffffffc0200486:	2405                	addiw	s0,s0,1
ffffffffc0200488:	09740463          	beq	s0,s7,ffffffffc0200510 <kmonitor+0x132>
ffffffffc020048c:	000d3503          	ld	a0,0(s10)
ffffffffc0200490:	6582                	ld	a1,0(sp)
ffffffffc0200492:	0d61                	addi	s10,s10,24
ffffffffc0200494:	64e070ef          	jal	ra,ffffffffc0207ae2 <strcmp>
ffffffffc0200498:	f57d                	bnez	a0,ffffffffc0200486 <kmonitor+0xa8>
ffffffffc020049a:	00141793          	slli	a5,s0,0x1
ffffffffc020049e:	97a2                	add	a5,a5,s0
ffffffffc02004a0:	078e                	slli	a5,a5,0x3
ffffffffc02004a2:	97e6                	add	a5,a5,s9
ffffffffc02004a4:	6b9c                	ld	a5,16(a5)
ffffffffc02004a6:	8662                	mv	a2,s8
ffffffffc02004a8:	002c                	addi	a1,sp,8
ffffffffc02004aa:	fff4851b          	addiw	a0,s1,-1
ffffffffc02004ae:	9782                	jalr	a5
ffffffffc02004b0:	f8055ce3          	bgez	a0,ffffffffc0200448 <kmonitor+0x6a>
ffffffffc02004b4:	60ee                	ld	ra,216(sp)
ffffffffc02004b6:	644e                	ld	s0,208(sp)
ffffffffc02004b8:	64ae                	ld	s1,200(sp)
ffffffffc02004ba:	690e                	ld	s2,192(sp)
ffffffffc02004bc:	79ea                	ld	s3,184(sp)
ffffffffc02004be:	7a4a                	ld	s4,176(sp)
ffffffffc02004c0:	7aaa                	ld	s5,168(sp)
ffffffffc02004c2:	7b0a                	ld	s6,160(sp)
ffffffffc02004c4:	6bea                	ld	s7,152(sp)
ffffffffc02004c6:	6c4a                	ld	s8,144(sp)
ffffffffc02004c8:	6caa                	ld	s9,136(sp)
ffffffffc02004ca:	6d0a                	ld	s10,128(sp)
ffffffffc02004cc:	612d                	addi	sp,sp,224
ffffffffc02004ce:	8082                	ret
ffffffffc02004d0:	00044783          	lbu	a5,0(s0)
ffffffffc02004d4:	dfc9                	beqz	a5,ffffffffc020046e <kmonitor+0x90>
ffffffffc02004d6:	03448863          	beq	s1,s4,ffffffffc0200506 <kmonitor+0x128>
ffffffffc02004da:	00349793          	slli	a5,s1,0x3
ffffffffc02004de:	0118                	addi	a4,sp,128
ffffffffc02004e0:	97ba                	add	a5,a5,a4
ffffffffc02004e2:	f887b023          	sd	s0,-128(a5)
ffffffffc02004e6:	00044583          	lbu	a1,0(s0)
ffffffffc02004ea:	2485                	addiw	s1,s1,1
ffffffffc02004ec:	e591                	bnez	a1,ffffffffc02004f8 <kmonitor+0x11a>
ffffffffc02004ee:	b749                	j	ffffffffc0200470 <kmonitor+0x92>
ffffffffc02004f0:	00144583          	lbu	a1,1(s0)
ffffffffc02004f4:	0405                	addi	s0,s0,1
ffffffffc02004f6:	ddad                	beqz	a1,ffffffffc0200470 <kmonitor+0x92>
ffffffffc02004f8:	854a                	mv	a0,s2
ffffffffc02004fa:	606070ef          	jal	ra,ffffffffc0207b00 <strchr>
ffffffffc02004fe:	d96d                	beqz	a0,ffffffffc02004f0 <kmonitor+0x112>
ffffffffc0200500:	00044583          	lbu	a1,0(s0)
ffffffffc0200504:	bf91                	j	ffffffffc0200458 <kmonitor+0x7a>
ffffffffc0200506:	45c1                	li	a1,16
ffffffffc0200508:	855a                	mv	a0,s6
ffffffffc020050a:	bc3ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020050e:	b7f1                	j	ffffffffc02004da <kmonitor+0xfc>
ffffffffc0200510:	6582                	ld	a1,0(sp)
ffffffffc0200512:	00008517          	auipc	a0,0x8
ffffffffc0200516:	cbe50513          	addi	a0,a0,-834 # ffffffffc02081d0 <etext+0x28c>
ffffffffc020051a:	bb3ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020051e:	b72d                	j	ffffffffc0200448 <kmonitor+0x6a>

ffffffffc0200520 <ide_init>:
ffffffffc0200520:	8082                	ret

ffffffffc0200522 <ide_device_valid>:
ffffffffc0200522:	00253513          	sltiu	a0,a0,2
ffffffffc0200526:	8082                	ret

ffffffffc0200528 <ide_device_size>:
ffffffffc0200528:	03800513          	li	a0,56
ffffffffc020052c:	8082                	ret

ffffffffc020052e <ide_read_secs>:
ffffffffc020052e:	0000e797          	auipc	a5,0xe
ffffffffc0200532:	f6278793          	addi	a5,a5,-158 # ffffffffc020e490 <ide>
ffffffffc0200536:	0095959b          	slliw	a1,a1,0x9
ffffffffc020053a:	1141                	addi	sp,sp,-16
ffffffffc020053c:	8532                	mv	a0,a2
ffffffffc020053e:	95be                	add	a1,a1,a5
ffffffffc0200540:	00969613          	slli	a2,a3,0x9
ffffffffc0200544:	e406                	sd	ra,8(sp)
ffffffffc0200546:	5e2070ef          	jal	ra,ffffffffc0207b28 <memcpy>
ffffffffc020054a:	60a2                	ld	ra,8(sp)
ffffffffc020054c:	4501                	li	a0,0
ffffffffc020054e:	0141                	addi	sp,sp,16
ffffffffc0200550:	8082                	ret

ffffffffc0200552 <ide_write_secs>:
ffffffffc0200552:	0095979b          	slliw	a5,a1,0x9
ffffffffc0200556:	0000e517          	auipc	a0,0xe
ffffffffc020055a:	f3a50513          	addi	a0,a0,-198 # ffffffffc020e490 <ide>
ffffffffc020055e:	1141                	addi	sp,sp,-16
ffffffffc0200560:	85b2                	mv	a1,a2
ffffffffc0200562:	953e                	add	a0,a0,a5
ffffffffc0200564:	00969613          	slli	a2,a3,0x9
ffffffffc0200568:	e406                	sd	ra,8(sp)
ffffffffc020056a:	5be070ef          	jal	ra,ffffffffc0207b28 <memcpy>
ffffffffc020056e:	60a2                	ld	ra,8(sp)
ffffffffc0200570:	4501                	li	a0,0
ffffffffc0200572:	0141                	addi	sp,sp,16
ffffffffc0200574:	8082                	ret

ffffffffc0200576 <clock_init>:
ffffffffc0200576:	02000793          	li	a5,32
ffffffffc020057a:	1047a7f3          	csrrs	a5,sie,a5
ffffffffc020057e:	c0102573          	rdtime	a0
ffffffffc0200582:	67e1                	lui	a5,0x18
ffffffffc0200584:	6a078793          	addi	a5,a5,1696 # 186a0 <kern_entry-0xffffffffc01e7960>
ffffffffc0200588:	953e                	add	a0,a0,a5
ffffffffc020058a:	4581                	li	a1,0
ffffffffc020058c:	4601                	li	a2,0
ffffffffc020058e:	4881                	li	a7,0
ffffffffc0200590:	00000073          	ecall
ffffffffc0200594:	00008517          	auipc	a0,0x8
ffffffffc0200598:	c9c50513          	addi	a0,a0,-868 # ffffffffc0208230 <commands+0x48>
ffffffffc020059c:	00019797          	auipc	a5,0x19
ffffffffc02005a0:	f807b623          	sd	zero,-116(a5) # ffffffffc0219528 <ticks>
ffffffffc02005a4:	b625                	j	ffffffffc02000cc <cprintf>

ffffffffc02005a6 <clock_set_next_event>:
ffffffffc02005a6:	c0102573          	rdtime	a0
ffffffffc02005aa:	67e1                	lui	a5,0x18
ffffffffc02005ac:	6a078793          	addi	a5,a5,1696 # 186a0 <kern_entry-0xffffffffc01e7960>
ffffffffc02005b0:	953e                	add	a0,a0,a5
ffffffffc02005b2:	4581                	li	a1,0
ffffffffc02005b4:	4601                	li	a2,0
ffffffffc02005b6:	4881                	li	a7,0
ffffffffc02005b8:	00000073          	ecall
ffffffffc02005bc:	8082                	ret

ffffffffc02005be <cons_init>:
ffffffffc02005be:	8082                	ret

ffffffffc02005c0 <cons_putc>:
ffffffffc02005c0:	100027f3          	csrr	a5,sstatus
ffffffffc02005c4:	8b89                	andi	a5,a5,2
ffffffffc02005c6:	0ff57513          	andi	a0,a0,255
ffffffffc02005ca:	e799                	bnez	a5,ffffffffc02005d8 <cons_putc+0x18>
ffffffffc02005cc:	4581                	li	a1,0
ffffffffc02005ce:	4601                	li	a2,0
ffffffffc02005d0:	4885                	li	a7,1
ffffffffc02005d2:	00000073          	ecall
ffffffffc02005d6:	8082                	ret
ffffffffc02005d8:	1101                	addi	sp,sp,-32
ffffffffc02005da:	ec06                	sd	ra,24(sp)
ffffffffc02005dc:	e42a                	sd	a0,8(sp)
ffffffffc02005de:	05a000ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02005e2:	6522                	ld	a0,8(sp)
ffffffffc02005e4:	4581                	li	a1,0
ffffffffc02005e6:	4601                	li	a2,0
ffffffffc02005e8:	4885                	li	a7,1
ffffffffc02005ea:	00000073          	ecall
ffffffffc02005ee:	60e2                	ld	ra,24(sp)
ffffffffc02005f0:	6105                	addi	sp,sp,32
ffffffffc02005f2:	a081                	j	ffffffffc0200632 <intr_enable>

ffffffffc02005f4 <cons_getc>:
ffffffffc02005f4:	100027f3          	csrr	a5,sstatus
ffffffffc02005f8:	8b89                	andi	a5,a5,2
ffffffffc02005fa:	eb89                	bnez	a5,ffffffffc020060c <cons_getc+0x18>
ffffffffc02005fc:	4501                	li	a0,0
ffffffffc02005fe:	4581                	li	a1,0
ffffffffc0200600:	4601                	li	a2,0
ffffffffc0200602:	4889                	li	a7,2
ffffffffc0200604:	00000073          	ecall
ffffffffc0200608:	2501                	sext.w	a0,a0
ffffffffc020060a:	8082                	ret
ffffffffc020060c:	1101                	addi	sp,sp,-32
ffffffffc020060e:	ec06                	sd	ra,24(sp)
ffffffffc0200610:	028000ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0200614:	4501                	li	a0,0
ffffffffc0200616:	4581                	li	a1,0
ffffffffc0200618:	4601                	li	a2,0
ffffffffc020061a:	4889                	li	a7,2
ffffffffc020061c:	00000073          	ecall
ffffffffc0200620:	2501                	sext.w	a0,a0
ffffffffc0200622:	e42a                	sd	a0,8(sp)
ffffffffc0200624:	00e000ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0200628:	60e2                	ld	ra,24(sp)
ffffffffc020062a:	6522                	ld	a0,8(sp)
ffffffffc020062c:	6105                	addi	sp,sp,32
ffffffffc020062e:	8082                	ret

ffffffffc0200630 <pic_init>:
ffffffffc0200630:	8082                	ret

ffffffffc0200632 <intr_enable>:
ffffffffc0200632:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc0200636:	8082                	ret

ffffffffc0200638 <intr_disable>:
ffffffffc0200638:	100177f3          	csrrci	a5,sstatus,2
ffffffffc020063c:	8082                	ret

ffffffffc020063e <idt_init>:
ffffffffc020063e:	14005073          	csrwi	sscratch,0
ffffffffc0200642:	00000797          	auipc	a5,0x0
ffffffffc0200646:	61e78793          	addi	a5,a5,1566 # ffffffffc0200c60 <__alltraps>
ffffffffc020064a:	10579073          	csrw	stvec,a5
ffffffffc020064e:	000407b7          	lui	a5,0x40
ffffffffc0200652:	1007a7f3          	csrrs	a5,sstatus,a5
ffffffffc0200656:	8082                	ret

ffffffffc0200658 <print_regs>:
ffffffffc0200658:	610c                	ld	a1,0(a0)
ffffffffc020065a:	1141                	addi	sp,sp,-16
ffffffffc020065c:	e022                	sd	s0,0(sp)
ffffffffc020065e:	842a                	mv	s0,a0
ffffffffc0200660:	00008517          	auipc	a0,0x8
ffffffffc0200664:	bf050513          	addi	a0,a0,-1040 # ffffffffc0208250 <commands+0x68>
ffffffffc0200668:	e406                	sd	ra,8(sp)
ffffffffc020066a:	a63ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020066e:	640c                	ld	a1,8(s0)
ffffffffc0200670:	00008517          	auipc	a0,0x8
ffffffffc0200674:	bf850513          	addi	a0,a0,-1032 # ffffffffc0208268 <commands+0x80>
ffffffffc0200678:	a55ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020067c:	680c                	ld	a1,16(s0)
ffffffffc020067e:	00008517          	auipc	a0,0x8
ffffffffc0200682:	c0250513          	addi	a0,a0,-1022 # ffffffffc0208280 <commands+0x98>
ffffffffc0200686:	a47ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020068a:	6c0c                	ld	a1,24(s0)
ffffffffc020068c:	00008517          	auipc	a0,0x8
ffffffffc0200690:	c0c50513          	addi	a0,a0,-1012 # ffffffffc0208298 <commands+0xb0>
ffffffffc0200694:	a39ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200698:	700c                	ld	a1,32(s0)
ffffffffc020069a:	00008517          	auipc	a0,0x8
ffffffffc020069e:	c1650513          	addi	a0,a0,-1002 # ffffffffc02082b0 <commands+0xc8>
ffffffffc02006a2:	a2bff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006a6:	740c                	ld	a1,40(s0)
ffffffffc02006a8:	00008517          	auipc	a0,0x8
ffffffffc02006ac:	c2050513          	addi	a0,a0,-992 # ffffffffc02082c8 <commands+0xe0>
ffffffffc02006b0:	a1dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006b4:	780c                	ld	a1,48(s0)
ffffffffc02006b6:	00008517          	auipc	a0,0x8
ffffffffc02006ba:	c2a50513          	addi	a0,a0,-982 # ffffffffc02082e0 <commands+0xf8>
ffffffffc02006be:	a0fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006c2:	7c0c                	ld	a1,56(s0)
ffffffffc02006c4:	00008517          	auipc	a0,0x8
ffffffffc02006c8:	c3450513          	addi	a0,a0,-972 # ffffffffc02082f8 <commands+0x110>
ffffffffc02006cc:	a01ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006d0:	602c                	ld	a1,64(s0)
ffffffffc02006d2:	00008517          	auipc	a0,0x8
ffffffffc02006d6:	c3e50513          	addi	a0,a0,-962 # ffffffffc0208310 <commands+0x128>
ffffffffc02006da:	9f3ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006de:	642c                	ld	a1,72(s0)
ffffffffc02006e0:	00008517          	auipc	a0,0x8
ffffffffc02006e4:	c4850513          	addi	a0,a0,-952 # ffffffffc0208328 <commands+0x140>
ffffffffc02006e8:	9e5ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006ec:	682c                	ld	a1,80(s0)
ffffffffc02006ee:	00008517          	auipc	a0,0x8
ffffffffc02006f2:	c5250513          	addi	a0,a0,-942 # ffffffffc0208340 <commands+0x158>
ffffffffc02006f6:	9d7ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006fa:	6c2c                	ld	a1,88(s0)
ffffffffc02006fc:	00008517          	auipc	a0,0x8
ffffffffc0200700:	c5c50513          	addi	a0,a0,-932 # ffffffffc0208358 <commands+0x170>
ffffffffc0200704:	9c9ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200708:	702c                	ld	a1,96(s0)
ffffffffc020070a:	00008517          	auipc	a0,0x8
ffffffffc020070e:	c6650513          	addi	a0,a0,-922 # ffffffffc0208370 <commands+0x188>
ffffffffc0200712:	9bbff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200716:	742c                	ld	a1,104(s0)
ffffffffc0200718:	00008517          	auipc	a0,0x8
ffffffffc020071c:	c7050513          	addi	a0,a0,-912 # ffffffffc0208388 <commands+0x1a0>
ffffffffc0200720:	9adff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200724:	782c                	ld	a1,112(s0)
ffffffffc0200726:	00008517          	auipc	a0,0x8
ffffffffc020072a:	c7a50513          	addi	a0,a0,-902 # ffffffffc02083a0 <commands+0x1b8>
ffffffffc020072e:	99fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200732:	7c2c                	ld	a1,120(s0)
ffffffffc0200734:	00008517          	auipc	a0,0x8
ffffffffc0200738:	c8450513          	addi	a0,a0,-892 # ffffffffc02083b8 <commands+0x1d0>
ffffffffc020073c:	991ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200740:	604c                	ld	a1,128(s0)
ffffffffc0200742:	00008517          	auipc	a0,0x8
ffffffffc0200746:	c8e50513          	addi	a0,a0,-882 # ffffffffc02083d0 <commands+0x1e8>
ffffffffc020074a:	983ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020074e:	644c                	ld	a1,136(s0)
ffffffffc0200750:	00008517          	auipc	a0,0x8
ffffffffc0200754:	c9850513          	addi	a0,a0,-872 # ffffffffc02083e8 <commands+0x200>
ffffffffc0200758:	975ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020075c:	684c                	ld	a1,144(s0)
ffffffffc020075e:	00008517          	auipc	a0,0x8
ffffffffc0200762:	ca250513          	addi	a0,a0,-862 # ffffffffc0208400 <commands+0x218>
ffffffffc0200766:	967ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020076a:	6c4c                	ld	a1,152(s0)
ffffffffc020076c:	00008517          	auipc	a0,0x8
ffffffffc0200770:	cac50513          	addi	a0,a0,-852 # ffffffffc0208418 <commands+0x230>
ffffffffc0200774:	959ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200778:	704c                	ld	a1,160(s0)
ffffffffc020077a:	00008517          	auipc	a0,0x8
ffffffffc020077e:	cb650513          	addi	a0,a0,-842 # ffffffffc0208430 <commands+0x248>
ffffffffc0200782:	94bff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200786:	744c                	ld	a1,168(s0)
ffffffffc0200788:	00008517          	auipc	a0,0x8
ffffffffc020078c:	cc050513          	addi	a0,a0,-832 # ffffffffc0208448 <commands+0x260>
ffffffffc0200790:	93dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200794:	784c                	ld	a1,176(s0)
ffffffffc0200796:	00008517          	auipc	a0,0x8
ffffffffc020079a:	cca50513          	addi	a0,a0,-822 # ffffffffc0208460 <commands+0x278>
ffffffffc020079e:	92fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007a2:	7c4c                	ld	a1,184(s0)
ffffffffc02007a4:	00008517          	auipc	a0,0x8
ffffffffc02007a8:	cd450513          	addi	a0,a0,-812 # ffffffffc0208478 <commands+0x290>
ffffffffc02007ac:	921ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007b0:	606c                	ld	a1,192(s0)
ffffffffc02007b2:	00008517          	auipc	a0,0x8
ffffffffc02007b6:	cde50513          	addi	a0,a0,-802 # ffffffffc0208490 <commands+0x2a8>
ffffffffc02007ba:	913ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007be:	646c                	ld	a1,200(s0)
ffffffffc02007c0:	00008517          	auipc	a0,0x8
ffffffffc02007c4:	ce850513          	addi	a0,a0,-792 # ffffffffc02084a8 <commands+0x2c0>
ffffffffc02007c8:	905ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007cc:	686c                	ld	a1,208(s0)
ffffffffc02007ce:	00008517          	auipc	a0,0x8
ffffffffc02007d2:	cf250513          	addi	a0,a0,-782 # ffffffffc02084c0 <commands+0x2d8>
ffffffffc02007d6:	8f7ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007da:	6c6c                	ld	a1,216(s0)
ffffffffc02007dc:	00008517          	auipc	a0,0x8
ffffffffc02007e0:	cfc50513          	addi	a0,a0,-772 # ffffffffc02084d8 <commands+0x2f0>
ffffffffc02007e4:	8e9ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007e8:	706c                	ld	a1,224(s0)
ffffffffc02007ea:	00008517          	auipc	a0,0x8
ffffffffc02007ee:	d0650513          	addi	a0,a0,-762 # ffffffffc02084f0 <commands+0x308>
ffffffffc02007f2:	8dbff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007f6:	746c                	ld	a1,232(s0)
ffffffffc02007f8:	00008517          	auipc	a0,0x8
ffffffffc02007fc:	d1050513          	addi	a0,a0,-752 # ffffffffc0208508 <commands+0x320>
ffffffffc0200800:	8cdff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200804:	786c                	ld	a1,240(s0)
ffffffffc0200806:	00008517          	auipc	a0,0x8
ffffffffc020080a:	d1a50513          	addi	a0,a0,-742 # ffffffffc0208520 <commands+0x338>
ffffffffc020080e:	8bfff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200812:	7c6c                	ld	a1,248(s0)
ffffffffc0200814:	6402                	ld	s0,0(sp)
ffffffffc0200816:	60a2                	ld	ra,8(sp)
ffffffffc0200818:	00008517          	auipc	a0,0x8
ffffffffc020081c:	d2050513          	addi	a0,a0,-736 # ffffffffc0208538 <commands+0x350>
ffffffffc0200820:	0141                	addi	sp,sp,16
ffffffffc0200822:	8abff06f          	j	ffffffffc02000cc <cprintf>

ffffffffc0200826 <print_trapframe>:
ffffffffc0200826:	1141                	addi	sp,sp,-16
ffffffffc0200828:	e022                	sd	s0,0(sp)
ffffffffc020082a:	85aa                	mv	a1,a0
ffffffffc020082c:	842a                	mv	s0,a0
ffffffffc020082e:	00008517          	auipc	a0,0x8
ffffffffc0200832:	d2250513          	addi	a0,a0,-734 # ffffffffc0208550 <commands+0x368>
ffffffffc0200836:	e406                	sd	ra,8(sp)
ffffffffc0200838:	895ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020083c:	8522                	mv	a0,s0
ffffffffc020083e:	e1bff0ef          	jal	ra,ffffffffc0200658 <print_regs>
ffffffffc0200842:	10043583          	ld	a1,256(s0)
ffffffffc0200846:	00008517          	auipc	a0,0x8
ffffffffc020084a:	d2250513          	addi	a0,a0,-734 # ffffffffc0208568 <commands+0x380>
ffffffffc020084e:	87fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200852:	10843583          	ld	a1,264(s0)
ffffffffc0200856:	00008517          	auipc	a0,0x8
ffffffffc020085a:	d2a50513          	addi	a0,a0,-726 # ffffffffc0208580 <commands+0x398>
ffffffffc020085e:	86fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200862:	11043583          	ld	a1,272(s0)
ffffffffc0200866:	00008517          	auipc	a0,0x8
ffffffffc020086a:	d3250513          	addi	a0,a0,-718 # ffffffffc0208598 <commands+0x3b0>
ffffffffc020086e:	85fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200872:	11843583          	ld	a1,280(s0)
ffffffffc0200876:	6402                	ld	s0,0(sp)
ffffffffc0200878:	60a2                	ld	ra,8(sp)
ffffffffc020087a:	00008517          	auipc	a0,0x8
ffffffffc020087e:	d2e50513          	addi	a0,a0,-722 # ffffffffc02085a8 <commands+0x3c0>
ffffffffc0200882:	0141                	addi	sp,sp,16
ffffffffc0200884:	849ff06f          	j	ffffffffc02000cc <cprintf>

ffffffffc0200888 <pgfault_handler>:
ffffffffc0200888:	1101                	addi	sp,sp,-32
ffffffffc020088a:	e426                	sd	s1,8(sp)
ffffffffc020088c:	00019497          	auipc	s1,0x19
ffffffffc0200890:	cc448493          	addi	s1,s1,-828 # ffffffffc0219550 <check_mm_struct>
ffffffffc0200894:	609c                	ld	a5,0(s1)
ffffffffc0200896:	e822                	sd	s0,16(sp)
ffffffffc0200898:	ec06                	sd	ra,24(sp)
ffffffffc020089a:	842a                	mv	s0,a0
ffffffffc020089c:	cbad                	beqz	a5,ffffffffc020090e <pgfault_handler+0x86>
ffffffffc020089e:	10053783          	ld	a5,256(a0)
ffffffffc02008a2:	11053583          	ld	a1,272(a0)
ffffffffc02008a6:	04b00613          	li	a2,75
ffffffffc02008aa:	1007f793          	andi	a5,a5,256
ffffffffc02008ae:	c7b1                	beqz	a5,ffffffffc02008fa <pgfault_handler+0x72>
ffffffffc02008b0:	11843703          	ld	a4,280(s0)
ffffffffc02008b4:	47bd                	li	a5,15
ffffffffc02008b6:	05700693          	li	a3,87
ffffffffc02008ba:	00f70463          	beq	a4,a5,ffffffffc02008c2 <pgfault_handler+0x3a>
ffffffffc02008be:	05200693          	li	a3,82
ffffffffc02008c2:	00008517          	auipc	a0,0x8
ffffffffc02008c6:	cfe50513          	addi	a0,a0,-770 # ffffffffc02085c0 <commands+0x3d8>
ffffffffc02008ca:	803ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02008ce:	6088                	ld	a0,0(s1)
ffffffffc02008d0:	cd1d                	beqz	a0,ffffffffc020090e <pgfault_handler+0x86>
ffffffffc02008d2:	00019717          	auipc	a4,0x19
ffffffffc02008d6:	c2673703          	ld	a4,-986(a4) # ffffffffc02194f8 <current>
ffffffffc02008da:	00019797          	auipc	a5,0x19
ffffffffc02008de:	c267b783          	ld	a5,-986(a5) # ffffffffc0219500 <idleproc>
ffffffffc02008e2:	04f71663          	bne	a4,a5,ffffffffc020092e <pgfault_handler+0xa6>
ffffffffc02008e6:	11043603          	ld	a2,272(s0)
ffffffffc02008ea:	11843583          	ld	a1,280(s0)
ffffffffc02008ee:	6442                	ld	s0,16(sp)
ffffffffc02008f0:	60e2                	ld	ra,24(sp)
ffffffffc02008f2:	64a2                	ld	s1,8(sp)
ffffffffc02008f4:	6105                	addi	sp,sp,32
ffffffffc02008f6:	1b40106f          	j	ffffffffc0201aaa <do_pgfault>
ffffffffc02008fa:	11843703          	ld	a4,280(s0)
ffffffffc02008fe:	47bd                	li	a5,15
ffffffffc0200900:	05500613          	li	a2,85
ffffffffc0200904:	05700693          	li	a3,87
ffffffffc0200908:	faf71be3          	bne	a4,a5,ffffffffc02008be <pgfault_handler+0x36>
ffffffffc020090c:	bf5d                	j	ffffffffc02008c2 <pgfault_handler+0x3a>
ffffffffc020090e:	00019797          	auipc	a5,0x19
ffffffffc0200912:	bea7b783          	ld	a5,-1046(a5) # ffffffffc02194f8 <current>
ffffffffc0200916:	cf85                	beqz	a5,ffffffffc020094e <pgfault_handler+0xc6>
ffffffffc0200918:	11043603          	ld	a2,272(s0)
ffffffffc020091c:	11843583          	ld	a1,280(s0)
ffffffffc0200920:	6442                	ld	s0,16(sp)
ffffffffc0200922:	60e2                	ld	ra,24(sp)
ffffffffc0200924:	64a2                	ld	s1,8(sp)
ffffffffc0200926:	7788                	ld	a0,40(a5)
ffffffffc0200928:	6105                	addi	sp,sp,32
ffffffffc020092a:	1800106f          	j	ffffffffc0201aaa <do_pgfault>
ffffffffc020092e:	00008697          	auipc	a3,0x8
ffffffffc0200932:	cb268693          	addi	a3,a3,-846 # ffffffffc02085e0 <commands+0x3f8>
ffffffffc0200936:	00008617          	auipc	a2,0x8
ffffffffc020093a:	cc260613          	addi	a2,a2,-830 # ffffffffc02085f8 <commands+0x410>
ffffffffc020093e:	06c00593          	li	a1,108
ffffffffc0200942:	00008517          	auipc	a0,0x8
ffffffffc0200946:	cce50513          	addi	a0,a0,-818 # ffffffffc0208610 <commands+0x428>
ffffffffc020094a:	8bfff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020094e:	8522                	mv	a0,s0
ffffffffc0200950:	ed7ff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200954:	10043783          	ld	a5,256(s0)
ffffffffc0200958:	11043583          	ld	a1,272(s0)
ffffffffc020095c:	04b00613          	li	a2,75
ffffffffc0200960:	1007f793          	andi	a5,a5,256
ffffffffc0200964:	e399                	bnez	a5,ffffffffc020096a <pgfault_handler+0xe2>
ffffffffc0200966:	05500613          	li	a2,85
ffffffffc020096a:	11843703          	ld	a4,280(s0)
ffffffffc020096e:	47bd                	li	a5,15
ffffffffc0200970:	02f70663          	beq	a4,a5,ffffffffc020099c <pgfault_handler+0x114>
ffffffffc0200974:	05200693          	li	a3,82
ffffffffc0200978:	00008517          	auipc	a0,0x8
ffffffffc020097c:	c4850513          	addi	a0,a0,-952 # ffffffffc02085c0 <commands+0x3d8>
ffffffffc0200980:	f4cff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200984:	00008617          	auipc	a2,0x8
ffffffffc0200988:	ca460613          	addi	a2,a2,-860 # ffffffffc0208628 <commands+0x440>
ffffffffc020098c:	07300593          	li	a1,115
ffffffffc0200990:	00008517          	auipc	a0,0x8
ffffffffc0200994:	c8050513          	addi	a0,a0,-896 # ffffffffc0208610 <commands+0x428>
ffffffffc0200998:	871ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020099c:	05700693          	li	a3,87
ffffffffc02009a0:	bfe1                	j	ffffffffc0200978 <pgfault_handler+0xf0>

ffffffffc02009a2 <interrupt_handler>:
ffffffffc02009a2:	11853783          	ld	a5,280(a0)
ffffffffc02009a6:	472d                	li	a4,11
ffffffffc02009a8:	0786                	slli	a5,a5,0x1
ffffffffc02009aa:	8385                	srli	a5,a5,0x1
ffffffffc02009ac:	06f76863          	bltu	a4,a5,ffffffffc0200a1c <interrupt_handler+0x7a>
ffffffffc02009b0:	00008717          	auipc	a4,0x8
ffffffffc02009b4:	d3070713          	addi	a4,a4,-720 # ffffffffc02086e0 <commands+0x4f8>
ffffffffc02009b8:	078a                	slli	a5,a5,0x2
ffffffffc02009ba:	97ba                	add	a5,a5,a4
ffffffffc02009bc:	439c                	lw	a5,0(a5)
ffffffffc02009be:	97ba                	add	a5,a5,a4
ffffffffc02009c0:	8782                	jr	a5
ffffffffc02009c2:	00008517          	auipc	a0,0x8
ffffffffc02009c6:	cde50513          	addi	a0,a0,-802 # ffffffffc02086a0 <commands+0x4b8>
ffffffffc02009ca:	f02ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009ce:	00008517          	auipc	a0,0x8
ffffffffc02009d2:	cb250513          	addi	a0,a0,-846 # ffffffffc0208680 <commands+0x498>
ffffffffc02009d6:	ef6ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009da:	00008517          	auipc	a0,0x8
ffffffffc02009de:	c6650513          	addi	a0,a0,-922 # ffffffffc0208640 <commands+0x458>
ffffffffc02009e2:	eeaff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009e6:	00008517          	auipc	a0,0x8
ffffffffc02009ea:	c7a50513          	addi	a0,a0,-902 # ffffffffc0208660 <commands+0x478>
ffffffffc02009ee:	edeff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009f2:	1141                	addi	sp,sp,-16
ffffffffc02009f4:	e406                	sd	ra,8(sp)
ffffffffc02009f6:	bb1ff0ef          	jal	ra,ffffffffc02005a6 <clock_set_next_event>
ffffffffc02009fa:	00019717          	auipc	a4,0x19
ffffffffc02009fe:	b2e70713          	addi	a4,a4,-1234 # ffffffffc0219528 <ticks>
ffffffffc0200a02:	631c                	ld	a5,0(a4)
ffffffffc0200a04:	60a2                	ld	ra,8(sp)
ffffffffc0200a06:	0785                	addi	a5,a5,1
ffffffffc0200a08:	e31c                	sd	a5,0(a4)
ffffffffc0200a0a:	0141                	addi	sp,sp,16
ffffffffc0200a0c:	2960406f          	j	ffffffffc0204ca2 <run_timer_list>
ffffffffc0200a10:	00008517          	auipc	a0,0x8
ffffffffc0200a14:	cb050513          	addi	a0,a0,-848 # ffffffffc02086c0 <commands+0x4d8>
ffffffffc0200a18:	eb4ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc0200a1c:	b529                	j	ffffffffc0200826 <print_trapframe>

ffffffffc0200a1e <exception_handler>:
ffffffffc0200a1e:	11853783          	ld	a5,280(a0)
ffffffffc0200a22:	1101                	addi	sp,sp,-32
ffffffffc0200a24:	e822                	sd	s0,16(sp)
ffffffffc0200a26:	ec06                	sd	ra,24(sp)
ffffffffc0200a28:	e426                	sd	s1,8(sp)
ffffffffc0200a2a:	473d                	li	a4,15
ffffffffc0200a2c:	842a                	mv	s0,a0
ffffffffc0200a2e:	16f76163          	bltu	a4,a5,ffffffffc0200b90 <exception_handler+0x172>
ffffffffc0200a32:	00008717          	auipc	a4,0x8
ffffffffc0200a36:	e7670713          	addi	a4,a4,-394 # ffffffffc02088a8 <commands+0x6c0>
ffffffffc0200a3a:	078a                	slli	a5,a5,0x2
ffffffffc0200a3c:	97ba                	add	a5,a5,a4
ffffffffc0200a3e:	439c                	lw	a5,0(a5)
ffffffffc0200a40:	97ba                	add	a5,a5,a4
ffffffffc0200a42:	8782                	jr	a5
ffffffffc0200a44:	00008517          	auipc	a0,0x8
ffffffffc0200a48:	dbc50513          	addi	a0,a0,-580 # ffffffffc0208800 <commands+0x618>
ffffffffc0200a4c:	e80ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200a50:	10843783          	ld	a5,264(s0)
ffffffffc0200a54:	60e2                	ld	ra,24(sp)
ffffffffc0200a56:	64a2                	ld	s1,8(sp)
ffffffffc0200a58:	0791                	addi	a5,a5,4
ffffffffc0200a5a:	10f43423          	sd	a5,264(s0)
ffffffffc0200a5e:	6442                	ld	s0,16(sp)
ffffffffc0200a60:	6105                	addi	sp,sp,32
ffffffffc0200a62:	7e30606f          	j	ffffffffc0207a44 <syscall>
ffffffffc0200a66:	00008517          	auipc	a0,0x8
ffffffffc0200a6a:	dba50513          	addi	a0,a0,-582 # ffffffffc0208820 <commands+0x638>
ffffffffc0200a6e:	6442                	ld	s0,16(sp)
ffffffffc0200a70:	60e2                	ld	ra,24(sp)
ffffffffc0200a72:	64a2                	ld	s1,8(sp)
ffffffffc0200a74:	6105                	addi	sp,sp,32
ffffffffc0200a76:	e56ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc0200a7a:	00008517          	auipc	a0,0x8
ffffffffc0200a7e:	dc650513          	addi	a0,a0,-570 # ffffffffc0208840 <commands+0x658>
ffffffffc0200a82:	b7f5                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200a84:	00008517          	auipc	a0,0x8
ffffffffc0200a88:	ddc50513          	addi	a0,a0,-548 # ffffffffc0208860 <commands+0x678>
ffffffffc0200a8c:	b7cd                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200a8e:	00008517          	auipc	a0,0x8
ffffffffc0200a92:	dea50513          	addi	a0,a0,-534 # ffffffffc0208878 <commands+0x690>
ffffffffc0200a96:	e36ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200a9a:	8522                	mv	a0,s0
ffffffffc0200a9c:	dedff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200aa0:	84aa                	mv	s1,a0
ffffffffc0200aa2:	10051963          	bnez	a0,ffffffffc0200bb4 <exception_handler+0x196>
ffffffffc0200aa6:	60e2                	ld	ra,24(sp)
ffffffffc0200aa8:	6442                	ld	s0,16(sp)
ffffffffc0200aaa:	64a2                	ld	s1,8(sp)
ffffffffc0200aac:	6105                	addi	sp,sp,32
ffffffffc0200aae:	8082                	ret
ffffffffc0200ab0:	00008517          	auipc	a0,0x8
ffffffffc0200ab4:	de050513          	addi	a0,a0,-544 # ffffffffc0208890 <commands+0x6a8>
ffffffffc0200ab8:	e14ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200abc:	8522                	mv	a0,s0
ffffffffc0200abe:	dcbff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200ac2:	84aa                	mv	s1,a0
ffffffffc0200ac4:	d16d                	beqz	a0,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200ac6:	8522                	mv	a0,s0
ffffffffc0200ac8:	d5fff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200acc:	86a6                	mv	a3,s1
ffffffffc0200ace:	00008617          	auipc	a2,0x8
ffffffffc0200ad2:	ce260613          	addi	a2,a2,-798 # ffffffffc02087b0 <commands+0x5c8>
ffffffffc0200ad6:	0f600593          	li	a1,246
ffffffffc0200ada:	00008517          	auipc	a0,0x8
ffffffffc0200ade:	b3650513          	addi	a0,a0,-1226 # ffffffffc0208610 <commands+0x428>
ffffffffc0200ae2:	f26ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200ae6:	00008517          	auipc	a0,0x8
ffffffffc0200aea:	c2a50513          	addi	a0,a0,-982 # ffffffffc0208710 <commands+0x528>
ffffffffc0200aee:	b741                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200af0:	00008517          	auipc	a0,0x8
ffffffffc0200af4:	c4050513          	addi	a0,a0,-960 # ffffffffc0208730 <commands+0x548>
ffffffffc0200af8:	bf9d                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200afa:	00008517          	auipc	a0,0x8
ffffffffc0200afe:	c5650513          	addi	a0,a0,-938 # ffffffffc0208750 <commands+0x568>
ffffffffc0200b02:	b7b5                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200b04:	00008517          	auipc	a0,0x8
ffffffffc0200b08:	c6450513          	addi	a0,a0,-924 # ffffffffc0208768 <commands+0x580>
ffffffffc0200b0c:	dc0ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200b10:	6458                	ld	a4,136(s0)
ffffffffc0200b12:	47a9                	li	a5,10
ffffffffc0200b14:	f8f719e3          	bne	a4,a5,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200b18:	bf25                	j	ffffffffc0200a50 <exception_handler+0x32>
ffffffffc0200b1a:	00008517          	auipc	a0,0x8
ffffffffc0200b1e:	c5e50513          	addi	a0,a0,-930 # ffffffffc0208778 <commands+0x590>
ffffffffc0200b22:	b7b1                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200b24:	00008517          	auipc	a0,0x8
ffffffffc0200b28:	c7450513          	addi	a0,a0,-908 # ffffffffc0208798 <commands+0x5b0>
ffffffffc0200b2c:	da0ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200b30:	8522                	mv	a0,s0
ffffffffc0200b32:	d57ff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200b36:	84aa                	mv	s1,a0
ffffffffc0200b38:	d53d                	beqz	a0,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200b3a:	8522                	mv	a0,s0
ffffffffc0200b3c:	cebff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200b40:	86a6                	mv	a3,s1
ffffffffc0200b42:	00008617          	auipc	a2,0x8
ffffffffc0200b46:	c6e60613          	addi	a2,a2,-914 # ffffffffc02087b0 <commands+0x5c8>
ffffffffc0200b4a:	0cb00593          	li	a1,203
ffffffffc0200b4e:	00008517          	auipc	a0,0x8
ffffffffc0200b52:	ac250513          	addi	a0,a0,-1342 # ffffffffc0208610 <commands+0x428>
ffffffffc0200b56:	eb2ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200b5a:	00008517          	auipc	a0,0x8
ffffffffc0200b5e:	c8e50513          	addi	a0,a0,-882 # ffffffffc02087e8 <commands+0x600>
ffffffffc0200b62:	d6aff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200b66:	8522                	mv	a0,s0
ffffffffc0200b68:	d21ff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200b6c:	84aa                	mv	s1,a0
ffffffffc0200b6e:	dd05                	beqz	a0,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200b70:	8522                	mv	a0,s0
ffffffffc0200b72:	cb5ff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200b76:	86a6                	mv	a3,s1
ffffffffc0200b78:	00008617          	auipc	a2,0x8
ffffffffc0200b7c:	c3860613          	addi	a2,a2,-968 # ffffffffc02087b0 <commands+0x5c8>
ffffffffc0200b80:	0d500593          	li	a1,213
ffffffffc0200b84:	00008517          	auipc	a0,0x8
ffffffffc0200b88:	a8c50513          	addi	a0,a0,-1396 # ffffffffc0208610 <commands+0x428>
ffffffffc0200b8c:	e7cff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200b90:	8522                	mv	a0,s0
ffffffffc0200b92:	6442                	ld	s0,16(sp)
ffffffffc0200b94:	60e2                	ld	ra,24(sp)
ffffffffc0200b96:	64a2                	ld	s1,8(sp)
ffffffffc0200b98:	6105                	addi	sp,sp,32
ffffffffc0200b9a:	b171                	j	ffffffffc0200826 <print_trapframe>
ffffffffc0200b9c:	00008617          	auipc	a2,0x8
ffffffffc0200ba0:	c3460613          	addi	a2,a2,-972 # ffffffffc02087d0 <commands+0x5e8>
ffffffffc0200ba4:	0cf00593          	li	a1,207
ffffffffc0200ba8:	00008517          	auipc	a0,0x8
ffffffffc0200bac:	a6850513          	addi	a0,a0,-1432 # ffffffffc0208610 <commands+0x428>
ffffffffc0200bb0:	e58ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200bb4:	8522                	mv	a0,s0
ffffffffc0200bb6:	c71ff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200bba:	86a6                	mv	a3,s1
ffffffffc0200bbc:	00008617          	auipc	a2,0x8
ffffffffc0200bc0:	bf460613          	addi	a2,a2,-1036 # ffffffffc02087b0 <commands+0x5c8>
ffffffffc0200bc4:	0ef00593          	li	a1,239
ffffffffc0200bc8:	00008517          	auipc	a0,0x8
ffffffffc0200bcc:	a4850513          	addi	a0,a0,-1464 # ffffffffc0208610 <commands+0x428>
ffffffffc0200bd0:	e38ff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0200bd4 <trap>:
ffffffffc0200bd4:	1101                	addi	sp,sp,-32
ffffffffc0200bd6:	e822                	sd	s0,16(sp)
ffffffffc0200bd8:	00019417          	auipc	s0,0x19
ffffffffc0200bdc:	92040413          	addi	s0,s0,-1760 # ffffffffc02194f8 <current>
ffffffffc0200be0:	6018                	ld	a4,0(s0)
ffffffffc0200be2:	ec06                	sd	ra,24(sp)
ffffffffc0200be4:	e426                	sd	s1,8(sp)
ffffffffc0200be6:	e04a                	sd	s2,0(sp)
ffffffffc0200be8:	11853683          	ld	a3,280(a0)
ffffffffc0200bec:	cf1d                	beqz	a4,ffffffffc0200c2a <trap+0x56>
ffffffffc0200bee:	10053483          	ld	s1,256(a0)
ffffffffc0200bf2:	0a073903          	ld	s2,160(a4)
ffffffffc0200bf6:	f348                	sd	a0,160(a4)
ffffffffc0200bf8:	1004f493          	andi	s1,s1,256
ffffffffc0200bfc:	0206c463          	bltz	a3,ffffffffc0200c24 <trap+0x50>
ffffffffc0200c00:	e1fff0ef          	jal	ra,ffffffffc0200a1e <exception_handler>
ffffffffc0200c04:	601c                	ld	a5,0(s0)
ffffffffc0200c06:	0b27b023          	sd	s2,160(a5)
ffffffffc0200c0a:	e499                	bnez	s1,ffffffffc0200c18 <trap+0x44>
ffffffffc0200c0c:	0b07a703          	lw	a4,176(a5)
ffffffffc0200c10:	8b05                	andi	a4,a4,1
ffffffffc0200c12:	e329                	bnez	a4,ffffffffc0200c54 <trap+0x80>
ffffffffc0200c14:	6f9c                	ld	a5,24(a5)
ffffffffc0200c16:	eb85                	bnez	a5,ffffffffc0200c46 <trap+0x72>
ffffffffc0200c18:	60e2                	ld	ra,24(sp)
ffffffffc0200c1a:	6442                	ld	s0,16(sp)
ffffffffc0200c1c:	64a2                	ld	s1,8(sp)
ffffffffc0200c1e:	6902                	ld	s2,0(sp)
ffffffffc0200c20:	6105                	addi	sp,sp,32
ffffffffc0200c22:	8082                	ret
ffffffffc0200c24:	d7fff0ef          	jal	ra,ffffffffc02009a2 <interrupt_handler>
ffffffffc0200c28:	bff1                	j	ffffffffc0200c04 <trap+0x30>
ffffffffc0200c2a:	0006c863          	bltz	a3,ffffffffc0200c3a <trap+0x66>
ffffffffc0200c2e:	6442                	ld	s0,16(sp)
ffffffffc0200c30:	60e2                	ld	ra,24(sp)
ffffffffc0200c32:	64a2                	ld	s1,8(sp)
ffffffffc0200c34:	6902                	ld	s2,0(sp)
ffffffffc0200c36:	6105                	addi	sp,sp,32
ffffffffc0200c38:	b3dd                	j	ffffffffc0200a1e <exception_handler>
ffffffffc0200c3a:	6442                	ld	s0,16(sp)
ffffffffc0200c3c:	60e2                	ld	ra,24(sp)
ffffffffc0200c3e:	64a2                	ld	s1,8(sp)
ffffffffc0200c40:	6902                	ld	s2,0(sp)
ffffffffc0200c42:	6105                	addi	sp,sp,32
ffffffffc0200c44:	bbb9                	j	ffffffffc02009a2 <interrupt_handler>
ffffffffc0200c46:	6442                	ld	s0,16(sp)
ffffffffc0200c48:	60e2                	ld	ra,24(sp)
ffffffffc0200c4a:	64a2                	ld	s1,8(sp)
ffffffffc0200c4c:	6902                	ld	s2,0(sp)
ffffffffc0200c4e:	6105                	addi	sp,sp,32
ffffffffc0200c50:	6410306f          	j	ffffffffc0204a90 <schedule>
ffffffffc0200c54:	555d                	li	a0,-9
ffffffffc0200c56:	0c0030ef          	jal	ra,ffffffffc0203d16 <do_exit>
ffffffffc0200c5a:	601c                	ld	a5,0(s0)
ffffffffc0200c5c:	bf65                	j	ffffffffc0200c14 <trap+0x40>
	...

ffffffffc0200c60 <__alltraps>:
ffffffffc0200c60:	14011173          	csrrw	sp,sscratch,sp
ffffffffc0200c64:	00011463          	bnez	sp,ffffffffc0200c6c <__alltraps+0xc>
ffffffffc0200c68:	14002173          	csrr	sp,sscratch
ffffffffc0200c6c:	712d                	addi	sp,sp,-288
ffffffffc0200c6e:	e002                	sd	zero,0(sp)
ffffffffc0200c70:	e406                	sd	ra,8(sp)
ffffffffc0200c72:	ec0e                	sd	gp,24(sp)
ffffffffc0200c74:	f012                	sd	tp,32(sp)
ffffffffc0200c76:	f416                	sd	t0,40(sp)
ffffffffc0200c78:	f81a                	sd	t1,48(sp)
ffffffffc0200c7a:	fc1e                	sd	t2,56(sp)
ffffffffc0200c7c:	e0a2                	sd	s0,64(sp)
ffffffffc0200c7e:	e4a6                	sd	s1,72(sp)
ffffffffc0200c80:	e8aa                	sd	a0,80(sp)
ffffffffc0200c82:	ecae                	sd	a1,88(sp)
ffffffffc0200c84:	f0b2                	sd	a2,96(sp)
ffffffffc0200c86:	f4b6                	sd	a3,104(sp)
ffffffffc0200c88:	f8ba                	sd	a4,112(sp)
ffffffffc0200c8a:	fcbe                	sd	a5,120(sp)
ffffffffc0200c8c:	e142                	sd	a6,128(sp)
ffffffffc0200c8e:	e546                	sd	a7,136(sp)
ffffffffc0200c90:	e94a                	sd	s2,144(sp)
ffffffffc0200c92:	ed4e                	sd	s3,152(sp)
ffffffffc0200c94:	f152                	sd	s4,160(sp)
ffffffffc0200c96:	f556                	sd	s5,168(sp)
ffffffffc0200c98:	f95a                	sd	s6,176(sp)
ffffffffc0200c9a:	fd5e                	sd	s7,184(sp)
ffffffffc0200c9c:	e1e2                	sd	s8,192(sp)
ffffffffc0200c9e:	e5e6                	sd	s9,200(sp)
ffffffffc0200ca0:	e9ea                	sd	s10,208(sp)
ffffffffc0200ca2:	edee                	sd	s11,216(sp)
ffffffffc0200ca4:	f1f2                	sd	t3,224(sp)
ffffffffc0200ca6:	f5f6                	sd	t4,232(sp)
ffffffffc0200ca8:	f9fa                	sd	t5,240(sp)
ffffffffc0200caa:	fdfe                	sd	t6,248(sp)
ffffffffc0200cac:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200cb0:	100024f3          	csrr	s1,sstatus
ffffffffc0200cb4:	14102973          	csrr	s2,sepc
ffffffffc0200cb8:	143029f3          	csrr	s3,stval
ffffffffc0200cbc:	14202a73          	csrr	s4,scause
ffffffffc0200cc0:	e822                	sd	s0,16(sp)
ffffffffc0200cc2:	e226                	sd	s1,256(sp)
ffffffffc0200cc4:	e64a                	sd	s2,264(sp)
ffffffffc0200cc6:	ea4e                	sd	s3,272(sp)
ffffffffc0200cc8:	ee52                	sd	s4,280(sp)
ffffffffc0200cca:	850a                	mv	a0,sp
ffffffffc0200ccc:	f09ff0ef          	jal	ra,ffffffffc0200bd4 <trap>

ffffffffc0200cd0 <__trapret>:
ffffffffc0200cd0:	6492                	ld	s1,256(sp)
ffffffffc0200cd2:	6932                	ld	s2,264(sp)
ffffffffc0200cd4:	1004f413          	andi	s0,s1,256
ffffffffc0200cd8:	e401                	bnez	s0,ffffffffc0200ce0 <__trapret+0x10>
ffffffffc0200cda:	1200                	addi	s0,sp,288
ffffffffc0200cdc:	14041073          	csrw	sscratch,s0
ffffffffc0200ce0:	10049073          	csrw	sstatus,s1
ffffffffc0200ce4:	14191073          	csrw	sepc,s2
ffffffffc0200ce8:	60a2                	ld	ra,8(sp)
ffffffffc0200cea:	61e2                	ld	gp,24(sp)
ffffffffc0200cec:	7202                	ld	tp,32(sp)
ffffffffc0200cee:	72a2                	ld	t0,40(sp)
ffffffffc0200cf0:	7342                	ld	t1,48(sp)
ffffffffc0200cf2:	73e2                	ld	t2,56(sp)
ffffffffc0200cf4:	6406                	ld	s0,64(sp)
ffffffffc0200cf6:	64a6                	ld	s1,72(sp)
ffffffffc0200cf8:	6546                	ld	a0,80(sp)
ffffffffc0200cfa:	65e6                	ld	a1,88(sp)
ffffffffc0200cfc:	7606                	ld	a2,96(sp)
ffffffffc0200cfe:	76a6                	ld	a3,104(sp)
ffffffffc0200d00:	7746                	ld	a4,112(sp)
ffffffffc0200d02:	77e6                	ld	a5,120(sp)
ffffffffc0200d04:	680a                	ld	a6,128(sp)
ffffffffc0200d06:	68aa                	ld	a7,136(sp)
ffffffffc0200d08:	694a                	ld	s2,144(sp)
ffffffffc0200d0a:	69ea                	ld	s3,152(sp)
ffffffffc0200d0c:	7a0a                	ld	s4,160(sp)
ffffffffc0200d0e:	7aaa                	ld	s5,168(sp)
ffffffffc0200d10:	7b4a                	ld	s6,176(sp)
ffffffffc0200d12:	7bea                	ld	s7,184(sp)
ffffffffc0200d14:	6c0e                	ld	s8,192(sp)
ffffffffc0200d16:	6cae                	ld	s9,200(sp)
ffffffffc0200d18:	6d4e                	ld	s10,208(sp)
ffffffffc0200d1a:	6dee                	ld	s11,216(sp)
ffffffffc0200d1c:	7e0e                	ld	t3,224(sp)
ffffffffc0200d1e:	7eae                	ld	t4,232(sp)
ffffffffc0200d20:	7f4e                	ld	t5,240(sp)
ffffffffc0200d22:	7fee                	ld	t6,248(sp)
ffffffffc0200d24:	6142                	ld	sp,16(sp)
ffffffffc0200d26:	10200073          	sret

ffffffffc0200d2a <forkrets>:
ffffffffc0200d2a:	812a                	mv	sp,a0
ffffffffc0200d2c:	b755                	j	ffffffffc0200cd0 <__trapret>

ffffffffc0200d2e <pa2page.part.0>:
ffffffffc0200d2e:	1141                	addi	sp,sp,-16
ffffffffc0200d30:	00008617          	auipc	a2,0x8
ffffffffc0200d34:	bb860613          	addi	a2,a2,-1096 # ffffffffc02088e8 <commands+0x700>
ffffffffc0200d38:	06200593          	li	a1,98
ffffffffc0200d3c:	00008517          	auipc	a0,0x8
ffffffffc0200d40:	bcc50513          	addi	a0,a0,-1076 # ffffffffc0208908 <commands+0x720>
ffffffffc0200d44:	e406                	sd	ra,8(sp)
ffffffffc0200d46:	cc2ff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0200d4a <alloc_pages>:
ffffffffc0200d4a:	7139                	addi	sp,sp,-64
ffffffffc0200d4c:	f426                	sd	s1,40(sp)
ffffffffc0200d4e:	f04a                	sd	s2,32(sp)
ffffffffc0200d50:	ec4e                	sd	s3,24(sp)
ffffffffc0200d52:	e852                	sd	s4,16(sp)
ffffffffc0200d54:	e456                	sd	s5,8(sp)
ffffffffc0200d56:	e05a                	sd	s6,0(sp)
ffffffffc0200d58:	fc06                	sd	ra,56(sp)
ffffffffc0200d5a:	f822                	sd	s0,48(sp)
ffffffffc0200d5c:	84aa                	mv	s1,a0
ffffffffc0200d5e:	00018917          	auipc	s2,0x18
ffffffffc0200d62:	7d290913          	addi	s2,s2,2002 # ffffffffc0219530 <pmm_manager>
ffffffffc0200d66:	4a05                	li	s4,1
ffffffffc0200d68:	00018a97          	auipc	s5,0x18
ffffffffc0200d6c:	780a8a93          	addi	s5,s5,1920 # ffffffffc02194e8 <swap_init_ok>
ffffffffc0200d70:	0005099b          	sext.w	s3,a0
ffffffffc0200d74:	00018b17          	auipc	s6,0x18
ffffffffc0200d78:	7dcb0b13          	addi	s6,s6,2012 # ffffffffc0219550 <check_mm_struct>
ffffffffc0200d7c:	a01d                	j	ffffffffc0200da2 <alloc_pages+0x58>
ffffffffc0200d7e:	00093783          	ld	a5,0(s2)
ffffffffc0200d82:	6f9c                	ld	a5,24(a5)
ffffffffc0200d84:	9782                	jalr	a5
ffffffffc0200d86:	842a                	mv	s0,a0
ffffffffc0200d88:	4601                	li	a2,0
ffffffffc0200d8a:	85ce                	mv	a1,s3
ffffffffc0200d8c:	ec0d                	bnez	s0,ffffffffc0200dc6 <alloc_pages+0x7c>
ffffffffc0200d8e:	029a6c63          	bltu	s4,s1,ffffffffc0200dc6 <alloc_pages+0x7c>
ffffffffc0200d92:	000aa783          	lw	a5,0(s5)
ffffffffc0200d96:	2781                	sext.w	a5,a5
ffffffffc0200d98:	c79d                	beqz	a5,ffffffffc0200dc6 <alloc_pages+0x7c>
ffffffffc0200d9a:	000b3503          	ld	a0,0(s6)
ffffffffc0200d9e:	745000ef          	jal	ra,ffffffffc0201ce2 <swap_out>
ffffffffc0200da2:	100027f3          	csrr	a5,sstatus
ffffffffc0200da6:	8b89                	andi	a5,a5,2
ffffffffc0200da8:	8526                	mv	a0,s1
ffffffffc0200daa:	dbf1                	beqz	a5,ffffffffc0200d7e <alloc_pages+0x34>
ffffffffc0200dac:	88dff0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0200db0:	00093783          	ld	a5,0(s2)
ffffffffc0200db4:	8526                	mv	a0,s1
ffffffffc0200db6:	6f9c                	ld	a5,24(a5)
ffffffffc0200db8:	9782                	jalr	a5
ffffffffc0200dba:	842a                	mv	s0,a0
ffffffffc0200dbc:	877ff0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0200dc0:	4601                	li	a2,0
ffffffffc0200dc2:	85ce                	mv	a1,s3
ffffffffc0200dc4:	d469                	beqz	s0,ffffffffc0200d8e <alloc_pages+0x44>
ffffffffc0200dc6:	70e2                	ld	ra,56(sp)
ffffffffc0200dc8:	8522                	mv	a0,s0
ffffffffc0200dca:	7442                	ld	s0,48(sp)
ffffffffc0200dcc:	74a2                	ld	s1,40(sp)
ffffffffc0200dce:	7902                	ld	s2,32(sp)
ffffffffc0200dd0:	69e2                	ld	s3,24(sp)
ffffffffc0200dd2:	6a42                	ld	s4,16(sp)
ffffffffc0200dd4:	6aa2                	ld	s5,8(sp)
ffffffffc0200dd6:	6b02                	ld	s6,0(sp)
ffffffffc0200dd8:	6121                	addi	sp,sp,64
ffffffffc0200dda:	8082                	ret

ffffffffc0200ddc <free_pages>:
ffffffffc0200ddc:	100027f3          	csrr	a5,sstatus
ffffffffc0200de0:	8b89                	andi	a5,a5,2
ffffffffc0200de2:	eb81                	bnez	a5,ffffffffc0200df2 <free_pages+0x16>
ffffffffc0200de4:	00018797          	auipc	a5,0x18
ffffffffc0200de8:	74c7b783          	ld	a5,1868(a5) # ffffffffc0219530 <pmm_manager>
ffffffffc0200dec:	0207b303          	ld	t1,32(a5)
ffffffffc0200df0:	8302                	jr	t1
ffffffffc0200df2:	1101                	addi	sp,sp,-32
ffffffffc0200df4:	ec06                	sd	ra,24(sp)
ffffffffc0200df6:	e822                	sd	s0,16(sp)
ffffffffc0200df8:	e426                	sd	s1,8(sp)
ffffffffc0200dfa:	842a                	mv	s0,a0
ffffffffc0200dfc:	84ae                	mv	s1,a1
ffffffffc0200dfe:	83bff0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0200e02:	00018797          	auipc	a5,0x18
ffffffffc0200e06:	72e7b783          	ld	a5,1838(a5) # ffffffffc0219530 <pmm_manager>
ffffffffc0200e0a:	739c                	ld	a5,32(a5)
ffffffffc0200e0c:	85a6                	mv	a1,s1
ffffffffc0200e0e:	8522                	mv	a0,s0
ffffffffc0200e10:	9782                	jalr	a5
ffffffffc0200e12:	6442                	ld	s0,16(sp)
ffffffffc0200e14:	60e2                	ld	ra,24(sp)
ffffffffc0200e16:	64a2                	ld	s1,8(sp)
ffffffffc0200e18:	6105                	addi	sp,sp,32
ffffffffc0200e1a:	819ff06f          	j	ffffffffc0200632 <intr_enable>

ffffffffc0200e1e <nr_free_pages>:
ffffffffc0200e1e:	100027f3          	csrr	a5,sstatus
ffffffffc0200e22:	8b89                	andi	a5,a5,2
ffffffffc0200e24:	eb81                	bnez	a5,ffffffffc0200e34 <nr_free_pages+0x16>
ffffffffc0200e26:	00018797          	auipc	a5,0x18
ffffffffc0200e2a:	70a7b783          	ld	a5,1802(a5) # ffffffffc0219530 <pmm_manager>
ffffffffc0200e2e:	0287b303          	ld	t1,40(a5)
ffffffffc0200e32:	8302                	jr	t1
ffffffffc0200e34:	1141                	addi	sp,sp,-16
ffffffffc0200e36:	e406                	sd	ra,8(sp)
ffffffffc0200e38:	e022                	sd	s0,0(sp)
ffffffffc0200e3a:	ffeff0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0200e3e:	00018797          	auipc	a5,0x18
ffffffffc0200e42:	6f27b783          	ld	a5,1778(a5) # ffffffffc0219530 <pmm_manager>
ffffffffc0200e46:	779c                	ld	a5,40(a5)
ffffffffc0200e48:	9782                	jalr	a5
ffffffffc0200e4a:	842a                	mv	s0,a0
ffffffffc0200e4c:	fe6ff0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0200e50:	60a2                	ld	ra,8(sp)
ffffffffc0200e52:	8522                	mv	a0,s0
ffffffffc0200e54:	6402                	ld	s0,0(sp)
ffffffffc0200e56:	0141                	addi	sp,sp,16
ffffffffc0200e58:	8082                	ret

ffffffffc0200e5a <pmm_init>:
ffffffffc0200e5a:	00008797          	auipc	a5,0x8
ffffffffc0200e5e:	4de78793          	addi	a5,a5,1246 # ffffffffc0209338 <default_pmm_manager>
ffffffffc0200e62:	638c                	ld	a1,0(a5)
ffffffffc0200e64:	1101                	addi	sp,sp,-32
ffffffffc0200e66:	e426                	sd	s1,8(sp)
ffffffffc0200e68:	00008517          	auipc	a0,0x8
ffffffffc0200e6c:	ab050513          	addi	a0,a0,-1360 # ffffffffc0208918 <commands+0x730>
ffffffffc0200e70:	00018497          	auipc	s1,0x18
ffffffffc0200e74:	6c048493          	addi	s1,s1,1728 # ffffffffc0219530 <pmm_manager>
ffffffffc0200e78:	ec06                	sd	ra,24(sp)
ffffffffc0200e7a:	e822                	sd	s0,16(sp)
ffffffffc0200e7c:	e09c                	sd	a5,0(s1)
ffffffffc0200e7e:	a4eff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200e82:	609c                	ld	a5,0(s1)
ffffffffc0200e84:	00018417          	auipc	s0,0x18
ffffffffc0200e88:	6b440413          	addi	s0,s0,1716 # ffffffffc0219538 <va_pa_offset>
ffffffffc0200e8c:	679c                	ld	a5,8(a5)
ffffffffc0200e8e:	9782                	jalr	a5
ffffffffc0200e90:	57f5                	li	a5,-3
ffffffffc0200e92:	07fa                	slli	a5,a5,0x1e
ffffffffc0200e94:	00008517          	auipc	a0,0x8
ffffffffc0200e98:	a9c50513          	addi	a0,a0,-1380 # ffffffffc0208930 <commands+0x748>
ffffffffc0200e9c:	e01c                	sd	a5,0(s0)
ffffffffc0200e9e:	a2eff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200ea2:	44300693          	li	a3,1091
ffffffffc0200ea6:	06d6                	slli	a3,a3,0x15
ffffffffc0200ea8:	40100613          	li	a2,1025
ffffffffc0200eac:	0656                	slli	a2,a2,0x15
ffffffffc0200eae:	088005b7          	lui	a1,0x8800
ffffffffc0200eb2:	16fd                	addi	a3,a3,-1
ffffffffc0200eb4:	00008517          	auipc	a0,0x8
ffffffffc0200eb8:	a9450513          	addi	a0,a0,-1388 # ffffffffc0208948 <commands+0x760>
ffffffffc0200ebc:	a10ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200ec0:	777d                	lui	a4,0xfffff
ffffffffc0200ec2:	0001a797          	auipc	a5,0x1a
ffffffffc0200ec6:	84578793          	addi	a5,a5,-1979 # ffffffffc021a707 <end+0xfff>
ffffffffc0200eca:	8ff9                	and	a5,a5,a4
ffffffffc0200ecc:	00088737          	lui	a4,0x88
ffffffffc0200ed0:	60070713          	addi	a4,a4,1536 # 88600 <kern_entry-0xffffffffc0177a00>
ffffffffc0200ed4:	00018597          	auipc	a1,0x18
ffffffffc0200ed8:	5fc58593          	addi	a1,a1,1532 # ffffffffc02194d0 <npage>
ffffffffc0200edc:	00018617          	auipc	a2,0x18
ffffffffc0200ee0:	66c60613          	addi	a2,a2,1644 # ffffffffc0219548 <pages>
ffffffffc0200ee4:	e198                	sd	a4,0(a1)
ffffffffc0200ee6:	e21c                	sd	a5,0(a2)
ffffffffc0200ee8:	4701                	li	a4,0
ffffffffc0200eea:	4505                	li	a0,1
ffffffffc0200eec:	fff80837          	lui	a6,0xfff80
ffffffffc0200ef0:	a011                	j	ffffffffc0200ef4 <pmm_init+0x9a>
ffffffffc0200ef2:	621c                	ld	a5,0(a2)
ffffffffc0200ef4:	00671693          	slli	a3,a4,0x6
ffffffffc0200ef8:	97b6                	add	a5,a5,a3
ffffffffc0200efa:	07a1                	addi	a5,a5,8
ffffffffc0200efc:	40a7b02f          	amoor.d	zero,a0,(a5)
ffffffffc0200f00:	0005b883          	ld	a7,0(a1)
ffffffffc0200f04:	0705                	addi	a4,a4,1
ffffffffc0200f06:	010886b3          	add	a3,a7,a6
ffffffffc0200f0a:	fed764e3          	bltu	a4,a3,ffffffffc0200ef2 <pmm_init+0x98>
ffffffffc0200f0e:	6208                	ld	a0,0(a2)
ffffffffc0200f10:	069a                	slli	a3,a3,0x6
ffffffffc0200f12:	c02007b7          	lui	a5,0xc0200
ffffffffc0200f16:	96aa                	add	a3,a3,a0
ffffffffc0200f18:	06f6e163          	bltu	a3,a5,ffffffffc0200f7a <pmm_init+0x120>
ffffffffc0200f1c:	601c                	ld	a5,0(s0)
ffffffffc0200f1e:	44300593          	li	a1,1091
ffffffffc0200f22:	05d6                	slli	a1,a1,0x15
ffffffffc0200f24:	8e9d                	sub	a3,a3,a5
ffffffffc0200f26:	02b6f363          	bgeu	a3,a1,ffffffffc0200f4c <pmm_init+0xf2>
ffffffffc0200f2a:	6785                	lui	a5,0x1
ffffffffc0200f2c:	17fd                	addi	a5,a5,-1
ffffffffc0200f2e:	96be                	add	a3,a3,a5
ffffffffc0200f30:	00c6d793          	srli	a5,a3,0xc
ffffffffc0200f34:	0717fb63          	bgeu	a5,a7,ffffffffc0200faa <pmm_init+0x150>
ffffffffc0200f38:	6098                	ld	a4,0(s1)
ffffffffc0200f3a:	767d                	lui	a2,0xfffff
ffffffffc0200f3c:	8ef1                	and	a3,a3,a2
ffffffffc0200f3e:	97c2                	add	a5,a5,a6
ffffffffc0200f40:	6b18                	ld	a4,16(a4)
ffffffffc0200f42:	8d95                	sub	a1,a1,a3
ffffffffc0200f44:	079a                	slli	a5,a5,0x6
ffffffffc0200f46:	81b1                	srli	a1,a1,0xc
ffffffffc0200f48:	953e                	add	a0,a0,a5
ffffffffc0200f4a:	9702                	jalr	a4
ffffffffc0200f4c:	0000c697          	auipc	a3,0xc
ffffffffc0200f50:	0b468693          	addi	a3,a3,180 # ffffffffc020d000 <boot_page_table_sv39>
ffffffffc0200f54:	00018797          	auipc	a5,0x18
ffffffffc0200f58:	56d7ba23          	sd	a3,1396(a5) # ffffffffc02194c8 <boot_pgdir>
ffffffffc0200f5c:	c02007b7          	lui	a5,0xc0200
ffffffffc0200f60:	02f6e963          	bltu	a3,a5,ffffffffc0200f92 <pmm_init+0x138>
ffffffffc0200f64:	601c                	ld	a5,0(s0)
ffffffffc0200f66:	60e2                	ld	ra,24(sp)
ffffffffc0200f68:	6442                	ld	s0,16(sp)
ffffffffc0200f6a:	8e9d                	sub	a3,a3,a5
ffffffffc0200f6c:	00018797          	auipc	a5,0x18
ffffffffc0200f70:	5cd7ba23          	sd	a3,1492(a5) # ffffffffc0219540 <boot_cr3>
ffffffffc0200f74:	64a2                	ld	s1,8(sp)
ffffffffc0200f76:	6105                	addi	sp,sp,32
ffffffffc0200f78:	8082                	ret
ffffffffc0200f7a:	00008617          	auipc	a2,0x8
ffffffffc0200f7e:	9f660613          	addi	a2,a2,-1546 # ffffffffc0208970 <commands+0x788>
ffffffffc0200f82:	07f00593          	li	a1,127
ffffffffc0200f86:	00008517          	auipc	a0,0x8
ffffffffc0200f8a:	a1250513          	addi	a0,a0,-1518 # ffffffffc0208998 <commands+0x7b0>
ffffffffc0200f8e:	a7aff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200f92:	00008617          	auipc	a2,0x8
ffffffffc0200f96:	9de60613          	addi	a2,a2,-1570 # ffffffffc0208970 <commands+0x788>
ffffffffc0200f9a:	0c100593          	li	a1,193
ffffffffc0200f9e:	00008517          	auipc	a0,0x8
ffffffffc0200fa2:	9fa50513          	addi	a0,a0,-1542 # ffffffffc0208998 <commands+0x7b0>
ffffffffc0200fa6:	a62ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200faa:	d85ff0ef          	jal	ra,ffffffffc0200d2e <pa2page.part.0>

ffffffffc0200fae <get_pte>:
ffffffffc0200fae:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0200fb2:	1ff7f793          	andi	a5,a5,511
ffffffffc0200fb6:	7139                	addi	sp,sp,-64
ffffffffc0200fb8:	078e                	slli	a5,a5,0x3
ffffffffc0200fba:	f426                	sd	s1,40(sp)
ffffffffc0200fbc:	00f504b3          	add	s1,a0,a5
ffffffffc0200fc0:	6094                	ld	a3,0(s1)
ffffffffc0200fc2:	f04a                	sd	s2,32(sp)
ffffffffc0200fc4:	ec4e                	sd	s3,24(sp)
ffffffffc0200fc6:	e852                	sd	s4,16(sp)
ffffffffc0200fc8:	fc06                	sd	ra,56(sp)
ffffffffc0200fca:	f822                	sd	s0,48(sp)
ffffffffc0200fcc:	e456                	sd	s5,8(sp)
ffffffffc0200fce:	e05a                	sd	s6,0(sp)
ffffffffc0200fd0:	0016f793          	andi	a5,a3,1
ffffffffc0200fd4:	892e                	mv	s2,a1
ffffffffc0200fd6:	89b2                	mv	s3,a2
ffffffffc0200fd8:	00018a17          	auipc	s4,0x18
ffffffffc0200fdc:	4f8a0a13          	addi	s4,s4,1272 # ffffffffc02194d0 <npage>
ffffffffc0200fe0:	e7b5                	bnez	a5,ffffffffc020104c <get_pte+0x9e>
ffffffffc0200fe2:	12060b63          	beqz	a2,ffffffffc0201118 <get_pte+0x16a>
ffffffffc0200fe6:	4505                	li	a0,1
ffffffffc0200fe8:	d63ff0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0200fec:	842a                	mv	s0,a0
ffffffffc0200fee:	12050563          	beqz	a0,ffffffffc0201118 <get_pte+0x16a>
ffffffffc0200ff2:	00018b17          	auipc	s6,0x18
ffffffffc0200ff6:	556b0b13          	addi	s6,s6,1366 # ffffffffc0219548 <pages>
ffffffffc0200ffa:	000b3503          	ld	a0,0(s6)
ffffffffc0200ffe:	00080ab7          	lui	s5,0x80
ffffffffc0201002:	00018a17          	auipc	s4,0x18
ffffffffc0201006:	4cea0a13          	addi	s4,s4,1230 # ffffffffc02194d0 <npage>
ffffffffc020100a:	40a40533          	sub	a0,s0,a0
ffffffffc020100e:	8519                	srai	a0,a0,0x6
ffffffffc0201010:	9556                	add	a0,a0,s5
ffffffffc0201012:	000a3703          	ld	a4,0(s4)
ffffffffc0201016:	00c51793          	slli	a5,a0,0xc
ffffffffc020101a:	4685                	li	a3,1
ffffffffc020101c:	c014                	sw	a3,0(s0)
ffffffffc020101e:	83b1                	srli	a5,a5,0xc
ffffffffc0201020:	0532                	slli	a0,a0,0xc
ffffffffc0201022:	14e7f263          	bgeu	a5,a4,ffffffffc0201166 <get_pte+0x1b8>
ffffffffc0201026:	00018797          	auipc	a5,0x18
ffffffffc020102a:	5127b783          	ld	a5,1298(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc020102e:	6605                	lui	a2,0x1
ffffffffc0201030:	4581                	li	a1,0
ffffffffc0201032:	953e                	add	a0,a0,a5
ffffffffc0201034:	2e3060ef          	jal	ra,ffffffffc0207b16 <memset>
ffffffffc0201038:	000b3683          	ld	a3,0(s6)
ffffffffc020103c:	40d406b3          	sub	a3,s0,a3
ffffffffc0201040:	8699                	srai	a3,a3,0x6
ffffffffc0201042:	96d6                	add	a3,a3,s5
ffffffffc0201044:	06aa                	slli	a3,a3,0xa
ffffffffc0201046:	0116e693          	ori	a3,a3,17
ffffffffc020104a:	e094                	sd	a3,0(s1)
ffffffffc020104c:	77fd                	lui	a5,0xfffff
ffffffffc020104e:	068a                	slli	a3,a3,0x2
ffffffffc0201050:	000a3703          	ld	a4,0(s4)
ffffffffc0201054:	8efd                	and	a3,a3,a5
ffffffffc0201056:	00c6d793          	srli	a5,a3,0xc
ffffffffc020105a:	0ce7f163          	bgeu	a5,a4,ffffffffc020111c <get_pte+0x16e>
ffffffffc020105e:	00018a97          	auipc	s5,0x18
ffffffffc0201062:	4daa8a93          	addi	s5,s5,1242 # ffffffffc0219538 <va_pa_offset>
ffffffffc0201066:	000ab403          	ld	s0,0(s5)
ffffffffc020106a:	01595793          	srli	a5,s2,0x15
ffffffffc020106e:	1ff7f793          	andi	a5,a5,511
ffffffffc0201072:	96a2                	add	a3,a3,s0
ffffffffc0201074:	00379413          	slli	s0,a5,0x3
ffffffffc0201078:	9436                	add	s0,s0,a3
ffffffffc020107a:	6014                	ld	a3,0(s0)
ffffffffc020107c:	0016f793          	andi	a5,a3,1
ffffffffc0201080:	e3ad                	bnez	a5,ffffffffc02010e2 <get_pte+0x134>
ffffffffc0201082:	08098b63          	beqz	s3,ffffffffc0201118 <get_pte+0x16a>
ffffffffc0201086:	4505                	li	a0,1
ffffffffc0201088:	cc3ff0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc020108c:	84aa                	mv	s1,a0
ffffffffc020108e:	c549                	beqz	a0,ffffffffc0201118 <get_pte+0x16a>
ffffffffc0201090:	00018b17          	auipc	s6,0x18
ffffffffc0201094:	4b8b0b13          	addi	s6,s6,1208 # ffffffffc0219548 <pages>
ffffffffc0201098:	000b3503          	ld	a0,0(s6)
ffffffffc020109c:	000809b7          	lui	s3,0x80
ffffffffc02010a0:	000a3703          	ld	a4,0(s4)
ffffffffc02010a4:	40a48533          	sub	a0,s1,a0
ffffffffc02010a8:	8519                	srai	a0,a0,0x6
ffffffffc02010aa:	954e                	add	a0,a0,s3
ffffffffc02010ac:	00c51793          	slli	a5,a0,0xc
ffffffffc02010b0:	4685                	li	a3,1
ffffffffc02010b2:	c094                	sw	a3,0(s1)
ffffffffc02010b4:	83b1                	srli	a5,a5,0xc
ffffffffc02010b6:	0532                	slli	a0,a0,0xc
ffffffffc02010b8:	08e7fa63          	bgeu	a5,a4,ffffffffc020114c <get_pte+0x19e>
ffffffffc02010bc:	000ab783          	ld	a5,0(s5)
ffffffffc02010c0:	6605                	lui	a2,0x1
ffffffffc02010c2:	4581                	li	a1,0
ffffffffc02010c4:	953e                	add	a0,a0,a5
ffffffffc02010c6:	251060ef          	jal	ra,ffffffffc0207b16 <memset>
ffffffffc02010ca:	000b3683          	ld	a3,0(s6)
ffffffffc02010ce:	40d486b3          	sub	a3,s1,a3
ffffffffc02010d2:	8699                	srai	a3,a3,0x6
ffffffffc02010d4:	96ce                	add	a3,a3,s3
ffffffffc02010d6:	06aa                	slli	a3,a3,0xa
ffffffffc02010d8:	0116e693          	ori	a3,a3,17
ffffffffc02010dc:	e014                	sd	a3,0(s0)
ffffffffc02010de:	000a3703          	ld	a4,0(s4)
ffffffffc02010e2:	068a                	slli	a3,a3,0x2
ffffffffc02010e4:	757d                	lui	a0,0xfffff
ffffffffc02010e6:	8ee9                	and	a3,a3,a0
ffffffffc02010e8:	00c6d793          	srli	a5,a3,0xc
ffffffffc02010ec:	04e7f463          	bgeu	a5,a4,ffffffffc0201134 <get_pte+0x186>
ffffffffc02010f0:	000ab503          	ld	a0,0(s5)
ffffffffc02010f4:	00c95913          	srli	s2,s2,0xc
ffffffffc02010f8:	1ff97913          	andi	s2,s2,511
ffffffffc02010fc:	96aa                	add	a3,a3,a0
ffffffffc02010fe:	00391513          	slli	a0,s2,0x3
ffffffffc0201102:	9536                	add	a0,a0,a3
ffffffffc0201104:	70e2                	ld	ra,56(sp)
ffffffffc0201106:	7442                	ld	s0,48(sp)
ffffffffc0201108:	74a2                	ld	s1,40(sp)
ffffffffc020110a:	7902                	ld	s2,32(sp)
ffffffffc020110c:	69e2                	ld	s3,24(sp)
ffffffffc020110e:	6a42                	ld	s4,16(sp)
ffffffffc0201110:	6aa2                	ld	s5,8(sp)
ffffffffc0201112:	6b02                	ld	s6,0(sp)
ffffffffc0201114:	6121                	addi	sp,sp,64
ffffffffc0201116:	8082                	ret
ffffffffc0201118:	4501                	li	a0,0
ffffffffc020111a:	b7ed                	j	ffffffffc0201104 <get_pte+0x156>
ffffffffc020111c:	00008617          	auipc	a2,0x8
ffffffffc0201120:	88c60613          	addi	a2,a2,-1908 # ffffffffc02089a8 <commands+0x7c0>
ffffffffc0201124:	0fe00593          	li	a1,254
ffffffffc0201128:	00008517          	auipc	a0,0x8
ffffffffc020112c:	87050513          	addi	a0,a0,-1936 # ffffffffc0208998 <commands+0x7b0>
ffffffffc0201130:	8d8ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201134:	00008617          	auipc	a2,0x8
ffffffffc0201138:	87460613          	addi	a2,a2,-1932 # ffffffffc02089a8 <commands+0x7c0>
ffffffffc020113c:	10900593          	li	a1,265
ffffffffc0201140:	00008517          	auipc	a0,0x8
ffffffffc0201144:	85850513          	addi	a0,a0,-1960 # ffffffffc0208998 <commands+0x7b0>
ffffffffc0201148:	8c0ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020114c:	86aa                	mv	a3,a0
ffffffffc020114e:	00008617          	auipc	a2,0x8
ffffffffc0201152:	85a60613          	addi	a2,a2,-1958 # ffffffffc02089a8 <commands+0x7c0>
ffffffffc0201156:	10600593          	li	a1,262
ffffffffc020115a:	00008517          	auipc	a0,0x8
ffffffffc020115e:	83e50513          	addi	a0,a0,-1986 # ffffffffc0208998 <commands+0x7b0>
ffffffffc0201162:	8a6ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201166:	86aa                	mv	a3,a0
ffffffffc0201168:	00008617          	auipc	a2,0x8
ffffffffc020116c:	84060613          	addi	a2,a2,-1984 # ffffffffc02089a8 <commands+0x7c0>
ffffffffc0201170:	0fa00593          	li	a1,250
ffffffffc0201174:	00008517          	auipc	a0,0x8
ffffffffc0201178:	82450513          	addi	a0,a0,-2012 # ffffffffc0208998 <commands+0x7b0>
ffffffffc020117c:	88cff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201180 <unmap_range>:
ffffffffc0201180:	711d                	addi	sp,sp,-96
ffffffffc0201182:	00c5e7b3          	or	a5,a1,a2
ffffffffc0201186:	ec86                	sd	ra,88(sp)
ffffffffc0201188:	e8a2                	sd	s0,80(sp)
ffffffffc020118a:	e4a6                	sd	s1,72(sp)
ffffffffc020118c:	e0ca                	sd	s2,64(sp)
ffffffffc020118e:	fc4e                	sd	s3,56(sp)
ffffffffc0201190:	f852                	sd	s4,48(sp)
ffffffffc0201192:	f456                	sd	s5,40(sp)
ffffffffc0201194:	f05a                	sd	s6,32(sp)
ffffffffc0201196:	ec5e                	sd	s7,24(sp)
ffffffffc0201198:	e862                	sd	s8,16(sp)
ffffffffc020119a:	e466                	sd	s9,8(sp)
ffffffffc020119c:	17d2                	slli	a5,a5,0x34
ffffffffc020119e:	ebf1                	bnez	a5,ffffffffc0201272 <unmap_range+0xf2>
ffffffffc02011a0:	002007b7          	lui	a5,0x200
ffffffffc02011a4:	842e                	mv	s0,a1
ffffffffc02011a6:	0af5e663          	bltu	a1,a5,ffffffffc0201252 <unmap_range+0xd2>
ffffffffc02011aa:	8932                	mv	s2,a2
ffffffffc02011ac:	0ac5f363          	bgeu	a1,a2,ffffffffc0201252 <unmap_range+0xd2>
ffffffffc02011b0:	4785                	li	a5,1
ffffffffc02011b2:	07fe                	slli	a5,a5,0x1f
ffffffffc02011b4:	08c7ef63          	bltu	a5,a2,ffffffffc0201252 <unmap_range+0xd2>
ffffffffc02011b8:	89aa                	mv	s3,a0
ffffffffc02011ba:	6a05                	lui	s4,0x1
ffffffffc02011bc:	00018c97          	auipc	s9,0x18
ffffffffc02011c0:	314c8c93          	addi	s9,s9,788 # ffffffffc02194d0 <npage>
ffffffffc02011c4:	00018c17          	auipc	s8,0x18
ffffffffc02011c8:	384c0c13          	addi	s8,s8,900 # ffffffffc0219548 <pages>
ffffffffc02011cc:	fff80bb7          	lui	s7,0xfff80
ffffffffc02011d0:	00200b37          	lui	s6,0x200
ffffffffc02011d4:	ffe00ab7          	lui	s5,0xffe00
ffffffffc02011d8:	4601                	li	a2,0
ffffffffc02011da:	85a2                	mv	a1,s0
ffffffffc02011dc:	854e                	mv	a0,s3
ffffffffc02011de:	dd1ff0ef          	jal	ra,ffffffffc0200fae <get_pte>
ffffffffc02011e2:	84aa                	mv	s1,a0
ffffffffc02011e4:	cd21                	beqz	a0,ffffffffc020123c <unmap_range+0xbc>
ffffffffc02011e6:	611c                	ld	a5,0(a0)
ffffffffc02011e8:	e38d                	bnez	a5,ffffffffc020120a <unmap_range+0x8a>
ffffffffc02011ea:	9452                	add	s0,s0,s4
ffffffffc02011ec:	ff2466e3          	bltu	s0,s2,ffffffffc02011d8 <unmap_range+0x58>
ffffffffc02011f0:	60e6                	ld	ra,88(sp)
ffffffffc02011f2:	6446                	ld	s0,80(sp)
ffffffffc02011f4:	64a6                	ld	s1,72(sp)
ffffffffc02011f6:	6906                	ld	s2,64(sp)
ffffffffc02011f8:	79e2                	ld	s3,56(sp)
ffffffffc02011fa:	7a42                	ld	s4,48(sp)
ffffffffc02011fc:	7aa2                	ld	s5,40(sp)
ffffffffc02011fe:	7b02                	ld	s6,32(sp)
ffffffffc0201200:	6be2                	ld	s7,24(sp)
ffffffffc0201202:	6c42                	ld	s8,16(sp)
ffffffffc0201204:	6ca2                	ld	s9,8(sp)
ffffffffc0201206:	6125                	addi	sp,sp,96
ffffffffc0201208:	8082                	ret
ffffffffc020120a:	0017f713          	andi	a4,a5,1
ffffffffc020120e:	df71                	beqz	a4,ffffffffc02011ea <unmap_range+0x6a>
ffffffffc0201210:	000cb703          	ld	a4,0(s9)
ffffffffc0201214:	078a                	slli	a5,a5,0x2
ffffffffc0201216:	83b1                	srli	a5,a5,0xc
ffffffffc0201218:	06e7fd63          	bgeu	a5,a4,ffffffffc0201292 <unmap_range+0x112>
ffffffffc020121c:	000c3503          	ld	a0,0(s8)
ffffffffc0201220:	97de                	add	a5,a5,s7
ffffffffc0201222:	079a                	slli	a5,a5,0x6
ffffffffc0201224:	953e                	add	a0,a0,a5
ffffffffc0201226:	411c                	lw	a5,0(a0)
ffffffffc0201228:	fff7871b          	addiw	a4,a5,-1
ffffffffc020122c:	c118                	sw	a4,0(a0)
ffffffffc020122e:	cf11                	beqz	a4,ffffffffc020124a <unmap_range+0xca>
ffffffffc0201230:	0004b023          	sd	zero,0(s1)
ffffffffc0201234:	12040073          	sfence.vma	s0
ffffffffc0201238:	9452                	add	s0,s0,s4
ffffffffc020123a:	bf4d                	j	ffffffffc02011ec <unmap_range+0x6c>
ffffffffc020123c:	945a                	add	s0,s0,s6
ffffffffc020123e:	01547433          	and	s0,s0,s5
ffffffffc0201242:	d45d                	beqz	s0,ffffffffc02011f0 <unmap_range+0x70>
ffffffffc0201244:	f9246ae3          	bltu	s0,s2,ffffffffc02011d8 <unmap_range+0x58>
ffffffffc0201248:	b765                	j	ffffffffc02011f0 <unmap_range+0x70>
ffffffffc020124a:	4585                	li	a1,1
ffffffffc020124c:	b91ff0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0201250:	b7c5                	j	ffffffffc0201230 <unmap_range+0xb0>
ffffffffc0201252:	00007697          	auipc	a3,0x7
ffffffffc0201256:	7ae68693          	addi	a3,a3,1966 # ffffffffc0208a00 <commands+0x818>
ffffffffc020125a:	00007617          	auipc	a2,0x7
ffffffffc020125e:	39e60613          	addi	a2,a2,926 # ffffffffc02085f8 <commands+0x410>
ffffffffc0201262:	14100593          	li	a1,321
ffffffffc0201266:	00007517          	auipc	a0,0x7
ffffffffc020126a:	73250513          	addi	a0,a0,1842 # ffffffffc0208998 <commands+0x7b0>
ffffffffc020126e:	f9bfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201272:	00007697          	auipc	a3,0x7
ffffffffc0201276:	75e68693          	addi	a3,a3,1886 # ffffffffc02089d0 <commands+0x7e8>
ffffffffc020127a:	00007617          	auipc	a2,0x7
ffffffffc020127e:	37e60613          	addi	a2,a2,894 # ffffffffc02085f8 <commands+0x410>
ffffffffc0201282:	14000593          	li	a1,320
ffffffffc0201286:	00007517          	auipc	a0,0x7
ffffffffc020128a:	71250513          	addi	a0,a0,1810 # ffffffffc0208998 <commands+0x7b0>
ffffffffc020128e:	f7bfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201292:	a9dff0ef          	jal	ra,ffffffffc0200d2e <pa2page.part.0>

ffffffffc0201296 <exit_range>:
ffffffffc0201296:	715d                	addi	sp,sp,-80
ffffffffc0201298:	00c5e7b3          	or	a5,a1,a2
ffffffffc020129c:	e486                	sd	ra,72(sp)
ffffffffc020129e:	e0a2                	sd	s0,64(sp)
ffffffffc02012a0:	fc26                	sd	s1,56(sp)
ffffffffc02012a2:	f84a                	sd	s2,48(sp)
ffffffffc02012a4:	f44e                	sd	s3,40(sp)
ffffffffc02012a6:	f052                	sd	s4,32(sp)
ffffffffc02012a8:	ec56                	sd	s5,24(sp)
ffffffffc02012aa:	e85a                	sd	s6,16(sp)
ffffffffc02012ac:	e45e                	sd	s7,8(sp)
ffffffffc02012ae:	17d2                	slli	a5,a5,0x34
ffffffffc02012b0:	e3f1                	bnez	a5,ffffffffc0201374 <exit_range+0xde>
ffffffffc02012b2:	002007b7          	lui	a5,0x200
ffffffffc02012b6:	08f5ef63          	bltu	a1,a5,ffffffffc0201354 <exit_range+0xbe>
ffffffffc02012ba:	89b2                	mv	s3,a2
ffffffffc02012bc:	08c5fc63          	bgeu	a1,a2,ffffffffc0201354 <exit_range+0xbe>
ffffffffc02012c0:	4785                	li	a5,1
ffffffffc02012c2:	ffe004b7          	lui	s1,0xffe00
ffffffffc02012c6:	07fe                	slli	a5,a5,0x1f
ffffffffc02012c8:	8ced                	and	s1,s1,a1
ffffffffc02012ca:	08c7e563          	bltu	a5,a2,ffffffffc0201354 <exit_range+0xbe>
ffffffffc02012ce:	8a2a                	mv	s4,a0
ffffffffc02012d0:	00018b17          	auipc	s6,0x18
ffffffffc02012d4:	200b0b13          	addi	s6,s6,512 # ffffffffc02194d0 <npage>
ffffffffc02012d8:	00018b97          	auipc	s7,0x18
ffffffffc02012dc:	270b8b93          	addi	s7,s7,624 # ffffffffc0219548 <pages>
ffffffffc02012e0:	fff80937          	lui	s2,0xfff80
ffffffffc02012e4:	00200ab7          	lui	s5,0x200
ffffffffc02012e8:	a019                	j	ffffffffc02012ee <exit_range+0x58>
ffffffffc02012ea:	0334fe63          	bgeu	s1,s3,ffffffffc0201326 <exit_range+0x90>
ffffffffc02012ee:	01e4d413          	srli	s0,s1,0x1e
ffffffffc02012f2:	1ff47413          	andi	s0,s0,511
ffffffffc02012f6:	040e                	slli	s0,s0,0x3
ffffffffc02012f8:	9452                	add	s0,s0,s4
ffffffffc02012fa:	601c                	ld	a5,0(s0)
ffffffffc02012fc:	0017f713          	andi	a4,a5,1
ffffffffc0201300:	c30d                	beqz	a4,ffffffffc0201322 <exit_range+0x8c>
ffffffffc0201302:	000b3703          	ld	a4,0(s6)
ffffffffc0201306:	078a                	slli	a5,a5,0x2
ffffffffc0201308:	83b1                	srli	a5,a5,0xc
ffffffffc020130a:	02e7f963          	bgeu	a5,a4,ffffffffc020133c <exit_range+0xa6>
ffffffffc020130e:	000bb503          	ld	a0,0(s7)
ffffffffc0201312:	97ca                	add	a5,a5,s2
ffffffffc0201314:	079a                	slli	a5,a5,0x6
ffffffffc0201316:	4585                	li	a1,1
ffffffffc0201318:	953e                	add	a0,a0,a5
ffffffffc020131a:	ac3ff0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc020131e:	00043023          	sd	zero,0(s0)
ffffffffc0201322:	94d6                	add	s1,s1,s5
ffffffffc0201324:	f0f9                	bnez	s1,ffffffffc02012ea <exit_range+0x54>
ffffffffc0201326:	60a6                	ld	ra,72(sp)
ffffffffc0201328:	6406                	ld	s0,64(sp)
ffffffffc020132a:	74e2                	ld	s1,56(sp)
ffffffffc020132c:	7942                	ld	s2,48(sp)
ffffffffc020132e:	79a2                	ld	s3,40(sp)
ffffffffc0201330:	7a02                	ld	s4,32(sp)
ffffffffc0201332:	6ae2                	ld	s5,24(sp)
ffffffffc0201334:	6b42                	ld	s6,16(sp)
ffffffffc0201336:	6ba2                	ld	s7,8(sp)
ffffffffc0201338:	6161                	addi	sp,sp,80
ffffffffc020133a:	8082                	ret
ffffffffc020133c:	00007617          	auipc	a2,0x7
ffffffffc0201340:	5ac60613          	addi	a2,a2,1452 # ffffffffc02088e8 <commands+0x700>
ffffffffc0201344:	06200593          	li	a1,98
ffffffffc0201348:	00007517          	auipc	a0,0x7
ffffffffc020134c:	5c050513          	addi	a0,a0,1472 # ffffffffc0208908 <commands+0x720>
ffffffffc0201350:	eb9fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201354:	00007697          	auipc	a3,0x7
ffffffffc0201358:	6ac68693          	addi	a3,a3,1708 # ffffffffc0208a00 <commands+0x818>
ffffffffc020135c:	00007617          	auipc	a2,0x7
ffffffffc0201360:	29c60613          	addi	a2,a2,668 # ffffffffc02085f8 <commands+0x410>
ffffffffc0201364:	15200593          	li	a1,338
ffffffffc0201368:	00007517          	auipc	a0,0x7
ffffffffc020136c:	63050513          	addi	a0,a0,1584 # ffffffffc0208998 <commands+0x7b0>
ffffffffc0201370:	e99fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201374:	00007697          	auipc	a3,0x7
ffffffffc0201378:	65c68693          	addi	a3,a3,1628 # ffffffffc02089d0 <commands+0x7e8>
ffffffffc020137c:	00007617          	auipc	a2,0x7
ffffffffc0201380:	27c60613          	addi	a2,a2,636 # ffffffffc02085f8 <commands+0x410>
ffffffffc0201384:	15100593          	li	a1,337
ffffffffc0201388:	00007517          	auipc	a0,0x7
ffffffffc020138c:	61050513          	addi	a0,a0,1552 # ffffffffc0208998 <commands+0x7b0>
ffffffffc0201390:	e79fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201394 <page_insert>:
ffffffffc0201394:	7179                	addi	sp,sp,-48
ffffffffc0201396:	e44e                	sd	s3,8(sp)
ffffffffc0201398:	89b2                	mv	s3,a2
ffffffffc020139a:	f022                	sd	s0,32(sp)
ffffffffc020139c:	4605                	li	a2,1
ffffffffc020139e:	842e                	mv	s0,a1
ffffffffc02013a0:	85ce                	mv	a1,s3
ffffffffc02013a2:	ec26                	sd	s1,24(sp)
ffffffffc02013a4:	f406                	sd	ra,40(sp)
ffffffffc02013a6:	e84a                	sd	s2,16(sp)
ffffffffc02013a8:	e052                	sd	s4,0(sp)
ffffffffc02013aa:	84b6                	mv	s1,a3
ffffffffc02013ac:	c03ff0ef          	jal	ra,ffffffffc0200fae <get_pte>
ffffffffc02013b0:	cd41                	beqz	a0,ffffffffc0201448 <page_insert+0xb4>
ffffffffc02013b2:	4014                	lw	a3,0(s0)
ffffffffc02013b4:	611c                	ld	a5,0(a0)
ffffffffc02013b6:	892a                	mv	s2,a0
ffffffffc02013b8:	0016871b          	addiw	a4,a3,1
ffffffffc02013bc:	c018                	sw	a4,0(s0)
ffffffffc02013be:	0017f713          	andi	a4,a5,1
ffffffffc02013c2:	eb1d                	bnez	a4,ffffffffc02013f8 <page_insert+0x64>
ffffffffc02013c4:	00018717          	auipc	a4,0x18
ffffffffc02013c8:	18473703          	ld	a4,388(a4) # ffffffffc0219548 <pages>
ffffffffc02013cc:	8c19                	sub	s0,s0,a4
ffffffffc02013ce:	000807b7          	lui	a5,0x80
ffffffffc02013d2:	8419                	srai	s0,s0,0x6
ffffffffc02013d4:	943e                	add	s0,s0,a5
ffffffffc02013d6:	042a                	slli	s0,s0,0xa
ffffffffc02013d8:	8c45                	or	s0,s0,s1
ffffffffc02013da:	00146413          	ori	s0,s0,1
ffffffffc02013de:	00893023          	sd	s0,0(s2) # fffffffffff80000 <end+0x3fd668f8>
ffffffffc02013e2:	12098073          	sfence.vma	s3
ffffffffc02013e6:	4501                	li	a0,0
ffffffffc02013e8:	70a2                	ld	ra,40(sp)
ffffffffc02013ea:	7402                	ld	s0,32(sp)
ffffffffc02013ec:	64e2                	ld	s1,24(sp)
ffffffffc02013ee:	6942                	ld	s2,16(sp)
ffffffffc02013f0:	69a2                	ld	s3,8(sp)
ffffffffc02013f2:	6a02                	ld	s4,0(sp)
ffffffffc02013f4:	6145                	addi	sp,sp,48
ffffffffc02013f6:	8082                	ret
ffffffffc02013f8:	078a                	slli	a5,a5,0x2
ffffffffc02013fa:	83b1                	srli	a5,a5,0xc
ffffffffc02013fc:	00018717          	auipc	a4,0x18
ffffffffc0201400:	0d473703          	ld	a4,212(a4) # ffffffffc02194d0 <npage>
ffffffffc0201404:	04e7f463          	bgeu	a5,a4,ffffffffc020144c <page_insert+0xb8>
ffffffffc0201408:	00018a17          	auipc	s4,0x18
ffffffffc020140c:	140a0a13          	addi	s4,s4,320 # ffffffffc0219548 <pages>
ffffffffc0201410:	000a3703          	ld	a4,0(s4)
ffffffffc0201414:	fff80537          	lui	a0,0xfff80
ffffffffc0201418:	97aa                	add	a5,a5,a0
ffffffffc020141a:	079a                	slli	a5,a5,0x6
ffffffffc020141c:	97ba                	add	a5,a5,a4
ffffffffc020141e:	00f40a63          	beq	s0,a5,ffffffffc0201432 <page_insert+0x9e>
ffffffffc0201422:	4394                	lw	a3,0(a5)
ffffffffc0201424:	fff6861b          	addiw	a2,a3,-1
ffffffffc0201428:	c390                	sw	a2,0(a5)
ffffffffc020142a:	c611                	beqz	a2,ffffffffc0201436 <page_insert+0xa2>
ffffffffc020142c:	12098073          	sfence.vma	s3
ffffffffc0201430:	bf71                	j	ffffffffc02013cc <page_insert+0x38>
ffffffffc0201432:	c014                	sw	a3,0(s0)
ffffffffc0201434:	bf61                	j	ffffffffc02013cc <page_insert+0x38>
ffffffffc0201436:	4585                	li	a1,1
ffffffffc0201438:	853e                	mv	a0,a5
ffffffffc020143a:	9a3ff0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc020143e:	000a3703          	ld	a4,0(s4)
ffffffffc0201442:	12098073          	sfence.vma	s3
ffffffffc0201446:	b759                	j	ffffffffc02013cc <page_insert+0x38>
ffffffffc0201448:	5571                	li	a0,-4
ffffffffc020144a:	bf79                	j	ffffffffc02013e8 <page_insert+0x54>
ffffffffc020144c:	8e3ff0ef          	jal	ra,ffffffffc0200d2e <pa2page.part.0>

ffffffffc0201450 <copy_range>:
ffffffffc0201450:	7159                	addi	sp,sp,-112
ffffffffc0201452:	00d667b3          	or	a5,a2,a3
ffffffffc0201456:	f486                	sd	ra,104(sp)
ffffffffc0201458:	f0a2                	sd	s0,96(sp)
ffffffffc020145a:	eca6                	sd	s1,88(sp)
ffffffffc020145c:	e8ca                	sd	s2,80(sp)
ffffffffc020145e:	e4ce                	sd	s3,72(sp)
ffffffffc0201460:	e0d2                	sd	s4,64(sp)
ffffffffc0201462:	fc56                	sd	s5,56(sp)
ffffffffc0201464:	f85a                	sd	s6,48(sp)
ffffffffc0201466:	f45e                	sd	s7,40(sp)
ffffffffc0201468:	f062                	sd	s8,32(sp)
ffffffffc020146a:	ec66                	sd	s9,24(sp)
ffffffffc020146c:	e86a                	sd	s10,16(sp)
ffffffffc020146e:	e46e                	sd	s11,8(sp)
ffffffffc0201470:	17d2                	slli	a5,a5,0x34
ffffffffc0201472:	1e079763          	bnez	a5,ffffffffc0201660 <copy_range+0x210>
ffffffffc0201476:	002007b7          	lui	a5,0x200
ffffffffc020147a:	8432                	mv	s0,a2
ffffffffc020147c:	16f66a63          	bltu	a2,a5,ffffffffc02015f0 <copy_range+0x1a0>
ffffffffc0201480:	8936                	mv	s2,a3
ffffffffc0201482:	16d67763          	bgeu	a2,a3,ffffffffc02015f0 <copy_range+0x1a0>
ffffffffc0201486:	4785                	li	a5,1
ffffffffc0201488:	07fe                	slli	a5,a5,0x1f
ffffffffc020148a:	16d7e363          	bltu	a5,a3,ffffffffc02015f0 <copy_range+0x1a0>
ffffffffc020148e:	5b7d                	li	s6,-1
ffffffffc0201490:	8aaa                	mv	s5,a0
ffffffffc0201492:	89ae                	mv	s3,a1
ffffffffc0201494:	6a05                	lui	s4,0x1
ffffffffc0201496:	00018c97          	auipc	s9,0x18
ffffffffc020149a:	03ac8c93          	addi	s9,s9,58 # ffffffffc02194d0 <npage>
ffffffffc020149e:	00018c17          	auipc	s8,0x18
ffffffffc02014a2:	0aac0c13          	addi	s8,s8,170 # ffffffffc0219548 <pages>
ffffffffc02014a6:	00080bb7          	lui	s7,0x80
ffffffffc02014aa:	00cb5b13          	srli	s6,s6,0xc
ffffffffc02014ae:	4601                	li	a2,0
ffffffffc02014b0:	85a2                	mv	a1,s0
ffffffffc02014b2:	854e                	mv	a0,s3
ffffffffc02014b4:	afbff0ef          	jal	ra,ffffffffc0200fae <get_pte>
ffffffffc02014b8:	84aa                	mv	s1,a0
ffffffffc02014ba:	c175                	beqz	a0,ffffffffc020159e <copy_range+0x14e>
ffffffffc02014bc:	611c                	ld	a5,0(a0)
ffffffffc02014be:	8b85                	andi	a5,a5,1
ffffffffc02014c0:	e785                	bnez	a5,ffffffffc02014e8 <copy_range+0x98>
ffffffffc02014c2:	9452                	add	s0,s0,s4
ffffffffc02014c4:	ff2465e3          	bltu	s0,s2,ffffffffc02014ae <copy_range+0x5e>
ffffffffc02014c8:	4501                	li	a0,0
ffffffffc02014ca:	70a6                	ld	ra,104(sp)
ffffffffc02014cc:	7406                	ld	s0,96(sp)
ffffffffc02014ce:	64e6                	ld	s1,88(sp)
ffffffffc02014d0:	6946                	ld	s2,80(sp)
ffffffffc02014d2:	69a6                	ld	s3,72(sp)
ffffffffc02014d4:	6a06                	ld	s4,64(sp)
ffffffffc02014d6:	7ae2                	ld	s5,56(sp)
ffffffffc02014d8:	7b42                	ld	s6,48(sp)
ffffffffc02014da:	7ba2                	ld	s7,40(sp)
ffffffffc02014dc:	7c02                	ld	s8,32(sp)
ffffffffc02014de:	6ce2                	ld	s9,24(sp)
ffffffffc02014e0:	6d42                	ld	s10,16(sp)
ffffffffc02014e2:	6da2                	ld	s11,8(sp)
ffffffffc02014e4:	6165                	addi	sp,sp,112
ffffffffc02014e6:	8082                	ret
ffffffffc02014e8:	4605                	li	a2,1
ffffffffc02014ea:	85a2                	mv	a1,s0
ffffffffc02014ec:	8556                	mv	a0,s5
ffffffffc02014ee:	ac1ff0ef          	jal	ra,ffffffffc0200fae <get_pte>
ffffffffc02014f2:	c161                	beqz	a0,ffffffffc02015b2 <copy_range+0x162>
ffffffffc02014f4:	609c                	ld	a5,0(s1)
ffffffffc02014f6:	0017f713          	andi	a4,a5,1
ffffffffc02014fa:	01f7f493          	andi	s1,a5,31
ffffffffc02014fe:	14070563          	beqz	a4,ffffffffc0201648 <copy_range+0x1f8>
ffffffffc0201502:	000cb683          	ld	a3,0(s9)
ffffffffc0201506:	078a                	slli	a5,a5,0x2
ffffffffc0201508:	00c7d713          	srli	a4,a5,0xc
ffffffffc020150c:	12d77263          	bgeu	a4,a3,ffffffffc0201630 <copy_range+0x1e0>
ffffffffc0201510:	000c3783          	ld	a5,0(s8)
ffffffffc0201514:	fff806b7          	lui	a3,0xfff80
ffffffffc0201518:	9736                	add	a4,a4,a3
ffffffffc020151a:	071a                	slli	a4,a4,0x6
ffffffffc020151c:	4505                	li	a0,1
ffffffffc020151e:	00e78db3          	add	s11,a5,a4
ffffffffc0201522:	829ff0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0201526:	8d2a                	mv	s10,a0
ffffffffc0201528:	0a0d8463          	beqz	s11,ffffffffc02015d0 <copy_range+0x180>
ffffffffc020152c:	c175                	beqz	a0,ffffffffc0201610 <copy_range+0x1c0>
ffffffffc020152e:	000c3703          	ld	a4,0(s8)
ffffffffc0201532:	000cb603          	ld	a2,0(s9)
ffffffffc0201536:	40ed86b3          	sub	a3,s11,a4
ffffffffc020153a:	8699                	srai	a3,a3,0x6
ffffffffc020153c:	96de                	add	a3,a3,s7
ffffffffc020153e:	0166f7b3          	and	a5,a3,s6
ffffffffc0201542:	06b2                	slli	a3,a3,0xc
ffffffffc0201544:	06c7fa63          	bgeu	a5,a2,ffffffffc02015b8 <copy_range+0x168>
ffffffffc0201548:	40e507b3          	sub	a5,a0,a4
ffffffffc020154c:	00018717          	auipc	a4,0x18
ffffffffc0201550:	fec70713          	addi	a4,a4,-20 # ffffffffc0219538 <va_pa_offset>
ffffffffc0201554:	6308                	ld	a0,0(a4)
ffffffffc0201556:	8799                	srai	a5,a5,0x6
ffffffffc0201558:	97de                	add	a5,a5,s7
ffffffffc020155a:	0167f733          	and	a4,a5,s6
ffffffffc020155e:	00a685b3          	add	a1,a3,a0
ffffffffc0201562:	07b2                	slli	a5,a5,0xc
ffffffffc0201564:	04c77963          	bgeu	a4,a2,ffffffffc02015b6 <copy_range+0x166>
ffffffffc0201568:	6605                	lui	a2,0x1
ffffffffc020156a:	953e                	add	a0,a0,a5
ffffffffc020156c:	5bc060ef          	jal	ra,ffffffffc0207b28 <memcpy>
ffffffffc0201570:	86a6                	mv	a3,s1
ffffffffc0201572:	8622                	mv	a2,s0
ffffffffc0201574:	85ea                	mv	a1,s10
ffffffffc0201576:	8556                	mv	a0,s5
ffffffffc0201578:	e1dff0ef          	jal	ra,ffffffffc0201394 <page_insert>
ffffffffc020157c:	d139                	beqz	a0,ffffffffc02014c2 <copy_range+0x72>
ffffffffc020157e:	00007697          	auipc	a3,0x7
ffffffffc0201582:	4e268693          	addi	a3,a3,1250 # ffffffffc0208a60 <commands+0x878>
ffffffffc0201586:	00007617          	auipc	a2,0x7
ffffffffc020158a:	07260613          	addi	a2,a2,114 # ffffffffc02085f8 <commands+0x410>
ffffffffc020158e:	19900593          	li	a1,409
ffffffffc0201592:	00007517          	auipc	a0,0x7
ffffffffc0201596:	40650513          	addi	a0,a0,1030 # ffffffffc0208998 <commands+0x7b0>
ffffffffc020159a:	c6ffe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020159e:	00200637          	lui	a2,0x200
ffffffffc02015a2:	9432                	add	s0,s0,a2
ffffffffc02015a4:	ffe00637          	lui	a2,0xffe00
ffffffffc02015a8:	8c71                	and	s0,s0,a2
ffffffffc02015aa:	dc19                	beqz	s0,ffffffffc02014c8 <copy_range+0x78>
ffffffffc02015ac:	f12461e3          	bltu	s0,s2,ffffffffc02014ae <copy_range+0x5e>
ffffffffc02015b0:	bf21                	j	ffffffffc02014c8 <copy_range+0x78>
ffffffffc02015b2:	5571                	li	a0,-4
ffffffffc02015b4:	bf19                	j	ffffffffc02014ca <copy_range+0x7a>
ffffffffc02015b6:	86be                	mv	a3,a5
ffffffffc02015b8:	00007617          	auipc	a2,0x7
ffffffffc02015bc:	3f060613          	addi	a2,a2,1008 # ffffffffc02089a8 <commands+0x7c0>
ffffffffc02015c0:	06900593          	li	a1,105
ffffffffc02015c4:	00007517          	auipc	a0,0x7
ffffffffc02015c8:	34450513          	addi	a0,a0,836 # ffffffffc0208908 <commands+0x720>
ffffffffc02015cc:	c3dfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02015d0:	00007697          	auipc	a3,0x7
ffffffffc02015d4:	47068693          	addi	a3,a3,1136 # ffffffffc0208a40 <commands+0x858>
ffffffffc02015d8:	00007617          	auipc	a2,0x7
ffffffffc02015dc:	02060613          	addi	a2,a2,32 # ffffffffc02085f8 <commands+0x410>
ffffffffc02015e0:	17e00593          	li	a1,382
ffffffffc02015e4:	00007517          	auipc	a0,0x7
ffffffffc02015e8:	3b450513          	addi	a0,a0,948 # ffffffffc0208998 <commands+0x7b0>
ffffffffc02015ec:	c1dfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02015f0:	00007697          	auipc	a3,0x7
ffffffffc02015f4:	41068693          	addi	a3,a3,1040 # ffffffffc0208a00 <commands+0x818>
ffffffffc02015f8:	00007617          	auipc	a2,0x7
ffffffffc02015fc:	00060613          	mv	a2,a2
ffffffffc0201600:	16a00593          	li	a1,362
ffffffffc0201604:	00007517          	auipc	a0,0x7
ffffffffc0201608:	39450513          	addi	a0,a0,916 # ffffffffc0208998 <commands+0x7b0>
ffffffffc020160c:	bfdfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201610:	00007697          	auipc	a3,0x7
ffffffffc0201614:	44068693          	addi	a3,a3,1088 # ffffffffc0208a50 <commands+0x868>
ffffffffc0201618:	00007617          	auipc	a2,0x7
ffffffffc020161c:	fe060613          	addi	a2,a2,-32 # ffffffffc02085f8 <commands+0x410>
ffffffffc0201620:	17f00593          	li	a1,383
ffffffffc0201624:	00007517          	auipc	a0,0x7
ffffffffc0201628:	37450513          	addi	a0,a0,884 # ffffffffc0208998 <commands+0x7b0>
ffffffffc020162c:	bddfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201630:	00007617          	auipc	a2,0x7
ffffffffc0201634:	2b860613          	addi	a2,a2,696 # ffffffffc02088e8 <commands+0x700>
ffffffffc0201638:	06200593          	li	a1,98
ffffffffc020163c:	00007517          	auipc	a0,0x7
ffffffffc0201640:	2cc50513          	addi	a0,a0,716 # ffffffffc0208908 <commands+0x720>
ffffffffc0201644:	bc5fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201648:	00007617          	auipc	a2,0x7
ffffffffc020164c:	3d060613          	addi	a2,a2,976 # ffffffffc0208a18 <commands+0x830>
ffffffffc0201650:	07400593          	li	a1,116
ffffffffc0201654:	00007517          	auipc	a0,0x7
ffffffffc0201658:	2b450513          	addi	a0,a0,692 # ffffffffc0208908 <commands+0x720>
ffffffffc020165c:	badfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201660:	00007697          	auipc	a3,0x7
ffffffffc0201664:	37068693          	addi	a3,a3,880 # ffffffffc02089d0 <commands+0x7e8>
ffffffffc0201668:	00007617          	auipc	a2,0x7
ffffffffc020166c:	f9060613          	addi	a2,a2,-112 # ffffffffc02085f8 <commands+0x410>
ffffffffc0201670:	16900593          	li	a1,361
ffffffffc0201674:	00007517          	auipc	a0,0x7
ffffffffc0201678:	32450513          	addi	a0,a0,804 # ffffffffc0208998 <commands+0x7b0>
ffffffffc020167c:	b8dfe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201680 <tlb_invalidate>:
ffffffffc0201680:	12058073          	sfence.vma	a1
ffffffffc0201684:	8082                	ret

ffffffffc0201686 <pgdir_alloc_page>:
ffffffffc0201686:	7179                	addi	sp,sp,-48
ffffffffc0201688:	e84a                	sd	s2,16(sp)
ffffffffc020168a:	892a                	mv	s2,a0
ffffffffc020168c:	4505                	li	a0,1
ffffffffc020168e:	f022                	sd	s0,32(sp)
ffffffffc0201690:	ec26                	sd	s1,24(sp)
ffffffffc0201692:	e44e                	sd	s3,8(sp)
ffffffffc0201694:	f406                	sd	ra,40(sp)
ffffffffc0201696:	84ae                	mv	s1,a1
ffffffffc0201698:	89b2                	mv	s3,a2
ffffffffc020169a:	eb0ff0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc020169e:	842a                	mv	s0,a0
ffffffffc02016a0:	cd05                	beqz	a0,ffffffffc02016d8 <pgdir_alloc_page+0x52>
ffffffffc02016a2:	85aa                	mv	a1,a0
ffffffffc02016a4:	86ce                	mv	a3,s3
ffffffffc02016a6:	8626                	mv	a2,s1
ffffffffc02016a8:	854a                	mv	a0,s2
ffffffffc02016aa:	cebff0ef          	jal	ra,ffffffffc0201394 <page_insert>
ffffffffc02016ae:	ed0d                	bnez	a0,ffffffffc02016e8 <pgdir_alloc_page+0x62>
ffffffffc02016b0:	00018797          	auipc	a5,0x18
ffffffffc02016b4:	e387a783          	lw	a5,-456(a5) # ffffffffc02194e8 <swap_init_ok>
ffffffffc02016b8:	c385                	beqz	a5,ffffffffc02016d8 <pgdir_alloc_page+0x52>
ffffffffc02016ba:	00018517          	auipc	a0,0x18
ffffffffc02016be:	e9653503          	ld	a0,-362(a0) # ffffffffc0219550 <check_mm_struct>
ffffffffc02016c2:	c919                	beqz	a0,ffffffffc02016d8 <pgdir_alloc_page+0x52>
ffffffffc02016c4:	4681                	li	a3,0
ffffffffc02016c6:	8622                	mv	a2,s0
ffffffffc02016c8:	85a6                	mv	a1,s1
ffffffffc02016ca:	60a000ef          	jal	ra,ffffffffc0201cd4 <swap_map_swappable>
ffffffffc02016ce:	4018                	lw	a4,0(s0)
ffffffffc02016d0:	fc04                	sd	s1,56(s0)
ffffffffc02016d2:	4785                	li	a5,1
ffffffffc02016d4:	02f71063          	bne	a4,a5,ffffffffc02016f4 <pgdir_alloc_page+0x6e>
ffffffffc02016d8:	70a2                	ld	ra,40(sp)
ffffffffc02016da:	8522                	mv	a0,s0
ffffffffc02016dc:	7402                	ld	s0,32(sp)
ffffffffc02016de:	64e2                	ld	s1,24(sp)
ffffffffc02016e0:	6942                	ld	s2,16(sp)
ffffffffc02016e2:	69a2                	ld	s3,8(sp)
ffffffffc02016e4:	6145                	addi	sp,sp,48
ffffffffc02016e6:	8082                	ret
ffffffffc02016e8:	8522                	mv	a0,s0
ffffffffc02016ea:	4585                	li	a1,1
ffffffffc02016ec:	ef0ff0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc02016f0:	4401                	li	s0,0
ffffffffc02016f2:	b7dd                	j	ffffffffc02016d8 <pgdir_alloc_page+0x52>
ffffffffc02016f4:	00007697          	auipc	a3,0x7
ffffffffc02016f8:	37c68693          	addi	a3,a3,892 # ffffffffc0208a70 <commands+0x888>
ffffffffc02016fc:	00007617          	auipc	a2,0x7
ffffffffc0201700:	efc60613          	addi	a2,a2,-260 # ffffffffc02085f8 <commands+0x410>
ffffffffc0201704:	1d800593          	li	a1,472
ffffffffc0201708:	00007517          	auipc	a0,0x7
ffffffffc020170c:	29050513          	addi	a0,a0,656 # ffffffffc0208998 <commands+0x7b0>
ffffffffc0201710:	af9fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201714 <check_vma_overlap.isra.0.part.0>:
ffffffffc0201714:	1141                	addi	sp,sp,-16
ffffffffc0201716:	00007697          	auipc	a3,0x7
ffffffffc020171a:	37268693          	addi	a3,a3,882 # ffffffffc0208a88 <commands+0x8a0>
ffffffffc020171e:	00007617          	auipc	a2,0x7
ffffffffc0201722:	eda60613          	addi	a2,a2,-294 # ffffffffc02085f8 <commands+0x410>
ffffffffc0201726:	06d00593          	li	a1,109
ffffffffc020172a:	00007517          	auipc	a0,0x7
ffffffffc020172e:	37e50513          	addi	a0,a0,894 # ffffffffc0208aa8 <commands+0x8c0>
ffffffffc0201732:	e406                	sd	ra,8(sp)
ffffffffc0201734:	ad5fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201738 <mm_create>:
ffffffffc0201738:	1141                	addi	sp,sp,-16
ffffffffc020173a:	05800513          	li	a0,88
ffffffffc020173e:	e022                	sd	s0,0(sp)
ffffffffc0201740:	e406                	sd	ra,8(sp)
ffffffffc0201742:	12f000ef          	jal	ra,ffffffffc0202070 <kmalloc>
ffffffffc0201746:	842a                	mv	s0,a0
ffffffffc0201748:	c51d                	beqz	a0,ffffffffc0201776 <mm_create+0x3e>
ffffffffc020174a:	e408                	sd	a0,8(s0)
ffffffffc020174c:	e008                	sd	a0,0(s0)
ffffffffc020174e:	00053823          	sd	zero,16(a0)
ffffffffc0201752:	00053c23          	sd	zero,24(a0)
ffffffffc0201756:	02052023          	sw	zero,32(a0)
ffffffffc020175a:	00018797          	auipc	a5,0x18
ffffffffc020175e:	d8e7a783          	lw	a5,-626(a5) # ffffffffc02194e8 <swap_init_ok>
ffffffffc0201762:	ef99                	bnez	a5,ffffffffc0201780 <mm_create+0x48>
ffffffffc0201764:	02053423          	sd	zero,40(a0)
ffffffffc0201768:	02042823          	sw	zero,48(s0)
ffffffffc020176c:	4585                	li	a1,1
ffffffffc020176e:	03840513          	addi	a0,s0,56
ffffffffc0201772:	367010ef          	jal	ra,ffffffffc02032d8 <sem_init>
ffffffffc0201776:	60a2                	ld	ra,8(sp)
ffffffffc0201778:	8522                	mv	a0,s0
ffffffffc020177a:	6402                	ld	s0,0(sp)
ffffffffc020177c:	0141                	addi	sp,sp,16
ffffffffc020177e:	8082                	ret
ffffffffc0201780:	546000ef          	jal	ra,ffffffffc0201cc6 <swap_init_mm>
ffffffffc0201784:	b7d5                	j	ffffffffc0201768 <mm_create+0x30>

ffffffffc0201786 <find_vma>:
ffffffffc0201786:	86aa                	mv	a3,a0
ffffffffc0201788:	c505                	beqz	a0,ffffffffc02017b0 <find_vma+0x2a>
ffffffffc020178a:	6908                	ld	a0,16(a0)
ffffffffc020178c:	c501                	beqz	a0,ffffffffc0201794 <find_vma+0xe>
ffffffffc020178e:	651c                	ld	a5,8(a0)
ffffffffc0201790:	02f5f263          	bgeu	a1,a5,ffffffffc02017b4 <find_vma+0x2e>
ffffffffc0201794:	669c                	ld	a5,8(a3)
ffffffffc0201796:	00f68d63          	beq	a3,a5,ffffffffc02017b0 <find_vma+0x2a>
ffffffffc020179a:	fe87b703          	ld	a4,-24(a5)
ffffffffc020179e:	00e5e663          	bltu	a1,a4,ffffffffc02017aa <find_vma+0x24>
ffffffffc02017a2:	ff07b703          	ld	a4,-16(a5)
ffffffffc02017a6:	00e5ec63          	bltu	a1,a4,ffffffffc02017be <find_vma+0x38>
ffffffffc02017aa:	679c                	ld	a5,8(a5)
ffffffffc02017ac:	fef697e3          	bne	a3,a5,ffffffffc020179a <find_vma+0x14>
ffffffffc02017b0:	4501                	li	a0,0
ffffffffc02017b2:	8082                	ret
ffffffffc02017b4:	691c                	ld	a5,16(a0)
ffffffffc02017b6:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0201794 <find_vma+0xe>
ffffffffc02017ba:	ea88                	sd	a0,16(a3)
ffffffffc02017bc:	8082                	ret
ffffffffc02017be:	fe078513          	addi	a0,a5,-32
ffffffffc02017c2:	ea88                	sd	a0,16(a3)
ffffffffc02017c4:	8082                	ret

ffffffffc02017c6 <insert_vma_struct>:
ffffffffc02017c6:	6590                	ld	a2,8(a1)
ffffffffc02017c8:	0105b803          	ld	a6,16(a1)
ffffffffc02017cc:	1141                	addi	sp,sp,-16
ffffffffc02017ce:	e406                	sd	ra,8(sp)
ffffffffc02017d0:	87aa                	mv	a5,a0
ffffffffc02017d2:	01066763          	bltu	a2,a6,ffffffffc02017e0 <insert_vma_struct+0x1a>
ffffffffc02017d6:	a085                	j	ffffffffc0201836 <insert_vma_struct+0x70>
ffffffffc02017d8:	fe87b703          	ld	a4,-24(a5)
ffffffffc02017dc:	04e66863          	bltu	a2,a4,ffffffffc020182c <insert_vma_struct+0x66>
ffffffffc02017e0:	86be                	mv	a3,a5
ffffffffc02017e2:	679c                	ld	a5,8(a5)
ffffffffc02017e4:	fef51ae3          	bne	a0,a5,ffffffffc02017d8 <insert_vma_struct+0x12>
ffffffffc02017e8:	02a68463          	beq	a3,a0,ffffffffc0201810 <insert_vma_struct+0x4a>
ffffffffc02017ec:	ff06b703          	ld	a4,-16(a3)
ffffffffc02017f0:	fe86b883          	ld	a7,-24(a3)
ffffffffc02017f4:	08e8f163          	bgeu	a7,a4,ffffffffc0201876 <insert_vma_struct+0xb0>
ffffffffc02017f8:	04e66f63          	bltu	a2,a4,ffffffffc0201856 <insert_vma_struct+0x90>
ffffffffc02017fc:	00f50a63          	beq	a0,a5,ffffffffc0201810 <insert_vma_struct+0x4a>
ffffffffc0201800:	fe87b703          	ld	a4,-24(a5)
ffffffffc0201804:	05076963          	bltu	a4,a6,ffffffffc0201856 <insert_vma_struct+0x90>
ffffffffc0201808:	ff07b603          	ld	a2,-16(a5)
ffffffffc020180c:	02c77363          	bgeu	a4,a2,ffffffffc0201832 <insert_vma_struct+0x6c>
ffffffffc0201810:	5118                	lw	a4,32(a0)
ffffffffc0201812:	e188                	sd	a0,0(a1)
ffffffffc0201814:	02058613          	addi	a2,a1,32
ffffffffc0201818:	e390                	sd	a2,0(a5)
ffffffffc020181a:	e690                	sd	a2,8(a3)
ffffffffc020181c:	60a2                	ld	ra,8(sp)
ffffffffc020181e:	f59c                	sd	a5,40(a1)
ffffffffc0201820:	f194                	sd	a3,32(a1)
ffffffffc0201822:	0017079b          	addiw	a5,a4,1
ffffffffc0201826:	d11c                	sw	a5,32(a0)
ffffffffc0201828:	0141                	addi	sp,sp,16
ffffffffc020182a:	8082                	ret
ffffffffc020182c:	fca690e3          	bne	a3,a0,ffffffffc02017ec <insert_vma_struct+0x26>
ffffffffc0201830:	bfd1                	j	ffffffffc0201804 <insert_vma_struct+0x3e>
ffffffffc0201832:	ee3ff0ef          	jal	ra,ffffffffc0201714 <check_vma_overlap.isra.0.part.0>
ffffffffc0201836:	00007697          	auipc	a3,0x7
ffffffffc020183a:	28268693          	addi	a3,a3,642 # ffffffffc0208ab8 <commands+0x8d0>
ffffffffc020183e:	00007617          	auipc	a2,0x7
ffffffffc0201842:	dba60613          	addi	a2,a2,-582 # ffffffffc02085f8 <commands+0x410>
ffffffffc0201846:	07400593          	li	a1,116
ffffffffc020184a:	00007517          	auipc	a0,0x7
ffffffffc020184e:	25e50513          	addi	a0,a0,606 # ffffffffc0208aa8 <commands+0x8c0>
ffffffffc0201852:	9b7fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201856:	00007697          	auipc	a3,0x7
ffffffffc020185a:	2a268693          	addi	a3,a3,674 # ffffffffc0208af8 <commands+0x910>
ffffffffc020185e:	00007617          	auipc	a2,0x7
ffffffffc0201862:	d9a60613          	addi	a2,a2,-614 # ffffffffc02085f8 <commands+0x410>
ffffffffc0201866:	06c00593          	li	a1,108
ffffffffc020186a:	00007517          	auipc	a0,0x7
ffffffffc020186e:	23e50513          	addi	a0,a0,574 # ffffffffc0208aa8 <commands+0x8c0>
ffffffffc0201872:	997fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201876:	00007697          	auipc	a3,0x7
ffffffffc020187a:	26268693          	addi	a3,a3,610 # ffffffffc0208ad8 <commands+0x8f0>
ffffffffc020187e:	00007617          	auipc	a2,0x7
ffffffffc0201882:	d7a60613          	addi	a2,a2,-646 # ffffffffc02085f8 <commands+0x410>
ffffffffc0201886:	06b00593          	li	a1,107
ffffffffc020188a:	00007517          	auipc	a0,0x7
ffffffffc020188e:	21e50513          	addi	a0,a0,542 # ffffffffc0208aa8 <commands+0x8c0>
ffffffffc0201892:	977fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201896 <mm_destroy>:
ffffffffc0201896:	591c                	lw	a5,48(a0)
ffffffffc0201898:	1141                	addi	sp,sp,-16
ffffffffc020189a:	e406                	sd	ra,8(sp)
ffffffffc020189c:	e022                	sd	s0,0(sp)
ffffffffc020189e:	e78d                	bnez	a5,ffffffffc02018c8 <mm_destroy+0x32>
ffffffffc02018a0:	842a                	mv	s0,a0
ffffffffc02018a2:	6508                	ld	a0,8(a0)
ffffffffc02018a4:	00a40c63          	beq	s0,a0,ffffffffc02018bc <mm_destroy+0x26>
ffffffffc02018a8:	6118                	ld	a4,0(a0)
ffffffffc02018aa:	651c                	ld	a5,8(a0)
ffffffffc02018ac:	1501                	addi	a0,a0,-32
ffffffffc02018ae:	e71c                	sd	a5,8(a4)
ffffffffc02018b0:	e398                	sd	a4,0(a5)
ffffffffc02018b2:	06f000ef          	jal	ra,ffffffffc0202120 <kfree>
ffffffffc02018b6:	6408                	ld	a0,8(s0)
ffffffffc02018b8:	fea418e3          	bne	s0,a0,ffffffffc02018a8 <mm_destroy+0x12>
ffffffffc02018bc:	8522                	mv	a0,s0
ffffffffc02018be:	6402                	ld	s0,0(sp)
ffffffffc02018c0:	60a2                	ld	ra,8(sp)
ffffffffc02018c2:	0141                	addi	sp,sp,16
ffffffffc02018c4:	05d0006f          	j	ffffffffc0202120 <kfree>
ffffffffc02018c8:	00007697          	auipc	a3,0x7
ffffffffc02018cc:	25068693          	addi	a3,a3,592 # ffffffffc0208b18 <commands+0x930>
ffffffffc02018d0:	00007617          	auipc	a2,0x7
ffffffffc02018d4:	d2860613          	addi	a2,a2,-728 # ffffffffc02085f8 <commands+0x410>
ffffffffc02018d8:	09400593          	li	a1,148
ffffffffc02018dc:	00007517          	auipc	a0,0x7
ffffffffc02018e0:	1cc50513          	addi	a0,a0,460 # ffffffffc0208aa8 <commands+0x8c0>
ffffffffc02018e4:	925fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02018e8 <mm_map>:
ffffffffc02018e8:	7139                	addi	sp,sp,-64
ffffffffc02018ea:	f822                	sd	s0,48(sp)
ffffffffc02018ec:	6405                	lui	s0,0x1
ffffffffc02018ee:	147d                	addi	s0,s0,-1
ffffffffc02018f0:	77fd                	lui	a5,0xfffff
ffffffffc02018f2:	9622                	add	a2,a2,s0
ffffffffc02018f4:	962e                	add	a2,a2,a1
ffffffffc02018f6:	f426                	sd	s1,40(sp)
ffffffffc02018f8:	fc06                	sd	ra,56(sp)
ffffffffc02018fa:	00f5f4b3          	and	s1,a1,a5
ffffffffc02018fe:	f04a                	sd	s2,32(sp)
ffffffffc0201900:	ec4e                	sd	s3,24(sp)
ffffffffc0201902:	e852                	sd	s4,16(sp)
ffffffffc0201904:	e456                	sd	s5,8(sp)
ffffffffc0201906:	002005b7          	lui	a1,0x200
ffffffffc020190a:	00f67433          	and	s0,a2,a5
ffffffffc020190e:	06b4e363          	bltu	s1,a1,ffffffffc0201974 <mm_map+0x8c>
ffffffffc0201912:	0684f163          	bgeu	s1,s0,ffffffffc0201974 <mm_map+0x8c>
ffffffffc0201916:	4785                	li	a5,1
ffffffffc0201918:	07fe                	slli	a5,a5,0x1f
ffffffffc020191a:	0487ed63          	bltu	a5,s0,ffffffffc0201974 <mm_map+0x8c>
ffffffffc020191e:	89aa                	mv	s3,a0
ffffffffc0201920:	cd21                	beqz	a0,ffffffffc0201978 <mm_map+0x90>
ffffffffc0201922:	85a6                	mv	a1,s1
ffffffffc0201924:	8ab6                	mv	s5,a3
ffffffffc0201926:	8a3a                	mv	s4,a4
ffffffffc0201928:	e5fff0ef          	jal	ra,ffffffffc0201786 <find_vma>
ffffffffc020192c:	c501                	beqz	a0,ffffffffc0201934 <mm_map+0x4c>
ffffffffc020192e:	651c                	ld	a5,8(a0)
ffffffffc0201930:	0487e263          	bltu	a5,s0,ffffffffc0201974 <mm_map+0x8c>
ffffffffc0201934:	03000513          	li	a0,48
ffffffffc0201938:	738000ef          	jal	ra,ffffffffc0202070 <kmalloc>
ffffffffc020193c:	892a                	mv	s2,a0
ffffffffc020193e:	5571                	li	a0,-4
ffffffffc0201940:	02090163          	beqz	s2,ffffffffc0201962 <mm_map+0x7a>
ffffffffc0201944:	854e                	mv	a0,s3
ffffffffc0201946:	00993423          	sd	s1,8(s2)
ffffffffc020194a:	00893823          	sd	s0,16(s2)
ffffffffc020194e:	01592c23          	sw	s5,24(s2)
ffffffffc0201952:	85ca                	mv	a1,s2
ffffffffc0201954:	e73ff0ef          	jal	ra,ffffffffc02017c6 <insert_vma_struct>
ffffffffc0201958:	4501                	li	a0,0
ffffffffc020195a:	000a0463          	beqz	s4,ffffffffc0201962 <mm_map+0x7a>
ffffffffc020195e:	012a3023          	sd	s2,0(s4) # 1000 <kern_entry-0xffffffffc01ff000>
ffffffffc0201962:	70e2                	ld	ra,56(sp)
ffffffffc0201964:	7442                	ld	s0,48(sp)
ffffffffc0201966:	74a2                	ld	s1,40(sp)
ffffffffc0201968:	7902                	ld	s2,32(sp)
ffffffffc020196a:	69e2                	ld	s3,24(sp)
ffffffffc020196c:	6a42                	ld	s4,16(sp)
ffffffffc020196e:	6aa2                	ld	s5,8(sp)
ffffffffc0201970:	6121                	addi	sp,sp,64
ffffffffc0201972:	8082                	ret
ffffffffc0201974:	5575                	li	a0,-3
ffffffffc0201976:	b7f5                	j	ffffffffc0201962 <mm_map+0x7a>
ffffffffc0201978:	00007697          	auipc	a3,0x7
ffffffffc020197c:	1b868693          	addi	a3,a3,440 # ffffffffc0208b30 <commands+0x948>
ffffffffc0201980:	00007617          	auipc	a2,0x7
ffffffffc0201984:	c7860613          	addi	a2,a2,-904 # ffffffffc02085f8 <commands+0x410>
ffffffffc0201988:	0a700593          	li	a1,167
ffffffffc020198c:	00007517          	auipc	a0,0x7
ffffffffc0201990:	11c50513          	addi	a0,a0,284 # ffffffffc0208aa8 <commands+0x8c0>
ffffffffc0201994:	875fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201998 <dup_mmap>:
ffffffffc0201998:	7139                	addi	sp,sp,-64
ffffffffc020199a:	fc06                	sd	ra,56(sp)
ffffffffc020199c:	f822                	sd	s0,48(sp)
ffffffffc020199e:	f426                	sd	s1,40(sp)
ffffffffc02019a0:	f04a                	sd	s2,32(sp)
ffffffffc02019a2:	ec4e                	sd	s3,24(sp)
ffffffffc02019a4:	e852                	sd	s4,16(sp)
ffffffffc02019a6:	e456                	sd	s5,8(sp)
ffffffffc02019a8:	c52d                	beqz	a0,ffffffffc0201a12 <dup_mmap+0x7a>
ffffffffc02019aa:	892a                	mv	s2,a0
ffffffffc02019ac:	84ae                	mv	s1,a1
ffffffffc02019ae:	842e                	mv	s0,a1
ffffffffc02019b0:	e595                	bnez	a1,ffffffffc02019dc <dup_mmap+0x44>
ffffffffc02019b2:	a085                	j	ffffffffc0201a12 <dup_mmap+0x7a>
ffffffffc02019b4:	854a                	mv	a0,s2
ffffffffc02019b6:	0155b423          	sd	s5,8(a1) # 200008 <kern_entry-0xffffffffbffffff8>
ffffffffc02019ba:	0145b823          	sd	s4,16(a1)
ffffffffc02019be:	0135ac23          	sw	s3,24(a1)
ffffffffc02019c2:	e05ff0ef          	jal	ra,ffffffffc02017c6 <insert_vma_struct>
ffffffffc02019c6:	ff043683          	ld	a3,-16(s0) # ff0 <kern_entry-0xffffffffc01ff010>
ffffffffc02019ca:	fe843603          	ld	a2,-24(s0)
ffffffffc02019ce:	6c8c                	ld	a1,24(s1)
ffffffffc02019d0:	01893503          	ld	a0,24(s2)
ffffffffc02019d4:	4701                	li	a4,0
ffffffffc02019d6:	a7bff0ef          	jal	ra,ffffffffc0201450 <copy_range>
ffffffffc02019da:	e105                	bnez	a0,ffffffffc02019fa <dup_mmap+0x62>
ffffffffc02019dc:	6000                	ld	s0,0(s0)
ffffffffc02019de:	02848863          	beq	s1,s0,ffffffffc0201a0e <dup_mmap+0x76>
ffffffffc02019e2:	03000513          	li	a0,48
ffffffffc02019e6:	fe843a83          	ld	s5,-24(s0)
ffffffffc02019ea:	ff043a03          	ld	s4,-16(s0)
ffffffffc02019ee:	ff842983          	lw	s3,-8(s0)
ffffffffc02019f2:	67e000ef          	jal	ra,ffffffffc0202070 <kmalloc>
ffffffffc02019f6:	85aa                	mv	a1,a0
ffffffffc02019f8:	fd55                	bnez	a0,ffffffffc02019b4 <dup_mmap+0x1c>
ffffffffc02019fa:	5571                	li	a0,-4
ffffffffc02019fc:	70e2                	ld	ra,56(sp)
ffffffffc02019fe:	7442                	ld	s0,48(sp)
ffffffffc0201a00:	74a2                	ld	s1,40(sp)
ffffffffc0201a02:	7902                	ld	s2,32(sp)
ffffffffc0201a04:	69e2                	ld	s3,24(sp)
ffffffffc0201a06:	6a42                	ld	s4,16(sp)
ffffffffc0201a08:	6aa2                	ld	s5,8(sp)
ffffffffc0201a0a:	6121                	addi	sp,sp,64
ffffffffc0201a0c:	8082                	ret
ffffffffc0201a0e:	4501                	li	a0,0
ffffffffc0201a10:	b7f5                	j	ffffffffc02019fc <dup_mmap+0x64>
ffffffffc0201a12:	00007697          	auipc	a3,0x7
ffffffffc0201a16:	12e68693          	addi	a3,a3,302 # ffffffffc0208b40 <commands+0x958>
ffffffffc0201a1a:	00007617          	auipc	a2,0x7
ffffffffc0201a1e:	bde60613          	addi	a2,a2,-1058 # ffffffffc02085f8 <commands+0x410>
ffffffffc0201a22:	0c000593          	li	a1,192
ffffffffc0201a26:	00007517          	auipc	a0,0x7
ffffffffc0201a2a:	08250513          	addi	a0,a0,130 # ffffffffc0208aa8 <commands+0x8c0>
ffffffffc0201a2e:	fdafe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201a32 <exit_mmap>:
ffffffffc0201a32:	1101                	addi	sp,sp,-32
ffffffffc0201a34:	ec06                	sd	ra,24(sp)
ffffffffc0201a36:	e822                	sd	s0,16(sp)
ffffffffc0201a38:	e426                	sd	s1,8(sp)
ffffffffc0201a3a:	e04a                	sd	s2,0(sp)
ffffffffc0201a3c:	c531                	beqz	a0,ffffffffc0201a88 <exit_mmap+0x56>
ffffffffc0201a3e:	591c                	lw	a5,48(a0)
ffffffffc0201a40:	84aa                	mv	s1,a0
ffffffffc0201a42:	e3b9                	bnez	a5,ffffffffc0201a88 <exit_mmap+0x56>
ffffffffc0201a44:	6500                	ld	s0,8(a0)
ffffffffc0201a46:	01853903          	ld	s2,24(a0)
ffffffffc0201a4a:	02850663          	beq	a0,s0,ffffffffc0201a76 <exit_mmap+0x44>
ffffffffc0201a4e:	ff043603          	ld	a2,-16(s0)
ffffffffc0201a52:	fe843583          	ld	a1,-24(s0)
ffffffffc0201a56:	854a                	mv	a0,s2
ffffffffc0201a58:	f28ff0ef          	jal	ra,ffffffffc0201180 <unmap_range>
ffffffffc0201a5c:	6400                	ld	s0,8(s0)
ffffffffc0201a5e:	fe8498e3          	bne	s1,s0,ffffffffc0201a4e <exit_mmap+0x1c>
ffffffffc0201a62:	6400                	ld	s0,8(s0)
ffffffffc0201a64:	00848c63          	beq	s1,s0,ffffffffc0201a7c <exit_mmap+0x4a>
ffffffffc0201a68:	ff043603          	ld	a2,-16(s0)
ffffffffc0201a6c:	fe843583          	ld	a1,-24(s0)
ffffffffc0201a70:	854a                	mv	a0,s2
ffffffffc0201a72:	825ff0ef          	jal	ra,ffffffffc0201296 <exit_range>
ffffffffc0201a76:	6400                	ld	s0,8(s0)
ffffffffc0201a78:	fe8498e3          	bne	s1,s0,ffffffffc0201a68 <exit_mmap+0x36>
ffffffffc0201a7c:	60e2                	ld	ra,24(sp)
ffffffffc0201a7e:	6442                	ld	s0,16(sp)
ffffffffc0201a80:	64a2                	ld	s1,8(sp)
ffffffffc0201a82:	6902                	ld	s2,0(sp)
ffffffffc0201a84:	6105                	addi	sp,sp,32
ffffffffc0201a86:	8082                	ret
ffffffffc0201a88:	00007697          	auipc	a3,0x7
ffffffffc0201a8c:	0d868693          	addi	a3,a3,216 # ffffffffc0208b60 <commands+0x978>
ffffffffc0201a90:	00007617          	auipc	a2,0x7
ffffffffc0201a94:	b6860613          	addi	a2,a2,-1176 # ffffffffc02085f8 <commands+0x410>
ffffffffc0201a98:	0d600593          	li	a1,214
ffffffffc0201a9c:	00007517          	auipc	a0,0x7
ffffffffc0201aa0:	00c50513          	addi	a0,a0,12 # ffffffffc0208aa8 <commands+0x8c0>
ffffffffc0201aa4:	f64fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201aa8 <vmm_init>:
ffffffffc0201aa8:	8082                	ret

ffffffffc0201aaa <do_pgfault>:
ffffffffc0201aaa:	7139                	addi	sp,sp,-64
ffffffffc0201aac:	85b2                	mv	a1,a2
ffffffffc0201aae:	f822                	sd	s0,48(sp)
ffffffffc0201ab0:	f426                	sd	s1,40(sp)
ffffffffc0201ab2:	fc06                	sd	ra,56(sp)
ffffffffc0201ab4:	f04a                	sd	s2,32(sp)
ffffffffc0201ab6:	ec4e                	sd	s3,24(sp)
ffffffffc0201ab8:	8432                	mv	s0,a2
ffffffffc0201aba:	84aa                	mv	s1,a0
ffffffffc0201abc:	ccbff0ef          	jal	ra,ffffffffc0201786 <find_vma>
ffffffffc0201ac0:	00018797          	auipc	a5,0x18
ffffffffc0201ac4:	a187a783          	lw	a5,-1512(a5) # ffffffffc02194d8 <pgfault_num>
ffffffffc0201ac8:	2785                	addiw	a5,a5,1
ffffffffc0201aca:	00018717          	auipc	a4,0x18
ffffffffc0201ace:	a0f72723          	sw	a5,-1522(a4) # ffffffffc02194d8 <pgfault_num>
ffffffffc0201ad2:	c545                	beqz	a0,ffffffffc0201b7a <do_pgfault+0xd0>
ffffffffc0201ad4:	651c                	ld	a5,8(a0)
ffffffffc0201ad6:	0af46263          	bltu	s0,a5,ffffffffc0201b7a <do_pgfault+0xd0>
ffffffffc0201ada:	4d1c                	lw	a5,24(a0)
ffffffffc0201adc:	49c1                	li	s3,16
ffffffffc0201ade:	8b89                	andi	a5,a5,2
ffffffffc0201ae0:	efb1                	bnez	a5,ffffffffc0201b3c <do_pgfault+0x92>
ffffffffc0201ae2:	75fd                	lui	a1,0xfffff
ffffffffc0201ae4:	6c88                	ld	a0,24(s1)
ffffffffc0201ae6:	8c6d                	and	s0,s0,a1
ffffffffc0201ae8:	4605                	li	a2,1
ffffffffc0201aea:	85a2                	mv	a1,s0
ffffffffc0201aec:	cc2ff0ef          	jal	ra,ffffffffc0200fae <get_pte>
ffffffffc0201af0:	c555                	beqz	a0,ffffffffc0201b9c <do_pgfault+0xf2>
ffffffffc0201af2:	610c                	ld	a1,0(a0)
ffffffffc0201af4:	c5a5                	beqz	a1,ffffffffc0201b5c <do_pgfault+0xb2>
ffffffffc0201af6:	00018797          	auipc	a5,0x18
ffffffffc0201afa:	9f27a783          	lw	a5,-1550(a5) # ffffffffc02194e8 <swap_init_ok>
ffffffffc0201afe:	c7d9                	beqz	a5,ffffffffc0201b8c <do_pgfault+0xe2>
ffffffffc0201b00:	0030                	addi	a2,sp,8
ffffffffc0201b02:	85a2                	mv	a1,s0
ffffffffc0201b04:	8526                	mv	a0,s1
ffffffffc0201b06:	e402                	sd	zero,8(sp)
ffffffffc0201b08:	2ee000ef          	jal	ra,ffffffffc0201df6 <swap_in>
ffffffffc0201b0c:	892a                	mv	s2,a0
ffffffffc0201b0e:	e90d                	bnez	a0,ffffffffc0201b40 <do_pgfault+0x96>
ffffffffc0201b10:	65a2                	ld	a1,8(sp)
ffffffffc0201b12:	6c88                	ld	a0,24(s1)
ffffffffc0201b14:	86ce                	mv	a3,s3
ffffffffc0201b16:	8622                	mv	a2,s0
ffffffffc0201b18:	87dff0ef          	jal	ra,ffffffffc0201394 <page_insert>
ffffffffc0201b1c:	6622                	ld	a2,8(sp)
ffffffffc0201b1e:	4685                	li	a3,1
ffffffffc0201b20:	85a2                	mv	a1,s0
ffffffffc0201b22:	8526                	mv	a0,s1
ffffffffc0201b24:	1b0000ef          	jal	ra,ffffffffc0201cd4 <swap_map_swappable>
ffffffffc0201b28:	67a2                	ld	a5,8(sp)
ffffffffc0201b2a:	ff80                	sd	s0,56(a5)
ffffffffc0201b2c:	70e2                	ld	ra,56(sp)
ffffffffc0201b2e:	7442                	ld	s0,48(sp)
ffffffffc0201b30:	74a2                	ld	s1,40(sp)
ffffffffc0201b32:	69e2                	ld	s3,24(sp)
ffffffffc0201b34:	854a                	mv	a0,s2
ffffffffc0201b36:	7902                	ld	s2,32(sp)
ffffffffc0201b38:	6121                	addi	sp,sp,64
ffffffffc0201b3a:	8082                	ret
ffffffffc0201b3c:	49dd                	li	s3,23
ffffffffc0201b3e:	b755                	j	ffffffffc0201ae2 <do_pgfault+0x38>
ffffffffc0201b40:	00007517          	auipc	a0,0x7
ffffffffc0201b44:	0b850513          	addi	a0,a0,184 # ffffffffc0208bf8 <commands+0xa10>
ffffffffc0201b48:	d84fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201b4c:	70e2                	ld	ra,56(sp)
ffffffffc0201b4e:	7442                	ld	s0,48(sp)
ffffffffc0201b50:	74a2                	ld	s1,40(sp)
ffffffffc0201b52:	69e2                	ld	s3,24(sp)
ffffffffc0201b54:	854a                	mv	a0,s2
ffffffffc0201b56:	7902                	ld	s2,32(sp)
ffffffffc0201b58:	6121                	addi	sp,sp,64
ffffffffc0201b5a:	8082                	ret
ffffffffc0201b5c:	6c88                	ld	a0,24(s1)
ffffffffc0201b5e:	864e                	mv	a2,s3
ffffffffc0201b60:	85a2                	mv	a1,s0
ffffffffc0201b62:	b25ff0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc0201b66:	4901                	li	s2,0
ffffffffc0201b68:	f171                	bnez	a0,ffffffffc0201b2c <do_pgfault+0x82>
ffffffffc0201b6a:	00007517          	auipc	a0,0x7
ffffffffc0201b6e:	06650513          	addi	a0,a0,102 # ffffffffc0208bd0 <commands+0x9e8>
ffffffffc0201b72:	d5afe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201b76:	5971                	li	s2,-4
ffffffffc0201b78:	bf55                	j	ffffffffc0201b2c <do_pgfault+0x82>
ffffffffc0201b7a:	85a2                	mv	a1,s0
ffffffffc0201b7c:	00007517          	auipc	a0,0x7
ffffffffc0201b80:	00450513          	addi	a0,a0,4 # ffffffffc0208b80 <commands+0x998>
ffffffffc0201b84:	d48fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201b88:	5975                	li	s2,-3
ffffffffc0201b8a:	b74d                	j	ffffffffc0201b2c <do_pgfault+0x82>
ffffffffc0201b8c:	00007517          	auipc	a0,0x7
ffffffffc0201b90:	08c50513          	addi	a0,a0,140 # ffffffffc0208c18 <commands+0xa30>
ffffffffc0201b94:	d38fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201b98:	5971                	li	s2,-4
ffffffffc0201b9a:	bf49                	j	ffffffffc0201b2c <do_pgfault+0x82>
ffffffffc0201b9c:	00007517          	auipc	a0,0x7
ffffffffc0201ba0:	01450513          	addi	a0,a0,20 # ffffffffc0208bb0 <commands+0x9c8>
ffffffffc0201ba4:	d28fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201ba8:	5971                	li	s2,-4
ffffffffc0201baa:	b749                	j	ffffffffc0201b2c <do_pgfault+0x82>

ffffffffc0201bac <user_mem_check>:
ffffffffc0201bac:	7179                	addi	sp,sp,-48
ffffffffc0201bae:	f022                	sd	s0,32(sp)
ffffffffc0201bb0:	f406                	sd	ra,40(sp)
ffffffffc0201bb2:	ec26                	sd	s1,24(sp)
ffffffffc0201bb4:	e84a                	sd	s2,16(sp)
ffffffffc0201bb6:	e44e                	sd	s3,8(sp)
ffffffffc0201bb8:	e052                	sd	s4,0(sp)
ffffffffc0201bba:	842e                	mv	s0,a1
ffffffffc0201bbc:	c135                	beqz	a0,ffffffffc0201c20 <user_mem_check+0x74>
ffffffffc0201bbe:	002007b7          	lui	a5,0x200
ffffffffc0201bc2:	04f5e663          	bltu	a1,a5,ffffffffc0201c0e <user_mem_check+0x62>
ffffffffc0201bc6:	00c584b3          	add	s1,a1,a2
ffffffffc0201bca:	0495f263          	bgeu	a1,s1,ffffffffc0201c0e <user_mem_check+0x62>
ffffffffc0201bce:	4785                	li	a5,1
ffffffffc0201bd0:	07fe                	slli	a5,a5,0x1f
ffffffffc0201bd2:	0297ee63          	bltu	a5,s1,ffffffffc0201c0e <user_mem_check+0x62>
ffffffffc0201bd6:	892a                	mv	s2,a0
ffffffffc0201bd8:	89b6                	mv	s3,a3
ffffffffc0201bda:	6a05                	lui	s4,0x1
ffffffffc0201bdc:	a821                	j	ffffffffc0201bf4 <user_mem_check+0x48>
ffffffffc0201bde:	0027f693          	andi	a3,a5,2
ffffffffc0201be2:	9752                	add	a4,a4,s4
ffffffffc0201be4:	8ba1                	andi	a5,a5,8
ffffffffc0201be6:	c685                	beqz	a3,ffffffffc0201c0e <user_mem_check+0x62>
ffffffffc0201be8:	c399                	beqz	a5,ffffffffc0201bee <user_mem_check+0x42>
ffffffffc0201bea:	02e46263          	bltu	s0,a4,ffffffffc0201c0e <user_mem_check+0x62>
ffffffffc0201bee:	6900                	ld	s0,16(a0)
ffffffffc0201bf0:	04947663          	bgeu	s0,s1,ffffffffc0201c3c <user_mem_check+0x90>
ffffffffc0201bf4:	85a2                	mv	a1,s0
ffffffffc0201bf6:	854a                	mv	a0,s2
ffffffffc0201bf8:	b8fff0ef          	jal	ra,ffffffffc0201786 <find_vma>
ffffffffc0201bfc:	c909                	beqz	a0,ffffffffc0201c0e <user_mem_check+0x62>
ffffffffc0201bfe:	6518                	ld	a4,8(a0)
ffffffffc0201c00:	00e46763          	bltu	s0,a4,ffffffffc0201c0e <user_mem_check+0x62>
ffffffffc0201c04:	4d1c                	lw	a5,24(a0)
ffffffffc0201c06:	fc099ce3          	bnez	s3,ffffffffc0201bde <user_mem_check+0x32>
ffffffffc0201c0a:	8b85                	andi	a5,a5,1
ffffffffc0201c0c:	f3ed                	bnez	a5,ffffffffc0201bee <user_mem_check+0x42>
ffffffffc0201c0e:	4501                	li	a0,0
ffffffffc0201c10:	70a2                	ld	ra,40(sp)
ffffffffc0201c12:	7402                	ld	s0,32(sp)
ffffffffc0201c14:	64e2                	ld	s1,24(sp)
ffffffffc0201c16:	6942                	ld	s2,16(sp)
ffffffffc0201c18:	69a2                	ld	s3,8(sp)
ffffffffc0201c1a:	6a02                	ld	s4,0(sp)
ffffffffc0201c1c:	6145                	addi	sp,sp,48
ffffffffc0201c1e:	8082                	ret
ffffffffc0201c20:	c02007b7          	lui	a5,0xc0200
ffffffffc0201c24:	4501                	li	a0,0
ffffffffc0201c26:	fef5e5e3          	bltu	a1,a5,ffffffffc0201c10 <user_mem_check+0x64>
ffffffffc0201c2a:	962e                	add	a2,a2,a1
ffffffffc0201c2c:	fec5f2e3          	bgeu	a1,a2,ffffffffc0201c10 <user_mem_check+0x64>
ffffffffc0201c30:	c8000537          	lui	a0,0xc8000
ffffffffc0201c34:	0505                	addi	a0,a0,1
ffffffffc0201c36:	00a63533          	sltu	a0,a2,a0
ffffffffc0201c3a:	bfd9                	j	ffffffffc0201c10 <user_mem_check+0x64>
ffffffffc0201c3c:	4505                	li	a0,1
ffffffffc0201c3e:	bfc9                	j	ffffffffc0201c10 <user_mem_check+0x64>

ffffffffc0201c40 <swap_init>:
ffffffffc0201c40:	1101                	addi	sp,sp,-32
ffffffffc0201c42:	ec06                	sd	ra,24(sp)
ffffffffc0201c44:	e822                	sd	s0,16(sp)
ffffffffc0201c46:	e426                	sd	s1,8(sp)
ffffffffc0201c48:	0f7010ef          	jal	ra,ffffffffc020353e <swapfs_init>
ffffffffc0201c4c:	00018697          	auipc	a3,0x18
ffffffffc0201c50:	9946b683          	ld	a3,-1644(a3) # ffffffffc02195e0 <max_swap_offset>
ffffffffc0201c54:	010007b7          	lui	a5,0x1000
ffffffffc0201c58:	ff968713          	addi	a4,a3,-7
ffffffffc0201c5c:	17e1                	addi	a5,a5,-8
ffffffffc0201c5e:	04e7e863          	bltu	a5,a4,ffffffffc0201cae <swap_init+0x6e>
ffffffffc0201c62:	0000c797          	auipc	a5,0xc
ffffffffc0201c66:	3ae78793          	addi	a5,a5,942 # ffffffffc020e010 <swap_manager_fifo>
ffffffffc0201c6a:	6798                	ld	a4,8(a5)
ffffffffc0201c6c:	00018497          	auipc	s1,0x18
ffffffffc0201c70:	87448493          	addi	s1,s1,-1932 # ffffffffc02194e0 <sm>
ffffffffc0201c74:	e09c                	sd	a5,0(s1)
ffffffffc0201c76:	9702                	jalr	a4
ffffffffc0201c78:	842a                	mv	s0,a0
ffffffffc0201c7a:	c519                	beqz	a0,ffffffffc0201c88 <swap_init+0x48>
ffffffffc0201c7c:	60e2                	ld	ra,24(sp)
ffffffffc0201c7e:	8522                	mv	a0,s0
ffffffffc0201c80:	6442                	ld	s0,16(sp)
ffffffffc0201c82:	64a2                	ld	s1,8(sp)
ffffffffc0201c84:	6105                	addi	sp,sp,32
ffffffffc0201c86:	8082                	ret
ffffffffc0201c88:	609c                	ld	a5,0(s1)
ffffffffc0201c8a:	00007517          	auipc	a0,0x7
ffffffffc0201c8e:	fe650513          	addi	a0,a0,-26 # ffffffffc0208c70 <commands+0xa88>
ffffffffc0201c92:	638c                	ld	a1,0(a5)
ffffffffc0201c94:	4785                	li	a5,1
ffffffffc0201c96:	00018717          	auipc	a4,0x18
ffffffffc0201c9a:	84f72923          	sw	a5,-1966(a4) # ffffffffc02194e8 <swap_init_ok>
ffffffffc0201c9e:	c2efe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201ca2:	60e2                	ld	ra,24(sp)
ffffffffc0201ca4:	8522                	mv	a0,s0
ffffffffc0201ca6:	6442                	ld	s0,16(sp)
ffffffffc0201ca8:	64a2                	ld	s1,8(sp)
ffffffffc0201caa:	6105                	addi	sp,sp,32
ffffffffc0201cac:	8082                	ret
ffffffffc0201cae:	00007617          	auipc	a2,0x7
ffffffffc0201cb2:	f9260613          	addi	a2,a2,-110 # ffffffffc0208c40 <commands+0xa58>
ffffffffc0201cb6:	02800593          	li	a1,40
ffffffffc0201cba:	00007517          	auipc	a0,0x7
ffffffffc0201cbe:	fa650513          	addi	a0,a0,-90 # ffffffffc0208c60 <commands+0xa78>
ffffffffc0201cc2:	d46fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201cc6 <swap_init_mm>:
ffffffffc0201cc6:	00018797          	auipc	a5,0x18
ffffffffc0201cca:	81a7b783          	ld	a5,-2022(a5) # ffffffffc02194e0 <sm>
ffffffffc0201cce:	0107b303          	ld	t1,16(a5)
ffffffffc0201cd2:	8302                	jr	t1

ffffffffc0201cd4 <swap_map_swappable>:
ffffffffc0201cd4:	00018797          	auipc	a5,0x18
ffffffffc0201cd8:	80c7b783          	ld	a5,-2036(a5) # ffffffffc02194e0 <sm>
ffffffffc0201cdc:	0207b303          	ld	t1,32(a5)
ffffffffc0201ce0:	8302                	jr	t1

ffffffffc0201ce2 <swap_out>:
ffffffffc0201ce2:	711d                	addi	sp,sp,-96
ffffffffc0201ce4:	ec86                	sd	ra,88(sp)
ffffffffc0201ce6:	e8a2                	sd	s0,80(sp)
ffffffffc0201ce8:	e4a6                	sd	s1,72(sp)
ffffffffc0201cea:	e0ca                	sd	s2,64(sp)
ffffffffc0201cec:	fc4e                	sd	s3,56(sp)
ffffffffc0201cee:	f852                	sd	s4,48(sp)
ffffffffc0201cf0:	f456                	sd	s5,40(sp)
ffffffffc0201cf2:	f05a                	sd	s6,32(sp)
ffffffffc0201cf4:	ec5e                	sd	s7,24(sp)
ffffffffc0201cf6:	e862                	sd	s8,16(sp)
ffffffffc0201cf8:	cde9                	beqz	a1,ffffffffc0201dd2 <swap_out+0xf0>
ffffffffc0201cfa:	8a2e                	mv	s4,a1
ffffffffc0201cfc:	892a                	mv	s2,a0
ffffffffc0201cfe:	8ab2                	mv	s5,a2
ffffffffc0201d00:	4401                	li	s0,0
ffffffffc0201d02:	00017997          	auipc	s3,0x17
ffffffffc0201d06:	7de98993          	addi	s3,s3,2014 # ffffffffc02194e0 <sm>
ffffffffc0201d0a:	00007b17          	auipc	s6,0x7
ffffffffc0201d0e:	fdeb0b13          	addi	s6,s6,-34 # ffffffffc0208ce8 <commands+0xb00>
ffffffffc0201d12:	00007b97          	auipc	s7,0x7
ffffffffc0201d16:	fbeb8b93          	addi	s7,s7,-66 # ffffffffc0208cd0 <commands+0xae8>
ffffffffc0201d1a:	a825                	j	ffffffffc0201d52 <swap_out+0x70>
ffffffffc0201d1c:	67a2                	ld	a5,8(sp)
ffffffffc0201d1e:	8626                	mv	a2,s1
ffffffffc0201d20:	85a2                	mv	a1,s0
ffffffffc0201d22:	7f94                	ld	a3,56(a5)
ffffffffc0201d24:	855a                	mv	a0,s6
ffffffffc0201d26:	2405                	addiw	s0,s0,1
ffffffffc0201d28:	82b1                	srli	a3,a3,0xc
ffffffffc0201d2a:	0685                	addi	a3,a3,1
ffffffffc0201d2c:	ba0fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201d30:	6522                	ld	a0,8(sp)
ffffffffc0201d32:	4585                	li	a1,1
ffffffffc0201d34:	7d1c                	ld	a5,56(a0)
ffffffffc0201d36:	83b1                	srli	a5,a5,0xc
ffffffffc0201d38:	0785                	addi	a5,a5,1
ffffffffc0201d3a:	07a2                	slli	a5,a5,0x8
ffffffffc0201d3c:	00fc3023          	sd	a5,0(s8)
ffffffffc0201d40:	89cff0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0201d44:	01893503          	ld	a0,24(s2)
ffffffffc0201d48:	85a6                	mv	a1,s1
ffffffffc0201d4a:	937ff0ef          	jal	ra,ffffffffc0201680 <tlb_invalidate>
ffffffffc0201d4e:	048a0d63          	beq	s4,s0,ffffffffc0201da8 <swap_out+0xc6>
ffffffffc0201d52:	0009b783          	ld	a5,0(s3)
ffffffffc0201d56:	8656                	mv	a2,s5
ffffffffc0201d58:	002c                	addi	a1,sp,8
ffffffffc0201d5a:	7b9c                	ld	a5,48(a5)
ffffffffc0201d5c:	854a                	mv	a0,s2
ffffffffc0201d5e:	9782                	jalr	a5
ffffffffc0201d60:	e12d                	bnez	a0,ffffffffc0201dc2 <swap_out+0xe0>
ffffffffc0201d62:	67a2                	ld	a5,8(sp)
ffffffffc0201d64:	01893503          	ld	a0,24(s2)
ffffffffc0201d68:	4601                	li	a2,0
ffffffffc0201d6a:	7f84                	ld	s1,56(a5)
ffffffffc0201d6c:	85a6                	mv	a1,s1
ffffffffc0201d6e:	a40ff0ef          	jal	ra,ffffffffc0200fae <get_pte>
ffffffffc0201d72:	611c                	ld	a5,0(a0)
ffffffffc0201d74:	8c2a                	mv	s8,a0
ffffffffc0201d76:	8b85                	andi	a5,a5,1
ffffffffc0201d78:	cfb9                	beqz	a5,ffffffffc0201dd6 <swap_out+0xf4>
ffffffffc0201d7a:	65a2                	ld	a1,8(sp)
ffffffffc0201d7c:	7d9c                	ld	a5,56(a1)
ffffffffc0201d7e:	83b1                	srli	a5,a5,0xc
ffffffffc0201d80:	0785                	addi	a5,a5,1
ffffffffc0201d82:	00879513          	slli	a0,a5,0x8
ffffffffc0201d86:	07f010ef          	jal	ra,ffffffffc0203604 <swapfs_write>
ffffffffc0201d8a:	d949                	beqz	a0,ffffffffc0201d1c <swap_out+0x3a>
ffffffffc0201d8c:	855e                	mv	a0,s7
ffffffffc0201d8e:	b3efe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201d92:	0009b783          	ld	a5,0(s3)
ffffffffc0201d96:	6622                	ld	a2,8(sp)
ffffffffc0201d98:	4681                	li	a3,0
ffffffffc0201d9a:	739c                	ld	a5,32(a5)
ffffffffc0201d9c:	85a6                	mv	a1,s1
ffffffffc0201d9e:	854a                	mv	a0,s2
ffffffffc0201da0:	2405                	addiw	s0,s0,1
ffffffffc0201da2:	9782                	jalr	a5
ffffffffc0201da4:	fa8a17e3          	bne	s4,s0,ffffffffc0201d52 <swap_out+0x70>
ffffffffc0201da8:	60e6                	ld	ra,88(sp)
ffffffffc0201daa:	8522                	mv	a0,s0
ffffffffc0201dac:	6446                	ld	s0,80(sp)
ffffffffc0201dae:	64a6                	ld	s1,72(sp)
ffffffffc0201db0:	6906                	ld	s2,64(sp)
ffffffffc0201db2:	79e2                	ld	s3,56(sp)
ffffffffc0201db4:	7a42                	ld	s4,48(sp)
ffffffffc0201db6:	7aa2                	ld	s5,40(sp)
ffffffffc0201db8:	7b02                	ld	s6,32(sp)
ffffffffc0201dba:	6be2                	ld	s7,24(sp)
ffffffffc0201dbc:	6c42                	ld	s8,16(sp)
ffffffffc0201dbe:	6125                	addi	sp,sp,96
ffffffffc0201dc0:	8082                	ret
ffffffffc0201dc2:	85a2                	mv	a1,s0
ffffffffc0201dc4:	00007517          	auipc	a0,0x7
ffffffffc0201dc8:	ec450513          	addi	a0,a0,-316 # ffffffffc0208c88 <commands+0xaa0>
ffffffffc0201dcc:	b00fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201dd0:	bfe1                	j	ffffffffc0201da8 <swap_out+0xc6>
ffffffffc0201dd2:	4401                	li	s0,0
ffffffffc0201dd4:	bfd1                	j	ffffffffc0201da8 <swap_out+0xc6>
ffffffffc0201dd6:	00007697          	auipc	a3,0x7
ffffffffc0201dda:	ee268693          	addi	a3,a3,-286 # ffffffffc0208cb8 <commands+0xad0>
ffffffffc0201dde:	00007617          	auipc	a2,0x7
ffffffffc0201de2:	81a60613          	addi	a2,a2,-2022 # ffffffffc02085f8 <commands+0x410>
ffffffffc0201de6:	06800593          	li	a1,104
ffffffffc0201dea:	00007517          	auipc	a0,0x7
ffffffffc0201dee:	e7650513          	addi	a0,a0,-394 # ffffffffc0208c60 <commands+0xa78>
ffffffffc0201df2:	c16fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201df6 <swap_in>:
ffffffffc0201df6:	7179                	addi	sp,sp,-48
ffffffffc0201df8:	e84a                	sd	s2,16(sp)
ffffffffc0201dfa:	892a                	mv	s2,a0
ffffffffc0201dfc:	4505                	li	a0,1
ffffffffc0201dfe:	ec26                	sd	s1,24(sp)
ffffffffc0201e00:	e44e                	sd	s3,8(sp)
ffffffffc0201e02:	f406                	sd	ra,40(sp)
ffffffffc0201e04:	f022                	sd	s0,32(sp)
ffffffffc0201e06:	84ae                	mv	s1,a1
ffffffffc0201e08:	89b2                	mv	s3,a2
ffffffffc0201e0a:	f41fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0201e0e:	c129                	beqz	a0,ffffffffc0201e50 <swap_in+0x5a>
ffffffffc0201e10:	842a                	mv	s0,a0
ffffffffc0201e12:	01893503          	ld	a0,24(s2)
ffffffffc0201e16:	4601                	li	a2,0
ffffffffc0201e18:	85a6                	mv	a1,s1
ffffffffc0201e1a:	994ff0ef          	jal	ra,ffffffffc0200fae <get_pte>
ffffffffc0201e1e:	892a                	mv	s2,a0
ffffffffc0201e20:	6108                	ld	a0,0(a0)
ffffffffc0201e22:	85a2                	mv	a1,s0
ffffffffc0201e24:	752010ef          	jal	ra,ffffffffc0203576 <swapfs_read>
ffffffffc0201e28:	00093583          	ld	a1,0(s2)
ffffffffc0201e2c:	8626                	mv	a2,s1
ffffffffc0201e2e:	00007517          	auipc	a0,0x7
ffffffffc0201e32:	f0a50513          	addi	a0,a0,-246 # ffffffffc0208d38 <commands+0xb50>
ffffffffc0201e36:	81a1                	srli	a1,a1,0x8
ffffffffc0201e38:	a94fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201e3c:	70a2                	ld	ra,40(sp)
ffffffffc0201e3e:	0089b023          	sd	s0,0(s3)
ffffffffc0201e42:	7402                	ld	s0,32(sp)
ffffffffc0201e44:	64e2                	ld	s1,24(sp)
ffffffffc0201e46:	6942                	ld	s2,16(sp)
ffffffffc0201e48:	69a2                	ld	s3,8(sp)
ffffffffc0201e4a:	4501                	li	a0,0
ffffffffc0201e4c:	6145                	addi	sp,sp,48
ffffffffc0201e4e:	8082                	ret
ffffffffc0201e50:	00007697          	auipc	a3,0x7
ffffffffc0201e54:	ed868693          	addi	a3,a3,-296 # ffffffffc0208d28 <commands+0xb40>
ffffffffc0201e58:	00006617          	auipc	a2,0x6
ffffffffc0201e5c:	7a060613          	addi	a2,a2,1952 # ffffffffc02085f8 <commands+0x410>
ffffffffc0201e60:	07e00593          	li	a1,126
ffffffffc0201e64:	00007517          	auipc	a0,0x7
ffffffffc0201e68:	dfc50513          	addi	a0,a0,-516 # ffffffffc0208c60 <commands+0xa78>
ffffffffc0201e6c:	b9cfe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201e70 <slob_free>:
ffffffffc0201e70:	c145                	beqz	a0,ffffffffc0201f10 <slob_free+0xa0>
ffffffffc0201e72:	1141                	addi	sp,sp,-16
ffffffffc0201e74:	e022                	sd	s0,0(sp)
ffffffffc0201e76:	e406                	sd	ra,8(sp)
ffffffffc0201e78:	842a                	mv	s0,a0
ffffffffc0201e7a:	edb1                	bnez	a1,ffffffffc0201ed6 <slob_free+0x66>
ffffffffc0201e7c:	100027f3          	csrr	a5,sstatus
ffffffffc0201e80:	8b89                	andi	a5,a5,2
ffffffffc0201e82:	4501                	li	a0,0
ffffffffc0201e84:	e3ad                	bnez	a5,ffffffffc0201ee6 <slob_free+0x76>
ffffffffc0201e86:	0000c617          	auipc	a2,0xc
ffffffffc0201e8a:	1fa60613          	addi	a2,a2,506 # ffffffffc020e080 <slobfree>
ffffffffc0201e8e:	621c                	ld	a5,0(a2)
ffffffffc0201e90:	6798                	ld	a4,8(a5)
ffffffffc0201e92:	0087fa63          	bgeu	a5,s0,ffffffffc0201ea6 <slob_free+0x36>
ffffffffc0201e96:	00e46c63          	bltu	s0,a4,ffffffffc0201eae <slob_free+0x3e>
ffffffffc0201e9a:	00e7fa63          	bgeu	a5,a4,ffffffffc0201eae <slob_free+0x3e>
ffffffffc0201e9e:	87ba                	mv	a5,a4
ffffffffc0201ea0:	6798                	ld	a4,8(a5)
ffffffffc0201ea2:	fe87eae3          	bltu	a5,s0,ffffffffc0201e96 <slob_free+0x26>
ffffffffc0201ea6:	fee7ece3          	bltu	a5,a4,ffffffffc0201e9e <slob_free+0x2e>
ffffffffc0201eaa:	fee47ae3          	bgeu	s0,a4,ffffffffc0201e9e <slob_free+0x2e>
ffffffffc0201eae:	400c                	lw	a1,0(s0)
ffffffffc0201eb0:	00459693          	slli	a3,a1,0x4
ffffffffc0201eb4:	96a2                	add	a3,a3,s0
ffffffffc0201eb6:	04d70763          	beq	a4,a3,ffffffffc0201f04 <slob_free+0x94>
ffffffffc0201eba:	e418                	sd	a4,8(s0)
ffffffffc0201ebc:	4394                	lw	a3,0(a5)
ffffffffc0201ebe:	00469713          	slli	a4,a3,0x4
ffffffffc0201ec2:	973e                	add	a4,a4,a5
ffffffffc0201ec4:	02e40a63          	beq	s0,a4,ffffffffc0201ef8 <slob_free+0x88>
ffffffffc0201ec8:	e780                	sd	s0,8(a5)
ffffffffc0201eca:	e21c                	sd	a5,0(a2)
ffffffffc0201ecc:	e10d                	bnez	a0,ffffffffc0201eee <slob_free+0x7e>
ffffffffc0201ece:	60a2                	ld	ra,8(sp)
ffffffffc0201ed0:	6402                	ld	s0,0(sp)
ffffffffc0201ed2:	0141                	addi	sp,sp,16
ffffffffc0201ed4:	8082                	ret
ffffffffc0201ed6:	05bd                	addi	a1,a1,15
ffffffffc0201ed8:	8191                	srli	a1,a1,0x4
ffffffffc0201eda:	c10c                	sw	a1,0(a0)
ffffffffc0201edc:	100027f3          	csrr	a5,sstatus
ffffffffc0201ee0:	8b89                	andi	a5,a5,2
ffffffffc0201ee2:	4501                	li	a0,0
ffffffffc0201ee4:	d3cd                	beqz	a5,ffffffffc0201e86 <slob_free+0x16>
ffffffffc0201ee6:	f52fe0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0201eea:	4505                	li	a0,1
ffffffffc0201eec:	bf69                	j	ffffffffc0201e86 <slob_free+0x16>
ffffffffc0201eee:	6402                	ld	s0,0(sp)
ffffffffc0201ef0:	60a2                	ld	ra,8(sp)
ffffffffc0201ef2:	0141                	addi	sp,sp,16
ffffffffc0201ef4:	f3efe06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0201ef8:	4018                	lw	a4,0(s0)
ffffffffc0201efa:	640c                	ld	a1,8(s0)
ffffffffc0201efc:	9eb9                	addw	a3,a3,a4
ffffffffc0201efe:	c394                	sw	a3,0(a5)
ffffffffc0201f00:	e78c                	sd	a1,8(a5)
ffffffffc0201f02:	b7e1                	j	ffffffffc0201eca <slob_free+0x5a>
ffffffffc0201f04:	4314                	lw	a3,0(a4)
ffffffffc0201f06:	6718                	ld	a4,8(a4)
ffffffffc0201f08:	9db5                	addw	a1,a1,a3
ffffffffc0201f0a:	c00c                	sw	a1,0(s0)
ffffffffc0201f0c:	e418                	sd	a4,8(s0)
ffffffffc0201f0e:	b77d                	j	ffffffffc0201ebc <slob_free+0x4c>
ffffffffc0201f10:	8082                	ret

ffffffffc0201f12 <__slob_get_free_pages.isra.0>:
ffffffffc0201f12:	4785                	li	a5,1
ffffffffc0201f14:	1141                	addi	sp,sp,-16
ffffffffc0201f16:	00a7953b          	sllw	a0,a5,a0
ffffffffc0201f1a:	e406                	sd	ra,8(sp)
ffffffffc0201f1c:	e2ffe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0201f20:	c91d                	beqz	a0,ffffffffc0201f56 <__slob_get_free_pages.isra.0+0x44>
ffffffffc0201f22:	00017697          	auipc	a3,0x17
ffffffffc0201f26:	6266b683          	ld	a3,1574(a3) # ffffffffc0219548 <pages>
ffffffffc0201f2a:	8d15                	sub	a0,a0,a3
ffffffffc0201f2c:	8519                	srai	a0,a0,0x6
ffffffffc0201f2e:	00008697          	auipc	a3,0x8
ffffffffc0201f32:	66a6b683          	ld	a3,1642(a3) # ffffffffc020a598 <nbase>
ffffffffc0201f36:	9536                	add	a0,a0,a3
ffffffffc0201f38:	00c51793          	slli	a5,a0,0xc
ffffffffc0201f3c:	83b1                	srli	a5,a5,0xc
ffffffffc0201f3e:	00017717          	auipc	a4,0x17
ffffffffc0201f42:	59273703          	ld	a4,1426(a4) # ffffffffc02194d0 <npage>
ffffffffc0201f46:	0532                	slli	a0,a0,0xc
ffffffffc0201f48:	00e7fa63          	bgeu	a5,a4,ffffffffc0201f5c <__slob_get_free_pages.isra.0+0x4a>
ffffffffc0201f4c:	00017697          	auipc	a3,0x17
ffffffffc0201f50:	5ec6b683          	ld	a3,1516(a3) # ffffffffc0219538 <va_pa_offset>
ffffffffc0201f54:	9536                	add	a0,a0,a3
ffffffffc0201f56:	60a2                	ld	ra,8(sp)
ffffffffc0201f58:	0141                	addi	sp,sp,16
ffffffffc0201f5a:	8082                	ret
ffffffffc0201f5c:	86aa                	mv	a3,a0
ffffffffc0201f5e:	00007617          	auipc	a2,0x7
ffffffffc0201f62:	a4a60613          	addi	a2,a2,-1462 # ffffffffc02089a8 <commands+0x7c0>
ffffffffc0201f66:	06900593          	li	a1,105
ffffffffc0201f6a:	00007517          	auipc	a0,0x7
ffffffffc0201f6e:	99e50513          	addi	a0,a0,-1634 # ffffffffc0208908 <commands+0x720>
ffffffffc0201f72:	a96fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201f76 <slob_alloc.isra.0.constprop.0>:
ffffffffc0201f76:	1101                	addi	sp,sp,-32
ffffffffc0201f78:	ec06                	sd	ra,24(sp)
ffffffffc0201f7a:	e822                	sd	s0,16(sp)
ffffffffc0201f7c:	e426                	sd	s1,8(sp)
ffffffffc0201f7e:	e04a                	sd	s2,0(sp)
ffffffffc0201f80:	01050713          	addi	a4,a0,16
ffffffffc0201f84:	6785                	lui	a5,0x1
ffffffffc0201f86:	0cf77363          	bgeu	a4,a5,ffffffffc020204c <slob_alloc.isra.0.constprop.0+0xd6>
ffffffffc0201f8a:	00f50493          	addi	s1,a0,15
ffffffffc0201f8e:	8091                	srli	s1,s1,0x4
ffffffffc0201f90:	2481                	sext.w	s1,s1
ffffffffc0201f92:	10002673          	csrr	a2,sstatus
ffffffffc0201f96:	8a09                	andi	a2,a2,2
ffffffffc0201f98:	e25d                	bnez	a2,ffffffffc020203e <slob_alloc.isra.0.constprop.0+0xc8>
ffffffffc0201f9a:	0000c917          	auipc	s2,0xc
ffffffffc0201f9e:	0e690913          	addi	s2,s2,230 # ffffffffc020e080 <slobfree>
ffffffffc0201fa2:	00093683          	ld	a3,0(s2)
ffffffffc0201fa6:	669c                	ld	a5,8(a3)
ffffffffc0201fa8:	4398                	lw	a4,0(a5)
ffffffffc0201faa:	08975e63          	bge	a4,s1,ffffffffc0202046 <slob_alloc.isra.0.constprop.0+0xd0>
ffffffffc0201fae:	00d78b63          	beq	a5,a3,ffffffffc0201fc4 <slob_alloc.isra.0.constprop.0+0x4e>
ffffffffc0201fb2:	6780                	ld	s0,8(a5)
ffffffffc0201fb4:	4018                	lw	a4,0(s0)
ffffffffc0201fb6:	02975a63          	bge	a4,s1,ffffffffc0201fea <slob_alloc.isra.0.constprop.0+0x74>
ffffffffc0201fba:	00093683          	ld	a3,0(s2)
ffffffffc0201fbe:	87a2                	mv	a5,s0
ffffffffc0201fc0:	fed799e3          	bne	a5,a3,ffffffffc0201fb2 <slob_alloc.isra.0.constprop.0+0x3c>
ffffffffc0201fc4:	ee31                	bnez	a2,ffffffffc0202020 <slob_alloc.isra.0.constprop.0+0xaa>
ffffffffc0201fc6:	4501                	li	a0,0
ffffffffc0201fc8:	f4bff0ef          	jal	ra,ffffffffc0201f12 <__slob_get_free_pages.isra.0>
ffffffffc0201fcc:	842a                	mv	s0,a0
ffffffffc0201fce:	cd05                	beqz	a0,ffffffffc0202006 <slob_alloc.isra.0.constprop.0+0x90>
ffffffffc0201fd0:	6585                	lui	a1,0x1
ffffffffc0201fd2:	e9fff0ef          	jal	ra,ffffffffc0201e70 <slob_free>
ffffffffc0201fd6:	10002673          	csrr	a2,sstatus
ffffffffc0201fda:	8a09                	andi	a2,a2,2
ffffffffc0201fdc:	ee05                	bnez	a2,ffffffffc0202014 <slob_alloc.isra.0.constprop.0+0x9e>
ffffffffc0201fde:	00093783          	ld	a5,0(s2)
ffffffffc0201fe2:	6780                	ld	s0,8(a5)
ffffffffc0201fe4:	4018                	lw	a4,0(s0)
ffffffffc0201fe6:	fc974ae3          	blt	a4,s1,ffffffffc0201fba <slob_alloc.isra.0.constprop.0+0x44>
ffffffffc0201fea:	04e48763          	beq	s1,a4,ffffffffc0202038 <slob_alloc.isra.0.constprop.0+0xc2>
ffffffffc0201fee:	00449693          	slli	a3,s1,0x4
ffffffffc0201ff2:	96a2                	add	a3,a3,s0
ffffffffc0201ff4:	e794                	sd	a3,8(a5)
ffffffffc0201ff6:	640c                	ld	a1,8(s0)
ffffffffc0201ff8:	9f05                	subw	a4,a4,s1
ffffffffc0201ffa:	c298                	sw	a4,0(a3)
ffffffffc0201ffc:	e68c                	sd	a1,8(a3)
ffffffffc0201ffe:	c004                	sw	s1,0(s0)
ffffffffc0202000:	00f93023          	sd	a5,0(s2)
ffffffffc0202004:	e20d                	bnez	a2,ffffffffc0202026 <slob_alloc.isra.0.constprop.0+0xb0>
ffffffffc0202006:	60e2                	ld	ra,24(sp)
ffffffffc0202008:	8522                	mv	a0,s0
ffffffffc020200a:	6442                	ld	s0,16(sp)
ffffffffc020200c:	64a2                	ld	s1,8(sp)
ffffffffc020200e:	6902                	ld	s2,0(sp)
ffffffffc0202010:	6105                	addi	sp,sp,32
ffffffffc0202012:	8082                	ret
ffffffffc0202014:	e24fe0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0202018:	00093783          	ld	a5,0(s2)
ffffffffc020201c:	4605                	li	a2,1
ffffffffc020201e:	b7d1                	j	ffffffffc0201fe2 <slob_alloc.isra.0.constprop.0+0x6c>
ffffffffc0202020:	e12fe0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0202024:	b74d                	j	ffffffffc0201fc6 <slob_alloc.isra.0.constprop.0+0x50>
ffffffffc0202026:	e0cfe0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc020202a:	60e2                	ld	ra,24(sp)
ffffffffc020202c:	8522                	mv	a0,s0
ffffffffc020202e:	6442                	ld	s0,16(sp)
ffffffffc0202030:	64a2                	ld	s1,8(sp)
ffffffffc0202032:	6902                	ld	s2,0(sp)
ffffffffc0202034:	6105                	addi	sp,sp,32
ffffffffc0202036:	8082                	ret
ffffffffc0202038:	6418                	ld	a4,8(s0)
ffffffffc020203a:	e798                	sd	a4,8(a5)
ffffffffc020203c:	b7d1                	j	ffffffffc0202000 <slob_alloc.isra.0.constprop.0+0x8a>
ffffffffc020203e:	dfafe0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0202042:	4605                	li	a2,1
ffffffffc0202044:	bf99                	j	ffffffffc0201f9a <slob_alloc.isra.0.constprop.0+0x24>
ffffffffc0202046:	843e                	mv	s0,a5
ffffffffc0202048:	87b6                	mv	a5,a3
ffffffffc020204a:	b745                	j	ffffffffc0201fea <slob_alloc.isra.0.constprop.0+0x74>
ffffffffc020204c:	00007697          	auipc	a3,0x7
ffffffffc0202050:	d2c68693          	addi	a3,a3,-724 # ffffffffc0208d78 <commands+0xb90>
ffffffffc0202054:	00006617          	auipc	a2,0x6
ffffffffc0202058:	5a460613          	addi	a2,a2,1444 # ffffffffc02085f8 <commands+0x410>
ffffffffc020205c:	06400593          	li	a1,100
ffffffffc0202060:	00007517          	auipc	a0,0x7
ffffffffc0202064:	d3850513          	addi	a0,a0,-712 # ffffffffc0208d98 <commands+0xbb0>
ffffffffc0202068:	9a0fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020206c <kallocated>:
ffffffffc020206c:	4501                	li	a0,0
ffffffffc020206e:	8082                	ret

ffffffffc0202070 <kmalloc>:
ffffffffc0202070:	1101                	addi	sp,sp,-32
ffffffffc0202072:	e04a                	sd	s2,0(sp)
ffffffffc0202074:	6905                	lui	s2,0x1
ffffffffc0202076:	e822                	sd	s0,16(sp)
ffffffffc0202078:	ec06                	sd	ra,24(sp)
ffffffffc020207a:	e426                	sd	s1,8(sp)
ffffffffc020207c:	fef90793          	addi	a5,s2,-17 # fef <kern_entry-0xffffffffc01ff011>
ffffffffc0202080:	842a                	mv	s0,a0
ffffffffc0202082:	04a7f963          	bgeu	a5,a0,ffffffffc02020d4 <kmalloc+0x64>
ffffffffc0202086:	4561                	li	a0,24
ffffffffc0202088:	eefff0ef          	jal	ra,ffffffffc0201f76 <slob_alloc.isra.0.constprop.0>
ffffffffc020208c:	84aa                	mv	s1,a0
ffffffffc020208e:	c929                	beqz	a0,ffffffffc02020e0 <kmalloc+0x70>
ffffffffc0202090:	0004079b          	sext.w	a5,s0
ffffffffc0202094:	4501                	li	a0,0
ffffffffc0202096:	00f95763          	bge	s2,a5,ffffffffc02020a4 <kmalloc+0x34>
ffffffffc020209a:	6705                	lui	a4,0x1
ffffffffc020209c:	8785                	srai	a5,a5,0x1
ffffffffc020209e:	2505                	addiw	a0,a0,1
ffffffffc02020a0:	fef74ee3          	blt	a4,a5,ffffffffc020209c <kmalloc+0x2c>
ffffffffc02020a4:	c088                	sw	a0,0(s1)
ffffffffc02020a6:	e6dff0ef          	jal	ra,ffffffffc0201f12 <__slob_get_free_pages.isra.0>
ffffffffc02020aa:	e488                	sd	a0,8(s1)
ffffffffc02020ac:	842a                	mv	s0,a0
ffffffffc02020ae:	c525                	beqz	a0,ffffffffc0202116 <kmalloc+0xa6>
ffffffffc02020b0:	100027f3          	csrr	a5,sstatus
ffffffffc02020b4:	8b89                	andi	a5,a5,2
ffffffffc02020b6:	ef8d                	bnez	a5,ffffffffc02020f0 <kmalloc+0x80>
ffffffffc02020b8:	00017797          	auipc	a5,0x17
ffffffffc02020bc:	43878793          	addi	a5,a5,1080 # ffffffffc02194f0 <bigblocks>
ffffffffc02020c0:	6398                	ld	a4,0(a5)
ffffffffc02020c2:	e384                	sd	s1,0(a5)
ffffffffc02020c4:	e898                	sd	a4,16(s1)
ffffffffc02020c6:	60e2                	ld	ra,24(sp)
ffffffffc02020c8:	8522                	mv	a0,s0
ffffffffc02020ca:	6442                	ld	s0,16(sp)
ffffffffc02020cc:	64a2                	ld	s1,8(sp)
ffffffffc02020ce:	6902                	ld	s2,0(sp)
ffffffffc02020d0:	6105                	addi	sp,sp,32
ffffffffc02020d2:	8082                	ret
ffffffffc02020d4:	0541                	addi	a0,a0,16
ffffffffc02020d6:	ea1ff0ef          	jal	ra,ffffffffc0201f76 <slob_alloc.isra.0.constprop.0>
ffffffffc02020da:	01050413          	addi	s0,a0,16
ffffffffc02020de:	f565                	bnez	a0,ffffffffc02020c6 <kmalloc+0x56>
ffffffffc02020e0:	4401                	li	s0,0
ffffffffc02020e2:	60e2                	ld	ra,24(sp)
ffffffffc02020e4:	8522                	mv	a0,s0
ffffffffc02020e6:	6442                	ld	s0,16(sp)
ffffffffc02020e8:	64a2                	ld	s1,8(sp)
ffffffffc02020ea:	6902                	ld	s2,0(sp)
ffffffffc02020ec:	6105                	addi	sp,sp,32
ffffffffc02020ee:	8082                	ret
ffffffffc02020f0:	d48fe0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02020f4:	00017797          	auipc	a5,0x17
ffffffffc02020f8:	3fc78793          	addi	a5,a5,1020 # ffffffffc02194f0 <bigblocks>
ffffffffc02020fc:	6398                	ld	a4,0(a5)
ffffffffc02020fe:	e384                	sd	s1,0(a5)
ffffffffc0202100:	e898                	sd	a4,16(s1)
ffffffffc0202102:	d30fe0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0202106:	6480                	ld	s0,8(s1)
ffffffffc0202108:	60e2                	ld	ra,24(sp)
ffffffffc020210a:	64a2                	ld	s1,8(sp)
ffffffffc020210c:	8522                	mv	a0,s0
ffffffffc020210e:	6442                	ld	s0,16(sp)
ffffffffc0202110:	6902                	ld	s2,0(sp)
ffffffffc0202112:	6105                	addi	sp,sp,32
ffffffffc0202114:	8082                	ret
ffffffffc0202116:	45e1                	li	a1,24
ffffffffc0202118:	8526                	mv	a0,s1
ffffffffc020211a:	d57ff0ef          	jal	ra,ffffffffc0201e70 <slob_free>
ffffffffc020211e:	b765                	j	ffffffffc02020c6 <kmalloc+0x56>

ffffffffc0202120 <kfree>:
ffffffffc0202120:	c169                	beqz	a0,ffffffffc02021e2 <kfree+0xc2>
ffffffffc0202122:	1101                	addi	sp,sp,-32
ffffffffc0202124:	e822                	sd	s0,16(sp)
ffffffffc0202126:	ec06                	sd	ra,24(sp)
ffffffffc0202128:	e426                	sd	s1,8(sp)
ffffffffc020212a:	03451793          	slli	a5,a0,0x34
ffffffffc020212e:	842a                	mv	s0,a0
ffffffffc0202130:	e7c9                	bnez	a5,ffffffffc02021ba <kfree+0x9a>
ffffffffc0202132:	100027f3          	csrr	a5,sstatus
ffffffffc0202136:	8b89                	andi	a5,a5,2
ffffffffc0202138:	ebc9                	bnez	a5,ffffffffc02021ca <kfree+0xaa>
ffffffffc020213a:	00017797          	auipc	a5,0x17
ffffffffc020213e:	3b67b783          	ld	a5,950(a5) # ffffffffc02194f0 <bigblocks>
ffffffffc0202142:	4601                	li	a2,0
ffffffffc0202144:	cbbd                	beqz	a5,ffffffffc02021ba <kfree+0x9a>
ffffffffc0202146:	00017697          	auipc	a3,0x17
ffffffffc020214a:	3aa68693          	addi	a3,a3,938 # ffffffffc02194f0 <bigblocks>
ffffffffc020214e:	a021                	j	ffffffffc0202156 <kfree+0x36>
ffffffffc0202150:	01048693          	addi	a3,s1,16
ffffffffc0202154:	c3a5                	beqz	a5,ffffffffc02021b4 <kfree+0x94>
ffffffffc0202156:	6798                	ld	a4,8(a5)
ffffffffc0202158:	84be                	mv	s1,a5
ffffffffc020215a:	6b9c                	ld	a5,16(a5)
ffffffffc020215c:	fe871ae3          	bne	a4,s0,ffffffffc0202150 <kfree+0x30>
ffffffffc0202160:	e29c                	sd	a5,0(a3)
ffffffffc0202162:	ee2d                	bnez	a2,ffffffffc02021dc <kfree+0xbc>
ffffffffc0202164:	c02007b7          	lui	a5,0xc0200
ffffffffc0202168:	4098                	lw	a4,0(s1)
ffffffffc020216a:	08f46963          	bltu	s0,a5,ffffffffc02021fc <kfree+0xdc>
ffffffffc020216e:	00017697          	auipc	a3,0x17
ffffffffc0202172:	3ca6b683          	ld	a3,970(a3) # ffffffffc0219538 <va_pa_offset>
ffffffffc0202176:	8c15                	sub	s0,s0,a3
ffffffffc0202178:	8031                	srli	s0,s0,0xc
ffffffffc020217a:	00017797          	auipc	a5,0x17
ffffffffc020217e:	3567b783          	ld	a5,854(a5) # ffffffffc02194d0 <npage>
ffffffffc0202182:	06f47163          	bgeu	s0,a5,ffffffffc02021e4 <kfree+0xc4>
ffffffffc0202186:	00008517          	auipc	a0,0x8
ffffffffc020218a:	41253503          	ld	a0,1042(a0) # ffffffffc020a598 <nbase>
ffffffffc020218e:	8c09                	sub	s0,s0,a0
ffffffffc0202190:	041a                	slli	s0,s0,0x6
ffffffffc0202192:	00017517          	auipc	a0,0x17
ffffffffc0202196:	3b653503          	ld	a0,950(a0) # ffffffffc0219548 <pages>
ffffffffc020219a:	4585                	li	a1,1
ffffffffc020219c:	9522                	add	a0,a0,s0
ffffffffc020219e:	00e595bb          	sllw	a1,a1,a4
ffffffffc02021a2:	c3bfe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc02021a6:	6442                	ld	s0,16(sp)
ffffffffc02021a8:	60e2                	ld	ra,24(sp)
ffffffffc02021aa:	8526                	mv	a0,s1
ffffffffc02021ac:	64a2                	ld	s1,8(sp)
ffffffffc02021ae:	45e1                	li	a1,24
ffffffffc02021b0:	6105                	addi	sp,sp,32
ffffffffc02021b2:	b97d                	j	ffffffffc0201e70 <slob_free>
ffffffffc02021b4:	c219                	beqz	a2,ffffffffc02021ba <kfree+0x9a>
ffffffffc02021b6:	c7cfe0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc02021ba:	ff040513          	addi	a0,s0,-16
ffffffffc02021be:	6442                	ld	s0,16(sp)
ffffffffc02021c0:	60e2                	ld	ra,24(sp)
ffffffffc02021c2:	64a2                	ld	s1,8(sp)
ffffffffc02021c4:	4581                	li	a1,0
ffffffffc02021c6:	6105                	addi	sp,sp,32
ffffffffc02021c8:	b165                	j	ffffffffc0201e70 <slob_free>
ffffffffc02021ca:	c6efe0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02021ce:	00017797          	auipc	a5,0x17
ffffffffc02021d2:	3227b783          	ld	a5,802(a5) # ffffffffc02194f0 <bigblocks>
ffffffffc02021d6:	4605                	li	a2,1
ffffffffc02021d8:	f7bd                	bnez	a5,ffffffffc0202146 <kfree+0x26>
ffffffffc02021da:	bff1                	j	ffffffffc02021b6 <kfree+0x96>
ffffffffc02021dc:	c56fe0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc02021e0:	b751                	j	ffffffffc0202164 <kfree+0x44>
ffffffffc02021e2:	8082                	ret
ffffffffc02021e4:	00006617          	auipc	a2,0x6
ffffffffc02021e8:	70460613          	addi	a2,a2,1796 # ffffffffc02088e8 <commands+0x700>
ffffffffc02021ec:	06200593          	li	a1,98
ffffffffc02021f0:	00006517          	auipc	a0,0x6
ffffffffc02021f4:	71850513          	addi	a0,a0,1816 # ffffffffc0208908 <commands+0x720>
ffffffffc02021f8:	810fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02021fc:	86a2                	mv	a3,s0
ffffffffc02021fe:	00006617          	auipc	a2,0x6
ffffffffc0202202:	77260613          	addi	a2,a2,1906 # ffffffffc0208970 <commands+0x788>
ffffffffc0202206:	06e00593          	li	a1,110
ffffffffc020220a:	00006517          	auipc	a0,0x6
ffffffffc020220e:	6fe50513          	addi	a0,a0,1790 # ffffffffc0208908 <commands+0x720>
ffffffffc0202212:	ff7fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0202216 <_fifo_init_mm>:
ffffffffc0202216:	00017797          	auipc	a5,0x17
ffffffffc020221a:	40a78793          	addi	a5,a5,1034 # ffffffffc0219620 <pra_list_head>
ffffffffc020221e:	f51c                	sd	a5,40(a0)
ffffffffc0202220:	e79c                	sd	a5,8(a5)
ffffffffc0202222:	e39c                	sd	a5,0(a5)
ffffffffc0202224:	4501                	li	a0,0
ffffffffc0202226:	8082                	ret

ffffffffc0202228 <_fifo_init>:
ffffffffc0202228:	4501                	li	a0,0
ffffffffc020222a:	8082                	ret

ffffffffc020222c <_fifo_set_unswappable>:
ffffffffc020222c:	4501                	li	a0,0
ffffffffc020222e:	8082                	ret

ffffffffc0202230 <_fifo_tick_event>:
ffffffffc0202230:	4501                	li	a0,0
ffffffffc0202232:	8082                	ret

ffffffffc0202234 <_fifo_check_swap>:
ffffffffc0202234:	711d                	addi	sp,sp,-96
ffffffffc0202236:	fc4e                	sd	s3,56(sp)
ffffffffc0202238:	f852                	sd	s4,48(sp)
ffffffffc020223a:	00007517          	auipc	a0,0x7
ffffffffc020223e:	b7650513          	addi	a0,a0,-1162 # ffffffffc0208db0 <commands+0xbc8>
ffffffffc0202242:	698d                	lui	s3,0x3
ffffffffc0202244:	4a31                	li	s4,12
ffffffffc0202246:	e0ca                	sd	s2,64(sp)
ffffffffc0202248:	ec86                	sd	ra,88(sp)
ffffffffc020224a:	e8a2                	sd	s0,80(sp)
ffffffffc020224c:	e4a6                	sd	s1,72(sp)
ffffffffc020224e:	f456                	sd	s5,40(sp)
ffffffffc0202250:	f05a                	sd	s6,32(sp)
ffffffffc0202252:	ec5e                	sd	s7,24(sp)
ffffffffc0202254:	e862                	sd	s8,16(sp)
ffffffffc0202256:	e466                	sd	s9,8(sp)
ffffffffc0202258:	e06a                	sd	s10,0(sp)
ffffffffc020225a:	e73fd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020225e:	01498023          	sb	s4,0(s3) # 3000 <kern_entry-0xffffffffc01fd000>
ffffffffc0202262:	00017917          	auipc	s2,0x17
ffffffffc0202266:	27692903          	lw	s2,630(s2) # ffffffffc02194d8 <pgfault_num>
ffffffffc020226a:	4791                	li	a5,4
ffffffffc020226c:	14f91e63          	bne	s2,a5,ffffffffc02023c8 <_fifo_check_swap+0x194>
ffffffffc0202270:	00007517          	auipc	a0,0x7
ffffffffc0202274:	b9050513          	addi	a0,a0,-1136 # ffffffffc0208e00 <commands+0xc18>
ffffffffc0202278:	6a85                	lui	s5,0x1
ffffffffc020227a:	4b29                	li	s6,10
ffffffffc020227c:	e51fd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0202280:	00017417          	auipc	s0,0x17
ffffffffc0202284:	25840413          	addi	s0,s0,600 # ffffffffc02194d8 <pgfault_num>
ffffffffc0202288:	016a8023          	sb	s6,0(s5) # 1000 <kern_entry-0xffffffffc01ff000>
ffffffffc020228c:	4004                	lw	s1,0(s0)
ffffffffc020228e:	2481                	sext.w	s1,s1
ffffffffc0202290:	2b249c63          	bne	s1,s2,ffffffffc0202548 <_fifo_check_swap+0x314>
ffffffffc0202294:	00007517          	auipc	a0,0x7
ffffffffc0202298:	b9450513          	addi	a0,a0,-1132 # ffffffffc0208e28 <commands+0xc40>
ffffffffc020229c:	6b91                	lui	s7,0x4
ffffffffc020229e:	4c35                	li	s8,13
ffffffffc02022a0:	e2dfd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02022a4:	018b8023          	sb	s8,0(s7) # 4000 <kern_entry-0xffffffffc01fc000>
ffffffffc02022a8:	00042903          	lw	s2,0(s0)
ffffffffc02022ac:	2901                	sext.w	s2,s2
ffffffffc02022ae:	26991d63          	bne	s2,s1,ffffffffc0202528 <_fifo_check_swap+0x2f4>
ffffffffc02022b2:	00007517          	auipc	a0,0x7
ffffffffc02022b6:	b9e50513          	addi	a0,a0,-1122 # ffffffffc0208e50 <commands+0xc68>
ffffffffc02022ba:	6c89                	lui	s9,0x2
ffffffffc02022bc:	4d2d                	li	s10,11
ffffffffc02022be:	e0ffd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02022c2:	01ac8023          	sb	s10,0(s9) # 2000 <kern_entry-0xffffffffc01fe000>
ffffffffc02022c6:	401c                	lw	a5,0(s0)
ffffffffc02022c8:	2781                	sext.w	a5,a5
ffffffffc02022ca:	23279f63          	bne	a5,s2,ffffffffc0202508 <_fifo_check_swap+0x2d4>
ffffffffc02022ce:	00007517          	auipc	a0,0x7
ffffffffc02022d2:	baa50513          	addi	a0,a0,-1110 # ffffffffc0208e78 <commands+0xc90>
ffffffffc02022d6:	df7fd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02022da:	6795                	lui	a5,0x5
ffffffffc02022dc:	4739                	li	a4,14
ffffffffc02022de:	00e78023          	sb	a4,0(a5) # 5000 <kern_entry-0xffffffffc01fb000>
ffffffffc02022e2:	4004                	lw	s1,0(s0)
ffffffffc02022e4:	4795                	li	a5,5
ffffffffc02022e6:	2481                	sext.w	s1,s1
ffffffffc02022e8:	20f49063          	bne	s1,a5,ffffffffc02024e8 <_fifo_check_swap+0x2b4>
ffffffffc02022ec:	00007517          	auipc	a0,0x7
ffffffffc02022f0:	b6450513          	addi	a0,a0,-1180 # ffffffffc0208e50 <commands+0xc68>
ffffffffc02022f4:	dd9fd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02022f8:	01ac8023          	sb	s10,0(s9)
ffffffffc02022fc:	401c                	lw	a5,0(s0)
ffffffffc02022fe:	2781                	sext.w	a5,a5
ffffffffc0202300:	1c979463          	bne	a5,s1,ffffffffc02024c8 <_fifo_check_swap+0x294>
ffffffffc0202304:	00007517          	auipc	a0,0x7
ffffffffc0202308:	afc50513          	addi	a0,a0,-1284 # ffffffffc0208e00 <commands+0xc18>
ffffffffc020230c:	dc1fd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0202310:	016a8023          	sb	s6,0(s5)
ffffffffc0202314:	401c                	lw	a5,0(s0)
ffffffffc0202316:	4719                	li	a4,6
ffffffffc0202318:	2781                	sext.w	a5,a5
ffffffffc020231a:	18e79763          	bne	a5,a4,ffffffffc02024a8 <_fifo_check_swap+0x274>
ffffffffc020231e:	00007517          	auipc	a0,0x7
ffffffffc0202322:	b3250513          	addi	a0,a0,-1230 # ffffffffc0208e50 <commands+0xc68>
ffffffffc0202326:	da7fd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020232a:	01ac8023          	sb	s10,0(s9)
ffffffffc020232e:	401c                	lw	a5,0(s0)
ffffffffc0202330:	471d                	li	a4,7
ffffffffc0202332:	2781                	sext.w	a5,a5
ffffffffc0202334:	14e79a63          	bne	a5,a4,ffffffffc0202488 <_fifo_check_swap+0x254>
ffffffffc0202338:	00007517          	auipc	a0,0x7
ffffffffc020233c:	a7850513          	addi	a0,a0,-1416 # ffffffffc0208db0 <commands+0xbc8>
ffffffffc0202340:	d8dfd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0202344:	01498023          	sb	s4,0(s3)
ffffffffc0202348:	401c                	lw	a5,0(s0)
ffffffffc020234a:	4721                	li	a4,8
ffffffffc020234c:	2781                	sext.w	a5,a5
ffffffffc020234e:	10e79d63          	bne	a5,a4,ffffffffc0202468 <_fifo_check_swap+0x234>
ffffffffc0202352:	00007517          	auipc	a0,0x7
ffffffffc0202356:	ad650513          	addi	a0,a0,-1322 # ffffffffc0208e28 <commands+0xc40>
ffffffffc020235a:	d73fd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020235e:	018b8023          	sb	s8,0(s7)
ffffffffc0202362:	401c                	lw	a5,0(s0)
ffffffffc0202364:	4725                	li	a4,9
ffffffffc0202366:	2781                	sext.w	a5,a5
ffffffffc0202368:	0ee79063          	bne	a5,a4,ffffffffc0202448 <_fifo_check_swap+0x214>
ffffffffc020236c:	00007517          	auipc	a0,0x7
ffffffffc0202370:	b0c50513          	addi	a0,a0,-1268 # ffffffffc0208e78 <commands+0xc90>
ffffffffc0202374:	d59fd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0202378:	6795                	lui	a5,0x5
ffffffffc020237a:	4739                	li	a4,14
ffffffffc020237c:	00e78023          	sb	a4,0(a5) # 5000 <kern_entry-0xffffffffc01fb000>
ffffffffc0202380:	4004                	lw	s1,0(s0)
ffffffffc0202382:	47a9                	li	a5,10
ffffffffc0202384:	2481                	sext.w	s1,s1
ffffffffc0202386:	0af49163          	bne	s1,a5,ffffffffc0202428 <_fifo_check_swap+0x1f4>
ffffffffc020238a:	00007517          	auipc	a0,0x7
ffffffffc020238e:	a7650513          	addi	a0,a0,-1418 # ffffffffc0208e00 <commands+0xc18>
ffffffffc0202392:	d3bfd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0202396:	6785                	lui	a5,0x1
ffffffffc0202398:	0007c783          	lbu	a5,0(a5) # 1000 <kern_entry-0xffffffffc01ff000>
ffffffffc020239c:	06979663          	bne	a5,s1,ffffffffc0202408 <_fifo_check_swap+0x1d4>
ffffffffc02023a0:	401c                	lw	a5,0(s0)
ffffffffc02023a2:	472d                	li	a4,11
ffffffffc02023a4:	2781                	sext.w	a5,a5
ffffffffc02023a6:	04e79163          	bne	a5,a4,ffffffffc02023e8 <_fifo_check_swap+0x1b4>
ffffffffc02023aa:	60e6                	ld	ra,88(sp)
ffffffffc02023ac:	6446                	ld	s0,80(sp)
ffffffffc02023ae:	64a6                	ld	s1,72(sp)
ffffffffc02023b0:	6906                	ld	s2,64(sp)
ffffffffc02023b2:	79e2                	ld	s3,56(sp)
ffffffffc02023b4:	7a42                	ld	s4,48(sp)
ffffffffc02023b6:	7aa2                	ld	s5,40(sp)
ffffffffc02023b8:	7b02                	ld	s6,32(sp)
ffffffffc02023ba:	6be2                	ld	s7,24(sp)
ffffffffc02023bc:	6c42                	ld	s8,16(sp)
ffffffffc02023be:	6ca2                	ld	s9,8(sp)
ffffffffc02023c0:	6d02                	ld	s10,0(sp)
ffffffffc02023c2:	4501                	li	a0,0
ffffffffc02023c4:	6125                	addi	sp,sp,96
ffffffffc02023c6:	8082                	ret
ffffffffc02023c8:	00007697          	auipc	a3,0x7
ffffffffc02023cc:	a1068693          	addi	a3,a3,-1520 # ffffffffc0208dd8 <commands+0xbf0>
ffffffffc02023d0:	00006617          	auipc	a2,0x6
ffffffffc02023d4:	22860613          	addi	a2,a2,552 # ffffffffc02085f8 <commands+0x410>
ffffffffc02023d8:	05100593          	li	a1,81
ffffffffc02023dc:	00007517          	auipc	a0,0x7
ffffffffc02023e0:	a0c50513          	addi	a0,a0,-1524 # ffffffffc0208de8 <commands+0xc00>
ffffffffc02023e4:	e25fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02023e8:	00007697          	auipc	a3,0x7
ffffffffc02023ec:	b4068693          	addi	a3,a3,-1216 # ffffffffc0208f28 <commands+0xd40>
ffffffffc02023f0:	00006617          	auipc	a2,0x6
ffffffffc02023f4:	20860613          	addi	a2,a2,520 # ffffffffc02085f8 <commands+0x410>
ffffffffc02023f8:	07300593          	li	a1,115
ffffffffc02023fc:	00007517          	auipc	a0,0x7
ffffffffc0202400:	9ec50513          	addi	a0,a0,-1556 # ffffffffc0208de8 <commands+0xc00>
ffffffffc0202404:	e05fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202408:	00007697          	auipc	a3,0x7
ffffffffc020240c:	af868693          	addi	a3,a3,-1288 # ffffffffc0208f00 <commands+0xd18>
ffffffffc0202410:	00006617          	auipc	a2,0x6
ffffffffc0202414:	1e860613          	addi	a2,a2,488 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202418:	07100593          	li	a1,113
ffffffffc020241c:	00007517          	auipc	a0,0x7
ffffffffc0202420:	9cc50513          	addi	a0,a0,-1588 # ffffffffc0208de8 <commands+0xc00>
ffffffffc0202424:	de5fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202428:	00007697          	auipc	a3,0x7
ffffffffc020242c:	ac868693          	addi	a3,a3,-1336 # ffffffffc0208ef0 <commands+0xd08>
ffffffffc0202430:	00006617          	auipc	a2,0x6
ffffffffc0202434:	1c860613          	addi	a2,a2,456 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202438:	06f00593          	li	a1,111
ffffffffc020243c:	00007517          	auipc	a0,0x7
ffffffffc0202440:	9ac50513          	addi	a0,a0,-1620 # ffffffffc0208de8 <commands+0xc00>
ffffffffc0202444:	dc5fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202448:	00007697          	auipc	a3,0x7
ffffffffc020244c:	a9868693          	addi	a3,a3,-1384 # ffffffffc0208ee0 <commands+0xcf8>
ffffffffc0202450:	00006617          	auipc	a2,0x6
ffffffffc0202454:	1a860613          	addi	a2,a2,424 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202458:	06c00593          	li	a1,108
ffffffffc020245c:	00007517          	auipc	a0,0x7
ffffffffc0202460:	98c50513          	addi	a0,a0,-1652 # ffffffffc0208de8 <commands+0xc00>
ffffffffc0202464:	da5fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202468:	00007697          	auipc	a3,0x7
ffffffffc020246c:	a6868693          	addi	a3,a3,-1432 # ffffffffc0208ed0 <commands+0xce8>
ffffffffc0202470:	00006617          	auipc	a2,0x6
ffffffffc0202474:	18860613          	addi	a2,a2,392 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202478:	06900593          	li	a1,105
ffffffffc020247c:	00007517          	auipc	a0,0x7
ffffffffc0202480:	96c50513          	addi	a0,a0,-1684 # ffffffffc0208de8 <commands+0xc00>
ffffffffc0202484:	d85fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202488:	00007697          	auipc	a3,0x7
ffffffffc020248c:	a3868693          	addi	a3,a3,-1480 # ffffffffc0208ec0 <commands+0xcd8>
ffffffffc0202490:	00006617          	auipc	a2,0x6
ffffffffc0202494:	16860613          	addi	a2,a2,360 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202498:	06600593          	li	a1,102
ffffffffc020249c:	00007517          	auipc	a0,0x7
ffffffffc02024a0:	94c50513          	addi	a0,a0,-1716 # ffffffffc0208de8 <commands+0xc00>
ffffffffc02024a4:	d65fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02024a8:	00007697          	auipc	a3,0x7
ffffffffc02024ac:	a0868693          	addi	a3,a3,-1528 # ffffffffc0208eb0 <commands+0xcc8>
ffffffffc02024b0:	00006617          	auipc	a2,0x6
ffffffffc02024b4:	14860613          	addi	a2,a2,328 # ffffffffc02085f8 <commands+0x410>
ffffffffc02024b8:	06300593          	li	a1,99
ffffffffc02024bc:	00007517          	auipc	a0,0x7
ffffffffc02024c0:	92c50513          	addi	a0,a0,-1748 # ffffffffc0208de8 <commands+0xc00>
ffffffffc02024c4:	d45fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02024c8:	00007697          	auipc	a3,0x7
ffffffffc02024cc:	9d868693          	addi	a3,a3,-1576 # ffffffffc0208ea0 <commands+0xcb8>
ffffffffc02024d0:	00006617          	auipc	a2,0x6
ffffffffc02024d4:	12860613          	addi	a2,a2,296 # ffffffffc02085f8 <commands+0x410>
ffffffffc02024d8:	06000593          	li	a1,96
ffffffffc02024dc:	00007517          	auipc	a0,0x7
ffffffffc02024e0:	90c50513          	addi	a0,a0,-1780 # ffffffffc0208de8 <commands+0xc00>
ffffffffc02024e4:	d25fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02024e8:	00007697          	auipc	a3,0x7
ffffffffc02024ec:	9b868693          	addi	a3,a3,-1608 # ffffffffc0208ea0 <commands+0xcb8>
ffffffffc02024f0:	00006617          	auipc	a2,0x6
ffffffffc02024f4:	10860613          	addi	a2,a2,264 # ffffffffc02085f8 <commands+0x410>
ffffffffc02024f8:	05d00593          	li	a1,93
ffffffffc02024fc:	00007517          	auipc	a0,0x7
ffffffffc0202500:	8ec50513          	addi	a0,a0,-1812 # ffffffffc0208de8 <commands+0xc00>
ffffffffc0202504:	d05fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202508:	00007697          	auipc	a3,0x7
ffffffffc020250c:	8d068693          	addi	a3,a3,-1840 # ffffffffc0208dd8 <commands+0xbf0>
ffffffffc0202510:	00006617          	auipc	a2,0x6
ffffffffc0202514:	0e860613          	addi	a2,a2,232 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202518:	05a00593          	li	a1,90
ffffffffc020251c:	00007517          	auipc	a0,0x7
ffffffffc0202520:	8cc50513          	addi	a0,a0,-1844 # ffffffffc0208de8 <commands+0xc00>
ffffffffc0202524:	ce5fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202528:	00007697          	auipc	a3,0x7
ffffffffc020252c:	8b068693          	addi	a3,a3,-1872 # ffffffffc0208dd8 <commands+0xbf0>
ffffffffc0202530:	00006617          	auipc	a2,0x6
ffffffffc0202534:	0c860613          	addi	a2,a2,200 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202538:	05700593          	li	a1,87
ffffffffc020253c:	00007517          	auipc	a0,0x7
ffffffffc0202540:	8ac50513          	addi	a0,a0,-1876 # ffffffffc0208de8 <commands+0xc00>
ffffffffc0202544:	cc5fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202548:	00007697          	auipc	a3,0x7
ffffffffc020254c:	89068693          	addi	a3,a3,-1904 # ffffffffc0208dd8 <commands+0xbf0>
ffffffffc0202550:	00006617          	auipc	a2,0x6
ffffffffc0202554:	0a860613          	addi	a2,a2,168 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202558:	05400593          	li	a1,84
ffffffffc020255c:	00007517          	auipc	a0,0x7
ffffffffc0202560:	88c50513          	addi	a0,a0,-1908 # ffffffffc0208de8 <commands+0xc00>
ffffffffc0202564:	ca5fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0202568 <_fifo_swap_out_victim>:
ffffffffc0202568:	751c                	ld	a5,40(a0)
ffffffffc020256a:	1141                	addi	sp,sp,-16
ffffffffc020256c:	e406                	sd	ra,8(sp)
ffffffffc020256e:	cf91                	beqz	a5,ffffffffc020258a <_fifo_swap_out_victim+0x22>
ffffffffc0202570:	ee0d                	bnez	a2,ffffffffc02025aa <_fifo_swap_out_victim+0x42>
ffffffffc0202572:	679c                	ld	a5,8(a5)
ffffffffc0202574:	60a2                	ld	ra,8(sp)
ffffffffc0202576:	4501                	li	a0,0
ffffffffc0202578:	6394                	ld	a3,0(a5)
ffffffffc020257a:	6798                	ld	a4,8(a5)
ffffffffc020257c:	fd878793          	addi	a5,a5,-40
ffffffffc0202580:	e698                	sd	a4,8(a3)
ffffffffc0202582:	e314                	sd	a3,0(a4)
ffffffffc0202584:	e19c                	sd	a5,0(a1)
ffffffffc0202586:	0141                	addi	sp,sp,16
ffffffffc0202588:	8082                	ret
ffffffffc020258a:	00007697          	auipc	a3,0x7
ffffffffc020258e:	9ae68693          	addi	a3,a3,-1618 # ffffffffc0208f38 <commands+0xd50>
ffffffffc0202592:	00006617          	auipc	a2,0x6
ffffffffc0202596:	06660613          	addi	a2,a2,102 # ffffffffc02085f8 <commands+0x410>
ffffffffc020259a:	04100593          	li	a1,65
ffffffffc020259e:	00007517          	auipc	a0,0x7
ffffffffc02025a2:	84a50513          	addi	a0,a0,-1974 # ffffffffc0208de8 <commands+0xc00>
ffffffffc02025a6:	c63fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02025aa:	00007697          	auipc	a3,0x7
ffffffffc02025ae:	99e68693          	addi	a3,a3,-1634 # ffffffffc0208f48 <commands+0xd60>
ffffffffc02025b2:	00006617          	auipc	a2,0x6
ffffffffc02025b6:	04660613          	addi	a2,a2,70 # ffffffffc02085f8 <commands+0x410>
ffffffffc02025ba:	04200593          	li	a1,66
ffffffffc02025be:	00007517          	auipc	a0,0x7
ffffffffc02025c2:	82a50513          	addi	a0,a0,-2006 # ffffffffc0208de8 <commands+0xc00>
ffffffffc02025c6:	c43fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02025ca <_fifo_map_swappable>:
ffffffffc02025ca:	751c                	ld	a5,40(a0)
ffffffffc02025cc:	cb91                	beqz	a5,ffffffffc02025e0 <_fifo_map_swappable+0x16>
ffffffffc02025ce:	6394                	ld	a3,0(a5)
ffffffffc02025d0:	02860713          	addi	a4,a2,40
ffffffffc02025d4:	e398                	sd	a4,0(a5)
ffffffffc02025d6:	e698                	sd	a4,8(a3)
ffffffffc02025d8:	4501                	li	a0,0
ffffffffc02025da:	fa1c                	sd	a5,48(a2)
ffffffffc02025dc:	f614                	sd	a3,40(a2)
ffffffffc02025de:	8082                	ret
ffffffffc02025e0:	1141                	addi	sp,sp,-16
ffffffffc02025e2:	00007697          	auipc	a3,0x7
ffffffffc02025e6:	97668693          	addi	a3,a3,-1674 # ffffffffc0208f58 <commands+0xd70>
ffffffffc02025ea:	00006617          	auipc	a2,0x6
ffffffffc02025ee:	00e60613          	addi	a2,a2,14 # ffffffffc02085f8 <commands+0x410>
ffffffffc02025f2:	03200593          	li	a1,50
ffffffffc02025f6:	00006517          	auipc	a0,0x6
ffffffffc02025fa:	7f250513          	addi	a0,a0,2034 # ffffffffc0208de8 <commands+0xc00>
ffffffffc02025fe:	e406                	sd	ra,8(sp)
ffffffffc0202600:	c09fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0202604 <default_init>:
ffffffffc0202604:	00017797          	auipc	a5,0x17
ffffffffc0202608:	02c78793          	addi	a5,a5,44 # ffffffffc0219630 <free_area>
ffffffffc020260c:	e79c                	sd	a5,8(a5)
ffffffffc020260e:	e39c                	sd	a5,0(a5)
ffffffffc0202610:	0007a823          	sw	zero,16(a5)
ffffffffc0202614:	8082                	ret

ffffffffc0202616 <default_nr_free_pages>:
ffffffffc0202616:	00017517          	auipc	a0,0x17
ffffffffc020261a:	02a56503          	lwu	a0,42(a0) # ffffffffc0219640 <free_area+0x10>
ffffffffc020261e:	8082                	ret

ffffffffc0202620 <default_check>:
ffffffffc0202620:	715d                	addi	sp,sp,-80
ffffffffc0202622:	e0a2                	sd	s0,64(sp)
ffffffffc0202624:	00017417          	auipc	s0,0x17
ffffffffc0202628:	00c40413          	addi	s0,s0,12 # ffffffffc0219630 <free_area>
ffffffffc020262c:	641c                	ld	a5,8(s0)
ffffffffc020262e:	e486                	sd	ra,72(sp)
ffffffffc0202630:	fc26                	sd	s1,56(sp)
ffffffffc0202632:	f84a                	sd	s2,48(sp)
ffffffffc0202634:	f44e                	sd	s3,40(sp)
ffffffffc0202636:	f052                	sd	s4,32(sp)
ffffffffc0202638:	ec56                	sd	s5,24(sp)
ffffffffc020263a:	e85a                	sd	s6,16(sp)
ffffffffc020263c:	e45e                	sd	s7,8(sp)
ffffffffc020263e:	e062                	sd	s8,0(sp)
ffffffffc0202640:	2a878d63          	beq	a5,s0,ffffffffc02028fa <default_check+0x2da>
ffffffffc0202644:	4481                	li	s1,0
ffffffffc0202646:	4901                	li	s2,0
ffffffffc0202648:	ff07b703          	ld	a4,-16(a5)
ffffffffc020264c:	8b09                	andi	a4,a4,2
ffffffffc020264e:	2a070a63          	beqz	a4,ffffffffc0202902 <default_check+0x2e2>
ffffffffc0202652:	ff87a703          	lw	a4,-8(a5)
ffffffffc0202656:	679c                	ld	a5,8(a5)
ffffffffc0202658:	2905                	addiw	s2,s2,1
ffffffffc020265a:	9cb9                	addw	s1,s1,a4
ffffffffc020265c:	fe8796e3          	bne	a5,s0,ffffffffc0202648 <default_check+0x28>
ffffffffc0202660:	89a6                	mv	s3,s1
ffffffffc0202662:	fbcfe0ef          	jal	ra,ffffffffc0200e1e <nr_free_pages>
ffffffffc0202666:	6f351e63          	bne	a0,s3,ffffffffc0202d62 <default_check+0x742>
ffffffffc020266a:	4505                	li	a0,1
ffffffffc020266c:	edefe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202670:	8aaa                	mv	s5,a0
ffffffffc0202672:	42050863          	beqz	a0,ffffffffc0202aa2 <default_check+0x482>
ffffffffc0202676:	4505                	li	a0,1
ffffffffc0202678:	ed2fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc020267c:	89aa                	mv	s3,a0
ffffffffc020267e:	70050263          	beqz	a0,ffffffffc0202d82 <default_check+0x762>
ffffffffc0202682:	4505                	li	a0,1
ffffffffc0202684:	ec6fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202688:	8a2a                	mv	s4,a0
ffffffffc020268a:	48050c63          	beqz	a0,ffffffffc0202b22 <default_check+0x502>
ffffffffc020268e:	293a8a63          	beq	s5,s3,ffffffffc0202922 <default_check+0x302>
ffffffffc0202692:	28aa8863          	beq	s5,a0,ffffffffc0202922 <default_check+0x302>
ffffffffc0202696:	28a98663          	beq	s3,a0,ffffffffc0202922 <default_check+0x302>
ffffffffc020269a:	000aa783          	lw	a5,0(s5)
ffffffffc020269e:	2a079263          	bnez	a5,ffffffffc0202942 <default_check+0x322>
ffffffffc02026a2:	0009a783          	lw	a5,0(s3)
ffffffffc02026a6:	28079e63          	bnez	a5,ffffffffc0202942 <default_check+0x322>
ffffffffc02026aa:	411c                	lw	a5,0(a0)
ffffffffc02026ac:	28079b63          	bnez	a5,ffffffffc0202942 <default_check+0x322>
ffffffffc02026b0:	00017797          	auipc	a5,0x17
ffffffffc02026b4:	e987b783          	ld	a5,-360(a5) # ffffffffc0219548 <pages>
ffffffffc02026b8:	40fa8733          	sub	a4,s5,a5
ffffffffc02026bc:	00008617          	auipc	a2,0x8
ffffffffc02026c0:	edc63603          	ld	a2,-292(a2) # ffffffffc020a598 <nbase>
ffffffffc02026c4:	8719                	srai	a4,a4,0x6
ffffffffc02026c6:	9732                	add	a4,a4,a2
ffffffffc02026c8:	00017697          	auipc	a3,0x17
ffffffffc02026cc:	e086b683          	ld	a3,-504(a3) # ffffffffc02194d0 <npage>
ffffffffc02026d0:	06b2                	slli	a3,a3,0xc
ffffffffc02026d2:	0732                	slli	a4,a4,0xc
ffffffffc02026d4:	28d77763          	bgeu	a4,a3,ffffffffc0202962 <default_check+0x342>
ffffffffc02026d8:	40f98733          	sub	a4,s3,a5
ffffffffc02026dc:	8719                	srai	a4,a4,0x6
ffffffffc02026de:	9732                	add	a4,a4,a2
ffffffffc02026e0:	0732                	slli	a4,a4,0xc
ffffffffc02026e2:	4cd77063          	bgeu	a4,a3,ffffffffc0202ba2 <default_check+0x582>
ffffffffc02026e6:	40f507b3          	sub	a5,a0,a5
ffffffffc02026ea:	8799                	srai	a5,a5,0x6
ffffffffc02026ec:	97b2                	add	a5,a5,a2
ffffffffc02026ee:	07b2                	slli	a5,a5,0xc
ffffffffc02026f0:	30d7f963          	bgeu	a5,a3,ffffffffc0202a02 <default_check+0x3e2>
ffffffffc02026f4:	4505                	li	a0,1
ffffffffc02026f6:	00043c03          	ld	s8,0(s0)
ffffffffc02026fa:	00843b83          	ld	s7,8(s0)
ffffffffc02026fe:	01042b03          	lw	s6,16(s0)
ffffffffc0202702:	e400                	sd	s0,8(s0)
ffffffffc0202704:	e000                	sd	s0,0(s0)
ffffffffc0202706:	00017797          	auipc	a5,0x17
ffffffffc020270a:	f207ad23          	sw	zero,-198(a5) # ffffffffc0219640 <free_area+0x10>
ffffffffc020270e:	e3cfe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202712:	2c051863          	bnez	a0,ffffffffc02029e2 <default_check+0x3c2>
ffffffffc0202716:	4585                	li	a1,1
ffffffffc0202718:	8556                	mv	a0,s5
ffffffffc020271a:	ec2fe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc020271e:	4585                	li	a1,1
ffffffffc0202720:	854e                	mv	a0,s3
ffffffffc0202722:	ebafe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0202726:	4585                	li	a1,1
ffffffffc0202728:	8552                	mv	a0,s4
ffffffffc020272a:	eb2fe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc020272e:	4818                	lw	a4,16(s0)
ffffffffc0202730:	478d                	li	a5,3
ffffffffc0202732:	28f71863          	bne	a4,a5,ffffffffc02029c2 <default_check+0x3a2>
ffffffffc0202736:	4505                	li	a0,1
ffffffffc0202738:	e12fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc020273c:	89aa                	mv	s3,a0
ffffffffc020273e:	26050263          	beqz	a0,ffffffffc02029a2 <default_check+0x382>
ffffffffc0202742:	4505                	li	a0,1
ffffffffc0202744:	e06fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202748:	8aaa                	mv	s5,a0
ffffffffc020274a:	3a050c63          	beqz	a0,ffffffffc0202b02 <default_check+0x4e2>
ffffffffc020274e:	4505                	li	a0,1
ffffffffc0202750:	dfafe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202754:	8a2a                	mv	s4,a0
ffffffffc0202756:	38050663          	beqz	a0,ffffffffc0202ae2 <default_check+0x4c2>
ffffffffc020275a:	4505                	li	a0,1
ffffffffc020275c:	deefe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202760:	36051163          	bnez	a0,ffffffffc0202ac2 <default_check+0x4a2>
ffffffffc0202764:	4585                	li	a1,1
ffffffffc0202766:	854e                	mv	a0,s3
ffffffffc0202768:	e74fe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc020276c:	641c                	ld	a5,8(s0)
ffffffffc020276e:	20878a63          	beq	a5,s0,ffffffffc0202982 <default_check+0x362>
ffffffffc0202772:	4505                	li	a0,1
ffffffffc0202774:	dd6fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202778:	30a99563          	bne	s3,a0,ffffffffc0202a82 <default_check+0x462>
ffffffffc020277c:	4505                	li	a0,1
ffffffffc020277e:	dccfe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202782:	2e051063          	bnez	a0,ffffffffc0202a62 <default_check+0x442>
ffffffffc0202786:	481c                	lw	a5,16(s0)
ffffffffc0202788:	2a079d63          	bnez	a5,ffffffffc0202a42 <default_check+0x422>
ffffffffc020278c:	854e                	mv	a0,s3
ffffffffc020278e:	4585                	li	a1,1
ffffffffc0202790:	01843023          	sd	s8,0(s0)
ffffffffc0202794:	01743423          	sd	s7,8(s0)
ffffffffc0202798:	01642823          	sw	s6,16(s0)
ffffffffc020279c:	e40fe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc02027a0:	4585                	li	a1,1
ffffffffc02027a2:	8556                	mv	a0,s5
ffffffffc02027a4:	e38fe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc02027a8:	4585                	li	a1,1
ffffffffc02027aa:	8552                	mv	a0,s4
ffffffffc02027ac:	e30fe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc02027b0:	4515                	li	a0,5
ffffffffc02027b2:	d98fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc02027b6:	89aa                	mv	s3,a0
ffffffffc02027b8:	26050563          	beqz	a0,ffffffffc0202a22 <default_check+0x402>
ffffffffc02027bc:	651c                	ld	a5,8(a0)
ffffffffc02027be:	8385                	srli	a5,a5,0x1
ffffffffc02027c0:	8b85                	andi	a5,a5,1
ffffffffc02027c2:	54079063          	bnez	a5,ffffffffc0202d02 <default_check+0x6e2>
ffffffffc02027c6:	4505                	li	a0,1
ffffffffc02027c8:	00043b03          	ld	s6,0(s0)
ffffffffc02027cc:	00843a83          	ld	s5,8(s0)
ffffffffc02027d0:	e000                	sd	s0,0(s0)
ffffffffc02027d2:	e400                	sd	s0,8(s0)
ffffffffc02027d4:	d76fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc02027d8:	50051563          	bnez	a0,ffffffffc0202ce2 <default_check+0x6c2>
ffffffffc02027dc:	08098a13          	addi	s4,s3,128
ffffffffc02027e0:	8552                	mv	a0,s4
ffffffffc02027e2:	458d                	li	a1,3
ffffffffc02027e4:	01042b83          	lw	s7,16(s0)
ffffffffc02027e8:	00017797          	auipc	a5,0x17
ffffffffc02027ec:	e407ac23          	sw	zero,-424(a5) # ffffffffc0219640 <free_area+0x10>
ffffffffc02027f0:	decfe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc02027f4:	4511                	li	a0,4
ffffffffc02027f6:	d54fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc02027fa:	4c051463          	bnez	a0,ffffffffc0202cc2 <default_check+0x6a2>
ffffffffc02027fe:	0889b783          	ld	a5,136(s3)
ffffffffc0202802:	8385                	srli	a5,a5,0x1
ffffffffc0202804:	8b85                	andi	a5,a5,1
ffffffffc0202806:	48078e63          	beqz	a5,ffffffffc0202ca2 <default_check+0x682>
ffffffffc020280a:	0909a703          	lw	a4,144(s3)
ffffffffc020280e:	478d                	li	a5,3
ffffffffc0202810:	48f71963          	bne	a4,a5,ffffffffc0202ca2 <default_check+0x682>
ffffffffc0202814:	450d                	li	a0,3
ffffffffc0202816:	d34fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc020281a:	8c2a                	mv	s8,a0
ffffffffc020281c:	46050363          	beqz	a0,ffffffffc0202c82 <default_check+0x662>
ffffffffc0202820:	4505                	li	a0,1
ffffffffc0202822:	d28fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202826:	42051e63          	bnez	a0,ffffffffc0202c62 <default_check+0x642>
ffffffffc020282a:	418a1c63          	bne	s4,s8,ffffffffc0202c42 <default_check+0x622>
ffffffffc020282e:	4585                	li	a1,1
ffffffffc0202830:	854e                	mv	a0,s3
ffffffffc0202832:	daafe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0202836:	458d                	li	a1,3
ffffffffc0202838:	8552                	mv	a0,s4
ffffffffc020283a:	da2fe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc020283e:	0089b783          	ld	a5,8(s3)
ffffffffc0202842:	04098c13          	addi	s8,s3,64
ffffffffc0202846:	8385                	srli	a5,a5,0x1
ffffffffc0202848:	8b85                	andi	a5,a5,1
ffffffffc020284a:	3c078c63          	beqz	a5,ffffffffc0202c22 <default_check+0x602>
ffffffffc020284e:	0109a703          	lw	a4,16(s3)
ffffffffc0202852:	4785                	li	a5,1
ffffffffc0202854:	3cf71763          	bne	a4,a5,ffffffffc0202c22 <default_check+0x602>
ffffffffc0202858:	008a3783          	ld	a5,8(s4) # 1008 <kern_entry-0xffffffffc01feff8>
ffffffffc020285c:	8385                	srli	a5,a5,0x1
ffffffffc020285e:	8b85                	andi	a5,a5,1
ffffffffc0202860:	3a078163          	beqz	a5,ffffffffc0202c02 <default_check+0x5e2>
ffffffffc0202864:	010a2703          	lw	a4,16(s4)
ffffffffc0202868:	478d                	li	a5,3
ffffffffc020286a:	38f71c63          	bne	a4,a5,ffffffffc0202c02 <default_check+0x5e2>
ffffffffc020286e:	4505                	li	a0,1
ffffffffc0202870:	cdafe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202874:	36a99763          	bne	s3,a0,ffffffffc0202be2 <default_check+0x5c2>
ffffffffc0202878:	4585                	li	a1,1
ffffffffc020287a:	d62fe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc020287e:	4509                	li	a0,2
ffffffffc0202880:	ccafe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202884:	32aa1f63          	bne	s4,a0,ffffffffc0202bc2 <default_check+0x5a2>
ffffffffc0202888:	4589                	li	a1,2
ffffffffc020288a:	d52fe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc020288e:	4585                	li	a1,1
ffffffffc0202890:	8562                	mv	a0,s8
ffffffffc0202892:	d4afe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0202896:	4515                	li	a0,5
ffffffffc0202898:	cb2fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc020289c:	89aa                	mv	s3,a0
ffffffffc020289e:	48050263          	beqz	a0,ffffffffc0202d22 <default_check+0x702>
ffffffffc02028a2:	4505                	li	a0,1
ffffffffc02028a4:	ca6fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc02028a8:	2c051d63          	bnez	a0,ffffffffc0202b82 <default_check+0x562>
ffffffffc02028ac:	481c                	lw	a5,16(s0)
ffffffffc02028ae:	2a079a63          	bnez	a5,ffffffffc0202b62 <default_check+0x542>
ffffffffc02028b2:	4595                	li	a1,5
ffffffffc02028b4:	854e                	mv	a0,s3
ffffffffc02028b6:	01742823          	sw	s7,16(s0)
ffffffffc02028ba:	01643023          	sd	s6,0(s0)
ffffffffc02028be:	01543423          	sd	s5,8(s0)
ffffffffc02028c2:	d1afe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc02028c6:	641c                	ld	a5,8(s0)
ffffffffc02028c8:	00878963          	beq	a5,s0,ffffffffc02028da <default_check+0x2ba>
ffffffffc02028cc:	ff87a703          	lw	a4,-8(a5)
ffffffffc02028d0:	679c                	ld	a5,8(a5)
ffffffffc02028d2:	397d                	addiw	s2,s2,-1
ffffffffc02028d4:	9c99                	subw	s1,s1,a4
ffffffffc02028d6:	fe879be3          	bne	a5,s0,ffffffffc02028cc <default_check+0x2ac>
ffffffffc02028da:	26091463          	bnez	s2,ffffffffc0202b42 <default_check+0x522>
ffffffffc02028de:	46049263          	bnez	s1,ffffffffc0202d42 <default_check+0x722>
ffffffffc02028e2:	60a6                	ld	ra,72(sp)
ffffffffc02028e4:	6406                	ld	s0,64(sp)
ffffffffc02028e6:	74e2                	ld	s1,56(sp)
ffffffffc02028e8:	7942                	ld	s2,48(sp)
ffffffffc02028ea:	79a2                	ld	s3,40(sp)
ffffffffc02028ec:	7a02                	ld	s4,32(sp)
ffffffffc02028ee:	6ae2                	ld	s5,24(sp)
ffffffffc02028f0:	6b42                	ld	s6,16(sp)
ffffffffc02028f2:	6ba2                	ld	s7,8(sp)
ffffffffc02028f4:	6c02                	ld	s8,0(sp)
ffffffffc02028f6:	6161                	addi	sp,sp,80
ffffffffc02028f8:	8082                	ret
ffffffffc02028fa:	4981                	li	s3,0
ffffffffc02028fc:	4481                	li	s1,0
ffffffffc02028fe:	4901                	li	s2,0
ffffffffc0202900:	b38d                	j	ffffffffc0202662 <default_check+0x42>
ffffffffc0202902:	00006697          	auipc	a3,0x6
ffffffffc0202906:	68e68693          	addi	a3,a3,1678 # ffffffffc0208f90 <commands+0xda8>
ffffffffc020290a:	00006617          	auipc	a2,0x6
ffffffffc020290e:	cee60613          	addi	a2,a2,-786 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202912:	0f000593          	li	a1,240
ffffffffc0202916:	00006517          	auipc	a0,0x6
ffffffffc020291a:	68a50513          	addi	a0,a0,1674 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc020291e:	8ebfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202922:	00006697          	auipc	a3,0x6
ffffffffc0202926:	71668693          	addi	a3,a3,1814 # ffffffffc0209038 <commands+0xe50>
ffffffffc020292a:	00006617          	auipc	a2,0x6
ffffffffc020292e:	cce60613          	addi	a2,a2,-818 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202932:	0bd00593          	li	a1,189
ffffffffc0202936:	00006517          	auipc	a0,0x6
ffffffffc020293a:	66a50513          	addi	a0,a0,1642 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc020293e:	8cbfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202942:	00006697          	auipc	a3,0x6
ffffffffc0202946:	71e68693          	addi	a3,a3,1822 # ffffffffc0209060 <commands+0xe78>
ffffffffc020294a:	00006617          	auipc	a2,0x6
ffffffffc020294e:	cae60613          	addi	a2,a2,-850 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202952:	0be00593          	li	a1,190
ffffffffc0202956:	00006517          	auipc	a0,0x6
ffffffffc020295a:	64a50513          	addi	a0,a0,1610 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc020295e:	8abfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202962:	00006697          	auipc	a3,0x6
ffffffffc0202966:	73e68693          	addi	a3,a3,1854 # ffffffffc02090a0 <commands+0xeb8>
ffffffffc020296a:	00006617          	auipc	a2,0x6
ffffffffc020296e:	c8e60613          	addi	a2,a2,-882 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202972:	0c000593          	li	a1,192
ffffffffc0202976:	00006517          	auipc	a0,0x6
ffffffffc020297a:	62a50513          	addi	a0,a0,1578 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc020297e:	88bfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202982:	00006697          	auipc	a3,0x6
ffffffffc0202986:	7a668693          	addi	a3,a3,1958 # ffffffffc0209128 <commands+0xf40>
ffffffffc020298a:	00006617          	auipc	a2,0x6
ffffffffc020298e:	c6e60613          	addi	a2,a2,-914 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202992:	0d900593          	li	a1,217
ffffffffc0202996:	00006517          	auipc	a0,0x6
ffffffffc020299a:	60a50513          	addi	a0,a0,1546 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc020299e:	86bfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02029a2:	00006697          	auipc	a3,0x6
ffffffffc02029a6:	63668693          	addi	a3,a3,1590 # ffffffffc0208fd8 <commands+0xdf0>
ffffffffc02029aa:	00006617          	auipc	a2,0x6
ffffffffc02029ae:	c4e60613          	addi	a2,a2,-946 # ffffffffc02085f8 <commands+0x410>
ffffffffc02029b2:	0d200593          	li	a1,210
ffffffffc02029b6:	00006517          	auipc	a0,0x6
ffffffffc02029ba:	5ea50513          	addi	a0,a0,1514 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc02029be:	84bfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02029c2:	00006697          	auipc	a3,0x6
ffffffffc02029c6:	75668693          	addi	a3,a3,1878 # ffffffffc0209118 <commands+0xf30>
ffffffffc02029ca:	00006617          	auipc	a2,0x6
ffffffffc02029ce:	c2e60613          	addi	a2,a2,-978 # ffffffffc02085f8 <commands+0x410>
ffffffffc02029d2:	0d000593          	li	a1,208
ffffffffc02029d6:	00006517          	auipc	a0,0x6
ffffffffc02029da:	5ca50513          	addi	a0,a0,1482 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc02029de:	82bfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02029e2:	00006697          	auipc	a3,0x6
ffffffffc02029e6:	71e68693          	addi	a3,a3,1822 # ffffffffc0209100 <commands+0xf18>
ffffffffc02029ea:	00006617          	auipc	a2,0x6
ffffffffc02029ee:	c0e60613          	addi	a2,a2,-1010 # ffffffffc02085f8 <commands+0x410>
ffffffffc02029f2:	0cb00593          	li	a1,203
ffffffffc02029f6:	00006517          	auipc	a0,0x6
ffffffffc02029fa:	5aa50513          	addi	a0,a0,1450 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc02029fe:	80bfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a02:	00006697          	auipc	a3,0x6
ffffffffc0202a06:	6de68693          	addi	a3,a3,1758 # ffffffffc02090e0 <commands+0xef8>
ffffffffc0202a0a:	00006617          	auipc	a2,0x6
ffffffffc0202a0e:	bee60613          	addi	a2,a2,-1042 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202a12:	0c200593          	li	a1,194
ffffffffc0202a16:	00006517          	auipc	a0,0x6
ffffffffc0202a1a:	58a50513          	addi	a0,a0,1418 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202a1e:	feafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a22:	00006697          	auipc	a3,0x6
ffffffffc0202a26:	74e68693          	addi	a3,a3,1870 # ffffffffc0209170 <commands+0xf88>
ffffffffc0202a2a:	00006617          	auipc	a2,0x6
ffffffffc0202a2e:	bce60613          	addi	a2,a2,-1074 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202a32:	0f800593          	li	a1,248
ffffffffc0202a36:	00006517          	auipc	a0,0x6
ffffffffc0202a3a:	56a50513          	addi	a0,a0,1386 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202a3e:	fcafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a42:	00006697          	auipc	a3,0x6
ffffffffc0202a46:	71e68693          	addi	a3,a3,1822 # ffffffffc0209160 <commands+0xf78>
ffffffffc0202a4a:	00006617          	auipc	a2,0x6
ffffffffc0202a4e:	bae60613          	addi	a2,a2,-1106 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202a52:	0df00593          	li	a1,223
ffffffffc0202a56:	00006517          	auipc	a0,0x6
ffffffffc0202a5a:	54a50513          	addi	a0,a0,1354 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202a5e:	faafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a62:	00006697          	auipc	a3,0x6
ffffffffc0202a66:	69e68693          	addi	a3,a3,1694 # ffffffffc0209100 <commands+0xf18>
ffffffffc0202a6a:	00006617          	auipc	a2,0x6
ffffffffc0202a6e:	b8e60613          	addi	a2,a2,-1138 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202a72:	0dd00593          	li	a1,221
ffffffffc0202a76:	00006517          	auipc	a0,0x6
ffffffffc0202a7a:	52a50513          	addi	a0,a0,1322 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202a7e:	f8afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a82:	00006697          	auipc	a3,0x6
ffffffffc0202a86:	6be68693          	addi	a3,a3,1726 # ffffffffc0209140 <commands+0xf58>
ffffffffc0202a8a:	00006617          	auipc	a2,0x6
ffffffffc0202a8e:	b6e60613          	addi	a2,a2,-1170 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202a92:	0dc00593          	li	a1,220
ffffffffc0202a96:	00006517          	auipc	a0,0x6
ffffffffc0202a9a:	50a50513          	addi	a0,a0,1290 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202a9e:	f6afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202aa2:	00006697          	auipc	a3,0x6
ffffffffc0202aa6:	53668693          	addi	a3,a3,1334 # ffffffffc0208fd8 <commands+0xdf0>
ffffffffc0202aaa:	00006617          	auipc	a2,0x6
ffffffffc0202aae:	b4e60613          	addi	a2,a2,-1202 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202ab2:	0b900593          	li	a1,185
ffffffffc0202ab6:	00006517          	auipc	a0,0x6
ffffffffc0202aba:	4ea50513          	addi	a0,a0,1258 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202abe:	f4afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ac2:	00006697          	auipc	a3,0x6
ffffffffc0202ac6:	63e68693          	addi	a3,a3,1598 # ffffffffc0209100 <commands+0xf18>
ffffffffc0202aca:	00006617          	auipc	a2,0x6
ffffffffc0202ace:	b2e60613          	addi	a2,a2,-1234 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202ad2:	0d600593          	li	a1,214
ffffffffc0202ad6:	00006517          	auipc	a0,0x6
ffffffffc0202ada:	4ca50513          	addi	a0,a0,1226 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202ade:	f2afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ae2:	00006697          	auipc	a3,0x6
ffffffffc0202ae6:	53668693          	addi	a3,a3,1334 # ffffffffc0209018 <commands+0xe30>
ffffffffc0202aea:	00006617          	auipc	a2,0x6
ffffffffc0202aee:	b0e60613          	addi	a2,a2,-1266 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202af2:	0d400593          	li	a1,212
ffffffffc0202af6:	00006517          	auipc	a0,0x6
ffffffffc0202afa:	4aa50513          	addi	a0,a0,1194 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202afe:	f0afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b02:	00006697          	auipc	a3,0x6
ffffffffc0202b06:	4f668693          	addi	a3,a3,1270 # ffffffffc0208ff8 <commands+0xe10>
ffffffffc0202b0a:	00006617          	auipc	a2,0x6
ffffffffc0202b0e:	aee60613          	addi	a2,a2,-1298 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202b12:	0d300593          	li	a1,211
ffffffffc0202b16:	00006517          	auipc	a0,0x6
ffffffffc0202b1a:	48a50513          	addi	a0,a0,1162 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202b1e:	eeafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b22:	00006697          	auipc	a3,0x6
ffffffffc0202b26:	4f668693          	addi	a3,a3,1270 # ffffffffc0209018 <commands+0xe30>
ffffffffc0202b2a:	00006617          	auipc	a2,0x6
ffffffffc0202b2e:	ace60613          	addi	a2,a2,-1330 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202b32:	0bb00593          	li	a1,187
ffffffffc0202b36:	00006517          	auipc	a0,0x6
ffffffffc0202b3a:	46a50513          	addi	a0,a0,1130 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202b3e:	ecafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b42:	00006697          	auipc	a3,0x6
ffffffffc0202b46:	77e68693          	addi	a3,a3,1918 # ffffffffc02092c0 <commands+0x10d8>
ffffffffc0202b4a:	00006617          	auipc	a2,0x6
ffffffffc0202b4e:	aae60613          	addi	a2,a2,-1362 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202b52:	12500593          	li	a1,293
ffffffffc0202b56:	00006517          	auipc	a0,0x6
ffffffffc0202b5a:	44a50513          	addi	a0,a0,1098 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202b5e:	eaafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b62:	00006697          	auipc	a3,0x6
ffffffffc0202b66:	5fe68693          	addi	a3,a3,1534 # ffffffffc0209160 <commands+0xf78>
ffffffffc0202b6a:	00006617          	auipc	a2,0x6
ffffffffc0202b6e:	a8e60613          	addi	a2,a2,-1394 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202b72:	11a00593          	li	a1,282
ffffffffc0202b76:	00006517          	auipc	a0,0x6
ffffffffc0202b7a:	42a50513          	addi	a0,a0,1066 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202b7e:	e8afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b82:	00006697          	auipc	a3,0x6
ffffffffc0202b86:	57e68693          	addi	a3,a3,1406 # ffffffffc0209100 <commands+0xf18>
ffffffffc0202b8a:	00006617          	auipc	a2,0x6
ffffffffc0202b8e:	a6e60613          	addi	a2,a2,-1426 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202b92:	11800593          	li	a1,280
ffffffffc0202b96:	00006517          	auipc	a0,0x6
ffffffffc0202b9a:	40a50513          	addi	a0,a0,1034 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202b9e:	e6afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ba2:	00006697          	auipc	a3,0x6
ffffffffc0202ba6:	51e68693          	addi	a3,a3,1310 # ffffffffc02090c0 <commands+0xed8>
ffffffffc0202baa:	00006617          	auipc	a2,0x6
ffffffffc0202bae:	a4e60613          	addi	a2,a2,-1458 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202bb2:	0c100593          	li	a1,193
ffffffffc0202bb6:	00006517          	auipc	a0,0x6
ffffffffc0202bba:	3ea50513          	addi	a0,a0,1002 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202bbe:	e4afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202bc2:	00006697          	auipc	a3,0x6
ffffffffc0202bc6:	6be68693          	addi	a3,a3,1726 # ffffffffc0209280 <commands+0x1098>
ffffffffc0202bca:	00006617          	auipc	a2,0x6
ffffffffc0202bce:	a2e60613          	addi	a2,a2,-1490 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202bd2:	11200593          	li	a1,274
ffffffffc0202bd6:	00006517          	auipc	a0,0x6
ffffffffc0202bda:	3ca50513          	addi	a0,a0,970 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202bde:	e2afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202be2:	00006697          	auipc	a3,0x6
ffffffffc0202be6:	67e68693          	addi	a3,a3,1662 # ffffffffc0209260 <commands+0x1078>
ffffffffc0202bea:	00006617          	auipc	a2,0x6
ffffffffc0202bee:	a0e60613          	addi	a2,a2,-1522 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202bf2:	11000593          	li	a1,272
ffffffffc0202bf6:	00006517          	auipc	a0,0x6
ffffffffc0202bfa:	3aa50513          	addi	a0,a0,938 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202bfe:	e0afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c02:	00006697          	auipc	a3,0x6
ffffffffc0202c06:	63668693          	addi	a3,a3,1590 # ffffffffc0209238 <commands+0x1050>
ffffffffc0202c0a:	00006617          	auipc	a2,0x6
ffffffffc0202c0e:	9ee60613          	addi	a2,a2,-1554 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202c12:	10e00593          	li	a1,270
ffffffffc0202c16:	00006517          	auipc	a0,0x6
ffffffffc0202c1a:	38a50513          	addi	a0,a0,906 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202c1e:	deafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c22:	00006697          	auipc	a3,0x6
ffffffffc0202c26:	5ee68693          	addi	a3,a3,1518 # ffffffffc0209210 <commands+0x1028>
ffffffffc0202c2a:	00006617          	auipc	a2,0x6
ffffffffc0202c2e:	9ce60613          	addi	a2,a2,-1586 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202c32:	10d00593          	li	a1,269
ffffffffc0202c36:	00006517          	auipc	a0,0x6
ffffffffc0202c3a:	36a50513          	addi	a0,a0,874 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202c3e:	dcafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c42:	00006697          	auipc	a3,0x6
ffffffffc0202c46:	5be68693          	addi	a3,a3,1470 # ffffffffc0209200 <commands+0x1018>
ffffffffc0202c4a:	00006617          	auipc	a2,0x6
ffffffffc0202c4e:	9ae60613          	addi	a2,a2,-1618 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202c52:	10800593          	li	a1,264
ffffffffc0202c56:	00006517          	auipc	a0,0x6
ffffffffc0202c5a:	34a50513          	addi	a0,a0,842 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202c5e:	daafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c62:	00006697          	auipc	a3,0x6
ffffffffc0202c66:	49e68693          	addi	a3,a3,1182 # ffffffffc0209100 <commands+0xf18>
ffffffffc0202c6a:	00006617          	auipc	a2,0x6
ffffffffc0202c6e:	98e60613          	addi	a2,a2,-1650 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202c72:	10700593          	li	a1,263
ffffffffc0202c76:	00006517          	auipc	a0,0x6
ffffffffc0202c7a:	32a50513          	addi	a0,a0,810 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202c7e:	d8afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c82:	00006697          	auipc	a3,0x6
ffffffffc0202c86:	55e68693          	addi	a3,a3,1374 # ffffffffc02091e0 <commands+0xff8>
ffffffffc0202c8a:	00006617          	auipc	a2,0x6
ffffffffc0202c8e:	96e60613          	addi	a2,a2,-1682 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202c92:	10600593          	li	a1,262
ffffffffc0202c96:	00006517          	auipc	a0,0x6
ffffffffc0202c9a:	30a50513          	addi	a0,a0,778 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202c9e:	d6afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ca2:	00006697          	auipc	a3,0x6
ffffffffc0202ca6:	50e68693          	addi	a3,a3,1294 # ffffffffc02091b0 <commands+0xfc8>
ffffffffc0202caa:	00006617          	auipc	a2,0x6
ffffffffc0202cae:	94e60613          	addi	a2,a2,-1714 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202cb2:	10500593          	li	a1,261
ffffffffc0202cb6:	00006517          	auipc	a0,0x6
ffffffffc0202cba:	2ea50513          	addi	a0,a0,746 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202cbe:	d4afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202cc2:	00006697          	auipc	a3,0x6
ffffffffc0202cc6:	4d668693          	addi	a3,a3,1238 # ffffffffc0209198 <commands+0xfb0>
ffffffffc0202cca:	00006617          	auipc	a2,0x6
ffffffffc0202cce:	92e60613          	addi	a2,a2,-1746 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202cd2:	10400593          	li	a1,260
ffffffffc0202cd6:	00006517          	auipc	a0,0x6
ffffffffc0202cda:	2ca50513          	addi	a0,a0,714 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202cde:	d2afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ce2:	00006697          	auipc	a3,0x6
ffffffffc0202ce6:	41e68693          	addi	a3,a3,1054 # ffffffffc0209100 <commands+0xf18>
ffffffffc0202cea:	00006617          	auipc	a2,0x6
ffffffffc0202cee:	90e60613          	addi	a2,a2,-1778 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202cf2:	0fe00593          	li	a1,254
ffffffffc0202cf6:	00006517          	auipc	a0,0x6
ffffffffc0202cfa:	2aa50513          	addi	a0,a0,682 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202cfe:	d0afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d02:	00006697          	auipc	a3,0x6
ffffffffc0202d06:	47e68693          	addi	a3,a3,1150 # ffffffffc0209180 <commands+0xf98>
ffffffffc0202d0a:	00006617          	auipc	a2,0x6
ffffffffc0202d0e:	8ee60613          	addi	a2,a2,-1810 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202d12:	0f900593          	li	a1,249
ffffffffc0202d16:	00006517          	auipc	a0,0x6
ffffffffc0202d1a:	28a50513          	addi	a0,a0,650 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202d1e:	ceafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d22:	00006697          	auipc	a3,0x6
ffffffffc0202d26:	57e68693          	addi	a3,a3,1406 # ffffffffc02092a0 <commands+0x10b8>
ffffffffc0202d2a:	00006617          	auipc	a2,0x6
ffffffffc0202d2e:	8ce60613          	addi	a2,a2,-1842 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202d32:	11700593          	li	a1,279
ffffffffc0202d36:	00006517          	auipc	a0,0x6
ffffffffc0202d3a:	26a50513          	addi	a0,a0,618 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202d3e:	ccafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d42:	00006697          	auipc	a3,0x6
ffffffffc0202d46:	58e68693          	addi	a3,a3,1422 # ffffffffc02092d0 <commands+0x10e8>
ffffffffc0202d4a:	00006617          	auipc	a2,0x6
ffffffffc0202d4e:	8ae60613          	addi	a2,a2,-1874 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202d52:	12600593          	li	a1,294
ffffffffc0202d56:	00006517          	auipc	a0,0x6
ffffffffc0202d5a:	24a50513          	addi	a0,a0,586 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202d5e:	caafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d62:	00006697          	auipc	a3,0x6
ffffffffc0202d66:	25668693          	addi	a3,a3,598 # ffffffffc0208fb8 <commands+0xdd0>
ffffffffc0202d6a:	00006617          	auipc	a2,0x6
ffffffffc0202d6e:	88e60613          	addi	a2,a2,-1906 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202d72:	0f300593          	li	a1,243
ffffffffc0202d76:	00006517          	auipc	a0,0x6
ffffffffc0202d7a:	22a50513          	addi	a0,a0,554 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202d7e:	c8afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d82:	00006697          	auipc	a3,0x6
ffffffffc0202d86:	27668693          	addi	a3,a3,630 # ffffffffc0208ff8 <commands+0xe10>
ffffffffc0202d8a:	00006617          	auipc	a2,0x6
ffffffffc0202d8e:	86e60613          	addi	a2,a2,-1938 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202d92:	0ba00593          	li	a1,186
ffffffffc0202d96:	00006517          	auipc	a0,0x6
ffffffffc0202d9a:	20a50513          	addi	a0,a0,522 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202d9e:	c6afd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0202da2 <default_free_pages>:
ffffffffc0202da2:	1141                	addi	sp,sp,-16
ffffffffc0202da4:	e406                	sd	ra,8(sp)
ffffffffc0202da6:	12058f63          	beqz	a1,ffffffffc0202ee4 <default_free_pages+0x142>
ffffffffc0202daa:	00659693          	slli	a3,a1,0x6
ffffffffc0202dae:	96aa                	add	a3,a3,a0
ffffffffc0202db0:	87aa                	mv	a5,a0
ffffffffc0202db2:	02d50263          	beq	a0,a3,ffffffffc0202dd6 <default_free_pages+0x34>
ffffffffc0202db6:	6798                	ld	a4,8(a5)
ffffffffc0202db8:	8b05                	andi	a4,a4,1
ffffffffc0202dba:	10071563          	bnez	a4,ffffffffc0202ec4 <default_free_pages+0x122>
ffffffffc0202dbe:	6798                	ld	a4,8(a5)
ffffffffc0202dc0:	8b09                	andi	a4,a4,2
ffffffffc0202dc2:	10071163          	bnez	a4,ffffffffc0202ec4 <default_free_pages+0x122>
ffffffffc0202dc6:	0007b423          	sd	zero,8(a5)
ffffffffc0202dca:	0007a023          	sw	zero,0(a5)
ffffffffc0202dce:	04078793          	addi	a5,a5,64
ffffffffc0202dd2:	fed792e3          	bne	a5,a3,ffffffffc0202db6 <default_free_pages+0x14>
ffffffffc0202dd6:	2581                	sext.w	a1,a1
ffffffffc0202dd8:	c90c                	sw	a1,16(a0)
ffffffffc0202dda:	00850893          	addi	a7,a0,8
ffffffffc0202dde:	4789                	li	a5,2
ffffffffc0202de0:	40f8b02f          	amoor.d	zero,a5,(a7)
ffffffffc0202de4:	00017697          	auipc	a3,0x17
ffffffffc0202de8:	84c68693          	addi	a3,a3,-1972 # ffffffffc0219630 <free_area>
ffffffffc0202dec:	4a98                	lw	a4,16(a3)
ffffffffc0202dee:	669c                	ld	a5,8(a3)
ffffffffc0202df0:	01850613          	addi	a2,a0,24
ffffffffc0202df4:	9db9                	addw	a1,a1,a4
ffffffffc0202df6:	ca8c                	sw	a1,16(a3)
ffffffffc0202df8:	08d78f63          	beq	a5,a3,ffffffffc0202e96 <default_free_pages+0xf4>
ffffffffc0202dfc:	fe878713          	addi	a4,a5,-24
ffffffffc0202e00:	0006b803          	ld	a6,0(a3)
ffffffffc0202e04:	4581                	li	a1,0
ffffffffc0202e06:	00e56a63          	bltu	a0,a4,ffffffffc0202e1a <default_free_pages+0x78>
ffffffffc0202e0a:	6798                	ld	a4,8(a5)
ffffffffc0202e0c:	04d70a63          	beq	a4,a3,ffffffffc0202e60 <default_free_pages+0xbe>
ffffffffc0202e10:	87ba                	mv	a5,a4
ffffffffc0202e12:	fe878713          	addi	a4,a5,-24
ffffffffc0202e16:	fee57ae3          	bgeu	a0,a4,ffffffffc0202e0a <default_free_pages+0x68>
ffffffffc0202e1a:	c199                	beqz	a1,ffffffffc0202e20 <default_free_pages+0x7e>
ffffffffc0202e1c:	0106b023          	sd	a6,0(a3)
ffffffffc0202e20:	6398                	ld	a4,0(a5)
ffffffffc0202e22:	e390                	sd	a2,0(a5)
ffffffffc0202e24:	e710                	sd	a2,8(a4)
ffffffffc0202e26:	f11c                	sd	a5,32(a0)
ffffffffc0202e28:	ed18                	sd	a4,24(a0)
ffffffffc0202e2a:	00d70c63          	beq	a4,a3,ffffffffc0202e42 <default_free_pages+0xa0>
ffffffffc0202e2e:	ff872583          	lw	a1,-8(a4) # ff8 <kern_entry-0xffffffffc01ff008>
ffffffffc0202e32:	fe870613          	addi	a2,a4,-24
ffffffffc0202e36:	02059793          	slli	a5,a1,0x20
ffffffffc0202e3a:	83e9                	srli	a5,a5,0x1a
ffffffffc0202e3c:	97b2                	add	a5,a5,a2
ffffffffc0202e3e:	02f50b63          	beq	a0,a5,ffffffffc0202e74 <default_free_pages+0xd2>
ffffffffc0202e42:	7118                	ld	a4,32(a0)
ffffffffc0202e44:	00d70b63          	beq	a4,a3,ffffffffc0202e5a <default_free_pages+0xb8>
ffffffffc0202e48:	4910                	lw	a2,16(a0)
ffffffffc0202e4a:	fe870693          	addi	a3,a4,-24
ffffffffc0202e4e:	02061793          	slli	a5,a2,0x20
ffffffffc0202e52:	83e9                	srli	a5,a5,0x1a
ffffffffc0202e54:	97aa                	add	a5,a5,a0
ffffffffc0202e56:	04f68763          	beq	a3,a5,ffffffffc0202ea4 <default_free_pages+0x102>
ffffffffc0202e5a:	60a2                	ld	ra,8(sp)
ffffffffc0202e5c:	0141                	addi	sp,sp,16
ffffffffc0202e5e:	8082                	ret
ffffffffc0202e60:	e790                	sd	a2,8(a5)
ffffffffc0202e62:	f114                	sd	a3,32(a0)
ffffffffc0202e64:	6798                	ld	a4,8(a5)
ffffffffc0202e66:	ed1c                	sd	a5,24(a0)
ffffffffc0202e68:	02d70463          	beq	a4,a3,ffffffffc0202e90 <default_free_pages+0xee>
ffffffffc0202e6c:	8832                	mv	a6,a2
ffffffffc0202e6e:	4585                	li	a1,1
ffffffffc0202e70:	87ba                	mv	a5,a4
ffffffffc0202e72:	b745                	j	ffffffffc0202e12 <default_free_pages+0x70>
ffffffffc0202e74:	491c                	lw	a5,16(a0)
ffffffffc0202e76:	9dbd                	addw	a1,a1,a5
ffffffffc0202e78:	feb72c23          	sw	a1,-8(a4)
ffffffffc0202e7c:	57f5                	li	a5,-3
ffffffffc0202e7e:	60f8b02f          	amoand.d	zero,a5,(a7)
ffffffffc0202e82:	6d0c                	ld	a1,24(a0)
ffffffffc0202e84:	711c                	ld	a5,32(a0)
ffffffffc0202e86:	8532                	mv	a0,a2
ffffffffc0202e88:	e59c                	sd	a5,8(a1)
ffffffffc0202e8a:	6718                	ld	a4,8(a4)
ffffffffc0202e8c:	e38c                	sd	a1,0(a5)
ffffffffc0202e8e:	bf5d                	j	ffffffffc0202e44 <default_free_pages+0xa2>
ffffffffc0202e90:	e290                	sd	a2,0(a3)
ffffffffc0202e92:	873e                	mv	a4,a5
ffffffffc0202e94:	bf69                	j	ffffffffc0202e2e <default_free_pages+0x8c>
ffffffffc0202e96:	60a2                	ld	ra,8(sp)
ffffffffc0202e98:	e390                	sd	a2,0(a5)
ffffffffc0202e9a:	e790                	sd	a2,8(a5)
ffffffffc0202e9c:	f11c                	sd	a5,32(a0)
ffffffffc0202e9e:	ed1c                	sd	a5,24(a0)
ffffffffc0202ea0:	0141                	addi	sp,sp,16
ffffffffc0202ea2:	8082                	ret
ffffffffc0202ea4:	ff872783          	lw	a5,-8(a4)
ffffffffc0202ea8:	ff070693          	addi	a3,a4,-16
ffffffffc0202eac:	9e3d                	addw	a2,a2,a5
ffffffffc0202eae:	c910                	sw	a2,16(a0)
ffffffffc0202eb0:	57f5                	li	a5,-3
ffffffffc0202eb2:	60f6b02f          	amoand.d	zero,a5,(a3)
ffffffffc0202eb6:	6314                	ld	a3,0(a4)
ffffffffc0202eb8:	671c                	ld	a5,8(a4)
ffffffffc0202eba:	60a2                	ld	ra,8(sp)
ffffffffc0202ebc:	e69c                	sd	a5,8(a3)
ffffffffc0202ebe:	e394                	sd	a3,0(a5)
ffffffffc0202ec0:	0141                	addi	sp,sp,16
ffffffffc0202ec2:	8082                	ret
ffffffffc0202ec4:	00006697          	auipc	a3,0x6
ffffffffc0202ec8:	42468693          	addi	a3,a3,1060 # ffffffffc02092e8 <commands+0x1100>
ffffffffc0202ecc:	00005617          	auipc	a2,0x5
ffffffffc0202ed0:	72c60613          	addi	a2,a2,1836 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202ed4:	08300593          	li	a1,131
ffffffffc0202ed8:	00006517          	auipc	a0,0x6
ffffffffc0202edc:	0c850513          	addi	a0,a0,200 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202ee0:	b28fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ee4:	00006697          	auipc	a3,0x6
ffffffffc0202ee8:	3fc68693          	addi	a3,a3,1020 # ffffffffc02092e0 <commands+0x10f8>
ffffffffc0202eec:	00005617          	auipc	a2,0x5
ffffffffc0202ef0:	70c60613          	addi	a2,a2,1804 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202ef4:	08000593          	li	a1,128
ffffffffc0202ef8:	00006517          	auipc	a0,0x6
ffffffffc0202efc:	0a850513          	addi	a0,a0,168 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202f00:	b08fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0202f04 <default_alloc_pages>:
ffffffffc0202f04:	c941                	beqz	a0,ffffffffc0202f94 <default_alloc_pages+0x90>
ffffffffc0202f06:	00016597          	auipc	a1,0x16
ffffffffc0202f0a:	72a58593          	addi	a1,a1,1834 # ffffffffc0219630 <free_area>
ffffffffc0202f0e:	0105a803          	lw	a6,16(a1)
ffffffffc0202f12:	872a                	mv	a4,a0
ffffffffc0202f14:	02081793          	slli	a5,a6,0x20
ffffffffc0202f18:	9381                	srli	a5,a5,0x20
ffffffffc0202f1a:	00a7ee63          	bltu	a5,a0,ffffffffc0202f36 <default_alloc_pages+0x32>
ffffffffc0202f1e:	87ae                	mv	a5,a1
ffffffffc0202f20:	a801                	j	ffffffffc0202f30 <default_alloc_pages+0x2c>
ffffffffc0202f22:	ff87a683          	lw	a3,-8(a5)
ffffffffc0202f26:	02069613          	slli	a2,a3,0x20
ffffffffc0202f2a:	9201                	srli	a2,a2,0x20
ffffffffc0202f2c:	00e67763          	bgeu	a2,a4,ffffffffc0202f3a <default_alloc_pages+0x36>
ffffffffc0202f30:	679c                	ld	a5,8(a5)
ffffffffc0202f32:	feb798e3          	bne	a5,a1,ffffffffc0202f22 <default_alloc_pages+0x1e>
ffffffffc0202f36:	4501                	li	a0,0
ffffffffc0202f38:	8082                	ret
ffffffffc0202f3a:	0007b883          	ld	a7,0(a5)
ffffffffc0202f3e:	0087b303          	ld	t1,8(a5)
ffffffffc0202f42:	fe878513          	addi	a0,a5,-24
ffffffffc0202f46:	00070e1b          	sext.w	t3,a4
ffffffffc0202f4a:	0068b423          	sd	t1,8(a7)
ffffffffc0202f4e:	01133023          	sd	a7,0(t1)
ffffffffc0202f52:	02c77863          	bgeu	a4,a2,ffffffffc0202f82 <default_alloc_pages+0x7e>
ffffffffc0202f56:	071a                	slli	a4,a4,0x6
ffffffffc0202f58:	972a                	add	a4,a4,a0
ffffffffc0202f5a:	41c686bb          	subw	a3,a3,t3
ffffffffc0202f5e:	cb14                	sw	a3,16(a4)
ffffffffc0202f60:	00870613          	addi	a2,a4,8
ffffffffc0202f64:	4689                	li	a3,2
ffffffffc0202f66:	40d6302f          	amoor.d	zero,a3,(a2)
ffffffffc0202f6a:	0088b683          	ld	a3,8(a7)
ffffffffc0202f6e:	01870613          	addi	a2,a4,24
ffffffffc0202f72:	0105a803          	lw	a6,16(a1)
ffffffffc0202f76:	e290                	sd	a2,0(a3)
ffffffffc0202f78:	00c8b423          	sd	a2,8(a7)
ffffffffc0202f7c:	f314                	sd	a3,32(a4)
ffffffffc0202f7e:	01173c23          	sd	a7,24(a4)
ffffffffc0202f82:	41c8083b          	subw	a6,a6,t3
ffffffffc0202f86:	0105a823          	sw	a6,16(a1)
ffffffffc0202f8a:	5775                	li	a4,-3
ffffffffc0202f8c:	17c1                	addi	a5,a5,-16
ffffffffc0202f8e:	60e7b02f          	amoand.d	zero,a4,(a5)
ffffffffc0202f92:	8082                	ret
ffffffffc0202f94:	1141                	addi	sp,sp,-16
ffffffffc0202f96:	00006697          	auipc	a3,0x6
ffffffffc0202f9a:	34a68693          	addi	a3,a3,842 # ffffffffc02092e0 <commands+0x10f8>
ffffffffc0202f9e:	00005617          	auipc	a2,0x5
ffffffffc0202fa2:	65a60613          	addi	a2,a2,1626 # ffffffffc02085f8 <commands+0x410>
ffffffffc0202fa6:	06200593          	li	a1,98
ffffffffc0202faa:	00006517          	auipc	a0,0x6
ffffffffc0202fae:	ff650513          	addi	a0,a0,-10 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0202fb2:	e406                	sd	ra,8(sp)
ffffffffc0202fb4:	a54fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0202fb8 <default_init_memmap>:
ffffffffc0202fb8:	1141                	addi	sp,sp,-16
ffffffffc0202fba:	e406                	sd	ra,8(sp)
ffffffffc0202fbc:	c5f1                	beqz	a1,ffffffffc0203088 <default_init_memmap+0xd0>
ffffffffc0202fbe:	00659693          	slli	a3,a1,0x6
ffffffffc0202fc2:	96aa                	add	a3,a3,a0
ffffffffc0202fc4:	87aa                	mv	a5,a0
ffffffffc0202fc6:	00d50f63          	beq	a0,a3,ffffffffc0202fe4 <default_init_memmap+0x2c>
ffffffffc0202fca:	6798                	ld	a4,8(a5)
ffffffffc0202fcc:	8b05                	andi	a4,a4,1
ffffffffc0202fce:	cf49                	beqz	a4,ffffffffc0203068 <default_init_memmap+0xb0>
ffffffffc0202fd0:	0007a823          	sw	zero,16(a5)
ffffffffc0202fd4:	0007b423          	sd	zero,8(a5)
ffffffffc0202fd8:	0007a023          	sw	zero,0(a5)
ffffffffc0202fdc:	04078793          	addi	a5,a5,64
ffffffffc0202fe0:	fed795e3          	bne	a5,a3,ffffffffc0202fca <default_init_memmap+0x12>
ffffffffc0202fe4:	2581                	sext.w	a1,a1
ffffffffc0202fe6:	c90c                	sw	a1,16(a0)
ffffffffc0202fe8:	4789                	li	a5,2
ffffffffc0202fea:	00850713          	addi	a4,a0,8
ffffffffc0202fee:	40f7302f          	amoor.d	zero,a5,(a4)
ffffffffc0202ff2:	00016697          	auipc	a3,0x16
ffffffffc0202ff6:	63e68693          	addi	a3,a3,1598 # ffffffffc0219630 <free_area>
ffffffffc0202ffa:	4a98                	lw	a4,16(a3)
ffffffffc0202ffc:	669c                	ld	a5,8(a3)
ffffffffc0202ffe:	01850613          	addi	a2,a0,24
ffffffffc0203002:	9db9                	addw	a1,a1,a4
ffffffffc0203004:	ca8c                	sw	a1,16(a3)
ffffffffc0203006:	04d78a63          	beq	a5,a3,ffffffffc020305a <default_init_memmap+0xa2>
ffffffffc020300a:	fe878713          	addi	a4,a5,-24
ffffffffc020300e:	0006b803          	ld	a6,0(a3)
ffffffffc0203012:	4581                	li	a1,0
ffffffffc0203014:	00e56a63          	bltu	a0,a4,ffffffffc0203028 <default_init_memmap+0x70>
ffffffffc0203018:	6798                	ld	a4,8(a5)
ffffffffc020301a:	02d70263          	beq	a4,a3,ffffffffc020303e <default_init_memmap+0x86>
ffffffffc020301e:	87ba                	mv	a5,a4
ffffffffc0203020:	fe878713          	addi	a4,a5,-24
ffffffffc0203024:	fee57ae3          	bgeu	a0,a4,ffffffffc0203018 <default_init_memmap+0x60>
ffffffffc0203028:	c199                	beqz	a1,ffffffffc020302e <default_init_memmap+0x76>
ffffffffc020302a:	0106b023          	sd	a6,0(a3)
ffffffffc020302e:	6398                	ld	a4,0(a5)
ffffffffc0203030:	60a2                	ld	ra,8(sp)
ffffffffc0203032:	e390                	sd	a2,0(a5)
ffffffffc0203034:	e710                	sd	a2,8(a4)
ffffffffc0203036:	f11c                	sd	a5,32(a0)
ffffffffc0203038:	ed18                	sd	a4,24(a0)
ffffffffc020303a:	0141                	addi	sp,sp,16
ffffffffc020303c:	8082                	ret
ffffffffc020303e:	e790                	sd	a2,8(a5)
ffffffffc0203040:	f114                	sd	a3,32(a0)
ffffffffc0203042:	6798                	ld	a4,8(a5)
ffffffffc0203044:	ed1c                	sd	a5,24(a0)
ffffffffc0203046:	00d70663          	beq	a4,a3,ffffffffc0203052 <default_init_memmap+0x9a>
ffffffffc020304a:	8832                	mv	a6,a2
ffffffffc020304c:	4585                	li	a1,1
ffffffffc020304e:	87ba                	mv	a5,a4
ffffffffc0203050:	bfc1                	j	ffffffffc0203020 <default_init_memmap+0x68>
ffffffffc0203052:	60a2                	ld	ra,8(sp)
ffffffffc0203054:	e290                	sd	a2,0(a3)
ffffffffc0203056:	0141                	addi	sp,sp,16
ffffffffc0203058:	8082                	ret
ffffffffc020305a:	60a2                	ld	ra,8(sp)
ffffffffc020305c:	e390                	sd	a2,0(a5)
ffffffffc020305e:	e790                	sd	a2,8(a5)
ffffffffc0203060:	f11c                	sd	a5,32(a0)
ffffffffc0203062:	ed1c                	sd	a5,24(a0)
ffffffffc0203064:	0141                	addi	sp,sp,16
ffffffffc0203066:	8082                	ret
ffffffffc0203068:	00006697          	auipc	a3,0x6
ffffffffc020306c:	2a868693          	addi	a3,a3,680 # ffffffffc0209310 <commands+0x1128>
ffffffffc0203070:	00005617          	auipc	a2,0x5
ffffffffc0203074:	58860613          	addi	a2,a2,1416 # ffffffffc02085f8 <commands+0x410>
ffffffffc0203078:	04900593          	li	a1,73
ffffffffc020307c:	00006517          	auipc	a0,0x6
ffffffffc0203080:	f2450513          	addi	a0,a0,-220 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc0203084:	984fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203088:	00006697          	auipc	a3,0x6
ffffffffc020308c:	25868693          	addi	a3,a3,600 # ffffffffc02092e0 <commands+0x10f8>
ffffffffc0203090:	00005617          	auipc	a2,0x5
ffffffffc0203094:	56860613          	addi	a2,a2,1384 # ffffffffc02085f8 <commands+0x410>
ffffffffc0203098:	04600593          	li	a1,70
ffffffffc020309c:	00006517          	auipc	a0,0x6
ffffffffc02030a0:	f0450513          	addi	a0,a0,-252 # ffffffffc0208fa0 <commands+0xdb8>
ffffffffc02030a4:	964fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02030a8 <wait_queue_del.part.0>:
ffffffffc02030a8:	1141                	addi	sp,sp,-16
ffffffffc02030aa:	00006697          	auipc	a3,0x6
ffffffffc02030ae:	2c668693          	addi	a3,a3,710 # ffffffffc0209370 <default_pmm_manager+0x38>
ffffffffc02030b2:	00005617          	auipc	a2,0x5
ffffffffc02030b6:	54660613          	addi	a2,a2,1350 # ffffffffc02085f8 <commands+0x410>
ffffffffc02030ba:	45f1                	li	a1,28
ffffffffc02030bc:	00006517          	auipc	a0,0x6
ffffffffc02030c0:	2f450513          	addi	a0,a0,756 # ffffffffc02093b0 <default_pmm_manager+0x78>
ffffffffc02030c4:	e406                	sd	ra,8(sp)
ffffffffc02030c6:	942fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02030ca <wait_queue_init>:
ffffffffc02030ca:	e508                	sd	a0,8(a0)
ffffffffc02030cc:	e108                	sd	a0,0(a0)
ffffffffc02030ce:	8082                	ret

ffffffffc02030d0 <wait_queue_del>:
ffffffffc02030d0:	7198                	ld	a4,32(a1)
ffffffffc02030d2:	01858793          	addi	a5,a1,24
ffffffffc02030d6:	00e78b63          	beq	a5,a4,ffffffffc02030ec <wait_queue_del+0x1c>
ffffffffc02030da:	6994                	ld	a3,16(a1)
ffffffffc02030dc:	00a69863          	bne	a3,a0,ffffffffc02030ec <wait_queue_del+0x1c>
ffffffffc02030e0:	6d94                	ld	a3,24(a1)
ffffffffc02030e2:	e698                	sd	a4,8(a3)
ffffffffc02030e4:	e314                	sd	a3,0(a4)
ffffffffc02030e6:	f19c                	sd	a5,32(a1)
ffffffffc02030e8:	ed9c                	sd	a5,24(a1)
ffffffffc02030ea:	8082                	ret
ffffffffc02030ec:	1141                	addi	sp,sp,-16
ffffffffc02030ee:	e406                	sd	ra,8(sp)
ffffffffc02030f0:	fb9ff0ef          	jal	ra,ffffffffc02030a8 <wait_queue_del.part.0>

ffffffffc02030f4 <wait_queue_first>:
ffffffffc02030f4:	651c                	ld	a5,8(a0)
ffffffffc02030f6:	00f50563          	beq	a0,a5,ffffffffc0203100 <wait_queue_first+0xc>
ffffffffc02030fa:	fe878513          	addi	a0,a5,-24
ffffffffc02030fe:	8082                	ret
ffffffffc0203100:	4501                	li	a0,0
ffffffffc0203102:	8082                	ret

ffffffffc0203104 <wait_in_queue>:
ffffffffc0203104:	711c                	ld	a5,32(a0)
ffffffffc0203106:	0561                	addi	a0,a0,24
ffffffffc0203108:	40a78533          	sub	a0,a5,a0
ffffffffc020310c:	00a03533          	snez	a0,a0
ffffffffc0203110:	8082                	ret

ffffffffc0203112 <wakeup_wait>:
ffffffffc0203112:	ce91                	beqz	a3,ffffffffc020312e <wakeup_wait+0x1c>
ffffffffc0203114:	7198                	ld	a4,32(a1)
ffffffffc0203116:	01858793          	addi	a5,a1,24
ffffffffc020311a:	00e78e63          	beq	a5,a4,ffffffffc0203136 <wakeup_wait+0x24>
ffffffffc020311e:	6994                	ld	a3,16(a1)
ffffffffc0203120:	00d51b63          	bne	a0,a3,ffffffffc0203136 <wakeup_wait+0x24>
ffffffffc0203124:	6d94                	ld	a3,24(a1)
ffffffffc0203126:	e698                	sd	a4,8(a3)
ffffffffc0203128:	e314                	sd	a3,0(a4)
ffffffffc020312a:	f19c                	sd	a5,32(a1)
ffffffffc020312c:	ed9c                	sd	a5,24(a1)
ffffffffc020312e:	6188                	ld	a0,0(a1)
ffffffffc0203130:	c590                	sw	a2,8(a1)
ffffffffc0203132:	0ad0106f          	j	ffffffffc02049de <wakeup_proc>
ffffffffc0203136:	1141                	addi	sp,sp,-16
ffffffffc0203138:	e406                	sd	ra,8(sp)
ffffffffc020313a:	f6fff0ef          	jal	ra,ffffffffc02030a8 <wait_queue_del.part.0>

ffffffffc020313e <wait_current_set>:
ffffffffc020313e:	00016797          	auipc	a5,0x16
ffffffffc0203142:	3ba7b783          	ld	a5,954(a5) # ffffffffc02194f8 <current>
ffffffffc0203146:	c39d                	beqz	a5,ffffffffc020316c <wait_current_set+0x2e>
ffffffffc0203148:	01858713          	addi	a4,a1,24
ffffffffc020314c:	800006b7          	lui	a3,0x80000
ffffffffc0203150:	ed98                	sd	a4,24(a1)
ffffffffc0203152:	e19c                	sd	a5,0(a1)
ffffffffc0203154:	c594                	sw	a3,8(a1)
ffffffffc0203156:	4685                	li	a3,1
ffffffffc0203158:	c394                	sw	a3,0(a5)
ffffffffc020315a:	0ec7a623          	sw	a2,236(a5)
ffffffffc020315e:	611c                	ld	a5,0(a0)
ffffffffc0203160:	e988                	sd	a0,16(a1)
ffffffffc0203162:	e118                	sd	a4,0(a0)
ffffffffc0203164:	e798                	sd	a4,8(a5)
ffffffffc0203166:	f188                	sd	a0,32(a1)
ffffffffc0203168:	ed9c                	sd	a5,24(a1)
ffffffffc020316a:	8082                	ret
ffffffffc020316c:	1141                	addi	sp,sp,-16
ffffffffc020316e:	00006697          	auipc	a3,0x6
ffffffffc0203172:	25a68693          	addi	a3,a3,602 # ffffffffc02093c8 <default_pmm_manager+0x90>
ffffffffc0203176:	00005617          	auipc	a2,0x5
ffffffffc020317a:	48260613          	addi	a2,a2,1154 # ffffffffc02085f8 <commands+0x410>
ffffffffc020317e:	07400593          	li	a1,116
ffffffffc0203182:	00006517          	auipc	a0,0x6
ffffffffc0203186:	22e50513          	addi	a0,a0,558 # ffffffffc02093b0 <default_pmm_manager+0x78>
ffffffffc020318a:	e406                	sd	ra,8(sp)
ffffffffc020318c:	87cfd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203190 <__down.constprop.0>:
ffffffffc0203190:	715d                	addi	sp,sp,-80
ffffffffc0203192:	e0a2                	sd	s0,64(sp)
ffffffffc0203194:	e486                	sd	ra,72(sp)
ffffffffc0203196:	fc26                	sd	s1,56(sp)
ffffffffc0203198:	842a                	mv	s0,a0
ffffffffc020319a:	100027f3          	csrr	a5,sstatus
ffffffffc020319e:	8b89                	andi	a5,a5,2
ffffffffc02031a0:	ebb1                	bnez	a5,ffffffffc02031f4 <__down.constprop.0+0x64>
ffffffffc02031a2:	411c                	lw	a5,0(a0)
ffffffffc02031a4:	00f05a63          	blez	a5,ffffffffc02031b8 <__down.constprop.0+0x28>
ffffffffc02031a8:	37fd                	addiw	a5,a5,-1
ffffffffc02031aa:	c11c                	sw	a5,0(a0)
ffffffffc02031ac:	4501                	li	a0,0
ffffffffc02031ae:	60a6                	ld	ra,72(sp)
ffffffffc02031b0:	6406                	ld	s0,64(sp)
ffffffffc02031b2:	74e2                	ld	s1,56(sp)
ffffffffc02031b4:	6161                	addi	sp,sp,80
ffffffffc02031b6:	8082                	ret
ffffffffc02031b8:	00850413          	addi	s0,a0,8
ffffffffc02031bc:	0024                	addi	s1,sp,8
ffffffffc02031be:	10000613          	li	a2,256
ffffffffc02031c2:	85a6                	mv	a1,s1
ffffffffc02031c4:	8522                	mv	a0,s0
ffffffffc02031c6:	f79ff0ef          	jal	ra,ffffffffc020313e <wait_current_set>
ffffffffc02031ca:	0c7010ef          	jal	ra,ffffffffc0204a90 <schedule>
ffffffffc02031ce:	100027f3          	csrr	a5,sstatus
ffffffffc02031d2:	8b89                	andi	a5,a5,2
ffffffffc02031d4:	efb9                	bnez	a5,ffffffffc0203232 <__down.constprop.0+0xa2>
ffffffffc02031d6:	8526                	mv	a0,s1
ffffffffc02031d8:	f2dff0ef          	jal	ra,ffffffffc0203104 <wait_in_queue>
ffffffffc02031dc:	e531                	bnez	a0,ffffffffc0203228 <__down.constprop.0+0x98>
ffffffffc02031de:	4542                	lw	a0,16(sp)
ffffffffc02031e0:	10000793          	li	a5,256
ffffffffc02031e4:	fcf515e3          	bne	a0,a5,ffffffffc02031ae <__down.constprop.0+0x1e>
ffffffffc02031e8:	60a6                	ld	ra,72(sp)
ffffffffc02031ea:	6406                	ld	s0,64(sp)
ffffffffc02031ec:	74e2                	ld	s1,56(sp)
ffffffffc02031ee:	4501                	li	a0,0
ffffffffc02031f0:	6161                	addi	sp,sp,80
ffffffffc02031f2:	8082                	ret
ffffffffc02031f4:	c44fd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02031f8:	401c                	lw	a5,0(s0)
ffffffffc02031fa:	00f05c63          	blez	a5,ffffffffc0203212 <__down.constprop.0+0x82>
ffffffffc02031fe:	37fd                	addiw	a5,a5,-1
ffffffffc0203200:	c01c                	sw	a5,0(s0)
ffffffffc0203202:	c30fd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203206:	60a6                	ld	ra,72(sp)
ffffffffc0203208:	6406                	ld	s0,64(sp)
ffffffffc020320a:	74e2                	ld	s1,56(sp)
ffffffffc020320c:	4501                	li	a0,0
ffffffffc020320e:	6161                	addi	sp,sp,80
ffffffffc0203210:	8082                	ret
ffffffffc0203212:	0421                	addi	s0,s0,8
ffffffffc0203214:	0024                	addi	s1,sp,8
ffffffffc0203216:	10000613          	li	a2,256
ffffffffc020321a:	85a6                	mv	a1,s1
ffffffffc020321c:	8522                	mv	a0,s0
ffffffffc020321e:	f21ff0ef          	jal	ra,ffffffffc020313e <wait_current_set>
ffffffffc0203222:	c10fd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203226:	b755                	j	ffffffffc02031ca <__down.constprop.0+0x3a>
ffffffffc0203228:	85a6                	mv	a1,s1
ffffffffc020322a:	8522                	mv	a0,s0
ffffffffc020322c:	ea5ff0ef          	jal	ra,ffffffffc02030d0 <wait_queue_del>
ffffffffc0203230:	b77d                	j	ffffffffc02031de <__down.constprop.0+0x4e>
ffffffffc0203232:	c06fd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203236:	8526                	mv	a0,s1
ffffffffc0203238:	ecdff0ef          	jal	ra,ffffffffc0203104 <wait_in_queue>
ffffffffc020323c:	e501                	bnez	a0,ffffffffc0203244 <__down.constprop.0+0xb4>
ffffffffc020323e:	bf4fd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203242:	bf71                	j	ffffffffc02031de <__down.constprop.0+0x4e>
ffffffffc0203244:	85a6                	mv	a1,s1
ffffffffc0203246:	8522                	mv	a0,s0
ffffffffc0203248:	e89ff0ef          	jal	ra,ffffffffc02030d0 <wait_queue_del>
ffffffffc020324c:	bfcd                	j	ffffffffc020323e <__down.constprop.0+0xae>

ffffffffc020324e <__up.constprop.0>:
ffffffffc020324e:	1101                	addi	sp,sp,-32
ffffffffc0203250:	e822                	sd	s0,16(sp)
ffffffffc0203252:	ec06                	sd	ra,24(sp)
ffffffffc0203254:	e426                	sd	s1,8(sp)
ffffffffc0203256:	e04a                	sd	s2,0(sp)
ffffffffc0203258:	842a                	mv	s0,a0
ffffffffc020325a:	100027f3          	csrr	a5,sstatus
ffffffffc020325e:	8b89                	andi	a5,a5,2
ffffffffc0203260:	4901                	li	s2,0
ffffffffc0203262:	eba1                	bnez	a5,ffffffffc02032b2 <__up.constprop.0+0x64>
ffffffffc0203264:	00840493          	addi	s1,s0,8
ffffffffc0203268:	8526                	mv	a0,s1
ffffffffc020326a:	e8bff0ef          	jal	ra,ffffffffc02030f4 <wait_queue_first>
ffffffffc020326e:	85aa                	mv	a1,a0
ffffffffc0203270:	cd0d                	beqz	a0,ffffffffc02032aa <__up.constprop.0+0x5c>
ffffffffc0203272:	6118                	ld	a4,0(a0)
ffffffffc0203274:	10000793          	li	a5,256
ffffffffc0203278:	0ec72703          	lw	a4,236(a4)
ffffffffc020327c:	02f71f63          	bne	a4,a5,ffffffffc02032ba <__up.constprop.0+0x6c>
ffffffffc0203280:	4685                	li	a3,1
ffffffffc0203282:	10000613          	li	a2,256
ffffffffc0203286:	8526                	mv	a0,s1
ffffffffc0203288:	e8bff0ef          	jal	ra,ffffffffc0203112 <wakeup_wait>
ffffffffc020328c:	00091863          	bnez	s2,ffffffffc020329c <__up.constprop.0+0x4e>
ffffffffc0203290:	60e2                	ld	ra,24(sp)
ffffffffc0203292:	6442                	ld	s0,16(sp)
ffffffffc0203294:	64a2                	ld	s1,8(sp)
ffffffffc0203296:	6902                	ld	s2,0(sp)
ffffffffc0203298:	6105                	addi	sp,sp,32
ffffffffc020329a:	8082                	ret
ffffffffc020329c:	6442                	ld	s0,16(sp)
ffffffffc020329e:	60e2                	ld	ra,24(sp)
ffffffffc02032a0:	64a2                	ld	s1,8(sp)
ffffffffc02032a2:	6902                	ld	s2,0(sp)
ffffffffc02032a4:	6105                	addi	sp,sp,32
ffffffffc02032a6:	b8cfd06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc02032aa:	401c                	lw	a5,0(s0)
ffffffffc02032ac:	2785                	addiw	a5,a5,1
ffffffffc02032ae:	c01c                	sw	a5,0(s0)
ffffffffc02032b0:	bff1                	j	ffffffffc020328c <__up.constprop.0+0x3e>
ffffffffc02032b2:	b86fd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02032b6:	4905                	li	s2,1
ffffffffc02032b8:	b775                	j	ffffffffc0203264 <__up.constprop.0+0x16>
ffffffffc02032ba:	00006697          	auipc	a3,0x6
ffffffffc02032be:	11e68693          	addi	a3,a3,286 # ffffffffc02093d8 <default_pmm_manager+0xa0>
ffffffffc02032c2:	00005617          	auipc	a2,0x5
ffffffffc02032c6:	33660613          	addi	a2,a2,822 # ffffffffc02085f8 <commands+0x410>
ffffffffc02032ca:	45e5                	li	a1,25
ffffffffc02032cc:	00006517          	auipc	a0,0x6
ffffffffc02032d0:	13450513          	addi	a0,a0,308 # ffffffffc0209400 <default_pmm_manager+0xc8>
ffffffffc02032d4:	f35fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02032d8 <sem_init>:
ffffffffc02032d8:	c10c                	sw	a1,0(a0)
ffffffffc02032da:	0521                	addi	a0,a0,8
ffffffffc02032dc:	defff06f          	j	ffffffffc02030ca <wait_queue_init>

ffffffffc02032e0 <up>:
ffffffffc02032e0:	b7bd                	j	ffffffffc020324e <__up.constprop.0>

ffffffffc02032e2 <down>:
ffffffffc02032e2:	1141                	addi	sp,sp,-16
ffffffffc02032e4:	e406                	sd	ra,8(sp)
ffffffffc02032e6:	eabff0ef          	jal	ra,ffffffffc0203190 <__down.constprop.0>
ffffffffc02032ea:	2501                	sext.w	a0,a0
ffffffffc02032ec:	e501                	bnez	a0,ffffffffc02032f4 <down+0x12>
ffffffffc02032ee:	60a2                	ld	ra,8(sp)
ffffffffc02032f0:	0141                	addi	sp,sp,16
ffffffffc02032f2:	8082                	ret
ffffffffc02032f4:	00006697          	auipc	a3,0x6
ffffffffc02032f8:	11c68693          	addi	a3,a3,284 # ffffffffc0209410 <default_pmm_manager+0xd8>
ffffffffc02032fc:	00005617          	auipc	a2,0x5
ffffffffc0203300:	2fc60613          	addi	a2,a2,764 # ffffffffc02085f8 <commands+0x410>
ffffffffc0203304:	04000593          	li	a1,64
ffffffffc0203308:	00006517          	auipc	a0,0x6
ffffffffc020330c:	0f850513          	addi	a0,a0,248 # ffffffffc0209400 <default_pmm_manager+0xc8>
ffffffffc0203310:	ef9fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203314 <worker1>:
ffffffffc0203314:	7179                	addi	sp,sp,-48
ffffffffc0203316:	4509                	li	a0,2
ffffffffc0203318:	f406                	sd	ra,40(sp)
ffffffffc020331a:	f022                	sd	s0,32(sp)
ffffffffc020331c:	ec26                	sd	s1,24(sp)
ffffffffc020331e:	e84a                	sd	s2,16(sp)
ffffffffc0203320:	e44e                	sd	s3,8(sp)
ffffffffc0203322:	5e6010ef          	jal	ra,ffffffffc0204908 <do_sleep>
ffffffffc0203326:	00016517          	auipc	a0,0x16
ffffffffc020332a:	34250513          	addi	a0,a0,834 # ffffffffc0219668 <mutex>
ffffffffc020332e:	fb5ff0ef          	jal	ra,ffffffffc02032e2 <down>
ffffffffc0203332:	00006517          	auipc	a0,0x6
ffffffffc0203336:	0ee50513          	addi	a0,a0,238 # ffffffffc0209420 <default_pmm_manager+0xe8>
ffffffffc020333a:	d93fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020333e:	00016517          	auipc	a0,0x16
ffffffffc0203342:	36250513          	addi	a0,a0,866 # ffffffffc02196a0 <cond1>
ffffffffc0203346:	1ce000ef          	jal	ra,ffffffffc0203514 <cond_signal>
ffffffffc020334a:	00016517          	auipc	a0,0x16
ffffffffc020334e:	31e50513          	addi	a0,a0,798 # ffffffffc0219668 <mutex>
ffffffffc0203352:	f8fff0ef          	jal	ra,ffffffffc02032e0 <up>
ffffffffc0203356:	00016417          	auipc	s0,0x16
ffffffffc020335a:	31240413          	addi	s0,s0,786 # ffffffffc0219668 <mutex>
ffffffffc020335e:	00016997          	auipc	s3,0x16
ffffffffc0203362:	36a98993          	addi	s3,s3,874 # ffffffffc02196c8 <cond3>
ffffffffc0203366:	00006917          	auipc	s2,0x6
ffffffffc020336a:	0ba90913          	addi	s2,s2,186 # ffffffffc0209420 <default_pmm_manager+0xe8>
ffffffffc020336e:	00016497          	auipc	s1,0x16
ffffffffc0203372:	33248493          	addi	s1,s1,818 # ffffffffc02196a0 <cond1>
ffffffffc0203376:	4509                	li	a0,2
ffffffffc0203378:	590010ef          	jal	ra,ffffffffc0204908 <do_sleep>
ffffffffc020337c:	8522                	mv	a0,s0
ffffffffc020337e:	f65ff0ef          	jal	ra,ffffffffc02032e2 <down>
ffffffffc0203382:	85a2                	mv	a1,s0
ffffffffc0203384:	854e                	mv	a0,s3
ffffffffc0203386:	192000ef          	jal	ra,ffffffffc0203518 <cond_wait>
ffffffffc020338a:	854a                	mv	a0,s2
ffffffffc020338c:	d41fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0203390:	8526                	mv	a0,s1
ffffffffc0203392:	182000ef          	jal	ra,ffffffffc0203514 <cond_signal>
ffffffffc0203396:	8522                	mv	a0,s0
ffffffffc0203398:	f49ff0ef          	jal	ra,ffffffffc02032e0 <up>
ffffffffc020339c:	bfe9                	j	ffffffffc0203376 <worker1+0x62>

ffffffffc020339e <worker2>:
ffffffffc020339e:	7179                	addi	sp,sp,-48
ffffffffc02033a0:	f022                	sd	s0,32(sp)
ffffffffc02033a2:	ec26                	sd	s1,24(sp)
ffffffffc02033a4:	e84a                	sd	s2,16(sp)
ffffffffc02033a6:	e44e                	sd	s3,8(sp)
ffffffffc02033a8:	f406                	sd	ra,40(sp)
ffffffffc02033aa:	00016417          	auipc	s0,0x16
ffffffffc02033ae:	2be40413          	addi	s0,s0,702 # ffffffffc0219668 <mutex>
ffffffffc02033b2:	00016997          	auipc	s3,0x16
ffffffffc02033b6:	2ee98993          	addi	s3,s3,750 # ffffffffc02196a0 <cond1>
ffffffffc02033ba:	00006917          	auipc	s2,0x6
ffffffffc02033be:	07e90913          	addi	s2,s2,126 # ffffffffc0209438 <default_pmm_manager+0x100>
ffffffffc02033c2:	00016497          	auipc	s1,0x16
ffffffffc02033c6:	31e48493          	addi	s1,s1,798 # ffffffffc02196e0 <cond2>
ffffffffc02033ca:	4509                	li	a0,2
ffffffffc02033cc:	53c010ef          	jal	ra,ffffffffc0204908 <do_sleep>
ffffffffc02033d0:	8522                	mv	a0,s0
ffffffffc02033d2:	f11ff0ef          	jal	ra,ffffffffc02032e2 <down>
ffffffffc02033d6:	85a2                	mv	a1,s0
ffffffffc02033d8:	854e                	mv	a0,s3
ffffffffc02033da:	13e000ef          	jal	ra,ffffffffc0203518 <cond_wait>
ffffffffc02033de:	854a                	mv	a0,s2
ffffffffc02033e0:	cedfc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02033e4:	8526                	mv	a0,s1
ffffffffc02033e6:	12e000ef          	jal	ra,ffffffffc0203514 <cond_signal>
ffffffffc02033ea:	8522                	mv	a0,s0
ffffffffc02033ec:	ef5ff0ef          	jal	ra,ffffffffc02032e0 <up>
ffffffffc02033f0:	bfe9                	j	ffffffffc02033ca <worker2+0x2c>

ffffffffc02033f2 <worker3>:
ffffffffc02033f2:	7179                	addi	sp,sp,-48
ffffffffc02033f4:	f022                	sd	s0,32(sp)
ffffffffc02033f6:	ec26                	sd	s1,24(sp)
ffffffffc02033f8:	e84a                	sd	s2,16(sp)
ffffffffc02033fa:	e44e                	sd	s3,8(sp)
ffffffffc02033fc:	f406                	sd	ra,40(sp)
ffffffffc02033fe:	00016417          	auipc	s0,0x16
ffffffffc0203402:	26a40413          	addi	s0,s0,618 # ffffffffc0219668 <mutex>
ffffffffc0203406:	00016997          	auipc	s3,0x16
ffffffffc020340a:	2da98993          	addi	s3,s3,730 # ffffffffc02196e0 <cond2>
ffffffffc020340e:	00006917          	auipc	s2,0x6
ffffffffc0203412:	04290913          	addi	s2,s2,66 # ffffffffc0209450 <default_pmm_manager+0x118>
ffffffffc0203416:	00016497          	auipc	s1,0x16
ffffffffc020341a:	2b248493          	addi	s1,s1,690 # ffffffffc02196c8 <cond3>
ffffffffc020341e:	4509                	li	a0,2
ffffffffc0203420:	4e8010ef          	jal	ra,ffffffffc0204908 <do_sleep>
ffffffffc0203424:	8522                	mv	a0,s0
ffffffffc0203426:	ebdff0ef          	jal	ra,ffffffffc02032e2 <down>
ffffffffc020342a:	85a2                	mv	a1,s0
ffffffffc020342c:	854e                	mv	a0,s3
ffffffffc020342e:	0ea000ef          	jal	ra,ffffffffc0203518 <cond_wait>
ffffffffc0203432:	854a                	mv	a0,s2
ffffffffc0203434:	c99fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0203438:	8526                	mv	a0,s1
ffffffffc020343a:	0da000ef          	jal	ra,ffffffffc0203514 <cond_signal>
ffffffffc020343e:	8522                	mv	a0,s0
ffffffffc0203440:	ea1ff0ef          	jal	ra,ffffffffc02032e0 <up>
ffffffffc0203444:	bfe9                	j	ffffffffc020341e <worker3+0x2c>

ffffffffc0203446 <check_exercise>:
ffffffffc0203446:	1101                	addi	sp,sp,-32
ffffffffc0203448:	00016517          	auipc	a0,0x16
ffffffffc020344c:	25850513          	addi	a0,a0,600 # ffffffffc02196a0 <cond1>
ffffffffc0203450:	ec06                	sd	ra,24(sp)
ffffffffc0203452:	e822                	sd	s0,16(sp)
ffffffffc0203454:	e426                	sd	s1,8(sp)
ffffffffc0203456:	e04a                	sd	s2,0(sp)
ffffffffc0203458:	0b6000ef          	jal	ra,ffffffffc020350e <cond_init>
ffffffffc020345c:	00016517          	auipc	a0,0x16
ffffffffc0203460:	28450513          	addi	a0,a0,644 # ffffffffc02196e0 <cond2>
ffffffffc0203464:	0aa000ef          	jal	ra,ffffffffc020350e <cond_init>
ffffffffc0203468:	00016517          	auipc	a0,0x16
ffffffffc020346c:	26050513          	addi	a0,a0,608 # ffffffffc02196c8 <cond3>
ffffffffc0203470:	09e000ef          	jal	ra,ffffffffc020350e <cond_init>
ffffffffc0203474:	4585                	li	a1,1
ffffffffc0203476:	00016517          	auipc	a0,0x16
ffffffffc020347a:	1f250513          	addi	a0,a0,498 # ffffffffc0219668 <mutex>
ffffffffc020347e:	e5bff0ef          	jal	ra,ffffffffc02032d8 <sem_init>
ffffffffc0203482:	4601                	li	a2,0
ffffffffc0203484:	4581                	li	a1,0
ffffffffc0203486:	00000517          	auipc	a0,0x0
ffffffffc020348a:	e8e50513          	addi	a0,a0,-370 # ffffffffc0203314 <worker1>
ffffffffc020348e:	039000ef          	jal	ra,ffffffffc0203cc6 <kernel_thread>
ffffffffc0203492:	892a                	mv	s2,a0
ffffffffc0203494:	4601                	li	a2,0
ffffffffc0203496:	4581                	li	a1,0
ffffffffc0203498:	00000517          	auipc	a0,0x0
ffffffffc020349c:	f0650513          	addi	a0,a0,-250 # ffffffffc020339e <worker2>
ffffffffc02034a0:	027000ef          	jal	ra,ffffffffc0203cc6 <kernel_thread>
ffffffffc02034a4:	4601                	li	a2,0
ffffffffc02034a6:	84aa                	mv	s1,a0
ffffffffc02034a8:	4581                	li	a1,0
ffffffffc02034aa:	00000517          	auipc	a0,0x0
ffffffffc02034ae:	f4850513          	addi	a0,a0,-184 # ffffffffc02033f2 <worker3>
ffffffffc02034b2:	015000ef          	jal	ra,ffffffffc0203cc6 <kernel_thread>
ffffffffc02034b6:	842a                	mv	s0,a0
ffffffffc02034b8:	854a                	mv	a0,s2
ffffffffc02034ba:	3e2000ef          	jal	ra,ffffffffc020389c <find_proc>
ffffffffc02034be:	00006597          	auipc	a1,0x6
ffffffffc02034c2:	faa58593          	addi	a1,a1,-86 # ffffffffc0209468 <default_pmm_manager+0x130>
ffffffffc02034c6:	00016797          	auipc	a5,0x16
ffffffffc02034ca:	1ca7b923          	sd	a0,466(a5) # ffffffffc0219698 <pworker1>
ffffffffc02034ce:	338000ef          	jal	ra,ffffffffc0203806 <set_proc_name>
ffffffffc02034d2:	8526                	mv	a0,s1
ffffffffc02034d4:	3c8000ef          	jal	ra,ffffffffc020389c <find_proc>
ffffffffc02034d8:	00006597          	auipc	a1,0x6
ffffffffc02034dc:	f9858593          	addi	a1,a1,-104 # ffffffffc0209470 <default_pmm_manager+0x138>
ffffffffc02034e0:	00016797          	auipc	a5,0x16
ffffffffc02034e4:	1ca7bc23          	sd	a0,472(a5) # ffffffffc02196b8 <pworker2>
ffffffffc02034e8:	31e000ef          	jal	ra,ffffffffc0203806 <set_proc_name>
ffffffffc02034ec:	8522                	mv	a0,s0
ffffffffc02034ee:	3ae000ef          	jal	ra,ffffffffc020389c <find_proc>
ffffffffc02034f2:	6442                	ld	s0,16(sp)
ffffffffc02034f4:	60e2                	ld	ra,24(sp)
ffffffffc02034f6:	64a2                	ld	s1,8(sp)
ffffffffc02034f8:	6902                	ld	s2,0(sp)
ffffffffc02034fa:	00016797          	auipc	a5,0x16
ffffffffc02034fe:	1ca7b323          	sd	a0,454(a5) # ffffffffc02196c0 <pworker3>
ffffffffc0203502:	00006597          	auipc	a1,0x6
ffffffffc0203506:	f7658593          	addi	a1,a1,-138 # ffffffffc0209478 <default_pmm_manager+0x140>
ffffffffc020350a:	6105                	addi	sp,sp,32
ffffffffc020350c:	aced                	j	ffffffffc0203806 <set_proc_name>

ffffffffc020350e <cond_init>:
ffffffffc020350e:	4581                	li	a1,0
ffffffffc0203510:	dc9ff06f          	j	ffffffffc02032d8 <sem_init>

ffffffffc0203514 <cond_signal>:
ffffffffc0203514:	dcdff06f          	j	ffffffffc02032e0 <up>

ffffffffc0203518 <cond_wait>:
ffffffffc0203518:	1101                	addi	sp,sp,-32
ffffffffc020351a:	e426                	sd	s1,8(sp)
ffffffffc020351c:	84aa                	mv	s1,a0
ffffffffc020351e:	852e                	mv	a0,a1
ffffffffc0203520:	ec06                	sd	ra,24(sp)
ffffffffc0203522:	e822                	sd	s0,16(sp)
ffffffffc0203524:	842e                	mv	s0,a1
ffffffffc0203526:	dbbff0ef          	jal	ra,ffffffffc02032e0 <up>
ffffffffc020352a:	8526                	mv	a0,s1
ffffffffc020352c:	db7ff0ef          	jal	ra,ffffffffc02032e2 <down>
ffffffffc0203530:	8522                	mv	a0,s0
ffffffffc0203532:	6442                	ld	s0,16(sp)
ffffffffc0203534:	60e2                	ld	ra,24(sp)
ffffffffc0203536:	64a2                	ld	s1,8(sp)
ffffffffc0203538:	6105                	addi	sp,sp,32
ffffffffc020353a:	da9ff06f          	j	ffffffffc02032e2 <down>

ffffffffc020353e <swapfs_init>:
ffffffffc020353e:	1141                	addi	sp,sp,-16
ffffffffc0203540:	4505                	li	a0,1
ffffffffc0203542:	e406                	sd	ra,8(sp)
ffffffffc0203544:	fdffc0ef          	jal	ra,ffffffffc0200522 <ide_device_valid>
ffffffffc0203548:	cd01                	beqz	a0,ffffffffc0203560 <swapfs_init+0x22>
ffffffffc020354a:	4505                	li	a0,1
ffffffffc020354c:	fddfc0ef          	jal	ra,ffffffffc0200528 <ide_device_size>
ffffffffc0203550:	60a2                	ld	ra,8(sp)
ffffffffc0203552:	810d                	srli	a0,a0,0x3
ffffffffc0203554:	00016797          	auipc	a5,0x16
ffffffffc0203558:	08a7b623          	sd	a0,140(a5) # ffffffffc02195e0 <max_swap_offset>
ffffffffc020355c:	0141                	addi	sp,sp,16
ffffffffc020355e:	8082                	ret
ffffffffc0203560:	00006617          	auipc	a2,0x6
ffffffffc0203564:	f2060613          	addi	a2,a2,-224 # ffffffffc0209480 <default_pmm_manager+0x148>
ffffffffc0203568:	45b5                	li	a1,13
ffffffffc020356a:	00006517          	auipc	a0,0x6
ffffffffc020356e:	f3650513          	addi	a0,a0,-202 # ffffffffc02094a0 <default_pmm_manager+0x168>
ffffffffc0203572:	c97fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203576 <swapfs_read>:
ffffffffc0203576:	1141                	addi	sp,sp,-16
ffffffffc0203578:	e406                	sd	ra,8(sp)
ffffffffc020357a:	00855793          	srli	a5,a0,0x8
ffffffffc020357e:	cbb1                	beqz	a5,ffffffffc02035d2 <swapfs_read+0x5c>
ffffffffc0203580:	00016717          	auipc	a4,0x16
ffffffffc0203584:	06073703          	ld	a4,96(a4) # ffffffffc02195e0 <max_swap_offset>
ffffffffc0203588:	04e7f563          	bgeu	a5,a4,ffffffffc02035d2 <swapfs_read+0x5c>
ffffffffc020358c:	00016617          	auipc	a2,0x16
ffffffffc0203590:	fbc63603          	ld	a2,-68(a2) # ffffffffc0219548 <pages>
ffffffffc0203594:	8d91                	sub	a1,a1,a2
ffffffffc0203596:	4065d613          	srai	a2,a1,0x6
ffffffffc020359a:	00007717          	auipc	a4,0x7
ffffffffc020359e:	ffe73703          	ld	a4,-2(a4) # ffffffffc020a598 <nbase>
ffffffffc02035a2:	963a                	add	a2,a2,a4
ffffffffc02035a4:	00c61713          	slli	a4,a2,0xc
ffffffffc02035a8:	8331                	srli	a4,a4,0xc
ffffffffc02035aa:	00016697          	auipc	a3,0x16
ffffffffc02035ae:	f266b683          	ld	a3,-218(a3) # ffffffffc02194d0 <npage>
ffffffffc02035b2:	0037959b          	slliw	a1,a5,0x3
ffffffffc02035b6:	0632                	slli	a2,a2,0xc
ffffffffc02035b8:	02d77963          	bgeu	a4,a3,ffffffffc02035ea <swapfs_read+0x74>
ffffffffc02035bc:	60a2                	ld	ra,8(sp)
ffffffffc02035be:	00016797          	auipc	a5,0x16
ffffffffc02035c2:	f7a7b783          	ld	a5,-134(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc02035c6:	46a1                	li	a3,8
ffffffffc02035c8:	963e                	add	a2,a2,a5
ffffffffc02035ca:	4505                	li	a0,1
ffffffffc02035cc:	0141                	addi	sp,sp,16
ffffffffc02035ce:	f61fc06f          	j	ffffffffc020052e <ide_read_secs>
ffffffffc02035d2:	86aa                	mv	a3,a0
ffffffffc02035d4:	00006617          	auipc	a2,0x6
ffffffffc02035d8:	ee460613          	addi	a2,a2,-284 # ffffffffc02094b8 <default_pmm_manager+0x180>
ffffffffc02035dc:	45d1                	li	a1,20
ffffffffc02035de:	00006517          	auipc	a0,0x6
ffffffffc02035e2:	ec250513          	addi	a0,a0,-318 # ffffffffc02094a0 <default_pmm_manager+0x168>
ffffffffc02035e6:	c23fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02035ea:	86b2                	mv	a3,a2
ffffffffc02035ec:	06900593          	li	a1,105
ffffffffc02035f0:	00005617          	auipc	a2,0x5
ffffffffc02035f4:	3b860613          	addi	a2,a2,952 # ffffffffc02089a8 <commands+0x7c0>
ffffffffc02035f8:	00005517          	auipc	a0,0x5
ffffffffc02035fc:	31050513          	addi	a0,a0,784 # ffffffffc0208908 <commands+0x720>
ffffffffc0203600:	c09fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203604 <swapfs_write>:
ffffffffc0203604:	1141                	addi	sp,sp,-16
ffffffffc0203606:	e406                	sd	ra,8(sp)
ffffffffc0203608:	00855793          	srli	a5,a0,0x8
ffffffffc020360c:	cbb1                	beqz	a5,ffffffffc0203660 <swapfs_write+0x5c>
ffffffffc020360e:	00016717          	auipc	a4,0x16
ffffffffc0203612:	fd273703          	ld	a4,-46(a4) # ffffffffc02195e0 <max_swap_offset>
ffffffffc0203616:	04e7f563          	bgeu	a5,a4,ffffffffc0203660 <swapfs_write+0x5c>
ffffffffc020361a:	00016617          	auipc	a2,0x16
ffffffffc020361e:	f2e63603          	ld	a2,-210(a2) # ffffffffc0219548 <pages>
ffffffffc0203622:	8d91                	sub	a1,a1,a2
ffffffffc0203624:	4065d613          	srai	a2,a1,0x6
ffffffffc0203628:	00007717          	auipc	a4,0x7
ffffffffc020362c:	f7073703          	ld	a4,-144(a4) # ffffffffc020a598 <nbase>
ffffffffc0203630:	963a                	add	a2,a2,a4
ffffffffc0203632:	00c61713          	slli	a4,a2,0xc
ffffffffc0203636:	8331                	srli	a4,a4,0xc
ffffffffc0203638:	00016697          	auipc	a3,0x16
ffffffffc020363c:	e986b683          	ld	a3,-360(a3) # ffffffffc02194d0 <npage>
ffffffffc0203640:	0037959b          	slliw	a1,a5,0x3
ffffffffc0203644:	0632                	slli	a2,a2,0xc
ffffffffc0203646:	02d77963          	bgeu	a4,a3,ffffffffc0203678 <swapfs_write+0x74>
ffffffffc020364a:	60a2                	ld	ra,8(sp)
ffffffffc020364c:	00016797          	auipc	a5,0x16
ffffffffc0203650:	eec7b783          	ld	a5,-276(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc0203654:	46a1                	li	a3,8
ffffffffc0203656:	963e                	add	a2,a2,a5
ffffffffc0203658:	4505                	li	a0,1
ffffffffc020365a:	0141                	addi	sp,sp,16
ffffffffc020365c:	ef7fc06f          	j	ffffffffc0200552 <ide_write_secs>
ffffffffc0203660:	86aa                	mv	a3,a0
ffffffffc0203662:	00006617          	auipc	a2,0x6
ffffffffc0203666:	e5660613          	addi	a2,a2,-426 # ffffffffc02094b8 <default_pmm_manager+0x180>
ffffffffc020366a:	45e5                	li	a1,25
ffffffffc020366c:	00006517          	auipc	a0,0x6
ffffffffc0203670:	e3450513          	addi	a0,a0,-460 # ffffffffc02094a0 <default_pmm_manager+0x168>
ffffffffc0203674:	b95fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203678:	86b2                	mv	a3,a2
ffffffffc020367a:	06900593          	li	a1,105
ffffffffc020367e:	00005617          	auipc	a2,0x5
ffffffffc0203682:	32a60613          	addi	a2,a2,810 # ffffffffc02089a8 <commands+0x7c0>
ffffffffc0203686:	00005517          	auipc	a0,0x5
ffffffffc020368a:	28250513          	addi	a0,a0,642 # ffffffffc0208908 <commands+0x720>
ffffffffc020368e:	b7bfc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203692 <kernel_thread_entry>:
ffffffffc0203692:	8526                	mv	a0,s1
ffffffffc0203694:	9402                	jalr	s0
ffffffffc0203696:	680000ef          	jal	ra,ffffffffc0203d16 <do_exit>

ffffffffc020369a <switch_to>:
ffffffffc020369a:	00153023          	sd	ra,0(a0)
ffffffffc020369e:	00253423          	sd	sp,8(a0)
ffffffffc02036a2:	e900                	sd	s0,16(a0)
ffffffffc02036a4:	ed04                	sd	s1,24(a0)
ffffffffc02036a6:	03253023          	sd	s2,32(a0)
ffffffffc02036aa:	03353423          	sd	s3,40(a0)
ffffffffc02036ae:	03453823          	sd	s4,48(a0)
ffffffffc02036b2:	03553c23          	sd	s5,56(a0)
ffffffffc02036b6:	05653023          	sd	s6,64(a0)
ffffffffc02036ba:	05753423          	sd	s7,72(a0)
ffffffffc02036be:	05853823          	sd	s8,80(a0)
ffffffffc02036c2:	05953c23          	sd	s9,88(a0)
ffffffffc02036c6:	07a53023          	sd	s10,96(a0)
ffffffffc02036ca:	07b53423          	sd	s11,104(a0)
ffffffffc02036ce:	0005b083          	ld	ra,0(a1)
ffffffffc02036d2:	0085b103          	ld	sp,8(a1)
ffffffffc02036d6:	6980                	ld	s0,16(a1)
ffffffffc02036d8:	6d84                	ld	s1,24(a1)
ffffffffc02036da:	0205b903          	ld	s2,32(a1)
ffffffffc02036de:	0285b983          	ld	s3,40(a1)
ffffffffc02036e2:	0305ba03          	ld	s4,48(a1)
ffffffffc02036e6:	0385ba83          	ld	s5,56(a1)
ffffffffc02036ea:	0405bb03          	ld	s6,64(a1)
ffffffffc02036ee:	0485bb83          	ld	s7,72(a1)
ffffffffc02036f2:	0505bc03          	ld	s8,80(a1)
ffffffffc02036f6:	0585bc83          	ld	s9,88(a1)
ffffffffc02036fa:	0605bd03          	ld	s10,96(a1)
ffffffffc02036fe:	0685bd83          	ld	s11,104(a1)
ffffffffc0203702:	8082                	ret

ffffffffc0203704 <alloc_proc>:
ffffffffc0203704:	1141                	addi	sp,sp,-16
ffffffffc0203706:	14800513          	li	a0,328
ffffffffc020370a:	e022                	sd	s0,0(sp)
ffffffffc020370c:	e406                	sd	ra,8(sp)
ffffffffc020370e:	963fe0ef          	jal	ra,ffffffffc0202070 <kmalloc>
ffffffffc0203712:	842a                	mv	s0,a0
ffffffffc0203714:	cd21                	beqz	a0,ffffffffc020376c <alloc_proc+0x68>
ffffffffc0203716:	57fd                	li	a5,-1
ffffffffc0203718:	1782                	slli	a5,a5,0x20
ffffffffc020371a:	e11c                	sd	a5,0(a0)
ffffffffc020371c:	07000613          	li	a2,112
ffffffffc0203720:	4581                	li	a1,0
ffffffffc0203722:	00052423          	sw	zero,8(a0)
ffffffffc0203726:	00053823          	sd	zero,16(a0)
ffffffffc020372a:	00053c23          	sd	zero,24(a0)
ffffffffc020372e:	02053023          	sd	zero,32(a0)
ffffffffc0203732:	02053423          	sd	zero,40(a0)
ffffffffc0203736:	03050513          	addi	a0,a0,48
ffffffffc020373a:	3dc040ef          	jal	ra,ffffffffc0207b16 <memset>
ffffffffc020373e:	00016797          	auipc	a5,0x16
ffffffffc0203742:	e027b783          	ld	a5,-510(a5) # ffffffffc0219540 <boot_cr3>
ffffffffc0203746:	0a043023          	sd	zero,160(s0)
ffffffffc020374a:	f45c                	sd	a5,168(s0)
ffffffffc020374c:	0a042823          	sw	zero,176(s0)
ffffffffc0203750:	463d                	li	a2,15
ffffffffc0203752:	4581                	li	a1,0
ffffffffc0203754:	0b440513          	addi	a0,s0,180
ffffffffc0203758:	3be040ef          	jal	ra,ffffffffc0207b16 <memset>
ffffffffc020375c:	0e042623          	sw	zero,236(s0)
ffffffffc0203760:	0e043c23          	sd	zero,248(s0)
ffffffffc0203764:	10043023          	sd	zero,256(s0)
ffffffffc0203768:	0e043823          	sd	zero,240(s0)
ffffffffc020376c:	60a2                	ld	ra,8(sp)
ffffffffc020376e:	8522                	mv	a0,s0
ffffffffc0203770:	6402                	ld	s0,0(sp)
ffffffffc0203772:	0141                	addi	sp,sp,16
ffffffffc0203774:	8082                	ret

ffffffffc0203776 <forkret>:
ffffffffc0203776:	00016797          	auipc	a5,0x16
ffffffffc020377a:	d827b783          	ld	a5,-638(a5) # ffffffffc02194f8 <current>
ffffffffc020377e:	73c8                	ld	a0,160(a5)
ffffffffc0203780:	daafd06f          	j	ffffffffc0200d2a <forkrets>

ffffffffc0203784 <setup_pgdir.isra.0>:
ffffffffc0203784:	1101                	addi	sp,sp,-32
ffffffffc0203786:	e426                	sd	s1,8(sp)
ffffffffc0203788:	84aa                	mv	s1,a0
ffffffffc020378a:	4505                	li	a0,1
ffffffffc020378c:	ec06                	sd	ra,24(sp)
ffffffffc020378e:	e822                	sd	s0,16(sp)
ffffffffc0203790:	dbafd0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0203794:	c939                	beqz	a0,ffffffffc02037ea <setup_pgdir.isra.0+0x66>
ffffffffc0203796:	00016697          	auipc	a3,0x16
ffffffffc020379a:	db26b683          	ld	a3,-590(a3) # ffffffffc0219548 <pages>
ffffffffc020379e:	40d506b3          	sub	a3,a0,a3
ffffffffc02037a2:	8699                	srai	a3,a3,0x6
ffffffffc02037a4:	00007417          	auipc	s0,0x7
ffffffffc02037a8:	df443403          	ld	s0,-524(s0) # ffffffffc020a598 <nbase>
ffffffffc02037ac:	96a2                	add	a3,a3,s0
ffffffffc02037ae:	00c69793          	slli	a5,a3,0xc
ffffffffc02037b2:	83b1                	srli	a5,a5,0xc
ffffffffc02037b4:	00016717          	auipc	a4,0x16
ffffffffc02037b8:	d1c73703          	ld	a4,-740(a4) # ffffffffc02194d0 <npage>
ffffffffc02037bc:	06b2                	slli	a3,a3,0xc
ffffffffc02037be:	02e7f863          	bgeu	a5,a4,ffffffffc02037ee <setup_pgdir.isra.0+0x6a>
ffffffffc02037c2:	00016417          	auipc	s0,0x16
ffffffffc02037c6:	d7643403          	ld	s0,-650(s0) # ffffffffc0219538 <va_pa_offset>
ffffffffc02037ca:	9436                	add	s0,s0,a3
ffffffffc02037cc:	6605                	lui	a2,0x1
ffffffffc02037ce:	00016597          	auipc	a1,0x16
ffffffffc02037d2:	cfa5b583          	ld	a1,-774(a1) # ffffffffc02194c8 <boot_pgdir>
ffffffffc02037d6:	8522                	mv	a0,s0
ffffffffc02037d8:	350040ef          	jal	ra,ffffffffc0207b28 <memcpy>
ffffffffc02037dc:	4501                	li	a0,0
ffffffffc02037de:	e080                	sd	s0,0(s1)
ffffffffc02037e0:	60e2                	ld	ra,24(sp)
ffffffffc02037e2:	6442                	ld	s0,16(sp)
ffffffffc02037e4:	64a2                	ld	s1,8(sp)
ffffffffc02037e6:	6105                	addi	sp,sp,32
ffffffffc02037e8:	8082                	ret
ffffffffc02037ea:	5571                	li	a0,-4
ffffffffc02037ec:	bfd5                	j	ffffffffc02037e0 <setup_pgdir.isra.0+0x5c>
ffffffffc02037ee:	00005617          	auipc	a2,0x5
ffffffffc02037f2:	1ba60613          	addi	a2,a2,442 # ffffffffc02089a8 <commands+0x7c0>
ffffffffc02037f6:	06900593          	li	a1,105
ffffffffc02037fa:	00005517          	auipc	a0,0x5
ffffffffc02037fe:	10e50513          	addi	a0,a0,270 # ffffffffc0208908 <commands+0x720>
ffffffffc0203802:	a07fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203806 <set_proc_name>:
ffffffffc0203806:	1101                	addi	sp,sp,-32
ffffffffc0203808:	e822                	sd	s0,16(sp)
ffffffffc020380a:	0b450413          	addi	s0,a0,180
ffffffffc020380e:	e426                	sd	s1,8(sp)
ffffffffc0203810:	4641                	li	a2,16
ffffffffc0203812:	84ae                	mv	s1,a1
ffffffffc0203814:	8522                	mv	a0,s0
ffffffffc0203816:	4581                	li	a1,0
ffffffffc0203818:	ec06                	sd	ra,24(sp)
ffffffffc020381a:	2fc040ef          	jal	ra,ffffffffc0207b16 <memset>
ffffffffc020381e:	8522                	mv	a0,s0
ffffffffc0203820:	6442                	ld	s0,16(sp)
ffffffffc0203822:	60e2                	ld	ra,24(sp)
ffffffffc0203824:	85a6                	mv	a1,s1
ffffffffc0203826:	64a2                	ld	s1,8(sp)
ffffffffc0203828:	463d                	li	a2,15
ffffffffc020382a:	6105                	addi	sp,sp,32
ffffffffc020382c:	2fc0406f          	j	ffffffffc0207b28 <memcpy>

ffffffffc0203830 <proc_run>:
ffffffffc0203830:	7179                	addi	sp,sp,-48
ffffffffc0203832:	ec4a                	sd	s2,24(sp)
ffffffffc0203834:	00016917          	auipc	s2,0x16
ffffffffc0203838:	cc490913          	addi	s2,s2,-828 # ffffffffc02194f8 <current>
ffffffffc020383c:	f026                	sd	s1,32(sp)
ffffffffc020383e:	00093483          	ld	s1,0(s2)
ffffffffc0203842:	f406                	sd	ra,40(sp)
ffffffffc0203844:	e84e                	sd	s3,16(sp)
ffffffffc0203846:	02a48863          	beq	s1,a0,ffffffffc0203876 <proc_run+0x46>
ffffffffc020384a:	100027f3          	csrr	a5,sstatus
ffffffffc020384e:	8b89                	andi	a5,a5,2
ffffffffc0203850:	4981                	li	s3,0
ffffffffc0203852:	ef9d                	bnez	a5,ffffffffc0203890 <proc_run+0x60>
ffffffffc0203854:	755c                	ld	a5,168(a0)
ffffffffc0203856:	577d                	li	a4,-1
ffffffffc0203858:	177e                	slli	a4,a4,0x3f
ffffffffc020385a:	83b1                	srli	a5,a5,0xc
ffffffffc020385c:	00a93023          	sd	a0,0(s2)
ffffffffc0203860:	8fd9                	or	a5,a5,a4
ffffffffc0203862:	18079073          	csrw	satp,a5
ffffffffc0203866:	03050593          	addi	a1,a0,48
ffffffffc020386a:	03048513          	addi	a0,s1,48
ffffffffc020386e:	e2dff0ef          	jal	ra,ffffffffc020369a <switch_to>
ffffffffc0203872:	00099863          	bnez	s3,ffffffffc0203882 <proc_run+0x52>
ffffffffc0203876:	70a2                	ld	ra,40(sp)
ffffffffc0203878:	7482                	ld	s1,32(sp)
ffffffffc020387a:	6962                	ld	s2,24(sp)
ffffffffc020387c:	69c2                	ld	s3,16(sp)
ffffffffc020387e:	6145                	addi	sp,sp,48
ffffffffc0203880:	8082                	ret
ffffffffc0203882:	70a2                	ld	ra,40(sp)
ffffffffc0203884:	7482                	ld	s1,32(sp)
ffffffffc0203886:	6962                	ld	s2,24(sp)
ffffffffc0203888:	69c2                	ld	s3,16(sp)
ffffffffc020388a:	6145                	addi	sp,sp,48
ffffffffc020388c:	da7fc06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0203890:	e42a                	sd	a0,8(sp)
ffffffffc0203892:	da7fc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203896:	6522                	ld	a0,8(sp)
ffffffffc0203898:	4985                	li	s3,1
ffffffffc020389a:	bf6d                	j	ffffffffc0203854 <proc_run+0x24>

ffffffffc020389c <find_proc>:
ffffffffc020389c:	6789                	lui	a5,0x2
ffffffffc020389e:	fff5071b          	addiw	a4,a0,-1
ffffffffc02038a2:	17f9                	addi	a5,a5,-2
ffffffffc02038a4:	04e7e063          	bltu	a5,a4,ffffffffc02038e4 <find_proc+0x48>
ffffffffc02038a8:	1141                	addi	sp,sp,-16
ffffffffc02038aa:	e022                	sd	s0,0(sp)
ffffffffc02038ac:	45a9                	li	a1,10
ffffffffc02038ae:	842a                	mv	s0,a0
ffffffffc02038b0:	2501                	sext.w	a0,a0
ffffffffc02038b2:	e406                	sd	ra,8(sp)
ffffffffc02038b4:	67a040ef          	jal	ra,ffffffffc0207f2e <hash32>
ffffffffc02038b8:	02051693          	slli	a3,a0,0x20
ffffffffc02038bc:	00012797          	auipc	a5,0x12
ffffffffc02038c0:	bd478793          	addi	a5,a5,-1068 # ffffffffc0215490 <hash_list>
ffffffffc02038c4:	82f1                	srli	a3,a3,0x1c
ffffffffc02038c6:	96be                	add	a3,a3,a5
ffffffffc02038c8:	87b6                	mv	a5,a3
ffffffffc02038ca:	a029                	j	ffffffffc02038d4 <find_proc+0x38>
ffffffffc02038cc:	f2c7a703          	lw	a4,-212(a5)
ffffffffc02038d0:	00870c63          	beq	a4,s0,ffffffffc02038e8 <find_proc+0x4c>
ffffffffc02038d4:	679c                	ld	a5,8(a5)
ffffffffc02038d6:	fef69be3          	bne	a3,a5,ffffffffc02038cc <find_proc+0x30>
ffffffffc02038da:	60a2                	ld	ra,8(sp)
ffffffffc02038dc:	6402                	ld	s0,0(sp)
ffffffffc02038de:	4501                	li	a0,0
ffffffffc02038e0:	0141                	addi	sp,sp,16
ffffffffc02038e2:	8082                	ret
ffffffffc02038e4:	4501                	li	a0,0
ffffffffc02038e6:	8082                	ret
ffffffffc02038e8:	60a2                	ld	ra,8(sp)
ffffffffc02038ea:	6402                	ld	s0,0(sp)
ffffffffc02038ec:	f2878513          	addi	a0,a5,-216
ffffffffc02038f0:	0141                	addi	sp,sp,16
ffffffffc02038f2:	8082                	ret

ffffffffc02038f4 <do_fork>:
ffffffffc02038f4:	7159                	addi	sp,sp,-112
ffffffffc02038f6:	e4ce                	sd	s3,72(sp)
ffffffffc02038f8:	00016997          	auipc	s3,0x16
ffffffffc02038fc:	c1898993          	addi	s3,s3,-1000 # ffffffffc0219510 <nr_process>
ffffffffc0203900:	0009a703          	lw	a4,0(s3)
ffffffffc0203904:	f486                	sd	ra,104(sp)
ffffffffc0203906:	f0a2                	sd	s0,96(sp)
ffffffffc0203908:	eca6                	sd	s1,88(sp)
ffffffffc020390a:	e8ca                	sd	s2,80(sp)
ffffffffc020390c:	e0d2                	sd	s4,64(sp)
ffffffffc020390e:	fc56                	sd	s5,56(sp)
ffffffffc0203910:	f85a                	sd	s6,48(sp)
ffffffffc0203912:	f45e                	sd	s7,40(sp)
ffffffffc0203914:	f062                	sd	s8,32(sp)
ffffffffc0203916:	ec66                	sd	s9,24(sp)
ffffffffc0203918:	e86a                	sd	s10,16(sp)
ffffffffc020391a:	e46e                	sd	s11,8(sp)
ffffffffc020391c:	6785                	lui	a5,0x1
ffffffffc020391e:	30f75f63          	bge	a4,a5,ffffffffc0203c3c <do_fork+0x348>
ffffffffc0203922:	8a2a                	mv	s4,a0
ffffffffc0203924:	892e                	mv	s2,a1
ffffffffc0203926:	84b2                	mv	s1,a2
ffffffffc0203928:	dddff0ef          	jal	ra,ffffffffc0203704 <alloc_proc>
ffffffffc020392c:	842a                	mv	s0,a0
ffffffffc020392e:	28050263          	beqz	a0,ffffffffc0203bb2 <do_fork+0x2be>
ffffffffc0203932:	00016b97          	auipc	s7,0x16
ffffffffc0203936:	bc6b8b93          	addi	s7,s7,-1082 # ffffffffc02194f8 <current>
ffffffffc020393a:	000bb783          	ld	a5,0(s7)
ffffffffc020393e:	0ec7a703          	lw	a4,236(a5) # 10ec <kern_entry-0xffffffffc01fef14>
ffffffffc0203942:	f11c                	sd	a5,32(a0)
ffffffffc0203944:	30071c63          	bnez	a4,ffffffffc0203c5c <do_fork+0x368>
ffffffffc0203948:	4509                	li	a0,2
ffffffffc020394a:	c00fd0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc020394e:	24050f63          	beqz	a0,ffffffffc0203bac <do_fork+0x2b8>
ffffffffc0203952:	00016c17          	auipc	s8,0x16
ffffffffc0203956:	bf6c0c13          	addi	s8,s8,-1034 # ffffffffc0219548 <pages>
ffffffffc020395a:	000c3683          	ld	a3,0(s8)
ffffffffc020395e:	00007a97          	auipc	s5,0x7
ffffffffc0203962:	c3aaba83          	ld	s5,-966(s5) # ffffffffc020a598 <nbase>
ffffffffc0203966:	00016c97          	auipc	s9,0x16
ffffffffc020396a:	b6ac8c93          	addi	s9,s9,-1174 # ffffffffc02194d0 <npage>
ffffffffc020396e:	40d506b3          	sub	a3,a0,a3
ffffffffc0203972:	8699                	srai	a3,a3,0x6
ffffffffc0203974:	96d6                	add	a3,a3,s5
ffffffffc0203976:	000cb703          	ld	a4,0(s9)
ffffffffc020397a:	00c69793          	slli	a5,a3,0xc
ffffffffc020397e:	83b1                	srli	a5,a5,0xc
ffffffffc0203980:	06b2                	slli	a3,a3,0xc
ffffffffc0203982:	2ce7f163          	bgeu	a5,a4,ffffffffc0203c44 <do_fork+0x350>
ffffffffc0203986:	000bb703          	ld	a4,0(s7)
ffffffffc020398a:	00016d17          	auipc	s10,0x16
ffffffffc020398e:	baed0d13          	addi	s10,s10,-1106 # ffffffffc0219538 <va_pa_offset>
ffffffffc0203992:	000d3783          	ld	a5,0(s10)
ffffffffc0203996:	02873b03          	ld	s6,40(a4)
ffffffffc020399a:	96be                	add	a3,a3,a5
ffffffffc020399c:	e814                	sd	a3,16(s0)
ffffffffc020399e:	020b0863          	beqz	s6,ffffffffc02039ce <do_fork+0xda>
ffffffffc02039a2:	100a7a13          	andi	s4,s4,256
ffffffffc02039a6:	1c0a0163          	beqz	s4,ffffffffc0203b68 <do_fork+0x274>
ffffffffc02039aa:	030b2703          	lw	a4,48(s6)
ffffffffc02039ae:	018b3783          	ld	a5,24(s6)
ffffffffc02039b2:	c02006b7          	lui	a3,0xc0200
ffffffffc02039b6:	2705                	addiw	a4,a4,1
ffffffffc02039b8:	02eb2823          	sw	a4,48(s6)
ffffffffc02039bc:	03643423          	sd	s6,40(s0)
ffffffffc02039c0:	2ad7ee63          	bltu	a5,a3,ffffffffc0203c7c <do_fork+0x388>
ffffffffc02039c4:	000d3703          	ld	a4,0(s10)
ffffffffc02039c8:	6814                	ld	a3,16(s0)
ffffffffc02039ca:	8f99                	sub	a5,a5,a4
ffffffffc02039cc:	f45c                	sd	a5,168(s0)
ffffffffc02039ce:	6789                	lui	a5,0x2
ffffffffc02039d0:	ee078793          	addi	a5,a5,-288 # 1ee0 <kern_entry-0xffffffffc01fe120>
ffffffffc02039d4:	97b6                	add	a5,a5,a3
ffffffffc02039d6:	8626                	mv	a2,s1
ffffffffc02039d8:	f05c                	sd	a5,160(s0)
ffffffffc02039da:	873e                	mv	a4,a5
ffffffffc02039dc:	12048313          	addi	t1,s1,288
ffffffffc02039e0:	00063883          	ld	a7,0(a2)
ffffffffc02039e4:	00863803          	ld	a6,8(a2)
ffffffffc02039e8:	6a08                	ld	a0,16(a2)
ffffffffc02039ea:	6e0c                	ld	a1,24(a2)
ffffffffc02039ec:	01173023          	sd	a7,0(a4)
ffffffffc02039f0:	01073423          	sd	a6,8(a4)
ffffffffc02039f4:	eb08                	sd	a0,16(a4)
ffffffffc02039f6:	ef0c                	sd	a1,24(a4)
ffffffffc02039f8:	02060613          	addi	a2,a2,32
ffffffffc02039fc:	02070713          	addi	a4,a4,32
ffffffffc0203a00:	fe6610e3          	bne	a2,t1,ffffffffc02039e0 <do_fork+0xec>
ffffffffc0203a04:	0407b823          	sd	zero,80(a5)
ffffffffc0203a08:	12090a63          	beqz	s2,ffffffffc0203b3c <do_fork+0x248>
ffffffffc0203a0c:	0127b823          	sd	s2,16(a5)
ffffffffc0203a10:	00000717          	auipc	a4,0x0
ffffffffc0203a14:	d6670713          	addi	a4,a4,-666 # ffffffffc0203776 <forkret>
ffffffffc0203a18:	f818                	sd	a4,48(s0)
ffffffffc0203a1a:	fc1c                	sd	a5,56(s0)
ffffffffc0203a1c:	100027f3          	csrr	a5,sstatus
ffffffffc0203a20:	8b89                	andi	a5,a5,2
ffffffffc0203a22:	4901                	li	s2,0
ffffffffc0203a24:	12079e63          	bnez	a5,ffffffffc0203b60 <do_fork+0x26c>
ffffffffc0203a28:	0000a597          	auipc	a1,0xa
ffffffffc0203a2c:	66058593          	addi	a1,a1,1632 # ffffffffc020e088 <last_pid.1812>
ffffffffc0203a30:	419c                	lw	a5,0(a1)
ffffffffc0203a32:	6709                	lui	a4,0x2
ffffffffc0203a34:	0017851b          	addiw	a0,a5,1
ffffffffc0203a38:	c188                	sw	a0,0(a1)
ffffffffc0203a3a:	08e55b63          	bge	a0,a4,ffffffffc0203ad0 <do_fork+0x1dc>
ffffffffc0203a3e:	0000a897          	auipc	a7,0xa
ffffffffc0203a42:	64e88893          	addi	a7,a7,1614 # ffffffffc020e08c <next_safe.1811>
ffffffffc0203a46:	0008a783          	lw	a5,0(a7)
ffffffffc0203a4a:	00016497          	auipc	s1,0x16
ffffffffc0203a4e:	cae48493          	addi	s1,s1,-850 # ffffffffc02196f8 <proc_list>
ffffffffc0203a52:	08f55663          	bge	a0,a5,ffffffffc0203ade <do_fork+0x1ea>
ffffffffc0203a56:	c048                	sw	a0,4(s0)
ffffffffc0203a58:	45a9                	li	a1,10
ffffffffc0203a5a:	2501                	sext.w	a0,a0
ffffffffc0203a5c:	4d2040ef          	jal	ra,ffffffffc0207f2e <hash32>
ffffffffc0203a60:	1502                	slli	a0,a0,0x20
ffffffffc0203a62:	00012797          	auipc	a5,0x12
ffffffffc0203a66:	a2e78793          	addi	a5,a5,-1490 # ffffffffc0215490 <hash_list>
ffffffffc0203a6a:	8171                	srli	a0,a0,0x1c
ffffffffc0203a6c:	953e                	add	a0,a0,a5
ffffffffc0203a6e:	650c                	ld	a1,8(a0)
ffffffffc0203a70:	7014                	ld	a3,32(s0)
ffffffffc0203a72:	0d840793          	addi	a5,s0,216
ffffffffc0203a76:	e19c                	sd	a5,0(a1)
ffffffffc0203a78:	6490                	ld	a2,8(s1)
ffffffffc0203a7a:	e51c                	sd	a5,8(a0)
ffffffffc0203a7c:	7af8                	ld	a4,240(a3)
ffffffffc0203a7e:	0c840793          	addi	a5,s0,200
ffffffffc0203a82:	f06c                	sd	a1,224(s0)
ffffffffc0203a84:	ec68                	sd	a0,216(s0)
ffffffffc0203a86:	e21c                	sd	a5,0(a2)
ffffffffc0203a88:	e49c                	sd	a5,8(s1)
ffffffffc0203a8a:	e870                	sd	a2,208(s0)
ffffffffc0203a8c:	e464                	sd	s1,200(s0)
ffffffffc0203a8e:	0e043c23          	sd	zero,248(s0)
ffffffffc0203a92:	10e43023          	sd	a4,256(s0)
ffffffffc0203a96:	c311                	beqz	a4,ffffffffc0203a9a <do_fork+0x1a6>
ffffffffc0203a98:	ff60                	sd	s0,248(a4)
ffffffffc0203a9a:	0009a783          	lw	a5,0(s3)
ffffffffc0203a9e:	fae0                	sd	s0,240(a3)
ffffffffc0203aa0:	2785                	addiw	a5,a5,1
ffffffffc0203aa2:	00f9a023          	sw	a5,0(s3)
ffffffffc0203aa6:	10091863          	bnez	s2,ffffffffc0203bb6 <do_fork+0x2c2>
ffffffffc0203aaa:	8522                	mv	a0,s0
ffffffffc0203aac:	733000ef          	jal	ra,ffffffffc02049de <wakeup_proc>
ffffffffc0203ab0:	4048                	lw	a0,4(s0)
ffffffffc0203ab2:	70a6                	ld	ra,104(sp)
ffffffffc0203ab4:	7406                	ld	s0,96(sp)
ffffffffc0203ab6:	64e6                	ld	s1,88(sp)
ffffffffc0203ab8:	6946                	ld	s2,80(sp)
ffffffffc0203aba:	69a6                	ld	s3,72(sp)
ffffffffc0203abc:	6a06                	ld	s4,64(sp)
ffffffffc0203abe:	7ae2                	ld	s5,56(sp)
ffffffffc0203ac0:	7b42                	ld	s6,48(sp)
ffffffffc0203ac2:	7ba2                	ld	s7,40(sp)
ffffffffc0203ac4:	7c02                	ld	s8,32(sp)
ffffffffc0203ac6:	6ce2                	ld	s9,24(sp)
ffffffffc0203ac8:	6d42                	ld	s10,16(sp)
ffffffffc0203aca:	6da2                	ld	s11,8(sp)
ffffffffc0203acc:	6165                	addi	sp,sp,112
ffffffffc0203ace:	8082                	ret
ffffffffc0203ad0:	4785                	li	a5,1
ffffffffc0203ad2:	c19c                	sw	a5,0(a1)
ffffffffc0203ad4:	4505                	li	a0,1
ffffffffc0203ad6:	0000a897          	auipc	a7,0xa
ffffffffc0203ada:	5b688893          	addi	a7,a7,1462 # ffffffffc020e08c <next_safe.1811>
ffffffffc0203ade:	00016497          	auipc	s1,0x16
ffffffffc0203ae2:	c1a48493          	addi	s1,s1,-998 # ffffffffc02196f8 <proc_list>
ffffffffc0203ae6:	0084b303          	ld	t1,8(s1)
ffffffffc0203aea:	6789                	lui	a5,0x2
ffffffffc0203aec:	00f8a023          	sw	a5,0(a7)
ffffffffc0203af0:	4801                	li	a6,0
ffffffffc0203af2:	87aa                	mv	a5,a0
ffffffffc0203af4:	6e89                	lui	t4,0x2
ffffffffc0203af6:	12930e63          	beq	t1,s1,ffffffffc0203c32 <do_fork+0x33e>
ffffffffc0203afa:	8e42                	mv	t3,a6
ffffffffc0203afc:	869a                	mv	a3,t1
ffffffffc0203afe:	6609                	lui	a2,0x2
ffffffffc0203b00:	a811                	j	ffffffffc0203b14 <do_fork+0x220>
ffffffffc0203b02:	00e7d663          	bge	a5,a4,ffffffffc0203b0e <do_fork+0x21a>
ffffffffc0203b06:	00c75463          	bge	a4,a2,ffffffffc0203b0e <do_fork+0x21a>
ffffffffc0203b0a:	863a                	mv	a2,a4
ffffffffc0203b0c:	4e05                	li	t3,1
ffffffffc0203b0e:	6694                	ld	a3,8(a3)
ffffffffc0203b10:	00968d63          	beq	a3,s1,ffffffffc0203b2a <do_fork+0x236>
ffffffffc0203b14:	f3c6a703          	lw	a4,-196(a3) # ffffffffc01fff3c <kern_entry-0xc4>
ffffffffc0203b18:	fef715e3          	bne	a4,a5,ffffffffc0203b02 <do_fork+0x20e>
ffffffffc0203b1c:	2785                	addiw	a5,a5,1
ffffffffc0203b1e:	08c7df63          	bge	a5,a2,ffffffffc0203bbc <do_fork+0x2c8>
ffffffffc0203b22:	6694                	ld	a3,8(a3)
ffffffffc0203b24:	4805                	li	a6,1
ffffffffc0203b26:	fe9697e3          	bne	a3,s1,ffffffffc0203b14 <do_fork+0x220>
ffffffffc0203b2a:	00080463          	beqz	a6,ffffffffc0203b32 <do_fork+0x23e>
ffffffffc0203b2e:	c19c                	sw	a5,0(a1)
ffffffffc0203b30:	853e                	mv	a0,a5
ffffffffc0203b32:	f20e02e3          	beqz	t3,ffffffffc0203a56 <do_fork+0x162>
ffffffffc0203b36:	00c8a023          	sw	a2,0(a7)
ffffffffc0203b3a:	bf31                	j	ffffffffc0203a56 <do_fork+0x162>
ffffffffc0203b3c:	6909                	lui	s2,0x2
ffffffffc0203b3e:	edc90913          	addi	s2,s2,-292 # 1edc <kern_entry-0xffffffffc01fe124>
ffffffffc0203b42:	9936                	add	s2,s2,a3
ffffffffc0203b44:	0127b823          	sd	s2,16(a5) # 2010 <kern_entry-0xffffffffc01fdff0>
ffffffffc0203b48:	00000717          	auipc	a4,0x0
ffffffffc0203b4c:	c2e70713          	addi	a4,a4,-978 # ffffffffc0203776 <forkret>
ffffffffc0203b50:	f818                	sd	a4,48(s0)
ffffffffc0203b52:	fc1c                	sd	a5,56(s0)
ffffffffc0203b54:	100027f3          	csrr	a5,sstatus
ffffffffc0203b58:	8b89                	andi	a5,a5,2
ffffffffc0203b5a:	4901                	li	s2,0
ffffffffc0203b5c:	ec0786e3          	beqz	a5,ffffffffc0203a28 <do_fork+0x134>
ffffffffc0203b60:	ad9fc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203b64:	4905                	li	s2,1
ffffffffc0203b66:	b5c9                	j	ffffffffc0203a28 <do_fork+0x134>
ffffffffc0203b68:	bd1fd0ef          	jal	ra,ffffffffc0201738 <mm_create>
ffffffffc0203b6c:	8a2a                	mv	s4,a0
ffffffffc0203b6e:	c901                	beqz	a0,ffffffffc0203b7e <do_fork+0x28a>
ffffffffc0203b70:	0561                	addi	a0,a0,24
ffffffffc0203b72:	c13ff0ef          	jal	ra,ffffffffc0203784 <setup_pgdir.isra.0>
ffffffffc0203b76:	c921                	beqz	a0,ffffffffc0203bc6 <do_fork+0x2d2>
ffffffffc0203b78:	8552                	mv	a0,s4
ffffffffc0203b7a:	d1dfd0ef          	jal	ra,ffffffffc0201896 <mm_destroy>
ffffffffc0203b7e:	6814                	ld	a3,16(s0)
ffffffffc0203b80:	c02007b7          	lui	a5,0xc0200
ffffffffc0203b84:	12f6e563          	bltu	a3,a5,ffffffffc0203cae <do_fork+0x3ba>
ffffffffc0203b88:	000d3783          	ld	a5,0(s10)
ffffffffc0203b8c:	000cb703          	ld	a4,0(s9)
ffffffffc0203b90:	40f687b3          	sub	a5,a3,a5
ffffffffc0203b94:	83b1                	srli	a5,a5,0xc
ffffffffc0203b96:	10e7f063          	bgeu	a5,a4,ffffffffc0203c96 <do_fork+0x3a2>
ffffffffc0203b9a:	000c3503          	ld	a0,0(s8)
ffffffffc0203b9e:	415787b3          	sub	a5,a5,s5
ffffffffc0203ba2:	079a                	slli	a5,a5,0x6
ffffffffc0203ba4:	4589                	li	a1,2
ffffffffc0203ba6:	953e                	add	a0,a0,a5
ffffffffc0203ba8:	a34fd0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0203bac:	8522                	mv	a0,s0
ffffffffc0203bae:	d72fe0ef          	jal	ra,ffffffffc0202120 <kfree>
ffffffffc0203bb2:	5571                	li	a0,-4
ffffffffc0203bb4:	bdfd                	j	ffffffffc0203ab2 <do_fork+0x1be>
ffffffffc0203bb6:	a7dfc0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203bba:	bdc5                	j	ffffffffc0203aaa <do_fork+0x1b6>
ffffffffc0203bbc:	01d7c363          	blt	a5,t4,ffffffffc0203bc2 <do_fork+0x2ce>
ffffffffc0203bc0:	4785                	li	a5,1
ffffffffc0203bc2:	4805                	li	a6,1
ffffffffc0203bc4:	bf0d                	j	ffffffffc0203af6 <do_fork+0x202>
ffffffffc0203bc6:	038b0d93          	addi	s11,s6,56
ffffffffc0203bca:	856e                	mv	a0,s11
ffffffffc0203bcc:	f16ff0ef          	jal	ra,ffffffffc02032e2 <down>
ffffffffc0203bd0:	000bb783          	ld	a5,0(s7)
ffffffffc0203bd4:	c781                	beqz	a5,ffffffffc0203bdc <do_fork+0x2e8>
ffffffffc0203bd6:	43dc                	lw	a5,4(a5)
ffffffffc0203bd8:	04fb2823          	sw	a5,80(s6)
ffffffffc0203bdc:	85da                	mv	a1,s6
ffffffffc0203bde:	8552                	mv	a0,s4
ffffffffc0203be0:	db9fd0ef          	jal	ra,ffffffffc0201998 <dup_mmap>
ffffffffc0203be4:	8baa                	mv	s7,a0
ffffffffc0203be6:	856e                	mv	a0,s11
ffffffffc0203be8:	ef8ff0ef          	jal	ra,ffffffffc02032e0 <up>
ffffffffc0203bec:	040b2823          	sw	zero,80(s6)
ffffffffc0203bf0:	8b52                	mv	s6,s4
ffffffffc0203bf2:	da0b8ce3          	beqz	s7,ffffffffc02039aa <do_fork+0xb6>
ffffffffc0203bf6:	8552                	mv	a0,s4
ffffffffc0203bf8:	e3bfd0ef          	jal	ra,ffffffffc0201a32 <exit_mmap>
ffffffffc0203bfc:	018a3683          	ld	a3,24(s4)
ffffffffc0203c00:	c02007b7          	lui	a5,0xc0200
ffffffffc0203c04:	0af6e563          	bltu	a3,a5,ffffffffc0203cae <do_fork+0x3ba>
ffffffffc0203c08:	000d3703          	ld	a4,0(s10)
ffffffffc0203c0c:	000cb783          	ld	a5,0(s9)
ffffffffc0203c10:	8e99                	sub	a3,a3,a4
ffffffffc0203c12:	82b1                	srli	a3,a3,0xc
ffffffffc0203c14:	08f6f163          	bgeu	a3,a5,ffffffffc0203c96 <do_fork+0x3a2>
ffffffffc0203c18:	000c3503          	ld	a0,0(s8)
ffffffffc0203c1c:	415686b3          	sub	a3,a3,s5
ffffffffc0203c20:	069a                	slli	a3,a3,0x6
ffffffffc0203c22:	9536                	add	a0,a0,a3
ffffffffc0203c24:	4585                	li	a1,1
ffffffffc0203c26:	9b6fd0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0203c2a:	8552                	mv	a0,s4
ffffffffc0203c2c:	c6bfd0ef          	jal	ra,ffffffffc0201896 <mm_destroy>
ffffffffc0203c30:	b7b9                	j	ffffffffc0203b7e <do_fork+0x28a>
ffffffffc0203c32:	00080763          	beqz	a6,ffffffffc0203c40 <do_fork+0x34c>
ffffffffc0203c36:	c19c                	sw	a5,0(a1)
ffffffffc0203c38:	853e                	mv	a0,a5
ffffffffc0203c3a:	bd31                	j	ffffffffc0203a56 <do_fork+0x162>
ffffffffc0203c3c:	556d                	li	a0,-5
ffffffffc0203c3e:	bd95                	j	ffffffffc0203ab2 <do_fork+0x1be>
ffffffffc0203c40:	4188                	lw	a0,0(a1)
ffffffffc0203c42:	bd11                	j	ffffffffc0203a56 <do_fork+0x162>
ffffffffc0203c44:	00005617          	auipc	a2,0x5
ffffffffc0203c48:	d6460613          	addi	a2,a2,-668 # ffffffffc02089a8 <commands+0x7c0>
ffffffffc0203c4c:	06900593          	li	a1,105
ffffffffc0203c50:	00005517          	auipc	a0,0x5
ffffffffc0203c54:	cb850513          	addi	a0,a0,-840 # ffffffffc0208908 <commands+0x720>
ffffffffc0203c58:	db0fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203c5c:	00006697          	auipc	a3,0x6
ffffffffc0203c60:	87c68693          	addi	a3,a3,-1924 # ffffffffc02094d8 <default_pmm_manager+0x1a0>
ffffffffc0203c64:	00005617          	auipc	a2,0x5
ffffffffc0203c68:	99460613          	addi	a2,a2,-1644 # ffffffffc02085f8 <commands+0x410>
ffffffffc0203c6c:	1a600593          	li	a1,422
ffffffffc0203c70:	00006517          	auipc	a0,0x6
ffffffffc0203c74:	88850513          	addi	a0,a0,-1912 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc0203c78:	d90fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203c7c:	86be                	mv	a3,a5
ffffffffc0203c7e:	00005617          	auipc	a2,0x5
ffffffffc0203c82:	cf260613          	addi	a2,a2,-782 # ffffffffc0208970 <commands+0x788>
ffffffffc0203c86:	15900593          	li	a1,345
ffffffffc0203c8a:	00006517          	auipc	a0,0x6
ffffffffc0203c8e:	86e50513          	addi	a0,a0,-1938 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc0203c92:	d76fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203c96:	00005617          	auipc	a2,0x5
ffffffffc0203c9a:	c5260613          	addi	a2,a2,-942 # ffffffffc02088e8 <commands+0x700>
ffffffffc0203c9e:	06200593          	li	a1,98
ffffffffc0203ca2:	00005517          	auipc	a0,0x5
ffffffffc0203ca6:	c6650513          	addi	a0,a0,-922 # ffffffffc0208908 <commands+0x720>
ffffffffc0203caa:	d5efc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203cae:	00005617          	auipc	a2,0x5
ffffffffc0203cb2:	cc260613          	addi	a2,a2,-830 # ffffffffc0208970 <commands+0x788>
ffffffffc0203cb6:	06e00593          	li	a1,110
ffffffffc0203cba:	00005517          	auipc	a0,0x5
ffffffffc0203cbe:	c4e50513          	addi	a0,a0,-946 # ffffffffc0208908 <commands+0x720>
ffffffffc0203cc2:	d46fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203cc6 <kernel_thread>:
ffffffffc0203cc6:	7129                	addi	sp,sp,-320
ffffffffc0203cc8:	fa22                	sd	s0,304(sp)
ffffffffc0203cca:	f626                	sd	s1,296(sp)
ffffffffc0203ccc:	f24a                	sd	s2,288(sp)
ffffffffc0203cce:	84ae                	mv	s1,a1
ffffffffc0203cd0:	892a                	mv	s2,a0
ffffffffc0203cd2:	8432                	mv	s0,a2
ffffffffc0203cd4:	4581                	li	a1,0
ffffffffc0203cd6:	12000613          	li	a2,288
ffffffffc0203cda:	850a                	mv	a0,sp
ffffffffc0203cdc:	fe06                	sd	ra,312(sp)
ffffffffc0203cde:	639030ef          	jal	ra,ffffffffc0207b16 <memset>
ffffffffc0203ce2:	e0ca                	sd	s2,64(sp)
ffffffffc0203ce4:	e4a6                	sd	s1,72(sp)
ffffffffc0203ce6:	100027f3          	csrr	a5,sstatus
ffffffffc0203cea:	edd7f793          	andi	a5,a5,-291
ffffffffc0203cee:	1207e793          	ori	a5,a5,288
ffffffffc0203cf2:	e23e                	sd	a5,256(sp)
ffffffffc0203cf4:	860a                	mv	a2,sp
ffffffffc0203cf6:	10046513          	ori	a0,s0,256
ffffffffc0203cfa:	00000797          	auipc	a5,0x0
ffffffffc0203cfe:	99878793          	addi	a5,a5,-1640 # ffffffffc0203692 <kernel_thread_entry>
ffffffffc0203d02:	4581                	li	a1,0
ffffffffc0203d04:	e63e                	sd	a5,264(sp)
ffffffffc0203d06:	befff0ef          	jal	ra,ffffffffc02038f4 <do_fork>
ffffffffc0203d0a:	70f2                	ld	ra,312(sp)
ffffffffc0203d0c:	7452                	ld	s0,304(sp)
ffffffffc0203d0e:	74b2                	ld	s1,296(sp)
ffffffffc0203d10:	7912                	ld	s2,288(sp)
ffffffffc0203d12:	6131                	addi	sp,sp,320
ffffffffc0203d14:	8082                	ret

ffffffffc0203d16 <do_exit>:
ffffffffc0203d16:	7179                	addi	sp,sp,-48
ffffffffc0203d18:	f022                	sd	s0,32(sp)
ffffffffc0203d1a:	00015417          	auipc	s0,0x15
ffffffffc0203d1e:	7de40413          	addi	s0,s0,2014 # ffffffffc02194f8 <current>
ffffffffc0203d22:	601c                	ld	a5,0(s0)
ffffffffc0203d24:	f406                	sd	ra,40(sp)
ffffffffc0203d26:	ec26                	sd	s1,24(sp)
ffffffffc0203d28:	e84a                	sd	s2,16(sp)
ffffffffc0203d2a:	e44e                	sd	s3,8(sp)
ffffffffc0203d2c:	e052                	sd	s4,0(sp)
ffffffffc0203d2e:	00015717          	auipc	a4,0x15
ffffffffc0203d32:	7d273703          	ld	a4,2002(a4) # ffffffffc0219500 <idleproc>
ffffffffc0203d36:	0ce78d63          	beq	a5,a4,ffffffffc0203e10 <do_exit+0xfa>
ffffffffc0203d3a:	00015497          	auipc	s1,0x15
ffffffffc0203d3e:	7ce48493          	addi	s1,s1,1998 # ffffffffc0219508 <initproc>
ffffffffc0203d42:	6098                	ld	a4,0(s1)
ffffffffc0203d44:	12e78963          	beq	a5,a4,ffffffffc0203e76 <do_exit+0x160>
ffffffffc0203d48:	0287b903          	ld	s2,40(a5)
ffffffffc0203d4c:	89aa                	mv	s3,a0
ffffffffc0203d4e:	02090663          	beqz	s2,ffffffffc0203d7a <do_exit+0x64>
ffffffffc0203d52:	00015797          	auipc	a5,0x15
ffffffffc0203d56:	7ee7b783          	ld	a5,2030(a5) # ffffffffc0219540 <boot_cr3>
ffffffffc0203d5a:	577d                	li	a4,-1
ffffffffc0203d5c:	177e                	slli	a4,a4,0x3f
ffffffffc0203d5e:	83b1                	srli	a5,a5,0xc
ffffffffc0203d60:	8fd9                	or	a5,a5,a4
ffffffffc0203d62:	18079073          	csrw	satp,a5
ffffffffc0203d66:	03092783          	lw	a5,48(s2)
ffffffffc0203d6a:	fff7871b          	addiw	a4,a5,-1
ffffffffc0203d6e:	02e92823          	sw	a4,48(s2)
ffffffffc0203d72:	cb5d                	beqz	a4,ffffffffc0203e28 <do_exit+0x112>
ffffffffc0203d74:	601c                	ld	a5,0(s0)
ffffffffc0203d76:	0207b423          	sd	zero,40(a5)
ffffffffc0203d7a:	601c                	ld	a5,0(s0)
ffffffffc0203d7c:	470d                	li	a4,3
ffffffffc0203d7e:	c398                	sw	a4,0(a5)
ffffffffc0203d80:	0f37a423          	sw	s3,232(a5)
ffffffffc0203d84:	100027f3          	csrr	a5,sstatus
ffffffffc0203d88:	8b89                	andi	a5,a5,2
ffffffffc0203d8a:	4a01                	li	s4,0
ffffffffc0203d8c:	10079163          	bnez	a5,ffffffffc0203e8e <do_exit+0x178>
ffffffffc0203d90:	6018                	ld	a4,0(s0)
ffffffffc0203d92:	800007b7          	lui	a5,0x80000
ffffffffc0203d96:	0785                	addi	a5,a5,1
ffffffffc0203d98:	7308                	ld	a0,32(a4)
ffffffffc0203d9a:	0ec52703          	lw	a4,236(a0)
ffffffffc0203d9e:	0ef70c63          	beq	a4,a5,ffffffffc0203e96 <do_exit+0x180>
ffffffffc0203da2:	6018                	ld	a4,0(s0)
ffffffffc0203da4:	7b7c                	ld	a5,240(a4)
ffffffffc0203da6:	c3a1                	beqz	a5,ffffffffc0203de6 <do_exit+0xd0>
ffffffffc0203da8:	800009b7          	lui	s3,0x80000
ffffffffc0203dac:	490d                	li	s2,3
ffffffffc0203dae:	0985                	addi	s3,s3,1
ffffffffc0203db0:	a021                	j	ffffffffc0203db8 <do_exit+0xa2>
ffffffffc0203db2:	6018                	ld	a4,0(s0)
ffffffffc0203db4:	7b7c                	ld	a5,240(a4)
ffffffffc0203db6:	cb85                	beqz	a5,ffffffffc0203de6 <do_exit+0xd0>
ffffffffc0203db8:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <kern_entry-0x401fff00>
ffffffffc0203dbc:	6088                	ld	a0,0(s1)
ffffffffc0203dbe:	fb74                	sd	a3,240(a4)
ffffffffc0203dc0:	7978                	ld	a4,240(a0)
ffffffffc0203dc2:	0e07bc23          	sd	zero,248(a5)
ffffffffc0203dc6:	10e7b023          	sd	a4,256(a5)
ffffffffc0203dca:	c311                	beqz	a4,ffffffffc0203dce <do_exit+0xb8>
ffffffffc0203dcc:	ff7c                	sd	a5,248(a4)
ffffffffc0203dce:	4398                	lw	a4,0(a5)
ffffffffc0203dd0:	f388                	sd	a0,32(a5)
ffffffffc0203dd2:	f97c                	sd	a5,240(a0)
ffffffffc0203dd4:	fd271fe3          	bne	a4,s2,ffffffffc0203db2 <do_exit+0x9c>
ffffffffc0203dd8:	0ec52783          	lw	a5,236(a0)
ffffffffc0203ddc:	fd379be3          	bne	a5,s3,ffffffffc0203db2 <do_exit+0x9c>
ffffffffc0203de0:	3ff000ef          	jal	ra,ffffffffc02049de <wakeup_proc>
ffffffffc0203de4:	b7f9                	j	ffffffffc0203db2 <do_exit+0x9c>
ffffffffc0203de6:	020a1263          	bnez	s4,ffffffffc0203e0a <do_exit+0xf4>
ffffffffc0203dea:	4a7000ef          	jal	ra,ffffffffc0204a90 <schedule>
ffffffffc0203dee:	601c                	ld	a5,0(s0)
ffffffffc0203df0:	00005617          	auipc	a2,0x5
ffffffffc0203df4:	74060613          	addi	a2,a2,1856 # ffffffffc0209530 <default_pmm_manager+0x1f8>
ffffffffc0203df8:	1f900593          	li	a1,505
ffffffffc0203dfc:	43d4                	lw	a3,4(a5)
ffffffffc0203dfe:	00005517          	auipc	a0,0x5
ffffffffc0203e02:	6fa50513          	addi	a0,a0,1786 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc0203e06:	c02fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203e0a:	829fc0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203e0e:	bff1                	j	ffffffffc0203dea <do_exit+0xd4>
ffffffffc0203e10:	00005617          	auipc	a2,0x5
ffffffffc0203e14:	70060613          	addi	a2,a2,1792 # ffffffffc0209510 <default_pmm_manager+0x1d8>
ffffffffc0203e18:	1cd00593          	li	a1,461
ffffffffc0203e1c:	00005517          	auipc	a0,0x5
ffffffffc0203e20:	6dc50513          	addi	a0,a0,1756 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc0203e24:	be4fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203e28:	854a                	mv	a0,s2
ffffffffc0203e2a:	c09fd0ef          	jal	ra,ffffffffc0201a32 <exit_mmap>
ffffffffc0203e2e:	01893683          	ld	a3,24(s2)
ffffffffc0203e32:	c02007b7          	lui	a5,0xc0200
ffffffffc0203e36:	06f6e363          	bltu	a3,a5,ffffffffc0203e9c <do_exit+0x186>
ffffffffc0203e3a:	00015797          	auipc	a5,0x15
ffffffffc0203e3e:	6fe7b783          	ld	a5,1790(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc0203e42:	8e9d                	sub	a3,a3,a5
ffffffffc0203e44:	82b1                	srli	a3,a3,0xc
ffffffffc0203e46:	00015797          	auipc	a5,0x15
ffffffffc0203e4a:	68a7b783          	ld	a5,1674(a5) # ffffffffc02194d0 <npage>
ffffffffc0203e4e:	06f6f363          	bgeu	a3,a5,ffffffffc0203eb4 <do_exit+0x19e>
ffffffffc0203e52:	00006517          	auipc	a0,0x6
ffffffffc0203e56:	74653503          	ld	a0,1862(a0) # ffffffffc020a598 <nbase>
ffffffffc0203e5a:	8e89                	sub	a3,a3,a0
ffffffffc0203e5c:	069a                	slli	a3,a3,0x6
ffffffffc0203e5e:	00015517          	auipc	a0,0x15
ffffffffc0203e62:	6ea53503          	ld	a0,1770(a0) # ffffffffc0219548 <pages>
ffffffffc0203e66:	9536                	add	a0,a0,a3
ffffffffc0203e68:	4585                	li	a1,1
ffffffffc0203e6a:	f73fc0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0203e6e:	854a                	mv	a0,s2
ffffffffc0203e70:	a27fd0ef          	jal	ra,ffffffffc0201896 <mm_destroy>
ffffffffc0203e74:	b701                	j	ffffffffc0203d74 <do_exit+0x5e>
ffffffffc0203e76:	00005617          	auipc	a2,0x5
ffffffffc0203e7a:	6aa60613          	addi	a2,a2,1706 # ffffffffc0209520 <default_pmm_manager+0x1e8>
ffffffffc0203e7e:	1d000593          	li	a1,464
ffffffffc0203e82:	00005517          	auipc	a0,0x5
ffffffffc0203e86:	67650513          	addi	a0,a0,1654 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc0203e8a:	b7efc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203e8e:	faafc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203e92:	4a05                	li	s4,1
ffffffffc0203e94:	bdf5                	j	ffffffffc0203d90 <do_exit+0x7a>
ffffffffc0203e96:	349000ef          	jal	ra,ffffffffc02049de <wakeup_proc>
ffffffffc0203e9a:	b721                	j	ffffffffc0203da2 <do_exit+0x8c>
ffffffffc0203e9c:	00005617          	auipc	a2,0x5
ffffffffc0203ea0:	ad460613          	addi	a2,a2,-1324 # ffffffffc0208970 <commands+0x788>
ffffffffc0203ea4:	06e00593          	li	a1,110
ffffffffc0203ea8:	00005517          	auipc	a0,0x5
ffffffffc0203eac:	a6050513          	addi	a0,a0,-1440 # ffffffffc0208908 <commands+0x720>
ffffffffc0203eb0:	b58fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203eb4:	00005617          	auipc	a2,0x5
ffffffffc0203eb8:	a3460613          	addi	a2,a2,-1484 # ffffffffc02088e8 <commands+0x700>
ffffffffc0203ebc:	06200593          	li	a1,98
ffffffffc0203ec0:	00005517          	auipc	a0,0x5
ffffffffc0203ec4:	a4850513          	addi	a0,a0,-1464 # ffffffffc0208908 <commands+0x720>
ffffffffc0203ec8:	b40fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203ecc <do_wait.part.0>:
ffffffffc0203ecc:	7139                	addi	sp,sp,-64
ffffffffc0203ece:	e852                	sd	s4,16(sp)
ffffffffc0203ed0:	80000a37          	lui	s4,0x80000
ffffffffc0203ed4:	f426                	sd	s1,40(sp)
ffffffffc0203ed6:	f04a                	sd	s2,32(sp)
ffffffffc0203ed8:	ec4e                	sd	s3,24(sp)
ffffffffc0203eda:	e456                	sd	s5,8(sp)
ffffffffc0203edc:	e05a                	sd	s6,0(sp)
ffffffffc0203ede:	fc06                	sd	ra,56(sp)
ffffffffc0203ee0:	f822                	sd	s0,48(sp)
ffffffffc0203ee2:	892a                	mv	s2,a0
ffffffffc0203ee4:	8aae                	mv	s5,a1
ffffffffc0203ee6:	00015997          	auipc	s3,0x15
ffffffffc0203eea:	61298993          	addi	s3,s3,1554 # ffffffffc02194f8 <current>
ffffffffc0203eee:	448d                	li	s1,3
ffffffffc0203ef0:	4b05                	li	s6,1
ffffffffc0203ef2:	2a05                	addiw	s4,s4,1
ffffffffc0203ef4:	02090f63          	beqz	s2,ffffffffc0203f32 <do_wait.part.0+0x66>
ffffffffc0203ef8:	854a                	mv	a0,s2
ffffffffc0203efa:	9a3ff0ef          	jal	ra,ffffffffc020389c <find_proc>
ffffffffc0203efe:	842a                	mv	s0,a0
ffffffffc0203f00:	10050763          	beqz	a0,ffffffffc020400e <do_wait.part.0+0x142>
ffffffffc0203f04:	0009b703          	ld	a4,0(s3)
ffffffffc0203f08:	711c                	ld	a5,32(a0)
ffffffffc0203f0a:	10e79263          	bne	a5,a4,ffffffffc020400e <do_wait.part.0+0x142>
ffffffffc0203f0e:	411c                	lw	a5,0(a0)
ffffffffc0203f10:	02978c63          	beq	a5,s1,ffffffffc0203f48 <do_wait.part.0+0x7c>
ffffffffc0203f14:	01672023          	sw	s6,0(a4)
ffffffffc0203f18:	0f472623          	sw	s4,236(a4)
ffffffffc0203f1c:	375000ef          	jal	ra,ffffffffc0204a90 <schedule>
ffffffffc0203f20:	0009b783          	ld	a5,0(s3)
ffffffffc0203f24:	0b07a783          	lw	a5,176(a5)
ffffffffc0203f28:	8b85                	andi	a5,a5,1
ffffffffc0203f2a:	d7e9                	beqz	a5,ffffffffc0203ef4 <do_wait.part.0+0x28>
ffffffffc0203f2c:	555d                	li	a0,-9
ffffffffc0203f2e:	de9ff0ef          	jal	ra,ffffffffc0203d16 <do_exit>
ffffffffc0203f32:	0009b703          	ld	a4,0(s3)
ffffffffc0203f36:	7b60                	ld	s0,240(a4)
ffffffffc0203f38:	e409                	bnez	s0,ffffffffc0203f42 <do_wait.part.0+0x76>
ffffffffc0203f3a:	a8d1                	j	ffffffffc020400e <do_wait.part.0+0x142>
ffffffffc0203f3c:	10043403          	ld	s0,256(s0)
ffffffffc0203f40:	d871                	beqz	s0,ffffffffc0203f14 <do_wait.part.0+0x48>
ffffffffc0203f42:	401c                	lw	a5,0(s0)
ffffffffc0203f44:	fe979ce3          	bne	a5,s1,ffffffffc0203f3c <do_wait.part.0+0x70>
ffffffffc0203f48:	00015797          	auipc	a5,0x15
ffffffffc0203f4c:	5b87b783          	ld	a5,1464(a5) # ffffffffc0219500 <idleproc>
ffffffffc0203f50:	0c878563          	beq	a5,s0,ffffffffc020401a <do_wait.part.0+0x14e>
ffffffffc0203f54:	00015797          	auipc	a5,0x15
ffffffffc0203f58:	5b47b783          	ld	a5,1460(a5) # ffffffffc0219508 <initproc>
ffffffffc0203f5c:	0af40f63          	beq	s0,a5,ffffffffc020401a <do_wait.part.0+0x14e>
ffffffffc0203f60:	000a8663          	beqz	s5,ffffffffc0203f6c <do_wait.part.0+0xa0>
ffffffffc0203f64:	0e842783          	lw	a5,232(s0)
ffffffffc0203f68:	00faa023          	sw	a5,0(s5)
ffffffffc0203f6c:	100027f3          	csrr	a5,sstatus
ffffffffc0203f70:	8b89                	andi	a5,a5,2
ffffffffc0203f72:	4581                	li	a1,0
ffffffffc0203f74:	efd9                	bnez	a5,ffffffffc0204012 <do_wait.part.0+0x146>
ffffffffc0203f76:	6c70                	ld	a2,216(s0)
ffffffffc0203f78:	7074                	ld	a3,224(s0)
ffffffffc0203f7a:	10043703          	ld	a4,256(s0)
ffffffffc0203f7e:	7c7c                	ld	a5,248(s0)
ffffffffc0203f80:	e614                	sd	a3,8(a2)
ffffffffc0203f82:	e290                	sd	a2,0(a3)
ffffffffc0203f84:	6470                	ld	a2,200(s0)
ffffffffc0203f86:	6874                	ld	a3,208(s0)
ffffffffc0203f88:	e614                	sd	a3,8(a2)
ffffffffc0203f8a:	e290                	sd	a2,0(a3)
ffffffffc0203f8c:	c319                	beqz	a4,ffffffffc0203f92 <do_wait.part.0+0xc6>
ffffffffc0203f8e:	ff7c                	sd	a5,248(a4)
ffffffffc0203f90:	7c7c                	ld	a5,248(s0)
ffffffffc0203f92:	cbbd                	beqz	a5,ffffffffc0204008 <do_wait.part.0+0x13c>
ffffffffc0203f94:	10e7b023          	sd	a4,256(a5)
ffffffffc0203f98:	00015717          	auipc	a4,0x15
ffffffffc0203f9c:	57870713          	addi	a4,a4,1400 # ffffffffc0219510 <nr_process>
ffffffffc0203fa0:	431c                	lw	a5,0(a4)
ffffffffc0203fa2:	37fd                	addiw	a5,a5,-1
ffffffffc0203fa4:	c31c                	sw	a5,0(a4)
ffffffffc0203fa6:	edb1                	bnez	a1,ffffffffc0204002 <do_wait.part.0+0x136>
ffffffffc0203fa8:	6814                	ld	a3,16(s0)
ffffffffc0203faa:	c02007b7          	lui	a5,0xc0200
ffffffffc0203fae:	08f6ee63          	bltu	a3,a5,ffffffffc020404a <do_wait.part.0+0x17e>
ffffffffc0203fb2:	00015797          	auipc	a5,0x15
ffffffffc0203fb6:	5867b783          	ld	a5,1414(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc0203fba:	8e9d                	sub	a3,a3,a5
ffffffffc0203fbc:	82b1                	srli	a3,a3,0xc
ffffffffc0203fbe:	00015797          	auipc	a5,0x15
ffffffffc0203fc2:	5127b783          	ld	a5,1298(a5) # ffffffffc02194d0 <npage>
ffffffffc0203fc6:	06f6f663          	bgeu	a3,a5,ffffffffc0204032 <do_wait.part.0+0x166>
ffffffffc0203fca:	00006517          	auipc	a0,0x6
ffffffffc0203fce:	5ce53503          	ld	a0,1486(a0) # ffffffffc020a598 <nbase>
ffffffffc0203fd2:	8e89                	sub	a3,a3,a0
ffffffffc0203fd4:	069a                	slli	a3,a3,0x6
ffffffffc0203fd6:	00015517          	auipc	a0,0x15
ffffffffc0203fda:	57253503          	ld	a0,1394(a0) # ffffffffc0219548 <pages>
ffffffffc0203fde:	9536                	add	a0,a0,a3
ffffffffc0203fe0:	4589                	li	a1,2
ffffffffc0203fe2:	dfbfc0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0203fe6:	8522                	mv	a0,s0
ffffffffc0203fe8:	938fe0ef          	jal	ra,ffffffffc0202120 <kfree>
ffffffffc0203fec:	4501                	li	a0,0
ffffffffc0203fee:	70e2                	ld	ra,56(sp)
ffffffffc0203ff0:	7442                	ld	s0,48(sp)
ffffffffc0203ff2:	74a2                	ld	s1,40(sp)
ffffffffc0203ff4:	7902                	ld	s2,32(sp)
ffffffffc0203ff6:	69e2                	ld	s3,24(sp)
ffffffffc0203ff8:	6a42                	ld	s4,16(sp)
ffffffffc0203ffa:	6aa2                	ld	s5,8(sp)
ffffffffc0203ffc:	6b02                	ld	s6,0(sp)
ffffffffc0203ffe:	6121                	addi	sp,sp,64
ffffffffc0204000:	8082                	ret
ffffffffc0204002:	e30fc0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0204006:	b74d                	j	ffffffffc0203fa8 <do_wait.part.0+0xdc>
ffffffffc0204008:	701c                	ld	a5,32(s0)
ffffffffc020400a:	fbf8                	sd	a4,240(a5)
ffffffffc020400c:	b771                	j	ffffffffc0203f98 <do_wait.part.0+0xcc>
ffffffffc020400e:	5579                	li	a0,-2
ffffffffc0204010:	bff9                	j	ffffffffc0203fee <do_wait.part.0+0x122>
ffffffffc0204012:	e26fc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204016:	4585                	li	a1,1
ffffffffc0204018:	bfb9                	j	ffffffffc0203f76 <do_wait.part.0+0xaa>
ffffffffc020401a:	00005617          	auipc	a2,0x5
ffffffffc020401e:	53660613          	addi	a2,a2,1334 # ffffffffc0209550 <default_pmm_manager+0x218>
ffffffffc0204022:	2f600593          	li	a1,758
ffffffffc0204026:	00005517          	auipc	a0,0x5
ffffffffc020402a:	4d250513          	addi	a0,a0,1234 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc020402e:	9dafc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204032:	00005617          	auipc	a2,0x5
ffffffffc0204036:	8b660613          	addi	a2,a2,-1866 # ffffffffc02088e8 <commands+0x700>
ffffffffc020403a:	06200593          	li	a1,98
ffffffffc020403e:	00005517          	auipc	a0,0x5
ffffffffc0204042:	8ca50513          	addi	a0,a0,-1846 # ffffffffc0208908 <commands+0x720>
ffffffffc0204046:	9c2fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020404a:	00005617          	auipc	a2,0x5
ffffffffc020404e:	92660613          	addi	a2,a2,-1754 # ffffffffc0208970 <commands+0x788>
ffffffffc0204052:	06e00593          	li	a1,110
ffffffffc0204056:	00005517          	auipc	a0,0x5
ffffffffc020405a:	8b250513          	addi	a0,a0,-1870 # ffffffffc0208908 <commands+0x720>
ffffffffc020405e:	9aafc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204062 <init_main>:
ffffffffc0204062:	1141                	addi	sp,sp,-16
ffffffffc0204064:	e406                	sd	ra,8(sp)
ffffffffc0204066:	db9fc0ef          	jal	ra,ffffffffc0200e1e <nr_free_pages>
ffffffffc020406a:	802fe0ef          	jal	ra,ffffffffc020206c <kallocated>
ffffffffc020406e:	bd8ff0ef          	jal	ra,ffffffffc0203446 <check_exercise>
ffffffffc0204072:	a019                	j	ffffffffc0204078 <init_main+0x16>
ffffffffc0204074:	21d000ef          	jal	ra,ffffffffc0204a90 <schedule>
ffffffffc0204078:	4581                	li	a1,0
ffffffffc020407a:	4501                	li	a0,0
ffffffffc020407c:	e51ff0ef          	jal	ra,ffffffffc0203ecc <do_wait.part.0>
ffffffffc0204080:	d975                	beqz	a0,ffffffffc0204074 <init_main+0x12>
ffffffffc0204082:	00005517          	auipc	a0,0x5
ffffffffc0204086:	4ee50513          	addi	a0,a0,1262 # ffffffffc0209570 <default_pmm_manager+0x238>
ffffffffc020408a:	842fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020408e:	00015797          	auipc	a5,0x15
ffffffffc0204092:	47a7b783          	ld	a5,1146(a5) # ffffffffc0219508 <initproc>
ffffffffc0204096:	7bf8                	ld	a4,240(a5)
ffffffffc0204098:	e339                	bnez	a4,ffffffffc02040de <init_main+0x7c>
ffffffffc020409a:	7ff8                	ld	a4,248(a5)
ffffffffc020409c:	e329                	bnez	a4,ffffffffc02040de <init_main+0x7c>
ffffffffc020409e:	1007b703          	ld	a4,256(a5)
ffffffffc02040a2:	ef15                	bnez	a4,ffffffffc02040de <init_main+0x7c>
ffffffffc02040a4:	00015697          	auipc	a3,0x15
ffffffffc02040a8:	46c6a683          	lw	a3,1132(a3) # ffffffffc0219510 <nr_process>
ffffffffc02040ac:	4709                	li	a4,2
ffffffffc02040ae:	08e69863          	bne	a3,a4,ffffffffc020413e <init_main+0xdc>
ffffffffc02040b2:	00015717          	auipc	a4,0x15
ffffffffc02040b6:	64670713          	addi	a4,a4,1606 # ffffffffc02196f8 <proc_list>
ffffffffc02040ba:	6714                	ld	a3,8(a4)
ffffffffc02040bc:	0c878793          	addi	a5,a5,200
ffffffffc02040c0:	04d79f63          	bne	a5,a3,ffffffffc020411e <init_main+0xbc>
ffffffffc02040c4:	6318                	ld	a4,0(a4)
ffffffffc02040c6:	02e79c63          	bne	a5,a4,ffffffffc02040fe <init_main+0x9c>
ffffffffc02040ca:	00005517          	auipc	a0,0x5
ffffffffc02040ce:	58e50513          	addi	a0,a0,1422 # ffffffffc0209658 <default_pmm_manager+0x320>
ffffffffc02040d2:	ffbfb0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02040d6:	60a2                	ld	ra,8(sp)
ffffffffc02040d8:	4501                	li	a0,0
ffffffffc02040da:	0141                	addi	sp,sp,16
ffffffffc02040dc:	8082                	ret
ffffffffc02040de:	00005697          	auipc	a3,0x5
ffffffffc02040e2:	4ba68693          	addi	a3,a3,1210 # ffffffffc0209598 <default_pmm_manager+0x260>
ffffffffc02040e6:	00004617          	auipc	a2,0x4
ffffffffc02040ea:	51260613          	addi	a2,a2,1298 # ffffffffc02085f8 <commands+0x410>
ffffffffc02040ee:	36200593          	li	a1,866
ffffffffc02040f2:	00005517          	auipc	a0,0x5
ffffffffc02040f6:	40650513          	addi	a0,a0,1030 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc02040fa:	90efc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02040fe:	00005697          	auipc	a3,0x5
ffffffffc0204102:	52a68693          	addi	a3,a3,1322 # ffffffffc0209628 <default_pmm_manager+0x2f0>
ffffffffc0204106:	00004617          	auipc	a2,0x4
ffffffffc020410a:	4f260613          	addi	a2,a2,1266 # ffffffffc02085f8 <commands+0x410>
ffffffffc020410e:	36500593          	li	a1,869
ffffffffc0204112:	00005517          	auipc	a0,0x5
ffffffffc0204116:	3e650513          	addi	a0,a0,998 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc020411a:	8eefc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020411e:	00005697          	auipc	a3,0x5
ffffffffc0204122:	4da68693          	addi	a3,a3,1242 # ffffffffc02095f8 <default_pmm_manager+0x2c0>
ffffffffc0204126:	00004617          	auipc	a2,0x4
ffffffffc020412a:	4d260613          	addi	a2,a2,1234 # ffffffffc02085f8 <commands+0x410>
ffffffffc020412e:	36400593          	li	a1,868
ffffffffc0204132:	00005517          	auipc	a0,0x5
ffffffffc0204136:	3c650513          	addi	a0,a0,966 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc020413a:	8cefc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020413e:	00005697          	auipc	a3,0x5
ffffffffc0204142:	4aa68693          	addi	a3,a3,1194 # ffffffffc02095e8 <default_pmm_manager+0x2b0>
ffffffffc0204146:	00004617          	auipc	a2,0x4
ffffffffc020414a:	4b260613          	addi	a2,a2,1202 # ffffffffc02085f8 <commands+0x410>
ffffffffc020414e:	36300593          	li	a1,867
ffffffffc0204152:	00005517          	auipc	a0,0x5
ffffffffc0204156:	3a650513          	addi	a0,a0,934 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc020415a:	8aefc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020415e <do_execve>:
ffffffffc020415e:	7135                	addi	sp,sp,-160
ffffffffc0204160:	f4d6                	sd	s5,104(sp)
ffffffffc0204162:	00015a97          	auipc	s5,0x15
ffffffffc0204166:	396a8a93          	addi	s5,s5,918 # ffffffffc02194f8 <current>
ffffffffc020416a:	000ab783          	ld	a5,0(s5)
ffffffffc020416e:	f8d2                	sd	s4,112(sp)
ffffffffc0204170:	e526                	sd	s1,136(sp)
ffffffffc0204172:	0287ba03          	ld	s4,40(a5)
ffffffffc0204176:	e14a                	sd	s2,128(sp)
ffffffffc0204178:	fcce                	sd	s3,120(sp)
ffffffffc020417a:	892a                	mv	s2,a0
ffffffffc020417c:	84ae                	mv	s1,a1
ffffffffc020417e:	89b2                	mv	s3,a2
ffffffffc0204180:	4681                	li	a3,0
ffffffffc0204182:	862e                	mv	a2,a1
ffffffffc0204184:	85aa                	mv	a1,a0
ffffffffc0204186:	8552                	mv	a0,s4
ffffffffc0204188:	ed06                	sd	ra,152(sp)
ffffffffc020418a:	e922                	sd	s0,144(sp)
ffffffffc020418c:	f0da                	sd	s6,96(sp)
ffffffffc020418e:	ecde                	sd	s7,88(sp)
ffffffffc0204190:	e8e2                	sd	s8,80(sp)
ffffffffc0204192:	e4e6                	sd	s9,72(sp)
ffffffffc0204194:	e0ea                	sd	s10,64(sp)
ffffffffc0204196:	fc6e                	sd	s11,56(sp)
ffffffffc0204198:	a15fd0ef          	jal	ra,ffffffffc0201bac <user_mem_check>
ffffffffc020419c:	46050063          	beqz	a0,ffffffffc02045fc <do_execve+0x49e>
ffffffffc02041a0:	4641                	li	a2,16
ffffffffc02041a2:	4581                	li	a1,0
ffffffffc02041a4:	1008                	addi	a0,sp,32
ffffffffc02041a6:	171030ef          	jal	ra,ffffffffc0207b16 <memset>
ffffffffc02041aa:	47bd                	li	a5,15
ffffffffc02041ac:	8626                	mv	a2,s1
ffffffffc02041ae:	1897ea63          	bltu	a5,s1,ffffffffc0204342 <do_execve+0x1e4>
ffffffffc02041b2:	85ca                	mv	a1,s2
ffffffffc02041b4:	1008                	addi	a0,sp,32
ffffffffc02041b6:	173030ef          	jal	ra,ffffffffc0207b28 <memcpy>
ffffffffc02041ba:	180a0b63          	beqz	s4,ffffffffc0204350 <do_execve+0x1f2>
ffffffffc02041be:	00005517          	auipc	a0,0x5
ffffffffc02041c2:	97250513          	addi	a0,a0,-1678 # ffffffffc0208b30 <commands+0x948>
ffffffffc02041c6:	f3ffb0ef          	jal	ra,ffffffffc0200104 <cputs>
ffffffffc02041ca:	00015797          	auipc	a5,0x15
ffffffffc02041ce:	3767b783          	ld	a5,886(a5) # ffffffffc0219540 <boot_cr3>
ffffffffc02041d2:	577d                	li	a4,-1
ffffffffc02041d4:	177e                	slli	a4,a4,0x3f
ffffffffc02041d6:	83b1                	srli	a5,a5,0xc
ffffffffc02041d8:	8fd9                	or	a5,a5,a4
ffffffffc02041da:	18079073          	csrw	satp,a5
ffffffffc02041de:	030a2783          	lw	a5,48(s4) # ffffffff80000030 <kern_entry-0x401fffd0>
ffffffffc02041e2:	fff7871b          	addiw	a4,a5,-1
ffffffffc02041e6:	02ea2823          	sw	a4,48(s4)
ffffffffc02041ea:	2c070163          	beqz	a4,ffffffffc02044ac <do_execve+0x34e>
ffffffffc02041ee:	000ab783          	ld	a5,0(s5)
ffffffffc02041f2:	0207b423          	sd	zero,40(a5)
ffffffffc02041f6:	d42fd0ef          	jal	ra,ffffffffc0201738 <mm_create>
ffffffffc02041fa:	84aa                	mv	s1,a0
ffffffffc02041fc:	18050263          	beqz	a0,ffffffffc0204380 <do_execve+0x222>
ffffffffc0204200:	0561                	addi	a0,a0,24
ffffffffc0204202:	d82ff0ef          	jal	ra,ffffffffc0203784 <setup_pgdir.isra.0>
ffffffffc0204206:	16051663          	bnez	a0,ffffffffc0204372 <do_execve+0x214>
ffffffffc020420a:	0009a703          	lw	a4,0(s3)
ffffffffc020420e:	464c47b7          	lui	a5,0x464c4
ffffffffc0204212:	57f78793          	addi	a5,a5,1407 # 464c457f <kern_entry-0xffffffff79d3ba81>
ffffffffc0204216:	24f71763          	bne	a4,a5,ffffffffc0204464 <do_execve+0x306>
ffffffffc020421a:	0389d703          	lhu	a4,56(s3)
ffffffffc020421e:	0209b903          	ld	s2,32(s3)
ffffffffc0204222:	00371793          	slli	a5,a4,0x3
ffffffffc0204226:	8f99                	sub	a5,a5,a4
ffffffffc0204228:	994e                	add	s2,s2,s3
ffffffffc020422a:	078e                	slli	a5,a5,0x3
ffffffffc020422c:	97ca                	add	a5,a5,s2
ffffffffc020422e:	ec3e                	sd	a5,24(sp)
ffffffffc0204230:	02f97c63          	bgeu	s2,a5,ffffffffc0204268 <do_execve+0x10a>
ffffffffc0204234:	5bfd                	li	s7,-1
ffffffffc0204236:	00cbd793          	srli	a5,s7,0xc
ffffffffc020423a:	00015d97          	auipc	s11,0x15
ffffffffc020423e:	30ed8d93          	addi	s11,s11,782 # ffffffffc0219548 <pages>
ffffffffc0204242:	00006d17          	auipc	s10,0x6
ffffffffc0204246:	356d0d13          	addi	s10,s10,854 # ffffffffc020a598 <nbase>
ffffffffc020424a:	e43e                	sd	a5,8(sp)
ffffffffc020424c:	00015c97          	auipc	s9,0x15
ffffffffc0204250:	284c8c93          	addi	s9,s9,644 # ffffffffc02194d0 <npage>
ffffffffc0204254:	00092703          	lw	a4,0(s2)
ffffffffc0204258:	4785                	li	a5,1
ffffffffc020425a:	12f70563          	beq	a4,a5,ffffffffc0204384 <do_execve+0x226>
ffffffffc020425e:	67e2                	ld	a5,24(sp)
ffffffffc0204260:	03890913          	addi	s2,s2,56
ffffffffc0204264:	fef968e3          	bltu	s2,a5,ffffffffc0204254 <do_execve+0xf6>
ffffffffc0204268:	4701                	li	a4,0
ffffffffc020426a:	46ad                	li	a3,11
ffffffffc020426c:	00100637          	lui	a2,0x100
ffffffffc0204270:	7ff005b7          	lui	a1,0x7ff00
ffffffffc0204274:	8526                	mv	a0,s1
ffffffffc0204276:	e72fd0ef          	jal	ra,ffffffffc02018e8 <mm_map>
ffffffffc020427a:	8a2a                	mv	s4,a0
ffffffffc020427c:	1e051063          	bnez	a0,ffffffffc020445c <do_execve+0x2fe>
ffffffffc0204280:	6c88                	ld	a0,24(s1)
ffffffffc0204282:	467d                	li	a2,31
ffffffffc0204284:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc0204288:	bfefd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc020428c:	42050e63          	beqz	a0,ffffffffc02046c8 <do_execve+0x56a>
ffffffffc0204290:	6c88                	ld	a0,24(s1)
ffffffffc0204292:	467d                	li	a2,31
ffffffffc0204294:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc0204298:	beefd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc020429c:	40050663          	beqz	a0,ffffffffc02046a8 <do_execve+0x54a>
ffffffffc02042a0:	6c88                	ld	a0,24(s1)
ffffffffc02042a2:	467d                	li	a2,31
ffffffffc02042a4:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc02042a8:	bdefd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc02042ac:	3c050e63          	beqz	a0,ffffffffc0204688 <do_execve+0x52a>
ffffffffc02042b0:	6c88                	ld	a0,24(s1)
ffffffffc02042b2:	467d                	li	a2,31
ffffffffc02042b4:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc02042b8:	bcefd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc02042bc:	3a050663          	beqz	a0,ffffffffc0204668 <do_execve+0x50a>
ffffffffc02042c0:	589c                	lw	a5,48(s1)
ffffffffc02042c2:	000ab603          	ld	a2,0(s5)
ffffffffc02042c6:	6c94                	ld	a3,24(s1)
ffffffffc02042c8:	2785                	addiw	a5,a5,1
ffffffffc02042ca:	d89c                	sw	a5,48(s1)
ffffffffc02042cc:	f604                	sd	s1,40(a2)
ffffffffc02042ce:	c02007b7          	lui	a5,0xc0200
ffffffffc02042d2:	36f6ef63          	bltu	a3,a5,ffffffffc0204650 <do_execve+0x4f2>
ffffffffc02042d6:	00015797          	auipc	a5,0x15
ffffffffc02042da:	2627b783          	ld	a5,610(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc02042de:	8e9d                	sub	a3,a3,a5
ffffffffc02042e0:	577d                	li	a4,-1
ffffffffc02042e2:	00c6d793          	srli	a5,a3,0xc
ffffffffc02042e6:	177e                	slli	a4,a4,0x3f
ffffffffc02042e8:	f654                	sd	a3,168(a2)
ffffffffc02042ea:	8fd9                	or	a5,a5,a4
ffffffffc02042ec:	18079073          	csrw	satp,a5
ffffffffc02042f0:	7240                	ld	s0,160(a2)
ffffffffc02042f2:	4581                	li	a1,0
ffffffffc02042f4:	12000613          	li	a2,288
ffffffffc02042f8:	8522                	mv	a0,s0
ffffffffc02042fa:	10043483          	ld	s1,256(s0)
ffffffffc02042fe:	019030ef          	jal	ra,ffffffffc0207b16 <memset>
ffffffffc0204302:	0189b703          	ld	a4,24(s3)
ffffffffc0204306:	4785                	li	a5,1
ffffffffc0204308:	000ab503          	ld	a0,0(s5)
ffffffffc020430c:	edf4f493          	andi	s1,s1,-289
ffffffffc0204310:	07fe                	slli	a5,a5,0x1f
ffffffffc0204312:	e81c                	sd	a5,16(s0)
ffffffffc0204314:	10e43423          	sd	a4,264(s0)
ffffffffc0204318:	10943023          	sd	s1,256(s0)
ffffffffc020431c:	100c                	addi	a1,sp,32
ffffffffc020431e:	ce8ff0ef          	jal	ra,ffffffffc0203806 <set_proc_name>
ffffffffc0204322:	60ea                	ld	ra,152(sp)
ffffffffc0204324:	644a                	ld	s0,144(sp)
ffffffffc0204326:	64aa                	ld	s1,136(sp)
ffffffffc0204328:	690a                	ld	s2,128(sp)
ffffffffc020432a:	79e6                	ld	s3,120(sp)
ffffffffc020432c:	7aa6                	ld	s5,104(sp)
ffffffffc020432e:	7b06                	ld	s6,96(sp)
ffffffffc0204330:	6be6                	ld	s7,88(sp)
ffffffffc0204332:	6c46                	ld	s8,80(sp)
ffffffffc0204334:	6ca6                	ld	s9,72(sp)
ffffffffc0204336:	6d06                	ld	s10,64(sp)
ffffffffc0204338:	7de2                	ld	s11,56(sp)
ffffffffc020433a:	8552                	mv	a0,s4
ffffffffc020433c:	7a46                	ld	s4,112(sp)
ffffffffc020433e:	610d                	addi	sp,sp,160
ffffffffc0204340:	8082                	ret
ffffffffc0204342:	463d                	li	a2,15
ffffffffc0204344:	85ca                	mv	a1,s2
ffffffffc0204346:	1008                	addi	a0,sp,32
ffffffffc0204348:	7e0030ef          	jal	ra,ffffffffc0207b28 <memcpy>
ffffffffc020434c:	e60a19e3          	bnez	s4,ffffffffc02041be <do_execve+0x60>
ffffffffc0204350:	000ab783          	ld	a5,0(s5)
ffffffffc0204354:	779c                	ld	a5,40(a5)
ffffffffc0204356:	ea0780e3          	beqz	a5,ffffffffc02041f6 <do_execve+0x98>
ffffffffc020435a:	00005617          	auipc	a2,0x5
ffffffffc020435e:	31e60613          	addi	a2,a2,798 # ffffffffc0209678 <default_pmm_manager+0x340>
ffffffffc0204362:	20300593          	li	a1,515
ffffffffc0204366:	00005517          	auipc	a0,0x5
ffffffffc020436a:	19250513          	addi	a0,a0,402 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc020436e:	e9bfb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204372:	8526                	mv	a0,s1
ffffffffc0204374:	d22fd0ef          	jal	ra,ffffffffc0201896 <mm_destroy>
ffffffffc0204378:	5a71                	li	s4,-4
ffffffffc020437a:	8552                	mv	a0,s4
ffffffffc020437c:	99bff0ef          	jal	ra,ffffffffc0203d16 <do_exit>
ffffffffc0204380:	5a71                	li	s4,-4
ffffffffc0204382:	bfe5                	j	ffffffffc020437a <do_execve+0x21c>
ffffffffc0204384:	02893603          	ld	a2,40(s2)
ffffffffc0204388:	02093783          	ld	a5,32(s2)
ffffffffc020438c:	26f66c63          	bltu	a2,a5,ffffffffc0204604 <do_execve+0x4a6>
ffffffffc0204390:	00492783          	lw	a5,4(s2)
ffffffffc0204394:	0017f693          	andi	a3,a5,1
ffffffffc0204398:	c291                	beqz	a3,ffffffffc020439c <do_execve+0x23e>
ffffffffc020439a:	4691                	li	a3,4
ffffffffc020439c:	0027f713          	andi	a4,a5,2
ffffffffc02043a0:	8b91                	andi	a5,a5,4
ffffffffc02043a2:	14071c63          	bnez	a4,ffffffffc02044fa <do_execve+0x39c>
ffffffffc02043a6:	4745                	li	a4,17
ffffffffc02043a8:	e03a                	sd	a4,0(sp)
ffffffffc02043aa:	c789                	beqz	a5,ffffffffc02043b4 <do_execve+0x256>
ffffffffc02043ac:	47cd                	li	a5,19
ffffffffc02043ae:	0016e693          	ori	a3,a3,1
ffffffffc02043b2:	e03e                	sd	a5,0(sp)
ffffffffc02043b4:	0026f793          	andi	a5,a3,2
ffffffffc02043b8:	14079563          	bnez	a5,ffffffffc0204502 <do_execve+0x3a4>
ffffffffc02043bc:	0046f793          	andi	a5,a3,4
ffffffffc02043c0:	c789                	beqz	a5,ffffffffc02043ca <do_execve+0x26c>
ffffffffc02043c2:	6782                	ld	a5,0(sp)
ffffffffc02043c4:	0087e793          	ori	a5,a5,8
ffffffffc02043c8:	e03e                	sd	a5,0(sp)
ffffffffc02043ca:	01093583          	ld	a1,16(s2)
ffffffffc02043ce:	4701                	li	a4,0
ffffffffc02043d0:	8526                	mv	a0,s1
ffffffffc02043d2:	d16fd0ef          	jal	ra,ffffffffc02018e8 <mm_map>
ffffffffc02043d6:	8a2a                	mv	s4,a0
ffffffffc02043d8:	e151                	bnez	a0,ffffffffc020445c <do_execve+0x2fe>
ffffffffc02043da:	01093c03          	ld	s8,16(s2)
ffffffffc02043de:	02093a03          	ld	s4,32(s2)
ffffffffc02043e2:	00893b03          	ld	s6,8(s2)
ffffffffc02043e6:	77fd                	lui	a5,0xfffff
ffffffffc02043e8:	9a62                	add	s4,s4,s8
ffffffffc02043ea:	9b4e                	add	s6,s6,s3
ffffffffc02043ec:	00fc7bb3          	and	s7,s8,a5
ffffffffc02043f0:	054c6e63          	bltu	s8,s4,ffffffffc020444c <do_execve+0x2ee>
ffffffffc02043f4:	a431                	j	ffffffffc0204600 <do_execve+0x4a2>
ffffffffc02043f6:	6785                	lui	a5,0x1
ffffffffc02043f8:	417c0533          	sub	a0,s8,s7
ffffffffc02043fc:	9bbe                	add	s7,s7,a5
ffffffffc02043fe:	418b8633          	sub	a2,s7,s8
ffffffffc0204402:	017a7463          	bgeu	s4,s7,ffffffffc020440a <do_execve+0x2ac>
ffffffffc0204406:	418a0633          	sub	a2,s4,s8
ffffffffc020440a:	000db683          	ld	a3,0(s11)
ffffffffc020440e:	000d3803          	ld	a6,0(s10)
ffffffffc0204412:	67a2                	ld	a5,8(sp)
ffffffffc0204414:	40d406b3          	sub	a3,s0,a3
ffffffffc0204418:	8699                	srai	a3,a3,0x6
ffffffffc020441a:	000cb583          	ld	a1,0(s9)
ffffffffc020441e:	96c2                	add	a3,a3,a6
ffffffffc0204420:	00f6f833          	and	a6,a3,a5
ffffffffc0204424:	06b2                	slli	a3,a3,0xc
ffffffffc0204426:	1eb87163          	bgeu	a6,a1,ffffffffc0204608 <do_execve+0x4aa>
ffffffffc020442a:	00015797          	auipc	a5,0x15
ffffffffc020442e:	10e78793          	addi	a5,a5,270 # ffffffffc0219538 <va_pa_offset>
ffffffffc0204432:	0007b803          	ld	a6,0(a5)
ffffffffc0204436:	85da                	mv	a1,s6
ffffffffc0204438:	9c32                	add	s8,s8,a2
ffffffffc020443a:	96c2                	add	a3,a3,a6
ffffffffc020443c:	9536                	add	a0,a0,a3
ffffffffc020443e:	e832                	sd	a2,16(sp)
ffffffffc0204440:	6e8030ef          	jal	ra,ffffffffc0207b28 <memcpy>
ffffffffc0204444:	6642                	ld	a2,16(sp)
ffffffffc0204446:	9b32                	add	s6,s6,a2
ffffffffc0204448:	0d4c7063          	bgeu	s8,s4,ffffffffc0204508 <do_execve+0x3aa>
ffffffffc020444c:	6c88                	ld	a0,24(s1)
ffffffffc020444e:	6602                	ld	a2,0(sp)
ffffffffc0204450:	85de                	mv	a1,s7
ffffffffc0204452:	a34fd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc0204456:	842a                	mv	s0,a0
ffffffffc0204458:	fd59                	bnez	a0,ffffffffc02043f6 <do_execve+0x298>
ffffffffc020445a:	5a71                	li	s4,-4
ffffffffc020445c:	8526                	mv	a0,s1
ffffffffc020445e:	dd4fd0ef          	jal	ra,ffffffffc0201a32 <exit_mmap>
ffffffffc0204462:	a011                	j	ffffffffc0204466 <do_execve+0x308>
ffffffffc0204464:	5a61                	li	s4,-8
ffffffffc0204466:	6c94                	ld	a3,24(s1)
ffffffffc0204468:	c02007b7          	lui	a5,0xc0200
ffffffffc020446c:	1af6ea63          	bltu	a3,a5,ffffffffc0204620 <do_execve+0x4c2>
ffffffffc0204470:	00015517          	auipc	a0,0x15
ffffffffc0204474:	0c853503          	ld	a0,200(a0) # ffffffffc0219538 <va_pa_offset>
ffffffffc0204478:	8e89                	sub	a3,a3,a0
ffffffffc020447a:	82b1                	srli	a3,a3,0xc
ffffffffc020447c:	00015797          	auipc	a5,0x15
ffffffffc0204480:	0547b783          	ld	a5,84(a5) # ffffffffc02194d0 <npage>
ffffffffc0204484:	1af6fa63          	bgeu	a3,a5,ffffffffc0204638 <do_execve+0x4da>
ffffffffc0204488:	00006517          	auipc	a0,0x6
ffffffffc020448c:	11053503          	ld	a0,272(a0) # ffffffffc020a598 <nbase>
ffffffffc0204490:	8e89                	sub	a3,a3,a0
ffffffffc0204492:	069a                	slli	a3,a3,0x6
ffffffffc0204494:	00015517          	auipc	a0,0x15
ffffffffc0204498:	0b453503          	ld	a0,180(a0) # ffffffffc0219548 <pages>
ffffffffc020449c:	9536                	add	a0,a0,a3
ffffffffc020449e:	4585                	li	a1,1
ffffffffc02044a0:	93dfc0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc02044a4:	8526                	mv	a0,s1
ffffffffc02044a6:	bf0fd0ef          	jal	ra,ffffffffc0201896 <mm_destroy>
ffffffffc02044aa:	bdc1                	j	ffffffffc020437a <do_execve+0x21c>
ffffffffc02044ac:	8552                	mv	a0,s4
ffffffffc02044ae:	d84fd0ef          	jal	ra,ffffffffc0201a32 <exit_mmap>
ffffffffc02044b2:	018a3683          	ld	a3,24(s4)
ffffffffc02044b6:	c02007b7          	lui	a5,0xc0200
ffffffffc02044ba:	16f6e363          	bltu	a3,a5,ffffffffc0204620 <do_execve+0x4c2>
ffffffffc02044be:	00015797          	auipc	a5,0x15
ffffffffc02044c2:	07a7b783          	ld	a5,122(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc02044c6:	8e9d                	sub	a3,a3,a5
ffffffffc02044c8:	82b1                	srli	a3,a3,0xc
ffffffffc02044ca:	00015797          	auipc	a5,0x15
ffffffffc02044ce:	0067b783          	ld	a5,6(a5) # ffffffffc02194d0 <npage>
ffffffffc02044d2:	16f6f363          	bgeu	a3,a5,ffffffffc0204638 <do_execve+0x4da>
ffffffffc02044d6:	00006517          	auipc	a0,0x6
ffffffffc02044da:	0c253503          	ld	a0,194(a0) # ffffffffc020a598 <nbase>
ffffffffc02044de:	8e89                	sub	a3,a3,a0
ffffffffc02044e0:	069a                	slli	a3,a3,0x6
ffffffffc02044e2:	00015517          	auipc	a0,0x15
ffffffffc02044e6:	06653503          	ld	a0,102(a0) # ffffffffc0219548 <pages>
ffffffffc02044ea:	9536                	add	a0,a0,a3
ffffffffc02044ec:	4585                	li	a1,1
ffffffffc02044ee:	8effc0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc02044f2:	8552                	mv	a0,s4
ffffffffc02044f4:	ba2fd0ef          	jal	ra,ffffffffc0201896 <mm_destroy>
ffffffffc02044f8:	b9dd                	j	ffffffffc02041ee <do_execve+0x90>
ffffffffc02044fa:	0026e693          	ori	a3,a3,2
ffffffffc02044fe:	ea0797e3          	bnez	a5,ffffffffc02043ac <do_execve+0x24e>
ffffffffc0204502:	47dd                	li	a5,23
ffffffffc0204504:	e03e                	sd	a5,0(sp)
ffffffffc0204506:	bd5d                	j	ffffffffc02043bc <do_execve+0x25e>
ffffffffc0204508:	01093a03          	ld	s4,16(s2)
ffffffffc020450c:	02893683          	ld	a3,40(s2)
ffffffffc0204510:	9a36                	add	s4,s4,a3
ffffffffc0204512:	077c7f63          	bgeu	s8,s7,ffffffffc0204590 <do_execve+0x432>
ffffffffc0204516:	d58a04e3          	beq	s4,s8,ffffffffc020425e <do_execve+0x100>
ffffffffc020451a:	6505                	lui	a0,0x1
ffffffffc020451c:	9562                	add	a0,a0,s8
ffffffffc020451e:	41750533          	sub	a0,a0,s7
ffffffffc0204522:	418a0b33          	sub	s6,s4,s8
ffffffffc0204526:	0d7a7863          	bgeu	s4,s7,ffffffffc02045f6 <do_execve+0x498>
ffffffffc020452a:	000db683          	ld	a3,0(s11)
ffffffffc020452e:	000d3583          	ld	a1,0(s10)
ffffffffc0204532:	67a2                	ld	a5,8(sp)
ffffffffc0204534:	40d406b3          	sub	a3,s0,a3
ffffffffc0204538:	8699                	srai	a3,a3,0x6
ffffffffc020453a:	000cb603          	ld	a2,0(s9)
ffffffffc020453e:	96ae                	add	a3,a3,a1
ffffffffc0204540:	00f6f5b3          	and	a1,a3,a5
ffffffffc0204544:	06b2                	slli	a3,a3,0xc
ffffffffc0204546:	0cc5f163          	bgeu	a1,a2,ffffffffc0204608 <do_execve+0x4aa>
ffffffffc020454a:	00015617          	auipc	a2,0x15
ffffffffc020454e:	fee63603          	ld	a2,-18(a2) # ffffffffc0219538 <va_pa_offset>
ffffffffc0204552:	96b2                	add	a3,a3,a2
ffffffffc0204554:	4581                	li	a1,0
ffffffffc0204556:	865a                	mv	a2,s6
ffffffffc0204558:	9536                	add	a0,a0,a3
ffffffffc020455a:	5bc030ef          	jal	ra,ffffffffc0207b16 <memset>
ffffffffc020455e:	018b0733          	add	a4,s6,s8
ffffffffc0204562:	037a7463          	bgeu	s4,s7,ffffffffc020458a <do_execve+0x42c>
ffffffffc0204566:	ceea0ce3          	beq	s4,a4,ffffffffc020425e <do_execve+0x100>
ffffffffc020456a:	00005697          	auipc	a3,0x5
ffffffffc020456e:	13668693          	addi	a3,a3,310 # ffffffffc02096a0 <default_pmm_manager+0x368>
ffffffffc0204572:	00004617          	auipc	a2,0x4
ffffffffc0204576:	08660613          	addi	a2,a2,134 # ffffffffc02085f8 <commands+0x410>
ffffffffc020457a:	25800593          	li	a1,600
ffffffffc020457e:	00005517          	auipc	a0,0x5
ffffffffc0204582:	f7a50513          	addi	a0,a0,-134 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc0204586:	c83fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020458a:	ff7710e3          	bne	a4,s7,ffffffffc020456a <do_execve+0x40c>
ffffffffc020458e:	8c5e                	mv	s8,s7
ffffffffc0204590:	00015b17          	auipc	s6,0x15
ffffffffc0204594:	fa8b0b13          	addi	s6,s6,-88 # ffffffffc0219538 <va_pa_offset>
ffffffffc0204598:	054c6763          	bltu	s8,s4,ffffffffc02045e6 <do_execve+0x488>
ffffffffc020459c:	b1c9                	j	ffffffffc020425e <do_execve+0x100>
ffffffffc020459e:	6785                	lui	a5,0x1
ffffffffc02045a0:	417c0533          	sub	a0,s8,s7
ffffffffc02045a4:	9bbe                	add	s7,s7,a5
ffffffffc02045a6:	418b8633          	sub	a2,s7,s8
ffffffffc02045aa:	017a7463          	bgeu	s4,s7,ffffffffc02045b2 <do_execve+0x454>
ffffffffc02045ae:	418a0633          	sub	a2,s4,s8
ffffffffc02045b2:	000db683          	ld	a3,0(s11)
ffffffffc02045b6:	000d3803          	ld	a6,0(s10)
ffffffffc02045ba:	67a2                	ld	a5,8(sp)
ffffffffc02045bc:	40d406b3          	sub	a3,s0,a3
ffffffffc02045c0:	8699                	srai	a3,a3,0x6
ffffffffc02045c2:	000cb583          	ld	a1,0(s9)
ffffffffc02045c6:	96c2                	add	a3,a3,a6
ffffffffc02045c8:	00f6f833          	and	a6,a3,a5
ffffffffc02045cc:	06b2                	slli	a3,a3,0xc
ffffffffc02045ce:	02b87d63          	bgeu	a6,a1,ffffffffc0204608 <do_execve+0x4aa>
ffffffffc02045d2:	000b3803          	ld	a6,0(s6)
ffffffffc02045d6:	9c32                	add	s8,s8,a2
ffffffffc02045d8:	4581                	li	a1,0
ffffffffc02045da:	96c2                	add	a3,a3,a6
ffffffffc02045dc:	9536                	add	a0,a0,a3
ffffffffc02045de:	538030ef          	jal	ra,ffffffffc0207b16 <memset>
ffffffffc02045e2:	c74c7ee3          	bgeu	s8,s4,ffffffffc020425e <do_execve+0x100>
ffffffffc02045e6:	6c88                	ld	a0,24(s1)
ffffffffc02045e8:	6602                	ld	a2,0(sp)
ffffffffc02045ea:	85de                	mv	a1,s7
ffffffffc02045ec:	89afd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc02045f0:	842a                	mv	s0,a0
ffffffffc02045f2:	f555                	bnez	a0,ffffffffc020459e <do_execve+0x440>
ffffffffc02045f4:	b59d                	j	ffffffffc020445a <do_execve+0x2fc>
ffffffffc02045f6:	418b8b33          	sub	s6,s7,s8
ffffffffc02045fa:	bf05                	j	ffffffffc020452a <do_execve+0x3cc>
ffffffffc02045fc:	5a75                	li	s4,-3
ffffffffc02045fe:	b315                	j	ffffffffc0204322 <do_execve+0x1c4>
ffffffffc0204600:	8a62                	mv	s4,s8
ffffffffc0204602:	b729                	j	ffffffffc020450c <do_execve+0x3ae>
ffffffffc0204604:	5a61                	li	s4,-8
ffffffffc0204606:	bd99                	j	ffffffffc020445c <do_execve+0x2fe>
ffffffffc0204608:	00004617          	auipc	a2,0x4
ffffffffc020460c:	3a060613          	addi	a2,a2,928 # ffffffffc02089a8 <commands+0x7c0>
ffffffffc0204610:	06900593          	li	a1,105
ffffffffc0204614:	00004517          	auipc	a0,0x4
ffffffffc0204618:	2f450513          	addi	a0,a0,756 # ffffffffc0208908 <commands+0x720>
ffffffffc020461c:	bedfb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204620:	00004617          	auipc	a2,0x4
ffffffffc0204624:	35060613          	addi	a2,a2,848 # ffffffffc0208970 <commands+0x788>
ffffffffc0204628:	06e00593          	li	a1,110
ffffffffc020462c:	00004517          	auipc	a0,0x4
ffffffffc0204630:	2dc50513          	addi	a0,a0,732 # ffffffffc0208908 <commands+0x720>
ffffffffc0204634:	bd5fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204638:	00004617          	auipc	a2,0x4
ffffffffc020463c:	2b060613          	addi	a2,a2,688 # ffffffffc02088e8 <commands+0x700>
ffffffffc0204640:	06200593          	li	a1,98
ffffffffc0204644:	00004517          	auipc	a0,0x4
ffffffffc0204648:	2c450513          	addi	a0,a0,708 # ffffffffc0208908 <commands+0x720>
ffffffffc020464c:	bbdfb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204650:	00004617          	auipc	a2,0x4
ffffffffc0204654:	32060613          	addi	a2,a2,800 # ffffffffc0208970 <commands+0x788>
ffffffffc0204658:	27300593          	li	a1,627
ffffffffc020465c:	00005517          	auipc	a0,0x5
ffffffffc0204660:	e9c50513          	addi	a0,a0,-356 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc0204664:	ba5fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204668:	00005697          	auipc	a3,0x5
ffffffffc020466c:	15068693          	addi	a3,a3,336 # ffffffffc02097b8 <default_pmm_manager+0x480>
ffffffffc0204670:	00004617          	auipc	a2,0x4
ffffffffc0204674:	f8860613          	addi	a2,a2,-120 # ffffffffc02085f8 <commands+0x410>
ffffffffc0204678:	26e00593          	li	a1,622
ffffffffc020467c:	00005517          	auipc	a0,0x5
ffffffffc0204680:	e7c50513          	addi	a0,a0,-388 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc0204684:	b85fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204688:	00005697          	auipc	a3,0x5
ffffffffc020468c:	0e868693          	addi	a3,a3,232 # ffffffffc0209770 <default_pmm_manager+0x438>
ffffffffc0204690:	00004617          	auipc	a2,0x4
ffffffffc0204694:	f6860613          	addi	a2,a2,-152 # ffffffffc02085f8 <commands+0x410>
ffffffffc0204698:	26d00593          	li	a1,621
ffffffffc020469c:	00005517          	auipc	a0,0x5
ffffffffc02046a0:	e5c50513          	addi	a0,a0,-420 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc02046a4:	b65fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02046a8:	00005697          	auipc	a3,0x5
ffffffffc02046ac:	08068693          	addi	a3,a3,128 # ffffffffc0209728 <default_pmm_manager+0x3f0>
ffffffffc02046b0:	00004617          	auipc	a2,0x4
ffffffffc02046b4:	f4860613          	addi	a2,a2,-184 # ffffffffc02085f8 <commands+0x410>
ffffffffc02046b8:	26c00593          	li	a1,620
ffffffffc02046bc:	00005517          	auipc	a0,0x5
ffffffffc02046c0:	e3c50513          	addi	a0,a0,-452 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc02046c4:	b45fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02046c8:	00005697          	auipc	a3,0x5
ffffffffc02046cc:	01868693          	addi	a3,a3,24 # ffffffffc02096e0 <default_pmm_manager+0x3a8>
ffffffffc02046d0:	00004617          	auipc	a2,0x4
ffffffffc02046d4:	f2860613          	addi	a2,a2,-216 # ffffffffc02085f8 <commands+0x410>
ffffffffc02046d8:	26b00593          	li	a1,619
ffffffffc02046dc:	00005517          	auipc	a0,0x5
ffffffffc02046e0:	e1c50513          	addi	a0,a0,-484 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc02046e4:	b25fb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02046e8 <do_yield>:
ffffffffc02046e8:	00015797          	auipc	a5,0x15
ffffffffc02046ec:	e107b783          	ld	a5,-496(a5) # ffffffffc02194f8 <current>
ffffffffc02046f0:	4705                	li	a4,1
ffffffffc02046f2:	ef98                	sd	a4,24(a5)
ffffffffc02046f4:	4501                	li	a0,0
ffffffffc02046f6:	8082                	ret

ffffffffc02046f8 <do_wait>:
ffffffffc02046f8:	1101                	addi	sp,sp,-32
ffffffffc02046fa:	e822                	sd	s0,16(sp)
ffffffffc02046fc:	e426                	sd	s1,8(sp)
ffffffffc02046fe:	ec06                	sd	ra,24(sp)
ffffffffc0204700:	842e                	mv	s0,a1
ffffffffc0204702:	84aa                	mv	s1,a0
ffffffffc0204704:	c999                	beqz	a1,ffffffffc020471a <do_wait+0x22>
ffffffffc0204706:	00015797          	auipc	a5,0x15
ffffffffc020470a:	df27b783          	ld	a5,-526(a5) # ffffffffc02194f8 <current>
ffffffffc020470e:	7788                	ld	a0,40(a5)
ffffffffc0204710:	4685                	li	a3,1
ffffffffc0204712:	4611                	li	a2,4
ffffffffc0204714:	c98fd0ef          	jal	ra,ffffffffc0201bac <user_mem_check>
ffffffffc0204718:	c909                	beqz	a0,ffffffffc020472a <do_wait+0x32>
ffffffffc020471a:	85a2                	mv	a1,s0
ffffffffc020471c:	6442                	ld	s0,16(sp)
ffffffffc020471e:	60e2                	ld	ra,24(sp)
ffffffffc0204720:	8526                	mv	a0,s1
ffffffffc0204722:	64a2                	ld	s1,8(sp)
ffffffffc0204724:	6105                	addi	sp,sp,32
ffffffffc0204726:	fa6ff06f          	j	ffffffffc0203ecc <do_wait.part.0>
ffffffffc020472a:	60e2                	ld	ra,24(sp)
ffffffffc020472c:	6442                	ld	s0,16(sp)
ffffffffc020472e:	64a2                	ld	s1,8(sp)
ffffffffc0204730:	5575                	li	a0,-3
ffffffffc0204732:	6105                	addi	sp,sp,32
ffffffffc0204734:	8082                	ret

ffffffffc0204736 <do_kill>:
ffffffffc0204736:	1141                	addi	sp,sp,-16
ffffffffc0204738:	e406                	sd	ra,8(sp)
ffffffffc020473a:	e022                	sd	s0,0(sp)
ffffffffc020473c:	960ff0ef          	jal	ra,ffffffffc020389c <find_proc>
ffffffffc0204740:	cd0d                	beqz	a0,ffffffffc020477a <do_kill+0x44>
ffffffffc0204742:	0b052703          	lw	a4,176(a0)
ffffffffc0204746:	00177693          	andi	a3,a4,1
ffffffffc020474a:	e695                	bnez	a3,ffffffffc0204776 <do_kill+0x40>
ffffffffc020474c:	0ec52683          	lw	a3,236(a0)
ffffffffc0204750:	00176713          	ori	a4,a4,1
ffffffffc0204754:	0ae52823          	sw	a4,176(a0)
ffffffffc0204758:	4401                	li	s0,0
ffffffffc020475a:	0006c763          	bltz	a3,ffffffffc0204768 <do_kill+0x32>
ffffffffc020475e:	60a2                	ld	ra,8(sp)
ffffffffc0204760:	8522                	mv	a0,s0
ffffffffc0204762:	6402                	ld	s0,0(sp)
ffffffffc0204764:	0141                	addi	sp,sp,16
ffffffffc0204766:	8082                	ret
ffffffffc0204768:	276000ef          	jal	ra,ffffffffc02049de <wakeup_proc>
ffffffffc020476c:	60a2                	ld	ra,8(sp)
ffffffffc020476e:	8522                	mv	a0,s0
ffffffffc0204770:	6402                	ld	s0,0(sp)
ffffffffc0204772:	0141                	addi	sp,sp,16
ffffffffc0204774:	8082                	ret
ffffffffc0204776:	545d                	li	s0,-9
ffffffffc0204778:	b7dd                	j	ffffffffc020475e <do_kill+0x28>
ffffffffc020477a:	5475                	li	s0,-3
ffffffffc020477c:	b7cd                	j	ffffffffc020475e <do_kill+0x28>

ffffffffc020477e <proc_init>:
ffffffffc020477e:	1101                	addi	sp,sp,-32
ffffffffc0204780:	00015797          	auipc	a5,0x15
ffffffffc0204784:	f7878793          	addi	a5,a5,-136 # ffffffffc02196f8 <proc_list>
ffffffffc0204788:	ec06                	sd	ra,24(sp)
ffffffffc020478a:	e822                	sd	s0,16(sp)
ffffffffc020478c:	e426                	sd	s1,8(sp)
ffffffffc020478e:	e04a                	sd	s2,0(sp)
ffffffffc0204790:	e79c                	sd	a5,8(a5)
ffffffffc0204792:	e39c                	sd	a5,0(a5)
ffffffffc0204794:	00015717          	auipc	a4,0x15
ffffffffc0204798:	cfc70713          	addi	a4,a4,-772 # ffffffffc0219490 <__rq>
ffffffffc020479c:	00011797          	auipc	a5,0x11
ffffffffc02047a0:	cf478793          	addi	a5,a5,-780 # ffffffffc0215490 <hash_list>
ffffffffc02047a4:	e79c                	sd	a5,8(a5)
ffffffffc02047a6:	e39c                	sd	a5,0(a5)
ffffffffc02047a8:	07c1                	addi	a5,a5,16
ffffffffc02047aa:	fef71de3          	bne	a4,a5,ffffffffc02047a4 <proc_init+0x26>
ffffffffc02047ae:	f57fe0ef          	jal	ra,ffffffffc0203704 <alloc_proc>
ffffffffc02047b2:	00015417          	auipc	s0,0x15
ffffffffc02047b6:	d4e40413          	addi	s0,s0,-690 # ffffffffc0219500 <idleproc>
ffffffffc02047ba:	e008                	sd	a0,0(s0)
ffffffffc02047bc:	c541                	beqz	a0,ffffffffc0204844 <proc_init+0xc6>
ffffffffc02047be:	4709                	li	a4,2
ffffffffc02047c0:	e118                	sd	a4,0(a0)
ffffffffc02047c2:	4485                	li	s1,1
ffffffffc02047c4:	00007717          	auipc	a4,0x7
ffffffffc02047c8:	83c70713          	addi	a4,a4,-1988 # ffffffffc020b000 <bootstack>
ffffffffc02047cc:	00005597          	auipc	a1,0x5
ffffffffc02047d0:	04c58593          	addi	a1,a1,76 # ffffffffc0209818 <default_pmm_manager+0x4e0>
ffffffffc02047d4:	e918                	sd	a4,16(a0)
ffffffffc02047d6:	ed04                	sd	s1,24(a0)
ffffffffc02047d8:	82eff0ef          	jal	ra,ffffffffc0203806 <set_proc_name>
ffffffffc02047dc:	00015717          	auipc	a4,0x15
ffffffffc02047e0:	d3470713          	addi	a4,a4,-716 # ffffffffc0219510 <nr_process>
ffffffffc02047e4:	431c                	lw	a5,0(a4)
ffffffffc02047e6:	6014                	ld	a3,0(s0)
ffffffffc02047e8:	4601                	li	a2,0
ffffffffc02047ea:	2785                	addiw	a5,a5,1
ffffffffc02047ec:	4581                	li	a1,0
ffffffffc02047ee:	00000517          	auipc	a0,0x0
ffffffffc02047f2:	87450513          	addi	a0,a0,-1932 # ffffffffc0204062 <init_main>
ffffffffc02047f6:	c31c                	sw	a5,0(a4)
ffffffffc02047f8:	00015797          	auipc	a5,0x15
ffffffffc02047fc:	d0d7b023          	sd	a3,-768(a5) # ffffffffc02194f8 <current>
ffffffffc0204800:	cc6ff0ef          	jal	ra,ffffffffc0203cc6 <kernel_thread>
ffffffffc0204804:	08a05c63          	blez	a0,ffffffffc020489c <proc_init+0x11e>
ffffffffc0204808:	894ff0ef          	jal	ra,ffffffffc020389c <find_proc>
ffffffffc020480c:	00015917          	auipc	s2,0x15
ffffffffc0204810:	cfc90913          	addi	s2,s2,-772 # ffffffffc0219508 <initproc>
ffffffffc0204814:	00005597          	auipc	a1,0x5
ffffffffc0204818:	02c58593          	addi	a1,a1,44 # ffffffffc0209840 <default_pmm_manager+0x508>
ffffffffc020481c:	00a93023          	sd	a0,0(s2)
ffffffffc0204820:	fe7fe0ef          	jal	ra,ffffffffc0203806 <set_proc_name>
ffffffffc0204824:	601c                	ld	a5,0(s0)
ffffffffc0204826:	cbb9                	beqz	a5,ffffffffc020487c <proc_init+0xfe>
ffffffffc0204828:	43dc                	lw	a5,4(a5)
ffffffffc020482a:	eba9                	bnez	a5,ffffffffc020487c <proc_init+0xfe>
ffffffffc020482c:	00093783          	ld	a5,0(s2)
ffffffffc0204830:	c795                	beqz	a5,ffffffffc020485c <proc_init+0xde>
ffffffffc0204832:	43dc                	lw	a5,4(a5)
ffffffffc0204834:	02979463          	bne	a5,s1,ffffffffc020485c <proc_init+0xde>
ffffffffc0204838:	60e2                	ld	ra,24(sp)
ffffffffc020483a:	6442                	ld	s0,16(sp)
ffffffffc020483c:	64a2                	ld	s1,8(sp)
ffffffffc020483e:	6902                	ld	s2,0(sp)
ffffffffc0204840:	6105                	addi	sp,sp,32
ffffffffc0204842:	8082                	ret
ffffffffc0204844:	00005617          	auipc	a2,0x5
ffffffffc0204848:	fbc60613          	addi	a2,a2,-68 # ffffffffc0209800 <default_pmm_manager+0x4c8>
ffffffffc020484c:	37700593          	li	a1,887
ffffffffc0204850:	00005517          	auipc	a0,0x5
ffffffffc0204854:	ca850513          	addi	a0,a0,-856 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc0204858:	9b1fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020485c:	00005697          	auipc	a3,0x5
ffffffffc0204860:	01468693          	addi	a3,a3,20 # ffffffffc0209870 <default_pmm_manager+0x538>
ffffffffc0204864:	00004617          	auipc	a2,0x4
ffffffffc0204868:	d9460613          	addi	a2,a2,-620 # ffffffffc02085f8 <commands+0x410>
ffffffffc020486c:	38c00593          	li	a1,908
ffffffffc0204870:	00005517          	auipc	a0,0x5
ffffffffc0204874:	c8850513          	addi	a0,a0,-888 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc0204878:	991fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020487c:	00005697          	auipc	a3,0x5
ffffffffc0204880:	fcc68693          	addi	a3,a3,-52 # ffffffffc0209848 <default_pmm_manager+0x510>
ffffffffc0204884:	00004617          	auipc	a2,0x4
ffffffffc0204888:	d7460613          	addi	a2,a2,-652 # ffffffffc02085f8 <commands+0x410>
ffffffffc020488c:	38b00593          	li	a1,907
ffffffffc0204890:	00005517          	auipc	a0,0x5
ffffffffc0204894:	c6850513          	addi	a0,a0,-920 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc0204898:	971fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020489c:	00005617          	auipc	a2,0x5
ffffffffc02048a0:	f8460613          	addi	a2,a2,-124 # ffffffffc0209820 <default_pmm_manager+0x4e8>
ffffffffc02048a4:	38500593          	li	a1,901
ffffffffc02048a8:	00005517          	auipc	a0,0x5
ffffffffc02048ac:	c5050513          	addi	a0,a0,-944 # ffffffffc02094f8 <default_pmm_manager+0x1c0>
ffffffffc02048b0:	959fb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02048b4 <cpu_idle>:
ffffffffc02048b4:	1141                	addi	sp,sp,-16
ffffffffc02048b6:	e022                	sd	s0,0(sp)
ffffffffc02048b8:	e406                	sd	ra,8(sp)
ffffffffc02048ba:	00015417          	auipc	s0,0x15
ffffffffc02048be:	c3e40413          	addi	s0,s0,-962 # ffffffffc02194f8 <current>
ffffffffc02048c2:	6018                	ld	a4,0(s0)
ffffffffc02048c4:	6f1c                	ld	a5,24(a4)
ffffffffc02048c6:	dffd                	beqz	a5,ffffffffc02048c4 <cpu_idle+0x10>
ffffffffc02048c8:	1c8000ef          	jal	ra,ffffffffc0204a90 <schedule>
ffffffffc02048cc:	bfdd                	j	ffffffffc02048c2 <cpu_idle+0xe>

ffffffffc02048ce <lab6_set_priority>:
ffffffffc02048ce:	1141                	addi	sp,sp,-16
ffffffffc02048d0:	e022                	sd	s0,0(sp)
ffffffffc02048d2:	85aa                	mv	a1,a0
ffffffffc02048d4:	842a                	mv	s0,a0
ffffffffc02048d6:	00005517          	auipc	a0,0x5
ffffffffc02048da:	fc250513          	addi	a0,a0,-62 # ffffffffc0209898 <default_pmm_manager+0x560>
ffffffffc02048de:	e406                	sd	ra,8(sp)
ffffffffc02048e0:	fecfb0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02048e4:	00015797          	auipc	a5,0x15
ffffffffc02048e8:	c147b783          	ld	a5,-1004(a5) # ffffffffc02194f8 <current>
ffffffffc02048ec:	e801                	bnez	s0,ffffffffc02048fc <lab6_set_priority+0x2e>
ffffffffc02048ee:	60a2                	ld	ra,8(sp)
ffffffffc02048f0:	6402                	ld	s0,0(sp)
ffffffffc02048f2:	4705                	li	a4,1
ffffffffc02048f4:	14e7a223          	sw	a4,324(a5)
ffffffffc02048f8:	0141                	addi	sp,sp,16
ffffffffc02048fa:	8082                	ret
ffffffffc02048fc:	60a2                	ld	ra,8(sp)
ffffffffc02048fe:	1487a223          	sw	s0,324(a5)
ffffffffc0204902:	6402                	ld	s0,0(sp)
ffffffffc0204904:	0141                	addi	sp,sp,16
ffffffffc0204906:	8082                	ret

ffffffffc0204908 <do_sleep>:
ffffffffc0204908:	c539                	beqz	a0,ffffffffc0204956 <do_sleep+0x4e>
ffffffffc020490a:	7179                	addi	sp,sp,-48
ffffffffc020490c:	f022                	sd	s0,32(sp)
ffffffffc020490e:	f406                	sd	ra,40(sp)
ffffffffc0204910:	842a                	mv	s0,a0
ffffffffc0204912:	100027f3          	csrr	a5,sstatus
ffffffffc0204916:	8b89                	andi	a5,a5,2
ffffffffc0204918:	e3a9                	bnez	a5,ffffffffc020495a <do_sleep+0x52>
ffffffffc020491a:	00015797          	auipc	a5,0x15
ffffffffc020491e:	bde7b783          	ld	a5,-1058(a5) # ffffffffc02194f8 <current>
ffffffffc0204922:	0818                	addi	a4,sp,16
ffffffffc0204924:	c02a                	sw	a0,0(sp)
ffffffffc0204926:	ec3a                	sd	a4,24(sp)
ffffffffc0204928:	e83a                	sd	a4,16(sp)
ffffffffc020492a:	e43e                	sd	a5,8(sp)
ffffffffc020492c:	4705                	li	a4,1
ffffffffc020492e:	c398                	sw	a4,0(a5)
ffffffffc0204930:	80000737          	lui	a4,0x80000
ffffffffc0204934:	840a                	mv	s0,sp
ffffffffc0204936:	2709                	addiw	a4,a4,2
ffffffffc0204938:	0ee7a623          	sw	a4,236(a5)
ffffffffc020493c:	8522                	mv	a0,s0
ffffffffc020493e:	218000ef          	jal	ra,ffffffffc0204b56 <add_timer>
ffffffffc0204942:	14e000ef          	jal	ra,ffffffffc0204a90 <schedule>
ffffffffc0204946:	8522                	mv	a0,s0
ffffffffc0204948:	2d6000ef          	jal	ra,ffffffffc0204c1e <del_timer>
ffffffffc020494c:	70a2                	ld	ra,40(sp)
ffffffffc020494e:	7402                	ld	s0,32(sp)
ffffffffc0204950:	4501                	li	a0,0
ffffffffc0204952:	6145                	addi	sp,sp,48
ffffffffc0204954:	8082                	ret
ffffffffc0204956:	4501                	li	a0,0
ffffffffc0204958:	8082                	ret
ffffffffc020495a:	cdffb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc020495e:	00015797          	auipc	a5,0x15
ffffffffc0204962:	b9a7b783          	ld	a5,-1126(a5) # ffffffffc02194f8 <current>
ffffffffc0204966:	0818                	addi	a4,sp,16
ffffffffc0204968:	c022                	sw	s0,0(sp)
ffffffffc020496a:	e43e                	sd	a5,8(sp)
ffffffffc020496c:	ec3a                	sd	a4,24(sp)
ffffffffc020496e:	e83a                	sd	a4,16(sp)
ffffffffc0204970:	4705                	li	a4,1
ffffffffc0204972:	c398                	sw	a4,0(a5)
ffffffffc0204974:	80000737          	lui	a4,0x80000
ffffffffc0204978:	2709                	addiw	a4,a4,2
ffffffffc020497a:	840a                	mv	s0,sp
ffffffffc020497c:	8522                	mv	a0,s0
ffffffffc020497e:	0ee7a623          	sw	a4,236(a5)
ffffffffc0204982:	1d4000ef          	jal	ra,ffffffffc0204b56 <add_timer>
ffffffffc0204986:	cadfb0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc020498a:	bf65                	j	ffffffffc0204942 <do_sleep+0x3a>

ffffffffc020498c <sched_init>:
ffffffffc020498c:	1141                	addi	sp,sp,-16
ffffffffc020498e:	00009717          	auipc	a4,0x9
ffffffffc0204992:	6c270713          	addi	a4,a4,1730 # ffffffffc020e050 <default_sched_class>
ffffffffc0204996:	e022                	sd	s0,0(sp)
ffffffffc0204998:	e406                	sd	ra,8(sp)
ffffffffc020499a:	00015797          	auipc	a5,0x15
ffffffffc020499e:	b1678793          	addi	a5,a5,-1258 # ffffffffc02194b0 <timer_list>
ffffffffc02049a2:	6714                	ld	a3,8(a4)
ffffffffc02049a4:	00015517          	auipc	a0,0x15
ffffffffc02049a8:	aec50513          	addi	a0,a0,-1300 # ffffffffc0219490 <__rq>
ffffffffc02049ac:	e79c                	sd	a5,8(a5)
ffffffffc02049ae:	e39c                	sd	a5,0(a5)
ffffffffc02049b0:	4795                	li	a5,5
ffffffffc02049b2:	c95c                	sw	a5,20(a0)
ffffffffc02049b4:	00015417          	auipc	s0,0x15
ffffffffc02049b8:	b6c40413          	addi	s0,s0,-1172 # ffffffffc0219520 <sched_class>
ffffffffc02049bc:	00015797          	auipc	a5,0x15
ffffffffc02049c0:	b4a7be23          	sd	a0,-1188(a5) # ffffffffc0219518 <rq>
ffffffffc02049c4:	e018                	sd	a4,0(s0)
ffffffffc02049c6:	9682                	jalr	a3
ffffffffc02049c8:	601c                	ld	a5,0(s0)
ffffffffc02049ca:	6402                	ld	s0,0(sp)
ffffffffc02049cc:	60a2                	ld	ra,8(sp)
ffffffffc02049ce:	638c                	ld	a1,0(a5)
ffffffffc02049d0:	00005517          	auipc	a0,0x5
ffffffffc02049d4:	ee050513          	addi	a0,a0,-288 # ffffffffc02098b0 <default_pmm_manager+0x578>
ffffffffc02049d8:	0141                	addi	sp,sp,16
ffffffffc02049da:	ef2fb06f          	j	ffffffffc02000cc <cprintf>

ffffffffc02049de <wakeup_proc>:
ffffffffc02049de:	4118                	lw	a4,0(a0)
ffffffffc02049e0:	1101                	addi	sp,sp,-32
ffffffffc02049e2:	ec06                	sd	ra,24(sp)
ffffffffc02049e4:	e822                	sd	s0,16(sp)
ffffffffc02049e6:	e426                	sd	s1,8(sp)
ffffffffc02049e8:	478d                	li	a5,3
ffffffffc02049ea:	08f70363          	beq	a4,a5,ffffffffc0204a70 <wakeup_proc+0x92>
ffffffffc02049ee:	842a                	mv	s0,a0
ffffffffc02049f0:	100027f3          	csrr	a5,sstatus
ffffffffc02049f4:	8b89                	andi	a5,a5,2
ffffffffc02049f6:	4481                	li	s1,0
ffffffffc02049f8:	e7bd                	bnez	a5,ffffffffc0204a66 <wakeup_proc+0x88>
ffffffffc02049fa:	4789                	li	a5,2
ffffffffc02049fc:	04f70863          	beq	a4,a5,ffffffffc0204a4c <wakeup_proc+0x6e>
ffffffffc0204a00:	c01c                	sw	a5,0(s0)
ffffffffc0204a02:	0e042623          	sw	zero,236(s0)
ffffffffc0204a06:	00015797          	auipc	a5,0x15
ffffffffc0204a0a:	af27b783          	ld	a5,-1294(a5) # ffffffffc02194f8 <current>
ffffffffc0204a0e:	02878363          	beq	a5,s0,ffffffffc0204a34 <wakeup_proc+0x56>
ffffffffc0204a12:	00015797          	auipc	a5,0x15
ffffffffc0204a16:	aee7b783          	ld	a5,-1298(a5) # ffffffffc0219500 <idleproc>
ffffffffc0204a1a:	00f40d63          	beq	s0,a5,ffffffffc0204a34 <wakeup_proc+0x56>
ffffffffc0204a1e:	00015797          	auipc	a5,0x15
ffffffffc0204a22:	b027b783          	ld	a5,-1278(a5) # ffffffffc0219520 <sched_class>
ffffffffc0204a26:	6b9c                	ld	a5,16(a5)
ffffffffc0204a28:	85a2                	mv	a1,s0
ffffffffc0204a2a:	00015517          	auipc	a0,0x15
ffffffffc0204a2e:	aee53503          	ld	a0,-1298(a0) # ffffffffc0219518 <rq>
ffffffffc0204a32:	9782                	jalr	a5
ffffffffc0204a34:	e491                	bnez	s1,ffffffffc0204a40 <wakeup_proc+0x62>
ffffffffc0204a36:	60e2                	ld	ra,24(sp)
ffffffffc0204a38:	6442                	ld	s0,16(sp)
ffffffffc0204a3a:	64a2                	ld	s1,8(sp)
ffffffffc0204a3c:	6105                	addi	sp,sp,32
ffffffffc0204a3e:	8082                	ret
ffffffffc0204a40:	6442                	ld	s0,16(sp)
ffffffffc0204a42:	60e2                	ld	ra,24(sp)
ffffffffc0204a44:	64a2                	ld	s1,8(sp)
ffffffffc0204a46:	6105                	addi	sp,sp,32
ffffffffc0204a48:	bebfb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204a4c:	00005617          	auipc	a2,0x5
ffffffffc0204a50:	eb460613          	addi	a2,a2,-332 # ffffffffc0209900 <default_pmm_manager+0x5c8>
ffffffffc0204a54:	04800593          	li	a1,72
ffffffffc0204a58:	00005517          	auipc	a0,0x5
ffffffffc0204a5c:	e9050513          	addi	a0,a0,-368 # ffffffffc02098e8 <default_pmm_manager+0x5b0>
ffffffffc0204a60:	811fb0ef          	jal	ra,ffffffffc0200270 <__warn>
ffffffffc0204a64:	bfc1                	j	ffffffffc0204a34 <wakeup_proc+0x56>
ffffffffc0204a66:	bd3fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204a6a:	4018                	lw	a4,0(s0)
ffffffffc0204a6c:	4485                	li	s1,1
ffffffffc0204a6e:	b771                	j	ffffffffc02049fa <wakeup_proc+0x1c>
ffffffffc0204a70:	00005697          	auipc	a3,0x5
ffffffffc0204a74:	e5868693          	addi	a3,a3,-424 # ffffffffc02098c8 <default_pmm_manager+0x590>
ffffffffc0204a78:	00004617          	auipc	a2,0x4
ffffffffc0204a7c:	b8060613          	addi	a2,a2,-1152 # ffffffffc02085f8 <commands+0x410>
ffffffffc0204a80:	03c00593          	li	a1,60
ffffffffc0204a84:	00005517          	auipc	a0,0x5
ffffffffc0204a88:	e6450513          	addi	a0,a0,-412 # ffffffffc02098e8 <default_pmm_manager+0x5b0>
ffffffffc0204a8c:	f7cfb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204a90 <schedule>:
ffffffffc0204a90:	7179                	addi	sp,sp,-48
ffffffffc0204a92:	f406                	sd	ra,40(sp)
ffffffffc0204a94:	f022                	sd	s0,32(sp)
ffffffffc0204a96:	ec26                	sd	s1,24(sp)
ffffffffc0204a98:	e84a                	sd	s2,16(sp)
ffffffffc0204a9a:	e44e                	sd	s3,8(sp)
ffffffffc0204a9c:	e052                	sd	s4,0(sp)
ffffffffc0204a9e:	100027f3          	csrr	a5,sstatus
ffffffffc0204aa2:	8b89                	andi	a5,a5,2
ffffffffc0204aa4:	4a01                	li	s4,0
ffffffffc0204aa6:	e7c5                	bnez	a5,ffffffffc0204b4e <schedule+0xbe>
ffffffffc0204aa8:	00015497          	auipc	s1,0x15
ffffffffc0204aac:	a5048493          	addi	s1,s1,-1456 # ffffffffc02194f8 <current>
ffffffffc0204ab0:	608c                	ld	a1,0(s1)
ffffffffc0204ab2:	00015997          	auipc	s3,0x15
ffffffffc0204ab6:	a6e98993          	addi	s3,s3,-1426 # ffffffffc0219520 <sched_class>
ffffffffc0204aba:	00015917          	auipc	s2,0x15
ffffffffc0204abe:	a5e90913          	addi	s2,s2,-1442 # ffffffffc0219518 <rq>
ffffffffc0204ac2:	4194                	lw	a3,0(a1)
ffffffffc0204ac4:	0005bc23          	sd	zero,24(a1)
ffffffffc0204ac8:	4709                	li	a4,2
ffffffffc0204aca:	0009b783          	ld	a5,0(s3)
ffffffffc0204ace:	00093503          	ld	a0,0(s2)
ffffffffc0204ad2:	04e68063          	beq	a3,a4,ffffffffc0204b12 <schedule+0x82>
ffffffffc0204ad6:	739c                	ld	a5,32(a5)
ffffffffc0204ad8:	9782                	jalr	a5
ffffffffc0204ada:	842a                	mv	s0,a0
ffffffffc0204adc:	c939                	beqz	a0,ffffffffc0204b32 <schedule+0xa2>
ffffffffc0204ade:	0009b783          	ld	a5,0(s3)
ffffffffc0204ae2:	00093503          	ld	a0,0(s2)
ffffffffc0204ae6:	85a2                	mv	a1,s0
ffffffffc0204ae8:	6f9c                	ld	a5,24(a5)
ffffffffc0204aea:	9782                	jalr	a5
ffffffffc0204aec:	441c                	lw	a5,8(s0)
ffffffffc0204aee:	6098                	ld	a4,0(s1)
ffffffffc0204af0:	2785                	addiw	a5,a5,1
ffffffffc0204af2:	c41c                	sw	a5,8(s0)
ffffffffc0204af4:	00870563          	beq	a4,s0,ffffffffc0204afe <schedule+0x6e>
ffffffffc0204af8:	8522                	mv	a0,s0
ffffffffc0204afa:	d37fe0ef          	jal	ra,ffffffffc0203830 <proc_run>
ffffffffc0204afe:	020a1f63          	bnez	s4,ffffffffc0204b3c <schedule+0xac>
ffffffffc0204b02:	70a2                	ld	ra,40(sp)
ffffffffc0204b04:	7402                	ld	s0,32(sp)
ffffffffc0204b06:	64e2                	ld	s1,24(sp)
ffffffffc0204b08:	6942                	ld	s2,16(sp)
ffffffffc0204b0a:	69a2                	ld	s3,8(sp)
ffffffffc0204b0c:	6a02                	ld	s4,0(sp)
ffffffffc0204b0e:	6145                	addi	sp,sp,48
ffffffffc0204b10:	8082                	ret
ffffffffc0204b12:	00015717          	auipc	a4,0x15
ffffffffc0204b16:	9ee73703          	ld	a4,-1554(a4) # ffffffffc0219500 <idleproc>
ffffffffc0204b1a:	fae58ee3          	beq	a1,a4,ffffffffc0204ad6 <schedule+0x46>
ffffffffc0204b1e:	6b9c                	ld	a5,16(a5)
ffffffffc0204b20:	9782                	jalr	a5
ffffffffc0204b22:	0009b783          	ld	a5,0(s3)
ffffffffc0204b26:	00093503          	ld	a0,0(s2)
ffffffffc0204b2a:	739c                	ld	a5,32(a5)
ffffffffc0204b2c:	9782                	jalr	a5
ffffffffc0204b2e:	842a                	mv	s0,a0
ffffffffc0204b30:	f55d                	bnez	a0,ffffffffc0204ade <schedule+0x4e>
ffffffffc0204b32:	00015417          	auipc	s0,0x15
ffffffffc0204b36:	9ce43403          	ld	s0,-1586(s0) # ffffffffc0219500 <idleproc>
ffffffffc0204b3a:	bf4d                	j	ffffffffc0204aec <schedule+0x5c>
ffffffffc0204b3c:	7402                	ld	s0,32(sp)
ffffffffc0204b3e:	70a2                	ld	ra,40(sp)
ffffffffc0204b40:	64e2                	ld	s1,24(sp)
ffffffffc0204b42:	6942                	ld	s2,16(sp)
ffffffffc0204b44:	69a2                	ld	s3,8(sp)
ffffffffc0204b46:	6a02                	ld	s4,0(sp)
ffffffffc0204b48:	6145                	addi	sp,sp,48
ffffffffc0204b4a:	ae9fb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204b4e:	aebfb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204b52:	4a05                	li	s4,1
ffffffffc0204b54:	bf91                	j	ffffffffc0204aa8 <schedule+0x18>

ffffffffc0204b56 <add_timer>:
ffffffffc0204b56:	1141                	addi	sp,sp,-16
ffffffffc0204b58:	e022                	sd	s0,0(sp)
ffffffffc0204b5a:	e406                	sd	ra,8(sp)
ffffffffc0204b5c:	842a                	mv	s0,a0
ffffffffc0204b5e:	100027f3          	csrr	a5,sstatus
ffffffffc0204b62:	8b89                	andi	a5,a5,2
ffffffffc0204b64:	4501                	li	a0,0
ffffffffc0204b66:	eba5                	bnez	a5,ffffffffc0204bd6 <add_timer+0x80>
ffffffffc0204b68:	401c                	lw	a5,0(s0)
ffffffffc0204b6a:	cbb5                	beqz	a5,ffffffffc0204bde <add_timer+0x88>
ffffffffc0204b6c:	6418                	ld	a4,8(s0)
ffffffffc0204b6e:	cb25                	beqz	a4,ffffffffc0204bde <add_timer+0x88>
ffffffffc0204b70:	6c18                	ld	a4,24(s0)
ffffffffc0204b72:	01040593          	addi	a1,s0,16
ffffffffc0204b76:	08e59463          	bne	a1,a4,ffffffffc0204bfe <add_timer+0xa8>
ffffffffc0204b7a:	00015617          	auipc	a2,0x15
ffffffffc0204b7e:	93660613          	addi	a2,a2,-1738 # ffffffffc02194b0 <timer_list>
ffffffffc0204b82:	6618                	ld	a4,8(a2)
ffffffffc0204b84:	00c71863          	bne	a4,a2,ffffffffc0204b94 <add_timer+0x3e>
ffffffffc0204b88:	a80d                	j	ffffffffc0204bba <add_timer+0x64>
ffffffffc0204b8a:	6718                	ld	a4,8(a4)
ffffffffc0204b8c:	9f95                	subw	a5,a5,a3
ffffffffc0204b8e:	c01c                	sw	a5,0(s0)
ffffffffc0204b90:	02c70563          	beq	a4,a2,ffffffffc0204bba <add_timer+0x64>
ffffffffc0204b94:	ff072683          	lw	a3,-16(a4)
ffffffffc0204b98:	fed7f9e3          	bgeu	a5,a3,ffffffffc0204b8a <add_timer+0x34>
ffffffffc0204b9c:	40f687bb          	subw	a5,a3,a5
ffffffffc0204ba0:	fef72823          	sw	a5,-16(a4)
ffffffffc0204ba4:	631c                	ld	a5,0(a4)
ffffffffc0204ba6:	e30c                	sd	a1,0(a4)
ffffffffc0204ba8:	e78c                	sd	a1,8(a5)
ffffffffc0204baa:	ec18                	sd	a4,24(s0)
ffffffffc0204bac:	e81c                	sd	a5,16(s0)
ffffffffc0204bae:	c105                	beqz	a0,ffffffffc0204bce <add_timer+0x78>
ffffffffc0204bb0:	6402                	ld	s0,0(sp)
ffffffffc0204bb2:	60a2                	ld	ra,8(sp)
ffffffffc0204bb4:	0141                	addi	sp,sp,16
ffffffffc0204bb6:	a7dfb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204bba:	00015717          	auipc	a4,0x15
ffffffffc0204bbe:	8f670713          	addi	a4,a4,-1802 # ffffffffc02194b0 <timer_list>
ffffffffc0204bc2:	631c                	ld	a5,0(a4)
ffffffffc0204bc4:	e30c                	sd	a1,0(a4)
ffffffffc0204bc6:	e78c                	sd	a1,8(a5)
ffffffffc0204bc8:	ec18                	sd	a4,24(s0)
ffffffffc0204bca:	e81c                	sd	a5,16(s0)
ffffffffc0204bcc:	f175                	bnez	a0,ffffffffc0204bb0 <add_timer+0x5a>
ffffffffc0204bce:	60a2                	ld	ra,8(sp)
ffffffffc0204bd0:	6402                	ld	s0,0(sp)
ffffffffc0204bd2:	0141                	addi	sp,sp,16
ffffffffc0204bd4:	8082                	ret
ffffffffc0204bd6:	a63fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204bda:	4505                	li	a0,1
ffffffffc0204bdc:	b771                	j	ffffffffc0204b68 <add_timer+0x12>
ffffffffc0204bde:	00005697          	auipc	a3,0x5
ffffffffc0204be2:	d4268693          	addi	a3,a3,-702 # ffffffffc0209920 <default_pmm_manager+0x5e8>
ffffffffc0204be6:	00004617          	auipc	a2,0x4
ffffffffc0204bea:	a1260613          	addi	a2,a2,-1518 # ffffffffc02085f8 <commands+0x410>
ffffffffc0204bee:	06c00593          	li	a1,108
ffffffffc0204bf2:	00005517          	auipc	a0,0x5
ffffffffc0204bf6:	cf650513          	addi	a0,a0,-778 # ffffffffc02098e8 <default_pmm_manager+0x5b0>
ffffffffc0204bfa:	e0efb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204bfe:	00005697          	auipc	a3,0x5
ffffffffc0204c02:	d5268693          	addi	a3,a3,-686 # ffffffffc0209950 <default_pmm_manager+0x618>
ffffffffc0204c06:	00004617          	auipc	a2,0x4
ffffffffc0204c0a:	9f260613          	addi	a2,a2,-1550 # ffffffffc02085f8 <commands+0x410>
ffffffffc0204c0e:	06d00593          	li	a1,109
ffffffffc0204c12:	00005517          	auipc	a0,0x5
ffffffffc0204c16:	cd650513          	addi	a0,a0,-810 # ffffffffc02098e8 <default_pmm_manager+0x5b0>
ffffffffc0204c1a:	deefb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204c1e <del_timer>:
ffffffffc0204c1e:	1101                	addi	sp,sp,-32
ffffffffc0204c20:	e822                	sd	s0,16(sp)
ffffffffc0204c22:	ec06                	sd	ra,24(sp)
ffffffffc0204c24:	e426                	sd	s1,8(sp)
ffffffffc0204c26:	842a                	mv	s0,a0
ffffffffc0204c28:	100027f3          	csrr	a5,sstatus
ffffffffc0204c2c:	8b89                	andi	a5,a5,2
ffffffffc0204c2e:	01050493          	addi	s1,a0,16
ffffffffc0204c32:	eb9d                	bnez	a5,ffffffffc0204c68 <del_timer+0x4a>
ffffffffc0204c34:	6d1c                	ld	a5,24(a0)
ffffffffc0204c36:	02978463          	beq	a5,s1,ffffffffc0204c5e <del_timer+0x40>
ffffffffc0204c3a:	4114                	lw	a3,0(a0)
ffffffffc0204c3c:	6918                	ld	a4,16(a0)
ffffffffc0204c3e:	ce81                	beqz	a3,ffffffffc0204c56 <del_timer+0x38>
ffffffffc0204c40:	00015617          	auipc	a2,0x15
ffffffffc0204c44:	87060613          	addi	a2,a2,-1936 # ffffffffc02194b0 <timer_list>
ffffffffc0204c48:	00c78763          	beq	a5,a2,ffffffffc0204c56 <del_timer+0x38>
ffffffffc0204c4c:	ff07a603          	lw	a2,-16(a5)
ffffffffc0204c50:	9eb1                	addw	a3,a3,a2
ffffffffc0204c52:	fed7a823          	sw	a3,-16(a5)
ffffffffc0204c56:	e71c                	sd	a5,8(a4)
ffffffffc0204c58:	e398                	sd	a4,0(a5)
ffffffffc0204c5a:	ec04                	sd	s1,24(s0)
ffffffffc0204c5c:	e804                	sd	s1,16(s0)
ffffffffc0204c5e:	60e2                	ld	ra,24(sp)
ffffffffc0204c60:	6442                	ld	s0,16(sp)
ffffffffc0204c62:	64a2                	ld	s1,8(sp)
ffffffffc0204c64:	6105                	addi	sp,sp,32
ffffffffc0204c66:	8082                	ret
ffffffffc0204c68:	9d1fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204c6c:	6c1c                	ld	a5,24(s0)
ffffffffc0204c6e:	02978463          	beq	a5,s1,ffffffffc0204c96 <del_timer+0x78>
ffffffffc0204c72:	4014                	lw	a3,0(s0)
ffffffffc0204c74:	6818                	ld	a4,16(s0)
ffffffffc0204c76:	ce81                	beqz	a3,ffffffffc0204c8e <del_timer+0x70>
ffffffffc0204c78:	00015617          	auipc	a2,0x15
ffffffffc0204c7c:	83860613          	addi	a2,a2,-1992 # ffffffffc02194b0 <timer_list>
ffffffffc0204c80:	00c78763          	beq	a5,a2,ffffffffc0204c8e <del_timer+0x70>
ffffffffc0204c84:	ff07a603          	lw	a2,-16(a5)
ffffffffc0204c88:	9eb1                	addw	a3,a3,a2
ffffffffc0204c8a:	fed7a823          	sw	a3,-16(a5)
ffffffffc0204c8e:	e71c                	sd	a5,8(a4)
ffffffffc0204c90:	e398                	sd	a4,0(a5)
ffffffffc0204c92:	ec04                	sd	s1,24(s0)
ffffffffc0204c94:	e804                	sd	s1,16(s0)
ffffffffc0204c96:	6442                	ld	s0,16(sp)
ffffffffc0204c98:	60e2                	ld	ra,24(sp)
ffffffffc0204c9a:	64a2                	ld	s1,8(sp)
ffffffffc0204c9c:	6105                	addi	sp,sp,32
ffffffffc0204c9e:	995fb06f          	j	ffffffffc0200632 <intr_enable>

ffffffffc0204ca2 <run_timer_list>:
ffffffffc0204ca2:	7139                	addi	sp,sp,-64
ffffffffc0204ca4:	fc06                	sd	ra,56(sp)
ffffffffc0204ca6:	f822                	sd	s0,48(sp)
ffffffffc0204ca8:	f426                	sd	s1,40(sp)
ffffffffc0204caa:	f04a                	sd	s2,32(sp)
ffffffffc0204cac:	ec4e                	sd	s3,24(sp)
ffffffffc0204cae:	e852                	sd	s4,16(sp)
ffffffffc0204cb0:	e456                	sd	s5,8(sp)
ffffffffc0204cb2:	e05a                	sd	s6,0(sp)
ffffffffc0204cb4:	100027f3          	csrr	a5,sstatus
ffffffffc0204cb8:	8b89                	andi	a5,a5,2
ffffffffc0204cba:	4b01                	li	s6,0
ffffffffc0204cbc:	eff9                	bnez	a5,ffffffffc0204d9a <run_timer_list+0xf8>
ffffffffc0204cbe:	00014997          	auipc	s3,0x14
ffffffffc0204cc2:	7f298993          	addi	s3,s3,2034 # ffffffffc02194b0 <timer_list>
ffffffffc0204cc6:	0089b403          	ld	s0,8(s3)
ffffffffc0204cca:	07340a63          	beq	s0,s3,ffffffffc0204d3e <run_timer_list+0x9c>
ffffffffc0204cce:	ff042783          	lw	a5,-16(s0)
ffffffffc0204cd2:	ff040913          	addi	s2,s0,-16
ffffffffc0204cd6:	0e078663          	beqz	a5,ffffffffc0204dc2 <run_timer_list+0x120>
ffffffffc0204cda:	fff7871b          	addiw	a4,a5,-1
ffffffffc0204cde:	fee42823          	sw	a4,-16(s0)
ffffffffc0204ce2:	ef31                	bnez	a4,ffffffffc0204d3e <run_timer_list+0x9c>
ffffffffc0204ce4:	00005a97          	auipc	s5,0x5
ffffffffc0204ce8:	cd4a8a93          	addi	s5,s5,-812 # ffffffffc02099b8 <default_pmm_manager+0x680>
ffffffffc0204cec:	00005a17          	auipc	s4,0x5
ffffffffc0204cf0:	bfca0a13          	addi	s4,s4,-1028 # ffffffffc02098e8 <default_pmm_manager+0x5b0>
ffffffffc0204cf4:	a005                	j	ffffffffc0204d14 <run_timer_list+0x72>
ffffffffc0204cf6:	0a07d663          	bgez	a5,ffffffffc0204da2 <run_timer_list+0x100>
ffffffffc0204cfa:	8526                	mv	a0,s1
ffffffffc0204cfc:	ce3ff0ef          	jal	ra,ffffffffc02049de <wakeup_proc>
ffffffffc0204d00:	854a                	mv	a0,s2
ffffffffc0204d02:	f1dff0ef          	jal	ra,ffffffffc0204c1e <del_timer>
ffffffffc0204d06:	03340c63          	beq	s0,s3,ffffffffc0204d3e <run_timer_list+0x9c>
ffffffffc0204d0a:	ff042783          	lw	a5,-16(s0)
ffffffffc0204d0e:	ff040913          	addi	s2,s0,-16
ffffffffc0204d12:	e795                	bnez	a5,ffffffffc0204d3e <run_timer_list+0x9c>
ffffffffc0204d14:	00893483          	ld	s1,8(s2)
ffffffffc0204d18:	6400                	ld	s0,8(s0)
ffffffffc0204d1a:	0ec4a783          	lw	a5,236(s1)
ffffffffc0204d1e:	ffe1                	bnez	a5,ffffffffc0204cf6 <run_timer_list+0x54>
ffffffffc0204d20:	40d4                	lw	a3,4(s1)
ffffffffc0204d22:	8656                	mv	a2,s5
ffffffffc0204d24:	0a300593          	li	a1,163
ffffffffc0204d28:	8552                	mv	a0,s4
ffffffffc0204d2a:	d46fb0ef          	jal	ra,ffffffffc0200270 <__warn>
ffffffffc0204d2e:	8526                	mv	a0,s1
ffffffffc0204d30:	cafff0ef          	jal	ra,ffffffffc02049de <wakeup_proc>
ffffffffc0204d34:	854a                	mv	a0,s2
ffffffffc0204d36:	ee9ff0ef          	jal	ra,ffffffffc0204c1e <del_timer>
ffffffffc0204d3a:	fd3418e3          	bne	s0,s3,ffffffffc0204d0a <run_timer_list+0x68>
ffffffffc0204d3e:	00014597          	auipc	a1,0x14
ffffffffc0204d42:	7ba5b583          	ld	a1,1978(a1) # ffffffffc02194f8 <current>
ffffffffc0204d46:	00014797          	auipc	a5,0x14
ffffffffc0204d4a:	7ba7b783          	ld	a5,1978(a5) # ffffffffc0219500 <idleproc>
ffffffffc0204d4e:	04f58363          	beq	a1,a5,ffffffffc0204d94 <run_timer_list+0xf2>
ffffffffc0204d52:	00014797          	auipc	a5,0x14
ffffffffc0204d56:	7ce7b783          	ld	a5,1998(a5) # ffffffffc0219520 <sched_class>
ffffffffc0204d5a:	779c                	ld	a5,40(a5)
ffffffffc0204d5c:	00014517          	auipc	a0,0x14
ffffffffc0204d60:	7bc53503          	ld	a0,1980(a0) # ffffffffc0219518 <rq>
ffffffffc0204d64:	9782                	jalr	a5
ffffffffc0204d66:	000b1c63          	bnez	s6,ffffffffc0204d7e <run_timer_list+0xdc>
ffffffffc0204d6a:	70e2                	ld	ra,56(sp)
ffffffffc0204d6c:	7442                	ld	s0,48(sp)
ffffffffc0204d6e:	74a2                	ld	s1,40(sp)
ffffffffc0204d70:	7902                	ld	s2,32(sp)
ffffffffc0204d72:	69e2                	ld	s3,24(sp)
ffffffffc0204d74:	6a42                	ld	s4,16(sp)
ffffffffc0204d76:	6aa2                	ld	s5,8(sp)
ffffffffc0204d78:	6b02                	ld	s6,0(sp)
ffffffffc0204d7a:	6121                	addi	sp,sp,64
ffffffffc0204d7c:	8082                	ret
ffffffffc0204d7e:	7442                	ld	s0,48(sp)
ffffffffc0204d80:	70e2                	ld	ra,56(sp)
ffffffffc0204d82:	74a2                	ld	s1,40(sp)
ffffffffc0204d84:	7902                	ld	s2,32(sp)
ffffffffc0204d86:	69e2                	ld	s3,24(sp)
ffffffffc0204d88:	6a42                	ld	s4,16(sp)
ffffffffc0204d8a:	6aa2                	ld	s5,8(sp)
ffffffffc0204d8c:	6b02                	ld	s6,0(sp)
ffffffffc0204d8e:	6121                	addi	sp,sp,64
ffffffffc0204d90:	8a3fb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204d94:	4785                	li	a5,1
ffffffffc0204d96:	ed9c                	sd	a5,24(a1)
ffffffffc0204d98:	b7f9                	j	ffffffffc0204d66 <run_timer_list+0xc4>
ffffffffc0204d9a:	89ffb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204d9e:	4b05                	li	s6,1
ffffffffc0204da0:	bf39                	j	ffffffffc0204cbe <run_timer_list+0x1c>
ffffffffc0204da2:	00005697          	auipc	a3,0x5
ffffffffc0204da6:	bee68693          	addi	a3,a3,-1042 # ffffffffc0209990 <default_pmm_manager+0x658>
ffffffffc0204daa:	00004617          	auipc	a2,0x4
ffffffffc0204dae:	84e60613          	addi	a2,a2,-1970 # ffffffffc02085f8 <commands+0x410>
ffffffffc0204db2:	0a000593          	li	a1,160
ffffffffc0204db6:	00005517          	auipc	a0,0x5
ffffffffc0204dba:	b3250513          	addi	a0,a0,-1230 # ffffffffc02098e8 <default_pmm_manager+0x5b0>
ffffffffc0204dbe:	c4afb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204dc2:	00005697          	auipc	a3,0x5
ffffffffc0204dc6:	bb668693          	addi	a3,a3,-1098 # ffffffffc0209978 <default_pmm_manager+0x640>
ffffffffc0204dca:	00004617          	auipc	a2,0x4
ffffffffc0204dce:	82e60613          	addi	a2,a2,-2002 # ffffffffc02085f8 <commands+0x410>
ffffffffc0204dd2:	09a00593          	li	a1,154
ffffffffc0204dd6:	00005517          	auipc	a0,0x5
ffffffffc0204dda:	b1250513          	addi	a0,a0,-1262 # ffffffffc02098e8 <default_pmm_manager+0x5b0>
ffffffffc0204dde:	c2afb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204de2 <proc_stride_comp_f>:
ffffffffc0204de2:	4d08                	lw	a0,24(a0)
ffffffffc0204de4:	4d9c                	lw	a5,24(a1)
ffffffffc0204de6:	9d1d                	subw	a0,a0,a5
ffffffffc0204de8:	00a04763          	bgtz	a0,ffffffffc0204df6 <proc_stride_comp_f+0x14>
ffffffffc0204dec:	00a03533          	snez	a0,a0
ffffffffc0204df0:	40a00533          	neg	a0,a0
ffffffffc0204df4:	8082                	ret
ffffffffc0204df6:	4505                	li	a0,1
ffffffffc0204df8:	8082                	ret

ffffffffc0204dfa <stride_init>:
ffffffffc0204dfa:	e508                	sd	a0,8(a0)
ffffffffc0204dfc:	e108                	sd	a0,0(a0)
ffffffffc0204dfe:	00053c23          	sd	zero,24(a0)
ffffffffc0204e02:	00052823          	sw	zero,16(a0)
ffffffffc0204e06:	8082                	ret

ffffffffc0204e08 <stride_pick_next>:
ffffffffc0204e08:	6d1c                	ld	a5,24(a0)
ffffffffc0204e0a:	cf89                	beqz	a5,ffffffffc0204e24 <stride_pick_next+0x1c>
ffffffffc0204e0c:	4fd0                	lw	a2,28(a5)
ffffffffc0204e0e:	4f98                	lw	a4,24(a5)
ffffffffc0204e10:	ed878513          	addi	a0,a5,-296
ffffffffc0204e14:	400006b7          	lui	a3,0x40000
ffffffffc0204e18:	c219                	beqz	a2,ffffffffc0204e1e <stride_pick_next+0x16>
ffffffffc0204e1a:	02c6d6bb          	divuw	a3,a3,a2
ffffffffc0204e1e:	9f35                	addw	a4,a4,a3
ffffffffc0204e20:	cf98                	sw	a4,24(a5)
ffffffffc0204e22:	8082                	ret
ffffffffc0204e24:	4501                	li	a0,0
ffffffffc0204e26:	8082                	ret

ffffffffc0204e28 <stride_proc_tick>:
ffffffffc0204e28:	1205a783          	lw	a5,288(a1)
ffffffffc0204e2c:	00f05563          	blez	a5,ffffffffc0204e36 <stride_proc_tick+0xe>
ffffffffc0204e30:	37fd                	addiw	a5,a5,-1
ffffffffc0204e32:	12f5a023          	sw	a5,288(a1)
ffffffffc0204e36:	e399                	bnez	a5,ffffffffc0204e3c <stride_proc_tick+0x14>
ffffffffc0204e38:	4785                	li	a5,1
ffffffffc0204e3a:	ed9c                	sd	a5,24(a1)
ffffffffc0204e3c:	8082                	ret

ffffffffc0204e3e <skew_heap_merge.constprop.0>:
ffffffffc0204e3e:	1101                	addi	sp,sp,-32
ffffffffc0204e40:	e822                	sd	s0,16(sp)
ffffffffc0204e42:	ec06                	sd	ra,24(sp)
ffffffffc0204e44:	e426                	sd	s1,8(sp)
ffffffffc0204e46:	e04a                	sd	s2,0(sp)
ffffffffc0204e48:	842e                	mv	s0,a1
ffffffffc0204e4a:	c11d                	beqz	a0,ffffffffc0204e70 <skew_heap_merge.constprop.0+0x32>
ffffffffc0204e4c:	84aa                	mv	s1,a0
ffffffffc0204e4e:	c1b9                	beqz	a1,ffffffffc0204e94 <skew_heap_merge.constprop.0+0x56>
ffffffffc0204e50:	f93ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0204e54:	57fd                	li	a5,-1
ffffffffc0204e56:	02f50463          	beq	a0,a5,ffffffffc0204e7e <skew_heap_merge.constprop.0+0x40>
ffffffffc0204e5a:	680c                	ld	a1,16(s0)
ffffffffc0204e5c:	00843903          	ld	s2,8(s0)
ffffffffc0204e60:	8526                	mv	a0,s1
ffffffffc0204e62:	fddff0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0204e66:	e408                	sd	a0,8(s0)
ffffffffc0204e68:	01243823          	sd	s2,16(s0)
ffffffffc0204e6c:	c111                	beqz	a0,ffffffffc0204e70 <skew_heap_merge.constprop.0+0x32>
ffffffffc0204e6e:	e100                	sd	s0,0(a0)
ffffffffc0204e70:	60e2                	ld	ra,24(sp)
ffffffffc0204e72:	8522                	mv	a0,s0
ffffffffc0204e74:	6442                	ld	s0,16(sp)
ffffffffc0204e76:	64a2                	ld	s1,8(sp)
ffffffffc0204e78:	6902                	ld	s2,0(sp)
ffffffffc0204e7a:	6105                	addi	sp,sp,32
ffffffffc0204e7c:	8082                	ret
ffffffffc0204e7e:	6888                	ld	a0,16(s1)
ffffffffc0204e80:	0084b903          	ld	s2,8(s1)
ffffffffc0204e84:	85a2                	mv	a1,s0
ffffffffc0204e86:	fb9ff0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0204e8a:	e488                	sd	a0,8(s1)
ffffffffc0204e8c:	0124b823          	sd	s2,16(s1)
ffffffffc0204e90:	c111                	beqz	a0,ffffffffc0204e94 <skew_heap_merge.constprop.0+0x56>
ffffffffc0204e92:	e104                	sd	s1,0(a0)
ffffffffc0204e94:	60e2                	ld	ra,24(sp)
ffffffffc0204e96:	6442                	ld	s0,16(sp)
ffffffffc0204e98:	6902                	ld	s2,0(sp)
ffffffffc0204e9a:	8526                	mv	a0,s1
ffffffffc0204e9c:	64a2                	ld	s1,8(sp)
ffffffffc0204e9e:	6105                	addi	sp,sp,32
ffffffffc0204ea0:	8082                	ret

ffffffffc0204ea2 <stride_enqueue>:
ffffffffc0204ea2:	7119                	addi	sp,sp,-128
ffffffffc0204ea4:	f4a6                	sd	s1,104(sp)
ffffffffc0204ea6:	6d04                	ld	s1,24(a0)
ffffffffc0204ea8:	f8a2                	sd	s0,112(sp)
ffffffffc0204eaa:	f0ca                	sd	s2,96(sp)
ffffffffc0204eac:	e8d2                	sd	s4,80(sp)
ffffffffc0204eae:	fc86                	sd	ra,120(sp)
ffffffffc0204eb0:	ecce                	sd	s3,88(sp)
ffffffffc0204eb2:	e4d6                	sd	s5,72(sp)
ffffffffc0204eb4:	e0da                	sd	s6,64(sp)
ffffffffc0204eb6:	fc5e                	sd	s7,56(sp)
ffffffffc0204eb8:	f862                	sd	s8,48(sp)
ffffffffc0204eba:	f466                	sd	s9,40(sp)
ffffffffc0204ebc:	f06a                	sd	s10,32(sp)
ffffffffc0204ebe:	ec6e                	sd	s11,24(sp)
ffffffffc0204ec0:	1205b423          	sd	zero,296(a1)
ffffffffc0204ec4:	1205bc23          	sd	zero,312(a1)
ffffffffc0204ec8:	1205b823          	sd	zero,304(a1)
ffffffffc0204ecc:	8a2a                	mv	s4,a0
ffffffffc0204ece:	842e                	mv	s0,a1
ffffffffc0204ed0:	12858913          	addi	s2,a1,296
ffffffffc0204ed4:	cc89                	beqz	s1,ffffffffc0204eee <stride_enqueue+0x4c>
ffffffffc0204ed6:	85ca                	mv	a1,s2
ffffffffc0204ed8:	8526                	mv	a0,s1
ffffffffc0204eda:	f09ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0204ede:	57fd                	li	a5,-1
ffffffffc0204ee0:	89aa                	mv	s3,a0
ffffffffc0204ee2:	04f50763          	beq	a0,a5,ffffffffc0204f30 <stride_enqueue+0x8e>
ffffffffc0204ee6:	12943823          	sd	s1,304(s0)
ffffffffc0204eea:	0124b023          	sd	s2,0(s1)
ffffffffc0204eee:	12042783          	lw	a5,288(s0)
ffffffffc0204ef2:	012a3c23          	sd	s2,24(s4)
ffffffffc0204ef6:	014a2703          	lw	a4,20(s4)
ffffffffc0204efa:	c399                	beqz	a5,ffffffffc0204f00 <stride_enqueue+0x5e>
ffffffffc0204efc:	00f75463          	bge	a4,a5,ffffffffc0204f04 <stride_enqueue+0x62>
ffffffffc0204f00:	12e42023          	sw	a4,288(s0)
ffffffffc0204f04:	010a2783          	lw	a5,16(s4)
ffffffffc0204f08:	70e6                	ld	ra,120(sp)
ffffffffc0204f0a:	11443423          	sd	s4,264(s0)
ffffffffc0204f0e:	7446                	ld	s0,112(sp)
ffffffffc0204f10:	2785                	addiw	a5,a5,1
ffffffffc0204f12:	00fa2823          	sw	a5,16(s4)
ffffffffc0204f16:	74a6                	ld	s1,104(sp)
ffffffffc0204f18:	7906                	ld	s2,96(sp)
ffffffffc0204f1a:	69e6                	ld	s3,88(sp)
ffffffffc0204f1c:	6a46                	ld	s4,80(sp)
ffffffffc0204f1e:	6aa6                	ld	s5,72(sp)
ffffffffc0204f20:	6b06                	ld	s6,64(sp)
ffffffffc0204f22:	7be2                	ld	s7,56(sp)
ffffffffc0204f24:	7c42                	ld	s8,48(sp)
ffffffffc0204f26:	7ca2                	ld	s9,40(sp)
ffffffffc0204f28:	7d02                	ld	s10,32(sp)
ffffffffc0204f2a:	6de2                	ld	s11,24(sp)
ffffffffc0204f2c:	6109                	addi	sp,sp,128
ffffffffc0204f2e:	8082                	ret
ffffffffc0204f30:	0104ba83          	ld	s5,16(s1)
ffffffffc0204f34:	0084bb83          	ld	s7,8(s1)
ffffffffc0204f38:	000a8d63          	beqz	s5,ffffffffc0204f52 <stride_enqueue+0xb0>
ffffffffc0204f3c:	85ca                	mv	a1,s2
ffffffffc0204f3e:	8556                	mv	a0,s5
ffffffffc0204f40:	ea3ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0204f44:	8b2a                	mv	s6,a0
ffffffffc0204f46:	01350e63          	beq	a0,s3,ffffffffc0204f62 <stride_enqueue+0xc0>
ffffffffc0204f4a:	13543823          	sd	s5,304(s0)
ffffffffc0204f4e:	012ab023          	sd	s2,0(s5)
ffffffffc0204f52:	0124b423          	sd	s2,8(s1)
ffffffffc0204f56:	0174b823          	sd	s7,16(s1)
ffffffffc0204f5a:	00993023          	sd	s1,0(s2)
ffffffffc0204f5e:	8926                	mv	s2,s1
ffffffffc0204f60:	b779                	j	ffffffffc0204eee <stride_enqueue+0x4c>
ffffffffc0204f62:	010ab983          	ld	s3,16(s5)
ffffffffc0204f66:	008abc83          	ld	s9,8(s5)
ffffffffc0204f6a:	00098d63          	beqz	s3,ffffffffc0204f84 <stride_enqueue+0xe2>
ffffffffc0204f6e:	85ca                	mv	a1,s2
ffffffffc0204f70:	854e                	mv	a0,s3
ffffffffc0204f72:	e71ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0204f76:	8c2a                	mv	s8,a0
ffffffffc0204f78:	01650e63          	beq	a0,s6,ffffffffc0204f94 <stride_enqueue+0xf2>
ffffffffc0204f7c:	13343823          	sd	s3,304(s0)
ffffffffc0204f80:	0129b023          	sd	s2,0(s3)
ffffffffc0204f84:	012ab423          	sd	s2,8(s5)
ffffffffc0204f88:	019ab823          	sd	s9,16(s5)
ffffffffc0204f8c:	01593023          	sd	s5,0(s2)
ffffffffc0204f90:	8956                	mv	s2,s5
ffffffffc0204f92:	b7c1                	j	ffffffffc0204f52 <stride_enqueue+0xb0>
ffffffffc0204f94:	0109bb03          	ld	s6,16(s3)
ffffffffc0204f98:	0089bd83          	ld	s11,8(s3)
ffffffffc0204f9c:	000b0d63          	beqz	s6,ffffffffc0204fb6 <stride_enqueue+0x114>
ffffffffc0204fa0:	85ca                	mv	a1,s2
ffffffffc0204fa2:	855a                	mv	a0,s6
ffffffffc0204fa4:	e3fff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0204fa8:	8d2a                	mv	s10,a0
ffffffffc0204faa:	01850e63          	beq	a0,s8,ffffffffc0204fc6 <stride_enqueue+0x124>
ffffffffc0204fae:	13643823          	sd	s6,304(s0)
ffffffffc0204fb2:	012b3023          	sd	s2,0(s6)
ffffffffc0204fb6:	0129b423          	sd	s2,8(s3)
ffffffffc0204fba:	01b9b823          	sd	s11,16(s3)
ffffffffc0204fbe:	01393023          	sd	s3,0(s2)
ffffffffc0204fc2:	894e                	mv	s2,s3
ffffffffc0204fc4:	b7c1                	j	ffffffffc0204f84 <stride_enqueue+0xe2>
ffffffffc0204fc6:	008b3783          	ld	a5,8(s6)
ffffffffc0204fca:	010b3c03          	ld	s8,16(s6)
ffffffffc0204fce:	e43e                	sd	a5,8(sp)
ffffffffc0204fd0:	000c0c63          	beqz	s8,ffffffffc0204fe8 <stride_enqueue+0x146>
ffffffffc0204fd4:	85ca                	mv	a1,s2
ffffffffc0204fd6:	8562                	mv	a0,s8
ffffffffc0204fd8:	e0bff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0204fdc:	01a50f63          	beq	a0,s10,ffffffffc0204ffa <stride_enqueue+0x158>
ffffffffc0204fe0:	13843823          	sd	s8,304(s0)
ffffffffc0204fe4:	012c3023          	sd	s2,0(s8)
ffffffffc0204fe8:	67a2                	ld	a5,8(sp)
ffffffffc0204fea:	012b3423          	sd	s2,8(s6)
ffffffffc0204fee:	00fb3823          	sd	a5,16(s6)
ffffffffc0204ff2:	01693023          	sd	s6,0(s2)
ffffffffc0204ff6:	895a                	mv	s2,s6
ffffffffc0204ff8:	bf7d                	j	ffffffffc0204fb6 <stride_enqueue+0x114>
ffffffffc0204ffa:	010c3503          	ld	a0,16(s8)
ffffffffc0204ffe:	008c3d03          	ld	s10,8(s8)
ffffffffc0205002:	85ca                	mv	a1,s2
ffffffffc0205004:	e3bff0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0205008:	00ac3423          	sd	a0,8(s8)
ffffffffc020500c:	01ac3823          	sd	s10,16(s8)
ffffffffc0205010:	c509                	beqz	a0,ffffffffc020501a <stride_enqueue+0x178>
ffffffffc0205012:	01853023          	sd	s8,0(a0)
ffffffffc0205016:	8962                	mv	s2,s8
ffffffffc0205018:	bfc1                	j	ffffffffc0204fe8 <stride_enqueue+0x146>
ffffffffc020501a:	8962                	mv	s2,s8
ffffffffc020501c:	b7f1                	j	ffffffffc0204fe8 <stride_enqueue+0x146>

ffffffffc020501e <stride_dequeue>:
ffffffffc020501e:	1085b783          	ld	a5,264(a1)
ffffffffc0205022:	7171                	addi	sp,sp,-176
ffffffffc0205024:	f506                	sd	ra,168(sp)
ffffffffc0205026:	f122                	sd	s0,160(sp)
ffffffffc0205028:	ed26                	sd	s1,152(sp)
ffffffffc020502a:	e94a                	sd	s2,144(sp)
ffffffffc020502c:	e54e                	sd	s3,136(sp)
ffffffffc020502e:	e152                	sd	s4,128(sp)
ffffffffc0205030:	fcd6                	sd	s5,120(sp)
ffffffffc0205032:	f8da                	sd	s6,112(sp)
ffffffffc0205034:	f4de                	sd	s7,104(sp)
ffffffffc0205036:	f0e2                	sd	s8,96(sp)
ffffffffc0205038:	ece6                	sd	s9,88(sp)
ffffffffc020503a:	e8ea                	sd	s10,80(sp)
ffffffffc020503c:	e4ee                	sd	s11,72(sp)
ffffffffc020503e:	00a78463          	beq	a5,a0,ffffffffc0205046 <stride_dequeue+0x28>
ffffffffc0205042:	7870106f          	j	ffffffffc0206fc8 <stride_dequeue+0x1faa>
ffffffffc0205046:	01052983          	lw	s3,16(a0)
ffffffffc020504a:	8c2a                	mv	s8,a0
ffffffffc020504c:	8b4e                	mv	s6,s3
ffffffffc020504e:	00099463          	bnez	s3,ffffffffc0205056 <stride_dequeue+0x38>
ffffffffc0205052:	7770106f          	j	ffffffffc0206fc8 <stride_dequeue+0x1faa>
ffffffffc0205056:	1305b903          	ld	s2,304(a1)
ffffffffc020505a:	01853a83          	ld	s5,24(a0)
ffffffffc020505e:	1285bd03          	ld	s10,296(a1)
ffffffffc0205062:	1385b483          	ld	s1,312(a1)
ffffffffc0205066:	842e                	mv	s0,a1
ffffffffc0205068:	2e090263          	beqz	s2,ffffffffc020534c <stride_dequeue+0x32e>
ffffffffc020506c:	42048263          	beqz	s1,ffffffffc0205490 <stride_dequeue+0x472>
ffffffffc0205070:	85a6                	mv	a1,s1
ffffffffc0205072:	854a                	mv	a0,s2
ffffffffc0205074:	d6fff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205078:	5cfd                	li	s9,-1
ffffffffc020507a:	8a2a                	mv	s4,a0
ffffffffc020507c:	19950163          	beq	a0,s9,ffffffffc02051fe <stride_dequeue+0x1e0>
ffffffffc0205080:	0104ba03          	ld	s4,16(s1)
ffffffffc0205084:	0084bb83          	ld	s7,8(s1)
ffffffffc0205088:	120a0563          	beqz	s4,ffffffffc02051b2 <stride_dequeue+0x194>
ffffffffc020508c:	85d2                	mv	a1,s4
ffffffffc020508e:	854a                	mv	a0,s2
ffffffffc0205090:	d53ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205094:	2d950563          	beq	a0,s9,ffffffffc020535e <stride_dequeue+0x340>
ffffffffc0205098:	008a3783          	ld	a5,8(s4)
ffffffffc020509c:	010a3d83          	ld	s11,16(s4)
ffffffffc02050a0:	e03e                	sd	a5,0(sp)
ffffffffc02050a2:	100d8063          	beqz	s11,ffffffffc02051a2 <stride_dequeue+0x184>
ffffffffc02050a6:	85ee                	mv	a1,s11
ffffffffc02050a8:	854a                	mv	a0,s2
ffffffffc02050aa:	d39ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02050ae:	7f950563          	beq	a0,s9,ffffffffc0205898 <stride_dequeue+0x87a>
ffffffffc02050b2:	008db783          	ld	a5,8(s11)
ffffffffc02050b6:	010dbc83          	ld	s9,16(s11)
ffffffffc02050ba:	e43e                	sd	a5,8(sp)
ffffffffc02050bc:	0c0c8b63          	beqz	s9,ffffffffc0205192 <stride_dequeue+0x174>
ffffffffc02050c0:	85e6                	mv	a1,s9
ffffffffc02050c2:	854a                	mv	a0,s2
ffffffffc02050c4:	d1fff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02050c8:	58fd                	li	a7,-1
ffffffffc02050ca:	71150063          	beq	a0,a7,ffffffffc02057ca <stride_dequeue+0x7ac>
ffffffffc02050ce:	008cb783          	ld	a5,8(s9)
ffffffffc02050d2:	010cb803          	ld	a6,16(s9)
ffffffffc02050d6:	e83e                	sd	a5,16(sp)
ffffffffc02050d8:	0a080563          	beqz	a6,ffffffffc0205182 <stride_dequeue+0x164>
ffffffffc02050dc:	85c2                	mv	a1,a6
ffffffffc02050de:	854a                	mv	a0,s2
ffffffffc02050e0:	ec42                	sd	a6,24(sp)
ffffffffc02050e2:	d01ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02050e6:	58fd                	li	a7,-1
ffffffffc02050e8:	6862                	ld	a6,24(sp)
ffffffffc02050ea:	41150be3          	beq	a0,a7,ffffffffc0205d00 <stride_dequeue+0xce2>
ffffffffc02050ee:	00883703          	ld	a4,8(a6) # fffffffffff80008 <end+0x3fd66900>
ffffffffc02050f2:	01083783          	ld	a5,16(a6)
ffffffffc02050f6:	ec3a                	sd	a4,24(sp)
ffffffffc02050f8:	cfad                	beqz	a5,ffffffffc0205172 <stride_dequeue+0x154>
ffffffffc02050fa:	85be                	mv	a1,a5
ffffffffc02050fc:	854a                	mv	a0,s2
ffffffffc02050fe:	f442                	sd	a6,40(sp)
ffffffffc0205100:	f03e                	sd	a5,32(sp)
ffffffffc0205102:	ce1ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205106:	58fd                	li	a7,-1
ffffffffc0205108:	7782                	ld	a5,32(sp)
ffffffffc020510a:	7822                	ld	a6,40(sp)
ffffffffc020510c:	01151463          	bne	a0,a7,ffffffffc0205114 <stride_dequeue+0xf6>
ffffffffc0205110:	17a0106f          	j	ffffffffc020628a <stride_dequeue+0x126c>
ffffffffc0205114:	6798                	ld	a4,8(a5)
ffffffffc0205116:	0107bb03          	ld	s6,16(a5)
ffffffffc020511a:	f03a                	sd	a4,32(sp)
ffffffffc020511c:	040b0463          	beqz	s6,ffffffffc0205164 <stride_dequeue+0x146>
ffffffffc0205120:	85da                	mv	a1,s6
ffffffffc0205122:	854a                	mv	a0,s2
ffffffffc0205124:	f83e                	sd	a5,48(sp)
ffffffffc0205126:	f442                	sd	a6,40(sp)
ffffffffc0205128:	cbbff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc020512c:	58fd                	li	a7,-1
ffffffffc020512e:	7822                	ld	a6,40(sp)
ffffffffc0205130:	77c2                	ld	a5,48(sp)
ffffffffc0205132:	01151463          	bne	a0,a7,ffffffffc020513a <stride_dequeue+0x11c>
ffffffffc0205136:	00d0106f          	j	ffffffffc0206942 <stride_dequeue+0x1924>
ffffffffc020513a:	010b3583          	ld	a1,16(s6)
ffffffffc020513e:	008b3983          	ld	s3,8(s6)
ffffffffc0205142:	854a                	mv	a0,s2
ffffffffc0205144:	f83e                	sd	a5,48(sp)
ffffffffc0205146:	f442                	sd	a6,40(sp)
ffffffffc0205148:	cf7ff0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc020514c:	00ab3423          	sd	a0,8(s6)
ffffffffc0205150:	013b3823          	sd	s3,16(s6)
ffffffffc0205154:	7822                	ld	a6,40(sp)
ffffffffc0205156:	77c2                	ld	a5,48(sp)
ffffffffc0205158:	010c2983          	lw	s3,16(s8)
ffffffffc020515c:	c119                	beqz	a0,ffffffffc0205162 <stride_dequeue+0x144>
ffffffffc020515e:	01653023          	sd	s6,0(a0)
ffffffffc0205162:	895a                	mv	s2,s6
ffffffffc0205164:	7702                	ld	a4,32(sp)
ffffffffc0205166:	0127b423          	sd	s2,8(a5)
ffffffffc020516a:	eb98                	sd	a4,16(a5)
ffffffffc020516c:	00f93023          	sd	a5,0(s2)
ffffffffc0205170:	893e                	mv	s2,a5
ffffffffc0205172:	67e2                	ld	a5,24(sp)
ffffffffc0205174:	01283423          	sd	s2,8(a6)
ffffffffc0205178:	00f83823          	sd	a5,16(a6)
ffffffffc020517c:	01093023          	sd	a6,0(s2)
ffffffffc0205180:	8942                	mv	s2,a6
ffffffffc0205182:	67c2                	ld	a5,16(sp)
ffffffffc0205184:	012cb423          	sd	s2,8(s9)
ffffffffc0205188:	00fcb823          	sd	a5,16(s9)
ffffffffc020518c:	01993023          	sd	s9,0(s2)
ffffffffc0205190:	8966                	mv	s2,s9
ffffffffc0205192:	67a2                	ld	a5,8(sp)
ffffffffc0205194:	012db423          	sd	s2,8(s11)
ffffffffc0205198:	00fdb823          	sd	a5,16(s11)
ffffffffc020519c:	01b93023          	sd	s11,0(s2)
ffffffffc02051a0:	896e                	mv	s2,s11
ffffffffc02051a2:	6782                	ld	a5,0(sp)
ffffffffc02051a4:	012a3423          	sd	s2,8(s4)
ffffffffc02051a8:	00fa3823          	sd	a5,16(s4)
ffffffffc02051ac:	01493023          	sd	s4,0(s2)
ffffffffc02051b0:	8952                	mv	s2,s4
ffffffffc02051b2:	0124b423          	sd	s2,8(s1)
ffffffffc02051b6:	0174b823          	sd	s7,16(s1)
ffffffffc02051ba:	00993023          	sd	s1,0(s2)
ffffffffc02051be:	01a4b023          	sd	s10,0(s1)
ffffffffc02051c2:	180d0963          	beqz	s10,ffffffffc0205354 <stride_dequeue+0x336>
ffffffffc02051c6:	008d3683          	ld	a3,8(s10)
ffffffffc02051ca:	12840413          	addi	s0,s0,296
ffffffffc02051ce:	18868563          	beq	a3,s0,ffffffffc0205358 <stride_dequeue+0x33a>
ffffffffc02051d2:	009d3823          	sd	s1,16(s10)
ffffffffc02051d6:	70aa                	ld	ra,168(sp)
ffffffffc02051d8:	740a                	ld	s0,160(sp)
ffffffffc02051da:	39fd                	addiw	s3,s3,-1
ffffffffc02051dc:	015c3c23          	sd	s5,24(s8)
ffffffffc02051e0:	013c2823          	sw	s3,16(s8)
ffffffffc02051e4:	64ea                	ld	s1,152(sp)
ffffffffc02051e6:	694a                	ld	s2,144(sp)
ffffffffc02051e8:	69aa                	ld	s3,136(sp)
ffffffffc02051ea:	6a0a                	ld	s4,128(sp)
ffffffffc02051ec:	7ae6                	ld	s5,120(sp)
ffffffffc02051ee:	7b46                	ld	s6,112(sp)
ffffffffc02051f0:	7ba6                	ld	s7,104(sp)
ffffffffc02051f2:	7c06                	ld	s8,96(sp)
ffffffffc02051f4:	6ce6                	ld	s9,88(sp)
ffffffffc02051f6:	6d46                	ld	s10,80(sp)
ffffffffc02051f8:	6da6                	ld	s11,72(sp)
ffffffffc02051fa:	614d                	addi	sp,sp,176
ffffffffc02051fc:	8082                	ret
ffffffffc02051fe:	01093d83          	ld	s11,16(s2)
ffffffffc0205202:	00893b83          	ld	s7,8(s2)
ffffffffc0205206:	120d8963          	beqz	s11,ffffffffc0205338 <stride_dequeue+0x31a>
ffffffffc020520a:	85a6                	mv	a1,s1
ffffffffc020520c:	856e                	mv	a0,s11
ffffffffc020520e:	bd5ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205212:	29450363          	beq	a0,s4,ffffffffc0205498 <stride_dequeue+0x47a>
ffffffffc0205216:	649c                	ld	a5,8(s1)
ffffffffc0205218:	0104bc83          	ld	s9,16(s1)
ffffffffc020521c:	e03e                	sd	a5,0(sp)
ffffffffc020521e:	100c8763          	beqz	s9,ffffffffc020532c <stride_dequeue+0x30e>
ffffffffc0205222:	85e6                	mv	a1,s9
ffffffffc0205224:	856e                	mv	a0,s11
ffffffffc0205226:	bbdff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc020522a:	4b450263          	beq	a0,s4,ffffffffc02056ce <stride_dequeue+0x6b0>
ffffffffc020522e:	008cb783          	ld	a5,8(s9)
ffffffffc0205232:	010cba03          	ld	s4,16(s9)
ffffffffc0205236:	e43e                	sd	a5,8(sp)
ffffffffc0205238:	0e0a0263          	beqz	s4,ffffffffc020531c <stride_dequeue+0x2fe>
ffffffffc020523c:	85d2                	mv	a1,s4
ffffffffc020523e:	856e                	mv	a0,s11
ffffffffc0205240:	ba3ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205244:	58fd                	li	a7,-1
ffffffffc0205246:	03150fe3          	beq	a0,a7,ffffffffc0205a84 <stride_dequeue+0xa66>
ffffffffc020524a:	008a3783          	ld	a5,8(s4)
ffffffffc020524e:	010a3803          	ld	a6,16(s4)
ffffffffc0205252:	e83e                	sd	a5,16(sp)
ffffffffc0205254:	0a080c63          	beqz	a6,ffffffffc020530c <stride_dequeue+0x2ee>
ffffffffc0205258:	85c2                	mv	a1,a6
ffffffffc020525a:	856e                	mv	a0,s11
ffffffffc020525c:	ec42                	sd	a6,24(sp)
ffffffffc020525e:	b85ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205262:	58fd                	li	a7,-1
ffffffffc0205264:	6862                	ld	a6,24(sp)
ffffffffc0205266:	01151463          	bne	a0,a7,ffffffffc020526e <stride_dequeue+0x250>
ffffffffc020526a:	6e10006f          	j	ffffffffc020614a <stride_dequeue+0x112c>
ffffffffc020526e:	00883783          	ld	a5,8(a6)
ffffffffc0205272:	01083303          	ld	t1,16(a6)
ffffffffc0205276:	ec3e                	sd	a5,24(sp)
ffffffffc0205278:	08030263          	beqz	t1,ffffffffc02052fc <stride_dequeue+0x2de>
ffffffffc020527c:	859a                	mv	a1,t1
ffffffffc020527e:	856e                	mv	a0,s11
ffffffffc0205280:	f442                	sd	a6,40(sp)
ffffffffc0205282:	f01a                	sd	t1,32(sp)
ffffffffc0205284:	b5fff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205288:	58fd                	li	a7,-1
ffffffffc020528a:	7302                	ld	t1,32(sp)
ffffffffc020528c:	7822                	ld	a6,40(sp)
ffffffffc020528e:	01151463          	bne	a0,a7,ffffffffc0205296 <stride_dequeue+0x278>
ffffffffc0205292:	5ee0106f          	j	ffffffffc0206880 <stride_dequeue+0x1862>
ffffffffc0205296:	00833783          	ld	a5,8(t1)
ffffffffc020529a:	01033983          	ld	s3,16(t1)
ffffffffc020529e:	f03e                	sd	a5,32(sp)
ffffffffc02052a0:	00099463          	bnez	s3,ffffffffc02052a8 <stride_dequeue+0x28a>
ffffffffc02052a4:	26f0106f          	j	ffffffffc0206d12 <stride_dequeue+0x1cf4>
ffffffffc02052a8:	85ce                	mv	a1,s3
ffffffffc02052aa:	856e                	mv	a0,s11
ffffffffc02052ac:	f842                	sd	a6,48(sp)
ffffffffc02052ae:	f41a                	sd	t1,40(sp)
ffffffffc02052b0:	b33ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02052b4:	58fd                	li	a7,-1
ffffffffc02052b6:	7322                	ld	t1,40(sp)
ffffffffc02052b8:	7842                	ld	a6,48(sp)
ffffffffc02052ba:	01151463          	bne	a0,a7,ffffffffc02052c2 <stride_dequeue+0x2a4>
ffffffffc02052be:	4d30106f          	j	ffffffffc0206f90 <stride_dequeue+0x1f72>
ffffffffc02052c2:	0109b583          	ld	a1,16(s3)
ffffffffc02052c6:	0089bb03          	ld	s6,8(s3)
ffffffffc02052ca:	856e                	mv	a0,s11
ffffffffc02052cc:	f842                	sd	a6,48(sp)
ffffffffc02052ce:	f41a                	sd	t1,40(sp)
ffffffffc02052d0:	b6fff0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02052d4:	00a9b423          	sd	a0,8(s3)
ffffffffc02052d8:	0169b823          	sd	s6,16(s3)
ffffffffc02052dc:	7322                	ld	t1,40(sp)
ffffffffc02052de:	7842                	ld	a6,48(sp)
ffffffffc02052e0:	010c2b03          	lw	s6,16(s8)
ffffffffc02052e4:	c119                	beqz	a0,ffffffffc02052ea <stride_dequeue+0x2cc>
ffffffffc02052e6:	01353023          	sd	s3,0(a0)
ffffffffc02052ea:	7782                	ld	a5,32(sp)
ffffffffc02052ec:	01333423          	sd	s3,8(t1)
ffffffffc02052f0:	8d9a                	mv	s11,t1
ffffffffc02052f2:	00f33823          	sd	a5,16(t1)
ffffffffc02052f6:	0069b023          	sd	t1,0(s3)
ffffffffc02052fa:	89da                	mv	s3,s6
ffffffffc02052fc:	67e2                	ld	a5,24(sp)
ffffffffc02052fe:	01b83423          	sd	s11,8(a6)
ffffffffc0205302:	00f83823          	sd	a5,16(a6)
ffffffffc0205306:	010db023          	sd	a6,0(s11)
ffffffffc020530a:	8dc2                	mv	s11,a6
ffffffffc020530c:	67c2                	ld	a5,16(sp)
ffffffffc020530e:	01ba3423          	sd	s11,8(s4)
ffffffffc0205312:	00fa3823          	sd	a5,16(s4)
ffffffffc0205316:	014db023          	sd	s4,0(s11)
ffffffffc020531a:	8dd2                	mv	s11,s4
ffffffffc020531c:	67a2                	ld	a5,8(sp)
ffffffffc020531e:	01bcb423          	sd	s11,8(s9)
ffffffffc0205322:	00fcb823          	sd	a5,16(s9)
ffffffffc0205326:	019db023          	sd	s9,0(s11)
ffffffffc020532a:	8de6                	mv	s11,s9
ffffffffc020532c:	6782                	ld	a5,0(sp)
ffffffffc020532e:	01b4b423          	sd	s11,8(s1)
ffffffffc0205332:	e89c                	sd	a5,16(s1)
ffffffffc0205334:	009db023          	sd	s1,0(s11)
ffffffffc0205338:	00993423          	sd	s1,8(s2)
ffffffffc020533c:	01793823          	sd	s7,16(s2)
ffffffffc0205340:	0124b023          	sd	s2,0(s1)
ffffffffc0205344:	84ca                	mv	s1,s2
ffffffffc0205346:	01a4b023          	sd	s10,0(s1)
ffffffffc020534a:	bda5                	j	ffffffffc02051c2 <stride_dequeue+0x1a4>
ffffffffc020534c:	e60499e3          	bnez	s1,ffffffffc02051be <stride_dequeue+0x1a0>
ffffffffc0205350:	e60d1be3          	bnez	s10,ffffffffc02051c6 <stride_dequeue+0x1a8>
ffffffffc0205354:	8aa6                	mv	s5,s1
ffffffffc0205356:	b541                	j	ffffffffc02051d6 <stride_dequeue+0x1b8>
ffffffffc0205358:	009d3423          	sd	s1,8(s10)
ffffffffc020535c:	bdad                	j	ffffffffc02051d6 <stride_dequeue+0x1b8>
ffffffffc020535e:	01093d83          	ld	s11,16(s2)
ffffffffc0205362:	e02a                	sd	a0,0(sp)
ffffffffc0205364:	00893c83          	ld	s9,8(s2)
ffffffffc0205368:	100d8d63          	beqz	s11,ffffffffc0205482 <stride_dequeue+0x464>
ffffffffc020536c:	85d2                	mv	a1,s4
ffffffffc020536e:	856e                	mv	a0,s11
ffffffffc0205370:	a73ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205374:	6782                	ld	a5,0(sp)
ffffffffc0205376:	24f50563          	beq	a0,a5,ffffffffc02055c0 <stride_dequeue+0x5a2>
ffffffffc020537a:	008a3783          	ld	a5,8(s4)
ffffffffc020537e:	010a3603          	ld	a2,16(s4)
ffffffffc0205382:	e03e                	sd	a5,0(sp)
ffffffffc0205384:	0e060863          	beqz	a2,ffffffffc0205474 <stride_dequeue+0x456>
ffffffffc0205388:	85b2                	mv	a1,a2
ffffffffc020538a:	856e                	mv	a0,s11
ffffffffc020538c:	e432                	sd	a2,8(sp)
ffffffffc020538e:	a55ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205392:	58fd                	li	a7,-1
ffffffffc0205394:	6622                	ld	a2,8(sp)
ffffffffc0205396:	7b150f63          	beq	a0,a7,ffffffffc0205b54 <stride_dequeue+0xb36>
ffffffffc020539a:	661c                	ld	a5,8(a2)
ffffffffc020539c:	01063803          	ld	a6,16(a2)
ffffffffc02053a0:	e43e                	sd	a5,8(sp)
ffffffffc02053a2:	0c080263          	beqz	a6,ffffffffc0205466 <stride_dequeue+0x448>
ffffffffc02053a6:	85c2                	mv	a1,a6
ffffffffc02053a8:	856e                	mv	a0,s11
ffffffffc02053aa:	ec32                	sd	a2,24(sp)
ffffffffc02053ac:	e842                	sd	a6,16(sp)
ffffffffc02053ae:	a35ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02053b2:	58fd                	li	a7,-1
ffffffffc02053b4:	6842                	ld	a6,16(sp)
ffffffffc02053b6:	6662                	ld	a2,24(sp)
ffffffffc02053b8:	631507e3          	beq	a0,a7,ffffffffc02061e6 <stride_dequeue+0x11c8>
ffffffffc02053bc:	00883783          	ld	a5,8(a6)
ffffffffc02053c0:	01083303          	ld	t1,16(a6)
ffffffffc02053c4:	e83e                	sd	a5,16(sp)
ffffffffc02053c6:	08030863          	beqz	t1,ffffffffc0205456 <stride_dequeue+0x438>
ffffffffc02053ca:	859a                	mv	a1,t1
ffffffffc02053cc:	856e                	mv	a0,s11
ffffffffc02053ce:	f442                	sd	a6,40(sp)
ffffffffc02053d0:	f032                	sd	a2,32(sp)
ffffffffc02053d2:	ec1a                	sd	t1,24(sp)
ffffffffc02053d4:	a0fff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02053d8:	58fd                	li	a7,-1
ffffffffc02053da:	6362                	ld	t1,24(sp)
ffffffffc02053dc:	7602                	ld	a2,32(sp)
ffffffffc02053de:	7822                	ld	a6,40(sp)
ffffffffc02053e0:	01151463          	bne	a0,a7,ffffffffc02053e8 <stride_dequeue+0x3ca>
ffffffffc02053e4:	3d00106f          	j	ffffffffc02067b4 <stride_dequeue+0x1796>
ffffffffc02053e8:	00833783          	ld	a5,8(t1)
ffffffffc02053ec:	01033983          	ld	s3,16(t1)
ffffffffc02053f0:	ec3e                	sd	a5,24(sp)
ffffffffc02053f2:	00099463          	bnez	s3,ffffffffc02053fa <stride_dequeue+0x3dc>
ffffffffc02053f6:	2af0106f          	j	ffffffffc0206ea4 <stride_dequeue+0x1e86>
ffffffffc02053fa:	85ce                	mv	a1,s3
ffffffffc02053fc:	856e                	mv	a0,s11
ffffffffc02053fe:	f81a                	sd	t1,48(sp)
ffffffffc0205400:	f442                	sd	a6,40(sp)
ffffffffc0205402:	f032                	sd	a2,32(sp)
ffffffffc0205404:	9dfff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205408:	58fd                	li	a7,-1
ffffffffc020540a:	7602                	ld	a2,32(sp)
ffffffffc020540c:	7822                	ld	a6,40(sp)
ffffffffc020540e:	7342                	ld	t1,48(sp)
ffffffffc0205410:	01151463          	bne	a0,a7,ffffffffc0205418 <stride_dequeue+0x3fa>
ffffffffc0205414:	3510106f          	j	ffffffffc0206f64 <stride_dequeue+0x1f46>
ffffffffc0205418:	0109b583          	ld	a1,16(s3)
ffffffffc020541c:	0089bb03          	ld	s6,8(s3)
ffffffffc0205420:	856e                	mv	a0,s11
ffffffffc0205422:	f81a                	sd	t1,48(sp)
ffffffffc0205424:	f442                	sd	a6,40(sp)
ffffffffc0205426:	f032                	sd	a2,32(sp)
ffffffffc0205428:	a17ff0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc020542c:	00a9b423          	sd	a0,8(s3)
ffffffffc0205430:	0169b823          	sd	s6,16(s3)
ffffffffc0205434:	7602                	ld	a2,32(sp)
ffffffffc0205436:	7822                	ld	a6,40(sp)
ffffffffc0205438:	7342                	ld	t1,48(sp)
ffffffffc020543a:	010c2b03          	lw	s6,16(s8)
ffffffffc020543e:	c119                	beqz	a0,ffffffffc0205444 <stride_dequeue+0x426>
ffffffffc0205440:	01353023          	sd	s3,0(a0)
ffffffffc0205444:	67e2                	ld	a5,24(sp)
ffffffffc0205446:	01333423          	sd	s3,8(t1)
ffffffffc020544a:	8d9a                	mv	s11,t1
ffffffffc020544c:	00f33823          	sd	a5,16(t1)
ffffffffc0205450:	0069b023          	sd	t1,0(s3)
ffffffffc0205454:	89da                	mv	s3,s6
ffffffffc0205456:	67c2                	ld	a5,16(sp)
ffffffffc0205458:	01b83423          	sd	s11,8(a6)
ffffffffc020545c:	00f83823          	sd	a5,16(a6)
ffffffffc0205460:	010db023          	sd	a6,0(s11)
ffffffffc0205464:	8dc2                	mv	s11,a6
ffffffffc0205466:	67a2                	ld	a5,8(sp)
ffffffffc0205468:	01b63423          	sd	s11,8(a2)
ffffffffc020546c:	ea1c                	sd	a5,16(a2)
ffffffffc020546e:	00cdb023          	sd	a2,0(s11)
ffffffffc0205472:	8db2                	mv	s11,a2
ffffffffc0205474:	6782                	ld	a5,0(sp)
ffffffffc0205476:	01ba3423          	sd	s11,8(s4)
ffffffffc020547a:	00fa3823          	sd	a5,16(s4)
ffffffffc020547e:	014db023          	sd	s4,0(s11)
ffffffffc0205482:	01493423          	sd	s4,8(s2)
ffffffffc0205486:	01993823          	sd	s9,16(s2)
ffffffffc020548a:	012a3023          	sd	s2,0(s4)
ffffffffc020548e:	b315                	j	ffffffffc02051b2 <stride_dequeue+0x194>
ffffffffc0205490:	84ca                	mv	s1,s2
ffffffffc0205492:	01a4b023          	sd	s10,0(s1)
ffffffffc0205496:	b335                	j	ffffffffc02051c2 <stride_dequeue+0x1a4>
ffffffffc0205498:	008db783          	ld	a5,8(s11)
ffffffffc020549c:	010dbc83          	ld	s9,16(s11)
ffffffffc02054a0:	e42a                	sd	a0,8(sp)
ffffffffc02054a2:	e03e                	sd	a5,0(sp)
ffffffffc02054a4:	100c8563          	beqz	s9,ffffffffc02055ae <stride_dequeue+0x590>
ffffffffc02054a8:	85a6                	mv	a1,s1
ffffffffc02054aa:	8566                	mv	a0,s9
ffffffffc02054ac:	937ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02054b0:	67a2                	ld	a5,8(sp)
ffffffffc02054b2:	4cf50e63          	beq	a0,a5,ffffffffc020598e <stride_dequeue+0x970>
ffffffffc02054b6:	649c                	ld	a5,8(s1)
ffffffffc02054b8:	0104ba03          	ld	s4,16(s1)
ffffffffc02054bc:	e43e                	sd	a5,8(sp)
ffffffffc02054be:	0e0a0263          	beqz	s4,ffffffffc02055a2 <stride_dequeue+0x584>
ffffffffc02054c2:	85d2                	mv	a1,s4
ffffffffc02054c4:	8566                	mv	a0,s9
ffffffffc02054c6:	91dff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02054ca:	58fd                	li	a7,-1
ffffffffc02054cc:	0d1505e3          	beq	a0,a7,ffffffffc0205d96 <stride_dequeue+0xd78>
ffffffffc02054d0:	008a3783          	ld	a5,8(s4)
ffffffffc02054d4:	010a3803          	ld	a6,16(s4)
ffffffffc02054d8:	e83e                	sd	a5,16(sp)
ffffffffc02054da:	0a080c63          	beqz	a6,ffffffffc0205592 <stride_dequeue+0x574>
ffffffffc02054de:	85c2                	mv	a1,a6
ffffffffc02054e0:	8566                	mv	a0,s9
ffffffffc02054e2:	ec42                	sd	a6,24(sp)
ffffffffc02054e4:	8ffff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02054e8:	58fd                	li	a7,-1
ffffffffc02054ea:	6862                	ld	a6,24(sp)
ffffffffc02054ec:	01151463          	bne	a0,a7,ffffffffc02054f4 <stride_dequeue+0x4d6>
ffffffffc02054f0:	07c0106f          	j	ffffffffc020656c <stride_dequeue+0x154e>
ffffffffc02054f4:	00883783          	ld	a5,8(a6)
ffffffffc02054f8:	01083983          	ld	s3,16(a6)
ffffffffc02054fc:	ec3e                	sd	a5,24(sp)
ffffffffc02054fe:	00099463          	bnez	s3,ffffffffc0205506 <stride_dequeue+0x4e8>
ffffffffc0205502:	2bb0106f          	j	ffffffffc0206fbc <stride_dequeue+0x1f9e>
ffffffffc0205506:	85ce                	mv	a1,s3
ffffffffc0205508:	8566                	mv	a0,s9
ffffffffc020550a:	f042                	sd	a6,32(sp)
ffffffffc020550c:	8d7ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205510:	58fd                	li	a7,-1
ffffffffc0205512:	7802                	ld	a6,32(sp)
ffffffffc0205514:	01151463          	bne	a0,a7,ffffffffc020551c <stride_dequeue+0x4fe>
ffffffffc0205518:	05f0106f          	j	ffffffffc0206d76 <stride_dequeue+0x1d58>
ffffffffc020551c:	0089b783          	ld	a5,8(s3)
ffffffffc0205520:	0109be03          	ld	t3,16(s3)
ffffffffc0205524:	f03e                	sd	a5,32(sp)
ffffffffc0205526:	040e0663          	beqz	t3,ffffffffc0205572 <stride_dequeue+0x554>
ffffffffc020552a:	85f2                	mv	a1,t3
ffffffffc020552c:	8566                	mv	a0,s9
ffffffffc020552e:	f842                	sd	a6,48(sp)
ffffffffc0205530:	f472                	sd	t3,40(sp)
ffffffffc0205532:	8b1ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205536:	58fd                	li	a7,-1
ffffffffc0205538:	7e22                	ld	t3,40(sp)
ffffffffc020553a:	7842                	ld	a6,48(sp)
ffffffffc020553c:	01151463          	bne	a0,a7,ffffffffc0205544 <stride_dequeue+0x526>
ffffffffc0205540:	4e70106f          	j	ffffffffc0207226 <stride_dequeue+0x2208>
ffffffffc0205544:	010e3583          	ld	a1,16(t3)
ffffffffc0205548:	8566                	mv	a0,s9
ffffffffc020554a:	008e3b03          	ld	s6,8(t3)
ffffffffc020554e:	f842                	sd	a6,48(sp)
ffffffffc0205550:	f472                	sd	t3,40(sp)
ffffffffc0205552:	8edff0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0205556:	7e22                	ld	t3,40(sp)
ffffffffc0205558:	7842                	ld	a6,48(sp)
ffffffffc020555a:	016e3823          	sd	s6,16(t3)
ffffffffc020555e:	00ae3423          	sd	a0,8(t3)
ffffffffc0205562:	010c2b03          	lw	s6,16(s8)
ffffffffc0205566:	e119                	bnez	a0,ffffffffc020556c <stride_dequeue+0x54e>
ffffffffc0205568:	7bb0106f          	j	ffffffffc0207522 <stride_dequeue+0x2504>
ffffffffc020556c:	01c53023          	sd	t3,0(a0)
ffffffffc0205570:	8cf2                	mv	s9,t3
ffffffffc0205572:	7782                	ld	a5,32(sp)
ffffffffc0205574:	0199b423          	sd	s9,8(s3)
ffffffffc0205578:	00f9b823          	sd	a5,16(s3)
ffffffffc020557c:	013cb023          	sd	s3,0(s9)
ffffffffc0205580:	67e2                	ld	a5,24(sp)
ffffffffc0205582:	01383423          	sd	s3,8(a6)
ffffffffc0205586:	8cc2                	mv	s9,a6
ffffffffc0205588:	00f83823          	sd	a5,16(a6)
ffffffffc020558c:	0109b023          	sd	a6,0(s3)
ffffffffc0205590:	89da                	mv	s3,s6
ffffffffc0205592:	67c2                	ld	a5,16(sp)
ffffffffc0205594:	019a3423          	sd	s9,8(s4)
ffffffffc0205598:	00fa3823          	sd	a5,16(s4)
ffffffffc020559c:	014cb023          	sd	s4,0(s9)
ffffffffc02055a0:	8cd2                	mv	s9,s4
ffffffffc02055a2:	67a2                	ld	a5,8(sp)
ffffffffc02055a4:	0194b423          	sd	s9,8(s1)
ffffffffc02055a8:	e89c                	sd	a5,16(s1)
ffffffffc02055aa:	009cb023          	sd	s1,0(s9)
ffffffffc02055ae:	6782                	ld	a5,0(sp)
ffffffffc02055b0:	009db423          	sd	s1,8(s11)
ffffffffc02055b4:	00fdb823          	sd	a5,16(s11)
ffffffffc02055b8:	01b4b023          	sd	s11,0(s1)
ffffffffc02055bc:	84ee                	mv	s1,s11
ffffffffc02055be:	bbad                	j	ffffffffc0205338 <stride_dequeue+0x31a>
ffffffffc02055c0:	008db783          	ld	a5,8(s11)
ffffffffc02055c4:	010db603          	ld	a2,16(s11)
ffffffffc02055c8:	e03e                	sd	a5,0(sp)
ffffffffc02055ca:	0e060963          	beqz	a2,ffffffffc02056bc <stride_dequeue+0x69e>
ffffffffc02055ce:	8532                	mv	a0,a2
ffffffffc02055d0:	85d2                	mv	a1,s4
ffffffffc02055d2:	e432                	sd	a2,8(sp)
ffffffffc02055d4:	80fff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02055d8:	58fd                	li	a7,-1
ffffffffc02055da:	6622                	ld	a2,8(sp)
ffffffffc02055dc:	091504e3          	beq	a0,a7,ffffffffc0205e64 <stride_dequeue+0xe46>
ffffffffc02055e0:	008a3783          	ld	a5,8(s4)
ffffffffc02055e4:	010a3803          	ld	a6,16(s4)
ffffffffc02055e8:	e43e                	sd	a5,8(sp)
ffffffffc02055ea:	0c080263          	beqz	a6,ffffffffc02056ae <stride_dequeue+0x690>
ffffffffc02055ee:	85c2                	mv	a1,a6
ffffffffc02055f0:	8532                	mv	a0,a2
ffffffffc02055f2:	ec42                	sd	a6,24(sp)
ffffffffc02055f4:	e832                	sd	a2,16(sp)
ffffffffc02055f6:	fecff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02055fa:	58fd                	li	a7,-1
ffffffffc02055fc:	6642                	ld	a2,16(sp)
ffffffffc02055fe:	6862                	ld	a6,24(sp)
ffffffffc0205600:	01151463          	bne	a0,a7,ffffffffc0205608 <stride_dequeue+0x5ea>
ffffffffc0205604:	00a0106f          	j	ffffffffc020660e <stride_dequeue+0x15f0>
ffffffffc0205608:	00883783          	ld	a5,8(a6)
ffffffffc020560c:	01083983          	ld	s3,16(a6)
ffffffffc0205610:	e83e                	sd	a5,16(sp)
ffffffffc0205612:	00099463          	bnez	s3,ffffffffc020561a <stride_dequeue+0x5fc>
ffffffffc0205616:	1e50106f          	j	ffffffffc0206ffa <stride_dequeue+0x1fdc>
ffffffffc020561a:	8532                	mv	a0,a2
ffffffffc020561c:	85ce                	mv	a1,s3
ffffffffc020561e:	f042                	sd	a6,32(sp)
ffffffffc0205620:	ec32                	sd	a2,24(sp)
ffffffffc0205622:	fc0ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205626:	58fd                	li	a7,-1
ffffffffc0205628:	6662                	ld	a2,24(sp)
ffffffffc020562a:	7802                	ld	a6,32(sp)
ffffffffc020562c:	01151463          	bne	a0,a7,ffffffffc0205634 <stride_dequeue+0x616>
ffffffffc0205630:	4fc0106f          	j	ffffffffc0206b2c <stride_dequeue+0x1b0e>
ffffffffc0205634:	0089b783          	ld	a5,8(s3)
ffffffffc0205638:	0109be03          	ld	t3,16(s3)
ffffffffc020563c:	ec3e                	sd	a5,24(sp)
ffffffffc020563e:	040e0863          	beqz	t3,ffffffffc020568e <stride_dequeue+0x670>
ffffffffc0205642:	85f2                	mv	a1,t3
ffffffffc0205644:	8532                	mv	a0,a2
ffffffffc0205646:	f842                	sd	a6,48(sp)
ffffffffc0205648:	f472                	sd	t3,40(sp)
ffffffffc020564a:	f032                	sd	a2,32(sp)
ffffffffc020564c:	f96ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205650:	7842                	ld	a6,48(sp)
ffffffffc0205652:	7e22                	ld	t3,40(sp)
ffffffffc0205654:	58fd                	li	a7,-1
ffffffffc0205656:	f442                	sd	a6,40(sp)
ffffffffc0205658:	7602                	ld	a2,32(sp)
ffffffffc020565a:	01151463          	bne	a0,a7,ffffffffc0205662 <stride_dequeue+0x644>
ffffffffc020565e:	37b0106f          	j	ffffffffc02071d8 <stride_dequeue+0x21ba>
ffffffffc0205662:	010e3583          	ld	a1,16(t3)
ffffffffc0205666:	8532                	mv	a0,a2
ffffffffc0205668:	008e3b03          	ld	s6,8(t3)
ffffffffc020566c:	f072                	sd	t3,32(sp)
ffffffffc020566e:	fd0ff0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0205672:	7e02                	ld	t3,32(sp)
ffffffffc0205674:	7822                	ld	a6,40(sp)
ffffffffc0205676:	016e3823          	sd	s6,16(t3)
ffffffffc020567a:	00ae3423          	sd	a0,8(t3)
ffffffffc020567e:	010c2b03          	lw	s6,16(s8)
ffffffffc0205682:	e119                	bnez	a0,ffffffffc0205688 <stride_dequeue+0x66a>
ffffffffc0205684:	7090106f          	j	ffffffffc020758c <stride_dequeue+0x256e>
ffffffffc0205688:	01c53023          	sd	t3,0(a0)
ffffffffc020568c:	8672                	mv	a2,t3
ffffffffc020568e:	67e2                	ld	a5,24(sp)
ffffffffc0205690:	00c9b423          	sd	a2,8(s3)
ffffffffc0205694:	00f9b823          	sd	a5,16(s3)
ffffffffc0205698:	01363023          	sd	s3,0(a2)
ffffffffc020569c:	67c2                	ld	a5,16(sp)
ffffffffc020569e:	01383423          	sd	s3,8(a6)
ffffffffc02056a2:	8642                	mv	a2,a6
ffffffffc02056a4:	00f83823          	sd	a5,16(a6)
ffffffffc02056a8:	0109b023          	sd	a6,0(s3)
ffffffffc02056ac:	89da                	mv	s3,s6
ffffffffc02056ae:	67a2                	ld	a5,8(sp)
ffffffffc02056b0:	00ca3423          	sd	a2,8(s4)
ffffffffc02056b4:	00fa3823          	sd	a5,16(s4)
ffffffffc02056b8:	01463023          	sd	s4,0(a2)
ffffffffc02056bc:	6782                	ld	a5,0(sp)
ffffffffc02056be:	014db423          	sd	s4,8(s11)
ffffffffc02056c2:	00fdb823          	sd	a5,16(s11)
ffffffffc02056c6:	01ba3023          	sd	s11,0(s4)
ffffffffc02056ca:	8a6e                	mv	s4,s11
ffffffffc02056cc:	bb5d                	j	ffffffffc0205482 <stride_dequeue+0x464>
ffffffffc02056ce:	008db783          	ld	a5,8(s11)
ffffffffc02056d2:	010dba03          	ld	s4,16(s11)
ffffffffc02056d6:	e43e                	sd	a5,8(sp)
ffffffffc02056d8:	0e0a0163          	beqz	s4,ffffffffc02057ba <stride_dequeue+0x79c>
ffffffffc02056dc:	85e6                	mv	a1,s9
ffffffffc02056de:	8552                	mv	a0,s4
ffffffffc02056e0:	f02ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02056e4:	58fd                	li	a7,-1
ffffffffc02056e6:	05150de3          	beq	a0,a7,ffffffffc0205f40 <stride_dequeue+0xf22>
ffffffffc02056ea:	008cb783          	ld	a5,8(s9)
ffffffffc02056ee:	010cb803          	ld	a6,16(s9)
ffffffffc02056f2:	e83e                	sd	a5,16(sp)
ffffffffc02056f4:	0a080c63          	beqz	a6,ffffffffc02057ac <stride_dequeue+0x78e>
ffffffffc02056f8:	85c2                	mv	a1,a6
ffffffffc02056fa:	8552                	mv	a0,s4
ffffffffc02056fc:	ec42                	sd	a6,24(sp)
ffffffffc02056fe:	ee4ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205702:	58fd                	li	a7,-1
ffffffffc0205704:	6862                	ld	a6,24(sp)
ffffffffc0205706:	01151463          	bne	a0,a7,ffffffffc020570e <stride_dequeue+0x6f0>
ffffffffc020570a:	7ab0006f          	j	ffffffffc02066b4 <stride_dequeue+0x1696>
ffffffffc020570e:	00883783          	ld	a5,8(a6)
ffffffffc0205712:	01083983          	ld	s3,16(a6)
ffffffffc0205716:	ec3e                	sd	a5,24(sp)
ffffffffc0205718:	00099463          	bnez	s3,ffffffffc0205720 <stride_dequeue+0x702>
ffffffffc020571c:	0cd0106f          	j	ffffffffc0206fe8 <stride_dequeue+0x1fca>
ffffffffc0205720:	85ce                	mv	a1,s3
ffffffffc0205722:	8552                	mv	a0,s4
ffffffffc0205724:	f042                	sd	a6,32(sp)
ffffffffc0205726:	ebcff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc020572a:	58fd                	li	a7,-1
ffffffffc020572c:	7802                	ld	a6,32(sp)
ffffffffc020572e:	01151463          	bne	a0,a7,ffffffffc0205736 <stride_dequeue+0x718>
ffffffffc0205732:	39c0106f          	j	ffffffffc0206ace <stride_dequeue+0x1ab0>
ffffffffc0205736:	0089b783          	ld	a5,8(s3)
ffffffffc020573a:	0109be03          	ld	t3,16(s3)
ffffffffc020573e:	f03e                	sd	a5,32(sp)
ffffffffc0205740:	040e0663          	beqz	t3,ffffffffc020578c <stride_dequeue+0x76e>
ffffffffc0205744:	85f2                	mv	a1,t3
ffffffffc0205746:	8552                	mv	a0,s4
ffffffffc0205748:	f842                	sd	a6,48(sp)
ffffffffc020574a:	f472                	sd	t3,40(sp)
ffffffffc020574c:	e96ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205750:	58fd                	li	a7,-1
ffffffffc0205752:	7e22                	ld	t3,40(sp)
ffffffffc0205754:	7842                	ld	a6,48(sp)
ffffffffc0205756:	01151463          	bne	a0,a7,ffffffffc020575e <stride_dequeue+0x740>
ffffffffc020575a:	2f90106f          	j	ffffffffc0207252 <stride_dequeue+0x2234>
ffffffffc020575e:	010e3583          	ld	a1,16(t3)
ffffffffc0205762:	8552                	mv	a0,s4
ffffffffc0205764:	008e3b03          	ld	s6,8(t3)
ffffffffc0205768:	f842                	sd	a6,48(sp)
ffffffffc020576a:	f472                	sd	t3,40(sp)
ffffffffc020576c:	ed2ff0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0205770:	7e22                	ld	t3,40(sp)
ffffffffc0205772:	7842                	ld	a6,48(sp)
ffffffffc0205774:	016e3823          	sd	s6,16(t3)
ffffffffc0205778:	00ae3423          	sd	a0,8(t3)
ffffffffc020577c:	010c2b03          	lw	s6,16(s8)
ffffffffc0205780:	e119                	bnez	a0,ffffffffc0205786 <stride_dequeue+0x768>
ffffffffc0205782:	5a70106f          	j	ffffffffc0207528 <stride_dequeue+0x250a>
ffffffffc0205786:	01c53023          	sd	t3,0(a0)
ffffffffc020578a:	8a72                	mv	s4,t3
ffffffffc020578c:	7782                	ld	a5,32(sp)
ffffffffc020578e:	0149b423          	sd	s4,8(s3)
ffffffffc0205792:	00f9b823          	sd	a5,16(s3)
ffffffffc0205796:	013a3023          	sd	s3,0(s4)
ffffffffc020579a:	67e2                	ld	a5,24(sp)
ffffffffc020579c:	01383423          	sd	s3,8(a6)
ffffffffc02057a0:	8a42                	mv	s4,a6
ffffffffc02057a2:	00f83823          	sd	a5,16(a6)
ffffffffc02057a6:	0109b023          	sd	a6,0(s3)
ffffffffc02057aa:	89da                	mv	s3,s6
ffffffffc02057ac:	67c2                	ld	a5,16(sp)
ffffffffc02057ae:	014cb423          	sd	s4,8(s9)
ffffffffc02057b2:	00fcb823          	sd	a5,16(s9)
ffffffffc02057b6:	019a3023          	sd	s9,0(s4)
ffffffffc02057ba:	67a2                	ld	a5,8(sp)
ffffffffc02057bc:	019db423          	sd	s9,8(s11)
ffffffffc02057c0:	00fdb823          	sd	a5,16(s11)
ffffffffc02057c4:	01bcb023          	sd	s11,0(s9)
ffffffffc02057c8:	b695                	j	ffffffffc020532c <stride_dequeue+0x30e>
ffffffffc02057ca:	00893783          	ld	a5,8(s2)
ffffffffc02057ce:	01093883          	ld	a7,16(s2)
ffffffffc02057d2:	ec2a                	sd	a0,24(sp)
ffffffffc02057d4:	e83e                	sd	a5,16(sp)
ffffffffc02057d6:	0a088963          	beqz	a7,ffffffffc0205888 <stride_dequeue+0x86a>
ffffffffc02057da:	8546                	mv	a0,a7
ffffffffc02057dc:	85e6                	mv	a1,s9
ffffffffc02057de:	f046                	sd	a7,32(sp)
ffffffffc02057e0:	e02ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02057e4:	6862                	ld	a6,24(sp)
ffffffffc02057e6:	7882                	ld	a7,32(sp)
ffffffffc02057e8:	030504e3          	beq	a0,a6,ffffffffc0206010 <stride_dequeue+0xff2>
ffffffffc02057ec:	008cb783          	ld	a5,8(s9)
ffffffffc02057f0:	010cb303          	ld	t1,16(s9)
ffffffffc02057f4:	f042                	sd	a6,32(sp)
ffffffffc02057f6:	ec3e                	sd	a5,24(sp)
ffffffffc02057f8:	08030163          	beqz	t1,ffffffffc020587a <stride_dequeue+0x85c>
ffffffffc02057fc:	859a                	mv	a1,t1
ffffffffc02057fe:	8546                	mv	a0,a7
ffffffffc0205800:	f81a                	sd	t1,48(sp)
ffffffffc0205802:	f446                	sd	a7,40(sp)
ffffffffc0205804:	ddeff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205808:	7802                	ld	a6,32(sp)
ffffffffc020580a:	78a2                	ld	a7,40(sp)
ffffffffc020580c:	7342                	ld	t1,48(sp)
ffffffffc020580e:	01051463          	bne	a0,a6,ffffffffc0205816 <stride_dequeue+0x7f8>
ffffffffc0205812:	0d00106f          	j	ffffffffc02068e2 <stride_dequeue+0x18c4>
ffffffffc0205816:	00833783          	ld	a5,8(t1)
ffffffffc020581a:	01033983          	ld	s3,16(t1)
ffffffffc020581e:	f442                	sd	a6,40(sp)
ffffffffc0205820:	f03e                	sd	a5,32(sp)
ffffffffc0205822:	00099463          	bnez	s3,ffffffffc020582a <stride_dequeue+0x80c>
ffffffffc0205826:	6720106f          	j	ffffffffc0206e98 <stride_dequeue+0x1e7a>
ffffffffc020582a:	8546                	mv	a0,a7
ffffffffc020582c:	85ce                	mv	a1,s3
ffffffffc020582e:	fc1a                	sd	t1,56(sp)
ffffffffc0205830:	f846                	sd	a7,48(sp)
ffffffffc0205832:	db0ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205836:	7822                	ld	a6,40(sp)
ffffffffc0205838:	78c2                	ld	a7,48(sp)
ffffffffc020583a:	7362                	ld	t1,56(sp)
ffffffffc020583c:	01051463          	bne	a0,a6,ffffffffc0205844 <stride_dequeue+0x826>
ffffffffc0205840:	6700106f          	j	ffffffffc0206eb0 <stride_dequeue+0x1e92>
ffffffffc0205844:	0109b583          	ld	a1,16(s3)
ffffffffc0205848:	0089bb03          	ld	s6,8(s3)
ffffffffc020584c:	8546                	mv	a0,a7
ffffffffc020584e:	f41a                	sd	t1,40(sp)
ffffffffc0205850:	deeff0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0205854:	00a9b423          	sd	a0,8(s3)
ffffffffc0205858:	0169b823          	sd	s6,16(s3)
ffffffffc020585c:	7322                	ld	t1,40(sp)
ffffffffc020585e:	010c2b03          	lw	s6,16(s8)
ffffffffc0205862:	c119                	beqz	a0,ffffffffc0205868 <stride_dequeue+0x84a>
ffffffffc0205864:	01353023          	sd	s3,0(a0)
ffffffffc0205868:	7782                	ld	a5,32(sp)
ffffffffc020586a:	01333423          	sd	s3,8(t1)
ffffffffc020586e:	889a                	mv	a7,t1
ffffffffc0205870:	00f33823          	sd	a5,16(t1)
ffffffffc0205874:	0069b023          	sd	t1,0(s3)
ffffffffc0205878:	89da                	mv	s3,s6
ffffffffc020587a:	67e2                	ld	a5,24(sp)
ffffffffc020587c:	011cb423          	sd	a7,8(s9)
ffffffffc0205880:	00fcb823          	sd	a5,16(s9)
ffffffffc0205884:	0198b023          	sd	s9,0(a7)
ffffffffc0205888:	67c2                	ld	a5,16(sp)
ffffffffc020588a:	01993423          	sd	s9,8(s2)
ffffffffc020588e:	00f93823          	sd	a5,16(s2)
ffffffffc0205892:	012cb023          	sd	s2,0(s9)
ffffffffc0205896:	b8f5                	j	ffffffffc0205192 <stride_dequeue+0x174>
ffffffffc0205898:	00893783          	ld	a5,8(s2)
ffffffffc020589c:	01093c83          	ld	s9,16(s2)
ffffffffc02058a0:	e43e                	sd	a5,8(sp)
ffffffffc02058a2:	0c0c8d63          	beqz	s9,ffffffffc020597c <stride_dequeue+0x95e>
ffffffffc02058a6:	85ee                	mv	a1,s11
ffffffffc02058a8:	8566                	mv	a0,s9
ffffffffc02058aa:	d38ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02058ae:	58fd                	li	a7,-1
ffffffffc02058b0:	39150063          	beq	a0,a7,ffffffffc0205c30 <stride_dequeue+0xc12>
ffffffffc02058b4:	008db783          	ld	a5,8(s11)
ffffffffc02058b8:	010db803          	ld	a6,16(s11)
ffffffffc02058bc:	e83e                	sd	a5,16(sp)
ffffffffc02058be:	0a080863          	beqz	a6,ffffffffc020596e <stride_dequeue+0x950>
ffffffffc02058c2:	85c2                	mv	a1,a6
ffffffffc02058c4:	8566                	mv	a0,s9
ffffffffc02058c6:	ec42                	sd	a6,24(sp)
ffffffffc02058c8:	d1aff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02058cc:	58fd                	li	a7,-1
ffffffffc02058ce:	6862                	ld	a6,24(sp)
ffffffffc02058d0:	7d150f63          	beq	a0,a7,ffffffffc02060ae <stride_dequeue+0x1090>
ffffffffc02058d4:	00883783          	ld	a5,8(a6)
ffffffffc02058d8:	01083303          	ld	t1,16(a6)
ffffffffc02058dc:	ec3e                	sd	a5,24(sp)
ffffffffc02058de:	08030063          	beqz	t1,ffffffffc020595e <stride_dequeue+0x940>
ffffffffc02058e2:	859a                	mv	a1,t1
ffffffffc02058e4:	8566                	mv	a0,s9
ffffffffc02058e6:	f442                	sd	a6,40(sp)
ffffffffc02058e8:	f01a                	sd	t1,32(sp)
ffffffffc02058ea:	cf8ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02058ee:	58fd                	li	a7,-1
ffffffffc02058f0:	7302                	ld	t1,32(sp)
ffffffffc02058f2:	7822                	ld	a6,40(sp)
ffffffffc02058f4:	65150fe3          	beq	a0,a7,ffffffffc0206752 <stride_dequeue+0x1734>
ffffffffc02058f8:	00833783          	ld	a5,8(t1)
ffffffffc02058fc:	01033983          	ld	s3,16(t1)
ffffffffc0205900:	f03e                	sd	a5,32(sp)
ffffffffc0205902:	00099463          	bnez	s3,ffffffffc020590a <stride_dequeue+0x8ec>
ffffffffc0205906:	5980106f          	j	ffffffffc0206e9e <stride_dequeue+0x1e80>
ffffffffc020590a:	85ce                	mv	a1,s3
ffffffffc020590c:	8566                	mv	a0,s9
ffffffffc020590e:	f81a                	sd	t1,48(sp)
ffffffffc0205910:	f442                	sd	a6,40(sp)
ffffffffc0205912:	cd0ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205916:	58fd                	li	a7,-1
ffffffffc0205918:	7822                	ld	a6,40(sp)
ffffffffc020591a:	7342                	ld	t1,48(sp)
ffffffffc020591c:	01151463          	bne	a0,a7,ffffffffc0205924 <stride_dequeue+0x906>
ffffffffc0205920:	5ea0106f          	j	ffffffffc0206f0a <stride_dequeue+0x1eec>
ffffffffc0205924:	0109b583          	ld	a1,16(s3)
ffffffffc0205928:	0089bb03          	ld	s6,8(s3)
ffffffffc020592c:	8566                	mv	a0,s9
ffffffffc020592e:	f81a                	sd	t1,48(sp)
ffffffffc0205930:	f442                	sd	a6,40(sp)
ffffffffc0205932:	d0cff0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0205936:	00a9b423          	sd	a0,8(s3)
ffffffffc020593a:	0169b823          	sd	s6,16(s3)
ffffffffc020593e:	7822                	ld	a6,40(sp)
ffffffffc0205940:	7342                	ld	t1,48(sp)
ffffffffc0205942:	010c2b03          	lw	s6,16(s8)
ffffffffc0205946:	c119                	beqz	a0,ffffffffc020594c <stride_dequeue+0x92e>
ffffffffc0205948:	01353023          	sd	s3,0(a0)
ffffffffc020594c:	7782                	ld	a5,32(sp)
ffffffffc020594e:	01333423          	sd	s3,8(t1)
ffffffffc0205952:	8c9a                	mv	s9,t1
ffffffffc0205954:	00f33823          	sd	a5,16(t1)
ffffffffc0205958:	0069b023          	sd	t1,0(s3)
ffffffffc020595c:	89da                	mv	s3,s6
ffffffffc020595e:	67e2                	ld	a5,24(sp)
ffffffffc0205960:	01983423          	sd	s9,8(a6)
ffffffffc0205964:	00f83823          	sd	a5,16(a6)
ffffffffc0205968:	010cb023          	sd	a6,0(s9)
ffffffffc020596c:	8cc2                	mv	s9,a6
ffffffffc020596e:	67c2                	ld	a5,16(sp)
ffffffffc0205970:	019db423          	sd	s9,8(s11)
ffffffffc0205974:	00fdb823          	sd	a5,16(s11)
ffffffffc0205978:	01bcb023          	sd	s11,0(s9)
ffffffffc020597c:	67a2                	ld	a5,8(sp)
ffffffffc020597e:	01b93423          	sd	s11,8(s2)
ffffffffc0205982:	00f93823          	sd	a5,16(s2)
ffffffffc0205986:	012db023          	sd	s2,0(s11)
ffffffffc020598a:	819ff06f          	j	ffffffffc02051a2 <stride_dequeue+0x184>
ffffffffc020598e:	008cb783          	ld	a5,8(s9)
ffffffffc0205992:	010cba03          	ld	s4,16(s9)
ffffffffc0205996:	e43e                	sd	a5,8(sp)
ffffffffc0205998:	0c0a0d63          	beqz	s4,ffffffffc0205a72 <stride_dequeue+0xa54>
ffffffffc020599c:	85a6                	mv	a1,s1
ffffffffc020599e:	8552                	mv	a0,s4
ffffffffc02059a0:	c42ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02059a4:	58fd                	li	a7,-1
ffffffffc02059a6:	151500e3          	beq	a0,a7,ffffffffc02062e6 <stride_dequeue+0x12c8>
ffffffffc02059aa:	649c                	ld	a5,8(s1)
ffffffffc02059ac:	0104b983          	ld	s3,16(s1)
ffffffffc02059b0:	e83e                	sd	a5,16(sp)
ffffffffc02059b2:	00099463          	bnez	s3,ffffffffc02059ba <stride_dequeue+0x99c>
ffffffffc02059b6:	4f40106f          	j	ffffffffc0206eaa <stride_dequeue+0x1e8c>
ffffffffc02059ba:	85ce                	mv	a1,s3
ffffffffc02059bc:	8552                	mv	a0,s4
ffffffffc02059be:	c24ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02059c2:	58fd                	li	a7,-1
ffffffffc02059c4:	01151463          	bne	a0,a7,ffffffffc02059cc <stride_dequeue+0x9ae>
ffffffffc02059c8:	0b00106f          	j	ffffffffc0206a78 <stride_dequeue+0x1a5a>
ffffffffc02059cc:	0089b783          	ld	a5,8(s3)
ffffffffc02059d0:	0109b303          	ld	t1,16(s3)
ffffffffc02059d4:	ec3e                	sd	a5,24(sp)
ffffffffc02059d6:	08030063          	beqz	t1,ffffffffc0205a56 <stride_dequeue+0xa38>
ffffffffc02059da:	859a                	mv	a1,t1
ffffffffc02059dc:	8552                	mv	a0,s4
ffffffffc02059de:	f01a                	sd	t1,32(sp)
ffffffffc02059e0:	c02ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02059e4:	58fd                	li	a7,-1
ffffffffc02059e6:	7302                	ld	t1,32(sp)
ffffffffc02059e8:	01151463          	bne	a0,a7,ffffffffc02059f0 <stride_dequeue+0x9d2>
ffffffffc02059ec:	0130106f          	j	ffffffffc02071fe <stride_dequeue+0x21e0>
ffffffffc02059f0:	00833783          	ld	a5,8(t1)
ffffffffc02059f4:	01033e03          	ld	t3,16(t1)
ffffffffc02059f8:	f03e                	sd	a5,32(sp)
ffffffffc02059fa:	040e0663          	beqz	t3,ffffffffc0205a46 <stride_dequeue+0xa28>
ffffffffc02059fe:	85f2                	mv	a1,t3
ffffffffc0205a00:	8552                	mv	a0,s4
ffffffffc0205a02:	f81a                	sd	t1,48(sp)
ffffffffc0205a04:	f472                	sd	t3,40(sp)
ffffffffc0205a06:	bdcff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205a0a:	58fd                	li	a7,-1
ffffffffc0205a0c:	7e22                	ld	t3,40(sp)
ffffffffc0205a0e:	7342                	ld	t1,48(sp)
ffffffffc0205a10:	01151463          	bne	a0,a7,ffffffffc0205a18 <stride_dequeue+0x9fa>
ffffffffc0205a14:	53d0106f          	j	ffffffffc0207750 <stride_dequeue+0x2732>
ffffffffc0205a18:	010e3583          	ld	a1,16(t3)
ffffffffc0205a1c:	8552                	mv	a0,s4
ffffffffc0205a1e:	008e3b03          	ld	s6,8(t3)
ffffffffc0205a22:	f81a                	sd	t1,48(sp)
ffffffffc0205a24:	f472                	sd	t3,40(sp)
ffffffffc0205a26:	c18ff0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0205a2a:	7e22                	ld	t3,40(sp)
ffffffffc0205a2c:	7342                	ld	t1,48(sp)
ffffffffc0205a2e:	016e3823          	sd	s6,16(t3)
ffffffffc0205a32:	00ae3423          	sd	a0,8(t3)
ffffffffc0205a36:	010c2b03          	lw	s6,16(s8)
ffffffffc0205a3a:	e119                	bnez	a0,ffffffffc0205a40 <stride_dequeue+0xa22>
ffffffffc0205a3c:	76d0106f          	j	ffffffffc02079a8 <stride_dequeue+0x298a>
ffffffffc0205a40:	01c53023          	sd	t3,0(a0)
ffffffffc0205a44:	8a72                	mv	s4,t3
ffffffffc0205a46:	7782                	ld	a5,32(sp)
ffffffffc0205a48:	01433423          	sd	s4,8(t1)
ffffffffc0205a4c:	00f33823          	sd	a5,16(t1)
ffffffffc0205a50:	006a3023          	sd	t1,0(s4)
ffffffffc0205a54:	8a1a                	mv	s4,t1
ffffffffc0205a56:	67e2                	ld	a5,24(sp)
ffffffffc0205a58:	0149b423          	sd	s4,8(s3)
ffffffffc0205a5c:	00f9b823          	sd	a5,16(s3)
ffffffffc0205a60:	013a3023          	sd	s3,0(s4)
ffffffffc0205a64:	67c2                	ld	a5,16(sp)
ffffffffc0205a66:	0134b423          	sd	s3,8(s1)
ffffffffc0205a6a:	e89c                	sd	a5,16(s1)
ffffffffc0205a6c:	0099b023          	sd	s1,0(s3)
ffffffffc0205a70:	89da                	mv	s3,s6
ffffffffc0205a72:	67a2                	ld	a5,8(sp)
ffffffffc0205a74:	009cb423          	sd	s1,8(s9)
ffffffffc0205a78:	00fcb823          	sd	a5,16(s9)
ffffffffc0205a7c:	0194b023          	sd	s9,0(s1)
ffffffffc0205a80:	84e6                	mv	s1,s9
ffffffffc0205a82:	b635                	j	ffffffffc02055ae <stride_dequeue+0x590>
ffffffffc0205a84:	008db783          	ld	a5,8(s11)
ffffffffc0205a88:	010db883          	ld	a7,16(s11)
ffffffffc0205a8c:	ec2a                	sd	a0,24(sp)
ffffffffc0205a8e:	e83e                	sd	a5,16(sp)
ffffffffc0205a90:	0a088963          	beqz	a7,ffffffffc0205b42 <stride_dequeue+0xb24>
ffffffffc0205a94:	8546                	mv	a0,a7
ffffffffc0205a96:	85d2                	mv	a1,s4
ffffffffc0205a98:	f046                	sd	a7,32(sp)
ffffffffc0205a9a:	b48ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205a9e:	6862                	ld	a6,24(sp)
ffffffffc0205aa0:	7882                	ld	a7,32(sp)
ffffffffc0205aa2:	0d050ae3          	beq	a0,a6,ffffffffc0206376 <stride_dequeue+0x1358>
ffffffffc0205aa6:	008a3783          	ld	a5,8(s4)
ffffffffc0205aaa:	010a3983          	ld	s3,16(s4)
ffffffffc0205aae:	f042                	sd	a6,32(sp)
ffffffffc0205ab0:	ec3e                	sd	a5,24(sp)
ffffffffc0205ab2:	00099463          	bnez	s3,ffffffffc0205aba <stride_dequeue+0xa9c>
ffffffffc0205ab6:	53e0106f          	j	ffffffffc0206ff4 <stride_dequeue+0x1fd6>
ffffffffc0205aba:	8546                	mv	a0,a7
ffffffffc0205abc:	85ce                	mv	a1,s3
ffffffffc0205abe:	f446                	sd	a7,40(sp)
ffffffffc0205ac0:	b22ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205ac4:	7802                	ld	a6,32(sp)
ffffffffc0205ac6:	78a2                	ld	a7,40(sp)
ffffffffc0205ac8:	01051463          	bne	a0,a6,ffffffffc0205ad0 <stride_dequeue+0xab2>
ffffffffc0205acc:	1260106f          	j	ffffffffc0206bf2 <stride_dequeue+0x1bd4>
ffffffffc0205ad0:	0089b783          	ld	a5,8(s3)
ffffffffc0205ad4:	0109be03          	ld	t3,16(s3)
ffffffffc0205ad8:	f442                	sd	a6,40(sp)
ffffffffc0205ada:	f03e                	sd	a5,32(sp)
ffffffffc0205adc:	040e0463          	beqz	t3,ffffffffc0205b24 <stride_dequeue+0xb06>
ffffffffc0205ae0:	85f2                	mv	a1,t3
ffffffffc0205ae2:	8546                	mv	a0,a7
ffffffffc0205ae4:	fc72                	sd	t3,56(sp)
ffffffffc0205ae6:	f846                	sd	a7,48(sp)
ffffffffc0205ae8:	afaff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205aec:	7822                	ld	a6,40(sp)
ffffffffc0205aee:	78c2                	ld	a7,48(sp)
ffffffffc0205af0:	7e62                	ld	t3,56(sp)
ffffffffc0205af2:	01051463          	bne	a0,a6,ffffffffc0205afa <stride_dequeue+0xadc>
ffffffffc0205af6:	0e70106f          	j	ffffffffc02073dc <stride_dequeue+0x23be>
ffffffffc0205afa:	010e3583          	ld	a1,16(t3)
ffffffffc0205afe:	8546                	mv	a0,a7
ffffffffc0205b00:	008e3b03          	ld	s6,8(t3)
ffffffffc0205b04:	f472                	sd	t3,40(sp)
ffffffffc0205b06:	b38ff0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0205b0a:	7e22                	ld	t3,40(sp)
ffffffffc0205b0c:	016e3823          	sd	s6,16(t3)
ffffffffc0205b10:	00ae3423          	sd	a0,8(t3)
ffffffffc0205b14:	010c2b03          	lw	s6,16(s8)
ffffffffc0205b18:	e119                	bnez	a0,ffffffffc0205b1e <stride_dequeue+0xb00>
ffffffffc0205b1a:	1c10106f          	j	ffffffffc02074da <stride_dequeue+0x24bc>
ffffffffc0205b1e:	01c53023          	sd	t3,0(a0)
ffffffffc0205b22:	88f2                	mv	a7,t3
ffffffffc0205b24:	7782                	ld	a5,32(sp)
ffffffffc0205b26:	0119b423          	sd	a7,8(s3)
ffffffffc0205b2a:	00f9b823          	sd	a5,16(s3)
ffffffffc0205b2e:	0138b023          	sd	s3,0(a7)
ffffffffc0205b32:	67e2                	ld	a5,24(sp)
ffffffffc0205b34:	013a3423          	sd	s3,8(s4)
ffffffffc0205b38:	00fa3823          	sd	a5,16(s4)
ffffffffc0205b3c:	0149b023          	sd	s4,0(s3)
ffffffffc0205b40:	89da                	mv	s3,s6
ffffffffc0205b42:	67c2                	ld	a5,16(sp)
ffffffffc0205b44:	014db423          	sd	s4,8(s11)
ffffffffc0205b48:	00fdb823          	sd	a5,16(s11)
ffffffffc0205b4c:	01ba3023          	sd	s11,0(s4)
ffffffffc0205b50:	fccff06f          	j	ffffffffc020531c <stride_dequeue+0x2fe>
ffffffffc0205b54:	008db783          	ld	a5,8(s11)
ffffffffc0205b58:	010db883          	ld	a7,16(s11)
ffffffffc0205b5c:	e82a                	sd	a0,16(sp)
ffffffffc0205b5e:	e43e                	sd	a5,8(sp)
ffffffffc0205b60:	0a088f63          	beqz	a7,ffffffffc0205c1e <stride_dequeue+0xc00>
ffffffffc0205b64:	85b2                	mv	a1,a2
ffffffffc0205b66:	8546                	mv	a0,a7
ffffffffc0205b68:	f032                	sd	a2,32(sp)
ffffffffc0205b6a:	ec46                	sd	a7,24(sp)
ffffffffc0205b6c:	a76ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205b70:	6842                	ld	a6,16(sp)
ffffffffc0205b72:	68e2                	ld	a7,24(sp)
ffffffffc0205b74:	7602                	ld	a2,32(sp)
ffffffffc0205b76:	150506e3          	beq	a0,a6,ffffffffc02064c2 <stride_dequeue+0x14a4>
ffffffffc0205b7a:	661c                	ld	a5,8(a2)
ffffffffc0205b7c:	01063983          	ld	s3,16(a2)
ffffffffc0205b80:	ec42                	sd	a6,24(sp)
ffffffffc0205b82:	e83e                	sd	a5,16(sp)
ffffffffc0205b84:	00099463          	bnez	s3,ffffffffc0205b8c <stride_dequeue+0xb6e>
ffffffffc0205b88:	4660106f          	j	ffffffffc0206fee <stride_dequeue+0x1fd0>
ffffffffc0205b8c:	8546                	mv	a0,a7
ffffffffc0205b8e:	85ce                	mv	a1,s3
ffffffffc0205b90:	f432                	sd	a2,40(sp)
ffffffffc0205b92:	f046                	sd	a7,32(sp)
ffffffffc0205b94:	a4eff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205b98:	6862                	ld	a6,24(sp)
ffffffffc0205b9a:	7882                	ld	a7,32(sp)
ffffffffc0205b9c:	7622                	ld	a2,40(sp)
ffffffffc0205b9e:	01051463          	bne	a0,a6,ffffffffc0205ba6 <stride_dequeue+0xb88>
ffffffffc0205ba2:	0ae0106f          	j	ffffffffc0206c50 <stride_dequeue+0x1c32>
ffffffffc0205ba6:	0089b783          	ld	a5,8(s3)
ffffffffc0205baa:	0109be03          	ld	t3,16(s3)
ffffffffc0205bae:	f042                	sd	a6,32(sp)
ffffffffc0205bb0:	ec3e                	sd	a5,24(sp)
ffffffffc0205bb2:	040e0863          	beqz	t3,ffffffffc0205c02 <stride_dequeue+0xbe4>
ffffffffc0205bb6:	85f2                	mv	a1,t3
ffffffffc0205bb8:	8546                	mv	a0,a7
ffffffffc0205bba:	fc32                	sd	a2,56(sp)
ffffffffc0205bbc:	f872                	sd	t3,48(sp)
ffffffffc0205bbe:	f446                	sd	a7,40(sp)
ffffffffc0205bc0:	a22ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205bc4:	7662                	ld	a2,56(sp)
ffffffffc0205bc6:	7802                	ld	a6,32(sp)
ffffffffc0205bc8:	78a2                	ld	a7,40(sp)
ffffffffc0205bca:	f432                	sd	a2,40(sp)
ffffffffc0205bcc:	7e42                	ld	t3,48(sp)
ffffffffc0205bce:	01051463          	bne	a0,a6,ffffffffc0205bd6 <stride_dequeue+0xbb8>
ffffffffc0205bd2:	6ac0106f          	j	ffffffffc020727e <stride_dequeue+0x2260>
ffffffffc0205bd6:	010e3583          	ld	a1,16(t3)
ffffffffc0205bda:	8546                	mv	a0,a7
ffffffffc0205bdc:	008e3b03          	ld	s6,8(t3)
ffffffffc0205be0:	f072                	sd	t3,32(sp)
ffffffffc0205be2:	a5cff0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0205be6:	7e02                	ld	t3,32(sp)
ffffffffc0205be8:	7622                	ld	a2,40(sp)
ffffffffc0205bea:	016e3823          	sd	s6,16(t3)
ffffffffc0205bee:	00ae3423          	sd	a0,8(t3)
ffffffffc0205bf2:	010c2b03          	lw	s6,16(s8)
ffffffffc0205bf6:	e119                	bnez	a0,ffffffffc0205bfc <stride_dequeue+0xbde>
ffffffffc0205bf8:	1370106f          	j	ffffffffc020752e <stride_dequeue+0x2510>
ffffffffc0205bfc:	01c53023          	sd	t3,0(a0)
ffffffffc0205c00:	88f2                	mv	a7,t3
ffffffffc0205c02:	67e2                	ld	a5,24(sp)
ffffffffc0205c04:	0119b423          	sd	a7,8(s3)
ffffffffc0205c08:	00f9b823          	sd	a5,16(s3)
ffffffffc0205c0c:	0138b023          	sd	s3,0(a7)
ffffffffc0205c10:	67c2                	ld	a5,16(sp)
ffffffffc0205c12:	01363423          	sd	s3,8(a2)
ffffffffc0205c16:	ea1c                	sd	a5,16(a2)
ffffffffc0205c18:	00c9b023          	sd	a2,0(s3)
ffffffffc0205c1c:	89da                	mv	s3,s6
ffffffffc0205c1e:	67a2                	ld	a5,8(sp)
ffffffffc0205c20:	00cdb423          	sd	a2,8(s11)
ffffffffc0205c24:	00fdb823          	sd	a5,16(s11)
ffffffffc0205c28:	01b63023          	sd	s11,0(a2)
ffffffffc0205c2c:	849ff06f          	j	ffffffffc0205474 <stride_dequeue+0x456>
ffffffffc0205c30:	008cb783          	ld	a5,8(s9)
ffffffffc0205c34:	010cb883          	ld	a7,16(s9)
ffffffffc0205c38:	ec2a                	sd	a0,24(sp)
ffffffffc0205c3a:	e83e                	sd	a5,16(sp)
ffffffffc0205c3c:	0a088963          	beqz	a7,ffffffffc0205cee <stride_dequeue+0xcd0>
ffffffffc0205c40:	8546                	mv	a0,a7
ffffffffc0205c42:	85ee                	mv	a1,s11
ffffffffc0205c44:	f046                	sd	a7,32(sp)
ffffffffc0205c46:	99cff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205c4a:	6862                	ld	a6,24(sp)
ffffffffc0205c4c:	7882                	ld	a7,32(sp)
ffffffffc0205c4e:	7d050863          	beq	a0,a6,ffffffffc020641e <stride_dequeue+0x1400>
ffffffffc0205c52:	008db783          	ld	a5,8(s11)
ffffffffc0205c56:	010db983          	ld	s3,16(s11)
ffffffffc0205c5a:	f042                	sd	a6,32(sp)
ffffffffc0205c5c:	ec3e                	sd	a5,24(sp)
ffffffffc0205c5e:	00099463          	bnez	s3,ffffffffc0205c66 <stride_dequeue+0xc48>
ffffffffc0205c62:	3600106f          	j	ffffffffc0206fc2 <stride_dequeue+0x1fa4>
ffffffffc0205c66:	8546                	mv	a0,a7
ffffffffc0205c68:	85ce                	mv	a1,s3
ffffffffc0205c6a:	f446                	sd	a7,40(sp)
ffffffffc0205c6c:	976ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205c70:	7802                	ld	a6,32(sp)
ffffffffc0205c72:	78a2                	ld	a7,40(sp)
ffffffffc0205c74:	01051463          	bne	a0,a6,ffffffffc0205c7c <stride_dequeue+0xc5e>
ffffffffc0205c78:	71d0006f          	j	ffffffffc0206b94 <stride_dequeue+0x1b76>
ffffffffc0205c7c:	0089b783          	ld	a5,8(s3)
ffffffffc0205c80:	0109be03          	ld	t3,16(s3)
ffffffffc0205c84:	f442                	sd	a6,40(sp)
ffffffffc0205c86:	f03e                	sd	a5,32(sp)
ffffffffc0205c88:	040e0463          	beqz	t3,ffffffffc0205cd0 <stride_dequeue+0xcb2>
ffffffffc0205c8c:	85f2                	mv	a1,t3
ffffffffc0205c8e:	8546                	mv	a0,a7
ffffffffc0205c90:	fc72                	sd	t3,56(sp)
ffffffffc0205c92:	f846                	sd	a7,48(sp)
ffffffffc0205c94:	94eff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205c98:	7822                	ld	a6,40(sp)
ffffffffc0205c9a:	78c2                	ld	a7,48(sp)
ffffffffc0205c9c:	7e62                	ld	t3,56(sp)
ffffffffc0205c9e:	01051463          	bne	a0,a6,ffffffffc0205ca6 <stride_dequeue+0xc88>
ffffffffc0205ca2:	60a0106f          	j	ffffffffc02072ac <stride_dequeue+0x228e>
ffffffffc0205ca6:	010e3583          	ld	a1,16(t3)
ffffffffc0205caa:	8546                	mv	a0,a7
ffffffffc0205cac:	008e3b03          	ld	s6,8(t3)
ffffffffc0205cb0:	f472                	sd	t3,40(sp)
ffffffffc0205cb2:	98cff0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0205cb6:	7e22                	ld	t3,40(sp)
ffffffffc0205cb8:	016e3823          	sd	s6,16(t3)
ffffffffc0205cbc:	00ae3423          	sd	a0,8(t3)
ffffffffc0205cc0:	010c2b03          	lw	s6,16(s8)
ffffffffc0205cc4:	e119                	bnez	a0,ffffffffc0205cca <stride_dequeue+0xcac>
ffffffffc0205cc6:	0270106f          	j	ffffffffc02074ec <stride_dequeue+0x24ce>
ffffffffc0205cca:	01c53023          	sd	t3,0(a0)
ffffffffc0205cce:	88f2                	mv	a7,t3
ffffffffc0205cd0:	7782                	ld	a5,32(sp)
ffffffffc0205cd2:	0119b423          	sd	a7,8(s3)
ffffffffc0205cd6:	00f9b823          	sd	a5,16(s3)
ffffffffc0205cda:	0138b023          	sd	s3,0(a7)
ffffffffc0205cde:	67e2                	ld	a5,24(sp)
ffffffffc0205ce0:	013db423          	sd	s3,8(s11)
ffffffffc0205ce4:	00fdb823          	sd	a5,16(s11)
ffffffffc0205ce8:	01b9b023          	sd	s11,0(s3)
ffffffffc0205cec:	89da                	mv	s3,s6
ffffffffc0205cee:	67c2                	ld	a5,16(sp)
ffffffffc0205cf0:	01bcb423          	sd	s11,8(s9)
ffffffffc0205cf4:	00fcb823          	sd	a5,16(s9)
ffffffffc0205cf8:	019db023          	sd	s9,0(s11)
ffffffffc0205cfc:	8de6                	mv	s11,s9
ffffffffc0205cfe:	b9bd                	j	ffffffffc020597c <stride_dequeue+0x95e>
ffffffffc0205d00:	00893783          	ld	a5,8(s2)
ffffffffc0205d04:	01093883          	ld	a7,16(s2)
ffffffffc0205d08:	f02a                	sd	a0,32(sp)
ffffffffc0205d0a:	ec3e                	sd	a5,24(sp)
ffffffffc0205d0c:	06088c63          	beqz	a7,ffffffffc0205d84 <stride_dequeue+0xd66>
ffffffffc0205d10:	85c2                	mv	a1,a6
ffffffffc0205d12:	8546                	mv	a0,a7
ffffffffc0205d14:	f842                	sd	a6,48(sp)
ffffffffc0205d16:	f446                	sd	a7,40(sp)
ffffffffc0205d18:	8caff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205d1c:	7302                	ld	t1,32(sp)
ffffffffc0205d1e:	78a2                	ld	a7,40(sp)
ffffffffc0205d20:	7842                	ld	a6,48(sp)
ffffffffc0205d22:	2e650ee3          	beq	a0,t1,ffffffffc020681e <stride_dequeue+0x1800>
ffffffffc0205d26:	00883783          	ld	a5,8(a6)
ffffffffc0205d2a:	01083983          	ld	s3,16(a6)
ffffffffc0205d2e:	f41a                	sd	t1,40(sp)
ffffffffc0205d30:	f03e                	sd	a5,32(sp)
ffffffffc0205d32:	64098ee3          	beqz	s3,ffffffffc0206b8e <stride_dequeue+0x1b70>
ffffffffc0205d36:	8546                	mv	a0,a7
ffffffffc0205d38:	85ce                	mv	a1,s3
ffffffffc0205d3a:	fc42                	sd	a6,56(sp)
ffffffffc0205d3c:	f846                	sd	a7,48(sp)
ffffffffc0205d3e:	8a4ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205d42:	7322                	ld	t1,40(sp)
ffffffffc0205d44:	78c2                	ld	a7,48(sp)
ffffffffc0205d46:	7862                	ld	a6,56(sp)
ffffffffc0205d48:	00651463          	bne	a0,t1,ffffffffc0205d50 <stride_dequeue+0xd32>
ffffffffc0205d4c:	1e80106f          	j	ffffffffc0206f34 <stride_dequeue+0x1f16>
ffffffffc0205d50:	0109b583          	ld	a1,16(s3)
ffffffffc0205d54:	0089bb03          	ld	s6,8(s3)
ffffffffc0205d58:	8546                	mv	a0,a7
ffffffffc0205d5a:	f442                	sd	a6,40(sp)
ffffffffc0205d5c:	8e2ff0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0205d60:	00a9b423          	sd	a0,8(s3)
ffffffffc0205d64:	0169b823          	sd	s6,16(s3)
ffffffffc0205d68:	7822                	ld	a6,40(sp)
ffffffffc0205d6a:	010c2b03          	lw	s6,16(s8)
ffffffffc0205d6e:	c119                	beqz	a0,ffffffffc0205d74 <stride_dequeue+0xd56>
ffffffffc0205d70:	01353023          	sd	s3,0(a0)
ffffffffc0205d74:	7782                	ld	a5,32(sp)
ffffffffc0205d76:	01383423          	sd	s3,8(a6)
ffffffffc0205d7a:	00f83823          	sd	a5,16(a6)
ffffffffc0205d7e:	0109b023          	sd	a6,0(s3)
ffffffffc0205d82:	89da                	mv	s3,s6
ffffffffc0205d84:	67e2                	ld	a5,24(sp)
ffffffffc0205d86:	01093423          	sd	a6,8(s2)
ffffffffc0205d8a:	00f93823          	sd	a5,16(s2)
ffffffffc0205d8e:	01283023          	sd	s2,0(a6)
ffffffffc0205d92:	bf0ff06f          	j	ffffffffc0205182 <stride_dequeue+0x164>
ffffffffc0205d96:	008cb783          	ld	a5,8(s9)
ffffffffc0205d9a:	010cb983          	ld	s3,16(s9)
ffffffffc0205d9e:	ec2a                	sd	a0,24(sp)
ffffffffc0205da0:	e83e                	sd	a5,16(sp)
ffffffffc0205da2:	0a098763          	beqz	s3,ffffffffc0205e50 <stride_dequeue+0xe32>
ffffffffc0205da6:	85d2                	mv	a1,s4
ffffffffc0205da8:	854e                	mv	a0,s3
ffffffffc0205daa:	838ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205dae:	6862                	ld	a6,24(sp)
ffffffffc0205db0:	3b050fe3          	beq	a0,a6,ffffffffc020696e <stride_dequeue+0x1950>
ffffffffc0205db4:	008a3783          	ld	a5,8(s4)
ffffffffc0205db8:	010a3303          	ld	t1,16(s4)
ffffffffc0205dbc:	f042                	sd	a6,32(sp)
ffffffffc0205dbe:	ec3e                	sd	a5,24(sp)
ffffffffc0205dc0:	08030163          	beqz	t1,ffffffffc0205e42 <stride_dequeue+0xe24>
ffffffffc0205dc4:	859a                	mv	a1,t1
ffffffffc0205dc6:	854e                	mv	a0,s3
ffffffffc0205dc8:	f41a                	sd	t1,40(sp)
ffffffffc0205dca:	818ff0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205dce:	7802                	ld	a6,32(sp)
ffffffffc0205dd0:	7322                	ld	t1,40(sp)
ffffffffc0205dd2:	01051463          	bne	a0,a6,ffffffffc0205dda <stride_dequeue+0xdbc>
ffffffffc0205dd6:	3da0106f          	j	ffffffffc02071b0 <stride_dequeue+0x2192>
ffffffffc0205dda:	00833783          	ld	a5,8(t1)
ffffffffc0205dde:	01033e03          	ld	t3,16(t1)
ffffffffc0205de2:	fc42                	sd	a6,56(sp)
ffffffffc0205de4:	f03e                	sd	a5,32(sp)
ffffffffc0205de6:	040e0663          	beqz	t3,ffffffffc0205e32 <stride_dequeue+0xe14>
ffffffffc0205dea:	85f2                	mv	a1,t3
ffffffffc0205dec:	854e                	mv	a0,s3
ffffffffc0205dee:	f81a                	sd	t1,48(sp)
ffffffffc0205df0:	f472                	sd	t3,40(sp)
ffffffffc0205df2:	ff1fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205df6:	7862                	ld	a6,56(sp)
ffffffffc0205df8:	7e22                	ld	t3,40(sp)
ffffffffc0205dfa:	7342                	ld	t1,48(sp)
ffffffffc0205dfc:	01051463          	bne	a0,a6,ffffffffc0205e04 <stride_dequeue+0xde6>
ffffffffc0205e00:	0c90106f          	j	ffffffffc02076c8 <stride_dequeue+0x26aa>
ffffffffc0205e04:	010e3583          	ld	a1,16(t3)
ffffffffc0205e08:	854e                	mv	a0,s3
ffffffffc0205e0a:	008e3b03          	ld	s6,8(t3)
ffffffffc0205e0e:	f81a                	sd	t1,48(sp)
ffffffffc0205e10:	f472                	sd	t3,40(sp)
ffffffffc0205e12:	82cff0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0205e16:	7e22                	ld	t3,40(sp)
ffffffffc0205e18:	7342                	ld	t1,48(sp)
ffffffffc0205e1a:	016e3823          	sd	s6,16(t3)
ffffffffc0205e1e:	00ae3423          	sd	a0,8(t3)
ffffffffc0205e22:	010c2b03          	lw	s6,16(s8)
ffffffffc0205e26:	e119                	bnez	a0,ffffffffc0205e2c <stride_dequeue+0xe0e>
ffffffffc0205e28:	32d0106f          	j	ffffffffc0207954 <stride_dequeue+0x2936>
ffffffffc0205e2c:	01c53023          	sd	t3,0(a0)
ffffffffc0205e30:	89f2                	mv	s3,t3
ffffffffc0205e32:	7782                	ld	a5,32(sp)
ffffffffc0205e34:	01333423          	sd	s3,8(t1)
ffffffffc0205e38:	00f33823          	sd	a5,16(t1)
ffffffffc0205e3c:	0069b023          	sd	t1,0(s3)
ffffffffc0205e40:	899a                	mv	s3,t1
ffffffffc0205e42:	67e2                	ld	a5,24(sp)
ffffffffc0205e44:	013a3423          	sd	s3,8(s4)
ffffffffc0205e48:	00fa3823          	sd	a5,16(s4)
ffffffffc0205e4c:	0149b023          	sd	s4,0(s3)
ffffffffc0205e50:	67c2                	ld	a5,16(sp)
ffffffffc0205e52:	014cb423          	sd	s4,8(s9)
ffffffffc0205e56:	89da                	mv	s3,s6
ffffffffc0205e58:	00fcb823          	sd	a5,16(s9)
ffffffffc0205e5c:	019a3023          	sd	s9,0(s4)
ffffffffc0205e60:	f42ff06f          	j	ffffffffc02055a2 <stride_dequeue+0x584>
ffffffffc0205e64:	661c                	ld	a5,8(a2)
ffffffffc0205e66:	01063983          	ld	s3,16(a2)
ffffffffc0205e6a:	e82a                	sd	a0,16(sp)
ffffffffc0205e6c:	e43e                	sd	a5,8(sp)
ffffffffc0205e6e:	0a098f63          	beqz	s3,ffffffffc0205f2c <stride_dequeue+0xf0e>
ffffffffc0205e72:	85d2                	mv	a1,s4
ffffffffc0205e74:	854e                	mv	a0,s3
ffffffffc0205e76:	ec32                	sd	a2,24(sp)
ffffffffc0205e78:	f6bfe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205e7c:	6842                	ld	a6,16(sp)
ffffffffc0205e7e:	6662                	ld	a2,24(sp)
ffffffffc0205e80:	39050de3          	beq	a0,a6,ffffffffc0206a1a <stride_dequeue+0x19fc>
ffffffffc0205e84:	008a3783          	ld	a5,8(s4)
ffffffffc0205e88:	010a3303          	ld	t1,16(s4)
ffffffffc0205e8c:	ec42                	sd	a6,24(sp)
ffffffffc0205e8e:	e83e                	sd	a5,16(sp)
ffffffffc0205e90:	08030763          	beqz	t1,ffffffffc0205f1e <stride_dequeue+0xf00>
ffffffffc0205e94:	859a                	mv	a1,t1
ffffffffc0205e96:	854e                	mv	a0,s3
ffffffffc0205e98:	f432                	sd	a2,40(sp)
ffffffffc0205e9a:	f01a                	sd	t1,32(sp)
ffffffffc0205e9c:	f47fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205ea0:	6862                	ld	a6,24(sp)
ffffffffc0205ea2:	7302                	ld	t1,32(sp)
ffffffffc0205ea4:	7622                	ld	a2,40(sp)
ffffffffc0205ea6:	01051463          	bne	a0,a6,ffffffffc0205eae <stride_dequeue+0xe90>
ffffffffc0205eaa:	5060106f          	j	ffffffffc02073b0 <stride_dequeue+0x2392>
ffffffffc0205eae:	00833783          	ld	a5,8(t1)
ffffffffc0205eb2:	01033e03          	ld	t3,16(t1)
ffffffffc0205eb6:	fc42                	sd	a6,56(sp)
ffffffffc0205eb8:	ec3e                	sd	a5,24(sp)
ffffffffc0205eba:	040e0a63          	beqz	t3,ffffffffc0205f0e <stride_dequeue+0xef0>
ffffffffc0205ebe:	85f2                	mv	a1,t3
ffffffffc0205ec0:	854e                	mv	a0,s3
ffffffffc0205ec2:	f81a                	sd	t1,48(sp)
ffffffffc0205ec4:	f432                	sd	a2,40(sp)
ffffffffc0205ec6:	f072                	sd	t3,32(sp)
ffffffffc0205ec8:	f1bfe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205ecc:	7862                	ld	a6,56(sp)
ffffffffc0205ece:	7e02                	ld	t3,32(sp)
ffffffffc0205ed0:	7622                	ld	a2,40(sp)
ffffffffc0205ed2:	7342                	ld	t1,48(sp)
ffffffffc0205ed4:	01051463          	bne	a0,a6,ffffffffc0205edc <stride_dequeue+0xebe>
ffffffffc0205ed8:	1e10106f          	j	ffffffffc02078b8 <stride_dequeue+0x289a>
ffffffffc0205edc:	010e3583          	ld	a1,16(t3)
ffffffffc0205ee0:	854e                	mv	a0,s3
ffffffffc0205ee2:	008e3b03          	ld	s6,8(t3)
ffffffffc0205ee6:	f81a                	sd	t1,48(sp)
ffffffffc0205ee8:	f432                	sd	a2,40(sp)
ffffffffc0205eea:	f072                	sd	t3,32(sp)
ffffffffc0205eec:	f53fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0205ef0:	7e02                	ld	t3,32(sp)
ffffffffc0205ef2:	7622                	ld	a2,40(sp)
ffffffffc0205ef4:	7342                	ld	t1,48(sp)
ffffffffc0205ef6:	016e3823          	sd	s6,16(t3)
ffffffffc0205efa:	00ae3423          	sd	a0,8(t3)
ffffffffc0205efe:	010c2b03          	lw	s6,16(s8)
ffffffffc0205f02:	e119                	bnez	a0,ffffffffc0205f08 <stride_dequeue+0xeea>
ffffffffc0205f04:	22d0106f          	j	ffffffffc0207930 <stride_dequeue+0x2912>
ffffffffc0205f08:	01c53023          	sd	t3,0(a0)
ffffffffc0205f0c:	89f2                	mv	s3,t3
ffffffffc0205f0e:	67e2                	ld	a5,24(sp)
ffffffffc0205f10:	01333423          	sd	s3,8(t1)
ffffffffc0205f14:	00f33823          	sd	a5,16(t1)
ffffffffc0205f18:	0069b023          	sd	t1,0(s3)
ffffffffc0205f1c:	899a                	mv	s3,t1
ffffffffc0205f1e:	67c2                	ld	a5,16(sp)
ffffffffc0205f20:	013a3423          	sd	s3,8(s4)
ffffffffc0205f24:	00fa3823          	sd	a5,16(s4)
ffffffffc0205f28:	0149b023          	sd	s4,0(s3)
ffffffffc0205f2c:	67a2                	ld	a5,8(sp)
ffffffffc0205f2e:	01463423          	sd	s4,8(a2)
ffffffffc0205f32:	89da                	mv	s3,s6
ffffffffc0205f34:	ea1c                	sd	a5,16(a2)
ffffffffc0205f36:	00ca3023          	sd	a2,0(s4)
ffffffffc0205f3a:	8a32                	mv	s4,a2
ffffffffc0205f3c:	f80ff06f          	j	ffffffffc02056bc <stride_dequeue+0x69e>
ffffffffc0205f40:	008a3783          	ld	a5,8(s4)
ffffffffc0205f44:	010a3983          	ld	s3,16(s4)
ffffffffc0205f48:	ec2a                	sd	a0,24(sp)
ffffffffc0205f4a:	e83e                	sd	a5,16(sp)
ffffffffc0205f4c:	0a098763          	beqz	s3,ffffffffc0205ffa <stride_dequeue+0xfdc>
ffffffffc0205f50:	85e6                	mv	a1,s9
ffffffffc0205f52:	854e                	mv	a0,s3
ffffffffc0205f54:	e8ffe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205f58:	6862                	ld	a6,24(sp)
ffffffffc0205f5a:	270505e3          	beq	a0,a6,ffffffffc02069c4 <stride_dequeue+0x19a6>
ffffffffc0205f5e:	008cb783          	ld	a5,8(s9)
ffffffffc0205f62:	010cb303          	ld	t1,16(s9)
ffffffffc0205f66:	f042                	sd	a6,32(sp)
ffffffffc0205f68:	ec3e                	sd	a5,24(sp)
ffffffffc0205f6a:	08030163          	beqz	t1,ffffffffc0205fec <stride_dequeue+0xfce>
ffffffffc0205f6e:	859a                	mv	a1,t1
ffffffffc0205f70:	854e                	mv	a0,s3
ffffffffc0205f72:	f41a                	sd	t1,40(sp)
ffffffffc0205f74:	e6ffe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205f78:	7802                	ld	a6,32(sp)
ffffffffc0205f7a:	7322                	ld	t1,40(sp)
ffffffffc0205f7c:	01051463          	bne	a0,a6,ffffffffc0205f84 <stride_dequeue+0xf66>
ffffffffc0205f80:	4080106f          	j	ffffffffc0207388 <stride_dequeue+0x236a>
ffffffffc0205f84:	00833783          	ld	a5,8(t1)
ffffffffc0205f88:	01033e03          	ld	t3,16(t1)
ffffffffc0205f8c:	fc42                	sd	a6,56(sp)
ffffffffc0205f8e:	f03e                	sd	a5,32(sp)
ffffffffc0205f90:	040e0663          	beqz	t3,ffffffffc0205fdc <stride_dequeue+0xfbe>
ffffffffc0205f94:	85f2                	mv	a1,t3
ffffffffc0205f96:	854e                	mv	a0,s3
ffffffffc0205f98:	f81a                	sd	t1,48(sp)
ffffffffc0205f9a:	f472                	sd	t3,40(sp)
ffffffffc0205f9c:	e47fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0205fa0:	7862                	ld	a6,56(sp)
ffffffffc0205fa2:	7e22                	ld	t3,40(sp)
ffffffffc0205fa4:	7342                	ld	t1,48(sp)
ffffffffc0205fa6:	01051463          	bne	a0,a6,ffffffffc0205fae <stride_dequeue+0xf90>
ffffffffc0205faa:	6160106f          	j	ffffffffc02075c0 <stride_dequeue+0x25a2>
ffffffffc0205fae:	010e3583          	ld	a1,16(t3)
ffffffffc0205fb2:	854e                	mv	a0,s3
ffffffffc0205fb4:	008e3b03          	ld	s6,8(t3)
ffffffffc0205fb8:	f81a                	sd	t1,48(sp)
ffffffffc0205fba:	f472                	sd	t3,40(sp)
ffffffffc0205fbc:	e83fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0205fc0:	7e22                	ld	t3,40(sp)
ffffffffc0205fc2:	7342                	ld	t1,48(sp)
ffffffffc0205fc4:	016e3823          	sd	s6,16(t3)
ffffffffc0205fc8:	00ae3423          	sd	a0,8(t3)
ffffffffc0205fcc:	010c2b03          	lw	s6,16(s8)
ffffffffc0205fd0:	e119                	bnez	a0,ffffffffc0205fd6 <stride_dequeue+0xfb8>
ffffffffc0205fd2:	1b30106f          	j	ffffffffc0207984 <stride_dequeue+0x2966>
ffffffffc0205fd6:	01c53023          	sd	t3,0(a0)
ffffffffc0205fda:	89f2                	mv	s3,t3
ffffffffc0205fdc:	7782                	ld	a5,32(sp)
ffffffffc0205fde:	01333423          	sd	s3,8(t1)
ffffffffc0205fe2:	00f33823          	sd	a5,16(t1)
ffffffffc0205fe6:	0069b023          	sd	t1,0(s3)
ffffffffc0205fea:	899a                	mv	s3,t1
ffffffffc0205fec:	67e2                	ld	a5,24(sp)
ffffffffc0205fee:	013cb423          	sd	s3,8(s9)
ffffffffc0205ff2:	00fcb823          	sd	a5,16(s9)
ffffffffc0205ff6:	0199b023          	sd	s9,0(s3)
ffffffffc0205ffa:	67c2                	ld	a5,16(sp)
ffffffffc0205ffc:	019a3423          	sd	s9,8(s4)
ffffffffc0206000:	89da                	mv	s3,s6
ffffffffc0206002:	00fa3823          	sd	a5,16(s4)
ffffffffc0206006:	014cb023          	sd	s4,0(s9)
ffffffffc020600a:	8cd2                	mv	s9,s4
ffffffffc020600c:	faeff06f          	j	ffffffffc02057ba <stride_dequeue+0x79c>
ffffffffc0206010:	0088b783          	ld	a5,8(a7)
ffffffffc0206014:	0108b983          	ld	s3,16(a7)
ffffffffc0206018:	f02a                	sd	a0,32(sp)
ffffffffc020601a:	ec3e                	sd	a5,24(sp)
ffffffffc020601c:	06098e63          	beqz	s3,ffffffffc0206098 <stride_dequeue+0x107a>
ffffffffc0206020:	85e6                	mv	a1,s9
ffffffffc0206022:	854e                	mv	a0,s3
ffffffffc0206024:	f446                	sd	a7,40(sp)
ffffffffc0206026:	dbdfe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc020602a:	7302                	ld	t1,32(sp)
ffffffffc020602c:	78a2                	ld	a7,40(sp)
ffffffffc020602e:	486503e3          	beq	a0,t1,ffffffffc0206cb4 <stride_dequeue+0x1c96>
ffffffffc0206032:	008cb783          	ld	a5,8(s9)
ffffffffc0206036:	010cbe03          	ld	t3,16(s9)
ffffffffc020603a:	f41a                	sd	t1,40(sp)
ffffffffc020603c:	f03e                	sd	a5,32(sp)
ffffffffc020603e:	040e0663          	beqz	t3,ffffffffc020608a <stride_dequeue+0x106c>
ffffffffc0206042:	85f2                	mv	a1,t3
ffffffffc0206044:	854e                	mv	a0,s3
ffffffffc0206046:	fc46                	sd	a7,56(sp)
ffffffffc0206048:	f872                	sd	t3,48(sp)
ffffffffc020604a:	d99fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc020604e:	7322                	ld	t1,40(sp)
ffffffffc0206050:	7e42                	ld	t3,48(sp)
ffffffffc0206052:	78e2                	ld	a7,56(sp)
ffffffffc0206054:	00651463          	bne	a0,t1,ffffffffc020605c <stride_dequeue+0x103e>
ffffffffc0206058:	3040106f          	j	ffffffffc020735c <stride_dequeue+0x233e>
ffffffffc020605c:	010e3583          	ld	a1,16(t3)
ffffffffc0206060:	854e                	mv	a0,s3
ffffffffc0206062:	008e3b03          	ld	s6,8(t3)
ffffffffc0206066:	f846                	sd	a7,48(sp)
ffffffffc0206068:	f472                	sd	t3,40(sp)
ffffffffc020606a:	dd5fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc020606e:	7e22                	ld	t3,40(sp)
ffffffffc0206070:	78c2                	ld	a7,48(sp)
ffffffffc0206072:	016e3823          	sd	s6,16(t3)
ffffffffc0206076:	00ae3423          	sd	a0,8(t3)
ffffffffc020607a:	010c2b03          	lw	s6,16(s8)
ffffffffc020607e:	e119                	bnez	a0,ffffffffc0206084 <stride_dequeue+0x1066>
ffffffffc0206080:	4540106f          	j	ffffffffc02074d4 <stride_dequeue+0x24b6>
ffffffffc0206084:	01c53023          	sd	t3,0(a0)
ffffffffc0206088:	89f2                	mv	s3,t3
ffffffffc020608a:	7782                	ld	a5,32(sp)
ffffffffc020608c:	013cb423          	sd	s3,8(s9)
ffffffffc0206090:	00fcb823          	sd	a5,16(s9)
ffffffffc0206094:	0199b023          	sd	s9,0(s3)
ffffffffc0206098:	67e2                	ld	a5,24(sp)
ffffffffc020609a:	0198b423          	sd	s9,8(a7)
ffffffffc020609e:	89da                	mv	s3,s6
ffffffffc02060a0:	00f8b823          	sd	a5,16(a7)
ffffffffc02060a4:	011cb023          	sd	a7,0(s9)
ffffffffc02060a8:	8cc6                	mv	s9,a7
ffffffffc02060aa:	fdeff06f          	j	ffffffffc0205888 <stride_dequeue+0x86a>
ffffffffc02060ae:	008cb783          	ld	a5,8(s9)
ffffffffc02060b2:	010cb983          	ld	s3,16(s9)
ffffffffc02060b6:	f02a                	sd	a0,32(sp)
ffffffffc02060b8:	ec3e                	sd	a5,24(sp)
ffffffffc02060ba:	06098e63          	beqz	s3,ffffffffc0206136 <stride_dequeue+0x1118>
ffffffffc02060be:	85c2                	mv	a1,a6
ffffffffc02060c0:	854e                	mv	a0,s3
ffffffffc02060c2:	f442                	sd	a6,40(sp)
ffffffffc02060c4:	d1ffe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02060c8:	7302                	ld	t1,32(sp)
ffffffffc02060ca:	7822                	ld	a6,40(sp)
ffffffffc02060cc:	446506e3          	beq	a0,t1,ffffffffc0206d18 <stride_dequeue+0x1cfa>
ffffffffc02060d0:	00883783          	ld	a5,8(a6)
ffffffffc02060d4:	01083e03          	ld	t3,16(a6)
ffffffffc02060d8:	f41a                	sd	t1,40(sp)
ffffffffc02060da:	f03e                	sd	a5,32(sp)
ffffffffc02060dc:	040e0663          	beqz	t3,ffffffffc0206128 <stride_dequeue+0x110a>
ffffffffc02060e0:	85f2                	mv	a1,t3
ffffffffc02060e2:	854e                	mv	a0,s3
ffffffffc02060e4:	fc42                	sd	a6,56(sp)
ffffffffc02060e6:	f872                	sd	t3,48(sp)
ffffffffc02060e8:	cfbfe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02060ec:	7322                	ld	t1,40(sp)
ffffffffc02060ee:	7e42                	ld	t3,48(sp)
ffffffffc02060f0:	7862                	ld	a6,56(sp)
ffffffffc02060f2:	00651463          	bne	a0,t1,ffffffffc02060fa <stride_dequeue+0x10dc>
ffffffffc02060f6:	20e0106f          	j	ffffffffc0207304 <stride_dequeue+0x22e6>
ffffffffc02060fa:	010e3583          	ld	a1,16(t3)
ffffffffc02060fe:	854e                	mv	a0,s3
ffffffffc0206100:	008e3b03          	ld	s6,8(t3)
ffffffffc0206104:	f842                	sd	a6,48(sp)
ffffffffc0206106:	f472                	sd	t3,40(sp)
ffffffffc0206108:	d37fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc020610c:	7e22                	ld	t3,40(sp)
ffffffffc020610e:	7842                	ld	a6,48(sp)
ffffffffc0206110:	016e3823          	sd	s6,16(t3)
ffffffffc0206114:	00ae3423          	sd	a0,8(t3)
ffffffffc0206118:	010c2b03          	lw	s6,16(s8)
ffffffffc020611c:	e119                	bnez	a0,ffffffffc0206122 <stride_dequeue+0x1104>
ffffffffc020611e:	3c80106f          	j	ffffffffc02074e6 <stride_dequeue+0x24c8>
ffffffffc0206122:	01c53023          	sd	t3,0(a0)
ffffffffc0206126:	89f2                	mv	s3,t3
ffffffffc0206128:	7782                	ld	a5,32(sp)
ffffffffc020612a:	01383423          	sd	s3,8(a6)
ffffffffc020612e:	00f83823          	sd	a5,16(a6)
ffffffffc0206132:	0109b023          	sd	a6,0(s3)
ffffffffc0206136:	67e2                	ld	a5,24(sp)
ffffffffc0206138:	010cb423          	sd	a6,8(s9)
ffffffffc020613c:	89da                	mv	s3,s6
ffffffffc020613e:	00fcb823          	sd	a5,16(s9)
ffffffffc0206142:	01983023          	sd	s9,0(a6)
ffffffffc0206146:	829ff06f          	j	ffffffffc020596e <stride_dequeue+0x950>
ffffffffc020614a:	008db783          	ld	a5,8(s11)
ffffffffc020614e:	010db983          	ld	s3,16(s11)
ffffffffc0206152:	f02a                	sd	a0,32(sp)
ffffffffc0206154:	ec3e                	sd	a5,24(sp)
ffffffffc0206156:	06098e63          	beqz	s3,ffffffffc02061d2 <stride_dequeue+0x11b4>
ffffffffc020615a:	85c2                	mv	a1,a6
ffffffffc020615c:	854e                	mv	a0,s3
ffffffffc020615e:	f442                	sd	a6,40(sp)
ffffffffc0206160:	c83fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206164:	7302                	ld	t1,32(sp)
ffffffffc0206166:	7822                	ld	a6,40(sp)
ffffffffc0206168:	466506e3          	beq	a0,t1,ffffffffc0206dd4 <stride_dequeue+0x1db6>
ffffffffc020616c:	00883783          	ld	a5,8(a6)
ffffffffc0206170:	01083e03          	ld	t3,16(a6)
ffffffffc0206174:	f41a                	sd	t1,40(sp)
ffffffffc0206176:	f03e                	sd	a5,32(sp)
ffffffffc0206178:	040e0663          	beqz	t3,ffffffffc02061c4 <stride_dequeue+0x11a6>
ffffffffc020617c:	85f2                	mv	a1,t3
ffffffffc020617e:	854e                	mv	a0,s3
ffffffffc0206180:	fc42                	sd	a6,56(sp)
ffffffffc0206182:	f872                	sd	t3,48(sp)
ffffffffc0206184:	c5ffe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206188:	7322                	ld	t1,40(sp)
ffffffffc020618a:	7e42                	ld	t3,48(sp)
ffffffffc020618c:	7862                	ld	a6,56(sp)
ffffffffc020618e:	00651463          	bne	a0,t1,ffffffffc0206196 <stride_dequeue+0x1178>
ffffffffc0206192:	7490006f          	j	ffffffffc02070da <stride_dequeue+0x20bc>
ffffffffc0206196:	010e3583          	ld	a1,16(t3)
ffffffffc020619a:	854e                	mv	a0,s3
ffffffffc020619c:	008e3b03          	ld	s6,8(t3)
ffffffffc02061a0:	f842                	sd	a6,48(sp)
ffffffffc02061a2:	f472                	sd	t3,40(sp)
ffffffffc02061a4:	c9bfe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02061a8:	7e22                	ld	t3,40(sp)
ffffffffc02061aa:	7842                	ld	a6,48(sp)
ffffffffc02061ac:	016e3823          	sd	s6,16(t3)
ffffffffc02061b0:	00ae3423          	sd	a0,8(t3)
ffffffffc02061b4:	010c2b03          	lw	s6,16(s8)
ffffffffc02061b8:	e119                	bnez	a0,ffffffffc02061be <stride_dequeue+0x11a0>
ffffffffc02061ba:	3260106f          	j	ffffffffc02074e0 <stride_dequeue+0x24c2>
ffffffffc02061be:	01c53023          	sd	t3,0(a0)
ffffffffc02061c2:	89f2                	mv	s3,t3
ffffffffc02061c4:	7782                	ld	a5,32(sp)
ffffffffc02061c6:	01383423          	sd	s3,8(a6)
ffffffffc02061ca:	00f83823          	sd	a5,16(a6)
ffffffffc02061ce:	0109b023          	sd	a6,0(s3)
ffffffffc02061d2:	67e2                	ld	a5,24(sp)
ffffffffc02061d4:	010db423          	sd	a6,8(s11)
ffffffffc02061d8:	89da                	mv	s3,s6
ffffffffc02061da:	00fdb823          	sd	a5,16(s11)
ffffffffc02061de:	01b83023          	sd	s11,0(a6)
ffffffffc02061e2:	92aff06f          	j	ffffffffc020530c <stride_dequeue+0x2ee>
ffffffffc02061e6:	008db783          	ld	a5,8(s11)
ffffffffc02061ea:	010db983          	ld	s3,16(s11)
ffffffffc02061ee:	ec2a                	sd	a0,24(sp)
ffffffffc02061f0:	e83e                	sd	a5,16(sp)
ffffffffc02061f2:	08098263          	beqz	s3,ffffffffc0206276 <stride_dequeue+0x1258>
ffffffffc02061f6:	85c2                	mv	a1,a6
ffffffffc02061f8:	854e                	mv	a0,s3
ffffffffc02061fa:	f432                	sd	a2,40(sp)
ffffffffc02061fc:	f042                	sd	a6,32(sp)
ffffffffc02061fe:	be5fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206202:	6362                	ld	t1,24(sp)
ffffffffc0206204:	7802                	ld	a6,32(sp)
ffffffffc0206206:	7622                	ld	a2,40(sp)
ffffffffc0206208:	426505e3          	beq	a0,t1,ffffffffc0206e32 <stride_dequeue+0x1e14>
ffffffffc020620c:	00883783          	ld	a5,8(a6)
ffffffffc0206210:	01083e03          	ld	t3,16(a6)
ffffffffc0206214:	f01a                	sd	t1,32(sp)
ffffffffc0206216:	ec3e                	sd	a5,24(sp)
ffffffffc0206218:	040e0863          	beqz	t3,ffffffffc0206268 <stride_dequeue+0x124a>
ffffffffc020621c:	85f2                	mv	a1,t3
ffffffffc020621e:	854e                	mv	a0,s3
ffffffffc0206220:	fc42                	sd	a6,56(sp)
ffffffffc0206222:	f832                	sd	a2,48(sp)
ffffffffc0206224:	f472                	sd	t3,40(sp)
ffffffffc0206226:	bbdfe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc020622a:	7302                	ld	t1,32(sp)
ffffffffc020622c:	7e22                	ld	t3,40(sp)
ffffffffc020622e:	7642                	ld	a2,48(sp)
ffffffffc0206230:	7862                	ld	a6,56(sp)
ffffffffc0206232:	60650fe3          	beq	a0,t1,ffffffffc0207050 <stride_dequeue+0x2032>
ffffffffc0206236:	010e3583          	ld	a1,16(t3)
ffffffffc020623a:	854e                	mv	a0,s3
ffffffffc020623c:	008e3b03          	ld	s6,8(t3)
ffffffffc0206240:	f842                	sd	a6,48(sp)
ffffffffc0206242:	f432                	sd	a2,40(sp)
ffffffffc0206244:	f072                	sd	t3,32(sp)
ffffffffc0206246:	bf9fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc020624a:	7e02                	ld	t3,32(sp)
ffffffffc020624c:	7622                	ld	a2,40(sp)
ffffffffc020624e:	7842                	ld	a6,48(sp)
ffffffffc0206250:	016e3823          	sd	s6,16(t3)
ffffffffc0206254:	00ae3423          	sd	a0,8(t3)
ffffffffc0206258:	010c2b03          	lw	s6,16(s8)
ffffffffc020625c:	e119                	bnez	a0,ffffffffc0206262 <stride_dequeue+0x1244>
ffffffffc020625e:	2d60106f          	j	ffffffffc0207534 <stride_dequeue+0x2516>
ffffffffc0206262:	01c53023          	sd	t3,0(a0)
ffffffffc0206266:	89f2                	mv	s3,t3
ffffffffc0206268:	67e2                	ld	a5,24(sp)
ffffffffc020626a:	01383423          	sd	s3,8(a6)
ffffffffc020626e:	00f83823          	sd	a5,16(a6)
ffffffffc0206272:	0109b023          	sd	a6,0(s3)
ffffffffc0206276:	67c2                	ld	a5,16(sp)
ffffffffc0206278:	010db423          	sd	a6,8(s11)
ffffffffc020627c:	89da                	mv	s3,s6
ffffffffc020627e:	00fdb823          	sd	a5,16(s11)
ffffffffc0206282:	01b83023          	sd	s11,0(a6)
ffffffffc0206286:	9e0ff06f          	j	ffffffffc0205466 <stride_dequeue+0x448>
ffffffffc020628a:	00893703          	ld	a4,8(s2)
ffffffffc020628e:	01093983          	ld	s3,16(s2)
ffffffffc0206292:	f42a                	sd	a0,40(sp)
ffffffffc0206294:	f03a                	sd	a4,32(sp)
ffffffffc0206296:	02098e63          	beqz	s3,ffffffffc02062d2 <stride_dequeue+0x12b4>
ffffffffc020629a:	85be                	mv	a1,a5
ffffffffc020629c:	854e                	mv	a0,s3
ffffffffc020629e:	fc42                	sd	a6,56(sp)
ffffffffc02062a0:	f83e                	sd	a5,48(sp)
ffffffffc02062a2:	b41fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02062a6:	7e22                	ld	t3,40(sp)
ffffffffc02062a8:	77c2                	ld	a5,48(sp)
ffffffffc02062aa:	7862                	ld	a6,56(sp)
ffffffffc02062ac:	43c509e3          	beq	a0,t3,ffffffffc0206ede <stride_dequeue+0x1ec0>
ffffffffc02062b0:	6b8c                	ld	a1,16(a5)
ffffffffc02062b2:	854e                	mv	a0,s3
ffffffffc02062b4:	0087bb03          	ld	s6,8(a5)
ffffffffc02062b8:	f842                	sd	a6,48(sp)
ffffffffc02062ba:	f43e                	sd	a5,40(sp)
ffffffffc02062bc:	b83fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02062c0:	77a2                	ld	a5,40(sp)
ffffffffc02062c2:	7842                	ld	a6,48(sp)
ffffffffc02062c4:	0167b823          	sd	s6,16(a5)
ffffffffc02062c8:	e788                	sd	a0,8(a5)
ffffffffc02062ca:	010c2b03          	lw	s6,16(s8)
ffffffffc02062ce:	c111                	beqz	a0,ffffffffc02062d2 <stride_dequeue+0x12b4>
ffffffffc02062d0:	e11c                	sd	a5,0(a0)
ffffffffc02062d2:	7702                	ld	a4,32(sp)
ffffffffc02062d4:	00f93423          	sd	a5,8(s2)
ffffffffc02062d8:	89da                	mv	s3,s6
ffffffffc02062da:	00e93823          	sd	a4,16(s2)
ffffffffc02062de:	0127b023          	sd	s2,0(a5)
ffffffffc02062e2:	e91fe06f          	j	ffffffffc0205172 <stride_dequeue+0x154>
ffffffffc02062e6:	008a3783          	ld	a5,8(s4)
ffffffffc02062ea:	010a3983          	ld	s3,16(s4)
ffffffffc02062ee:	ec2a                	sd	a0,24(sp)
ffffffffc02062f0:	e83e                	sd	a5,16(sp)
ffffffffc02062f2:	5a098ce3          	beqz	s3,ffffffffc02070aa <stride_dequeue+0x208c>
ffffffffc02062f6:	85a6                	mv	a1,s1
ffffffffc02062f8:	854e                	mv	a0,s3
ffffffffc02062fa:	ae9fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02062fe:	67e2                	ld	a5,24(sp)
ffffffffc0206300:	50f500e3          	beq	a0,a5,ffffffffc0207000 <stride_dequeue+0x1fe2>
ffffffffc0206304:	f43e                	sd	a5,40(sp)
ffffffffc0206306:	649c                	ld	a5,8(s1)
ffffffffc0206308:	0104b883          	ld	a7,16(s1)
ffffffffc020630c:	ec3e                	sd	a5,24(sp)
ffffffffc020630e:	04088263          	beqz	a7,ffffffffc0206352 <stride_dequeue+0x1334>
ffffffffc0206312:	85c6                	mv	a1,a7
ffffffffc0206314:	854e                	mv	a0,s3
ffffffffc0206316:	f046                	sd	a7,32(sp)
ffffffffc0206318:	acbfe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc020631c:	77a2                	ld	a5,40(sp)
ffffffffc020631e:	7882                	ld	a7,32(sp)
ffffffffc0206320:	00f51463          	bne	a0,a5,ffffffffc0206328 <stride_dequeue+0x130a>
ffffffffc0206324:	2160106f          	j	ffffffffc020753a <stride_dequeue+0x251c>
ffffffffc0206328:	0108b583          	ld	a1,16(a7)
ffffffffc020632c:	854e                	mv	a0,s3
ffffffffc020632e:	0088bb03          	ld	s6,8(a7)
ffffffffc0206332:	f046                	sd	a7,32(sp)
ffffffffc0206334:	b0bfe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206338:	7882                	ld	a7,32(sp)
ffffffffc020633a:	0168b823          	sd	s6,16(a7)
ffffffffc020633e:	00a8b423          	sd	a0,8(a7)
ffffffffc0206342:	010c2b03          	lw	s6,16(s8)
ffffffffc0206346:	e119                	bnez	a0,ffffffffc020634c <stride_dequeue+0x132e>
ffffffffc0206348:	56a0106f          	j	ffffffffc02078b2 <stride_dequeue+0x2894>
ffffffffc020634c:	01153023          	sd	a7,0(a0)
ffffffffc0206350:	89c6                	mv	s3,a7
ffffffffc0206352:	67e2                	ld	a5,24(sp)
ffffffffc0206354:	0134b423          	sd	s3,8(s1)
ffffffffc0206358:	e89c                	sd	a5,16(s1)
ffffffffc020635a:	0099b023          	sd	s1,0(s3)
ffffffffc020635e:	89a6                	mv	s3,s1
ffffffffc0206360:	67c2                	ld	a5,16(sp)
ffffffffc0206362:	013a3423          	sd	s3,8(s4)
ffffffffc0206366:	84d2                	mv	s1,s4
ffffffffc0206368:	00fa3823          	sd	a5,16(s4)
ffffffffc020636c:	0149b023          	sd	s4,0(s3)
ffffffffc0206370:	89da                	mv	s3,s6
ffffffffc0206372:	f00ff06f          	j	ffffffffc0205a72 <stride_dequeue+0xa54>
ffffffffc0206376:	0088b783          	ld	a5,8(a7)
ffffffffc020637a:	0108b983          	ld	s3,16(a7)
ffffffffc020637e:	f02a                	sd	a0,32(sp)
ffffffffc0206380:	ec3e                	sd	a5,24(sp)
ffffffffc0206382:	00099463          	bnez	s3,ffffffffc020638a <stride_dequeue+0x136c>
ffffffffc0206386:	0d40106f          	j	ffffffffc020745a <stride_dequeue+0x243c>
ffffffffc020638a:	85d2                	mv	a1,s4
ffffffffc020638c:	854e                	mv	a0,s3
ffffffffc020638e:	f446                	sd	a7,40(sp)
ffffffffc0206390:	a53fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206394:	7302                	ld	t1,32(sp)
ffffffffc0206396:	78a2                	ld	a7,40(sp)
ffffffffc0206398:	00651463          	bne	a0,t1,ffffffffc02063a0 <stride_dequeue+0x1382>
ffffffffc020639c:	06c0106f          	j	ffffffffc0207408 <stride_dequeue+0x23ea>
ffffffffc02063a0:	008a3783          	ld	a5,8(s4)
ffffffffc02063a4:	010a3e03          	ld	t3,16(s4)
ffffffffc02063a8:	fc1a                	sd	t1,56(sp)
ffffffffc02063aa:	f03e                	sd	a5,32(sp)
ffffffffc02063ac:	040e0663          	beqz	t3,ffffffffc02063f8 <stride_dequeue+0x13da>
ffffffffc02063b0:	85f2                	mv	a1,t3
ffffffffc02063b2:	854e                	mv	a0,s3
ffffffffc02063b4:	f846                	sd	a7,48(sp)
ffffffffc02063b6:	f472                	sd	t3,40(sp)
ffffffffc02063b8:	a2bfe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02063bc:	7362                	ld	t1,56(sp)
ffffffffc02063be:	7e22                	ld	t3,40(sp)
ffffffffc02063c0:	78c2                	ld	a7,48(sp)
ffffffffc02063c2:	00651463          	bne	a0,t1,ffffffffc02063ca <stride_dequeue+0x13ac>
ffffffffc02063c6:	32e0106f          	j	ffffffffc02076f4 <stride_dequeue+0x26d6>
ffffffffc02063ca:	010e3583          	ld	a1,16(t3)
ffffffffc02063ce:	854e                	mv	a0,s3
ffffffffc02063d0:	008e3b03          	ld	s6,8(t3)
ffffffffc02063d4:	f846                	sd	a7,48(sp)
ffffffffc02063d6:	f472                	sd	t3,40(sp)
ffffffffc02063d8:	a67fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02063dc:	7e22                	ld	t3,40(sp)
ffffffffc02063de:	78c2                	ld	a7,48(sp)
ffffffffc02063e0:	016e3823          	sd	s6,16(t3)
ffffffffc02063e4:	00ae3423          	sd	a0,8(t3)
ffffffffc02063e8:	010c2b03          	lw	s6,16(s8)
ffffffffc02063ec:	e119                	bnez	a0,ffffffffc02063f2 <stride_dequeue+0x13d4>
ffffffffc02063ee:	58a0106f          	j	ffffffffc0207978 <stride_dequeue+0x295a>
ffffffffc02063f2:	01c53023          	sd	t3,0(a0)
ffffffffc02063f6:	89f2                	mv	s3,t3
ffffffffc02063f8:	7782                	ld	a5,32(sp)
ffffffffc02063fa:	013a3423          	sd	s3,8(s4)
ffffffffc02063fe:	00fa3823          	sd	a5,16(s4)
ffffffffc0206402:	0149b023          	sd	s4,0(s3)
ffffffffc0206406:	89d2                	mv	s3,s4
ffffffffc0206408:	67e2                	ld	a5,24(sp)
ffffffffc020640a:	0138b423          	sd	s3,8(a7)
ffffffffc020640e:	8a46                	mv	s4,a7
ffffffffc0206410:	00f8b823          	sd	a5,16(a7)
ffffffffc0206414:	0119b023          	sd	a7,0(s3)
ffffffffc0206418:	89da                	mv	s3,s6
ffffffffc020641a:	f28ff06f          	j	ffffffffc0205b42 <stride_dequeue+0xb24>
ffffffffc020641e:	0088b783          	ld	a5,8(a7)
ffffffffc0206422:	0108b983          	ld	s3,16(a7)
ffffffffc0206426:	f02a                	sd	a0,32(sp)
ffffffffc0206428:	ec3e                	sd	a5,24(sp)
ffffffffc020642a:	00099463          	bnez	s3,ffffffffc0206432 <stride_dequeue+0x1414>
ffffffffc020642e:	0320106f          	j	ffffffffc0207460 <stride_dequeue+0x2442>
ffffffffc0206432:	85ee                	mv	a1,s11
ffffffffc0206434:	854e                	mv	a0,s3
ffffffffc0206436:	f446                	sd	a7,40(sp)
ffffffffc0206438:	9abfe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc020643c:	7302                	ld	t1,32(sp)
ffffffffc020643e:	78a2                	ld	a7,40(sp)
ffffffffc0206440:	466508e3          	beq	a0,t1,ffffffffc02070b0 <stride_dequeue+0x2092>
ffffffffc0206444:	008db783          	ld	a5,8(s11)
ffffffffc0206448:	010dbe03          	ld	t3,16(s11)
ffffffffc020644c:	fc1a                	sd	t1,56(sp)
ffffffffc020644e:	f03e                	sd	a5,32(sp)
ffffffffc0206450:	040e0663          	beqz	t3,ffffffffc020649c <stride_dequeue+0x147e>
ffffffffc0206454:	85f2                	mv	a1,t3
ffffffffc0206456:	854e                	mv	a0,s3
ffffffffc0206458:	f846                	sd	a7,48(sp)
ffffffffc020645a:	f472                	sd	t3,40(sp)
ffffffffc020645c:	987fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206460:	7362                	ld	t1,56(sp)
ffffffffc0206462:	7e22                	ld	t3,40(sp)
ffffffffc0206464:	78c2                	ld	a7,48(sp)
ffffffffc0206466:	00651463          	bne	a0,t1,ffffffffc020646e <stride_dequeue+0x1450>
ffffffffc020646a:	3120106f          	j	ffffffffc020777c <stride_dequeue+0x275e>
ffffffffc020646e:	010e3583          	ld	a1,16(t3)
ffffffffc0206472:	854e                	mv	a0,s3
ffffffffc0206474:	008e3b03          	ld	s6,8(t3)
ffffffffc0206478:	f846                	sd	a7,48(sp)
ffffffffc020647a:	f472                	sd	t3,40(sp)
ffffffffc020647c:	9c3fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206480:	7e22                	ld	t3,40(sp)
ffffffffc0206482:	78c2                	ld	a7,48(sp)
ffffffffc0206484:	016e3823          	sd	s6,16(t3)
ffffffffc0206488:	00ae3423          	sd	a0,8(t3)
ffffffffc020648c:	010c2b03          	lw	s6,16(s8)
ffffffffc0206490:	e119                	bnez	a0,ffffffffc0206496 <stride_dequeue+0x1478>
ffffffffc0206492:	51c0106f          	j	ffffffffc02079ae <stride_dequeue+0x2990>
ffffffffc0206496:	01c53023          	sd	t3,0(a0)
ffffffffc020649a:	89f2                	mv	s3,t3
ffffffffc020649c:	7782                	ld	a5,32(sp)
ffffffffc020649e:	013db423          	sd	s3,8(s11)
ffffffffc02064a2:	00fdb823          	sd	a5,16(s11)
ffffffffc02064a6:	01b9b023          	sd	s11,0(s3)
ffffffffc02064aa:	89ee                	mv	s3,s11
ffffffffc02064ac:	67e2                	ld	a5,24(sp)
ffffffffc02064ae:	0138b423          	sd	s3,8(a7)
ffffffffc02064b2:	8dc6                	mv	s11,a7
ffffffffc02064b4:	00f8b823          	sd	a5,16(a7)
ffffffffc02064b8:	0119b023          	sd	a7,0(s3)
ffffffffc02064bc:	89da                	mv	s3,s6
ffffffffc02064be:	831ff06f          	j	ffffffffc0205cee <stride_dequeue+0xcd0>
ffffffffc02064c2:	0088b783          	ld	a5,8(a7)
ffffffffc02064c6:	0108b983          	ld	s3,16(a7)
ffffffffc02064ca:	ec2a                	sd	a0,24(sp)
ffffffffc02064cc:	e83e                	sd	a5,16(sp)
ffffffffc02064ce:	00099463          	bnez	s3,ffffffffc02064d6 <stride_dequeue+0x14b8>
ffffffffc02064d2:	7a10006f          	j	ffffffffc0207472 <stride_dequeue+0x2454>
ffffffffc02064d6:	85b2                	mv	a1,a2
ffffffffc02064d8:	854e                	mv	a0,s3
ffffffffc02064da:	f446                	sd	a7,40(sp)
ffffffffc02064dc:	907fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02064e0:	6362                	ld	t1,24(sp)
ffffffffc02064e2:	7602                	ld	a2,32(sp)
ffffffffc02064e4:	78a2                	ld	a7,40(sp)
ffffffffc02064e6:	426500e3          	beq	a0,t1,ffffffffc0207106 <stride_dequeue+0x20e8>
ffffffffc02064ea:	661c                	ld	a5,8(a2)
ffffffffc02064ec:	01063e03          	ld	t3,16(a2)
ffffffffc02064f0:	fc1a                	sd	t1,56(sp)
ffffffffc02064f2:	ec3e                	sd	a5,24(sp)
ffffffffc02064f4:	040e0a63          	beqz	t3,ffffffffc0206548 <stride_dequeue+0x152a>
ffffffffc02064f8:	85f2                	mv	a1,t3
ffffffffc02064fa:	854e                	mv	a0,s3
ffffffffc02064fc:	f846                	sd	a7,48(sp)
ffffffffc02064fe:	f432                	sd	a2,40(sp)
ffffffffc0206500:	f072                	sd	t3,32(sp)
ffffffffc0206502:	8e1fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206506:	7362                	ld	t1,56(sp)
ffffffffc0206508:	7e02                	ld	t3,32(sp)
ffffffffc020650a:	7622                	ld	a2,40(sp)
ffffffffc020650c:	78c2                	ld	a7,48(sp)
ffffffffc020650e:	00651463          	bne	a0,t1,ffffffffc0206516 <stride_dequeue+0x14f8>
ffffffffc0206512:	20e0106f          	j	ffffffffc0207720 <stride_dequeue+0x2702>
ffffffffc0206516:	010e3583          	ld	a1,16(t3)
ffffffffc020651a:	854e                	mv	a0,s3
ffffffffc020651c:	008e3b03          	ld	s6,8(t3)
ffffffffc0206520:	f846                	sd	a7,48(sp)
ffffffffc0206522:	f432                	sd	a2,40(sp)
ffffffffc0206524:	f072                	sd	t3,32(sp)
ffffffffc0206526:	919fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc020652a:	7e02                	ld	t3,32(sp)
ffffffffc020652c:	7622                	ld	a2,40(sp)
ffffffffc020652e:	78c2                	ld	a7,48(sp)
ffffffffc0206530:	016e3823          	sd	s6,16(t3)
ffffffffc0206534:	00ae3423          	sd	a0,8(t3)
ffffffffc0206538:	010c2b03          	lw	s6,16(s8)
ffffffffc020653c:	e119                	bnez	a0,ffffffffc0206542 <stride_dequeue+0x1524>
ffffffffc020653e:	4400106f          	j	ffffffffc020797e <stride_dequeue+0x2960>
ffffffffc0206542:	01c53023          	sd	t3,0(a0)
ffffffffc0206546:	89f2                	mv	s3,t3
ffffffffc0206548:	67e2                	ld	a5,24(sp)
ffffffffc020654a:	01363423          	sd	s3,8(a2)
ffffffffc020654e:	ea1c                	sd	a5,16(a2)
ffffffffc0206550:	00c9b023          	sd	a2,0(s3)
ffffffffc0206554:	89b2                	mv	s3,a2
ffffffffc0206556:	67c2                	ld	a5,16(sp)
ffffffffc0206558:	0138b423          	sd	s3,8(a7)
ffffffffc020655c:	8646                	mv	a2,a7
ffffffffc020655e:	00f8b823          	sd	a5,16(a7)
ffffffffc0206562:	0119b023          	sd	a7,0(s3)
ffffffffc0206566:	89da                	mv	s3,s6
ffffffffc0206568:	eb6ff06f          	j	ffffffffc0205c1e <stride_dequeue+0xc00>
ffffffffc020656c:	008cb783          	ld	a5,8(s9)
ffffffffc0206570:	010cb983          	ld	s3,16(s9)
ffffffffc0206574:	f02a                	sd	a0,32(sp)
ffffffffc0206576:	ec3e                	sd	a5,24(sp)
ffffffffc0206578:	00099463          	bnez	s3,ffffffffc0206580 <stride_dequeue+0x1562>
ffffffffc020657c:	6eb0006f          	j	ffffffffc0207466 <stride_dequeue+0x2448>
ffffffffc0206580:	85c2                	mv	a1,a6
ffffffffc0206582:	854e                	mv	a0,s3
ffffffffc0206584:	f442                	sd	a6,40(sp)
ffffffffc0206586:	85dfe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc020658a:	7302                	ld	t1,32(sp)
ffffffffc020658c:	7822                	ld	a6,40(sp)
ffffffffc020658e:	3e650ee3          	beq	a0,t1,ffffffffc020718a <stride_dequeue+0x216c>
ffffffffc0206592:	00883783          	ld	a5,8(a6)
ffffffffc0206596:	01083e03          	ld	t3,16(a6)
ffffffffc020659a:	fc1a                	sd	t1,56(sp)
ffffffffc020659c:	f03e                	sd	a5,32(sp)
ffffffffc020659e:	040e0663          	beqz	t3,ffffffffc02065ea <stride_dequeue+0x15cc>
ffffffffc02065a2:	85f2                	mv	a1,t3
ffffffffc02065a4:	854e                	mv	a0,s3
ffffffffc02065a6:	f842                	sd	a6,48(sp)
ffffffffc02065a8:	f472                	sd	t3,40(sp)
ffffffffc02065aa:	839fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02065ae:	7362                	ld	t1,56(sp)
ffffffffc02065b0:	7e22                	ld	t3,40(sp)
ffffffffc02065b2:	7842                	ld	a6,48(sp)
ffffffffc02065b4:	00651463          	bne	a0,t1,ffffffffc02065bc <stride_dequeue+0x159e>
ffffffffc02065b8:	2a20106f          	j	ffffffffc020785a <stride_dequeue+0x283c>
ffffffffc02065bc:	010e3583          	ld	a1,16(t3)
ffffffffc02065c0:	854e                	mv	a0,s3
ffffffffc02065c2:	008e3b03          	ld	s6,8(t3)
ffffffffc02065c6:	f842                	sd	a6,48(sp)
ffffffffc02065c8:	f472                	sd	t3,40(sp)
ffffffffc02065ca:	875fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02065ce:	7e22                	ld	t3,40(sp)
ffffffffc02065d0:	7842                	ld	a6,48(sp)
ffffffffc02065d2:	016e3823          	sd	s6,16(t3)
ffffffffc02065d6:	00ae3423          	sd	a0,8(t3)
ffffffffc02065da:	010c2b03          	lw	s6,16(s8)
ffffffffc02065de:	e119                	bnez	a0,ffffffffc02065e4 <stride_dequeue+0x15c6>
ffffffffc02065e0:	35c0106f          	j	ffffffffc020793c <stride_dequeue+0x291e>
ffffffffc02065e4:	01c53023          	sd	t3,0(a0)
ffffffffc02065e8:	89f2                	mv	s3,t3
ffffffffc02065ea:	7782                	ld	a5,32(sp)
ffffffffc02065ec:	01383423          	sd	s3,8(a6)
ffffffffc02065f0:	00f83823          	sd	a5,16(a6)
ffffffffc02065f4:	0109b023          	sd	a6,0(s3)
ffffffffc02065f8:	89c2                	mv	s3,a6
ffffffffc02065fa:	67e2                	ld	a5,24(sp)
ffffffffc02065fc:	013cb423          	sd	s3,8(s9)
ffffffffc0206600:	00fcb823          	sd	a5,16(s9)
ffffffffc0206604:	0199b023          	sd	s9,0(s3)
ffffffffc0206608:	89da                	mv	s3,s6
ffffffffc020660a:	f89fe06f          	j	ffffffffc0205592 <stride_dequeue+0x574>
ffffffffc020660e:	661c                	ld	a5,8(a2)
ffffffffc0206610:	01063983          	ld	s3,16(a2)
ffffffffc0206614:	ec2a                	sd	a0,24(sp)
ffffffffc0206616:	e83e                	sd	a5,16(sp)
ffffffffc0206618:	64098ae3          	beqz	s3,ffffffffc020746c <stride_dequeue+0x244e>
ffffffffc020661c:	85c2                	mv	a1,a6
ffffffffc020661e:	854e                	mv	a0,s3
ffffffffc0206620:	f432                	sd	a2,40(sp)
ffffffffc0206622:	f042                	sd	a6,32(sp)
ffffffffc0206624:	fbefe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206628:	6362                	ld	t1,24(sp)
ffffffffc020662a:	7802                	ld	a6,32(sp)
ffffffffc020662c:	7622                	ld	a2,40(sp)
ffffffffc020662e:	326509e3          	beq	a0,t1,ffffffffc0207160 <stride_dequeue+0x2142>
ffffffffc0206632:	00883783          	ld	a5,8(a6)
ffffffffc0206636:	01083e03          	ld	t3,16(a6)
ffffffffc020663a:	fc1a                	sd	t1,56(sp)
ffffffffc020663c:	ec3e                	sd	a5,24(sp)
ffffffffc020663e:	040e0a63          	beqz	t3,ffffffffc0206692 <stride_dequeue+0x1674>
ffffffffc0206642:	85f2                	mv	a1,t3
ffffffffc0206644:	854e                	mv	a0,s3
ffffffffc0206646:	f842                	sd	a6,48(sp)
ffffffffc0206648:	f432                	sd	a2,40(sp)
ffffffffc020664a:	f072                	sd	t3,32(sp)
ffffffffc020664c:	f96fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206650:	7362                	ld	t1,56(sp)
ffffffffc0206652:	7e02                	ld	t3,32(sp)
ffffffffc0206654:	7622                	ld	a2,40(sp)
ffffffffc0206656:	7842                	ld	a6,48(sp)
ffffffffc0206658:	00651463          	bne	a0,t1,ffffffffc0206660 <stride_dequeue+0x1642>
ffffffffc020665c:	1760106f          	j	ffffffffc02077d2 <stride_dequeue+0x27b4>
ffffffffc0206660:	010e3583          	ld	a1,16(t3)
ffffffffc0206664:	854e                	mv	a0,s3
ffffffffc0206666:	008e3b03          	ld	s6,8(t3)
ffffffffc020666a:	f842                	sd	a6,48(sp)
ffffffffc020666c:	f432                	sd	a2,40(sp)
ffffffffc020666e:	f072                	sd	t3,32(sp)
ffffffffc0206670:	fcefe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206674:	7e02                	ld	t3,32(sp)
ffffffffc0206676:	7622                	ld	a2,40(sp)
ffffffffc0206678:	7842                	ld	a6,48(sp)
ffffffffc020667a:	016e3823          	sd	s6,16(t3)
ffffffffc020667e:	00ae3423          	sd	a0,8(t3)
ffffffffc0206682:	010c2b03          	lw	s6,16(s8)
ffffffffc0206686:	e119                	bnez	a0,ffffffffc020668c <stride_dequeue+0x166e>
ffffffffc0206688:	32c0106f          	j	ffffffffc02079b4 <stride_dequeue+0x2996>
ffffffffc020668c:	01c53023          	sd	t3,0(a0)
ffffffffc0206690:	89f2                	mv	s3,t3
ffffffffc0206692:	67e2                	ld	a5,24(sp)
ffffffffc0206694:	01383423          	sd	s3,8(a6)
ffffffffc0206698:	00f83823          	sd	a5,16(a6)
ffffffffc020669c:	0109b023          	sd	a6,0(s3)
ffffffffc02066a0:	89c2                	mv	s3,a6
ffffffffc02066a2:	67c2                	ld	a5,16(sp)
ffffffffc02066a4:	01363423          	sd	s3,8(a2)
ffffffffc02066a8:	ea1c                	sd	a5,16(a2)
ffffffffc02066aa:	00c9b023          	sd	a2,0(s3)
ffffffffc02066ae:	89da                	mv	s3,s6
ffffffffc02066b0:	ffffe06f          	j	ffffffffc02056ae <stride_dequeue+0x690>
ffffffffc02066b4:	008a3783          	ld	a5,8(s4)
ffffffffc02066b8:	010a3983          	ld	s3,16(s4)
ffffffffc02066bc:	f02a                	sd	a0,32(sp)
ffffffffc02066be:	ec3e                	sd	a5,24(sp)
ffffffffc02066c0:	5a098ce3          	beqz	s3,ffffffffc0207478 <stride_dequeue+0x245a>
ffffffffc02066c4:	85c2                	mv	a1,a6
ffffffffc02066c6:	854e                	mv	a0,s3
ffffffffc02066c8:	f442                	sd	a6,40(sp)
ffffffffc02066ca:	f18fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02066ce:	7302                	ld	t1,32(sp)
ffffffffc02066d0:	7822                	ld	a6,40(sp)
ffffffffc02066d2:	566501e3          	beq	a0,t1,ffffffffc0207434 <stride_dequeue+0x2416>
ffffffffc02066d6:	00883783          	ld	a5,8(a6)
ffffffffc02066da:	01083e03          	ld	t3,16(a6)
ffffffffc02066de:	fc1a                	sd	t1,56(sp)
ffffffffc02066e0:	f03e                	sd	a5,32(sp)
ffffffffc02066e2:	040e0663          	beqz	t3,ffffffffc020672e <stride_dequeue+0x1710>
ffffffffc02066e6:	85f2                	mv	a1,t3
ffffffffc02066e8:	854e                	mv	a0,s3
ffffffffc02066ea:	f842                	sd	a6,48(sp)
ffffffffc02066ec:	f472                	sd	t3,40(sp)
ffffffffc02066ee:	ef4fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02066f2:	7362                	ld	t1,56(sp)
ffffffffc02066f4:	7e22                	ld	t3,40(sp)
ffffffffc02066f6:	7842                	ld	a6,48(sp)
ffffffffc02066f8:	00651463          	bne	a0,t1,ffffffffc0206700 <stride_dequeue+0x16e2>
ffffffffc02066fc:	18a0106f          	j	ffffffffc0207886 <stride_dequeue+0x2868>
ffffffffc0206700:	010e3583          	ld	a1,16(t3)
ffffffffc0206704:	854e                	mv	a0,s3
ffffffffc0206706:	008e3b03          	ld	s6,8(t3)
ffffffffc020670a:	f842                	sd	a6,48(sp)
ffffffffc020670c:	f472                	sd	t3,40(sp)
ffffffffc020670e:	f30fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206712:	7e22                	ld	t3,40(sp)
ffffffffc0206714:	7842                	ld	a6,48(sp)
ffffffffc0206716:	016e3823          	sd	s6,16(t3)
ffffffffc020671a:	00ae3423          	sd	a0,8(t3)
ffffffffc020671e:	010c2b03          	lw	s6,16(s8)
ffffffffc0206722:	e119                	bnez	a0,ffffffffc0206728 <stride_dequeue+0x170a>
ffffffffc0206724:	1ee0106f          	j	ffffffffc0207912 <stride_dequeue+0x28f4>
ffffffffc0206728:	01c53023          	sd	t3,0(a0)
ffffffffc020672c:	89f2                	mv	s3,t3
ffffffffc020672e:	7782                	ld	a5,32(sp)
ffffffffc0206730:	01383423          	sd	s3,8(a6)
ffffffffc0206734:	00f83823          	sd	a5,16(a6)
ffffffffc0206738:	0109b023          	sd	a6,0(s3)
ffffffffc020673c:	89c2                	mv	s3,a6
ffffffffc020673e:	67e2                	ld	a5,24(sp)
ffffffffc0206740:	013a3423          	sd	s3,8(s4)
ffffffffc0206744:	00fa3823          	sd	a5,16(s4)
ffffffffc0206748:	0149b023          	sd	s4,0(s3)
ffffffffc020674c:	89da                	mv	s3,s6
ffffffffc020674e:	85eff06f          	j	ffffffffc02057ac <stride_dequeue+0x78e>
ffffffffc0206752:	008cb783          	ld	a5,8(s9)
ffffffffc0206756:	010cb983          	ld	s3,16(s9)
ffffffffc020675a:	f42a                	sd	a0,40(sp)
ffffffffc020675c:	f03e                	sd	a5,32(sp)
ffffffffc020675e:	04098163          	beqz	s3,ffffffffc02067a0 <stride_dequeue+0x1782>
ffffffffc0206762:	859a                	mv	a1,t1
ffffffffc0206764:	854e                	mv	a0,s3
ffffffffc0206766:	fc42                	sd	a6,56(sp)
ffffffffc0206768:	f81a                	sd	t1,48(sp)
ffffffffc020676a:	e78fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc020676e:	7e22                	ld	t3,40(sp)
ffffffffc0206770:	7342                	ld	t1,48(sp)
ffffffffc0206772:	7862                	ld	a6,56(sp)
ffffffffc0206774:	11c505e3          	beq	a0,t3,ffffffffc020707e <stride_dequeue+0x2060>
ffffffffc0206778:	01033583          	ld	a1,16(t1)
ffffffffc020677c:	854e                	mv	a0,s3
ffffffffc020677e:	00833b03          	ld	s6,8(t1)
ffffffffc0206782:	f842                	sd	a6,48(sp)
ffffffffc0206784:	f41a                	sd	t1,40(sp)
ffffffffc0206786:	eb8fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc020678a:	7322                	ld	t1,40(sp)
ffffffffc020678c:	7842                	ld	a6,48(sp)
ffffffffc020678e:	01633823          	sd	s6,16(t1)
ffffffffc0206792:	00a33423          	sd	a0,8(t1)
ffffffffc0206796:	010c2b03          	lw	s6,16(s8)
ffffffffc020679a:	c119                	beqz	a0,ffffffffc02067a0 <stride_dequeue+0x1782>
ffffffffc020679c:	00653023          	sd	t1,0(a0)
ffffffffc02067a0:	7782                	ld	a5,32(sp)
ffffffffc02067a2:	006cb423          	sd	t1,8(s9)
ffffffffc02067a6:	89da                	mv	s3,s6
ffffffffc02067a8:	00fcb823          	sd	a5,16(s9)
ffffffffc02067ac:	01933023          	sd	s9,0(t1)
ffffffffc02067b0:	9aeff06f          	j	ffffffffc020595e <stride_dequeue+0x940>
ffffffffc02067b4:	008db783          	ld	a5,8(s11)
ffffffffc02067b8:	010db983          	ld	s3,16(s11)
ffffffffc02067bc:	f02a                	sd	a0,32(sp)
ffffffffc02067be:	ec3e                	sd	a5,24(sp)
ffffffffc02067c0:	04098563          	beqz	s3,ffffffffc020680a <stride_dequeue+0x17ec>
ffffffffc02067c4:	859a                	mv	a1,t1
ffffffffc02067c6:	854e                	mv	a0,s3
ffffffffc02067c8:	fc42                	sd	a6,56(sp)
ffffffffc02067ca:	f832                	sd	a2,48(sp)
ffffffffc02067cc:	f41a                	sd	t1,40(sp)
ffffffffc02067ce:	e14fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02067d2:	7e02                	ld	t3,32(sp)
ffffffffc02067d4:	7322                	ld	t1,40(sp)
ffffffffc02067d6:	7642                	ld	a2,48(sp)
ffffffffc02067d8:	7862                	ld	a6,56(sp)
ffffffffc02067da:	15c50be3          	beq	a0,t3,ffffffffc0207130 <stride_dequeue+0x2112>
ffffffffc02067de:	01033583          	ld	a1,16(t1)
ffffffffc02067e2:	854e                	mv	a0,s3
ffffffffc02067e4:	00833b03          	ld	s6,8(t1)
ffffffffc02067e8:	f842                	sd	a6,48(sp)
ffffffffc02067ea:	f432                	sd	a2,40(sp)
ffffffffc02067ec:	f01a                	sd	t1,32(sp)
ffffffffc02067ee:	e50fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02067f2:	7302                	ld	t1,32(sp)
ffffffffc02067f4:	7622                	ld	a2,40(sp)
ffffffffc02067f6:	7842                	ld	a6,48(sp)
ffffffffc02067f8:	01633823          	sd	s6,16(t1)
ffffffffc02067fc:	00a33423          	sd	a0,8(t1)
ffffffffc0206800:	010c2b03          	lw	s6,16(s8)
ffffffffc0206804:	c119                	beqz	a0,ffffffffc020680a <stride_dequeue+0x17ec>
ffffffffc0206806:	00653023          	sd	t1,0(a0)
ffffffffc020680a:	67e2                	ld	a5,24(sp)
ffffffffc020680c:	006db423          	sd	t1,8(s11)
ffffffffc0206810:	89da                	mv	s3,s6
ffffffffc0206812:	00fdb823          	sd	a5,16(s11)
ffffffffc0206816:	01b33023          	sd	s11,0(t1)
ffffffffc020681a:	c3dfe06f          	j	ffffffffc0205456 <stride_dequeue+0x438>
ffffffffc020681e:	0088b783          	ld	a5,8(a7)
ffffffffc0206822:	0108b983          	ld	s3,16(a7)
ffffffffc0206826:	f42a                	sd	a0,40(sp)
ffffffffc0206828:	f03e                	sd	a5,32(sp)
ffffffffc020682a:	04098063          	beqz	s3,ffffffffc020686a <stride_dequeue+0x184c>
ffffffffc020682e:	85c2                	mv	a1,a6
ffffffffc0206830:	854e                	mv	a0,s3
ffffffffc0206832:	fc46                	sd	a7,56(sp)
ffffffffc0206834:	daefe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206838:	7e22                	ld	t3,40(sp)
ffffffffc020683a:	7842                	ld	a6,48(sp)
ffffffffc020683c:	78e2                	ld	a7,56(sp)
ffffffffc020683e:	29c50de3          	beq	a0,t3,ffffffffc02072d8 <stride_dequeue+0x22ba>
ffffffffc0206842:	01083583          	ld	a1,16(a6)
ffffffffc0206846:	854e                	mv	a0,s3
ffffffffc0206848:	00883b03          	ld	s6,8(a6)
ffffffffc020684c:	f846                	sd	a7,48(sp)
ffffffffc020684e:	f442                	sd	a6,40(sp)
ffffffffc0206850:	deefe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206854:	7822                	ld	a6,40(sp)
ffffffffc0206856:	78c2                	ld	a7,48(sp)
ffffffffc0206858:	01683823          	sd	s6,16(a6)
ffffffffc020685c:	00a83423          	sd	a0,8(a6)
ffffffffc0206860:	010c2b03          	lw	s6,16(s8)
ffffffffc0206864:	c119                	beqz	a0,ffffffffc020686a <stride_dequeue+0x184c>
ffffffffc0206866:	01053023          	sd	a6,0(a0)
ffffffffc020686a:	7782                	ld	a5,32(sp)
ffffffffc020686c:	0108b423          	sd	a6,8(a7)
ffffffffc0206870:	89da                	mv	s3,s6
ffffffffc0206872:	00f8b823          	sd	a5,16(a7)
ffffffffc0206876:	01183023          	sd	a7,0(a6)
ffffffffc020687a:	8846                	mv	a6,a7
ffffffffc020687c:	d08ff06f          	j	ffffffffc0205d84 <stride_dequeue+0xd66>
ffffffffc0206880:	008db783          	ld	a5,8(s11)
ffffffffc0206884:	010db983          	ld	s3,16(s11)
ffffffffc0206888:	f42a                	sd	a0,40(sp)
ffffffffc020688a:	f03e                	sd	a5,32(sp)
ffffffffc020688c:	04098163          	beqz	s3,ffffffffc02068ce <stride_dequeue+0x18b0>
ffffffffc0206890:	859a                	mv	a1,t1
ffffffffc0206892:	854e                	mv	a0,s3
ffffffffc0206894:	fc42                	sd	a6,56(sp)
ffffffffc0206896:	f81a                	sd	t1,48(sp)
ffffffffc0206898:	d4afe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc020689c:	7e22                	ld	t3,40(sp)
ffffffffc020689e:	7342                	ld	t1,48(sp)
ffffffffc02068a0:	7862                	ld	a6,56(sp)
ffffffffc02068a2:	29c507e3          	beq	a0,t3,ffffffffc0207330 <stride_dequeue+0x2312>
ffffffffc02068a6:	01033583          	ld	a1,16(t1)
ffffffffc02068aa:	854e                	mv	a0,s3
ffffffffc02068ac:	00833b03          	ld	s6,8(t1)
ffffffffc02068b0:	f842                	sd	a6,48(sp)
ffffffffc02068b2:	f41a                	sd	t1,40(sp)
ffffffffc02068b4:	d8afe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02068b8:	7322                	ld	t1,40(sp)
ffffffffc02068ba:	7842                	ld	a6,48(sp)
ffffffffc02068bc:	01633823          	sd	s6,16(t1)
ffffffffc02068c0:	00a33423          	sd	a0,8(t1)
ffffffffc02068c4:	010c2b03          	lw	s6,16(s8)
ffffffffc02068c8:	c119                	beqz	a0,ffffffffc02068ce <stride_dequeue+0x18b0>
ffffffffc02068ca:	00653023          	sd	t1,0(a0)
ffffffffc02068ce:	7782                	ld	a5,32(sp)
ffffffffc02068d0:	006db423          	sd	t1,8(s11)
ffffffffc02068d4:	89da                	mv	s3,s6
ffffffffc02068d6:	00fdb823          	sd	a5,16(s11)
ffffffffc02068da:	01b33023          	sd	s11,0(t1)
ffffffffc02068de:	a1ffe06f          	j	ffffffffc02052fc <stride_dequeue+0x2de>
ffffffffc02068e2:	0088b783          	ld	a5,8(a7)
ffffffffc02068e6:	0108b983          	ld	s3,16(a7)
ffffffffc02068ea:	f42a                	sd	a0,40(sp)
ffffffffc02068ec:	f03e                	sd	a5,32(sp)
ffffffffc02068ee:	04098063          	beqz	s3,ffffffffc020692e <stride_dequeue+0x1910>
ffffffffc02068f2:	859a                	mv	a1,t1
ffffffffc02068f4:	854e                	mv	a0,s3
ffffffffc02068f6:	fc46                	sd	a7,56(sp)
ffffffffc02068f8:	ceafe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02068fc:	7e22                	ld	t3,40(sp)
ffffffffc02068fe:	7342                	ld	t1,48(sp)
ffffffffc0206900:	78e2                	ld	a7,56(sp)
ffffffffc0206902:	73c50263          	beq	a0,t3,ffffffffc0207026 <stride_dequeue+0x2008>
ffffffffc0206906:	01033583          	ld	a1,16(t1)
ffffffffc020690a:	854e                	mv	a0,s3
ffffffffc020690c:	00833b03          	ld	s6,8(t1)
ffffffffc0206910:	f846                	sd	a7,48(sp)
ffffffffc0206912:	f41a                	sd	t1,40(sp)
ffffffffc0206914:	d2afe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206918:	7322                	ld	t1,40(sp)
ffffffffc020691a:	78c2                	ld	a7,48(sp)
ffffffffc020691c:	01633823          	sd	s6,16(t1)
ffffffffc0206920:	00a33423          	sd	a0,8(t1)
ffffffffc0206924:	010c2b03          	lw	s6,16(s8)
ffffffffc0206928:	c119                	beqz	a0,ffffffffc020692e <stride_dequeue+0x1910>
ffffffffc020692a:	00653023          	sd	t1,0(a0)
ffffffffc020692e:	7782                	ld	a5,32(sp)
ffffffffc0206930:	0068b423          	sd	t1,8(a7)
ffffffffc0206934:	89da                	mv	s3,s6
ffffffffc0206936:	00f8b823          	sd	a5,16(a7)
ffffffffc020693a:	01133023          	sd	a7,0(t1)
ffffffffc020693e:	f3dfe06f          	j	ffffffffc020587a <stride_dequeue+0x85c>
ffffffffc0206942:	01093503          	ld	a0,16(s2)
ffffffffc0206946:	00893983          	ld	s3,8(s2)
ffffffffc020694a:	85da                	mv	a1,s6
ffffffffc020694c:	cf2fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206950:	00a93423          	sd	a0,8(s2)
ffffffffc0206954:	01393823          	sd	s3,16(s2)
ffffffffc0206958:	7822                	ld	a6,40(sp)
ffffffffc020695a:	77c2                	ld	a5,48(sp)
ffffffffc020695c:	010c2983          	lw	s3,16(s8)
ffffffffc0206960:	e119                	bnez	a0,ffffffffc0206966 <stride_dequeue+0x1948>
ffffffffc0206962:	803fe06f          	j	ffffffffc0205164 <stride_dequeue+0x146>
ffffffffc0206966:	01253023          	sd	s2,0(a0)
ffffffffc020696a:	ffafe06f          	j	ffffffffc0205164 <stride_dequeue+0x146>
ffffffffc020696e:	0089b783          	ld	a5,8(s3)
ffffffffc0206972:	0109b803          	ld	a6,16(s3)
ffffffffc0206976:	f42a                	sd	a0,40(sp)
ffffffffc0206978:	ec3e                	sd	a5,24(sp)
ffffffffc020697a:	02080b63          	beqz	a6,ffffffffc02069b0 <stride_dequeue+0x1992>
ffffffffc020697e:	8542                	mv	a0,a6
ffffffffc0206980:	85d2                	mv	a1,s4
ffffffffc0206982:	f042                	sd	a6,32(sp)
ffffffffc0206984:	c5efe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206988:	77a2                	ld	a5,40(sp)
ffffffffc020698a:	7802                	ld	a6,32(sp)
ffffffffc020698c:	3cf50be3          	beq	a0,a5,ffffffffc0207562 <stride_dequeue+0x2544>
ffffffffc0206990:	010a3583          	ld	a1,16(s4)
ffffffffc0206994:	008a3b03          	ld	s6,8(s4)
ffffffffc0206998:	8542                	mv	a0,a6
ffffffffc020699a:	ca4fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc020699e:	00aa3423          	sd	a0,8(s4)
ffffffffc02069a2:	016a3823          	sd	s6,16(s4)
ffffffffc02069a6:	010c2b03          	lw	s6,16(s8)
ffffffffc02069aa:	c119                	beqz	a0,ffffffffc02069b0 <stride_dequeue+0x1992>
ffffffffc02069ac:	01453023          	sd	s4,0(a0)
ffffffffc02069b0:	67e2                	ld	a5,24(sp)
ffffffffc02069b2:	0149b423          	sd	s4,8(s3)
ffffffffc02069b6:	00f9b823          	sd	a5,16(s3)
ffffffffc02069ba:	013a3023          	sd	s3,0(s4)
ffffffffc02069be:	8a4e                	mv	s4,s3
ffffffffc02069c0:	c90ff06f          	j	ffffffffc0205e50 <stride_dequeue+0xe32>
ffffffffc02069c4:	0089b783          	ld	a5,8(s3)
ffffffffc02069c8:	0109b803          	ld	a6,16(s3)
ffffffffc02069cc:	f42a                	sd	a0,40(sp)
ffffffffc02069ce:	ec3e                	sd	a5,24(sp)
ffffffffc02069d0:	02080b63          	beqz	a6,ffffffffc0206a06 <stride_dequeue+0x19e8>
ffffffffc02069d4:	8542                	mv	a0,a6
ffffffffc02069d6:	85e6                	mv	a1,s9
ffffffffc02069d8:	f042                	sd	a6,32(sp)
ffffffffc02069da:	c08fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc02069de:	77a2                	ld	a5,40(sp)
ffffffffc02069e0:	7802                	ld	a6,32(sp)
ffffffffc02069e2:	28f50ee3          	beq	a0,a5,ffffffffc020747e <stride_dequeue+0x2460>
ffffffffc02069e6:	010cb583          	ld	a1,16(s9)
ffffffffc02069ea:	008cbb03          	ld	s6,8(s9)
ffffffffc02069ee:	8542                	mv	a0,a6
ffffffffc02069f0:	c4efe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02069f4:	00acb423          	sd	a0,8(s9)
ffffffffc02069f8:	016cb823          	sd	s6,16(s9)
ffffffffc02069fc:	010c2b03          	lw	s6,16(s8)
ffffffffc0206a00:	c119                	beqz	a0,ffffffffc0206a06 <stride_dequeue+0x19e8>
ffffffffc0206a02:	01953023          	sd	s9,0(a0)
ffffffffc0206a06:	67e2                	ld	a5,24(sp)
ffffffffc0206a08:	0199b423          	sd	s9,8(s3)
ffffffffc0206a0c:	00f9b823          	sd	a5,16(s3)
ffffffffc0206a10:	013cb023          	sd	s3,0(s9)
ffffffffc0206a14:	8cce                	mv	s9,s3
ffffffffc0206a16:	de4ff06f          	j	ffffffffc0205ffa <stride_dequeue+0xfdc>
ffffffffc0206a1a:	0089b783          	ld	a5,8(s3)
ffffffffc0206a1e:	0109b803          	ld	a6,16(s3)
ffffffffc0206a22:	f42a                	sd	a0,40(sp)
ffffffffc0206a24:	e83e                	sd	a5,16(sp)
ffffffffc0206a26:	02080f63          	beqz	a6,ffffffffc0206a64 <stride_dequeue+0x1a46>
ffffffffc0206a2a:	8542                	mv	a0,a6
ffffffffc0206a2c:	85d2                	mv	a1,s4
ffffffffc0206a2e:	f032                	sd	a2,32(sp)
ffffffffc0206a30:	ec42                	sd	a6,24(sp)
ffffffffc0206a32:	bb0fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206a36:	77a2                	ld	a5,40(sp)
ffffffffc0206a38:	6862                	ld	a6,24(sp)
ffffffffc0206a3a:	7602                	ld	a2,32(sp)
ffffffffc0206a3c:	26f506e3          	beq	a0,a5,ffffffffc02074a8 <stride_dequeue+0x248a>
ffffffffc0206a40:	010a3583          	ld	a1,16(s4)
ffffffffc0206a44:	008a3b03          	ld	s6,8(s4)
ffffffffc0206a48:	8542                	mv	a0,a6
ffffffffc0206a4a:	ec32                	sd	a2,24(sp)
ffffffffc0206a4c:	bf2fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206a50:	00aa3423          	sd	a0,8(s4)
ffffffffc0206a54:	016a3823          	sd	s6,16(s4)
ffffffffc0206a58:	6662                	ld	a2,24(sp)
ffffffffc0206a5a:	010c2b03          	lw	s6,16(s8)
ffffffffc0206a5e:	c119                	beqz	a0,ffffffffc0206a64 <stride_dequeue+0x1a46>
ffffffffc0206a60:	01453023          	sd	s4,0(a0)
ffffffffc0206a64:	67c2                	ld	a5,16(sp)
ffffffffc0206a66:	0149b423          	sd	s4,8(s3)
ffffffffc0206a6a:	00f9b823          	sd	a5,16(s3)
ffffffffc0206a6e:	013a3023          	sd	s3,0(s4)
ffffffffc0206a72:	8a4e                	mv	s4,s3
ffffffffc0206a74:	cb8ff06f          	j	ffffffffc0205f2c <stride_dequeue+0xf0e>
ffffffffc0206a78:	008a3783          	ld	a5,8(s4)
ffffffffc0206a7c:	010a3883          	ld	a7,16(s4)
ffffffffc0206a80:	f42a                	sd	a0,40(sp)
ffffffffc0206a82:	ec3e                	sd	a5,24(sp)
ffffffffc0206a84:	02088b63          	beqz	a7,ffffffffc0206aba <stride_dequeue+0x1a9c>
ffffffffc0206a88:	8546                	mv	a0,a7
ffffffffc0206a8a:	85ce                	mv	a1,s3
ffffffffc0206a8c:	f046                	sd	a7,32(sp)
ffffffffc0206a8e:	b54fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206a92:	77a2                	ld	a5,40(sp)
ffffffffc0206a94:	7882                	ld	a7,32(sp)
ffffffffc0206a96:	26f501e3          	beq	a0,a5,ffffffffc02074f8 <stride_dequeue+0x24da>
ffffffffc0206a9a:	0109b583          	ld	a1,16(s3)
ffffffffc0206a9e:	0089bb03          	ld	s6,8(s3)
ffffffffc0206aa2:	8546                	mv	a0,a7
ffffffffc0206aa4:	b9afe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206aa8:	00a9b423          	sd	a0,8(s3)
ffffffffc0206aac:	0169b823          	sd	s6,16(s3)
ffffffffc0206ab0:	010c2b03          	lw	s6,16(s8)
ffffffffc0206ab4:	c119                	beqz	a0,ffffffffc0206aba <stride_dequeue+0x1a9c>
ffffffffc0206ab6:	01353023          	sd	s3,0(a0)
ffffffffc0206aba:	67e2                	ld	a5,24(sp)
ffffffffc0206abc:	013a3423          	sd	s3,8(s4)
ffffffffc0206ac0:	00fa3823          	sd	a5,16(s4)
ffffffffc0206ac4:	0149b023          	sd	s4,0(s3)
ffffffffc0206ac8:	89d2                	mv	s3,s4
ffffffffc0206aca:	f9bfe06f          	j	ffffffffc0205a64 <stride_dequeue+0xa46>
ffffffffc0206ace:	008a3783          	ld	a5,8(s4)
ffffffffc0206ad2:	010a3883          	ld	a7,16(s4)
ffffffffc0206ad6:	fc2a                	sd	a0,56(sp)
ffffffffc0206ad8:	f03e                	sd	a5,32(sp)
ffffffffc0206ada:	02088f63          	beqz	a7,ffffffffc0206b18 <stride_dequeue+0x1afa>
ffffffffc0206ade:	8546                	mv	a0,a7
ffffffffc0206ae0:	85ce                	mv	a1,s3
ffffffffc0206ae2:	f842                	sd	a6,48(sp)
ffffffffc0206ae4:	f446                	sd	a7,40(sp)
ffffffffc0206ae6:	afcfe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206aea:	7e62                	ld	t3,56(sp)
ffffffffc0206aec:	78a2                	ld	a7,40(sp)
ffffffffc0206aee:	7842                	ld	a6,48(sp)
ffffffffc0206af0:	35c509e3          	beq	a0,t3,ffffffffc0207642 <stride_dequeue+0x2624>
ffffffffc0206af4:	0109b583          	ld	a1,16(s3)
ffffffffc0206af8:	0089bb03          	ld	s6,8(s3)
ffffffffc0206afc:	8546                	mv	a0,a7
ffffffffc0206afe:	f442                	sd	a6,40(sp)
ffffffffc0206b00:	b3efe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206b04:	00a9b423          	sd	a0,8(s3)
ffffffffc0206b08:	0169b823          	sd	s6,16(s3)
ffffffffc0206b0c:	7822                	ld	a6,40(sp)
ffffffffc0206b0e:	010c2b03          	lw	s6,16(s8)
ffffffffc0206b12:	c119                	beqz	a0,ffffffffc0206b18 <stride_dequeue+0x1afa>
ffffffffc0206b14:	01353023          	sd	s3,0(a0)
ffffffffc0206b18:	7782                	ld	a5,32(sp)
ffffffffc0206b1a:	013a3423          	sd	s3,8(s4)
ffffffffc0206b1e:	00fa3823          	sd	a5,16(s4)
ffffffffc0206b22:	0149b023          	sd	s4,0(s3)
ffffffffc0206b26:	89d2                	mv	s3,s4
ffffffffc0206b28:	c73fe06f          	j	ffffffffc020579a <stride_dequeue+0x77c>
ffffffffc0206b2c:	661c                	ld	a5,8(a2)
ffffffffc0206b2e:	01063883          	ld	a7,16(a2)
ffffffffc0206b32:	fc2a                	sd	a0,56(sp)
ffffffffc0206b34:	ec3e                	sd	a5,24(sp)
ffffffffc0206b36:	04088363          	beqz	a7,ffffffffc0206b7c <stride_dequeue+0x1b5e>
ffffffffc0206b3a:	8546                	mv	a0,a7
ffffffffc0206b3c:	85ce                	mv	a1,s3
ffffffffc0206b3e:	f842                	sd	a6,48(sp)
ffffffffc0206b40:	f432                	sd	a2,40(sp)
ffffffffc0206b42:	f046                	sd	a7,32(sp)
ffffffffc0206b44:	a9efe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206b48:	7e62                	ld	t3,56(sp)
ffffffffc0206b4a:	7882                	ld	a7,32(sp)
ffffffffc0206b4c:	7622                	ld	a2,40(sp)
ffffffffc0206b4e:	7842                	ld	a6,48(sp)
ffffffffc0206b50:	25c501e3          	beq	a0,t3,ffffffffc0207592 <stride_dequeue+0x2574>
ffffffffc0206b54:	0109b583          	ld	a1,16(s3)
ffffffffc0206b58:	0089bb03          	ld	s6,8(s3)
ffffffffc0206b5c:	8546                	mv	a0,a7
ffffffffc0206b5e:	f442                	sd	a6,40(sp)
ffffffffc0206b60:	f032                	sd	a2,32(sp)
ffffffffc0206b62:	adcfe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206b66:	00a9b423          	sd	a0,8(s3)
ffffffffc0206b6a:	0169b823          	sd	s6,16(s3)
ffffffffc0206b6e:	7602                	ld	a2,32(sp)
ffffffffc0206b70:	7822                	ld	a6,40(sp)
ffffffffc0206b72:	010c2b03          	lw	s6,16(s8)
ffffffffc0206b76:	c119                	beqz	a0,ffffffffc0206b7c <stride_dequeue+0x1b5e>
ffffffffc0206b78:	01353023          	sd	s3,0(a0)
ffffffffc0206b7c:	67e2                	ld	a5,24(sp)
ffffffffc0206b7e:	01363423          	sd	s3,8(a2)
ffffffffc0206b82:	ea1c                	sd	a5,16(a2)
ffffffffc0206b84:	00c9b023          	sd	a2,0(s3)
ffffffffc0206b88:	89b2                	mv	s3,a2
ffffffffc0206b8a:	b13fe06f          	j	ffffffffc020569c <stride_dequeue+0x67e>
ffffffffc0206b8e:	89c6                	mv	s3,a7
ffffffffc0206b90:	9e4ff06f          	j	ffffffffc0205d74 <stride_dequeue+0xd56>
ffffffffc0206b94:	0088b783          	ld	a5,8(a7)
ffffffffc0206b98:	0108b803          	ld	a6,16(a7)
ffffffffc0206b9c:	fc2a                	sd	a0,56(sp)
ffffffffc0206b9e:	f03e                	sd	a5,32(sp)
ffffffffc0206ba0:	02080f63          	beqz	a6,ffffffffc0206bde <stride_dequeue+0x1bc0>
ffffffffc0206ba4:	8542                	mv	a0,a6
ffffffffc0206ba6:	85ce                	mv	a1,s3
ffffffffc0206ba8:	f846                	sd	a7,48(sp)
ffffffffc0206baa:	f442                	sd	a6,40(sp)
ffffffffc0206bac:	a36fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206bb0:	7e62                	ld	t3,56(sp)
ffffffffc0206bb2:	7822                	ld	a6,40(sp)
ffffffffc0206bb4:	78c2                	ld	a7,48(sp)
ffffffffc0206bb6:	47c50ce3          	beq	a0,t3,ffffffffc020782e <stride_dequeue+0x2810>
ffffffffc0206bba:	0109b583          	ld	a1,16(s3)
ffffffffc0206bbe:	0089bb03          	ld	s6,8(s3)
ffffffffc0206bc2:	8542                	mv	a0,a6
ffffffffc0206bc4:	f446                	sd	a7,40(sp)
ffffffffc0206bc6:	a78fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206bca:	00a9b423          	sd	a0,8(s3)
ffffffffc0206bce:	0169b823          	sd	s6,16(s3)
ffffffffc0206bd2:	78a2                	ld	a7,40(sp)
ffffffffc0206bd4:	010c2b03          	lw	s6,16(s8)
ffffffffc0206bd8:	c119                	beqz	a0,ffffffffc0206bde <stride_dequeue+0x1bc0>
ffffffffc0206bda:	01353023          	sd	s3,0(a0)
ffffffffc0206bde:	7782                	ld	a5,32(sp)
ffffffffc0206be0:	0138b423          	sd	s3,8(a7)
ffffffffc0206be4:	00f8b823          	sd	a5,16(a7)
ffffffffc0206be8:	0119b023          	sd	a7,0(s3)
ffffffffc0206bec:	89c6                	mv	s3,a7
ffffffffc0206bee:	8f0ff06f          	j	ffffffffc0205cde <stride_dequeue+0xcc0>
ffffffffc0206bf2:	0088b783          	ld	a5,8(a7)
ffffffffc0206bf6:	0108b803          	ld	a6,16(a7)
ffffffffc0206bfa:	fc2a                	sd	a0,56(sp)
ffffffffc0206bfc:	f03e                	sd	a5,32(sp)
ffffffffc0206bfe:	02080f63          	beqz	a6,ffffffffc0206c3c <stride_dequeue+0x1c1e>
ffffffffc0206c02:	8542                	mv	a0,a6
ffffffffc0206c04:	85ce                	mv	a1,s3
ffffffffc0206c06:	f846                	sd	a7,48(sp)
ffffffffc0206c08:	f442                	sd	a6,40(sp)
ffffffffc0206c0a:	9d8fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206c0e:	7e62                	ld	t3,56(sp)
ffffffffc0206c10:	7822                	ld	a6,40(sp)
ffffffffc0206c12:	78c2                	ld	a7,48(sp)
ffffffffc0206c14:	25c50de3          	beq	a0,t3,ffffffffc020766e <stride_dequeue+0x2650>
ffffffffc0206c18:	0109b583          	ld	a1,16(s3)
ffffffffc0206c1c:	0089bb03          	ld	s6,8(s3)
ffffffffc0206c20:	8542                	mv	a0,a6
ffffffffc0206c22:	f446                	sd	a7,40(sp)
ffffffffc0206c24:	a1afe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206c28:	00a9b423          	sd	a0,8(s3)
ffffffffc0206c2c:	0169b823          	sd	s6,16(s3)
ffffffffc0206c30:	78a2                	ld	a7,40(sp)
ffffffffc0206c32:	010c2b03          	lw	s6,16(s8)
ffffffffc0206c36:	c119                	beqz	a0,ffffffffc0206c3c <stride_dequeue+0x1c1e>
ffffffffc0206c38:	01353023          	sd	s3,0(a0)
ffffffffc0206c3c:	7782                	ld	a5,32(sp)
ffffffffc0206c3e:	0138b423          	sd	s3,8(a7)
ffffffffc0206c42:	00f8b823          	sd	a5,16(a7)
ffffffffc0206c46:	0119b023          	sd	a7,0(s3)
ffffffffc0206c4a:	89c6                	mv	s3,a7
ffffffffc0206c4c:	ee7fe06f          	j	ffffffffc0205b32 <stride_dequeue+0xb14>
ffffffffc0206c50:	0088b783          	ld	a5,8(a7)
ffffffffc0206c54:	0108b803          	ld	a6,16(a7)
ffffffffc0206c58:	fc2a                	sd	a0,56(sp)
ffffffffc0206c5a:	ec3e                	sd	a5,24(sp)
ffffffffc0206c5c:	04080263          	beqz	a6,ffffffffc0206ca0 <stride_dequeue+0x1c82>
ffffffffc0206c60:	8542                	mv	a0,a6
ffffffffc0206c62:	85ce                	mv	a1,s3
ffffffffc0206c64:	f846                	sd	a7,48(sp)
ffffffffc0206c66:	f042                	sd	a6,32(sp)
ffffffffc0206c68:	97afe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206c6c:	7e62                	ld	t3,56(sp)
ffffffffc0206c6e:	7802                	ld	a6,32(sp)
ffffffffc0206c70:	7622                	ld	a2,40(sp)
ffffffffc0206c72:	78c2                	ld	a7,48(sp)
ffffffffc0206c74:	23c503e3          	beq	a0,t3,ffffffffc020769a <stride_dequeue+0x267c>
ffffffffc0206c78:	0109b583          	ld	a1,16(s3)
ffffffffc0206c7c:	0089bb03          	ld	s6,8(s3)
ffffffffc0206c80:	8542                	mv	a0,a6
ffffffffc0206c82:	f446                	sd	a7,40(sp)
ffffffffc0206c84:	f032                	sd	a2,32(sp)
ffffffffc0206c86:	9b8fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206c8a:	00a9b423          	sd	a0,8(s3)
ffffffffc0206c8e:	0169b823          	sd	s6,16(s3)
ffffffffc0206c92:	7602                	ld	a2,32(sp)
ffffffffc0206c94:	78a2                	ld	a7,40(sp)
ffffffffc0206c96:	010c2b03          	lw	s6,16(s8)
ffffffffc0206c9a:	c119                	beqz	a0,ffffffffc0206ca0 <stride_dequeue+0x1c82>
ffffffffc0206c9c:	01353023          	sd	s3,0(a0)
ffffffffc0206ca0:	67e2                	ld	a5,24(sp)
ffffffffc0206ca2:	0138b423          	sd	s3,8(a7)
ffffffffc0206ca6:	00f8b823          	sd	a5,16(a7)
ffffffffc0206caa:	0119b023          	sd	a7,0(s3)
ffffffffc0206cae:	89c6                	mv	s3,a7
ffffffffc0206cb0:	f61fe06f          	j	ffffffffc0205c10 <stride_dequeue+0xbf2>
ffffffffc0206cb4:	0089b783          	ld	a5,8(s3)
ffffffffc0206cb8:	0109b303          	ld	t1,16(s3)
ffffffffc0206cbc:	fc2a                	sd	a0,56(sp)
ffffffffc0206cbe:	f03e                	sd	a5,32(sp)
ffffffffc0206cc0:	02030f63          	beqz	t1,ffffffffc0206cfe <stride_dequeue+0x1ce0>
ffffffffc0206cc4:	851a                	mv	a0,t1
ffffffffc0206cc6:	85e6                	mv	a1,s9
ffffffffc0206cc8:	f846                	sd	a7,48(sp)
ffffffffc0206cca:	f41a                	sd	t1,40(sp)
ffffffffc0206ccc:	916fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206cd0:	7e62                	ld	t3,56(sp)
ffffffffc0206cd2:	7322                	ld	t1,40(sp)
ffffffffc0206cd4:	78c2                	ld	a7,48(sp)
ffffffffc0206cd6:	11c50be3          	beq	a0,t3,ffffffffc02075ec <stride_dequeue+0x25ce>
ffffffffc0206cda:	010cb583          	ld	a1,16(s9)
ffffffffc0206cde:	008cbb03          	ld	s6,8(s9)
ffffffffc0206ce2:	851a                	mv	a0,t1
ffffffffc0206ce4:	f446                	sd	a7,40(sp)
ffffffffc0206ce6:	958fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206cea:	00acb423          	sd	a0,8(s9)
ffffffffc0206cee:	016cb823          	sd	s6,16(s9)
ffffffffc0206cf2:	78a2                	ld	a7,40(sp)
ffffffffc0206cf4:	010c2b03          	lw	s6,16(s8)
ffffffffc0206cf8:	c119                	beqz	a0,ffffffffc0206cfe <stride_dequeue+0x1ce0>
ffffffffc0206cfa:	01953023          	sd	s9,0(a0)
ffffffffc0206cfe:	7782                	ld	a5,32(sp)
ffffffffc0206d00:	0199b423          	sd	s9,8(s3)
ffffffffc0206d04:	00f9b823          	sd	a5,16(s3)
ffffffffc0206d08:	013cb023          	sd	s3,0(s9)
ffffffffc0206d0c:	8cce                	mv	s9,s3
ffffffffc0206d0e:	b8aff06f          	j	ffffffffc0206098 <stride_dequeue+0x107a>
ffffffffc0206d12:	89ee                	mv	s3,s11
ffffffffc0206d14:	dd6fe06f          	j	ffffffffc02052ea <stride_dequeue+0x2cc>
ffffffffc0206d18:	0089b783          	ld	a5,8(s3)
ffffffffc0206d1c:	0109b303          	ld	t1,16(s3)
ffffffffc0206d20:	fc2a                	sd	a0,56(sp)
ffffffffc0206d22:	f03e                	sd	a5,32(sp)
ffffffffc0206d24:	02030f63          	beqz	t1,ffffffffc0206d62 <stride_dequeue+0x1d44>
ffffffffc0206d28:	85c2                	mv	a1,a6
ffffffffc0206d2a:	851a                	mv	a0,t1
ffffffffc0206d2c:	f842                	sd	a6,48(sp)
ffffffffc0206d2e:	f41a                	sd	t1,40(sp)
ffffffffc0206d30:	8b2fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206d34:	7e62                	ld	t3,56(sp)
ffffffffc0206d36:	7322                	ld	t1,40(sp)
ffffffffc0206d38:	7842                	ld	a6,48(sp)
ffffffffc0206d3a:	0dc50fe3          	beq	a0,t3,ffffffffc0207618 <stride_dequeue+0x25fa>
ffffffffc0206d3e:	01083583          	ld	a1,16(a6)
ffffffffc0206d42:	851a                	mv	a0,t1
ffffffffc0206d44:	00883b03          	ld	s6,8(a6)
ffffffffc0206d48:	f442                	sd	a6,40(sp)
ffffffffc0206d4a:	8f4fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206d4e:	7822                	ld	a6,40(sp)
ffffffffc0206d50:	01683823          	sd	s6,16(a6)
ffffffffc0206d54:	00a83423          	sd	a0,8(a6)
ffffffffc0206d58:	010c2b03          	lw	s6,16(s8)
ffffffffc0206d5c:	c119                	beqz	a0,ffffffffc0206d62 <stride_dequeue+0x1d44>
ffffffffc0206d5e:	01053023          	sd	a6,0(a0)
ffffffffc0206d62:	7782                	ld	a5,32(sp)
ffffffffc0206d64:	0109b423          	sd	a6,8(s3)
ffffffffc0206d68:	00f9b823          	sd	a5,16(s3)
ffffffffc0206d6c:	01383023          	sd	s3,0(a6)
ffffffffc0206d70:	884e                	mv	a6,s3
ffffffffc0206d72:	bc4ff06f          	j	ffffffffc0206136 <stride_dequeue+0x1118>
ffffffffc0206d76:	008cb783          	ld	a5,8(s9)
ffffffffc0206d7a:	010cb883          	ld	a7,16(s9)
ffffffffc0206d7e:	fc2a                	sd	a0,56(sp)
ffffffffc0206d80:	f03e                	sd	a5,32(sp)
ffffffffc0206d82:	02088f63          	beqz	a7,ffffffffc0206dc0 <stride_dequeue+0x1da2>
ffffffffc0206d86:	8546                	mv	a0,a7
ffffffffc0206d88:	85ce                	mv	a1,s3
ffffffffc0206d8a:	f842                	sd	a6,48(sp)
ffffffffc0206d8c:	f446                	sd	a7,40(sp)
ffffffffc0206d8e:	854fe0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206d92:	7e62                	ld	t3,56(sp)
ffffffffc0206d94:	78a2                	ld	a7,40(sp)
ffffffffc0206d96:	7842                	ld	a6,48(sp)
ffffffffc0206d98:	27c505e3          	beq	a0,t3,ffffffffc0207802 <stride_dequeue+0x27e4>
ffffffffc0206d9c:	0109b583          	ld	a1,16(s3)
ffffffffc0206da0:	0089bb03          	ld	s6,8(s3)
ffffffffc0206da4:	8546                	mv	a0,a7
ffffffffc0206da6:	f442                	sd	a6,40(sp)
ffffffffc0206da8:	896fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206dac:	00a9b423          	sd	a0,8(s3)
ffffffffc0206db0:	0169b823          	sd	s6,16(s3)
ffffffffc0206db4:	7822                	ld	a6,40(sp)
ffffffffc0206db6:	010c2b03          	lw	s6,16(s8)
ffffffffc0206dba:	c119                	beqz	a0,ffffffffc0206dc0 <stride_dequeue+0x1da2>
ffffffffc0206dbc:	01353023          	sd	s3,0(a0)
ffffffffc0206dc0:	7782                	ld	a5,32(sp)
ffffffffc0206dc2:	013cb423          	sd	s3,8(s9)
ffffffffc0206dc6:	00fcb823          	sd	a5,16(s9)
ffffffffc0206dca:	0199b023          	sd	s9,0(s3)
ffffffffc0206dce:	89e6                	mv	s3,s9
ffffffffc0206dd0:	fb0fe06f          	j	ffffffffc0205580 <stride_dequeue+0x562>
ffffffffc0206dd4:	0089b783          	ld	a5,8(s3)
ffffffffc0206dd8:	0109b303          	ld	t1,16(s3)
ffffffffc0206ddc:	fc2a                	sd	a0,56(sp)
ffffffffc0206dde:	f03e                	sd	a5,32(sp)
ffffffffc0206de0:	02030f63          	beqz	t1,ffffffffc0206e1e <stride_dequeue+0x1e00>
ffffffffc0206de4:	85c2                	mv	a1,a6
ffffffffc0206de6:	851a                	mv	a0,t1
ffffffffc0206de8:	f842                	sd	a6,48(sp)
ffffffffc0206dea:	f41a                	sd	t1,40(sp)
ffffffffc0206dec:	ff7fd0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206df0:	7e62                	ld	t3,56(sp)
ffffffffc0206df2:	7322                	ld	t1,40(sp)
ffffffffc0206df4:	7842                	ld	a6,48(sp)
ffffffffc0206df6:	1bc509e3          	beq	a0,t3,ffffffffc02077a8 <stride_dequeue+0x278a>
ffffffffc0206dfa:	01083583          	ld	a1,16(a6)
ffffffffc0206dfe:	851a                	mv	a0,t1
ffffffffc0206e00:	00883b03          	ld	s6,8(a6)
ffffffffc0206e04:	f442                	sd	a6,40(sp)
ffffffffc0206e06:	838fe0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206e0a:	7822                	ld	a6,40(sp)
ffffffffc0206e0c:	01683823          	sd	s6,16(a6)
ffffffffc0206e10:	00a83423          	sd	a0,8(a6)
ffffffffc0206e14:	010c2b03          	lw	s6,16(s8)
ffffffffc0206e18:	c119                	beqz	a0,ffffffffc0206e1e <stride_dequeue+0x1e00>
ffffffffc0206e1a:	01053023          	sd	a6,0(a0)
ffffffffc0206e1e:	7782                	ld	a5,32(sp)
ffffffffc0206e20:	0109b423          	sd	a6,8(s3)
ffffffffc0206e24:	00f9b823          	sd	a5,16(s3)
ffffffffc0206e28:	01383023          	sd	s3,0(a6)
ffffffffc0206e2c:	884e                	mv	a6,s3
ffffffffc0206e2e:	ba4ff06f          	j	ffffffffc02061d2 <stride_dequeue+0x11b4>
ffffffffc0206e32:	0089b783          	ld	a5,8(s3)
ffffffffc0206e36:	0109b303          	ld	t1,16(s3)
ffffffffc0206e3a:	fc2a                	sd	a0,56(sp)
ffffffffc0206e3c:	ec3e                	sd	a5,24(sp)
ffffffffc0206e3e:	04030363          	beqz	t1,ffffffffc0206e84 <stride_dequeue+0x1e66>
ffffffffc0206e42:	85c2                	mv	a1,a6
ffffffffc0206e44:	851a                	mv	a0,t1
ffffffffc0206e46:	f832                	sd	a2,48(sp)
ffffffffc0206e48:	f442                	sd	a6,40(sp)
ffffffffc0206e4a:	f01a                	sd	t1,32(sp)
ffffffffc0206e4c:	f97fd0ef          	jal	ra,ffffffffc0204de2 <proc_stride_comp_f>
ffffffffc0206e50:	7642                	ld	a2,48(sp)
ffffffffc0206e52:	7e62                	ld	t3,56(sp)
ffffffffc0206e54:	7822                	ld	a6,40(sp)
ffffffffc0206e56:	f432                	sd	a2,40(sp)
ffffffffc0206e58:	7302                	ld	t1,32(sp)
ffffffffc0206e5a:	29c507e3          	beq	a0,t3,ffffffffc02078e8 <stride_dequeue+0x28ca>
ffffffffc0206e5e:	01083583          	ld	a1,16(a6)
ffffffffc0206e62:	851a                	mv	a0,t1
ffffffffc0206e64:	00883b03          	ld	s6,8(a6)
ffffffffc0206e68:	f042                	sd	a6,32(sp)
ffffffffc0206e6a:	fd5fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206e6e:	7802                	ld	a6,32(sp)
ffffffffc0206e70:	7622                	ld	a2,40(sp)
ffffffffc0206e72:	01683823          	sd	s6,16(a6)
ffffffffc0206e76:	00a83423          	sd	a0,8(a6)
ffffffffc0206e7a:	010c2b03          	lw	s6,16(s8)
ffffffffc0206e7e:	c119                	beqz	a0,ffffffffc0206e84 <stride_dequeue+0x1e66>
ffffffffc0206e80:	01053023          	sd	a6,0(a0)
ffffffffc0206e84:	67e2                	ld	a5,24(sp)
ffffffffc0206e86:	0109b423          	sd	a6,8(s3)
ffffffffc0206e8a:	00f9b823          	sd	a5,16(s3)
ffffffffc0206e8e:	01383023          	sd	s3,0(a6)
ffffffffc0206e92:	884e                	mv	a6,s3
ffffffffc0206e94:	be2ff06f          	j	ffffffffc0206276 <stride_dequeue+0x1258>
ffffffffc0206e98:	89c6                	mv	s3,a7
ffffffffc0206e9a:	9cffe06f          	j	ffffffffc0205868 <stride_dequeue+0x84a>
ffffffffc0206e9e:	89e6                	mv	s3,s9
ffffffffc0206ea0:	aadfe06f          	j	ffffffffc020594c <stride_dequeue+0x92e>
ffffffffc0206ea4:	89ee                	mv	s3,s11
ffffffffc0206ea6:	d9efe06f          	j	ffffffffc0205444 <stride_dequeue+0x426>
ffffffffc0206eaa:	89d2                	mv	s3,s4
ffffffffc0206eac:	bb9fe06f          	j	ffffffffc0205a64 <stride_dequeue+0xa46>
ffffffffc0206eb0:	0108b503          	ld	a0,16(a7)
ffffffffc0206eb4:	85ce                	mv	a1,s3
ffffffffc0206eb6:	0088bb03          	ld	s6,8(a7)
ffffffffc0206eba:	f81a                	sd	t1,48(sp)
ffffffffc0206ebc:	f446                	sd	a7,40(sp)
ffffffffc0206ebe:	f81fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206ec2:	78a2                	ld	a7,40(sp)
ffffffffc0206ec4:	7342                	ld	t1,48(sp)
ffffffffc0206ec6:	0168b823          	sd	s6,16(a7)
ffffffffc0206eca:	00a8b423          	sd	a0,8(a7)
ffffffffc0206ece:	010c2b03          	lw	s6,16(s8)
ffffffffc0206ed2:	d179                	beqz	a0,ffffffffc0206e98 <stride_dequeue+0x1e7a>
ffffffffc0206ed4:	01153023          	sd	a7,0(a0)
ffffffffc0206ed8:	89c6                	mv	s3,a7
ffffffffc0206eda:	98ffe06f          	j	ffffffffc0205868 <stride_dequeue+0x84a>
ffffffffc0206ede:	0109b503          	ld	a0,16(s3)
ffffffffc0206ee2:	0089bb03          	ld	s6,8(s3)
ffffffffc0206ee6:	85be                	mv	a1,a5
ffffffffc0206ee8:	f442                	sd	a6,40(sp)
ffffffffc0206eea:	f55fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206eee:	00a9b423          	sd	a0,8(s3)
ffffffffc0206ef2:	0169b823          	sd	s6,16(s3)
ffffffffc0206ef6:	7822                	ld	a6,40(sp)
ffffffffc0206ef8:	010c2b03          	lw	s6,16(s8)
ffffffffc0206efc:	5e050b63          	beqz	a0,ffffffffc02074f2 <stride_dequeue+0x24d4>
ffffffffc0206f00:	01353023          	sd	s3,0(a0)
ffffffffc0206f04:	87ce                	mv	a5,s3
ffffffffc0206f06:	bccff06f          	j	ffffffffc02062d2 <stride_dequeue+0x12b4>
ffffffffc0206f0a:	010cb503          	ld	a0,16(s9)
ffffffffc0206f0e:	008cbb03          	ld	s6,8(s9)
ffffffffc0206f12:	85ce                	mv	a1,s3
ffffffffc0206f14:	f2bfd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206f18:	00acb423          	sd	a0,8(s9)
ffffffffc0206f1c:	016cb823          	sd	s6,16(s9)
ffffffffc0206f20:	7822                	ld	a6,40(sp)
ffffffffc0206f22:	7342                	ld	t1,48(sp)
ffffffffc0206f24:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f28:	d93d                	beqz	a0,ffffffffc0206e9e <stride_dequeue+0x1e80>
ffffffffc0206f2a:	01953023          	sd	s9,0(a0)
ffffffffc0206f2e:	89e6                	mv	s3,s9
ffffffffc0206f30:	a1dfe06f          	j	ffffffffc020594c <stride_dequeue+0x92e>
ffffffffc0206f34:	0108b503          	ld	a0,16(a7)
ffffffffc0206f38:	85ce                	mv	a1,s3
ffffffffc0206f3a:	0088bb03          	ld	s6,8(a7)
ffffffffc0206f3e:	f842                	sd	a6,48(sp)
ffffffffc0206f40:	f446                	sd	a7,40(sp)
ffffffffc0206f42:	efdfd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206f46:	78a2                	ld	a7,40(sp)
ffffffffc0206f48:	7842                	ld	a6,48(sp)
ffffffffc0206f4a:	0168b823          	sd	s6,16(a7)
ffffffffc0206f4e:	00a8b423          	sd	a0,8(a7)
ffffffffc0206f52:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f56:	c2050ce3          	beqz	a0,ffffffffc0206b8e <stride_dequeue+0x1b70>
ffffffffc0206f5a:	01153023          	sd	a7,0(a0)
ffffffffc0206f5e:	89c6                	mv	s3,a7
ffffffffc0206f60:	e15fe06f          	j	ffffffffc0205d74 <stride_dequeue+0xd56>
ffffffffc0206f64:	010db503          	ld	a0,16(s11)
ffffffffc0206f68:	008dbb03          	ld	s6,8(s11)
ffffffffc0206f6c:	85ce                	mv	a1,s3
ffffffffc0206f6e:	ed1fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206f72:	00adb423          	sd	a0,8(s11)
ffffffffc0206f76:	016db823          	sd	s6,16(s11)
ffffffffc0206f7a:	7602                	ld	a2,32(sp)
ffffffffc0206f7c:	7822                	ld	a6,40(sp)
ffffffffc0206f7e:	7342                	ld	t1,48(sp)
ffffffffc0206f80:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f84:	d105                	beqz	a0,ffffffffc0206ea4 <stride_dequeue+0x1e86>
ffffffffc0206f86:	01b53023          	sd	s11,0(a0)
ffffffffc0206f8a:	89ee                	mv	s3,s11
ffffffffc0206f8c:	cb8fe06f          	j	ffffffffc0205444 <stride_dequeue+0x426>
ffffffffc0206f90:	010db503          	ld	a0,16(s11)
ffffffffc0206f94:	008dbb03          	ld	s6,8(s11)
ffffffffc0206f98:	85ce                	mv	a1,s3
ffffffffc0206f9a:	ea5fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0206f9e:	00adb423          	sd	a0,8(s11)
ffffffffc0206fa2:	016db823          	sd	s6,16(s11)
ffffffffc0206fa6:	7322                	ld	t1,40(sp)
ffffffffc0206fa8:	7842                	ld	a6,48(sp)
ffffffffc0206faa:	010c2b03          	lw	s6,16(s8)
ffffffffc0206fae:	d60502e3          	beqz	a0,ffffffffc0206d12 <stride_dequeue+0x1cf4>
ffffffffc0206fb2:	01b53023          	sd	s11,0(a0)
ffffffffc0206fb6:	89ee                	mv	s3,s11
ffffffffc0206fb8:	b32fe06f          	j	ffffffffc02052ea <stride_dequeue+0x2cc>
ffffffffc0206fbc:	89e6                	mv	s3,s9
ffffffffc0206fbe:	dc2fe06f          	j	ffffffffc0205580 <stride_dequeue+0x562>
ffffffffc0206fc2:	89c6                	mv	s3,a7
ffffffffc0206fc4:	d1bfe06f          	j	ffffffffc0205cde <stride_dequeue+0xcc0>
ffffffffc0206fc8:	00003697          	auipc	a3,0x3
ffffffffc0206fcc:	a1068693          	addi	a3,a3,-1520 # ffffffffc02099d8 <default_pmm_manager+0x6a0>
ffffffffc0206fd0:	00001617          	auipc	a2,0x1
ffffffffc0206fd4:	62860613          	addi	a2,a2,1576 # ffffffffc02085f8 <commands+0x410>
ffffffffc0206fd8:	06300593          	li	a1,99
ffffffffc0206fdc:	00003517          	auipc	a0,0x3
ffffffffc0206fe0:	a2450513          	addi	a0,a0,-1500 # ffffffffc0209a00 <default_pmm_manager+0x6c8>
ffffffffc0206fe4:	a24f90ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0206fe8:	89d2                	mv	s3,s4
ffffffffc0206fea:	fb0fe06f          	j	ffffffffc020579a <stride_dequeue+0x77c>
ffffffffc0206fee:	89c6                	mv	s3,a7
ffffffffc0206ff0:	c21fe06f          	j	ffffffffc0205c10 <stride_dequeue+0xbf2>
ffffffffc0206ff4:	89c6                	mv	s3,a7
ffffffffc0206ff6:	b3dfe06f          	j	ffffffffc0205b32 <stride_dequeue+0xb14>
ffffffffc0206ffa:	89b2                	mv	s3,a2
ffffffffc0206ffc:	ea0fe06f          	j	ffffffffc020569c <stride_dequeue+0x67e>
ffffffffc0207000:	0109b503          	ld	a0,16(s3)
ffffffffc0207004:	0089bb03          	ld	s6,8(s3)
ffffffffc0207008:	85a6                	mv	a1,s1
ffffffffc020700a:	e35fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc020700e:	00a9b423          	sd	a0,8(s3)
ffffffffc0207012:	0169b823          	sd	s6,16(s3)
ffffffffc0207016:	010c2b03          	lw	s6,16(s8)
ffffffffc020701a:	b4050363          	beqz	a0,ffffffffc0206360 <stride_dequeue+0x1342>
ffffffffc020701e:	01353023          	sd	s3,0(a0)
ffffffffc0207022:	b3eff06f          	j	ffffffffc0206360 <stride_dequeue+0x1342>
ffffffffc0207026:	0109b503          	ld	a0,16(s3)
ffffffffc020702a:	0089bb03          	ld	s6,8(s3)
ffffffffc020702e:	859a                	mv	a1,t1
ffffffffc0207030:	f446                	sd	a7,40(sp)
ffffffffc0207032:	e0dfd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207036:	00a9b423          	sd	a0,8(s3)
ffffffffc020703a:	0169b823          	sd	s6,16(s3)
ffffffffc020703e:	78a2                	ld	a7,40(sp)
ffffffffc0207040:	010c2b03          	lw	s6,16(s8)
ffffffffc0207044:	100505e3          	beqz	a0,ffffffffc020794e <stride_dequeue+0x2930>
ffffffffc0207048:	01353023          	sd	s3,0(a0)
ffffffffc020704c:	834e                	mv	t1,s3
ffffffffc020704e:	b0c5                	j	ffffffffc020692e <stride_dequeue+0x1910>
ffffffffc0207050:	0109b503          	ld	a0,16(s3)
ffffffffc0207054:	0089bb03          	ld	s6,8(s3)
ffffffffc0207058:	85f2                	mv	a1,t3
ffffffffc020705a:	f442                	sd	a6,40(sp)
ffffffffc020705c:	f032                	sd	a2,32(sp)
ffffffffc020705e:	de1fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207062:	00a9b423          	sd	a0,8(s3)
ffffffffc0207066:	0169b823          	sd	s6,16(s3)
ffffffffc020706a:	7602                	ld	a2,32(sp)
ffffffffc020706c:	7822                	ld	a6,40(sp)
ffffffffc020706e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207072:	9e050b63          	beqz	a0,ffffffffc0206268 <stride_dequeue+0x124a>
ffffffffc0207076:	01353023          	sd	s3,0(a0)
ffffffffc020707a:	9eeff06f          	j	ffffffffc0206268 <stride_dequeue+0x124a>
ffffffffc020707e:	0109b503          	ld	a0,16(s3)
ffffffffc0207082:	0089bb03          	ld	s6,8(s3)
ffffffffc0207086:	859a                	mv	a1,t1
ffffffffc0207088:	f442                	sd	a6,40(sp)
ffffffffc020708a:	db5fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc020708e:	00a9b423          	sd	a0,8(s3)
ffffffffc0207092:	0169b823          	sd	s6,16(s3)
ffffffffc0207096:	7822                	ld	a6,40(sp)
ffffffffc0207098:	010c2b03          	lw	s6,16(s8)
ffffffffc020709c:	08050de3          	beqz	a0,ffffffffc0207936 <stride_dequeue+0x2918>
ffffffffc02070a0:	01353023          	sd	s3,0(a0)
ffffffffc02070a4:	834e                	mv	t1,s3
ffffffffc02070a6:	efaff06f          	j	ffffffffc02067a0 <stride_dequeue+0x1782>
ffffffffc02070aa:	89a6                	mv	s3,s1
ffffffffc02070ac:	ab4ff06f          	j	ffffffffc0206360 <stride_dequeue+0x1342>
ffffffffc02070b0:	0109b503          	ld	a0,16(s3)
ffffffffc02070b4:	0089bb03          	ld	s6,8(s3)
ffffffffc02070b8:	85ee                	mv	a1,s11
ffffffffc02070ba:	f046                	sd	a7,32(sp)
ffffffffc02070bc:	d83fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02070c0:	00a9b423          	sd	a0,8(s3)
ffffffffc02070c4:	0169b823          	sd	s6,16(s3)
ffffffffc02070c8:	7882                	ld	a7,32(sp)
ffffffffc02070ca:	010c2b03          	lw	s6,16(s8)
ffffffffc02070ce:	bc050f63          	beqz	a0,ffffffffc02064ac <stride_dequeue+0x148e>
ffffffffc02070d2:	01353023          	sd	s3,0(a0)
ffffffffc02070d6:	bd6ff06f          	j	ffffffffc02064ac <stride_dequeue+0x148e>
ffffffffc02070da:	0109b503          	ld	a0,16(s3)
ffffffffc02070de:	0089bb03          	ld	s6,8(s3)
ffffffffc02070e2:	85f2                	mv	a1,t3
ffffffffc02070e4:	f442                	sd	a6,40(sp)
ffffffffc02070e6:	d59fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02070ea:	00a9b423          	sd	a0,8(s3)
ffffffffc02070ee:	0169b823          	sd	s6,16(s3)
ffffffffc02070f2:	7822                	ld	a6,40(sp)
ffffffffc02070f4:	010c2b03          	lw	s6,16(s8)
ffffffffc02070f8:	e119                	bnez	a0,ffffffffc02070fe <stride_dequeue+0x20e0>
ffffffffc02070fa:	8caff06f          	j	ffffffffc02061c4 <stride_dequeue+0x11a6>
ffffffffc02070fe:	01353023          	sd	s3,0(a0)
ffffffffc0207102:	8c2ff06f          	j	ffffffffc02061c4 <stride_dequeue+0x11a6>
ffffffffc0207106:	0109b503          	ld	a0,16(s3)
ffffffffc020710a:	0089bb03          	ld	s6,8(s3)
ffffffffc020710e:	85b2                	mv	a1,a2
ffffffffc0207110:	ec46                	sd	a7,24(sp)
ffffffffc0207112:	d2dfd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207116:	00a9b423          	sd	a0,8(s3)
ffffffffc020711a:	0169b823          	sd	s6,16(s3)
ffffffffc020711e:	68e2                	ld	a7,24(sp)
ffffffffc0207120:	010c2b03          	lw	s6,16(s8)
ffffffffc0207124:	c2050963          	beqz	a0,ffffffffc0206556 <stride_dequeue+0x1538>
ffffffffc0207128:	01353023          	sd	s3,0(a0)
ffffffffc020712c:	c2aff06f          	j	ffffffffc0206556 <stride_dequeue+0x1538>
ffffffffc0207130:	0109b503          	ld	a0,16(s3)
ffffffffc0207134:	0089bb03          	ld	s6,8(s3)
ffffffffc0207138:	859a                	mv	a1,t1
ffffffffc020713a:	f442                	sd	a6,40(sp)
ffffffffc020713c:	f032                	sd	a2,32(sp)
ffffffffc020713e:	d01fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207142:	00a9b423          	sd	a0,8(s3)
ffffffffc0207146:	0169b823          	sd	s6,16(s3)
ffffffffc020714a:	7602                	ld	a2,32(sp)
ffffffffc020714c:	7822                	ld	a6,40(sp)
ffffffffc020714e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207152:	7c050363          	beqz	a0,ffffffffc0207918 <stride_dequeue+0x28fa>
ffffffffc0207156:	01353023          	sd	s3,0(a0)
ffffffffc020715a:	834e                	mv	t1,s3
ffffffffc020715c:	eaeff06f          	j	ffffffffc020680a <stride_dequeue+0x17ec>
ffffffffc0207160:	0109b503          	ld	a0,16(s3)
ffffffffc0207164:	0089bb03          	ld	s6,8(s3)
ffffffffc0207168:	85c2                	mv	a1,a6
ffffffffc020716a:	ec32                	sd	a2,24(sp)
ffffffffc020716c:	cd3fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207170:	00a9b423          	sd	a0,8(s3)
ffffffffc0207174:	0169b823          	sd	s6,16(s3)
ffffffffc0207178:	6662                	ld	a2,24(sp)
ffffffffc020717a:	010c2b03          	lw	s6,16(s8)
ffffffffc020717e:	d2050263          	beqz	a0,ffffffffc02066a2 <stride_dequeue+0x1684>
ffffffffc0207182:	01353023          	sd	s3,0(a0)
ffffffffc0207186:	d1cff06f          	j	ffffffffc02066a2 <stride_dequeue+0x1684>
ffffffffc020718a:	0109b503          	ld	a0,16(s3)
ffffffffc020718e:	0089bb03          	ld	s6,8(s3)
ffffffffc0207192:	85c2                	mv	a1,a6
ffffffffc0207194:	cabfd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207198:	00a9b423          	sd	a0,8(s3)
ffffffffc020719c:	0169b823          	sd	s6,16(s3)
ffffffffc02071a0:	010c2b03          	lw	s6,16(s8)
ffffffffc02071a4:	c4050b63          	beqz	a0,ffffffffc02065fa <stride_dequeue+0x15dc>
ffffffffc02071a8:	01353023          	sd	s3,0(a0)
ffffffffc02071ac:	c4eff06f          	j	ffffffffc02065fa <stride_dequeue+0x15dc>
ffffffffc02071b0:	0109b503          	ld	a0,16(s3)
ffffffffc02071b4:	0089bb03          	ld	s6,8(s3)
ffffffffc02071b8:	859a                	mv	a1,t1
ffffffffc02071ba:	c85fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02071be:	00a9b423          	sd	a0,8(s3)
ffffffffc02071c2:	0169b823          	sd	s6,16(s3)
ffffffffc02071c6:	010c2b03          	lw	s6,16(s8)
ffffffffc02071ca:	e119                	bnez	a0,ffffffffc02071d0 <stride_dequeue+0x21b2>
ffffffffc02071cc:	c77fe06f          	j	ffffffffc0205e42 <stride_dequeue+0xe24>
ffffffffc02071d0:	01353023          	sd	s3,0(a0)
ffffffffc02071d4:	c6ffe06f          	j	ffffffffc0205e42 <stride_dequeue+0xe24>
ffffffffc02071d8:	6a08                	ld	a0,16(a2)
ffffffffc02071da:	85f2                	mv	a1,t3
ffffffffc02071dc:	00863b03          	ld	s6,8(a2)
ffffffffc02071e0:	c5ffd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02071e4:	7602                	ld	a2,32(sp)
ffffffffc02071e6:	7822                	ld	a6,40(sp)
ffffffffc02071e8:	01663823          	sd	s6,16(a2)
ffffffffc02071ec:	e608                	sd	a0,8(a2)
ffffffffc02071ee:	010c2b03          	lw	s6,16(s8)
ffffffffc02071f2:	e119                	bnez	a0,ffffffffc02071f8 <stride_dequeue+0x21da>
ffffffffc02071f4:	c9afe06f          	j	ffffffffc020568e <stride_dequeue+0x670>
ffffffffc02071f8:	e110                	sd	a2,0(a0)
ffffffffc02071fa:	c94fe06f          	j	ffffffffc020568e <stride_dequeue+0x670>
ffffffffc02071fe:	010a3503          	ld	a0,16(s4)
ffffffffc0207202:	008a3b03          	ld	s6,8(s4)
ffffffffc0207206:	859a                	mv	a1,t1
ffffffffc0207208:	c37fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc020720c:	00aa3423          	sd	a0,8(s4)
ffffffffc0207210:	016a3823          	sd	s6,16(s4)
ffffffffc0207214:	010c2b03          	lw	s6,16(s8)
ffffffffc0207218:	e119                	bnez	a0,ffffffffc020721e <stride_dequeue+0x2200>
ffffffffc020721a:	83dfe06f          	j	ffffffffc0205a56 <stride_dequeue+0xa38>
ffffffffc020721e:	01453023          	sd	s4,0(a0)
ffffffffc0207222:	835fe06f          	j	ffffffffc0205a56 <stride_dequeue+0xa38>
ffffffffc0207226:	010cb503          	ld	a0,16(s9)
ffffffffc020722a:	008cbb03          	ld	s6,8(s9)
ffffffffc020722e:	85f2                	mv	a1,t3
ffffffffc0207230:	f442                	sd	a6,40(sp)
ffffffffc0207232:	c0dfd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207236:	00acb423          	sd	a0,8(s9)
ffffffffc020723a:	016cb823          	sd	s6,16(s9)
ffffffffc020723e:	7822                	ld	a6,40(sp)
ffffffffc0207240:	010c2b03          	lw	s6,16(s8)
ffffffffc0207244:	e119                	bnez	a0,ffffffffc020724a <stride_dequeue+0x222c>
ffffffffc0207246:	b2cfe06f          	j	ffffffffc0205572 <stride_dequeue+0x554>
ffffffffc020724a:	01953023          	sd	s9,0(a0)
ffffffffc020724e:	b24fe06f          	j	ffffffffc0205572 <stride_dequeue+0x554>
ffffffffc0207252:	010a3503          	ld	a0,16(s4)
ffffffffc0207256:	008a3b03          	ld	s6,8(s4)
ffffffffc020725a:	85f2                	mv	a1,t3
ffffffffc020725c:	f442                	sd	a6,40(sp)
ffffffffc020725e:	be1fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207262:	00aa3423          	sd	a0,8(s4)
ffffffffc0207266:	016a3823          	sd	s6,16(s4)
ffffffffc020726a:	7822                	ld	a6,40(sp)
ffffffffc020726c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207270:	e119                	bnez	a0,ffffffffc0207276 <stride_dequeue+0x2258>
ffffffffc0207272:	d1afe06f          	j	ffffffffc020578c <stride_dequeue+0x76e>
ffffffffc0207276:	01453023          	sd	s4,0(a0)
ffffffffc020727a:	d12fe06f          	j	ffffffffc020578c <stride_dequeue+0x76e>
ffffffffc020727e:	0108b503          	ld	a0,16(a7)
ffffffffc0207282:	85f2                	mv	a1,t3
ffffffffc0207284:	0088bb03          	ld	s6,8(a7)
ffffffffc0207288:	f046                	sd	a7,32(sp)
ffffffffc020728a:	bb5fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc020728e:	7882                	ld	a7,32(sp)
ffffffffc0207290:	7622                	ld	a2,40(sp)
ffffffffc0207292:	0168b823          	sd	s6,16(a7)
ffffffffc0207296:	00a8b423          	sd	a0,8(a7)
ffffffffc020729a:	010c2b03          	lw	s6,16(s8)
ffffffffc020729e:	e119                	bnez	a0,ffffffffc02072a4 <stride_dequeue+0x2286>
ffffffffc02072a0:	963fe06f          	j	ffffffffc0205c02 <stride_dequeue+0xbe4>
ffffffffc02072a4:	01153023          	sd	a7,0(a0)
ffffffffc02072a8:	95bfe06f          	j	ffffffffc0205c02 <stride_dequeue+0xbe4>
ffffffffc02072ac:	0108b503          	ld	a0,16(a7)
ffffffffc02072b0:	85f2                	mv	a1,t3
ffffffffc02072b2:	0088bb03          	ld	s6,8(a7)
ffffffffc02072b6:	f446                	sd	a7,40(sp)
ffffffffc02072b8:	b87fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02072bc:	78a2                	ld	a7,40(sp)
ffffffffc02072be:	0168b823          	sd	s6,16(a7)
ffffffffc02072c2:	00a8b423          	sd	a0,8(a7)
ffffffffc02072c6:	010c2b03          	lw	s6,16(s8)
ffffffffc02072ca:	e119                	bnez	a0,ffffffffc02072d0 <stride_dequeue+0x22b2>
ffffffffc02072cc:	a05fe06f          	j	ffffffffc0205cd0 <stride_dequeue+0xcb2>
ffffffffc02072d0:	01153023          	sd	a7,0(a0)
ffffffffc02072d4:	9fdfe06f          	j	ffffffffc0205cd0 <stride_dequeue+0xcb2>
ffffffffc02072d8:	0109b503          	ld	a0,16(s3)
ffffffffc02072dc:	0089bb03          	ld	s6,8(s3)
ffffffffc02072e0:	85c2                	mv	a1,a6
ffffffffc02072e2:	f446                	sd	a7,40(sp)
ffffffffc02072e4:	b5bfd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02072e8:	00a9b423          	sd	a0,8(s3)
ffffffffc02072ec:	0169b823          	sd	s6,16(s3)
ffffffffc02072f0:	78a2                	ld	a7,40(sp)
ffffffffc02072f2:	010c2b03          	lw	s6,16(s8)
ffffffffc02072f6:	66050563          	beqz	a0,ffffffffc0207960 <stride_dequeue+0x2942>
ffffffffc02072fa:	01353023          	sd	s3,0(a0)
ffffffffc02072fe:	884e                	mv	a6,s3
ffffffffc0207300:	d6aff06f          	j	ffffffffc020686a <stride_dequeue+0x184c>
ffffffffc0207304:	0109b503          	ld	a0,16(s3)
ffffffffc0207308:	0089bb03          	ld	s6,8(s3)
ffffffffc020730c:	85f2                	mv	a1,t3
ffffffffc020730e:	f442                	sd	a6,40(sp)
ffffffffc0207310:	b2ffd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207314:	00a9b423          	sd	a0,8(s3)
ffffffffc0207318:	0169b823          	sd	s6,16(s3)
ffffffffc020731c:	7822                	ld	a6,40(sp)
ffffffffc020731e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207322:	e119                	bnez	a0,ffffffffc0207328 <stride_dequeue+0x230a>
ffffffffc0207324:	e05fe06f          	j	ffffffffc0206128 <stride_dequeue+0x110a>
ffffffffc0207328:	01353023          	sd	s3,0(a0)
ffffffffc020732c:	dfdfe06f          	j	ffffffffc0206128 <stride_dequeue+0x110a>
ffffffffc0207330:	0109b503          	ld	a0,16(s3)
ffffffffc0207334:	0089bb03          	ld	s6,8(s3)
ffffffffc0207338:	859a                	mv	a1,t1
ffffffffc020733a:	f442                	sd	a6,40(sp)
ffffffffc020733c:	b03fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207340:	00a9b423          	sd	a0,8(s3)
ffffffffc0207344:	0169b823          	sd	s6,16(s3)
ffffffffc0207348:	7822                	ld	a6,40(sp)
ffffffffc020734a:	010c2b03          	lw	s6,16(s8)
ffffffffc020734e:	64050163          	beqz	a0,ffffffffc0207990 <stride_dequeue+0x2972>
ffffffffc0207352:	01353023          	sd	s3,0(a0)
ffffffffc0207356:	834e                	mv	t1,s3
ffffffffc0207358:	d76ff06f          	j	ffffffffc02068ce <stride_dequeue+0x18b0>
ffffffffc020735c:	0109b503          	ld	a0,16(s3)
ffffffffc0207360:	0089bb03          	ld	s6,8(s3)
ffffffffc0207364:	85f2                	mv	a1,t3
ffffffffc0207366:	f446                	sd	a7,40(sp)
ffffffffc0207368:	ad7fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc020736c:	00a9b423          	sd	a0,8(s3)
ffffffffc0207370:	0169b823          	sd	s6,16(s3)
ffffffffc0207374:	78a2                	ld	a7,40(sp)
ffffffffc0207376:	010c2b03          	lw	s6,16(s8)
ffffffffc020737a:	e119                	bnez	a0,ffffffffc0207380 <stride_dequeue+0x2362>
ffffffffc020737c:	d0ffe06f          	j	ffffffffc020608a <stride_dequeue+0x106c>
ffffffffc0207380:	01353023          	sd	s3,0(a0)
ffffffffc0207384:	d07fe06f          	j	ffffffffc020608a <stride_dequeue+0x106c>
ffffffffc0207388:	0109b503          	ld	a0,16(s3)
ffffffffc020738c:	0089bb03          	ld	s6,8(s3)
ffffffffc0207390:	859a                	mv	a1,t1
ffffffffc0207392:	aadfd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207396:	00a9b423          	sd	a0,8(s3)
ffffffffc020739a:	0169b823          	sd	s6,16(s3)
ffffffffc020739e:	010c2b03          	lw	s6,16(s8)
ffffffffc02073a2:	e119                	bnez	a0,ffffffffc02073a8 <stride_dequeue+0x238a>
ffffffffc02073a4:	c49fe06f          	j	ffffffffc0205fec <stride_dequeue+0xfce>
ffffffffc02073a8:	01353023          	sd	s3,0(a0)
ffffffffc02073ac:	c41fe06f          	j	ffffffffc0205fec <stride_dequeue+0xfce>
ffffffffc02073b0:	0109b503          	ld	a0,16(s3)
ffffffffc02073b4:	0089bb03          	ld	s6,8(s3)
ffffffffc02073b8:	859a                	mv	a1,t1
ffffffffc02073ba:	ec32                	sd	a2,24(sp)
ffffffffc02073bc:	a83fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02073c0:	00a9b423          	sd	a0,8(s3)
ffffffffc02073c4:	0169b823          	sd	s6,16(s3)
ffffffffc02073c8:	6662                	ld	a2,24(sp)
ffffffffc02073ca:	010c2b03          	lw	s6,16(s8)
ffffffffc02073ce:	e119                	bnez	a0,ffffffffc02073d4 <stride_dequeue+0x23b6>
ffffffffc02073d0:	b4ffe06f          	j	ffffffffc0205f1e <stride_dequeue+0xf00>
ffffffffc02073d4:	01353023          	sd	s3,0(a0)
ffffffffc02073d8:	b47fe06f          	j	ffffffffc0205f1e <stride_dequeue+0xf00>
ffffffffc02073dc:	0108b503          	ld	a0,16(a7)
ffffffffc02073e0:	85f2                	mv	a1,t3
ffffffffc02073e2:	0088bb03          	ld	s6,8(a7)
ffffffffc02073e6:	f446                	sd	a7,40(sp)
ffffffffc02073e8:	a57fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02073ec:	78a2                	ld	a7,40(sp)
ffffffffc02073ee:	0168b823          	sd	s6,16(a7)
ffffffffc02073f2:	00a8b423          	sd	a0,8(a7)
ffffffffc02073f6:	010c2b03          	lw	s6,16(s8)
ffffffffc02073fa:	e119                	bnez	a0,ffffffffc0207400 <stride_dequeue+0x23e2>
ffffffffc02073fc:	f28fe06f          	j	ffffffffc0205b24 <stride_dequeue+0xb06>
ffffffffc0207400:	01153023          	sd	a7,0(a0)
ffffffffc0207404:	f20fe06f          	j	ffffffffc0205b24 <stride_dequeue+0xb06>
ffffffffc0207408:	0109b503          	ld	a0,16(s3)
ffffffffc020740c:	0089bb03          	ld	s6,8(s3)
ffffffffc0207410:	85d2                	mv	a1,s4
ffffffffc0207412:	f046                	sd	a7,32(sp)
ffffffffc0207414:	a2bfd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207418:	00a9b423          	sd	a0,8(s3)
ffffffffc020741c:	0169b823          	sd	s6,16(s3)
ffffffffc0207420:	7882                	ld	a7,32(sp)
ffffffffc0207422:	010c2b03          	lw	s6,16(s8)
ffffffffc0207426:	e119                	bnez	a0,ffffffffc020742c <stride_dequeue+0x240e>
ffffffffc0207428:	fe1fe06f          	j	ffffffffc0206408 <stride_dequeue+0x13ea>
ffffffffc020742c:	01353023          	sd	s3,0(a0)
ffffffffc0207430:	fd9fe06f          	j	ffffffffc0206408 <stride_dequeue+0x13ea>
ffffffffc0207434:	0109b503          	ld	a0,16(s3)
ffffffffc0207438:	0089bb03          	ld	s6,8(s3)
ffffffffc020743c:	85c2                	mv	a1,a6
ffffffffc020743e:	a01fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207442:	00a9b423          	sd	a0,8(s3)
ffffffffc0207446:	0169b823          	sd	s6,16(s3)
ffffffffc020744a:	010c2b03          	lw	s6,16(s8)
ffffffffc020744e:	ae050863          	beqz	a0,ffffffffc020673e <stride_dequeue+0x1720>
ffffffffc0207452:	01353023          	sd	s3,0(a0)
ffffffffc0207456:	ae8ff06f          	j	ffffffffc020673e <stride_dequeue+0x1720>
ffffffffc020745a:	89d2                	mv	s3,s4
ffffffffc020745c:	fadfe06f          	j	ffffffffc0206408 <stride_dequeue+0x13ea>
ffffffffc0207460:	89ee                	mv	s3,s11
ffffffffc0207462:	84aff06f          	j	ffffffffc02064ac <stride_dequeue+0x148e>
ffffffffc0207466:	89c2                	mv	s3,a6
ffffffffc0207468:	992ff06f          	j	ffffffffc02065fa <stride_dequeue+0x15dc>
ffffffffc020746c:	89c2                	mv	s3,a6
ffffffffc020746e:	a34ff06f          	j	ffffffffc02066a2 <stride_dequeue+0x1684>
ffffffffc0207472:	89b2                	mv	s3,a2
ffffffffc0207474:	8e2ff06f          	j	ffffffffc0206556 <stride_dequeue+0x1538>
ffffffffc0207478:	89c2                	mv	s3,a6
ffffffffc020747a:	ac4ff06f          	j	ffffffffc020673e <stride_dequeue+0x1720>
ffffffffc020747e:	01083503          	ld	a0,16(a6)
ffffffffc0207482:	85e6                	mv	a1,s9
ffffffffc0207484:	00883b03          	ld	s6,8(a6)
ffffffffc0207488:	9b7fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc020748c:	7802                	ld	a6,32(sp)
ffffffffc020748e:	01683823          	sd	s6,16(a6)
ffffffffc0207492:	00a83423          	sd	a0,8(a6)
ffffffffc0207496:	010c2b03          	lw	s6,16(s8)
ffffffffc020749a:	50050163          	beqz	a0,ffffffffc020799c <stride_dequeue+0x297e>
ffffffffc020749e:	01053023          	sd	a6,0(a0)
ffffffffc02074a2:	8cc2                	mv	s9,a6
ffffffffc02074a4:	d62ff06f          	j	ffffffffc0206a06 <stride_dequeue+0x19e8>
ffffffffc02074a8:	01083503          	ld	a0,16(a6)
ffffffffc02074ac:	85d2                	mv	a1,s4
ffffffffc02074ae:	00883b03          	ld	s6,8(a6)
ffffffffc02074b2:	98dfd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02074b6:	6862                	ld	a6,24(sp)
ffffffffc02074b8:	7602                	ld	a2,32(sp)
ffffffffc02074ba:	01683823          	sd	s6,16(a6)
ffffffffc02074be:	00a83423          	sd	a0,8(a6)
ffffffffc02074c2:	010c2b03          	lw	s6,16(s8)
ffffffffc02074c6:	4c050863          	beqz	a0,ffffffffc0207996 <stride_dequeue+0x2978>
ffffffffc02074ca:	01053023          	sd	a6,0(a0)
ffffffffc02074ce:	8a42                	mv	s4,a6
ffffffffc02074d0:	d94ff06f          	j	ffffffffc0206a64 <stride_dequeue+0x1a46>
ffffffffc02074d4:	89f2                	mv	s3,t3
ffffffffc02074d6:	bb5fe06f          	j	ffffffffc020608a <stride_dequeue+0x106c>
ffffffffc02074da:	88f2                	mv	a7,t3
ffffffffc02074dc:	e48fe06f          	j	ffffffffc0205b24 <stride_dequeue+0xb06>
ffffffffc02074e0:	89f2                	mv	s3,t3
ffffffffc02074e2:	ce3fe06f          	j	ffffffffc02061c4 <stride_dequeue+0x11a6>
ffffffffc02074e6:	89f2                	mv	s3,t3
ffffffffc02074e8:	c41fe06f          	j	ffffffffc0206128 <stride_dequeue+0x110a>
ffffffffc02074ec:	88f2                	mv	a7,t3
ffffffffc02074ee:	fe2fe06f          	j	ffffffffc0205cd0 <stride_dequeue+0xcb2>
ffffffffc02074f2:	87ce                	mv	a5,s3
ffffffffc02074f4:	ddffe06f          	j	ffffffffc02062d2 <stride_dequeue+0x12b4>
ffffffffc02074f8:	0108b503          	ld	a0,16(a7)
ffffffffc02074fc:	85ce                	mv	a1,s3
ffffffffc02074fe:	0088bb03          	ld	s6,8(a7)
ffffffffc0207502:	93dfd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207506:	7882                	ld	a7,32(sp)
ffffffffc0207508:	0168b823          	sd	s6,16(a7)
ffffffffc020750c:	00a8b423          	sd	a0,8(a7)
ffffffffc0207510:	010c2b03          	lw	s6,16(s8)
ffffffffc0207514:	42050a63          	beqz	a0,ffffffffc0207948 <stride_dequeue+0x292a>
ffffffffc0207518:	01153023          	sd	a7,0(a0)
ffffffffc020751c:	89c6                	mv	s3,a7
ffffffffc020751e:	d9cff06f          	j	ffffffffc0206aba <stride_dequeue+0x1a9c>
ffffffffc0207522:	8cf2                	mv	s9,t3
ffffffffc0207524:	84efe06f          	j	ffffffffc0205572 <stride_dequeue+0x554>
ffffffffc0207528:	8a72                	mv	s4,t3
ffffffffc020752a:	a62fe06f          	j	ffffffffc020578c <stride_dequeue+0x76e>
ffffffffc020752e:	88f2                	mv	a7,t3
ffffffffc0207530:	ed2fe06f          	j	ffffffffc0205c02 <stride_dequeue+0xbe4>
ffffffffc0207534:	89f2                	mv	s3,t3
ffffffffc0207536:	d33fe06f          	j	ffffffffc0206268 <stride_dequeue+0x124a>
ffffffffc020753a:	0109b503          	ld	a0,16(s3)
ffffffffc020753e:	0089bb03          	ld	s6,8(s3)
ffffffffc0207542:	85c6                	mv	a1,a7
ffffffffc0207544:	8fbfd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207548:	00a9b423          	sd	a0,8(s3)
ffffffffc020754c:	0169b823          	sd	s6,16(s3)
ffffffffc0207550:	010c2b03          	lw	s6,16(s8)
ffffffffc0207554:	e119                	bnez	a0,ffffffffc020755a <stride_dequeue+0x253c>
ffffffffc0207556:	dfdfe06f          	j	ffffffffc0206352 <stride_dequeue+0x1334>
ffffffffc020755a:	01353023          	sd	s3,0(a0)
ffffffffc020755e:	df5fe06f          	j	ffffffffc0206352 <stride_dequeue+0x1334>
ffffffffc0207562:	01083503          	ld	a0,16(a6)
ffffffffc0207566:	85d2                	mv	a1,s4
ffffffffc0207568:	00883b03          	ld	s6,8(a6)
ffffffffc020756c:	8d3fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207570:	7802                	ld	a6,32(sp)
ffffffffc0207572:	01683823          	sd	s6,16(a6)
ffffffffc0207576:	00a83423          	sd	a0,8(a6)
ffffffffc020757a:	010c2b03          	lw	s6,16(s8)
ffffffffc020757e:	3a050363          	beqz	a0,ffffffffc0207924 <stride_dequeue+0x2906>
ffffffffc0207582:	01053023          	sd	a6,0(a0)
ffffffffc0207586:	8a42                	mv	s4,a6
ffffffffc0207588:	c28ff06f          	j	ffffffffc02069b0 <stride_dequeue+0x1992>
ffffffffc020758c:	8672                	mv	a2,t3
ffffffffc020758e:	900fe06f          	j	ffffffffc020568e <stride_dequeue+0x670>
ffffffffc0207592:	0108b503          	ld	a0,16(a7)
ffffffffc0207596:	85ce                	mv	a1,s3
ffffffffc0207598:	0088bb03          	ld	s6,8(a7)
ffffffffc020759c:	8a3fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02075a0:	7882                	ld	a7,32(sp)
ffffffffc02075a2:	7622                	ld	a2,40(sp)
ffffffffc02075a4:	7842                	ld	a6,48(sp)
ffffffffc02075a6:	0168b823          	sd	s6,16(a7)
ffffffffc02075aa:	00a8b423          	sd	a0,8(a7)
ffffffffc02075ae:	010c2b03          	lw	s6,16(s8)
ffffffffc02075b2:	3c050c63          	beqz	a0,ffffffffc020798a <stride_dequeue+0x296c>
ffffffffc02075b6:	01153023          	sd	a7,0(a0)
ffffffffc02075ba:	89c6                	mv	s3,a7
ffffffffc02075bc:	dc0ff06f          	j	ffffffffc0206b7c <stride_dequeue+0x1b5e>
ffffffffc02075c0:	0109b503          	ld	a0,16(s3)
ffffffffc02075c4:	0089bb03          	ld	s6,8(s3)
ffffffffc02075c8:	85f2                	mv	a1,t3
ffffffffc02075ca:	f41a                	sd	t1,40(sp)
ffffffffc02075cc:	873fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02075d0:	00a9b423          	sd	a0,8(s3)
ffffffffc02075d4:	0169b823          	sd	s6,16(s3)
ffffffffc02075d8:	7322                	ld	t1,40(sp)
ffffffffc02075da:	010c2b03          	lw	s6,16(s8)
ffffffffc02075de:	e119                	bnez	a0,ffffffffc02075e4 <stride_dequeue+0x25c6>
ffffffffc02075e0:	9fdfe06f          	j	ffffffffc0205fdc <stride_dequeue+0xfbe>
ffffffffc02075e4:	01353023          	sd	s3,0(a0)
ffffffffc02075e8:	9f5fe06f          	j	ffffffffc0205fdc <stride_dequeue+0xfbe>
ffffffffc02075ec:	01033503          	ld	a0,16(t1)
ffffffffc02075f0:	85e6                	mv	a1,s9
ffffffffc02075f2:	00833b03          	ld	s6,8(t1)
ffffffffc02075f6:	849fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02075fa:	7322                	ld	t1,40(sp)
ffffffffc02075fc:	78c2                	ld	a7,48(sp)
ffffffffc02075fe:	01633823          	sd	s6,16(t1)
ffffffffc0207602:	00a33423          	sd	a0,8(t1)
ffffffffc0207606:	010c2b03          	lw	s6,16(s8)
ffffffffc020760a:	34050e63          	beqz	a0,ffffffffc0207966 <stride_dequeue+0x2948>
ffffffffc020760e:	00653023          	sd	t1,0(a0)
ffffffffc0207612:	8c9a                	mv	s9,t1
ffffffffc0207614:	eeaff06f          	j	ffffffffc0206cfe <stride_dequeue+0x1ce0>
ffffffffc0207618:	01033503          	ld	a0,16(t1)
ffffffffc020761c:	85c2                	mv	a1,a6
ffffffffc020761e:	00833b03          	ld	s6,8(t1)
ffffffffc0207622:	81dfd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207626:	7322                	ld	t1,40(sp)
ffffffffc0207628:	01633823          	sd	s6,16(t1)
ffffffffc020762c:	00a33423          	sd	a0,8(t1)
ffffffffc0207630:	010c2b03          	lw	s6,16(s8)
ffffffffc0207634:	32050c63          	beqz	a0,ffffffffc020796c <stride_dequeue+0x294e>
ffffffffc0207638:	00653023          	sd	t1,0(a0)
ffffffffc020763c:	881a                	mv	a6,t1
ffffffffc020763e:	f24ff06f          	j	ffffffffc0206d62 <stride_dequeue+0x1d44>
ffffffffc0207642:	0108b503          	ld	a0,16(a7)
ffffffffc0207646:	85ce                	mv	a1,s3
ffffffffc0207648:	0088bb03          	ld	s6,8(a7)
ffffffffc020764c:	ff2fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207650:	78a2                	ld	a7,40(sp)
ffffffffc0207652:	7842                	ld	a6,48(sp)
ffffffffc0207654:	0168b823          	sd	s6,16(a7)
ffffffffc0207658:	00a8b423          	sd	a0,8(a7)
ffffffffc020765c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207660:	30050963          	beqz	a0,ffffffffc0207972 <stride_dequeue+0x2954>
ffffffffc0207664:	01153023          	sd	a7,0(a0)
ffffffffc0207668:	89c6                	mv	s3,a7
ffffffffc020766a:	caeff06f          	j	ffffffffc0206b18 <stride_dequeue+0x1afa>
ffffffffc020766e:	01083503          	ld	a0,16(a6)
ffffffffc0207672:	85ce                	mv	a1,s3
ffffffffc0207674:	00883b03          	ld	s6,8(a6)
ffffffffc0207678:	fc6fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc020767c:	7822                	ld	a6,40(sp)
ffffffffc020767e:	78c2                	ld	a7,48(sp)
ffffffffc0207680:	01683823          	sd	s6,16(a6)
ffffffffc0207684:	00a83423          	sd	a0,8(a6)
ffffffffc0207688:	010c2b03          	lw	s6,16(s8)
ffffffffc020768c:	30050b63          	beqz	a0,ffffffffc02079a2 <stride_dequeue+0x2984>
ffffffffc0207690:	01053023          	sd	a6,0(a0)
ffffffffc0207694:	89c2                	mv	s3,a6
ffffffffc0207696:	da6ff06f          	j	ffffffffc0206c3c <stride_dequeue+0x1c1e>
ffffffffc020769a:	01083503          	ld	a0,16(a6)
ffffffffc020769e:	85ce                	mv	a1,s3
ffffffffc02076a0:	00883b03          	ld	s6,8(a6)
ffffffffc02076a4:	f9afd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02076a8:	7802                	ld	a6,32(sp)
ffffffffc02076aa:	7622                	ld	a2,40(sp)
ffffffffc02076ac:	78c2                	ld	a7,48(sp)
ffffffffc02076ae:	01683823          	sd	s6,16(a6)
ffffffffc02076b2:	00a83423          	sd	a0,8(a6)
ffffffffc02076b6:	010c2b03          	lw	s6,16(s8)
ffffffffc02076ba:	2a050063          	beqz	a0,ffffffffc020795a <stride_dequeue+0x293c>
ffffffffc02076be:	01053023          	sd	a6,0(a0)
ffffffffc02076c2:	89c2                	mv	s3,a6
ffffffffc02076c4:	ddcff06f          	j	ffffffffc0206ca0 <stride_dequeue+0x1c82>
ffffffffc02076c8:	0109b503          	ld	a0,16(s3)
ffffffffc02076cc:	0089bb03          	ld	s6,8(s3)
ffffffffc02076d0:	85f2                	mv	a1,t3
ffffffffc02076d2:	f41a                	sd	t1,40(sp)
ffffffffc02076d4:	f6afd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02076d8:	00a9b423          	sd	a0,8(s3)
ffffffffc02076dc:	0169b823          	sd	s6,16(s3)
ffffffffc02076e0:	7322                	ld	t1,40(sp)
ffffffffc02076e2:	010c2b03          	lw	s6,16(s8)
ffffffffc02076e6:	e119                	bnez	a0,ffffffffc02076ec <stride_dequeue+0x26ce>
ffffffffc02076e8:	f4afe06f          	j	ffffffffc0205e32 <stride_dequeue+0xe14>
ffffffffc02076ec:	01353023          	sd	s3,0(a0)
ffffffffc02076f0:	f42fe06f          	j	ffffffffc0205e32 <stride_dequeue+0xe14>
ffffffffc02076f4:	0109b503          	ld	a0,16(s3)
ffffffffc02076f8:	0089bb03          	ld	s6,8(s3)
ffffffffc02076fc:	85f2                	mv	a1,t3
ffffffffc02076fe:	f446                	sd	a7,40(sp)
ffffffffc0207700:	f3efd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207704:	00a9b423          	sd	a0,8(s3)
ffffffffc0207708:	0169b823          	sd	s6,16(s3)
ffffffffc020770c:	78a2                	ld	a7,40(sp)
ffffffffc020770e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207712:	e119                	bnez	a0,ffffffffc0207718 <stride_dequeue+0x26fa>
ffffffffc0207714:	ce5fe06f          	j	ffffffffc02063f8 <stride_dequeue+0x13da>
ffffffffc0207718:	01353023          	sd	s3,0(a0)
ffffffffc020771c:	cddfe06f          	j	ffffffffc02063f8 <stride_dequeue+0x13da>
ffffffffc0207720:	0109b503          	ld	a0,16(s3)
ffffffffc0207724:	0089bb03          	ld	s6,8(s3)
ffffffffc0207728:	85f2                	mv	a1,t3
ffffffffc020772a:	f446                	sd	a7,40(sp)
ffffffffc020772c:	f032                	sd	a2,32(sp)
ffffffffc020772e:	f10fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207732:	00a9b423          	sd	a0,8(s3)
ffffffffc0207736:	0169b823          	sd	s6,16(s3)
ffffffffc020773a:	7602                	ld	a2,32(sp)
ffffffffc020773c:	78a2                	ld	a7,40(sp)
ffffffffc020773e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207742:	e119                	bnez	a0,ffffffffc0207748 <stride_dequeue+0x272a>
ffffffffc0207744:	e05fe06f          	j	ffffffffc0206548 <stride_dequeue+0x152a>
ffffffffc0207748:	01353023          	sd	s3,0(a0)
ffffffffc020774c:	dfdfe06f          	j	ffffffffc0206548 <stride_dequeue+0x152a>
ffffffffc0207750:	010a3503          	ld	a0,16(s4)
ffffffffc0207754:	008a3b03          	ld	s6,8(s4)
ffffffffc0207758:	85f2                	mv	a1,t3
ffffffffc020775a:	f41a                	sd	t1,40(sp)
ffffffffc020775c:	ee2fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207760:	00aa3423          	sd	a0,8(s4)
ffffffffc0207764:	016a3823          	sd	s6,16(s4)
ffffffffc0207768:	7322                	ld	t1,40(sp)
ffffffffc020776a:	010c2b03          	lw	s6,16(s8)
ffffffffc020776e:	e119                	bnez	a0,ffffffffc0207774 <stride_dequeue+0x2756>
ffffffffc0207770:	ad6fe06f          	j	ffffffffc0205a46 <stride_dequeue+0xa28>
ffffffffc0207774:	01453023          	sd	s4,0(a0)
ffffffffc0207778:	acefe06f          	j	ffffffffc0205a46 <stride_dequeue+0xa28>
ffffffffc020777c:	0109b503          	ld	a0,16(s3)
ffffffffc0207780:	0089bb03          	ld	s6,8(s3)
ffffffffc0207784:	85f2                	mv	a1,t3
ffffffffc0207786:	f446                	sd	a7,40(sp)
ffffffffc0207788:	eb6fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc020778c:	00a9b423          	sd	a0,8(s3)
ffffffffc0207790:	0169b823          	sd	s6,16(s3)
ffffffffc0207794:	78a2                	ld	a7,40(sp)
ffffffffc0207796:	010c2b03          	lw	s6,16(s8)
ffffffffc020779a:	e119                	bnez	a0,ffffffffc02077a0 <stride_dequeue+0x2782>
ffffffffc020779c:	d01fe06f          	j	ffffffffc020649c <stride_dequeue+0x147e>
ffffffffc02077a0:	01353023          	sd	s3,0(a0)
ffffffffc02077a4:	cf9fe06f          	j	ffffffffc020649c <stride_dequeue+0x147e>
ffffffffc02077a8:	01033503          	ld	a0,16(t1)
ffffffffc02077ac:	85c2                	mv	a1,a6
ffffffffc02077ae:	00833b03          	ld	s6,8(t1)
ffffffffc02077b2:	e8cfd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02077b6:	7322                	ld	t1,40(sp)
ffffffffc02077b8:	01633823          	sd	s6,16(t1)
ffffffffc02077bc:	00a33423          	sd	a0,8(t1)
ffffffffc02077c0:	010c2b03          	lw	s6,16(s8)
ffffffffc02077c4:	1e050b63          	beqz	a0,ffffffffc02079ba <stride_dequeue+0x299c>
ffffffffc02077c8:	00653023          	sd	t1,0(a0)
ffffffffc02077cc:	881a                	mv	a6,t1
ffffffffc02077ce:	e50ff06f          	j	ffffffffc0206e1e <stride_dequeue+0x1e00>
ffffffffc02077d2:	0109b503          	ld	a0,16(s3)
ffffffffc02077d6:	0089bb03          	ld	s6,8(s3)
ffffffffc02077da:	85f2                	mv	a1,t3
ffffffffc02077dc:	f442                	sd	a6,40(sp)
ffffffffc02077de:	f032                	sd	a2,32(sp)
ffffffffc02077e0:	e5efd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02077e4:	00a9b423          	sd	a0,8(s3)
ffffffffc02077e8:	0169b823          	sd	s6,16(s3)
ffffffffc02077ec:	7602                	ld	a2,32(sp)
ffffffffc02077ee:	7822                	ld	a6,40(sp)
ffffffffc02077f0:	010c2b03          	lw	s6,16(s8)
ffffffffc02077f4:	e119                	bnez	a0,ffffffffc02077fa <stride_dequeue+0x27dc>
ffffffffc02077f6:	e9dfe06f          	j	ffffffffc0206692 <stride_dequeue+0x1674>
ffffffffc02077fa:	01353023          	sd	s3,0(a0)
ffffffffc02077fe:	e95fe06f          	j	ffffffffc0206692 <stride_dequeue+0x1674>
ffffffffc0207802:	0108b503          	ld	a0,16(a7)
ffffffffc0207806:	85ce                	mv	a1,s3
ffffffffc0207808:	0088bb03          	ld	s6,8(a7)
ffffffffc020780c:	e32fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207810:	78a2                	ld	a7,40(sp)
ffffffffc0207812:	7842                	ld	a6,48(sp)
ffffffffc0207814:	0168b823          	sd	s6,16(a7)
ffffffffc0207818:	00a8b423          	sd	a0,8(a7)
ffffffffc020781c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207820:	0e050f63          	beqz	a0,ffffffffc020791e <stride_dequeue+0x2900>
ffffffffc0207824:	01153023          	sd	a7,0(a0)
ffffffffc0207828:	89c6                	mv	s3,a7
ffffffffc020782a:	d96ff06f          	j	ffffffffc0206dc0 <stride_dequeue+0x1da2>
ffffffffc020782e:	01083503          	ld	a0,16(a6)
ffffffffc0207832:	85ce                	mv	a1,s3
ffffffffc0207834:	00883b03          	ld	s6,8(a6)
ffffffffc0207838:	e06fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc020783c:	7822                	ld	a6,40(sp)
ffffffffc020783e:	78c2                	ld	a7,48(sp)
ffffffffc0207840:	01683823          	sd	s6,16(a6)
ffffffffc0207844:	00a83423          	sd	a0,8(a6)
ffffffffc0207848:	010c2b03          	lw	s6,16(s8)
ffffffffc020784c:	0e050b63          	beqz	a0,ffffffffc0207942 <stride_dequeue+0x2924>
ffffffffc0207850:	01053023          	sd	a6,0(a0)
ffffffffc0207854:	89c2                	mv	s3,a6
ffffffffc0207856:	b88ff06f          	j	ffffffffc0206bde <stride_dequeue+0x1bc0>
ffffffffc020785a:	0109b503          	ld	a0,16(s3)
ffffffffc020785e:	0089bb03          	ld	s6,8(s3)
ffffffffc0207862:	85f2                	mv	a1,t3
ffffffffc0207864:	f442                	sd	a6,40(sp)
ffffffffc0207866:	dd8fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc020786a:	00a9b423          	sd	a0,8(s3)
ffffffffc020786e:	0169b823          	sd	s6,16(s3)
ffffffffc0207872:	7822                	ld	a6,40(sp)
ffffffffc0207874:	010c2b03          	lw	s6,16(s8)
ffffffffc0207878:	e119                	bnez	a0,ffffffffc020787e <stride_dequeue+0x2860>
ffffffffc020787a:	d71fe06f          	j	ffffffffc02065ea <stride_dequeue+0x15cc>
ffffffffc020787e:	01353023          	sd	s3,0(a0)
ffffffffc0207882:	d69fe06f          	j	ffffffffc02065ea <stride_dequeue+0x15cc>
ffffffffc0207886:	0109b503          	ld	a0,16(s3)
ffffffffc020788a:	0089bb03          	ld	s6,8(s3)
ffffffffc020788e:	85f2                	mv	a1,t3
ffffffffc0207890:	f442                	sd	a6,40(sp)
ffffffffc0207892:	dacfd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc0207896:	00a9b423          	sd	a0,8(s3)
ffffffffc020789a:	0169b823          	sd	s6,16(s3)
ffffffffc020789e:	7822                	ld	a6,40(sp)
ffffffffc02078a0:	010c2b03          	lw	s6,16(s8)
ffffffffc02078a4:	e119                	bnez	a0,ffffffffc02078aa <stride_dequeue+0x288c>
ffffffffc02078a6:	e89fe06f          	j	ffffffffc020672e <stride_dequeue+0x1710>
ffffffffc02078aa:	01353023          	sd	s3,0(a0)
ffffffffc02078ae:	e81fe06f          	j	ffffffffc020672e <stride_dequeue+0x1710>
ffffffffc02078b2:	89c6                	mv	s3,a7
ffffffffc02078b4:	a9ffe06f          	j	ffffffffc0206352 <stride_dequeue+0x1334>
ffffffffc02078b8:	0109b503          	ld	a0,16(s3)
ffffffffc02078bc:	0089bb03          	ld	s6,8(s3)
ffffffffc02078c0:	85f2                	mv	a1,t3
ffffffffc02078c2:	f41a                	sd	t1,40(sp)
ffffffffc02078c4:	f032                	sd	a2,32(sp)
ffffffffc02078c6:	d78fd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02078ca:	00a9b423          	sd	a0,8(s3)
ffffffffc02078ce:	0169b823          	sd	s6,16(s3)
ffffffffc02078d2:	7602                	ld	a2,32(sp)
ffffffffc02078d4:	7322                	ld	t1,40(sp)
ffffffffc02078d6:	010c2b03          	lw	s6,16(s8)
ffffffffc02078da:	e119                	bnez	a0,ffffffffc02078e0 <stride_dequeue+0x28c2>
ffffffffc02078dc:	e32fe06f          	j	ffffffffc0205f0e <stride_dequeue+0xef0>
ffffffffc02078e0:	01353023          	sd	s3,0(a0)
ffffffffc02078e4:	e2afe06f          	j	ffffffffc0205f0e <stride_dequeue+0xef0>
ffffffffc02078e8:	01033503          	ld	a0,16(t1)
ffffffffc02078ec:	85c2                	mv	a1,a6
ffffffffc02078ee:	00833b03          	ld	s6,8(t1)
ffffffffc02078f2:	d4cfd0ef          	jal	ra,ffffffffc0204e3e <skew_heap_merge.constprop.0>
ffffffffc02078f6:	7302                	ld	t1,32(sp)
ffffffffc02078f8:	7622                	ld	a2,40(sp)
ffffffffc02078fa:	01633823          	sd	s6,16(t1)
ffffffffc02078fe:	00a33423          	sd	a0,8(t1)
ffffffffc0207902:	010c2b03          	lw	s6,16(s8)
ffffffffc0207906:	c115                	beqz	a0,ffffffffc020792a <stride_dequeue+0x290c>
ffffffffc0207908:	00653023          	sd	t1,0(a0)
ffffffffc020790c:	881a                	mv	a6,t1
ffffffffc020790e:	d76ff06f          	j	ffffffffc0206e84 <stride_dequeue+0x1e66>
ffffffffc0207912:	89f2                	mv	s3,t3
ffffffffc0207914:	e1bfe06f          	j	ffffffffc020672e <stride_dequeue+0x1710>
ffffffffc0207918:	834e                	mv	t1,s3
ffffffffc020791a:	ef1fe06f          	j	ffffffffc020680a <stride_dequeue+0x17ec>
ffffffffc020791e:	89c6                	mv	s3,a7
ffffffffc0207920:	ca0ff06f          	j	ffffffffc0206dc0 <stride_dequeue+0x1da2>
ffffffffc0207924:	8a42                	mv	s4,a6
ffffffffc0207926:	88aff06f          	j	ffffffffc02069b0 <stride_dequeue+0x1992>
ffffffffc020792a:	881a                	mv	a6,t1
ffffffffc020792c:	d58ff06f          	j	ffffffffc0206e84 <stride_dequeue+0x1e66>
ffffffffc0207930:	89f2                	mv	s3,t3
ffffffffc0207932:	ddcfe06f          	j	ffffffffc0205f0e <stride_dequeue+0xef0>
ffffffffc0207936:	834e                	mv	t1,s3
ffffffffc0207938:	e69fe06f          	j	ffffffffc02067a0 <stride_dequeue+0x1782>
ffffffffc020793c:	89f2                	mv	s3,t3
ffffffffc020793e:	cadfe06f          	j	ffffffffc02065ea <stride_dequeue+0x15cc>
ffffffffc0207942:	89c2                	mv	s3,a6
ffffffffc0207944:	a9aff06f          	j	ffffffffc0206bde <stride_dequeue+0x1bc0>
ffffffffc0207948:	89c6                	mv	s3,a7
ffffffffc020794a:	970ff06f          	j	ffffffffc0206aba <stride_dequeue+0x1a9c>
ffffffffc020794e:	834e                	mv	t1,s3
ffffffffc0207950:	fdffe06f          	j	ffffffffc020692e <stride_dequeue+0x1910>
ffffffffc0207954:	89f2                	mv	s3,t3
ffffffffc0207956:	cdcfe06f          	j	ffffffffc0205e32 <stride_dequeue+0xe14>
ffffffffc020795a:	89c2                	mv	s3,a6
ffffffffc020795c:	b44ff06f          	j	ffffffffc0206ca0 <stride_dequeue+0x1c82>
ffffffffc0207960:	884e                	mv	a6,s3
ffffffffc0207962:	f09fe06f          	j	ffffffffc020686a <stride_dequeue+0x184c>
ffffffffc0207966:	8c9a                	mv	s9,t1
ffffffffc0207968:	b96ff06f          	j	ffffffffc0206cfe <stride_dequeue+0x1ce0>
ffffffffc020796c:	881a                	mv	a6,t1
ffffffffc020796e:	bf4ff06f          	j	ffffffffc0206d62 <stride_dequeue+0x1d44>
ffffffffc0207972:	89c6                	mv	s3,a7
ffffffffc0207974:	9a4ff06f          	j	ffffffffc0206b18 <stride_dequeue+0x1afa>
ffffffffc0207978:	89f2                	mv	s3,t3
ffffffffc020797a:	a7ffe06f          	j	ffffffffc02063f8 <stride_dequeue+0x13da>
ffffffffc020797e:	89f2                	mv	s3,t3
ffffffffc0207980:	bc9fe06f          	j	ffffffffc0206548 <stride_dequeue+0x152a>
ffffffffc0207984:	89f2                	mv	s3,t3
ffffffffc0207986:	e56fe06f          	j	ffffffffc0205fdc <stride_dequeue+0xfbe>
ffffffffc020798a:	89c6                	mv	s3,a7
ffffffffc020798c:	9f0ff06f          	j	ffffffffc0206b7c <stride_dequeue+0x1b5e>
ffffffffc0207990:	834e                	mv	t1,s3
ffffffffc0207992:	f3dfe06f          	j	ffffffffc02068ce <stride_dequeue+0x18b0>
ffffffffc0207996:	8a42                	mv	s4,a6
ffffffffc0207998:	8ccff06f          	j	ffffffffc0206a64 <stride_dequeue+0x1a46>
ffffffffc020799c:	8cc2                	mv	s9,a6
ffffffffc020799e:	868ff06f          	j	ffffffffc0206a06 <stride_dequeue+0x19e8>
ffffffffc02079a2:	89c2                	mv	s3,a6
ffffffffc02079a4:	a98ff06f          	j	ffffffffc0206c3c <stride_dequeue+0x1c1e>
ffffffffc02079a8:	8a72                	mv	s4,t3
ffffffffc02079aa:	89cfe06f          	j	ffffffffc0205a46 <stride_dequeue+0xa28>
ffffffffc02079ae:	89f2                	mv	s3,t3
ffffffffc02079b0:	aedfe06f          	j	ffffffffc020649c <stride_dequeue+0x147e>
ffffffffc02079b4:	89f2                	mv	s3,t3
ffffffffc02079b6:	cddfe06f          	j	ffffffffc0206692 <stride_dequeue+0x1674>
ffffffffc02079ba:	881a                	mv	a6,t1
ffffffffc02079bc:	c62ff06f          	j	ffffffffc0206e1e <stride_dequeue+0x1e00>

ffffffffc02079c0 <sys_getpid>:
ffffffffc02079c0:	00012797          	auipc	a5,0x12
ffffffffc02079c4:	b387b783          	ld	a5,-1224(a5) # ffffffffc02194f8 <current>
ffffffffc02079c8:	43c8                	lw	a0,4(a5)
ffffffffc02079ca:	8082                	ret

ffffffffc02079cc <sys_pgdir>:
ffffffffc02079cc:	4501                	li	a0,0
ffffffffc02079ce:	8082                	ret

ffffffffc02079d0 <sys_gettime>:
ffffffffc02079d0:	00012797          	auipc	a5,0x12
ffffffffc02079d4:	b587b783          	ld	a5,-1192(a5) # ffffffffc0219528 <ticks>
ffffffffc02079d8:	0027951b          	slliw	a0,a5,0x2
ffffffffc02079dc:	9d3d                	addw	a0,a0,a5
ffffffffc02079de:	0015151b          	slliw	a0,a0,0x1
ffffffffc02079e2:	8082                	ret

ffffffffc02079e4 <sys_lab6_set_priority>:
ffffffffc02079e4:	4108                	lw	a0,0(a0)
ffffffffc02079e6:	1141                	addi	sp,sp,-16
ffffffffc02079e8:	e406                	sd	ra,8(sp)
ffffffffc02079ea:	ee5fc0ef          	jal	ra,ffffffffc02048ce <lab6_set_priority>
ffffffffc02079ee:	60a2                	ld	ra,8(sp)
ffffffffc02079f0:	4501                	li	a0,0
ffffffffc02079f2:	0141                	addi	sp,sp,16
ffffffffc02079f4:	8082                	ret

ffffffffc02079f6 <sys_putc>:
ffffffffc02079f6:	4108                	lw	a0,0(a0)
ffffffffc02079f8:	1141                	addi	sp,sp,-16
ffffffffc02079fa:	e406                	sd	ra,8(sp)
ffffffffc02079fc:	f06f80ef          	jal	ra,ffffffffc0200102 <cputchar>
ffffffffc0207a00:	60a2                	ld	ra,8(sp)
ffffffffc0207a02:	4501                	li	a0,0
ffffffffc0207a04:	0141                	addi	sp,sp,16
ffffffffc0207a06:	8082                	ret

ffffffffc0207a08 <sys_kill>:
ffffffffc0207a08:	4108                	lw	a0,0(a0)
ffffffffc0207a0a:	d2dfc06f          	j	ffffffffc0204736 <do_kill>

ffffffffc0207a0e <sys_sleep>:
ffffffffc0207a0e:	4108                	lw	a0,0(a0)
ffffffffc0207a10:	ef9fc06f          	j	ffffffffc0204908 <do_sleep>

ffffffffc0207a14 <sys_yield>:
ffffffffc0207a14:	cd5fc06f          	j	ffffffffc02046e8 <do_yield>

ffffffffc0207a18 <sys_exec>:
ffffffffc0207a18:	6d14                	ld	a3,24(a0)
ffffffffc0207a1a:	6910                	ld	a2,16(a0)
ffffffffc0207a1c:	650c                	ld	a1,8(a0)
ffffffffc0207a1e:	6108                	ld	a0,0(a0)
ffffffffc0207a20:	f3efc06f          	j	ffffffffc020415e <do_execve>

ffffffffc0207a24 <sys_wait>:
ffffffffc0207a24:	650c                	ld	a1,8(a0)
ffffffffc0207a26:	4108                	lw	a0,0(a0)
ffffffffc0207a28:	cd1fc06f          	j	ffffffffc02046f8 <do_wait>

ffffffffc0207a2c <sys_fork>:
ffffffffc0207a2c:	00012797          	auipc	a5,0x12
ffffffffc0207a30:	acc7b783          	ld	a5,-1332(a5) # ffffffffc02194f8 <current>
ffffffffc0207a34:	73d0                	ld	a2,160(a5)
ffffffffc0207a36:	4501                	li	a0,0
ffffffffc0207a38:	6a0c                	ld	a1,16(a2)
ffffffffc0207a3a:	ebbfb06f          	j	ffffffffc02038f4 <do_fork>

ffffffffc0207a3e <sys_exit>:
ffffffffc0207a3e:	4108                	lw	a0,0(a0)
ffffffffc0207a40:	ad6fc06f          	j	ffffffffc0203d16 <do_exit>

ffffffffc0207a44 <syscall>:
ffffffffc0207a44:	715d                	addi	sp,sp,-80
ffffffffc0207a46:	fc26                	sd	s1,56(sp)
ffffffffc0207a48:	00012497          	auipc	s1,0x12
ffffffffc0207a4c:	ab048493          	addi	s1,s1,-1360 # ffffffffc02194f8 <current>
ffffffffc0207a50:	6098                	ld	a4,0(s1)
ffffffffc0207a52:	e0a2                	sd	s0,64(sp)
ffffffffc0207a54:	f84a                	sd	s2,48(sp)
ffffffffc0207a56:	7340                	ld	s0,160(a4)
ffffffffc0207a58:	e486                	sd	ra,72(sp)
ffffffffc0207a5a:	0ff00793          	li	a5,255
ffffffffc0207a5e:	05042903          	lw	s2,80(s0)
ffffffffc0207a62:	0327ee63          	bltu	a5,s2,ffffffffc0207a9e <syscall+0x5a>
ffffffffc0207a66:	00391713          	slli	a4,s2,0x3
ffffffffc0207a6a:	00002797          	auipc	a5,0x2
ffffffffc0207a6e:	01e78793          	addi	a5,a5,30 # ffffffffc0209a88 <syscalls>
ffffffffc0207a72:	97ba                	add	a5,a5,a4
ffffffffc0207a74:	639c                	ld	a5,0(a5)
ffffffffc0207a76:	c785                	beqz	a5,ffffffffc0207a9e <syscall+0x5a>
ffffffffc0207a78:	6c28                	ld	a0,88(s0)
ffffffffc0207a7a:	702c                	ld	a1,96(s0)
ffffffffc0207a7c:	7430                	ld	a2,104(s0)
ffffffffc0207a7e:	7834                	ld	a3,112(s0)
ffffffffc0207a80:	7c38                	ld	a4,120(s0)
ffffffffc0207a82:	e42a                	sd	a0,8(sp)
ffffffffc0207a84:	e82e                	sd	a1,16(sp)
ffffffffc0207a86:	ec32                	sd	a2,24(sp)
ffffffffc0207a88:	f036                	sd	a3,32(sp)
ffffffffc0207a8a:	f43a                	sd	a4,40(sp)
ffffffffc0207a8c:	0028                	addi	a0,sp,8
ffffffffc0207a8e:	9782                	jalr	a5
ffffffffc0207a90:	60a6                	ld	ra,72(sp)
ffffffffc0207a92:	e828                	sd	a0,80(s0)
ffffffffc0207a94:	6406                	ld	s0,64(sp)
ffffffffc0207a96:	74e2                	ld	s1,56(sp)
ffffffffc0207a98:	7942                	ld	s2,48(sp)
ffffffffc0207a9a:	6161                	addi	sp,sp,80
ffffffffc0207a9c:	8082                	ret
ffffffffc0207a9e:	8522                	mv	a0,s0
ffffffffc0207aa0:	d87f80ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0207aa4:	609c                	ld	a5,0(s1)
ffffffffc0207aa6:	86ca                	mv	a3,s2
ffffffffc0207aa8:	00002617          	auipc	a2,0x2
ffffffffc0207aac:	f9860613          	addi	a2,a2,-104 # ffffffffc0209a40 <default_pmm_manager+0x708>
ffffffffc0207ab0:	43d8                	lw	a4,4(a5)
ffffffffc0207ab2:	07300593          	li	a1,115
ffffffffc0207ab6:	0b478793          	addi	a5,a5,180
ffffffffc0207aba:	00002517          	auipc	a0,0x2
ffffffffc0207abe:	fb650513          	addi	a0,a0,-74 # ffffffffc0209a70 <default_pmm_manager+0x738>
ffffffffc0207ac2:	f46f80ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0207ac6 <strnlen>:
ffffffffc0207ac6:	872a                	mv	a4,a0
ffffffffc0207ac8:	4501                	li	a0,0
ffffffffc0207aca:	e589                	bnez	a1,ffffffffc0207ad4 <strnlen+0xe>
ffffffffc0207acc:	a811                	j	ffffffffc0207ae0 <strnlen+0x1a>
ffffffffc0207ace:	0505                	addi	a0,a0,1
ffffffffc0207ad0:	00a58763          	beq	a1,a0,ffffffffc0207ade <strnlen+0x18>
ffffffffc0207ad4:	00a707b3          	add	a5,a4,a0
ffffffffc0207ad8:	0007c783          	lbu	a5,0(a5)
ffffffffc0207adc:	fbed                	bnez	a5,ffffffffc0207ace <strnlen+0x8>
ffffffffc0207ade:	8082                	ret
ffffffffc0207ae0:	8082                	ret

ffffffffc0207ae2 <strcmp>:
ffffffffc0207ae2:	00054783          	lbu	a5,0(a0)
ffffffffc0207ae6:	0005c703          	lbu	a4,0(a1)
ffffffffc0207aea:	cb89                	beqz	a5,ffffffffc0207afc <strcmp+0x1a>
ffffffffc0207aec:	0505                	addi	a0,a0,1
ffffffffc0207aee:	0585                	addi	a1,a1,1
ffffffffc0207af0:	fee789e3          	beq	a5,a4,ffffffffc0207ae2 <strcmp>
ffffffffc0207af4:	0007851b          	sext.w	a0,a5
ffffffffc0207af8:	9d19                	subw	a0,a0,a4
ffffffffc0207afa:	8082                	ret
ffffffffc0207afc:	4501                	li	a0,0
ffffffffc0207afe:	bfed                	j	ffffffffc0207af8 <strcmp+0x16>

ffffffffc0207b00 <strchr>:
ffffffffc0207b00:	00054783          	lbu	a5,0(a0)
ffffffffc0207b04:	c799                	beqz	a5,ffffffffc0207b12 <strchr+0x12>
ffffffffc0207b06:	00f58763          	beq	a1,a5,ffffffffc0207b14 <strchr+0x14>
ffffffffc0207b0a:	00154783          	lbu	a5,1(a0)
ffffffffc0207b0e:	0505                	addi	a0,a0,1
ffffffffc0207b10:	fbfd                	bnez	a5,ffffffffc0207b06 <strchr+0x6>
ffffffffc0207b12:	4501                	li	a0,0
ffffffffc0207b14:	8082                	ret

ffffffffc0207b16 <memset>:
ffffffffc0207b16:	ca01                	beqz	a2,ffffffffc0207b26 <memset+0x10>
ffffffffc0207b18:	962a                	add	a2,a2,a0
ffffffffc0207b1a:	87aa                	mv	a5,a0
ffffffffc0207b1c:	0785                	addi	a5,a5,1
ffffffffc0207b1e:	feb78fa3          	sb	a1,-1(a5)
ffffffffc0207b22:	fec79de3          	bne	a5,a2,ffffffffc0207b1c <memset+0x6>
ffffffffc0207b26:	8082                	ret

ffffffffc0207b28 <memcpy>:
ffffffffc0207b28:	ca19                	beqz	a2,ffffffffc0207b3e <memcpy+0x16>
ffffffffc0207b2a:	962e                	add	a2,a2,a1
ffffffffc0207b2c:	87aa                	mv	a5,a0
ffffffffc0207b2e:	0005c703          	lbu	a4,0(a1)
ffffffffc0207b32:	0585                	addi	a1,a1,1
ffffffffc0207b34:	0785                	addi	a5,a5,1
ffffffffc0207b36:	fee78fa3          	sb	a4,-1(a5)
ffffffffc0207b3a:	fec59ae3          	bne	a1,a2,ffffffffc0207b2e <memcpy+0x6>
ffffffffc0207b3e:	8082                	ret

ffffffffc0207b40 <printnum>:
ffffffffc0207b40:	02069813          	slli	a6,a3,0x20
ffffffffc0207b44:	7179                	addi	sp,sp,-48
ffffffffc0207b46:	02085813          	srli	a6,a6,0x20
ffffffffc0207b4a:	e052                	sd	s4,0(sp)
ffffffffc0207b4c:	03067a33          	remu	s4,a2,a6
ffffffffc0207b50:	f022                	sd	s0,32(sp)
ffffffffc0207b52:	ec26                	sd	s1,24(sp)
ffffffffc0207b54:	e84a                	sd	s2,16(sp)
ffffffffc0207b56:	f406                	sd	ra,40(sp)
ffffffffc0207b58:	e44e                	sd	s3,8(sp)
ffffffffc0207b5a:	84aa                	mv	s1,a0
ffffffffc0207b5c:	892e                	mv	s2,a1
ffffffffc0207b5e:	fff7041b          	addiw	s0,a4,-1
ffffffffc0207b62:	2a01                	sext.w	s4,s4
ffffffffc0207b64:	03067e63          	bgeu	a2,a6,ffffffffc0207ba0 <printnum+0x60>
ffffffffc0207b68:	89be                	mv	s3,a5
ffffffffc0207b6a:	00805763          	blez	s0,ffffffffc0207b78 <printnum+0x38>
ffffffffc0207b6e:	347d                	addiw	s0,s0,-1
ffffffffc0207b70:	85ca                	mv	a1,s2
ffffffffc0207b72:	854e                	mv	a0,s3
ffffffffc0207b74:	9482                	jalr	s1
ffffffffc0207b76:	fc65                	bnez	s0,ffffffffc0207b6e <printnum+0x2e>
ffffffffc0207b78:	1a02                	slli	s4,s4,0x20
ffffffffc0207b7a:	020a5a13          	srli	s4,s4,0x20
ffffffffc0207b7e:	00002797          	auipc	a5,0x2
ffffffffc0207b82:	70a78793          	addi	a5,a5,1802 # ffffffffc020a288 <syscalls+0x800>
ffffffffc0207b86:	7402                	ld	s0,32(sp)
ffffffffc0207b88:	9a3e                	add	s4,s4,a5
ffffffffc0207b8a:	000a4503          	lbu	a0,0(s4)
ffffffffc0207b8e:	70a2                	ld	ra,40(sp)
ffffffffc0207b90:	69a2                	ld	s3,8(sp)
ffffffffc0207b92:	6a02                	ld	s4,0(sp)
ffffffffc0207b94:	85ca                	mv	a1,s2
ffffffffc0207b96:	8326                	mv	t1,s1
ffffffffc0207b98:	6942                	ld	s2,16(sp)
ffffffffc0207b9a:	64e2                	ld	s1,24(sp)
ffffffffc0207b9c:	6145                	addi	sp,sp,48
ffffffffc0207b9e:	8302                	jr	t1
ffffffffc0207ba0:	03065633          	divu	a2,a2,a6
ffffffffc0207ba4:	8722                	mv	a4,s0
ffffffffc0207ba6:	f9bff0ef          	jal	ra,ffffffffc0207b40 <printnum>
ffffffffc0207baa:	b7f9                	j	ffffffffc0207b78 <printnum+0x38>

ffffffffc0207bac <vprintfmt>:
ffffffffc0207bac:	7119                	addi	sp,sp,-128
ffffffffc0207bae:	f4a6                	sd	s1,104(sp)
ffffffffc0207bb0:	f0ca                	sd	s2,96(sp)
ffffffffc0207bb2:	ecce                	sd	s3,88(sp)
ffffffffc0207bb4:	e8d2                	sd	s4,80(sp)
ffffffffc0207bb6:	e4d6                	sd	s5,72(sp)
ffffffffc0207bb8:	e0da                	sd	s6,64(sp)
ffffffffc0207bba:	fc5e                	sd	s7,56(sp)
ffffffffc0207bbc:	f06a                	sd	s10,32(sp)
ffffffffc0207bbe:	fc86                	sd	ra,120(sp)
ffffffffc0207bc0:	f8a2                	sd	s0,112(sp)
ffffffffc0207bc2:	f862                	sd	s8,48(sp)
ffffffffc0207bc4:	f466                	sd	s9,40(sp)
ffffffffc0207bc6:	ec6e                	sd	s11,24(sp)
ffffffffc0207bc8:	892a                	mv	s2,a0
ffffffffc0207bca:	84ae                	mv	s1,a1
ffffffffc0207bcc:	8d32                	mv	s10,a2
ffffffffc0207bce:	8a36                	mv	s4,a3
ffffffffc0207bd0:	02500993          	li	s3,37
ffffffffc0207bd4:	5b7d                	li	s6,-1
ffffffffc0207bd6:	00002a97          	auipc	s5,0x2
ffffffffc0207bda:	6dea8a93          	addi	s5,s5,1758 # ffffffffc020a2b4 <syscalls+0x82c>
ffffffffc0207bde:	00003b97          	auipc	s7,0x3
ffffffffc0207be2:	8f2b8b93          	addi	s7,s7,-1806 # ffffffffc020a4d0 <error_string>
ffffffffc0207be6:	000d4503          	lbu	a0,0(s10)
ffffffffc0207bea:	001d0413          	addi	s0,s10,1
ffffffffc0207bee:	01350a63          	beq	a0,s3,ffffffffc0207c02 <vprintfmt+0x56>
ffffffffc0207bf2:	c121                	beqz	a0,ffffffffc0207c32 <vprintfmt+0x86>
ffffffffc0207bf4:	85a6                	mv	a1,s1
ffffffffc0207bf6:	0405                	addi	s0,s0,1
ffffffffc0207bf8:	9902                	jalr	s2
ffffffffc0207bfa:	fff44503          	lbu	a0,-1(s0)
ffffffffc0207bfe:	ff351ae3          	bne	a0,s3,ffffffffc0207bf2 <vprintfmt+0x46>
ffffffffc0207c02:	00044603          	lbu	a2,0(s0)
ffffffffc0207c06:	02000793          	li	a5,32
ffffffffc0207c0a:	4c81                	li	s9,0
ffffffffc0207c0c:	4881                	li	a7,0
ffffffffc0207c0e:	5c7d                	li	s8,-1
ffffffffc0207c10:	5dfd                	li	s11,-1
ffffffffc0207c12:	05500513          	li	a0,85
ffffffffc0207c16:	4825                	li	a6,9
ffffffffc0207c18:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0207c1c:	0ff5f593          	andi	a1,a1,255
ffffffffc0207c20:	00140d13          	addi	s10,s0,1
ffffffffc0207c24:	04b56263          	bltu	a0,a1,ffffffffc0207c68 <vprintfmt+0xbc>
ffffffffc0207c28:	058a                	slli	a1,a1,0x2
ffffffffc0207c2a:	95d6                	add	a1,a1,s5
ffffffffc0207c2c:	4194                	lw	a3,0(a1)
ffffffffc0207c2e:	96d6                	add	a3,a3,s5
ffffffffc0207c30:	8682                	jr	a3
ffffffffc0207c32:	70e6                	ld	ra,120(sp)
ffffffffc0207c34:	7446                	ld	s0,112(sp)
ffffffffc0207c36:	74a6                	ld	s1,104(sp)
ffffffffc0207c38:	7906                	ld	s2,96(sp)
ffffffffc0207c3a:	69e6                	ld	s3,88(sp)
ffffffffc0207c3c:	6a46                	ld	s4,80(sp)
ffffffffc0207c3e:	6aa6                	ld	s5,72(sp)
ffffffffc0207c40:	6b06                	ld	s6,64(sp)
ffffffffc0207c42:	7be2                	ld	s7,56(sp)
ffffffffc0207c44:	7c42                	ld	s8,48(sp)
ffffffffc0207c46:	7ca2                	ld	s9,40(sp)
ffffffffc0207c48:	7d02                	ld	s10,32(sp)
ffffffffc0207c4a:	6de2                	ld	s11,24(sp)
ffffffffc0207c4c:	6109                	addi	sp,sp,128
ffffffffc0207c4e:	8082                	ret
ffffffffc0207c50:	87b2                	mv	a5,a2
ffffffffc0207c52:	00144603          	lbu	a2,1(s0)
ffffffffc0207c56:	846a                	mv	s0,s10
ffffffffc0207c58:	00140d13          	addi	s10,s0,1
ffffffffc0207c5c:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0207c60:	0ff5f593          	andi	a1,a1,255
ffffffffc0207c64:	fcb572e3          	bgeu	a0,a1,ffffffffc0207c28 <vprintfmt+0x7c>
ffffffffc0207c68:	85a6                	mv	a1,s1
ffffffffc0207c6a:	02500513          	li	a0,37
ffffffffc0207c6e:	9902                	jalr	s2
ffffffffc0207c70:	fff44783          	lbu	a5,-1(s0)
ffffffffc0207c74:	8d22                	mv	s10,s0
ffffffffc0207c76:	f73788e3          	beq	a5,s3,ffffffffc0207be6 <vprintfmt+0x3a>
ffffffffc0207c7a:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0207c7e:	1d7d                	addi	s10,s10,-1
ffffffffc0207c80:	ff379de3          	bne	a5,s3,ffffffffc0207c7a <vprintfmt+0xce>
ffffffffc0207c84:	b78d                	j	ffffffffc0207be6 <vprintfmt+0x3a>
ffffffffc0207c86:	fd060c1b          	addiw	s8,a2,-48
ffffffffc0207c8a:	00144603          	lbu	a2,1(s0)
ffffffffc0207c8e:	846a                	mv	s0,s10
ffffffffc0207c90:	fd06069b          	addiw	a3,a2,-48
ffffffffc0207c94:	0006059b          	sext.w	a1,a2
ffffffffc0207c98:	02d86463          	bltu	a6,a3,ffffffffc0207cc0 <vprintfmt+0x114>
ffffffffc0207c9c:	00144603          	lbu	a2,1(s0)
ffffffffc0207ca0:	002c169b          	slliw	a3,s8,0x2
ffffffffc0207ca4:	0186873b          	addw	a4,a3,s8
ffffffffc0207ca8:	0017171b          	slliw	a4,a4,0x1
ffffffffc0207cac:	9f2d                	addw	a4,a4,a1
ffffffffc0207cae:	fd06069b          	addiw	a3,a2,-48
ffffffffc0207cb2:	0405                	addi	s0,s0,1
ffffffffc0207cb4:	fd070c1b          	addiw	s8,a4,-48
ffffffffc0207cb8:	0006059b          	sext.w	a1,a2
ffffffffc0207cbc:	fed870e3          	bgeu	a6,a3,ffffffffc0207c9c <vprintfmt+0xf0>
ffffffffc0207cc0:	f40ddce3          	bgez	s11,ffffffffc0207c18 <vprintfmt+0x6c>
ffffffffc0207cc4:	8de2                	mv	s11,s8
ffffffffc0207cc6:	5c7d                	li	s8,-1
ffffffffc0207cc8:	bf81                	j	ffffffffc0207c18 <vprintfmt+0x6c>
ffffffffc0207cca:	fffdc693          	not	a3,s11
ffffffffc0207cce:	96fd                	srai	a3,a3,0x3f
ffffffffc0207cd0:	00ddfdb3          	and	s11,s11,a3
ffffffffc0207cd4:	00144603          	lbu	a2,1(s0)
ffffffffc0207cd8:	2d81                	sext.w	s11,s11
ffffffffc0207cda:	846a                	mv	s0,s10
ffffffffc0207cdc:	bf35                	j	ffffffffc0207c18 <vprintfmt+0x6c>
ffffffffc0207cde:	000a2c03          	lw	s8,0(s4)
ffffffffc0207ce2:	00144603          	lbu	a2,1(s0)
ffffffffc0207ce6:	0a21                	addi	s4,s4,8
ffffffffc0207ce8:	846a                	mv	s0,s10
ffffffffc0207cea:	bfd9                	j	ffffffffc0207cc0 <vprintfmt+0x114>
ffffffffc0207cec:	4705                	li	a4,1
ffffffffc0207cee:	008a0593          	addi	a1,s4,8
ffffffffc0207cf2:	01174463          	blt	a4,a7,ffffffffc0207cfa <vprintfmt+0x14e>
ffffffffc0207cf6:	1a088e63          	beqz	a7,ffffffffc0207eb2 <vprintfmt+0x306>
ffffffffc0207cfa:	000a3603          	ld	a2,0(s4)
ffffffffc0207cfe:	46c1                	li	a3,16
ffffffffc0207d00:	8a2e                	mv	s4,a1
ffffffffc0207d02:	2781                	sext.w	a5,a5
ffffffffc0207d04:	876e                	mv	a4,s11
ffffffffc0207d06:	85a6                	mv	a1,s1
ffffffffc0207d08:	854a                	mv	a0,s2
ffffffffc0207d0a:	e37ff0ef          	jal	ra,ffffffffc0207b40 <printnum>
ffffffffc0207d0e:	bde1                	j	ffffffffc0207be6 <vprintfmt+0x3a>
ffffffffc0207d10:	000a2503          	lw	a0,0(s4)
ffffffffc0207d14:	85a6                	mv	a1,s1
ffffffffc0207d16:	0a21                	addi	s4,s4,8
ffffffffc0207d18:	9902                	jalr	s2
ffffffffc0207d1a:	b5f1                	j	ffffffffc0207be6 <vprintfmt+0x3a>
ffffffffc0207d1c:	4705                	li	a4,1
ffffffffc0207d1e:	008a0593          	addi	a1,s4,8
ffffffffc0207d22:	01174463          	blt	a4,a7,ffffffffc0207d2a <vprintfmt+0x17e>
ffffffffc0207d26:	18088163          	beqz	a7,ffffffffc0207ea8 <vprintfmt+0x2fc>
ffffffffc0207d2a:	000a3603          	ld	a2,0(s4)
ffffffffc0207d2e:	46a9                	li	a3,10
ffffffffc0207d30:	8a2e                	mv	s4,a1
ffffffffc0207d32:	bfc1                	j	ffffffffc0207d02 <vprintfmt+0x156>
ffffffffc0207d34:	00144603          	lbu	a2,1(s0)
ffffffffc0207d38:	4c85                	li	s9,1
ffffffffc0207d3a:	846a                	mv	s0,s10
ffffffffc0207d3c:	bdf1                	j	ffffffffc0207c18 <vprintfmt+0x6c>
ffffffffc0207d3e:	85a6                	mv	a1,s1
ffffffffc0207d40:	02500513          	li	a0,37
ffffffffc0207d44:	9902                	jalr	s2
ffffffffc0207d46:	b545                	j	ffffffffc0207be6 <vprintfmt+0x3a>
ffffffffc0207d48:	00144603          	lbu	a2,1(s0)
ffffffffc0207d4c:	2885                	addiw	a7,a7,1
ffffffffc0207d4e:	846a                	mv	s0,s10
ffffffffc0207d50:	b5e1                	j	ffffffffc0207c18 <vprintfmt+0x6c>
ffffffffc0207d52:	4705                	li	a4,1
ffffffffc0207d54:	008a0593          	addi	a1,s4,8
ffffffffc0207d58:	01174463          	blt	a4,a7,ffffffffc0207d60 <vprintfmt+0x1b4>
ffffffffc0207d5c:	14088163          	beqz	a7,ffffffffc0207e9e <vprintfmt+0x2f2>
ffffffffc0207d60:	000a3603          	ld	a2,0(s4)
ffffffffc0207d64:	46a1                	li	a3,8
ffffffffc0207d66:	8a2e                	mv	s4,a1
ffffffffc0207d68:	bf69                	j	ffffffffc0207d02 <vprintfmt+0x156>
ffffffffc0207d6a:	03000513          	li	a0,48
ffffffffc0207d6e:	85a6                	mv	a1,s1
ffffffffc0207d70:	e03e                	sd	a5,0(sp)
ffffffffc0207d72:	9902                	jalr	s2
ffffffffc0207d74:	85a6                	mv	a1,s1
ffffffffc0207d76:	07800513          	li	a0,120
ffffffffc0207d7a:	9902                	jalr	s2
ffffffffc0207d7c:	0a21                	addi	s4,s4,8
ffffffffc0207d7e:	6782                	ld	a5,0(sp)
ffffffffc0207d80:	46c1                	li	a3,16
ffffffffc0207d82:	ff8a3603          	ld	a2,-8(s4)
ffffffffc0207d86:	bfb5                	j	ffffffffc0207d02 <vprintfmt+0x156>
ffffffffc0207d88:	000a3403          	ld	s0,0(s4)
ffffffffc0207d8c:	008a0713          	addi	a4,s4,8
ffffffffc0207d90:	e03a                	sd	a4,0(sp)
ffffffffc0207d92:	14040263          	beqz	s0,ffffffffc0207ed6 <vprintfmt+0x32a>
ffffffffc0207d96:	0fb05763          	blez	s11,ffffffffc0207e84 <vprintfmt+0x2d8>
ffffffffc0207d9a:	02d00693          	li	a3,45
ffffffffc0207d9e:	0cd79163          	bne	a5,a3,ffffffffc0207e60 <vprintfmt+0x2b4>
ffffffffc0207da2:	00044783          	lbu	a5,0(s0)
ffffffffc0207da6:	0007851b          	sext.w	a0,a5
ffffffffc0207daa:	cf85                	beqz	a5,ffffffffc0207de2 <vprintfmt+0x236>
ffffffffc0207dac:	00140a13          	addi	s4,s0,1
ffffffffc0207db0:	05e00413          	li	s0,94
ffffffffc0207db4:	000c4563          	bltz	s8,ffffffffc0207dbe <vprintfmt+0x212>
ffffffffc0207db8:	3c7d                	addiw	s8,s8,-1
ffffffffc0207dba:	036c0263          	beq	s8,s6,ffffffffc0207dde <vprintfmt+0x232>
ffffffffc0207dbe:	85a6                	mv	a1,s1
ffffffffc0207dc0:	0e0c8e63          	beqz	s9,ffffffffc0207ebc <vprintfmt+0x310>
ffffffffc0207dc4:	3781                	addiw	a5,a5,-32
ffffffffc0207dc6:	0ef47b63          	bgeu	s0,a5,ffffffffc0207ebc <vprintfmt+0x310>
ffffffffc0207dca:	03f00513          	li	a0,63
ffffffffc0207dce:	9902                	jalr	s2
ffffffffc0207dd0:	000a4783          	lbu	a5,0(s4)
ffffffffc0207dd4:	3dfd                	addiw	s11,s11,-1
ffffffffc0207dd6:	0a05                	addi	s4,s4,1
ffffffffc0207dd8:	0007851b          	sext.w	a0,a5
ffffffffc0207ddc:	ffe1                	bnez	a5,ffffffffc0207db4 <vprintfmt+0x208>
ffffffffc0207dde:	01b05963          	blez	s11,ffffffffc0207df0 <vprintfmt+0x244>
ffffffffc0207de2:	3dfd                	addiw	s11,s11,-1
ffffffffc0207de4:	85a6                	mv	a1,s1
ffffffffc0207de6:	02000513          	li	a0,32
ffffffffc0207dea:	9902                	jalr	s2
ffffffffc0207dec:	fe0d9be3          	bnez	s11,ffffffffc0207de2 <vprintfmt+0x236>
ffffffffc0207df0:	6a02                	ld	s4,0(sp)
ffffffffc0207df2:	bbd5                	j	ffffffffc0207be6 <vprintfmt+0x3a>
ffffffffc0207df4:	4705                	li	a4,1
ffffffffc0207df6:	008a0c93          	addi	s9,s4,8
ffffffffc0207dfa:	01174463          	blt	a4,a7,ffffffffc0207e02 <vprintfmt+0x256>
ffffffffc0207dfe:	08088d63          	beqz	a7,ffffffffc0207e98 <vprintfmt+0x2ec>
ffffffffc0207e02:	000a3403          	ld	s0,0(s4)
ffffffffc0207e06:	0a044d63          	bltz	s0,ffffffffc0207ec0 <vprintfmt+0x314>
ffffffffc0207e0a:	8622                	mv	a2,s0
ffffffffc0207e0c:	8a66                	mv	s4,s9
ffffffffc0207e0e:	46a9                	li	a3,10
ffffffffc0207e10:	bdcd                	j	ffffffffc0207d02 <vprintfmt+0x156>
ffffffffc0207e12:	000a2783          	lw	a5,0(s4)
ffffffffc0207e16:	4761                	li	a4,24
ffffffffc0207e18:	0a21                	addi	s4,s4,8
ffffffffc0207e1a:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0207e1e:	8fb5                	xor	a5,a5,a3
ffffffffc0207e20:	40d786bb          	subw	a3,a5,a3
ffffffffc0207e24:	02d74163          	blt	a4,a3,ffffffffc0207e46 <vprintfmt+0x29a>
ffffffffc0207e28:	00369793          	slli	a5,a3,0x3
ffffffffc0207e2c:	97de                	add	a5,a5,s7
ffffffffc0207e2e:	639c                	ld	a5,0(a5)
ffffffffc0207e30:	cb99                	beqz	a5,ffffffffc0207e46 <vprintfmt+0x29a>
ffffffffc0207e32:	86be                	mv	a3,a5
ffffffffc0207e34:	00000617          	auipc	a2,0x0
ffffffffc0207e38:	13460613          	addi	a2,a2,308 # ffffffffc0207f68 <etext+0x24>
ffffffffc0207e3c:	85a6                	mv	a1,s1
ffffffffc0207e3e:	854a                	mv	a0,s2
ffffffffc0207e40:	0ce000ef          	jal	ra,ffffffffc0207f0e <printfmt>
ffffffffc0207e44:	b34d                	j	ffffffffc0207be6 <vprintfmt+0x3a>
ffffffffc0207e46:	00002617          	auipc	a2,0x2
ffffffffc0207e4a:	46260613          	addi	a2,a2,1122 # ffffffffc020a2a8 <syscalls+0x820>
ffffffffc0207e4e:	85a6                	mv	a1,s1
ffffffffc0207e50:	854a                	mv	a0,s2
ffffffffc0207e52:	0bc000ef          	jal	ra,ffffffffc0207f0e <printfmt>
ffffffffc0207e56:	bb41                	j	ffffffffc0207be6 <vprintfmt+0x3a>
ffffffffc0207e58:	00002417          	auipc	s0,0x2
ffffffffc0207e5c:	44840413          	addi	s0,s0,1096 # ffffffffc020a2a0 <syscalls+0x818>
ffffffffc0207e60:	85e2                	mv	a1,s8
ffffffffc0207e62:	8522                	mv	a0,s0
ffffffffc0207e64:	e43e                	sd	a5,8(sp)
ffffffffc0207e66:	c61ff0ef          	jal	ra,ffffffffc0207ac6 <strnlen>
ffffffffc0207e6a:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0207e6e:	01b05b63          	blez	s11,ffffffffc0207e84 <vprintfmt+0x2d8>
ffffffffc0207e72:	67a2                	ld	a5,8(sp)
ffffffffc0207e74:	00078a1b          	sext.w	s4,a5
ffffffffc0207e78:	3dfd                	addiw	s11,s11,-1
ffffffffc0207e7a:	85a6                	mv	a1,s1
ffffffffc0207e7c:	8552                	mv	a0,s4
ffffffffc0207e7e:	9902                	jalr	s2
ffffffffc0207e80:	fe0d9ce3          	bnez	s11,ffffffffc0207e78 <vprintfmt+0x2cc>
ffffffffc0207e84:	00044783          	lbu	a5,0(s0)
ffffffffc0207e88:	00140a13          	addi	s4,s0,1
ffffffffc0207e8c:	0007851b          	sext.w	a0,a5
ffffffffc0207e90:	d3a5                	beqz	a5,ffffffffc0207df0 <vprintfmt+0x244>
ffffffffc0207e92:	05e00413          	li	s0,94
ffffffffc0207e96:	bf39                	j	ffffffffc0207db4 <vprintfmt+0x208>
ffffffffc0207e98:	000a2403          	lw	s0,0(s4)
ffffffffc0207e9c:	b7ad                	j	ffffffffc0207e06 <vprintfmt+0x25a>
ffffffffc0207e9e:	000a6603          	lwu	a2,0(s4)
ffffffffc0207ea2:	46a1                	li	a3,8
ffffffffc0207ea4:	8a2e                	mv	s4,a1
ffffffffc0207ea6:	bdb1                	j	ffffffffc0207d02 <vprintfmt+0x156>
ffffffffc0207ea8:	000a6603          	lwu	a2,0(s4)
ffffffffc0207eac:	46a9                	li	a3,10
ffffffffc0207eae:	8a2e                	mv	s4,a1
ffffffffc0207eb0:	bd89                	j	ffffffffc0207d02 <vprintfmt+0x156>
ffffffffc0207eb2:	000a6603          	lwu	a2,0(s4)
ffffffffc0207eb6:	46c1                	li	a3,16
ffffffffc0207eb8:	8a2e                	mv	s4,a1
ffffffffc0207eba:	b5a1                	j	ffffffffc0207d02 <vprintfmt+0x156>
ffffffffc0207ebc:	9902                	jalr	s2
ffffffffc0207ebe:	bf09                	j	ffffffffc0207dd0 <vprintfmt+0x224>
ffffffffc0207ec0:	85a6                	mv	a1,s1
ffffffffc0207ec2:	02d00513          	li	a0,45
ffffffffc0207ec6:	e03e                	sd	a5,0(sp)
ffffffffc0207ec8:	9902                	jalr	s2
ffffffffc0207eca:	6782                	ld	a5,0(sp)
ffffffffc0207ecc:	8a66                	mv	s4,s9
ffffffffc0207ece:	40800633          	neg	a2,s0
ffffffffc0207ed2:	46a9                	li	a3,10
ffffffffc0207ed4:	b53d                	j	ffffffffc0207d02 <vprintfmt+0x156>
ffffffffc0207ed6:	03b05163          	blez	s11,ffffffffc0207ef8 <vprintfmt+0x34c>
ffffffffc0207eda:	02d00693          	li	a3,45
ffffffffc0207ede:	f6d79de3          	bne	a5,a3,ffffffffc0207e58 <vprintfmt+0x2ac>
ffffffffc0207ee2:	00002417          	auipc	s0,0x2
ffffffffc0207ee6:	3be40413          	addi	s0,s0,958 # ffffffffc020a2a0 <syscalls+0x818>
ffffffffc0207eea:	02800793          	li	a5,40
ffffffffc0207eee:	02800513          	li	a0,40
ffffffffc0207ef2:	00140a13          	addi	s4,s0,1
ffffffffc0207ef6:	bd6d                	j	ffffffffc0207db0 <vprintfmt+0x204>
ffffffffc0207ef8:	00002a17          	auipc	s4,0x2
ffffffffc0207efc:	3a9a0a13          	addi	s4,s4,937 # ffffffffc020a2a1 <syscalls+0x819>
ffffffffc0207f00:	02800513          	li	a0,40
ffffffffc0207f04:	02800793          	li	a5,40
ffffffffc0207f08:	05e00413          	li	s0,94
ffffffffc0207f0c:	b565                	j	ffffffffc0207db4 <vprintfmt+0x208>

ffffffffc0207f0e <printfmt>:
ffffffffc0207f0e:	715d                	addi	sp,sp,-80
ffffffffc0207f10:	02810313          	addi	t1,sp,40
ffffffffc0207f14:	f436                	sd	a3,40(sp)
ffffffffc0207f16:	869a                	mv	a3,t1
ffffffffc0207f18:	ec06                	sd	ra,24(sp)
ffffffffc0207f1a:	f83a                	sd	a4,48(sp)
ffffffffc0207f1c:	fc3e                	sd	a5,56(sp)
ffffffffc0207f1e:	e0c2                	sd	a6,64(sp)
ffffffffc0207f20:	e4c6                	sd	a7,72(sp)
ffffffffc0207f22:	e41a                	sd	t1,8(sp)
ffffffffc0207f24:	c89ff0ef          	jal	ra,ffffffffc0207bac <vprintfmt>
ffffffffc0207f28:	60e2                	ld	ra,24(sp)
ffffffffc0207f2a:	6161                	addi	sp,sp,80
ffffffffc0207f2c:	8082                	ret

ffffffffc0207f2e <hash32>:
ffffffffc0207f2e:	9e3707b7          	lui	a5,0x9e370
ffffffffc0207f32:	2785                	addiw	a5,a5,1
ffffffffc0207f34:	02a7853b          	mulw	a0,a5,a0
ffffffffc0207f38:	02000793          	li	a5,32
ffffffffc0207f3c:	9f8d                	subw	a5,a5,a1
ffffffffc0207f3e:	00f5553b          	srlw	a0,a0,a5
ffffffffc0207f42:	8082                	ret
