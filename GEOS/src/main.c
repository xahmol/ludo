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
#include "sidplay.h"

// Global variables
char applicationfilename[21];
char buffer[81];
unsigned char overlay_active = 0;

//Game variables
unsigned char gameflag = 0;
unsigned char musicflag = 0;
unsigned char dicethrows = 0;
unsigned char iconflag = 0;
unsigned char turnofplayernr = 0;
unsigned char noturnpossible = 0;
unsigned char zv = 0;
unsigned char ns = 0;
unsigned char throw;
unsigned char autosavetoggle = 0;
unsigned char pawnpossible[4];
signed char pawnchosen;
signed char as;
unsigned char mp,ap, vr, vl, vn, nr, gv, ov, ro;

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
     position 2: player pattern if monochrome
     position 3: number of pawns at home              */
unsigned char playerdata[4][4] = {
    {0,4,1,4},
    {0,4,10,4},
    {0,4,2,4},
    {0,4,9,4}
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
char playername[4][9] = { "","","","" };

signed char np[4] = { -1, -1, -1, -1};
unsigned char dp[4] = { 8, 8, 8, 8 };

// Bitmaos

// Pawn graphics for filled and patterned monochrome
char pawngraphics[4][] = {
    // Filled pawn - pattern 1
    "\xA0\x01\xC0\x07\xF0\x0F\xF8\x1F"
    "\xFC\x0F\xF8\x07\xF0\x03\xE0\x07"
    "\xF0\x03\xE0\x07\xF0\x0F\xF8\x0F"
    "\xF8\x1F\xFC\x1F\xFC\x1F\xFC\x00"
    "\x00",
    // Pattern 10
    "\xA0\x01\xC0\x07\xF0\x0E\xB8\x1A"
    "\xAC\x0E\xB8\x06\xB0\x03\xE0\x06"
    "\xB0\x03\xE0\x06\xB0\x0E\xB8\x0E"
    "\xB8\x1A\xAC\x1A\xAC\x1F\xFC\x00"
    "\x00",
    // Pattern 2
    "\xA0\x01\xC0\x07\x70\x0D\x58\x1A"
    "\xAC\x0D\x58\x06\xB0\x03\x60\x06"
    "\xB0\x03\x60\x06\xB0\x0D\x58\x0E"
    "\xB8\x1D\x5C\x1A\xAC\x1F\xFC\x00"
    "\x00",
    // Pattern 9
    "\xA0\x01\xC0\x07\x70\x0F\xF8\x18"
    "\x0C\x0F\xF8\x06\x30\x03\xE0\x06"
    "\x30\x03\xE0\x06\x30\x0F\xF8\x0C"
    "\x18\x1F\xFC\x18\x0C\x1F\xFC\x00"
    "\x00"
};

// Pawn graphics for clear, filled and patterned monochrome
char fieldgraphics[5][] = {
    // Clear - pattern 0
    "\x04\x00\x98\x01\x80\x06\x60\x08"
    "\x10\x10\x08\x10\x08\x20\x04\x20"
    "\x04\x10\x08\x10\x08\x08\x10\x06"
    "\x60\x01\x80\x04\x00",
    // Filled - pattern 1
    "\x04\x00\x98\x01\x80\x07\xE0\x0F"
    "\xF0\x1F\xF8\x1F\xF8\x3F\xFC\x3F"
    "\xFC\x1F\xF8\x1F\xF8\x0F\xF0\x07"
    "\xE0\x01\x80\x04\x00",
    // Pattern 10
    "\x04\x00\x98\x01\x80\x06\xE0\x0A"
    "\xB0\x1A\xA8\x1A\xA8\x2A\xAC\x2A"
    "\xAC\x1A\xA8\x1A\xA8\x0A\xB0\x06"
    "\xE0\x01\x80\x04\x00",
    // Pattern 2
    "\x04\x00\x98\x01\x80\x06\xE0\x0D"
    "\x50\x1A\xA8\x15\x58\x2A\xAC\x35"
    "\x54\x1A\xA8\x15\x58\x0A\xB0\x07"
    "\x60\x01\x80\x04\x00",
    // Pattern 9
    "\x04\x00\x98\x01\x80\x07\xE0\x08"
    "\x10\x1F\xF8\x10\x08\x3F\xFC\x20"
    "\x04\x1F\xF8\x10\x08\x0F\xF0\x06"
    "\x60\x01\x80\x04\x00"
};

// Start field graphics
char startfieldgraphics[4][] = {
    // Player 1 - Green
    "\x04\x00\x98\x01\x80\x07\xE0\x0F"
    "\xF0\x1F\x78\x1F\x38\x38\x1C\x38"
    "\x1C\x1F\x38\x1F\x78\x0F\xF0\x07"
    "\xE0\x01\x80\x04\x00",
    // Player 2 - Red
    "\x04\x00\x98\x01\x80\x07\xE0\x0F"
    "\xF0\x1E\x78\x1E\x78\x3E\x7C\x38"
    "\x1C\x1C\x38\x1E\x78\x0F\xF0\x07"
    "\xE0\x01\x80\x04\x00",
    // Player 3 - Blue
    "\x04\x00\x98\x01\x80\x07\xE0\x0F"
    "\xF0\x1E\xF8\x1C\xF8\x38\x1C\x38"
    "\x1C\x1C\xF8\x1E\xF8\x0F\xF0\x07"
    "\xE0\x01\x80\x04\x00",
    // Player 4 - Yellow
    "\x04\x00\x98\x01\x80\x07\xE0\x0F"
    "\xF0\x1E\x78\x1C\x38\x38\x1C\x3E"
    "\x7C\x1E\x78\x1E\x78\x0F\xF0\x07"
    "\xE0\x01\x80\x04\x00"
};

// Dice graphics
char dicegraphics[6][] = {
    // One
    "\xBF\x00\x00\x00\x07\xFF\xE0\x08"
    "\x00\x10\x10\x00\x08\x10\x00\x08"
    "\x10\x00\x08\x10\x00\x08\x10\x00"
    "\x08\x10\x18\x08\x10\x3C\x08\x10"
    "\x3C\x08\x10\x18\x08\x10\x00\x08"
    "\x10\x00\x08\x10\x00\x08\x10\x00"
    "\x08\x10\x00\x08\x08\x00\x10\x07"
    "\xFF\xE0\x00\x00\x00\x00\x00\x00",
    // Two
    "\xBF\x00\x00\x00\x07\xFF\xE0\x08"
    "\x00\x10\x10\x00\xC8\x10\x01\xE8"
    "\x10\x01\xE8\x10\x00\xC8\x10\x00"
    "\x08\x10\x00\x08\x10\x00\x08\x10"
    "\x00\x08\x10\x00\x08\x10\x00\x08"
    "\x13\x00\x08\x17\x80\x08\x17\x80"
    "\x08\x13\x00\x08\x08\x00\x10\x07"
    "\xFF\xE0\x00\x00\x00\x00\x00\x00",
    // Three
    "\xBF\x00\x00\x00\x07\xFF\xE0\x08"
    "\x00\x10\x10\x00\xC8\x10\x01\xE8"
    "\x10\x01\xE8\x10\x00\xC8\x10\x00"
    "\x08\x10\x18\x08\x10\x3C\x08\x10"
    "\x3C\x08\x10\x18\x08\x10\x00\x08"
    "\x13\x00\x08\x17\x80\x08\x17\x80"
    "\x08\x13\x00\x08\x08\x00\x10\x07"
    "\xFF\xE0\x00\x00\x00\x00\x00\x00",
    // Four
    "\xBF\x00\x00\x00\x07\xFF\xE0\x08"
    "\x00\x10\x13\x00\xC8\x17\x81\xE8"
    "\x17\x81\xE8\x13\x00\xC8\x10\x00"
    "\x08\x10\x00\x08\x10\x00\x08\x10"
    "\x00\x08\x10\x00\x08\x10\x00\x08"
    "\x13\x00\xC8\x17\x81\xE8\x17\x81"
    "\xE8\x13\x00\xC8\x08\x00\x10\x07"
    "\xFF\xE0\x00\x00\x00\x00\x00\x00",
    // Five
    "\xBF\x00\x00\x00\x07\xFF\xE0\x08"
    "\x00\x10\x13\x00\xC8\x17\x81\xE8"
    "\x17\x81\xE8\x13\x00\xC8\x10\x00"
    "\x08\x10\x18\x08\x10\x3C\x08\x10"
    "\x3C\x08\x10\x18\x08\x10\x00\x08"
    "\x13\x00\xC8\x17\x81\xE8\x17\x81"
    "\xE8\x13\x00\xC8\x08\x00\x10\x07"
    "\xFF\xE0\x00\x00\x00\x00\x00\x00",
    // Six
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

//Save game and config file memory allocation and variables
char savegamemem[160];
char filename[17];

// Declare function prototypes for icons
void IconclickThrow();
void IconclickNext();

// Interface icontab
struct icontab throwicon = {
    1,
    { 0,0 },
    {
        { iconThrow, 25, 150, 6, 16, (int)IconclickThrow },
    }
};

struct icontab nexticon = {
    1,
    { 0,0 },
    {
        { iconNext, 25, 150, 6, 16, (int)IconclickNext },
    }
};

// Declare functions prototypes that are called when menu items are 
// clicked on and are used in the structs that defines the menus below.
void geosExit();
void geosSwitch4080();
void fileAutosaveToggle();
void gameRestart();
void MonochromeToggle();

// Menu structures with pointers to the menu handlers above
struct menu menuGEOS = {
    // GEOS menu
    { 11, 23, 0, 160 },
    2 | HORIZONTAL,
    {
        { "Switch 40/80", MENU_ACTION, geosSwitch4080 },
        { "Exit", MENU_ACTION, geosExit },
    }
};

struct menu menuGame = {
    // Game menu
    { 11, 23, 0, 160 },
    2 | HORIZONTAL,
    {
        { "(Re)Start", MENU_ACTION, gameRestart },
        { "Color", MENU_ACTION, gameColor },
    }
};

struct menu menuFile = {
    // File menu
    { 11, 23, 0, 160 },
    3 | HORIZONTAL,
    {
        { "Load", MENU_ACTION, fileLoad },
        { "Save", MENU_ACTION, fileSave },
        { "Autosave", MENU_ACTION, fileAutosaveToggle }
    }
};

struct menu menuMain = {
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

// Overlay routine
void overlayerror(unsigned char tyoe,unsigned char overlay) {
// Overlay file loading error message

    char typestring[4][] = {
        "Opening VLIR file",
        "Pointing at record",
        "Reading record",
        "Closing VLIR file"
    };

    sprintf(buffer,"%s %d",typestring[tyoe],overlay);
    if(!monochromeflag & gameflag) { DialogueClearColor(); }
    DlgBoxOk("VLIR file error",buffer);
}

void openVLIR() {
// Opem VLIR records

    if (OpenRecordFile(applicationfilename)) {
        overlayerror(0,0);
        appExit();
    }
}

void closeVLIR() {
// Close VLIR records

    if (CloseRecordFile()) {
        overlayerror(3,0);
        appExit();
    }
}

void loadoverlay(unsigned char overlay_select) {
// Load memory overlay with given number

    // Returns if overlay already active
    if(overlay_select != overlay_active)
    {
        // Point at VLIR RECORD
        if (PointRecord(overlay_select)) {
            overlayerror(1,overlay_select);
            appExit();
        }

        // Read VLIR record
        if (ReadRecord(OVERLAY_ADDR, OVERLAY_SIZE)) {
            overlayerror(2,overlay_select);
            appExit();
        }

        overlay_active = overlay_select;
    }
}

/* Game routines */

unsigned char dicethrow()
{
    /* Throw the dice. Returns the dice value */

    unsigned char dicethrow, x;
    struct iconpic bitmap;

    bitmap.height = 21;
    bitmap.width = 3 | screen_doubleb;
    bitmap.x = 25 | screen_doubleb;
    bitmap.y = 100;

    for(x=0;x<25;x++)
    {
        // Generate random number 1 to 6 for dice throw
        dicethrow = sidRnd(6)+1;

        // Draw selected dice number
        bitmap.pic_ptr = dicegraphics[dicethrow-1];
        BitmapUp(&bitmap);
    }

    return dicethrow;
}

void drawicon() {
// Redraw active icon

    if(iconflag == 1 ) {
        // Show throw icon
        throwicon.tab->x = 25 + screen_doubleb;
        mainicons = &throwicon;
        icons = mainicons;
        DoIcons(icons);
    }
    if(iconflag == 2 ) {
        // Show next icon
        nexticon.tab->x = 25 + screen_doubleb;
        mainicons = &nexticon;
        icons = mainicons;
        DoIcons(icons);
    }
}

void eraseicon() {
// Erase icon

    if(iconflag == 1 ) {
        // Disable throw icon
        mainicons = &noicons;
        icons = mainicons;
        DoIcons(icons);
        SetRectangleCoords(150,165,200 | screen_doublew, 247 | screen_doublew);
        SetPattern(0);
        Rectangle();
    }

    if(iconflag == 2 ) {
        // Diaable next icon
        mainicons = &noicons;
        icons = mainicons;
        DoIcons(icons);
        SetRectangleCoords(150,165,200 | screen_doublew, 247 | screen_doublew);
        SetPattern(0);
        Rectangle();
    }
}

void drawfield(unsigned char track, unsigned char position, unsigned char playernumber, unsigned char coloronly) {
// Draw board fields

    struct iconpic bitmap;
    unsigned char color = 0;
    unsigned char ypos;
    unsigned int xpos;
    bitmap.height = 16;
    bitmap.width = 2 | screen_doubleb;

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
        bitmap.width = 2 | screen_doubleb;
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
    if(!monochromeflag) {
        xpos = xpos * 8;
        ColorRectangle(color,color_background,ypos,ypos+15,xpos,xpos+15+(16*vdc));
    }
}

void pawnerase(unsigned char playernumber, unsigned char pawnnumber)
{
    /* Erase a pawn from the field
       Input playernumber and pawnnumber */

    drawfield(playerpos[playernumber][pawnnumber][0],playerpos[playernumber][pawnnumber][1],playernumber,0);
}

void pawnprint(unsigned char playernumber, unsigned int xpos, unsigned char ypos, unsigned char backcolor, unsigned char coloronly) {
// Print pawn of player at given position

    struct iconpic bitmap;
    unsigned char color = 0;

    bitmap.height = 16;
    bitmap.width = 2 | screen_doubleb;

    if(monochromeflag) {
        bitmap.pic_ptr = pawngraphics[playernumber];
    } else {
        bitmap.pic_ptr = pawngraphics[0];
        color = (vdc)?vdc_color[playernumber+1]:vic_color[playernumber+1];
    }

    if(!coloronly) {
        // Place bitmap
        bitmap.x = xpos;
        bitmap.y = ypos;
        BitmapUp(&bitmap);
    }

    xpos = xpos * 8;

    // Color field
    if(!monochromeflag) {
        if(coloronly == 2) {
            backcolor = (vdc)?VDC_DGREY:DKGREY; 
        }
        ColorRectangle(color,backcolor,ypos,ypos+15,xpos,xpos+15+(16*vdc));
    }

    // Select highlight if relevant
    if(coloronly == 2) {
        SetRectangleCoords(ypos,ypos+15,xpos,xpos+15+(16*vdc));
        FrameRectangle(255);
    }
}

void pawnplace(unsigned char playernumber, unsigned char pawnnumber, unsigned char coloronly) {
// Place a pawn on the field
// Input playernumber and pawnnumber

    unsigned char track, position,ypos;
    unsigned int xpos;

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

    if(vdc) { xpos += xpos; }

    pawnprint(playernumber,xpos,ypos,color_background,coloronly);
}

void DrawPresentplayerinfo(unsigned char coloronly) {
// Draw information for the player whos turn it is

    unsigned char color,width;
    unsigned int xpos;

    if(!coloronly) {
        // Clear area
        SetPattern(0);
        SetRectangleCoords(24,70,200 | screen_doublew, screen_pixel_width);
        Rectangle();
    
        // Print player number
        sprintf(buffer,"Player %d:",turnofplayernr+1);
        PutString(buffer,29,200 | screen_doublew);
    
        // Draw pattern for player
        SetRectangleCoords(24,31, 280 | screen_doublew, 295 | screen_doublew);
        if(monochromeflag) {
            SetPattern(playerdata[turnofplayernr][2]);
            Rectangle();
        }
        FrameRectangle(255);

        // Draw player name
        PutString(playername[turnofplayernr],39,200 | screen_doublew);
    
        // Print computer plays if AI
        if(playerdata[turnofplayernr][0]) {
            PutString("Computer plays",49,200 | screen_doublew);
        }

        // Print if player may throw three times.
        if(dicethrows==3) { 
            PutString("Player may throw 3 times.",59,200 | screen_doublew);
        }
    }

    // Draw color for player
    if(!monochromeflag) {
        color = (vdc)?vdc_color[turnofplayernr+1]:vic_color[turnofplayernr+1];
        xpos = (vdc)?560:280;
        width = (vdc)?31:15;
        ColorRectangle(color_foreground,color,24,31,xpos,xpos+width);
    }
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

    // Player info
    DrawPresentplayerinfo(coloronly);
}

void ClearBoard() {
// Clear game board area

    if(!monochromeflag) {
        ColorRectangle(color_foreground,color_background,24,screen_pixel_height-1,0,screen_pixel_width-1);
    }

    eraseicon();
    SetRectangleCoords(24,screen_pixel_height-1,0,screen_pixel_width-1);
    SetPattern(0);
    Rectangle();
}

void humanchoosepawnstart() {
// Human has to choose a pawn, returns pawnnumber chosen

    unsigned char x;

    PutString("Choose pawn.",49,200 | screen_doublew);

    for(x=0;x<4;x++) {
        if(pawnpossible[x]) { pawnplace(turnofplayernr,x,2); }
    }

    // Set pawn choose mode for mouse handler
    gameflag = 2;
}

void computerchoosepawn() {
/* Computer has to choose a pawn, returns pawnnumber chosen */

    signed int pawnscore[4] = { 0,0,0,0 };
    signed int minimumpawnscore;
    unsigned char nn, no, x,y,z ;

    for(x=0;x<4;x++)
    {
        if(pawnpossible[x]==0)
        {
            pawnscore[x]=-10000;
        }
        else{
            vr=playerpos[turnofplayernr][x][0];
            vn=playerpos[turnofplayernr][x][1];
            nn=vn+throw;
            no=nn;
            nr=vr;
            if(vr==0)
            {
                if(turnofplayernr==0 && nn>39 && vn<40) { nn-=36; nr=1; }
                if(turnofplayernr==1 && nn> 9 && vn<10) { nn-= 6; nr=1; }
                if(turnofplayernr==2 && nn>19 && vn<20) { nn-=16; nr=1; }
                if(turnofplayernr==3 && nn>29 && vn<30) { nn-=26; nr=1; }
            }
            if(nr==0 && nn>39) { nn-=40; }
            if(nr==1 && nn>3 && playerdata[turnofplayernr][1]==1) { pawnscore[x]=10000; x=3; }
            else
            {
                if(nr==1 && nn>3) { pawnscore[x]+=6000; }
                for(y=0;y<4;y++)
                {
                    for(z=0;z<4;z++)
                    {
                        if(turnofplayernr==y && playerpos[y][z][0]==nr && playerpos[y][z][1]==nn) { pawnscore[x]-=8000; }
                        if(turnofplayernr!=y && playerpos[y][z][0]==nr && playerpos[y][z][1]==nn)
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
                        if(playerpos[y][z][0]==0 && nr==0 && turnofplayernr!=y)
                        {
                            if((vn-playerpos[y][z][1])<6 && vn-playerpos[y][z][1]>0) { pawnscore[x]+=400; }
                            if((no-playerpos[y][z][1])<6 && no-playerpos[y][z][1]>0) { pawnscore[x]-=200; }
                            if((playerpos[y][z][1]-nn)<6 && (playerpos[y][z][1]-nn)>0) { pawnscore[x]+=100; }
                        }
                    }
                }
                if(nr==0 && (nn==0 || nn==10 || nn==20 || nn==30)) { pawnscore[x]-=4000; }
                if(vr==0 && (vn==0 || vn==10 || vn==20 || vn==30)) { pawnscore[x]+=2000; }
                if(turnofplayernr==0) { pawnscore[x]+=nn; }
                if(turnofplayernr==1) { pawnscore[x]+=no-10; }
                if(turnofplayernr==2) { pawnscore[x]+=no-20; }
                if(turnofplayernr==3) { pawnscore[x]+=no-30; }
            }
        }
    }
    minimumpawnscore=-20000;
    for(x=0;x<4;x++)
    {
        if(pawnscore[x]>minimumpawnscore && pawnpossible[x]==1) { minimumpawnscore=pawnscore[x]; pawnchosen=x; }
    }
}

unsigned char inputofnames() {
// Enter player nanes

    unsigned char x,ainumber;
    char numberai[2] = "0";
    unsigned int result;
    char aitext[6];

    if(DlgBoxGetString(numberai,1,"Enter number of AI players (0-4)","(RETURN for 0, Cancel to abort}") != CANCEL) {
        ainumber = numberai[0]-48;
    } else { return 0; }

    for(x=0;x<4;x++)
    {
        if(x < (4-ainumber)) {
            playerdata[x][0] = 0;
            CopyString(aitext,"Human");
        } else {
            playerdata[x][0] = 1;
            CopyString(aitext,"AI");
        }
        sprintf(buffer,"Input name for player %d (%s)",x+1,aitext);
        result = DlgBoxGetString(playername[x],8,buffer,"(Leave empty for default name)");
        if(result == CANCEL || !playername[x][0])
        {
            sprintf(playername[x],"%s %d",aitext,x+1);
        }
    }

    return 1;
}

void gamereset() {
// Reset all player data

    unsigned char player,pawn;

    gameflag = 1;
    musicflag = 0;
    dicethrows = 0;
    iconflag = 0;
    turnofplayernr=0;
    for(player=0;player<4;player++) {
        playerdata[player][1]=4;
        playerdata[player][3]=4;
        np[player]=-1;
        dp[player]=8;
        for(pawn=0;pawn<4;pawn++) {
            playerpos[player][pawn][0] = 1;
            playerpos[player][pawn][1] = pawn;
        }
    }

    // Setup random generator and game phase flag
    primeRnd();

    // Draw board
    DrawBoard(0);
}

void startturn() {
// Start a turn

    unsigned char x;

    // Decide how many times player may throw dice
    if(playerdata[turnofplayernr][3]==playerdata[turnofplayernr][1])
    {
        dicethrows = 3;
        for(x=0;x<4;x++)
        {
            if(playerpos[turnofplayernr][x][0]==0)
            {
                dicethrows = 0;
            }
            if(playerpos[turnofplayernr][x][0]==1 && playerpos[turnofplayernr][x][1]<playerdata[turnofplayernr][1]+4 && playerpos[turnofplayernr][x][1]<playerdata[turnofplayernr][1]>3)
            {
                dicethrows = 0;
            }
        }
    }

    DrawPresentplayerinfo(0);

    iconflag = 1;
    drawicon();
    return;
}

// Icon handlers
void IconclickThrow() {
// Player clicked throw icon

    loadoverlay(1);
    turngeneric();
}

void IconclickNext() {
// Next icon clicked

    // Autosave if enabled
    if(playerdata[turnofplayernr][0]==0 && autosavetoggle==1)
    {
        loadoverlay(2);
        savegame(1); /* Autosave on end human turn */
    }
    
    // Diaable next icon
    iconflag = 2;
    eraseicon();
    iconflag = 0;

    // Start next turn
    startturn();
}

// Mouse handler functions

void OtherMousePress() {
// Handler for mouse clicks on other areas than the icons

    unsigned int xmouse = mouseXPos;
    unsigned int ymouse = mouseYPos;
    unsigned char valid = 0;
    unsigned char x, track, position,ypos;
    unsigned int xpos;
    unsigned char width = 16;

    // Don't act on mouse button release
    if ((mouseData & MOUSE_BTN_DOWN) != 0) return;

    // Return if not in pawn choose mode
    if(gameflag != 2) { return; }

    // Check if clicked on valid pawn
    for(x=0;x<4;x++) {
        if(pawnpossible[x]) {
            track = playerpos[turnofplayernr][x][0];
            position = playerpos[turnofplayernr][x][1];

            if(!track)
            {
                xpos = fieldcoords[position][0]*8;
                ypos = fieldcoords[position][1]*8;
            } else {
                xpos = homedestcoords[turnofplayernr][position][0]*8;
                ypos = homedestcoords[turnofplayernr][position][1]*8;
            }

            if(vdc) { xpos += xpos; width = 32; }

            if(xpos<xmouse && xmouse<xpos+width && ypos<ymouse && ymouse<ypos+16) {
                valid = x+1;
            }
        }
    }

    // Return if not clicked on valid pawn
    if(!valid) { return; }

    // Select clcked pawn
    pawnchosen = valid-1;
    gameflag = 1;

    // Give visual clue of click
    SetRectangleCoords(ypos,ypos+15,xpos,xpos+width-1);
    InvertRectangle();
    InvertRectangle();

    // Disable highlights
    for(x=0;x<4;x++)
    {
        if(pawnpossible[x]) {
            pawnplace(turnofplayernr,x,0);
        }
    }

    // Erase text
    SetRectangleCoords(40,50,200 | screen_doublew,screen_pixel_width-1);
    SetPattern(0);
    Rectangle();

    // Continue with oawn placement
    loadoverlay(1);
    pawnselect();
}

// Menu functions
void appExit() {
// Clean up video mode on exit

    if(!monochromeflag) {
        if(vdc) { SetColorMode(VDC_CLR0); }
        else {
            ColorRectangle(color_foreground,color_background,24,screen_pixel_height-1,0,screen_pixel_width-1);
        }
    }

    closeVLIR();

    EnterDeskTop();    
}

void geosSwitch4080() {
// Switch 40/80 selected from menu

    if(musicflag & !gameflag) { StopMusic(); }
    loadoverlay(2);
    SetNewMode();
    ReinitScreen(appname);
    if(gameflag) { DrawBoard(0); } else { ShowCredits(1); }
    if(gameflag==2) { humanchoosepawnstart(); }
    GotoFirstMenu();
    DoMenu(&menuMain);
    drawicon();
    DoIcons(icons);
    if(musicflag & !gameflag) { loadoverlay(3); PlayMusic(); }
    return;
}

void geosExit() {
// Exit to desktop

    ReDoMenu();

    if(musicflag & !gameflag) { StopMusic(); }    

    // Ask confirnation
    if(!monochromeflag) { DialogueClearColor(); }
    if (DlgBoxOkCancel("Exit to desktop", "Are you sure?") == OK)
    {
        appExit();
    }
    else
    {
        if(!monochromeflag) {
            if(gameflag) { DrawBoard(1); } else {
                loadoverlay(2);
                ShowCredits(2);
            }
        }
        if(musicflag & !gameflag) { loadoverlay(3); PlayMusic(); }
        return;
    }  
}

void gameRestart() {
// Start or restart game

    ReDoMenu();
    if(musicflag & !gameflag) { StopMusic(); }
    if(!monochromeflag) { DialogueClearColor(); }

    if(gameflag) {
        // Restart instead of initial start
        if (DlgBoxOkCancel("Restart game", "Are you sure?") != OK)
        {
            if(!monochromeflag) { DrawBoard(1); }
            return;
        }  
    }

    if(inputofnames()) {
        ClearBoard();
        gamereset();
        startturn();
    } else {
        if(gameflag) {
            if(!monochromeflag) { DrawBoard(1); }
        } else {
            appExit();
        }
    }
    return;
}

void gameColor() {
// Color option selected from menu

    unsigned char oldflag = monochromeflag;

    ReDoMenu();

    if(musicflag & !gameflag) { StopMusic(); }
    if(!monochromeflag) { DialogueClearColor(); }
    sprintf(buffer,"Present value: %s",(monochromeflag)?"Yes":"No");
    monochromeflag = (DlgBoxYesNo("Enable monochrome mode?",buffer) == YES)?1:0;

    if(oldflag != monochromeflag) { 
        
        mainicons = &noicons;
        icons = mainicons;
        DoIcons(icons);
        loadoverlay(2);
        ReinitScreen(appname);
        if(gameflag) { DrawBoard(0); } else { ShowCredits(1); }
        if(gameflag==2) { humanchoosepawnstart(); }
        GotoFirstMenu();
        DoMenu(&menuMain);
        drawicon();
        DoIcons(icons);
    } else {
        if(!monochromeflag) {
            if(gameflag) { DrawBoard(1); } else {
                loadoverlay(2);
                ShowCredits(2);
            }
        }
    }

    if(musicflag & !gameflag) { loadoverlay(3); PlayMusic(); }
    return;
}

void fileLoad() {
// Select load file from menu

    ReDoMenu();
    if(musicflag & !gameflag) { StopMusic(); }
    loadoverlay(2);
    loadgame();
    return;
}

void fileSave() {
// Select save file from menu

    ReDoMenu();
    if(!gameflag) { return; }
    loadoverlay(2);
    savegame(0);
    return;
}

void fileAutosaveToggle() {
// Select autosave toogle from menu

    ReDoMenu();
    
    if(musicflag & !gameflag) { StopMusic(); }
    if(!monochromeflag) { DialogueClearColor(); }
    sprintf(buffer,"Present value: %s",(autosavetoggle)?"Yes":"No");
    autosavetoggle = (DlgBoxYesNo("Enable autosave?",buffer) == YES)?1:0;
    if(!monochromeflag) {
        if(gameflag) { DrawBoard(1); } else {
            loadoverlay(2);
            ShowCredits(2);
        }
    }
    if(musicflag & !gameflag) { loadoverlay(3); PlayMusic(); }
    return;
}

void informationCredits (void) {
// Select show credits from menu
    
    ReDoMenu();
    if(musicflag & !gameflag) { StopMusic(); }
    loadoverlay(2);
    ShowCredits(0);
    return;
}

// Main

void main(int /*argc*/, char *argv[])
{
    CopyString(applicationfilename,argv[0]);

    // Open VLIR at record 0
    openVLIR();

    // Set at exit hook
    atexit(&appExit);

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
    loadoverlay(2);
    InitVideomode();
    ReinitScreen(appname);

    // Set game flag'
    gameflag = 0;

    // Shpw splashscreen
    ShowCredits(1);

    // Start music
    if(!(osType&GEOS4)) {
        musicflag = 1;
        loadoverlay(3);
        PlayMusic();
    } else {
        musicflag = 0;
    }

    DoMenu(&menuMain);
    DoIcons(icons);

    // Set mouse handler vector
    otherPressVec = OtherMousePress;
    
    // Never returns    
    MainLoop();
}