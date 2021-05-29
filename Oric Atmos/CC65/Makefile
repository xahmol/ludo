OSDK = /home/xahmol/OSDK-build/pc/tools/osdk/main/osdk-linux/bin/
YM2MYM = $(OSDK)Ym2Mym -h1 -m8192
HXCFE = /home/xahmol/retro/oric/hxcfloppyemu-code/HxCFloppyEmulator/HxCFloppyEmulator_cmdline/trunk/build/
WORKDIR = $(shell pwd)

SOURCES = src/main.c
LIBOBJECTS = include/libsedoric-ca65.s include/MYM.s include/ijkdriver-ca65.s

TESTSOURCES = src/savetest.c
TESTOBJECTS = include/libsedoric-ca65.s

DISK = BUILD/LUDO.dsk
PROGRAM = BUILD/LUDOMAIN.bin
TESTPROG = BUILD/SAVETEST.bin

CC65_TARGET = atmos
CC = cl65
CFLAGS  = -t $(CC65_TARGET) --create-dep $(<:.c=.d) -Oirs -I include
LDFLAGS = -t $(CC65_TARGET) -m $(PROGRAM).map
LDFLAGSTEST = -t $(CC65_TARGET) -m $(TESTPROG).map

########################################

.SUFFIXES:
.PHONY: all clean
all: $(PROGRAM) $(TESTPROG) $(DISK)

ifneq ($(MAKECMDGOALS),clean)
-include $(SOURCES:.c=.d) $(SOURCESUPD:.c=.d)
endif

%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $<
  
$(PROGRAM): $(SOURCES:.c=.o)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBOBJECTS)

$(TESTPROG): $(TESTSOURCES:.c=.o)
	$(CC) $(LDFLAGSTEST) -o $@ $^ $(TESTOBJECTS)

$(DISK): $(PROGRAM) $(TESTPROG)
	$(OSDK)header $(PROGRAM) BUILD/LUDOMAIN.tap 0x0501
	$(OSDK)header $(TESTPROG) BUILD/SAVETEST.tap 0x0501
	$(OSDK)header data/LUDODATA.bin BUILD/LUDODATA.tap 0xb000
	$(YM2MYM) "music/R-Type  2 - level 1.ym" BUILD/R-Type.tap		0x7e00 "LUDOMUS1"
	$(YM2MYM) "music/Wizball 1.ym" BUILD/Wizzball.tap               0x7e00 "LUDOMUS2"
	$(YM2MYM) "music/Defender of the Crown 1.ym" BUILD/Defender.tap 0x7e00 "LUDOMUS3"
	$(OSDK)tap2dsk -iCLS:LUDOMAIN -c20:3 -nLUDO BUILD/LUDOMAIN.tap BUILD/SAVETEST.tap screen/LUDOTITL.tap screen/LUDOSCRM.tap BUILD/LUDODATA.tap BUILD/R-Type.tap BUILD/Defender.tap BUILD/Wizzball.tap $(DISK)
	$(OSDK)old2mfm $(DISK)
	cd $(HXCFE); hxcfe -finput:"$(WORKDIR)/$(DISK)" -foutput:"$(WORKDIR)/BUILD/LUDO.hfe" -conv:HXC_HFE

clean:
	$(RM) $(SOURCES:.c=.o) $(SOURCES:.c=.d) $(TESTSOURCES:.c=.o) $(TESTSOURCES:.c=.d) $(PROGRAM) $(PROGRAM).map $(TESTPROG) $(TESTPROG).map