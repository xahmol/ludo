	pseg
	even

	def	safe_read
safe_read
* Begin inline assembler code
* 69 "speech.h" 1
	MOVB @>9000,@>8320
	NOP
	NOP
	
* 0 "" 2
* End of inline assembler code
	b    *r11
	.size	safe_read, .-safe_read
	even

	def	delay_asm_12
delay_asm_12
* Begin inline assembler code
* 78 "speech.h" 1
	NOP
	NOP
* 0 "" 2
* End of inline assembler code
	b    *r11
	.size	delay_asm_12, .-delay_asm_12
	even

	def	delay_asm_42
delay_asm_42
* Begin inline assembler code
* 85 "speech.h" 1
		LI r12,10
loop21
	DEC r12
	JNE loop21
* 0 "" 2
* End of inline assembler code
	b    *r11
	.size	delay_asm_42, .-delay_asm_42
	even

	def	copy_safe_read
copy_safe_read
	li   r2, safe_read
	li   r1, >8322
L8
	mov  *r2+, *r1+
	ci   r1, >832E
	jne  L8
	b    *r11
	.size	copy_safe_read, .-copy_safe_read
	even

	def	call_safe_read
call_safe_read
	dect r10
	mov  r11, *r10
	bl   @>8322
	movb @>8320, r1
	mov  *r10+, r11
	b    *r11
	.size	call_safe_read, .-call_safe_read
	even

	def	load_speech_addr
load_speech_addr
	mov  r1, r2
	swpb r2
	sra  r2, 8
	andi r2, >F
	ori  r2, >40
	mov  r2, r3
	swpb r3
	li   r2, >9400
	movb r3, *r2
	mov  r1, r3
	sla  r3, >4
	sra  r3, 8
	andi r3, >F
	ori  r3, >40
	swpb r3
	movb r3, *r2
	mov  r1, r3
	sra  r3, 8
	andi r3, >F
	ori  r3, >40
	swpb r3
	movb r3, *r2
	srl  r1, >4
	ori  r1, >4000
	movb r1, *r2
	li   r1, >4000
	movb r1, *r2
* Begin inline assembler code
* 85 "speech.h" 1
		LI r12,10
loop84
	DEC r12
	JNE loop84
* 0 "" 2
* End of inline assembler code
	b    *r11
	.size	load_speech_addr, .-load_speech_addr
	even

	def	say_vocab
say_vocab
	dect r10
	mov  r11, *r10
	bl   @load_speech_addr
	li   r1, >5000
	movb r1, @>9400
* Begin inline assembler code
* 78 "speech.h" 1
	NOP
	NOP
* 0 "" 2
* End of inline assembler code
	mov  *r10+, r11
	b    *r11
	.size	say_vocab, .-say_vocab
	even

	def	say_data
say_data
	ai   r10, >FFF8
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	mov  r14, *r0+
	li   r3, >6000
	movb r3, @>9400
* Begin inline assembler code
* 78 "speech.h" 1
	NOP
	NOP
* 0 "" 2
* End of inline assembler code
	ci   r2, 0
	jlt  L26
	jeq  L26
	mov  r1, r13
	movb *r13+, @>9400
	mov  r2, r9
	dec  r9
	ai   r1, >10
L20
	ci   r9, 0
	jeq  L26
	movb *r13+, @>9400
	dec  r9
	c    r13, r1
	jne  L20
	ci   r9, 0
	jeq  L26
	li   r14, call_safe_read
L31
	bl   *r14
	srl  r1, 8
	andi r1, >40
	ci   r1, 0
	jeq  L31
	ci   r9, 0
	jeq  L26
	movb *r13+, @>9400
	mov  r9, r1
	dec  r1
	mov  r9, r3
	ai   r3, >FFF8
	jmp  L23
L32
	mov  r9, r1
L23
	ci   r1, 0
	jeq  L26
	movb *r13+, @>9400
	mov  r1, r9
	dec  r9
	c    r9, r3
	jne  L32
	ci   r3, 0
	jgt  L31
L26
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	b    *r11
	.size	say_data, .-say_data
	even

	def	speech_reset
speech_reset
	li   r2, safe_read
	li   r1, >8322
L34
	mov  *r2+, *r1+
	ci   r1, >832E
	jne  L34
	li   r1, >7000
	movb r1, @>9400
	b    @>8322
	.size	speech_reset, .-speech_reset
	even

	def	detect_speech
detect_speech
	dect r10
	mov  r11, *r10
	bl   @speech_reset
	clr  r1
	bl   @load_speech_addr
	li   r1, >1000
	movb r1, @>9400
* Begin inline assembler code
* 78 "speech.h" 1
	NOP
	NOP
* 0 "" 2
* End of inline assembler code
	bl   @>8322
	movb @>8320, r3
	clr  r1
	li   r2, >AA00
	cb   r3, r2
	jeq  L40
	mov  *r10+, r11
	b    *r11
	jmp  L41
L40
	li   r1, >1
	mov  *r10+, r11
	b    *r11
L41
	.size	detect_speech, .-detect_speech
	even

	def	speech_wait
speech_wait
	ai   r10, >FFFC
	mov  r11, *r10
	mov  r9, @>2(r10)
* Begin inline assembler code
* 85 "speech.h" 1
		LI r12,10
loop243
	DEC r12
	JNE loop243
* 0 "" 2
* 78 "speech.h" 1
	NOP
	NOP
* 0 "" 2
* End of inline assembler code
	li   r1, >8000
	movb r1, @>8320
	movb @>8320, r1
	jgt  L45
	jeq  L45
	li   r9, >8322
L46
	bl   *r9
	movb @>8320, r1
	jlt  L46
L45
	mov  *r10+, r11
	mov  *r10+, r9
	b    *r11
	.size	speech_wait, .-speech_wait
	even

	def	strchr
strchr
L51
	movb *r1, r3
	movb r3, r4
	srl  r4, 8
	c    r4, r2
	jeq  L49
	jeq  0
	cb  r3, @$-1
	jeq  L50
	inc  r1
	jmp  L51
L50
	clr  r1
L49
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
	jeq  L57
	srl  r3, 8
	movb @>1(r4), r2
	srl  r2, 8
	sla  r1, >3
	a    r2, r1
	a    r1, r1
	a    r3, r1
	movb @homedestcoords(r1), r1
	b    *r11
	jmp  L58
L57
	srl  r3, 8
	movb @>1(r4), r1
	srl  r1, 8
	a    r1, r1
	a    r3, r1
	movb @fieldcoords(r1), r1
	b    *r11
L58
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
	jmp  L99
L110
	li   r1, >D8F0
	mov  r1, *r14
L61
	mov  @>12(r10), r2
	inc  r2
	mov  r2, @>12(r10)
	inct r14
	mov  @>1A(r10), r1
	inct r1
	mov  r1, @>1A(r10)
	ai   r2, >FFFC
	jne  JMP_0
	b    @L78
JMP_0
L99
	mov  @>20(r10), r1
	mov  @>12(r10), r2
	a    r2, r1
	jeq  0
	cb  *r1, @$-1
	jeq  L110
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
	b    @L62
JMP_1
	jeq  0
	cb  r15, @$-1
	jeq  JMP_2
	b    @L63
JMP_2
	li   r1, >2700
	cb   r2, r1
	jle  L69
	movb @>1E(r10), r2
	cb   r2, r1
	jh  JMP_3
	b    @L111
JMP_3
L69
	movb @>1D(r10), @>1C(r10)
L72
	li   r2, >2700
	movb @>1C(r10), r1
	cb   r1, r2
	jle  L74
	ai   r1, >D800
	movb r1, @>1C(r10)
L74
	clr  r13
L76
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
L79
	mov  r6, r4
	sla  r4, >3
	ai   r4, playerpos
	mov  @>10(r10), r5
	clr  r3
	mov  r6, r8
	sla  r8, >2
	li   r0, >D00
L90
	cb   r15, r9
	jne  JMP_4
	b    @L112
JMP_4
	movb *r4, r1
	cb   r1, r13
	jne  JMP_5
	b    @L113
JMP_5
L82
	jeq  0
	cb  r1, @$-1
	jne  L83
	jeq  0
	cb  r13, @$-1
	jne  L83
L105
	cb   r15, r9
	jeq  L83
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
	jh  L88
	li   r2, >190
	a    r2, *r14
L88
	mov  @>16(r10), r2
	s    r1, r2
	dec  r2
	ci   r2, >4
	jh  L89
	li   r2, >FF38
	a    r2, *r14
L89
	mov  @>18(r10), r2
	s    r2, r1
	dec  r1
	ci   r1, >4
	jh  L83
	li   r1, >64
	a    r1, *r14
L83
	inc  r3
	inct r4
	inct r5
	ci   r3, >4
	jne  L90
	ai   r9, >100
	inc  r6
	ai   r7, >8
	li   r1, >400
	cb   r9, r1
	jeq  JMP_6
	b    @L79
JMP_6
	jeq  0
	cb  r13, @$-1
	jne  L92
	movb @>1C(r10), r2
	jne  JMP_7
	b    @L93
JMP_7
	li   r2, >A00
	movb @>1C(r10), r1
	cb   r1, r2
	jne  JMP_8
	b    @L93
JMP_8
	li   r2, >1400
	cb   r1, r2
	jne  JMP_9
	b    @L93
JMP_9
	li   r2, >1E00
	cb   r1, r2
	jne  JMP_10
	b    @L93
JMP_10
L92
	movb @>1F(r10), r1
	jne  L94
	movb @>1E(r10), r2
	jeq  L95
	li   r2, >A00
	movb @>1E(r10), r1
	cb   r1, r2
	jeq  L95
	li   r2, >1400
	cb   r1, r2
	jeq  L95
	li   r2, >1E00
	cb   r1, r2
	jeq  L95
L94
	jeq  0
	cb  r15, @$-1
	jne  L96
L116
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
	b    @L99
JMP_11
L78
	mov  @>20(r10), r5
	clr  r1
	movb r1, r3
	li   r4, >B1E0
	li   r7, >100
	li   r6, >400
	mov  @>26(r10), r8
L103
	mov  *r8, r2
	c    r2, r4
	jlt  L100
	jeq  L100
	cb   *r5, r7
	jne  JMP_12
	b    @L114
JMP_12
L100
	mov  r4, r2
	ai   r3, >100
	inct r8
	inc  r5
	cb   r3, r6
	jne  JMP_13
	b    @L115
JMP_13
L102
	mov  r2, r4
	jmp  L103
L95
	li   r2, >7D0
	a    r2, *r14
	jeq  0
	cb  r15, @$-1
	jeq  L116
L96
	li   r1, >100
	cb   r15, r1
	jeq  JMP_14
	b    @L97
