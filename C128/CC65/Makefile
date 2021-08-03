# Prerequisites for building:
# - CC65 compiled and included in path with sudo make avail
# - ZIP packages installed: sudo apt-get install zip
# - wput command installed: sudo apt-get install wput

SOURCESMAIN = src/main.c src/vdc_core.c src/sidplay.c
SOURCESLIB = src/vdc_core_assembly.s src/sidplay_assembly.s
OBJECTS = ludo.maco.prg ludo.chr1.prg ludo.chr2.prg ludo.tscr.prg ludo.mscr.prg ludo.mus1.prg ludo.mus2.prg ludo.mus3.prg

ZIP = LudoC128-$(shell date "+%Y%m%d-%H%M").zip
D64 = ludoc128.d64

# Hostname of Ultimate II+ target for deployment. Edit for proper IP and usb number
ULTHOST = ftp://192.168.1.72/usb1/dev/
ULTHOST2 = ftp://192.168.1.31/usb1/dev/

MAIN = ludo.prg

CC65_TARGET = c128
CC = cl65
CFLAGS  = -t $(CC65_TARGET) --create-dep $(<:.c=.d) -O -I include
LDFLAGSMAIN = -t $(CC65_TARGET) -C ludo-c128.cfg -m $(MAIN).map

########################################

.SUFFIXES:
.PHONY: all clean deploy vice
all: $(MAIN) $(D64)

ifneq ($(MAKECMDGOALS),clean)
-include $(SOURCESMAIN:.c=.d)
endif

%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $<
  
$(MAIN): $(SOURCESLIB) $(SOURCESMAIN:.c=.o)
	$(CC) $(LDFLAGSMAIN) -o $@ $^

#$(ZIP): $(MAIN) $(OBJECTS)
#	zip $@ $^

$(D64):	$(MAIN) $(OBJECTS)
	c1541 -format "ludo c128,id" d64 $(D64)
	c1541 -attach $(D64) -write ludo.prg ludo
	c1541 -attach $(D64) -write ludo.maco.prg ludo.maco
	c1541 -attach $(D64) -write ludo.chr1.prg ludo.chr1
	c1541 -attach $(D64) -write ludo.chr2.prg ludo.chr2
	c1541 -attach $(D64) -write ludo.tscr.prg ludo.tscr
	c1541 -attach $(D64) -write ludo.mscr.prg ludo.mscr
	c1541 -attach $(D64) -write ludo.mus1.prg ludo.mus1
	c1541 -attach $(D64) -write ludo.mus2.prg ludo.mus2
	c1541 -attach $(D64) -write ludo.mus3.prg ludo.mus3

clean:
	$(RM) $(SOURCESMAIN:.c=.o) $(SOURCESMAIN:.c=.d) $(MAIN) $(MAIN).map
	
# To deploy software to UII+ enter make deploy. Obviously C128 needs to powered on with UII+ and USB drive connected.
deploy: $(MAIN)
	wput -u $(MAIN) $(OBJECTS) $(D64) $(ULTHOST)
	wput -u $(MAIN) $(OBJECTS) $(D64) $(ULTHOST2)

# To run software in VICE
vice: $(D64)
	x128 -autostart $(D64)
