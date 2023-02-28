; GeoLudo
; Ludo game for 8 bit computers, GEOS edition
; Written in 2023 by Xander Mol
; 
; https://github.com/xahmol/GeoUTools
; 
; https://www.idreamtin8bits.com/
; 
; Code and resources from others used:
; 
; -   Scott Hutter - GeoUTerm:
;     https://github.com/xlar54/ultimateii-dos-lib/
;     (GeoUTerm as GEOS sample application using this)
; 
; -   CC65 cross compiler:
;     https://cc65.github.io/
; 
; -   Daniel England (Daniel England) - GEOSBuild:
;     https://github.com/M3wP/GEOSBuild
;     (buildtool for GEOS disks)
; 
; -   David Lee - GEOS Image Editor
;     https://www.facebook.com/groups/704637082964003/permalink/5839146806179646
;     (editor for GEOS icons)
; 
; -   Subchrist Software - SpritePad Pro
;     https://subchristsoftware.itch.io/spritepad-c64-pro
;     (editor used for the file icons)
; 
; -   Hitchhikers Guide to GEOS v2020
;     Berkeley Softworks / Paul B Murdaugh
;     https://github.com/geos64128/HG2G2020
; 
; -   Sample sequential application header of GeoProgrammer
;     Berkeley Softworks
; 
; -   Heureks: GEOS64 Programming Examples
;     https://codeberg.org/heurekus/C64-Geos-Programming
;     (sample code using C in CC65 for writing applications in GEOS)
; 
; -   Lyonlabs / Cenbe GEOS resources page:
;     https://www.lyonlabs.org/commodore/onrequest/geos/index.html
; 
; -   Bo Zimmerman GEOS resources page:
;     http://www.zimmers.net/geos/
; 
; -   CBM Files GEOS disk images
;     https://cbmfiles.com/geos/geos-13.php
; 
; -   GEOS - Wheels - GeoWorks - MegaPatch - gateWay - BreadBox Facebook Group
;     https://www.facebook.com/groups/704637082964003/permalink/5839146806179646
; 
; -   Bart van Leeuwen for testing and providing the Device Manager ROM and GEOS RAM Boot
; 
; -   Gideon Zweijtzer for creating the Ultimate II+ cartridge and the Ultimate64, and the Ultimate Command Interface enabling this software.
;    
; -   Tested using real hardware (C128D, C128DCR, Ultimate 64) using GEOS128 2.0, GEOS64 2.0 and Megapatch3 128.
; 
; Licensed under the GNU General Public License v3.0
; 
; The code can be used freely as long as you retain
; a notice describing original source and author.
; 
; THE PROGRAMS ARE DISTRIBUTED IN THE HOPE THAT THEY WILL BE USEFUL,
; BUT WITHOUT ANY WARRANTY. USE THEM AT YOUR OWN RISK!

    .segment "FILEHEADER"
    .import __VLIR0_START__, __STARTUP_RUN__ , __BACKBUFSIZE__ , __STACKADDR__ , __STACKSIZE__,__HIMEM__

; Defines

; GEOS filetypes
NOT_GEOS        = 0
BASIC           = 1
ASSEMBLY        = 2
DATA            = 3
SYSTEM          = 4
DESK_ACC        = 5
APPLICATION     = 6
APPL_DATA       = 7
FONT            = 8
PRINTER         = 9
INPUT_DEVICE    = 10
DISK_DEVICE     = 11
SYSTEM_BOOT     = 12
TEMPORARY       = 13
AUTO_EXEC       = 14
INPUT_128       = 15
NUMFILETYPES    = 16

; Supported structures
SEQUENTIAL      = 0
VLIR            = 1

; DOS filetypes
DEL             = 0
SEQ             = 1
PRG             = 2
USR             = 3
REL             = 4
CBM             = 5

; OS Compatibility flag
CF_40           = $00
CF_40_80        = $40
CF_64           = $80
CF_128          = $C0
	
;Here is our header. The SamSeq.lnk file will instruct the linker
;to attach it to our sample application.

	.word	0			        	    ;first two bytes are always zero
					    	            ;These are replaced with sector
					    	            ;data by build tool.
	.byte	3				            ;Icon width in bytes
	.byte	21				            ;Icon height in scanlines
    .byte   63 | $80                    ;Indicator or format straight uncompacted bitmap
                                        ;of 63 bytes, so 63 with bit 7 set.

    ; Icon data: 63 bytes
    .incbin "ludoicon.bin", 0, 63

	.byte	$80 | USR			        ;Commodore file type, with bit 7 set.
	.byte	APPLICATION		    	    ;Geos file type
	.byte	VLIR    		    	    ;Geos file structure type

	.word	__VLIR0_START__	    	    ;start address of program (where to load to)
	.word	 __VLIR0_START__ - 1        ;usually end address, but only needed for
						                ;desk accessories.
	.word	__STARTUP_RUN__			    ;init address of program (where to JMP to)

    .byte "GeoLudo     "                ;permanent filename: 12 characters
    .byte "V0.1"                        ;4 character version number,
	.byte 0,0,0                         ;3 zeroes
    
    .byte   CF_40_80                    ;OS Compatibility flag

    ; Author name (max 20 char)
    .byte "Xander Mol"                  
	.byte 0
	.res  (63 - 11)                     ; Filling op for:
                                        ;- 20 char author name
                                        ;- 20 bytes parent
                                        ;- 23 app data 

    ; Application description of max 96 chars
    .byte "Ludo game for 8 bit computers, GEOS edition"
    .byte 0

    ; Align to make 256 bytes
    .align  256
