; ====================================================================================
; sidplay_assembly.s
; Core assembly routines for playsing SID music in GEOS
;
; This code is assuming a SID file with load address at the overlay start address,
; init address that start addess and play address that address +3.
; Zeropage usage of $fc, $fd and $fe.
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
; -	Hitchhikers Guide to GEOS v2020
;	Berkeley Softworks / Paul B Murdaugh
;	https://github.com/geos64128/HG2G2020
;	'Patching into interrupt level' example 7-4
;
; =====================================================================================

; Includes
    .include "jumptab.inc"              ; GEOS functions jumptable
    .include "geossym.inc"              ; GEOS symbols
	.include "geosmac.inc"				; GEOS assembly macros

; Exports
	.export _PlayMusic
	.export _StopMusic

; Imports
	.import	_enableIO
    .import _restoreIO
	.import __OVERLAYADDR__

; Data

SIDIRQtmp:
	.res	2

; ---------------------------------------------------------------
; void __near__ _PlayMusic (void)
; ---------------------------------------------------------------

_PlayMusic:
		; init code	(default address is $0903)
		jsr __OVERLAYADDR__					; Jump to SID init routine
		
        ; Hook IRQ pointer into GEOS
		php									; Save current interrupt disable status
        sei									; Stop interupts
		MoveW	intTopVector,SIDIRQtmp		; Save address of current routine
		LoadW	intTopVector,interruptSID	; Install our interrupt routine
		plp									; Restore old interrupt status
        rts       							; Return

; ---------------------------------------------------------------
; void __near__ _StopMusic (void)
; ---------------------------------------------------------------

_StopMusic:
		; restore IRQ vector to kernel interrupt routine
        php									; Save current interrupt disable status
        sei									; Stop interupts
		MoveW	SIDIRQtmp,intTopVector		; Restore old routine
		jsr resetSID						; Reset SID to mute sounds
        plp									; Restore old interrupt status
        rts 								; Return

; ---------------------------------------------------------------

interruptSID:
		; Enable IO
		jsr _enableIO						; Enable IO

		; Play frame
        jsr __OVERLAYADDR__ + 3				; Jump to play frame routine of SID

		; Disable IO
		jsr _restoreIO						; Disable IO

		; do the normal interrupt service routine		
        ldx	SIDIRQtmp+1						; Load high byte of normal IRQ
		lda	SIDIRQtmp						; Load low byte of normal IRW
		jmp	CallRoutine						; Transfer to InterruptMain

; ---------------------------------------------------------------

resetSID:
		; Enable IO
		jsr _enableIO						; Enable IO

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

		; Disable IO
		jsr _restoreIO						; Disable IO

		rts
