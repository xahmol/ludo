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
* 243 "main.c" 1
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
	jeq  L16
	srl  r3, 8
	movb @>1(r4), r2
	srl  r2, 8
	sla  r1, >3
	a    r2, r1
	a    r1, r1
	a    r3, r1
	movb @homedestcoords(r1), r1
	b    *r11
	jmp  L17
L16
	srl  r3, 8
	movb @>1(r4), r1
	srl  r1, 8
	a    r1, r1
	a    r3, r1
	movb @fieldcoords(r1), r1
	b    *r11
L17
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
	jmp  L58
L69
	li   r1, >D8F0
	mov  r1, *r14
L20
	mov  @>12(r10), r2
	inc  r2
	mov  r2, @>12(r10)
	inct r14
	mov  @>1A(r10), r1
	inct r1
	mov  r1, @>1A(r10)
	ai   r2, >FFFC
	jne  JMP_2
	b    @L37
JMP_2
L58
	mov  @>20(r10), r1
	mov  @>12(r10), r2
	a    r2, r1
	jeq  0
	cb  *r1, @$-1
	jeq  L69
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
	b    @L21
JMP_3
	jeq  0
	cb  r15, @$-1
	jeq  JMP_4
	b    @L22
JMP_4
	li   r1, >2700
	cb   r2, r1
	jle  L28
	movb @>1E(r10), r2
	cb   r2, r1
	jh  JMP_5
	b    @L70
JMP_5
L28
	movb @>1D(r10), @>1C(r10)
L31
	li   r2, >2700
	movb @>1C(r10), r1
	cb   r1, r2
	jle  L33
	ai   r1, >D800
	movb r1, @>1C(r10)
L33
	clr  r13
L35
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
L38
	mov  r6, r4
	sla  r4, >3
	ai   r4, playerpos
	mov  @>10(r10), r5
	clr  r3
	mov  r6, r8
	sla  r8, >2
	li   r0, >D00
L49
	cb   r15, r9
	jne  JMP_6
	b    @L71
JMP_6
	movb *r4, r1
	cb   r1, r13
	jne  JMP_7
	b    @L72
JMP_7
L41
	jeq  0
	cb  r1, @$-1
	jne  L42
	jeq  0
	cb  r13, @$-1
	jne  L42
L64
	cb   r15, r9
	jeq  L42
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
	jh  L47
	li   r2, >190
	a    r2, *r14
L47
	mov  @>16(r10), r2
	s    r1, r2
	dec  r2
	ci   r2, >4
	jh  L48
	li   r2, >FF38
	a    r2, *r14
L48
	mov  @>18(r10), r2
	s    r2, r1
	dec  r1
	ci   r1, >4
	jh  L42
	li   r1, >64
	a    r1, *r14
L42
	inc  r3
	inct r4
	inct r5
	ci   r3, >4
	jne  L49
	ai   r9, >100
	inc  r6
	ai   r7, >8
	li   r1, >400
	cb   r9, r1
	jeq  JMP_8
	b    @L38
JMP_8
	jeq  0
	cb  r13, @$-1
	jne  L51
	movb @>1C(r10), r2
	jne  JMP_9
	b    @L52
JMP_9
	li   r2, >A00
	movb @>1C(r10), r1
	cb   r1, r2
	jne  JMP_10
	b    @L52
JMP_10
	li   r2, >1400
	cb   r1, r2
	jne  JMP_11
	b    @L52
JMP_11
	li   r2, >1E00
	cb   r1, r2
	jne  JMP_12
	b    @L52
JMP_12
L51
	movb @>1F(r10), r1
	jne  L53
	movb @>1E(r10), r2
	jeq  L54
	li   r2, >A00
	movb @>1E(r10), r1
	cb   r1, r2
	jeq  L54
	li   r2, >1400
	cb   r1, r2
	jeq  L54
	li   r2, >1E00
	cb   r1, r2
	jeq  L54
L53
	jeq  0
	cb  r15, @$-1
	jne  L55
L75
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
	jeq  JMP_13
	b    @L58
JMP_13
L37
	mov  @>20(r10), r5
	li   r4, >B1E0
	clr  r1
	movb r1, r3
	li   r7, >100
	li   r6, >400
	mov  @>26(r10), r8
L62
	mov  *r8, r2
	c    r4, r2
	jgt  L59
	jeq  L59
	cb   *r5, r7
	jne  JMP_14
	b    @L73
JMP_14
L59
	mov  r4, r2
	ai   r3, >100
	inct r8
	inc  r5
	cb   r3, r6
	jne  JMP_15
	b    @L74
JMP_15
L61
	mov  r2, r4
	jmp  L62
L54
	li   r2, >7D0
	a    r2, *r14
	jeq  0
	cb  r15, @$-1
	jeq  L75
L55
	li   r1, >100
	cb   r15, r1
	jeq  JMP_16
	b    @L56
JMP_16
	mov  *r14, r2
	ai   r2, >FFF6
	movb @>1D(r10), r1
	srl  r1, 8
	a    r1, r2
	mov  r2, *r14
	b    @L20
L52
	li   r2, >F060
	a    r2, *r14
	b    @L51
L71
	cb   @>FFFF(r5), r13
	jeq  L76
L40
	mov  r3, r1
	a    r3, r1
	a    r7, r1
	movb *r1, r1
	b    @L41
L76
	cb   *r5, r12
	jne  L40
	li   r1, >E0C0
	a    r1, *r14
	mov  r3, r1
	a    r3, r1
	a    r7, r1
	movb *r1, r1
	b    @L41
L72
	cb   @>1(r4), r12
	jeq  JMP_17
	b    @L41
JMP_17
	mov  *r14, r2
	ai   r2, >FA0
	mov  r2, *r14
	jeq  0
	cb  r13, @$-1
	jeq  JMP_18
	b    @L42
JMP_18
	jeq  0
	cb  r9, @$-1
	jne  L43
	ci   r12, >21FF
	jh  JMP_19
	b    @L64
JMP_19
	ai   r2, >BB8
	mov  r2, *r14
	b    @L64
L43
	li   r1, >100
	cb   r9, r1
	jeq  JMP_20
	b    @L45
JMP_20
	ci   r12, >3FF
	jh  JMP_21
	b    @L64
JMP_21
	ai   r2, >BB8
	mov  r2, *r14
	b    @L64
L21
	movb @>1D(r10), @>1C(r10)
	movb @>1F(r10), r13
L30
	li   r2, >100
	cb   r13, r2
	jeq  JMP_22
	b    @L35
JMP_22
L32
	li   r2, >300
	movb @>1C(r10), r1
	cb   r1, r2
	jle  L67
	li   r1, >100
	mov  @>24(r10), r2
	cb   *r2, r1
	jne  JMP_23
	b    @L77
JMP_23
	li   r1, >1770
	a    r1, *r14
