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

-   LIBTI99 and LIBTIVGM2 libraries by Tursi aka Mike Brent

    LIBTI99: Generic library for conio, sound, file and VDP functions
    https://github.com/tursilion/libti99

    LIBTIVGM2: Library for VGMComp2 music functions
    https://github.com/tursilion/vgmcomp2/tree/master/Players/libtivgm2

-   Jedimatt42 for:
    - TMS9900-GCC installation script and instructions
      https://atariage.com/forums/topic/164295-gcc-for-the-ti/page/24/?tab=comments#comment-4776745
    - Speech library:
      Source: https://github.com/jedimatt42/fcmd/tree/jm42/say-toy/example/gcc/say
      See forum thread on AtariAge:
      https://atariage.com/forums/topic/318907-doing-speech-in-c-using-tms9900-gcc/
    - TIPI software and code examples
      https://github.com/jedimatt42/tipi

-   PeteE on Makefile code to adapt Magellan screens and random() function:
    https://github.com/peberlein/turmoil

-   TheCodex for Magellan tool to create screens
    https://atariage.com/forums/topic/161356-magellan/

-   PTWZ for Python Wizard to convert speech to LPC data:
    https://github.com/ptwz/python_wizard

-   Original windowing system code on Commodore 128 by unknown author.

-   Music credits:
    R-Type: Game Start Music
    https://www.smspower.org/Music/RType-SMS-PSG
    Astro Warriot: Galaxy Zone
    https://www.smspower.org/Music/AstroWarrior-SMS
    Submarine Attack: Title Screen
    https://www.smspower.org/Music/SubmarineAttack-SMS
    
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

//Includes
#include <stdio.h>
#include <string.h>
#include <peekpoke.h>
#include <cbm.h>
#include <conio.h>
#include <stdlib.h>
#include <errno.h>
#include <ctype.h>
#include <device.h>
#include <accelerator.h>
#include <c128.h>
#include <time.h>
#include "vdc_core.h"
#include "defines.h"

//Window data
struct WindowStruct
{
    unsigned int address;
    unsigned char ypos;
    unsigned char height;
};
struct WindowStruct Window[9];

unsigned int windowaddress = WINDOWBASEADDRESS;
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
     { 0,11}, { 5,11}, {10,11}, {15,11}, {20,11},
     {20, 9}, {20, 7}, {20, 5}, {20, 3}, {25, 3},
     {30, 3}, {30, 5}, {30, 7}, {30, 9}, {30,11},
     {35,11}, {40,11}, {45,11}, {50,11}, {50,13},
     {50,15}, {45,15}, {40,15}, {35,15}, {30,15},
     {30,17}, {30,19}, {30,21}, {30,23}, {25,23},
     {20,23}, {20,21}, {20,19}, {20,17}, {20,15},
     {15,15}, {10,15}, { 5,15}, { 0,15}, { 0,13}
};
//Pawn posiiion co-ords start and destination
unsigned char homedestcoords[4][8][2] = {
    {{ 0, 3}, { 5, 3}, { 0, 5}, { 5, 5}, { 5,13}, {10,13}, {15,13}, {20,13}},
    {{45, 3}, {50, 3}, {45, 5}, {50, 5}, {25, 5}, {25, 7}, {25, 9}, {25,11}},
    {{45,21}, {50,21}, {45,23}, {50,23}, {45,13}, {40,13}, {35,13}, {30,13}},
    {{ 0,21}, { 5,21}, { 0,23}, { 5,23}, {25,21}, {25,19}, {25,17}, {25,15}}
};
/* Player data:
    [players 0-3]
    [position 0: human = 0 or computer = 1
     position 1: number of pawns not at destination
     position 2: player color
     position 3: number of pawns at home              */
