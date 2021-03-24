	pseg
	even

	def	strchr
strchr
L4
	movb *r1, r3
	movb r3, r4
	srl  r4, 8
	c    r4, r2
	jeq  L2
	jeq  0
	cb  r3, @$-1
	jeq  L3
	inc  r1
	jmp  L4
L3
	clr  r1
L2
	b    *r11
	.size	strchr, .-strchr
	even

	def	wait
wait
	ci   r1, 0
	jne  JMP_0
	b    @L10
JMP_0
	clr  r2
L9
* Begin inline assembler code
* 245 "main.c" 1
	clr r12
	tb 2
	jeq -4
	movb @>8802,r12
* 0 "" 2
* End of inline assembler code
	inc  r2
	c    r2, r1
	jeq  JMP_1
	b    @L9
JMP_1
L10
	b    *r11
	.size	wait, .-wait
	even

	def	initPab
initPab
	li   r3, >14
	movb r3, *r1
	swpb r3
	movb r3, @>1(r1)
	swpb r2
	movb r2, @>4(r1)
	clr  r2
	movb r2, @>6(r1)
	movb r2, @>7(r1)
	movb r2, @>8(r1)
	movb r2, @>9(r1)
	movb r2, @>5(r1)
	b    *r11
	.size	initPab, .-initPab
	even

	def	pawncoord
pawncoord
	srl  r1, 8
	srl  r2, 8
	mov  r1, r4
	sla  r4, >2
	a    r2, r4
	a    r4, r4
	ai   r4, playerpos
	jeq  0
	cb  *r4, @$-1
	jeq  L18
	srl  r3, 8
	movb @>1(r4), r2
	srl  r2, 8
	sla  r1, >3
	a    r2, r1
	a    r1, r1
	a    r3, r1
	movb @homedestcoords(r1), r1
	b    *r11
	jmp  L19
L18
	srl  r3, 8
	movb @>1(r4), r1
	srl  r1, 8
	a    r1, r1
	a    r3, r1
	movb @fieldcoords(r1), r1
	b    *r11
L19
	.size	pawncoord, .-pawncoord
	even

	def	computerchoosepawn
computerchoosepawn
	ai   r10, >FFD8
	mov  r10, r0
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	mov  r2, @>20(r10)
	clr  @>8(r10)
	clr  @>A(r10)
	clr  @>C(r10)
	clr  @>E(r10)
	movb @throw, @>22(r10)
	mov  r10, r2
	ai   r2, >8
	mov  r2, @>26(r10)
	movb r1, r3
	srl  r3, 8
	mov  r3, r4
	sla  r4, >3
	mov  r4, r2
	ai   r2, playerpos
	mov  r2, @>1A(r10)
	mov  r10, r14
	ai   r14, >8
	clr  r2
	mov  r2, @>12(r10)
	inc  r4
	mov  r4, r2
	ai   r2, playerpos
	mov  r2, @>10(r10)
	sla  r3, >2
	mov  r3, r2
	ai   r2, playerdata
	inc  r2
	mov  r2, @>24(r10)
	movb r1, r15
	jmp  L60
L70
	li   r1, >D8F0
	mov  r1, *r14
L22
	mov  @>12(r10), r2
	inc  r2
	mov  r2, @>12(r10)
	inct r14
	mov  @>1A(r10), r1
	inct r1
	mov  r1, @>1A(r10)
	ai   r2, >FFFC
	jne  JMP_2
	b    @L39
JMP_2
L60
	mov  @>20(r10), r1
	mov  @>12(r10), r2
	a    r2, r1
	jeq  0
	cb  *r1, @$-1
	jeq  L70
	mov  @>1A(r10), r2
	movb *r2, @>1F(r10)
	mov  @>1A(r10), r1
	movb @>1(r1), r1
	movb r1, @>1E(r10)
	movb @>22(r10), r2
	ab   r1, r2
	movb r2, @>1D(r10)
	movb @>1F(r10), r1
	jeq  JMP_3
	b    @L23
JMP_3
	jeq  0
	cb  r15, @$-1
	jeq  JMP_4
	b    @L24
JMP_4
	li   r1, >2700
	cb   r2, r1
	jle  L30
	movb @>1E(r10), r2
	cb   r2, r1
	jh  JMP_5
	b    @L71
JMP_5
L30
	movb @>1D(r10), @>1C(r10)
L33
	li   r2, >2700
	movb @>1C(r10), r1
	cb   r1, r2
	jle  L35
	ai   r1, >D800
	movb r1, @>1C(r10)
L35
	clr  r13
L37
	li   r7, playerpos
	clr  r6
	clr  r9
	movb @>1E(r10), r2
	srl  r2, 8
	mov  r2, @>14(r10)
	movb @>1D(r10), r1
	srl  r1, 8
	mov  r1, @>16(r10)
	movb @>1C(r10), r2
	srl  r2, 8
	mov  r2, @>18(r10)
	movb @>1C(r10), r12
L40
	mov  r6, r4
	sla  r4, >3
	ai   r4, playerpos
	mov  @>10(r10), r5
	clr  r3
	mov  r6, r8
	sla  r8, >2
	li   r0, >D00
L51
	cb   r15, r9
	jne  JMP_6
	b    @L72
JMP_6
	movb *r4, r1
	cb   r1, r13
	jne  JMP_7
	b    @L73
JMP_7
L43
	jeq  0
	cb  r1, @$-1
	jne  L44
	jeq  0
	cb  r13, @$-1
	jne  JMP_8
	b    @L46
JMP_8
L44
	inc  r3
	inct r4
	inct r5
	ci   r3, >4
	jne  L51
	ai   r9, >100
	inc  r6
	ai   r7, >8
	li   r1, >400
	cb   r9, r1
	jne  L40
	jeq  0
	cb  r13, @$-1
	jne  L53
	movb @>1C(r10), r2
	jne  JMP_9
	b    @L54
JMP_9
	li   r2, >A00
	movb @>1C(r10), r1
	cb   r1, r2
	jne  JMP_10
	b    @L54
JMP_10
	li   r2, >1400
	cb   r1, r2
	jne  JMP_11
	b    @L54
JMP_11
	li   r2, >1E00
	cb   r1, r2
	jne  JMP_12
	b    @L54
JMP_12
L53
	movb @>1F(r10), r1
	jne  L55
	movb @>1E(r10), r2
	jne  JMP_13
	b    @L56
JMP_13
	li   r2, >A00
	movb @>1E(r10), r1
	cb   r1, r2
	jeq  L56
	li   r2, >1400
	cb   r1, r2
	jeq  L56
	li   r2, >1E00
	cb   r1, r2
	jeq  L56
L55
	jeq  0
	cb  r15, @$-1
	jne  L57
L76
	movb @>1C(r10), r1
	srl  r1, 8
	a    r1, *r14
	mov  @>12(r10), r2
	inc  r2
	mov  r2, @>12(r10)
	inct r14
	mov  @>1A(r10), r1
	inct r1
	mov  r1, @>1A(r10)
	ai   r2, >FFFC
	jeq  JMP_14
	b    @L60
JMP_14
L39
	mov  @>20(r10), r5
	li   r4, >B1E0
	clr  r2
	movb r2, r1
	li   r7, >100
	li   r6, >400
	mov  @>26(r10), r8
L64
	mov  *r8, r3
	c    r4, r3
	jgt  L61
	jeq  L61
	cb   *r5, r7
	jne  JMP_15
	b    @L74
JMP_15
L61
	mov  r4, r3
	ai   r2, >100
	inct r8
	inc  r5
	cb   r2, r6
	jne  JMP_16
	b    @L75
JMP_16
L63
	mov  r3, r4
	jmp  L64
L54
	li   r2, >F060
	a    r2, *r14
	b    @L53
L56
	li   r2, >7D0
	a    r2, *r14
	jeq  0
	cb  r15, @$-1
	jeq  L76
L57
	li   r1, >100
	cb   r15, r1
	jeq  JMP_17
	b    @L58
JMP_17
	mov  *r14, r2
	ai   r2, >FFF6
	movb @>1D(r10), r1
	srl  r1, 8
	a    r1, r2
	mov  r2, *r14
	b    @L22
L72
	cb   @>FFFF(r5), r13
	jeq  L77
L42
	mov  r3, r1
	a    r3, r1
	a    r7, r1
	movb *r1, r1
	b    @L43
L77
	cb   *r5, r12
	jne  L42
	li   r1, >E0C0
	a    r1, *r14
	mov  r3, r1
	a    r3, r1
	a    r7, r1
	movb *r1, r1
	b    @L43
L48
	li   r2, >300
	cb   r9, r2
	jne  L46
	ci   r12, >17FF
	jle  L46
	li   r2, >BB8
	a    r2, *r14
L46
	cb   r15, r9
	jne  JMP_18
	b    @L44
JMP_18
	mov  r8, r1
	a    r3, r1
	a    r1, r1
	ai   r1, playerpos
	movb @>1(r1), r1
	srl  r1, 8
	mov  @>14(r10), r2
	s    r1, r2
	dec  r2
	ci   r2, >4
	jh  L49
	li   r2, >190
	a    r2, *r14
L49
	mov  @>16(r10), r2
	s    r1, r2
	dec  r2
	ci   r2, >4
	jh  L50
	li   r2, >FF38
	a    r2, *r14
L50
	mov  @>18(r10), r2
	s    r2, r1
	dec  r1
	ci   r1, >4
	jle  JMP_19
	b    @L44
JMP_19
	li   r1, >64
	a    r1, *r14
	b    @L44
L73
	cb   @>1(r4), r12
	jeq  JMP_20
	b    @L43
JMP_20
	mov  *r14, r2
	ai   r2, >FA0
	mov  r2, *r14
	jeq  0
	cb  r13, @$-1
	jeq  JMP_21
	b    @L44
JMP_21
	jeq  0
	cb  r9, @$-1
	jne  L45
	ci   r12, >21FF
	jle  L46
	ai   r2, >BB8
	mov  r2, *r14
	jmp  L46
L45
	li   r1, >100
	cb   r9, r1
	jeq  JMP_22
	b    @L47
JMP_22
	ci   r12, >3FF
	jh  JMP_23
	b    @L46
JMP_23
	ai   r2, >BB8
	mov  r2, *r14
	b    @L46
L23
	movb @>1F(r10), r13
	movb @>1D(r10), @>1C(r10)
L32
	li   r2, >100
	cb   r13, r2
	jeq  JMP_24
	b    @L37
JMP_24
L34
	li   r2, >300
	movb @>1C(r10), r1
	cb   r1, r2
	jle  L68
	li   r1, >100
	mov  @>24(r10), r2
	cb   *r2, r1
	jne  JMP_25
	b    @L78
JMP_25
	li   r1, >1770
	a    r1, *r14
L68
	li   r13, >100
	b    @L37
L24
	li   r2, >100
	cb   r15, r2
	jne  L27
	li   r2, >900
	movb @>1D(r10), r1
	cb   r1, r2
	jle  L31
	movb @>1E(r10), r1
	cb   r1, r2
	jh  L31
	movb @>1D(r10), r2
	ai   r2, >FA00
	movb r2, @>1C(r10)
	jmp  L34
L31
	movb @>1D(r10), @>1C(r10)
	b    @L33
L47
	li   r1, >200
	cb   r9, r1
	jeq  JMP_26
	b    @L48
JMP_26
	cb   r12, r0
	jh  JMP_27
	b    @L46
JMP_27
	ai   r2, >BB8
	mov  r2, *r14
	b    @L46
L58
	li   r2, >200
	cb   r15, r2
	jne  L59
	mov  *r14, r2
	ai   r2, >FFEC
	movb @>1D(r10), r1
	srl  r1, 8
	a    r1, r2
	mov  r2, *r14
	b    @L22
L74
	movb r2, r1
	ai   r2, >100
	inct r8
	inc  r5
	cb   r2, r6
	jeq  JMP_28
	b    @L63
JMP_28
L75
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >22
	b    *r11
L27
	li   r2, >200
	cb   r15, r2
	jne  L29
	li   r2, >1300
	movb @>1D(r10), r1
	cb   r1, r2
	jh  JMP_29
	b    @L30
JMP_29
	movb @>1E(r10), r1
	cb   r1, r2
	jle  JMP_30
	b    @L30
JMP_30
	movb @>1D(r10), r2
	ai   r2, >F000
	movb r2, @>1C(r10)
	b    @L34
L71
	movb @>1D(r10), r1
	ai   r1, >DC00
	movb r1, @>1C(r10)
	b    @L34
L78
	mov  @>12(r10), r1
	a    r1, r1
	li   r2, >8
	a    r10, r2
	a    r2, r1
	li   r2, >2710
	mov  r2, *r1
	b    @L39
L59
	li   r2, >300
	cb   r15, r2
	jeq  JMP_31
	b    @L22
JMP_31
	mov  *r14, r2
	ai   r2, >FFE2
	movb @>1D(r10), r1
	srl  r1, 8
	a    r1, r2
	mov  r2, *r14
	b    @L22
L29
	li   r2, >300
	cb   r15, r2
	jeq  JMP_32
	b    @L31
JMP_32
	li   r2, >1D00
	movb @>1D(r10), r1
	cb   r1, r2
	jh  JMP_33
	b    @L31
JMP_33
	movb @>1E(r10), r1
	cb   r1, r2
	jle  JMP_34
	b    @L31
JMP_34
	movb @>1D(r10), r2
	ai   r2, >E600
	movb r2, @>1C(r10)
	li   r13, >100
	b    @L32
	.size	computerchoosepawn, .-computerchoosepawn
LC0
	text '%s '
	byte 0
	even

	def	menuplacebar
menuplacebar
	ai   r10, >FFFA
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	li   r1, >6
	mov  r1, @conio_x
	clr  @conio_y
	jeq  0
	cb  @menubaroptions, @$-1
	jeq  L82
	clr  r9
	li   r13, cprintf
L81
	ai   r10, >FFFC
	li   r1, LC0
	mov  r1, *r10
	movb r9, r2
	srl  r2, 8
	mov  r2, r1
	a    r2, r1
	a    r2, r1
	sla  r1, >2
	ai   r1, menubartitles
	mov  r1, @>2(r10)
	bl   *r13
	ai   r9, >100
	ai   r10, >4
	cb   @menubaroptions, r9
	jh  L81
L82
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
	.size	menuplacebar, .-menuplacebar
	even

	def	pawnplace
pawnplace
	ai   r10, >FFF6
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	movb r1, r5
	srl  r5, 8
	srl  r2, 8
	mov  r5, r4
	sla  r4, >2
	a    r2, r4
	a    r4, r4
	ai   r4, playerpos
	jeq  0
	cb  *r4, @$-1
	jne  L85
	movb @>1(r4), r2
	srl  r2, 8
	a    r2, r2
	ai   r2, fieldcoords
	movb *r2+, r4
	movb *r2, r2
	jeq  0
	cb  r3, @$-1
	jne  L96
L87
	li   r3, >100
	cb   r1, r3
	jne  JMP_35
	b    @L90
JMP_35
	cb   r1, r3
	jhe  L97
	movb r4, r13
	srl  r13, 8
	movb r2, r14
	srl  r14, 8
	li   r9, cputcxy
	mov  r13, r1
	mov  r14, r2
	li   r3, >80
	bl   *r9
	mov  r13, r15
	inc  r15
	mov  r15, r1
	mov  r14, r2
	li   r3, >81
	bl   *r9
	inc  r14
	mov  r13, r1
	mov  r14, r2
	li   r3, >82
	bl   *r9
	mov  r15, r1
	mov  r14, r2
	li   r3, >83
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @cputcxy
L85
	movb @>1(r4), r4
	srl  r4, 8
	mov  r5, r2
	sla  r2, >3
	a    r4, r2
	a    r2, r2
	ai   r2, homedestcoords
	movb *r2+, r4
	movb *r2, r2
	jeq  0
	cb  r3, @$-1
	jeq  L87
L96
	movb r4, r13
	srl  r13, 8
	movb r2, r14
	srl  r14, 8
	li   r9, cputcxy
	mov  r13, r1
	mov  r14, r2
	li   r3, >A0
	bl   *r9
	mov  r13, r15
	inc  r15
	mov  r15, r1
	mov  r14, r2
	li   r3, >A1
	bl   *r9
	inc  r14
	mov  r13, r1
	mov  r14, r2
	li   r3, >A2
	bl   *r9
	mov  r15, r1
	mov  r14, r2
	li   r3, >A3
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @cputcxy
L97
	li   r3, >200
	cb   r1, r3
	jeq  L91
	li   r3, >300
	cb   r1, r3
	jeq  L98
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
L91
	movb r4, r13
	srl  r13, 8
	movb r2, r14
	srl  r14, 8
	li   r9, cputcxy
	mov  r13, r1
	mov  r14, r2
	li   r3, >90
	bl   *r9
	mov  r13, r15
	inc  r15
	mov  r15, r1
	mov  r14, r2
	li   r3, >91
	bl   *r9
	inc  r14
	mov  r13, r1
	mov  r14, r2
	li   r3, >92
	bl   *r9
	mov  r15, r1
	mov  r14, r2
	li   r3, >93
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @cputcxy
L90
	movb r4, r13
	srl  r13, 8
	movb r2, r14
	srl  r14, 8
	li   r9, cputcxy
	mov  r13, r1
	mov  r14, r2
	li   r3, >88
	bl   *r9
	mov  r13, r15
	inc  r15
	mov  r15, r1
	mov  r14, r2
	li   r3, >89
	bl   *r9
	inc  r14
	mov  r13, r1
	mov  r14, r2
	li   r3, >8A
	bl   *r9
	mov  r15, r1
	mov  r14, r2
	li   r3, >8B
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @cputcxy
L98
	movb r4, r13
	srl  r13, 8
	movb r2, r14
	srl  r14, 8
	li   r9, cputcxy
	mov  r13, r1
	mov  r14, r2
	li   r3, >98
	bl   *r9
	mov  r13, r15
	inc  r15
	mov  r15, r1
	mov  r14, r2
	li   r3, >99
	bl   *r9
	inc  r14
	mov  r13, r1
	mov  r14, r2
	li   r3, >9A
	bl   *r9
	mov  r15, r1
	mov  r14, r2
	li   r3, >9B
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @cputcxy
	.size	pawnplace, .-pawnplace
	even

	def	pawnerase
pawnerase
	ai   r10, >FFF6
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	movb r1, r4
	srl  r4, 8
	srl  r2, 8
	mov  r4, r3
	sla  r3, >2
	a    r2, r3
	a    r3, r3
	ai   r3, playerpos
	jeq  0
	cb  *r3, @$-1
	jne  L100
	movb @>1(r3), r3
	movb r3, r2
	srl  r2, 8
	a    r2, r2
	ai   r2, fieldcoords
	movb *r2+, r1
	movb *r2, r2
	jeq  0
	cb  r3, @$-1
	jne  L115
	movb r1, r13
	srl  r13, 8
	movb r2, r14
	srl  r14, 8
	li   r9, cputcxy
	mov  r13, r1
	mov  r14, r2
	li   r3, >AC
	bl   *r9
	mov  r13, r15
	inc  r15
	mov  r15, r1
	mov  r14, r2
	li   r3, >AD
	bl   *r9
	inc  r14
	mov  r13, r1
	mov  r14, r2
	li   r3, >AE
	bl   *r9
	mov  r15, r1
	mov  r14, r2
	li   r3, >AF