L67
	li   r13, >100
	b    @L35
L22
	li   r2, >100
	cb   r15, r2
	jne  L25
	li   r2, >900
	movb @>1D(r10), r1
	cb   r1, r2
	jle  L29
	movb @>1E(r10), r1
	cb   r1, r2
	jh  L29
	movb @>1D(r10), r2
	ai   r2, >FA00
	movb r2, @>1C(r10)
	jmp  L32
L29
	movb @>1D(r10), @>1C(r10)
	b    @L31
L45
	li   r1, >200
	cb   r9, r1
	jeq  JMP_24
	b    @L46
JMP_24
	cb   r12, r0
	jh  JMP_25
	b    @L64
JMP_25
	ai   r2, >BB8
	mov  r2, *r14
	b    @L64
L56
	li   r2, >200
	cb   r15, r2
	jne  L57
	mov  *r14, r2
	ai   r2, >FFEC
	movb @>1D(r10), r1
	srl  r1, 8
	a    r1, r2
	mov  r2, *r14
	b    @L20
L73
	movb r3, r1
	ai   r3, >100
	inct r8
	inc  r5
	cb   r3, r6
	jeq  JMP_26
	b    @L61
JMP_26
L74
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >22
	b    *r11
L25
	li   r2, >200
	cb   r15, r2
	jeq  JMP_27
	b    @L27
JMP_27
	li   r2, >1300
	movb @>1D(r10), r1
	cb   r1, r2
	jh  JMP_28
	b    @L28
JMP_28
	movb @>1E(r10), r1
	cb   r1, r2
	jle  JMP_29
	b    @L28
JMP_29
	movb @>1D(r10), r2
	ai   r2, >F000
	movb r2, @>1C(r10)
	b    @L32
L70
	movb @>1D(r10), r1
	ai   r1, >DC00
	movb r1, @>1C(r10)
	b    @L32
L77
	mov  @>12(r10), r1
	a    r1, r1
	li   r2, >8
	a    r10, r2
	a    r2, r1
	li   r2, >2710
	mov  r2, *r1
	b    @L37
L57
	li   r2, >300
	cb   r15, r2
	jeq  JMP_30
	b    @L20
JMP_30
	mov  *r14, r2
	ai   r2, >FFE2
	movb @>1D(r10), r1
	srl  r1, 8
	a    r1, r2
	mov  r2, *r14
	b    @L20
L46
	li   r2, >300
	cb   r9, r2
	jeq  JMP_31
	b    @L64
JMP_31
	ci   r12, >17FF
	jh  JMP_32
	b    @L64
JMP_32
	li   r2, >BB8
	a    r2, *r14
	b    @L64
L27
	li   r2, >300
	cb   r15, r2
	jeq  JMP_33
	b    @L29
JMP_33
	li   r2, >1D00
	movb @>1D(r10), r1
	cb   r1, r2
	jh  JMP_34
	b    @L29
JMP_34
	movb @>1E(r10), r1
	cb   r1, r2
	jle  JMP_35
	b    @L29
JMP_35
	movb @>1D(r10), r2
	ai   r2, >E600
	movb r2, @>1C(r10)
	li   r13, >100
	b    @L30
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
	jeq  L81
	clr  r9
	li   r13, cprintf
L80
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
	jh  L80
L81
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
	jne  L84
	movb @>1(r4), r2
	srl  r2, 8
	a    r2, r2
	ai   r2, fieldcoords
	movb *r2+, r4
	movb *r2, r2
	jeq  0
	cb  r3, @$-1
	jne  L95
L86
	li   r3, >100
	cb   r1, r3
	jne  JMP_36
	b    @L89
JMP_36
	cb   r1, r3
	jhe  L96
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
L84
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
	jeq  L86
L95
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
L96
	li   r3, >200
	cb   r1, r3
	jeq  L90
	li   r3, >300
	cb   r1, r3
	jeq  L97
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
L90
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
L89
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
L97
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
	jne  L99
	movb @>1(r3), r3
	movb r3, r2
	srl  r2, 8
	a    r2, r2
	ai   r2, fieldcoords
	movb *r2+, r1
	movb *r2, r2
	jeq  0
	cb  r3, @$-1
	jne  L114
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
L113
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @cputcxy
L99
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
	jne  JMP_37
	b    @L104
JMP_37
	cb   r1, r3
	jl  L103
	li   r3, >200
	cb   r1, r3
	jne  JMP_38
	b    @L105
JMP_38
	li   r3, >300
	cb   r1, r3
	jne  JMP_39
	b    @L115
JMP_39
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
L114
	li   r4, >A00
	cb   r3, r4
	jne  JMP_40
	b    @L107
JMP_40
	li   r4, >1400
	cb   r3, r4
	jne  JMP_41
	b    @L108
JMP_41
	li   r4, >1E00
	cb   r3, r4
	jne  JMP_42
	b    @L116
JMP_42
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
L103
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
	b    @L113
L104
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
	b    @L113
L107
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
	b    @L113
L115
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
	b    @L113
L105
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
	b    @L113
L108
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
	b    @L113
L116
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
	b    @L113
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
L120
	li   r3, >400
	movb r3, *r2
	movb r3, @>2(r2)
	li   r3, >FF08
	movb r3, @np(r1)
	swpb r3
	movb r3, @dp(r1)
	inc  r1
	ai   r2, >4
	ci   r1, >4
	jne  L120
	mov  *r10+, r11
	b    *r11
	.size	gamereset, .-gamereset
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

	def	cspaces
cspaces
	ai   r10, >FFF8
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	movb r1, r13
	jeq  L134
	clr  r9
	li   r14, cputc
L133
	li   r1, >20
	bl   *r14
	ai   r9, >100
	cb   r13, r9
	jh  L133
L134
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
	jeq  L138
	mov  @>A(r10), r15
	clr  r9
L139
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
	jh  L139
L138
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
	jne  JMP_43
	b    @L149
JMP_43
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
L142
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
	jh  L142
L141
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
	jeq  L143
	mov  @>A(r10), r14
	clr  r9
L144
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
	jh  L144
L143
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
L149
	mov  @>14(r10), r2
	inc  r2
	mov  r2, @>14(r10)
	jmp  L141
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
	jeq  L153
	srl  r1, 8
	mov  r1, @>A(r10)
	clr  r13
	clr  r9
	srl  r2, 8
	mov  r2, @>C(r10)
L152
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
	jh  L152
L153
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
L196
	mov  @seed.1455, r1
* Begin inline assembler code
* 225 "main.c" 1
	srl r1,1  
	jnc 1f    
	xor @random_mask.1456,r1 
	1:        
	
* 0 "" 2
* End of inline assembler code
	mov  r1, @seed.1455
	jeq  0
	cb  @joyinterface, @$-1
	jeq  L156
	movb @>C(r10), r1
	jne  L200
