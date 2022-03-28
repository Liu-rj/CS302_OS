
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <kern_entry>:
    80200000:	00005117          	auipc	sp,0x5
    80200004:	00010113          	mv	sp,sp
    80200008:	a009                	j	8020000a <kern_init>

000000008020000a <kern_init>:
    8020000a:	00005517          	auipc	a0,0x5
    8020000e:	ffe50513          	addi	a0,a0,-2 # 80205008 <is_panic>
    80200012:	00005617          	auipc	a2,0x5
    80200016:	04e60613          	addi	a2,a2,78 # 80205060 <end>
    8020001a:	1141                	addi	sp,sp,-16
    8020001c:	8e09                	sub	a2,a2,a0
    8020001e:	4581                	li	a1,0
    80200020:	e406                	sd	ra,8(sp)
    80200022:	112010ef          	jal	ra,80201134 <memset>
    80200026:	138000ef          	jal	ra,8020015e <cons_init>
    8020002a:	00001517          	auipc	a0,0x1
    8020002e:	53e50513          	addi	a0,a0,1342 # 80201568 <etext>
    80200032:	086000ef          	jal	ra,802000b8 <cputs>
    80200036:	13e000ef          	jal	ra,80200174 <idt_init>
    8020003a:	594000ef          	jal	ra,802005ce <pmm_init>
    8020003e:	136000ef          	jal	ra,80200174 <idt_init>
    80200042:	126000ef          	jal	ra,80200168 <intr_enable>
    80200046:	a001                	j	80200046 <kern_init+0x3c>

0000000080200048 <cputch>:
    80200048:	1141                	addi	sp,sp,-16
    8020004a:	e022                	sd	s0,0(sp)
    8020004c:	e406                	sd	ra,8(sp)
    8020004e:	842e                	mv	s0,a1
    80200050:	110000ef          	jal	ra,80200160 <cons_putc>
    80200054:	401c                	lw	a5,0(s0)
    80200056:	60a2                	ld	ra,8(sp)
    80200058:	2785                	addiw	a5,a5,1
    8020005a:	c01c                	sw	a5,0(s0)
    8020005c:	6402                	ld	s0,0(sp)
    8020005e:	0141                	addi	sp,sp,16
    80200060:	8082                	ret

0000000080200062 <vcprintf>:
    80200062:	1101                	addi	sp,sp,-32
    80200064:	862a                	mv	a2,a0
    80200066:	86ae                	mv	a3,a1
    80200068:	00000517          	auipc	a0,0x0
    8020006c:	fe050513          	addi	a0,a0,-32 # 80200048 <cputch>
    80200070:	006c                	addi	a1,sp,12
    80200072:	ec06                	sd	ra,24(sp)
    80200074:	c602                	sw	zero,12(sp)
    80200076:	13c010ef          	jal	ra,802011b2 <vprintfmt>
    8020007a:	60e2                	ld	ra,24(sp)
    8020007c:	4532                	lw	a0,12(sp)
    8020007e:	6105                	addi	sp,sp,32
    80200080:	8082                	ret

0000000080200082 <cprintf>:
    80200082:	711d                	addi	sp,sp,-96
    80200084:	02810313          	addi	t1,sp,40 # 80205028 <satp_physical>
    80200088:	8e2a                	mv	t3,a0
    8020008a:	f42e                	sd	a1,40(sp)
    8020008c:	f832                	sd	a2,48(sp)
    8020008e:	fc36                	sd	a3,56(sp)
    80200090:	00000517          	auipc	a0,0x0
    80200094:	fb850513          	addi	a0,a0,-72 # 80200048 <cputch>
    80200098:	004c                	addi	a1,sp,4
    8020009a:	869a                	mv	a3,t1
    8020009c:	8672                	mv	a2,t3
    8020009e:	ec06                	sd	ra,24(sp)
    802000a0:	e0ba                	sd	a4,64(sp)
    802000a2:	e4be                	sd	a5,72(sp)
    802000a4:	e8c2                	sd	a6,80(sp)
    802000a6:	ecc6                	sd	a7,88(sp)
    802000a8:	e41a                	sd	t1,8(sp)
    802000aa:	c202                	sw	zero,4(sp)
    802000ac:	106010ef          	jal	ra,802011b2 <vprintfmt>
    802000b0:	60e2                	ld	ra,24(sp)
    802000b2:	4512                	lw	a0,4(sp)
    802000b4:	6125                	addi	sp,sp,96
    802000b6:	8082                	ret

00000000802000b8 <cputs>:
    802000b8:	1101                	addi	sp,sp,-32
    802000ba:	e822                	sd	s0,16(sp)
    802000bc:	ec06                	sd	ra,24(sp)
    802000be:	e426                	sd	s1,8(sp)
    802000c0:	842a                	mv	s0,a0
    802000c2:	00054503          	lbu	a0,0(a0)
    802000c6:	c51d                	beqz	a0,802000f4 <cputs+0x3c>
    802000c8:	0405                	addi	s0,s0,1
    802000ca:	4485                	li	s1,1
    802000cc:	9c81                	subw	s1,s1,s0
    802000ce:	092000ef          	jal	ra,80200160 <cons_putc>
    802000d2:	00044503          	lbu	a0,0(s0)
    802000d6:	008487bb          	addw	a5,s1,s0
    802000da:	0405                	addi	s0,s0,1
    802000dc:	f96d                	bnez	a0,802000ce <cputs+0x16>
    802000de:	0017841b          	addiw	s0,a5,1
    802000e2:	4529                	li	a0,10
    802000e4:	07c000ef          	jal	ra,80200160 <cons_putc>
    802000e8:	60e2                	ld	ra,24(sp)
    802000ea:	8522                	mv	a0,s0
    802000ec:	6442                	ld	s0,16(sp)
    802000ee:	64a2                	ld	s1,8(sp)
    802000f0:	6105                	addi	sp,sp,32
    802000f2:	8082                	ret
    802000f4:	4405                	li	s0,1
    802000f6:	b7f5                	j	802000e2 <cputs+0x2a>

00000000802000f8 <__panic>:
    802000f8:	00005317          	auipc	t1,0x5
    802000fc:	f1030313          	addi	t1,t1,-240 # 80205008 <is_panic>
    80200100:	00032e03          	lw	t3,0(t1)
    80200104:	715d                	addi	sp,sp,-80
    80200106:	ec06                	sd	ra,24(sp)
    80200108:	e822                	sd	s0,16(sp)
    8020010a:	f436                	sd	a3,40(sp)
    8020010c:	f83a                	sd	a4,48(sp)
    8020010e:	fc3e                	sd	a5,56(sp)
    80200110:	e0c2                	sd	a6,64(sp)
    80200112:	e4c6                	sd	a7,72(sp)
    80200114:	020e1a63          	bnez	t3,80200148 <__panic+0x50>
    80200118:	4785                	li	a5,1
    8020011a:	00f32023          	sw	a5,0(t1)
    8020011e:	8432                	mv	s0,a2
    80200120:	103c                	addi	a5,sp,40
    80200122:	862e                	mv	a2,a1
    80200124:	85aa                	mv	a1,a0
    80200126:	00001517          	auipc	a0,0x1
    8020012a:	45a50513          	addi	a0,a0,1114 # 80201580 <etext+0x18>
    8020012e:	e43e                	sd	a5,8(sp)
    80200130:	f53ff0ef          	jal	ra,80200082 <cprintf>
    80200134:	65a2                	ld	a1,8(sp)
    80200136:	8522                	mv	a0,s0
    80200138:	f2bff0ef          	jal	ra,80200062 <vcprintf>
    8020013c:	00002517          	auipc	a0,0x2
    80200140:	87c50513          	addi	a0,a0,-1924 # 802019b8 <etext+0x450>
    80200144:	f3fff0ef          	jal	ra,80200082 <cprintf>
    80200148:	026000ef          	jal	ra,8020016e <intr_disable>
    8020014c:	a001                	j	8020014c <__panic+0x54>

000000008020014e <clock_set_next_event>:
    8020014e:	c0102573          	rdtime	a0
    80200152:	67e1                	lui	a5,0x18
    80200154:	6a078793          	addi	a5,a5,1696 # 186a0 <kern_entry-0x801e7960>
    80200158:	953e                	add	a0,a0,a5
    8020015a:	3f40106f          	j	8020154e <sbi_set_timer>

000000008020015e <cons_init>:
    8020015e:	8082                	ret

0000000080200160 <cons_putc>:
    80200160:	0ff57513          	andi	a0,a0,255
    80200164:	3d00106f          	j	80201534 <sbi_console_putchar>

0000000080200168 <intr_enable>:
    80200168:	100167f3          	csrrsi	a5,sstatus,2
    8020016c:	8082                	ret

000000008020016e <intr_disable>:
    8020016e:	100177f3          	csrrci	a5,sstatus,2
    80200172:	8082                	ret

0000000080200174 <idt_init>:
    80200174:	14005073          	csrwi	sscratch,0
    80200178:	00000797          	auipc	a5,0x0
    8020017c:	2e478793          	addi	a5,a5,740 # 8020045c <__alltraps>
    80200180:	10579073          	csrw	stvec,a5
    80200184:	8082                	ret

0000000080200186 <print_regs>:
    80200186:	610c                	ld	a1,0(a0)
    80200188:	1141                	addi	sp,sp,-16
    8020018a:	e022                	sd	s0,0(sp)
    8020018c:	842a                	mv	s0,a0
    8020018e:	00001517          	auipc	a0,0x1
    80200192:	41250513          	addi	a0,a0,1042 # 802015a0 <etext+0x38>
    80200196:	e406                	sd	ra,8(sp)
    80200198:	eebff0ef          	jal	ra,80200082 <cprintf>
    8020019c:	640c                	ld	a1,8(s0)
    8020019e:	00001517          	auipc	a0,0x1
    802001a2:	41a50513          	addi	a0,a0,1050 # 802015b8 <etext+0x50>
    802001a6:	eddff0ef          	jal	ra,80200082 <cprintf>
    802001aa:	680c                	ld	a1,16(s0)
    802001ac:	00001517          	auipc	a0,0x1
    802001b0:	42450513          	addi	a0,a0,1060 # 802015d0 <etext+0x68>
    802001b4:	ecfff0ef          	jal	ra,80200082 <cprintf>
    802001b8:	6c0c                	ld	a1,24(s0)
    802001ba:	00001517          	auipc	a0,0x1
    802001be:	42e50513          	addi	a0,a0,1070 # 802015e8 <etext+0x80>
    802001c2:	ec1ff0ef          	jal	ra,80200082 <cprintf>
    802001c6:	700c                	ld	a1,32(s0)
    802001c8:	00001517          	auipc	a0,0x1
    802001cc:	43850513          	addi	a0,a0,1080 # 80201600 <etext+0x98>
    802001d0:	eb3ff0ef          	jal	ra,80200082 <cprintf>
    802001d4:	740c                	ld	a1,40(s0)
    802001d6:	00001517          	auipc	a0,0x1
    802001da:	44250513          	addi	a0,a0,1090 # 80201618 <etext+0xb0>
    802001de:	ea5ff0ef          	jal	ra,80200082 <cprintf>
    802001e2:	780c                	ld	a1,48(s0)
    802001e4:	00001517          	auipc	a0,0x1
    802001e8:	44c50513          	addi	a0,a0,1100 # 80201630 <etext+0xc8>
    802001ec:	e97ff0ef          	jal	ra,80200082 <cprintf>
    802001f0:	7c0c                	ld	a1,56(s0)
    802001f2:	00001517          	auipc	a0,0x1
    802001f6:	45650513          	addi	a0,a0,1110 # 80201648 <etext+0xe0>
    802001fa:	e89ff0ef          	jal	ra,80200082 <cprintf>
    802001fe:	602c                	ld	a1,64(s0)
    80200200:	00001517          	auipc	a0,0x1
    80200204:	46050513          	addi	a0,a0,1120 # 80201660 <etext+0xf8>
    80200208:	e7bff0ef          	jal	ra,80200082 <cprintf>
    8020020c:	642c                	ld	a1,72(s0)
    8020020e:	00001517          	auipc	a0,0x1
    80200212:	46a50513          	addi	a0,a0,1130 # 80201678 <etext+0x110>
    80200216:	e6dff0ef          	jal	ra,80200082 <cprintf>
    8020021a:	682c                	ld	a1,80(s0)
    8020021c:	00001517          	auipc	a0,0x1
    80200220:	47450513          	addi	a0,a0,1140 # 80201690 <etext+0x128>
    80200224:	e5fff0ef          	jal	ra,80200082 <cprintf>
    80200228:	6c2c                	ld	a1,88(s0)
    8020022a:	00001517          	auipc	a0,0x1
    8020022e:	47e50513          	addi	a0,a0,1150 # 802016a8 <etext+0x140>
    80200232:	e51ff0ef          	jal	ra,80200082 <cprintf>
    80200236:	702c                	ld	a1,96(s0)
    80200238:	00001517          	auipc	a0,0x1
    8020023c:	48850513          	addi	a0,a0,1160 # 802016c0 <etext+0x158>
    80200240:	e43ff0ef          	jal	ra,80200082 <cprintf>
    80200244:	742c                	ld	a1,104(s0)
    80200246:	00001517          	auipc	a0,0x1
    8020024a:	49250513          	addi	a0,a0,1170 # 802016d8 <etext+0x170>
    8020024e:	e35ff0ef          	jal	ra,80200082 <cprintf>
    80200252:	782c                	ld	a1,112(s0)
    80200254:	00001517          	auipc	a0,0x1
    80200258:	49c50513          	addi	a0,a0,1180 # 802016f0 <etext+0x188>
    8020025c:	e27ff0ef          	jal	ra,80200082 <cprintf>
    80200260:	7c2c                	ld	a1,120(s0)
    80200262:	00001517          	auipc	a0,0x1
    80200266:	4a650513          	addi	a0,a0,1190 # 80201708 <etext+0x1a0>
    8020026a:	e19ff0ef          	jal	ra,80200082 <cprintf>
    8020026e:	604c                	ld	a1,128(s0)
    80200270:	00001517          	auipc	a0,0x1
    80200274:	4b050513          	addi	a0,a0,1200 # 80201720 <etext+0x1b8>
    80200278:	e0bff0ef          	jal	ra,80200082 <cprintf>
    8020027c:	644c                	ld	a1,136(s0)
    8020027e:	00001517          	auipc	a0,0x1
    80200282:	4ba50513          	addi	a0,a0,1210 # 80201738 <etext+0x1d0>
    80200286:	dfdff0ef          	jal	ra,80200082 <cprintf>
    8020028a:	684c                	ld	a1,144(s0)
    8020028c:	00001517          	auipc	a0,0x1
    80200290:	4c450513          	addi	a0,a0,1220 # 80201750 <etext+0x1e8>
    80200294:	defff0ef          	jal	ra,80200082 <cprintf>
    80200298:	6c4c                	ld	a1,152(s0)
    8020029a:	00001517          	auipc	a0,0x1
    8020029e:	4ce50513          	addi	a0,a0,1230 # 80201768 <etext+0x200>
    802002a2:	de1ff0ef          	jal	ra,80200082 <cprintf>
    802002a6:	704c                	ld	a1,160(s0)
    802002a8:	00001517          	auipc	a0,0x1
    802002ac:	4d850513          	addi	a0,a0,1240 # 80201780 <etext+0x218>
    802002b0:	dd3ff0ef          	jal	ra,80200082 <cprintf>
    802002b4:	744c                	ld	a1,168(s0)
    802002b6:	00001517          	auipc	a0,0x1
    802002ba:	4e250513          	addi	a0,a0,1250 # 80201798 <etext+0x230>
    802002be:	dc5ff0ef          	jal	ra,80200082 <cprintf>
    802002c2:	784c                	ld	a1,176(s0)
    802002c4:	00001517          	auipc	a0,0x1
    802002c8:	4ec50513          	addi	a0,a0,1260 # 802017b0 <etext+0x248>
    802002cc:	db7ff0ef          	jal	ra,80200082 <cprintf>
    802002d0:	7c4c                	ld	a1,184(s0)
    802002d2:	00001517          	auipc	a0,0x1
    802002d6:	4f650513          	addi	a0,a0,1270 # 802017c8 <etext+0x260>
    802002da:	da9ff0ef          	jal	ra,80200082 <cprintf>
    802002de:	606c                	ld	a1,192(s0)
    802002e0:	00001517          	auipc	a0,0x1
    802002e4:	50050513          	addi	a0,a0,1280 # 802017e0 <etext+0x278>
    802002e8:	d9bff0ef          	jal	ra,80200082 <cprintf>
    802002ec:	646c                	ld	a1,200(s0)
    802002ee:	00001517          	auipc	a0,0x1
    802002f2:	50a50513          	addi	a0,a0,1290 # 802017f8 <etext+0x290>
    802002f6:	d8dff0ef          	jal	ra,80200082 <cprintf>
    802002fa:	686c                	ld	a1,208(s0)
    802002fc:	00001517          	auipc	a0,0x1
    80200300:	51450513          	addi	a0,a0,1300 # 80201810 <etext+0x2a8>
    80200304:	d7fff0ef          	jal	ra,80200082 <cprintf>
    80200308:	6c6c                	ld	a1,216(s0)
    8020030a:	00001517          	auipc	a0,0x1
    8020030e:	51e50513          	addi	a0,a0,1310 # 80201828 <etext+0x2c0>
    80200312:	d71ff0ef          	jal	ra,80200082 <cprintf>
    80200316:	706c                	ld	a1,224(s0)
    80200318:	00001517          	auipc	a0,0x1
    8020031c:	52850513          	addi	a0,a0,1320 # 80201840 <etext+0x2d8>
    80200320:	d63ff0ef          	jal	ra,80200082 <cprintf>
    80200324:	746c                	ld	a1,232(s0)
    80200326:	00001517          	auipc	a0,0x1
    8020032a:	53250513          	addi	a0,a0,1330 # 80201858 <etext+0x2f0>
    8020032e:	d55ff0ef          	jal	ra,80200082 <cprintf>
    80200332:	786c                	ld	a1,240(s0)
    80200334:	00001517          	auipc	a0,0x1
    80200338:	53c50513          	addi	a0,a0,1340 # 80201870 <etext+0x308>
    8020033c:	d47ff0ef          	jal	ra,80200082 <cprintf>
    80200340:	7c6c                	ld	a1,248(s0)
    80200342:	6402                	ld	s0,0(sp)
    80200344:	60a2                	ld	ra,8(sp)
    80200346:	00001517          	auipc	a0,0x1
    8020034a:	54250513          	addi	a0,a0,1346 # 80201888 <etext+0x320>
    8020034e:	0141                	addi	sp,sp,16
    80200350:	bb0d                	j	80200082 <cprintf>