L114
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @cputcxy
L100
	movb @>1(r3), r3
	srl  r3, 8
	mov  r4, r2
	sla  r2, >3
	a    r3, r2
	a    r2, r2
	ai   r2, homedestcoords
	movb *r2+, r4
	movb *r2, r2
	li   r3, >100
	cb   r1, r3
	jne  JMP_36
	b    @L105
JMP_36
	cb   r1, r3
	jl  L104
	li   r3, >200
	cb   r1, r3
	jne  JMP_37
	b    @L106
JMP_37
	li   r3, >300
	cb   r1, r3
	jne  JMP_38
	b    @L116
JMP_38
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
L115
	li   r4, >A00
	cb   r3, r4
	jne  JMP_39
	b    @L108
JMP_39
	li   r4, >1400
	cb   r3, r4
	jne  JMP_40
	b    @L109
JMP_40
	li   r4, >1E00
	cb   r3, r4
	jne  JMP_41
	b    @L117
JMP_41
	movb r1, r13
	srl  r13, 8
	movb r2, r14
	srl  r14, 8
	li   r9, cputcxy
	mov  r13, r1
	mov  r14, r2
	li   r3, >A4
	bl   *r9
	mov  r13, r15
	inc  r15
	mov  r15, r1
	mov  r14, r2
	li   r3, >A5
	bl   *r9
	inc  r14
	mov  r13, r1
	mov  r14, r2
	li   r3, >A6
	bl   *r9
	mov  r15, r1
	mov  r14, r2
	li   r3, >A7
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @cputcxy
L104
	movb r4, r13
	srl  r13, 8
	movb r2, r14
	srl  r14, 8
	li   r9, cputcxy
	mov  r13, r1
	mov  r14, r2
	li   r3, >84
	bl   *r9
	mov  r13, r15
	inc  r15
	mov  r15, r1
	mov  r14, r2
	li   r3, >85
	bl   *r9
	inc  r14
	mov  r13, r1
	mov  r14, r2
	li   r3, >86
	bl   *r9
	mov  r15, r1
	mov  r14, r2
	li   r3, >87
	b    @L114
L105
	movb r4, r13
	srl  r13, 8
	movb r2, r14
	srl  r14, 8
	li   r9, cputcxy
	mov  r13, r1
	mov  r14, r2
	li   r3, >8C
	bl   *r9
	mov  r13, r15
	inc  r15
	mov  r15, r1
	mov  r14, r2
	li   r3, >8D
	bl   *r9
	inc  r14
	mov  r13, r1
	mov  r14, r2
	li   r3, >8E
	bl   *r9
	mov  r15, r1
	mov  r14, r2
	li   r3, >8F
	b    @L114
L108
	movb r1, r13
	srl  r13, 8
	movb r2, r14
	srl  r14, 8
	li   r9, cputcxy
	mov  r13, r1
	mov  r14, r2
	li   r3, >B4
	bl   *r9
	mov  r13, r15
	inc  r15
	mov  r15, r1
	mov  r14, r2
	li   r3, >B5
	bl   *r9
	inc  r14
	mov  r13, r1
	mov  r14, r2
	li   r3, >B6
	bl   *r9
	mov  r15, r1
	mov  r14, r2
	li   r3, >B7
	b    @L114
L116
	movb r4, r13
	srl  r13, 8
	movb r2, r14
	srl  r14, 8
	li   r9, cputcxy
	mov  r13, r1
	mov  r14, r2
	li   r3, >9C
	bl   *r9
	mov  r13, r15
	inc  r15
	mov  r15, r1
	mov  r14, r2
	li   r3, >9D
	bl   *r9
	inc  r14
	mov  r13, r1
	mov  r14, r2
	li   r3, >9E
	bl   *r9
	mov  r15, r1
	mov  r14, r2
	li   r3, >9F
	b    @L114
L106
	movb r4, r13
	srl  r13, 8
	movb r2, r14
	srl  r14, 8
	li   r9, cputcxy
	mov  r13, r1
	mov  r14, r2
	li   r3, >94
	bl   *r9
	mov  r13, r15
	inc  r15
	mov  r15, r1
	mov  r14, r2
	li   r3, >95
	bl   *r9
	inc  r14
	mov  r13, r1
	mov  r14, r2
	li   r3, >96
	bl   *r9
	mov  r15, r1
	mov  r14, r2
	li   r3, >97
	b    @L114
L109
	movb r1, r13
	srl  r13, 8
	movb r2, r14
	srl  r14, 8
	li   r9, cputcxy
	mov  r13, r1
	mov  r14, r2
	li   r3, >BC
	bl   *r9
	mov  r13, r15
	inc  r15
	mov  r15, r1
	mov  r14, r2
	li   r3, >BD
	bl   *r9
	inc  r14
	mov  r13, r1
	mov  r14, r2
	li   r3, >BE
	bl   *r9
	mov  r15, r1
	mov  r14, r2
	li   r3, >BF
	b    @L114
L117
	movb r1, r13
	srl  r13, 8
	movb r2, r14
	srl  r14, 8
	li   r9, cputcxy
	mov  r13, r1
	mov  r14, r2
	li   r3, >C4
	bl   *r9
	mov  r13, r15
	inc  r15
	mov  r15, r1
	mov  r14, r2
	li   r3, >C5
	bl   *r9
	inc  r14
	mov  r13, r1
	mov  r14, r2
	li   r3, >C6
	bl   *r9
	mov  r15, r1
	mov  r14, r2
	li   r3, >C7
	b    @L114
	.size	pawnerase, .-pawnerase
	even

	def	loadmainscreen
loadmainscreen
	dect r10
	mov  r11, *r10
	mov  @gImage, r1
	li   r2, mainscreen
	li   r3, >300
	bl   @vdpmemcpy
	mov  *r10+, r11
	b    @menuplacebar
	.size	loadmainscreen, .-loadmainscreen
	even

	def	gamereset
gamereset
	dect r10
	mov  r11, *r10
	bl   @loadmainscreen
	clr  r1
	movb r1, @turnofplayernr
	li   r2, playerdata+1
	clr  r1
L121
	li   r3, >400
	movb r3, *r2
	movb r3, @>2(r2)
	li   r4, >FF08
	movb r4, @np(r1)
	swpb r4
	movb r4, @dp(r1)
	inc  r1
	ai   r2, >4
	ci   r1, >4
	jne  L121
	mov  *r10+, r11
	b    *r11
	.size	gamereset, .-gamereset
	even

	def	windowrestore
windowrestore
	ai   r10, >FFFC
	mov  r11, *r10
	mov  r9, @>2(r10)
	movb @windownumber, r2
	ai   r2, >FF00
	movb r2, @windownumber
	srl  r2, 8
	li   r9, Window
	mov  r2, r1
	sla  r1, >2
	a    r9, r1
	mov  *r1, r1
	mov  r1, @windowaddress
	a    r2, r2
	inc  r2
	a    r2, r2
	a    r9, r2
	movb @>1(r2), r3
	srl  r3, 8
	li   r2, windowmemory
	sla  r3, >5
	bl   @vdpmemread
	movb @windownumber, r2
	srl  r2, 8
	a    r2, r2
	inc  r2
	a    r2, r2
	a    r9, r2
	movb *r2, r1
	srl  r1, >3
	andi r1, >FFE0
	movb @>1(r2), r3
	srl  r3, 8
	a    @gImage, r1
	li   r2, windowmemory
	sla  r3, >5
	mov  *r10+, r11
	mov  *r10+, r9
	b    @vdpmemcpy
	.size	windowrestore, .-windowrestore
	even

	def	windowsave
windowsave
	ai   r10, >FFFC
	mov  r11, *r10
	mov  r9, @>2(r10)
	movb @windownumber, r4
	srl  r4, 8
	mov  r4, r3
	sla  r3, >2
	li   r9, Window
	mov  @windowaddress, @Window(r3)
	a    r4, r4
	inc  r4
	a    r4, r4
	a    r9, r4
	movb r1, *r4
	movb r2, @>1(r4)
	srl  r1, >3
	andi r1, >FFE0
	movb r2, r3
	srl  r3, 8
	a    @gImage, r1
	li   r2, windowmemory
	sla  r3, >5
	bl   @vdpmemread
	movb @windownumber, r1
	srl  r1, 8
	a    r1, r1
	inc  r1
	a    r1, r1
	a    r9, r1
	movb @>1(r1), r3
	srl  r3, 8
	mov  @windowaddress, r1
	li   r2, windowmemory
	sla  r3, >5
	bl   @vdpmemcpy
	movb @windownumber, r2
	movb r2, r1
	srl  r1, 8
	a    r1, r1
	inc  r1
	a    r1, r1
	a    r9, r1
	movb @>1(r1), r1
	srl  r1, >3
	andi r1, >FFE0
	a    r1, @windowaddress
	ai   r2, >100
	movb r2, @windownumber
	mov  *r10+, r11
	mov  *r10+, r9
	b    *r11
	.size	windowsave, .-windowsave
	even

	def	graphicsinit
graphicsinit
	ai   r10, >FFFC
	mov  r11, *r10
	mov  r9, @>2(r10)
	clr  r1
	bl   @set_graphics
	li   r1, >2020
	mov  r1, @windowaddress
	li   r1, >1
	bl   @bgcolor
	li   r9, vdpmemcpy
	mov  @gColor, r1
	li   r2, colorset
	li   r3, >19
	bl   *r9
	mov  @gPattern, r1
	li   r2, patterns
	li   r3, >640
	bl   *r9
	mov  *r10+, r11
	mov  *r10+, r9
	b    @clrscr
	.size	graphicsinit, .-graphicsinit
	even

	def	strcat
strcat
	ai   r10, >FFFA
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r1, r9
	mov  r2, r13
	bl   @strlen
	a    r9, r1
	mov  r13, r2
	bl   @strcpy
	mov  r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
	.size	strcat, .-strcat
	even

	def	cspaces
cspaces
	ai   r10, >FFF8
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	movb r1, r13
	jeq  L135
	clr  r9
	li   r14, cputc
L134
	li   r1, >20
	bl   *r14
	ai   r9, >100
	cb   r13, r9
	jh  L134
L135
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	b    *r11
	.size	cspaces, .-cspaces
	even

	def	menumakeborder
menumakeborder
	ai   r10, >FFEA
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	movb r1, r14
	movb r2, r9
	movb r3, @>E(r10)
	movb r4, r13
	movb r2, r1
	movb r3, r2
	ai   r2, >200
	bl   @windowsave
	srl  r14, 8
	mov  r14, @>A(r10)
	movb r9, r1
	srl  r1, 8
	mov  r1, @>14(r10)
	mov  r1, r14
	sla  r14, >5
	mov  @>A(r10), r1
	a    @gImage, r1
	a    r14, r1
	li   r2, >6
	mov  @vdpchar, r3
	bl   *r3
	jeq  0
	cb  r13, @$-1
	jeq  L139
	mov  @>A(r10), r15
	clr  r9
L140
	mov  @gImage, r5
	inc  r5
	a    r14, r5
	mov  r5, r1
	a    r15, r1
	li   r2, >1
	mov  @vdpchar, r3
	bl   *r3
	ai   r9, >100
	inc  r15
	cb   r13, r9
	jh  L140
L139
	movb r13, r2
	srl  r2, 8
	mov  @>A(r10), r1
	a    r2, r1
	mov  r1, @>C(r10)
	mov  r14, r1
	a    @gImage, r1
	mov  @>C(r10), r2
	a    r2, r1
	li   r2, >7
	mov  @vdpchar, r3
	bl   *r3
	movb @>E(r10), r1
	jne  JMP_42
	b    @L150
JMP_42
	mov  @>14(r10), r1
	inc  r1
	mov  r1, @>14(r10)
	mov  r1, r9
	sla  r9, >5
	clr  r14
	clr  r15
	mov  @>A(r10), r2
	inc  r2
	mov  r2, @>10(r10)
	mov  r1, @>12(r10)
L143
	mov  @>A(r10), r1
	a    @gImage, r1
	a    r9, r1
	li   r2, >2
	mov  @vdpchar, r3
	bl   *r3
	mov  @>10(r10), @conio_x
	mov  @>12(r10), r1
	a    r14, r1
	mov  r1, @conio_y
	movb r13, r1
	li   r2, cspaces
	bl   *r2
	mov  @>C(r10), r1
	a    @gImage, r1
	a    r9, r1
	li   r2, >3
	mov  @vdpchar, r3
	bl   *r3
	ai   r15, >100
	inc  r14
	ai   r9, >20
	movb @>E(r10), r1
	cb   r1, r15
	jh  L143
L142
	movb @>E(r10), r15
	srl  r15, 8
	mov  @>14(r10), r2
	a    r2, r15
	sla  r15, >5
	mov  @>A(r10), r1
	a    @gImage, r1
	a    r15, r1
	li   r2, >4
	mov  @vdpchar, r3
	bl   *r3
	jeq  0
	cb  r13, @$-1
	jeq  L144
	mov  @>A(r10), r14
	clr  r9
L145
	mov  @gImage, r2
	inc  r2
	a    r15, r2
	mov  r2, r1
	a    r14, r1
	clr  r2
	mov  @vdpchar, r3
	bl   *r3
	ai   r9, >100
	inc  r14
	cb   r13, r9
	jh  L145
L144
	mov  @>C(r10), r1
	a    @gImage, r1
	a    r15, r1
	li   r2, >5
	mov  @vdpchar, r3
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >E
	b    *r3
L150
	mov  @>14(r10), r2
	inc  r2
	mov  r2, @>14(r10)
	jmp  L142
	.size	menumakeborder, .-menumakeborder
	even

	def	cleararea
cleararea
	ai   r10, >FFF2
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	movb r3, r14
	movb r4, r15
	jeq  0
	cb  r3, @$-1
	jeq  L154
	srl  r1, 8
	mov  r1, @>A(r10)
	clr  r13
	clr  r9
	srl  r2, 8
	mov  r2, @>C(r10)
L153
	mov  @>A(r10), @conio_x
	mov  @>C(r10), r2
	a    r13, r2
	mov  r2, @conio_y
	movb r15, r1
	li   r2, cspaces
	bl   *r2
	ai   r9, >100
	inc  r13
	cb   r14, r9
	jh  L153
L154
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	.size	cleararea, .-cleararea
	even

	def	getkey
getkey
	ai   r10, >FFF2
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	mov  r1, @>A(r10)
	movb r2, @>C(r10)
L197
	mov  @seed.1473, r1
* Begin inline assembler code
* 227 "main.c" 1
	srl r1,1  
	jnc 1f    
	xor @random_mask.1474,r1 
	1:        
	
* 0 "" 2
* End of inline assembler code
	mov  r1, @seed.1473
	jeq  0
	cb  @joyinterface, @$-1
	jeq  L157
	movb @>C(r10), r1
	jne  L201
L157
	bl   @kbhit
	jeq  0
	cb  r1, @$-1
	jeq  JMP_43
	b    @L182
JMP_43
	clr  r5
	movb r1, r15
L181
	mov  @>A(r10), r2
	jmp  L186
L202
	inc  r2
L186
	movb *r2, r1
	movb r1, r3
	srl  r3, 8
	c    r3, r5
	jeq  L184
	jeq  0
	cb  r1, @$-1
	jne  L202
L185
	li   r1, >D00
	cb   r15, r1
	jeq  JMP_44
	b    @L197
JMP_44
	movb r15, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	b    @L203
L184
	ci   r2, 0
	jeq  L185
	jeq  0
	cb  r15, @$-1
	jne  JMP_45
	b    @L197
JMP_45
	movb r15, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	b    @L203
L201
	li   r1, >1
	li   r2, joystfast
	bl   *r2
	li   r1, >1
	li   r3, kscanfast
	bl   *r3
	movb @>8377, r13
	movb @>8376, r9
	movb @>8375, r14
	li   r1, >2
	li   r4, joystfast
	bl   *r4
	li   r1, >2
	li   r5, kscanfast
	bl   *r5
	movb @>8377, r2
	movb @>8376, r1
	movb @>8375, r3
	seto r4
	cb   r14, r4
	jne  JMP_46
	b    @L204
JMP_46
L158
	li   r15, >D00
	li   r5, >400
	cb   r13, r5
	jne  JMP_47
	b    @L205
JMP_47
L160
	li   r3, >400
	cb   r2, r3
	jne  JMP_48
	b    @L206
JMP_48
L162
	li   r4, >FC00
	cb   r13, r4
	jne  JMP_49
	b    @L163
JMP_49
	li   r5, >FC00
	cb   r2, r5
	jne  JMP_50
	b    @L163
JMP_50
L164
	li   r2, >FC00
	cb   r9, r2
	jne  JMP_51
	b    @L207
JMP_51
L165
	li   r3, >FC00
	cb   r1, r3
	jne  JMP_52
	b    @L208
JMP_52
L167
	li   r4, >400
	cb   r9, r4
	jne  JMP_53
	b    @L168
JMP_53
	li   r5, >400
	cb   r1, r5
	jne  JMP_54
	b    @L168
JMP_54
L213
	jeq  0
	cb  r15, @$-1
	jne  JMP_55
	b    @L157
JMP_55
L196
	li   r1, >1
	li   r2, joystfast
	bl   *r2
	li   r1, >1
	li   r3, kscanfast
	bl   *r3
	movb @>8377, r14
	movb @>8376, r13
	movb @>8375, r9
	li   r1, >2
	li   r4, joystfast
	bl   *r4
	li   r1, >2
	li   r5, kscanfast
	bl   *r5
	movb @>8377, r3
	movb @>8376, r2
	movb @>8375, r4
	seto r1
	cb   r9, r1
	jeq  L170
L199
	li   r1, >100
	li   r4, >400
	cb   r14, r4
	jeq  L209
L173
	li   r5, >400
	cb   r3, r5
	jne  JMP_56
	b    @L210
JMP_56
L175
	li   r4, >FC00
	cb   r14, r4
	jeq  L176
	li   r5, >FC00
	cb   r3, r5
	jeq  L176
L177
	li   r3, >FC00
	cb   r13, r3
	jeq  L211
L178
	li   r4, >FC00
	cb   r2, r4
	jne  JMP_57
	b    @L212
JMP_57
L180
	li   r5, >400
	cb   r13, r5
	jeq  L196
L179
	li   r3, >400
	cb   r2, r3
	jeq  L196
	li   r4, >100
	cb   r1, r4
	jne  JMP_58
	b    @L196
JMP_58
L183
	movb r15, r5
	srl  r5, 8
	b    @L181
L170
	clr  r1
	seto r5
	cb   r4, r5
	jne  L199
	li   r4, >400
	cb   r14, r4
	jne  L173