L156
	bl   @kbhit
	jeq  0
	cb  r1, @$-1
	jeq  JMP_44
	b    @L181
JMP_44
	clr  r5
	movb r1, r15
L180
	mov  @>A(r10), r2
	jmp  L185
L201
	inc  r2
L185
	movb *r2, r1
	movb r1, r3
	srl  r3, 8
	c    r3, r5
	jeq  L183
	jeq  0
	cb  r1, @$-1
	jne  L201
L184
	li   r1, >D00
	cb   r15, r1
	jeq  JMP_45
	b    @L196
JMP_45
	movb r15, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	b    @L202
L183
	ci   r2, 0
	jeq  L184
	jeq  0
	cb  r15, @$-1
	jne  JMP_46
	b    @L196
JMP_46
	movb r15, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	b    @L202
L200
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
	jne  JMP_47
	b    @L203
JMP_47
L157
	li   r15, >D00
	li   r5, >400
	cb   r13, r5
	jne  JMP_48
	b    @L204
JMP_48
L159
	li   r3, >400
	cb   r2, r3
	jne  JMP_49
	b    @L205
JMP_49
L161
	li   r4, >FC00
	cb   r13, r4
	jne  JMP_50
	b    @L162
JMP_50
	li   r5, >FC00
	cb   r2, r5
	jne  JMP_51
	b    @L162
JMP_51
L163
	li   r2, >FC00
	cb   r9, r2
	jne  JMP_52
	b    @L206
JMP_52
L164
	li   r3, >FC00
	cb   r1, r3
	jne  JMP_53
	b    @L207
JMP_53
L166
	li   r4, >400
	cb   r9, r4
	jne  JMP_54
	b    @L167
JMP_54
	li   r5, >400
	cb   r1, r5
	jne  JMP_55
	b    @L167
JMP_55
L212
	jeq  0
	cb  r15, @$-1
	jne  JMP_56
	b    @L156
JMP_56
L195
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
	jeq  L169
L198
	li   r1, >100
	li   r4, >400
	cb   r14, r4
	jeq  L208
L172
	li   r5, >400
	cb   r3, r5
	jne  JMP_57
	b    @L209
JMP_57
L174
	li   r4, >FC00
	cb   r14, r4
	jeq  L175
	li   r5, >FC00
	cb   r3, r5
	jeq  L175
L176
	li   r3, >FC00
	cb   r13, r3
	jeq  L210
L177
	li   r4, >FC00
	cb   r2, r4
	jne  JMP_58
	b    @L211
JMP_58
L179
	li   r5, >400
	cb   r13, r5
	jeq  L195
L178
	li   r3, >400
	cb   r2, r3
	jeq  L195
	li   r4, >100
	cb   r1, r4
	jne  JMP_59
	b    @L195
JMP_59
L182
	movb r15, r5
	srl  r5, 8
	b    @L180
L169
	clr  r1
	seto r5
	cb   r4, r5
	jne  L198
	li   r4, >400
	cb   r14, r4
	jne  L172
L208
	li   r1, >100
	li   r5, >FC00
	cb   r3, r5
	jne  L176
L175
	li   r1, >100
	li   r3, >FC00
	cb   r13, r3
	jne  L177
L210
	li   r1, >100
	jmp  L178
L203
	cb   r3, r4
	jeq  JMP_60
	b    @L157
JMP_60
	clr  r15
	li   r5, >400
	cb   r13, r5
	jeq  JMP_61
	b    @L159
JMP_61
L204
	li   r15, >900
	li   r5, >FC00
	cb   r2, r5
	jeq  JMP_62
	b    @L163
JMP_62
L162
	li   r15, >800
	li   r2, >FC00
	cb   r9, r2
	jeq  JMP_63
	b    @L164
JMP_63
L206
	li   r15, >A00
	li   r5, >400
	cb   r1, r5
	jeq  JMP_64
	b    @L212
JMP_64
L167
	li   r15, >B00
	b    @L195
L209
	li   r1, >100
	b    @L174
L211
	li   r1, >100
	b    @L179
L181
	bl   @cgetc
	movb r1, r15
	mov  @>A(r10), r5
	jeq  0
	cb  *r5, @$-1
	jeq  JMP_65
	b    @L182
JMP_65
	li   r5, >D
	li   r15, >D00
	b    @L180
L207
	li   r15, >A00
	b    @L166
L205
	li   r15, >900
	b    @L161
L202
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
	li   r2, C.93.2295
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
	jeq  L238
	cb   @>2(r14), r9
	jne  JMP_66
	b    @L240
JMP_66
	cb   @>3(r14), r9
	jne  JMP_67
	b    @L241
JMP_67
	cb   @>4(r14), r9
	jne  JMP_68
	b    @L218
JMP_68
	li   r9, >400
L238
	li   r1, pawnplace
	mov  r1, @>12(r10)
	li   r3, getkey
	mov  r3, @>14(r10)
L237
	li   r4, >300
L236
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
	jne  JMP_69
	b    @L219
JMP_69
	li   r3, >A00
	cb   r13, r3
	jeq  L219
L220
	li   r5, >900
	cb   r13, r5
	jeq  L221
	li   r1, >B00
	cb   r13, r1
	jeq  L221
	li   r2, >D00
	cb   r13, r2
	jeq  L223
L243
	cb   r9, r4
	jlt  L224
	jeq  L224
	clr  r9
L225
	movb r9, r2
	sra  r2, 8
L226
	a    r14, r2
	li   r3, >100
	cb   *r2, r3
	jeq  L236
	ab   r15, r9
	cb   r9, r4
	jlt  L227
	jeq  L227
L242
	clr  r9
L228
	movb r9, r1
	sra  r1, 8
L229
	a    r14, r1
	cb   *r1, r3
	jeq  L236
	ab   r15, r9
	cb   r9, r4
	jgt  L242
L227
	jeq  0
	cb  r9, @$-1
	jgt  L228
	jeq  L228
	li   r1, >3
	li   r9, >300
	jmp  L229
L221
	ai   r9, >100
	li   r15, >100
	li   r2, >D00
	cb   r13, r2
	jne  L243
L223
	bl   @windowrestore
	movb r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >10
	b    *r11
L219
	ai   r9, >FF00
	seto r15
	jmp  L220
L224
	jeq  0
	cb  r9, @$-1
	jgt  L225
	jeq  L225
	li   r2, >3
	li   r9, >300
	jmp  L226
L240
	li   r9, >200
	li   r5, pawnplace
	mov  r5, @>12(r10)
	li   r1, getkey
	mov  r1, @>14(r10)
	b    @L237
L218
	li   r9, >400
	li   r5, pawnplace
	mov  r5, @>12(r10)
	li   r1, getkey
	mov  r1, @>14(r10)
	b    @L237
