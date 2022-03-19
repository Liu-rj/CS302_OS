
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <kern_entry>:
    80200000:	00004117          	auipc	sp,0x4
    80200004:	00010113          	mv	sp,sp
    80200008:	a009                	j	8020000a <kern_init>

000000008020000a <kern_init>:
    8020000a:	00004517          	auipc	a0,0x4
    8020000e:	ffe50513          	addi	a0,a0,-2 # 80204008 <SBI_SET_TIMER>
    80200012:	00004617          	auipc	a2,0x4
    80200016:	00660613          	addi	a2,a2,6 # 80204018 <end>
    8020001a:	1141                	addi	sp,sp,-16
    8020001c:	8e09                	sub	a2,a2,a0
    8020001e:	4581                	li	a1,0
    80200020:	e406                	sd	ra,8(sp)
    80200022:	4e4000ef          	jal	ra,80200506 <memset>
    80200026:	00001517          	auipc	a0,0x1
    8020002a:	91a50513          	addi	a0,a0,-1766 # 80200940 <etext+0x6>
    8020002e:	064000ef          	jal	ra,80200092 <cputs>
    80200032:	0be000ef          	jal	ra,802000f0 <idt_init>
    80200036:	0b4000ef          	jal	ra,802000ea <intr_enable>
    8020003a:	9002                	ebreak
    8020003c:	30200073          	mret
    80200040:	a001                	j	80200040 <kern_init+0x36>

0000000080200042 <cputch>:
    80200042:	1141                	addi	sp,sp,-16
    80200044:	e022                	sd	s0,0(sp)
    80200046:	e406                	sd	ra,8(sp)
    80200048:	842e                	mv	s0,a1
    8020004a:	098000ef          	jal	ra,802000e2 <cons_putc>
    8020004e:	401c                	lw	a5,0(s0)
    80200050:	60a2                	ld	ra,8(sp)
    80200052:	2785                	addiw	a5,a5,1
    80200054:	c01c                	sw	a5,0(s0)
    80200056:	6402                	ld	s0,0(sp)
    80200058:	0141                	addi	sp,sp,16
    8020005a:	8082                	ret

000000008020005c <cprintf>:
    8020005c:	711d                	addi	sp,sp,-96
    8020005e:	02810313          	addi	t1,sp,40 # 80204028 <end+0x10>
    80200062:	8e2a                	mv	t3,a0
    80200064:	f42e                	sd	a1,40(sp)
    80200066:	f832                	sd	a2,48(sp)
    80200068:	fc36                	sd	a3,56(sp)
    8020006a:	00000517          	auipc	a0,0x0
    8020006e:	fd850513          	addi	a0,a0,-40 # 80200042 <cputch>
    80200072:	004c                	addi	a1,sp,4
    80200074:	869a                	mv	a3,t1
    80200076:	8672                	mv	a2,t3
    80200078:	ec06                	sd	ra,24(sp)
    8020007a:	e0ba                	sd	a4,64(sp)
    8020007c:	e4be                	sd	a5,72(sp)
    8020007e:	e8c2                	sd	a6,80(sp)
    80200080:	ecc6                	sd	a7,88(sp)
    80200082:	e41a                	sd	t1,8(sp)
    80200084:	c202                	sw	zero,4(sp)
    80200086:	4fe000ef          	jal	ra,80200584 <vprintfmt>
    8020008a:	60e2                	ld	ra,24(sp)
    8020008c:	4512                	lw	a0,4(sp)
    8020008e:	6125                	addi	sp,sp,96
    80200090:	8082                	ret

0000000080200092 <cputs>:
    80200092:	1101                	addi	sp,sp,-32
    80200094:	e822                	sd	s0,16(sp)
    80200096:	ec06                	sd	ra,24(sp)
    80200098:	e426                	sd	s1,8(sp)
    8020009a:	842a                	mv	s0,a0
    8020009c:	00054503          	lbu	a0,0(a0)
    802000a0:	c51d                	beqz	a0,802000ce <cputs+0x3c>
    802000a2:	0405                	addi	s0,s0,1
    802000a4:	4485                	li	s1,1
    802000a6:	9c81                	subw	s1,s1,s0
    802000a8:	03a000ef          	jal	ra,802000e2 <cons_putc>
    802000ac:	00044503          	lbu	a0,0(s0)
    802000b0:	008487bb          	addw	a5,s1,s0
    802000b4:	0405                	addi	s0,s0,1
    802000b6:	f96d                	bnez	a0,802000a8 <cputs+0x16>
    802000b8:	0017841b          	addiw	s0,a5,1
    802000bc:	4529                	li	a0,10
    802000be:	024000ef          	jal	ra,802000e2 <cons_putc>
    802000c2:	60e2                	ld	ra,24(sp)
    802000c4:	8522                	mv	a0,s0
    802000c6:	6442                	ld	s0,16(sp)
    802000c8:	64a2                	ld	s1,8(sp)
    802000ca:	6105                	addi	sp,sp,32
    802000cc:	8082                	ret
    802000ce:	4405                	li	s0,1
    802000d0:	b7f5                	j	802000bc <cputs+0x2a>

00000000802000d2 <clock_set_next_event>:
    802000d2:	c0102573          	rdtime	a0
    802000d6:	67e1                	lui	a5,0x18
    802000d8:	6a078793          	addi	a5,a5,1696 # 186a0 <kern_entry-0x801e7960>
    802000dc:	953e                	add	a0,a0,a5
    802000de:	0430006f          	j	80200920 <sbi_set_timer>

00000000802000e2 <cons_putc>:
    802000e2:	0ff57513          	andi	a0,a0,255
    802000e6:	0210006f          	j	80200906 <sbi_console_putchar>

00000000802000ea <intr_enable>:
    802000ea:	100167f3          	csrrsi	a5,sstatus,2
    802000ee:	8082                	ret

00000000802000f0 <idt_init>:
    802000f0:	00000797          	auipc	a5,0x0
    802000f4:	34478793          	addi	a5,a5,836 # 80200434 <__alltraps>
    802000f8:	10579073          	csrw	stvec,a5
    802000fc:	8082                	ret