JMP_14
	mov  *r14, r2
	ai   r2, >FFF6
	movb @>1D(r10), r1
	srl  r1, 8
	a    r1, r2
	mov  r2, *r14
	b    @L61
L93
	li   r2, >F060
	a    r2, *r14
	b    @L92
L112
	cb   @>FFFF(r5), r13
	jeq  L117
L81
	mov  r3, r1
	a    r3, r1
	a    r7, r1
	movb *r1, r1
	b    @L82
L117
	cb   *r5, r12
	jne  L81
	li   r1, >E0C0
	a    r1, *r14
	mov  r3, r1
	a    r3, r1
	a    r7, r1
	movb *r1, r1
	b    @L82
L113
	cb   @>1(r4), r12
	jeq  JMP_15
	b    @L82
JMP_15
	mov  *r14, r2
	ai   r2, >FA0
	mov  r2, *r14
	jeq  0
	cb  r13, @$-1
	jeq  JMP_16
	b    @L83
JMP_16
	jeq  0
	cb  r9, @$-1
	jne  L84
	ci   r12, >21FF
	jh  JMP_17
	b    @L105
JMP_17
	ai   r2, >BB8
	mov  r2, *r14
	b    @L105
L84
	li   r1, >100
	cb   r9, r1
	jeq  JMP_18
	b    @L86
JMP_18
	ci   r12, >3FF
	jh  JMP_19
	b    @L105
JMP_19
	ai   r2, >BB8
	mov  r2, *r14
	b    @L105
L62
	movb @>1D(r10), @>1C(r10)
	movb @>1F(r10), r13
L71
	li   r2, >100
	cb   r13, r2
	jeq  JMP_20
	b    @L76
JMP_20
L73
	li   r2, >300
	movb @>1C(r10), r1
	cb   r1, r2
	jle  L108
	li   r1, >100
	mov  @>24(r10), r2
	cb   *r2, r1
	jne  JMP_21
	b    @L118
JMP_21
	li   r1, >1770
	a    r1, *r14
L108
	li   r13, >100
	b    @L76
L63
	li   r2, >100
	cb   r15, r2
	jne  L66
	li   r2, >900
	movb @>1D(r10), r1
	cb   r1, r2
	jle  L70
	movb @>1E(r10), r1
	cb   r1, r2
	jh  L70
	movb @>1D(r10), r2
	ai   r2, >FA00
	movb r2, @>1C(r10)
	jmp  L73
L70
	movb @>1D(r10), @>1C(r10)
	b    @L72
L86
	li   r1, >200
	cb   r9, r1
	jeq  JMP_22
	b    @L87
JMP_22
	cb   r12, r0
	jh  JMP_23
	b    @L105
JMP_23
	ai   r2, >BB8
	mov  r2, *r14
	b    @L105
L97
	li   r2, >200
	cb   r15, r2
	jne  L98
	mov  *r14, r2
	ai   r2, >FFEC
	movb @>1D(r10), r1
	srl  r1, 8
	a    r1, r2
	mov  r2, *r14
	b    @L61
L114
	movb r3, r1
	ai   r3, >100
	inct r8
	inc  r5
	cb   r3, r6
	jeq  JMP_24
	b    @L102
JMP_24
L115
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >22
	b    *r11
L66
	li   r2, >200
	cb   r15, r2
	jeq  JMP_25
	b    @L68
JMP_25
	li   r2, >1300
	movb @>1D(r10), r1
	cb   r1, r2
	jh  JMP_26
	b    @L69
JMP_26
	movb @>1E(r10), r1
	cb   r1, r2
	jle  JMP_27
	b    @L69
JMP_27
	movb @>1D(r10), r2
	ai   r2, >F000
	movb r2, @>1C(r10)
	b    @L73
L111
	movb @>1D(r10), r1
	ai   r1, >DC00
	movb r1, @>1C(r10)
	b    @L73
L118
	mov  @>12(r10), r1
	a    r1, r1
	li   r2, >8
	a    r10, r2
	a    r2, r1
	li   r2, >2710
	mov  r2, *r1
	b    @L78
L98
	li   r2, >300
	cb   r15, r2
	jeq  JMP_28
	b    @L61
JMP_28
	mov  *r14, r2
	ai   r2, >FFE2
	movb @>1D(r10), r1
	srl  r1, 8
	a    r1, r2
	mov  r2, *r14
	b    @L61
L87
	li   r2, >300
	cb   r9, r2
	jeq  JMP_29
	b    @L105
JMP_29
	ci   r12, >17FF
	jh  JMP_30
	b    @L105
JMP_30
	li   r2, >BB8
	a    r2, *r14
	b    @L105
L68
	li   r2, >300
	cb   r15, r2
	jeq  JMP_31
	b    @L70
JMP_31
	li   r2, >1D00
	movb @>1D(r10), r1
	cb   r1, r2
	jh  JMP_32
	b    @L70
JMP_32
	movb @>1E(r10), r1
	cb   r1, r2
	jle  JMP_33
	b    @L70
JMP_33
	movb @>1D(r10), r2
	ai   r2, >E600
	movb r2, @>1C(r10)
	li   r13, >100
	b    @L71
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
	jeq  L122
	clr  r9
	li   r13, cprintf
L121
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
	jh  L121
L122
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
	jne  L125
	movb @>1(r4), r2
	srl  r2, 8
	a    r2, r2
	ai   r2, fieldcoords
	movb *r2+, r4
	movb *r2, r2
	jeq  0
	cb  r3, @$-1
	jne  L136
L127
	li   r3, >100
	cb   r1, r3
	jne  JMP_34
	b    @L130
JMP_34
	cb   r1, r3
	jhe  L137
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
L125
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
	jeq  L127
L136
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
L137
	li   r3, >200
	cb   r1, r3
	jeq  L131
	li   r3, >300
	cb   r1, r3
	jeq  L138
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
L131
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
L130
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
L138
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
	jne  L140
	movb @>1(r3), r3
	movb r3, r2
	srl  r2, 8
	a    r2, r2
	ai   r2, fieldcoords
	movb *r2+, r1
	movb *r2, r2
	jeq  0
	cb  r3, @$-1
	jne  L155
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
L154
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @cputcxy
L140
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
	b    @L145
JMP_35
	cb   r1, r3
	jl  L144
	li   r3, >200
	cb   r1, r3
	jne  JMP_36
	b    @L146
JMP_36
	li   r3, >300
	cb   r1, r3
	jne  JMP_37
	b    @L156
JMP_37
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
L155
	li   r4, >A00
	cb   r3, r4
	jne  JMP_38
	b    @L148
JMP_38
	li   r4, >1400
	cb   r3, r4
	jne  JMP_39
	b    @L149
JMP_39
	li   r4, >1E00
	cb   r3, r4
	jne  JMP_40
	b    @L157
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
L144
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
	b    @L154
L145
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
	b    @L154
L148
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
	b    @L154
L156
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
	b    @L154
L146
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
	b    @L154
L149
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
	b    @L154
L157
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
	b    @L154
	.size	pawnerase, .-pawnerase
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
	b    @L162
JMP_41
	clr  r1
	mov  r1, @>A(r10)
	jmp  L161
L160
	mov  @>A(r10), r1
	inc  r1
	mov  r1, @>A(r10)
	mov  @>C(r10), r2
	c    r2, r1
	jh  JMP_42
	b    @L162
JMP_42
L161
* Begin inline assembler code
* 264 "main.c" 1
	clr r12
	tb 2
	jeq -4
	movb @>8802,r12
* 0 "" 2
* End of inline assembler code
	jeq  0
	cb  @musicnumber, @$-1
	jne  JMP_43
	b    @L160
JMP_43
* Begin inline assembler code
* 267 "main.c" 1
	bl @SongLoop
* 0 "" 2
* End of inline assembler code
	mov  @songNote+6, r1
	andi r1, >1
	jeq  JMP_44
	b    @L160
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
	b    @L161
JMP_45
L162
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	.size	wait, .-wait
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
L167
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
	jne  L167
	mov  *r10+, r11
	b    *r11
	.size	gamereset, .-gamereset
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
	jeq  L179
	clr  r9
	li   r14, cputc
L178
	li   r1, >20
	bl   *r14
	ai   r9, >100
	cb   r13, r9
	jh  L178
L179
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
	jeq  L183
	mov  @>A(r10), r15
	clr  r9
L184
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
	jh  L184
L183
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
	b    @L194
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
L187
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
	jh  L187
L186
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
	jeq  L188
	mov  @>A(r10), r14
	clr  r9
L189
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
	jh  L189
L188
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
L194
	mov  @>14(r10), r2
	inc  r2
	mov  r2, @>14(r10)
	jmp  L186
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
	jlt  L199
	mov  r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    @cputs
L199
	s    r4, r2
	neg  r2
	jlt  L200
	sra  r2, >1
	dec  r2
	mov  r2, r1
	swpb r1
	bl   @cspaces
L201
	mov  r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    @cputs
L200
	inc  r2
	sra  r2, >1
	dec  r2
	mov  r2, r1
	swpb r1
	bl   @cspaces
	jmp  L201
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
	jeq  L205
	srl  r1, 8
	mov  r1, @>A(r10)
	clr  r13
	clr  r9
	srl  r2, 8
	mov  r2, @>C(r10)
L204
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
	jh  L204
L205
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
L249
	mov  @seed.1613, r1
* Begin inline assembler code
* 246 "main.c" 1
	srl r1,1  
	jnc 1f    
	xor @random_mask.1614,r1 
	1:        
	
* 0 "" 2
* End of inline assembler code
	mov  r1, @seed.1613
	jeq  0
	cb  @musicnumber, @$-1
	jne  L254
L208
	jeq  0
	cb  @joyinterface, @$-1
	jeq  L209
	movb @>C(r10), r4
	jeq  JMP_47
	b    @L255
JMP_47
L209
	bl   @kbhit
	jeq  0
	cb  r1, @$-1
	jeq  JMP_48
	b    @L234
JMP_48
	clr  r5
	movb r1, r8
L233
	mov  @>A(r10), r2
	jmp  L238
L256
	inc  r2
L238
	movb *r2, r1
	movb r1, r3
	srl  r3, 8
	c    r3, r5
	jne  JMP_49
	b    @L236
JMP_49
	jeq  0
	cb  r1, @$-1
	jne  L256
L237
	li   r2, >D00
	cb   r8, r2
	jeq  JMP_50
	b    @L249
JMP_50
	movb r8, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	b    @L257
L254
	li   r1, vdpwaitvint
	bl   *r1
* Begin inline assembler code
* 381 "main.c" 1
	bl @SongLoop
* 0 "" 2
* End of inline assembler code
	mov  @songNote+6, r1
	andi r1, >1
	jeq  JMP_51
	b    @L208
