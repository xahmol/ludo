# GeoLudo
# Ludo game for 8 bit computers, GEOS edition
# Written in 2023 by Xander Mol
# 
# https://github.com/xahmol/GeoUTools
# 
# https://www.idreamtin8bits.com/

# Prerequisites for building:
# - CC65 compiled for Linux and included in path with sudo make avail
# - GEOSBuild tool compiled for Linux using Lazarus IDE.
#   See compiling instructions at https://github.com/M3wP/GEOSBuild
#   Provide path to tool below
# - VICE /bin directory, or at least the c1541 tool, in the path environment
#   and compiled for Linux
#   https://vice-emu.sourceforge.io/
# - ZIP packages installed: sudo apt-get install zip
# - wput command installed: sudo apt-get install wput

# Run 'make SYS=<target>'; or, set a SYS env.
# var. to build for another target system.
SYS ?= geos-cbm

# If SYS was given on the commandline, redirect "c64" to "geos-cbm" and
# "apple2enh" to "geos-apple"
ifeq ($(origin SYS),command line)
  ifeq ($(SYS),c64)
    override SYS = geos-cbm
    $(info GEOS: c64 -> geos-cbm)
  endif
  ifeq ($(SYS),apple2enh)
    override SYS = geos-apple
    $(info GEOS: apple2enh -> geos-apple)
  endif
endif

# Just the usual way to find out if we're
# using cmd.exe to execute make rules.
ifneq ($(shell echo),)
  CMD_EXE = 1
endif

ifdef CMD_EXE
  NULLDEV = nul:
  DEL = -del /f
  RMDIR = rmdir /s /q
else
  NULLDEV = /dev/null
  DEL = $(RM)
  RMDIR = $(RM) -r
endif

ifdef CC65_HOME
  AS = $(CC65_HOME)/bin/ca65
  CC = $(CC65_HOME)/bin/cc65
  CL = $(CC65_HOME)/bin/cl65
  LD = $(CC65_HOME)/bin/ld65
  SP = $(CC65_HOME)/bin/sp65
else
  AS := $(if $(wildcard ../../bin/ca65*),../../bin/ca65,ca65)
  CC := $(if $(wildcard ../../bin/cc65*),../../bin/cc65,cc65)
  CL := $(if $(wildcard ../../bin/cl65*),../../bin/cl65,cl65)
  LD := $(if $(wildcard ../../bin/ld65*),../../bin/ld65,ld65)
  SP := $(if $(wildcard ../../bin/sp65*),../../bin/sp65,sp65)
endif

# Path to GEOSBuild tool
GBUILD = /home/xahmol/geostools/GEOSBuild

# Application names
MAIN = geoludo

# Common compile flags
CFLAGS  = -t $(SYS)  -Os -I include

# Sources and config for GeoUMAIN
MAINSRC = src/main.c src/geoscore.s src/interface.c
MAINHDR = src/$(MAIN)Hdr.s
MAINFLG = -C $(MAIN)_cc65config.cfg -m $(MAIN).map

# Hostname of Ultimate II+ target for deployment. Edit for proper IP and usb number
ULTHOST = ftp://192.168.1.19/usb1/11/
ULTHOST2 = ftp://192.168.1.31/usb1/11/
ULTHOST3 = ftp://192.168.1.55/usb0/Geos/

########################################

.SUFFIXES:
.PHONY: all clean deploy vice
all: $(MAIN).bin $(MAIN).d81

# Building GeoUMAIN
$(MAIN).bin: $(MAIN).grc $(MAINSRC) $(MAINHDR)
	$(CL) $(CFLAGS) $(MAINFLG) -o $(MAIN).bin $(MAIN).grc $(MAINSRC) $(MAINHDR)

# Creating MAIN disk image
$(MAIN).d81:		$(MAIN).bin $(MAIN)Hdr.bin $(MAIN)d81.gbuild
	$(DEL) $(MAIN).d81 2>$(NULLDEV)
	$(GBUILD) $(MAIN)d81.gbuild

clean:
	$(DEL) $(MAIN)*.bin $(MAIN).map 2>$(NULLDEV)

# To deploy software to UII+ enter make deploy. Obviously C128 needs to powered on with UII+ and USB drive connected.
deploy: $(MAIN).d81
	wput -u $(MAIN).d81 $(ULTHOST)
	wput -u $(MAIN).d81 $(ULTHOST2)
#	wput -u $(MAIN).d81 $(ULTHOST3)