SOURCES = src/main.c
LIBOBJECTS = include/telestratjoy.s

PROGRAM = build/ludo

CC65_TARGET = telestrat
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

clean:
	$(RM) $(SOURCES:.c=.o) $(SOURCES:.c=.d) $(PROGRAM) $(PROGRAM).map