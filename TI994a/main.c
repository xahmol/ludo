/*
L U D O
Written in 1992,2020, 2021 by Xander Mol

https://github.com/xahmol/ludo
https://www.idreamtin8bits.com/

Originally written in 1992 in Commodore BASIC 7.0 for the Commodore 128
Rewritten for Oric Atmos in BASIC in 2020
Rewritten for Oric Atmos in C using CC65 in 2021
Rewritten for TI-99/4a in C using TMS9900-GCC in 2021

Code and resources from others used:

-   TMS9900 modification of GCC by Insomnia
    https://atariage.com/forums/topic/164295-gcc-for-the-ti/

-   Jedimatt42 for:
    - TMS9900-GCC installation script and instructions
      https://atariage.com/forums/topic/164295-gcc-for-the-ti/page/24/?tab=comments#comment-4776745
    - TIPI software and code examples
      https://github.com/jedimatt42/tipi

-   PeteE on Makefile code to adapt Magellan screens:
    https://github.com/peberlein/turmoil

-   TheCodex for Magellan tool to create screens
    https://atariage.com/forums/topic/161356-magellan/

-   Original windowing system code on Commodore 128 by unknown author.

-   Music credits:
    R-Type level 1 by Wally Beben/Alain Derpin
    Defender of the Crown by David Whittaker/Aldn
    Wizzball by Peter Johnson/Aldn
    
-   Documentation used:
    AtariAge TI-99/4a community
    https://atariage.com/forums/forum/164-ti-994a-computers/
 
-   Tooling to transfer original Commodore software code: "
    VICE by VICE authors
    DirMaster by The Wiz/Elwix
    CharPad Free by Subchrist software
    UltimateII+ cartridge by Gideon Zweijtzer
    
-   Tested using Classic99 emulator and original TI-99/4a with TIPI. 

The code can be used freely as long as you retain
a notice describing original source and author.

THE PROGRAMS ARE DISTRIBUTED IN THE HOPE THAT THEY WILL BE USEFUL,
BUT WITHOUT ANY WARRANTY. USE THEM AT YOUR OWN RISK!
*/

/* Includes */
#include "system.h"
#include "conio.h"
#include "kscan.h"
#include "string.h"
#include "vdp.h"
#include "graphics.h"
#include "defines.h"

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
unsigned char windowmemory[768];
unsigned char windownumber = 0;

