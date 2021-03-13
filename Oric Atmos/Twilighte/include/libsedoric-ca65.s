;)
;) Generated with ap65+ v 1.00
;) Copyright iss (C) 2021
;)


.setcpu     "6502"
.smart      on
.autoimport on
.case       on
;
_sed_fname: .byte 0,0
_sed_begin: .byte 0,0
_sed_end: .byte 0,0
_sed_size: .byte 0,0
_sed_err: .byte 0,0
_sed_savefile:
tya
pha
jsr sed_szp
lda _sed_fname
sta $e9
lda _sed_fname+1
sta $ea
jsr $04f2
lda #1
sta $0b
lda #$00
sta $c018
clc
lda #$00
jsr $d454
lda _sed_begin
sta $c052
lda _sed_begin+1
sta $c053
lda _sed_end
sta $c054
lda _sed_end+1
sta $c055
lda _sed_begin
sta $c056
lda _sed_begin+1
sta $c057
lda #$00
sta $c04d
lda #$40
sta $c04e
lda #$40
sta $c051
jsr $de0b
jmp sed_exit
_sed_loadfile:
tya
pha
jsr sed_szp
lda _sed_fname
sta $e9
lda _sed_fname+1
sta $ea
jsr $04f2
lda #1
sta $0b
lda #$00
sta $c018
clc
lda #$00
jsr $d454
lda _sed_begin
sta $c052
lda _sed_begin+1
sta $c053
lda #<$4000
sta $c04d
lda #>$4000
sta $c04e
jsr $e0e5
lda $c052
sta _sed_begin
lda $c053
sta _sed_begin+1
clc
lda $c04f
sta _sed_size
adc _sed_begin
sta _sed_end
lda $c050
sta _sed_size+1
adc _sed_begin+1
sta _sed_end+1
sed_exit: jsr $04f2
sed_rzp: ldx #00
sed_rzp_lp: lda savebuf_zp,x
sta $00,x
dex
bne sed_rzp_lp
lda $04fd
sta _sed_err
lda $04fd+1
sta _sed_err+1
pla
tay
rts
sed_szp: ldx #00
sed_szp_lp: lda $00,x
sta savebuf_zp,x
dex
bne sed_szp_lp
rts
savebuf_zp: .res 256
.export _sed_fname
.export _sed_begin
.export _sed_end
.export _sed_size
.export _sed_err
.export _sed_savefile
.export _sed_loadfile