0000000080200352 <print_trapframe>:
    80200352:	1141                	addi	sp,sp,-16
    80200354:	e022                	sd	s0,0(sp)
    80200356:	85aa                	mv	a1,a0
    80200358:	842a                	mv	s0,a0
    8020035a:	00001517          	auipc	a0,0x1
    8020035e:	54650513          	addi	a0,a0,1350 # 802018a0 <etext+0x338>
    80200362:	e406                	sd	ra,8(sp)
    80200364:	d1fff0ef          	jal	ra,80200082 <cprintf>
    80200368:	8522                	mv	a0,s0
    8020036a:	e1dff0ef          	jal	ra,80200186 <print_regs>
    8020036e:	10043583          	ld	a1,256(s0)
    80200372:	00001517          	auipc	a0,0x1
    80200376:	54650513          	addi	a0,a0,1350 # 802018b8 <etext+0x350>
    8020037a:	d09ff0ef          	jal	ra,80200082 <cprintf>
    8020037e:	10843583          	ld	a1,264(s0)
    80200382:	00001517          	auipc	a0,0x1
    80200386:	54e50513          	addi	a0,a0,1358 # 802018d0 <etext+0x368>
    8020038a:	cf9ff0ef          	jal	ra,80200082 <cprintf>
    8020038e:	11043583          	ld	a1,272(s0)
    80200392:	00001517          	auipc	a0,0x1
    80200396:	55650513          	addi	a0,a0,1366 # 802018e8 <etext+0x380>
    8020039a:	ce9ff0ef          	jal	ra,80200082 <cprintf>
    8020039e:	11843583          	ld	a1,280(s0)
    802003a2:	6402                	ld	s0,0(sp)
    802003a4:	60a2                	ld	ra,8(sp)
    802003a6:	00001517          	auipc	a0,0x1
    802003aa:	55a50513          	addi	a0,a0,1370 # 80201900 <etext+0x398>
    802003ae:	0141                	addi	sp,sp,16
    802003b0:	b9c9                	j	80200082 <cprintf>

00000000802003b2 <interrupt_handler>:
    802003b2:	11853783          	ld	a5,280(a0)
    802003b6:	472d                	li	a4,11
    802003b8:	0786                	slli	a5,a5,0x1
    802003ba:	8385                	srli	a5,a5,0x1
    802003bc:	06f76c63          	bltu	a4,a5,80200434 <interrupt_handler+0x82>
    802003c0:	00001717          	auipc	a4,0x1
    802003c4:	62070713          	addi	a4,a4,1568 # 802019e0 <etext+0x478>
    802003c8:	078a                	slli	a5,a5,0x2
    802003ca:	97ba                	add	a5,a5,a4
    802003cc:	439c                	lw	a5,0(a5)
    802003ce:	97ba                	add	a5,a5,a4
    802003d0:	8782                	jr	a5
    802003d2:	00001517          	auipc	a0,0x1
    802003d6:	5a650513          	addi	a0,a0,1446 # 80201978 <etext+0x410>
    802003da:	b165                	j	80200082 <cprintf>
    802003dc:	00001517          	auipc	a0,0x1
    802003e0:	57c50513          	addi	a0,a0,1404 # 80201958 <etext+0x3f0>
    802003e4:	b979                	j	80200082 <cprintf>
    802003e6:	00001517          	auipc	a0,0x1
    802003ea:	53250513          	addi	a0,a0,1330 # 80201918 <etext+0x3b0>
    802003ee:	b951                	j	80200082 <cprintf>
    802003f0:	00001517          	auipc	a0,0x1
    802003f4:	5a850513          	addi	a0,a0,1448 # 80201998 <etext+0x430>
    802003f8:	b169                	j	80200082 <cprintf>
    802003fa:	1141                	addi	sp,sp,-16
    802003fc:	e406                	sd	ra,8(sp)
    802003fe:	d51ff0ef          	jal	ra,8020014e <clock_set_next_event>
    80200402:	00005697          	auipc	a3,0x5
    80200406:	c1e68693          	addi	a3,a3,-994 # 80205020 <ticks>
    8020040a:	629c                	ld	a5,0(a3)
    8020040c:	06400713          	li	a4,100
    80200410:	0785                	addi	a5,a5,1
    80200412:	02e7f733          	remu	a4,a5,a4
    80200416:	e29c                	sd	a5,0(a3)
    80200418:	cf19                	beqz	a4,80200436 <interrupt_handler+0x84>
    8020041a:	60a2                	ld	ra,8(sp)
    8020041c:	0141                	addi	sp,sp,16
    8020041e:	8082                	ret
    80200420:	00001517          	auipc	a0,0x1
    80200424:	5a050513          	addi	a0,a0,1440 # 802019c0 <etext+0x458>
    80200428:	b9a9                	j	80200082 <cprintf>
    8020042a:	00001517          	auipc	a0,0x1
    8020042e:	50e50513          	addi	a0,a0,1294 # 80201938 <etext+0x3d0>
    80200432:	b981                	j	80200082 <cprintf>
    80200434:	bf39                	j	80200352 <print_trapframe>
    80200436:	60a2                	ld	ra,8(sp)
    80200438:	06400593          	li	a1,100
    8020043c:	00001517          	auipc	a0,0x1
    80200440:	57450513          	addi	a0,a0,1396 # 802019b0 <etext+0x448>
    80200444:	0141                	addi	sp,sp,16
    80200446:	b935                	j	80200082 <cprintf>

0000000080200448 <trap>:
    80200448:	11853783          	ld	a5,280(a0)
    8020044c:	0007c763          	bltz	a5,8020045a <trap+0x12>
    80200450:	472d                	li	a4,11
    80200452:	00f76363          	bltu	a4,a5,80200458 <trap+0x10>
    80200456:	8082                	ret
    80200458:	bded                	j	80200352 <print_trapframe>
    8020045a:	bfa1                	j	802003b2 <interrupt_handler>

000000008020045c <__alltraps>:
    8020045c:	14011073          	csrw	sscratch,sp
    80200460:	712d                	addi	sp,sp,-288
    80200462:	e002                	sd	zero,0(sp)
    80200464:	e406                	sd	ra,8(sp)
    80200466:	ec0e                	sd	gp,24(sp)
    80200468:	f012                	sd	tp,32(sp)
    8020046a:	f416                	sd	t0,40(sp)
    8020046c:	f81a                	sd	t1,48(sp)
    8020046e:	fc1e                	sd	t2,56(sp)
    80200470:	e0a2                	sd	s0,64(sp)
    80200472:	e4a6                	sd	s1,72(sp)
    80200474:	e8aa                	sd	a0,80(sp)
    80200476:	ecae                	sd	a1,88(sp)
    80200478:	f0b2                	sd	a2,96(sp)
    8020047a:	f4b6                	sd	a3,104(sp)
    8020047c:	f8ba                	sd	a4,112(sp)
    8020047e:	fcbe                	sd	a5,120(sp)
    80200480:	e142                	sd	a6,128(sp)
    80200482:	e546                	sd	a7,136(sp)
    80200484:	e94a                	sd	s2,144(sp)
    80200486:	ed4e                	sd	s3,152(sp)
    80200488:	f152                	sd	s4,160(sp)
    8020048a:	f556                	sd	s5,168(sp)
    8020048c:	f95a                	sd	s6,176(sp)
    8020048e:	fd5e                	sd	s7,184(sp)
    80200490:	e1e2                	sd	s8,192(sp)
    80200492:	e5e6                	sd	s9,200(sp)
    80200494:	e9ea                	sd	s10,208(sp)
    80200496:	edee                	sd	s11,216(sp)
    80200498:	f1f2                	sd	t3,224(sp)
    8020049a:	f5f6                	sd	t4,232(sp)
    8020049c:	f9fa                	sd	t5,240(sp)
    8020049e:	fdfe                	sd	t6,248(sp)
    802004a0:	14001473          	csrrw	s0,sscratch,zero
    802004a4:	100024f3          	csrr	s1,sstatus
    802004a8:	14102973          	csrr	s2,sepc
    802004ac:	143029f3          	csrr	s3,stval
    802004b0:	14202a73          	csrr	s4,scause
    802004b4:	e822                	sd	s0,16(sp)
    802004b6:	e226                	sd	s1,256(sp)
    802004b8:	e64a                	sd	s2,264(sp)
    802004ba:	ea4e                	sd	s3,272(sp)
    802004bc:	ee52                	sd	s4,280(sp)
    802004be:	850a                	mv	a0,sp
    802004c0:	f89ff0ef          	jal	ra,80200448 <trap>

00000000802004c4 <__trapret>:
    802004c4:	6492                	ld	s1,256(sp)
    802004c6:	6932                	ld	s2,264(sp)
    802004c8:	10049073          	csrw	sstatus,s1
    802004cc:	14191073          	csrw	sepc,s2
    802004d0:	60a2                	ld	ra,8(sp)
    802004d2:	61e2                	ld	gp,24(sp)
    802004d4:	7202                	ld	tp,32(sp)
    802004d6:	72a2                	ld	t0,40(sp)
    802004d8:	7342                	ld	t1,48(sp)
    802004da:	73e2                	ld	t2,56(sp)
    802004dc:	6406                	ld	s0,64(sp)
    802004de:	64a6                	ld	s1,72(sp)
    802004e0:	6546                	ld	a0,80(sp)
    802004e2:	65e6                	ld	a1,88(sp)
    802004e4:	7606                	ld	a2,96(sp)
    802004e6:	76a6                	ld	a3,104(sp)
    802004e8:	7746                	ld	a4,112(sp)
    802004ea:	77e6                	ld	a5,120(sp)
    802004ec:	680a                	ld	a6,128(sp)
    802004ee:	68aa                	ld	a7,136(sp)
    802004f0:	694a                	ld	s2,144(sp)
    802004f2:	69ea                	ld	s3,152(sp)
    802004f4:	7a0a                	ld	s4,160(sp)
    802004f6:	7aaa                	ld	s5,168(sp)
    802004f8:	7b4a                	ld	s6,176(sp)
    802004fa:	7bea                	ld	s7,184(sp)
    802004fc:	6c0e                	ld	s8,192(sp)
    802004fe:	6cae                	ld	s9,200(sp)
    80200500:	6d4e                	ld	s10,208(sp)
    80200502:	6dee                	ld	s11,216(sp)
    80200504:	7e0e                	ld	t3,224(sp)
    80200506:	7eae                	ld	t4,232(sp)
    80200508:	7f4e                	ld	t5,240(sp)
    8020050a:	7fee                	ld	t6,248(sp)
    8020050c:	6142                	ld	sp,16(sp)
    8020050e:	10200073          	sret

