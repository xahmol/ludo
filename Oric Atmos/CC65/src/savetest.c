/* Includes */
#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <string.h>
#include "defines.h"
#include "osdklib.h"
#include "libsedoric.h"

/* PEEK POKE */
#define peek(address)		( *((unsigned char*)address) )
#define poke(address,value)	( *((unsigned char*)address)=(unsigned char)value )

#define deek(address)		( *((unsigned int*)address) )
#define doke(address,value)	( *((unsigned int*)address)=(unsigned int)value )


void main(void)
{
    int rc, x, y, len;
    unsigned int* saveslots;
    unsigned int* savegamemem;
    char filename[15];

    saveslots = (unsigned int*) malloc(85);
    savegamemem = (unsigned int*) malloc(120);

    clrscr();
    bgcolor(0);    
    textcolor(3);
    cputs("\nViewing config file and save slots:\n\r");

    cprintf("Loading config file.\n\r");
    len = 0;
    rc = loadfile("LUDODATA.COM", (void*)saveslots, &len);
    cprintf("%d bytes loaded, rc=%d\n\r",len,rc);

    cprintf("Printing read data:\n\r");
    for(x=0;x<85;x++)
    {
        cprintf("%2X  ",peek(saveslots+x));
    }
    cputs("\n\n\r");
    for(x=0;x<85;x++)
    {
        if(peek(saveslots+x)>31) { cputc(peek(saveslots+x)); }
        else { cputs(" "); }
    }
    cgetc();

    for(x=0;x<5;x++)
    {
        if(peek(saveslots+x))
        {
            clrscr();
            cprintf("Loading slot %d: \n\r", x);
            sprintf(filename,"LUDOSAV%d.SAV", x);
            rc = loadfile(filename, (void*)savegamemem, &len);
            cprintf("%s loaded, %d bytes, rc = %d. \n\r",filename, len, rc);
            cprintf("Printing read data:\n\r");
            for(y=0;y<137;y++)
            {
                cprintf("%2X  ",peek(savegamemem+y));
            }
            cputs("\n\n\r");
            for(y=0;y<137;y++)
            {
                if(peek(savegamemem+y)>31 && peek(savegamemem+y)<128) { cputc(peek(savegamemem+y)); }
                else { cputs(" "); }
            }
            cputs("\n\rPress key.\n\r");
            cgetc();
        }
    }

    clrscr();

    free(saveslots);
    free(savegamemem);
}