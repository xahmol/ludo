     
; Includes
            
    .include "jumptab.inc"              ; GEOS functions jumptable
    .include "geossym.inc"              ; GEOS symbols
 
 ; VDC Core functions   
    
    .export		_VDC_ReadRegister_core
	.export		_VDC_WriteRegister_core
	.export		_VDC_Poke_core
	.export		_VDC_Peek_core
	.export		_VDC_DetectVDCMemSize_core
	;.export		_VDC_SetExtendedVDCMemSize
	;.export		_VDC_CopyCharsetsfromROM
	;.export		_VDC_MemCopy_core
	.export		_VDC_HChar_core
	;.export		_VDC_VChar_core
	;.export		_VDC_CopyMemToVDC_core
	;.export		_VDC_CopyVDCToMem_core
	;.export		_VDC_RedefineCharset_core
	.export		_VDC_FillArea_core
	;.export		_VDC_CopyViewPortToVDC_core
	;.export		_VDC_ScrollCopy_core
	;.export		_SetLoadSaveBank_core
	;.export		_POKEB_core
	;.export		_PEEKB_core
	;.export		_BankMemCopy_core
	;.export		_BankMemSet_core

    .export		_VDC_regadd
	.export		_VDC_regval
	.export		_VDC_addrh
	.export		_VDC_addrl
	.export		_VDC_desth
	.export		_VDC_destl
	.export 	_VDC_strideh
	.export		_VDC_stridel
	.export		_VDC_value
	.export		_VDC_tmp1
	.export		_VDC_tmp2
	.export		_VDC_tmp3
	.export		_VDC_tmp4

; GEOS function call core functions
    .export     _SetColorModeCore
    .export     _ColorCardSetCore
    .export     _ColorCardGetCore
    .export     _ColorRectangleCore

    .export     _a_tmp

VDC_ADDRESS_REGISTER    = $D600
VDC_DATA_REGISTER       = $D601

; Variables
_VDC_regadd:
	.res	1
_VDC_regval:
	.res	1
_VDC_addrh:
	.res	1
_VDC_addrl:
	.res	1
_VDC_desth:
	.res	1
_VDC_destl:
	.res	1
_VDC_strideh:
	.res	1
_VDC_stridel:
	.res	1
_VDC_value:
	.res	1
_VDC_tmp1:
	.res	1
_VDC_tmp2:
	.res	1
_VDC_tmp3:
	.res	1
_VDC_tmp4:
	.res	1
ZPtmp1:
	.res	1
ZPtmp2:
	.res	1
ZPtmp3:
	.res	1
ZPtmp4:
	.res	1
MemConfTmp:
	.res	1

_a_tmp:
	.res	1
scr80polartmp:
    .res    1

; Generic helper routines

; ------------------------------------------------------------------------------------------
VDC_Read:
; Function to do a VDC read and wait for ready status
; Input:	X = register number
; Output:	A = read value
; ------------------------------------------------------------------------------------------

	stx VDC_ADDRESS_REGISTER            ; Store X in VDC address register
notyetreadyread:						; Start of wait loop to wait for VDC status ready
	bit VDC_ADDRESS_REGISTER            ; Check status bit 7 of VDC address register
	bpl notyetreadyread                 ; Continue loop if status is not ready
	lda VDC_DATA_REGISTER               ; Load data to A from VDC data register
	rts

; ------------------------------------------------------------------------------------------
VDC_Write:
; Function to do a VDC read and wait for ready status
; Input:	X = register number
; 			A = value to write
; ------------------------------------------------------------------------------------------

	stx VDC_ADDRESS_REGISTER            ; Store X in VDC address register
notyetreadywrite:						; Start of wait loop to wait for VDC status ready
	bit VDC_ADDRESS_REGISTER            ; Check status bit 7 of VDC address register
	bpl notyetreadywrite                ; Continue loop if status is not ready
	sta VDC_DATA_REGISTER               ; Store A to VDC data
	rts

; ------------------------------------------------------------------------------------------
SetBlockCopy:
; Function to set block copy mode while preserving present src80polar GOES sys variable
; Output:   Safeguard present value of sys variable in temp variable
; ------------------------------------------------------------------------------------------

    lda scr80polar                      ; Load present value of shadow copy VDC reg 24
    sta scr80polartmp                   ; Safeguard present value
    ora #$80                            ; Set bit 7 for block copy
    rts                                 ; Return

; ------------------------------------------------------------------------------------------
ClearBlockCopy:
; Function to clear block copy mode nby reverting to temp copy of src80polar GOES sys var
; Input:   Safeguarded present value of sys variable in temp variable
; ------------------------------------------------------------------------------------------

    lda scr80polartmp                   ; Load temp value of shadow copy VDC reg 24
    sta scr80polar                      ; Store to GEOS shadow copy
    rts   