00000000802000fe <print_regs>:
    802000fe:	610c                	ld	a1,0(a0)
    80200100:	1141                	addi	sp,sp,-16
    80200102:	e022                	sd	s0,0(sp)
    80200104:	842a                	mv	s0,a0
    80200106:	00001517          	auipc	a0,0x1
    8020010a:	85250513          	addi	a0,a0,-1966 # 80200958 <etext+0x1e>
    8020010e:	e406                	sd	ra,8(sp)
    80200110:	f4dff0ef          	jal	ra,8020005c <cprintf>
    80200114:	640c                	ld	a1,8(s0)
    80200116:	00001517          	auipc	a0,0x1
    8020011a:	85a50513          	addi	a0,a0,-1958 # 80200970 <etext+0x36>
    8020011e:	f3fff0ef          	jal	ra,8020005c <cprintf>
    80200122:	680c                	ld	a1,16(s0)
    80200124:	00001517          	auipc	a0,0x1
    80200128:	86450513          	addi	a0,a0,-1948 # 80200988 <etext+0x4e>
    8020012c:	f31ff0ef          	jal	ra,8020005c <cprintf>
    80200130:	6c0c                	ld	a1,24(s0)
    80200132:	00001517          	auipc	a0,0x1
    80200136:	86e50513          	addi	a0,a0,-1938 # 802009a0 <etext+0x66>
    8020013a:	f23ff0ef          	jal	ra,8020005c <cprintf>
    8020013e:	700c                	ld	a1,32(s0)
    80200140:	00001517          	auipc	a0,0x1
    80200144:	87850513          	addi	a0,a0,-1928 # 802009b8 <etext+0x7e>
    80200148:	f15ff0ef          	jal	ra,8020005c <cprintf>
    8020014c:	740c                	ld	a1,40(s0)
    8020014e:	00001517          	auipc	a0,0x1
    80200152:	88250513          	addi	a0,a0,-1918 # 802009d0 <etext+0x96>
    80200156:	f07ff0ef          	jal	ra,8020005c <cprintf>
    8020015a:	780c                	ld	a1,48(s0)
    8020015c:	00001517          	auipc	a0,0x1
    80200160:	88c50513          	addi	a0,a0,-1908 # 802009e8 <etext+0xae>
    80200164:	ef9ff0ef          	jal	ra,8020005c <cprintf>
    80200168:	7c0c                	ld	a1,56(s0)
    8020016a:	00001517          	auipc	a0,0x1
    8020016e:	89650513          	addi	a0,a0,-1898 # 80200a00 <etext+0xc6>
    80200172:	eebff0ef          	jal	ra,8020005c <cprintf>
    80200176:	602c                	ld	a1,64(s0)
    80200178:	00001517          	auipc	a0,0x1
    8020017c:	8a050513          	addi	a0,a0,-1888 # 80200a18 <etext+0xde>
    80200180:	eddff0ef          	jal	ra,8020005c <cprintf>
    80200184:	642c                	ld	a1,72(s0)
    80200186:	00001517          	auipc	a0,0x1
    8020018a:	8aa50513          	addi	a0,a0,-1878 # 80200a30 <etext+0xf6>
    8020018e:	ecfff0ef          	jal	ra,8020005c <cprintf>
    80200192:	682c                	ld	a1,80(s0)
    80200194:	00001517          	auipc	a0,0x1
    80200198:	8b450513          	addi	a0,a0,-1868 # 80200a48 <etext+0x10e>
    8020019c:	ec1ff0ef          	jal	ra,8020005c <cprintf>
    802001a0:	6c2c                	ld	a1,88(s0)
    802001a2:	00001517          	auipc	a0,0x1
    802001a6:	8be50513          	addi	a0,a0,-1858 # 80200a60 <etext+0x126>
    802001aa:	eb3ff0ef          	jal	ra,8020005c <cprintf>
    802001ae:	702c                	ld	a1,96(s0)
    802001b0:	00001517          	auipc	a0,0x1
    802001b4:	8c850513          	addi	a0,a0,-1848 # 80200a78 <etext+0x13e>
    802001b8:	ea5ff0ef          	jal	ra,8020005c <cprintf>
    802001bc:	742c                	ld	a1,104(s0)
    802001be:	00001517          	auipc	a0,0x1
    802001c2:	8d250513          	addi	a0,a0,-1838 # 80200a90 <etext+0x156>
    802001c6:	e97ff0ef          	jal	ra,8020005c <cprintf>
    802001ca:	782c                	ld	a1,112(s0)
    802001cc:	00001517          	auipc	a0,0x1
    802001d0:	8dc50513          	addi	a0,a0,-1828 # 80200aa8 <etext+0x16e>
    802001d4:	e89ff0ef          	jal	ra,8020005c <cprintf>
    802001d8:	7c2c                	ld	a1,120(s0)
    802001da:	00001517          	auipc	a0,0x1
    802001de:	8e650513          	addi	a0,a0,-1818 # 80200ac0 <etext+0x186>
    802001e2:	e7bff0ef          	jal	ra,8020005c <cprintf>
    802001e6:	604c                	ld	a1,128(s0)
    802001e8:	00001517          	auipc	a0,0x1
    802001ec:	8f050513          	addi	a0,a0,-1808 # 80200ad8 <etext+0x19e>
    802001f0:	e6dff0ef          	jal	ra,8020005c <cprintf>
    802001f4:	644c                	ld	a1,136(s0)
    802001f6:	00001517          	auipc	a0,0x1
    802001fa:	8fa50513          	addi	a0,a0,-1798 # 80200af0 <etext+0x1b6>
    802001fe:	e5fff0ef          	jal	ra,8020005c <cprintf>
    80200202:	684c                	ld	a1,144(s0)
    80200204:	00001517          	auipc	a0,0x1
    80200208:	90450513          	addi	a0,a0,-1788 # 80200b08 <etext+0x1ce>
    8020020c:	e51ff0ef          	jal	ra,8020005c <cprintf>
    80200210:	6c4c                	ld	a1,152(s0)
    80200212:	00001517          	auipc	a0,0x1
    80200216:	90e50513          	addi	a0,a0,-1778 # 80200b20 <etext+0x1e6>
    8020021a:	e43ff0ef          	jal	ra,8020005c <cprintf>
    8020021e:	704c                	ld	a1,160(s0)
    80200220:	00001517          	auipc	a0,0x1
    80200224:	91850513          	addi	a0,a0,-1768 # 80200b38 <etext+0x1fe>
    80200228:	e35ff0ef          	jal	ra,8020005c <cprintf>
    8020022c:	744c                	ld	a1,168(s0)
    8020022e:	00001517          	auipc	a0,0x1
    80200232:	92250513          	addi	a0,a0,-1758 # 80200b50 <etext+0x216>
    80200236:	e27ff0ef          	jal	ra,8020005c <cprintf>
    8020023a:	784c                	ld	a1,176(s0)
    8020023c:	00001517          	auipc	a0,0x1
    80200240:	92c50513          	addi	a0,a0,-1748 # 80200b68 <etext+0x22e>
    80200244:	e19ff0ef          	jal	ra,8020005c <cprintf>
    80200248:	7c4c                	ld	a1,184(s0)
    8020024a:	00001517          	auipc	a0,0x1
    8020024e:	93650513          	addi	a0,a0,-1738 # 80200b80 <etext+0x246>
    80200252:	e0bff0ef          	jal	ra,8020005c <cprintf>
    80200256:	606c                	ld	a1,192(s0)
    80200258:	00001517          	auipc	a0,0x1
    8020025c:	94050513          	addi	a0,a0,-1728 # 80200b98 <etext+0x25e>
    80200260:	dfdff0ef          	jal	ra,8020005c <cprintf>
    80200264:	646c                	ld	a1,200(s0)
    80200266:	00001517          	auipc	a0,0x1
    8020026a:	94a50513          	addi	a0,a0,-1718 # 80200bb0 <etext+0x276>
    8020026e:	defff0ef          	jal	ra,8020005c <cprintf>
    80200272:	686c                	ld	a1,208(s0)
    80200274:	00001517          	auipc	a0,0x1
    80200278:	95450513          	addi	a0,a0,-1708 # 80200bc8 <etext+0x28e>
    8020027c:	de1ff0ef          	jal	ra,8020005c <cprintf>
    80200280:	6c6c                	ld	a1,216(s0)
    80200282:	00001517          	auipc	a0,0x1
    80200286:	95e50513          	addi	a0,a0,-1698 # 80200be0 <etext+0x2a6>
    8020028a:	dd3ff0ef          	jal	ra,8020005c <cprintf>
    8020028e:	706c                	ld	a1,224(s0)
    80200290:	00001517          	auipc	a0,0x1
    80200294:	96850513          	addi	a0,a0,-1688 # 80200bf8 <etext+0x2be>
    80200298:	dc5ff0ef          	jal	ra,8020005c <cprintf>
    8020029c:	746c                	ld	a1,232(s0)
    8020029e:	00001517          	auipc	a0,0x1
    802002a2:	97250513          	addi	a0,a0,-1678 # 80200c10 <etext+0x2d6>
    802002a6:	db7ff0ef          	jal	ra,8020005c <cprintf>
    802002aa:	786c                	ld	a1,240(s0)
    802002ac:	00001517          	auipc	a0,0x1
    802002b0:	97c50513          	addi	a0,a0,-1668 # 80200c28 <etext+0x2ee>
    802002b4:	da9ff0ef          	jal	ra,8020005c <cprintf>
    802002b8:	7c6c                	ld	a1,248(s0)
    802002ba:	6402                	ld	s0,0(sp)
    802002bc:	60a2                	ld	ra,8(sp)
    802002be:	00001517          	auipc	a0,0x1
    802002c2:	98250513          	addi	a0,a0,-1662 # 80200c40 <etext+0x306>
    802002c6:	0141                	addi	sp,sp,16
    802002c8:	bb51                	j	8020005c <cprintf>

