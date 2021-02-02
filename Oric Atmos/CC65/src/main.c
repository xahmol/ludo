/*
L U D O   MAIN PROGRAM
WRITTEN BY XANDER MOL
CONVERTED TO ORIC ATMOS BASIC IN 2020
CONVERTED TO ORIC ATMOS C IN 2021
ORIGINAL WRITTEN IN 1992 FOR COMMODORE 128
(C)2020 IDREAMTIN8BITS.COM
*/

/* Defines */
#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <string.h>
#include <joystick.h>
#include "osdklib.h"
#include "libsedoric.h"
#include "libmymplayer.h"

/* Functions */
void loadintro();
void loadmainscreen();
void turnhuman();
void musicnext();
void windowsave(unsigned char ypos, unsigned char height);
void windowrestore();
void menumakeborder(unsigned char xpos, unsigned char ypos, unsigned char height, unsigned char width);
void menuplacebar();
unsigned char menupulldown(unsigned char xpos, unsigned char ypos, unsigned char menunumber);
unsigned char menumain();
unsigned char* screenpos(unsigned char xpos, unsigned char ypos);
unsigned char getkey(unsigned char* allowedkeys, unsigned char joyallowed);
void wait(unsigned int wait_cs);

/* Variables */

//Window data
struct WindowStruct
{
    unsigned int address;
    unsigned char ypos;
    unsigned char height;
};
struct WindowStruct Window[9];

unsigned int windowaddress = 0xa100;
unsigned char windownumber = 1;

//Menu data
unsigned char menubaroptions = 4;
unsigned char pulldownmenunumber = 7;
unsigned char menubartitles[4][12] = {"Game","Disc","Music","Information"};
unsigned char menubarcoords[4] = {1,6,11,17};
unsigned char pulldownmenuoptions[7] = {3,2,3,1,2,2,3};
unsigned char pulldownmenutitles[7][3][15] = {
    {"Throw dice",
     "Restart   ",
     "Stop      "},
    {"Save game",
     "Load game"},
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
     "Stop         "}
};

//Input validation strings
unsigned char numbers[11]="0123456789";
unsigned char letters[53]="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
unsigned char updownenter[4] = {10,11,13,0};
unsigned char leftright[3] = {8,9,0};

