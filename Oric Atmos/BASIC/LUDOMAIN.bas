#labels
#optimize

Start:+1:0

'L U D O   MAIN PROGRAM

'WRITTEN BY XANDER MOL
'CONVERTED TO ORIC ATMOS
'IN 2020
'ORIGINAL WRITTEN IN 1992
'FOR COMMODORE 128
'(C)2020 IDREAMTIN8BITS.COM
    
'GAME DATA
    
'PAWN POSITION CO-ORDS MAIN
    DATA  2,13,  5,13,  8,13, 11,13, 14,13
    DATA 14,11, 14, 9, 14, 7, 14, 5, 17, 5
    DATA 20, 5, 20, 7, 20, 9, 20,11, 20,13
    DATA 23,13, 26,13, 29,13, 32,13, 32,15
    DATA 32,17, 29,17, 26,17, 23,17, 20,17
    DATA 20,19, 20,21, 20,23, 20,25, 17,25
    DATA 14,25, 14,23, 14,21, 14,19, 14,17
    DATA 11,17,  8,17,  5,17,  2,17,  2,15
    
'PAWN POS CO-ORDS START AND DEST
    DATA  2, 5,  5, 5,  2, 7,  5, 7,  5,15,  8,15, 11,15, 14,15
    DATA 29, 5, 32, 5, 29, 7, 32, 7, 17, 7, 17, 9, 17,11, 17,13
    DATA 29,23, 32,23, 29,25, 32,25, 29,15, 26,15, 23,15, 20,15
    DATA  2,23,  5,23,  2,25,  5,25, 17,23, 17,21, 17,19, 17,17
    
'PLAYER COLORS
    DATA 2,1,4,3
    
'DICE PRINT STRINGS
    DATA 188,189,190,191
    DATA 192,193,193,194
    DATA 195,189,190,196
    DATA 192,197,198,194
    DATA 195,199,200,196
    DATA 201,201,202,202
    
'MENU DATA
    
    DATA 4,3
    DATA "Game",3,"Throw dice","Restart","Stop"
    DATA "Disc",2,"Save game","Load game"
    DATA "Music",3,"Next","Stop","Restart"
    DATA "Information",1,"Credits"
    DATA 2,"Yes","No"
    DATA 2,"Restart","Stop"
    DATA 3,"Continue game","New game","Stop"

'GAME CODE START
    
    RANDOM
    B$="": O$=""
    FOR C=1 TO 40
      B$=B$+CHR$(94): O$=O$+CHR$(93)
    NEXT C
    CI$="0123456789"
    LC$="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"+CI$
    AL$=LC$+" !#$%&'()"+CHR$(34)+"+-@*^:[;]=,<.>/?_"
    RESTORE
    S$="                                        "
    AD=#A100:WN=1: DIM WI(10,2): MU=1: CC=0
    GOSUB subIJKDetect
    GOSUB subInitialisation
    GOSUB subReadmenudata
    XC=18: YC=8: B=20: H=6: GOSUB funcMenumakeborder
    PRINT @20,10;CHR$(131);"Load old game?";CHR$(129)
    XC=27: YC=11: MN=5: GOSUB funcMenupulldown
    GOSUB funcWindowrestore
    IF M=1 THEN GOSUB subLoadgame
    
'MAIN GAMELOOP
    
    REPEAT
        GOSUB subLoadmainscreen
        IF EI<>2 THENGOSUB subGamereset: GOSUB subInputofnames: GOTO endifMain1
            EI=0: GOSUB subPlacepawnsafterload
endifMain1
        REPEAT
            PRINT @0,2;LEFT$(S$,39): PRINT @0,3;LEFT$(S$,39)
            PRINT @0,4;LEFT$(S$,39)
            PRINT @0,2;CHR$(131);"Player";CHR$(134);BS+1;CHR$(131);": ";
            PRINT CHR$(144+SP(BS,2));" ";CHR$(144)
            PRINT @0,3;CHR$(130);SP$(BS);CHR$(131);LEFT$(S$,10)
            IF SP(BS,0)=0 THEN GOSUB subTurnhuman: GOTO endifMain2
                PRINT @0,4;CHR$(131);"Computer is playing."
endifMain2
            IF EI<>0 THEN PULL: GOTO exitMain1
            GOSUB subTurngeneric
            IF SP(BS,1)=0 THEN GOSUB subPlayerwins
            IF EI<>0 THEN PULL: GOTO exitMain1
            REPEAT
                IF ZV=1 THEN ZV=0:GOTO endifMain3
                    NP(NS)=-1:BS=BS+1:IFBS>3THENBS=0
endifMain3
            UNTIL (ZV<>0 OR SP(BS,1)<>0)
        UNTIL EI<>0
exitMain1
    UNTIL EI=1
    GOTO subGameend

'LOAD MAIN SCREEN

subLoadmainscreen
    LOAD "LUDOSCRM.BIN"
    GOSUB funcMenuplacebar
    RETURN

'INITIALISATION

