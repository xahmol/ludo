 10000 rem "---------------------------------------------------------------------
 10010 rem "-             M E N S   E R G E R   J E   N I E T lader             -
 10020 rem "-              Geschreven door Xander Arend Herman Mol              -
 10030 rem "-                     (C) 1992 by XAMA Software                     -
 10040 rem "---------------------------------------------------------------------
 10050 :
 10060 rem "--- Hoofdprogramma ---
 10070 :
 10080 color6,1:fast:window0,0,79,24,1:printchr$(14)chr$(27)"m{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{wht}"
 10090 fd$="Even geduld S.V.P.":gosub10630
 10100 poke247,128:poke0,peek(0)or64:poke1,peek(1)and191:poke47,0:poke48,164:clr
 10110 trap10970
 10120 graphic1,1:graphic5,0
 10130 bload"mejn.maco
 10140 bload"mejn.chr1
 10150 bload"mejn.chr2
 10160 sysdec("0bc0"),1,0,0
 10170 sysdec("0bc0"),2,1,0
 10180 graphicclr
 10190 bload"mejn.mdat",onb1
 10200 boot"mejn.mirq
 10210 fd$="XAMA Software presenteert":gosub10520
 10220 fd$="Een programma geschreven door Xander Arend Herman Mol":gosub10520
 10230 fd$="M{$a0}E{$a0}N{$a0}S{$a0}{$a0}{$a0}E{$a0}R{$a0}G{$a0}E{$a0}R{$a0}{$a0}{$a0}J{$a0}E{$a0}{$a0}{$a0}N{$a0}I{$a0}E{$a0}T":gosub10520
 10240 fd$="@ 1992 by XAMA Software":gosub10520
 10250 fd$="Made in The Netherlands":gosub10520
 10260 printchr$(142)
 10270 scnclr
 10280 printtab(9)"{rvon}{red}KLM{rght}{rght}{rght}{rght}{rght}{yel}NO{CBM-I}{CBM-I}LM{red}{rght}{rght}{rght}{rght}{rght}{rght}{rght}DC{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}DC{rght}{rght}DC{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}DC"
 10290 printtab(9)"{rvon}{red}{rght}{rght}KLM{rght}{yel}ROP{rght}{rght}{rght}{rght}KLM{red}{rght}{rght}{rght}{rght}DBAC{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}DBACDBAC{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}DBAC"
 10300 printtab(9)"{rvon}{red}{rght}{rght}{rght}{rght}KLM{yel}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}KL{rvof}{CBM-I}{rvon}G{red}DB{yel}IJ{red}AC{yel}H{rvof}{CBM-I}{CBM-I}{CBM-I}{CBM-I}{rvon}G{red}DB{yel}IJ{red}AB{yel}IJ{red}AC{yel}H{rvof}{CBM-I}{CBM-I}{CBM-I}{CBM-I}{rvon}G{red}DB{yel}IJ{red}AC{yel}H{rvof}{CBM-I}{CBM-I}{CBM-I}{CBM-I}{CBM-I}{CBM-I}{CBM-I}{CBM-I}"
 10310 printtab(9)"{rvon}{yel}{rght}{rght}NOQ{red}{rght}KLM{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}DB{rght}{rght}{rght}{rght}AC{rght}{rght}{rght}{rght}DB{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}AC{rght}{rght}{rght}{rght}DB{rght}{rght}{rght}{rght}AC"
 10320 printtab(9)"{rvon}{yel}NOP{red}{rght}{rght}{rght}{rght}{rght}KL{rvof}{CBM-I}{CBM-I}{CBM-I}{CBM-I}{CBM-I}{CBM-I}{CBM-I}{rvon}FB{rght}{rght}{rght}{rght}{rght}{rght}AE{rvof}{CBM-I}{CBM-I}{rvon}FB{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}AE{rvof}{CBM-I}{CBM-I}{rvon}FB{rght}{rght}{rght}{rght}{rght}{rght}AE{rvof}{CBM-I}{CBM-I}{CBM-I}{CBM-I}{CBM-I}{CBM-I}{CBM-I}{down}{down}{wht}"
 10330 fd$="S o f t w a r e   p r e s e n t e e r t   :":gosub10630
 10340 print"{down}{down}{rvon}{blu}S TS T{rght}S  T{rght}S  T{rght}S  T{rght}{rght}S  T{rght}S  T{rght}S  T{rght}S  T{rght}S  T{rght}{rght}{rght}ST{rght}S  T{rght}{rght}S  T{rght}S   T{rght}S  T{rght}S   T"
 10350 print"{rvon}{lblu} UVUV {rght} U{rght}V{rght} UV {rght} U{rght}V{rght}{rght} U{rght}V{rght} UV {rght} U{rght}V{rght} U{rght}V{rght} UV {rght}{rght}{rght}Y {rght} U{rght}V{rght}{rght} UV {rght}Y   Z{rght} U{rght}V{rght}Y   Z"
 10360 print"{rvon}{gry1} {rght}{rght}{rght}{rght} {rght}YW{rght}{rght}{rght} {rght}{rght} {rght}YW{rght}{rght}{rght}{rght}YW{rght}{rght}{rght} WXZ{rght} {rght}{rght}{rght}{rght}YW{rght}{rght}{rght} WXZ{rght}{rght}{rght}{rght} {rght}YW{rght}{rght}{rght}{rght} {rght}{rght} {rght}{rght}V U{rght}{rght}YW{rght}{rght}{rght}{rght}V U"
 10370 print"{rvon}{cyn} {rght}{rght}{rght}{rght} {rght}SU{rght}{rght}{rght} {rght}{rght} {rght}{rght}{rght}VT{rght}{rght}SU{rght}{rght}{rght}   T{rght} {rght}VT{rght}SU{rght}{rght}{rght}   T{rght}{rght}{rght}X {rght}SU{rght}{rght}{rght}{rght} {rght}{rght} {rght}{rght}X W{rght}{rght}SU{rght}{rght}{rght}{rght}{rght} "
 10380 print"{rvon}{lgrn} {rght}{rght}{rght}{rght} {rght} W{rght}X{rght} {rght}{rght} {rght}W{rght}X {rght}{rght} W{rght}X{rght} UV {rght} WX {rght} W{rght}X{rght} UV {rght}{rght}S  {rght} W{rght}X{rght}{rght} {rght}{rght} {rght}S   T{rght} W{rght}X{rght}{rght}{rght} "
 10390 print"{rvon}{grn} {rght}{rght}{rght}{rght} {rght}Y  Z{rght} {rght}{rght} {rght}Y  Z{rght}{rght}Y  Z{rght} {rght}{rght} {rght}Y  Z{rght}Y  Z{rght} {rght}{rght} {rght}{rght}Y Z{rght}Y  Z{rght}{rght} {rght}{rght} {rght}Y   Z{rght}Y  Z{rght}{rght}{rght} {down}{down}{wht}"
 10400 fd$="Geschreven door Xander{$a0}Arend Herman Mol":gosub10630
 10410 print
 10420 fd$="@ 1992 by XAMA Software":gosub10630
 10430 printchr$(14)
 10440 color5,8:gosub10680
 10450 sysdec("13a0")
 10460 print"{home}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{wht}";
 10470 fd$="Even geduld S.V.P.":gosub10630:print"{home}"chr$(27)"l"
 10480 run"mejn.mprg
 10490 :
 10500 rem "--- Fade ---
 10510 :
 10520 restore11050
 10530 forn=1to8
 10540 : readc,d
 10550 : color5,c:print"{home}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}";
 10560 : gosub10630
 10570 : forw=1tod:nextw
 10580 nextn
 10590 return
 10600 :
 10610 rem "--- Centreren ---
 10620 :
 10630 printusing"=################################################################################";fd$
 10640 return
 10650 :
 10660 rem "--- Scrolltext ---
 10670 :
 10680 window0,24,79,24:restore11070
 10690 ss$="                                                                                ":sc$=ss$
 10700 do
 10710 : iflen(sc$)<85thenbegin
 10720 :   readtx$
 10730 :   iftx$="Einde"thenrestore11070:sc$=sc$+ss$:readtx$
 10740 :   sc$=sc$+tx$
 10750 : bend
 10760 : printleft$(sc$,80)
 10770 : sc$=right$(sc$,len(sc$)-1)
 10780 : getaw$:jw=joy(2)
 10790 : ifaw$=" "orjw>=128thenexit
 10800 : forw=1to50:nextw
 10810 loop
 10820 window0,0,79,24
 10830 return
 10840 :
 10850 rem "--- Toets of knop joystick ---
 10860 :
 10870 print"{down}{lgrn}Toets.";
 10880 do
 10890 : getaw$
 10900 : jw=joy(2)
 10910 loopwhileaw$=""andjw<128
 10920 scnclr
 10930 return
 10940 :
 10950 rem "--- Foutenonderscheproutine ---
 10960 :
 10970 ifer=30thenresume
 10980 window0,0,79,24,1
 10990 print"{cyn}"err$(er)"{yel} error in regel{cyn}"el;chr$(27)"l"
 11000 help
 11010 end
 11020 :
 11030 rem "--- Data ---
 11040 :
 11050 data1,30,13,30,16,30,2,2000
 11060 data2,30,16,30,13,30,1,1000
 11070 data" ","XAMA Software presenteert:  M E{$a0}N{$a0}S   E{$a0}R{$a0}G{$a0}E{$a0}R{$a0}{$a0}{$a0}J{$a0}E{$a0}{$a0}{$a0}N{$a0}I{$a0}E{$a0}T   ! ! ! ! !    Een volledig menugestuurde, kinderlijk eenvoudig bedienbare "
 11080 data"computerversie van het wereldberoemde bordspel.   Alle regels van het bekende spel gelden ook voor deze versie.   U kunt spelen tegen Uw vrienden, "
 11090 data"of tegen de computer !    Druk op 'SPATIE' of op de joystickknop om het programma te starten.       Graag zou ik nu de volgende mensen de groeten "
 11100 data"willen doen:  Rinco, Edwin, DJ, Duncan, Jeroen, Yuri, Brouwer, Eric, Suzanne, Martine, Martijn, Bas, Timo, Wouter, Masson, Marc, Emile, Henk, "
 11110 data"Sellam, Jeannet, Liesette, Carla, alle leden van de Jonge Democraten, alle leden van D66, alle leden der Societas Studiosorum Reformatorum "
 11120 data"Roterodamensis, alle leden van Het Belgisch Dispuut Sidonia, alle leden van de Economische Faculteitsvereniging Rotterdam, alle studenten aan "
 11130 data"de Erasmus Universiteit Rotterdam, en verder iedereen die ik nog vergeten ben.         Voor  meer informatie over XAMA progammas:   XAMA Software, "
 11140 data"p.a. X.A.H. Mol, Goudse Rijweg 575-1, 3031 CG Rotterdam, Nederland.     Dit programma is geschreven door Xander Arend Herman Mol.    @ 1992 by "
 11150 data"XAMA Software.             XAMA Software.  For people who know what progress means !"
 11160 data"Einde"
 11170 :
 11180 rem "---------------------------------------------------------------------
 11190 rem "-                          Einde programma                          -
 11200 rem "---------------------------------------------------------------------
