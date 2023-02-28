/*
GeoLudo
Ludo game for 8 bit computers, GEOS edition
Written in 2023 by Xander Mol

https://github.com/xahmol/ludo

https://www.idreamtin8bits.com/

Code and resources from others used:

-   Scott Hutter - GeoUTerm:
    https://github.com/xlar54/ultimateii-dos-lib/
    (GeoUTerm as GEOS sample application using this)

-   CC65 cross compiler:
    https://cc65.github.io/

-   Daniel England (Daniel England) - GEOSBuild:
    https://github.com/M3wP/GEOSBuild
    (buildtool for GEOS disks)

-   David Lee - GEOS Image Editor
    https://www.facebook.com/groups/704637082964003/permalink/5839146806179646
    (editor for GEOS icons)

-   Subchrist Software - SpritePad Pro
    https://subchristsoftware.itch.io/spritepad-c64-pro
    (editor used for the file icons)

-   Hitchhikers Guide to GEOS v2020
    Berkeley Softworks / Paul B Murdaugh
    https://github.com/geos64128/HG2G2020

-   Sample sequential application header of GeoProgrammer
    Berkeley Softworks

-   Heureks: GEOS64 Programming Examples
    https://codeberg.org/heurekus/C64-Geos-Programming
    (sample code using C in CC65 for writing applications in GEOS)

-   Lyonlabs / Cenbe GEOS resources page:
    https://www.lyonlabs.org/commodore/onrequest/geos/index.html
    Including using code from:
    https://www.lyonlabs.org/commodore/onrequest/geos/geos-prog-tips.html

-   Bo Zimmerman GEOS resources page:
    http://www.zimmers.net/geos/

-   CBM Files GEOS disk images
    https://cbmfiles.com/geos/geos-13.php

-   GEOS - Wheels - GeoWorks - MegaPatch - gateWay - BreadBox Facebook Group
    https://www.facebook.com/groups/704637082964003/permalink/5839146806179646

-   Bart van Leeuwen for testing and providing the Device Manager ROM and GEOS RAM Boot

-   Gideon Zweijtzer for creating the Ultimate II+ cartridge and the Ultimate64, and the Ultimate Command Interface enabling this software.
   
-   Tested using real hardware (C128D, C128DCR, Ultimate 64) using GEOS128 2.0, GEOS64 2.0 and Megapatch3 128.

Licensed under the GNU General Public License v3.0

The code can be used freely as long as you retain
a notice describing original source and author.

THE PROGRAMS ARE DISTRIBUTED IN THE HOPE THAT THEY WILL BE USEFUL,
BUT WITHOUT ANY WARRANTY. USE THEM AT YOUR OWN RISK!
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <geos.h>
#include <peekpoke.h>
//#include <conio.h>
#include "defines.h"
#include "interface.h"
#include "menus.h"
#include "gamelogic.h"

#pragma code-name ("OVERLAY1");
#pragma rodata-name ("OVERLAY1");

void playerwins() {
// A player has won the game, choose to continue or stop the game

    sprintf(buffer, "%s has won!", playername[turnofplayernr]);

    if(!monochromeflag) { DialogueClearColor(); }
    if(DlgBoxYesNo(buffer,"Continue playing?") == NO) {
        gameflag = 0;
        eraseicon();
        iconflag=0;
        ClearBoard();
        return;
    }
    if(!monochromeflag & gameflag) { DrawBoard(1); }
}

void endturn() {
// End of turn sequence

    // Choose right icon based on if turn is for same player again
    iconflag = (zv)?1:2;

    // Next player, or same if 6 is thrown
    do
    {
        if(zv==1)
        {
            zv=0;
        }
        else
        {
            np[turnofplayernr]=-1;
            turnofplayernr++;
            if(turnofplayernr>3) { turnofplayernr=0; }
        }
    } while (zv==0 && playerdata[turnofplayernr][1]==0);

    // Enable right icon
    drawicon();
}

void pawnselect() {
// Place pawn

    unsigned char x,y;

    // Erase pawn at present position
    pawnerase(turnofplayernr,pawnchosen);

    // Calculate new position
    ov=playerpos[turnofplayernr][pawnchosen][1];
    ro=playerpos[turnofplayernr][pawnchosen][0];
    if(ro==1 && ov<4)
    {
        playerpos[turnofplayernr][pawnchosen][0]=0;
        playerpos[turnofplayernr][pawnchosen][1]=turnofplayernr*10;
        playerdata[turnofplayernr][3]--;
    }
    else { playerpos[turnofplayernr][pawnchosen][1]+=throw; }
    if(turnofplayernr==0 && playerpos[turnofplayernr][pawnchosen][1]>39 && ov<40 && ro==0)
        { playerpos[turnofplayernr][pawnchosen][0]=1; playerpos[turnofplayernr][pawnchosen][1]-=36; }
    if(turnofplayernr==1 && playerpos[turnofplayernr][pawnchosen][1]> 9 && ov<10 && ro==0)
        { playerpos[turnofplayernr][pawnchosen][0]=1; playerpos[turnofplayernr][pawnchosen][1]-= 6; }
    if(turnofplayernr==2 && playerpos[turnofplayernr][pawnchosen][1]>19 && ov<20 && ro==0)
        { playerpos[turnofplayernr][pawnchosen][0]=1; playerpos[turnofplayernr][pawnchosen][1]-=16; }
    if(turnofplayernr==3 && playerpos[turnofplayernr][pawnchosen][1]>29 && ov<30 && ro==0)
        { playerpos[turnofplayernr][pawnchosen][0]=1; playerpos[turnofplayernr][pawnchosen][1]-=26; }
    if(playerpos[turnofplayernr][pawnchosen][0]==1 && playerpos[turnofplayernr][pawnchosen][1]>3)
        { dp[turnofplayernr]=playerpos[turnofplayernr][pawnchosen][1]; }
    if(playerpos[turnofplayernr][pawnchosen][1]==playerdata[turnofplayernr][1]+3 && playerpos[turnofplayernr][pawnchosen][0]==1)
        { playerdata[turnofplayernr][1]--; }
    if(playerpos[turnofplayernr][pawnchosen][1]>39) { playerpos[turnofplayernr][pawnchosen][1]-=40; }
    ap=0;
    as=-1;

    // Check is player of other player is presemt at destination
    for(x=0;x<4;x++)
    {
        for(y=0;y<4;y++)
        {
            if(y!=pawnchosen || x!=turnofplayernr)
            {
                if(playerpos[x][y][0]==0 && playerpos[turnofplayernr][pawnchosen][0]==0)
                {
                    if(playerpos[x][y][1]==playerpos[turnofplayernr][pawnchosen][1])
                    {
                        ap=y;
                        as=x;
                        y=3;
                        x=3;
                    }
                }
            }
        }
    }

    // Move other player pawn to home if needed
    if(as!=-1)
    {
        pawnerase(as,ap);
        playerpos[as][ap][0]=1;
        playerpos[as][ap][1]=ap;
        playerdata[as][3]++;
        pawnplace(as,ap,0);
    }

    // Place pawn at new position
    pawnplace(turnofplayernr,pawnchosen,0);

    // Did player win?
    if(playerdata[turnofplayernr][1]==0) {
        playerwins();
        if(!gameflag) { return; }
    }

    endturn();
}

void turngeneric() {
// Generic turn sequence

    unsigned char x,y;

    // Reset variables
    noturnpossible = 0;
    mp = 0;
    pawnchosen = -1;
    ap = 0;
    pawnpossible[0] = 0;
    pawnpossible[1] = 0;
    pawnpossible[2] = 0;
    pawnpossible[3] = 0;

    // Throw dice
    throw = dicethrow();

    // Reduce throw counter and return if multiple dicethrows left and no six is thrown
    if(dicethrows>1)
    {
        if(throw !=6 ) { dicethrows--; return; }
        else { dicethrows=1; }
    }

    // Disable throw icon if enabled
    if(iconflag == 1) { eraseicon(); }

    if(dicethrows == 1) {
        // Erase throw 3 times line
        SetRectangleCoords(50,60,200 | screen_doublew,screen_pixel_width-1);
        SetPattern(0);
        Rectangle();

        // If all at home and no 6
        if(playerdata[turnofplayernr][3]==playerdata[turnofplayernr][1] && throw!=6) { noturnpossible=1; }
    }

    // Check for valid moves
    if(np[turnofplayernr]>=0)
    {
        if(playerdata[turnofplayernr][3]>0)
        {
            pawnchosen=np[turnofplayernr];
        }
        np[turnofplayernr]=-1;
    }
    if(noturnpossible==0 && pawnchosen==-1)
    {
        for(x=0;x<4;x++)
        {
            vr=playerpos[turnofplayernr][x][0];
            vl=playerpos[turnofplayernr][x][1];
            gv=0;
            if(vr==1 && vl<4)
            {
                gv=1;
                if(throw==6)
                {
                    pawnchosen=x;
                    np[turnofplayernr]=x;
                    x=3;
                }
            }
            if(gv==0)
            {
                vn=vl+throw;
                nr=vr;
                if(vr==0)
                {
                    if(turnofplayernr==0 && vn>39 && vl<40) { vn-=36; nr=1; }
                    if(turnofplayernr==1 && vn> 9 && vl<10) { vn-= 6; nr=1; }
                    if(turnofplayernr==2 && vn>19 && vl<20) { vn-=16; nr=1; }
                    if(turnofplayernr==3 && vn>29 && vl<30) { vn-=26; nr=1; }
                }
                if(nr==1)
                {
                    if(vn>7) { gv=1; }
                    else
                    {
                        for(y=0;y<4;y++)
                        {
                            if(vr==1)
                            {
                                if(x!=y && playerpos[turnofplayernr][y][0]==1 && playerpos[turnofplayernr][y][1]<=vn && playerpos[turnofplayernr][y][1]>3 && playerpos[turnofplayernr][x][1] < playerpos[turnofplayernr][y][1])
                                {
                                    gv=1;
                                    y=3;
                                }
                            }
                            else{
                                if(x!=y && playerpos[turnofplayernr][y][0]==1 && playerpos[turnofplayernr][y][1]<=vn && playerpos[turnofplayernr][y][1]>3)
                                {
                                    gv=1;
                                    y=3;
                                }
                            }
                        }
                    }
                }
                if(gv==0) { pawnpossible[x]=1; }
            }
        }
    }
    if(pawnchosen==-1)
    {
        for(x=0;x<4;x++)
        {
            if(pawnpossible[x]==1) { ap++; pawnchosen=x; }
        }
    }
    else { ap=1; }

    // If 6 is thrown, another turn for same player
    if(throw==6) { zv=1; }

    // No turn possible
    if(ap==0 || noturnpossible==1)
    {
        PutString("No turn possible.",59,200 | screen_doublew);
        endturn();
        return;
    }

    // More than one pawn possible, so choose
    if(ap>1)
    {
        if(!playerdata[turnofplayernr][0]) { humanchoosepawnstart(); return; }
        else { computerchoosepawn(); }
    }

    pawnselect();
}
