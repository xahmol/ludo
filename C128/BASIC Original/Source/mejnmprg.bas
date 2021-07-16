 10000 rem "---------------------------------------------------------------------
 10010 rem "-        M E N S   E R G E R   J E   N I E T  Hoofdprogramma        -
 10020 rem "-              Geschreven door Xander Arend Herman Mol              -
 10030 rem "-                     (C) 1992 by XAMA Software                     -
 10040 rem "---------------------------------------------------------------------
 10050 :
 10060 trap16200:print"{home}{home}"chr$(14)
 10070 b$="{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}{CBM-@}"
 10080 o$="{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}"
 10090 ci$="0123456789"
 10100 lc$="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ{CBM-C}{CBM-F}{CBM-X}{CBM-V}{CBM--}{SHIFT-+}{SHIFT--}"+ci$
 10110 al$=lc$+" !#$%&'()"+chr$(34)+"+-@*^:[;]=,<.>/?_"
 10120 pudef" .,"
 10130 s$="                                                                                "
 10140 ad=4
 10150 gosub14660
 10160 gosub10720
 10170 xc=40:yc=8:b=35:h=6:gosub16100
 10180 window42,10,79,24
 10190 print"{yel}Wilt U een oud spel laden ?"
 10200 xc=69:yc=11:mn=3:gosub15130
 10210 gosub15090
 10220 ifm=1thengosub13370
 10230 do
 10240 : gosub10440
 10250 : ifei<>2thengosub11450:gosub11300:elseei=0:gosub13850
 10260 : do
 10270 :   window60,3,79,24,1
 10280 :   print"{yel}Speler{cyn}"bs+1"{yel}:";:color5,sp(bs,2):print" {rvon}  {rvof}"
 10290 :   print"{down}{lgrn}"sp$(bs)
 10300 :   ifsp(bs,0)=0thengosub11770:elseprint"{yel}{down}De computer speelt."
 10310 :   ifei<>0thenexit
 10320 :   gosub11900
 10330 :   ifsp(bs,1)=0thengosub14000
 10340 :   ifei<>0thenexit
 10350 :   do
 10360 :     ifzv=1thenzv=0:elsenp(ns)=-1:bs=bs+1:ifbs>3thenbs=0
 10370 :   loopwhilezv=0andsp(bs,1)=0
 10380 : loopwhileei=0
 10390 loopuntilei=1
 10400 goto16260
 10410 :
 10420 rem "--- Beeldschermopbouw ---
 10430 :
 10440 print"{home}{home}{clr}{rvon}{lgrn} Mens erger je niet !                   Geschreven door Xander Arend Herman Mol "
 10450 gosub14960
 10460 printchr$(142)"{down}{rvon}{rght}uv{rght}{rght}{rght}uv{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{wht}efgh{rght}efgh{rght}{red}m01p{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}uv{rght}{rght}{rght}uv"
 10470 print"{rvon}{grn}{rght}wx{rght}{rght}{rght}wx{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{wht}ijkl{rght}ijkl{rght}{red}q23t{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}wx{rght}{rght}{rght}wx"
 10480 print"{rvon}{grn}{rght}uv{rght}{rght}{rght}uv{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{wht}efgh{rght}{red}mnop{wht}{rght}efgh{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{red}{rght}uv{rght}{rght}{rght}uv"
 10490 print"{rvon}{grn}{rght}wx{rght}{rght}{rght}wx{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{wht}ijkl{rght}{red}qrst{wht}{rght}ijkl{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{red}{rght}wx{rght}{rght}{rght}wx"
 10500 print"{rvon}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{wht}efgh{rght}{red}mnop{wht}{rght}efgh"
 10510 print"{rvon}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}ijkl{rght}{red}qrst{wht}{rght}ijkl"
 10520 print"{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{cyn}Mens{rvon}{wht}{rght}efgh{rght}{red}mnop{wht}{rght}efgh{rght}{cyn}{rvof}Erger{wht}"
 10530 print"{rvon}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}ijkl{rght}{red}qrst{wht}{rght}ijkl"
 10540 print"{rvon}{grn}m'(p{rght}{wht}efgh{rght}efgh{rght}efgh{rght}efgh{rght}{red}mnop{wht}{rght}efgh{rght}efgh{rght}efgh{rght}efgh{rght}efgh"
 10550 print"{rvon}{grn}q)*t{rght}{wht}ijkl{rght}ijkl{rght}ijkl{rght}ijkl{rght}{red}qrst{wht}{rght}ijkl{rght}ijkl{rght}ijkl{rght}ijkl{rght}ijkl"
 10560 print"{rvon}efgh{rght}{grn}mnop{rght}mnop{rght}mnop{rght}mnop{rght}{rght}{rght}{rght}{rght}{rght}{blu}mnop{rght}mnop{rght}mnop{rght}mnop{rght}{wht}efgh"
 10570 print"{rvon}ijkl{rght}{grn}qrst{rght}qrst{rght}qrst{rght}qrst{rght}{rght}{rght}{rght}{rght}{rght}{blu}qrst{rght}qrst{rght}qrst{rght}qrst{rght}{wht}ijkl"
 10580 print"{rvon}efgh{rght}efgh{rght}efgh{rght}efgh{rght}efgh{rght}{yel}mnop{rght}{wht}efgh{rght}efgh{rght}efgh{rght}efgh{rght}{blu}m#$p"
 10590 print"{rvon}{wht}ijkl{rght}ijkl{rght}ijkl{rght}ijkl{rght}ijkl{rght}{yel}qrst{rght}{wht}ijkl{rght}ijkl{rght}ijkl{rght}ijkl{rght}{blu}q%&t"
 10600 print"{rvon}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{wht}efgh{rght}{yel}mnop{wht}{rght}efgh"
 10610 print"{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{cyn}Je{rvon}{wht}{rght}ijkl{rght}{yel}qrst{wht}{rght}ijkl{rght}{cyn}{rvof}Niet{wht}"
 10620 print"{rvon}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}efgh{rght}{yel}mnop{wht}{rght}efgh"
 10630 print"{rvon}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}ijkl{rght}{yel}qrst{wht}{rght}ijkl"
 10640 print"{rvon}{rght}{yel}uv{rght}{rght}{rght}uv{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{wht}efgh{rght}{yel}mnop{rght}{wht}efgh{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{blu}uv{rght}{rght}{rght}uv"
 10650 print"{rvon}{yel}{rght}wx{rght}{rght}{rght}wx{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{wht}ijkl{rght}{yel}qrst{rght}{wht}ijkl{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{blu}wx{rght}{rght}{rght}wx"
 10660 print"{rvon}{yel}{rght}uv{rght}{rght}{rght}uv{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}m45p{rght}{wht}efgh{rght}efgh{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{blu}{rght}uv{rght}{rght}{rght}uv"
 10670 print"{rvon}{yel}{rght}wx{rght}{rght}{rght}wx{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}q67t{rght}{wht}ijkl{rght}ijkl{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{blu}{rght}wx{rght}{rght}{rght}wx{rvof}";chr$(14);
 10680 return
 10690 :
 10700 rem "--- Initialisatie ---
 10710 :
 10720 dimvc(39,1),rc(3,7,1),sp$(3),sp(3,3),dn$(5),sc(3,3,1),pm(3),np(3),pw(3)
 10730 restore16490
 10740 forn=0to39:readvc(n,0),vc(n,1):nextn
 10750 forn=0to3
 10760 : form=0to7:readrc(n,m,0),rc(n,m,1):nextm
 10770 nextn
 10780 forn=0to3:readsp(n,2):nextn
 10790 forn=0to5:readdn$(n):nextn
 10800 return
 10810 :
 10820 rem "--- Coordinaten pion ---
 10830 :
 10840 ifsc(bs,pn,0)=0thenbegin
 10850 : xc=vc(sc(bs,pn,1),0):yc=vc(sc(bs,pn,1),1)
 10860 bend:elsebegin
 10870 : xc=rc(bs,sc(bs,pn,1),0):yc=rc(bs,sc(bs,pn,1),1)
 10880 bend
 10890 windowxc-1,yc,79,24
 10900 return
 10910 :
 10920 rem "--- Wis pion ---
 10930 :
 10940 gosub10840
 10950 printchr$(142);
 10960 ifsc(bs,pn,0)=0andsc(bs,pn,1)/10=int(sc(bs,pn,1)/10)thenbegin
 10970 : color5,sp(sc(bs,pn,1)/10,2)
 10980 : ifsc(bs,pn,1)=0thenprint"{rvon}m'(p":print"{rvon}q)*t";
 10990 : ifsc(bs,pn,1)=10thenprint"{rvon}m01p":print"{rvon}q23t";
 11000 : ifsc(bs,pn,1)=20thenprint"{rvon}m#$p":print"{rvon}q%&t";
 11010 : ifsc(bs,pn,1)=30thenprint"{rvon}m45p":print"{rvon}q67t";
 11020 bend:elsebegin
 11030 : ifsc(bs,pn,0)=0thenprint"{rvon}{wht}efgh":print"{rvon}ijkl";:elsecolor5,sp(bs,2):print"{rvon}mnop":print"{rvon}qrst";
 11040 bend
 11050 print"{rvof}"chr$(14);
 11060 return
 11070 :
 11080 rem "--- Zet pion ---
 11090 :
 11100 gosub10840
 11110 color5,sp(bs,2)
 11120 printchr$(142)" {rvon}uv{rvof} {down}{left}{left}{left}{left} {rvon}wx{rvof} ";chr$(14);
 11130 return
 11140 :
 11150 rem "--- Dobbelen ---
 11160 :
 11170 xc=60:yc=12:b=8:h=6:gosub16100
 11180 forn=1to50
 11190 : window62,14,79,24
 11200 : dg=int(rnd(ti)*6)+1
 11210 : print" ";dn$(dg-1);
 11220 : forw=1to20:nextw
 11230 nextn
 11240 print
 11250 print"{lgrn}Toets.";:gosub16320:gosub15090
 11260 return
 11270 :
 11280 rem "--- Ingeven namen ---
 11290 :
 11300 xc=30:yc=8:b=45:h=6:gosub16100
 11310 forsp=0to3
 11320 : window32,10,74,14,1
 11330 : print"{yel}Moet de computer voor speler{cyn}"sp+1"{yel}spelen ?"
 11340 : xc=69:yc=11:mn=3:gosub15130
 11350 : ifm=1thensp(sp,0)=1:elsesp(sp,0)=0
 11360 : window32,10,74,14,1
 11370 : print"{yel}Geef nu de naam van speler{cyn}"sp+1"{yel}in :"
 11380 : xc=32:yc=12:ml=20:tt$=al$:gosub15740:sp$(sp)=an$
 11390 nextsp
 11400 gosub15090
 11410 return
 11420 :
 11430 rem "--- Spel reset ---
 11440 :
 11450 bs=0:ei=0
 11460 forn=0to3
 11470 : sp(n,1)=4:sp(n,3)=4:np(n)=-1:dp(n)=8
 11480 : form=0to3
 11490 :   sc(n,m,0)=1:sc(n,m,1)=m
 11500 : nextm
 11510 nextn
 11520 return
 11530 :
 11540 rem "--- Informatie ---
 11550 :
 11560 xc=30:yc=8:b=45:h=11:gosub16100:b=b-1
 11570 window31,10,79,24
 11580 color5,2:ct$="M E N S   E R G E R   J E   N I E T":gosub16360:print
 11590 color5,14:ct$="Geschreven door Xander Arend Herman Mol":gosub16360:print
 11600 color5,4:ct$="@ 1992 by XAMA Software":gosub16360:print
 11610 color5,11:ct$="Made in the Netherlands":gosub16360:print
 11620 color5,8:ct$="Druk op een toets.":gosub16360
 11630 gosub16320:gosub15090
 11640 return
 11650 :
 11660 rem "--- Zeker weten ? ---
 11670 :
 11680 xc=45:yc=8:b=30:h=6:gosub16100
 11690 window47,10,79,24
 11700 print"{yel}Weet U het zeker ?"
 11710 xc=69:yc=11:mn=3:gosub15130
 11720 gosub15090
 11730 return
 11740 :
 11750 rem "--- Beurt speler ---
 11760 :
 11770 do
 11780 : gosub15520
 11790 : ifmn=1andm=1thenexit
 11800 : ifmn=1andm=2thengosub11680:ifm=1thenei=3:exit
 11810 : ifmn=1andm=3thengosub11680:ifm=1thenei=1:exit
 11820 : ifmn=1andm=4thengosub11560
 11830 : ifmn=2andm=1thengosub12920
 11840 : ifmn=2andm=2thengosub11680:ifm=1thengosub13370:exit
 11850 loop
 11860 return
 11870 :
 11880 rem "--- Beurt algemeen ---
 11890 :
 11900 ga=1:gb=0:mp=0:pn=-1:ap=0:zv=0
 11910 forn=0to3:pm(n)=0:nextn
 11920 ifsp(bs,3)=sp(bs,1)thenga=3:window60,8,79,24:print"{yel}{down}U mag 3 keer gooien."
 11930 ford=1toga
 11940 : gosub11170
 11950 : ifdg=6thend=ga
 11960 nextd
 11970 ifsp(bs,3)=sp(bs,1)anddg<>6thengb=1
 11980 ifnp(bs)>-1thenifsp(bs,3)>0thenpn=np(bs):np(bs)=-1:elsenp(bs)=-1
 11990 ifgb=0andpn=-1thenbegin
 12000 : forn=0to3
 12010 :   vr=sc(bs,n,0):vl=sc(bs,n,1):gv=0
 12020 :   ifvr=1andvl<4thengv=1:ifdg=6thenpn=n:np(bs)=n:n=3
 12030 :   ifgv=0thenbegin
 12040 :     vn=vl+dg:nr=vr
 12050 :     ifvr=0thenbegin
 12060 :       ifbs=0andvn>39andvl<40thenvn=vn-36:nr=1
 12070 :       ifbs=1andvn>9andvl<10thenvn=vn-6:nr=1
 12080 :       ifbs=2andvn>19andvl<20thenvn=vn-16:nr=1
 12090 :       ifbs=3andvn>29andvl<30thenvn=vn-26:nr=1
 12100 :     bend
 12110 :     ifnr=1thenbegin
 12120 :       ifvn>7thengv=1:elsebegin
 12130 :         form=0to3
 12140 :           ifn<>mandsc(bs,m,0)=1andsc(bs,m,1)<=vnandsc(bs,m,1)>3thengv=1:m=3
 12150 :         nextm
 12160 :       bend
 12170 :     bend
 12180 :     ifgv=0thenpm(n)=1
 12190 :   bend
 12200 : nextn
 12210 bend
 12220 ifpn=-1thenbegin
 12230 : forn=0to3
 12240 :   ifpm(n)=1thenap=ap+1:pn=n
 12250 : nextn
 12260 bend:elseap=1
 12270 ifap>1thenbegin
 12280 : ifsp(bs,0)=0thengosub12610:elsegosub14150
 12290 bend
 12300 ifdg=6thenzv=1
 12310 ifap=0orgb=1thenwindow60,9,79,24,1:print"{yel}U kunt niet.":print"{lgrn}{down}Toets.":gosub16320:return
 12320 gosub10940
 12330 ov=sc(bs,pn,1):ro=sc(bs,pn,0)
 12340 ifro=1andov<4thensc(bs,pn,0)=0:sc(bs,pn,1)=bs*10:sp(bs,3)=sp(bs,3)-1:elsesc(bs,pn,1)=sc(bs,pn,1)+dg
 12350 ifbs=0andsc(bs,pn,1)>39andov<40andro=0thensc(bs,pn,0)=1:sc(bs,pn,1)=sc(bs,pn,1)-36
 12360 ifbs=1andsc(bs,pn,1)>9andov<10andro=0thensc(bs,pn,0)=1:sc(bs,pn,1)=sc(bs,pn,1)-6
 12370 ifbs=2andsc(bs,pn,1)>19andov<20andro=0thensc(bs,pn,0)=1:sc(bs,pn,1)=sc(bs,pn,1)-16
 12380 ifbs=3andsc(bs,pn,1)>29andov<30andro=0thensc(bs,pn,0)=1:sc(bs,pn,1)=sc(bs,pn,1)-26
 12390 ifsc(bs,pn,0)=1andsc(bs,pn,1)>3thendp(bs)=sc(bs,pn,1)
 12400 ifsc(bs,pn,1)=sp(bs,1)+3andsc(bs,pn,0)=1thensp(bs,1)=sp(bs,1)-1
 12410 ifsc(bs,pn,1)>39thensc(bs,pn,1)=sc(bs,pn,1)-40
 12420 ap=0:as=-1
 12430 forsp=0to3
 12440 : forpi=0to3
 12450 :   ifnot(pi=pnandsp=bs)andsc(sp,pi,0)=0andsc(bs,pn,0)=0andsc(sp,pi,1)=sc(bs,pn,1)thenap=pi:as=sp:pi=3:sp=3
 12460 : nextpi
 12470 nextsp
 12480 ifas<>-1thenbegin
 12490 : h1=bs:h2=pn
 12500 : bs=as:pn=ap
 12510 : gosub10940
 12520 : sc(bs,pn,0)=1:sc(bs,pn,1)=pn:sp(bs,3)=sp(bs,3)+1
 12530 : gosub11100
 12540 : bs=h1:pn=h2
 12550 bend
 12560 gosub11100
 12570 return
 12580 :
 12590 rem "--- Kies pion speler ---
 12600 :
 12610 xc=60:yc=10:b=18:h=3:gosub16100
 12620 window62,12,79,24
 12630 print"{yel}Welke pion ?"
 12640 print"{home}{home}"
 12650 pn=0
 12660 do
 12670 : ifpm(pn)=1thenexit
 12680 : pn=pn+1
 12690 loop
 12700 do
 12710 : poke241,peek(241)or16:ri=0
 12720 : gosub11100
 12730 : jm=1:tt$="{up}{down}{left}{rght}"+chr$(13):tj$="11111111":gosub15380
 12740 : poke241,peek(241)and239:gosub11100
 12750 : ifaw$="{left}"oraw$="{down}"orjw=5orjw=6orjw=7orjw=8thenpn=pn-1:ri=-1
 12760 : ifaw$="{rght}"oraw$="{up}"orjw=1orjw=2orjw=3orjw=4thenpn=pn+1:ri=1
 12770 : ifaw$=chr$(13)orjw>=128thenexit
 12780 : ifpn>3thenpn=0
 12790 : ifpn<0thenpn=3
 12800 : do
 12810 :   ifpm(pn)=1thenexit
 12820 :   pn=pn+ri
 12830 :   ifpn>3thenpn=0
 12840 :   ifpn<0thenpn=3
 12850 : loop
 12860 loop
 12870 gosub15090
 12880 return
 12890 :
 12900 rem "--- Saven spel ---
 12910 :
 12920 xc=40:yc=8:b=35:h=7:gosub16100
 12930 window42,10,79,24
 12940 print"{lgrn}Saven spel"
 12950 print"{lred}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}"
 12960 print"{yel}Geef bestandsnaam :"
 12970 xc=42:yc=14:ml=11:tt$=al$:gosub15740:gosub15090:ifan$=""thenreturn
 12980 an$=an$+left$(s$,11-len(an$))+".mejn"
 12990 dopen#1,(an$),w
 13000 dclose#1
 13010 ifds<>63andds<>0thengosub16410:return
 13020 ifds=63thenbegin
 13030 : xc=40:yc=8:b=35:h=8:gosub16100
 13040 : window42,10,79,24
 13050 : print"{yel}Bestand bestaat al."
 13060 : print"{down}Moet dit vervangen worden ?"
 13070 : xc=69:yc=13:mn=3:gosub15130
 13080 : gosub15090
 13090 : ifm=2thenreturn
 13100 bend
 13110 scratch(an$)
 13120 dopen#1,(an$),w
 13130 : print#1,bs
 13140 : forn=0to3
 13150 :   print#1,np(n)
 13160 : nextn
 13170 : forn=0to3
 13180 :   form=0to3
 13190 :     print#1,sp(n,m)
 13200 :   nextm
 13210 : nextn
 13220 : forn=0to3
 13230 :   form=0to3
 13240 :     print#1,sc(n,m,0)
 13250 :     print#1,sc(n,m,1)
 13260 :   nextm
 13270 : nextn
 13280 : forn=0to3
 13290 :   print#1,sp$(n)
 13300 : nextn
 13310 dclose#1
 13320 gosub16410
 13330 return
 13340 :
 13350 rem "--- Laden spel ---
 13360 :
 13370 xc=40:yc=8:b=35:h=8:gosub16100
 13380 window42,10,79,24
 13390 print"{lgrn}Laden oud spel"
 13400 print"{lred}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}{CBM-T}"
 13410 print"{yel}Wilt U de directory zien ?"
 13420 xc=69:yc=13:mn=3:gosub15130
 13430 window42,12,74,16,1:print"{home}{home}"
 13440 ifm=1thenbegin
 13450 : xc=40:yc=3:b=35:h=18:gosub16100
 13460 : window42,5,74,18:print"{cyn}";
 13470 : catalog"???????????.mejn"
 13480 : print"{home}{home}"
 13490 : window42,20,79,24
 13500 : print"{lgrn}Toets.":gosub16320:gosub15090
 13510 bend
 13520 window42,12,79,24
 13530 print"{yel}Bestandsnaam (zonder .mejn) :"
 13540 xc=42:yc=14:ml=11:tt$=al$:gosub15740:gosub15090:ifan$=""thenreturn
 13550 an$=an$+left$(s$,11-len(an$))+".mejn"
 13560 dopen#1,(an$)
 13570 dclose#1
 13580 ifds<>0thengosub16410:return
 13590 dopen#1,(an$)
 13600 : input#1,bs
 13610 : forn=0to3
 13620 :   input#1,np(n)
 13630 : nextn
 13640 : forn=0to3
 13650 :   form=0to3
 13660 :     input#1,sp(n,m)
 13670 :   nextm
 13680 : nextn
 13690 : forn=0to3
 13700 :   form=0to3
 13710 :     input#1,sc(n,m,0)
 13720 :     input#1,sc(n,m,1)
 13730 :   nextm
 13740 : nextn
 13750 : forn=0to3
 13760 :   input#1,sp$(n)
 13770 : nextn
 13780 dclose#1
 13790 ifds=0thenei=2
 13800 gosub16410
 13810 return
 13820 :
 13830 rem "--- Zet pionnen na laden ---
 13840 :
 13850 h1=bs
 13860 forbs=0to3
 13870 : forpn=0to3
 13880 :   h2=sc(bs,pn,0):h3=sc(bs,pn,1)
 13890 :   sc(bs,pn,0)=1:sc(bs,pn,1)=pn
 13900 :   gosub10940
 13910 :   sc(bs,pn,0)=h2:sc(bs,pn,1)=h3
 13920 :   gosub11100
 13930 : nextpn
 13940 nextbs
 13950 bs=h1
 13960 return
 13970 :
 13980 rem "--- Gewonnen ! ---
 13990 :
 14000 xc=35:yc=8:b=40:h=9:gosub16100
 14010 window37,10,79,24
 14020 print"{lgrn}"sp$(bs)"{yel} heeft gewonnen !"
 14030 print"{lred}"left$(o$,len(sp$(bs))+17)
 14040 print"{yel}Wat wilt U nu ?"
 14050 do
 14060 : xc=59:yc=13:mn=5:gosub15130
 14070 loopwhilem=1andsp(0,1)=0andsp(1,1)=0andsp(2,1)=0andsp(3,1)=0
 14080 ifm=2thenei=3:zv=1
 14090 ifm=3thenei=1:zv=1
 14100 gosub15090
 14110 return
 14120 :
 14130 rem "--- Pion kiezen computer ---
 14140 :
 14150 forn=0to3:pw(n)=0:nextn
 14160 forn=0to3
 14170 : do
 14180 :   ifpm(n)=0thenpw(n)=-10000:exit
 14190 :   vr=sc(bs,n,0):vn=sc(bs,n,1)
 14200 :   nn=vn+dg:no=nn:nr=vr
 14210 :   ifvr=0thenbegin
 14220 :     ifbs=0andnn>39andvn<40thennn=nn-36:nr=1
 14230 :     ifbs=1andnn>9andvn<10thennn=nn-6:nr=1
 14240 :     ifbs=2andnn>19andvn<20thennn=nn-16:nr=1
 14250 :     ifbs=3andnn>29andvn<30thennn=nn-26:nr=1
 14260 :   bend
 14270 :   ifnr=0andnn>39thennn=nn-40
 14280 :   ifnr=1andnn>3andsp(bs,1)=1thenpw(n)=10000:n=3:exit
 14290 :   ifnr=1andnn>3thenpw(n)=pw(n)+6000
 14300 :   forsp=0to3
 14310 :     forpi=0to3
 14320 :       ifbs=spandsc(sp,pi,0)=nrandsc(sp,pi,1)=nnthenpw(n)=pw(n)-8000
 14330 :       ifbs<>spandsc(sp,pi,0)=nrandsc(sp,pi,1)=nnthenbegin
 14340 :         pw(n)=pw(n)+4000
 14350 :         ifsc(sp,pi,0)=0thenbegin
 14360 :           ifsp=0andsc(sp,pi,1)>33thenpw(n)=pw(n)+3000
 14370 :           ifsp=1andsc(sp,pi,1)>3thenpw(n)=pw(n)+3000
 14380 :           ifsp=2andsc(sp,pi,1)>13thenpw(n)=pw(n)+3000
 14390 :           ifsp=3andsc(sp,pi,1)>23thenpw(n)=pw(n)+3000
 14400 :         bend
 14410 :       bend
 14420 :       ifsc(sp,pi,0)=0andnr=0andbs<>spthenbegin
 14430 :         if(vn-sc(sp,pi,1))<6and(vn-sc(sp,pi,1))>0thenpw(n)=pw(n)+400
 14440 :         if(no-sc(sp,pi,1))<6and(no-sc(sp,pi,1))>0thenpw(n)=pw(n)-200
 14450 :         if(sc(sp,pi,1)-nn)<6and(sc(sp,pi,1)-nn)>0thenpw(n)=pw(n)+100
 14460 :       bend
 14470 :     nextpi
 14480 :   nextsp
 14490 :   ifnr=0and(nn=0ornn=10ornn=20ornn=30)thenpw(n)=pw(n)-4000
 14500 :   ifvr=0and(vn=0orvn=10orvn=20orvn=30)thenpw(n)=pw(n)+2000
 14510 :   ifbs=0thenpw(n)=pw(n)+nn
 14520 :   ifbs=1thenpw(n)=pw(n)+(no-10)
 14530 :   ifbs=2thenpw(n)=pw(n)+(no-20)
 14540 :   ifbs=3thenpw(n)=pw(n)+(no-30)
 14550 :   exit
 14560 : loop
 14570 nextn
 14580 mw=-20000
 14590 forn=0to3
 14600 : ifpw(n)>mwthenmw=pw(n):pn=n
 14610 nextn
 14620 return
 14630 :
 14640 rem "--- Lezen menudata ---
 14650 :
 14660 restore16670
 14670 readmn,dn
 14680 dimmn$(mn+dn+2,16),mn(mn+dn+2),mc(mn,1)
 14690 mc=1:mn(0)=mn
 14700 forn=1tomn(0)
 14710 : readmn$(n,0)
 14720 : readmn(n)
 14730 : mc(n,0)=mc:mc(n,1)=mc+len(mn$(n,0)):mc=mc(n,1)+1:ml=0
 14740 : form=1tomn(n)
 14750 :   readmn$(n,m)
 14760 :   iflen(mn$(n,m))>mlthenml=len(mn$(n,m))
 14770 : nextm
 14780 : form=1tomn(n)
 14790 :   mn$(n,m)=mn$(n,m)+left$(s$,ml-len(mn$(n,m)))
 14800 : nextm
 14810 nextn
 14820 forn=1todn
 14830 : readmn(mn(0)+n):ml=0
 14840 : form=1tomn(mn(0)+n)
 14850 :   readmn$(mn(0)+n,m)
 14860 :   iflen(mn$(mn(0)+n,m))>mlthenml=len(mn$(mn(0)+n,m))
 14870 : nextm
 14880 : form=1tomn(mn(0)+n)
 14890 :   mn$(mn(0)+n,m)=mn$(mn(0)+n,m)+left$(s$,ml-len(mn$(mn(0)+n,m)))
 14900 : nextm
 14910 nextn
 14920 return
 14930 :
 14940 rem "--- Menuregel ---
 14950 :
 14960 color5,6:window0,1,79,24:print"{rvon} ";
 14970 forn=1tomn(0)
 14980 : print"{rvon}"mn$(n,0)" {rvof}";
 14990 nextn
 15000 print"{rvon}"left$(s$,79-mc(mn(0),1))
 15010 return
 15020 :
 15030 rem "--- Beeld opslaan ---
 15040 :
 15050 sysdec("0b33"),0,ad:ad=ad+16:print"{home}{home}":return
 15060 :
 15070 rem "--- Beeld terughalen ---
 15080 :
 15090 ad=ad-16:sysdec("0c6a"),16,ad:sysdec("0b7a"),16,0:print"{home}{home}":return
 15100 :
 15110 rem "--- Menu ---
 15120 :
 15130 gosub15050
 15140 ifmn>mn(0)thenwindowxc,yc,79,24:print"{lred}{SHIFT-POUND}"left$(b$,2+len(mn$(mn,1)))"{CBM-Q}"
 15150 forn=1tomn(mn)
 15160 : windowxc,yc+n,79,24:print"{lred}{CBM-N}{rvon}{cyn} "mn$(mn,n)" {rvof}{lred}{CBM-H}"
 15170 nextn
 15180 windowxc,yc+n,79,24:print"{lred}{CBM-Z}"left$(o$,2+len(mn$(mn,1)))"{CBM-S}"
 15190 m=1:tt$="{up}{down}"+chr$(13):tj$="11011101"
 15200 ifmn<=mn(0)thentt$=tt$+"{left}{rght}":tj$="11111111"
 15210 do
 15220 : windowxc+1,yc+m,79,24:print"{rvon}{yel} "mn$(mn,m)" {rvof}"
 15230 : jm=1:gosub15380:jm=0
 15240 : ifaw$=chr$(13)orjw>=128thenexit
 15250 : ifaw$="{left}"orjw=7thenm=0:poke208,1:poke842,asc("{left}"):exit
 15260 : ifaw$="{rght}"orjw=3thenm=0:poke208,1:poke842,asc("{rght}"):exit
 15270 : windowxc+1,yc+m,79,24:print"{rvon}{cyn} "mn$(mn,m)" {rvof}"
 15280 : ifaw$="{up}"orjw=1orjw=2orjw=8thenm=m-1
 15290 : ifaw$="{down}"orjw=4orjw=5orjw=6thenm=m+1
 15300 : ifm>mn(mn)thenm=1
 15310 : ifm<1thenm=mn(mn)
 15320 loop
 15330 gosub15090
 15340 return
 15350 :
 15360 rem "--- Vraag toets ---
 15370 :
 15380 do
 15390 : getaw$
 15400 : ifjm=1thenbegin
 15410 :   jw=joy(2)
 15420 :   ifjw<>0thenbegin
 15430 :     ifjw<128thenifmid$(tj$,jw,1)="1"thenexit
 15440 :     ifjw>=128thenexit
 15450 :   bend
 15460 : bend
 15470 loopwhileinstr(tt$,aw$)=0
 15480 return
 15490 :
 15500 rem "--- Hoofdmenu ---
 15510 :
 15520 mn=1:m=0
 15530 do
 15540 : do
 15550 :   windowmc(mn,0),1,79,24:print"{rvon}{wht}"mn$(mn,0)"{rvof}"
 15560 :   tt$="{left}{rght}"+chr$(13):tj$="01110111"
 15570 :   jm=1:gosub15380:jm=0
 15580 :   ifaw$=chr$(13)orjw>=128thenexit
 15590 :   windowmc(mn,0),1,79,24:print"{rvon}{grn}"mn$(mn,0)"{rvof}"
 15600 :   ifaw$="{left}"orjw=6orjw=7orjw=8thenmn=mn-1
 15610 :   ifaw$="{rght}"orjw=2orjw=3orjw=4thenmn=mn+1
 15620 :   ifmn<1thenmn=mn(0)
 15630 :   ifmn>mn(0)thenmn=1
 15640 : loop
 15650 : xc=mc(mn,0)-1:yc=1
 15660 : ifxc+len(mn$(mn,1))>79thenxc=mc(mn,1)-len(mn$(mn,1))
 15670 : gosub15130
 15680 loopuntilm
 15690 windowmc(mn,0),1,79,24:print"{rvon}{grn}"mn$(mn,0)"{rvof}":print"{home}{home}"
 15700 return
 15710 :
 15720 rem "--- Input ---
 15730 :
 15740 an$="":kn=1
 15750 tt$=tt$+chr$(13)+chr$(20)+chr$(148)+"{left}{rght}"
 15760 do
 15770 : ifkn<=len(an$)thenbegin
 15780 :   windowxc,yc,79,24:print"{cyn}"left$(an$,kn-1)"{rvon}"mid$(an$,kn,1)"{rvof}"right$(an$,len(an$)-kn)"{grn}"left$(b$,ml-len(an$))
 15790 : bend:elsebegin
 15800 :   windowxc,yc,79,24:print"{cyn}"an$"{rvon} {rvof}{grn}"left$(b$,ml-len(an$)-1)
 15810 : bend
 15820 : gosub15380
 15830 : ifaw$=chr$(13)thenexit
 15840 : ifinstr(chr$(20)+chr$(148)+"{left}{rght}",aw$)=0thenbegin
 15850 :   ifkn<=len(an$)thenbegin
 15860 :     an$=left$(an$,kn-1)+aw$+right$(an$,len(an$)-kn)
 15870 :   bend:elsebegin
 15880 :     an$=an$+aw$
 15890 :   bend
 15900 :   kn=kn+1
 15910 : bend:elsebegin
 15920 :   ifaw$=chr$(20)andlen(an$)>0andkn<=len(an$)thenbegin
 15930 :     an$=left$(an$,kn-2)+right$(an$,len(an$)-kn+1):kn=kn-1
 15940 :   bend
 15950 :   ifaw$=chr$(20)andlen(an$)>0andkn>len(an$)thenbegin
 15960 :     an$=left$(an$,len(an$)-1):kn=kn-1
 15970 :   bend
 15980 :   ifaw$="{left}"andkn>1thenkn=kn-1
 15990 :   ifaw$="{rght}"andkn<len(an$)+1thenkn=kn+1
 16000 :   ifaw$=chr$(148)andkn<=len(an$)andlen(an$)<mlthenbegin
 16010 :     an$=left$(an$,kn-1)+" "+right$(an$,len(an$)-kn+1)
 16020 :   bend
 16030 : bend
 16040 loopuntil(len(an$)=mlandkn=len(an$)+1)
 16050 windowxc,yc,79,24:print"{cyn}"an$left$(s$,ml-len(an$))
 16060 return
 16070 :
 16080 rem "--- Maak kader ---
 16090 :
 16100 color5,11:gosub15050
 16110 windowxc,yc,79,24:print"{SHIFT-POUND}"left$(b$,b)"{CBM-Q}"
 16120 forn=1toh
 16130 : windowxc,yc+n,79,24:print"{CBM-N}"left$(s$,b)"{CBM-H}"
 16140 nextn
 16150 windowxc,yc+h+1,79,24:print"{CBM-Z}"left$(o$,b)"{CBM-S}{yel}";:print"{home}{home}"
 16160 return
 16170 :
 16180 rem "--- Foutenonderscheproutine ---
 16190 :
 16200 xc=4:yc=8:b=68:h=9:gosub16100
 16210 window6,10,79,24:print"{cyn}"err$(er)"{yel} error in regel{cyn}"el
 16220 print"{yel}{down}Wat wilt U ?"
 16230 xc=61:yc=14:mn=4:gosub15130
 16240 gosub15090
 16250 ifm=1thenrun
 16260 window0,2,79,24,1:window0,0,79,24
 16270 print"{yel}{down}{down}{down}{down}{down}Tot ziens."
 16280 poke208,0:end
 16290 :
 16300 rem "--- Toets of knop joy ---
 16310 :
 16320 poke208,0:tt$=al$+chr$(13):tj$="00000000":jm=1:gosub15380:jm=0:return
 16330 :
 16340 rem "--- Centreren ---
 16350 :
 16360 printusing("="+left$("################################################################################",b));ct$
 16370 return
 16380 :
 16390 rem "--- Discfout ---
 16400 :
 16410 xc=5:yc=8:b=70:h=5:gosub16100
 16420 window7,10,79,24
 16430 print"{cyn}"ds$
 16440 print"{down}{lgrn}Toets.":gosub16320:gosub15090
 16450 return
 16460 :
 16470 rem "--- Data voor spel ---
 16480 :
 16490 data1,11,6,11,11,11,16,11,21,11,21,9,21,7,21,5,21,3,26,3
 16500 data31,3,31,5,31,7,31,9,31,11,36,11,41,11,46,11,51,11,51,13
 16510 data51,15,46,15,41,15,36,15,31,15,31,17,31,19,31,21,31,23,26,23
 16520 data21,23,21,21,21,19,21,17,21,15,16,15,11,15,6,15,1,15,1,13
 16530 data1,3,6,3,1,5,6,5,6,13,11,13,16,13,21,13
 16540 data46,3,51,3,46,5,51,5,26,5,26,7,26,9,26,11
 16550 data46,21,51,21,46,23,51,23,46,13,41,13,36,13,31,13
 16560 data1,21,6,21,1,23,6,23,26,21,26,19,26,17,26,15
 16570 data6,3,7,8
 16580 data"{wht}{rvon}   {rvof}{CBM-K}{down}{left}{left}{left}{left}{rvon} {SHIFT-@} {rvof}{CBM-K}{down}{left}{left}{left}{left}{rvon}{CBM-I}{CBM-I}{CBM-I}{rvof}~"
 16590 data"{wht}{rvon}{CBM-U}  {rvof}{CBM-K}{down}{left}{left}{left}{left}{rvon}  {CBM-U}{rvof}{CBM-K}{down}{left}{left}{left}{left}{rvon}{CBM-I}{CBM-I}{CBM-I}{rvof}~"
 16600 data"{wht}{rvon}{CBM-U}  {rvof}{CBM-K}{down}{left}{left}{left}{left}{rvon} {SHIFT-@}{CBM-U}{rvof}{CBM-K}{down}{left}{left}{left}{left}{rvon}{CBM-I}{CBM-I}{CBM-I}{rvof}~"
 16610 data"{wht}{rvon}{CBM-U} {CBM-U}{rvof}{CBM-K}{down}{left}{left}{left}{left}{rvon}{CBM-U} {CBM-U}{rvof}{CBM-K}{down}{left}{left}{left}{left}{rvon}{CBM-I}{CBM-I}{CBM-I}{rvof}~"
 16620 data"{wht}{rvon}{CBM-U} {CBM-U}{rvof}{CBM-K}{down}{left}{left}{left}{left}{rvon}{CBM-U}{SHIFT-@}{CBM-U}{rvof}{CBM-K}{down}{left}{left}{left}{left}{rvon}{CBM-I}{CBM-I}{CBM-I}{rvof}~"
 16630 data"{wht}{rvon}{CBM-U}{CBM-U}{CBM-U}{rvof}{CBM-K}{down}{left}{left}{left}{left}{rvon}{CBM-U}{CBM-U}{CBM-U}{rvof}{CBM-K}{down}{left}{left}{left}{left}{rvon}{CBM-I}{CBM-I}{CBM-I}{rvof}~"
 16640 :
 16650 rem "--- Menudata ---
 16660 :
 16670 data2,3
 16680 data"Spel",4,"Dobbelen","Opnieuw beginnen","Stoppen","Informatie"
 16690 data"Disc",2,"Saven spel","Oud spel laden"
 16700 data2,"Ja","Nee"
 16710 data2,"Verder","Stoppen"
 16720 data3,"Verder spelen","Nieuw spel","Stoppen"
 16730 :
 16740 rem "---------------------------------------------------------------------
 16750 rem "-                           Einde programma                         -
 16760 rem "---------------------------------------------------------------------