0000000080200512 <alloc_pages>:
    80200512:	100027f3          	csrr	a5,sstatus
    80200516:	8b89                	andi	a5,a5,2
    80200518:	eb81                	bnez	a5,80200528 <alloc_pages+0x16>
    8020051a:	00005797          	auipc	a5,0x5
    8020051e:	b167b783          	ld	a5,-1258(a5) # 80205030 <pmm_manager>
    80200522:	0187b303          	ld	t1,24(a5)
    80200526:	8302                	jr	t1
    80200528:	1141                	addi	sp,sp,-16
    8020052a:	e406                	sd	ra,8(sp)
    8020052c:	e022                	sd	s0,0(sp)
    8020052e:	842a                	mv	s0,a0
    80200530:	c3fff0ef          	jal	ra,8020016e <intr_disable>
    80200534:	00005797          	auipc	a5,0x5
    80200538:	afc7b783          	ld	a5,-1284(a5) # 80205030 <pmm_manager>
    8020053c:	6f9c                	ld	a5,24(a5)
    8020053e:	8522                	mv	a0,s0
    80200540:	9782                	jalr	a5
    80200542:	842a                	mv	s0,a0
    80200544:	c25ff0ef          	jal	ra,80200168 <intr_enable>
    80200548:	60a2                	ld	ra,8(sp)
    8020054a:	8522                	mv	a0,s0
    8020054c:	6402                	ld	s0,0(sp)
    8020054e:	0141                	addi	sp,sp,16
    80200550:	8082                	ret

0000000080200552 <free_pages>:
    80200552:	100027f3          	csrr	a5,sstatus
    80200556:	8b89                	andi	a5,a5,2
    80200558:	eb81                	bnez	a5,80200568 <free_pages+0x16>
    8020055a:	00005797          	auipc	a5,0x5
    8020055e:	ad67b783          	ld	a5,-1322(a5) # 80205030 <pmm_manager>
    80200562:	0207b303          	ld	t1,32(a5)
    80200566:	8302                	jr	t1
    80200568:	1101                	addi	sp,sp,-32
    8020056a:	ec06                	sd	ra,24(sp)
    8020056c:	e822                	sd	s0,16(sp)
    8020056e:	e426                	sd	s1,8(sp)
    80200570:	842a                	mv	s0,a0
    80200572:	84ae                	mv	s1,a1
    80200574:	bfbff0ef          	jal	ra,8020016e <intr_disable>
    80200578:	00005797          	auipc	a5,0x5
    8020057c:	ab87b783          	ld	a5,-1352(a5) # 80205030 <pmm_manager>
    80200580:	739c                	ld	a5,32(a5)
    80200582:	85a6                	mv	a1,s1
    80200584:	8522                	mv	a0,s0
    80200586:	9782                	jalr	a5
    80200588:	6442                	ld	s0,16(sp)
    8020058a:	60e2                	ld	ra,24(sp)
    8020058c:	64a2                	ld	s1,8(sp)
    8020058e:	6105                	addi	sp,sp,32
    80200590:	bee1                	j	80200168 <intr_enable>

0000000080200592 <nr_free_pages>:
    80200592:	100027f3          	csrr	a5,sstatus
    80200596:	8b89                	andi	a5,a5,2
    80200598:	eb81                	bnez	a5,802005a8 <nr_free_pages+0x16>
    8020059a:	00005797          	auipc	a5,0x5
    8020059e:	a967b783          	ld	a5,-1386(a5) # 80205030 <pmm_manager>
    802005a2:	0287b303          	ld	t1,40(a5)
    802005a6:	8302                	jr	t1
    802005a8:	1141                	addi	sp,sp,-16
    802005aa:	e406                	sd	ra,8(sp)
    802005ac:	e022                	sd	s0,0(sp)
    802005ae:	bc1ff0ef          	jal	ra,8020016e <intr_disable>
    802005b2:	00005797          	auipc	a5,0x5
    802005b6:	a7e7b783          	ld	a5,-1410(a5) # 80205030 <pmm_manager>
    802005ba:	779c                	ld	a5,40(a5)
    802005bc:	9782                	jalr	a5
    802005be:	842a                	mv	s0,a0
    802005c0:	ba9ff0ef          	jal	ra,80200168 <intr_enable>
    802005c4:	60a2                	ld	ra,8(sp)
    802005c6:	8522                	mv	a0,s0
    802005c8:	6402                	ld	s0,0(sp)
    802005ca:	0141                	addi	sp,sp,16
    802005cc:	8082                	ret

00000000802005ce <pmm_init>:
    802005ce:	00002797          	auipc	a5,0x2
    802005d2:	87278793          	addi	a5,a5,-1934 # 80201e40 <best_fit_pmm_manager>
    802005d6:	638c                	ld	a1,0(a5)
    802005d8:	1141                	addi	sp,sp,-16
    802005da:	e022                	sd	s0,0(sp)
    802005dc:	00001517          	auipc	a0,0x1
    802005e0:	43450513          	addi	a0,a0,1076 # 80201a10 <etext+0x4a8>
    802005e4:	00005417          	auipc	s0,0x5
    802005e8:	a4c40413          	addi	s0,s0,-1460 # 80205030 <pmm_manager>
    802005ec:	e406                	sd	ra,8(sp)
    802005ee:	e01c                	sd	a5,0(s0)
    802005f0:	a93ff0ef          	jal	ra,80200082 <cprintf>
    802005f4:	601c                	ld	a5,0(s0)
    802005f6:	679c                	ld	a5,8(a5)
    802005f8:	9782                	jalr	a5
    802005fa:	00001517          	auipc	a0,0x1
    802005fe:	42e50513          	addi	a0,a0,1070 # 80201a28 <etext+0x4c0>
    80200602:	00005797          	auipc	a5,0x5
    80200606:	a207bb23          	sd	zero,-1482(a5) # 80205038 <va_pa_offset>
    8020060a:	a79ff0ef          	jal	ra,80200082 <cprintf>
    8020060e:	46c5                	li	a3,17
    80200610:	06ee                	slli	a3,a3,0x1b
    80200612:	40100613          	li	a2,1025
    80200616:	16fd                	addi	a3,a3,-1
    80200618:	0656                	slli	a2,a2,0x15
    8020061a:	07e005b7          	lui	a1,0x7e00
    8020061e:	00001517          	auipc	a0,0x1
    80200622:	42250513          	addi	a0,a0,1058 # 80201a40 <etext+0x4d8>
    80200626:	a5dff0ef          	jal	ra,80200082 <cprintf>
    8020062a:	777d                	lui	a4,0xfffff
    8020062c:	00006797          	auipc	a5,0x6
    80200630:	a3378793          	addi	a5,a5,-1485 # 8020605f <end+0xfff>
    80200634:	8ff9                	and	a5,a5,a4
    80200636:	00005517          	auipc	a0,0x5
    8020063a:	9da50513          	addi	a0,a0,-1574 # 80205010 <npage>
    8020063e:	00005697          	auipc	a3,0x5
    80200642:	a0268693          	addi	a3,a3,-1534 # 80205040 <pages>
    80200646:	00088737          	lui	a4,0x88
    8020064a:	e118                	sd	a4,0(a0)
    8020064c:	e29c                	sd	a5,0(a3)
    8020064e:	4581                	li	a1,0
    80200650:	4601                	li	a2,0
    80200652:	4885                	li	a7,1
    80200654:	fff80837          	lui	a6,0xfff80
    80200658:	a011                	j	8020065c <pmm_init+0x8e>
    8020065a:	629c                	ld	a5,0(a3)
    8020065c:	97ae                	add	a5,a5,a1
    8020065e:	07a1                	addi	a5,a5,8
    80200660:	4117b02f          	amoor.d	zero,a7,(a5)
    80200664:	6118                	ld	a4,0(a0)
    80200666:	0605                	addi	a2,a2,1
    80200668:	02858593          	addi	a1,a1,40 # 7e00028 <kern_entry-0x783fffd8>
    8020066c:	010707b3          	add	a5,a4,a6
    80200670:	fef665e3          	bltu	a2,a5,8020065a <pmm_init+0x8c>
    80200674:	6290                	ld	a2,0(a3)
    80200676:	00271793          	slli	a5,a4,0x2
    8020067a:	97ba                	add	a5,a5,a4
    8020067c:	fec006b7          	lui	a3,0xfec00
    80200680:	078e                	slli	a5,a5,0x3
    80200682:	96b2                	add	a3,a3,a2
    80200684:	96be                	add	a3,a3,a5
    80200686:	40100793          	li	a5,1025
    8020068a:	07d6                	slli	a5,a5,0x15
    8020068c:	04f6eb63          	bltu	a3,a5,802006e2 <pmm_init+0x114>
    80200690:	00005597          	auipc	a1,0x5
    80200694:	9a85b583          	ld	a1,-1624(a1) # 80205038 <va_pa_offset>
    80200698:	8e8d                	sub	a3,a3,a1
    8020069a:	45c5                	li	a1,17
    8020069c:	05ee                	slli	a1,a1,0x1b
    8020069e:	00b6ed63          	bltu	a3,a1,802006b8 <pmm_init+0xea>
    802006a2:	601c                	ld	a5,0(s0)
    802006a4:	7b9c                	ld	a5,48(a5)
    802006a6:	9782                	jalr	a5
    802006a8:	6402                	ld	s0,0(sp)
    802006aa:	60a2                	ld	ra,8(sp)
    802006ac:	00001517          	auipc	a0,0x1
    802006b0:	42c50513          	addi	a0,a0,1068 # 80201ad8 <etext+0x570>
    802006b4:	0141                	addi	sp,sp,16
    802006b6:	b2f1                	j	80200082 <cprintf>
    802006b8:	6785                	lui	a5,0x1
    802006ba:	17fd                	addi	a5,a5,-1
    802006bc:	96be                	add	a3,a3,a5
    802006be:	77fd                	lui	a5,0xfffff
    802006c0:	8efd                	and	a3,a3,a5
    802006c2:	00c6d513          	srli	a0,a3,0xc
    802006c6:	02e57a63          	bgeu	a0,a4,802006fa <pmm_init+0x12c>
    802006ca:	601c                	ld	a5,0(s0)
    802006cc:	982a                	add	a6,a6,a0
    802006ce:	00281513          	slli	a0,a6,0x2
    802006d2:	9542                	add	a0,a0,a6
    802006d4:	6b9c                	ld	a5,16(a5)
    802006d6:	8d95                	sub	a1,a1,a3
    802006d8:	050e                	slli	a0,a0,0x3
    802006da:	81b1                	srli	a1,a1,0xc
    802006dc:	9532                	add	a0,a0,a2
    802006de:	9782                	jalr	a5
    802006e0:	b7c9                	j	802006a2 <pmm_init+0xd4>
    802006e2:	00001617          	auipc	a2,0x1
    802006e6:	38e60613          	addi	a2,a2,910 # 80201a70 <etext+0x508>
    802006ea:	06f00593          	li	a1,111
    802006ee:	00001517          	auipc	a0,0x1
    802006f2:	3aa50513          	addi	a0,a0,938 # 80201a98 <etext+0x530>
    802006f6:	a03ff0ef          	jal	ra,802000f8 <__panic>
    802006fa:	00001617          	auipc	a2,0x1
    802006fe:	3ae60613          	addi	a2,a2,942 # 80201aa8 <etext+0x540>
    80200702:	06f00593          	li	a1,111
    80200706:	00001517          	auipc	a0,0x1
    8020070a:	3c250513          	addi	a0,a0,962 # 80201ac8 <etext+0x560>
    8020070e:	9ebff0ef          	jal	ra,802000f8 <__panic>

0000000080200712 <best_fit_init>:
    80200712:	00005797          	auipc	a5,0x5
    80200716:	93678793          	addi	a5,a5,-1738 # 80205048 <free_area>
    8020071a:	e79c                	sd	a5,8(a5)
    8020071c:	e39c                	sd	a5,0(a5)
    8020071e:	0007a823          	sw	zero,16(a5)
    80200722:	8082                	ret

0000000080200724 <best_fit_nr_free_pages>:
    80200724:	00005517          	auipc	a0,0x5
    80200728:	93456503          	lwu	a0,-1740(a0) # 80205058 <free_area+0x10>
    8020072c:	8082                	ret