//Pawn position co-ords main field
unsigned char vc[40][2] = {
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
unsigned char rc[4][8][2] = {
    {{ 2, 5}, { 5, 5}, { 2, 7}, { 5, 7}, { 5,15}, { 8,15}, {11,15}, {14,15}},
    {{29, 5}, {32, 5}, {29, 7}, {32, 7}, {17, 7}, {17, 9}, {17,11}, {17,13}},
    {{29,23}, {32,23}, {29,25}, {32,25}, {29,15}, {26,15}, {23,15}, {20,15}},
    {{ 2,23}, { 5,23}, { 2,25}, { 5,25}, {17,23}, {17,21}, {17,19}, {17,17}}
};
//Player data
unsigned char sp[4][4] = {
    {0,0,2,0},
    {0,0,1,0},
    {0,0,4,0},
    {0,0,3,0}
};
//Dice graphics string data
unsigned char dns[6][2][3] = {
    {{188,189,0},{190,191,0}},
    {{192,193,0},{193,194,0}},
    {{195,189,0},{190,196,0}},
    {{192,197,0},{198,194,0}},
    {{195,199,0},{200,196,0}},
    {{201,201,0},{202,202,0}}
};
unsigned char sc[4][4][2];
unsigned char pm[4];
unsigned char np[4];
int pw[3];
unsigned char ei = 0;
unsigned char joyinterface = 0;
unsigned char musicnumber = 1;

/* Main routine */

void main()
{
    unsigned char x;

    //Game start
    clrscr();
    bgcolor(0);    
    textcolor(3);

    loadintro();

    loadmainscreen();

    //Ask for loading save game
    menumakeborder(18,8,6,20);
    gotoxy(20,11);
    cprintf("%cLoad old game?%c",A_FWYELLOW, A_FWRED);
    menupulldown(27,11,5);
    windowrestore();

    turnhuman();
    
    //End of game
    clrscr();
    bgcolor(0);    
    textcolor(3);
    for(x=0;x<40;x++) { poke(0xbb80+x,0); }
    gotoxy(1,1);
    cprintf("%cThanks for playing, goodbye.",A_FWCYAN);
    endmusic();
}

/* Game routines */
void loadintro()
{
    /* Game intro */

    int rc;
    int len = 0;

    rc = loadfile("LUDOTITL.BIN", (void*)0xb500, &len);
    rc = loadfile("LUDOMUS1.BIN", (void*)0x7600, &len);
    startmusic();
    cgetc();
}

void loadmainscreen()
{
    /* Function to load main screen and print menu bar */

    int rc;
    int len = 0;
    rc = loadfile("LUDOSCRM.BIN", (void*)0xb500, &len);
    menuplacebar();
}

void turnhuman()
{
    /* Turn for the human players */

    unsigned char choice;

    do
    {
        choice = menumain();
        switch (choice)
        {
        case 31:
            musicnext();
            break;

        case 32:
            endmusic();
            break;
        
        case 33:
            endmusic();
            startmusic();
            break;
        
        default:
            break;
        }
    } while (choice != 11);
}

void musicnext()
{
    /* Funtion to load and start next music track */

    int rc;
    int len = 0;
    unsigned char musicfilename[15];

    endmusic();
    if(++musicnumber>3) { musicnumber = 1;}
    sprintf((char*)musicfilename,"LUDOMUS%d.BIN", musicnumber);
    rc = loadfile(musicfilename, (void*)0x7600, &len);
    startmusic();
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
    unsigned char* screen;
    
    windowsave(ypos, height+2);

    screen = screenpos(xpos-2,ypos+1);
    poke(screen++,A_STD);
    poke(screen++,A_FWRED);
    poke(screen++,125);
    for(x=0;x<width;x++) {poke(screen++,94); }
    poke(screen,126);
    for(y=0;y<height;y++)
    {
        screen = screenpos(xpos-2,ypos+y+2);
        poke(screen++,A_STD);
        poke(screen++,A_FWRED);
        poke(screen++,91);
        for(x=0;x<width;x++) { poke(screen++, 32); }
        poke(screen,92);
    }
    screen = screenpos(xpos-2,ypos+height+2);
    poke(screen++,A_STD);
    poke(screen++,A_FWRED);
    poke(screen++,123);
    for(x=0;x<width;x++) { poke(screen++,93); }
    poke(screen,124);
}

void menuplacebar()
{
    /* Function to print menu bar */

    unsigned char x;

    poke(0xbba8,A_FWBLACK);
    gotoxy(1,1);
    cprintf("%c", A_BGGREEN);
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
    unsigned char validkeys[6];
    unsigned char key;
    unsigned char exit = 0;
    unsigned char menuchoice = 1;
    unsigned char* screen;

    windowsave(ypos, pulldownmenuoptions[menunumber]+4);
    if(menunumber>menubaroptions)
    {
        screen = screenpos(xpos,ypos+1);
        poke(screen++,A_FWRED);
        poke(screen++,125);
        for(x=0;x<strlen(pulldownmenutitles[menunumber-1][0])+4;x++) { poke(screen++,94); }
    }
    for(x=0;x<pulldownmenuoptions[menunumber-1];x++)
    {
        gotoxy(xpos,ypos+x+2);
        cprintf("%c%c%c", A_FWRED,91, A_BGCYAN);
        poke(screenpos(xpos+3,ypos+x+2),A_FWBLACK);
        gotoxy(xpos+4,ypos+x+2);
        cprintf("%s%c%c%c",            
            pulldownmenutitles[menunumber-1][x],A_FWRED,91,A_BGBLACK);
    }
    screen = screenpos(xpos,ypos+pulldownmenuoptions[menunumber-1]+2);
    poke(screen++,A_FWRED);
    poke(screen++,123);
    for(x=0;x<strlen(pulldownmenutitles[menunumber-1][0])+4;x++) { poke(screen++,93); }

    strcpy(validkeys, updownenter);
    if(menunumber<=menubaroptions)
    {
        strcat(validkeys, leftright);
    }
    
    do
    {
        poke(screenpos(xpos+2,ypos+menuchoice+1), A_BGYELLOW);
        poke(screenpos(xpos+3,ypos+menuchoice+1),A_FWBLACK);
        gotoxy(xpos+4,ypos+menuchoice+1);
        cprintf("%s%c%c%c",pulldownmenutitles[menunumber-1][menuchoice-1], A_FWRED,91,A_BGBLACK);
        key = getkey(validkeys,joyinterface);
        switch (key)
        {
        case 13:
            exit = 1;
            break;
        
        case 8:
        case 9:
            exit = 1;
            menuchoice = 10 + key;
            break;

        case 10:
        case 11:
            poke(screenpos(xpos+2,ypos+menuchoice+1), A_BGCYAN);
            poke(screenpos(xpos+3,ypos+menuchoice+1), A_FWBLACK);
            gotoxy(xpos+4,ypos+menuchoice+1);
            cprintf("%s%c%c%c",pulldownmenutitles[menunumber-1][menuchoice-1],A_FWRED,91,A_BGBLACK);
            if(key==11)
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
    unsigned char validkeys[4] = {8,9,13,0};
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
            if(key==8)
            {
                menubarchoice--;
                if(menubarchoice<1)
                {
                    menubarchoice = menubaroptions;
                }
            }
            else if (key==9)
            {
                menubarchoice++;
                if(menubarchoice>menubaroptions)
                {
                    menubarchoice = 1;
                }
            }
        } while (key!=13);
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

/* Generic screen functions */

unsigned char* screenpos(unsigned char xpos, unsigned char ypos)
{
    /* Function to calculate screen memory position of 
       given x,y co-ordinates.
       Input:
       - xpos: x-co-ordinate
       - ypos: y-co-ordinate
       Output: pointer to correct screen memoery position */
       
    return (char*)0xbb80 + ypos*40 + xpos;
}

/* Generic input routines */

unsigned char getkey(unsigned char* allowedkeys, unsigned char joyallowed)
{
    /* Function to wait on valid key or joystick press/move
       Input: allowedkeys = string with valid key press options
       Output: key value (or joystick converted to key value)    */

    unsigned char key;

    do
    {
        key = 0;
        /*if(ijk_present && joyallowed)
        {
            ijk_read();
            if(ijk_ljoy&4) { key = 13; }
            if(ijk_ljoy&1) { key = 9; }
            if(ijk_ljoy&2) { key = 8; }
            if(ijk_ljoy&8) { key = 10; }
            if(ijk_ljoy&16) { key = 11; }
            if(ijk_rjoy&4) { key = 13; }
            if(ijk_rjoy&1) { key = 9; }
            if(ijk_rjoy&2) { key = 8; }
            if(ijk_rjoy&8) { key = 10; }
            if(ijk_rjoy&16) { key = 11; }
            if(key){
                do
                {
                   ijk_read();
                } while (ijk_ljoy || ijk_rjoy);
            }
        }*/
        if(key == 0)
        {
            if(kbhit()) { key = cgetc();}
        }
    } while (strchr(allowedkeys, key)==0 || key == 0);
    return key;
}

void wait(unsigned int wait_cs)
 {
 	//we use TIMER3 at adress #276-#277
	doke(0x0276,wait_cs);
	while ( deek(0x0276)>0){};
}