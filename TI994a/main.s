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
L63
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
	jeq  L63
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
	b    @L64
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
	b    @L65
JMP_4
	movb *r4, r1
	cb   r1, r13
	jne  JMP_5
	b    @L66
JMP_5
L36
	jeq  0
	cb  r1, @$-1
	jne  L37
	jeq  0
	cb  r13, @$-1
	jne  JMP_6
	b    @L39
JMP_6
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
	jne  L33
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
	jne  JMP_11
	b    @L49
JMP_11
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
L69
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
	jeq  JMP_12
	b    @L53
JMP_12
L32
	mov  @>20(r10), r5
	clr  r1
	movb r1, r3
	li   r4, >B1E0
	li   r7, >100
	li   r6, >400
	mov  @>26(r10), r8
L57
	mov  *r8, r2
	c    r2, r4
	jlt  L54
	jeq  L54
	cb   *r5, r7
	jne  JMP_13
	b    @L67
JMP_13
L54
	mov  r4, r2
	ai   r3, >100
	inct r8
	inc  r5
	cb   r3, r6
	jne  JMP_14
	b    @L68
JMP_14
L56
	mov  r2, r4
	jmp  L57
L47
	li   r2, >F060
	a    r2, *r14
	b    @L46
L49
	li   r2, >7D0
	a    r2, *r14
	jeq  0
	cb  r15, @$-1
	jeq  L69
L50
	li   r1, >100
	cb   r15, r1
	jeq  JMP_15
	b    @L51
JMP_15
	mov  *r14, r2
	ai   r2, >FFF6
	movb @>1D(r10), r1
	srl  r1, 8
	a    r1, r2
	mov  r2, *r14
	b    @L15
L65
	cb   @>FFFF(r5), r13
	jeq  L70
L35
	mov  r3, r1
	a    r3, r1
	a    r7, r1
	movb *r1, r1
	b    @L36
L70
	cb   *r5, r12
	jne  L35
	li   r1, >E0C0
	a    r1, *r14
	mov  r3, r1
	a    r3, r1
	a    r7, r1
	movb *r1, r1
	b    @L36
L41
	li   r2, >300
	cb   r9, r2
	jne  L39
	ci   r12, >17FF
	jle  L39
	li   r2, >BB8
	a    r2, *r14
L39
	cb   r15, r9
	jne  JMP_16
	b    @L37
JMP_16
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
	jle  JMP_17
	b    @L37
JMP_17
	li   r1, >64
	a    r1, *r14
	b    @L37
L66
	cb   @>1(r4), r12
	jeq  JMP_18
	b    @L36
JMP_18
	mov  *r14, r2
	ai   r2, >FA0
	mov  r2, *r14
	jeq  0
	cb  r13, @$-1
	jeq  JMP_19
	b    @L37
JMP_19
	jeq  0
	cb  r9, @$-1
	jne  L38
	ci   r12, >21FF
	jle  L39
	ai   r2, >BB8
	mov  r2, *r14
	jmp  L39
L38
	li   r1, >100
	cb   r9, r1
	jeq  JMP_20
	b    @L40
JMP_20
	ci   r12, >3FF
	jh  JMP_21
	b    @L39
JMP_21
	ai   r2, >BB8
	mov  r2, *r14
	b    @L39
L16
	movb @>1F(r10), r13
	movb @>1D(r10), @>1C(r10)
L25
	li   r2, >100
	cb   r13, r2
	jeq  JMP_22
	b    @L30
JMP_22
L27
	li   r2, >300
	movb @>1C(r10), r1
	cb   r1, r2
	jle  L61
	li   r1, >100
	mov  @>24(r10), r2
	cb   *r2, r1
	jne  JMP_23
	b    @L71
JMP_23
	li   r1, >1770
	a    r1, *r14
L61
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
	jeq  JMP_24
	b    @L41
JMP_24
	cb   r12, r0
	jh  JMP_25
	b    @L39
JMP_25
	ai   r2, >BB8
	mov  r2, *r14
	b    @L39
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
L67
	movb r3, r1
	ai   r3, >100
	inct r8
	inc  r5
	cb   r3, r6
	jeq  JMP_26
	b    @L56
JMP_26
L68
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >22
	b    *r11
L20
	li   r2, >200
	cb   r15, r2
	jne  L22
	li   r2, >1300
	movb @>1D(r10), r1
	cb   r1, r2
	jh  JMP_27
	b    @L23
JMP_27
	movb @>1E(r10), r1
	cb   r1, r2
	jle  JMP_28
	b    @L23
JMP_28
	movb @>1D(r10), r2
	ai   r2, >F000
	movb r2, @>1C(r10)
	b    @L27
L64
	movb @>1D(r10), r1
	ai   r1, >DC00
	movb r1, @>1C(r10)
	b    @L27
L71
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
	jeq  JMP_29
	b    @L15
JMP_29
	mov  *r14, r2
	ai   r2, >FFE2
	movb @>1D(r10), r1
	srl  r1, 8
	a    r1, r2
	mov  r2, *r14
	b    @L15
L22
	li   r2, >300
	cb   r15, r2
	jeq  JMP_30
	b    @L24
JMP_30
	li   r2, >1D00
	movb @>1D(r10), r1
	cb   r1, r2
	jh  JMP_31
	b    @L24
JMP_31
	movb @>1E(r10), r1
	cb   r1, r2
	jle  JMP_32
	b    @L24
JMP_32
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
	jeq  L75
	clr  r9
	li   r13, cprintf
L74
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
	jh  L74
L75
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
	jne  L78
	movb @>1(r4), r2
	srl  r2, 8
	a    r2, r2
	ai   r2, fieldcoords
	movb *r2+, r4
	movb *r2, r2
	jeq  0
	cb  r3, @$-1
	jne  L89
L80
	li   r3, >100
	cb   r1, r3
	jne  JMP_33
	b    @L83
JMP_33
	cb   r1, r3
	jhe  L90
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
L78
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
	jeq  L80
L89
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
L90
	li   r3, >200
	cb   r1, r3
	jeq  L84
	li   r3, >300
	cb   r1, r3
	jeq  L91
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
L84
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
L83
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
L91
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
	jne  L93
	movb @>1(r3), r3
	movb r3, r2
	srl  r2, 8
	a    r2, r2
	ai   r2, fieldcoords
	movb *r2+, r1
	movb *r2, r2
	jeq  0
	cb  r3, @$-1
	jne  L108
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
L107
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @cputcxy
L93
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
	jne  JMP_34
	b    @L98
JMP_34
	cb   r1, r3
	jl  L97
	li   r3, >200
	cb   r1, r3
	jne  JMP_35
	b    @L99
JMP_35
	li   r3, >300
	cb   r1, r3
	jne  JMP_36
	b    @L109
JMP_36
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
L108
	li   r4, >A00
	cb   r3, r4
	jne  JMP_37
	b    @L101
JMP_37
	li   r4, >1400
	cb   r3, r4
	jne  JMP_38
	b    @L102
JMP_38
	li   r4, >1E00
	cb   r3, r4
	jne  JMP_39
	b    @L110
JMP_39
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
L97
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
	b    @L107
L98
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
	b    @L107
L101
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
	b    @L107
L109
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
	b    @L107
L99
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
	b    @L107
L102
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
	b    @L107
