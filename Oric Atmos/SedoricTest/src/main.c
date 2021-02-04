/*
SEDORIC Test Program
*/

/* Defines */
#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <string.h>
#include <time.h>
#include "osdklib.h"
#include "libsedoric.h"

/* PEEK POKE */
#define peek(address)		( *((unsigned char*)address) )
#define poke(address,value)	( *((unsigned char*)address)=(unsigned char)value )

#define deek(address)		( *((unsigned int*)address) )
#define doke(address,value)	( *((unsigned int*)address)=(unsigned int)value )


void main(void)
{
    int rc, x, len;

    srand(clock());
    clrscr();
    bgcolor(0);    
    textcolor(3);
    cputs("\nWriting test data to memory:\n\r");
    for(x=0;x<85;x++)
    {
        poke(0xb000+x,rand()*255);
        cprintf("%2X  ",peek(0xb000+x));
    }

    cgetc();

    cputs("\n\rSaving test data.\n\r");
    rc = savefile("TEST.BIN", (void*)0xb000, 85);

    cprintf("File saved. Errorcode: %d\n\r",rc);

    cgetc();

    cprintf("Loading test data.\n\r");
    len = 0;
    rc = loadfile("TEST.BIN", (void*)0xb5100, &len);
    cprintf("%d bytes loaded, rc=%d\n\r",len,rc);

    cprintf("Printing read data:\n\r");
    for(x=0;x<85;x++)
    {
        cprintf("%2X  ",peek(0xb5100+x));
    }

    cgetc();
}