L241
	li   r9, >300
	li   r3, pawnplace
	mov  r3, @>12(r10)
	li   r5, getkey
	mov  r5, @>14(r10)
	b    @L237
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
L246
	mov  @seed.1455, r1
* Begin inline assembler code
* 225 "main.c" 1
	srl r1,1  
	jnc 1f    
	xor @random_mask.1456,r1 
	1:        
	
* 0 "" 2
* End of inline assembler code
	mov  r1, @seed.1455
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
L245
* Begin inline assembler code
* 243 "main.c" 1
	clr r12
	tb 2
	jeq -4
	movb @>8802,r12
* 0 "" 2
* End of inline assembler code
	inc  r2
	ci   r2, >A
	jeq  JMP_70
	b    @L245
JMP_70
	ai   r15, >100
	li   r1, >A00
	cb   r15, r1
	jeq  JMP_71
	b    @L246
JMP_71
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
	jne  JMP_72
	b    @L329
JMP_72
L251
	li   r13, >100
	li   r1, cputsxy
	mov  r1, @>E(r10)
L256
	clr  r9
	li   r15, dicethrow
	li   r14, >600
L258
	bl   *r15
	movb r1, @throw
	cb   r1, r14
	jeq  L257
	ai   r9, >100
	cb   r13, r9
	jh  L258
L257
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
	jne  JMP_73
	b    @L330
JMP_73
L259
	clr  r14
L261
	mov  r3, r12
	ai   r12, np
	movb *r12, r15
	jgt  JMP_74
	jeq  JMP_74
	b    @L331
JMP_74
	jeq  0
	cb  r4, @$-1
	jne  JMP_75
	b    @L332
JMP_75
L264
	seto r2
	movb r2, *r12
L263
	jeq  0
	cb  r14, @$-1
	jeq  JMP_76
	b    @L265
JMP_76
	seto r4
	cb   r15, r4
	jne  JMP_77
	b    @L333
JMP_77
L266
	li   r9, >100
L290
	li   r3, >600
	cb   @throw, r3
	jne  JMP_78
	b    @L334
JMP_78
L292
	jeq  0
	cb  r9, @$-1
	jne  JMP_79
	b    @L293
JMP_79
	li   r13, >100
	cb   r14, r13
	jne  JMP_80
	b    @L293
JMP_80
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
	jne  JMP_81
	b    @L335
JMP_81
L296
	movb r5, r3
	ab   @throw, r3
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	movb r3, @playerpos+1(r4)
L297
	jeq  0
	cb  r9, @$-1
	jeq  JMP_82
	b    @L298
JMP_82
	li   r4, >2700
	cb   r3, r4
	jle  JMP_83
	b    @L336
JMP_83
L303
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	movb @>1(r3), r3
L305
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	movb @playerpos(r4), r7
	li   r4, >100
	cb   r7, r4
	jne  JMP_84
	b    @L337
JMP_84
L306
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
	jne  JMP_85
	b    @L338
JMP_85
L307
	ci   r3, >27FF
	jle  L308
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	ai   r3, >D800
	movb r3, @playerpos+1(r4)
L308
	clr  r0
	a    r6, r8
	a    r8, r8
	ai   r8, playerpos
	mov  r8, r13
	inc  r13
	li   r12, >400
L309
	clr  r2
	clr  r5
	movb r0, r3
	srl  r3, >6
	andi r3, >FFFC
	jmp  L313
L310
	mov  r3, r1
	a    r2, r1
	a    r1, r1
	ai   r1, playerpos
	jeq  0
	cb  *r1, @$-1
	jne  L311
	jeq  0
	cb  *r8, @$-1
	jne  L311
	cb   @>1(r1), *r13
	jeq  L312
L311
	ai   r5, >100
	inc  r2
	cb   r5, r12
	jeq  L339
L313
	c    r6, r2
	jne  L310
	cb   r0, r9
	jne  L310
	ai   r5, >100
	inc  r2
	cb   r5, r12
	jne  L313
L339
	ai   r0, >100
	ci   r0, >3FF
	jle  L309
	clr  r5
	seto r0
L312
	seto r3
	cb   r0, r3
	jeq  JMP_86
	b    @L325
JMP_86
	li   r13, pawnplace
L315
	movb r9, r1
	movb r15, r2
	clr  r3
	bl   *r13
	movb @turnofplayernr, r1
	srl  r1, >6
	andi r1, >FFFC
	jeq  0
	cb  @playerdata(r1), @$-1
	jne  L316
	li   r1, >100
	cb   @autosavetoggle, r1
	jeq  L317
L316
	li   r1, >17
	li   r2, >7
	jmp  L326
L293
	li   r1, >17
	li   r2, >7
	li   r3, LC7
	mov  @>E(r10), r4
	bl   *r4
	li   r1, >17
	li   r2, >8
L326
	li   r3, LC3
	mov  @>E(r10), r4
	bl   *r4
	li   r1, LC4
	li   r2, >100
	bl   @getkey
L317
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >10
	b    *r11
L333
	movb @throw, r13
	movb r14, r2
	li   r0, >100
	sla  r3, >3
	ai   r3, playerpos
	mov  r3, @>10(r10)
	li   r9, >400
	movb r14, @>12(r10)
	mov  r12, r14
L284
	movb r2, r12
	srl  r12, 8
	mov  r8, r3
	a    r12, r3
	a    r3, r3
	ai   r3, playerpos
	movb *r3+, r4
	movb *r3, r5
	cb   r4, r0
	jne  JMP_87
	b    @L340
JMP_87
	movb r5, r7
	ab   r13, r7
	jeq  0
	cb  r4, @$-1
	jne  L271
	jeq  0
	cb  r1, @$-1
	jeq  JMP_88
	b    @L272
JMP_88
	li   r4, >2700
	cb   r7, r4
	jle  L278
	cb   r5, r4
	jh  JMP_89
	b    @L341
JMP_89
L278
	clr  r4
L274
	cb   r4, r0
	jne  JMP_90
	b    @L279
JMP_90
L271
	li   r3, >A
	a    r10, r3
	a    r12, r3
	li   r4, >100
	movb r4, *r3
	ab   r4, r2
L270
	cb   r2, r9
	jne  L284
	movb @>12(r10), r14
L265
	seto r3
	cb   r15, r3
	jeq  JMP_91
	b    @L266
JMP_91
	li   r9, >100
	cb   @>A(r10), r9
	jne  JMP_92
	b    @L285
JMP_92
	clr  r9
L286
	li   r3, >100
	cb   @>B(r10), r3
	jne  JMP_93
	b    @L342
JMP_93
L287
	li   r3, >100
	cb   @>C(r10), r3
	jne  JMP_94
	b    @L343
JMP_94
L288
	li   r3, >100
	cb   @>D(r10), r3
	jne  JMP_95
	b    @L344
