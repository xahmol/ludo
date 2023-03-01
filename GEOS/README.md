# GeoLudo
Ludo game for 8 bit computers, GEOS edition

Written in 2023 by Xander Mol

## Contents
[Version history and download](#version-history-and-download)

[Known issues and bugs](#known-issues-and-bugs)

[Introduction](#introduction)

[Screenshots](#screenshots)

[Credits](#credits)

![GeoLudo main interface on C128 VDC mode with 64 Kb VDC RAM](https://raw.githubusercontent.com/xahmol/ludo/main/GEOS/screenshots/ludo-game-128vdc64.png)

## Version history and download
([Back to contents](#contents))

[Link to latest build](https://github.com/xahmol/ludo/raw/main/GEOS/GeoLudo-v01-20230301-1400.zip)

Version v01-20230301-1400:
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


**Credits**:

*Commodore 128 version*:

Code and resources from others used:

* CC65 cross compiler:
  https://cc65.github.io/
* C128 Programmers Reference Guide: For the basic VDC register routines and VDC code inspiration
  http://www.zimmers.net/anonftp/pub/cbm/manuals/c128/C128_Programmers_Reference_Guide.pdf
* Scott Hutter - VDC Core functions inspiration:
  https://github.com/Commodore64128/vdc_gui/blob/master/src/vdc_core.c
  (used as starting point, but channged to inline assembler for core functions, added VDC wait statements and expanded)
* Francesco Sblendorio - Screen Utility: used for inspiration:
  https://github.com/xlar54/ultimateii-dos-lib/blob/master/src/samples/screen_utility.c
* DevDef: Commodore 128 Assembly - Part 3: The 80-column (8563) chip
  https://devdef.blogspot.com/2018/03/commodore-128-assembly-part-3-80-column.html
* 6502.org: Practical Memory Move Routines: Starting point for memory move routines
  http://6502.org/source/general/memory_move.html
* Anthony Beaucamp - 8Bit Unity: Starting point for SID play routines
  https://github.com/8bit-Dude/8bit-Unity/blob/main/unity/targets/c64/SID.s
* Bart van Leeuwen: For inspiration and advice while coding. Also for providing the excellent Device Manager ROM to make testing on real hardware very easy.
* Original windowing system code on Commodore 128 by unknown author.

Music credits:

* John Ames - Smells Like Teen Spirit
  https://csdb.dk/sid/?id=7763
* John Ames - Castle of Zokor: Step Carefully
  https://csdb.dk/sid/?id=7736
* John Ames - Final Fantasy IV - Overworld
  https://csdb.dk/sid/?id=7743

Tested using real hardware (C128D and C128DCR) plus VICE.

*Oric Atmos version*:

Code and resources from others used:

-   oricOpenLibrary for IJK joystick driver code and Sedoric routines
                 _
     ___ ___ _ _|_|___ ___
    |  _| .'|_'_| |_ -|_ -|
    |_| |__,|_,_|_|___|___|
            raxiss (c) 2021
    GNU General Public License v3.0
    See https://github.com/iss000/oricOpenLibrary/blob/main/LICENSE
-   OSDK for MYMPlayer music player and building tools
    (C) Dbug and OSDK authors
    https://osdk.org/
-   8Bit Unity for adaptation of OSDK MYM player
    https://github.com/8bit-Dude/8bit-Unity
     * Copyright (c) 2018 Anthony Beaucamp.
     *
     * This software is provided 'as-is', without any express or implied warranty.
     * In no event will the authors be held liable for any damages arising from
     * the use of this software.
     *
     * Permission is granted to anyone to use this software for any purpose,
     * including commercial applications, and to alter it and redistribute it
     * freely, subject to the following restrictions:
     *
     *   1. The origin of this software must not be misrepresented * you must not
     *   claim that you wrote the original software. If you use this software in a
     *   product, an acknowledgment in the product documentation would be
     *   appreciated but is not required.
     *
     *   2. Altered source versions must be plainly marked as such, and must not
     *   be misrepresented as being the original software.
     *
     *   3. This notice may not be removed or altered from any distribution.
     *
     *   4. The names of this software and/or it's copyright holders may not be
     *   used to endorse or promote products derived from this software without
     *   specific prior written permission.
-   Original windowing system code on Commodore 128 by unknown author.
-   Music credits:()
    R-Type level 1 by Wally Beben/Alain Derpin
    Defender of the Crown by David Whittaker/Aldn
    Wizzball by Peter Johnson/Aldn
-   Documentation used:
    OSDK.org, forum.defence-force.org, defence-force.org.
-   ORIC software development tooling:
    CC65 from CC65 contributors, see https://cc65.github.io/
    OSDK from DBug/OSDK Authors
    CD2 from Twilighte
    Oric Explorer by Scott Davies
    ORIC Character Generater by Pe@ceR
    HxCFloppyEmulator Software by Jean-Francois del Nero.
-   Tested using Oricuton emulator and an Oric Atmos with a Cumana Reborn. 



*TI-99/4a version*:

Code and resources from others used:

- TMS9900 modification of GCC by Insomnia
  https://atariage.com/forums/topic/164295-gcc-for-the-ti/
- LIBTI99 and LIBTIVGM2 libraries by Tursi aka Mike Brent
  LIBTI99: Generic library for conio, sound, file and VDP functions
  https://github.com/tursilion/libti99
  LIBTIVGM2: Library for VGMComp2 music functions
  https://github.com/tursilion/vgmcomp2/tree/master/Players/libtivgm2
- Jedimatt42 for:
  TMS9900-GCC installation script and instructions
  https://atariage.com/forums/topic/164295-gcc-for-the-ti/page/24/?tab=comments#comment-4776745
  Speech library:
  Source: https://github.com/jedimatt42/fcmd/tree/jm42/say-toy/example/gcc/say
  See forum thread on AtariAge:
  https://atariage.com/forums/topic/318907-doing-speech-in-c-using-tms9900-gcc/
  TIPI software and code examples
  https://github.com/jedimatt42/tipi
- PeteE on Makefile code to adapt Magellan screens and random() function:
  https://github.com/peberlein/turmoil
- TheCodex for Magellan tool to create screens
  https://atariage.com/forums/topic/161356-magellan/
- PTWZ for Python Wizard to convert speech to LPC data:
  https://github.com/ptwz/python_wizard
- Original windowing system code on Commodore 128 by unknown author.

Music credits:

* R-Type: Game Start Music
  https://www.smspower.org/Music/RType-SMS-PSG
* Astro Warriot: Galaxy Zone
  https://www.smspower.org/Music/AstroWarrior-SMS
* Submarine Attack: Title Screen
  https://www.smspower.org/Music/SubmarineAttack-SMS

  Documentation used:

* AtariAge TI-99/4a community
  https://atariage.com/forums/forum/164-ti-994a-computers/

  Tested using Classic99 emulator and original TI-99/4a with TIPI. 



*Tooling to transfer original Commodore software code*:

* VICE by VICE authors
* DirMaster by The Wiz/Elwix
* CharPad Free by Subchrist software
* UltimateII+ cartridge by Gideon Zweijtzer



The code can be used freely as long as you retain
a notice describing original source and author.

THE PROGRAMS ARE DISTRIBUTED IN THE HOPE THAT THEY WILL BE USEFUL,
BUT WITHOUT ANY WARRANTY. USE THEM AT YOUR OWN RISK!



Thanks for reading and enjoy playing!

Xander Mol
