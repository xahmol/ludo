; ====================================================================================
; sidplay_assembly.s
; Core assembly routines for sidplay.c
;
; This code is assuming a SID file with load address $3000, init address $3000
; and playaddress $3003, with zeropage usage of $fc, $fd and $fe.
; For other SIDs this routine needs to be adapted.
;
; Code based on the SID assembly code in 8Bit Unity:
; https://github.com/8bit-Dude/8bit-Unity/blob/main/unity/targets/c64/SID.s
;
; 	Copyright (c) 2018 Anthony Beaucamp.
;
; 	This software is provided 'as-is', without any express or implied warranty.
; 	In no event will the authors be held liable for any damages arising from
; 	the use of this software.
;
; 	Permission is granted to anyone to use this software for any purpose,
; 	including commercial applications, and to alter it and redistribute it
; 	freely, subject to the following restrictions:
;
;   1. The origin of this software must not be misrepresented; you must not
;   claim that you wrote the original software. If you use this software in a
;   product, an acknowledgment in the product documentation would be
;   appreciated but is not required.
;
;   2. Altered source versions must be plainly marked as such, and must not
;   be misrepresented as being the original software.
;
;   3. This notice may not be removed or altered from any distribution.
;
;   4. The names of this software and/or it's copyright holders may not be
;   used to endorse or promote products derived from this software without
;   specific prior written permission.
;
; Altered for C128 by Xander Mol
;
; =====================================================================================

	.export _PlayMusic
	.export _StopMusic

	.segment "MACO"	

MemConfTmp:		.byte 0
SIDZPtmp1:		.byte 0
SIDZPtmp2:		.byte 0
SIDZPtmp3:		.byte 0
SIDIRQtmp1:		.byte 0
SIDIRQtmp2:		.byte 0

; ---------------------------------------------------------------
; void __near__ _PlayMusic (void)
; ---------------------------------------------------------------

_PlayMusic:
		; Store old MMU config and change to bank 1 wkth I/O ($7e)
		lda	$ff00							; Obtain present memory configuration
		sta MemConfTmp						; Store in temp location for safeguarding
		lda #$7e							; Obtain selected MMU config
		sta $ff00							; Store selected MMU config

		; Store old ZP values
		lda $fc								; Load $fc ZP value
		sta SIDZPtmp1						; Store at temp address
		lda $fd								; Load $fc ZP value
		sta SIDZPtmp2						; Store at temp address
		lda $fe								; Load $fc ZP value
		sta SIDZPtmp3						; Store at temp address

initSID:
		; init code	(default address is $0903)
		jsr $3000							; Jump to SID init routine
		
        ; set IRQ pointer in $314/$315
        sei									; Stop interupts
		lda $314							; Load old IRQ low byte
		sta SIDIRQtmp1						; Store at temp location
		sta doneFrame+1						; Auto modify JMP to old IRQ
        lda #<interruptSID					; Load new IRQ low byte
		sta $314							; Store new IRQ low byte
		lda $315							; Load old IRQ high byte
		sta SIDIRQtmp2						; Store at temp location
		sta doneFrame+2						; Auto modify JMP to old IRQ
        lda #>interruptSID					; Load new IRQ high byte
		sta $315							; Store new IRQ high byte

		; Retore ZP values
		lda SIDZPtmp1						; Load $fc ZP value
		sta $fc								; Store at temp address
		lda SIDZPtmp2						; Load $fc ZP value
		sta $fd								; Store at temp address
		lda SIDZPtmp3						; Load $fc ZP value
		sta $fe								; Store at temp address

		; Restore memory configuration
		lda MemConfTmp						; Obtain saved memory config
		sta $ff00							; Restore memory config

        cli									; Re-enable interupts
		
        rts       							; Return

; ---------------------------------------------------------------
; void __near__ _StopMusic (void)
; ---------------------------------------------------------------

_StopMusic:
		; restore IRQ vector to kernel interrupt routine
        sei									; Stop interupts
		ldx SIDIRQtmp1						; Load low byte of old IRQ
		ldy SIDIRQtmp2						; Load high byte of old IRQ
		stx $314							; Store low byte
		sty $315							; Store high byte
        cli 								; Enable interupts
		
		jsr resetSID						; Reset SID to mute sounds
        rts 								; Return

; ---------------------------------------------------------------

interruptSID:
		; Store old MMU config and change to bank 1 wkth I/O ($7e)
		lda	$ff00							; Obtain present memory configuration
		sta MemConfTmp						; Store in temp location for safeguarding
		lda #$7e							; Obtain selected MMU config
		sta $ff00							; Store selected MMU config

		; Store old ZP values
		lda $fc								; Load $fc ZP value
		sta SIDZPtmp1						; Store at temp address
		lda $fd								; Load $fc ZP value
		sta SIDZPtmp2						; Store at temp address
		lda $fe								; Load $fc ZP value
		sta SIDZPtmp3						; Store at temp address
	
playFrame:	
		; interrupt code (default address is $0806)
        jsr $3003							; Jump to play frame routine of SID

		; Retore ZP values
		lda SIDZPtmp1						; Load $fc ZP value
		sta $fc								; Store at temp address
		lda SIDZPtmp2						; Load $fc ZP value
		sta $fd								; Store at temp address
		lda SIDZPtmp3						; Load $fc ZP value
		sta $fe								; Store at temp address

		; Restore memory configuration
		lda MemConfTmp						; Obtain saved memory config
		sta $ff00							; Restore memory config
		
doneFrame:
		; do the normal interrupt service routine		
        jmp $FA65							; Jump to old IRQ (will be automodified)

; ---------------------------------------------------------------

resetSID:
		; reset SID state
        ldx     #$18
        lda     #$00
rst1:    
        sta     $d400,x
        dex
        bpl     rst1
 
        lda     #$08
        sta     $d404
        sta     $d40b
        sta     $d412 
        ldx    #$03
rst2:       
        bit     $d011
        bpl     *-3
        bit     $d011
        bmi     *-3
        dex
        bpl     rst2
 
        lda     #$00
        sta     $d404
        sta     $d40b
        sta     $d412
        lda     #$00
        sta     $d418
		rts
