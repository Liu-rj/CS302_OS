
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
ffffffffc0200000:	c02082b7          	lui	t0,0xc0208
ffffffffc0200004:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200008:	037a                	slli	t1,t1,0x1e
ffffffffc020000a:	406282b3          	sub	t0,t0,t1
ffffffffc020000e:	00c2d293          	srli	t0,t0,0xc
ffffffffc0200012:	fff0031b          	addiw	t1,zero,-1
ffffffffc0200016:	137e                	slli	t1,t1,0x3f
ffffffffc0200018:	0062e2b3          	or	t0,t0,t1
ffffffffc020001c:	18029073          	csrw	satp,t0
ffffffffc0200020:	12000073          	sfence.vma
ffffffffc0200024:	c0208137          	lui	sp,0xc0208
ffffffffc0200028:	c02002b7          	lui	t0,0xc0200
ffffffffc020002c:	03228293          	addi	t0,t0,50 # ffffffffc0200032 <kern_init>
ffffffffc0200030:	8282                	jr	t0

ffffffffc0200032 <kern_init>:
ffffffffc0200032:	00009517          	auipc	a0,0x9
ffffffffc0200036:	00e50513          	addi	a0,a0,14 # ffffffffc0209040 <ide>
ffffffffc020003a:	00010617          	auipc	a2,0x10
ffffffffc020003e:	16660613          	addi	a2,a2,358 # ffffffffc02101a0 <end>
ffffffffc0200042:	1141                	addi	sp,sp,-16
ffffffffc0200044:	8e09                	sub	a2,a2,a0
ffffffffc0200046:	4581                	li	a1,0
ffffffffc0200048:	e406                	sd	ra,8(sp)
ffffffffc020004a:	00d030ef          	jal	ra,ffffffffc0203856 <memset>
ffffffffc020004e:	00004597          	auipc	a1,0x4
ffffffffc0200052:	c2258593          	addi	a1,a1,-990 # ffffffffc0203c70 <etext+0x2>
ffffffffc0200056:	00004517          	auipc	a0,0x4
ffffffffc020005a:	c3250513          	addi	a0,a0,-974 # ffffffffc0203c88 <etext+0x1a>
ffffffffc020005e:	058000ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200062:	000010ef          	jal	ra,ffffffffc0201062 <pmm_init>
ffffffffc0200066:	204000ef          	jal	ra,ffffffffc020026a <idt_init>
ffffffffc020006a:	559010ef          	jal	ra,ffffffffc0201dc2 <vmm_init>
ffffffffc020006e:	0dc000ef          	jal	ra,ffffffffc020014a <ide_init>
ffffffffc0200072:	17c000ef          	jal	ra,ffffffffc02001ee <intr_enable>
ffffffffc0200076:	352020ef          	jal	ra,ffffffffc02023c8 <swap_init>
ffffffffc020007a:	a001                	j	ffffffffc020007a <kern_init+0x48>

ffffffffc020007c <cputch>:
ffffffffc020007c:	1141                	addi	sp,sp,-16
ffffffffc020007e:	e022                	sd	s0,0(sp)
ffffffffc0200080:	e406                	sd	ra,8(sp)
ffffffffc0200082:	842e                	mv	s0,a1
ffffffffc0200084:	136000ef          	jal	ra,ffffffffc02001ba <cons_putc>
ffffffffc0200088:	401c                	lw	a5,0(s0)
ffffffffc020008a:	60a2                	ld	ra,8(sp)
ffffffffc020008c:	2785                	addiw	a5,a5,1
ffffffffc020008e:	c01c                	sw	a5,0(s0)
ffffffffc0200090:	6402                	ld	s0,0(sp)
ffffffffc0200092:	0141                	addi	sp,sp,16
ffffffffc0200094:	8082                	ret

ffffffffc0200096 <vcprintf>:
ffffffffc0200096:	1101                	addi	sp,sp,-32
ffffffffc0200098:	862a                	mv	a2,a0
ffffffffc020009a:	86ae                	mv	a3,a1
ffffffffc020009c:	00000517          	auipc	a0,0x0
ffffffffc02000a0:	fe050513          	addi	a0,a0,-32 # ffffffffc020007c <cputch>
ffffffffc02000a4:	006c                	addi	a1,sp,12
ffffffffc02000a6:	ec06                	sd	ra,24(sp)
ffffffffc02000a8:	c602                	sw	zero,12(sp)
ffffffffc02000aa:	043030ef          	jal	ra,ffffffffc02038ec <vprintfmt>
ffffffffc02000ae:	60e2                	ld	ra,24(sp)
ffffffffc02000b0:	4532                	lw	a0,12(sp)
ffffffffc02000b2:	6105                	addi	sp,sp,32
ffffffffc02000b4:	8082                	ret

ffffffffc02000b6 <cprintf>:
ffffffffc02000b6:	711d                	addi	sp,sp,-96
ffffffffc02000b8:	02810313          	addi	t1,sp,40 # ffffffffc0208028 <boot_page_table_sv39+0x28>
ffffffffc02000bc:	8e2a                	mv	t3,a0
ffffffffc02000be:	f42e                	sd	a1,40(sp)
ffffffffc02000c0:	f832                	sd	a2,48(sp)
ffffffffc02000c2:	fc36                	sd	a3,56(sp)
ffffffffc02000c4:	00000517          	auipc	a0,0x0
ffffffffc02000c8:	fb850513          	addi	a0,a0,-72 # ffffffffc020007c <cputch>
ffffffffc02000cc:	004c                	addi	a1,sp,4
ffffffffc02000ce:	869a                	mv	a3,t1
ffffffffc02000d0:	8672                	mv	a2,t3
ffffffffc02000d2:	ec06                	sd	ra,24(sp)
ffffffffc02000d4:	e0ba                	sd	a4,64(sp)
ffffffffc02000d6:	e4be                	sd	a5,72(sp)
ffffffffc02000d8:	e8c2                	sd	a6,80(sp)
ffffffffc02000da:	ecc6                	sd	a7,88(sp)
ffffffffc02000dc:	e41a                	sd	t1,8(sp)
ffffffffc02000de:	c202                	sw	zero,4(sp)
ffffffffc02000e0:	00d030ef          	jal	ra,ffffffffc02038ec <vprintfmt>
ffffffffc02000e4:	60e2                	ld	ra,24(sp)
ffffffffc02000e6:	4512                	lw	a0,4(sp)
ffffffffc02000e8:	6125                	addi	sp,sp,96
ffffffffc02000ea:	8082                	ret

ffffffffc02000ec <__panic>:
ffffffffc02000ec:	00010317          	auipc	t1,0x10
ffffffffc02000f0:	f5430313          	addi	t1,t1,-172 # ffffffffc0210040 <is_panic>
ffffffffc02000f4:	00032e03          	lw	t3,0(t1)
ffffffffc02000f8:	715d                	addi	sp,sp,-80
ffffffffc02000fa:	ec06                	sd	ra,24(sp)
ffffffffc02000fc:	e822                	sd	s0,16(sp)
ffffffffc02000fe:	f436                	sd	a3,40(sp)
ffffffffc0200100:	f83a                	sd	a4,48(sp)
ffffffffc0200102:	fc3e                	sd	a5,56(sp)
ffffffffc0200104:	e0c2                	sd	a6,64(sp)
ffffffffc0200106:	e4c6                	sd	a7,72(sp)
ffffffffc0200108:	020e1a63          	bnez	t3,ffffffffc020013c <__panic+0x50>
ffffffffc020010c:	4785                	li	a5,1
ffffffffc020010e:	00f32023          	sw	a5,0(t1)
ffffffffc0200112:	8432                	mv	s0,a2
ffffffffc0200114:	103c                	addi	a5,sp,40
ffffffffc0200116:	862e                	mv	a2,a1
ffffffffc0200118:	85aa                	mv	a1,a0
ffffffffc020011a:	00004517          	auipc	a0,0x4
ffffffffc020011e:	b7650513          	addi	a0,a0,-1162 # ffffffffc0203c90 <etext+0x22>
ffffffffc0200122:	e43e                	sd	a5,8(sp)
ffffffffc0200124:	f93ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200128:	65a2                	ld	a1,8(sp)
ffffffffc020012a:	8522                	mv	a0,s0
ffffffffc020012c:	f6bff0ef          	jal	ra,ffffffffc0200096 <vcprintf>
ffffffffc0200130:	00005517          	auipc	a0,0x5
ffffffffc0200134:	87850513          	addi	a0,a0,-1928 # ffffffffc02049a8 <etext+0xd3a>
ffffffffc0200138:	f7fff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020013c:	0b8000ef          	jal	ra,ffffffffc02001f4 <intr_disable>
ffffffffc0200140:	4501                	li	a0,0
ffffffffc0200142:	006000ef          	jal	ra,ffffffffc0200148 <kmonitor>
ffffffffc0200146:	bfed                	j	ffffffffc0200140 <__panic+0x54>

ffffffffc0200148 <kmonitor>:
ffffffffc0200148:	a001                	j	ffffffffc0200148 <kmonitor>

ffffffffc020014a <ide_init>:
ffffffffc020014a:	8082                	ret

ffffffffc020014c <ide_device_valid>:
ffffffffc020014c:	00253513          	sltiu	a0,a0,2
ffffffffc0200150:	8082                	ret

ffffffffc0200152 <ide_device_size>:
ffffffffc0200152:	03800513          	li	a0,56
ffffffffc0200156:	8082                	ret

ffffffffc0200158 <ide_read_secs>:
ffffffffc0200158:	00009797          	auipc	a5,0x9
ffffffffc020015c:	ee878793          	addi	a5,a5,-280 # ffffffffc0209040 <ide>
ffffffffc0200160:	0095959b          	slliw	a1,a1,0x9
ffffffffc0200164:	1141                	addi	sp,sp,-16
ffffffffc0200166:	8532                	mv	a0,a2
ffffffffc0200168:	95be                	add	a1,a1,a5
ffffffffc020016a:	00969613          	slli	a2,a3,0x9
ffffffffc020016e:	e406                	sd	ra,8(sp)
ffffffffc0200170:	6f8030ef          	jal	ra,ffffffffc0203868 <memcpy>
ffffffffc0200174:	60a2                	ld	ra,8(sp)
ffffffffc0200176:	4501                	li	a0,0
ffffffffc0200178:	0141                	addi	sp,sp,16
ffffffffc020017a:	8082                	ret

ffffffffc020017c <ide_write_secs>:
ffffffffc020017c:	0095979b          	slliw	a5,a1,0x9
ffffffffc0200180:	00009517          	auipc	a0,0x9
ffffffffc0200184:	ec050513          	addi	a0,a0,-320 # ffffffffc0209040 <ide>
ffffffffc0200188:	1141                	addi	sp,sp,-16
ffffffffc020018a:	85b2                	mv	a1,a2
ffffffffc020018c:	953e                	add	a0,a0,a5
ffffffffc020018e:	00969613          	slli	a2,a3,0x9
ffffffffc0200192:	e406                	sd	ra,8(sp)
ffffffffc0200194:	6d4030ef          	jal	ra,ffffffffc0203868 <memcpy>
ffffffffc0200198:	60a2                	ld	ra,8(sp)
ffffffffc020019a:	4501                	li	a0,0
ffffffffc020019c:	0141                	addi	sp,sp,16
ffffffffc020019e:	8082                	ret

ffffffffc02001a0 <clock_set_next_event>:
ffffffffc02001a0:	c0102573          	rdtime	a0
ffffffffc02001a4:	00010797          	auipc	a5,0x10
ffffffffc02001a8:	ea47b783          	ld	a5,-348(a5) # ffffffffc0210048 <timebase>
ffffffffc02001ac:	953e                	add	a0,a0,a5
ffffffffc02001ae:	4581                	li	a1,0
ffffffffc02001b0:	4601                	li	a2,0
ffffffffc02001b2:	4881                	li	a7,0
ffffffffc02001b4:	00000073          	ecall
ffffffffc02001b8:	8082                	ret

ffffffffc02001ba <cons_putc>:
ffffffffc02001ba:	100027f3          	csrr	a5,sstatus
ffffffffc02001be:	8b89                	andi	a5,a5,2
ffffffffc02001c0:	0ff57513          	andi	a0,a0,255
ffffffffc02001c4:	e799                	bnez	a5,ffffffffc02001d2 <cons_putc+0x18>
ffffffffc02001c6:	4581                	li	a1,0
ffffffffc02001c8:	4601                	li	a2,0
ffffffffc02001ca:	4885                	li	a7,1
ffffffffc02001cc:	00000073          	ecall
ffffffffc02001d0:	8082                	ret
ffffffffc02001d2:	1101                	addi	sp,sp,-32
ffffffffc02001d4:	ec06                	sd	ra,24(sp)
ffffffffc02001d6:	e42a                	sd	a0,8(sp)
ffffffffc02001d8:	01c000ef          	jal	ra,ffffffffc02001f4 <intr_disable>
ffffffffc02001dc:	6522                	ld	a0,8(sp)
ffffffffc02001de:	4581                	li	a1,0
ffffffffc02001e0:	4601                	li	a2,0
ffffffffc02001e2:	4885                	li	a7,1
ffffffffc02001e4:	00000073          	ecall
ffffffffc02001e8:	60e2                	ld	ra,24(sp)
ffffffffc02001ea:	6105                	addi	sp,sp,32
ffffffffc02001ec:	a009                	j	ffffffffc02001ee <intr_enable>

ffffffffc02001ee <intr_enable>:
ffffffffc02001ee:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc02001f2:	8082                	ret

ffffffffc02001f4 <intr_disable>:
ffffffffc02001f4:	100177f3          	csrrci	a5,sstatus,2
ffffffffc02001f8:	8082                	ret

ffffffffc02001fa <pgfault_handler>:
ffffffffc02001fa:	10053783          	ld	a5,256(a0)
ffffffffc02001fe:	1141                	addi	sp,sp,-16
ffffffffc0200200:	e022                	sd	s0,0(sp)
ffffffffc0200202:	e406                	sd	ra,8(sp)
ffffffffc0200204:	1007f793          	andi	a5,a5,256
ffffffffc0200208:	11053583          	ld	a1,272(a0)
ffffffffc020020c:	842a                	mv	s0,a0
ffffffffc020020e:	05500613          	li	a2,85
ffffffffc0200212:	c399                	beqz	a5,ffffffffc0200218 <pgfault_handler+0x1e>
ffffffffc0200214:	04b00613          	li	a2,75
ffffffffc0200218:	11843703          	ld	a4,280(s0)
ffffffffc020021c:	47bd                	li	a5,15
ffffffffc020021e:	05700693          	li	a3,87
ffffffffc0200222:	00f70463          	beq	a4,a5,ffffffffc020022a <pgfault_handler+0x30>
ffffffffc0200226:	05200693          	li	a3,82
ffffffffc020022a:	00004517          	auipc	a0,0x4
ffffffffc020022e:	a8650513          	addi	a0,a0,-1402 # ffffffffc0203cb0 <etext+0x42>
ffffffffc0200232:	e85ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200236:	00010517          	auipc	a0,0x10
ffffffffc020023a:	e8253503          	ld	a0,-382(a0) # ffffffffc02100b8 <check_mm_struct>
ffffffffc020023e:	c911                	beqz	a0,ffffffffc0200252 <pgfault_handler+0x58>
ffffffffc0200240:	11043603          	ld	a2,272(s0)
ffffffffc0200244:	11843583          	ld	a1,280(s0)
ffffffffc0200248:	6402                	ld	s0,0(sp)
ffffffffc020024a:	60a2                	ld	ra,8(sp)
ffffffffc020024c:	0141                	addi	sp,sp,16
ffffffffc020024e:	0ac0206f          	j	ffffffffc02022fa <do_pgfault>
ffffffffc0200252:	00004617          	auipc	a2,0x4
ffffffffc0200256:	a7e60613          	addi	a2,a2,-1410 # ffffffffc0203cd0 <etext+0x62>
ffffffffc020025a:	06300593          	li	a1,99
ffffffffc020025e:	00004517          	auipc	a0,0x4
ffffffffc0200262:	a8a50513          	addi	a0,a0,-1398 # ffffffffc0203ce8 <etext+0x7a>
ffffffffc0200266:	e87ff0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc020026a <idt_init>:
ffffffffc020026a:	14005073          	csrwi	sscratch,0
ffffffffc020026e:	00000797          	auipc	a5,0x0
ffffffffc0200272:	47278793          	addi	a5,a5,1138 # ffffffffc02006e0 <__alltraps>
ffffffffc0200276:	10579073          	csrw	stvec,a5
ffffffffc020027a:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc020027e:	000407b7          	lui	a5,0x40
ffffffffc0200282:	1007a7f3          	csrrs	a5,sstatus,a5
ffffffffc0200286:	8082                	ret

ffffffffc0200288 <print_regs>:
ffffffffc0200288:	610c                	ld	a1,0(a0)
ffffffffc020028a:	1141                	addi	sp,sp,-16
ffffffffc020028c:	e022                	sd	s0,0(sp)
ffffffffc020028e:	842a                	mv	s0,a0
ffffffffc0200290:	00004517          	auipc	a0,0x4
ffffffffc0200294:	a7050513          	addi	a0,a0,-1424 # ffffffffc0203d00 <etext+0x92>
ffffffffc0200298:	e406                	sd	ra,8(sp)
ffffffffc020029a:	e1dff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020029e:	640c                	ld	a1,8(s0)
ffffffffc02002a0:	00004517          	auipc	a0,0x4
ffffffffc02002a4:	a7850513          	addi	a0,a0,-1416 # ffffffffc0203d18 <etext+0xaa>
ffffffffc02002a8:	e0fff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02002ac:	680c                	ld	a1,16(s0)
ffffffffc02002ae:	00004517          	auipc	a0,0x4
ffffffffc02002b2:	a8250513          	addi	a0,a0,-1406 # ffffffffc0203d30 <etext+0xc2>
ffffffffc02002b6:	e01ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02002ba:	6c0c                	ld	a1,24(s0)
ffffffffc02002bc:	00004517          	auipc	a0,0x4
ffffffffc02002c0:	a8c50513          	addi	a0,a0,-1396 # ffffffffc0203d48 <etext+0xda>
ffffffffc02002c4:	df3ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02002c8:	700c                	ld	a1,32(s0)
ffffffffc02002ca:	00004517          	auipc	a0,0x4
ffffffffc02002ce:	a9650513          	addi	a0,a0,-1386 # ffffffffc0203d60 <etext+0xf2>
ffffffffc02002d2:	de5ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02002d6:	740c                	ld	a1,40(s0)
ffffffffc02002d8:	00004517          	auipc	a0,0x4
ffffffffc02002dc:	aa050513          	addi	a0,a0,-1376 # ffffffffc0203d78 <etext+0x10a>
ffffffffc02002e0:	dd7ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02002e4:	780c                	ld	a1,48(s0)
ffffffffc02002e6:	00004517          	auipc	a0,0x4
ffffffffc02002ea:	aaa50513          	addi	a0,a0,-1366 # ffffffffc0203d90 <etext+0x122>
ffffffffc02002ee:	dc9ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02002f2:	7c0c                	ld	a1,56(s0)
ffffffffc02002f4:	00004517          	auipc	a0,0x4
ffffffffc02002f8:	ab450513          	addi	a0,a0,-1356 # ffffffffc0203da8 <etext+0x13a>
ffffffffc02002fc:	dbbff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200300:	602c                	ld	a1,64(s0)
ffffffffc0200302:	00004517          	auipc	a0,0x4
ffffffffc0200306:	abe50513          	addi	a0,a0,-1346 # ffffffffc0203dc0 <etext+0x152>
ffffffffc020030a:	dadff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020030e:	642c                	ld	a1,72(s0)
ffffffffc0200310:	00004517          	auipc	a0,0x4
ffffffffc0200314:	ac850513          	addi	a0,a0,-1336 # ffffffffc0203dd8 <etext+0x16a>
ffffffffc0200318:	d9fff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020031c:	682c                	ld	a1,80(s0)
ffffffffc020031e:	00004517          	auipc	a0,0x4
ffffffffc0200322:	ad250513          	addi	a0,a0,-1326 # ffffffffc0203df0 <etext+0x182>
ffffffffc0200326:	d91ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020032a:	6c2c                	ld	a1,88(s0)
ffffffffc020032c:	00004517          	auipc	a0,0x4
ffffffffc0200330:	adc50513          	addi	a0,a0,-1316 # ffffffffc0203e08 <etext+0x19a>
ffffffffc0200334:	d83ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200338:	702c                	ld	a1,96(s0)
ffffffffc020033a:	00004517          	auipc	a0,0x4
ffffffffc020033e:	ae650513          	addi	a0,a0,-1306 # ffffffffc0203e20 <etext+0x1b2>
ffffffffc0200342:	d75ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200346:	742c                	ld	a1,104(s0)
ffffffffc0200348:	00004517          	auipc	a0,0x4
ffffffffc020034c:	af050513          	addi	a0,a0,-1296 # ffffffffc0203e38 <etext+0x1ca>
ffffffffc0200350:	d67ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200354:	782c                	ld	a1,112(s0)
ffffffffc0200356:	00004517          	auipc	a0,0x4
ffffffffc020035a:	afa50513          	addi	a0,a0,-1286 # ffffffffc0203e50 <etext+0x1e2>
ffffffffc020035e:	d59ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200362:	7c2c                	ld	a1,120(s0)
ffffffffc0200364:	00004517          	auipc	a0,0x4
ffffffffc0200368:	b0450513          	addi	a0,a0,-1276 # ffffffffc0203e68 <etext+0x1fa>
ffffffffc020036c:	d4bff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200370:	604c                	ld	a1,128(s0)
ffffffffc0200372:	00004517          	auipc	a0,0x4
ffffffffc0200376:	b0e50513          	addi	a0,a0,-1266 # ffffffffc0203e80 <etext+0x212>
ffffffffc020037a:	d3dff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020037e:	644c                	ld	a1,136(s0)
ffffffffc0200380:	00004517          	auipc	a0,0x4
ffffffffc0200384:	b1850513          	addi	a0,a0,-1256 # ffffffffc0203e98 <etext+0x22a>
ffffffffc0200388:	d2fff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020038c:	684c                	ld	a1,144(s0)
ffffffffc020038e:	00004517          	auipc	a0,0x4
ffffffffc0200392:	b2250513          	addi	a0,a0,-1246 # ffffffffc0203eb0 <etext+0x242>
ffffffffc0200396:	d21ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020039a:	6c4c                	ld	a1,152(s0)
ffffffffc020039c:	00004517          	auipc	a0,0x4
ffffffffc02003a0:	b2c50513          	addi	a0,a0,-1236 # ffffffffc0203ec8 <etext+0x25a>
ffffffffc02003a4:	d13ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02003a8:	704c                	ld	a1,160(s0)
ffffffffc02003aa:	00004517          	auipc	a0,0x4
ffffffffc02003ae:	b3650513          	addi	a0,a0,-1226 # ffffffffc0203ee0 <etext+0x272>
ffffffffc02003b2:	d05ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02003b6:	744c                	ld	a1,168(s0)
ffffffffc02003b8:	00004517          	auipc	a0,0x4
ffffffffc02003bc:	b4050513          	addi	a0,a0,-1216 # ffffffffc0203ef8 <etext+0x28a>
ffffffffc02003c0:	cf7ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02003c4:	784c                	ld	a1,176(s0)
ffffffffc02003c6:	00004517          	auipc	a0,0x4
ffffffffc02003ca:	b4a50513          	addi	a0,a0,-1206 # ffffffffc0203f10 <etext+0x2a2>
ffffffffc02003ce:	ce9ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02003d2:	7c4c                	ld	a1,184(s0)
ffffffffc02003d4:	00004517          	auipc	a0,0x4
ffffffffc02003d8:	b5450513          	addi	a0,a0,-1196 # ffffffffc0203f28 <etext+0x2ba>
ffffffffc02003dc:	cdbff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02003e0:	606c                	ld	a1,192(s0)
ffffffffc02003e2:	00004517          	auipc	a0,0x4
ffffffffc02003e6:	b5e50513          	addi	a0,a0,-1186 # ffffffffc0203f40 <etext+0x2d2>
ffffffffc02003ea:	ccdff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02003ee:	646c                	ld	a1,200(s0)
ffffffffc02003f0:	00004517          	auipc	a0,0x4
ffffffffc02003f4:	b6850513          	addi	a0,a0,-1176 # ffffffffc0203f58 <etext+0x2ea>
ffffffffc02003f8:	cbfff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02003fc:	686c                	ld	a1,208(s0)
ffffffffc02003fe:	00004517          	auipc	a0,0x4
ffffffffc0200402:	b7250513          	addi	a0,a0,-1166 # ffffffffc0203f70 <etext+0x302>
ffffffffc0200406:	cb1ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020040a:	6c6c                	ld	a1,216(s0)
ffffffffc020040c:	00004517          	auipc	a0,0x4
ffffffffc0200410:	b7c50513          	addi	a0,a0,-1156 # ffffffffc0203f88 <etext+0x31a>
ffffffffc0200414:	ca3ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200418:	706c                	ld	a1,224(s0)
ffffffffc020041a:	00004517          	auipc	a0,0x4
ffffffffc020041e:	b8650513          	addi	a0,a0,-1146 # ffffffffc0203fa0 <etext+0x332>
ffffffffc0200422:	c95ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200426:	746c                	ld	a1,232(s0)
ffffffffc0200428:	00004517          	auipc	a0,0x4
ffffffffc020042c:	b9050513          	addi	a0,a0,-1136 # ffffffffc0203fb8 <etext+0x34a>
ffffffffc0200430:	c87ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200434:	786c                	ld	a1,240(s0)
ffffffffc0200436:	00004517          	auipc	a0,0x4
ffffffffc020043a:	b9a50513          	addi	a0,a0,-1126 # ffffffffc0203fd0 <etext+0x362>
ffffffffc020043e:	c79ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200442:	7c6c                	ld	a1,248(s0)
ffffffffc0200444:	6402                	ld	s0,0(sp)
ffffffffc0200446:	60a2                	ld	ra,8(sp)
ffffffffc0200448:	00004517          	auipc	a0,0x4
ffffffffc020044c:	ba050513          	addi	a0,a0,-1120 # ffffffffc0203fe8 <etext+0x37a>
ffffffffc0200450:	0141                	addi	sp,sp,16
ffffffffc0200452:	b195                	j	ffffffffc02000b6 <cprintf>

ffffffffc0200454 <print_trapframe>:
ffffffffc0200454:	1141                	addi	sp,sp,-16
ffffffffc0200456:	e022                	sd	s0,0(sp)
ffffffffc0200458:	85aa                	mv	a1,a0
ffffffffc020045a:	842a                	mv	s0,a0
ffffffffc020045c:	00004517          	auipc	a0,0x4
ffffffffc0200460:	ba450513          	addi	a0,a0,-1116 # ffffffffc0204000 <etext+0x392>
ffffffffc0200464:	e406                	sd	ra,8(sp)
ffffffffc0200466:	c51ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020046a:	8522                	mv	a0,s0
ffffffffc020046c:	e1dff0ef          	jal	ra,ffffffffc0200288 <print_regs>
ffffffffc0200470:	10043583          	ld	a1,256(s0)
ffffffffc0200474:	00004517          	auipc	a0,0x4
ffffffffc0200478:	ba450513          	addi	a0,a0,-1116 # ffffffffc0204018 <etext+0x3aa>
ffffffffc020047c:	c3bff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200480:	10843583          	ld	a1,264(s0)
ffffffffc0200484:	00004517          	auipc	a0,0x4
ffffffffc0200488:	bac50513          	addi	a0,a0,-1108 # ffffffffc0204030 <etext+0x3c2>
ffffffffc020048c:	c2bff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200490:	11043583          	ld	a1,272(s0)
ffffffffc0200494:	00004517          	auipc	a0,0x4
ffffffffc0200498:	bb450513          	addi	a0,a0,-1100 # ffffffffc0204048 <etext+0x3da>
ffffffffc020049c:	c1bff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02004a0:	11843583          	ld	a1,280(s0)
ffffffffc02004a4:	6402                	ld	s0,0(sp)
ffffffffc02004a6:	60a2                	ld	ra,8(sp)
ffffffffc02004a8:	00004517          	auipc	a0,0x4
ffffffffc02004ac:	bb850513          	addi	a0,a0,-1096 # ffffffffc0204060 <etext+0x3f2>
ffffffffc02004b0:	0141                	addi	sp,sp,16
ffffffffc02004b2:	b111                	j	ffffffffc02000b6 <cprintf>

ffffffffc02004b4 <interrupt_handler>:
ffffffffc02004b4:	11853783          	ld	a5,280(a0)
ffffffffc02004b8:	472d                	li	a4,11
ffffffffc02004ba:	0786                	slli	a5,a5,0x1
ffffffffc02004bc:	8385                	srli	a5,a5,0x1
ffffffffc02004be:	06f76763          	bltu	a4,a5,ffffffffc020052c <interrupt_handler+0x78>
ffffffffc02004c2:	00004717          	auipc	a4,0x4
ffffffffc02004c6:	c6670713          	addi	a4,a4,-922 # ffffffffc0204128 <etext+0x4ba>
ffffffffc02004ca:	078a                	slli	a5,a5,0x2
ffffffffc02004cc:	97ba                	add	a5,a5,a4
ffffffffc02004ce:	439c                	lw	a5,0(a5)
ffffffffc02004d0:	97ba                	add	a5,a5,a4
ffffffffc02004d2:	8782                	jr	a5
ffffffffc02004d4:	00004517          	auipc	a0,0x4
ffffffffc02004d8:	c0450513          	addi	a0,a0,-1020 # ffffffffc02040d8 <etext+0x46a>
ffffffffc02004dc:	bee9                	j	ffffffffc02000b6 <cprintf>
ffffffffc02004de:	00004517          	auipc	a0,0x4
ffffffffc02004e2:	bda50513          	addi	a0,a0,-1062 # ffffffffc02040b8 <etext+0x44a>
ffffffffc02004e6:	bec1                	j	ffffffffc02000b6 <cprintf>
ffffffffc02004e8:	00004517          	auipc	a0,0x4
ffffffffc02004ec:	b9050513          	addi	a0,a0,-1136 # ffffffffc0204078 <etext+0x40a>
ffffffffc02004f0:	b6d9                	j	ffffffffc02000b6 <cprintf>
ffffffffc02004f2:	00004517          	auipc	a0,0x4
ffffffffc02004f6:	ba650513          	addi	a0,a0,-1114 # ffffffffc0204098 <etext+0x42a>
ffffffffc02004fa:	be75                	j	ffffffffc02000b6 <cprintf>
ffffffffc02004fc:	1141                	addi	sp,sp,-16
ffffffffc02004fe:	e406                	sd	ra,8(sp)
ffffffffc0200500:	ca1ff0ef          	jal	ra,ffffffffc02001a0 <clock_set_next_event>
ffffffffc0200504:	00010697          	auipc	a3,0x10
ffffffffc0200508:	b7468693          	addi	a3,a3,-1164 # ffffffffc0210078 <ticks>
ffffffffc020050c:	629c                	ld	a5,0(a3)
ffffffffc020050e:	06400713          	li	a4,100
ffffffffc0200512:	0785                	addi	a5,a5,1
ffffffffc0200514:	02e7f733          	remu	a4,a5,a4
ffffffffc0200518:	e29c                	sd	a5,0(a3)
ffffffffc020051a:	cb11                	beqz	a4,ffffffffc020052e <interrupt_handler+0x7a>
ffffffffc020051c:	60a2                	ld	ra,8(sp)
ffffffffc020051e:	0141                	addi	sp,sp,16
ffffffffc0200520:	8082                	ret
ffffffffc0200522:	00004517          	auipc	a0,0x4
ffffffffc0200526:	be650513          	addi	a0,a0,-1050 # ffffffffc0204108 <etext+0x49a>
ffffffffc020052a:	b671                	j	ffffffffc02000b6 <cprintf>
ffffffffc020052c:	b725                	j	ffffffffc0200454 <print_trapframe>
ffffffffc020052e:	60a2                	ld	ra,8(sp)
ffffffffc0200530:	06400593          	li	a1,100
ffffffffc0200534:	00004517          	auipc	a0,0x4
ffffffffc0200538:	bc450513          	addi	a0,a0,-1084 # ffffffffc02040f8 <etext+0x48a>
ffffffffc020053c:	0141                	addi	sp,sp,16
ffffffffc020053e:	bea5                	j	ffffffffc02000b6 <cprintf>

ffffffffc0200540 <exception_handler>:
ffffffffc0200540:	11853783          	ld	a5,280(a0)
ffffffffc0200544:	1101                	addi	sp,sp,-32
ffffffffc0200546:	e822                	sd	s0,16(sp)
ffffffffc0200548:	ec06                	sd	ra,24(sp)
ffffffffc020054a:	e426                	sd	s1,8(sp)
ffffffffc020054c:	473d                	li	a4,15
ffffffffc020054e:	842a                	mv	s0,a0
ffffffffc0200550:	14f76963          	bltu	a4,a5,ffffffffc02006a2 <exception_handler+0x162>
ffffffffc0200554:	00004717          	auipc	a4,0x4
ffffffffc0200558:	dbc70713          	addi	a4,a4,-580 # ffffffffc0204310 <etext+0x6a2>
ffffffffc020055c:	078a                	slli	a5,a5,0x2
ffffffffc020055e:	97ba                	add	a5,a5,a4
ffffffffc0200560:	439c                	lw	a5,0(a5)
ffffffffc0200562:	97ba                	add	a5,a5,a4
ffffffffc0200564:	8782                	jr	a5
ffffffffc0200566:	00004517          	auipc	a0,0x4
ffffffffc020056a:	d9250513          	addi	a0,a0,-622 # ffffffffc02042f8 <etext+0x68a>
ffffffffc020056e:	b49ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200572:	8522                	mv	a0,s0
ffffffffc0200574:	c87ff0ef          	jal	ra,ffffffffc02001fa <pgfault_handler>
ffffffffc0200578:	84aa                	mv	s1,a0
ffffffffc020057a:	12051a63          	bnez	a0,ffffffffc02006ae <exception_handler+0x16e>
ffffffffc020057e:	60e2                	ld	ra,24(sp)
ffffffffc0200580:	6442                	ld	s0,16(sp)
ffffffffc0200582:	64a2                	ld	s1,8(sp)
ffffffffc0200584:	6105                	addi	sp,sp,32
ffffffffc0200586:	8082                	ret
ffffffffc0200588:	00004517          	auipc	a0,0x4
ffffffffc020058c:	bd050513          	addi	a0,a0,-1072 # ffffffffc0204158 <etext+0x4ea>
ffffffffc0200590:	6442                	ld	s0,16(sp)
ffffffffc0200592:	60e2                	ld	ra,24(sp)
ffffffffc0200594:	64a2                	ld	s1,8(sp)
ffffffffc0200596:	6105                	addi	sp,sp,32
ffffffffc0200598:	be39                	j	ffffffffc02000b6 <cprintf>
ffffffffc020059a:	00004517          	auipc	a0,0x4
ffffffffc020059e:	bde50513          	addi	a0,a0,-1058 # ffffffffc0204178 <etext+0x50a>
ffffffffc02005a2:	b7fd                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc02005a4:	00004517          	auipc	a0,0x4
ffffffffc02005a8:	bf450513          	addi	a0,a0,-1036 # ffffffffc0204198 <etext+0x52a>
ffffffffc02005ac:	b7d5                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc02005ae:	00004517          	auipc	a0,0x4
ffffffffc02005b2:	c0250513          	addi	a0,a0,-1022 # ffffffffc02041b0 <etext+0x542>
ffffffffc02005b6:	bfe9                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc02005b8:	00004517          	auipc	a0,0x4
ffffffffc02005bc:	c0850513          	addi	a0,a0,-1016 # ffffffffc02041c0 <etext+0x552>
ffffffffc02005c0:	bfc1                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc02005c2:	00004517          	auipc	a0,0x4
ffffffffc02005c6:	c1e50513          	addi	a0,a0,-994 # ffffffffc02041e0 <etext+0x572>
ffffffffc02005ca:	aedff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02005ce:	8522                	mv	a0,s0
ffffffffc02005d0:	c2bff0ef          	jal	ra,ffffffffc02001fa <pgfault_handler>
ffffffffc02005d4:	84aa                	mv	s1,a0
ffffffffc02005d6:	d545                	beqz	a0,ffffffffc020057e <exception_handler+0x3e>
ffffffffc02005d8:	8522                	mv	a0,s0
ffffffffc02005da:	e7bff0ef          	jal	ra,ffffffffc0200454 <print_trapframe>
ffffffffc02005de:	86a6                	mv	a3,s1
ffffffffc02005e0:	00004617          	auipc	a2,0x4
ffffffffc02005e4:	c1860613          	addi	a2,a2,-1000 # ffffffffc02041f8 <etext+0x58a>
ffffffffc02005e8:	0af00593          	li	a1,175
ffffffffc02005ec:	00003517          	auipc	a0,0x3
ffffffffc02005f0:	6fc50513          	addi	a0,a0,1788 # ffffffffc0203ce8 <etext+0x7a>
ffffffffc02005f4:	af9ff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02005f8:	00004517          	auipc	a0,0x4
ffffffffc02005fc:	c2050513          	addi	a0,a0,-992 # ffffffffc0204218 <etext+0x5aa>
ffffffffc0200600:	bf41                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc0200602:	00004517          	auipc	a0,0x4
ffffffffc0200606:	c2e50513          	addi	a0,a0,-978 # ffffffffc0204230 <etext+0x5c2>
ffffffffc020060a:	aadff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020060e:	8522                	mv	a0,s0
ffffffffc0200610:	bebff0ef          	jal	ra,ffffffffc02001fa <pgfault_handler>
ffffffffc0200614:	84aa                	mv	s1,a0
ffffffffc0200616:	d525                	beqz	a0,ffffffffc020057e <exception_handler+0x3e>
ffffffffc0200618:	8522                	mv	a0,s0
ffffffffc020061a:	e3bff0ef          	jal	ra,ffffffffc0200454 <print_trapframe>
ffffffffc020061e:	86a6                	mv	a3,s1
ffffffffc0200620:	00004617          	auipc	a2,0x4
ffffffffc0200624:	bd860613          	addi	a2,a2,-1064 # ffffffffc02041f8 <etext+0x58a>
ffffffffc0200628:	0b900593          	li	a1,185
ffffffffc020062c:	00003517          	auipc	a0,0x3
ffffffffc0200630:	6bc50513          	addi	a0,a0,1724 # ffffffffc0203ce8 <etext+0x7a>
ffffffffc0200634:	ab9ff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0200638:	00004517          	auipc	a0,0x4
ffffffffc020063c:	c1050513          	addi	a0,a0,-1008 # ffffffffc0204248 <etext+0x5da>
ffffffffc0200640:	bf81                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc0200642:	00004517          	auipc	a0,0x4
ffffffffc0200646:	c2650513          	addi	a0,a0,-986 # ffffffffc0204268 <etext+0x5fa>
ffffffffc020064a:	b799                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc020064c:	00004517          	auipc	a0,0x4
ffffffffc0200650:	c3c50513          	addi	a0,a0,-964 # ffffffffc0204288 <etext+0x61a>
ffffffffc0200654:	bf35                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc0200656:	00004517          	auipc	a0,0x4
ffffffffc020065a:	c5250513          	addi	a0,a0,-942 # ffffffffc02042a8 <etext+0x63a>
ffffffffc020065e:	bf0d                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc0200660:	00004517          	auipc	a0,0x4
ffffffffc0200664:	c6850513          	addi	a0,a0,-920 # ffffffffc02042c8 <etext+0x65a>
ffffffffc0200668:	b725                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc020066a:	00004517          	auipc	a0,0x4
ffffffffc020066e:	c7650513          	addi	a0,a0,-906 # ffffffffc02042e0 <etext+0x672>
ffffffffc0200672:	a45ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200676:	8522                	mv	a0,s0
ffffffffc0200678:	b83ff0ef          	jal	ra,ffffffffc02001fa <pgfault_handler>
ffffffffc020067c:	84aa                	mv	s1,a0
ffffffffc020067e:	f00500e3          	beqz	a0,ffffffffc020057e <exception_handler+0x3e>
ffffffffc0200682:	8522                	mv	a0,s0
ffffffffc0200684:	dd1ff0ef          	jal	ra,ffffffffc0200454 <print_trapframe>
ffffffffc0200688:	86a6                	mv	a3,s1
ffffffffc020068a:	00004617          	auipc	a2,0x4
ffffffffc020068e:	b6e60613          	addi	a2,a2,-1170 # ffffffffc02041f8 <etext+0x58a>
ffffffffc0200692:	0cf00593          	li	a1,207
ffffffffc0200696:	00003517          	auipc	a0,0x3
ffffffffc020069a:	65250513          	addi	a0,a0,1618 # ffffffffc0203ce8 <etext+0x7a>
ffffffffc020069e:	a4fff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02006a2:	8522                	mv	a0,s0
ffffffffc02006a4:	6442                	ld	s0,16(sp)
ffffffffc02006a6:	60e2                	ld	ra,24(sp)
ffffffffc02006a8:	64a2                	ld	s1,8(sp)
ffffffffc02006aa:	6105                	addi	sp,sp,32
ffffffffc02006ac:	b365                	j	ffffffffc0200454 <print_trapframe>
ffffffffc02006ae:	8522                	mv	a0,s0
ffffffffc02006b0:	da5ff0ef          	jal	ra,ffffffffc0200454 <print_trapframe>
ffffffffc02006b4:	86a6                	mv	a3,s1
ffffffffc02006b6:	00004617          	auipc	a2,0x4
ffffffffc02006ba:	b4260613          	addi	a2,a2,-1214 # ffffffffc02041f8 <etext+0x58a>
ffffffffc02006be:	0d600593          	li	a1,214
ffffffffc02006c2:	00003517          	auipc	a0,0x3
ffffffffc02006c6:	62650513          	addi	a0,a0,1574 # ffffffffc0203ce8 <etext+0x7a>
ffffffffc02006ca:	a23ff0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc02006ce <trap>:
ffffffffc02006ce:	11853783          	ld	a5,280(a0)
ffffffffc02006d2:	0007c363          	bltz	a5,ffffffffc02006d8 <trap+0xa>
ffffffffc02006d6:	b5ad                	j	ffffffffc0200540 <exception_handler>
ffffffffc02006d8:	bbf1                	j	ffffffffc02004b4 <interrupt_handler>
ffffffffc02006da:	0000                	unimp
ffffffffc02006dc:	0000                	unimp
	...

ffffffffc02006e0 <__alltraps>:
ffffffffc02006e0:	14011073          	csrw	sscratch,sp
ffffffffc02006e4:	712d                	addi	sp,sp,-288
ffffffffc02006e6:	e406                	sd	ra,8(sp)
ffffffffc02006e8:	ec0e                	sd	gp,24(sp)
ffffffffc02006ea:	f012                	sd	tp,32(sp)
ffffffffc02006ec:	f416                	sd	t0,40(sp)
ffffffffc02006ee:	f81a                	sd	t1,48(sp)
ffffffffc02006f0:	fc1e                	sd	t2,56(sp)
ffffffffc02006f2:	e0a2                	sd	s0,64(sp)
ffffffffc02006f4:	e4a6                	sd	s1,72(sp)
ffffffffc02006f6:	e8aa                	sd	a0,80(sp)
ffffffffc02006f8:	ecae                	sd	a1,88(sp)
ffffffffc02006fa:	f0b2                	sd	a2,96(sp)
ffffffffc02006fc:	f4b6                	sd	a3,104(sp)
ffffffffc02006fe:	f8ba                	sd	a4,112(sp)
ffffffffc0200700:	fcbe                	sd	a5,120(sp)
ffffffffc0200702:	e142                	sd	a6,128(sp)
ffffffffc0200704:	e546                	sd	a7,136(sp)
ffffffffc0200706:	e94a                	sd	s2,144(sp)
ffffffffc0200708:	ed4e                	sd	s3,152(sp)
ffffffffc020070a:	f152                	sd	s4,160(sp)
ffffffffc020070c:	f556                	sd	s5,168(sp)
ffffffffc020070e:	f95a                	sd	s6,176(sp)
ffffffffc0200710:	fd5e                	sd	s7,184(sp)
ffffffffc0200712:	e1e2                	sd	s8,192(sp)
ffffffffc0200714:	e5e6                	sd	s9,200(sp)
ffffffffc0200716:	e9ea                	sd	s10,208(sp)
ffffffffc0200718:	edee                	sd	s11,216(sp)
ffffffffc020071a:	f1f2                	sd	t3,224(sp)
ffffffffc020071c:	f5f6                	sd	t4,232(sp)
ffffffffc020071e:	f9fa                	sd	t5,240(sp)
ffffffffc0200720:	fdfe                	sd	t6,248(sp)
ffffffffc0200722:	14002473          	csrr	s0,sscratch
ffffffffc0200726:	100024f3          	csrr	s1,sstatus
ffffffffc020072a:	14102973          	csrr	s2,sepc
ffffffffc020072e:	143029f3          	csrr	s3,stval
ffffffffc0200732:	14202a73          	csrr	s4,scause
ffffffffc0200736:	e822                	sd	s0,16(sp)
ffffffffc0200738:	e226                	sd	s1,256(sp)
ffffffffc020073a:	e64a                	sd	s2,264(sp)
ffffffffc020073c:	ea4e                	sd	s3,272(sp)
ffffffffc020073e:	ee52                	sd	s4,280(sp)
ffffffffc0200740:	850a                	mv	a0,sp
ffffffffc0200742:	f8dff0ef          	jal	ra,ffffffffc02006ce <trap>

ffffffffc0200746 <__trapret>:
ffffffffc0200746:	6492                	ld	s1,256(sp)
ffffffffc0200748:	6932                	ld	s2,264(sp)
ffffffffc020074a:	10049073          	csrw	sstatus,s1
ffffffffc020074e:	14191073          	csrw	sepc,s2
ffffffffc0200752:	60a2                	ld	ra,8(sp)
ffffffffc0200754:	61e2                	ld	gp,24(sp)
ffffffffc0200756:	7202                	ld	tp,32(sp)
ffffffffc0200758:	72a2                	ld	t0,40(sp)
ffffffffc020075a:	7342                	ld	t1,48(sp)
ffffffffc020075c:	73e2                	ld	t2,56(sp)
ffffffffc020075e:	6406                	ld	s0,64(sp)
ffffffffc0200760:	64a6                	ld	s1,72(sp)
ffffffffc0200762:	6546                	ld	a0,80(sp)
ffffffffc0200764:	65e6                	ld	a1,88(sp)
ffffffffc0200766:	7606                	ld	a2,96(sp)
ffffffffc0200768:	76a6                	ld	a3,104(sp)
ffffffffc020076a:	7746                	ld	a4,112(sp)
ffffffffc020076c:	77e6                	ld	a5,120(sp)
ffffffffc020076e:	680a                	ld	a6,128(sp)
ffffffffc0200770:	68aa                	ld	a7,136(sp)
ffffffffc0200772:	694a                	ld	s2,144(sp)
ffffffffc0200774:	69ea                	ld	s3,152(sp)
ffffffffc0200776:	7a0a                	ld	s4,160(sp)
ffffffffc0200778:	7aaa                	ld	s5,168(sp)
ffffffffc020077a:	7b4a                	ld	s6,176(sp)
ffffffffc020077c:	7bea                	ld	s7,184(sp)
ffffffffc020077e:	6c0e                	ld	s8,192(sp)
ffffffffc0200780:	6cae                	ld	s9,200(sp)
ffffffffc0200782:	6d4e                	ld	s10,208(sp)
ffffffffc0200784:	6dee                	ld	s11,216(sp)
ffffffffc0200786:	7e0e                	ld	t3,224(sp)
ffffffffc0200788:	7eae                	ld	t4,232(sp)
ffffffffc020078a:	7f4e                	ld	t5,240(sp)
ffffffffc020078c:	7fee                	ld	t6,248(sp)
ffffffffc020078e:	6142                	ld	sp,16(sp)
ffffffffc0200790:	10200073          	sret
	...

ffffffffc02007a0 <_lru_init_mm>:
ffffffffc02007a0:	00010797          	auipc	a5,0x10
ffffffffc02007a4:	8e078793          	addi	a5,a5,-1824 # ffffffffc0210080 <pra_list_head>
ffffffffc02007a8:	f51c                	sd	a5,40(a0)
ffffffffc02007aa:	e79c                	sd	a5,8(a5)
ffffffffc02007ac:	e39c                	sd	a5,0(a5)
ffffffffc02007ae:	4501                	li	a0,0
ffffffffc02007b0:	8082                	ret

ffffffffc02007b2 <_lru_init>:
ffffffffc02007b2:	4501                	li	a0,0
ffffffffc02007b4:	8082                	ret

ffffffffc02007b6 <_lru_set_unswappable>:
ffffffffc02007b6:	4501                	li	a0,0
ffffffffc02007b8:	8082                	ret

ffffffffc02007ba <_lru_tick_event>:
ffffffffc02007ba:	4501                	li	a0,0
ffffffffc02007bc:	8082                	ret

ffffffffc02007be <_lru_check_swap>:
ffffffffc02007be:	7139                	addi	sp,sp,-64
ffffffffc02007c0:	00004517          	auipc	a0,0x4
ffffffffc02007c4:	b9050513          	addi	a0,a0,-1136 # ffffffffc0204350 <etext+0x6e2>
ffffffffc02007c8:	fc06                	sd	ra,56(sp)
ffffffffc02007ca:	f04a                	sd	s2,32(sp)
ffffffffc02007cc:	e05a                	sd	s6,0(sp)
ffffffffc02007ce:	f822                	sd	s0,48(sp)
ffffffffc02007d0:	f426                	sd	s1,40(sp)
ffffffffc02007d2:	ec4e                	sd	s3,24(sp)
ffffffffc02007d4:	e852                	sd	s4,16(sp)
ffffffffc02007d6:	e456                	sd	s5,8(sp)
ffffffffc02007d8:	8dfff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02007dc:	00004517          	auipc	a0,0x4
ffffffffc02007e0:	b9c50513          	addi	a0,a0,-1124 # ffffffffc0204378 <etext+0x70a>
ffffffffc02007e4:	8d3ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02007e8:	47c1                	li	a5,16
ffffffffc02007ea:	6b0d                	lui	s6,0x3
ffffffffc02007ec:	00fb0023          	sb	a5,0(s6) # 3000 <kern_entry-0xffffffffc01fd000>
ffffffffc02007f0:	00010917          	auipc	s2,0x10
ffffffffc02007f4:	87092903          	lw	s2,-1936(s2) # ffffffffc0210060 <pgfault_num>
ffffffffc02007f8:	4791                	li	a5,4
ffffffffc02007fa:	16f91463          	bne	s2,a5,ffffffffc0200962 <_lru_check_swap+0x1a4>
ffffffffc02007fe:	00004517          	auipc	a0,0x4
ffffffffc0200802:	bea50513          	addi	a0,a0,-1046 # ffffffffc02043e8 <etext+0x77a>
ffffffffc0200806:	8b1ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020080a:	6a05                	lui	s4,0x1
ffffffffc020080c:	47c5                	li	a5,17
ffffffffc020080e:	00010417          	auipc	s0,0x10
ffffffffc0200812:	85240413          	addi	s0,s0,-1966 # ffffffffc0210060 <pgfault_num>
ffffffffc0200816:	00fa0023          	sb	a5,0(s4) # 1000 <kern_entry-0xffffffffc01ff000>
ffffffffc020081a:	4004                	lw	s1,0(s0)
ffffffffc020081c:	2481                	sext.w	s1,s1
ffffffffc020081e:	2b249263          	bne	s1,s2,ffffffffc0200ac2 <_lru_check_swap+0x304>
ffffffffc0200822:	00004517          	auipc	a0,0x4
ffffffffc0200826:	bee50513          	addi	a0,a0,-1042 # ffffffffc0204410 <etext+0x7a2>
ffffffffc020082a:	88dff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020082e:	6991                	lui	s3,0x4
ffffffffc0200830:	47c9                	li	a5,18
ffffffffc0200832:	00f98023          	sb	a5,0(s3) # 4000 <kern_entry-0xffffffffc01fc000>
ffffffffc0200836:	00042903          	lw	s2,0(s0)
ffffffffc020083a:	2901                	sext.w	s2,s2
ffffffffc020083c:	26991363          	bne	s2,s1,ffffffffc0200aa2 <_lru_check_swap+0x2e4>
ffffffffc0200840:	00004517          	auipc	a0,0x4
ffffffffc0200844:	bf850513          	addi	a0,a0,-1032 # ffffffffc0204438 <etext+0x7ca>
ffffffffc0200848:	86fff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020084c:	6789                	lui	a5,0x2
ffffffffc020084e:	474d                	li	a4,19
ffffffffc0200850:	00e78023          	sb	a4,0(a5) # 2000 <kern_entry-0xffffffffc01fe000>
ffffffffc0200854:	401c                	lw	a5,0(s0)
ffffffffc0200856:	2781                	sext.w	a5,a5
ffffffffc0200858:	23279563          	bne	a5,s2,ffffffffc0200a82 <_lru_check_swap+0x2c4>
ffffffffc020085c:	00004517          	auipc	a0,0x4
ffffffffc0200860:	c0450513          	addi	a0,a0,-1020 # ffffffffc0204460 <etext+0x7f2>
ffffffffc0200864:	853ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200868:	47d1                	li	a5,20
ffffffffc020086a:	6a95                	lui	s5,0x5
ffffffffc020086c:	00fa8023          	sb	a5,0(s5) # 5000 <kern_entry-0xffffffffc01fb000>
ffffffffc0200870:	401c                	lw	a5,0(s0)
ffffffffc0200872:	4715                	li	a4,5
ffffffffc0200874:	2781                	sext.w	a5,a5
ffffffffc0200876:	1ee79663          	bne	a5,a4,ffffffffc0200a62 <_lru_check_swap+0x2a4>
ffffffffc020087a:	00004517          	auipc	a0,0x4
ffffffffc020087e:	afe50513          	addi	a0,a0,-1282 # ffffffffc0204378 <etext+0x70a>
ffffffffc0200882:	835ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200886:	47d5                	li	a5,21
ffffffffc0200888:	00fb0023          	sb	a5,0(s6)
ffffffffc020088c:	401c                	lw	a5,0(s0)
ffffffffc020088e:	4719                	li	a4,6
ffffffffc0200890:	2781                	sext.w	a5,a5
ffffffffc0200892:	1ae79863          	bne	a5,a4,ffffffffc0200a42 <_lru_check_swap+0x284>
ffffffffc0200896:	00004517          	auipc	a0,0x4
ffffffffc020089a:	b5250513          	addi	a0,a0,-1198 # ffffffffc02043e8 <etext+0x77a>
ffffffffc020089e:	819ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02008a2:	47d9                	li	a5,22
ffffffffc02008a4:	00fa0023          	sb	a5,0(s4)
ffffffffc02008a8:	401c                	lw	a5,0(s0)
ffffffffc02008aa:	471d                	li	a4,7
ffffffffc02008ac:	2781                	sext.w	a5,a5
ffffffffc02008ae:	16e79a63          	bne	a5,a4,ffffffffc0200a22 <_lru_check_swap+0x264>
ffffffffc02008b2:	00004517          	auipc	a0,0x4
ffffffffc02008b6:	b5e50513          	addi	a0,a0,-1186 # ffffffffc0204410 <etext+0x7a2>
ffffffffc02008ba:	ffcff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02008be:	47dd                	li	a5,23
ffffffffc02008c0:	00f98023          	sb	a5,0(s3)
ffffffffc02008c4:	4004                	lw	s1,0(s0)
ffffffffc02008c6:	47a1                	li	a5,8
ffffffffc02008c8:	2481                	sext.w	s1,s1
ffffffffc02008ca:	12f49c63          	bne	s1,a5,ffffffffc0200a02 <_lru_check_swap+0x244>
ffffffffc02008ce:	00004517          	auipc	a0,0x4
ffffffffc02008d2:	b4250513          	addi	a0,a0,-1214 # ffffffffc0204410 <etext+0x7a2>
ffffffffc02008d6:	fe0ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02008da:	47e1                	li	a5,24
ffffffffc02008dc:	00f98023          	sb	a5,0(s3)
ffffffffc02008e0:	00042903          	lw	s2,0(s0)
ffffffffc02008e4:	2901                	sext.w	s2,s2
ffffffffc02008e6:	0e991e63          	bne	s2,s1,ffffffffc02009e2 <_lru_check_swap+0x224>
ffffffffc02008ea:	00004517          	auipc	a0,0x4
ffffffffc02008ee:	b7650513          	addi	a0,a0,-1162 # ffffffffc0204460 <etext+0x7f2>
ffffffffc02008f2:	fc4ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02008f6:	47e5                	li	a5,25
ffffffffc02008f8:	00fa8023          	sb	a5,0(s5)
ffffffffc02008fc:	401c                	lw	a5,0(s0)
ffffffffc02008fe:	2781                	sext.w	a5,a5
ffffffffc0200900:	0d279163          	bne	a5,s2,ffffffffc02009c2 <_lru_check_swap+0x204>
ffffffffc0200904:	00004517          	auipc	a0,0x4
ffffffffc0200908:	b3450513          	addi	a0,a0,-1228 # ffffffffc0204438 <etext+0x7ca>
ffffffffc020090c:	faaff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200910:	6789                	lui	a5,0x2
ffffffffc0200912:	4769                	li	a4,26
ffffffffc0200914:	00e78023          	sb	a4,0(a5) # 2000 <kern_entry-0xffffffffc01fe000>
ffffffffc0200918:	401c                	lw	a5,0(s0)
ffffffffc020091a:	4725                	li	a4,9
ffffffffc020091c:	2781                	sext.w	a5,a5
ffffffffc020091e:	08e79263          	bne	a5,a4,ffffffffc02009a2 <_lru_check_swap+0x1e4>
ffffffffc0200922:	00004517          	auipc	a0,0x4
ffffffffc0200926:	a5650513          	addi	a0,a0,-1450 # ffffffffc0204378 <etext+0x70a>
ffffffffc020092a:	f8cff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020092e:	678d                	lui	a5,0x3
ffffffffc0200930:	476d                	li	a4,27
ffffffffc0200932:	00e78023          	sb	a4,0(a5) # 3000 <kern_entry-0xffffffffc01fd000>
ffffffffc0200936:	401c                	lw	a5,0(s0)
ffffffffc0200938:	4729                	li	a4,10
ffffffffc020093a:	2781                	sext.w	a5,a5
ffffffffc020093c:	04e79363          	bne	a5,a4,ffffffffc0200982 <_lru_check_swap+0x1c4>
ffffffffc0200940:	00004517          	auipc	a0,0x4
ffffffffc0200944:	bd850513          	addi	a0,a0,-1064 # ffffffffc0204518 <etext+0x8aa>
ffffffffc0200948:	f6eff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020094c:	70e2                	ld	ra,56(sp)
ffffffffc020094e:	7442                	ld	s0,48(sp)
ffffffffc0200950:	74a2                	ld	s1,40(sp)
ffffffffc0200952:	7902                	ld	s2,32(sp)
ffffffffc0200954:	69e2                	ld	s3,24(sp)
ffffffffc0200956:	6a42                	ld	s4,16(sp)
ffffffffc0200958:	6aa2                	ld	s5,8(sp)
ffffffffc020095a:	6b02                	ld	s6,0(sp)
ffffffffc020095c:	4501                	li	a0,0
ffffffffc020095e:	6121                	addi	sp,sp,64
ffffffffc0200960:	8082                	ret
ffffffffc0200962:	00004697          	auipc	a3,0x4
ffffffffc0200966:	a3e68693          	addi	a3,a3,-1474 # ffffffffc02043a0 <etext+0x732>
ffffffffc020096a:	00004617          	auipc	a2,0x4
ffffffffc020096e:	a4e60613          	addi	a2,a2,-1458 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0200972:	04d00593          	li	a1,77
ffffffffc0200976:	00004517          	auipc	a0,0x4
ffffffffc020097a:	a5a50513          	addi	a0,a0,-1446 # ffffffffc02043d0 <etext+0x762>
ffffffffc020097e:	f6eff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0200982:	00004697          	auipc	a3,0x4
ffffffffc0200986:	b7e68693          	addi	a3,a3,-1154 # ffffffffc0204500 <etext+0x892>
ffffffffc020098a:	00004617          	auipc	a2,0x4
ffffffffc020098e:	a2e60613          	addi	a2,a2,-1490 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0200992:	07900593          	li	a1,121
ffffffffc0200996:	00004517          	auipc	a0,0x4
ffffffffc020099a:	a3a50513          	addi	a0,a0,-1478 # ffffffffc02043d0 <etext+0x762>
ffffffffc020099e:	f4eff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02009a2:	00004697          	auipc	a3,0x4
ffffffffc02009a6:	b4668693          	addi	a3,a3,-1210 # ffffffffc02044e8 <etext+0x87a>
ffffffffc02009aa:	00004617          	auipc	a2,0x4
ffffffffc02009ae:	a0e60613          	addi	a2,a2,-1522 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02009b2:	07500593          	li	a1,117
ffffffffc02009b6:	00004517          	auipc	a0,0x4
ffffffffc02009ba:	a1a50513          	addi	a0,a0,-1510 # ffffffffc02043d0 <etext+0x762>
ffffffffc02009be:	f2eff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02009c2:	00004697          	auipc	a3,0x4
ffffffffc02009c6:	b0e68693          	addi	a3,a3,-1266 # ffffffffc02044d0 <etext+0x862>
ffffffffc02009ca:	00004617          	auipc	a2,0x4
ffffffffc02009ce:	9ee60613          	addi	a2,a2,-1554 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02009d2:	07100593          	li	a1,113
ffffffffc02009d6:	00004517          	auipc	a0,0x4
ffffffffc02009da:	9fa50513          	addi	a0,a0,-1542 # ffffffffc02043d0 <etext+0x762>
ffffffffc02009de:	f0eff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02009e2:	00004697          	auipc	a3,0x4
ffffffffc02009e6:	aee68693          	addi	a3,a3,-1298 # ffffffffc02044d0 <etext+0x862>
ffffffffc02009ea:	00004617          	auipc	a2,0x4
ffffffffc02009ee:	9ce60613          	addi	a2,a2,-1586 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02009f2:	06d00593          	li	a1,109
ffffffffc02009f6:	00004517          	auipc	a0,0x4
ffffffffc02009fa:	9da50513          	addi	a0,a0,-1574 # ffffffffc02043d0 <etext+0x762>
ffffffffc02009fe:	eeeff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0200a02:	00004697          	auipc	a3,0x4
ffffffffc0200a06:	ace68693          	addi	a3,a3,-1330 # ffffffffc02044d0 <etext+0x862>
ffffffffc0200a0a:	00004617          	auipc	a2,0x4
ffffffffc0200a0e:	9ae60613          	addi	a2,a2,-1618 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0200a12:	06900593          	li	a1,105
ffffffffc0200a16:	00004517          	auipc	a0,0x4
ffffffffc0200a1a:	9ba50513          	addi	a0,a0,-1606 # ffffffffc02043d0 <etext+0x762>
ffffffffc0200a1e:	eceff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0200a22:	00004697          	auipc	a3,0x4
ffffffffc0200a26:	a9668693          	addi	a3,a3,-1386 # ffffffffc02044b8 <etext+0x84a>
ffffffffc0200a2a:	00004617          	auipc	a2,0x4
ffffffffc0200a2e:	98e60613          	addi	a2,a2,-1650 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0200a32:	06500593          	li	a1,101
ffffffffc0200a36:	00004517          	auipc	a0,0x4
ffffffffc0200a3a:	99a50513          	addi	a0,a0,-1638 # ffffffffc02043d0 <etext+0x762>
ffffffffc0200a3e:	eaeff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0200a42:	00004697          	auipc	a3,0x4
ffffffffc0200a46:	a5e68693          	addi	a3,a3,-1442 # ffffffffc02044a0 <etext+0x832>
ffffffffc0200a4a:	00004617          	auipc	a2,0x4
ffffffffc0200a4e:	96e60613          	addi	a2,a2,-1682 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0200a52:	06100593          	li	a1,97
ffffffffc0200a56:	00004517          	auipc	a0,0x4
ffffffffc0200a5a:	97a50513          	addi	a0,a0,-1670 # ffffffffc02043d0 <etext+0x762>
ffffffffc0200a5e:	e8eff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0200a62:	00004697          	auipc	a3,0x4
ffffffffc0200a66:	a2668693          	addi	a3,a3,-1498 # ffffffffc0204488 <etext+0x81a>
ffffffffc0200a6a:	00004617          	auipc	a2,0x4
ffffffffc0200a6e:	94e60613          	addi	a2,a2,-1714 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0200a72:	05d00593          	li	a1,93
ffffffffc0200a76:	00004517          	auipc	a0,0x4
ffffffffc0200a7a:	95a50513          	addi	a0,a0,-1702 # ffffffffc02043d0 <etext+0x762>
ffffffffc0200a7e:	e6eff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0200a82:	00004697          	auipc	a3,0x4
ffffffffc0200a86:	91e68693          	addi	a3,a3,-1762 # ffffffffc02043a0 <etext+0x732>
ffffffffc0200a8a:	00004617          	auipc	a2,0x4
ffffffffc0200a8e:	92e60613          	addi	a2,a2,-1746 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0200a92:	05900593          	li	a1,89
ffffffffc0200a96:	00004517          	auipc	a0,0x4
ffffffffc0200a9a:	93a50513          	addi	a0,a0,-1734 # ffffffffc02043d0 <etext+0x762>
ffffffffc0200a9e:	e4eff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0200aa2:	00004697          	auipc	a3,0x4
ffffffffc0200aa6:	8fe68693          	addi	a3,a3,-1794 # ffffffffc02043a0 <etext+0x732>
ffffffffc0200aaa:	00004617          	auipc	a2,0x4
ffffffffc0200aae:	90e60613          	addi	a2,a2,-1778 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0200ab2:	05500593          	li	a1,85
ffffffffc0200ab6:	00004517          	auipc	a0,0x4
ffffffffc0200aba:	91a50513          	addi	a0,a0,-1766 # ffffffffc02043d0 <etext+0x762>
ffffffffc0200abe:	e2eff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0200ac2:	00004697          	auipc	a3,0x4
ffffffffc0200ac6:	8de68693          	addi	a3,a3,-1826 # ffffffffc02043a0 <etext+0x732>
ffffffffc0200aca:	00004617          	auipc	a2,0x4
ffffffffc0200ace:	8ee60613          	addi	a2,a2,-1810 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0200ad2:	05100593          	li	a1,81
ffffffffc0200ad6:	00004517          	auipc	a0,0x4
ffffffffc0200ada:	8fa50513          	addi	a0,a0,-1798 # ffffffffc02043d0 <etext+0x762>
ffffffffc0200ade:	e0eff0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0200ae2 <_lru_swap_out_victim>:
ffffffffc0200ae2:	7508                	ld	a0,40(a0)
ffffffffc0200ae4:	c535                	beqz	a0,ffffffffc0200b50 <_lru_swap_out_victim+0x6e>
ffffffffc0200ae6:	e62d                	bnez	a2,ffffffffc0200b50 <_lru_swap_out_victim+0x6e>
ffffffffc0200ae8:	611c                	ld	a5,0(a0)
ffffffffc0200aea:	04f50f63          	beq	a0,a5,ffffffffc0200b48 <_lru_swap_out_victim+0x66>
ffffffffc0200aee:	6b98                	ld	a4,16(a5)
ffffffffc0200af0:	0000f817          	auipc	a6,0xf
ffffffffc0200af4:	5a080813          	addi	a6,a6,1440 # ffffffffc0210090 <curr_ptr>
ffffffffc0200af8:	00f83023          	sd	a5,0(a6)
ffffffffc0200afc:	fd078693          	addi	a3,a5,-48
ffffffffc0200b00:	e194                	sd	a3,0(a1)
ffffffffc0200b02:	00074603          	lbu	a2,0(a4)
ffffffffc0200b06:	88be                	mv	a7,a5
ffffffffc0200b08:	639c                	ld	a5,0(a5)
ffffffffc0200b0a:	00f83023          	sd	a5,0(a6)
ffffffffc0200b0e:	02f50163          	beq	a0,a5,ffffffffc0200b30 <_lru_swap_out_victim+0x4e>
ffffffffc0200b12:	6b98                	ld	a4,16(a5)
ffffffffc0200b14:	fd078693          	addi	a3,a5,-48
ffffffffc0200b18:	e194                	sd	a3,0(a1)
ffffffffc0200b1a:	00074703          	lbu	a4,0(a4)
ffffffffc0200b1e:	fec755e3          	bge	a4,a2,ffffffffc0200b08 <_lru_swap_out_victim+0x26>
ffffffffc0200b22:	88be                	mv	a7,a5
ffffffffc0200b24:	639c                	ld	a5,0(a5)
ffffffffc0200b26:	863a                	mv	a2,a4
ffffffffc0200b28:	00f83023          	sd	a5,0(a6)
ffffffffc0200b2c:	fef513e3          	bne	a0,a5,ffffffffc0200b12 <_lru_swap_out_victim+0x30>
ffffffffc0200b30:	0008b703          	ld	a4,0(a7)
ffffffffc0200b34:	0088b783          	ld	a5,8(a7)
ffffffffc0200b38:	fd088893          	addi	a7,a7,-48
ffffffffc0200b3c:	0115b023          	sd	a7,0(a1)
ffffffffc0200b40:	e71c                	sd	a5,8(a4)
ffffffffc0200b42:	e398                	sd	a4,0(a5)
ffffffffc0200b44:	4501                	li	a0,0
ffffffffc0200b46:	8082                	ret
ffffffffc0200b48:	0005b023          	sd	zero,0(a1)
ffffffffc0200b4c:	4501                	li	a0,0
ffffffffc0200b4e:	8082                	ret
ffffffffc0200b50:	1141                	addi	sp,sp,-16
ffffffffc0200b52:	00004697          	auipc	a3,0x4
ffffffffc0200b56:	9de68693          	addi	a3,a3,-1570 # ffffffffc0204530 <etext+0x8c2>
ffffffffc0200b5a:	00004617          	auipc	a2,0x4
ffffffffc0200b5e:	85e60613          	addi	a2,a2,-1954 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0200b62:	02400593          	li	a1,36
ffffffffc0200b66:	00004517          	auipc	a0,0x4
ffffffffc0200b6a:	86a50513          	addi	a0,a0,-1942 # ffffffffc02043d0 <etext+0x762>
ffffffffc0200b6e:	e406                	sd	ra,8(sp)
ffffffffc0200b70:	d7cff0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0200b74 <_lru_map_swappable>:
ffffffffc0200b74:	751c                	ld	a5,40(a0)
ffffffffc0200b76:	cb91                	beqz	a5,ffffffffc0200b8a <_lru_map_swappable+0x16>
ffffffffc0200b78:	6794                	ld	a3,8(a5)
ffffffffc0200b7a:	03060713          	addi	a4,a2,48
ffffffffc0200b7e:	4501                	li	a0,0
ffffffffc0200b80:	e298                	sd	a4,0(a3)
ffffffffc0200b82:	e798                	sd	a4,8(a5)
ffffffffc0200b84:	fe14                	sd	a3,56(a2)
ffffffffc0200b86:	fa1c                	sd	a5,48(a2)
ffffffffc0200b88:	8082                	ret
ffffffffc0200b8a:	1141                	addi	sp,sp,-16
ffffffffc0200b8c:	00004697          	auipc	a3,0x4
ffffffffc0200b90:	9c468693          	addi	a3,a3,-1596 # ffffffffc0204550 <etext+0x8e2>
ffffffffc0200b94:	00004617          	auipc	a2,0x4
ffffffffc0200b98:	82460613          	addi	a2,a2,-2012 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0200b9c:	45ed                	li	a1,27
ffffffffc0200b9e:	00004517          	auipc	a0,0x4
ffffffffc0200ba2:	83250513          	addi	a0,a0,-1998 # ffffffffc02043d0 <etext+0x762>
ffffffffc0200ba6:	e406                	sd	ra,8(sp)
ffffffffc0200ba8:	d44ff0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0200bac <pa2page.part.0>:
ffffffffc0200bac:	1141                	addi	sp,sp,-16
ffffffffc0200bae:	00004617          	auipc	a2,0x4
ffffffffc0200bb2:	9da60613          	addi	a2,a2,-1574 # ffffffffc0204588 <etext+0x91a>
ffffffffc0200bb6:	06500593          	li	a1,101
ffffffffc0200bba:	00004517          	auipc	a0,0x4
ffffffffc0200bbe:	9ee50513          	addi	a0,a0,-1554 # ffffffffc02045a8 <etext+0x93a>
ffffffffc0200bc2:	e406                	sd	ra,8(sp)
ffffffffc0200bc4:	d28ff0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0200bc8 <alloc_pages>:
ffffffffc0200bc8:	7139                	addi	sp,sp,-64
ffffffffc0200bca:	f426                	sd	s1,40(sp)
ffffffffc0200bcc:	f04a                	sd	s2,32(sp)
ffffffffc0200bce:	ec4e                	sd	s3,24(sp)
ffffffffc0200bd0:	e852                	sd	s4,16(sp)
ffffffffc0200bd2:	e456                	sd	s5,8(sp)
ffffffffc0200bd4:	e05a                	sd	s6,0(sp)
ffffffffc0200bd6:	fc06                	sd	ra,56(sp)
ffffffffc0200bd8:	f822                	sd	s0,48(sp)
ffffffffc0200bda:	84aa                	mv	s1,a0
ffffffffc0200bdc:	0000f917          	auipc	s2,0xf
ffffffffc0200be0:	4bc90913          	addi	s2,s2,1212 # ffffffffc0210098 <pmm_manager>
ffffffffc0200be4:	4a05                	li	s4,1
ffffffffc0200be6:	0000fa97          	auipc	s5,0xf
ffffffffc0200bea:	48aa8a93          	addi	s5,s5,1162 # ffffffffc0210070 <swap_init_ok>
ffffffffc0200bee:	0005099b          	sext.w	s3,a0
ffffffffc0200bf2:	0000fb17          	auipc	s6,0xf
ffffffffc0200bf6:	4c6b0b13          	addi	s6,s6,1222 # ffffffffc02100b8 <check_mm_struct>
ffffffffc0200bfa:	a01d                	j	ffffffffc0200c20 <alloc_pages+0x58>
ffffffffc0200bfc:	00093783          	ld	a5,0(s2)
ffffffffc0200c00:	6f9c                	ld	a5,24(a5)
ffffffffc0200c02:	9782                	jalr	a5
ffffffffc0200c04:	842a                	mv	s0,a0
ffffffffc0200c06:	4601                	li	a2,0
ffffffffc0200c08:	85ce                	mv	a1,s3
ffffffffc0200c0a:	ec0d                	bnez	s0,ffffffffc0200c44 <alloc_pages+0x7c>
ffffffffc0200c0c:	029a6c63          	bltu	s4,s1,ffffffffc0200c44 <alloc_pages+0x7c>
ffffffffc0200c10:	000aa783          	lw	a5,0(s5)
ffffffffc0200c14:	2781                	sext.w	a5,a5
ffffffffc0200c16:	c79d                	beqz	a5,ffffffffc0200c44 <alloc_pages+0x7c>
ffffffffc0200c18:	000b3503          	ld	a0,0(s6)
ffffffffc0200c1c:	607010ef          	jal	ra,ffffffffc0202a22 <swap_out>
ffffffffc0200c20:	100027f3          	csrr	a5,sstatus
ffffffffc0200c24:	8b89                	andi	a5,a5,2
ffffffffc0200c26:	8526                	mv	a0,s1
ffffffffc0200c28:	dbf1                	beqz	a5,ffffffffc0200bfc <alloc_pages+0x34>
ffffffffc0200c2a:	dcaff0ef          	jal	ra,ffffffffc02001f4 <intr_disable>
ffffffffc0200c2e:	00093783          	ld	a5,0(s2)
ffffffffc0200c32:	8526                	mv	a0,s1
ffffffffc0200c34:	6f9c                	ld	a5,24(a5)
ffffffffc0200c36:	9782                	jalr	a5
ffffffffc0200c38:	842a                	mv	s0,a0
ffffffffc0200c3a:	db4ff0ef          	jal	ra,ffffffffc02001ee <intr_enable>
ffffffffc0200c3e:	4601                	li	a2,0
ffffffffc0200c40:	85ce                	mv	a1,s3
ffffffffc0200c42:	d469                	beqz	s0,ffffffffc0200c0c <alloc_pages+0x44>
ffffffffc0200c44:	70e2                	ld	ra,56(sp)
ffffffffc0200c46:	8522                	mv	a0,s0
ffffffffc0200c48:	7442                	ld	s0,48(sp)
ffffffffc0200c4a:	74a2                	ld	s1,40(sp)
ffffffffc0200c4c:	7902                	ld	s2,32(sp)
ffffffffc0200c4e:	69e2                	ld	s3,24(sp)
ffffffffc0200c50:	6a42                	ld	s4,16(sp)
ffffffffc0200c52:	6aa2                	ld	s5,8(sp)
ffffffffc0200c54:	6b02                	ld	s6,0(sp)
ffffffffc0200c56:	6121                	addi	sp,sp,64
ffffffffc0200c58:	8082                	ret

ffffffffc0200c5a <free_pages>:
ffffffffc0200c5a:	100027f3          	csrr	a5,sstatus
ffffffffc0200c5e:	8b89                	andi	a5,a5,2
ffffffffc0200c60:	eb81                	bnez	a5,ffffffffc0200c70 <free_pages+0x16>
ffffffffc0200c62:	0000f797          	auipc	a5,0xf
ffffffffc0200c66:	4367b783          	ld	a5,1078(a5) # ffffffffc0210098 <pmm_manager>
ffffffffc0200c6a:	0207b303          	ld	t1,32(a5)
ffffffffc0200c6e:	8302                	jr	t1
ffffffffc0200c70:	1101                	addi	sp,sp,-32
ffffffffc0200c72:	ec06                	sd	ra,24(sp)
ffffffffc0200c74:	e822                	sd	s0,16(sp)
ffffffffc0200c76:	e426                	sd	s1,8(sp)
ffffffffc0200c78:	842a                	mv	s0,a0
ffffffffc0200c7a:	84ae                	mv	s1,a1
ffffffffc0200c7c:	d78ff0ef          	jal	ra,ffffffffc02001f4 <intr_disable>
ffffffffc0200c80:	0000f797          	auipc	a5,0xf
ffffffffc0200c84:	4187b783          	ld	a5,1048(a5) # ffffffffc0210098 <pmm_manager>
ffffffffc0200c88:	739c                	ld	a5,32(a5)
ffffffffc0200c8a:	85a6                	mv	a1,s1
ffffffffc0200c8c:	8522                	mv	a0,s0
ffffffffc0200c8e:	9782                	jalr	a5
ffffffffc0200c90:	6442                	ld	s0,16(sp)
ffffffffc0200c92:	60e2                	ld	ra,24(sp)
ffffffffc0200c94:	64a2                	ld	s1,8(sp)
ffffffffc0200c96:	6105                	addi	sp,sp,32
ffffffffc0200c98:	d56ff06f          	j	ffffffffc02001ee <intr_enable>

ffffffffc0200c9c <nr_free_pages>:
ffffffffc0200c9c:	100027f3          	csrr	a5,sstatus
ffffffffc0200ca0:	8b89                	andi	a5,a5,2
ffffffffc0200ca2:	eb81                	bnez	a5,ffffffffc0200cb2 <nr_free_pages+0x16>
ffffffffc0200ca4:	0000f797          	auipc	a5,0xf
ffffffffc0200ca8:	3f47b783          	ld	a5,1012(a5) # ffffffffc0210098 <pmm_manager>
ffffffffc0200cac:	0287b303          	ld	t1,40(a5)
ffffffffc0200cb0:	8302                	jr	t1
ffffffffc0200cb2:	1141                	addi	sp,sp,-16
ffffffffc0200cb4:	e406                	sd	ra,8(sp)
ffffffffc0200cb6:	e022                	sd	s0,0(sp)
ffffffffc0200cb8:	d3cff0ef          	jal	ra,ffffffffc02001f4 <intr_disable>
ffffffffc0200cbc:	0000f797          	auipc	a5,0xf
ffffffffc0200cc0:	3dc7b783          	ld	a5,988(a5) # ffffffffc0210098 <pmm_manager>
ffffffffc0200cc4:	779c                	ld	a5,40(a5)
ffffffffc0200cc6:	9782                	jalr	a5
ffffffffc0200cc8:	842a                	mv	s0,a0
ffffffffc0200cca:	d24ff0ef          	jal	ra,ffffffffc02001ee <intr_enable>
ffffffffc0200cce:	60a2                	ld	ra,8(sp)
ffffffffc0200cd0:	8522                	mv	a0,s0
ffffffffc0200cd2:	6402                	ld	s0,0(sp)
ffffffffc0200cd4:	0141                	addi	sp,sp,16
ffffffffc0200cd6:	8082                	ret

ffffffffc0200cd8 <get_pte>:
ffffffffc0200cd8:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0200cdc:	1ff7f793          	andi	a5,a5,511
ffffffffc0200ce0:	715d                	addi	sp,sp,-80
ffffffffc0200ce2:	078e                	slli	a5,a5,0x3
ffffffffc0200ce4:	fc26                	sd	s1,56(sp)
ffffffffc0200ce6:	00f504b3          	add	s1,a0,a5
ffffffffc0200cea:	6094                	ld	a3,0(s1)
ffffffffc0200cec:	f84a                	sd	s2,48(sp)
ffffffffc0200cee:	f44e                	sd	s3,40(sp)
ffffffffc0200cf0:	f052                	sd	s4,32(sp)
ffffffffc0200cf2:	e486                	sd	ra,72(sp)
ffffffffc0200cf4:	e0a2                	sd	s0,64(sp)
ffffffffc0200cf6:	ec56                	sd	s5,24(sp)
ffffffffc0200cf8:	e85a                	sd	s6,16(sp)
ffffffffc0200cfa:	e45e                	sd	s7,8(sp)
ffffffffc0200cfc:	0016f793          	andi	a5,a3,1
ffffffffc0200d00:	892e                	mv	s2,a1
ffffffffc0200d02:	8a32                	mv	s4,a2
ffffffffc0200d04:	0000f997          	auipc	s3,0xf
ffffffffc0200d08:	35498993          	addi	s3,s3,852 # ffffffffc0210058 <npage>
ffffffffc0200d0c:	efb5                	bnez	a5,ffffffffc0200d88 <get_pte+0xb0>
ffffffffc0200d0e:	14060c63          	beqz	a2,ffffffffc0200e66 <get_pte+0x18e>
ffffffffc0200d12:	4505                	li	a0,1
ffffffffc0200d14:	eb5ff0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0200d18:	842a                	mv	s0,a0
ffffffffc0200d1a:	14050663          	beqz	a0,ffffffffc0200e66 <get_pte+0x18e>
ffffffffc0200d1e:	0000fb97          	auipc	s7,0xf
ffffffffc0200d22:	392b8b93          	addi	s7,s7,914 # ffffffffc02100b0 <pages>
ffffffffc0200d26:	000bb503          	ld	a0,0(s7)
ffffffffc0200d2a:	00005b17          	auipc	s6,0x5
ffffffffc0200d2e:	b9eb3b03          	ld	s6,-1122(s6) # ffffffffc02058c8 <error_string+0x38>
ffffffffc0200d32:	00080ab7          	lui	s5,0x80
ffffffffc0200d36:	40a40533          	sub	a0,s0,a0
ffffffffc0200d3a:	850d                	srai	a0,a0,0x3
ffffffffc0200d3c:	03650533          	mul	a0,a0,s6
ffffffffc0200d40:	0000f997          	auipc	s3,0xf
ffffffffc0200d44:	31898993          	addi	s3,s3,792 # ffffffffc0210058 <npage>
ffffffffc0200d48:	4785                	li	a5,1
ffffffffc0200d4a:	0009b703          	ld	a4,0(s3)
ffffffffc0200d4e:	c01c                	sw	a5,0(s0)
ffffffffc0200d50:	9556                	add	a0,a0,s5
ffffffffc0200d52:	00c51793          	slli	a5,a0,0xc
ffffffffc0200d56:	83b1                	srli	a5,a5,0xc
ffffffffc0200d58:	0532                	slli	a0,a0,0xc
ffffffffc0200d5a:	14e7fd63          	bgeu	a5,a4,ffffffffc0200eb4 <get_pte+0x1dc>
ffffffffc0200d5e:	0000f797          	auipc	a5,0xf
ffffffffc0200d62:	34a7b783          	ld	a5,842(a5) # ffffffffc02100a8 <va_pa_offset>
ffffffffc0200d66:	6605                	lui	a2,0x1
ffffffffc0200d68:	4581                	li	a1,0
ffffffffc0200d6a:	953e                	add	a0,a0,a5
ffffffffc0200d6c:	2eb020ef          	jal	ra,ffffffffc0203856 <memset>
ffffffffc0200d70:	000bb683          	ld	a3,0(s7)
ffffffffc0200d74:	40d406b3          	sub	a3,s0,a3
ffffffffc0200d78:	868d                	srai	a3,a3,0x3
ffffffffc0200d7a:	036686b3          	mul	a3,a3,s6
ffffffffc0200d7e:	96d6                	add	a3,a3,s5
ffffffffc0200d80:	06aa                	slli	a3,a3,0xa
ffffffffc0200d82:	0116e693          	ori	a3,a3,17
ffffffffc0200d86:	e094                	sd	a3,0(s1)
ffffffffc0200d88:	77fd                	lui	a5,0xfffff
ffffffffc0200d8a:	068a                	slli	a3,a3,0x2
ffffffffc0200d8c:	0009b703          	ld	a4,0(s3)
ffffffffc0200d90:	8efd                	and	a3,a3,a5
ffffffffc0200d92:	00c6d793          	srli	a5,a3,0xc
ffffffffc0200d96:	0ce7fa63          	bgeu	a5,a4,ffffffffc0200e6a <get_pte+0x192>
ffffffffc0200d9a:	0000fa97          	auipc	s5,0xf
ffffffffc0200d9e:	30ea8a93          	addi	s5,s5,782 # ffffffffc02100a8 <va_pa_offset>
ffffffffc0200da2:	000ab403          	ld	s0,0(s5)
ffffffffc0200da6:	01595793          	srli	a5,s2,0x15
ffffffffc0200daa:	1ff7f793          	andi	a5,a5,511
ffffffffc0200dae:	96a2                	add	a3,a3,s0
ffffffffc0200db0:	00379413          	slli	s0,a5,0x3
ffffffffc0200db4:	9436                	add	s0,s0,a3
ffffffffc0200db6:	6014                	ld	a3,0(s0)
ffffffffc0200db8:	0016f793          	andi	a5,a3,1
ffffffffc0200dbc:	ebad                	bnez	a5,ffffffffc0200e2e <get_pte+0x156>
ffffffffc0200dbe:	0a0a0463          	beqz	s4,ffffffffc0200e66 <get_pte+0x18e>
ffffffffc0200dc2:	4505                	li	a0,1
ffffffffc0200dc4:	e05ff0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0200dc8:	84aa                	mv	s1,a0
ffffffffc0200dca:	cd51                	beqz	a0,ffffffffc0200e66 <get_pte+0x18e>
ffffffffc0200dcc:	0000fb97          	auipc	s7,0xf
ffffffffc0200dd0:	2e4b8b93          	addi	s7,s7,740 # ffffffffc02100b0 <pages>
ffffffffc0200dd4:	000bb503          	ld	a0,0(s7)
ffffffffc0200dd8:	00005b17          	auipc	s6,0x5
ffffffffc0200ddc:	af0b3b03          	ld	s6,-1296(s6) # ffffffffc02058c8 <error_string+0x38>
ffffffffc0200de0:	00080a37          	lui	s4,0x80
ffffffffc0200de4:	40a48533          	sub	a0,s1,a0
ffffffffc0200de8:	850d                	srai	a0,a0,0x3
ffffffffc0200dea:	03650533          	mul	a0,a0,s6
ffffffffc0200dee:	4785                	li	a5,1
ffffffffc0200df0:	0009b703          	ld	a4,0(s3)
ffffffffc0200df4:	c09c                	sw	a5,0(s1)
ffffffffc0200df6:	9552                	add	a0,a0,s4
ffffffffc0200df8:	00c51793          	slli	a5,a0,0xc
ffffffffc0200dfc:	83b1                	srli	a5,a5,0xc
ffffffffc0200dfe:	0532                	slli	a0,a0,0xc
ffffffffc0200e00:	08e7fd63          	bgeu	a5,a4,ffffffffc0200e9a <get_pte+0x1c2>
ffffffffc0200e04:	000ab783          	ld	a5,0(s5)
ffffffffc0200e08:	6605                	lui	a2,0x1
ffffffffc0200e0a:	4581                	li	a1,0
ffffffffc0200e0c:	953e                	add	a0,a0,a5
ffffffffc0200e0e:	249020ef          	jal	ra,ffffffffc0203856 <memset>
ffffffffc0200e12:	000bb683          	ld	a3,0(s7)
ffffffffc0200e16:	40d486b3          	sub	a3,s1,a3
ffffffffc0200e1a:	868d                	srai	a3,a3,0x3
ffffffffc0200e1c:	036686b3          	mul	a3,a3,s6
ffffffffc0200e20:	96d2                	add	a3,a3,s4
ffffffffc0200e22:	06aa                	slli	a3,a3,0xa
ffffffffc0200e24:	0116e693          	ori	a3,a3,17
ffffffffc0200e28:	e014                	sd	a3,0(s0)
ffffffffc0200e2a:	0009b703          	ld	a4,0(s3)
ffffffffc0200e2e:	068a                	slli	a3,a3,0x2
ffffffffc0200e30:	757d                	lui	a0,0xfffff
ffffffffc0200e32:	8ee9                	and	a3,a3,a0
ffffffffc0200e34:	00c6d793          	srli	a5,a3,0xc
ffffffffc0200e38:	04e7f563          	bgeu	a5,a4,ffffffffc0200e82 <get_pte+0x1aa>
ffffffffc0200e3c:	000ab503          	ld	a0,0(s5)
ffffffffc0200e40:	00c95913          	srli	s2,s2,0xc
ffffffffc0200e44:	1ff97913          	andi	s2,s2,511
ffffffffc0200e48:	96aa                	add	a3,a3,a0
ffffffffc0200e4a:	00391513          	slli	a0,s2,0x3
ffffffffc0200e4e:	9536                	add	a0,a0,a3
ffffffffc0200e50:	60a6                	ld	ra,72(sp)
ffffffffc0200e52:	6406                	ld	s0,64(sp)
ffffffffc0200e54:	74e2                	ld	s1,56(sp)
ffffffffc0200e56:	7942                	ld	s2,48(sp)
ffffffffc0200e58:	79a2                	ld	s3,40(sp)
ffffffffc0200e5a:	7a02                	ld	s4,32(sp)
ffffffffc0200e5c:	6ae2                	ld	s5,24(sp)
ffffffffc0200e5e:	6b42                	ld	s6,16(sp)
ffffffffc0200e60:	6ba2                	ld	s7,8(sp)
ffffffffc0200e62:	6161                	addi	sp,sp,80
ffffffffc0200e64:	8082                	ret
ffffffffc0200e66:	4501                	li	a0,0
ffffffffc0200e68:	b7e5                	j	ffffffffc0200e50 <get_pte+0x178>
ffffffffc0200e6a:	00003617          	auipc	a2,0x3
ffffffffc0200e6e:	74e60613          	addi	a2,a2,1870 # ffffffffc02045b8 <etext+0x94a>
ffffffffc0200e72:	0e800593          	li	a1,232
ffffffffc0200e76:	00003517          	auipc	a0,0x3
ffffffffc0200e7a:	76a50513          	addi	a0,a0,1898 # ffffffffc02045e0 <etext+0x972>
ffffffffc0200e7e:	a6eff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0200e82:	00003617          	auipc	a2,0x3
ffffffffc0200e86:	73660613          	addi	a2,a2,1846 # ffffffffc02045b8 <etext+0x94a>
ffffffffc0200e8a:	0f300593          	li	a1,243
ffffffffc0200e8e:	00003517          	auipc	a0,0x3
ffffffffc0200e92:	75250513          	addi	a0,a0,1874 # ffffffffc02045e0 <etext+0x972>
ffffffffc0200e96:	a56ff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0200e9a:	86aa                	mv	a3,a0
ffffffffc0200e9c:	00003617          	auipc	a2,0x3
ffffffffc0200ea0:	71c60613          	addi	a2,a2,1820 # ffffffffc02045b8 <etext+0x94a>
ffffffffc0200ea4:	0f000593          	li	a1,240
ffffffffc0200ea8:	00003517          	auipc	a0,0x3
ffffffffc0200eac:	73850513          	addi	a0,a0,1848 # ffffffffc02045e0 <etext+0x972>
ffffffffc0200eb0:	a3cff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0200eb4:	86aa                	mv	a3,a0
ffffffffc0200eb6:	00003617          	auipc	a2,0x3
ffffffffc0200eba:	70260613          	addi	a2,a2,1794 # ffffffffc02045b8 <etext+0x94a>
ffffffffc0200ebe:	0e500593          	li	a1,229
ffffffffc0200ec2:	00003517          	auipc	a0,0x3
ffffffffc0200ec6:	71e50513          	addi	a0,a0,1822 # ffffffffc02045e0 <etext+0x972>
ffffffffc0200eca:	a22ff0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0200ece <get_page>:
ffffffffc0200ece:	1141                	addi	sp,sp,-16
ffffffffc0200ed0:	e022                	sd	s0,0(sp)
ffffffffc0200ed2:	8432                	mv	s0,a2
ffffffffc0200ed4:	4601                	li	a2,0
ffffffffc0200ed6:	e406                	sd	ra,8(sp)
ffffffffc0200ed8:	e01ff0ef          	jal	ra,ffffffffc0200cd8 <get_pte>
ffffffffc0200edc:	c011                	beqz	s0,ffffffffc0200ee0 <get_page+0x12>
ffffffffc0200ede:	e008                	sd	a0,0(s0)
ffffffffc0200ee0:	c511                	beqz	a0,ffffffffc0200eec <get_page+0x1e>
ffffffffc0200ee2:	611c                	ld	a5,0(a0)
ffffffffc0200ee4:	4501                	li	a0,0
ffffffffc0200ee6:	0017f713          	andi	a4,a5,1
ffffffffc0200eea:	e709                	bnez	a4,ffffffffc0200ef4 <get_page+0x26>
ffffffffc0200eec:	60a2                	ld	ra,8(sp)
ffffffffc0200eee:	6402                	ld	s0,0(sp)
ffffffffc0200ef0:	0141                	addi	sp,sp,16
ffffffffc0200ef2:	8082                	ret
ffffffffc0200ef4:	078a                	slli	a5,a5,0x2
ffffffffc0200ef6:	83b1                	srli	a5,a5,0xc
ffffffffc0200ef8:	0000f717          	auipc	a4,0xf
ffffffffc0200efc:	16073703          	ld	a4,352(a4) # ffffffffc0210058 <npage>
ffffffffc0200f00:	02e7f263          	bgeu	a5,a4,ffffffffc0200f24 <get_page+0x56>
ffffffffc0200f04:	fff80537          	lui	a0,0xfff80
ffffffffc0200f08:	97aa                	add	a5,a5,a0
ffffffffc0200f0a:	60a2                	ld	ra,8(sp)
ffffffffc0200f0c:	6402                	ld	s0,0(sp)
ffffffffc0200f0e:	00379513          	slli	a0,a5,0x3
ffffffffc0200f12:	97aa                	add	a5,a5,a0
ffffffffc0200f14:	078e                	slli	a5,a5,0x3
ffffffffc0200f16:	0000f517          	auipc	a0,0xf
ffffffffc0200f1a:	19a53503          	ld	a0,410(a0) # ffffffffc02100b0 <pages>
ffffffffc0200f1e:	953e                	add	a0,a0,a5
ffffffffc0200f20:	0141                	addi	sp,sp,16
ffffffffc0200f22:	8082                	ret
ffffffffc0200f24:	c89ff0ef          	jal	ra,ffffffffc0200bac <pa2page.part.0>

ffffffffc0200f28 <page_remove>:
ffffffffc0200f28:	1141                	addi	sp,sp,-16
ffffffffc0200f2a:	4601                	li	a2,0
ffffffffc0200f2c:	e406                	sd	ra,8(sp)
ffffffffc0200f2e:	e022                	sd	s0,0(sp)
ffffffffc0200f30:	da9ff0ef          	jal	ra,ffffffffc0200cd8 <get_pte>
ffffffffc0200f34:	c511                	beqz	a0,ffffffffc0200f40 <page_remove+0x18>
ffffffffc0200f36:	611c                	ld	a5,0(a0)
ffffffffc0200f38:	842a                	mv	s0,a0
ffffffffc0200f3a:	0017f713          	andi	a4,a5,1
ffffffffc0200f3e:	e709                	bnez	a4,ffffffffc0200f48 <page_remove+0x20>
ffffffffc0200f40:	60a2                	ld	ra,8(sp)
ffffffffc0200f42:	6402                	ld	s0,0(sp)
ffffffffc0200f44:	0141                	addi	sp,sp,16
ffffffffc0200f46:	8082                	ret
ffffffffc0200f48:	078a                	slli	a5,a5,0x2
ffffffffc0200f4a:	83b1                	srli	a5,a5,0xc
ffffffffc0200f4c:	0000f717          	auipc	a4,0xf
ffffffffc0200f50:	10c73703          	ld	a4,268(a4) # ffffffffc0210058 <npage>
ffffffffc0200f54:	02e7ff63          	bgeu	a5,a4,ffffffffc0200f92 <page_remove+0x6a>
ffffffffc0200f58:	fff80737          	lui	a4,0xfff80
ffffffffc0200f5c:	97ba                	add	a5,a5,a4
ffffffffc0200f5e:	00379513          	slli	a0,a5,0x3
ffffffffc0200f62:	97aa                	add	a5,a5,a0
ffffffffc0200f64:	078e                	slli	a5,a5,0x3
ffffffffc0200f66:	0000f517          	auipc	a0,0xf
ffffffffc0200f6a:	14a53503          	ld	a0,330(a0) # ffffffffc02100b0 <pages>
ffffffffc0200f6e:	953e                	add	a0,a0,a5
ffffffffc0200f70:	411c                	lw	a5,0(a0)
ffffffffc0200f72:	fff7871b          	addiw	a4,a5,-1
ffffffffc0200f76:	c118                	sw	a4,0(a0)
ffffffffc0200f78:	cb09                	beqz	a4,ffffffffc0200f8a <page_remove+0x62>
ffffffffc0200f7a:	00043023          	sd	zero,0(s0)
ffffffffc0200f7e:	12000073          	sfence.vma
ffffffffc0200f82:	60a2                	ld	ra,8(sp)
ffffffffc0200f84:	6402                	ld	s0,0(sp)
ffffffffc0200f86:	0141                	addi	sp,sp,16
ffffffffc0200f88:	8082                	ret
ffffffffc0200f8a:	4585                	li	a1,1
ffffffffc0200f8c:	ccfff0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0200f90:	b7ed                	j	ffffffffc0200f7a <page_remove+0x52>
ffffffffc0200f92:	c1bff0ef          	jal	ra,ffffffffc0200bac <pa2page.part.0>

ffffffffc0200f96 <page_insert>:
ffffffffc0200f96:	7179                	addi	sp,sp,-48
ffffffffc0200f98:	87b2                	mv	a5,a2
ffffffffc0200f9a:	f022                	sd	s0,32(sp)
ffffffffc0200f9c:	4605                	li	a2,1
ffffffffc0200f9e:	842e                	mv	s0,a1
ffffffffc0200fa0:	85be                	mv	a1,a5
ffffffffc0200fa2:	ec26                	sd	s1,24(sp)
ffffffffc0200fa4:	f406                	sd	ra,40(sp)
ffffffffc0200fa6:	e84a                	sd	s2,16(sp)
ffffffffc0200fa8:	e44e                	sd	s3,8(sp)
ffffffffc0200faa:	84b6                	mv	s1,a3
ffffffffc0200fac:	d2dff0ef          	jal	ra,ffffffffc0200cd8 <get_pte>
ffffffffc0200fb0:	c54d                	beqz	a0,ffffffffc020105a <page_insert+0xc4>
ffffffffc0200fb2:	4014                	lw	a3,0(s0)
ffffffffc0200fb4:	611c                	ld	a5,0(a0)
ffffffffc0200fb6:	892a                	mv	s2,a0
ffffffffc0200fb8:	0016871b          	addiw	a4,a3,1
ffffffffc0200fbc:	c018                	sw	a4,0(s0)
ffffffffc0200fbe:	0017f713          	andi	a4,a5,1
ffffffffc0200fc2:	e329                	bnez	a4,ffffffffc0201004 <page_insert+0x6e>
ffffffffc0200fc4:	0000f797          	auipc	a5,0xf
ffffffffc0200fc8:	0ec7b783          	ld	a5,236(a5) # ffffffffc02100b0 <pages>
ffffffffc0200fcc:	40f407b3          	sub	a5,s0,a5
ffffffffc0200fd0:	878d                	srai	a5,a5,0x3
ffffffffc0200fd2:	00005417          	auipc	s0,0x5
ffffffffc0200fd6:	8f643403          	ld	s0,-1802(s0) # ffffffffc02058c8 <error_string+0x38>
ffffffffc0200fda:	028787b3          	mul	a5,a5,s0
ffffffffc0200fde:	00080437          	lui	s0,0x80
ffffffffc0200fe2:	97a2                	add	a5,a5,s0
ffffffffc0200fe4:	07aa                	slli	a5,a5,0xa
ffffffffc0200fe6:	8fc5                	or	a5,a5,s1
ffffffffc0200fe8:	0017e793          	ori	a5,a5,1
ffffffffc0200fec:	00f93023          	sd	a5,0(s2)
ffffffffc0200ff0:	12000073          	sfence.vma
ffffffffc0200ff4:	4501                	li	a0,0
ffffffffc0200ff6:	70a2                	ld	ra,40(sp)
ffffffffc0200ff8:	7402                	ld	s0,32(sp)
ffffffffc0200ffa:	64e2                	ld	s1,24(sp)
ffffffffc0200ffc:	6942                	ld	s2,16(sp)
ffffffffc0200ffe:	69a2                	ld	s3,8(sp)
ffffffffc0201000:	6145                	addi	sp,sp,48
ffffffffc0201002:	8082                	ret
ffffffffc0201004:	00279513          	slli	a0,a5,0x2
ffffffffc0201008:	8131                	srli	a0,a0,0xc
ffffffffc020100a:	0000f797          	auipc	a5,0xf
ffffffffc020100e:	04e7b783          	ld	a5,78(a5) # ffffffffc0210058 <npage>
ffffffffc0201012:	04f57663          	bgeu	a0,a5,ffffffffc020105e <page_insert+0xc8>
ffffffffc0201016:	fff807b7          	lui	a5,0xfff80
ffffffffc020101a:	953e                	add	a0,a0,a5
ffffffffc020101c:	0000f997          	auipc	s3,0xf
ffffffffc0201020:	09498993          	addi	s3,s3,148 # ffffffffc02100b0 <pages>
ffffffffc0201024:	0009b783          	ld	a5,0(s3)
ffffffffc0201028:	00351713          	slli	a4,a0,0x3
ffffffffc020102c:	953a                	add	a0,a0,a4
ffffffffc020102e:	050e                	slli	a0,a0,0x3
ffffffffc0201030:	953e                	add	a0,a0,a5
ffffffffc0201032:	00a40e63          	beq	s0,a0,ffffffffc020104e <page_insert+0xb8>
ffffffffc0201036:	411c                	lw	a5,0(a0)
ffffffffc0201038:	fff7871b          	addiw	a4,a5,-1
ffffffffc020103c:	c118                	sw	a4,0(a0)
ffffffffc020103e:	cb11                	beqz	a4,ffffffffc0201052 <page_insert+0xbc>
ffffffffc0201040:	00093023          	sd	zero,0(s2)
ffffffffc0201044:	12000073          	sfence.vma
ffffffffc0201048:	0009b783          	ld	a5,0(s3)
ffffffffc020104c:	b741                	j	ffffffffc0200fcc <page_insert+0x36>
ffffffffc020104e:	c014                	sw	a3,0(s0)
ffffffffc0201050:	bfb5                	j	ffffffffc0200fcc <page_insert+0x36>
ffffffffc0201052:	4585                	li	a1,1
ffffffffc0201054:	c07ff0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0201058:	b7e5                	j	ffffffffc0201040 <page_insert+0xaa>
ffffffffc020105a:	5571                	li	a0,-4
ffffffffc020105c:	bf69                	j	ffffffffc0200ff6 <page_insert+0x60>
ffffffffc020105e:	b4fff0ef          	jal	ra,ffffffffc0200bac <pa2page.part.0>

ffffffffc0201062 <pmm_init>:
ffffffffc0201062:	00004797          	auipc	a5,0x4
ffffffffc0201066:	58e78793          	addi	a5,a5,1422 # ffffffffc02055f0 <default_pmm_manager>
ffffffffc020106a:	638c                	ld	a1,0(a5)
ffffffffc020106c:	7139                	addi	sp,sp,-64
ffffffffc020106e:	fc06                	sd	ra,56(sp)
ffffffffc0201070:	f822                	sd	s0,48(sp)
ffffffffc0201072:	f426                	sd	s1,40(sp)
ffffffffc0201074:	f04a                	sd	s2,32(sp)
ffffffffc0201076:	ec4e                	sd	s3,24(sp)
ffffffffc0201078:	e852                	sd	s4,16(sp)
ffffffffc020107a:	e456                	sd	s5,8(sp)
ffffffffc020107c:	e05a                	sd	s6,0(sp)
ffffffffc020107e:	0000fa17          	auipc	s4,0xf
ffffffffc0201082:	01aa0a13          	addi	s4,s4,26 # ffffffffc0210098 <pmm_manager>
ffffffffc0201086:	00003517          	auipc	a0,0x3
ffffffffc020108a:	56a50513          	addi	a0,a0,1386 # ffffffffc02045f0 <etext+0x982>
ffffffffc020108e:	00fa3023          	sd	a5,0(s4)
ffffffffc0201092:	824ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0201096:	000a3783          	ld	a5,0(s4)
ffffffffc020109a:	40100913          	li	s2,1025
ffffffffc020109e:	4445                	li	s0,17
ffffffffc02010a0:	679c                	ld	a5,8(a5)
ffffffffc02010a2:	0000f997          	auipc	s3,0xf
ffffffffc02010a6:	00698993          	addi	s3,s3,6 # ffffffffc02100a8 <va_pa_offset>
ffffffffc02010aa:	0000f497          	auipc	s1,0xf
ffffffffc02010ae:	fae48493          	addi	s1,s1,-82 # ffffffffc0210058 <npage>
ffffffffc02010b2:	9782                	jalr	a5
ffffffffc02010b4:	57f5                	li	a5,-3
ffffffffc02010b6:	07fa                	slli	a5,a5,0x1e
ffffffffc02010b8:	01591593          	slli	a1,s2,0x15
ffffffffc02010bc:	07e006b7          	lui	a3,0x7e00
ffffffffc02010c0:	01b41613          	slli	a2,s0,0x1b
ffffffffc02010c4:	00003517          	auipc	a0,0x3
ffffffffc02010c8:	54450513          	addi	a0,a0,1348 # ffffffffc0204608 <etext+0x99a>
ffffffffc02010cc:	00f9b023          	sd	a5,0(s3)
ffffffffc02010d0:	fe7fe0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02010d4:	00003517          	auipc	a0,0x3
ffffffffc02010d8:	56450513          	addi	a0,a0,1380 # ffffffffc0204638 <etext+0x9ca>
ffffffffc02010dc:	fdbfe0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02010e0:	01b41693          	slli	a3,s0,0x1b
ffffffffc02010e4:	01591613          	slli	a2,s2,0x15
ffffffffc02010e8:	16fd                	addi	a3,a3,-1
ffffffffc02010ea:	07e005b7          	lui	a1,0x7e00
ffffffffc02010ee:	00003517          	auipc	a0,0x3
ffffffffc02010f2:	56250513          	addi	a0,a0,1378 # ffffffffc0204650 <etext+0x9e2>
ffffffffc02010f6:	fc1fe0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02010fa:	777d                	lui	a4,0xfffff
ffffffffc02010fc:	00010797          	auipc	a5,0x10
ffffffffc0201100:	0a378793          	addi	a5,a5,163 # ffffffffc021119f <end+0xfff>
ffffffffc0201104:	8ff9                	and	a5,a5,a4
ffffffffc0201106:	0000f917          	auipc	s2,0xf
ffffffffc020110a:	faa90913          	addi	s2,s2,-86 # ffffffffc02100b0 <pages>
ffffffffc020110e:	00088737          	lui	a4,0x88
ffffffffc0201112:	e098                	sd	a4,0(s1)
ffffffffc0201114:	00f93023          	sd	a5,0(s2)
ffffffffc0201118:	4681                	li	a3,0
ffffffffc020111a:	4701                	li	a4,0
ffffffffc020111c:	4585                	li	a1,1
ffffffffc020111e:	fff80637          	lui	a2,0xfff80
ffffffffc0201122:	a019                	j	ffffffffc0201128 <pmm_init+0xc6>
ffffffffc0201124:	00093783          	ld	a5,0(s2)
ffffffffc0201128:	97b6                	add	a5,a5,a3
ffffffffc020112a:	07a1                	addi	a5,a5,8
ffffffffc020112c:	40b7b02f          	amoor.d	zero,a1,(a5)
ffffffffc0201130:	609c                	ld	a5,0(s1)
ffffffffc0201132:	0705                	addi	a4,a4,1
ffffffffc0201134:	04868693          	addi	a3,a3,72 # 7e00048 <kern_entry-0xffffffffb83fffb8>
ffffffffc0201138:	00c78533          	add	a0,a5,a2
ffffffffc020113c:	fea764e3          	bltu	a4,a0,ffffffffc0201124 <pmm_init+0xc2>
ffffffffc0201140:	00093503          	ld	a0,0(s2)
ffffffffc0201144:	00379693          	slli	a3,a5,0x3
ffffffffc0201148:	96be                	add	a3,a3,a5
ffffffffc020114a:	fdc00737          	lui	a4,0xfdc00
ffffffffc020114e:	972a                	add	a4,a4,a0
ffffffffc0201150:	068e                	slli	a3,a3,0x3
ffffffffc0201152:	96ba                	add	a3,a3,a4
ffffffffc0201154:	c0200737          	lui	a4,0xc0200
ffffffffc0201158:	68e6ef63          	bltu	a3,a4,ffffffffc02017f6 <pmm_init+0x794>
ffffffffc020115c:	0009b703          	ld	a4,0(s3)
ffffffffc0201160:	45c5                	li	a1,17
ffffffffc0201162:	05ee                	slli	a1,a1,0x1b
ffffffffc0201164:	8e99                	sub	a3,a3,a4
ffffffffc0201166:	34b6ec63          	bltu	a3,a1,ffffffffc02014be <pmm_init+0x45c>
ffffffffc020116a:	000a3783          	ld	a5,0(s4)
ffffffffc020116e:	0000f417          	auipc	s0,0xf
ffffffffc0201172:	ee240413          	addi	s0,s0,-286 # ffffffffc0210050 <boot_pgdir>
ffffffffc0201176:	7b9c                	ld	a5,48(a5)
ffffffffc0201178:	9782                	jalr	a5
ffffffffc020117a:	00003517          	auipc	a0,0x3
ffffffffc020117e:	52650513          	addi	a0,a0,1318 # ffffffffc02046a0 <etext+0xa32>
ffffffffc0201182:	f35fe0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0201186:	00007517          	auipc	a0,0x7
ffffffffc020118a:	e7a50513          	addi	a0,a0,-390 # ffffffffc0208000 <boot_page_table_sv39>
ffffffffc020118e:	e008                	sd	a0,0(s0)
ffffffffc0201190:	c02007b7          	lui	a5,0xc0200
ffffffffc0201194:	7af56963          	bltu	a0,a5,ffffffffc0201946 <pmm_init+0x8e4>
ffffffffc0201198:	0009b783          	ld	a5,0(s3)
ffffffffc020119c:	6098                	ld	a4,0(s1)
ffffffffc020119e:	40f507b3          	sub	a5,a0,a5
ffffffffc02011a2:	0000f697          	auipc	a3,0xf
ffffffffc02011a6:	eef6bf23          	sd	a5,-258(a3) # ffffffffc02100a0 <boot_satp>
ffffffffc02011aa:	c80007b7          	lui	a5,0xc8000
ffffffffc02011ae:	83b1                	srli	a5,a5,0xc
ffffffffc02011b0:	76e7eb63          	bltu	a5,a4,ffffffffc0201926 <pmm_init+0x8c4>
ffffffffc02011b4:	03451793          	slli	a5,a0,0x34
ffffffffc02011b8:	3a079563          	bnez	a5,ffffffffc0201562 <pmm_init+0x500>
ffffffffc02011bc:	4601                	li	a2,0
ffffffffc02011be:	4581                	li	a1,0
ffffffffc02011c0:	d0fff0ef          	jal	ra,ffffffffc0200ece <get_page>
ffffffffc02011c4:	74051163          	bnez	a0,ffffffffc0201906 <pmm_init+0x8a4>
ffffffffc02011c8:	4505                	li	a0,1
ffffffffc02011ca:	9ffff0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc02011ce:	8a2a                	mv	s4,a0
ffffffffc02011d0:	6008                	ld	a0,0(s0)
ffffffffc02011d2:	4681                	li	a3,0
ffffffffc02011d4:	4601                	li	a2,0
ffffffffc02011d6:	85d2                	mv	a1,s4
ffffffffc02011d8:	dbfff0ef          	jal	ra,ffffffffc0200f96 <page_insert>
ffffffffc02011dc:	3a051363          	bnez	a0,ffffffffc0201582 <pmm_init+0x520>
ffffffffc02011e0:	6008                	ld	a0,0(s0)
ffffffffc02011e2:	4601                	li	a2,0
ffffffffc02011e4:	4581                	li	a1,0
ffffffffc02011e6:	af3ff0ef          	jal	ra,ffffffffc0200cd8 <get_pte>
ffffffffc02011ea:	7a050b63          	beqz	a0,ffffffffc02019a0 <pmm_init+0x93e>
ffffffffc02011ee:	611c                	ld	a5,0(a0)
ffffffffc02011f0:	0017f713          	andi	a4,a5,1
ffffffffc02011f4:	34070b63          	beqz	a4,ffffffffc020154a <pmm_init+0x4e8>
ffffffffc02011f8:	6090                	ld	a2,0(s1)
ffffffffc02011fa:	078a                	slli	a5,a5,0x2
ffffffffc02011fc:	83b1                	srli	a5,a5,0xc
ffffffffc02011fe:	34c7f463          	bgeu	a5,a2,ffffffffc0201546 <pmm_init+0x4e4>
ffffffffc0201202:	fff80737          	lui	a4,0xfff80
ffffffffc0201206:	97ba                	add	a5,a5,a4
ffffffffc0201208:	00093683          	ld	a3,0(s2)
ffffffffc020120c:	00379713          	slli	a4,a5,0x3
ffffffffc0201210:	97ba                	add	a5,a5,a4
ffffffffc0201212:	078e                	slli	a5,a5,0x3
ffffffffc0201214:	97b6                	add	a5,a5,a3
ffffffffc0201216:	4cfa1063          	bne	s4,a5,ffffffffc02016d6 <pmm_init+0x674>
ffffffffc020121a:	000a2703          	lw	a4,0(s4)
ffffffffc020121e:	4785                	li	a5,1
ffffffffc0201220:	48f71b63          	bne	a4,a5,ffffffffc02016b6 <pmm_init+0x654>
ffffffffc0201224:	6008                	ld	a0,0(s0)
ffffffffc0201226:	76fd                	lui	a3,0xfffff
ffffffffc0201228:	611c                	ld	a5,0(a0)
ffffffffc020122a:	078a                	slli	a5,a5,0x2
ffffffffc020122c:	8ff5                	and	a5,a5,a3
ffffffffc020122e:	00c7d713          	srli	a4,a5,0xc
ffffffffc0201232:	46c77563          	bgeu	a4,a2,ffffffffc020169c <pmm_init+0x63a>
ffffffffc0201236:	0009bb03          	ld	s6,0(s3)
ffffffffc020123a:	97da                	add	a5,a5,s6
ffffffffc020123c:	0007ba83          	ld	s5,0(a5) # ffffffffc8000000 <end+0x7defe60>
ffffffffc0201240:	0a8a                	slli	s5,s5,0x2
ffffffffc0201242:	00dafab3          	and	s5,s5,a3
ffffffffc0201246:	00cad793          	srli	a5,s5,0xc
ffffffffc020124a:	42c7fc63          	bgeu	a5,a2,ffffffffc0201682 <pmm_init+0x620>
ffffffffc020124e:	4601                	li	a2,0
ffffffffc0201250:	6585                	lui	a1,0x1
ffffffffc0201252:	9ada                	add	s5,s5,s6
ffffffffc0201254:	a85ff0ef          	jal	ra,ffffffffc0200cd8 <get_pte>
ffffffffc0201258:	0aa1                	addi	s5,s5,8
ffffffffc020125a:	41551463          	bne	a0,s5,ffffffffc0201662 <pmm_init+0x600>
ffffffffc020125e:	4505                	li	a0,1
ffffffffc0201260:	969ff0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0201264:	8aaa                	mv	s5,a0
ffffffffc0201266:	6008                	ld	a0,0(s0)
ffffffffc0201268:	46d1                	li	a3,20
ffffffffc020126a:	6605                	lui	a2,0x1
ffffffffc020126c:	85d6                	mv	a1,s5
ffffffffc020126e:	d29ff0ef          	jal	ra,ffffffffc0200f96 <page_insert>
ffffffffc0201272:	3c051863          	bnez	a0,ffffffffc0201642 <pmm_init+0x5e0>
ffffffffc0201276:	6008                	ld	a0,0(s0)
ffffffffc0201278:	4601                	li	a2,0
ffffffffc020127a:	6585                	lui	a1,0x1
ffffffffc020127c:	a5dff0ef          	jal	ra,ffffffffc0200cd8 <get_pte>
ffffffffc0201280:	3a050163          	beqz	a0,ffffffffc0201622 <pmm_init+0x5c0>
ffffffffc0201284:	611c                	ld	a5,0(a0)
ffffffffc0201286:	0107f713          	andi	a4,a5,16
ffffffffc020128a:	36070c63          	beqz	a4,ffffffffc0201602 <pmm_init+0x5a0>
ffffffffc020128e:	8b91                	andi	a5,a5,4
ffffffffc0201290:	30078963          	beqz	a5,ffffffffc02015a2 <pmm_init+0x540>
ffffffffc0201294:	6008                	ld	a0,0(s0)
ffffffffc0201296:	611c                	ld	a5,0(a0)
ffffffffc0201298:	8bc1                	andi	a5,a5,16
ffffffffc020129a:	50078e63          	beqz	a5,ffffffffc02017b6 <pmm_init+0x754>
ffffffffc020129e:	000aa703          	lw	a4,0(s5)
ffffffffc02012a2:	4785                	li	a5,1
ffffffffc02012a4:	4ef71963          	bne	a4,a5,ffffffffc0201796 <pmm_init+0x734>
ffffffffc02012a8:	4681                	li	a3,0
ffffffffc02012aa:	6605                	lui	a2,0x1
ffffffffc02012ac:	85d2                	mv	a1,s4
ffffffffc02012ae:	ce9ff0ef          	jal	ra,ffffffffc0200f96 <page_insert>
ffffffffc02012b2:	4c051263          	bnez	a0,ffffffffc0201776 <pmm_init+0x714>
ffffffffc02012b6:	000a2703          	lw	a4,0(s4)
ffffffffc02012ba:	4789                	li	a5,2
ffffffffc02012bc:	48f71d63          	bne	a4,a5,ffffffffc0201756 <pmm_init+0x6f4>
ffffffffc02012c0:	000aa783          	lw	a5,0(s5)
ffffffffc02012c4:	46079963          	bnez	a5,ffffffffc0201736 <pmm_init+0x6d4>
ffffffffc02012c8:	6008                	ld	a0,0(s0)
ffffffffc02012ca:	4601                	li	a2,0
ffffffffc02012cc:	6585                	lui	a1,0x1
ffffffffc02012ce:	a0bff0ef          	jal	ra,ffffffffc0200cd8 <get_pte>
ffffffffc02012d2:	44050263          	beqz	a0,ffffffffc0201716 <pmm_init+0x6b4>
ffffffffc02012d6:	6114                	ld	a3,0(a0)
ffffffffc02012d8:	0016f793          	andi	a5,a3,1
ffffffffc02012dc:	26078763          	beqz	a5,ffffffffc020154a <pmm_init+0x4e8>
ffffffffc02012e0:	6098                	ld	a4,0(s1)
ffffffffc02012e2:	00269793          	slli	a5,a3,0x2
ffffffffc02012e6:	83b1                	srli	a5,a5,0xc
ffffffffc02012e8:	24e7ff63          	bgeu	a5,a4,ffffffffc0201546 <pmm_init+0x4e4>
ffffffffc02012ec:	fff80737          	lui	a4,0xfff80
ffffffffc02012f0:	97ba                	add	a5,a5,a4
ffffffffc02012f2:	00093603          	ld	a2,0(s2)
ffffffffc02012f6:	00379713          	slli	a4,a5,0x3
ffffffffc02012fa:	97ba                	add	a5,a5,a4
ffffffffc02012fc:	078e                	slli	a5,a5,0x3
ffffffffc02012fe:	97b2                	add	a5,a5,a2
ffffffffc0201300:	3efa1b63          	bne	s4,a5,ffffffffc02016f6 <pmm_init+0x694>
ffffffffc0201304:	8ac1                	andi	a3,a3,16
ffffffffc0201306:	5c069063          	bnez	a3,ffffffffc02018c6 <pmm_init+0x864>
ffffffffc020130a:	6008                	ld	a0,0(s0)
ffffffffc020130c:	4581                	li	a1,0
ffffffffc020130e:	c1bff0ef          	jal	ra,ffffffffc0200f28 <page_remove>
ffffffffc0201312:	000a2703          	lw	a4,0(s4)
ffffffffc0201316:	4785                	li	a5,1
ffffffffc0201318:	2af71563          	bne	a4,a5,ffffffffc02015c2 <pmm_init+0x560>
ffffffffc020131c:	000aa783          	lw	a5,0(s5)
ffffffffc0201320:	4a079b63          	bnez	a5,ffffffffc02017d6 <pmm_init+0x774>
ffffffffc0201324:	6008                	ld	a0,0(s0)
ffffffffc0201326:	6585                	lui	a1,0x1
ffffffffc0201328:	c01ff0ef          	jal	ra,ffffffffc0200f28 <page_remove>
ffffffffc020132c:	000a2783          	lw	a5,0(s4)
ffffffffc0201330:	2a079963          	bnez	a5,ffffffffc02015e2 <pmm_init+0x580>
ffffffffc0201334:	000aa783          	lw	a5,0(s5)
ffffffffc0201338:	64079463          	bnez	a5,ffffffffc0201980 <pmm_init+0x91e>
ffffffffc020133c:	601c                	ld	a5,0(s0)
ffffffffc020133e:	6098                	ld	a4,0(s1)
ffffffffc0201340:	639c                	ld	a5,0(a5)
ffffffffc0201342:	078a                	slli	a5,a5,0x2
ffffffffc0201344:	83b1                	srli	a5,a5,0xc
ffffffffc0201346:	20e7f063          	bgeu	a5,a4,ffffffffc0201546 <pmm_init+0x4e4>
ffffffffc020134a:	fff80537          	lui	a0,0xfff80
ffffffffc020134e:	97aa                	add	a5,a5,a0
ffffffffc0201350:	00379713          	slli	a4,a5,0x3
ffffffffc0201354:	00093503          	ld	a0,0(s2)
ffffffffc0201358:	97ba                	add	a5,a5,a4
ffffffffc020135a:	078e                	slli	a5,a5,0x3
ffffffffc020135c:	953e                	add	a0,a0,a5
ffffffffc020135e:	4118                	lw	a4,0(a0)
ffffffffc0201360:	4785                	li	a5,1
ffffffffc0201362:	5ef71f63          	bne	a4,a5,ffffffffc0201960 <pmm_init+0x8fe>
ffffffffc0201366:	4585                	li	a1,1
ffffffffc0201368:	8f3ff0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc020136c:	601c                	ld	a5,0(s0)
ffffffffc020136e:	00003517          	auipc	a0,0x3
ffffffffc0201372:	62250513          	addi	a0,a0,1570 # ffffffffc0204990 <etext+0xd22>
ffffffffc0201376:	c0200a37          	lui	s4,0xc0200
ffffffffc020137a:	0007b023          	sd	zero,0(a5)
ffffffffc020137e:	d39fe0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0201382:	609c                	ld	a5,0(s1)
ffffffffc0201384:	7b7d                	lui	s6,0xfffff
ffffffffc0201386:	6a85                	lui	s5,0x1
ffffffffc0201388:	00c79713          	slli	a4,a5,0xc
ffffffffc020138c:	02ea7b63          	bgeu	s4,a4,ffffffffc02013c2 <pmm_init+0x360>
ffffffffc0201390:	00ca5713          	srli	a4,s4,0xc
ffffffffc0201394:	6008                	ld	a0,0(s0)
ffffffffc0201396:	18f77b63          	bgeu	a4,a5,ffffffffc020152c <pmm_init+0x4ca>
ffffffffc020139a:	0009b583          	ld	a1,0(s3)
ffffffffc020139e:	4601                	li	a2,0
ffffffffc02013a0:	95d2                	add	a1,a1,s4
ffffffffc02013a2:	937ff0ef          	jal	ra,ffffffffc0200cd8 <get_pte>
ffffffffc02013a6:	16050363          	beqz	a0,ffffffffc020150c <pmm_init+0x4aa>
ffffffffc02013aa:	611c                	ld	a5,0(a0)
ffffffffc02013ac:	078a                	slli	a5,a5,0x2
ffffffffc02013ae:	0167f7b3          	and	a5,a5,s6
ffffffffc02013b2:	13479d63          	bne	a5,s4,ffffffffc02014ec <pmm_init+0x48a>
ffffffffc02013b6:	609c                	ld	a5,0(s1)
ffffffffc02013b8:	9a56                	add	s4,s4,s5
ffffffffc02013ba:	00c79713          	slli	a4,a5,0xc
ffffffffc02013be:	fcea69e3          	bltu	s4,a4,ffffffffc0201390 <pmm_init+0x32e>
ffffffffc02013c2:	601c                	ld	a5,0(s0)
ffffffffc02013c4:	639c                	ld	a5,0(a5)
ffffffffc02013c6:	52079063          	bnez	a5,ffffffffc02018e6 <pmm_init+0x884>
ffffffffc02013ca:	4505                	li	a0,1
ffffffffc02013cc:	ffcff0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc02013d0:	8aaa                	mv	s5,a0
ffffffffc02013d2:	6008                	ld	a0,0(s0)
ffffffffc02013d4:	4699                	li	a3,6
ffffffffc02013d6:	10000613          	li	a2,256
ffffffffc02013da:	85d6                	mv	a1,s5
ffffffffc02013dc:	bbbff0ef          	jal	ra,ffffffffc0200f96 <page_insert>
ffffffffc02013e0:	46051763          	bnez	a0,ffffffffc020184e <pmm_init+0x7ec>
ffffffffc02013e4:	000aa703          	lw	a4,0(s5) # 1000 <kern_entry-0xffffffffc01ff000>
ffffffffc02013e8:	4785                	li	a5,1
ffffffffc02013ea:	44f71263          	bne	a4,a5,ffffffffc020182e <pmm_init+0x7cc>
ffffffffc02013ee:	6008                	ld	a0,0(s0)
ffffffffc02013f0:	6a05                	lui	s4,0x1
ffffffffc02013f2:	4699                	li	a3,6
ffffffffc02013f4:	100a0613          	addi	a2,s4,256 # 1100 <kern_entry-0xffffffffc01fef00>
ffffffffc02013f8:	85d6                	mv	a1,s5
ffffffffc02013fa:	b9dff0ef          	jal	ra,ffffffffc0200f96 <page_insert>
ffffffffc02013fe:	5c051163          	bnez	a0,ffffffffc02019c0 <pmm_init+0x95e>
ffffffffc0201402:	000aa703          	lw	a4,0(s5)
ffffffffc0201406:	4789                	li	a5,2
ffffffffc0201408:	48f71f63          	bne	a4,a5,ffffffffc02018a6 <pmm_init+0x844>
ffffffffc020140c:	00003597          	auipc	a1,0x3
ffffffffc0201410:	6bc58593          	addi	a1,a1,1724 # ffffffffc0204ac8 <etext+0xe5a>
ffffffffc0201414:	10000513          	li	a0,256
ffffffffc0201418:	40e020ef          	jal	ra,ffffffffc0203826 <strcpy>
ffffffffc020141c:	100a0593          	addi	a1,s4,256
ffffffffc0201420:	10000513          	li	a0,256
ffffffffc0201424:	414020ef          	jal	ra,ffffffffc0203838 <strcmp>
ffffffffc0201428:	44051f63          	bnez	a0,ffffffffc0201886 <pmm_init+0x824>
ffffffffc020142c:	00093683          	ld	a3,0(s2)
ffffffffc0201430:	00004797          	auipc	a5,0x4
ffffffffc0201434:	4987b783          	ld	a5,1176(a5) # ffffffffc02058c8 <error_string+0x38>
ffffffffc0201438:	00080a37          	lui	s4,0x80
ffffffffc020143c:	40da86b3          	sub	a3,s5,a3
ffffffffc0201440:	868d                	srai	a3,a3,0x3
ffffffffc0201442:	02f686b3          	mul	a3,a3,a5
ffffffffc0201446:	6098                	ld	a4,0(s1)
ffffffffc0201448:	96d2                	add	a3,a3,s4
ffffffffc020144a:	00c69793          	slli	a5,a3,0xc
ffffffffc020144e:	83b1                	srli	a5,a5,0xc
ffffffffc0201450:	06b2                	slli	a3,a3,0xc
ffffffffc0201452:	40e7fe63          	bgeu	a5,a4,ffffffffc020186e <pmm_init+0x80c>
ffffffffc0201456:	0009b783          	ld	a5,0(s3)
ffffffffc020145a:	10000513          	li	a0,256
ffffffffc020145e:	96be                	add	a3,a3,a5
ffffffffc0201460:	10068023          	sb	zero,256(a3) # fffffffffffff100 <end+0x3fdeef60>
ffffffffc0201464:	38c020ef          	jal	ra,ffffffffc02037f0 <strlen>
ffffffffc0201468:	3a051363          	bnez	a0,ffffffffc020180e <pmm_init+0x7ac>
ffffffffc020146c:	4585                	li	a1,1
ffffffffc020146e:	8556                	mv	a0,s5
ffffffffc0201470:	feaff0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0201474:	601c                	ld	a5,0(s0)
ffffffffc0201476:	6098                	ld	a4,0(s1)
ffffffffc0201478:	639c                	ld	a5,0(a5)
ffffffffc020147a:	078a                	slli	a5,a5,0x2
ffffffffc020147c:	83b1                	srli	a5,a5,0xc
ffffffffc020147e:	0ce7f463          	bgeu	a5,a4,ffffffffc0201546 <pmm_init+0x4e4>
ffffffffc0201482:	414787b3          	sub	a5,a5,s4
ffffffffc0201486:	00093503          	ld	a0,0(s2)
ffffffffc020148a:	00379713          	slli	a4,a5,0x3
ffffffffc020148e:	97ba                	add	a5,a5,a4
ffffffffc0201490:	078e                	slli	a5,a5,0x3
ffffffffc0201492:	953e                	add	a0,a0,a5
ffffffffc0201494:	4585                	li	a1,1
ffffffffc0201496:	fc4ff0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc020149a:	601c                	ld	a5,0(s0)
ffffffffc020149c:	7442                	ld	s0,48(sp)
ffffffffc020149e:	70e2                	ld	ra,56(sp)
ffffffffc02014a0:	74a2                	ld	s1,40(sp)
ffffffffc02014a2:	7902                	ld	s2,32(sp)
ffffffffc02014a4:	69e2                	ld	s3,24(sp)
ffffffffc02014a6:	6a42                	ld	s4,16(sp)
ffffffffc02014a8:	6aa2                	ld	s5,8(sp)
ffffffffc02014aa:	6b02                	ld	s6,0(sp)
ffffffffc02014ac:	0007b023          	sd	zero,0(a5)
ffffffffc02014b0:	00003517          	auipc	a0,0x3
ffffffffc02014b4:	69050513          	addi	a0,a0,1680 # ffffffffc0204b40 <etext+0xed2>
ffffffffc02014b8:	6121                	addi	sp,sp,64
ffffffffc02014ba:	bfdfe06f          	j	ffffffffc02000b6 <cprintf>
ffffffffc02014be:	6705                	lui	a4,0x1
ffffffffc02014c0:	177d                	addi	a4,a4,-1
ffffffffc02014c2:	96ba                	add	a3,a3,a4
ffffffffc02014c4:	00c6d713          	srli	a4,a3,0xc
ffffffffc02014c8:	06f77f63          	bgeu	a4,a5,ffffffffc0201546 <pmm_init+0x4e4>
ffffffffc02014cc:	000a3803          	ld	a6,0(s4) # 80000 <kern_entry-0xffffffffc0180000>
ffffffffc02014d0:	9732                	add	a4,a4,a2
ffffffffc02014d2:	00371793          	slli	a5,a4,0x3
ffffffffc02014d6:	767d                	lui	a2,0xfffff
ffffffffc02014d8:	8ef1                	and	a3,a3,a2
ffffffffc02014da:	97ba                	add	a5,a5,a4
ffffffffc02014dc:	01083703          	ld	a4,16(a6)
ffffffffc02014e0:	8d95                	sub	a1,a1,a3
ffffffffc02014e2:	078e                	slli	a5,a5,0x3
ffffffffc02014e4:	81b1                	srli	a1,a1,0xc
ffffffffc02014e6:	953e                	add	a0,a0,a5
ffffffffc02014e8:	9702                	jalr	a4
ffffffffc02014ea:	b141                	j	ffffffffc020116a <pmm_init+0x108>
ffffffffc02014ec:	00003697          	auipc	a3,0x3
ffffffffc02014f0:	50468693          	addi	a3,a3,1284 # ffffffffc02049f0 <etext+0xd82>
ffffffffc02014f4:	00003617          	auipc	a2,0x3
ffffffffc02014f8:	ec460613          	addi	a2,a2,-316 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02014fc:	18b00593          	li	a1,395
ffffffffc0201500:	00003517          	auipc	a0,0x3
ffffffffc0201504:	0e050513          	addi	a0,a0,224 # ffffffffc02045e0 <etext+0x972>
ffffffffc0201508:	be5fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020150c:	00003697          	auipc	a3,0x3
ffffffffc0201510:	4a468693          	addi	a3,a3,1188 # ffffffffc02049b0 <etext+0xd42>
ffffffffc0201514:	00003617          	auipc	a2,0x3
ffffffffc0201518:	ea460613          	addi	a2,a2,-348 # ffffffffc02043b8 <etext+0x74a>
ffffffffc020151c:	18a00593          	li	a1,394
ffffffffc0201520:	00003517          	auipc	a0,0x3
ffffffffc0201524:	0c050513          	addi	a0,a0,192 # ffffffffc02045e0 <etext+0x972>
ffffffffc0201528:	bc5fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020152c:	86d2                	mv	a3,s4
ffffffffc020152e:	00003617          	auipc	a2,0x3
ffffffffc0201532:	08a60613          	addi	a2,a2,138 # ffffffffc02045b8 <etext+0x94a>
ffffffffc0201536:	18a00593          	li	a1,394
ffffffffc020153a:	00003517          	auipc	a0,0x3
ffffffffc020153e:	0a650513          	addi	a0,a0,166 # ffffffffc02045e0 <etext+0x972>
ffffffffc0201542:	babfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201546:	e66ff0ef          	jal	ra,ffffffffc0200bac <pa2page.part.0>
ffffffffc020154a:	00003617          	auipc	a2,0x3
ffffffffc020154e:	25660613          	addi	a2,a2,598 # ffffffffc02047a0 <etext+0xb32>
ffffffffc0201552:	07000593          	li	a1,112
ffffffffc0201556:	00003517          	auipc	a0,0x3
ffffffffc020155a:	05250513          	addi	a0,a0,82 # ffffffffc02045a8 <etext+0x93a>
ffffffffc020155e:	b8ffe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201562:	00003697          	auipc	a3,0x3
ffffffffc0201566:	17e68693          	addi	a3,a3,382 # ffffffffc02046e0 <etext+0xa72>
ffffffffc020156a:	00003617          	auipc	a2,0x3
ffffffffc020156e:	e4e60613          	addi	a2,a2,-434 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201572:	15900593          	li	a1,345
ffffffffc0201576:	00003517          	auipc	a0,0x3
ffffffffc020157a:	06a50513          	addi	a0,a0,106 # ffffffffc02045e0 <etext+0x972>
ffffffffc020157e:	b6ffe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201582:	00003697          	auipc	a3,0x3
ffffffffc0201586:	1be68693          	addi	a3,a3,446 # ffffffffc0204740 <etext+0xad2>
ffffffffc020158a:	00003617          	auipc	a2,0x3
ffffffffc020158e:	e2e60613          	addi	a2,a2,-466 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201592:	15e00593          	li	a1,350
ffffffffc0201596:	00003517          	auipc	a0,0x3
ffffffffc020159a:	04a50513          	addi	a0,a0,74 # ffffffffc02045e0 <etext+0x972>
ffffffffc020159e:	b4ffe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02015a2:	00003697          	auipc	a3,0x3
ffffffffc02015a6:	2f668693          	addi	a3,a3,758 # ffffffffc0204898 <etext+0xc2a>
ffffffffc02015aa:	00003617          	auipc	a2,0x3
ffffffffc02015ae:	e0e60613          	addi	a2,a2,-498 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02015b2:	16c00593          	li	a1,364
ffffffffc02015b6:	00003517          	auipc	a0,0x3
ffffffffc02015ba:	02a50513          	addi	a0,a0,42 # ffffffffc02045e0 <etext+0x972>
ffffffffc02015be:	b2ffe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02015c2:	00003697          	auipc	a3,0x3
ffffffffc02015c6:	21e68693          	addi	a3,a3,542 # ffffffffc02047e0 <etext+0xb72>
ffffffffc02015ca:	00003617          	auipc	a2,0x3
ffffffffc02015ce:	dee60613          	addi	a2,a2,-530 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02015d2:	17800593          	li	a1,376
ffffffffc02015d6:	00003517          	auipc	a0,0x3
ffffffffc02015da:	00a50513          	addi	a0,a0,10 # ffffffffc02045e0 <etext+0x972>
ffffffffc02015de:	b0ffe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02015e2:	00003697          	auipc	a3,0x3
ffffffffc02015e6:	36e68693          	addi	a3,a3,878 # ffffffffc0204950 <etext+0xce2>
ffffffffc02015ea:	00003617          	auipc	a2,0x3
ffffffffc02015ee:	dce60613          	addi	a2,a2,-562 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02015f2:	17c00593          	li	a1,380
ffffffffc02015f6:	00003517          	auipc	a0,0x3
ffffffffc02015fa:	fea50513          	addi	a0,a0,-22 # ffffffffc02045e0 <etext+0x972>
ffffffffc02015fe:	aeffe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201602:	00003697          	auipc	a3,0x3
ffffffffc0201606:	28668693          	addi	a3,a3,646 # ffffffffc0204888 <etext+0xc1a>
ffffffffc020160a:	00003617          	auipc	a2,0x3
ffffffffc020160e:	dae60613          	addi	a2,a2,-594 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201612:	16b00593          	li	a1,363
ffffffffc0201616:	00003517          	auipc	a0,0x3
ffffffffc020161a:	fca50513          	addi	a0,a0,-54 # ffffffffc02045e0 <etext+0x972>
ffffffffc020161e:	acffe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201622:	00003697          	auipc	a3,0x3
ffffffffc0201626:	23668693          	addi	a3,a3,566 # ffffffffc0204858 <etext+0xbea>
ffffffffc020162a:	00003617          	auipc	a2,0x3
ffffffffc020162e:	d8e60613          	addi	a2,a2,-626 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201632:	16a00593          	li	a1,362
ffffffffc0201636:	00003517          	auipc	a0,0x3
ffffffffc020163a:	faa50513          	addi	a0,a0,-86 # ffffffffc02045e0 <etext+0x972>
ffffffffc020163e:	aaffe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201642:	00003697          	auipc	a3,0x3
ffffffffc0201646:	1de68693          	addi	a3,a3,478 # ffffffffc0204820 <etext+0xbb2>
ffffffffc020164a:	00003617          	auipc	a2,0x3
ffffffffc020164e:	d6e60613          	addi	a2,a2,-658 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201652:	16900593          	li	a1,361
ffffffffc0201656:	00003517          	auipc	a0,0x3
ffffffffc020165a:	f8a50513          	addi	a0,a0,-118 # ffffffffc02045e0 <etext+0x972>
ffffffffc020165e:	a8ffe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201662:	00003697          	auipc	a3,0x3
ffffffffc0201666:	19668693          	addi	a3,a3,406 # ffffffffc02047f8 <etext+0xb8a>
ffffffffc020166a:	00003617          	auipc	a2,0x3
ffffffffc020166e:	d4e60613          	addi	a2,a2,-690 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201672:	16600593          	li	a1,358
ffffffffc0201676:	00003517          	auipc	a0,0x3
ffffffffc020167a:	f6a50513          	addi	a0,a0,-150 # ffffffffc02045e0 <etext+0x972>
ffffffffc020167e:	a6ffe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201682:	86d6                	mv	a3,s5
ffffffffc0201684:	00003617          	auipc	a2,0x3
ffffffffc0201688:	f3460613          	addi	a2,a2,-204 # ffffffffc02045b8 <etext+0x94a>
ffffffffc020168c:	16500593          	li	a1,357
ffffffffc0201690:	00003517          	auipc	a0,0x3
ffffffffc0201694:	f5050513          	addi	a0,a0,-176 # ffffffffc02045e0 <etext+0x972>
ffffffffc0201698:	a55fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020169c:	86be                	mv	a3,a5
ffffffffc020169e:	00003617          	auipc	a2,0x3
ffffffffc02016a2:	f1a60613          	addi	a2,a2,-230 # ffffffffc02045b8 <etext+0x94a>
ffffffffc02016a6:	16400593          	li	a1,356
ffffffffc02016aa:	00003517          	auipc	a0,0x3
ffffffffc02016ae:	f3650513          	addi	a0,a0,-202 # ffffffffc02045e0 <etext+0x972>
ffffffffc02016b2:	a3bfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02016b6:	00003697          	auipc	a3,0x3
ffffffffc02016ba:	12a68693          	addi	a3,a3,298 # ffffffffc02047e0 <etext+0xb72>
ffffffffc02016be:	00003617          	auipc	a2,0x3
ffffffffc02016c2:	cfa60613          	addi	a2,a2,-774 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02016c6:	16200593          	li	a1,354
ffffffffc02016ca:	00003517          	auipc	a0,0x3
ffffffffc02016ce:	f1650513          	addi	a0,a0,-234 # ffffffffc02045e0 <etext+0x972>
ffffffffc02016d2:	a1bfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02016d6:	00003697          	auipc	a3,0x3
ffffffffc02016da:	0f268693          	addi	a3,a3,242 # ffffffffc02047c8 <etext+0xb5a>
ffffffffc02016de:	00003617          	auipc	a2,0x3
ffffffffc02016e2:	cda60613          	addi	a2,a2,-806 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02016e6:	16100593          	li	a1,353
ffffffffc02016ea:	00003517          	auipc	a0,0x3
ffffffffc02016ee:	ef650513          	addi	a0,a0,-266 # ffffffffc02045e0 <etext+0x972>
ffffffffc02016f2:	9fbfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02016f6:	00003697          	auipc	a3,0x3
ffffffffc02016fa:	0d268693          	addi	a3,a3,210 # ffffffffc02047c8 <etext+0xb5a>
ffffffffc02016fe:	00003617          	auipc	a2,0x3
ffffffffc0201702:	cba60613          	addi	a2,a2,-838 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201706:	17400593          	li	a1,372
ffffffffc020170a:	00003517          	auipc	a0,0x3
ffffffffc020170e:	ed650513          	addi	a0,a0,-298 # ffffffffc02045e0 <etext+0x972>
ffffffffc0201712:	9dbfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201716:	00003697          	auipc	a3,0x3
ffffffffc020171a:	14268693          	addi	a3,a3,322 # ffffffffc0204858 <etext+0xbea>
ffffffffc020171e:	00003617          	auipc	a2,0x3
ffffffffc0201722:	c9a60613          	addi	a2,a2,-870 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201726:	17300593          	li	a1,371
ffffffffc020172a:	00003517          	auipc	a0,0x3
ffffffffc020172e:	eb650513          	addi	a0,a0,-330 # ffffffffc02045e0 <etext+0x972>
ffffffffc0201732:	9bbfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201736:	00003697          	auipc	a3,0x3
ffffffffc020173a:	1ea68693          	addi	a3,a3,490 # ffffffffc0204920 <etext+0xcb2>
ffffffffc020173e:	00003617          	auipc	a2,0x3
ffffffffc0201742:	c7a60613          	addi	a2,a2,-902 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201746:	17200593          	li	a1,370
ffffffffc020174a:	00003517          	auipc	a0,0x3
ffffffffc020174e:	e9650513          	addi	a0,a0,-362 # ffffffffc02045e0 <etext+0x972>
ffffffffc0201752:	99bfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201756:	00003697          	auipc	a3,0x3
ffffffffc020175a:	1b268693          	addi	a3,a3,434 # ffffffffc0204908 <etext+0xc9a>
ffffffffc020175e:	00003617          	auipc	a2,0x3
ffffffffc0201762:	c5a60613          	addi	a2,a2,-934 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201766:	17100593          	li	a1,369
ffffffffc020176a:	00003517          	auipc	a0,0x3
ffffffffc020176e:	e7650513          	addi	a0,a0,-394 # ffffffffc02045e0 <etext+0x972>
ffffffffc0201772:	97bfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201776:	00003697          	auipc	a3,0x3
ffffffffc020177a:	16268693          	addi	a3,a3,354 # ffffffffc02048d8 <etext+0xc6a>
ffffffffc020177e:	00003617          	auipc	a2,0x3
ffffffffc0201782:	c3a60613          	addi	a2,a2,-966 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201786:	17000593          	li	a1,368
ffffffffc020178a:	00003517          	auipc	a0,0x3
ffffffffc020178e:	e5650513          	addi	a0,a0,-426 # ffffffffc02045e0 <etext+0x972>
ffffffffc0201792:	95bfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201796:	00003697          	auipc	a3,0x3
ffffffffc020179a:	12a68693          	addi	a3,a3,298 # ffffffffc02048c0 <etext+0xc52>
ffffffffc020179e:	00003617          	auipc	a2,0x3
ffffffffc02017a2:	c1a60613          	addi	a2,a2,-998 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02017a6:	16e00593          	li	a1,366
ffffffffc02017aa:	00003517          	auipc	a0,0x3
ffffffffc02017ae:	e3650513          	addi	a0,a0,-458 # ffffffffc02045e0 <etext+0x972>
ffffffffc02017b2:	93bfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02017b6:	00003697          	auipc	a3,0x3
ffffffffc02017ba:	0f268693          	addi	a3,a3,242 # ffffffffc02048a8 <etext+0xc3a>
ffffffffc02017be:	00003617          	auipc	a2,0x3
ffffffffc02017c2:	bfa60613          	addi	a2,a2,-1030 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02017c6:	16d00593          	li	a1,365
ffffffffc02017ca:	00003517          	auipc	a0,0x3
ffffffffc02017ce:	e1650513          	addi	a0,a0,-490 # ffffffffc02045e0 <etext+0x972>
ffffffffc02017d2:	91bfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02017d6:	00003697          	auipc	a3,0x3
ffffffffc02017da:	14a68693          	addi	a3,a3,330 # ffffffffc0204920 <etext+0xcb2>
ffffffffc02017de:	00003617          	auipc	a2,0x3
ffffffffc02017e2:	bda60613          	addi	a2,a2,-1062 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02017e6:	17900593          	li	a1,377
ffffffffc02017ea:	00003517          	auipc	a0,0x3
ffffffffc02017ee:	df650513          	addi	a0,a0,-522 # ffffffffc02045e0 <etext+0x972>
ffffffffc02017f2:	8fbfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02017f6:	00003617          	auipc	a2,0x3
ffffffffc02017fa:	e8260613          	addi	a2,a2,-382 # ffffffffc0204678 <etext+0xa0a>
ffffffffc02017fe:	07700593          	li	a1,119
ffffffffc0201802:	00003517          	auipc	a0,0x3
ffffffffc0201806:	dde50513          	addi	a0,a0,-546 # ffffffffc02045e0 <etext+0x972>
ffffffffc020180a:	8e3fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020180e:	00003697          	auipc	a3,0x3
ffffffffc0201812:	30a68693          	addi	a3,a3,778 # ffffffffc0204b18 <etext+0xeaa>
ffffffffc0201816:	00003617          	auipc	a2,0x3
ffffffffc020181a:	ba260613          	addi	a2,a2,-1118 # ffffffffc02043b8 <etext+0x74a>
ffffffffc020181e:	19d00593          	li	a1,413
ffffffffc0201822:	00003517          	auipc	a0,0x3
ffffffffc0201826:	dbe50513          	addi	a0,a0,-578 # ffffffffc02045e0 <etext+0x972>
ffffffffc020182a:	8c3fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020182e:	00003697          	auipc	a3,0x3
ffffffffc0201832:	22a68693          	addi	a3,a3,554 # ffffffffc0204a58 <etext+0xdea>
ffffffffc0201836:	00003617          	auipc	a2,0x3
ffffffffc020183a:	b8260613          	addi	a2,a2,-1150 # ffffffffc02043b8 <etext+0x74a>
ffffffffc020183e:	19400593          	li	a1,404
ffffffffc0201842:	00003517          	auipc	a0,0x3
ffffffffc0201846:	d9e50513          	addi	a0,a0,-610 # ffffffffc02045e0 <etext+0x972>
ffffffffc020184a:	8a3fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020184e:	00003697          	auipc	a3,0x3
ffffffffc0201852:	1d268693          	addi	a3,a3,466 # ffffffffc0204a20 <etext+0xdb2>
ffffffffc0201856:	00003617          	auipc	a2,0x3
ffffffffc020185a:	b6260613          	addi	a2,a2,-1182 # ffffffffc02043b8 <etext+0x74a>
ffffffffc020185e:	19300593          	li	a1,403
ffffffffc0201862:	00003517          	auipc	a0,0x3
ffffffffc0201866:	d7e50513          	addi	a0,a0,-642 # ffffffffc02045e0 <etext+0x972>
ffffffffc020186a:	883fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020186e:	00003617          	auipc	a2,0x3
ffffffffc0201872:	d4a60613          	addi	a2,a2,-694 # ffffffffc02045b8 <etext+0x94a>
ffffffffc0201876:	06a00593          	li	a1,106
ffffffffc020187a:	00003517          	auipc	a0,0x3
ffffffffc020187e:	d2e50513          	addi	a0,a0,-722 # ffffffffc02045a8 <etext+0x93a>
ffffffffc0201882:	86bfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201886:	00003697          	auipc	a3,0x3
ffffffffc020188a:	25a68693          	addi	a3,a3,602 # ffffffffc0204ae0 <etext+0xe72>
ffffffffc020188e:	00003617          	auipc	a2,0x3
ffffffffc0201892:	b2a60613          	addi	a2,a2,-1238 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201896:	19a00593          	li	a1,410
ffffffffc020189a:	00003517          	auipc	a0,0x3
ffffffffc020189e:	d4650513          	addi	a0,a0,-698 # ffffffffc02045e0 <etext+0x972>
ffffffffc02018a2:	84bfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02018a6:	00003697          	auipc	a3,0x3
ffffffffc02018aa:	20a68693          	addi	a3,a3,522 # ffffffffc0204ab0 <etext+0xe42>
ffffffffc02018ae:	00003617          	auipc	a2,0x3
ffffffffc02018b2:	b0a60613          	addi	a2,a2,-1270 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02018b6:	19600593          	li	a1,406
ffffffffc02018ba:	00003517          	auipc	a0,0x3
ffffffffc02018be:	d2650513          	addi	a0,a0,-730 # ffffffffc02045e0 <etext+0x972>
ffffffffc02018c2:	82bfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02018c6:	00003697          	auipc	a3,0x3
ffffffffc02018ca:	07268693          	addi	a3,a3,114 # ffffffffc0204938 <etext+0xcca>
ffffffffc02018ce:	00003617          	auipc	a2,0x3
ffffffffc02018d2:	aea60613          	addi	a2,a2,-1302 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02018d6:	17500593          	li	a1,373
ffffffffc02018da:	00003517          	auipc	a0,0x3
ffffffffc02018de:	d0650513          	addi	a0,a0,-762 # ffffffffc02045e0 <etext+0x972>
ffffffffc02018e2:	80bfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02018e6:	00003697          	auipc	a3,0x3
ffffffffc02018ea:	12268693          	addi	a3,a3,290 # ffffffffc0204a08 <etext+0xd9a>
ffffffffc02018ee:	00003617          	auipc	a2,0x3
ffffffffc02018f2:	aca60613          	addi	a2,a2,-1334 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02018f6:	18f00593          	li	a1,399
ffffffffc02018fa:	00003517          	auipc	a0,0x3
ffffffffc02018fe:	ce650513          	addi	a0,a0,-794 # ffffffffc02045e0 <etext+0x972>
ffffffffc0201902:	feafe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201906:	00003697          	auipc	a3,0x3
ffffffffc020190a:	e1268693          	addi	a3,a3,-494 # ffffffffc0204718 <etext+0xaaa>
ffffffffc020190e:	00003617          	auipc	a2,0x3
ffffffffc0201912:	aaa60613          	addi	a2,a2,-1366 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201916:	15a00593          	li	a1,346
ffffffffc020191a:	00003517          	auipc	a0,0x3
ffffffffc020191e:	cc650513          	addi	a0,a0,-826 # ffffffffc02045e0 <etext+0x972>
ffffffffc0201922:	fcafe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201926:	00003697          	auipc	a3,0x3
ffffffffc020192a:	d9a68693          	addi	a3,a3,-614 # ffffffffc02046c0 <etext+0xa52>
ffffffffc020192e:	00003617          	auipc	a2,0x3
ffffffffc0201932:	a8a60613          	addi	a2,a2,-1398 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201936:	15800593          	li	a1,344
ffffffffc020193a:	00003517          	auipc	a0,0x3
ffffffffc020193e:	ca650513          	addi	a0,a0,-858 # ffffffffc02045e0 <etext+0x972>
ffffffffc0201942:	faafe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201946:	86aa                	mv	a3,a0
ffffffffc0201948:	00003617          	auipc	a2,0x3
ffffffffc020194c:	d3060613          	addi	a2,a2,-720 # ffffffffc0204678 <etext+0xa0a>
ffffffffc0201950:	0bd00593          	li	a1,189
ffffffffc0201954:	00003517          	auipc	a0,0x3
ffffffffc0201958:	c8c50513          	addi	a0,a0,-884 # ffffffffc02045e0 <etext+0x972>
ffffffffc020195c:	f90fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201960:	00003697          	auipc	a3,0x3
ffffffffc0201964:	00868693          	addi	a3,a3,8 # ffffffffc0204968 <etext+0xcfa>
ffffffffc0201968:	00003617          	auipc	a2,0x3
ffffffffc020196c:	a5060613          	addi	a2,a2,-1456 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201970:	17f00593          	li	a1,383
ffffffffc0201974:	00003517          	auipc	a0,0x3
ffffffffc0201978:	c6c50513          	addi	a0,a0,-916 # ffffffffc02045e0 <etext+0x972>
ffffffffc020197c:	f70fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201980:	00003697          	auipc	a3,0x3
ffffffffc0201984:	fa068693          	addi	a3,a3,-96 # ffffffffc0204920 <etext+0xcb2>
ffffffffc0201988:	00003617          	auipc	a2,0x3
ffffffffc020198c:	a3060613          	addi	a2,a2,-1488 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201990:	17d00593          	li	a1,381
ffffffffc0201994:	00003517          	auipc	a0,0x3
ffffffffc0201998:	c4c50513          	addi	a0,a0,-948 # ffffffffc02045e0 <etext+0x972>
ffffffffc020199c:	f50fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02019a0:	00003697          	auipc	a3,0x3
ffffffffc02019a4:	dd068693          	addi	a3,a3,-560 # ffffffffc0204770 <etext+0xb02>
ffffffffc02019a8:	00003617          	auipc	a2,0x3
ffffffffc02019ac:	a1060613          	addi	a2,a2,-1520 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02019b0:	16000593          	li	a1,352
ffffffffc02019b4:	00003517          	auipc	a0,0x3
ffffffffc02019b8:	c2c50513          	addi	a0,a0,-980 # ffffffffc02045e0 <etext+0x972>
ffffffffc02019bc:	f30fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02019c0:	00003697          	auipc	a3,0x3
ffffffffc02019c4:	0b068693          	addi	a3,a3,176 # ffffffffc0204a70 <etext+0xe02>
ffffffffc02019c8:	00003617          	auipc	a2,0x3
ffffffffc02019cc:	9f060613          	addi	a2,a2,-1552 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02019d0:	19500593          	li	a1,405
ffffffffc02019d4:	00003517          	auipc	a0,0x3
ffffffffc02019d8:	c0c50513          	addi	a0,a0,-1012 # ffffffffc02045e0 <etext+0x972>
ffffffffc02019dc:	f10fe0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc02019e0 <tlb_invalidate>:
ffffffffc02019e0:	12000073          	sfence.vma
ffffffffc02019e4:	8082                	ret

ffffffffc02019e6 <pgdir_alloc_page>:
ffffffffc02019e6:	7179                	addi	sp,sp,-48
ffffffffc02019e8:	e84a                	sd	s2,16(sp)
ffffffffc02019ea:	892a                	mv	s2,a0
ffffffffc02019ec:	4505                	li	a0,1
ffffffffc02019ee:	f022                	sd	s0,32(sp)
ffffffffc02019f0:	ec26                	sd	s1,24(sp)
ffffffffc02019f2:	e44e                	sd	s3,8(sp)
ffffffffc02019f4:	f406                	sd	ra,40(sp)
ffffffffc02019f6:	84ae                	mv	s1,a1
ffffffffc02019f8:	89b2                	mv	s3,a2
ffffffffc02019fa:	9ceff0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc02019fe:	842a                	mv	s0,a0
ffffffffc0201a00:	cd09                	beqz	a0,ffffffffc0201a1a <pgdir_alloc_page+0x34>
ffffffffc0201a02:	85aa                	mv	a1,a0
ffffffffc0201a04:	86ce                	mv	a3,s3
ffffffffc0201a06:	8626                	mv	a2,s1
ffffffffc0201a08:	854a                	mv	a0,s2
ffffffffc0201a0a:	d8cff0ef          	jal	ra,ffffffffc0200f96 <page_insert>
ffffffffc0201a0e:	ed21                	bnez	a0,ffffffffc0201a66 <pgdir_alloc_page+0x80>
ffffffffc0201a10:	0000e797          	auipc	a5,0xe
ffffffffc0201a14:	6607a783          	lw	a5,1632(a5) # ffffffffc0210070 <swap_init_ok>
ffffffffc0201a18:	eb89                	bnez	a5,ffffffffc0201a2a <pgdir_alloc_page+0x44>
ffffffffc0201a1a:	70a2                	ld	ra,40(sp)
ffffffffc0201a1c:	8522                	mv	a0,s0
ffffffffc0201a1e:	7402                	ld	s0,32(sp)
ffffffffc0201a20:	64e2                	ld	s1,24(sp)
ffffffffc0201a22:	6942                	ld	s2,16(sp)
ffffffffc0201a24:	69a2                	ld	s3,8(sp)
ffffffffc0201a26:	6145                	addi	sp,sp,48
ffffffffc0201a28:	8082                	ret
ffffffffc0201a2a:	4681                	li	a3,0
ffffffffc0201a2c:	8622                	mv	a2,s0
ffffffffc0201a2e:	85a6                	mv	a1,s1
ffffffffc0201a30:	0000e517          	auipc	a0,0xe
ffffffffc0201a34:	68853503          	ld	a0,1672(a0) # ffffffffc02100b8 <check_mm_struct>
ffffffffc0201a38:	7dd000ef          	jal	ra,ffffffffc0202a14 <swap_map_swappable>
ffffffffc0201a3c:	4018                	lw	a4,0(s0)
ffffffffc0201a3e:	e024                	sd	s1,64(s0)
ffffffffc0201a40:	4785                	li	a5,1
ffffffffc0201a42:	fcf70ce3          	beq	a4,a5,ffffffffc0201a1a <pgdir_alloc_page+0x34>
ffffffffc0201a46:	00003697          	auipc	a3,0x3
ffffffffc0201a4a:	11a68693          	addi	a3,a3,282 # ffffffffc0204b60 <etext+0xef2>
ffffffffc0201a4e:	00003617          	auipc	a2,0x3
ffffffffc0201a52:	96a60613          	addi	a2,a2,-1686 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201a56:	14800593          	li	a1,328
ffffffffc0201a5a:	00003517          	auipc	a0,0x3
ffffffffc0201a5e:	b8650513          	addi	a0,a0,-1146 # ffffffffc02045e0 <etext+0x972>
ffffffffc0201a62:	e8afe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201a66:	8522                	mv	a0,s0
ffffffffc0201a68:	4585                	li	a1,1
ffffffffc0201a6a:	9f0ff0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0201a6e:	4401                	li	s0,0
ffffffffc0201a70:	b76d                	j	ffffffffc0201a1a <pgdir_alloc_page+0x34>

ffffffffc0201a72 <kmalloc>:
ffffffffc0201a72:	1141                	addi	sp,sp,-16
ffffffffc0201a74:	67d5                	lui	a5,0x15
ffffffffc0201a76:	e406                	sd	ra,8(sp)
ffffffffc0201a78:	fff50713          	addi	a4,a0,-1
ffffffffc0201a7c:	17f9                	addi	a5,a5,-2
ffffffffc0201a7e:	04e7ea63          	bltu	a5,a4,ffffffffc0201ad2 <kmalloc+0x60>
ffffffffc0201a82:	6785                	lui	a5,0x1
ffffffffc0201a84:	17fd                	addi	a5,a5,-1
ffffffffc0201a86:	953e                	add	a0,a0,a5
ffffffffc0201a88:	8131                	srli	a0,a0,0xc
ffffffffc0201a8a:	93eff0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0201a8e:	cd3d                	beqz	a0,ffffffffc0201b0c <kmalloc+0x9a>
ffffffffc0201a90:	0000e797          	auipc	a5,0xe
ffffffffc0201a94:	6207b783          	ld	a5,1568(a5) # ffffffffc02100b0 <pages>
ffffffffc0201a98:	8d1d                	sub	a0,a0,a5
ffffffffc0201a9a:	00004697          	auipc	a3,0x4
ffffffffc0201a9e:	e2e6b683          	ld	a3,-466(a3) # ffffffffc02058c8 <error_string+0x38>
ffffffffc0201aa2:	850d                	srai	a0,a0,0x3
ffffffffc0201aa4:	02d50533          	mul	a0,a0,a3
ffffffffc0201aa8:	000806b7          	lui	a3,0x80
ffffffffc0201aac:	0000e717          	auipc	a4,0xe
ffffffffc0201ab0:	5ac73703          	ld	a4,1452(a4) # ffffffffc0210058 <npage>
ffffffffc0201ab4:	9536                	add	a0,a0,a3
ffffffffc0201ab6:	00c51793          	slli	a5,a0,0xc
ffffffffc0201aba:	83b1                	srli	a5,a5,0xc
ffffffffc0201abc:	0532                	slli	a0,a0,0xc
ffffffffc0201abe:	02e7fa63          	bgeu	a5,a4,ffffffffc0201af2 <kmalloc+0x80>
ffffffffc0201ac2:	60a2                	ld	ra,8(sp)
ffffffffc0201ac4:	0000e797          	auipc	a5,0xe
ffffffffc0201ac8:	5e47b783          	ld	a5,1508(a5) # ffffffffc02100a8 <va_pa_offset>
ffffffffc0201acc:	953e                	add	a0,a0,a5
ffffffffc0201ace:	0141                	addi	sp,sp,16
ffffffffc0201ad0:	8082                	ret
ffffffffc0201ad2:	00003697          	auipc	a3,0x3
ffffffffc0201ad6:	0a668693          	addi	a3,a3,166 # ffffffffc0204b78 <etext+0xf0a>
ffffffffc0201ada:	00003617          	auipc	a2,0x3
ffffffffc0201ade:	8de60613          	addi	a2,a2,-1826 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201ae2:	1a900593          	li	a1,425
ffffffffc0201ae6:	00003517          	auipc	a0,0x3
ffffffffc0201aea:	afa50513          	addi	a0,a0,-1286 # ffffffffc02045e0 <etext+0x972>
ffffffffc0201aee:	dfefe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201af2:	86aa                	mv	a3,a0
ffffffffc0201af4:	00003617          	auipc	a2,0x3
ffffffffc0201af8:	ac460613          	addi	a2,a2,-1340 # ffffffffc02045b8 <etext+0x94a>
ffffffffc0201afc:	06a00593          	li	a1,106
ffffffffc0201b00:	00003517          	auipc	a0,0x3
ffffffffc0201b04:	aa850513          	addi	a0,a0,-1368 # ffffffffc02045a8 <etext+0x93a>
ffffffffc0201b08:	de4fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201b0c:	00003697          	auipc	a3,0x3
ffffffffc0201b10:	08c68693          	addi	a3,a3,140 # ffffffffc0204b98 <etext+0xf2a>
ffffffffc0201b14:	00003617          	auipc	a2,0x3
ffffffffc0201b18:	8a460613          	addi	a2,a2,-1884 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201b1c:	1ac00593          	li	a1,428
ffffffffc0201b20:	00003517          	auipc	a0,0x3
ffffffffc0201b24:	ac050513          	addi	a0,a0,-1344 # ffffffffc02045e0 <etext+0x972>
ffffffffc0201b28:	dc4fe0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0201b2c <kfree>:
ffffffffc0201b2c:	1141                	addi	sp,sp,-16
ffffffffc0201b2e:	67d5                	lui	a5,0x15
ffffffffc0201b30:	e406                	sd	ra,8(sp)
ffffffffc0201b32:	fff58713          	addi	a4,a1,-1
ffffffffc0201b36:	17f9                	addi	a5,a5,-2
ffffffffc0201b38:	04e7e763          	bltu	a5,a4,ffffffffc0201b86 <kfree+0x5a>
ffffffffc0201b3c:	c541                	beqz	a0,ffffffffc0201bc4 <kfree+0x98>
ffffffffc0201b3e:	6785                	lui	a5,0x1
ffffffffc0201b40:	17fd                	addi	a5,a5,-1
ffffffffc0201b42:	95be                	add	a1,a1,a5
ffffffffc0201b44:	c02007b7          	lui	a5,0xc0200
ffffffffc0201b48:	81b1                	srli	a1,a1,0xc
ffffffffc0201b4a:	06f56063          	bltu	a0,a5,ffffffffc0201baa <kfree+0x7e>
ffffffffc0201b4e:	0000e697          	auipc	a3,0xe
ffffffffc0201b52:	55a6b683          	ld	a3,1370(a3) # ffffffffc02100a8 <va_pa_offset>
ffffffffc0201b56:	8d15                	sub	a0,a0,a3
ffffffffc0201b58:	8131                	srli	a0,a0,0xc
ffffffffc0201b5a:	0000e797          	auipc	a5,0xe
ffffffffc0201b5e:	4fe7b783          	ld	a5,1278(a5) # ffffffffc0210058 <npage>
ffffffffc0201b62:	04f57263          	bgeu	a0,a5,ffffffffc0201ba6 <kfree+0x7a>
ffffffffc0201b66:	fff806b7          	lui	a3,0xfff80
ffffffffc0201b6a:	9536                	add	a0,a0,a3
ffffffffc0201b6c:	00351793          	slli	a5,a0,0x3
ffffffffc0201b70:	60a2                	ld	ra,8(sp)
ffffffffc0201b72:	953e                	add	a0,a0,a5
ffffffffc0201b74:	050e                	slli	a0,a0,0x3
ffffffffc0201b76:	0000e797          	auipc	a5,0xe
ffffffffc0201b7a:	53a7b783          	ld	a5,1338(a5) # ffffffffc02100b0 <pages>
ffffffffc0201b7e:	953e                	add	a0,a0,a5
ffffffffc0201b80:	0141                	addi	sp,sp,16
ffffffffc0201b82:	8d8ff06f          	j	ffffffffc0200c5a <free_pages>
ffffffffc0201b86:	00003697          	auipc	a3,0x3
ffffffffc0201b8a:	ff268693          	addi	a3,a3,-14 # ffffffffc0204b78 <etext+0xf0a>
ffffffffc0201b8e:	00003617          	auipc	a2,0x3
ffffffffc0201b92:	82a60613          	addi	a2,a2,-2006 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201b96:	1b200593          	li	a1,434
ffffffffc0201b9a:	00003517          	auipc	a0,0x3
ffffffffc0201b9e:	a4650513          	addi	a0,a0,-1466 # ffffffffc02045e0 <etext+0x972>
ffffffffc0201ba2:	d4afe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201ba6:	806ff0ef          	jal	ra,ffffffffc0200bac <pa2page.part.0>
ffffffffc0201baa:	86aa                	mv	a3,a0
ffffffffc0201bac:	00003617          	auipc	a2,0x3
ffffffffc0201bb0:	acc60613          	addi	a2,a2,-1332 # ffffffffc0204678 <etext+0xa0a>
ffffffffc0201bb4:	06c00593          	li	a1,108
ffffffffc0201bb8:	00003517          	auipc	a0,0x3
ffffffffc0201bbc:	9f050513          	addi	a0,a0,-1552 # ffffffffc02045a8 <etext+0x93a>
ffffffffc0201bc0:	d2cfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201bc4:	00003697          	auipc	a3,0x3
ffffffffc0201bc8:	fe468693          	addi	a3,a3,-28 # ffffffffc0204ba8 <etext+0xf3a>
ffffffffc0201bcc:	00002617          	auipc	a2,0x2
ffffffffc0201bd0:	7ec60613          	addi	a2,a2,2028 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201bd4:	1b300593          	li	a1,435
ffffffffc0201bd8:	00003517          	auipc	a0,0x3
ffffffffc0201bdc:	a0850513          	addi	a0,a0,-1528 # ffffffffc02045e0 <etext+0x972>
ffffffffc0201be0:	d0cfe0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0201be4 <check_vma_overlap.isra.0.part.0>:
ffffffffc0201be4:	1141                	addi	sp,sp,-16
ffffffffc0201be6:	00003697          	auipc	a3,0x3
ffffffffc0201bea:	fd268693          	addi	a3,a3,-46 # ffffffffc0204bb8 <etext+0xf4a>
ffffffffc0201bee:	00002617          	auipc	a2,0x2
ffffffffc0201bf2:	7ca60613          	addi	a2,a2,1994 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201bf6:	07c00593          	li	a1,124
ffffffffc0201bfa:	00003517          	auipc	a0,0x3
ffffffffc0201bfe:	fde50513          	addi	a0,a0,-34 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc0201c02:	e406                	sd	ra,8(sp)
ffffffffc0201c04:	ce8fe0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0201c08 <mm_create>:
ffffffffc0201c08:	1141                	addi	sp,sp,-16
ffffffffc0201c0a:	03000513          	li	a0,48
ffffffffc0201c0e:	e022                	sd	s0,0(sp)
ffffffffc0201c10:	e406                	sd	ra,8(sp)
ffffffffc0201c12:	e61ff0ef          	jal	ra,ffffffffc0201a72 <kmalloc>
ffffffffc0201c16:	842a                	mv	s0,a0
ffffffffc0201c18:	c105                	beqz	a0,ffffffffc0201c38 <mm_create+0x30>
ffffffffc0201c1a:	e408                	sd	a0,8(s0)
ffffffffc0201c1c:	e008                	sd	a0,0(s0)
ffffffffc0201c1e:	00053823          	sd	zero,16(a0)
ffffffffc0201c22:	00053c23          	sd	zero,24(a0)
ffffffffc0201c26:	02052023          	sw	zero,32(a0)
ffffffffc0201c2a:	0000e797          	auipc	a5,0xe
ffffffffc0201c2e:	4467a783          	lw	a5,1094(a5) # ffffffffc0210070 <swap_init_ok>
ffffffffc0201c32:	eb81                	bnez	a5,ffffffffc0201c42 <mm_create+0x3a>
ffffffffc0201c34:	02053423          	sd	zero,40(a0)
ffffffffc0201c38:	60a2                	ld	ra,8(sp)
ffffffffc0201c3a:	8522                	mv	a0,s0
ffffffffc0201c3c:	6402                	ld	s0,0(sp)
ffffffffc0201c3e:	0141                	addi	sp,sp,16
ffffffffc0201c40:	8082                	ret
ffffffffc0201c42:	5c5000ef          	jal	ra,ffffffffc0202a06 <swap_init_mm>
ffffffffc0201c46:	60a2                	ld	ra,8(sp)
ffffffffc0201c48:	8522                	mv	a0,s0
ffffffffc0201c4a:	6402                	ld	s0,0(sp)
ffffffffc0201c4c:	0141                	addi	sp,sp,16
ffffffffc0201c4e:	8082                	ret

ffffffffc0201c50 <vma_create>:
ffffffffc0201c50:	1101                	addi	sp,sp,-32
ffffffffc0201c52:	e04a                	sd	s2,0(sp)
ffffffffc0201c54:	892a                	mv	s2,a0
ffffffffc0201c56:	03000513          	li	a0,48
ffffffffc0201c5a:	e822                	sd	s0,16(sp)
ffffffffc0201c5c:	e426                	sd	s1,8(sp)
ffffffffc0201c5e:	ec06                	sd	ra,24(sp)
ffffffffc0201c60:	84ae                	mv	s1,a1
ffffffffc0201c62:	8432                	mv	s0,a2
ffffffffc0201c64:	e0fff0ef          	jal	ra,ffffffffc0201a72 <kmalloc>
ffffffffc0201c68:	c509                	beqz	a0,ffffffffc0201c72 <vma_create+0x22>
ffffffffc0201c6a:	01253423          	sd	s2,8(a0)
ffffffffc0201c6e:	e904                	sd	s1,16(a0)
ffffffffc0201c70:	ed00                	sd	s0,24(a0)
ffffffffc0201c72:	60e2                	ld	ra,24(sp)
ffffffffc0201c74:	6442                	ld	s0,16(sp)
ffffffffc0201c76:	64a2                	ld	s1,8(sp)
ffffffffc0201c78:	6902                	ld	s2,0(sp)
ffffffffc0201c7a:	6105                	addi	sp,sp,32
ffffffffc0201c7c:	8082                	ret

ffffffffc0201c7e <find_vma>:
ffffffffc0201c7e:	86aa                	mv	a3,a0
ffffffffc0201c80:	c505                	beqz	a0,ffffffffc0201ca8 <find_vma+0x2a>
ffffffffc0201c82:	6908                	ld	a0,16(a0)
ffffffffc0201c84:	c501                	beqz	a0,ffffffffc0201c8c <find_vma+0xe>
ffffffffc0201c86:	651c                	ld	a5,8(a0)
ffffffffc0201c88:	02f5f263          	bgeu	a1,a5,ffffffffc0201cac <find_vma+0x2e>
ffffffffc0201c8c:	669c                	ld	a5,8(a3)
ffffffffc0201c8e:	00f68d63          	beq	a3,a5,ffffffffc0201ca8 <find_vma+0x2a>
ffffffffc0201c92:	fe87b703          	ld	a4,-24(a5)
ffffffffc0201c96:	00e5e663          	bltu	a1,a4,ffffffffc0201ca2 <find_vma+0x24>
ffffffffc0201c9a:	ff07b703          	ld	a4,-16(a5)
ffffffffc0201c9e:	00e5ec63          	bltu	a1,a4,ffffffffc0201cb6 <find_vma+0x38>
ffffffffc0201ca2:	679c                	ld	a5,8(a5)
ffffffffc0201ca4:	fef697e3          	bne	a3,a5,ffffffffc0201c92 <find_vma+0x14>
ffffffffc0201ca8:	4501                	li	a0,0
ffffffffc0201caa:	8082                	ret
ffffffffc0201cac:	691c                	ld	a5,16(a0)
ffffffffc0201cae:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0201c8c <find_vma+0xe>
ffffffffc0201cb2:	ea88                	sd	a0,16(a3)
ffffffffc0201cb4:	8082                	ret
ffffffffc0201cb6:	fe078513          	addi	a0,a5,-32
ffffffffc0201cba:	ea88                	sd	a0,16(a3)
ffffffffc0201cbc:	8082                	ret

ffffffffc0201cbe <insert_vma_struct>:
ffffffffc0201cbe:	6590                	ld	a2,8(a1)
ffffffffc0201cc0:	0105b803          	ld	a6,16(a1)
ffffffffc0201cc4:	1141                	addi	sp,sp,-16
ffffffffc0201cc6:	e406                	sd	ra,8(sp)
ffffffffc0201cc8:	87aa                	mv	a5,a0
ffffffffc0201cca:	01066763          	bltu	a2,a6,ffffffffc0201cd8 <insert_vma_struct+0x1a>
ffffffffc0201cce:	a085                	j	ffffffffc0201d2e <insert_vma_struct+0x70>
ffffffffc0201cd0:	fe87b703          	ld	a4,-24(a5)
ffffffffc0201cd4:	04e66863          	bltu	a2,a4,ffffffffc0201d24 <insert_vma_struct+0x66>
ffffffffc0201cd8:	86be                	mv	a3,a5
ffffffffc0201cda:	679c                	ld	a5,8(a5)
ffffffffc0201cdc:	fef51ae3          	bne	a0,a5,ffffffffc0201cd0 <insert_vma_struct+0x12>
ffffffffc0201ce0:	02a68463          	beq	a3,a0,ffffffffc0201d08 <insert_vma_struct+0x4a>
ffffffffc0201ce4:	ff06b703          	ld	a4,-16(a3)
ffffffffc0201ce8:	fe86b883          	ld	a7,-24(a3)
ffffffffc0201cec:	08e8f163          	bgeu	a7,a4,ffffffffc0201d6e <insert_vma_struct+0xb0>
ffffffffc0201cf0:	04e66f63          	bltu	a2,a4,ffffffffc0201d4e <insert_vma_struct+0x90>
ffffffffc0201cf4:	00f50a63          	beq	a0,a5,ffffffffc0201d08 <insert_vma_struct+0x4a>
ffffffffc0201cf8:	fe87b703          	ld	a4,-24(a5)
ffffffffc0201cfc:	05076963          	bltu	a4,a6,ffffffffc0201d4e <insert_vma_struct+0x90>
ffffffffc0201d00:	ff07b603          	ld	a2,-16(a5)
ffffffffc0201d04:	02c77363          	bgeu	a4,a2,ffffffffc0201d2a <insert_vma_struct+0x6c>
ffffffffc0201d08:	5118                	lw	a4,32(a0)
ffffffffc0201d0a:	e188                	sd	a0,0(a1)
ffffffffc0201d0c:	02058613          	addi	a2,a1,32
ffffffffc0201d10:	e390                	sd	a2,0(a5)
ffffffffc0201d12:	e690                	sd	a2,8(a3)
ffffffffc0201d14:	60a2                	ld	ra,8(sp)
ffffffffc0201d16:	f59c                	sd	a5,40(a1)
ffffffffc0201d18:	f194                	sd	a3,32(a1)
ffffffffc0201d1a:	0017079b          	addiw	a5,a4,1
ffffffffc0201d1e:	d11c                	sw	a5,32(a0)
ffffffffc0201d20:	0141                	addi	sp,sp,16
ffffffffc0201d22:	8082                	ret
ffffffffc0201d24:	fca690e3          	bne	a3,a0,ffffffffc0201ce4 <insert_vma_struct+0x26>
ffffffffc0201d28:	bfd1                	j	ffffffffc0201cfc <insert_vma_struct+0x3e>
ffffffffc0201d2a:	ebbff0ef          	jal	ra,ffffffffc0201be4 <check_vma_overlap.isra.0.part.0>
ffffffffc0201d2e:	00003697          	auipc	a3,0x3
ffffffffc0201d32:	eba68693          	addi	a3,a3,-326 # ffffffffc0204be8 <etext+0xf7a>
ffffffffc0201d36:	00002617          	auipc	a2,0x2
ffffffffc0201d3a:	68260613          	addi	a2,a2,1666 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201d3e:	08300593          	li	a1,131
ffffffffc0201d42:	00003517          	auipc	a0,0x3
ffffffffc0201d46:	e9650513          	addi	a0,a0,-362 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc0201d4a:	ba2fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201d4e:	00003697          	auipc	a3,0x3
ffffffffc0201d52:	eda68693          	addi	a3,a3,-294 # ffffffffc0204c28 <etext+0xfba>
ffffffffc0201d56:	00002617          	auipc	a2,0x2
ffffffffc0201d5a:	66260613          	addi	a2,a2,1634 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201d5e:	07b00593          	li	a1,123
ffffffffc0201d62:	00003517          	auipc	a0,0x3
ffffffffc0201d66:	e7650513          	addi	a0,a0,-394 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc0201d6a:	b82fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201d6e:	00003697          	auipc	a3,0x3
ffffffffc0201d72:	e9a68693          	addi	a3,a3,-358 # ffffffffc0204c08 <etext+0xf9a>
ffffffffc0201d76:	00002617          	auipc	a2,0x2
ffffffffc0201d7a:	64260613          	addi	a2,a2,1602 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201d7e:	07a00593          	li	a1,122
ffffffffc0201d82:	00003517          	auipc	a0,0x3
ffffffffc0201d86:	e5650513          	addi	a0,a0,-426 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc0201d8a:	b62fe0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0201d8e <mm_destroy>:
ffffffffc0201d8e:	1141                	addi	sp,sp,-16
ffffffffc0201d90:	e022                	sd	s0,0(sp)
ffffffffc0201d92:	842a                	mv	s0,a0
ffffffffc0201d94:	6508                	ld	a0,8(a0)
ffffffffc0201d96:	e406                	sd	ra,8(sp)
ffffffffc0201d98:	00a40e63          	beq	s0,a0,ffffffffc0201db4 <mm_destroy+0x26>
ffffffffc0201d9c:	6118                	ld	a4,0(a0)
ffffffffc0201d9e:	651c                	ld	a5,8(a0)
ffffffffc0201da0:	03000593          	li	a1,48
ffffffffc0201da4:	1501                	addi	a0,a0,-32
ffffffffc0201da6:	e71c                	sd	a5,8(a4)
ffffffffc0201da8:	e398                	sd	a4,0(a5)
ffffffffc0201daa:	d83ff0ef          	jal	ra,ffffffffc0201b2c <kfree>
ffffffffc0201dae:	6408                	ld	a0,8(s0)
ffffffffc0201db0:	fea416e3          	bne	s0,a0,ffffffffc0201d9c <mm_destroy+0xe>
ffffffffc0201db4:	8522                	mv	a0,s0
ffffffffc0201db6:	6402                	ld	s0,0(sp)
ffffffffc0201db8:	60a2                	ld	ra,8(sp)
ffffffffc0201dba:	03000593          	li	a1,48
ffffffffc0201dbe:	0141                	addi	sp,sp,16
ffffffffc0201dc0:	b3b5                	j	ffffffffc0201b2c <kfree>

ffffffffc0201dc2 <vmm_init>:
ffffffffc0201dc2:	715d                	addi	sp,sp,-80
ffffffffc0201dc4:	e486                	sd	ra,72(sp)
ffffffffc0201dc6:	e0a2                	sd	s0,64(sp)
ffffffffc0201dc8:	fc26                	sd	s1,56(sp)
ffffffffc0201dca:	f84a                	sd	s2,48(sp)
ffffffffc0201dcc:	f052                	sd	s4,32(sp)
ffffffffc0201dce:	f44e                	sd	s3,40(sp)
ffffffffc0201dd0:	ec56                	sd	s5,24(sp)
ffffffffc0201dd2:	e85a                	sd	s6,16(sp)
ffffffffc0201dd4:	e45e                	sd	s7,8(sp)
ffffffffc0201dd6:	ec7fe0ef          	jal	ra,ffffffffc0200c9c <nr_free_pages>
ffffffffc0201dda:	892a                	mv	s2,a0
ffffffffc0201ddc:	ec1fe0ef          	jal	ra,ffffffffc0200c9c <nr_free_pages>
ffffffffc0201de0:	8a2a                	mv	s4,a0
ffffffffc0201de2:	e27ff0ef          	jal	ra,ffffffffc0201c08 <mm_create>
ffffffffc0201de6:	842a                	mv	s0,a0
ffffffffc0201de8:	03200493          	li	s1,50
ffffffffc0201dec:	e919                	bnez	a0,ffffffffc0201e02 <vmm_init+0x40>
ffffffffc0201dee:	aed5                	j	ffffffffc02021e2 <vmm_init+0x420>
ffffffffc0201df0:	e504                	sd	s1,8(a0)
ffffffffc0201df2:	e91c                	sd	a5,16(a0)
ffffffffc0201df4:	00053c23          	sd	zero,24(a0)
ffffffffc0201df8:	14ed                	addi	s1,s1,-5
ffffffffc0201dfa:	8522                	mv	a0,s0
ffffffffc0201dfc:	ec3ff0ef          	jal	ra,ffffffffc0201cbe <insert_vma_struct>
ffffffffc0201e00:	c88d                	beqz	s1,ffffffffc0201e32 <vmm_init+0x70>
ffffffffc0201e02:	03000513          	li	a0,48
ffffffffc0201e06:	c6dff0ef          	jal	ra,ffffffffc0201a72 <kmalloc>
ffffffffc0201e0a:	85aa                	mv	a1,a0
ffffffffc0201e0c:	00248793          	addi	a5,s1,2
ffffffffc0201e10:	f165                	bnez	a0,ffffffffc0201df0 <vmm_init+0x2e>
ffffffffc0201e12:	00003697          	auipc	a3,0x3
ffffffffc0201e16:	05e68693          	addi	a3,a3,94 # ffffffffc0204e70 <etext+0x1202>
ffffffffc0201e1a:	00002617          	auipc	a2,0x2
ffffffffc0201e1e:	59e60613          	addi	a2,a2,1438 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201e22:	0cd00593          	li	a1,205
ffffffffc0201e26:	00003517          	auipc	a0,0x3
ffffffffc0201e2a:	db250513          	addi	a0,a0,-590 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc0201e2e:	abefe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201e32:	03700493          	li	s1,55
ffffffffc0201e36:	1f900993          	li	s3,505
ffffffffc0201e3a:	a819                	j	ffffffffc0201e50 <vmm_init+0x8e>
ffffffffc0201e3c:	e504                	sd	s1,8(a0)
ffffffffc0201e3e:	e91c                	sd	a5,16(a0)
ffffffffc0201e40:	00053c23          	sd	zero,24(a0)
ffffffffc0201e44:	0495                	addi	s1,s1,5
ffffffffc0201e46:	8522                	mv	a0,s0
ffffffffc0201e48:	e77ff0ef          	jal	ra,ffffffffc0201cbe <insert_vma_struct>
ffffffffc0201e4c:	03348a63          	beq	s1,s3,ffffffffc0201e80 <vmm_init+0xbe>
ffffffffc0201e50:	03000513          	li	a0,48
ffffffffc0201e54:	c1fff0ef          	jal	ra,ffffffffc0201a72 <kmalloc>
ffffffffc0201e58:	85aa                	mv	a1,a0
ffffffffc0201e5a:	00248793          	addi	a5,s1,2
ffffffffc0201e5e:	fd79                	bnez	a0,ffffffffc0201e3c <vmm_init+0x7a>
ffffffffc0201e60:	00003697          	auipc	a3,0x3
ffffffffc0201e64:	01068693          	addi	a3,a3,16 # ffffffffc0204e70 <etext+0x1202>
ffffffffc0201e68:	00002617          	auipc	a2,0x2
ffffffffc0201e6c:	55060613          	addi	a2,a2,1360 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201e70:	0d300593          	li	a1,211
ffffffffc0201e74:	00003517          	auipc	a0,0x3
ffffffffc0201e78:	d6450513          	addi	a0,a0,-668 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc0201e7c:	a70fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201e80:	6418                	ld	a4,8(s0)
ffffffffc0201e82:	479d                	li	a5,7
ffffffffc0201e84:	1fb00593          	li	a1,507
ffffffffc0201e88:	28e40d63          	beq	s0,a4,ffffffffc0202122 <vmm_init+0x360>
ffffffffc0201e8c:	fe873683          	ld	a3,-24(a4)
ffffffffc0201e90:	ffe78613          	addi	a2,a5,-2
ffffffffc0201e94:	20d61763          	bne	a2,a3,ffffffffc02020a2 <vmm_init+0x2e0>
ffffffffc0201e98:	ff073683          	ld	a3,-16(a4)
ffffffffc0201e9c:	20d79363          	bne	a5,a3,ffffffffc02020a2 <vmm_init+0x2e0>
ffffffffc0201ea0:	0795                	addi	a5,a5,5
ffffffffc0201ea2:	6718                	ld	a4,8(a4)
ffffffffc0201ea4:	feb792e3          	bne	a5,a1,ffffffffc0201e88 <vmm_init+0xc6>
ffffffffc0201ea8:	4b1d                	li	s6,7
ffffffffc0201eaa:	4495                	li	s1,5
ffffffffc0201eac:	1f900b93          	li	s7,505
ffffffffc0201eb0:	85a6                	mv	a1,s1
ffffffffc0201eb2:	8522                	mv	a0,s0
ffffffffc0201eb4:	dcbff0ef          	jal	ra,ffffffffc0201c7e <find_vma>
ffffffffc0201eb8:	8aaa                	mv	s5,a0
ffffffffc0201eba:	2e050463          	beqz	a0,ffffffffc02021a2 <vmm_init+0x3e0>
ffffffffc0201ebe:	00148593          	addi	a1,s1,1
ffffffffc0201ec2:	8522                	mv	a0,s0
ffffffffc0201ec4:	dbbff0ef          	jal	ra,ffffffffc0201c7e <find_vma>
ffffffffc0201ec8:	89aa                	mv	s3,a0
ffffffffc0201eca:	2a050c63          	beqz	a0,ffffffffc0202182 <vmm_init+0x3c0>
ffffffffc0201ece:	85da                	mv	a1,s6
ffffffffc0201ed0:	8522                	mv	a0,s0
ffffffffc0201ed2:	dadff0ef          	jal	ra,ffffffffc0201c7e <find_vma>
ffffffffc0201ed6:	28051663          	bnez	a0,ffffffffc0202162 <vmm_init+0x3a0>
ffffffffc0201eda:	00348593          	addi	a1,s1,3
ffffffffc0201ede:	8522                	mv	a0,s0
ffffffffc0201ee0:	d9fff0ef          	jal	ra,ffffffffc0201c7e <find_vma>
ffffffffc0201ee4:	24051f63          	bnez	a0,ffffffffc0202142 <vmm_init+0x380>
ffffffffc0201ee8:	00448593          	addi	a1,s1,4
ffffffffc0201eec:	8522                	mv	a0,s0
ffffffffc0201eee:	d91ff0ef          	jal	ra,ffffffffc0201c7e <find_vma>
ffffffffc0201ef2:	2c051863          	bnez	a0,ffffffffc02021c2 <vmm_init+0x400>
ffffffffc0201ef6:	008ab783          	ld	a5,8(s5)
ffffffffc0201efa:	1c979463          	bne	a5,s1,ffffffffc02020c2 <vmm_init+0x300>
ffffffffc0201efe:	010ab783          	ld	a5,16(s5)
ffffffffc0201f02:	1d679063          	bne	a5,s6,ffffffffc02020c2 <vmm_init+0x300>
ffffffffc0201f06:	0089b783          	ld	a5,8(s3)
ffffffffc0201f0a:	1c979c63          	bne	a5,s1,ffffffffc02020e2 <vmm_init+0x320>
ffffffffc0201f0e:	0109b783          	ld	a5,16(s3)
ffffffffc0201f12:	1d679863          	bne	a5,s6,ffffffffc02020e2 <vmm_init+0x320>
ffffffffc0201f16:	0495                	addi	s1,s1,5
ffffffffc0201f18:	0b15                	addi	s6,s6,5
ffffffffc0201f1a:	f9749be3          	bne	s1,s7,ffffffffc0201eb0 <vmm_init+0xee>
ffffffffc0201f1e:	4491                	li	s1,4
ffffffffc0201f20:	59fd                	li	s3,-1
ffffffffc0201f22:	85a6                	mv	a1,s1
ffffffffc0201f24:	8522                	mv	a0,s0
ffffffffc0201f26:	d59ff0ef          	jal	ra,ffffffffc0201c7e <find_vma>
ffffffffc0201f2a:	0004859b          	sext.w	a1,s1
ffffffffc0201f2e:	c90d                	beqz	a0,ffffffffc0201f60 <vmm_init+0x19e>
ffffffffc0201f30:	6914                	ld	a3,16(a0)
ffffffffc0201f32:	6510                	ld	a2,8(a0)
ffffffffc0201f34:	00003517          	auipc	a0,0x3
ffffffffc0201f38:	e2450513          	addi	a0,a0,-476 # ffffffffc0204d58 <etext+0x10ea>
ffffffffc0201f3c:	97afe0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0201f40:	00003697          	auipc	a3,0x3
ffffffffc0201f44:	e4068693          	addi	a3,a3,-448 # ffffffffc0204d80 <etext+0x1112>
ffffffffc0201f48:	00002617          	auipc	a2,0x2
ffffffffc0201f4c:	47060613          	addi	a2,a2,1136 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0201f50:	0f500593          	li	a1,245
ffffffffc0201f54:	00003517          	auipc	a0,0x3
ffffffffc0201f58:	c8450513          	addi	a0,a0,-892 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc0201f5c:	990fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201f60:	14fd                	addi	s1,s1,-1
ffffffffc0201f62:	fd3490e3          	bne	s1,s3,ffffffffc0201f22 <vmm_init+0x160>
ffffffffc0201f66:	8522                	mv	a0,s0
ffffffffc0201f68:	e27ff0ef          	jal	ra,ffffffffc0201d8e <mm_destroy>
ffffffffc0201f6c:	d31fe0ef          	jal	ra,ffffffffc0200c9c <nr_free_pages>
ffffffffc0201f70:	28aa1963          	bne	s4,a0,ffffffffc0202202 <vmm_init+0x440>
ffffffffc0201f74:	00003517          	auipc	a0,0x3
ffffffffc0201f78:	e4c50513          	addi	a0,a0,-436 # ffffffffc0204dc0 <etext+0x1152>
ffffffffc0201f7c:	93afe0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0201f80:	d1dfe0ef          	jal	ra,ffffffffc0200c9c <nr_free_pages>
ffffffffc0201f84:	89aa                	mv	s3,a0
ffffffffc0201f86:	c83ff0ef          	jal	ra,ffffffffc0201c08 <mm_create>
ffffffffc0201f8a:	0000e797          	auipc	a5,0xe
ffffffffc0201f8e:	12a7b723          	sd	a0,302(a5) # ffffffffc02100b8 <check_mm_struct>
ffffffffc0201f92:	842a                	mv	s0,a0
ffffffffc0201f94:	2a050763          	beqz	a0,ffffffffc0202242 <vmm_init+0x480>
ffffffffc0201f98:	0000ea17          	auipc	s4,0xe
ffffffffc0201f9c:	0b8a3a03          	ld	s4,184(s4) # ffffffffc0210050 <boot_pgdir>
ffffffffc0201fa0:	000a3783          	ld	a5,0(s4)
ffffffffc0201fa4:	01453c23          	sd	s4,24(a0)
ffffffffc0201fa8:	32079963          	bnez	a5,ffffffffc02022da <vmm_init+0x518>
ffffffffc0201fac:	03000513          	li	a0,48
ffffffffc0201fb0:	ac3ff0ef          	jal	ra,ffffffffc0201a72 <kmalloc>
ffffffffc0201fb4:	84aa                	mv	s1,a0
ffffffffc0201fb6:	14050663          	beqz	a0,ffffffffc0202102 <vmm_init+0x340>
ffffffffc0201fba:	002007b7          	lui	a5,0x200
ffffffffc0201fbe:	e89c                	sd	a5,16(s1)
ffffffffc0201fc0:	4789                	li	a5,2
ffffffffc0201fc2:	85aa                	mv	a1,a0
ffffffffc0201fc4:	ec9c                	sd	a5,24(s1)
ffffffffc0201fc6:	8522                	mv	a0,s0
ffffffffc0201fc8:	0004b423          	sd	zero,8(s1)
ffffffffc0201fcc:	cf3ff0ef          	jal	ra,ffffffffc0201cbe <insert_vma_struct>
ffffffffc0201fd0:	10000593          	li	a1,256
ffffffffc0201fd4:	8522                	mv	a0,s0
ffffffffc0201fd6:	ca9ff0ef          	jal	ra,ffffffffc0201c7e <find_vma>
ffffffffc0201fda:	10000793          	li	a5,256
ffffffffc0201fde:	16400713          	li	a4,356
ffffffffc0201fe2:	2aa49063          	bne	s1,a0,ffffffffc0202282 <vmm_init+0x4c0>
ffffffffc0201fe6:	00f78023          	sb	a5,0(a5) # 200000 <kern_entry-0xffffffffc0000000>
ffffffffc0201fea:	0785                	addi	a5,a5,1
ffffffffc0201fec:	fee79de3          	bne	a5,a4,ffffffffc0201fe6 <vmm_init+0x224>
ffffffffc0201ff0:	6705                	lui	a4,0x1
ffffffffc0201ff2:	10000793          	li	a5,256
ffffffffc0201ff6:	35670713          	addi	a4,a4,854 # 1356 <kern_entry-0xffffffffc01fecaa>
ffffffffc0201ffa:	16400613          	li	a2,356
ffffffffc0201ffe:	0007c683          	lbu	a3,0(a5)
ffffffffc0202002:	0785                	addi	a5,a5,1
ffffffffc0202004:	9f15                	subw	a4,a4,a3
ffffffffc0202006:	fec79ce3          	bne	a5,a2,ffffffffc0201ffe <vmm_init+0x23c>
ffffffffc020200a:	2a071863          	bnez	a4,ffffffffc02022ba <vmm_init+0x4f8>
ffffffffc020200e:	4581                	li	a1,0
ffffffffc0202010:	8552                	mv	a0,s4
ffffffffc0202012:	f17fe0ef          	jal	ra,ffffffffc0200f28 <page_remove>
ffffffffc0202016:	000a3783          	ld	a5,0(s4)
ffffffffc020201a:	0000e717          	auipc	a4,0xe
ffffffffc020201e:	03e73703          	ld	a4,62(a4) # ffffffffc0210058 <npage>
ffffffffc0202022:	078a                	slli	a5,a5,0x2
ffffffffc0202024:	83b1                	srli	a5,a5,0xc
ffffffffc0202026:	26e7fe63          	bgeu	a5,a4,ffffffffc02022a2 <vmm_init+0x4e0>
ffffffffc020202a:	00004517          	auipc	a0,0x4
ffffffffc020202e:	8a653503          	ld	a0,-1882(a0) # ffffffffc02058d0 <nbase>
ffffffffc0202032:	8f89                	sub	a5,a5,a0
ffffffffc0202034:	00379513          	slli	a0,a5,0x3
ffffffffc0202038:	97aa                	add	a5,a5,a0
ffffffffc020203a:	078e                	slli	a5,a5,0x3
ffffffffc020203c:	0000e517          	auipc	a0,0xe
ffffffffc0202040:	07453503          	ld	a0,116(a0) # ffffffffc02100b0 <pages>
ffffffffc0202044:	953e                	add	a0,a0,a5
ffffffffc0202046:	4585                	li	a1,1
ffffffffc0202048:	c13fe0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc020204c:	000a3023          	sd	zero,0(s4)
ffffffffc0202050:	8522                	mv	a0,s0
ffffffffc0202052:	00043c23          	sd	zero,24(s0)
ffffffffc0202056:	d39ff0ef          	jal	ra,ffffffffc0201d8e <mm_destroy>
ffffffffc020205a:	19fd                	addi	s3,s3,-1
ffffffffc020205c:	0000e797          	auipc	a5,0xe
ffffffffc0202060:	0407be23          	sd	zero,92(a5) # ffffffffc02100b8 <check_mm_struct>
ffffffffc0202064:	c39fe0ef          	jal	ra,ffffffffc0200c9c <nr_free_pages>
ffffffffc0202068:	1aa99d63          	bne	s3,a0,ffffffffc0202222 <vmm_init+0x460>
ffffffffc020206c:	00003517          	auipc	a0,0x3
ffffffffc0202070:	dcc50513          	addi	a0,a0,-564 # ffffffffc0204e38 <etext+0x11ca>
ffffffffc0202074:	842fe0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0202078:	c25fe0ef          	jal	ra,ffffffffc0200c9c <nr_free_pages>
ffffffffc020207c:	197d                	addi	s2,s2,-1
ffffffffc020207e:	1ea91263          	bne	s2,a0,ffffffffc0202262 <vmm_init+0x4a0>
ffffffffc0202082:	6406                	ld	s0,64(sp)
ffffffffc0202084:	60a6                	ld	ra,72(sp)
ffffffffc0202086:	74e2                	ld	s1,56(sp)
ffffffffc0202088:	7942                	ld	s2,48(sp)
ffffffffc020208a:	79a2                	ld	s3,40(sp)
ffffffffc020208c:	7a02                	ld	s4,32(sp)
ffffffffc020208e:	6ae2                	ld	s5,24(sp)
ffffffffc0202090:	6b42                	ld	s6,16(sp)
ffffffffc0202092:	6ba2                	ld	s7,8(sp)
ffffffffc0202094:	00003517          	auipc	a0,0x3
ffffffffc0202098:	dc450513          	addi	a0,a0,-572 # ffffffffc0204e58 <etext+0x11ea>
ffffffffc020209c:	6161                	addi	sp,sp,80
ffffffffc020209e:	818fe06f          	j	ffffffffc02000b6 <cprintf>
ffffffffc02020a2:	00003697          	auipc	a3,0x3
ffffffffc02020a6:	bce68693          	addi	a3,a3,-1074 # ffffffffc0204c70 <etext+0x1002>
ffffffffc02020aa:	00002617          	auipc	a2,0x2
ffffffffc02020ae:	30e60613          	addi	a2,a2,782 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02020b2:	0dc00593          	li	a1,220
ffffffffc02020b6:	00003517          	auipc	a0,0x3
ffffffffc02020ba:	b2250513          	addi	a0,a0,-1246 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc02020be:	82efe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02020c2:	00003697          	auipc	a3,0x3
ffffffffc02020c6:	c3668693          	addi	a3,a3,-970 # ffffffffc0204cf8 <etext+0x108a>
ffffffffc02020ca:	00002617          	auipc	a2,0x2
ffffffffc02020ce:	2ee60613          	addi	a2,a2,750 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02020d2:	0ec00593          	li	a1,236
ffffffffc02020d6:	00003517          	auipc	a0,0x3
ffffffffc02020da:	b0250513          	addi	a0,a0,-1278 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc02020de:	80efe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02020e2:	00003697          	auipc	a3,0x3
ffffffffc02020e6:	c4668693          	addi	a3,a3,-954 # ffffffffc0204d28 <etext+0x10ba>
ffffffffc02020ea:	00002617          	auipc	a2,0x2
ffffffffc02020ee:	2ce60613          	addi	a2,a2,718 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02020f2:	0ed00593          	li	a1,237
ffffffffc02020f6:	00003517          	auipc	a0,0x3
ffffffffc02020fa:	ae250513          	addi	a0,a0,-1310 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc02020fe:	feffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202102:	00003697          	auipc	a3,0x3
ffffffffc0202106:	d6e68693          	addi	a3,a3,-658 # ffffffffc0204e70 <etext+0x1202>
ffffffffc020210a:	00002617          	auipc	a2,0x2
ffffffffc020210e:	2ae60613          	addi	a2,a2,686 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202112:	11000593          	li	a1,272
ffffffffc0202116:	00003517          	auipc	a0,0x3
ffffffffc020211a:	ac250513          	addi	a0,a0,-1342 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc020211e:	fcffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202122:	00003697          	auipc	a3,0x3
ffffffffc0202126:	b3668693          	addi	a3,a3,-1226 # ffffffffc0204c58 <etext+0xfea>
ffffffffc020212a:	00002617          	auipc	a2,0x2
ffffffffc020212e:	28e60613          	addi	a2,a2,654 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202132:	0da00593          	li	a1,218
ffffffffc0202136:	00003517          	auipc	a0,0x3
ffffffffc020213a:	aa250513          	addi	a0,a0,-1374 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc020213e:	faffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202142:	00003697          	auipc	a3,0x3
ffffffffc0202146:	b9668693          	addi	a3,a3,-1130 # ffffffffc0204cd8 <etext+0x106a>
ffffffffc020214a:	00002617          	auipc	a2,0x2
ffffffffc020214e:	26e60613          	addi	a2,a2,622 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202152:	0e800593          	li	a1,232
ffffffffc0202156:	00003517          	auipc	a0,0x3
ffffffffc020215a:	a8250513          	addi	a0,a0,-1406 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc020215e:	f8ffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202162:	00003697          	auipc	a3,0x3
ffffffffc0202166:	b6668693          	addi	a3,a3,-1178 # ffffffffc0204cc8 <etext+0x105a>
ffffffffc020216a:	00002617          	auipc	a2,0x2
ffffffffc020216e:	24e60613          	addi	a2,a2,590 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202172:	0e600593          	li	a1,230
ffffffffc0202176:	00003517          	auipc	a0,0x3
ffffffffc020217a:	a6250513          	addi	a0,a0,-1438 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc020217e:	f6ffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202182:	00003697          	auipc	a3,0x3
ffffffffc0202186:	b3668693          	addi	a3,a3,-1226 # ffffffffc0204cb8 <etext+0x104a>
ffffffffc020218a:	00002617          	auipc	a2,0x2
ffffffffc020218e:	22e60613          	addi	a2,a2,558 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202192:	0e400593          	li	a1,228
ffffffffc0202196:	00003517          	auipc	a0,0x3
ffffffffc020219a:	a4250513          	addi	a0,a0,-1470 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc020219e:	f4ffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02021a2:	00003697          	auipc	a3,0x3
ffffffffc02021a6:	b0668693          	addi	a3,a3,-1274 # ffffffffc0204ca8 <etext+0x103a>
ffffffffc02021aa:	00002617          	auipc	a2,0x2
ffffffffc02021ae:	20e60613          	addi	a2,a2,526 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02021b2:	0e200593          	li	a1,226
ffffffffc02021b6:	00003517          	auipc	a0,0x3
ffffffffc02021ba:	a2250513          	addi	a0,a0,-1502 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc02021be:	f2ffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02021c2:	00003697          	auipc	a3,0x3
ffffffffc02021c6:	b2668693          	addi	a3,a3,-1242 # ffffffffc0204ce8 <etext+0x107a>
ffffffffc02021ca:	00002617          	auipc	a2,0x2
ffffffffc02021ce:	1ee60613          	addi	a2,a2,494 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02021d2:	0ea00593          	li	a1,234
ffffffffc02021d6:	00003517          	auipc	a0,0x3
ffffffffc02021da:	a0250513          	addi	a0,a0,-1534 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc02021de:	f0ffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02021e2:	00003697          	auipc	a3,0x3
ffffffffc02021e6:	a6668693          	addi	a3,a3,-1434 # ffffffffc0204c48 <etext+0xfda>
ffffffffc02021ea:	00002617          	auipc	a2,0x2
ffffffffc02021ee:	1ce60613          	addi	a2,a2,462 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02021f2:	0c600593          	li	a1,198
ffffffffc02021f6:	00003517          	auipc	a0,0x3
ffffffffc02021fa:	9e250513          	addi	a0,a0,-1566 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc02021fe:	eeffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202202:	00003697          	auipc	a3,0x3
ffffffffc0202206:	b9668693          	addi	a3,a3,-1130 # ffffffffc0204d98 <etext+0x112a>
ffffffffc020220a:	00002617          	auipc	a2,0x2
ffffffffc020220e:	1ae60613          	addi	a2,a2,430 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202212:	0fa00593          	li	a1,250
ffffffffc0202216:	00003517          	auipc	a0,0x3
ffffffffc020221a:	9c250513          	addi	a0,a0,-1598 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc020221e:	ecffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202222:	00003697          	auipc	a3,0x3
ffffffffc0202226:	b7668693          	addi	a3,a3,-1162 # ffffffffc0204d98 <etext+0x112a>
ffffffffc020222a:	00002617          	auipc	a2,0x2
ffffffffc020222e:	18e60613          	addi	a2,a2,398 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202232:	12c00593          	li	a1,300
ffffffffc0202236:	00003517          	auipc	a0,0x3
ffffffffc020223a:	9a250513          	addi	a0,a0,-1630 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc020223e:	eaffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202242:	00003697          	auipc	a3,0x3
ffffffffc0202246:	b9e68693          	addi	a3,a3,-1122 # ffffffffc0204de0 <etext+0x1172>
ffffffffc020224a:	00002617          	auipc	a2,0x2
ffffffffc020224e:	16e60613          	addi	a2,a2,366 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202252:	10900593          	li	a1,265
ffffffffc0202256:	00003517          	auipc	a0,0x3
ffffffffc020225a:	98250513          	addi	a0,a0,-1662 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc020225e:	e8ffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202262:	00003697          	auipc	a3,0x3
ffffffffc0202266:	b3668693          	addi	a3,a3,-1226 # ffffffffc0204d98 <etext+0x112a>
ffffffffc020226a:	00002617          	auipc	a2,0x2
ffffffffc020226e:	14e60613          	addi	a2,a2,334 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202272:	0bc00593          	li	a1,188
ffffffffc0202276:	00003517          	auipc	a0,0x3
ffffffffc020227a:	96250513          	addi	a0,a0,-1694 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc020227e:	e6ffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202282:	00003697          	auipc	a3,0x3
ffffffffc0202286:	b8668693          	addi	a3,a3,-1146 # ffffffffc0204e08 <etext+0x119a>
ffffffffc020228a:	00002617          	auipc	a2,0x2
ffffffffc020228e:	12e60613          	addi	a2,a2,302 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202292:	11500593          	li	a1,277
ffffffffc0202296:	00003517          	auipc	a0,0x3
ffffffffc020229a:	94250513          	addi	a0,a0,-1726 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc020229e:	e4ffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02022a2:	00002617          	auipc	a2,0x2
ffffffffc02022a6:	2e660613          	addi	a2,a2,742 # ffffffffc0204588 <etext+0x91a>
ffffffffc02022aa:	06500593          	li	a1,101
ffffffffc02022ae:	00002517          	auipc	a0,0x2
ffffffffc02022b2:	2fa50513          	addi	a0,a0,762 # ffffffffc02045a8 <etext+0x93a>
ffffffffc02022b6:	e37fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02022ba:	00003697          	auipc	a3,0x3
ffffffffc02022be:	b6e68693          	addi	a3,a3,-1170 # ffffffffc0204e28 <etext+0x11ba>
ffffffffc02022c2:	00002617          	auipc	a2,0x2
ffffffffc02022c6:	0f660613          	addi	a2,a2,246 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02022ca:	11f00593          	li	a1,287
ffffffffc02022ce:	00003517          	auipc	a0,0x3
ffffffffc02022d2:	90a50513          	addi	a0,a0,-1782 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc02022d6:	e17fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02022da:	00003697          	auipc	a3,0x3
ffffffffc02022de:	b1e68693          	addi	a3,a3,-1250 # ffffffffc0204df8 <etext+0x118a>
ffffffffc02022e2:	00002617          	auipc	a2,0x2
ffffffffc02022e6:	0d660613          	addi	a2,a2,214 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02022ea:	10c00593          	li	a1,268
ffffffffc02022ee:	00003517          	auipc	a0,0x3
ffffffffc02022f2:	8ea50513          	addi	a0,a0,-1814 # ffffffffc0204bd8 <etext+0xf6a>
ffffffffc02022f6:	df7fd0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc02022fa <do_pgfault>:
ffffffffc02022fa:	7179                	addi	sp,sp,-48
ffffffffc02022fc:	85b2                	mv	a1,a2
ffffffffc02022fe:	f022                	sd	s0,32(sp)
ffffffffc0202300:	ec26                	sd	s1,24(sp)
ffffffffc0202302:	f406                	sd	ra,40(sp)
ffffffffc0202304:	e84a                	sd	s2,16(sp)
ffffffffc0202306:	8432                	mv	s0,a2
ffffffffc0202308:	84aa                	mv	s1,a0
ffffffffc020230a:	975ff0ef          	jal	ra,ffffffffc0201c7e <find_vma>
ffffffffc020230e:	0000e797          	auipc	a5,0xe
ffffffffc0202312:	d527a783          	lw	a5,-686(a5) # ffffffffc0210060 <pgfault_num>
ffffffffc0202316:	2785                	addiw	a5,a5,1
ffffffffc0202318:	0000e717          	auipc	a4,0xe
ffffffffc020231c:	d4f72423          	sw	a5,-696(a4) # ffffffffc0210060 <pgfault_num>
ffffffffc0202320:	c159                	beqz	a0,ffffffffc02023a6 <do_pgfault+0xac>
ffffffffc0202322:	651c                	ld	a5,8(a0)
ffffffffc0202324:	08f46163          	bltu	s0,a5,ffffffffc02023a6 <do_pgfault+0xac>
ffffffffc0202328:	6d1c                	ld	a5,24(a0)
ffffffffc020232a:	4941                	li	s2,16
ffffffffc020232c:	8b89                	andi	a5,a5,2
ffffffffc020232e:	ebb1                	bnez	a5,ffffffffc0202382 <do_pgfault+0x88>
ffffffffc0202330:	75fd                	lui	a1,0xfffff
ffffffffc0202332:	6c88                	ld	a0,24(s1)
ffffffffc0202334:	8c6d                	and	s0,s0,a1
ffffffffc0202336:	85a2                	mv	a1,s0
ffffffffc0202338:	4605                	li	a2,1
ffffffffc020233a:	99ffe0ef          	jal	ra,ffffffffc0200cd8 <get_pte>
ffffffffc020233e:	610c                	ld	a1,0(a0)
ffffffffc0202340:	c1b9                	beqz	a1,ffffffffc0202386 <do_pgfault+0x8c>
ffffffffc0202342:	0000e797          	auipc	a5,0xe
ffffffffc0202346:	d2e7a783          	lw	a5,-722(a5) # ffffffffc0210070 <swap_init_ok>
ffffffffc020234a:	c7bd                	beqz	a5,ffffffffc02023b8 <do_pgfault+0xbe>
ffffffffc020234c:	85a2                	mv	a1,s0
ffffffffc020234e:	0030                	addi	a2,sp,8
ffffffffc0202350:	8526                	mv	a0,s1
ffffffffc0202352:	e402                	sd	zero,8(sp)
ffffffffc0202354:	7e2000ef          	jal	ra,ffffffffc0202b36 <swap_in>
ffffffffc0202358:	65a2                	ld	a1,8(sp)
ffffffffc020235a:	6c88                	ld	a0,24(s1)
ffffffffc020235c:	86ca                	mv	a3,s2
ffffffffc020235e:	8622                	mv	a2,s0
ffffffffc0202360:	c37fe0ef          	jal	ra,ffffffffc0200f96 <page_insert>
ffffffffc0202364:	6622                	ld	a2,8(sp)
ffffffffc0202366:	4685                	li	a3,1
ffffffffc0202368:	85a2                	mv	a1,s0
ffffffffc020236a:	8526                	mv	a0,s1
ffffffffc020236c:	6a8000ef          	jal	ra,ffffffffc0202a14 <swap_map_swappable>
ffffffffc0202370:	67a2                	ld	a5,8(sp)
ffffffffc0202372:	4501                	li	a0,0
ffffffffc0202374:	e3a0                	sd	s0,64(a5)
ffffffffc0202376:	70a2                	ld	ra,40(sp)
ffffffffc0202378:	7402                	ld	s0,32(sp)
ffffffffc020237a:	64e2                	ld	s1,24(sp)
ffffffffc020237c:	6942                	ld	s2,16(sp)
ffffffffc020237e:	6145                	addi	sp,sp,48
ffffffffc0202380:	8082                	ret
ffffffffc0202382:	4959                	li	s2,22
ffffffffc0202384:	b775                	j	ffffffffc0202330 <do_pgfault+0x36>
ffffffffc0202386:	6c88                	ld	a0,24(s1)
ffffffffc0202388:	864a                	mv	a2,s2
ffffffffc020238a:	85a2                	mv	a1,s0
ffffffffc020238c:	e5aff0ef          	jal	ra,ffffffffc02019e6 <pgdir_alloc_page>
ffffffffc0202390:	87aa                	mv	a5,a0
ffffffffc0202392:	4501                	li	a0,0
ffffffffc0202394:	f3ed                	bnez	a5,ffffffffc0202376 <do_pgfault+0x7c>
ffffffffc0202396:	00003517          	auipc	a0,0x3
ffffffffc020239a:	b1a50513          	addi	a0,a0,-1254 # ffffffffc0204eb0 <etext+0x1242>
ffffffffc020239e:	d19fd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02023a2:	5571                	li	a0,-4
ffffffffc02023a4:	bfc9                	j	ffffffffc0202376 <do_pgfault+0x7c>
ffffffffc02023a6:	85a2                	mv	a1,s0
ffffffffc02023a8:	00003517          	auipc	a0,0x3
ffffffffc02023ac:	ad850513          	addi	a0,a0,-1320 # ffffffffc0204e80 <etext+0x1212>
ffffffffc02023b0:	d07fd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02023b4:	5575                	li	a0,-3
ffffffffc02023b6:	b7c1                	j	ffffffffc0202376 <do_pgfault+0x7c>
ffffffffc02023b8:	00003517          	auipc	a0,0x3
ffffffffc02023bc:	b2050513          	addi	a0,a0,-1248 # ffffffffc0204ed8 <etext+0x126a>
ffffffffc02023c0:	cf7fd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02023c4:	5571                	li	a0,-4
ffffffffc02023c6:	bf45                	j	ffffffffc0202376 <do_pgfault+0x7c>

ffffffffc02023c8 <swap_init>:
ffffffffc02023c8:	7175                	addi	sp,sp,-144
ffffffffc02023ca:	e506                	sd	ra,136(sp)
ffffffffc02023cc:	e122                	sd	s0,128(sp)
ffffffffc02023ce:	fca6                	sd	s1,120(sp)
ffffffffc02023d0:	f8ca                	sd	s2,112(sp)
ffffffffc02023d2:	f4ce                	sd	s3,104(sp)
ffffffffc02023d4:	f0d2                	sd	s4,96(sp)
ffffffffc02023d6:	ecd6                	sd	s5,88(sp)
ffffffffc02023d8:	e8da                	sd	s6,80(sp)
ffffffffc02023da:	e4de                	sd	s7,72(sp)
ffffffffc02023dc:	e0e2                	sd	s8,64(sp)
ffffffffc02023de:	fc66                	sd	s9,56(sp)
ffffffffc02023e0:	f86a                	sd	s10,48(sp)
ffffffffc02023e2:	f46e                	sd	s11,40(sp)
ffffffffc02023e4:	2a0010ef          	jal	ra,ffffffffc0203684 <swapfs_init>
ffffffffc02023e8:	0000e697          	auipc	a3,0xe
ffffffffc02023ec:	d606b683          	ld	a3,-672(a3) # ffffffffc0210148 <max_swap_offset>
ffffffffc02023f0:	010007b7          	lui	a5,0x1000
ffffffffc02023f4:	ff968713          	addi	a4,a3,-7
ffffffffc02023f8:	17e1                	addi	a5,a5,-8
ffffffffc02023fa:	3ce7ea63          	bltu	a5,a4,ffffffffc02027ce <swap_init+0x406>
ffffffffc02023fe:	00007797          	auipc	a5,0x7
ffffffffc0202402:	c0278793          	addi	a5,a5,-1022 # ffffffffc0209000 <swap_manager_lru>
ffffffffc0202406:	6798                	ld	a4,8(a5)
ffffffffc0202408:	0000ea97          	auipc	s5,0xe
ffffffffc020240c:	c60a8a93          	addi	s5,s5,-928 # ffffffffc0210068 <sm>
ffffffffc0202410:	00fab023          	sd	a5,0(s5)
ffffffffc0202414:	9702                	jalr	a4
ffffffffc0202416:	84aa                	mv	s1,a0
ffffffffc0202418:	c10d                	beqz	a0,ffffffffc020243a <swap_init+0x72>
ffffffffc020241a:	60aa                	ld	ra,136(sp)
ffffffffc020241c:	640a                	ld	s0,128(sp)
ffffffffc020241e:	7946                	ld	s2,112(sp)
ffffffffc0202420:	79a6                	ld	s3,104(sp)
ffffffffc0202422:	7a06                	ld	s4,96(sp)
ffffffffc0202424:	6ae6                	ld	s5,88(sp)
ffffffffc0202426:	6b46                	ld	s6,80(sp)
ffffffffc0202428:	6ba6                	ld	s7,72(sp)
ffffffffc020242a:	6c06                	ld	s8,64(sp)
ffffffffc020242c:	7ce2                	ld	s9,56(sp)
ffffffffc020242e:	7d42                	ld	s10,48(sp)
ffffffffc0202430:	7da2                	ld	s11,40(sp)
ffffffffc0202432:	8526                	mv	a0,s1
ffffffffc0202434:	74e6                	ld	s1,120(sp)
ffffffffc0202436:	6149                	addi	sp,sp,144
ffffffffc0202438:	8082                	ret
ffffffffc020243a:	000ab783          	ld	a5,0(s5)
ffffffffc020243e:	00003517          	auipc	a0,0x3
ffffffffc0202442:	af250513          	addi	a0,a0,-1294 # ffffffffc0204f30 <etext+0x12c2>
ffffffffc0202446:	0000e417          	auipc	s0,0xe
ffffffffc020244a:	d4240413          	addi	s0,s0,-702 # ffffffffc0210188 <free_area>
ffffffffc020244e:	638c                	ld	a1,0(a5)
ffffffffc0202450:	4785                	li	a5,1
ffffffffc0202452:	0000e717          	auipc	a4,0xe
ffffffffc0202456:	c0f72f23          	sw	a5,-994(a4) # ffffffffc0210070 <swap_init_ok>
ffffffffc020245a:	c5dfd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020245e:	641c                	ld	a5,8(s0)
ffffffffc0202460:	4901                	li	s2,0
ffffffffc0202462:	4981                	li	s3,0
ffffffffc0202464:	28878b63          	beq	a5,s0,ffffffffc02026fa <swap_init+0x332>
ffffffffc0202468:	fe87b703          	ld	a4,-24(a5)
ffffffffc020246c:	8b09                	andi	a4,a4,2
ffffffffc020246e:	28070863          	beqz	a4,ffffffffc02026fe <swap_init+0x336>
ffffffffc0202472:	ff87a703          	lw	a4,-8(a5)
ffffffffc0202476:	679c                	ld	a5,8(a5)
ffffffffc0202478:	2985                	addiw	s3,s3,1
ffffffffc020247a:	0127093b          	addw	s2,a4,s2
ffffffffc020247e:	fe8795e3          	bne	a5,s0,ffffffffc0202468 <swap_init+0xa0>
ffffffffc0202482:	8a4a                	mv	s4,s2
ffffffffc0202484:	819fe0ef          	jal	ra,ffffffffc0200c9c <nr_free_pages>
ffffffffc0202488:	55451f63          	bne	a0,s4,ffffffffc02029e6 <swap_init+0x61e>
ffffffffc020248c:	864a                	mv	a2,s2
ffffffffc020248e:	85ce                	mv	a1,s3
ffffffffc0202490:	00003517          	auipc	a0,0x3
ffffffffc0202494:	ae850513          	addi	a0,a0,-1304 # ffffffffc0204f78 <etext+0x130a>
ffffffffc0202498:	c1ffd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020249c:	f6cff0ef          	jal	ra,ffffffffc0201c08 <mm_create>
ffffffffc02024a0:	8a2a                	mv	s4,a0
ffffffffc02024a2:	4c050263          	beqz	a0,ffffffffc0202966 <swap_init+0x59e>
ffffffffc02024a6:	0000e797          	auipc	a5,0xe
ffffffffc02024aa:	c1278793          	addi	a5,a5,-1006 # ffffffffc02100b8 <check_mm_struct>
ffffffffc02024ae:	6398                	ld	a4,0(a5)
ffffffffc02024b0:	4c071b63          	bnez	a4,ffffffffc0202986 <swap_init+0x5be>
ffffffffc02024b4:	0000eb17          	auipc	s6,0xe
ffffffffc02024b8:	b9cb3b03          	ld	s6,-1124(s6) # ffffffffc0210050 <boot_pgdir>
ffffffffc02024bc:	000b3703          	ld	a4,0(s6)
ffffffffc02024c0:	e388                	sd	a0,0(a5)
ffffffffc02024c2:	01653c23          	sd	s6,24(a0)
ffffffffc02024c6:	4e071063          	bnez	a4,ffffffffc02029a6 <swap_init+0x5de>
ffffffffc02024ca:	6599                	lui	a1,0x6
ffffffffc02024cc:	460d                	li	a2,3
ffffffffc02024ce:	6505                	lui	a0,0x1
ffffffffc02024d0:	f80ff0ef          	jal	ra,ffffffffc0201c50 <vma_create>
ffffffffc02024d4:	85aa                	mv	a1,a0
ffffffffc02024d6:	4e050863          	beqz	a0,ffffffffc02029c6 <swap_init+0x5fe>
ffffffffc02024da:	8552                	mv	a0,s4
ffffffffc02024dc:	fe2ff0ef          	jal	ra,ffffffffc0201cbe <insert_vma_struct>
ffffffffc02024e0:	00003517          	auipc	a0,0x3
ffffffffc02024e4:	ad850513          	addi	a0,a0,-1320 # ffffffffc0204fb8 <etext+0x134a>
ffffffffc02024e8:	bcffd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02024ec:	018a3503          	ld	a0,24(s4)
ffffffffc02024f0:	4605                	li	a2,1
ffffffffc02024f2:	6585                	lui	a1,0x1
ffffffffc02024f4:	fe4fe0ef          	jal	ra,ffffffffc0200cd8 <get_pte>
ffffffffc02024f8:	3c050763          	beqz	a0,ffffffffc02028c6 <swap_init+0x4fe>
ffffffffc02024fc:	00003517          	auipc	a0,0x3
ffffffffc0202500:	b0c50513          	addi	a0,a0,-1268 # ffffffffc0205008 <etext+0x139a>
ffffffffc0202504:	0000e917          	auipc	s2,0xe
ffffffffc0202508:	bbc90913          	addi	s2,s2,-1092 # ffffffffc02100c0 <check_rp>
ffffffffc020250c:	babfd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0202510:	0000e997          	auipc	s3,0xe
ffffffffc0202514:	bd098993          	addi	s3,s3,-1072 # ffffffffc02100e0 <swap_in_seq_no>
ffffffffc0202518:	8bca                	mv	s7,s2
ffffffffc020251a:	4505                	li	a0,1
ffffffffc020251c:	eacfe0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202520:	00abb023          	sd	a0,0(s7)
ffffffffc0202524:	26050563          	beqz	a0,ffffffffc020278e <swap_init+0x3c6>
ffffffffc0202528:	651c                	ld	a5,8(a0)
ffffffffc020252a:	8b89                	andi	a5,a5,2
ffffffffc020252c:	24079163          	bnez	a5,ffffffffc020276e <swap_init+0x3a6>
ffffffffc0202530:	0ba1                	addi	s7,s7,8
ffffffffc0202532:	ff3b94e3          	bne	s7,s3,ffffffffc020251a <swap_init+0x152>
ffffffffc0202536:	601c                	ld	a5,0(s0)
ffffffffc0202538:	0000eb97          	auipc	s7,0xe
ffffffffc020253c:	b88b8b93          	addi	s7,s7,-1144 # ffffffffc02100c0 <check_rp>
ffffffffc0202540:	e000                	sd	s0,0(s0)
ffffffffc0202542:	e43e                	sd	a5,8(sp)
ffffffffc0202544:	641c                	ld	a5,8(s0)
ffffffffc0202546:	e400                	sd	s0,8(s0)
ffffffffc0202548:	e83e                	sd	a5,16(sp)
ffffffffc020254a:	481c                	lw	a5,16(s0)
ffffffffc020254c:	ec3e                	sd	a5,24(sp)
ffffffffc020254e:	0000e797          	auipc	a5,0xe
ffffffffc0202552:	c407a523          	sw	zero,-950(a5) # ffffffffc0210198 <free_area+0x10>
ffffffffc0202556:	000bb503          	ld	a0,0(s7)
ffffffffc020255a:	4585                	li	a1,1
ffffffffc020255c:	0ba1                	addi	s7,s7,8
ffffffffc020255e:	efcfe0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0202562:	ff3b9ae3          	bne	s7,s3,ffffffffc0202556 <swap_init+0x18e>
ffffffffc0202566:	01042b83          	lw	s7,16(s0)
ffffffffc020256a:	4791                	li	a5,4
ffffffffc020256c:	32fb9d63          	bne	s7,a5,ffffffffc02028a6 <swap_init+0x4de>
ffffffffc0202570:	00003517          	auipc	a0,0x3
ffffffffc0202574:	b2050513          	addi	a0,a0,-1248 # ffffffffc0205090 <etext+0x1422>
ffffffffc0202578:	b3ffd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020257c:	6705                	lui	a4,0x1
ffffffffc020257e:	0000e797          	auipc	a5,0xe
ffffffffc0202582:	ae07a123          	sw	zero,-1310(a5) # ffffffffc0210060 <pgfault_num>
ffffffffc0202586:	4629                	li	a2,10
ffffffffc0202588:	00c70023          	sb	a2,0(a4) # 1000 <kern_entry-0xffffffffc01ff000>
ffffffffc020258c:	0000e697          	auipc	a3,0xe
ffffffffc0202590:	ad46a683          	lw	a3,-1324(a3) # ffffffffc0210060 <pgfault_num>
ffffffffc0202594:	4585                	li	a1,1
ffffffffc0202596:	0000e797          	auipc	a5,0xe
ffffffffc020259a:	aca78793          	addi	a5,a5,-1334 # ffffffffc0210060 <pgfault_num>
ffffffffc020259e:	2cb69463          	bne	a3,a1,ffffffffc0202866 <swap_init+0x49e>
ffffffffc02025a2:	00c70823          	sb	a2,16(a4)
ffffffffc02025a6:	4398                	lw	a4,0(a5)
ffffffffc02025a8:	2701                	sext.w	a4,a4
ffffffffc02025aa:	2cd71e63          	bne	a4,a3,ffffffffc0202886 <swap_init+0x4be>
ffffffffc02025ae:	6689                	lui	a3,0x2
ffffffffc02025b0:	462d                	li	a2,11
ffffffffc02025b2:	00c68023          	sb	a2,0(a3) # 2000 <kern_entry-0xffffffffc01fe000>
ffffffffc02025b6:	4398                	lw	a4,0(a5)
ffffffffc02025b8:	4589                	li	a1,2
ffffffffc02025ba:	2701                	sext.w	a4,a4
ffffffffc02025bc:	22b71563          	bne	a4,a1,ffffffffc02027e6 <swap_init+0x41e>
ffffffffc02025c0:	00c68823          	sb	a2,16(a3)
ffffffffc02025c4:	4394                	lw	a3,0(a5)
ffffffffc02025c6:	2681                	sext.w	a3,a3
ffffffffc02025c8:	22e69f63          	bne	a3,a4,ffffffffc0202806 <swap_init+0x43e>
ffffffffc02025cc:	668d                	lui	a3,0x3
ffffffffc02025ce:	4631                	li	a2,12
ffffffffc02025d0:	00c68023          	sb	a2,0(a3) # 3000 <kern_entry-0xffffffffc01fd000>
ffffffffc02025d4:	4398                	lw	a4,0(a5)
ffffffffc02025d6:	458d                	li	a1,3
ffffffffc02025d8:	2701                	sext.w	a4,a4
ffffffffc02025da:	24b71663          	bne	a4,a1,ffffffffc0202826 <swap_init+0x45e>
ffffffffc02025de:	00c68823          	sb	a2,16(a3)
ffffffffc02025e2:	4394                	lw	a3,0(a5)
ffffffffc02025e4:	2681                	sext.w	a3,a3
ffffffffc02025e6:	26e69063          	bne	a3,a4,ffffffffc0202846 <swap_init+0x47e>
ffffffffc02025ea:	6691                	lui	a3,0x4
ffffffffc02025ec:	4635                	li	a2,13
ffffffffc02025ee:	00c68023          	sb	a2,0(a3) # 4000 <kern_entry-0xffffffffc01fc000>
ffffffffc02025f2:	4398                	lw	a4,0(a5)
ffffffffc02025f4:	2701                	sext.w	a4,a4
ffffffffc02025f6:	2f771863          	bne	a4,s7,ffffffffc02028e6 <swap_init+0x51e>
ffffffffc02025fa:	00c68823          	sb	a2,16(a3)
ffffffffc02025fe:	439c                	lw	a5,0(a5)
ffffffffc0202600:	2781                	sext.w	a5,a5
ffffffffc0202602:	30e79263          	bne	a5,a4,ffffffffc0202906 <swap_init+0x53e>
ffffffffc0202606:	481c                	lw	a5,16(s0)
ffffffffc0202608:	30079f63          	bnez	a5,ffffffffc0202926 <swap_init+0x55e>
ffffffffc020260c:	0000e797          	auipc	a5,0xe
ffffffffc0202610:	ad478793          	addi	a5,a5,-1324 # ffffffffc02100e0 <swap_in_seq_no>
ffffffffc0202614:	0000e717          	auipc	a4,0xe
ffffffffc0202618:	af470713          	addi	a4,a4,-1292 # ffffffffc0210108 <swap_out_seq_no>
ffffffffc020261c:	0000e617          	auipc	a2,0xe
ffffffffc0202620:	aec60613          	addi	a2,a2,-1300 # ffffffffc0210108 <swap_out_seq_no>
ffffffffc0202624:	56fd                	li	a3,-1
ffffffffc0202626:	c394                	sw	a3,0(a5)
ffffffffc0202628:	c314                	sw	a3,0(a4)
ffffffffc020262a:	0791                	addi	a5,a5,4
ffffffffc020262c:	0711                	addi	a4,a4,4
ffffffffc020262e:	fef61ce3          	bne	a2,a5,ffffffffc0202626 <swap_init+0x25e>
ffffffffc0202632:	0000e697          	auipc	a3,0xe
ffffffffc0202636:	b3668693          	addi	a3,a3,-1226 # ffffffffc0210168 <check_ptep>
ffffffffc020263a:	0000ec17          	auipc	s8,0xe
ffffffffc020263e:	a86c0c13          	addi	s8,s8,-1402 # ffffffffc02100c0 <check_rp>
ffffffffc0202642:	6b85                	lui	s7,0x1
ffffffffc0202644:	0000ed97          	auipc	s11,0xe
ffffffffc0202648:	a14d8d93          	addi	s11,s11,-1516 # ffffffffc0210058 <npage>
ffffffffc020264c:	0000ed17          	auipc	s10,0xe
ffffffffc0202650:	a64d0d13          	addi	s10,s10,-1436 # ffffffffc02100b0 <pages>
ffffffffc0202654:	00003c97          	auipc	s9,0x3
ffffffffc0202658:	27cc8c93          	addi	s9,s9,636 # ffffffffc02058d0 <nbase>
ffffffffc020265c:	0006b023          	sd	zero,0(a3)
ffffffffc0202660:	4601                	li	a2,0
ffffffffc0202662:	85de                	mv	a1,s7
ffffffffc0202664:	855a                	mv	a0,s6
ffffffffc0202666:	e036                	sd	a3,0(sp)
ffffffffc0202668:	e70fe0ef          	jal	ra,ffffffffc0200cd8 <get_pte>
ffffffffc020266c:	6682                	ld	a3,0(sp)
ffffffffc020266e:	e288                	sd	a0,0(a3)
ffffffffc0202670:	12050f63          	beqz	a0,ffffffffc02027ae <swap_init+0x3e6>
ffffffffc0202674:	611c                	ld	a5,0(a0)
ffffffffc0202676:	0017f713          	andi	a4,a5,1
ffffffffc020267a:	c371                	beqz	a4,ffffffffc020273e <swap_init+0x376>
ffffffffc020267c:	000db703          	ld	a4,0(s11)
ffffffffc0202680:	078a                	slli	a5,a5,0x2
ffffffffc0202682:	83b1                	srli	a5,a5,0xc
ffffffffc0202684:	0ce7f963          	bgeu	a5,a4,ffffffffc0202756 <swap_init+0x38e>
ffffffffc0202688:	000cb703          	ld	a4,0(s9)
ffffffffc020268c:	000d3603          	ld	a2,0(s10)
ffffffffc0202690:	000c3503          	ld	a0,0(s8)
ffffffffc0202694:	8f99                	sub	a5,a5,a4
ffffffffc0202696:	00379713          	slli	a4,a5,0x3
ffffffffc020269a:	97ba                	add	a5,a5,a4
ffffffffc020269c:	078e                	slli	a5,a5,0x3
ffffffffc020269e:	97b2                	add	a5,a5,a2
ffffffffc02026a0:	06f51f63          	bne	a0,a5,ffffffffc020271e <swap_init+0x356>
ffffffffc02026a4:	6785                	lui	a5,0x1
ffffffffc02026a6:	9bbe                	add	s7,s7,a5
ffffffffc02026a8:	6795                	lui	a5,0x5
ffffffffc02026aa:	06a1                	addi	a3,a3,8
ffffffffc02026ac:	0c21                	addi	s8,s8,8
ffffffffc02026ae:	fafb97e3          	bne	s7,a5,ffffffffc020265c <swap_init+0x294>
ffffffffc02026b2:	00003517          	auipc	a0,0x3
ffffffffc02026b6:	a9650513          	addi	a0,a0,-1386 # ffffffffc0205148 <etext+0x14da>
ffffffffc02026ba:	9fdfd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02026be:	000ab783          	ld	a5,0(s5)
ffffffffc02026c2:	7f9c                	ld	a5,56(a5)
ffffffffc02026c4:	9782                	jalr	a5
ffffffffc02026c6:	28051063          	bnez	a0,ffffffffc0202946 <swap_init+0x57e>
ffffffffc02026ca:	00093503          	ld	a0,0(s2)
ffffffffc02026ce:	4585                	li	a1,1
ffffffffc02026d0:	0921                	addi	s2,s2,8
ffffffffc02026d2:	d88fe0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc02026d6:	ff391ae3          	bne	s2,s3,ffffffffc02026ca <swap_init+0x302>
ffffffffc02026da:	8552                	mv	a0,s4
ffffffffc02026dc:	eb2ff0ef          	jal	ra,ffffffffc0201d8e <mm_destroy>
ffffffffc02026e0:	67e2                	ld	a5,24(sp)
ffffffffc02026e2:	00003517          	auipc	a0,0x3
ffffffffc02026e6:	a9650513          	addi	a0,a0,-1386 # ffffffffc0205178 <etext+0x150a>
ffffffffc02026ea:	c81c                	sw	a5,16(s0)
ffffffffc02026ec:	67a2                	ld	a5,8(sp)
ffffffffc02026ee:	e01c                	sd	a5,0(s0)
ffffffffc02026f0:	67c2                	ld	a5,16(sp)
ffffffffc02026f2:	e41c                	sd	a5,8(s0)
ffffffffc02026f4:	9c3fd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02026f8:	b30d                	j	ffffffffc020241a <swap_init+0x52>
ffffffffc02026fa:	4a01                	li	s4,0
ffffffffc02026fc:	b361                	j	ffffffffc0202484 <swap_init+0xbc>
ffffffffc02026fe:	00003697          	auipc	a3,0x3
ffffffffc0202702:	84a68693          	addi	a3,a3,-1974 # ffffffffc0204f48 <etext+0x12da>
ffffffffc0202706:	00002617          	auipc	a2,0x2
ffffffffc020270a:	cb260613          	addi	a2,a2,-846 # ffffffffc02043b8 <etext+0x74a>
ffffffffc020270e:	0c500593          	li	a1,197
ffffffffc0202712:	00003517          	auipc	a0,0x3
ffffffffc0202716:	80e50513          	addi	a0,a0,-2034 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc020271a:	9d3fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020271e:	00003697          	auipc	a3,0x3
ffffffffc0202722:	a0268693          	addi	a3,a3,-1534 # ffffffffc0205120 <etext+0x14b2>
ffffffffc0202726:	00002617          	auipc	a2,0x2
ffffffffc020272a:	c9260613          	addi	a2,a2,-878 # ffffffffc02043b8 <etext+0x74a>
ffffffffc020272e:	10400593          	li	a1,260
ffffffffc0202732:	00002517          	auipc	a0,0x2
ffffffffc0202736:	7ee50513          	addi	a0,a0,2030 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc020273a:	9b3fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020273e:	00002617          	auipc	a2,0x2
ffffffffc0202742:	06260613          	addi	a2,a2,98 # ffffffffc02047a0 <etext+0xb32>
ffffffffc0202746:	07000593          	li	a1,112
ffffffffc020274a:	00002517          	auipc	a0,0x2
ffffffffc020274e:	e5e50513          	addi	a0,a0,-418 # ffffffffc02045a8 <etext+0x93a>
ffffffffc0202752:	99bfd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202756:	00002617          	auipc	a2,0x2
ffffffffc020275a:	e3260613          	addi	a2,a2,-462 # ffffffffc0204588 <etext+0x91a>
ffffffffc020275e:	06500593          	li	a1,101
ffffffffc0202762:	00002517          	auipc	a0,0x2
ffffffffc0202766:	e4650513          	addi	a0,a0,-442 # ffffffffc02045a8 <etext+0x93a>
ffffffffc020276a:	983fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020276e:	00003697          	auipc	a3,0x3
ffffffffc0202772:	8da68693          	addi	a3,a3,-1830 # ffffffffc0205048 <etext+0x13da>
ffffffffc0202776:	00002617          	auipc	a2,0x2
ffffffffc020277a:	c4260613          	addi	a2,a2,-958 # ffffffffc02043b8 <etext+0x74a>
ffffffffc020277e:	0e600593          	li	a1,230
ffffffffc0202782:	00002517          	auipc	a0,0x2
ffffffffc0202786:	79e50513          	addi	a0,a0,1950 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc020278a:	963fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020278e:	00003697          	auipc	a3,0x3
ffffffffc0202792:	8a268693          	addi	a3,a3,-1886 # ffffffffc0205030 <etext+0x13c2>
ffffffffc0202796:	00002617          	auipc	a2,0x2
ffffffffc020279a:	c2260613          	addi	a2,a2,-990 # ffffffffc02043b8 <etext+0x74a>
ffffffffc020279e:	0e500593          	li	a1,229
ffffffffc02027a2:	00002517          	auipc	a0,0x2
ffffffffc02027a6:	77e50513          	addi	a0,a0,1918 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc02027aa:	943fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02027ae:	00003697          	auipc	a3,0x3
ffffffffc02027b2:	95a68693          	addi	a3,a3,-1702 # ffffffffc0205108 <etext+0x149a>
ffffffffc02027b6:	00002617          	auipc	a2,0x2
ffffffffc02027ba:	c0260613          	addi	a2,a2,-1022 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02027be:	10300593          	li	a1,259
ffffffffc02027c2:	00002517          	auipc	a0,0x2
ffffffffc02027c6:	75e50513          	addi	a0,a0,1886 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc02027ca:	923fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02027ce:	00002617          	auipc	a2,0x2
ffffffffc02027d2:	73260613          	addi	a2,a2,1842 # ffffffffc0204f00 <etext+0x1292>
ffffffffc02027d6:	02800593          	li	a1,40
ffffffffc02027da:	00002517          	auipc	a0,0x2
ffffffffc02027de:	74650513          	addi	a0,a0,1862 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc02027e2:	90bfd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02027e6:	00003697          	auipc	a3,0x3
ffffffffc02027ea:	8e268693          	addi	a3,a3,-1822 # ffffffffc02050c8 <etext+0x145a>
ffffffffc02027ee:	00002617          	auipc	a2,0x2
ffffffffc02027f2:	bca60613          	addi	a2,a2,-1078 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02027f6:	0a000593          	li	a1,160
ffffffffc02027fa:	00002517          	auipc	a0,0x2
ffffffffc02027fe:	72650513          	addi	a0,a0,1830 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc0202802:	8ebfd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202806:	00003697          	auipc	a3,0x3
ffffffffc020280a:	8c268693          	addi	a3,a3,-1854 # ffffffffc02050c8 <etext+0x145a>
ffffffffc020280e:	00002617          	auipc	a2,0x2
ffffffffc0202812:	baa60613          	addi	a2,a2,-1110 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202816:	0a200593          	li	a1,162
ffffffffc020281a:	00002517          	auipc	a0,0x2
ffffffffc020281e:	70650513          	addi	a0,a0,1798 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc0202822:	8cbfd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202826:	00003697          	auipc	a3,0x3
ffffffffc020282a:	8b268693          	addi	a3,a3,-1870 # ffffffffc02050d8 <etext+0x146a>
ffffffffc020282e:	00002617          	auipc	a2,0x2
ffffffffc0202832:	b8a60613          	addi	a2,a2,-1142 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202836:	0a400593          	li	a1,164
ffffffffc020283a:	00002517          	auipc	a0,0x2
ffffffffc020283e:	6e650513          	addi	a0,a0,1766 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc0202842:	8abfd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202846:	00003697          	auipc	a3,0x3
ffffffffc020284a:	89268693          	addi	a3,a3,-1902 # ffffffffc02050d8 <etext+0x146a>
ffffffffc020284e:	00002617          	auipc	a2,0x2
ffffffffc0202852:	b6a60613          	addi	a2,a2,-1174 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202856:	0a600593          	li	a1,166
ffffffffc020285a:	00002517          	auipc	a0,0x2
ffffffffc020285e:	6c650513          	addi	a0,a0,1734 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc0202862:	88bfd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202866:	00003697          	auipc	a3,0x3
ffffffffc020286a:	85268693          	addi	a3,a3,-1966 # ffffffffc02050b8 <etext+0x144a>
ffffffffc020286e:	00002617          	auipc	a2,0x2
ffffffffc0202872:	b4a60613          	addi	a2,a2,-1206 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202876:	09c00593          	li	a1,156
ffffffffc020287a:	00002517          	auipc	a0,0x2
ffffffffc020287e:	6a650513          	addi	a0,a0,1702 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc0202882:	86bfd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202886:	00003697          	auipc	a3,0x3
ffffffffc020288a:	83268693          	addi	a3,a3,-1998 # ffffffffc02050b8 <etext+0x144a>
ffffffffc020288e:	00002617          	auipc	a2,0x2
ffffffffc0202892:	b2a60613          	addi	a2,a2,-1238 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202896:	09e00593          	li	a1,158
ffffffffc020289a:	00002517          	auipc	a0,0x2
ffffffffc020289e:	68650513          	addi	a0,a0,1670 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc02028a2:	84bfd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02028a6:	00002697          	auipc	a3,0x2
ffffffffc02028aa:	7c268693          	addi	a3,a3,1986 # ffffffffc0205068 <etext+0x13fa>
ffffffffc02028ae:	00002617          	auipc	a2,0x2
ffffffffc02028b2:	b0a60613          	addi	a2,a2,-1270 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02028b6:	0f300593          	li	a1,243
ffffffffc02028ba:	00002517          	auipc	a0,0x2
ffffffffc02028be:	66650513          	addi	a0,a0,1638 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc02028c2:	82bfd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02028c6:	00002697          	auipc	a3,0x2
ffffffffc02028ca:	72a68693          	addi	a3,a3,1834 # ffffffffc0204ff0 <etext+0x1382>
ffffffffc02028ce:	00002617          	auipc	a2,0x2
ffffffffc02028d2:	aea60613          	addi	a2,a2,-1302 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02028d6:	0e000593          	li	a1,224
ffffffffc02028da:	00002517          	auipc	a0,0x2
ffffffffc02028de:	64650513          	addi	a0,a0,1606 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc02028e2:	80bfd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02028e6:	00003697          	auipc	a3,0x3
ffffffffc02028ea:	80268693          	addi	a3,a3,-2046 # ffffffffc02050e8 <etext+0x147a>
ffffffffc02028ee:	00002617          	auipc	a2,0x2
ffffffffc02028f2:	aca60613          	addi	a2,a2,-1334 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02028f6:	0a800593          	li	a1,168
ffffffffc02028fa:	00002517          	auipc	a0,0x2
ffffffffc02028fe:	62650513          	addi	a0,a0,1574 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc0202902:	feafd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202906:	00002697          	auipc	a3,0x2
ffffffffc020290a:	7e268693          	addi	a3,a3,2018 # ffffffffc02050e8 <etext+0x147a>
ffffffffc020290e:	00002617          	auipc	a2,0x2
ffffffffc0202912:	aaa60613          	addi	a2,a2,-1366 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202916:	0aa00593          	li	a1,170
ffffffffc020291a:	00002517          	auipc	a0,0x2
ffffffffc020291e:	60650513          	addi	a0,a0,1542 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc0202922:	fcafd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202926:	00002697          	auipc	a3,0x2
ffffffffc020292a:	7d268693          	addi	a3,a3,2002 # ffffffffc02050f8 <etext+0x148a>
ffffffffc020292e:	00002617          	auipc	a2,0x2
ffffffffc0202932:	a8a60613          	addi	a2,a2,-1398 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202936:	0fc00593          	li	a1,252
ffffffffc020293a:	00002517          	auipc	a0,0x2
ffffffffc020293e:	5e650513          	addi	a0,a0,1510 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc0202942:	faafd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202946:	00003697          	auipc	a3,0x3
ffffffffc020294a:	82a68693          	addi	a3,a3,-2006 # ffffffffc0205170 <etext+0x1502>
ffffffffc020294e:	00002617          	auipc	a2,0x2
ffffffffc0202952:	a6a60613          	addi	a2,a2,-1430 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202956:	10b00593          	li	a1,267
ffffffffc020295a:	00002517          	auipc	a0,0x2
ffffffffc020295e:	5c650513          	addi	a0,a0,1478 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc0202962:	f8afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202966:	00002697          	auipc	a3,0x2
ffffffffc020296a:	2e268693          	addi	a3,a3,738 # ffffffffc0204c48 <etext+0xfda>
ffffffffc020296e:	00002617          	auipc	a2,0x2
ffffffffc0202972:	a4a60613          	addi	a2,a2,-1462 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202976:	0cd00593          	li	a1,205
ffffffffc020297a:	00002517          	auipc	a0,0x2
ffffffffc020297e:	5a650513          	addi	a0,a0,1446 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc0202982:	f6afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202986:	00002697          	auipc	a3,0x2
ffffffffc020298a:	61a68693          	addi	a3,a3,1562 # ffffffffc0204fa0 <etext+0x1332>
ffffffffc020298e:	00002617          	auipc	a2,0x2
ffffffffc0202992:	a2a60613          	addi	a2,a2,-1494 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202996:	0d000593          	li	a1,208
ffffffffc020299a:	00002517          	auipc	a0,0x2
ffffffffc020299e:	58650513          	addi	a0,a0,1414 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc02029a2:	f4afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02029a6:	00002697          	auipc	a3,0x2
ffffffffc02029aa:	45268693          	addi	a3,a3,1106 # ffffffffc0204df8 <etext+0x118a>
ffffffffc02029ae:	00002617          	auipc	a2,0x2
ffffffffc02029b2:	a0a60613          	addi	a2,a2,-1526 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02029b6:	0d500593          	li	a1,213
ffffffffc02029ba:	00002517          	auipc	a0,0x2
ffffffffc02029be:	56650513          	addi	a0,a0,1382 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc02029c2:	f2afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02029c6:	00002697          	auipc	a3,0x2
ffffffffc02029ca:	4aa68693          	addi	a3,a3,1194 # ffffffffc0204e70 <etext+0x1202>
ffffffffc02029ce:	00002617          	auipc	a2,0x2
ffffffffc02029d2:	9ea60613          	addi	a2,a2,-1558 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02029d6:	0d800593          	li	a1,216
ffffffffc02029da:	00002517          	auipc	a0,0x2
ffffffffc02029de:	54650513          	addi	a0,a0,1350 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc02029e2:	f0afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02029e6:	00002697          	auipc	a3,0x2
ffffffffc02029ea:	57268693          	addi	a3,a3,1394 # ffffffffc0204f58 <etext+0x12ea>
ffffffffc02029ee:	00002617          	auipc	a2,0x2
ffffffffc02029f2:	9ca60613          	addi	a2,a2,-1590 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02029f6:	0c800593          	li	a1,200
ffffffffc02029fa:	00002517          	auipc	a0,0x2
ffffffffc02029fe:	52650513          	addi	a0,a0,1318 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc0202a02:	eeafd0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0202a06 <swap_init_mm>:
ffffffffc0202a06:	0000d797          	auipc	a5,0xd
ffffffffc0202a0a:	6627b783          	ld	a5,1634(a5) # ffffffffc0210068 <sm>
ffffffffc0202a0e:	0107b303          	ld	t1,16(a5)
ffffffffc0202a12:	8302                	jr	t1

ffffffffc0202a14 <swap_map_swappable>:
ffffffffc0202a14:	0000d797          	auipc	a5,0xd
ffffffffc0202a18:	6547b783          	ld	a5,1620(a5) # ffffffffc0210068 <sm>
ffffffffc0202a1c:	0207b303          	ld	t1,32(a5)
ffffffffc0202a20:	8302                	jr	t1

ffffffffc0202a22 <swap_out>:
ffffffffc0202a22:	711d                	addi	sp,sp,-96
ffffffffc0202a24:	ec86                	sd	ra,88(sp)
ffffffffc0202a26:	e8a2                	sd	s0,80(sp)
ffffffffc0202a28:	e4a6                	sd	s1,72(sp)
ffffffffc0202a2a:	e0ca                	sd	s2,64(sp)
ffffffffc0202a2c:	fc4e                	sd	s3,56(sp)
ffffffffc0202a2e:	f852                	sd	s4,48(sp)
ffffffffc0202a30:	f456                	sd	s5,40(sp)
ffffffffc0202a32:	f05a                	sd	s6,32(sp)
ffffffffc0202a34:	ec5e                	sd	s7,24(sp)
ffffffffc0202a36:	e862                	sd	s8,16(sp)
ffffffffc0202a38:	cde9                	beqz	a1,ffffffffc0202b12 <swap_out+0xf0>
ffffffffc0202a3a:	8a2e                	mv	s4,a1
ffffffffc0202a3c:	892a                	mv	s2,a0
ffffffffc0202a3e:	8ab2                	mv	s5,a2
ffffffffc0202a40:	4401                	li	s0,0
ffffffffc0202a42:	0000d997          	auipc	s3,0xd
ffffffffc0202a46:	62698993          	addi	s3,s3,1574 # ffffffffc0210068 <sm>
ffffffffc0202a4a:	00002b17          	auipc	s6,0x2
ffffffffc0202a4e:	7aeb0b13          	addi	s6,s6,1966 # ffffffffc02051f8 <etext+0x158a>
ffffffffc0202a52:	00002b97          	auipc	s7,0x2
ffffffffc0202a56:	78eb8b93          	addi	s7,s7,1934 # ffffffffc02051e0 <etext+0x1572>
ffffffffc0202a5a:	a825                	j	ffffffffc0202a92 <swap_out+0x70>
ffffffffc0202a5c:	67a2                	ld	a5,8(sp)
ffffffffc0202a5e:	8626                	mv	a2,s1
ffffffffc0202a60:	85a2                	mv	a1,s0
ffffffffc0202a62:	63b4                	ld	a3,64(a5)
ffffffffc0202a64:	855a                	mv	a0,s6
ffffffffc0202a66:	2405                	addiw	s0,s0,1
ffffffffc0202a68:	82b1                	srli	a3,a3,0xc
ffffffffc0202a6a:	0685                	addi	a3,a3,1
ffffffffc0202a6c:	e4afd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0202a70:	6522                	ld	a0,8(sp)
ffffffffc0202a72:	4585                	li	a1,1
ffffffffc0202a74:	613c                	ld	a5,64(a0)
ffffffffc0202a76:	83b1                	srli	a5,a5,0xc
ffffffffc0202a78:	0785                	addi	a5,a5,1
ffffffffc0202a7a:	07a2                	slli	a5,a5,0x8
ffffffffc0202a7c:	00fc3023          	sd	a5,0(s8)
ffffffffc0202a80:	9dafe0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0202a84:	01893503          	ld	a0,24(s2)
ffffffffc0202a88:	85a6                	mv	a1,s1
ffffffffc0202a8a:	f57fe0ef          	jal	ra,ffffffffc02019e0 <tlb_invalidate>
ffffffffc0202a8e:	048a0d63          	beq	s4,s0,ffffffffc0202ae8 <swap_out+0xc6>
ffffffffc0202a92:	0009b783          	ld	a5,0(s3)
ffffffffc0202a96:	8656                	mv	a2,s5
ffffffffc0202a98:	002c                	addi	a1,sp,8
ffffffffc0202a9a:	7b9c                	ld	a5,48(a5)
ffffffffc0202a9c:	854a                	mv	a0,s2
ffffffffc0202a9e:	9782                	jalr	a5
ffffffffc0202aa0:	e12d                	bnez	a0,ffffffffc0202b02 <swap_out+0xe0>
ffffffffc0202aa2:	67a2                	ld	a5,8(sp)
ffffffffc0202aa4:	01893503          	ld	a0,24(s2)
ffffffffc0202aa8:	4601                	li	a2,0
ffffffffc0202aaa:	63a4                	ld	s1,64(a5)
ffffffffc0202aac:	85a6                	mv	a1,s1
ffffffffc0202aae:	a2afe0ef          	jal	ra,ffffffffc0200cd8 <get_pte>
ffffffffc0202ab2:	611c                	ld	a5,0(a0)
ffffffffc0202ab4:	8c2a                	mv	s8,a0
ffffffffc0202ab6:	8b85                	andi	a5,a5,1
ffffffffc0202ab8:	cfb9                	beqz	a5,ffffffffc0202b16 <swap_out+0xf4>
ffffffffc0202aba:	65a2                	ld	a1,8(sp)
ffffffffc0202abc:	61bc                	ld	a5,64(a1)
ffffffffc0202abe:	83b1                	srli	a5,a5,0xc
ffffffffc0202ac0:	0785                	addi	a5,a5,1
ffffffffc0202ac2:	00879513          	slli	a0,a5,0x8
ffffffffc0202ac6:	491000ef          	jal	ra,ffffffffc0203756 <swapfs_write>
ffffffffc0202aca:	d949                	beqz	a0,ffffffffc0202a5c <swap_out+0x3a>
ffffffffc0202acc:	855e                	mv	a0,s7
ffffffffc0202ace:	de8fd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0202ad2:	0009b783          	ld	a5,0(s3)
ffffffffc0202ad6:	6622                	ld	a2,8(sp)
ffffffffc0202ad8:	4681                	li	a3,0
ffffffffc0202ada:	739c                	ld	a5,32(a5)
ffffffffc0202adc:	85a6                	mv	a1,s1
ffffffffc0202ade:	854a                	mv	a0,s2
ffffffffc0202ae0:	2405                	addiw	s0,s0,1
ffffffffc0202ae2:	9782                	jalr	a5
ffffffffc0202ae4:	fa8a17e3          	bne	s4,s0,ffffffffc0202a92 <swap_out+0x70>
ffffffffc0202ae8:	60e6                	ld	ra,88(sp)
ffffffffc0202aea:	8522                	mv	a0,s0
ffffffffc0202aec:	6446                	ld	s0,80(sp)
ffffffffc0202aee:	64a6                	ld	s1,72(sp)
ffffffffc0202af0:	6906                	ld	s2,64(sp)
ffffffffc0202af2:	79e2                	ld	s3,56(sp)
ffffffffc0202af4:	7a42                	ld	s4,48(sp)
ffffffffc0202af6:	7aa2                	ld	s5,40(sp)
ffffffffc0202af8:	7b02                	ld	s6,32(sp)
ffffffffc0202afa:	6be2                	ld	s7,24(sp)
ffffffffc0202afc:	6c42                	ld	s8,16(sp)
ffffffffc0202afe:	6125                	addi	sp,sp,96
ffffffffc0202b00:	8082                	ret
ffffffffc0202b02:	85a2                	mv	a1,s0
ffffffffc0202b04:	00002517          	auipc	a0,0x2
ffffffffc0202b08:	69450513          	addi	a0,a0,1684 # ffffffffc0205198 <etext+0x152a>
ffffffffc0202b0c:	daafd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0202b10:	bfe1                	j	ffffffffc0202ae8 <swap_out+0xc6>
ffffffffc0202b12:	4401                	li	s0,0
ffffffffc0202b14:	bfd1                	j	ffffffffc0202ae8 <swap_out+0xc6>
ffffffffc0202b16:	00002697          	auipc	a3,0x2
ffffffffc0202b1a:	6b268693          	addi	a3,a3,1714 # ffffffffc02051c8 <etext+0x155a>
ffffffffc0202b1e:	00002617          	auipc	a2,0x2
ffffffffc0202b22:	89a60613          	addi	a2,a2,-1894 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202b26:	07200593          	li	a1,114
ffffffffc0202b2a:	00002517          	auipc	a0,0x2
ffffffffc0202b2e:	3f650513          	addi	a0,a0,1014 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc0202b32:	dbafd0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0202b36 <swap_in>:
ffffffffc0202b36:	7179                	addi	sp,sp,-48
ffffffffc0202b38:	e84a                	sd	s2,16(sp)
ffffffffc0202b3a:	892a                	mv	s2,a0
ffffffffc0202b3c:	4505                	li	a0,1
ffffffffc0202b3e:	ec26                	sd	s1,24(sp)
ffffffffc0202b40:	e44e                	sd	s3,8(sp)
ffffffffc0202b42:	f406                	sd	ra,40(sp)
ffffffffc0202b44:	f022                	sd	s0,32(sp)
ffffffffc0202b46:	84ae                	mv	s1,a1
ffffffffc0202b48:	89b2                	mv	s3,a2
ffffffffc0202b4a:	87efe0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202b4e:	c129                	beqz	a0,ffffffffc0202b90 <swap_in+0x5a>
ffffffffc0202b50:	842a                	mv	s0,a0
ffffffffc0202b52:	01893503          	ld	a0,24(s2)
ffffffffc0202b56:	4601                	li	a2,0
ffffffffc0202b58:	85a6                	mv	a1,s1
ffffffffc0202b5a:	97efe0ef          	jal	ra,ffffffffc0200cd8 <get_pte>
ffffffffc0202b5e:	892a                	mv	s2,a0
ffffffffc0202b60:	6108                	ld	a0,0(a0)
ffffffffc0202b62:	85a2                	mv	a1,s0
ffffffffc0202b64:	359000ef          	jal	ra,ffffffffc02036bc <swapfs_read>
ffffffffc0202b68:	00093583          	ld	a1,0(s2)
ffffffffc0202b6c:	8626                	mv	a2,s1
ffffffffc0202b6e:	00002517          	auipc	a0,0x2
ffffffffc0202b72:	6da50513          	addi	a0,a0,1754 # ffffffffc0205248 <etext+0x15da>
ffffffffc0202b76:	81a1                	srli	a1,a1,0x8
ffffffffc0202b78:	d3efd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0202b7c:	70a2                	ld	ra,40(sp)
ffffffffc0202b7e:	0089b023          	sd	s0,0(s3)
ffffffffc0202b82:	7402                	ld	s0,32(sp)
ffffffffc0202b84:	64e2                	ld	s1,24(sp)
ffffffffc0202b86:	6942                	ld	s2,16(sp)
ffffffffc0202b88:	69a2                	ld	s3,8(sp)
ffffffffc0202b8a:	4501                	li	a0,0
ffffffffc0202b8c:	6145                	addi	sp,sp,48
ffffffffc0202b8e:	8082                	ret
ffffffffc0202b90:	00002697          	auipc	a3,0x2
ffffffffc0202b94:	6a868693          	addi	a3,a3,1704 # ffffffffc0205238 <etext+0x15ca>
ffffffffc0202b98:	00002617          	auipc	a2,0x2
ffffffffc0202b9c:	82060613          	addi	a2,a2,-2016 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202ba0:	08800593          	li	a1,136
ffffffffc0202ba4:	00002517          	auipc	a0,0x2
ffffffffc0202ba8:	37c50513          	addi	a0,a0,892 # ffffffffc0204f20 <etext+0x12b2>
ffffffffc0202bac:	d40fd0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0202bb0 <default_init>:
ffffffffc0202bb0:	0000d797          	auipc	a5,0xd
ffffffffc0202bb4:	5d878793          	addi	a5,a5,1496 # ffffffffc0210188 <free_area>
ffffffffc0202bb8:	e79c                	sd	a5,8(a5)
ffffffffc0202bba:	e39c                	sd	a5,0(a5)
ffffffffc0202bbc:	0007a823          	sw	zero,16(a5)
ffffffffc0202bc0:	8082                	ret

ffffffffc0202bc2 <default_nr_free_pages>:
ffffffffc0202bc2:	0000d517          	auipc	a0,0xd
ffffffffc0202bc6:	5d656503          	lwu	a0,1494(a0) # ffffffffc0210198 <free_area+0x10>
ffffffffc0202bca:	8082                	ret

ffffffffc0202bcc <default_check>:
ffffffffc0202bcc:	715d                	addi	sp,sp,-80
ffffffffc0202bce:	e0a2                	sd	s0,64(sp)
ffffffffc0202bd0:	0000d417          	auipc	s0,0xd
ffffffffc0202bd4:	5b840413          	addi	s0,s0,1464 # ffffffffc0210188 <free_area>
ffffffffc0202bd8:	641c                	ld	a5,8(s0)
ffffffffc0202bda:	e486                	sd	ra,72(sp)
ffffffffc0202bdc:	fc26                	sd	s1,56(sp)
ffffffffc0202bde:	f84a                	sd	s2,48(sp)
ffffffffc0202be0:	f44e                	sd	s3,40(sp)
ffffffffc0202be2:	f052                	sd	s4,32(sp)
ffffffffc0202be4:	ec56                	sd	s5,24(sp)
ffffffffc0202be6:	e85a                	sd	s6,16(sp)
ffffffffc0202be8:	e45e                	sd	s7,8(sp)
ffffffffc0202bea:	e062                	sd	s8,0(sp)
ffffffffc0202bec:	2c878763          	beq	a5,s0,ffffffffc0202eba <default_check+0x2ee>
ffffffffc0202bf0:	4481                	li	s1,0
ffffffffc0202bf2:	4901                	li	s2,0
ffffffffc0202bf4:	fe87b703          	ld	a4,-24(a5)
ffffffffc0202bf8:	8b09                	andi	a4,a4,2
ffffffffc0202bfa:	2c070463          	beqz	a4,ffffffffc0202ec2 <default_check+0x2f6>
ffffffffc0202bfe:	ff87a703          	lw	a4,-8(a5)
ffffffffc0202c02:	679c                	ld	a5,8(a5)
ffffffffc0202c04:	2905                	addiw	s2,s2,1
ffffffffc0202c06:	9cb9                	addw	s1,s1,a4
ffffffffc0202c08:	fe8796e3          	bne	a5,s0,ffffffffc0202bf4 <default_check+0x28>
ffffffffc0202c0c:	89a6                	mv	s3,s1
ffffffffc0202c0e:	88efe0ef          	jal	ra,ffffffffc0200c9c <nr_free_pages>
ffffffffc0202c12:	71351863          	bne	a0,s3,ffffffffc0203322 <default_check+0x756>
ffffffffc0202c16:	4505                	li	a0,1
ffffffffc0202c18:	fb1fd0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202c1c:	8a2a                	mv	s4,a0
ffffffffc0202c1e:	44050263          	beqz	a0,ffffffffc0203062 <default_check+0x496>
ffffffffc0202c22:	4505                	li	a0,1
ffffffffc0202c24:	fa5fd0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202c28:	89aa                	mv	s3,a0
ffffffffc0202c2a:	70050c63          	beqz	a0,ffffffffc0203342 <default_check+0x776>
ffffffffc0202c2e:	4505                	li	a0,1
ffffffffc0202c30:	f99fd0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202c34:	8aaa                	mv	s5,a0
ffffffffc0202c36:	4a050663          	beqz	a0,ffffffffc02030e2 <default_check+0x516>
ffffffffc0202c3a:	2b3a0463          	beq	s4,s3,ffffffffc0202ee2 <default_check+0x316>
ffffffffc0202c3e:	2aaa0263          	beq	s4,a0,ffffffffc0202ee2 <default_check+0x316>
ffffffffc0202c42:	2aa98063          	beq	s3,a0,ffffffffc0202ee2 <default_check+0x316>
ffffffffc0202c46:	000a2783          	lw	a5,0(s4)
ffffffffc0202c4a:	2a079c63          	bnez	a5,ffffffffc0202f02 <default_check+0x336>
ffffffffc0202c4e:	0009a783          	lw	a5,0(s3)
ffffffffc0202c52:	2a079863          	bnez	a5,ffffffffc0202f02 <default_check+0x336>
ffffffffc0202c56:	411c                	lw	a5,0(a0)
ffffffffc0202c58:	2a079563          	bnez	a5,ffffffffc0202f02 <default_check+0x336>
ffffffffc0202c5c:	0000d797          	auipc	a5,0xd
ffffffffc0202c60:	4547b783          	ld	a5,1108(a5) # ffffffffc02100b0 <pages>
ffffffffc0202c64:	40fa0733          	sub	a4,s4,a5
ffffffffc0202c68:	870d                	srai	a4,a4,0x3
ffffffffc0202c6a:	00003597          	auipc	a1,0x3
ffffffffc0202c6e:	c5e5b583          	ld	a1,-930(a1) # ffffffffc02058c8 <error_string+0x38>
ffffffffc0202c72:	02b70733          	mul	a4,a4,a1
ffffffffc0202c76:	00003617          	auipc	a2,0x3
ffffffffc0202c7a:	c5a63603          	ld	a2,-934(a2) # ffffffffc02058d0 <nbase>
ffffffffc0202c7e:	0000d697          	auipc	a3,0xd
ffffffffc0202c82:	3da6b683          	ld	a3,986(a3) # ffffffffc0210058 <npage>
ffffffffc0202c86:	06b2                	slli	a3,a3,0xc
ffffffffc0202c88:	9732                	add	a4,a4,a2
ffffffffc0202c8a:	0732                	slli	a4,a4,0xc
ffffffffc0202c8c:	28d77b63          	bgeu	a4,a3,ffffffffc0202f22 <default_check+0x356>
ffffffffc0202c90:	40f98733          	sub	a4,s3,a5
ffffffffc0202c94:	870d                	srai	a4,a4,0x3
ffffffffc0202c96:	02b70733          	mul	a4,a4,a1
ffffffffc0202c9a:	9732                	add	a4,a4,a2
ffffffffc0202c9c:	0732                	slli	a4,a4,0xc
ffffffffc0202c9e:	4cd77263          	bgeu	a4,a3,ffffffffc0203162 <default_check+0x596>
ffffffffc0202ca2:	40f507b3          	sub	a5,a0,a5
ffffffffc0202ca6:	878d                	srai	a5,a5,0x3
ffffffffc0202ca8:	02b787b3          	mul	a5,a5,a1
ffffffffc0202cac:	97b2                	add	a5,a5,a2
ffffffffc0202cae:	07b2                	slli	a5,a5,0xc
ffffffffc0202cb0:	30d7f963          	bgeu	a5,a3,ffffffffc0202fc2 <default_check+0x3f6>
ffffffffc0202cb4:	4505                	li	a0,1
ffffffffc0202cb6:	00043c03          	ld	s8,0(s0)
ffffffffc0202cba:	00843b83          	ld	s7,8(s0)
ffffffffc0202cbe:	01042b03          	lw	s6,16(s0)
ffffffffc0202cc2:	e400                	sd	s0,8(s0)
ffffffffc0202cc4:	e000                	sd	s0,0(s0)
ffffffffc0202cc6:	0000d797          	auipc	a5,0xd
ffffffffc0202cca:	4c07a923          	sw	zero,1234(a5) # ffffffffc0210198 <free_area+0x10>
ffffffffc0202cce:	efbfd0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202cd2:	2c051863          	bnez	a0,ffffffffc0202fa2 <default_check+0x3d6>
ffffffffc0202cd6:	4585                	li	a1,1
ffffffffc0202cd8:	8552                	mv	a0,s4
ffffffffc0202cda:	f81fd0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0202cde:	4585                	li	a1,1
ffffffffc0202ce0:	854e                	mv	a0,s3
ffffffffc0202ce2:	f79fd0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0202ce6:	4585                	li	a1,1
ffffffffc0202ce8:	8556                	mv	a0,s5
ffffffffc0202cea:	f71fd0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0202cee:	4818                	lw	a4,16(s0)
ffffffffc0202cf0:	478d                	li	a5,3
ffffffffc0202cf2:	28f71863          	bne	a4,a5,ffffffffc0202f82 <default_check+0x3b6>
ffffffffc0202cf6:	4505                	li	a0,1
ffffffffc0202cf8:	ed1fd0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202cfc:	89aa                	mv	s3,a0
ffffffffc0202cfe:	26050263          	beqz	a0,ffffffffc0202f62 <default_check+0x396>
ffffffffc0202d02:	4505                	li	a0,1
ffffffffc0202d04:	ec5fd0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202d08:	8aaa                	mv	s5,a0
ffffffffc0202d0a:	3a050c63          	beqz	a0,ffffffffc02030c2 <default_check+0x4f6>
ffffffffc0202d0e:	4505                	li	a0,1
ffffffffc0202d10:	eb9fd0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202d14:	8a2a                	mv	s4,a0
ffffffffc0202d16:	38050663          	beqz	a0,ffffffffc02030a2 <default_check+0x4d6>
ffffffffc0202d1a:	4505                	li	a0,1
ffffffffc0202d1c:	eadfd0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202d20:	36051163          	bnez	a0,ffffffffc0203082 <default_check+0x4b6>
ffffffffc0202d24:	4585                	li	a1,1
ffffffffc0202d26:	854e                	mv	a0,s3
ffffffffc0202d28:	f33fd0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0202d2c:	641c                	ld	a5,8(s0)
ffffffffc0202d2e:	20878a63          	beq	a5,s0,ffffffffc0202f42 <default_check+0x376>
ffffffffc0202d32:	4505                	li	a0,1
ffffffffc0202d34:	e95fd0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202d38:	30a99563          	bne	s3,a0,ffffffffc0203042 <default_check+0x476>
ffffffffc0202d3c:	4505                	li	a0,1
ffffffffc0202d3e:	e8bfd0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202d42:	2e051063          	bnez	a0,ffffffffc0203022 <default_check+0x456>
ffffffffc0202d46:	481c                	lw	a5,16(s0)
ffffffffc0202d48:	2a079d63          	bnez	a5,ffffffffc0203002 <default_check+0x436>
ffffffffc0202d4c:	854e                	mv	a0,s3
ffffffffc0202d4e:	4585                	li	a1,1
ffffffffc0202d50:	01843023          	sd	s8,0(s0)
ffffffffc0202d54:	01743423          	sd	s7,8(s0)
ffffffffc0202d58:	01642823          	sw	s6,16(s0)
ffffffffc0202d5c:	efffd0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0202d60:	4585                	li	a1,1
ffffffffc0202d62:	8556                	mv	a0,s5
ffffffffc0202d64:	ef7fd0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0202d68:	4585                	li	a1,1
ffffffffc0202d6a:	8552                	mv	a0,s4
ffffffffc0202d6c:	eeffd0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0202d70:	4515                	li	a0,5
ffffffffc0202d72:	e57fd0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202d76:	89aa                	mv	s3,a0
ffffffffc0202d78:	26050563          	beqz	a0,ffffffffc0202fe2 <default_check+0x416>
ffffffffc0202d7c:	651c                	ld	a5,8(a0)
ffffffffc0202d7e:	8385                	srli	a5,a5,0x1
ffffffffc0202d80:	8b85                	andi	a5,a5,1
ffffffffc0202d82:	54079063          	bnez	a5,ffffffffc02032c2 <default_check+0x6f6>
ffffffffc0202d86:	4505                	li	a0,1
ffffffffc0202d88:	00043b03          	ld	s6,0(s0)
ffffffffc0202d8c:	00843a83          	ld	s5,8(s0)
ffffffffc0202d90:	e000                	sd	s0,0(s0)
ffffffffc0202d92:	e400                	sd	s0,8(s0)
ffffffffc0202d94:	e35fd0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202d98:	50051563          	bnez	a0,ffffffffc02032a2 <default_check+0x6d6>
ffffffffc0202d9c:	09098a13          	addi	s4,s3,144
ffffffffc0202da0:	8552                	mv	a0,s4
ffffffffc0202da2:	458d                	li	a1,3
ffffffffc0202da4:	01042b83          	lw	s7,16(s0)
ffffffffc0202da8:	0000d797          	auipc	a5,0xd
ffffffffc0202dac:	3e07a823          	sw	zero,1008(a5) # ffffffffc0210198 <free_area+0x10>
ffffffffc0202db0:	eabfd0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0202db4:	4511                	li	a0,4
ffffffffc0202db6:	e13fd0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202dba:	4c051463          	bnez	a0,ffffffffc0203282 <default_check+0x6b6>
ffffffffc0202dbe:	0989b783          	ld	a5,152(s3)
ffffffffc0202dc2:	8385                	srli	a5,a5,0x1
ffffffffc0202dc4:	8b85                	andi	a5,a5,1
ffffffffc0202dc6:	48078e63          	beqz	a5,ffffffffc0203262 <default_check+0x696>
ffffffffc0202dca:	0a89a703          	lw	a4,168(s3)
ffffffffc0202dce:	478d                	li	a5,3
ffffffffc0202dd0:	48f71963          	bne	a4,a5,ffffffffc0203262 <default_check+0x696>
ffffffffc0202dd4:	450d                	li	a0,3
ffffffffc0202dd6:	df3fd0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202dda:	8c2a                	mv	s8,a0
ffffffffc0202ddc:	46050363          	beqz	a0,ffffffffc0203242 <default_check+0x676>
ffffffffc0202de0:	4505                	li	a0,1
ffffffffc0202de2:	de7fd0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202de6:	42051e63          	bnez	a0,ffffffffc0203222 <default_check+0x656>
ffffffffc0202dea:	418a1c63          	bne	s4,s8,ffffffffc0203202 <default_check+0x636>
ffffffffc0202dee:	4585                	li	a1,1
ffffffffc0202df0:	854e                	mv	a0,s3
ffffffffc0202df2:	e69fd0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0202df6:	458d                	li	a1,3
ffffffffc0202df8:	8552                	mv	a0,s4
ffffffffc0202dfa:	e61fd0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0202dfe:	0089b783          	ld	a5,8(s3)
ffffffffc0202e02:	04898c13          	addi	s8,s3,72
ffffffffc0202e06:	8385                	srli	a5,a5,0x1
ffffffffc0202e08:	8b85                	andi	a5,a5,1
ffffffffc0202e0a:	3c078c63          	beqz	a5,ffffffffc02031e2 <default_check+0x616>
ffffffffc0202e0e:	0189a703          	lw	a4,24(s3)
ffffffffc0202e12:	4785                	li	a5,1
ffffffffc0202e14:	3cf71763          	bne	a4,a5,ffffffffc02031e2 <default_check+0x616>
ffffffffc0202e18:	008a3783          	ld	a5,8(s4)
ffffffffc0202e1c:	8385                	srli	a5,a5,0x1
ffffffffc0202e1e:	8b85                	andi	a5,a5,1
ffffffffc0202e20:	3a078163          	beqz	a5,ffffffffc02031c2 <default_check+0x5f6>
ffffffffc0202e24:	018a2703          	lw	a4,24(s4)
ffffffffc0202e28:	478d                	li	a5,3
ffffffffc0202e2a:	38f71c63          	bne	a4,a5,ffffffffc02031c2 <default_check+0x5f6>
ffffffffc0202e2e:	4505                	li	a0,1
ffffffffc0202e30:	d99fd0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202e34:	36a99763          	bne	s3,a0,ffffffffc02031a2 <default_check+0x5d6>
ffffffffc0202e38:	4585                	li	a1,1
ffffffffc0202e3a:	e21fd0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0202e3e:	4509                	li	a0,2
ffffffffc0202e40:	d89fd0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202e44:	32aa1f63          	bne	s4,a0,ffffffffc0203182 <default_check+0x5b6>
ffffffffc0202e48:	4589                	li	a1,2
ffffffffc0202e4a:	e11fd0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0202e4e:	4585                	li	a1,1
ffffffffc0202e50:	8562                	mv	a0,s8
ffffffffc0202e52:	e09fd0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0202e56:	4515                	li	a0,5
ffffffffc0202e58:	d71fd0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202e5c:	89aa                	mv	s3,a0
ffffffffc0202e5e:	48050263          	beqz	a0,ffffffffc02032e2 <default_check+0x716>
ffffffffc0202e62:	4505                	li	a0,1
ffffffffc0202e64:	d65fd0ef          	jal	ra,ffffffffc0200bc8 <alloc_pages>
ffffffffc0202e68:	2c051d63          	bnez	a0,ffffffffc0203142 <default_check+0x576>
ffffffffc0202e6c:	481c                	lw	a5,16(s0)
ffffffffc0202e6e:	2a079a63          	bnez	a5,ffffffffc0203122 <default_check+0x556>
ffffffffc0202e72:	4595                	li	a1,5
ffffffffc0202e74:	854e                	mv	a0,s3
ffffffffc0202e76:	01742823          	sw	s7,16(s0)
ffffffffc0202e7a:	01643023          	sd	s6,0(s0)
ffffffffc0202e7e:	01543423          	sd	s5,8(s0)
ffffffffc0202e82:	dd9fd0ef          	jal	ra,ffffffffc0200c5a <free_pages>
ffffffffc0202e86:	641c                	ld	a5,8(s0)
ffffffffc0202e88:	00878963          	beq	a5,s0,ffffffffc0202e9a <default_check+0x2ce>
ffffffffc0202e8c:	ff87a703          	lw	a4,-8(a5)
ffffffffc0202e90:	679c                	ld	a5,8(a5)
ffffffffc0202e92:	397d                	addiw	s2,s2,-1
ffffffffc0202e94:	9c99                	subw	s1,s1,a4
ffffffffc0202e96:	fe879be3          	bne	a5,s0,ffffffffc0202e8c <default_check+0x2c0>
ffffffffc0202e9a:	26091463          	bnez	s2,ffffffffc0203102 <default_check+0x536>
ffffffffc0202e9e:	46049263          	bnez	s1,ffffffffc0203302 <default_check+0x736>
ffffffffc0202ea2:	60a6                	ld	ra,72(sp)
ffffffffc0202ea4:	6406                	ld	s0,64(sp)
ffffffffc0202ea6:	74e2                	ld	s1,56(sp)
ffffffffc0202ea8:	7942                	ld	s2,48(sp)
ffffffffc0202eaa:	79a2                	ld	s3,40(sp)
ffffffffc0202eac:	7a02                	ld	s4,32(sp)
ffffffffc0202eae:	6ae2                	ld	s5,24(sp)
ffffffffc0202eb0:	6b42                	ld	s6,16(sp)
ffffffffc0202eb2:	6ba2                	ld	s7,8(sp)
ffffffffc0202eb4:	6c02                	ld	s8,0(sp)
ffffffffc0202eb6:	6161                	addi	sp,sp,80
ffffffffc0202eb8:	8082                	ret
ffffffffc0202eba:	4981                	li	s3,0
ffffffffc0202ebc:	4481                	li	s1,0
ffffffffc0202ebe:	4901                	li	s2,0
ffffffffc0202ec0:	b3b9                	j	ffffffffc0202c0e <default_check+0x42>
ffffffffc0202ec2:	00002697          	auipc	a3,0x2
ffffffffc0202ec6:	08668693          	addi	a3,a3,134 # ffffffffc0204f48 <etext+0x12da>
ffffffffc0202eca:	00001617          	auipc	a2,0x1
ffffffffc0202ece:	4ee60613          	addi	a2,a2,1262 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202ed2:	0bd00593          	li	a1,189
ffffffffc0202ed6:	00002517          	auipc	a0,0x2
ffffffffc0202eda:	3b250513          	addi	a0,a0,946 # ffffffffc0205288 <etext+0x161a>
ffffffffc0202ede:	a0efd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202ee2:	00002697          	auipc	a3,0x2
ffffffffc0202ee6:	41e68693          	addi	a3,a3,1054 # ffffffffc0205300 <etext+0x1692>
ffffffffc0202eea:	00001617          	auipc	a2,0x1
ffffffffc0202eee:	4ce60613          	addi	a2,a2,1230 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202ef2:	08a00593          	li	a1,138
ffffffffc0202ef6:	00002517          	auipc	a0,0x2
ffffffffc0202efa:	39250513          	addi	a0,a0,914 # ffffffffc0205288 <etext+0x161a>
ffffffffc0202efe:	9eefd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202f02:	00002697          	auipc	a3,0x2
ffffffffc0202f06:	42668693          	addi	a3,a3,1062 # ffffffffc0205328 <etext+0x16ba>
ffffffffc0202f0a:	00001617          	auipc	a2,0x1
ffffffffc0202f0e:	4ae60613          	addi	a2,a2,1198 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202f12:	08b00593          	li	a1,139
ffffffffc0202f16:	00002517          	auipc	a0,0x2
ffffffffc0202f1a:	37250513          	addi	a0,a0,882 # ffffffffc0205288 <etext+0x161a>
ffffffffc0202f1e:	9cefd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202f22:	00002697          	auipc	a3,0x2
ffffffffc0202f26:	44668693          	addi	a3,a3,1094 # ffffffffc0205368 <etext+0x16fa>
ffffffffc0202f2a:	00001617          	auipc	a2,0x1
ffffffffc0202f2e:	48e60613          	addi	a2,a2,1166 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202f32:	08d00593          	li	a1,141
ffffffffc0202f36:	00002517          	auipc	a0,0x2
ffffffffc0202f3a:	35250513          	addi	a0,a0,850 # ffffffffc0205288 <etext+0x161a>
ffffffffc0202f3e:	9aefd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202f42:	00002697          	auipc	a3,0x2
ffffffffc0202f46:	4ae68693          	addi	a3,a3,1198 # ffffffffc02053f0 <etext+0x1782>
ffffffffc0202f4a:	00001617          	auipc	a2,0x1
ffffffffc0202f4e:	46e60613          	addi	a2,a2,1134 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202f52:	0a600593          	li	a1,166
ffffffffc0202f56:	00002517          	auipc	a0,0x2
ffffffffc0202f5a:	33250513          	addi	a0,a0,818 # ffffffffc0205288 <etext+0x161a>
ffffffffc0202f5e:	98efd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202f62:	00002697          	auipc	a3,0x2
ffffffffc0202f66:	33e68693          	addi	a3,a3,830 # ffffffffc02052a0 <etext+0x1632>
ffffffffc0202f6a:	00001617          	auipc	a2,0x1
ffffffffc0202f6e:	44e60613          	addi	a2,a2,1102 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202f72:	09f00593          	li	a1,159
ffffffffc0202f76:	00002517          	auipc	a0,0x2
ffffffffc0202f7a:	31250513          	addi	a0,a0,786 # ffffffffc0205288 <etext+0x161a>
ffffffffc0202f7e:	96efd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202f82:	00002697          	auipc	a3,0x2
ffffffffc0202f86:	45e68693          	addi	a3,a3,1118 # ffffffffc02053e0 <etext+0x1772>
ffffffffc0202f8a:	00001617          	auipc	a2,0x1
ffffffffc0202f8e:	42e60613          	addi	a2,a2,1070 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202f92:	09d00593          	li	a1,157
ffffffffc0202f96:	00002517          	auipc	a0,0x2
ffffffffc0202f9a:	2f250513          	addi	a0,a0,754 # ffffffffc0205288 <etext+0x161a>
ffffffffc0202f9e:	94efd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202fa2:	00002697          	auipc	a3,0x2
ffffffffc0202fa6:	42668693          	addi	a3,a3,1062 # ffffffffc02053c8 <etext+0x175a>
ffffffffc0202faa:	00001617          	auipc	a2,0x1
ffffffffc0202fae:	40e60613          	addi	a2,a2,1038 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202fb2:	09800593          	li	a1,152
ffffffffc0202fb6:	00002517          	auipc	a0,0x2
ffffffffc0202fba:	2d250513          	addi	a0,a0,722 # ffffffffc0205288 <etext+0x161a>
ffffffffc0202fbe:	92efd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202fc2:	00002697          	auipc	a3,0x2
ffffffffc0202fc6:	3e668693          	addi	a3,a3,998 # ffffffffc02053a8 <etext+0x173a>
ffffffffc0202fca:	00001617          	auipc	a2,0x1
ffffffffc0202fce:	3ee60613          	addi	a2,a2,1006 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202fd2:	08f00593          	li	a1,143
ffffffffc0202fd6:	00002517          	auipc	a0,0x2
ffffffffc0202fda:	2b250513          	addi	a0,a0,690 # ffffffffc0205288 <etext+0x161a>
ffffffffc0202fde:	90efd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202fe2:	00002697          	auipc	a3,0x2
ffffffffc0202fe6:	44668693          	addi	a3,a3,1094 # ffffffffc0205428 <etext+0x17ba>
ffffffffc0202fea:	00001617          	auipc	a2,0x1
ffffffffc0202fee:	3ce60613          	addi	a2,a2,974 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0202ff2:	0c500593          	li	a1,197
ffffffffc0202ff6:	00002517          	auipc	a0,0x2
ffffffffc0202ffa:	29250513          	addi	a0,a0,658 # ffffffffc0205288 <etext+0x161a>
ffffffffc0202ffe:	8eefd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203002:	00002697          	auipc	a3,0x2
ffffffffc0203006:	0f668693          	addi	a3,a3,246 # ffffffffc02050f8 <etext+0x148a>
ffffffffc020300a:	00001617          	auipc	a2,0x1
ffffffffc020300e:	3ae60613          	addi	a2,a2,942 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203012:	0ac00593          	li	a1,172
ffffffffc0203016:	00002517          	auipc	a0,0x2
ffffffffc020301a:	27250513          	addi	a0,a0,626 # ffffffffc0205288 <etext+0x161a>
ffffffffc020301e:	8cefd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203022:	00002697          	auipc	a3,0x2
ffffffffc0203026:	3a668693          	addi	a3,a3,934 # ffffffffc02053c8 <etext+0x175a>
ffffffffc020302a:	00001617          	auipc	a2,0x1
ffffffffc020302e:	38e60613          	addi	a2,a2,910 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203032:	0aa00593          	li	a1,170
ffffffffc0203036:	00002517          	auipc	a0,0x2
ffffffffc020303a:	25250513          	addi	a0,a0,594 # ffffffffc0205288 <etext+0x161a>
ffffffffc020303e:	8aefd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203042:	00002697          	auipc	a3,0x2
ffffffffc0203046:	3c668693          	addi	a3,a3,966 # ffffffffc0205408 <etext+0x179a>
ffffffffc020304a:	00001617          	auipc	a2,0x1
ffffffffc020304e:	36e60613          	addi	a2,a2,878 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203052:	0a900593          	li	a1,169
ffffffffc0203056:	00002517          	auipc	a0,0x2
ffffffffc020305a:	23250513          	addi	a0,a0,562 # ffffffffc0205288 <etext+0x161a>
ffffffffc020305e:	88efd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203062:	00002697          	auipc	a3,0x2
ffffffffc0203066:	23e68693          	addi	a3,a3,574 # ffffffffc02052a0 <etext+0x1632>
ffffffffc020306a:	00001617          	auipc	a2,0x1
ffffffffc020306e:	34e60613          	addi	a2,a2,846 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203072:	08600593          	li	a1,134
ffffffffc0203076:	00002517          	auipc	a0,0x2
ffffffffc020307a:	21250513          	addi	a0,a0,530 # ffffffffc0205288 <etext+0x161a>
ffffffffc020307e:	86efd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203082:	00002697          	auipc	a3,0x2
ffffffffc0203086:	34668693          	addi	a3,a3,838 # ffffffffc02053c8 <etext+0x175a>
ffffffffc020308a:	00001617          	auipc	a2,0x1
ffffffffc020308e:	32e60613          	addi	a2,a2,814 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203092:	0a300593          	li	a1,163
ffffffffc0203096:	00002517          	auipc	a0,0x2
ffffffffc020309a:	1f250513          	addi	a0,a0,498 # ffffffffc0205288 <etext+0x161a>
ffffffffc020309e:	84efd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02030a2:	00002697          	auipc	a3,0x2
ffffffffc02030a6:	23e68693          	addi	a3,a3,574 # ffffffffc02052e0 <etext+0x1672>
ffffffffc02030aa:	00001617          	auipc	a2,0x1
ffffffffc02030ae:	30e60613          	addi	a2,a2,782 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02030b2:	0a100593          	li	a1,161
ffffffffc02030b6:	00002517          	auipc	a0,0x2
ffffffffc02030ba:	1d250513          	addi	a0,a0,466 # ffffffffc0205288 <etext+0x161a>
ffffffffc02030be:	82efd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02030c2:	00002697          	auipc	a3,0x2
ffffffffc02030c6:	1fe68693          	addi	a3,a3,510 # ffffffffc02052c0 <etext+0x1652>
ffffffffc02030ca:	00001617          	auipc	a2,0x1
ffffffffc02030ce:	2ee60613          	addi	a2,a2,750 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02030d2:	0a000593          	li	a1,160
ffffffffc02030d6:	00002517          	auipc	a0,0x2
ffffffffc02030da:	1b250513          	addi	a0,a0,434 # ffffffffc0205288 <etext+0x161a>
ffffffffc02030de:	80efd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02030e2:	00002697          	auipc	a3,0x2
ffffffffc02030e6:	1fe68693          	addi	a3,a3,510 # ffffffffc02052e0 <etext+0x1672>
ffffffffc02030ea:	00001617          	auipc	a2,0x1
ffffffffc02030ee:	2ce60613          	addi	a2,a2,718 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02030f2:	08800593          	li	a1,136
ffffffffc02030f6:	00002517          	auipc	a0,0x2
ffffffffc02030fa:	19250513          	addi	a0,a0,402 # ffffffffc0205288 <etext+0x161a>
ffffffffc02030fe:	feffc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203102:	00002697          	auipc	a3,0x2
ffffffffc0203106:	47668693          	addi	a3,a3,1142 # ffffffffc0205578 <etext+0x190a>
ffffffffc020310a:	00001617          	auipc	a2,0x1
ffffffffc020310e:	2ae60613          	addi	a2,a2,686 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203112:	0f200593          	li	a1,242
ffffffffc0203116:	00002517          	auipc	a0,0x2
ffffffffc020311a:	17250513          	addi	a0,a0,370 # ffffffffc0205288 <etext+0x161a>
ffffffffc020311e:	fcffc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203122:	00002697          	auipc	a3,0x2
ffffffffc0203126:	fd668693          	addi	a3,a3,-42 # ffffffffc02050f8 <etext+0x148a>
ffffffffc020312a:	00001617          	auipc	a2,0x1
ffffffffc020312e:	28e60613          	addi	a2,a2,654 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203132:	0e700593          	li	a1,231
ffffffffc0203136:	00002517          	auipc	a0,0x2
ffffffffc020313a:	15250513          	addi	a0,a0,338 # ffffffffc0205288 <etext+0x161a>
ffffffffc020313e:	faffc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203142:	00002697          	auipc	a3,0x2
ffffffffc0203146:	28668693          	addi	a3,a3,646 # ffffffffc02053c8 <etext+0x175a>
ffffffffc020314a:	00001617          	auipc	a2,0x1
ffffffffc020314e:	26e60613          	addi	a2,a2,622 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203152:	0e500593          	li	a1,229
ffffffffc0203156:	00002517          	auipc	a0,0x2
ffffffffc020315a:	13250513          	addi	a0,a0,306 # ffffffffc0205288 <etext+0x161a>
ffffffffc020315e:	f8ffc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203162:	00002697          	auipc	a3,0x2
ffffffffc0203166:	22668693          	addi	a3,a3,550 # ffffffffc0205388 <etext+0x171a>
ffffffffc020316a:	00001617          	auipc	a2,0x1
ffffffffc020316e:	24e60613          	addi	a2,a2,590 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203172:	08e00593          	li	a1,142
ffffffffc0203176:	00002517          	auipc	a0,0x2
ffffffffc020317a:	11250513          	addi	a0,a0,274 # ffffffffc0205288 <etext+0x161a>
ffffffffc020317e:	f6ffc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203182:	00002697          	auipc	a3,0x2
ffffffffc0203186:	3b668693          	addi	a3,a3,950 # ffffffffc0205538 <etext+0x18ca>
ffffffffc020318a:	00001617          	auipc	a2,0x1
ffffffffc020318e:	22e60613          	addi	a2,a2,558 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203192:	0df00593          	li	a1,223
ffffffffc0203196:	00002517          	auipc	a0,0x2
ffffffffc020319a:	0f250513          	addi	a0,a0,242 # ffffffffc0205288 <etext+0x161a>
ffffffffc020319e:	f4ffc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02031a2:	00002697          	auipc	a3,0x2
ffffffffc02031a6:	37668693          	addi	a3,a3,886 # ffffffffc0205518 <etext+0x18aa>
ffffffffc02031aa:	00001617          	auipc	a2,0x1
ffffffffc02031ae:	20e60613          	addi	a2,a2,526 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02031b2:	0dd00593          	li	a1,221
ffffffffc02031b6:	00002517          	auipc	a0,0x2
ffffffffc02031ba:	0d250513          	addi	a0,a0,210 # ffffffffc0205288 <etext+0x161a>
ffffffffc02031be:	f2ffc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02031c2:	00002697          	auipc	a3,0x2
ffffffffc02031c6:	32e68693          	addi	a3,a3,814 # ffffffffc02054f0 <etext+0x1882>
ffffffffc02031ca:	00001617          	auipc	a2,0x1
ffffffffc02031ce:	1ee60613          	addi	a2,a2,494 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02031d2:	0db00593          	li	a1,219
ffffffffc02031d6:	00002517          	auipc	a0,0x2
ffffffffc02031da:	0b250513          	addi	a0,a0,178 # ffffffffc0205288 <etext+0x161a>
ffffffffc02031de:	f0ffc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02031e2:	00002697          	auipc	a3,0x2
ffffffffc02031e6:	2e668693          	addi	a3,a3,742 # ffffffffc02054c8 <etext+0x185a>
ffffffffc02031ea:	00001617          	auipc	a2,0x1
ffffffffc02031ee:	1ce60613          	addi	a2,a2,462 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02031f2:	0da00593          	li	a1,218
ffffffffc02031f6:	00002517          	auipc	a0,0x2
ffffffffc02031fa:	09250513          	addi	a0,a0,146 # ffffffffc0205288 <etext+0x161a>
ffffffffc02031fe:	eeffc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203202:	00002697          	auipc	a3,0x2
ffffffffc0203206:	2b668693          	addi	a3,a3,694 # ffffffffc02054b8 <etext+0x184a>
ffffffffc020320a:	00001617          	auipc	a2,0x1
ffffffffc020320e:	1ae60613          	addi	a2,a2,430 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203212:	0d500593          	li	a1,213
ffffffffc0203216:	00002517          	auipc	a0,0x2
ffffffffc020321a:	07250513          	addi	a0,a0,114 # ffffffffc0205288 <etext+0x161a>
ffffffffc020321e:	ecffc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203222:	00002697          	auipc	a3,0x2
ffffffffc0203226:	1a668693          	addi	a3,a3,422 # ffffffffc02053c8 <etext+0x175a>
ffffffffc020322a:	00001617          	auipc	a2,0x1
ffffffffc020322e:	18e60613          	addi	a2,a2,398 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203232:	0d400593          	li	a1,212
ffffffffc0203236:	00002517          	auipc	a0,0x2
ffffffffc020323a:	05250513          	addi	a0,a0,82 # ffffffffc0205288 <etext+0x161a>
ffffffffc020323e:	eaffc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203242:	00002697          	auipc	a3,0x2
ffffffffc0203246:	25668693          	addi	a3,a3,598 # ffffffffc0205498 <etext+0x182a>
ffffffffc020324a:	00001617          	auipc	a2,0x1
ffffffffc020324e:	16e60613          	addi	a2,a2,366 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203252:	0d300593          	li	a1,211
ffffffffc0203256:	00002517          	auipc	a0,0x2
ffffffffc020325a:	03250513          	addi	a0,a0,50 # ffffffffc0205288 <etext+0x161a>
ffffffffc020325e:	e8ffc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203262:	00002697          	auipc	a3,0x2
ffffffffc0203266:	20668693          	addi	a3,a3,518 # ffffffffc0205468 <etext+0x17fa>
ffffffffc020326a:	00001617          	auipc	a2,0x1
ffffffffc020326e:	14e60613          	addi	a2,a2,334 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203272:	0d200593          	li	a1,210
ffffffffc0203276:	00002517          	auipc	a0,0x2
ffffffffc020327a:	01250513          	addi	a0,a0,18 # ffffffffc0205288 <etext+0x161a>
ffffffffc020327e:	e6ffc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203282:	00002697          	auipc	a3,0x2
ffffffffc0203286:	1ce68693          	addi	a3,a3,462 # ffffffffc0205450 <etext+0x17e2>
ffffffffc020328a:	00001617          	auipc	a2,0x1
ffffffffc020328e:	12e60613          	addi	a2,a2,302 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203292:	0d100593          	li	a1,209
ffffffffc0203296:	00002517          	auipc	a0,0x2
ffffffffc020329a:	ff250513          	addi	a0,a0,-14 # ffffffffc0205288 <etext+0x161a>
ffffffffc020329e:	e4ffc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02032a2:	00002697          	auipc	a3,0x2
ffffffffc02032a6:	12668693          	addi	a3,a3,294 # ffffffffc02053c8 <etext+0x175a>
ffffffffc02032aa:	00001617          	auipc	a2,0x1
ffffffffc02032ae:	10e60613          	addi	a2,a2,270 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02032b2:	0cb00593          	li	a1,203
ffffffffc02032b6:	00002517          	auipc	a0,0x2
ffffffffc02032ba:	fd250513          	addi	a0,a0,-46 # ffffffffc0205288 <etext+0x161a>
ffffffffc02032be:	e2ffc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02032c2:	00002697          	auipc	a3,0x2
ffffffffc02032c6:	17668693          	addi	a3,a3,374 # ffffffffc0205438 <etext+0x17ca>
ffffffffc02032ca:	00001617          	auipc	a2,0x1
ffffffffc02032ce:	0ee60613          	addi	a2,a2,238 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02032d2:	0c600593          	li	a1,198
ffffffffc02032d6:	00002517          	auipc	a0,0x2
ffffffffc02032da:	fb250513          	addi	a0,a0,-78 # ffffffffc0205288 <etext+0x161a>
ffffffffc02032de:	e0ffc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02032e2:	00002697          	auipc	a3,0x2
ffffffffc02032e6:	27668693          	addi	a3,a3,630 # ffffffffc0205558 <etext+0x18ea>
ffffffffc02032ea:	00001617          	auipc	a2,0x1
ffffffffc02032ee:	0ce60613          	addi	a2,a2,206 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02032f2:	0e400593          	li	a1,228
ffffffffc02032f6:	00002517          	auipc	a0,0x2
ffffffffc02032fa:	f9250513          	addi	a0,a0,-110 # ffffffffc0205288 <etext+0x161a>
ffffffffc02032fe:	deffc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203302:	00002697          	auipc	a3,0x2
ffffffffc0203306:	28668693          	addi	a3,a3,646 # ffffffffc0205588 <etext+0x191a>
ffffffffc020330a:	00001617          	auipc	a2,0x1
ffffffffc020330e:	0ae60613          	addi	a2,a2,174 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203312:	0f300593          	li	a1,243
ffffffffc0203316:	00002517          	auipc	a0,0x2
ffffffffc020331a:	f7250513          	addi	a0,a0,-142 # ffffffffc0205288 <etext+0x161a>
ffffffffc020331e:	dcffc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203322:	00002697          	auipc	a3,0x2
ffffffffc0203326:	c3668693          	addi	a3,a3,-970 # ffffffffc0204f58 <etext+0x12ea>
ffffffffc020332a:	00001617          	auipc	a2,0x1
ffffffffc020332e:	08e60613          	addi	a2,a2,142 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203332:	0c000593          	li	a1,192
ffffffffc0203336:	00002517          	auipc	a0,0x2
ffffffffc020333a:	f5250513          	addi	a0,a0,-174 # ffffffffc0205288 <etext+0x161a>
ffffffffc020333e:	daffc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203342:	00002697          	auipc	a3,0x2
ffffffffc0203346:	f7e68693          	addi	a3,a3,-130 # ffffffffc02052c0 <etext+0x1652>
ffffffffc020334a:	00001617          	auipc	a2,0x1
ffffffffc020334e:	06e60613          	addi	a2,a2,110 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203352:	08700593          	li	a1,135
ffffffffc0203356:	00002517          	auipc	a0,0x2
ffffffffc020335a:	f3250513          	addi	a0,a0,-206 # ffffffffc0205288 <etext+0x161a>
ffffffffc020335e:	d8ffc0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0203362 <default_free_pages>:
ffffffffc0203362:	1141                	addi	sp,sp,-16
ffffffffc0203364:	e406                	sd	ra,8(sp)
ffffffffc0203366:	14058a63          	beqz	a1,ffffffffc02034ba <default_free_pages+0x158>
ffffffffc020336a:	00359693          	slli	a3,a1,0x3
ffffffffc020336e:	96ae                	add	a3,a3,a1
ffffffffc0203370:	068e                	slli	a3,a3,0x3
ffffffffc0203372:	96aa                	add	a3,a3,a0
ffffffffc0203374:	87aa                	mv	a5,a0
ffffffffc0203376:	02d50263          	beq	a0,a3,ffffffffc020339a <default_free_pages+0x38>
ffffffffc020337a:	6798                	ld	a4,8(a5)
ffffffffc020337c:	8b05                	andi	a4,a4,1
ffffffffc020337e:	10071e63          	bnez	a4,ffffffffc020349a <default_free_pages+0x138>
ffffffffc0203382:	6798                	ld	a4,8(a5)
ffffffffc0203384:	8b09                	andi	a4,a4,2
ffffffffc0203386:	10071a63          	bnez	a4,ffffffffc020349a <default_free_pages+0x138>
ffffffffc020338a:	0007b423          	sd	zero,8(a5)
ffffffffc020338e:	0007a023          	sw	zero,0(a5)
ffffffffc0203392:	04878793          	addi	a5,a5,72
ffffffffc0203396:	fed792e3          	bne	a5,a3,ffffffffc020337a <default_free_pages+0x18>
ffffffffc020339a:	2581                	sext.w	a1,a1
ffffffffc020339c:	cd0c                	sw	a1,24(a0)
ffffffffc020339e:	00850893          	addi	a7,a0,8
ffffffffc02033a2:	4789                	li	a5,2
ffffffffc02033a4:	40f8b02f          	amoor.d	zero,a5,(a7)
ffffffffc02033a8:	0000d697          	auipc	a3,0xd
ffffffffc02033ac:	de068693          	addi	a3,a3,-544 # ffffffffc0210188 <free_area>
ffffffffc02033b0:	4a98                	lw	a4,16(a3)
ffffffffc02033b2:	669c                	ld	a5,8(a3)
ffffffffc02033b4:	02050613          	addi	a2,a0,32
ffffffffc02033b8:	9db9                	addw	a1,a1,a4
ffffffffc02033ba:	ca8c                	sw	a1,16(a3)
ffffffffc02033bc:	0ad78863          	beq	a5,a3,ffffffffc020346c <default_free_pages+0x10a>
ffffffffc02033c0:	fe078713          	addi	a4,a5,-32
ffffffffc02033c4:	0006b803          	ld	a6,0(a3)
ffffffffc02033c8:	4581                	li	a1,0
ffffffffc02033ca:	00e56a63          	bltu	a0,a4,ffffffffc02033de <default_free_pages+0x7c>
ffffffffc02033ce:	6798                	ld	a4,8(a5)
ffffffffc02033d0:	06d70263          	beq	a4,a3,ffffffffc0203434 <default_free_pages+0xd2>
ffffffffc02033d4:	87ba                	mv	a5,a4
ffffffffc02033d6:	fe078713          	addi	a4,a5,-32
ffffffffc02033da:	fee57ae3          	bgeu	a0,a4,ffffffffc02033ce <default_free_pages+0x6c>
ffffffffc02033de:	c199                	beqz	a1,ffffffffc02033e4 <default_free_pages+0x82>
ffffffffc02033e0:	0106b023          	sd	a6,0(a3)
ffffffffc02033e4:	6398                	ld	a4,0(a5)
ffffffffc02033e6:	e390                	sd	a2,0(a5)
ffffffffc02033e8:	e710                	sd	a2,8(a4)
ffffffffc02033ea:	f51c                	sd	a5,40(a0)
ffffffffc02033ec:	f118                	sd	a4,32(a0)
ffffffffc02033ee:	02d70063          	beq	a4,a3,ffffffffc020340e <default_free_pages+0xac>
ffffffffc02033f2:	ff872803          	lw	a6,-8(a4)
ffffffffc02033f6:	fe070593          	addi	a1,a4,-32
ffffffffc02033fa:	02081613          	slli	a2,a6,0x20
ffffffffc02033fe:	9201                	srli	a2,a2,0x20
ffffffffc0203400:	00361793          	slli	a5,a2,0x3
ffffffffc0203404:	97b2                	add	a5,a5,a2
ffffffffc0203406:	078e                	slli	a5,a5,0x3
ffffffffc0203408:	97ae                	add	a5,a5,a1
ffffffffc020340a:	02f50f63          	beq	a0,a5,ffffffffc0203448 <default_free_pages+0xe6>
ffffffffc020340e:	7518                	ld	a4,40(a0)
ffffffffc0203410:	00d70f63          	beq	a4,a3,ffffffffc020342e <default_free_pages+0xcc>
ffffffffc0203414:	4d0c                	lw	a1,24(a0)
ffffffffc0203416:	fe070693          	addi	a3,a4,-32
ffffffffc020341a:	02059613          	slli	a2,a1,0x20
ffffffffc020341e:	9201                	srli	a2,a2,0x20
ffffffffc0203420:	00361793          	slli	a5,a2,0x3
ffffffffc0203424:	97b2                	add	a5,a5,a2
ffffffffc0203426:	078e                	slli	a5,a5,0x3
ffffffffc0203428:	97aa                	add	a5,a5,a0
ffffffffc020342a:	04f68863          	beq	a3,a5,ffffffffc020347a <default_free_pages+0x118>
ffffffffc020342e:	60a2                	ld	ra,8(sp)
ffffffffc0203430:	0141                	addi	sp,sp,16
ffffffffc0203432:	8082                	ret
ffffffffc0203434:	e790                	sd	a2,8(a5)
ffffffffc0203436:	f514                	sd	a3,40(a0)
ffffffffc0203438:	6798                	ld	a4,8(a5)
ffffffffc020343a:	f11c                	sd	a5,32(a0)
ffffffffc020343c:	02d70563          	beq	a4,a3,ffffffffc0203466 <default_free_pages+0x104>
ffffffffc0203440:	8832                	mv	a6,a2
ffffffffc0203442:	4585                	li	a1,1
ffffffffc0203444:	87ba                	mv	a5,a4
ffffffffc0203446:	bf41                	j	ffffffffc02033d6 <default_free_pages+0x74>
ffffffffc0203448:	4d1c                	lw	a5,24(a0)
ffffffffc020344a:	0107883b          	addw	a6,a5,a6
ffffffffc020344e:	ff072c23          	sw	a6,-8(a4)
ffffffffc0203452:	57f5                	li	a5,-3
ffffffffc0203454:	60f8b02f          	amoand.d	zero,a5,(a7)
ffffffffc0203458:	7110                	ld	a2,32(a0)
ffffffffc020345a:	751c                	ld	a5,40(a0)
ffffffffc020345c:	852e                	mv	a0,a1
ffffffffc020345e:	e61c                	sd	a5,8(a2)
ffffffffc0203460:	6718                	ld	a4,8(a4)
ffffffffc0203462:	e390                	sd	a2,0(a5)
ffffffffc0203464:	b775                	j	ffffffffc0203410 <default_free_pages+0xae>
ffffffffc0203466:	e290                	sd	a2,0(a3)
ffffffffc0203468:	873e                	mv	a4,a5
ffffffffc020346a:	b761                	j	ffffffffc02033f2 <default_free_pages+0x90>
ffffffffc020346c:	60a2                	ld	ra,8(sp)
ffffffffc020346e:	e390                	sd	a2,0(a5)
ffffffffc0203470:	e790                	sd	a2,8(a5)
ffffffffc0203472:	f51c                	sd	a5,40(a0)
ffffffffc0203474:	f11c                	sd	a5,32(a0)
ffffffffc0203476:	0141                	addi	sp,sp,16
ffffffffc0203478:	8082                	ret
ffffffffc020347a:	ff872783          	lw	a5,-8(a4)
ffffffffc020347e:	fe870693          	addi	a3,a4,-24
ffffffffc0203482:	9dbd                	addw	a1,a1,a5
ffffffffc0203484:	cd0c                	sw	a1,24(a0)
ffffffffc0203486:	57f5                	li	a5,-3
ffffffffc0203488:	60f6b02f          	amoand.d	zero,a5,(a3)
ffffffffc020348c:	6314                	ld	a3,0(a4)
ffffffffc020348e:	671c                	ld	a5,8(a4)
ffffffffc0203490:	60a2                	ld	ra,8(sp)
ffffffffc0203492:	e69c                	sd	a5,8(a3)
ffffffffc0203494:	e394                	sd	a3,0(a5)
ffffffffc0203496:	0141                	addi	sp,sp,16
ffffffffc0203498:	8082                	ret
ffffffffc020349a:	00002697          	auipc	a3,0x2
ffffffffc020349e:	10668693          	addi	a3,a3,262 # ffffffffc02055a0 <etext+0x1932>
ffffffffc02034a2:	00001617          	auipc	a2,0x1
ffffffffc02034a6:	f1660613          	addi	a2,a2,-234 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02034aa:	05000593          	li	a1,80
ffffffffc02034ae:	00002517          	auipc	a0,0x2
ffffffffc02034b2:	dda50513          	addi	a0,a0,-550 # ffffffffc0205288 <etext+0x161a>
ffffffffc02034b6:	c37fc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02034ba:	00002697          	auipc	a3,0x2
ffffffffc02034be:	0de68693          	addi	a3,a3,222 # ffffffffc0205598 <etext+0x192a>
ffffffffc02034c2:	00001617          	auipc	a2,0x1
ffffffffc02034c6:	ef660613          	addi	a2,a2,-266 # ffffffffc02043b8 <etext+0x74a>
ffffffffc02034ca:	04d00593          	li	a1,77
ffffffffc02034ce:	00002517          	auipc	a0,0x2
ffffffffc02034d2:	dba50513          	addi	a0,a0,-582 # ffffffffc0205288 <etext+0x161a>
ffffffffc02034d6:	c17fc0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc02034da <default_alloc_pages>:
ffffffffc02034da:	c959                	beqz	a0,ffffffffc0203570 <default_alloc_pages+0x96>
ffffffffc02034dc:	0000d597          	auipc	a1,0xd
ffffffffc02034e0:	cac58593          	addi	a1,a1,-852 # ffffffffc0210188 <free_area>
ffffffffc02034e4:	0105a803          	lw	a6,16(a1)
ffffffffc02034e8:	862a                	mv	a2,a0
ffffffffc02034ea:	02081793          	slli	a5,a6,0x20
ffffffffc02034ee:	9381                	srli	a5,a5,0x20
ffffffffc02034f0:	00a7ee63          	bltu	a5,a0,ffffffffc020350c <default_alloc_pages+0x32>
ffffffffc02034f4:	87ae                	mv	a5,a1
ffffffffc02034f6:	a801                	j	ffffffffc0203506 <default_alloc_pages+0x2c>
ffffffffc02034f8:	ff87a703          	lw	a4,-8(a5)
ffffffffc02034fc:	02071693          	slli	a3,a4,0x20
ffffffffc0203500:	9281                	srli	a3,a3,0x20
ffffffffc0203502:	00c6f763          	bgeu	a3,a2,ffffffffc0203510 <default_alloc_pages+0x36>
ffffffffc0203506:	679c                	ld	a5,8(a5)
ffffffffc0203508:	feb798e3          	bne	a5,a1,ffffffffc02034f8 <default_alloc_pages+0x1e>
ffffffffc020350c:	4501                	li	a0,0
ffffffffc020350e:	8082                	ret
ffffffffc0203510:	0007b883          	ld	a7,0(a5)
ffffffffc0203514:	0087b303          	ld	t1,8(a5)
ffffffffc0203518:	fe078513          	addi	a0,a5,-32
ffffffffc020351c:	00060e1b          	sext.w	t3,a2
ffffffffc0203520:	0068b423          	sd	t1,8(a7)
ffffffffc0203524:	01133023          	sd	a7,0(t1)
ffffffffc0203528:	02d67b63          	bgeu	a2,a3,ffffffffc020355e <default_alloc_pages+0x84>
ffffffffc020352c:	00361693          	slli	a3,a2,0x3
ffffffffc0203530:	96b2                	add	a3,a3,a2
ffffffffc0203532:	068e                	slli	a3,a3,0x3
ffffffffc0203534:	96aa                	add	a3,a3,a0
ffffffffc0203536:	41c7073b          	subw	a4,a4,t3
ffffffffc020353a:	ce98                	sw	a4,24(a3)
ffffffffc020353c:	00868613          	addi	a2,a3,8
ffffffffc0203540:	4709                	li	a4,2
ffffffffc0203542:	40e6302f          	amoor.d	zero,a4,(a2)
ffffffffc0203546:	0088b703          	ld	a4,8(a7)
ffffffffc020354a:	02068613          	addi	a2,a3,32
ffffffffc020354e:	0105a803          	lw	a6,16(a1)
ffffffffc0203552:	e310                	sd	a2,0(a4)
ffffffffc0203554:	00c8b423          	sd	a2,8(a7)
ffffffffc0203558:	f698                	sd	a4,40(a3)
ffffffffc020355a:	0316b023          	sd	a7,32(a3)
ffffffffc020355e:	41c8083b          	subw	a6,a6,t3
ffffffffc0203562:	0105a823          	sw	a6,16(a1)
ffffffffc0203566:	5775                	li	a4,-3
ffffffffc0203568:	17a1                	addi	a5,a5,-24
ffffffffc020356a:	60e7b02f          	amoand.d	zero,a4,(a5)
ffffffffc020356e:	8082                	ret
ffffffffc0203570:	1141                	addi	sp,sp,-16
ffffffffc0203572:	00002697          	auipc	a3,0x2
ffffffffc0203576:	02668693          	addi	a3,a3,38 # ffffffffc0205598 <etext+0x192a>
ffffffffc020357a:	00001617          	auipc	a2,0x1
ffffffffc020357e:	e3e60613          	addi	a2,a2,-450 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203582:	02f00593          	li	a1,47
ffffffffc0203586:	00002517          	auipc	a0,0x2
ffffffffc020358a:	d0250513          	addi	a0,a0,-766 # ffffffffc0205288 <etext+0x161a>
ffffffffc020358e:	e406                	sd	ra,8(sp)
ffffffffc0203590:	b5dfc0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0203594 <default_init_memmap>:
ffffffffc0203594:	1141                	addi	sp,sp,-16
ffffffffc0203596:	e406                	sd	ra,8(sp)
ffffffffc0203598:	c5f9                	beqz	a1,ffffffffc0203666 <default_init_memmap+0xd2>
ffffffffc020359a:	00359693          	slli	a3,a1,0x3
ffffffffc020359e:	96ae                	add	a3,a3,a1
ffffffffc02035a0:	068e                	slli	a3,a3,0x3
ffffffffc02035a2:	96aa                	add	a3,a3,a0
ffffffffc02035a4:	87aa                	mv	a5,a0
ffffffffc02035a6:	00d50f63          	beq	a0,a3,ffffffffc02035c4 <default_init_memmap+0x30>
ffffffffc02035aa:	6798                	ld	a4,8(a5)
ffffffffc02035ac:	8b05                	andi	a4,a4,1
ffffffffc02035ae:	cf49                	beqz	a4,ffffffffc0203648 <default_init_memmap+0xb4>
ffffffffc02035b0:	0007ac23          	sw	zero,24(a5)
ffffffffc02035b4:	0007b423          	sd	zero,8(a5)
ffffffffc02035b8:	0007a023          	sw	zero,0(a5)
ffffffffc02035bc:	04878793          	addi	a5,a5,72
ffffffffc02035c0:	fed795e3          	bne	a5,a3,ffffffffc02035aa <default_init_memmap+0x16>
ffffffffc02035c4:	2581                	sext.w	a1,a1
ffffffffc02035c6:	cd0c                	sw	a1,24(a0)
ffffffffc02035c8:	4789                	li	a5,2
ffffffffc02035ca:	00850713          	addi	a4,a0,8
ffffffffc02035ce:	40f7302f          	amoor.d	zero,a5,(a4)
ffffffffc02035d2:	0000d697          	auipc	a3,0xd
ffffffffc02035d6:	bb668693          	addi	a3,a3,-1098 # ffffffffc0210188 <free_area>
ffffffffc02035da:	4a98                	lw	a4,16(a3)
ffffffffc02035dc:	669c                	ld	a5,8(a3)
ffffffffc02035de:	02050613          	addi	a2,a0,32
ffffffffc02035e2:	9db9                	addw	a1,a1,a4
ffffffffc02035e4:	ca8c                	sw	a1,16(a3)
ffffffffc02035e6:	04d78a63          	beq	a5,a3,ffffffffc020363a <default_init_memmap+0xa6>
ffffffffc02035ea:	fe078713          	addi	a4,a5,-32
ffffffffc02035ee:	0006b803          	ld	a6,0(a3)
ffffffffc02035f2:	4581                	li	a1,0
ffffffffc02035f4:	00e56a63          	bltu	a0,a4,ffffffffc0203608 <default_init_memmap+0x74>
ffffffffc02035f8:	6798                	ld	a4,8(a5)
ffffffffc02035fa:	02d70263          	beq	a4,a3,ffffffffc020361e <default_init_memmap+0x8a>
ffffffffc02035fe:	87ba                	mv	a5,a4
ffffffffc0203600:	fe078713          	addi	a4,a5,-32
ffffffffc0203604:	fee57ae3          	bgeu	a0,a4,ffffffffc02035f8 <default_init_memmap+0x64>
ffffffffc0203608:	c199                	beqz	a1,ffffffffc020360e <default_init_memmap+0x7a>
ffffffffc020360a:	0106b023          	sd	a6,0(a3)
ffffffffc020360e:	6398                	ld	a4,0(a5)
ffffffffc0203610:	60a2                	ld	ra,8(sp)
ffffffffc0203612:	e390                	sd	a2,0(a5)
ffffffffc0203614:	e710                	sd	a2,8(a4)
ffffffffc0203616:	f51c                	sd	a5,40(a0)
ffffffffc0203618:	f118                	sd	a4,32(a0)
ffffffffc020361a:	0141                	addi	sp,sp,16
ffffffffc020361c:	8082                	ret
ffffffffc020361e:	e790                	sd	a2,8(a5)
ffffffffc0203620:	f514                	sd	a3,40(a0)
ffffffffc0203622:	6798                	ld	a4,8(a5)
ffffffffc0203624:	f11c                	sd	a5,32(a0)
ffffffffc0203626:	00d70663          	beq	a4,a3,ffffffffc0203632 <default_init_memmap+0x9e>
ffffffffc020362a:	8832                	mv	a6,a2
ffffffffc020362c:	4585                	li	a1,1
ffffffffc020362e:	87ba                	mv	a5,a4
ffffffffc0203630:	bfc1                	j	ffffffffc0203600 <default_init_memmap+0x6c>
ffffffffc0203632:	60a2                	ld	ra,8(sp)
ffffffffc0203634:	e290                	sd	a2,0(a3)
ffffffffc0203636:	0141                	addi	sp,sp,16
ffffffffc0203638:	8082                	ret
ffffffffc020363a:	60a2                	ld	ra,8(sp)
ffffffffc020363c:	e390                	sd	a2,0(a5)
ffffffffc020363e:	e790                	sd	a2,8(a5)
ffffffffc0203640:	f51c                	sd	a5,40(a0)
ffffffffc0203642:	f11c                	sd	a5,32(a0)
ffffffffc0203644:	0141                	addi	sp,sp,16
ffffffffc0203646:	8082                	ret
ffffffffc0203648:	00002697          	auipc	a3,0x2
ffffffffc020364c:	f8068693          	addi	a3,a3,-128 # ffffffffc02055c8 <etext+0x195a>
ffffffffc0203650:	00001617          	auipc	a2,0x1
ffffffffc0203654:	d6860613          	addi	a2,a2,-664 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203658:	45d9                	li	a1,22
ffffffffc020365a:	00002517          	auipc	a0,0x2
ffffffffc020365e:	c2e50513          	addi	a0,a0,-978 # ffffffffc0205288 <etext+0x161a>
ffffffffc0203662:	a8bfc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203666:	00002697          	auipc	a3,0x2
ffffffffc020366a:	f3268693          	addi	a3,a3,-206 # ffffffffc0205598 <etext+0x192a>
ffffffffc020366e:	00001617          	auipc	a2,0x1
ffffffffc0203672:	d4a60613          	addi	a2,a2,-694 # ffffffffc02043b8 <etext+0x74a>
ffffffffc0203676:	45cd                	li	a1,19
ffffffffc0203678:	00002517          	auipc	a0,0x2
ffffffffc020367c:	c1050513          	addi	a0,a0,-1008 # ffffffffc0205288 <etext+0x161a>
ffffffffc0203680:	a6dfc0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0203684 <swapfs_init>:
ffffffffc0203684:	1141                	addi	sp,sp,-16
ffffffffc0203686:	4505                	li	a0,1
ffffffffc0203688:	e406                	sd	ra,8(sp)
ffffffffc020368a:	ac3fc0ef          	jal	ra,ffffffffc020014c <ide_device_valid>
ffffffffc020368e:	cd01                	beqz	a0,ffffffffc02036a6 <swapfs_init+0x22>
ffffffffc0203690:	4505                	li	a0,1
ffffffffc0203692:	ac1fc0ef          	jal	ra,ffffffffc0200152 <ide_device_size>
ffffffffc0203696:	60a2                	ld	ra,8(sp)
ffffffffc0203698:	810d                	srli	a0,a0,0x3
ffffffffc020369a:	0000d797          	auipc	a5,0xd
ffffffffc020369e:	aaa7b723          	sd	a0,-1362(a5) # ffffffffc0210148 <max_swap_offset>
ffffffffc02036a2:	0141                	addi	sp,sp,16
ffffffffc02036a4:	8082                	ret
ffffffffc02036a6:	00002617          	auipc	a2,0x2
ffffffffc02036aa:	f8260613          	addi	a2,a2,-126 # ffffffffc0205628 <default_pmm_manager+0x38>
ffffffffc02036ae:	45b5                	li	a1,13
ffffffffc02036b0:	00002517          	auipc	a0,0x2
ffffffffc02036b4:	f9850513          	addi	a0,a0,-104 # ffffffffc0205648 <default_pmm_manager+0x58>
ffffffffc02036b8:	a35fc0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc02036bc <swapfs_read>:
ffffffffc02036bc:	1141                	addi	sp,sp,-16
ffffffffc02036be:	e406                	sd	ra,8(sp)
ffffffffc02036c0:	00855793          	srli	a5,a0,0x8
ffffffffc02036c4:	c3a5                	beqz	a5,ffffffffc0203724 <swapfs_read+0x68>
ffffffffc02036c6:	0000d717          	auipc	a4,0xd
ffffffffc02036ca:	a8273703          	ld	a4,-1406(a4) # ffffffffc0210148 <max_swap_offset>
ffffffffc02036ce:	04e7fb63          	bgeu	a5,a4,ffffffffc0203724 <swapfs_read+0x68>
ffffffffc02036d2:	0000d617          	auipc	a2,0xd
ffffffffc02036d6:	9de63603          	ld	a2,-1570(a2) # ffffffffc02100b0 <pages>
ffffffffc02036da:	8d91                	sub	a1,a1,a2
ffffffffc02036dc:	4035d613          	srai	a2,a1,0x3
ffffffffc02036e0:	00002597          	auipc	a1,0x2
ffffffffc02036e4:	1e85b583          	ld	a1,488(a1) # ffffffffc02058c8 <error_string+0x38>
ffffffffc02036e8:	02b60633          	mul	a2,a2,a1
ffffffffc02036ec:	0037959b          	slliw	a1,a5,0x3
ffffffffc02036f0:	00002797          	auipc	a5,0x2
ffffffffc02036f4:	1e07b783          	ld	a5,480(a5) # ffffffffc02058d0 <nbase>
ffffffffc02036f8:	0000d717          	auipc	a4,0xd
ffffffffc02036fc:	96073703          	ld	a4,-1696(a4) # ffffffffc0210058 <npage>
ffffffffc0203700:	963e                	add	a2,a2,a5
ffffffffc0203702:	00c61793          	slli	a5,a2,0xc
ffffffffc0203706:	83b1                	srli	a5,a5,0xc
ffffffffc0203708:	0632                	slli	a2,a2,0xc
ffffffffc020370a:	02e7f963          	bgeu	a5,a4,ffffffffc020373c <swapfs_read+0x80>
ffffffffc020370e:	60a2                	ld	ra,8(sp)
ffffffffc0203710:	0000d797          	auipc	a5,0xd
ffffffffc0203714:	9987b783          	ld	a5,-1640(a5) # ffffffffc02100a8 <va_pa_offset>
ffffffffc0203718:	46a1                	li	a3,8
ffffffffc020371a:	963e                	add	a2,a2,a5
ffffffffc020371c:	4505                	li	a0,1
ffffffffc020371e:	0141                	addi	sp,sp,16
ffffffffc0203720:	a39fc06f          	j	ffffffffc0200158 <ide_read_secs>
ffffffffc0203724:	86aa                	mv	a3,a0
ffffffffc0203726:	00002617          	auipc	a2,0x2
ffffffffc020372a:	f3a60613          	addi	a2,a2,-198 # ffffffffc0205660 <default_pmm_manager+0x70>
ffffffffc020372e:	45d1                	li	a1,20
ffffffffc0203730:	00002517          	auipc	a0,0x2
ffffffffc0203734:	f1850513          	addi	a0,a0,-232 # ffffffffc0205648 <default_pmm_manager+0x58>
ffffffffc0203738:	9b5fc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020373c:	86b2                	mv	a3,a2
ffffffffc020373e:	06a00593          	li	a1,106
ffffffffc0203742:	00001617          	auipc	a2,0x1
ffffffffc0203746:	e7660613          	addi	a2,a2,-394 # ffffffffc02045b8 <etext+0x94a>
ffffffffc020374a:	00001517          	auipc	a0,0x1
ffffffffc020374e:	e5e50513          	addi	a0,a0,-418 # ffffffffc02045a8 <etext+0x93a>
ffffffffc0203752:	99bfc0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0203756 <swapfs_write>:
ffffffffc0203756:	1141                	addi	sp,sp,-16
ffffffffc0203758:	e406                	sd	ra,8(sp)
ffffffffc020375a:	00855793          	srli	a5,a0,0x8
ffffffffc020375e:	c3a5                	beqz	a5,ffffffffc02037be <swapfs_write+0x68>
ffffffffc0203760:	0000d717          	auipc	a4,0xd
ffffffffc0203764:	9e873703          	ld	a4,-1560(a4) # ffffffffc0210148 <max_swap_offset>
ffffffffc0203768:	04e7fb63          	bgeu	a5,a4,ffffffffc02037be <swapfs_write+0x68>
ffffffffc020376c:	0000d617          	auipc	a2,0xd
ffffffffc0203770:	94463603          	ld	a2,-1724(a2) # ffffffffc02100b0 <pages>
ffffffffc0203774:	8d91                	sub	a1,a1,a2
ffffffffc0203776:	4035d613          	srai	a2,a1,0x3
ffffffffc020377a:	00002597          	auipc	a1,0x2
ffffffffc020377e:	14e5b583          	ld	a1,334(a1) # ffffffffc02058c8 <error_string+0x38>
ffffffffc0203782:	02b60633          	mul	a2,a2,a1
ffffffffc0203786:	0037959b          	slliw	a1,a5,0x3
ffffffffc020378a:	00002797          	auipc	a5,0x2
ffffffffc020378e:	1467b783          	ld	a5,326(a5) # ffffffffc02058d0 <nbase>
ffffffffc0203792:	0000d717          	auipc	a4,0xd
ffffffffc0203796:	8c673703          	ld	a4,-1850(a4) # ffffffffc0210058 <npage>
ffffffffc020379a:	963e                	add	a2,a2,a5
ffffffffc020379c:	00c61793          	slli	a5,a2,0xc
ffffffffc02037a0:	83b1                	srli	a5,a5,0xc
ffffffffc02037a2:	0632                	slli	a2,a2,0xc
ffffffffc02037a4:	02e7f963          	bgeu	a5,a4,ffffffffc02037d6 <swapfs_write+0x80>
ffffffffc02037a8:	60a2                	ld	ra,8(sp)
ffffffffc02037aa:	0000d797          	auipc	a5,0xd
ffffffffc02037ae:	8fe7b783          	ld	a5,-1794(a5) # ffffffffc02100a8 <va_pa_offset>
ffffffffc02037b2:	46a1                	li	a3,8
ffffffffc02037b4:	963e                	add	a2,a2,a5
ffffffffc02037b6:	4505                	li	a0,1
ffffffffc02037b8:	0141                	addi	sp,sp,16
ffffffffc02037ba:	9c3fc06f          	j	ffffffffc020017c <ide_write_secs>
ffffffffc02037be:	86aa                	mv	a3,a0
ffffffffc02037c0:	00002617          	auipc	a2,0x2
ffffffffc02037c4:	ea060613          	addi	a2,a2,-352 # ffffffffc0205660 <default_pmm_manager+0x70>
ffffffffc02037c8:	45e5                	li	a1,25
ffffffffc02037ca:	00002517          	auipc	a0,0x2
ffffffffc02037ce:	e7e50513          	addi	a0,a0,-386 # ffffffffc0205648 <default_pmm_manager+0x58>
ffffffffc02037d2:	91bfc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02037d6:	86b2                	mv	a3,a2
ffffffffc02037d8:	06a00593          	li	a1,106
ffffffffc02037dc:	00001617          	auipc	a2,0x1
ffffffffc02037e0:	ddc60613          	addi	a2,a2,-548 # ffffffffc02045b8 <etext+0x94a>
ffffffffc02037e4:	00001517          	auipc	a0,0x1
ffffffffc02037e8:	dc450513          	addi	a0,a0,-572 # ffffffffc02045a8 <etext+0x93a>
ffffffffc02037ec:	901fc0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc02037f0 <strlen>:
ffffffffc02037f0:	00054783          	lbu	a5,0(a0)
ffffffffc02037f4:	872a                	mv	a4,a0
ffffffffc02037f6:	4501                	li	a0,0
ffffffffc02037f8:	cb81                	beqz	a5,ffffffffc0203808 <strlen+0x18>
ffffffffc02037fa:	0505                	addi	a0,a0,1
ffffffffc02037fc:	00a707b3          	add	a5,a4,a0
ffffffffc0203800:	0007c783          	lbu	a5,0(a5)
ffffffffc0203804:	fbfd                	bnez	a5,ffffffffc02037fa <strlen+0xa>
ffffffffc0203806:	8082                	ret
ffffffffc0203808:	8082                	ret

ffffffffc020380a <strnlen>:
ffffffffc020380a:	872a                	mv	a4,a0
ffffffffc020380c:	4501                	li	a0,0
ffffffffc020380e:	e589                	bnez	a1,ffffffffc0203818 <strnlen+0xe>
ffffffffc0203810:	a811                	j	ffffffffc0203824 <strnlen+0x1a>
ffffffffc0203812:	0505                	addi	a0,a0,1
ffffffffc0203814:	00a58763          	beq	a1,a0,ffffffffc0203822 <strnlen+0x18>
ffffffffc0203818:	00a707b3          	add	a5,a4,a0
ffffffffc020381c:	0007c783          	lbu	a5,0(a5)
ffffffffc0203820:	fbed                	bnez	a5,ffffffffc0203812 <strnlen+0x8>
ffffffffc0203822:	8082                	ret
ffffffffc0203824:	8082                	ret

ffffffffc0203826 <strcpy>:
ffffffffc0203826:	87aa                	mv	a5,a0
ffffffffc0203828:	0005c703          	lbu	a4,0(a1)
ffffffffc020382c:	0785                	addi	a5,a5,1
ffffffffc020382e:	0585                	addi	a1,a1,1
ffffffffc0203830:	fee78fa3          	sb	a4,-1(a5)
ffffffffc0203834:	fb75                	bnez	a4,ffffffffc0203828 <strcpy+0x2>
ffffffffc0203836:	8082                	ret

ffffffffc0203838 <strcmp>:
ffffffffc0203838:	00054783          	lbu	a5,0(a0)
ffffffffc020383c:	0005c703          	lbu	a4,0(a1)
ffffffffc0203840:	cb89                	beqz	a5,ffffffffc0203852 <strcmp+0x1a>
ffffffffc0203842:	0505                	addi	a0,a0,1
ffffffffc0203844:	0585                	addi	a1,a1,1
ffffffffc0203846:	fee789e3          	beq	a5,a4,ffffffffc0203838 <strcmp>
ffffffffc020384a:	0007851b          	sext.w	a0,a5
ffffffffc020384e:	9d19                	subw	a0,a0,a4
ffffffffc0203850:	8082                	ret
ffffffffc0203852:	4501                	li	a0,0
ffffffffc0203854:	bfed                	j	ffffffffc020384e <strcmp+0x16>

ffffffffc0203856 <memset>:
ffffffffc0203856:	ca01                	beqz	a2,ffffffffc0203866 <memset+0x10>
ffffffffc0203858:	962a                	add	a2,a2,a0
ffffffffc020385a:	87aa                	mv	a5,a0
ffffffffc020385c:	0785                	addi	a5,a5,1
ffffffffc020385e:	feb78fa3          	sb	a1,-1(a5)
ffffffffc0203862:	fec79de3          	bne	a5,a2,ffffffffc020385c <memset+0x6>
ffffffffc0203866:	8082                	ret

ffffffffc0203868 <memcpy>:
ffffffffc0203868:	ca19                	beqz	a2,ffffffffc020387e <memcpy+0x16>
ffffffffc020386a:	962e                	add	a2,a2,a1
ffffffffc020386c:	87aa                	mv	a5,a0
ffffffffc020386e:	0005c703          	lbu	a4,0(a1)
ffffffffc0203872:	0585                	addi	a1,a1,1
ffffffffc0203874:	0785                	addi	a5,a5,1
ffffffffc0203876:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020387a:	fec59ae3          	bne	a1,a2,ffffffffc020386e <memcpy+0x6>
ffffffffc020387e:	8082                	ret

ffffffffc0203880 <printnum>:
ffffffffc0203880:	02069813          	slli	a6,a3,0x20
ffffffffc0203884:	7179                	addi	sp,sp,-48
ffffffffc0203886:	02085813          	srli	a6,a6,0x20
ffffffffc020388a:	e052                	sd	s4,0(sp)
ffffffffc020388c:	03067a33          	remu	s4,a2,a6
ffffffffc0203890:	f022                	sd	s0,32(sp)
ffffffffc0203892:	ec26                	sd	s1,24(sp)
ffffffffc0203894:	e84a                	sd	s2,16(sp)
ffffffffc0203896:	f406                	sd	ra,40(sp)
ffffffffc0203898:	e44e                	sd	s3,8(sp)
ffffffffc020389a:	84aa                	mv	s1,a0
ffffffffc020389c:	892e                	mv	s2,a1
ffffffffc020389e:	fff7041b          	addiw	s0,a4,-1
ffffffffc02038a2:	2a01                	sext.w	s4,s4
ffffffffc02038a4:	03067e63          	bgeu	a2,a6,ffffffffc02038e0 <printnum+0x60>
ffffffffc02038a8:	89be                	mv	s3,a5
ffffffffc02038aa:	00805763          	blez	s0,ffffffffc02038b8 <printnum+0x38>
ffffffffc02038ae:	347d                	addiw	s0,s0,-1
ffffffffc02038b0:	85ca                	mv	a1,s2
ffffffffc02038b2:	854e                	mv	a0,s3
ffffffffc02038b4:	9482                	jalr	s1
ffffffffc02038b6:	fc65                	bnez	s0,ffffffffc02038ae <printnum+0x2e>
ffffffffc02038b8:	1a02                	slli	s4,s4,0x20
ffffffffc02038ba:	020a5a13          	srli	s4,s4,0x20
ffffffffc02038be:	00002797          	auipc	a5,0x2
ffffffffc02038c2:	dc278793          	addi	a5,a5,-574 # ffffffffc0205680 <default_pmm_manager+0x90>
ffffffffc02038c6:	7402                	ld	s0,32(sp)
ffffffffc02038c8:	9a3e                	add	s4,s4,a5
ffffffffc02038ca:	000a4503          	lbu	a0,0(s4)
ffffffffc02038ce:	70a2                	ld	ra,40(sp)
ffffffffc02038d0:	69a2                	ld	s3,8(sp)
ffffffffc02038d2:	6a02                	ld	s4,0(sp)
ffffffffc02038d4:	85ca                	mv	a1,s2
ffffffffc02038d6:	8326                	mv	t1,s1
ffffffffc02038d8:	6942                	ld	s2,16(sp)
ffffffffc02038da:	64e2                	ld	s1,24(sp)
ffffffffc02038dc:	6145                	addi	sp,sp,48
ffffffffc02038de:	8302                	jr	t1
ffffffffc02038e0:	03065633          	divu	a2,a2,a6
ffffffffc02038e4:	8722                	mv	a4,s0
ffffffffc02038e6:	f9bff0ef          	jal	ra,ffffffffc0203880 <printnum>
ffffffffc02038ea:	b7f9                	j	ffffffffc02038b8 <printnum+0x38>

ffffffffc02038ec <vprintfmt>:
ffffffffc02038ec:	7119                	addi	sp,sp,-128
ffffffffc02038ee:	f4a6                	sd	s1,104(sp)
ffffffffc02038f0:	f0ca                	sd	s2,96(sp)
ffffffffc02038f2:	ecce                	sd	s3,88(sp)
ffffffffc02038f4:	e8d2                	sd	s4,80(sp)
ffffffffc02038f6:	e4d6                	sd	s5,72(sp)
ffffffffc02038f8:	e0da                	sd	s6,64(sp)
ffffffffc02038fa:	fc5e                	sd	s7,56(sp)
ffffffffc02038fc:	f06a                	sd	s10,32(sp)
ffffffffc02038fe:	fc86                	sd	ra,120(sp)
ffffffffc0203900:	f8a2                	sd	s0,112(sp)
ffffffffc0203902:	f862                	sd	s8,48(sp)
ffffffffc0203904:	f466                	sd	s9,40(sp)
ffffffffc0203906:	ec6e                	sd	s11,24(sp)
ffffffffc0203908:	892a                	mv	s2,a0
ffffffffc020390a:	84ae                	mv	s1,a1
ffffffffc020390c:	8d32                	mv	s10,a2
ffffffffc020390e:	8a36                	mv	s4,a3
ffffffffc0203910:	02500993          	li	s3,37
ffffffffc0203914:	5b7d                	li	s6,-1
ffffffffc0203916:	00002a97          	auipc	s5,0x2
ffffffffc020391a:	d9ea8a93          	addi	s5,s5,-610 # ffffffffc02056b4 <default_pmm_manager+0xc4>
ffffffffc020391e:	00002b97          	auipc	s7,0x2
ffffffffc0203922:	f72b8b93          	addi	s7,s7,-142 # ffffffffc0205890 <error_string>
ffffffffc0203926:	000d4503          	lbu	a0,0(s10)
ffffffffc020392a:	001d0413          	addi	s0,s10,1
ffffffffc020392e:	01350a63          	beq	a0,s3,ffffffffc0203942 <vprintfmt+0x56>
ffffffffc0203932:	c121                	beqz	a0,ffffffffc0203972 <vprintfmt+0x86>
ffffffffc0203934:	85a6                	mv	a1,s1
ffffffffc0203936:	0405                	addi	s0,s0,1
ffffffffc0203938:	9902                	jalr	s2
ffffffffc020393a:	fff44503          	lbu	a0,-1(s0)
ffffffffc020393e:	ff351ae3          	bne	a0,s3,ffffffffc0203932 <vprintfmt+0x46>
ffffffffc0203942:	00044603          	lbu	a2,0(s0)
ffffffffc0203946:	02000793          	li	a5,32
ffffffffc020394a:	4c81                	li	s9,0
ffffffffc020394c:	4881                	li	a7,0
ffffffffc020394e:	5c7d                	li	s8,-1
ffffffffc0203950:	5dfd                	li	s11,-1
ffffffffc0203952:	05500513          	li	a0,85
ffffffffc0203956:	4825                	li	a6,9
ffffffffc0203958:	fdd6059b          	addiw	a1,a2,-35
ffffffffc020395c:	0ff5f593          	andi	a1,a1,255
ffffffffc0203960:	00140d13          	addi	s10,s0,1
ffffffffc0203964:	04b56263          	bltu	a0,a1,ffffffffc02039a8 <vprintfmt+0xbc>
ffffffffc0203968:	058a                	slli	a1,a1,0x2
ffffffffc020396a:	95d6                	add	a1,a1,s5
ffffffffc020396c:	4194                	lw	a3,0(a1)
ffffffffc020396e:	96d6                	add	a3,a3,s5
ffffffffc0203970:	8682                	jr	a3
ffffffffc0203972:	70e6                	ld	ra,120(sp)
ffffffffc0203974:	7446                	ld	s0,112(sp)
ffffffffc0203976:	74a6                	ld	s1,104(sp)
ffffffffc0203978:	7906                	ld	s2,96(sp)
ffffffffc020397a:	69e6                	ld	s3,88(sp)
ffffffffc020397c:	6a46                	ld	s4,80(sp)
ffffffffc020397e:	6aa6                	ld	s5,72(sp)
ffffffffc0203980:	6b06                	ld	s6,64(sp)
ffffffffc0203982:	7be2                	ld	s7,56(sp)
ffffffffc0203984:	7c42                	ld	s8,48(sp)
ffffffffc0203986:	7ca2                	ld	s9,40(sp)
ffffffffc0203988:	7d02                	ld	s10,32(sp)
ffffffffc020398a:	6de2                	ld	s11,24(sp)
ffffffffc020398c:	6109                	addi	sp,sp,128
ffffffffc020398e:	8082                	ret
ffffffffc0203990:	87b2                	mv	a5,a2
ffffffffc0203992:	00144603          	lbu	a2,1(s0)
ffffffffc0203996:	846a                	mv	s0,s10
ffffffffc0203998:	00140d13          	addi	s10,s0,1
ffffffffc020399c:	fdd6059b          	addiw	a1,a2,-35
ffffffffc02039a0:	0ff5f593          	andi	a1,a1,255
ffffffffc02039a4:	fcb572e3          	bgeu	a0,a1,ffffffffc0203968 <vprintfmt+0x7c>
ffffffffc02039a8:	85a6                	mv	a1,s1
ffffffffc02039aa:	02500513          	li	a0,37
ffffffffc02039ae:	9902                	jalr	s2
ffffffffc02039b0:	fff44783          	lbu	a5,-1(s0)
ffffffffc02039b4:	8d22                	mv	s10,s0
ffffffffc02039b6:	f73788e3          	beq	a5,s3,ffffffffc0203926 <vprintfmt+0x3a>
ffffffffc02039ba:	ffed4783          	lbu	a5,-2(s10)
ffffffffc02039be:	1d7d                	addi	s10,s10,-1
ffffffffc02039c0:	ff379de3          	bne	a5,s3,ffffffffc02039ba <vprintfmt+0xce>
ffffffffc02039c4:	b78d                	j	ffffffffc0203926 <vprintfmt+0x3a>
ffffffffc02039c6:	fd060c1b          	addiw	s8,a2,-48
ffffffffc02039ca:	00144603          	lbu	a2,1(s0)
ffffffffc02039ce:	846a                	mv	s0,s10
ffffffffc02039d0:	fd06069b          	addiw	a3,a2,-48
ffffffffc02039d4:	0006059b          	sext.w	a1,a2
ffffffffc02039d8:	02d86463          	bltu	a6,a3,ffffffffc0203a00 <vprintfmt+0x114>
ffffffffc02039dc:	00144603          	lbu	a2,1(s0)
ffffffffc02039e0:	002c169b          	slliw	a3,s8,0x2
ffffffffc02039e4:	0186873b          	addw	a4,a3,s8
ffffffffc02039e8:	0017171b          	slliw	a4,a4,0x1
ffffffffc02039ec:	9f2d                	addw	a4,a4,a1
ffffffffc02039ee:	fd06069b          	addiw	a3,a2,-48
ffffffffc02039f2:	0405                	addi	s0,s0,1
ffffffffc02039f4:	fd070c1b          	addiw	s8,a4,-48
ffffffffc02039f8:	0006059b          	sext.w	a1,a2
ffffffffc02039fc:	fed870e3          	bgeu	a6,a3,ffffffffc02039dc <vprintfmt+0xf0>
ffffffffc0203a00:	f40ddce3          	bgez	s11,ffffffffc0203958 <vprintfmt+0x6c>
ffffffffc0203a04:	8de2                	mv	s11,s8
ffffffffc0203a06:	5c7d                	li	s8,-1
ffffffffc0203a08:	bf81                	j	ffffffffc0203958 <vprintfmt+0x6c>
ffffffffc0203a0a:	fffdc693          	not	a3,s11
ffffffffc0203a0e:	96fd                	srai	a3,a3,0x3f
ffffffffc0203a10:	00ddfdb3          	and	s11,s11,a3
ffffffffc0203a14:	00144603          	lbu	a2,1(s0)
ffffffffc0203a18:	2d81                	sext.w	s11,s11
ffffffffc0203a1a:	846a                	mv	s0,s10
ffffffffc0203a1c:	bf35                	j	ffffffffc0203958 <vprintfmt+0x6c>
ffffffffc0203a1e:	000a2c03          	lw	s8,0(s4)
ffffffffc0203a22:	00144603          	lbu	a2,1(s0)
ffffffffc0203a26:	0a21                	addi	s4,s4,8
ffffffffc0203a28:	846a                	mv	s0,s10
ffffffffc0203a2a:	bfd9                	j	ffffffffc0203a00 <vprintfmt+0x114>
ffffffffc0203a2c:	4705                	li	a4,1
ffffffffc0203a2e:	008a0593          	addi	a1,s4,8
ffffffffc0203a32:	01174463          	blt	a4,a7,ffffffffc0203a3a <vprintfmt+0x14e>
ffffffffc0203a36:	1a088e63          	beqz	a7,ffffffffc0203bf2 <vprintfmt+0x306>
ffffffffc0203a3a:	000a3603          	ld	a2,0(s4)
ffffffffc0203a3e:	46c1                	li	a3,16
ffffffffc0203a40:	8a2e                	mv	s4,a1
ffffffffc0203a42:	2781                	sext.w	a5,a5
ffffffffc0203a44:	876e                	mv	a4,s11
ffffffffc0203a46:	85a6                	mv	a1,s1
ffffffffc0203a48:	854a                	mv	a0,s2
ffffffffc0203a4a:	e37ff0ef          	jal	ra,ffffffffc0203880 <printnum>
ffffffffc0203a4e:	bde1                	j	ffffffffc0203926 <vprintfmt+0x3a>
ffffffffc0203a50:	000a2503          	lw	a0,0(s4)
ffffffffc0203a54:	85a6                	mv	a1,s1
ffffffffc0203a56:	0a21                	addi	s4,s4,8
ffffffffc0203a58:	9902                	jalr	s2
ffffffffc0203a5a:	b5f1                	j	ffffffffc0203926 <vprintfmt+0x3a>
ffffffffc0203a5c:	4705                	li	a4,1
ffffffffc0203a5e:	008a0593          	addi	a1,s4,8
ffffffffc0203a62:	01174463          	blt	a4,a7,ffffffffc0203a6a <vprintfmt+0x17e>
ffffffffc0203a66:	18088163          	beqz	a7,ffffffffc0203be8 <vprintfmt+0x2fc>
ffffffffc0203a6a:	000a3603          	ld	a2,0(s4)
ffffffffc0203a6e:	46a9                	li	a3,10
ffffffffc0203a70:	8a2e                	mv	s4,a1
ffffffffc0203a72:	bfc1                	j	ffffffffc0203a42 <vprintfmt+0x156>
ffffffffc0203a74:	00144603          	lbu	a2,1(s0)
ffffffffc0203a78:	4c85                	li	s9,1
ffffffffc0203a7a:	846a                	mv	s0,s10
ffffffffc0203a7c:	bdf1                	j	ffffffffc0203958 <vprintfmt+0x6c>
ffffffffc0203a7e:	85a6                	mv	a1,s1
ffffffffc0203a80:	02500513          	li	a0,37
ffffffffc0203a84:	9902                	jalr	s2
ffffffffc0203a86:	b545                	j	ffffffffc0203926 <vprintfmt+0x3a>
ffffffffc0203a88:	00144603          	lbu	a2,1(s0)
ffffffffc0203a8c:	2885                	addiw	a7,a7,1
ffffffffc0203a8e:	846a                	mv	s0,s10
ffffffffc0203a90:	b5e1                	j	ffffffffc0203958 <vprintfmt+0x6c>
ffffffffc0203a92:	4705                	li	a4,1
ffffffffc0203a94:	008a0593          	addi	a1,s4,8
ffffffffc0203a98:	01174463          	blt	a4,a7,ffffffffc0203aa0 <vprintfmt+0x1b4>
ffffffffc0203a9c:	14088163          	beqz	a7,ffffffffc0203bde <vprintfmt+0x2f2>
ffffffffc0203aa0:	000a3603          	ld	a2,0(s4)
ffffffffc0203aa4:	46a1                	li	a3,8
ffffffffc0203aa6:	8a2e                	mv	s4,a1
ffffffffc0203aa8:	bf69                	j	ffffffffc0203a42 <vprintfmt+0x156>
ffffffffc0203aaa:	03000513          	li	a0,48
ffffffffc0203aae:	85a6                	mv	a1,s1
ffffffffc0203ab0:	e03e                	sd	a5,0(sp)
ffffffffc0203ab2:	9902                	jalr	s2
ffffffffc0203ab4:	85a6                	mv	a1,s1
ffffffffc0203ab6:	07800513          	li	a0,120
ffffffffc0203aba:	9902                	jalr	s2
ffffffffc0203abc:	0a21                	addi	s4,s4,8
ffffffffc0203abe:	6782                	ld	a5,0(sp)
ffffffffc0203ac0:	46c1                	li	a3,16
ffffffffc0203ac2:	ff8a3603          	ld	a2,-8(s4)
ffffffffc0203ac6:	bfb5                	j	ffffffffc0203a42 <vprintfmt+0x156>
ffffffffc0203ac8:	000a3403          	ld	s0,0(s4)
ffffffffc0203acc:	008a0713          	addi	a4,s4,8
ffffffffc0203ad0:	e03a                	sd	a4,0(sp)
ffffffffc0203ad2:	14040263          	beqz	s0,ffffffffc0203c16 <vprintfmt+0x32a>
ffffffffc0203ad6:	0fb05763          	blez	s11,ffffffffc0203bc4 <vprintfmt+0x2d8>
ffffffffc0203ada:	02d00693          	li	a3,45
ffffffffc0203ade:	0cd79163          	bne	a5,a3,ffffffffc0203ba0 <vprintfmt+0x2b4>
ffffffffc0203ae2:	00044783          	lbu	a5,0(s0)
ffffffffc0203ae6:	0007851b          	sext.w	a0,a5
ffffffffc0203aea:	cf85                	beqz	a5,ffffffffc0203b22 <vprintfmt+0x236>
ffffffffc0203aec:	00140a13          	addi	s4,s0,1
ffffffffc0203af0:	05e00413          	li	s0,94
ffffffffc0203af4:	000c4563          	bltz	s8,ffffffffc0203afe <vprintfmt+0x212>
ffffffffc0203af8:	3c7d                	addiw	s8,s8,-1
ffffffffc0203afa:	036c0263          	beq	s8,s6,ffffffffc0203b1e <vprintfmt+0x232>
ffffffffc0203afe:	85a6                	mv	a1,s1
ffffffffc0203b00:	0e0c8e63          	beqz	s9,ffffffffc0203bfc <vprintfmt+0x310>
ffffffffc0203b04:	3781                	addiw	a5,a5,-32
ffffffffc0203b06:	0ef47b63          	bgeu	s0,a5,ffffffffc0203bfc <vprintfmt+0x310>
ffffffffc0203b0a:	03f00513          	li	a0,63
ffffffffc0203b0e:	9902                	jalr	s2
ffffffffc0203b10:	000a4783          	lbu	a5,0(s4)
ffffffffc0203b14:	3dfd                	addiw	s11,s11,-1
ffffffffc0203b16:	0a05                	addi	s4,s4,1
ffffffffc0203b18:	0007851b          	sext.w	a0,a5
ffffffffc0203b1c:	ffe1                	bnez	a5,ffffffffc0203af4 <vprintfmt+0x208>
ffffffffc0203b1e:	01b05963          	blez	s11,ffffffffc0203b30 <vprintfmt+0x244>
ffffffffc0203b22:	3dfd                	addiw	s11,s11,-1
ffffffffc0203b24:	85a6                	mv	a1,s1
ffffffffc0203b26:	02000513          	li	a0,32
ffffffffc0203b2a:	9902                	jalr	s2
ffffffffc0203b2c:	fe0d9be3          	bnez	s11,ffffffffc0203b22 <vprintfmt+0x236>
ffffffffc0203b30:	6a02                	ld	s4,0(sp)
ffffffffc0203b32:	bbd5                	j	ffffffffc0203926 <vprintfmt+0x3a>
ffffffffc0203b34:	4705                	li	a4,1
ffffffffc0203b36:	008a0c93          	addi	s9,s4,8
ffffffffc0203b3a:	01174463          	blt	a4,a7,ffffffffc0203b42 <vprintfmt+0x256>
ffffffffc0203b3e:	08088d63          	beqz	a7,ffffffffc0203bd8 <vprintfmt+0x2ec>
ffffffffc0203b42:	000a3403          	ld	s0,0(s4)
ffffffffc0203b46:	0a044d63          	bltz	s0,ffffffffc0203c00 <vprintfmt+0x314>
ffffffffc0203b4a:	8622                	mv	a2,s0
ffffffffc0203b4c:	8a66                	mv	s4,s9
ffffffffc0203b4e:	46a9                	li	a3,10
ffffffffc0203b50:	bdcd                	j	ffffffffc0203a42 <vprintfmt+0x156>
ffffffffc0203b52:	000a2783          	lw	a5,0(s4)
ffffffffc0203b56:	4719                	li	a4,6
ffffffffc0203b58:	0a21                	addi	s4,s4,8
ffffffffc0203b5a:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0203b5e:	8fb5                	xor	a5,a5,a3
ffffffffc0203b60:	40d786bb          	subw	a3,a5,a3
ffffffffc0203b64:	02d74163          	blt	a4,a3,ffffffffc0203b86 <vprintfmt+0x29a>
ffffffffc0203b68:	00369793          	slli	a5,a3,0x3
ffffffffc0203b6c:	97de                	add	a5,a5,s7
ffffffffc0203b6e:	639c                	ld	a5,0(a5)
ffffffffc0203b70:	cb99                	beqz	a5,ffffffffc0203b86 <vprintfmt+0x29a>
ffffffffc0203b72:	86be                	mv	a3,a5
ffffffffc0203b74:	00002617          	auipc	a2,0x2
ffffffffc0203b78:	b3c60613          	addi	a2,a2,-1220 # ffffffffc02056b0 <default_pmm_manager+0xc0>
ffffffffc0203b7c:	85a6                	mv	a1,s1
ffffffffc0203b7e:	854a                	mv	a0,s2
ffffffffc0203b80:	0ce000ef          	jal	ra,ffffffffc0203c4e <printfmt>
ffffffffc0203b84:	b34d                	j	ffffffffc0203926 <vprintfmt+0x3a>
ffffffffc0203b86:	00002617          	auipc	a2,0x2
ffffffffc0203b8a:	b1a60613          	addi	a2,a2,-1254 # ffffffffc02056a0 <default_pmm_manager+0xb0>
ffffffffc0203b8e:	85a6                	mv	a1,s1
ffffffffc0203b90:	854a                	mv	a0,s2
ffffffffc0203b92:	0bc000ef          	jal	ra,ffffffffc0203c4e <printfmt>
ffffffffc0203b96:	bb41                	j	ffffffffc0203926 <vprintfmt+0x3a>
ffffffffc0203b98:	00002417          	auipc	s0,0x2
ffffffffc0203b9c:	b0040413          	addi	s0,s0,-1280 # ffffffffc0205698 <default_pmm_manager+0xa8>
ffffffffc0203ba0:	85e2                	mv	a1,s8
ffffffffc0203ba2:	8522                	mv	a0,s0
ffffffffc0203ba4:	e43e                	sd	a5,8(sp)
ffffffffc0203ba6:	c65ff0ef          	jal	ra,ffffffffc020380a <strnlen>
ffffffffc0203baa:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0203bae:	01b05b63          	blez	s11,ffffffffc0203bc4 <vprintfmt+0x2d8>
ffffffffc0203bb2:	67a2                	ld	a5,8(sp)
ffffffffc0203bb4:	00078a1b          	sext.w	s4,a5
ffffffffc0203bb8:	3dfd                	addiw	s11,s11,-1
ffffffffc0203bba:	85a6                	mv	a1,s1
ffffffffc0203bbc:	8552                	mv	a0,s4
ffffffffc0203bbe:	9902                	jalr	s2
ffffffffc0203bc0:	fe0d9ce3          	bnez	s11,ffffffffc0203bb8 <vprintfmt+0x2cc>
ffffffffc0203bc4:	00044783          	lbu	a5,0(s0)
ffffffffc0203bc8:	00140a13          	addi	s4,s0,1
ffffffffc0203bcc:	0007851b          	sext.w	a0,a5
ffffffffc0203bd0:	d3a5                	beqz	a5,ffffffffc0203b30 <vprintfmt+0x244>
ffffffffc0203bd2:	05e00413          	li	s0,94
ffffffffc0203bd6:	bf39                	j	ffffffffc0203af4 <vprintfmt+0x208>
ffffffffc0203bd8:	000a2403          	lw	s0,0(s4)
ffffffffc0203bdc:	b7ad                	j	ffffffffc0203b46 <vprintfmt+0x25a>
ffffffffc0203bde:	000a6603          	lwu	a2,0(s4)
ffffffffc0203be2:	46a1                	li	a3,8
ffffffffc0203be4:	8a2e                	mv	s4,a1
ffffffffc0203be6:	bdb1                	j	ffffffffc0203a42 <vprintfmt+0x156>
ffffffffc0203be8:	000a6603          	lwu	a2,0(s4)
ffffffffc0203bec:	46a9                	li	a3,10
ffffffffc0203bee:	8a2e                	mv	s4,a1
ffffffffc0203bf0:	bd89                	j	ffffffffc0203a42 <vprintfmt+0x156>
ffffffffc0203bf2:	000a6603          	lwu	a2,0(s4)
ffffffffc0203bf6:	46c1                	li	a3,16
ffffffffc0203bf8:	8a2e                	mv	s4,a1
ffffffffc0203bfa:	b5a1                	j	ffffffffc0203a42 <vprintfmt+0x156>
ffffffffc0203bfc:	9902                	jalr	s2
ffffffffc0203bfe:	bf09                	j	ffffffffc0203b10 <vprintfmt+0x224>
ffffffffc0203c00:	85a6                	mv	a1,s1
ffffffffc0203c02:	02d00513          	li	a0,45
ffffffffc0203c06:	e03e                	sd	a5,0(sp)
ffffffffc0203c08:	9902                	jalr	s2
ffffffffc0203c0a:	6782                	ld	a5,0(sp)
ffffffffc0203c0c:	8a66                	mv	s4,s9
ffffffffc0203c0e:	40800633          	neg	a2,s0
ffffffffc0203c12:	46a9                	li	a3,10
ffffffffc0203c14:	b53d                	j	ffffffffc0203a42 <vprintfmt+0x156>
ffffffffc0203c16:	03b05163          	blez	s11,ffffffffc0203c38 <vprintfmt+0x34c>
ffffffffc0203c1a:	02d00693          	li	a3,45
ffffffffc0203c1e:	f6d79de3          	bne	a5,a3,ffffffffc0203b98 <vprintfmt+0x2ac>
ffffffffc0203c22:	00002417          	auipc	s0,0x2
ffffffffc0203c26:	a7640413          	addi	s0,s0,-1418 # ffffffffc0205698 <default_pmm_manager+0xa8>
ffffffffc0203c2a:	02800793          	li	a5,40
ffffffffc0203c2e:	02800513          	li	a0,40
ffffffffc0203c32:	00140a13          	addi	s4,s0,1
ffffffffc0203c36:	bd6d                	j	ffffffffc0203af0 <vprintfmt+0x204>
ffffffffc0203c38:	00002a17          	auipc	s4,0x2
ffffffffc0203c3c:	a61a0a13          	addi	s4,s4,-1439 # ffffffffc0205699 <default_pmm_manager+0xa9>
ffffffffc0203c40:	02800513          	li	a0,40
ffffffffc0203c44:	02800793          	li	a5,40
ffffffffc0203c48:	05e00413          	li	s0,94
ffffffffc0203c4c:	b565                	j	ffffffffc0203af4 <vprintfmt+0x208>

ffffffffc0203c4e <printfmt>:
ffffffffc0203c4e:	715d                	addi	sp,sp,-80
ffffffffc0203c50:	02810313          	addi	t1,sp,40
ffffffffc0203c54:	f436                	sd	a3,40(sp)
ffffffffc0203c56:	869a                	mv	a3,t1
ffffffffc0203c58:	ec06                	sd	ra,24(sp)
ffffffffc0203c5a:	f83a                	sd	a4,48(sp)
ffffffffc0203c5c:	fc3e                	sd	a5,56(sp)
ffffffffc0203c5e:	e0c2                	sd	a6,64(sp)
ffffffffc0203c60:	e4c6                	sd	a7,72(sp)
ffffffffc0203c62:	e41a                	sd	t1,8(sp)
ffffffffc0203c64:	c89ff0ef          	jal	ra,ffffffffc02038ec <vprintfmt>
ffffffffc0203c68:	60e2                	ld	ra,24(sp)
ffffffffc0203c6a:	6161                	addi	sp,sp,80
ffffffffc0203c6c:	8082                	ret
