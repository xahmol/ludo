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
#include <joystick.h>
#include "vdc_core.h"
#include "sidplay.h"
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
char dicegraphics[6][3][4] = {
    {{160,160,160, 97} , {160,252,160, 97} , {226,226,226,126}},
    {{236,160,160, 97} , {160,160,236, 97} , {226,226,226,126}},
    {{236,160,160, 97} , {160,252,236, 97} , {226,226,226,126}},
    {{236,160,236, 97} , {236,160,236, 97} , {226,226,226,126}},
    {{236,160,236, 97} , {236,252,236, 97} , {226,226,226,126}},
    {{236,236,236, 97} , {236,236,236, 97} , {226,226,226,126}}
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
unsigned char joyinterface = 0;
unsigned char autosavetoggle = 1;

//Save game and config file memory allocation and variables
unsigned char saveslots[85];
unsigned char savegamemem[136];

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

    unsigned char key, joy1, joy2;

    do
    {
        key = 0;
        if(joyinterface && joyallowed)
        {
            joy1 = joy_read(JOY_1);
            joy2 = joy_read(JOY_2);
            if(joy1&JOY_BTN_1_MASK) { key = C_ENTER; }
            if(joy1&JOY_RIGHT_MASK) { key = C_RIGHT; }
            if(joy1&JOY_LEFT_MASK) { key = C_LEFT; }
            if(joy1&JOY_DOWN_MASK) { key = C_DOWN; }
            if(joy1&JOY_UP_MASK) { key = C_UP; }
            if(joy2&JOY_BTN_1_MASK) { key = C_ENTER; }
            if(joy2&JOY_RIGHT_MASK) { key = C_RIGHT; }
            if(joy2&JOY_LEFT_MASK) { key = C_LEFT; }
            if(joy2&JOY_DOWN_MASK) { key = C_DOWN; }
            if(joy2&JOY_UP_MASK) { key = C_UP; }
            if(key){
                do
                {
                    wait(10);
                    joy1 = joy_read(JOY_1);
                    joy2 = joy_read(JOY_2);
                } while (joy1 || joy2);
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
    POKE(208,0);    // Clear keyboard buffer
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
    VDC_Plot(ypos,xpos+idx,C_SPACE,VDC_WHITE+VDC_A_REVERSE+VDC_A_ALTCHAR);
  
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
 
    windowsave(ypos, height+4);

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

void fileerrormessage(unsigned char error)
{
    /* Show message for file error encountered */

    menumakeborder(8,8,6,30);
    cputsxy(10,10,"File error!");
    if(error<255)
    {
        gotoxy(10,12);
        cprintf("Error nr.: %2X",error);
    }
    cputsxy(10,12,"Press key.");
    getkey("",1);
    windowrestore();    
}

/* Config file and save functions */

void saveconfigfile()
{
    // Function to save config file

    char filename[] = "ludo.cfg";
    unsigned char error;

    // Remove old file
    remove(filename);

    // Set device ID
	cbm_k_setlfs(0, getcurrentdevice(), 0);

    // Set filename
	cbm_k_setnam(filename);

    // Set bank to 0
    SetLoadSaveBank(0);

    // Save saveslots memory
	error = cbm_k_save((unsigned int)saveslots, (unsigned int)saveslots+85);

    if (error) { fileerrormessage(error); }
}

void loadconfigfile()
{
    // Load configuration file or create one if not present

    char filename[] = "ludo.cfg";
    unsigned int length;
    unsigned char x,y;

    // Set device ID
	cbm_k_setlfs(0, getcurrentdevice(), 0);

	// Set filename
	cbm_k_setnam(filename);

	// Set bank to 0
	SetLoadSaveBank(0);
	
	// Load config from file to memory
	length = cbm_k_load(0,(unsigned int)saveslots);

    if (length>(unsigned int)saveslots) {
        for(y=0;y<5;y++)
        {
            for(x=0;x<16;x++)
            {
                pulldownmenutitles[7][y][x]=saveslots[(y*16)+5+x];
            }
        }
    }
    else
    {
        memset(saveslots,0,85);
        for(y=0;y<5;y++)
        {
            for(x=0;x<16;x++)
            {
                saveslots[(y*16)+5+x]=pulldownmenutitles[7][y][x];
            }
        }
        saveconfigfile();
    }
}

/* Graphics and screen initialisation functions */

void graphicsinit()
{
    // Initialize VDC screen and load charsets
    VDC_Init();
    printcentered("Loading...",0,10,80);
    VDC_LoadCharset("ludo.chr1",LOADSAVEBUFFER,1,0);
    VDC_LoadCharset("ludo.chr2",LOADSAVEBUFFER,1,1);
}

void loadmainscreen()
{
    /* Copy mainscreen to VDC screen memory */

    VDC_CopyMemToVDC(0,MAINSCREENADDRESS,1,4096);
    menuplacebar();
}

/* Game routines */

unsigned char dicethrow()
{
    /* Throw the dice. Returns the dice value */

    unsigned char dicethrow, x;

    menumakeborder(60,12,6,8);
    for(x=0;x<10;x++)
    {
        dicethrow = rand()%6+1;
        VDC_PlotString(14,62,dicegraphics[dicethrow-1][0],4,VDC_WHITE+VDC_A_ALTCHAR);
        VDC_PlotString(15,62,dicegraphics[dicethrow-1][1],4,VDC_WHITE+VDC_A_ALTCHAR);
        VDC_PlotString(16,62,dicegraphics[dicethrow-1][2],4,VDC_WHITE+VDC_A_ALTCHAR);
        wait(5);
    }
    cputsxy(62,17,"Key.");
    getkey("",1);
    windowrestore();
    return dicethrow;
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

void savegame(unsigned char autosave)
{
    /* Save game to a gameslot
       Input: autosave is 1 for autosave, else 0 */

    char fname[25] = "ludo.sav";
    unsigned char slot = 0;
    unsigned char x, y, len, ferr;
    unsigned char yesno = 1;

    len = strlen(fname);

    if(autosave==1)
    {
        fname[len]=48;
        fname[len+1]=0;
    }
    else
    {
        menumakeborder(5,5,12,30);
        cputsxy(7,7,"Save game.");
        cputsxy(7,8,"Choose slot:");
        do
        {
            slot = menupulldown(14,10,8) - 1;
        } while (slot<1);
        if(saveslots[slot]==1)
        {
            cputsxy(7,8,"Slot not empty. Sure?");
            yesno = menupulldown(18,10,5);
        }
        if(yesno==1)
        {
            cputsxy(7,8,"Choose name of save. ");
            if(saveslots[slot]==0) { memset(pulldownmenutitles[7][slot],0,15); }
            input(7,9,pulldownmenutitles[7][slot],15);
            for(x=strlen(pulldownmenutitles[7][slot]);x<15;x++)
            {
                pulldownmenutitles[7][slot][x] = C_SPACE;
            }
            pulldownmenutitles[7][slot][15] = 0;
            fname[len]=48+slot;
            fname[len+1]=0;
            for(x=0;x<16;x++)
            {
                saveslots[(slot*16)+5+x]=pulldownmenutitles[7][slot][x];
            }
        }
        windowrestore();
    }
    if(yesno==1)
    {
        saveslots[slot]=1;
        saveconfigfile();
        savegamemem[0]=turnofplayernr;
        for(x=0;x<4;x++)
        {
            savegamemem[x+1] = np[x];
        }
        for(x=0;x<4;x++)
        {
            for(y=0;y<4;y++)
            {
                savegamemem[5+(x*4)+y]=playerdata[x][y];
            }
        }
        for(x=0;x<4;x++)
        {
            for(y=0;y<4;y++)
            {
                savegamemem[21+(x*8)+(y*2)]=playerpos[x][y][0];
                savegamemem[22+(x*8)+(y*2)]=playerpos[x][y][1];
            }
        }
        for(x=0;x<4;x++)
        {
            for(y=0;y<21;y++)
            {
                savegamemem[53+(x*21)+y]=playername[x][y];
            }
        }

         // Remove old file
        remove(fname);

        // Set device ID
	    cbm_k_setlfs(0, getcurrentdevice(), 0);

        // Set filename
	    cbm_k_setnam(fname);

        // Set bank to 0
        SetLoadSaveBank(0);

        // Save saveslots
	    ferr = cbm_k_save((unsigned int)savegamemem, (unsigned int)savegamemem+136);

        if (ferr) { fileerrormessage(ferr); }
    }
}

void loadgame()
{
     /* Load game from a gameslot */
    
    char fname[25] = "ludo.sav";
    unsigned char slot, x, y, len;
    unsigned char yesno = 1;
    unsigned int length;
    
    len = strlen(fname);
    
    menumakeborder(5,5,12,30);
    cputsxy(7,7,"Load game.");
    cputsxy(7,9,"Choose slot:");
    slot = menupulldown(14,10,8) - 1;
    if(saveslots[slot]==0)
    {
        cputsxy(7,9,"Slot empty. ");
        cputsxy(7,10,"Press key.");
        getkey("",1);
    }
    windowrestore();
    if(saveslots[slot]==1)
    {
        fname[len]=48+slot;
        fname[len+1]=0;

        // Set device ID
	    cbm_k_setlfs(0, getcurrentdevice(), 0);

	    // Set filename
	    cbm_k_setnam(fname);

	    // Set bank to 0
	    SetLoadSaveBank(0);
	
	    // Load config from file to memory
	    length = cbm_k_load(0,(unsigned int)savegamemem);

        if (length <= (unsigned int)savegamemem) { fileerrormessage(255); return; }

        turnofplayernr=savegamemem[0];
        for(x=0;x<4;x++)
        {
            np[x]=savegamemem[1+x];
        }
        for(x=0;x<4;x++)
        {
            for(y=0;y<4;y++)
            {
                playerdata[x][y]=savegamemem[5+(x*4)+y];
            }
        }
        for(x=0;x<4;x++)
        {
            for(y=0;y<4;y++)
            {
                pawnerase(x,y);
                playerpos[x][y][0]=savegamemem[21+(x*8)+(y*2)];
                playerpos[x][y][1]=savegamemem[22+(x*8)+(y*2)];
                pawnplace(x,y,0);
            }
        }
        for(x=0;x<4;x++)
        {
            for(y=0;y<21;y++)
            {
                playername[x][y]=savegamemem[53+(x*21)+y];
            }
        }
        endofgameflag = 2;
    }
}

void inputofnames()
{
    /* Enter player nanes */
    unsigned char x, choice;

    menumakeborder(30,8,6,45);
    for(x=0;x<4;x++)
    {
        gotoxy(32,10);
        cputs("Computer plays player ");
        textcolor(COLOR_CYAN);
        cprintf("%d",x+1);
        textcolor(COLOR_YELLOW);
        cputs("?");
        choice = menupulldown(69,11,5);
        if(choice==1)
        {
            playerdata[x][0]=1;
        }
        else
        {
            playerdata[x][0]=0;
        }
        gotoxy(32,10);
        cprintf("Input name player ");
        textcolor(COLOR_CYAN);
        cprintf("%d",x+1);
        textcolor(COLOR_YELLOW);
        cputs(":    ");
        input(32,12,playername[x],20);
    }
    windowrestore();
}

void musicnext()
{
    /* Funtion to load and start next music track */

    char fname[25]="ludo.mus";
    unsigned char len = strlen(fname);

    StopMusic();
    if(++musicnumber>3) { musicnumber = 1;}
    fname[len]=48+musicnumber;
    fname[len+1]=0;
    LoadMusic(fname);
}

void informationcredits()
{
    /* Print version information and credits */

    char version[30];
    sprintf(version,
            "Version: v%i%i - %c%c%c%c%c%c%c%c-%c%c%c%c",
            VERSION_MAJOR, VERSION_MINOR,
            BUILD_YEAR_CH0, BUILD_YEAR_CH1, BUILD_YEAR_CH2, BUILD_YEAR_CH3, BUILD_MONTH_CH0, BUILD_MONTH_CH1, BUILD_DAY_CH0, BUILD_DAY_CH1,BUILD_HOUR_CH0, BUILD_HOUR_CH1, BUILD_MIN_CH0, BUILD_MIN_CH1);
    menumakeborder(5,5,14,70);
    textcolor(COLOR_CYAN);
    printcentered("L U D O",7,7,70);
    textcolor(COLOR_WHITE);
    printcentered(version,7,8,70);
    textcolor(COLOR_YELLOW);
    printcentered("Written in 2021 by Xander Mol",7,10,70);
    printcentered("Converted to C from the C128 original written in BASIC in 1992",7,11,70);
    printcentered("See source code on Github for full code credits.",7,13,70);
    printcentered("Music credits:",7,15,70);
    textcolor(COLOR_GREEN);
    printcentered("Press a key.",7,18,70);
    textcolor(COLOR_YELLOW);
    getkey("",1);
    windowrestore();
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
                musicnumber=0;
                break;

            case 33:
                if(musicnumber)
                { 
                    StopMusic();
                }
                else
                {
                    musicnumber=1;
                }
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

unsigned char humanchoosepawn(unsigned char playernumber, unsigned char possible[4])
{
    /* Human has to choose a pawn, returns pawnnumber chosen */

    signed char pawnnumber = 0;
    signed char direction;
    unsigned char key;
    char validkeys[5] = { C_LEFT, C_RIGHT, C_UP, C_DOWN, C_ENTER };

    menumakeborder(60,10,5,18);
    cputsxy(62,12,"Which pawn?");
    gotoxy(62,14);
    cputs("Dice thow = ");
    textcolor(COLOR_GREEN);
    cprintf("%d", throw);
    textcolor(COLOR_YELLOW);
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

    menumakeborder(35,8,10,40);
    gotoxy(37,10);
    textcolor(COLOR_GREEN);
    cprintf("%s", playername[turnofplayernr]);
    textcolor(COLOR_YELLOW);
    cputs(" has won!");

    cputsxy(37,12,"Your choice?");
    do
    {
        choice = menupulldown(59,13,7);
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
            cputsxy(60,8,"Throw 3x");
        }
    }
    for(x=0;x<dicethrows;x++)
    {
        throw = dicethrow();
        if(throw==6) { break; }
    }
    cputsxy(60,8,"        ");
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
                            if(x!=y && playerpos[turnofplayernr][y][0]==1 && playerpos[turnofplayernr][y][1]<=vn && playerpos[turnofplayernr][y][1]>3)
                            {
                                gv=1;
                                y=3;
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
        cputsxy(60,8,"No move possible.");
        cputsxy(60,9,"Press key.");
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
    if(playerdata[turnofplayernr][0]==0 && autosavetoggle==1)
    {
        savegame(1); /* Autosave on end human turn */
    }
    else
    {
        cputsxy(60,8,"Press key.");
        getkey("",1);
    }
}

void loadintro()
{
    unsigned char error;

    /* Game intro */

    char validkeys[4] = {'m', 'M', C_ENTER, 0 };
    unsigned char key;

    /* Title screen */
    VDC_LoadScreen("ludo.tscr",LOADSAVEBUFFER,1,1);

    /* Load and read game config file */
    loadconfigfile();

    // Load main screen to memory
    VDC_LoadScreen("ludo.mscr",MAINSCREENADDRESS,1,0);

    // Imstall joystick driver
    error = joy_install(&joy_static_stddrv);
    if(error == JOY_ERR_OK)
    {
        joyinterface = 1;
    }
    else
    {
        cputsxy(0,24,"Joystick driver unavailable.");
    }

    /* Load and start first music file */
    LoadMusic("ludo.mus1");

    /* Wait for ENTER of FIRE while player can toggle music */ 
    cputsxy(65,20,"M=toggle music.");
    printcentered("Press ENTER or FIRE to start game.",0,22,80);

    do
    {
        cputsxy(0,20,"Music: ");
        if(musicnumber) { cputs("Yes "); } else { cputs("No "); }
        key = getkey(validkeys,1);
        switch (key)
        {
        case 'm':
        case 'M':
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

void main()
{
    unsigned char choice;

    //Game intro
    graphicsinit();

    loadintro();

    //Ask for loading save game
    menumakeborder(40,8,6,35);
    cputsxy(42,10,"Load old game?");
    choice = menupulldown(69,11,5);
    windowrestore();
    if(choice==1) { loadmainscreen(); loadgame(); }

    srand(clock());

    if(endofgameflag==0) { loadmainscreen(); }

    // Main game loop
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
            VDC_FillArea(3,60,C_SPACE,20,10,VDC_LYELLOW);
            gotoxy(60,3);
            cputs("Player ");
            textcolor(COLOR_CYAN);
            cprintf("%u", turnofplayernr+1);
            textcolor(COLOR_YELLOW);
            cputs(":");
            VDC_Plot(3,70,C_SPACE,playerdata[turnofplayernr][2]+VDC_A_REVERSE);
            VDC_Plot(3,71,C_SPACE,playerdata[turnofplayernr][2]+VDC_A_REVERSE);
            textcolor(COLOR_GREEN);
            cputsxy(60,4,playername[turnofplayernr]);
            textcolor(COLOR_YELLOW);

            if(playerdata[turnofplayernr][0]==0)
            {
                turnhuman();
            }
            else
            {
               cputsxy(60,6,"Computer plays.");
            }
            if(endofgameflag!=0) { break; }
            turngeneric();

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

    if(musicnumber) { StopMusic(); }

    VDC_Exit();
    joy_uninstall();
    cputsxy(0,0,"Thanks for playing, goodbye.");
    //StopSong();
    //MUTE_SOUND();
}