000000008020072e <best_fit_check>:
    8020072e:	715d                	addi	sp,sp,-80
    80200730:	e0a2                	sd	s0,64(sp)
    80200732:	00005417          	auipc	s0,0x5
    80200736:	91640413          	addi	s0,s0,-1770 # 80205048 <free_area>
    8020073a:	641c                	ld	a5,8(s0)
    8020073c:	e486                	sd	ra,72(sp)
    8020073e:	fc26                	sd	s1,56(sp)
    80200740:	f84a                	sd	s2,48(sp)
    80200742:	f44e                	sd	s3,40(sp)
    80200744:	f052                	sd	s4,32(sp)
    80200746:	ec56                	sd	s5,24(sp)
    80200748:	e85a                	sd	s6,16(sp)
    8020074a:	e45e                	sd	s7,8(sp)
    8020074c:	e062                	sd	s8,0(sp)
    8020074e:	26878b63          	beq	a5,s0,802009c4 <best_fit_check+0x296>
    80200752:	4481                	li	s1,0
    80200754:	4901                	li	s2,0
    80200756:	ff07b703          	ld	a4,-16(a5)
    8020075a:	8b09                	andi	a4,a4,2
    8020075c:	26070863          	beqz	a4,802009cc <best_fit_check+0x29e>
    80200760:	ff87a703          	lw	a4,-8(a5)
    80200764:	679c                	ld	a5,8(a5)
    80200766:	2905                	addiw	s2,s2,1
    80200768:	9cb9                	addw	s1,s1,a4
    8020076a:	fe8796e3          	bne	a5,s0,80200756 <best_fit_check+0x28>
    8020076e:	89a6                	mv	s3,s1
    80200770:	e23ff0ef          	jal	ra,80200592 <nr_free_pages>
    80200774:	33351c63          	bne	a0,s3,80200aac <best_fit_check+0x37e>
    80200778:	4505                	li	a0,1
    8020077a:	d99ff0ef          	jal	ra,80200512 <alloc_pages>
    8020077e:	8a2a                	mv	s4,a0
    80200780:	36050663          	beqz	a0,80200aec <best_fit_check+0x3be>
    80200784:	4505                	li	a0,1
    80200786:	d8dff0ef          	jal	ra,80200512 <alloc_pages>
    8020078a:	89aa                	mv	s3,a0
    8020078c:	34050063          	beqz	a0,80200acc <best_fit_check+0x39e>
    80200790:	4505                	li	a0,1
    80200792:	d81ff0ef          	jal	ra,80200512 <alloc_pages>
    80200796:	8aaa                	mv	s5,a0
    80200798:	2c050a63          	beqz	a0,80200a6c <best_fit_check+0x33e>
    8020079c:	253a0863          	beq	s4,s3,802009ec <best_fit_check+0x2be>
    802007a0:	24aa0663          	beq	s4,a0,802009ec <best_fit_check+0x2be>
    802007a4:	24a98463          	beq	s3,a0,802009ec <best_fit_check+0x2be>
    802007a8:	000a2783          	lw	a5,0(s4)
    802007ac:	26079063          	bnez	a5,80200a0c <best_fit_check+0x2de>
    802007b0:	0009a783          	lw	a5,0(s3)
    802007b4:	24079c63          	bnez	a5,80200a0c <best_fit_check+0x2de>
    802007b8:	411c                	lw	a5,0(a0)
    802007ba:	24079963          	bnez	a5,80200a0c <best_fit_check+0x2de>
    802007be:	00005797          	auipc	a5,0x5
    802007c2:	8827b783          	ld	a5,-1918(a5) # 80205040 <pages>
    802007c6:	40fa0733          	sub	a4,s4,a5
    802007ca:	870d                	srai	a4,a4,0x3
    802007cc:	00002597          	auipc	a1,0x2
    802007d0:	8fc5b583          	ld	a1,-1796(a1) # 802020c8 <nbase+0x8>
    802007d4:	02b70733          	mul	a4,a4,a1
    802007d8:	00002617          	auipc	a2,0x2
    802007dc:	8e863603          	ld	a2,-1816(a2) # 802020c0 <nbase>
    802007e0:	00005697          	auipc	a3,0x5
    802007e4:	8306b683          	ld	a3,-2000(a3) # 80205010 <npage>
    802007e8:	06b2                	slli	a3,a3,0xc
    802007ea:	9732                	add	a4,a4,a2
    802007ec:	0732                	slli	a4,a4,0xc
    802007ee:	22d77f63          	bgeu	a4,a3,80200a2c <best_fit_check+0x2fe>
    802007f2:	40f98733          	sub	a4,s3,a5
    802007f6:	870d                	srai	a4,a4,0x3
    802007f8:	02b70733          	mul	a4,a4,a1
    802007fc:	9732                	add	a4,a4,a2
    802007fe:	0732                	slli	a4,a4,0xc
    80200800:	3ed77663          	bgeu	a4,a3,80200bec <best_fit_check+0x4be>
    80200804:	40f507b3          	sub	a5,a0,a5
    80200808:	878d                	srai	a5,a5,0x3
    8020080a:	02b787b3          	mul	a5,a5,a1
    8020080e:	97b2                	add	a5,a5,a2
    80200810:	07b2                	slli	a5,a5,0xc
    80200812:	3ad7fd63          	bgeu	a5,a3,80200bcc <best_fit_check+0x49e>
    80200816:	4505                	li	a0,1
    80200818:	00043c03          	ld	s8,0(s0)
    8020081c:	00843b83          	ld	s7,8(s0)
    80200820:	01042b03          	lw	s6,16(s0)
    80200824:	e400                	sd	s0,8(s0)
    80200826:	e000                	sd	s0,0(s0)
    80200828:	00005797          	auipc	a5,0x5
    8020082c:	8207a823          	sw	zero,-2000(a5) # 80205058 <free_area+0x10>
    80200830:	ce3ff0ef          	jal	ra,80200512 <alloc_pages>
    80200834:	36051c63          	bnez	a0,80200bac <best_fit_check+0x47e>
    80200838:	4585                	li	a1,1
    8020083a:	8552                	mv	a0,s4
    8020083c:	d17ff0ef          	jal	ra,80200552 <free_pages>
    80200840:	4585                	li	a1,1
    80200842:	854e                	mv	a0,s3
    80200844:	d0fff0ef          	jal	ra,80200552 <free_pages>
    80200848:	4585                	li	a1,1
    8020084a:	8556                	mv	a0,s5
    8020084c:	d07ff0ef          	jal	ra,80200552 <free_pages>
    80200850:	4818                	lw	a4,16(s0)
    80200852:	478d                	li	a5,3
    80200854:	32f71c63          	bne	a4,a5,80200b8c <best_fit_check+0x45e>
    80200858:	4505                	li	a0,1
    8020085a:	cb9ff0ef          	jal	ra,80200512 <alloc_pages>
    8020085e:	89aa                	mv	s3,a0
    80200860:	30050663          	beqz	a0,80200b6c <best_fit_check+0x43e>
    80200864:	4505                	li	a0,1
    80200866:	cadff0ef          	jal	ra,80200512 <alloc_pages>
    8020086a:	8aaa                	mv	s5,a0
    8020086c:	2e050063          	beqz	a0,80200b4c <best_fit_check+0x41e>
    80200870:	4505                	li	a0,1
    80200872:	ca1ff0ef          	jal	ra,80200512 <alloc_pages>
    80200876:	8a2a                	mv	s4,a0
    80200878:	2a050a63          	beqz	a0,80200b2c <best_fit_check+0x3fe>
    8020087c:	4505                	li	a0,1
    8020087e:	c95ff0ef          	jal	ra,80200512 <alloc_pages>
    80200882:	28051563          	bnez	a0,80200b0c <best_fit_check+0x3de>
    80200886:	4585                	li	a1,1
    80200888:	854e                	mv	a0,s3
    8020088a:	cc9ff0ef          	jal	ra,80200552 <free_pages>
    8020088e:	641c                	ld	a5,8(s0)
    80200890:	1a878e63          	beq	a5,s0,80200a4c <best_fit_check+0x31e>
    80200894:	4505                	li	a0,1
    80200896:	c7dff0ef          	jal	ra,80200512 <alloc_pages>
    8020089a:	52a99963          	bne	s3,a0,80200dcc <best_fit_check+0x69e>
    8020089e:	4505                	li	a0,1
    802008a0:	c73ff0ef          	jal	ra,80200512 <alloc_pages>
    802008a4:	50051463          	bnez	a0,80200dac <best_fit_check+0x67e>
    802008a8:	481c                	lw	a5,16(s0)
    802008aa:	4e079163          	bnez	a5,80200d8c <best_fit_check+0x65e>
    802008ae:	854e                	mv	a0,s3
    802008b0:	4585                	li	a1,1
    802008b2:	01843023          	sd	s8,0(s0)
    802008b6:	01743423          	sd	s7,8(s0)
    802008ba:	01642823          	sw	s6,16(s0)
    802008be:	c95ff0ef          	jal	ra,80200552 <free_pages>
    802008c2:	4585                	li	a1,1
    802008c4:	8556                	mv	a0,s5
    802008c6:	c8dff0ef          	jal	ra,80200552 <free_pages>
    802008ca:	4585                	li	a1,1
    802008cc:	8552                	mv	a0,s4
    802008ce:	c85ff0ef          	jal	ra,80200552 <free_pages>
    802008d2:	4515                	li	a0,5
    802008d4:	c3fff0ef          	jal	ra,80200512 <alloc_pages>
    802008d8:	89aa                	mv	s3,a0
    802008da:	48050963          	beqz	a0,80200d6c <best_fit_check+0x63e>
    802008de:	651c                	ld	a5,8(a0)
    802008e0:	8385                	srli	a5,a5,0x1
    802008e2:	8b85                	andi	a5,a5,1
    802008e4:	46079463          	bnez	a5,80200d4c <best_fit_check+0x61e>
    802008e8:	4505                	li	a0,1
    802008ea:	00043a83          	ld	s5,0(s0)
    802008ee:	00843a03          	ld	s4,8(s0)
    802008f2:	e000                	sd	s0,0(s0)
    802008f4:	e400                	sd	s0,8(s0)
    802008f6:	c1dff0ef          	jal	ra,80200512 <alloc_pages>
    802008fa:	42051963          	bnez	a0,80200d2c <best_fit_check+0x5fe>
    802008fe:	4589                	li	a1,2
    80200900:	02898513          	addi	a0,s3,40
    80200904:	01042b03          	lw	s6,16(s0)
    80200908:	0a098c13          	addi	s8,s3,160
    8020090c:	00004797          	auipc	a5,0x4
    80200910:	7407a623          	sw	zero,1868(a5) # 80205058 <free_area+0x10>
    80200914:	c3fff0ef          	jal	ra,80200552 <free_pages>
    80200918:	8562                	mv	a0,s8
    8020091a:	4585                	li	a1,1
    8020091c:	c37ff0ef          	jal	ra,80200552 <free_pages>
    80200920:	4511                	li	a0,4
    80200922:	bf1ff0ef          	jal	ra,80200512 <alloc_pages>
    80200926:	3e051363          	bnez	a0,80200d0c <best_fit_check+0x5de>
    8020092a:	0309b783          	ld	a5,48(s3)
    8020092e:	8385                	srli	a5,a5,0x1
    80200930:	8b85                	andi	a5,a5,1
    80200932:	3a078d63          	beqz	a5,80200cec <best_fit_check+0x5be>
    80200936:	0389a703          	lw	a4,56(s3)
    8020093a:	4789                	li	a5,2
    8020093c:	3af71863          	bne	a4,a5,80200cec <best_fit_check+0x5be>
    80200940:	4505                	li	a0,1
    80200942:	bd1ff0ef          	jal	ra,80200512 <alloc_pages>
    80200946:	8baa                	mv	s7,a0
    80200948:	38050263          	beqz	a0,80200ccc <best_fit_check+0x59e>
    8020094c:	4509                	li	a0,2
    8020094e:	bc5ff0ef          	jal	ra,80200512 <alloc_pages>
    80200952:	34050d63          	beqz	a0,80200cac <best_fit_check+0x57e>
    80200956:	337c1b63          	bne	s8,s7,80200c8c <best_fit_check+0x55e>
    8020095a:	854e                	mv	a0,s3
    8020095c:	4595                	li	a1,5
    8020095e:	bf5ff0ef          	jal	ra,80200552 <free_pages>
    80200962:	4515                	li	a0,5
    80200964:	bafff0ef          	jal	ra,80200512 <alloc_pages>
    80200968:	89aa                	mv	s3,a0
    8020096a:	30050163          	beqz	a0,80200c6c <best_fit_check+0x53e>
    8020096e:	4505                	li	a0,1
    80200970:	ba3ff0ef          	jal	ra,80200512 <alloc_pages>
    80200974:	2c051c63          	bnez	a0,80200c4c <best_fit_check+0x51e>
    80200978:	481c                	lw	a5,16(s0)
    8020097a:	2a079963          	bnez	a5,80200c2c <best_fit_check+0x4fe>
    8020097e:	4595                	li	a1,5
    80200980:	854e                	mv	a0,s3
    80200982:	01642823          	sw	s6,16(s0)
    80200986:	01543023          	sd	s5,0(s0)
    8020098a:	01443423          	sd	s4,8(s0)
    8020098e:	bc5ff0ef          	jal	ra,80200552 <free_pages>
    80200992:	641c                	ld	a5,8(s0)
    80200994:	00878963          	beq	a5,s0,802009a6 <best_fit_check+0x278>
    80200998:	ff87a703          	lw	a4,-8(a5)
    8020099c:	679c                	ld	a5,8(a5)
    8020099e:	397d                	addiw	s2,s2,-1
    802009a0:	9c99                	subw	s1,s1,a4
    802009a2:	fe879be3          	bne	a5,s0,80200998 <best_fit_check+0x26a>
    802009a6:	26091363          	bnez	s2,80200c0c <best_fit_check+0x4de>
    802009aa:	e0ed                	bnez	s1,80200a8c <best_fit_check+0x35e>
    802009ac:	60a6                	ld	ra,72(sp)
    802009ae:	6406                	ld	s0,64(sp)
    802009b0:	74e2                	ld	s1,56(sp)
    802009b2:	7942                	ld	s2,48(sp)
    802009b4:	79a2                	ld	s3,40(sp)
    802009b6:	7a02                	ld	s4,32(sp)
    802009b8:	6ae2                	ld	s5,24(sp)
    802009ba:	6b42                	ld	s6,16(sp)
    802009bc:	6ba2                	ld	s7,8(sp)
    802009be:	6c02                	ld	s8,0(sp)
    802009c0:	6161                	addi	sp,sp,80
    802009c2:	8082                	ret
    802009c4:	4981                	li	s3,0
    802009c6:	4481                	li	s1,0
    802009c8:	4901                	li	s2,0
    802009ca:	b35d                	j	80200770 <best_fit_check+0x42>
    802009cc:	00001697          	auipc	a3,0x1
    802009d0:	12c68693          	addi	a3,a3,300 # 80201af8 <etext+0x590>
    802009d4:	00001617          	auipc	a2,0x1
    802009d8:	13460613          	addi	a2,a2,308 # 80201b08 <etext+0x5a0>
    802009dc:	0dd00593          	li	a1,221
    802009e0:	00001517          	auipc	a0,0x1
    802009e4:	14050513          	addi	a0,a0,320 # 80201b20 <etext+0x5b8>
    802009e8:	f10ff0ef          	jal	ra,802000f8 <__panic>
    802009ec:	00001697          	auipc	a3,0x1
    802009f0:	1cc68693          	addi	a3,a3,460 # 80201bb8 <etext+0x650>
    802009f4:	00001617          	auipc	a2,0x1
    802009f8:	11460613          	addi	a2,a2,276 # 80201b08 <etext+0x5a0>
    802009fc:	0a700593          	li	a1,167
    80200a00:	00001517          	auipc	a0,0x1
    80200a04:	12050513          	addi	a0,a0,288 # 80201b20 <etext+0x5b8>
    80200a08:	ef0ff0ef          	jal	ra,802000f8 <__panic>
    80200a0c:	00001697          	auipc	a3,0x1
    80200a10:	1d468693          	addi	a3,a3,468 # 80201be0 <etext+0x678>
    80200a14:	00001617          	auipc	a2,0x1
    80200a18:	0f460613          	addi	a2,a2,244 # 80201b08 <etext+0x5a0>
    80200a1c:	0a800593          	li	a1,168
    80200a20:	00001517          	auipc	a0,0x1
    80200a24:	10050513          	addi	a0,a0,256 # 80201b20 <etext+0x5b8>
    80200a28:	ed0ff0ef          	jal	ra,802000f8 <__panic>
    80200a2c:	00001697          	auipc	a3,0x1
    80200a30:	1f468693          	addi	a3,a3,500 # 80201c20 <etext+0x6b8>
    80200a34:	00001617          	auipc	a2,0x1
    80200a38:	0d460613          	addi	a2,a2,212 # 80201b08 <etext+0x5a0>
    80200a3c:	0aa00593          	li	a1,170
    80200a40:	00001517          	auipc	a0,0x1
    80200a44:	0e050513          	addi	a0,a0,224 # 80201b20 <etext+0x5b8>
    80200a48:	eb0ff0ef          	jal	ra,802000f8 <__panic>
    80200a4c:	00001697          	auipc	a3,0x1
    80200a50:	25c68693          	addi	a3,a3,604 # 80201ca8 <etext+0x740>
    80200a54:	00001617          	auipc	a2,0x1
    80200a58:	0b460613          	addi	a2,a2,180 # 80201b08 <etext+0x5a0>
    80200a5c:	0c300593          	li	a1,195
    80200a60:	00001517          	auipc	a0,0x1
    80200a64:	0c050513          	addi	a0,a0,192 # 80201b20 <etext+0x5b8>
    80200a68:	e90ff0ef          	jal	ra,802000f8 <__panic>
    80200a6c:	00001697          	auipc	a3,0x1
    80200a70:	12c68693          	addi	a3,a3,300 # 80201b98 <etext+0x630>
    80200a74:	00001617          	auipc	a2,0x1
    80200a78:	09460613          	addi	a2,a2,148 # 80201b08 <etext+0x5a0>
    80200a7c:	0a500593          	li	a1,165
    80200a80:	00001517          	auipc	a0,0x1
    80200a84:	0a050513          	addi	a0,a0,160 # 80201b20 <etext+0x5b8>
    80200a88:	e70ff0ef          	jal	ra,802000f8 <__panic>
    80200a8c:	00001697          	auipc	a3,0x1
    80200a90:	34c68693          	addi	a3,a3,844 # 80201dd8 <etext+0x870>
    80200a94:	00001617          	auipc	a2,0x1
    80200a98:	07460613          	addi	a2,a2,116 # 80201b08 <etext+0x5a0>
    80200a9c:	12000593          	li	a1,288
    80200aa0:	00001517          	auipc	a0,0x1
    80200aa4:	08050513          	addi	a0,a0,128 # 80201b20 <etext+0x5b8>
    80200aa8:	e50ff0ef          	jal	ra,802000f8 <__panic>
    80200aac:	00001697          	auipc	a3,0x1
    80200ab0:	08c68693          	addi	a3,a3,140 # 80201b38 <etext+0x5d0>
    80200ab4:	00001617          	auipc	a2,0x1
    80200ab8:	05460613          	addi	a2,a2,84 # 80201b08 <etext+0x5a0>
    80200abc:	0e000593          	li	a1,224
    80200ac0:	00001517          	auipc	a0,0x1
    80200ac4:	06050513          	addi	a0,a0,96 # 80201b20 <etext+0x5b8>
    80200ac8:	e30ff0ef          	jal	ra,802000f8 <__panic>
    80200acc:	00001697          	auipc	a3,0x1
    80200ad0:	0ac68693          	addi	a3,a3,172 # 80201b78 <etext+0x610>
    80200ad4:	00001617          	auipc	a2,0x1
    80200ad8:	03460613          	addi	a2,a2,52 # 80201b08 <etext+0x5a0>
    80200adc:	0a400593          	li	a1,164
    80200ae0:	00001517          	auipc	a0,0x1
    80200ae4:	04050513          	addi	a0,a0,64 # 80201b20 <etext+0x5b8>
    80200ae8:	e10ff0ef          	jal	ra,802000f8 <__panic>
    80200aec:	00001697          	auipc	a3,0x1
    80200af0:	06c68693          	addi	a3,a3,108 # 80201b58 <etext+0x5f0>
    80200af4:	00001617          	auipc	a2,0x1
    80200af8:	01460613          	addi	a2,a2,20 # 80201b08 <etext+0x5a0>
    80200afc:	0a300593          	li	a1,163
    80200b00:	00001517          	auipc	a0,0x1
    80200b04:	02050513          	addi	a0,a0,32 # 80201b20 <etext+0x5b8>
    80200b08:	df0ff0ef          	jal	ra,802000f8 <__panic>
    80200b0c:	00001697          	auipc	a3,0x1
    80200b10:	17468693          	addi	a3,a3,372 # 80201c80 <etext+0x718>
    80200b14:	00001617          	auipc	a2,0x1
    80200b18:	ff460613          	addi	a2,a2,-12 # 80201b08 <etext+0x5a0>
    80200b1c:	0c000593          	li	a1,192
    80200b20:	00001517          	auipc	a0,0x1
    80200b24:	00050513          	mv	a0,a0
    80200b28:	dd0ff0ef          	jal	ra,802000f8 <__panic>
    80200b2c:	00001697          	auipc	a3,0x1
    80200b30:	06c68693          	addi	a3,a3,108 # 80201b98 <etext+0x630>
    80200b34:	00001617          	auipc	a2,0x1
    80200b38:	fd460613          	addi	a2,a2,-44 # 80201b08 <etext+0x5a0>
    80200b3c:	0be00593          	li	a1,190
    80200b40:	00001517          	auipc	a0,0x1
    80200b44:	fe050513          	addi	a0,a0,-32 # 80201b20 <etext+0x5b8>
    80200b48:	db0ff0ef          	jal	ra,802000f8 <__panic>
    80200b4c:	00001697          	auipc	a3,0x1
    80200b50:	02c68693          	addi	a3,a3,44 # 80201b78 <etext+0x610>
    80200b54:	00001617          	auipc	a2,0x1
    80200b58:	fb460613          	addi	a2,a2,-76 # 80201b08 <etext+0x5a0>
    80200b5c:	0bd00593          	li	a1,189
    80200b60:	00001517          	auipc	a0,0x1
    80200b64:	fc050513          	addi	a0,a0,-64 # 80201b20 <etext+0x5b8>
    80200b68:	d90ff0ef          	jal	ra,802000f8 <__panic>
    80200b6c:	00001697          	auipc	a3,0x1
    80200b70:	fec68693          	addi	a3,a3,-20 # 80201b58 <etext+0x5f0>
    80200b74:	00001617          	auipc	a2,0x1
    80200b78:	f9460613          	addi	a2,a2,-108 # 80201b08 <etext+0x5a0>
    80200b7c:	0bc00593          	li	a1,188
    80200b80:	00001517          	auipc	a0,0x1
    80200b84:	fa050513          	addi	a0,a0,-96 # 80201b20 <etext+0x5b8>
    80200b88:	d70ff0ef          	jal	ra,802000f8 <__panic>
    80200b8c:	00001697          	auipc	a3,0x1
    80200b90:	10c68693          	addi	a3,a3,268 # 80201c98 <etext+0x730>
    80200b94:	00001617          	auipc	a2,0x1
    80200b98:	f7460613          	addi	a2,a2,-140 # 80201b08 <etext+0x5a0>
    80200b9c:	0ba00593          	li	a1,186
    80200ba0:	00001517          	auipc	a0,0x1
    80200ba4:	f8050513          	addi	a0,a0,-128 # 80201b20 <etext+0x5b8>
    80200ba8:	d50ff0ef          	jal	ra,802000f8 <__panic>
    80200bac:	00001697          	auipc	a3,0x1
    80200bb0:	0d468693          	addi	a3,a3,212 # 80201c80 <etext+0x718>
    80200bb4:	00001617          	auipc	a2,0x1
    80200bb8:	f5460613          	addi	a2,a2,-172 # 80201b08 <etext+0x5a0>
    80200bbc:	0b500593          	li	a1,181
    80200bc0:	00001517          	auipc	a0,0x1
    80200bc4:	f6050513          	addi	a0,a0,-160 # 80201b20 <etext+0x5b8>
    80200bc8:	d30ff0ef          	jal	ra,802000f8 <__panic>
    80200bcc:	00001697          	auipc	a3,0x1
    80200bd0:	09468693          	addi	a3,a3,148 # 80201c60 <etext+0x6f8>
    80200bd4:	00001617          	auipc	a2,0x1
    80200bd8:	f3460613          	addi	a2,a2,-204 # 80201b08 <etext+0x5a0>
    80200bdc:	0ac00593          	li	a1,172
    80200be0:	00001517          	auipc	a0,0x1
    80200be4:	f4050513          	addi	a0,a0,-192 # 80201b20 <etext+0x5b8>
    80200be8:	d10ff0ef          	jal	ra,802000f8 <__panic>
    80200bec:	00001697          	auipc	a3,0x1
    80200bf0:	05468693          	addi	a3,a3,84 # 80201c40 <etext+0x6d8>
    80200bf4:	00001617          	auipc	a2,0x1
    80200bf8:	f1460613          	addi	a2,a2,-236 # 80201b08 <etext+0x5a0>
    80200bfc:	0ab00593          	li	a1,171
    80200c00:	00001517          	auipc	a0,0x1
    80200c04:	f2050513          	addi	a0,a0,-224 # 80201b20 <etext+0x5b8>
    80200c08:	cf0ff0ef          	jal	ra,802000f8 <__panic>
    80200c0c:	00001697          	auipc	a3,0x1
    80200c10:	1bc68693          	addi	a3,a3,444 # 80201dc8 <etext+0x860>
    80200c14:	00001617          	auipc	a2,0x1
    80200c18:	ef460613          	addi	a2,a2,-268 # 80201b08 <etext+0x5a0>
    80200c1c:	11f00593          	li	a1,287
    80200c20:	00001517          	auipc	a0,0x1
    80200c24:	f0050513          	addi	a0,a0,-256 # 80201b20 <etext+0x5b8>
    80200c28:	cd0ff0ef          	jal	ra,802000f8 <__panic>
    80200c2c:	00001697          	auipc	a3,0x1
    80200c30:	0b468693          	addi	a3,a3,180 # 80201ce0 <etext+0x778>
    80200c34:	00001617          	auipc	a2,0x1
    80200c38:	ed460613          	addi	a2,a2,-300 # 80201b08 <etext+0x5a0>
    80200c3c:	11300593          	li	a1,275
    80200c40:	00001517          	auipc	a0,0x1
    80200c44:	ee050513          	addi	a0,a0,-288 # 80201b20 <etext+0x5b8>
    80200c48:	cb0ff0ef          	jal	ra,802000f8 <__panic>
    80200c4c:	00001697          	auipc	a3,0x1
    80200c50:	03468693          	addi	a3,a3,52 # 80201c80 <etext+0x718>
    80200c54:	00001617          	auipc	a2,0x1
    80200c58:	eb460613          	addi	a2,a2,-332 # 80201b08 <etext+0x5a0>
    80200c5c:	10d00593          	li	a1,269
    80200c60:	00001517          	auipc	a0,0x1
    80200c64:	ec050513          	addi	a0,a0,-320 # 80201b20 <etext+0x5b8>
    80200c68:	c90ff0ef          	jal	ra,802000f8 <__panic>
    80200c6c:	00001697          	auipc	a3,0x1
    80200c70:	13c68693          	addi	a3,a3,316 # 80201da8 <etext+0x840>
    80200c74:	00001617          	auipc	a2,0x1
    80200c78:	e9460613          	addi	a2,a2,-364 # 80201b08 <etext+0x5a0>
    80200c7c:	10c00593          	li	a1,268
    80200c80:	00001517          	auipc	a0,0x1
    80200c84:	ea050513          	addi	a0,a0,-352 # 80201b20 <etext+0x5b8>
    80200c88:	c70ff0ef          	jal	ra,802000f8 <__panic>
    80200c8c:	00001697          	auipc	a3,0x1
    80200c90:	10c68693          	addi	a3,a3,268 # 80201d98 <etext+0x830>
    80200c94:	00001617          	auipc	a2,0x1
    80200c98:	e7460613          	addi	a2,a2,-396 # 80201b08 <etext+0x5a0>
    80200c9c:	10400593          	li	a1,260
    80200ca0:	00001517          	auipc	a0,0x1
    80200ca4:	e8050513          	addi	a0,a0,-384 # 80201b20 <etext+0x5b8>
    80200ca8:	c50ff0ef          	jal	ra,802000f8 <__panic>
    80200cac:	00001697          	auipc	a3,0x1
    80200cb0:	0d468693          	addi	a3,a3,212 # 80201d80 <etext+0x818>
    80200cb4:	00001617          	auipc	a2,0x1
    80200cb8:	e5460613          	addi	a2,a2,-428 # 80201b08 <etext+0x5a0>
    80200cbc:	10300593          	li	a1,259
    80200cc0:	00001517          	auipc	a0,0x1
    80200cc4:	e6050513          	addi	a0,a0,-416 # 80201b20 <etext+0x5b8>
    80200cc8:	c30ff0ef          	jal	ra,802000f8 <__panic>
    80200ccc:	00001697          	auipc	a3,0x1
    80200cd0:	09468693          	addi	a3,a3,148 # 80201d60 <etext+0x7f8>
    80200cd4:	00001617          	auipc	a2,0x1
    80200cd8:	e3460613          	addi	a2,a2,-460 # 80201b08 <etext+0x5a0>
    80200cdc:	10200593          	li	a1,258
    80200ce0:	00001517          	auipc	a0,0x1
    80200ce4:	e4050513          	addi	a0,a0,-448 # 80201b20 <etext+0x5b8>
    80200ce8:	c10ff0ef          	jal	ra,802000f8 <__panic>
    80200cec:	00001697          	auipc	a3,0x1
    80200cf0:	04468693          	addi	a3,a3,68 # 80201d30 <etext+0x7c8>
    80200cf4:	00001617          	auipc	a2,0x1
    80200cf8:	e1460613          	addi	a2,a2,-492 # 80201b08 <etext+0x5a0>
    80200cfc:	10000593          	li	a1,256
    80200d00:	00001517          	auipc	a0,0x1
    80200d04:	e2050513          	addi	a0,a0,-480 # 80201b20 <etext+0x5b8>
    80200d08:	bf0ff0ef          	jal	ra,802000f8 <__panic>
    80200d0c:	00001697          	auipc	a3,0x1
    80200d10:	00c68693          	addi	a3,a3,12 # 80201d18 <etext+0x7b0>
    80200d14:	00001617          	auipc	a2,0x1
    80200d18:	df460613          	addi	a2,a2,-524 # 80201b08 <etext+0x5a0>
    80200d1c:	0ff00593          	li	a1,255
    80200d20:	00001517          	auipc	a0,0x1
    80200d24:	e0050513          	addi	a0,a0,-512 # 80201b20 <etext+0x5b8>
    80200d28:	bd0ff0ef          	jal	ra,802000f8 <__panic>
    80200d2c:	00001697          	auipc	a3,0x1
    80200d30:	f5468693          	addi	a3,a3,-172 # 80201c80 <etext+0x718>
    80200d34:	00001617          	auipc	a2,0x1
    80200d38:	dd460613          	addi	a2,a2,-556 # 80201b08 <etext+0x5a0>
    80200d3c:	0f300593          	li	a1,243
    80200d40:	00001517          	auipc	a0,0x1
    80200d44:	de050513          	addi	a0,a0,-544 # 80201b20 <etext+0x5b8>
    80200d48:	bb0ff0ef          	jal	ra,802000f8 <__panic>
    80200d4c:	00001697          	auipc	a3,0x1
    80200d50:	fb468693          	addi	a3,a3,-76 # 80201d00 <etext+0x798>
    80200d54:	00001617          	auipc	a2,0x1
    80200d58:	db460613          	addi	a2,a2,-588 # 80201b08 <etext+0x5a0>
    80200d5c:	0ea00593          	li	a1,234
    80200d60:	00001517          	auipc	a0,0x1
    80200d64:	dc050513          	addi	a0,a0,-576 # 80201b20 <etext+0x5b8>
    80200d68:	b90ff0ef          	jal	ra,802000f8 <__panic>
    80200d6c:	00001697          	auipc	a3,0x1
    80200d70:	f8468693          	addi	a3,a3,-124 # 80201cf0 <etext+0x788>
    80200d74:	00001617          	auipc	a2,0x1
    80200d78:	d9460613          	addi	a2,a2,-620 # 80201b08 <etext+0x5a0>
    80200d7c:	0e900593          	li	a1,233
    80200d80:	00001517          	auipc	a0,0x1
    80200d84:	da050513          	addi	a0,a0,-608 # 80201b20 <etext+0x5b8>
    80200d88:	b70ff0ef          	jal	ra,802000f8 <__panic>
    80200d8c:	00001697          	auipc	a3,0x1
    80200d90:	f5468693          	addi	a3,a3,-172 # 80201ce0 <etext+0x778>
    80200d94:	00001617          	auipc	a2,0x1
    80200d98:	d7460613          	addi	a2,a2,-652 # 80201b08 <etext+0x5a0>
    80200d9c:	0c900593          	li	a1,201
    80200da0:	00001517          	auipc	a0,0x1
    80200da4:	d8050513          	addi	a0,a0,-640 # 80201b20 <etext+0x5b8>
    80200da8:	b50ff0ef          	jal	ra,802000f8 <__panic>
    80200dac:	00001697          	auipc	a3,0x1
    80200db0:	ed468693          	addi	a3,a3,-300 # 80201c80 <etext+0x718>
    80200db4:	00001617          	auipc	a2,0x1
    80200db8:	d5460613          	addi	a2,a2,-684 # 80201b08 <etext+0x5a0>
    80200dbc:	0c700593          	li	a1,199
    80200dc0:	00001517          	auipc	a0,0x1
    80200dc4:	d6050513          	addi	a0,a0,-672 # 80201b20 <etext+0x5b8>
    80200dc8:	b30ff0ef          	jal	ra,802000f8 <__panic>
    80200dcc:	00001697          	auipc	a3,0x1
    80200dd0:	ef468693          	addi	a3,a3,-268 # 80201cc0 <etext+0x758>
    80200dd4:	00001617          	auipc	a2,0x1
    80200dd8:	d3460613          	addi	a2,a2,-716 # 80201b08 <etext+0x5a0>
    80200ddc:	0c600593          	li	a1,198
    80200de0:	00001517          	auipc	a0,0x1
    80200de4:	d4050513          	addi	a0,a0,-704 # 80201b20 <etext+0x5b8>
    80200de8:	b10ff0ef          	jal	ra,802000f8 <__panic>

