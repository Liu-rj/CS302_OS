
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
ffffffffc020003e:	70e60613          	addi	a2,a2,1806 # ffffffffc0219748 <end>
ffffffffc0200042:	1141                	addi	sp,sp,-16
ffffffffc0200044:	8e09                	sub	a2,a2,a0
ffffffffc0200046:	4581                	li	a1,0
ffffffffc0200048:	e406                	sd	ra,8(sp)
ffffffffc020004a:	2bd070ef          	jal	ra,ffffffffc0207b06 <memset>
ffffffffc020004e:	570000ef          	jal	ra,ffffffffc02005be <cons_init>
ffffffffc0200052:	00008597          	auipc	a1,0x8
ffffffffc0200056:	ee658593          	addi	a1,a1,-282 # ffffffffc0207f38 <etext+0x4>
ffffffffc020005a:	00008517          	auipc	a0,0x8
ffffffffc020005e:	ef650513          	addi	a0,a0,-266 # ffffffffc0207f50 <etext+0x1c>
ffffffffc0200062:	06a000ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200066:	5f5000ef          	jal	ra,ffffffffc0200e5a <pmm_init>
ffffffffc020006a:	5c6000ef          	jal	ra,ffffffffc0200630 <pic_init>
ffffffffc020006e:	5d0000ef          	jal	ra,ffffffffc020063e <idt_init>
ffffffffc0200072:	237010ef          	jal	ra,ffffffffc0201aa8 <vmm_init>
ffffffffc0200076:	107040ef          	jal	ra,ffffffffc020497c <sched_init>
ffffffffc020007a:	6f4040ef          	jal	ra,ffffffffc020476e <proc_init>
ffffffffc020007e:	4a2000ef          	jal	ra,ffffffffc0200520 <ide_init>
ffffffffc0200082:	3bf010ef          	jal	ra,ffffffffc0201c40 <swap_init>
ffffffffc0200086:	4f0000ef          	jal	ra,ffffffffc0200576 <clock_init>
ffffffffc020008a:	5a8000ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc020008e:	017040ef          	jal	ra,ffffffffc02048a4 <cpu_idle>

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
ffffffffc02000c0:	2dd070ef          	jal	ra,ffffffffc0207b9c <vprintfmt>
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
ffffffffc02000f6:	2a7070ef          	jal	ra,ffffffffc0207b9c <vprintfmt>
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
ffffffffc020016e:	dee50513          	addi	a0,a0,-530 # ffffffffc0207f58 <etext+0x24>
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
ffffffffc020023a:	d2a50513          	addi	a0,a0,-726 # ffffffffc0207f60 <etext+0x2c>
ffffffffc020023e:	e43e                	sd	a5,8(sp)
ffffffffc0200240:	e8dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200244:	65a2                	ld	a1,8(sp)
ffffffffc0200246:	8522                	mv	a0,s0
ffffffffc0200248:	e65ff0ef          	jal	ra,ffffffffc02000ac <vcprintf>
ffffffffc020024c:	00009517          	auipc	a0,0x9
ffffffffc0200250:	1e450513          	addi	a0,a0,484 # ffffffffc0209430 <default_pmm_manager+0x108>
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
ffffffffc0200284:	d0050513          	addi	a0,a0,-768 # ffffffffc0207f80 <etext+0x4c>
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
ffffffffc02002a4:	19050513          	addi	a0,a0,400 # ffffffffc0209430 <default_pmm_manager+0x108>
ffffffffc02002a8:	e25ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002ac:	60e2                	ld	ra,24(sp)
ffffffffc02002ae:	6442                	ld	s0,16(sp)
ffffffffc02002b0:	6161                	addi	sp,sp,80
ffffffffc02002b2:	8082                	ret

ffffffffc02002b4 <print_kerninfo>:
ffffffffc02002b4:	1141                	addi	sp,sp,-16
ffffffffc02002b6:	00008517          	auipc	a0,0x8
ffffffffc02002ba:	cea50513          	addi	a0,a0,-790 # ffffffffc0207fa0 <etext+0x6c>
ffffffffc02002be:	e406                	sd	ra,8(sp)
ffffffffc02002c0:	e0dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002c4:	00000597          	auipc	a1,0x0
ffffffffc02002c8:	d6e58593          	addi	a1,a1,-658 # ffffffffc0200032 <kern_init>
ffffffffc02002cc:	00008517          	auipc	a0,0x8
ffffffffc02002d0:	cf450513          	addi	a0,a0,-780 # ffffffffc0207fc0 <etext+0x8c>
ffffffffc02002d4:	df9ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002d8:	00008597          	auipc	a1,0x8
ffffffffc02002dc:	c5c58593          	addi	a1,a1,-932 # ffffffffc0207f34 <etext>
ffffffffc02002e0:	00008517          	auipc	a0,0x8
ffffffffc02002e4:	d0050513          	addi	a0,a0,-768 # ffffffffc0207fe0 <etext+0xac>
ffffffffc02002e8:	de5ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002ec:	0000e597          	auipc	a1,0xe
ffffffffc02002f0:	da458593          	addi	a1,a1,-604 # ffffffffc020e090 <buf>
ffffffffc02002f4:	00008517          	auipc	a0,0x8
ffffffffc02002f8:	d0c50513          	addi	a0,a0,-756 # ffffffffc0208000 <etext+0xcc>
ffffffffc02002fc:	dd1ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200300:	00019597          	auipc	a1,0x19
ffffffffc0200304:	44858593          	addi	a1,a1,1096 # ffffffffc0219748 <end>
ffffffffc0200308:	00008517          	auipc	a0,0x8
ffffffffc020030c:	d1850513          	addi	a0,a0,-744 # ffffffffc0208020 <etext+0xec>
ffffffffc0200310:	dbdff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200314:	0001a597          	auipc	a1,0x1a
ffffffffc0200318:	83358593          	addi	a1,a1,-1997 # ffffffffc0219b47 <end+0x3ff>
ffffffffc020031c:	00000797          	auipc	a5,0x0
ffffffffc0200320:	d1678793          	addi	a5,a5,-746 # ffffffffc0200032 <kern_init>
ffffffffc0200324:	40f587b3          	sub	a5,a1,a5
ffffffffc0200328:	43f7d593          	srai	a1,a5,0x3f
ffffffffc020032c:	60a2                	ld	ra,8(sp)
ffffffffc020032e:	3ff5f593          	andi	a1,a1,1023
ffffffffc0200332:	95be                	add	a1,a1,a5
ffffffffc0200334:	85a9                	srai	a1,a1,0xa
ffffffffc0200336:	00008517          	auipc	a0,0x8
ffffffffc020033a:	d0a50513          	addi	a0,a0,-758 # ffffffffc0208040 <etext+0x10c>
ffffffffc020033e:	0141                	addi	sp,sp,16
ffffffffc0200340:	b371                	j	ffffffffc02000cc <cprintf>

ffffffffc0200342 <print_stackframe>:
ffffffffc0200342:	1141                	addi	sp,sp,-16
ffffffffc0200344:	00008617          	auipc	a2,0x8
ffffffffc0200348:	d2c60613          	addi	a2,a2,-724 # ffffffffc0208070 <etext+0x13c>
ffffffffc020034c:	05b00593          	li	a1,91
ffffffffc0200350:	00008517          	auipc	a0,0x8
ffffffffc0200354:	d3850513          	addi	a0,a0,-712 # ffffffffc0208088 <etext+0x154>
ffffffffc0200358:	e406                	sd	ra,8(sp)
ffffffffc020035a:	eafff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020035e <mon_help>:
ffffffffc020035e:	1141                	addi	sp,sp,-16
ffffffffc0200360:	00008617          	auipc	a2,0x8
ffffffffc0200364:	d4060613          	addi	a2,a2,-704 # ffffffffc02080a0 <etext+0x16c>
ffffffffc0200368:	00008597          	auipc	a1,0x8
ffffffffc020036c:	d5858593          	addi	a1,a1,-680 # ffffffffc02080c0 <etext+0x18c>
ffffffffc0200370:	00008517          	auipc	a0,0x8
ffffffffc0200374:	d5850513          	addi	a0,a0,-680 # ffffffffc02080c8 <etext+0x194>
ffffffffc0200378:	e406                	sd	ra,8(sp)
ffffffffc020037a:	d53ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020037e:	00008617          	auipc	a2,0x8
ffffffffc0200382:	d5a60613          	addi	a2,a2,-678 # ffffffffc02080d8 <etext+0x1a4>
ffffffffc0200386:	00008597          	auipc	a1,0x8
ffffffffc020038a:	d7a58593          	addi	a1,a1,-646 # ffffffffc0208100 <etext+0x1cc>
ffffffffc020038e:	00008517          	auipc	a0,0x8
ffffffffc0200392:	d3a50513          	addi	a0,a0,-710 # ffffffffc02080c8 <etext+0x194>
ffffffffc0200396:	d37ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020039a:	00008617          	auipc	a2,0x8
ffffffffc020039e:	d7660613          	addi	a2,a2,-650 # ffffffffc0208110 <etext+0x1dc>
ffffffffc02003a2:	00008597          	auipc	a1,0x8
ffffffffc02003a6:	d8e58593          	addi	a1,a1,-626 # ffffffffc0208130 <etext+0x1fc>
ffffffffc02003aa:	00008517          	auipc	a0,0x8
ffffffffc02003ae:	d1e50513          	addi	a0,a0,-738 # ffffffffc02080c8 <etext+0x194>
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
ffffffffc02003e8:	d5c50513          	addi	a0,a0,-676 # ffffffffc0208140 <etext+0x20c>
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
ffffffffc020040a:	d6250513          	addi	a0,a0,-670 # ffffffffc0208168 <etext+0x234>
ffffffffc020040e:	cbfff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200412:	000c0563          	beqz	s8,ffffffffc020041c <kmonitor+0x3e>
ffffffffc0200416:	8562                	mv	a0,s8
ffffffffc0200418:	40e000ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc020041c:	00008c97          	auipc	s9,0x8
ffffffffc0200420:	dbcc8c93          	addi	s9,s9,-580 # ffffffffc02081d8 <commands>
ffffffffc0200424:	00008997          	auipc	s3,0x8
ffffffffc0200428:	d6c98993          	addi	s3,s3,-660 # ffffffffc0208190 <etext+0x25c>
ffffffffc020042c:	00008917          	auipc	s2,0x8
ffffffffc0200430:	d6c90913          	addi	s2,s2,-660 # ffffffffc0208198 <etext+0x264>
ffffffffc0200434:	4a3d                	li	s4,15
ffffffffc0200436:	00008b17          	auipc	s6,0x8
ffffffffc020043a:	d6ab0b13          	addi	s6,s6,-662 # ffffffffc02081a0 <etext+0x26c>
ffffffffc020043e:	00008a97          	auipc	s5,0x8
ffffffffc0200442:	c82a8a93          	addi	s5,s5,-894 # ffffffffc02080c0 <etext+0x18c>
ffffffffc0200446:	4b8d                	li	s7,3
ffffffffc0200448:	854e                	mv	a0,s3
ffffffffc020044a:	d0bff0ef          	jal	ra,ffffffffc0200154 <readline>
ffffffffc020044e:	842a                	mv	s0,a0
ffffffffc0200450:	dd65                	beqz	a0,ffffffffc0200448 <kmonitor+0x6a>
ffffffffc0200452:	00054583          	lbu	a1,0(a0)
ffffffffc0200456:	4481                	li	s1,0
ffffffffc0200458:	c999                	beqz	a1,ffffffffc020046e <kmonitor+0x90>
ffffffffc020045a:	854a                	mv	a0,s2
ffffffffc020045c:	694070ef          	jal	ra,ffffffffc0207af0 <strchr>
ffffffffc0200460:	c925                	beqz	a0,ffffffffc02004d0 <kmonitor+0xf2>
ffffffffc0200462:	00144583          	lbu	a1,1(s0)
ffffffffc0200466:	00040023          	sb	zero,0(s0)
ffffffffc020046a:	0405                	addi	s0,s0,1
ffffffffc020046c:	f5fd                	bnez	a1,ffffffffc020045a <kmonitor+0x7c>
ffffffffc020046e:	dce9                	beqz	s1,ffffffffc0200448 <kmonitor+0x6a>
ffffffffc0200470:	6582                	ld	a1,0(sp)
ffffffffc0200472:	00008d17          	auipc	s10,0x8
ffffffffc0200476:	d66d0d13          	addi	s10,s10,-666 # ffffffffc02081d8 <commands>
ffffffffc020047a:	8556                	mv	a0,s5
ffffffffc020047c:	4401                	li	s0,0
ffffffffc020047e:	0d61                	addi	s10,s10,24
ffffffffc0200480:	652070ef          	jal	ra,ffffffffc0207ad2 <strcmp>
ffffffffc0200484:	c919                	beqz	a0,ffffffffc020049a <kmonitor+0xbc>
ffffffffc0200486:	2405                	addiw	s0,s0,1
ffffffffc0200488:	09740463          	beq	s0,s7,ffffffffc0200510 <kmonitor+0x132>
ffffffffc020048c:	000d3503          	ld	a0,0(s10)
ffffffffc0200490:	6582                	ld	a1,0(sp)
ffffffffc0200492:	0d61                	addi	s10,s10,24
ffffffffc0200494:	63e070ef          	jal	ra,ffffffffc0207ad2 <strcmp>
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
ffffffffc02004fa:	5f6070ef          	jal	ra,ffffffffc0207af0 <strchr>
ffffffffc02004fe:	d96d                	beqz	a0,ffffffffc02004f0 <kmonitor+0x112>
ffffffffc0200500:	00044583          	lbu	a1,0(s0)
ffffffffc0200504:	bf91                	j	ffffffffc0200458 <kmonitor+0x7a>
ffffffffc0200506:	45c1                	li	a1,16
ffffffffc0200508:	855a                	mv	a0,s6
ffffffffc020050a:	bc3ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020050e:	b7f1                	j	ffffffffc02004da <kmonitor+0xfc>
ffffffffc0200510:	6582                	ld	a1,0(sp)
ffffffffc0200512:	00008517          	auipc	a0,0x8
ffffffffc0200516:	cae50513          	addi	a0,a0,-850 # ffffffffc02081c0 <etext+0x28c>
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
ffffffffc0200546:	5d2070ef          	jal	ra,ffffffffc0207b18 <memcpy>
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
ffffffffc020056a:	5ae070ef          	jal	ra,ffffffffc0207b18 <memcpy>
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
ffffffffc0200598:	c8c50513          	addi	a0,a0,-884 # ffffffffc0208220 <commands+0x48>
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
ffffffffc0200664:	be050513          	addi	a0,a0,-1056 # ffffffffc0208240 <commands+0x68>
ffffffffc0200668:	e406                	sd	ra,8(sp)
ffffffffc020066a:	a63ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020066e:	640c                	ld	a1,8(s0)
ffffffffc0200670:	00008517          	auipc	a0,0x8
ffffffffc0200674:	be850513          	addi	a0,a0,-1048 # ffffffffc0208258 <commands+0x80>
ffffffffc0200678:	a55ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020067c:	680c                	ld	a1,16(s0)
ffffffffc020067e:	00008517          	auipc	a0,0x8
ffffffffc0200682:	bf250513          	addi	a0,a0,-1038 # ffffffffc0208270 <commands+0x98>
ffffffffc0200686:	a47ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020068a:	6c0c                	ld	a1,24(s0)
ffffffffc020068c:	00008517          	auipc	a0,0x8
ffffffffc0200690:	bfc50513          	addi	a0,a0,-1028 # ffffffffc0208288 <commands+0xb0>
ffffffffc0200694:	a39ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200698:	700c                	ld	a1,32(s0)
ffffffffc020069a:	00008517          	auipc	a0,0x8
ffffffffc020069e:	c0650513          	addi	a0,a0,-1018 # ffffffffc02082a0 <commands+0xc8>
ffffffffc02006a2:	a2bff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006a6:	740c                	ld	a1,40(s0)
ffffffffc02006a8:	00008517          	auipc	a0,0x8
ffffffffc02006ac:	c1050513          	addi	a0,a0,-1008 # ffffffffc02082b8 <commands+0xe0>
ffffffffc02006b0:	a1dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006b4:	780c                	ld	a1,48(s0)
ffffffffc02006b6:	00008517          	auipc	a0,0x8
ffffffffc02006ba:	c1a50513          	addi	a0,a0,-998 # ffffffffc02082d0 <commands+0xf8>
ffffffffc02006be:	a0fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006c2:	7c0c                	ld	a1,56(s0)
ffffffffc02006c4:	00008517          	auipc	a0,0x8
ffffffffc02006c8:	c2450513          	addi	a0,a0,-988 # ffffffffc02082e8 <commands+0x110>
ffffffffc02006cc:	a01ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006d0:	602c                	ld	a1,64(s0)
ffffffffc02006d2:	00008517          	auipc	a0,0x8
ffffffffc02006d6:	c2e50513          	addi	a0,a0,-978 # ffffffffc0208300 <commands+0x128>
ffffffffc02006da:	9f3ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006de:	642c                	ld	a1,72(s0)
ffffffffc02006e0:	00008517          	auipc	a0,0x8
ffffffffc02006e4:	c3850513          	addi	a0,a0,-968 # ffffffffc0208318 <commands+0x140>
ffffffffc02006e8:	9e5ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006ec:	682c                	ld	a1,80(s0)
ffffffffc02006ee:	00008517          	auipc	a0,0x8
ffffffffc02006f2:	c4250513          	addi	a0,a0,-958 # ffffffffc0208330 <commands+0x158>
ffffffffc02006f6:	9d7ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006fa:	6c2c                	ld	a1,88(s0)
ffffffffc02006fc:	00008517          	auipc	a0,0x8
ffffffffc0200700:	c4c50513          	addi	a0,a0,-948 # ffffffffc0208348 <commands+0x170>
ffffffffc0200704:	9c9ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200708:	702c                	ld	a1,96(s0)
ffffffffc020070a:	00008517          	auipc	a0,0x8
ffffffffc020070e:	c5650513          	addi	a0,a0,-938 # ffffffffc0208360 <commands+0x188>
ffffffffc0200712:	9bbff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200716:	742c                	ld	a1,104(s0)
ffffffffc0200718:	00008517          	auipc	a0,0x8
ffffffffc020071c:	c6050513          	addi	a0,a0,-928 # ffffffffc0208378 <commands+0x1a0>
ffffffffc0200720:	9adff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200724:	782c                	ld	a1,112(s0)
ffffffffc0200726:	00008517          	auipc	a0,0x8
ffffffffc020072a:	c6a50513          	addi	a0,a0,-918 # ffffffffc0208390 <commands+0x1b8>
ffffffffc020072e:	99fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200732:	7c2c                	ld	a1,120(s0)
ffffffffc0200734:	00008517          	auipc	a0,0x8
ffffffffc0200738:	c7450513          	addi	a0,a0,-908 # ffffffffc02083a8 <commands+0x1d0>
ffffffffc020073c:	991ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200740:	604c                	ld	a1,128(s0)
ffffffffc0200742:	00008517          	auipc	a0,0x8
ffffffffc0200746:	c7e50513          	addi	a0,a0,-898 # ffffffffc02083c0 <commands+0x1e8>
ffffffffc020074a:	983ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020074e:	644c                	ld	a1,136(s0)
ffffffffc0200750:	00008517          	auipc	a0,0x8
ffffffffc0200754:	c8850513          	addi	a0,a0,-888 # ffffffffc02083d8 <commands+0x200>
ffffffffc0200758:	975ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020075c:	684c                	ld	a1,144(s0)
ffffffffc020075e:	00008517          	auipc	a0,0x8
ffffffffc0200762:	c9250513          	addi	a0,a0,-878 # ffffffffc02083f0 <commands+0x218>
ffffffffc0200766:	967ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020076a:	6c4c                	ld	a1,152(s0)
ffffffffc020076c:	00008517          	auipc	a0,0x8
ffffffffc0200770:	c9c50513          	addi	a0,a0,-868 # ffffffffc0208408 <commands+0x230>
ffffffffc0200774:	959ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200778:	704c                	ld	a1,160(s0)
ffffffffc020077a:	00008517          	auipc	a0,0x8
ffffffffc020077e:	ca650513          	addi	a0,a0,-858 # ffffffffc0208420 <commands+0x248>
ffffffffc0200782:	94bff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200786:	744c                	ld	a1,168(s0)
ffffffffc0200788:	00008517          	auipc	a0,0x8
ffffffffc020078c:	cb050513          	addi	a0,a0,-848 # ffffffffc0208438 <commands+0x260>
ffffffffc0200790:	93dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200794:	784c                	ld	a1,176(s0)
ffffffffc0200796:	00008517          	auipc	a0,0x8
ffffffffc020079a:	cba50513          	addi	a0,a0,-838 # ffffffffc0208450 <commands+0x278>
ffffffffc020079e:	92fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007a2:	7c4c                	ld	a1,184(s0)
ffffffffc02007a4:	00008517          	auipc	a0,0x8
ffffffffc02007a8:	cc450513          	addi	a0,a0,-828 # ffffffffc0208468 <commands+0x290>
ffffffffc02007ac:	921ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007b0:	606c                	ld	a1,192(s0)
ffffffffc02007b2:	00008517          	auipc	a0,0x8
ffffffffc02007b6:	cce50513          	addi	a0,a0,-818 # ffffffffc0208480 <commands+0x2a8>
ffffffffc02007ba:	913ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007be:	646c                	ld	a1,200(s0)
ffffffffc02007c0:	00008517          	auipc	a0,0x8
ffffffffc02007c4:	cd850513          	addi	a0,a0,-808 # ffffffffc0208498 <commands+0x2c0>
ffffffffc02007c8:	905ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007cc:	686c                	ld	a1,208(s0)
ffffffffc02007ce:	00008517          	auipc	a0,0x8
ffffffffc02007d2:	ce250513          	addi	a0,a0,-798 # ffffffffc02084b0 <commands+0x2d8>
ffffffffc02007d6:	8f7ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007da:	6c6c                	ld	a1,216(s0)
ffffffffc02007dc:	00008517          	auipc	a0,0x8
ffffffffc02007e0:	cec50513          	addi	a0,a0,-788 # ffffffffc02084c8 <commands+0x2f0>
ffffffffc02007e4:	8e9ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007e8:	706c                	ld	a1,224(s0)
ffffffffc02007ea:	00008517          	auipc	a0,0x8
ffffffffc02007ee:	cf650513          	addi	a0,a0,-778 # ffffffffc02084e0 <commands+0x308>
ffffffffc02007f2:	8dbff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007f6:	746c                	ld	a1,232(s0)
ffffffffc02007f8:	00008517          	auipc	a0,0x8
ffffffffc02007fc:	d0050513          	addi	a0,a0,-768 # ffffffffc02084f8 <commands+0x320>
ffffffffc0200800:	8cdff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200804:	786c                	ld	a1,240(s0)
ffffffffc0200806:	00008517          	auipc	a0,0x8
ffffffffc020080a:	d0a50513          	addi	a0,a0,-758 # ffffffffc0208510 <commands+0x338>
ffffffffc020080e:	8bfff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200812:	7c6c                	ld	a1,248(s0)
ffffffffc0200814:	6402                	ld	s0,0(sp)
ffffffffc0200816:	60a2                	ld	ra,8(sp)
ffffffffc0200818:	00008517          	auipc	a0,0x8
ffffffffc020081c:	d1050513          	addi	a0,a0,-752 # ffffffffc0208528 <commands+0x350>
ffffffffc0200820:	0141                	addi	sp,sp,16
ffffffffc0200822:	8abff06f          	j	ffffffffc02000cc <cprintf>

ffffffffc0200826 <print_trapframe>:
ffffffffc0200826:	1141                	addi	sp,sp,-16
ffffffffc0200828:	e022                	sd	s0,0(sp)
ffffffffc020082a:	85aa                	mv	a1,a0
ffffffffc020082c:	842a                	mv	s0,a0
ffffffffc020082e:	00008517          	auipc	a0,0x8
ffffffffc0200832:	d1250513          	addi	a0,a0,-750 # ffffffffc0208540 <commands+0x368>
ffffffffc0200836:	e406                	sd	ra,8(sp)
ffffffffc0200838:	895ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020083c:	8522                	mv	a0,s0
ffffffffc020083e:	e1bff0ef          	jal	ra,ffffffffc0200658 <print_regs>
ffffffffc0200842:	10043583          	ld	a1,256(s0)
ffffffffc0200846:	00008517          	auipc	a0,0x8
ffffffffc020084a:	d1250513          	addi	a0,a0,-750 # ffffffffc0208558 <commands+0x380>
ffffffffc020084e:	87fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200852:	10843583          	ld	a1,264(s0)
ffffffffc0200856:	00008517          	auipc	a0,0x8
ffffffffc020085a:	d1a50513          	addi	a0,a0,-742 # ffffffffc0208570 <commands+0x398>
ffffffffc020085e:	86fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200862:	11043583          	ld	a1,272(s0)
ffffffffc0200866:	00008517          	auipc	a0,0x8
ffffffffc020086a:	d2250513          	addi	a0,a0,-734 # ffffffffc0208588 <commands+0x3b0>
ffffffffc020086e:	85fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200872:	11843583          	ld	a1,280(s0)
ffffffffc0200876:	6402                	ld	s0,0(sp)
ffffffffc0200878:	60a2                	ld	ra,8(sp)
ffffffffc020087a:	00008517          	auipc	a0,0x8
ffffffffc020087e:	d1e50513          	addi	a0,a0,-738 # ffffffffc0208598 <commands+0x3c0>
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
ffffffffc02008c6:	cee50513          	addi	a0,a0,-786 # ffffffffc02085b0 <commands+0x3d8>
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
ffffffffc0200932:	ca268693          	addi	a3,a3,-862 # ffffffffc02085d0 <commands+0x3f8>
ffffffffc0200936:	00008617          	auipc	a2,0x8
ffffffffc020093a:	cb260613          	addi	a2,a2,-846 # ffffffffc02085e8 <commands+0x410>
ffffffffc020093e:	06c00593          	li	a1,108
ffffffffc0200942:	00008517          	auipc	a0,0x8
ffffffffc0200946:	cbe50513          	addi	a0,a0,-834 # ffffffffc0208600 <commands+0x428>
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
ffffffffc020097c:	c3850513          	addi	a0,a0,-968 # ffffffffc02085b0 <commands+0x3d8>
ffffffffc0200980:	f4cff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200984:	00008617          	auipc	a2,0x8
ffffffffc0200988:	c9460613          	addi	a2,a2,-876 # ffffffffc0208618 <commands+0x440>
ffffffffc020098c:	07300593          	li	a1,115
ffffffffc0200990:	00008517          	auipc	a0,0x8
ffffffffc0200994:	c7050513          	addi	a0,a0,-912 # ffffffffc0208600 <commands+0x428>
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
ffffffffc02009b4:	d2070713          	addi	a4,a4,-736 # ffffffffc02086d0 <commands+0x4f8>
ffffffffc02009b8:	078a                	slli	a5,a5,0x2
ffffffffc02009ba:	97ba                	add	a5,a5,a4
ffffffffc02009bc:	439c                	lw	a5,0(a5)
ffffffffc02009be:	97ba                	add	a5,a5,a4
ffffffffc02009c0:	8782                	jr	a5
ffffffffc02009c2:	00008517          	auipc	a0,0x8
ffffffffc02009c6:	cce50513          	addi	a0,a0,-818 # ffffffffc0208690 <commands+0x4b8>
ffffffffc02009ca:	f02ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009ce:	00008517          	auipc	a0,0x8
ffffffffc02009d2:	ca250513          	addi	a0,a0,-862 # ffffffffc0208670 <commands+0x498>
ffffffffc02009d6:	ef6ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009da:	00008517          	auipc	a0,0x8
ffffffffc02009de:	c5650513          	addi	a0,a0,-938 # ffffffffc0208630 <commands+0x458>
ffffffffc02009e2:	eeaff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009e6:	00008517          	auipc	a0,0x8
ffffffffc02009ea:	c6a50513          	addi	a0,a0,-918 # ffffffffc0208650 <commands+0x478>
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
ffffffffc0200a0c:	2860406f          	j	ffffffffc0204c92 <run_timer_list>
ffffffffc0200a10:	00008517          	auipc	a0,0x8
ffffffffc0200a14:	ca050513          	addi	a0,a0,-864 # ffffffffc02086b0 <commands+0x4d8>
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
ffffffffc0200a36:	e6670713          	addi	a4,a4,-410 # ffffffffc0208898 <commands+0x6c0>
ffffffffc0200a3a:	078a                	slli	a5,a5,0x2
ffffffffc0200a3c:	97ba                	add	a5,a5,a4
ffffffffc0200a3e:	439c                	lw	a5,0(a5)
ffffffffc0200a40:	97ba                	add	a5,a5,a4
ffffffffc0200a42:	8782                	jr	a5
ffffffffc0200a44:	00008517          	auipc	a0,0x8
ffffffffc0200a48:	dac50513          	addi	a0,a0,-596 # ffffffffc02087f0 <commands+0x618>
ffffffffc0200a4c:	e80ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200a50:	10843783          	ld	a5,264(s0)
ffffffffc0200a54:	60e2                	ld	ra,24(sp)
ffffffffc0200a56:	64a2                	ld	s1,8(sp)
ffffffffc0200a58:	0791                	addi	a5,a5,4
ffffffffc0200a5a:	10f43423          	sd	a5,264(s0)
ffffffffc0200a5e:	6442                	ld	s0,16(sp)
ffffffffc0200a60:	6105                	addi	sp,sp,32
ffffffffc0200a62:	7d30606f          	j	ffffffffc0207a34 <syscall>
ffffffffc0200a66:	00008517          	auipc	a0,0x8
ffffffffc0200a6a:	daa50513          	addi	a0,a0,-598 # ffffffffc0208810 <commands+0x638>
ffffffffc0200a6e:	6442                	ld	s0,16(sp)
ffffffffc0200a70:	60e2                	ld	ra,24(sp)
ffffffffc0200a72:	64a2                	ld	s1,8(sp)
ffffffffc0200a74:	6105                	addi	sp,sp,32
ffffffffc0200a76:	e56ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc0200a7a:	00008517          	auipc	a0,0x8
ffffffffc0200a7e:	db650513          	addi	a0,a0,-586 # ffffffffc0208830 <commands+0x658>
ffffffffc0200a82:	b7f5                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200a84:	00008517          	auipc	a0,0x8
ffffffffc0200a88:	dcc50513          	addi	a0,a0,-564 # ffffffffc0208850 <commands+0x678>
ffffffffc0200a8c:	b7cd                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200a8e:	00008517          	auipc	a0,0x8
ffffffffc0200a92:	dda50513          	addi	a0,a0,-550 # ffffffffc0208868 <commands+0x690>
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
ffffffffc0200ab4:	dd050513          	addi	a0,a0,-560 # ffffffffc0208880 <commands+0x6a8>
ffffffffc0200ab8:	e14ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200abc:	8522                	mv	a0,s0
ffffffffc0200abe:	dcbff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200ac2:	84aa                	mv	s1,a0
ffffffffc0200ac4:	d16d                	beqz	a0,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200ac6:	8522                	mv	a0,s0
ffffffffc0200ac8:	d5fff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200acc:	86a6                	mv	a3,s1
ffffffffc0200ace:	00008617          	auipc	a2,0x8
ffffffffc0200ad2:	cd260613          	addi	a2,a2,-814 # ffffffffc02087a0 <commands+0x5c8>
ffffffffc0200ad6:	0f600593          	li	a1,246
ffffffffc0200ada:	00008517          	auipc	a0,0x8
ffffffffc0200ade:	b2650513          	addi	a0,a0,-1242 # ffffffffc0208600 <commands+0x428>
ffffffffc0200ae2:	f26ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200ae6:	00008517          	auipc	a0,0x8
ffffffffc0200aea:	c1a50513          	addi	a0,a0,-998 # ffffffffc0208700 <commands+0x528>
ffffffffc0200aee:	b741                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200af0:	00008517          	auipc	a0,0x8
ffffffffc0200af4:	c3050513          	addi	a0,a0,-976 # ffffffffc0208720 <commands+0x548>
ffffffffc0200af8:	bf9d                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200afa:	00008517          	auipc	a0,0x8
ffffffffc0200afe:	c4650513          	addi	a0,a0,-954 # ffffffffc0208740 <commands+0x568>
ffffffffc0200b02:	b7b5                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200b04:	00008517          	auipc	a0,0x8
ffffffffc0200b08:	c5450513          	addi	a0,a0,-940 # ffffffffc0208758 <commands+0x580>
ffffffffc0200b0c:	dc0ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200b10:	6458                	ld	a4,136(s0)
ffffffffc0200b12:	47a9                	li	a5,10
ffffffffc0200b14:	f8f719e3          	bne	a4,a5,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200b18:	bf25                	j	ffffffffc0200a50 <exception_handler+0x32>
ffffffffc0200b1a:	00008517          	auipc	a0,0x8
ffffffffc0200b1e:	c4e50513          	addi	a0,a0,-946 # ffffffffc0208768 <commands+0x590>
ffffffffc0200b22:	b7b1                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200b24:	00008517          	auipc	a0,0x8
ffffffffc0200b28:	c6450513          	addi	a0,a0,-924 # ffffffffc0208788 <commands+0x5b0>
ffffffffc0200b2c:	da0ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200b30:	8522                	mv	a0,s0
ffffffffc0200b32:	d57ff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200b36:	84aa                	mv	s1,a0
ffffffffc0200b38:	d53d                	beqz	a0,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200b3a:	8522                	mv	a0,s0
ffffffffc0200b3c:	cebff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200b40:	86a6                	mv	a3,s1
ffffffffc0200b42:	00008617          	auipc	a2,0x8
ffffffffc0200b46:	c5e60613          	addi	a2,a2,-930 # ffffffffc02087a0 <commands+0x5c8>
ffffffffc0200b4a:	0cb00593          	li	a1,203
ffffffffc0200b4e:	00008517          	auipc	a0,0x8
ffffffffc0200b52:	ab250513          	addi	a0,a0,-1358 # ffffffffc0208600 <commands+0x428>
ffffffffc0200b56:	eb2ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200b5a:	00008517          	auipc	a0,0x8
ffffffffc0200b5e:	c7e50513          	addi	a0,a0,-898 # ffffffffc02087d8 <commands+0x600>
ffffffffc0200b62:	d6aff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200b66:	8522                	mv	a0,s0
ffffffffc0200b68:	d21ff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200b6c:	84aa                	mv	s1,a0
ffffffffc0200b6e:	dd05                	beqz	a0,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200b70:	8522                	mv	a0,s0
ffffffffc0200b72:	cb5ff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200b76:	86a6                	mv	a3,s1
ffffffffc0200b78:	00008617          	auipc	a2,0x8
ffffffffc0200b7c:	c2860613          	addi	a2,a2,-984 # ffffffffc02087a0 <commands+0x5c8>
ffffffffc0200b80:	0d500593          	li	a1,213
ffffffffc0200b84:	00008517          	auipc	a0,0x8
ffffffffc0200b88:	a7c50513          	addi	a0,a0,-1412 # ffffffffc0208600 <commands+0x428>
ffffffffc0200b8c:	e7cff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200b90:	8522                	mv	a0,s0
ffffffffc0200b92:	6442                	ld	s0,16(sp)
ffffffffc0200b94:	60e2                	ld	ra,24(sp)
ffffffffc0200b96:	64a2                	ld	s1,8(sp)
ffffffffc0200b98:	6105                	addi	sp,sp,32
ffffffffc0200b9a:	b171                	j	ffffffffc0200826 <print_trapframe>
ffffffffc0200b9c:	00008617          	auipc	a2,0x8
ffffffffc0200ba0:	c2460613          	addi	a2,a2,-988 # ffffffffc02087c0 <commands+0x5e8>
ffffffffc0200ba4:	0cf00593          	li	a1,207
ffffffffc0200ba8:	00008517          	auipc	a0,0x8
ffffffffc0200bac:	a5850513          	addi	a0,a0,-1448 # ffffffffc0208600 <commands+0x428>
ffffffffc0200bb0:	e58ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200bb4:	8522                	mv	a0,s0
ffffffffc0200bb6:	c71ff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200bba:	86a6                	mv	a3,s1
ffffffffc0200bbc:	00008617          	auipc	a2,0x8
ffffffffc0200bc0:	be460613          	addi	a2,a2,-1052 # ffffffffc02087a0 <commands+0x5c8>
ffffffffc0200bc4:	0ef00593          	li	a1,239
ffffffffc0200bc8:	00008517          	auipc	a0,0x8
ffffffffc0200bcc:	a3850513          	addi	a0,a0,-1480 # ffffffffc0208600 <commands+0x428>
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
ffffffffc0200c50:	6310306f          	j	ffffffffc0204a80 <schedule>
ffffffffc0200c54:	555d                	li	a0,-9
ffffffffc0200c56:	0b0030ef          	jal	ra,ffffffffc0203d06 <do_exit>
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
ffffffffc0200d34:	ba860613          	addi	a2,a2,-1112 # ffffffffc02088d8 <commands+0x700>
ffffffffc0200d38:	06200593          	li	a1,98
ffffffffc0200d3c:	00008517          	auipc	a0,0x8
ffffffffc0200d40:	bbc50513          	addi	a0,a0,-1092 # ffffffffc02088f8 <commands+0x720>
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
ffffffffc0200e5e:	4ce78793          	addi	a5,a5,1230 # ffffffffc0209328 <default_pmm_manager>
ffffffffc0200e62:	638c                	ld	a1,0(a5)
ffffffffc0200e64:	1101                	addi	sp,sp,-32
ffffffffc0200e66:	e426                	sd	s1,8(sp)
ffffffffc0200e68:	00008517          	auipc	a0,0x8
ffffffffc0200e6c:	aa050513          	addi	a0,a0,-1376 # ffffffffc0208908 <commands+0x730>
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
ffffffffc0200e98:	a8c50513          	addi	a0,a0,-1396 # ffffffffc0208920 <commands+0x748>
ffffffffc0200e9c:	e01c                	sd	a5,0(s0)
ffffffffc0200e9e:	a2eff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200ea2:	44300693          	li	a3,1091
ffffffffc0200ea6:	06d6                	slli	a3,a3,0x15
ffffffffc0200ea8:	40100613          	li	a2,1025
ffffffffc0200eac:	0656                	slli	a2,a2,0x15
ffffffffc0200eae:	088005b7          	lui	a1,0x8800
ffffffffc0200eb2:	16fd                	addi	a3,a3,-1
ffffffffc0200eb4:	00008517          	auipc	a0,0x8
ffffffffc0200eb8:	a8450513          	addi	a0,a0,-1404 # ffffffffc0208938 <commands+0x760>
ffffffffc0200ebc:	a10ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200ec0:	777d                	lui	a4,0xfffff
ffffffffc0200ec2:	0001a797          	auipc	a5,0x1a
ffffffffc0200ec6:	88578793          	addi	a5,a5,-1915 # ffffffffc021a747 <end+0xfff>
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
ffffffffc0200f7e:	9e660613          	addi	a2,a2,-1562 # ffffffffc0208960 <commands+0x788>
ffffffffc0200f82:	07f00593          	li	a1,127
ffffffffc0200f86:	00008517          	auipc	a0,0x8
ffffffffc0200f8a:	a0250513          	addi	a0,a0,-1534 # ffffffffc0208988 <commands+0x7b0>
ffffffffc0200f8e:	a7aff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200f92:	00008617          	auipc	a2,0x8
ffffffffc0200f96:	9ce60613          	addi	a2,a2,-1586 # ffffffffc0208960 <commands+0x788>
ffffffffc0200f9a:	0c100593          	li	a1,193
ffffffffc0200f9e:	00008517          	auipc	a0,0x8
ffffffffc0200fa2:	9ea50513          	addi	a0,a0,-1558 # ffffffffc0208988 <commands+0x7b0>
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
ffffffffc0201034:	2d3060ef          	jal	ra,ffffffffc0207b06 <memset>
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
ffffffffc02010c6:	241060ef          	jal	ra,ffffffffc0207b06 <memset>
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
ffffffffc0201120:	87c60613          	addi	a2,a2,-1924 # ffffffffc0208998 <commands+0x7c0>
ffffffffc0201124:	0fe00593          	li	a1,254
ffffffffc0201128:	00008517          	auipc	a0,0x8
ffffffffc020112c:	86050513          	addi	a0,a0,-1952 # ffffffffc0208988 <commands+0x7b0>
ffffffffc0201130:	8d8ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201134:	00008617          	auipc	a2,0x8
ffffffffc0201138:	86460613          	addi	a2,a2,-1948 # ffffffffc0208998 <commands+0x7c0>
ffffffffc020113c:	10900593          	li	a1,265
ffffffffc0201140:	00008517          	auipc	a0,0x8
ffffffffc0201144:	84850513          	addi	a0,a0,-1976 # ffffffffc0208988 <commands+0x7b0>
ffffffffc0201148:	8c0ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020114c:	86aa                	mv	a3,a0
ffffffffc020114e:	00008617          	auipc	a2,0x8
ffffffffc0201152:	84a60613          	addi	a2,a2,-1974 # ffffffffc0208998 <commands+0x7c0>
ffffffffc0201156:	10600593          	li	a1,262
ffffffffc020115a:	00008517          	auipc	a0,0x8
ffffffffc020115e:	82e50513          	addi	a0,a0,-2002 # ffffffffc0208988 <commands+0x7b0>
ffffffffc0201162:	8a6ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201166:	86aa                	mv	a3,a0
ffffffffc0201168:	00008617          	auipc	a2,0x8
ffffffffc020116c:	83060613          	addi	a2,a2,-2000 # ffffffffc0208998 <commands+0x7c0>
ffffffffc0201170:	0fa00593          	li	a1,250
ffffffffc0201174:	00008517          	auipc	a0,0x8
ffffffffc0201178:	81450513          	addi	a0,a0,-2028 # ffffffffc0208988 <commands+0x7b0>
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
ffffffffc0201256:	79e68693          	addi	a3,a3,1950 # ffffffffc02089f0 <commands+0x818>
ffffffffc020125a:	00007617          	auipc	a2,0x7
ffffffffc020125e:	38e60613          	addi	a2,a2,910 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201262:	14100593          	li	a1,321
ffffffffc0201266:	00007517          	auipc	a0,0x7
ffffffffc020126a:	72250513          	addi	a0,a0,1826 # ffffffffc0208988 <commands+0x7b0>
ffffffffc020126e:	f9bfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201272:	00007697          	auipc	a3,0x7
ffffffffc0201276:	74e68693          	addi	a3,a3,1870 # ffffffffc02089c0 <commands+0x7e8>
ffffffffc020127a:	00007617          	auipc	a2,0x7
ffffffffc020127e:	36e60613          	addi	a2,a2,878 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201282:	14000593          	li	a1,320
ffffffffc0201286:	00007517          	auipc	a0,0x7
ffffffffc020128a:	70250513          	addi	a0,a0,1794 # ffffffffc0208988 <commands+0x7b0>
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
ffffffffc0201340:	59c60613          	addi	a2,a2,1436 # ffffffffc02088d8 <commands+0x700>
ffffffffc0201344:	06200593          	li	a1,98
ffffffffc0201348:	00007517          	auipc	a0,0x7
ffffffffc020134c:	5b050513          	addi	a0,a0,1456 # ffffffffc02088f8 <commands+0x720>
ffffffffc0201350:	eb9fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201354:	00007697          	auipc	a3,0x7
ffffffffc0201358:	69c68693          	addi	a3,a3,1692 # ffffffffc02089f0 <commands+0x818>
ffffffffc020135c:	00007617          	auipc	a2,0x7
ffffffffc0201360:	28c60613          	addi	a2,a2,652 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201364:	15200593          	li	a1,338
ffffffffc0201368:	00007517          	auipc	a0,0x7
ffffffffc020136c:	62050513          	addi	a0,a0,1568 # ffffffffc0208988 <commands+0x7b0>
ffffffffc0201370:	e99fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201374:	00007697          	auipc	a3,0x7
ffffffffc0201378:	64c68693          	addi	a3,a3,1612 # ffffffffc02089c0 <commands+0x7e8>
ffffffffc020137c:	00007617          	auipc	a2,0x7
ffffffffc0201380:	26c60613          	addi	a2,a2,620 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201384:	15100593          	li	a1,337
ffffffffc0201388:	00007517          	auipc	a0,0x7
ffffffffc020138c:	60050513          	addi	a0,a0,1536 # ffffffffc0208988 <commands+0x7b0>
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
ffffffffc02013de:	00893023          	sd	s0,0(s2) # fffffffffff80000 <end+0x3fd668b8>
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
ffffffffc020156c:	5ac060ef          	jal	ra,ffffffffc0207b18 <memcpy>
ffffffffc0201570:	86a6                	mv	a3,s1
ffffffffc0201572:	8622                	mv	a2,s0
ffffffffc0201574:	85ea                	mv	a1,s10
ffffffffc0201576:	8556                	mv	a0,s5
ffffffffc0201578:	e1dff0ef          	jal	ra,ffffffffc0201394 <page_insert>
ffffffffc020157c:	d139                	beqz	a0,ffffffffc02014c2 <copy_range+0x72>
ffffffffc020157e:	00007697          	auipc	a3,0x7
ffffffffc0201582:	4d268693          	addi	a3,a3,1234 # ffffffffc0208a50 <commands+0x878>
ffffffffc0201586:	00007617          	auipc	a2,0x7
ffffffffc020158a:	06260613          	addi	a2,a2,98 # ffffffffc02085e8 <commands+0x410>
ffffffffc020158e:	19900593          	li	a1,409
ffffffffc0201592:	00007517          	auipc	a0,0x7
ffffffffc0201596:	3f650513          	addi	a0,a0,1014 # ffffffffc0208988 <commands+0x7b0>
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
ffffffffc02015bc:	3e060613          	addi	a2,a2,992 # ffffffffc0208998 <commands+0x7c0>
ffffffffc02015c0:	06900593          	li	a1,105
ffffffffc02015c4:	00007517          	auipc	a0,0x7
ffffffffc02015c8:	33450513          	addi	a0,a0,820 # ffffffffc02088f8 <commands+0x720>
ffffffffc02015cc:	c3dfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02015d0:	00007697          	auipc	a3,0x7
ffffffffc02015d4:	46068693          	addi	a3,a3,1120 # ffffffffc0208a30 <commands+0x858>
ffffffffc02015d8:	00007617          	auipc	a2,0x7
ffffffffc02015dc:	01060613          	addi	a2,a2,16 # ffffffffc02085e8 <commands+0x410>
ffffffffc02015e0:	17e00593          	li	a1,382
ffffffffc02015e4:	00007517          	auipc	a0,0x7
ffffffffc02015e8:	3a450513          	addi	a0,a0,932 # ffffffffc0208988 <commands+0x7b0>
ffffffffc02015ec:	c1dfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02015f0:	00007697          	auipc	a3,0x7
ffffffffc02015f4:	40068693          	addi	a3,a3,1024 # ffffffffc02089f0 <commands+0x818>
ffffffffc02015f8:	00007617          	auipc	a2,0x7
ffffffffc02015fc:	ff060613          	addi	a2,a2,-16 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201600:	16a00593          	li	a1,362
ffffffffc0201604:	00007517          	auipc	a0,0x7
ffffffffc0201608:	38450513          	addi	a0,a0,900 # ffffffffc0208988 <commands+0x7b0>
ffffffffc020160c:	bfdfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201610:	00007697          	auipc	a3,0x7
ffffffffc0201614:	43068693          	addi	a3,a3,1072 # ffffffffc0208a40 <commands+0x868>
ffffffffc0201618:	00007617          	auipc	a2,0x7
ffffffffc020161c:	fd060613          	addi	a2,a2,-48 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201620:	17f00593          	li	a1,383
ffffffffc0201624:	00007517          	auipc	a0,0x7
ffffffffc0201628:	36450513          	addi	a0,a0,868 # ffffffffc0208988 <commands+0x7b0>
ffffffffc020162c:	bddfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201630:	00007617          	auipc	a2,0x7
ffffffffc0201634:	2a860613          	addi	a2,a2,680 # ffffffffc02088d8 <commands+0x700>
ffffffffc0201638:	06200593          	li	a1,98
ffffffffc020163c:	00007517          	auipc	a0,0x7
ffffffffc0201640:	2bc50513          	addi	a0,a0,700 # ffffffffc02088f8 <commands+0x720>
ffffffffc0201644:	bc5fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201648:	00007617          	auipc	a2,0x7
ffffffffc020164c:	3c060613          	addi	a2,a2,960 # ffffffffc0208a08 <commands+0x830>
ffffffffc0201650:	07400593          	li	a1,116
ffffffffc0201654:	00007517          	auipc	a0,0x7
ffffffffc0201658:	2a450513          	addi	a0,a0,676 # ffffffffc02088f8 <commands+0x720>
ffffffffc020165c:	badfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201660:	00007697          	auipc	a3,0x7
ffffffffc0201664:	36068693          	addi	a3,a3,864 # ffffffffc02089c0 <commands+0x7e8>
ffffffffc0201668:	00007617          	auipc	a2,0x7
ffffffffc020166c:	f8060613          	addi	a2,a2,-128 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201670:	16900593          	li	a1,361
ffffffffc0201674:	00007517          	auipc	a0,0x7
ffffffffc0201678:	31450513          	addi	a0,a0,788 # ffffffffc0208988 <commands+0x7b0>
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
ffffffffc02016f8:	36c68693          	addi	a3,a3,876 # ffffffffc0208a60 <commands+0x888>
ffffffffc02016fc:	00007617          	auipc	a2,0x7
ffffffffc0201700:	eec60613          	addi	a2,a2,-276 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201704:	1d800593          	li	a1,472
ffffffffc0201708:	00007517          	auipc	a0,0x7
ffffffffc020170c:	28050513          	addi	a0,a0,640 # ffffffffc0208988 <commands+0x7b0>
ffffffffc0201710:	af9fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201714 <check_vma_overlap.isra.0.part.0>:
ffffffffc0201714:	1141                	addi	sp,sp,-16
ffffffffc0201716:	00007697          	auipc	a3,0x7
ffffffffc020171a:	36268693          	addi	a3,a3,866 # ffffffffc0208a78 <commands+0x8a0>
ffffffffc020171e:	00007617          	auipc	a2,0x7
ffffffffc0201722:	eca60613          	addi	a2,a2,-310 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201726:	06d00593          	li	a1,109
ffffffffc020172a:	00007517          	auipc	a0,0x7
ffffffffc020172e:	36e50513          	addi	a0,a0,878 # ffffffffc0208a98 <commands+0x8c0>
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
ffffffffc0201772:	581010ef          	jal	ra,ffffffffc02034f2 <sem_init>
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
ffffffffc020183a:	27268693          	addi	a3,a3,626 # ffffffffc0208aa8 <commands+0x8d0>
ffffffffc020183e:	00007617          	auipc	a2,0x7
ffffffffc0201842:	daa60613          	addi	a2,a2,-598 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201846:	07400593          	li	a1,116
ffffffffc020184a:	00007517          	auipc	a0,0x7
ffffffffc020184e:	24e50513          	addi	a0,a0,590 # ffffffffc0208a98 <commands+0x8c0>
ffffffffc0201852:	9b7fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201856:	00007697          	auipc	a3,0x7
ffffffffc020185a:	29268693          	addi	a3,a3,658 # ffffffffc0208ae8 <commands+0x910>
ffffffffc020185e:	00007617          	auipc	a2,0x7
ffffffffc0201862:	d8a60613          	addi	a2,a2,-630 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201866:	06c00593          	li	a1,108
ffffffffc020186a:	00007517          	auipc	a0,0x7
ffffffffc020186e:	22e50513          	addi	a0,a0,558 # ffffffffc0208a98 <commands+0x8c0>
ffffffffc0201872:	997fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201876:	00007697          	auipc	a3,0x7
ffffffffc020187a:	25268693          	addi	a3,a3,594 # ffffffffc0208ac8 <commands+0x8f0>
ffffffffc020187e:	00007617          	auipc	a2,0x7
ffffffffc0201882:	d6a60613          	addi	a2,a2,-662 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201886:	06b00593          	li	a1,107
ffffffffc020188a:	00007517          	auipc	a0,0x7
ffffffffc020188e:	20e50513          	addi	a0,a0,526 # ffffffffc0208a98 <commands+0x8c0>
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
ffffffffc02018cc:	24068693          	addi	a3,a3,576 # ffffffffc0208b08 <commands+0x930>
ffffffffc02018d0:	00007617          	auipc	a2,0x7
ffffffffc02018d4:	d1860613          	addi	a2,a2,-744 # ffffffffc02085e8 <commands+0x410>
ffffffffc02018d8:	09400593          	li	a1,148
ffffffffc02018dc:	00007517          	auipc	a0,0x7
ffffffffc02018e0:	1bc50513          	addi	a0,a0,444 # ffffffffc0208a98 <commands+0x8c0>
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
ffffffffc020197c:	1a868693          	addi	a3,a3,424 # ffffffffc0208b20 <commands+0x948>
ffffffffc0201980:	00007617          	auipc	a2,0x7
ffffffffc0201984:	c6860613          	addi	a2,a2,-920 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201988:	0a700593          	li	a1,167
ffffffffc020198c:	00007517          	auipc	a0,0x7
ffffffffc0201990:	10c50513          	addi	a0,a0,268 # ffffffffc0208a98 <commands+0x8c0>
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
ffffffffc0201a16:	11e68693          	addi	a3,a3,286 # ffffffffc0208b30 <commands+0x958>
ffffffffc0201a1a:	00007617          	auipc	a2,0x7
ffffffffc0201a1e:	bce60613          	addi	a2,a2,-1074 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201a22:	0c000593          	li	a1,192
ffffffffc0201a26:	00007517          	auipc	a0,0x7
ffffffffc0201a2a:	07250513          	addi	a0,a0,114 # ffffffffc0208a98 <commands+0x8c0>
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
ffffffffc0201a8c:	0c868693          	addi	a3,a3,200 # ffffffffc0208b50 <commands+0x978>
ffffffffc0201a90:	00007617          	auipc	a2,0x7
ffffffffc0201a94:	b5860613          	addi	a2,a2,-1192 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201a98:	0d600593          	li	a1,214
ffffffffc0201a9c:	00007517          	auipc	a0,0x7
ffffffffc0201aa0:	ffc50513          	addi	a0,a0,-4 # ffffffffc0208a98 <commands+0x8c0>
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
ffffffffc0201b44:	0a850513          	addi	a0,a0,168 # ffffffffc0208be8 <commands+0xa10>
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
ffffffffc0201b6e:	05650513          	addi	a0,a0,86 # ffffffffc0208bc0 <commands+0x9e8>
ffffffffc0201b72:	d5afe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201b76:	5971                	li	s2,-4
ffffffffc0201b78:	bf55                	j	ffffffffc0201b2c <do_pgfault+0x82>
ffffffffc0201b7a:	85a2                	mv	a1,s0
ffffffffc0201b7c:	00007517          	auipc	a0,0x7
ffffffffc0201b80:	ff450513          	addi	a0,a0,-12 # ffffffffc0208b70 <commands+0x998>
ffffffffc0201b84:	d48fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201b88:	5975                	li	s2,-3
ffffffffc0201b8a:	b74d                	j	ffffffffc0201b2c <do_pgfault+0x82>
ffffffffc0201b8c:	00007517          	auipc	a0,0x7
ffffffffc0201b90:	07c50513          	addi	a0,a0,124 # ffffffffc0208c08 <commands+0xa30>
ffffffffc0201b94:	d38fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201b98:	5971                	li	s2,-4
ffffffffc0201b9a:	bf49                	j	ffffffffc0201b2c <do_pgfault+0x82>
ffffffffc0201b9c:	00007517          	auipc	a0,0x7
ffffffffc0201ba0:	00450513          	addi	a0,a0,4 # ffffffffc0208ba0 <commands+0x9c8>
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
ffffffffc0201c48:	0e7010ef          	jal	ra,ffffffffc020352e <swapfs_init>
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
ffffffffc0201c8e:	fd650513          	addi	a0,a0,-42 # ffffffffc0208c60 <commands+0xa88>
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
ffffffffc0201cb2:	f8260613          	addi	a2,a2,-126 # ffffffffc0208c30 <commands+0xa58>
ffffffffc0201cb6:	02800593          	li	a1,40
ffffffffc0201cba:	00007517          	auipc	a0,0x7
ffffffffc0201cbe:	f9650513          	addi	a0,a0,-106 # ffffffffc0208c50 <commands+0xa78>
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
ffffffffc0201d0e:	fceb0b13          	addi	s6,s6,-50 # ffffffffc0208cd8 <commands+0xb00>
ffffffffc0201d12:	00007b97          	auipc	s7,0x7
ffffffffc0201d16:	faeb8b93          	addi	s7,s7,-82 # ffffffffc0208cc0 <commands+0xae8>
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
ffffffffc0201d86:	06f010ef          	jal	ra,ffffffffc02035f4 <swapfs_write>
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
ffffffffc0201dc8:	eb450513          	addi	a0,a0,-332 # ffffffffc0208c78 <commands+0xaa0>
ffffffffc0201dcc:	b00fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201dd0:	bfe1                	j	ffffffffc0201da8 <swap_out+0xc6>
ffffffffc0201dd2:	4401                	li	s0,0
ffffffffc0201dd4:	bfd1                	j	ffffffffc0201da8 <swap_out+0xc6>
ffffffffc0201dd6:	00007697          	auipc	a3,0x7
ffffffffc0201dda:	ed268693          	addi	a3,a3,-302 # ffffffffc0208ca8 <commands+0xad0>
ffffffffc0201dde:	00007617          	auipc	a2,0x7
ffffffffc0201de2:	80a60613          	addi	a2,a2,-2038 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201de6:	06800593          	li	a1,104
ffffffffc0201dea:	00007517          	auipc	a0,0x7
ffffffffc0201dee:	e6650513          	addi	a0,a0,-410 # ffffffffc0208c50 <commands+0xa78>
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
ffffffffc0201e24:	742010ef          	jal	ra,ffffffffc0203566 <swapfs_read>
ffffffffc0201e28:	00093583          	ld	a1,0(s2)
ffffffffc0201e2c:	8626                	mv	a2,s1
ffffffffc0201e2e:	00007517          	auipc	a0,0x7
ffffffffc0201e32:	efa50513          	addi	a0,a0,-262 # ffffffffc0208d28 <commands+0xb50>
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
ffffffffc0201e54:	ec868693          	addi	a3,a3,-312 # ffffffffc0208d18 <commands+0xb40>
ffffffffc0201e58:	00006617          	auipc	a2,0x6
ffffffffc0201e5c:	79060613          	addi	a2,a2,1936 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201e60:	07e00593          	li	a1,126
ffffffffc0201e64:	00007517          	auipc	a0,0x7
ffffffffc0201e68:	dec50513          	addi	a0,a0,-532 # ffffffffc0208c50 <commands+0xa78>
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
ffffffffc0201f32:	7026b683          	ld	a3,1794(a3) # ffffffffc020a630 <nbase>
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
ffffffffc0201f62:	a3a60613          	addi	a2,a2,-1478 # ffffffffc0208998 <commands+0x7c0>
ffffffffc0201f66:	06900593          	li	a1,105
ffffffffc0201f6a:	00007517          	auipc	a0,0x7
ffffffffc0201f6e:	98e50513          	addi	a0,a0,-1650 # ffffffffc02088f8 <commands+0x720>
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
ffffffffc0202050:	d1c68693          	addi	a3,a3,-740 # ffffffffc0208d68 <commands+0xb90>
ffffffffc0202054:	00006617          	auipc	a2,0x6
ffffffffc0202058:	59460613          	addi	a2,a2,1428 # ffffffffc02085e8 <commands+0x410>
ffffffffc020205c:	06400593          	li	a1,100
ffffffffc0202060:	00007517          	auipc	a0,0x7
ffffffffc0202064:	d2850513          	addi	a0,a0,-728 # ffffffffc0208d88 <commands+0xbb0>
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
ffffffffc020218a:	4aa53503          	ld	a0,1194(a0) # ffffffffc020a630 <nbase>
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
ffffffffc02021e8:	6f460613          	addi	a2,a2,1780 # ffffffffc02088d8 <commands+0x700>
ffffffffc02021ec:	06200593          	li	a1,98
ffffffffc02021f0:	00006517          	auipc	a0,0x6
ffffffffc02021f4:	70850513          	addi	a0,a0,1800 # ffffffffc02088f8 <commands+0x720>
ffffffffc02021f8:	810fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02021fc:	86a2                	mv	a3,s0
ffffffffc02021fe:	00006617          	auipc	a2,0x6
ffffffffc0202202:	76260613          	addi	a2,a2,1890 # ffffffffc0208960 <commands+0x788>
ffffffffc0202206:	06e00593          	li	a1,110
ffffffffc020220a:	00006517          	auipc	a0,0x6
ffffffffc020220e:	6ee50513          	addi	a0,a0,1774 # ffffffffc02088f8 <commands+0x720>
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
ffffffffc020223e:	b6650513          	addi	a0,a0,-1178 # ffffffffc0208da0 <commands+0xbc8>
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
ffffffffc0202274:	b8050513          	addi	a0,a0,-1152 # ffffffffc0208df0 <commands+0xc18>
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
ffffffffc0202298:	b8450513          	addi	a0,a0,-1148 # ffffffffc0208e18 <commands+0xc40>
ffffffffc020229c:	6b91                	lui	s7,0x4
ffffffffc020229e:	4c35                	li	s8,13
ffffffffc02022a0:	e2dfd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02022a4:	018b8023          	sb	s8,0(s7) # 4000 <kern_entry-0xffffffffc01fc000>
ffffffffc02022a8:	00042903          	lw	s2,0(s0)
ffffffffc02022ac:	2901                	sext.w	s2,s2
ffffffffc02022ae:	26991d63          	bne	s2,s1,ffffffffc0202528 <_fifo_check_swap+0x2f4>
ffffffffc02022b2:	00007517          	auipc	a0,0x7
ffffffffc02022b6:	b8e50513          	addi	a0,a0,-1138 # ffffffffc0208e40 <commands+0xc68>
ffffffffc02022ba:	6c89                	lui	s9,0x2
ffffffffc02022bc:	4d2d                	li	s10,11
ffffffffc02022be:	e0ffd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02022c2:	01ac8023          	sb	s10,0(s9) # 2000 <kern_entry-0xffffffffc01fe000>
ffffffffc02022c6:	401c                	lw	a5,0(s0)
ffffffffc02022c8:	2781                	sext.w	a5,a5
ffffffffc02022ca:	23279f63          	bne	a5,s2,ffffffffc0202508 <_fifo_check_swap+0x2d4>
ffffffffc02022ce:	00007517          	auipc	a0,0x7
ffffffffc02022d2:	b9a50513          	addi	a0,a0,-1126 # ffffffffc0208e68 <commands+0xc90>
ffffffffc02022d6:	df7fd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02022da:	6795                	lui	a5,0x5
ffffffffc02022dc:	4739                	li	a4,14
ffffffffc02022de:	00e78023          	sb	a4,0(a5) # 5000 <kern_entry-0xffffffffc01fb000>
ffffffffc02022e2:	4004                	lw	s1,0(s0)
ffffffffc02022e4:	4795                	li	a5,5
ffffffffc02022e6:	2481                	sext.w	s1,s1
ffffffffc02022e8:	20f49063          	bne	s1,a5,ffffffffc02024e8 <_fifo_check_swap+0x2b4>
ffffffffc02022ec:	00007517          	auipc	a0,0x7
ffffffffc02022f0:	b5450513          	addi	a0,a0,-1196 # ffffffffc0208e40 <commands+0xc68>
ffffffffc02022f4:	dd9fd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02022f8:	01ac8023          	sb	s10,0(s9)
ffffffffc02022fc:	401c                	lw	a5,0(s0)
ffffffffc02022fe:	2781                	sext.w	a5,a5
ffffffffc0202300:	1c979463          	bne	a5,s1,ffffffffc02024c8 <_fifo_check_swap+0x294>
ffffffffc0202304:	00007517          	auipc	a0,0x7
ffffffffc0202308:	aec50513          	addi	a0,a0,-1300 # ffffffffc0208df0 <commands+0xc18>
ffffffffc020230c:	dc1fd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0202310:	016a8023          	sb	s6,0(s5)
ffffffffc0202314:	401c                	lw	a5,0(s0)
ffffffffc0202316:	4719                	li	a4,6
ffffffffc0202318:	2781                	sext.w	a5,a5
ffffffffc020231a:	18e79763          	bne	a5,a4,ffffffffc02024a8 <_fifo_check_swap+0x274>
ffffffffc020231e:	00007517          	auipc	a0,0x7
ffffffffc0202322:	b2250513          	addi	a0,a0,-1246 # ffffffffc0208e40 <commands+0xc68>
ffffffffc0202326:	da7fd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020232a:	01ac8023          	sb	s10,0(s9)
ffffffffc020232e:	401c                	lw	a5,0(s0)
ffffffffc0202330:	471d                	li	a4,7
ffffffffc0202332:	2781                	sext.w	a5,a5
ffffffffc0202334:	14e79a63          	bne	a5,a4,ffffffffc0202488 <_fifo_check_swap+0x254>
ffffffffc0202338:	00007517          	auipc	a0,0x7
ffffffffc020233c:	a6850513          	addi	a0,a0,-1432 # ffffffffc0208da0 <commands+0xbc8>
ffffffffc0202340:	d8dfd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0202344:	01498023          	sb	s4,0(s3)
ffffffffc0202348:	401c                	lw	a5,0(s0)
ffffffffc020234a:	4721                	li	a4,8
ffffffffc020234c:	2781                	sext.w	a5,a5
ffffffffc020234e:	10e79d63          	bne	a5,a4,ffffffffc0202468 <_fifo_check_swap+0x234>
ffffffffc0202352:	00007517          	auipc	a0,0x7
ffffffffc0202356:	ac650513          	addi	a0,a0,-1338 # ffffffffc0208e18 <commands+0xc40>
ffffffffc020235a:	d73fd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020235e:	018b8023          	sb	s8,0(s7)
ffffffffc0202362:	401c                	lw	a5,0(s0)
ffffffffc0202364:	4725                	li	a4,9
ffffffffc0202366:	2781                	sext.w	a5,a5
ffffffffc0202368:	0ee79063          	bne	a5,a4,ffffffffc0202448 <_fifo_check_swap+0x214>
ffffffffc020236c:	00007517          	auipc	a0,0x7
ffffffffc0202370:	afc50513          	addi	a0,a0,-1284 # ffffffffc0208e68 <commands+0xc90>
ffffffffc0202374:	d59fd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0202378:	6795                	lui	a5,0x5
ffffffffc020237a:	4739                	li	a4,14
ffffffffc020237c:	00e78023          	sb	a4,0(a5) # 5000 <kern_entry-0xffffffffc01fb000>
ffffffffc0202380:	4004                	lw	s1,0(s0)
ffffffffc0202382:	47a9                	li	a5,10
ffffffffc0202384:	2481                	sext.w	s1,s1
ffffffffc0202386:	0af49163          	bne	s1,a5,ffffffffc0202428 <_fifo_check_swap+0x1f4>
ffffffffc020238a:	00007517          	auipc	a0,0x7
ffffffffc020238e:	a6650513          	addi	a0,a0,-1434 # ffffffffc0208df0 <commands+0xc18>
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
ffffffffc02023cc:	a0068693          	addi	a3,a3,-1536 # ffffffffc0208dc8 <commands+0xbf0>
ffffffffc02023d0:	00006617          	auipc	a2,0x6
ffffffffc02023d4:	21860613          	addi	a2,a2,536 # ffffffffc02085e8 <commands+0x410>
ffffffffc02023d8:	05100593          	li	a1,81
ffffffffc02023dc:	00007517          	auipc	a0,0x7
ffffffffc02023e0:	9fc50513          	addi	a0,a0,-1540 # ffffffffc0208dd8 <commands+0xc00>
ffffffffc02023e4:	e25fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02023e8:	00007697          	auipc	a3,0x7
ffffffffc02023ec:	b3068693          	addi	a3,a3,-1232 # ffffffffc0208f18 <commands+0xd40>
ffffffffc02023f0:	00006617          	auipc	a2,0x6
ffffffffc02023f4:	1f860613          	addi	a2,a2,504 # ffffffffc02085e8 <commands+0x410>
ffffffffc02023f8:	07300593          	li	a1,115
ffffffffc02023fc:	00007517          	auipc	a0,0x7
ffffffffc0202400:	9dc50513          	addi	a0,a0,-1572 # ffffffffc0208dd8 <commands+0xc00>
ffffffffc0202404:	e05fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202408:	00007697          	auipc	a3,0x7
ffffffffc020240c:	ae868693          	addi	a3,a3,-1304 # ffffffffc0208ef0 <commands+0xd18>
ffffffffc0202410:	00006617          	auipc	a2,0x6
ffffffffc0202414:	1d860613          	addi	a2,a2,472 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202418:	07100593          	li	a1,113
ffffffffc020241c:	00007517          	auipc	a0,0x7
ffffffffc0202420:	9bc50513          	addi	a0,a0,-1604 # ffffffffc0208dd8 <commands+0xc00>
ffffffffc0202424:	de5fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202428:	00007697          	auipc	a3,0x7
ffffffffc020242c:	ab868693          	addi	a3,a3,-1352 # ffffffffc0208ee0 <commands+0xd08>
ffffffffc0202430:	00006617          	auipc	a2,0x6
ffffffffc0202434:	1b860613          	addi	a2,a2,440 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202438:	06f00593          	li	a1,111
ffffffffc020243c:	00007517          	auipc	a0,0x7
ffffffffc0202440:	99c50513          	addi	a0,a0,-1636 # ffffffffc0208dd8 <commands+0xc00>
ffffffffc0202444:	dc5fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202448:	00007697          	auipc	a3,0x7
ffffffffc020244c:	a8868693          	addi	a3,a3,-1400 # ffffffffc0208ed0 <commands+0xcf8>
ffffffffc0202450:	00006617          	auipc	a2,0x6
ffffffffc0202454:	19860613          	addi	a2,a2,408 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202458:	06c00593          	li	a1,108
ffffffffc020245c:	00007517          	auipc	a0,0x7
ffffffffc0202460:	97c50513          	addi	a0,a0,-1668 # ffffffffc0208dd8 <commands+0xc00>
ffffffffc0202464:	da5fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202468:	00007697          	auipc	a3,0x7
ffffffffc020246c:	a5868693          	addi	a3,a3,-1448 # ffffffffc0208ec0 <commands+0xce8>
ffffffffc0202470:	00006617          	auipc	a2,0x6
ffffffffc0202474:	17860613          	addi	a2,a2,376 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202478:	06900593          	li	a1,105
ffffffffc020247c:	00007517          	auipc	a0,0x7
ffffffffc0202480:	95c50513          	addi	a0,a0,-1700 # ffffffffc0208dd8 <commands+0xc00>
ffffffffc0202484:	d85fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202488:	00007697          	auipc	a3,0x7
ffffffffc020248c:	a2868693          	addi	a3,a3,-1496 # ffffffffc0208eb0 <commands+0xcd8>
ffffffffc0202490:	00006617          	auipc	a2,0x6
ffffffffc0202494:	15860613          	addi	a2,a2,344 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202498:	06600593          	li	a1,102
ffffffffc020249c:	00007517          	auipc	a0,0x7
ffffffffc02024a0:	93c50513          	addi	a0,a0,-1732 # ffffffffc0208dd8 <commands+0xc00>
ffffffffc02024a4:	d65fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02024a8:	00007697          	auipc	a3,0x7
ffffffffc02024ac:	9f868693          	addi	a3,a3,-1544 # ffffffffc0208ea0 <commands+0xcc8>
ffffffffc02024b0:	00006617          	auipc	a2,0x6
ffffffffc02024b4:	13860613          	addi	a2,a2,312 # ffffffffc02085e8 <commands+0x410>
ffffffffc02024b8:	06300593          	li	a1,99
ffffffffc02024bc:	00007517          	auipc	a0,0x7
ffffffffc02024c0:	91c50513          	addi	a0,a0,-1764 # ffffffffc0208dd8 <commands+0xc00>
ffffffffc02024c4:	d45fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02024c8:	00007697          	auipc	a3,0x7
ffffffffc02024cc:	9c868693          	addi	a3,a3,-1592 # ffffffffc0208e90 <commands+0xcb8>
ffffffffc02024d0:	00006617          	auipc	a2,0x6
ffffffffc02024d4:	11860613          	addi	a2,a2,280 # ffffffffc02085e8 <commands+0x410>
ffffffffc02024d8:	06000593          	li	a1,96
ffffffffc02024dc:	00007517          	auipc	a0,0x7
ffffffffc02024e0:	8fc50513          	addi	a0,a0,-1796 # ffffffffc0208dd8 <commands+0xc00>
ffffffffc02024e4:	d25fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02024e8:	00007697          	auipc	a3,0x7
ffffffffc02024ec:	9a868693          	addi	a3,a3,-1624 # ffffffffc0208e90 <commands+0xcb8>
ffffffffc02024f0:	00006617          	auipc	a2,0x6
ffffffffc02024f4:	0f860613          	addi	a2,a2,248 # ffffffffc02085e8 <commands+0x410>
ffffffffc02024f8:	05d00593          	li	a1,93
ffffffffc02024fc:	00007517          	auipc	a0,0x7
ffffffffc0202500:	8dc50513          	addi	a0,a0,-1828 # ffffffffc0208dd8 <commands+0xc00>
ffffffffc0202504:	d05fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202508:	00007697          	auipc	a3,0x7
ffffffffc020250c:	8c068693          	addi	a3,a3,-1856 # ffffffffc0208dc8 <commands+0xbf0>
ffffffffc0202510:	00006617          	auipc	a2,0x6
ffffffffc0202514:	0d860613          	addi	a2,a2,216 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202518:	05a00593          	li	a1,90
ffffffffc020251c:	00007517          	auipc	a0,0x7
ffffffffc0202520:	8bc50513          	addi	a0,a0,-1860 # ffffffffc0208dd8 <commands+0xc00>
ffffffffc0202524:	ce5fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202528:	00007697          	auipc	a3,0x7
ffffffffc020252c:	8a068693          	addi	a3,a3,-1888 # ffffffffc0208dc8 <commands+0xbf0>
ffffffffc0202530:	00006617          	auipc	a2,0x6
ffffffffc0202534:	0b860613          	addi	a2,a2,184 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202538:	05700593          	li	a1,87
ffffffffc020253c:	00007517          	auipc	a0,0x7
ffffffffc0202540:	89c50513          	addi	a0,a0,-1892 # ffffffffc0208dd8 <commands+0xc00>
ffffffffc0202544:	cc5fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202548:	00007697          	auipc	a3,0x7
ffffffffc020254c:	88068693          	addi	a3,a3,-1920 # ffffffffc0208dc8 <commands+0xbf0>
ffffffffc0202550:	00006617          	auipc	a2,0x6
ffffffffc0202554:	09860613          	addi	a2,a2,152 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202558:	05400593          	li	a1,84
ffffffffc020255c:	00007517          	auipc	a0,0x7
ffffffffc0202560:	87c50513          	addi	a0,a0,-1924 # ffffffffc0208dd8 <commands+0xc00>
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
ffffffffc020258e:	99e68693          	addi	a3,a3,-1634 # ffffffffc0208f28 <commands+0xd50>
ffffffffc0202592:	00006617          	auipc	a2,0x6
ffffffffc0202596:	05660613          	addi	a2,a2,86 # ffffffffc02085e8 <commands+0x410>
ffffffffc020259a:	04100593          	li	a1,65
ffffffffc020259e:	00007517          	auipc	a0,0x7
ffffffffc02025a2:	83a50513          	addi	a0,a0,-1990 # ffffffffc0208dd8 <commands+0xc00>
ffffffffc02025a6:	c63fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02025aa:	00007697          	auipc	a3,0x7
ffffffffc02025ae:	98e68693          	addi	a3,a3,-1650 # ffffffffc0208f38 <commands+0xd60>
ffffffffc02025b2:	00006617          	auipc	a2,0x6
ffffffffc02025b6:	03660613          	addi	a2,a2,54 # ffffffffc02085e8 <commands+0x410>
ffffffffc02025ba:	04200593          	li	a1,66
ffffffffc02025be:	00007517          	auipc	a0,0x7
ffffffffc02025c2:	81a50513          	addi	a0,a0,-2022 # ffffffffc0208dd8 <commands+0xc00>
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
ffffffffc02025e6:	96668693          	addi	a3,a3,-1690 # ffffffffc0208f48 <commands+0xd70>
ffffffffc02025ea:	00006617          	auipc	a2,0x6
ffffffffc02025ee:	ffe60613          	addi	a2,a2,-2 # ffffffffc02085e8 <commands+0x410>
ffffffffc02025f2:	03200593          	li	a1,50
ffffffffc02025f6:	00006517          	auipc	a0,0x6
ffffffffc02025fa:	7e250513          	addi	a0,a0,2018 # ffffffffc0208dd8 <commands+0xc00>
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
ffffffffc02026c0:	f7463603          	ld	a2,-140(a2) # ffffffffc020a630 <nbase>
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
ffffffffc0202906:	67e68693          	addi	a3,a3,1662 # ffffffffc0208f80 <commands+0xda8>
ffffffffc020290a:	00006617          	auipc	a2,0x6
ffffffffc020290e:	cde60613          	addi	a2,a2,-802 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202912:	0f000593          	li	a1,240
ffffffffc0202916:	00006517          	auipc	a0,0x6
ffffffffc020291a:	67a50513          	addi	a0,a0,1658 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc020291e:	8ebfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202922:	00006697          	auipc	a3,0x6
ffffffffc0202926:	70668693          	addi	a3,a3,1798 # ffffffffc0209028 <commands+0xe50>
ffffffffc020292a:	00006617          	auipc	a2,0x6
ffffffffc020292e:	cbe60613          	addi	a2,a2,-834 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202932:	0bd00593          	li	a1,189
ffffffffc0202936:	00006517          	auipc	a0,0x6
ffffffffc020293a:	65a50513          	addi	a0,a0,1626 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc020293e:	8cbfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202942:	00006697          	auipc	a3,0x6
ffffffffc0202946:	70e68693          	addi	a3,a3,1806 # ffffffffc0209050 <commands+0xe78>
ffffffffc020294a:	00006617          	auipc	a2,0x6
ffffffffc020294e:	c9e60613          	addi	a2,a2,-866 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202952:	0be00593          	li	a1,190
ffffffffc0202956:	00006517          	auipc	a0,0x6
ffffffffc020295a:	63a50513          	addi	a0,a0,1594 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc020295e:	8abfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202962:	00006697          	auipc	a3,0x6
ffffffffc0202966:	72e68693          	addi	a3,a3,1838 # ffffffffc0209090 <commands+0xeb8>
ffffffffc020296a:	00006617          	auipc	a2,0x6
ffffffffc020296e:	c7e60613          	addi	a2,a2,-898 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202972:	0c000593          	li	a1,192
ffffffffc0202976:	00006517          	auipc	a0,0x6
ffffffffc020297a:	61a50513          	addi	a0,a0,1562 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc020297e:	88bfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202982:	00006697          	auipc	a3,0x6
ffffffffc0202986:	79668693          	addi	a3,a3,1942 # ffffffffc0209118 <commands+0xf40>
ffffffffc020298a:	00006617          	auipc	a2,0x6
ffffffffc020298e:	c5e60613          	addi	a2,a2,-930 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202992:	0d900593          	li	a1,217
ffffffffc0202996:	00006517          	auipc	a0,0x6
ffffffffc020299a:	5fa50513          	addi	a0,a0,1530 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc020299e:	86bfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02029a2:	00006697          	auipc	a3,0x6
ffffffffc02029a6:	62668693          	addi	a3,a3,1574 # ffffffffc0208fc8 <commands+0xdf0>
ffffffffc02029aa:	00006617          	auipc	a2,0x6
ffffffffc02029ae:	c3e60613          	addi	a2,a2,-962 # ffffffffc02085e8 <commands+0x410>
ffffffffc02029b2:	0d200593          	li	a1,210
ffffffffc02029b6:	00006517          	auipc	a0,0x6
ffffffffc02029ba:	5da50513          	addi	a0,a0,1498 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc02029be:	84bfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02029c2:	00006697          	auipc	a3,0x6
ffffffffc02029c6:	74668693          	addi	a3,a3,1862 # ffffffffc0209108 <commands+0xf30>
ffffffffc02029ca:	00006617          	auipc	a2,0x6
ffffffffc02029ce:	c1e60613          	addi	a2,a2,-994 # ffffffffc02085e8 <commands+0x410>
ffffffffc02029d2:	0d000593          	li	a1,208
ffffffffc02029d6:	00006517          	auipc	a0,0x6
ffffffffc02029da:	5ba50513          	addi	a0,a0,1466 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc02029de:	82bfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02029e2:	00006697          	auipc	a3,0x6
ffffffffc02029e6:	70e68693          	addi	a3,a3,1806 # ffffffffc02090f0 <commands+0xf18>
ffffffffc02029ea:	00006617          	auipc	a2,0x6
ffffffffc02029ee:	bfe60613          	addi	a2,a2,-1026 # ffffffffc02085e8 <commands+0x410>
ffffffffc02029f2:	0cb00593          	li	a1,203
ffffffffc02029f6:	00006517          	auipc	a0,0x6
ffffffffc02029fa:	59a50513          	addi	a0,a0,1434 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc02029fe:	80bfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a02:	00006697          	auipc	a3,0x6
ffffffffc0202a06:	6ce68693          	addi	a3,a3,1742 # ffffffffc02090d0 <commands+0xef8>
ffffffffc0202a0a:	00006617          	auipc	a2,0x6
ffffffffc0202a0e:	bde60613          	addi	a2,a2,-1058 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202a12:	0c200593          	li	a1,194
ffffffffc0202a16:	00006517          	auipc	a0,0x6
ffffffffc0202a1a:	57a50513          	addi	a0,a0,1402 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202a1e:	feafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a22:	00006697          	auipc	a3,0x6
ffffffffc0202a26:	73e68693          	addi	a3,a3,1854 # ffffffffc0209160 <commands+0xf88>
ffffffffc0202a2a:	00006617          	auipc	a2,0x6
ffffffffc0202a2e:	bbe60613          	addi	a2,a2,-1090 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202a32:	0f800593          	li	a1,248
ffffffffc0202a36:	00006517          	auipc	a0,0x6
ffffffffc0202a3a:	55a50513          	addi	a0,a0,1370 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202a3e:	fcafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a42:	00006697          	auipc	a3,0x6
ffffffffc0202a46:	70e68693          	addi	a3,a3,1806 # ffffffffc0209150 <commands+0xf78>
ffffffffc0202a4a:	00006617          	auipc	a2,0x6
ffffffffc0202a4e:	b9e60613          	addi	a2,a2,-1122 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202a52:	0df00593          	li	a1,223
ffffffffc0202a56:	00006517          	auipc	a0,0x6
ffffffffc0202a5a:	53a50513          	addi	a0,a0,1338 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202a5e:	faafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a62:	00006697          	auipc	a3,0x6
ffffffffc0202a66:	68e68693          	addi	a3,a3,1678 # ffffffffc02090f0 <commands+0xf18>
ffffffffc0202a6a:	00006617          	auipc	a2,0x6
ffffffffc0202a6e:	b7e60613          	addi	a2,a2,-1154 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202a72:	0dd00593          	li	a1,221
ffffffffc0202a76:	00006517          	auipc	a0,0x6
ffffffffc0202a7a:	51a50513          	addi	a0,a0,1306 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202a7e:	f8afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a82:	00006697          	auipc	a3,0x6
ffffffffc0202a86:	6ae68693          	addi	a3,a3,1710 # ffffffffc0209130 <commands+0xf58>
ffffffffc0202a8a:	00006617          	auipc	a2,0x6
ffffffffc0202a8e:	b5e60613          	addi	a2,a2,-1186 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202a92:	0dc00593          	li	a1,220
ffffffffc0202a96:	00006517          	auipc	a0,0x6
ffffffffc0202a9a:	4fa50513          	addi	a0,a0,1274 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202a9e:	f6afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202aa2:	00006697          	auipc	a3,0x6
ffffffffc0202aa6:	52668693          	addi	a3,a3,1318 # ffffffffc0208fc8 <commands+0xdf0>
ffffffffc0202aaa:	00006617          	auipc	a2,0x6
ffffffffc0202aae:	b3e60613          	addi	a2,a2,-1218 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202ab2:	0b900593          	li	a1,185
ffffffffc0202ab6:	00006517          	auipc	a0,0x6
ffffffffc0202aba:	4da50513          	addi	a0,a0,1242 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202abe:	f4afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ac2:	00006697          	auipc	a3,0x6
ffffffffc0202ac6:	62e68693          	addi	a3,a3,1582 # ffffffffc02090f0 <commands+0xf18>
ffffffffc0202aca:	00006617          	auipc	a2,0x6
ffffffffc0202ace:	b1e60613          	addi	a2,a2,-1250 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202ad2:	0d600593          	li	a1,214
ffffffffc0202ad6:	00006517          	auipc	a0,0x6
ffffffffc0202ada:	4ba50513          	addi	a0,a0,1210 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202ade:	f2afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ae2:	00006697          	auipc	a3,0x6
ffffffffc0202ae6:	52668693          	addi	a3,a3,1318 # ffffffffc0209008 <commands+0xe30>
ffffffffc0202aea:	00006617          	auipc	a2,0x6
ffffffffc0202aee:	afe60613          	addi	a2,a2,-1282 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202af2:	0d400593          	li	a1,212
ffffffffc0202af6:	00006517          	auipc	a0,0x6
ffffffffc0202afa:	49a50513          	addi	a0,a0,1178 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202afe:	f0afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b02:	00006697          	auipc	a3,0x6
ffffffffc0202b06:	4e668693          	addi	a3,a3,1254 # ffffffffc0208fe8 <commands+0xe10>
ffffffffc0202b0a:	00006617          	auipc	a2,0x6
ffffffffc0202b0e:	ade60613          	addi	a2,a2,-1314 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202b12:	0d300593          	li	a1,211
ffffffffc0202b16:	00006517          	auipc	a0,0x6
ffffffffc0202b1a:	47a50513          	addi	a0,a0,1146 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202b1e:	eeafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b22:	00006697          	auipc	a3,0x6
ffffffffc0202b26:	4e668693          	addi	a3,a3,1254 # ffffffffc0209008 <commands+0xe30>
ffffffffc0202b2a:	00006617          	auipc	a2,0x6
ffffffffc0202b2e:	abe60613          	addi	a2,a2,-1346 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202b32:	0bb00593          	li	a1,187
ffffffffc0202b36:	00006517          	auipc	a0,0x6
ffffffffc0202b3a:	45a50513          	addi	a0,a0,1114 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202b3e:	ecafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b42:	00006697          	auipc	a3,0x6
ffffffffc0202b46:	76e68693          	addi	a3,a3,1902 # ffffffffc02092b0 <commands+0x10d8>
ffffffffc0202b4a:	00006617          	auipc	a2,0x6
ffffffffc0202b4e:	a9e60613          	addi	a2,a2,-1378 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202b52:	12500593          	li	a1,293
ffffffffc0202b56:	00006517          	auipc	a0,0x6
ffffffffc0202b5a:	43a50513          	addi	a0,a0,1082 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202b5e:	eaafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b62:	00006697          	auipc	a3,0x6
ffffffffc0202b66:	5ee68693          	addi	a3,a3,1518 # ffffffffc0209150 <commands+0xf78>
ffffffffc0202b6a:	00006617          	auipc	a2,0x6
ffffffffc0202b6e:	a7e60613          	addi	a2,a2,-1410 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202b72:	11a00593          	li	a1,282
ffffffffc0202b76:	00006517          	auipc	a0,0x6
ffffffffc0202b7a:	41a50513          	addi	a0,a0,1050 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202b7e:	e8afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b82:	00006697          	auipc	a3,0x6
ffffffffc0202b86:	56e68693          	addi	a3,a3,1390 # ffffffffc02090f0 <commands+0xf18>
ffffffffc0202b8a:	00006617          	auipc	a2,0x6
ffffffffc0202b8e:	a5e60613          	addi	a2,a2,-1442 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202b92:	11800593          	li	a1,280
ffffffffc0202b96:	00006517          	auipc	a0,0x6
ffffffffc0202b9a:	3fa50513          	addi	a0,a0,1018 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202b9e:	e6afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ba2:	00006697          	auipc	a3,0x6
ffffffffc0202ba6:	50e68693          	addi	a3,a3,1294 # ffffffffc02090b0 <commands+0xed8>
ffffffffc0202baa:	00006617          	auipc	a2,0x6
ffffffffc0202bae:	a3e60613          	addi	a2,a2,-1474 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202bb2:	0c100593          	li	a1,193
ffffffffc0202bb6:	00006517          	auipc	a0,0x6
ffffffffc0202bba:	3da50513          	addi	a0,a0,986 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202bbe:	e4afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202bc2:	00006697          	auipc	a3,0x6
ffffffffc0202bc6:	6ae68693          	addi	a3,a3,1710 # ffffffffc0209270 <commands+0x1098>
ffffffffc0202bca:	00006617          	auipc	a2,0x6
ffffffffc0202bce:	a1e60613          	addi	a2,a2,-1506 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202bd2:	11200593          	li	a1,274
ffffffffc0202bd6:	00006517          	auipc	a0,0x6
ffffffffc0202bda:	3ba50513          	addi	a0,a0,954 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202bde:	e2afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202be2:	00006697          	auipc	a3,0x6
ffffffffc0202be6:	66e68693          	addi	a3,a3,1646 # ffffffffc0209250 <commands+0x1078>
ffffffffc0202bea:	00006617          	auipc	a2,0x6
ffffffffc0202bee:	9fe60613          	addi	a2,a2,-1538 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202bf2:	11000593          	li	a1,272
ffffffffc0202bf6:	00006517          	auipc	a0,0x6
ffffffffc0202bfa:	39a50513          	addi	a0,a0,922 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202bfe:	e0afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c02:	00006697          	auipc	a3,0x6
ffffffffc0202c06:	62668693          	addi	a3,a3,1574 # ffffffffc0209228 <commands+0x1050>
ffffffffc0202c0a:	00006617          	auipc	a2,0x6
ffffffffc0202c0e:	9de60613          	addi	a2,a2,-1570 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202c12:	10e00593          	li	a1,270
ffffffffc0202c16:	00006517          	auipc	a0,0x6
ffffffffc0202c1a:	37a50513          	addi	a0,a0,890 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202c1e:	deafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c22:	00006697          	auipc	a3,0x6
ffffffffc0202c26:	5de68693          	addi	a3,a3,1502 # ffffffffc0209200 <commands+0x1028>
ffffffffc0202c2a:	00006617          	auipc	a2,0x6
ffffffffc0202c2e:	9be60613          	addi	a2,a2,-1602 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202c32:	10d00593          	li	a1,269
ffffffffc0202c36:	00006517          	auipc	a0,0x6
ffffffffc0202c3a:	35a50513          	addi	a0,a0,858 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202c3e:	dcafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c42:	00006697          	auipc	a3,0x6
ffffffffc0202c46:	5ae68693          	addi	a3,a3,1454 # ffffffffc02091f0 <commands+0x1018>
ffffffffc0202c4a:	00006617          	auipc	a2,0x6
ffffffffc0202c4e:	99e60613          	addi	a2,a2,-1634 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202c52:	10800593          	li	a1,264
ffffffffc0202c56:	00006517          	auipc	a0,0x6
ffffffffc0202c5a:	33a50513          	addi	a0,a0,826 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202c5e:	daafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c62:	00006697          	auipc	a3,0x6
ffffffffc0202c66:	48e68693          	addi	a3,a3,1166 # ffffffffc02090f0 <commands+0xf18>
ffffffffc0202c6a:	00006617          	auipc	a2,0x6
ffffffffc0202c6e:	97e60613          	addi	a2,a2,-1666 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202c72:	10700593          	li	a1,263
ffffffffc0202c76:	00006517          	auipc	a0,0x6
ffffffffc0202c7a:	31a50513          	addi	a0,a0,794 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202c7e:	d8afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c82:	00006697          	auipc	a3,0x6
ffffffffc0202c86:	54e68693          	addi	a3,a3,1358 # ffffffffc02091d0 <commands+0xff8>
ffffffffc0202c8a:	00006617          	auipc	a2,0x6
ffffffffc0202c8e:	95e60613          	addi	a2,a2,-1698 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202c92:	10600593          	li	a1,262
ffffffffc0202c96:	00006517          	auipc	a0,0x6
ffffffffc0202c9a:	2fa50513          	addi	a0,a0,762 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202c9e:	d6afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ca2:	00006697          	auipc	a3,0x6
ffffffffc0202ca6:	4fe68693          	addi	a3,a3,1278 # ffffffffc02091a0 <commands+0xfc8>
ffffffffc0202caa:	00006617          	auipc	a2,0x6
ffffffffc0202cae:	93e60613          	addi	a2,a2,-1730 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202cb2:	10500593          	li	a1,261
ffffffffc0202cb6:	00006517          	auipc	a0,0x6
ffffffffc0202cba:	2da50513          	addi	a0,a0,730 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202cbe:	d4afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202cc2:	00006697          	auipc	a3,0x6
ffffffffc0202cc6:	4c668693          	addi	a3,a3,1222 # ffffffffc0209188 <commands+0xfb0>
ffffffffc0202cca:	00006617          	auipc	a2,0x6
ffffffffc0202cce:	91e60613          	addi	a2,a2,-1762 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202cd2:	10400593          	li	a1,260
ffffffffc0202cd6:	00006517          	auipc	a0,0x6
ffffffffc0202cda:	2ba50513          	addi	a0,a0,698 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202cde:	d2afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ce2:	00006697          	auipc	a3,0x6
ffffffffc0202ce6:	40e68693          	addi	a3,a3,1038 # ffffffffc02090f0 <commands+0xf18>
ffffffffc0202cea:	00006617          	auipc	a2,0x6
ffffffffc0202cee:	8fe60613          	addi	a2,a2,-1794 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202cf2:	0fe00593          	li	a1,254
ffffffffc0202cf6:	00006517          	auipc	a0,0x6
ffffffffc0202cfa:	29a50513          	addi	a0,a0,666 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202cfe:	d0afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d02:	00006697          	auipc	a3,0x6
ffffffffc0202d06:	46e68693          	addi	a3,a3,1134 # ffffffffc0209170 <commands+0xf98>
ffffffffc0202d0a:	00006617          	auipc	a2,0x6
ffffffffc0202d0e:	8de60613          	addi	a2,a2,-1826 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202d12:	0f900593          	li	a1,249
ffffffffc0202d16:	00006517          	auipc	a0,0x6
ffffffffc0202d1a:	27a50513          	addi	a0,a0,634 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202d1e:	ceafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d22:	00006697          	auipc	a3,0x6
ffffffffc0202d26:	56e68693          	addi	a3,a3,1390 # ffffffffc0209290 <commands+0x10b8>
ffffffffc0202d2a:	00006617          	auipc	a2,0x6
ffffffffc0202d2e:	8be60613          	addi	a2,a2,-1858 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202d32:	11700593          	li	a1,279
ffffffffc0202d36:	00006517          	auipc	a0,0x6
ffffffffc0202d3a:	25a50513          	addi	a0,a0,602 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202d3e:	ccafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d42:	00006697          	auipc	a3,0x6
ffffffffc0202d46:	57e68693          	addi	a3,a3,1406 # ffffffffc02092c0 <commands+0x10e8>
ffffffffc0202d4a:	00006617          	auipc	a2,0x6
ffffffffc0202d4e:	89e60613          	addi	a2,a2,-1890 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202d52:	12600593          	li	a1,294
ffffffffc0202d56:	00006517          	auipc	a0,0x6
ffffffffc0202d5a:	23a50513          	addi	a0,a0,570 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202d5e:	caafd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d62:	00006697          	auipc	a3,0x6
ffffffffc0202d66:	24668693          	addi	a3,a3,582 # ffffffffc0208fa8 <commands+0xdd0>
ffffffffc0202d6a:	00006617          	auipc	a2,0x6
ffffffffc0202d6e:	87e60613          	addi	a2,a2,-1922 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202d72:	0f300593          	li	a1,243
ffffffffc0202d76:	00006517          	auipc	a0,0x6
ffffffffc0202d7a:	21a50513          	addi	a0,a0,538 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202d7e:	c8afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d82:	00006697          	auipc	a3,0x6
ffffffffc0202d86:	26668693          	addi	a3,a3,614 # ffffffffc0208fe8 <commands+0xe10>
ffffffffc0202d8a:	00006617          	auipc	a2,0x6
ffffffffc0202d8e:	85e60613          	addi	a2,a2,-1954 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202d92:	0ba00593          	li	a1,186
ffffffffc0202d96:	00006517          	auipc	a0,0x6
ffffffffc0202d9a:	1fa50513          	addi	a0,a0,506 # ffffffffc0208f90 <commands+0xdb8>
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
ffffffffc0202ec8:	41468693          	addi	a3,a3,1044 # ffffffffc02092d8 <commands+0x1100>
ffffffffc0202ecc:	00005617          	auipc	a2,0x5
ffffffffc0202ed0:	71c60613          	addi	a2,a2,1820 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202ed4:	08300593          	li	a1,131
ffffffffc0202ed8:	00006517          	auipc	a0,0x6
ffffffffc0202edc:	0b850513          	addi	a0,a0,184 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202ee0:	b28fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ee4:	00006697          	auipc	a3,0x6
ffffffffc0202ee8:	3ec68693          	addi	a3,a3,1004 # ffffffffc02092d0 <commands+0x10f8>
ffffffffc0202eec:	00005617          	auipc	a2,0x5
ffffffffc0202ef0:	6fc60613          	addi	a2,a2,1788 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202ef4:	08000593          	li	a1,128
ffffffffc0202ef8:	00006517          	auipc	a0,0x6
ffffffffc0202efc:	09850513          	addi	a0,a0,152 # ffffffffc0208f90 <commands+0xdb8>
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
ffffffffc0202f9a:	33a68693          	addi	a3,a3,826 # ffffffffc02092d0 <commands+0x10f8>
ffffffffc0202f9e:	00005617          	auipc	a2,0x5
ffffffffc0202fa2:	64a60613          	addi	a2,a2,1610 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202fa6:	06200593          	li	a1,98
ffffffffc0202faa:	00006517          	auipc	a0,0x6
ffffffffc0202fae:	fe650513          	addi	a0,a0,-26 # ffffffffc0208f90 <commands+0xdb8>
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
ffffffffc020306c:	29868693          	addi	a3,a3,664 # ffffffffc0209300 <commands+0x1128>
ffffffffc0203070:	00005617          	auipc	a2,0x5
ffffffffc0203074:	57860613          	addi	a2,a2,1400 # ffffffffc02085e8 <commands+0x410>
ffffffffc0203078:	04900593          	li	a1,73
ffffffffc020307c:	00006517          	auipc	a0,0x6
ffffffffc0203080:	f1450513          	addi	a0,a0,-236 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0203084:	984fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203088:	00006697          	auipc	a3,0x6
ffffffffc020308c:	24868693          	addi	a3,a3,584 # ffffffffc02092d0 <commands+0x10f8>
ffffffffc0203090:	00005617          	auipc	a2,0x5
ffffffffc0203094:	55860613          	addi	a2,a2,1368 # ffffffffc02085e8 <commands+0x410>
ffffffffc0203098:	04600593          	li	a1,70
ffffffffc020309c:	00006517          	auipc	a0,0x6
ffffffffc02030a0:	ef450513          	addi	a0,a0,-268 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc02030a4:	964fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02030a8 <phi_test_sema>:
ffffffffc02030a8:	00016697          	auipc	a3,0x16
ffffffffc02030ac:	5d868693          	addi	a3,a3,1496 # ffffffffc0219680 <state_sema>
ffffffffc02030b0:	00251793          	slli	a5,a0,0x2
ffffffffc02030b4:	97b6                	add	a5,a5,a3
ffffffffc02030b6:	4390                	lw	a2,0(a5)
ffffffffc02030b8:	4705                	li	a4,1
ffffffffc02030ba:	00e60363          	beq	a2,a4,ffffffffc02030c0 <phi_test_sema+0x18>
ffffffffc02030be:	8082                	ret
ffffffffc02030c0:	0045071b          	addiw	a4,a0,4
ffffffffc02030c4:	4595                	li	a1,5
ffffffffc02030c6:	02b7673b          	remw	a4,a4,a1
ffffffffc02030ca:	4609                	li	a2,2
ffffffffc02030cc:	070a                	slli	a4,a4,0x2
ffffffffc02030ce:	9736                	add	a4,a4,a3
ffffffffc02030d0:	4318                	lw	a4,0(a4)
ffffffffc02030d2:	fec706e3          	beq	a4,a2,ffffffffc02030be <phi_test_sema+0x16>
ffffffffc02030d6:	0015071b          	addiw	a4,a0,1
ffffffffc02030da:	02b7673b          	remw	a4,a4,a1
ffffffffc02030de:	070a                	slli	a4,a4,0x2
ffffffffc02030e0:	96ba                	add	a3,a3,a4
ffffffffc02030e2:	4298                	lw	a4,0(a3)
ffffffffc02030e4:	fcc70de3          	beq	a4,a2,ffffffffc02030be <phi_test_sema+0x16>
ffffffffc02030e8:	00151713          	slli	a4,a0,0x1
ffffffffc02030ec:	953a                	add	a0,a0,a4
ffffffffc02030ee:	050e                	slli	a0,a0,0x3
ffffffffc02030f0:	00016717          	auipc	a4,0x16
ffffffffc02030f4:	5d070713          	addi	a4,a4,1488 # ffffffffc02196c0 <s>
ffffffffc02030f8:	953a                	add	a0,a0,a4
ffffffffc02030fa:	c390                	sw	a2,0(a5)
ffffffffc02030fc:	aefd                	j	ffffffffc02034fa <up>

ffffffffc02030fe <phi_take_forks_sema>:
ffffffffc02030fe:	1141                	addi	sp,sp,-16
ffffffffc0203100:	e022                	sd	s0,0(sp)
ffffffffc0203102:	842a                	mv	s0,a0
ffffffffc0203104:	00016517          	auipc	a0,0x16
ffffffffc0203108:	54c50513          	addi	a0,a0,1356 # ffffffffc0219650 <mutex>
ffffffffc020310c:	e406                	sd	ra,8(sp)
ffffffffc020310e:	3ee000ef          	jal	ra,ffffffffc02034fc <down>
ffffffffc0203112:	00241713          	slli	a4,s0,0x2
ffffffffc0203116:	00016797          	auipc	a5,0x16
ffffffffc020311a:	56a78793          	addi	a5,a5,1386 # ffffffffc0219680 <state_sema>
ffffffffc020311e:	97ba                	add	a5,a5,a4
ffffffffc0203120:	8522                	mv	a0,s0
ffffffffc0203122:	4705                	li	a4,1
ffffffffc0203124:	c398                	sw	a4,0(a5)
ffffffffc0203126:	f83ff0ef          	jal	ra,ffffffffc02030a8 <phi_test_sema>
ffffffffc020312a:	00016517          	auipc	a0,0x16
ffffffffc020312e:	52650513          	addi	a0,a0,1318 # ffffffffc0219650 <mutex>
ffffffffc0203132:	3c8000ef          	jal	ra,ffffffffc02034fa <up>
ffffffffc0203136:	00141513          	slli	a0,s0,0x1
ffffffffc020313a:	942a                	add	s0,s0,a0
ffffffffc020313c:	040e                	slli	s0,s0,0x3
ffffffffc020313e:	00016517          	auipc	a0,0x16
ffffffffc0203142:	58250513          	addi	a0,a0,1410 # ffffffffc02196c0 <s>
ffffffffc0203146:	9522                	add	a0,a0,s0
ffffffffc0203148:	6402                	ld	s0,0(sp)
ffffffffc020314a:	60a2                	ld	ra,8(sp)
ffffffffc020314c:	0141                	addi	sp,sp,16
ffffffffc020314e:	a67d                	j	ffffffffc02034fc <down>

ffffffffc0203150 <phi_put_forks_sema>:
ffffffffc0203150:	1101                	addi	sp,sp,-32
ffffffffc0203152:	e822                	sd	s0,16(sp)
ffffffffc0203154:	842a                	mv	s0,a0
ffffffffc0203156:	00016517          	auipc	a0,0x16
ffffffffc020315a:	4fa50513          	addi	a0,a0,1274 # ffffffffc0219650 <mutex>
ffffffffc020315e:	ec06                	sd	ra,24(sp)
ffffffffc0203160:	e426                	sd	s1,8(sp)
ffffffffc0203162:	39a000ef          	jal	ra,ffffffffc02034fc <down>
ffffffffc0203166:	4495                	li	s1,5
ffffffffc0203168:	0044051b          	addiw	a0,s0,4
ffffffffc020316c:	0295653b          	remw	a0,a0,s1
ffffffffc0203170:	00241713          	slli	a4,s0,0x2
ffffffffc0203174:	00016797          	auipc	a5,0x16
ffffffffc0203178:	50c78793          	addi	a5,a5,1292 # ffffffffc0219680 <state_sema>
ffffffffc020317c:	97ba                	add	a5,a5,a4
ffffffffc020317e:	0007a023          	sw	zero,0(a5)
ffffffffc0203182:	f27ff0ef          	jal	ra,ffffffffc02030a8 <phi_test_sema>
ffffffffc0203186:	0014051b          	addiw	a0,s0,1
ffffffffc020318a:	0295653b          	remw	a0,a0,s1
ffffffffc020318e:	f1bff0ef          	jal	ra,ffffffffc02030a8 <phi_test_sema>
ffffffffc0203192:	6442                	ld	s0,16(sp)
ffffffffc0203194:	60e2                	ld	ra,24(sp)
ffffffffc0203196:	64a2                	ld	s1,8(sp)
ffffffffc0203198:	00016517          	auipc	a0,0x16
ffffffffc020319c:	4b850513          	addi	a0,a0,1208 # ffffffffc0219650 <mutex>
ffffffffc02031a0:	6105                	addi	sp,sp,32
ffffffffc02031a2:	aea1                	j	ffffffffc02034fa <up>

ffffffffc02031a4 <philosopher_using_semaphore>:
ffffffffc02031a4:	7179                	addi	sp,sp,-48
ffffffffc02031a6:	f022                	sd	s0,32(sp)
ffffffffc02031a8:	0005041b          	sext.w	s0,a0
ffffffffc02031ac:	85a2                	mv	a1,s0
ffffffffc02031ae:	00006517          	auipc	a0,0x6
ffffffffc02031b2:	1b250513          	addi	a0,a0,434 # ffffffffc0209360 <default_pmm_manager+0x38>
ffffffffc02031b6:	ec26                	sd	s1,24(sp)
ffffffffc02031b8:	e84a                	sd	s2,16(sp)
ffffffffc02031ba:	e44e                	sd	s3,8(sp)
ffffffffc02031bc:	e052                	sd	s4,0(sp)
ffffffffc02031be:	f406                	sd	ra,40(sp)
ffffffffc02031c0:	4485                	li	s1,1
ffffffffc02031c2:	f0bfc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02031c6:	00006a17          	auipc	s4,0x6
ffffffffc02031ca:	1baa0a13          	addi	s4,s4,442 # ffffffffc0209380 <default_pmm_manager+0x58>
ffffffffc02031ce:	00006997          	auipc	s3,0x6
ffffffffc02031d2:	1e298993          	addi	s3,s3,482 # ffffffffc02093b0 <default_pmm_manager+0x88>
ffffffffc02031d6:	4915                	li	s2,5
ffffffffc02031d8:	85a6                	mv	a1,s1
ffffffffc02031da:	8622                	mv	a2,s0
ffffffffc02031dc:	8552                	mv	a0,s4
ffffffffc02031de:	eeffc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02031e2:	4529                	li	a0,10
ffffffffc02031e4:	714010ef          	jal	ra,ffffffffc02048f8 <do_sleep>
ffffffffc02031e8:	8522                	mv	a0,s0
ffffffffc02031ea:	f15ff0ef          	jal	ra,ffffffffc02030fe <phi_take_forks_sema>
ffffffffc02031ee:	85a6                	mv	a1,s1
ffffffffc02031f0:	8622                	mv	a2,s0
ffffffffc02031f2:	854e                	mv	a0,s3
ffffffffc02031f4:	ed9fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02031f8:	4529                	li	a0,10
ffffffffc02031fa:	6fe010ef          	jal	ra,ffffffffc02048f8 <do_sleep>
ffffffffc02031fe:	2485                	addiw	s1,s1,1
ffffffffc0203200:	8522                	mv	a0,s0
ffffffffc0203202:	f4fff0ef          	jal	ra,ffffffffc0203150 <phi_put_forks_sema>
ffffffffc0203206:	fd2499e3          	bne	s1,s2,ffffffffc02031d8 <philosopher_using_semaphore+0x34>
ffffffffc020320a:	85a2                	mv	a1,s0
ffffffffc020320c:	00006517          	auipc	a0,0x6
ffffffffc0203210:	1d450513          	addi	a0,a0,468 # ffffffffc02093e0 <default_pmm_manager+0xb8>
ffffffffc0203214:	eb9fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0203218:	70a2                	ld	ra,40(sp)
ffffffffc020321a:	7402                	ld	s0,32(sp)
ffffffffc020321c:	64e2                	ld	s1,24(sp)
ffffffffc020321e:	6942                	ld	s2,16(sp)
ffffffffc0203220:	69a2                	ld	s3,8(sp)
ffffffffc0203222:	6a02                	ld	s4,0(sp)
ffffffffc0203224:	4501                	li	a0,0
ffffffffc0203226:	6145                	addi	sp,sp,48
ffffffffc0203228:	8082                	ret

ffffffffc020322a <check_sync>:
ffffffffc020322a:	7139                	addi	sp,sp,-64
ffffffffc020322c:	4585                	li	a1,1
ffffffffc020322e:	00016517          	auipc	a0,0x16
ffffffffc0203232:	42250513          	addi	a0,a0,1058 # ffffffffc0219650 <mutex>
ffffffffc0203236:	f822                	sd	s0,48(sp)
ffffffffc0203238:	f426                	sd	s1,40(sp)
ffffffffc020323a:	f04a                	sd	s2,32(sp)
ffffffffc020323c:	ec4e                	sd	s3,24(sp)
ffffffffc020323e:	e852                	sd	s4,16(sp)
ffffffffc0203240:	e456                	sd	s5,8(sp)
ffffffffc0203242:	fc06                	sd	ra,56(sp)
ffffffffc0203244:	00016917          	auipc	s2,0x16
ffffffffc0203248:	47c90913          	addi	s2,s2,1148 # ffffffffc02196c0 <s>
ffffffffc020324c:	2a6000ef          	jal	ra,ffffffffc02034f2 <sem_init>
ffffffffc0203250:	00016497          	auipc	s1,0x16
ffffffffc0203254:	44848493          	addi	s1,s1,1096 # ffffffffc0219698 <philosopher_proc_sema>
ffffffffc0203258:	4401                	li	s0,0
ffffffffc020325a:	00000a97          	auipc	s5,0x0
ffffffffc020325e:	f4aa8a93          	addi	s5,s5,-182 # ffffffffc02031a4 <philosopher_using_semaphore>
ffffffffc0203262:	00006a17          	auipc	s4,0x6
ffffffffc0203266:	1eea0a13          	addi	s4,s4,494 # ffffffffc0209450 <default_pmm_manager+0x128>
ffffffffc020326a:	4995                	li	s3,5
ffffffffc020326c:	4581                	li	a1,0
ffffffffc020326e:	854a                	mv	a0,s2
ffffffffc0203270:	282000ef          	jal	ra,ffffffffc02034f2 <sem_init>
ffffffffc0203274:	4601                	li	a2,0
ffffffffc0203276:	85a2                	mv	a1,s0
ffffffffc0203278:	8556                	mv	a0,s5
ffffffffc020327a:	23d000ef          	jal	ra,ffffffffc0203cb6 <kernel_thread>
ffffffffc020327e:	02a05663          	blez	a0,ffffffffc02032aa <check_sync+0x80>
ffffffffc0203282:	60a000ef          	jal	ra,ffffffffc020388c <find_proc>
ffffffffc0203286:	85d2                	mv	a1,s4
ffffffffc0203288:	0405                	addi	s0,s0,1
ffffffffc020328a:	e088                	sd	a0,0(s1)
ffffffffc020328c:	0961                	addi	s2,s2,24
ffffffffc020328e:	568000ef          	jal	ra,ffffffffc02037f6 <set_proc_name>
ffffffffc0203292:	04a1                	addi	s1,s1,8
ffffffffc0203294:	fd341ce3          	bne	s0,s3,ffffffffc020326c <check_sync+0x42>
ffffffffc0203298:	70e2                	ld	ra,56(sp)
ffffffffc020329a:	7442                	ld	s0,48(sp)
ffffffffc020329c:	74a2                	ld	s1,40(sp)
ffffffffc020329e:	7902                	ld	s2,32(sp)
ffffffffc02032a0:	69e2                	ld	s3,24(sp)
ffffffffc02032a2:	6a42                	ld	s4,16(sp)
ffffffffc02032a4:	6aa2                	ld	s5,8(sp)
ffffffffc02032a6:	6121                	addi	sp,sp,64
ffffffffc02032a8:	8082                	ret
ffffffffc02032aa:	00006617          	auipc	a2,0x6
ffffffffc02032ae:	15660613          	addi	a2,a2,342 # ffffffffc0209400 <default_pmm_manager+0xd8>
ffffffffc02032b2:	06500593          	li	a1,101
ffffffffc02032b6:	00006517          	auipc	a0,0x6
ffffffffc02032ba:	18250513          	addi	a0,a0,386 # ffffffffc0209438 <default_pmm_manager+0x110>
ffffffffc02032be:	f4bfc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02032c2 <wait_queue_del.part.0>:
ffffffffc02032c2:	1141                	addi	sp,sp,-16
ffffffffc02032c4:	00006697          	auipc	a3,0x6
ffffffffc02032c8:	1a468693          	addi	a3,a3,420 # ffffffffc0209468 <default_pmm_manager+0x140>
ffffffffc02032cc:	00005617          	auipc	a2,0x5
ffffffffc02032d0:	31c60613          	addi	a2,a2,796 # ffffffffc02085e8 <commands+0x410>
ffffffffc02032d4:	45f1                	li	a1,28
ffffffffc02032d6:	00006517          	auipc	a0,0x6
ffffffffc02032da:	1d250513          	addi	a0,a0,466 # ffffffffc02094a8 <default_pmm_manager+0x180>
ffffffffc02032de:	e406                	sd	ra,8(sp)
ffffffffc02032e0:	f29fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02032e4 <wait_queue_init>:
ffffffffc02032e4:	e508                	sd	a0,8(a0)
ffffffffc02032e6:	e108                	sd	a0,0(a0)
ffffffffc02032e8:	8082                	ret

ffffffffc02032ea <wait_queue_del>:
ffffffffc02032ea:	7198                	ld	a4,32(a1)
ffffffffc02032ec:	01858793          	addi	a5,a1,24
ffffffffc02032f0:	00e78b63          	beq	a5,a4,ffffffffc0203306 <wait_queue_del+0x1c>
ffffffffc02032f4:	6994                	ld	a3,16(a1)
ffffffffc02032f6:	00a69863          	bne	a3,a0,ffffffffc0203306 <wait_queue_del+0x1c>
ffffffffc02032fa:	6d94                	ld	a3,24(a1)
ffffffffc02032fc:	e698                	sd	a4,8(a3)
ffffffffc02032fe:	e314                	sd	a3,0(a4)
ffffffffc0203300:	f19c                	sd	a5,32(a1)
ffffffffc0203302:	ed9c                	sd	a5,24(a1)
ffffffffc0203304:	8082                	ret
ffffffffc0203306:	1141                	addi	sp,sp,-16
ffffffffc0203308:	e406                	sd	ra,8(sp)
ffffffffc020330a:	fb9ff0ef          	jal	ra,ffffffffc02032c2 <wait_queue_del.part.0>

ffffffffc020330e <wait_queue_first>:
ffffffffc020330e:	651c                	ld	a5,8(a0)
ffffffffc0203310:	00f50563          	beq	a0,a5,ffffffffc020331a <wait_queue_first+0xc>
ffffffffc0203314:	fe878513          	addi	a0,a5,-24
ffffffffc0203318:	8082                	ret
ffffffffc020331a:	4501                	li	a0,0
ffffffffc020331c:	8082                	ret

ffffffffc020331e <wait_in_queue>:
ffffffffc020331e:	711c                	ld	a5,32(a0)
ffffffffc0203320:	0561                	addi	a0,a0,24
ffffffffc0203322:	40a78533          	sub	a0,a5,a0
ffffffffc0203326:	00a03533          	snez	a0,a0
ffffffffc020332a:	8082                	ret

ffffffffc020332c <wakeup_wait>:
ffffffffc020332c:	ce91                	beqz	a3,ffffffffc0203348 <wakeup_wait+0x1c>
ffffffffc020332e:	7198                	ld	a4,32(a1)
ffffffffc0203330:	01858793          	addi	a5,a1,24
ffffffffc0203334:	00e78e63          	beq	a5,a4,ffffffffc0203350 <wakeup_wait+0x24>
ffffffffc0203338:	6994                	ld	a3,16(a1)
ffffffffc020333a:	00d51b63          	bne	a0,a3,ffffffffc0203350 <wakeup_wait+0x24>
ffffffffc020333e:	6d94                	ld	a3,24(a1)
ffffffffc0203340:	e698                	sd	a4,8(a3)
ffffffffc0203342:	e314                	sd	a3,0(a4)
ffffffffc0203344:	f19c                	sd	a5,32(a1)
ffffffffc0203346:	ed9c                	sd	a5,24(a1)
ffffffffc0203348:	6188                	ld	a0,0(a1)
ffffffffc020334a:	c590                	sw	a2,8(a1)
ffffffffc020334c:	6820106f          	j	ffffffffc02049ce <wakeup_proc>
ffffffffc0203350:	1141                	addi	sp,sp,-16
ffffffffc0203352:	e406                	sd	ra,8(sp)
ffffffffc0203354:	f6fff0ef          	jal	ra,ffffffffc02032c2 <wait_queue_del.part.0>

ffffffffc0203358 <wait_current_set>:
ffffffffc0203358:	00016797          	auipc	a5,0x16
ffffffffc020335c:	1a07b783          	ld	a5,416(a5) # ffffffffc02194f8 <current>
ffffffffc0203360:	c39d                	beqz	a5,ffffffffc0203386 <wait_current_set+0x2e>
ffffffffc0203362:	01858713          	addi	a4,a1,24
ffffffffc0203366:	800006b7          	lui	a3,0x80000
ffffffffc020336a:	ed98                	sd	a4,24(a1)
ffffffffc020336c:	e19c                	sd	a5,0(a1)
ffffffffc020336e:	c594                	sw	a3,8(a1)
ffffffffc0203370:	4685                	li	a3,1
ffffffffc0203372:	c394                	sw	a3,0(a5)
ffffffffc0203374:	0ec7a623          	sw	a2,236(a5)
ffffffffc0203378:	611c                	ld	a5,0(a0)
ffffffffc020337a:	e988                	sd	a0,16(a1)
ffffffffc020337c:	e118                	sd	a4,0(a0)
ffffffffc020337e:	e798                	sd	a4,8(a5)
ffffffffc0203380:	f188                	sd	a0,32(a1)
ffffffffc0203382:	ed9c                	sd	a5,24(a1)
ffffffffc0203384:	8082                	ret
ffffffffc0203386:	1141                	addi	sp,sp,-16
ffffffffc0203388:	00006697          	auipc	a3,0x6
ffffffffc020338c:	13868693          	addi	a3,a3,312 # ffffffffc02094c0 <default_pmm_manager+0x198>
ffffffffc0203390:	00005617          	auipc	a2,0x5
ffffffffc0203394:	25860613          	addi	a2,a2,600 # ffffffffc02085e8 <commands+0x410>
ffffffffc0203398:	07400593          	li	a1,116
ffffffffc020339c:	00006517          	auipc	a0,0x6
ffffffffc02033a0:	10c50513          	addi	a0,a0,268 # ffffffffc02094a8 <default_pmm_manager+0x180>
ffffffffc02033a4:	e406                	sd	ra,8(sp)
ffffffffc02033a6:	e63fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02033aa <__down.constprop.0>:
ffffffffc02033aa:	715d                	addi	sp,sp,-80
ffffffffc02033ac:	e0a2                	sd	s0,64(sp)
ffffffffc02033ae:	e486                	sd	ra,72(sp)
ffffffffc02033b0:	fc26                	sd	s1,56(sp)
ffffffffc02033b2:	842a                	mv	s0,a0
ffffffffc02033b4:	100027f3          	csrr	a5,sstatus
ffffffffc02033b8:	8b89                	andi	a5,a5,2
ffffffffc02033ba:	ebb1                	bnez	a5,ffffffffc020340e <__down.constprop.0+0x64>
ffffffffc02033bc:	411c                	lw	a5,0(a0)
ffffffffc02033be:	00f05a63          	blez	a5,ffffffffc02033d2 <__down.constprop.0+0x28>
ffffffffc02033c2:	37fd                	addiw	a5,a5,-1
ffffffffc02033c4:	c11c                	sw	a5,0(a0)
ffffffffc02033c6:	4501                	li	a0,0
ffffffffc02033c8:	60a6                	ld	ra,72(sp)
ffffffffc02033ca:	6406                	ld	s0,64(sp)
ffffffffc02033cc:	74e2                	ld	s1,56(sp)
ffffffffc02033ce:	6161                	addi	sp,sp,80
ffffffffc02033d0:	8082                	ret
ffffffffc02033d2:	00850413          	addi	s0,a0,8
ffffffffc02033d6:	0024                	addi	s1,sp,8
ffffffffc02033d8:	10000613          	li	a2,256
ffffffffc02033dc:	85a6                	mv	a1,s1
ffffffffc02033de:	8522                	mv	a0,s0
ffffffffc02033e0:	f79ff0ef          	jal	ra,ffffffffc0203358 <wait_current_set>
ffffffffc02033e4:	69c010ef          	jal	ra,ffffffffc0204a80 <schedule>
ffffffffc02033e8:	100027f3          	csrr	a5,sstatus
ffffffffc02033ec:	8b89                	andi	a5,a5,2
ffffffffc02033ee:	efb9                	bnez	a5,ffffffffc020344c <__down.constprop.0+0xa2>
ffffffffc02033f0:	8526                	mv	a0,s1
ffffffffc02033f2:	f2dff0ef          	jal	ra,ffffffffc020331e <wait_in_queue>
ffffffffc02033f6:	e531                	bnez	a0,ffffffffc0203442 <__down.constprop.0+0x98>
ffffffffc02033f8:	4542                	lw	a0,16(sp)
ffffffffc02033fa:	10000793          	li	a5,256
ffffffffc02033fe:	fcf515e3          	bne	a0,a5,ffffffffc02033c8 <__down.constprop.0+0x1e>
ffffffffc0203402:	60a6                	ld	ra,72(sp)
ffffffffc0203404:	6406                	ld	s0,64(sp)
ffffffffc0203406:	74e2                	ld	s1,56(sp)
ffffffffc0203408:	4501                	li	a0,0
ffffffffc020340a:	6161                	addi	sp,sp,80
ffffffffc020340c:	8082                	ret
ffffffffc020340e:	a2afd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203412:	401c                	lw	a5,0(s0)
ffffffffc0203414:	00f05c63          	blez	a5,ffffffffc020342c <__down.constprop.0+0x82>
ffffffffc0203418:	37fd                	addiw	a5,a5,-1
ffffffffc020341a:	c01c                	sw	a5,0(s0)
ffffffffc020341c:	a16fd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203420:	60a6                	ld	ra,72(sp)
ffffffffc0203422:	6406                	ld	s0,64(sp)
ffffffffc0203424:	74e2                	ld	s1,56(sp)
ffffffffc0203426:	4501                	li	a0,0
ffffffffc0203428:	6161                	addi	sp,sp,80
ffffffffc020342a:	8082                	ret
ffffffffc020342c:	0421                	addi	s0,s0,8
ffffffffc020342e:	0024                	addi	s1,sp,8
ffffffffc0203430:	10000613          	li	a2,256
ffffffffc0203434:	85a6                	mv	a1,s1
ffffffffc0203436:	8522                	mv	a0,s0
ffffffffc0203438:	f21ff0ef          	jal	ra,ffffffffc0203358 <wait_current_set>
ffffffffc020343c:	9f6fd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203440:	b755                	j	ffffffffc02033e4 <__down.constprop.0+0x3a>
ffffffffc0203442:	85a6                	mv	a1,s1
ffffffffc0203444:	8522                	mv	a0,s0
ffffffffc0203446:	ea5ff0ef          	jal	ra,ffffffffc02032ea <wait_queue_del>
ffffffffc020344a:	b77d                	j	ffffffffc02033f8 <__down.constprop.0+0x4e>
ffffffffc020344c:	9ecfd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203450:	8526                	mv	a0,s1
ffffffffc0203452:	ecdff0ef          	jal	ra,ffffffffc020331e <wait_in_queue>
ffffffffc0203456:	e501                	bnez	a0,ffffffffc020345e <__down.constprop.0+0xb4>
ffffffffc0203458:	9dafd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc020345c:	bf71                	j	ffffffffc02033f8 <__down.constprop.0+0x4e>
ffffffffc020345e:	85a6                	mv	a1,s1
ffffffffc0203460:	8522                	mv	a0,s0
ffffffffc0203462:	e89ff0ef          	jal	ra,ffffffffc02032ea <wait_queue_del>
ffffffffc0203466:	bfcd                	j	ffffffffc0203458 <__down.constprop.0+0xae>

ffffffffc0203468 <__up.constprop.0>:
ffffffffc0203468:	1101                	addi	sp,sp,-32
ffffffffc020346a:	e822                	sd	s0,16(sp)
ffffffffc020346c:	ec06                	sd	ra,24(sp)
ffffffffc020346e:	e426                	sd	s1,8(sp)
ffffffffc0203470:	e04a                	sd	s2,0(sp)
ffffffffc0203472:	842a                	mv	s0,a0
ffffffffc0203474:	100027f3          	csrr	a5,sstatus
ffffffffc0203478:	8b89                	andi	a5,a5,2
ffffffffc020347a:	4901                	li	s2,0
ffffffffc020347c:	eba1                	bnez	a5,ffffffffc02034cc <__up.constprop.0+0x64>
ffffffffc020347e:	00840493          	addi	s1,s0,8
ffffffffc0203482:	8526                	mv	a0,s1
ffffffffc0203484:	e8bff0ef          	jal	ra,ffffffffc020330e <wait_queue_first>
ffffffffc0203488:	85aa                	mv	a1,a0
ffffffffc020348a:	cd0d                	beqz	a0,ffffffffc02034c4 <__up.constprop.0+0x5c>
ffffffffc020348c:	6118                	ld	a4,0(a0)
ffffffffc020348e:	10000793          	li	a5,256
ffffffffc0203492:	0ec72703          	lw	a4,236(a4)
ffffffffc0203496:	02f71f63          	bne	a4,a5,ffffffffc02034d4 <__up.constprop.0+0x6c>
ffffffffc020349a:	4685                	li	a3,1
ffffffffc020349c:	10000613          	li	a2,256
ffffffffc02034a0:	8526                	mv	a0,s1
ffffffffc02034a2:	e8bff0ef          	jal	ra,ffffffffc020332c <wakeup_wait>
ffffffffc02034a6:	00091863          	bnez	s2,ffffffffc02034b6 <__up.constprop.0+0x4e>
ffffffffc02034aa:	60e2                	ld	ra,24(sp)
ffffffffc02034ac:	6442                	ld	s0,16(sp)
ffffffffc02034ae:	64a2                	ld	s1,8(sp)
ffffffffc02034b0:	6902                	ld	s2,0(sp)
ffffffffc02034b2:	6105                	addi	sp,sp,32
ffffffffc02034b4:	8082                	ret
ffffffffc02034b6:	6442                	ld	s0,16(sp)
ffffffffc02034b8:	60e2                	ld	ra,24(sp)
ffffffffc02034ba:	64a2                	ld	s1,8(sp)
ffffffffc02034bc:	6902                	ld	s2,0(sp)
ffffffffc02034be:	6105                	addi	sp,sp,32
ffffffffc02034c0:	972fd06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc02034c4:	401c                	lw	a5,0(s0)
ffffffffc02034c6:	2785                	addiw	a5,a5,1
ffffffffc02034c8:	c01c                	sw	a5,0(s0)
ffffffffc02034ca:	bff1                	j	ffffffffc02034a6 <__up.constprop.0+0x3e>
ffffffffc02034cc:	96cfd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02034d0:	4905                	li	s2,1
ffffffffc02034d2:	b775                	j	ffffffffc020347e <__up.constprop.0+0x16>
ffffffffc02034d4:	00006697          	auipc	a3,0x6
ffffffffc02034d8:	ffc68693          	addi	a3,a3,-4 # ffffffffc02094d0 <default_pmm_manager+0x1a8>
ffffffffc02034dc:	00005617          	auipc	a2,0x5
ffffffffc02034e0:	10c60613          	addi	a2,a2,268 # ffffffffc02085e8 <commands+0x410>
ffffffffc02034e4:	45e5                	li	a1,25
ffffffffc02034e6:	00006517          	auipc	a0,0x6
ffffffffc02034ea:	01250513          	addi	a0,a0,18 # ffffffffc02094f8 <default_pmm_manager+0x1d0>
ffffffffc02034ee:	d1bfc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02034f2 <sem_init>:
ffffffffc02034f2:	c10c                	sw	a1,0(a0)
ffffffffc02034f4:	0521                	addi	a0,a0,8
ffffffffc02034f6:	defff06f          	j	ffffffffc02032e4 <wait_queue_init>

ffffffffc02034fa <up>:
ffffffffc02034fa:	b7bd                	j	ffffffffc0203468 <__up.constprop.0>

ffffffffc02034fc <down>:
ffffffffc02034fc:	1141                	addi	sp,sp,-16
ffffffffc02034fe:	e406                	sd	ra,8(sp)
ffffffffc0203500:	eabff0ef          	jal	ra,ffffffffc02033aa <__down.constprop.0>
ffffffffc0203504:	2501                	sext.w	a0,a0
ffffffffc0203506:	e501                	bnez	a0,ffffffffc020350e <down+0x12>
ffffffffc0203508:	60a2                	ld	ra,8(sp)
ffffffffc020350a:	0141                	addi	sp,sp,16
ffffffffc020350c:	8082                	ret
ffffffffc020350e:	00006697          	auipc	a3,0x6
ffffffffc0203512:	ffa68693          	addi	a3,a3,-6 # ffffffffc0209508 <default_pmm_manager+0x1e0>
ffffffffc0203516:	00005617          	auipc	a2,0x5
ffffffffc020351a:	0d260613          	addi	a2,a2,210 # ffffffffc02085e8 <commands+0x410>
ffffffffc020351e:	04000593          	li	a1,64
ffffffffc0203522:	00006517          	auipc	a0,0x6
ffffffffc0203526:	fd650513          	addi	a0,a0,-42 # ffffffffc02094f8 <default_pmm_manager+0x1d0>
ffffffffc020352a:	cdffc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020352e <swapfs_init>:
ffffffffc020352e:	1141                	addi	sp,sp,-16
ffffffffc0203530:	4505                	li	a0,1
ffffffffc0203532:	e406                	sd	ra,8(sp)
ffffffffc0203534:	feffc0ef          	jal	ra,ffffffffc0200522 <ide_device_valid>
ffffffffc0203538:	cd01                	beqz	a0,ffffffffc0203550 <swapfs_init+0x22>
ffffffffc020353a:	4505                	li	a0,1
ffffffffc020353c:	fedfc0ef          	jal	ra,ffffffffc0200528 <ide_device_size>
ffffffffc0203540:	60a2                	ld	ra,8(sp)
ffffffffc0203542:	810d                	srli	a0,a0,0x3
ffffffffc0203544:	00016797          	auipc	a5,0x16
ffffffffc0203548:	08a7be23          	sd	a0,156(a5) # ffffffffc02195e0 <max_swap_offset>
ffffffffc020354c:	0141                	addi	sp,sp,16
ffffffffc020354e:	8082                	ret
ffffffffc0203550:	00006617          	auipc	a2,0x6
ffffffffc0203554:	fc860613          	addi	a2,a2,-56 # ffffffffc0209518 <default_pmm_manager+0x1f0>
ffffffffc0203558:	45b5                	li	a1,13
ffffffffc020355a:	00006517          	auipc	a0,0x6
ffffffffc020355e:	fde50513          	addi	a0,a0,-34 # ffffffffc0209538 <default_pmm_manager+0x210>
ffffffffc0203562:	ca7fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203566 <swapfs_read>:
ffffffffc0203566:	1141                	addi	sp,sp,-16
ffffffffc0203568:	e406                	sd	ra,8(sp)
ffffffffc020356a:	00855793          	srli	a5,a0,0x8
ffffffffc020356e:	cbb1                	beqz	a5,ffffffffc02035c2 <swapfs_read+0x5c>
ffffffffc0203570:	00016717          	auipc	a4,0x16
ffffffffc0203574:	07073703          	ld	a4,112(a4) # ffffffffc02195e0 <max_swap_offset>
ffffffffc0203578:	04e7f563          	bgeu	a5,a4,ffffffffc02035c2 <swapfs_read+0x5c>
ffffffffc020357c:	00016617          	auipc	a2,0x16
ffffffffc0203580:	fcc63603          	ld	a2,-52(a2) # ffffffffc0219548 <pages>
ffffffffc0203584:	8d91                	sub	a1,a1,a2
ffffffffc0203586:	4065d613          	srai	a2,a1,0x6
ffffffffc020358a:	00007717          	auipc	a4,0x7
ffffffffc020358e:	0a673703          	ld	a4,166(a4) # ffffffffc020a630 <nbase>
ffffffffc0203592:	963a                	add	a2,a2,a4
ffffffffc0203594:	00c61713          	slli	a4,a2,0xc
ffffffffc0203598:	8331                	srli	a4,a4,0xc
ffffffffc020359a:	00016697          	auipc	a3,0x16
ffffffffc020359e:	f366b683          	ld	a3,-202(a3) # ffffffffc02194d0 <npage>
ffffffffc02035a2:	0037959b          	slliw	a1,a5,0x3
ffffffffc02035a6:	0632                	slli	a2,a2,0xc
ffffffffc02035a8:	02d77963          	bgeu	a4,a3,ffffffffc02035da <swapfs_read+0x74>
ffffffffc02035ac:	60a2                	ld	ra,8(sp)
ffffffffc02035ae:	00016797          	auipc	a5,0x16
ffffffffc02035b2:	f8a7b783          	ld	a5,-118(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc02035b6:	46a1                	li	a3,8
ffffffffc02035b8:	963e                	add	a2,a2,a5
ffffffffc02035ba:	4505                	li	a0,1
ffffffffc02035bc:	0141                	addi	sp,sp,16
ffffffffc02035be:	f71fc06f          	j	ffffffffc020052e <ide_read_secs>
ffffffffc02035c2:	86aa                	mv	a3,a0
ffffffffc02035c4:	00006617          	auipc	a2,0x6
ffffffffc02035c8:	f8c60613          	addi	a2,a2,-116 # ffffffffc0209550 <default_pmm_manager+0x228>
ffffffffc02035cc:	45d1                	li	a1,20
ffffffffc02035ce:	00006517          	auipc	a0,0x6
ffffffffc02035d2:	f6a50513          	addi	a0,a0,-150 # ffffffffc0209538 <default_pmm_manager+0x210>
ffffffffc02035d6:	c33fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02035da:	86b2                	mv	a3,a2
ffffffffc02035dc:	06900593          	li	a1,105
ffffffffc02035e0:	00005617          	auipc	a2,0x5
ffffffffc02035e4:	3b860613          	addi	a2,a2,952 # ffffffffc0208998 <commands+0x7c0>
ffffffffc02035e8:	00005517          	auipc	a0,0x5
ffffffffc02035ec:	31050513          	addi	a0,a0,784 # ffffffffc02088f8 <commands+0x720>
ffffffffc02035f0:	c19fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02035f4 <swapfs_write>:
ffffffffc02035f4:	1141                	addi	sp,sp,-16
ffffffffc02035f6:	e406                	sd	ra,8(sp)
ffffffffc02035f8:	00855793          	srli	a5,a0,0x8
ffffffffc02035fc:	cbb1                	beqz	a5,ffffffffc0203650 <swapfs_write+0x5c>
ffffffffc02035fe:	00016717          	auipc	a4,0x16
ffffffffc0203602:	fe273703          	ld	a4,-30(a4) # ffffffffc02195e0 <max_swap_offset>
ffffffffc0203606:	04e7f563          	bgeu	a5,a4,ffffffffc0203650 <swapfs_write+0x5c>
ffffffffc020360a:	00016617          	auipc	a2,0x16
ffffffffc020360e:	f3e63603          	ld	a2,-194(a2) # ffffffffc0219548 <pages>
ffffffffc0203612:	8d91                	sub	a1,a1,a2
ffffffffc0203614:	4065d613          	srai	a2,a1,0x6
ffffffffc0203618:	00007717          	auipc	a4,0x7
ffffffffc020361c:	01873703          	ld	a4,24(a4) # ffffffffc020a630 <nbase>
ffffffffc0203620:	963a                	add	a2,a2,a4
ffffffffc0203622:	00c61713          	slli	a4,a2,0xc
ffffffffc0203626:	8331                	srli	a4,a4,0xc
ffffffffc0203628:	00016697          	auipc	a3,0x16
ffffffffc020362c:	ea86b683          	ld	a3,-344(a3) # ffffffffc02194d0 <npage>
ffffffffc0203630:	0037959b          	slliw	a1,a5,0x3
ffffffffc0203634:	0632                	slli	a2,a2,0xc
ffffffffc0203636:	02d77963          	bgeu	a4,a3,ffffffffc0203668 <swapfs_write+0x74>
ffffffffc020363a:	60a2                	ld	ra,8(sp)
ffffffffc020363c:	00016797          	auipc	a5,0x16
ffffffffc0203640:	efc7b783          	ld	a5,-260(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc0203644:	46a1                	li	a3,8
ffffffffc0203646:	963e                	add	a2,a2,a5
ffffffffc0203648:	4505                	li	a0,1
ffffffffc020364a:	0141                	addi	sp,sp,16
ffffffffc020364c:	f07fc06f          	j	ffffffffc0200552 <ide_write_secs>
ffffffffc0203650:	86aa                	mv	a3,a0
ffffffffc0203652:	00006617          	auipc	a2,0x6
ffffffffc0203656:	efe60613          	addi	a2,a2,-258 # ffffffffc0209550 <default_pmm_manager+0x228>
ffffffffc020365a:	45e5                	li	a1,25
ffffffffc020365c:	00006517          	auipc	a0,0x6
ffffffffc0203660:	edc50513          	addi	a0,a0,-292 # ffffffffc0209538 <default_pmm_manager+0x210>
ffffffffc0203664:	ba5fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203668:	86b2                	mv	a3,a2
ffffffffc020366a:	06900593          	li	a1,105
ffffffffc020366e:	00005617          	auipc	a2,0x5
ffffffffc0203672:	32a60613          	addi	a2,a2,810 # ffffffffc0208998 <commands+0x7c0>
ffffffffc0203676:	00005517          	auipc	a0,0x5
ffffffffc020367a:	28250513          	addi	a0,a0,642 # ffffffffc02088f8 <commands+0x720>
ffffffffc020367e:	b8bfc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203682 <kernel_thread_entry>:
ffffffffc0203682:	8526                	mv	a0,s1
ffffffffc0203684:	9402                	jalr	s0
ffffffffc0203686:	680000ef          	jal	ra,ffffffffc0203d06 <do_exit>

ffffffffc020368a <switch_to>:
ffffffffc020368a:	00153023          	sd	ra,0(a0)
ffffffffc020368e:	00253423          	sd	sp,8(a0)
ffffffffc0203692:	e900                	sd	s0,16(a0)
ffffffffc0203694:	ed04                	sd	s1,24(a0)
ffffffffc0203696:	03253023          	sd	s2,32(a0)
ffffffffc020369a:	03353423          	sd	s3,40(a0)
ffffffffc020369e:	03453823          	sd	s4,48(a0)
ffffffffc02036a2:	03553c23          	sd	s5,56(a0)
ffffffffc02036a6:	05653023          	sd	s6,64(a0)
ffffffffc02036aa:	05753423          	sd	s7,72(a0)
ffffffffc02036ae:	05853823          	sd	s8,80(a0)
ffffffffc02036b2:	05953c23          	sd	s9,88(a0)
ffffffffc02036b6:	07a53023          	sd	s10,96(a0)
ffffffffc02036ba:	07b53423          	sd	s11,104(a0)
ffffffffc02036be:	0005b083          	ld	ra,0(a1)
ffffffffc02036c2:	0085b103          	ld	sp,8(a1)
ffffffffc02036c6:	6980                	ld	s0,16(a1)
ffffffffc02036c8:	6d84                	ld	s1,24(a1)
ffffffffc02036ca:	0205b903          	ld	s2,32(a1)
ffffffffc02036ce:	0285b983          	ld	s3,40(a1)
ffffffffc02036d2:	0305ba03          	ld	s4,48(a1)
ffffffffc02036d6:	0385ba83          	ld	s5,56(a1)
ffffffffc02036da:	0405bb03          	ld	s6,64(a1)
ffffffffc02036de:	0485bb83          	ld	s7,72(a1)
ffffffffc02036e2:	0505bc03          	ld	s8,80(a1)
ffffffffc02036e6:	0585bc83          	ld	s9,88(a1)
ffffffffc02036ea:	0605bd03          	ld	s10,96(a1)
ffffffffc02036ee:	0685bd83          	ld	s11,104(a1)
ffffffffc02036f2:	8082                	ret

ffffffffc02036f4 <alloc_proc>:
ffffffffc02036f4:	1141                	addi	sp,sp,-16
ffffffffc02036f6:	14800513          	li	a0,328
ffffffffc02036fa:	e022                	sd	s0,0(sp)
ffffffffc02036fc:	e406                	sd	ra,8(sp)
ffffffffc02036fe:	973fe0ef          	jal	ra,ffffffffc0202070 <kmalloc>
ffffffffc0203702:	842a                	mv	s0,a0
ffffffffc0203704:	cd21                	beqz	a0,ffffffffc020375c <alloc_proc+0x68>
ffffffffc0203706:	57fd                	li	a5,-1
ffffffffc0203708:	1782                	slli	a5,a5,0x20
ffffffffc020370a:	e11c                	sd	a5,0(a0)
ffffffffc020370c:	07000613          	li	a2,112
ffffffffc0203710:	4581                	li	a1,0
ffffffffc0203712:	00052423          	sw	zero,8(a0)
ffffffffc0203716:	00053823          	sd	zero,16(a0)
ffffffffc020371a:	00053c23          	sd	zero,24(a0)
ffffffffc020371e:	02053023          	sd	zero,32(a0)
ffffffffc0203722:	02053423          	sd	zero,40(a0)
ffffffffc0203726:	03050513          	addi	a0,a0,48
ffffffffc020372a:	3dc040ef          	jal	ra,ffffffffc0207b06 <memset>
ffffffffc020372e:	00016797          	auipc	a5,0x16
ffffffffc0203732:	e127b783          	ld	a5,-494(a5) # ffffffffc0219540 <boot_cr3>
ffffffffc0203736:	0a043023          	sd	zero,160(s0)
ffffffffc020373a:	f45c                	sd	a5,168(s0)
ffffffffc020373c:	0a042823          	sw	zero,176(s0)
ffffffffc0203740:	463d                	li	a2,15
ffffffffc0203742:	4581                	li	a1,0
ffffffffc0203744:	0b440513          	addi	a0,s0,180
ffffffffc0203748:	3be040ef          	jal	ra,ffffffffc0207b06 <memset>
ffffffffc020374c:	0e042623          	sw	zero,236(s0)
ffffffffc0203750:	0e043c23          	sd	zero,248(s0)
ffffffffc0203754:	10043023          	sd	zero,256(s0)
ffffffffc0203758:	0e043823          	sd	zero,240(s0)
ffffffffc020375c:	60a2                	ld	ra,8(sp)
ffffffffc020375e:	8522                	mv	a0,s0
ffffffffc0203760:	6402                	ld	s0,0(sp)
ffffffffc0203762:	0141                	addi	sp,sp,16
ffffffffc0203764:	8082                	ret

ffffffffc0203766 <forkret>:
ffffffffc0203766:	00016797          	auipc	a5,0x16
ffffffffc020376a:	d927b783          	ld	a5,-622(a5) # ffffffffc02194f8 <current>
ffffffffc020376e:	73c8                	ld	a0,160(a5)
ffffffffc0203770:	dbafd06f          	j	ffffffffc0200d2a <forkrets>

ffffffffc0203774 <setup_pgdir.isra.0>:
ffffffffc0203774:	1101                	addi	sp,sp,-32
ffffffffc0203776:	e426                	sd	s1,8(sp)
ffffffffc0203778:	84aa                	mv	s1,a0
ffffffffc020377a:	4505                	li	a0,1
ffffffffc020377c:	ec06                	sd	ra,24(sp)
ffffffffc020377e:	e822                	sd	s0,16(sp)
ffffffffc0203780:	dcafd0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0203784:	c939                	beqz	a0,ffffffffc02037da <setup_pgdir.isra.0+0x66>
ffffffffc0203786:	00016697          	auipc	a3,0x16
ffffffffc020378a:	dc26b683          	ld	a3,-574(a3) # ffffffffc0219548 <pages>
ffffffffc020378e:	40d506b3          	sub	a3,a0,a3
ffffffffc0203792:	8699                	srai	a3,a3,0x6
ffffffffc0203794:	00007417          	auipc	s0,0x7
ffffffffc0203798:	e9c43403          	ld	s0,-356(s0) # ffffffffc020a630 <nbase>
ffffffffc020379c:	96a2                	add	a3,a3,s0
ffffffffc020379e:	00c69793          	slli	a5,a3,0xc
ffffffffc02037a2:	83b1                	srli	a5,a5,0xc
ffffffffc02037a4:	00016717          	auipc	a4,0x16
ffffffffc02037a8:	d2c73703          	ld	a4,-724(a4) # ffffffffc02194d0 <npage>
ffffffffc02037ac:	06b2                	slli	a3,a3,0xc
ffffffffc02037ae:	02e7f863          	bgeu	a5,a4,ffffffffc02037de <setup_pgdir.isra.0+0x6a>
ffffffffc02037b2:	00016417          	auipc	s0,0x16
ffffffffc02037b6:	d8643403          	ld	s0,-634(s0) # ffffffffc0219538 <va_pa_offset>
ffffffffc02037ba:	9436                	add	s0,s0,a3
ffffffffc02037bc:	6605                	lui	a2,0x1
ffffffffc02037be:	00016597          	auipc	a1,0x16
ffffffffc02037c2:	d0a5b583          	ld	a1,-758(a1) # ffffffffc02194c8 <boot_pgdir>
ffffffffc02037c6:	8522                	mv	a0,s0
ffffffffc02037c8:	350040ef          	jal	ra,ffffffffc0207b18 <memcpy>
ffffffffc02037cc:	4501                	li	a0,0
ffffffffc02037ce:	e080                	sd	s0,0(s1)
ffffffffc02037d0:	60e2                	ld	ra,24(sp)
ffffffffc02037d2:	6442                	ld	s0,16(sp)
ffffffffc02037d4:	64a2                	ld	s1,8(sp)
ffffffffc02037d6:	6105                	addi	sp,sp,32
ffffffffc02037d8:	8082                	ret
ffffffffc02037da:	5571                	li	a0,-4
ffffffffc02037dc:	bfd5                	j	ffffffffc02037d0 <setup_pgdir.isra.0+0x5c>
ffffffffc02037de:	00005617          	auipc	a2,0x5
ffffffffc02037e2:	1ba60613          	addi	a2,a2,442 # ffffffffc0208998 <commands+0x7c0>
ffffffffc02037e6:	06900593          	li	a1,105
ffffffffc02037ea:	00005517          	auipc	a0,0x5
ffffffffc02037ee:	10e50513          	addi	a0,a0,270 # ffffffffc02088f8 <commands+0x720>
ffffffffc02037f2:	a17fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02037f6 <set_proc_name>:
ffffffffc02037f6:	1101                	addi	sp,sp,-32
ffffffffc02037f8:	e822                	sd	s0,16(sp)
ffffffffc02037fa:	0b450413          	addi	s0,a0,180
ffffffffc02037fe:	e426                	sd	s1,8(sp)
ffffffffc0203800:	4641                	li	a2,16
ffffffffc0203802:	84ae                	mv	s1,a1
ffffffffc0203804:	8522                	mv	a0,s0
ffffffffc0203806:	4581                	li	a1,0
ffffffffc0203808:	ec06                	sd	ra,24(sp)
ffffffffc020380a:	2fc040ef          	jal	ra,ffffffffc0207b06 <memset>
ffffffffc020380e:	8522                	mv	a0,s0
ffffffffc0203810:	6442                	ld	s0,16(sp)
ffffffffc0203812:	60e2                	ld	ra,24(sp)
ffffffffc0203814:	85a6                	mv	a1,s1
ffffffffc0203816:	64a2                	ld	s1,8(sp)
ffffffffc0203818:	463d                	li	a2,15
ffffffffc020381a:	6105                	addi	sp,sp,32
ffffffffc020381c:	2fc0406f          	j	ffffffffc0207b18 <memcpy>

ffffffffc0203820 <proc_run>:
ffffffffc0203820:	7179                	addi	sp,sp,-48
ffffffffc0203822:	ec4a                	sd	s2,24(sp)
ffffffffc0203824:	00016917          	auipc	s2,0x16
ffffffffc0203828:	cd490913          	addi	s2,s2,-812 # ffffffffc02194f8 <current>
ffffffffc020382c:	f026                	sd	s1,32(sp)
ffffffffc020382e:	00093483          	ld	s1,0(s2)
ffffffffc0203832:	f406                	sd	ra,40(sp)
ffffffffc0203834:	e84e                	sd	s3,16(sp)
ffffffffc0203836:	02a48863          	beq	s1,a0,ffffffffc0203866 <proc_run+0x46>
ffffffffc020383a:	100027f3          	csrr	a5,sstatus
ffffffffc020383e:	8b89                	andi	a5,a5,2
ffffffffc0203840:	4981                	li	s3,0
ffffffffc0203842:	ef9d                	bnez	a5,ffffffffc0203880 <proc_run+0x60>
ffffffffc0203844:	755c                	ld	a5,168(a0)
ffffffffc0203846:	577d                	li	a4,-1
ffffffffc0203848:	177e                	slli	a4,a4,0x3f
ffffffffc020384a:	83b1                	srli	a5,a5,0xc
ffffffffc020384c:	00a93023          	sd	a0,0(s2)
ffffffffc0203850:	8fd9                	or	a5,a5,a4
ffffffffc0203852:	18079073          	csrw	satp,a5
ffffffffc0203856:	03050593          	addi	a1,a0,48
ffffffffc020385a:	03048513          	addi	a0,s1,48
ffffffffc020385e:	e2dff0ef          	jal	ra,ffffffffc020368a <switch_to>
ffffffffc0203862:	00099863          	bnez	s3,ffffffffc0203872 <proc_run+0x52>
ffffffffc0203866:	70a2                	ld	ra,40(sp)
ffffffffc0203868:	7482                	ld	s1,32(sp)
ffffffffc020386a:	6962                	ld	s2,24(sp)
ffffffffc020386c:	69c2                	ld	s3,16(sp)
ffffffffc020386e:	6145                	addi	sp,sp,48
ffffffffc0203870:	8082                	ret
ffffffffc0203872:	70a2                	ld	ra,40(sp)
ffffffffc0203874:	7482                	ld	s1,32(sp)
ffffffffc0203876:	6962                	ld	s2,24(sp)
ffffffffc0203878:	69c2                	ld	s3,16(sp)
ffffffffc020387a:	6145                	addi	sp,sp,48
ffffffffc020387c:	db7fc06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0203880:	e42a                	sd	a0,8(sp)
ffffffffc0203882:	db7fc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203886:	6522                	ld	a0,8(sp)
ffffffffc0203888:	4985                	li	s3,1
ffffffffc020388a:	bf6d                	j	ffffffffc0203844 <proc_run+0x24>

ffffffffc020388c <find_proc>:
ffffffffc020388c:	6789                	lui	a5,0x2
ffffffffc020388e:	fff5071b          	addiw	a4,a0,-1
ffffffffc0203892:	17f9                	addi	a5,a5,-2
ffffffffc0203894:	04e7e063          	bltu	a5,a4,ffffffffc02038d4 <find_proc+0x48>
ffffffffc0203898:	1141                	addi	sp,sp,-16
ffffffffc020389a:	e022                	sd	s0,0(sp)
ffffffffc020389c:	45a9                	li	a1,10
ffffffffc020389e:	842a                	mv	s0,a0
ffffffffc02038a0:	2501                	sext.w	a0,a0
ffffffffc02038a2:	e406                	sd	ra,8(sp)
ffffffffc02038a4:	67a040ef          	jal	ra,ffffffffc0207f1e <hash32>
ffffffffc02038a8:	02051693          	slli	a3,a0,0x20
ffffffffc02038ac:	00012797          	auipc	a5,0x12
ffffffffc02038b0:	be478793          	addi	a5,a5,-1052 # ffffffffc0215490 <hash_list>
ffffffffc02038b4:	82f1                	srli	a3,a3,0x1c
ffffffffc02038b6:	96be                	add	a3,a3,a5
ffffffffc02038b8:	87b6                	mv	a5,a3
ffffffffc02038ba:	a029                	j	ffffffffc02038c4 <find_proc+0x38>
ffffffffc02038bc:	f2c7a703          	lw	a4,-212(a5)
ffffffffc02038c0:	00870c63          	beq	a4,s0,ffffffffc02038d8 <find_proc+0x4c>
ffffffffc02038c4:	679c                	ld	a5,8(a5)
ffffffffc02038c6:	fef69be3          	bne	a3,a5,ffffffffc02038bc <find_proc+0x30>
ffffffffc02038ca:	60a2                	ld	ra,8(sp)
ffffffffc02038cc:	6402                	ld	s0,0(sp)
ffffffffc02038ce:	4501                	li	a0,0
ffffffffc02038d0:	0141                	addi	sp,sp,16
ffffffffc02038d2:	8082                	ret
ffffffffc02038d4:	4501                	li	a0,0
ffffffffc02038d6:	8082                	ret
ffffffffc02038d8:	60a2                	ld	ra,8(sp)
ffffffffc02038da:	6402                	ld	s0,0(sp)
ffffffffc02038dc:	f2878513          	addi	a0,a5,-216
ffffffffc02038e0:	0141                	addi	sp,sp,16
ffffffffc02038e2:	8082                	ret

ffffffffc02038e4 <do_fork>:
ffffffffc02038e4:	7159                	addi	sp,sp,-112
ffffffffc02038e6:	e4ce                	sd	s3,72(sp)
ffffffffc02038e8:	00016997          	auipc	s3,0x16
ffffffffc02038ec:	c2898993          	addi	s3,s3,-984 # ffffffffc0219510 <nr_process>
ffffffffc02038f0:	0009a703          	lw	a4,0(s3)
ffffffffc02038f4:	f486                	sd	ra,104(sp)
ffffffffc02038f6:	f0a2                	sd	s0,96(sp)
ffffffffc02038f8:	eca6                	sd	s1,88(sp)
ffffffffc02038fa:	e8ca                	sd	s2,80(sp)
ffffffffc02038fc:	e0d2                	sd	s4,64(sp)
ffffffffc02038fe:	fc56                	sd	s5,56(sp)
ffffffffc0203900:	f85a                	sd	s6,48(sp)
ffffffffc0203902:	f45e                	sd	s7,40(sp)
ffffffffc0203904:	f062                	sd	s8,32(sp)
ffffffffc0203906:	ec66                	sd	s9,24(sp)
ffffffffc0203908:	e86a                	sd	s10,16(sp)
ffffffffc020390a:	e46e                	sd	s11,8(sp)
ffffffffc020390c:	6785                	lui	a5,0x1
ffffffffc020390e:	30f75f63          	bge	a4,a5,ffffffffc0203c2c <do_fork+0x348>
ffffffffc0203912:	8a2a                	mv	s4,a0
ffffffffc0203914:	892e                	mv	s2,a1
ffffffffc0203916:	84b2                	mv	s1,a2
ffffffffc0203918:	dddff0ef          	jal	ra,ffffffffc02036f4 <alloc_proc>
ffffffffc020391c:	842a                	mv	s0,a0
ffffffffc020391e:	28050263          	beqz	a0,ffffffffc0203ba2 <do_fork+0x2be>
ffffffffc0203922:	00016b97          	auipc	s7,0x16
ffffffffc0203926:	bd6b8b93          	addi	s7,s7,-1066 # ffffffffc02194f8 <current>
ffffffffc020392a:	000bb783          	ld	a5,0(s7)
ffffffffc020392e:	0ec7a703          	lw	a4,236(a5) # 10ec <kern_entry-0xffffffffc01fef14>
ffffffffc0203932:	f11c                	sd	a5,32(a0)
ffffffffc0203934:	30071c63          	bnez	a4,ffffffffc0203c4c <do_fork+0x368>
ffffffffc0203938:	4509                	li	a0,2
ffffffffc020393a:	c10fd0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc020393e:	24050f63          	beqz	a0,ffffffffc0203b9c <do_fork+0x2b8>
ffffffffc0203942:	00016c17          	auipc	s8,0x16
ffffffffc0203946:	c06c0c13          	addi	s8,s8,-1018 # ffffffffc0219548 <pages>
ffffffffc020394a:	000c3683          	ld	a3,0(s8)
ffffffffc020394e:	00007a97          	auipc	s5,0x7
ffffffffc0203952:	ce2aba83          	ld	s5,-798(s5) # ffffffffc020a630 <nbase>
ffffffffc0203956:	00016c97          	auipc	s9,0x16
ffffffffc020395a:	b7ac8c93          	addi	s9,s9,-1158 # ffffffffc02194d0 <npage>
ffffffffc020395e:	40d506b3          	sub	a3,a0,a3
ffffffffc0203962:	8699                	srai	a3,a3,0x6
ffffffffc0203964:	96d6                	add	a3,a3,s5
ffffffffc0203966:	000cb703          	ld	a4,0(s9)
ffffffffc020396a:	00c69793          	slli	a5,a3,0xc
ffffffffc020396e:	83b1                	srli	a5,a5,0xc
ffffffffc0203970:	06b2                	slli	a3,a3,0xc
ffffffffc0203972:	2ce7f163          	bgeu	a5,a4,ffffffffc0203c34 <do_fork+0x350>
ffffffffc0203976:	000bb703          	ld	a4,0(s7)
ffffffffc020397a:	00016d17          	auipc	s10,0x16
ffffffffc020397e:	bbed0d13          	addi	s10,s10,-1090 # ffffffffc0219538 <va_pa_offset>
ffffffffc0203982:	000d3783          	ld	a5,0(s10)
ffffffffc0203986:	02873b03          	ld	s6,40(a4)
ffffffffc020398a:	96be                	add	a3,a3,a5
ffffffffc020398c:	e814                	sd	a3,16(s0)
ffffffffc020398e:	020b0863          	beqz	s6,ffffffffc02039be <do_fork+0xda>
ffffffffc0203992:	100a7a13          	andi	s4,s4,256
ffffffffc0203996:	1c0a0163          	beqz	s4,ffffffffc0203b58 <do_fork+0x274>
ffffffffc020399a:	030b2703          	lw	a4,48(s6)
ffffffffc020399e:	018b3783          	ld	a5,24(s6)
ffffffffc02039a2:	c02006b7          	lui	a3,0xc0200
ffffffffc02039a6:	2705                	addiw	a4,a4,1
ffffffffc02039a8:	02eb2823          	sw	a4,48(s6)
ffffffffc02039ac:	03643423          	sd	s6,40(s0)
ffffffffc02039b0:	2ad7ee63          	bltu	a5,a3,ffffffffc0203c6c <do_fork+0x388>
ffffffffc02039b4:	000d3703          	ld	a4,0(s10)
ffffffffc02039b8:	6814                	ld	a3,16(s0)
ffffffffc02039ba:	8f99                	sub	a5,a5,a4
ffffffffc02039bc:	f45c                	sd	a5,168(s0)
ffffffffc02039be:	6789                	lui	a5,0x2
ffffffffc02039c0:	ee078793          	addi	a5,a5,-288 # 1ee0 <kern_entry-0xffffffffc01fe120>
ffffffffc02039c4:	97b6                	add	a5,a5,a3
ffffffffc02039c6:	8626                	mv	a2,s1
ffffffffc02039c8:	f05c                	sd	a5,160(s0)
ffffffffc02039ca:	873e                	mv	a4,a5
ffffffffc02039cc:	12048313          	addi	t1,s1,288
ffffffffc02039d0:	00063883          	ld	a7,0(a2)
ffffffffc02039d4:	00863803          	ld	a6,8(a2)
ffffffffc02039d8:	6a08                	ld	a0,16(a2)
ffffffffc02039da:	6e0c                	ld	a1,24(a2)
ffffffffc02039dc:	01173023          	sd	a7,0(a4)
ffffffffc02039e0:	01073423          	sd	a6,8(a4)
ffffffffc02039e4:	eb08                	sd	a0,16(a4)
ffffffffc02039e6:	ef0c                	sd	a1,24(a4)
ffffffffc02039e8:	02060613          	addi	a2,a2,32
ffffffffc02039ec:	02070713          	addi	a4,a4,32
ffffffffc02039f0:	fe6610e3          	bne	a2,t1,ffffffffc02039d0 <do_fork+0xec>
ffffffffc02039f4:	0407b823          	sd	zero,80(a5)
ffffffffc02039f8:	12090a63          	beqz	s2,ffffffffc0203b2c <do_fork+0x248>
ffffffffc02039fc:	0127b823          	sd	s2,16(a5)
ffffffffc0203a00:	00000717          	auipc	a4,0x0
ffffffffc0203a04:	d6670713          	addi	a4,a4,-666 # ffffffffc0203766 <forkret>
ffffffffc0203a08:	f818                	sd	a4,48(s0)
ffffffffc0203a0a:	fc1c                	sd	a5,56(s0)
ffffffffc0203a0c:	100027f3          	csrr	a5,sstatus
ffffffffc0203a10:	8b89                	andi	a5,a5,2
ffffffffc0203a12:	4901                	li	s2,0
ffffffffc0203a14:	12079e63          	bnez	a5,ffffffffc0203b50 <do_fork+0x26c>
ffffffffc0203a18:	0000a597          	auipc	a1,0xa
ffffffffc0203a1c:	67058593          	addi	a1,a1,1648 # ffffffffc020e088 <last_pid.1812>
ffffffffc0203a20:	419c                	lw	a5,0(a1)
ffffffffc0203a22:	6709                	lui	a4,0x2
ffffffffc0203a24:	0017851b          	addiw	a0,a5,1
ffffffffc0203a28:	c188                	sw	a0,0(a1)
ffffffffc0203a2a:	08e55b63          	bge	a0,a4,ffffffffc0203ac0 <do_fork+0x1dc>
ffffffffc0203a2e:	0000a897          	auipc	a7,0xa
ffffffffc0203a32:	65e88893          	addi	a7,a7,1630 # ffffffffc020e08c <next_safe.1811>
ffffffffc0203a36:	0008a783          	lw	a5,0(a7)
ffffffffc0203a3a:	00016497          	auipc	s1,0x16
ffffffffc0203a3e:	cfe48493          	addi	s1,s1,-770 # ffffffffc0219738 <proc_list>
ffffffffc0203a42:	08f55663          	bge	a0,a5,ffffffffc0203ace <do_fork+0x1ea>
ffffffffc0203a46:	c048                	sw	a0,4(s0)
ffffffffc0203a48:	45a9                	li	a1,10
ffffffffc0203a4a:	2501                	sext.w	a0,a0
ffffffffc0203a4c:	4d2040ef          	jal	ra,ffffffffc0207f1e <hash32>
ffffffffc0203a50:	1502                	slli	a0,a0,0x20
ffffffffc0203a52:	00012797          	auipc	a5,0x12
ffffffffc0203a56:	a3e78793          	addi	a5,a5,-1474 # ffffffffc0215490 <hash_list>
ffffffffc0203a5a:	8171                	srli	a0,a0,0x1c
ffffffffc0203a5c:	953e                	add	a0,a0,a5
ffffffffc0203a5e:	650c                	ld	a1,8(a0)
ffffffffc0203a60:	7014                	ld	a3,32(s0)
ffffffffc0203a62:	0d840793          	addi	a5,s0,216
ffffffffc0203a66:	e19c                	sd	a5,0(a1)
ffffffffc0203a68:	6490                	ld	a2,8(s1)
ffffffffc0203a6a:	e51c                	sd	a5,8(a0)
ffffffffc0203a6c:	7af8                	ld	a4,240(a3)
ffffffffc0203a6e:	0c840793          	addi	a5,s0,200
ffffffffc0203a72:	f06c                	sd	a1,224(s0)
ffffffffc0203a74:	ec68                	sd	a0,216(s0)
ffffffffc0203a76:	e21c                	sd	a5,0(a2)
ffffffffc0203a78:	e49c                	sd	a5,8(s1)
ffffffffc0203a7a:	e870                	sd	a2,208(s0)
ffffffffc0203a7c:	e464                	sd	s1,200(s0)
ffffffffc0203a7e:	0e043c23          	sd	zero,248(s0)
ffffffffc0203a82:	10e43023          	sd	a4,256(s0)
ffffffffc0203a86:	c311                	beqz	a4,ffffffffc0203a8a <do_fork+0x1a6>
ffffffffc0203a88:	ff60                	sd	s0,248(a4)
ffffffffc0203a8a:	0009a783          	lw	a5,0(s3)
ffffffffc0203a8e:	fae0                	sd	s0,240(a3)
ffffffffc0203a90:	2785                	addiw	a5,a5,1
ffffffffc0203a92:	00f9a023          	sw	a5,0(s3)
ffffffffc0203a96:	10091863          	bnez	s2,ffffffffc0203ba6 <do_fork+0x2c2>
ffffffffc0203a9a:	8522                	mv	a0,s0
ffffffffc0203a9c:	733000ef          	jal	ra,ffffffffc02049ce <wakeup_proc>
ffffffffc0203aa0:	4048                	lw	a0,4(s0)
ffffffffc0203aa2:	70a6                	ld	ra,104(sp)
ffffffffc0203aa4:	7406                	ld	s0,96(sp)
ffffffffc0203aa6:	64e6                	ld	s1,88(sp)
ffffffffc0203aa8:	6946                	ld	s2,80(sp)
ffffffffc0203aaa:	69a6                	ld	s3,72(sp)
ffffffffc0203aac:	6a06                	ld	s4,64(sp)
ffffffffc0203aae:	7ae2                	ld	s5,56(sp)
ffffffffc0203ab0:	7b42                	ld	s6,48(sp)
ffffffffc0203ab2:	7ba2                	ld	s7,40(sp)
ffffffffc0203ab4:	7c02                	ld	s8,32(sp)
ffffffffc0203ab6:	6ce2                	ld	s9,24(sp)
ffffffffc0203ab8:	6d42                	ld	s10,16(sp)
ffffffffc0203aba:	6da2                	ld	s11,8(sp)
ffffffffc0203abc:	6165                	addi	sp,sp,112
ffffffffc0203abe:	8082                	ret
ffffffffc0203ac0:	4785                	li	a5,1
ffffffffc0203ac2:	c19c                	sw	a5,0(a1)
ffffffffc0203ac4:	4505                	li	a0,1
ffffffffc0203ac6:	0000a897          	auipc	a7,0xa
ffffffffc0203aca:	5c688893          	addi	a7,a7,1478 # ffffffffc020e08c <next_safe.1811>
ffffffffc0203ace:	00016497          	auipc	s1,0x16
ffffffffc0203ad2:	c6a48493          	addi	s1,s1,-918 # ffffffffc0219738 <proc_list>
ffffffffc0203ad6:	0084b303          	ld	t1,8(s1)
ffffffffc0203ada:	6789                	lui	a5,0x2
ffffffffc0203adc:	00f8a023          	sw	a5,0(a7)
ffffffffc0203ae0:	4801                	li	a6,0
ffffffffc0203ae2:	87aa                	mv	a5,a0
ffffffffc0203ae4:	6e89                	lui	t4,0x2
ffffffffc0203ae6:	12930e63          	beq	t1,s1,ffffffffc0203c22 <do_fork+0x33e>
ffffffffc0203aea:	8e42                	mv	t3,a6
ffffffffc0203aec:	869a                	mv	a3,t1
ffffffffc0203aee:	6609                	lui	a2,0x2
ffffffffc0203af0:	a811                	j	ffffffffc0203b04 <do_fork+0x220>
ffffffffc0203af2:	00e7d663          	bge	a5,a4,ffffffffc0203afe <do_fork+0x21a>
ffffffffc0203af6:	00c75463          	bge	a4,a2,ffffffffc0203afe <do_fork+0x21a>
ffffffffc0203afa:	863a                	mv	a2,a4
ffffffffc0203afc:	4e05                	li	t3,1
ffffffffc0203afe:	6694                	ld	a3,8(a3)
ffffffffc0203b00:	00968d63          	beq	a3,s1,ffffffffc0203b1a <do_fork+0x236>
ffffffffc0203b04:	f3c6a703          	lw	a4,-196(a3) # ffffffffc01fff3c <kern_entry-0xc4>
ffffffffc0203b08:	fef715e3          	bne	a4,a5,ffffffffc0203af2 <do_fork+0x20e>
ffffffffc0203b0c:	2785                	addiw	a5,a5,1
ffffffffc0203b0e:	08c7df63          	bge	a5,a2,ffffffffc0203bac <do_fork+0x2c8>
ffffffffc0203b12:	6694                	ld	a3,8(a3)
ffffffffc0203b14:	4805                	li	a6,1
ffffffffc0203b16:	fe9697e3          	bne	a3,s1,ffffffffc0203b04 <do_fork+0x220>
ffffffffc0203b1a:	00080463          	beqz	a6,ffffffffc0203b22 <do_fork+0x23e>
ffffffffc0203b1e:	c19c                	sw	a5,0(a1)
ffffffffc0203b20:	853e                	mv	a0,a5
ffffffffc0203b22:	f20e02e3          	beqz	t3,ffffffffc0203a46 <do_fork+0x162>
ffffffffc0203b26:	00c8a023          	sw	a2,0(a7)
ffffffffc0203b2a:	bf31                	j	ffffffffc0203a46 <do_fork+0x162>
ffffffffc0203b2c:	6909                	lui	s2,0x2
ffffffffc0203b2e:	edc90913          	addi	s2,s2,-292 # 1edc <kern_entry-0xffffffffc01fe124>
ffffffffc0203b32:	9936                	add	s2,s2,a3
ffffffffc0203b34:	0127b823          	sd	s2,16(a5) # 2010 <kern_entry-0xffffffffc01fdff0>
ffffffffc0203b38:	00000717          	auipc	a4,0x0
ffffffffc0203b3c:	c2e70713          	addi	a4,a4,-978 # ffffffffc0203766 <forkret>
ffffffffc0203b40:	f818                	sd	a4,48(s0)
ffffffffc0203b42:	fc1c                	sd	a5,56(s0)
ffffffffc0203b44:	100027f3          	csrr	a5,sstatus
ffffffffc0203b48:	8b89                	andi	a5,a5,2
ffffffffc0203b4a:	4901                	li	s2,0
ffffffffc0203b4c:	ec0786e3          	beqz	a5,ffffffffc0203a18 <do_fork+0x134>
ffffffffc0203b50:	ae9fc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203b54:	4905                	li	s2,1
ffffffffc0203b56:	b5c9                	j	ffffffffc0203a18 <do_fork+0x134>
ffffffffc0203b58:	be1fd0ef          	jal	ra,ffffffffc0201738 <mm_create>
ffffffffc0203b5c:	8a2a                	mv	s4,a0
ffffffffc0203b5e:	c901                	beqz	a0,ffffffffc0203b6e <do_fork+0x28a>
ffffffffc0203b60:	0561                	addi	a0,a0,24
ffffffffc0203b62:	c13ff0ef          	jal	ra,ffffffffc0203774 <setup_pgdir.isra.0>
ffffffffc0203b66:	c921                	beqz	a0,ffffffffc0203bb6 <do_fork+0x2d2>
ffffffffc0203b68:	8552                	mv	a0,s4
ffffffffc0203b6a:	d2dfd0ef          	jal	ra,ffffffffc0201896 <mm_destroy>
ffffffffc0203b6e:	6814                	ld	a3,16(s0)
ffffffffc0203b70:	c02007b7          	lui	a5,0xc0200
ffffffffc0203b74:	12f6e563          	bltu	a3,a5,ffffffffc0203c9e <do_fork+0x3ba>
ffffffffc0203b78:	000d3783          	ld	a5,0(s10)
ffffffffc0203b7c:	000cb703          	ld	a4,0(s9)
ffffffffc0203b80:	40f687b3          	sub	a5,a3,a5
ffffffffc0203b84:	83b1                	srli	a5,a5,0xc
ffffffffc0203b86:	10e7f063          	bgeu	a5,a4,ffffffffc0203c86 <do_fork+0x3a2>
ffffffffc0203b8a:	000c3503          	ld	a0,0(s8)
ffffffffc0203b8e:	415787b3          	sub	a5,a5,s5
ffffffffc0203b92:	079a                	slli	a5,a5,0x6
ffffffffc0203b94:	4589                	li	a1,2
ffffffffc0203b96:	953e                	add	a0,a0,a5
ffffffffc0203b98:	a44fd0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0203b9c:	8522                	mv	a0,s0
ffffffffc0203b9e:	d82fe0ef          	jal	ra,ffffffffc0202120 <kfree>
ffffffffc0203ba2:	5571                	li	a0,-4
ffffffffc0203ba4:	bdfd                	j	ffffffffc0203aa2 <do_fork+0x1be>
ffffffffc0203ba6:	a8dfc0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203baa:	bdc5                	j	ffffffffc0203a9a <do_fork+0x1b6>
ffffffffc0203bac:	01d7c363          	blt	a5,t4,ffffffffc0203bb2 <do_fork+0x2ce>
ffffffffc0203bb0:	4785                	li	a5,1
ffffffffc0203bb2:	4805                	li	a6,1
ffffffffc0203bb4:	bf0d                	j	ffffffffc0203ae6 <do_fork+0x202>
ffffffffc0203bb6:	038b0d93          	addi	s11,s6,56
ffffffffc0203bba:	856e                	mv	a0,s11
ffffffffc0203bbc:	941ff0ef          	jal	ra,ffffffffc02034fc <down>
ffffffffc0203bc0:	000bb783          	ld	a5,0(s7)
ffffffffc0203bc4:	c781                	beqz	a5,ffffffffc0203bcc <do_fork+0x2e8>
ffffffffc0203bc6:	43dc                	lw	a5,4(a5)
ffffffffc0203bc8:	04fb2823          	sw	a5,80(s6)
ffffffffc0203bcc:	85da                	mv	a1,s6
ffffffffc0203bce:	8552                	mv	a0,s4
ffffffffc0203bd0:	dc9fd0ef          	jal	ra,ffffffffc0201998 <dup_mmap>
ffffffffc0203bd4:	8baa                	mv	s7,a0
ffffffffc0203bd6:	856e                	mv	a0,s11
ffffffffc0203bd8:	923ff0ef          	jal	ra,ffffffffc02034fa <up>
ffffffffc0203bdc:	040b2823          	sw	zero,80(s6)
ffffffffc0203be0:	8b52                	mv	s6,s4
ffffffffc0203be2:	da0b8ce3          	beqz	s7,ffffffffc020399a <do_fork+0xb6>
ffffffffc0203be6:	8552                	mv	a0,s4
ffffffffc0203be8:	e4bfd0ef          	jal	ra,ffffffffc0201a32 <exit_mmap>
ffffffffc0203bec:	018a3683          	ld	a3,24(s4)
ffffffffc0203bf0:	c02007b7          	lui	a5,0xc0200
ffffffffc0203bf4:	0af6e563          	bltu	a3,a5,ffffffffc0203c9e <do_fork+0x3ba>
ffffffffc0203bf8:	000d3703          	ld	a4,0(s10)
ffffffffc0203bfc:	000cb783          	ld	a5,0(s9)
ffffffffc0203c00:	8e99                	sub	a3,a3,a4
ffffffffc0203c02:	82b1                	srli	a3,a3,0xc
ffffffffc0203c04:	08f6f163          	bgeu	a3,a5,ffffffffc0203c86 <do_fork+0x3a2>
ffffffffc0203c08:	000c3503          	ld	a0,0(s8)
ffffffffc0203c0c:	415686b3          	sub	a3,a3,s5
ffffffffc0203c10:	069a                	slli	a3,a3,0x6
ffffffffc0203c12:	9536                	add	a0,a0,a3
ffffffffc0203c14:	4585                	li	a1,1
ffffffffc0203c16:	9c6fd0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0203c1a:	8552                	mv	a0,s4
ffffffffc0203c1c:	c7bfd0ef          	jal	ra,ffffffffc0201896 <mm_destroy>
ffffffffc0203c20:	b7b9                	j	ffffffffc0203b6e <do_fork+0x28a>
ffffffffc0203c22:	00080763          	beqz	a6,ffffffffc0203c30 <do_fork+0x34c>
ffffffffc0203c26:	c19c                	sw	a5,0(a1)
ffffffffc0203c28:	853e                	mv	a0,a5
ffffffffc0203c2a:	bd31                	j	ffffffffc0203a46 <do_fork+0x162>
ffffffffc0203c2c:	556d                	li	a0,-5
ffffffffc0203c2e:	bd95                	j	ffffffffc0203aa2 <do_fork+0x1be>
ffffffffc0203c30:	4188                	lw	a0,0(a1)
ffffffffc0203c32:	bd11                	j	ffffffffc0203a46 <do_fork+0x162>
ffffffffc0203c34:	00005617          	auipc	a2,0x5
ffffffffc0203c38:	d6460613          	addi	a2,a2,-668 # ffffffffc0208998 <commands+0x7c0>
ffffffffc0203c3c:	06900593          	li	a1,105
ffffffffc0203c40:	00005517          	auipc	a0,0x5
ffffffffc0203c44:	cb850513          	addi	a0,a0,-840 # ffffffffc02088f8 <commands+0x720>
ffffffffc0203c48:	dc0fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203c4c:	00006697          	auipc	a3,0x6
ffffffffc0203c50:	92468693          	addi	a3,a3,-1756 # ffffffffc0209570 <default_pmm_manager+0x248>
ffffffffc0203c54:	00005617          	auipc	a2,0x5
ffffffffc0203c58:	99460613          	addi	a2,a2,-1644 # ffffffffc02085e8 <commands+0x410>
ffffffffc0203c5c:	1a600593          	li	a1,422
ffffffffc0203c60:	00006517          	auipc	a0,0x6
ffffffffc0203c64:	93050513          	addi	a0,a0,-1744 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0203c68:	da0fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203c6c:	86be                	mv	a3,a5
ffffffffc0203c6e:	00005617          	auipc	a2,0x5
ffffffffc0203c72:	cf260613          	addi	a2,a2,-782 # ffffffffc0208960 <commands+0x788>
ffffffffc0203c76:	15900593          	li	a1,345
ffffffffc0203c7a:	00006517          	auipc	a0,0x6
ffffffffc0203c7e:	91650513          	addi	a0,a0,-1770 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0203c82:	d86fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203c86:	00005617          	auipc	a2,0x5
ffffffffc0203c8a:	c5260613          	addi	a2,a2,-942 # ffffffffc02088d8 <commands+0x700>
ffffffffc0203c8e:	06200593          	li	a1,98
ffffffffc0203c92:	00005517          	auipc	a0,0x5
ffffffffc0203c96:	c6650513          	addi	a0,a0,-922 # ffffffffc02088f8 <commands+0x720>
ffffffffc0203c9a:	d6efc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203c9e:	00005617          	auipc	a2,0x5
ffffffffc0203ca2:	cc260613          	addi	a2,a2,-830 # ffffffffc0208960 <commands+0x788>
ffffffffc0203ca6:	06e00593          	li	a1,110
ffffffffc0203caa:	00005517          	auipc	a0,0x5
ffffffffc0203cae:	c4e50513          	addi	a0,a0,-946 # ffffffffc02088f8 <commands+0x720>
ffffffffc0203cb2:	d56fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203cb6 <kernel_thread>:
ffffffffc0203cb6:	7129                	addi	sp,sp,-320
ffffffffc0203cb8:	fa22                	sd	s0,304(sp)
ffffffffc0203cba:	f626                	sd	s1,296(sp)
ffffffffc0203cbc:	f24a                	sd	s2,288(sp)
ffffffffc0203cbe:	84ae                	mv	s1,a1
ffffffffc0203cc0:	892a                	mv	s2,a0
ffffffffc0203cc2:	8432                	mv	s0,a2
ffffffffc0203cc4:	4581                	li	a1,0
ffffffffc0203cc6:	12000613          	li	a2,288
ffffffffc0203cca:	850a                	mv	a0,sp
ffffffffc0203ccc:	fe06                	sd	ra,312(sp)
ffffffffc0203cce:	639030ef          	jal	ra,ffffffffc0207b06 <memset>
ffffffffc0203cd2:	e0ca                	sd	s2,64(sp)
ffffffffc0203cd4:	e4a6                	sd	s1,72(sp)
ffffffffc0203cd6:	100027f3          	csrr	a5,sstatus
ffffffffc0203cda:	edd7f793          	andi	a5,a5,-291
ffffffffc0203cde:	1207e793          	ori	a5,a5,288
ffffffffc0203ce2:	e23e                	sd	a5,256(sp)
ffffffffc0203ce4:	860a                	mv	a2,sp
ffffffffc0203ce6:	10046513          	ori	a0,s0,256
ffffffffc0203cea:	00000797          	auipc	a5,0x0
ffffffffc0203cee:	99878793          	addi	a5,a5,-1640 # ffffffffc0203682 <kernel_thread_entry>
ffffffffc0203cf2:	4581                	li	a1,0
ffffffffc0203cf4:	e63e                	sd	a5,264(sp)
ffffffffc0203cf6:	befff0ef          	jal	ra,ffffffffc02038e4 <do_fork>
ffffffffc0203cfa:	70f2                	ld	ra,312(sp)
ffffffffc0203cfc:	7452                	ld	s0,304(sp)
ffffffffc0203cfe:	74b2                	ld	s1,296(sp)
ffffffffc0203d00:	7912                	ld	s2,288(sp)
ffffffffc0203d02:	6131                	addi	sp,sp,320
ffffffffc0203d04:	8082                	ret

ffffffffc0203d06 <do_exit>:
ffffffffc0203d06:	7179                	addi	sp,sp,-48
ffffffffc0203d08:	f022                	sd	s0,32(sp)
ffffffffc0203d0a:	00015417          	auipc	s0,0x15
ffffffffc0203d0e:	7ee40413          	addi	s0,s0,2030 # ffffffffc02194f8 <current>
ffffffffc0203d12:	601c                	ld	a5,0(s0)
ffffffffc0203d14:	f406                	sd	ra,40(sp)
ffffffffc0203d16:	ec26                	sd	s1,24(sp)
ffffffffc0203d18:	e84a                	sd	s2,16(sp)
ffffffffc0203d1a:	e44e                	sd	s3,8(sp)
ffffffffc0203d1c:	e052                	sd	s4,0(sp)
ffffffffc0203d1e:	00015717          	auipc	a4,0x15
ffffffffc0203d22:	7e273703          	ld	a4,2018(a4) # ffffffffc0219500 <idleproc>
ffffffffc0203d26:	0ce78d63          	beq	a5,a4,ffffffffc0203e00 <do_exit+0xfa>
ffffffffc0203d2a:	00015497          	auipc	s1,0x15
ffffffffc0203d2e:	7de48493          	addi	s1,s1,2014 # ffffffffc0219508 <initproc>
ffffffffc0203d32:	6098                	ld	a4,0(s1)
ffffffffc0203d34:	12e78963          	beq	a5,a4,ffffffffc0203e66 <do_exit+0x160>
ffffffffc0203d38:	0287b903          	ld	s2,40(a5)
ffffffffc0203d3c:	89aa                	mv	s3,a0
ffffffffc0203d3e:	02090663          	beqz	s2,ffffffffc0203d6a <do_exit+0x64>
ffffffffc0203d42:	00015797          	auipc	a5,0x15
ffffffffc0203d46:	7fe7b783          	ld	a5,2046(a5) # ffffffffc0219540 <boot_cr3>
ffffffffc0203d4a:	577d                	li	a4,-1
ffffffffc0203d4c:	177e                	slli	a4,a4,0x3f
ffffffffc0203d4e:	83b1                	srli	a5,a5,0xc
ffffffffc0203d50:	8fd9                	or	a5,a5,a4
ffffffffc0203d52:	18079073          	csrw	satp,a5
ffffffffc0203d56:	03092783          	lw	a5,48(s2)
ffffffffc0203d5a:	fff7871b          	addiw	a4,a5,-1
ffffffffc0203d5e:	02e92823          	sw	a4,48(s2)
ffffffffc0203d62:	cb5d                	beqz	a4,ffffffffc0203e18 <do_exit+0x112>
ffffffffc0203d64:	601c                	ld	a5,0(s0)
ffffffffc0203d66:	0207b423          	sd	zero,40(a5)
ffffffffc0203d6a:	601c                	ld	a5,0(s0)
ffffffffc0203d6c:	470d                	li	a4,3
ffffffffc0203d6e:	c398                	sw	a4,0(a5)
ffffffffc0203d70:	0f37a423          	sw	s3,232(a5)
ffffffffc0203d74:	100027f3          	csrr	a5,sstatus
ffffffffc0203d78:	8b89                	andi	a5,a5,2
ffffffffc0203d7a:	4a01                	li	s4,0
ffffffffc0203d7c:	10079163          	bnez	a5,ffffffffc0203e7e <do_exit+0x178>
ffffffffc0203d80:	6018                	ld	a4,0(s0)
ffffffffc0203d82:	800007b7          	lui	a5,0x80000
ffffffffc0203d86:	0785                	addi	a5,a5,1
ffffffffc0203d88:	7308                	ld	a0,32(a4)
ffffffffc0203d8a:	0ec52703          	lw	a4,236(a0)
ffffffffc0203d8e:	0ef70c63          	beq	a4,a5,ffffffffc0203e86 <do_exit+0x180>
ffffffffc0203d92:	6018                	ld	a4,0(s0)
ffffffffc0203d94:	7b7c                	ld	a5,240(a4)
ffffffffc0203d96:	c3a1                	beqz	a5,ffffffffc0203dd6 <do_exit+0xd0>
ffffffffc0203d98:	800009b7          	lui	s3,0x80000
ffffffffc0203d9c:	490d                	li	s2,3
ffffffffc0203d9e:	0985                	addi	s3,s3,1
ffffffffc0203da0:	a021                	j	ffffffffc0203da8 <do_exit+0xa2>
ffffffffc0203da2:	6018                	ld	a4,0(s0)
ffffffffc0203da4:	7b7c                	ld	a5,240(a4)
ffffffffc0203da6:	cb85                	beqz	a5,ffffffffc0203dd6 <do_exit+0xd0>
ffffffffc0203da8:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <kern_entry-0x401fff00>
ffffffffc0203dac:	6088                	ld	a0,0(s1)
ffffffffc0203dae:	fb74                	sd	a3,240(a4)
ffffffffc0203db0:	7978                	ld	a4,240(a0)
ffffffffc0203db2:	0e07bc23          	sd	zero,248(a5)
ffffffffc0203db6:	10e7b023          	sd	a4,256(a5)
ffffffffc0203dba:	c311                	beqz	a4,ffffffffc0203dbe <do_exit+0xb8>
ffffffffc0203dbc:	ff7c                	sd	a5,248(a4)
ffffffffc0203dbe:	4398                	lw	a4,0(a5)
ffffffffc0203dc0:	f388                	sd	a0,32(a5)
ffffffffc0203dc2:	f97c                	sd	a5,240(a0)
ffffffffc0203dc4:	fd271fe3          	bne	a4,s2,ffffffffc0203da2 <do_exit+0x9c>
ffffffffc0203dc8:	0ec52783          	lw	a5,236(a0)
ffffffffc0203dcc:	fd379be3          	bne	a5,s3,ffffffffc0203da2 <do_exit+0x9c>
ffffffffc0203dd0:	3ff000ef          	jal	ra,ffffffffc02049ce <wakeup_proc>
ffffffffc0203dd4:	b7f9                	j	ffffffffc0203da2 <do_exit+0x9c>
ffffffffc0203dd6:	020a1263          	bnez	s4,ffffffffc0203dfa <do_exit+0xf4>
ffffffffc0203dda:	4a7000ef          	jal	ra,ffffffffc0204a80 <schedule>
ffffffffc0203dde:	601c                	ld	a5,0(s0)
ffffffffc0203de0:	00005617          	auipc	a2,0x5
ffffffffc0203de4:	7e860613          	addi	a2,a2,2024 # ffffffffc02095c8 <default_pmm_manager+0x2a0>
ffffffffc0203de8:	1f900593          	li	a1,505
ffffffffc0203dec:	43d4                	lw	a3,4(a5)
ffffffffc0203dee:	00005517          	auipc	a0,0x5
ffffffffc0203df2:	7a250513          	addi	a0,a0,1954 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0203df6:	c12fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203dfa:	839fc0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203dfe:	bff1                	j	ffffffffc0203dda <do_exit+0xd4>
ffffffffc0203e00:	00005617          	auipc	a2,0x5
ffffffffc0203e04:	7a860613          	addi	a2,a2,1960 # ffffffffc02095a8 <default_pmm_manager+0x280>
ffffffffc0203e08:	1cd00593          	li	a1,461
ffffffffc0203e0c:	00005517          	auipc	a0,0x5
ffffffffc0203e10:	78450513          	addi	a0,a0,1924 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0203e14:	bf4fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203e18:	854a                	mv	a0,s2
ffffffffc0203e1a:	c19fd0ef          	jal	ra,ffffffffc0201a32 <exit_mmap>
ffffffffc0203e1e:	01893683          	ld	a3,24(s2)
ffffffffc0203e22:	c02007b7          	lui	a5,0xc0200
ffffffffc0203e26:	06f6e363          	bltu	a3,a5,ffffffffc0203e8c <do_exit+0x186>
ffffffffc0203e2a:	00015797          	auipc	a5,0x15
ffffffffc0203e2e:	70e7b783          	ld	a5,1806(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc0203e32:	8e9d                	sub	a3,a3,a5
ffffffffc0203e34:	82b1                	srli	a3,a3,0xc
ffffffffc0203e36:	00015797          	auipc	a5,0x15
ffffffffc0203e3a:	69a7b783          	ld	a5,1690(a5) # ffffffffc02194d0 <npage>
ffffffffc0203e3e:	06f6f363          	bgeu	a3,a5,ffffffffc0203ea4 <do_exit+0x19e>
ffffffffc0203e42:	00006517          	auipc	a0,0x6
ffffffffc0203e46:	7ee53503          	ld	a0,2030(a0) # ffffffffc020a630 <nbase>
ffffffffc0203e4a:	8e89                	sub	a3,a3,a0
ffffffffc0203e4c:	069a                	slli	a3,a3,0x6
ffffffffc0203e4e:	00015517          	auipc	a0,0x15
ffffffffc0203e52:	6fa53503          	ld	a0,1786(a0) # ffffffffc0219548 <pages>
ffffffffc0203e56:	9536                	add	a0,a0,a3
ffffffffc0203e58:	4585                	li	a1,1
ffffffffc0203e5a:	f83fc0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0203e5e:	854a                	mv	a0,s2
ffffffffc0203e60:	a37fd0ef          	jal	ra,ffffffffc0201896 <mm_destroy>
ffffffffc0203e64:	b701                	j	ffffffffc0203d64 <do_exit+0x5e>
ffffffffc0203e66:	00005617          	auipc	a2,0x5
ffffffffc0203e6a:	75260613          	addi	a2,a2,1874 # ffffffffc02095b8 <default_pmm_manager+0x290>
ffffffffc0203e6e:	1d000593          	li	a1,464
ffffffffc0203e72:	00005517          	auipc	a0,0x5
ffffffffc0203e76:	71e50513          	addi	a0,a0,1822 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0203e7a:	b8efc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203e7e:	fbafc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203e82:	4a05                	li	s4,1
ffffffffc0203e84:	bdf5                	j	ffffffffc0203d80 <do_exit+0x7a>
ffffffffc0203e86:	349000ef          	jal	ra,ffffffffc02049ce <wakeup_proc>
ffffffffc0203e8a:	b721                	j	ffffffffc0203d92 <do_exit+0x8c>
ffffffffc0203e8c:	00005617          	auipc	a2,0x5
ffffffffc0203e90:	ad460613          	addi	a2,a2,-1324 # ffffffffc0208960 <commands+0x788>
ffffffffc0203e94:	06e00593          	li	a1,110
ffffffffc0203e98:	00005517          	auipc	a0,0x5
ffffffffc0203e9c:	a6050513          	addi	a0,a0,-1440 # ffffffffc02088f8 <commands+0x720>
ffffffffc0203ea0:	b68fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203ea4:	00005617          	auipc	a2,0x5
ffffffffc0203ea8:	a3460613          	addi	a2,a2,-1484 # ffffffffc02088d8 <commands+0x700>
ffffffffc0203eac:	06200593          	li	a1,98
ffffffffc0203eb0:	00005517          	auipc	a0,0x5
ffffffffc0203eb4:	a4850513          	addi	a0,a0,-1464 # ffffffffc02088f8 <commands+0x720>
ffffffffc0203eb8:	b50fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203ebc <do_wait.part.0>:
ffffffffc0203ebc:	7139                	addi	sp,sp,-64
ffffffffc0203ebe:	e852                	sd	s4,16(sp)
ffffffffc0203ec0:	80000a37          	lui	s4,0x80000
ffffffffc0203ec4:	f426                	sd	s1,40(sp)
ffffffffc0203ec6:	f04a                	sd	s2,32(sp)
ffffffffc0203ec8:	ec4e                	sd	s3,24(sp)
ffffffffc0203eca:	e456                	sd	s5,8(sp)
ffffffffc0203ecc:	e05a                	sd	s6,0(sp)
ffffffffc0203ece:	fc06                	sd	ra,56(sp)
ffffffffc0203ed0:	f822                	sd	s0,48(sp)
ffffffffc0203ed2:	892a                	mv	s2,a0
ffffffffc0203ed4:	8aae                	mv	s5,a1
ffffffffc0203ed6:	00015997          	auipc	s3,0x15
ffffffffc0203eda:	62298993          	addi	s3,s3,1570 # ffffffffc02194f8 <current>
ffffffffc0203ede:	448d                	li	s1,3
ffffffffc0203ee0:	4b05                	li	s6,1
ffffffffc0203ee2:	2a05                	addiw	s4,s4,1
ffffffffc0203ee4:	02090f63          	beqz	s2,ffffffffc0203f22 <do_wait.part.0+0x66>
ffffffffc0203ee8:	854a                	mv	a0,s2
ffffffffc0203eea:	9a3ff0ef          	jal	ra,ffffffffc020388c <find_proc>
ffffffffc0203eee:	842a                	mv	s0,a0
ffffffffc0203ef0:	10050763          	beqz	a0,ffffffffc0203ffe <do_wait.part.0+0x142>
ffffffffc0203ef4:	0009b703          	ld	a4,0(s3)
ffffffffc0203ef8:	711c                	ld	a5,32(a0)
ffffffffc0203efa:	10e79263          	bne	a5,a4,ffffffffc0203ffe <do_wait.part.0+0x142>
ffffffffc0203efe:	411c                	lw	a5,0(a0)
ffffffffc0203f00:	02978c63          	beq	a5,s1,ffffffffc0203f38 <do_wait.part.0+0x7c>
ffffffffc0203f04:	01672023          	sw	s6,0(a4)
ffffffffc0203f08:	0f472623          	sw	s4,236(a4)
ffffffffc0203f0c:	375000ef          	jal	ra,ffffffffc0204a80 <schedule>
ffffffffc0203f10:	0009b783          	ld	a5,0(s3)
ffffffffc0203f14:	0b07a783          	lw	a5,176(a5)
ffffffffc0203f18:	8b85                	andi	a5,a5,1
ffffffffc0203f1a:	d7e9                	beqz	a5,ffffffffc0203ee4 <do_wait.part.0+0x28>
ffffffffc0203f1c:	555d                	li	a0,-9
ffffffffc0203f1e:	de9ff0ef          	jal	ra,ffffffffc0203d06 <do_exit>
ffffffffc0203f22:	0009b703          	ld	a4,0(s3)
ffffffffc0203f26:	7b60                	ld	s0,240(a4)
ffffffffc0203f28:	e409                	bnez	s0,ffffffffc0203f32 <do_wait.part.0+0x76>
ffffffffc0203f2a:	a8d1                	j	ffffffffc0203ffe <do_wait.part.0+0x142>
ffffffffc0203f2c:	10043403          	ld	s0,256(s0)
ffffffffc0203f30:	d871                	beqz	s0,ffffffffc0203f04 <do_wait.part.0+0x48>
ffffffffc0203f32:	401c                	lw	a5,0(s0)
ffffffffc0203f34:	fe979ce3          	bne	a5,s1,ffffffffc0203f2c <do_wait.part.0+0x70>
ffffffffc0203f38:	00015797          	auipc	a5,0x15
ffffffffc0203f3c:	5c87b783          	ld	a5,1480(a5) # ffffffffc0219500 <idleproc>
ffffffffc0203f40:	0c878563          	beq	a5,s0,ffffffffc020400a <do_wait.part.0+0x14e>
ffffffffc0203f44:	00015797          	auipc	a5,0x15
ffffffffc0203f48:	5c47b783          	ld	a5,1476(a5) # ffffffffc0219508 <initproc>
ffffffffc0203f4c:	0af40f63          	beq	s0,a5,ffffffffc020400a <do_wait.part.0+0x14e>
ffffffffc0203f50:	000a8663          	beqz	s5,ffffffffc0203f5c <do_wait.part.0+0xa0>
ffffffffc0203f54:	0e842783          	lw	a5,232(s0)
ffffffffc0203f58:	00faa023          	sw	a5,0(s5)
ffffffffc0203f5c:	100027f3          	csrr	a5,sstatus
ffffffffc0203f60:	8b89                	andi	a5,a5,2
ffffffffc0203f62:	4581                	li	a1,0
ffffffffc0203f64:	efd9                	bnez	a5,ffffffffc0204002 <do_wait.part.0+0x146>
ffffffffc0203f66:	6c70                	ld	a2,216(s0)
ffffffffc0203f68:	7074                	ld	a3,224(s0)
ffffffffc0203f6a:	10043703          	ld	a4,256(s0)
ffffffffc0203f6e:	7c7c                	ld	a5,248(s0)
ffffffffc0203f70:	e614                	sd	a3,8(a2)
ffffffffc0203f72:	e290                	sd	a2,0(a3)
ffffffffc0203f74:	6470                	ld	a2,200(s0)
ffffffffc0203f76:	6874                	ld	a3,208(s0)
ffffffffc0203f78:	e614                	sd	a3,8(a2)
ffffffffc0203f7a:	e290                	sd	a2,0(a3)
ffffffffc0203f7c:	c319                	beqz	a4,ffffffffc0203f82 <do_wait.part.0+0xc6>
ffffffffc0203f7e:	ff7c                	sd	a5,248(a4)
ffffffffc0203f80:	7c7c                	ld	a5,248(s0)
ffffffffc0203f82:	cbbd                	beqz	a5,ffffffffc0203ff8 <do_wait.part.0+0x13c>
ffffffffc0203f84:	10e7b023          	sd	a4,256(a5)
ffffffffc0203f88:	00015717          	auipc	a4,0x15
ffffffffc0203f8c:	58870713          	addi	a4,a4,1416 # ffffffffc0219510 <nr_process>
ffffffffc0203f90:	431c                	lw	a5,0(a4)
ffffffffc0203f92:	37fd                	addiw	a5,a5,-1
ffffffffc0203f94:	c31c                	sw	a5,0(a4)
ffffffffc0203f96:	edb1                	bnez	a1,ffffffffc0203ff2 <do_wait.part.0+0x136>
ffffffffc0203f98:	6814                	ld	a3,16(s0)
ffffffffc0203f9a:	c02007b7          	lui	a5,0xc0200
ffffffffc0203f9e:	08f6ee63          	bltu	a3,a5,ffffffffc020403a <do_wait.part.0+0x17e>
ffffffffc0203fa2:	00015797          	auipc	a5,0x15
ffffffffc0203fa6:	5967b783          	ld	a5,1430(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc0203faa:	8e9d                	sub	a3,a3,a5
ffffffffc0203fac:	82b1                	srli	a3,a3,0xc
ffffffffc0203fae:	00015797          	auipc	a5,0x15
ffffffffc0203fb2:	5227b783          	ld	a5,1314(a5) # ffffffffc02194d0 <npage>
ffffffffc0203fb6:	06f6f663          	bgeu	a3,a5,ffffffffc0204022 <do_wait.part.0+0x166>
ffffffffc0203fba:	00006517          	auipc	a0,0x6
ffffffffc0203fbe:	67653503          	ld	a0,1654(a0) # ffffffffc020a630 <nbase>
ffffffffc0203fc2:	8e89                	sub	a3,a3,a0
ffffffffc0203fc4:	069a                	slli	a3,a3,0x6
ffffffffc0203fc6:	00015517          	auipc	a0,0x15
ffffffffc0203fca:	58253503          	ld	a0,1410(a0) # ffffffffc0219548 <pages>
ffffffffc0203fce:	9536                	add	a0,a0,a3
ffffffffc0203fd0:	4589                	li	a1,2
ffffffffc0203fd2:	e0bfc0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0203fd6:	8522                	mv	a0,s0
ffffffffc0203fd8:	948fe0ef          	jal	ra,ffffffffc0202120 <kfree>
ffffffffc0203fdc:	4501                	li	a0,0
ffffffffc0203fde:	70e2                	ld	ra,56(sp)
ffffffffc0203fe0:	7442                	ld	s0,48(sp)
ffffffffc0203fe2:	74a2                	ld	s1,40(sp)
ffffffffc0203fe4:	7902                	ld	s2,32(sp)
ffffffffc0203fe6:	69e2                	ld	s3,24(sp)
ffffffffc0203fe8:	6a42                	ld	s4,16(sp)
ffffffffc0203fea:	6aa2                	ld	s5,8(sp)
ffffffffc0203fec:	6b02                	ld	s6,0(sp)
ffffffffc0203fee:	6121                	addi	sp,sp,64
ffffffffc0203ff0:	8082                	ret
ffffffffc0203ff2:	e40fc0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203ff6:	b74d                	j	ffffffffc0203f98 <do_wait.part.0+0xdc>
ffffffffc0203ff8:	701c                	ld	a5,32(s0)
ffffffffc0203ffa:	fbf8                	sd	a4,240(a5)
ffffffffc0203ffc:	b771                	j	ffffffffc0203f88 <do_wait.part.0+0xcc>
ffffffffc0203ffe:	5579                	li	a0,-2
ffffffffc0204000:	bff9                	j	ffffffffc0203fde <do_wait.part.0+0x122>
ffffffffc0204002:	e36fc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204006:	4585                	li	a1,1
ffffffffc0204008:	bfb9                	j	ffffffffc0203f66 <do_wait.part.0+0xaa>
ffffffffc020400a:	00005617          	auipc	a2,0x5
ffffffffc020400e:	5de60613          	addi	a2,a2,1502 # ffffffffc02095e8 <default_pmm_manager+0x2c0>
ffffffffc0204012:	2f600593          	li	a1,758
ffffffffc0204016:	00005517          	auipc	a0,0x5
ffffffffc020401a:	57a50513          	addi	a0,a0,1402 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc020401e:	9eafc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204022:	00005617          	auipc	a2,0x5
ffffffffc0204026:	8b660613          	addi	a2,a2,-1866 # ffffffffc02088d8 <commands+0x700>
ffffffffc020402a:	06200593          	li	a1,98
ffffffffc020402e:	00005517          	auipc	a0,0x5
ffffffffc0204032:	8ca50513          	addi	a0,a0,-1846 # ffffffffc02088f8 <commands+0x720>
ffffffffc0204036:	9d2fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020403a:	00005617          	auipc	a2,0x5
ffffffffc020403e:	92660613          	addi	a2,a2,-1754 # ffffffffc0208960 <commands+0x788>
ffffffffc0204042:	06e00593          	li	a1,110
ffffffffc0204046:	00005517          	auipc	a0,0x5
ffffffffc020404a:	8b250513          	addi	a0,a0,-1870 # ffffffffc02088f8 <commands+0x720>
ffffffffc020404e:	9bafc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204052 <init_main>:
ffffffffc0204052:	1141                	addi	sp,sp,-16
ffffffffc0204054:	e406                	sd	ra,8(sp)
ffffffffc0204056:	dc9fc0ef          	jal	ra,ffffffffc0200e1e <nr_free_pages>
ffffffffc020405a:	812fe0ef          	jal	ra,ffffffffc020206c <kallocated>
ffffffffc020405e:	9ccff0ef          	jal	ra,ffffffffc020322a <check_sync>
ffffffffc0204062:	a019                	j	ffffffffc0204068 <init_main+0x16>
ffffffffc0204064:	21d000ef          	jal	ra,ffffffffc0204a80 <schedule>
ffffffffc0204068:	4581                	li	a1,0
ffffffffc020406a:	4501                	li	a0,0
ffffffffc020406c:	e51ff0ef          	jal	ra,ffffffffc0203ebc <do_wait.part.0>
ffffffffc0204070:	d975                	beqz	a0,ffffffffc0204064 <init_main+0x12>
ffffffffc0204072:	00005517          	auipc	a0,0x5
ffffffffc0204076:	59650513          	addi	a0,a0,1430 # ffffffffc0209608 <default_pmm_manager+0x2e0>
ffffffffc020407a:	852fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020407e:	00015797          	auipc	a5,0x15
ffffffffc0204082:	48a7b783          	ld	a5,1162(a5) # ffffffffc0219508 <initproc>
ffffffffc0204086:	7bf8                	ld	a4,240(a5)
ffffffffc0204088:	e339                	bnez	a4,ffffffffc02040ce <init_main+0x7c>
ffffffffc020408a:	7ff8                	ld	a4,248(a5)
ffffffffc020408c:	e329                	bnez	a4,ffffffffc02040ce <init_main+0x7c>
ffffffffc020408e:	1007b703          	ld	a4,256(a5)
ffffffffc0204092:	ef15                	bnez	a4,ffffffffc02040ce <init_main+0x7c>
ffffffffc0204094:	00015697          	auipc	a3,0x15
ffffffffc0204098:	47c6a683          	lw	a3,1148(a3) # ffffffffc0219510 <nr_process>
ffffffffc020409c:	4709                	li	a4,2
ffffffffc020409e:	08e69863          	bne	a3,a4,ffffffffc020412e <init_main+0xdc>
ffffffffc02040a2:	00015717          	auipc	a4,0x15
ffffffffc02040a6:	69670713          	addi	a4,a4,1686 # ffffffffc0219738 <proc_list>
ffffffffc02040aa:	6714                	ld	a3,8(a4)
ffffffffc02040ac:	0c878793          	addi	a5,a5,200
ffffffffc02040b0:	04d79f63          	bne	a5,a3,ffffffffc020410e <init_main+0xbc>
ffffffffc02040b4:	6318                	ld	a4,0(a4)
ffffffffc02040b6:	02e79c63          	bne	a5,a4,ffffffffc02040ee <init_main+0x9c>
ffffffffc02040ba:	00005517          	auipc	a0,0x5
ffffffffc02040be:	63650513          	addi	a0,a0,1590 # ffffffffc02096f0 <default_pmm_manager+0x3c8>
ffffffffc02040c2:	80afc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02040c6:	60a2                	ld	ra,8(sp)
ffffffffc02040c8:	4501                	li	a0,0
ffffffffc02040ca:	0141                	addi	sp,sp,16
ffffffffc02040cc:	8082                	ret
ffffffffc02040ce:	00005697          	auipc	a3,0x5
ffffffffc02040d2:	56268693          	addi	a3,a3,1378 # ffffffffc0209630 <default_pmm_manager+0x308>
ffffffffc02040d6:	00004617          	auipc	a2,0x4
ffffffffc02040da:	51260613          	addi	a2,a2,1298 # ffffffffc02085e8 <commands+0x410>
ffffffffc02040de:	35f00593          	li	a1,863
ffffffffc02040e2:	00005517          	auipc	a0,0x5
ffffffffc02040e6:	4ae50513          	addi	a0,a0,1198 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc02040ea:	91efc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02040ee:	00005697          	auipc	a3,0x5
ffffffffc02040f2:	5d268693          	addi	a3,a3,1490 # ffffffffc02096c0 <default_pmm_manager+0x398>
ffffffffc02040f6:	00004617          	auipc	a2,0x4
ffffffffc02040fa:	4f260613          	addi	a2,a2,1266 # ffffffffc02085e8 <commands+0x410>
ffffffffc02040fe:	36200593          	li	a1,866
ffffffffc0204102:	00005517          	auipc	a0,0x5
ffffffffc0204106:	48e50513          	addi	a0,a0,1166 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc020410a:	8fefc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020410e:	00005697          	auipc	a3,0x5
ffffffffc0204112:	58268693          	addi	a3,a3,1410 # ffffffffc0209690 <default_pmm_manager+0x368>
ffffffffc0204116:	00004617          	auipc	a2,0x4
ffffffffc020411a:	4d260613          	addi	a2,a2,1234 # ffffffffc02085e8 <commands+0x410>
ffffffffc020411e:	36100593          	li	a1,865
ffffffffc0204122:	00005517          	auipc	a0,0x5
ffffffffc0204126:	46e50513          	addi	a0,a0,1134 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc020412a:	8defc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020412e:	00005697          	auipc	a3,0x5
ffffffffc0204132:	55268693          	addi	a3,a3,1362 # ffffffffc0209680 <default_pmm_manager+0x358>
ffffffffc0204136:	00004617          	auipc	a2,0x4
ffffffffc020413a:	4b260613          	addi	a2,a2,1202 # ffffffffc02085e8 <commands+0x410>
ffffffffc020413e:	36000593          	li	a1,864
ffffffffc0204142:	00005517          	auipc	a0,0x5
ffffffffc0204146:	44e50513          	addi	a0,a0,1102 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc020414a:	8befc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020414e <do_execve>:
ffffffffc020414e:	7135                	addi	sp,sp,-160
ffffffffc0204150:	f4d6                	sd	s5,104(sp)
ffffffffc0204152:	00015a97          	auipc	s5,0x15
ffffffffc0204156:	3a6a8a93          	addi	s5,s5,934 # ffffffffc02194f8 <current>
ffffffffc020415a:	000ab783          	ld	a5,0(s5)
ffffffffc020415e:	f8d2                	sd	s4,112(sp)
ffffffffc0204160:	e526                	sd	s1,136(sp)
ffffffffc0204162:	0287ba03          	ld	s4,40(a5)
ffffffffc0204166:	e14a                	sd	s2,128(sp)
ffffffffc0204168:	fcce                	sd	s3,120(sp)
ffffffffc020416a:	892a                	mv	s2,a0
ffffffffc020416c:	84ae                	mv	s1,a1
ffffffffc020416e:	89b2                	mv	s3,a2
ffffffffc0204170:	4681                	li	a3,0
ffffffffc0204172:	862e                	mv	a2,a1
ffffffffc0204174:	85aa                	mv	a1,a0
ffffffffc0204176:	8552                	mv	a0,s4
ffffffffc0204178:	ed06                	sd	ra,152(sp)
ffffffffc020417a:	e922                	sd	s0,144(sp)
ffffffffc020417c:	f0da                	sd	s6,96(sp)
ffffffffc020417e:	ecde                	sd	s7,88(sp)
ffffffffc0204180:	e8e2                	sd	s8,80(sp)
ffffffffc0204182:	e4e6                	sd	s9,72(sp)
ffffffffc0204184:	e0ea                	sd	s10,64(sp)
ffffffffc0204186:	fc6e                	sd	s11,56(sp)
ffffffffc0204188:	a25fd0ef          	jal	ra,ffffffffc0201bac <user_mem_check>
ffffffffc020418c:	46050063          	beqz	a0,ffffffffc02045ec <do_execve+0x49e>
ffffffffc0204190:	4641                	li	a2,16
ffffffffc0204192:	4581                	li	a1,0
ffffffffc0204194:	1008                	addi	a0,sp,32
ffffffffc0204196:	171030ef          	jal	ra,ffffffffc0207b06 <memset>
ffffffffc020419a:	47bd                	li	a5,15
ffffffffc020419c:	8626                	mv	a2,s1
ffffffffc020419e:	1897ea63          	bltu	a5,s1,ffffffffc0204332 <do_execve+0x1e4>
ffffffffc02041a2:	85ca                	mv	a1,s2
ffffffffc02041a4:	1008                	addi	a0,sp,32
ffffffffc02041a6:	173030ef          	jal	ra,ffffffffc0207b18 <memcpy>
ffffffffc02041aa:	180a0b63          	beqz	s4,ffffffffc0204340 <do_execve+0x1f2>
ffffffffc02041ae:	00005517          	auipc	a0,0x5
ffffffffc02041b2:	97250513          	addi	a0,a0,-1678 # ffffffffc0208b20 <commands+0x948>
ffffffffc02041b6:	f4ffb0ef          	jal	ra,ffffffffc0200104 <cputs>
ffffffffc02041ba:	00015797          	auipc	a5,0x15
ffffffffc02041be:	3867b783          	ld	a5,902(a5) # ffffffffc0219540 <boot_cr3>
ffffffffc02041c2:	577d                	li	a4,-1
ffffffffc02041c4:	177e                	slli	a4,a4,0x3f
ffffffffc02041c6:	83b1                	srli	a5,a5,0xc
ffffffffc02041c8:	8fd9                	or	a5,a5,a4
ffffffffc02041ca:	18079073          	csrw	satp,a5
ffffffffc02041ce:	030a2783          	lw	a5,48(s4) # ffffffff80000030 <kern_entry-0x401fffd0>
ffffffffc02041d2:	fff7871b          	addiw	a4,a5,-1
ffffffffc02041d6:	02ea2823          	sw	a4,48(s4)
ffffffffc02041da:	2c070163          	beqz	a4,ffffffffc020449c <do_execve+0x34e>
ffffffffc02041de:	000ab783          	ld	a5,0(s5)
ffffffffc02041e2:	0207b423          	sd	zero,40(a5)
ffffffffc02041e6:	d52fd0ef          	jal	ra,ffffffffc0201738 <mm_create>
ffffffffc02041ea:	84aa                	mv	s1,a0
ffffffffc02041ec:	18050263          	beqz	a0,ffffffffc0204370 <do_execve+0x222>
ffffffffc02041f0:	0561                	addi	a0,a0,24
ffffffffc02041f2:	d82ff0ef          	jal	ra,ffffffffc0203774 <setup_pgdir.isra.0>
ffffffffc02041f6:	16051663          	bnez	a0,ffffffffc0204362 <do_execve+0x214>
ffffffffc02041fa:	0009a703          	lw	a4,0(s3)
ffffffffc02041fe:	464c47b7          	lui	a5,0x464c4
ffffffffc0204202:	57f78793          	addi	a5,a5,1407 # 464c457f <kern_entry-0xffffffff79d3ba81>
ffffffffc0204206:	24f71763          	bne	a4,a5,ffffffffc0204454 <do_execve+0x306>
ffffffffc020420a:	0389d703          	lhu	a4,56(s3)
ffffffffc020420e:	0209b903          	ld	s2,32(s3)
ffffffffc0204212:	00371793          	slli	a5,a4,0x3
ffffffffc0204216:	8f99                	sub	a5,a5,a4
ffffffffc0204218:	994e                	add	s2,s2,s3
ffffffffc020421a:	078e                	slli	a5,a5,0x3
ffffffffc020421c:	97ca                	add	a5,a5,s2
ffffffffc020421e:	ec3e                	sd	a5,24(sp)
ffffffffc0204220:	02f97c63          	bgeu	s2,a5,ffffffffc0204258 <do_execve+0x10a>
ffffffffc0204224:	5bfd                	li	s7,-1
ffffffffc0204226:	00cbd793          	srli	a5,s7,0xc
ffffffffc020422a:	00015d97          	auipc	s11,0x15
ffffffffc020422e:	31ed8d93          	addi	s11,s11,798 # ffffffffc0219548 <pages>
ffffffffc0204232:	00006d17          	auipc	s10,0x6
ffffffffc0204236:	3fed0d13          	addi	s10,s10,1022 # ffffffffc020a630 <nbase>
ffffffffc020423a:	e43e                	sd	a5,8(sp)
ffffffffc020423c:	00015c97          	auipc	s9,0x15
ffffffffc0204240:	294c8c93          	addi	s9,s9,660 # ffffffffc02194d0 <npage>
ffffffffc0204244:	00092703          	lw	a4,0(s2)
ffffffffc0204248:	4785                	li	a5,1
ffffffffc020424a:	12f70563          	beq	a4,a5,ffffffffc0204374 <do_execve+0x226>
ffffffffc020424e:	67e2                	ld	a5,24(sp)
ffffffffc0204250:	03890913          	addi	s2,s2,56
ffffffffc0204254:	fef968e3          	bltu	s2,a5,ffffffffc0204244 <do_execve+0xf6>
ffffffffc0204258:	4701                	li	a4,0
ffffffffc020425a:	46ad                	li	a3,11
ffffffffc020425c:	00100637          	lui	a2,0x100
ffffffffc0204260:	7ff005b7          	lui	a1,0x7ff00
ffffffffc0204264:	8526                	mv	a0,s1
ffffffffc0204266:	e82fd0ef          	jal	ra,ffffffffc02018e8 <mm_map>
ffffffffc020426a:	8a2a                	mv	s4,a0
ffffffffc020426c:	1e051063          	bnez	a0,ffffffffc020444c <do_execve+0x2fe>
ffffffffc0204270:	6c88                	ld	a0,24(s1)
ffffffffc0204272:	467d                	li	a2,31
ffffffffc0204274:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc0204278:	c0efd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc020427c:	42050e63          	beqz	a0,ffffffffc02046b8 <do_execve+0x56a>
ffffffffc0204280:	6c88                	ld	a0,24(s1)
ffffffffc0204282:	467d                	li	a2,31
ffffffffc0204284:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc0204288:	bfefd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc020428c:	40050663          	beqz	a0,ffffffffc0204698 <do_execve+0x54a>
ffffffffc0204290:	6c88                	ld	a0,24(s1)
ffffffffc0204292:	467d                	li	a2,31
ffffffffc0204294:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc0204298:	beefd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc020429c:	3c050e63          	beqz	a0,ffffffffc0204678 <do_execve+0x52a>
ffffffffc02042a0:	6c88                	ld	a0,24(s1)
ffffffffc02042a2:	467d                	li	a2,31
ffffffffc02042a4:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc02042a8:	bdefd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc02042ac:	3a050663          	beqz	a0,ffffffffc0204658 <do_execve+0x50a>
ffffffffc02042b0:	589c                	lw	a5,48(s1)
ffffffffc02042b2:	000ab603          	ld	a2,0(s5)
ffffffffc02042b6:	6c94                	ld	a3,24(s1)
ffffffffc02042b8:	2785                	addiw	a5,a5,1
ffffffffc02042ba:	d89c                	sw	a5,48(s1)
ffffffffc02042bc:	f604                	sd	s1,40(a2)
ffffffffc02042be:	c02007b7          	lui	a5,0xc0200
ffffffffc02042c2:	36f6ef63          	bltu	a3,a5,ffffffffc0204640 <do_execve+0x4f2>
ffffffffc02042c6:	00015797          	auipc	a5,0x15
ffffffffc02042ca:	2727b783          	ld	a5,626(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc02042ce:	8e9d                	sub	a3,a3,a5
ffffffffc02042d0:	577d                	li	a4,-1
ffffffffc02042d2:	00c6d793          	srli	a5,a3,0xc
ffffffffc02042d6:	177e                	slli	a4,a4,0x3f
ffffffffc02042d8:	f654                	sd	a3,168(a2)
ffffffffc02042da:	8fd9                	or	a5,a5,a4
ffffffffc02042dc:	18079073          	csrw	satp,a5
ffffffffc02042e0:	7240                	ld	s0,160(a2)
ffffffffc02042e2:	4581                	li	a1,0
ffffffffc02042e4:	12000613          	li	a2,288
ffffffffc02042e8:	8522                	mv	a0,s0
ffffffffc02042ea:	10043483          	ld	s1,256(s0)
ffffffffc02042ee:	019030ef          	jal	ra,ffffffffc0207b06 <memset>
ffffffffc02042f2:	0189b703          	ld	a4,24(s3)
ffffffffc02042f6:	4785                	li	a5,1
ffffffffc02042f8:	000ab503          	ld	a0,0(s5)
ffffffffc02042fc:	edf4f493          	andi	s1,s1,-289
ffffffffc0204300:	07fe                	slli	a5,a5,0x1f
ffffffffc0204302:	e81c                	sd	a5,16(s0)
ffffffffc0204304:	10e43423          	sd	a4,264(s0)
ffffffffc0204308:	10943023          	sd	s1,256(s0)
ffffffffc020430c:	100c                	addi	a1,sp,32
ffffffffc020430e:	ce8ff0ef          	jal	ra,ffffffffc02037f6 <set_proc_name>
ffffffffc0204312:	60ea                	ld	ra,152(sp)
ffffffffc0204314:	644a                	ld	s0,144(sp)
ffffffffc0204316:	64aa                	ld	s1,136(sp)
ffffffffc0204318:	690a                	ld	s2,128(sp)
ffffffffc020431a:	79e6                	ld	s3,120(sp)
ffffffffc020431c:	7aa6                	ld	s5,104(sp)
ffffffffc020431e:	7b06                	ld	s6,96(sp)
ffffffffc0204320:	6be6                	ld	s7,88(sp)
ffffffffc0204322:	6c46                	ld	s8,80(sp)
ffffffffc0204324:	6ca6                	ld	s9,72(sp)
ffffffffc0204326:	6d06                	ld	s10,64(sp)
ffffffffc0204328:	7de2                	ld	s11,56(sp)
ffffffffc020432a:	8552                	mv	a0,s4
ffffffffc020432c:	7a46                	ld	s4,112(sp)
ffffffffc020432e:	610d                	addi	sp,sp,160
ffffffffc0204330:	8082                	ret
ffffffffc0204332:	463d                	li	a2,15
ffffffffc0204334:	85ca                	mv	a1,s2
ffffffffc0204336:	1008                	addi	a0,sp,32
ffffffffc0204338:	7e0030ef          	jal	ra,ffffffffc0207b18 <memcpy>
ffffffffc020433c:	e60a19e3          	bnez	s4,ffffffffc02041ae <do_execve+0x60>
ffffffffc0204340:	000ab783          	ld	a5,0(s5)
ffffffffc0204344:	779c                	ld	a5,40(a5)
ffffffffc0204346:	ea0780e3          	beqz	a5,ffffffffc02041e6 <do_execve+0x98>
ffffffffc020434a:	00005617          	auipc	a2,0x5
ffffffffc020434e:	3c660613          	addi	a2,a2,966 # ffffffffc0209710 <default_pmm_manager+0x3e8>
ffffffffc0204352:	20300593          	li	a1,515
ffffffffc0204356:	00005517          	auipc	a0,0x5
ffffffffc020435a:	23a50513          	addi	a0,a0,570 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc020435e:	eabfb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204362:	8526                	mv	a0,s1
ffffffffc0204364:	d32fd0ef          	jal	ra,ffffffffc0201896 <mm_destroy>
ffffffffc0204368:	5a71                	li	s4,-4
ffffffffc020436a:	8552                	mv	a0,s4
ffffffffc020436c:	99bff0ef          	jal	ra,ffffffffc0203d06 <do_exit>
ffffffffc0204370:	5a71                	li	s4,-4
ffffffffc0204372:	bfe5                	j	ffffffffc020436a <do_execve+0x21c>
ffffffffc0204374:	02893603          	ld	a2,40(s2)
ffffffffc0204378:	02093783          	ld	a5,32(s2)
ffffffffc020437c:	26f66c63          	bltu	a2,a5,ffffffffc02045f4 <do_execve+0x4a6>
ffffffffc0204380:	00492783          	lw	a5,4(s2)
ffffffffc0204384:	0017f693          	andi	a3,a5,1
ffffffffc0204388:	c291                	beqz	a3,ffffffffc020438c <do_execve+0x23e>
ffffffffc020438a:	4691                	li	a3,4
ffffffffc020438c:	0027f713          	andi	a4,a5,2
ffffffffc0204390:	8b91                	andi	a5,a5,4
ffffffffc0204392:	14071c63          	bnez	a4,ffffffffc02044ea <do_execve+0x39c>
ffffffffc0204396:	4745                	li	a4,17
ffffffffc0204398:	e03a                	sd	a4,0(sp)
ffffffffc020439a:	c789                	beqz	a5,ffffffffc02043a4 <do_execve+0x256>
ffffffffc020439c:	47cd                	li	a5,19
ffffffffc020439e:	0016e693          	ori	a3,a3,1
ffffffffc02043a2:	e03e                	sd	a5,0(sp)
ffffffffc02043a4:	0026f793          	andi	a5,a3,2
ffffffffc02043a8:	14079563          	bnez	a5,ffffffffc02044f2 <do_execve+0x3a4>
ffffffffc02043ac:	0046f793          	andi	a5,a3,4
ffffffffc02043b0:	c789                	beqz	a5,ffffffffc02043ba <do_execve+0x26c>
ffffffffc02043b2:	6782                	ld	a5,0(sp)
ffffffffc02043b4:	0087e793          	ori	a5,a5,8
ffffffffc02043b8:	e03e                	sd	a5,0(sp)
ffffffffc02043ba:	01093583          	ld	a1,16(s2)
ffffffffc02043be:	4701                	li	a4,0
ffffffffc02043c0:	8526                	mv	a0,s1
ffffffffc02043c2:	d26fd0ef          	jal	ra,ffffffffc02018e8 <mm_map>
ffffffffc02043c6:	8a2a                	mv	s4,a0
ffffffffc02043c8:	e151                	bnez	a0,ffffffffc020444c <do_execve+0x2fe>
ffffffffc02043ca:	01093c03          	ld	s8,16(s2)
ffffffffc02043ce:	02093a03          	ld	s4,32(s2)
ffffffffc02043d2:	00893b03          	ld	s6,8(s2)
ffffffffc02043d6:	77fd                	lui	a5,0xfffff
ffffffffc02043d8:	9a62                	add	s4,s4,s8
ffffffffc02043da:	9b4e                	add	s6,s6,s3
ffffffffc02043dc:	00fc7bb3          	and	s7,s8,a5
ffffffffc02043e0:	054c6e63          	bltu	s8,s4,ffffffffc020443c <do_execve+0x2ee>
ffffffffc02043e4:	a431                	j	ffffffffc02045f0 <do_execve+0x4a2>
ffffffffc02043e6:	6785                	lui	a5,0x1
ffffffffc02043e8:	417c0533          	sub	a0,s8,s7
ffffffffc02043ec:	9bbe                	add	s7,s7,a5
ffffffffc02043ee:	418b8633          	sub	a2,s7,s8
ffffffffc02043f2:	017a7463          	bgeu	s4,s7,ffffffffc02043fa <do_execve+0x2ac>
ffffffffc02043f6:	418a0633          	sub	a2,s4,s8
ffffffffc02043fa:	000db683          	ld	a3,0(s11)
ffffffffc02043fe:	000d3803          	ld	a6,0(s10)
ffffffffc0204402:	67a2                	ld	a5,8(sp)
ffffffffc0204404:	40d406b3          	sub	a3,s0,a3
ffffffffc0204408:	8699                	srai	a3,a3,0x6
ffffffffc020440a:	000cb583          	ld	a1,0(s9)
ffffffffc020440e:	96c2                	add	a3,a3,a6
ffffffffc0204410:	00f6f833          	and	a6,a3,a5
ffffffffc0204414:	06b2                	slli	a3,a3,0xc
ffffffffc0204416:	1eb87163          	bgeu	a6,a1,ffffffffc02045f8 <do_execve+0x4aa>
ffffffffc020441a:	00015797          	auipc	a5,0x15
ffffffffc020441e:	11e78793          	addi	a5,a5,286 # ffffffffc0219538 <va_pa_offset>
ffffffffc0204422:	0007b803          	ld	a6,0(a5)
ffffffffc0204426:	85da                	mv	a1,s6
ffffffffc0204428:	9c32                	add	s8,s8,a2
ffffffffc020442a:	96c2                	add	a3,a3,a6
ffffffffc020442c:	9536                	add	a0,a0,a3
ffffffffc020442e:	e832                	sd	a2,16(sp)
ffffffffc0204430:	6e8030ef          	jal	ra,ffffffffc0207b18 <memcpy>
ffffffffc0204434:	6642                	ld	a2,16(sp)
ffffffffc0204436:	9b32                	add	s6,s6,a2
ffffffffc0204438:	0d4c7063          	bgeu	s8,s4,ffffffffc02044f8 <do_execve+0x3aa>
ffffffffc020443c:	6c88                	ld	a0,24(s1)
ffffffffc020443e:	6602                	ld	a2,0(sp)
ffffffffc0204440:	85de                	mv	a1,s7
ffffffffc0204442:	a44fd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc0204446:	842a                	mv	s0,a0
ffffffffc0204448:	fd59                	bnez	a0,ffffffffc02043e6 <do_execve+0x298>
ffffffffc020444a:	5a71                	li	s4,-4
ffffffffc020444c:	8526                	mv	a0,s1
ffffffffc020444e:	de4fd0ef          	jal	ra,ffffffffc0201a32 <exit_mmap>
ffffffffc0204452:	a011                	j	ffffffffc0204456 <do_execve+0x308>
ffffffffc0204454:	5a61                	li	s4,-8
ffffffffc0204456:	6c94                	ld	a3,24(s1)
ffffffffc0204458:	c02007b7          	lui	a5,0xc0200
ffffffffc020445c:	1af6ea63          	bltu	a3,a5,ffffffffc0204610 <do_execve+0x4c2>
ffffffffc0204460:	00015517          	auipc	a0,0x15
ffffffffc0204464:	0d853503          	ld	a0,216(a0) # ffffffffc0219538 <va_pa_offset>
ffffffffc0204468:	8e89                	sub	a3,a3,a0
ffffffffc020446a:	82b1                	srli	a3,a3,0xc
ffffffffc020446c:	00015797          	auipc	a5,0x15
ffffffffc0204470:	0647b783          	ld	a5,100(a5) # ffffffffc02194d0 <npage>
ffffffffc0204474:	1af6fa63          	bgeu	a3,a5,ffffffffc0204628 <do_execve+0x4da>
ffffffffc0204478:	00006517          	auipc	a0,0x6
ffffffffc020447c:	1b853503          	ld	a0,440(a0) # ffffffffc020a630 <nbase>
ffffffffc0204480:	8e89                	sub	a3,a3,a0
ffffffffc0204482:	069a                	slli	a3,a3,0x6
ffffffffc0204484:	00015517          	auipc	a0,0x15
ffffffffc0204488:	0c453503          	ld	a0,196(a0) # ffffffffc0219548 <pages>
ffffffffc020448c:	9536                	add	a0,a0,a3
ffffffffc020448e:	4585                	li	a1,1
ffffffffc0204490:	94dfc0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0204494:	8526                	mv	a0,s1
ffffffffc0204496:	c00fd0ef          	jal	ra,ffffffffc0201896 <mm_destroy>
ffffffffc020449a:	bdc1                	j	ffffffffc020436a <do_execve+0x21c>
ffffffffc020449c:	8552                	mv	a0,s4
ffffffffc020449e:	d94fd0ef          	jal	ra,ffffffffc0201a32 <exit_mmap>
ffffffffc02044a2:	018a3683          	ld	a3,24(s4)
ffffffffc02044a6:	c02007b7          	lui	a5,0xc0200
ffffffffc02044aa:	16f6e363          	bltu	a3,a5,ffffffffc0204610 <do_execve+0x4c2>
ffffffffc02044ae:	00015797          	auipc	a5,0x15
ffffffffc02044b2:	08a7b783          	ld	a5,138(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc02044b6:	8e9d                	sub	a3,a3,a5
ffffffffc02044b8:	82b1                	srli	a3,a3,0xc
ffffffffc02044ba:	00015797          	auipc	a5,0x15
ffffffffc02044be:	0167b783          	ld	a5,22(a5) # ffffffffc02194d0 <npage>
ffffffffc02044c2:	16f6f363          	bgeu	a3,a5,ffffffffc0204628 <do_execve+0x4da>
ffffffffc02044c6:	00006517          	auipc	a0,0x6
ffffffffc02044ca:	16a53503          	ld	a0,362(a0) # ffffffffc020a630 <nbase>
ffffffffc02044ce:	8e89                	sub	a3,a3,a0
ffffffffc02044d0:	069a                	slli	a3,a3,0x6
ffffffffc02044d2:	00015517          	auipc	a0,0x15
ffffffffc02044d6:	07653503          	ld	a0,118(a0) # ffffffffc0219548 <pages>
ffffffffc02044da:	9536                	add	a0,a0,a3
ffffffffc02044dc:	4585                	li	a1,1
ffffffffc02044de:	8fffc0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc02044e2:	8552                	mv	a0,s4
ffffffffc02044e4:	bb2fd0ef          	jal	ra,ffffffffc0201896 <mm_destroy>
ffffffffc02044e8:	b9dd                	j	ffffffffc02041de <do_execve+0x90>
ffffffffc02044ea:	0026e693          	ori	a3,a3,2
ffffffffc02044ee:	ea0797e3          	bnez	a5,ffffffffc020439c <do_execve+0x24e>
ffffffffc02044f2:	47dd                	li	a5,23
ffffffffc02044f4:	e03e                	sd	a5,0(sp)
ffffffffc02044f6:	bd5d                	j	ffffffffc02043ac <do_execve+0x25e>
ffffffffc02044f8:	01093a03          	ld	s4,16(s2)
ffffffffc02044fc:	02893683          	ld	a3,40(s2)
ffffffffc0204500:	9a36                	add	s4,s4,a3
ffffffffc0204502:	077c7f63          	bgeu	s8,s7,ffffffffc0204580 <do_execve+0x432>
ffffffffc0204506:	d58a04e3          	beq	s4,s8,ffffffffc020424e <do_execve+0x100>
ffffffffc020450a:	6505                	lui	a0,0x1
ffffffffc020450c:	9562                	add	a0,a0,s8
ffffffffc020450e:	41750533          	sub	a0,a0,s7
ffffffffc0204512:	418a0b33          	sub	s6,s4,s8
ffffffffc0204516:	0d7a7863          	bgeu	s4,s7,ffffffffc02045e6 <do_execve+0x498>
ffffffffc020451a:	000db683          	ld	a3,0(s11)
ffffffffc020451e:	000d3583          	ld	a1,0(s10)
ffffffffc0204522:	67a2                	ld	a5,8(sp)
ffffffffc0204524:	40d406b3          	sub	a3,s0,a3
ffffffffc0204528:	8699                	srai	a3,a3,0x6
ffffffffc020452a:	000cb603          	ld	a2,0(s9)
ffffffffc020452e:	96ae                	add	a3,a3,a1
ffffffffc0204530:	00f6f5b3          	and	a1,a3,a5
ffffffffc0204534:	06b2                	slli	a3,a3,0xc
ffffffffc0204536:	0cc5f163          	bgeu	a1,a2,ffffffffc02045f8 <do_execve+0x4aa>
ffffffffc020453a:	00015617          	auipc	a2,0x15
ffffffffc020453e:	ffe63603          	ld	a2,-2(a2) # ffffffffc0219538 <va_pa_offset>
ffffffffc0204542:	96b2                	add	a3,a3,a2
ffffffffc0204544:	4581                	li	a1,0
ffffffffc0204546:	865a                	mv	a2,s6
ffffffffc0204548:	9536                	add	a0,a0,a3
ffffffffc020454a:	5bc030ef          	jal	ra,ffffffffc0207b06 <memset>
ffffffffc020454e:	018b0733          	add	a4,s6,s8
ffffffffc0204552:	037a7463          	bgeu	s4,s7,ffffffffc020457a <do_execve+0x42c>
ffffffffc0204556:	ceea0ce3          	beq	s4,a4,ffffffffc020424e <do_execve+0x100>
ffffffffc020455a:	00005697          	auipc	a3,0x5
ffffffffc020455e:	1de68693          	addi	a3,a3,478 # ffffffffc0209738 <default_pmm_manager+0x410>
ffffffffc0204562:	00004617          	auipc	a2,0x4
ffffffffc0204566:	08660613          	addi	a2,a2,134 # ffffffffc02085e8 <commands+0x410>
ffffffffc020456a:	25800593          	li	a1,600
ffffffffc020456e:	00005517          	auipc	a0,0x5
ffffffffc0204572:	02250513          	addi	a0,a0,34 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0204576:	c93fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020457a:	ff7710e3          	bne	a4,s7,ffffffffc020455a <do_execve+0x40c>
ffffffffc020457e:	8c5e                	mv	s8,s7
ffffffffc0204580:	00015b17          	auipc	s6,0x15
ffffffffc0204584:	fb8b0b13          	addi	s6,s6,-72 # ffffffffc0219538 <va_pa_offset>
ffffffffc0204588:	054c6763          	bltu	s8,s4,ffffffffc02045d6 <do_execve+0x488>
ffffffffc020458c:	b1c9                	j	ffffffffc020424e <do_execve+0x100>
ffffffffc020458e:	6785                	lui	a5,0x1
ffffffffc0204590:	417c0533          	sub	a0,s8,s7
ffffffffc0204594:	9bbe                	add	s7,s7,a5
ffffffffc0204596:	418b8633          	sub	a2,s7,s8
ffffffffc020459a:	017a7463          	bgeu	s4,s7,ffffffffc02045a2 <do_execve+0x454>
ffffffffc020459e:	418a0633          	sub	a2,s4,s8
ffffffffc02045a2:	000db683          	ld	a3,0(s11)
ffffffffc02045a6:	000d3803          	ld	a6,0(s10)
ffffffffc02045aa:	67a2                	ld	a5,8(sp)
ffffffffc02045ac:	40d406b3          	sub	a3,s0,a3
ffffffffc02045b0:	8699                	srai	a3,a3,0x6
ffffffffc02045b2:	000cb583          	ld	a1,0(s9)
ffffffffc02045b6:	96c2                	add	a3,a3,a6
ffffffffc02045b8:	00f6f833          	and	a6,a3,a5
ffffffffc02045bc:	06b2                	slli	a3,a3,0xc
ffffffffc02045be:	02b87d63          	bgeu	a6,a1,ffffffffc02045f8 <do_execve+0x4aa>
ffffffffc02045c2:	000b3803          	ld	a6,0(s6)
ffffffffc02045c6:	9c32                	add	s8,s8,a2
ffffffffc02045c8:	4581                	li	a1,0
ffffffffc02045ca:	96c2                	add	a3,a3,a6
ffffffffc02045cc:	9536                	add	a0,a0,a3
ffffffffc02045ce:	538030ef          	jal	ra,ffffffffc0207b06 <memset>
ffffffffc02045d2:	c74c7ee3          	bgeu	s8,s4,ffffffffc020424e <do_execve+0x100>
ffffffffc02045d6:	6c88                	ld	a0,24(s1)
ffffffffc02045d8:	6602                	ld	a2,0(sp)
ffffffffc02045da:	85de                	mv	a1,s7
ffffffffc02045dc:	8aafd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc02045e0:	842a                	mv	s0,a0
ffffffffc02045e2:	f555                	bnez	a0,ffffffffc020458e <do_execve+0x440>
ffffffffc02045e4:	b59d                	j	ffffffffc020444a <do_execve+0x2fc>
ffffffffc02045e6:	418b8b33          	sub	s6,s7,s8
ffffffffc02045ea:	bf05                	j	ffffffffc020451a <do_execve+0x3cc>
ffffffffc02045ec:	5a75                	li	s4,-3
ffffffffc02045ee:	b315                	j	ffffffffc0204312 <do_execve+0x1c4>
ffffffffc02045f0:	8a62                	mv	s4,s8
ffffffffc02045f2:	b729                	j	ffffffffc02044fc <do_execve+0x3ae>
ffffffffc02045f4:	5a61                	li	s4,-8
ffffffffc02045f6:	bd99                	j	ffffffffc020444c <do_execve+0x2fe>
ffffffffc02045f8:	00004617          	auipc	a2,0x4
ffffffffc02045fc:	3a060613          	addi	a2,a2,928 # ffffffffc0208998 <commands+0x7c0>
ffffffffc0204600:	06900593          	li	a1,105
ffffffffc0204604:	00004517          	auipc	a0,0x4
ffffffffc0204608:	2f450513          	addi	a0,a0,756 # ffffffffc02088f8 <commands+0x720>
ffffffffc020460c:	bfdfb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204610:	00004617          	auipc	a2,0x4
ffffffffc0204614:	35060613          	addi	a2,a2,848 # ffffffffc0208960 <commands+0x788>
ffffffffc0204618:	06e00593          	li	a1,110
ffffffffc020461c:	00004517          	auipc	a0,0x4
ffffffffc0204620:	2dc50513          	addi	a0,a0,732 # ffffffffc02088f8 <commands+0x720>
ffffffffc0204624:	be5fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204628:	00004617          	auipc	a2,0x4
ffffffffc020462c:	2b060613          	addi	a2,a2,688 # ffffffffc02088d8 <commands+0x700>
ffffffffc0204630:	06200593          	li	a1,98
ffffffffc0204634:	00004517          	auipc	a0,0x4
ffffffffc0204638:	2c450513          	addi	a0,a0,708 # ffffffffc02088f8 <commands+0x720>
ffffffffc020463c:	bcdfb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204640:	00004617          	auipc	a2,0x4
ffffffffc0204644:	32060613          	addi	a2,a2,800 # ffffffffc0208960 <commands+0x788>
ffffffffc0204648:	27300593          	li	a1,627
ffffffffc020464c:	00005517          	auipc	a0,0x5
ffffffffc0204650:	f4450513          	addi	a0,a0,-188 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0204654:	bb5fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204658:	00005697          	auipc	a3,0x5
ffffffffc020465c:	1f868693          	addi	a3,a3,504 # ffffffffc0209850 <default_pmm_manager+0x528>
ffffffffc0204660:	00004617          	auipc	a2,0x4
ffffffffc0204664:	f8860613          	addi	a2,a2,-120 # ffffffffc02085e8 <commands+0x410>
ffffffffc0204668:	26e00593          	li	a1,622
ffffffffc020466c:	00005517          	auipc	a0,0x5
ffffffffc0204670:	f2450513          	addi	a0,a0,-220 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0204674:	b95fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204678:	00005697          	auipc	a3,0x5
ffffffffc020467c:	19068693          	addi	a3,a3,400 # ffffffffc0209808 <default_pmm_manager+0x4e0>
ffffffffc0204680:	00004617          	auipc	a2,0x4
ffffffffc0204684:	f6860613          	addi	a2,a2,-152 # ffffffffc02085e8 <commands+0x410>
ffffffffc0204688:	26d00593          	li	a1,621
ffffffffc020468c:	00005517          	auipc	a0,0x5
ffffffffc0204690:	f0450513          	addi	a0,a0,-252 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0204694:	b75fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204698:	00005697          	auipc	a3,0x5
ffffffffc020469c:	12868693          	addi	a3,a3,296 # ffffffffc02097c0 <default_pmm_manager+0x498>
ffffffffc02046a0:	00004617          	auipc	a2,0x4
ffffffffc02046a4:	f4860613          	addi	a2,a2,-184 # ffffffffc02085e8 <commands+0x410>
ffffffffc02046a8:	26c00593          	li	a1,620
ffffffffc02046ac:	00005517          	auipc	a0,0x5
ffffffffc02046b0:	ee450513          	addi	a0,a0,-284 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc02046b4:	b55fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02046b8:	00005697          	auipc	a3,0x5
ffffffffc02046bc:	0c068693          	addi	a3,a3,192 # ffffffffc0209778 <default_pmm_manager+0x450>
ffffffffc02046c0:	00004617          	auipc	a2,0x4
ffffffffc02046c4:	f2860613          	addi	a2,a2,-216 # ffffffffc02085e8 <commands+0x410>
ffffffffc02046c8:	26b00593          	li	a1,619
ffffffffc02046cc:	00005517          	auipc	a0,0x5
ffffffffc02046d0:	ec450513          	addi	a0,a0,-316 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc02046d4:	b35fb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02046d8 <do_yield>:
ffffffffc02046d8:	00015797          	auipc	a5,0x15
ffffffffc02046dc:	e207b783          	ld	a5,-480(a5) # ffffffffc02194f8 <current>
ffffffffc02046e0:	4705                	li	a4,1
ffffffffc02046e2:	ef98                	sd	a4,24(a5)
ffffffffc02046e4:	4501                	li	a0,0
ffffffffc02046e6:	8082                	ret

ffffffffc02046e8 <do_wait>:
ffffffffc02046e8:	1101                	addi	sp,sp,-32
ffffffffc02046ea:	e822                	sd	s0,16(sp)
ffffffffc02046ec:	e426                	sd	s1,8(sp)
ffffffffc02046ee:	ec06                	sd	ra,24(sp)
ffffffffc02046f0:	842e                	mv	s0,a1
ffffffffc02046f2:	84aa                	mv	s1,a0
ffffffffc02046f4:	c999                	beqz	a1,ffffffffc020470a <do_wait+0x22>
ffffffffc02046f6:	00015797          	auipc	a5,0x15
ffffffffc02046fa:	e027b783          	ld	a5,-510(a5) # ffffffffc02194f8 <current>
ffffffffc02046fe:	7788                	ld	a0,40(a5)
ffffffffc0204700:	4685                	li	a3,1
ffffffffc0204702:	4611                	li	a2,4
ffffffffc0204704:	ca8fd0ef          	jal	ra,ffffffffc0201bac <user_mem_check>
ffffffffc0204708:	c909                	beqz	a0,ffffffffc020471a <do_wait+0x32>
ffffffffc020470a:	85a2                	mv	a1,s0
ffffffffc020470c:	6442                	ld	s0,16(sp)
ffffffffc020470e:	60e2                	ld	ra,24(sp)
ffffffffc0204710:	8526                	mv	a0,s1
ffffffffc0204712:	64a2                	ld	s1,8(sp)
ffffffffc0204714:	6105                	addi	sp,sp,32
ffffffffc0204716:	fa6ff06f          	j	ffffffffc0203ebc <do_wait.part.0>
ffffffffc020471a:	60e2                	ld	ra,24(sp)
ffffffffc020471c:	6442                	ld	s0,16(sp)
ffffffffc020471e:	64a2                	ld	s1,8(sp)
ffffffffc0204720:	5575                	li	a0,-3
ffffffffc0204722:	6105                	addi	sp,sp,32
ffffffffc0204724:	8082                	ret

ffffffffc0204726 <do_kill>:
ffffffffc0204726:	1141                	addi	sp,sp,-16
ffffffffc0204728:	e406                	sd	ra,8(sp)
ffffffffc020472a:	e022                	sd	s0,0(sp)
ffffffffc020472c:	960ff0ef          	jal	ra,ffffffffc020388c <find_proc>
ffffffffc0204730:	cd0d                	beqz	a0,ffffffffc020476a <do_kill+0x44>
ffffffffc0204732:	0b052703          	lw	a4,176(a0)
ffffffffc0204736:	00177693          	andi	a3,a4,1
ffffffffc020473a:	e695                	bnez	a3,ffffffffc0204766 <do_kill+0x40>
ffffffffc020473c:	0ec52683          	lw	a3,236(a0)
ffffffffc0204740:	00176713          	ori	a4,a4,1
ffffffffc0204744:	0ae52823          	sw	a4,176(a0)
ffffffffc0204748:	4401                	li	s0,0
ffffffffc020474a:	0006c763          	bltz	a3,ffffffffc0204758 <do_kill+0x32>
ffffffffc020474e:	60a2                	ld	ra,8(sp)
ffffffffc0204750:	8522                	mv	a0,s0
ffffffffc0204752:	6402                	ld	s0,0(sp)
ffffffffc0204754:	0141                	addi	sp,sp,16
ffffffffc0204756:	8082                	ret
ffffffffc0204758:	276000ef          	jal	ra,ffffffffc02049ce <wakeup_proc>
ffffffffc020475c:	60a2                	ld	ra,8(sp)
ffffffffc020475e:	8522                	mv	a0,s0
ffffffffc0204760:	6402                	ld	s0,0(sp)
ffffffffc0204762:	0141                	addi	sp,sp,16
ffffffffc0204764:	8082                	ret
ffffffffc0204766:	545d                	li	s0,-9
ffffffffc0204768:	b7dd                	j	ffffffffc020474e <do_kill+0x28>
ffffffffc020476a:	5475                	li	s0,-3
ffffffffc020476c:	b7cd                	j	ffffffffc020474e <do_kill+0x28>

ffffffffc020476e <proc_init>:
ffffffffc020476e:	1101                	addi	sp,sp,-32
ffffffffc0204770:	00015797          	auipc	a5,0x15
ffffffffc0204774:	fc878793          	addi	a5,a5,-56 # ffffffffc0219738 <proc_list>
ffffffffc0204778:	ec06                	sd	ra,24(sp)
ffffffffc020477a:	e822                	sd	s0,16(sp)
ffffffffc020477c:	e426                	sd	s1,8(sp)
ffffffffc020477e:	e04a                	sd	s2,0(sp)
ffffffffc0204780:	e79c                	sd	a5,8(a5)
ffffffffc0204782:	e39c                	sd	a5,0(a5)
ffffffffc0204784:	00015717          	auipc	a4,0x15
ffffffffc0204788:	d0c70713          	addi	a4,a4,-756 # ffffffffc0219490 <__rq>
ffffffffc020478c:	00011797          	auipc	a5,0x11
ffffffffc0204790:	d0478793          	addi	a5,a5,-764 # ffffffffc0215490 <hash_list>
ffffffffc0204794:	e79c                	sd	a5,8(a5)
ffffffffc0204796:	e39c                	sd	a5,0(a5)
ffffffffc0204798:	07c1                	addi	a5,a5,16
ffffffffc020479a:	fef71de3          	bne	a4,a5,ffffffffc0204794 <proc_init+0x26>
ffffffffc020479e:	f57fe0ef          	jal	ra,ffffffffc02036f4 <alloc_proc>
ffffffffc02047a2:	00015417          	auipc	s0,0x15
ffffffffc02047a6:	d5e40413          	addi	s0,s0,-674 # ffffffffc0219500 <idleproc>
ffffffffc02047aa:	e008                	sd	a0,0(s0)
ffffffffc02047ac:	c541                	beqz	a0,ffffffffc0204834 <proc_init+0xc6>
ffffffffc02047ae:	4709                	li	a4,2
ffffffffc02047b0:	e118                	sd	a4,0(a0)
ffffffffc02047b2:	4485                	li	s1,1
ffffffffc02047b4:	00007717          	auipc	a4,0x7
ffffffffc02047b8:	84c70713          	addi	a4,a4,-1972 # ffffffffc020b000 <bootstack>
ffffffffc02047bc:	00005597          	auipc	a1,0x5
ffffffffc02047c0:	0f458593          	addi	a1,a1,244 # ffffffffc02098b0 <default_pmm_manager+0x588>
ffffffffc02047c4:	e918                	sd	a4,16(a0)
ffffffffc02047c6:	ed04                	sd	s1,24(a0)
ffffffffc02047c8:	82eff0ef          	jal	ra,ffffffffc02037f6 <set_proc_name>
ffffffffc02047cc:	00015717          	auipc	a4,0x15
ffffffffc02047d0:	d4470713          	addi	a4,a4,-700 # ffffffffc0219510 <nr_process>
ffffffffc02047d4:	431c                	lw	a5,0(a4)
ffffffffc02047d6:	6014                	ld	a3,0(s0)
ffffffffc02047d8:	4601                	li	a2,0
ffffffffc02047da:	2785                	addiw	a5,a5,1
ffffffffc02047dc:	4581                	li	a1,0
ffffffffc02047de:	00000517          	auipc	a0,0x0
ffffffffc02047e2:	87450513          	addi	a0,a0,-1932 # ffffffffc0204052 <init_main>
ffffffffc02047e6:	c31c                	sw	a5,0(a4)
ffffffffc02047e8:	00015797          	auipc	a5,0x15
ffffffffc02047ec:	d0d7b823          	sd	a3,-752(a5) # ffffffffc02194f8 <current>
ffffffffc02047f0:	cc6ff0ef          	jal	ra,ffffffffc0203cb6 <kernel_thread>
ffffffffc02047f4:	08a05c63          	blez	a0,ffffffffc020488c <proc_init+0x11e>
ffffffffc02047f8:	894ff0ef          	jal	ra,ffffffffc020388c <find_proc>
ffffffffc02047fc:	00015917          	auipc	s2,0x15
ffffffffc0204800:	d0c90913          	addi	s2,s2,-756 # ffffffffc0219508 <initproc>
ffffffffc0204804:	00005597          	auipc	a1,0x5
ffffffffc0204808:	0d458593          	addi	a1,a1,212 # ffffffffc02098d8 <default_pmm_manager+0x5b0>
ffffffffc020480c:	00a93023          	sd	a0,0(s2)
ffffffffc0204810:	fe7fe0ef          	jal	ra,ffffffffc02037f6 <set_proc_name>
ffffffffc0204814:	601c                	ld	a5,0(s0)
ffffffffc0204816:	cbb9                	beqz	a5,ffffffffc020486c <proc_init+0xfe>
ffffffffc0204818:	43dc                	lw	a5,4(a5)
ffffffffc020481a:	eba9                	bnez	a5,ffffffffc020486c <proc_init+0xfe>
ffffffffc020481c:	00093783          	ld	a5,0(s2)
ffffffffc0204820:	c795                	beqz	a5,ffffffffc020484c <proc_init+0xde>
ffffffffc0204822:	43dc                	lw	a5,4(a5)
ffffffffc0204824:	02979463          	bne	a5,s1,ffffffffc020484c <proc_init+0xde>
ffffffffc0204828:	60e2                	ld	ra,24(sp)
ffffffffc020482a:	6442                	ld	s0,16(sp)
ffffffffc020482c:	64a2                	ld	s1,8(sp)
ffffffffc020482e:	6902                	ld	s2,0(sp)
ffffffffc0204830:	6105                	addi	sp,sp,32
ffffffffc0204832:	8082                	ret
ffffffffc0204834:	00005617          	auipc	a2,0x5
ffffffffc0204838:	06460613          	addi	a2,a2,100 # ffffffffc0209898 <default_pmm_manager+0x570>
ffffffffc020483c:	37400593          	li	a1,884
ffffffffc0204840:	00005517          	auipc	a0,0x5
ffffffffc0204844:	d5050513          	addi	a0,a0,-688 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0204848:	9c1fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020484c:	00005697          	auipc	a3,0x5
ffffffffc0204850:	0bc68693          	addi	a3,a3,188 # ffffffffc0209908 <default_pmm_manager+0x5e0>
ffffffffc0204854:	00004617          	auipc	a2,0x4
ffffffffc0204858:	d9460613          	addi	a2,a2,-620 # ffffffffc02085e8 <commands+0x410>
ffffffffc020485c:	38900593          	li	a1,905
ffffffffc0204860:	00005517          	auipc	a0,0x5
ffffffffc0204864:	d3050513          	addi	a0,a0,-720 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0204868:	9a1fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020486c:	00005697          	auipc	a3,0x5
ffffffffc0204870:	07468693          	addi	a3,a3,116 # ffffffffc02098e0 <default_pmm_manager+0x5b8>
ffffffffc0204874:	00004617          	auipc	a2,0x4
ffffffffc0204878:	d7460613          	addi	a2,a2,-652 # ffffffffc02085e8 <commands+0x410>
ffffffffc020487c:	38800593          	li	a1,904
ffffffffc0204880:	00005517          	auipc	a0,0x5
ffffffffc0204884:	d1050513          	addi	a0,a0,-752 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0204888:	981fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020488c:	00005617          	auipc	a2,0x5
ffffffffc0204890:	02c60613          	addi	a2,a2,44 # ffffffffc02098b8 <default_pmm_manager+0x590>
ffffffffc0204894:	38200593          	li	a1,898
ffffffffc0204898:	00005517          	auipc	a0,0x5
ffffffffc020489c:	cf850513          	addi	a0,a0,-776 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc02048a0:	969fb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02048a4 <cpu_idle>:
ffffffffc02048a4:	1141                	addi	sp,sp,-16
ffffffffc02048a6:	e022                	sd	s0,0(sp)
ffffffffc02048a8:	e406                	sd	ra,8(sp)
ffffffffc02048aa:	00015417          	auipc	s0,0x15
ffffffffc02048ae:	c4e40413          	addi	s0,s0,-946 # ffffffffc02194f8 <current>
ffffffffc02048b2:	6018                	ld	a4,0(s0)
ffffffffc02048b4:	6f1c                	ld	a5,24(a4)
ffffffffc02048b6:	dffd                	beqz	a5,ffffffffc02048b4 <cpu_idle+0x10>
ffffffffc02048b8:	1c8000ef          	jal	ra,ffffffffc0204a80 <schedule>
ffffffffc02048bc:	bfdd                	j	ffffffffc02048b2 <cpu_idle+0xe>

ffffffffc02048be <lab6_set_priority>:
ffffffffc02048be:	1141                	addi	sp,sp,-16
ffffffffc02048c0:	e022                	sd	s0,0(sp)
ffffffffc02048c2:	85aa                	mv	a1,a0
ffffffffc02048c4:	842a                	mv	s0,a0
ffffffffc02048c6:	00005517          	auipc	a0,0x5
ffffffffc02048ca:	06a50513          	addi	a0,a0,106 # ffffffffc0209930 <default_pmm_manager+0x608>
ffffffffc02048ce:	e406                	sd	ra,8(sp)
ffffffffc02048d0:	ffcfb0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02048d4:	00015797          	auipc	a5,0x15
ffffffffc02048d8:	c247b783          	ld	a5,-988(a5) # ffffffffc02194f8 <current>
ffffffffc02048dc:	e801                	bnez	s0,ffffffffc02048ec <lab6_set_priority+0x2e>
ffffffffc02048de:	60a2                	ld	ra,8(sp)
ffffffffc02048e0:	6402                	ld	s0,0(sp)
ffffffffc02048e2:	4705                	li	a4,1
ffffffffc02048e4:	14e7a223          	sw	a4,324(a5)
ffffffffc02048e8:	0141                	addi	sp,sp,16
ffffffffc02048ea:	8082                	ret
ffffffffc02048ec:	60a2                	ld	ra,8(sp)
ffffffffc02048ee:	1487a223          	sw	s0,324(a5)
ffffffffc02048f2:	6402                	ld	s0,0(sp)
ffffffffc02048f4:	0141                	addi	sp,sp,16
ffffffffc02048f6:	8082                	ret

ffffffffc02048f8 <do_sleep>:
ffffffffc02048f8:	c539                	beqz	a0,ffffffffc0204946 <do_sleep+0x4e>
ffffffffc02048fa:	7179                	addi	sp,sp,-48
ffffffffc02048fc:	f022                	sd	s0,32(sp)
ffffffffc02048fe:	f406                	sd	ra,40(sp)
ffffffffc0204900:	842a                	mv	s0,a0
ffffffffc0204902:	100027f3          	csrr	a5,sstatus
ffffffffc0204906:	8b89                	andi	a5,a5,2
ffffffffc0204908:	e3a9                	bnez	a5,ffffffffc020494a <do_sleep+0x52>
ffffffffc020490a:	00015797          	auipc	a5,0x15
ffffffffc020490e:	bee7b783          	ld	a5,-1042(a5) # ffffffffc02194f8 <current>
ffffffffc0204912:	0818                	addi	a4,sp,16
ffffffffc0204914:	c02a                	sw	a0,0(sp)
ffffffffc0204916:	ec3a                	sd	a4,24(sp)
ffffffffc0204918:	e83a                	sd	a4,16(sp)
ffffffffc020491a:	e43e                	sd	a5,8(sp)
ffffffffc020491c:	4705                	li	a4,1
ffffffffc020491e:	c398                	sw	a4,0(a5)
ffffffffc0204920:	80000737          	lui	a4,0x80000
ffffffffc0204924:	840a                	mv	s0,sp
ffffffffc0204926:	2709                	addiw	a4,a4,2
ffffffffc0204928:	0ee7a623          	sw	a4,236(a5)
ffffffffc020492c:	8522                	mv	a0,s0
ffffffffc020492e:	218000ef          	jal	ra,ffffffffc0204b46 <add_timer>
ffffffffc0204932:	14e000ef          	jal	ra,ffffffffc0204a80 <schedule>
ffffffffc0204936:	8522                	mv	a0,s0
ffffffffc0204938:	2d6000ef          	jal	ra,ffffffffc0204c0e <del_timer>
ffffffffc020493c:	70a2                	ld	ra,40(sp)
ffffffffc020493e:	7402                	ld	s0,32(sp)
ffffffffc0204940:	4501                	li	a0,0
ffffffffc0204942:	6145                	addi	sp,sp,48
ffffffffc0204944:	8082                	ret
ffffffffc0204946:	4501                	li	a0,0
ffffffffc0204948:	8082                	ret
ffffffffc020494a:	ceffb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc020494e:	00015797          	auipc	a5,0x15
ffffffffc0204952:	baa7b783          	ld	a5,-1110(a5) # ffffffffc02194f8 <current>
ffffffffc0204956:	0818                	addi	a4,sp,16
ffffffffc0204958:	c022                	sw	s0,0(sp)
ffffffffc020495a:	e43e                	sd	a5,8(sp)
ffffffffc020495c:	ec3a                	sd	a4,24(sp)
ffffffffc020495e:	e83a                	sd	a4,16(sp)
ffffffffc0204960:	4705                	li	a4,1
ffffffffc0204962:	c398                	sw	a4,0(a5)
ffffffffc0204964:	80000737          	lui	a4,0x80000
ffffffffc0204968:	2709                	addiw	a4,a4,2
ffffffffc020496a:	840a                	mv	s0,sp
ffffffffc020496c:	8522                	mv	a0,s0
ffffffffc020496e:	0ee7a623          	sw	a4,236(a5)
ffffffffc0204972:	1d4000ef          	jal	ra,ffffffffc0204b46 <add_timer>
ffffffffc0204976:	cbdfb0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc020497a:	bf65                	j	ffffffffc0204932 <do_sleep+0x3a>

ffffffffc020497c <sched_init>:
ffffffffc020497c:	1141                	addi	sp,sp,-16
ffffffffc020497e:	00009717          	auipc	a4,0x9
ffffffffc0204982:	6d270713          	addi	a4,a4,1746 # ffffffffc020e050 <default_sched_class>
ffffffffc0204986:	e022                	sd	s0,0(sp)
ffffffffc0204988:	e406                	sd	ra,8(sp)
ffffffffc020498a:	00015797          	auipc	a5,0x15
ffffffffc020498e:	b2678793          	addi	a5,a5,-1242 # ffffffffc02194b0 <timer_list>
ffffffffc0204992:	6714                	ld	a3,8(a4)
ffffffffc0204994:	00015517          	auipc	a0,0x15
ffffffffc0204998:	afc50513          	addi	a0,a0,-1284 # ffffffffc0219490 <__rq>
ffffffffc020499c:	e79c                	sd	a5,8(a5)
ffffffffc020499e:	e39c                	sd	a5,0(a5)
ffffffffc02049a0:	4795                	li	a5,5
ffffffffc02049a2:	c95c                	sw	a5,20(a0)
ffffffffc02049a4:	00015417          	auipc	s0,0x15
ffffffffc02049a8:	b7c40413          	addi	s0,s0,-1156 # ffffffffc0219520 <sched_class>
ffffffffc02049ac:	00015797          	auipc	a5,0x15
ffffffffc02049b0:	b6a7b623          	sd	a0,-1172(a5) # ffffffffc0219518 <rq>
ffffffffc02049b4:	e018                	sd	a4,0(s0)
ffffffffc02049b6:	9682                	jalr	a3
ffffffffc02049b8:	601c                	ld	a5,0(s0)
ffffffffc02049ba:	6402                	ld	s0,0(sp)
ffffffffc02049bc:	60a2                	ld	ra,8(sp)
ffffffffc02049be:	638c                	ld	a1,0(a5)
ffffffffc02049c0:	00005517          	auipc	a0,0x5
ffffffffc02049c4:	f8850513          	addi	a0,a0,-120 # ffffffffc0209948 <default_pmm_manager+0x620>
ffffffffc02049c8:	0141                	addi	sp,sp,16
ffffffffc02049ca:	f02fb06f          	j	ffffffffc02000cc <cprintf>

ffffffffc02049ce <wakeup_proc>:
ffffffffc02049ce:	4118                	lw	a4,0(a0)
ffffffffc02049d0:	1101                	addi	sp,sp,-32
ffffffffc02049d2:	ec06                	sd	ra,24(sp)
ffffffffc02049d4:	e822                	sd	s0,16(sp)
ffffffffc02049d6:	e426                	sd	s1,8(sp)
ffffffffc02049d8:	478d                	li	a5,3
ffffffffc02049da:	08f70363          	beq	a4,a5,ffffffffc0204a60 <wakeup_proc+0x92>
ffffffffc02049de:	842a                	mv	s0,a0
ffffffffc02049e0:	100027f3          	csrr	a5,sstatus
ffffffffc02049e4:	8b89                	andi	a5,a5,2
ffffffffc02049e6:	4481                	li	s1,0
ffffffffc02049e8:	e7bd                	bnez	a5,ffffffffc0204a56 <wakeup_proc+0x88>
ffffffffc02049ea:	4789                	li	a5,2
ffffffffc02049ec:	04f70863          	beq	a4,a5,ffffffffc0204a3c <wakeup_proc+0x6e>
ffffffffc02049f0:	c01c                	sw	a5,0(s0)
ffffffffc02049f2:	0e042623          	sw	zero,236(s0)
ffffffffc02049f6:	00015797          	auipc	a5,0x15
ffffffffc02049fa:	b027b783          	ld	a5,-1278(a5) # ffffffffc02194f8 <current>
ffffffffc02049fe:	02878363          	beq	a5,s0,ffffffffc0204a24 <wakeup_proc+0x56>
ffffffffc0204a02:	00015797          	auipc	a5,0x15
ffffffffc0204a06:	afe7b783          	ld	a5,-1282(a5) # ffffffffc0219500 <idleproc>
ffffffffc0204a0a:	00f40d63          	beq	s0,a5,ffffffffc0204a24 <wakeup_proc+0x56>
ffffffffc0204a0e:	00015797          	auipc	a5,0x15
ffffffffc0204a12:	b127b783          	ld	a5,-1262(a5) # ffffffffc0219520 <sched_class>
ffffffffc0204a16:	6b9c                	ld	a5,16(a5)
ffffffffc0204a18:	85a2                	mv	a1,s0
ffffffffc0204a1a:	00015517          	auipc	a0,0x15
ffffffffc0204a1e:	afe53503          	ld	a0,-1282(a0) # ffffffffc0219518 <rq>
ffffffffc0204a22:	9782                	jalr	a5
ffffffffc0204a24:	e491                	bnez	s1,ffffffffc0204a30 <wakeup_proc+0x62>
ffffffffc0204a26:	60e2                	ld	ra,24(sp)
ffffffffc0204a28:	6442                	ld	s0,16(sp)
ffffffffc0204a2a:	64a2                	ld	s1,8(sp)
ffffffffc0204a2c:	6105                	addi	sp,sp,32
ffffffffc0204a2e:	8082                	ret
ffffffffc0204a30:	6442                	ld	s0,16(sp)
ffffffffc0204a32:	60e2                	ld	ra,24(sp)
ffffffffc0204a34:	64a2                	ld	s1,8(sp)
ffffffffc0204a36:	6105                	addi	sp,sp,32
ffffffffc0204a38:	bfbfb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204a3c:	00005617          	auipc	a2,0x5
ffffffffc0204a40:	f5c60613          	addi	a2,a2,-164 # ffffffffc0209998 <default_pmm_manager+0x670>
ffffffffc0204a44:	04800593          	li	a1,72
ffffffffc0204a48:	00005517          	auipc	a0,0x5
ffffffffc0204a4c:	f3850513          	addi	a0,a0,-200 # ffffffffc0209980 <default_pmm_manager+0x658>
ffffffffc0204a50:	821fb0ef          	jal	ra,ffffffffc0200270 <__warn>
ffffffffc0204a54:	bfc1                	j	ffffffffc0204a24 <wakeup_proc+0x56>
ffffffffc0204a56:	be3fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204a5a:	4018                	lw	a4,0(s0)
ffffffffc0204a5c:	4485                	li	s1,1
ffffffffc0204a5e:	b771                	j	ffffffffc02049ea <wakeup_proc+0x1c>
ffffffffc0204a60:	00005697          	auipc	a3,0x5
ffffffffc0204a64:	f0068693          	addi	a3,a3,-256 # ffffffffc0209960 <default_pmm_manager+0x638>
ffffffffc0204a68:	00004617          	auipc	a2,0x4
ffffffffc0204a6c:	b8060613          	addi	a2,a2,-1152 # ffffffffc02085e8 <commands+0x410>
ffffffffc0204a70:	03c00593          	li	a1,60
ffffffffc0204a74:	00005517          	auipc	a0,0x5
ffffffffc0204a78:	f0c50513          	addi	a0,a0,-244 # ffffffffc0209980 <default_pmm_manager+0x658>
ffffffffc0204a7c:	f8cfb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204a80 <schedule>:
ffffffffc0204a80:	7179                	addi	sp,sp,-48
ffffffffc0204a82:	f406                	sd	ra,40(sp)
ffffffffc0204a84:	f022                	sd	s0,32(sp)
ffffffffc0204a86:	ec26                	sd	s1,24(sp)
ffffffffc0204a88:	e84a                	sd	s2,16(sp)
ffffffffc0204a8a:	e44e                	sd	s3,8(sp)
ffffffffc0204a8c:	e052                	sd	s4,0(sp)
ffffffffc0204a8e:	100027f3          	csrr	a5,sstatus
ffffffffc0204a92:	8b89                	andi	a5,a5,2
ffffffffc0204a94:	4a01                	li	s4,0
ffffffffc0204a96:	e7c5                	bnez	a5,ffffffffc0204b3e <schedule+0xbe>
ffffffffc0204a98:	00015497          	auipc	s1,0x15
ffffffffc0204a9c:	a6048493          	addi	s1,s1,-1440 # ffffffffc02194f8 <current>
ffffffffc0204aa0:	608c                	ld	a1,0(s1)
ffffffffc0204aa2:	00015997          	auipc	s3,0x15
ffffffffc0204aa6:	a7e98993          	addi	s3,s3,-1410 # ffffffffc0219520 <sched_class>
ffffffffc0204aaa:	00015917          	auipc	s2,0x15
ffffffffc0204aae:	a6e90913          	addi	s2,s2,-1426 # ffffffffc0219518 <rq>
ffffffffc0204ab2:	4194                	lw	a3,0(a1)
ffffffffc0204ab4:	0005bc23          	sd	zero,24(a1)
ffffffffc0204ab8:	4709                	li	a4,2
ffffffffc0204aba:	0009b783          	ld	a5,0(s3)
ffffffffc0204abe:	00093503          	ld	a0,0(s2)
ffffffffc0204ac2:	04e68063          	beq	a3,a4,ffffffffc0204b02 <schedule+0x82>
ffffffffc0204ac6:	739c                	ld	a5,32(a5)
ffffffffc0204ac8:	9782                	jalr	a5
ffffffffc0204aca:	842a                	mv	s0,a0
ffffffffc0204acc:	c939                	beqz	a0,ffffffffc0204b22 <schedule+0xa2>
ffffffffc0204ace:	0009b783          	ld	a5,0(s3)
ffffffffc0204ad2:	00093503          	ld	a0,0(s2)
ffffffffc0204ad6:	85a2                	mv	a1,s0
ffffffffc0204ad8:	6f9c                	ld	a5,24(a5)
ffffffffc0204ada:	9782                	jalr	a5
ffffffffc0204adc:	441c                	lw	a5,8(s0)
ffffffffc0204ade:	6098                	ld	a4,0(s1)
ffffffffc0204ae0:	2785                	addiw	a5,a5,1
ffffffffc0204ae2:	c41c                	sw	a5,8(s0)
ffffffffc0204ae4:	00870563          	beq	a4,s0,ffffffffc0204aee <schedule+0x6e>
ffffffffc0204ae8:	8522                	mv	a0,s0
ffffffffc0204aea:	d37fe0ef          	jal	ra,ffffffffc0203820 <proc_run>
ffffffffc0204aee:	020a1f63          	bnez	s4,ffffffffc0204b2c <schedule+0xac>
ffffffffc0204af2:	70a2                	ld	ra,40(sp)
ffffffffc0204af4:	7402                	ld	s0,32(sp)
ffffffffc0204af6:	64e2                	ld	s1,24(sp)
ffffffffc0204af8:	6942                	ld	s2,16(sp)
ffffffffc0204afa:	69a2                	ld	s3,8(sp)
ffffffffc0204afc:	6a02                	ld	s4,0(sp)
ffffffffc0204afe:	6145                	addi	sp,sp,48
ffffffffc0204b00:	8082                	ret
ffffffffc0204b02:	00015717          	auipc	a4,0x15
ffffffffc0204b06:	9fe73703          	ld	a4,-1538(a4) # ffffffffc0219500 <idleproc>
ffffffffc0204b0a:	fae58ee3          	beq	a1,a4,ffffffffc0204ac6 <schedule+0x46>
ffffffffc0204b0e:	6b9c                	ld	a5,16(a5)
ffffffffc0204b10:	9782                	jalr	a5
ffffffffc0204b12:	0009b783          	ld	a5,0(s3)
ffffffffc0204b16:	00093503          	ld	a0,0(s2)
ffffffffc0204b1a:	739c                	ld	a5,32(a5)
ffffffffc0204b1c:	9782                	jalr	a5
ffffffffc0204b1e:	842a                	mv	s0,a0
ffffffffc0204b20:	f55d                	bnez	a0,ffffffffc0204ace <schedule+0x4e>
ffffffffc0204b22:	00015417          	auipc	s0,0x15
ffffffffc0204b26:	9de43403          	ld	s0,-1570(s0) # ffffffffc0219500 <idleproc>
ffffffffc0204b2a:	bf4d                	j	ffffffffc0204adc <schedule+0x5c>
ffffffffc0204b2c:	7402                	ld	s0,32(sp)
ffffffffc0204b2e:	70a2                	ld	ra,40(sp)
ffffffffc0204b30:	64e2                	ld	s1,24(sp)
ffffffffc0204b32:	6942                	ld	s2,16(sp)
ffffffffc0204b34:	69a2                	ld	s3,8(sp)
ffffffffc0204b36:	6a02                	ld	s4,0(sp)
ffffffffc0204b38:	6145                	addi	sp,sp,48
ffffffffc0204b3a:	af9fb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204b3e:	afbfb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204b42:	4a05                	li	s4,1
ffffffffc0204b44:	bf91                	j	ffffffffc0204a98 <schedule+0x18>

ffffffffc0204b46 <add_timer>:
ffffffffc0204b46:	1141                	addi	sp,sp,-16
ffffffffc0204b48:	e022                	sd	s0,0(sp)
ffffffffc0204b4a:	e406                	sd	ra,8(sp)
ffffffffc0204b4c:	842a                	mv	s0,a0
ffffffffc0204b4e:	100027f3          	csrr	a5,sstatus
ffffffffc0204b52:	8b89                	andi	a5,a5,2
ffffffffc0204b54:	4501                	li	a0,0
ffffffffc0204b56:	eba5                	bnez	a5,ffffffffc0204bc6 <add_timer+0x80>
ffffffffc0204b58:	401c                	lw	a5,0(s0)
ffffffffc0204b5a:	cbb5                	beqz	a5,ffffffffc0204bce <add_timer+0x88>
ffffffffc0204b5c:	6418                	ld	a4,8(s0)
ffffffffc0204b5e:	cb25                	beqz	a4,ffffffffc0204bce <add_timer+0x88>
ffffffffc0204b60:	6c18                	ld	a4,24(s0)
ffffffffc0204b62:	01040593          	addi	a1,s0,16
ffffffffc0204b66:	08e59463          	bne	a1,a4,ffffffffc0204bee <add_timer+0xa8>
ffffffffc0204b6a:	00015617          	auipc	a2,0x15
ffffffffc0204b6e:	94660613          	addi	a2,a2,-1722 # ffffffffc02194b0 <timer_list>
ffffffffc0204b72:	6618                	ld	a4,8(a2)
ffffffffc0204b74:	00c71863          	bne	a4,a2,ffffffffc0204b84 <add_timer+0x3e>
ffffffffc0204b78:	a80d                	j	ffffffffc0204baa <add_timer+0x64>
ffffffffc0204b7a:	6718                	ld	a4,8(a4)
ffffffffc0204b7c:	9f95                	subw	a5,a5,a3
ffffffffc0204b7e:	c01c                	sw	a5,0(s0)
ffffffffc0204b80:	02c70563          	beq	a4,a2,ffffffffc0204baa <add_timer+0x64>
ffffffffc0204b84:	ff072683          	lw	a3,-16(a4)
ffffffffc0204b88:	fed7f9e3          	bgeu	a5,a3,ffffffffc0204b7a <add_timer+0x34>
ffffffffc0204b8c:	40f687bb          	subw	a5,a3,a5
ffffffffc0204b90:	fef72823          	sw	a5,-16(a4)
ffffffffc0204b94:	631c                	ld	a5,0(a4)
ffffffffc0204b96:	e30c                	sd	a1,0(a4)
ffffffffc0204b98:	e78c                	sd	a1,8(a5)
ffffffffc0204b9a:	ec18                	sd	a4,24(s0)
ffffffffc0204b9c:	e81c                	sd	a5,16(s0)
ffffffffc0204b9e:	c105                	beqz	a0,ffffffffc0204bbe <add_timer+0x78>
ffffffffc0204ba0:	6402                	ld	s0,0(sp)
ffffffffc0204ba2:	60a2                	ld	ra,8(sp)
ffffffffc0204ba4:	0141                	addi	sp,sp,16
ffffffffc0204ba6:	a8dfb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204baa:	00015717          	auipc	a4,0x15
ffffffffc0204bae:	90670713          	addi	a4,a4,-1786 # ffffffffc02194b0 <timer_list>
ffffffffc0204bb2:	631c                	ld	a5,0(a4)
ffffffffc0204bb4:	e30c                	sd	a1,0(a4)
ffffffffc0204bb6:	e78c                	sd	a1,8(a5)
ffffffffc0204bb8:	ec18                	sd	a4,24(s0)
ffffffffc0204bba:	e81c                	sd	a5,16(s0)
ffffffffc0204bbc:	f175                	bnez	a0,ffffffffc0204ba0 <add_timer+0x5a>
ffffffffc0204bbe:	60a2                	ld	ra,8(sp)
ffffffffc0204bc0:	6402                	ld	s0,0(sp)
ffffffffc0204bc2:	0141                	addi	sp,sp,16
ffffffffc0204bc4:	8082                	ret
ffffffffc0204bc6:	a73fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204bca:	4505                	li	a0,1
ffffffffc0204bcc:	b771                	j	ffffffffc0204b58 <add_timer+0x12>
ffffffffc0204bce:	00005697          	auipc	a3,0x5
ffffffffc0204bd2:	dea68693          	addi	a3,a3,-534 # ffffffffc02099b8 <default_pmm_manager+0x690>
ffffffffc0204bd6:	00004617          	auipc	a2,0x4
ffffffffc0204bda:	a1260613          	addi	a2,a2,-1518 # ffffffffc02085e8 <commands+0x410>
ffffffffc0204bde:	06c00593          	li	a1,108
ffffffffc0204be2:	00005517          	auipc	a0,0x5
ffffffffc0204be6:	d9e50513          	addi	a0,a0,-610 # ffffffffc0209980 <default_pmm_manager+0x658>
ffffffffc0204bea:	e1efb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204bee:	00005697          	auipc	a3,0x5
ffffffffc0204bf2:	dfa68693          	addi	a3,a3,-518 # ffffffffc02099e8 <default_pmm_manager+0x6c0>
ffffffffc0204bf6:	00004617          	auipc	a2,0x4
ffffffffc0204bfa:	9f260613          	addi	a2,a2,-1550 # ffffffffc02085e8 <commands+0x410>
ffffffffc0204bfe:	06d00593          	li	a1,109
ffffffffc0204c02:	00005517          	auipc	a0,0x5
ffffffffc0204c06:	d7e50513          	addi	a0,a0,-642 # ffffffffc0209980 <default_pmm_manager+0x658>
ffffffffc0204c0a:	dfefb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204c0e <del_timer>:
ffffffffc0204c0e:	1101                	addi	sp,sp,-32
ffffffffc0204c10:	e822                	sd	s0,16(sp)
ffffffffc0204c12:	ec06                	sd	ra,24(sp)
ffffffffc0204c14:	e426                	sd	s1,8(sp)
ffffffffc0204c16:	842a                	mv	s0,a0
ffffffffc0204c18:	100027f3          	csrr	a5,sstatus
ffffffffc0204c1c:	8b89                	andi	a5,a5,2
ffffffffc0204c1e:	01050493          	addi	s1,a0,16
ffffffffc0204c22:	eb9d                	bnez	a5,ffffffffc0204c58 <del_timer+0x4a>
ffffffffc0204c24:	6d1c                	ld	a5,24(a0)
ffffffffc0204c26:	02978463          	beq	a5,s1,ffffffffc0204c4e <del_timer+0x40>
ffffffffc0204c2a:	4114                	lw	a3,0(a0)
ffffffffc0204c2c:	6918                	ld	a4,16(a0)
ffffffffc0204c2e:	ce81                	beqz	a3,ffffffffc0204c46 <del_timer+0x38>
ffffffffc0204c30:	00015617          	auipc	a2,0x15
ffffffffc0204c34:	88060613          	addi	a2,a2,-1920 # ffffffffc02194b0 <timer_list>
ffffffffc0204c38:	00c78763          	beq	a5,a2,ffffffffc0204c46 <del_timer+0x38>
ffffffffc0204c3c:	ff07a603          	lw	a2,-16(a5)
ffffffffc0204c40:	9eb1                	addw	a3,a3,a2
ffffffffc0204c42:	fed7a823          	sw	a3,-16(a5)
ffffffffc0204c46:	e71c                	sd	a5,8(a4)
ffffffffc0204c48:	e398                	sd	a4,0(a5)
ffffffffc0204c4a:	ec04                	sd	s1,24(s0)
ffffffffc0204c4c:	e804                	sd	s1,16(s0)
ffffffffc0204c4e:	60e2                	ld	ra,24(sp)
ffffffffc0204c50:	6442                	ld	s0,16(sp)
ffffffffc0204c52:	64a2                	ld	s1,8(sp)
ffffffffc0204c54:	6105                	addi	sp,sp,32
ffffffffc0204c56:	8082                	ret
ffffffffc0204c58:	9e1fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204c5c:	6c1c                	ld	a5,24(s0)
ffffffffc0204c5e:	02978463          	beq	a5,s1,ffffffffc0204c86 <del_timer+0x78>
ffffffffc0204c62:	4014                	lw	a3,0(s0)
ffffffffc0204c64:	6818                	ld	a4,16(s0)
ffffffffc0204c66:	ce81                	beqz	a3,ffffffffc0204c7e <del_timer+0x70>
ffffffffc0204c68:	00015617          	auipc	a2,0x15
ffffffffc0204c6c:	84860613          	addi	a2,a2,-1976 # ffffffffc02194b0 <timer_list>
ffffffffc0204c70:	00c78763          	beq	a5,a2,ffffffffc0204c7e <del_timer+0x70>
ffffffffc0204c74:	ff07a603          	lw	a2,-16(a5)
ffffffffc0204c78:	9eb1                	addw	a3,a3,a2
ffffffffc0204c7a:	fed7a823          	sw	a3,-16(a5)
ffffffffc0204c7e:	e71c                	sd	a5,8(a4)
ffffffffc0204c80:	e398                	sd	a4,0(a5)
ffffffffc0204c82:	ec04                	sd	s1,24(s0)
ffffffffc0204c84:	e804                	sd	s1,16(s0)
ffffffffc0204c86:	6442                	ld	s0,16(sp)
ffffffffc0204c88:	60e2                	ld	ra,24(sp)
ffffffffc0204c8a:	64a2                	ld	s1,8(sp)
ffffffffc0204c8c:	6105                	addi	sp,sp,32
ffffffffc0204c8e:	9a5fb06f          	j	ffffffffc0200632 <intr_enable>

ffffffffc0204c92 <run_timer_list>:
ffffffffc0204c92:	7139                	addi	sp,sp,-64
ffffffffc0204c94:	fc06                	sd	ra,56(sp)
ffffffffc0204c96:	f822                	sd	s0,48(sp)
ffffffffc0204c98:	f426                	sd	s1,40(sp)
ffffffffc0204c9a:	f04a                	sd	s2,32(sp)
ffffffffc0204c9c:	ec4e                	sd	s3,24(sp)
ffffffffc0204c9e:	e852                	sd	s4,16(sp)
ffffffffc0204ca0:	e456                	sd	s5,8(sp)
ffffffffc0204ca2:	e05a                	sd	s6,0(sp)
ffffffffc0204ca4:	100027f3          	csrr	a5,sstatus
ffffffffc0204ca8:	8b89                	andi	a5,a5,2
ffffffffc0204caa:	4b01                	li	s6,0
ffffffffc0204cac:	eff9                	bnez	a5,ffffffffc0204d8a <run_timer_list+0xf8>
ffffffffc0204cae:	00015997          	auipc	s3,0x15
ffffffffc0204cb2:	80298993          	addi	s3,s3,-2046 # ffffffffc02194b0 <timer_list>
ffffffffc0204cb6:	0089b403          	ld	s0,8(s3)
ffffffffc0204cba:	07340a63          	beq	s0,s3,ffffffffc0204d2e <run_timer_list+0x9c>
ffffffffc0204cbe:	ff042783          	lw	a5,-16(s0)
ffffffffc0204cc2:	ff040913          	addi	s2,s0,-16
ffffffffc0204cc6:	0e078663          	beqz	a5,ffffffffc0204db2 <run_timer_list+0x120>
ffffffffc0204cca:	fff7871b          	addiw	a4,a5,-1
ffffffffc0204cce:	fee42823          	sw	a4,-16(s0)
ffffffffc0204cd2:	ef31                	bnez	a4,ffffffffc0204d2e <run_timer_list+0x9c>
ffffffffc0204cd4:	00005a97          	auipc	s5,0x5
ffffffffc0204cd8:	d7ca8a93          	addi	s5,s5,-644 # ffffffffc0209a50 <default_pmm_manager+0x728>
ffffffffc0204cdc:	00005a17          	auipc	s4,0x5
ffffffffc0204ce0:	ca4a0a13          	addi	s4,s4,-860 # ffffffffc0209980 <default_pmm_manager+0x658>
ffffffffc0204ce4:	a005                	j	ffffffffc0204d04 <run_timer_list+0x72>
ffffffffc0204ce6:	0a07d663          	bgez	a5,ffffffffc0204d92 <run_timer_list+0x100>
ffffffffc0204cea:	8526                	mv	a0,s1
ffffffffc0204cec:	ce3ff0ef          	jal	ra,ffffffffc02049ce <wakeup_proc>
ffffffffc0204cf0:	854a                	mv	a0,s2
ffffffffc0204cf2:	f1dff0ef          	jal	ra,ffffffffc0204c0e <del_timer>
ffffffffc0204cf6:	03340c63          	beq	s0,s3,ffffffffc0204d2e <run_timer_list+0x9c>
ffffffffc0204cfa:	ff042783          	lw	a5,-16(s0)
ffffffffc0204cfe:	ff040913          	addi	s2,s0,-16
ffffffffc0204d02:	e795                	bnez	a5,ffffffffc0204d2e <run_timer_list+0x9c>
ffffffffc0204d04:	00893483          	ld	s1,8(s2)
ffffffffc0204d08:	6400                	ld	s0,8(s0)
ffffffffc0204d0a:	0ec4a783          	lw	a5,236(s1)
ffffffffc0204d0e:	ffe1                	bnez	a5,ffffffffc0204ce6 <run_timer_list+0x54>
ffffffffc0204d10:	40d4                	lw	a3,4(s1)
ffffffffc0204d12:	8656                	mv	a2,s5
ffffffffc0204d14:	0a300593          	li	a1,163
ffffffffc0204d18:	8552                	mv	a0,s4
ffffffffc0204d1a:	d56fb0ef          	jal	ra,ffffffffc0200270 <__warn>
ffffffffc0204d1e:	8526                	mv	a0,s1
ffffffffc0204d20:	cafff0ef          	jal	ra,ffffffffc02049ce <wakeup_proc>
ffffffffc0204d24:	854a                	mv	a0,s2
ffffffffc0204d26:	ee9ff0ef          	jal	ra,ffffffffc0204c0e <del_timer>
ffffffffc0204d2a:	fd3418e3          	bne	s0,s3,ffffffffc0204cfa <run_timer_list+0x68>
ffffffffc0204d2e:	00014597          	auipc	a1,0x14
ffffffffc0204d32:	7ca5b583          	ld	a1,1994(a1) # ffffffffc02194f8 <current>
ffffffffc0204d36:	00014797          	auipc	a5,0x14
ffffffffc0204d3a:	7ca7b783          	ld	a5,1994(a5) # ffffffffc0219500 <idleproc>
ffffffffc0204d3e:	04f58363          	beq	a1,a5,ffffffffc0204d84 <run_timer_list+0xf2>
ffffffffc0204d42:	00014797          	auipc	a5,0x14
ffffffffc0204d46:	7de7b783          	ld	a5,2014(a5) # ffffffffc0219520 <sched_class>
ffffffffc0204d4a:	779c                	ld	a5,40(a5)
ffffffffc0204d4c:	00014517          	auipc	a0,0x14
ffffffffc0204d50:	7cc53503          	ld	a0,1996(a0) # ffffffffc0219518 <rq>
ffffffffc0204d54:	9782                	jalr	a5
ffffffffc0204d56:	000b1c63          	bnez	s6,ffffffffc0204d6e <run_timer_list+0xdc>
ffffffffc0204d5a:	70e2                	ld	ra,56(sp)
ffffffffc0204d5c:	7442                	ld	s0,48(sp)
ffffffffc0204d5e:	74a2                	ld	s1,40(sp)
ffffffffc0204d60:	7902                	ld	s2,32(sp)
ffffffffc0204d62:	69e2                	ld	s3,24(sp)
ffffffffc0204d64:	6a42                	ld	s4,16(sp)
ffffffffc0204d66:	6aa2                	ld	s5,8(sp)
ffffffffc0204d68:	6b02                	ld	s6,0(sp)
ffffffffc0204d6a:	6121                	addi	sp,sp,64
ffffffffc0204d6c:	8082                	ret
ffffffffc0204d6e:	7442                	ld	s0,48(sp)
ffffffffc0204d70:	70e2                	ld	ra,56(sp)
ffffffffc0204d72:	74a2                	ld	s1,40(sp)
ffffffffc0204d74:	7902                	ld	s2,32(sp)
ffffffffc0204d76:	69e2                	ld	s3,24(sp)
ffffffffc0204d78:	6a42                	ld	s4,16(sp)
ffffffffc0204d7a:	6aa2                	ld	s5,8(sp)
ffffffffc0204d7c:	6b02                	ld	s6,0(sp)
ffffffffc0204d7e:	6121                	addi	sp,sp,64
ffffffffc0204d80:	8b3fb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204d84:	4785                	li	a5,1
ffffffffc0204d86:	ed9c                	sd	a5,24(a1)
ffffffffc0204d88:	b7f9                	j	ffffffffc0204d56 <run_timer_list+0xc4>
ffffffffc0204d8a:	8affb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204d8e:	4b05                	li	s6,1
ffffffffc0204d90:	bf39                	j	ffffffffc0204cae <run_timer_list+0x1c>
ffffffffc0204d92:	00005697          	auipc	a3,0x5
ffffffffc0204d96:	c9668693          	addi	a3,a3,-874 # ffffffffc0209a28 <default_pmm_manager+0x700>
ffffffffc0204d9a:	00004617          	auipc	a2,0x4
ffffffffc0204d9e:	84e60613          	addi	a2,a2,-1970 # ffffffffc02085e8 <commands+0x410>
ffffffffc0204da2:	0a000593          	li	a1,160
ffffffffc0204da6:	00005517          	auipc	a0,0x5
ffffffffc0204daa:	bda50513          	addi	a0,a0,-1062 # ffffffffc0209980 <default_pmm_manager+0x658>
ffffffffc0204dae:	c5afb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204db2:	00005697          	auipc	a3,0x5
ffffffffc0204db6:	c5e68693          	addi	a3,a3,-930 # ffffffffc0209a10 <default_pmm_manager+0x6e8>
ffffffffc0204dba:	00004617          	auipc	a2,0x4
ffffffffc0204dbe:	82e60613          	addi	a2,a2,-2002 # ffffffffc02085e8 <commands+0x410>
ffffffffc0204dc2:	09a00593          	li	a1,154
ffffffffc0204dc6:	00005517          	auipc	a0,0x5
ffffffffc0204dca:	bba50513          	addi	a0,a0,-1094 # ffffffffc0209980 <default_pmm_manager+0x658>
ffffffffc0204dce:	c3afb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204dd2 <proc_stride_comp_f>:
ffffffffc0204dd2:	4d08                	lw	a0,24(a0)
ffffffffc0204dd4:	4d9c                	lw	a5,24(a1)
ffffffffc0204dd6:	9d1d                	subw	a0,a0,a5
ffffffffc0204dd8:	00a04763          	bgtz	a0,ffffffffc0204de6 <proc_stride_comp_f+0x14>
ffffffffc0204ddc:	00a03533          	snez	a0,a0
ffffffffc0204de0:	40a00533          	neg	a0,a0
ffffffffc0204de4:	8082                	ret
ffffffffc0204de6:	4505                	li	a0,1
ffffffffc0204de8:	8082                	ret

ffffffffc0204dea <stride_init>:
ffffffffc0204dea:	e508                	sd	a0,8(a0)
ffffffffc0204dec:	e108                	sd	a0,0(a0)
ffffffffc0204dee:	00053c23          	sd	zero,24(a0)
ffffffffc0204df2:	00052823          	sw	zero,16(a0)
ffffffffc0204df6:	8082                	ret

ffffffffc0204df8 <stride_pick_next>:
ffffffffc0204df8:	6d1c                	ld	a5,24(a0)
ffffffffc0204dfa:	cf89                	beqz	a5,ffffffffc0204e14 <stride_pick_next+0x1c>
ffffffffc0204dfc:	4fd0                	lw	a2,28(a5)
ffffffffc0204dfe:	4f98                	lw	a4,24(a5)
ffffffffc0204e00:	ed878513          	addi	a0,a5,-296
ffffffffc0204e04:	400006b7          	lui	a3,0x40000
ffffffffc0204e08:	c219                	beqz	a2,ffffffffc0204e0e <stride_pick_next+0x16>
ffffffffc0204e0a:	02c6d6bb          	divuw	a3,a3,a2
ffffffffc0204e0e:	9f35                	addw	a4,a4,a3
ffffffffc0204e10:	cf98                	sw	a4,24(a5)
ffffffffc0204e12:	8082                	ret
ffffffffc0204e14:	4501                	li	a0,0
ffffffffc0204e16:	8082                	ret

ffffffffc0204e18 <stride_proc_tick>:
ffffffffc0204e18:	1205a783          	lw	a5,288(a1)
ffffffffc0204e1c:	00f05563          	blez	a5,ffffffffc0204e26 <stride_proc_tick+0xe>
ffffffffc0204e20:	37fd                	addiw	a5,a5,-1
ffffffffc0204e22:	12f5a023          	sw	a5,288(a1)
ffffffffc0204e26:	e399                	bnez	a5,ffffffffc0204e2c <stride_proc_tick+0x14>
ffffffffc0204e28:	4785                	li	a5,1
ffffffffc0204e2a:	ed9c                	sd	a5,24(a1)
ffffffffc0204e2c:	8082                	ret

ffffffffc0204e2e <skew_heap_merge.constprop.0>:
ffffffffc0204e2e:	1101                	addi	sp,sp,-32
ffffffffc0204e30:	e822                	sd	s0,16(sp)
ffffffffc0204e32:	ec06                	sd	ra,24(sp)
ffffffffc0204e34:	e426                	sd	s1,8(sp)
ffffffffc0204e36:	e04a                	sd	s2,0(sp)
ffffffffc0204e38:	842e                	mv	s0,a1
ffffffffc0204e3a:	c11d                	beqz	a0,ffffffffc0204e60 <skew_heap_merge.constprop.0+0x32>
ffffffffc0204e3c:	84aa                	mv	s1,a0
ffffffffc0204e3e:	c1b9                	beqz	a1,ffffffffc0204e84 <skew_heap_merge.constprop.0+0x56>
ffffffffc0204e40:	f93ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0204e44:	57fd                	li	a5,-1
ffffffffc0204e46:	02f50463          	beq	a0,a5,ffffffffc0204e6e <skew_heap_merge.constprop.0+0x40>
ffffffffc0204e4a:	680c                	ld	a1,16(s0)
ffffffffc0204e4c:	00843903          	ld	s2,8(s0)
ffffffffc0204e50:	8526                	mv	a0,s1
ffffffffc0204e52:	fddff0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0204e56:	e408                	sd	a0,8(s0)
ffffffffc0204e58:	01243823          	sd	s2,16(s0)
ffffffffc0204e5c:	c111                	beqz	a0,ffffffffc0204e60 <skew_heap_merge.constprop.0+0x32>
ffffffffc0204e5e:	e100                	sd	s0,0(a0)
ffffffffc0204e60:	60e2                	ld	ra,24(sp)
ffffffffc0204e62:	8522                	mv	a0,s0
ffffffffc0204e64:	6442                	ld	s0,16(sp)
ffffffffc0204e66:	64a2                	ld	s1,8(sp)
ffffffffc0204e68:	6902                	ld	s2,0(sp)
ffffffffc0204e6a:	6105                	addi	sp,sp,32
ffffffffc0204e6c:	8082                	ret
ffffffffc0204e6e:	6888                	ld	a0,16(s1)
ffffffffc0204e70:	0084b903          	ld	s2,8(s1)
ffffffffc0204e74:	85a2                	mv	a1,s0
ffffffffc0204e76:	fb9ff0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0204e7a:	e488                	sd	a0,8(s1)
ffffffffc0204e7c:	0124b823          	sd	s2,16(s1)
ffffffffc0204e80:	c111                	beqz	a0,ffffffffc0204e84 <skew_heap_merge.constprop.0+0x56>
ffffffffc0204e82:	e104                	sd	s1,0(a0)
ffffffffc0204e84:	60e2                	ld	ra,24(sp)
ffffffffc0204e86:	6442                	ld	s0,16(sp)
ffffffffc0204e88:	6902                	ld	s2,0(sp)
ffffffffc0204e8a:	8526                	mv	a0,s1
ffffffffc0204e8c:	64a2                	ld	s1,8(sp)
ffffffffc0204e8e:	6105                	addi	sp,sp,32
ffffffffc0204e90:	8082                	ret

ffffffffc0204e92 <stride_enqueue>:
ffffffffc0204e92:	7119                	addi	sp,sp,-128
ffffffffc0204e94:	f4a6                	sd	s1,104(sp)
ffffffffc0204e96:	6d04                	ld	s1,24(a0)
ffffffffc0204e98:	f8a2                	sd	s0,112(sp)
ffffffffc0204e9a:	f0ca                	sd	s2,96(sp)
ffffffffc0204e9c:	e8d2                	sd	s4,80(sp)
ffffffffc0204e9e:	fc86                	sd	ra,120(sp)
ffffffffc0204ea0:	ecce                	sd	s3,88(sp)
ffffffffc0204ea2:	e4d6                	sd	s5,72(sp)
ffffffffc0204ea4:	e0da                	sd	s6,64(sp)
ffffffffc0204ea6:	fc5e                	sd	s7,56(sp)
ffffffffc0204ea8:	f862                	sd	s8,48(sp)
ffffffffc0204eaa:	f466                	sd	s9,40(sp)
ffffffffc0204eac:	f06a                	sd	s10,32(sp)
ffffffffc0204eae:	ec6e                	sd	s11,24(sp)
ffffffffc0204eb0:	1205b423          	sd	zero,296(a1)
ffffffffc0204eb4:	1205bc23          	sd	zero,312(a1)
ffffffffc0204eb8:	1205b823          	sd	zero,304(a1)
ffffffffc0204ebc:	8a2a                	mv	s4,a0
ffffffffc0204ebe:	842e                	mv	s0,a1
ffffffffc0204ec0:	12858913          	addi	s2,a1,296
ffffffffc0204ec4:	cc89                	beqz	s1,ffffffffc0204ede <stride_enqueue+0x4c>
ffffffffc0204ec6:	85ca                	mv	a1,s2
ffffffffc0204ec8:	8526                	mv	a0,s1
ffffffffc0204eca:	f09ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0204ece:	57fd                	li	a5,-1
ffffffffc0204ed0:	89aa                	mv	s3,a0
ffffffffc0204ed2:	04f50763          	beq	a0,a5,ffffffffc0204f20 <stride_enqueue+0x8e>
ffffffffc0204ed6:	12943823          	sd	s1,304(s0)
ffffffffc0204eda:	0124b023          	sd	s2,0(s1)
ffffffffc0204ede:	12042783          	lw	a5,288(s0)
ffffffffc0204ee2:	012a3c23          	sd	s2,24(s4)
ffffffffc0204ee6:	014a2703          	lw	a4,20(s4)
ffffffffc0204eea:	c399                	beqz	a5,ffffffffc0204ef0 <stride_enqueue+0x5e>
ffffffffc0204eec:	00f75463          	bge	a4,a5,ffffffffc0204ef4 <stride_enqueue+0x62>
ffffffffc0204ef0:	12e42023          	sw	a4,288(s0)
ffffffffc0204ef4:	010a2783          	lw	a5,16(s4)
ffffffffc0204ef8:	70e6                	ld	ra,120(sp)
ffffffffc0204efa:	11443423          	sd	s4,264(s0)
ffffffffc0204efe:	7446                	ld	s0,112(sp)
ffffffffc0204f00:	2785                	addiw	a5,a5,1
ffffffffc0204f02:	00fa2823          	sw	a5,16(s4)
ffffffffc0204f06:	74a6                	ld	s1,104(sp)
ffffffffc0204f08:	7906                	ld	s2,96(sp)
ffffffffc0204f0a:	69e6                	ld	s3,88(sp)
ffffffffc0204f0c:	6a46                	ld	s4,80(sp)
ffffffffc0204f0e:	6aa6                	ld	s5,72(sp)
ffffffffc0204f10:	6b06                	ld	s6,64(sp)
ffffffffc0204f12:	7be2                	ld	s7,56(sp)
ffffffffc0204f14:	7c42                	ld	s8,48(sp)
ffffffffc0204f16:	7ca2                	ld	s9,40(sp)
ffffffffc0204f18:	7d02                	ld	s10,32(sp)
ffffffffc0204f1a:	6de2                	ld	s11,24(sp)
ffffffffc0204f1c:	6109                	addi	sp,sp,128
ffffffffc0204f1e:	8082                	ret
ffffffffc0204f20:	0104ba83          	ld	s5,16(s1)
ffffffffc0204f24:	0084bb83          	ld	s7,8(s1)
ffffffffc0204f28:	000a8d63          	beqz	s5,ffffffffc0204f42 <stride_enqueue+0xb0>
ffffffffc0204f2c:	85ca                	mv	a1,s2
ffffffffc0204f2e:	8556                	mv	a0,s5
ffffffffc0204f30:	ea3ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0204f34:	8b2a                	mv	s6,a0
ffffffffc0204f36:	01350e63          	beq	a0,s3,ffffffffc0204f52 <stride_enqueue+0xc0>
ffffffffc0204f3a:	13543823          	sd	s5,304(s0)
ffffffffc0204f3e:	012ab023          	sd	s2,0(s5)
ffffffffc0204f42:	0124b423          	sd	s2,8(s1)
ffffffffc0204f46:	0174b823          	sd	s7,16(s1)
ffffffffc0204f4a:	00993023          	sd	s1,0(s2)
ffffffffc0204f4e:	8926                	mv	s2,s1
ffffffffc0204f50:	b779                	j	ffffffffc0204ede <stride_enqueue+0x4c>
ffffffffc0204f52:	010ab983          	ld	s3,16(s5)
ffffffffc0204f56:	008abc83          	ld	s9,8(s5)
ffffffffc0204f5a:	00098d63          	beqz	s3,ffffffffc0204f74 <stride_enqueue+0xe2>
ffffffffc0204f5e:	85ca                	mv	a1,s2
ffffffffc0204f60:	854e                	mv	a0,s3
ffffffffc0204f62:	e71ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0204f66:	8c2a                	mv	s8,a0
ffffffffc0204f68:	01650e63          	beq	a0,s6,ffffffffc0204f84 <stride_enqueue+0xf2>
ffffffffc0204f6c:	13343823          	sd	s3,304(s0)
ffffffffc0204f70:	0129b023          	sd	s2,0(s3)
ffffffffc0204f74:	012ab423          	sd	s2,8(s5)
ffffffffc0204f78:	019ab823          	sd	s9,16(s5)
ffffffffc0204f7c:	01593023          	sd	s5,0(s2)
ffffffffc0204f80:	8956                	mv	s2,s5
ffffffffc0204f82:	b7c1                	j	ffffffffc0204f42 <stride_enqueue+0xb0>
ffffffffc0204f84:	0109bb03          	ld	s6,16(s3)
ffffffffc0204f88:	0089bd83          	ld	s11,8(s3)
ffffffffc0204f8c:	000b0d63          	beqz	s6,ffffffffc0204fa6 <stride_enqueue+0x114>
ffffffffc0204f90:	85ca                	mv	a1,s2
ffffffffc0204f92:	855a                	mv	a0,s6
ffffffffc0204f94:	e3fff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0204f98:	8d2a                	mv	s10,a0
ffffffffc0204f9a:	01850e63          	beq	a0,s8,ffffffffc0204fb6 <stride_enqueue+0x124>
ffffffffc0204f9e:	13643823          	sd	s6,304(s0)
ffffffffc0204fa2:	012b3023          	sd	s2,0(s6)
ffffffffc0204fa6:	0129b423          	sd	s2,8(s3)
ffffffffc0204faa:	01b9b823          	sd	s11,16(s3)
ffffffffc0204fae:	01393023          	sd	s3,0(s2)
ffffffffc0204fb2:	894e                	mv	s2,s3
ffffffffc0204fb4:	b7c1                	j	ffffffffc0204f74 <stride_enqueue+0xe2>
ffffffffc0204fb6:	008b3783          	ld	a5,8(s6)
ffffffffc0204fba:	010b3c03          	ld	s8,16(s6)
ffffffffc0204fbe:	e43e                	sd	a5,8(sp)
ffffffffc0204fc0:	000c0c63          	beqz	s8,ffffffffc0204fd8 <stride_enqueue+0x146>
ffffffffc0204fc4:	85ca                	mv	a1,s2
ffffffffc0204fc6:	8562                	mv	a0,s8
ffffffffc0204fc8:	e0bff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0204fcc:	01a50f63          	beq	a0,s10,ffffffffc0204fea <stride_enqueue+0x158>
ffffffffc0204fd0:	13843823          	sd	s8,304(s0)
ffffffffc0204fd4:	012c3023          	sd	s2,0(s8)
ffffffffc0204fd8:	67a2                	ld	a5,8(sp)
ffffffffc0204fda:	012b3423          	sd	s2,8(s6)
ffffffffc0204fde:	00fb3823          	sd	a5,16(s6)
ffffffffc0204fe2:	01693023          	sd	s6,0(s2)
ffffffffc0204fe6:	895a                	mv	s2,s6
ffffffffc0204fe8:	bf7d                	j	ffffffffc0204fa6 <stride_enqueue+0x114>
ffffffffc0204fea:	010c3503          	ld	a0,16(s8)
ffffffffc0204fee:	008c3d03          	ld	s10,8(s8)
ffffffffc0204ff2:	85ca                	mv	a1,s2
ffffffffc0204ff4:	e3bff0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0204ff8:	00ac3423          	sd	a0,8(s8)
ffffffffc0204ffc:	01ac3823          	sd	s10,16(s8)
ffffffffc0205000:	c509                	beqz	a0,ffffffffc020500a <stride_enqueue+0x178>
ffffffffc0205002:	01853023          	sd	s8,0(a0)
ffffffffc0205006:	8962                	mv	s2,s8
ffffffffc0205008:	bfc1                	j	ffffffffc0204fd8 <stride_enqueue+0x146>
ffffffffc020500a:	8962                	mv	s2,s8
ffffffffc020500c:	b7f1                	j	ffffffffc0204fd8 <stride_enqueue+0x146>

ffffffffc020500e <stride_dequeue>:
ffffffffc020500e:	1085b783          	ld	a5,264(a1)
ffffffffc0205012:	7171                	addi	sp,sp,-176
ffffffffc0205014:	f506                	sd	ra,168(sp)
ffffffffc0205016:	f122                	sd	s0,160(sp)
ffffffffc0205018:	ed26                	sd	s1,152(sp)
ffffffffc020501a:	e94a                	sd	s2,144(sp)
ffffffffc020501c:	e54e                	sd	s3,136(sp)
ffffffffc020501e:	e152                	sd	s4,128(sp)
ffffffffc0205020:	fcd6                	sd	s5,120(sp)
ffffffffc0205022:	f8da                	sd	s6,112(sp)
ffffffffc0205024:	f4de                	sd	s7,104(sp)
ffffffffc0205026:	f0e2                	sd	s8,96(sp)
ffffffffc0205028:	ece6                	sd	s9,88(sp)
ffffffffc020502a:	e8ea                	sd	s10,80(sp)
ffffffffc020502c:	e4ee                	sd	s11,72(sp)
ffffffffc020502e:	00a78463          	beq	a5,a0,ffffffffc0205036 <stride_dequeue+0x28>
ffffffffc0205032:	7870106f          	j	ffffffffc0206fb8 <stride_dequeue+0x1faa>
ffffffffc0205036:	01052983          	lw	s3,16(a0)
ffffffffc020503a:	8c2a                	mv	s8,a0
ffffffffc020503c:	8b4e                	mv	s6,s3
ffffffffc020503e:	00099463          	bnez	s3,ffffffffc0205046 <stride_dequeue+0x38>
ffffffffc0205042:	7770106f          	j	ffffffffc0206fb8 <stride_dequeue+0x1faa>
ffffffffc0205046:	1305b903          	ld	s2,304(a1)
ffffffffc020504a:	01853a83          	ld	s5,24(a0)
ffffffffc020504e:	1285bd03          	ld	s10,296(a1)
ffffffffc0205052:	1385b483          	ld	s1,312(a1)
ffffffffc0205056:	842e                	mv	s0,a1
ffffffffc0205058:	2e090263          	beqz	s2,ffffffffc020533c <stride_dequeue+0x32e>
ffffffffc020505c:	42048263          	beqz	s1,ffffffffc0205480 <stride_dequeue+0x472>
ffffffffc0205060:	85a6                	mv	a1,s1
ffffffffc0205062:	854a                	mv	a0,s2
ffffffffc0205064:	d6fff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205068:	5cfd                	li	s9,-1
ffffffffc020506a:	8a2a                	mv	s4,a0
ffffffffc020506c:	19950163          	beq	a0,s9,ffffffffc02051ee <stride_dequeue+0x1e0>
ffffffffc0205070:	0104ba03          	ld	s4,16(s1)
ffffffffc0205074:	0084bb83          	ld	s7,8(s1)
ffffffffc0205078:	120a0563          	beqz	s4,ffffffffc02051a2 <stride_dequeue+0x194>
ffffffffc020507c:	85d2                	mv	a1,s4
ffffffffc020507e:	854a                	mv	a0,s2
ffffffffc0205080:	d53ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205084:	2d950563          	beq	a0,s9,ffffffffc020534e <stride_dequeue+0x340>
ffffffffc0205088:	008a3783          	ld	a5,8(s4)
ffffffffc020508c:	010a3d83          	ld	s11,16(s4)
ffffffffc0205090:	e03e                	sd	a5,0(sp)
ffffffffc0205092:	100d8063          	beqz	s11,ffffffffc0205192 <stride_dequeue+0x184>
ffffffffc0205096:	85ee                	mv	a1,s11
ffffffffc0205098:	854a                	mv	a0,s2
ffffffffc020509a:	d39ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc020509e:	7f950563          	beq	a0,s9,ffffffffc0205888 <stride_dequeue+0x87a>
ffffffffc02050a2:	008db783          	ld	a5,8(s11)
ffffffffc02050a6:	010dbc83          	ld	s9,16(s11)
ffffffffc02050aa:	e43e                	sd	a5,8(sp)
ffffffffc02050ac:	0c0c8b63          	beqz	s9,ffffffffc0205182 <stride_dequeue+0x174>
ffffffffc02050b0:	85e6                	mv	a1,s9
ffffffffc02050b2:	854a                	mv	a0,s2
ffffffffc02050b4:	d1fff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02050b8:	58fd                	li	a7,-1
ffffffffc02050ba:	71150063          	beq	a0,a7,ffffffffc02057ba <stride_dequeue+0x7ac>
ffffffffc02050be:	008cb783          	ld	a5,8(s9)
ffffffffc02050c2:	010cb803          	ld	a6,16(s9)
ffffffffc02050c6:	e83e                	sd	a5,16(sp)
ffffffffc02050c8:	0a080563          	beqz	a6,ffffffffc0205172 <stride_dequeue+0x164>
ffffffffc02050cc:	85c2                	mv	a1,a6
ffffffffc02050ce:	854a                	mv	a0,s2
ffffffffc02050d0:	ec42                	sd	a6,24(sp)
ffffffffc02050d2:	d01ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02050d6:	58fd                	li	a7,-1
ffffffffc02050d8:	6862                	ld	a6,24(sp)
ffffffffc02050da:	41150be3          	beq	a0,a7,ffffffffc0205cf0 <stride_dequeue+0xce2>
ffffffffc02050de:	00883703          	ld	a4,8(a6) # fffffffffff80008 <end+0x3fd668c0>
ffffffffc02050e2:	01083783          	ld	a5,16(a6)
ffffffffc02050e6:	ec3a                	sd	a4,24(sp)
ffffffffc02050e8:	cfad                	beqz	a5,ffffffffc0205162 <stride_dequeue+0x154>
ffffffffc02050ea:	85be                	mv	a1,a5
ffffffffc02050ec:	854a                	mv	a0,s2
ffffffffc02050ee:	f442                	sd	a6,40(sp)
ffffffffc02050f0:	f03e                	sd	a5,32(sp)
ffffffffc02050f2:	ce1ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02050f6:	58fd                	li	a7,-1
ffffffffc02050f8:	7782                	ld	a5,32(sp)
ffffffffc02050fa:	7822                	ld	a6,40(sp)
ffffffffc02050fc:	01151463          	bne	a0,a7,ffffffffc0205104 <stride_dequeue+0xf6>
ffffffffc0205100:	17a0106f          	j	ffffffffc020627a <stride_dequeue+0x126c>
ffffffffc0205104:	6798                	ld	a4,8(a5)
ffffffffc0205106:	0107bb03          	ld	s6,16(a5)
ffffffffc020510a:	f03a                	sd	a4,32(sp)
ffffffffc020510c:	040b0463          	beqz	s6,ffffffffc0205154 <stride_dequeue+0x146>
ffffffffc0205110:	85da                	mv	a1,s6
ffffffffc0205112:	854a                	mv	a0,s2
ffffffffc0205114:	f83e                	sd	a5,48(sp)
ffffffffc0205116:	f442                	sd	a6,40(sp)
ffffffffc0205118:	cbbff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc020511c:	58fd                	li	a7,-1
ffffffffc020511e:	7822                	ld	a6,40(sp)
ffffffffc0205120:	77c2                	ld	a5,48(sp)
ffffffffc0205122:	01151463          	bne	a0,a7,ffffffffc020512a <stride_dequeue+0x11c>
ffffffffc0205126:	00d0106f          	j	ffffffffc0206932 <stride_dequeue+0x1924>
ffffffffc020512a:	010b3583          	ld	a1,16(s6)
ffffffffc020512e:	008b3983          	ld	s3,8(s6)
ffffffffc0205132:	854a                	mv	a0,s2
ffffffffc0205134:	f83e                	sd	a5,48(sp)
ffffffffc0205136:	f442                	sd	a6,40(sp)
ffffffffc0205138:	cf7ff0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc020513c:	00ab3423          	sd	a0,8(s6)
ffffffffc0205140:	013b3823          	sd	s3,16(s6)
ffffffffc0205144:	7822                	ld	a6,40(sp)
ffffffffc0205146:	77c2                	ld	a5,48(sp)
ffffffffc0205148:	010c2983          	lw	s3,16(s8)
ffffffffc020514c:	c119                	beqz	a0,ffffffffc0205152 <stride_dequeue+0x144>
ffffffffc020514e:	01653023          	sd	s6,0(a0)
ffffffffc0205152:	895a                	mv	s2,s6
ffffffffc0205154:	7702                	ld	a4,32(sp)
ffffffffc0205156:	0127b423          	sd	s2,8(a5)
ffffffffc020515a:	eb98                	sd	a4,16(a5)
ffffffffc020515c:	00f93023          	sd	a5,0(s2)
ffffffffc0205160:	893e                	mv	s2,a5
ffffffffc0205162:	67e2                	ld	a5,24(sp)
ffffffffc0205164:	01283423          	sd	s2,8(a6)
ffffffffc0205168:	00f83823          	sd	a5,16(a6)
ffffffffc020516c:	01093023          	sd	a6,0(s2)
ffffffffc0205170:	8942                	mv	s2,a6
ffffffffc0205172:	67c2                	ld	a5,16(sp)
ffffffffc0205174:	012cb423          	sd	s2,8(s9)
ffffffffc0205178:	00fcb823          	sd	a5,16(s9)
ffffffffc020517c:	01993023          	sd	s9,0(s2)
ffffffffc0205180:	8966                	mv	s2,s9
ffffffffc0205182:	67a2                	ld	a5,8(sp)
ffffffffc0205184:	012db423          	sd	s2,8(s11)
ffffffffc0205188:	00fdb823          	sd	a5,16(s11)
ffffffffc020518c:	01b93023          	sd	s11,0(s2)
ffffffffc0205190:	896e                	mv	s2,s11
ffffffffc0205192:	6782                	ld	a5,0(sp)
ffffffffc0205194:	012a3423          	sd	s2,8(s4)
ffffffffc0205198:	00fa3823          	sd	a5,16(s4)
ffffffffc020519c:	01493023          	sd	s4,0(s2)
ffffffffc02051a0:	8952                	mv	s2,s4
ffffffffc02051a2:	0124b423          	sd	s2,8(s1)
ffffffffc02051a6:	0174b823          	sd	s7,16(s1)
ffffffffc02051aa:	00993023          	sd	s1,0(s2)
ffffffffc02051ae:	01a4b023          	sd	s10,0(s1)
ffffffffc02051b2:	180d0963          	beqz	s10,ffffffffc0205344 <stride_dequeue+0x336>
ffffffffc02051b6:	008d3683          	ld	a3,8(s10)
ffffffffc02051ba:	12840413          	addi	s0,s0,296
ffffffffc02051be:	18868563          	beq	a3,s0,ffffffffc0205348 <stride_dequeue+0x33a>
ffffffffc02051c2:	009d3823          	sd	s1,16(s10)
ffffffffc02051c6:	70aa                	ld	ra,168(sp)
ffffffffc02051c8:	740a                	ld	s0,160(sp)
ffffffffc02051ca:	39fd                	addiw	s3,s3,-1
ffffffffc02051cc:	015c3c23          	sd	s5,24(s8)
ffffffffc02051d0:	013c2823          	sw	s3,16(s8)
ffffffffc02051d4:	64ea                	ld	s1,152(sp)
ffffffffc02051d6:	694a                	ld	s2,144(sp)
ffffffffc02051d8:	69aa                	ld	s3,136(sp)
ffffffffc02051da:	6a0a                	ld	s4,128(sp)
ffffffffc02051dc:	7ae6                	ld	s5,120(sp)
ffffffffc02051de:	7b46                	ld	s6,112(sp)
ffffffffc02051e0:	7ba6                	ld	s7,104(sp)
ffffffffc02051e2:	7c06                	ld	s8,96(sp)
ffffffffc02051e4:	6ce6                	ld	s9,88(sp)
ffffffffc02051e6:	6d46                	ld	s10,80(sp)
ffffffffc02051e8:	6da6                	ld	s11,72(sp)
ffffffffc02051ea:	614d                	addi	sp,sp,176
ffffffffc02051ec:	8082                	ret
ffffffffc02051ee:	01093d83          	ld	s11,16(s2)
ffffffffc02051f2:	00893b83          	ld	s7,8(s2)
ffffffffc02051f6:	120d8963          	beqz	s11,ffffffffc0205328 <stride_dequeue+0x31a>
ffffffffc02051fa:	85a6                	mv	a1,s1
ffffffffc02051fc:	856e                	mv	a0,s11
ffffffffc02051fe:	bd5ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205202:	29450363          	beq	a0,s4,ffffffffc0205488 <stride_dequeue+0x47a>
ffffffffc0205206:	649c                	ld	a5,8(s1)
ffffffffc0205208:	0104bc83          	ld	s9,16(s1)
ffffffffc020520c:	e03e                	sd	a5,0(sp)
ffffffffc020520e:	100c8763          	beqz	s9,ffffffffc020531c <stride_dequeue+0x30e>
ffffffffc0205212:	85e6                	mv	a1,s9
ffffffffc0205214:	856e                	mv	a0,s11
ffffffffc0205216:	bbdff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc020521a:	4b450263          	beq	a0,s4,ffffffffc02056be <stride_dequeue+0x6b0>
ffffffffc020521e:	008cb783          	ld	a5,8(s9)
ffffffffc0205222:	010cba03          	ld	s4,16(s9)
ffffffffc0205226:	e43e                	sd	a5,8(sp)
ffffffffc0205228:	0e0a0263          	beqz	s4,ffffffffc020530c <stride_dequeue+0x2fe>
ffffffffc020522c:	85d2                	mv	a1,s4
ffffffffc020522e:	856e                	mv	a0,s11
ffffffffc0205230:	ba3ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205234:	58fd                	li	a7,-1
ffffffffc0205236:	03150fe3          	beq	a0,a7,ffffffffc0205a74 <stride_dequeue+0xa66>
ffffffffc020523a:	008a3783          	ld	a5,8(s4)
ffffffffc020523e:	010a3803          	ld	a6,16(s4)
ffffffffc0205242:	e83e                	sd	a5,16(sp)
ffffffffc0205244:	0a080c63          	beqz	a6,ffffffffc02052fc <stride_dequeue+0x2ee>
ffffffffc0205248:	85c2                	mv	a1,a6
ffffffffc020524a:	856e                	mv	a0,s11
ffffffffc020524c:	ec42                	sd	a6,24(sp)
ffffffffc020524e:	b85ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205252:	58fd                	li	a7,-1
ffffffffc0205254:	6862                	ld	a6,24(sp)
ffffffffc0205256:	01151463          	bne	a0,a7,ffffffffc020525e <stride_dequeue+0x250>
ffffffffc020525a:	6e10006f          	j	ffffffffc020613a <stride_dequeue+0x112c>
ffffffffc020525e:	00883783          	ld	a5,8(a6)
ffffffffc0205262:	01083303          	ld	t1,16(a6)
ffffffffc0205266:	ec3e                	sd	a5,24(sp)
ffffffffc0205268:	08030263          	beqz	t1,ffffffffc02052ec <stride_dequeue+0x2de>
ffffffffc020526c:	859a                	mv	a1,t1
ffffffffc020526e:	856e                	mv	a0,s11
ffffffffc0205270:	f442                	sd	a6,40(sp)
ffffffffc0205272:	f01a                	sd	t1,32(sp)
ffffffffc0205274:	b5fff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205278:	58fd                	li	a7,-1
ffffffffc020527a:	7302                	ld	t1,32(sp)
ffffffffc020527c:	7822                	ld	a6,40(sp)
ffffffffc020527e:	01151463          	bne	a0,a7,ffffffffc0205286 <stride_dequeue+0x278>
ffffffffc0205282:	5ee0106f          	j	ffffffffc0206870 <stride_dequeue+0x1862>
ffffffffc0205286:	00833783          	ld	a5,8(t1)
ffffffffc020528a:	01033983          	ld	s3,16(t1)
ffffffffc020528e:	f03e                	sd	a5,32(sp)
ffffffffc0205290:	00099463          	bnez	s3,ffffffffc0205298 <stride_dequeue+0x28a>
ffffffffc0205294:	26f0106f          	j	ffffffffc0206d02 <stride_dequeue+0x1cf4>
ffffffffc0205298:	85ce                	mv	a1,s3
ffffffffc020529a:	856e                	mv	a0,s11
ffffffffc020529c:	f842                	sd	a6,48(sp)
ffffffffc020529e:	f41a                	sd	t1,40(sp)
ffffffffc02052a0:	b33ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02052a4:	58fd                	li	a7,-1
ffffffffc02052a6:	7322                	ld	t1,40(sp)
ffffffffc02052a8:	7842                	ld	a6,48(sp)
ffffffffc02052aa:	01151463          	bne	a0,a7,ffffffffc02052b2 <stride_dequeue+0x2a4>
ffffffffc02052ae:	4d30106f          	j	ffffffffc0206f80 <stride_dequeue+0x1f72>
ffffffffc02052b2:	0109b583          	ld	a1,16(s3)
ffffffffc02052b6:	0089bb03          	ld	s6,8(s3)
ffffffffc02052ba:	856e                	mv	a0,s11
ffffffffc02052bc:	f842                	sd	a6,48(sp)
ffffffffc02052be:	f41a                	sd	t1,40(sp)
ffffffffc02052c0:	b6fff0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02052c4:	00a9b423          	sd	a0,8(s3)
ffffffffc02052c8:	0169b823          	sd	s6,16(s3)
ffffffffc02052cc:	7322                	ld	t1,40(sp)
ffffffffc02052ce:	7842                	ld	a6,48(sp)
ffffffffc02052d0:	010c2b03          	lw	s6,16(s8)
ffffffffc02052d4:	c119                	beqz	a0,ffffffffc02052da <stride_dequeue+0x2cc>
ffffffffc02052d6:	01353023          	sd	s3,0(a0)
ffffffffc02052da:	7782                	ld	a5,32(sp)
ffffffffc02052dc:	01333423          	sd	s3,8(t1)
ffffffffc02052e0:	8d9a                	mv	s11,t1
ffffffffc02052e2:	00f33823          	sd	a5,16(t1)
ffffffffc02052e6:	0069b023          	sd	t1,0(s3)
ffffffffc02052ea:	89da                	mv	s3,s6
ffffffffc02052ec:	67e2                	ld	a5,24(sp)
ffffffffc02052ee:	01b83423          	sd	s11,8(a6)
ffffffffc02052f2:	00f83823          	sd	a5,16(a6)
ffffffffc02052f6:	010db023          	sd	a6,0(s11)
ffffffffc02052fa:	8dc2                	mv	s11,a6
ffffffffc02052fc:	67c2                	ld	a5,16(sp)
ffffffffc02052fe:	01ba3423          	sd	s11,8(s4)
ffffffffc0205302:	00fa3823          	sd	a5,16(s4)
ffffffffc0205306:	014db023          	sd	s4,0(s11)
ffffffffc020530a:	8dd2                	mv	s11,s4
ffffffffc020530c:	67a2                	ld	a5,8(sp)
ffffffffc020530e:	01bcb423          	sd	s11,8(s9)
ffffffffc0205312:	00fcb823          	sd	a5,16(s9)
ffffffffc0205316:	019db023          	sd	s9,0(s11)
ffffffffc020531a:	8de6                	mv	s11,s9
ffffffffc020531c:	6782                	ld	a5,0(sp)
ffffffffc020531e:	01b4b423          	sd	s11,8(s1)
ffffffffc0205322:	e89c                	sd	a5,16(s1)
ffffffffc0205324:	009db023          	sd	s1,0(s11)
ffffffffc0205328:	00993423          	sd	s1,8(s2)
ffffffffc020532c:	01793823          	sd	s7,16(s2)
ffffffffc0205330:	0124b023          	sd	s2,0(s1)
ffffffffc0205334:	84ca                	mv	s1,s2
ffffffffc0205336:	01a4b023          	sd	s10,0(s1)
ffffffffc020533a:	bda5                	j	ffffffffc02051b2 <stride_dequeue+0x1a4>
ffffffffc020533c:	e60499e3          	bnez	s1,ffffffffc02051ae <stride_dequeue+0x1a0>
ffffffffc0205340:	e60d1be3          	bnez	s10,ffffffffc02051b6 <stride_dequeue+0x1a8>
ffffffffc0205344:	8aa6                	mv	s5,s1
ffffffffc0205346:	b541                	j	ffffffffc02051c6 <stride_dequeue+0x1b8>
ffffffffc0205348:	009d3423          	sd	s1,8(s10)
ffffffffc020534c:	bdad                	j	ffffffffc02051c6 <stride_dequeue+0x1b8>
ffffffffc020534e:	01093d83          	ld	s11,16(s2)
ffffffffc0205352:	e02a                	sd	a0,0(sp)
ffffffffc0205354:	00893c83          	ld	s9,8(s2)
ffffffffc0205358:	100d8d63          	beqz	s11,ffffffffc0205472 <stride_dequeue+0x464>
ffffffffc020535c:	85d2                	mv	a1,s4
ffffffffc020535e:	856e                	mv	a0,s11
ffffffffc0205360:	a73ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205364:	6782                	ld	a5,0(sp)
ffffffffc0205366:	24f50563          	beq	a0,a5,ffffffffc02055b0 <stride_dequeue+0x5a2>
ffffffffc020536a:	008a3783          	ld	a5,8(s4)
ffffffffc020536e:	010a3603          	ld	a2,16(s4)
ffffffffc0205372:	e03e                	sd	a5,0(sp)
ffffffffc0205374:	0e060863          	beqz	a2,ffffffffc0205464 <stride_dequeue+0x456>
ffffffffc0205378:	85b2                	mv	a1,a2
ffffffffc020537a:	856e                	mv	a0,s11
ffffffffc020537c:	e432                	sd	a2,8(sp)
ffffffffc020537e:	a55ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205382:	58fd                	li	a7,-1
ffffffffc0205384:	6622                	ld	a2,8(sp)
ffffffffc0205386:	7b150f63          	beq	a0,a7,ffffffffc0205b44 <stride_dequeue+0xb36>
ffffffffc020538a:	661c                	ld	a5,8(a2)
ffffffffc020538c:	01063803          	ld	a6,16(a2)
ffffffffc0205390:	e43e                	sd	a5,8(sp)
ffffffffc0205392:	0c080263          	beqz	a6,ffffffffc0205456 <stride_dequeue+0x448>
ffffffffc0205396:	85c2                	mv	a1,a6
ffffffffc0205398:	856e                	mv	a0,s11
ffffffffc020539a:	ec32                	sd	a2,24(sp)
ffffffffc020539c:	e842                	sd	a6,16(sp)
ffffffffc020539e:	a35ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02053a2:	58fd                	li	a7,-1
ffffffffc02053a4:	6842                	ld	a6,16(sp)
ffffffffc02053a6:	6662                	ld	a2,24(sp)
ffffffffc02053a8:	631507e3          	beq	a0,a7,ffffffffc02061d6 <stride_dequeue+0x11c8>
ffffffffc02053ac:	00883783          	ld	a5,8(a6)
ffffffffc02053b0:	01083303          	ld	t1,16(a6)
ffffffffc02053b4:	e83e                	sd	a5,16(sp)
ffffffffc02053b6:	08030863          	beqz	t1,ffffffffc0205446 <stride_dequeue+0x438>
ffffffffc02053ba:	859a                	mv	a1,t1
ffffffffc02053bc:	856e                	mv	a0,s11
ffffffffc02053be:	f442                	sd	a6,40(sp)
ffffffffc02053c0:	f032                	sd	a2,32(sp)
ffffffffc02053c2:	ec1a                	sd	t1,24(sp)
ffffffffc02053c4:	a0fff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02053c8:	58fd                	li	a7,-1
ffffffffc02053ca:	6362                	ld	t1,24(sp)
ffffffffc02053cc:	7602                	ld	a2,32(sp)
ffffffffc02053ce:	7822                	ld	a6,40(sp)
ffffffffc02053d0:	01151463          	bne	a0,a7,ffffffffc02053d8 <stride_dequeue+0x3ca>
ffffffffc02053d4:	3d00106f          	j	ffffffffc02067a4 <stride_dequeue+0x1796>
ffffffffc02053d8:	00833783          	ld	a5,8(t1)
ffffffffc02053dc:	01033983          	ld	s3,16(t1)
ffffffffc02053e0:	ec3e                	sd	a5,24(sp)
ffffffffc02053e2:	00099463          	bnez	s3,ffffffffc02053ea <stride_dequeue+0x3dc>
ffffffffc02053e6:	2af0106f          	j	ffffffffc0206e94 <stride_dequeue+0x1e86>
ffffffffc02053ea:	85ce                	mv	a1,s3
ffffffffc02053ec:	856e                	mv	a0,s11
ffffffffc02053ee:	f81a                	sd	t1,48(sp)
ffffffffc02053f0:	f442                	sd	a6,40(sp)
ffffffffc02053f2:	f032                	sd	a2,32(sp)
ffffffffc02053f4:	9dfff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02053f8:	58fd                	li	a7,-1
ffffffffc02053fa:	7602                	ld	a2,32(sp)
ffffffffc02053fc:	7822                	ld	a6,40(sp)
ffffffffc02053fe:	7342                	ld	t1,48(sp)
ffffffffc0205400:	01151463          	bne	a0,a7,ffffffffc0205408 <stride_dequeue+0x3fa>
ffffffffc0205404:	3510106f          	j	ffffffffc0206f54 <stride_dequeue+0x1f46>
ffffffffc0205408:	0109b583          	ld	a1,16(s3)
ffffffffc020540c:	0089bb03          	ld	s6,8(s3)
ffffffffc0205410:	856e                	mv	a0,s11
ffffffffc0205412:	f81a                	sd	t1,48(sp)
ffffffffc0205414:	f442                	sd	a6,40(sp)
ffffffffc0205416:	f032                	sd	a2,32(sp)
ffffffffc0205418:	a17ff0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc020541c:	00a9b423          	sd	a0,8(s3)
ffffffffc0205420:	0169b823          	sd	s6,16(s3)
ffffffffc0205424:	7602                	ld	a2,32(sp)
ffffffffc0205426:	7822                	ld	a6,40(sp)
ffffffffc0205428:	7342                	ld	t1,48(sp)
ffffffffc020542a:	010c2b03          	lw	s6,16(s8)
ffffffffc020542e:	c119                	beqz	a0,ffffffffc0205434 <stride_dequeue+0x426>
ffffffffc0205430:	01353023          	sd	s3,0(a0)
ffffffffc0205434:	67e2                	ld	a5,24(sp)
ffffffffc0205436:	01333423          	sd	s3,8(t1)
ffffffffc020543a:	8d9a                	mv	s11,t1
ffffffffc020543c:	00f33823          	sd	a5,16(t1)
ffffffffc0205440:	0069b023          	sd	t1,0(s3)
ffffffffc0205444:	89da                	mv	s3,s6
ffffffffc0205446:	67c2                	ld	a5,16(sp)
ffffffffc0205448:	01b83423          	sd	s11,8(a6)
ffffffffc020544c:	00f83823          	sd	a5,16(a6)
ffffffffc0205450:	010db023          	sd	a6,0(s11)
ffffffffc0205454:	8dc2                	mv	s11,a6
ffffffffc0205456:	67a2                	ld	a5,8(sp)
ffffffffc0205458:	01b63423          	sd	s11,8(a2)
ffffffffc020545c:	ea1c                	sd	a5,16(a2)
ffffffffc020545e:	00cdb023          	sd	a2,0(s11)
ffffffffc0205462:	8db2                	mv	s11,a2
ffffffffc0205464:	6782                	ld	a5,0(sp)
ffffffffc0205466:	01ba3423          	sd	s11,8(s4)
ffffffffc020546a:	00fa3823          	sd	a5,16(s4)
ffffffffc020546e:	014db023          	sd	s4,0(s11)
ffffffffc0205472:	01493423          	sd	s4,8(s2)
ffffffffc0205476:	01993823          	sd	s9,16(s2)
ffffffffc020547a:	012a3023          	sd	s2,0(s4)
ffffffffc020547e:	b315                	j	ffffffffc02051a2 <stride_dequeue+0x194>
ffffffffc0205480:	84ca                	mv	s1,s2
ffffffffc0205482:	01a4b023          	sd	s10,0(s1)
ffffffffc0205486:	b335                	j	ffffffffc02051b2 <stride_dequeue+0x1a4>
ffffffffc0205488:	008db783          	ld	a5,8(s11)
ffffffffc020548c:	010dbc83          	ld	s9,16(s11)
ffffffffc0205490:	e42a                	sd	a0,8(sp)
ffffffffc0205492:	e03e                	sd	a5,0(sp)
ffffffffc0205494:	100c8563          	beqz	s9,ffffffffc020559e <stride_dequeue+0x590>
ffffffffc0205498:	85a6                	mv	a1,s1
ffffffffc020549a:	8566                	mv	a0,s9
ffffffffc020549c:	937ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02054a0:	67a2                	ld	a5,8(sp)
ffffffffc02054a2:	4cf50e63          	beq	a0,a5,ffffffffc020597e <stride_dequeue+0x970>
ffffffffc02054a6:	649c                	ld	a5,8(s1)
ffffffffc02054a8:	0104ba03          	ld	s4,16(s1)
ffffffffc02054ac:	e43e                	sd	a5,8(sp)
ffffffffc02054ae:	0e0a0263          	beqz	s4,ffffffffc0205592 <stride_dequeue+0x584>
ffffffffc02054b2:	85d2                	mv	a1,s4
ffffffffc02054b4:	8566                	mv	a0,s9
ffffffffc02054b6:	91dff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02054ba:	58fd                	li	a7,-1
ffffffffc02054bc:	0d1505e3          	beq	a0,a7,ffffffffc0205d86 <stride_dequeue+0xd78>
ffffffffc02054c0:	008a3783          	ld	a5,8(s4)
ffffffffc02054c4:	010a3803          	ld	a6,16(s4)
ffffffffc02054c8:	e83e                	sd	a5,16(sp)
ffffffffc02054ca:	0a080c63          	beqz	a6,ffffffffc0205582 <stride_dequeue+0x574>
ffffffffc02054ce:	85c2                	mv	a1,a6
ffffffffc02054d0:	8566                	mv	a0,s9
ffffffffc02054d2:	ec42                	sd	a6,24(sp)
ffffffffc02054d4:	8ffff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02054d8:	58fd                	li	a7,-1
ffffffffc02054da:	6862                	ld	a6,24(sp)
ffffffffc02054dc:	01151463          	bne	a0,a7,ffffffffc02054e4 <stride_dequeue+0x4d6>
ffffffffc02054e0:	07c0106f          	j	ffffffffc020655c <stride_dequeue+0x154e>
ffffffffc02054e4:	00883783          	ld	a5,8(a6)
ffffffffc02054e8:	01083983          	ld	s3,16(a6)
ffffffffc02054ec:	ec3e                	sd	a5,24(sp)
ffffffffc02054ee:	00099463          	bnez	s3,ffffffffc02054f6 <stride_dequeue+0x4e8>
ffffffffc02054f2:	2bb0106f          	j	ffffffffc0206fac <stride_dequeue+0x1f9e>
ffffffffc02054f6:	85ce                	mv	a1,s3
ffffffffc02054f8:	8566                	mv	a0,s9
ffffffffc02054fa:	f042                	sd	a6,32(sp)
ffffffffc02054fc:	8d7ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205500:	58fd                	li	a7,-1
ffffffffc0205502:	7802                	ld	a6,32(sp)
ffffffffc0205504:	01151463          	bne	a0,a7,ffffffffc020550c <stride_dequeue+0x4fe>
ffffffffc0205508:	05f0106f          	j	ffffffffc0206d66 <stride_dequeue+0x1d58>
ffffffffc020550c:	0089b783          	ld	a5,8(s3)
ffffffffc0205510:	0109be03          	ld	t3,16(s3)
ffffffffc0205514:	f03e                	sd	a5,32(sp)
ffffffffc0205516:	040e0663          	beqz	t3,ffffffffc0205562 <stride_dequeue+0x554>
ffffffffc020551a:	85f2                	mv	a1,t3
ffffffffc020551c:	8566                	mv	a0,s9
ffffffffc020551e:	f842                	sd	a6,48(sp)
ffffffffc0205520:	f472                	sd	t3,40(sp)
ffffffffc0205522:	8b1ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205526:	58fd                	li	a7,-1
ffffffffc0205528:	7e22                	ld	t3,40(sp)
ffffffffc020552a:	7842                	ld	a6,48(sp)
ffffffffc020552c:	01151463          	bne	a0,a7,ffffffffc0205534 <stride_dequeue+0x526>
ffffffffc0205530:	4e70106f          	j	ffffffffc0207216 <stride_dequeue+0x2208>
ffffffffc0205534:	010e3583          	ld	a1,16(t3)
ffffffffc0205538:	8566                	mv	a0,s9
ffffffffc020553a:	008e3b03          	ld	s6,8(t3)
ffffffffc020553e:	f842                	sd	a6,48(sp)
ffffffffc0205540:	f472                	sd	t3,40(sp)
ffffffffc0205542:	8edff0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0205546:	7e22                	ld	t3,40(sp)
ffffffffc0205548:	7842                	ld	a6,48(sp)
ffffffffc020554a:	016e3823          	sd	s6,16(t3)
ffffffffc020554e:	00ae3423          	sd	a0,8(t3)
ffffffffc0205552:	010c2b03          	lw	s6,16(s8)
ffffffffc0205556:	e119                	bnez	a0,ffffffffc020555c <stride_dequeue+0x54e>
ffffffffc0205558:	7bb0106f          	j	ffffffffc0207512 <stride_dequeue+0x2504>
ffffffffc020555c:	01c53023          	sd	t3,0(a0)
ffffffffc0205560:	8cf2                	mv	s9,t3
ffffffffc0205562:	7782                	ld	a5,32(sp)
ffffffffc0205564:	0199b423          	sd	s9,8(s3)
ffffffffc0205568:	00f9b823          	sd	a5,16(s3)
ffffffffc020556c:	013cb023          	sd	s3,0(s9)
ffffffffc0205570:	67e2                	ld	a5,24(sp)
ffffffffc0205572:	01383423          	sd	s3,8(a6)
ffffffffc0205576:	8cc2                	mv	s9,a6
ffffffffc0205578:	00f83823          	sd	a5,16(a6)
ffffffffc020557c:	0109b023          	sd	a6,0(s3)
ffffffffc0205580:	89da                	mv	s3,s6
ffffffffc0205582:	67c2                	ld	a5,16(sp)
ffffffffc0205584:	019a3423          	sd	s9,8(s4)
ffffffffc0205588:	00fa3823          	sd	a5,16(s4)
ffffffffc020558c:	014cb023          	sd	s4,0(s9)
ffffffffc0205590:	8cd2                	mv	s9,s4
ffffffffc0205592:	67a2                	ld	a5,8(sp)
ffffffffc0205594:	0194b423          	sd	s9,8(s1)
ffffffffc0205598:	e89c                	sd	a5,16(s1)
ffffffffc020559a:	009cb023          	sd	s1,0(s9)
ffffffffc020559e:	6782                	ld	a5,0(sp)
ffffffffc02055a0:	009db423          	sd	s1,8(s11)
ffffffffc02055a4:	00fdb823          	sd	a5,16(s11)
ffffffffc02055a8:	01b4b023          	sd	s11,0(s1)
ffffffffc02055ac:	84ee                	mv	s1,s11
ffffffffc02055ae:	bbad                	j	ffffffffc0205328 <stride_dequeue+0x31a>
ffffffffc02055b0:	008db783          	ld	a5,8(s11)
ffffffffc02055b4:	010db603          	ld	a2,16(s11)
ffffffffc02055b8:	e03e                	sd	a5,0(sp)
ffffffffc02055ba:	0e060963          	beqz	a2,ffffffffc02056ac <stride_dequeue+0x69e>
ffffffffc02055be:	8532                	mv	a0,a2
ffffffffc02055c0:	85d2                	mv	a1,s4
ffffffffc02055c2:	e432                	sd	a2,8(sp)
ffffffffc02055c4:	80fff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02055c8:	58fd                	li	a7,-1
ffffffffc02055ca:	6622                	ld	a2,8(sp)
ffffffffc02055cc:	091504e3          	beq	a0,a7,ffffffffc0205e54 <stride_dequeue+0xe46>
ffffffffc02055d0:	008a3783          	ld	a5,8(s4)
ffffffffc02055d4:	010a3803          	ld	a6,16(s4)
ffffffffc02055d8:	e43e                	sd	a5,8(sp)
ffffffffc02055da:	0c080263          	beqz	a6,ffffffffc020569e <stride_dequeue+0x690>
ffffffffc02055de:	85c2                	mv	a1,a6
ffffffffc02055e0:	8532                	mv	a0,a2
ffffffffc02055e2:	ec42                	sd	a6,24(sp)
ffffffffc02055e4:	e832                	sd	a2,16(sp)
ffffffffc02055e6:	fecff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02055ea:	58fd                	li	a7,-1
ffffffffc02055ec:	6642                	ld	a2,16(sp)
ffffffffc02055ee:	6862                	ld	a6,24(sp)
ffffffffc02055f0:	01151463          	bne	a0,a7,ffffffffc02055f8 <stride_dequeue+0x5ea>
ffffffffc02055f4:	00a0106f          	j	ffffffffc02065fe <stride_dequeue+0x15f0>
ffffffffc02055f8:	00883783          	ld	a5,8(a6)
ffffffffc02055fc:	01083983          	ld	s3,16(a6)
ffffffffc0205600:	e83e                	sd	a5,16(sp)
ffffffffc0205602:	00099463          	bnez	s3,ffffffffc020560a <stride_dequeue+0x5fc>
ffffffffc0205606:	1e50106f          	j	ffffffffc0206fea <stride_dequeue+0x1fdc>
ffffffffc020560a:	8532                	mv	a0,a2
ffffffffc020560c:	85ce                	mv	a1,s3
ffffffffc020560e:	f042                	sd	a6,32(sp)
ffffffffc0205610:	ec32                	sd	a2,24(sp)
ffffffffc0205612:	fc0ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205616:	58fd                	li	a7,-1
ffffffffc0205618:	6662                	ld	a2,24(sp)
ffffffffc020561a:	7802                	ld	a6,32(sp)
ffffffffc020561c:	01151463          	bne	a0,a7,ffffffffc0205624 <stride_dequeue+0x616>
ffffffffc0205620:	4fc0106f          	j	ffffffffc0206b1c <stride_dequeue+0x1b0e>
ffffffffc0205624:	0089b783          	ld	a5,8(s3)
ffffffffc0205628:	0109be03          	ld	t3,16(s3)
ffffffffc020562c:	ec3e                	sd	a5,24(sp)
ffffffffc020562e:	040e0863          	beqz	t3,ffffffffc020567e <stride_dequeue+0x670>
ffffffffc0205632:	85f2                	mv	a1,t3
ffffffffc0205634:	8532                	mv	a0,a2
ffffffffc0205636:	f842                	sd	a6,48(sp)
ffffffffc0205638:	f472                	sd	t3,40(sp)
ffffffffc020563a:	f032                	sd	a2,32(sp)
ffffffffc020563c:	f96ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205640:	7842                	ld	a6,48(sp)
ffffffffc0205642:	7e22                	ld	t3,40(sp)
ffffffffc0205644:	58fd                	li	a7,-1
ffffffffc0205646:	f442                	sd	a6,40(sp)
ffffffffc0205648:	7602                	ld	a2,32(sp)
ffffffffc020564a:	01151463          	bne	a0,a7,ffffffffc0205652 <stride_dequeue+0x644>
ffffffffc020564e:	37b0106f          	j	ffffffffc02071c8 <stride_dequeue+0x21ba>
ffffffffc0205652:	010e3583          	ld	a1,16(t3)
ffffffffc0205656:	8532                	mv	a0,a2
ffffffffc0205658:	008e3b03          	ld	s6,8(t3)
ffffffffc020565c:	f072                	sd	t3,32(sp)
ffffffffc020565e:	fd0ff0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0205662:	7e02                	ld	t3,32(sp)
ffffffffc0205664:	7822                	ld	a6,40(sp)
ffffffffc0205666:	016e3823          	sd	s6,16(t3)
ffffffffc020566a:	00ae3423          	sd	a0,8(t3)
ffffffffc020566e:	010c2b03          	lw	s6,16(s8)
ffffffffc0205672:	e119                	bnez	a0,ffffffffc0205678 <stride_dequeue+0x66a>
ffffffffc0205674:	7090106f          	j	ffffffffc020757c <stride_dequeue+0x256e>
ffffffffc0205678:	01c53023          	sd	t3,0(a0)
ffffffffc020567c:	8672                	mv	a2,t3
ffffffffc020567e:	67e2                	ld	a5,24(sp)
ffffffffc0205680:	00c9b423          	sd	a2,8(s3)
ffffffffc0205684:	00f9b823          	sd	a5,16(s3)
ffffffffc0205688:	01363023          	sd	s3,0(a2)
ffffffffc020568c:	67c2                	ld	a5,16(sp)
ffffffffc020568e:	01383423          	sd	s3,8(a6)
ffffffffc0205692:	8642                	mv	a2,a6
ffffffffc0205694:	00f83823          	sd	a5,16(a6)
ffffffffc0205698:	0109b023          	sd	a6,0(s3)
ffffffffc020569c:	89da                	mv	s3,s6
ffffffffc020569e:	67a2                	ld	a5,8(sp)
ffffffffc02056a0:	00ca3423          	sd	a2,8(s4)
ffffffffc02056a4:	00fa3823          	sd	a5,16(s4)
ffffffffc02056a8:	01463023          	sd	s4,0(a2)
ffffffffc02056ac:	6782                	ld	a5,0(sp)
ffffffffc02056ae:	014db423          	sd	s4,8(s11)
ffffffffc02056b2:	00fdb823          	sd	a5,16(s11)
ffffffffc02056b6:	01ba3023          	sd	s11,0(s4)
ffffffffc02056ba:	8a6e                	mv	s4,s11
ffffffffc02056bc:	bb5d                	j	ffffffffc0205472 <stride_dequeue+0x464>
ffffffffc02056be:	008db783          	ld	a5,8(s11)
ffffffffc02056c2:	010dba03          	ld	s4,16(s11)
ffffffffc02056c6:	e43e                	sd	a5,8(sp)
ffffffffc02056c8:	0e0a0163          	beqz	s4,ffffffffc02057aa <stride_dequeue+0x79c>
ffffffffc02056cc:	85e6                	mv	a1,s9
ffffffffc02056ce:	8552                	mv	a0,s4
ffffffffc02056d0:	f02ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02056d4:	58fd                	li	a7,-1
ffffffffc02056d6:	05150de3          	beq	a0,a7,ffffffffc0205f30 <stride_dequeue+0xf22>
ffffffffc02056da:	008cb783          	ld	a5,8(s9)
ffffffffc02056de:	010cb803          	ld	a6,16(s9)
ffffffffc02056e2:	e83e                	sd	a5,16(sp)
ffffffffc02056e4:	0a080c63          	beqz	a6,ffffffffc020579c <stride_dequeue+0x78e>
ffffffffc02056e8:	85c2                	mv	a1,a6
ffffffffc02056ea:	8552                	mv	a0,s4
ffffffffc02056ec:	ec42                	sd	a6,24(sp)
ffffffffc02056ee:	ee4ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02056f2:	58fd                	li	a7,-1
ffffffffc02056f4:	6862                	ld	a6,24(sp)
ffffffffc02056f6:	01151463          	bne	a0,a7,ffffffffc02056fe <stride_dequeue+0x6f0>
ffffffffc02056fa:	7ab0006f          	j	ffffffffc02066a4 <stride_dequeue+0x1696>
ffffffffc02056fe:	00883783          	ld	a5,8(a6)
ffffffffc0205702:	01083983          	ld	s3,16(a6)
ffffffffc0205706:	ec3e                	sd	a5,24(sp)
ffffffffc0205708:	00099463          	bnez	s3,ffffffffc0205710 <stride_dequeue+0x702>
ffffffffc020570c:	0cd0106f          	j	ffffffffc0206fd8 <stride_dequeue+0x1fca>
ffffffffc0205710:	85ce                	mv	a1,s3
ffffffffc0205712:	8552                	mv	a0,s4
ffffffffc0205714:	f042                	sd	a6,32(sp)
ffffffffc0205716:	ebcff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc020571a:	58fd                	li	a7,-1
ffffffffc020571c:	7802                	ld	a6,32(sp)
ffffffffc020571e:	01151463          	bne	a0,a7,ffffffffc0205726 <stride_dequeue+0x718>
ffffffffc0205722:	39c0106f          	j	ffffffffc0206abe <stride_dequeue+0x1ab0>
ffffffffc0205726:	0089b783          	ld	a5,8(s3)
ffffffffc020572a:	0109be03          	ld	t3,16(s3)
ffffffffc020572e:	f03e                	sd	a5,32(sp)
ffffffffc0205730:	040e0663          	beqz	t3,ffffffffc020577c <stride_dequeue+0x76e>
ffffffffc0205734:	85f2                	mv	a1,t3
ffffffffc0205736:	8552                	mv	a0,s4
ffffffffc0205738:	f842                	sd	a6,48(sp)
ffffffffc020573a:	f472                	sd	t3,40(sp)
ffffffffc020573c:	e96ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205740:	58fd                	li	a7,-1
ffffffffc0205742:	7e22                	ld	t3,40(sp)
ffffffffc0205744:	7842                	ld	a6,48(sp)
ffffffffc0205746:	01151463          	bne	a0,a7,ffffffffc020574e <stride_dequeue+0x740>
ffffffffc020574a:	2f90106f          	j	ffffffffc0207242 <stride_dequeue+0x2234>
ffffffffc020574e:	010e3583          	ld	a1,16(t3)
ffffffffc0205752:	8552                	mv	a0,s4
ffffffffc0205754:	008e3b03          	ld	s6,8(t3)
ffffffffc0205758:	f842                	sd	a6,48(sp)
ffffffffc020575a:	f472                	sd	t3,40(sp)
ffffffffc020575c:	ed2ff0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0205760:	7e22                	ld	t3,40(sp)
ffffffffc0205762:	7842                	ld	a6,48(sp)
ffffffffc0205764:	016e3823          	sd	s6,16(t3)
ffffffffc0205768:	00ae3423          	sd	a0,8(t3)
ffffffffc020576c:	010c2b03          	lw	s6,16(s8)
ffffffffc0205770:	e119                	bnez	a0,ffffffffc0205776 <stride_dequeue+0x768>
ffffffffc0205772:	5a70106f          	j	ffffffffc0207518 <stride_dequeue+0x250a>
ffffffffc0205776:	01c53023          	sd	t3,0(a0)
ffffffffc020577a:	8a72                	mv	s4,t3
ffffffffc020577c:	7782                	ld	a5,32(sp)
ffffffffc020577e:	0149b423          	sd	s4,8(s3)
ffffffffc0205782:	00f9b823          	sd	a5,16(s3)
ffffffffc0205786:	013a3023          	sd	s3,0(s4)
ffffffffc020578a:	67e2                	ld	a5,24(sp)
ffffffffc020578c:	01383423          	sd	s3,8(a6)
ffffffffc0205790:	8a42                	mv	s4,a6
ffffffffc0205792:	00f83823          	sd	a5,16(a6)
ffffffffc0205796:	0109b023          	sd	a6,0(s3)
ffffffffc020579a:	89da                	mv	s3,s6
ffffffffc020579c:	67c2                	ld	a5,16(sp)
ffffffffc020579e:	014cb423          	sd	s4,8(s9)
ffffffffc02057a2:	00fcb823          	sd	a5,16(s9)
ffffffffc02057a6:	019a3023          	sd	s9,0(s4)
ffffffffc02057aa:	67a2                	ld	a5,8(sp)
ffffffffc02057ac:	019db423          	sd	s9,8(s11)
ffffffffc02057b0:	00fdb823          	sd	a5,16(s11)
ffffffffc02057b4:	01bcb023          	sd	s11,0(s9)
ffffffffc02057b8:	b695                	j	ffffffffc020531c <stride_dequeue+0x30e>
ffffffffc02057ba:	00893783          	ld	a5,8(s2)
ffffffffc02057be:	01093883          	ld	a7,16(s2)
ffffffffc02057c2:	ec2a                	sd	a0,24(sp)
ffffffffc02057c4:	e83e                	sd	a5,16(sp)
ffffffffc02057c6:	0a088963          	beqz	a7,ffffffffc0205878 <stride_dequeue+0x86a>
ffffffffc02057ca:	8546                	mv	a0,a7
ffffffffc02057cc:	85e6                	mv	a1,s9
ffffffffc02057ce:	f046                	sd	a7,32(sp)
ffffffffc02057d0:	e02ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02057d4:	6862                	ld	a6,24(sp)
ffffffffc02057d6:	7882                	ld	a7,32(sp)
ffffffffc02057d8:	030504e3          	beq	a0,a6,ffffffffc0206000 <stride_dequeue+0xff2>
ffffffffc02057dc:	008cb783          	ld	a5,8(s9)
ffffffffc02057e0:	010cb303          	ld	t1,16(s9)
ffffffffc02057e4:	f042                	sd	a6,32(sp)
ffffffffc02057e6:	ec3e                	sd	a5,24(sp)
ffffffffc02057e8:	08030163          	beqz	t1,ffffffffc020586a <stride_dequeue+0x85c>
ffffffffc02057ec:	859a                	mv	a1,t1
ffffffffc02057ee:	8546                	mv	a0,a7
ffffffffc02057f0:	f81a                	sd	t1,48(sp)
ffffffffc02057f2:	f446                	sd	a7,40(sp)
ffffffffc02057f4:	ddeff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02057f8:	7802                	ld	a6,32(sp)
ffffffffc02057fa:	78a2                	ld	a7,40(sp)
ffffffffc02057fc:	7342                	ld	t1,48(sp)
ffffffffc02057fe:	01051463          	bne	a0,a6,ffffffffc0205806 <stride_dequeue+0x7f8>
ffffffffc0205802:	0d00106f          	j	ffffffffc02068d2 <stride_dequeue+0x18c4>
ffffffffc0205806:	00833783          	ld	a5,8(t1)
ffffffffc020580a:	01033983          	ld	s3,16(t1)
ffffffffc020580e:	f442                	sd	a6,40(sp)
ffffffffc0205810:	f03e                	sd	a5,32(sp)
ffffffffc0205812:	00099463          	bnez	s3,ffffffffc020581a <stride_dequeue+0x80c>
ffffffffc0205816:	6720106f          	j	ffffffffc0206e88 <stride_dequeue+0x1e7a>
ffffffffc020581a:	8546                	mv	a0,a7
ffffffffc020581c:	85ce                	mv	a1,s3
ffffffffc020581e:	fc1a                	sd	t1,56(sp)
ffffffffc0205820:	f846                	sd	a7,48(sp)
ffffffffc0205822:	db0ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205826:	7822                	ld	a6,40(sp)
ffffffffc0205828:	78c2                	ld	a7,48(sp)
ffffffffc020582a:	7362                	ld	t1,56(sp)
ffffffffc020582c:	01051463          	bne	a0,a6,ffffffffc0205834 <stride_dequeue+0x826>
ffffffffc0205830:	6700106f          	j	ffffffffc0206ea0 <stride_dequeue+0x1e92>
ffffffffc0205834:	0109b583          	ld	a1,16(s3)
ffffffffc0205838:	0089bb03          	ld	s6,8(s3)
ffffffffc020583c:	8546                	mv	a0,a7
ffffffffc020583e:	f41a                	sd	t1,40(sp)
ffffffffc0205840:	deeff0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0205844:	00a9b423          	sd	a0,8(s3)
ffffffffc0205848:	0169b823          	sd	s6,16(s3)
ffffffffc020584c:	7322                	ld	t1,40(sp)
ffffffffc020584e:	010c2b03          	lw	s6,16(s8)
ffffffffc0205852:	c119                	beqz	a0,ffffffffc0205858 <stride_dequeue+0x84a>
ffffffffc0205854:	01353023          	sd	s3,0(a0)
ffffffffc0205858:	7782                	ld	a5,32(sp)
ffffffffc020585a:	01333423          	sd	s3,8(t1)
ffffffffc020585e:	889a                	mv	a7,t1
ffffffffc0205860:	00f33823          	sd	a5,16(t1)
ffffffffc0205864:	0069b023          	sd	t1,0(s3)
ffffffffc0205868:	89da                	mv	s3,s6
ffffffffc020586a:	67e2                	ld	a5,24(sp)
ffffffffc020586c:	011cb423          	sd	a7,8(s9)
ffffffffc0205870:	00fcb823          	sd	a5,16(s9)
ffffffffc0205874:	0198b023          	sd	s9,0(a7)
ffffffffc0205878:	67c2                	ld	a5,16(sp)
ffffffffc020587a:	01993423          	sd	s9,8(s2)
ffffffffc020587e:	00f93823          	sd	a5,16(s2)
ffffffffc0205882:	012cb023          	sd	s2,0(s9)
ffffffffc0205886:	b8f5                	j	ffffffffc0205182 <stride_dequeue+0x174>
ffffffffc0205888:	00893783          	ld	a5,8(s2)
ffffffffc020588c:	01093c83          	ld	s9,16(s2)
ffffffffc0205890:	e43e                	sd	a5,8(sp)
ffffffffc0205892:	0c0c8d63          	beqz	s9,ffffffffc020596c <stride_dequeue+0x95e>
ffffffffc0205896:	85ee                	mv	a1,s11
ffffffffc0205898:	8566                	mv	a0,s9
ffffffffc020589a:	d38ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc020589e:	58fd                	li	a7,-1
ffffffffc02058a0:	39150063          	beq	a0,a7,ffffffffc0205c20 <stride_dequeue+0xc12>
ffffffffc02058a4:	008db783          	ld	a5,8(s11)
ffffffffc02058a8:	010db803          	ld	a6,16(s11)
ffffffffc02058ac:	e83e                	sd	a5,16(sp)
ffffffffc02058ae:	0a080863          	beqz	a6,ffffffffc020595e <stride_dequeue+0x950>
ffffffffc02058b2:	85c2                	mv	a1,a6
ffffffffc02058b4:	8566                	mv	a0,s9
ffffffffc02058b6:	ec42                	sd	a6,24(sp)
ffffffffc02058b8:	d1aff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02058bc:	58fd                	li	a7,-1
ffffffffc02058be:	6862                	ld	a6,24(sp)
ffffffffc02058c0:	7d150f63          	beq	a0,a7,ffffffffc020609e <stride_dequeue+0x1090>
ffffffffc02058c4:	00883783          	ld	a5,8(a6)
ffffffffc02058c8:	01083303          	ld	t1,16(a6)
ffffffffc02058cc:	ec3e                	sd	a5,24(sp)
ffffffffc02058ce:	08030063          	beqz	t1,ffffffffc020594e <stride_dequeue+0x940>
ffffffffc02058d2:	859a                	mv	a1,t1
ffffffffc02058d4:	8566                	mv	a0,s9
ffffffffc02058d6:	f442                	sd	a6,40(sp)
ffffffffc02058d8:	f01a                	sd	t1,32(sp)
ffffffffc02058da:	cf8ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02058de:	58fd                	li	a7,-1
ffffffffc02058e0:	7302                	ld	t1,32(sp)
ffffffffc02058e2:	7822                	ld	a6,40(sp)
ffffffffc02058e4:	65150fe3          	beq	a0,a7,ffffffffc0206742 <stride_dequeue+0x1734>
ffffffffc02058e8:	00833783          	ld	a5,8(t1)
ffffffffc02058ec:	01033983          	ld	s3,16(t1)
ffffffffc02058f0:	f03e                	sd	a5,32(sp)
ffffffffc02058f2:	00099463          	bnez	s3,ffffffffc02058fa <stride_dequeue+0x8ec>
ffffffffc02058f6:	5980106f          	j	ffffffffc0206e8e <stride_dequeue+0x1e80>
ffffffffc02058fa:	85ce                	mv	a1,s3
ffffffffc02058fc:	8566                	mv	a0,s9
ffffffffc02058fe:	f81a                	sd	t1,48(sp)
ffffffffc0205900:	f442                	sd	a6,40(sp)
ffffffffc0205902:	cd0ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205906:	58fd                	li	a7,-1
ffffffffc0205908:	7822                	ld	a6,40(sp)
ffffffffc020590a:	7342                	ld	t1,48(sp)
ffffffffc020590c:	01151463          	bne	a0,a7,ffffffffc0205914 <stride_dequeue+0x906>
ffffffffc0205910:	5ea0106f          	j	ffffffffc0206efa <stride_dequeue+0x1eec>
ffffffffc0205914:	0109b583          	ld	a1,16(s3)
ffffffffc0205918:	0089bb03          	ld	s6,8(s3)
ffffffffc020591c:	8566                	mv	a0,s9
ffffffffc020591e:	f81a                	sd	t1,48(sp)
ffffffffc0205920:	f442                	sd	a6,40(sp)
ffffffffc0205922:	d0cff0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0205926:	00a9b423          	sd	a0,8(s3)
ffffffffc020592a:	0169b823          	sd	s6,16(s3)
ffffffffc020592e:	7822                	ld	a6,40(sp)
ffffffffc0205930:	7342                	ld	t1,48(sp)
ffffffffc0205932:	010c2b03          	lw	s6,16(s8)
ffffffffc0205936:	c119                	beqz	a0,ffffffffc020593c <stride_dequeue+0x92e>
ffffffffc0205938:	01353023          	sd	s3,0(a0)
ffffffffc020593c:	7782                	ld	a5,32(sp)
ffffffffc020593e:	01333423          	sd	s3,8(t1)
ffffffffc0205942:	8c9a                	mv	s9,t1
ffffffffc0205944:	00f33823          	sd	a5,16(t1)
ffffffffc0205948:	0069b023          	sd	t1,0(s3)
ffffffffc020594c:	89da                	mv	s3,s6
ffffffffc020594e:	67e2                	ld	a5,24(sp)
ffffffffc0205950:	01983423          	sd	s9,8(a6)
ffffffffc0205954:	00f83823          	sd	a5,16(a6)
ffffffffc0205958:	010cb023          	sd	a6,0(s9)
ffffffffc020595c:	8cc2                	mv	s9,a6
ffffffffc020595e:	67c2                	ld	a5,16(sp)
ffffffffc0205960:	019db423          	sd	s9,8(s11)
ffffffffc0205964:	00fdb823          	sd	a5,16(s11)
ffffffffc0205968:	01bcb023          	sd	s11,0(s9)
ffffffffc020596c:	67a2                	ld	a5,8(sp)
ffffffffc020596e:	01b93423          	sd	s11,8(s2)
ffffffffc0205972:	00f93823          	sd	a5,16(s2)
ffffffffc0205976:	012db023          	sd	s2,0(s11)
ffffffffc020597a:	819ff06f          	j	ffffffffc0205192 <stride_dequeue+0x184>
ffffffffc020597e:	008cb783          	ld	a5,8(s9)
ffffffffc0205982:	010cba03          	ld	s4,16(s9)
ffffffffc0205986:	e43e                	sd	a5,8(sp)
ffffffffc0205988:	0c0a0d63          	beqz	s4,ffffffffc0205a62 <stride_dequeue+0xa54>
ffffffffc020598c:	85a6                	mv	a1,s1
ffffffffc020598e:	8552                	mv	a0,s4
ffffffffc0205990:	c42ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205994:	58fd                	li	a7,-1
ffffffffc0205996:	151500e3          	beq	a0,a7,ffffffffc02062d6 <stride_dequeue+0x12c8>
ffffffffc020599a:	649c                	ld	a5,8(s1)
ffffffffc020599c:	0104b983          	ld	s3,16(s1)
ffffffffc02059a0:	e83e                	sd	a5,16(sp)
ffffffffc02059a2:	00099463          	bnez	s3,ffffffffc02059aa <stride_dequeue+0x99c>
ffffffffc02059a6:	4f40106f          	j	ffffffffc0206e9a <stride_dequeue+0x1e8c>
ffffffffc02059aa:	85ce                	mv	a1,s3
ffffffffc02059ac:	8552                	mv	a0,s4
ffffffffc02059ae:	c24ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02059b2:	58fd                	li	a7,-1
ffffffffc02059b4:	01151463          	bne	a0,a7,ffffffffc02059bc <stride_dequeue+0x9ae>
ffffffffc02059b8:	0b00106f          	j	ffffffffc0206a68 <stride_dequeue+0x1a5a>
ffffffffc02059bc:	0089b783          	ld	a5,8(s3)
ffffffffc02059c0:	0109b303          	ld	t1,16(s3)
ffffffffc02059c4:	ec3e                	sd	a5,24(sp)
ffffffffc02059c6:	08030063          	beqz	t1,ffffffffc0205a46 <stride_dequeue+0xa38>
ffffffffc02059ca:	859a                	mv	a1,t1
ffffffffc02059cc:	8552                	mv	a0,s4
ffffffffc02059ce:	f01a                	sd	t1,32(sp)
ffffffffc02059d0:	c02ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02059d4:	58fd                	li	a7,-1
ffffffffc02059d6:	7302                	ld	t1,32(sp)
ffffffffc02059d8:	01151463          	bne	a0,a7,ffffffffc02059e0 <stride_dequeue+0x9d2>
ffffffffc02059dc:	0130106f          	j	ffffffffc02071ee <stride_dequeue+0x21e0>
ffffffffc02059e0:	00833783          	ld	a5,8(t1)
ffffffffc02059e4:	01033e03          	ld	t3,16(t1)
ffffffffc02059e8:	f03e                	sd	a5,32(sp)
ffffffffc02059ea:	040e0663          	beqz	t3,ffffffffc0205a36 <stride_dequeue+0xa28>
ffffffffc02059ee:	85f2                	mv	a1,t3
ffffffffc02059f0:	8552                	mv	a0,s4
ffffffffc02059f2:	f81a                	sd	t1,48(sp)
ffffffffc02059f4:	f472                	sd	t3,40(sp)
ffffffffc02059f6:	bdcff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02059fa:	58fd                	li	a7,-1
ffffffffc02059fc:	7e22                	ld	t3,40(sp)
ffffffffc02059fe:	7342                	ld	t1,48(sp)
ffffffffc0205a00:	01151463          	bne	a0,a7,ffffffffc0205a08 <stride_dequeue+0x9fa>
ffffffffc0205a04:	53d0106f          	j	ffffffffc0207740 <stride_dequeue+0x2732>
ffffffffc0205a08:	010e3583          	ld	a1,16(t3)
ffffffffc0205a0c:	8552                	mv	a0,s4
ffffffffc0205a0e:	008e3b03          	ld	s6,8(t3)
ffffffffc0205a12:	f81a                	sd	t1,48(sp)
ffffffffc0205a14:	f472                	sd	t3,40(sp)
ffffffffc0205a16:	c18ff0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0205a1a:	7e22                	ld	t3,40(sp)
ffffffffc0205a1c:	7342                	ld	t1,48(sp)
ffffffffc0205a1e:	016e3823          	sd	s6,16(t3)
ffffffffc0205a22:	00ae3423          	sd	a0,8(t3)
ffffffffc0205a26:	010c2b03          	lw	s6,16(s8)
ffffffffc0205a2a:	e119                	bnez	a0,ffffffffc0205a30 <stride_dequeue+0xa22>
ffffffffc0205a2c:	76d0106f          	j	ffffffffc0207998 <stride_dequeue+0x298a>
ffffffffc0205a30:	01c53023          	sd	t3,0(a0)
ffffffffc0205a34:	8a72                	mv	s4,t3
ffffffffc0205a36:	7782                	ld	a5,32(sp)
ffffffffc0205a38:	01433423          	sd	s4,8(t1)
ffffffffc0205a3c:	00f33823          	sd	a5,16(t1)
ffffffffc0205a40:	006a3023          	sd	t1,0(s4)
ffffffffc0205a44:	8a1a                	mv	s4,t1
ffffffffc0205a46:	67e2                	ld	a5,24(sp)
ffffffffc0205a48:	0149b423          	sd	s4,8(s3)
ffffffffc0205a4c:	00f9b823          	sd	a5,16(s3)
ffffffffc0205a50:	013a3023          	sd	s3,0(s4)
ffffffffc0205a54:	67c2                	ld	a5,16(sp)
ffffffffc0205a56:	0134b423          	sd	s3,8(s1)
ffffffffc0205a5a:	e89c                	sd	a5,16(s1)
ffffffffc0205a5c:	0099b023          	sd	s1,0(s3)
ffffffffc0205a60:	89da                	mv	s3,s6
ffffffffc0205a62:	67a2                	ld	a5,8(sp)
ffffffffc0205a64:	009cb423          	sd	s1,8(s9)
ffffffffc0205a68:	00fcb823          	sd	a5,16(s9)
ffffffffc0205a6c:	0194b023          	sd	s9,0(s1)
ffffffffc0205a70:	84e6                	mv	s1,s9
ffffffffc0205a72:	b635                	j	ffffffffc020559e <stride_dequeue+0x590>
ffffffffc0205a74:	008db783          	ld	a5,8(s11)
ffffffffc0205a78:	010db883          	ld	a7,16(s11)
ffffffffc0205a7c:	ec2a                	sd	a0,24(sp)
ffffffffc0205a7e:	e83e                	sd	a5,16(sp)
ffffffffc0205a80:	0a088963          	beqz	a7,ffffffffc0205b32 <stride_dequeue+0xb24>
ffffffffc0205a84:	8546                	mv	a0,a7
ffffffffc0205a86:	85d2                	mv	a1,s4
ffffffffc0205a88:	f046                	sd	a7,32(sp)
ffffffffc0205a8a:	b48ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205a8e:	6862                	ld	a6,24(sp)
ffffffffc0205a90:	7882                	ld	a7,32(sp)
ffffffffc0205a92:	0d050ae3          	beq	a0,a6,ffffffffc0206366 <stride_dequeue+0x1358>
ffffffffc0205a96:	008a3783          	ld	a5,8(s4)
ffffffffc0205a9a:	010a3983          	ld	s3,16(s4)
ffffffffc0205a9e:	f042                	sd	a6,32(sp)
ffffffffc0205aa0:	ec3e                	sd	a5,24(sp)
ffffffffc0205aa2:	00099463          	bnez	s3,ffffffffc0205aaa <stride_dequeue+0xa9c>
ffffffffc0205aa6:	53e0106f          	j	ffffffffc0206fe4 <stride_dequeue+0x1fd6>
ffffffffc0205aaa:	8546                	mv	a0,a7
ffffffffc0205aac:	85ce                	mv	a1,s3
ffffffffc0205aae:	f446                	sd	a7,40(sp)
ffffffffc0205ab0:	b22ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205ab4:	7802                	ld	a6,32(sp)
ffffffffc0205ab6:	78a2                	ld	a7,40(sp)
ffffffffc0205ab8:	01051463          	bne	a0,a6,ffffffffc0205ac0 <stride_dequeue+0xab2>
ffffffffc0205abc:	1260106f          	j	ffffffffc0206be2 <stride_dequeue+0x1bd4>
ffffffffc0205ac0:	0089b783          	ld	a5,8(s3)
ffffffffc0205ac4:	0109be03          	ld	t3,16(s3)
ffffffffc0205ac8:	f442                	sd	a6,40(sp)
ffffffffc0205aca:	f03e                	sd	a5,32(sp)
ffffffffc0205acc:	040e0463          	beqz	t3,ffffffffc0205b14 <stride_dequeue+0xb06>
ffffffffc0205ad0:	85f2                	mv	a1,t3
ffffffffc0205ad2:	8546                	mv	a0,a7
ffffffffc0205ad4:	fc72                	sd	t3,56(sp)
ffffffffc0205ad6:	f846                	sd	a7,48(sp)
ffffffffc0205ad8:	afaff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205adc:	7822                	ld	a6,40(sp)
ffffffffc0205ade:	78c2                	ld	a7,48(sp)
ffffffffc0205ae0:	7e62                	ld	t3,56(sp)
ffffffffc0205ae2:	01051463          	bne	a0,a6,ffffffffc0205aea <stride_dequeue+0xadc>
ffffffffc0205ae6:	0e70106f          	j	ffffffffc02073cc <stride_dequeue+0x23be>
ffffffffc0205aea:	010e3583          	ld	a1,16(t3)
ffffffffc0205aee:	8546                	mv	a0,a7
ffffffffc0205af0:	008e3b03          	ld	s6,8(t3)
ffffffffc0205af4:	f472                	sd	t3,40(sp)
ffffffffc0205af6:	b38ff0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0205afa:	7e22                	ld	t3,40(sp)
ffffffffc0205afc:	016e3823          	sd	s6,16(t3)
ffffffffc0205b00:	00ae3423          	sd	a0,8(t3)
ffffffffc0205b04:	010c2b03          	lw	s6,16(s8)
ffffffffc0205b08:	e119                	bnez	a0,ffffffffc0205b0e <stride_dequeue+0xb00>
ffffffffc0205b0a:	1c10106f          	j	ffffffffc02074ca <stride_dequeue+0x24bc>
ffffffffc0205b0e:	01c53023          	sd	t3,0(a0)
ffffffffc0205b12:	88f2                	mv	a7,t3
ffffffffc0205b14:	7782                	ld	a5,32(sp)
ffffffffc0205b16:	0119b423          	sd	a7,8(s3)
ffffffffc0205b1a:	00f9b823          	sd	a5,16(s3)
ffffffffc0205b1e:	0138b023          	sd	s3,0(a7)
ffffffffc0205b22:	67e2                	ld	a5,24(sp)
ffffffffc0205b24:	013a3423          	sd	s3,8(s4)
ffffffffc0205b28:	00fa3823          	sd	a5,16(s4)
ffffffffc0205b2c:	0149b023          	sd	s4,0(s3)
ffffffffc0205b30:	89da                	mv	s3,s6
ffffffffc0205b32:	67c2                	ld	a5,16(sp)
ffffffffc0205b34:	014db423          	sd	s4,8(s11)
ffffffffc0205b38:	00fdb823          	sd	a5,16(s11)
ffffffffc0205b3c:	01ba3023          	sd	s11,0(s4)
ffffffffc0205b40:	fccff06f          	j	ffffffffc020530c <stride_dequeue+0x2fe>
ffffffffc0205b44:	008db783          	ld	a5,8(s11)
ffffffffc0205b48:	010db883          	ld	a7,16(s11)
ffffffffc0205b4c:	e82a                	sd	a0,16(sp)
ffffffffc0205b4e:	e43e                	sd	a5,8(sp)
ffffffffc0205b50:	0a088f63          	beqz	a7,ffffffffc0205c0e <stride_dequeue+0xc00>
ffffffffc0205b54:	85b2                	mv	a1,a2
ffffffffc0205b56:	8546                	mv	a0,a7
ffffffffc0205b58:	f032                	sd	a2,32(sp)
ffffffffc0205b5a:	ec46                	sd	a7,24(sp)
ffffffffc0205b5c:	a76ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205b60:	6842                	ld	a6,16(sp)
ffffffffc0205b62:	68e2                	ld	a7,24(sp)
ffffffffc0205b64:	7602                	ld	a2,32(sp)
ffffffffc0205b66:	150506e3          	beq	a0,a6,ffffffffc02064b2 <stride_dequeue+0x14a4>
ffffffffc0205b6a:	661c                	ld	a5,8(a2)
ffffffffc0205b6c:	01063983          	ld	s3,16(a2)
ffffffffc0205b70:	ec42                	sd	a6,24(sp)
ffffffffc0205b72:	e83e                	sd	a5,16(sp)
ffffffffc0205b74:	00099463          	bnez	s3,ffffffffc0205b7c <stride_dequeue+0xb6e>
ffffffffc0205b78:	4660106f          	j	ffffffffc0206fde <stride_dequeue+0x1fd0>
ffffffffc0205b7c:	8546                	mv	a0,a7
ffffffffc0205b7e:	85ce                	mv	a1,s3
ffffffffc0205b80:	f432                	sd	a2,40(sp)
ffffffffc0205b82:	f046                	sd	a7,32(sp)
ffffffffc0205b84:	a4eff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205b88:	6862                	ld	a6,24(sp)
ffffffffc0205b8a:	7882                	ld	a7,32(sp)
ffffffffc0205b8c:	7622                	ld	a2,40(sp)
ffffffffc0205b8e:	01051463          	bne	a0,a6,ffffffffc0205b96 <stride_dequeue+0xb88>
ffffffffc0205b92:	0ae0106f          	j	ffffffffc0206c40 <stride_dequeue+0x1c32>
ffffffffc0205b96:	0089b783          	ld	a5,8(s3)
ffffffffc0205b9a:	0109be03          	ld	t3,16(s3)
ffffffffc0205b9e:	f042                	sd	a6,32(sp)
ffffffffc0205ba0:	ec3e                	sd	a5,24(sp)
ffffffffc0205ba2:	040e0863          	beqz	t3,ffffffffc0205bf2 <stride_dequeue+0xbe4>
ffffffffc0205ba6:	85f2                	mv	a1,t3
ffffffffc0205ba8:	8546                	mv	a0,a7
ffffffffc0205baa:	fc32                	sd	a2,56(sp)
ffffffffc0205bac:	f872                	sd	t3,48(sp)
ffffffffc0205bae:	f446                	sd	a7,40(sp)
ffffffffc0205bb0:	a22ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205bb4:	7662                	ld	a2,56(sp)
ffffffffc0205bb6:	7802                	ld	a6,32(sp)
ffffffffc0205bb8:	78a2                	ld	a7,40(sp)
ffffffffc0205bba:	f432                	sd	a2,40(sp)
ffffffffc0205bbc:	7e42                	ld	t3,48(sp)
ffffffffc0205bbe:	01051463          	bne	a0,a6,ffffffffc0205bc6 <stride_dequeue+0xbb8>
ffffffffc0205bc2:	6ac0106f          	j	ffffffffc020726e <stride_dequeue+0x2260>
ffffffffc0205bc6:	010e3583          	ld	a1,16(t3)
ffffffffc0205bca:	8546                	mv	a0,a7
ffffffffc0205bcc:	008e3b03          	ld	s6,8(t3)
ffffffffc0205bd0:	f072                	sd	t3,32(sp)
ffffffffc0205bd2:	a5cff0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0205bd6:	7e02                	ld	t3,32(sp)
ffffffffc0205bd8:	7622                	ld	a2,40(sp)
ffffffffc0205bda:	016e3823          	sd	s6,16(t3)
ffffffffc0205bde:	00ae3423          	sd	a0,8(t3)
ffffffffc0205be2:	010c2b03          	lw	s6,16(s8)
ffffffffc0205be6:	e119                	bnez	a0,ffffffffc0205bec <stride_dequeue+0xbde>
ffffffffc0205be8:	1370106f          	j	ffffffffc020751e <stride_dequeue+0x2510>
ffffffffc0205bec:	01c53023          	sd	t3,0(a0)
ffffffffc0205bf0:	88f2                	mv	a7,t3
ffffffffc0205bf2:	67e2                	ld	a5,24(sp)
ffffffffc0205bf4:	0119b423          	sd	a7,8(s3)
ffffffffc0205bf8:	00f9b823          	sd	a5,16(s3)
ffffffffc0205bfc:	0138b023          	sd	s3,0(a7)
ffffffffc0205c00:	67c2                	ld	a5,16(sp)
ffffffffc0205c02:	01363423          	sd	s3,8(a2)
ffffffffc0205c06:	ea1c                	sd	a5,16(a2)
ffffffffc0205c08:	00c9b023          	sd	a2,0(s3)
ffffffffc0205c0c:	89da                	mv	s3,s6
ffffffffc0205c0e:	67a2                	ld	a5,8(sp)
ffffffffc0205c10:	00cdb423          	sd	a2,8(s11)
ffffffffc0205c14:	00fdb823          	sd	a5,16(s11)
ffffffffc0205c18:	01b63023          	sd	s11,0(a2)
ffffffffc0205c1c:	849ff06f          	j	ffffffffc0205464 <stride_dequeue+0x456>
ffffffffc0205c20:	008cb783          	ld	a5,8(s9)
ffffffffc0205c24:	010cb883          	ld	a7,16(s9)
ffffffffc0205c28:	ec2a                	sd	a0,24(sp)
ffffffffc0205c2a:	e83e                	sd	a5,16(sp)
ffffffffc0205c2c:	0a088963          	beqz	a7,ffffffffc0205cde <stride_dequeue+0xcd0>
ffffffffc0205c30:	8546                	mv	a0,a7
ffffffffc0205c32:	85ee                	mv	a1,s11
ffffffffc0205c34:	f046                	sd	a7,32(sp)
ffffffffc0205c36:	99cff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205c3a:	6862                	ld	a6,24(sp)
ffffffffc0205c3c:	7882                	ld	a7,32(sp)
ffffffffc0205c3e:	7d050863          	beq	a0,a6,ffffffffc020640e <stride_dequeue+0x1400>
ffffffffc0205c42:	008db783          	ld	a5,8(s11)
ffffffffc0205c46:	010db983          	ld	s3,16(s11)
ffffffffc0205c4a:	f042                	sd	a6,32(sp)
ffffffffc0205c4c:	ec3e                	sd	a5,24(sp)
ffffffffc0205c4e:	00099463          	bnez	s3,ffffffffc0205c56 <stride_dequeue+0xc48>
ffffffffc0205c52:	3600106f          	j	ffffffffc0206fb2 <stride_dequeue+0x1fa4>
ffffffffc0205c56:	8546                	mv	a0,a7
ffffffffc0205c58:	85ce                	mv	a1,s3
ffffffffc0205c5a:	f446                	sd	a7,40(sp)
ffffffffc0205c5c:	976ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205c60:	7802                	ld	a6,32(sp)
ffffffffc0205c62:	78a2                	ld	a7,40(sp)
ffffffffc0205c64:	01051463          	bne	a0,a6,ffffffffc0205c6c <stride_dequeue+0xc5e>
ffffffffc0205c68:	71d0006f          	j	ffffffffc0206b84 <stride_dequeue+0x1b76>
ffffffffc0205c6c:	0089b783          	ld	a5,8(s3)
ffffffffc0205c70:	0109be03          	ld	t3,16(s3)
ffffffffc0205c74:	f442                	sd	a6,40(sp)
ffffffffc0205c76:	f03e                	sd	a5,32(sp)
ffffffffc0205c78:	040e0463          	beqz	t3,ffffffffc0205cc0 <stride_dequeue+0xcb2>
ffffffffc0205c7c:	85f2                	mv	a1,t3
ffffffffc0205c7e:	8546                	mv	a0,a7
ffffffffc0205c80:	fc72                	sd	t3,56(sp)
ffffffffc0205c82:	f846                	sd	a7,48(sp)
ffffffffc0205c84:	94eff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205c88:	7822                	ld	a6,40(sp)
ffffffffc0205c8a:	78c2                	ld	a7,48(sp)
ffffffffc0205c8c:	7e62                	ld	t3,56(sp)
ffffffffc0205c8e:	01051463          	bne	a0,a6,ffffffffc0205c96 <stride_dequeue+0xc88>
ffffffffc0205c92:	60a0106f          	j	ffffffffc020729c <stride_dequeue+0x228e>
ffffffffc0205c96:	010e3583          	ld	a1,16(t3)
ffffffffc0205c9a:	8546                	mv	a0,a7
ffffffffc0205c9c:	008e3b03          	ld	s6,8(t3)
ffffffffc0205ca0:	f472                	sd	t3,40(sp)
ffffffffc0205ca2:	98cff0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0205ca6:	7e22                	ld	t3,40(sp)
ffffffffc0205ca8:	016e3823          	sd	s6,16(t3)
ffffffffc0205cac:	00ae3423          	sd	a0,8(t3)
ffffffffc0205cb0:	010c2b03          	lw	s6,16(s8)
ffffffffc0205cb4:	e119                	bnez	a0,ffffffffc0205cba <stride_dequeue+0xcac>
ffffffffc0205cb6:	0270106f          	j	ffffffffc02074dc <stride_dequeue+0x24ce>
ffffffffc0205cba:	01c53023          	sd	t3,0(a0)
ffffffffc0205cbe:	88f2                	mv	a7,t3
ffffffffc0205cc0:	7782                	ld	a5,32(sp)
ffffffffc0205cc2:	0119b423          	sd	a7,8(s3)
ffffffffc0205cc6:	00f9b823          	sd	a5,16(s3)
ffffffffc0205cca:	0138b023          	sd	s3,0(a7)
ffffffffc0205cce:	67e2                	ld	a5,24(sp)
ffffffffc0205cd0:	013db423          	sd	s3,8(s11)
ffffffffc0205cd4:	00fdb823          	sd	a5,16(s11)
ffffffffc0205cd8:	01b9b023          	sd	s11,0(s3)
ffffffffc0205cdc:	89da                	mv	s3,s6
ffffffffc0205cde:	67c2                	ld	a5,16(sp)
ffffffffc0205ce0:	01bcb423          	sd	s11,8(s9)
ffffffffc0205ce4:	00fcb823          	sd	a5,16(s9)
ffffffffc0205ce8:	019db023          	sd	s9,0(s11)
ffffffffc0205cec:	8de6                	mv	s11,s9
ffffffffc0205cee:	b9bd                	j	ffffffffc020596c <stride_dequeue+0x95e>
ffffffffc0205cf0:	00893783          	ld	a5,8(s2)
ffffffffc0205cf4:	01093883          	ld	a7,16(s2)
ffffffffc0205cf8:	f02a                	sd	a0,32(sp)
ffffffffc0205cfa:	ec3e                	sd	a5,24(sp)
ffffffffc0205cfc:	06088c63          	beqz	a7,ffffffffc0205d74 <stride_dequeue+0xd66>
ffffffffc0205d00:	85c2                	mv	a1,a6
ffffffffc0205d02:	8546                	mv	a0,a7
ffffffffc0205d04:	f842                	sd	a6,48(sp)
ffffffffc0205d06:	f446                	sd	a7,40(sp)
ffffffffc0205d08:	8caff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205d0c:	7302                	ld	t1,32(sp)
ffffffffc0205d0e:	78a2                	ld	a7,40(sp)
ffffffffc0205d10:	7842                	ld	a6,48(sp)
ffffffffc0205d12:	2e650ee3          	beq	a0,t1,ffffffffc020680e <stride_dequeue+0x1800>
ffffffffc0205d16:	00883783          	ld	a5,8(a6)
ffffffffc0205d1a:	01083983          	ld	s3,16(a6)
ffffffffc0205d1e:	f41a                	sd	t1,40(sp)
ffffffffc0205d20:	f03e                	sd	a5,32(sp)
ffffffffc0205d22:	64098ee3          	beqz	s3,ffffffffc0206b7e <stride_dequeue+0x1b70>
ffffffffc0205d26:	8546                	mv	a0,a7
ffffffffc0205d28:	85ce                	mv	a1,s3
ffffffffc0205d2a:	fc42                	sd	a6,56(sp)
ffffffffc0205d2c:	f846                	sd	a7,48(sp)
ffffffffc0205d2e:	8a4ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205d32:	7322                	ld	t1,40(sp)
ffffffffc0205d34:	78c2                	ld	a7,48(sp)
ffffffffc0205d36:	7862                	ld	a6,56(sp)
ffffffffc0205d38:	00651463          	bne	a0,t1,ffffffffc0205d40 <stride_dequeue+0xd32>
ffffffffc0205d3c:	1e80106f          	j	ffffffffc0206f24 <stride_dequeue+0x1f16>
ffffffffc0205d40:	0109b583          	ld	a1,16(s3)
ffffffffc0205d44:	0089bb03          	ld	s6,8(s3)
ffffffffc0205d48:	8546                	mv	a0,a7
ffffffffc0205d4a:	f442                	sd	a6,40(sp)
ffffffffc0205d4c:	8e2ff0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0205d50:	00a9b423          	sd	a0,8(s3)
ffffffffc0205d54:	0169b823          	sd	s6,16(s3)
ffffffffc0205d58:	7822                	ld	a6,40(sp)
ffffffffc0205d5a:	010c2b03          	lw	s6,16(s8)
ffffffffc0205d5e:	c119                	beqz	a0,ffffffffc0205d64 <stride_dequeue+0xd56>
ffffffffc0205d60:	01353023          	sd	s3,0(a0)
ffffffffc0205d64:	7782                	ld	a5,32(sp)
ffffffffc0205d66:	01383423          	sd	s3,8(a6)
ffffffffc0205d6a:	00f83823          	sd	a5,16(a6)
ffffffffc0205d6e:	0109b023          	sd	a6,0(s3)
ffffffffc0205d72:	89da                	mv	s3,s6
ffffffffc0205d74:	67e2                	ld	a5,24(sp)
ffffffffc0205d76:	01093423          	sd	a6,8(s2)
ffffffffc0205d7a:	00f93823          	sd	a5,16(s2)
ffffffffc0205d7e:	01283023          	sd	s2,0(a6)
ffffffffc0205d82:	bf0ff06f          	j	ffffffffc0205172 <stride_dequeue+0x164>
ffffffffc0205d86:	008cb783          	ld	a5,8(s9)
ffffffffc0205d8a:	010cb983          	ld	s3,16(s9)
ffffffffc0205d8e:	ec2a                	sd	a0,24(sp)
ffffffffc0205d90:	e83e                	sd	a5,16(sp)
ffffffffc0205d92:	0a098763          	beqz	s3,ffffffffc0205e40 <stride_dequeue+0xe32>
ffffffffc0205d96:	85d2                	mv	a1,s4
ffffffffc0205d98:	854e                	mv	a0,s3
ffffffffc0205d9a:	838ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205d9e:	6862                	ld	a6,24(sp)
ffffffffc0205da0:	3b050fe3          	beq	a0,a6,ffffffffc020695e <stride_dequeue+0x1950>
ffffffffc0205da4:	008a3783          	ld	a5,8(s4)
ffffffffc0205da8:	010a3303          	ld	t1,16(s4)
ffffffffc0205dac:	f042                	sd	a6,32(sp)
ffffffffc0205dae:	ec3e                	sd	a5,24(sp)
ffffffffc0205db0:	08030163          	beqz	t1,ffffffffc0205e32 <stride_dequeue+0xe24>
ffffffffc0205db4:	859a                	mv	a1,t1
ffffffffc0205db6:	854e                	mv	a0,s3
ffffffffc0205db8:	f41a                	sd	t1,40(sp)
ffffffffc0205dba:	818ff0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205dbe:	7802                	ld	a6,32(sp)
ffffffffc0205dc0:	7322                	ld	t1,40(sp)
ffffffffc0205dc2:	01051463          	bne	a0,a6,ffffffffc0205dca <stride_dequeue+0xdbc>
ffffffffc0205dc6:	3da0106f          	j	ffffffffc02071a0 <stride_dequeue+0x2192>
ffffffffc0205dca:	00833783          	ld	a5,8(t1)
ffffffffc0205dce:	01033e03          	ld	t3,16(t1)
ffffffffc0205dd2:	fc42                	sd	a6,56(sp)
ffffffffc0205dd4:	f03e                	sd	a5,32(sp)
ffffffffc0205dd6:	040e0663          	beqz	t3,ffffffffc0205e22 <stride_dequeue+0xe14>
ffffffffc0205dda:	85f2                	mv	a1,t3
ffffffffc0205ddc:	854e                	mv	a0,s3
ffffffffc0205dde:	f81a                	sd	t1,48(sp)
ffffffffc0205de0:	f472                	sd	t3,40(sp)
ffffffffc0205de2:	ff1fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205de6:	7862                	ld	a6,56(sp)
ffffffffc0205de8:	7e22                	ld	t3,40(sp)
ffffffffc0205dea:	7342                	ld	t1,48(sp)
ffffffffc0205dec:	01051463          	bne	a0,a6,ffffffffc0205df4 <stride_dequeue+0xde6>
ffffffffc0205df0:	0c90106f          	j	ffffffffc02076b8 <stride_dequeue+0x26aa>
ffffffffc0205df4:	010e3583          	ld	a1,16(t3)
ffffffffc0205df8:	854e                	mv	a0,s3
ffffffffc0205dfa:	008e3b03          	ld	s6,8(t3)
ffffffffc0205dfe:	f81a                	sd	t1,48(sp)
ffffffffc0205e00:	f472                	sd	t3,40(sp)
ffffffffc0205e02:	82cff0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0205e06:	7e22                	ld	t3,40(sp)
ffffffffc0205e08:	7342                	ld	t1,48(sp)
ffffffffc0205e0a:	016e3823          	sd	s6,16(t3)
ffffffffc0205e0e:	00ae3423          	sd	a0,8(t3)
ffffffffc0205e12:	010c2b03          	lw	s6,16(s8)
ffffffffc0205e16:	e119                	bnez	a0,ffffffffc0205e1c <stride_dequeue+0xe0e>
ffffffffc0205e18:	32d0106f          	j	ffffffffc0207944 <stride_dequeue+0x2936>
ffffffffc0205e1c:	01c53023          	sd	t3,0(a0)
ffffffffc0205e20:	89f2                	mv	s3,t3
ffffffffc0205e22:	7782                	ld	a5,32(sp)
ffffffffc0205e24:	01333423          	sd	s3,8(t1)
ffffffffc0205e28:	00f33823          	sd	a5,16(t1)
ffffffffc0205e2c:	0069b023          	sd	t1,0(s3)
ffffffffc0205e30:	899a                	mv	s3,t1
ffffffffc0205e32:	67e2                	ld	a5,24(sp)
ffffffffc0205e34:	013a3423          	sd	s3,8(s4)
ffffffffc0205e38:	00fa3823          	sd	a5,16(s4)
ffffffffc0205e3c:	0149b023          	sd	s4,0(s3)
ffffffffc0205e40:	67c2                	ld	a5,16(sp)
ffffffffc0205e42:	014cb423          	sd	s4,8(s9)
ffffffffc0205e46:	89da                	mv	s3,s6
ffffffffc0205e48:	00fcb823          	sd	a5,16(s9)
ffffffffc0205e4c:	019a3023          	sd	s9,0(s4)
ffffffffc0205e50:	f42ff06f          	j	ffffffffc0205592 <stride_dequeue+0x584>
ffffffffc0205e54:	661c                	ld	a5,8(a2)
ffffffffc0205e56:	01063983          	ld	s3,16(a2)
ffffffffc0205e5a:	e82a                	sd	a0,16(sp)
ffffffffc0205e5c:	e43e                	sd	a5,8(sp)
ffffffffc0205e5e:	0a098f63          	beqz	s3,ffffffffc0205f1c <stride_dequeue+0xf0e>
ffffffffc0205e62:	85d2                	mv	a1,s4
ffffffffc0205e64:	854e                	mv	a0,s3
ffffffffc0205e66:	ec32                	sd	a2,24(sp)
ffffffffc0205e68:	f6bfe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205e6c:	6842                	ld	a6,16(sp)
ffffffffc0205e6e:	6662                	ld	a2,24(sp)
ffffffffc0205e70:	39050de3          	beq	a0,a6,ffffffffc0206a0a <stride_dequeue+0x19fc>
ffffffffc0205e74:	008a3783          	ld	a5,8(s4)
ffffffffc0205e78:	010a3303          	ld	t1,16(s4)
ffffffffc0205e7c:	ec42                	sd	a6,24(sp)
ffffffffc0205e7e:	e83e                	sd	a5,16(sp)
ffffffffc0205e80:	08030763          	beqz	t1,ffffffffc0205f0e <stride_dequeue+0xf00>
ffffffffc0205e84:	859a                	mv	a1,t1
ffffffffc0205e86:	854e                	mv	a0,s3
ffffffffc0205e88:	f432                	sd	a2,40(sp)
ffffffffc0205e8a:	f01a                	sd	t1,32(sp)
ffffffffc0205e8c:	f47fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205e90:	6862                	ld	a6,24(sp)
ffffffffc0205e92:	7302                	ld	t1,32(sp)
ffffffffc0205e94:	7622                	ld	a2,40(sp)
ffffffffc0205e96:	01051463          	bne	a0,a6,ffffffffc0205e9e <stride_dequeue+0xe90>
ffffffffc0205e9a:	5060106f          	j	ffffffffc02073a0 <stride_dequeue+0x2392>
ffffffffc0205e9e:	00833783          	ld	a5,8(t1)
ffffffffc0205ea2:	01033e03          	ld	t3,16(t1)
ffffffffc0205ea6:	fc42                	sd	a6,56(sp)
ffffffffc0205ea8:	ec3e                	sd	a5,24(sp)
ffffffffc0205eaa:	040e0a63          	beqz	t3,ffffffffc0205efe <stride_dequeue+0xef0>
ffffffffc0205eae:	85f2                	mv	a1,t3
ffffffffc0205eb0:	854e                	mv	a0,s3
ffffffffc0205eb2:	f81a                	sd	t1,48(sp)
ffffffffc0205eb4:	f432                	sd	a2,40(sp)
ffffffffc0205eb6:	f072                	sd	t3,32(sp)
ffffffffc0205eb8:	f1bfe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205ebc:	7862                	ld	a6,56(sp)
ffffffffc0205ebe:	7e02                	ld	t3,32(sp)
ffffffffc0205ec0:	7622                	ld	a2,40(sp)
ffffffffc0205ec2:	7342                	ld	t1,48(sp)
ffffffffc0205ec4:	01051463          	bne	a0,a6,ffffffffc0205ecc <stride_dequeue+0xebe>
ffffffffc0205ec8:	1e10106f          	j	ffffffffc02078a8 <stride_dequeue+0x289a>
ffffffffc0205ecc:	010e3583          	ld	a1,16(t3)
ffffffffc0205ed0:	854e                	mv	a0,s3
ffffffffc0205ed2:	008e3b03          	ld	s6,8(t3)
ffffffffc0205ed6:	f81a                	sd	t1,48(sp)
ffffffffc0205ed8:	f432                	sd	a2,40(sp)
ffffffffc0205eda:	f072                	sd	t3,32(sp)
ffffffffc0205edc:	f53fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0205ee0:	7e02                	ld	t3,32(sp)
ffffffffc0205ee2:	7622                	ld	a2,40(sp)
ffffffffc0205ee4:	7342                	ld	t1,48(sp)
ffffffffc0205ee6:	016e3823          	sd	s6,16(t3)
ffffffffc0205eea:	00ae3423          	sd	a0,8(t3)
ffffffffc0205eee:	010c2b03          	lw	s6,16(s8)
ffffffffc0205ef2:	e119                	bnez	a0,ffffffffc0205ef8 <stride_dequeue+0xeea>
ffffffffc0205ef4:	22d0106f          	j	ffffffffc0207920 <stride_dequeue+0x2912>
ffffffffc0205ef8:	01c53023          	sd	t3,0(a0)
ffffffffc0205efc:	89f2                	mv	s3,t3
ffffffffc0205efe:	67e2                	ld	a5,24(sp)
ffffffffc0205f00:	01333423          	sd	s3,8(t1)
ffffffffc0205f04:	00f33823          	sd	a5,16(t1)
ffffffffc0205f08:	0069b023          	sd	t1,0(s3)
ffffffffc0205f0c:	899a                	mv	s3,t1
ffffffffc0205f0e:	67c2                	ld	a5,16(sp)
ffffffffc0205f10:	013a3423          	sd	s3,8(s4)
ffffffffc0205f14:	00fa3823          	sd	a5,16(s4)
ffffffffc0205f18:	0149b023          	sd	s4,0(s3)
ffffffffc0205f1c:	67a2                	ld	a5,8(sp)
ffffffffc0205f1e:	01463423          	sd	s4,8(a2)
ffffffffc0205f22:	89da                	mv	s3,s6
ffffffffc0205f24:	ea1c                	sd	a5,16(a2)
ffffffffc0205f26:	00ca3023          	sd	a2,0(s4)
ffffffffc0205f2a:	8a32                	mv	s4,a2
ffffffffc0205f2c:	f80ff06f          	j	ffffffffc02056ac <stride_dequeue+0x69e>
ffffffffc0205f30:	008a3783          	ld	a5,8(s4)
ffffffffc0205f34:	010a3983          	ld	s3,16(s4)
ffffffffc0205f38:	ec2a                	sd	a0,24(sp)
ffffffffc0205f3a:	e83e                	sd	a5,16(sp)
ffffffffc0205f3c:	0a098763          	beqz	s3,ffffffffc0205fea <stride_dequeue+0xfdc>
ffffffffc0205f40:	85e6                	mv	a1,s9
ffffffffc0205f42:	854e                	mv	a0,s3
ffffffffc0205f44:	e8ffe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205f48:	6862                	ld	a6,24(sp)
ffffffffc0205f4a:	270505e3          	beq	a0,a6,ffffffffc02069b4 <stride_dequeue+0x19a6>
ffffffffc0205f4e:	008cb783          	ld	a5,8(s9)
ffffffffc0205f52:	010cb303          	ld	t1,16(s9)
ffffffffc0205f56:	f042                	sd	a6,32(sp)
ffffffffc0205f58:	ec3e                	sd	a5,24(sp)
ffffffffc0205f5a:	08030163          	beqz	t1,ffffffffc0205fdc <stride_dequeue+0xfce>
ffffffffc0205f5e:	859a                	mv	a1,t1
ffffffffc0205f60:	854e                	mv	a0,s3
ffffffffc0205f62:	f41a                	sd	t1,40(sp)
ffffffffc0205f64:	e6ffe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205f68:	7802                	ld	a6,32(sp)
ffffffffc0205f6a:	7322                	ld	t1,40(sp)
ffffffffc0205f6c:	01051463          	bne	a0,a6,ffffffffc0205f74 <stride_dequeue+0xf66>
ffffffffc0205f70:	4080106f          	j	ffffffffc0207378 <stride_dequeue+0x236a>
ffffffffc0205f74:	00833783          	ld	a5,8(t1)
ffffffffc0205f78:	01033e03          	ld	t3,16(t1)
ffffffffc0205f7c:	fc42                	sd	a6,56(sp)
ffffffffc0205f7e:	f03e                	sd	a5,32(sp)
ffffffffc0205f80:	040e0663          	beqz	t3,ffffffffc0205fcc <stride_dequeue+0xfbe>
ffffffffc0205f84:	85f2                	mv	a1,t3
ffffffffc0205f86:	854e                	mv	a0,s3
ffffffffc0205f88:	f81a                	sd	t1,48(sp)
ffffffffc0205f8a:	f472                	sd	t3,40(sp)
ffffffffc0205f8c:	e47fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0205f90:	7862                	ld	a6,56(sp)
ffffffffc0205f92:	7e22                	ld	t3,40(sp)
ffffffffc0205f94:	7342                	ld	t1,48(sp)
ffffffffc0205f96:	01051463          	bne	a0,a6,ffffffffc0205f9e <stride_dequeue+0xf90>
ffffffffc0205f9a:	6160106f          	j	ffffffffc02075b0 <stride_dequeue+0x25a2>
ffffffffc0205f9e:	010e3583          	ld	a1,16(t3)
ffffffffc0205fa2:	854e                	mv	a0,s3
ffffffffc0205fa4:	008e3b03          	ld	s6,8(t3)
ffffffffc0205fa8:	f81a                	sd	t1,48(sp)
ffffffffc0205faa:	f472                	sd	t3,40(sp)
ffffffffc0205fac:	e83fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0205fb0:	7e22                	ld	t3,40(sp)
ffffffffc0205fb2:	7342                	ld	t1,48(sp)
ffffffffc0205fb4:	016e3823          	sd	s6,16(t3)
ffffffffc0205fb8:	00ae3423          	sd	a0,8(t3)
ffffffffc0205fbc:	010c2b03          	lw	s6,16(s8)
ffffffffc0205fc0:	e119                	bnez	a0,ffffffffc0205fc6 <stride_dequeue+0xfb8>
ffffffffc0205fc2:	1b30106f          	j	ffffffffc0207974 <stride_dequeue+0x2966>
ffffffffc0205fc6:	01c53023          	sd	t3,0(a0)
ffffffffc0205fca:	89f2                	mv	s3,t3
ffffffffc0205fcc:	7782                	ld	a5,32(sp)
ffffffffc0205fce:	01333423          	sd	s3,8(t1)
ffffffffc0205fd2:	00f33823          	sd	a5,16(t1)
ffffffffc0205fd6:	0069b023          	sd	t1,0(s3)
ffffffffc0205fda:	899a                	mv	s3,t1
ffffffffc0205fdc:	67e2                	ld	a5,24(sp)
ffffffffc0205fde:	013cb423          	sd	s3,8(s9)
ffffffffc0205fe2:	00fcb823          	sd	a5,16(s9)
ffffffffc0205fe6:	0199b023          	sd	s9,0(s3)
ffffffffc0205fea:	67c2                	ld	a5,16(sp)
ffffffffc0205fec:	019a3423          	sd	s9,8(s4)
ffffffffc0205ff0:	89da                	mv	s3,s6
ffffffffc0205ff2:	00fa3823          	sd	a5,16(s4)
ffffffffc0205ff6:	014cb023          	sd	s4,0(s9)
ffffffffc0205ffa:	8cd2                	mv	s9,s4
ffffffffc0205ffc:	faeff06f          	j	ffffffffc02057aa <stride_dequeue+0x79c>
ffffffffc0206000:	0088b783          	ld	a5,8(a7)
ffffffffc0206004:	0108b983          	ld	s3,16(a7)
ffffffffc0206008:	f02a                	sd	a0,32(sp)
ffffffffc020600a:	ec3e                	sd	a5,24(sp)
ffffffffc020600c:	06098e63          	beqz	s3,ffffffffc0206088 <stride_dequeue+0x107a>
ffffffffc0206010:	85e6                	mv	a1,s9
ffffffffc0206012:	854e                	mv	a0,s3
ffffffffc0206014:	f446                	sd	a7,40(sp)
ffffffffc0206016:	dbdfe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc020601a:	7302                	ld	t1,32(sp)
ffffffffc020601c:	78a2                	ld	a7,40(sp)
ffffffffc020601e:	486503e3          	beq	a0,t1,ffffffffc0206ca4 <stride_dequeue+0x1c96>
ffffffffc0206022:	008cb783          	ld	a5,8(s9)
ffffffffc0206026:	010cbe03          	ld	t3,16(s9)
ffffffffc020602a:	f41a                	sd	t1,40(sp)
ffffffffc020602c:	f03e                	sd	a5,32(sp)
ffffffffc020602e:	040e0663          	beqz	t3,ffffffffc020607a <stride_dequeue+0x106c>
ffffffffc0206032:	85f2                	mv	a1,t3
ffffffffc0206034:	854e                	mv	a0,s3
ffffffffc0206036:	fc46                	sd	a7,56(sp)
ffffffffc0206038:	f872                	sd	t3,48(sp)
ffffffffc020603a:	d99fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc020603e:	7322                	ld	t1,40(sp)
ffffffffc0206040:	7e42                	ld	t3,48(sp)
ffffffffc0206042:	78e2                	ld	a7,56(sp)
ffffffffc0206044:	00651463          	bne	a0,t1,ffffffffc020604c <stride_dequeue+0x103e>
ffffffffc0206048:	3040106f          	j	ffffffffc020734c <stride_dequeue+0x233e>
ffffffffc020604c:	010e3583          	ld	a1,16(t3)
ffffffffc0206050:	854e                	mv	a0,s3
ffffffffc0206052:	008e3b03          	ld	s6,8(t3)
ffffffffc0206056:	f846                	sd	a7,48(sp)
ffffffffc0206058:	f472                	sd	t3,40(sp)
ffffffffc020605a:	dd5fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc020605e:	7e22                	ld	t3,40(sp)
ffffffffc0206060:	78c2                	ld	a7,48(sp)
ffffffffc0206062:	016e3823          	sd	s6,16(t3)
ffffffffc0206066:	00ae3423          	sd	a0,8(t3)
ffffffffc020606a:	010c2b03          	lw	s6,16(s8)
ffffffffc020606e:	e119                	bnez	a0,ffffffffc0206074 <stride_dequeue+0x1066>
ffffffffc0206070:	4540106f          	j	ffffffffc02074c4 <stride_dequeue+0x24b6>
ffffffffc0206074:	01c53023          	sd	t3,0(a0)
ffffffffc0206078:	89f2                	mv	s3,t3
ffffffffc020607a:	7782                	ld	a5,32(sp)
ffffffffc020607c:	013cb423          	sd	s3,8(s9)
ffffffffc0206080:	00fcb823          	sd	a5,16(s9)
ffffffffc0206084:	0199b023          	sd	s9,0(s3)
ffffffffc0206088:	67e2                	ld	a5,24(sp)
ffffffffc020608a:	0198b423          	sd	s9,8(a7)
ffffffffc020608e:	89da                	mv	s3,s6
ffffffffc0206090:	00f8b823          	sd	a5,16(a7)
ffffffffc0206094:	011cb023          	sd	a7,0(s9)
ffffffffc0206098:	8cc6                	mv	s9,a7
ffffffffc020609a:	fdeff06f          	j	ffffffffc0205878 <stride_dequeue+0x86a>
ffffffffc020609e:	008cb783          	ld	a5,8(s9)
ffffffffc02060a2:	010cb983          	ld	s3,16(s9)
ffffffffc02060a6:	f02a                	sd	a0,32(sp)
ffffffffc02060a8:	ec3e                	sd	a5,24(sp)
ffffffffc02060aa:	06098e63          	beqz	s3,ffffffffc0206126 <stride_dequeue+0x1118>
ffffffffc02060ae:	85c2                	mv	a1,a6
ffffffffc02060b0:	854e                	mv	a0,s3
ffffffffc02060b2:	f442                	sd	a6,40(sp)
ffffffffc02060b4:	d1ffe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02060b8:	7302                	ld	t1,32(sp)
ffffffffc02060ba:	7822                	ld	a6,40(sp)
ffffffffc02060bc:	446506e3          	beq	a0,t1,ffffffffc0206d08 <stride_dequeue+0x1cfa>
ffffffffc02060c0:	00883783          	ld	a5,8(a6)
ffffffffc02060c4:	01083e03          	ld	t3,16(a6)
ffffffffc02060c8:	f41a                	sd	t1,40(sp)
ffffffffc02060ca:	f03e                	sd	a5,32(sp)
ffffffffc02060cc:	040e0663          	beqz	t3,ffffffffc0206118 <stride_dequeue+0x110a>
ffffffffc02060d0:	85f2                	mv	a1,t3
ffffffffc02060d2:	854e                	mv	a0,s3
ffffffffc02060d4:	fc42                	sd	a6,56(sp)
ffffffffc02060d6:	f872                	sd	t3,48(sp)
ffffffffc02060d8:	cfbfe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02060dc:	7322                	ld	t1,40(sp)
ffffffffc02060de:	7e42                	ld	t3,48(sp)
ffffffffc02060e0:	7862                	ld	a6,56(sp)
ffffffffc02060e2:	00651463          	bne	a0,t1,ffffffffc02060ea <stride_dequeue+0x10dc>
ffffffffc02060e6:	20e0106f          	j	ffffffffc02072f4 <stride_dequeue+0x22e6>
ffffffffc02060ea:	010e3583          	ld	a1,16(t3)
ffffffffc02060ee:	854e                	mv	a0,s3
ffffffffc02060f0:	008e3b03          	ld	s6,8(t3)
ffffffffc02060f4:	f842                	sd	a6,48(sp)
ffffffffc02060f6:	f472                	sd	t3,40(sp)
ffffffffc02060f8:	d37fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02060fc:	7e22                	ld	t3,40(sp)
ffffffffc02060fe:	7842                	ld	a6,48(sp)
ffffffffc0206100:	016e3823          	sd	s6,16(t3)
ffffffffc0206104:	00ae3423          	sd	a0,8(t3)
ffffffffc0206108:	010c2b03          	lw	s6,16(s8)
ffffffffc020610c:	e119                	bnez	a0,ffffffffc0206112 <stride_dequeue+0x1104>
ffffffffc020610e:	3c80106f          	j	ffffffffc02074d6 <stride_dequeue+0x24c8>
ffffffffc0206112:	01c53023          	sd	t3,0(a0)
ffffffffc0206116:	89f2                	mv	s3,t3
ffffffffc0206118:	7782                	ld	a5,32(sp)
ffffffffc020611a:	01383423          	sd	s3,8(a6)
ffffffffc020611e:	00f83823          	sd	a5,16(a6)
ffffffffc0206122:	0109b023          	sd	a6,0(s3)
ffffffffc0206126:	67e2                	ld	a5,24(sp)
ffffffffc0206128:	010cb423          	sd	a6,8(s9)
ffffffffc020612c:	89da                	mv	s3,s6
ffffffffc020612e:	00fcb823          	sd	a5,16(s9)
ffffffffc0206132:	01983023          	sd	s9,0(a6)
ffffffffc0206136:	829ff06f          	j	ffffffffc020595e <stride_dequeue+0x950>
ffffffffc020613a:	008db783          	ld	a5,8(s11)
ffffffffc020613e:	010db983          	ld	s3,16(s11)
ffffffffc0206142:	f02a                	sd	a0,32(sp)
ffffffffc0206144:	ec3e                	sd	a5,24(sp)
ffffffffc0206146:	06098e63          	beqz	s3,ffffffffc02061c2 <stride_dequeue+0x11b4>
ffffffffc020614a:	85c2                	mv	a1,a6
ffffffffc020614c:	854e                	mv	a0,s3
ffffffffc020614e:	f442                	sd	a6,40(sp)
ffffffffc0206150:	c83fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206154:	7302                	ld	t1,32(sp)
ffffffffc0206156:	7822                	ld	a6,40(sp)
ffffffffc0206158:	466506e3          	beq	a0,t1,ffffffffc0206dc4 <stride_dequeue+0x1db6>
ffffffffc020615c:	00883783          	ld	a5,8(a6)
ffffffffc0206160:	01083e03          	ld	t3,16(a6)
ffffffffc0206164:	f41a                	sd	t1,40(sp)
ffffffffc0206166:	f03e                	sd	a5,32(sp)
ffffffffc0206168:	040e0663          	beqz	t3,ffffffffc02061b4 <stride_dequeue+0x11a6>
ffffffffc020616c:	85f2                	mv	a1,t3
ffffffffc020616e:	854e                	mv	a0,s3
ffffffffc0206170:	fc42                	sd	a6,56(sp)
ffffffffc0206172:	f872                	sd	t3,48(sp)
ffffffffc0206174:	c5ffe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206178:	7322                	ld	t1,40(sp)
ffffffffc020617a:	7e42                	ld	t3,48(sp)
ffffffffc020617c:	7862                	ld	a6,56(sp)
ffffffffc020617e:	00651463          	bne	a0,t1,ffffffffc0206186 <stride_dequeue+0x1178>
ffffffffc0206182:	7490006f          	j	ffffffffc02070ca <stride_dequeue+0x20bc>
ffffffffc0206186:	010e3583          	ld	a1,16(t3)
ffffffffc020618a:	854e                	mv	a0,s3
ffffffffc020618c:	008e3b03          	ld	s6,8(t3)
ffffffffc0206190:	f842                	sd	a6,48(sp)
ffffffffc0206192:	f472                	sd	t3,40(sp)
ffffffffc0206194:	c9bfe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206198:	7e22                	ld	t3,40(sp)
ffffffffc020619a:	7842                	ld	a6,48(sp)
ffffffffc020619c:	016e3823          	sd	s6,16(t3)
ffffffffc02061a0:	00ae3423          	sd	a0,8(t3)
ffffffffc02061a4:	010c2b03          	lw	s6,16(s8)
ffffffffc02061a8:	e119                	bnez	a0,ffffffffc02061ae <stride_dequeue+0x11a0>
ffffffffc02061aa:	3260106f          	j	ffffffffc02074d0 <stride_dequeue+0x24c2>
ffffffffc02061ae:	01c53023          	sd	t3,0(a0)
ffffffffc02061b2:	89f2                	mv	s3,t3
ffffffffc02061b4:	7782                	ld	a5,32(sp)
ffffffffc02061b6:	01383423          	sd	s3,8(a6)
ffffffffc02061ba:	00f83823          	sd	a5,16(a6)
ffffffffc02061be:	0109b023          	sd	a6,0(s3)
ffffffffc02061c2:	67e2                	ld	a5,24(sp)
ffffffffc02061c4:	010db423          	sd	a6,8(s11)
ffffffffc02061c8:	89da                	mv	s3,s6
ffffffffc02061ca:	00fdb823          	sd	a5,16(s11)
ffffffffc02061ce:	01b83023          	sd	s11,0(a6)
ffffffffc02061d2:	92aff06f          	j	ffffffffc02052fc <stride_dequeue+0x2ee>
ffffffffc02061d6:	008db783          	ld	a5,8(s11)
ffffffffc02061da:	010db983          	ld	s3,16(s11)
ffffffffc02061de:	ec2a                	sd	a0,24(sp)
ffffffffc02061e0:	e83e                	sd	a5,16(sp)
ffffffffc02061e2:	08098263          	beqz	s3,ffffffffc0206266 <stride_dequeue+0x1258>
ffffffffc02061e6:	85c2                	mv	a1,a6
ffffffffc02061e8:	854e                	mv	a0,s3
ffffffffc02061ea:	f432                	sd	a2,40(sp)
ffffffffc02061ec:	f042                	sd	a6,32(sp)
ffffffffc02061ee:	be5fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02061f2:	6362                	ld	t1,24(sp)
ffffffffc02061f4:	7802                	ld	a6,32(sp)
ffffffffc02061f6:	7622                	ld	a2,40(sp)
ffffffffc02061f8:	426505e3          	beq	a0,t1,ffffffffc0206e22 <stride_dequeue+0x1e14>
ffffffffc02061fc:	00883783          	ld	a5,8(a6)
ffffffffc0206200:	01083e03          	ld	t3,16(a6)
ffffffffc0206204:	f01a                	sd	t1,32(sp)
ffffffffc0206206:	ec3e                	sd	a5,24(sp)
ffffffffc0206208:	040e0863          	beqz	t3,ffffffffc0206258 <stride_dequeue+0x124a>
ffffffffc020620c:	85f2                	mv	a1,t3
ffffffffc020620e:	854e                	mv	a0,s3
ffffffffc0206210:	fc42                	sd	a6,56(sp)
ffffffffc0206212:	f832                	sd	a2,48(sp)
ffffffffc0206214:	f472                	sd	t3,40(sp)
ffffffffc0206216:	bbdfe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc020621a:	7302                	ld	t1,32(sp)
ffffffffc020621c:	7e22                	ld	t3,40(sp)
ffffffffc020621e:	7642                	ld	a2,48(sp)
ffffffffc0206220:	7862                	ld	a6,56(sp)
ffffffffc0206222:	60650fe3          	beq	a0,t1,ffffffffc0207040 <stride_dequeue+0x2032>
ffffffffc0206226:	010e3583          	ld	a1,16(t3)
ffffffffc020622a:	854e                	mv	a0,s3
ffffffffc020622c:	008e3b03          	ld	s6,8(t3)
ffffffffc0206230:	f842                	sd	a6,48(sp)
ffffffffc0206232:	f432                	sd	a2,40(sp)
ffffffffc0206234:	f072                	sd	t3,32(sp)
ffffffffc0206236:	bf9fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc020623a:	7e02                	ld	t3,32(sp)
ffffffffc020623c:	7622                	ld	a2,40(sp)
ffffffffc020623e:	7842                	ld	a6,48(sp)
ffffffffc0206240:	016e3823          	sd	s6,16(t3)
ffffffffc0206244:	00ae3423          	sd	a0,8(t3)
ffffffffc0206248:	010c2b03          	lw	s6,16(s8)
ffffffffc020624c:	e119                	bnez	a0,ffffffffc0206252 <stride_dequeue+0x1244>
ffffffffc020624e:	2d60106f          	j	ffffffffc0207524 <stride_dequeue+0x2516>
ffffffffc0206252:	01c53023          	sd	t3,0(a0)
ffffffffc0206256:	89f2                	mv	s3,t3
ffffffffc0206258:	67e2                	ld	a5,24(sp)
ffffffffc020625a:	01383423          	sd	s3,8(a6)
ffffffffc020625e:	00f83823          	sd	a5,16(a6)
ffffffffc0206262:	0109b023          	sd	a6,0(s3)
ffffffffc0206266:	67c2                	ld	a5,16(sp)
ffffffffc0206268:	010db423          	sd	a6,8(s11)
ffffffffc020626c:	89da                	mv	s3,s6
ffffffffc020626e:	00fdb823          	sd	a5,16(s11)
ffffffffc0206272:	01b83023          	sd	s11,0(a6)
ffffffffc0206276:	9e0ff06f          	j	ffffffffc0205456 <stride_dequeue+0x448>
ffffffffc020627a:	00893703          	ld	a4,8(s2)
ffffffffc020627e:	01093983          	ld	s3,16(s2)
ffffffffc0206282:	f42a                	sd	a0,40(sp)
ffffffffc0206284:	f03a                	sd	a4,32(sp)
ffffffffc0206286:	02098e63          	beqz	s3,ffffffffc02062c2 <stride_dequeue+0x12b4>
ffffffffc020628a:	85be                	mv	a1,a5
ffffffffc020628c:	854e                	mv	a0,s3
ffffffffc020628e:	fc42                	sd	a6,56(sp)
ffffffffc0206290:	f83e                	sd	a5,48(sp)
ffffffffc0206292:	b41fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206296:	7e22                	ld	t3,40(sp)
ffffffffc0206298:	77c2                	ld	a5,48(sp)
ffffffffc020629a:	7862                	ld	a6,56(sp)
ffffffffc020629c:	43c509e3          	beq	a0,t3,ffffffffc0206ece <stride_dequeue+0x1ec0>
ffffffffc02062a0:	6b8c                	ld	a1,16(a5)
ffffffffc02062a2:	854e                	mv	a0,s3
ffffffffc02062a4:	0087bb03          	ld	s6,8(a5)
ffffffffc02062a8:	f842                	sd	a6,48(sp)
ffffffffc02062aa:	f43e                	sd	a5,40(sp)
ffffffffc02062ac:	b83fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02062b0:	77a2                	ld	a5,40(sp)
ffffffffc02062b2:	7842                	ld	a6,48(sp)
ffffffffc02062b4:	0167b823          	sd	s6,16(a5)
ffffffffc02062b8:	e788                	sd	a0,8(a5)
ffffffffc02062ba:	010c2b03          	lw	s6,16(s8)
ffffffffc02062be:	c111                	beqz	a0,ffffffffc02062c2 <stride_dequeue+0x12b4>
ffffffffc02062c0:	e11c                	sd	a5,0(a0)
ffffffffc02062c2:	7702                	ld	a4,32(sp)
ffffffffc02062c4:	00f93423          	sd	a5,8(s2)
ffffffffc02062c8:	89da                	mv	s3,s6
ffffffffc02062ca:	00e93823          	sd	a4,16(s2)
ffffffffc02062ce:	0127b023          	sd	s2,0(a5)
ffffffffc02062d2:	e91fe06f          	j	ffffffffc0205162 <stride_dequeue+0x154>
ffffffffc02062d6:	008a3783          	ld	a5,8(s4)
ffffffffc02062da:	010a3983          	ld	s3,16(s4)
ffffffffc02062de:	ec2a                	sd	a0,24(sp)
ffffffffc02062e0:	e83e                	sd	a5,16(sp)
ffffffffc02062e2:	5a098ce3          	beqz	s3,ffffffffc020709a <stride_dequeue+0x208c>
ffffffffc02062e6:	85a6                	mv	a1,s1
ffffffffc02062e8:	854e                	mv	a0,s3
ffffffffc02062ea:	ae9fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02062ee:	67e2                	ld	a5,24(sp)
ffffffffc02062f0:	50f500e3          	beq	a0,a5,ffffffffc0206ff0 <stride_dequeue+0x1fe2>
ffffffffc02062f4:	f43e                	sd	a5,40(sp)
ffffffffc02062f6:	649c                	ld	a5,8(s1)
ffffffffc02062f8:	0104b883          	ld	a7,16(s1)
ffffffffc02062fc:	ec3e                	sd	a5,24(sp)
ffffffffc02062fe:	04088263          	beqz	a7,ffffffffc0206342 <stride_dequeue+0x1334>
ffffffffc0206302:	85c6                	mv	a1,a7
ffffffffc0206304:	854e                	mv	a0,s3
ffffffffc0206306:	f046                	sd	a7,32(sp)
ffffffffc0206308:	acbfe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc020630c:	77a2                	ld	a5,40(sp)
ffffffffc020630e:	7882                	ld	a7,32(sp)
ffffffffc0206310:	00f51463          	bne	a0,a5,ffffffffc0206318 <stride_dequeue+0x130a>
ffffffffc0206314:	2160106f          	j	ffffffffc020752a <stride_dequeue+0x251c>
ffffffffc0206318:	0108b583          	ld	a1,16(a7)
ffffffffc020631c:	854e                	mv	a0,s3
ffffffffc020631e:	0088bb03          	ld	s6,8(a7)
ffffffffc0206322:	f046                	sd	a7,32(sp)
ffffffffc0206324:	b0bfe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206328:	7882                	ld	a7,32(sp)
ffffffffc020632a:	0168b823          	sd	s6,16(a7)
ffffffffc020632e:	00a8b423          	sd	a0,8(a7)
ffffffffc0206332:	010c2b03          	lw	s6,16(s8)
ffffffffc0206336:	e119                	bnez	a0,ffffffffc020633c <stride_dequeue+0x132e>
ffffffffc0206338:	56a0106f          	j	ffffffffc02078a2 <stride_dequeue+0x2894>
ffffffffc020633c:	01153023          	sd	a7,0(a0)
ffffffffc0206340:	89c6                	mv	s3,a7
ffffffffc0206342:	67e2                	ld	a5,24(sp)
ffffffffc0206344:	0134b423          	sd	s3,8(s1)
ffffffffc0206348:	e89c                	sd	a5,16(s1)
ffffffffc020634a:	0099b023          	sd	s1,0(s3)
ffffffffc020634e:	89a6                	mv	s3,s1
ffffffffc0206350:	67c2                	ld	a5,16(sp)
ffffffffc0206352:	013a3423          	sd	s3,8(s4)
ffffffffc0206356:	84d2                	mv	s1,s4
ffffffffc0206358:	00fa3823          	sd	a5,16(s4)
ffffffffc020635c:	0149b023          	sd	s4,0(s3)
ffffffffc0206360:	89da                	mv	s3,s6
ffffffffc0206362:	f00ff06f          	j	ffffffffc0205a62 <stride_dequeue+0xa54>
ffffffffc0206366:	0088b783          	ld	a5,8(a7)
ffffffffc020636a:	0108b983          	ld	s3,16(a7)
ffffffffc020636e:	f02a                	sd	a0,32(sp)
ffffffffc0206370:	ec3e                	sd	a5,24(sp)
ffffffffc0206372:	00099463          	bnez	s3,ffffffffc020637a <stride_dequeue+0x136c>
ffffffffc0206376:	0d40106f          	j	ffffffffc020744a <stride_dequeue+0x243c>
ffffffffc020637a:	85d2                	mv	a1,s4
ffffffffc020637c:	854e                	mv	a0,s3
ffffffffc020637e:	f446                	sd	a7,40(sp)
ffffffffc0206380:	a53fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206384:	7302                	ld	t1,32(sp)
ffffffffc0206386:	78a2                	ld	a7,40(sp)
ffffffffc0206388:	00651463          	bne	a0,t1,ffffffffc0206390 <stride_dequeue+0x1382>
ffffffffc020638c:	06c0106f          	j	ffffffffc02073f8 <stride_dequeue+0x23ea>
ffffffffc0206390:	008a3783          	ld	a5,8(s4)
ffffffffc0206394:	010a3e03          	ld	t3,16(s4)
ffffffffc0206398:	fc1a                	sd	t1,56(sp)
ffffffffc020639a:	f03e                	sd	a5,32(sp)
ffffffffc020639c:	040e0663          	beqz	t3,ffffffffc02063e8 <stride_dequeue+0x13da>
ffffffffc02063a0:	85f2                	mv	a1,t3
ffffffffc02063a2:	854e                	mv	a0,s3
ffffffffc02063a4:	f846                	sd	a7,48(sp)
ffffffffc02063a6:	f472                	sd	t3,40(sp)
ffffffffc02063a8:	a2bfe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02063ac:	7362                	ld	t1,56(sp)
ffffffffc02063ae:	7e22                	ld	t3,40(sp)
ffffffffc02063b0:	78c2                	ld	a7,48(sp)
ffffffffc02063b2:	00651463          	bne	a0,t1,ffffffffc02063ba <stride_dequeue+0x13ac>
ffffffffc02063b6:	32e0106f          	j	ffffffffc02076e4 <stride_dequeue+0x26d6>
ffffffffc02063ba:	010e3583          	ld	a1,16(t3)
ffffffffc02063be:	854e                	mv	a0,s3
ffffffffc02063c0:	008e3b03          	ld	s6,8(t3)
ffffffffc02063c4:	f846                	sd	a7,48(sp)
ffffffffc02063c6:	f472                	sd	t3,40(sp)
ffffffffc02063c8:	a67fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02063cc:	7e22                	ld	t3,40(sp)
ffffffffc02063ce:	78c2                	ld	a7,48(sp)
ffffffffc02063d0:	016e3823          	sd	s6,16(t3)
ffffffffc02063d4:	00ae3423          	sd	a0,8(t3)
ffffffffc02063d8:	010c2b03          	lw	s6,16(s8)
ffffffffc02063dc:	e119                	bnez	a0,ffffffffc02063e2 <stride_dequeue+0x13d4>
ffffffffc02063de:	58a0106f          	j	ffffffffc0207968 <stride_dequeue+0x295a>
ffffffffc02063e2:	01c53023          	sd	t3,0(a0)
ffffffffc02063e6:	89f2                	mv	s3,t3
ffffffffc02063e8:	7782                	ld	a5,32(sp)
ffffffffc02063ea:	013a3423          	sd	s3,8(s4)
ffffffffc02063ee:	00fa3823          	sd	a5,16(s4)
ffffffffc02063f2:	0149b023          	sd	s4,0(s3)
ffffffffc02063f6:	89d2                	mv	s3,s4
ffffffffc02063f8:	67e2                	ld	a5,24(sp)
ffffffffc02063fa:	0138b423          	sd	s3,8(a7)
ffffffffc02063fe:	8a46                	mv	s4,a7
ffffffffc0206400:	00f8b823          	sd	a5,16(a7)
ffffffffc0206404:	0119b023          	sd	a7,0(s3)
ffffffffc0206408:	89da                	mv	s3,s6
ffffffffc020640a:	f28ff06f          	j	ffffffffc0205b32 <stride_dequeue+0xb24>
ffffffffc020640e:	0088b783          	ld	a5,8(a7)
ffffffffc0206412:	0108b983          	ld	s3,16(a7)
ffffffffc0206416:	f02a                	sd	a0,32(sp)
ffffffffc0206418:	ec3e                	sd	a5,24(sp)
ffffffffc020641a:	00099463          	bnez	s3,ffffffffc0206422 <stride_dequeue+0x1414>
ffffffffc020641e:	0320106f          	j	ffffffffc0207450 <stride_dequeue+0x2442>
ffffffffc0206422:	85ee                	mv	a1,s11
ffffffffc0206424:	854e                	mv	a0,s3
ffffffffc0206426:	f446                	sd	a7,40(sp)
ffffffffc0206428:	9abfe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc020642c:	7302                	ld	t1,32(sp)
ffffffffc020642e:	78a2                	ld	a7,40(sp)
ffffffffc0206430:	466508e3          	beq	a0,t1,ffffffffc02070a0 <stride_dequeue+0x2092>
ffffffffc0206434:	008db783          	ld	a5,8(s11)
ffffffffc0206438:	010dbe03          	ld	t3,16(s11)
ffffffffc020643c:	fc1a                	sd	t1,56(sp)
ffffffffc020643e:	f03e                	sd	a5,32(sp)
ffffffffc0206440:	040e0663          	beqz	t3,ffffffffc020648c <stride_dequeue+0x147e>
ffffffffc0206444:	85f2                	mv	a1,t3
ffffffffc0206446:	854e                	mv	a0,s3
ffffffffc0206448:	f846                	sd	a7,48(sp)
ffffffffc020644a:	f472                	sd	t3,40(sp)
ffffffffc020644c:	987fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206450:	7362                	ld	t1,56(sp)
ffffffffc0206452:	7e22                	ld	t3,40(sp)
ffffffffc0206454:	78c2                	ld	a7,48(sp)
ffffffffc0206456:	00651463          	bne	a0,t1,ffffffffc020645e <stride_dequeue+0x1450>
ffffffffc020645a:	3120106f          	j	ffffffffc020776c <stride_dequeue+0x275e>
ffffffffc020645e:	010e3583          	ld	a1,16(t3)
ffffffffc0206462:	854e                	mv	a0,s3
ffffffffc0206464:	008e3b03          	ld	s6,8(t3)
ffffffffc0206468:	f846                	sd	a7,48(sp)
ffffffffc020646a:	f472                	sd	t3,40(sp)
ffffffffc020646c:	9c3fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206470:	7e22                	ld	t3,40(sp)
ffffffffc0206472:	78c2                	ld	a7,48(sp)
ffffffffc0206474:	016e3823          	sd	s6,16(t3)
ffffffffc0206478:	00ae3423          	sd	a0,8(t3)
ffffffffc020647c:	010c2b03          	lw	s6,16(s8)
ffffffffc0206480:	e119                	bnez	a0,ffffffffc0206486 <stride_dequeue+0x1478>
ffffffffc0206482:	51c0106f          	j	ffffffffc020799e <stride_dequeue+0x2990>
ffffffffc0206486:	01c53023          	sd	t3,0(a0)
ffffffffc020648a:	89f2                	mv	s3,t3
ffffffffc020648c:	7782                	ld	a5,32(sp)
ffffffffc020648e:	013db423          	sd	s3,8(s11)
ffffffffc0206492:	00fdb823          	sd	a5,16(s11)
ffffffffc0206496:	01b9b023          	sd	s11,0(s3)
ffffffffc020649a:	89ee                	mv	s3,s11
ffffffffc020649c:	67e2                	ld	a5,24(sp)
ffffffffc020649e:	0138b423          	sd	s3,8(a7)
ffffffffc02064a2:	8dc6                	mv	s11,a7
ffffffffc02064a4:	00f8b823          	sd	a5,16(a7)
ffffffffc02064a8:	0119b023          	sd	a7,0(s3)
ffffffffc02064ac:	89da                	mv	s3,s6
ffffffffc02064ae:	831ff06f          	j	ffffffffc0205cde <stride_dequeue+0xcd0>
ffffffffc02064b2:	0088b783          	ld	a5,8(a7)
ffffffffc02064b6:	0108b983          	ld	s3,16(a7)
ffffffffc02064ba:	ec2a                	sd	a0,24(sp)
ffffffffc02064bc:	e83e                	sd	a5,16(sp)
ffffffffc02064be:	00099463          	bnez	s3,ffffffffc02064c6 <stride_dequeue+0x14b8>
ffffffffc02064c2:	7a10006f          	j	ffffffffc0207462 <stride_dequeue+0x2454>
ffffffffc02064c6:	85b2                	mv	a1,a2
ffffffffc02064c8:	854e                	mv	a0,s3
ffffffffc02064ca:	f446                	sd	a7,40(sp)
ffffffffc02064cc:	907fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02064d0:	6362                	ld	t1,24(sp)
ffffffffc02064d2:	7602                	ld	a2,32(sp)
ffffffffc02064d4:	78a2                	ld	a7,40(sp)
ffffffffc02064d6:	426500e3          	beq	a0,t1,ffffffffc02070f6 <stride_dequeue+0x20e8>
ffffffffc02064da:	661c                	ld	a5,8(a2)
ffffffffc02064dc:	01063e03          	ld	t3,16(a2)
ffffffffc02064e0:	fc1a                	sd	t1,56(sp)
ffffffffc02064e2:	ec3e                	sd	a5,24(sp)
ffffffffc02064e4:	040e0a63          	beqz	t3,ffffffffc0206538 <stride_dequeue+0x152a>
ffffffffc02064e8:	85f2                	mv	a1,t3
ffffffffc02064ea:	854e                	mv	a0,s3
ffffffffc02064ec:	f846                	sd	a7,48(sp)
ffffffffc02064ee:	f432                	sd	a2,40(sp)
ffffffffc02064f0:	f072                	sd	t3,32(sp)
ffffffffc02064f2:	8e1fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02064f6:	7362                	ld	t1,56(sp)
ffffffffc02064f8:	7e02                	ld	t3,32(sp)
ffffffffc02064fa:	7622                	ld	a2,40(sp)
ffffffffc02064fc:	78c2                	ld	a7,48(sp)
ffffffffc02064fe:	00651463          	bne	a0,t1,ffffffffc0206506 <stride_dequeue+0x14f8>
ffffffffc0206502:	20e0106f          	j	ffffffffc0207710 <stride_dequeue+0x2702>
ffffffffc0206506:	010e3583          	ld	a1,16(t3)
ffffffffc020650a:	854e                	mv	a0,s3
ffffffffc020650c:	008e3b03          	ld	s6,8(t3)
ffffffffc0206510:	f846                	sd	a7,48(sp)
ffffffffc0206512:	f432                	sd	a2,40(sp)
ffffffffc0206514:	f072                	sd	t3,32(sp)
ffffffffc0206516:	919fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc020651a:	7e02                	ld	t3,32(sp)
ffffffffc020651c:	7622                	ld	a2,40(sp)
ffffffffc020651e:	78c2                	ld	a7,48(sp)
ffffffffc0206520:	016e3823          	sd	s6,16(t3)
ffffffffc0206524:	00ae3423          	sd	a0,8(t3)
ffffffffc0206528:	010c2b03          	lw	s6,16(s8)
ffffffffc020652c:	e119                	bnez	a0,ffffffffc0206532 <stride_dequeue+0x1524>
ffffffffc020652e:	4400106f          	j	ffffffffc020796e <stride_dequeue+0x2960>
ffffffffc0206532:	01c53023          	sd	t3,0(a0)
ffffffffc0206536:	89f2                	mv	s3,t3
ffffffffc0206538:	67e2                	ld	a5,24(sp)
ffffffffc020653a:	01363423          	sd	s3,8(a2)
ffffffffc020653e:	ea1c                	sd	a5,16(a2)
ffffffffc0206540:	00c9b023          	sd	a2,0(s3)
ffffffffc0206544:	89b2                	mv	s3,a2
ffffffffc0206546:	67c2                	ld	a5,16(sp)
ffffffffc0206548:	0138b423          	sd	s3,8(a7)
ffffffffc020654c:	8646                	mv	a2,a7
ffffffffc020654e:	00f8b823          	sd	a5,16(a7)
ffffffffc0206552:	0119b023          	sd	a7,0(s3)
ffffffffc0206556:	89da                	mv	s3,s6
ffffffffc0206558:	eb6ff06f          	j	ffffffffc0205c0e <stride_dequeue+0xc00>
ffffffffc020655c:	008cb783          	ld	a5,8(s9)
ffffffffc0206560:	010cb983          	ld	s3,16(s9)
ffffffffc0206564:	f02a                	sd	a0,32(sp)
ffffffffc0206566:	ec3e                	sd	a5,24(sp)
ffffffffc0206568:	00099463          	bnez	s3,ffffffffc0206570 <stride_dequeue+0x1562>
ffffffffc020656c:	6eb0006f          	j	ffffffffc0207456 <stride_dequeue+0x2448>
ffffffffc0206570:	85c2                	mv	a1,a6
ffffffffc0206572:	854e                	mv	a0,s3
ffffffffc0206574:	f442                	sd	a6,40(sp)
ffffffffc0206576:	85dfe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc020657a:	7302                	ld	t1,32(sp)
ffffffffc020657c:	7822                	ld	a6,40(sp)
ffffffffc020657e:	3e650ee3          	beq	a0,t1,ffffffffc020717a <stride_dequeue+0x216c>
ffffffffc0206582:	00883783          	ld	a5,8(a6)
ffffffffc0206586:	01083e03          	ld	t3,16(a6)
ffffffffc020658a:	fc1a                	sd	t1,56(sp)
ffffffffc020658c:	f03e                	sd	a5,32(sp)
ffffffffc020658e:	040e0663          	beqz	t3,ffffffffc02065da <stride_dequeue+0x15cc>
ffffffffc0206592:	85f2                	mv	a1,t3
ffffffffc0206594:	854e                	mv	a0,s3
ffffffffc0206596:	f842                	sd	a6,48(sp)
ffffffffc0206598:	f472                	sd	t3,40(sp)
ffffffffc020659a:	839fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc020659e:	7362                	ld	t1,56(sp)
ffffffffc02065a0:	7e22                	ld	t3,40(sp)
ffffffffc02065a2:	7842                	ld	a6,48(sp)
ffffffffc02065a4:	00651463          	bne	a0,t1,ffffffffc02065ac <stride_dequeue+0x159e>
ffffffffc02065a8:	2a20106f          	j	ffffffffc020784a <stride_dequeue+0x283c>
ffffffffc02065ac:	010e3583          	ld	a1,16(t3)
ffffffffc02065b0:	854e                	mv	a0,s3
ffffffffc02065b2:	008e3b03          	ld	s6,8(t3)
ffffffffc02065b6:	f842                	sd	a6,48(sp)
ffffffffc02065b8:	f472                	sd	t3,40(sp)
ffffffffc02065ba:	875fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02065be:	7e22                	ld	t3,40(sp)
ffffffffc02065c0:	7842                	ld	a6,48(sp)
ffffffffc02065c2:	016e3823          	sd	s6,16(t3)
ffffffffc02065c6:	00ae3423          	sd	a0,8(t3)
ffffffffc02065ca:	010c2b03          	lw	s6,16(s8)
ffffffffc02065ce:	e119                	bnez	a0,ffffffffc02065d4 <stride_dequeue+0x15c6>
ffffffffc02065d0:	35c0106f          	j	ffffffffc020792c <stride_dequeue+0x291e>
ffffffffc02065d4:	01c53023          	sd	t3,0(a0)
ffffffffc02065d8:	89f2                	mv	s3,t3
ffffffffc02065da:	7782                	ld	a5,32(sp)
ffffffffc02065dc:	01383423          	sd	s3,8(a6)
ffffffffc02065e0:	00f83823          	sd	a5,16(a6)
ffffffffc02065e4:	0109b023          	sd	a6,0(s3)
ffffffffc02065e8:	89c2                	mv	s3,a6
ffffffffc02065ea:	67e2                	ld	a5,24(sp)
ffffffffc02065ec:	013cb423          	sd	s3,8(s9)
ffffffffc02065f0:	00fcb823          	sd	a5,16(s9)
ffffffffc02065f4:	0199b023          	sd	s9,0(s3)
ffffffffc02065f8:	89da                	mv	s3,s6
ffffffffc02065fa:	f89fe06f          	j	ffffffffc0205582 <stride_dequeue+0x574>
ffffffffc02065fe:	661c                	ld	a5,8(a2)
ffffffffc0206600:	01063983          	ld	s3,16(a2)
ffffffffc0206604:	ec2a                	sd	a0,24(sp)
ffffffffc0206606:	e83e                	sd	a5,16(sp)
ffffffffc0206608:	64098ae3          	beqz	s3,ffffffffc020745c <stride_dequeue+0x244e>
ffffffffc020660c:	85c2                	mv	a1,a6
ffffffffc020660e:	854e                	mv	a0,s3
ffffffffc0206610:	f432                	sd	a2,40(sp)
ffffffffc0206612:	f042                	sd	a6,32(sp)
ffffffffc0206614:	fbefe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206618:	6362                	ld	t1,24(sp)
ffffffffc020661a:	7802                	ld	a6,32(sp)
ffffffffc020661c:	7622                	ld	a2,40(sp)
ffffffffc020661e:	326509e3          	beq	a0,t1,ffffffffc0207150 <stride_dequeue+0x2142>
ffffffffc0206622:	00883783          	ld	a5,8(a6)
ffffffffc0206626:	01083e03          	ld	t3,16(a6)
ffffffffc020662a:	fc1a                	sd	t1,56(sp)
ffffffffc020662c:	ec3e                	sd	a5,24(sp)
ffffffffc020662e:	040e0a63          	beqz	t3,ffffffffc0206682 <stride_dequeue+0x1674>
ffffffffc0206632:	85f2                	mv	a1,t3
ffffffffc0206634:	854e                	mv	a0,s3
ffffffffc0206636:	f842                	sd	a6,48(sp)
ffffffffc0206638:	f432                	sd	a2,40(sp)
ffffffffc020663a:	f072                	sd	t3,32(sp)
ffffffffc020663c:	f96fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206640:	7362                	ld	t1,56(sp)
ffffffffc0206642:	7e02                	ld	t3,32(sp)
ffffffffc0206644:	7622                	ld	a2,40(sp)
ffffffffc0206646:	7842                	ld	a6,48(sp)
ffffffffc0206648:	00651463          	bne	a0,t1,ffffffffc0206650 <stride_dequeue+0x1642>
ffffffffc020664c:	1760106f          	j	ffffffffc02077c2 <stride_dequeue+0x27b4>
ffffffffc0206650:	010e3583          	ld	a1,16(t3)
ffffffffc0206654:	854e                	mv	a0,s3
ffffffffc0206656:	008e3b03          	ld	s6,8(t3)
ffffffffc020665a:	f842                	sd	a6,48(sp)
ffffffffc020665c:	f432                	sd	a2,40(sp)
ffffffffc020665e:	f072                	sd	t3,32(sp)
ffffffffc0206660:	fcefe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206664:	7e02                	ld	t3,32(sp)
ffffffffc0206666:	7622                	ld	a2,40(sp)
ffffffffc0206668:	7842                	ld	a6,48(sp)
ffffffffc020666a:	016e3823          	sd	s6,16(t3)
ffffffffc020666e:	00ae3423          	sd	a0,8(t3)
ffffffffc0206672:	010c2b03          	lw	s6,16(s8)
ffffffffc0206676:	e119                	bnez	a0,ffffffffc020667c <stride_dequeue+0x166e>
ffffffffc0206678:	32c0106f          	j	ffffffffc02079a4 <stride_dequeue+0x2996>
ffffffffc020667c:	01c53023          	sd	t3,0(a0)
ffffffffc0206680:	89f2                	mv	s3,t3
ffffffffc0206682:	67e2                	ld	a5,24(sp)
ffffffffc0206684:	01383423          	sd	s3,8(a6)
ffffffffc0206688:	00f83823          	sd	a5,16(a6)
ffffffffc020668c:	0109b023          	sd	a6,0(s3)
ffffffffc0206690:	89c2                	mv	s3,a6
ffffffffc0206692:	67c2                	ld	a5,16(sp)
ffffffffc0206694:	01363423          	sd	s3,8(a2)
ffffffffc0206698:	ea1c                	sd	a5,16(a2)
ffffffffc020669a:	00c9b023          	sd	a2,0(s3)
ffffffffc020669e:	89da                	mv	s3,s6
ffffffffc02066a0:	ffffe06f          	j	ffffffffc020569e <stride_dequeue+0x690>
ffffffffc02066a4:	008a3783          	ld	a5,8(s4)
ffffffffc02066a8:	010a3983          	ld	s3,16(s4)
ffffffffc02066ac:	f02a                	sd	a0,32(sp)
ffffffffc02066ae:	ec3e                	sd	a5,24(sp)
ffffffffc02066b0:	5a098ce3          	beqz	s3,ffffffffc0207468 <stride_dequeue+0x245a>
ffffffffc02066b4:	85c2                	mv	a1,a6
ffffffffc02066b6:	854e                	mv	a0,s3
ffffffffc02066b8:	f442                	sd	a6,40(sp)
ffffffffc02066ba:	f18fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02066be:	7302                	ld	t1,32(sp)
ffffffffc02066c0:	7822                	ld	a6,40(sp)
ffffffffc02066c2:	566501e3          	beq	a0,t1,ffffffffc0207424 <stride_dequeue+0x2416>
ffffffffc02066c6:	00883783          	ld	a5,8(a6)
ffffffffc02066ca:	01083e03          	ld	t3,16(a6)
ffffffffc02066ce:	fc1a                	sd	t1,56(sp)
ffffffffc02066d0:	f03e                	sd	a5,32(sp)
ffffffffc02066d2:	040e0663          	beqz	t3,ffffffffc020671e <stride_dequeue+0x1710>
ffffffffc02066d6:	85f2                	mv	a1,t3
ffffffffc02066d8:	854e                	mv	a0,s3
ffffffffc02066da:	f842                	sd	a6,48(sp)
ffffffffc02066dc:	f472                	sd	t3,40(sp)
ffffffffc02066de:	ef4fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02066e2:	7362                	ld	t1,56(sp)
ffffffffc02066e4:	7e22                	ld	t3,40(sp)
ffffffffc02066e6:	7842                	ld	a6,48(sp)
ffffffffc02066e8:	00651463          	bne	a0,t1,ffffffffc02066f0 <stride_dequeue+0x16e2>
ffffffffc02066ec:	18a0106f          	j	ffffffffc0207876 <stride_dequeue+0x2868>
ffffffffc02066f0:	010e3583          	ld	a1,16(t3)
ffffffffc02066f4:	854e                	mv	a0,s3
ffffffffc02066f6:	008e3b03          	ld	s6,8(t3)
ffffffffc02066fa:	f842                	sd	a6,48(sp)
ffffffffc02066fc:	f472                	sd	t3,40(sp)
ffffffffc02066fe:	f30fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206702:	7e22                	ld	t3,40(sp)
ffffffffc0206704:	7842                	ld	a6,48(sp)
ffffffffc0206706:	016e3823          	sd	s6,16(t3)
ffffffffc020670a:	00ae3423          	sd	a0,8(t3)
ffffffffc020670e:	010c2b03          	lw	s6,16(s8)
ffffffffc0206712:	e119                	bnez	a0,ffffffffc0206718 <stride_dequeue+0x170a>
ffffffffc0206714:	1ee0106f          	j	ffffffffc0207902 <stride_dequeue+0x28f4>
ffffffffc0206718:	01c53023          	sd	t3,0(a0)
ffffffffc020671c:	89f2                	mv	s3,t3
ffffffffc020671e:	7782                	ld	a5,32(sp)
ffffffffc0206720:	01383423          	sd	s3,8(a6)
ffffffffc0206724:	00f83823          	sd	a5,16(a6)
ffffffffc0206728:	0109b023          	sd	a6,0(s3)
ffffffffc020672c:	89c2                	mv	s3,a6
ffffffffc020672e:	67e2                	ld	a5,24(sp)
ffffffffc0206730:	013a3423          	sd	s3,8(s4)
ffffffffc0206734:	00fa3823          	sd	a5,16(s4)
ffffffffc0206738:	0149b023          	sd	s4,0(s3)
ffffffffc020673c:	89da                	mv	s3,s6
ffffffffc020673e:	85eff06f          	j	ffffffffc020579c <stride_dequeue+0x78e>
ffffffffc0206742:	008cb783          	ld	a5,8(s9)
ffffffffc0206746:	010cb983          	ld	s3,16(s9)
ffffffffc020674a:	f42a                	sd	a0,40(sp)
ffffffffc020674c:	f03e                	sd	a5,32(sp)
ffffffffc020674e:	04098163          	beqz	s3,ffffffffc0206790 <stride_dequeue+0x1782>
ffffffffc0206752:	859a                	mv	a1,t1
ffffffffc0206754:	854e                	mv	a0,s3
ffffffffc0206756:	fc42                	sd	a6,56(sp)
ffffffffc0206758:	f81a                	sd	t1,48(sp)
ffffffffc020675a:	e78fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc020675e:	7e22                	ld	t3,40(sp)
ffffffffc0206760:	7342                	ld	t1,48(sp)
ffffffffc0206762:	7862                	ld	a6,56(sp)
ffffffffc0206764:	11c505e3          	beq	a0,t3,ffffffffc020706e <stride_dequeue+0x2060>
ffffffffc0206768:	01033583          	ld	a1,16(t1)
ffffffffc020676c:	854e                	mv	a0,s3
ffffffffc020676e:	00833b03          	ld	s6,8(t1)
ffffffffc0206772:	f842                	sd	a6,48(sp)
ffffffffc0206774:	f41a                	sd	t1,40(sp)
ffffffffc0206776:	eb8fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc020677a:	7322                	ld	t1,40(sp)
ffffffffc020677c:	7842                	ld	a6,48(sp)
ffffffffc020677e:	01633823          	sd	s6,16(t1)
ffffffffc0206782:	00a33423          	sd	a0,8(t1)
ffffffffc0206786:	010c2b03          	lw	s6,16(s8)
ffffffffc020678a:	c119                	beqz	a0,ffffffffc0206790 <stride_dequeue+0x1782>
ffffffffc020678c:	00653023          	sd	t1,0(a0)
ffffffffc0206790:	7782                	ld	a5,32(sp)
ffffffffc0206792:	006cb423          	sd	t1,8(s9)
ffffffffc0206796:	89da                	mv	s3,s6
ffffffffc0206798:	00fcb823          	sd	a5,16(s9)
ffffffffc020679c:	01933023          	sd	s9,0(t1)
ffffffffc02067a0:	9aeff06f          	j	ffffffffc020594e <stride_dequeue+0x940>
ffffffffc02067a4:	008db783          	ld	a5,8(s11)
ffffffffc02067a8:	010db983          	ld	s3,16(s11)
ffffffffc02067ac:	f02a                	sd	a0,32(sp)
ffffffffc02067ae:	ec3e                	sd	a5,24(sp)
ffffffffc02067b0:	04098563          	beqz	s3,ffffffffc02067fa <stride_dequeue+0x17ec>
ffffffffc02067b4:	859a                	mv	a1,t1
ffffffffc02067b6:	854e                	mv	a0,s3
ffffffffc02067b8:	fc42                	sd	a6,56(sp)
ffffffffc02067ba:	f832                	sd	a2,48(sp)
ffffffffc02067bc:	f41a                	sd	t1,40(sp)
ffffffffc02067be:	e14fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02067c2:	7e02                	ld	t3,32(sp)
ffffffffc02067c4:	7322                	ld	t1,40(sp)
ffffffffc02067c6:	7642                	ld	a2,48(sp)
ffffffffc02067c8:	7862                	ld	a6,56(sp)
ffffffffc02067ca:	15c50be3          	beq	a0,t3,ffffffffc0207120 <stride_dequeue+0x2112>
ffffffffc02067ce:	01033583          	ld	a1,16(t1)
ffffffffc02067d2:	854e                	mv	a0,s3
ffffffffc02067d4:	00833b03          	ld	s6,8(t1)
ffffffffc02067d8:	f842                	sd	a6,48(sp)
ffffffffc02067da:	f432                	sd	a2,40(sp)
ffffffffc02067dc:	f01a                	sd	t1,32(sp)
ffffffffc02067de:	e50fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02067e2:	7302                	ld	t1,32(sp)
ffffffffc02067e4:	7622                	ld	a2,40(sp)
ffffffffc02067e6:	7842                	ld	a6,48(sp)
ffffffffc02067e8:	01633823          	sd	s6,16(t1)
ffffffffc02067ec:	00a33423          	sd	a0,8(t1)
ffffffffc02067f0:	010c2b03          	lw	s6,16(s8)
ffffffffc02067f4:	c119                	beqz	a0,ffffffffc02067fa <stride_dequeue+0x17ec>
ffffffffc02067f6:	00653023          	sd	t1,0(a0)
ffffffffc02067fa:	67e2                	ld	a5,24(sp)
ffffffffc02067fc:	006db423          	sd	t1,8(s11)
ffffffffc0206800:	89da                	mv	s3,s6
ffffffffc0206802:	00fdb823          	sd	a5,16(s11)
ffffffffc0206806:	01b33023          	sd	s11,0(t1)
ffffffffc020680a:	c3dfe06f          	j	ffffffffc0205446 <stride_dequeue+0x438>
ffffffffc020680e:	0088b783          	ld	a5,8(a7)
ffffffffc0206812:	0108b983          	ld	s3,16(a7)
ffffffffc0206816:	f42a                	sd	a0,40(sp)
ffffffffc0206818:	f03e                	sd	a5,32(sp)
ffffffffc020681a:	04098063          	beqz	s3,ffffffffc020685a <stride_dequeue+0x184c>
ffffffffc020681e:	85c2                	mv	a1,a6
ffffffffc0206820:	854e                	mv	a0,s3
ffffffffc0206822:	fc46                	sd	a7,56(sp)
ffffffffc0206824:	daefe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206828:	7e22                	ld	t3,40(sp)
ffffffffc020682a:	7842                	ld	a6,48(sp)
ffffffffc020682c:	78e2                	ld	a7,56(sp)
ffffffffc020682e:	29c50de3          	beq	a0,t3,ffffffffc02072c8 <stride_dequeue+0x22ba>
ffffffffc0206832:	01083583          	ld	a1,16(a6)
ffffffffc0206836:	854e                	mv	a0,s3
ffffffffc0206838:	00883b03          	ld	s6,8(a6)
ffffffffc020683c:	f846                	sd	a7,48(sp)
ffffffffc020683e:	f442                	sd	a6,40(sp)
ffffffffc0206840:	deefe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206844:	7822                	ld	a6,40(sp)
ffffffffc0206846:	78c2                	ld	a7,48(sp)
ffffffffc0206848:	01683823          	sd	s6,16(a6)
ffffffffc020684c:	00a83423          	sd	a0,8(a6)
ffffffffc0206850:	010c2b03          	lw	s6,16(s8)
ffffffffc0206854:	c119                	beqz	a0,ffffffffc020685a <stride_dequeue+0x184c>
ffffffffc0206856:	01053023          	sd	a6,0(a0)
ffffffffc020685a:	7782                	ld	a5,32(sp)
ffffffffc020685c:	0108b423          	sd	a6,8(a7)
ffffffffc0206860:	89da                	mv	s3,s6
ffffffffc0206862:	00f8b823          	sd	a5,16(a7)
ffffffffc0206866:	01183023          	sd	a7,0(a6)
ffffffffc020686a:	8846                	mv	a6,a7
ffffffffc020686c:	d08ff06f          	j	ffffffffc0205d74 <stride_dequeue+0xd66>
ffffffffc0206870:	008db783          	ld	a5,8(s11)
ffffffffc0206874:	010db983          	ld	s3,16(s11)
ffffffffc0206878:	f42a                	sd	a0,40(sp)
ffffffffc020687a:	f03e                	sd	a5,32(sp)
ffffffffc020687c:	04098163          	beqz	s3,ffffffffc02068be <stride_dequeue+0x18b0>
ffffffffc0206880:	859a                	mv	a1,t1
ffffffffc0206882:	854e                	mv	a0,s3
ffffffffc0206884:	fc42                	sd	a6,56(sp)
ffffffffc0206886:	f81a                	sd	t1,48(sp)
ffffffffc0206888:	d4afe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc020688c:	7e22                	ld	t3,40(sp)
ffffffffc020688e:	7342                	ld	t1,48(sp)
ffffffffc0206890:	7862                	ld	a6,56(sp)
ffffffffc0206892:	29c507e3          	beq	a0,t3,ffffffffc0207320 <stride_dequeue+0x2312>
ffffffffc0206896:	01033583          	ld	a1,16(t1)
ffffffffc020689a:	854e                	mv	a0,s3
ffffffffc020689c:	00833b03          	ld	s6,8(t1)
ffffffffc02068a0:	f842                	sd	a6,48(sp)
ffffffffc02068a2:	f41a                	sd	t1,40(sp)
ffffffffc02068a4:	d8afe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02068a8:	7322                	ld	t1,40(sp)
ffffffffc02068aa:	7842                	ld	a6,48(sp)
ffffffffc02068ac:	01633823          	sd	s6,16(t1)
ffffffffc02068b0:	00a33423          	sd	a0,8(t1)
ffffffffc02068b4:	010c2b03          	lw	s6,16(s8)
ffffffffc02068b8:	c119                	beqz	a0,ffffffffc02068be <stride_dequeue+0x18b0>
ffffffffc02068ba:	00653023          	sd	t1,0(a0)
ffffffffc02068be:	7782                	ld	a5,32(sp)
ffffffffc02068c0:	006db423          	sd	t1,8(s11)
ffffffffc02068c4:	89da                	mv	s3,s6
ffffffffc02068c6:	00fdb823          	sd	a5,16(s11)
ffffffffc02068ca:	01b33023          	sd	s11,0(t1)
ffffffffc02068ce:	a1ffe06f          	j	ffffffffc02052ec <stride_dequeue+0x2de>
ffffffffc02068d2:	0088b783          	ld	a5,8(a7)
ffffffffc02068d6:	0108b983          	ld	s3,16(a7)
ffffffffc02068da:	f42a                	sd	a0,40(sp)
ffffffffc02068dc:	f03e                	sd	a5,32(sp)
ffffffffc02068de:	04098063          	beqz	s3,ffffffffc020691e <stride_dequeue+0x1910>
ffffffffc02068e2:	859a                	mv	a1,t1
ffffffffc02068e4:	854e                	mv	a0,s3
ffffffffc02068e6:	fc46                	sd	a7,56(sp)
ffffffffc02068e8:	ceafe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02068ec:	7e22                	ld	t3,40(sp)
ffffffffc02068ee:	7342                	ld	t1,48(sp)
ffffffffc02068f0:	78e2                	ld	a7,56(sp)
ffffffffc02068f2:	73c50263          	beq	a0,t3,ffffffffc0207016 <stride_dequeue+0x2008>
ffffffffc02068f6:	01033583          	ld	a1,16(t1)
ffffffffc02068fa:	854e                	mv	a0,s3
ffffffffc02068fc:	00833b03          	ld	s6,8(t1)
ffffffffc0206900:	f846                	sd	a7,48(sp)
ffffffffc0206902:	f41a                	sd	t1,40(sp)
ffffffffc0206904:	d2afe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206908:	7322                	ld	t1,40(sp)
ffffffffc020690a:	78c2                	ld	a7,48(sp)
ffffffffc020690c:	01633823          	sd	s6,16(t1)
ffffffffc0206910:	00a33423          	sd	a0,8(t1)
ffffffffc0206914:	010c2b03          	lw	s6,16(s8)
ffffffffc0206918:	c119                	beqz	a0,ffffffffc020691e <stride_dequeue+0x1910>
ffffffffc020691a:	00653023          	sd	t1,0(a0)
ffffffffc020691e:	7782                	ld	a5,32(sp)
ffffffffc0206920:	0068b423          	sd	t1,8(a7)
ffffffffc0206924:	89da                	mv	s3,s6
ffffffffc0206926:	00f8b823          	sd	a5,16(a7)
ffffffffc020692a:	01133023          	sd	a7,0(t1)
ffffffffc020692e:	f3dfe06f          	j	ffffffffc020586a <stride_dequeue+0x85c>
ffffffffc0206932:	01093503          	ld	a0,16(s2)
ffffffffc0206936:	00893983          	ld	s3,8(s2)
ffffffffc020693a:	85da                	mv	a1,s6
ffffffffc020693c:	cf2fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206940:	00a93423          	sd	a0,8(s2)
ffffffffc0206944:	01393823          	sd	s3,16(s2)
ffffffffc0206948:	7822                	ld	a6,40(sp)
ffffffffc020694a:	77c2                	ld	a5,48(sp)
ffffffffc020694c:	010c2983          	lw	s3,16(s8)
ffffffffc0206950:	e119                	bnez	a0,ffffffffc0206956 <stride_dequeue+0x1948>
ffffffffc0206952:	803fe06f          	j	ffffffffc0205154 <stride_dequeue+0x146>
ffffffffc0206956:	01253023          	sd	s2,0(a0)
ffffffffc020695a:	ffafe06f          	j	ffffffffc0205154 <stride_dequeue+0x146>
ffffffffc020695e:	0089b783          	ld	a5,8(s3)
ffffffffc0206962:	0109b803          	ld	a6,16(s3)
ffffffffc0206966:	f42a                	sd	a0,40(sp)
ffffffffc0206968:	ec3e                	sd	a5,24(sp)
ffffffffc020696a:	02080b63          	beqz	a6,ffffffffc02069a0 <stride_dequeue+0x1992>
ffffffffc020696e:	8542                	mv	a0,a6
ffffffffc0206970:	85d2                	mv	a1,s4
ffffffffc0206972:	f042                	sd	a6,32(sp)
ffffffffc0206974:	c5efe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206978:	77a2                	ld	a5,40(sp)
ffffffffc020697a:	7802                	ld	a6,32(sp)
ffffffffc020697c:	3cf50be3          	beq	a0,a5,ffffffffc0207552 <stride_dequeue+0x2544>
ffffffffc0206980:	010a3583          	ld	a1,16(s4)
ffffffffc0206984:	008a3b03          	ld	s6,8(s4)
ffffffffc0206988:	8542                	mv	a0,a6
ffffffffc020698a:	ca4fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc020698e:	00aa3423          	sd	a0,8(s4)
ffffffffc0206992:	016a3823          	sd	s6,16(s4)
ffffffffc0206996:	010c2b03          	lw	s6,16(s8)
ffffffffc020699a:	c119                	beqz	a0,ffffffffc02069a0 <stride_dequeue+0x1992>
ffffffffc020699c:	01453023          	sd	s4,0(a0)
ffffffffc02069a0:	67e2                	ld	a5,24(sp)
ffffffffc02069a2:	0149b423          	sd	s4,8(s3)
ffffffffc02069a6:	00f9b823          	sd	a5,16(s3)
ffffffffc02069aa:	013a3023          	sd	s3,0(s4)
ffffffffc02069ae:	8a4e                	mv	s4,s3
ffffffffc02069b0:	c90ff06f          	j	ffffffffc0205e40 <stride_dequeue+0xe32>
ffffffffc02069b4:	0089b783          	ld	a5,8(s3)
ffffffffc02069b8:	0109b803          	ld	a6,16(s3)
ffffffffc02069bc:	f42a                	sd	a0,40(sp)
ffffffffc02069be:	ec3e                	sd	a5,24(sp)
ffffffffc02069c0:	02080b63          	beqz	a6,ffffffffc02069f6 <stride_dequeue+0x19e8>
ffffffffc02069c4:	8542                	mv	a0,a6
ffffffffc02069c6:	85e6                	mv	a1,s9
ffffffffc02069c8:	f042                	sd	a6,32(sp)
ffffffffc02069ca:	c08fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc02069ce:	77a2                	ld	a5,40(sp)
ffffffffc02069d0:	7802                	ld	a6,32(sp)
ffffffffc02069d2:	28f50ee3          	beq	a0,a5,ffffffffc020746e <stride_dequeue+0x2460>
ffffffffc02069d6:	010cb583          	ld	a1,16(s9)
ffffffffc02069da:	008cbb03          	ld	s6,8(s9)
ffffffffc02069de:	8542                	mv	a0,a6
ffffffffc02069e0:	c4efe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02069e4:	00acb423          	sd	a0,8(s9)
ffffffffc02069e8:	016cb823          	sd	s6,16(s9)
ffffffffc02069ec:	010c2b03          	lw	s6,16(s8)
ffffffffc02069f0:	c119                	beqz	a0,ffffffffc02069f6 <stride_dequeue+0x19e8>
ffffffffc02069f2:	01953023          	sd	s9,0(a0)
ffffffffc02069f6:	67e2                	ld	a5,24(sp)
ffffffffc02069f8:	0199b423          	sd	s9,8(s3)
ffffffffc02069fc:	00f9b823          	sd	a5,16(s3)
ffffffffc0206a00:	013cb023          	sd	s3,0(s9)
ffffffffc0206a04:	8cce                	mv	s9,s3
ffffffffc0206a06:	de4ff06f          	j	ffffffffc0205fea <stride_dequeue+0xfdc>
ffffffffc0206a0a:	0089b783          	ld	a5,8(s3)
ffffffffc0206a0e:	0109b803          	ld	a6,16(s3)
ffffffffc0206a12:	f42a                	sd	a0,40(sp)
ffffffffc0206a14:	e83e                	sd	a5,16(sp)
ffffffffc0206a16:	02080f63          	beqz	a6,ffffffffc0206a54 <stride_dequeue+0x1a46>
ffffffffc0206a1a:	8542                	mv	a0,a6
ffffffffc0206a1c:	85d2                	mv	a1,s4
ffffffffc0206a1e:	f032                	sd	a2,32(sp)
ffffffffc0206a20:	ec42                	sd	a6,24(sp)
ffffffffc0206a22:	bb0fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206a26:	77a2                	ld	a5,40(sp)
ffffffffc0206a28:	6862                	ld	a6,24(sp)
ffffffffc0206a2a:	7602                	ld	a2,32(sp)
ffffffffc0206a2c:	26f506e3          	beq	a0,a5,ffffffffc0207498 <stride_dequeue+0x248a>
ffffffffc0206a30:	010a3583          	ld	a1,16(s4)
ffffffffc0206a34:	008a3b03          	ld	s6,8(s4)
ffffffffc0206a38:	8542                	mv	a0,a6
ffffffffc0206a3a:	ec32                	sd	a2,24(sp)
ffffffffc0206a3c:	bf2fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206a40:	00aa3423          	sd	a0,8(s4)
ffffffffc0206a44:	016a3823          	sd	s6,16(s4)
ffffffffc0206a48:	6662                	ld	a2,24(sp)
ffffffffc0206a4a:	010c2b03          	lw	s6,16(s8)
ffffffffc0206a4e:	c119                	beqz	a0,ffffffffc0206a54 <stride_dequeue+0x1a46>
ffffffffc0206a50:	01453023          	sd	s4,0(a0)
ffffffffc0206a54:	67c2                	ld	a5,16(sp)
ffffffffc0206a56:	0149b423          	sd	s4,8(s3)
ffffffffc0206a5a:	00f9b823          	sd	a5,16(s3)
ffffffffc0206a5e:	013a3023          	sd	s3,0(s4)
ffffffffc0206a62:	8a4e                	mv	s4,s3
ffffffffc0206a64:	cb8ff06f          	j	ffffffffc0205f1c <stride_dequeue+0xf0e>
ffffffffc0206a68:	008a3783          	ld	a5,8(s4)
ffffffffc0206a6c:	010a3883          	ld	a7,16(s4)
ffffffffc0206a70:	f42a                	sd	a0,40(sp)
ffffffffc0206a72:	ec3e                	sd	a5,24(sp)
ffffffffc0206a74:	02088b63          	beqz	a7,ffffffffc0206aaa <stride_dequeue+0x1a9c>
ffffffffc0206a78:	8546                	mv	a0,a7
ffffffffc0206a7a:	85ce                	mv	a1,s3
ffffffffc0206a7c:	f046                	sd	a7,32(sp)
ffffffffc0206a7e:	b54fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206a82:	77a2                	ld	a5,40(sp)
ffffffffc0206a84:	7882                	ld	a7,32(sp)
ffffffffc0206a86:	26f501e3          	beq	a0,a5,ffffffffc02074e8 <stride_dequeue+0x24da>
ffffffffc0206a8a:	0109b583          	ld	a1,16(s3)
ffffffffc0206a8e:	0089bb03          	ld	s6,8(s3)
ffffffffc0206a92:	8546                	mv	a0,a7
ffffffffc0206a94:	b9afe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206a98:	00a9b423          	sd	a0,8(s3)
ffffffffc0206a9c:	0169b823          	sd	s6,16(s3)
ffffffffc0206aa0:	010c2b03          	lw	s6,16(s8)
ffffffffc0206aa4:	c119                	beqz	a0,ffffffffc0206aaa <stride_dequeue+0x1a9c>
ffffffffc0206aa6:	01353023          	sd	s3,0(a0)
ffffffffc0206aaa:	67e2                	ld	a5,24(sp)
ffffffffc0206aac:	013a3423          	sd	s3,8(s4)
ffffffffc0206ab0:	00fa3823          	sd	a5,16(s4)
ffffffffc0206ab4:	0149b023          	sd	s4,0(s3)
ffffffffc0206ab8:	89d2                	mv	s3,s4
ffffffffc0206aba:	f9bfe06f          	j	ffffffffc0205a54 <stride_dequeue+0xa46>
ffffffffc0206abe:	008a3783          	ld	a5,8(s4)
ffffffffc0206ac2:	010a3883          	ld	a7,16(s4)
ffffffffc0206ac6:	fc2a                	sd	a0,56(sp)
ffffffffc0206ac8:	f03e                	sd	a5,32(sp)
ffffffffc0206aca:	02088f63          	beqz	a7,ffffffffc0206b08 <stride_dequeue+0x1afa>
ffffffffc0206ace:	8546                	mv	a0,a7
ffffffffc0206ad0:	85ce                	mv	a1,s3
ffffffffc0206ad2:	f842                	sd	a6,48(sp)
ffffffffc0206ad4:	f446                	sd	a7,40(sp)
ffffffffc0206ad6:	afcfe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206ada:	7e62                	ld	t3,56(sp)
ffffffffc0206adc:	78a2                	ld	a7,40(sp)
ffffffffc0206ade:	7842                	ld	a6,48(sp)
ffffffffc0206ae0:	35c509e3          	beq	a0,t3,ffffffffc0207632 <stride_dequeue+0x2624>
ffffffffc0206ae4:	0109b583          	ld	a1,16(s3)
ffffffffc0206ae8:	0089bb03          	ld	s6,8(s3)
ffffffffc0206aec:	8546                	mv	a0,a7
ffffffffc0206aee:	f442                	sd	a6,40(sp)
ffffffffc0206af0:	b3efe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206af4:	00a9b423          	sd	a0,8(s3)
ffffffffc0206af8:	0169b823          	sd	s6,16(s3)
ffffffffc0206afc:	7822                	ld	a6,40(sp)
ffffffffc0206afe:	010c2b03          	lw	s6,16(s8)
ffffffffc0206b02:	c119                	beqz	a0,ffffffffc0206b08 <stride_dequeue+0x1afa>
ffffffffc0206b04:	01353023          	sd	s3,0(a0)
ffffffffc0206b08:	7782                	ld	a5,32(sp)
ffffffffc0206b0a:	013a3423          	sd	s3,8(s4)
ffffffffc0206b0e:	00fa3823          	sd	a5,16(s4)
ffffffffc0206b12:	0149b023          	sd	s4,0(s3)
ffffffffc0206b16:	89d2                	mv	s3,s4
ffffffffc0206b18:	c73fe06f          	j	ffffffffc020578a <stride_dequeue+0x77c>
ffffffffc0206b1c:	661c                	ld	a5,8(a2)
ffffffffc0206b1e:	01063883          	ld	a7,16(a2)
ffffffffc0206b22:	fc2a                	sd	a0,56(sp)
ffffffffc0206b24:	ec3e                	sd	a5,24(sp)
ffffffffc0206b26:	04088363          	beqz	a7,ffffffffc0206b6c <stride_dequeue+0x1b5e>
ffffffffc0206b2a:	8546                	mv	a0,a7
ffffffffc0206b2c:	85ce                	mv	a1,s3
ffffffffc0206b2e:	f842                	sd	a6,48(sp)
ffffffffc0206b30:	f432                	sd	a2,40(sp)
ffffffffc0206b32:	f046                	sd	a7,32(sp)
ffffffffc0206b34:	a9efe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206b38:	7e62                	ld	t3,56(sp)
ffffffffc0206b3a:	7882                	ld	a7,32(sp)
ffffffffc0206b3c:	7622                	ld	a2,40(sp)
ffffffffc0206b3e:	7842                	ld	a6,48(sp)
ffffffffc0206b40:	25c501e3          	beq	a0,t3,ffffffffc0207582 <stride_dequeue+0x2574>
ffffffffc0206b44:	0109b583          	ld	a1,16(s3)
ffffffffc0206b48:	0089bb03          	ld	s6,8(s3)
ffffffffc0206b4c:	8546                	mv	a0,a7
ffffffffc0206b4e:	f442                	sd	a6,40(sp)
ffffffffc0206b50:	f032                	sd	a2,32(sp)
ffffffffc0206b52:	adcfe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206b56:	00a9b423          	sd	a0,8(s3)
ffffffffc0206b5a:	0169b823          	sd	s6,16(s3)
ffffffffc0206b5e:	7602                	ld	a2,32(sp)
ffffffffc0206b60:	7822                	ld	a6,40(sp)
ffffffffc0206b62:	010c2b03          	lw	s6,16(s8)
ffffffffc0206b66:	c119                	beqz	a0,ffffffffc0206b6c <stride_dequeue+0x1b5e>
ffffffffc0206b68:	01353023          	sd	s3,0(a0)
ffffffffc0206b6c:	67e2                	ld	a5,24(sp)
ffffffffc0206b6e:	01363423          	sd	s3,8(a2)
ffffffffc0206b72:	ea1c                	sd	a5,16(a2)
ffffffffc0206b74:	00c9b023          	sd	a2,0(s3)
ffffffffc0206b78:	89b2                	mv	s3,a2
ffffffffc0206b7a:	b13fe06f          	j	ffffffffc020568c <stride_dequeue+0x67e>
ffffffffc0206b7e:	89c6                	mv	s3,a7
ffffffffc0206b80:	9e4ff06f          	j	ffffffffc0205d64 <stride_dequeue+0xd56>
ffffffffc0206b84:	0088b783          	ld	a5,8(a7)
ffffffffc0206b88:	0108b803          	ld	a6,16(a7)
ffffffffc0206b8c:	fc2a                	sd	a0,56(sp)
ffffffffc0206b8e:	f03e                	sd	a5,32(sp)
ffffffffc0206b90:	02080f63          	beqz	a6,ffffffffc0206bce <stride_dequeue+0x1bc0>
ffffffffc0206b94:	8542                	mv	a0,a6
ffffffffc0206b96:	85ce                	mv	a1,s3
ffffffffc0206b98:	f846                	sd	a7,48(sp)
ffffffffc0206b9a:	f442                	sd	a6,40(sp)
ffffffffc0206b9c:	a36fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206ba0:	7e62                	ld	t3,56(sp)
ffffffffc0206ba2:	7822                	ld	a6,40(sp)
ffffffffc0206ba4:	78c2                	ld	a7,48(sp)
ffffffffc0206ba6:	47c50ce3          	beq	a0,t3,ffffffffc020781e <stride_dequeue+0x2810>
ffffffffc0206baa:	0109b583          	ld	a1,16(s3)
ffffffffc0206bae:	0089bb03          	ld	s6,8(s3)
ffffffffc0206bb2:	8542                	mv	a0,a6
ffffffffc0206bb4:	f446                	sd	a7,40(sp)
ffffffffc0206bb6:	a78fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206bba:	00a9b423          	sd	a0,8(s3)
ffffffffc0206bbe:	0169b823          	sd	s6,16(s3)
ffffffffc0206bc2:	78a2                	ld	a7,40(sp)
ffffffffc0206bc4:	010c2b03          	lw	s6,16(s8)
ffffffffc0206bc8:	c119                	beqz	a0,ffffffffc0206bce <stride_dequeue+0x1bc0>
ffffffffc0206bca:	01353023          	sd	s3,0(a0)
ffffffffc0206bce:	7782                	ld	a5,32(sp)
ffffffffc0206bd0:	0138b423          	sd	s3,8(a7)
ffffffffc0206bd4:	00f8b823          	sd	a5,16(a7)
ffffffffc0206bd8:	0119b023          	sd	a7,0(s3)
ffffffffc0206bdc:	89c6                	mv	s3,a7
ffffffffc0206bde:	8f0ff06f          	j	ffffffffc0205cce <stride_dequeue+0xcc0>
ffffffffc0206be2:	0088b783          	ld	a5,8(a7)
ffffffffc0206be6:	0108b803          	ld	a6,16(a7)
ffffffffc0206bea:	fc2a                	sd	a0,56(sp)
ffffffffc0206bec:	f03e                	sd	a5,32(sp)
ffffffffc0206bee:	02080f63          	beqz	a6,ffffffffc0206c2c <stride_dequeue+0x1c1e>
ffffffffc0206bf2:	8542                	mv	a0,a6
ffffffffc0206bf4:	85ce                	mv	a1,s3
ffffffffc0206bf6:	f846                	sd	a7,48(sp)
ffffffffc0206bf8:	f442                	sd	a6,40(sp)
ffffffffc0206bfa:	9d8fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206bfe:	7e62                	ld	t3,56(sp)
ffffffffc0206c00:	7822                	ld	a6,40(sp)
ffffffffc0206c02:	78c2                	ld	a7,48(sp)
ffffffffc0206c04:	25c50de3          	beq	a0,t3,ffffffffc020765e <stride_dequeue+0x2650>
ffffffffc0206c08:	0109b583          	ld	a1,16(s3)
ffffffffc0206c0c:	0089bb03          	ld	s6,8(s3)
ffffffffc0206c10:	8542                	mv	a0,a6
ffffffffc0206c12:	f446                	sd	a7,40(sp)
ffffffffc0206c14:	a1afe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206c18:	00a9b423          	sd	a0,8(s3)
ffffffffc0206c1c:	0169b823          	sd	s6,16(s3)
ffffffffc0206c20:	78a2                	ld	a7,40(sp)
ffffffffc0206c22:	010c2b03          	lw	s6,16(s8)
ffffffffc0206c26:	c119                	beqz	a0,ffffffffc0206c2c <stride_dequeue+0x1c1e>
ffffffffc0206c28:	01353023          	sd	s3,0(a0)
ffffffffc0206c2c:	7782                	ld	a5,32(sp)
ffffffffc0206c2e:	0138b423          	sd	s3,8(a7)
ffffffffc0206c32:	00f8b823          	sd	a5,16(a7)
ffffffffc0206c36:	0119b023          	sd	a7,0(s3)
ffffffffc0206c3a:	89c6                	mv	s3,a7
ffffffffc0206c3c:	ee7fe06f          	j	ffffffffc0205b22 <stride_dequeue+0xb14>
ffffffffc0206c40:	0088b783          	ld	a5,8(a7)
ffffffffc0206c44:	0108b803          	ld	a6,16(a7)
ffffffffc0206c48:	fc2a                	sd	a0,56(sp)
ffffffffc0206c4a:	ec3e                	sd	a5,24(sp)
ffffffffc0206c4c:	04080263          	beqz	a6,ffffffffc0206c90 <stride_dequeue+0x1c82>
ffffffffc0206c50:	8542                	mv	a0,a6
ffffffffc0206c52:	85ce                	mv	a1,s3
ffffffffc0206c54:	f846                	sd	a7,48(sp)
ffffffffc0206c56:	f042                	sd	a6,32(sp)
ffffffffc0206c58:	97afe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206c5c:	7e62                	ld	t3,56(sp)
ffffffffc0206c5e:	7802                	ld	a6,32(sp)
ffffffffc0206c60:	7622                	ld	a2,40(sp)
ffffffffc0206c62:	78c2                	ld	a7,48(sp)
ffffffffc0206c64:	23c503e3          	beq	a0,t3,ffffffffc020768a <stride_dequeue+0x267c>
ffffffffc0206c68:	0109b583          	ld	a1,16(s3)
ffffffffc0206c6c:	0089bb03          	ld	s6,8(s3)
ffffffffc0206c70:	8542                	mv	a0,a6
ffffffffc0206c72:	f446                	sd	a7,40(sp)
ffffffffc0206c74:	f032                	sd	a2,32(sp)
ffffffffc0206c76:	9b8fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206c7a:	00a9b423          	sd	a0,8(s3)
ffffffffc0206c7e:	0169b823          	sd	s6,16(s3)
ffffffffc0206c82:	7602                	ld	a2,32(sp)
ffffffffc0206c84:	78a2                	ld	a7,40(sp)
ffffffffc0206c86:	010c2b03          	lw	s6,16(s8)
ffffffffc0206c8a:	c119                	beqz	a0,ffffffffc0206c90 <stride_dequeue+0x1c82>
ffffffffc0206c8c:	01353023          	sd	s3,0(a0)
ffffffffc0206c90:	67e2                	ld	a5,24(sp)
ffffffffc0206c92:	0138b423          	sd	s3,8(a7)
ffffffffc0206c96:	00f8b823          	sd	a5,16(a7)
ffffffffc0206c9a:	0119b023          	sd	a7,0(s3)
ffffffffc0206c9e:	89c6                	mv	s3,a7
ffffffffc0206ca0:	f61fe06f          	j	ffffffffc0205c00 <stride_dequeue+0xbf2>
ffffffffc0206ca4:	0089b783          	ld	a5,8(s3)
ffffffffc0206ca8:	0109b303          	ld	t1,16(s3)
ffffffffc0206cac:	fc2a                	sd	a0,56(sp)
ffffffffc0206cae:	f03e                	sd	a5,32(sp)
ffffffffc0206cb0:	02030f63          	beqz	t1,ffffffffc0206cee <stride_dequeue+0x1ce0>
ffffffffc0206cb4:	851a                	mv	a0,t1
ffffffffc0206cb6:	85e6                	mv	a1,s9
ffffffffc0206cb8:	f846                	sd	a7,48(sp)
ffffffffc0206cba:	f41a                	sd	t1,40(sp)
ffffffffc0206cbc:	916fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206cc0:	7e62                	ld	t3,56(sp)
ffffffffc0206cc2:	7322                	ld	t1,40(sp)
ffffffffc0206cc4:	78c2                	ld	a7,48(sp)
ffffffffc0206cc6:	11c50be3          	beq	a0,t3,ffffffffc02075dc <stride_dequeue+0x25ce>
ffffffffc0206cca:	010cb583          	ld	a1,16(s9)
ffffffffc0206cce:	008cbb03          	ld	s6,8(s9)
ffffffffc0206cd2:	851a                	mv	a0,t1
ffffffffc0206cd4:	f446                	sd	a7,40(sp)
ffffffffc0206cd6:	958fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206cda:	00acb423          	sd	a0,8(s9)
ffffffffc0206cde:	016cb823          	sd	s6,16(s9)
ffffffffc0206ce2:	78a2                	ld	a7,40(sp)
ffffffffc0206ce4:	010c2b03          	lw	s6,16(s8)
ffffffffc0206ce8:	c119                	beqz	a0,ffffffffc0206cee <stride_dequeue+0x1ce0>
ffffffffc0206cea:	01953023          	sd	s9,0(a0)
ffffffffc0206cee:	7782                	ld	a5,32(sp)
ffffffffc0206cf0:	0199b423          	sd	s9,8(s3)
ffffffffc0206cf4:	00f9b823          	sd	a5,16(s3)
ffffffffc0206cf8:	013cb023          	sd	s3,0(s9)
ffffffffc0206cfc:	8cce                	mv	s9,s3
ffffffffc0206cfe:	b8aff06f          	j	ffffffffc0206088 <stride_dequeue+0x107a>
ffffffffc0206d02:	89ee                	mv	s3,s11
ffffffffc0206d04:	dd6fe06f          	j	ffffffffc02052da <stride_dequeue+0x2cc>
ffffffffc0206d08:	0089b783          	ld	a5,8(s3)
ffffffffc0206d0c:	0109b303          	ld	t1,16(s3)
ffffffffc0206d10:	fc2a                	sd	a0,56(sp)
ffffffffc0206d12:	f03e                	sd	a5,32(sp)
ffffffffc0206d14:	02030f63          	beqz	t1,ffffffffc0206d52 <stride_dequeue+0x1d44>
ffffffffc0206d18:	85c2                	mv	a1,a6
ffffffffc0206d1a:	851a                	mv	a0,t1
ffffffffc0206d1c:	f842                	sd	a6,48(sp)
ffffffffc0206d1e:	f41a                	sd	t1,40(sp)
ffffffffc0206d20:	8b2fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206d24:	7e62                	ld	t3,56(sp)
ffffffffc0206d26:	7322                	ld	t1,40(sp)
ffffffffc0206d28:	7842                	ld	a6,48(sp)
ffffffffc0206d2a:	0dc50fe3          	beq	a0,t3,ffffffffc0207608 <stride_dequeue+0x25fa>
ffffffffc0206d2e:	01083583          	ld	a1,16(a6)
ffffffffc0206d32:	851a                	mv	a0,t1
ffffffffc0206d34:	00883b03          	ld	s6,8(a6)
ffffffffc0206d38:	f442                	sd	a6,40(sp)
ffffffffc0206d3a:	8f4fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206d3e:	7822                	ld	a6,40(sp)
ffffffffc0206d40:	01683823          	sd	s6,16(a6)
ffffffffc0206d44:	00a83423          	sd	a0,8(a6)
ffffffffc0206d48:	010c2b03          	lw	s6,16(s8)
ffffffffc0206d4c:	c119                	beqz	a0,ffffffffc0206d52 <stride_dequeue+0x1d44>
ffffffffc0206d4e:	01053023          	sd	a6,0(a0)
ffffffffc0206d52:	7782                	ld	a5,32(sp)
ffffffffc0206d54:	0109b423          	sd	a6,8(s3)
ffffffffc0206d58:	00f9b823          	sd	a5,16(s3)
ffffffffc0206d5c:	01383023          	sd	s3,0(a6)
ffffffffc0206d60:	884e                	mv	a6,s3
ffffffffc0206d62:	bc4ff06f          	j	ffffffffc0206126 <stride_dequeue+0x1118>
ffffffffc0206d66:	008cb783          	ld	a5,8(s9)
ffffffffc0206d6a:	010cb883          	ld	a7,16(s9)
ffffffffc0206d6e:	fc2a                	sd	a0,56(sp)
ffffffffc0206d70:	f03e                	sd	a5,32(sp)
ffffffffc0206d72:	02088f63          	beqz	a7,ffffffffc0206db0 <stride_dequeue+0x1da2>
ffffffffc0206d76:	8546                	mv	a0,a7
ffffffffc0206d78:	85ce                	mv	a1,s3
ffffffffc0206d7a:	f842                	sd	a6,48(sp)
ffffffffc0206d7c:	f446                	sd	a7,40(sp)
ffffffffc0206d7e:	854fe0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206d82:	7e62                	ld	t3,56(sp)
ffffffffc0206d84:	78a2                	ld	a7,40(sp)
ffffffffc0206d86:	7842                	ld	a6,48(sp)
ffffffffc0206d88:	27c505e3          	beq	a0,t3,ffffffffc02077f2 <stride_dequeue+0x27e4>
ffffffffc0206d8c:	0109b583          	ld	a1,16(s3)
ffffffffc0206d90:	0089bb03          	ld	s6,8(s3)
ffffffffc0206d94:	8546                	mv	a0,a7
ffffffffc0206d96:	f442                	sd	a6,40(sp)
ffffffffc0206d98:	896fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206d9c:	00a9b423          	sd	a0,8(s3)
ffffffffc0206da0:	0169b823          	sd	s6,16(s3)
ffffffffc0206da4:	7822                	ld	a6,40(sp)
ffffffffc0206da6:	010c2b03          	lw	s6,16(s8)
ffffffffc0206daa:	c119                	beqz	a0,ffffffffc0206db0 <stride_dequeue+0x1da2>
ffffffffc0206dac:	01353023          	sd	s3,0(a0)
ffffffffc0206db0:	7782                	ld	a5,32(sp)
ffffffffc0206db2:	013cb423          	sd	s3,8(s9)
ffffffffc0206db6:	00fcb823          	sd	a5,16(s9)
ffffffffc0206dba:	0199b023          	sd	s9,0(s3)
ffffffffc0206dbe:	89e6                	mv	s3,s9
ffffffffc0206dc0:	fb0fe06f          	j	ffffffffc0205570 <stride_dequeue+0x562>
ffffffffc0206dc4:	0089b783          	ld	a5,8(s3)
ffffffffc0206dc8:	0109b303          	ld	t1,16(s3)
ffffffffc0206dcc:	fc2a                	sd	a0,56(sp)
ffffffffc0206dce:	f03e                	sd	a5,32(sp)
ffffffffc0206dd0:	02030f63          	beqz	t1,ffffffffc0206e0e <stride_dequeue+0x1e00>
ffffffffc0206dd4:	85c2                	mv	a1,a6
ffffffffc0206dd6:	851a                	mv	a0,t1
ffffffffc0206dd8:	f842                	sd	a6,48(sp)
ffffffffc0206dda:	f41a                	sd	t1,40(sp)
ffffffffc0206ddc:	ff7fd0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206de0:	7e62                	ld	t3,56(sp)
ffffffffc0206de2:	7322                	ld	t1,40(sp)
ffffffffc0206de4:	7842                	ld	a6,48(sp)
ffffffffc0206de6:	1bc509e3          	beq	a0,t3,ffffffffc0207798 <stride_dequeue+0x278a>
ffffffffc0206dea:	01083583          	ld	a1,16(a6)
ffffffffc0206dee:	851a                	mv	a0,t1
ffffffffc0206df0:	00883b03          	ld	s6,8(a6)
ffffffffc0206df4:	f442                	sd	a6,40(sp)
ffffffffc0206df6:	838fe0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206dfa:	7822                	ld	a6,40(sp)
ffffffffc0206dfc:	01683823          	sd	s6,16(a6)
ffffffffc0206e00:	00a83423          	sd	a0,8(a6)
ffffffffc0206e04:	010c2b03          	lw	s6,16(s8)
ffffffffc0206e08:	c119                	beqz	a0,ffffffffc0206e0e <stride_dequeue+0x1e00>
ffffffffc0206e0a:	01053023          	sd	a6,0(a0)
ffffffffc0206e0e:	7782                	ld	a5,32(sp)
ffffffffc0206e10:	0109b423          	sd	a6,8(s3)
ffffffffc0206e14:	00f9b823          	sd	a5,16(s3)
ffffffffc0206e18:	01383023          	sd	s3,0(a6)
ffffffffc0206e1c:	884e                	mv	a6,s3
ffffffffc0206e1e:	ba4ff06f          	j	ffffffffc02061c2 <stride_dequeue+0x11b4>
ffffffffc0206e22:	0089b783          	ld	a5,8(s3)
ffffffffc0206e26:	0109b303          	ld	t1,16(s3)
ffffffffc0206e2a:	fc2a                	sd	a0,56(sp)
ffffffffc0206e2c:	ec3e                	sd	a5,24(sp)
ffffffffc0206e2e:	04030363          	beqz	t1,ffffffffc0206e74 <stride_dequeue+0x1e66>
ffffffffc0206e32:	85c2                	mv	a1,a6
ffffffffc0206e34:	851a                	mv	a0,t1
ffffffffc0206e36:	f832                	sd	a2,48(sp)
ffffffffc0206e38:	f442                	sd	a6,40(sp)
ffffffffc0206e3a:	f01a                	sd	t1,32(sp)
ffffffffc0206e3c:	f97fd0ef          	jal	ra,ffffffffc0204dd2 <proc_stride_comp_f>
ffffffffc0206e40:	7642                	ld	a2,48(sp)
ffffffffc0206e42:	7e62                	ld	t3,56(sp)
ffffffffc0206e44:	7822                	ld	a6,40(sp)
ffffffffc0206e46:	f432                	sd	a2,40(sp)
ffffffffc0206e48:	7302                	ld	t1,32(sp)
ffffffffc0206e4a:	29c507e3          	beq	a0,t3,ffffffffc02078d8 <stride_dequeue+0x28ca>
ffffffffc0206e4e:	01083583          	ld	a1,16(a6)
ffffffffc0206e52:	851a                	mv	a0,t1
ffffffffc0206e54:	00883b03          	ld	s6,8(a6)
ffffffffc0206e58:	f042                	sd	a6,32(sp)
ffffffffc0206e5a:	fd5fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206e5e:	7802                	ld	a6,32(sp)
ffffffffc0206e60:	7622                	ld	a2,40(sp)
ffffffffc0206e62:	01683823          	sd	s6,16(a6)
ffffffffc0206e66:	00a83423          	sd	a0,8(a6)
ffffffffc0206e6a:	010c2b03          	lw	s6,16(s8)
ffffffffc0206e6e:	c119                	beqz	a0,ffffffffc0206e74 <stride_dequeue+0x1e66>
ffffffffc0206e70:	01053023          	sd	a6,0(a0)
ffffffffc0206e74:	67e2                	ld	a5,24(sp)
ffffffffc0206e76:	0109b423          	sd	a6,8(s3)
ffffffffc0206e7a:	00f9b823          	sd	a5,16(s3)
ffffffffc0206e7e:	01383023          	sd	s3,0(a6)
ffffffffc0206e82:	884e                	mv	a6,s3
ffffffffc0206e84:	be2ff06f          	j	ffffffffc0206266 <stride_dequeue+0x1258>
ffffffffc0206e88:	89c6                	mv	s3,a7
ffffffffc0206e8a:	9cffe06f          	j	ffffffffc0205858 <stride_dequeue+0x84a>
ffffffffc0206e8e:	89e6                	mv	s3,s9
ffffffffc0206e90:	aadfe06f          	j	ffffffffc020593c <stride_dequeue+0x92e>
ffffffffc0206e94:	89ee                	mv	s3,s11
ffffffffc0206e96:	d9efe06f          	j	ffffffffc0205434 <stride_dequeue+0x426>
ffffffffc0206e9a:	89d2                	mv	s3,s4
ffffffffc0206e9c:	bb9fe06f          	j	ffffffffc0205a54 <stride_dequeue+0xa46>
ffffffffc0206ea0:	0108b503          	ld	a0,16(a7)
ffffffffc0206ea4:	85ce                	mv	a1,s3
ffffffffc0206ea6:	0088bb03          	ld	s6,8(a7)
ffffffffc0206eaa:	f81a                	sd	t1,48(sp)
ffffffffc0206eac:	f446                	sd	a7,40(sp)
ffffffffc0206eae:	f81fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206eb2:	78a2                	ld	a7,40(sp)
ffffffffc0206eb4:	7342                	ld	t1,48(sp)
ffffffffc0206eb6:	0168b823          	sd	s6,16(a7)
ffffffffc0206eba:	00a8b423          	sd	a0,8(a7)
ffffffffc0206ebe:	010c2b03          	lw	s6,16(s8)
ffffffffc0206ec2:	d179                	beqz	a0,ffffffffc0206e88 <stride_dequeue+0x1e7a>
ffffffffc0206ec4:	01153023          	sd	a7,0(a0)
ffffffffc0206ec8:	89c6                	mv	s3,a7
ffffffffc0206eca:	98ffe06f          	j	ffffffffc0205858 <stride_dequeue+0x84a>
ffffffffc0206ece:	0109b503          	ld	a0,16(s3)
ffffffffc0206ed2:	0089bb03          	ld	s6,8(s3)
ffffffffc0206ed6:	85be                	mv	a1,a5
ffffffffc0206ed8:	f442                	sd	a6,40(sp)
ffffffffc0206eda:	f55fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206ede:	00a9b423          	sd	a0,8(s3)
ffffffffc0206ee2:	0169b823          	sd	s6,16(s3)
ffffffffc0206ee6:	7822                	ld	a6,40(sp)
ffffffffc0206ee8:	010c2b03          	lw	s6,16(s8)
ffffffffc0206eec:	5e050b63          	beqz	a0,ffffffffc02074e2 <stride_dequeue+0x24d4>
ffffffffc0206ef0:	01353023          	sd	s3,0(a0)
ffffffffc0206ef4:	87ce                	mv	a5,s3
ffffffffc0206ef6:	bccff06f          	j	ffffffffc02062c2 <stride_dequeue+0x12b4>
ffffffffc0206efa:	010cb503          	ld	a0,16(s9)
ffffffffc0206efe:	008cbb03          	ld	s6,8(s9)
ffffffffc0206f02:	85ce                	mv	a1,s3
ffffffffc0206f04:	f2bfd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206f08:	00acb423          	sd	a0,8(s9)
ffffffffc0206f0c:	016cb823          	sd	s6,16(s9)
ffffffffc0206f10:	7822                	ld	a6,40(sp)
ffffffffc0206f12:	7342                	ld	t1,48(sp)
ffffffffc0206f14:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f18:	d93d                	beqz	a0,ffffffffc0206e8e <stride_dequeue+0x1e80>
ffffffffc0206f1a:	01953023          	sd	s9,0(a0)
ffffffffc0206f1e:	89e6                	mv	s3,s9
ffffffffc0206f20:	a1dfe06f          	j	ffffffffc020593c <stride_dequeue+0x92e>
ffffffffc0206f24:	0108b503          	ld	a0,16(a7)
ffffffffc0206f28:	85ce                	mv	a1,s3
ffffffffc0206f2a:	0088bb03          	ld	s6,8(a7)
ffffffffc0206f2e:	f842                	sd	a6,48(sp)
ffffffffc0206f30:	f446                	sd	a7,40(sp)
ffffffffc0206f32:	efdfd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206f36:	78a2                	ld	a7,40(sp)
ffffffffc0206f38:	7842                	ld	a6,48(sp)
ffffffffc0206f3a:	0168b823          	sd	s6,16(a7)
ffffffffc0206f3e:	00a8b423          	sd	a0,8(a7)
ffffffffc0206f42:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f46:	c2050ce3          	beqz	a0,ffffffffc0206b7e <stride_dequeue+0x1b70>
ffffffffc0206f4a:	01153023          	sd	a7,0(a0)
ffffffffc0206f4e:	89c6                	mv	s3,a7
ffffffffc0206f50:	e15fe06f          	j	ffffffffc0205d64 <stride_dequeue+0xd56>
ffffffffc0206f54:	010db503          	ld	a0,16(s11)
ffffffffc0206f58:	008dbb03          	ld	s6,8(s11)
ffffffffc0206f5c:	85ce                	mv	a1,s3
ffffffffc0206f5e:	ed1fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206f62:	00adb423          	sd	a0,8(s11)
ffffffffc0206f66:	016db823          	sd	s6,16(s11)
ffffffffc0206f6a:	7602                	ld	a2,32(sp)
ffffffffc0206f6c:	7822                	ld	a6,40(sp)
ffffffffc0206f6e:	7342                	ld	t1,48(sp)
ffffffffc0206f70:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f74:	d105                	beqz	a0,ffffffffc0206e94 <stride_dequeue+0x1e86>
ffffffffc0206f76:	01b53023          	sd	s11,0(a0)
ffffffffc0206f7a:	89ee                	mv	s3,s11
ffffffffc0206f7c:	cb8fe06f          	j	ffffffffc0205434 <stride_dequeue+0x426>
ffffffffc0206f80:	010db503          	ld	a0,16(s11)
ffffffffc0206f84:	008dbb03          	ld	s6,8(s11)
ffffffffc0206f88:	85ce                	mv	a1,s3
ffffffffc0206f8a:	ea5fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206f8e:	00adb423          	sd	a0,8(s11)
ffffffffc0206f92:	016db823          	sd	s6,16(s11)
ffffffffc0206f96:	7322                	ld	t1,40(sp)
ffffffffc0206f98:	7842                	ld	a6,48(sp)
ffffffffc0206f9a:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f9e:	d60502e3          	beqz	a0,ffffffffc0206d02 <stride_dequeue+0x1cf4>
ffffffffc0206fa2:	01b53023          	sd	s11,0(a0)
ffffffffc0206fa6:	89ee                	mv	s3,s11
ffffffffc0206fa8:	b32fe06f          	j	ffffffffc02052da <stride_dequeue+0x2cc>
ffffffffc0206fac:	89e6                	mv	s3,s9
ffffffffc0206fae:	dc2fe06f          	j	ffffffffc0205570 <stride_dequeue+0x562>
ffffffffc0206fb2:	89c6                	mv	s3,a7
ffffffffc0206fb4:	d1bfe06f          	j	ffffffffc0205cce <stride_dequeue+0xcc0>
ffffffffc0206fb8:	00003697          	auipc	a3,0x3
ffffffffc0206fbc:	ab868693          	addi	a3,a3,-1352 # ffffffffc0209a70 <default_pmm_manager+0x748>
ffffffffc0206fc0:	00001617          	auipc	a2,0x1
ffffffffc0206fc4:	62860613          	addi	a2,a2,1576 # ffffffffc02085e8 <commands+0x410>
ffffffffc0206fc8:	06300593          	li	a1,99
ffffffffc0206fcc:	00003517          	auipc	a0,0x3
ffffffffc0206fd0:	acc50513          	addi	a0,a0,-1332 # ffffffffc0209a98 <default_pmm_manager+0x770>
ffffffffc0206fd4:	a34f90ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0206fd8:	89d2                	mv	s3,s4
ffffffffc0206fda:	fb0fe06f          	j	ffffffffc020578a <stride_dequeue+0x77c>
ffffffffc0206fde:	89c6                	mv	s3,a7
ffffffffc0206fe0:	c21fe06f          	j	ffffffffc0205c00 <stride_dequeue+0xbf2>
ffffffffc0206fe4:	89c6                	mv	s3,a7
ffffffffc0206fe6:	b3dfe06f          	j	ffffffffc0205b22 <stride_dequeue+0xb14>
ffffffffc0206fea:	89b2                	mv	s3,a2
ffffffffc0206fec:	ea0fe06f          	j	ffffffffc020568c <stride_dequeue+0x67e>
ffffffffc0206ff0:	0109b503          	ld	a0,16(s3)
ffffffffc0206ff4:	0089bb03          	ld	s6,8(s3)
ffffffffc0206ff8:	85a6                	mv	a1,s1
ffffffffc0206ffa:	e35fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0206ffe:	00a9b423          	sd	a0,8(s3)
ffffffffc0207002:	0169b823          	sd	s6,16(s3)
ffffffffc0207006:	010c2b03          	lw	s6,16(s8)
ffffffffc020700a:	b4050363          	beqz	a0,ffffffffc0206350 <stride_dequeue+0x1342>
ffffffffc020700e:	01353023          	sd	s3,0(a0)
ffffffffc0207012:	b3eff06f          	j	ffffffffc0206350 <stride_dequeue+0x1342>
ffffffffc0207016:	0109b503          	ld	a0,16(s3)
ffffffffc020701a:	0089bb03          	ld	s6,8(s3)
ffffffffc020701e:	859a                	mv	a1,t1
ffffffffc0207020:	f446                	sd	a7,40(sp)
ffffffffc0207022:	e0dfd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207026:	00a9b423          	sd	a0,8(s3)
ffffffffc020702a:	0169b823          	sd	s6,16(s3)
ffffffffc020702e:	78a2                	ld	a7,40(sp)
ffffffffc0207030:	010c2b03          	lw	s6,16(s8)
ffffffffc0207034:	100505e3          	beqz	a0,ffffffffc020793e <stride_dequeue+0x2930>
ffffffffc0207038:	01353023          	sd	s3,0(a0)
ffffffffc020703c:	834e                	mv	t1,s3
ffffffffc020703e:	b0c5                	j	ffffffffc020691e <stride_dequeue+0x1910>
ffffffffc0207040:	0109b503          	ld	a0,16(s3)
ffffffffc0207044:	0089bb03          	ld	s6,8(s3)
ffffffffc0207048:	85f2                	mv	a1,t3
ffffffffc020704a:	f442                	sd	a6,40(sp)
ffffffffc020704c:	f032                	sd	a2,32(sp)
ffffffffc020704e:	de1fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207052:	00a9b423          	sd	a0,8(s3)
ffffffffc0207056:	0169b823          	sd	s6,16(s3)
ffffffffc020705a:	7602                	ld	a2,32(sp)
ffffffffc020705c:	7822                	ld	a6,40(sp)
ffffffffc020705e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207062:	9e050b63          	beqz	a0,ffffffffc0206258 <stride_dequeue+0x124a>
ffffffffc0207066:	01353023          	sd	s3,0(a0)
ffffffffc020706a:	9eeff06f          	j	ffffffffc0206258 <stride_dequeue+0x124a>
ffffffffc020706e:	0109b503          	ld	a0,16(s3)
ffffffffc0207072:	0089bb03          	ld	s6,8(s3)
ffffffffc0207076:	859a                	mv	a1,t1
ffffffffc0207078:	f442                	sd	a6,40(sp)
ffffffffc020707a:	db5fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc020707e:	00a9b423          	sd	a0,8(s3)
ffffffffc0207082:	0169b823          	sd	s6,16(s3)
ffffffffc0207086:	7822                	ld	a6,40(sp)
ffffffffc0207088:	010c2b03          	lw	s6,16(s8)
ffffffffc020708c:	08050de3          	beqz	a0,ffffffffc0207926 <stride_dequeue+0x2918>
ffffffffc0207090:	01353023          	sd	s3,0(a0)
ffffffffc0207094:	834e                	mv	t1,s3
ffffffffc0207096:	efaff06f          	j	ffffffffc0206790 <stride_dequeue+0x1782>
ffffffffc020709a:	89a6                	mv	s3,s1
ffffffffc020709c:	ab4ff06f          	j	ffffffffc0206350 <stride_dequeue+0x1342>
ffffffffc02070a0:	0109b503          	ld	a0,16(s3)
ffffffffc02070a4:	0089bb03          	ld	s6,8(s3)
ffffffffc02070a8:	85ee                	mv	a1,s11
ffffffffc02070aa:	f046                	sd	a7,32(sp)
ffffffffc02070ac:	d83fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02070b0:	00a9b423          	sd	a0,8(s3)
ffffffffc02070b4:	0169b823          	sd	s6,16(s3)
ffffffffc02070b8:	7882                	ld	a7,32(sp)
ffffffffc02070ba:	010c2b03          	lw	s6,16(s8)
ffffffffc02070be:	bc050f63          	beqz	a0,ffffffffc020649c <stride_dequeue+0x148e>
ffffffffc02070c2:	01353023          	sd	s3,0(a0)
ffffffffc02070c6:	bd6ff06f          	j	ffffffffc020649c <stride_dequeue+0x148e>
ffffffffc02070ca:	0109b503          	ld	a0,16(s3)
ffffffffc02070ce:	0089bb03          	ld	s6,8(s3)
ffffffffc02070d2:	85f2                	mv	a1,t3
ffffffffc02070d4:	f442                	sd	a6,40(sp)
ffffffffc02070d6:	d59fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02070da:	00a9b423          	sd	a0,8(s3)
ffffffffc02070de:	0169b823          	sd	s6,16(s3)
ffffffffc02070e2:	7822                	ld	a6,40(sp)
ffffffffc02070e4:	010c2b03          	lw	s6,16(s8)
ffffffffc02070e8:	e119                	bnez	a0,ffffffffc02070ee <stride_dequeue+0x20e0>
ffffffffc02070ea:	8caff06f          	j	ffffffffc02061b4 <stride_dequeue+0x11a6>
ffffffffc02070ee:	01353023          	sd	s3,0(a0)
ffffffffc02070f2:	8c2ff06f          	j	ffffffffc02061b4 <stride_dequeue+0x11a6>
ffffffffc02070f6:	0109b503          	ld	a0,16(s3)
ffffffffc02070fa:	0089bb03          	ld	s6,8(s3)
ffffffffc02070fe:	85b2                	mv	a1,a2
ffffffffc0207100:	ec46                	sd	a7,24(sp)
ffffffffc0207102:	d2dfd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207106:	00a9b423          	sd	a0,8(s3)
ffffffffc020710a:	0169b823          	sd	s6,16(s3)
ffffffffc020710e:	68e2                	ld	a7,24(sp)
ffffffffc0207110:	010c2b03          	lw	s6,16(s8)
ffffffffc0207114:	c2050963          	beqz	a0,ffffffffc0206546 <stride_dequeue+0x1538>
ffffffffc0207118:	01353023          	sd	s3,0(a0)
ffffffffc020711c:	c2aff06f          	j	ffffffffc0206546 <stride_dequeue+0x1538>
ffffffffc0207120:	0109b503          	ld	a0,16(s3)
ffffffffc0207124:	0089bb03          	ld	s6,8(s3)
ffffffffc0207128:	859a                	mv	a1,t1
ffffffffc020712a:	f442                	sd	a6,40(sp)
ffffffffc020712c:	f032                	sd	a2,32(sp)
ffffffffc020712e:	d01fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207132:	00a9b423          	sd	a0,8(s3)
ffffffffc0207136:	0169b823          	sd	s6,16(s3)
ffffffffc020713a:	7602                	ld	a2,32(sp)
ffffffffc020713c:	7822                	ld	a6,40(sp)
ffffffffc020713e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207142:	7c050363          	beqz	a0,ffffffffc0207908 <stride_dequeue+0x28fa>
ffffffffc0207146:	01353023          	sd	s3,0(a0)
ffffffffc020714a:	834e                	mv	t1,s3
ffffffffc020714c:	eaeff06f          	j	ffffffffc02067fa <stride_dequeue+0x17ec>
ffffffffc0207150:	0109b503          	ld	a0,16(s3)
ffffffffc0207154:	0089bb03          	ld	s6,8(s3)
ffffffffc0207158:	85c2                	mv	a1,a6
ffffffffc020715a:	ec32                	sd	a2,24(sp)
ffffffffc020715c:	cd3fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207160:	00a9b423          	sd	a0,8(s3)
ffffffffc0207164:	0169b823          	sd	s6,16(s3)
ffffffffc0207168:	6662                	ld	a2,24(sp)
ffffffffc020716a:	010c2b03          	lw	s6,16(s8)
ffffffffc020716e:	d2050263          	beqz	a0,ffffffffc0206692 <stride_dequeue+0x1684>
ffffffffc0207172:	01353023          	sd	s3,0(a0)
ffffffffc0207176:	d1cff06f          	j	ffffffffc0206692 <stride_dequeue+0x1684>
ffffffffc020717a:	0109b503          	ld	a0,16(s3)
ffffffffc020717e:	0089bb03          	ld	s6,8(s3)
ffffffffc0207182:	85c2                	mv	a1,a6
ffffffffc0207184:	cabfd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207188:	00a9b423          	sd	a0,8(s3)
ffffffffc020718c:	0169b823          	sd	s6,16(s3)
ffffffffc0207190:	010c2b03          	lw	s6,16(s8)
ffffffffc0207194:	c4050b63          	beqz	a0,ffffffffc02065ea <stride_dequeue+0x15dc>
ffffffffc0207198:	01353023          	sd	s3,0(a0)
ffffffffc020719c:	c4eff06f          	j	ffffffffc02065ea <stride_dequeue+0x15dc>
ffffffffc02071a0:	0109b503          	ld	a0,16(s3)
ffffffffc02071a4:	0089bb03          	ld	s6,8(s3)
ffffffffc02071a8:	859a                	mv	a1,t1
ffffffffc02071aa:	c85fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02071ae:	00a9b423          	sd	a0,8(s3)
ffffffffc02071b2:	0169b823          	sd	s6,16(s3)
ffffffffc02071b6:	010c2b03          	lw	s6,16(s8)
ffffffffc02071ba:	e119                	bnez	a0,ffffffffc02071c0 <stride_dequeue+0x21b2>
ffffffffc02071bc:	c77fe06f          	j	ffffffffc0205e32 <stride_dequeue+0xe24>
ffffffffc02071c0:	01353023          	sd	s3,0(a0)
ffffffffc02071c4:	c6ffe06f          	j	ffffffffc0205e32 <stride_dequeue+0xe24>
ffffffffc02071c8:	6a08                	ld	a0,16(a2)
ffffffffc02071ca:	85f2                	mv	a1,t3
ffffffffc02071cc:	00863b03          	ld	s6,8(a2)
ffffffffc02071d0:	c5ffd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02071d4:	7602                	ld	a2,32(sp)
ffffffffc02071d6:	7822                	ld	a6,40(sp)
ffffffffc02071d8:	01663823          	sd	s6,16(a2)
ffffffffc02071dc:	e608                	sd	a0,8(a2)
ffffffffc02071de:	010c2b03          	lw	s6,16(s8)
ffffffffc02071e2:	e119                	bnez	a0,ffffffffc02071e8 <stride_dequeue+0x21da>
ffffffffc02071e4:	c9afe06f          	j	ffffffffc020567e <stride_dequeue+0x670>
ffffffffc02071e8:	e110                	sd	a2,0(a0)
ffffffffc02071ea:	c94fe06f          	j	ffffffffc020567e <stride_dequeue+0x670>
ffffffffc02071ee:	010a3503          	ld	a0,16(s4)
ffffffffc02071f2:	008a3b03          	ld	s6,8(s4)
ffffffffc02071f6:	859a                	mv	a1,t1
ffffffffc02071f8:	c37fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02071fc:	00aa3423          	sd	a0,8(s4)
ffffffffc0207200:	016a3823          	sd	s6,16(s4)
ffffffffc0207204:	010c2b03          	lw	s6,16(s8)
ffffffffc0207208:	e119                	bnez	a0,ffffffffc020720e <stride_dequeue+0x2200>
ffffffffc020720a:	83dfe06f          	j	ffffffffc0205a46 <stride_dequeue+0xa38>
ffffffffc020720e:	01453023          	sd	s4,0(a0)
ffffffffc0207212:	835fe06f          	j	ffffffffc0205a46 <stride_dequeue+0xa38>
ffffffffc0207216:	010cb503          	ld	a0,16(s9)
ffffffffc020721a:	008cbb03          	ld	s6,8(s9)
ffffffffc020721e:	85f2                	mv	a1,t3
ffffffffc0207220:	f442                	sd	a6,40(sp)
ffffffffc0207222:	c0dfd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207226:	00acb423          	sd	a0,8(s9)
ffffffffc020722a:	016cb823          	sd	s6,16(s9)
ffffffffc020722e:	7822                	ld	a6,40(sp)
ffffffffc0207230:	010c2b03          	lw	s6,16(s8)
ffffffffc0207234:	e119                	bnez	a0,ffffffffc020723a <stride_dequeue+0x222c>
ffffffffc0207236:	b2cfe06f          	j	ffffffffc0205562 <stride_dequeue+0x554>
ffffffffc020723a:	01953023          	sd	s9,0(a0)
ffffffffc020723e:	b24fe06f          	j	ffffffffc0205562 <stride_dequeue+0x554>
ffffffffc0207242:	010a3503          	ld	a0,16(s4)
ffffffffc0207246:	008a3b03          	ld	s6,8(s4)
ffffffffc020724a:	85f2                	mv	a1,t3
ffffffffc020724c:	f442                	sd	a6,40(sp)
ffffffffc020724e:	be1fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207252:	00aa3423          	sd	a0,8(s4)
ffffffffc0207256:	016a3823          	sd	s6,16(s4)
ffffffffc020725a:	7822                	ld	a6,40(sp)
ffffffffc020725c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207260:	e119                	bnez	a0,ffffffffc0207266 <stride_dequeue+0x2258>
ffffffffc0207262:	d1afe06f          	j	ffffffffc020577c <stride_dequeue+0x76e>
ffffffffc0207266:	01453023          	sd	s4,0(a0)
ffffffffc020726a:	d12fe06f          	j	ffffffffc020577c <stride_dequeue+0x76e>
ffffffffc020726e:	0108b503          	ld	a0,16(a7)
ffffffffc0207272:	85f2                	mv	a1,t3
ffffffffc0207274:	0088bb03          	ld	s6,8(a7)
ffffffffc0207278:	f046                	sd	a7,32(sp)
ffffffffc020727a:	bb5fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc020727e:	7882                	ld	a7,32(sp)
ffffffffc0207280:	7622                	ld	a2,40(sp)
ffffffffc0207282:	0168b823          	sd	s6,16(a7)
ffffffffc0207286:	00a8b423          	sd	a0,8(a7)
ffffffffc020728a:	010c2b03          	lw	s6,16(s8)
ffffffffc020728e:	e119                	bnez	a0,ffffffffc0207294 <stride_dequeue+0x2286>
ffffffffc0207290:	963fe06f          	j	ffffffffc0205bf2 <stride_dequeue+0xbe4>
ffffffffc0207294:	01153023          	sd	a7,0(a0)
ffffffffc0207298:	95bfe06f          	j	ffffffffc0205bf2 <stride_dequeue+0xbe4>
ffffffffc020729c:	0108b503          	ld	a0,16(a7)
ffffffffc02072a0:	85f2                	mv	a1,t3
ffffffffc02072a2:	0088bb03          	ld	s6,8(a7)
ffffffffc02072a6:	f446                	sd	a7,40(sp)
ffffffffc02072a8:	b87fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02072ac:	78a2                	ld	a7,40(sp)
ffffffffc02072ae:	0168b823          	sd	s6,16(a7)
ffffffffc02072b2:	00a8b423          	sd	a0,8(a7)
ffffffffc02072b6:	010c2b03          	lw	s6,16(s8)
ffffffffc02072ba:	e119                	bnez	a0,ffffffffc02072c0 <stride_dequeue+0x22b2>
ffffffffc02072bc:	a05fe06f          	j	ffffffffc0205cc0 <stride_dequeue+0xcb2>
ffffffffc02072c0:	01153023          	sd	a7,0(a0)
ffffffffc02072c4:	9fdfe06f          	j	ffffffffc0205cc0 <stride_dequeue+0xcb2>
ffffffffc02072c8:	0109b503          	ld	a0,16(s3)
ffffffffc02072cc:	0089bb03          	ld	s6,8(s3)
ffffffffc02072d0:	85c2                	mv	a1,a6
ffffffffc02072d2:	f446                	sd	a7,40(sp)
ffffffffc02072d4:	b5bfd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02072d8:	00a9b423          	sd	a0,8(s3)
ffffffffc02072dc:	0169b823          	sd	s6,16(s3)
ffffffffc02072e0:	78a2                	ld	a7,40(sp)
ffffffffc02072e2:	010c2b03          	lw	s6,16(s8)
ffffffffc02072e6:	66050563          	beqz	a0,ffffffffc0207950 <stride_dequeue+0x2942>
ffffffffc02072ea:	01353023          	sd	s3,0(a0)
ffffffffc02072ee:	884e                	mv	a6,s3
ffffffffc02072f0:	d6aff06f          	j	ffffffffc020685a <stride_dequeue+0x184c>
ffffffffc02072f4:	0109b503          	ld	a0,16(s3)
ffffffffc02072f8:	0089bb03          	ld	s6,8(s3)
ffffffffc02072fc:	85f2                	mv	a1,t3
ffffffffc02072fe:	f442                	sd	a6,40(sp)
ffffffffc0207300:	b2ffd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207304:	00a9b423          	sd	a0,8(s3)
ffffffffc0207308:	0169b823          	sd	s6,16(s3)
ffffffffc020730c:	7822                	ld	a6,40(sp)
ffffffffc020730e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207312:	e119                	bnez	a0,ffffffffc0207318 <stride_dequeue+0x230a>
ffffffffc0207314:	e05fe06f          	j	ffffffffc0206118 <stride_dequeue+0x110a>
ffffffffc0207318:	01353023          	sd	s3,0(a0)
ffffffffc020731c:	dfdfe06f          	j	ffffffffc0206118 <stride_dequeue+0x110a>
ffffffffc0207320:	0109b503          	ld	a0,16(s3)
ffffffffc0207324:	0089bb03          	ld	s6,8(s3)
ffffffffc0207328:	859a                	mv	a1,t1
ffffffffc020732a:	f442                	sd	a6,40(sp)
ffffffffc020732c:	b03fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207330:	00a9b423          	sd	a0,8(s3)
ffffffffc0207334:	0169b823          	sd	s6,16(s3)
ffffffffc0207338:	7822                	ld	a6,40(sp)
ffffffffc020733a:	010c2b03          	lw	s6,16(s8)
ffffffffc020733e:	64050163          	beqz	a0,ffffffffc0207980 <stride_dequeue+0x2972>
ffffffffc0207342:	01353023          	sd	s3,0(a0)
ffffffffc0207346:	834e                	mv	t1,s3
ffffffffc0207348:	d76ff06f          	j	ffffffffc02068be <stride_dequeue+0x18b0>
ffffffffc020734c:	0109b503          	ld	a0,16(s3)
ffffffffc0207350:	0089bb03          	ld	s6,8(s3)
ffffffffc0207354:	85f2                	mv	a1,t3
ffffffffc0207356:	f446                	sd	a7,40(sp)
ffffffffc0207358:	ad7fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc020735c:	00a9b423          	sd	a0,8(s3)
ffffffffc0207360:	0169b823          	sd	s6,16(s3)
ffffffffc0207364:	78a2                	ld	a7,40(sp)
ffffffffc0207366:	010c2b03          	lw	s6,16(s8)
ffffffffc020736a:	e119                	bnez	a0,ffffffffc0207370 <stride_dequeue+0x2362>
ffffffffc020736c:	d0ffe06f          	j	ffffffffc020607a <stride_dequeue+0x106c>
ffffffffc0207370:	01353023          	sd	s3,0(a0)
ffffffffc0207374:	d07fe06f          	j	ffffffffc020607a <stride_dequeue+0x106c>
ffffffffc0207378:	0109b503          	ld	a0,16(s3)
ffffffffc020737c:	0089bb03          	ld	s6,8(s3)
ffffffffc0207380:	859a                	mv	a1,t1
ffffffffc0207382:	aadfd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207386:	00a9b423          	sd	a0,8(s3)
ffffffffc020738a:	0169b823          	sd	s6,16(s3)
ffffffffc020738e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207392:	e119                	bnez	a0,ffffffffc0207398 <stride_dequeue+0x238a>
ffffffffc0207394:	c49fe06f          	j	ffffffffc0205fdc <stride_dequeue+0xfce>
ffffffffc0207398:	01353023          	sd	s3,0(a0)
ffffffffc020739c:	c41fe06f          	j	ffffffffc0205fdc <stride_dequeue+0xfce>
ffffffffc02073a0:	0109b503          	ld	a0,16(s3)
ffffffffc02073a4:	0089bb03          	ld	s6,8(s3)
ffffffffc02073a8:	859a                	mv	a1,t1
ffffffffc02073aa:	ec32                	sd	a2,24(sp)
ffffffffc02073ac:	a83fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02073b0:	00a9b423          	sd	a0,8(s3)
ffffffffc02073b4:	0169b823          	sd	s6,16(s3)
ffffffffc02073b8:	6662                	ld	a2,24(sp)
ffffffffc02073ba:	010c2b03          	lw	s6,16(s8)
ffffffffc02073be:	e119                	bnez	a0,ffffffffc02073c4 <stride_dequeue+0x23b6>
ffffffffc02073c0:	b4ffe06f          	j	ffffffffc0205f0e <stride_dequeue+0xf00>
ffffffffc02073c4:	01353023          	sd	s3,0(a0)
ffffffffc02073c8:	b47fe06f          	j	ffffffffc0205f0e <stride_dequeue+0xf00>
ffffffffc02073cc:	0108b503          	ld	a0,16(a7)
ffffffffc02073d0:	85f2                	mv	a1,t3
ffffffffc02073d2:	0088bb03          	ld	s6,8(a7)
ffffffffc02073d6:	f446                	sd	a7,40(sp)
ffffffffc02073d8:	a57fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02073dc:	78a2                	ld	a7,40(sp)
ffffffffc02073de:	0168b823          	sd	s6,16(a7)
ffffffffc02073e2:	00a8b423          	sd	a0,8(a7)
ffffffffc02073e6:	010c2b03          	lw	s6,16(s8)
ffffffffc02073ea:	e119                	bnez	a0,ffffffffc02073f0 <stride_dequeue+0x23e2>
ffffffffc02073ec:	f28fe06f          	j	ffffffffc0205b14 <stride_dequeue+0xb06>
ffffffffc02073f0:	01153023          	sd	a7,0(a0)
ffffffffc02073f4:	f20fe06f          	j	ffffffffc0205b14 <stride_dequeue+0xb06>
ffffffffc02073f8:	0109b503          	ld	a0,16(s3)
ffffffffc02073fc:	0089bb03          	ld	s6,8(s3)
ffffffffc0207400:	85d2                	mv	a1,s4
ffffffffc0207402:	f046                	sd	a7,32(sp)
ffffffffc0207404:	a2bfd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207408:	00a9b423          	sd	a0,8(s3)
ffffffffc020740c:	0169b823          	sd	s6,16(s3)
ffffffffc0207410:	7882                	ld	a7,32(sp)
ffffffffc0207412:	010c2b03          	lw	s6,16(s8)
ffffffffc0207416:	e119                	bnez	a0,ffffffffc020741c <stride_dequeue+0x240e>
ffffffffc0207418:	fe1fe06f          	j	ffffffffc02063f8 <stride_dequeue+0x13ea>
ffffffffc020741c:	01353023          	sd	s3,0(a0)
ffffffffc0207420:	fd9fe06f          	j	ffffffffc02063f8 <stride_dequeue+0x13ea>
ffffffffc0207424:	0109b503          	ld	a0,16(s3)
ffffffffc0207428:	0089bb03          	ld	s6,8(s3)
ffffffffc020742c:	85c2                	mv	a1,a6
ffffffffc020742e:	a01fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207432:	00a9b423          	sd	a0,8(s3)
ffffffffc0207436:	0169b823          	sd	s6,16(s3)
ffffffffc020743a:	010c2b03          	lw	s6,16(s8)
ffffffffc020743e:	ae050863          	beqz	a0,ffffffffc020672e <stride_dequeue+0x1720>
ffffffffc0207442:	01353023          	sd	s3,0(a0)
ffffffffc0207446:	ae8ff06f          	j	ffffffffc020672e <stride_dequeue+0x1720>
ffffffffc020744a:	89d2                	mv	s3,s4
ffffffffc020744c:	fadfe06f          	j	ffffffffc02063f8 <stride_dequeue+0x13ea>
ffffffffc0207450:	89ee                	mv	s3,s11
ffffffffc0207452:	84aff06f          	j	ffffffffc020649c <stride_dequeue+0x148e>
ffffffffc0207456:	89c2                	mv	s3,a6
ffffffffc0207458:	992ff06f          	j	ffffffffc02065ea <stride_dequeue+0x15dc>
ffffffffc020745c:	89c2                	mv	s3,a6
ffffffffc020745e:	a34ff06f          	j	ffffffffc0206692 <stride_dequeue+0x1684>
ffffffffc0207462:	89b2                	mv	s3,a2
ffffffffc0207464:	8e2ff06f          	j	ffffffffc0206546 <stride_dequeue+0x1538>
ffffffffc0207468:	89c2                	mv	s3,a6
ffffffffc020746a:	ac4ff06f          	j	ffffffffc020672e <stride_dequeue+0x1720>
ffffffffc020746e:	01083503          	ld	a0,16(a6)
ffffffffc0207472:	85e6                	mv	a1,s9
ffffffffc0207474:	00883b03          	ld	s6,8(a6)
ffffffffc0207478:	9b7fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc020747c:	7802                	ld	a6,32(sp)
ffffffffc020747e:	01683823          	sd	s6,16(a6)
ffffffffc0207482:	00a83423          	sd	a0,8(a6)
ffffffffc0207486:	010c2b03          	lw	s6,16(s8)
ffffffffc020748a:	50050163          	beqz	a0,ffffffffc020798c <stride_dequeue+0x297e>
ffffffffc020748e:	01053023          	sd	a6,0(a0)
ffffffffc0207492:	8cc2                	mv	s9,a6
ffffffffc0207494:	d62ff06f          	j	ffffffffc02069f6 <stride_dequeue+0x19e8>
ffffffffc0207498:	01083503          	ld	a0,16(a6)
ffffffffc020749c:	85d2                	mv	a1,s4
ffffffffc020749e:	00883b03          	ld	s6,8(a6)
ffffffffc02074a2:	98dfd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02074a6:	6862                	ld	a6,24(sp)
ffffffffc02074a8:	7602                	ld	a2,32(sp)
ffffffffc02074aa:	01683823          	sd	s6,16(a6)
ffffffffc02074ae:	00a83423          	sd	a0,8(a6)
ffffffffc02074b2:	010c2b03          	lw	s6,16(s8)
ffffffffc02074b6:	4c050863          	beqz	a0,ffffffffc0207986 <stride_dequeue+0x2978>
ffffffffc02074ba:	01053023          	sd	a6,0(a0)
ffffffffc02074be:	8a42                	mv	s4,a6
ffffffffc02074c0:	d94ff06f          	j	ffffffffc0206a54 <stride_dequeue+0x1a46>
ffffffffc02074c4:	89f2                	mv	s3,t3
ffffffffc02074c6:	bb5fe06f          	j	ffffffffc020607a <stride_dequeue+0x106c>
ffffffffc02074ca:	88f2                	mv	a7,t3
ffffffffc02074cc:	e48fe06f          	j	ffffffffc0205b14 <stride_dequeue+0xb06>
ffffffffc02074d0:	89f2                	mv	s3,t3
ffffffffc02074d2:	ce3fe06f          	j	ffffffffc02061b4 <stride_dequeue+0x11a6>
ffffffffc02074d6:	89f2                	mv	s3,t3
ffffffffc02074d8:	c41fe06f          	j	ffffffffc0206118 <stride_dequeue+0x110a>
ffffffffc02074dc:	88f2                	mv	a7,t3
ffffffffc02074de:	fe2fe06f          	j	ffffffffc0205cc0 <stride_dequeue+0xcb2>
ffffffffc02074e2:	87ce                	mv	a5,s3
ffffffffc02074e4:	ddffe06f          	j	ffffffffc02062c2 <stride_dequeue+0x12b4>
ffffffffc02074e8:	0108b503          	ld	a0,16(a7)
ffffffffc02074ec:	85ce                	mv	a1,s3
ffffffffc02074ee:	0088bb03          	ld	s6,8(a7)
ffffffffc02074f2:	93dfd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02074f6:	7882                	ld	a7,32(sp)
ffffffffc02074f8:	0168b823          	sd	s6,16(a7)
ffffffffc02074fc:	00a8b423          	sd	a0,8(a7)
ffffffffc0207500:	010c2b03          	lw	s6,16(s8)
ffffffffc0207504:	42050a63          	beqz	a0,ffffffffc0207938 <stride_dequeue+0x292a>
ffffffffc0207508:	01153023          	sd	a7,0(a0)
ffffffffc020750c:	89c6                	mv	s3,a7
ffffffffc020750e:	d9cff06f          	j	ffffffffc0206aaa <stride_dequeue+0x1a9c>
ffffffffc0207512:	8cf2                	mv	s9,t3
ffffffffc0207514:	84efe06f          	j	ffffffffc0205562 <stride_dequeue+0x554>
ffffffffc0207518:	8a72                	mv	s4,t3
ffffffffc020751a:	a62fe06f          	j	ffffffffc020577c <stride_dequeue+0x76e>
ffffffffc020751e:	88f2                	mv	a7,t3
ffffffffc0207520:	ed2fe06f          	j	ffffffffc0205bf2 <stride_dequeue+0xbe4>
ffffffffc0207524:	89f2                	mv	s3,t3
ffffffffc0207526:	d33fe06f          	j	ffffffffc0206258 <stride_dequeue+0x124a>
ffffffffc020752a:	0109b503          	ld	a0,16(s3)
ffffffffc020752e:	0089bb03          	ld	s6,8(s3)
ffffffffc0207532:	85c6                	mv	a1,a7
ffffffffc0207534:	8fbfd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207538:	00a9b423          	sd	a0,8(s3)
ffffffffc020753c:	0169b823          	sd	s6,16(s3)
ffffffffc0207540:	010c2b03          	lw	s6,16(s8)
ffffffffc0207544:	e119                	bnez	a0,ffffffffc020754a <stride_dequeue+0x253c>
ffffffffc0207546:	dfdfe06f          	j	ffffffffc0206342 <stride_dequeue+0x1334>
ffffffffc020754a:	01353023          	sd	s3,0(a0)
ffffffffc020754e:	df5fe06f          	j	ffffffffc0206342 <stride_dequeue+0x1334>
ffffffffc0207552:	01083503          	ld	a0,16(a6)
ffffffffc0207556:	85d2                	mv	a1,s4
ffffffffc0207558:	00883b03          	ld	s6,8(a6)
ffffffffc020755c:	8d3fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207560:	7802                	ld	a6,32(sp)
ffffffffc0207562:	01683823          	sd	s6,16(a6)
ffffffffc0207566:	00a83423          	sd	a0,8(a6)
ffffffffc020756a:	010c2b03          	lw	s6,16(s8)
ffffffffc020756e:	3a050363          	beqz	a0,ffffffffc0207914 <stride_dequeue+0x2906>
ffffffffc0207572:	01053023          	sd	a6,0(a0)
ffffffffc0207576:	8a42                	mv	s4,a6
ffffffffc0207578:	c28ff06f          	j	ffffffffc02069a0 <stride_dequeue+0x1992>
ffffffffc020757c:	8672                	mv	a2,t3
ffffffffc020757e:	900fe06f          	j	ffffffffc020567e <stride_dequeue+0x670>
ffffffffc0207582:	0108b503          	ld	a0,16(a7)
ffffffffc0207586:	85ce                	mv	a1,s3
ffffffffc0207588:	0088bb03          	ld	s6,8(a7)
ffffffffc020758c:	8a3fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207590:	7882                	ld	a7,32(sp)
ffffffffc0207592:	7622                	ld	a2,40(sp)
ffffffffc0207594:	7842                	ld	a6,48(sp)
ffffffffc0207596:	0168b823          	sd	s6,16(a7)
ffffffffc020759a:	00a8b423          	sd	a0,8(a7)
ffffffffc020759e:	010c2b03          	lw	s6,16(s8)
ffffffffc02075a2:	3c050c63          	beqz	a0,ffffffffc020797a <stride_dequeue+0x296c>
ffffffffc02075a6:	01153023          	sd	a7,0(a0)
ffffffffc02075aa:	89c6                	mv	s3,a7
ffffffffc02075ac:	dc0ff06f          	j	ffffffffc0206b6c <stride_dequeue+0x1b5e>
ffffffffc02075b0:	0109b503          	ld	a0,16(s3)
ffffffffc02075b4:	0089bb03          	ld	s6,8(s3)
ffffffffc02075b8:	85f2                	mv	a1,t3
ffffffffc02075ba:	f41a                	sd	t1,40(sp)
ffffffffc02075bc:	873fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02075c0:	00a9b423          	sd	a0,8(s3)
ffffffffc02075c4:	0169b823          	sd	s6,16(s3)
ffffffffc02075c8:	7322                	ld	t1,40(sp)
ffffffffc02075ca:	010c2b03          	lw	s6,16(s8)
ffffffffc02075ce:	e119                	bnez	a0,ffffffffc02075d4 <stride_dequeue+0x25c6>
ffffffffc02075d0:	9fdfe06f          	j	ffffffffc0205fcc <stride_dequeue+0xfbe>
ffffffffc02075d4:	01353023          	sd	s3,0(a0)
ffffffffc02075d8:	9f5fe06f          	j	ffffffffc0205fcc <stride_dequeue+0xfbe>
ffffffffc02075dc:	01033503          	ld	a0,16(t1)
ffffffffc02075e0:	85e6                	mv	a1,s9
ffffffffc02075e2:	00833b03          	ld	s6,8(t1)
ffffffffc02075e6:	849fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02075ea:	7322                	ld	t1,40(sp)
ffffffffc02075ec:	78c2                	ld	a7,48(sp)
ffffffffc02075ee:	01633823          	sd	s6,16(t1)
ffffffffc02075f2:	00a33423          	sd	a0,8(t1)
ffffffffc02075f6:	010c2b03          	lw	s6,16(s8)
ffffffffc02075fa:	34050e63          	beqz	a0,ffffffffc0207956 <stride_dequeue+0x2948>
ffffffffc02075fe:	00653023          	sd	t1,0(a0)
ffffffffc0207602:	8c9a                	mv	s9,t1
ffffffffc0207604:	eeaff06f          	j	ffffffffc0206cee <stride_dequeue+0x1ce0>
ffffffffc0207608:	01033503          	ld	a0,16(t1)
ffffffffc020760c:	85c2                	mv	a1,a6
ffffffffc020760e:	00833b03          	ld	s6,8(t1)
ffffffffc0207612:	81dfd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207616:	7322                	ld	t1,40(sp)
ffffffffc0207618:	01633823          	sd	s6,16(t1)
ffffffffc020761c:	00a33423          	sd	a0,8(t1)
ffffffffc0207620:	010c2b03          	lw	s6,16(s8)
ffffffffc0207624:	32050c63          	beqz	a0,ffffffffc020795c <stride_dequeue+0x294e>
ffffffffc0207628:	00653023          	sd	t1,0(a0)
ffffffffc020762c:	881a                	mv	a6,t1
ffffffffc020762e:	f24ff06f          	j	ffffffffc0206d52 <stride_dequeue+0x1d44>
ffffffffc0207632:	0108b503          	ld	a0,16(a7)
ffffffffc0207636:	85ce                	mv	a1,s3
ffffffffc0207638:	0088bb03          	ld	s6,8(a7)
ffffffffc020763c:	ff2fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207640:	78a2                	ld	a7,40(sp)
ffffffffc0207642:	7842                	ld	a6,48(sp)
ffffffffc0207644:	0168b823          	sd	s6,16(a7)
ffffffffc0207648:	00a8b423          	sd	a0,8(a7)
ffffffffc020764c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207650:	30050963          	beqz	a0,ffffffffc0207962 <stride_dequeue+0x2954>
ffffffffc0207654:	01153023          	sd	a7,0(a0)
ffffffffc0207658:	89c6                	mv	s3,a7
ffffffffc020765a:	caeff06f          	j	ffffffffc0206b08 <stride_dequeue+0x1afa>
ffffffffc020765e:	01083503          	ld	a0,16(a6)
ffffffffc0207662:	85ce                	mv	a1,s3
ffffffffc0207664:	00883b03          	ld	s6,8(a6)
ffffffffc0207668:	fc6fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc020766c:	7822                	ld	a6,40(sp)
ffffffffc020766e:	78c2                	ld	a7,48(sp)
ffffffffc0207670:	01683823          	sd	s6,16(a6)
ffffffffc0207674:	00a83423          	sd	a0,8(a6)
ffffffffc0207678:	010c2b03          	lw	s6,16(s8)
ffffffffc020767c:	30050b63          	beqz	a0,ffffffffc0207992 <stride_dequeue+0x2984>
ffffffffc0207680:	01053023          	sd	a6,0(a0)
ffffffffc0207684:	89c2                	mv	s3,a6
ffffffffc0207686:	da6ff06f          	j	ffffffffc0206c2c <stride_dequeue+0x1c1e>
ffffffffc020768a:	01083503          	ld	a0,16(a6)
ffffffffc020768e:	85ce                	mv	a1,s3
ffffffffc0207690:	00883b03          	ld	s6,8(a6)
ffffffffc0207694:	f9afd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207698:	7802                	ld	a6,32(sp)
ffffffffc020769a:	7622                	ld	a2,40(sp)
ffffffffc020769c:	78c2                	ld	a7,48(sp)
ffffffffc020769e:	01683823          	sd	s6,16(a6)
ffffffffc02076a2:	00a83423          	sd	a0,8(a6)
ffffffffc02076a6:	010c2b03          	lw	s6,16(s8)
ffffffffc02076aa:	2a050063          	beqz	a0,ffffffffc020794a <stride_dequeue+0x293c>
ffffffffc02076ae:	01053023          	sd	a6,0(a0)
ffffffffc02076b2:	89c2                	mv	s3,a6
ffffffffc02076b4:	ddcff06f          	j	ffffffffc0206c90 <stride_dequeue+0x1c82>
ffffffffc02076b8:	0109b503          	ld	a0,16(s3)
ffffffffc02076bc:	0089bb03          	ld	s6,8(s3)
ffffffffc02076c0:	85f2                	mv	a1,t3
ffffffffc02076c2:	f41a                	sd	t1,40(sp)
ffffffffc02076c4:	f6afd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02076c8:	00a9b423          	sd	a0,8(s3)
ffffffffc02076cc:	0169b823          	sd	s6,16(s3)
ffffffffc02076d0:	7322                	ld	t1,40(sp)
ffffffffc02076d2:	010c2b03          	lw	s6,16(s8)
ffffffffc02076d6:	e119                	bnez	a0,ffffffffc02076dc <stride_dequeue+0x26ce>
ffffffffc02076d8:	f4afe06f          	j	ffffffffc0205e22 <stride_dequeue+0xe14>
ffffffffc02076dc:	01353023          	sd	s3,0(a0)
ffffffffc02076e0:	f42fe06f          	j	ffffffffc0205e22 <stride_dequeue+0xe14>
ffffffffc02076e4:	0109b503          	ld	a0,16(s3)
ffffffffc02076e8:	0089bb03          	ld	s6,8(s3)
ffffffffc02076ec:	85f2                	mv	a1,t3
ffffffffc02076ee:	f446                	sd	a7,40(sp)
ffffffffc02076f0:	f3efd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02076f4:	00a9b423          	sd	a0,8(s3)
ffffffffc02076f8:	0169b823          	sd	s6,16(s3)
ffffffffc02076fc:	78a2                	ld	a7,40(sp)
ffffffffc02076fe:	010c2b03          	lw	s6,16(s8)
ffffffffc0207702:	e119                	bnez	a0,ffffffffc0207708 <stride_dequeue+0x26fa>
ffffffffc0207704:	ce5fe06f          	j	ffffffffc02063e8 <stride_dequeue+0x13da>
ffffffffc0207708:	01353023          	sd	s3,0(a0)
ffffffffc020770c:	cddfe06f          	j	ffffffffc02063e8 <stride_dequeue+0x13da>
ffffffffc0207710:	0109b503          	ld	a0,16(s3)
ffffffffc0207714:	0089bb03          	ld	s6,8(s3)
ffffffffc0207718:	85f2                	mv	a1,t3
ffffffffc020771a:	f446                	sd	a7,40(sp)
ffffffffc020771c:	f032                	sd	a2,32(sp)
ffffffffc020771e:	f10fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207722:	00a9b423          	sd	a0,8(s3)
ffffffffc0207726:	0169b823          	sd	s6,16(s3)
ffffffffc020772a:	7602                	ld	a2,32(sp)
ffffffffc020772c:	78a2                	ld	a7,40(sp)
ffffffffc020772e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207732:	e119                	bnez	a0,ffffffffc0207738 <stride_dequeue+0x272a>
ffffffffc0207734:	e05fe06f          	j	ffffffffc0206538 <stride_dequeue+0x152a>
ffffffffc0207738:	01353023          	sd	s3,0(a0)
ffffffffc020773c:	dfdfe06f          	j	ffffffffc0206538 <stride_dequeue+0x152a>
ffffffffc0207740:	010a3503          	ld	a0,16(s4)
ffffffffc0207744:	008a3b03          	ld	s6,8(s4)
ffffffffc0207748:	85f2                	mv	a1,t3
ffffffffc020774a:	f41a                	sd	t1,40(sp)
ffffffffc020774c:	ee2fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207750:	00aa3423          	sd	a0,8(s4)
ffffffffc0207754:	016a3823          	sd	s6,16(s4)
ffffffffc0207758:	7322                	ld	t1,40(sp)
ffffffffc020775a:	010c2b03          	lw	s6,16(s8)
ffffffffc020775e:	e119                	bnez	a0,ffffffffc0207764 <stride_dequeue+0x2756>
ffffffffc0207760:	ad6fe06f          	j	ffffffffc0205a36 <stride_dequeue+0xa28>
ffffffffc0207764:	01453023          	sd	s4,0(a0)
ffffffffc0207768:	acefe06f          	j	ffffffffc0205a36 <stride_dequeue+0xa28>
ffffffffc020776c:	0109b503          	ld	a0,16(s3)
ffffffffc0207770:	0089bb03          	ld	s6,8(s3)
ffffffffc0207774:	85f2                	mv	a1,t3
ffffffffc0207776:	f446                	sd	a7,40(sp)
ffffffffc0207778:	eb6fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc020777c:	00a9b423          	sd	a0,8(s3)
ffffffffc0207780:	0169b823          	sd	s6,16(s3)
ffffffffc0207784:	78a2                	ld	a7,40(sp)
ffffffffc0207786:	010c2b03          	lw	s6,16(s8)
ffffffffc020778a:	e119                	bnez	a0,ffffffffc0207790 <stride_dequeue+0x2782>
ffffffffc020778c:	d01fe06f          	j	ffffffffc020648c <stride_dequeue+0x147e>
ffffffffc0207790:	01353023          	sd	s3,0(a0)
ffffffffc0207794:	cf9fe06f          	j	ffffffffc020648c <stride_dequeue+0x147e>
ffffffffc0207798:	01033503          	ld	a0,16(t1)
ffffffffc020779c:	85c2                	mv	a1,a6
ffffffffc020779e:	00833b03          	ld	s6,8(t1)
ffffffffc02077a2:	e8cfd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02077a6:	7322                	ld	t1,40(sp)
ffffffffc02077a8:	01633823          	sd	s6,16(t1)
ffffffffc02077ac:	00a33423          	sd	a0,8(t1)
ffffffffc02077b0:	010c2b03          	lw	s6,16(s8)
ffffffffc02077b4:	1e050b63          	beqz	a0,ffffffffc02079aa <stride_dequeue+0x299c>
ffffffffc02077b8:	00653023          	sd	t1,0(a0)
ffffffffc02077bc:	881a                	mv	a6,t1
ffffffffc02077be:	e50ff06f          	j	ffffffffc0206e0e <stride_dequeue+0x1e00>
ffffffffc02077c2:	0109b503          	ld	a0,16(s3)
ffffffffc02077c6:	0089bb03          	ld	s6,8(s3)
ffffffffc02077ca:	85f2                	mv	a1,t3
ffffffffc02077cc:	f442                	sd	a6,40(sp)
ffffffffc02077ce:	f032                	sd	a2,32(sp)
ffffffffc02077d0:	e5efd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02077d4:	00a9b423          	sd	a0,8(s3)
ffffffffc02077d8:	0169b823          	sd	s6,16(s3)
ffffffffc02077dc:	7602                	ld	a2,32(sp)
ffffffffc02077de:	7822                	ld	a6,40(sp)
ffffffffc02077e0:	010c2b03          	lw	s6,16(s8)
ffffffffc02077e4:	e119                	bnez	a0,ffffffffc02077ea <stride_dequeue+0x27dc>
ffffffffc02077e6:	e9dfe06f          	j	ffffffffc0206682 <stride_dequeue+0x1674>
ffffffffc02077ea:	01353023          	sd	s3,0(a0)
ffffffffc02077ee:	e95fe06f          	j	ffffffffc0206682 <stride_dequeue+0x1674>
ffffffffc02077f2:	0108b503          	ld	a0,16(a7)
ffffffffc02077f6:	85ce                	mv	a1,s3
ffffffffc02077f8:	0088bb03          	ld	s6,8(a7)
ffffffffc02077fc:	e32fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207800:	78a2                	ld	a7,40(sp)
ffffffffc0207802:	7842                	ld	a6,48(sp)
ffffffffc0207804:	0168b823          	sd	s6,16(a7)
ffffffffc0207808:	00a8b423          	sd	a0,8(a7)
ffffffffc020780c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207810:	0e050f63          	beqz	a0,ffffffffc020790e <stride_dequeue+0x2900>
ffffffffc0207814:	01153023          	sd	a7,0(a0)
ffffffffc0207818:	89c6                	mv	s3,a7
ffffffffc020781a:	d96ff06f          	j	ffffffffc0206db0 <stride_dequeue+0x1da2>
ffffffffc020781e:	01083503          	ld	a0,16(a6)
ffffffffc0207822:	85ce                	mv	a1,s3
ffffffffc0207824:	00883b03          	ld	s6,8(a6)
ffffffffc0207828:	e06fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc020782c:	7822                	ld	a6,40(sp)
ffffffffc020782e:	78c2                	ld	a7,48(sp)
ffffffffc0207830:	01683823          	sd	s6,16(a6)
ffffffffc0207834:	00a83423          	sd	a0,8(a6)
ffffffffc0207838:	010c2b03          	lw	s6,16(s8)
ffffffffc020783c:	0e050b63          	beqz	a0,ffffffffc0207932 <stride_dequeue+0x2924>
ffffffffc0207840:	01053023          	sd	a6,0(a0)
ffffffffc0207844:	89c2                	mv	s3,a6
ffffffffc0207846:	b88ff06f          	j	ffffffffc0206bce <stride_dequeue+0x1bc0>
ffffffffc020784a:	0109b503          	ld	a0,16(s3)
ffffffffc020784e:	0089bb03          	ld	s6,8(s3)
ffffffffc0207852:	85f2                	mv	a1,t3
ffffffffc0207854:	f442                	sd	a6,40(sp)
ffffffffc0207856:	dd8fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc020785a:	00a9b423          	sd	a0,8(s3)
ffffffffc020785e:	0169b823          	sd	s6,16(s3)
ffffffffc0207862:	7822                	ld	a6,40(sp)
ffffffffc0207864:	010c2b03          	lw	s6,16(s8)
ffffffffc0207868:	e119                	bnez	a0,ffffffffc020786e <stride_dequeue+0x2860>
ffffffffc020786a:	d71fe06f          	j	ffffffffc02065da <stride_dequeue+0x15cc>
ffffffffc020786e:	01353023          	sd	s3,0(a0)
ffffffffc0207872:	d69fe06f          	j	ffffffffc02065da <stride_dequeue+0x15cc>
ffffffffc0207876:	0109b503          	ld	a0,16(s3)
ffffffffc020787a:	0089bb03          	ld	s6,8(s3)
ffffffffc020787e:	85f2                	mv	a1,t3
ffffffffc0207880:	f442                	sd	a6,40(sp)
ffffffffc0207882:	dacfd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc0207886:	00a9b423          	sd	a0,8(s3)
ffffffffc020788a:	0169b823          	sd	s6,16(s3)
ffffffffc020788e:	7822                	ld	a6,40(sp)
ffffffffc0207890:	010c2b03          	lw	s6,16(s8)
ffffffffc0207894:	e119                	bnez	a0,ffffffffc020789a <stride_dequeue+0x288c>
ffffffffc0207896:	e89fe06f          	j	ffffffffc020671e <stride_dequeue+0x1710>
ffffffffc020789a:	01353023          	sd	s3,0(a0)
ffffffffc020789e:	e81fe06f          	j	ffffffffc020671e <stride_dequeue+0x1710>
ffffffffc02078a2:	89c6                	mv	s3,a7
ffffffffc02078a4:	a9ffe06f          	j	ffffffffc0206342 <stride_dequeue+0x1334>
ffffffffc02078a8:	0109b503          	ld	a0,16(s3)
ffffffffc02078ac:	0089bb03          	ld	s6,8(s3)
ffffffffc02078b0:	85f2                	mv	a1,t3
ffffffffc02078b2:	f41a                	sd	t1,40(sp)
ffffffffc02078b4:	f032                	sd	a2,32(sp)
ffffffffc02078b6:	d78fd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02078ba:	00a9b423          	sd	a0,8(s3)
ffffffffc02078be:	0169b823          	sd	s6,16(s3)
ffffffffc02078c2:	7602                	ld	a2,32(sp)
ffffffffc02078c4:	7322                	ld	t1,40(sp)
ffffffffc02078c6:	010c2b03          	lw	s6,16(s8)
ffffffffc02078ca:	e119                	bnez	a0,ffffffffc02078d0 <stride_dequeue+0x28c2>
ffffffffc02078cc:	e32fe06f          	j	ffffffffc0205efe <stride_dequeue+0xef0>
ffffffffc02078d0:	01353023          	sd	s3,0(a0)
ffffffffc02078d4:	e2afe06f          	j	ffffffffc0205efe <stride_dequeue+0xef0>
ffffffffc02078d8:	01033503          	ld	a0,16(t1)
ffffffffc02078dc:	85c2                	mv	a1,a6
ffffffffc02078de:	00833b03          	ld	s6,8(t1)
ffffffffc02078e2:	d4cfd0ef          	jal	ra,ffffffffc0204e2e <skew_heap_merge.constprop.0>
ffffffffc02078e6:	7302                	ld	t1,32(sp)
ffffffffc02078e8:	7622                	ld	a2,40(sp)
ffffffffc02078ea:	01633823          	sd	s6,16(t1)
ffffffffc02078ee:	00a33423          	sd	a0,8(t1)
ffffffffc02078f2:	010c2b03          	lw	s6,16(s8)
ffffffffc02078f6:	c115                	beqz	a0,ffffffffc020791a <stride_dequeue+0x290c>
ffffffffc02078f8:	00653023          	sd	t1,0(a0)
ffffffffc02078fc:	881a                	mv	a6,t1
ffffffffc02078fe:	d76ff06f          	j	ffffffffc0206e74 <stride_dequeue+0x1e66>
ffffffffc0207902:	89f2                	mv	s3,t3
ffffffffc0207904:	e1bfe06f          	j	ffffffffc020671e <stride_dequeue+0x1710>
ffffffffc0207908:	834e                	mv	t1,s3
ffffffffc020790a:	ef1fe06f          	j	ffffffffc02067fa <stride_dequeue+0x17ec>
ffffffffc020790e:	89c6                	mv	s3,a7
ffffffffc0207910:	ca0ff06f          	j	ffffffffc0206db0 <stride_dequeue+0x1da2>
ffffffffc0207914:	8a42                	mv	s4,a6
ffffffffc0207916:	88aff06f          	j	ffffffffc02069a0 <stride_dequeue+0x1992>
ffffffffc020791a:	881a                	mv	a6,t1
ffffffffc020791c:	d58ff06f          	j	ffffffffc0206e74 <stride_dequeue+0x1e66>
ffffffffc0207920:	89f2                	mv	s3,t3
ffffffffc0207922:	ddcfe06f          	j	ffffffffc0205efe <stride_dequeue+0xef0>
ffffffffc0207926:	834e                	mv	t1,s3
ffffffffc0207928:	e69fe06f          	j	ffffffffc0206790 <stride_dequeue+0x1782>
ffffffffc020792c:	89f2                	mv	s3,t3
ffffffffc020792e:	cadfe06f          	j	ffffffffc02065da <stride_dequeue+0x15cc>
ffffffffc0207932:	89c2                	mv	s3,a6
ffffffffc0207934:	a9aff06f          	j	ffffffffc0206bce <stride_dequeue+0x1bc0>
ffffffffc0207938:	89c6                	mv	s3,a7
ffffffffc020793a:	970ff06f          	j	ffffffffc0206aaa <stride_dequeue+0x1a9c>
ffffffffc020793e:	834e                	mv	t1,s3
ffffffffc0207940:	fdffe06f          	j	ffffffffc020691e <stride_dequeue+0x1910>
ffffffffc0207944:	89f2                	mv	s3,t3
ffffffffc0207946:	cdcfe06f          	j	ffffffffc0205e22 <stride_dequeue+0xe14>
ffffffffc020794a:	89c2                	mv	s3,a6
ffffffffc020794c:	b44ff06f          	j	ffffffffc0206c90 <stride_dequeue+0x1c82>
ffffffffc0207950:	884e                	mv	a6,s3
ffffffffc0207952:	f09fe06f          	j	ffffffffc020685a <stride_dequeue+0x184c>
ffffffffc0207956:	8c9a                	mv	s9,t1
ffffffffc0207958:	b96ff06f          	j	ffffffffc0206cee <stride_dequeue+0x1ce0>
ffffffffc020795c:	881a                	mv	a6,t1
ffffffffc020795e:	bf4ff06f          	j	ffffffffc0206d52 <stride_dequeue+0x1d44>
ffffffffc0207962:	89c6                	mv	s3,a7
ffffffffc0207964:	9a4ff06f          	j	ffffffffc0206b08 <stride_dequeue+0x1afa>
ffffffffc0207968:	89f2                	mv	s3,t3
ffffffffc020796a:	a7ffe06f          	j	ffffffffc02063e8 <stride_dequeue+0x13da>
ffffffffc020796e:	89f2                	mv	s3,t3
ffffffffc0207970:	bc9fe06f          	j	ffffffffc0206538 <stride_dequeue+0x152a>
ffffffffc0207974:	89f2                	mv	s3,t3
ffffffffc0207976:	e56fe06f          	j	ffffffffc0205fcc <stride_dequeue+0xfbe>
ffffffffc020797a:	89c6                	mv	s3,a7
ffffffffc020797c:	9f0ff06f          	j	ffffffffc0206b6c <stride_dequeue+0x1b5e>
ffffffffc0207980:	834e                	mv	t1,s3
ffffffffc0207982:	f3dfe06f          	j	ffffffffc02068be <stride_dequeue+0x18b0>
ffffffffc0207986:	8a42                	mv	s4,a6
ffffffffc0207988:	8ccff06f          	j	ffffffffc0206a54 <stride_dequeue+0x1a46>
ffffffffc020798c:	8cc2                	mv	s9,a6
ffffffffc020798e:	868ff06f          	j	ffffffffc02069f6 <stride_dequeue+0x19e8>
ffffffffc0207992:	89c2                	mv	s3,a6
ffffffffc0207994:	a98ff06f          	j	ffffffffc0206c2c <stride_dequeue+0x1c1e>
ffffffffc0207998:	8a72                	mv	s4,t3
ffffffffc020799a:	89cfe06f          	j	ffffffffc0205a36 <stride_dequeue+0xa28>
ffffffffc020799e:	89f2                	mv	s3,t3
ffffffffc02079a0:	aedfe06f          	j	ffffffffc020648c <stride_dequeue+0x147e>
ffffffffc02079a4:	89f2                	mv	s3,t3
ffffffffc02079a6:	cddfe06f          	j	ffffffffc0206682 <stride_dequeue+0x1674>
ffffffffc02079aa:	881a                	mv	a6,t1
ffffffffc02079ac:	c62ff06f          	j	ffffffffc0206e0e <stride_dequeue+0x1e00>

ffffffffc02079b0 <sys_getpid>:
ffffffffc02079b0:	00012797          	auipc	a5,0x12
ffffffffc02079b4:	b487b783          	ld	a5,-1208(a5) # ffffffffc02194f8 <current>
ffffffffc02079b8:	43c8                	lw	a0,4(a5)
ffffffffc02079ba:	8082                	ret

ffffffffc02079bc <sys_pgdir>:
ffffffffc02079bc:	4501                	li	a0,0
ffffffffc02079be:	8082                	ret

ffffffffc02079c0 <sys_gettime>:
ffffffffc02079c0:	00012797          	auipc	a5,0x12
ffffffffc02079c4:	b687b783          	ld	a5,-1176(a5) # ffffffffc0219528 <ticks>
ffffffffc02079c8:	0027951b          	slliw	a0,a5,0x2
ffffffffc02079cc:	9d3d                	addw	a0,a0,a5
ffffffffc02079ce:	0015151b          	slliw	a0,a0,0x1
ffffffffc02079d2:	8082                	ret

ffffffffc02079d4 <sys_lab6_set_priority>:
ffffffffc02079d4:	4108                	lw	a0,0(a0)
ffffffffc02079d6:	1141                	addi	sp,sp,-16
ffffffffc02079d8:	e406                	sd	ra,8(sp)
ffffffffc02079da:	ee5fc0ef          	jal	ra,ffffffffc02048be <lab6_set_priority>
ffffffffc02079de:	60a2                	ld	ra,8(sp)
ffffffffc02079e0:	4501                	li	a0,0
ffffffffc02079e2:	0141                	addi	sp,sp,16
ffffffffc02079e4:	8082                	ret

ffffffffc02079e6 <sys_putc>:
ffffffffc02079e6:	4108                	lw	a0,0(a0)
ffffffffc02079e8:	1141                	addi	sp,sp,-16
ffffffffc02079ea:	e406                	sd	ra,8(sp)
ffffffffc02079ec:	f16f80ef          	jal	ra,ffffffffc0200102 <cputchar>
ffffffffc02079f0:	60a2                	ld	ra,8(sp)
ffffffffc02079f2:	4501                	li	a0,0
ffffffffc02079f4:	0141                	addi	sp,sp,16
ffffffffc02079f6:	8082                	ret

ffffffffc02079f8 <sys_kill>:
ffffffffc02079f8:	4108                	lw	a0,0(a0)
ffffffffc02079fa:	d2dfc06f          	j	ffffffffc0204726 <do_kill>

ffffffffc02079fe <sys_sleep>:
ffffffffc02079fe:	4108                	lw	a0,0(a0)
ffffffffc0207a00:	ef9fc06f          	j	ffffffffc02048f8 <do_sleep>

ffffffffc0207a04 <sys_yield>:
ffffffffc0207a04:	cd5fc06f          	j	ffffffffc02046d8 <do_yield>

ffffffffc0207a08 <sys_exec>:
ffffffffc0207a08:	6d14                	ld	a3,24(a0)
ffffffffc0207a0a:	6910                	ld	a2,16(a0)
ffffffffc0207a0c:	650c                	ld	a1,8(a0)
ffffffffc0207a0e:	6108                	ld	a0,0(a0)
ffffffffc0207a10:	f3efc06f          	j	ffffffffc020414e <do_execve>

ffffffffc0207a14 <sys_wait>:
ffffffffc0207a14:	650c                	ld	a1,8(a0)
ffffffffc0207a16:	4108                	lw	a0,0(a0)
ffffffffc0207a18:	cd1fc06f          	j	ffffffffc02046e8 <do_wait>

ffffffffc0207a1c <sys_fork>:
ffffffffc0207a1c:	00012797          	auipc	a5,0x12
ffffffffc0207a20:	adc7b783          	ld	a5,-1316(a5) # ffffffffc02194f8 <current>
ffffffffc0207a24:	73d0                	ld	a2,160(a5)
ffffffffc0207a26:	4501                	li	a0,0
ffffffffc0207a28:	6a0c                	ld	a1,16(a2)
ffffffffc0207a2a:	ebbfb06f          	j	ffffffffc02038e4 <do_fork>

ffffffffc0207a2e <sys_exit>:
ffffffffc0207a2e:	4108                	lw	a0,0(a0)
ffffffffc0207a30:	ad6fc06f          	j	ffffffffc0203d06 <do_exit>

ffffffffc0207a34 <syscall>:
ffffffffc0207a34:	715d                	addi	sp,sp,-80
ffffffffc0207a36:	fc26                	sd	s1,56(sp)
ffffffffc0207a38:	00012497          	auipc	s1,0x12
ffffffffc0207a3c:	ac048493          	addi	s1,s1,-1344 # ffffffffc02194f8 <current>
ffffffffc0207a40:	6098                	ld	a4,0(s1)
ffffffffc0207a42:	e0a2                	sd	s0,64(sp)
ffffffffc0207a44:	f84a                	sd	s2,48(sp)
ffffffffc0207a46:	7340                	ld	s0,160(a4)
ffffffffc0207a48:	e486                	sd	ra,72(sp)
ffffffffc0207a4a:	0ff00793          	li	a5,255
ffffffffc0207a4e:	05042903          	lw	s2,80(s0)
ffffffffc0207a52:	0327ee63          	bltu	a5,s2,ffffffffc0207a8e <syscall+0x5a>
ffffffffc0207a56:	00391713          	slli	a4,s2,0x3
ffffffffc0207a5a:	00002797          	auipc	a5,0x2
ffffffffc0207a5e:	0c678793          	addi	a5,a5,198 # ffffffffc0209b20 <syscalls>
ffffffffc0207a62:	97ba                	add	a5,a5,a4
ffffffffc0207a64:	639c                	ld	a5,0(a5)
ffffffffc0207a66:	c785                	beqz	a5,ffffffffc0207a8e <syscall+0x5a>
ffffffffc0207a68:	6c28                	ld	a0,88(s0)
ffffffffc0207a6a:	702c                	ld	a1,96(s0)
ffffffffc0207a6c:	7430                	ld	a2,104(s0)
ffffffffc0207a6e:	7834                	ld	a3,112(s0)
ffffffffc0207a70:	7c38                	ld	a4,120(s0)
ffffffffc0207a72:	e42a                	sd	a0,8(sp)
ffffffffc0207a74:	e82e                	sd	a1,16(sp)
ffffffffc0207a76:	ec32                	sd	a2,24(sp)
ffffffffc0207a78:	f036                	sd	a3,32(sp)
ffffffffc0207a7a:	f43a                	sd	a4,40(sp)
ffffffffc0207a7c:	0028                	addi	a0,sp,8
ffffffffc0207a7e:	9782                	jalr	a5
ffffffffc0207a80:	60a6                	ld	ra,72(sp)
ffffffffc0207a82:	e828                	sd	a0,80(s0)
ffffffffc0207a84:	6406                	ld	s0,64(sp)
ffffffffc0207a86:	74e2                	ld	s1,56(sp)
ffffffffc0207a88:	7942                	ld	s2,48(sp)
ffffffffc0207a8a:	6161                	addi	sp,sp,80
ffffffffc0207a8c:	8082                	ret
ffffffffc0207a8e:	8522                	mv	a0,s0
ffffffffc0207a90:	d97f80ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0207a94:	609c                	ld	a5,0(s1)
ffffffffc0207a96:	86ca                	mv	a3,s2
ffffffffc0207a98:	00002617          	auipc	a2,0x2
ffffffffc0207a9c:	04060613          	addi	a2,a2,64 # ffffffffc0209ad8 <default_pmm_manager+0x7b0>
ffffffffc0207aa0:	43d8                	lw	a4,4(a5)
ffffffffc0207aa2:	07300593          	li	a1,115
ffffffffc0207aa6:	0b478793          	addi	a5,a5,180
ffffffffc0207aaa:	00002517          	auipc	a0,0x2
ffffffffc0207aae:	05e50513          	addi	a0,a0,94 # ffffffffc0209b08 <default_pmm_manager+0x7e0>
ffffffffc0207ab2:	f56f80ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0207ab6 <strnlen>:
ffffffffc0207ab6:	872a                	mv	a4,a0
ffffffffc0207ab8:	4501                	li	a0,0
ffffffffc0207aba:	e589                	bnez	a1,ffffffffc0207ac4 <strnlen+0xe>
ffffffffc0207abc:	a811                	j	ffffffffc0207ad0 <strnlen+0x1a>
ffffffffc0207abe:	0505                	addi	a0,a0,1
ffffffffc0207ac0:	00a58763          	beq	a1,a0,ffffffffc0207ace <strnlen+0x18>
ffffffffc0207ac4:	00a707b3          	add	a5,a4,a0
ffffffffc0207ac8:	0007c783          	lbu	a5,0(a5)
ffffffffc0207acc:	fbed                	bnez	a5,ffffffffc0207abe <strnlen+0x8>
ffffffffc0207ace:	8082                	ret
ffffffffc0207ad0:	8082                	ret

ffffffffc0207ad2 <strcmp>:
ffffffffc0207ad2:	00054783          	lbu	a5,0(a0)
ffffffffc0207ad6:	0005c703          	lbu	a4,0(a1)
ffffffffc0207ada:	cb89                	beqz	a5,ffffffffc0207aec <strcmp+0x1a>
ffffffffc0207adc:	0505                	addi	a0,a0,1
ffffffffc0207ade:	0585                	addi	a1,a1,1
ffffffffc0207ae0:	fee789e3          	beq	a5,a4,ffffffffc0207ad2 <strcmp>
ffffffffc0207ae4:	0007851b          	sext.w	a0,a5
ffffffffc0207ae8:	9d19                	subw	a0,a0,a4
ffffffffc0207aea:	8082                	ret
ffffffffc0207aec:	4501                	li	a0,0
ffffffffc0207aee:	bfed                	j	ffffffffc0207ae8 <strcmp+0x16>

ffffffffc0207af0 <strchr>:
ffffffffc0207af0:	00054783          	lbu	a5,0(a0)
ffffffffc0207af4:	c799                	beqz	a5,ffffffffc0207b02 <strchr+0x12>
ffffffffc0207af6:	00f58763          	beq	a1,a5,ffffffffc0207b04 <strchr+0x14>
ffffffffc0207afa:	00154783          	lbu	a5,1(a0)
ffffffffc0207afe:	0505                	addi	a0,a0,1
ffffffffc0207b00:	fbfd                	bnez	a5,ffffffffc0207af6 <strchr+0x6>
ffffffffc0207b02:	4501                	li	a0,0
ffffffffc0207b04:	8082                	ret

ffffffffc0207b06 <memset>:
ffffffffc0207b06:	ca01                	beqz	a2,ffffffffc0207b16 <memset+0x10>
ffffffffc0207b08:	962a                	add	a2,a2,a0
ffffffffc0207b0a:	87aa                	mv	a5,a0
ffffffffc0207b0c:	0785                	addi	a5,a5,1
ffffffffc0207b0e:	feb78fa3          	sb	a1,-1(a5)
ffffffffc0207b12:	fec79de3          	bne	a5,a2,ffffffffc0207b0c <memset+0x6>
ffffffffc0207b16:	8082                	ret

ffffffffc0207b18 <memcpy>:
ffffffffc0207b18:	ca19                	beqz	a2,ffffffffc0207b2e <memcpy+0x16>
ffffffffc0207b1a:	962e                	add	a2,a2,a1
ffffffffc0207b1c:	87aa                	mv	a5,a0
ffffffffc0207b1e:	0005c703          	lbu	a4,0(a1)
ffffffffc0207b22:	0585                	addi	a1,a1,1
ffffffffc0207b24:	0785                	addi	a5,a5,1
ffffffffc0207b26:	fee78fa3          	sb	a4,-1(a5)
ffffffffc0207b2a:	fec59ae3          	bne	a1,a2,ffffffffc0207b1e <memcpy+0x6>
ffffffffc0207b2e:	8082                	ret

ffffffffc0207b30 <printnum>:
ffffffffc0207b30:	02069813          	slli	a6,a3,0x20
ffffffffc0207b34:	7179                	addi	sp,sp,-48
ffffffffc0207b36:	02085813          	srli	a6,a6,0x20
ffffffffc0207b3a:	e052                	sd	s4,0(sp)
ffffffffc0207b3c:	03067a33          	remu	s4,a2,a6
ffffffffc0207b40:	f022                	sd	s0,32(sp)
ffffffffc0207b42:	ec26                	sd	s1,24(sp)
ffffffffc0207b44:	e84a                	sd	s2,16(sp)
ffffffffc0207b46:	f406                	sd	ra,40(sp)
ffffffffc0207b48:	e44e                	sd	s3,8(sp)
ffffffffc0207b4a:	84aa                	mv	s1,a0
ffffffffc0207b4c:	892e                	mv	s2,a1
ffffffffc0207b4e:	fff7041b          	addiw	s0,a4,-1
ffffffffc0207b52:	2a01                	sext.w	s4,s4
ffffffffc0207b54:	03067e63          	bgeu	a2,a6,ffffffffc0207b90 <printnum+0x60>
ffffffffc0207b58:	89be                	mv	s3,a5
ffffffffc0207b5a:	00805763          	blez	s0,ffffffffc0207b68 <printnum+0x38>
ffffffffc0207b5e:	347d                	addiw	s0,s0,-1
ffffffffc0207b60:	85ca                	mv	a1,s2
ffffffffc0207b62:	854e                	mv	a0,s3
ffffffffc0207b64:	9482                	jalr	s1
ffffffffc0207b66:	fc65                	bnez	s0,ffffffffc0207b5e <printnum+0x2e>
ffffffffc0207b68:	1a02                	slli	s4,s4,0x20
ffffffffc0207b6a:	020a5a13          	srli	s4,s4,0x20
ffffffffc0207b6e:	00002797          	auipc	a5,0x2
ffffffffc0207b72:	7b278793          	addi	a5,a5,1970 # ffffffffc020a320 <syscalls+0x800>
ffffffffc0207b76:	7402                	ld	s0,32(sp)
ffffffffc0207b78:	9a3e                	add	s4,s4,a5
ffffffffc0207b7a:	000a4503          	lbu	a0,0(s4)
ffffffffc0207b7e:	70a2                	ld	ra,40(sp)
ffffffffc0207b80:	69a2                	ld	s3,8(sp)
ffffffffc0207b82:	6a02                	ld	s4,0(sp)
ffffffffc0207b84:	85ca                	mv	a1,s2
ffffffffc0207b86:	8326                	mv	t1,s1
ffffffffc0207b88:	6942                	ld	s2,16(sp)
ffffffffc0207b8a:	64e2                	ld	s1,24(sp)
ffffffffc0207b8c:	6145                	addi	sp,sp,48
ffffffffc0207b8e:	8302                	jr	t1
ffffffffc0207b90:	03065633          	divu	a2,a2,a6
ffffffffc0207b94:	8722                	mv	a4,s0
ffffffffc0207b96:	f9bff0ef          	jal	ra,ffffffffc0207b30 <printnum>
ffffffffc0207b9a:	b7f9                	j	ffffffffc0207b68 <printnum+0x38>

ffffffffc0207b9c <vprintfmt>:
ffffffffc0207b9c:	7119                	addi	sp,sp,-128
ffffffffc0207b9e:	f4a6                	sd	s1,104(sp)
ffffffffc0207ba0:	f0ca                	sd	s2,96(sp)
ffffffffc0207ba2:	ecce                	sd	s3,88(sp)
ffffffffc0207ba4:	e8d2                	sd	s4,80(sp)
ffffffffc0207ba6:	e4d6                	sd	s5,72(sp)
ffffffffc0207ba8:	e0da                	sd	s6,64(sp)
ffffffffc0207baa:	fc5e                	sd	s7,56(sp)
ffffffffc0207bac:	f06a                	sd	s10,32(sp)
ffffffffc0207bae:	fc86                	sd	ra,120(sp)
ffffffffc0207bb0:	f8a2                	sd	s0,112(sp)
ffffffffc0207bb2:	f862                	sd	s8,48(sp)
ffffffffc0207bb4:	f466                	sd	s9,40(sp)
ffffffffc0207bb6:	ec6e                	sd	s11,24(sp)
ffffffffc0207bb8:	892a                	mv	s2,a0
ffffffffc0207bba:	84ae                	mv	s1,a1
ffffffffc0207bbc:	8d32                	mv	s10,a2
ffffffffc0207bbe:	8a36                	mv	s4,a3
ffffffffc0207bc0:	02500993          	li	s3,37
ffffffffc0207bc4:	5b7d                	li	s6,-1
ffffffffc0207bc6:	00002a97          	auipc	s5,0x2
ffffffffc0207bca:	786a8a93          	addi	s5,s5,1926 # ffffffffc020a34c <syscalls+0x82c>
ffffffffc0207bce:	00003b97          	auipc	s7,0x3
ffffffffc0207bd2:	99ab8b93          	addi	s7,s7,-1638 # ffffffffc020a568 <error_string>
ffffffffc0207bd6:	000d4503          	lbu	a0,0(s10)
ffffffffc0207bda:	001d0413          	addi	s0,s10,1
ffffffffc0207bde:	01350a63          	beq	a0,s3,ffffffffc0207bf2 <vprintfmt+0x56>
ffffffffc0207be2:	c121                	beqz	a0,ffffffffc0207c22 <vprintfmt+0x86>
ffffffffc0207be4:	85a6                	mv	a1,s1
ffffffffc0207be6:	0405                	addi	s0,s0,1
ffffffffc0207be8:	9902                	jalr	s2
ffffffffc0207bea:	fff44503          	lbu	a0,-1(s0)
ffffffffc0207bee:	ff351ae3          	bne	a0,s3,ffffffffc0207be2 <vprintfmt+0x46>
ffffffffc0207bf2:	00044603          	lbu	a2,0(s0)
ffffffffc0207bf6:	02000793          	li	a5,32
ffffffffc0207bfa:	4c81                	li	s9,0
ffffffffc0207bfc:	4881                	li	a7,0
ffffffffc0207bfe:	5c7d                	li	s8,-1
ffffffffc0207c00:	5dfd                	li	s11,-1
ffffffffc0207c02:	05500513          	li	a0,85
ffffffffc0207c06:	4825                	li	a6,9
ffffffffc0207c08:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0207c0c:	0ff5f593          	andi	a1,a1,255
ffffffffc0207c10:	00140d13          	addi	s10,s0,1
ffffffffc0207c14:	04b56263          	bltu	a0,a1,ffffffffc0207c58 <vprintfmt+0xbc>
ffffffffc0207c18:	058a                	slli	a1,a1,0x2
ffffffffc0207c1a:	95d6                	add	a1,a1,s5
ffffffffc0207c1c:	4194                	lw	a3,0(a1)
ffffffffc0207c1e:	96d6                	add	a3,a3,s5
ffffffffc0207c20:	8682                	jr	a3
ffffffffc0207c22:	70e6                	ld	ra,120(sp)
ffffffffc0207c24:	7446                	ld	s0,112(sp)
ffffffffc0207c26:	74a6                	ld	s1,104(sp)
ffffffffc0207c28:	7906                	ld	s2,96(sp)
ffffffffc0207c2a:	69e6                	ld	s3,88(sp)
ffffffffc0207c2c:	6a46                	ld	s4,80(sp)
ffffffffc0207c2e:	6aa6                	ld	s5,72(sp)
ffffffffc0207c30:	6b06                	ld	s6,64(sp)
ffffffffc0207c32:	7be2                	ld	s7,56(sp)
ffffffffc0207c34:	7c42                	ld	s8,48(sp)
ffffffffc0207c36:	7ca2                	ld	s9,40(sp)
ffffffffc0207c38:	7d02                	ld	s10,32(sp)
ffffffffc0207c3a:	6de2                	ld	s11,24(sp)
ffffffffc0207c3c:	6109                	addi	sp,sp,128
ffffffffc0207c3e:	8082                	ret
ffffffffc0207c40:	87b2                	mv	a5,a2
ffffffffc0207c42:	00144603          	lbu	a2,1(s0)
ffffffffc0207c46:	846a                	mv	s0,s10
ffffffffc0207c48:	00140d13          	addi	s10,s0,1
ffffffffc0207c4c:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0207c50:	0ff5f593          	andi	a1,a1,255
ffffffffc0207c54:	fcb572e3          	bgeu	a0,a1,ffffffffc0207c18 <vprintfmt+0x7c>
ffffffffc0207c58:	85a6                	mv	a1,s1
ffffffffc0207c5a:	02500513          	li	a0,37
ffffffffc0207c5e:	9902                	jalr	s2
ffffffffc0207c60:	fff44783          	lbu	a5,-1(s0)
ffffffffc0207c64:	8d22                	mv	s10,s0
ffffffffc0207c66:	f73788e3          	beq	a5,s3,ffffffffc0207bd6 <vprintfmt+0x3a>
ffffffffc0207c6a:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0207c6e:	1d7d                	addi	s10,s10,-1
ffffffffc0207c70:	ff379de3          	bne	a5,s3,ffffffffc0207c6a <vprintfmt+0xce>
ffffffffc0207c74:	b78d                	j	ffffffffc0207bd6 <vprintfmt+0x3a>
ffffffffc0207c76:	fd060c1b          	addiw	s8,a2,-48
ffffffffc0207c7a:	00144603          	lbu	a2,1(s0)
ffffffffc0207c7e:	846a                	mv	s0,s10
ffffffffc0207c80:	fd06069b          	addiw	a3,a2,-48
ffffffffc0207c84:	0006059b          	sext.w	a1,a2
ffffffffc0207c88:	02d86463          	bltu	a6,a3,ffffffffc0207cb0 <vprintfmt+0x114>
ffffffffc0207c8c:	00144603          	lbu	a2,1(s0)
ffffffffc0207c90:	002c169b          	slliw	a3,s8,0x2
ffffffffc0207c94:	0186873b          	addw	a4,a3,s8
ffffffffc0207c98:	0017171b          	slliw	a4,a4,0x1
ffffffffc0207c9c:	9f2d                	addw	a4,a4,a1
ffffffffc0207c9e:	fd06069b          	addiw	a3,a2,-48
ffffffffc0207ca2:	0405                	addi	s0,s0,1
ffffffffc0207ca4:	fd070c1b          	addiw	s8,a4,-48
ffffffffc0207ca8:	0006059b          	sext.w	a1,a2
ffffffffc0207cac:	fed870e3          	bgeu	a6,a3,ffffffffc0207c8c <vprintfmt+0xf0>
ffffffffc0207cb0:	f40ddce3          	bgez	s11,ffffffffc0207c08 <vprintfmt+0x6c>
ffffffffc0207cb4:	8de2                	mv	s11,s8
ffffffffc0207cb6:	5c7d                	li	s8,-1
ffffffffc0207cb8:	bf81                	j	ffffffffc0207c08 <vprintfmt+0x6c>
ffffffffc0207cba:	fffdc693          	not	a3,s11
ffffffffc0207cbe:	96fd                	srai	a3,a3,0x3f
ffffffffc0207cc0:	00ddfdb3          	and	s11,s11,a3
ffffffffc0207cc4:	00144603          	lbu	a2,1(s0)
ffffffffc0207cc8:	2d81                	sext.w	s11,s11
ffffffffc0207cca:	846a                	mv	s0,s10
ffffffffc0207ccc:	bf35                	j	ffffffffc0207c08 <vprintfmt+0x6c>
ffffffffc0207cce:	000a2c03          	lw	s8,0(s4)
ffffffffc0207cd2:	00144603          	lbu	a2,1(s0)
ffffffffc0207cd6:	0a21                	addi	s4,s4,8
ffffffffc0207cd8:	846a                	mv	s0,s10
ffffffffc0207cda:	bfd9                	j	ffffffffc0207cb0 <vprintfmt+0x114>
ffffffffc0207cdc:	4705                	li	a4,1
ffffffffc0207cde:	008a0593          	addi	a1,s4,8
ffffffffc0207ce2:	01174463          	blt	a4,a7,ffffffffc0207cea <vprintfmt+0x14e>
ffffffffc0207ce6:	1a088e63          	beqz	a7,ffffffffc0207ea2 <vprintfmt+0x306>
ffffffffc0207cea:	000a3603          	ld	a2,0(s4)
ffffffffc0207cee:	46c1                	li	a3,16
ffffffffc0207cf0:	8a2e                	mv	s4,a1
ffffffffc0207cf2:	2781                	sext.w	a5,a5
ffffffffc0207cf4:	876e                	mv	a4,s11
ffffffffc0207cf6:	85a6                	mv	a1,s1
ffffffffc0207cf8:	854a                	mv	a0,s2
ffffffffc0207cfa:	e37ff0ef          	jal	ra,ffffffffc0207b30 <printnum>
ffffffffc0207cfe:	bde1                	j	ffffffffc0207bd6 <vprintfmt+0x3a>
ffffffffc0207d00:	000a2503          	lw	a0,0(s4)
ffffffffc0207d04:	85a6                	mv	a1,s1
ffffffffc0207d06:	0a21                	addi	s4,s4,8
ffffffffc0207d08:	9902                	jalr	s2
ffffffffc0207d0a:	b5f1                	j	ffffffffc0207bd6 <vprintfmt+0x3a>
ffffffffc0207d0c:	4705                	li	a4,1
ffffffffc0207d0e:	008a0593          	addi	a1,s4,8
ffffffffc0207d12:	01174463          	blt	a4,a7,ffffffffc0207d1a <vprintfmt+0x17e>
ffffffffc0207d16:	18088163          	beqz	a7,ffffffffc0207e98 <vprintfmt+0x2fc>
ffffffffc0207d1a:	000a3603          	ld	a2,0(s4)
ffffffffc0207d1e:	46a9                	li	a3,10
ffffffffc0207d20:	8a2e                	mv	s4,a1
ffffffffc0207d22:	bfc1                	j	ffffffffc0207cf2 <vprintfmt+0x156>
ffffffffc0207d24:	00144603          	lbu	a2,1(s0)
ffffffffc0207d28:	4c85                	li	s9,1
ffffffffc0207d2a:	846a                	mv	s0,s10
ffffffffc0207d2c:	bdf1                	j	ffffffffc0207c08 <vprintfmt+0x6c>
ffffffffc0207d2e:	85a6                	mv	a1,s1
ffffffffc0207d30:	02500513          	li	a0,37
ffffffffc0207d34:	9902                	jalr	s2
ffffffffc0207d36:	b545                	j	ffffffffc0207bd6 <vprintfmt+0x3a>
ffffffffc0207d38:	00144603          	lbu	a2,1(s0)
ffffffffc0207d3c:	2885                	addiw	a7,a7,1
ffffffffc0207d3e:	846a                	mv	s0,s10
ffffffffc0207d40:	b5e1                	j	ffffffffc0207c08 <vprintfmt+0x6c>
ffffffffc0207d42:	4705                	li	a4,1
ffffffffc0207d44:	008a0593          	addi	a1,s4,8
ffffffffc0207d48:	01174463          	blt	a4,a7,ffffffffc0207d50 <vprintfmt+0x1b4>
ffffffffc0207d4c:	14088163          	beqz	a7,ffffffffc0207e8e <vprintfmt+0x2f2>
ffffffffc0207d50:	000a3603          	ld	a2,0(s4)
ffffffffc0207d54:	46a1                	li	a3,8
ffffffffc0207d56:	8a2e                	mv	s4,a1
ffffffffc0207d58:	bf69                	j	ffffffffc0207cf2 <vprintfmt+0x156>
ffffffffc0207d5a:	03000513          	li	a0,48
ffffffffc0207d5e:	85a6                	mv	a1,s1
ffffffffc0207d60:	e03e                	sd	a5,0(sp)
ffffffffc0207d62:	9902                	jalr	s2
ffffffffc0207d64:	85a6                	mv	a1,s1
ffffffffc0207d66:	07800513          	li	a0,120
ffffffffc0207d6a:	9902                	jalr	s2
ffffffffc0207d6c:	0a21                	addi	s4,s4,8
ffffffffc0207d6e:	6782                	ld	a5,0(sp)
ffffffffc0207d70:	46c1                	li	a3,16
ffffffffc0207d72:	ff8a3603          	ld	a2,-8(s4)
ffffffffc0207d76:	bfb5                	j	ffffffffc0207cf2 <vprintfmt+0x156>
ffffffffc0207d78:	000a3403          	ld	s0,0(s4)
ffffffffc0207d7c:	008a0713          	addi	a4,s4,8
ffffffffc0207d80:	e03a                	sd	a4,0(sp)
ffffffffc0207d82:	14040263          	beqz	s0,ffffffffc0207ec6 <vprintfmt+0x32a>
ffffffffc0207d86:	0fb05763          	blez	s11,ffffffffc0207e74 <vprintfmt+0x2d8>
ffffffffc0207d8a:	02d00693          	li	a3,45
ffffffffc0207d8e:	0cd79163          	bne	a5,a3,ffffffffc0207e50 <vprintfmt+0x2b4>
ffffffffc0207d92:	00044783          	lbu	a5,0(s0)
ffffffffc0207d96:	0007851b          	sext.w	a0,a5
ffffffffc0207d9a:	cf85                	beqz	a5,ffffffffc0207dd2 <vprintfmt+0x236>
ffffffffc0207d9c:	00140a13          	addi	s4,s0,1
ffffffffc0207da0:	05e00413          	li	s0,94
ffffffffc0207da4:	000c4563          	bltz	s8,ffffffffc0207dae <vprintfmt+0x212>
ffffffffc0207da8:	3c7d                	addiw	s8,s8,-1
ffffffffc0207daa:	036c0263          	beq	s8,s6,ffffffffc0207dce <vprintfmt+0x232>
ffffffffc0207dae:	85a6                	mv	a1,s1
ffffffffc0207db0:	0e0c8e63          	beqz	s9,ffffffffc0207eac <vprintfmt+0x310>
ffffffffc0207db4:	3781                	addiw	a5,a5,-32
ffffffffc0207db6:	0ef47b63          	bgeu	s0,a5,ffffffffc0207eac <vprintfmt+0x310>
ffffffffc0207dba:	03f00513          	li	a0,63
ffffffffc0207dbe:	9902                	jalr	s2
ffffffffc0207dc0:	000a4783          	lbu	a5,0(s4)
ffffffffc0207dc4:	3dfd                	addiw	s11,s11,-1
ffffffffc0207dc6:	0a05                	addi	s4,s4,1
ffffffffc0207dc8:	0007851b          	sext.w	a0,a5
ffffffffc0207dcc:	ffe1                	bnez	a5,ffffffffc0207da4 <vprintfmt+0x208>
ffffffffc0207dce:	01b05963          	blez	s11,ffffffffc0207de0 <vprintfmt+0x244>
ffffffffc0207dd2:	3dfd                	addiw	s11,s11,-1
ffffffffc0207dd4:	85a6                	mv	a1,s1
ffffffffc0207dd6:	02000513          	li	a0,32
ffffffffc0207dda:	9902                	jalr	s2
ffffffffc0207ddc:	fe0d9be3          	bnez	s11,ffffffffc0207dd2 <vprintfmt+0x236>
ffffffffc0207de0:	6a02                	ld	s4,0(sp)
ffffffffc0207de2:	bbd5                	j	ffffffffc0207bd6 <vprintfmt+0x3a>
ffffffffc0207de4:	4705                	li	a4,1
ffffffffc0207de6:	008a0c93          	addi	s9,s4,8
ffffffffc0207dea:	01174463          	blt	a4,a7,ffffffffc0207df2 <vprintfmt+0x256>
ffffffffc0207dee:	08088d63          	beqz	a7,ffffffffc0207e88 <vprintfmt+0x2ec>
ffffffffc0207df2:	000a3403          	ld	s0,0(s4)
ffffffffc0207df6:	0a044d63          	bltz	s0,ffffffffc0207eb0 <vprintfmt+0x314>
ffffffffc0207dfa:	8622                	mv	a2,s0
ffffffffc0207dfc:	8a66                	mv	s4,s9
ffffffffc0207dfe:	46a9                	li	a3,10
ffffffffc0207e00:	bdcd                	j	ffffffffc0207cf2 <vprintfmt+0x156>
ffffffffc0207e02:	000a2783          	lw	a5,0(s4)
ffffffffc0207e06:	4761                	li	a4,24
ffffffffc0207e08:	0a21                	addi	s4,s4,8
ffffffffc0207e0a:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0207e0e:	8fb5                	xor	a5,a5,a3
ffffffffc0207e10:	40d786bb          	subw	a3,a5,a3
ffffffffc0207e14:	02d74163          	blt	a4,a3,ffffffffc0207e36 <vprintfmt+0x29a>
ffffffffc0207e18:	00369793          	slli	a5,a3,0x3
ffffffffc0207e1c:	97de                	add	a5,a5,s7
ffffffffc0207e1e:	639c                	ld	a5,0(a5)
ffffffffc0207e20:	cb99                	beqz	a5,ffffffffc0207e36 <vprintfmt+0x29a>
ffffffffc0207e22:	86be                	mv	a3,a5
ffffffffc0207e24:	00000617          	auipc	a2,0x0
ffffffffc0207e28:	13460613          	addi	a2,a2,308 # ffffffffc0207f58 <etext+0x24>
ffffffffc0207e2c:	85a6                	mv	a1,s1
ffffffffc0207e2e:	854a                	mv	a0,s2
ffffffffc0207e30:	0ce000ef          	jal	ra,ffffffffc0207efe <printfmt>
ffffffffc0207e34:	b34d                	j	ffffffffc0207bd6 <vprintfmt+0x3a>
ffffffffc0207e36:	00002617          	auipc	a2,0x2
ffffffffc0207e3a:	50a60613          	addi	a2,a2,1290 # ffffffffc020a340 <syscalls+0x820>
ffffffffc0207e3e:	85a6                	mv	a1,s1
ffffffffc0207e40:	854a                	mv	a0,s2
ffffffffc0207e42:	0bc000ef          	jal	ra,ffffffffc0207efe <printfmt>
ffffffffc0207e46:	bb41                	j	ffffffffc0207bd6 <vprintfmt+0x3a>
ffffffffc0207e48:	00002417          	auipc	s0,0x2
ffffffffc0207e4c:	4f040413          	addi	s0,s0,1264 # ffffffffc020a338 <syscalls+0x818>
ffffffffc0207e50:	85e2                	mv	a1,s8
ffffffffc0207e52:	8522                	mv	a0,s0
ffffffffc0207e54:	e43e                	sd	a5,8(sp)
ffffffffc0207e56:	c61ff0ef          	jal	ra,ffffffffc0207ab6 <strnlen>
ffffffffc0207e5a:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0207e5e:	01b05b63          	blez	s11,ffffffffc0207e74 <vprintfmt+0x2d8>
ffffffffc0207e62:	67a2                	ld	a5,8(sp)
ffffffffc0207e64:	00078a1b          	sext.w	s4,a5
ffffffffc0207e68:	3dfd                	addiw	s11,s11,-1
ffffffffc0207e6a:	85a6                	mv	a1,s1
ffffffffc0207e6c:	8552                	mv	a0,s4
ffffffffc0207e6e:	9902                	jalr	s2
ffffffffc0207e70:	fe0d9ce3          	bnez	s11,ffffffffc0207e68 <vprintfmt+0x2cc>
ffffffffc0207e74:	00044783          	lbu	a5,0(s0)
ffffffffc0207e78:	00140a13          	addi	s4,s0,1
ffffffffc0207e7c:	0007851b          	sext.w	a0,a5
ffffffffc0207e80:	d3a5                	beqz	a5,ffffffffc0207de0 <vprintfmt+0x244>
ffffffffc0207e82:	05e00413          	li	s0,94
ffffffffc0207e86:	bf39                	j	ffffffffc0207da4 <vprintfmt+0x208>
ffffffffc0207e88:	000a2403          	lw	s0,0(s4)
ffffffffc0207e8c:	b7ad                	j	ffffffffc0207df6 <vprintfmt+0x25a>
ffffffffc0207e8e:	000a6603          	lwu	a2,0(s4)
ffffffffc0207e92:	46a1                	li	a3,8
ffffffffc0207e94:	8a2e                	mv	s4,a1
ffffffffc0207e96:	bdb1                	j	ffffffffc0207cf2 <vprintfmt+0x156>
ffffffffc0207e98:	000a6603          	lwu	a2,0(s4)
ffffffffc0207e9c:	46a9                	li	a3,10
ffffffffc0207e9e:	8a2e                	mv	s4,a1
ffffffffc0207ea0:	bd89                	j	ffffffffc0207cf2 <vprintfmt+0x156>
ffffffffc0207ea2:	000a6603          	lwu	a2,0(s4)
ffffffffc0207ea6:	46c1                	li	a3,16
ffffffffc0207ea8:	8a2e                	mv	s4,a1
ffffffffc0207eaa:	b5a1                	j	ffffffffc0207cf2 <vprintfmt+0x156>
ffffffffc0207eac:	9902                	jalr	s2
ffffffffc0207eae:	bf09                	j	ffffffffc0207dc0 <vprintfmt+0x224>
ffffffffc0207eb0:	85a6                	mv	a1,s1
ffffffffc0207eb2:	02d00513          	li	a0,45
ffffffffc0207eb6:	e03e                	sd	a5,0(sp)
ffffffffc0207eb8:	9902                	jalr	s2
ffffffffc0207eba:	6782                	ld	a5,0(sp)
ffffffffc0207ebc:	8a66                	mv	s4,s9
ffffffffc0207ebe:	40800633          	neg	a2,s0
ffffffffc0207ec2:	46a9                	li	a3,10
ffffffffc0207ec4:	b53d                	j	ffffffffc0207cf2 <vprintfmt+0x156>
ffffffffc0207ec6:	03b05163          	blez	s11,ffffffffc0207ee8 <vprintfmt+0x34c>
ffffffffc0207eca:	02d00693          	li	a3,45
ffffffffc0207ece:	f6d79de3          	bne	a5,a3,ffffffffc0207e48 <vprintfmt+0x2ac>
ffffffffc0207ed2:	00002417          	auipc	s0,0x2
ffffffffc0207ed6:	46640413          	addi	s0,s0,1126 # ffffffffc020a338 <syscalls+0x818>
ffffffffc0207eda:	02800793          	li	a5,40
ffffffffc0207ede:	02800513          	li	a0,40
ffffffffc0207ee2:	00140a13          	addi	s4,s0,1
ffffffffc0207ee6:	bd6d                	j	ffffffffc0207da0 <vprintfmt+0x204>
ffffffffc0207ee8:	00002a17          	auipc	s4,0x2
ffffffffc0207eec:	451a0a13          	addi	s4,s4,1105 # ffffffffc020a339 <syscalls+0x819>
ffffffffc0207ef0:	02800513          	li	a0,40
ffffffffc0207ef4:	02800793          	li	a5,40
ffffffffc0207ef8:	05e00413          	li	s0,94
ffffffffc0207efc:	b565                	j	ffffffffc0207da4 <vprintfmt+0x208>

ffffffffc0207efe <printfmt>:
ffffffffc0207efe:	715d                	addi	sp,sp,-80
ffffffffc0207f00:	02810313          	addi	t1,sp,40
ffffffffc0207f04:	f436                	sd	a3,40(sp)
ffffffffc0207f06:	869a                	mv	a3,t1
ffffffffc0207f08:	ec06                	sd	ra,24(sp)
ffffffffc0207f0a:	f83a                	sd	a4,48(sp)
ffffffffc0207f0c:	fc3e                	sd	a5,56(sp)
ffffffffc0207f0e:	e0c2                	sd	a6,64(sp)
ffffffffc0207f10:	e4c6                	sd	a7,72(sp)
ffffffffc0207f12:	e41a                	sd	t1,8(sp)
ffffffffc0207f14:	c89ff0ef          	jal	ra,ffffffffc0207b9c <vprintfmt>
ffffffffc0207f18:	60e2                	ld	ra,24(sp)
ffffffffc0207f1a:	6161                	addi	sp,sp,80
ffffffffc0207f1c:	8082                	ret

ffffffffc0207f1e <hash32>:
ffffffffc0207f1e:	9e3707b7          	lui	a5,0x9e370
ffffffffc0207f22:	2785                	addiw	a5,a5,1
ffffffffc0207f24:	02a7853b          	mulw	a0,a5,a0
ffffffffc0207f28:	02000793          	li	a5,32
ffffffffc0207f2c:	9f8d                	subw	a5,a5,a1
ffffffffc0207f2e:	00f5553b          	srlw	a0,a0,a5
ffffffffc0207f32:	8082                	ret