subInitialisation
    DIM VC(39,1),RC(3,7,1),SP$(3),SP(3,3),DN$(5,1),SC(3,3,1)
    DIM PM(3),NP(3),PW(3)
    FOR N=0 TO 39
        READ VC(N,0),VC(N,1)
    NEXT N
    FOR N=0 TO 3
        FOR M=0 TO 7
            READ RC(N,M,0),RC(N,M,1)
        NEXT M
    NEXT N
    FOR N=0 TO 3
        READ SP(N,2)
    NEXT N
    FOR N=0 TO 5
        READ A,B,C,D: DN$(N,0)=CHR$(A)+CHR$(B): DN$(N,1)=CHR$(C)+CHR$(D)
    NEXT N
    RETURN

'CO-ORDINATES OF PAWN

funcPawncoords
    IF SC(BS,PN,0)<>0 THEN GOTO endifPawncoords1
    XC=VC(SC(BS,PN,1),0): YC=VC(SC(BS,PN,1),1)
    GOTO endifPawncoords2
endifPawncoords1
    XC=RC(BS,SC(BS,PN,1),0): YC=RC(BS,SC(BS,PN,1),1)
endifPawncoords2
    RETURN

'ERASE PAWN

funcPawnerase
    GOSUB funcPawncoords
    IF SC(BS,PN,0)=0 AND SC(BS,PN,1)/10=INT(SC(BS,PN,1)/10) THEN GOTO endifPawnerase1
    'NORMAL WHITE FIELD MAIN TRACK
    IF SC(BS,PN,0)<>0 THEN GOTO endifPawnerase2
        PRINT @XC-1,YC;CHR$(135);" !"
        PRINT @XC-1,YC+1;CHR$(135);CHR$(34);"#";
        GOTO exitPawnerase
    'COLORED HOME OR DEST FIELD
endifPawnerase2
        PRINT @XC-1,YC;CHR$(128+SP(BS,2));"$%"
        PRINT @XC-1,YC+1;CHR$(128+SP(BS,2));"&";CHR$(39);
        GOTO exitPawnerase
    'COLORED START FIELDS
endifPawnerase1
    IF SC(BS,PN,1)<>0 THEN GOTO endifPawnerase3
        PRINT @XC-1,YC;CHR$(130);",-"
        PRINT @XC-1,YC+1;CHR$(130);"./";
        GOTO exitPawnerase
endifPawnerase3
    IF SC(BS,PN,1)<>10 THEN GOTO endifPawnerase4
        PRINT @XC-1,YC;CHR$(129);"01"
        PRINT @XC-1,YC+1;CHR$(129);"23";
        GOTO exitPawnerase
endifPawnerase4
    IF SC(BS,PN,1)<>20 THEN GOTO endifPawnerase5
        PRINT @XC-1,YC;CHR$(132);"45"
        PRINT @XC-1,YC+1;CHR$(132);"67";
        GOTO exitPawnerase
endifPawnerase5
    IF SC(BS,PN,1)<>30 THEN GOTO exitPawnerase
        PRINT @XC-1,YC;CHR$(131);"89"
        PRINT @XC-1,YC+1;CHR$(131);":;";
exitPawnerase
    RETURN

'PLACE PAWN

funcPawnplace
    GOSUB funcPawncoords
    IF CC=1 THEN GOTO endifPawnplace1
        PRINT @XC-1,YC;CHR$(128+SP(BS,2));"()"
        PRINT @XC-1,YC+1;CHR$(128+SP(BS,2));"*+";
        GOTO exitPawnplace
endifPawnplace1
        PRINT @XC-1,YC;CHR$(135);"()"
        PRINT @XC-1,YC+1;CHR$(135);"*+";
exitPawnplace
    RETURN

'THROW DICE

funcDicethrow
    XC=30: YC=12: B=8: H=6: GOSUB funcMenumakeborder
    PRINT @32,14;CHR$(27);"I";CHR$(135);CHR$(160);CHR$(160);
    PRINT CHR$(129);CHR$(27);"H"
    PRINT @32,15;CHR$(27);"I";CHR$(135);CHR$(160);CHR$(160);
    PRINT CHR$(129);CHR$(27);"H"
    FOR N=1 TO 10
        DG=INT(RND(1)*6)+1
        PLOT 34,14,DN$(DG-1,0): PLOT 34,15,DN$(DG-1,1)
        FOR W=1 TO 10
            NEXT W
    NEXT N
    PRINT @32,17;CHR$(131);"Key.";CHR$(129)
    GOSUB funcWaitkey: GOSUB funcWindowrestore
    RETURN

'INPUT OF NAMES

subInputofnames
    XC=4: YC=8: B=34: H=6: GOSUB funcMenumakeborder
    FOR SP=0 TO 3
        PRINT @6,10;CHR$(131);"Computer plays for player";CHR$(134);
        PRINT SP+1;CHR$(131);"?";CHR$(129)
        XC=28: YC=11: MN=5: GOSUB funcMenupulldown
        IF M=1 THEN SP(SP,0)=1 ELSE SP(SP,0)=0
        PRINT @6,10;CHR$(131);"Input name for player";CHR$(134);
        PRINT SP+1;CHR$(131);":    ";CHR$(129)
        XC=6: YC=12: ML=20: TT$=AL$: GOSUB funcInput: SP$(SP)=AN$
    NEXT SP
    GOSUB funcWindowrestore
    RETURN

'GAME RESET