0000000080200dec <best_fit_free_pages>:
    80200dec:	1141                	addi	sp,sp,-16
    80200dee:	e406                	sd	ra,8(sp)
    80200df0:	14058c63          	beqz	a1,80200f48 <best_fit_free_pages+0x15c>
    80200df4:	00259693          	slli	a3,a1,0x2
    80200df8:	96ae                	add	a3,a3,a1
    80200dfa:	068e                	slli	a3,a3,0x3
    80200dfc:	96aa                	add	a3,a3,a0
    80200dfe:	87aa                	mv	a5,a0
    80200e00:	02d50263          	beq	a0,a3,80200e24 <best_fit_free_pages+0x38>
    80200e04:	6798                	ld	a4,8(a5)
    80200e06:	8b05                	andi	a4,a4,1
    80200e08:	12071063          	bnez	a4,80200f28 <best_fit_free_pages+0x13c>
    80200e0c:	6798                	ld	a4,8(a5)
    80200e0e:	8b09                	andi	a4,a4,2
    80200e10:	10071c63          	bnez	a4,80200f28 <best_fit_free_pages+0x13c>
    80200e14:	0007b423          	sd	zero,8(a5)
    80200e18:	0007a023          	sw	zero,0(a5)
    80200e1c:	02878793          	addi	a5,a5,40
    80200e20:	fed792e3          	bne	a5,a3,80200e04 <best_fit_free_pages+0x18>
    80200e24:	2581                	sext.w	a1,a1
    80200e26:	c90c                	sw	a1,16(a0)
    80200e28:	00850313          	addi	t1,a0,8
    80200e2c:	4789                	li	a5,2
    80200e2e:	40f3302f          	amoor.d	zero,a5,(t1)
    80200e32:	00004697          	auipc	a3,0x4
    80200e36:	21668693          	addi	a3,a3,534 # 80205048 <free_area>
    80200e3a:	4a98                	lw	a4,16(a3)
    80200e3c:	669c                	ld	a5,8(a3)
    80200e3e:	01850613          	addi	a2,a0,24
    80200e42:	9db9                	addw	a1,a1,a4
    80200e44:	ca8c                	sw	a1,16(a3)
    80200e46:	0ad78863          	beq	a5,a3,80200ef6 <best_fit_free_pages+0x10a>
    80200e4a:	fe878713          	addi	a4,a5,-24
    80200e4e:	0006b803          	ld	a6,0(a3)
    80200e52:	4581                	li	a1,0
    80200e54:	00e56a63          	bltu	a0,a4,80200e68 <best_fit_free_pages+0x7c>
    80200e58:	6798                	ld	a4,8(a5)
    80200e5a:	06d70163          	beq	a4,a3,80200ebc <best_fit_free_pages+0xd0>
    80200e5e:	87ba                	mv	a5,a4
    80200e60:	fe878713          	addi	a4,a5,-24
    80200e64:	fee57ae3          	bgeu	a0,a4,80200e58 <best_fit_free_pages+0x6c>
    80200e68:	c199                	beqz	a1,80200e6e <best_fit_free_pages+0x82>
    80200e6a:	0106b023          	sd	a6,0(a3)
    80200e6e:	638c                	ld	a1,0(a5)
    80200e70:	e390                	sd	a2,0(a5)
    80200e72:	e590                	sd	a2,8(a1)
    80200e74:	f11c                	sd	a5,32(a0)
    80200e76:	ed0c                	sd	a1,24(a0)
    80200e78:	02d58463          	beq	a1,a3,80200ea0 <best_fit_free_pages+0xb4>
    80200e7c:	ff85a883          	lw	a7,-8(a1)
    80200e80:	fe858813          	addi	a6,a1,-24
    80200e84:	02089613          	slli	a2,a7,0x20
    80200e88:	9201                	srli	a2,a2,0x20
    80200e8a:	00261713          	slli	a4,a2,0x2
    80200e8e:	9732                	add	a4,a4,a2
    80200e90:	070e                	slli	a4,a4,0x3
    80200e92:	9742                	add	a4,a4,a6
    80200e94:	02e50e63          	beq	a0,a4,80200ed0 <best_fit_free_pages+0xe4>
    80200e98:	00d78f63          	beq	a5,a3,80200eb6 <best_fit_free_pages+0xca>
    80200e9c:	fe878713          	addi	a4,a5,-24
    80200ea0:	490c                	lw	a1,16(a0)
    80200ea2:	02059613          	slli	a2,a1,0x20
    80200ea6:	9201                	srli	a2,a2,0x20
    80200ea8:	00261693          	slli	a3,a2,0x2
    80200eac:	96b2                	add	a3,a3,a2
    80200eae:	068e                	slli	a3,a3,0x3
    80200eb0:	96aa                	add	a3,a3,a0
    80200eb2:	04d70963          	beq	a4,a3,80200f04 <best_fit_free_pages+0x118>
    80200eb6:	60a2                	ld	ra,8(sp)
    80200eb8:	0141                	addi	sp,sp,16
    80200eba:	8082                	ret
    80200ebc:	e790                	sd	a2,8(a5)
    80200ebe:	f114                	sd	a3,32(a0)
    80200ec0:	6798                	ld	a4,8(a5)
    80200ec2:	ed1c                	sd	a5,24(a0)
    80200ec4:	02d70563          	beq	a4,a3,80200eee <best_fit_free_pages+0x102>
    80200ec8:	8832                	mv	a6,a2
    80200eca:	4585                	li	a1,1
    80200ecc:	87ba                	mv	a5,a4
    80200ece:	bf49                	j	80200e60 <best_fit_free_pages+0x74>
    80200ed0:	4918                	lw	a4,16(a0)
    80200ed2:	011708bb          	addw	a7,a4,a7
    80200ed6:	ff15ac23          	sw	a7,-8(a1)
    80200eda:	00052823          	sw	zero,16(a0)
    80200ede:	e59c                	sd	a5,8(a1)
    80200ee0:	e38c                	sd	a1,0(a5)
    80200ee2:	57f5                	li	a5,-3
    80200ee4:	60f3302f          	amoand.d	zero,a5,(t1)
    80200ee8:	659c                	ld	a5,8(a1)
    80200eea:	8542                	mv	a0,a6
    80200eec:	b775                	j	80200e98 <best_fit_free_pages+0xac>
    80200eee:	85be                	mv	a1,a5
    80200ef0:	e290                	sd	a2,0(a3)
    80200ef2:	87b6                	mv	a5,a3
    80200ef4:	b761                	j	80200e7c <best_fit_free_pages+0x90>
    80200ef6:	60a2                	ld	ra,8(sp)
    80200ef8:	e390                	sd	a2,0(a5)
    80200efa:	e790                	sd	a2,8(a5)
    80200efc:	f11c                	sd	a5,32(a0)
    80200efe:	ed1c                	sd	a5,24(a0)
    80200f00:	0141                	addi	sp,sp,16
    80200f02:	8082                	ret
    80200f04:	ff87a703          	lw	a4,-8(a5)
    80200f08:	6794                	ld	a3,8(a5)
    80200f0a:	01850613          	addi	a2,a0,24
    80200f0e:	9db9                	addw	a1,a1,a4
    80200f10:	c90c                	sw	a1,16(a0)
    80200f12:	fe07ac23          	sw	zero,-8(a5)
    80200f16:	f114                	sd	a3,32(a0)
    80200f18:	e290                	sd	a2,0(a3)
    80200f1a:	5775                	li	a4,-3
    80200f1c:	17c1                	addi	a5,a5,-16
    80200f1e:	60e7b02f          	amoand.d	zero,a4,(a5)
    80200f22:	60a2                	ld	ra,8(sp)
    80200f24:	0141                	addi	sp,sp,16
    80200f26:	8082                	ret
    80200f28:	00001697          	auipc	a3,0x1
    80200f2c:	ec868693          	addi	a3,a3,-312 # 80201df0 <etext+0x888>
    80200f30:	00001617          	auipc	a2,0x1
    80200f34:	bd860613          	addi	a2,a2,-1064 # 80201b08 <etext+0x5a0>
    80200f38:	05800593          	li	a1,88
    80200f3c:	00001517          	auipc	a0,0x1
    80200f40:	be450513          	addi	a0,a0,-1052 # 80201b20 <etext+0x5b8>
    80200f44:	9b4ff0ef          	jal	ra,802000f8 <__panic>
    80200f48:	00001697          	auipc	a3,0x1
    80200f4c:	ea068693          	addi	a3,a3,-352 # 80201de8 <etext+0x880>
    80200f50:	00001617          	auipc	a2,0x1
    80200f54:	bb860613          	addi	a2,a2,-1096 # 80201b08 <etext+0x5a0>
    80200f58:	05500593          	li	a1,85
    80200f5c:	00001517          	auipc	a0,0x1
    80200f60:	bc450513          	addi	a0,a0,-1084 # 80201b20 <etext+0x5b8>
    80200f64:	994ff0ef          	jal	ra,802000f8 <__panic>

