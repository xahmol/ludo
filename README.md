# LUDO
Ludo game for 8 bit computers.

For **GeoLudo**, the GEOS version playable on Commodore 64, Commodore 128 and Commodore 128 with GEOS, click:
https://github.com/xahmol/ludo/tree/main/GEOS

Written in 1992,2020, 2021 by Xander Mol
https://github.com/xahmol/ludo
https://www.idreamtin8bits.com/

Originally written in 1992 in Commodore BASIC 7.0 for the Commodore 128
Rewritten for Oric Atmos in BASIC in 2020
Rewritten for Oric Atmos in C using CC65 in 2021
Rewritten for TI-99/4a in C using TMS9900-GCC in 2021
Rewritten for C128 in C using CC65 in 2021

**Latest builds**:

Commodore 128:

* D64 version:
  https://github.com/xahmol/ludo/raw/00036311332cf095bc47cfed7b2c6653208a68d2/C128/CC65/ludoc128.d64

Oric Atmos:

- DSK version:
  https://github.com/xahmol/ludo/raw/main/Oric%20Atmos/CC65/BUILD/LUDO.dsk
- HFE version (for Cumana Reborn):
  https://github.com/xahmol/ludo/raw/main/Oric%20Atmos/CC65/BUILD/LUDO_dsk.hfe

TI-99/4a:

* ZIP file to be deployed at DSK1 location of e.g. TIPI or emulator:
  https://github.com/xahmol/ludo/raw/00036311332cf095bc47cfed7b2c6653208a68d2/TI994a/LudoTI994a-v199-20210531-1535.zip

Original 1992 Commodore 128 version (in Dutch):

- D64 version:
  https://github.com/xahmol/ludo/raw/main/C128/D64/mejn.d64

**Instructions for playing**:

The game is menu driven. For menu navigation, use the cursor keys (up, down, left, right) and press ENTER to select. Active choice has a white background in the main menu bar, yellow in the pull down menus. If the main menu bar shows no white hightlighted options, no menu choices are possible, the computer is busy executing game turn actions.
Popups wait for a keypress, for this any key will work. Pawn selection is also performed using the cursor keys and ENTER.
Joystick is also possible for the C128 version, but not yet implemented for the Oric Atmos version. Mouse not supported.

The game uses the LUDO rules from the Dutch 'Mens Erger je Niet' variant as played by my family 30 years ago, so probably there are some 'house rules' interpretations that are not the same as the present official game manual, like what is allowed after a six is thrown depending on how many pawns are already on the board. Example: after throwing a six, moving the newly placed pawn with the next dice throw is obligatory, also if this would attack another pawn of the same player. Exception is if all pawns are on the board, moving the new pawn is in that case optional. As the game only allows valid moves, this should indicate itself.

Please let me know if the game interpretations are inconsistent, incorrect or not working.

Enjoy!

**Machine specific instructions**:

Commodore 128:

* Copy D64 file to the desired media, start with RUN"LUDO.
* Known issue: on VICE, if the joystick is enabled, but cursor down and SPACE trigger fire. Disable joystick in loading screen by pressing J to be able to play by keyboard.

Oric Atmos:

* Select DSK (or HFE on Cumana Reborn) as disk in emulator or real hardware. Game autostarts.

TI-99/4a:

* Copy contents of ZIP file to the location needed for your local DSK1 emulation (of your emulator or real hardware via e.g. TIPI)
* Ensure Editor/Assembler is enabled as cartridge. Start E/A with menu option 2, then menuoption 5 for Run program file. Then type DSK1.LUDO and press enter.
* For TIPI: select 1 on start menu to go to BASIC prompt and type CALL TIPI("TIPI.<your path to the ZIP contents>.LUDO")

**Screenshots**:

Commodore 128:

![](https://github.com/xahmol/ludo/blob/main/Media/ludoc128title.png?raw=true)

![](https://github.com/xahmol/ludo/blob/main/Media/ludoc128play.png?raw=true)

Oric Atmos:

![](https://github.com/xahmol/ludo/blob/main/Media/ludoorictitle.png?raw=true)

![](https://github.com/xahmol/ludo/blob/main/Media/ludooricplay.png?raw=true)

Texas Instruments TI-99/4a:
![](https://github.com/xahmol/ludo/blob/main/Media/ludotititle.png?raw=true)

![](https://github.com/xahmol/ludo/blob/main/Media/ludotiplay.png?raw=true)

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
-   Music credits:
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