L110
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
	b    @L107
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
L114
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
	jne  L114
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
	jne  JMP_40
	b    @L121
JMP_40
	clr  r1
	mov  r1, @>A(r10)
	jmp  L120
L119
	mov  @>A(r10), r1
	inc  r1
	mov  r1, @>A(r10)
	mov  @>C(r10), r2
	c    r2, r1
	jh  JMP_41
	b    @L121
JMP_41
L120
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
	jne  JMP_42
	b    @L119
JMP_42
* Begin inline assembler code
* 252 "main.c" 1
	bl @SongLoop
* 0 "" 2
* End of inline assembler code
	mov  @songNote+6, r1
	andi r1, >1
	jeq  JMP_43
	b    @L119
JMP_43
	li   r1, musicmem
	clr  r2
	li   r3, StartSong
	bl   *r3
	mov  @>A(r10), r1
	inc  r1
	mov  r1, @>A(r10)
	mov  @>C(r10), r2
	c    r2, r1
	jle  JMP_44
	b    @L120
JMP_44
L121
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
	jne  JMP_45
	b    @L149
JMP_45
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
	jlt  L154
	mov  r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    @cputs
L154
	s    r4, r2
	neg  r2
	jlt  L155
	sra  r2, >1
	dec  r2
	mov  r2, r1
	swpb r1
	bl   @cspaces
L156
	mov  r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    @cputs
L155
	inc  r2
	sra  r2, >1
	dec  r2
	mov  r2, r1
	swpb r1
	bl   @cspaces
	jmp  L156
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
	jeq  L160
	srl  r1, 8
	mov  r1, @>A(r10)
	clr  r13
	clr  r9
	srl  r2, 8
	mov  r2, @>C(r10)
L159
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
	jh  L159
L160
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
L204
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
	jne  L209
L163
	jeq  0
	cb  @joyinterface, @$-1
	jeq  L164
	movb @>C(r10), r4
	jeq  JMP_46
	b    @L210
JMP_46
L164
	bl   @kbhit
	jeq  0
	cb  r1, @$-1
	jeq  JMP_47
	b    @L189
JMP_47
	clr  r5
	movb r1, r8
L188
	mov  @>A(r10), r2
	jmp  L193
L211
	inc  r2
L193
	movb *r2, r1
	movb r1, r3
	srl  r3, 8
	c    r3, r5
	jne  JMP_48
	b    @L191
JMP_48
	jeq  0
	cb  r1, @$-1
	jne  L211
L192
	li   r2, >D00
	cb   r8, r2
	jeq  JMP_49
	b    @L204
JMP_49
	movb r8, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	b    @L212
L209
	li   r1, vdpwaitvint
	bl   *r1
* Begin inline assembler code
* 366 "main.c" 1
	bl @SongLoop
* 0 "" 2
* End of inline assembler code
	mov  @songNote+6, r1
	andi r1, >1
	jeq  JMP_50
	b    @L163
JMP_50
	li   r1, musicmem
	clr  r2
	bl   @StartSong
	b    @L163
L191
	ci   r2, 0
	jne  JMP_51
	b    @L192
JMP_51
	jeq  0
	cb  r8, @$-1
	jne  JMP_52
	b    @L204
JMP_52
	movb r8, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	b    @L212
L210
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
	jne  JMP_53
	b    @L213
JMP_53
L165
	li   r8, >D00
	li   r5, >400
	cb   r15, r5
	jne  JMP_54
	b    @L214
JMP_54
L167
	li   r1, >400
	cb   r3, r1
	jne  JMP_55
	b    @L215
JMP_55
L169
	li   r4, >FC00
	cb   r15, r4
	jne  JMP_56
	b    @L170
JMP_56
	li   r5, >FC00
	cb   r3, r5
	jne  JMP_57
	b    @L170
JMP_57
L171
	li   r1, >FC00
	cb   r14, r1
	jne  JMP_58
	b    @L216
JMP_58
L172
	li   r4, >FC00
	cb   r2, r4
	jne  JMP_59
	b    @L217
JMP_59
L174
	li   r5, >400
	cb   r14, r5
	jne  JMP_60
	b    @L175
JMP_60
	li   r1, >400
	cb   r2, r1
	jne  JMP_61
	b    @L175
JMP_61
L222
	jeq  0
	cb  r8, @$-1
	jne  JMP_62
	b    @L164
JMP_62
L206
	movb r8, @>D(r10)
L203
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
	jne  JMP_63
	b    @L177
JMP_63
L207
	li   r1, >100
	li   r2, >400
	cb   r14, r2
	jne  JMP_64
	b    @L218
JMP_64
L180
	li   r5, >400
	cb   r4, r5
	jne  JMP_65
	b    @L219
JMP_65
L182
	li   r2, >FC00
	cb   r14, r2
	jne  JMP_66
	b    @L183
JMP_66
	li   r5, >FC00
	cb   r4, r5
	jne  JMP_67
	b    @L183
JMP_67
L184
	li   r2, >FC00
	cb   r15, r2
	jne  JMP_68
	b    @L220
JMP_68
L185
	li   r4, >FC00
	cb   r3, r4
	jne  JMP_69
	b    @L221
JMP_69
L187
	li   r5, >400
	cb   r15, r5
	jeq  L203
L186
	li   r2, >400
	cb   r3, r2
	jne  JMP_70
	b    @L203
JMP_70
	li   r4, >100
	cb   r1, r4
	jne  JMP_71
	b    @L203
JMP_71
	movb @>D(r10), r8
	movb r8, r5
	srl  r5, 8
	b    @L188
L213
	cb   r1, r4
	jeq  JMP_72
	b    @L165
JMP_72
	clr  r8
	li   r5, >400
	cb   r15, r5
	jeq  JMP_73
	b    @L167
JMP_73
L214
	li   r8, >900
	li   r5, >FC00
	cb   r3, r5
	jeq  JMP_74
	b    @L171
JMP_74
L170
	li   r8, >800
	li   r1, >FC00
	cb   r14, r1
	jeq  JMP_75
	b    @L172
JMP_75
L216
	li   r8, >A00
	li   r1, >400
	cb   r2, r1
	jeq  JMP_76
	b    @L222
JMP_76
L175
	li   r8, >B00
	b    @L206
L177
	clr  r1
	seto r5
	cb   r2, r5
	jeq  JMP_77
	b    @L207
JMP_77
	li   r2, >400
	cb   r14, r2
	jeq  JMP_78
	b    @L180
JMP_78
L218
	li   r1, >100
	li   r5, >FC00
	cb   r4, r5
	jeq  JMP_79
	b    @L184
JMP_79
L183
	li   r1, >100
	li   r2, >FC00
	cb   r15, r2
	jeq  JMP_80
	b    @L185
JMP_80
L220
	li   r1, >100
	b    @L186
L219
	li   r1, >100
	b    @L182
L221
	li   r1, >100
	b    @L187
L189
	bl   @cgetc
	movb r1, r8
	mov  @>A(r10), r5
	jeq  0
	cb  *r5, @$-1
	jne  L190
	li   r5, >D
	li   r8, >D00
	b    @L188
L217
	li   r8, >A00
	b    @L174
L215
	li   r8, >900
	b    @L169
L190
	movb r1, r5
	srl  r5, 8
	b    @L188
