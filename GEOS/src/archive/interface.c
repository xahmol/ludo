/*
GeoUTools
GUI interface elements
Written in 2023 by Xander Mol

https://github.com/xahmol/GeoUTools

https://www.idreamtin8bits.com/

Code and resources from others used:

-   Scott Hutter - Ultimate II+ library and GeoUTerm:
    https://github.com/xlar54/ultimateii-dos-lib/
    (library for the UII+ UCI functions. And GeoUTerm as GEOS sample application using this)

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

-   ntp2ultimate by MaxPlap: code for obtaining time via NTP
    https://github.com/MaxPlap/ntp2ultimate

-   Heureks: GEOS64 Programming Examples
    https://codeberg.org/heurekus/C64-Geos-Programming
    (sample code using C in CC65 for writing applications in GEOS)

-   Lyonlabs / Cenbe GEOS resources page:
    https://www.lyonlabs.org/commodore/onrequest/geos/index.html
    Including using code from:
    https://www.lyonlabs.org/commodore/onrequest/geos/geos-prog-tips.html

-   Bo Zimmerman GEOS resources page:
    http://www.zimmers.net/geos/

-   CVM Files GEOS disk images
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
#include <conio.h>
#include "defines.h"
#include "interface.h"

// Global variables
char version[25];
unsigned char monochromeflag = 0;
unsigned char screen_colormode = VDC_CLR2;
unsigned int screen_pixel_width;
unsigned char screen_pixel_height;
unsigned char screen_doubleb;
unsigned int screen_doublew;
unsigned char color_foreground;
unsigned char color_background;
unsigned short hdrY = 0;
unsigned char osType = 0;
unsigned char vdc = 0;
unsigned char vdcsize = 0;
unsigned char modelines[4] = {22,25,50,100};
unsigned char cardheigth[4] = {8,8,4,2};
char appname[21];

// VIC to Plus/4 TED color and luminance conversion
unsigned char ted_color[16][2] = {
    { TED_BLACK,        0 },    //  0 Black
    { TED_WHITE,        7 },    //  1 White
    { TED_RED,          3 },    //  2 Red
    { TED_CYAN,         7 },    //  3 Cyan
    { TED_VIOLET,       0 },    //  4 Purple
    { TED_GREEN,        5 },    //  5 Green
    { TED_BLUE,         2 },    //  6 Blue
    { TED_YELLOW,       7 },    //  7 Yellow
    { TED_ORANGE,       7 },    //  8 Orange
    { TED_BROWN,        7 },    //  9 Brown
    { TED_RED,          7 },    // 10 Lightred
    { TED_WHITE,        1 },    // 11 Dark grey
    { TED_WHITE,        3 },    // 12 Grey
    { TED_LIGHTGREEN,   7 },    // 13 Light green
    { TED_LIGHTBLUE,    7 },    // 14 Light blue
    { TED_WHITE,        6 }     // 15 Light grey
};

unsigned char ted_lum[16] = { 0,7,4,7,7,0,7,7,7,7,7,1,3,7,7,5 };

// Window definitions
struct window *winMain;
struct window *winHeader;
struct window *winInterface;
struct window *winIntShadow;
struct window *winIntRecover;

struct window vic_winHdr = {0, 12, 200, SC_PIX_WIDTH-1 };
struct window vic_winMain = {12, SC_PIX_HEIGHT-1, 0, SC_PIX_WIDTH-1};
struct window vic_winInt = {50,150,10,310};
struct window vic_winShd = {58,158,18,318};
struct window vic_winRec = {50,158,10,318};

struct window vdc_winHdr = {0, 12, 400, SCREENPIXELWIDTH-1 };
struct window vdc_winMain = {12, SC_PIX_HEIGHT-1, 0, SCREENPIXELWIDTH-1};
struct window vdc_winInt = {50,150,120,520};
struct window vdc_winShd = {58,158,136,536};
struct window vdc_winRec = {50,158,120,536};

// Icons
char IconOK[] = {
	0x05, 0xFF, 0x82, 0xFE, 0x80, 0x04, 0x00, 0x82,
	0x03, 0x80, 0x04, 0x00, 0xB8, 0x03, 0x80, 0x00,
	0xF8, 0xC6, 0x00, 0x03, 0x80, 0x01, 0x8C, 0xCC,
	0x00, 0x03, 0x80, 0x01, 0x8C, 0xD8, 0x00, 0x03,
	0x80, 0x01, 0x8C, 0xF0, 0x00, 0x03, 0x80, 0x01,
	0x8C, 0xE0, 0x00, 0x03, 0x80, 0x01, 0x8C, 0xF0,
	0x00, 0x03, 0x80, 0x01, 0x8C, 0xD8, 0x00, 0x03,
	0x80, 0x01, 0x8C, 0xCC, 0x00, 0x03, 0x80, 0x00,
	0xF8, 0xC6, 0x00, 0x03, 0x80, 0x04, 0x00, 0x82,
	0x03, 0x80, 0x04, 0x00, 0x81, 0x03, 0x06, 0xFF,
	0x81, 0x7F, 0x05, 0xFF
};

struct icontab *icons;
struct icontab *mainicons;
struct icontab *winOK;

struct icontab noicons = {
    1,
    { 0,0 },
    { 0, 0, 0, 1, 1, 0 }
};

struct icontab vic_winOK = {
    1,
    { 0,0 },
    { IconOK, 31, 130, 6, 16, (int)CloseWindow }
};

struct icontab vdc_winOK = {
    1,
    { 0,0 },
    { IconOK, 58, 130, 6, 16, (int)CloseWindow }
};

// Screen functions

void InitVideomode() {
// Initialise videomode based on OS, screenmode and VDC size detected


    // Get default color
    color_foreground = BLACK;
    color_background = LTGREY;

    // Get host OS type
    osType = get_ostype();
    if ((osType & GEOS128) == GEOS128)  {
        vdcsize = VDC_DetectVDCMemSize();
    }
}

void SetRectangleCoords(unsigned char top, unsigned char bottom, unsigned int left, unsigned int right) {
// Set the co-ordinates to use for rectangle functions

    drawWindow.top = top;
    drawWindow.bot = bottom;
    drawWindow.left = left;
    drawWindow.right = right;
}

int StringLength (char* inputstring) {
// Return the length of a string in pixels in the presently used font

    unsigned char x;
    unsigned char lengthchar = strlen(inputstring);
    unsigned int lengthpixel = 0;

    for(x=0;x<lengthchar;x++) { lengthpixel += GetCharWidth(inputstring[x]); }

    return lengthpixel;
}

void PutStringCentered(char* inputstring, unsigned char bottom, unsigned int left, unsigned int right) {
// Print a string centered in the given area co-ordinates

    unsigned int width = StringLength(inputstring);
    if(right-left>width)
    {
        PutString(inputstring,bottom,((left+right)/2)-(width/2));
    }
}

void PutStringRight(char* inputstring, unsigned char bottom, unsigned int left, unsigned int right) {
// Print a string right aligned in the given area co-ordinates

    unsigned int width = StringLength(inputstring);
    if(right-left>width)
    {
        PutString(inputstring,bottom,right-width);
    }
}

int CreateWindow() {
// Creates a window at the default co-ordinates given the mode (40/80 column) used
// Returns the x co-ordinate for output to this window

    unsigned int xcoord = 0;

    // Disable menus to avoid unwanted interference
    mouseOn = SET_MSE_ON + SET_ICONSON;

    // Set co-ordinates based on which screen mode (40/80) is used
	if (vdc)
	{
		// == 0x80 - 80 col mode
		winInterface = &vdc_winInt;
        winIntShadow = &vdc_winShd;
        winIntRecover = &vdc_winRec;
        winOK = &vdc_winOK;
        xcoord = 130;
	}
    else
    {
        winInterface = &vic_winInt;
        winIntShadow = &vic_winShd;
        winIntRecover = &vic_winRec;
        winOK = &vic_winOK;
        xcoord = 20;
    }

    // Clear color
    if(!monochromeflag) {
        ColorRectangle(color_foreground,color_background,winIntRecover->top,winIntRecover->bot,winIntRecover->left,winIntRecover->right);
    }

    // Draw window, shadow and frame
    dispBufferOn = ST_WR_FORE;
    SetPattern(1);
    InitDrawWindow (winIntShadow);
    Rectangle();  // Shadow
    SetPattern(0);
    InitDrawWindow (winInterface);
    Rectangle();  // Window
    FrameRectangle(255);    // Frame

    // Returns the x co-ordinate for output to this window
    return xcoord;
}

void WinOKButton() {
// Shows OK button to end a dialogue window

    // Shows OK icon and enables icons
    icons = winOK;
    DoIcons(icons);
}

void CloseWindow() {
// Closes the last opened window and recovers background

    // Enable menus again
    mouseOn = SET_MSE_ON + SET_MENUON + SET_ICONSON;

    // Clear OK icon
    icons = mainicons;
    DoIcons(icons);

    // Recover background
    if(!monochromeflag & gameflag) { DrawBoard(1); }
    InitDrawWindow (winIntRecover);
    dispBufferOn = ST_WR_FORE + ST_WR_BACK;
    RecoverRectangle();
}

void ReinitScreen(char *s) {
// Initialise main screen
// Input:   App name as string s

    unsigned char colormode = (monochromeflag)?VDC_CLR0:VDC_CLR2;

    screen_pixel_height = 200;

    // Set co-ordinates based on which screen mode (40/80) is used
	if ((osType & GEOS64) == GEOS64 || osType & GEOS4) // c64 or Plus/4
	{
		screen_pixel_width = SC_PIX_WIDTH;
		winHeader = &vic_winHdr;
		winMain = &vic_winMain;
		hdrY = 200;
		vdc = 0;
        screen_doubleb = 0;
        screen_doublew = 0;
	}

	if ((osType & GEOS128) == GEOS128) // c128
	{

        screen_doubleb = DOUBLE_B;
        screen_doublew = DOUBLE_W;
		if((graphMode & 0x80) == 0x00)
		{
			// 40 col mode
			screen_pixel_width = SC_PIX_WIDTH;
			winHeader = &vic_winHdr;
			winMain = &vic_winMain;
			hdrY = 200;
			vdc = 0;
		}
		else if((graphMode & 0x80) == 0x80)
		{
			// == 0x80 - 80 col mode
			screen_pixel_width = SCREENPIXELWIDTH;
			winHeader = &vdc_winHdr;
			winMain = &vdc_winMain;
			hdrY = 400;
			vdc = 1;
            if(vdcsize<64) { colormode=VDC_CLR0; monochromeflag=1; }
            color_background = VDC_LGREY;
		}
	}

    // Set colormode
    screen_colormode = colormode;
    if(vdc) { 
        SetColorMode(colormode);
    } else {
        if(osType & GEOS4) {
            // Fill luminance
            FillRam((void*)ColorAddress(0,0),(ted_color[color_background][1]*16)+ted_color[color_foreground][1],1000);
            // Fill color
            FillRam((void*)(ColorAddress(0,0)+1024),(ted_color[color_foreground][0]*16)+ted_color[color_background][0],1000);
        } else {
            FillRam((void*)ColorAddress(0,0),(color_foreground*16)+color_background,1000);
        }
    }

    // Clear icons
    mainicons = &noicons;
    icons = mainicons;
	
    // Clear main screen
    SetPattern(2);
    SetRectangleCoords(0,screen_pixel_height-1,0,screen_pixel_width-1);
    Rectangle();
	SetPattern(0);
	InitDrawWindow (winMain);
	Rectangle();

    // Draw header
	SetPattern(0);
	InitDrawWindow (winHeader);
	Rectangle();
	HorizontalLine(255, 0, hdrY, screen_pixel_width-1);
	HorizontalLine(255, 3, hdrY, screen_pixel_width-1);
	HorizontalLine(255, 5, hdrY, screen_pixel_width-1);
	HorizontalLine(255, 7, hdrY, screen_pixel_width-1);
	HorizontalLine(255, 10, hdrY, screen_pixel_width-1);
    HorizontalLine(255, 12, 0, screen_pixel_width-1);
	
    // Draw application name
	UseSystemFont();
	PutStringCentered (s, 9, hdrY,screen_pixel_width-1);
}

unsigned char VDC_DetectVDCMemSize()
{
	// Function to detect the VDC memory size
	// Output: memorysize 16 or 64

	VDC_DetectVDCMemSize_core();
	return VDC_value;
}

void VDC_FillArea(unsigned int startaddress, unsigned char character, unsigned char length, unsigned char height)
{
	// Function to draw area with given value (draws from topleft to bottomright)
	// Input: startaddress of start position (topleft), value to draw line with,
	//		  length and height in number of character positions

	VDC_addrh = (startaddress>>8) & 0xff;	// Obtain high byte of start address
	VDC_addrl = startaddress & 0xff;		// Obtain low byte of start address
	VDC_tmp1 = character;					// Obtain character value
	VDC_tmp2 = length-1;  					// Obtain length value
	VDC_tmp4 = height;						// Obtain number of lines

	VDC_FillArea_core();
}

void VIC_FillArea(unsigned int startaddress, unsigned char character, unsigned char length, unsigned char height)
{
	// Function to draw area with given value (draws from topleft to bottomright)
	// Input: startaddress of start position (topleft), value to draw line with,
	//		  length and height in number of character positions

	r1          = startaddress;                 // Load start address
	VDC_tmp1    = character;					// Obtain character value
	VDC_tmp2    = length;  					    // Obtain length value
	VDC_tmp4    = height;						// Obtain number of lines

	VIC_FillArea_core();
}

unsigned int ColorAddress(unsigned int xcoord, unsigned char ycoord) {
// Function to get color address for given card coordinate

    unsigned int address;

    // Return if monochrome VDC
    if(!screen_colormode && vdc) { return 0; }

    // Get base address of color matrix based on video mode
    if(vdc)
    {
        // C128 VDC mode
        address = (screen_colormode>VDC_CLR1)?0x4000:0x3880;
        address += (ycoord / cardheigth[screen_colormode-1])*80;
    }
    else {
        if(osType & GEOS4) {
            // Plus/4
            address = 0x9800;
        } else {
            // C64 and C128 VIC-II mode
            address = 0x8c00;
        }
        address += ((ycoord/8)*40);
    }

    address += xcoord / 8;

    return address;
}

void ColorRectangle(unsigned char foreground, unsigned char background, unsigned char top, unsigned char bottom, unsigned int left, unsigned int right) {
// C function calling the GEOS v2 ColorRectangle function that is not included in GEOSLib for CC65

    unsigned char width;
    unsigned char height;

    width = ((right-left)/8)+1;

    if(osType & GEOS128 ) {
        if(vdc && width>1 ) {
            height = ((bottom-top)/cardheigth[screen_colormode-1])+1;
            VDC_FillArea(ColorAddress(left,top),background + (foreground*16),width,height);
        } else {
            r2L     = top;
            r2H     = bottom;
            r3      = left;
            r4      = right;
            a_tmp   = background + (foreground*16);
            ColorRectangleCore();
        }
    } else {
        height = ((bottom-top)/8)+1;
        if(osType & GEOS4) {
            // Fill luminance
            VIC_FillArea(ColorAddress(left,top),ted_color[foreground][1] + (ted_color[background][1]*16),width,height);
            // Fill color
            VIC_FillArea(ColorAddress(left,top)+1024,ted_color[background][0] + (ted_color[foreground][0]*16),width,height);
        } else {
            VIC_FillArea(ColorAddress(left,top),background + (foreground*16),width,height);
        }
    }
}

void SetColorMode(unsigned char colormode) {
// C function calling the GEOS v2 SetColorMode function that is not included in GEOSLib for CC65

    unsigned char lines;

    // Only works in C128 80 column mode, so return if this mode is not detected
    if(!vdc) { return; }

    // Set colormode
    a_tmp = colormode;
    SetColorModeCore();
    screen_colormode=colormode;

    // Clear colors with defaults if not monochrome
    if(colormode) {
        lines = modelines[colormode-1];
        VDC_FillArea(ColorAddress(0,0),color_background+(16*color_foreground),80,lines);
    }
}

void ColorCardSet(unsigned int xcoord, unsigned char ycoord, unsigned char foreground, unsigned char background ) {
// C function calling the GEOS v2 ColorCard function that is not included in GEOSLib for CC65 with carry set to set color

    r3      = xcoord;
    r11L    = ycoord;
    a_tmp   = background + (foreground*16);

    ColorCardSetCore();
}

unsigned char ColorCardGet(unsigned int xcoord, unsigned char ycoord) {
// C function calling the GEOS v2 ColorCard function that is not included in GEOSLib for CC65 with carry clear to get color

    r3      = xcoord;
    r11L    = ycoord;
    ColorCardGetCore();
    return a_tmp;
}

void DialogueClearColor() {
// Function to wipe color for dialogue box

    unsigned int left = DEF_DB_LEFT;
    if(osType & GEOS4) { left-=16; }

    if(vdc) {
        ColorRectangle(color_foreground,color_background,DEF_DB_TOP,DEF_DB_BOT+8,left*2,DEF_DB_RIGHT*2+16);
    } else {
        ColorRectangle(color_foreground,color_background,DEF_DB_TOP,DEF_DB_BOT+8,left,DEF_DB_RIGHT+8);
    }

}

unsigned int sidRnd(unsigned int limit) {
// Function to generate a random number between 0 and limit-1
// Generate from SID noise if possible to get more 'random' numbers

    if(osType&GEOS4) {
        // Plus/4 has no SID, so get number from standard GetRandom
        return GetRandom()%6;
    } else {
        // Get random number generated from SID noise
        r2  =   limit;
        sidRndCore();
        return r1;
    }
}