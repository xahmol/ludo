TMS9900_DIR?=/home/xahmol/tms9900gcc/bin
LIBTI99?=/home/xahmol/libti99
LIBTIVGM2?=/home/xahmol/vgmcomp2/Players/libtivgm2

# Paths to TMS9900 compilation tools
GAS=$(TMS9900_DIR)/tms9900-as
LD=$(TMS9900_DIR)/tms9900-ld
CC=$(TMS9900_DIR)/tms9900-gcc
AR=$(TMS9900_DIR)/tms9900-ar
CXX=$(TMS9900_DIR)/tms9900-c++
OBJCOPY=$(TMS9900_DIR)/tms9900-objcopy
OBJDUMP=$(TMS9900_DIR)/tms9900-objdump
ELF2EA5=$(TMS9900_DIR)/elf2ea5
ELF2CART=$(TMS9900_DIR)/elf2cart
EA5SPLIT=$(TMS9900_DIR)/ea5split
CLASSIC99_DSK1?=/mnt/l/Retro/TI994a/classic99/DSK1/

FNAME=ludo
UCFNAME=$(shell echo -n $(FNAME) | tr 'a-z' 'A-Z')
GRAPHICS=graphics.h
SCREENNAME=ludo_mainscreen.mag
ZIP = LudoTI994a-v199-$(shell date "+%Y%m%d-%H%M").zip

LDFLAGS=\
  --script=linkfile

OBJECT_LIST=\
  crt0.o\
  main.o

all: $(GRAPHICS) $(FNAME)

$(GRAPHICS): $(SCREENNAME) Makefile
	( echo "static const unsigned char colorset[] = {" ;\
	gawk -F: -e '$$1=="CC" { if (i>=0 && i<25) { split($$2, a, "|"); printf("0x%x%x,\n", a[1], a[2]) } i++ }' $(SCREENNAME) ;\
	echo "};" ;\
	echo "static const unsigned char patterns[] = {" ;\
	gawk -F: -e '$$1=="CH" { if (i>=0 && i<200) { print gensub(/(..)/,"0x\\1,","g",$$2) } i++ }' $(SCREENNAME) ;\
	echo "};" ;\
	echo "static const unsigned char mainscreen[] = {" ;\
	gawk -F: -e '$$1=="MP" { if (i>=0 && i<24) { split($$2, a, "|"); for( b in a ) { printf("0x%02x,", a[b]); } print "" } i++ }' $(SCREENNAME) ;\
  echo "};" ;\
  echo "static const unsigned char titlescreen[] = {" ;\
	gawk -F: -e '$$1=="MP" { if (i>=24 && i<42) { split($$2, a, "|"); for( b in a ) { printf("0x%02x,", a[b]); } print "" } i++ }' $(SCREENNAME) ;\
	echo "};" ) > $@

$(FNAME): $(FNAME).bin
	$(EA5SPLIT) $(FNAME).bin
	zip $(ZIP) $(shell echo $(UCFNAME)| rev| cut -c2-| rev)?*
	cp $(shell echo $(UCFNAME)| rev| cut -c2-| rev)?* $(CLASSIC99_DSK1)

$(FNAME).bin: $(FNAME).elf
	$(ELF2EA5) $(FNAME).elf $(FNAME).bin

$(FNAME).elf: $(OBJECT_LIST)
	$(LD) $(OBJECT_LIST) $(LDFLAGS) -L$(LIBTI99) -lti99 -L$(LIBTIVGM2) -ltivgm2 -o $(FNAME).elf -Map=mapfile

.phony clean:
	rm -f *.o
	rm -f *.elf
	rm -f *.bin
	rm -f *.i
	rm -f *.s
	rm -f mapfile
	rm -f $(shell echo $(UCFNAME)| rev| cut -c2-| rev)?

%.o: %.asm
	$(GAS) $< -o $@

%.o: %.c
	$(CC) -c $< -std=c99 -O2 --save-temp -I$(LIBTI99) -I$(LIBTIVGM2) -o $@
