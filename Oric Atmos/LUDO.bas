1000 REM --- LUDO LOADER ---
1001 :
1100 HIMEM #6000
2000 CLS
2010 PAPER 0: INK 7: PRINT CHR$(17)
2015 FORX=0TO39:POKE#BB80+X,8:NEXTX
2020 AT$=+CHR$(129)+CHR$(138)
2030 TX$="IDreamtIn8Bits.com"
2040 YC=7: GOSUB 8010
2050 YC=8: GOSUB 8010
2060 AT$=CHR$(135):TX$="presents....": YC =12 : GOSUB 8010
2065 LOAD"LUDOMACO.BIN"
2066 LOAD"MUSIC1.BIN"
2067 CALL#6500
2070 WP=100: GOSUB 8110
2080 HIRES
2090 LOAD "LUDOFOTO.BIN"
2100 WP=200: GOSUB 8110
2130 TEXT: CLS: PRINT CHR$(17)
2140 LOAD "LUDOTITL.BIN"
2145 AT$=CHR$(135):TX$="Press key to continue.": YC =24 : GOSUB 8010
2150 GOSUB 9020
3990 AT$=CHR$(135):TX$="Please wait while loading...": YC =24 : GOSUB 8010
4000 LOAD "LUDOMAIN"
4999 END
8000 :
8001 REM --- CENTER FUNCTION ---
8002 :
8010 PRINT @(20-LEN(AT$)-LEN(TX$)/2),YC;AT$;TX$
8020 RETURN
8100 :
8101 REM --- WAIT FUNCTION WITH KEYPRESS TO CONTINUE ---
8102 :
8110 WC=0
8120 REPEAT
8125 : KE$=KEY$
8130 REM IF KE$ THEN PULL: GOTO 8160
8140 : WC=WC+1
8150 UNTIL WC=WP OR KE$<>""
8160 RETURN
8170 :
9000 REM "--- SCROLLTEXT ---
9010 :
9020 RESTORE
9030 SS$="                                        ":SC$=SS$
9040 REPEAT
9050 : IFLEN(SC$)>45THENGOTO9090
9060 :   READTX$
9070 :   IFTX$="END"THENRESTORE:SC$=SC$+SS$:READTX$
9080 :   SC$=SC$+TX$
9090 : PRINT@0,22;LEFT$(SC$,38)
9100 : SC$=RIGHT$(SC$,LEN(SC$)-1)
9110 : KE$=KEY$
9120 : FORW=1TO10:NEXTW
9130 UNTIL KE$<>""
9140 RETURN
9990 :
10000 REM SCROLLTEXT DATA
10010 :
10020 DATA "LUDO. A game written by Xander Mol. ",
10025 DATA "Original written in 1992 on the Commodore 128. ",
10030 DATA "Converted in 2020 to the Oric Atmos. ",
10035 DATA "Credits: music player and memcopy assembly ",
10040 DATA "code used from OSDK package (Oric Software ",
10045 DATA "Development Kit) maintained by DBug ",
10050 DATA ", code by OSDK authors. Original windowing ",
10055 DATA "system code on Commodore 128 by unknown ",
10060 DATA "author. Music credits: R-Type level 1 by ",
10061 DATA "Wally Beben/Alain Derpin, Axel F by Jochen Hippel/ ",
10062 DATA "Oedipus, Defender of the Crown by David Whittaker/ ",
10063 DATA "Aldn, Wizzball by Peter Johnson/Aldn. "
10064 DATA "Documentation used: OSDK.org , ",
10065 DATA "forum.defence-force.org, defence-force.org. ",
10070 DATA "ORIC software development tooling: OSDK from ",
10075 DATA "DBug/OSDK Authors, CD2 from Twilighte, ",
10080 DATA "Oric Explorer by Scott Davies, ORIC Character ",
10085 DATA "Generater by Pe@ceR, HxCFloppyEmulator Software ",
10090 DATA "by Jean-Francois del Nero. Tooling to transfer "
10095 DATA "original Commodore software code: ",
10100 DATA "VICE by VICE authors, DirMaster by The Wiz/Elwix, ",
10105 DATA "CharPad Free by Subchrist software, ",
10110 DATA "UltimateII+ cartridge by Gideon Zweijtzer. ",
10115 DATA "Tested using Oricuton emulator and an ",
10120 DATA "Oric Atmos with a Cumana Reborn. Thanks for ",
10125 DATA "reading and enjoy playing! Xander Mol             ",
10130 DATA "END"
11000 :
11010 REM END OF LOADER PROGRAM