JMP_51
	li   r1, musicmem
	clr  r2
	bl   @StartSong
	b    @L208
L236
	ci   r2, 0
	jne  JMP_52
	b    @L237
JMP_52
	jeq  0
	cb  r8, @$-1
	jne  JMP_53
	b    @L249
JMP_53
	movb r8, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
	b    @L257
L255
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
	b    @L258
JMP_54
L210
	li   r8, >D00
	li   r5, >400
	cb   r15, r5
	jne  JMP_55
	b    @L259
JMP_55
L212
	li   r1, >400
	cb   r3, r1
	jne  JMP_56
	b    @L260
JMP_56
L214
	li   r4, >FC00
	cb   r15, r4
	jne  JMP_57
	b    @L215
JMP_57
	li   r5, >FC00
	cb   r3, r5
	jne  JMP_58
	b    @L215
JMP_58
L216
	li   r1, >FC00
	cb   r14, r1
	jne  JMP_59
	b    @L261
JMP_59
L217
	li   r4, >FC00
	cb   r2, r4
	jne  JMP_60
	b    @L262
JMP_60
L219
	li   r5, >400
	cb   r14, r5
	jne  JMP_61
	b    @L220
JMP_61
	li   r1, >400
	cb   r2, r1
	jne  JMP_62
	b    @L220
JMP_62
L267
	jeq  0
	cb  r8, @$-1
	jne  JMP_63
	b    @L209
JMP_63
L251
	movb r8, @>D(r10)
L248
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
	b    @L222
JMP_64
L252
	li   r1, >100
	li   r2, >400
	cb   r14, r2
	jne  JMP_65
	b    @L263
JMP_65
L225
	li   r5, >400
	cb   r4, r5
	jne  JMP_66
	b    @L264
JMP_66
L227
	li   r2, >FC00
	cb   r14, r2
	jne  JMP_67
	b    @L228
JMP_67
	li   r5, >FC00
	cb   r4, r5
	jne  JMP_68
	b    @L228
JMP_68
L229
	li   r2, >FC00
	cb   r15, r2
	jne  JMP_69
	b    @L265
JMP_69
L230
	li   r4, >FC00
	cb   r3, r4
	jne  JMP_70
	b    @L266
JMP_70
L232
	li   r5, >400
	cb   r15, r5
	jeq  L248
L231
	li   r2, >400
	cb   r3, r2
	jne  JMP_71
	b    @L248
JMP_71
	li   r4, >100
	cb   r1, r4
	jne  JMP_72
	b    @L248
JMP_72
	movb @>D(r10), r8
	movb r8, r5
	srl  r5, 8
	b    @L233
L258
	cb   r1, r4
	jeq  JMP_73
	b    @L210
JMP_73
	clr  r8
	li   r5, >400
	cb   r15, r5
	jeq  JMP_74
	b    @L212
JMP_74
L259
	li   r8, >900
	li   r5, >FC00
	cb   r3, r5
	jeq  JMP_75
	b    @L216
JMP_75
L215
	li   r8, >800
	li   r1, >FC00
	cb   r14, r1
	jeq  JMP_76
	b    @L217
JMP_76
L261
	li   r8, >A00
	li   r1, >400
	cb   r2, r1
	jeq  JMP_77
	b    @L267
JMP_77
L220
	li   r8, >B00
	b    @L251
L222
	clr  r1
	seto r5
	cb   r2, r5
	jeq  JMP_78
	b    @L252
JMP_78
	li   r2, >400
	cb   r14, r2
	jeq  JMP_79
	b    @L225
JMP_79
L263
	li   r1, >100
	li   r5, >FC00
	cb   r4, r5
	jeq  JMP_80
	b    @L229
JMP_80
L228
	li   r1, >100
	li   r2, >FC00
	cb   r15, r2
	jeq  JMP_81
	b    @L230
JMP_81
L265
	li   r1, >100
	b    @L231
L264
	li   r1, >100
	b    @L227
L266
	li   r1, >100
	b    @L232
L234
	bl   @cgetc
	movb r1, r8
	mov  @>A(r10), r5
	jeq  0
	cb  *r5, @$-1
	jne  L235
	li   r5, >D
	li   r8, >D00
	b    @L233
L262
	li   r8, >A00
	b    @L219
L260
	li   r8, >900
	b    @L214
L235
	movb r1, r5
	srl  r5, 8
	b    @L233
L257
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
	li   r2, C.124.2742
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
	jeq  L293
	cb   @>2(r14), r9
	jne  JMP_82
	b    @L295
JMP_82
	cb   @>3(r14), r9
	jne  JMP_83
	b    @L296
JMP_83
	cb   @>4(r14), r9
	jne  JMP_84
	b    @L273
JMP_84
	li   r9, >400
L293
	li   r1, pawnplace
	mov  r1, @>12(r10)
	li   r3, getkey
	mov  r3, @>14(r10)
L292
	li   r4, >300
L291
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
	b    @L274
JMP_85
	li   r3, >A00
	cb   r13, r3
	jeq  L274
L275
	li   r5, >900
	cb   r13, r5
	jeq  L276
	li   r1, >B00
	cb   r13, r1
	jeq  L276
	li   r2, >D00
	cb   r13, r2
	jeq  L278
L298
	cb   r9, r4
	jlt  L279
	jeq  L279
	clr  r9
L280
	movb r9, r2
	sra  r2, 8
L281
	a    r14, r2
	li   r3, >100
	cb   *r2, r3
	jeq  L291
	ab   r15, r9
	cb   r9, r4
	jlt  L282
	jeq  L282
L297
	clr  r9
L283
	movb r9, r1
	sra  r1, 8
L284
	a    r14, r1
	cb   *r1, r3
	jeq  L291
	ab   r15, r9
	cb   r9, r4
	jgt  L297
L282
	jeq  0
	cb  r9, @$-1
	jgt  L283
	jeq  L283
	li   r1, >3
	li   r9, >300
	jmp  L284
L276
	ai   r9, >100
	li   r15, >100
	li   r2, >D00
	cb   r13, r2
	jne  L298
L278
	bl   @windowrestore
	movb r9, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >10
	b    *r11
L274
	ai   r9, >FF00
	seto r15
	jmp  L275
L279
	jeq  0
	cb  r9, @$-1
	jgt  L280
	jeq  L280
	li   r2, >3
	li   r9, >300
	jmp  L281
L295
	li   r9, >200
	li   r5, pawnplace
	mov  r5, @>12(r10)
	li   r1, getkey
	mov  r1, @>14(r10)
	b    @L292
L273
	li   r9, >400
	li   r5, pawnplace
	mov  r5, @>12(r10)
	li   r1, getkey
	mov  r1, @>14(r10)
	b    @L292
L296
	li   r9, >300
	li   r3, pawnplace
	mov  r3, @>12(r10)
	li   r5, getkey
	mov  r5, @>14(r10)
	b    @L292
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
	li   r7, >3430
	movb r7, @>10(r10)
	swpb r7
	movb r7, @>11(r10)
	li   r6, >312D
	movb r6, @>12(r10)
	swpb r6
	movb r6, @>13(r10)
	li   r5, >3039
	movb r5, @>14(r10)
	swpb r5
	movb r5, @>15(r10)
	li   r4, >3238
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
	b    @L303
L302
	mov  @seed.1613, r1
* Begin inline assembler code
* 246 "main.c" 1
	srl r1,1  
	jnc 1f    
	xor @random_mask.1614,r1 
	1:        
	
* 0 "" 2
* End of inline assembler code
	mov  r1, @seed.1613
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
	b    @L306
JMP_86
L303
	jeq  0
	cb  @musicnumber, @$-1
	jne  JMP_87
	b    @L302
JMP_87
	li   r2, vdpwaitvint
	bl   *r2
* Begin inline assembler code
* 881 "main.c" 1
	bl @SongLoop
* 0 "" 2
* End of inline assembler code
	mov  @songNote+6, r1
	andi r1, >1
	jeq  JMP_88
	b    @L302
JMP_88
	li   r1, musicmem
	clr  r2
	li   r3, StartSong
	bl   *r3
	b    @L302
L306
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
	jle  JMP_89
	b    @L310
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
L315
	mov  @>14(r10), r1
	movb *r1, r4
	jne  JMP_90
	b    @L337
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
L316
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
	jh  L316
L312
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
	jmp  L317
L318
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
L317
	mov  r14, r1
	bl   *r15
	inc  r1
	movb r9, r4
	srl  r4, 8
	c    r1, r4
	jgt  L318
	jeq  L318
	mov  r10, r1
	ai   r1, >A
	li   r2, updownenter
	bl   @strcpy
	movb @>20(r10), r2
	cb   r2, @menubaroptions
	jh  JMP_91
	b    @L338
JMP_91
L319
	li   r13, >100
	li   r15, >1
L332
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
	jh  L332
	srl  r2, 8
	a    r2, r2
	mov  @L324(r2), r3
	b    *r3
	even
L324
		data		L321
		data		L321
		data		L322
		data		L322
		data		L332
		data		L323
L321
	movb r1, r13
	ai   r13, >A00
L323
	bl   @windowrestore
	movb r13, r1
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >1A
	b    *r11
L322
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
	jeq  L339
	ai   r13, >100
	mov  @>14(r10), r2
	cb   r13, *r2
	jh  L319
L336
	movb r13, r15
	srl  r15, 8
	jmp  L332
L339
	ai   r13, >FF00
	jne  L336
	mov  @>14(r10), r1
	movb *r1, r13
	movb r13, r15
	srl  r15, 8
	jmp  L332
L338
	mov  r10, r1
	ai   r1, >A
	li   r2, leftright
	bl   @strcat
	b    @L319
L310
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
	jmp  L313
L314
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
L313
	mov  r15, r1
	bl   *r14
	inc  r1
	movb r13, r3
	srl  r3, 8
	c    r1, r3
	jgt  L314
	jeq  L314
	mov  @>12(r10), r9
	b    @L315
L337
	mov  @>1C(r10), r2
	inc  r2
	mov  r2, @>12(r10)
	b    @L312
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
L344
	li   r1, >A00
	movb r1, r2
	li   r3, >700
	bl   *r13
	cb   r1, r9
	jeq  L347
	cb   r1, r14
	jeq  L348
	cb   r1, r15
	jne  L342
	jeq  0
	cb  @playerdata+1, @$-1
	jne  L342
	jeq  0
	cb  @playerdata+5, @$-1
	jne  L342
	jeq  0
	cb  @playerdata+9, @$-1
	jne  L342
	jeq  0
	cb  @playerdata+13, @$-1
	jeq  L344
