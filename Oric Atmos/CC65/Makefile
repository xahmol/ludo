# L U D O
# Written in 1992,2020, 2021 by Xander Mol

# https://github.com/xahmol/ludo
# https://www.idreamtin8bits.com/

# Originally written in 1992 in Commodore BASIC 7.0 for the Commodore 128
# Rewritten for Oric Atmos in BASIC in 2020
# Rewritten for Oric Atmos in C using CC65 in 2021

# For full credits: see src/main.c

# Thanks to Iss for pointers for this Makefile:
# https://forum.defence-force.org/viewtopic.php?p=25411#p25411

## Paths
# Path tp OSDK install. Edit for local dir
# Installation instructions for Linux: #https://forum.defence-force.org/viewtopic.php?p=25396#p25396
OSDK := /home/xahmol/OSDK-build/pc/tools/osdk/main/osdk-linux/bin/
# Path tp HxC Floppy Emulator command line tool: edit for local dir
# SVN repository: svn checkout https://svn.code.sf.net/p/hxcfloppyemu/code/ hxcfloppyemu-code
# Build with  HxCFloppyEmulator/build/make 
HXCFE := /home/xahmol/retro/oric/hxcfloppyemu-code/HxCFloppyEmulator/HxCFloppyEmulator_cmdline/trunk/build/
# Emulator path: edit for location of emulator to use
EMUL_DIR := /home/xahmol/retro/oric/oricutron/

## Project name
PROJECT      := LUDO
PROJECT_DIR  := $(shell pwd)
PROGRAM      := BUILD/$(PROJECT).bin
TESTPROG     := SAVETEST
TESTPROG_BIN := BUILD/$(TESTPROG).bin
DISK_DSK     := BUILD/$(PROJECT).dsk
DISK_HFE     := BUILD/$(PROJECT).hfe

## Tooling arguments variables
# Arguments for YM to MYM music conversion tool
YM2MYM = $(OSDK)Ym2Mym -h1 -m8192
# Arguments for emulator
# # # Use MACH to override the default and run as:
# # # make run-tap MACH=-ma for Atmos (default)
# # # make run-tap MACH=-m1 for Oric-1
# # # make run-tap MACH=-mo16k for Oric-1 / 16K
# # # make run-tap MACH=-mp for Pravetz-8D
# # # make run-tap MACH=-mt for Telestrat
MACH := -ma
EMU                     := ./oricutron
EMUDIR                  := $(EMUL_DIR)
EMUARG                  := $(MACH)
# # # (un)comment, add, remove more Oricutron cmd-line options
EMUARG                  += --serial none
EMUARG                  += --vsynchack off
EMUARG                  += --turbotape on
# append symbols and breakpoints
# read more at DF-forum:
# https://forum.defence-force.org/viewtopic.php?p=15145#p15145
EMUARG_DEBUG            := $(EMUARG) -s "$(PROJECT_DIR)/$(PROJECT).sym"
EMUARG_DEBUG            +=  -r :"$(PROJECT_DIR)/$(PROJECT).brk"

## C Sources and library objects to use
SOURCES = src/main.c
LIBOBJECTS = include/libsedoric-ca65.s include/MYM.s include/ijkdriver-ca65.s

TESTSOURCES = src/savetest.c
TESTOBJECTS = include/libsedoric-ca65.s

## Compiler and linker flags
CC65_TARGET = atmos
CC = cl65
CFLAGS  = -t $(CC65_TARGET) --create-dep $(<:.c=.d) -Oirs -I include
LDFLAGS = -t $(CC65_TARGET) -m $(PROJECT).map
LDFLAGSTEST = -t $(CC65_TARGET) -m $(TESTPROG).map

########################################

.SUFFIXES:
.PHONY: all clean run run-debug
all: $(PROGRAM) $(TESTPROG_BIN) $(DISK_DSK)

ifneq ($(MAKECMDGOALS),clean)
-include $(SOURCES:.c=.d) $(SOURCESUPD:.c=.d)
endif

# Compile C sources
%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $<

# Link compiled objects 
$(PROGRAM): $(SOURCES:.c=.o)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBOBJECTS)

$(TESTPROG_BIN): $(TESTSOURCES:.c=.o)
	$(CC) $(LDFLAGSTEST) -o $@ $^ $(TESTOBJECTS)

# Build disk
$(DISK_DSK): $(PROGRAM) $(TESTPROG_BIN)
	$(OSDK)header $(PROGRAM) BUILD/$(PROJECT)MAIN.tap 0x0501
	$(OSDK)header $(TESTPROG_BIN) BUILD/$(TESTPROG).tap 0x0501
	$(OSDK)header data/$(PROJECT)DATA.bin BUILD/$(PROJECT)DATA.tap 0xb000
	$(YM2MYM) "music/R-Type  2 - level 1.ym" BUILD/R-Type.tap		0x7e00 "$(PROJECT)MUS1"
	$(YM2MYM) "music/Wizball 1.ym" BUILD/Wizzball.tap               0x7e00 "$(PROJECT)MUS2"
	$(YM2MYM) "music/Defender of the Crown 1.ym" BUILD/Defender.tap 0x7e00 "$(PROJECT)MUS3"
	$(OSDK)tap2dsk -iCLS:$(PROJECT)MAIN -c20:3 -n$(PROJECT) BUILD/$(PROJECT)MAIN.tap BUILD/$(TESTPROG).tap screen/$(PROJECT)TITL.tap screen/$(PROJECT)SCRM.tap BUILD/$(PROJECT)DATA.tap BUILD/R-Type.tap BUILD/Defender.tap BUILD/Wizzball.tap $(DISK_DSK)
	$(OSDK)old2mfm $(DISK_DSK)
	cd $(HXCFE); hxcfe -finput:"$(WORKDIR)/$(DISK_DSK)" -foutput:"$(WORKDIR)/$(DISK_HFE)" -conv:HXC_HFE

# Clean old builds and objects
clean:
	$(RM) $(SOURCES:.c=.o) $(SOURCES:.c=.d) $(TESTSOURCES:.c=.o) $(TESTSOURCES:.c=.d) $(PROGRAM) $(PROGRAM).map $(PROGRAM).brk $(PROGRAM).sym $(TESTPROG) $(TESTPROG).map
	cd BUILD; $(RM) *.*

# Execute in emulator in debug mode: use make run-debug
run-debug: $(DISK_DSK)
	@([ -e $(PROJECT).brk ] || touch $(PROJECT).brk) || echo -n
	cd $(EMUDIR); $(EMU) $(EMUARG_DEBUG) "$(PROJECT_DIR)/$(DISK_DSK)"

run: $(DISK_DSK)
	cd $(EMUDIR); $(EMU) $(EMUARG) "$(PROJECT_DIR)/$(DISK_DSK)"