00000000802002ca <print_trapframe>:
    802002ca:	1141                	addi	sp,sp,-16
    802002cc:	e022                	sd	s0,0(sp)
    802002ce:	85aa                	mv	a1,a0
    802002d0:	842a                	mv	s0,a0
    802002d2:	00001517          	auipc	a0,0x1
    802002d6:	98650513          	addi	a0,a0,-1658 # 80200c58 <etext+0x31e>
    802002da:	e406                	sd	ra,8(sp)
    802002dc:	d81ff0ef          	jal	ra,8020005c <cprintf>
    802002e0:	8522                	mv	a0,s0
    802002e2:	e1dff0ef          	jal	ra,802000fe <print_regs>
    802002e6:	10043583          	ld	a1,256(s0)
    802002ea:	00001517          	auipc	a0,0x1
    802002ee:	98650513          	addi	a0,a0,-1658 # 80200c70 <etext+0x336>
    802002f2:	d6bff0ef          	jal	ra,8020005c <cprintf>
    802002f6:	10843583          	ld	a1,264(s0)
    802002fa:	00001517          	auipc	a0,0x1
    802002fe:	98e50513          	addi	a0,a0,-1650 # 80200c88 <etext+0x34e>
    80200302:	d5bff0ef          	jal	ra,8020005c <cprintf>
    80200306:	11043583          	ld	a1,272(s0)
    8020030a:	00001517          	auipc	a0,0x1
    8020030e:	99650513          	addi	a0,a0,-1642 # 80200ca0 <etext+0x366>
    80200312:	d4bff0ef          	jal	ra,8020005c <cprintf>
    80200316:	11843583          	ld	a1,280(s0)
    8020031a:	6402                	ld	s0,0(sp)
    8020031c:	60a2                	ld	ra,8(sp)
    8020031e:	00001517          	auipc	a0,0x1
    80200322:	99a50513          	addi	a0,a0,-1638 # 80200cb8 <etext+0x37e>
    80200326:	0141                	addi	sp,sp,16
    80200328:	bb15                	j	8020005c <cprintf>

000000008020032a <interrupt_handler>:
    8020032a:	11853783          	ld	a5,280(a0)
    8020032e:	472d                	li	a4,11
    80200330:	0786                	slli	a5,a5,0x1
    80200332:	8385                	srli	a5,a5,0x1
    80200334:	06f76763          	bltu	a4,a5,802003a2 <interrupt_handler+0x78>
    80200338:	00001717          	auipc	a4,0x1
    8020033c:	a4870713          	addi	a4,a4,-1464 # 80200d80 <etext+0x446>
    80200340:	078a                	slli	a5,a5,0x2
    80200342:	97ba                	add	a5,a5,a4
    80200344:	439c                	lw	a5,0(a5)
    80200346:	97ba                	add	a5,a5,a4
    80200348:	8782                	jr	a5
    8020034a:	00001517          	auipc	a0,0x1
    8020034e:	9e650513          	addi	a0,a0,-1562 # 80200d30 <etext+0x3f6>
    80200352:	b329                	j	8020005c <cprintf>
    80200354:	00001517          	auipc	a0,0x1
    80200358:	9bc50513          	addi	a0,a0,-1604 # 80200d10 <etext+0x3d6>
    8020035c:	b301                	j	8020005c <cprintf>
    8020035e:	00001517          	auipc	a0,0x1
    80200362:	97250513          	addi	a0,a0,-1678 # 80200cd0 <etext+0x396>
    80200366:	b9dd                	j	8020005c <cprintf>
    80200368:	00001517          	auipc	a0,0x1
    8020036c:	98850513          	addi	a0,a0,-1656 # 80200cf0 <etext+0x3b6>
    80200370:	b1f5                	j	8020005c <cprintf>
    80200372:	1141                	addi	sp,sp,-16
    80200374:	e406                	sd	ra,8(sp)
    80200376:	d5dff0ef          	jal	ra,802000d2 <clock_set_next_event>
    8020037a:	00004697          	auipc	a3,0x4
    8020037e:	c9668693          	addi	a3,a3,-874 # 80204010 <ticks>
    80200382:	629c                	ld	a5,0(a3)
    80200384:	06400713          	li	a4,100
    80200388:	0785                	addi	a5,a5,1
    8020038a:	02e7f733          	remu	a4,a5,a4
    8020038e:	e29c                	sd	a5,0(a3)
    80200390:	cb11                	beqz	a4,802003a4 <interrupt_handler+0x7a>
    80200392:	60a2                	ld	ra,8(sp)
    80200394:	0141                	addi	sp,sp,16
    80200396:	8082                	ret
    80200398:	00001517          	auipc	a0,0x1
    8020039c:	9c850513          	addi	a0,a0,-1592 # 80200d60 <etext+0x426>
    802003a0:	b975                	j	8020005c <cprintf>
    802003a2:	b725                	j	802002ca <print_trapframe>
    802003a4:	60a2                	ld	ra,8(sp)
    802003a6:	06400593          	li	a1,100
    802003aa:	00001517          	auipc	a0,0x1
    802003ae:	9a650513          	addi	a0,a0,-1626 # 80200d50 <etext+0x416>
    802003b2:	0141                	addi	sp,sp,16
    802003b4:	b165                	j	8020005c <cprintf>

