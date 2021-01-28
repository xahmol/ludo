;
#include "libsedoric.h"

; '!' vector
_exvec      = $02f5
; toggle rom on/off
_dosrom     = $04f2
; dos flag
_dosflag    = $04fc
; dos error
_doserr     = $04fd

.text

; _sed_fname  = pointer to filename
; _sed_begin  = Start address
; _sed_end    = End address
; _sed_size   = Size (not used)

_sed_fname  .byt 0,0
_sed_begin  .byt 0,0
_sed_end    .byt 0,0
_sed_size   .byt 0,0
_sed_err    .byt 0,0

savebuf_zp  .dsb 256 ;$b400

; ======================================
; bool sed_savefile(const char* fname, void* buf, int len);
; ======================================
_sed_savefile
.(
            tya
            pha

            jsr sed_savezp
            
            ; -- sei ; disable interrupts

            lda _sed_fname
            sta $e9 ; Filename lo
            lda _sed_fname+1
            sta $ea ; Filename hi

            jsr _dosrom  ; enable/disable OverlayRAM

            ; $0B FTYPE, file type : OPEN "R" (#00) ou "S" (#80) ou "D" (#01)
            lda #1
            sta $0b

            ; enable errors
            lda #$00
            sta $c018

            ; verify filename and copy it to BUFNOM
            clc
            lda #$00
            jsr $d454

            ; Setup Areas
            lda _sed_begin
            sta $c052 ; Start Address Lo
            lda _sed_begin+1
            sta $c053 ; Start Address Hi

            lda _sed_end
            sta $c054   ; End Address Lo
            lda _sed_end+1
            sta $c055   ; End Address Hi

            lda _sed_begin
            sta $c056   ; Execution Address Lo
            lda _sed_begin+1
            sta $c057   ; Execution Address Hi

            ; VSALO0: code pour SAve/LOad b6=1 si ",V" b7=1 si ",N"
            lda #$00    ; #$00 - SAVEO, #$C0 - SAVEU
            sta $c04d

            ; VSALO1: code pour SAve/LOad b6=1 si ",A" b7=1 si ",J"
            lda #$40    ; 0 here means no params
            sta $c04e

            lda #$40    ; file type - data and no auto
            sta $c051

            jsr $de0b   ; set LGSAL0 and call XSAVEB

            jsr _dosrom ; disable Overlay RAM
            ; -- cli    ; re-enable interrupts

            jsr sed_restorezp

            lda _doserr
            sta _sed_err
            lda _doserr+1
            sta _sed_err+1
            pla
            tay
            rts
.)

; ======================================
; bool sed_loadfile(const char* fname, void* buf, int* len);
; ======================================
_sed_loadfile
.(
            tya
            pha
            jsr sed_savezp

            ; -- sei ; disable interrupts
            
            lda _sed_fname
            sta $e9 ; Filename lo
            lda _sed_fname+1
            sta $ea ; Filename hi

            jsr _dosrom  ; enable/disable OverlayRAM

            ; $0B FTYPE, file type : OPEN "R" (#00) ou "S" (#80) ou "D" (#01)
            lda #1
            sta $0b

            ; enable errors
            lda #$00
            sta $c018

            clc
            lda #$00
            jsr $d454 ; verify filename and copy it to BUFNOM

            ; Setup Areas
            lda _sed_begin
            sta $c052 ; Start Address Lo
            lda _sed_begin+1
            sta $c053 ; Start Address Hi

            ; VSALO0: code pour SAve/LOad b6=1 si ",V" b7=1 si ",N"
            lda #$00
            sta $c04d

            ; VSALO1: code pour SAve/LOad b6=1 si ",A" b7=1 si ",J"
            lda #$40
            sta $c04e

            jsr $e0e5 ; XLOADA

            ; Get Areas
            lda $c052
            sta _sed_begin ; Start Address Lo
            lda $c053
            sta _sed_begin+1 ; Start Address Hi

            clc
            lda $c04f
            sta _sed_size
            adc _sed_begin
            sta _sed_end ; End Address Lo
            lda $c050
            sta _sed_size+1
            adc _sed_begin+1
            sta _sed_end+1 ; End Address Lo

            jsr _dosrom ; disable OverlayRAM
            ; -- cli ; re-enable interrupts

            jsr sed_restorezp

            lda _doserr
            sta _sed_err
            lda _doserr+1
            sta _sed_err+1
            pla
            tay
            rts
.)

; ======================================
sed_savezp
.(
            ldx #00
loop
            lda $00,x
            sta savebuf_zp,x
            dex
            bne loop
            rts
.)

; ======================================
sed_restorezp
.(
            ldx #00
loop
            lda savebuf_zp,x
            sta $00,x
            dex
            bne loop
            rts
.)


;_cls
;            jmp $ccce