L209
	li   r1, >100
	li   r5, >FC00
	cb   r3, r5
	jne  L177
L176
	li   r1, >100
	li   r3, >FC00
	cb   r13, r3
	jne  L178
L211
	li   r1, >100
	jmp  L179
L204
	cb   r3, r4
	jeq  JMP_59
	b    @L158
JMP_59
	clr  r15
	li   r5, >400
	cb   r13, r5
	jeq  JMP_60
	b    @L160
JMP_60
L205
	li   r15, >900
	li   r5, >FC00
	cb   r2, r5
	jeq  JMP_61
	b    @L164
JMP_61
L163
	li   r15, >800
	li   r2, >FC00
	cb   r9, r2
	jeq  JMP_62
	b    @L165
JMP_62
L207
	li   r15, >A00
	li   r5, >400
	cb   r1, r5
	jeq  JMP_63
	b    @L213
JMP_63
L168
	li   r15, >B00
	b    @L196
L210
	li   r1, >100
	b    @L175
L212
	li   r1, >100
	b    @L180
L182
	bl   @cgetc
	movb r1, r15
	mov  @>A(r10), r5
	jeq  0
	cb  *r5, @$-1
	jeq  JMP_64
	b    @L183
JMP_64
	li   r5, >D
	li   r15, >D00
	b    @L181
L208
	li   r15, >A00
	b    @L167
L206
	li   r15, >900
	b    @L162
L203
	.size	getkey, .-getkey
LC1
	text 'Pawn?'
	byte 0
LC2
	text 'Dice=%d'
	byte 0
	even

	def	humanchoosepawn
humanchoosepawn
	ai   r10, >FFE8
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	movb r1, @>10(r10)
	mov  r2, r14
	mov  r10, r1
	ai   r1, >A
	li   r2, C.121.2599
	li   r3, >5
	bl   @memcpy
	li   r1, >1600
	li   r2, >600
	li   r3, >200
	li   r4, >900
	bl   @menumakeborder
	li   r1, >18
	li   r2, >7
	li   r3, LC1
	bl   @cputsxy
	li   r1, >18
	mov  r1, @conio_x
	li   r3, >8
	mov  r3, @conio_y
	ai   r10, >FFFC
	li   r5, LC2
	mov  r5, *r10
	movb @throw, r1
	srl  r1, 8
	mov  r1, @>2(r10)
	bl   @cprintf
	ai   r10, >4
	li   r9, >100
	cb   @>1(r14), r9
	jeq  L239
	cb   @>2(r14), r9
	jne  JMP_65
	b    @L241
JMP_65
	cb   @>3(r14), r9
	jne  JMP_66
	b    @L242
JMP_66
	cb   @>4(r14), r9
	jne  JMP_67
	b    @L219
JMP_67
	li   r9, >400
L239
	li   r1, pawnplace
	mov  r1, @>12(r10)
	li   r3, getkey
	mov  r3, @>14(r10)
L238
	li   r4, >300
L237
	movb @>10(r10), r1
	movb r9, r2
	li   r3, >100
	mov  r4, @>16(r10)
	mov  @>12(r10), r5
	bl   *r5
	mov  r10, r1
	ai   r1, >A
	li   r2, >100
	mov  @>14(r10), r3
	bl   *r3
	movb r1, r13
	movb @>10(r10), r1
	movb r9, r2
	clr  r3
	mov  @>12(r10), r5
	bl   *r5
	mov  @>16(r10), r4
	li   r1, >800
	cb   r13, r1
	jne  JMP_68
	b    @L220
JMP_68
	li   r3, >A00
	cb   r13, r3
	jeq  L220
L221
	li   r5, >900
	cb   r13, r5
	jeq  L222
	li   r1, >B00
	cb   r13, r1
	jeq  L222
	li   r2, >D00
	cb   r13, r2
	jeq  L224
L244
	cb   r9, r4
	jlt  L225
	jeq  L225
	clr  r9
L226
	movb r9, r2
	sra  r2, 8
L227
	a    r14, r2
	li   r3, >100
	cb   *r2, r3
	jeq  L237
	ab   r15, r9
	cb   r9, r4
	jlt  L228
	jeq  L228
L243
	clr  r9
L229
	movb r9, r1
	sra  r1, 8
L230
	a    r14, r1
	cb   *r1, r3
	jeq  L237
	ab   r15, r9
	cb   r9, r4
	jgt  L243
L228
	jeq  0
	cb  r9, @$-1
	jgt  L229
	jeq  L229
	li   r1, >3
	li   r9, >300
	jmp  L230
L222
	ai   r9, >100
	li   r15, >100
	li   r2, >D00
	cb   r13, r2
	jne  L244
L224
	bl   @windowrestore
	movb r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >10
	b    *r11
L220
	ai   r9, >FF00
	seto r15
	jmp  L221
L225
	jeq  0
	cb  r9, @$-1
	jgt  L226
	jeq  L226
	li   r2, >3
	li   r9, >300
	jmp  L227
L241
	li   r9, >200
	li   r5, pawnplace
	mov  r5, @>12(r10)
	li   r1, getkey
	mov  r1, @>14(r10)
	b    @L238
L219
	li   r9, >400
	li   r5, pawnplace
	mov  r5, @>12(r10)
	li   r1, getkey
	mov  r1, @>14(r10)
	b    @L238
L242
	li   r9, >300
	li   r3, pawnplace
	mov  r3, @>12(r10)
	li   r5, getkey
	mov  r5, @>14(r10)
	b    @L238
	.size	humanchoosepawn, .-humanchoosepawn
LC3
	text 'Key.'
	byte 0
LC4
	byte 0
	even

	def	dicethrow
dicethrow
	ai   r10, >FFF4
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	li   r1, >1600
	li   r2, >A00
	li   r3, >600
	li   r4, >700
	bl   @menumakeborder
	clr  r15
L247
	mov  @seed.1473, r1
* Begin inline assembler code
* 227 "main.c" 1
	srl r1,1  
	jnc 1f    
	xor @random_mask.1474,r1 
	1:        
	
* 0 "" 2
* End of inline assembler code
	mov  r1, @seed.1473
	mov  r1, r2
	clr  r1
	li   r3, >6
	div  r3, r1
	mov  r2, r1
	inc  r1
	mov  r1, r4
	swpb r4
	movb r4, r9
	srl  r9, 8
	dec  r9
	mov  r9, r13
	sla  r13, >2
	ai   r13, dicegraphics
	mov  r13, r14
	movb *r14+, r2
	mov  @gImage, r1
	ai   r1, >199
	srl  r2, 8
	mov  @vdpchar, r3
	mov  r4, @>A(r10)
	bl   *r3
	movb *r14, r2
	mov  @gImage, r1
	ai   r1, >19A
	srl  r2, 8
	mov  @vdpchar, r3
	bl   *r3
	mov  r9, r2
	a    r9, r2
	inc  r2
	a    r2, r2
	movb @dicegraphics(r2), r2
	mov  @gImage, r1
	ai   r1, >1B9
	srl  r2, 8
	mov  @vdpchar, r3
	bl   *r3
	movb @>3(r13), r2
	mov  @gImage, r1
	ai   r1, >1BA
	srl  r2, 8
	mov  @vdpchar, r3
	bl   *r3
	clr  r2
	mov  @>A(r10), r4
L246
* Begin inline assembler code
* 245 "main.c" 1
	clr r12
	tb 2
	jeq -4
	movb @>8802,r12
* 0 "" 2
* End of inline assembler code
	inc  r2
	ci   r2, >A
	jeq  JMP_69
	b    @L246
JMP_69
	ai   r15, >100
	li   r1, >A00
	cb   r15, r1
	jeq  JMP_70
	b    @L247
JMP_70
	li   r1, >18
	li   r2, >F
	li   r3, LC3
	mov  r4, @>A(r10)
	bl   @cputsxy
	li   r1, LC4
	li   r2, >100
	bl   @getkey
	bl   @windowrestore
	mov  @>A(r10), r4
	movb r4, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	inct r10
	b    *r11
	.size	dicethrow, .-dicethrow
LC5
	text 'Throw 3x'
	byte 0
LC6
	text '        '
	byte 0
LC7
	text 'No move'
	byte 0
	even

	def	turngeneric
turngeneric
	ai   r10, >FFE8
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	clr  r1
	movb r1, @>A(r10)
	movb r1, @>B(r10)
	movb r1, @>C(r10)
	movb r1, @>D(r10)
	movb @turnofplayernr, r1
	srl  r1, 8
	mov  r1, r3
	sla  r3, >2
	mov  r3, r2
	ai   r2, playerdata
	cb   @>3(r2), @>1(r2)
	jne  JMP_71
	b    @L330
JMP_71
L252
	li   r13, >100
	li   r1, cputsxy
	mov  r1, @>E(r10)
L257
	clr  r9
	li   r15, dicethrow
	li   r14, >600
L259
	bl   *r15
	movb r1, @throw
	cb   r1, r14
	jeq  L258
	ai   r9, >100
	cb   r13, r9
	jh  L259
L258
	li   r1, >17
	li   r2, >7
	li   r3, LC6
	mov  @>E(r10), r4
	bl   *r4
	movb @turnofplayernr, r1
	movb r1, r3
	srl  r3, 8
	mov  r3, r8
	sla  r8, >2
	mov  r8, r2
	ai   r2, playerdata
	movb @>3(r2), r4
	cb   r4, @>1(r2)
	jne  JMP_72
	b    @L331
JMP_72
L260
	clr  r14
L262
	mov  r3, r12
	ai   r12, np
	movb *r12, r15
	jgt  JMP_73
	jeq  JMP_73
	b    @L332
JMP_73
	jeq  0
	cb  r4, @$-1
	jne  JMP_74
	b    @L333
JMP_74
L265
	seto r2
	movb r2, *r12
L264
	jeq  0
	cb  r14, @$-1
	jeq  JMP_75
	b    @L266
JMP_75
	seto r4
	cb   r15, r4
	jne  JMP_76
	b    @L334
JMP_76
L267
	li   r9, >100
L291
	li   r3, >600
	cb   @throw, r3
	jne  JMP_77
	b    @L335
JMP_77
L293
	jeq  0
	cb  r9, @$-1
	jne  JMP_78
	b    @L294
JMP_78
	li   r13, >100
	cb   r14, r13
	jne  JMP_79
	b    @L294
JMP_79
	li   r14, pawnerase
	movb @turnofplayernr, r1
	movb r15, r2
	bl   *r14
	movb @turnofplayernr, r9
	movb r9, r12
	srl  r12, 8
	movb r15, r6
	sra  r6, 8
	mov  r12, r8
	sla  r8, >2
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	mov  r3, r4
	inc  r4
	movb *r4, r5
	movb *r3, r7
	cb   r7, r13
	jne  JMP_80
	b    @L336
JMP_80
L297
	movb r5, r3
	ab   @throw, r3
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	movb r3, @playerpos+1(r4)
L298
	jeq  0
	cb  r9, @$-1
	jeq  JMP_81
	b    @L299
JMP_81
	li   r4, >2700
	cb   r3, r4
	jle  JMP_82
	b    @L337
JMP_82
L304
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	movb @>1(r3), r3
L306
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	movb @playerpos(r4), r7
	li   r4, >100
	cb   r7, r4
	jne  JMP_83
	b    @L338
JMP_83
L307
	mov  r8, r4
	ai   r4, playerdata
	inc  r4
	movb *r4, r12
	movb r3, r0
	srl  r0, 8
	movb r12, r5
	srl  r5, 8
	ai   r5, >3
	c    r0, r5
	jne  JMP_84
	b    @L339
JMP_84
L308
	ci   r3, >27FF
	jle  L309
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	ai   r3, >D800
	movb r3, @playerpos+1(r4)
L309
	clr  r0
	a    r6, r8
	a    r8, r8
	ai   r8, playerpos
	mov  r8, r13
	inc  r13
	li   r12, >400
L310
	clr  r2
	clr  r5
	movb r0, r3
	srl  r3, >6
	andi r3, >FFFC
	jmp  L314
L311
	mov  r3, r1
	a    r2, r1
	a    r1, r1
	ai   r1, playerpos
	jeq  0
	cb  *r1, @$-1
	jne  L312
	jeq  0
	cb  *r8, @$-1
	jne  L312
	cb   @>1(r1), *r13
	jeq  L313
L312
	ai   r5, >100
	inc  r2
	cb   r5, r12
	jeq  L340
L314
	c    r6, r2
	jne  L311
	cb   r0, r9
	jne  L311
	ai   r5, >100
	inc  r2
	cb   r5, r12
	jne  L314
L340
	ai   r0, >100
	ci   r0, >3FF
	jle  L310
	clr  r5
	seto r0
L313
	seto r3
	cb   r0, r3
	jeq  JMP_85
	b    @L326
JMP_85
	li   r13, pawnplace
L316
	movb r9, r1
	movb r15, r2
	clr  r3
	bl   *r13
	movb @turnofplayernr, r1
	srl  r1, >6
	andi r1, >FFFC
	jeq  0
	cb  @playerdata(r1), @$-1
	jne  L317
	li   r1, >100
	cb   @autosavetoggle, r1
	jeq  L318
L317
	li   r1, >17
	li   r2, >7
	jmp  L327
L294
	li   r1, >17
	li   r2, >7
	li   r3, LC7
	mov  @>E(r10), r4
	bl   *r4
	li   r1, >17
	li   r2, >8
L327
	li   r3, LC3
	mov  @>E(r10), r4
	bl   *r4
	li   r1, LC4
	li   r2, >100
	bl   @getkey
L318
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >10
	b    *r11
L334
	movb @throw, r13
	movb r14, r2
	li   r0, >100
	sla  r3, >3
	ai   r3, playerpos
	mov  r3, @>10(r10)
	li   r9, >400
	movb r14, @>12(r10)
	mov  r12, r14
L285
	movb r2, r12
	srl  r12, 8
	mov  r8, r3
	a    r12, r3
	a    r3, r3
	ai   r3, playerpos
	movb *r3+, r4
	movb *r3, r5
	cb   r4, r0
	jne  JMP_86
	b    @L341
JMP_86
	movb r5, r7
	ab   r13, r7
	jeq  0
	cb  r4, @$-1
	jne  L272
	jeq  0
	cb  r1, @$-1
	jeq  JMP_87
	b    @L273
JMP_87
	li   r4, >2700
	cb   r7, r4
	jle  L279
	cb   r5, r4
	jh  JMP_88
	b    @L342
JMP_88
L279
	clr  r4
L275
	cb   r4, r0
	jne  JMP_89
	b    @L280
JMP_89
L272
	li   r3, >A
	a    r10, r3
	a    r12, r3
	li   r4, >100
	movb r4, *r3
	ab   r4, r2
L271
	cb   r2, r9
	jne  L285
	movb @>12(r10), r14
L266
	seto r3
	cb   r15, r3
	jeq  JMP_90
	b    @L267
JMP_90
	li   r9, >100
	cb   @>A(r10), r9
	jne  JMP_91
	b    @L286
JMP_91
	clr  r9
L287
	li   r3, >100
	cb   @>B(r10), r3
	jne  JMP_92
	b    @L343
JMP_92
L288
	li   r3, >100
	cb   @>C(r10), r3
	jne  JMP_93
	b    @L344
JMP_93
L289
	li   r3, >100
	cb   @>D(r10), r3
	jne  JMP_94
	b    @L345
JMP_94
L290
	ci   r9, >1FF
	jh  JMP_95
	b    @L291
JMP_95
	jeq  0
	cb  @playerdata(r8), @$-1
	jeq  JMP_96
	b    @L292
JMP_96
	mov  r10, r2
	ai   r2, >A
	bl   @humanchoosepawn
	movb r1, r15
	li   r3, >600
	cb   @throw, r3
	jeq  JMP_97
	b    @L293
JMP_97
L335
	li   r1, >100
	movb r1, @zv
	b    @L293
L333
	seto r15
	b    @L265
L331
	li   r2, >300
	cb   r13, r2
	jeq  JMP_98
	b    @L260
JMP_98
	clr  r14
	li   r2, >600
	cb   @throw, r2
	jne  JMP_99
	b    @L262
JMP_99
	li   r14, >100
	b    @L262
L330
	mov  r1, r2
	sla  r2, >3
	jeq  0
	cb  @playerpos(r2), @$-1
	jne  JMP_100
	b    @L346
JMP_100
	li   r13, >300
L254
	inc  r3
	a    r3, r3
	jeq  0
	cb  @playerpos(r3), @$-1
	jne  L255
	li   r13, >100
L255
	a    r1, r1
	inc  r1
	sla  r1, >2
	jeq  0
	cb  @playerpos(r1), @$-1
	jne  L256
	li   r13, >100
L256
	ai   r2, playerpos
	jeq  0
	cb  @>6(r2), @$-1
	jne  JMP_101
	b    @L252
JMP_101
	li   r1, >300
	cb   r13, r1
	jne  JMP_102
	b    @L325
JMP_102
	li   r2, cputsxy
	mov  r2, @>E(r10)
	b    @L257
L292
	mov  r10, r2
	ai   r2, >A
	bl   @computerchoosepawn
	movb r1, r15
	b    @L291
L332
	seto r15
	b    @L264
L326
	movb r0, r1
	movb r5, r2
	mov  r0, @>16(r10)
	mov  r5, @>14(r10)
	bl   *r14
	mov  @>16(r10), r0
	movb r0, r4
	sra  r4, 8
	mov  @>14(r10), r5
	movb r5, r3
	srl  r3, 8
	sla  r4, >2
	a    r4, r3
	a    r3, r3
	ai   r3, playerpos
	li   r1, >100
	movb r1, *r3+
	movb r5, *r3
	ai   r4, playerdata
	ab   r1, @>3(r4)
	li   r13, pawnplace
	movb r0, r1
	movb r5, r2
	clr  r3
	bl   *r13
	movb @turnofplayernr, r9
	b    @L316
L299
	li   r0, >100
	cb   r9, r0
	jne  L301
	li   r4, >900
	cb   r3, r4
	jh  JMP_103
	b    @L304
JMP_103
	cb   r5, r4
	jle  JMP_104
	b    @L304
JMP_104
	jeq  0
	cb  r7, @$-1
	jeq  JMP_105
	b    @L304
JMP_105
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	movb r9, *r3+
	li   r2, >FA00
	ab   r2, *r3
	b    @L304
L346
	li   r13, >100
	b    @L254
L337
	cb   r5, r4
	jle  JMP_106
	b    @L304
JMP_106
	jeq  0
	cb  r7, @$-1
	jeq  JMP_107
	b    @L304
JMP_107
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	li   r4, >100
	movb r4, *r3+
	li   r1, >DC00
	ab   r1, *r3
	b    @L304
L301
	li   r4, >200
	cb   r9, r4
	jeq  JMP_108
	b    @L303
JMP_108
	li   r4, >1300
	cb   r3, r4
	jh  JMP_109
	b    @L304
JMP_109
	cb   r5, r4
	jle  JMP_110
	b    @L304
