10000 'L U D O   MAIN PROGRAM
10010 '
10020 'WRITTEN BY XANDER MOL
10030 'CONVERTED TO ORIC ATMOS
10040 'IN 2020
10050 'ORIGINAL WRITTEN IN 1992
10060 'FOR COMMODORE 128
10070 '(C)2020 IDREAMTIN8BITS.COM
10080 :
10090 RANDOM
10100 B$="": O$=""
10110 FOR C=1 TO 40
10120 : B$=B$+CHR$(94): O$=O$+CHR$(93)
10130 NEXT
10140 CI$="0123456789"
10150 LC$="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"+CI$
10160 AL$=LC$+" !#$%&'()"+CHR$(34)+"+-@*^:[;]=,<.>/?_"
10170 RESTORE
10180 S$="                                        "
10190 AD=#A000:WN=1: DIM WI(10,2): MU=1: CC=0
10200 GOSUB10620
10210 GOSUB14830
10220 XC=18:YC=8:B=20:H=6:GOSUB16290
10230 PRINT@20,10;CHR$(131);"Load old game?";CHR$(129)
10240 XC=27:YC=11:MN=5:GOSUB15330
10250 GOSUB15270
10260 IFM=1THENGOSUB13650
10270 :
10280 'MAIN GAMELOOP
10290 :
10300 REPEAT
10310 : GOSUB10560
10320 : IFEI<>2THENGOSUB11560:GOSUB11410:GOTO10340
10330 : EI=0:GOSUB14110
10340 : REPEAT
10350 :   PRINT@0,2;LEFT$(S$,39):PRINT@0,3;LEFT$(S$,39)
10360 :   PRINT@0,4;LEFT$(S$,39)
10370 :   PRINT@0,2;CHR$(131);"Player";CHR$(134);BS+1;CHR$(131);": ";
10380 :    PRINTCHR$(144+SP(BS,2));" ";CHR$(144)
10390 :   PRINT@0,3;CHR$(130);SP$(BS);CHR$(131);LEFT$(S$,10)
10400 :   IFSP(BS,0)=0THENGOSUB11950:GOTO10420
10410 :     PRINT@0,4;CHR$(131);"Computer is playing."
10420 :   IFEI<>0THENPULL:GOTO10510
10430 :   GOSUB12100
10440 :   IFSP(BS,1)=0THENGOSUB14260
10450 :   IFEI<>0THENPULL:GOTO10510
10460 :   REPEAT
10470 :     IFZV=1THENZV=0:GOTO10490
10480 :       NP(NS)=-1:BS=BS+1:IFBS>3THENBS=0
10490 :   UNTIL(ZV<>0 OR SP(BS,1)<>0)
10500 : UNTILEI<>0
10510 UNTILEI=1
10520 GOTO16420
10530 :
10540 'LOAD MAIN SCREEN
10550 :
10560 LOAD "LUDOSCRM.BIN"
10570 GOSUB15120
10580 RETURN
10590 :
10600 'INITIALISATION
10610 :
10620 DIMVC(39,1),RC(3,7,1),SP$(3),SP(3,3),DN$(5,1),SC(3,3,1)
10630 DIMPM(3),NP(3),PW(3)
10640 FORN=0TO39:READVC(N,0),VC(N,1):NEXTN
10650 FORN=0TO3
10660 : FORM=0TO7:READRC(N,M,0),RC(N,M,1):NEXTM
10670 NEXTN
10680 FORN=0TO3:READSP(N,2):NEXTN
10690 FORN=0TO5
10700 : READA,B,C,D:DN$(N,0)=CHR$(A)+CHR$(B):DN$(N,1)=CHR$(C)+CHR$(D)
10710 NEXTN
10720 RETURN
10730 :
10740 'CO-ORDINATES OF PAWN
10750 :
10760 IFSC(BS,PN,0)<>0THENGOTO10780
10770 : XC=VC(SC(BS,PN,1),0):YC=VC(SC(BS,PN,1),1):GOTO10790
10780 XC=RC(BS,SC(BS,PN,1),0):YC=RC(BS,SC(BS,PN,1),1)
10790 RETURN
10800 :
10810 'ERASE PAWN
10820 :
10830 GOSUB10760
10840 IFSC(BS,PN,0)=0ANDSC(BS,PN,1)/10=INT(SC(BS,PN,1)/10)THENGOTO10950
10850 'NORMAL WHITE FIELD MAIN TRACK
10860 IFSC(BS,PN,0)<>0THENGOTO10910
10870 : PRINT@XC-1,YC;CHR$(135);" !"
10880 : PRINT@XC-1,YC+1;CHR$(135);CHR$(34);"#";
10890 : GOTO11100
10900 'COLORED HOME OR DEST FIELD
10910 PRINT@XC-1,YC;CHR$(128+SP(BS,2));"$%"
10920 PRINT@XC-1,YC+1;CHR$(128+SP(BS,2));"&";CHR$(39);
10930 GOTO11100
10940 'COLORED START FIELDS
10950 IFSC(BS,PN,1)<>0THENGOTO10990
10960 : PRINT@XC-1,YC;CHR$(130);",-"
10970 : PRINT@XC-1,YC+1;CHR$(130);"./";
10980 : GOTO11100
10990 IFSC(BS,PN,1)<>10THENGOTO11030
11000 : PRINT@XC-1,YC;CHR$(129);"01"
11010 : PRINT@XC-1,YC+1;CHR$(129);"23";
11020 : GOTO11100
11030 IFSC(BS,PN,1)<>20THENGOTO11070
11040 : PRINT@XC-1,YC;CHR$(132);"45"
11050 : PRINT@XC-1,YC+1;CHR$(132);"67";
11060 : GOTO11100
11070 IFSC(BS,PN,1)<>30THENGOTO11100
11080 : PRINT@XC-1,YC;CHR$(131);"89"
11090 : PRINT@XC-1,YC+1;CHR$(131);":;";
11100 RETURN
11110 :
11120 'PLACE PAWN
11130 :
11140 GOSUB10760
11150 IFCC=1THENGOTO11190
11160 : PRINT@XC-1,YC;CHR$(128+SP(BS,2));"()"
11170 : PRINT@XC-1,YC+1;CHR$(128+SP(BS,2));"*+";
11180 GOTO 11210
11190 : PRINT@XC-1,YC;CHR$(135);"()"
11200 : PRINT@XC-1,YC+1;CHR$(135);"*+";
11210 RETURN
11220 :
11230 'THROW DICE
11240 :
11250 XC=30:YC=12:B=8:H=6:GOSUB16290
11260 PRINT@32,14;CHR$(27);"I";CHR$(135);CHR$(160);CHR$(160);
11270 PRINTCHR$(129);CHR$(27);"H"
11280 PRINT@32,15;CHR$(27);"I";CHR$(135);CHR$(160);CHR$(160);
11290 PRINTCHR$(129);CHR$(27);"H"
11300 FORN=1TO10
11310 : DG=INT(RND(1)*6)+1
11320 : PLOT 34,14,DN$(DG-1,0): PLOT 34,15,DN$(DG-1,1)
11330 : FORW=1TO10:NEXTW
11340 NEXTN
11350 PRINT@32,17;CHR$(131);"Key.";CHR$(129)
11360 GOSUB16490:GOSUB15270
11370 RETURN
11380 :
11390 'INPUT OF NAMES
11400 :
11410 XC=4:YC=8:B=34:H=6:GOSUB16290
11420 FORSP=0TO3
11430 : PRINT@6,10;CHR$(131);"Computer plays for player";CHR$(134);
11440 : PRINTSP+1;CHR$(131);"?";CHR$(129)
11450 : XC=28:YC=11:MN=5:GOSUB15330
11460 : IFM=1THENSP(SP,0)=1ELSESP(SP,0)=0
11470 : PRINT@6,10;CHR$(131);"Input name for player";CHR$(134);
11480 : PRINTSP+1;CHR$(131);":    ";CHR$(129)
11490 : XC=6:YC=12:ML=20:TT$=AL$:GOSUB15950:SP$(SP)=AN$
11500 NEXTSP
11510 GOSUB15270
11520 RETURN
11530 :
11540 'GAME RESET
11550 :
11560 BS=0:EI=0
11570 FORN=0TO3
11580 : SP(N,1)=4:SP(N,3)=4:NP(N)=-1:DP(N)=8
11590 : FORM=0TO3
11600 :   SC(N,M,0)=1:SC(N,M,1)=M
11610 : NEXTM
11620 NEXTN
11630 RETURN
11640 :
11650 'INFORMATION: CREDITS
11660 :
11670 XC=2:YC=8:B=36:H=11:GOSUB16290:B=B-1
11680 PRINT@4,10;CHR$(134);:CT$="L U D O"
11690 GOSUB16530:PRINTCHR$(129)
11700 PRINT@4,11;CHR$(131);:CT$="Written by Xander Mol"
11710 GOSUB16530:PRINTCHR$(129)
11720 PRINT@4,12;CHR$(131);:CT$="Converted to Oric Atmos, 2020"
11730 GOSUB16530:PRINTCHR$(129)
11740 PRINT@4,13;CHR$(131);:CT$="Original on Commodore 128, 1992"
11750 GOSUB16530:PRINTCHR$(129)
11760 PRINT@4,14;CHR$(131);:CT$="Build with and using code of"
11770 GOSUB16530:PRINTCHR$(129)
11780 PRINT@4,15;CHR$(131);:CT$="OSDK,"+CHR$(96)+" DBug and OSDK authors."
11790 GOSUB16530:PRINTCHR$(129)
11800 PRINT@4,17;CHR$(130);:CT$="Press a key."
11810 GOSUB16530:PRINTCHR$(129)
11820 GOSUB16490:GOSUB15270
11830 RETURN
11840 :
11850 'QUESTION: ARE YOU SURE?
11860 :
11870 XC=8:YC=8:B=30:H=6:GOSUB16290
11880 PRINT@10,10;CHR$(131)"Are you sure ?";CHR$(129);
11890 XC=25:YC=11:MN=5:GOSUB15330
11900 GOSUB15270
11910 RETURN
11920 :
11930 'TURN HUMAN PLAYER
11940 :
11950 REPEAT
11960 : GOSUB15740
11970 : IFMN=1ANDM=2THENGOSUB11870:IFM=1THENEI=3:PULL:GOTO12060
11980 : IFMN=1ANDM=3THENGOSUB11870:IFM=1THENEI=1:PULL:GOTO12060
11990 : IFMN=2ANDM=1THENGOSUB13200:M=1
12000 : IFMN=2ANDM=2THENGOSUB11870:IFM=1THENGOSUB13650:PULL:GOTO12060
12010 : IFMN=3ANDM=1THENGOSUB16660
12020 : IFMN=3ANDM=2THENCALL#6503
12030 : IFMN=3ANDM=3THENCALL#6503:CALL#6500
12040 : IFMN=4ANDM=1THENGOSUB11670
12050 UNTIL MN=1 AND M=1
12060 RETURN
12070 :
12080 'TURN GENERIC
12090 :
12100 GA=1:GB=0:MP=0:PN=-1:AP=0:ZV=0
12110 FORN=0TO3:PM(N)=0:NEXTN
12120 IFSP(BS,3)=SP(BS,1)THENGA=3:PRINT@21,3;CHR$(131);"Throw 3 times."
12130 FORD=1TOGA
12140 : GOSUB11250
12150 : IFDG=6THEND=GA
12160 NEXTD
12170 PRINT@21,3;LEFT$(S$,15)
12180 IFSP(BS,3)=SP(BS,1)ANDDG<>6THENGB=1
12190 IFNP(BS)<0THENGOTO12220
12200 : IFSP(BS,3)>0THENPN=NP(BS):NP(BS)=-1:GOTO12220
12210 :   NP(BS)=-1
12220 IFGB<>0ORPN<>-1THENGOTO12400
12230 : FORN=0TO3
12240 :   VR=SC(BS,N,0):VL=SC(BS,N,1):GV=0
12250 :   IFVR=1ANDVL<4THENGV=1:IFDG=6THENPN=N:NP(BS)=N:N=3
12260 :   IFGV<>0THENGOTO12390
12270 :   VN=VL+DG:NR=VR
12280 :   IFVR<>0THENGOTO12330
12290 :     IFBS=0ANDVN>39ANDVL<40THENVN=VN-36:NR=1
12300 :     IFBS=1ANDVN>9ANDVL<10THENVN=VN-6:NR=1
12310 :     IFBS=2ANDVN>19ANDVL<20THENVN=VN-16:NR=1
12320 :     IFBS=3ANDVN>29ANDVL<30THENVN=VN-26:NR=1
12330 :   IFNR<>1THENGOTO12380
12340 :   IFVN>7THENGV=1:GOTO12380
12350 :   FORM=0TO3
12360 :   IFN<>MANDSC(BS,M,0)=1ANDSC(BS,M,1)<=VNANDSC(BS,M,1)>3THENGV=1:M=3
12370 :   NEXTM
12380 :   IFGV=0THENPM(N)=1
12390 : NEXTN
12400 IFPN<>-1THENGOTO12450
12410 : FORN=0TO3
12420 :   IFPM(N)=1THENAP=AP+1:PN=N
12430 : NEXTN
12440 : GOTO12460
12450 AP=1
12460 IFAP<=1THENGOTO12480
12470 : IFSP(BS,0)=0THENGOSUB12910ELSEGOSUB14390
12480 IFDG=6THENZV=1
12490 IFAP<>0ANDGB<>1THENGOTO12540
12500 : PRINT@21,2;CHR$(131);"No move possible"
12510 : PRINT@21,3;CHR$(131);"Press key"
12520 : GOSUB16490
12530 : RETURN
12540 GOSUB10830
12550 OV=SC(BS,PN,1):RO=SC(BS,PN,0)
12560 IFRO<>1OROV>=4THENGOTO12590
12570 : SC(BS,PN,0)=0:SC(BS,PN,1)=BS*10:SP(BS,3)=SP(BS,3)-1
12580 : GOTO12600
12590 SC(BS,PN,1)=SC(BS,PN,1)+DG
12600 IFBS<>0ORSC(BS,PN,1)<=39OROV>=40ORRO<>0THENGOTO12620
12610 : SC(BS,PN,0)=1:SC(BS,PN,1)=SC(BS,PN,1)-36
12620 IFBS<>1ORSC(BS,PN,1)<=9OROV>=10ORRO<>0THENGOTO12640
12630 : SC(BS,PN,0)=1:SC(BS,PN,1)=SC(BS,PN,1)-6
12640 IFBS<>2ORSC(BS,PN,1)<=19OROV>=20ORRO<>0THENGOTO12660
12650 : SC(BS,PN,0)=1:SC(BS,PN,1)=SC(BS,PN,1)-16
12660 IFBS<>3ORSC(BS,PN,1)<=29OROV>=30ORRO<>0THENGOTO12680
12670 : SC(BS,PN,0)=1:SC(BS,PN,1)=SC(BS,PN,1)-26
12680 IFSC(BS,PN,0)=1ANDSC(BS,PN,1)>3THENDP(BS)=SC(BS,PN,1)
12690 IFSC(BS,PN,1)=SP(BS,1)+3ANDSC(BS,PN,0)=1THENSP(BS,1)=SP(BS,1)-1
12700 IFSC(BS,PN,1)>39THENSC(BS,PN,1)=SC(BS,PN,1)-40
12710 AP=0:AS=-1
12720 FORSP=0TO3
12730 : FORPO=0TO3
12740 :   IFPO=PNANDSP=BSTHENGOTO12770
12750 :     IFSC(SP,PO,0)<>0ORSC(BS,PN,0)<>0THENGOTO12770
12760 :       IFSC(SP,PO,1)=SC(BS,PN,1)THENAP=PO:AS=SP:PO=3:SP=3
12770 : NEXTPO
12780 NEXTSP
12790 IFAS=-1THENGOTO12860
12800 : H1=BS:H2=PN
12810 : BS=AS:PN=AP
12820 : GOSUB10830
12830 : SC(BS,PN,0)=1:SC(BS,PN,1)=PN:SP(BS,3)=SP(BS,3)+1
12840 : GOSUB11140
12850 : BS=H1:PN=H2
12860 GOSUB11140
12870 RETURN
12880 :
12890 'HUMAN PLAYER CHOOSE PAWN
12900 :
12910 XC=20:YC=1:B=18:H=2:GOSUB16290
12920 PRINT@22,2;CHR$(131);"Which pawn?";CHR$(129)
12930 PRINT@22,3;CHR$(131);"Thrown:";DG;CHR$(129)
12940 PN=0
12950 REPEAT
12960 : PN=PN+1
12970 UNTIL PM(PN)=1
12980 REPEAT
12990 CC=1:GOSUB11140:CC=0
13000 JM=1:TT$=CHR$(8)+CHR$(9)+CHR$(10)+CHR$(11)+CHR$(13)
13010 TJ$="11111111":GOSUB15650
13020 GOSUB11140
13030 IFAW$=CHR$(8)ORAW$=CHR$(10)ORJW=5ORJW=6ORJW=7ORJW=8THENPN=PN-1:RI=-1
13040 IFAW$=CHR$(9)ORAW$=CHR$(11)ORJW=1ORJW=2ORJW=3ORJW=4THENPN=PN+1:RI=1
13050 IFAW$=CHR$(13)ORJW>=128THENPULL:GOTO13150
13060 IFPN>3THENPN=0
13070 IFPN<0THENPN=3
13080 REPEAT
13090 : IFPM(PN)=1THENPULL:GOTO13140
13100 : PN=PN+RI
13110 : IFPN>3THENPN=0
13120 : IFPN<0THENPN=3
13130 UNTIL PM(PN)=1
13140 UNTIL AW$=CHR$(13)
13150 GOSUB15270
13160 RETURN
13170 :
13180 'SAVE GAME
13190 :
13200 XC=8:YC=8:B=30:H=7:GOSUB16290
13210 PRINT@10,10;CHR$(130);"Save game.";CHR$(129)
13220 PRINT@10,12;CHR$(131);"Enter filename:";CHR$(129)
13230 XC=10:YC=14:ML=8:TT$=AL$:GOSUB15950:GOSUB15270:IFAN$=""THENRETURN
13240 AN$=AN$+".SAV"
13250 ERR SET: ERRGOTO 13600
13260 SEARCH AN$
13270 IFEF=0THENGOTO13340
13280 : XC=8:YC=8:B=30:H=8:GOSUB16290
13290 : PRINT@10,10;CHR$(131);"Filename exists.";CHR$(129)
13300 : PRINT@10,11;CHR$(131);"Replace?";CHR$(129)
13310 : XC=15:YC=13:MN=5:GOSUB15330
13320 : GOSUB15270
13330 : IFM=2THENRETURN
13340 AS=#B001
13350 POKE #B000,BS
13360 FORN=0TO3
13370 : IFNP(N)<0THENPOKEAS,256+NP(N)ELSEPOKEAS,NP(N)
13380 : AS=AS+1
13390 NEXTN
13400 FORN=0TO3
13410 : FORM=0TO3
13420 :   POKE AS,SP(N,M):AS=AS+1
13430 : NEXTM
13440 NEXTN
13450 FORN=0TO3
13460 : FORM=0TO3
13470 :   POKE AS,SC(N,M,0): AS=AS+1
13480 :   POKE AS,SC(N,M,1): AS=AS+1
13490 : NEXTM
13500 NEXTN
13510 FORN=0TO3
13520 : POKE AS,LEN(SP$(N)):AS=AS+1
13530 : FORM=1TOLEN(SP$(N))
13540 :   POKE AS,ASC(MID$(SP$(N),M,1)):AS=AS+1
13550 : NEXTM
13560 NEXTN
13570 SAVEO AN$,A#B000,E#B100
13580 ERR OFF: RETURN
13590 'ERROR HANDLING
13600 GOSUB16590: ERR OFF
13610 RETURN
13620 :
13630 'LOAD GAME
13640 :
13650 XC=8:YC=8:B=30:H=8
13660 GOSUB16290
13670 PRINT@10,10;CHR$(131);"Load game.";CHR$(129)
13680 PRINT@10,12;CHR$(131);"Filename (without .SAV):";CHR$(129)
13690 XC=10:YC=14:ML=8:TT$=AL$:GOSUB15950:GOSUB15270:IFAN$=""THENRETURN
13700 AN$=AN$+".SAV"
13710 ERR SET: ERRGOTO 14060
13720 SEARCH AN$
13730 IFEF<>0THENGOTO13780
13740 : XC=8:YC=8:B=30:H=6:GOSUB16290
13750 : PRINT@10,10;CHR$(131);"File not found.";CHR$(129)
13760 : PRINT@10,11;CHR$(131);"Press key.";CHR$(129):GOSUB16490
13770 : GOSUB15270:RETURN
13780 LOAD AN$
13790 BS=PEEK(#B000):AS=#B001
13800 FORN=0TO3
13810 : NP(N)=PEEK(AS):AS=AS+1
13820 : IFNP(N)>127THENNP(N)=-(256-NP(N))
13830 NEXTN
13840 FORN=0TO3
13850 : FORM=0TO3
13860 :   SP(N,M)=PEEK(AS):AS=AS+1
13870 : NEXTM
13880 NEXTN
13890 FORN=0TO3
13900 : FORM=0TO3
13910 :   SC(N,M,0)=PEEK(AS):AS=AS+1
13920 :   SC(N,M,1)=PEEK(AS):AS=AS+1
13930 : NEXTM
13940 NEXTN
13950 FORN=0TO3
13960 : ML=PEEK(AS):AS=AS+1
13970 : SP$(N)=""
13980 : FORM=1TOML
13990 :   SP$(N)=SP$(N)+CHR$(PEEK(AS)):AS=AS+1
14000 : NEXTM
14010 NEXTN
14020 EI=2
14030 ERR OFF
14040 RETURN
14050 'ERROR HANDLING
14060 GOSUB16590: ERR OFF
14070 RETURN
14080 :
14090 'PLACE PAWNS AFTER LOAD
14100 :
14110 H1=BS
14120 FORBS=0TO3
14130 : FORPN=0TO3
14140 :   H2=SC(BS,PN,0):H3=SC(BS,PN,1)
14150 :   SC(BS,PN,0)=1:SC(BS,PN,1)=PN
14160 :   GOSUB10830
14170 :   SC(BS,PN,0)=H2:SC(BS,PN,1)=H3
14180 :   GOSUB11140
14190 : NEXTPN
14200 NEXTBS
14210 BS=H1
14220 RETURN
14230 :
14240 'A PLAYER HAS WON THE GAME
14250 :
14260 XC=3:YC=8:B=35:H=9:GOSUB16290
14270 PRINT@5,10;CHR$(130);SP$(BS);CHR$(131);" has won the game!";
14280 PRINTCHR$(129)
14290 PRINT@5,12;CHR$(131);"What do you want?";CHR$(129)
14300 XC=15:YC=13:MN=7:GOSUB15330
14310 IFM=1ANDSP(0,1)=0ANDSP(1,1)=0ANDSP(2,1)=0ANDSP(3,1)=0THENGOTO14300
14320 IFM=2THENEI=3:ZV=1
14330 IFM=3THENEI=1:ZV=1
14340 GOSUB15270
14350 RETURN
14360 :
14370 'CHOOSE PAWN COMPUTER PLAYER
14380 :
14390 FORN=0TO3:PW(N)=0:NEXTN
14400 FORN=0TO3
14410 IFPM(N)=0THENPW(N)=-10000:GOTO14740
14420 VR=SC(BS,N,0):VN=SC(BS,N,1)
14430 NN=VN+DG:NO=NN:NR=VR
14440 IFVR<>0THENGOTO14490
14450 IFBS=0ANDNN>39ANDVN<40THENNN=NN-36:NR=1
14460 IFBS=1ANDNN>9ANDVN<10THENNN=NN-6:NR=1
14470 IFBS=2ANDNN>19ANDVN<20THENNN=NN-16:NR=1
14480 IFBS=3ANDNN>29ANDVN<30THENNN=NN-26:NR=1
14490 IFNR=0ANDNN>39THENNN=NN-40
14500 IFNR=1ANDNN>3ANDSP(BS,1)=1THENPW(N)=10000:N=3:GOTO14740
14510 IFNR=1ANDNN>3THENPW(N)=PW(N)+6000
14520 FORSP=0TO3
14530 FORPO=0TO3
14540 IFBS=SPANDSC(SP,PO,0)=NRANDSC(SP,PO,1)=NNTHENPW(N)=PW(N)-8000
14550 IFBS=SPORSC(SP,PO,0)<>NRORSC(SP,PO,1)<>NNTHENGOTO14620
14560 PW(N)=PW(N)+4000
14570 IFSC(SP,PO,0)<>0THENGOTO14620
14580 IFSP=0ANDSC(SP,PO,1)>33THENPW(N)=PW(N)+3000
14590 IFSP=1ANDSC(SP,PO,1)>3THENPW(N)=PW(N)+3000
14600 IFSP=2ANDSC(SP,PO,1)>13THENPW(N)=PW(N)+3000
14610 IFSP=3ANDSC(SP,PO,1)>23THENPW(N)=PW(N)+3000
14620 IFSC(SP,PO,0)<>0ORNR<>0ORBS=SPTHENGOTO14660
14630 IF(VN-SC(SP,PO,1))<6AND(VN-SC(SP,PO,1))>0THENPW(N)=PW(N)+400
14640 IF(NO-SC(SP,PO,1))<6AND(NO-SC(SP,PO,1))>0THENPW(N)=PW(N)-200
14650 IF(SC(SP,PO,1)-NN)<6AND(SC(SP,PO,1)-NN)>0THENPW(N)=PW(N)+100
14660 NEXTPO
14670 NEXTSP
14680 IFNR=0AND(NN=0ORNN=10ORNN=20ORNN=30)THENPW(N)=PW(N)-4000
14690 IFVR=0AND(VN=0ORVN=10ORVN=20ORVN=30)THENPW(N)=PW(N)+2000
14700 IFBS=0THENPW(N)=PW(N)+NN
14710 IFBS=1THENPW(N)=PW(N)+(NO-10)
14720 IFBS=2THENPW(N)=PW(N)+(NO-20)
14730 IFBS=3THENPW(N)=PW(N)+(NO-30)
14740 NEXTN
14750 MW=-20000
14760 FORN=0TO3
14770 : IFPW(N)>MWTHENMW=PW(N):PN=N
14780 NEXTN
14790 RETURN
14800 :
14810 'READ MENUDATA
14820 :
14830 READMN,DN
14840 DIMMN$(MN+DN+2,16),MN(MN+DN+2),MC(MN,1)
14850 MC=1:MN(0)=MN
14860 FORN=1TOMN(0)
14870 : READMN$(N,0)
14880 : READMN(N)
14890 : MC(N,0)=MC:MC(N,1)=MC+LEN(MN$(N,0)):MC=MC(N,1)+1:ML=0
14900 : FORM=1TOMN(N)
14910 :   READMN$(N,M)
14920 :   IFLEN(MN$(N,M))>MLTHENML=LEN(MN$(N,M))
14930 : NEXTM
14940 : FORM=1TOMN(N)
14950 :   MN$(N,M)=MN$(N,M)+LEFT$(S$,ML-LEN(MN$(N,M)))
14960 : NEXTM
14970 NEXTN
14980 FORN=1TODN
14990 : READMN(MN(0)+N):ML=0
15000 : FORM=1TOMN(MN(0)+N)
15010 :   READMN$(MN(0)+N,M)
15020 :   IFLEN(MN$(MN(0)+N,M))>MLTHENML=LEN(MN$(MN(0)+N,M))
15030 : NEXTM
15040 : FORM=1TOMN(MN(0)+N)
15050 :   MN$(MN(0)+N,M)=MN$(MN(0)+N,M)+LEFT$(S$,ML-LEN(MN$(MN(0)+N,M)))
15060 : NEXTM
15070 NEXTN
15080 RETURN
15090 :
15100 'PLACE MENU BAR
15110 :
15120 PRINT @0,0;CHR$(128);CHR$(146);
15130 FORN=1TOMN(0)
15140 : PRINT MN$(N,0);" ";
15150 NEXTN
15160 RETURN
15170 :
15180 'SAVE SCREEN
15190 :
15200 WI(WN,0)=AD: WI(WN,1)=YC-1: WI(WN,2)=H+3
15210 MOVE #BBA8+WI(WN,1)*40,#BBA8+(WI(WN,1)+WI(WN,2))*40,WI(WN,0)
15220 AD=AD+WI(WN,2)*40:WN=WN+1
15230 RETURN
15240 :
15250 'LOAD SCREEN BACK
15260 :
15270 WN=WN-1: AD=WI(WN,0)
15280 MOVE WI(WN,0),WI(WN,0)+WI(WN,2)*40,#BBA8+WI(WN,1)*40
15290 RETURN
15300 :
15310 'MENU
15320 :
15330 H=MN(MN)+2
15340 GOSUB15200
15350 IFMN<=MN(0)THENGOTO15370
15360 : PRINT@XC,YC;CHR$(129);CHR$(125);LEFT$(B$,4+LEN(MN$(MN,1)))
15370 FORN=1TOMN(MN)
15380 : PRINT@XC,YC+N;CHR$(129);CHR$(91);CHR$(150);CHR$(128);
15390 : PRINTMN$(MN,N);CHR$(129);CHR$(91);CHR$(144)
15400 NEXTN
15410 PRINT@XC,YC+N;CHR$(129);CHR$(123);LEFT$(O$,4+LEN(MN$(MN,1)));
15420 M=1:TT$=CHR$(11)+CHR$(10)+CHR$(13):TJ$="11011101"
15430 IFMN<=MN(0)THENTT$=TT$+CHR$(8)+CHR$(9):TJ$="11111111"
15440 EX=0
15450 REPEAT
15460 : PRINT@XC+2,YC+M;CHR$(147);CHR$(128);MN$(MN,M);
15470 : PRINTCHR$(129);CHR$(91);CHR$(144)
15480 : JM=1:GOSUB15650:JM=0
15490 : IF AW$=CHR$(13) OR JW>=128THEN EX=1
15500 : IFAW$=CHR$(8)ORJW=7THENM=0:EX=1
15510 : IFAW$=CHR$(9)ORJW=3THENM=0:EX=1
15520 : IFEX<>0THENGOTO15550
15530 :   PRINT@XC+2,YC+M;CHR$(150);CHR$(128);MN$(MN,M);
15540 :   PRINTCHR$(129);CHR$(91);CHR$(144)
15550 : IFAW$=CHR$(11)ORJW=1ORJW=2ORJW=8THENM=M-1
15560 : IFAW$=CHR$(10)ORJW=4ORJW=5ORJW=6THENM=M+1
15570 : IFM>MN(MN)THENM=1
15580 : IFM<1THENM=MN(MN)
15590 UNTIL EX=1
15600 GOSUB15270
15610 RETURN
15620 :
15630 'ASK FOR KEYPRESS OR JOYSTICK
15640 :
15650 REPEAT
15660 : GETAW$: INSTR TT$,AW$,1
15670 'TBD FOR READING JOYSTICK
15680 : JW=0
15690 UNTIL IN>0
15700 RETURN
15710 :
15720 'MAIN MENU
15730 :
15740 MN=1:M=0
15750 REPEAT
15760 : REPEAT
15770 :   PRINT@MC(MN,0),0;CHR$(151);MN$(MN,0);CHR$(146)
15780 :   TT$=CHR$(8)+CHR$(9)+CHR$(13):TJ$="01110111"
15790 :   JM=1:GOSUB15650:JM=0
15800 :   PRINT@MC(MN,0),0;CHR$(146);MN$(MN,0);
15810 :   IFAW$=CHR$(8)ORJW=6ORJW=7ORJW=8THENMN=MN-1
15820 :   IFAW$=CHR$(9)ORJW=2ORJW=3ORJW=4THENMN=MN+1
15830 :   IFMN<1THENMN=MN(0)
15840 :   IFMN>MN(0)THENMN=1
15850 : UNTILAW$=CHR$(13) OR JW>=128
15860 : XC=MC(MN,0)-1:YC=0
15870 : IFXC+LEN(MN$(MN,1))>79THENXC=MC(MN,1)-LEN(MN$(MN,1))
15880 : GOSUB15330
15890 UNTIL M<>0
15900 PRINT@MC(MN,0),0;CHR$(146);MN$(MN,0);
15910 RETURN
15920 :
15930 'INPUT ROUTINE
15940 :
15950 AN$="":KN=1:PR$=""
15960 TT$=TT$+CHR$(13)+CHR$(8)+CHR$(9)+CHR$(127)
15970 PRINT@XC,YC;CHR$(135);LEFT$(B$,ML-LEN(AN$)-1);" ";CHR$(129)
15980 REPEAT
15990 : IFKN>LEN(AN$)THENGOTO16030
16000 :   PR$=LEFT$(AN$,KN-1)+CHR$(128+ASC(MID$(AN$,KN,1)))
16010 :   PR$=PR$+RIGHT$(AN$,LEN(AN$)-KN)+LEFT$(B$,ML-LEN(AN$))
16020 :   GOTO 16040
16030 : PR$=AN$+CHR$(160)+LEFT$(B$,ML-LEN(AN$)-1)
16040 : PLOTXC+1,YC,PR$
16050 : GOSUB15650
16060 : IFAW$=CHR$(13)THENPULL:GOTO16240
16070 : INSTR CHR$(8)+CHR$(9)+CHR$(127),AW$,1
16080 : IFIN<>0THENGOTO16150
16090 :   IFKN>LEN(AN$)THENGOTO16120
16100 :     AN$=LEFT$(AN$,KN-1)+AW$+RIGHT$(AN$,LEN(AN$)-KN)
16110 :     GOTO16130
16120 :   AN$=AN$+AW$
16130 :   KN=KN+1
16140 : GOTO16230
16150 :   IFAW$<>CHR$(127)ORLEN(AN$)<=0ORKN>LEN(AN$)THENGOTO16180
16160 :     AN$=LEFT$(AN$,KN-2)+RIGHT$(AN$,LEN(AN$)-KN+1):KN=KN-1
16170 :     GOTO16230
16180 :   IFAW$<>CHR$(127)ORLEN(AN$)<=0ORKN<=LEN(AN$)THENGOTO16210
16190 :     AN$=LEFT$(AN$,LEN(AN$)-1):KN=KN-1
16200 :     GOTO16230
16210 :   IFAW$=CHR$(8)ANDKN>1THENKN=KN-1
16220 :   IFAW$=CHR$(9)ANDKN<LEN(AN$)+1THENKN=KN+1
16230 UNTILLEN(AN$)=MLANDKN=LEN(AN$)+1
16240 PRINT@XC1,YC;CHR$(131);AN$LEFT$(S$,ML-LEN(AN$));CHR$(129)
16250 RETURN
16260 :
16270 'MAKE RECTANGLE
16280 :
16290 GOSUB15200
16300 PRINT@XC-2,YC;CHR$(27);"H";CHR$(129);CHR$(125);
16310 PRINTLEFT$(B$,B);CHR$(126)
16320 FORN=1TOH
16330 : PRINT@XC-2,YC+N;CHR$(27);"H";CHR$(129);CHR$(91);
16340 : PRINTLEFT$(S$,B);CHR$(92)
16350 NEXTN
16360 PRINT@XC-2,YC+H+1;CHR$(27);"H";CHR$(129);CHR$(123);
16370 PRINTLEFT$(O$,B);CHR$(124)
16380 RETURN
16390 :
16400 'END OF GAME
16410 :
16420 CLS
16430 PRINT CHR$(131);"GOODBYE.";CHR$(17)
16440 CALL #6503
16450 END
16460 :
16470 'WAIT FOR KEYPRESS OR JOYSTICK
16480 :
16490 TT$=AL$+CHR$(13):TJ$="00000000":JM=1:GOSUB15650:JM=0:RETURN
16500 :
16510 'PRINT CENTERED
16520 :
16530 IF LEN(CT$)>=BTHENPRINTCT$;
16540 PRINTLEFT$(S$,(B-1-LEN(CT$))/2);CT$;
16550 RETURN
16560 :
16570 'DISK FILE ERROR ROUTINE
16580 :
16590 XC=4:YC=8:B=34:H=5:GOSUB16290
16600 PRINT@6,10;CHR$(134);"Disc error";CHR$(129)
16610 PRINT@6,11;CHR$(131);"Press key.";CHR$(129):GOSUB16490:GOSUB15270
16620 RETURN
16630 :
16640 'NEXT MUSIC TRACK
16650 :
16660 CALL #6503
16670 MU=MU+1:IFMU>3THENMU=1
16680 LOAD "MUSIC"+STR$(MU)+".BIN"
16690 CALL #6500
16700 RETURN
16710 :
16720 'GAME DATA
16730 :
16740 'PAWN POSITION CO-ORDS MAIN
16750 DATA  2,13,  5,13,  8,13, 11,13, 14,13
16760 DATA 14,11, 14, 9, 14, 7, 14, 5, 17, 5
16770 DATA 20, 5, 20, 7, 20, 9, 20,11, 20,13
16780 DATA 23,13, 26,13, 29,13, 32,13, 32,15
16790 DATA 32,17, 29,17, 26,17, 23,17, 20,17
16800 DATA 20,19, 20,21, 20,23, 20,25, 17,25
16810 DATA 14,25, 14,23, 14,21, 14,19, 14,17
16820 DATA 11,17,  8,17,  5,17,  2,17,  2,15
16830 :
16840 'PAWN POS CO-ORDS START AND DEST
16850 DATA  2, 5,  5, 5,  2, 7,  5, 7,  5,15,  8,15, 11,15, 14,15
16860 DATA 29, 5, 32, 5, 29, 7, 32, 7, 17, 7, 17, 9, 17,11, 17,13
16870 DATA 29,23, 32,23, 29,25, 32,25, 29,15, 26,15, 23,15, 20,15
16880 DATA  2,23,  5,23,  2,25,  5,25, 17,23, 17,21, 17,19, 17,17
16890 :
16900 'PLAYER COLORS
16910 DATA 2,1,4,3
16920 :
16930 'DICE PRINT STRINGS
16940 DATA 188,189,190,191
16950 DATA 192,193,193,194
16960 DATA 195,189,190,196
16970 DATA 192,197,198,194
16980 DATA 195,199,200,196
16990 DATA 201,201,202,202
17000 :
17010 'MENU DATA
17020 :
17030 DATA 4,3
17040 DATA Game,3,Throw dice,Restart,Stop
17050 DATA Disc,2,Save game,Load game
17060 DATA Music,3,Next,Stop,Restart
17070 DATA Information,1,Credits
17080 DATA 2,Yes,No
17090 DATA 2,Restart,Stop
17100 DATA 3,Continue game,New game,Stop
17110 :
17120 '
17130 'END OF PROGRAM
17140 '