JMP_95
L289
	ci   r9, >1FF
	jh  JMP_96
	b    @L290
JMP_96
	jeq  0
	cb  @playerdata(r8), @$-1
	jeq  JMP_97
	b    @L291
JMP_97
	mov  r10, r2
	ai   r2, >A
	bl   @humanchoosepawn
	movb r1, r15
	li   r3, >600
	cb   @throw, r3
	jeq  JMP_98
	b    @L292
JMP_98
L334
	li   r1, >100
	movb r1, @zv
	b    @L292
L332
	seto r15
	b    @L264
L330
	li   r2, >300
	cb   r13, r2
	jeq  JMP_99
	b    @L259
JMP_99
	clr  r14
	li   r2, >600
	cb   @throw, r2
	jne  JMP_100
	b    @L261
JMP_100
	li   r14, >100
	b    @L261
L329
	mov  r1, r2
	sla  r2, >3
	jeq  0
	cb  @playerpos(r2), @$-1
	jne  JMP_101
	b    @L345
JMP_101
	li   r13, >300
L253
	inc  r3
	a    r3, r3
	jeq  0
	cb  @playerpos(r3), @$-1
	jne  L254
	li   r13, >100
L254
	a    r1, r1
	inc  r1
	sla  r1, >2
	jeq  0
	cb  @playerpos(r1), @$-1
	jne  L255
	li   r13, >100
L255
	ai   r2, playerpos
	jeq  0
	cb  @>6(r2), @$-1
	jne  JMP_102
	b    @L251
JMP_102
	li   r1, >300
	cb   r13, r1
	jne  JMP_103
	b    @L324
JMP_103
	li   r2, cputsxy
	mov  r2, @>E(r10)
	b    @L256
L291
	mov  r10, r2
	ai   r2, >A
	bl   @computerchoosepawn
	movb r1, r15
	b    @L290
L331
	seto r15
	b    @L263
L325
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
	b    @L315
L298
	li   r0, >100
	cb   r9, r0
	jne  L300
	li   r4, >900
	cb   r3, r4
	jh  JMP_104
	b    @L303
JMP_104
	cb   r5, r4
	jle  JMP_105
	b    @L303
JMP_105
	jeq  0
	cb  r7, @$-1
	jeq  JMP_106
	b    @L303
JMP_106
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	movb r9, *r3+
	li   r2, >FA00
	ab   r2, *r3
	b    @L303
L345
	li   r13, >100
	b    @L253
L336
	cb   r5, r4
	jle  JMP_107
	b    @L303
JMP_107
	jeq  0
	cb  r7, @$-1
	jeq  JMP_108
	b    @L303
JMP_108
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	li   r4, >100
	movb r4, *r3+
	li   r1, >DC00
	ab   r1, *r3
	b    @L303
L300
	li   r4, >200
	cb   r9, r4
	jeq  JMP_109
	b    @L302
JMP_109
	li   r4, >1300
	cb   r3, r4
	jh  JMP_110
	b    @L303
JMP_110
	cb   r5, r4
	jle  JMP_111
	b    @L303
JMP_111
	jeq  0
	cb  r7, @$-1
	jeq  JMP_112
	b    @L303
JMP_112
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	movb r0, *r3+
	li   r4, >F000
	ab   r4, *r3
	b    @L303
L340
	ci   r5, >3FF
	jh  L268
	li   r3, >600
	cb   r13, r3
	jeq  L346
L282
	ai   r2, >100
	b    @L270
L346
	movb r2, r15
	movb r2, *r14
	li   r2, >400
	b    @L270
L268
	movb r5, r7
	ab   r13, r7
L279
	ci   r7, >7FF
	jh  L282
	mov  @>10(r10), r6
	clr  r5
	jmp  L283
L281
	ai   r5, >100
	inct r6
	cb   r5, r9
	jne  JMP_113
	b    @L271
JMP_113
L283
	cb   r2, r5
	jeq  L281
	cb   *r6, r0
	jne  L281
	movb @>1(r6), r3
	cb   r3, r7
	jh  L281
	ci   r3, >3FF
	jle  L281
	ai   r2, >100
	b    @L270
L272
	cb   r1, r0
	jne  L275
	li   r4, >900
	cb   r7, r4
	jh  JMP_114
	b    @L278
JMP_114
	cb   r5, r4
	jle  JMP_115
	b    @L278
JMP_115
	ai   r7, >FA00
	movb r1, r4
	b    @L274
L338
	li   r5, >100
	cb   r7, r5
	jeq  JMP_116
	b    @L307
JMP_116
	ai   r12, >FF00
	movb r12, *r4
	b    @L307
L337
	ci   r3, >3FF
	jh  JMP_117
	b    @L306
JMP_117
	movb r3, @dp(r12)
	b    @L306
L335
	ci   r5, >3FF
	jle  JMP_118
	b    @L296
JMP_118
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
	b    @L297
L275
	li   r4, >200
	cb   r1, r4
	jne  L277
	li   r4, >1300
	cb   r7, r4
	jh  JMP_119
	b    @L278
JMP_119
	cb   r5, r4
	jle  JMP_120
	b    @L278
JMP_120
	ai   r7, >F000
	li   r4, >100
	b    @L274
L344
	ab   r3, r9
	li   r15, >300
	b    @L289
L343
	ab   r3, r9
	li   r15, >200
	b    @L288
L342
	ab   r3, r9
	movb r3, r15
	b    @L287
L285
	clr  r15
	b    @L286
L341
	ai   r7, >DC00
	li   r4, >100
	b    @L274
L324
	li   r3, cputsxy
	mov  r3, @>E(r10)
	li   r1, >17
	li   r2, >7
	li   r3, LC5
	li   r4, cputsxy
	bl   *r4
	b    @L256
L277
	li   r4, >300
	cb   r1, r4
	jeq  JMP_121
	b    @L271
JMP_121
	li   r4, >1D00
	cb   r7, r4
	jh  JMP_122
	b    @L271
JMP_122
	cb   r5, r4
	jle  JMP_123
	b    @L271
JMP_123
	ai   r7, >E600
	b    @L279
L302
	li   r4, >300
	cb   r9, r4
	jeq  JMP_124
	b    @L303
JMP_124
	li   r4, >1D00
	cb   r3, r4
	jh  JMP_125
	b    @L305
JMP_125
	cb   r5, r4
	jle  JMP_126
	b    @L305
JMP_126
	jeq  0
	cb  r7, @$-1
	jeq  JMP_127
	b    @L305
JMP_127
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	ai   r4, playerpos
	movb r0, *r4+
	movb *r4, r3
	ai   r3, >E600
	movb r3, *r4
	b    @L305
	.size	turngeneric, .-turngeneric
