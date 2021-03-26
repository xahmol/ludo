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
	jeq  L11
	srl  r3, 8
	movb @>1(r4), r2
	srl  r2, 8
	sla  r1, >3
	a    r2, r1
	a    r1, r1
	a    r3, r1
	movb @homedestcoords(r1), r1
	b    *r11
	jmp  L12
L11
	srl  r3, 8
	movb @>1(r4), r1
	srl  r1, 8
	a    r1, r1
	a    r3, r1
	movb @fieldcoords(r1), r1
	b    *r11
L12
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
	jmp  L53
L64
	li   r1, >D8F0
	mov  r1, *r14
L15
	mov  @>12(r10), r2
	inc  r2
	mov  r2, @>12(r10)
	inct r14
	mov  @>1A(r10), r1
	inct r1
	mov  r1, @>1A(r10)
	ai   r2, >FFFC
	jne  JMP_0
	b    @L32
JMP_0
L53
	mov  @>20(r10), r1
	mov  @>12(r10), r2
	a    r2, r1
	jeq  0
	cb  *r1, @$-1
	jeq  L64
	mov  @>1A(r10), r2
	movb *r2, @>1F(r10)
	mov  @>1A(r10), r1
	movb @>1(r1), r1
	movb r1, @>1E(r10)
	movb @>22(r10), r2
	ab   r1, r2
	movb r2, @>1D(r10)
	movb @>1F(r10), r1
	jeq  JMP_1
	b    @L16
JMP_1
	jeq  0
	cb  r15, @$-1
	jeq  JMP_2
	b    @L17
JMP_2
	li   r1, >2700
	cb   r2, r1
	jle  L23
	movb @>1E(r10), r2
	cb   r2, r1
	jh  JMP_3
	b    @L65
JMP_3
L23
	movb @>1D(r10), @>1C(r10)
L26
	li   r2, >2700
	movb @>1C(r10), r1
	cb   r1, r2
	jle  L28
	ai   r1, >D800
	movb r1, @>1C(r10)
L28
	clr  r13
L30
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
L33
	mov  r6, r4
	sla  r4, >3
	ai   r4, playerpos
	mov  @>10(r10), r5
	clr  r3
	mov  r6, r8
	sla  r8, >2
	li   r0, >D00
L44
	cb   r15, r9
	jne  JMP_4
	b    @L66
JMP_4
	movb *r4, r1
	cb   r1, r13
	jne  JMP_5
	b    @L67
JMP_5
L36
	jeq  0
	cb  r1, @$-1
	jne  L37
	jeq  0
	cb  r13, @$-1
	jne  L37
L59
	cb   r15, r9
	jeq  L37
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
	jh  L42
	li   r2, >190
	a    r2, *r14
L42
	mov  @>16(r10), r2
	s    r1, r2
	dec  r2
	ci   r2, >4
	jh  L43
	li   r2, >FF38
	a    r2, *r14
L43
	mov  @>18(r10), r2
	s    r2, r1
	dec  r1
	ci   r1, >4
	jh  L37
	li   r1, >64
	a    r1, *r14
L37
	inc  r3
	inct r4
	inct r5
	ci   r3, >4
	jne  L44
	ai   r9, >100
	inc  r6
	ai   r7, >8
	li   r1, >400
	cb   r9, r1
	jeq  JMP_6
	b    @L33
JMP_6
	jeq  0
	cb  r13, @$-1
	jne  L46
	movb @>1C(r10), r2
	jne  JMP_7
	b    @L47
JMP_7
	li   r2, >A00
	movb @>1C(r10), r1
	cb   r1, r2
	jne  JMP_8
	b    @L47
JMP_8
	li   r2, >1400
	cb   r1, r2
	jne  JMP_9
	b    @L47
JMP_9
	li   r2, >1E00
	cb   r1, r2
	jne  JMP_10
	b    @L47
JMP_10
L46
	movb @>1F(r10), r1
	jne  L48
	movb @>1E(r10), r2
	jeq  L49
	li   r2, >A00
	movb @>1E(r10), r1
	cb   r1, r2
	jeq  L49
	li   r2, >1400
	cb   r1, r2
	jeq  L49
	li   r2, >1E00
	cb   r1, r2
	jeq  L49
L48
	jeq  0
	cb  r15, @$-1
	jne  L50
L70
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
	jeq  JMP_11
	b    @L53
JMP_11
L32
	mov  @>20(r10), r5
	clr  r2
	li   r4, >B1E0
	movb r2, r1
	li   r7, >100
	li   r6, >400
	mov  @>26(r10), r8
L57
	mov  *r8, r3
	c    r3, r4
	jlt  L54
	jeq  L54
	cb   *r5, r7
	jne  JMP_12
	b    @L68
JMP_12
L54
	mov  r4, r3
	ai   r2, >100
	inct r8
	inc  r5
	cb   r2, r6
	jne  JMP_13
	b    @L69
JMP_13
L56
	mov  r3, r4
	jmp  L57
L49
	li   r2, >7D0
	a    r2, *r14
	jeq  0
	cb  r15, @$-1
	jeq  L70
L50
	li   r1, >100
	cb   r15, r1
	jeq  JMP_14
	b    @L51
JMP_14
	mov  *r14, r2
	ai   r2, >FFF6
	movb @>1D(r10), r1
	srl  r1, 8
	a    r1, r2
	mov  r2, *r14
	b    @L15
L47
	li   r2, >F060
	a    r2, *r14
	b    @L46
L66
	cb   @>FFFF(r5), r13
	jeq  L71
L35
	mov  r3, r1
	a    r3, r1
	a    r7, r1
	movb *r1, r1
	b    @L36
L71
	cb   *r5, r12
	jne  L35
	li   r1, >E0C0
	a    r1, *r14
	mov  r3, r1
	a    r3, r1
	a    r7, r1
	movb *r1, r1
	b    @L36
L67
	cb   @>1(r4), r12
	jeq  JMP_15
	b    @L36
JMP_15
	mov  *r14, r2
	ai   r2, >FA0
	mov  r2, *r14
	jeq  0
	cb  r13, @$-1
	jeq  JMP_16
	b    @L37
JMP_16
	jeq  0
	cb  r9, @$-1
	jne  L38
	ci   r12, >21FF
	jh  JMP_17
	b    @L59
JMP_17
	ai   r2, >BB8
	mov  r2, *r14
	b    @L59
L38
	li   r1, >100
	cb   r9, r1
	jeq  JMP_18
	b    @L40
JMP_18
	ci   r12, >3FF
	jh  JMP_19
	b    @L59
JMP_19
	ai   r2, >BB8
	mov  r2, *r14
	b    @L59
L16
	movb @>1F(r10), r13
	movb @>1D(r10), @>1C(r10)
L25
	li   r2, >100
	cb   r13, r2
	jeq  JMP_20
	b    @L30
JMP_20
L27
	li   r2, >300
	movb @>1C(r10), r1
	cb   r1, r2
	jle  L62
	li   r1, >100
	mov  @>24(r10), r2
	cb   *r2, r1
	jne  JMP_21
	b    @L72
JMP_21
	li   r1, >1770
	a    r1, *r14
L62
	li   r13, >100
	b    @L30
L17
	li   r2, >100
	cb   r15, r2
	jne  L20
	li   r2, >900
	movb @>1D(r10), r1
	cb   r1, r2
	jle  L24
	movb @>1E(r10), r1
	cb   r1, r2
	jh  L24
	movb @>1D(r10), r2
	ai   r2, >FA00
	movb r2, @>1C(r10)
	jmp  L27
L24
	movb @>1D(r10), @>1C(r10)
	b    @L26
L40
	li   r1, >200
	cb   r9, r1
	jeq  JMP_22
	b    @L41
JMP_22
	cb   r12, r0
	jh  JMP_23
	b    @L59
JMP_23
	ai   r2, >BB8
	mov  r2, *r14
	b    @L59
L51
	li   r2, >200
	cb   r15, r2
	jne  L52
	mov  *r14, r2
	ai   r2, >FFEC
	movb @>1D(r10), r1
	srl  r1, 8
	a    r1, r2
	mov  r2, *r14
	b    @L15
L68
	movb r2, r1
	ai   r2, >100
	inct r8
	inc  r5
	cb   r2, r6
	jeq  JMP_24
	b    @L56
JMP_24
L69
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >22
	b    *r11
L20
	li   r2, >200
	cb   r15, r2
	jeq  JMP_25
	b    @L22
JMP_25
	li   r2, >1300
	movb @>1D(r10), r1
	cb   r1, r2
	jh  JMP_26
	b    @L23
JMP_26
	movb @>1E(r10), r1
	cb   r1, r2
	jle  JMP_27
	b    @L23
JMP_27
	movb @>1D(r10), r2
	ai   r2, >F000
	movb r2, @>1C(r10)
	b    @L27
L65
	movb @>1D(r10), r1
	ai   r1, >DC00
	movb r1, @>1C(r10)
	b    @L27
L72
	mov  @>12(r10), r1
	a    r1, r1
	li   r2, >8
	a    r10, r2
	a    r2, r1
	li   r2, >2710
	mov  r2, *r1
	b    @L32
L52
	li   r2, >300
	cb   r15, r2
	jeq  JMP_28
	b    @L15
JMP_28
	mov  *r14, r2
	ai   r2, >FFE2
	movb @>1D(r10), r1
	srl  r1, 8
	a    r1, r2
	mov  r2, *r14
	b    @L15
L41
	li   r2, >300
	cb   r9, r2
	jeq  JMP_29
	b    @L59
JMP_29
	ci   r12, >17FF
	jh  JMP_30
	b    @L59
JMP_30
	li   r2, >BB8
	a    r2, *r14
	b    @L59
L22
	li   r2, >300
	cb   r15, r2
	jeq  JMP_31
	b    @L24
JMP_31
	li   r2, >1D00
	movb @>1D(r10), r1
	cb   r1, r2
	jh  JMP_32
	b    @L24
JMP_32
	movb @>1E(r10), r1
	cb   r1, r2
	jle  JMP_33
	b    @L24
JMP_33
	movb @>1D(r10), r2
	ai   r2, >E600
	movb r2, @>1C(r10)
	li   r13, >100
	b    @L25
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
	jeq  L76
	clr  r9
	li   r13, cprintf
L75
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
	jh  L75
