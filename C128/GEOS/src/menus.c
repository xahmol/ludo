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

#pragma code-name ("OVERLAY2");
#pragma rodata-name ("OVERLAY2");
#pragma data-name ("OVERLAY2");
#pragma bss-name ("OVERLAY2");

// Declare config file header
struct fileheader savefileHdr = {
    {0,0},
    {3, 21, 63 | 0x80 },
    {
        0x00,0x00,0x00,0x0E,0x00,0x00,0x1F,0x00,0x00,0x3F,0x80,0x00,0x7F,0xC0,0x00,0x7F,
        0xC0,0x00,0x3F,0x80,0x00,0x1F,0x00,0x00,0x0E,0x07,0xFC,0x1F,0x08,0x02,0x3F,0x92,
        0x09,0x3F,0x97,0x1D,0x7F,0xD2,0x09,0x7F,0xD0,0x41,0x7F,0xD0,0xE1,0x00,0x10,0x41,
        0x00,0x12,0x09,0x00,0x17,0x1D,0x00,0x12,0x09,0x00,0x08,0x02,0x00,0x07,0xFC
    },
    SEQ,
    APPL_DATA,
    SEQUENTIAL,
    0,
    0,
    0,
    {'G','e','o','L','u','d','o',' ',' ',' ',' ',' ','V','0','.','1',0},
    0x40,
    {'X','a','n','d','e','r',' ','M','o','l',0,0,0,0,0,0,0,0,0,0,
     'G','e','o','L','u','d','o',' ',' ',' ',' ',' ','V','0','.','1',0,0,0,0},
    {"GeoLudo save file."}
};

//Save game and config file memory allocation and variables
char savegamemem[136];
char filename[16];

// Functions
unsigned char VDC_DetectVDCMemSize()
{
	// Function to detect the VDC memory size
	// Output: memorysize 16 or 64

	VDC_DetectVDCMemSize_core();
	return VDC_value;
}

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

void savegame(unsigned char autosave) {
// Save game to a gameslot
// Input: autosave is 1 for autosave, else 0

    unsigned char error,x,y;
    char fname[] = "Ludo Savegame  ";
    unsigned int address = (int)&fname;

    if(autosave==1)
    {
        CopyString(filename,"Ludo Autosave");
        DeleteFile(filename);
    }
    else
    {
        // Ask for filename
        if(!monochromeflag) { DialogueClearColor(); }
        if(DlgBoxGetString(filename,15,"Enter name for save game.","(Cancel to abort)") == CANCEL) {
            if(!monochromeflag & gameflag) { DrawBoard(1); }
            return;
        }
        if(!filename[0]) {
            CopyString(filename,"Ludo Savegame");
        }

        // Check if file is already existing
        if(!FindFile(filename) == FILE_NOT_FOUND) {
            if(DlgBoxYesNo("File exists.","Are you sure?") == YES) {
                DeleteFile(filename);
            } else {
                if(!monochromeflag & gameflag) { DrawBoard(1); }
                return;
            }
        }
    }

    CopyString(fname,filename);

    // Store game data to save game memory
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

    closeVLIR();
    
    // Set fileheader
    savefileHdr.n_block.track = (address) & 0xff;
    savefileHdr.n_block.sector = (address>>8) & 0xff;
    savefileHdr.load_address = (int)savegamemem;
    savefileHdr.end_address= (int)savegamemem + 135;

    // Save file to disk
    error = SaveFile(0,&savefileHdr);

    if(error) {
        sprintf(buffer,"Error: %d",error);
        DlgBoxOk("Error saving file.",buffer);
    }

    if(!monochromeflag & gameflag) { DrawBoard(1); };

    openVLIR();
}

void loadgame() {
// Load game
    
    unsigned char error,x,y;
    
    closeVLIR();

    // Select file
    if(!monochromeflag) { DialogueClearColor(); }
    error = DlgBoxFileSelect("GeoLudo",APPL_DATA,filename);
    if (error!= OPEN ) {
        if(error!=CANCEL) {
            sprintf(buffer,"Error: %d",error);
            DlgBoxOk("Error reading directory.",buffer);
        }
        if(!monochromeflag & gameflag) { DrawBoard(1); };
        return;
    }

    // Load game data
    error = GetFile(1,filename,savegamemem,NULL,NULL);

    // Error handling
    if(error) {
        sprintf(buffer,"Error: %d",error);
        DlgBoxOk("Error loading file.",buffer);
        if(!monochromeflag & gameflag) { DrawBoard(1); };
        return;
    }

    openVLIR();

    // Clear board if ongoing game
    if(gameflag) { ClearBoard(); }

    // Retrievibg game data
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
    gameflag = 1;

    DrawBoard(0);    
}

void Switch4080() {
// Switch between 40 and 80 column mode

    SetNewMode();
    ReinitScreen(appname);
    if(gameflag) { DrawBoard(0); }
    if(gameflag==2) { humanchoosepawnstart(); }
    GotoFirstMenu();
    DoMenu(&menuMain);
    drawicon();
    DoIcons(icons);
}

void MonochromeToggle() {
// Set monochrome flag or not

    unsigned char oldflag = monochromeflag;

    if(!monochromeflag&gameflag) { DialogueClearColor(); }
    sprintf(buffer,"Present value: %s",(monochromeflag)?"Yes":"No");
    monochromeflag = (DlgBoxYesNo("Enable monochrome mode?",buffer) == YES)?1:0;

    if(oldflag != monochromeflag & gameflag) { 
        
        mainicons = &noicons;
        icons = mainicons;
        DoIcons(icons);

        ReinitScreen(appname);
        DrawBoard(0);
        if(gameflag==2) { humanchoosepawnstart(); }
        GotoFirstMenu();
        DoMenu(&menuMain);
        drawicon();
        DoIcons(icons);
    } else {
        if(!monochromeflag) { DrawBoard(1); }
    }
}

void AutosaveToggle() {
// Auto save toggle

    if(!monochromeflag&gameflag) { DialogueClearColor(); }
    sprintf(buffer,"Present value: %s",(autosavetoggle)?"Yes":"No");
    autosavetoggle = (DlgBoxYesNo("Enable autosave?",buffer) == YES)?1:0;
    if(!monochromeflag&gameflag) { DrawBoard(1); }
}

void ShowCredits() {
// Show credits

    unsigned char xcoord;

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
}