JMP_110
	jeq  0
	cb  r7, @$-1
	jeq  JMP_111
	b    @L304
JMP_111
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	movb r0, *r3+
	li   r4, >F000
	ab   r4, *r3
	b    @L304
L341
	ci   r5, >3FF
	jh  L269
	li   r3, >600
	cb   r13, r3
	jeq  L347
L283
	ai   r2, >100
	b    @L271
L347
	movb r2, r15
	movb r2, *r14
	li   r2, >400
	b    @L271
L269
	movb r5, r7
	ab   r13, r7
L280
	ci   r7, >7FF
	jh  L283
	mov  @>10(r10), r6
	clr  r5
	jmp  L284
L282
	ai   r5, >100
	inct r6
	cb   r5, r9
	jne  JMP_112
	b    @L272
JMP_112
L284
	cb   r5, r2
	jeq  L282
	cb   *r6, r0
	jne  L282
	movb @>1(r6), r3
	cb   r3, r7
	jh  L282
	ci   r3, >3FF
	jle  L282
	ai   r2, >100
	b    @L271
L273
	cb   r1, r0
	jne  L276
	li   r4, >900
	cb   r7, r4
	jh  JMP_113
	b    @L279
JMP_113
	cb   r5, r4
	jle  JMP_114
	b    @L279
JMP_114
	ai   r7, >FA00
	movb r1, r4
	b    @L275
L339
	li   r5, >100
	cb   r7, r5
	jeq  JMP_115
	b    @L308
JMP_115
	ai   r12, >FF00
	movb r12, *r4
	b    @L308
L338
	ci   r3, >3FF
	jh  JMP_116
	b    @L307
JMP_116
	movb r3, @dp(r12)
	b    @L307
L336
	ci   r5, >3FF
	jle  JMP_117
	b    @L297
JMP_117
	clr  r1
	movb r1, *r3
	movb r9, r3
	ab   r9, r3
	movb r9, r0
	andi r0, >FF00
	sla  r0, >3
	ab   r0, r3
	movb r3, *r4
	mov  r8, r4
	ai   r4, playerdata
	seto r2
	ab   r2, @>3(r4)
	b    @L298
L276
	li   r4, >200
	cb   r1, r4
	jne  L278
	li   r4, >1300
	cb   r7, r4
	jh  JMP_118
	b    @L279
JMP_118
	cb   r5, r4
	jle  JMP_119
	b    @L279
JMP_119
	ai   r7, >F000
	li   r4, >100
	b    @L275
L345
	ab   r3, r9
	li   r15, >300
	b    @L290
L344
	ab   r3, r9
	li   r15, >200
	b    @L289
L343
	ab   r3, r9
	movb r3, r15
	b    @L288
L286
	clr  r15
	b    @L287
L342
	ai   r7, >DC00
	li   r4, >100
	b    @L275
L325
	li   r3, cputsxy
	mov  r3, @>E(r10)
	li   r1, >17
	li   r2, >7
	li   r3, LC5
	li   r4, cputsxy
	bl   *r4
	b    @L257
L278
	li   r4, >300
	cb   r1, r4
	jeq  JMP_120
	b    @L272
JMP_120
	li   r4, >1D00
	cb   r7, r4
	jh  JMP_121
	b    @L272
JMP_121
	cb   r5, r4
	jle  JMP_122
	b    @L272
JMP_122
	ai   r7, >E600
	b    @L280
L303
	li   r4, >300
	cb   r9, r4
	jeq  JMP_123
	b    @L304
JMP_123
	li   r4, >1D00
	cb   r3, r4
	jh  JMP_124
	b    @L306
JMP_124
	cb   r5, r4
	jle  JMP_125
	b    @L306
JMP_125
	jeq  0
	cb  r7, @$-1
	jeq  JMP_126
	b    @L306
JMP_126
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	ai   r4, playerpos
	movb r0, *r4+
	movb *r4, r3
	ai   r3, >E600
	movb r3, *r4
	b    @L306
	.size	turngeneric, .-turngeneric
LC8
	text 'TIPI not enabled!'
	byte 0
LC9
	text 'Press key.'
	byte 0
	even

	def	tipinotenabledmessage
tipinotenabledmessage
	ai   r10, >FFFC
	mov  r11, *r10
	mov  r9, @>2(r10)
	li   r1, >A00
	li   r2, >500
	movb r2, r3
	li   r4, >1400
	bl   @menumakeborder
	li   r9, cputsxy
	li   r1, >C
	li   r2, >7
	li   r3, LC8
	bl   *r9
	li   r1, >C
	mov  r1, @conio_x
	li   r1, >8
	mov  r1, @conio_y
	li   r1, >C
	li   r2, >9
	li   r3, LC9
	bl   *r9
	li   r1, LC4
	li   r2, >100
	bl   @getkey
	mov  *r10+, r11
	mov  *r10+, r9
	b    @windowrestore
	.size	tipinotenabledmessage, .-tipinotenabledmessage
LC10
	text 'File error!'
	byte 0
LC11
	text 'Error nr.: %2X'
	byte 0
	even

	def	fileerrormessage
fileerrormessage
	ai   r10, >FFFA
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	movb r1, r13
	li   r1, >A00
	li   r2, >500
	li   r3, >600
	li   r4, >1400
	bl   @menumakeborder
	li   r9, cputsxy
	li   r1, >C
	li   r2, >7
	li   r3, LC10
	bl   *r9
	li   r1, >C
	mov  r1, @conio_x
	li   r1, >8
	mov  r1, @conio_y
	ai   r10, >FFFC
	li   r1, LC11
	mov  r1, *r10
	movb r13, r1
	srl  r1, 8
	mov  r1, @>2(r10)
	bl   @cprintf
	ai   r10, >4
	li   r1, >C
	li   r2, >A
	li   r3, LC9
	bl   *r9
	li   r1, LC4
	li   r2, >100
	bl   @getkey
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    @windowrestore
	.size	fileerrormessage, .-fileerrormessage
LC12
	text ' %s '
	byte 0
	even

	def	menupulldown
menupulldown
	ai   r10, >FFDE
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	movb r1, r14
	movb r2, r13
	movb r3, @>20(r10)
	movb r3, r9
	srl  r9, 8
	dec  r9
	mov  r9, r1
	ai   r1, pulldownmenuoptions
	mov  r1, @>14(r10)
	movb r2, r1
	mov  @>14(r10), r3
	movb *r3, r2
	ai   r2, >400
	bl   @windowsave
	movb @>20(r10), r1
	cb   r1, @menubaroptions
	jle  JMP_127
	b    @L353
JMP_127
	srl  r14, 8
	mov  r14, @>10(r10)
	srl  r13, 8
	mov  r13, @>1C(r10)
	mov  r9, r2
	sla  r2, >4
	mov  r9, r1
	sla  r1, >6
	a    r1, r2
	ai   r2, pulldownmenutitles
	mov  r2, @>1E(r10)
	li   r3, strlen
	mov  r3, @>18(r10)
L358
	mov  @>14(r10), r1
	movb *r1, r4
	jne  JMP_128
	b    @L380
JMP_128
	mov  @>1C(r10), r2
	inc  r2
	mov  r2, @>12(r10)
	mov  @>10(r10), r3
	inc  r3
	mov  r3, @>1A(r10)
	mov  r9, r1
	sla  r1, >2
	a    r9, r1
	mov  r1, @>16(r10)
	clr  r15
L359
	movb r15, r9
	srl  r9, 8
	mov  @>12(r10), r14
	a    r9, r14
	mov  r14, r13
	sla  r13, >5
	mov  @>10(r10), r1
	a    @gImage, r1
	a    r13, r1
	li   r2, >2
	mov  @vdpchar, r3
	bl   *r3
	mov  @>1A(r10), @conio_x
	mov  r14, @conio_y
	mov  @>16(r10), r3
	a    r3, r9
	sla  r9, >4
	ai   r9, pulldownmenutitles
	ai   r10, >FFFC
	li   r1, LC12
	mov  r1, *r10
	mov  r9, @>2(r10)
	li   r2, cprintf
	bl   *r2
	ai   r10, >4
	mov  r9, r1
	mov  @>18(r10), r3
	bl   *r3
	mov  @gImage, r2
	inct r2
	mov  @>10(r10), r3
	a    r3, r2
	a    r1, r2
	mov  r2, r1
	a    r13, r1
	li   r2, >2
	mov  @vdpchar, r3
	bl   *r3
	ai   r15, >100
	mov  @>14(r10), r1
	movb *r1, r4
	cb   r4, r15
	jh  L359
L355
	mov  @>10(r10), r1
	a    @gImage, r1
	srl  r4, 8
	mov  @>12(r10), r2
	a    r2, r4
	sla  r4, >5
	a    r4, r1
	li   r2, >4
	mov  @vdpchar, r4
	bl   *r4
	clr  r9
	mov  @>1E(r10), r14
	mov  @>18(r10), r15
	mov  @>14(r10), r13
	jmp  L360
L361
	mov  @gImage, r2
	inc  r2
	mov  @>10(r10), r3
	a    r3, r2
	movb *r13, r3
	srl  r3, 8
	mov  @>12(r10), r1
	a    r1, r3
	sla  r3, >5
	a    r3, r2
	mov  r2, r1
	a    r4, r1
	clr  r2
	mov  @vdpchar, r3
	bl   *r3
	ai   r9, >100
L360
	mov  r14, r1
	bl   *r15
	inc  r1
	movb r9, r4
	srl  r4, 8
	c    r1, r4
	jgt  L361
	jeq  L361
	mov  r10, r1
	ai   r1, >A
	li   r2, updownenter
	bl   @strcpy
	movb @>20(r10), r2
	cb   r2, @menubaroptions
	jh  JMP_129
	b    @L381
JMP_129
L362
	li   r13, >100
	li   r15, >1
L375
	mov  @>1C(r10), r9
	a    r15, r9
	sla  r9, >5
	mov  @gImage, r1
	inc  r1
	mov  @>10(r10), r3
	a    r3, r1
	a    r9, r1
	li   r2, >B1
	mov  @vdpchar, r3
	bl   *r3
	mov  r10, r1
	ai   r1, >A
	movb @joyinterface, r2
	li   r3, getkey
	bl   *r3
	movb r1, r14
	movb r1, r2
	ai   r2, >F800
	ci   r2, >5FF
	jh  L375
	srl  r2, 8
	a    r2, r2
	mov  @L367(r2), r3
	b    *r3
	even
L367
		data		L364
		data		L364
		data		L365
		data		L365
		data		L375
		data		L366
L364
	movb r1, r13
	ai   r13, >A00
L366
	bl   @windowrestore
	movb r13, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >1A
	b    *r11
L365
	mov  @gImage, r1
	inc  r1
	mov  @>10(r10), r2
	a    r2, r1
	a    r9, r1
	li   r2, >20
	mov  @vdpchar, r3
	bl   *r3
	li   r3, >B00
	cb   r14, r3
	jeq  L382
	ai   r13, >100
	mov  @>14(r10), r2
	cb   r13, *r2
	jh  L362
L379
	movb r13, r15
	srl  r15, 8
	jmp  L375
L382
	ai   r13, >FF00
	jne  L379
	mov  @>14(r10), r1
	movb *r1, r13
	movb r13, r15
	srl  r15, 8
	jmp  L375
L381
	mov  r10, r1
	ai   r1, >A
	li   r2, leftright
	bl   @strcat
	b    @L362
L353
	srl  r14, 8
	mov  r14, @>10(r10)
	srl  r13, 8
	mov  r13, @>1C(r10)
	mov  r13, r14
	sla  r14, >5
	mov  @>10(r10), r1
	a    @gImage, r1
	a    r14, r1
	li   r2, >6
	mov  @vdpchar, r3
	bl   *r3
	mov  r9, r3
	sla  r3, >4
	mov  r9, r1
	sla  r1, >6
	a    r1, r3
	ai   r3, pulldownmenutitles
	mov  r3, @>1E(r10)
	clr  r13
	li   r1, strlen
	mov  r1, @>18(r10)
	mov  r3, r15
	mov  r9, @>12(r10)
	mov  r14, r9
	mov  r1, r14
	jmp  L356
L357
	mov  @gImage, r2
	inc  r2
	mov  @>10(r10), r1
	a    r1, r2
	a    r9, r2
	mov  r2, r1
	a    r3, r1
	li   r2, >1
	mov  @vdpchar, r3
	bl   *r3
	ai   r13, >100
L356
	mov  r15, r1
	bl   *r14
	inc  r1
	movb r13, r3
	srl  r3, 8
	c    r1, r3
	jgt  L357
	jeq  L357
	mov  @>12(r10), r9
	b    @L358
L380
	mov  @>1C(r10), r2
	inc  r2
	mov  r2, @>12(r10)
	b    @L355
	.size	menupulldown, .-menupulldown
LC13
	text '%s has won!'
	byte 0
LC14
	text 'Your choice?'
	byte 0
	even

	def	playerwins
playerwins
	ai   r10, >FFF6
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	li   r1, >300
	li   r2, >500
	li   r3, >A00
	li   r4, >1900
	bl   @menumakeborder
	li   r1, >5
	mov  r1, @conio_x
	li   r1, >7
	mov  r1, @conio_y
	ai   r10, >FFFC
	li   r1, LC13
	mov  r1, *r10
	movb @turnofplayernr, r2
	srl  r2, 8
	mov  r2, r1
	sla  r1, >3
	a    r2, r1
	ai   r1, playername
	mov  r1, @>2(r10)
	bl   @cprintf
	ai   r10, >4
	li   r1, >5
	li   r2, >9
	li   r3, LC14
	bl   @cputsxy
	li   r13, menupulldown
	li   r9, >200
	li   r14, >300
	li   r15, >100
L387
	li   r1, >A00
	movb r1, r2
	li   r3, >700
	bl   *r13
	cb   r1, r9
	jeq  L390
	cb   r1, r14
	jeq  L391
	cb   r1, r15
	jne  L385
	jeq  0
	cb  @playerdata+1, @$-1
	jne  L385
	jeq  0
	cb  @playerdata+5, @$-1
	jne  L385
	jeq  0
	cb  @playerdata+9, @$-1
	jne  L385
	jeq  0
	cb  @playerdata+13, @$-1
	jeq  L387
L385
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @windowrestore
L391
	li   r1, >100
	movb r1, @endofgameflag
	movb r1, @zv
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @windowrestore
L390
	li   r1, >300
	movb r1, @endofgameflag
	bl   @gamereset
	li   r1, >100
	movb r1, @zv
	jmp  L385
	.size	playerwins, .-playerwins
LC15
	text 'Are you sure?'
	byte 0
	even

	def	areyousure
areyousure
	ai   r10, >FFFC
	mov  r11, *r10
	mov  r9, @>2(r10)
	li   r1, >A00
	li   r2, >500
	li   r3, >600
	li   r4, >1400
	bl   @menumakeborder
	li   r1, >C
	li   r2, >7
	li   r3, LC15
	bl   @cputsxy
	li   r1, >1400
	li   r2, >800
	li   r3, >500
	bl   @menupulldown
	movb r1, r9
	bl   @windowrestore
	movb r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	b    *r11
	.size	areyousure, .-areyousure
	even

	def	menumain
menumain
	ai   r10, >FFEC
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	mov  r10, r1
	ai   r1, >A
	li   r2, C.56.1994
	li   r3, >4
	bl   @memcpy
	li   r1, >100
	movb r1, @>E(r10)
	li   r2, >1
	mov  r2, @>12(r10)
L410
	mov  @>12(r10), r15
	dec  r15
	mov  r15, r3
	a    r15, r3
	mov  r3, @>10(r10)
	mov  r3, r14
	a    r15, r14
	sla  r14, >2
	ai   r14, menubartitles
	clr  r9
	mov  r15, r13
	ai   r13, menubarcoords
	jmp  L395
L396
	mov  @gImage, r3
	ai   r3, >20
	movb *r13, r2
	srl  r2, 8
	a    r2, r3
	mov  r3, r1
	a    r4, r1
	clr  r2
	mov  @vdpchar, r3
	bl   *r3
	ai   r9, >100
L395
	mov  r14, r1
	li   r4, strlen
	bl   *r4
	movb r9, r4
	srl  r4, 8
	c    r4, r1
	jlt  L396
	mov  r10, r1
	ai   r1, >A
	movb @joyinterface, r2
	li   r3, getkey
	bl   *r3
	movb r1, r9
	movb *r13, r2
	srl  r2, 8
	mov  r2, @conio_x
	li   r4, >1
	mov  r4, @conio_y
	mov  r14, r1
	li   r2, strlen
	bl   *r2
	swpb r1
	li   r3, cspaces
	bl   *r3
	li   r4, >800
	cb   r9, r4
	jne  JMP_130
	b    @L414
JMP_130
	li   r1, >900
	cb   r9, r1
	jne  JMP_131
	b    @L415
JMP_131
	li   r4, >D00
	cb   r9, r4
	jne  L410
	movb *r13, r14
	movb r14, r9
	ai   r9, >FF00
	mov  r15, r5
	sla  r5, >4
	mov  r15, r4
	sla  r4, >6
	a    r4, r5
	mov  r5, r1
	ai   r1, pulldownmenutitles
	li   r2, strlen
	bl   *r2
	mov  r1, r13
	movb r9, r4
	srl  r4, 8
	a    r1, r4
	ci   r4, >26
	jlt  L401
	jeq  L401
	mov  @>10(r10), r4
	a    r15, r4
	sla  r4, >2
	mov  r4, r1
	ai   r1, menubartitles
	li   r3, strlen
	bl   *r3
	movb r14, r2
	srl  r2, 8
	s    r13, r2
	a    r1, r2
	mov  r2, r9
	swpb r9
L401
	movb r9, r1
	clr  r2
	movb @>E(r10), r3
	li   r4, menupulldown
	bl   *r4
	li   r2, >1200
	cb   r1, r2
	jne  JMP_132
	b    @L416
JMP_132
	li   r3, >1300
	cb   r1, r3
	jeq  L417
	jeq  0
	cb  r1, @$-1
	jne  JMP_133
	b    @L410
JMP_133
	movb @>E(r10), r2
	movb r2, r3
	ab   r2, r2
	andi r3, >FF00
	sla  r3, >3
	ab   r3, r2
	ab   r2, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >C
	b    *r11
L414
	movb @>E(r10), r1
	ai   r1, >FF00
	movb r1, @>E(r10)
	jne  L413
	movb @menubaroptions, r3
	movb r3, @>E(r10)
	movb r3, r4
	srl  r4, 8
	mov  r4, @>12(r10)
	b    @L410
L415
	movb @>E(r10), r2
	ai   r2, >100
	movb r2, @>E(r10)
	cb   r2, @menubaroptions
	jh  L400
	movb r2, r3
	srl  r3, 8
	mov  r3, @>12(r10)
	b    @L410
L412
	movb @menubaroptions, r1
	movb r1, @>E(r10)
L413
	movb r1, r2
	srl  r2, 8
	mov  r2, @>12(r10)
	b    @L410