L212
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
	li   r2, C.117.2624
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
	jeq  L248
	cb   @>2(r14), r9
	jne  JMP_81
	b    @L250
JMP_81
	cb   @>3(r14), r9
	jne  JMP_82
	b    @L251
JMP_82
	cb   @>4(r14), r9
	jne  JMP_83
	b    @L228
JMP_83
	li   r9, >400
L248
	li   r1, pawnplace
	mov  r1, @>12(r10)
	li   r3, getkey
	mov  r3, @>14(r10)
L247
	li   r4, >300
L246
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
	jne  JMP_84
	b    @L229
JMP_84
	li   r3, >A00
	cb   r13, r3
	jeq  L229
L230
	li   r5, >900
	cb   r13, r5
	jeq  L231
	li   r1, >B00
	cb   r13, r1
	jeq  L231
	li   r2, >D00
	cb   r13, r2
	jeq  L233
L253
	cb   r9, r4
	jlt  L234
	jeq  L234
	clr  r9
L235
	movb r9, r2
	sra  r2, 8
L236
	a    r14, r2
	li   r3, >100
	cb   *r2, r3
	jeq  L246
	ab   r15, r9
	cb   r9, r4
	jlt  L237
	jeq  L237
L252
	clr  r9
L238
	movb r9, r1
	sra  r1, 8
L239
	a    r14, r1
	cb   *r1, r3
	jeq  L246
	ab   r15, r9
	cb   r9, r4
	jgt  L252
L237
	jeq  0
	cb  r9, @$-1
	jgt  L238
	jeq  L238
	li   r1, >3
	li   r9, >300
	jmp  L239
L231
	ai   r9, >100
	li   r15, >100
	li   r2, >D00
	cb   r13, r2
	jne  L253
L233
	bl   @windowrestore
	movb r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >10
	b    *r11
L229
	ai   r9, >FF00
	seto r15
	jmp  L230
L234
	jeq  0
	cb  r9, @$-1
	jgt  L235
	jeq  L235
	li   r2, >3
	li   r9, >300
	jmp  L236
L250
	li   r9, >200
	li   r5, pawnplace
	mov  r5, @>12(r10)
	li   r1, getkey
	mov  r1, @>14(r10)
	b    @L247
L228
	li   r9, >400
	li   r5, pawnplace
	mov  r5, @>12(r10)
	li   r1, getkey
	mov  r1, @>14(r10)
	b    @L247
L251
	li   r9, >300
	li   r3, pawnplace
	mov  r3, @>12(r10)
	li   r5, getkey
	mov  r5, @>14(r10)
	b    @L247
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
	li   r5, >3139
	movb r5, @>14(r10)
	swpb r5
	movb r5, @>15(r10)
	li   r4, >3331
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
	b    @L258
L257
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
	jne  JMP_85
	b    @L261
JMP_85
L258
	jeq  0
	cb  @musicnumber, @$-1
	jne  JMP_86
	b    @L257
JMP_86
	li   r2, vdpwaitvint
	bl   *r2
* Begin inline assembler code
* 847 "main.c" 1
	bl @SongLoop
* 0 "" 2
* End of inline assembler code
	mov  @songNote+6, r1
	andi r1, >1
	jeq  JMP_87
	b    @L257
JMP_87
	li   r1, musicmem
	clr  r2
	li   r3, StartSong
	bl   *r3
	b    @L257
L261
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
	text 'File error!'
	byte 0
LC15
	text 'Error nr.: %2X'
	byte 0
LC16
	text 'Press key.'
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
	li   r3, LC14
	bl   *r9
	li   r1, >C
	mov  r1, @conio_x
	li   r1, >8
	mov  r1, @conio_y
	ai   r10, >FFFC
	li   r1, LC15
	mov  r1, *r10
	movb r13, r1
	srl  r1, 8
	mov  r1, @>2(r10)
	bl   @cprintf
	ai   r10, >4
	li   r1, >C
	li   r2, >A
	li   r3, LC16
	bl   *r9
	li   r1, LC12
	li   r2, >100
	bl   @getkey
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    @windowrestore
	.size	fileerrormessage, .-fileerrormessage
LC17
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
	jle  JMP_88
	b    @L265
JMP_88
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
L270
	mov  @>14(r10), r1
	movb *r1, r4
	jne  JMP_89
	b    @L292
JMP_89
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
L271
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
	li   r1, LC17
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
	jh  L271
L267
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
	jmp  L272
L273
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
L272
	mov  r14, r1
	bl   *r15
	inc  r1
	movb r9, r4
	srl  r4, 8
	c    r1, r4
	jgt  L273
	jeq  L273
	mov  r10, r1
	ai   r1, >A
	li   r2, updownenter
	bl   @strcpy
	movb @>20(r10), r2
	cb   r2, @menubaroptions
	jh  JMP_90
	b    @L293
JMP_90
L274
	li   r13, >100
	li   r15, >1
L287
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
	jh  L287
	srl  r2, 8
	a    r2, r2
	mov  @L279(r2), r3
	b    *r3
	even
L279
		data		L276
		data		L276
		data		L277
		data		L277
		data		L287
		data		L278
L276
	movb r1, r13
	ai   r13, >A00
L278
	bl   @windowrestore
	movb r13, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >1A
	b    *r11
L277
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
	jeq  L294
	ai   r13, >100
	mov  @>14(r10), r2
	cb   r13, *r2
	jh  L274
L291
	movb r13, r15
	srl  r15, 8
	jmp  L287
L294
	ai   r13, >FF00
	jne  L291
	mov  @>14(r10), r1
	movb *r1, r13
	movb r13, r15
	srl  r15, 8
	jmp  L287
L293
	mov  r10, r1
	ai   r1, >A
	li   r2, leftright
	bl   @strcat
	b    @L274
L265
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
	jmp  L268
L269
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
L268
	mov  r15, r1
	bl   *r14
	inc  r1
	movb r13, r3
	srl  r3, 8
	c    r1, r3
	jgt  L269
	jeq  L269
	mov  @>12(r10), r9
	b    @L270
L292
	mov  @>1C(r10), r2
	inc  r2
	mov  r2, @>12(r10)
	b    @L267
	.size	menupulldown, .-menupulldown
LC18
	text '%s has won!'
	byte 0
LC19
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
	li   r1, LC18
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
	li   r3, LC19
	bl   @cputsxy
	li   r13, menupulldown
	li   r9, >200
	li   r14, >300
	li   r15, >100
L299
	li   r1, >A00
	movb r1, r2
	li   r3, >700
	bl   *r13
	cb   r1, r9
	jeq  L302
	cb   r1, r14
	jeq  L303
	cb   r1, r15
	jne  L297
	jeq  0
	cb  @playerdata+1, @$-1
	jne  L297
	jeq  0
	cb  @playerdata+5, @$-1
	jne  L297
	jeq  0
	cb  @playerdata+9, @$-1
	jne  L297
	jeq  0
	cb  @playerdata+13, @$-1
	jeq  L299
L297
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @windowrestore
L303
	li   r1, >100
	movb r1, @endofgameflag
	movb r1, @zv
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @windowrestore
L302
	li   r1, >300
	movb r1, @endofgameflag
	bl   @gamereset
	li   r1, >100
	movb r1, @zv
	jmp  L297
	.size	playerwins, .-playerwins