subGamereset
    BS=0: EI=0
    FOR N=0 TO 3
        SP(N,1)=4: SP(N,3)=4: NP(N)=-1: DP(N)=8
        FOR M=0 TO 3
            SC(N,M,0)=1: SC(N,M,1)=M
        NEXT M
    NEXT N
    RETURN

'INFORMATION: CREDITS

subInformationcredits
    XC=2: YC=8: B=36: H=11: GOSUB funcMenumakeborder: B=B-1
    PRINT @4,10;CHR$(134);: CT$="L U D O"
    GOSUB funcPrintcentered: PRINT CHR$(129)
    PRINT @4,11;CHR$(131);: CT$="Written by Xander Mol"
    GOSUB funcPrintcentered: PRINT CHR$(129)
    PRINT @4,12;CHR$(131);: CT$="Converted to Oric Atmos, 2020"
    GOSUB funcPrintcentered: PRINT CHR$(129)
    PRINT @4,13;CHR$(131);: CT$="Original on Commodore 128, 1992"
    GOSUB funcPrintcentered: PRINT CHR$(129)
    PRINT @4,14;CHR$(131);: CT$="Build with and using code of"
    GOSUB funcPrintcentered: PRINT CHR$(129)
    PRINT @4,15;CHR$(131);: CT$="OSDK,"+CHR$(96)+" DBug and OSDK authors."
    GOSUB funcPrintcentered: PRINT CHR$(129)
    PRINT @4,17;CHR$(130);: CT$="Press a key."
    GOSUB funcPrintcentered: PRINT CHR$(129)
    GOSUB funcWaitkey: GOSUB funcWindowrestore
    RETURN

'QUESTION: ARE YOU SURE?

funcAreyousure
    XC=8: YC=8: B=30: H=6: GOSUB funcMenumakeborder
    PRINT @10,10;CHR$(131)"Are you sure ?";CHR$(129);
    XC=25: YC=11: MN=5: GOSUB funcMenupulldown
    GOSUB funcWindowrestore
    RETURN
    
'TURN HUMAN PLAYER
    
subTurnhuman
    REPEAT
        GOSUB funcMenumain
        IF MN=1 AND M=2 THEN GOSUB funcAreyousure: IF M=1 THEN EI=3: PULL: GOTO exitTurnhuman
        IF MN=1 AND M=3 THEN GOSUB funcAreyousure: IF M=1 THEN EI=1: PULL: GOTO exitTurnhuman
        IF MN=2 AND M=1 THEN GOSUB subSavegame: M=1
        IF MN=2 AND M=2 THEN GOSUB funcAreyousure: IF M=1 THEN GOSUB subLoadgame: PULL: GOTO exitTurnhuman
        IF MN=3 AND M=1 THEN GOSUB subMusicnext
        IF MN=3 AND M=2 THEN CALL #6503
        IF MN=3 AND M=3 THEN CALL #6503: CALL #6500
        IF MN=4 AND M=1 THEN GOSUB subInformationcredits
    UNTIL MN=1 AND M=1
exitTurnhuman
    RETURN

'TURN GENERIC

subTurngeneric
    GA=1: GB=0: MP=0: PN=-1: AP=0: ZV=0
    FOR N=0 TO 3
        PM(N)=0
    NEXT N
    IF SP(BS,3)=SP(BS,1) THEN GA=3: PRINT @21,3;CHR$(131);"Throw 3 times."
    FOR D=1 TO GA
      GOSUB funcDicethrow
      IF DG=6 THEN D=GA
    NEXT D
    PRINT @21,3;LEFT$(S$,15)
    IF SP(BS,3)=SP(BS,1) AND DG<>6 THEN GB=1
    IF NP(BS)<0 THEN GOTO endifTurngeneric1
        IF SP(BS,3)>0 THEN PN=NP(BS): NP(BS)=-1: GOTO endifTurngeneric1
            NP(BS)=-1
endifTurngeneric1
    IF GB<>0 OR PN<>-1 THEN GOTO endifTurngeneric2
        FOR N=0 TO 3
            VR=SC(BS,N,0): VL=SC(BS,N,1): GV=0
            IF VR=1 AND VL<4 THEN GV=1: IF DG=6 THEN PN=N: NP(BS)=N: N=3
            IF GV<>0 THEN GOTO endifTurngeneric3
                VN=VL+DG:NR=VR
                IF VR<>0 THEN GOTO endifTurngeneric4
                    IF BS=0 AND VN>39 AND VL<40 THEN VN=VN-36: NR=1
                    IF BS=1 AND VN>9 AND VL<10 THEN VN=VN-6: NR=1
                    IF BS=2 AND VN>19 AND VL<20 THEN VN=VN-16: NR=1
                    IF BS=3 AND VN>29 ANDVL<30 THEN VN=VN-26: NR=1
endifTurngeneric4
                IF NR<>1 THEN GOTO endifTurngeneric5
                IF VN>7 THEN GV=1: GOTO endifTurngeneric5
                    FOR M=0 TO 3
                         IF N<>M AND SC(BS,M,0)=1 AND SC(BS,M,1)<=VN AND SC(BS,M,1)>3 THEN GV=1: M=3
                    NEXT M
endifTurngeneric5
                IF GV=0 THEN PM(N)=1