L342
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @windowrestore
L348
	li   r1, >100
	movb r1, @endofgameflag
	movb r1, @zv
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @windowrestore
L347
	li   r1, >300
	movb r1, @endofgameflag
	bl   @gamereset
	li   r1, >100
	movb r1, @zv
	jmp  L342
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
	li   r2, C.59.2134
	li   r3, >4
	bl   @memcpy
	li   r1, >100
	movb r1, @>E(r10)
	li   r2, >1
	mov  r2, @>12(r10)
L367
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
	jmp  L352
L353
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
L352
	mov  r14, r1
	li   r4, strlen
	bl   *r4
	movb r9, r4
	srl  r4, 8
	c    r4, r1
	jlt  L353
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
	b    @L371
JMP_92
	li   r1, >900
	cb   r9, r1
	jne  JMP_93
	b    @L372
JMP_93
	li   r4, >D00
	cb   r9, r4
	jne  L367
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
	jlt  L358
	jeq  L358
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
L358
	movb r9, r1
	clr  r2
	movb @>E(r10), r3
	li   r4, menupulldown
	bl   *r4
	li   r2, >1200
	cb   r1, r2
	jne  JMP_94
	b    @L373
JMP_94
	li   r3, >1300
	cb   r1, r3
	jeq  L374
	jeq  0
	cb  r1, @$-1
	jne  JMP_95
	b    @L367
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
L371
	movb @>E(r10), r1
	ai   r1, >FF00
	movb r1, @>E(r10)
	jne  L370
	movb @menubaroptions, r3
	movb r3, @>E(r10)
	movb r3, r4
	srl  r4, 8
	mov  r4, @>12(r10)
	b    @L367
L372
	movb @>E(r10), r2
	ai   r2, >100
	movb r2, @>E(r10)
	cb   r2, @menubaroptions
	jh  L357
	movb r2, r3
	srl  r3, 8
	mov  r3, @>12(r10)
	b    @L367
L369
	movb @menubaroptions, r1
	movb r1, @>E(r10)
L370
	movb r1, r2
	srl  r2, 8
	mov  r2, @>12(r10)
	b    @L367
L357
	li   r2, >100
	movb r2, @>E(r10)
	li   r3, >1
	mov  r3, @>12(r10)
	b    @L367
L374
	movb @>E(r10), r4
	ai   r4, >100
	movb r4, @>E(r10)
	cb   r4, @menubaroptions
	jh  L361
	movb r4, r1
	srl  r1, 8
	mov  r1, @>12(r10)
	b    @L367
L373
	movb @>E(r10), r3
	ai   r3, >FF00
	movb r3, @>E(r10)
	jeq  L369
	movb r3, r4
	srl  r4, 8
	mov  r4, @>12(r10)
	b    @L367
L361
	li   r4, >100
	movb r4, @>E(r10)
	li   r1, >1
	mov  r1, @>12(r10)
	b    @L367
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
L376
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
	jlt  L376
	jeq  L376
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
	jle  L403
L378
	movb @>58(r10), r3
	cb   r9, r3
	jhe  JMP_96
	b    @L404
JMP_96
L385
	movb r9, r13
L388
	movb r13, r9
L405
	mov  r10, r1
	ai   r1, >A
	clr  r2
	li   r4, getkey
	bl   *r4
	movb r1, r4
	ai   r4, >FD00
	ci   r4, >AFF
	jh  L378
L403
	srl  r4, 8
	a    r4, r4
	mov  @L384(r4), r3
	b    *r3
	even
L384
		data		L379
		data		L380
		data		L378
		data		L378
		data		L378
		data		L381
		data		L382
		data		L378
		data		L378
		data		L378
		data		L383
L383
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
L382
	mov  r14, r1
	li   r3, strlen
	bl   *r3
	movb r9, r4
	srl  r4, 8
	c    r4, r1
	jgt  L385
	jeq  L385
	movb @>58(r10), r4
	cb   r9, r4
	jhe  L385
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
	b    @L405
L381
	jeq  0
	cb  r9, @$-1
	jne  JMP_97
	b    @L385
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
	b    @L392
JMP_98
	li   r2, >1A
L393
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
	b    @L405
L380
	mov  r14, r1
	li   r4, strlen
	bl   *r4
	mov  r1, r4
	swpb r4
	movb @>58(r10), r1
	cb   r1, r4
	jh  JMP_99
	b    @L385
JMP_99
	jeq  0
	cb  r4, @$-1
	jne  JMP_100
	b    @L385
JMP_100
	cb   r9, r4
	jl  JMP_101
	b    @L385
JMP_101
	ai   r4, >100
	cb   r9, r4
	jh  L389
	movb r4, r5
	srl  r5, 8
	a    r14, r5
	movb *r5, @>1(r5)
	jeq  0
	cb  r4, @$-1
	jne  L400
	jmp  L389
L391
	movb r4, r1
	srl  r1, 8
	a    r14, r1
	movb *r1, @>1(r1)
	jeq  0
	cb  r4, @$-1
	jeq  L389
L400
	ai   r4, >FF00
	cb   r9, r4
	jle  L391
L389
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
	b    @L405
L379
	jeq  0
	cb  r9, @$-1
	jne  JMP_102
	b    @L385
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
	jeq  L386
	movb r13, @>5E(r10)
	mov  r3, r13
L397
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
	jne  L397
	movb @>5E(r10), r13
L386
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
	jeq  L406
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
L407
	movb r13, r9
	b    @L405
L404
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
	b    @L388
JMP_103
	movb r13, r4
	srl  r4, 8
	a    r14, r4
	movb r3, @>1(r4)
	movb r13, r9
	b    @L405
L406
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
	jmp  L407
L392
	movb r5, r2
	srl  r2, 8
	b    @L393
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
L411
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
	jeq  L414
	clr  r4
	movb r4, *r13
L410
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
	jne  L411
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @windowrestore
L414
	movb r2, *r13
	jmp  L410
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
	jne  L420
	mov  *r10, r11
	ai   r10, >10
	b    *r11
	jmp  L421
L420
	bl   @fileerrormessage
	mov  *r10, r11
	ai   r10, >10
	b    *r11
L421
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
	jne  JMP_104
	b    @L452
JMP_104
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
L425
	li   r1, >A00
	movb r1, r2
	li   r3, >800
	bl   *r13
	movb r1, r9
	ai   r9, >FF00
	jeq  L425
	movb r9, r5
	srl  r5, 8
	mov  r5, r13
	ai   r13, saveslots
	li   r4, >100
	cb   *r13, r4
	jne  JMP_105
	b    @L453
JMP_105
L426
	li   r1, >4
	li   r2, >9
	li   r3, LC28
	mov  r5, @>1C(r10)
	bl   *r14
	mov  @>1C(r10), r5
	jeq  0
	cb  *r13, @$-1
	jne  JMP_106
	b    @L428
JMP_106
	mov  r5, r14
	ai   r14, >23
	sla  r14, >4
	ai   r14, pulldownmenutitles
L429
	li   r1, >400
	li   r2, >A00
	mov  r14, r3
	li   r4, >F00
	mov  r5, @>1C(r10)
	bl   @input
	mov  r14, r1
	bl   *r15
	mov  r1, r2
	swpb r2
	li   r1, >E00
	mov  @>1C(r10), r5
	cb   r2, r1
	jle  JMP_107
	b    @L454
JMP_107
	mov  r5, r4
	sla  r4, >4
	mov  r4, r6
	ai   r6, pulldownmenutitles
	li   r1, >F00
L431
	movb r2, r3
	srl  r3, 8
	a    r6, r3
	li   r7, >2000
	movb r7, @>230(r3)
	ai   r2, >100
	cb   r2, r1
	jne  L431
L430
	clr  r1
	movb r1, @pulldownmenutitles+575(r4)
	movb @>18(r10), r1
	srl  r1, 8
	mov  r5, r3
	ai   r3, >23
	sla  r3, >4
	ai   r3, pulldownmenutitles
	mov  r4, r2
	ai   r2, >5
	ai   r2, saveslots
	ai   r4, saveslots+21
L432
	movb *r3+, *r2+
	c    r2, r4
	jne  L432
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
	jmp  L424
L452
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
L424
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
L433
	mov  r3, r2
	sla  r2, >2
	ai   r2, playerdata
	mov  r4, r1
	ai   r1, savegamemem
	mov  r4, r5
	ai   r5, savegamemem+4
L434
	movb *r2+, *r1+
	c    r5, r1
	jne  L434
	inc  r3
	ai   r4, >4
	ci   r3, >4
	jne  L433
	li   r5, >15
	clr  r4
	li   r6, >400
L435
	mov  r4, r1
	sla  r1, >3
	ai   r1, playerpos
	mov  r5, r2
	ai   r2, savegamemem
	clr  r3
L436
	movb *r1, *r2
	movb @>1(r1), @>1(r2)
	ai   r3, >100
	inct r1
	inct r2
	cb   r3, r6
	jne  L436
	inc  r4
	ai   r5, >8
	ci   r4, >4
	jne  L435
	li   r5, >35
	clr  r4
L437
	mov  r4, r2
	sla  r2, >3
	a    r4, r2
	ai   r2, playername
	mov  r5, r1
	ai   r1, savegamemem
	mov  r5, r3
	ai   r3, savegamemem+21
L438
	movb *r2+, *r1+
	c    r1, r3
	jne  L438
	inc  r4
	ai   r5, >15
	ci   r4, >4
	jne  L437
	mov  r10, r1
	ai   r1, >A
	li   r2, savegamemem
	li   r3, >88
	bl   @dsr_save
	jeq  0
	cb  r1, @$-1
	jne  L455
L441
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >16
	b    *r11
L455
	bl   @fileerrormessage
	jmp  L441
L453
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
	jne  JMP_108
	b    @L426
JMP_108
	bl   @windowrestore
	jmp  L441
L428
	mov  r5, r14
	ai   r14, >23
	sla  r14, >4
	ai   r14, pulldownmenutitles
	mov  r14, r1
	clr  r2
	li   r3, >F
	mov  r5, @>1C(r10)
	bl   @memset
	mov  @>1C(r10), r5
	b    @L429
L454
	mov  r5, r4
	sla  r4, >4
	b    @L430
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
	jne  JMP_109
	b    @L535
JMP_109
L457
	li   r13, >100
	li   r1, cputsxy
	mov  r1, @>E(r10)
L462
	clr  r9
	li   r15, dicethrow
	li   r14, >600
L464
	bl   *r15
	movb r1, @throw
	cb   r1, r14
	jeq  L463
	ai   r9, >100
	cb   r13, r9
	jh  L464
L463
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
	jne  JMP_110
	b    @L536
JMP_110
L465
	clr  r14
L467
	mov  r3, r12
	ai   r12, np
	movb *r12, r15
	jgt  JMP_111
	jeq  JMP_111
	b    @L537
JMP_111
	jeq  0
	cb  r4, @$-1
	jne  JMP_112
	b    @L538