L400
	li   r2, >100
	movb r2, @>E(r10)
	li   r3, >1
	mov  r3, @>12(r10)
	b    @L410
L417
	movb @>E(r10), r4
	ai   r4, >100
	movb r4, @>E(r10)
	cb   r4, @menubaroptions
	jh  L404
	movb r4, r1
	srl  r1, 8
	mov  r1, @>12(r10)
	b    @L410
L416
	movb @>E(r10), r3
	ai   r3, >FF00
	movb r3, @>E(r10)
	jeq  L412
	movb r3, r4
	srl  r4, 8
	mov  r4, @>12(r10)
	b    @L410
L404
	li   r4, >100
	movb r4, @>E(r10)
	li   r1, >1
	mov  r1, @>12(r10)
	b    @L410
	.size	menumain, .-menumain
	even

	def	input
input
	ai   r10, >FF9C
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	movb r1, r15
	movb r2, r5
	mov  r3, @>50(r10)
	movb r4, @>58(r10)
	mov  r3, r1
	mov  r5, @>62(r10)
	li   r2, strlen
	bl   *r2
	mov  r1, r14
	mov  r10, r1
	ai   r1, >A
	clr  r2
	li   r3, >46
	bl   @memset
	li   r5, >2003
	movb r5, @>A(r10)
	swpb r5
	movb r5, @>B(r10)
	li   r9, strcat
	mov  r10, r1
	ai   r1, >A
	li   r2, numbers
	bl   *r9
	mov  r10, r1
	ai   r1, >A
	li   r2, letters
	bl   *r9
	mov  r10, r1
	ai   r1, >A
	li   r2, updownenter
	bl   *r9
	mov  r10, r1
	ai   r1, >A
	li   r2, leftright
	bl   *r9
	movb @>58(r10), r13
	srl  r13, 8
	mov  @>62(r10), r5
	srl  r5, 8
	mov  r5, @>54(r10)
	srl  r15, 8
	mov  r15, @>52(r10)
	mov  r5, r1
	sla  r1, >5
	mov  r1, @>56(r10)
	clr  r9
	clr  r6
	mov  r1, r15
	mov  r14, @>5A(r10)
	mov  @>52(r10), r14
L419
	mov  r14, r1
	a    @gImage, r1
	a    r15, r1
	a    r6, r1
	li   r2, >1A
	mov  @vdpchar, r3
	bl   *r3
	ai   r9, >100
	movb r9, r6
	srl  r6, 8
	c    r6, r13
	jlt  L419
	jeq  L419
	mov  @>5A(r10), r14
	swpb r14
	mov  @>52(r10), r1
	mov  @>54(r10), r2
	mov  @>50(r10), r3
	li   r4, cputsxy
	bl   *r4
	mov  @>50(r10), r1
	li   r2, strlen
	bl   *r2
	mov  @>52(r10), r5
	a    @gImage, r5
	mov  @>56(r10), r3
	a    r3, r5
	a    r5, r1
	li   r2, >19
	mov  @vdpchar, r6
	bl   *r6
	movb r14, r9
	mov  @>50(r10), r14
	mov  @>52(r10), r15
	mov  r10, r1
	ai   r1, >A
	clr  r2
	li   r4, getkey
	bl   *r4
	movb r1, r4
	ai   r4, >FD00
	ci   r4, >AFF
	jle  L446
L421
	movb @>58(r10), r3
	cb   r9, r3
	jhe  JMP_134
	b    @L447
JMP_134
L428
	movb r9, r13
L431
	movb r13, r9
L448
	mov  r10, r1
	ai   r1, >A
	clr  r2
	li   r4, getkey
	bl   *r4
	movb r1, r4
	ai   r4, >FD00
	ci   r4, >AFF
	jh  L421
L446
	srl  r4, 8
	a    r4, r4
	mov  @L427(r4), r3
	b    *r3
	even
L427
		data		L422
		data		L423
		data		L421
		data		L421
		data		L421
		data		L424
		data		L425
		data		L421
		data		L421
		data		L421
		data		L426
L426
	mov  @>50(r10), r1
	li   r4, strlen
	bl   *r4
	mov  r1, r9
	andi r9, >FF
	mov  @>50(r10), r5
	a    r9, r5
	clr  r1
	movb r1, *r5
	mov  @>52(r10), @conio_x
	mov  @>54(r10), @conio_y
	movb @>58(r10), r1
	ai   r1, >100
	bl   @cspaces
	mov  @>52(r10), r1
	mov  @>54(r10), r2
	mov  @>50(r10), r3
	li   r4, cputsxy
	bl   *r4
	mov  r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >5C
	b    *r11
L425
	mov  r14, r1
	li   r3, strlen
	bl   *r3
	movb r9, r4
	srl  r4, 8
	c    r4, r1
	jgt  L428
	jeq  L428
	movb @>58(r10), r4
	cb   r9, r4
	jhe  L428
	movb r9, r13
	ai   r13, >100
	movb r13, r9
	srl  r9, 8
	mov  r9, r5
	a    r15, r5
	mov  r5, r1
	dec  r1
	mov  r1, @conio_x
	mov  @>54(r10), @conio_y
	mov  r14, r4
	a    r9, r4
	movb @>FFFF(r4), r4
	movb r4, r1
	srl  r1, 8
	mov  r5, @>62(r10)
	li   r3, cputc
	bl   *r3
	mov  r15, r4
	a    @gImage, r4
	mov  @>56(r10), r1
	a    r1, r4
	mov  r4, r1
	a    r9, r1
	li   r2, >19
	mov  @vdpchar, r3
	bl   *r3
	mov  @>62(r10), @conio_x
	mov  @>54(r10), @conio_y
	movb r13, r9
	b    @L448
L424
	jeq  0
	cb  r9, @$-1
	jne  JMP_135
	b    @L428
JMP_135
	movb r9, r13
	ai   r13, >FF00
	movb r13, r9
	srl  r9, 8
	mov  r15, r4
	a    @gImage, r4
	mov  @>56(r10), r2
	a    r2, r4
	mov  r4, r1
	a    r9, r1
	li   r2, >19
	mov  @vdpchar, r4
	bl   *r4
	mov  @vdpchar, r3
	mov  @gImage, r1
	mov  r14, r4
	a    r9, r4
	movb @>1(r4), r5
	jeq  JMP_136
	b    @L435
JMP_136
	li   r2, >1A
L436
	mov  r1, r4
	inc  r4
	a    r15, r4
	mov  @>56(r10), r1
	a    r1, r4
	mov  r4, r1
	a    r9, r1
	bl   *r3
	a    r15, r9
	mov  r9, @conio_x
	mov  @>54(r10), @conio_y
	movb r13, r9
	b    @L448
L423
	mov  r14, r1
	li   r4, strlen
	bl   *r4
	mov  r1, r4
	swpb r4
	movb @>58(r10), r1
	cb   r1, r4
	jh  JMP_137
	b    @L428
JMP_137
	jeq  0
	cb  r4, @$-1
	jne  JMP_138
	b    @L428
JMP_138
	cb   r9, r4
	jl  JMP_139
	b    @L428
JMP_139
	ai   r4, >100
	cb   r9, r4
	jh  L432
	movb r4, r5
	srl  r5, 8
	a    r14, r5
	movb *r5, @>1(r5)
	jeq  0
	cb  r4, @$-1
	jne  L443
	jmp  L432
L434
	movb r4, r1
	srl  r1, 8
	a    r14, r1
	movb *r1, @>1(r1)
	jeq  0
	cb  r4, @$-1
	jeq  L432
L443
	ai   r4, >FF00
	cb   r9, r4
	jle  L434
L432
	movb r9, r13
	srl  r13, 8
	mov  r14, r4
	a    r13, r4
	li   r2, >2000
	movb r2, *r4
	mov  r15, r1
	mov  @>54(r10), r2
	mov  r14, r3
	li   r4, cputsxy
	bl   *r4
	a    r15, r13
	mov  r13, @conio_x
	mov  @>54(r10), @conio_y
	movb r9, r13
	movb r13, r9
	b    @L448
L422
	jeq  0
	cb  r9, @$-1
	jne  JMP_140
	b    @L428
JMP_140
	movb r9, r13
	ai   r13, >FF00
	movb r13, r1
	srl  r1, 8
	mov  r1, @>5A(r10)
	a    r15, r1
	mov  r1, @>60(r10)
	mov  @>54(r10), r2
	li   r3, >20
	li   r4, cputcxy
	bl   *r4
	mov  @>5A(r10), r1
	inc  r1
	a    r14, r1
	mov  r1, @>5C(r10)
	movb *r1, r2
	mov  @>5A(r10), r4
	a    r14, r4
	movb r2, *r4
	mov  @vdpchar, r5
	mov  r15, r1
	a    @gImage, r1
	mov  @>56(r10), r3
	a    r3, r1
	mov  @>5A(r10), r4
	a    r4, r1
	jeq  0
	cb  r2, @$-1
	jeq  L429
	movb r13, @>5E(r10)
	mov  r3, r13
L440
	srl  r2, 8
	bl   *r5
	movb r9, r3
	srl  r3, 8
	mov  r14, r1
	a    r3, r1
	movb @>1(r1), r2
	movb r2, *r1
	mov  @vdpchar, r5
	mov  r15, r1
	a    @gImage, r1
	a    r13, r1
	a    r3, r1
	ai   r9, >100
	jeq  0
	cb  r2, @$-1
	jne  L440
	movb @>5E(r10), r13
L429
	li   r2, >1A
	bl   *r5
	mov  r15, r4
	a    @gImage, r4
	mov  @>56(r10), r2
	a    r2, r4
	mov  @>5A(r10), r1
	a    r4, r1
	li   r2, >19
	mov  @vdpchar, r4
	bl   *r4
	mov  @vdpchar, r3
	mov  @gImage, r5
	mov  @>5C(r10), r1
	movb *r1, r4
	jeq  L449
	movb r4, r2
	srl  r2, 8
	inc  r5
	a    r15, r5
	mov  @>56(r10), r1
	a    r1, r5
	mov  @>5A(r10), r1
	a    r5, r1
	bl   *r3
	mov  @>60(r10), @conio_x
	mov  @>54(r10), @conio_y
L450
	movb r13, r9
	b    @L448
L447
	movb r9, r13
	srl  r13, 8
	mov  r14, r4
	a    r13, r4
	movb *r4, r3
	movb r1, *r4
	mov  r13, r4
	a    r15, r4
	mov  r4, @conio_x
	mov  @>54(r10), @conio_y
	srl  r1, 8
	mov  r3, @>62(r10)
	li   r4, cputc
	bl   *r4
	mov  @gImage, r4
	inc  r4
	a    r15, r4
	mov  @>56(r10), r1
	a    r1, r4
	mov  r4, r1
	a    r13, r1
	li   r2, >19
	mov  @vdpchar, r4
	bl   *r4
	movb r9, r13
	ai   r13, >100
	mov  @>62(r10), r3
	jeq  0
	cb  r3, @$-1
	jeq  JMP_141
	b    @L431
JMP_141
	movb r13, r4
	srl  r4, 8
	a    r14, r4
	movb r3, @>1(r4)
	movb r13, r9
	b    @L448
L449
	li   r2, >1A
	inc  r5
	a    r15, r5
	mov  @>56(r10), r1
	a    r1, r5
	mov  @>5A(r10), r1
	a    r5, r1
	bl   *r3
	mov  @>60(r10), @conio_x
	mov  @>54(r10), @conio_y
	jmp  L450
L435
	movb r5, r2
	srl  r2, 8
	b    @L436
	.size	input, .-input
LC16
	text 'Computer plays player %d?'
	byte 0
LC17
	text 'Input name player %d:    '
	byte 0
	even

	def	inputofnames
inputofnames
	ai   r10, >FFF6
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	li   r1, >200
	li   r2, >800
	li   r3, >600
	li   r4, >1C00
	bl   @menumakeborder
	li   r14, playername
	li   r13, playerdata
	clr  r9
	li   r15, cprintf
L454
	li   r1, >4
	mov  r1, @conio_x
	li   r2, >A
	mov  r2, @conio_y
	inc  r9
	ai   r10, >FFFC
	li   r4, LC16
	mov  r4, *r10
	mov  r9, @>2(r10)
	bl   *r15
	ai   r10, >4
	li   r1, >1400
	li   r2, >B00
	li   r3, >500
	li   r5, menupulldown
	bl   *r5
	li   r2, >100
	cb   r1, r2
	jeq  L457
	clr  r4
	movb r4, *r13
L453
	li   r5, >4
	mov  r5, @conio_x
	li   r1, >A
	mov  r1, @conio_y
	ai   r10, >FFFC
	li   r2, LC17
	mov  r2, *r10
	mov  r9, @>2(r10)
	bl   *r15
	ai   r10, >4
	li   r1, >400
	li   r2, >C00
	mov  r14, r3
	li   r4, >800
	li   r5, input
	bl   *r5
	ai   r14, >9
	ai   r13, >4
	ci   r9, >4
	jne  L454
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @windowrestore
L457
	movb r2, *r13
	jmp  L453
	.size	inputofnames, .-inputofnames
	even

	def	printcentered
printcentered
	ai   r10, >FFFA
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r1, r9
	movb r4, r13
	srl  r2, 8
	mov  r2, @conio_x
	srl  r3, 8
	mov  r3, @conio_y
	bl   @strlen
	mov  r1, r2
	movb r13, r4
	srl  r4, 8
	c    r1, r4
	jlt  L462
	mov  r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    @cputs
L462
	s    r4, r2
	neg  r2
	jlt  L463
	sra  r2, >1
	dec  r2
	mov  r2, r1
	swpb r1
	bl   @cspaces
L464
	mov  r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    @cputs
L463
	inc  r2
	sra  r2, >1
	dec  r2
	mov  r2, r1
	swpb r1
	bl   @cspaces
	jmp  L464
	.size	printcentered, .-printcentered
LC18
	text 'L U D O'
	byte 0
LC19
	text 'Written by Xander Mol'
	byte 0
LC20
	text 'Converted TI-99/4a, 2021'
	byte 0
LC21
	text 'From Commodore 128 1992'
	byte 0
LC22
	text 'Build with/using code of'
	byte 0
LC23
	text 'TMS9900-GCC by Insomnia'
	byte 0
LC24
	text 'Libti99 lib by Tursi'
	byte 0
LC25
	text 'Jedimatt42 help/code'
	byte 0
LC26
	text 'Press a key.'
	byte 0
	even

	def	informationcredits
informationcredits
	ai   r10, >FFDE
	mov  r11, *r10
	mov  r9, @>2(r10)
	mov  r10, r1
	ai   r1, >4
	clr  r2
	li   r3, >1E
	bl   @memset
	li   r3, >7631
	movb r3, @>4(r10)
	swpb r3
	movb r3, @>5(r10)
	li   r1, >3900
	movb r1, @>6(r10)
	movb r1, @>7(r10)
	li   r2, >202D
	movb r2, @>8(r10)
	swpb r2
	movb r2, @>9(r10)
	li   r1, >2032
	movb r1, @>A(r10)
	swpb r1
	movb r1, @>B(r10)
	li   r9, >3032
	movb r9, @>C(r10)
	swpb r9
	movb r9, @>D(r10)
	li   r0, >3130
	movb r0, @>E(r10)
	swpb r0
	movb r0, @>F(r10)
	li   r12, >3332
	movb r12, @>10(r10)
	swpb r12
	movb r12, @>11(r10)
	li   r8, >342D
	movb r8, @>12(r10)
	swpb r8
	movb r8, @>13(r10)
	li   r7, >3137
	movb r7, @>14(r10)
	swpb r7
	movb r7, @>15(r10)
	li   r6, >3137
	movb r6, @>16(r10)
	swpb r6
	movb r6, @>17(r10)
	clr  r1
	li   r2, >500
	li   r3, >E00
	li   r4, >1E00
	bl   @menumakeborder
	li   r9, printcentered
	li   r1, LC18
	li   r2, >200
	li   r3, >700
	li   r4, >1C00
	bl   *r9
	mov  r10, r1
	ai   r1, >4
	li   r2, >200
	li   r3, >800
	li   r4, >1C00
	bl   *r9
	li   r1, LC19
	li   r2, >200
	li   r3, >A00
	li   r4, >1C00
	bl   *r9
	li   r1, LC20
	li   r2, >200
	li   r3, >B00
	li   r4, >1C00
	bl   *r9
	li   r1, LC21
	li   r2, >200
	li   r3, >C00
	li   r4, >1C00
	bl   *r9
	li   r1, LC22
	li   r2, >200
	li   r3, >E00
	li   r4, >1C00
	bl   *r9
	li   r1, LC23
	li   r2, >200
	li   r3, >F00
	li   r4, >1C00
	bl   *r9
	li   r1, LC24
	li   r2, >200
	li   r3, >1000
	li   r4, >1C00
	bl   *r9
	li   r1, LC25
	li   r2, >200
	li   r3, >1100
	li   r4, >1C00
	bl   *r9
	li   r1, LC26
	li   r2, >200
	li   r3, >1200
	li   r4, >1C00
	bl   *r9
	li   r1, LC4
	li   r2, >100
	bl   @getkey
	bl   @windowrestore
	mov  *r10+, r11
	mov  *r10, r9
	ai   r10, >20
	b    *r11
	.size	informationcredits, .-informationcredits
	even

	def	dsr_write
dsr_write
	ai   r10, >FFF8
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r1, r9
	mov  r2, r14
	li   r1, >300
	movb r1, *r9
	mov  r2, r1
	bl   @strlen
	mov  r1, r13
	movb @>2(r9), r4
	andi r4, >FF00
	movb @>3(r9), r1
	srl  r1, 8
	soc  r4, r1
	mov  r14, r2
	mov  r13, r3
	bl   @vdpmemcpy
	swpb r13
	movb r13, @>5(r9)
	mov  r9, r1
	li   r2, >3000
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	b    @dsrlnk
	.size	dsr_write, .-dsr_write
	even

	def	dsr_read
dsr_read
	ai   r10, >FFFA
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r1, r9
	li   r3, >200
	movb r3, *r1
	mov  r2, r3
	movb r3, @>6(r1)
	andi r2, >FF
	swpb r2
	movb r2, @>7(r1)
	clr  r2
	movb r2, @>5(r1)
	li   r2, >3000
	bl   @dsrlnk
	movb r1, r13
	li   r1, >3005
	mov  r9, r2
	ai   r2, >5
	li   r3, >1
	bl   @vdpmemread
	movb r13, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    *r11
	.size	dsr_read, .-dsr_read
	even

	def	dsr_close
dsr_close
	li   r2, >100
	movb r2, *r1
	li   r2, >3000
	b    @dsrlnk
	.size	dsr_close, .-dsr_close
	even

	def	dsr_openDV