00000000802003b6 <exception_handler>:
    802003b6:	11853783          	ld	a5,280(a0)
    802003ba:	1141                	addi	sp,sp,-16
    802003bc:	e022                	sd	s0,0(sp)
    802003be:	e406                	sd	ra,8(sp)
    802003c0:	470d                	li	a4,3
    802003c2:	842a                	mv	s0,a0
    802003c4:	04e78063          	beq	a5,a4,80200404 <exception_handler+0x4e>
    802003c8:	02f76663          	bltu	a4,a5,802003f4 <exception_handler+0x3e>
    802003cc:	4709                	li	a4,2
    802003ce:	00e79f63          	bne	a5,a4,802003ec <exception_handler+0x36>
    802003d2:	10853583          	ld	a1,264(a0)
    802003d6:	00001517          	auipc	a0,0x1
    802003da:	9da50513          	addi	a0,a0,-1574 # 80200db0 <etext+0x476>
    802003de:	c7fff0ef          	jal	ra,8020005c <cprintf>
    802003e2:	10843783          	ld	a5,264(s0)
    802003e6:	0789                	addi	a5,a5,2
    802003e8:	10f43423          	sd	a5,264(s0)
    802003ec:	60a2                	ld	ra,8(sp)
    802003ee:	6402                	ld	s0,0(sp)
    802003f0:	0141                	addi	sp,sp,16
    802003f2:	8082                	ret
    802003f4:	17f1                	addi	a5,a5,-4
    802003f6:	471d                	li	a4,7
    802003f8:	fef77ae3          	bgeu	a4,a5,802003ec <exception_handler+0x36>
    802003fc:	6402                	ld	s0,0(sp)
    802003fe:	60a2                	ld	ra,8(sp)
    80200400:	0141                	addi	sp,sp,16
    80200402:	b5e1                	j	802002ca <print_trapframe>
    80200404:	10853583          	ld	a1,264(a0)
    80200408:	00001517          	auipc	a0,0x1
    8020040c:	9d850513          	addi	a0,a0,-1576 # 80200de0 <etext+0x4a6>
    80200410:	c4dff0ef          	jal	ra,8020005c <cprintf>
    80200414:	10843783          	ld	a5,264(s0)
    80200418:	60a2                	ld	ra,8(sp)
    8020041a:	0789                	addi	a5,a5,2
    8020041c:	10f43423          	sd	a5,264(s0)
    80200420:	6402                	ld	s0,0(sp)
    80200422:	0141                	addi	sp,sp,16
    80200424:	8082                	ret

0000000080200426 <trap>:
    80200426:	11853783          	ld	a5,280(a0)
    8020042a:	0007c363          	bltz	a5,80200430 <trap+0xa>
    8020042e:	b761                	j	802003b6 <exception_handler>
    80200430:	bded                	j	8020032a <interrupt_handler>
	...

0000000080200434 <__alltraps>:
    80200434:	14011073          	csrw	sscratch,sp
    80200438:	712d                	addi	sp,sp,-288
    8020043a:	e002                	sd	zero,0(sp)
    8020043c:	e406                	sd	ra,8(sp)
    8020043e:	ec0e                	sd	gp,24(sp)
    80200440:	f012                	sd	tp,32(sp)
    80200442:	f416                	sd	t0,40(sp)
    80200444:	f81a                	sd	t1,48(sp)
    80200446:	fc1e                	sd	t2,56(sp)
    80200448:	e0a2                	sd	s0,64(sp)
    8020044a:	e4a6                	sd	s1,72(sp)
    8020044c:	e8aa                	sd	a0,80(sp)
    8020044e:	ecae                	sd	a1,88(sp)
    80200450:	f0b2                	sd	a2,96(sp)
    80200452:	f4b6                	sd	a3,104(sp)
    80200454:	f8ba                	sd	a4,112(sp)
    80200456:	fcbe                	sd	a5,120(sp)
    80200458:	e142                	sd	a6,128(sp)
    8020045a:	e546                	sd	a7,136(sp)
    8020045c:	e94a                	sd	s2,144(sp)
    8020045e:	ed4e                	sd	s3,152(sp)
    80200460:	f152                	sd	s4,160(sp)
    80200462:	f556                	sd	s5,168(sp)
    80200464:	f95a                	sd	s6,176(sp)
    80200466:	fd5e                	sd	s7,184(sp)
    80200468:	e1e2                	sd	s8,192(sp)
    8020046a:	e5e6                	sd	s9,200(sp)
    8020046c:	e9ea                	sd	s10,208(sp)
    8020046e:	edee                	sd	s11,216(sp)
    80200470:	f1f2                	sd	t3,224(sp)
    80200472:	f5f6                	sd	t4,232(sp)
    80200474:	f9fa                	sd	t5,240(sp)
    80200476:	fdfe                	sd	t6,248(sp)
    80200478:	14001473          	csrrw	s0,sscratch,zero
    8020047c:	100024f3          	csrr	s1,sstatus
    80200480:	14102973          	csrr	s2,sepc
    80200484:	143029f3          	csrr	s3,stval
    80200488:	14202a73          	csrr	s4,scause
    8020048c:	e822                	sd	s0,16(sp)
    8020048e:	e226                	sd	s1,256(sp)
    80200490:	e64a                	sd	s2,264(sp)
    80200492:	ea4e                	sd	s3,272(sp)
    80200494:	ee52                	sd	s4,280(sp)
    80200496:	850a                	mv	a0,sp
    80200498:	f8fff0ef          	jal	ra,80200426 <trap>