JMP_112
L470
	seto r2
	movb r2, *r12
L469
	jeq  0
	cb  r14, @$-1
	jeq  JMP_113
	b    @L471
JMP_113
	seto r4
	cb   r15, r4
	jne  JMP_114
	b    @L539
JMP_114
L472
	li   r9, >100
L496
	li   r3, >600
	cb   @throw, r3
	jne  JMP_115
	b    @L540
JMP_115
L498
	jeq  0
	cb  r9, @$-1
	jne  JMP_116
	b    @L499
JMP_116
	li   r13, >100
	cb   r14, r13
	jne  JMP_117
	b    @L499
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
	b    @L541
JMP_118
L502
	movb r5, r3
	ab   @throw, r3
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	movb r3, @playerpos+1(r4)
L503
	jeq  0
	cb  r9, @$-1
	jeq  JMP_119
	b    @L504
JMP_119
	li   r4, >2700
	cb   r3, r4
	jle  JMP_120
	b    @L542
JMP_120
L509
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	movb @>1(r3), r3
L511
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	movb @playerpos(r4), r7
	li   r4, >100
	cb   r7, r4
	jne  JMP_121
	b    @L543
JMP_121
L512
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
	b    @L544
JMP_122
L513
	ci   r3, >27FF
	jle  L514
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	ai   r3, >D800
	movb r3, @playerpos+1(r4)
L514
	clr  r0
	a    r6, r8
	a    r8, r8
	ai   r8, playerpos
	mov  r8, r13
	inc  r13
	li   r12, >400
L515
	clr  r2
	clr  r5
	movb r0, r3
	srl  r3, >6
	andi r3, >FFFC
	jmp  L519
L516
	mov  r3, r1
	a    r2, r1
	a    r1, r1
	ai   r1, playerpos
	jeq  0
	cb  *r1, @$-1
	jne  L517
	jeq  0
	cb  *r8, @$-1
	jne  L517
	cb   @>1(r1), *r13
	jeq  L518
L517
	ai   r5, >100
	inc  r2
	cb   r5, r12
	jeq  L545
L519
	c    r6, r2
	jne  L516
	cb   r0, r9
	jne  L516
	ai   r5, >100
	inc  r2
	cb   r5, r12
	jne  L519
L545
	ai   r0, >100
	ci   r0, >3FF
	jle  L515
	seto r0
	clr  r5
L518
	seto r3
	cb   r0, r3
	jeq  JMP_123
	b    @L531
JMP_123
	li   r13, pawnplace
L521
	movb r9, r1
	movb r15, r2
	clr  r3
	bl   *r13
	movb @turnofplayernr, r1
	srl  r1, >6
	andi r1, >FFFC
	jeq  0
	cb  @playerdata(r1), @$-1
	jne  L522
	li   r1, >100
	cb   @autosavetoggle, r1
	jne  JMP_124
	b    @L546
JMP_124
L522
	li   r1, >17
	li   r2, >7
	jmp  L532
L499
	li   r1, >17
	li   r2, >7
	li   r3, LC31
	mov  @>E(r10), r4
	bl   *r4
	li   r1, >17
	li   r2, >8
L532
	li   r3, LC13
	mov  @>E(r10), r4
	bl   *r4
	li   r1, LC12
	li   r2, >100
	bl   @getkey
L523
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >10
	b    *r11
L539
	movb @throw, r13
	movb r14, r2
	li   r0, >100
	sla  r3, >3
	ai   r3, playerpos
	mov  r3, @>10(r10)
	li   r9, >400
	movb r14, @>12(r10)
	mov  r12, r14
L490
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
	b    @L547
JMP_125
	movb r5, r7
	ab   r13, r7
	jeq  0
	cb  r4, @$-1
	jne  L477
	jeq  0
	cb  r1, @$-1
	jeq  JMP_126
	b    @L478
JMP_126
	li   r4, >2700
	cb   r7, r4
	jle  L484
	cb   r5, r4
	jh  JMP_127
	b    @L548
JMP_127
L484
	clr  r4
L480
	cb   r4, r0
	jne  JMP_128
	b    @L485
JMP_128
L477
	li   r3, >A
	a    r10, r3
	a    r12, r3
	li   r4, >100
	movb r4, *r3
	ab   r4, r2
L476
	cb   r2, r9
	jne  L490
	movb @>12(r10), r14
L471
	seto r3
	cb   r15, r3
	jeq  JMP_129
	b    @L472
JMP_129
	li   r9, >100
	cb   @>A(r10), r9
	jne  JMP_130
	b    @L491
JMP_130
	clr  r9
L492
	li   r3, >100
	cb   @>B(r10), r3
	jne  JMP_131
	b    @L549
JMP_131
L493
	li   r3, >100
	cb   @>C(r10), r3
	jne  JMP_132
	b    @L550
JMP_132
L494
	li   r3, >100
	cb   @>D(r10), r3
	jne  JMP_133
	b    @L551
JMP_133
L495
	ci   r9, >1FF
	jh  JMP_134
	b    @L496
JMP_134
	jeq  0
	cb  @playerdata(r8), @$-1
	jeq  JMP_135
	b    @L497
JMP_135
	mov  r10, r2
	ai   r2, >A
	bl   @humanchoosepawn
	movb r1, r15
	li   r3, >600
	cb   @throw, r3
	jeq  JMP_136
	b    @L498
JMP_136
L540
	li   r1, >100
	movb r1, @zv
	b    @L498
L538
	seto r15
	b    @L470
L536
	li   r2, >300
	cb   r13, r2
	jeq  JMP_137
	b    @L465
JMP_137
	clr  r14
	li   r2, >600
	cb   @throw, r2
	jne  JMP_138
	b    @L467
JMP_138
	li   r14, >100
	b    @L467
L535
	mov  r1, r2
	sla  r2, >3
	jeq  0
	cb  @playerpos(r2), @$-1
	jne  JMP_139
	b    @L552
JMP_139
	li   r13, >300
L459
	inc  r3
	a    r3, r3
	jeq  0
	cb  @playerpos(r3), @$-1
	jne  L460
	li   r13, >100
L460
	a    r1, r1
	inc  r1
	sla  r1, >2
	jeq  0
	cb  @playerpos(r1), @$-1
	jne  L461
	li   r13, >100
L461
	ai   r2, playerpos
	jeq  0
	cb  @>6(r2), @$-1
	jne  JMP_140
	b    @L457
JMP_140
	li   r1, >300
	cb   r13, r1
	jne  JMP_141
	b    @L530
JMP_141
	li   r2, cputsxy
	mov  r2, @>E(r10)
	b    @L462
L497
	mov  r10, r2
	ai   r2, >A
	bl   @computerchoosepawn
	movb r1, r15
	b    @L496
L537
	seto r15
	b    @L469
L531
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
	b    @L521
L504
	li   r0, >100
	cb   r9, r0
	jne  L506
	li   r4, >900
	cb   r3, r4
	jh  JMP_142
	b    @L509
JMP_142
	cb   r5, r4
	jle  JMP_143
	b    @L509
JMP_143
	jeq  0
	cb  r7, @$-1
	jeq  JMP_144
	b    @L509
JMP_144
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	movb r9, *r3+
	li   r2, >FA00
	ab   r2, *r3
	b    @L509
L552
	li   r13, >100
	b    @L459
L542
	cb   r5, r4
	jle  JMP_145
	b    @L509
JMP_145
	jeq  0
	cb  r7, @$-1
	jeq  JMP_146
	b    @L509
JMP_146
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	li   r4, >100
	movb r4, *r3+
	li   r1, >DC00
	ab   r1, *r3
	b    @L509
L506
	li   r4, >200
	cb   r9, r4
	jeq  JMP_147
	b    @L508
JMP_147
	li   r4, >1300
	cb   r3, r4
	jh  JMP_148
	b    @L509
JMP_148
	cb   r5, r4
	jle  JMP_149
	b    @L509
JMP_149
	jeq  0
	cb  r7, @$-1
	jeq  JMP_150
	b    @L509
JMP_150
	mov  r8, r3
	a    r6, r3
	a    r3, r3
	ai   r3, playerpos
	movb r0, *r3+
	li   r4, >F000
	ab   r4, *r3
	b    @L509
L547
	ci   r5, >3FF
	jh  L474
	li   r3, >600
	cb   r13, r3
	jeq  L553
L488
	ai   r2, >100
	b    @L476
L553
	movb r2, r15
	movb r2, *r14
	li   r2, >400
	b    @L476
L474
	movb r5, r7
	ab   r13, r7
L485
	ci   r7, >7FF
	jh  L488
	mov  @>10(r10), r6
	clr  r5
	jmp  L489
L487
	ai   r5, >100
	inct r6
	cb   r5, r9
	jne  JMP_151
	b    @L477
JMP_151
L489
	cb   r5, r2
	jeq  L487
	cb   *r6, r0
	jne  L487
	movb @>1(r6), r3
	cb   r3, r7
	jh  L487
	ci   r3, >3FF
	jle  L487
	ai   r2, >100
	b    @L476
L478
	cb   r1, r0
	jne  L481
	li   r4, >900
	cb   r7, r4
	jh  JMP_152
	b    @L484
JMP_152
	cb   r5, r4
	jle  JMP_153
	b    @L484
JMP_153
	ai   r7, >FA00
	movb r1, r4
	b    @L480
L543
	ci   r3, >3FF
	jh  JMP_154
	b    @L512
JMP_154
	movb r3, @dp(r12)
	b    @L512
L544
	li   r5, >100
	cb   r7, r5
	jeq  JMP_155
	b    @L513
JMP_155
	ai   r12, >FF00
	movb r12, *r4
	b    @L513
L541
	ci   r5, >3FF
	jle  JMP_156
	b    @L502
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
	b    @L503
L481
	li   r4, >200
	cb   r1, r4
	jeq  JMP_157
	b    @L483
JMP_157
	li   r4, >1300
	cb   r7, r4
	jh  JMP_158
	b    @L484
JMP_158
	cb   r5, r4
	jle  JMP_159
	b    @L484
JMP_159
	ai   r7, >F000
	li   r4, >100
	b    @L480
L551
	ab   r3, r9
	li   r15, >300
	b    @L495
L550
	ab   r3, r9
	li   r15, >200
	b    @L494
L549
	ab   r3, r9
	movb r3, r15
	b    @L493
L491
	clr  r15
	b    @L492
L548
	ai   r7, >DC00
	li   r4, >100
	b    @L480
L546
	bl   @savegame
	b    @L523
L530
	li   r3, cputsxy
	mov  r3, @>E(r10)
	li   r1, >17
	li   r2, >7
	li   r3, LC29
	li   r4, cputsxy
	bl   *r4
	b    @L462
L508
	li   r4, >300
	cb   r9, r4
	jeq  JMP_160
	b    @L509
