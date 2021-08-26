/*
L U D O
Written in 1992,2020, 2021 by Xander Mol

https://github.com/xahmol/ludo
https://www.idreamtin8bits.com/

Originally written in 1992 in Commodore BASIC 7.0 for the Commodore 128
Rewritten for Oric Atmos in BASIC in 2020
Rewritten for Oric Atmos in C using CC65 in 2021

Code and resources from others used:

-   oricOpenLibrary for IJK joystick driver code and Sedoric routines
                 _
     ___ ___ _ _|_|___ ___
    |  _| .'|_'_| |_ -|_ -|
    |_| |__,|_,_|_|___|___|
            raxiss (c) 2021
    GNU General Public License v3.0
    See https://github.com/iss000/oricOpenLibrary/blob/main/LICENSE

-   OSDK for MYMPlayer music player and building tools
    (C) Dbug and OSDK authors
    https://osdk.org/

-   8Bit Unity for adaptation of OSDK MYM player
    https://github.com/8bit-Dude/8bit-Unity
     * Copyright (c) 2018 Anthony Beaucamp.
     *
     * This software is provided 'as-is', without any express or implied warranty.
     * In no event will the authors be held liable for any damages arising from
     * the use of this software.    
     *
     * Permission is granted to anyone to use this software for any purpose,
     * including commercial applications, and to alter it and redistribute it
     * freely, subject to the following restrictions:
     *
     *   1. The origin of this software must not be misrepresented * you must not
     *   claim that you wrote the original software. If you use this software in a
     *   product, an acknowledgment in the product documentation would be
     *   appreciated but is not required.
     *
     *   2. Altered source versions must be plainly marked as such, and must not
     *   be misrepresented as being the original software.
     *
     *   3. This notice may not be removed or altered from any distribution.
     *
     *   4. The names of this software and/or it's copyright holders may not be
     *   used to endorse or promote products derived from this software without
     *   specific prior written permission.

-   Original windowing system code on Commodore 128 by unknown author.

-   Music credits:
    R-Type level 1 by Wally Beben/Alain Derpin
    Defender of the Crown by David Whittaker/Aldn
    Wizzball by Peter Johnson/Aldn
    
-   Documentation used:
    OSDK.org, forum.defence-force.org, defence-force.org.

-   ORIC software development tooling:
    CC65 from CC65 contributors, see https://cc65.github.io/
    OSDK from DBug/OSDK Authors
    CD2 from Twilighte
    Oric Explorer by Scott Davies
    ORIC Character Generater by Pe@ceR
    HxCFloppyEmulator Software by Jean-Francois del Nero.
    
-   Tooling to transfer original Commodore software code: "
    VICE by VICE authors
    DirMaster by The Wiz/Elwix
    CharPad Free by Subchrist software
    UltimateII+ cartridge by Gideon Zweijtzer
    
-   Tested using Oricuton emulator and an Oric Atmos with a Cumana Reborn. 

The code can be used freely as long as you retain
a notice describing original source and author.

THE PROGRAMS ARE DISTRIBUTED IN THE HOPE THAT THEY WILL BE USEFUL,
BUT WITHOUT ANY WARRANTY. USE THEM AT YOUR OWN RISK!
*/

/* Includes */
#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <string.h>
#include <time.h>
#include "defines.h"
#include "osdklib.h"
#include "libsedoric.h"
#include "libmymplayer.h"
#include "libijkdriver.h"

/* Functions */
void loadintro();
void loadmainscreen();
void gamereset();
unsigned char pawncoord(unsigned char playernumber, unsigned char pawnnumber, unsigned char xy);
void pawnerase(unsigned char playernumber, unsigned char pawnnumber);
void pawnplace(unsigned char playernumber, unsigned char pawnnumber, unsigned char selected);
unsigned char dicethrow();
void inputofnames();
void informationcredits();
void turnhuman();
void turngeneric();
unsigned char humanchoosepawn(unsigned char playernumber, unsigned char possible[4]);
void playerwins();
unsigned char computerchoosepawn(unsigned char playernumber, unsigned char possible[4]);
void savegame(unsigned char autosave);
void loadgame();
void musicnext();
void windowsave(unsigned char ypos, unsigned char height);
void windowrestore();
void menumakeborder(unsigned char xpos, unsigned char ypos, unsigned char height, unsigned char width);
void menuplacebar();
unsigned char menupulldown(unsigned char xpos, unsigned char ypos, unsigned char menunumber);
unsigned char menumain();
unsigned char areyousure();
unsigned char getkey(char* allowedkeys, unsigned char joyallowed);
int input(unsigned char xpos, unsigned char ypos, char *str, unsigned char size);
void wait(unsigned int wait_cs);
void printcentered(char* text, unsigned char color, unsigned char xpos, unsigned char ypos, unsigned char width);
void cspaces(unsigned char number);
void cleararea(unsigned char xpos, unsigned char ypos, unsigned char height, unsigned char width);

/* Variables */

//Window data
struct WindowStruct
{
    unsigned int address;
    unsigned char ypos;
    unsigned char height;
};
struct WindowStruct Window[9];

unsigned int windowaddress;
unsigned int* windowmemory;
unsigned char windownumber = 0;

//Menu data
unsigned char menubaroptions = 4;
unsigned char pulldownmenunumber = 8;
char menubartitles[4][12] = {"Game","Disc","Music","Information"};
unsigned char menubarcoords[4] = {1,6,11,17};
unsigned char pulldownmenuoptions[8] = {3,3,3,1,2,2,3,5};
char pulldownmenutitles[8][5][16] = {
    {"Throw dice",
     "Restart   ",
     "Stop      "},
    {"Save game   ",
     "Load game   ",
     "Autosave off"},
    {"Next   ",
     "Stop   ",
     "Restart"},
    {"Credits"},
    {"Yes",
     "No "},
    {"Restart"
    ,"Stop   "},
    {"Continue game",
     "New game     ",
     "Stop         "},
    {"Autosave       ",
     "Slot 1: Empty  ",
     "Slot 2: Empty  ",
     "Slot 3: Empty  ",
     "Slot 4: Empty  "}
};

//Input validation strings
char numbers[11]="0123456789";
char letters[53]="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
char updownenter[4] = {C_DOWN,C_UP,C_ENTER,0};
 char leftright[3] = {C_LEFT,C_RIGHT,0};

