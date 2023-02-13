/*
GeoLudo
Ludo game for 8 bit computers, GEOS edition
Written in 2023 by Xander Mol

https://github.com/xahmol/GeoUTools

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

// Global variables
char buffer[81];

//Game variables
unsigned char endofgameflag = 0;
unsigned char turnphase = 0;
unsigned char turnofplayernr = 0;
unsigned char zv = 0;
unsigned char ns = 0;
unsigned char throw;
unsigned char autosavetoggle = 1;

//Save game and config file memory allocation and variables
unsigned char saveslots[85];
unsigned char savegamemem[136];

// Colors for field
unsigned char vic_color[5] = { BLACK, GREEN, RED, BLUE, YELLOW };
unsigned char vdc_color[5] = { VDC_BLACK, VDC_DGREEN, VDC_DRED, VDC_DBLUE, VDC_LYELLOW };

//Pawn position co-ords and colors main field
unsigned char fieldcoords[40][2] = {
     { 0,11}, { 2,11}, { 4,11}, { 6,11}, { 8,11},
     { 8, 9}, { 8, 7}, { 8, 5}, { 8, 3}, {10, 3},
     {12, 3}, {12, 5}, {12, 7}, {12, 9}, {12,11},
     {14,11}, {16,11}, {18,11}, {20,11}, {20,13},
     {20,15}, {18,15}, {16,15}, {14,15}, {12,15},
     {12,17}, {12,19}, {12,21}, {12,23}, {10,23},
     { 8,23}, { 8,21}, { 8,19}, { 8,17}, { 8,15},
     { 6,15}, { 4,15}, { 2,15}, { 0,15}, { 0,13}
};

//Pawn posiiion co-ords and colors start and destination
unsigned char homedestcoords[4][8][2] = {
    {{ 0, 3}, { 2, 3}, { 0, 5}, { 2, 5}, { 2,13}, { 4,13}, { 6,13}, { 8,13}},
    {{18, 3}, {20, 3}, {18, 5}, {20, 5}, {10, 5}, {10, 7}, {10, 9}, {10,11}},
    {{18,21}, {20,21}, {18,23}, {20,23}, {18,13}, {16,13}, {14,13}, {12,13}},
    {{ 0,21}, { 2,21}, { 0,23}, { 2,23}, {10,21}, {10,19}, {10,17}, {10,15}}
};

/* Player data:
    [players 0-3]
    [position 0: human = 0 or computer = 1
     position 1: number of pawns not at destination
     position 2: player color
     position 3: number of pawns at home              */