JMP_160
	li   r4, >1D00
	cb   r3, r4
	jh  JMP_161
	b    @L511
JMP_161
	cb   r5, r4
	jle  JMP_162
	b    @L511
JMP_162
	jeq  0
	cb  r7, @$-1
	jeq  JMP_163
	b    @L511
JMP_163
	mov  r8, r4
	a    r6, r4
	a    r4, r4
	ai   r4, playerpos
	movb r0, *r4+
	movb *r4, r3
	ai   r3, >E600
	movb r3, *r4
	b    @L511
L483
	li   r4, >300
	cb   r1, r4
	jeq  JMP_164
	b    @L477
JMP_164
	li   r4, >1D00
	cb   r7, r4
	jh  JMP_165
	b    @L477
JMP_165
	cb   r5, r4
	jle  JMP_166
	b    @L477
JMP_166
	ai   r7, >E600
	b    @L485
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
	jne  L555
	li   r1, >1A00
	mov  r14, r2
	mov  r13, r3
	bl   @vdpmemread
L555
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
	jh  L558
	ai   r2, >3000
L559
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
	jeq  L560
	bl   @fileerrormessage
L560
	li   r1, musicmem
	clr  r2
	bl   @StartSong
	mov  *r10+, r11
	mov  *r10, r9
	ai   r10, >10
	b    *r11
L558
	li   r2, >100
	movb r2, @musicnumber
	li   r2, >3100
	jmp  L559
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
	jeq  L579
	bl   @windowrestore
	li   r2, >100
	cb   *r9, r2
	jeq  L580
L573
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >14
	b    *r11
	b    @L581
L579
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
	jne  L573
L580
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
	b    @L582
JMP_167
	movb @savegamemem, @turnofplayernr
	movb @savegamemem+1, @np
	movb @savegamemem+2, @np+1
	movb @savegamemem+3, @np+2
	movb @savegamemem+4, @np+3
	li   r4, >5
	clr  r3
L566
	mov  r4, r1
	ai   r1, savegamemem
	mov  r3, r2
	sla  r2, >2
	ai   r2, playerdata
	mov  r4, r5
	ai   r5, savegamemem+4
L567
	movb *r1+, *r2+
	c    r5, r1
	jne  L567
	inc  r3
	ai   r4, >4
	ci   r3, >4
	jne  L566
	li   r1, >15
	mov  r1, @>18(r10)
	clr  r3
	mov  r3, @>1A(r10)
	clr  r15
L568
	mov  @>18(r10), r14
	ai   r14, savegamemem
	mov  @>1A(r10), r13
	sla  r13, >3
	ai   r13, playerpos
	clr  r9
L569
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
	jne  L569
	ai   r15, >100
	mov  @>1A(r10), r3
	inc  r3
	mov  r3, @>1A(r10)
	mov  @>18(r10), r4
	ai   r4, >8
	mov  r4, @>18(r10)
	cb   r15, r9
	jne  L568
	li   r5, >35
	clr  r4
L570
	mov  r5, r1
	ai   r1, savegamemem
	mov  r4, r2
	sla  r2, >3
	a    r4, r2
	ai   r2, playername
	mov  r5, r3
	ai   r3, savegamemem+21
L571
	movb *r1+, *r2+
	c    r1, r3
	jne  L571
	inc  r4
	ai   r5, >15
	ci   r4, >4
	jne  L570
	li   r1, >200
	movb r1, @endofgameflag
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >14
	b    *r11
	jmp  L581
L582
	bl   @fileerrormessage
	b    @L573
L581
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
	jmp  L600
L584
	movb r9, r1
	ai   r1, >F500
	ci   r1, >2FF
	jle  L601
L596
	li   r1, >1600
	cb   r9, r1
	jeq  L601
L600
	bl   *r14
	movb r1, r9
	ai   r1, >F400
	cb   r1, r13
	jh  L584
	srl  r1, 8
	a    r1, r1
	mov  @L594(r1), r2
	b    *r2
	even
L594
		data		L585
		data		L586
		data		L584
		data		L584
		data		L584
		data		L584
		data		L584
		data		L584
		data		L584
		data		L587
		data		L588
		data		L589
		data		L584
		data		L584
		data		L584
		data		L584
		data		L584
		data		L584
		data		L584
		data		L590
		data		L591
		data		L592
		data		L584
		data		L584
		data		L584
		data		L584
		data		L584
		data		L584
		data		L584
		data		L593
L593
	li   r1, informationcredits
	bl   *r1
	li   r1, >1600
	cb   r9, r1
	jne  L600
L601
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	b    @L603
L592
	jeq  0
	cb  @musicnumber, @$-1
	jeq  JMP_168
	b    @L604
JMP_168
	li   r3, >100
	movb r3, @musicnumber
	li   r1, musicmem
	clr  r2
	li   r4, StartSong
	bl   *r4
	jmp  L596
L591
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
	jmp  L596
L590
	li   r1, musicnext
	bl   *r1
	b    @L596
L589
	li   r1, >100
	cb   @autosavetoggle, r1
	jeq  L605
	movb r1, @autosavetoggle
	li   r1, pulldownmenutitles+112
	li   r2, LC36
	li   r3, >D
	li   r4, memcpy
	bl   *r4
	b    @L596
L588
	li   r4, areyousure
	bl   *r4
	li   r2, >100
	cb   r1, r2
	jeq  JMP_169
	b    @L596
JMP_169
	bl   @loadgame
	b    @L596
L587
	clr  r1
	bl   @savegame
	b    @L596
L586
	bl   @areyousure
	li   r2, >100
	cb   r1, r2
	jeq  JMP_170
	b    @L601
JMP_170
	movb r1, @endofgameflag
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    *r11
	jmp  L603
L585
	bl   @areyousure
	li   r2, >100
	cb   r1, r2
	jeq  JMP_171
	b    @L601
JMP_171
	li   r3, >300
	movb r3, @endofgameflag
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10+, r15
	b    @gamereset
L604
	bl   *r15
	li   r1, musicmem
	clr  r2
	li   r4, StartSong
	bl   *r4
	b    @L596
L605
	clr  r1
	movb r1, @autosavetoggle
	li   r1, pulldownmenutitles+112
	li   r2, LC35
	li   r3, >D
	li   r4, memcpy
	bl   *r4
	b    @L596
L603
	.size	turnhuman, .-turnhuman
LC37
	text 'DSK1.LUDOCHR'
	byte 0
LC38
	text 'DSK1.LUDOCOL'
	byte 0
LC39
	text 'DSK1.LUDOMSC'
	byte 0
LC40
	text 'DSK1.LUDOTIT'
	byte 0
	even

	def	graphicsinit
graphicsinit
	ai   r10, >FFFA
	mov  r10, r0
	mov  r11, *r0+
	mov  r9, *r0+
	mov  r13, *r0+
	clr  r1
	bl   @set_graphics
	li   r1, >1000
	mov  r1, @windowaddress
	li   r1, >1
	bl   @bgcolor
	bl   @clrscr
	li   r9, dsr_load
	li   r1, LC37
	li   r2, musicmem
	li   r3, >640
	bl   *r9
	jeq  0
	cb  r1, @$-1
	jne  L613
	li   r13, vdpmemcpy
	mov  @gPattern, r1
	li   r2, musicmem
	li   r3, >640
	bl   *r13
	li   r1, LC38
	li   r2, musicmem
	li   r3, >19
	bl   *r9
	jeq  0
	cb  r1, @$-1
	jne  L613
	mov  @gColor, r1
	li   r2, musicmem
	li   r3, >19
	bl   *r13
	li   r1, LC39
	li   r2, mainscreen
	li   r3, >300
	bl   *r9
	jeq  0
	cb  r1, @$-1
	jne  L613
	li   r1, LC40
	li   r2, musicmem
	li   r3, >240
	bl   *r9
	jeq  0
	cb  r1, @$-1
	jne  L613
	mov  @gImage, r1
	li   r2, musicmem
	li   r3, >240
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	b    @vdpmemcpy
L613
	bl   @fileerrormessage
	bl   @halt
	.size	graphicsinit, .-graphicsinit
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
	jne  L615
	li   r5, >5
	clr  r4
L616
	mov  r5, r1
	ai   r1, saveslots
	mov  r4, r2
	ai   r2, >23
	sla  r2, >4
	ai   r2, pulldownmenutitles
	mov  r5, r3
	ai   r3, saveslots+16
L618
	movb *r1+, *r2+
	c    r1, r3
	jne  L618
	inc  r4
	ai   r5, >10
	ci   r4, >5
	jne  L616
	mov  *r10, r11
	ai   r10, >10
	b    *r11
	jmp  L621
L615
	bl   @fileerrormessage
	mov  *r10, r11
	ai   r10, >10
	b    *r11
L621
	.size	loadconfigfile, .-loadconfigfile
LC41
	text 'No speech synthesizer detected :('
	byte 10
	byte 0
LC42
	text 'DSK1.LUDOMUS1'
	byte 0
LC43
	text 'Press ENTER/FIRE to start game.'
	byte 0
LC44
	text 'M=toggle music.'
	byte 0
LC45
	text 'Music: '
	byte 0
LC46
	text 'Yes '
	byte 0
LC47
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
	li   r2, C.140.3217
	li   r3, >4
	bl   @memcpy
	bl   @loadconfigfile
	li   r2, safe_read
	li   r1, >8322
L623
	mov  *r2+, *r1+
	ci   r1, >832E
	jne  L623
	bl   @detect_speech
	ci   r1, 0
	jeq  JMP_172
	b    @L624
JMP_172
	dect r10
	li   r1, LC41
	mov  r1, *r10
	bl   @cprintf
	inct r10
	li   r1, musicmem
	clr  r2
	li   r3, >C80
	bl   @memset
	li   r1, LC42
	li   r2, musicmem
	li   r3, >C80
	bl   @dsr_load
	jeq  0
	cb  r1, @$-1
	jeq  JMP_173
	b    @L639
JMP_173
L626
	li   r1, musicmem
	clr  r2
	li   r3, StartSong
	bl   *r3
	li   r9, cputsxy
	li   r1, >1
	li   r2, >15
	li   r3, LC43
	bl   *r9
	li   r1, >1
	li   r2, >16
	li   r3, LC44
	bl   *r9
	li   r15, cputs
	li   r14, getkey
	li   r13, >4D00
L637
	li   r1, >1
	li   r2, >14
	li   r3, LC45
	bl   *r9
	jeq  0
	cb  @musicnumber, @$-1
	jeq  L627
L640
	li   r1, LC46
	bl   *r15