//Pawn position co-ords main field
unsigned char fieldcoords[40][2] = {
     { 2,13}, { 5,13}, { 8,13}, {11,13}, {14,13},
     {14,11}, {14, 9}, {14, 7}, {14, 5}, {17, 5},
     {20, 5}, {20, 7}, {20, 9}, {20,11}, {20,13},
     {23,13}, {26,13}, {29,13}, {32,13}, {32,15},
     {32,17}, {29,17}, {26,17}, {23,17}, {20,17},
     {20,19}, {20,21}, {20,23}, {20,25}, {17,25},
     {14,25}, {14,23}, {14,21}, {14,19}, {14,17},
     {11,17}, { 8,17}, { 5,17}, { 2,17}, { 2,15}
};
//Pawn posiiion co-ords start and destination
unsigned char homedestcoords[4][8][2] = {
    {{ 2, 5}, { 5, 5}, { 2, 7}, { 5, 7}, { 5,15}, { 8,15}, {11,15}, {14,15}},
    {{29, 5}, {32, 5}, {29, 7}, {32, 7}, {17, 7}, {17, 9}, {17,11}, {17,13}},
    {{29,23}, {32,23}, {29,25}, {32,25}, {29,15}, {26,15}, {23,15}, {20,15}},
    {{ 2,23}, { 5,23}, { 2,25}, { 5,25}, {17,23}, {17,21}, {17,19}, {17,17}}
};
/* Player data:
    [players 0-3]
    [position 0: human = 0 or computer = 1
     position 1: number of pawns not at destination
     position 2: player color
     position 3: number of pawns at home              */
unsigned char playerdata[4][4] = {
    {0,4,A_FWGREEN,4},
    {0,4,A_FWRED,4},
    {0,4,A_FWBLUE,4},
    {0,4,A_FWYELLOW,4}
};
/* Player field positions:
    [players 0-3]
    [pawnnumber 0-3]
    [0 position: main field = 0, else 1
     1 position: fieldnumber]               */
unsigned char playerpos[4][4][2] = {
    {{1,0}, {1,1}, {1,2}, {1,3}},
    {{1,0}, {1,1}, {1,2}, {1,3}},
    {{1,0}, {1,1}, {1,2}, {1,3}},
    {{1,0}, {1,1}, {1,2}, {1,3}}
};
/* Player names */
char playername[4][21];

signed char np[4] = { -1, -1, -1, -1};
unsigned char dp[4] = { 8, 8, 8, 8 };

//Dice graphics string data
char dicegraphics[6][2][3] = {
    {{C_DICE01,C_DICE02,0},{C_DICE03,C_DICE04,0}},
    {{C_DICE05,C_DICE06,0},{C_DICE06,C_DICE07,0}},
    {{C_DICE08,C_DICE02,0},{C_DICE03,C_DICE09,0}},
    {{C_DICE05,C_DICE10,0},{C_DICE11,C_DICE07,0}},
    {{C_DICE08,C_DICE12,0},{C_DICE13,C_DICE09,0}},
    {{C_DICE14,C_DICE14,0},{C_DICE15,C_DICE15,0}}
};

//Game variables
unsigned char endofgameflag = 0;
unsigned char turnofplayernr = 0;
unsigned char zv = 0;
unsigned char ns = 0;
unsigned char throw;
unsigned char musicnumber = 1;
unsigned char joyinterface;
unsigned char autosavetoggle = 1;

//Save game memory allocation
unsigned int* saveslots;
unsigned int* savegamemem;

/* Main routine */

void main()
{
    unsigned char x, choice;

    setflags(SCREEN);

    ijk_detect();
    joyinterface = ijk_present;

    //Save game memory allocation
    saveslots = (unsigned int*) malloc(85);
    savegamemem = (unsigned int*) malloc(136);
    windowmemory = (unsigned int*) malloc(4096);
    windowaddress = (unsigned int)windowmemory;

    //Game intro
    clrscr();
    bgcolor(0);    
    textcolor(3);

    loadintro();

    //Ask for loading save game
    menumakeborder(18,8,6,20);
    gotoxy(20,11);
    cprintf("%cLoad old game?%c",A_FWYELLOW, A_FWRED);
    choice = menupulldown(27,11,5);
    windowrestore();

    loadmainscreen();
    
    if(choice==1) { loadgame(); }

    srand(clock());

    //Main game loop
    do
    {
        if(endofgameflag>0)
        {
            endofgameflag = 0;
        }
        else
        {
            inputofnames();
        }
        do
        {
            cleararea(0,2,3,40);
            gotoxy(0,3);
            cprintf("%cPlayer %c%d%c: %c %c\n\r", A_FWYELLOW, A_FWCYAN, turnofplayernr+1, A_FWYELLOW, 16+playerdata[turnofplayernr][2], A_BGBLACK);
            cprintf("%c%s%c\n\r", A_FWGREEN, playername[turnofplayernr], A_FWYELLOW);
            if(playerdata[turnofplayernr][0]==0)
            {
                turnhuman();
            }
            else
            {
                cprintf("%cComputer is playing.", A_FWYELLOW);
            }
            if(endofgameflag!=0) { break; }
            turngeneric();

            /* Debugging: printing player data
            for(x=0;x<4;x++)
            {
                gotoxy(1+22*(x==1 || x==2), 10+11*(x==2 || x==3));
                cprintf("%d %d %d %d  ", playerpos[x][0][0],playerpos[x][0][1],playerpos[x][1][0],playerpos[x][1][1]);
                gotoxy(1+22*(x==1 || x==2), 11+11*(x==2 || x==3));
                cprintf("%d %d %d %d  ", playerpos[x][2][0],playerpos[x][2][1],playerpos[x][3][0],playerpos[x][3][1]);
                gotoxy(1+22*(x==1 || x==2), 12+11*(x==2 || x==3));
                cprintf("%d %d",playerdata[x][1],playerdata[x][3]);
            } */

            if(playerdata[turnofplayernr][1]==0) { playerwins(); }
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
        } while (endofgameflag==0);
    } while (endofgameflag!=1); 

    //End of game
    clrscr();
    bgcolor(0);    
    textcolor(3);
    gotoxy(0,0);
    for(x=0;x<40;x++) { cputc(0); }
    gotoxy(0,1);
    cprintf("%cThanks for playing, goodbye.",A_FWCYAN);
    free(saveslots);
    free(savegamemem);
    free(windowmemory);
    StopMusic();
}

/* Game routines */
void loadintro()
{
    /* Game intro */

    int rc, x, y;
    int len = 0;
    char buffer[40];
    char joys[4];
    char music[4];
    char validkeys[4] = {'j','m', C_ENTER, 0 };
    unsigned char key;

    /* Load title screen */
    rc = loadfile("LUDOTITL.BIN", (void*)0xb500, &len);

    /* Load and read game config file */
    rc = loadfile("LUDODATA.COM", (void*)saveslots, &len);
    for(y=0;y<5;y++)
    {
        for(x=0;x<16;x++)
        {
            pulldownmenutitles[7][y][x]=peek(saveslots+(y*16)+5+x);
        }
    }

    /* Load and start first music file */
    rc = loadfile("LUDOMUS1.BIN", (void*)0x9400, &len);
    PlayMusic(); 

    /* Wait for ENTER of FIRE while player can toggle joystick and music */
    
    printcentered("Press ENTER/FIRE to start game.", A_FWWHITE,2,22,38);
    printcentered("J=toggle joystick, M=toggle music.", A_FWWHITE,2,23,38);

    do
    {
        if(joyinterface) { strcpy(joys,"Yes"); } else { strcpy(joys,"No"); }
        if(musicnumber) { strcpy(music,"Yes"); } else { strcpy(music,"No"); }
        sprintf(buffer,"Joystick: %s  Music: %s", joys,music);
        printcentered(buffer,A_FWWHITE,2,20,38);
        key = getkey(validkeys,1);
        switch (key)
        {
        case 'j':
            joyinterface = (joyinterface)? 0 : ijk_present;
            break;

        case 'm':
            if(musicnumber)
            {
                StopMusic();
                musicnumber = 0;
            }
            else{
                musicnumber = 1;
                PlayMusic();
            }
            break;
        
        default:
            break;
        }
    } while (key != C_ENTER);
}