unsigned char playerdata[4][4] = {
    {0,4,1,4},
    {0,4,2,4},
    {0,4,3,4},
    {0,4,4,4}
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

// Bitmaos
char pawngraphics[4][] = {
    "\xA0\x01\xC0\x07\xF0\x0F\xF8\x1F"
    "\xFC\x0F\xF8\x07\xF0\x03\xE0\x07"
    "\xF0\x03\xE0\x07\xF0\x0F\xF8\x0F"
    "\xF8\x1F\xFC\x1F\xFC\x1F\xFC\x00"
    "\x00",
    "\xA0\x01\xC0\x07\xF0\x0E\xB8\x1A"
    "\xAC\x0E\xB8\x06\xB0\x03\xE0\x06"
    "\xB0\x03\xE0\x06\xB0\x0E\xB8\x0E"
    "\xB8\x1A\xAC\x1A\xAC\x1F\xFC\x00"
    "\x00",
    "\xA0\x01\xC0\x07\x70\x0D\x58\x1A"
    "\xAC\x0D\x58\x06\xB0\x03\x60\x06"
    "\xB0\x03\x60\x06\xB0\x0D\x58\x0E"
    "\xB8\x1D\x5C\x1A\xAC\x1F\xFC\x00"
    "\x00",
    "\xA0\x01\xC0\x07\x70\x0F\xF8\x18"
    "\x0C\x0F\xF8\x06\x30\x03\xE0\x06"
    "\x30\x03\xE0\x06\x30\x0F\xF8\x0C"
    "\x18\x1F\xFC\x18\x0C\x1F\xFC\x00"
    "\x00"
};

char fieldgraphics[5][] = {
    "\x04\x00\x98\x01\x80\x06\x60\x08"
    "\x10\x10\x08\x10\x08\x20\x04\x20"
    "\x04\x10\x08\x10\x08\x08\x10\x06"
    "\x60\x01\x80\x04\x00",
    "\x04\x00\x98\x01\x80\x07\xE0\x0F"
    "\xF0\x1F\xF8\x1F\xF8\x3F\xFC\x3F"
    "\xFC\x1F\xF8\x1F\xF8\x0F\xF0\x07"
    "\xE0\x01\x80\x04\x00",
    "\x04\x00\x98\x01\x80\x06\xE0\x0A"
    "\xB0\x1A\xA8\x1A\xA8\x2A\xAC\x2A"
    "\xAC\x1A\xA8\x1A\xA8\x0A\xB0\x06"
    "\xE0\x01\x80\x04\x00",
    "\x04\x00\x98\x01\x80\x06\xE0\x0D"
    "\x50\x1A\xA8\x15\x58\x2A\xAC\x35"
    "\x54\x1A\xA8\x15\x58\x0A\xB0\x07"
    "\x60\x01\x80\x04\x00",
    "\x04\x00\x98\x01\x80\x07\xE0\x08"
    "\x10\x1F\xF8\x10\x08\x3F\xFC\x20"
    "\x04\x1F\xF8\x10\x08\x0F\xF0\x06"
    "\x60\x01\x80\x04\x00"
};

char startfieldgraphics[4][] = {
    "\x04\x00\x98\x01\x80\x07\xE0\x0F"
    "\xF0\x1F\x78\x1F\x38\x38\x1C\x38"
    "\x1C\x1F\x38\x1F\x78\x0F\xF0\x07"
    "\xE0\x01\x80\x04\x00",
    "\x04\x00\x98\x01\x80\x07\xE0\x0F"
    "\xF0\x1E\x78\x1E\x78\x3E\x7C\x38"
    "\x1C\x1C\x38\x1E\x78\x0F\xF0\x07"
    "\xE0\x01\x80\x04\x00",
    "\x04\x00\x98\x01\x80\x07\xE0\x0F"
    "\xF0\x1E\xF8\x1C\xF8\x38\x1C\x38"
    "\x1C\x1C\xF8\x1E\xF8\x0F\xF0\x07"
    "\xE0\x01\x80\x04\x00",
    "\x04\x00\x98\x01\x80\x07\xE0\x0F"
    "\xF0\x1E\x78\x1C\x38\x38\x1C\x3E"
    "\x7C\x1E\x78\x1E\x78\x0F\xF0\x07"
    "\xE0\x01\x80\x04\x00"
};

char dicegraphics[6][] = {
    "\xBF\x00\x00\x00\x07\xFF\xE0\x08"
    "\x00\x10\x10\x00\x08\x10\x00\x08"
    "\x10\x00\x08\x10\x00\x08\x10\x00"
    "\x08\x10\x18\x08\x10\x3C\x08\x10"
    "\x3C\x08\x10\x18\x08\x10\x00\x08"
    "\x10\x00\x08\x10\x00\x08\x10\x00"
    "\x08\x10\x00\x08\x08\x00\x10\x07"
    "\xFF\xE0\x00\x00\x00\x00\x00\x00",
    "\xBF\x00\x00\x00\x07\xFF\xE0\x08"
    "\x00\x10\x10\x00\xC8\x10\x01\xE8"
    "\x10\x01\xE8\x10\x00\xC8\x10\x00"
    "\x08\x10\x00\x08\x10\x00\x08\x10"
    "\x00\x08\x10\x00\x08\x10\x00\x08"
    "\x13\x00\x08\x17\x80\x08\x17\x80"
    "\x08\x13\x00\x08\x08\x00\x10\x07"
    "\xFF\xE0\x00\x00\x00\x00\x00\x00",
    "\xBF\x00\x00\x00\x07\xFF\xE0\x08"
    "\x00\x10\x10\x00\xC8\x10\x01\xE8"
    "\x10\x01\xE8\x10\x00\xC8\x10\x00"
    "\x08\x10\x18\x08\x10\x3C\x08\x10"
    "\x3C\x08\x10\x18\x08\x10\x00\x08"
    "\x13\x00\x08\x17\x80\x08\x17\x80"
    "\x08\x13\x00\x08\x08\x00\x10\x07"
    "\xFF\xE0\x00\x00\x00\x00\x00\x00",
    "\xBF\x00\x00\x00\x07\xFF\xE0\x08"
    "\x00\x10\x13\x00\xC8\x17\x81\xE8"
    "\x17\x81\xE8\x13\x00\xC8\x10\x00"
    "\x08\x10\x00\x08\x10\x00\x08\x10"
    "\x00\x08\x10\x00\x08\x10\x00\x08"
    "\x13\x00\xC8\x17\x81\xE8\x17\x81"
    "\xE8\x13\x00\xC8\x08\x00\x10\x07"
    "\xFF\xE0\x00\x00\x00\x00\x00\x00",
    "\xBF\x00\x00\x00\x07\xFF\xE0\x08"
    "\x00\x10\x13\x00\xC8\x17\x81\xE8"
    "\x17\x81\xE8\x13\x00\xC8\x10\x00"
    "\x08\x10\x18\x08\x10\x3C\x08\x10"
    "\x3C\x08\x10\x18\x08\x10\x00\x08"
    "\x13\x00\xC8\x17\x81\xE8\x17\x81"
    "\xE8\x13\x00\xC8\x08\x00\x10\x07"
    "\xFF\xE0\x00\x00\x00\x00\x00\x00",
    "\xBF\x00\x00\x00\x07\xFF\xE0\x08"
    "\x00\x10\x13\x00\xC8\x17\x81\xE8"
    "\x17\x81\xE8\x13\x00\xC8\x10\x00"
    "\x08\x13\x00\xC8\x17\x81\xE8\x17"
    "\x81\xE8\x13\x00\xC8\x10\x00\x08"
    "\x13\x00\xC8\x17\x81\xE8\x17\x81"
    "\xE8\x13\x00\xC8\x08\x00\x10\x07"
    "\xFF\xE0\x00\x00\x00\x00\x00\x00"
};

// Icons
char iconThrow[] = {
    "\x05\xFF\x82\xFE\x80\x04\x00\x82"
    "\x03\x80\x04\x00\xB8\x03\x9F\xEC"
    "\x00\x00\x00\x03\x83\x0C\x00\x00"
    "\x00\x03\x83\x0F\x9F\x9E\x66\x63"
    "\x83\x0E\xDC\x33\x66\x63\x83\x0C"
    "\xD8\x33\x3F\xC3\x83\x0C\xD8\x33"
    "\x3F\xC3\x83\x0C\xD8\x33\x19\x83"
    "\x83\x0C\xD8\x33\x19\x83\x83\x0C"
    "\xD8\x1E\x19\x83\x80\x04\x00\x82"
    "\x03\x80\x04\x00\x81\x03\x06\xFF"
    "\x81\x7F\x05\xFF"
};

char iconNext[] = {
    "\x05\xFF\x82\xFE\x80\x04\x00\x82"
    "\x03\x80\x04\x00\xB8\x03\x80\x39"
    "\x80\x00\x60\x03\x80\x39\x80\x00"
    "\x60\x03\x80\x3D\x9E\x66\xF0\x03"
    "\x80\x3D\xB3\x66\x60\x03\x80\x37"
    "\xB3\x3C\x60\x03\x80\x37\xBF\x18"
    "\x60\x03\x80\x33\xB0\x3C\x60\x03"
    "\x80\x33\xB3\x66\x60\x03\x80\x31"
    "\x9E\x66\x38\x03\x80\x04\x00\x82"
    "\x03\x80\x04\x00\x81\x03\x06\xFF"
    "\x81\x7F\x05\xFF"
};

char fileiconp[] = {
    0x00,0x00,0x00,0x0E,0x00,0x00,0x1F,0x00,0x00,0x3F,0x80,0x00,0x7F,0xC0,0x00,0x7F,
    0xC0,0x00,0x3F,0x80,0x00,0x1F,0x00,0x00,0x0E,0x07,0xFC,0x1F,0x08,0x02,0x3F,0x92,
    0x09,0x3F,0x97,0x1D,0x7F,0xD2,0x09,0x7F,0xD0,0x41,0x7F,0xD0,0xE1,0x00,0x10,0x41,
    0x00,0x12,0x09,0x00,0x17,0x1D,0x00,0x12,0x09,0x00,0x08,0x02,0x00,0x07,0xFC,0x00
};

// Interface icontab
struct icontab vic_mainicons = {
    1,
    { 0,0 },
    { 0, 0, 0, 1, 1, 0 }
};

struct icontab vdc_mainicons = {
    1,
    { 0,0 },
    { 0, 0, 0, 1, 1, 0 }
};

// Declare functions prototypes that are called when menu items are 
// clicked on and are used in the structs that defines the menus below.
void geosSwitch4080();
void geosExit();
void gameRestart();
void gameColor();
void fileLoad();
void fileSave();
void fileAutosaveToggle();
void informationCredits();

// Menu structures with pointers to the menu handlers above
static struct menu menuGEOS = {
    // GEOS menu
        { 11, 23, 0, 160 },
        2 | HORIZONTAL,
          {
            { "Switch 40/80", MENU_ACTION, geosSwitch4080 },
            { "Exit", MENU_ACTION, geosExit },
          }
 };

static struct menu menuGame = {
    // Game menu
        { 11, 23, 0, 160 },
        2 | HORIZONTAL,
          {
            { "Restart", MENU_ACTION, gameRestart },
            { "Color", MENU_ACTION, gameColor },
          }
 };

static struct menu menuFile = {
    // File menu
        { 11, 23, 0, 160 },
        3 | HORIZONTAL,
          {
            { "Load", MENU_ACTION, fileLoad },
            { "Save", MENU_ACTION, fileSave },
            { "Autosave", MENU_ACTION, fileAutosaveToggle }
          }
 };

static struct menu menuMain = {
    // Main menu
        { 0, 12, 0, 160 },
        4 | HORIZONTAL,
          {
            { "GEOS", SUB_MENU, &menuGEOS},
            { "Game", SUB_MENU, &menuGame},
            { "File", SUB_MENU, &menuFile},
            { "Credits", MENU_ACTION, informationCredits }
          }
 };

/* Game routines */

void drawfield(unsigned char track, unsigned char position, unsigned char playernumber, unsigned char coloronly) {
// Draw board fields

    struct iconpic bitmap;
    unsigned char color = 0;
    unsigned char ypos;
    unsigned int xpos;
    bitmap.height = 16;
    bitmap.width = 2 | DOUBLE_B;

    if(!track)
    {
        // Draw main board track
        xpos = fieldcoords[position][0];
        ypos = fieldcoords[position][1]*8;

        if(position==0 || position==10 || position==20 || position==30)
        {
            // Colored start fields
            bitmap.pic_ptr = startfieldgraphics[position/10];
            if(!monochromeflag) {
                color = (vdc)?vdc_color[(position/10)+1]:vic_color[(position/10)+1];
            }
        }
        else
        {
            // Normal fields
            bitmap.pic_ptr = fieldgraphics[0];
        }
    } else {
        // Draw home and destination fields
        xpos = homedestcoords[playernumber][position][0];
        ypos = homedestcoords[playernumber][position][1]*8;
        bitmap.width = 2 | DOUBLE_B;
        bitmap.pic_ptr = fieldgraphics[playernumber+1];
        if(!monochromeflag) {
            color = (vdc)?vdc_color[playernumber+1]:vic_color[playernumber+1];
            bitmap.pic_ptr = fieldgraphics[1];
        }
    }

    if(vdc) { xpos += xpos; }

    if(!coloronly) {
        // Place bitmap
        bitmap.x = xpos;
        bitmap.y = ypos;
        BitmapUp(&bitmap);
    }

    // Color field
    xpos = xpos * 8;
    ColorRectangle(color,color_background,ypos,ypos+15,xpos,xpos+15+(16*vdc));
}

void pawnerase(unsigned char playernumber, unsigned char pawnnumber)
{
    /* Erase a pawn from the field
       Input playernumber and pawnnumber */

    drawfield(playerpos[playernumber][pawnnumber][0],playerpos[playernumber][pawnnumber][1],playernumber,0);
}

void pawnplace(unsigned char playernumber, unsigned char pawnnumber, unsigned char coloronly)
{
    /* Place a pawn on the field
       Input playernumber and pawnnumber */

    struct iconpic bitmap;
    unsigned char color = 0;
    unsigned char track, position,ypos;
    unsigned int xpos;
    bitmap.height = 16;
    bitmap.width = 2 | DOUBLE_B;


    track = playerpos[playernumber][pawnnumber][0];
    position = playerpos[playernumber][pawnnumber][1];
    
    if(!track)
    {
        xpos = fieldcoords[position][0];
        ypos = fieldcoords[position][1]*8;
    } else {
        xpos = homedestcoords[playernumber][position][0];
        ypos = homedestcoords[playernumber][position][1]*8;
    }

    if(monochromeflag) {
        bitmap.pic_ptr = pawngraphics[playernumber];
    } else {
        bitmap.pic_ptr = pawngraphics[0];
        color = (vdc)?vdc_color[playernumber+1]:vic_color[playernumber+1];
    }

    if(vdc) { xpos += xpos; }

    if(!coloronly) {
        // Place bitmap
        bitmap.x = xpos;
        bitmap.y = ypos;
        BitmapUp(&bitmap);
    }

    // Color field
    xpos = xpos * 8;
    ColorRectangle(color,color_background,ypos,ypos+15,xpos,xpos+15+(16*vdc));
}

void DrawBoard(unsigned char coloronly) {
// Draw game board

    unsigned char position, playernumber;

    // Main track
    for(position=0;position<40;position++)
    {
        drawfield(0,position,0,coloronly);
    }

    // Home and destination fields
    for(playernumber=0;playernumber<4;playernumber++)
    {
        for(position=0;position<8;position++)
        {
            drawfield(1,position,playernumber,coloronly);
        }
    }

    // Pawns
    for(playernumber=0;playernumber<4;playernumber++)
    {
        for(position=0;position<4;position++)
        {
            pawnplace(playernumber,position,coloronly);
        }
    }

    if(!coloronly)
    {    
        sprintf(buffer,"Colormode set: %d",screen_colormode);
        PutString(buffer,33,200 | DOUBLE_W);
        sprintf(buffer,"Colormode detect: %d",vdcClrMode);
        PutString(buffer,43,200 | DOUBLE_W);
        sprintf(buffer,"VDC: %d",vdc);
        PutString(buffer,53,200 | DOUBLE_W);
        sprintf(buffer,"VDC Size: %d",vdcsize);
        PutString(buffer,63,200 | DOUBLE_W);
        sprintf(buffer,"Monochrome: %d",monochromeflag);
        PutString(buffer,73,200 | DOUBLE_W);
    }
}

// Icon handlers

// Mouse handler functions

// Menu functions

void geosSwitch4080() {
// Switch between 40 and 80 column mode

    SetNewMode();
    ReinitScreen(appname);
    DrawBoard(0);
    GotoFirstMenu();
    DoMenu(&menuMain);
    DoIcons(icons);
    return;
}

void geosExit() {
// Exit to desktop

    ReDoMenu();
    // Ask confirnation
    if(!monochromeflag) { DialogueClearColor(); }
    if (DlgBoxOkCancel("Exit to desktop", "Are you sure?") == OK)
    {
        EnterDeskTop();
    }
    else
    {
        if(!monochromeflag) { DrawBoard(1); }
        return;
    }  
}

void gameRestart() {
    ReDoMenu();

}

void gameColor() {
// Set monochrome flag or not

    unsigned char oldflag = monochromeflag;

    ReDoMenu();

    if(!monochromeflag) { DialogueClearColor(); }
    sprintf(buffer,"Present value: %s",(monochromeflag)?"Yes":"No");
    monochromeflag = (DlgBoxYesNo("Enable monochrome mode?",buffer) == YES)?1:0;

    if(oldflag != monochromeflag) { 
        ReinitScreen(appname);
        DrawBoard(0);
    }
    return;
}

void fileLoad() {
    ReDoMenu();

}

void fileSave() {
    ReDoMenu();

}

void fileAutosaveToggle() {
    ReDoMenu();

}

void informationCredits (void) {
// Show credits
    
    unsigned char xcoord;

    ReDoMenu();

    // Create dialogue window
    xcoord = CreateWindow();

    // Print credits
    PutString(CBOLDON "GeoLudo" CPLAINTEXT,69,xcoord);
    PutString("Ludo game for 8 bit computers, GEOS edition",79,xcoord);
    sprintf(buffer,"Version: %s",version);
    PutString(buffer,99,xcoord);
    PutString("Written by Xander Mol, 2023",109,xcoord);
    PutString("For documentation, source, license and credits, see",119,xcoord);
    PutString("https://github.com/xahmol/GeoUTools",129,xcoord);
    PutString("https://www.idreamtin8bits.com/",139,xcoord);

    // Show OK icon
    WinOKButton();
    return;
}

// Main

void main (void)
{
    // Set appname
    CopyString(appname,"   GeoLudo   ");

    // Set version number in string variable
    sprintf(version,
            "v%2i.%2i - %c%c%c%c%c%c%c%c-%c%c%c%c",
            VERSION_MAJOR, VERSION_MINOR,
            BUILD_YEAR_CH0, BUILD_YEAR_CH1, BUILD_YEAR_CH2, BUILD_YEAR_CH3,
            BUILD_MONTH_CH0, BUILD_MONTH_CH1, BUILD_DAY_CH0, BUILD_DAY_CH1,
            BUILD_HOUR_CH0, BUILD_HOUR_CH1, BUILD_MIN_CH0, BUILD_MIN_CH1);

    // Setup video mode
    InitVideomode();

    ReinitScreen(appname);
    DrawBoard(0);

    DoMenu(&menuMain);
    DoIcons(icons);

    // Never returns    
    MainLoop();
}