L76
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
	jne  L79
	movb @>1(r4), r2
	srl  r2, 8
	a    r2, r2
	ai   r2, fieldcoords
	movb *r2+, r4
	movb *r2, r2
	jeq  0
	cb  r3, @$-1
	jne  L90
L81
	li   r3, >100
	cb   r1, r3
	jne  JMP_34
	b    @L84
JMP_34
	cb   r1, r3
	jhe  L91
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
L79
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
	jeq  L81
L90
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
L91
	li   r3, >200
	cb   r1, r3
	jeq  L85
	li   r3, >300
	cb   r1, r3
	jeq  L92
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
L85
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
L84
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
L92
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
	jne  L94
	movb @>1(r3), r3
	movb r3, r2
	srl  r2, 8
	a    r2, r2
	ai   r2, fieldcoords
	movb *r2+, r1
	movb *r2, r2
	jeq  0
	cb  r3, @$-1
	jne  L109
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
L108
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @cputcxy
L94
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
	jne  JMP_35
	b    @L99
JMP_35
	cb   r1, r3
	jl  L98
	li   r3, >200
	cb   r1, r3
	jne  JMP_36
	b    @L100
JMP_36
	li   r3, >300
	cb   r1, r3
	jne  JMP_37
	b    @L110
JMP_37
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
L109
	li   r4, >A00
	cb   r3, r4
	jne  JMP_38
	b    @L102
JMP_38
	li   r4, >1400
	cb   r3, r4
	jne  JMP_39
	b    @L103
JMP_39
	li   r4, >1E00
	cb   r3, r4
	jne  JMP_40
	b    @L111
JMP_40
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
L98
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
	b    @L108
L99
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
	b    @L108
L102
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
	b    @L108
L110
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
	b    @L108
L100
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
	b    @L108
L103
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
	b    @L108
L111
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
	b    @L108
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
L115
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
	jne  L115
	mov  *r10+, r11
	b    *r11
	.size	gamereset, .-gamereset
	even

	def	wait
wait
	ai   r10, >FFF2
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	mov  r1, @>C(r10)
	jne  JMP_41
	b    @L122
JMP_41
	clr  r1
	mov  r1, @>A(r10)
	jmp  L121
L120
	mov  @>A(r10), r1
	inc  r1
	mov  r1, @>A(r10)
	mov  @>C(r10), r2
	c    r2, r1
	jh  JMP_42
	b    @L122
JMP_42
L121
* Begin inline assembler code
* 249 "main.c" 1
	clr r12
	tb 2
	jeq -4
	movb @>8802,r12
* 0 "" 2
* End of inline assembler code
	jeq  0
	cb  @musicnumber, @$-1
	jne  JMP_43
	b    @L120
JMP_43
* Begin inline assembler code
* 252 "main.c" 1
	bl @SongLoop
* 0 "" 2
* End of inline assembler code
	mov  @songNote+6, r1
	andi r1, >1
	jeq  JMP_44
	b    @L120
JMP_44
	li   r1, musicmem
	clr  r2
	li   r3, StartSong
	bl   *r3
	mov  @>A(r10), r1
	inc  r1
	mov  r1, @>A(r10)
	mov  @>C(r10), r2
	c    r2, r1
	jle  JMP_45
	b    @L121
JMP_45
L122
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	.size	wait, .-wait
	even

	def	graphicsinit
graphicsinit
	ai   r10, >FFFC
	mov  r11, *r10
	mov  r9, @>2(r10)
	clr  r1
	bl   @set_graphics
	li   r1, >1000
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
	jne  JMP_46
	b    @L150
JMP_46
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
	jlt  L155
	mov  r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    @cputs
L155
	s    r4, r2
	neg  r2
	jlt  L156
	sra  r2, >1
	dec  r2
	mov  r2, r1
	swpb r1
	bl   @cspaces
L157
	mov  r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    @cputs
L156
	inc  r2
	sra  r2, >1
	dec  r2
	mov  r2, r1
	swpb r1
	bl   @cspaces
	jmp  L157
	.size	printcentered, .-printcentered
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
	jeq  L161
	srl  r1, 8
	mov  r1, @>A(r10)
	clr  r13
	clr  r9
	srl  r2, 8
	mov  r2, @>C(r10)
L160
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
	jh  L160
L161
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
L205
	mov  @seed.1515, r1
* Begin inline assembler code
* 231 "main.c" 1
	srl r1,1  
	jnc 1f    
	xor @random_mask.1516,r1 
	1:        
	
* 0 "" 2
* End of inline assembler code
	mov  r1, @seed.1515
	jeq  0
	cb  @musicnumber, @$-1
	jne  L210
L164
	jeq  0
	cb  @joyinterface, @$-1
	jeq  L165
	movb @>C(r10), r4
	jeq  JMP_47
	b    @L211
JMP_47
L165
	bl   @kbhit
	jeq  0
	cb  r1, @$-1
	jeq  JMP_48
	b    @L190
JMP_48
	clr  r5
	movb r1, r8
L189
	mov  @>A(r10), r2
	jmp  L194
L212
	inc  r2
L194
	movb *r2, r1
	movb r1, r3
	srl  r3, 8
	c    r3, r5
	jne  JMP_49
	b    @L192
JMP_49
	jeq  0
	cb  r1, @$-1
	jne  L212
L193
	li   r2, >D00
	cb   r8, r2
	jeq  JMP_50
	b    @L205
JMP_50
	movb r8, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	b    @L213
L210
	li   r1, vdpwaitvint
	bl   *r1
* Begin inline assembler code
* 366 "main.c" 1
	bl @SongLoop
* 0 "" 2
* End of inline assembler code
	mov  @songNote+6, r1
	andi r1, >1
	jeq  JMP_51
	b    @L164
JMP_51
	li   r1, musicmem
	clr  r2
	bl   @StartSong
	b    @L164
L192
	ci   r2, 0
	jne  JMP_52
	b    @L193
JMP_52
	jeq  0
	cb  r8, @$-1
	jne  JMP_53
	b    @L205
JMP_53
	movb r8, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	b    @L213
L211
	li   r1, >1
	li   r5, joystfast
	bl   *r5
	li   r1, >1
	li   r2, kscanfast
	bl   *r2
	movb @>8377, r15
	movb @>8376, r14
	movb @>8375, r13
	li   r1, >2
	li   r4, joystfast
	bl   *r4
	li   r1, >2
	li   r5, kscanfast
	bl   *r5
	movb @>8377, r3
	movb @>8376, r2
	movb @>8375, r1
	seto r4
	cb   r13, r4
	jne  JMP_54
	b    @L214
JMP_54
L166
	li   r8, >D00
	li   r5, >400
	cb   r15, r5
	jne  JMP_55
	b    @L215
JMP_55
L168
	li   r1, >400
	cb   r3, r1
	jne  JMP_56
	b    @L216
JMP_56
L170
	li   r4, >FC00
	cb   r15, r4
	jne  JMP_57
	b    @L171
JMP_57
	li   r5, >FC00
	cb   r3, r5
	jne  JMP_58
	b    @L171
JMP_58
L172
	li   r1, >FC00
	cb   r14, r1
	jne  JMP_59
	b    @L217
JMP_59
L173
	li   r4, >FC00
	cb   r2, r4
	jne  JMP_60
	b    @L218
JMP_60
L175
	li   r5, >400
	cb   r14, r5
	jne  JMP_61
	b    @L176
JMP_61
	li   r1, >400
	cb   r2, r1
	jne  JMP_62
	b    @L176
JMP_62
L223
	jeq  0
	cb  r8, @$-1
	jne  JMP_63
	b    @L165
JMP_63
L207
	movb r8, @>D(r10)
L204
	li   r1, >1
	li   r2, joystfast
	bl   *r2
	li   r1, >1
	li   r4, kscanfast
	bl   *r4
	movb @>8377, r14
	movb @>8376, r15
	movb @>8375, r13
	li   r1, >2
	li   r5, joystfast
	bl   *r5
	li   r1, >2
	li   r2, kscanfast
	bl   *r2
	movb @>8377, r4
	movb @>8376, r3
	movb @>8375, r2
	seto r5
	cb   r13, r5
	jne  JMP_64
	b    @L178
JMP_64
L208
	li   r1, >100
	li   r2, >400
	cb   r14, r2
	jne  JMP_65
	b    @L219
JMP_65
L181
	li   r5, >400
	cb   r4, r5
	jne  JMP_66
	b    @L220
JMP_66
L183
	li   r2, >FC00
	cb   r14, r2
	jne  JMP_67
	b    @L184
JMP_67
	li   r5, >FC00
	cb   r4, r5
	jne  JMP_68
	b    @L184
JMP_68
L185
	li   r2, >FC00
	cb   r15, r2
	jne  JMP_69
	b    @L221
JMP_69
L186
	li   r4, >FC00
	cb   r3, r4
	jne  JMP_70
	b    @L222
JMP_70
L188
	li   r5, >400
	cb   r15, r5
	jeq  L204
L187
	li   r2, >400
	cb   r3, r2
	jne  JMP_71
	b    @L204
JMP_71
	li   r4, >100
	cb   r1, r4
	jne  JMP_72
	b    @L204
JMP_72
	movb @>D(r10), r8
	movb r8, r5
	srl  r5, 8
	b    @L189
L214
	cb   r1, r4
	jeq  JMP_73
	b    @L166
JMP_73
	clr  r8
	li   r5, >400
	cb   r15, r5
	jeq  JMP_74
	b    @L168
JMP_74
L215
	li   r8, >900
	li   r5, >FC00
	cb   r3, r5
	jeq  JMP_75
	b    @L172
JMP_75
L171
	li   r8, >800
	li   r1, >FC00
	cb   r14, r1
	jeq  JMP_76
	b    @L173
JMP_76
L217
	li   r8, >A00
	li   r1, >400
	cb   r2, r1
	jeq  JMP_77
	b    @L223
JMP_77
L176
	li   r8, >B00
	b    @L207
L178
	clr  r1
	seto r5
	cb   r2, r5
	jeq  JMP_78
	b    @L208
JMP_78
	li   r2, >400
	cb   r14, r2
	jeq  JMP_79
	b    @L181
JMP_79
L219
	li   r1, >100
	li   r5, >FC00
	cb   r4, r5
	jeq  JMP_80
	b    @L185
JMP_80
L184
	li   r1, >100
	li   r2, >FC00
	cb   r15, r2
	jeq  JMP_81
	b    @L186