; Core routines

; ------------------------------------------------------------------------------------------
_VDC_ReadRegister_core:
; Function to read a VDC register
; Input:	VDC_regadd = register number
; Output:	VDC_regval = read value
; ------------------------------------------------------------------------------------------

	ldx _VDC_regadd                     ; Load register address in X
	jsr VDC_Read						; Read VDC
	sta _VDC_regval                     ; Load A to return variable
    rts

; ------------------------------------------------------------------------------------------
_VDC_WriteRegister_core:
; Function to write a VDC register
; Input:	VDC_regadd = register numnber
;			VDC_regval = value to write
; ------------------------------------------------------------------------------------------

    ldx _VDC_regadd                     ; Load register address in X
	lda _VDC_regval				        ; Load register value in A
	jsr VDC_Write						; Write VDC
    rts

; ------------------------------------------------------------------------------------------
_VDC_Poke_core:
; Function to store a value to a VDC address
; Input:	VDC_addrh = VDC address high byte
;			VDC_addrl = VDC address low byte
;			VDC_value = value to write
; ------------------------------------------------------------------------------------------

    ldx #$12                            ; Load $12 for register 18 (VDC RAM address high) in X	
	lda _VDC_addrh                      ; Load high byte of address in A
	jsr VDC_Write						; Write VDC
	inx		    						; Increase X for register 19 (VDC RAM address low)
	lda _VDC_addrl      				; Load low byte of address in A
	jsr VDC_Write						; Write VDC
	ldx #$1f    						; Load $1f for register 31 (VDC data) in X	
	lda _VDC_value       				; Load value to write in A
	jsr VDC_Write						; Write VDC
    rts

; ------------------------------------------------------------------------------------------
_VDC_Peek_core:
; Function to read a value from a VDC address
; Input:	VDC_addrh = VDC address high byte
;			VDC_addrl = VDC address low byte
; Output:	VDC_value = read value
; ------------------------------------------------------------------------------------------

    ldx #$12    						; Load $12 for register 18 (VDC RAM address high) in X	
	lda _VDC_addrh      				; Load high byte of address in A
	jsr VDC_Write						; Write VDC
	inx					    			; Increase X for register 19 (VDC RAM address low)
	lda _VDC_addrl	    	    		; Load low byte of address in A
	jsr VDC_Write						; Write VDC
	ldx #$1f    						; Load $1f for register 31 (VDC data) in X	
	jsr VDC_Read						; Read VDC
	sta _VDC_value			        	; Load A to return variable
    rts

; ------------------------------------------------------------------------------------------
_VDC_DetectVDCMemSize_core:
; Function to detect the VDC memory size
; Output:	VDC_value = memory size in KB (16 or 64)
; ------------------------------------------------------------------------------------------

	; Setting memory mode to 64KB
	; Reading register 28, safeguarding value, setting bit 4 and storing back to register 28
	ldx #$1c							; Load $1c for register 28 in X
	jsr VDC_Read						; Read VDC
	tay									; Transfer A to Y to save value for later restore
	ora #$10							; Set bit 4 of A
	jsr VDC_Write						; Write VDC

	; Writing a $00 value to VDC $1fff
	ldx #$12                            ; Load $12 for register 18 (VDC RAM address high) in X	
	lda #$1f                    		; Load high byte of address in A
	jsr VDC_Write						; Write VDC
	inx		    						; Increase X for register 19 (VDC RAM address low)
	lda #$ff      						; Load low byte of address in A
	jsr VDC_Write						; Write VDC
	ldx #$1f    						; Load $1f for register 31 (VDC data) in X	
	lda #$00       						; Load value to store in A
	jsr VDC_Write						; Write VDC

	; Writing a $ff value to VDC $9fff
	ldx #$12                            ; Load $12 for register 18 (VDC RAM address high) in X	
	lda #$9f                    		; Load high byte of address in A
	jsr VDC_Write						; Write VDC
	inx		    						; Increase X for register 19 (VDC RAM address low)
	lda #$ff      						; Load low byte of address in A
	jsr VDC_Write						; Write VDC
	ldx #$1f    						; Load $1f for register 31 (VDC data) in X	
	lda #$ff       						; Load value to store in A
	jsr VDC_Write						; Write VDC

	; Reading back value of VDC $1fff
    ldx #$12    						; Load $12 for register 18 (VDC RAM address high) in X	
	lda #$1f		     				; Load high byte of address in A
	jsr VDC_Write						; Write VDC
	inx					    			; Increase X for register 19 (VDC RAM address low)
	lda #$ff    	    				; Load low byte of address in A
	jsr VDC_Write						; Write VDC
	ldx #$1f    						; Load $1f for register 31 (VDC data) in X	
	jsr VDC_Read						; Read VDC

	; Comparing value with $ff to see if 64KB address could be read
	bne sixteendetected					; If not equal 16KB detected, so branch
	lda #64								; Load 64 as value to A
	jmp dmsend							; Jump to end of routine