LC20
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
	li   r3, LC20
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
L322
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
	jmp  L307
L308
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
L307
	mov  r14, r1
	li   r4, strlen
	bl   *r4
	movb r9, r4
	srl  r4, 8
	c    r4, r1
	jlt  L308
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
	jne  JMP_91
	b    @L326
JMP_91
	li   r1, >900
	cb   r9, r1
	jne  JMP_92
	b    @L327
JMP_92
	li   r4, >D00
	cb   r9, r4
	jne  L322
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
	jlt  L313
	jeq  L313
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
L313
	movb r9, r1
	clr  r2
	movb @>E(r10), r3
	li   r4, menupulldown
	bl   *r4
	li   r2, >1200
	cb   r1, r2
	jne  JMP_93
	b    @L328
JMP_93
	li   r3, >1300
	cb   r1, r3
	jeq  L329
	jeq  0
	cb  r1, @$-1
	jne  JMP_94
	b    @L322
JMP_94
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
L326
	movb @>E(r10), r1
	ai   r1, >FF00
	movb r1, @>E(r10)
	jne  L325
	movb @menubaroptions, r3
	movb r3, @>E(r10)
	movb r3, r4
	srl  r4, 8
	mov  r4, @>12(r10)
	b    @L322
L327
	movb @>E(r10), r2
	ai   r2, >100
	movb r2, @>E(r10)
	cb   r2, @menubaroptions
	jh  L312
	movb r2, r3
	srl  r3, 8
	mov  r3, @>12(r10)
	b    @L322
L324
	movb @menubaroptions, r1
	movb r1, @>E(r10)
L325
	movb r1, r2
	srl  r2, 8
	mov  r2, @>12(r10)
	b    @L322
L312
	li   r2, >100
	movb r2, @>E(r10)
	li   r3, >1
	mov  r3, @>12(r10)
	b    @L322
L329
	movb @>E(r10), r4
	ai   r4, >100
	movb r4, @>E(r10)
	cb   r4, @menubaroptions
	jh  L316
	movb r4, r1
	srl  r1, 8
	mov  r1, @>12(r10)
	b    @L322
L328
	movb @>E(r10), r3
	ai   r3, >FF00
	movb r3, @>E(r10)
	jeq  L324
	movb r3, r4
	srl  r4, 8
	mov  r4, @>12(r10)
	b    @L322
L316
	li   r4, >100
	movb r4, @>E(r10)
	li   r1, >1
	mov  r1, @>12(r10)
	b    @L322
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
L331
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
	jlt  L331
	jeq  L331
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
	jle  L358
L333
	movb @>58(r10), r3
	cb   r9, r3
	jhe  JMP_95
	b    @L359
JMP_95
L340
	movb r9, r13
L343
	movb r13, r9
L360
	mov  r10, r1
	ai   r1, >A
	clr  r2
	li   r4, getkey
	bl   *r4
	movb r1, r4
	ai   r4, >FD00
	ci   r4, >AFF
	jh  L333
L358
	srl  r4, 8
	a    r4, r4
	mov  @L339(r4), r3
	b    *r3
	even
L339
		data		L334
		data		L335
		data		L333
		data		L333
		data		L333
		data		L336
		data		L337
		data		L333
		data		L333
		data		L333
		data		L338
L338
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
L337
	mov  r14, r1
	li   r3, strlen
	bl   *r3
	movb r9, r4
	srl  r4, 8
	c    r4, r1
	jgt  L340
	jeq  L340
	movb @>58(r10), r4
	cb   r9, r4
	jhe  L340
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
	b    @L360
L336
	jeq  0
	cb  r9, @$-1
	jne  JMP_96
	b    @L340
JMP_96
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
	jeq  JMP_97
	b    @L347
JMP_97
	li   r2, >1A
L348
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
	b    @L360
L335
	mov  r14, r1
	li   r4, strlen
	bl   *r4
	mov  r1, r4
	swpb r4
	movb @>58(r10), r1
	cb   r1, r4
	jh  JMP_98
	b    @L340
JMP_98
	jeq  0
	cb  r4, @$-1
	jne  JMP_99
	b    @L340
JMP_99
	cb   r9, r4
	jl  JMP_100
	b    @L340
JMP_100
	ai   r4, >100
	cb   r9, r4
	jh  L344
	movb r4, r5
	srl  r5, 8
	a    r14, r5
	movb *r5, @>1(r5)
	jeq  0
	cb  r4, @$-1
	jne  L355
	jmp  L344
L346
	movb r4, r1
	srl  r1, 8
	a    r14, r1
	movb *r1, @>1(r1)
	jeq  0
	cb  r4, @$-1
	jeq  L344
L355
	ai   r4, >FF00
	cb   r9, r4
	jle  L346
L344
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
	b    @L360
L334
	jeq  0
	cb  r9, @$-1
	jne  JMP_101
	b    @L340
JMP_101
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
	jeq  L341
	movb r13, @>5E(r10)
	mov  r3, r13
L352
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
	jne  L352
	movb @>5E(r10), r13
L341
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
	jeq  L361
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
L362
	movb r13, r9
	b    @L360
L359
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
	jeq  JMP_102
	b    @L343
JMP_102
	movb r13, r4
	srl  r4, 8
	a    r14, r4
	movb r3, @>1(r4)
	movb r13, r9
	b    @L360
L361
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
	jmp  L362
L347
	movb r5, r2
	srl  r2, 8
	b    @L348
	.size	input, .-input
LC21
	text 'Computer plays player %d?'
	byte 0
LC22
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
L366
	li   r1, >4
	mov  r1, @conio_x
	li   r2, >A
	mov  r2, @conio_y
	inc  r9
	ai   r10, >FFFC
	li   r4, LC21
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
	jeq  L369
	clr  r4
	movb r4, *r13
L365
	li   r5, >4
	mov  r5, @conio_x
	li   r1, >A
	mov  r1, @conio_y
	ai   r10, >FFFC
	li   r2, LC22
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
	jne  L366
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @windowrestore
L369
	movb r2, *r13
	jmp  L365
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
LC23
	text 'DSK1.LUDOCFG'
	byte 0
	even

	def	saveconfigfile
saveconfigfile
	ai   r10, >FFF0
	mov  r11, *r10
	mov  r10, r1
	inct r1
	li   r2, LC23
	li   r3, >D
	bl   @memcpy
	mov  r10, r1
	inct r1
	li   r2, saveslots
	li   r3, >55
	bl   @dsr_save
	jeq  0
	cb  r1, @$-1
	jne  L375
	mov  *r10, r11
	ai   r10, >10
	b    *r11
	jmp  L376
L375
	bl   @fileerrormessage
	mov  *r10, r11
	ai   r10, >10
	b    *r11
L376
	.size	saveconfigfile, .-saveconfigfile
LC25
	text 'Save game.'
	byte 0
LC26
	text 'Choose slot:'
	byte 0
LC27
	text 'Slot not empty. Sure?'
	byte 0
LC28
	text 'Choose name of save. '
	byte 0
LC24
	text 'DSK1.LUDOSAV'
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
	li   r2, LC24
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
	jne  JMP_103
	b    @L408