JMP_81
L221
	li   r1, >100
	b    @L187
L220
	li   r1, >100
	b    @L183
L222
	li   r1, >100
	b    @L188
L190
	bl   @cgetc
	movb r1, r8
	mov  @>A(r10), r5
	jeq  0
	cb  *r5, @$-1
	jne  L191
	li   r5, >D
	li   r8, >D00
	b    @L189
L218
	li   r8, >A00
	b    @L175
L216
	li   r8, >900
	b    @L170
L191
	movb r1, r5
	srl  r5, 8
	b    @L189
L213
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
	li   r2, C.117.2627
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
	jeq  L249
	cb   @>2(r14), r9
	jne  JMP_82
	b    @L251
JMP_82
	cb   @>3(r14), r9
	jne  JMP_83
	b    @L252
JMP_83
	cb   @>4(r14), r9
	jne  JMP_84
	b    @L229
JMP_84
	li   r9, >400
L249
	li   r1, pawnplace
	mov  r1, @>12(r10)
	li   r3, getkey
	mov  r3, @>14(r10)
L248
	li   r4, >300
L247
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
	jne  JMP_85
	b    @L230
JMP_85
	li   r3, >A00
	cb   r13, r3
	jeq  L230
L231
	li   r5, >900
	cb   r13, r5
	jeq  L232
	li   r1, >B00
	cb   r13, r1
	jeq  L232
	li   r2, >D00
	cb   r13, r2
	jeq  L234
L254
	cb   r9, r4
	jlt  L235
	jeq  L235
	clr  r9
L236
	movb r9, r2
	sra  r2, 8
L237
	a    r14, r2
	li   r3, >100
	cb   *r2, r3
	jeq  L247
	ab   r15, r9
	cb   r9, r4
	jlt  L238
	jeq  L238
L253
	clr  r9
L239
	movb r9, r1
	sra  r1, 8
L240
	a    r14, r1
	cb   *r1, r3
	jeq  L247
	ab   r15, r9
	cb   r9, r4
	jgt  L253
L238
	jeq  0
	cb  r9, @$-1
	jgt  L239
	jeq  L239
	li   r1, >3
	li   r9, >300
	jmp  L240
L232
	ai   r9, >100
	li   r15, >100
	li   r2, >D00
	cb   r13, r2
	jne  L254
L234
	bl   @windowrestore
	movb r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >10
	b    *r11
L230
	ai   r9, >FF00
	seto r15
	jmp  L231
L235
	jeq  0
	cb  r9, @$-1
	jgt  L236
	jeq  L236
	li   r2, >3
	li   r9, >300
	jmp  L237
L251
	li   r9, >200
	li   r5, pawnplace
	mov  r5, @>12(r10)
	li   r1, getkey
	mov  r1, @>14(r10)
	b    @L248
L229
	li   r9, >400
	li   r5, pawnplace
	mov  r5, @>12(r10)
	li   r1, getkey
	mov  r1, @>14(r10)
	b    @L248
L252
	li   r9, >300
	li   r3, pawnplace
	mov  r3, @>12(r10)
	li   r5, getkey
	mov  r5, @>14(r10)
	b    @L248
	.size	humanchoosepawn, .-humanchoosepawn
LC3
	text 'L U D O'
	byte 0
LC4
	text 'Written by Xander Mol'
	byte 0
LC5
	text 'Converted TI-99/4a, 2021'
	byte 0
LC6
	text 'From Commodore 128 1992'
	byte 0
LC7
	text 'Build with/using code of'
	byte 0
LC8
	text 'TMS9900-GCC by Insomnia'
	byte 0
LC9
	text 'Libti99 lib by Tursi'
	byte 0
LC10
	text 'Jedimatt42 help/code'
	byte 0
LC11
	text 'Press a key.'
	byte 0
LC12
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
	li   r1, >7631
	movb r1, @>4(r10)
	swpb r1
	movb r1, @>5(r10)
	li   r1, >3900
	movb r1, @>6(r10)
	movb r1, @>7(r10)
	li   r9, >202D
	movb r9, @>8(r10)
	swpb r9
	movb r9, @>9(r10)
	li   r0, >2032
	movb r0, @>A(r10)
	swpb r0
	movb r0, @>B(r10)
	li   r12, >3032
	movb r12, @>C(r10)
	swpb r12
	movb r12, @>D(r10)
	li   r8, >3130
	movb r8, @>E(r10)
	swpb r8
	movb r8, @>F(r10)
	li   r7, >3332
	movb r7, @>10(r10)
	swpb r7
	movb r7, @>11(r10)
	li   r6, >362D
	movb r6, @>12(r10)
	swpb r6
	movb r6, @>13(r10)
	li   r5, >3136
	movb r5, @>14(r10)
	swpb r5
	movb r5, @>15(r10)
	li   r4, >3035
	movb r4, @>16(r10)
	swpb r4
	movb r4, @>17(r10)
	clr  r1
	li   r2, >500
	li   r3, >E00
	li   r4, >1E00
	bl   @menumakeborder
	li   r9, printcentered
	li   r1, LC3
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
	li   r1, LC4
	li   r2, >200
	li   r3, >A00
	li   r4, >1C00
	bl   *r9
	li   r1, LC5
	li   r2, >200
	li   r3, >B00
	li   r4, >1C00
	bl   *r9
	li   r1, LC6
	li   r2, >200
	li   r3, >C00
	li   r4, >1C00
	bl   *r9
	li   r1, LC7
	li   r2, >200
	li   r3, >E00
	li   r4, >1C00
	bl   *r9
	li   r1, LC8
	li   r2, >200
	li   r3, >F00
	li   r4, >1C00
	bl   *r9
	li   r1, LC9
	li   r2, >200
	li   r3, >1000
	li   r4, >1C00
	bl   *r9
	li   r1, LC10
	li   r2, >200
	li   r3, >1100
	li   r4, >1C00
	bl   *r9
	li   r1, LC11
	li   r2, >200
	li   r3, >1200
	li   r4, >1C00
	bl   *r9
	li   r1, LC12
	li   r2, >100
	bl   @getkey
	bl   @windowrestore
	mov  *r10+, r11
	mov  *r10, r9
	ai   r10, >20
	b    *r11
	.size	informationcredits, .-informationcredits
LC13
	text 'Key.'
	byte 0
	even

	def	dicethrow
dicethrow
	ai   r10, >FFF2
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
	clr  r1
	movb r1, @>A(r10)
	b    @L259
L258
	mov  @seed.1515, r1
* Begin inline assembler code
* 231 "main.c" 1
	srl r1,1  
	jnc 1f    
	xor @random_mask.1516,r1 
	1:        
	
* 0 "" 2
* End of inline assembler code
	mov  r1, @seed.1515
	mov  r1, r2
	clr  r1
	li   r3, >6
	div  r3, r1
	mov  r2, r4
	inc  r4
	swpb r4
	movb r4, r13
	srl  r13, 8
	dec  r13
	mov  r13, r14
	sla  r14, >2
	ai   r14, dicegraphics
	mov  r14, r15
	movb *r15+, r2
	mov  @gImage, r1
	ai   r1, >199
	srl  r2, 8
	mov  @vdpchar, r3
	mov  r4, @>C(r10)
	bl   *r3
	movb *r15, r2
	mov  @gImage, r1
	ai   r1, >19A
	srl  r2, 8
	mov  @vdpchar, r3
	bl   *r3
	mov  r13, r1
	a    r13, r1
	inc  r1
	a    r1, r1
	movb @dicegraphics(r1), r2
	mov  @gImage, r1
	ai   r1, >1B9
	srl  r2, 8
	mov  @vdpchar, r3
	bl   *r3
	movb @>3(r14), r2
	mov  @gImage, r1
	ai   r1, >1BA
	srl  r2, 8
	mov  @vdpchar, r3
	bl   *r3
	li   r1, >5
	li   r2, wait
	bl   *r2
	movb @>A(r10), r3
	ai   r3, >100
	movb r3, @>A(r10)
	li   r1, >A00
	cb   r3, r1
	jne  JMP_86
	b    @L262
JMP_86
L259
	jeq  0
	cb  @musicnumber, @$-1
	jne  JMP_87
	b    @L258
JMP_87
	li   r2, vdpwaitvint
	bl   *r2
* Begin inline assembler code
* 859 "main.c" 1
	bl @SongLoop
* 0 "" 2
* End of inline assembler code
	mov  @songNote+6, r1
	andi r1, >1
	jeq  JMP_88
	b    @L258
JMP_88
	li   r1, musicmem
	clr  r2
	li   r3, StartSong
	bl   *r3
	b    @L258
L262
	li   r1, >18
	li   r2, >F
	li   r3, LC13
	bl   @cputsxy
	li   r1, LC12
	li   r2, >100
	bl   @getkey
	bl   @windowrestore
	mov  @>C(r10), r4
	movb r4, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	.size	dicethrow, .-dicethrow
LC14
	text 'TIPI not enabled!'
	byte 0
LC15
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
	li   r3, LC14
	bl   *r9
	li   r1, >C
	mov  r1, @conio_x
	li   r1, >8
	mov  r1, @conio_y
	li   r1, >C
	li   r2, >9
	li   r3, LC15
	bl   *r9
	li   r1, LC12
	li   r2, >100
	bl   @getkey
	mov  *r10+, r11
	mov  *r10+, r9
	b    @windowrestore
	.size	tipinotenabledmessage, .-tipinotenabledmessage
LC16
	text 'File error!'
	byte 0
LC17
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
	li   r3, LC16
	bl   *r9
	li   r1, >C
	mov  r1, @conio_x
	li   r1, >8
	mov  r1, @conio_y
	ai   r10, >FFFC
	li   r1, LC17
	mov  r1, *r10
	movb r13, r1
	srl  r1, 8
	mov  r1, @>2(r10)
	bl   @cprintf
	ai   r10, >4
	li   r1, >C
	li   r2, >A
	li   r3, LC15
	bl   *r9
	li   r1, LC12
	li   r2, >100
	bl   @getkey
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    @windowrestore
	.size	fileerrormessage, .-fileerrormessage
LC18
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
	jle  JMP_89
	b    @L268
JMP_89
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
L273
	mov  @>14(r10), r1
	movb *r1, r4
	jne  JMP_90
	b    @L295
