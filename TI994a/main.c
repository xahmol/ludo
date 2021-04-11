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

/* Includes */
#include <system.h>
#include <files.h>
#include <conio.h>
#include <kscan.h>
#include <string.h>
#include <vdp.h>
#include <TISNPlay.h>
#include <sound.h>
#include "speech.h"
#include "defines.h"

/* Variables */

/* Speech */
const char speech_intro[] = {0xC4,0x35,0x2F,0x34,0xAD,0xA9,0xBB,0x54,0x4D,0x57,0x97,0x14,0x12,0x32,0x95,0x53,0x8C,0x3D,0x70,0x4A,0x55,0x75,0x77,0x88,0xA0,0x29,0x95,0xC5,0x2D,0xC9,0x8C,0xA6,0x54,0x14,0xCD,0xC2,0x10,0x1A,0x32,0x9E,0xAC,0x06,0x5D,0xB2,0xC9,0x48,0x8C,0x78,0x54,0xDA,0xA8,0x06,0x3D,0xB2,0xC1,0xA4,0x20,0x1B,0x98,0xCE,0x70,0xA3,0x6C,0x82,0x42,0xC3,0xC5,0xC4,0xB2,0x0A,0x0A,0x4B,0x67,0x17,0x37,0xCC,0x83,0x2A,0x2D,0xCC,0x93,0x98,0x88,0xA4,0xD4,0x70,0xB5,0x1C,0x32,0xDA,0xB4,0x52,0xCC,0x68,0xCA,0x79,0xD3,0x4A,0x36,0xA1,0xA9,0x60,0x4D,0xCB,0xD9,0x85,0xBA,0x12,0xB5,0x68,0xD5,0xB0,0x62,0x4A,0x54,0xE2,0x50,0x23,0xA5,0xAA,0x60,0x8B,0x43,0xCE,0x58,0xA2,0x41,0x35,0x4B,0x49,0x12,0x05,0x25,0xA9,0x28,0x63,0xB3,0x6B,0x80,0x29,0x3C,0xC2,0xC6,0x7C,0x64,0x59,0x92,0x09,0x35,0xC9,0x19,0x25,0x0E,0x4C,0xD5,0xB0,0xE7,0x08,0x8C,0x12,0x53,0xC2,0x16,0x8F,0x92,0x2A,0x54,0x81,0x4A,0x3C,0x49,0x68,0x20,0x25,0xBC,0x99,0x06,0x87,0x00,0x10,0x68,0x9D,0xF9,0x72,0xD1,0x36,0xB5,0x0A,0xDE,0x4B,0x09,0x25,0xA4,0xCA,0x5B,0xB5,0x24,0xE4,0x92,0x1A,0x47,0x53,0x5E,0xB0,0x4B,0xAA,0x1C,0x5F,0x7B,0x40,0x2E,0x89,0xB0,0x3A,0x6F,0x06,0x39,0x25,0xCC,0x7B,0xBD,0x28,0x68,0x93,0xE2,0x10,0xB5,0xE2,0xA0,0x90,0x06,0xDA,0xDA,0x80,0x22,0x02,0xE2,0x49,0x9D,0x96,0x1A,0xB2,0xD2,0x42,0x93,0x4D,0x99,0x8A,0x2E,0x3B,0x8B,0x3A,0xAD,0x4A,0xA9,0x14,0x22,0x48,0x1D,0x07,0x65,0x57,0x50,0xE7,0xF6,0xEC,0x64,0x58,0x0F,0xE5,0x78,0x25,0xD1,0x56,0x4E,0x00,0x66,0xA2,0x69,0x47,0x01,0x93,0x9A,0x22,0xBF,0x32,0x95,0x64,0xB7,0x63,0xE6,0xAA,0xBD,0x5D,0xC5,0x49,0xCA,0xAD,0xEA,0x34,0x76,0xC7,0xA9,0xE2,0x23,0xC8,0xAC,0x22,0x98,0x1A,0x2F,0xE3,0xF0,0xB4,0x20,0x3A,0x10,0x27,0x24,0xC2,0x91,0x32,0x39,0xD3,0x16,0xD7,0xAC,0xC6,0x91,0xC2,0x13,0x59,0xBC,0x21,0x0F,0xBC,0x11,0xD7,0xA2,0x81,0x7C,0x10,0xD6,0x42,0xD3,0xB3,0xB0,0x75,0x1C,0x25,0xE5,0xCA,0x2A,0xA1,0x2F,0xC8,0xC2,0x43,0x9A,0x92,0x3C,0x23,0x2D,0x0B,0xA0,0x2A,0xF2,0x59,0xC5,0xD3,0x90,0xA9,0xF1,0x37,0xC7,0x08,0x89,0xA6,0x46,0x57,0x8D,0xBC,0x6D,0x9A,0x1A,0x2D,0x73,0xF4,0x4A,0xE4,0x6A,0x3C,0x3C,0x40,0xCB,0x95,0x69,0xE0,0xF0,0x24,0xEE,0x4A,0xA4,0x01,0x33,0x5D,0x21,0x62,0xA1,0x16,0xF5,0xE1,0x80,0xB2,0x05,0x40,0x34,0xE3,0xC2,0x54,0x4C,0xB5,0x29,0x70,0x89,0x08,0x77,0x0A,0xA1,0xA6,0x36,0x3A,0x42,0x45,0x87,0x86,0x98,0xE8,0x0A,0x25,0xE5,0x5A,0x2A,0x3B,0xBB,0x55,0x90,0x71,0x2D,0x30,0xB7,0x1E,0x0B,0x0E,0xE8,0x38,0x38,0xD4,0x5C,0xA7,0xB5,0xBB,0xE0,0x52,0xD3,0xE4,0x95,0xE6,0x50,0x4A,0xCD,0x93,0x46,0x69,0x40,0x2E,0x0D,0x4F,0xE6,0xCD,0x01,0x39,0x35,0xB4,0xB8,0x0D,0x04,0x34,0xD7,0xA0,0x92,0x19,0x30,0xAC,0x4D,0x03,0x5B,0x2C,0xAA,0x3B,0x30,0x0D,0xCC,0xF1,0x60,0xEE,0xC2,0x34,0x48,0x6D,0x24,0xB2,0x1B,0x65,0x26,0xA0,0x1D,0xA6,0x4A,0x0C,0x70,0x28,0x9B,0x01,0xAE,0x36,0x37,0xC0,0xD5,0x96,0x06,0x38,0xD6,0x52,0x00,0x5D,0x44,0xA2,0xDD,0xF3,0x76,0x31,0x95,0x05,0x00,0x00,0x00,0x00,0x00,0x00,0x80,0x72,0x1A,0xC2,0x8A,0xC7,0x22,0xAB,0xC0,0xCE,0x4C,0x4A,0x92,0xAA,0x04,0x2D,0xA2,0xB5,0x05,0x9A,0x12,0x8C,0x8C,0xB6,0x14,0x11,0x72,0x5C,0xB3,0x92,0x52,0x52,0x4A,0x71,0xAF,0x70,0x4A,0x43,0x29,0xC5,0x23,0x4B,0xCD,0x23,0x84,0x14,0xAF,0x68,0xAA,0x08,0x60,0x52,0xDC,0xAD,0x69,0x9B,0xA4,0x29,0x49,0xF4,0x61,0x2F,0x93,0xA9,0xA2,0x25,0x5B,0xC2,0x43,0xA4,0x9A,0xD6,0x34,0x4D,0x33,0x91,0x3A,0xDE,0x5D,0x34,0xC5,0x60,0xEA,0xC4,0x32,0x37,0x73,0x13,0xA1,0xE7,0x4B,0xCD,0x2C,0x04,0x98,0x9E,0x6D,0x31,0xB5,0x12,0xA8,0x06,0xB6,0x51,0x43,0x87,0x00,0x1B,0xD0,0x43,0xF5,0x08,0x81,0x68,0x04,0x0F,0x3C,0xD3,0x08,0x03,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xA2,0x8D,0x2C,0x29,0x4A,0x56,0x6E,0x73,0x49,0xBC,0x78,0x6C,0xB9,0x54,0x26,0xAD,0xE2,0x22,0x9D,0x2A,0x9E,0xB5,0x53,0x8D,0x74,0xAA,0x69,0xB6,0x4A,0x13,0xC1,0xAE,0x86,0xA9,0x2A,0x59,0x49,0xB3,0x16,0xB4,0x1E,0x07,0xA5,0x8D,0x5C,0xD0,0x9E,0x0B,0x1C,0xB1,0xB1,0xAD,0x54,0x75,0x51,0xC9,0x49,0xF6,0xCA,0x3C,0xCD,0xEC,0x84,0x82,0x7B,0xD9,0x15,0x85,0x9C,0x4A,0xEA,0x75,0x1A,0x1D,0x76,0xAA,0x58,0xD4,0x4D,0x72,0x38,0xA9,0x62,0xD1,0xA6,0xC0,0xE1,0xA6,0x82,0x05,0xDB,0x06,0x63,0x96,0x0A,0x9A,0xF4,0x1C,0x5D,0x4E,0xC8,0x71,0xB5,0xC3,0x68,0x87,0xAE,0xC0,0x53,0x1B,0x7B,0x14,0x98,0x02,0x6D,0x2D,0xCE,0xA3,0x21,0x2A,0xF0,0x24,0xCC,0x86,0x14,0x6B,0xC1,0x35,0x4D,0x4B,0x8B,0xA1,0x12,0x5B,0xDC,0xB5,0x8C,0x94,0x5A,0x0E,0x17,0x67,0x0F,0x9C,0x1A,0xD9,0x92,0x43,0x25,0x70,0x6A,0x44,0x97,0x72,0x0E,0x62,0xA9,0x11,0x59,0x33,0x29,0x89,0x86,0x96,0x04,0xCF,0x05,0x93,0x22,0x5A,0x50,0xDA,0x87,0x58,0x0E,0x72,0x41,0xAE,0x48,0x15,0x46,0xC1,0xAB,0x26,0x1D,0x5D,0x1D,0x07,0xA0,0xFB,0xAA,0x04,0x4C,0x1F,0x15,0xF0,0x6A,0xC2,0x59,0xD9,0x65,0xC8,0xF8,0xB0,0x30,0x2E,0xA3,0x21,0xE7,0x5B,0xC5,0x25,0x83,0x9A,0x92,0x3E,0xD2,0xD4,0x14,0x22,0x0A,0xF8,0xC2,0x95,0xCB,0x94,0x2A,0xE0,0xD3,0xE4,0x4A,0x4B,0xA6,0x80,0x57,0x43,0xA2,0x6D,0x86,0x02,0xCD,0x14,0xD7,0xA8,0x98,0x0A,0xBE,0x55,0xDD,0x3C,0x50,0x28,0xD9,0x15,0x37,0x73,0xC3,0xAE,0xA4,0x47,0x5C,0xB4,0x02,0xBB,0x0A,0x2F,0x53,0xD5,0x18,0xED,0x2A,0xBC,0x55,0xD4,0xB3,0xB4,0xAB,0xD0,0x0A,0x11,0xF7,0x4A,0xAE,0x26,0x3B,0x99,0x52,0x43,0x9A,0x86,0xDC,0x40,0x1A,0x0D,0x69,0x5A,0xBC,0x13,0xA9,0xDC,0x81,0xEA,0xD0,0x29,0x90,0x76,0x8A,0xAC,0x47,0x67,0x80,0xC6,0x48,0xB1,0x01,0xBD,0x46,0x52,0xB7,0x4C,0x46,0xF0,0x0A,0xD9,0xC2,0x32,0x8A,0x40,0x58,0x65,0x0F,0x55,0x68,0x06,0xBE,0xC4,0xD9,0x1D,0x02};
const unsigned int speech_playercolor[4] = { 0x321d, 0x57c1, 0x1b8a, 0x7cf8 };
const unsigned char speech_ohoh[] = {0x60,0x3C,0x39,0x9A,0x32,0x4D,0x4A,0xF0,0x64,0x3D,0xB5,0x66,0xDB,0xC1,0x15,0xB3,0x39,0x86,0x15,0x39,0x5B,0xEC,0x21,0x1F,0x76,0x68,0x6C,0x71,0x9A,0x72,0xCD,0x21,0x29,0xC4,0x1B,0xF1,0x57,0x8B,0x00,0x22,0x14,0xFD,0x58,0xD7,0x65,0xB8,0x98,0xAF,0x13,0x2D,0xB3,0xE1,0x62,0x36,0x5F,0x35,0xD5,0x41,0x88,0xD9,0x7A,0xB1,0x50,0x1B,0x21,0x66,0xE7,0xD8,0x53,0x6D,0xB8,0x85,0xBD,0xE6,0x74,0x0B,0xE1,0x62,0xF6,0x9A,0x23,0x34,0x80,0x89,0xE9,0x0F,0x2E,0x73,0x83,0x2A,0xA6,0xDF,0x29,0x5D,0x05,0x89,0x98,0xFE,0x60,0xE3,0x08,0x28,0x12,0xFA,0x93,0x8D,0x33,0x00,0x4A,0xF0,0x57,0x76,0x6B,0xC3};

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