endifTurngeneric3
        NEXT N
endifTurngeneric2
    IF PN<>-1 THEN GOTO endifTurngeneric6
        FOR N=0 TO 3
            IF PM(N)=1 THEN AP=AP+1: PN=N
        NEXT N
        GOTO endifTurngeneric7
endifTurngeneric6
        AP=1
endifTurngeneric7
    IF AP<=1 THEN GOTO endifTurngeneric8
    IF SP(BS,0)=0 THEN GOSUB subHumanchoosepawn ELSE GOSUB subComputerchoosepawn
endifTurngeneric8
    IF DG=6 THEN ZV=1
    IF AP<>0 AND GB<>1 THEN GOTO endifTurngeneric9
        PRINT @21,2;CHR$(131);"No move possible"
        PRINT @21,3;CHR$(131);"Press key"
        GOSUB funcWaitkey
        RETURN
endifTurngeneric9
    GOSUB funcPawnerase
    OV=SC(BS,PN,1): RO=SC(BS,PN,0)
    IF RO<>1 OR OV>=4 THEN GOTO endifTurngeneric10
        SC(BS,PN,0)=0: SC(BS,PN,1)=BS*10: SP(BS,3)=SP(BS,3)-1
        GOTO endifTurngeneric11
endifTurngeneric10
    SC(BS,PN,1)=SC(BS,PN,1)+DG
endifTurngeneric11
    IF BS<>0 OR SC(BS,PN,1)<=39 OR OV>=40 OR RO<>0 THEN GOTO endifTurngeneric12
        SC(BS,PN,0)=1: SC(BS,PN,1)=SC(BS,PN,1)-36
endifTurngeneric12
    IF BS<>1 OR SC(BS,PN,1)<=9 OR OV>=10 OR RO<>0 THEN GOTO endifTurngeneric13
        SC(BS,PN,0)=1: SC(BS,PN,1)=SC(BS,PN,1)-6
endifTurngeneric13
    IF BS<>2 OR SC(BS,PN,1)<=19 OR OV>=20 OR RO<>0 THEN GOTO endifTurngeneric14
        SC(BS,PN,0)=1: SC(BS,PN,1)=SC(BS,PN,1)-16
endifTurngeneric14
    IF BS<>3 OR SC(BS,PN,1)<=29 OR OV>=30 OR RO<>0 THEN GOTO endifTurngeneric15
        SC(BS,PN,0)=1: SC(BS,PN,1)=SC(BS,PN,1)-26
endifTurngeneric15
    IF SC(BS,PN,0)=1 AND SC(BS,PN,1)>3 THEN DP(BS)=SC(BS,PN,1)
    IF SC(BS,PN,1)=SP(BS,1)+3 AND SC(BS,PN,0)=1 THEN SP(BS,1)=SP(BS,1)-1
    IF SC(BS,PN,1)>39 THEN SC(BS,PN,1)=SC(BS,PN,1)-40
    AP=0: AS=-1
    FOR SP=0 TO 3
        FOR PO=0 TO 3
            IF PO=PN AND SP=BS THEN GOTO endifTurngeneric16
                IF SC(SP,PO,0)<>0 OR SC(BS,PN,0)<>0 THEN endifTurngeneric16
                    IF SC(SP,PO,1)=SC(BS,PN,1) THEN AP=PO: AS=SP: PO=3: SP=3
endifTurngeneric16
        NEXT PO
    NEXT SP
    IF AS=-1 THEN GOTO endifTurngeneric17
        H1=BS: H2=PN
        BS=AS: PN=AP
        GOSUB funcPawnerase
        SC(BS,PN,0)=1: SC(BS,PN,1)=PN: SP(BS,3)=SP(BS,3)+1
        GOSUB funcPawnplace
        BS=H1: PN=H2
endifTurngeneric17
    GOSUB funcPawnplace
    RETURN

'HUMAN PLAYER CHOOSE PAWN

subHumanchoosepawn
    XC=20: YC=1: B=18: H=2: GOSUB funcMenumakeborder
    PRINT @22,2;CHR$(131);"Which pawn?";CHR$(129)
    PRINT @22,3;CHR$(131);"Thrown:";DG;CHR$(129)
    PN=0
    REPEAT
        PN=PN+1
    UNTIL PM(PN)=1
    REPEAT
        CC=1: GOSUB funcPawnplace: CC=0
        JM=1:TT$=CHR$(8)+CHR$(9)+CHR$(10)+CHR$(11)+CHR$(13)
        TJ$="1111":GOSUB funcGetkey
        GOSUB funcPawnplace
        IF AW$=CHR$(8) OR AW$=CHR$(10) OR JL=1 OR JD=1 THEN PN=PN-1: RI=-1
        IF AW$=CHR$(9) OR AW$=CHR$(11) OR JR=1 OR JU=1 THEN PN=PN+1: RI=1
        IF AW$=CHR$(13) OR JF=1 THEN PULL: GOTO exitHumanchoosepawn
        IF PN>3 THEN PN=0
        IF PN<0 THEN PN=3
        REPEAT
            IF PM(PN)=1 THEN PULL:GOTO endrepeatHumanchoosepawn1
            PN=PN+RI
            IF PN>3 THEN PN=0
            IF PN<0 THEN PN=3
        UNTIL PM(PN)=1
