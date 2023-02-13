; SpriteSet Data...
; 1 images, 64 bytes per image, total size is 64 ($40) bytes.

* = addr_spriteset_data
spriteset_data

sprite_image_0
.byte $00,$00,$00,$0E,$00,$00,$1F,$00,$00,$3F,$80,$00,$7F,$C0,$00,$7F
.byte $C0,$00,$3F,$80,$00,$1F,$00,$00,$0E,$07,$FC,$1F,$08,$02,$3F,$92
.byte $09,$3F,$97,$1D,$7F,$D2,$09,$7F,$D0,$41,$7F,$D0,$E1,$00,$10,$41
.byte $00,$12,$09,$00,$17,$1D,$00,$12,$09,$00,$08,$02,$00,$07,$FC,$00



; SpriteSet Attribute Data...
; 1 attributes, 1 per image, 8 bits each, total size is 1 ($1) bytes.
; nb. Upper nybbles = MYXV, lower nybbles = colour (0-15).

* = addr_spriteset_attrib_data
spriteset_attrib_data

.byte $00