void loadmainscreen()
{
    /* Function to load main screen and print menu bar */

    int rc;
    int len = 0;
    if(musicnumber) { PauseMusic(1); }
    rc = loadfile("LUDOSCRM.BIN", (void*)0xb500, &len);
    if(musicnumber) { PauseMusic(0); }
    menuplacebar();
}

void gamereset()
{
    /* Reset all player data */

    unsigned char n;

    loadmainscreen();
    turnofplayernr=0;
    for(n=0;n<4;n++)
    {
        playerdata[n][1]=4;
        playerdata[n][3]=4;
        np[n]=-1;
        dp[n]=8;
    }
}

unsigned char pawncoord(unsigned char playernumber, unsigned char pawnnumber, unsigned char xy)
{
    /* Obtain pawn coordinates
       Input:
       - playernumber and pawnnumber
       - xy: X (0) or Y (1) coordinate returned
       Output: the corresponding x or y co-ordinate */

    if(playerpos[playernumber][pawnnumber][0]==0)
    {
        return fieldcoords[playerpos[playernumber][pawnnumber][1]][xy];
    }
    else
    {
        return homedestcoords[playernumber][playerpos[playernumber][pawnnumber][1]][xy];
    }
}

void pawnerase(unsigned char playernumber, unsigned char pawnnumber)
{
    /* Erase a pawn from the field
       Input playernumber and pawnnumber */

    unsigned char xpos, ypos;

    xpos = pawncoord(playernumber, pawnnumber, 0);
    ypos = pawncoord(playernumber, pawnnumber, 1);
    if(playerpos[playernumber][pawnnumber][0]==0 && (playerpos[playernumber][pawnnumber][1]%10)== 0)
    {
        /* Colored start fields */
        switch (playerpos[playernumber][pawnnumber][1]/10)
        {
        case 0:
            cputcxy(xpos-1,ypos+1, A_FWGREEN);
            cputcxy(xpos,ypos+1,C_GSTARTUL);
            cputcxy(xpos+1,ypos+1,C_GSTARTUR);
            cputcxy(xpos-1,ypos+2, A_FWGREEN);
            cputcxy(xpos,ypos+2,C_GSTARTLL);
            cputcxy(xpos+1,ypos+2,C_GSTARTLR);
            break;

        case 1:
            cputcxy(xpos-1,ypos+1, A_FWRED);
            cputcxy(xpos,ypos+1,C_RSTARTUL);
            cputcxy(xpos+1,ypos+1,C_RSTARTUR);
            cputcxy(xpos-1,ypos+2, A_FWRED);
            cputcxy(xpos,ypos+2,C_RSTARTLL);
            cputcxy(xpos+1,ypos+2,C_RSTARTLR);
            break;

        case 2:
            cputcxy(xpos-1,ypos+1, A_FWBLUE);
            cputcxy(xpos,ypos+1,C_BSTARTUL);
            cputcxy(xpos+1,ypos+1,C_BSTARTUR);
            cputcxy(xpos-1,ypos+2, A_FWBLUE);
            cputcxy(xpos,ypos+2,C_BSTARTLL);
            cputcxy(xpos+1,ypos+2,C_BSTARTLR);
            break;

        case 3:
            cputcxy(xpos-1,ypos+1, A_FWYELLOW);
            cputcxy(xpos,ypos+1,C_YSTARTUL);
            cputcxy(xpos+1,ypos+1,C_YSTARTUR);
            cputcxy(xpos-1,ypos+2, A_FWYELLOW);
            cputcxy(xpos,ypos+2,C_YSTARTLL);
            cputcxy(xpos+1,ypos+2,C_YSTARTLR);
            break;
        
        default:
            break;
        }
    }
    else
    {
        if(playerpos[playernumber][pawnnumber][0]==0)
        {
            /* Normal white field main track */
            cputcxy(xpos-1,ypos+1, A_FWWHITE);
            cputcxy(xpos,ypos+1,C_EFIELDUL);
            cputcxy(xpos+1,ypos+1,C_EFIELDUR);
            cputcxy(xpos-1,ypos+2, A_FWWHITE);
            cputcxy(xpos,ypos+2,C_EFIELDLL);
            cputcxy(xpos+1,ypos+2,C_EFIELDLR);
        }
        else
        {
            /* Colored home or destination field */
            cputcxy(xpos-1,ypos+1, playerdata[playernumber][2]);
            cputcxy(xpos,ypos+1,C_FFIELDUL);
            cputcxy(xpos+1,ypos+1,C_FFIELDUR);
            cputcxy(xpos-1,ypos+2, playerdata[playernumber][2]);
            cputcxy(xpos,ypos+2,C_FFIELDLL);
            cputcxy(xpos+1,ypos+2,C_FFIELDLR);
        }
    }
}

void pawnplace(unsigned char playernumber, unsigned char pawnnumber, unsigned char selected)
{
    /* Place a pawn on the field
       Input playernumber and pawnnumber */

    unsigned char xpos, ypos, color;

    xpos = pawncoord(playernumber, pawnnumber, 0);
    ypos = pawncoord(playernumber, pawnnumber, 1);
    color = (selected)? A_FWWHITE : playerdata[playernumber][2];

    cputcxy(xpos-1,ypos+1, color);
    cputcxy(xpos,ypos+1,C_PAWNUL);
    cputcxy(xpos+1,ypos+1,C_PAWNUR);
    cputcxy(xpos-1,ypos+2, color);
    cputcxy(xpos,ypos+2,C_PAWNLL);
    cputcxy(xpos+1,ypos+2,C_PAWNLR);
}

unsigned char dicethrow()
{
    /* Throw the dice. Returns the dice value */

    unsigned char dicethrow, x;

    menumakeborder(30,12,6,8);
    gotoxy(32,15);
    cprintf("%c%c%c%c%c%c",A_ALT, A_FWWHITE, C_SPACE, C_SPACE, A_FWRED, A_STD);
    gotoxy(32,16);
    cprintf("%c%c%c%c%c%c",A_ALT, A_FWWHITE, C_SPACE, C_SPACE, A_FWRED, A_STD);
    for(x=0;x<10;x++)
    {
        dicethrow = rand()%6+1;
        cputsxy(34,15,dicegraphics[dicethrow-1][0]);
        cputsxy(34,16,dicegraphics[dicethrow-1][1]);
        wait(10);
    }
    gotoxy(32,18);
    cprintf("%cKey.%c", A_FWYELLOW, A_FWRED);
    getkey("",1);
    windowrestore();
    return dicethrow;
}