LC8
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
	movb r2, r9
	movb r3, @>20(r10)
	movb r3, r13
	srl  r13, 8
	movb r2, r1
	movb @pulldownmenuoptions(r13), r2
	ai   r2, >400
	bl   @windowsave
	movb @>20(r10), r1
	cb   r1, @menubaroptions
	jle  JMP_128
	b    @L348
JMP_128
	srl  r14, 8
	mov  r14, @>10(r10)
	movb r9, r2
	srl  r2, 8
	mov  r2, @>1C(r10)
	dec  r13
	mov  r13, r3
	sla  r3, >4
	mov  r13, r1
	sla  r1, >6
	a    r1, r3
	ai   r3, pulldownmenutitles
	mov  r3, @>1E(r10)
	li   r1, strlen
	mov  r1, @>18(r10)
L353
	mov  r13, r2
	ai   r2, pulldownmenuoptions
	mov  r2, @>14(r10)
	movb *r2, r4
	jne  JMP_129
	b    @L375
JMP_129
	mov  @>1C(r10), r2
	inc  r2
	mov  r2, @>12(r10)
	mov  @>10(r10), r3
	inc  r3
	mov  r3, @>1A(r10)
	mov  r13, r1
	sla  r1, >2
	a    r13, r1
	mov  r1, @>16(r10)
	clr  r15
L354
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
	li   r1, LC8
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
	jh  L354
L350
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
	jmp  L355
L356
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
L355
	mov  r14, r1
	bl   *r15
	inc  r1
	movb r9, r4
	srl  r4, 8
	c    r1, r4
	jgt  L356
	jeq  L356
	mov  r10, r1
	ai   r1, >A
	li   r2, updownenter
	bl   @strcpy
	movb @>20(r10), r2
	cb   r2, @menubaroptions
	jh  JMP_130
	b    @L376
JMP_130
L357
	li   r13, >100
	li   r15, >1
L370
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
	jh  L370
	srl  r2, 8
	a    r2, r2
	mov  @L362(r2), r3
	b    *r3
	even
L362
		data		L359
		data		L359
		data		L360
		data		L360
		data		L370
		data		L361
L359
	movb r1, r13
	ai   r13, >A00
L361
	bl   @windowrestore
	movb r13, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >1A
	b    *r11
L360
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
	jeq  L377
	ai   r13, >100
	mov  @>14(r10), r2
	cb   r13, *r2
	jh  L357
L374
	movb r13, r15
	srl  r15, 8
	jmp  L370
L377
	ai   r13, >FF00
	jne  L374
	mov  @>14(r10), r1
	movb *r1, r13
	movb r13, r15
	srl  r15, 8
	jmp  L370
L376
	mov  r10, r1
	ai   r1, >A
	li   r2, leftright
	bl   @strcat
	b    @L357
L348
	srl  r14, 8
	mov  r14, @>10(r10)
	movb r9, r1
	srl  r1, 8
	mov  r1, @>1C(r10)
	mov  r1, r14
	sla  r14, >5
	mov  @>10(r10), r1
	a    @gImage, r1
	a    r14, r1
	li   r2, >6
	mov  @vdpchar, r3
	bl   *r3
	dec  r13
	mov  r13, r2
	sla  r2, >4
	mov  r13, r1
	sla  r1, >6
	a    r1, r2
	ai   r2, pulldownmenutitles
	mov  r2, @>1E(r10)
	clr  r9
	li   r3, strlen
	mov  r3, @>18(r10)
	mov  r2, r15
	mov  r13, @>12(r10)
	mov  r14, r13
	mov  r3, r14
	jmp  L351
L352
	mov  @gImage, r2
	inc  r2
	mov  @>10(r10), r1
	a    r1, r2
	a    r13, r2
	mov  r2, r1
	a    r3, r1
	li   r2, >1
	mov  @vdpchar, r3
	bl   *r3
	ai   r9, >100
L351
	mov  r15, r1
	bl   *r14
	inc  r1
	movb r9, r3
	srl  r3, 8
	c    r1, r3
	jgt  L352
	jeq  L352
	mov  @>12(r10), r13
	b    @L353
L375
	mov  @>1C(r10), r3
	inc  r3
	mov  r3, @>12(r10)
	b    @L350
	.size	menupulldown, .-menupulldown
LC9
	text '%s has won!'
	byte 0
LC10
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
	li   r1, LC9
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
	li   r3, LC10
	bl   @cputsxy
	li   r13, menupulldown
	li   r9, >200
	li   r14, >300
	li   r15, >100
L382
	li   r1, >F00
	li   r2, >A00
	li   r3, >700
	bl   *r13
	cb   r1, r9
	jeq  L385
	cb   r1, r14
	jeq  L386
	cb   r1, r15
	jne  L380
	jeq  0
	cb  @playerdata+1, @$-1
	jne  L380
	jeq  0
	cb  @playerdata+5, @$-1
	jne  L380
	jeq  0
	cb  @playerdata+9, @$-1
	jne  L380
	jeq  0
	cb  @playerdata+13, @$-1
	jeq  L382
L380
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @windowrestore
L386
	li   r1, >100
	movb r1, @endofgameflag
	movb r1, @zv
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @windowrestore
L385
	li   r1, >300
	movb r1, @endofgameflag
	bl   @gamereset
	li   r1, >100
	movb r1, @zv
	jmp  L380
	.size	playerwins, .-playerwins
LC11
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
	li   r3, LC11
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
	li   r2, C.51.1934
	li   r3, >4
	bl   @memcpy
	li   r1, >100
	movb r1, @>E(r10)
	li   r2, >1
	mov  r2, @>12(r10)
L405
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
	jmp  L390
L391
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
L390
	mov  r14, r1
	li   r4, strlen
	bl   *r4
	movb r9, r4
	srl  r4, 8
	c    r4, r1
	jlt  L391
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
	jne  JMP_131
	b    @L409
JMP_131
	li   r1, >900
	cb   r9, r1
	jne  JMP_132
	b    @L410
JMP_132
	li   r4, >D00
	cb   r9, r4
	jne  L405
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
	jlt  L396
	jeq  L396
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
L396
	movb r9, r1
	clr  r2
	movb @>E(r10), r3
	li   r4, menupulldown
	bl   *r4
	li   r2, >1200
	cb   r1, r2
	jne  JMP_133
	b    @L411
JMP_133
	li   r3, >1300
	cb   r1, r3
	jeq  L412
	jeq  0
	cb  r1, @$-1
	jne  JMP_134
	b    @L405
JMP_134
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
L409
	movb @>E(r10), r1
	ai   r1, >FF00
	movb r1, @>E(r10)
	jne  L408
	movb @menubaroptions, r3
	movb r3, @>E(r10)
	movb r3, r4
	srl  r4, 8
	mov  r4, @>12(r10)
	b    @L405