JMP_90
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
L274
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
	li   r1, LC18
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
	jh  L274
L270
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
	jmp  L275
L276
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
L275
	mov  r14, r1
	bl   *r15
	inc  r1
	movb r9, r4
	srl  r4, 8
	c    r1, r4
	jgt  L276
	jeq  L276
	mov  r10, r1
	ai   r1, >A
	li   r2, updownenter
	bl   @strcpy
	movb @>20(r10), r2
	cb   r2, @menubaroptions
	jh  JMP_91
	b    @L296
JMP_91
L277
	li   r13, >100
	li   r15, >1
L290
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
	jh  L290
	srl  r2, 8
	a    r2, r2
	mov  @L282(r2), r3
	b    *r3
	even
L282
		data		L279
		data		L279
		data		L280
		data		L280
		data		L290
		data		L281
L279
	movb r1, r13
	ai   r13, >A00
L281
	bl   @windowrestore
	movb r13, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >1A
	b    *r11
L280
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
	jeq  L297
	ai   r13, >100
	mov  @>14(r10), r2
	cb   r13, *r2
	jh  L277
L294
	movb r13, r15
	srl  r15, 8
	jmp  L290
L297
	ai   r13, >FF00
	jne  L294
	mov  @>14(r10), r1
	movb *r1, r13
	movb r13, r15
	srl  r15, 8
	jmp  L290
L296
	mov  r10, r1
	ai   r1, >A
	li   r2, leftright
	bl   @strcat
	b    @L277
L268
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
	jmp  L271
L272
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
L271
	mov  r15, r1
	bl   *r14
	inc  r1
	movb r13, r3
	srl  r3, 8
	c    r1, r3
	jgt  L272
	jeq  L272
	mov  @>12(r10), r9
	b    @L273
L295
	mov  @>1C(r10), r2
	inc  r2
	mov  r2, @>12(r10)
	b    @L270
	.size	menupulldown, .-menupulldown
LC19
	text '%s has won!'
	byte 0
LC20
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
	li   r1, LC19
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
	li   r3, LC20
	bl   @cputsxy
	li   r13, menupulldown
	li   r9, >200
	li   r14, >300
	li   r15, >100
L302
	li   r1, >A00
	movb r1, r2
	li   r3, >700
	bl   *r13
	cb   r1, r9
	jeq  L305
	cb   r1, r14
	jeq  L306
	cb   r1, r15
	jne  L300
	jeq  0
	cb  @playerdata+1, @$-1
	jne  L300
	jeq  0
	cb  @playerdata+5, @$-1
	jne  L300
	jeq  0
	cb  @playerdata+9, @$-1
	jne  L300
	jeq  0
	cb  @playerdata+13, @$-1
	jeq  L302
L300
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @windowrestore
L306
	li   r1, >100
	movb r1, @endofgameflag
	movb r1, @zv
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @windowrestore
L305
	li   r1, >300
	movb r1, @endofgameflag
	bl   @gamereset
	li   r1, >100
	movb r1, @zv
	jmp  L300
	.size	playerwins, .-playerwins
LC21
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
	li   r3, LC21
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
	li   r2, C.58.2036
	li   r3, >4
	bl   @memcpy
	li   r1, >100
	movb r1, @>E(r10)
	li   r2, >1
	mov  r2, @>12(r10)
L325
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
	jmp  L310
L311
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
L310
	mov  r14, r1
	li   r4, strlen
	bl   *r4
	movb r9, r4
	srl  r4, 8
	c    r4, r1
	jlt  L311
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
	jne  JMP_92
	b    @L329
JMP_92
	li   r1, >900
	cb   r9, r1
	jne  JMP_93
	b    @L330
JMP_93
	li   r4, >D00
	cb   r9, r4
	jne  L325
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
	jlt  L316
	jeq  L316
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
L316
	movb r9, r1
	clr  r2
	movb @>E(r10), r3
	li   r4, menupulldown
	bl   *r4
	li   r2, >1200
	cb   r1, r2
	jne  JMP_94
	b    @L331
JMP_94
	li   r3, >1300
	cb   r1, r3
	jeq  L332
	jeq  0
	cb  r1, @$-1
	jne  JMP_95
	b    @L325
JMP_95
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
L329
	movb @>E(r10), r1
	ai   r1, >FF00
	movb r1, @>E(r10)
	jne  L328
	movb @menubaroptions, r3
	movb r3, @>E(r10)
	movb r3, r4
	srl  r4, 8
	mov  r4, @>12(r10)
	b    @L325
L330
	movb @>E(r10), r2
	ai   r2, >100
	movb r2, @>E(r10)
	cb   r2, @menubaroptions
	jh  L315
	movb r2, r3
	srl  r3, 8
	mov  r3, @>12(r10)
	b    @L325
L327
	movb @menubaroptions, r1
	movb r1, @>E(r10)
L328
	movb r1, r2
	srl  r2, 8
	mov  r2, @>12(r10)
	b    @L325
L315
	li   r2, >100
	movb r2, @>E(r10)
	li   r3, >1
	mov  r3, @>12(r10)
	b    @L325
L332
	movb @>E(r10), r4
	ai   r4, >100
	movb r4, @>E(r10)
	cb   r4, @menubaroptions
	jh  L319
	movb r4, r1
	srl  r1, 8
	mov  r1, @>12(r10)
	b    @L325
L331
	movb @>E(r10), r3
	ai   r3, >FF00
	movb r3, @>E(r10)
	jeq  L327
	movb r3, r4
	srl  r4, 8
	mov  r4, @>12(r10)
	b    @L325
L319
	li   r4, >100
	movb r4, @>E(r10)
	li   r1, >1
	mov  r1, @>12(r10)
	b    @L325
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
	li   r2, >2003
	movb r2, @>A(r10)
	swpb r2
	movb r2, @>B(r10)
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
L334
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
	jlt  L334
	jeq  L334
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
	jle  L361
L336
	movb @>58(r10), r3
	cb   r9, r3
	jhe  JMP_96
	b    @L362
JMP_96
L343
	movb r9, r13
L346
	movb r13, r9
L363
	mov  r10, r1
	ai   r1, >A
	clr  r2
	li   r4, getkey
	bl   *r4
	movb r1, r4
	ai   r4, >FD00
	ci   r4, >AFF
	jh  L336
L361
	srl  r4, 8
	a    r4, r4
	mov  @L342(r4), r3
	b    *r3
	even
L342
		data		L337
		data		L338
		data		L336
		data		L336
		data		L336
		data		L339
		data		L340
		data		L336
		data		L336
		data		L336
		data		L341
L341
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
L340
	mov  r14, r1
	li   r3, strlen
	bl   *r3
	movb r9, r4
	srl  r4, 8
	c    r4, r1
	jgt  L343
	jeq  L343
	movb @>58(r10), r4
	cb   r9, r4
	jhe  L343
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
	b    @L363
L339
	jeq  0
	cb  r9, @$-1
	jne  JMP_97
	b    @L343
JMP_97
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
	jeq  JMP_98
	b    @L350
JMP_98
	li   r2, >1A
L351
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
	b    @L363
L338
	mov  r14, r1
	li   r4, strlen
	bl   *r4
	mov  r1, r4
	swpb r4
	movb @>58(r10), r1
	cb   r1, r4
	jh  JMP_99
	b    @L343
JMP_99
	jeq  0
	cb  r4, @$-1
	jne  JMP_100
	b    @L343
JMP_100
	cb   r9, r4
	jl  JMP_101
	b    @L343
JMP_101
	ai   r4, >100
	cb   r9, r4
	jh  L347
	movb r4, r5
	srl  r5, 8
	a    r14, r5
	movb *r5, @>1(r5)
	jeq  0
	cb  r4, @$-1
	jne  L358
	jmp  L347
L349
	movb r4, r1
	srl  r1, 8
	a    r14, r1
	movb *r1, @>1(r1)
	jeq  0
	cb  r4, @$-1
	jeq  L347
L358
	ai   r4, >FF00
	cb   r9, r4
	jle  L349
L347
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
	b    @L363
L337
	jeq  0
	cb  r9, @$-1
	jne  JMP_102
	b    @L343
JMP_102
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
	jeq  L344
	movb r13, @>5E(r10)
	mov  r3, r13
L355
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
	jne  L355
	movb @>5E(r10), r13
L344
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
	jeq  L364
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
L365
	movb r13, r9
	b    @L363
L362
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
	jeq  JMP_103
	b    @L346
JMP_103
	movb r13, r4
	srl  r4, 8
	a    r14, r4
	movb r3, @>1(r4)
	movb r13, r9
	b    @L363
L364
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
	jmp  L365
L350
	movb r5, r2
	srl  r2, 8
	b    @L351
	.size	input, .-input
LC22
	text 'Computer plays player %d?'
	byte 0
LC23
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
L369
	li   r1, >4
	mov  r1, @conio_x
	li   r2, >A
	mov  r2, @conio_y
	inc  r9
	ai   r10, >FFFC
	li   r4, LC22
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
	jeq  L372
	clr  r4
	movb r4, *r13
L368
	li   r5, >4
	mov  r5, @conio_x
	li   r1, >A
	mov  r1, @conio_y
	ai   r10, >FFFC
	li   r2, LC23
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
	jne  L369
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @windowrestore
L372
	movb r2, *r13
	jmp  L368
	.size	inputofnames, .-inputofnames
	even

	def	dsr_save
dsr_save
	ai   r10, >FFEC
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r1, r14
	mov  r2, r13
	mov  r3, r9
	clr  r2
	movb r2, @>10(r10)
	movb r2, @>9(r10)
	movb r2, @>C(r10)
	movb r2, @>D(r10)
	li   r2, >600
	movb r2, @>8(r10)
	li   r2, >1A00
	mov  r2, @>A(r10)
	mov  r3, @>E(r10)
	bl   @strlen
	swpb r1
	movb r1, @>11(r10)
	mov  r14, @>12(r10)
	li   r1, >1A00
	mov  r13, r2
	mov  r9, r3
	bl   @vdpmemcpy
	mov  r10, r1
	ai   r1, >8
	li   r2, >1800
	bl   @dsrlnk
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10, r14
	ai   r10, >E
	b    *r11
	.size	dsr_save, .-dsr_save
LC24
	text 'TIPI.LUDOCFG'
	byte 0
	even

	def	saveconfigfile