endrepeatHumanchoosepawn1
    UNTIL AW$=CHR$(13)
exitHumanchoosepawn
    GOSUB funcWindowrestore
    RETURN

'SAVE GAME

subSavegame
    XC=8: YC=8: B=30: H=7: GOSUB funcMenumakeborder
    PRINT @10,10;CHR$(130);"Save game.";CHR$(129)
    PRINT @10,12;CHR$(131);"Enter filename:";CHR$(129)
    XC=10: YC=14: ML=8: TT$=AL$: GOSUB funcInput: GOSUB funcWindowrestore: IF AN$="" THEN RETURN
    AN$=AN$+".SAV"
    ERR SET: ERRGOTO errorSavegame
    SEARCH AN$
    IF EF=0 THEN GOTO endifSavegame1
        XC=8: YC=8: B=30: H=8: GOSUB funcMenumakeborder
        PRINT @10,10;CHR$(131);"Filename exists.";CHR$(129)
        PRINT @10,11;CHR$(131);"Replace?";CHR$(129)
        XC=15: YC=13: MN=5: GOSUB funcMenupulldown
        GOSUB funcWindowrestore
        IF M=2 THEN RETURN
endifSavegame1
    AS=#B001
    POKE #B000,BS
    FOR N=0 TO 3
        IF NP(N)<0 THEN POKEAS,256+NP(N) ELSE POKE AS,NP(N)
        AS=AS+1
    NEXT N
    FOR N=0 TO 3
        FOR M=0 TO 3
            POKE AS,SP(N,M): AS=AS+1
        NEXT M
    NEXT N
    FOR N=0 TO 3
        FOR M=0 TO 3
            POKE AS,SC(N,M,0): AS=AS+1
            POKE AS,SC(N,M,1): AS=AS+1
        NEXT M
    NEXT N
    FOR N=0 TO 3
        POKE AS,LEN(SP$(N)): AS=AS+1
        FOR M=1 TO LEN(SP$(N))
            POKE AS,ASC(MID$(SP$(N),M,1)): AS=AS+1
        NEXT M
    NEXT N
    SAVEO AN$,A#B000,E#B100
    ERR OFF
    RETURN
'ERROR HANDLING
errorSavegame
    GOSUB funcDiscerror
    ERR OFF
    RETURN

'LOAD GAME

subLoadgame
    XC=8: YC=8: B=30: H=8
    GOSUB funcMenumakeborder
    PRINT @10,10;CHR$(131);"Load game.";CHR$(129)
    PRINT @10,12;CHR$(131);"Filename (without .SAV):";CHR$(129)
    XC=10: YC=14: ML=8: TT$=AL$: GOSUB funcInput: GOSUB funcWindowrestore: IF AN$="" THEN RETURN
    AN$=AN$+".SAV"
    ERR SET: ERRGOTO errorLoadgame
    SEARCH AN$
    IF EF<>0 THEN GOTO endifLoadgame1
        XC=8: YC=8: B=30: H=6: GOSUB funcMenumakeborder
        PRINT @10,10;CHR$(131);"File not found.";CHR$(129)
        PRINT @10,11;CHR$(131);"Press key.";CHR$(129): GOSUB funcWaitkey
        GOSUB funcWindowrestore
        RETURN
