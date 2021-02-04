SOURCES = src/main.c
LIBOBJECTS = include/libsedoric-ca65.s

PROGRAM = build/sedorictest.bin

CC65_TARGET = atmos
CC = cl65
CFLAGS  = -t $(CC65_TARGET) --create-dep $(<:.c=.d) -Oirs -I include
LDFLAGS = -t $(CC65_TARGET) -m $(PROGRAM).map
LDFLAGSUPD = -t $(CC65_TARGET) -m $(UPDATE).map

########################################

.SUFFIXES:
.PHONY: all clean
all: $(PROGRAM) $(UPDATE) $(ZIP)

ifneq ($(MAKECMDGOALS),clean)
-include $(SOURCES:.c=.d) $(SOURCESUPD:.c=.d)
endif

%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $<
  
$(PROGRAM): $(SOURCES:.c=.o)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBOBJECTS)

clean:
	$(RM) $(SOURCES:.c=.o) $(SOURCES:.c=.d) $(SOURCESUPD:.c=.o) $(SOURCESUPD:.c=.d) $(PROGRAM) $(PROGRAM).map $(UPDATE) $(UPDATE).map