dsr_openDV
	swpb r3
	clr  r7
	movb r7, @>6(r1)
	movb r7, @>7(r1)
	movb r7, @>8(r1)
	movb r7, @>9(r1)
	movb r7, @>5(r1)
	movb r7, *r1
	ori  r5, >1000
	movb r5, @>1(r1)
	movb r3, @>4(r1)
	mov  r2, r3
	movb r3, @>A(r1)
	andi r2, >FF
	swpb r2
	movb r2, @>B(r1)
	mov  r4, r2
	movb r2, @>2(r1)
	andi r4, >FF
	swpb r4
	movb r4, @>3(r1)
	li   r2, >3000
	b    @dsrlnk
	.size	dsr_openDV, .-dsr_openDV
LC28
	text 'Load game.'
	byte 0
LC29
	text 'Choose slot:'
	byte 0
LC30
	text 'Slot empty.'
	byte 0
LC27
	text 'TIPI.LUDOSAV'
	byte 0
	bss 1
	even

	def	loadgame
loadgame
	ai   r10, >FFD6
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	mov  r10, r13
	ai   r13, >16
	mov  r13, r1
	li   r2, LC27
	li   r3, >D
	bl   @memcpy
	clr  r1
	movb r1, @>23(r10)
	mov  r13, r1
	bl   @strlen
	mov  r1, @>24(r10)
	li   r1, >200
	li   r2, >500
	li   r3, >C00
	li   r4, >1C00
	bl   @menumakeborder
	li   r14, cputsxy
	li   r1, >4
	li   r2, >7
	li   r3, LC28
	bl   *r14
	li   r1, >4
	li   r2, >9
	li   r3, LC29
	bl   *r14
	li   r1, >A00
	movb r1, r2
	li   r3, >800
	bl   @menupulldown
	movb r1, r15
	ai   r15, >FF00
	movb r15, r9
	srl  r9, 8
	ai   r9, saveslots
	li   r4, >100
	cb   *r9, r4
	jne  JMP_142
	b    @L493
JMP_142
L476
	bl   @windowrestore
	li   r2, >200
	cb   *r9, r2
	jeq  L494
L487
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >22
	b    *r11
	b    @L495
L494
	movb @>25(r10), r1
	srl  r1, 8
	mov  r13, r2
	a    r1, r2
	ai   r15, >3000
	movb r15, *r2
	li   r2, >A
	a    r10, r2
	a    r2, r1
	clr  r3
	movb r3, @>D(r1)
	mov  r2, r1
	mov  r13, r2
	li   r3, >88
	li   r4, >3200
	li   r5, >400
	bl   @dsr_openDV
	mov  r10, r1
	ai   r1, >A
	clr  r2
	bl   @dsr_read
	jeq  0
	cb  r1, @$-1
	jeq  JMP_143
	b    @L479
JMP_143
	li   r1, >3200
	li   r2, savegamemem
	li   r3, >88
	bl   @vdpmemread
	mov  r10, r1
	ai   r1, >A
	bl   @dsr_close
	jeq  0
	cb  r1, @$-1
	jeq  JMP_144
	b    @L479
JMP_144
	movb @savegamemem, r4
	ai   r4, >FF00
	movb r4, @turnofplayernr
	movb @savegamemem+1, r6
	ai   r6, >8000
	movb r6, @np
	movb @savegamemem+2, r1
	ai   r1, >8000
	movb r1, @np+1
	movb @savegamemem+3, r2
	ai   r2, >8000
	movb r2, @np+2
	movb @savegamemem+4, r3
	ai   r3, >8000
	movb r3, @np+3
	li   r1, savegamemem+5
	li   r2, playerdata
L481
	seto r4
	ab   *r1, r4
	movb r4, *r2
	movb @>1(r1), r6
	ai   r6, >FF00
	movb r6, @>1(r2)
	movb @>2(r1), r3
	ai   r3, >FF00
	movb r3, @>2(r2)
	movb @>3(r1), r4
	ai   r4, >FF00
	movb r4, @>3(r2)
	ai   r1, >4
	ai   r2, >4
	ci   r1, savegamemem+21
	jne  L481
	li   r6, >15
	mov  r6, @>24(r10)
	clr  r1
	mov  r1, @>26(r10)
	clr  r15
L482
	mov  @>24(r10), r14
	ai   r14, savegamemem
	mov  @>26(r10), r13
	sla  r13, >3
	ai   r13, playerpos
	clr  r9
L483
	movb r15, r1
	movb r9, r2
	li   r3, pawnerase
	bl   *r3
	seto r4
	ab   *r14, r4
	movb r4, *r13
	movb @>1(r14), r6
	ai   r6, >FF00
	movb r6, @>1(r13)
	movb r15, r1
	movb r9, r2
	clr  r3
	li   r4, pawnplace
	bl   *r4
	ai   r9, >100
	inct r14
	inct r13
	li   r6, >400
	cb   r9, r6
	jne  L483
	ai   r15, >100
	mov  @>26(r10), r1
	inc  r1
	mov  r1, @>26(r10)
	mov  @>24(r10), r2
	ai   r2, >8
	mov  r2, @>24(r10)
	cb   r15, r9
	jne  L482
	li   r5, >35
	clr  r4
L484
	mov  r5, r1
	ai   r1, savegamemem
	mov  r4, r2
	sla  r2, >3
	a    r4, r2
	ai   r2, playername
	mov  r5, r3
	ai   r3, savegamemem+21
L485
	seto r6
	ab   *r1+, r6
	movb r6, *r2+
	c    r3, r1
	jne  L485
	inc  r4
	ai   r5, >15
	ci   r4, >4
	jne  L484
	li   r1, >200
	movb r1, @endofgameflag
	b    @L487
L493
	li   r1, >4
	li   r2, >9
	li   r3, LC30
	mov  r4, @>28(r10)
	bl   *r14
	li   r1, >4
	li   r2, >A
	li   r3, LC9
	bl   *r14
	li   r1, LC4
	mov  @>28(r10), r4
	movb r4, r2
	bl   @getkey
	b    @L476
L479
	bl   @fileerrormessage
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >22
	b    *r11
L495
	.size	loadgame, .-loadgame
LC31
	text 'TIPI.LUDOCFG'
	byte 0
	even

	def	loadconfigfile
loadconfigfile
	ai   r10, >FFE2
	mov  r11, *r10
	mov  r9, @>2(r10)
	mov  r10, r9
	ai   r9, >10
	mov  r9, r1
	li   r2, LC31
	li   r3, >D
	bl   @memcpy
	mov  r10, r1
	ai   r1, >4
	mov  r9, r2
	li   r3, >55
	li   r4, >3200
	li   r5, >400
	bl   @dsr_openDV
	mov  r10, r1
	ai   r1, >4
	clr  r2
	bl   @dsr_read
	jeq  0
	cb  r1, @$-1
	jne  L497
	li   r1, >3200
	li   r2, saveslots
	li   r3, >55
	bl   @vdpmemread
	mov  r10, r1
	ai   r1, >4
	bl   @dsr_close
	jeq  0
	cb  r1, @$-1
	jne  L505
L499
	li   r5, >5
	clr  r4
L500
	mov  r5, r1
	ai   r1, saveslots
	mov  r4, r2
	ai   r2, >23
	sla  r2, >4
	ai   r2, pulldownmenutitles
	mov  r5, r3
	ai   r3, saveslots+16
L501
	seto r6
	ab   *r1+, r6
	movb r6, *r2+
	c    r1, r3
	jne  L501
	inc  r4
	ai   r5, >10
	ci   r4, >5
	jne  L500
	mov  *r10+, r11
	mov  *r10, r9
	ai   r10, >1C
	b    *r11
L497
	bl   @fileerrormessage
	mov  r10, r1
	ai   r1, >4
	bl   @dsr_close
	jeq  0
	cb  r1, @$-1
	jeq  L499
L505
	bl   @fileerrormessage
	jmp  L499
	.size	loadconfigfile, .-loadconfigfile
	even

	def	saveconfigfile
saveconfigfile
	ai   r10, >FFE2
	mov  r11, *r10
	mov  r9, @>2(r10)
	mov  r10, r9
	ai   r9, >10
	mov  r9, r1
	li   r2, LC31
	li   r3, >D
	bl   @memcpy
	mov  r10, r1
	ai   r1, >4
	mov  r9, r2
	li   r3, >55
	li   r4, >3200
	li   r5, >600
	bl   @dsr_openDV
	jeq  0
	cb  r1, @$-1
	jne  L511
	mov  r10, r1
	ai   r1, >4
	li   r2, saveslots
	bl   @dsr_write
	jeq  0
	cb  r1, @$-1
	jne  L512
	mov  r10, r1
	ai   r1, >4
	bl   @dsr_close
	jeq  0
	cb  r1, @$-1
	jne  L511
L510
	mov  *r10+, r11
	mov  *r10, r9
	ai   r10, >1C
	b    *r11
	jmp  L513
L511
	bl   @fileerrormessage
	mov  *r10+, r11
	mov  *r10, r9
	ai   r10, >1C
	b    *r11
	jmp  L513
L512
	bl   @fileerrormessage
	mov  r10, r1
	ai   r1, >4
	bl   @dsr_close
	jeq  0
	cb  r1, @$-1
	jeq  L510
	jmp  L511
L513
	.size	saveconfigfile, .-saveconfigfile
LC32
	text 'Save game.'
	byte 0
LC33
	text 'Slot not empty. Sure?'
	byte 0
LC34
	text 'Choose name of save. '
	byte 0
	even

	def	savegame
savegame
	ai   r10, >FFD8
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	movb r1, r9
	mov  r10, r13
	ai   r13, >16
	mov  r13, r1
	li   r2, LC27
	li   r3, >D
	bl   @memcpy
	clr  r1
	movb r1, @>23(r10)
	mov  r13, r1
	li   r2, strlen
	bl   *r2
	swpb r1
	movb r1, @>24(r10)
	li   r2, >100
	cb   r9, r2
	jne  JMP_145
	b    @L546
JMP_145
	li   r1, >200
	li   r2, >500
	li   r3, >C00
	li   r4, >1C00
	bl   @menumakeborder
	li   r15, cputsxy
	li   r1, >4
	li   r2, >7
	li   r3, LC32
	bl   *r15
	li   r1, >4
	li   r2, >8
	li   r3, LC29
	bl   *r15
	li   r14, menupulldown
L517
	li   r1, >A00
	movb r1, r2
	li   r3, >800
	bl   *r14
	movb r1, r9
	ai   r9, >FF00
	jeq  L517
	movb r9, r14
	srl  r14, 8
	mov  r14, r4
	ai   r4, saveslots
	li   r1, >200
	cb   *r4, r1
	jne  JMP_146
	b    @L547
JMP_146
L518
	li   r1, >4
	li   r2, >9
	li   r3, LC34
	mov  r4, @>26(r10)
	bl   *r15
	li   r1, >100
	mov  @>26(r10), r4
	cb   *r4, r1
	jne  JMP_147
	b    @L543
JMP_147
	mov  r14, r5
	ai   r5, >23
L520
	mov  r14, r15
	ai   r15, >23
	sla  r15, >4
	ai   r15, pulldownmenutitles
	li   r1, >400
	li   r2, >A00
	mov  r15, r3
	li   r4, >F00
	mov  r5, @>26(r10)
	bl   @input
	mov  r15, r1
	li   r2, strlen
	bl   *r2
	mov  r1, r2
	swpb r2
	li   r1, >E00
	mov  @>26(r10), r5
	cb   r2, r1
	jle  JMP_148
	b    @L548
JMP_148
	sla  r14, >4
	mov  r14, r4
	ai   r4, pulldownmenutitles
	li   r1, >F00
L522
	movb r2, r3
	srl  r3, 8
	a    r4, r3
	li   r6, >2000
	movb r6, @>230(r3)
	ai   r2, >100
	cb   r2, r1
	jne  L522
L521
	clr  r7
	movb r7, @pulldownmenutitles+575(r14)
	movb @>24(r10), r1
	srl  r1, 8
	mov  r5, r3
	sla  r3, >4
	ai   r3, pulldownmenutitles
	mov  r14, r2
	ai   r2, >5
	ai   r2, saveslots
	ai   r14, saveslots+21
L523
	li   r4, >100
	ab   *r3+, r4
	movb r4, *r2+
	c    r2, r14
	jne  L523
	mov  r13, r2
	a    r1, r2
	ai   r9, >3000
	movb r9, *r2
	li   r6, >A
	a    r10, r6
	a    r6, r1
	clr  r7
	movb r7, @>D(r1)
	bl   @windowrestore
	jmp  L516
L546
	srl  r1, 8
	mov  r13, r2
	a    r1, r2
	li   r3, >3000
	movb r3, *r2
	li   r4, >A
	a    r10, r4
	a    r4, r1
	clr  r6
	movb r6, @>D(r1)
L516
	bl   @saveconfigfile
	movb @turnofplayernr, r1
	ai   r1, >100
	movb r1, @savegamemem
	movb @np, r2
	ai   r2, >8000
	movb r2, @savegamemem+1
	movb @np+1, r3
	ai   r3, >8000
	movb r3, @savegamemem+2
	movb @np+2, r4
	ai   r4, >8000
	movb r4, @savegamemem+3
	movb @np+3, r6
	ai   r6, >8000
	movb r6, @savegamemem+4
	li   r3, playerdata
	li   r4, savegamemem+5
L524
	li   r7, >100
	ab   *r3, r7
	movb r7, *r4
	movb @>1(r3), r1
	ai   r1, >100
	movb r1, @>1(r4)
	movb @>2(r3), r2
	ai   r2, >100
	movb r2, @>2(r4)
	movb @>3(r3), r6
	ai   r6, >100
	movb r6, @>3(r4)
	ai   r3, >4
	ai   r4, >4
	ci   r3, playerdata+16
	jne  L524
	li   r2, >15
	clr  r1
	li   r6, >400
L525
	mov  r1, r3
	sla  r3, >3
	ai   r3, playerpos
	mov  r2, r4
	ai   r4, savegamemem
	clr  r5
L526
	li   r7, >100
	ab   *r3, r7
	movb r7, *r4
	movb @>1(r3), r7
	ai   r7, >100
	movb r7, @>1(r4)
	ai   r5, >100
	inct r3
	inct r4
	cb   r5, r6
	jne  L526
	inc  r1
	ai   r2, >8
	ci   r1, >4
	jne  L525
	li   r1, >35
	clr  r6
L527
	mov  r6, r4
	sla  r4, >3
	a    r6, r4
	ai   r4, playername
	mov  r1, r3
	ai   r3, savegamemem
	mov  r1, r5
	ai   r5, savegamemem+21
L528
	li   r2, >100
	ab   *r4+, r2
	movb r2, *r3+
	c    r5, r3
	jne  L528
	inc  r6
	ai   r1, >15
	ci   r6, >4
	jne  L527
	mov  r10, r1
	ai   r1, >A
	mov  r13, r2
	li   r3, >88
	li   r4, >3200
	li   r5, >600
	bl   @dsr_openDV
	jeq  0
	cb  r1, @$-1
	jne  L545
	mov  r10, r1
	ai   r1, >A
	li   r2, savegamemem
	bl   @dsr_write
	jeq  0
	cb  r1, @$-1
	jne  L549
L532
	mov  r10, r1
	ai   r1, >A
	bl   @dsr_close
	jeq  0
	cb  r1, @$-1
	jne  L545
L533
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >20
	b    *r11
	jmp  L550
L545
	bl   @fileerrormessage
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >20
	b    *r11
	jmp  L550
L547
	li   r1, >4
	li   r2, >9
	li   r3, LC33
	mov  r4, @>26(r10)
	bl   *r15
	li   r1, >F00
	li   r2, >A00
	li   r3, >500
	bl   @menupulldown
	li   r2, >100
	mov  @>26(r10), r4
	cb   r1, r2
	jne  JMP_149
	b    @L518
JMP_149
	bl   @windowrestore
	jmp  L533
L549
	bl   @fileerrormessage
	jmp  L532
L543
	mov  r14, r5
	ai   r5, >23
	mov  r5, r1
	sla  r1, >4
	clr  r7
	movb r7, @pulldownmenutitles(r1)
	b    @L520
L548
	sla  r14, >4
	b    @L521
L550
	.size	savegame, .-savegame
LC35
	text 'Autosave on '
	byte 0
LC36
	text 'Autosave off'
	byte 0
	even

	def	turnhuman
turnhuman
	ai   r10, >FFF6
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	li   r14, menumain
	li   r13, >1D00
	li   r15, >100
	jmp  L563
L552
	movb r9, r1
	ai   r1, >F500
	ci   r1, >2FF
	jle  L564
L561
	li   r1, >1600
	cb   r9, r1
	jeq  L564
L563
	bl   *r14
	movb r1, r9
	ai   r1, >F400
	cb   r1, r13
	jh  L552
	srl  r1, 8
	a    r1, r1
	mov  @L559(r1), r2
	b    *r2
	even
L559
		data		L553
		data		L554
		data		L552
		data		L552
		data		L552
		data		L552
		data		L552
		data		L552
		data		L552
		data		L555
		data		L556
		data		L557
		data		L552
		data		L552
		data		L552
		data		L552
		data		L552
		data		L552
		data		L552
		data		L552
		data		L552
		data		L552
		data		L552
		data		L552
		data		L552
		data		L552
		data		L552
		data		L552
		data		L552
		data		L558
L558
	li   r1, informationcredits
	bl   *r1
	li   r1, >1600
	cb   r9, r1
	jne  L563
L564
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	jmp  L566
L557
	cb   @autosavetoggle, r15
	jeq  L567
	li   r1, >100
	movb r1, @autosavetoggle
	li   r1, pulldownmenutitles+112
	li   r2, LC36
	li   r3, >D
	li   r4, memcpy
	bl   *r4
	jmp  L561
L556
	li   r4, areyousure
	bl   *r4
	cb   r1, r15
	jne  L561
	li   r1, loadgame
	bl   *r1
	jmp  L561
L555
	clr  r1
	li   r2, savegame
	bl   *r2
	b    @L561
L554
	bl   @areyousure
	li   r2, >100
	cb   r1, r2
	jne  L564
	movb r1, @endofgameflag
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	jmp  L566
L553
	bl   @areyousure
	li   r2, >100
	cb   r1, r2
	jne  L564
	li   r4, >300
	movb r4, @endofgameflag
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @gamereset
L567
	clr  r2
	movb r2, @autosavetoggle
	li   r1, pulldownmenutitles+112
	li   r2, LC35
	li   r3, >D
	li   r4, memcpy
	bl   *r4
	b    @L561
L566
	.size	turnhuman, .-turnhuman
LC37
	text 'Load old game?'
	byte 0
LC38
	text 'Player %d'
	byte 0
LC39
	text 'Color'
	byte 0
LC40
	text 'Computer'
	byte 0
LC41
	text 'Thanks for playing, goodbye.'
	byte 0
	even

	def	main
main
	ai   r10, >FFF6
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	bl   @graphicsinit
	jeq  0
	cb  @tipienabled, @$-1
	jeq  JMP_150
	b    @L588
JMP_150
	clr  r1
	movb r1, @autosavetoggle
	li   r15, cputsxy
L570
	bl   @loadmainscreen
	movb @endofgameflag, r1
	li   r9, >100
	li   r14, >300