endifLoadgame1
    LOAD AN$
    BS=PEEK(#B000): AS=#B001
    FOR N=0 TO 3
        NP(N)=PEEK(AS): AS=AS+1
        IF NP(N)>127 THEN NP(N)=-(256-NP(N))
    NEXT N
    FOR N=0 TO 3
        FOR M=0 TO 3
            SP(N,M)=PEEK(AS): AS=AS+1
        NEXT M
    NEXT N
    FOR N=0 TO 3
        FOR M=0 TO 3
            SC(N,M,0)=PEEK(AS): AS=AS+1
            SC(N,M,1)=PEEK(AS): AS=AS+1
        NEXT M
    NEXT N
    FOR N=0 TO 3
        ML=PEEK(AS): AS=AS+1
        SP$(N)=""
        FOR M=1 TO ML
            SP$(N)=SP$(N)+CHR$(PEEK(AS)): AS=AS+1
        NEXT M
    NEXT N
    EI=2
    ERR OFF
    RETURN
    'ERROR HANDLING
errorLoadgame
    GOSUB funcDiscerror: ERR OFF
    RETURN

'PLACE PAWNS AFTER LOAD

subPlacepawnsafterload
    H1=BS
    FOR BS=0 TO 3
        FOR PN=0 TO 3
            H2=SC(BS,PN,0): H3=SC(BS,PN,1)
            SC(BS,PN,0)=1: SC(BS,PN,1)=PN
            GOSUB funcPawnerase
            SC(BS,PN,0)=H2: SC(BS,PN,1)=H3
            GOSUB funcPawnplace
        NEXT PN
    NEXT BS
    BS=H1
    RETURN

'A PLAYER HAS WON THE GAME

subPlayerwins
    XC=3: YC=8: B=35: H=9: GOSUB funcMenumakeborder
    PRINT @5,10;CHR$(130);SP$(BS);CHR$(131);" has won the game!";
    PRINTCHR$(129)
    PRINT @5,12;CHR$(131);"What do you want?";CHR$(129)
loopInvalidchoice
    XC=15: YC=13: MN=7: GOSUB funcMenupulldown
    IF M=1 AND SP(0,1)=0 AND SP(1,1)=0 AND SP(2,1)=0 AND SP(3,1)=0 THEN GOTO loopInvalidchoice
    IF M=2 THEN EI=3: ZV=1
    IF M=3 THEN EI=1: ZV=1
    GOSUB funcWindowrestore
    RETURN

'CHOOSE PAWN COMPUTER PLAYER

subComputerchoosepawn
    FOR N=0 TO 3
        PW(N)=0
    NEXT N
    FOR N=0 TO 3
        IF PM(N)=0 THEN PW(N)=-10000:GOTO exitComputerchoosepawnloop
        VR=SC(BS,N,0): VN=SC(BS,N,1)
        NN=VN+DG: NO=NN: NR=VR
        IF VR<>0 THEN GOTO endifComputerchoosepawn1
            IF BS=0 AND NN>39 AND VN<40 THEN NN=NN-36: NR=1
            IF BS=1 AND NN>9 AND VN<10 THEN NN=NN-6: NR=1
            IF BS=2 AND NN>19 AND VN<20 THEN NN=NN-16: NR=1
            IF BS=3 AND NN>29 AND VN<30 THEN NN=NN-26: NR=1
endifComputerchoosepawn1
        IF NR=0 AND NN>39 THEN NN=NN-40
        IF NR=1 AND NN>3 AND SP(BS,1)=1 THENPW(N)=10000: N=3: GOTO exitComputerchoosepawnloop
        IF NR=1 AND NN>3 THEN PW(N)=PW(N)+6000
        FOR SP=0 TO 3
            FOR PO=0 TO 3
                IF BS=SP AND SC(SP,PO,0)=NR AND SC(SP,PO,1)=NN THEN PW(N)=PW(N)-8000
                IF BS=SP OR SC(SP,PO,0)<>NR OR SC(SP,PO,1)<>NN THEN GOTO endifComputerchoosepawn2
                    PW(N)=PW(N)+4000
                    IF SC(SP,PO,0)<>0 THEN GOTO endifComputerchoosepawn2
                        IF SP=0 AND SC(SP,PO,1)>33 THEN PW(N)=PW(N)+3000
                        IF SP=1 AND SC(SP,PO,1)>3 THEN PW(N)=PW(N)+3000
                        IF SP=2 AND SC(SP,PO,1)>13 THEN PW(N)=PW(N)+3000
                        IF SP=3 AND SC(SP,PO,1)>23 THEN PW(N)=PW(N)+3000
endifComputerchoosepawn2
                IF SC(SP,PO,0)<>0 OR NR<>0 OR BS=SP THEN GOTO endifComputerchoosepawn3
                    IF (VN-SC(SP,PO,1))<6 AND (VN-SC(SP,PO,1))>0 THEN PW(N)=PW(N)+400
                    IF (NO-SC(SP,PO,1))<6 AND (NO-SC(SP,PO,1))>0 THEN PW(N)=PW(N)-200
                    IF (SC(SP,PO,1)-NN)<6 AND (SC(SP,PO,1)-NN)>0 THEN PW(N)=PW(N)+100
endifComputerchoosepawn3
            NEXT PO
        NEXT SP
        IF NR=0 AND (NN=0 OR NN=10 OR NN=20 OR NN=30) THEN PW(N)=PW(N)-4000
        IF VR=0 AND (VN=0 OR VN=10 OR VN=20 OR VN=30) THEN PW(N)=PW(N)+2000
        IF BS=0 THEN PW(N)=PW(N)+NN
        IF BS=1 THEN PW(N)=PW(N)+(NO-10)
        IF BS=2 THEN PW(N)=PW(N)+(NO-20)
        IF BS=3 THEN PW(N)=PW(N)+(NO-30)
exitComputerchoosepawnloop
    NEXT N
    MW=-20000
    FOR N=0 TO 3
        IF PW(N)>MW THEN MW=PW(N): PN=N
    NEXT N
    RETURN

'READ MENUDATA

subReadmenudata
    READ MN,DN
    DIM MN$(MN+DN+2,16),MN(MN+DN+2),MC(MN,1)
    MC=1: MN(0)=MN
    FOR N=1 TO MN(0)
        READ MN$(N,0)
        READ MN(N)
        MC(N,0)=MC:MC(N,1)=MC+LEN(MN$(N,0)):MC=MC(N,1)+1:ML=0
        FOR M=1 TO MN(N)
            READ MN$(N,M)
            IF LEN(MN$(N,M))>ML THEN ML=LEN(MN$(N,M))
        NEXT M
        FOR M=1 TO MN(N)
            MN$(N,M)=MN$(N,M)+LEFT$(S$,ML-LEN(MN$(N,M)))
        NEXT M
    NEXT N
    FOR N=1 TO DN
        READ MN(MN(0)+N):ML=0
        FOR M=1 TO MN(MN(0)+N)
            READ MN$(MN(0)+N,M)
            IF LEN(MN$(MN(0)+N,M))>ML THEN ML=LEN(MN$(MN(0)+N,M))
        NEXT M
        FOR M=1 TO MN(MN(0)+N)
            MN$(MN(0)+N,M)=MN$(MN(0)+N,M)+LEFT$(S$,ML-LEN(MN$(MN(0)+N,M)))
        NEXT M
    NEXT N
    RETURN

'PLACE MENU BAR

funcMenuplacebar
    PRINT @0,0;CHR$(128);CHR$(146);
    FOR N=1 TO MN(0)
        PRINT MN$(N,0);" ";
    NEXT N
    RETURN

'SAVE SCREEN

funcWindowsave
    WI(WN,0)=AD: WI(WN,1)=YC-1: WI(WN,2)=H+3
    MOVE #BBA8+WI(WN,1)*40,#BBA8+(WI(WN,1)+WI(WN,2))*40,WI(WN,0)
    AD=AD+WI(WN,2)*40:WN=WN+1
    RETURN

'LOAD SCREEN BACK

funcWindowrestore
    WN=WN-1: AD=WI(WN,0)
    MOVE WI(WN,0),WI(WN,0)+WI(WN,2)*40,#BBA8+WI(WN,1)*40
    RETURN

'MENU

funcMenupulldown
    H=MN(MN)+2
    GOSUB funcWindowsave
    IF MN<=MN(0) THEN GOTO endifMenupulldown1
        PRINT @XC,YC;CHR$(129);CHR$(125);LEFT$(B$,4+LEN(MN$(MN,1)))
endifMenupulldown1
    FOR N=1 TO MN(MN)
        PRINT @XC,YC+N;CHR$(129);CHR$(91);CHR$(150);CHR$(128);
        PRINT MN$(MN,N);CHR$(129);CHR$(91);CHR$(144)
    NEXT N
    PRINT @XC,YC+N;CHR$(129);CHR$(123);LEFT$(O$,4+LEN(MN$(MN,1)));
    M=1:TT$=CHR$(11)+CHR$(10)+CHR$(13):TJ$="0011"
    IF MN<=MN(0) THEN TT$=TT$+CHR$(8)+CHR$(9):TJ$="1111"
    EX=0
    REPEAT
        PRINT @XC+2,YC+M;CHR$(147);CHR$(128);MN$(MN,M);
        PRINT CHR$(129);CHR$(91);CHR$(144)
        JM=1: GOSUB funcGetkey: JM=0
        IF AW$=CHR$(13) OR JF=1 THEN EX=1
        IF AW$=CHR$(8) OR JL=1 THEN M=0: EX=1: GOTO endifMenupulldown2
        IF AW$=CHR$(9) OR JR=1 THEN M=0: EX=1: GOTO endifMenupulldown2
        IF EX<>0 THEN GOTO endifMenupulldown2
            PRINT @XC+2,YC+M;CHR$(150);CHR$(128);MN$(MN,M);
            PRINT CHR$(129);CHR$(91);CHR$(144)
            IF AW$=CHR$(11) OR JU=1 THEN M=M-1
            IF AW$=CHR$(10) OR JD=1 THEN M=M+1
            IF M>MN(MN) THEN M=1
            IF M<1 THEN M=MN(MN)
endifMenupulldown2
    UNTIL EX=1
    GOSUB funcWindowrestore
    RETURN

'ASK FOR KEYPRESS OR JOYSTICK

funcGetkey
    AW$=""
    REPEAT
        AW$=KEY$: INSTR TT$,AW$,1
        IF JM=1 THEN GOSUB subIJKRead
    UNTIL (IN>0 OR JF=1 OR JL=1 OR JR=1 OR JU=1 OR JD=1)
    RETURN

'MAIN MENU

funcMenumain
    MN=1: M=0
    REPEAT
        REPEAT
            PRINT @MC(MN,0),0;CHR$(151);MN$(MN,0);CHR$(146)
            TT$=CHR$(8)+CHR$(9)+CHR$(13):TJ$="1100"
            JM=1:GOSUB funcGetkey:JM=0
            PRINT @MC(MN,0),0;CHR$(146);MN$(MN,0);
            IF AW$=CHR$(8) OR JL=1 THEN MN=MN-1
            IF AW$=CHR$(9) OR JR=1 THEN MN=MN+1
            IF MN<1 THEN MN=MN(0)
            IF MN>MN(0) THEN MN=1
        UNTIL AW$=CHR$(13) OR JF=1
        XC=MC(MN,0)-1: YC=0
        IF XC+LEN(MN$(MN,1))>38 THEN XC=MC(MN,1)-LEN(MN$(MN,1))
        GOSUB funcMenupulldown
    UNTIL M<>0
    PRINT @MC(MN,0),0;CHR$(146);MN$(MN,0);
    RETURN

'INPUT ROUTINE

funcInput
    AN$="":KN=1:PR$=""
    TT$=TT$+CHR$(13)+CHR$(8)+CHR$(9)+CHR$(127)
    PRINT @XC,YC;CHR$(135);LEFT$(B$,ML-LEN(AN$)-1);" ";CHR$(129)
    REPEAT
        IF KN>LEN(AN$) THEN GOTO endifInput1
            PR$=LEFT$(AN$,KN-1)+CHR$(128+ASC(MID$(AN$,KN,1)))
            PR$=PR$+RIGHT$(AN$,LEN(AN$)-KN)+LEFT$(B$,ML-LEN(AN$))
            GOTO endifInput2
endifInput1
        PR$=AN$+CHR$(160)+LEFT$(B$,ML-LEN(AN$)-1)
endifInput2
        PLOTXC+1,YC,PR$
        JM=0: GOSUB funcGetkey
        IF AW$=CHR$(13) THEN PULL: GOTO exitInput
        INSTR CHR$(8)+CHR$(9)+CHR$(127),AW$,1
        IF IN<>0 THEN GOTO endifInput3
            IF KN>LEN(AN$) THEN GOTO endifInput4
                AN$=LEFT$(AN$,KN-1)+AW$+RIGHT$(AN$,LEN(AN$)-KN)
                GOTO endifInput5
endifInput4
        AN$=AN$+AW$
endifInput5
        KN=KN+1
        GOTO endifInput6
endifInput3
        IF AW$<>CHR$(127) OR LEN(AN$)<=0 OR KN>LEN(AN$) THEN GOTO endifInput7
            AN$=LEFT$(AN$,KN-2)+RIGHT$(AN$,LEN(AN$)-KN+1):KN=KN-1
            GOTO endifInput6
endifInput7
        IF AW$<>CHR$(127) OR LEN(AN$)<=0 OR KN<=LEN(AN$) THEN GOTO endifInput8
            AN$=LEFT$(AN$,LEN(AN$)-1):KN=KN-1
            GOTO endifInput6
endifInput8
        IF AW$=CHR$(8) AND KN>1 THEN KN=KN-1
        IF AW$=CHR$(9) AND KN<LEN(AN$)+1 THEN KN=KN+1
endifInput6
    UNTIL LEN(AN$)=ML AND KN=LEN(AN$)+1
exitInput
    PRINT @XC1,YC;CHR$(131);AN$LEFT$(S$,ML-LEN(AN$));CHR$(129)
    RETURN

'MAKE RECTANGLE

funcMenumakeborder
    GOSUB funcWindowsave
    PRINT @XC-2,YC;CHR$(27);"H";CHR$(129);CHR$(125);
    PRINT LEFT$(B$,B);CHR$(126)
    FOR N=1 TO H
        PRINT @XC-2,YC+N;CHR$(27);"H";CHR$(129);CHR$(91);
        PRINT LEFT$(S$,B);CHR$(92)
    NEXT N
    PRINT @XC-2,YC+H+1;CHR$(27);"H";CHR$(129);CHR$(123);
    PRINT LEFT$(O$,B);CHR$(124)
    RETURN

'END OF GAME

subGameend
    CLS
    PRINT CHR$(131);"GOODBYE.";CHR$(17)
    CALL #6503
    END

'WAIT FOR KEYPRESS OR JOYSTICK

funcWaitkey
    TT$=AL$+CHR$(13):TJ$="0000": JM=1
    GOSUB funcGetkey
    JM=0
    RETURN

'PRINT CENTERED

funcPrintcentered
    IF LEN(CT$)>=B THEN PRINT CT$;
    PRINT LEFT$(S$,(B-1-LEN(CT$))/2);CT$;
    RETURN

'DISK FILE ERROR ROUTINE

funcDiscerror
    XC=4: YC=8: B=34: H=5: GOSUB funcMenumakeborder
    PRINT @6,10;CHR$(134);"Disc error";CHR$(129)
    PRINT @6,11;CHR$(131);"Press key.";CHR$(129)
        GOSUB funcWaitkey
        GOSUB funcWindowrestore
    RETURN

'NEXT MUSIC TRACK

subMusicnext
    CALL #6503
    MU=MU+1: IF MU>3 THEN MU=1
    LOAD "MUSIC"+STR$(MU)+".BIN"
    CALL #6500
    RETURN
   
'IJK INTERFACE DETECT

subIJKDetect
    CALL #A000
    IF PEEK(#A006)=0 THEN JP=0: ELSE JP=1
    RETURN

'IJK JOYSTICK INTERFACE READ

subIJKRead
    JL = 0: JR = 0: JU = 0: JD = 0: JF = 0
    IF JP=0 THEN RETURN
    CALL #A003
    JA = PEEK(#A007): JB = PEEK(#A008)
    IF MID$(TJ$,1,1)="0" THEN GOTO endifIJKRead1
        IF (JA AND 1) OR (JB AND 1) THEN JR=1
endifIJKRead1
    IF MID$(TJ$,2,1)="0" THEN GOTO endifIJKRead2
        IF (JA AND 2) OR (JB AND 2) THEN JL=1
endifIJKRead2
    IF MID$(TJ$,3,1)="0" THEN GOTO endifIJKRead3
        IF (JA AND 8) OR (JB AND 8) THEN JD=1
endifIJKRead3
    IF MID$(TJ$,4,1)="0" THEN GOTO endifIJKRead4   
        IF (JA AND 16) OR (JB AND 16) THEN JU=1
endifIJKRead4
    IF (JA AND 4) OR (JB AND 4) THEN JF=1
    RETURN    

'
'END OF PROGRAM
'    