L628
	mov  r10, r1
	ai   r1, >A
	li   r2, >100
	bl   *r14
	cb   r1, r13
	jeq  L630
	li   r2, >6D00
	cb   r1, r2
	jeq  L630
	li   r2, >D00
	cb   r1, r2
	jne  L637
	mov  *r10+, r11
	mov  *r10+, r9
	mov  *r10+, r13
	mov  *r10+, r14
	mov  *r10, r15
	ai   r10, >6
	b    *r11
L630
	jeq  0
	cb  @musicnumber, @$-1
	jeq  L631
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
	li   r3, LC45
	bl   *r9
	jeq  0
	cb  @musicnumber, @$-1
	jne  L640
L627
	li   r1, LC47
	bl   *r15
	jmp  L628
L631
	li   r3, >100
	movb r3, @musicnumber
	li   r1, musicmem
	clr  r2
	li   r3, StartSong
	bl   *r3
	jmp  L637
L624
	li   r1, speech_intro
	li   r2, >3F9
	bl   @say_data
	bl   @speech_wait
	li   r1, musicmem
	clr  r2
	li   r3, >C80
	bl   @memset
	li   r1, LC42
	li   r2, musicmem
	li   r3, >C80
	bl   @dsr_load
	jeq  0
	cb  r1, @$-1
	jne  JMP_174
	b    @L626
JMP_174
L639
	bl   @fileerrormessage
	b    @L626
	.size	loadintro, .-loadintro
LC48
	text 'Load old game?'
	byte 0
LC49
	text 'Player %d'
	byte 0
LC50
	text 'Color'
	byte 0
LC51
	text 'Computer'
	byte 0
LC52
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
	li   r3, LC48
	bl   *r15
	li   r1, >1100
	li   r2, >800
	li   r3, >500
	bl   @menupulldown
	movb r1, r9
	bl   @windowrestore
	li   r2, >100
	cb   r9, r2
	jne  JMP_175
	b    @L662
JMP_175
L642
	movb @endofgameflag, r1
	jne  JMP_176
	b    @L663
JMP_176
L643
	li   r9, >100
	li   r14, >300
L655
	jeq  0
	cb  r1, @$-1
	jne  JMP_177
	b    @L644
JMP_177
	clr  r1
	movb r1, @endofgameflag
L645
	li   r13, turngeneric
L658
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
	li   r4, LC49
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
	li   r3, LC50
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
	jeq  JMP_178
	b    @L646
JMP_178
	li   r5, turnhuman
	bl   *r5
L647
	movb @endofgameflag, r1
	jne  L648
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
	jeq  L664
L649
	movb @zv, r3
L653
	cb   r3, r9
	jeq  L650
	seto r1
	movb r1, @np(r4)
	movb r5, r2
	ai   r2, >100
	cb   r2, r14
	jle  L651
	clr  r2
L651
	jeq  0
	cb  r3, @$-1
	jne  L652
	movb r2, r5
	movb r2, r4
	srl  r4, 8
L650
	clr  r3
	mov  r4, r1
	sla  r1, >2
	ai   r1, playerdata
	jeq  0
	cb  @>1(r1), @$-1
	jeq  L653
L652
	movb r2, @turnofplayernr
	movb r3, @zv
	movb @endofgameflag, r1
	jne  JMP_179
	b    @L658
JMP_179
L648
	cb   r1, r9
	jeq  JMP_180
	b    @L655
JMP_180
	bl   @clrscr
	clr  r1
	bl   @bgcolor
	clr  r1
	mov  r1, r2
	li   r3, LC52
	bl   *r15
	jeq  0
	cb  @musicnumber, @$-1
	jne  L665
	bl   @halt
L664
	bl   @playerwins
	movb @turnofplayernr, r2
	movb r2, r5
	movb r2, r4
	srl  r4, 8
	jmp  L649
L646
	li   r1, >17
	li   r2, >5
	li   r3, LC51
	li   r4, cputsxy
	bl   *r4
	b    @L647
L644
	li   r2, inputofnames
	bl   *r2
	b    @L645
L665
	bl   @StopSong
	li   r8, >9FBF
	movb r8, @>8400
	swpb r8
	movb r8, @>8400
	li   r7, >DFFF
	movb r7, @>8400
	swpb r7
	movb r7, @>8400
	bl   @halt
L663
	bl   @loadmainscreen
	movb @endofgameflag, r1
	b    @L643
L662
	bl   @loadmainscreen
	bl   @loadgame
	b    @L642
	.size	main, .-main

	def	speech_intro
	.type	speech_intro, @object
	.size	speech_intro, 1017