void inputofnames()
{
    /* Enter player nanes */
    unsigned char x, choice;

    menumakeborder(4,8,6,34);
    for(x=0;x<4;x++)
    {
        gotoxy(6,11);
        cprintf("%cComputer plays for player%c %d%c?%c",A_FWYELLOW,A_FWCYAN,x+1,A_FWYELLOW,A_FWRED);
        choice = menupulldown(28,11,5);
        if(choice==1)
        {
            playerdata[x][0]=1;
        }
        else
        {
            playerdata[x][0]=0;
        }
        gotoxy(6,11);
        cprintf("%cInput name for player%c %d%c:    %c",A_FWYELLOW,A_FWCYAN,x+1,A_FWYELLOW,A_FWRED);
        input(6,12,playername[x],20);
    }
    windowrestore();
}

void informationcredits()
{
    /* Print version information and credits */

    char version[30];
    sprintf(version,
            "Version: v%i%i - %c%c%c%c%c%c%c%c-%c%c%c%c",
            VERSION_MAJOR, VERSION_MINOR,
            BUILD_YEAR_CH0, BUILD_YEAR_CH1, BUILD_YEAR_CH2, BUILD_YEAR_CH3, BUILD_MONTH_CH0, BUILD_MONTH_CH1, BUILD_DAY_CH0, BUILD_DAY_CH1,BUILD_HOUR_CH0, BUILD_HOUR_CH1, BUILD_MIN_CH0, BUILD_MIN_CH1);
    menumakeborder(2,8,14,36);
    printcentered("L U D O",A_FWCYAN,3,10,36);
    printcentered(version,A_FWYELLOW,3,11,36);
    printcentered("Written by Xander Mol",A_FWYELLOW,3,13,36);
    printcentered("Converted to Oric Atmos, 2020/21",A_FWYELLOW,3,14,36);
    printcentered("Original on Commodore 128, 1992",A_FWYELLOW,3,15,36);
    printcentered("Build with and using code of",A_FWYELLOW,3,17,36);
    printcentered("OSDK, (C) Dbug and OSDK authors.",A_FWYELLOW,3,18,36);
    printcentered("oricOpenLibrary, (C) raxiss.",A_FWYELLOW,3,19,36);
    printcentered("8Bit Unity, (C) Anthony Beaucamp.",A_FWYELLOW,3,20,36);
    printcentered("Press a key.",A_FWGREEN,3,21,36);
    getkey("",1);
    windowrestore();
}

void turnhuman()
{
    /* Turn for the human players */

    unsigned char choice;
    unsigned char yesno;

    do
    {
        choice = menumain();
        switch (choice)
        {
            case 12:
                yesno = areyousure();
                if(yesno==1) { endofgameflag=3;  gamereset(); }
                break;

            case 13:
                yesno = areyousure();
                if(yesno==1) { endofgameflag=1; }
                break;

            case 21:
                savegame(0);
                break;

            case 22:
                yesno = areyousure();
                if(yesno==1) { loadgame(); }
                break;

            case 23:
                if(autosavetoggle==1)
                {
                    autosavetoggle=0;
                    strcpy(pulldownmenutitles[1][2],"Autosave on ");
                }
                else
                {
                    autosavetoggle=1;
                    strcpy(pulldownmenutitles[1][2],"Autosave off");
                }
                break;

            case 31:
                musicnext();
                break;

            case 32:
                StopMusic();
                break;

            case 33:
                StopMusic();
                PlayMusic();
                break;

            case 41:
                informationcredits();
                break;

            default:
                break;
        }
    } while (choice!=11 && choice!=12 && choice!=13 && choice!=22);
}