0000000080200f68 <best_fit_alloc_pages>:
    80200f68:	cd51                	beqz	a0,80201004 <best_fit_alloc_pages+0x9c>
    80200f6a:	00004617          	auipc	a2,0x4
    80200f6e:	0de60613          	addi	a2,a2,222 # 80205048 <free_area>
    80200f72:	01062803          	lw	a6,16(a2)
    80200f76:	86aa                	mv	a3,a0
    80200f78:	02081793          	slli	a5,a6,0x20
    80200f7c:	9381                	srli	a5,a5,0x20
    80200f7e:	08a7e163          	bltu	a5,a0,80201000 <best_fit_alloc_pages+0x98>
    80200f82:	661c                	ld	a5,8(a2)
    80200f84:	4501                	li	a0,0
    80200f86:	06c78c63          	beq	a5,a2,80200ffe <best_fit_alloc_pages+0x96>
    80200f8a:	55fd                	li	a1,-1
    80200f8c:	ff87e703          	lwu	a4,-8(a5)
    80200f90:	00d76763          	bltu	a4,a3,80200f9e <best_fit_alloc_pages+0x36>
    80200f94:	00b77563          	bgeu	a4,a1,80200f9e <best_fit_alloc_pages+0x36>
    80200f98:	fe878513          	addi	a0,a5,-24
    80200f9c:	85ba                	mv	a1,a4
    80200f9e:	679c                	ld	a5,8(a5)
    80200fa0:	fec796e3          	bne	a5,a2,80200f8c <best_fit_alloc_pages+0x24>
    80200fa4:	cd29                	beqz	a0,80200ffe <best_fit_alloc_pages+0x96>
    80200fa6:	711c                	ld	a5,32(a0)
    80200fa8:	6d18                	ld	a4,24(a0)
    80200faa:	490c                	lw	a1,16(a0)
    80200fac:	0006889b          	sext.w	a7,a3
    80200fb0:	e71c                	sd	a5,8(a4)
    80200fb2:	e398                	sd	a4,0(a5)
    80200fb4:	02059793          	slli	a5,a1,0x20
    80200fb8:	9381                	srli	a5,a5,0x20
    80200fba:	02f6f863          	bgeu	a3,a5,80200fea <best_fit_alloc_pages+0x82>
    80200fbe:	00269793          	slli	a5,a3,0x2
    80200fc2:	97b6                	add	a5,a5,a3
    80200fc4:	078e                	slli	a5,a5,0x3
    80200fc6:	97aa                	add	a5,a5,a0
    80200fc8:	411585bb          	subw	a1,a1,a7
    80200fcc:	cb8c                	sw	a1,16(a5)
    80200fce:	4689                	li	a3,2
    80200fd0:	00878593          	addi	a1,a5,8
    80200fd4:	40d5b02f          	amoor.d	zero,a3,(a1)
    80200fd8:	6714                	ld	a3,8(a4)
    80200fda:	01878593          	addi	a1,a5,24
    80200fde:	01062803          	lw	a6,16(a2)
    80200fe2:	e28c                	sd	a1,0(a3)
    80200fe4:	e70c                	sd	a1,8(a4)
    80200fe6:	f394                	sd	a3,32(a5)
    80200fe8:	ef98                	sd	a4,24(a5)
    80200fea:	4118083b          	subw	a6,a6,a7
    80200fee:	01062823          	sw	a6,16(a2)
    80200ff2:	57f5                	li	a5,-3
    80200ff4:	00850713          	addi	a4,a0,8
    80200ff8:	60f7302f          	amoand.d	zero,a5,(a4)
    80200ffc:	8082                	ret
    80200ffe:	8082                	ret
    80201000:	4501                	li	a0,0
    80201002:	8082                	ret
    80201004:	1141                	addi	sp,sp,-16
    80201006:	00001697          	auipc	a3,0x1
    8020100a:	de268693          	addi	a3,a3,-542 # 80201de8 <etext+0x880>
    8020100e:	00001617          	auipc	a2,0x1
    80201012:	afa60613          	addi	a2,a2,-1286 # 80201b08 <etext+0x5a0>
    80201016:	03300593          	li	a1,51
    8020101a:	00001517          	auipc	a0,0x1
    8020101e:	b0650513          	addi	a0,a0,-1274 # 80201b20 <etext+0x5b8>
    80201022:	e406                	sd	ra,8(sp)
    80201024:	8d4ff0ef          	jal	ra,802000f8 <__panic>