L582
	jeq  0
	cb  r1, @$-1
	jne  JMP_151
	b    @L571
JMP_151
	clr  r2
	movb r2, @endofgameflag
L572
	li   r13, turngeneric
L584
	li   r1, >1700
	li   r2, >200
	li   r3, >800
	movb r3, r4
	li   r5, cleararea
	bl   *r5
	li   r1, >17
	mov  r1, @conio_x
	li   r2, >2
	mov  r2, @conio_y
	ai   r10, >FFFC
	li   r4, LC38
	mov  r4, *r10
	movb @turnofplayernr, r1
	srl  r1, 8
	inc  r1
	mov  r1, @>2(r10)
	li   r5, cprintf
	bl   *r5
	ai   r10, >4
	li   r1, >17
	li   r2, >3
	li   r3, LC39
	bl   *r15
	movb @turnofplayernr, r1
	srl  r1, 8
	a    r1, r1
	inc  r1
	a    r1, r1
	movb @playerdata(r1), r3
	li   r1, >1E
	li   r2, >3
	srl  r3, 8
	li   r4, cputcxy
	bl   *r4
	movb @turnofplayernr, r1
	srl  r1, 8
	mov  r1, r3
	sla  r3, >3
	a    r1, r3
	li   r1, >17
	li   r2, >4
	ai   r3, playername
	bl   *r15
	movb @turnofplayernr, r1
	srl  r1, >6
	andi r1, >FFFC
	jeq  0
	cb  @playerdata(r1), @$-1
	jeq  JMP_152
	b    @L573
JMP_152
	li   r5, turnhuman
	bl   *r5
L574
	movb @endofgameflag, r1
	jne  L575
	bl   *r13
	movb @turnofplayernr, r2
	movb r2, r5
	movb r2, r4
	srl  r4, 8
	mov  r4, r1
	sla  r1, >2
	ai   r1, playerdata
	jeq  0
	cb  @>1(r1), @$-1
	jeq  L589
L576
	movb @zv, r3
L580
	cb   r3, r9
	jeq  L577
	seto r1
	movb r1, @np(r4)
	movb r5, r2
	ai   r2, >100
	cb   r2, r14
	jle  L578
	clr  r2
L578
	jeq  0
	cb  r3, @$-1
	jne  L579
	movb r2, r5
	movb r2, r4
	srl  r4, 8
L577
	clr  r3
	mov  r4, r1
	sla  r1, >2
	ai   r1, playerdata
	jeq  0
	cb  @>1(r1), @$-1
	jeq  L580
L579
	movb r2, @turnofplayernr
	movb r3, @zv
	movb @endofgameflag, r1
	jne  JMP_153
	b    @L584
JMP_153
L575
	cb   r1, r9
	jeq  JMP_154
	b    @L582
JMP_154
	bl   @clrscr
	clr  r1
	bl   @bgcolor
	clr  r1
	mov  r1, r2
	li   r3, LC41
	bl   *r15
	clr  r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
L589
	bl   @playerwins
	movb @turnofplayernr, r2
	movb r2, r5
	movb r2, r4
	srl  r4, 8
	jmp  L576
L573
	li   r1, >17
	li   r2, >5
	li   r3, LC40
	li   r4, cputsxy
	bl   *r4
	b    @L574
L571
	li   r4, inputofnames
	bl   *r4
	b    @L572
L588
	bl   @loadconfigfile
	li   r1, >800
	li   r2, >500
	li   r3, >600
	li   r4, >1400
	bl   @menumakeborder
	li   r15, cputsxy
	li   r1, >A
	li   r2, >7
	li   r3, LC37
	bl   *r15
	li   r1, >1100
	li   r2, >800
	li   r3, >500
	bl   @menupulldown
	movb r1, r9
	bl   @windowrestore
	li   r2, >100
	cb   r9, r2
	jeq  JMP_155
	b    @L570
JMP_155
	bl   @loadgame
	b    @L570
	.size	main, .-main

	def	windownumber

	even
	cseg
	.type	windownumber, @object
	.size	windownumber, 1
windownumber
	bss 1

	def	menubaroptions
	dseg
	.type	menubaroptions, @object
	.size	menubaroptions, 1
menubaroptions
	byte	4

	def	pulldownmenunumber
	.type	pulldownmenunumber, @object
	.size	pulldownmenunumber, 1
pulldownmenunumber
	byte	8

	def	menubartitles
	.type	menubartitles, @object
	.size	menubartitles, 48
menubartitles
	text 'Game'
	byte 0
	bss 7
	text 'Disc'
	byte 0
	bss 7
	text 'Music'
	byte 0
	bss 6
	text 'Info'
	byte 0
	bss 7

	def	menubarcoords
	.type	menubarcoords, @object
	.size	menubarcoords, 4
menubarcoords
	byte	6
	byte	11
	byte	16
	byte	22

	def	pulldownmenuoptions
	.type	pulldownmenuoptions, @object
	.size	pulldownmenuoptions, 8
pulldownmenuoptions
	byte	3
	byte	3
	byte	3
	byte	1
	byte	2
	byte	2
	byte	3
	byte	5

	def	pulldownmenutitles
	.type	pulldownmenutitles, @object
	.size	pulldownmenutitles, 640
pulldownmenutitles
	text 'Throw dice'
	byte 0
	bss 5
	text 'Restart   '
	byte 0
	bss 5
	text 'Stop      '
	byte 0
	bss 5
	bss 32
	text 'Save game   '
	byte 0
	bss 3
	text 'Load game   '
	byte 0
	bss 3
	text 'Autosave off'
	byte 0
	bss 3
	bss 32
	text 'Next   '
	byte 0
	bss 8
	text 'Stop   '
	byte 0
	bss 8
	text 'Restart'
	byte 0
	bss 8
	bss 32
	text 'Credits'
	byte 0
	bss 8
	bss 64
	text 'Yes'
	byte 0
	bss 12
	text 'No '
	byte 0
	bss 12
	bss 48
	text 'Restart'
	byte 0
	bss 8
	text 'Stop   '
	byte 0
	bss 8
	bss 48
	text 'Continue game'
	byte 0
	bss 2
	text 'New game     '
	byte 0
	bss 2
	text 'Stop         '
	byte 0
	bss 2
	bss 32
	text 'Autosave       '
	byte 0
	text 'Slot 1: Empty  '
	byte 0
	text 'Slot 2: Empty  '
	byte 0
	text 'Slot 3: Empty  '
	byte 0
	text 'Slot 4: Empty  '
	byte 0

	def	numbers
	.type	numbers, @object
	.size	numbers, 11
numbers
	text '0123456789'
	byte 0

	def	letters
	.type	letters, @object
	.size	letters, 53
letters
	text 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
	byte 0

	def	updownenter
	.type	updownenter, @object
	.size	updownenter, 4
updownenter
	byte	10
	byte	11
	byte	13
	byte	0

	def	leftright
	.type	leftright, @object
	.size	leftright, 3
leftright
	byte	8
	byte	9
	byte	0

	def	fieldcoords
	.type	fieldcoords, @object
	.size	fieldcoords, 80
fieldcoords
	byte	0
	byte	10
	byte	2
	byte	10
	byte	4
	byte	10
	byte	6
	byte	10
	byte	8
	byte	10
	byte	8
	byte	8
	byte	8
	byte	6
	byte	8
	byte	4
	byte	8
	byte	2
	byte	10
	byte	2
	byte	12
	byte	2
	byte	12
	byte	4
	byte	12
	byte	6
	byte	12
	byte	8
	byte	12
	byte	10
	byte	14
	byte	10
	byte	16
	byte	10
	byte	18
	byte	10
	byte	20
	byte	10
	byte	20
	byte	12
	byte	20
	byte	14
	byte	18
	byte	14
	byte	16
	byte	14
	byte	14
	byte	14
	byte	12
	byte	14
	byte	12
	byte	16
	byte	12
	byte	18
	byte	12
	byte	20
	byte	12
	byte	22
	byte	10
	byte	22
	byte	8
	byte	22
	byte	8
	byte	20
	byte	8
	byte	18
	byte	8
	byte	16
	byte	8
	byte	14
	byte	6
	byte	14
	byte	4
	byte	14
	byte	2
	byte	14
	byte	0
	byte	14
	byte	0
	byte	12

	def	homedestcoords
	.type	homedestcoords, @object
	.size	homedestcoords, 64
homedestcoords
	byte	0
	byte	2
	byte	2
	byte	2
	byte	0
	byte	4
	byte	2
	byte	4
	byte	2
	byte	12
	byte	4
	byte	12
	byte	6
	byte	12
	byte	8
	byte	12
	byte	18
	byte	2
	byte	20
	byte	2
	byte	18
	byte	4
	byte	20
	byte	4
	byte	10
	byte	4
	byte	10
	byte	6
	byte	10
	byte	8
	byte	10
	byte	10
	byte	18
	byte	20
	byte	20
	byte	20
	byte	18
	byte	22
	byte	20
	byte	22
	byte	18
	byte	12
	byte	16
	byte	12
	byte	14
	byte	12
	byte	12
	byte	12
	byte	0
	byte	20
	byte	2
	byte	20
	byte	0
	byte	22
	byte	2
	byte	22
	byte	10
	byte	20
	byte	10
	byte	18
	byte	10
	byte	16
	byte	10
	byte	14

	def	playerdata
	.type	playerdata, @object
	.size	playerdata, 16
playerdata
	byte	0
	byte	4
	byte	-88
	byte	4
	byte	0
	byte	4
	byte	-80
	byte	4
	byte	0
	byte	4
	byte	-72
	byte	4
	byte	0
	byte	4
	byte	-64
	byte	4

	def	playerpos
	.type	playerpos, @object
	.size	playerpos, 32
playerpos
	byte	1
	byte	0
	byte	1
	byte	1
	byte	1
	byte	2
	byte	1
	byte	3
	byte	1
	byte	0
	byte	1
	byte	1
	byte	1
	byte	2
	byte	1
	byte	3
	byte	1
	byte	0
	byte	1
	byte	1
	byte	1
	byte	2
	byte	1
	byte	3
	byte	1
	byte	0
	byte	1
	byte	1
	byte	1
	byte	2
	byte	1
	byte	3

	def	playername
	.type	playername, @object
	.size	playername, 36
playername
	byte 0
	bss 8
	byte 0
	bss 8
	byte 0
	bss 8
	byte 0
	bss 8

	def	np
	.type	np, @object
	.size	np, 4
np
	byte	-1
	byte	-1
	byte	-1
	byte	-1

	def	dp
	.type	dp, @object
	.size	dp, 4
dp
	byte	8
	byte	8
	byte	8
	byte	8

	def	dicegraphics
	.type	dicegraphics, @object
	.size	dicegraphics, 24
dicegraphics
	byte	8
	byte	9
	byte	10
	byte	11
	byte	12
	byte	13
	byte	14
	byte	12
	byte	8
	byte	15
	byte	16
	byte	11
	byte	17
	byte	13
	byte	14
	byte	18
	byte	19
	byte	15
	byte	16
	byte	20
	byte	21
	byte	22
	byte	23
	byte	24

	def	endofgameflag

	even
	cseg
	.type	endofgameflag, @object
	.size	endofgameflag, 1
endofgameflag
	bss 1

	def	turnofplayernr

	even
	.type	turnofplayernr, @object
	.size	turnofplayernr, 1
turnofplayernr
	bss 1

	def	zv

	even
	.type	zv, @object
	.size	zv, 1
zv
	bss 1

	def	ns

	even
	.type	ns, @object
	.size	ns, 1
ns
	bss 1

	def	musicnumber

	even
	.type	musicnumber, @object
	.size	musicnumber, 1
musicnumber
	bss 1

	def	joyinterface
	dseg
	.type	joyinterface, @object
	.size	joyinterface, 1
joyinterface
	byte	1

	def	autosavetoggle
	.type	autosavetoggle, @object
	.size	autosavetoggle, 1
autosavetoggle
	byte	1

	def	tipienabled
	.type	tipienabled, @object
	.size	tipienabled, 1
tipienabled
	byte	1
	pseg
	.type	C.121.2599, @object
	.size	C.121.2599, 5
C.121.2599
	byte	8
	byte	9
	byte	11
	byte	10
	byte	13
	even
	.type	random_mask.1474, @object
	.size	random_mask.1474, 2
random_mask.1474
	data	-19456
	dseg
	even
	.type	seed.1473, @object
	.size	seed.1473, 2
seed.1473
	data	-21846
	pseg
	.type	mainscreen, @object
	.size	mainscreen, 768
mainscreen
	byte	76
	byte	85
	byte	68
	byte	79
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-128
	byte	-127
	byte	-128
	byte	-127
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-92
	byte	-91
	byte	-92
	byte	-91
	byte	-76
	byte	-75
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-120
	byte	-119
	byte	-120
	byte	-119
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-126
	byte	-125
	byte	-126
	byte	-125
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-90
	byte	-89
	byte	-90
	byte	-89
	byte	-74
	byte	-73
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-118
	byte	-117
	byte	-118
	byte	-117
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-128
	byte	-127
	byte	-128
	byte	-127
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-92
	byte	-91
	byte	-116
	byte	-115
	byte	-92
	byte	-91
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-120
	byte	-119
	byte	-120
	byte	-119
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-126
	byte	-125
	byte	-126
	byte	-125
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-90
	byte	-89
	byte	-114
	byte	-113
	byte	-90
	byte	-89
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-118
	byte	-117
	byte	-118
	byte	-117
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-92
	byte	-91
	byte	-116
	byte	-115
	byte	-92
	byte	-91
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-90
	byte	-89
	byte	-114
	byte	-113
	byte	-90
	byte	-89
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-92
	byte	-91
	byte	-116
	byte	-115
	byte	-92
	byte	-91
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-90
	byte	-89
	byte	-114
	byte	-113
	byte	-90
	byte	-89
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-84
	byte	-83
	byte	-92
	byte	-91
	byte	-92
	byte	-91
	byte	-92
	byte	-91
	byte	-92
	byte	-91
	byte	-116
	byte	-115
	byte	-92
	byte	-91
	byte	-92
	byte	-91
	byte	-92
	byte	-91
	byte	-92
	byte	-91
	byte	-92
	byte	-91
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-82
	byte	-81
	byte	-90
	byte	-89
	byte	-90
	byte	-89
	byte	-90
	byte	-89
	byte	-90
	byte	-89
	byte	-114
	byte	-113
	byte	-90
	byte	-89
	byte	-90
	byte	-89
	byte	-90
	byte	-89
	byte	-90
	byte	-89
	byte	-90
	byte	-89
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-92
	byte	-91
	byte	-124
	byte	-123
	byte	-124
	byte	-123
	byte	-124
	byte	-123
	byte	-124
	byte	-123
	byte	32
	byte	32
	byte	-108
	byte	-107
	byte	-108
	byte	-107
	byte	-108
	byte	-107
	byte	-108
	byte	-107
	byte	-92
	byte	-91
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-90
	byte	-89
	byte	-122
	byte	-121
	byte	-122
	byte	-121
	byte	-122
	byte	-121
	byte	-122
	byte	-121
	byte	32
	byte	32
	byte	-106
	byte	-105
	byte	-106
	byte	-105
	byte	-106
	byte	-105
	byte	-106
	byte	-105
	byte	-90
	byte	-89
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-92
	byte	-91
	byte	-92
	byte	-91
	byte	-92
	byte	-91
	byte	-92
	byte	-91
	byte	-92
	byte	-91
	byte	-100
	byte	-99
	byte	-92
	byte	-91
	byte	-92
	byte	-91
	byte	-92
	byte	-91
	byte	-92
	byte	-91
	byte	-68
	byte	-67
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-90
	byte	-89
	byte	-90
	byte	-89
	byte	-90
	byte	-89
	byte	-90
	byte	-89
	byte	-90
	byte	-89
	byte	-98
	byte	-97
	byte	-90
	byte	-89
	byte	-90
	byte	-89
	byte	-90
	byte	-89
	byte	-90
	byte	-89
	byte	-66
	byte	-65
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-92
	byte	-91
	byte	-100
	byte	-99
	byte	-92
	byte	-91
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-90
	byte	-89
	byte	-98
	byte	-97
	byte	-90
	byte	-89
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-92
	byte	-91
	byte	-100
	byte	-99
	byte	-92
	byte	-91
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-90
	byte	-89
	byte	-98
	byte	-97
	byte	-90
	byte	-89
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-104
	byte	-103
	byte	-104
	byte	-103
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-92
	byte	-91
	byte	-100
	byte	-99
	byte	-92
	byte	-91
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-112
	byte	-111
	byte	-112
	byte	-111
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-102
	byte	-101
	byte	-102
	byte	-101
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-90
	byte	-89
	byte	-98
	byte	-97
	byte	-90
	byte	-89
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-110
	byte	-109
	byte	-110
	byte	-109
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-104
	byte	-103
	byte	-104
	byte	-103
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-60
	byte	-59
	byte	-92
	byte	-91
	byte	-92
	byte	-91
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-112
	byte	-111
	byte	-112
	byte	-111
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-102
	byte	-101
	byte	-102
	byte	-101
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-58
	byte	-57
	byte	-90
	byte	-89
	byte	-90
	byte	-89
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-110
	byte	-109
	byte	-110
	byte	-109
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	.type	colorset, @object
	.size	colorset, 25
colorset
	byte	-127
	byte	31
	byte	31
	byte	31
	byte	-79
	byte	-79
	byte	-79
	byte	-79
	byte	-79
	byte	-79
	byte	-79
	byte	-79
	byte	-79
	byte	-79
	byte	-79
	byte	-79
	byte	33
	byte	-127
	byte	65
	byte	-95
	byte	-15
	byte	33
	byte	-127
	byte	65
	byte	-95
	.type	patterns, @object
	.size	patterns, 1600