//Pawn position co-ords main field
unsigned char fieldcoords[40][2] = {
     { 0,10}, { 2,10}, { 4,10}, { 6,10}, { 8,10},
     { 8, 8}, { 8, 6}, { 8, 4}, { 8, 2}, {10, 2},
     {12, 2}, {12, 4}, {12, 6}, {12, 8}, {12,10},
     {14,10}, {16,10}, {18,10}, {20,10}, {20,12},
     {20,14}, {18,14}, {16,14}, {14,14}, {12,14},
     {12,16}, {12,18}, {12,20}, {12,22}, {10,22},
     { 8,22}, { 8,20}, { 8,18}, { 8,16}, { 8,14},
     { 6,14}, { 4,14}, { 2,14}, { 0,14}, { 0,12}
};
//Pawn posiiion co-ords start and destination
unsigned char homedestcoords[4][8][2] = {
    {{ 0, 2}, { 2, 2}, { 0, 4}, { 2, 4}, { 2,12}, { 4,12}, { 6,12}, { 8,12}},
    {{18, 2}, {20, 2}, {18, 4}, {20, 4}, {10, 4}, {10, 6}, {10, 8}, {10,10}},
    {{18,20}, {20,20}, {18,22}, {20,22}, {18,12}, {16,12}, {14,12}, {12,12}},
    {{ 0,20}, { 2,20}, { 0,22}, { 2,22}, {10,20}, {10,18}, {10,16}, {10,14}}
};
/* Player data:
    [players 0-3]
    [position 0: human = 0 or computer = 1
     position 1: number of pawns not at destination
     position 2: player color
     position 3: number of pawns at home              */