unsigned char playerdata[4][4] = {
    {0,4,VDC_LGREEN,4},
    {0,4,VDC_LRED,4},
    {0,4,VDC_LBLUE,4},
    {0,4,VDC_LYELLOW,4}
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

//Pawn, field and dice graphics string data
char dicegraphics[6][2][3] = {
    {{C_DICE01,C_DICE02,0},{C_DICE03,C_DICE04,0}},
    {{C_DICE05,C_DICE06,0},{C_DICE06,C_DICE07,0}},
    {{C_DICE08,C_DICE02,0},{C_DICE03,C_DICE09,0}},
    {{C_DICE05,C_DICE10,0},{C_DICE11,C_DICE07,0}},
    {{C_DICE08,C_DICE12,0},{C_DICE13,C_DICE09,0}},
    {{C_DICE14,C_DICE14,0},{C_DICE15,C_DICE15,0}}
};

char pawngraphics[2][4] = {
    { 32,149,150, 32} , { 32,151,152, 32}
};

char fieldgraphics[2][2][4] = {
    {{133,134,135,136} , {137,138,139,140}},
    {{141,142,143,144} , {145,146,147,148}}
};

char startfieldgraphics[4][2][4] = {
    {{141,167,168,144} , {145,169,170,148}},
    {{141,176,177,144} , {145,178,179,148}},
    {{141,163,164,144} , {145,165,166,148}},
    {{141,180,181,144} , {145,182,183,148}}
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

/* General functions */
void wait(clock_t wait_cycles)
 {
    /* Function to wait for the specified number of cycles
       Input: wait_cycles = numnber of cycles to wait       */

    clock_t starttime = clock();
    while (clock() - starttime < wait_cycles);
}

/* General screen functions */
void cspaces(unsigned char number)
{
    /* Function to print specified number of spaces, cursor set by conio.h functions */

    unsigned char x;

    for(x=0;x<number;x++) { cputc(C_SPACE); }
}

void printcentered(char* text, unsigned char xpos, unsigned char ypos, unsigned char width)
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
            //ijk_read();
            //if(ijk_ljoy&4) { key = C_ENTER; }
            //if(ijk_ljoy&1) { key = C_RIGHT; }
            //if(ijk_ljoy&2) { key = C_LEFT; }
            //if(ijk_ljoy&8) { key = C_DOWN; }
            //if(ijk_ljoy&16) { key = C_UP; }
            //if(ijk_rjoy&4) { key = C_ENTER; }
            //if(ijk_rjoy&1) { key = C_RIGHT; }
            //if(ijk_rjoy&2) { key = C_LEFT; }
            //if(ijk_rjoy&8) { key = C_DOWN; }
            //if(ijk_rjoy&16) { key = C_UP; }
            //if(key){
            //    do
            //    {
            //       ijk_read();
            //    } while (ijk_ljoy || ijk_rjoy);
            //    wait(10);
            //}
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
    char validkeys[70] = {C_SPACE ,C_DELETE,C_INSERT,0};

    strcat(validkeys,numbers);
    strcat(validkeys,letters);
    strcat(validkeys,updownenter);
    strcat(validkeys,leftright);
  
    VDC_HChar(ypos,xpos,C_SPACE,size,VDC_WHITE+VDC_A_UNDERLINE+VDC_A_ALTCHAR);
    VDC_PrintAt(ypos,xpos,str,VDC_WHITE+VDC_A_UNDERLINE+VDC_A_ALTCHAR);
    VDC_Plot(ypos,xpos,C_SPACE,VDC_WHITE+VDC_A_REVERSE+VDC_A_ALTCHAR);
  
    while(1)
    {
        c = getkey(validkeys,0);
        switch (c)
        {
            case C_ENTER:
                idx = strlen(str);
                str[idx] = 0;
                VDC_HChar(ypos,xpos,C_SPACE,size,VDC_LYELLOW+VDC_A_ALTCHAR);
                VDC_PrintAt(ypos,xpos,str,VDC_LYELLOW+VDC_A_ALTCHAR);
                return idx;
  
            case C_DELETE:
                if (idx)
                {
                    --idx;
                    VDC_Plot(ypos,xpos+idx,C_SPACE,VDC_WHITE+VDC_A_UNDERLINE+VDC_A_ALTCHAR);
                    for(x = idx; 1; ++x)
                    {
                        b = str[x+1];
                        str[x] = b;
                        VDC_Plot(ypos,xpos+x, b ? VDC_PetsciiToScreenCode(b) : C_LOWLINE,VDC_WHITE+VDC_A_UNDERLINE+VDC_A_ALTCHAR);
                        if (b == 0) { break; }
                    }
                    VDC_Plot(ypos,xpos+idx,str[idx] ? VDC_PetsciiToScreenCode(str[idx]) : C_SPACE,VDC_WHITE+VDC_A_REVERSE+VDC_A_ALTCHAR);
                    VDC_Plot(ypos,xpos+idx+1,str[idx+1] ? VDC_PetsciiToScreenCode(str[idx+1]) : C_SPACE,VDC_WHITE+VDC_A_UNDERLINE+VDC_A_ALTCHAR);
                }
                break;

            case C_INSERT:
                c = strlen(str);
                if (c < size && c > 0 && idx < c)
                {
                    ++c;
                    while(c >= idx)
                    {
                        str[c+1] = str[c];
                        if (c == 0) { break; }
                        --c;
                    }
                    str[idx] = ' ';
                    VDC_PrintAt(ypos,xpos,str,VDC_WHITE+VDC_A_UNDERLINE+VDC_A_ALTCHAR);
                    VDC_Plot(ypos,xpos+idx,C_SPACE,VDC_WHITE+VDC_A_REVERSE+VDC_A_ALTCHAR);
                }
                break;
  
            case C_LEFT:
                if (idx)
                {
                    --idx;
                    VDC_Plot(ypos,xpos+idx,str[idx] ? VDC_PetsciiToScreenCode(str[idx]) : C_SPACE,VDC_WHITE+VDC_A_REVERSE+VDC_A_ALTCHAR);
                    VDC_Plot(ypos,xpos+idx+1,str[idx+1] ? VDC_PetsciiToScreenCode(str[idx+1]) : C_SPACE,VDC_WHITE+VDC_A_UNDERLINE+VDC_A_ALTCHAR);
                }
                break;

            case C_RIGHT:
                if (idx < strlen(str) && idx < size)
                {
                    ++idx;
                    VDC_Plot(ypos,xpos+idx-1,VDC_PetsciiToScreenCode(str[idx-1]),VDC_WHITE+VDC_A_UNDERLINE+VDC_A_ALTCHAR);
                    VDC_Plot(ypos,xpos+idx,str[idx] ? VDC_PetsciiToScreenCode(str[idx]) : C_SPACE,VDC_WHITE+VDC_A_REVERSE+VDC_A_ALTCHAR);
                }
                break;
  
            default:
                if (idx < size)
                {
                    flag = (str[idx] == 0);
                    str[idx] = c;
                    VDC_Plot(ypos,xpos+idx,VDC_PetsciiToScreenCode(c),VDC_WHITE+VDC_A_UNDERLINE+VDC_A_ALTCHAR);
                    VDC_Plot(ypos,xpos+idx+1,C_SPACE,VDC_WHITE+VDC_A_REVERSE+VDC_A_ALTCHAR);
                    ++idx;
                    if (flag) { str[idx+1] = 0; }
                }
                break;
        }
    }
    return 0;
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

    // Copy characters
    VDC_CopyVDCToMem(ypos*80,windowaddress,1,height*80);
    windowaddress += height*80;

    // Copy attributes
    VDC_CopyVDCToMem(0x0800+ypos*80,windowaddress,1,height*80);
    windowaddress += height*80;

    windownumber++;
}

void windowrestore()
{
    /* Function to restore a window */
    windowaddress = Window[--windownumber].address;

    // Restore characters
    VDC_CopyMemToVDC(Window[windownumber].ypos*80,windowaddress,1,Window[windownumber].height*80);

    // Restore attributes
    VDC_CopyMemToVDC(0x0800+(Window[windownumber].ypos*80),windowaddress+(Window[windownumber].height*80),1,Window[windownumber].height*80);
}

void menumakeborder(unsigned char xpos, unsigned char ypos, unsigned char height, unsigned char width)
{
    /* Function to make menu border
       Input:
       - xpos: x-coordinate of left upper corner
       - ypos: y-coordinate of right upper corner
       - height: number of rows in window
       - width: window width in characters        */
 
    windowsave(ypos, height+2);

    VDC_FillArea(ypos+1,xpos+1,C_SPACE,width,height,VDC_LYELLOW);
    VDC_Plot(ypos,xpos,C_LOWRIGHT,VDC_LRED);
    VDC_HChar(ypos,xpos+1,C_LOWLINE,width,VDC_LRED);
    VDC_Plot(ypos,xpos+width+1,C_LOWLEFT,VDC_LRED);
    VDC_VChar(ypos+1,xpos,C_RIGHTLINE,height,VDC_LRED);
    VDC_VChar(ypos+1,xpos+width+1,C_LEFTLINE,height,VDC_LRED);
    VDC_Plot(ypos+height+1,xpos,C_UPRIGHT,VDC_LRED);
    VDC_HChar(ypos+height+1,xpos+1,C_UPLINE,width,VDC_LRED);
    VDC_Plot(ypos+height+1,xpos+width+1,C_UPLEFT,VDC_LRED);
}

void menuplacebar()
{
    /* Function to print menu bar */

    unsigned char x;

    for(x=0;x<menubaroptions;x++)
    {
        VDC_PrintAt(1,menubarcoords[x],menubartitles[x],VDC_DGREEN+VDC_A_REVERSE);
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
        VDC_Plot(ypos,xpos,C_LOWRIGHT,VDC_LRED);
        VDC_HChar(ypos,xpos+1,C_LOWLINE,strlen(pulldownmenutitles[menunumber-1][0])+2,VDC_LRED);
        VDC_Plot(ypos,xpos+strlen(pulldownmenutitles[menunumber-1][0])+3,C_LOWLEFT,VDC_LRED);
    }
    for(x=0;x<pulldownmenuoptions[menunumber-1];x++)
    {
        VDC_Plot(ypos+x+1,xpos,C_RIGHTLINE,VDC_LRED);
        VDC_Plot(ypos+x+1,xpos+1,C_SPACE,VDC_LCYAN+VDC_A_REVERSE);
        VDC_PrintAt(ypos+x+1,xpos+2,pulldownmenutitles[menunumber-1][x],VDC_LCYAN+VDC_A_REVERSE);
        VDC_Plot(ypos+x+1,xpos+strlen(pulldownmenutitles[menunumber-1][x])+2,C_SPACE,VDC_LCYAN+VDC_A_REVERSE);
        VDC_Plot(ypos+x+1,xpos+strlen(pulldownmenutitles[menunumber-1][x])+3,C_LEFTLINE,VDC_LRED);
    }
    VDC_Plot(ypos+pulldownmenuoptions[menunumber-1]+1,xpos,C_UPRIGHT,VDC_LRED);
    VDC_HChar(ypos+pulldownmenuoptions[menunumber-1]+1,xpos+1,C_UPLINE,strlen(pulldownmenutitles[menunumber-1][0])+2,VDC_LRED);
    VDC_Plot(ypos+pulldownmenuoptions[menunumber-1]+1,xpos+strlen(pulldownmenutitles[menunumber-1][0])+3,C_UPLEFT,VDC_LRED);

    strcpy(validkeys, updownenter);
    if(menunumber<=menubaroptions)
    {
        strcat(validkeys, leftright);
    }
    
    do
    {
        VDC_Plot(ypos+menuchoice,xpos+1,C_SPACE,VDC_LYELLOW+VDC_A_REVERSE);
        VDC_PrintAt(ypos+menuchoice,xpos+2,pulldownmenutitles[menunumber-1][menuchoice-1],VDC_LYELLOW+VDC_A_REVERSE);
        VDC_Plot(ypos+menuchoice,xpos+strlen(pulldownmenutitles[menunumber-1][menuchoice-1])+2,C_SPACE,VDC_LYELLOW+VDC_A_REVERSE);

        key = getkey(validkeys,joyinterface);
        switch (key)
        {
        case C_ENTER:
            exit = 1;
            break;
        
        case C_LEFT:
            exit = 1;
            menuchoice = 18;
            break;
        
        case C_RIGHT:
            exit = 1;
            menuchoice = 19;
            break;

        case C_DOWN:
        case C_UP:
            VDC_Plot(ypos+menuchoice,xpos+1,C_SPACE,VDC_LCYAN+VDC_A_REVERSE);
            VDC_PrintAt(ypos+menuchoice,xpos+2,pulldownmenutitles[menunumber-1][menuchoice-1],VDC_LCYAN+VDC_A_REVERSE);
            VDC_Plot(ypos+menuchoice,xpos+strlen(pulldownmenutitles[menunumber-1][menuchoice-1])+2,C_SPACE,VDC_LCYAN+VDC_A_REVERSE);
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
    char validkeys[4] = {C_LEFT,C_RIGHT,C_ENTER,0};
    unsigned char xpos;

    do
    {
        do
        {
            VDC_Plot(1,menubarcoords[menubarchoice-1]-1,C_SPACE,VDC_WHITE+VDC_A_REVERSE+VDC_A_ALTCHAR);
            VDC_PrintAt(1,menubarcoords[menubarchoice-1],menubartitles[menubarchoice-1],VDC_WHITE+VDC_A_REVERSE+VDC_A_ALTCHAR);
            VDC_Plot(1,menubarcoords[menubarchoice-1]+strlen(menubartitles[menubarchoice-1]),C_SPACE,VDC_WHITE+VDC_A_REVERSE+VDC_A_ALTCHAR);

            key = getkey(validkeys,joyinterface);

            VDC_Plot(1,menubarcoords[menubarchoice-1]-1,C_SPACE,VDC_DGREEN+VDC_A_REVERSE+VDC_A_ALTCHAR);
            VDC_PrintAt(1,menubarcoords[menubarchoice-1],menubartitles[menubarchoice-1],VDC_DGREEN+VDC_A_REVERSE+VDC_A_ALTCHAR);
            VDC_Plot(1,menubarcoords[menubarchoice-1]+strlen(menubartitles[menubarchoice-1]),C_SPACE,VDC_DGREEN+VDC_A_REVERSE+VDC_A_ALTCHAR);
            
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
        menuoptionchoice = menupulldown(xpos,1,menubarchoice);
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
    cputsxy(10,10,"Are you sure?");
    choice = menupulldown(25,11,5);
    windowrestore();
    return choice;
}

/* Graphics and screen initialisation functions */

void graphicsinit()
{
    // Initialize VDC screen and load charsets

    VDC_Init();
    VDC_LoadCharset("ludo.chr1",0x0400,1,0);
    VDC_LoadCharset("ludo.chr2",0x0400,1,1);

    // Load main screen to memory
    VDC_LoadScreen("ludo.mscr",MAINSCREENADDRESS,1,0);
}

void loadmainscreen()
{
    /* Copy mainscreen to VDC screen memory */

    VDC_CopyMemToVDC(0,MAINSCREENADDRESS,1,4096);
    menuplacebar();
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

    unsigned char xpos, ypos, boardpos;

    xpos = pawncoord(playernumber, pawnnumber, 0);
    ypos = pawncoord(playernumber, pawnnumber, 1);
    boardpos = playerpos[playernumber][pawnnumber][1];
    if(playerpos[playernumber][pawnnumber][0]==0 && (boardpos==0 || boardpos==10 || boardpos==20 || boardpos==30 ))
    {
        /* Colored start fields */
        VDC_PlotString(ypos,xpos,startfieldgraphics[boardpos/10][0],4,playerdata[boardpos/10][2]+VDC_A_ALTCHAR);
        VDC_PlotString(ypos+1,xpos,startfieldgraphics[boardpos/10][1],4,playerdata[boardpos/10][2]+VDC_A_ALTCHAR);
    }
    else
    {
        if(playerpos[playernumber][pawnnumber][0]==0)
        {
            /* Normal white field main track */
            VDC_PlotString(ypos,xpos,fieldgraphics[0][0],4,VDC_WHITE+VDC_A_ALTCHAR);
            VDC_PlotString(ypos+1,xpos,fieldgraphics[0][1],4,VDC_WHITE+VDC_A_ALTCHAR);
        }
        else
        {
            /* Colored home or destination field */
            VDC_PlotString(ypos,xpos,fieldgraphics[1][0],4,playerdata[playernumber][2]+VDC_A_ALTCHAR);
            VDC_PlotString(ypos+1,xpos,fieldgraphics[1][1],4,playerdata[playernumber][2]+VDC_A_ALTCHAR);
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
    color = (selected)? VDC_WHITE : playerdata[playernumber][2];

    VDC_PlotString(ypos,xpos,pawngraphics[0],4,color+VDC_A_ALTCHAR);
    VDC_PlotString(ypos+1,xpos,pawngraphics[1],4,color+VDC_A_ALTCHAR);
}

void loadintro()
{
    /* Game intro */

    char validkeys[4] = {'m', 'M', C_ENTER, 0 };
    unsigned char key;

    /* Load and start first music file */

    /* Wait for ENTER of FIRE while player can toggle music */
    
    cputsxy(1,21,"Press ENTER/FIRE to start game.");
    cputsxy(1,22,"M=toggle music.");

    do
    {
        cputsxy(1,20,"Music: ");
        if(musicnumber) { cputs("Yes "); } else { cputs("No "); }
        key = getkey(validkeys,1);
        switch (key)
        {
        case 'm':
        case 'M':
            if(musicnumber)
            {
                //StopSong();
                //MUTE_SOUND();
                musicnumber = 0;
            }
            else{
                musicnumber = 1;
                //StartSong(musicmem,0);
            }
            break;
        
        default:
            break;
        }
    } while (key != C_ENTER);
}

void main()
{
    unsigned char x, choice;

    //Game intro
    graphicsinit();

    loadintro();

    //Ask for loading save game
    menumakeborder(40,8,6,35);
    cputsxy(42,10,"Load old game?");
    choice = menupulldown(69,11,5);
    windowrestore();
    //if(choice==1) { loadmainscreen(); loadgame(); }

    wait(10);

    if(endofgameflag==0) { loadmainscreen(); }

    for(choice=0;choice<4;choice++)
    {
        for(x=0;x<40;x++)
        {
            pawnerase(choice,0);
            playerpos[choice][0][0] = 0;
            playerpos[choice][0][1] = x;
            pawnplace(choice,0,0);
            wait(10);
        }
        for(x=0;x<8;x++)
        {
            pawnerase(choice,0);
            playerpos[choice][0][0] = 1;
            playerpos[choice][0][1] = x;
            pawnplace(choice,0,0);
            wait(10);
        }
    }

    //Main game loop
    //do
    //{
    //    if(endofgameflag>0)
    //    {
    //        endofgameflag = 0;
    //    }
    //    else
    //    {
    //        inputofnames();
    //    }
    //    do
    //    {
    //        cleararea(23,2,8,8);
    //        gotoxy(23,2);
    //        cprintf("Player %d", turnofplayernr+1);
    //        cputsxy(23,3,"Color");
    //        cputcxy(30,3,playerdata[turnofplayernr][2]);
    //        cputsxy(23,4,playername[turnofplayernr]);
//
    //        if(playerdata[turnofplayernr][0]==0)
    //        {
    //            turnhuman();
    //        }
    //        else
    //        {
    //            cputsxy(23,5,"Computer");
    //        }
    //        if(endofgameflag!=0) { break; }
    //        turngeneric();
//
    //        if(playerdata[turnofplayernr][1]==0) { playerwins(); }
    //        do
    //        {
    //            if(zv==1)
    //            {
    //                zv=0;
    //            }
    //            else
    //            {
    //                np[turnofplayernr]=-1;
    //                turnofplayernr++;
    //                if(turnofplayernr>3) { turnofplayernr=0; }
    //            }
    //        } while (zv==0 && playerdata[turnofplayernr][1]==0);
    //    } while (endofgameflag==0);
    //} while (endofgameflag!=1); 

    VDC_Exit();
    cputsxy(0,0,"Thanks for playing, goodbye.");
    //StopSong();
    //MUTE_SOUND();
}