patterns
	byte	-1
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	-1
	byte	1
	byte	1
	byte	1
	byte	1
	byte	1
	byte	1
	byte	1
	byte	1
	byte	-128
	byte	-128
	byte	-128
	byte	-128
	byte	-128
	byte	-128
	byte	-128
	byte	-128
	byte	1
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	-128
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	1
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	-128
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	1
	byte	3
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	-128
	byte	-64
	byte	3
	byte	1
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	-64
	byte	-128
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	12
	byte	30
	byte	30
	byte	12
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	48
	byte	120
	byte	120
	byte	48
	byte	0
	byte	0
	byte	12
	byte	30
	byte	30
	byte	12
	byte	0
	byte	-128
	byte	-64
	byte	3
	byte	1
	byte	0
	byte	48
	byte	120
	byte	120
	byte	48
	byte	0
	byte	0
	byte	48
	byte	120
	byte	120
	byte	48
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	12
	byte	30
	byte	30
	byte	12
	byte	0
	byte	0
	byte	48
	byte	120
	byte	120
	byte	48
	byte	0
	byte	1
	byte	3
	byte	-64
	byte	-128
	byte	0
	byte	12
	byte	30
	byte	30
	byte	12
	byte	0
	byte	0
	byte	48
	byte	120
	byte	120
	byte	48
	byte	0
	byte	48
	byte	120
	byte	0
	byte	12
	byte	30
	byte	30
	byte	12
	byte	0
	byte	12
	byte	30
	byte	120
	byte	48
	byte	0
	byte	48
	byte	120
	byte	120
	byte	48
	byte	0
	byte	30
	byte	12
	byte	0
	byte	12
	byte	30
	byte	30
	byte	12
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	24
	byte	60
	byte	60
	byte	24
	byte	24
	byte	0
	byte	24
	byte	0
	byte	108
	byte	108
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	108
	byte	108
	byte	-2
	byte	108
	byte	-2
	byte	108
	byte	108
	byte	0
	byte	24
	byte	62
	byte	96
	byte	60
	byte	6
	byte	124
	byte	24
	byte	0
	byte	0
	byte	-58
	byte	-52
	byte	24
	byte	48
	byte	102
	byte	-58
	byte	0
	byte	56
	byte	108
	byte	104
	byte	118
	byte	-36
	byte	-52
	byte	118
	byte	0
	byte	12
	byte	12
	byte	16
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	12
	byte	24
	byte	48
	byte	48
	byte	48
	byte	24
	byte	12
	byte	0
	byte	48
	byte	24
	byte	12
	byte	12
	byte	12
	byte	24
	byte	48
	byte	0
	byte	0
	byte	102
	byte	60
	byte	-1
	byte	60
	byte	102
	byte	0
	byte	0
	byte	0
	byte	24
	byte	24
	byte	126
	byte	24
	byte	24
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	24
	byte	24
	byte	48
	byte	0
	byte	0
	byte	0
	byte	126
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	24
	byte	24
	byte	0
	byte	3
	byte	6
	byte	12
	byte	24
	byte	48
	byte	96
	byte	-64
	byte	0
	byte	60
	byte	102
	byte	110
	byte	126
	byte	118
	byte	102
	byte	60
	byte	0
	byte	24
	byte	24
	byte	56
	byte	24
	byte	24
	byte	24
	byte	126
	byte	0
	byte	60
	byte	102
	byte	6
	byte	12
	byte	48
	byte	102
	byte	126
	byte	0
	byte	60
	byte	102
	byte	6
	byte	28
	byte	6
	byte	102
	byte	60
	byte	0
	byte	28
	byte	60
	byte	108
	byte	-52
	byte	-2
	byte	12
	byte	30
	byte	0
	byte	126
	byte	96
	byte	124
	byte	6
	byte	6
	byte	102
	byte	60
	byte	0
	byte	28
	byte	48
	byte	96
	byte	124
	byte	102
	byte	102
	byte	60
	byte	0
	byte	126
	byte	102
	byte	6
	byte	12
	byte	24
	byte	24
	byte	24
	byte	0
	byte	60
	byte	102
	byte	102
	byte	60
	byte	102
	byte	102
	byte	60
	byte	0
	byte	60
	byte	102
	byte	102
	byte	62
	byte	6
	byte	12
	byte	56
	byte	0
	byte	0
	byte	24
	byte	24
	byte	0
	byte	24
	byte	24
	byte	0
	byte	0
	byte	0
	byte	24
	byte	24
	byte	0
	byte	0
	byte	24
	byte	24
	byte	48
	byte	12
	byte	24
	byte	48
	byte	96
	byte	48
	byte	24
	byte	12
	byte	0
	byte	0
	byte	0
	byte	126
	byte	0
	byte	126
	byte	0
	byte	0
	byte	0
	byte	48
	byte	24
	byte	12
	byte	6
	byte	12
	byte	24
	byte	48
	byte	0
	byte	60
	byte	102
	byte	6
	byte	12
	byte	24
	byte	0
	byte	24
	byte	0
	byte	60
	byte	66
	byte	-103
	byte	-95
	byte	-95
	byte	-103
	byte	66
	byte	60
	byte	24
	byte	60
	byte	60
	byte	102
	byte	126
	byte	-61
	byte	-61
	byte	0
	byte	-4
	byte	102
	byte	102
	byte	124
	byte	102
	byte	102
	byte	-4
	byte	0
	byte	60
	byte	102
	byte	-64
	byte	-64
	byte	-64
	byte	102
	byte	60
	byte	0
	byte	-8
	byte	108
	byte	102
	byte	102
	byte	102
	byte	108
	byte	-8
	byte	0
	byte	-2
	byte	102
	byte	96
	byte	120
	byte	96
	byte	102
	byte	-2
	byte	0
	byte	-2
	byte	102
	byte	96
	byte	120
	byte	96
	byte	96
	byte	-16
	byte	0
	byte	60
	byte	102
	byte	-64
	byte	-50
	byte	-58
	byte	102
	byte	60
	byte	0
	byte	102
	byte	102
	byte	102
	byte	126
	byte	102
	byte	102
	byte	102
	byte	0
	byte	126
	byte	24
	byte	24
	byte	24
	byte	24
	byte	24
	byte	126
	byte	0
	byte	60
	byte	12
	byte	12
	byte	12
	byte	-52
	byte	-52
	byte	120
	byte	0
	byte	-26
	byte	102
	byte	108
	byte	112
	byte	108
	byte	102
	byte	-26
	byte	0
	byte	-16
	byte	96
	byte	96
	byte	96
	byte	98
	byte	102
	byte	-2
	byte	0
	byte	-126
	byte	-58
	byte	-18
	byte	-2
	byte	-42
	byte	-58
	byte	-58
	byte	0
	byte	-58
	byte	-26
	byte	-10
	byte	-34
	byte	-50
	byte	-58
	byte	-58
	byte	0
	byte	56
	byte	108
	byte	-58
	byte	-58
	byte	-58
	byte	108
	byte	56
	byte	0
	byte	-4
	byte	102
	byte	102
	byte	124
	byte	96
	byte	96
	byte	-16
	byte	0
	byte	56
	byte	108
	byte	-58
	byte	-58
	byte	-58
	byte	108
	byte	60
	byte	6
	byte	-4
	byte	102
	byte	102
	byte	124
	byte	108
	byte	102
	byte	-29
	byte	0
	byte	60
	byte	102
	byte	112
	byte	56
	byte	14
	byte	102
	byte	60
	byte	0
	byte	126
	byte	90
	byte	24
	byte	24
	byte	24
	byte	24
	byte	60
	byte	0
	byte	102
	byte	102
	byte	102
	byte	102
	byte	102
	byte	102
	byte	62
	byte	0
	byte	-61
	byte	-61
	byte	102
	byte	102
	byte	60
	byte	60
	byte	24
	byte	0
	byte	-58
	byte	-58
	byte	-58
	byte	-42
	byte	-2
	byte	-18
	byte	-58
	byte	0
	byte	-61
	byte	102
	byte	60
	byte	24
	byte	60
	byte	102
	byte	-61
	byte	0
	byte	-61
	byte	-61
	byte	102
	byte	60
	byte	24
	byte	24
	byte	60
	byte	0
	byte	-2
	byte	-58
	byte	-116
	byte	24
	byte	50
	byte	102
	byte	-2
	byte	0
	byte	60
	byte	48
	byte	48
	byte	48
	byte	48
	byte	48
	byte	60
	byte	0
	byte	-64
	byte	96
	byte	48
	byte	24
	byte	12
	byte	6
	byte	3
	byte	0
	byte	60
	byte	12
	byte	12
	byte	12
	byte	12
	byte	12
	byte	60
	byte	0
	byte	16
	byte	56
	byte	108
	byte	-58
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	-1
	byte	0
	byte	0
	byte	32
	byte	16
	byte	8
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	120
	byte	12
	byte	124
	byte	-52
	byte	118
	byte	0
	byte	-32
	byte	96
	byte	108
	byte	118
	byte	102
	byte	102
	byte	60
	byte	0
	byte	0
	byte	0
	byte	60
	byte	102
	byte	96
	byte	102
	byte	60
	byte	0
	byte	28
	byte	12
	byte	108
	byte	-36
	byte	-52
	byte	-52
	byte	118
	byte	0
	byte	0
	byte	0
	byte	60
	byte	102
	byte	126
	byte	96
	byte	60
	byte	0
	byte	28
	byte	54
	byte	48
	byte	120
	byte	48
	byte	48
	byte	120
	byte	0
	byte	0
	byte	0
	byte	59
	byte	102
	byte	102
	byte	60
	byte	-58
	byte	124
	byte	-32
	byte	96
	byte	108
	byte	118
	byte	102
	byte	102
	byte	-26
	byte	0
	byte	24
	byte	0
	byte	56
	byte	24
	byte	24
	byte	24
	byte	60
	byte	0
	byte	12
	byte	0
	byte	12
	byte	12
	byte	12
	byte	12
	byte	-52
	byte	120
	byte	-32
	byte	96
	byte	102
	byte	108
	byte	120
	byte	108
	byte	-26
	byte	0
	byte	56
	byte	24
	byte	24
	byte	24
	byte	24
	byte	24
	byte	60
	byte	0
	byte	0
	byte	0
	byte	-52
	byte	-18
	byte	-42
	byte	-58
	byte	-58
	byte	0
	byte	0
	byte	0
	byte	124
	byte	102
	byte	102
	byte	102
	byte	102
	byte	0
	byte	0
	byte	0
	byte	60
	byte	102
	byte	102
	byte	102
	byte	60
	byte	0
	byte	0
	byte	0
	byte	-68
	byte	102
	byte	102
	byte	124
	byte	96
	byte	-16
	byte	0
	byte	0
	byte	122
	byte	-52
	byte	-52
	byte	124
	byte	12
	byte	14
	byte	0
	byte	0
	byte	-84
	byte	118
	byte	102
	byte	96
	byte	-16
	byte	0
	byte	0
	byte	0
	byte	62
	byte	96
	byte	60
	byte	6
	byte	124
	byte	0
	byte	16
	byte	48
	byte	124
	byte	48
	byte	48
	byte	52
	byte	24
	byte	0
	byte	0
	byte	0
	byte	-52
	byte	-52
	byte	-52
	byte	-52
	byte	114
	byte	0
	byte	0
	byte	0
	byte	102
	byte	102
	byte	102
	byte	60
	byte	24
	byte	0
	byte	0
	byte	0
	byte	-58
	byte	-42
	byte	-42
	byte	108
	byte	108
	byte	0
	byte	0
	byte	0
	byte	-58
	byte	108
	byte	56
	byte	108
	byte	-58
	byte	0
	byte	0
	byte	0
	byte	102
	byte	102
	byte	102
	byte	60
	byte	24
	byte	112
	byte	0
	byte	0
	byte	126
	byte	76
	byte	24
	byte	50
	byte	126
	byte	0
	byte	24
	byte	32
	byte	32
	byte	64
	byte	32
	byte	32
	byte	24
	byte	0
	byte	16
	byte	16
	byte	16
	byte	0
	byte	16
	byte	16
	byte	16
	byte	0
	byte	48
	byte	8
	byte	8
	byte	4
	byte	8
	byte	8
	byte	48
	byte	0
	byte	0
	byte	32
	byte	84
	byte	8
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	3
	byte	15
	byte	31
	byte	63
	byte	31
	byte	15
	byte	7
	byte	15
	byte	-64
	byte	-16
	byte	-8
	byte	-4
	byte	-8
	byte	-16
	byte	-32
	byte	-16
	byte	7
	byte	15
	byte	31
	byte	31
	byte	63
	byte	63
	byte	63
	byte	0
	byte	-32
	byte	-16
	byte	-8
	byte	-8
	byte	-4
	byte	-4
	byte	-4
	byte	0
	byte	0
	byte	0
	byte	1
	byte	7
	byte	15
	byte	31
	byte	31
	byte	63
	byte	0
	byte	0
	byte	-128
	byte	-32
	byte	-16
	byte	-8
	byte	-8
	byte	-4
	byte	63
	byte	31
	byte	31
	byte	15
	byte	7
	byte	1
	byte	0
	byte	0
	byte	-4
	byte	-8
	byte	-8
	byte	-16
	byte	-32
	byte	-128
	byte	0
	byte	0
	byte	3
	byte	15
	byte	31
	byte	63
	byte	31
	byte	15
	byte	7
	byte	15
	byte	-64
	byte	-16
	byte	-8
	byte	-4
	byte	-8
	byte	-16
	byte	-32
	byte	-16
	byte	7
	byte	15
	byte	31
	byte	31
	byte	63
	byte	63
	byte	63
	byte	0
	byte	-32
	byte	-16
	byte	-8
	byte	-8
	byte	-4
	byte	-4
	byte	-4
	byte	0
	byte	0
	byte	0
	byte	1
	byte	7
	byte	15
	byte	31
	byte	31
	byte	63
	byte	0
	byte	0
	byte	-128
	byte	-32
	byte	-16
	byte	-8
	byte	-8
	byte	-4
	byte	63
	byte	31
	byte	31
	byte	15
	byte	7
	byte	1
	byte	0
	byte	0
	byte	-4
	byte	-8
	byte	-8
	byte	-16
	byte	-32
	byte	-128
	byte	0
	byte	0
	byte	3
	byte	15
	byte	31
	byte	63
	byte	31
	byte	15
	byte	7
	byte	15
	byte	-64
	byte	-16
	byte	-8
	byte	-4
	byte	-8
	byte	-16
	byte	-32
	byte	-16
	byte	7
	byte	15
	byte	31
	byte	31
	byte	63
	byte	63
	byte	63
	byte	0
	byte	-32
	byte	-16
	byte	-8
	byte	-8
	byte	-4
	byte	-4
	byte	-4
	byte	0
	byte	0
	byte	0
	byte	1
	byte	7
	byte	15
	byte	31
	byte	31
	byte	63
	byte	0
	byte	0
	byte	-128
	byte	-32
	byte	-16
	byte	-8
	byte	-8
	byte	-4
	byte	63
	byte	31
	byte	31
	byte	15
	byte	7
	byte	1
	byte	0
	byte	0
	byte	-4
	byte	-8
	byte	-8
	byte	-16
	byte	-32
	byte	-128
	byte	0
	byte	0
	byte	3
	byte	15
	byte	31
	byte	63
	byte	31
	byte	15
	byte	7
	byte	15
	byte	-64
	byte	-16
	byte	-8
	byte	-4
	byte	-8
	byte	-16
	byte	-32
	byte	-16
	byte	7
	byte	15
	byte	31
	byte	31
	byte	63
	byte	63
	byte	63
	byte	0
	byte	-32
	byte	-16
	byte	-8
	byte	-8
	byte	-4
	byte	-4
	byte	-4
	byte	0
	byte	0
	byte	0
	byte	1
	byte	7
	byte	15
	byte	31
	byte	31
	byte	63
	byte	0
	byte	0
	byte	-128
	byte	-32
	byte	-16
	byte	-8
	byte	-8
	byte	-4
	byte	63
	byte	31
	byte	31
	byte	15
	byte	7
	byte	1
	byte	0
	byte	0
	byte	-4
	byte	-8
	byte	-8
	byte	-16
	byte	-32
	byte	-128
	byte	0
	byte	0
	byte	3
	byte	15
	byte	31
	byte	63
	byte	31
	byte	15
	byte	7
	byte	15
	byte	-64
	byte	-16
	byte	-8
	byte	-4
	byte	-8
	byte	-16
	byte	-32
	byte	-16
	byte	7
	byte	15
	byte	31
	byte	31
	byte	63
	byte	63
	byte	63
	byte	0
	byte	-32
	byte	-16
	byte	-8
	byte	-8
	byte	-4
	byte	-4
	byte	-4
	byte	0
	byte	0
	byte	0
	byte	1
	byte	6
	byte	8
	byte	16
	byte	16
	byte	32
	byte	0
	byte	0
	byte	-128
	byte	96
	byte	16
	byte	8
	byte	8
	byte	4
	byte	32
	byte	16
	byte	16
	byte	8
	byte	6
	byte	1
	byte	0
	byte	0
	byte	4
	byte	8
	byte	8
	byte	16
	byte	96
	byte	-128
	byte	0
	byte	0
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	1
	byte	7
	byte	15
	byte	31
	byte	31
	byte	56
	byte	0
	byte	0
	byte	-128
	byte	-32
	byte	-16
	byte	120
	byte	56
	byte	28
	byte	56
	byte	31
	byte	31
	byte	15
	byte	7
	byte	1
	byte	0
	byte	0
	byte	28
	byte	56
	byte	120
	byte	-16
	byte	-32
	byte	-128
	byte	0
	byte	0
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	0
	byte	8
	byte	12
	byte	126
	byte	126
	byte	12
	byte	8
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	1
	byte	7
	byte	15
	byte	30
	byte	30
	byte	62
	byte	0
	byte	0
	byte	-128
	byte	-32
	byte	-16
	byte	120
	byte	120
	byte	124
	byte	56
	byte	28
	byte	30
	byte	15
	byte	7
	byte	1
	byte	0
	byte	0
	byte	28
	byte	56
	byte	120
	byte	-16
	byte	-32
	byte	-128
	byte	0
	byte	0
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	1
	byte	7
	byte	15
	byte	30
	byte	28
	byte	56
	byte	0
	byte	0
	byte	-128
	byte	-32
	byte	-16
	byte	-8
	byte	-8
	byte	28
	byte	56
	byte	28
	byte	30
	byte	15
	byte	7
	byte	1
	byte	0
	byte	0
	byte	28
	byte	-8
	byte	-8
	byte	-16
	byte	-32
	byte	-128
	byte	0
	byte	0
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	-1
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	1
	byte	7
	byte	15
	byte	30
	byte	28
	byte	56
	byte	0
	byte	0
	byte	-128
	byte	-32
	byte	-16
	byte	120
	byte	56
	byte	28
	byte	62
	byte	30
	byte	30
	byte	15
	byte	7
	byte	1
	byte	0
	byte	0
	byte	124
	byte	120
	byte	120
	byte	-16
	byte	-32
	byte	-128
	byte	0
	byte	0
	.type	C.56.1994, @object
	.size	C.56.1994, 4
C.56.1994
	byte	8
	byte	9
	byte	13
	byte	0
	cseg

	even
	def Window
Window
	bss 36

	even
	def windowaddress
windowaddress
	bss 2

	even
	def windowmemory
windowmemory
	bss 768

	even
	def throw
throw
	bss 1

	even
	def saveslots
saveslots
	bss 85

	even
	def savegamemem
savegamemem
	bss 136

	ref	cputsxy

	ref	bgcolor

	ref	clrscr

	ref	cputcxy

	ref	cprintf

	ref	conio_y

	ref	conio_x

	ref	memcpy

	ref	strlen

	ref	vdpmemread

	ref	dsrlnk

	ref	vdpmemcpy

	ref	memset

	ref	cputs

	ref	vdpchar

	ref	gImage

	ref	cputc

	ref	strcpy

	ref	cgetc

	ref	kscanfast

	ref	joystfast

	ref	kbhit

	ref	gPattern

	ref	gColor

	ref	set_graphics