saveconfigfile
	ai   r10, >FFF0
	mov  r11, *r10
	mov  r10, r1
	inct r1
	li   r2, LC24
	li   r3, >D
	bl   @memcpy
	mov  r10, r1
	inct r1
	li   r2, saveslots
	li   r3, >55
	bl   @dsr_save
	jeq  0
	cb  r1, @$-1
	jne  L378
	mov  *r10, r11
	ai   r10, >10
	b    *r11
	jmp  L379
L378
	bl   @fileerrormessage
	mov  *r10, r11
	ai   r10, >10
	b    *r11
L379
	.size	saveconfigfile, .-saveconfigfile
LC26
	text 'Save game.'
	byte 0
LC27
	text 'Choose slot:'
	byte 0
LC28
	text 'Slot not empty. Sure?'
	byte 0
LC29
	text 'Choose name of save. '
	byte 0
LC25
	text 'TIPI.LUDOSAV'
	byte 0
	bss 1
	even

	def	savegame
savegame
	ai   r10, >FFE2
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	movb r1, r9
	mov  r10, r1
	ai   r1, >A
	li   r2, LC25
	li   r3, >D
	bl   @memcpy
	clr  r1
	movb r1, @>17(r10)
	li   r15, strlen
	mov  r10, r1
	ai   r1, >A
	bl   *r15
	swpb r1
	movb r1, @>18(r10)
	li   r2, >100
	cb   r9, r2
	jne  JMP_104
	b    @L411
JMP_104
	li   r1, >200
	li   r2, >500
	li   r3, >C00
	li   r4, >1C00
	bl   @menumakeborder
	li   r14, cputsxy
	li   r1, >4
	li   r2, >7
	li   r3, LC26
	bl   *r14
	li   r1, >4
	li   r2, >8
	li   r3, LC27
	bl   *r14
	li   r13, menupulldown
L383
	li   r1, >A00
	movb r1, r2
	li   r3, >800
	bl   *r13
	movb r1, r9
	ai   r9, >FF00
	jeq  L383
	movb r9, r5
	srl  r5, 8
	mov  r5, r13
	ai   r13, saveslots
	li   r4, >100
	cb   *r13, r4
	jne  JMP_105
	b    @L412
JMP_105
L384
	li   r1, >4
	li   r2, >9
	li   r3, LC29
	mov  r5, @>1C(r10)
	bl   *r14
	li   r1, >100
	mov  @>1C(r10), r5
	cb   *r13, r1
	jne  JMP_106
	b    @L409
JMP_106
	mov  r5, r6
	ai   r6, >23
L386
	mov  r5, r14
	ai   r14, >23
	sla  r14, >4
	ai   r14, pulldownmenutitles
	li   r1, >400
	li   r2, >A00
	mov  r14, r3
	li   r4, >F00
	mov  r5, @>1C(r10)
	mov  r6, @>1A(r10)
	bl   @input
	mov  r14, r1
	bl   *r15
	mov  r1, r2
	swpb r2
	li   r1, >E00
	mov  @>1C(r10), r5
	mov  @>1A(r10), r6
	cb   r2, r1
	jle  JMP_107
	b    @L413
JMP_107
	sla  r5, >4
	mov  r5, r4
	ai   r4, pulldownmenutitles
	li   r1, >F00
L388
	movb r2, r3
	srl  r3, 8
	a    r4, r3
	li   r7, >2000
	movb r7, @>230(r3)
	ai   r2, >100
	cb   r2, r1
	jne  L388
L387
	clr  r1
	movb r1, @pulldownmenutitles+575(r5)
	movb @>18(r10), r1
	srl  r1, 8
	mov  r6, r3
	sla  r3, >4
	ai   r3, pulldownmenutitles
	mov  r5, r2
	ai   r2, >5
	ai   r2, saveslots
	ai   r5, saveslots+21
L389
	movb *r3+, *r2+
	c    r2, r5
	jne  L389
	li   r2, >A
	a    r10, r2
	a    r1, r2
	ai   r9, >3000
	movb r9, *r2
	li   r2, >A
	a    r10, r2
	a    r2, r1
	clr  r3
	movb r3, @>1(r1)
	bl   @windowrestore
	jmp  L382
L411
	srl  r1, 8
	li   r2, >A
	a    r10, r2
	a    r1, r2
	li   r3, >3000
	movb r3, *r2
	mov  r2, r1
	clr  r2
	movb r2, @>1(r1)
	li   r13, saveslots
L382
	li   r7, >100
	movb r7, *r13
	bl   @saveconfigfile
	movb @turnofplayernr, @savegamemem
	movb @np, @savegamemem+1
	movb @np+1, @savegamemem+2
	movb @np+2, @savegamemem+3
	movb @np+3, @savegamemem+4
	li   r4, >5
	clr  r3
L390
	mov  r3, r2
	sla  r2, >2
	ai   r2, playerdata
	mov  r4, r1
	ai   r1, savegamemem
	mov  r4, r5
	ai   r5, savegamemem+4
L391
	movb *r2+, *r1+
	c    r1, r5
	jne  L391
	inc  r3
	ai   r4, >4
	ci   r3, >4
	jne  L390
	li   r5, >15
	clr  r4
	li   r6, >400
L392
	mov  r4, r1
	sla  r1, >3
	ai   r1, playerpos
	mov  r5, r2
	ai   r2, savegamemem
	clr  r3
L393
	movb *r1, *r2
	movb @>1(r1), @>1(r2)
	ai   r3, >100
	inct r1
	inct r2
	cb   r3, r6
	jne  L393
	inc  r4
	ai   r5, >8
	ci   r4, >4
	jne  L392
	li   r5, >35
	clr  r4
L394
	mov  r4, r2
	sla  r2, >3
	a    r4, r2
	ai   r2, playername
	mov  r5, r1
	ai   r1, savegamemem
	mov  r5, r3
	ai   r3, savegamemem+21
L395
	movb *r2+, *r1+
	c    r3, r1
	jne  L395
	inc  r4
	ai   r5, >15
	ci   r4, >4
	jne  L394
	mov  r10, r1
	ai   r1, >A
	li   r2, savegamemem
	li   r3, >88
	bl   @dsr_save
	jeq  0
	cb  r1, @$-1
	jne  L414
L398
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >16
	b    *r11
L414
	bl   @fileerrormessage
	jmp  L398
L412
	li   r1, >4
	li   r2, >9
	li   r3, LC28
	mov  r4, @>1A(r10)
	mov  r5, @>1C(r10)
	bl   *r14
	li   r1, >F00
	li   r2, >A00
	li   r3, >500
	bl   @menupulldown
	mov  @>1A(r10), r4
	mov  @>1C(r10), r5
	cb   r1, r4
	jne  JMP_108
	b    @L384
JMP_108
	bl   @windowrestore
	jmp  L398
L409
	mov  r5, r6
	ai   r6, >23
	mov  r6, r1
	sla  r1, >4
	clr  r3
	movb r3, @pulldownmenutitles(r1)
	b    @L386
L413
	sla  r5, >4
	b    @L387
	.size	savegame, .-savegame
LC30
	text 'Throw 3x'
	byte 0
LC31
	text '        '
	byte 0
LC32
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
	jne  JMP_109
	b    @L494
JMP_109
L416
	li   r13, >100
	li   r1, cputsxy
	mov  r1, @>E(r10)
L421
	clr  r9
	li   r15, dicethrow
	li   r14, >600
L423
	bl   *r15
	movb r1, @throw
	cb   r1, r14
	jeq  L422
	ai   r9, >100
	cb   r13, r9
	jh  L423
L422
	li   r1, >17
	li   r2, >7
	li   r3, LC31
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
	jne  JMP_110
	b    @L495
JMP_110
L424
	clr  r14
L426
	mov  r3, r12
	ai   r12, np
	movb *r12, r15
	jgt  JMP_111
	jeq  JMP_111
	b    @L496
JMP_111
	jeq  0
	cb  r4, @$-1
	jne  JMP_112
	b    @L497
JMP_112
L429
	seto r2
	movb r2, *r12
L428
	jeq  0
	cb  r14, @$-1
	jeq  JMP_113
	b    @L430
JMP_113
	seto r4
	cb   r15, r4
	jne  JMP_114
	b    @L498
JMP_114
L431
	li   r9, >100
L455
	li   r3, >600
	cb   @throw, r3
	jne  JMP_115
	b    @L499
JMP_115
L457
	jeq  0
	cb  r9, @$-1
	jne  JMP_116
	b    @L458
JMP_116
	li   r13, >100
	cb   r14, r13
	jne  JMP_117
	b    @L458
JMP_117
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
	jne  JMP_118
	b    @L500
JMP_118
L461
	movb r5, r3
	ab   @throw, r3
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	movb r3, @playerpos+1(r4)
L462
	jeq  0
	cb  r9, @$-1
	jeq  JMP_119
	b    @L463
JMP_119
	li   r4, >2700
	cb   r3, r4
	jle  JMP_120
	b    @L501
JMP_120
L468
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	movb @>1(r3), r3
L470
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	movb @playerpos(r4), r7
	li   r4, >100
	cb   r7, r4
	jne  JMP_121
	b    @L502
JMP_121
L471
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
	jne  JMP_122
	b    @L503
JMP_122
L472
	ci   r3, >27FF
	jle  L473
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	ai   r3, >D800
	movb r3, @playerpos+1(r4)
L473
	clr  r0
	a    r6, r8
	a    r8, r8
	ai   r8, playerpos
	mov  r8, r13
	inc  r13
	li   r12, >400
L474
	clr  r2
	clr  r5
	movb r0, r3
	srl  r3, >6
	andi r3, >FFFC
	jmp  L478
L475
	mov  r3, r1
	a    r2, r1
	a    r1, r1
	ai   r1, playerpos
	jeq  0
	cb  *r1, @$-1
	jne  L476
	jeq  0
	cb  *r8, @$-1
	jne  L476
	cb   @>1(r1), *r13
	jeq  L477
L476
	ai   r5, >100
	inc  r2
	cb   r5, r12
	jeq  L504
L478
	c    r6, r2
	jne  L475
	cb   r0, r9
	jne  L475
	ai   r5, >100
	inc  r2
	cb   r5, r12
	jne  L478
L504
	ai   r0, >100
	ci   r0, >3FF
	jle  L474
	clr  r5
	seto r0