0000000080201028 <best_fit_init_memmap>:
    80201028:	1141                	addi	sp,sp,-16
    8020102a:	e406                	sd	ra,8(sp)
    8020102c:	c5f9                	beqz	a1,802010fa <best_fit_init_memmap+0xd2>
    8020102e:	00259693          	slli	a3,a1,0x2
    80201032:	96ae                	add	a3,a3,a1
    80201034:	068e                	slli	a3,a3,0x3
    80201036:	96aa                	add	a3,a3,a0
    80201038:	87aa                	mv	a5,a0
    8020103a:	00d50f63          	beq	a0,a3,80201058 <best_fit_init_memmap+0x30>
    8020103e:	6798                	ld	a4,8(a5)
    80201040:	8b05                	andi	a4,a4,1
    80201042:	cf49                	beqz	a4,802010dc <best_fit_init_memmap+0xb4>
    80201044:	0007a823          	sw	zero,16(a5)
    80201048:	0007b423          	sd	zero,8(a5)
    8020104c:	0007a023          	sw	zero,0(a5)
    80201050:	02878793          	addi	a5,a5,40
    80201054:	fed795e3          	bne	a5,a3,8020103e <best_fit_init_memmap+0x16>
    80201058:	2581                	sext.w	a1,a1
    8020105a:	c90c                	sw	a1,16(a0)
    8020105c:	4789                	li	a5,2
    8020105e:	00850713          	addi	a4,a0,8
    80201062:	40f7302f          	amoor.d	zero,a5,(a4)
    80201066:	00004697          	auipc	a3,0x4
    8020106a:	fe268693          	addi	a3,a3,-30 # 80205048 <free_area>
    8020106e:	4a98                	lw	a4,16(a3)
    80201070:	669c                	ld	a5,8(a3)
    80201072:	01850613          	addi	a2,a0,24
    80201076:	9db9                	addw	a1,a1,a4
    80201078:	ca8c                	sw	a1,16(a3)
    8020107a:	04d78a63          	beq	a5,a3,802010ce <best_fit_init_memmap+0xa6>
    8020107e:	fe878713          	addi	a4,a5,-24
    80201082:	0006b803          	ld	a6,0(a3)
    80201086:	4581                	li	a1,0
    80201088:	00e56a63          	bltu	a0,a4,8020109c <best_fit_init_memmap+0x74>
    8020108c:	6798                	ld	a4,8(a5)
    8020108e:	02d70263          	beq	a4,a3,802010b2 <best_fit_init_memmap+0x8a>
    80201092:	87ba                	mv	a5,a4
    80201094:	fe878713          	addi	a4,a5,-24
    80201098:	fee57ae3          	bgeu	a0,a4,8020108c <best_fit_init_memmap+0x64>
    8020109c:	c199                	beqz	a1,802010a2 <best_fit_init_memmap+0x7a>
    8020109e:	0106b023          	sd	a6,0(a3)
    802010a2:	6398                	ld	a4,0(a5)
    802010a4:	60a2                	ld	ra,8(sp)
    802010a6:	e390                	sd	a2,0(a5)
    802010a8:	e710                	sd	a2,8(a4)
    802010aa:	f11c                	sd	a5,32(a0)
    802010ac:	ed18                	sd	a4,24(a0)
    802010ae:	0141                	addi	sp,sp,16
    802010b0:	8082                	ret
    802010b2:	e790                	sd	a2,8(a5)
    802010b4:	f114                	sd	a3,32(a0)
    802010b6:	6798                	ld	a4,8(a5)
    802010b8:	ed1c                	sd	a5,24(a0)
    802010ba:	00d70663          	beq	a4,a3,802010c6 <best_fit_init_memmap+0x9e>
    802010be:	8832                	mv	a6,a2
    802010c0:	4585                	li	a1,1
    802010c2:	87ba                	mv	a5,a4
    802010c4:	bfc1                	j	80201094 <best_fit_init_memmap+0x6c>
    802010c6:	60a2                	ld	ra,8(sp)
    802010c8:	e290                	sd	a2,0(a3)
    802010ca:	0141                	addi	sp,sp,16
    802010cc:	8082                	ret
    802010ce:	60a2                	ld	ra,8(sp)
    802010d0:	e390                	sd	a2,0(a5)
    802010d2:	e790                	sd	a2,8(a5)
    802010d4:	f11c                	sd	a5,32(a0)
    802010d6:	ed1c                	sd	a5,24(a0)
    802010d8:	0141                	addi	sp,sp,16
    802010da:	8082                	ret
    802010dc:	00001697          	auipc	a3,0x1
    802010e0:	d3c68693          	addi	a3,a3,-708 # 80201e18 <etext+0x8b0>
    802010e4:	00001617          	auipc	a2,0x1
    802010e8:	a2460613          	addi	a2,a2,-1500 # 80201b08 <etext+0x5a0>
    802010ec:	45e5                	li	a1,25
    802010ee:	00001517          	auipc	a0,0x1
    802010f2:	a3250513          	addi	a0,a0,-1486 # 80201b20 <etext+0x5b8>
    802010f6:	802ff0ef          	jal	ra,802000f8 <__panic>
    802010fa:	00001697          	auipc	a3,0x1
    802010fe:	cee68693          	addi	a3,a3,-786 # 80201de8 <etext+0x880>
    80201102:	00001617          	auipc	a2,0x1
    80201106:	a0660613          	addi	a2,a2,-1530 # 80201b08 <etext+0x5a0>
    8020110a:	45d9                	li	a1,22
    8020110c:	00001517          	auipc	a0,0x1
    80201110:	a1450513          	addi	a0,a0,-1516 # 80201b20 <etext+0x5b8>
    80201114:	fe5fe0ef          	jal	ra,802000f8 <__panic>

0000000080201118 <strnlen>:
    80201118:	872a                	mv	a4,a0
    8020111a:	4501                	li	a0,0
    8020111c:	e589                	bnez	a1,80201126 <strnlen+0xe>
    8020111e:	a811                	j	80201132 <strnlen+0x1a>
    80201120:	0505                	addi	a0,a0,1
    80201122:	00a58763          	beq	a1,a0,80201130 <strnlen+0x18>
    80201126:	00a707b3          	add	a5,a4,a0
    8020112a:	0007c783          	lbu	a5,0(a5)
    8020112e:	fbed                	bnez	a5,80201120 <strnlen+0x8>
    80201130:	8082                	ret
    80201132:	8082                	ret

0000000080201134 <memset>:
    80201134:	ca01                	beqz	a2,80201144 <memset+0x10>
    80201136:	962a                	add	a2,a2,a0
    80201138:	87aa                	mv	a5,a0
    8020113a:	0785                	addi	a5,a5,1
    8020113c:	feb78fa3          	sb	a1,-1(a5)
    80201140:	fec79de3          	bne	a5,a2,8020113a <memset+0x6>
    80201144:	8082                	ret

0000000080201146 <printnum>:
    80201146:	02069813          	slli	a6,a3,0x20
    8020114a:	7179                	addi	sp,sp,-48
    8020114c:	02085813          	srli	a6,a6,0x20
    80201150:	e052                	sd	s4,0(sp)
    80201152:	03067a33          	remu	s4,a2,a6
    80201156:	f022                	sd	s0,32(sp)
    80201158:	ec26                	sd	s1,24(sp)
    8020115a:	e84a                	sd	s2,16(sp)
    8020115c:	f406                	sd	ra,40(sp)
    8020115e:	e44e                	sd	s3,8(sp)
    80201160:	84aa                	mv	s1,a0
    80201162:	892e                	mv	s2,a1
    80201164:	fff7041b          	addiw	s0,a4,-1
    80201168:	2a01                	sext.w	s4,s4
    8020116a:	03067e63          	bgeu	a2,a6,802011a6 <printnum+0x60>
    8020116e:	89be                	mv	s3,a5
    80201170:	00805763          	blez	s0,8020117e <printnum+0x38>
    80201174:	347d                	addiw	s0,s0,-1
    80201176:	85ca                	mv	a1,s2
    80201178:	854e                	mv	a0,s3
    8020117a:	9482                	jalr	s1
    8020117c:	fc65                	bnez	s0,80201174 <printnum+0x2e>
    8020117e:	1a02                	slli	s4,s4,0x20
    80201180:	020a5a13          	srli	s4,s4,0x20
    80201184:	00001797          	auipc	a5,0x1
    80201188:	cf478793          	addi	a5,a5,-780 # 80201e78 <best_fit_pmm_manager+0x38>
    8020118c:	7402                	ld	s0,32(sp)
    8020118e:	9a3e                	add	s4,s4,a5
    80201190:	000a4503          	lbu	a0,0(s4)
    80201194:	70a2                	ld	ra,40(sp)
    80201196:	69a2                	ld	s3,8(sp)
    80201198:	6a02                	ld	s4,0(sp)
    8020119a:	85ca                	mv	a1,s2
    8020119c:	8326                	mv	t1,s1
    8020119e:	6942                	ld	s2,16(sp)
    802011a0:	64e2                	ld	s1,24(sp)
    802011a2:	6145                	addi	sp,sp,48
    802011a4:	8302                	jr	t1
    802011a6:	03065633          	divu	a2,a2,a6
    802011aa:	8722                	mv	a4,s0
    802011ac:	f9bff0ef          	jal	ra,80201146 <printnum>
    802011b0:	b7f9                	j	8020117e <printnum+0x38>

