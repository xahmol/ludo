SOURCES = src/main.c
LIBOBJECTS = include/libsedoric-ca65.s include/MYM.s include/ijkdriver-ca65.s

TESTSOURCES = src/savetest.c
TESTOBJECTS = include/libsedoric-ca65.s

PROGRAM = build/LUDOMAIN.bin
TESTPROG = build/SAVETEST.bin

CC65_TARGET = atmos
CC = cl65
CFLAGS  = -t $(CC65_TARGET) --create-dep $(<:.c=.d) -Oirs -I include
LDFLAGS = -t $(CC65_TARGET) -m $(PROGRAM).map
LDFLAGSTEST = -t $(CC65_TARGET) -m $(TESTPROG).map

########################################

.SUFFIXES:
.PHONY: all clean
all: $(PROGRAM) $(TESTPROG)

ifneq ($(MAKECMDGOALS),clean)
-include $(SOURCES:.c=.d) $(SOURCESUPD:.c=.d)
endif

%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $<
  
$(PROGRAM): $(SOURCES:.c=.o)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBOBJECTS)

$(TESTPROG): $(TESTSOURCES:.c=.o)
	$(CC) $(LDFLAGSTEST) -o $@ $^ $(TESTOBJECTS)

clean:
	$(RM) $(SOURCES:.c=.o) $(SOURCES:.c=.d) $(TESTSOURCES:.c=.o) $(TESTSOURCES:.c=.d) $(PROGRAM) $(PROGRAM).map $(TESTPROG) $(TESTPROG).map