sixteendetected:						; Label for 16KB detected
	lda #16								; Load 16 as value to A

	; Restore bit 4 of register 28
dmsend:									; Label for end of routine
	sta _VDC_value						; Load KB size to return value
	tya									; Transfer value stored in Y back to A
	ldx #$1c							; Store $1c in A for register 28
	jsr VDC_Write						; Write VDC
	rts									; Return

; ------------------------------------------------------------------------------------------
_VDC_HChar_core:
; Function to draw horizontal line with given value (draws from left to right)
; Input:	VDC_addrh = igh byte of start address
;			VDC_addrl = ow byte of start address
;			VDC_tmp1 = character value
;			VDC_tmp2 = length value
;			VDC_tmp3 = attribute value
; ------------------------------------------------------------------------------------------

	; Set block copy bit in src80polar GEOS sys variable containing shadow VDC reg 24
    jsr SetBlockCopy                    ; Jump to routine setting shadow reg copy
    
    ; Hi-byte of the destination address to register 18
	ldx #$12    						; Load $12 for register 18 (VDC RAM address high) in X	
	lda _VDC_addrh	        			; Load high byte of start in A
	jsr VDC_Write						; Write VDC

	; Lo-byte of the destination address to register 19
	ldx #$13    						; Load $13 for register 19 (VDC RAM address high) in X	
	lda _VDC_addrl		        		; Load high byte of start in A
	jsr VDC_Write						; Write VDC

	; Store character to write in data register 31
	ldx #$1f    						; Load $1f for register 31 (VDC data) in X	
	lda _VDC_tmp1			        	; Load character value in A
	jsr VDC_Write						; Write VDC

	; Clear the copy bit (bit 7) of register 24 (block copy mode)
	ldx #$18    						; Load $18 for register 24 (block copy mode) in X	
	lda scr80polar				        ; Load VDC reg 24 shadow copy
	jsr VDC_Write						; Write VDC

	; Store lenth in data register 30
	ldx #$1e    						; Load $1f for register 30 (word count) in X	
	lda _VDC_tmp2			        	; Load character value in A
	jsr VDC_Write						; Write VDC

    ; Clear block copy bit in src80polar GEOS sys variable containing shadow VDC reg 24
    jsr ClearBlockCopy                  ; Jump to routine clearing shadow reg copy

    rts

; ------------------------------------------------------------------------------------------
_VDC_FillArea_core:
; Function to draw area with given character (draws from topleft to bottomright)
; Input:	VDC_addrh = high byte of start address
;			VDC_addrl = low byte of start address
;			VDC_tmp1 = value
;			VDC_tmp2 = length value
;			VDC_tmp3 = attribute value
;			VDC_tmp4 = number of lines
; ------------------------------------------------------------------------------------------

loopdrawline:
	jsr _VDC_HChar_core					; Draw line

	; Increase start address with 80 for next line
	clc 								; Clear carry
	lda _VDC_addrl	        			; Load low byte of address to A
	adc #$50    						; Add 80 with carry
	sta _VDC_addrl			        	; Store result back
	lda _VDC_addrh	        			; Load high byte of address to A
	adc #$00    						; Add 0 with carry
	sta _VDC_addrh	        			; Store result back

	; Decrease line counter and loop until zero
	dec _VDC_tmp4						; Decrease line counter
	bne loopdrawline					; Continue until counter is zero
	rts

; GEOS function calls

_SetColorModeCore:
    lda _a_tmp                          ; Load mode in A via a_tmp variable
    jsr SetColorMode                    ; Jump to SetColorMode routine
    rts                                 ; Return

_ColorCardSetCore:
    lda _a_tmp                          ; Load color in A via a_tmp variable
    sec                                 ; Set Carry to set color
    jsr ColorCard                       ; Jump to ColorCard routine
    rts                                 ; Return

_ColorCardGetCore:
    clc                                 ; Clear Carry to get color
    jsr ColorCard                       ; Jump to ColorCard routine
    sta _a_tmp                          ; Store retrieved color in a_tmp variable
    rts                                 ; Return

_ColorRectangleCore:
    lda _a_tmp                          ; Load color in A via a_tmp variable
    jsr ColorRectangle                  ; Jump to ColorRectangle routine
    rts                                 ; Return