//Menu data
unsigned char menubaroptions = 4;
unsigned char pulldownmenunumber = 8;
unsigned char menubartitles[4][12] = {"Game","Disc","Music","Info"};
unsigned char menubarcoords[4] = {6,11,16,22};
unsigned char pulldownmenuoptions[8] = {3,3,3,1,2,2,3,5};
unsigned char pulldownmenutitles[8][5][16] = {
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
unsigned char numbers[11]="0123456789";
unsigned char letters[53]="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
unsigned char updownenter[4] = {C_DOWN,C_UP,C_ENTER,0};
unsigned char leftright[3] = {C_LEFT,C_RIGHT,0};

//Game variables
unsigned char endofgameflag = 0;
unsigned char turnofplayernr = 0;
unsigned char zv = 0;
unsigned char ns = 0;
unsigned char throw;
unsigned char musicnumber = 0;
unsigned char joyinterface = 0;
unsigned char autosavetoggle = 0;

/* string.h functions not present in LIBTI99 */
unsigned char* strcat(unsigned char *dest, unsigned const char *src)
{
  strcpy (dest + strlen (dest), src);
  return dest;
}

unsigned char* strchr(unsigned register const char *s, unsigned int c)
{
  do {
    if (*s == c)
      {
        return (char*)s;
      }
  } while (*s++);
  return (0);
}

/* Generic input routines */
unsigned char getkey(unsigned char* allowedkeys, unsigned char joyallowed)
{
    /* Function to wait on valid key or joystick press/move
       Input: allowedkeys = String with valid key press options
                            Empty string means any key allowed
       Output: key value (or joystick converted to key value)    */

    unsigned char key, joy1, joy2;

    do
    {
        key = 0;
        //if(joyinterface && joyallowed)
        //{
        //    joy1 = joy_read(JOY_1);
        //    joy2 = joy_read(JOY_2);
        //    gotoxy(1,1);
        //    if(JOY_BTN_1(joy1) || JOY_BTN_1(joy2)) { key = C_ENTER; }
        //    if(JOY_RIGHT(joy1) || JOY_RIGHT(joy2)) { key = C_RIGHT; }
        //    if(JOY_LEFT(joy1) || JOY_LEFT(joy2)) { key = C_LEFT; }
        //    if(JOY_DOWN(joy1) || JOY_DOWN(joy2)) { key = C_DOWN; }
        //    if(JOY_UP(joy1) || JOY_UP(joy2)) { key = C_UP; }
        //    if(key){
        //        do
        //        {
        //            joy1 = joy_read(JOY_1);
        //            joy2 = joy_read(JOY_2);
        //        } while (joy1 != 32 || joy2 != 32 );
        //        wait(10);
        //    }
        //}
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

/* General screen functions */
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
        gotoxy(xpos,ypos+x);
        cspaces(width);
    }
}

void printcentered(unsigned char* text, unsigned char xpos, unsigned char ypos, unsigned char width)
{
    /* Function to print a text centered
       Input:
       - Text:  Text to be printed
       - Color: Color for text to be printed
       - Width: Width of window to align to    */

    gotoxy(xpos,ypos);

    if(strlen(text)<width)
    {
        cspaces((width-strlen(text))/2-1);
    }
    cputs(text);
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
    vdpmemread(gImage+Window[windownumber].ypos*32, windowmemory, Window[windownumber].height*32);
    vdpmemcpy(windowaddress, windowmemory,  Window[windownumber].height*32);
    windowaddress += Window[windownumber++].height*32;
}

void windowrestore()
{
    /* Function to restore a window */
    windowaddress = Window[--windownumber].address;
    vdpmemread(windowaddress, windowmemory, Window[windownumber].height*32);
    vdpmemcpy(gImage+Window[windownumber].ypos*32, windowmemory, Window[windownumber].height*32);
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

    vdpchar(gImage+xpos+(ypos*32),C_LOWRIGHT);
    for(x=0;x<width;x++) {vdpchar(gImage+(xpos+x+1)+(ypos*32),C_LOWLINE); }
    vdpchar(gImage+(xpos+width)+(ypos*32),C_LOWLEFT);
    for(y=0;y<height;y++)
    {
        vdpchar(gImage+xpos+(ypos+y+1)*32,C_RIGHTLINE);
        gotoxy(xpos+1,ypos+y+1);
        cspaces(width);
        vdpchar(gImage+(xpos+width)+(ypos+y+1)*32,C_LEFTLINE);
    }
    vdpchar(gImage+xpos+(ypos+height+1)*32,C_UPRIGHT);
    for(x=0;x<width;x++) { vdpchar(gImage+(xpos+x+1)+(ypos+height+1)*32,C_UPLINE); }
    vdpchar(gImage+(xpos+width)+(ypos+height+1)*32,C_UPLEFT);
}

void menuplacebar()
{
    /* Function to print menu bar */

    unsigned char x;

    gotoxy(6,0);
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

    windowsave(ypos, pulldownmenuoptions[menunumber]+4);
    if(menunumber>menubaroptions)
    {
        vdpchar(gImage+xpos+(ypos*32),C_LOWRIGHT);
        for(x=0;x<strlen(pulldownmenutitles[menunumber-1][0])+2;x++) { vdpchar(gImage+xpos+x+1+(ypos*32),C_LOWLINE); }
    }
    for(x=0;x<pulldownmenuoptions[menunumber-1];x++)
    {
        vdpchar(gImage+xpos+(ypos+x+1)*32,C_RIGHTLINE);
        gotoxy(xpos+1,ypos+x+1);
        cprintf(" %s ",pulldownmenutitles[menunumber-1][x]);
        vdpchar(gImage+xpos+strlen(pulldownmenutitles[menunumber-1][x])+2+(ypos+x+1)*32,C_RIGHTLINE);
    }
    vdpchar(gImage+xpos+(ypos+pulldownmenuoptions[menunumber-1]+1)*32,C_UPRIGHT);
    for(x=0;x<strlen(pulldownmenutitles[menunumber-1][0])+2;x++)
    {
        vdpchar(gImage+xpos+x+1+(ypos+pulldownmenuoptions[menunumber-1]+1)*32,C_UPLINE);
    }

    strcpy(validkeys, updownenter);
    if(menunumber<=menubaroptions)
    {
        strcat(validkeys, leftright);
    }
    
    do
    {
        vdpchar(gImage+xpos+1+(ypos+menuchoice)*32,C_ARROW);
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
            vdpchar(gImage+xpos+1+(ypos+menuchoice)*32,C_SPACE);
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
    unsigned char key, x;
    unsigned char validkeys[4] = {C_LEFT,C_RIGHT,C_ENTER,0};
    unsigned char xpos;

    do
    {
        do
        {
            for(x=0;x<strlen(menubartitles[menubarchoice-1]);x++)
            {
                vdpchar(gImage+menubarcoords[menubarchoice-1]+x+32,C_UPLINE);
            }
            key = getkey(validkeys,joyinterface);
            gotoxy(menubarcoords[menubarchoice-1],1);
            cspaces(strlen(menubartitles[menubarchoice-1]));
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

    menumakeborder(10,5,6,20);
    cputsxy(12,7,"Are you sure?");
    choice = menupulldown(20,8,5);
    windowrestore();
    return choice;
}

void graphicsinit()
{
    set_graphics(0);
    windowaddress = 0x2020;
    bgcolor(COLOR_BLACK);
    vdpmemcpy(gColor, colorset, sizeof(colorset));
    vdpmemcpy(gPattern, patterns, sizeof(patterns));
    clrscr();
}

void loadmainscreen()
{
    vdpmemcpy(gImage, mainscreen, sizeof(mainscreen));
}

int main()
{
    unsigned char x;
    
    graphicsinit();
    loadmainscreen();

    areyousure();
    menuplacebar();
    menumain();

    while(!kbhit());
    cgetc();

    return 0;
}