JMP_103
	li   r1, >200
	li   r2, >500
	li   r3, >C00
	li   r4, >1C00
	bl   @menumakeborder
	li   r14, cputsxy
	li   r1, >4
	li   r2, >7
	li   r3, LC25
	bl   *r14
	li   r1, >4
	li   r2, >8
	li   r3, LC26
	bl   *r14
	li   r13, menupulldown
L380
	li   r1, >A00
	movb r1, r2
	li   r3, >800
	bl   *r13
	movb r1, r9
	ai   r9, >FF00
	jeq  L380
	movb r9, r5
	srl  r5, 8
	mov  r5, r13
	ai   r13, saveslots
	li   r4, >100
	cb   *r13, r4
	jne  JMP_104
	b    @L409
JMP_104
L381
	li   r1, >4
	li   r2, >9
	li   r3, LC28
	mov  r5, @>1C(r10)
	bl   *r14
	li   r1, >100
	mov  @>1C(r10), r5
	cb   *r13, r1
	jne  JMP_105
	b    @L406
JMP_105
	mov  r5, r6
	ai   r6, >23
L383
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
	jle  JMP_106
	b    @L410
JMP_106
	sla  r5, >4
	mov  r5, r4
	ai   r4, pulldownmenutitles
	li   r1, >F00
L385
	movb r2, r3
	srl  r3, 8
	a    r4, r3
	li   r7, >2000
	movb r7, @>230(r3)
	ai   r2, >100
	cb   r2, r1
	jne  L385
L384
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
L386
	movb *r3+, *r2+
	c    r2, r5
	jne  L386
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
	jmp  L379
L408
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
L379
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
L387
	mov  r3, r2
	sla  r2, >2
	ai   r2, playerdata
	mov  r4, r1
	ai   r1, savegamemem
	mov  r4, r5
	ai   r5, savegamemem+4
L388
	movb *r2+, *r1+
	c    r1, r5
	jne  L388
	inc  r3
	ai   r4, >4
	ci   r3, >4
	jne  L387
	li   r5, >15
	clr  r4
	li   r6, >400
L389
	mov  r4, r1
	sla  r1, >3
	ai   r1, playerpos
	mov  r5, r2
	ai   r2, savegamemem
	clr  r3
L390
	movb *r1, *r2
	movb @>1(r1), @>1(r2)
	ai   r3, >100
	inct r1
	inct r2
	cb   r3, r6
	jne  L390
	inc  r4
	ai   r5, >8
	ci   r4, >4
	jne  L389
	li   r5, >35
	clr  r4
L391
	mov  r4, r2
	sla  r2, >3
	a    r4, r2
	ai   r2, playername
	mov  r5, r1
	ai   r1, savegamemem
	mov  r5, r3
	ai   r3, savegamemem+21
L392
	movb *r2+, *r1+
	c    r3, r1
	jne  L392
	inc  r4
	ai   r5, >15
	ci   r4, >4
	jne  L391
	mov  r10, r1
	ai   r1, >A
	li   r2, savegamemem
	li   r3, >88
	bl   @dsr_save
	jeq  0
	cb  r1, @$-1
	jne  L411
L395
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >16
	b    *r11
L411
	bl   @fileerrormessage
	jmp  L395
L409
	li   r1, >4
	li   r2, >9
	li   r3, LC27
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
	jne  JMP_107
	b    @L381
JMP_107
	bl   @windowrestore
	jmp  L395
L406
	mov  r5, r6
	ai   r6, >23
	mov  r6, r1
	sla  r1, >4
	clr  r3
	movb r3, @pulldownmenutitles(r1)
	b    @L383
L410
	sla  r5, >4
	b    @L384
	.size	savegame, .-savegame
LC29
	text 'Throw 3x'
	byte 0
LC30
	text '        '
	byte 0
LC31
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
	jne  JMP_108
	b    @L491
JMP_108
L413
	li   r13, >100
	li   r1, cputsxy
	mov  r1, @>E(r10)
L418
	clr  r9
	li   r15, dicethrow
	li   r14, >600
L420
	bl   *r15
	movb r1, @throw
	cb   r1, r14
	jeq  L419
	ai   r9, >100
	cb   r13, r9
	jh  L420
L419
	li   r1, >17
	li   r2, >7
	li   r3, LC30
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
	jne  JMP_109
	b    @L492
JMP_109
L421
	clr  r14
L423
	mov  r3, r12
	ai   r12, np
	movb *r12, r15
	jgt  JMP_110
	jeq  JMP_110
	b    @L493
JMP_110
	jeq  0
	cb  r4, @$-1
	jne  JMP_111
	b    @L494
JMP_111
L426
	seto r2
	movb r2, *r12
L425
	jeq  0
	cb  r14, @$-1
	jeq  JMP_112
	b    @L427
JMP_112
	seto r4
	cb   r15, r4
	jne  JMP_113
	b    @L495
JMP_113
L428
	li   r9, >100
L452
	li   r3, >600
	cb   @throw, r3
	jne  JMP_114
	b    @L496
JMP_114
L454
	jeq  0
	cb  r9, @$-1
	jne  JMP_115
	b    @L455
JMP_115
	li   r13, >100
	cb   r14, r13
	jne  JMP_116
	b    @L455
JMP_116
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
	jne  JMP_117
	b    @L497
JMP_117
L458
	movb r5, r3
	ab   @throw, r3
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	movb r3, @playerpos+1(r4)
L459
	jeq  0
	cb  r9, @$-1
	jeq  JMP_118
	b    @L460
JMP_118
	li   r4, >2700
	cb   r3, r4
	jle  JMP_119
	b    @L498
JMP_119
L465
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	movb @>1(r3), r3
L467
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	movb @playerpos(r4), r7
	li   r4, >100
	cb   r7, r4
	jne  JMP_120
	b    @L499
JMP_120
L468
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
	jne  JMP_121
	b    @L500
JMP_121
L469
	ci   r3, >27FF
	jle  L470
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	ai   r3, >D800
	movb r3, @playerpos+1(r4)
L470
	clr  r0
	a    r6, r8
	a    r8, r8
	ai   r8, playerpos
	mov  r8, r13
	inc  r13
	li   r12, >400
L471
	clr  r2
	clr  r5
	movb r0, r3
	srl  r3, >6
	andi r3, >FFFC
	jmp  L475
L472
	mov  r3, r1
	a    r2, r1
	a    r1, r1
	ai   r1, playerpos
	jeq  0
	cb  *r1, @$-1
	jne  L473
	jeq  0
	cb  *r8, @$-1
	jne  L473
	cb   @>1(r1), *r13
	jeq  L474
L473
	ai   r5, >100
	inc  r2
	cb   r5, r12
	jeq  L501
L475
	c    r6, r2
	jne  L472
	cb   r0, r9
	jne  L472
	ai   r5, >100
	inc  r2
	cb   r5, r12
	jne  L475
L501
	ai   r0, >100
	ci   r0, >3FF
	jle  L471
	clr  r5
	seto r0
L474
	seto r3
	cb   r0, r3
	jeq  JMP_122
	b    @L487
JMP_122
	li   r13, pawnplace
L477
	movb r9, r1
	movb r15, r2
	clr  r3
	bl   *r13
	movb @turnofplayernr, r1
	srl  r1, >6
	andi r1, >FFFC
	jeq  0
	cb  @playerdata(r1), @$-1
	jne  L478
	li   r1, >100
	cb   @autosavetoggle, r1
	jne  JMP_123
	b    @L502
