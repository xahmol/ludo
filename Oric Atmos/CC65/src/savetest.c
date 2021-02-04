/* Includes */
#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <string.h>
#include "defines.h"
#include "osdklib.h"
#include "libsedoric.h"
#include "libmymplayer.h"

/* PEEK POKE */
#define peek(address)		( *((unsigned char*)address) )
#define poke(address,value)	( *((unsigned char*)address)=(unsigned char)value )

#define deek(address)		( *((unsigned int*)address) )
#define doke(address,value)	( *((unsigned int*)address)=(unsigned int)value )


void main(void)
{
    int rc, x, len;

    clrscr();
    bgcolor(0);    
    textcolor(3);
    cputs("\nViewing config file and save slots:\n\r");

    cprintf("Loading config file.\n\r");
    len = 0;
    rc = loadfile("LUDODATA.COM", (void*)0xb000, &len);
    cprintf("%d bytes loaded, rc=%d\n\r",len,rc);

    cprintf("Printing read data:\n\r");
    for(x=0;x<85;x++)
    {
        cprintf("%2X  ",peek(0xb000+x));
    }
    cputs("\n\r");
    for(x=0;x<85;x++)
    {
        if(peek(0xb000+x)>31) { cputc(peek(0xb000+x)); }
        else { cputs(" "); }
    }

    cgetc();
}