L410
	movb @>E(r10), r2
	ai   r2, >100
	movb r2, @>E(r10)
	cb   r2, @menubaroptions
	jh  L395
	movb r2, r3
	srl  r3, 8
	mov  r3, @>12(r10)
	b    @L405
L407
	movb @menubaroptions, r1
	movb r1, @>E(r10)
L408
	movb r1, r2
	srl  r2, 8
	mov  r2, @>12(r10)
	b    @L405
L395
	li   r2, >100
	movb r2, @>E(r10)
	li   r3, >1
	mov  r3, @>12(r10)
	b    @L405
L412
	movb @>E(r10), r4
	ai   r4, >100
	movb r4, @>E(r10)
	cb   r4, @menubaroptions
	jh  L399
	movb r4, r1
	srl  r1, 8
	mov  r1, @>12(r10)
	b    @L405
L411
	movb @>E(r10), r3
	ai   r3, >FF00
	movb r3, @>E(r10)
	jeq  L407
	movb r3, r4
	srl  r4, 8
	mov  r4, @>12(r10)
	b    @L405
L399
	li   r4, >100
	movb r4, @>E(r10)
	li   r1, >1
	mov  r1, @>12(r10)
	b    @L405
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
	li   r4, >2003
	movb r4, @>A(r10)
	swpb r4
	movb r4, @>B(r10)
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
L414
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
	jlt  L414
	jeq  L414
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
	jle  L441
L416
	movb @>58(r10), r3
	cb   r9, r3
	jhe  JMP_135
	b    @L442
JMP_135
L423
	movb r9, r13
L426
	movb r13, r9
L443
	mov  r10, r1
	ai   r1, >A
	clr  r2
	li   r4, getkey
	bl   *r4
	movb r1, r4
	ai   r4, >FD00
	ci   r4, >AFF
	jh  L416
L441
	srl  r4, 8
	a    r4, r4
	mov  @L422(r4), r3
	b    *r3
	even
L422
		data		L417
		data		L418
		data		L416
		data		L416
		data		L416
		data		L419
		data		L420
		data		L416
		data		L416
		data		L416
		data		L421
L421
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
L420
	mov  r14, r1
	li   r3, strlen
	bl   *r3
	movb r9, r4
	srl  r4, 8
	c    r4, r1
	jgt  L423
	jeq  L423
	movb @>58(r10), r4
	cb   r9, r4
	jhe  L423
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
	b    @L443
L419
	jeq  0
	cb  r9, @$-1
	jne  JMP_136
	b    @L423
JMP_136
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
	jeq  JMP_137
	b    @L430
JMP_137
	li   r2, >1A
L431
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
	b    @L443
L418
	mov  r14, r1
	li   r4, strlen
	bl   *r4
	mov  r1, r4
	swpb r4
	movb @>58(r10), r1
	cb   r1, r4
	jh  JMP_138
	b    @L423
JMP_138
	jeq  0
	cb  r4, @$-1
	jne  JMP_139
	b    @L423
JMP_139
	cb   r9, r4
	jl  JMP_140
	b    @L423
JMP_140
	ai   r4, >100
	cb   r9, r4
	jh  L427
	movb r4, r5
	srl  r5, 8
	a    r14, r5
	movb *r5, @>1(r5)
	jeq  0
	cb  r4, @$-1
	jne  L438
	jmp  L427
L429
	movb r4, r1
	srl  r1, 8
	a    r14, r1
	movb *r1, @>1(r1)
	jeq  0
	cb  r4, @$-1
	jeq  L427
L438
	ai   r4, >FF00
	cb   r9, r4
	jle  L429
L427
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
	b    @L443
L417
	jeq  0
	cb  r9, @$-1
	jne  JMP_141
	b    @L423
JMP_141
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
	jeq  L424
	movb r13, @>5E(r10)
	mov  r3, r13
L435
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
	jne  L435
	movb @>5E(r10), r13
L424
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
	jeq  L444
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
L445
	movb r13, r9
	b    @L443
L442
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
	jeq  JMP_142
	b    @L426
JMP_142
	movb r13, r4
	srl  r4, 8
	a    r14, r4
	movb r3, @>1(r4)
	movb r13, r9
	b    @L443
L444
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
	jmp  L445
L430
	movb r5, r2
	srl  r2, 8
	b    @L431
	.size	input, .-input
LC12
	text 'Computer plays player %d?'
	byte 0
LC13
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
L449
	li   r1, >4
	mov  r1, @conio_x
	li   r2, >A
	mov  r2, @conio_y
	inc  r9
	ai   r10, >FFFC
	li   r4, LC12
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
	jeq  L452
	clr  r4
	movb r4, *r13
L448
	li   r5, >4
	mov  r5, @conio_x
	li   r1, >A
	mov  r1, @conio_y
	ai   r10, >FFFC
	li   r2, LC13
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
	jne  L449
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @windowrestore
L452
	movb r2, *r13
	jmp  L448
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
	jlt  L457
	mov  r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    @cputs
L457
	s    r4, r2
	neg  r2
	jlt  L458
	sra  r2, >1
	dec  r2
	mov  r2, r1
	swpb r1
	bl   @cspaces
L459
	mov  r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    @cputs
L458
	inc  r2
	sra  r2, >1
	dec  r2
	mov  r2, r1
	swpb r1
	bl   @cspaces
	jmp  L459
	.size	printcentered, .-printcentered
LC14
	text 'L U D O'
	byte 0
LC15
	text 'Written by Xander Mol'
	byte 0
LC16
	text 'Converted TI-99/4a, 2021'
	byte 0
LC17
	text 'From Commodore 128 1992'
	byte 0
LC18
	text 'Build with/using code of'
	byte 0
LC19
	text 'TMS9900-GCC by Insomnia'
	byte 0
LC20
	text 'Libti99 lib by Tursi'
	byte 0
LC21
	text 'Jedimatt42 help/code'
	byte 0