000000008020049c <__trapret>:
    8020049c:	6492                	ld	s1,256(sp)
    8020049e:	6932                	ld	s2,264(sp)
    802004a0:	10049073          	csrw	sstatus,s1
    802004a4:	14191073          	csrw	sepc,s2
    802004a8:	60a2                	ld	ra,8(sp)
    802004aa:	61e2                	ld	gp,24(sp)
    802004ac:	7202                	ld	tp,32(sp)
    802004ae:	72a2                	ld	t0,40(sp)
    802004b0:	7342                	ld	t1,48(sp)
    802004b2:	73e2                	ld	t2,56(sp)
    802004b4:	6406                	ld	s0,64(sp)
    802004b6:	64a6                	ld	s1,72(sp)
    802004b8:	6546                	ld	a0,80(sp)
    802004ba:	65e6                	ld	a1,88(sp)
    802004bc:	7606                	ld	a2,96(sp)
    802004be:	76a6                	ld	a3,104(sp)
    802004c0:	7746                	ld	a4,112(sp)
    802004c2:	77e6                	ld	a5,120(sp)
    802004c4:	680a                	ld	a6,128(sp)
    802004c6:	68aa                	ld	a7,136(sp)
    802004c8:	694a                	ld	s2,144(sp)
    802004ca:	69ea                	ld	s3,152(sp)
    802004cc:	7a0a                	ld	s4,160(sp)
    802004ce:	7aaa                	ld	s5,168(sp)
    802004d0:	7b4a                	ld	s6,176(sp)
    802004d2:	7bea                	ld	s7,184(sp)
    802004d4:	6c0e                	ld	s8,192(sp)
    802004d6:	6cae                	ld	s9,200(sp)
    802004d8:	6d4e                	ld	s10,208(sp)
    802004da:	6dee                	ld	s11,216(sp)
    802004dc:	7e0e                	ld	t3,224(sp)
    802004de:	7eae                	ld	t4,232(sp)
    802004e0:	7f4e                	ld	t5,240(sp)
    802004e2:	7fee                	ld	t6,248(sp)
    802004e4:	6142                	ld	sp,16(sp)
    802004e6:	10200073          	sret

00000000802004ea <strnlen>:
    802004ea:	872a                	mv	a4,a0
    802004ec:	4501                	li	a0,0
    802004ee:	e589                	bnez	a1,802004f8 <strnlen+0xe>
    802004f0:	a811                	j	80200504 <strnlen+0x1a>
    802004f2:	0505                	addi	a0,a0,1
    802004f4:	00a58763          	beq	a1,a0,80200502 <strnlen+0x18>
    802004f8:	00a707b3          	add	a5,a4,a0
    802004fc:	0007c783          	lbu	a5,0(a5)
    80200500:	fbed                	bnez	a5,802004f2 <strnlen+0x8>
    80200502:	8082                	ret
    80200504:	8082                	ret

0000000080200506 <memset>:
    80200506:	ca01                	beqz	a2,80200516 <memset+0x10>
    80200508:	962a                	add	a2,a2,a0
    8020050a:	87aa                	mv	a5,a0
    8020050c:	0785                	addi	a5,a5,1
    8020050e:	feb78fa3          	sb	a1,-1(a5)
    80200512:	fec79de3          	bne	a5,a2,8020050c <memset+0x6>
    80200516:	8082                	ret

0000000080200518 <printnum>:
    80200518:	02069813          	slli	a6,a3,0x20
    8020051c:	7179                	addi	sp,sp,-48
    8020051e:	02085813          	srli	a6,a6,0x20
    80200522:	e052                	sd	s4,0(sp)
    80200524:	03067a33          	remu	s4,a2,a6
    80200528:	f022                	sd	s0,32(sp)
    8020052a:	ec26                	sd	s1,24(sp)
    8020052c:	e84a                	sd	s2,16(sp)
    8020052e:	f406                	sd	ra,40(sp)
    80200530:	e44e                	sd	s3,8(sp)
    80200532:	84aa                	mv	s1,a0
    80200534:	892e                	mv	s2,a1
    80200536:	fff7041b          	addiw	s0,a4,-1
    8020053a:	2a01                	sext.w	s4,s4
    8020053c:	03067e63          	bgeu	a2,a6,80200578 <printnum+0x60>
    80200540:	89be                	mv	s3,a5
    80200542:	00805763          	blez	s0,80200550 <printnum+0x38>
    80200546:	347d                	addiw	s0,s0,-1
    80200548:	85ca                	mv	a1,s2
    8020054a:	854e                	mv	a0,s3
    8020054c:	9482                	jalr	s1
    8020054e:	fc65                	bnez	s0,80200546 <printnum+0x2e>
    80200550:	1a02                	slli	s4,s4,0x20
    80200552:	020a5a13          	srli	s4,s4,0x20
    80200556:	00001797          	auipc	a5,0x1
    8020055a:	8aa78793          	addi	a5,a5,-1878 # 80200e00 <etext+0x4c6>
    8020055e:	7402                	ld	s0,32(sp)
    80200560:	9a3e                	add	s4,s4,a5
    80200562:	000a4503          	lbu	a0,0(s4)
    80200566:	70a2                	ld	ra,40(sp)
    80200568:	69a2                	ld	s3,8(sp)
    8020056a:	6a02                	ld	s4,0(sp)
    8020056c:	85ca                	mv	a1,s2
    8020056e:	8326                	mv	t1,s1
    80200570:	6942                	ld	s2,16(sp)
    80200572:	64e2                	ld	s1,24(sp)
    80200574:	6145                	addi	sp,sp,48
    80200576:	8302                	jr	t1
    80200578:	03065633          	divu	a2,a2,a6
    8020057c:	8722                	mv	a4,s0
    8020057e:	f9bff0ef          	jal	ra,80200518 <printnum>
    80200582:	b7f9                	j	80200550 <printnum+0x38>