L477
	seto r3
	cb   r0, r3
	jeq  JMP_123
	b    @L490
JMP_123
	li   r13, pawnplace
L480
	movb r9, r1
	movb r15, r2
	clr  r3
	bl   *r13
	movb @turnofplayernr, r1
	srl  r1, >6
	andi r1, >FFFC
	jeq  0
	cb  @playerdata(r1), @$-1
	jne  L481
	li   r1, >100
	cb   @autosavetoggle, r1
	jne  JMP_124
	b    @L505
JMP_124
L481
	li   r1, >17
	li   r2, >7
	jmp  L491
L458
	li   r1, >17
	li   r2, >7
	li   r3, LC32
	mov  @>E(r10), r4
	bl   *r4
	li   r1, >17
	li   r2, >8
L491
	li   r3, LC13
	mov  @>E(r10), r4
	bl   *r4
	li   r1, LC12
	li   r2, >100
	bl   @getkey
L482
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >10
	b    *r11
L498
	movb @throw, r13
	movb r14, r2
	li   r0, >100
	sla  r3, >3
	ai   r3, playerpos
	mov  r3, @>10(r10)
	li   r9, >400
	movb r14, @>12(r10)
	mov  r12, r14
L449
	movb r2, r12
	srl  r12, 8
	mov  r8, r3
	a    r12, r3
	a    r3, r3
	ai   r3, playerpos
	movb *r3+, r4
	movb *r3, r5
	cb   r4, r0
	jne  JMP_125
	b    @L506
JMP_125
	movb r5, r7
	ab   r13, r7
	jeq  0
	cb  r4, @$-1
	jne  L436
	jeq  0
	cb  r1, @$-1
	jeq  JMP_126
	b    @L437
JMP_126
	li   r4, >2700
	cb   r7, r4
	jle  L443
	cb   r5, r4
	jh  JMP_127
	b    @L507
JMP_127
L443
	clr  r4
L439
	cb   r4, r0
	jne  JMP_128
	b    @L444
JMP_128
L436
	li   r3, >A
	a    r10, r3
	a    r12, r3
	li   r4, >100
	movb r4, *r3
	ab   r4, r2
L435
	cb   r2, r9
	jne  L449
	movb @>12(r10), r14
L430
	seto r3
	cb   r15, r3
	jeq  JMP_129
	b    @L431
JMP_129
	li   r9, >100
	cb   @>A(r10), r9
	jne  JMP_130
	b    @L450
JMP_130
	clr  r9
L451
	li   r3, >100
	cb   @>B(r10), r3
	jne  JMP_131
	b    @L508
JMP_131
L452
	li   r3, >100
	cb   @>C(r10), r3
	jne  JMP_132
	b    @L509
JMP_132
L453
	li   r3, >100
	cb   @>D(r10), r3
	jne  JMP_133
	b    @L510
JMP_133
L454
	ci   r9, >1FF
	jh  JMP_134
	b    @L455
JMP_134
	jeq  0
	cb  @playerdata(r8), @$-1
	jeq  JMP_135
	b    @L456
JMP_135
	mov  r10, r2
	ai   r2, >A
	bl   @humanchoosepawn
	movb r1, r15
	li   r3, >600
	cb   @throw, r3
	jeq  JMP_136
	b    @L457
JMP_136
L499
	li   r1, >100
	movb r1, @zv
	b    @L457
L497
	seto r15
	b    @L429
L495
	li   r2, >300
	cb   r13, r2
	jeq  JMP_137
	b    @L424
JMP_137
	clr  r14
	li   r2, >600
	cb   @throw, r2
	jne  JMP_138
	b    @L426
JMP_138
	li   r14, >100
	b    @L426
L494
	mov  r1, r2
	sla  r2, >3
	jeq  0
	cb  @playerpos(r2), @$-1
	jne  JMP_139
	b    @L511
JMP_139
	li   r13, >300
L418
	inc  r3
	a    r3, r3
	jeq  0
	cb  @playerpos(r3), @$-1
	jne  L419
	li   r13, >100
L419
	a    r1, r1
	inc  r1
	sla  r1, >2
	jeq  0
	cb  @playerpos(r1), @$-1
	jne  L420
	li   r13, >100
L420
	ai   r2, playerpos
	jeq  0
	cb  @>6(r2), @$-1
	jne  JMP_140
	b    @L416
JMP_140
	li   r1, >300
	cb   r13, r1
	jne  JMP_141
	b    @L489
JMP_141
	li   r2, cputsxy
	mov  r2, @>E(r10)
	b    @L421
L456
	mov  r10, r2
	ai   r2, >A
	bl   @computerchoosepawn
	movb r1, r15
	b    @L455
L496
	seto r15
	b    @L428
L490
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
	b    @L480
L463
	li   r0, >100
	cb   r9, r0
	jne  L465
	li   r4, >900
	cb   r3, r4
	jh  JMP_142
	b    @L468
JMP_142
	cb   r5, r4
	jle  JMP_143
	b    @L468
JMP_143
	jeq  0
	cb  r7, @$-1
	jeq  JMP_144
	b    @L468
JMP_144
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	movb r9, *r3+
	li   r2, >FA00
	ab   r2, *r3
	b    @L468
L511
	li   r13, >100
	b    @L418
L501
	cb   r5, r4
	jle  JMP_145
	b    @L468
JMP_145
	jeq  0
	cb  r7, @$-1
	jeq  JMP_146
	b    @L468
JMP_146
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	li   r4, >100
	movb r4, *r3+
	li   r1, >DC00
	ab   r1, *r3
	b    @L468
L465
	li   r4, >200
	cb   r9, r4
	jeq  JMP_147
	b    @L467
JMP_147
	li   r4, >1300
	cb   r3, r4
	jh  JMP_148
	b    @L468
JMP_148
	cb   r5, r4
	jle  JMP_149
	b    @L468
JMP_149
	jeq  0
	cb  r7, @$-1
	jeq  JMP_150
	b    @L468
JMP_150
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	movb r0, *r3+
	li   r4, >F000
	ab   r4, *r3
	b    @L468
L506
	ci   r5, >3FF
	jh  L433
	li   r3, >600
	cb   r13, r3
	jeq  L512
L447
	ai   r2, >100
	b    @L435
L512
	movb r2, r15
	movb r2, *r14
	li   r2, >400
	b    @L435
L433
	movb r5, r7
	ab   r13, r7
L444
	ci   r7, >7FF
	jh  L447
	mov  @>10(r10), r6
	clr  r5
	jmp  L448
L446
	ai   r5, >100
	inct r6
	cb   r5, r9
	jne  JMP_151
	b    @L436
JMP_151
L448
	cb   r2, r5
	jeq  L446
	cb   *r6, r0
	jne  L446
	movb @>1(r6), r3
	cb   r3, r7
	jh  L446
	ci   r3, >3FF
	jle  L446
	ai   r2, >100
	b    @L435
L437
	cb   r1, r0
	jne  L440
	li   r4, >900
	cb   r7, r4
	jh  JMP_152
	b    @L443
JMP_152
	cb   r5, r4
	jle  JMP_153
	b    @L443
JMP_153
	ai   r7, >FA00
	movb r1, r4
	b    @L439
L502
	ci   r3, >3FF
	jh  JMP_154
	b    @L471
JMP_154
	movb r3, @dp(r12)
	b    @L471
L503
	li   r5, >100
	cb   r7, r5
	jeq  JMP_155
	b    @L472
JMP_155
	ai   r12, >FF00
	movb r12, *r4
	b    @L472
L500
	ci   r5, >3FF
	jle  JMP_156
	b    @L461
JMP_156
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
	b    @L462
L440
	li   r4, >200
	cb   r1, r4
	jeq  JMP_157
	b    @L442
JMP_157
	li   r4, >1300
	cb   r7, r4
	jh  JMP_158
	b    @L443
JMP_158
	cb   r5, r4
	jle  JMP_159
	b    @L443
JMP_159
	ai   r7, >F000
	li   r4, >100
	b    @L439
L510
	ab   r3, r9
	li   r15, >300
	b    @L454
L509
	ab   r3, r9
	li   r15, >200
	b    @L453
L508
	ab   r3, r9
	movb r3, r15
	b    @L452
L450
	clr  r15
	b    @L451
L507
	ai   r7, >DC00
	li   r4, >100
	b    @L439
L505
	bl   @savegame
	b    @L482
L489
	li   r3, cputsxy
	mov  r3, @>E(r10)
	li   r1, >17
	li   r2, >7
	li   r3, LC30
	li   r4, cputsxy
	bl   *r4
	b    @L421
L467
	li   r4, >300
	cb   r9, r4
	jeq  JMP_160
	b    @L468
JMP_160
	li   r4, >1D00
	cb   r3, r4
	jh  JMP_161
	b    @L470
JMP_161
	cb   r5, r4
	jle  JMP_162
	b    @L470
JMP_162
	jeq  0
	cb  r7, @$-1
	jeq  JMP_163
	b    @L470
JMP_163
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	ai   r4, playerpos
	movb r0, *r4+
	movb *r4, r3
	ai   r3, >E600
	movb r3, *r4
	b    @L470
L442
	li   r4, >300
	cb   r1, r4
	jeq  JMP_164
	b    @L436
JMP_164
	li   r4, >1D00
	cb   r7, r4
	jh  JMP_165
	b    @L436
JMP_165
	cb   r5, r4
	jle  JMP_166
	b    @L436
JMP_166
	ai   r7, >E600
	b    @L444
	.size	turngeneric, .-turngeneric
	even

	def	dsr_load
dsr_load
	ai   r10, >FFEC
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r1, r9
	mov  r2, r14
	mov  r3, r13
	clr  r2
	movb r2, @>10(r10)
	movb r2, @>9(r10)
	movb r2, @>C(r10)
	movb r2, @>D(r10)
	li   r2, >500
	movb r2, @>8(r10)
	li   r2, >1A00
	mov  r2, @>A(r10)
	mov  r3, @>E(r10)
	bl   @strlen
	swpb r1
	movb r1, @>11(r10)
	mov  r9, @>12(r10)
	mov  r10, r1
	ai   r1, >8
	li   r2, >1800
	bl   @dsrlnk
	movb r1, r9
	jne  L514
	li   r1, >1A00
	mov  r14, r2
	mov  r13, r3
	bl   @vdpmemread
