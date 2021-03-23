	pseg
	even

	def	_start
_start
* Begin inline assembler code
* 71 "crt0.c" 1
		limi 0
* 0 "" 2
* 76 "crt0.c" 1
		lwpi >8300
* 0 "" 2
* 79 "crt0.c" 1
		li sp, >4000
* 0 "" 2
* 82 "crt0.c" 1
		b @_start2
* 0 "" 2
* End of inline assembler code
	b    *r11
	.size	_start, .-_start
	even

	def	_start2
_start2
	dect r10
	mov  r11, *r10
	li   r1, __DATA_START
	ci   r1, __DATA_END
	jhe  L4
	li   r2, __VAL_START
L5
	movb *r2+, *r1+
	ci   r1, __DATA_END
	jl  L5
L4
	li   r1, __BSS_START
	ci   r1, __BSS_END
	jhe  L6
L10
	clr  r2
	movb r2, *r1+
	ci   r1, __BSS_END
	jl  L10
L6
	bl   @main
L8
	jmp  L8
	.size	_start2, .-_start2

	ref	main

	ref	__BSS_END

	ref	__BSS_START

	ref	__DATA_END

	ref	__VAL_START

	ref	__DATA_START