0000000080200584 <vprintfmt>:
    80200584:	7119                	addi	sp,sp,-128
    80200586:	f4a6                	sd	s1,104(sp)
    80200588:	f0ca                	sd	s2,96(sp)
    8020058a:	ecce                	sd	s3,88(sp)
    8020058c:	e8d2                	sd	s4,80(sp)
    8020058e:	e4d6                	sd	s5,72(sp)
    80200590:	e0da                	sd	s6,64(sp)
    80200592:	fc5e                	sd	s7,56(sp)
    80200594:	f06a                	sd	s10,32(sp)
    80200596:	fc86                	sd	ra,120(sp)
    80200598:	f8a2                	sd	s0,112(sp)
    8020059a:	f862                	sd	s8,48(sp)
    8020059c:	f466                	sd	s9,40(sp)
    8020059e:	ec6e                	sd	s11,24(sp)
    802005a0:	892a                	mv	s2,a0
    802005a2:	84ae                	mv	s1,a1
    802005a4:	8d32                	mv	s10,a2
    802005a6:	8a36                	mv	s4,a3
    802005a8:	02500993          	li	s3,37
    802005ac:	5b7d                	li	s6,-1
    802005ae:	00001a97          	auipc	s5,0x1
    802005b2:	886a8a93          	addi	s5,s5,-1914 # 80200e34 <etext+0x4fa>
    802005b6:	00001b97          	auipc	s7,0x1
    802005ba:	a5ab8b93          	addi	s7,s7,-1446 # 80201010 <error_string>
    802005be:	000d4503          	lbu	a0,0(s10)
    802005c2:	001d0413          	addi	s0,s10,1
    802005c6:	01350a63          	beq	a0,s3,802005da <vprintfmt+0x56>
    802005ca:	c121                	beqz	a0,8020060a <vprintfmt+0x86>
    802005cc:	85a6                	mv	a1,s1
    802005ce:	0405                	addi	s0,s0,1
    802005d0:	9902                	jalr	s2
    802005d2:	fff44503          	lbu	a0,-1(s0)
    802005d6:	ff351ae3          	bne	a0,s3,802005ca <vprintfmt+0x46>
    802005da:	00044603          	lbu	a2,0(s0)
    802005de:	02000793          	li	a5,32
    802005e2:	4c81                	li	s9,0
    802005e4:	4881                	li	a7,0
    802005e6:	5c7d                	li	s8,-1
    802005e8:	5dfd                	li	s11,-1
    802005ea:	05500513          	li	a0,85
    802005ee:	4825                	li	a6,9
    802005f0:	fdd6059b          	addiw	a1,a2,-35
    802005f4:	0ff5f593          	andi	a1,a1,255
    802005f8:	00140d13          	addi	s10,s0,1
    802005fc:	04b56263          	bltu	a0,a1,80200640 <vprintfmt+0xbc>
    80200600:	058a                	slli	a1,a1,0x2
    80200602:	95d6                	add	a1,a1,s5
    80200604:	4194                	lw	a3,0(a1)
    80200606:	96d6                	add	a3,a3,s5
    80200608:	8682                	jr	a3
    8020060a:	70e6                	ld	ra,120(sp)
    8020060c:	7446                	ld	s0,112(sp)
    8020060e:	74a6                	ld	s1,104(sp)
    80200610:	7906                	ld	s2,96(sp)
    80200612:	69e6                	ld	s3,88(sp)
    80200614:	6a46                	ld	s4,80(sp)
    80200616:	6aa6                	ld	s5,72(sp)
    80200618:	6b06                	ld	s6,64(sp)
    8020061a:	7be2                	ld	s7,56(sp)
    8020061c:	7c42                	ld	s8,48(sp)
    8020061e:	7ca2                	ld	s9,40(sp)
    80200620:	7d02                	ld	s10,32(sp)
    80200622:	6de2                	ld	s11,24(sp)
    80200624:	6109                	addi	sp,sp,128
    80200626:	8082                	ret
    80200628:	87b2                	mv	a5,a2
    8020062a:	00144603          	lbu	a2,1(s0)
    8020062e:	846a                	mv	s0,s10
    80200630:	00140d13          	addi	s10,s0,1
    80200634:	fdd6059b          	addiw	a1,a2,-35
    80200638:	0ff5f593          	andi	a1,a1,255
    8020063c:	fcb572e3          	bgeu	a0,a1,80200600 <vprintfmt+0x7c>
    80200640:	85a6                	mv	a1,s1
    80200642:	02500513          	li	a0,37
    80200646:	9902                	jalr	s2
    80200648:	fff44783          	lbu	a5,-1(s0)
    8020064c:	8d22                	mv	s10,s0
    8020064e:	f73788e3          	beq	a5,s3,802005be <vprintfmt+0x3a>
    80200652:	ffed4783          	lbu	a5,-2(s10)
    80200656:	1d7d                	addi	s10,s10,-1
    80200658:	ff379de3          	bne	a5,s3,80200652 <vprintfmt+0xce>
    8020065c:	b78d                	j	802005be <vprintfmt+0x3a>
    8020065e:	fd060c1b          	addiw	s8,a2,-48
    80200662:	00144603          	lbu	a2,1(s0)
    80200666:	846a                	mv	s0,s10
    80200668:	fd06069b          	addiw	a3,a2,-48
    8020066c:	0006059b          	sext.w	a1,a2
    80200670:	02d86463          	bltu	a6,a3,80200698 <vprintfmt+0x114>
    80200674:	00144603          	lbu	a2,1(s0)
    80200678:	002c169b          	slliw	a3,s8,0x2
    8020067c:	0186873b          	addw	a4,a3,s8
    80200680:	0017171b          	slliw	a4,a4,0x1
    80200684:	9f2d                	addw	a4,a4,a1
    80200686:	fd06069b          	addiw	a3,a2,-48
    8020068a:	0405                	addi	s0,s0,1
    8020068c:	fd070c1b          	addiw	s8,a4,-48
    80200690:	0006059b          	sext.w	a1,a2
    80200694:	fed870e3          	bgeu	a6,a3,80200674 <vprintfmt+0xf0>
    80200698:	f40ddce3          	bgez	s11,802005f0 <vprintfmt+0x6c>
    8020069c:	8de2                	mv	s11,s8
    8020069e:	5c7d                	li	s8,-1
    802006a0:	bf81                	j	802005f0 <vprintfmt+0x6c>
    802006a2:	fffdc693          	not	a3,s11
    802006a6:	96fd                	srai	a3,a3,0x3f
    802006a8:	00ddfdb3          	and	s11,s11,a3
    802006ac:	00144603          	lbu	a2,1(s0)
    802006b0:	2d81                	sext.w	s11,s11
    802006b2:	846a                	mv	s0,s10
    802006b4:	bf35                	j	802005f0 <vprintfmt+0x6c>
    802006b6:	000a2c03          	lw	s8,0(s4)
    802006ba:	00144603          	lbu	a2,1(s0)
    802006be:	0a21                	addi	s4,s4,8
    802006c0:	846a                	mv	s0,s10
    802006c2:	bfd9                	j	80200698 <vprintfmt+0x114>
    802006c4:	4705                	li	a4,1
    802006c6:	008a0593          	addi	a1,s4,8
    802006ca:	01174463          	blt	a4,a7,802006d2 <vprintfmt+0x14e>
    802006ce:	1a088e63          	beqz	a7,8020088a <vprintfmt+0x306>
    802006d2:	000a3603          	ld	a2,0(s4)
    802006d6:	46c1                	li	a3,16
    802006d8:	8a2e                	mv	s4,a1
    802006da:	2781                	sext.w	a5,a5
    802006dc:	876e                	mv	a4,s11
    802006de:	85a6                	mv	a1,s1
    802006e0:	854a                	mv	a0,s2
    802006e2:	e37ff0ef          	jal	ra,80200518 <printnum>
    802006e6:	bde1                	j	802005be <vprintfmt+0x3a>
    802006e8:	000a2503          	lw	a0,0(s4)
    802006ec:	85a6                	mv	a1,s1
    802006ee:	0a21                	addi	s4,s4,8
    802006f0:	9902                	jalr	s2
    802006f2:	b5f1                	j	802005be <vprintfmt+0x3a>
    802006f4:	4705                	li	a4,1
    802006f6:	008a0593          	addi	a1,s4,8
    802006fa:	01174463          	blt	a4,a7,80200702 <vprintfmt+0x17e>
    802006fe:	18088163          	beqz	a7,80200880 <vprintfmt+0x2fc>
    80200702:	000a3603          	ld	a2,0(s4)
    80200706:	46a9                	li	a3,10
    80200708:	8a2e                	mv	s4,a1
    8020070a:	bfc1                	j	802006da <vprintfmt+0x156>
    8020070c:	00144603          	lbu	a2,1(s0)
    80200710:	4c85                	li	s9,1
    80200712:	846a                	mv	s0,s10
    80200714:	bdf1                	j	802005f0 <vprintfmt+0x6c>
    80200716:	85a6                	mv	a1,s1
    80200718:	02500513          	li	a0,37
    8020071c:	9902                	jalr	s2
    8020071e:	b545                	j	802005be <vprintfmt+0x3a>
    80200720:	00144603          	lbu	a2,1(s0)
    80200724:	2885                	addiw	a7,a7,1
    80200726:	846a                	mv	s0,s10
    80200728:	b5e1                	j	802005f0 <vprintfmt+0x6c>
    8020072a:	4705                	li	a4,1
    8020072c:	008a0593          	addi	a1,s4,8
    80200730:	01174463          	blt	a4,a7,80200738 <vprintfmt+0x1b4>
    80200734:	14088163          	beqz	a7,80200876 <vprintfmt+0x2f2>
    80200738:	000a3603          	ld	a2,0(s4)
    8020073c:	46a1                	li	a3,8
    8020073e:	8a2e                	mv	s4,a1
    80200740:	bf69                	j	802006da <vprintfmt+0x156>
    80200742:	03000513          	li	a0,48
    80200746:	85a6                	mv	a1,s1
    80200748:	e03e                	sd	a5,0(sp)
    8020074a:	9902                	jalr	s2
    8020074c:	85a6                	mv	a1,s1
    8020074e:	07800513          	li	a0,120
    80200752:	9902                	jalr	s2
    80200754:	0a21                	addi	s4,s4,8
    80200756:	6782                	ld	a5,0(sp)
    80200758:	46c1                	li	a3,16
    8020075a:	ff8a3603          	ld	a2,-8(s4)
    8020075e:	bfb5                	j	802006da <vprintfmt+0x156>
    80200760:	000a3403          	ld	s0,0(s4)
    80200764:	008a0713          	addi	a4,s4,8
    80200768:	e03a                	sd	a4,0(sp)
    8020076a:	14040263          	beqz	s0,802008ae <vprintfmt+0x32a>
    8020076e:	0fb05763          	blez	s11,8020085c <vprintfmt+0x2d8>
    80200772:	02d00693          	li	a3,45
    80200776:	0cd79163          	bne	a5,a3,80200838 <vprintfmt+0x2b4>
    8020077a:	00044783          	lbu	a5,0(s0)
    8020077e:	0007851b          	sext.w	a0,a5
    80200782:	cf85                	beqz	a5,802007ba <vprintfmt+0x236>
    80200784:	00140a13          	addi	s4,s0,1
    80200788:	05e00413          	li	s0,94
    8020078c:	000c4563          	bltz	s8,80200796 <vprintfmt+0x212>
    80200790:	3c7d                	addiw	s8,s8,-1
    80200792:	036c0263          	beq	s8,s6,802007b6 <vprintfmt+0x232>
    80200796:	85a6                	mv	a1,s1
    80200798:	0e0c8e63          	beqz	s9,80200894 <vprintfmt+0x310>
    8020079c:	3781                	addiw	a5,a5,-32
    8020079e:	0ef47b63          	bgeu	s0,a5,80200894 <vprintfmt+0x310>
    802007a2:	03f00513          	li	a0,63
    802007a6:	9902                	jalr	s2
    802007a8:	000a4783          	lbu	a5,0(s4)
    802007ac:	3dfd                	addiw	s11,s11,-1
    802007ae:	0a05                	addi	s4,s4,1
    802007b0:	0007851b          	sext.w	a0,a5
    802007b4:	ffe1                	bnez	a5,8020078c <vprintfmt+0x208>
    802007b6:	01b05963          	blez	s11,802007c8 <vprintfmt+0x244>
    802007ba:	3dfd                	addiw	s11,s11,-1
    802007bc:	85a6                	mv	a1,s1
    802007be:	02000513          	li	a0,32
    802007c2:	9902                	jalr	s2
    802007c4:	fe0d9be3          	bnez	s11,802007ba <vprintfmt+0x236>
    802007c8:	6a02                	ld	s4,0(sp)
    802007ca:	bbd5                	j	802005be <vprintfmt+0x3a>
    802007cc:	4705                	li	a4,1
    802007ce:	008a0c93          	addi	s9,s4,8
    802007d2:	01174463          	blt	a4,a7,802007da <vprintfmt+0x256>
    802007d6:	08088d63          	beqz	a7,80200870 <vprintfmt+0x2ec>
    802007da:	000a3403          	ld	s0,0(s4)
    802007de:	0a044d63          	bltz	s0,80200898 <vprintfmt+0x314>
    802007e2:	8622                	mv	a2,s0
    802007e4:	8a66                	mv	s4,s9
    802007e6:	46a9                	li	a3,10
    802007e8:	bdcd                	j	802006da <vprintfmt+0x156>
    802007ea:	000a2783          	lw	a5,0(s4)
    802007ee:	4719                	li	a4,6
    802007f0:	0a21                	addi	s4,s4,8
    802007f2:	41f7d69b          	sraiw	a3,a5,0x1f
    802007f6:	8fb5                	xor	a5,a5,a3
    802007f8:	40d786bb          	subw	a3,a5,a3
    802007fc:	02d74163          	blt	a4,a3,8020081e <vprintfmt+0x29a>
    80200800:	00369793          	slli	a5,a3,0x3
    80200804:	97de                	add	a5,a5,s7
    80200806:	639c                	ld	a5,0(a5)
    80200808:	cb99                	beqz	a5,8020081e <vprintfmt+0x29a>
    8020080a:	86be                	mv	a3,a5
    8020080c:	00000617          	auipc	a2,0x0
    80200810:	62460613          	addi	a2,a2,1572 # 80200e30 <etext+0x4f6>
    80200814:	85a6                	mv	a1,s1
    80200816:	854a                	mv	a0,s2
    80200818:	0ce000ef          	jal	ra,802008e6 <printfmt>
    8020081c:	b34d                	j	802005be <vprintfmt+0x3a>
    8020081e:	00000617          	auipc	a2,0x0
    80200822:	60260613          	addi	a2,a2,1538 # 80200e20 <etext+0x4e6>
    80200826:	85a6                	mv	a1,s1
    80200828:	854a                	mv	a0,s2
    8020082a:	0bc000ef          	jal	ra,802008e6 <printfmt>
    8020082e:	bb41                	j	802005be <vprintfmt+0x3a>
    80200830:	00000417          	auipc	s0,0x0
    80200834:	5e840413          	addi	s0,s0,1512 # 80200e18 <etext+0x4de>
    80200838:	85e2                	mv	a1,s8
    8020083a:	8522                	mv	a0,s0
    8020083c:	e43e                	sd	a5,8(sp)
    8020083e:	cadff0ef          	jal	ra,802004ea <strnlen>
    80200842:	40ad8dbb          	subw	s11,s11,a0
    80200846:	01b05b63          	blez	s11,8020085c <vprintfmt+0x2d8>
    8020084a:	67a2                	ld	a5,8(sp)
    8020084c:	00078a1b          	sext.w	s4,a5
    80200850:	3dfd                	addiw	s11,s11,-1
    80200852:	85a6                	mv	a1,s1
    80200854:	8552                	mv	a0,s4
    80200856:	9902                	jalr	s2
    80200858:	fe0d9ce3          	bnez	s11,80200850 <vprintfmt+0x2cc>
    8020085c:	00044783          	lbu	a5,0(s0)
    80200860:	00140a13          	addi	s4,s0,1
    80200864:	0007851b          	sext.w	a0,a5
    80200868:	d3a5                	beqz	a5,802007c8 <vprintfmt+0x244>
    8020086a:	05e00413          	li	s0,94
    8020086e:	bf39                	j	8020078c <vprintfmt+0x208>
    80200870:	000a2403          	lw	s0,0(s4)
    80200874:	b7ad                	j	802007de <vprintfmt+0x25a>
    80200876:	000a6603          	lwu	a2,0(s4)
    8020087a:	46a1                	li	a3,8
    8020087c:	8a2e                	mv	s4,a1
    8020087e:	bdb1                	j	802006da <vprintfmt+0x156>
    80200880:	000a6603          	lwu	a2,0(s4)
    80200884:	46a9                	li	a3,10
    80200886:	8a2e                	mv	s4,a1
    80200888:	bd89                	j	802006da <vprintfmt+0x156>
    8020088a:	000a6603          	lwu	a2,0(s4)
    8020088e:	46c1                	li	a3,16
    80200890:	8a2e                	mv	s4,a1
    80200892:	b5a1                	j	802006da <vprintfmt+0x156>
    80200894:	9902                	jalr	s2
    80200896:	bf09                	j	802007a8 <vprintfmt+0x224>
    80200898:	85a6                	mv	a1,s1
    8020089a:	02d00513          	li	a0,45
    8020089e:	e03e                	sd	a5,0(sp)
    802008a0:	9902                	jalr	s2
    802008a2:	6782                	ld	a5,0(sp)
    802008a4:	8a66                	mv	s4,s9
    802008a6:	40800633          	neg	a2,s0
    802008aa:	46a9                	li	a3,10
    802008ac:	b53d                	j	802006da <vprintfmt+0x156>
    802008ae:	03b05163          	blez	s11,802008d0 <vprintfmt+0x34c>
    802008b2:	02d00693          	li	a3,45
    802008b6:	f6d79de3          	bne	a5,a3,80200830 <vprintfmt+0x2ac>
    802008ba:	00000417          	auipc	s0,0x0
    802008be:	55e40413          	addi	s0,s0,1374 # 80200e18 <etext+0x4de>
    802008c2:	02800793          	li	a5,40
    802008c6:	02800513          	li	a0,40
    802008ca:	00140a13          	addi	s4,s0,1
    802008ce:	bd6d                	j	80200788 <vprintfmt+0x204>
    802008d0:	00000a17          	auipc	s4,0x0
    802008d4:	549a0a13          	addi	s4,s4,1353 # 80200e19 <etext+0x4df>
    802008d8:	02800513          	li	a0,40
    802008dc:	02800793          	li	a5,40
    802008e0:	05e00413          	li	s0,94
    802008e4:	b565                	j	8020078c <vprintfmt+0x208>