void turngeneric()
{
    /* Generic turn sequence */

    unsigned char pawnpossible[4] = { 0,0,0,0 };
    unsigned char dicethrows = 1;
    unsigned char noturnpossible = 0;
    unsigned char mp = 0;
    signed char pawnnumber = -1;
    unsigned char ap = 0;
    signed char as;
    unsigned char vr, vl, vn, nr, gv, ov, ro, x,y;

    if(playerdata[turnofplayernr][3]==playerdata[turnofplayernr][1])
    {
        dicethrows = 3;
        for(x=0;x<4;x++)
        {
            if(playerpos[turnofplayernr][x][0]==0)
            {
                dicethrows = 1;
            }
            if(playerpos[turnofplayernr][x][0]==1 && playerpos[turnofplayernr][x][1]<playerdata[turnofplayernr][1]+4 && playerpos[turnofplayernr][x][1]<playerdata[turnofplayernr][1]>3)
            {
                dicethrows = 1;
            }
        }
        if(dicethrows == 3)
        {
            gotoxy(21,4);
            cprintf("%cThrow 3 times.", A_FWYELLOW);
        }
    }
    for(x=0;x<dicethrows;x++)
    {
        throw = dicethrow();
        if(throw==6) { break; }
    }
    cleararea(21,3,1,15);
    if(playerdata[turnofplayernr][3]==playerdata[turnofplayernr][1] && dicethrows == 3 && throw!=6) { noturnpossible=1; }
    if(np[turnofplayernr]>=0)
    {
        if(playerdata[turnofplayernr][3]>0)
        {
            pawnnumber=np[turnofplayernr];
        }
        np[turnofplayernr]=-1;
    }
    if(noturnpossible==0 && pawnnumber==-1)
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
                    pawnnumber=x;
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
    if(pawnnumber==-1)
    {
        for(x=0;x<4;x++)
        {
            if(pawnpossible[x]==1) { ap++; pawnnumber=x; }
        }
    }
    else { ap=1; }
    if(ap>1)
    {
        if(playerdata[turnofplayernr][0]==0) { pawnnumber = humanchoosepawn(turnofplayernr,pawnpossible); }
        else { pawnnumber = computerchoosepawn(turnofplayernr,pawnpossible); }
    }
    if(throw==6) { zv=1; }
    if(ap==0 || noturnpossible==1)
    {
        gotoxy(21,3);
        cprintf("%cNo move possible", A_FWYELLOW);
        gotoxy(21,4);
        cprintf("%cPress key", A_FWYELLOW);
        getkey("",1);
        return;
    }
    pawnerase(turnofplayernr,pawnnumber);
    ov=playerpos[turnofplayernr][pawnnumber][1];
    ro=playerpos[turnofplayernr][pawnnumber][0];
    if(ro==1 && ov<4)
    {
        playerpos[turnofplayernr][pawnnumber][0]=0;
        playerpos[turnofplayernr][pawnnumber][1]=turnofplayernr*10;
        playerdata[turnofplayernr][3]--;
    }
    else { playerpos[turnofplayernr][pawnnumber][1]+=throw; }
    if(turnofplayernr==0 && playerpos[turnofplayernr][pawnnumber][1]>39 && ov<40 && ro==0)
        { playerpos[turnofplayernr][pawnnumber][0]=1; playerpos[turnofplayernr][pawnnumber][1]-=36; }
    if(turnofplayernr==1 && playerpos[turnofplayernr][pawnnumber][1]> 9 && ov<10 && ro==0)
        { playerpos[turnofplayernr][pawnnumber][0]=1; playerpos[turnofplayernr][pawnnumber][1]-= 6; }
    if(turnofplayernr==2 && playerpos[turnofplayernr][pawnnumber][1]>19 && ov<20 && ro==0)
        { playerpos[turnofplayernr][pawnnumber][0]=1; playerpos[turnofplayernr][pawnnumber][1]-=16; }
    if(turnofplayernr==3 && playerpos[turnofplayernr][pawnnumber][1]>29 && ov<30 && ro==0)
        { playerpos[turnofplayernr][pawnnumber][0]=1; playerpos[turnofplayernr][pawnnumber][1]-=26; }
    if(playerpos[turnofplayernr][pawnnumber][0]==1 && playerpos[turnofplayernr][pawnnumber][1]>3)
        { dp[turnofplayernr]=playerpos[turnofplayernr][pawnnumber][1]; }
    if(playerpos[turnofplayernr][pawnnumber][1]==playerdata[turnofplayernr][1]+3 && playerpos[turnofplayernr][pawnnumber][0]==1)
        { playerdata[turnofplayernr][1]--; }
    if(playerpos[turnofplayernr][pawnnumber][1]>39) { playerpos[turnofplayernr][pawnnumber][1]-=40; }
    ap=0;
    as=-1;
    for(x=0;x<4;x++)
    {
        for(y=0;y<4;y++)
        {
            if(y!=pawnnumber || x!=turnofplayernr)
            {
                if(playerpos[x][y][0]==0 && playerpos[turnofplayernr][pawnnumber][0]==0)
                {
                    if(playerpos[x][y][1]==playerpos[turnofplayernr][pawnnumber][1])
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
    if(as!=-1)
    {
        pawnerase(as,ap);
        playerpos[as][ap][0]=1;
        playerpos[as][ap][1]=ap;
        playerdata[as][3]++;
        pawnplace(as,ap,0);
    }
    pawnplace(turnofplayernr,pawnnumber,0);
    if(playerdata[turnofplayernr][0]==0 && autosavetoggle==1) { savegame(1); } /* Autosave on end human turn */
    else
    {
        gotoxy(20,3);
        cprintf("%cPress key.", A_FWYELLOW);
        getkey("",1);
    }
}

unsigned char humanchoosepawn(unsigned char playernumber, unsigned char possible[4])
{
    /* Human has to choose a pawn, returns pawnnumber chosen */

    signed char pawnnumber = 0;
    signed char direction;
    unsigned char key;
    char validkeys[5] = { C_LEFT, C_RIGHT, C_UP, C_DOWN, C_ENTER };

    menumakeborder(20,1,2,18);
    gotoxy(22,3);
    cprintf("%cWhich pawn?%c", A_FWYELLOW, A_FWRED);
    gotoxy(22,4);
    cprintf("%cThrown: %d%c", A_FWYELLOW, throw, A_FWRED);
    while (possible[++pawnnumber]!=1 && pawnnumber<4);
    do
    {
        pawnplace(playernumber,pawnnumber,1);
        key = getkey(validkeys,1);
        pawnplace(playernumber,pawnnumber,0);
        if(key==C_LEFT || key==C_DOWN) { pawnnumber--; direction=-1; }
        if(key==C_RIGHT || key==C_UP) { pawnnumber++; direction=1; }
        if(key!=C_ENTER)
        {
            if(pawnnumber>3) { pawnnumber = 0; }
            if(pawnnumber<0) { pawnnumber = 3; }
            do
            {
                if(possible[pawnnumber]!=1)
                {
                    pawnnumber+=direction;
                    if(pawnnumber>3) { pawnnumber = 0; }
                    if(pawnnumber<0) { pawnnumber = 3; }
                }
            } while (possible[pawnnumber]!=1);
        }
    } while (key!=C_ENTER);
    windowrestore();
    return pawnnumber;
}

void playerwins()
{
    unsigned char choice;

    menumakeborder(3,8,9,35);
    gotoxy(5,11);
    cprintf("%c%s%c has won the game!%c", A_FWGREEN, playername[turnofplayernr], A_FWYELLOW, A_FWRED);
    gotoxy(5,13);
    cprintf("%cWhat do you want?%c", A_FWYELLOW, A_FWRED);
    do
    {
        choice = menupulldown(15,13,7);
        if(choice==2) { endofgameflag=3; gamereset(); zv=1; }
        if(choice==3) { endofgameflag=1; zv=1; }
    } while (choice==1 && playerdata[0][1]==0 && playerdata[1][1]==0 && playerdata[2][1]==0 && playerdata[3][1]==0);
    windowrestore();
}

unsigned char computerchoosepawn(unsigned char playernumber, unsigned char possible[4])
{
    /* Computer has to choose a pawn, returns pawnnumber chosen */

    signed int pawnscore[4] = { 0,0,0,0 };
    unsigned char pawnnumber = 0;
    signed int minimumpawnscore;
    unsigned char vr, vn, nn, no, nr, x,y,z ;

    for(x=0;x<4;x++)
    {
        if(possible[x]==0)
        {
            pawnscore[x]=-10000;
        }
        else{
            vr=playerpos[playernumber][x][0];
            vn=playerpos[playernumber][x][1];
            nn=vn+throw;
            no=nn;
            nr=vr;
            if(vr==0)
            {
                if(playernumber==0 && nn>39 && vn<40) { nn-=36; nr=1; }
                if(playernumber==1 && nn> 9 && vn<10) { nn-= 6; nr=1; }
                if(playernumber==2 && nn>19 && vn<20) { nn-=16; nr=1; }
                if(playernumber==3 && nn>29 && vn<30) { nn-=26; nr=1; }
            }
            if(nr==0 && nn>39) { nn-=40; }
            if(nr==1 && nn>3 && playerdata[playernumber][1]==1) { pawnscore[x]=10000; x=3; }
            else
            {
                if(nr==1 && nn>3) { pawnscore[x]+=6000; }
                for(y=0;y<4;y++)
                {
                    for(z=0;z<4;z++)
                    {
                        if(playernumber==y && playerpos[y][z][0]==nr && playerpos[y][z][1]==nn) { pawnscore[x]-=8000; }
                        if(playernumber!=y && playerpos[y][z][0]==nr && playerpos[y][z][1]==nn)
                        {
                            pawnscore[x]+=4000;
                            if(playerpos[y][z][0]==0)
                            {
                                if(y==0 && playerpos[y][z][1]>33) { pawnscore[x]+=3000; }
                                if(y==1 && playerpos[y][z][1]> 3) { pawnscore[x]+=3000; }
                                if(y==2 && playerpos[y][z][1]>13) { pawnscore[x]+=3000; }
                                if(y==3 && playerpos[y][z][1]>23) { pawnscore[x]+=3000; }
                            }
                        }
                        if(playerpos[y][z][0]==0 && nr==0 && playernumber!=y)
                        {
                            if((vn-playerpos[y][z][1])<6 && vn-playerpos[y][z][1]>0) { pawnscore[x]+=400; }
                            if((no-playerpos[y][z][1])<6 && no-playerpos[y][z][1]>0) { pawnscore[x]-=200; }
                            if((playerpos[y][z][1]-nn)<6 && (playerpos[y][z][1]-nn)>0) { pawnscore[x]+=100; }
                        }
                    }
                }
                if(nr==0 && (nn==0 || nn==10 || nn==20 || nn==30)) { pawnscore[x]-=4000; }
                if(vr==0 && (vn==0 || vn==10 || vn==20 || vn==30)) { pawnscore[x]+=2000; }
                if(playernumber==0) { pawnscore[x]+=nn; }
                if(playernumber==1) { pawnscore[x]+=no-10; }
                if(playernumber==2) { pawnscore[x]+=no-20; }
                if(playernumber==3) { pawnscore[x]+=no-30; }
            }
        }
    }
    minimumpawnscore=-20000;
    for(x=0;x<4;x++)
    {
        if(pawnscore[x]>minimumpawnscore && possible[x]==1) { minimumpawnscore=pawnscore[x]; pawnnumber=x; }
    }

    return pawnnumber;
}

void savegame(unsigned char autosave)
{
    /* Save game to a gameslot
       Input: autosave is 1 for autosave, else 0 */

    char filename[15];
    unsigned char slot = 0;
    unsigned char x, y;
    unsigned char yesno = 1;

    if(autosave==1)
    {
        strcpy(filename,"LUDOSAV0.SAV");
    }
    else
    {
        menumakeborder(7,5,12,31);
        gotoxy(9,8);
        cprintf("%cSave game.%c", A_FWGREEN, A_FWRED);
        gotoxy(9,10);
        cprintf("%cChoose slot:%c", A_FWYELLOW, A_FWRED);
        do
        {
            slot = menupulldown(15,10,8) - 1;
        } while (slot<1);
        if(peek(saveslots+slot)==1)
        {
            gotoxy(9,10);
            cprintf("%cSlot not empty. Sure?%c", A_FWYELLOW, A_FWRED);
            yesno = menupulldown(15,10,5);
        }
        if(yesno==1)
        {
            gotoxy(9,10);
            cprintf("%cChoose name of save. %c", A_FWYELLOW, A_FWRED);
            if(peek(saveslots+slot)==0) { pulldownmenutitles[7][slot][0]=0; }
            input(9,10,pulldownmenutitles[7][slot],15);
            for(x=strlen(pulldownmenutitles[7][slot]);x<15;x++)
            {
                pulldownmenutitles[7][slot][x] = C_SPACE;
            }
            pulldownmenutitles[7][slot][15] = 0;
            sprintf(filename,"LUDOSAV%d.SAV", slot);
            for(x=0;x<16;x++)
            {
                poke(saveslots+(slot*16)+5+x,pulldownmenutitles[7][slot][x]);
            }
        }
        windowrestore();
    }
    if(yesno==1)
    {
        if(musicnumber) { PauseMusic(1); }
        poke(saveslots+slot,1);
        savefile("LUDODATA.COM", (void*)saveslots, 85);
        poke(savegamemem,turnofplayernr);
        for(x=0;x<4;x++)
        {
            poke(savegamemem+1+x, np[x] );
        }
        for(x=0;x<4;x++)
        {
            for(y=0;y<4;y++)
            {
                poke(savegamemem+5+(x*4)+y,playerdata[x][y]);
            }
        }
        for(x=0;x<4;x++)
        {
            for(y=0;y<4;y++)
            {
                poke(savegamemem+21+(x*8)+(y*2),playerpos[x][y][0]);
                poke(savegamemem+22+(x*8)+(y*2),playerpos[x][y][1]);
            }
        }
        for(x=0;x<4;x++)
        {
            for(y=0;y<21;y++)
            {
                poke(savegamemem+53+(x*21)+y,playername[x][y]);
            }
        }
        savefile(filename, (void*)savegamemem, 136);
        if(musicnumber) { PauseMusic(0); }
    }
}

void loadgame()
{
     /* Load game from a gameslot */

    char filename[15];
    unsigned char slot, rc, x, y;
    unsigned char yesno = 1;
    int len;
    
    menumakeborder(7,5,12,31);
    gotoxy(9,8);
    cprintf("%cLoad game.%c", A_FWGREEN, A_FWRED);
    gotoxy(9,10);
    cprintf("%cChoose slot:%c", A_FWYELLOW, A_FWRED);
    slot = menupulldown(15,10,8) - 1;
    if(peek(saveslots+slot)==0)
    {
        gotoxy(9,10);
        cprintf("%cSlot empty. %c", A_FWYELLOW, A_FWRED);
        gotoxy(9,11);
        cprintf("%cPress key. %c", A_FWYELLOW, A_FWRED);
        getkey("",1);
    }
    windowrestore();
    if(peek(saveslots+slot)==1)
    {
        if(musicnumber) { PauseMusic(1); }
        sprintf(filename,"LUDOSAV%d.SAV", slot);
        rc = loadfile(filename, (void*)savegamemem, &len);
        if(musicnumber) { PauseMusic(0); }
        turnofplayernr=peek(savegamemem);
        for(x=0;x<4;x++)
        {
            np[x]=peek(savegamemem+1+x);
        }
        for(x=0;x<4;x++)
        {
            for(y=0;y<4;y++)
            {
                playerdata[x][y]=peek(savegamemem+5+(x*4)+y);
            }
        }
        for(x=0;x<4;x++)
        {
            for(y=0;y<4;y++)
            {
                pawnerase(x,y);
                playerpos[x][y][0]=peek(savegamemem+21+(x*8)+(y*2));
                playerpos[x][y][1]=peek(savegamemem+22+(x*8)+(y*2));
                pawnplace(x,y,0);
            }
        }
        for(x=0;x<4;x++)
        {
            for(y=0;y<21;y++)
            {
                playername[x][y]=peek(savegamemem+53+(x*21)+y);
            }
        }
        endofgameflag = 2;
    }
}

void musicnext()
{
    /* Funtion to load and start next music track */

    int rc;
    int len = 0;
    char musicfilename[15];

    StopMusic();
    if(++musicnumber>3) { musicnumber = 1;}
    sprintf((char*)musicfilename,"LUDOMUS%d.BIN", musicnumber);
    rc = loadfile(musicfilename, (void*)0x9400, &len);
    PlayMusic();
}

/* Functions for windowing and menu system */

void windowsave(unsigned char ypos, unsigned char height)
{
    /* Function to save a window
       Input:
       - ypos: startline of window
       - height: height of window    */
    
    Window[windownumber].address = windowaddress;
    Window[windownumber].ypos = ypos;
    Window[windownumber].height = height;
    memcpy((char*)windowaddress, (char*)0xbba8 + Window[windownumber].ypos*40, Window[windownumber].height*40);
    windowaddress += Window[windownumber++].height*40;
}

void windowrestore()
{
    /* Function to restore a window */
    windowaddress = Window[--windownumber].address;
    memcpy((char*)0xbba8 + Window[windownumber].ypos*40, (char*)windowaddress, Window[windownumber].height*40);
}

void menumakeborder(unsigned char xpos, unsigned char ypos, unsigned char height, unsigned char width)
{
    /* Function to make menu border
       Input:
       - xpos: x-coordinate of left upper corner
       - ypos: y-coordinate of right upper corner
       - height: number of rows in window
       - width: window width in characters        */

    unsigned char x, y;
    
    windowsave(ypos, height+2);

    gotoxy(xpos-2,ypos+1);
    cputc(A_STD);
    cputc(A_FWRED);
    cputc(C_LOWRIGHT);
    for(x=0;x<width;x++) {cputc(C_LOWLINE); }
    cputc(C_LOWLEFT);
    for(y=0;y<height;y++)
    {
        gotoxy(xpos-2,ypos+y+2);
        cputc(A_STD);
        cputc(A_FWRED);
        cputc(C_RIGHTLINE);
        cspaces(width);
        cputc(C_LEFTLINE);
    }
    gotoxy(xpos-2,ypos+height+2);
    cputc(A_STD);
    cputc(A_FWRED);
    cputc(C_UPRIGHT);
    for(x=0;x<width;x++) { cputc(C_UPLINE); }
    cputc(C_UPLEFT);
}

void menuplacebar()
{
    /* Function to print menu bar */

    unsigned char x;

    gotoxy(0,1);
    cputc(A_FWBLACK);
    cputc(A_BGGREEN);
    for(x=0;x<menubaroptions;x++)
    {
        cprintf("%s ",menubartitles[x]);
    }
}

unsigned char menupulldown(unsigned char xpos, unsigned char ypos, unsigned char menunumber)
{
    /* Function for pull down menu
       Input:
       - xpos = x-coordinate of upper left corner
       - ypos = y-coordinate of upper left corner
       - menunumber = 
         number of the menu as defined in pulldownmenuoptions array */

    unsigned char x;
    char validkeys[6];
    unsigned char key;
    unsigned char exit = 0;
    unsigned char menuchoice = 1;

    windowsave(ypos, pulldownmenuoptions[menunumber-1]+4);
    if(menunumber>menubaroptions)
    {
        gotoxy(xpos,ypos+1);
        cputc(A_FWRED);
        cputc(C_LOWRIGHT);
        for(x=0;x<strlen(pulldownmenutitles[menunumber-1][0])+4;x++) { cputc(C_LOWLINE); }
    }
    for(x=0;x<pulldownmenuoptions[menunumber-1];x++)
    {
        gotoxy(xpos,ypos+x+2);
        cprintf("%c%c%c", A_FWRED,C_RIGHTLINE, A_BGCYAN);
        cputc(A_FWBLACK);
        cprintf("%s%c%c%c",            
            pulldownmenutitles[menunumber-1][x],A_FWRED,C_RIGHTLINE,A_BGBLACK);
    }
    gotoxy(xpos,ypos+pulldownmenuoptions[menunumber-1]+2);
    cputc(A_FWRED);
    cputc(C_UPRIGHT);
    for(x=0;x<strlen(pulldownmenutitles[menunumber-1][0])+4;x++) { cputc(C_UPLINE); }

    strcpy(validkeys, updownenter);
    if(menunumber<=menubaroptions)
    {
        strcat(validkeys, leftright);
    }
    
    do
    {
        gotoxy(xpos+2,ypos+menuchoice+1);
        cputc(A_BGYELLOW);
        cputc(A_FWBLACK);
        cprintf("%s%c%c%c",pulldownmenutitles[menunumber-1][menuchoice-1], A_FWRED,C_RIGHTLINE,A_BGBLACK);
        key = getkey(validkeys,joyinterface);
        switch (key)
        {
        case C_ENTER:
            exit = 1;
            break;
        
        case C_LEFT:
        case C_RIGHT:
            exit = 1;
            menuchoice = 10 + key;
            break;

        case C_DOWN:
        case C_UP:
            gotoxy(xpos+2,ypos+menuchoice+1);
            cputc(A_BGCYAN);
            cputc(A_FWBLACK);
            cprintf("%s%c%c%c",pulldownmenutitles[menunumber-1][menuchoice-1],A_FWRED,C_RIGHTLINE,A_BGBLACK);
            if(key==C_UP)
            {
                menuchoice--;
                if(menuchoice<1)
                {
                    menuchoice=pulldownmenuoptions[menunumber-1];
                }
            }
            else
            {
                menuchoice++;
                if(menuchoice>pulldownmenuoptions[menunumber-1])
                {
                    menuchoice = 1;
                }
            }
            break;

        default:
            break;
        }
    } while (exit==0);
    windowrestore();    
    return menuchoice;
}

unsigned char menumain()
{
    /* Function for main menu selection */

    unsigned char menubarchoice = 1;
    unsigned char menuoptionchoice = 0;
    unsigned char key;
    char validkeys[4] = {8,9,13,0};
    unsigned char xpos;

    do
    {
        do
        {
            gotoxy(menubarcoords[menubarchoice-1],1);
            cprintf("%c%s%c", A_BGWHITE,menubartitles[menubarchoice-1], A_BGGREEN);
            key = getkey(validkeys,joyinterface);
            gotoxy(menubarcoords[menubarchoice-1],1);
            cprintf("%c%s", A_BGGREEN,menubartitles[menubarchoice-1]);
            if(key==C_LEFT)
            {
                menubarchoice--;
                if(menubarchoice<1)
                {
                    menubarchoice = menubaroptions;
                }
            }
            else if (key==C_RIGHT)
            {
                menubarchoice++;
                if(menubarchoice>menubaroptions)
                {
                    menubarchoice = 1;
                }
            }
        } while (key!=C_ENTER);
        xpos=menubarcoords[menubarchoice-1]-1;
        if(xpos+strlen(pulldownmenutitles[menubarchoice-1][0])>38)
        {
            xpos=menubarcoords[menubarchoice-1]+strlen(menubartitles[menubarchoice-1])-strlen(pulldownmenutitles[menubarchoice-1][0]);
        }
        menuoptionchoice = menupulldown(xpos,0,menubarchoice);
        if(menuoptionchoice==18)
        {
            menuoptionchoice=0;
            menubarchoice--;
            if(menubarchoice<1)
            {
                    menubarchoice = menubaroptions;
            }
        }
        if(menuoptionchoice==19)
        {
            menuoptionchoice=0;
            menubarchoice++;
            if(menubarchoice>menubaroptions)
            {
                menubarchoice = 1;
            }
        }
    } while (menuoptionchoice==0);
    return menubarchoice*10+menuoptionchoice;    
}

unsigned char areyousure()
{
    /* Pull down menu to verify if player is sure */
    unsigned char choice;

    menumakeborder(8,8,6,30);
    gotoxy(10,11);
    cprintf("%cAre you sure ?%c", A_FWYELLOW, A_FWRED);
    choice = menupulldown(25,11,5);
    windowrestore();
    return choice;
}

/* Generic input routines */

unsigned char getkey(char* allowedkeys, unsigned char joyallowed)
{
    /* Function to wait on valid key or joystick press/move
       Input: allowedkeys = String with valid key press options
                            Empty string means any key allowed
       Output: key value (or joystick converted to key value)    */

    unsigned char key;

    do
    {
        key = 0;
        if(joyinterface && joyallowed)
        {
            ijk_read();
            if(ijk_ljoy&4) { key = C_ENTER; }
            if(ijk_ljoy&1) { key = C_RIGHT; }
            if(ijk_ljoy&2) { key = C_LEFT; }
            if(ijk_ljoy&8) { key = C_DOWN; }
            if(ijk_ljoy&16) { key = C_UP; }
            if(ijk_rjoy&4) { key = C_ENTER; }
            if(ijk_rjoy&1) { key = C_RIGHT; }
            if(ijk_rjoy&2) { key = C_LEFT; }
            if(ijk_rjoy&8) { key = C_DOWN; }
            if(ijk_rjoy&16) { key = C_UP; }
            if(key){
                do
                {
                   ijk_read();
                } while (ijk_ljoy || ijk_rjoy);
                wait(10);
            }
        }
        if(key == 0)
        {
            if(kbhit())
            {
                key = cgetc();
                if(strlen(allowedkeys)==0) { key = C_ENTER; }
            }
        }
    } while ( (strchr(allowedkeys, key)==0 && key != C_ENTER) || key == 0);
    return key;
}

int input(unsigned char xpos, unsigned char ypos, char *str, unsigned char size)
{
    /**
    * input/modify a string.
    * based on version DraCopy 1.0e, then modified.
    * Created 2009 by Sascha Bader.
    * @param[in] xpos screen x where input starts.
    * @param[in] ypos screen y where input starts.
    * @param[in,out] str string that is edited, it can have content and must have at   least @p size + 1 bytes. Maximum size if 255 bytes.
    * @param[in] size maximum length of @p str in bytes.
    * @return -1 if input was aborted.
    * @return >= 0 length of edited string @p str.
    */

    unsigned char idx = strlen(str);
    unsigned char c, x, b, flag;
    char validkeys[70] = {C_SPACE ,C_DELETE,0};

    strcat(validkeys,numbers);
    strcat(validkeys,letters);
    strcat(validkeys,updownenter);
    strcat(validkeys,leftright);
  
    gotoxy(xpos,ypos+1);
    cputc(A_FWWHITE);
    for(x=0;x<size+1;x++) { cputc(C_LOWLINE); }
    cputc(A_FWRED);

    cputsxy(xpos+1, ypos+1, str);
    cputc(C_INVSPACE);
  
    while(1)
    {
        c = getkey(validkeys,0);
        switch (c)
        {
            case C_ENTER:
                idx = strlen(str);
                str[idx] = 0;
                gotoxy(xpos+1,ypos+1);
                cspaces(size+1);
                cputsxy(xpos+1, ypos+1, str);
                return idx;
  
            case C_DELETE:
                if (idx)
                {
                    --idx;
                    cputcxy(xpos+idx+1, ypos+1, ' ');
                    for(x = idx; 1; ++x)
                    {
                        b = str[x+1];
                        str[x] = b;
                        cputcxy(xpos+x+1, ypos+1, b ? b : C_LOWLINE);
                        if (b == 0) { break; }
                    }
                    gotoxy(xpos+idx+1, ypos+1);
                    cputc(str[idx] ? 128+str[idx] : C_INVSPACE);
                    cputc(str[idx+1] ? str[idx+1] : C_LOWLINE);
                    gotoxy(xpos+idx+1, ypos+1);
                }
                break;
  
            case C_LEFT:
                if (idx)
                {
                    --idx;
                    gotoxy(xpos+idx+1, ypos+1);
                    cputc(str[idx] ? 128+str[idx] : C_INVSPACE);
                    cputc(str[idx+1] ? str[idx+1] : C_LOWLINE);
                    gotoxy(xpos+idx+1, ypos+1);
                }
                break;

            case C_RIGHT:
                if (idx < strlen(str) && idx < size)
                {
                    ++idx;
                    gotoxy(xpos+idx, ypos+1);
                    cputc(str[idx-1]);
                    cputc(str[idx] ? 128+str[idx] : C_INVSPACE);
                    gotoxy(xpos + idx + 1, ypos+1);
                }
                break;
  
            default:
                if (idx < size)
                {
                    flag = (str[idx] == 0);
                    str[idx] = c;
                    gotoxy(xpos+idx+1, ypos+1);
                    cputc(c);
                    cputc(C_INVSPACE);
                    ++idx;
                    if (flag) { str[idx+1] = 0; }
                }
                break;
        }
    }
    return 0;
}  

void wait(unsigned int wait_cycles)
 {
    /* Function to wait for the specified number of cycles
       Input: wait_cycles = numnber of cycles to wait       */

    unsigned int starttime = clock();
    while (clock() - starttime < wait_cycles);
}

void printcentered(char* text, unsigned char color, unsigned char xpos, unsigned char ypos, unsigned char width)
{
    /* Function to print a text centered
       Input:
       - Text:  Text to be printed
       - Color: Color for text to be printed
       - Width: Width of window to align to    */

    gotoxy(xpos,ypos+1);

    if(strlen(text)<width)
    {
        cspaces((width-strlen(text))/2-1);
    }
    cputc(color);
    cputs(text);
    cputc(A_FWRED);
}

void cspaces(unsigned char number)
{
    /* Function to print specified number of spaces */

    unsigned char x;

    for(x=0;x<number;x++) { cputc(C_SPACE); }
}

void cleararea(unsigned char xpos, unsigned char ypos, unsigned char height, unsigned char width)
{
    /* Function to clear area */

    unsigned char x;

    for(x=0;x<height;x++)
    {
        gotoxy(xpos,ypos+x+1);
        cspaces(width);
    }
} 