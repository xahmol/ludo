#labels
#optimize

Start:+1:0
    'SCROLLTEXT DATA
    
    DATA "LUDO. A game written by Xander Mol. "
    DATA "Original written in 1992 on the Commodore 128. "
    DATA "Converted in 2020 to the Oric Atmos. "
    DATA "Credits: music player and memcopy assembly "
    DATA "code used from OSDK package (Oric Software "
    DATA "Development Kit) maintained by DBug "
    DATA ", code by OSDK authors. Original windowing "
    DATA "system code on Commodore 128 by unknown "
    DATA "author. Music credits: R-Type level 1 by "
    DATA "Wally Beben/Alain Derpin, Axel F by Jochen Hippel/ "
    DATA "Oedipus, Defender of the Crown by David Whittaker/ "
    DATA "Aldn, Wizzball by Peter Johnson/Aldn. "
    DATA "Documentation used: OSDK.org, "
    DATA "forum.defence-force.org, defence-force.org. "
    DATA "ORIC software development tooling: OSDK from "
    DATA "DBug/OSDK Authors, CD2 from Twilighte, "
    DATA "Oric Explorer by Scott Davies, ORIC Character "
    DATA "Generater by Pe@ceR, HxCFloppyEmulator Software "
    DATA "by Jean-Francois del Nero. Tooling to transfer "
    DATA "original Commodore software code: "
    DATA "VICE by VICE authors, DirMaster by The Wiz/Elwix, "
    DATA "CharPad Free by Subchrist software, "
    DATA "UltimateII+ cartridge by Gideon Zweijtzer. "
    DATA "Tested using Oricuton emulator and an "
    DATA "Oric Atmos with a Cumana Reborn. Thanks for "
    DATA "reading and enjoy playing! Xander Mol             "
    DATA "END"

    '--- LUDO LOADER ---
    
    HIMEM #6000
    CLS
    RESTORE
    PAPER 0: INK 7: PRINT CHR$(17)
    FORX=0 TO 39
        POKE#BB80+X,8
    NEXTX
    AT$=+CHR$(129)+CHR$(138)
    TX$="IDreamtIn8Bits.com"
    YC=7: GOSUB funcCenter
    YC=8: GOSUB funcCenter
    AT$=CHR$(135):TX$="presents....": YC =12 : GOSUB funcCenter
    LOAD"LUDOMACO.BIN"
    LOAD"MUSIC1.BIN"
    CALL #6500
    WP=100: GOSUB funcWaitkey
    HIRES
    LOAD "LUDOFOTO.BIN"
    WP=200: GOSUB funcWaitkey
    TEXT: CLS: PRINT CHR$(17)
    LOAD "LUDOTITL.BIN"
    LOAD "LUDOJOYD.BIN"
    AT$=CHR$(135):TX$="Press key to continue.": YC =24 : GOSUB funcCenter
    GOSUB subScrolltext
    AT$=CHR$(135):TX$="Please wait while loading...": YC =24 : GOSUB funcCenter
    LOAD "LUDOMAIN"
    END
    
    '--- CENTER FUNCTION ---
    
funcCenter
    PRINT @(20-LEN(AT$)-LEN(TX$)/2),YC;AT$;TX$
    RETURN
    
    '--- WAIT FUNCTION WITH KEYPRESS TO CONTINUE ---

funcWaitkey
    WC=0
    REPEAT
        KE$=KEY$
        WC=WC+1
    UNTIL WC=WP OR KE$<>""
    RETURN
    
    '--- SCROLLTEXT ---
    
subScrolltext
    SS$="                                        ": SC$=SS$
    REPEAT
        IF LEN(SC$)>45 THEN GOTO endifScroll1
            READ TX$
            IF TX$="END" THEN RESTORE: SC$=SC$+SS$: READ TX$
            SC$=SC$+TX$
endifScroll1
        PRINT @0,22;LEFT$(SC$,38)
        SC$=RIGHT$(SC$,LEN(SC$)-1)
        KE$=KEY$
        FOR W=1 TO 10
        NEXT W
    UNTIL KE$<>""
    RETURN
  
    'END OF LOADER PROGRAM