speech_intro
	byte	-60
	byte	53
	byte	47
	byte	52
	byte	-83
	byte	-87
	byte	-69
	byte	84
	byte	77
	byte	87
	byte	-105
	byte	20
	byte	18
	byte	50
	byte	-107
	byte	83
	byte	-116
	byte	61
	byte	112
	byte	74
	byte	85
	byte	117
	byte	119
	byte	-120
	byte	-96
	byte	41
	byte	-107
	byte	-59
	byte	45
	byte	-55
	byte	-116
	byte	-90
	byte	84
	byte	20
	byte	-51
	byte	-62
	byte	16
	byte	26
	byte	50
	byte	-98
	byte	-84
	byte	6
	byte	93
	byte	-78
	byte	-55
	byte	72
	byte	-116
	byte	120
	byte	84
	byte	-38
	byte	-88
	byte	6
	byte	61
	byte	-78
	byte	-63
	byte	-92
	byte	32
	byte	27
	byte	-104
	byte	-50
	byte	112
	byte	-93
	byte	108
	byte	-126
	byte	66
	byte	-61
	byte	-59
	byte	-60
	byte	-78
	byte	10
	byte	10
	byte	75
	byte	103
	byte	23
	byte	55
	byte	-52
	byte	-125
	byte	42
	byte	45
	byte	-52
	byte	-109
	byte	-104
	byte	-120
	byte	-92
	byte	-44
	byte	112
	byte	-75
	byte	28
	byte	50
	byte	-38
	byte	-76
	byte	82
	byte	-52
	byte	104
	byte	-54
	byte	121
	byte	-45
	byte	74
	byte	54
	byte	-95
	byte	-87
	byte	96
	byte	77
	byte	-53
	byte	-39
	byte	-123
	byte	-70
	byte	18
	byte	-75
	byte	104
	byte	-43
	byte	-80
	byte	98
	byte	74
	byte	84
	byte	-30
	byte	80
	byte	35
	byte	-91
	byte	-86
	byte	96
	byte	-117
	byte	67
	byte	-50
	byte	88
	byte	-94
	byte	65
	byte	53
	byte	75
	byte	73
	byte	18
	byte	5
	byte	37
	byte	-87
	byte	40
	byte	99
	byte	-77
	byte	107
	byte	-128
	byte	41
	byte	60
	byte	-62
	byte	-58
	byte	124
	byte	100
	byte	89
	byte	-110
	byte	9
	byte	53
	byte	-55
	byte	25
	byte	37
	byte	14
	byte	76
	byte	-43
	byte	-80
	byte	-25
	byte	8
	byte	-116
	byte	18
	byte	83
	byte	-62
	byte	22
	byte	-113
	byte	-110
	byte	42
	byte	84
	byte	-127
	byte	74
	byte	60
	byte	73
	byte	104
	byte	32
	byte	37
	byte	-68
	byte	-103
	byte	6
	byte	-121
	byte	0
	byte	16
	byte	104
	byte	-99
	byte	-7
	byte	114
	byte	-47
	byte	54
	byte	-75
	byte	10
	byte	-34
	byte	75
	byte	9
	byte	37
	byte	-92
	byte	-54
	byte	91
	byte	-75
	byte	36
	byte	-28
	byte	-110
	byte	26
	byte	71
	byte	83
	byte	94
	byte	-80
	byte	75
	byte	-86
	byte	28
	byte	95
	byte	123
	byte	64
	byte	46
	byte	-119
	byte	-80
	byte	58
	byte	111
	byte	6
	byte	57
	byte	37
	byte	-52
	byte	123
	byte	-67
	byte	40
	byte	104
	byte	-109
	byte	-30
	byte	16
	byte	-75
	byte	-30
	byte	-96
	byte	-112
	byte	6
	byte	-38
	byte	-38
	byte	-128
	byte	34
	byte	2
	byte	-30
	byte	73
	byte	-99
	byte	-106
	byte	26
	byte	-78
	byte	-46
	byte	66
	byte	-109
	byte	77
	byte	-103
	byte	-118
	byte	46
	byte	59
	byte	-117
	byte	58
	byte	-83
	byte	74
	byte	-87
	byte	20
	byte	34
	byte	72
	byte	29
	byte	7
	byte	101
	byte	87
	byte	80
	byte	-25
	byte	-10
	byte	-20
	byte	100
	byte	88
	byte	15
	byte	-27
	byte	120
	byte	37
	byte	-47
	byte	86
	byte	78
	byte	0
	byte	102
	byte	-94
	byte	105
	byte	71
	byte	1
	byte	-109
	byte	-102
	byte	34
	byte	-65
	byte	50
	byte	-107
	byte	100
	byte	-73
	byte	99
	byte	-26
	byte	-86
	byte	-67
	byte	93
	byte	-59
	byte	73
	byte	-54
	byte	-83
	byte	-22
	byte	52
	byte	118
	byte	-57
	byte	-87
	byte	-30
	byte	35
	byte	-56
	byte	-84
	byte	34
	byte	-104
	byte	26
	byte	47
	byte	-29
	byte	-16
	byte	-76
	byte	32
	byte	58
	byte	16
	byte	39
	byte	36
	byte	-62
	byte	-111
	byte	50
	byte	57
	byte	-45
	byte	22
	byte	-41
	byte	-84
	byte	-58
	byte	-111
	byte	-62
	byte	19
	byte	89
	byte	-68
	byte	33
	byte	15
	byte	-68
	byte	17
	byte	-41
	byte	-94
	byte	-127
	byte	124
	byte	16
	byte	-42
	byte	66
	byte	-45
	byte	-77
	byte	-80
	byte	117
	byte	28
	byte	37
	byte	-27
	byte	-54
	byte	42
	byte	-95
	byte	47
	byte	-56
	byte	-62
	byte	67
	byte	-102
	byte	-110
	byte	60
	byte	35
	byte	45
	byte	11
	byte	-96
	byte	42
	byte	-14
	byte	89
	byte	-59
	byte	-45
	byte	-112
	byte	-87
	byte	-15
	byte	55
	byte	-57
	byte	8
	byte	-119
	byte	-90
	byte	70
	byte	87
	byte	-115
	byte	-68
	byte	109
	byte	-102
	byte	26
	byte	45
	byte	115
	byte	-12
	byte	74
	byte	-28
	byte	106
	byte	60
	byte	60
	byte	64
	byte	-53
	byte	-107
	byte	105
	byte	-32
	byte	-16
	byte	36
	byte	-18
	byte	74
	byte	-92
	byte	1
	byte	51
	byte	93
	byte	33
	byte	98
	byte	-95
	byte	22
	byte	-11
	byte	-31
	byte	-128
	byte	-78
	byte	5
	byte	64
	byte	52
	byte	-29
	byte	-62
	byte	84
	byte	76
	byte	-75
	byte	41
	byte	112
	byte	-119
	byte	8
	byte	119
	byte	10
	byte	-95
	byte	-90
	byte	54
	byte	58
	byte	66
	byte	69
	byte	-121
	byte	-122
	byte	-104
	byte	-24
	byte	10
	byte	37
	byte	-27
	byte	90
	byte	42
	byte	59
	byte	-69
	byte	85
	byte	-112
	byte	113
	byte	45
	byte	48
	byte	-73
	byte	30
	byte	11
	byte	14
	byte	-24
	byte	56
	byte	56
	byte	-44
	byte	92
	byte	-89
	byte	-75
	byte	-69
	byte	-32
	byte	82
	byte	-45
	byte	-28
	byte	-107
	byte	-26
	byte	80
	byte	74
	byte	-51
	byte	-109
	byte	70
	byte	105
	byte	64
	byte	46
	byte	13
	byte	79
	byte	-26
	byte	-51
	byte	1
	byte	57
	byte	53
	byte	-76
	byte	-72
	byte	13
	byte	4
	byte	52
	byte	-41
	byte	-96
	byte	-110
	byte	25
	byte	48
	byte	-84
	byte	77
	byte	3
	byte	91
	byte	44
	byte	-86
	byte	59
	byte	48
	byte	13
	byte	-52
	byte	-15
	byte	96
	byte	-18
	byte	-62
	byte	52
	byte	72
	byte	109
	byte	36
	byte	-78
	byte	27
	byte	101
	byte	38
	byte	-96
	byte	29
	byte	-90
	byte	74
	byte	12
	byte	112
	byte	40
	byte	-101
	byte	1
	byte	-82
	byte	54
	byte	55
	byte	-64
	byte	-43
	byte	-106
	byte	6
	byte	56
	byte	-42
	byte	82
	byte	0
	byte	93
	byte	68
	byte	-94
	byte	-35
	byte	-13
	byte	118
	byte	49
	byte	-107
	byte	5
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	-128
	byte	114
	byte	26
	byte	-62
	byte	-118
	byte	-57
	byte	34
	byte	-85
	byte	-64
	byte	-50
	byte	76
	byte	74
	byte	-110
	byte	-86
	byte	4
	byte	45
	byte	-94
	byte	-75
	byte	5
	byte	-102
	byte	18
	byte	-116
	byte	-116
	byte	-74
	byte	20
	byte	17
	byte	114
	byte	92
	byte	-77
	byte	-110
	byte	82
	byte	82
	byte	74
	byte	113
	byte	-81
	byte	112
	byte	74
	byte	67
	byte	41
	byte	-59
	byte	35
	byte	75
	byte	-51
	byte	35
	byte	-124
	byte	20
	byte	-81
	byte	104
	byte	-86
	byte	8
	byte	96
	byte	82
	byte	-36
	byte	-83
	byte	105
	byte	-101
	byte	-92
	byte	41
	byte	73
	byte	-12
	byte	97
	byte	47
	byte	-109
	byte	-87
	byte	-94
	byte	37
	byte	91
	byte	-62
	byte	67
	byte	-92
	byte	-102
	byte	-42
	byte	52
	byte	77
	byte	51
	byte	-111
	byte	58
	byte	-34
	byte	93
	byte	52
	byte	-59
	byte	96
	byte	-22
	byte	-60
	byte	50
	byte	55
	byte	115
	byte	19
	byte	-95
	byte	-25
	byte	75
	byte	-51
	byte	44
	byte	4
	byte	-104
	byte	-98
	byte	109
	byte	49
	byte	-75
	byte	18
	byte	-88
	byte	6
	byte	-74
	byte	81
	byte	67
	byte	-121
	byte	0
	byte	27
	byte	-48
	byte	67
	byte	-11
	byte	8
	byte	-127
	byte	104
	byte	4
	byte	15
	byte	60
	byte	-45
	byte	8
	byte	3
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	0
	byte	-94
	byte	-115
	byte	44
	byte	41
	byte	74
	byte	86
	byte	110
	byte	115
	byte	73
	byte	-68
	byte	120
	byte	108
	byte	-71
	byte	84
	byte	38
	byte	-83
	byte	-30
	byte	34
	byte	-99
	byte	42
	byte	-98
	byte	-75
	byte	83
	byte	-115
	byte	116
	byte	-86
	byte	105
	byte	-74
	byte	74
	byte	19
	byte	-63
	byte	-82
	byte	-122
	byte	-87
	byte	42
	byte	89
	byte	73
	byte	-77
	byte	22
	byte	-76
	byte	30
	byte	7
	byte	-91
	byte	-115
	byte	92
	byte	-48
	byte	-98
	byte	11
	byte	28
	byte	-79
	byte	-79
	byte	-83
	byte	84
	byte	117
	byte	81
	byte	-55
	byte	73
	byte	-10
	byte	-54
	byte	60
	byte	-51
	byte	-20
	byte	-124
	byte	-126
	byte	123
	byte	-39
	byte	21
	byte	-123
	byte	-100
	byte	74
	byte	-22
	byte	117
	byte	26
	byte	29
	byte	118
	byte	-86
	byte	88
	byte	-44
	byte	77
	byte	114
	byte	56
	byte	-87
	byte	98
	byte	-47
	byte	-90
	byte	-64
	byte	-31
	byte	-90
	byte	-126
	byte	5
	byte	-37
	byte	6
	byte	99
	byte	-106
	byte	10
	byte	-102
	byte	-12
	byte	28
	byte	93
	byte	78
	byte	-56
	byte	113
	byte	-75
	byte	-61
	byte	104
	byte	-121
	byte	-82
	byte	-64
	byte	83
	byte	27
	byte	123
	byte	20
	byte	-104
	byte	2
	byte	109
	byte	45
	byte	-50
	byte	-93
	byte	33
	byte	42
	byte	-16
	byte	36
	byte	-52
	byte	-122
	byte	20
	byte	107
	byte	-63
	byte	53
	byte	77
	byte	75
	byte	-117
	byte	-95
	byte	18
	byte	91
	byte	-36
	byte	-75
	byte	-116
	byte	-108
	byte	90
	byte	14
	byte	23
	byte	103
	byte	15
	byte	-100
	byte	26
	byte	-39
	byte	-110
	byte	67
	byte	37
	byte	112
	byte	106
	byte	68
	byte	-105
	byte	114
	byte	14
	byte	98
	byte	-87
	byte	17
	byte	89
	byte	51
	byte	41
	byte	-119
	byte	-122
	byte	-106
	byte	4
	byte	-49
	byte	5
	byte	-109
	byte	34
	byte	90
	byte	80
	byte	-38
	byte	-121
	byte	88
	byte	14
	byte	114
	byte	65
	byte	-82
	byte	72
	byte	21
	byte	70
	byte	-63
	byte	-85
	byte	38
	byte	29
	byte	93
	byte	29
	byte	7
	byte	-96
	byte	-5
	byte	-86
	byte	4
	byte	76
	byte	31
	byte	21
	byte	-16
	byte	106
	byte	-62
	byte	89
	byte	-39
	byte	101
	byte	-56
	byte	-8
	byte	-80
	byte	48
	byte	46
	byte	-93
	byte	33
	byte	-25
	byte	91
	byte	-59
	byte	37
	byte	-125
	byte	-102
	byte	-110
	byte	62
	byte	-46
	byte	-44
	byte	20
	byte	34
	byte	10
	byte	-8
	byte	-62
	byte	-107
	byte	-53
	byte	-108
	byte	42
	byte	-32
	byte	-45
	byte	-28
	byte	74
	byte	75
	byte	-90
	byte	-128
	byte	87
	byte	67
	byte	-94
	byte	109
	byte	-122
	byte	2
	byte	-51
	byte	20
	byte	-41
	byte	-88
	byte	-104
	byte	10
	byte	-66
	byte	85
	byte	-35
	byte	60
	byte	80
	byte	40
	byte	-39
	byte	21
	byte	55
	byte	115
	byte	-61
	byte	-82
	byte	-92
	byte	71
	byte	92
	byte	-76
	byte	2
	byte	-69
	byte	10
	byte	47
	byte	83
	byte	-43
	byte	24
	byte	-19
	byte	42
	byte	-68
	byte	85
	byte	-44
	byte	-77
	byte	-76
	byte	-85
	byte	-48
	byte	10
	byte	17
	byte	-9
	byte	74
	byte	-82
	byte	38
	byte	59
	byte	-103
	byte	82
	byte	67
	byte	-102
	byte	-122
	byte	-36
	byte	64
	byte	26
	byte	13
	byte	105
	byte	90
	byte	-68
	byte	19
	byte	-87
	byte	-36
	byte	-127
	byte	-22
	byte	-48
	byte	41
	byte	-112
	byte	118
	byte	-118
	byte	-84
	byte	71
	byte	103
	byte	-128
	byte	-58
	byte	72
	byte	-79
	byte	1
	byte	-67
	byte	70
	byte	82
	byte	-73
	byte	76
	byte	70
	byte	-16
	byte	10
	byte	-39
	byte	-62
	byte	50
	byte	-118
	byte	64
	byte	88
	byte	101
	byte	15
	byte	85
	byte	104
	byte	6
	byte	-66
	byte	-60
	byte	-39
	byte	29
	byte	2

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
	.type	C.140.3217, @object
	.size	C.140.3217, 4
C.140.3217
	byte	109
	byte	77
	byte	13
	byte	0
	.type	C.124.2742, @object
	.size	C.124.2742, 5
C.124.2742
	byte	8
	byte	9
	byte	11
	byte	10
	byte	13
	even
	.type	random_mask.1614, @object
	.size	random_mask.1614, 2
random_mask.1614
	data	-19456
	dseg
	even
	.type	seed.1613, @object
	.size	seed.1613, 2
seed.1613
	data	-21846
	pseg
	.type	C.59.2134, @object
	.size	C.59.2134, 4
C.59.2134
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

	even
	def mainscreen
mainscreen
	bss 768

	ref	halt

	ref	StopSong

	ref	cputsxy

	ref	bgcolor

	ref	clrscr

	ref	cputcxy

	ref	cprintf

	ref	conio_y

	ref	conio_x

	ref	memset

	ref	StartSong

	ref	cputs

	ref	memcpy

	ref	vdpmemcpy

	ref	gImage

	ref	gColor

	ref	gPattern

	ref	set_graphics

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