JMP_123
L478
	li   r1, >17
	li   r2, >7
	jmp  L488
L455
	li   r1, >17
	li   r2, >7
	li   r3, LC31
	mov  @>E(r10), r4
	bl   *r4
	li   r1, >17
	li   r2, >8
L488
	li   r3, LC13
	mov  @>E(r10), r4
	bl   *r4
	li   r1, LC12
	li   r2, >100
	bl   @getkey
L479
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >10
	b    *r11
L495
	movb @throw, r13
	movb r14, r2
	li   r0, >100
	sla  r3, >3
	ai   r3, playerpos
	mov  r3, @>10(r10)
	li   r9, >400
	movb r14, @>12(r10)
	mov  r12, r14
L446
	movb r2, r12
	srl  r12, 8
	mov  r8, r3
	a    r12, r3
	a    r3, r3
	ai   r3, playerpos
	movb *r3+, r4
	movb *r3, r5
	cb   r4, r0
	jne  JMP_124
	b    @L503
JMP_124
	movb r5, r7
	ab   r13, r7
	jeq  0
	cb  r4, @$-1
	jne  L433
	jeq  0
	cb  r1, @$-1
	jeq  JMP_125
	b    @L434
JMP_125
	li   r4, >2700
	cb   r7, r4
	jle  L440
	cb   r5, r4
	jh  JMP_126
	b    @L504
JMP_126
L440
	clr  r4
L436
	cb   r4, r0
	jne  JMP_127
	b    @L441
JMP_127
L433
	li   r3, >A
	a    r10, r3
	a    r12, r3
	li   r4, >100
	movb r4, *r3
	ab   r4, r2
L432
	cb   r2, r9
	jne  L446
	movb @>12(r10), r14
L427
	seto r3
	cb   r15, r3
	jeq  JMP_128
	b    @L428
JMP_128
	li   r9, >100
	cb   @>A(r10), r9
	jne  JMP_129
	b    @L447
JMP_129
	clr  r9
L448
	li   r3, >100
	cb   @>B(r10), r3
	jne  JMP_130
	b    @L505
JMP_130
L449
	li   r3, >100
	cb   @>C(r10), r3
	jne  JMP_131
	b    @L506
JMP_131
L450
	li   r3, >100
	cb   @>D(r10), r3
	jne  JMP_132
	b    @L507
JMP_132
L451
	ci   r9, >1FF
	jh  JMP_133
	b    @L452
JMP_133
	jeq  0
	cb  @playerdata(r8), @$-1
	jeq  JMP_134
	b    @L453
JMP_134
	mov  r10, r2
	ai   r2, >A
	bl   @humanchoosepawn
	movb r1, r15
	li   r3, >600
	cb   @throw, r3
	jeq  JMP_135
	b    @L454
JMP_135
L496
	li   r1, >100
	movb r1, @zv
	b    @L454
L494
	seto r15
	b    @L426
L492
	li   r2, >300
	cb   r13, r2
	jeq  JMP_136
	b    @L421
JMP_136
	clr  r14
	li   r2, >600
	cb   @throw, r2
	jne  JMP_137
	b    @L423
JMP_137
	li   r14, >100
	b    @L423
L491
	mov  r1, r2
	sla  r2, >3
	jeq  0
	cb  @playerpos(r2), @$-1
	jne  JMP_138
	b    @L508
JMP_138
	li   r13, >300
L415
	inc  r3
	a    r3, r3
	jeq  0
	cb  @playerpos(r3), @$-1
	jne  L416
	li   r13, >100
L416
	a    r1, r1
	inc  r1
	sla  r1, >2
	jeq  0
	cb  @playerpos(r1), @$-1
	jne  L417
	li   r13, >100
L417
	ai   r2, playerpos
	jeq  0
	cb  @>6(r2), @$-1
	jne  JMP_139
	b    @L413
JMP_139
	li   r1, >300
	cb   r13, r1
	jne  JMP_140
	b    @L486
JMP_140
	li   r2, cputsxy
	mov  r2, @>E(r10)
	b    @L418
L453
	mov  r10, r2
	ai   r2, >A
	bl   @computerchoosepawn
	movb r1, r15
	b    @L452
L493
	seto r15
	b    @L425
L487
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
	b    @L477
L460
	li   r0, >100
	cb   r9, r0
	jne  L462
	li   r4, >900
	cb   r3, r4
	jh  JMP_141
	b    @L465
JMP_141
	cb   r5, r4
	jle  JMP_142
	b    @L465
JMP_142
	jeq  0
	cb  r7, @$-1
	jeq  JMP_143
	b    @L465
JMP_143
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	movb r9, *r3+
	li   r2, >FA00
	ab   r2, *r3
	b    @L465
L508
	li   r13, >100
	b    @L415
L498
	cb   r5, r4
	jle  JMP_144
	b    @L465
JMP_144
	jeq  0
	cb  r7, @$-1
	jeq  JMP_145
	b    @L465
JMP_145
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	li   r4, >100
	movb r4, *r3+
	li   r1, >DC00
	ab   r1, *r3
	b    @L465
L462
	li   r4, >200
	cb   r9, r4
	jeq  JMP_146
	b    @L464
JMP_146
	li   r4, >1300
	cb   r3, r4
	jh  JMP_147
	b    @L465
JMP_147
	cb   r5, r4
	jle  JMP_148
	b    @L465
JMP_148
	jeq  0
	cb  r7, @$-1
	jeq  JMP_149
	b    @L465
JMP_149
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	movb r0, *r3+
	li   r4, >F000
	ab   r4, *r3
	b    @L465
L503
	ci   r5, >3FF
	jh  L430
	li   r3, >600
	cb   r13, r3
	jeq  L509
L444
	ai   r2, >100
	b    @L432
L509
	movb r2, r15
	movb r2, *r14
	li   r2, >400
	b    @L432
L430
	movb r5, r7
	ab   r13, r7
L441
	ci   r7, >7FF
	jh  L444
	mov  @>10(r10), r6
	clr  r5
	jmp  L445
L443
	ai   r5, >100
	inct r6
	cb   r5, r9
	jne  JMP_150
	b    @L433
JMP_150
L445
	cb   r5, r2
	jeq  L443
	cb   *r6, r0
	jne  L443
	movb @>1(r6), r3
	cb   r3, r7
	jh  L443
	ci   r3, >3FF
	jle  L443
	ai   r2, >100
	b    @L432
L434
	cb   r1, r0
	jne  L437
	li   r4, >900
	cb   r7, r4
	jh  JMP_151
	b    @L440
JMP_151
	cb   r5, r4
	jle  JMP_152
	b    @L440
JMP_152
	ai   r7, >FA00
	movb r1, r4
	b    @L436
L499
	ci   r3, >3FF
	jh  JMP_153
	b    @L468
JMP_153
	movb r3, @dp(r12)
	b    @L468
L500
	li   r5, >100
	cb   r7, r5
	jeq  JMP_154
	b    @L469
JMP_154
	ai   r12, >FF00
	movb r12, *r4
	b    @L469
L497
	ci   r5, >3FF
	jle  JMP_155
	b    @L458
JMP_155
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
	b    @L459