LC22
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
	li   r9, >7631
	movb r9, @>4(r10)
	swpb r9
	movb r9, @>5(r10)
	li   r1, >3900
	movb r1, @>6(r10)
	movb r1, @>7(r10)
	li   r1, >2000
	movb r1, @>8(r10)
	li   r0, >2D20
	movb r0, @>9(r10)
	swpb r0
	movb r0, @>A(r10)
	li   r12, >3230
	movb r12, @>B(r10)
	swpb r12
	movb r12, @>C(r10)
	li   r8, >3231
	movb r8, @>D(r10)
	swpb r8
	movb r8, @>E(r10)
	li   r7, >3033
	movb r7, @>F(r10)
	swpb r7
	movb r7, @>10(r10)
	li   r6, >3233
	movb r6, @>11(r10)
	swpb r6
	movb r6, @>12(r10)
	li   r5, >2D31
	movb r5, @>13(r10)
	swpb r5
	movb r5, @>14(r10)
	li   r1, >3500
	movb r1, @>15(r10)
	movb r1, @>16(r10)
	li   r1, >3200
	movb r1, @>17(r10)
	clr  r1
	li   r2, >500
	li   r3, >E00
	li   r4, >1E00
	bl   @menumakeborder
	li   r9, printcentered
	li   r1, LC14
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
	li   r1, LC15
	li   r2, >200
	li   r3, >A00
	li   r4, >1C00
	bl   *r9
	li   r1, LC16
	li   r2, >200
	li   r3, >B00
	li   r4, >1C00
	bl   *r9
	li   r1, LC17
	li   r2, >200
	li   r3, >C00
	li   r4, >1C00
	bl   *r9
	li   r1, LC18
	li   r2, >200
	li   r3, >E00
	li   r4, >1C00
	bl   *r9
	li   r1, LC19
	li   r2, >200
	li   r3, >F00
	li   r4, >1C00
	bl   *r9
	li   r1, LC20
	li   r2, >200
	li   r3, >1000
	li   r4, >1C00
	bl   *r9
	li   r1, LC21
	li   r2, >200
	li   r3, >1100
	li   r4, >1C00
	bl   *r9
	li   r1, LC22
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
LC23
	text 'Autosave on '
	byte 0
LC24
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
	li   r15, >1600
	jmp  L473
L463
	movb r9, r1
	ai   r1, >F500
	ci   r1, >2FF
	jle  L474
L471
	cb   r9, r15
	jeq  L474
L473
	bl   *r14
	movb r1, r9
	ai   r1, >F400
	cb   r1, r13
	jh  L463
	srl  r1, 8
	a    r1, r1
	mov  @L469(r1), r2
	b    *r2
	even
L469
		data		L464
		data		L465
		data		L463
		data		L463
		data		L463
		data		L463
		data		L463
		data		L463
		data		L463
		data		L463
		data		L466
		data		L467
		data		L463
		data		L463
		data		L463
		data		L463
		data		L463
		data		L463
		data		L463
		data		L463
		data		L463
		data		L463
		data		L463
		data		L463
		data		L463
		data		L463
		data		L463
		data		L463
		data		L463
		data		L468
L467
	li   r4, >100
	cb   @autosavetoggle, r4
	jeq  L476
	li   r1, >100
	movb r1, @autosavetoggle
	li   r1, pulldownmenutitles+112
	li   r2, LC24
	li   r3, >D
	li   r4, memcpy
	bl   *r4
	cb   r9, r15
	jne  L473
L474
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	jmp  L477
L466
	li   r2, areyousure
	bl   *r2
	jmp  L471
L468
	li   r1, informationcredits
	bl   *r1
	jmp  L471
L465
	bl   @areyousure
	li   r2, >100
	cb   r1, r2
	jne  L474
	movb r1, @endofgameflag
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	jmp  L477
L464
	bl   @areyousure
	li   r2, >100
	cb   r1, r2
	jne  L474
	li   r4, >300
	movb r4, @endofgameflag
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @gamereset
L476
	clr  r1
	movb r1, @autosavetoggle
	li   r1, pulldownmenutitles+112
	li   r2, LC23
	li   r3, >D
	li   r4, memcpy
	bl   *r4
	b    @L471
L477
	.size	turnhuman, .-turnhuman
LC25
	text 'Load old game?'
	byte 0
LC26
	text 'Player %d'
	byte 0
LC27
	text 'Color'
	byte 0
LC28
	text 'Computer'
	byte 0
LC29
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
	li   r1, >800
	li   r2, >500
	li   r3, >600
	li   r4, >1400
	bl   @menumakeborder
	li   r15, cputsxy
	li   r1, >A
	li   r2, >7
	li   r3, LC25
	bl   *r15
	li   r1, >1100
	li   r2, >800
	li   r3, >500
	bl   @menupulldown
	bl   @windowrestore
	bl   @loadmainscreen
	movb @endofgameflag, r1
	li   r9, >100
	li   r14, >300
L490
	jeq  0
	cb  r1, @$-1
	jne  JMP_143
	b    @L479
JMP_143
	clr  r1
	movb r1, @endofgameflag
L480
	li   r13, turngeneric
L492
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
	li   r4, LC26
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
	li   r3, LC27
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
	jeq  JMP_144
	b    @L481
JMP_144
	li   r5, turnhuman
	bl   *r5
L482
	movb @endofgameflag, r1
	jne  L483
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
	jeq  L496
L484
	movb @zv, r3
L488
	cb   r3, r9
	jeq  L485
	seto r1
	movb r1, @np(r4)
	movb r5, r2
	ai   r2, >100
	cb   r2, r14
	jle  L486
	clr  r2
L486
	jeq  0
	cb  r3, @$-1
	jne  L487
	movb r2, r5
	movb r2, r4
	srl  r4, 8
L485
	clr  r3
	mov  r4, r1
	sla  r1, >2
	ai   r1, playerdata
	jeq  0
	cb  @>1(r1), @$-1
	jeq  L488
L487
	movb r2, @turnofplayernr
	movb r3, @zv
	movb @endofgameflag, r1
	jne  JMP_145
	b    @L492
JMP_145
L483
	cb   r1, r9
	jeq  JMP_146
	b    @L490
JMP_146
	bl   @clrscr
	clr  r1
	bl   @bgcolor
	clr  r1
	mov  r1, r2
	li   r3, LC29
	bl   *r15
	clr  r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
L496
	bl   @playerwins
	movb @turnofplayernr, r2
	movb r2, r5
	movb r2, r4
	srl  r4, 8
	jmp  L484
L481
	li   r1, >17
	li   r2, >5
	li   r3, LC28
	li   r4, cputsxy
	bl   *r4
	b    @L482
L479
	li   r2, inputofnames
	bl   *r2
	b    @L480
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

	even
	cseg
	.type	autosavetoggle, @object
	.size	autosavetoggle, 1
autosavetoggle
	bss 1
	pseg
	.type	C.93.2295, @object
	.size	C.93.2295, 5
C.93.2295
	byte	8
	byte	9
	byte	11
	byte	10
	byte	13
	even
	.type	random_mask.1456, @object
	.size	random_mask.1456, 2
random_mask.1456
	data	-19456
	dseg
	even
	.type	seed.1455, @object
	.size	seed.1455, 2
seed.1455
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
	.type	C.51.1934, @object
	.size	C.51.1934, 4
C.51.1934
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

	ref	memset

	ref	cputs

	ref	strlen

	ref	vdpchar

	ref	gImage

	ref	cputc

	ref	strcpy

	ref	cgetc

	ref	kscanfast

	ref	joystfast

	ref	kbhit

	ref	vdpmemcpy

	ref	vdpmemread

	ref	gPattern

	ref	gColor

	ref	set_graphics
