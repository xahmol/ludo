# GeoLudo
Ludo game for 8 bit computers, GEOS edition

Written in 2023 by Xander Mol

## Contents
[Version history and download](#version-history-and-download)

[Known issues and bugs](#known-issues-and-bugs)

[Introduction](#introduction)

[Prerequisites](#prerequisites)

[Features](#features)

[Screenshots](#screenshots)

[Game rules](#game-rules)

[Explanation of menu functions](#explanation-of-menu-functions)

[Credits](#credits)


![GeoLudo main interface on C128 VDC mode with 64 Kb VDC RAM](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-game-128vdc64.png)

## Version history and download
([Back to contents](#contents))

[Link to latest build](https://github.com/xahmol/ludo/raw/main/GEOS/GeoLudo-v01-20230302-1343.zip)

Version 01-20230302-1343:
- First public alpha version

## Known issues and bugs
([Back to contents](#contents))
- Application crashes on exit in Commodore Plus/4 GEOS 3.5

## Introduction
([Back to contents](#contents))

GeoLudo is based on a Ludo variant that I programmed in BASIC for the Commodore 128 80 column mode in 1992. See [here](https://github.com/xahmol/ludo/tree/main/C128/BASIC%20Original) for this original version (note: start game in 80 column mode, in 40 column mode it just shows a blank screen after start).

The game uses the LUDO rules from the Dutch 'Mens Erger je Niet' variant as played by my family 30 years ago, so probably there are some 'house rules' interpretations that are not the same as the present official game manual, like what is allowed after a six is thrown depending on how many pawns are already on the board. Example: after throwing a six, moving the newly placed pawn with the next dice throw is obligatory, also if this would attack another pawn of the same player. Exception is if all pawns are on the board, moving the new pawn is in that case optional. As the game only allows valid moves, this should indicate itself.

Please let me know if the game interpretations are inconsistent, incorrect or not working.

The GEOS adaption is based on my C ports of this original game for the [Oric Atmos](https://github.com/xahmol/ludo/tree/main/Oric%20Atmos/CC65), [Commodore 128](https://github.com/xahmol/ludo/tree/main/C128/CC65) and [TI-99/4a](https://github.com/xahmol/ludo/tree/main/TI994a).

Enjoy!

## Prerequisites
([Back to contents](#contents))

GeoLudo is designed to work on any GEOS version on Commodore 128, Commodore 64 or Commodore Plus/4.

It has been tested on:
- Commodore 64 with GEOS64 version 2.0
- Commodore 128 with GEOS128 version 2.0 on both a 16KB and a 64 KB VDC RAM machine. Tested in both 40 and 80 column mode operation.
- Commodore Plus/4 with GEOS3.5 with YAPE emulation as a 1551 drive is needed. Enable CPU exact 1551 emulation in YAPE.

Color mode is supoorted:
- Commodore 128: VIC-II 40 column mode
- Commodore 128: VDC mode only if 64 KB VDC RAM is available
- Commodore 64
- Commodore Plus/4

(Reason for not supporting color in VDC 80 column mode on 16 Kb VDC memory C128 machines is that 16 Kb video RAM with color only allows for a 176 lines resolution under GEOS. And I could not fit the gameboard and the menus in that limited vertical resolution, also because color change is only possible per 8 lines in that mode)

GEOS images can be downloaded from:
- C64 and C128 versions: https://cbmfiles.com/geos/geos-13.php
- Plus/4 version: http://plus4world.powweb.com/software/GEOS_3_5

## Features
([Back to contents](#contents))

Multiplatform:
- the same executable works on GEOS variants on Commodore 128, Commodore 64 and Commodore Plus/4

Interface:
- Color suppport: the game works in color on all platforms and modes apart from the VDC 80 column mode on a C128 with only 16 Kb VDC memory. On 64 Kb VDC memory color is supported. If color is supported is detected by the game itself.
- Option to play in monochrome as in game option
- Option to switch between 40 and 80 column mode on a C128.

Title music:
- Title music is played on the splash screen on a C64 and C128 (not supported for Plus/4)

Save game support:
- Saving and loading of a game is supported
- Autosave option can be enabled (default off as the downside is notable extra delay due to disk access before every human turn)

Full source code available at https://github.com/xahmol/ludo/tree/main/GEOS

## Screenshots
([Back to contents](#contents))

### Commodore 128 with 64 Kb VDC RAM

(Screenshots made using VICE x128, as I have not hooked up my C128DCR to a capture device)

VDC 80 column mode:

![C128 64Kb VDC Splash](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-splash-128vdc64.png)
![C128 64Kb VDC Main screen](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-game-128vdc64.png)

### Commodore 128 with 16 Kb VDC RAM

(Screenshots made from real iron C128D)

VDC 80 column mode:

![C128 16Kb VDC Splash](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-splash-128vdc16.png)
![C128 16Kb VDC Main screen](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-game-128vdc16.png)

VIC-II 40 column mode color:

![C128 VIC Splash](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-splash-128vic.png)

VIC-II 40 column mode monochrome:

![C128 VIC Main screen](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-game-128vic.png)

### Commodore 64

(Screenshots made from Ultimate 64)

Color mode:

![C64 Splash](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-splash-c64.png)
![C64 Main screen](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-game-c64.png)

Monochrome mode:

![C64 Main screen](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-game-c64mono.png)

### Commodore Plus/4

(Screenshots made with the YAPE emulator, as I do not own a real 1551 needed to run GEOS 3.5 for Plus/4)

Color mode:

![C64 Splash](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-splash-plus4.png)
![C64 Main screen](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-game-plus4.png)

Monochrome mode:

![C64 Main screen](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-game-plus4mono.png)

## Game rules
([Back to contents](#contents))

### Gameplay

- 4 players begin with their respective pieces in their bases. On each player’s turn, the player rolls the die to determine a move. The goal of the game is to move all four of the player’s pieces clockwise once around the board, up to the destination column.

### Movement
- To begin, a player must roll a six to move a piece out of the base and onto the start position. That piece is then in play. The player cannot make any other moves until at least one piece is in play.
- If a player has a piece or pieces in play, they can move any one of their pieces 1 to 6 spaces along the path according to the number they roll.

### Throwing sixes

- If all pieces are either in the home base of the player, or are in the destination column without any possible movement left, a player is entitled to try up to three times throwing a six.
- If a six is rolled and pawns are still left in the home base, the player has to place a new pawn at its start field. The player has to move this pawn with the next throw, unless no pawns are left in the homebase.
- Anytime a six is rolled, the player gets an extra roll after his move.

### Landing on a shared square

- If a player’s piece lands on an opponent’s piece, the opponent’s piece is sent back to their base where he must roll a six again in order move it out onto the starting square.

### Winning the Game

- When a player’s piece has reached the destination column of its own color, the piece continues its moves toward the end of the destination column.- A pawn can not pass another pawn in the destination column. First move the blocking pawn as far as possible.
- If a pawn can not enter the destination column with the number thrown, the turn passes.
- The first player to have all four of his pieces finish their journeys wins. The remaining players may continue the game to determine the runner-ups.

## Explanation of interface and menu functions
([Back to contents](#contents))

### Start from splash screen

![Splash screen](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-splash-128vdc64.png)

From the splash screen, either start a new game via the Game menu, option (Re)Start, or load a previously saved game via the File menu, Load option.

## Starting a new game

On starting a new game (with Game>(Re)Start game), first a dialogue will ask how many players should be played by the computer AI. Enter a number between 0 and 4. Cancel will abort starting a game.

![Number of AI players dialogue](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-ainumber.png)

After that, dialogues will pop-up to ask to enter a name for each player. Leaving the input empty on entering, or clicking Cancel, will name the player with a default name.

![Enter player names dialogue](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-enternames.png)

After this, the game will start.

### Throw icon: Throw the dice on player turn

To throw the dice, press the Throw icon.

![Throw icon](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-throw.png)

### Next icon: Go to the turn of the next player

To proceed to the turn of the next player, click the Next icon.

![Next icon](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-next.png)

### Player wins dialogue

After a player has reached the destination column with all four pawns, that player wins. Choose in the dialogue popping up to proceed to play with the remaining players, or end the game and return to the start interface.

On returning to the start interface, the splash screen information will not be shown again. From here choose GEOS>Exit to exit to the GEOS desktop, Game>(Re)Start to start a new game or File>Load to load a saved game.

![Player wins](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-playerwon.png)

### GEOS menu

![GEOS menu](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-GEOSmenu.png)

**Switch 40/80**

Switches between the 40 column VIC-II mode and the 80 column VDC mode on a Commodore 128. Only does something on a C128.

**Exit**

Exit to GEOS desktop. A confirmation dialogue pops up first: click OK to exit, Cancel to cancel exiting.

### Game menu

![Game menu](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-gamemenu.png)

**(Re)Start**

Choose this to start a game after starting the application, or restart a new game and loose the running game.

If a game is in progress a dialogue pop-up will ask you if you are sure, as the old game will be lost. Choose OK to proceed, or Cancel to cancel.

![Restart confirmation dialogue](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-restart-confirm.png)

**Color**

Choose whether to enable monochrome mode (choose Yes) or color mode (choose No).

Will not do anything on a C128 in VDC 80 column mode on machines with only 16 Kb VDC RAM, as color mode is not supported in that mode on those machines.

![Monochrome mode dialogue](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-monochrome.png)

### File menu

![File menu](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-filemenu.png)

**Load**

Load a game that is selected via a file picker dialogue. The dialogue will show valid save game files on the present disk.

*Note*: The disk icon is not (yet) implemented, only loading save games from the present active drive is supported.

![Load dialogue](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-load.png)

**Save**

Save the present game to disk with the user provided filename. Enter the filename. Press ENTER to complete, or Cancel to cancel. Entering with no input provided will save with a default filename.

![Sace dialogue](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-save.png)

**Autosave**

Choose whether to enable autosave mode (choose Yes) or disable it (choose No). In autosave mode, the game will be saved automatically with the name Ludo Autosave before every human player turn. This will prevent possible game progress loss in case of system failure, but will also slow down the game due to the disk access needed.
By default, autosave is disabled to allow for faster gameplay in default mode.

![Autosave dialogue](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-autosave.png)

### Credits menu

Clicking this will show the game version and game information.

![Credits](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-credits.png)


## Credits
([Back to contents](#contents))

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

-   Hitchhikers Guide to GEOS v2022
    Berkeley Softworks / Paul B Murdaugh
    https://github.com/geos64128/HG2G2022

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

Music credit:
- Avicii - Hey Brother (Universal) https://en.wikipedia.org/wiki/Hey_Brother

Licensed under the GNU General Public License v3.0

The code can be used freely as long as you retain
a notice describing original source and author.

THE PROGRAMS ARE DISTRIBUTED IN THE HOPE THAT THEY WILL BE USEFUL,
BUT WITHOUT ANY WARRANTY. USE THEM AT YOUR OWN RISK!