L437
	li   r4, >200
	cb   r1, r4
	jeq  JMP_156
	b    @L439
JMP_156
	li   r4, >1300
	cb   r7, r4
	jh  JMP_157
	b    @L440
JMP_157
	cb   r5, r4
	jle  JMP_158
	b    @L440
JMP_158
	ai   r7, >F000
	li   r4, >100
	b    @L436
L507
	ab   r3, r9
	li   r15, >300
	b    @L451
L506
	ab   r3, r9
	li   r15, >200
	b    @L450
L505
	ab   r3, r9
	movb r3, r15
	b    @L449
L447
	clr  r15
	b    @L448
L504
	ai   r7, >DC00
	li   r4, >100
	b    @L436
L502
	bl   @savegame
	b    @L479
L486
	li   r3, cputsxy
	mov  r3, @>E(r10)
	li   r1, >17
	li   r2, >7
	li   r3, LC29
	li   r4, cputsxy
	bl   *r4
	b    @L418
L464
	li   r4, >300
	cb   r9, r4
	jeq  JMP_159
	b    @L465
JMP_159
	li   r4, >1D00
	cb   r3, r4
	jh  JMP_160
	b    @L467
JMP_160
	cb   r5, r4
	jle  JMP_161
	b    @L467
JMP_161
	jeq  0
	cb  r7, @$-1
	jeq  JMP_162
	b    @L467
JMP_162
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	ai   r4, playerpos
	movb r0, *r4+
	movb *r4, r3
	ai   r3, >E600
	movb r3, *r4
	b    @L467
L439
	li   r4, >300
	cb   r1, r4
	jeq  JMP_163
	b    @L433
JMP_163
	li   r4, >1D00
	cb   r7, r4
	jh  JMP_164
	b    @L433
JMP_164
	cb   r5, r4
	jle  JMP_165
	b    @L433
JMP_165
	ai   r7, >E600
	b    @L441
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
	jne  L511
	li   r1, >1A00
	mov  r14, r2
	mov  r13, r3
	bl   @vdpmemread
L511
	movb r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10, r14
	ai   r10, >E
	b    *r11
	.size	dsr_load, .-dsr_load
LC32
	text 'DSK1.LUDOMUS'
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
	li   r2, LC32
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
	jh  L514
	ai   r2, >3000
L515
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
	jeq  L516
	bl   @fileerrormessage
L516
	li   r1, musicmem
	clr  r2
	bl   @StartSong
	mov  *r10+, r11
	mov  *r10, r9
	ai   r10, >10
	b    *r11
L514
	li   r2, >100
	movb r2, @musicnumber
	li   r2, >3100
	jmp  L515
	.size	musicnext, .-musicnext
LC33
	text 'Load game.'
	byte 0
LC34
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
	li   r2, LC24
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
	li   r3, LC33
	bl   *r13
	li   r1, >4
	li   r2, >9
	li   r3, LC26
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
	jeq  L535
	bl   @windowrestore
	li   r2, >100
	cb   *r9, r2
	jeq  L536
L529
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >14
	b    *r11
	b    @L537
L535
	li   r1, >4
	li   r2, >9
	li   r3, LC34
	bl   *r13
	li   r1, >4
	li   r2, >A
	li   r3, LC16
	bl   *r13
	li   r1, LC12
	li   r2, >100
	bl   @getkey
	bl   @windowrestore
	li   r2, >100
	cb   *r9, r2
	jne  L529
L536
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
	jeq  JMP_166
	b    @L538
JMP_166
	movb @savegamemem, @turnofplayernr
	movb @savegamemem+1, @np
	movb @savegamemem+2, @np+1
	movb @savegamemem+3, @np+2
	movb @savegamemem+4, @np+3
	li   r4, >5
	clr  r3
L522
	mov  r4, r1
	ai   r1, savegamemem
	mov  r3, r2
	sla  r2, >2
	ai   r2, playerdata
	mov  r4, r5
	ai   r5, savegamemem+4
L523
	movb *r1+, *r2+
	c    r5, r1
	jne  L523
	inc  r3
	ai   r4, >4
	ci   r3, >4
	jne  L522
	li   r1, >15
	mov  r1, @>18(r10)
	clr  r3
	mov  r3, @>1A(r10)
	clr  r15
L524
	mov  @>18(r10), r14
	ai   r14, savegamemem
	mov  @>1A(r10), r13
	sla  r13, >3
	ai   r13, playerpos
	clr  r9
L525
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
	jne  L525
	ai   r15, >100
	mov  @>1A(r10), r3
	inc  r3
	mov  r3, @>1A(r10)
	mov  @>18(r10), r4
	ai   r4, >8
	mov  r4, @>18(r10)
	cb   r15, r9
	jne  L524
	li   r5, >35
	clr  r4
L526
	mov  r5, r1
	ai   r1, savegamemem
	mov  r4, r2
	sla  r2, >3
	a    r4, r2
	ai   r2, playername
	mov  r5, r3
	ai   r3, savegamemem+21
L527
	movb *r1+, *r2+
	c    r1, r3
	jne  L527
	inc  r4
	ai   r5, >15
	ci   r4, >4
	jne  L526
	li   r1, >200
	movb r1, @endofgameflag
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >14
	b    *r11
	jmp  L537
L538
	bl   @fileerrormessage
	b    @L529
L537
	.size	loadgame, .-loadgame
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
	li   r15, StopSong
	jmp  L556
L540
	movb r9, r1
	ai   r1, >F500
	ci   r1, >2FF
	jle  L557
L552
	li   r1, >1600
	cb   r9, r1
	jeq  L557
L556
	bl   *r14
	movb r1, r9
	ai   r1, >F400
	cb   r1, r13
	jh  L540
	srl  r1, 8
	a    r1, r1
	mov  @L550(r1), r2
	b    *r2
	even
L550
		data		L541
		data		L542
		data		L540
		data		L540
		data		L540
		data		L540
		data		L540
		data		L540
		data		L540
		data		L543
		data		L544
		data		L545
		data		L540
		data		L540
		data		L540
		data		L540
		data		L540
		data		L540
		data		L540
		data		L546
		data		L547
		data		L548
		data		L540
		data		L540
		data		L540
		data		L540
		data		L540
		data		L540
		data		L540
		data		L549
L549
	li   r1, informationcredits
	bl   *r1
	li   r1, >1600
	cb   r9, r1
	jne  L556
L557
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	b    @L559
L548
	jeq  0
	cb  @musicnumber, @$-1
	jeq  JMP_167
	b    @L560
JMP_167
	li   r3, >100
	movb r3, @musicnumber
	li   r1, musicmem
	clr  r2
	li   r4, StartSong
	bl   *r4
	jmp  L552
L547
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
	jmp  L552
L546
	li   r1, musicnext
	bl   *r1
	b    @L552
L545
	li   r1, >100
	cb   @autosavetoggle, r1
	jeq  L561
	movb r1, @autosavetoggle
	li   r1, pulldownmenutitles+112
	li   r2, LC36
	li   r3, >D
	li   r4, memcpy
	bl   *r4
	b    @L552
L544
	li   r4, areyousure
	bl   *r4
	li   r2, >100
	cb   r1, r2
	jeq  JMP_168
	b    @L552
JMP_168
	bl   @loadgame
	b    @L552
L543
	clr  r1
	bl   @savegame
	b    @L552