00000000802011b2 <vprintfmt>:
    802011b2:	7119                	addi	sp,sp,-128
    802011b4:	f4a6                	sd	s1,104(sp)
    802011b6:	f0ca                	sd	s2,96(sp)
    802011b8:	ecce                	sd	s3,88(sp)
    802011ba:	e8d2                	sd	s4,80(sp)
    802011bc:	e4d6                	sd	s5,72(sp)
    802011be:	e0da                	sd	s6,64(sp)
    802011c0:	fc5e                	sd	s7,56(sp)
    802011c2:	f06a                	sd	s10,32(sp)
    802011c4:	fc86                	sd	ra,120(sp)
    802011c6:	f8a2                	sd	s0,112(sp)
    802011c8:	f862                	sd	s8,48(sp)
    802011ca:	f466                	sd	s9,40(sp)
    802011cc:	ec6e                	sd	s11,24(sp)
    802011ce:	892a                	mv	s2,a0
    802011d0:	84ae                	mv	s1,a1
    802011d2:	8d32                	mv	s10,a2
    802011d4:	8a36                	mv	s4,a3
    802011d6:	02500993          	li	s3,37
    802011da:	5b7d                	li	s6,-1
    802011dc:	00001a97          	auipc	s5,0x1
    802011e0:	cd0a8a93          	addi	s5,s5,-816 # 80201eac <best_fit_pmm_manager+0x6c>
    802011e4:	00001b97          	auipc	s7,0x1
    802011e8:	ea4b8b93          	addi	s7,s7,-348 # 80202088 <error_string>
    802011ec:	000d4503          	lbu	a0,0(s10)
    802011f0:	001d0413          	addi	s0,s10,1
    802011f4:	01350a63          	beq	a0,s3,80201208 <vprintfmt+0x56>
    802011f8:	c121                	beqz	a0,80201238 <vprintfmt+0x86>
    802011fa:	85a6                	mv	a1,s1
    802011fc:	0405                	addi	s0,s0,1
    802011fe:	9902                	jalr	s2
    80201200:	fff44503          	lbu	a0,-1(s0)
    80201204:	ff351ae3          	bne	a0,s3,802011f8 <vprintfmt+0x46>
    80201208:	00044603          	lbu	a2,0(s0)
    8020120c:	02000793          	li	a5,32
    80201210:	4c81                	li	s9,0
    80201212:	4881                	li	a7,0
    80201214:	5c7d                	li	s8,-1
    80201216:	5dfd                	li	s11,-1
    80201218:	05500513          	li	a0,85
    8020121c:	4825                	li	a6,9
    8020121e:	fdd6059b          	addiw	a1,a2,-35
    80201222:	0ff5f593          	andi	a1,a1,255
    80201226:	00140d13          	addi	s10,s0,1
    8020122a:	04b56263          	bltu	a0,a1,8020126e <vprintfmt+0xbc>
    8020122e:	058a                	slli	a1,a1,0x2
    80201230:	95d6                	add	a1,a1,s5
    80201232:	4194                	lw	a3,0(a1)
    80201234:	96d6                	add	a3,a3,s5
    80201236:	8682                	jr	a3
    80201238:	70e6                	ld	ra,120(sp)
    8020123a:	7446                	ld	s0,112(sp)
    8020123c:	74a6                	ld	s1,104(sp)
    8020123e:	7906                	ld	s2,96(sp)
    80201240:	69e6                	ld	s3,88(sp)
    80201242:	6a46                	ld	s4,80(sp)
    80201244:	6aa6                	ld	s5,72(sp)
    80201246:	6b06                	ld	s6,64(sp)
    80201248:	7be2                	ld	s7,56(sp)
    8020124a:	7c42                	ld	s8,48(sp)
    8020124c:	7ca2                	ld	s9,40(sp)
    8020124e:	7d02                	ld	s10,32(sp)
    80201250:	6de2                	ld	s11,24(sp)
    80201252:	6109                	addi	sp,sp,128
    80201254:	8082                	ret
    80201256:	87b2                	mv	a5,a2
    80201258:	00144603          	lbu	a2,1(s0)
    8020125c:	846a                	mv	s0,s10
    8020125e:	00140d13          	addi	s10,s0,1
    80201262:	fdd6059b          	addiw	a1,a2,-35
    80201266:	0ff5f593          	andi	a1,a1,255
    8020126a:	fcb572e3          	bgeu	a0,a1,8020122e <vprintfmt+0x7c>
    8020126e:	85a6                	mv	a1,s1
    80201270:	02500513          	li	a0,37
    80201274:	9902                	jalr	s2
    80201276:	fff44783          	lbu	a5,-1(s0)
    8020127a:	8d22                	mv	s10,s0
    8020127c:	f73788e3          	beq	a5,s3,802011ec <vprintfmt+0x3a>
    80201280:	ffed4783          	lbu	a5,-2(s10)
    80201284:	1d7d                	addi	s10,s10,-1
    80201286:	ff379de3          	bne	a5,s3,80201280 <vprintfmt+0xce>
    8020128a:	b78d                	j	802011ec <vprintfmt+0x3a>
    8020128c:	fd060c1b          	addiw	s8,a2,-48
    80201290:	00144603          	lbu	a2,1(s0)
    80201294:	846a                	mv	s0,s10
    80201296:	fd06069b          	addiw	a3,a2,-48
    8020129a:	0006059b          	sext.w	a1,a2
    8020129e:	02d86463          	bltu	a6,a3,802012c6 <vprintfmt+0x114>
    802012a2:	00144603          	lbu	a2,1(s0)
    802012a6:	002c169b          	slliw	a3,s8,0x2
    802012aa:	0186873b          	addw	a4,a3,s8
    802012ae:	0017171b          	slliw	a4,a4,0x1
    802012b2:	9f2d                	addw	a4,a4,a1
    802012b4:	fd06069b          	addiw	a3,a2,-48
    802012b8:	0405                	addi	s0,s0,1
    802012ba:	fd070c1b          	addiw	s8,a4,-48
    802012be:	0006059b          	sext.w	a1,a2
    802012c2:	fed870e3          	bgeu	a6,a3,802012a2 <vprintfmt+0xf0>
    802012c6:	f40ddce3          	bgez	s11,8020121e <vprintfmt+0x6c>
    802012ca:	8de2                	mv	s11,s8
    802012cc:	5c7d                	li	s8,-1
    802012ce:	bf81                	j	8020121e <vprintfmt+0x6c>
    802012d0:	fffdc693          	not	a3,s11
    802012d4:	96fd                	srai	a3,a3,0x3f
    802012d6:	00ddfdb3          	and	s11,s11,a3
    802012da:	00144603          	lbu	a2,1(s0)
    802012de:	2d81                	sext.w	s11,s11
    802012e0:	846a                	mv	s0,s10
    802012e2:	bf35                	j	8020121e <vprintfmt+0x6c>
    802012e4:	000a2c03          	lw	s8,0(s4)
    802012e8:	00144603          	lbu	a2,1(s0)
    802012ec:	0a21                	addi	s4,s4,8
    802012ee:	846a                	mv	s0,s10
    802012f0:	bfd9                	j	802012c6 <vprintfmt+0x114>
    802012f2:	4705                	li	a4,1
    802012f4:	008a0593          	addi	a1,s4,8
    802012f8:	01174463          	blt	a4,a7,80201300 <vprintfmt+0x14e>
    802012fc:	1a088e63          	beqz	a7,802014b8 <vprintfmt+0x306>
    80201300:	000a3603          	ld	a2,0(s4)
    80201304:	46c1                	li	a3,16
    80201306:	8a2e                	mv	s4,a1
    80201308:	2781                	sext.w	a5,a5
    8020130a:	876e                	mv	a4,s11
    8020130c:	85a6                	mv	a1,s1
    8020130e:	854a                	mv	a0,s2
    80201310:	e37ff0ef          	jal	ra,80201146 <printnum>
    80201314:	bde1                	j	802011ec <vprintfmt+0x3a>
    80201316:	000a2503          	lw	a0,0(s4)
    8020131a:	85a6                	mv	a1,s1
    8020131c:	0a21                	addi	s4,s4,8
    8020131e:	9902                	jalr	s2
    80201320:	b5f1                	j	802011ec <vprintfmt+0x3a>
    80201322:	4705                	li	a4,1
    80201324:	008a0593          	addi	a1,s4,8
    80201328:	01174463          	blt	a4,a7,80201330 <vprintfmt+0x17e>
    8020132c:	18088163          	beqz	a7,802014ae <vprintfmt+0x2fc>
    80201330:	000a3603          	ld	a2,0(s4)
    80201334:	46a9                	li	a3,10
    80201336:	8a2e                	mv	s4,a1
    80201338:	bfc1                	j	80201308 <vprintfmt+0x156>
    8020133a:	00144603          	lbu	a2,1(s0)
    8020133e:	4c85                	li	s9,1
    80201340:	846a                	mv	s0,s10
    80201342:	bdf1                	j	8020121e <vprintfmt+0x6c>
    80201344:	85a6                	mv	a1,s1
    80201346:	02500513          	li	a0,37
    8020134a:	9902                	jalr	s2
    8020134c:	b545                	j	802011ec <vprintfmt+0x3a>
    8020134e:	00144603          	lbu	a2,1(s0)
    80201352:	2885                	addiw	a7,a7,1
    80201354:	846a                	mv	s0,s10
    80201356:	b5e1                	j	8020121e <vprintfmt+0x6c>
    80201358:	4705                	li	a4,1
    8020135a:	008a0593          	addi	a1,s4,8
    8020135e:	01174463          	blt	a4,a7,80201366 <vprintfmt+0x1b4>
    80201362:	14088163          	beqz	a7,802014a4 <vprintfmt+0x2f2>
    80201366:	000a3603          	ld	a2,0(s4)
    8020136a:	46a1                	li	a3,8
    8020136c:	8a2e                	mv	s4,a1
    8020136e:	bf69                	j	80201308 <vprintfmt+0x156>
    80201370:	03000513          	li	a0,48
    80201374:	85a6                	mv	a1,s1
    80201376:	e03e                	sd	a5,0(sp)
    80201378:	9902                	jalr	s2
    8020137a:	85a6                	mv	a1,s1
    8020137c:	07800513          	li	a0,120
    80201380:	9902                	jalr	s2
    80201382:	0a21                	addi	s4,s4,8
    80201384:	6782                	ld	a5,0(sp)
    80201386:	46c1                	li	a3,16
    80201388:	ff8a3603          	ld	a2,-8(s4)
    8020138c:	bfb5                	j	80201308 <vprintfmt+0x156>
    8020138e:	000a3403          	ld	s0,0(s4)
    80201392:	008a0713          	addi	a4,s4,8
    80201396:	e03a                	sd	a4,0(sp)
    80201398:	14040263          	beqz	s0,802014dc <vprintfmt+0x32a>
    8020139c:	0fb05763          	blez	s11,8020148a <vprintfmt+0x2d8>
    802013a0:	02d00693          	li	a3,45
    802013a4:	0cd79163          	bne	a5,a3,80201466 <vprintfmt+0x2b4>
    802013a8:	00044783          	lbu	a5,0(s0)
    802013ac:	0007851b          	sext.w	a0,a5
    802013b0:	cf85                	beqz	a5,802013e8 <vprintfmt+0x236>
    802013b2:	00140a13          	addi	s4,s0,1
    802013b6:	05e00413          	li	s0,94
    802013ba:	000c4563          	bltz	s8,802013c4 <vprintfmt+0x212>
    802013be:	3c7d                	addiw	s8,s8,-1
    802013c0:	036c0263          	beq	s8,s6,802013e4 <vprintfmt+0x232>
    802013c4:	85a6                	mv	a1,s1
    802013c6:	0e0c8e63          	beqz	s9,802014c2 <vprintfmt+0x310>
    802013ca:	3781                	addiw	a5,a5,-32
    802013cc:	0ef47b63          	bgeu	s0,a5,802014c2 <vprintfmt+0x310>
    802013d0:	03f00513          	li	a0,63
    802013d4:	9902                	jalr	s2
    802013d6:	000a4783          	lbu	a5,0(s4)
    802013da:	3dfd                	addiw	s11,s11,-1
    802013dc:	0a05                	addi	s4,s4,1
    802013de:	0007851b          	sext.w	a0,a5
    802013e2:	ffe1                	bnez	a5,802013ba <vprintfmt+0x208>
    802013e4:	01b05963          	blez	s11,802013f6 <vprintfmt+0x244>
    802013e8:	3dfd                	addiw	s11,s11,-1
    802013ea:	85a6                	mv	a1,s1
    802013ec:	02000513          	li	a0,32
    802013f0:	9902                	jalr	s2
    802013f2:	fe0d9be3          	bnez	s11,802013e8 <vprintfmt+0x236>
    802013f6:	6a02                	ld	s4,0(sp)
    802013f8:	bbd5                	j	802011ec <vprintfmt+0x3a>
    802013fa:	4705                	li	a4,1
    802013fc:	008a0c93          	addi	s9,s4,8
    80201400:	01174463          	blt	a4,a7,80201408 <vprintfmt+0x256>
    80201404:	08088d63          	beqz	a7,8020149e <vprintfmt+0x2ec>
    80201408:	000a3403          	ld	s0,0(s4)
    8020140c:	0a044d63          	bltz	s0,802014c6 <vprintfmt+0x314>
    80201410:	8622                	mv	a2,s0
    80201412:	8a66                	mv	s4,s9
    80201414:	46a9                	li	a3,10
    80201416:	bdcd                	j	80201308 <vprintfmt+0x156>
    80201418:	000a2783          	lw	a5,0(s4)
    8020141c:	4719                	li	a4,6
    8020141e:	0a21                	addi	s4,s4,8
    80201420:	41f7d69b          	sraiw	a3,a5,0x1f
    80201424:	8fb5                	xor	a5,a5,a3
    80201426:	40d786bb          	subw	a3,a5,a3
    8020142a:	02d74163          	blt	a4,a3,8020144c <vprintfmt+0x29a>
    8020142e:	00369793          	slli	a5,a3,0x3
    80201432:	97de                	add	a5,a5,s7
    80201434:	639c                	ld	a5,0(a5)
    80201436:	cb99                	beqz	a5,8020144c <vprintfmt+0x29a>
    80201438:	86be                	mv	a3,a5
    8020143a:	00001617          	auipc	a2,0x1
    8020143e:	a6e60613          	addi	a2,a2,-1426 # 80201ea8 <best_fit_pmm_manager+0x68>
    80201442:	85a6                	mv	a1,s1
    80201444:	854a                	mv	a0,s2
    80201446:	0ce000ef          	jal	ra,80201514 <printfmt>
    8020144a:	b34d                	j	802011ec <vprintfmt+0x3a>
    8020144c:	00001617          	auipc	a2,0x1
    80201450:	a4c60613          	addi	a2,a2,-1460 # 80201e98 <best_fit_pmm_manager+0x58>
    80201454:	85a6                	mv	a1,s1
    80201456:	854a                	mv	a0,s2
    80201458:	0bc000ef          	jal	ra,80201514 <printfmt>
    8020145c:	bb41                	j	802011ec <vprintfmt+0x3a>
    8020145e:	00001417          	auipc	s0,0x1
    80201462:	a3240413          	addi	s0,s0,-1486 # 80201e90 <best_fit_pmm_manager+0x50>
    80201466:	85e2                	mv	a1,s8
    80201468:	8522                	mv	a0,s0
    8020146a:	e43e                	sd	a5,8(sp)
    8020146c:	cadff0ef          	jal	ra,80201118 <strnlen>
    80201470:	40ad8dbb          	subw	s11,s11,a0
    80201474:	01b05b63          	blez	s11,8020148a <vprintfmt+0x2d8>
    80201478:	67a2                	ld	a5,8(sp)
    8020147a:	00078a1b          	sext.w	s4,a5
    8020147e:	3dfd                	addiw	s11,s11,-1
    80201480:	85a6                	mv	a1,s1
    80201482:	8552                	mv	a0,s4
    80201484:	9902                	jalr	s2
    80201486:	fe0d9ce3          	bnez	s11,8020147e <vprintfmt+0x2cc>
    8020148a:	00044783          	lbu	a5,0(s0)
    8020148e:	00140a13          	addi	s4,s0,1
    80201492:	0007851b          	sext.w	a0,a5
    80201496:	d3a5                	beqz	a5,802013f6 <vprintfmt+0x244>
    80201498:	05e00413          	li	s0,94
    8020149c:	bf39                	j	802013ba <vprintfmt+0x208>
    8020149e:	000a2403          	lw	s0,0(s4)
    802014a2:	b7ad                	j	8020140c <vprintfmt+0x25a>
    802014a4:	000a6603          	lwu	a2,0(s4)
    802014a8:	46a1                	li	a3,8
    802014aa:	8a2e                	mv	s4,a1
    802014ac:	bdb1                	j	80201308 <vprintfmt+0x156>
    802014ae:	000a6603          	lwu	a2,0(s4)
    802014b2:	46a9                	li	a3,10
    802014b4:	8a2e                	mv	s4,a1
    802014b6:	bd89                	j	80201308 <vprintfmt+0x156>
    802014b8:	000a6603          	lwu	a2,0(s4)
    802014bc:	46c1                	li	a3,16
    802014be:	8a2e                	mv	s4,a1
    802014c0:	b5a1                	j	80201308 <vprintfmt+0x156>
    802014c2:	9902                	jalr	s2
    802014c4:	bf09                	j	802013d6 <vprintfmt+0x224>
    802014c6:	85a6                	mv	a1,s1
    802014c8:	02d00513          	li	a0,45
    802014cc:	e03e                	sd	a5,0(sp)
    802014ce:	9902                	jalr	s2
    802014d0:	6782                	ld	a5,0(sp)
    802014d2:	8a66                	mv	s4,s9
    802014d4:	40800633          	neg	a2,s0
    802014d8:	46a9                	li	a3,10
    802014da:	b53d                	j	80201308 <vprintfmt+0x156>
    802014dc:	03b05163          	blez	s11,802014fe <vprintfmt+0x34c>
    802014e0:	02d00693          	li	a3,45
    802014e4:	f6d79de3          	bne	a5,a3,8020145e <vprintfmt+0x2ac>
    802014e8:	00001417          	auipc	s0,0x1
    802014ec:	9a840413          	addi	s0,s0,-1624 # 80201e90 <best_fit_pmm_manager+0x50>
    802014f0:	02800793          	li	a5,40
    802014f4:	02800513          	li	a0,40
    802014f8:	00140a13          	addi	s4,s0,1
    802014fc:	bd6d                	j	802013b6 <vprintfmt+0x204>
    802014fe:	00001a17          	auipc	s4,0x1
    80201502:	993a0a13          	addi	s4,s4,-1645 # 80201e91 <best_fit_pmm_manager+0x51>
    80201506:	02800513          	li	a0,40
    8020150a:	02800793          	li	a5,40
    8020150e:	05e00413          	li	s0,94
    80201512:	b565                	j	802013ba <vprintfmt+0x208>

0000000080201514 <printfmt>:
    80201514:	715d                	addi	sp,sp,-80
    80201516:	02810313          	addi	t1,sp,40
    8020151a:	f436                	sd	a3,40(sp)
    8020151c:	869a                	mv	a3,t1
    8020151e:	ec06                	sd	ra,24(sp)
    80201520:	f83a                	sd	a4,48(sp)
    80201522:	fc3e                	sd	a5,56(sp)
    80201524:	e0c2                	sd	a6,64(sp)
    80201526:	e4c6                	sd	a7,72(sp)
    80201528:	e41a                	sd	t1,8(sp)
    8020152a:	c89ff0ef          	jal	ra,802011b2 <vprintfmt>
    8020152e:	60e2                	ld	ra,24(sp)
    80201530:	6161                	addi	sp,sp,80
    80201532:	8082                	ret

0000000080201534 <sbi_console_putchar>:
    80201534:	4781                	li	a5,0
    80201536:	00004717          	auipc	a4,0x4
    8020153a:	aca73703          	ld	a4,-1334(a4) # 80205000 <SBI_CONSOLE_PUTCHAR>
    8020153e:	88ba                	mv	a7,a4
    80201540:	852a                	mv	a0,a0
    80201542:	85be                	mv	a1,a5
    80201544:	863e                	mv	a2,a5
    80201546:	00000073          	ecall
    8020154a:	87aa                	mv	a5,a0
    8020154c:	8082                	ret

000000008020154e <sbi_set_timer>:
    8020154e:	4781                	li	a5,0
    80201550:	00004717          	auipc	a4,0x4
    80201554:	ac873703          	ld	a4,-1336(a4) # 80205018 <SBI_SET_TIMER>
    80201558:	88ba                	mv	a7,a4
    8020155a:	852a                	mv	a0,a0
    8020155c:	85be                	mv	a1,a5
    8020155e:	863e                	mv	a2,a5
    80201560:	00000073          	ecall
    80201564:	87aa                	mv	a5,a0
    80201566:	8082                	ret