L514
	movb r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10, r14
	ai   r10, >E
	b    *r11
	.size	dsr_load, .-dsr_load
LC33
	text 'TIPI.LUDOMUS'
	byte 0
	bss 1
	even

	def	musicnext
musicnext
	ai   r10, >FFEE
	mov  r11, *r10
	mov  r9, @>2(r10)
	mov  r10, r1
	ai   r1, >4
	li   r2, LC33
	li   r3, >D
	bl   @memcpy
	clr  r1
	movb r1, @>11(r10)
	mov  r10, r1
	ai   r1, >4
	bl   @strlen
	mov  r1, r9
	bl   @StopSong
	movb @musicnumber, r2
	ai   r2, >100
	movb r2, @musicnumber
	ci   r2, >3FF
	jh  L517
	ai   r2, >3000
L518
	mov  r9, r1
	andi r1, >FF
	li   r3, >4
	a    r10, r3
	a    r1, r3
	movb r2, *r3
	clr  r2
	movb r2, @>1(r3)
	li   r1, musicmem
	clr  r2
	li   r3, >C80
	bl   @memset
	mov  r10, r1
	ai   r1, >4
	li   r2, musicmem
	li   r3, >C80
	bl   @dsr_load
	jeq  0
	cb  r1, @$-1
	jeq  L519
	bl   @fileerrormessage
L519
	li   r1, musicmem
	clr  r2
	bl   @StartSong
	mov  *r10+, r11
	mov  *r10, r9
	ai   r10, >10
	b    *r11
L517
	li   r2, >100
	movb r2, @musicnumber
	li   r2, >3100
	jmp  L518
	.size	musicnext, .-musicnext
LC34
	text 'Load game.'
	byte 0
LC35
	text 'Slot empty.'
	byte 0
	even

	def	loadgame
loadgame
	ai   r10, >FFE4
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	mov  r10, r1
	ai   r1, >A
	li   r2, LC25
	li   r3, >D
	bl   @memcpy
	clr  r1
	movb r1, @>17(r10)
	mov  r10, r1
	ai   r1, >A
	bl   @strlen
	mov  r1, r15
	li   r1, >200
	li   r2, >500
	li   r3, >C00
	li   r4, >1C00
	bl   @menumakeborder
	li   r13, cputsxy
	li   r1, >4
	li   r2, >7
	li   r3, LC34
	bl   *r13
	li   r1, >4
	li   r2, >9
	li   r3, LC27
	bl   *r13
	li   r1, >A00
	movb r1, r2
	li   r3, >800
	bl   @menupulldown
	movb r1, r14
	ai   r14, >FF00
	movb r14, r9
	srl  r9, 8
	ai   r9, saveslots
	jeq  0
	cb  *r9, @$-1
	jeq  L538
	bl   @windowrestore
	li   r2, >100
	cb   *r9, r2
	jeq  L539
L532
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >14
	b    *r11
	b    @L540
L538
	li   r1, >4
	li   r2, >9
	li   r3, LC35
	bl   *r13
	li   r1, >4
	li   r2, >A
	li   r3, LC15
	bl   *r13
	li   r1, LC12
	li   r2, >100
	bl   @getkey
	bl   @windowrestore
	li   r2, >100
	cb   *r9, r2
	jne  L532
L539
	andi r15, >FF
	li   r1, >A
	a    r10, r1
	a    r15, r1
	ai   r14, >3000
	movb r14, *r1
	li   r3, >A
	a    r10, r3
	clr  r4
	movb r4, @>1(r1)
	mov  r3, r1
	li   r2, savegamemem
	li   r3, >88
	bl   @dsr_load
	jeq  0
	cb  r1, @$-1
	jeq  JMP_167
	b    @L541
JMP_167
	movb @savegamemem, @turnofplayernr
	movb @savegamemem+1, @np
	movb @savegamemem+2, @np+1
	movb @savegamemem+3, @np+2
	movb @savegamemem+4, @np+3
	li   r4, >5
	clr  r3
L525
	mov  r4, r1
	ai   r1, savegamemem
	mov  r3, r2
	sla  r2, >2
	ai   r2, playerdata
	mov  r4, r5
	ai   r5, savegamemem+4
L526
	movb *r1+, *r2+
	c    r5, r1
	jne  L526
	inc  r3
	ai   r4, >4
	ci   r3, >4
	jne  L525
	li   r1, >15
	mov  r1, @>18(r10)
	clr  r3
	mov  r3, @>1A(r10)
	clr  r15
L527
	mov  @>18(r10), r14
	ai   r14, savegamemem
	mov  @>1A(r10), r13
	sla  r13, >3
	ai   r13, playerpos
	clr  r9
L528
	movb r15, r1
	movb r9, r2
	li   r4, pawnerase
	bl   *r4
	movb *r14, *r13
	movb @>1(r14), @>1(r13)
	movb r15, r1
	movb r9, r2
	clr  r3
	li   r4, pawnplace
	bl   *r4
	ai   r9, >100
	inct r14
	inct r13
	li   r1, >400
	cb   r9, r1
	jne  L528
	ai   r15, >100
	mov  @>1A(r10), r3
	inc  r3
	mov  r3, @>1A(r10)
	mov  @>18(r10), r4
	ai   r4, >8
	mov  r4, @>18(r10)
	cb   r15, r9
	jne  L527
	li   r5, >35
	clr  r4
L529
	mov  r5, r1
	ai   r1, savegamemem
	mov  r4, r2
	sla  r2, >3
	a    r4, r2
	ai   r2, playername
	mov  r5, r3
	ai   r3, savegamemem+21
L530
	movb *r1+, *r2+
	c    r1, r3
	jne  L530
	inc  r4
	ai   r5, >15
	ci   r4, >4
	jne  L529
	li   r1, >200
	movb r1, @endofgameflag
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >14
	b    *r11
	jmp  L540
L541
	bl   @fileerrormessage
	b    @L532
L540
	.size	loadgame, .-loadgame
LC36
	text 'Autosave on '
	byte 0
LC37
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
	li   r15, StopSong
	jmp  L559
L543
	movb r9, r1
	ai   r1, >F500
	ci   r1, >2FF
	jle  L560
L555
	li   r1, >1600
	cb   r9, r1
	jeq  L560
L559
	bl   *r14
	movb r1, r9
	ai   r1, >F400
	cb   r1, r13
	jh  L543
	srl  r1, 8
	a    r1, r1
	mov  @L553(r1), r2
	b    *r2
	even
L553
		data		L544
		data		L545
		data		L543
		data		L543
		data		L543
		data		L543
		data		L543
		data		L543
		data		L543
		data		L546
		data		L547
		data		L548
		data		L543
		data		L543
		data		L543
		data		L543
		data		L543
		data		L543
		data		L543
		data		L549
		data		L550
		data		L551
		data		L543
		data		L543
		data		L543
		data		L543
		data		L543
		data		L543
		data		L543
		data		L552
L552
	li   r1, informationcredits
	bl   *r1
	li   r1, >1600
	cb   r9, r1
	jne  L559
L560
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	b    @L562
L551
	jeq  0
	cb  @musicnumber, @$-1
	jeq  JMP_168
	b    @L563
JMP_168
	li   r3, >100
	movb r3, @musicnumber
	li   r1, musicmem
	clr  r2
	li   r4, StartSong
	bl   *r4
	jmp  L555
L550
	bl   *r15
	li   r2, >9F00
	movb r2, @>8400
	li   r4, >BFDF
	movb r4, @>8400
	swpb r4
	movb r4, @>8400
	li   r3, >FF00
	movb r3, @>8400
	swpb r3
	movb r3, @musicnumber
	jmp  L555
L549
	li   r1, musicnext
	bl   *r1
	b    @L555
L548
	li   r1, >100
	cb   @autosavetoggle, r1
	jeq  L564
	movb r1, @autosavetoggle
	li   r1, pulldownmenutitles+112
	li   r2, LC37
	li   r3, >D
	li   r4, memcpy
	bl   *r4
	b    @L555
L547
	li   r4, areyousure
	bl   *r4
	li   r2, >100
	cb   r1, r2
	jeq  JMP_169
	b    @L555
JMP_169
	bl   @loadgame
	b    @L555
L546
	clr  r1
	bl   @savegame
	b    @L555
L545
	bl   @areyousure
	li   r2, >100
	cb   r1, r2
	jeq  JMP_170
	b    @L560
JMP_170
	movb r1, @endofgameflag
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	jmp  L562
L544
	bl   @areyousure
	li   r2, >100
	cb   r1, r2
	jeq  JMP_171
	b    @L560
JMP_171
	li   r3, >300
	movb r3, @endofgameflag
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @gamereset
L563
	bl   *r15
	li   r1, musicmem
	clr  r2
	li   r4, StartSong
	bl   *r4
	b    @L555
L564
	clr  r1
	movb r1, @autosavetoggle
	li   r1, pulldownmenutitles+112
	li   r2, LC36
	li   r3, >D
	li   r4, memcpy
	bl   *r4
	b    @L555
L562
	.size	turnhuman, .-turnhuman
	even

	def	loadconfigfile
loadconfigfile
	ai   r10, >FFF0
	mov  r11, *r10
	mov  r10, r1
	inct r1
	li   r2, LC24
	li   r3, >D
	bl   @memcpy
	mov  r10, r1
	inct r1
	li   r2, saveslots
	li   r3, >55
	bl   @dsr_load
	jeq  0
	cb  r1, @$-1
	jne  L566
	li   r5, >5
	clr  r4
L567
	mov  r5, r1
	ai   r1, saveslots
	mov  r4, r2
	ai   r2, >23
	sla  r2, >4
	ai   r2, pulldownmenutitles
	mov  r5, r3
	ai   r3, saveslots+16
L569
	movb *r1+, *r2+
	c    r1, r3
	jne  L569
	inc  r4
	ai   r5, >10
	ci   r4, >5
	jne  L567
	mov  *r10, r11
	ai   r10, >10
	b    *r11
	jmp  L572
L566
	bl   @fileerrormessage
	mov  *r10, r11
	ai   r10, >10
	b    *r11
L572
	.size	loadconfigfile, .-loadconfigfile
LC38
	text 'TIPI.LUDOMUS1'
	byte 0
LC39
	text 'Press ENTER/FIRE to start game.'
	byte 0
LC40
	text 'M=toggle music.'
	byte 0