L542
	bl   @areyousure
	li   r2, >100
	cb   r1, r2
	jeq  JMP_169
	b    @L557
JMP_169
	movb r1, @endofgameflag
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	jmp  L559
L541
	bl   @areyousure
	li   r2, >100
	cb   r1, r2
	jeq  JMP_170
	b    @L557
JMP_170
	li   r3, >300
	movb r3, @endofgameflag
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @gamereset
L560
	bl   *r15
	li   r1, musicmem
	clr  r2
	li   r4, StartSong
	bl   *r4
	b    @L552
L561
	clr  r1
	movb r1, @autosavetoggle
	li   r1, pulldownmenutitles+112
	li   r2, LC35
	li   r3, >D
	li   r4, memcpy
	bl   *r4
	b    @L552
L559
	.size	turnhuman, .-turnhuman
	even

	def	loadconfigfile
loadconfigfile
	ai   r10, >FFF0
	mov  r11, *r10
	mov  r10, r1
	inct r1
	li   r2, LC23
	li   r3, >D
	bl   @memcpy
	mov  r10, r1
	inct r1
	li   r2, saveslots
	li   r3, >55
	bl   @dsr_load
	jeq  0
	cb  r1, @$-1
	jne  L563
	li   r5, >5
	clr  r4
L564
	mov  r5, r1
	ai   r1, saveslots
	mov  r4, r2
	ai   r2, >23
	sla  r2, >4
	ai   r2, pulldownmenutitles
	mov  r5, r3
	ai   r3, saveslots+16
L566
	movb *r1+, *r2+
	c    r1, r3
	jne  L566
	inc  r4
	ai   r5, >10
	ci   r4, >5
	jne  L564
	mov  *r10, r11
	ai   r10, >10
	b    *r11
	jmp  L569
L563
	bl   @fileerrormessage
	mov  *r10, r11
	ai   r10, >10
	b    *r11
L569
	.size	loadconfigfile, .-loadconfigfile
LC37
	text 'DSK1.LUDOMUS1'
	byte 0
LC38
	text 'Press ENTER/FIRE to start game.'
	byte 0
LC39
	text 'M=toggle music.'
	byte 0
LC40
	text 'Music: '
	byte 0
LC41
	text 'Yes '
	byte 0
LC42
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
	li   r2, C.133.3099
	li   r3, >4
	bl   @memcpy
	mov  @gImage, r1
	li   r2, titlescreen
	li   r3, >240
	bl   @vdpmemcpy
	bl   @loadconfigfile
	li   r1, musicmem
	clr  r2
	li   r3, >C80
	bl   @memset
	li   r1, LC37
	li   r2, musicmem
	li   r3, >C80
	bl   @dsr_load
	jeq  0
	cb  r1, @$-1
	jeq  JMP_171
	b    @L583
JMP_171
L571
	li   r1, musicmem
	clr  r2
	li   r3, StartSong
	bl   *r3
	li   r9, cputsxy
	li   r1, >1
	li   r2, >15
	li   r3, LC38
	bl   *r9
	li   r1, >1
	li   r2, >16
	li   r3, LC39
	bl   *r9
	li   r15, cputs
	li   r14, getkey
	li   r13, >4D00
L581
	li   r1, >1
	li   r2, >14
	li   r3, LC40
	bl   *r9
	jeq  0
	cb  @musicnumber, @$-1
	jeq  L572
L584
	li   r1, LC41
	bl   *r15
L573
	mov  r10, r1
	ai   r1, >A
	li   r2, >100
	bl   *r14
	cb   r1, r13
	jeq  L575
	li   r2, >6D00
	cb   r1, r2
	jeq  L575
	li   r2, >D00
	cb   r1, r2
	jne  L581
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
L575
	jeq  0
	cb  @musicnumber, @$-1
	jeq  L576
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
	li   r3, LC40
	bl   *r9
	jeq  0
	cb  @musicnumber, @$-1
	jne  L584
L572
	li   r1, LC42
	bl   *r15
	jmp  L573
L576
	li   r3, >100
	movb r3, @musicnumber
	li   r1, musicmem
	clr  r2
	li   r3, StartSong
	bl   *r3
	jmp  L581
L583
	bl   @fileerrormessage
	b    @L571
	.size	loadintro, .-loadintro
LC43
	text 'Load old game?'
	byte 0
LC44
	text 'Player %d'
	byte 0
LC45
	text 'Color'
	byte 0
LC46
	text 'Computer'
	byte 0
LC47
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
	li   r3, LC43
	bl   *r15
	li   r1, >1100
	li   r2, >800
	li   r3, >500
	bl   @menupulldown
	movb r1, r9
	bl   @windowrestore
	li   r2, >100
	cb   r9, r2
	jne  JMP_172
	b    @L605
JMP_172
L586
	movb @endofgameflag, r1
	jne  JMP_173
	b    @L606
JMP_173
L587
	li   r9, >100
	li   r14, >300
L599
	jeq  0
	cb  r1, @$-1
	jne  JMP_174
	b    @L588
JMP_174
	clr  r1
	movb r1, @endofgameflag
L589
	li   r13, turngeneric
L601
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
	li   r4, LC44
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
	li   r3, LC45
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
	jeq  JMP_175
	b    @L590
JMP_175
	li   r5, turnhuman
	bl   *r5
L591
	movb @endofgameflag, r1
	jne  L592
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
	jeq  L607
L593
	movb @zv, r3
L597
	cb   r3, r9
	jeq  L594
	seto r1
	movb r1, @np(r4)
	movb r5, r2
	ai   r2, >100
	cb   r2, r14
	jle  L595
	clr  r2
L595
	jeq  0
	cb  r3, @$-1
	jne  L596
	movb r2, r5
	movb r2, r4
	srl  r4, 8
L594
	clr  r3
	mov  r4, r1
	sla  r1, >2
	ai   r1, playerdata
	jeq  0
	cb  @>1(r1), @$-1
	jeq  L597
L596
	movb r2, @turnofplayernr
	movb r3, @zv
	movb @endofgameflag, r1
	jne  JMP_176
	b    @L601
JMP_176
L592
	cb   r1, r9
	jeq  JMP_177
	b    @L599
JMP_177
	bl   @clrscr
	clr  r1
	bl   @bgcolor
	clr  r1
	mov  r1, r2
	li   r3, LC47
	bl   *r15
	clr  r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
L607
	bl   @playerwins
	movb @turnofplayernr, r2
	movb r2, r5
	movb r2, r4
	srl  r4, 8
	jmp  L593
L590
	li   r1, >17
	li   r2, >5
	li   r3, LC46
	li   r4, cputsxy
	bl   *r4
	b    @L591
L588
	li   r2, inputofnames
	bl   *r2
	b    @L589
L606
	bl   @loadmainscreen
	movb @endofgameflag, r1
	b    @L587
L605
	bl   @loadmainscreen
	bl   @loadgame
	b    @L586
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
	.type	C.133.3099, @object
	.size	C.133.3099, 4
C.133.3099
	byte	109
	byte	77
	byte	13
	byte	0
	.type	C.117.2624, @object
	.size	C.117.2624, 5
C.117.2624
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

	ref	memset

	ref	vdpmemcpy

	ref	gImage

	ref	memcpy

	ref	strlen

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
