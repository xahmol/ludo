# LUDO
Ludo game for 8 bit computers. By Xander Mol.
(C) 2020 for Oric Atmos, (C) 1992 for Commodore 128

Latest build for Oric Atmos:

C version:
- DSK version:
  https://github.com/xahmol/ludo/raw/main/Oric%20Atmos/CC65/BUILD/LUDO.dsk
- HFE version (for Cumana Reborn):
  https://github.com/xahmol/ludo/raw/main/Oric%20Atmos/CC65/BUILD/LUDO_dsk.hfe

BASIC version:

- DSK version:
  https://github.com/xahmol/ludo/raw/main/Oric%20Atmos/BASIC/BUILD/LUDO.dsk
- HFE version (for Cumana Reborn):
  https://github.com/xahmol/ludo/raw/main/Oric%20Atmos/BASIC/BUILD/LUDO_dsk.hfe

Original Commodore 128 version (in Dutch):

- D64 version:
  https://github.com/xahmol/ludo/raw/main/C128/D64/mejn.d64

**Instructions for playing**:

The game is menu driven. For menu navigation, use the cursor keys (up, down, left, right) and press ENTER to select. Active choice has a white background in the main menu bar, yellow in the pull down menus. If the main menu bar shows no white hightlighted options, no menu choices are possible, the computer is busy executing game turn actions.
Popups wait for a keypress, for this any key will work. Pawn selection is also performed using the cursor keys and ENTER.
Joystick is also possible for the C128 version, but not yet implemented for the Oric Atmos version. Mouse not supported.

The game uses the LUDO rules from the Dutch 'Mens Erger je Niet' variant as played by my family 30 years ago, so probably there are some 'house rules' interpretations that are not the same as the present official game manual, like what is allowed after a six is thrown depending on how many pawns are already on the board. Example: after throwing a six, moving the newly placed pawn with the next dice throw is obligatory, also if this would attack another pawn of the same player. Exception is if all pawns are on the board, moving the new pawn is in that case optional. As the game only allows valid moves, this should indicate itself.

Please let me know if the game interpretations are inconsistent, incorrect or not working.

Enjoy!

**Screenshots of Oric Atmos version**:

![](LudoTitle.png)

![](LudoGame.png)

**Credits**:

L U D O
Written in 1992,2020, 2021 by Xander Mol

https://github.com/xahmol/ludo
https://www.idreamtin8bits.com/

Originally written in 1992 in Commodore BASIC 7.0 for the Commodore 128
Rewritten for Oric Atmos in BASIC in 2020
Rewritten for Oric Atmos in C using CC65 in 2021

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
    
-   Tooling to transfer original Commodore software code: "
    VICE by VICE authors
    DirMaster by The Wiz/Elwix
    CharPad Free by Subchrist software
    UltimateII+ cartridge by Gideon Zweijtzer
    
-   Tested using Oricuton emulator and an Oric Atmos with a Cumana Reborn. 

The code can be used freely as long as you retain
a notice describing original source and author.

THE PROGRAMS ARE DISTRIBUTED IN THE HOPE THAT THEY WILL BE USEFUL,
BUT WITHOUT ANY WARRANTY. USE THEM AT YOUR OWN RISK!



Thanks for reading and enjoy playing!

Xander Mol