00000000802008e6 <printfmt>:
    802008e6:	715d                	addi	sp,sp,-80
    802008e8:	02810313          	addi	t1,sp,40
    802008ec:	f436                	sd	a3,40(sp)
    802008ee:	869a                	mv	a3,t1
    802008f0:	ec06                	sd	ra,24(sp)
    802008f2:	f83a                	sd	a4,48(sp)
    802008f4:	fc3e                	sd	a5,56(sp)
    802008f6:	e0c2                	sd	a6,64(sp)
    802008f8:	e4c6                	sd	a7,72(sp)
    802008fa:	e41a                	sd	t1,8(sp)
    802008fc:	c89ff0ef          	jal	ra,80200584 <vprintfmt>
    80200900:	60e2                	ld	ra,24(sp)
    80200902:	6161                	addi	sp,sp,80
    80200904:	8082                	ret

0000000080200906 <sbi_console_putchar>:
    80200906:	4781                	li	a5,0
    80200908:	00003717          	auipc	a4,0x3
    8020090c:	6f873703          	ld	a4,1784(a4) # 80204000 <SBI_CONSOLE_PUTCHAR>
    80200910:	88ba                	mv	a7,a4
    80200912:	852a                	mv	a0,a0
    80200914:	85be                	mv	a1,a5
    80200916:	863e                	mv	a2,a5
    80200918:	00000073          	ecall
    8020091c:	87aa                	mv	a5,a0
    8020091e:	8082                	ret

0000000080200920 <sbi_set_timer>:
    80200920:	4781                	li	a5,0
    80200922:	00003717          	auipc	a4,0x3
    80200926:	6e673703          	ld	a4,1766(a4) # 80204008 <SBI_SET_TIMER>
    8020092a:	88ba                	mv	a7,a4
    8020092c:	852a                	mv	a0,a0
    8020092e:	85be                	mv	a1,a5
    80200930:	863e                	mv	a2,a5
    80200932:	00000073          	ecall
    80200936:	87aa                	mv	a5,a0
    80200938:	8082                	ret