unsigned char playerdata[4][4] = {
    {0,4,C_GINVSPACE,4},
    {0,4,C_RINVSPACE,4},
    {0,4,C_BINVSPACE,4},
    {0,4,C_YINVSPACE,4}
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
unsigned char playername[4][9] = { "","","","" };

signed char np[4] = { -1, -1, -1, -1};
unsigned char dp[4] = { 8, 8, 8, 8 };

//Dice graphics string data
unsigned char dicegraphics[6][4] = {
    {C_DICE01,C_DICE02,C_DICE03,C_DICE04},
    {C_DICE05,C_DICE06,C_DICE07,C_DICE05},
    {C_DICE01,C_DICE08,C_DICE09,C_DICE04},
    {C_DICE10,C_DICE06,C_DICE07,C_DICE11},
    {C_DICE12,C_DICE08,C_DICE09,C_DICE13},
    {C_DICE14,C_DICE15,C_DICE16,C_DICE17}
};

//Game variables
unsigned char endofgameflag = 0;
unsigned char turnofplayernr = 0;
unsigned char zv = 0;
unsigned char ns = 0;
unsigned char throw;
unsigned char musicnumber = 1;
unsigned char joyinterface = 1;
unsigned char autosavetoggle = 1;

//Save game and config file memory allocation and variables
unsigned char dsrpath[15];
unsigned char saveslots[85];
unsigned char savegamemem[136];

//Music memory allocation
unsigned char musicmem[3200];

//Graphics memory allocation
unsigned char mainscreen[768];

/* Functions not present in LIBTI99 */
unsigned char* strcat(unsigned char *dest, unsigned const char *src)
{
    /*  Append SRC on the end of DEST.
        Source: https://code.woboq.org/userspace/glibc/string/strcat.c.html */

    strcpy (dest + strlen (dest), src);
    return dest;
}

unsigned char* strchr(unsigned register const char *s, unsigned int c)
{
    /*  eturns a pointer to the first occurrence of the character @var{c} in
        the string @var{s}, or @code{NULL} if not found.  If @var{c} is itself the
        null character, the results are undefined.
        Source: https://code.woboq.org/gcc/libiberty/strchr.c.html */

    do {
      if (*s == c)
        {
          return (char*)s;
        }
    } while (*s++);
    return (0);
}

static unsigned int random(void)
{
    /*  Retun random number
        Source from: https://github.com/peberlein/turmoil */

	static unsigned int seed = 0xaaaa;
	static const unsigned int random_mask = 0xb400;

	__asm__(
		"srl %0,1  \n\t"
		"jnc 1f    \n\t"
		"xor %2,%0 \n\t"
		"1:        \n\t"
		: "=r"(seed)
		: "0"(seed),"m"(random_mask)
	);
	return seed;
}

void wait(unsigned int jiffies)
{
    /* Function to wait for the specified number of cycles
       Input: wait_cycles = numnber of cycles to wait       
       Source: https://github.com/jedimatt42/tipi/tree/master/clients/tipicfg */

    for(int i=0; i < jiffies; i++) {
        VDP_WAIT_VBLANK_CRU;
        if(musicnumber)
        {
            CALL_PLAYER_SN;
            if (!isSNPlaying) { StartSong(musicmem,0); }
        }
    }
}

/*  File management functions */

void getconfigfilepath()
{
    /*  Get the proper path for the config file.
        Uses boot tracking to support DSKx, falls back to DSK1 if something else
        is detected.
        Output is in dsrpath variable               */

    unsigned char dsrname[6] = { 0,0,0,0,'.',0 };
    unsigned char x;
    unsigned int crubase;
    unsigned int romaddress;
    unsigned char fname[25];

    crubase = deek(0x83d0);
    romaddress = deek(0x83d2);
    romaddress += 5;

    CRU_ENABLE(crubase);

    for(x=0;x<4;x++)
    {
        dsrname[x] = peek(romaddress+x);
    }

    CRU_DISABLE(crubase);

    // Detects if DSR name starts with DSK, otherwise fall back to DSK1
    if(dsrname[0] != 'D' || dsrname[1] != 'S' || dsrname[2] != 'K')
    {
        strcpy(dsrname,"DSK1.");
    }

    strcpy(dsrpath,dsrname);
    strcpy(fname,dsrpath);
    strcat(fname,"LUDOCFG");
}

unsigned char dsr_load(unsigned char* filename, unsigned char* dest, unsigned int numbytes)
{
    /*  Load file.
        Inspired by Jedimatt42 and Tursi
        Source: https://atariage.com/forums/topic/164295-gcc-for-the-ti/page/25/?tab=comments#comment-4786953 */

    struct PAB pab;
    unsigned char ferr;

    // not relavent, but lets initialize all the bits
    pab.ScreenOffset = 0; 
    pab.Status = 0;
    pab.RecordLength = 0;
    pab.CharCount = 0;
    // the stuff that matters...
    pab.OpCode = DSR_LOAD; // DSR_LOAD for LOAD
    pab.VDPBuffer = FBUF; // where in VDP you want to load (or save from)
    pab.RecordNumber = numbytes; // size to load since we aren't using records
    pab.NameLength = strlen(filename);
    pab.pName = filename;
 
    ferr = dsrlnk(&pab, VPAB);
    if(!ferr) { vdpmemread(FBUF, dest, numbytes); }
    return ferr;
}

unsigned char dsr_save(unsigned char* filename, unsigned char* source, unsigned int numbytes)
{
    /*  Save file.
        Inspired by Jedimatt42 and Tursi
        Source: https://atariage.com/forums/topic/164295-gcc-for-the-ti/page/25/?tab=comments#comment-4786953 */

    struct PAB pab;

    // not relavent, but lets initialize all the bits
    pab.ScreenOffset = 0; 
    pab.Status = 0;
    pab.RecordLength = 0;
    pab.CharCount = 0;
    // the stuff that matters...
    pab.OpCode = DSR_SAVE; // DSR_SAVE for SAVE
    pab.VDPBuffer = FBUF; // where in VDP you want to load (or save from)
    pab.RecordNumber = numbytes; // size to save since we aren't using records
    pab.NameLength = strlen(filename);
    pab.pName = filename;
    
    vdpmemcpy(FBUF, source, numbytes);
    return dsrlnk(&pab, VPAB);
}

/* General screen functions */
void cspaces(unsigned char number)
{
    /* Function to print specified number of spaces, cursor set by conio.h functions */

    unsigned char x;

    for(x=0;x<number;x++) { cputc(C_SPACE); }
}

void vdpspaces(unsigned char number)
{
    /* Function to print specified number of spaces, cursor set by vdp.h functions */

    unsigned char x;

    for(x=0;x<number;x++) { VDPWD = C_SPACE; }
}

void cleararea(unsigned char xpos, unsigned char ypos, unsigned char height, unsigned char width)
{
    /* Function to clear area */

    unsigned char x;

    for(x=0;x<height;x++)
    {
        VDP_SET_ADDRESS_WRITE(gImage+xpos+(ypos+x)*32);
        vdpspaces(width);
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

/* Generic input routines */
unsigned char getkey(unsigned char* allowedkeys, unsigned char joyallowed)
{
    /* Function to wait on valid key or joystick press/move
       Input: allowedkeys = String with valid key press options
                            Empty string means any key allowed
       Output: key value (or joystick converted to key value)    */

    unsigned char key, joy1x, joy1y, joy1b, joy2x, joy2y, joy2b, debounce;

    do
    {
        random();
        if(musicnumber)
        {
            vdpwaitvint();      // wait for an interrupt with ints enabled - console clears it
            CALL_PLAYER_SN;
            if (!isSNPlaying) { StartSong(musicmem,0); }
        }
        
        key = 0;
        if(joyinterface && joyallowed)
        {
            joystfast(1);
            kscanfast(1);
            joy1x = KSCAN_JOYX;
            joy1y = KSCAN_JOYY;
            joy1b = KSCAN_KEY;
            joystfast(2);
            kscanfast(2);
            joy2x = KSCAN_JOYX;
            joy2y = KSCAN_JOYY;
            joy2b = KSCAN_KEY;
            if(joy1b != 0xff || joy2b != 0xff ) { key = C_ENTER; }
            if(joy1x == JOY_RIGHT || joy2x == JOY_RIGHT ) { key = C_RIGHT; }
            if(joy1x == JOY_LEFT || joy2x == JOY_LEFT ) { key = C_LEFT; }
            if(joy1y == JOY_DOWN || joy2y == JOY_DOWN ) { key = C_DOWN; }
            if(joy1y == JOY_UP || joy2y == JOY_UP ) { key = C_UP; }
            if(key){
                do
                {
                    debounce = 0;
                    joystfast(1);
                    kscanfast(1);
                    joy1x = KSCAN_JOYX;
                    joy1y = KSCAN_JOYY;
                    joy1b = KSCAN_KEY;
                    joystfast(2);
                    kscanfast(2);
                    joy2x = KSCAN_JOYX;
                    joy2y = KSCAN_JOYY;
                    joy2b = KSCAN_KEY;
                    if(joy1b != 0xff || joy2b != 0xff ) { debounce=1; }
                    if(joy1x == JOY_RIGHT || joy2x == JOY_RIGHT ) { debounce=1; }
                    if(joy1x == JOY_LEFT || joy2x == JOY_LEFT ) { debounce=1; }
                    if(joy1y == JOY_DOWN || joy2y == JOY_DOWN ) { debounce=1; }
                    if(joy1y == JOY_UP || joy2y == JOY_UP ) { debounce=1; }
                } while (debounce == 1);
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

int input(unsigned char xpos, unsigned char ypos, unsigned char *str, unsigned char size)
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
    unsigned char validkeys[70] = {C_SPACE ,C_DELETE,0};

    strcat(validkeys,numbers);
    strcat(validkeys,letters);
    strcat(validkeys,updownenter);
    strcat(validkeys,leftright);
  
    VDP_SET_ADDRESS_WRITE(gImage+xpos+x+(ypos*32));
    for(x=0;x<size+1;x++) { VDPWD = C_WUNDERL; }

    cputsxy(xpos, ypos, str);
    vdpchar(gImage+xpos+strlen(str)+(ypos*32),C_INVSPACE);
  
    while(1)
    {
        c = getkey(validkeys,0);
        switch (c)
        {
            case C_ENTER:
                idx = strlen(str);
                str[idx] = 0;
                gotoxy(xpos,ypos);
                cspaces(size+1);
                cputsxy(xpos, ypos, str);
                return idx;
  
            case C_DELETE:
                if (idx)
                {
                    --idx;
                    cputcxy(xpos+idx, ypos, C_SPACE);
                    for(x = idx; 1; ++x)
                    {
                        b = str[x+1];
                        str[x] = b;
                        vdpchar(gImage+xpos+x+(ypos*32), b ? b : C_WUNDERL);
                        if (b == 0) { break; }
                    }
                    vdpchar(gImage+xpos+idx+(ypos*32),C_INVSPACE);
                    vdpchar(gImage+xpos+idx+1+(ypos*32),str[idx+1] ? str[idx+1] : C_WUNDERL);
                    gotoxy(xpos+idx, ypos);
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
                    cputsxy(xpos, ypos, str);
                    gotoxy(xpos + idx, ypos);
                }
                break;
  
            case C_LEFT:
                if (idx)
                {
                    --idx;
                    vdpchar(gImage+xpos+idx+(ypos*32),C_INVSPACE);
                    vdpchar(gImage+xpos+idx+1+(ypos*32),str[idx+1] ? str[idx+1] : C_WUNDERL);
                    gotoxy(xpos+idx, ypos);
                }
                break;

            case C_RIGHT:
                if (idx < strlen(str) && idx < size)
                {
                    ++idx;
                    gotoxy(xpos+idx-1, ypos);
                    cputc(str[idx-1]);
                    vdpchar(gImage+xpos+idx+(ypos*32),C_INVSPACE);
                    gotoxy(xpos + idx, ypos);
                }
                break;
  
            default:
                if (idx < size)
                {
                    flag = (str[idx] == 0);
                    str[idx] = c;
                    gotoxy(xpos+idx, ypos);
                    cputc(c);
                    vdpchar(gImage+xpos+idx+1+(ypos*32),C_INVSPACE);
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

    VDP_SET_ADDRESS_WRITE(gImage+xpos+(ypos*32));
    VDPWD = C_LOWRIGHT;
    for(x=0;x<width;x++) { VDPWD = C_LOWLINE; }
    VDPWD = C_LOWLEFT;
    for(y=0;y<height;y++)
    {
        VDP_SET_ADDRESS_WRITE(gImage+xpos+(ypos+y+1)*32);
        VDPWD = C_RIGHTLINE;
        vdpspaces(width);
        VDPWD = C_LEFTLINE;
    }
    VDP_SET_ADDRESS_WRITE(gImage+xpos+(ypos+height+1)*32);
    VDPWD = C_UPRIGHT;
    for(x=0;x<width;x++) { VDPWD = C_UPLINE; }
    VDPWD = C_UPLEFT;
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

    windowsave(ypos, pulldownmenuoptions[menunumber-1]+4);
    if(menunumber>menubaroptions)
    {
        VDP_SET_ADDRESS_WRITE(gImage+xpos+(ypos*32));
        VDPWD = C_LOWRIGHT;
        for(x=0;x<strlen(pulldownmenutitles[menunumber-1][0])+2;x++) { VDPWD = C_LOWLINE; }
    }
    for(x=0;x<pulldownmenuoptions[menunumber-1];x++)
    {
        vdpchar(gImage+xpos+(ypos+x+1)*32,C_RIGHTLINE);
        gotoxy(xpos+1,ypos+x+1);
        cprintf(" %s ",pulldownmenutitles[menunumber-1][x]);
        vdpchar(gImage+xpos+strlen(pulldownmenutitles[menunumber-1][x])+2+(ypos+x+1)*32,C_RIGHTLINE);
    }
    VDP_SET_ADDRESS_WRITE(gImage+xpos+(ypos+pulldownmenuoptions[menunumber-1]+1)*32);
    VDPWD = C_UPRIGHT;
    for(x=0;x<strlen(pulldownmenutitles[menunumber-1][0])+2;x++)
    {
        VDPWD = C_UPLINE;
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
            VDP_SET_ADDRESS_WRITE(gImage+menubarcoords[menubarchoice-1]+32);
            for(x=0;x<strlen(menubartitles[menubarchoice-1]);x++)
            {
                VDPWD = C_UPLINE;
            }
            key = getkey(validkeys,joyinterface);
            VDP_SET_ADDRESS_WRITE(gImage+menubarcoords[menubarchoice-1]+32);
            vdpspaces(strlen(menubartitles[menubarchoice-1]));
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

void fileerrormessage(unsigned char ferr)
{
    /* Show message for file error encountered */

    menumakeborder(10,5,6,20);
    cputsxy(12,7,"File error!");
    gotoxy(12,8);
    cprintf("Error nr.: %2X",ferr);
    cputsxy(12,10,"Press key.");
    getkey("",1);
    windowrestore();    
}

/* Config file and save game functions */

void saveconfigfile()
{
    /* Save configuration file */

    unsigned char fname[25];
    unsigned char ferr;

    strcpy(fname,dsrpath);
    strcat(fname,"LUDOFG");

    ferr = dsr_save(fname,saveslots,85);
    if (ferr) { fileerrormessage(ferr); }
}

void loadconfigfile()
{
    /* Load configuration file or create one if not present */

    unsigned char fname[25];
    unsigned char x,y;

    getconfigfilepath();

    strcpy(fname,dsrpath);
    strcat(fname,"LUDOCFG");

    unsigned char ferr = dsr_load(fname,saveslots,85);
    if (ferr) { fileerrormessage(ferr); }
    else
    {
        for(y=0;y<5;y++)
        {
            for(x=0;x<16;x++)
            {
                pulldownmenutitles[7][y][x]=saveslots[(y*16)+5+x];
            }
        }
    }
}

/* Graphics and screen initialisation functions */

void graphicsinit()
{
    /* Initialize graphics mode and load colors and patterns */

    unsigned char ferr; 
    unsigned char fname[25];

    set_graphics(0);
    windowaddress = WINDOWBASE;
    bgcolor(COLOR_BLACK);
    clrscr();

    /* Load and read game config file */
    loadconfigfile();

    // Load patterns from disk and copy to VDP
    strcpy(fname,dsrpath);
    strcat(fname,"LUDOCHR");
    ferr = dsr_load(fname,musicmem,1600);
    if (ferr) { fileerrormessage(ferr); halt(); }
    vdpmemcpy(gPattern,musicmem,1600);

    // Load colorset from disk and copy to VDP
    strcpy(fname,dsrpath);
    strcat(fname,"LUDOCOL");
    ferr = dsr_load(fname,musicmem,25);
    if (ferr) { fileerrormessage(ferr); halt(); }
    vdpmemcpy(gColor,musicmem,25);

    //Load mainscreen from disk and store to variable for in-game use
    strcpy(fname,dsrpath);
    strcat(fname,"LUDOMSC");
    ferr = dsr_load(fname,mainscreen,768);
    if (ferr) { fileerrormessage(ferr); halt(); }

    //Load titlecreen from disk and copy to VDP
    strcpy(fname,dsrpath);
    strcat(fname,"LUDOTIT");
    ferr = dsr_load(fname,musicmem,576);
    if (ferr) { fileerrormessage(ferr); halt(); }
    vdpmemcpy(gImage,musicmem,576);
}

void loadmainscreen()
{
    /* Copy mainscreen to screen memory */

    vdpmemcpy(gImage, mainscreen, sizeof(mainscreen));
    menuplacebar();
}

/* Game routines */

unsigned char dicethrow()
{
    /* Throw the dice. Returns the dice value */

    unsigned char dicethrow, x;

    menumakeborder(22,10,6,7);
    for(x=0;x<10;x++)
    {
        if(musicnumber)
        {
            vdpwaitvint();      // wait for an interrupt with ints enabled - console clears it
            CALL_PLAYER_SN;
            if (!isSNPlaying) { StartSong(musicmem,0); }
        }
        dicethrow = random()%6+1;
        vdpchar(gImage+25+(12*32),dicegraphics[dicethrow-1][0]);
        vdpchar(gImage+26+(12*32),dicegraphics[dicethrow-1][1]);
        vdpchar(gImage+25+(13*32),dicegraphics[dicethrow-1][2]);
        vdpchar(gImage+26+(13*32),dicegraphics[dicethrow-1][3]);
        wait(5);
    }
    cputsxy(24,15,"Key.");
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
        switch (playerpos[playernumber][pawnnumber][1]/10)
        {
        case 0:
            cputcxy(xpos,ypos,C_GSTARTUL);
            cputcxy(xpos+1,ypos,C_GSTARTUR);
            cputcxy(xpos,ypos+1,C_GSTARTLL);
            cputcxy(xpos+1,ypos+1,C_GSTARTLR);
            break;

        case 1:
            cputcxy(xpos,ypos,C_RSTARTUL);
            cputcxy(xpos+1,ypos,C_RSTARTUR);
            cputcxy(xpos,ypos+1,C_RSTARTLL);
            cputcxy(xpos+1,ypos+1,C_RSTARTLR);
            break;

        case 2:
            cputcxy(xpos,ypos,C_BSTARTUL);
            cputcxy(xpos+1,ypos,C_BSTARTUR);
            cputcxy(xpos,ypos+1,C_BSTARTLL);
            cputcxy(xpos+1,ypos+1,C_BSTARTLR);
            break;

        case 3:
            cputcxy(xpos,ypos,C_YSTARTUL);
            cputcxy(xpos+1,ypos,C_YSTARTUR);
            cputcxy(xpos,ypos+1,C_YSTARTLL);
            cputcxy(xpos+1,ypos+1,C_YSTARTLR);
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
            cputcxy(xpos,ypos,C_EFIELDUL);
            cputcxy(xpos+1,ypos,C_EFIELDUR);
            cputcxy(xpos,ypos+1,C_EFIELDLL);
            cputcxy(xpos+1,ypos+1,C_EFIELDLR);
        }
        else
        {
            /* Colored home or destination field */
            switch (playernumber)
            {
            case 0:
                cputcxy(xpos,ypos,C_GFIELDUL);
                cputcxy(xpos+1,ypos,C_GFIELDUR);
                cputcxy(xpos,ypos+1,C_GFIELDLL);
                cputcxy(xpos+1,ypos+1,C_GFIELDLR);
                break;

            case 1:
                cputcxy(xpos,ypos,C_RFIELDUL);
                cputcxy(xpos+1,ypos,C_RFIELDUR);
                cputcxy(xpos,ypos+1,C_RFIELDLL);
                cputcxy(xpos+1,ypos+1,C_RFIELDLR);
                break;

            case 2:
                cputcxy(xpos,ypos,C_BFIELDUL);
                cputcxy(xpos+1,ypos,C_BFIELDUR);
                cputcxy(xpos,ypos+1,C_BFIELDLL);
                cputcxy(xpos+1,ypos+1,C_BFIELDLR);
                break;

            case 3:
                cputcxy(xpos,ypos,C_YFIELDUL);
                cputcxy(xpos+1,ypos,C_YFIELDUR);
                cputcxy(xpos,ypos+1,C_YFIELDLL);
                cputcxy(xpos+1,ypos+1,C_YFIELDLR);
                break;

            default:
                break;
            }
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

    if(selected)
    {
        cputcxy(xpos,ypos,C_WPAWNUL);
        cputcxy(xpos+1,ypos,C_WPAWNUR);
        cputcxy(xpos,ypos+1,C_WPAWNLL);
        cputcxy(xpos+1,ypos+1,C_WPAWNLR);
    }
    else
    {
        switch (playernumber)
        {
        case 0:
            cputcxy(xpos,ypos,C_GPAWNUL);
            cputcxy(xpos+1,ypos,C_GPAWNUR);
            cputcxy(xpos,ypos+1,C_GPAWNLL);
            cputcxy(xpos+1,ypos+1,C_GPAWNLR);
            break;

        case 1:
            cputcxy(xpos,ypos,C_RPAWNUL);
            cputcxy(xpos+1,ypos,C_RPAWNUR);
            cputcxy(xpos,ypos+1,C_RPAWNLL);
            cputcxy(xpos+1,ypos+1,C_RPAWNLR);
            break;

        case 2:
            cputcxy(xpos,ypos,C_BPAWNUL);
            cputcxy(xpos+1,ypos,C_BPAWNUR);
            cputcxy(xpos,ypos+1,C_BPAWNLL);
            cputcxy(xpos+1,ypos+1,C_BPAWNLR);
            break;

        case 3:
            cputcxy(xpos,ypos,C_YPAWNUL);
            cputcxy(xpos+1,ypos,C_YPAWNUR);
            cputcxy(xpos,ypos+1,C_YPAWNLL);
            cputcxy(xpos+1,ypos+1,C_YPAWNLR);
            break;
        
        default:
            break;
        }
    }
}

void savegame(unsigned char autosave)
{
    /* Save game to a gameslot
       Input: autosave is 1 for autosave, else 0 */

    unsigned char fname[25];
    unsigned char slot = 0;
    unsigned char x, y, len, ferr;
    unsigned char yesno = 1;

    strcpy(fname,dsrpath);
    strcat(fname,"LUDOSAV");

    len = strlen(fname);

    if(autosave==1)
    {
        fname[len]=48;
        fname[len+1]=0;
    }
    else
    {
        menumakeborder(2,5,12,28);
        cputsxy(4,7,"Save game.");
        cputsxy(4,8,"Choose slot:");
        do
        {
            slot = menupulldown(10,10,8) - 1;
        } while (slot<1);
        if(saveslots[slot]==1)
        {
            cputsxy(4,9,"Slot not empty. Sure?");
            yesno = menupulldown(15,10,5);
        }
        if(yesno==1)
        {
            cputsxy(4,9,"Choose name of save. ");
            if(saveslots[slot]==0) { memset(pulldownmenutitles[7][slot],0,15); }
            input(4,10,pulldownmenutitles[7][slot],15);
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
        ferr = dsr_save(fname,savegamemem,136);
        if (ferr) { fileerrormessage(ferr); }
    }
}

void loadgame()
{
     /* Load game from a gameslot */
    
    unsigned char fname[25];
    unsigned char slot, x, y, ferr, len;
    unsigned char yesno = 1;

    strcpy(fname,dsrpath);
    strcat(fname,"LUDOSAV");
    
    len = strlen(fname);
    
    menumakeborder(2,5,12,28);
    cputsxy(4,7,"Load game.");
    cputsxy(4,9,"Choose slot:");
    slot = menupulldown(10,10,8) - 1;
    if(saveslots[slot]==0)
    {
        cputsxy(4,9,"Slot empty.");
        cputsxy(4,10,"Press key.");
        getkey("",1);
    }
    windowrestore();
    if(saveslots[slot]==1)
    {
        fname[len]=48+slot;
        fname[len+1]=0;
        ferr = dsr_load(fname,savegamemem,136);
        if (ferr) { fileerrormessage(ferr); return; }

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

    menumakeborder(2,8,6,28);
    for(x=0;x<4;x++)
    {
        gotoxy(4,10);
        cprintf("Computer plays player %d?",x+1);
        choice = menupulldown(20,11,5);
        if(choice==1)
        {
            playerdata[x][0]=1;
        }
        else
        {
            playerdata[x][0]=0;
        }
        gotoxy(4,10);
        cprintf("Input name player %d:    ",x+1);
        input(4,12,playername[x],8);
    }
    windowrestore();
}

void musicnext()
{
    /* Funtion to load and start next music track */

    unsigned char fname[25];
    unsigned char len, ferr;

    strcpy(fname,dsrpath);
    strcat(fname,"LUDOMUS");

    len = strlen(fname);

    StopSong();
    if(++musicnumber>3) { musicnumber = 1;}
    fname[len]=48+musicnumber;
    fname[len+1]=0;
    memset(musicmem,0,3200);
    ferr = dsr_load(fname,musicmem,3200);
    if (ferr) { fileerrormessage(ferr); }
    StartSong(musicmem,0);
}

void informationcredits()
{
    /* Print version information and credits */

    unsigned char version[30] = {
        'v',VERSION_MAJOR_CH0,VERSION_MINOR_CH0,VERSION_MINOR_CH1,' ','-',' ',
        BUILD_YEAR_CH0,BUILD_YEAR_CH1,BUILD_YEAR_CH2,BUILD_YEAR_CH3,
        BUILD_MONTH_CH0,BUILD_MONTH_CH1,BUILD_DAY_CH0,BUILD_DAY_CH1,'-',
        BUILD_HOUR_CH0,BUILD_HOUR_CH1,BUILD_MIN_CH0,BUILD_MIN_CH1 };
    menumakeborder(0,5,14,30);
    printcentered("L U D O",2,7,28);
    printcentered(version,2,8,28);
    printcentered("Written by Xander Mol",2,10,28);
    printcentered("Converted TI-99/4a, 2021",2,11,28);
    printcentered("From Commodore 128 1992",2,12,28);
    printcentered("Build with/using code of",2,14,28);
    printcentered("TMS9900-GCC by Insomnia",2,15,28);
    printcentered("Libti99 lib by Tursi",2,16,28);
    printcentered("Jedimatt42 help/code",2,17,28);
    printcentered("Press a key.",2,18,28);
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
                StopSong();
                MUTE_SOUND();
                musicnumber=0;
                break;

            case 33:
                if(musicnumber)
                { 
                    StopSong();
                }
                else
                {
                    musicnumber=1;
                }
                StartSong(musicmem,0);
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
    unsigned char validkeys[5] = { C_LEFT, C_RIGHT, C_UP, C_DOWN, C_ENTER };

    menumakeborder(22,6,2,9);
    cputsxy(24,7,"Pawn?");
    gotoxy(24,8);
    cprintf("Dice=%d", throw);
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

    menumakeborder(3,5,10,25);
    gotoxy(5,7);
    cprintf("%s has won!", playername[turnofplayernr]);

    if (detect_speech())
    {
        MUTE_SOUND();
        say_vocab(speech_playercolor[turnofplayernr]);
        speech_wait();
        speech_reset();
        say_vocab(SPEECH_WIN);
        speech_wait();
    }

    cputsxy(5,9,"Your choice?");
    do
    {
        choice = menupulldown(10,10,7);
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
            cputsxy(23,7,"Throw 3x");
        }
    }
    for(x=0;x<dicethrows;x++)
    {
        throw = dicethrow();
        if(throw==6) { break; }
    }
    cputsxy(23,7,"        ");
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
        cputsxy(23,7,"No move");
        cputsxy(23,8,"Key.");
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
        if (detect_speech())
        {
            MUTE_SOUND();
            say_data(speech_ohoh, sizeof(speech_ohoh));
            speech_wait();
        }

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
        cputsxy(23,7,"Key.");
        getkey("",1);
    }
}

void loadintro()
{
    /* Game intro */

    int x, y, ferr;
    int len = 0;
    unsigned char validkeys[4] = {'m', 'M', C_ENTER, 0 };
    unsigned char fname[25];
    unsigned char key;

    //Welcome speech
    copy_safe_read();
    
    if (!detect_speech()) {
      cprintf("No speech synthesizer detected :(\n");
    }
    else
    {
        say_data(speech_intro, sizeof(speech_intro));
        speech_wait();
    }

    /* Load and start first music file */
    memset(musicmem,0,3200);
    strcpy(fname,dsrpath);
    strcat(fname,"LUDOMUS1");
    ferr = dsr_load(fname,musicmem,3200);
    if (ferr) { fileerrormessage(ferr); }
    StartSong(musicmem,0);

    /* Wait for ENTER of FIRE while player can toggle joystick and music */
    
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
                StopSong();
                MUTE_SOUND();
                musicnumber = 0;
            }
            else{
                musicnumber = 1;
                StartSong(musicmem,0);
            }
            break;
        
        default:
            break;
        }
    } while (key != C_ENTER);
}

/* Main routine */

int main()
{
    unsigned char x, choice;

    //Game intro
    graphicsinit();

    loadintro();

    //Ask for loading save game
    menumakeborder(8,5,6,20);
    cputsxy(10,7,"Load old game?");
    choice = menupulldown(17,8,5);
    windowrestore();
    if(choice==1) { loadmainscreen(); loadgame(); }

    if(endofgameflag==0) { loadmainscreen(); }

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
            cleararea(23,2,8,8);
            gotoxy(23,2);
            cprintf("Player %d", turnofplayernr+1);
            cputsxy(23,3,"Color");
            cputcxy(30,3,playerdata[turnofplayernr][2]);
            cputsxy(23,4,playername[turnofplayernr]);

            //Speech announce turn
            if (detect_speech())
            {
                MUTE_SOUND();
                say_vocab(speech_playercolor[turnofplayernr]);
                speech_wait();
            }

            if(playerdata[turnofplayernr][0]==0)
            {
                turnhuman();
            }
            else
            {
                cputsxy(23,5,"Computer");
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

    //End of game
    clrscr();
    bgcolor(0);    
    cputsxy(0,0,"Thanks for playing, goodbye.");
    StopSong();
    MUTE_SOUND();
    halt();
}