LC41
	text 'Music: '
	byte 0
LC42
	text 'Yes '
	byte 0
LC43
	text 'No '
	byte 0
	even

	def	loadintro
loadintro
	ai   r10, >FFF2
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	mov  r15, *r0
	mov  r10, r1
	ai   r1, >A
	li   r2, C.133.3102
	li   r3, >4
	bl   @memcpy
	mov  @gImage, r1
	li   r2, titlescreen
	li   r3, >240
	bl   @vdpmemcpy
	bl   @loadconfigfile
	li   r1, LC38
	li   r2, musicmem
	li   r3, >C80
	bl   @dsr_load
	jeq  0
	cb  r1, @$-1
	jeq  JMP_172
	b    @L586
JMP_172
L574
	li   r1, musicmem
	clr  r2
	li   r3, StartSong
	bl   *r3
	li   r9, cputsxy
	li   r1, >1
	li   r2, >15
	li   r3, LC39
	bl   *r9
	li   r1, >1
	li   r2, >16
	li   r3, LC40
	bl   *r9
	li   r15, cputs
	li   r14, getkey
	li   r13, >4D00
L584
	li   r1, >1
	li   r2, >14
	li   r3, LC41
	bl   *r9
	jeq  0
	cb  @musicnumber, @$-1
	jeq  L575
L587
	li   r1, LC42
	bl   *r15
L576
	mov  r10, r1
	ai   r1, >A
	li   r2, >100
	bl   *r14
	cb   r1, r13
	jeq  L578
	li   r2, >6D00
	cb   r1, r2
	jeq  L578
	li   r2, >D00
	cb   r1, r2
	jne  L584
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
L578
	jeq  0
	cb  @musicnumber, @$-1
	jeq  L579
	li   r3, StopSong
	bl   *r3
	li   r1, >9F00
	movb r1, @>8400
	li   r6, >BFDF
	movb r6, @>8400
	swpb r6
	movb r6, @>8400
	li   r5, >FF00
	movb r5, @>8400
	swpb r5
	movb r5, @musicnumber
	li   r1, >1
	li   r2, >14
	li   r3, LC41
	bl   *r9
	jeq  0
	cb  @musicnumber, @$-1
	jne  L587
L575
	li   r1, LC43
	bl   *r15
	jmp  L576
L579
	li   r3, >100
	movb r3, @musicnumber
	li   r1, musicmem
	clr  r2
	li   r3, StartSong
	bl   *r3
	jmp  L584
L586
	bl   @fileerrormessage
	b    @L574
	.size	loadintro, .-loadintro
LC44
	text 'Load old game?'
	byte 0
LC45
	text 'Player %d'
	byte 0
LC46
	text 'Color'
	byte 0
LC47
	text 'Computer'
	byte 0
LC48
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
	bl   @loadintro
	li   r1, >800
	li   r2, >500
	li   r3, >600
	li   r4, >1400
	bl   @menumakeborder
	li   r15, cputsxy
	li   r1, >A
	li   r2, >7
	li   r3, LC44
	bl   *r15
	li   r1, >1100
	li   r2, >800
	li   r3, >500
	bl   @menupulldown
	movb r1, r9
	bl   @windowrestore
	li   r2, >100
	cb   r9, r2
	jne  JMP_173
	b    @L608
JMP_173
L589
	movb @endofgameflag, r1
	jne  JMP_174
	b    @L609
JMP_174
L590
	li   r9, >100
	li   r14, >300
L602
	jeq  0
	cb  r1, @$-1
	jne  JMP_175
	b    @L591
JMP_175
	clr  r1
	movb r1, @endofgameflag
L592
	li   r13, turngeneric
L604
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
	li   r4, LC45
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
	li   r3, LC46
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
	jeq  JMP_176
	b    @L593
JMP_176
	li   r5, turnhuman
	bl   *r5
L594
	movb @endofgameflag, r1
	jne  L595
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
	jeq  L610
L596
	movb @zv, r3
L600
	cb   r3, r9
	jeq  L597
	seto r1
	movb r1, @np(r4)
	movb r5, r2
	ai   r2, >100
	cb   r2, r14
	jle  L598
	clr  r2
L598
	jeq  0
	cb  r3, @$-1
	jne  L599
	movb r2, r5
	movb r2, r4
	srl  r4, 8
L597
	clr  r3
	mov  r4, r1
	sla  r1, >2
	ai   r1, playerdata
	jeq  0
	cb  @>1(r1), @$-1
	jeq  L600
L599
	movb r2, @turnofplayernr
	movb r3, @zv
	movb @endofgameflag, r1
	jne  JMP_177
	b    @L604
JMP_177
L595
	cb   r1, r9
	jeq  JMP_178
	b    @L602
JMP_178
	bl   @clrscr
	clr  r1
	bl   @bgcolor
	clr  r1
	mov  r1, r2
	li   r3, LC48
	bl   *r15
	clr  r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
L610
	bl   @playerwins
	movb @turnofplayernr, r2
	movb r2, r5
	movb r2, r4
	srl  r4, 8
	jmp  L596
L593
	li   r1, >17
	li   r2, >5
	li   r3, LC47
	li   r4, cputsxy
	bl   *r4
	b    @L594
L591
	li   r2, inputofnames
	bl   *r2
	b    @L592
L609
	bl   @loadmainscreen
	movb @endofgameflag, r1
	b    @L590
L608
	bl   @loadmainscreen
	bl   @loadgame
	b    @L589
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
	dseg
	.type	musicnumber, @object
	.size	musicnumber, 1
musicnumber
	byte	1

	def	joyinterface
	.type	joyinterface, @object
	.size	joyinterface, 1
joyinterface
	byte	1

	def	autosavetoggle
	.type	autosavetoggle, @object
	.size	autosavetoggle, 1
autosavetoggle
	byte	1
	pseg
	.type	titlescreen, @object
	.size	titlescreen, 576
titlescreen
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	73
	byte	68
	byte	114
	byte	101
	byte	97
	byte	109
	byte	116
	byte	73
	byte	110
	byte	56
	byte	66
	byte	105
	byte	116
	byte	115
	byte	46
	byte	99
	byte	111
	byte	109
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	112
	byte	114
	byte	101
	byte	115
	byte	101
	byte	110
	byte	116
	byte	115
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
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
	byte	32
	byte	32
	byte	-100
	byte	-99
	byte	32
	byte	32
	byte	32
	byte	-100
	byte	-99
	byte	32
	byte	-100
	byte	-99
	byte	32
	byte	-100
	byte	-64
	byte	-64
	byte	-64
	byte	-99
	byte	32
	byte	32
	byte	-100
	byte	-64
	byte	-64
	byte	-64
	byte	-99
	byte	32
	byte	-120
	byte	-119
	byte	32
	byte	32
	byte	-126
	byte	-125
	byte	32
	byte	32
	byte	-64
	byte	-64
	byte	32
	byte	32
	byte	32
	byte	-64
	byte	-64
	byte	32
	byte	-64
	byte	-64
	byte	32
	byte	-64
	byte	-64
	byte	32
	byte	32
	byte	-98
	byte	-99
	byte	32
	byte	-64
	byte	-64
	byte	32
	byte	-64
	byte	-64
	byte	32
	byte	-118
	byte	-117
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-88
	byte	-88
	byte	32
	byte	32
	byte	32
	byte	-88
	byte	-88
	byte	32
	byte	-88
	byte	-88
	byte	32
	byte	-88
	byte	-88
	byte	32
	byte	32
	byte	32
	byte	-88
	byte	32
	byte	-88
	byte	-88
	byte	32
	byte	-88
	byte	-88
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	-104
	byte	-103
	byte	32
	byte	32
	byte	-88
	byte	-88
	byte	32
	byte	32
	byte	32
	byte	-88
	byte	-88
	byte	32
	byte	-88
	byte	-88
	byte	32
	byte	-88
	byte	-88
	byte	32
	byte	32
	byte	-124
	byte	-121
	byte	32
	byte	-88
	byte	-88
	byte	32
	byte	-88
	byte	-88
	byte	32
	byte	-112
	byte	-111
	byte	32
	byte	32
	byte	-102
	byte	-101
	byte	32
	byte	32
	byte	-106
	byte	-72
	byte	-72
	byte	-72
	byte	32
	byte	-106
	byte	-72
	byte	-72
	byte	-72
	byte	-105
	byte	32
	byte	-106
	byte	-72
	byte	-72
	byte	-72
	byte	-105
	byte	32
	byte	32
	byte	-106
	byte	-72
	byte	-72
	byte	-72
	byte	-105
	byte	32
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
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	87
	byte	114
	byte	105
	byte	116
	byte	116
	byte	101
	byte	110
	byte	32
	byte	98
	byte	121
	byte	32
	byte	88
	byte	97
	byte	110
	byte	100
	byte	101
	byte	114
	byte	32
	byte	77
	byte	111
	byte	108
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	8
	byte	9
	byte	32
	byte	21
	byte	22
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	10
	byte	11
	byte	32
	byte	23
	byte	24
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	byte	32
	.type	C.133.3102, @object
	.size	C.133.3102, 4
C.133.3102
	byte	109
	byte	77
	byte	13
	byte	0
	.type	C.117.2627, @object
	.size	C.117.2627, 5
C.117.2627
	byte	8
	byte	9
	byte	11
	byte	10
	byte	13
	even
	.type	random_mask.1516, @object
	.size	random_mask.1516, 2
random_mask.1516
	data	-19456
	dseg
	even
	.type	seed.1515, @object
	.size	seed.1515, 2
seed.1515
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
	.type	C.58.2036, @object
	.size	C.58.2036, 4
C.58.2036
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

	even
	def musicmem
musicmem
	bss 3200

	ref	cputsxy

	ref	bgcolor

	ref	clrscr

	ref	cputcxy

	ref	cprintf

	ref	conio_y

	ref	conio_x

	ref	StartSong

	ref	StopSong

	ref	cputs

	ref	vdpmemcpy

	ref	gImage

	ref	memcpy

	ref	strlen

	ref	memset

	ref	vdpmemread

	ref	dsrlnk

	ref	vdpchar

	ref	cputc

	ref	strcpy

	ref	songNote

	ref	vdpwaitvint

	ref	cgetc

	ref	kscanfast

	ref	joystfast

	ref	kbhit

	ref	gPattern

	ref	gColor

	ref	set_graphics
