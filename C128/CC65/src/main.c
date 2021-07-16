//Includes
#include <stdio.h>
#include <string.h>
#include <peekpoke.h>
#include <cbm.h>
#include <conio.h>
#include <stdlib.h>
#include <errno.h>
#include <ctype.h>
#include <device.h>
#include <accelerator.h>
#include <c128.h>
#include <_vdc.h>
#include "vdc_core.h"
#include "defines.h"
#include "ludo_mainscreen.h"

void main()
{
    unsigned int x;
    char test[] = "Dit is een memcopy test.";

    VDC_Init();
    VDC_LoadCharset("ludo.chr1",0x0400,1,0);
    VDC_LoadCharset("ludo.chr2",0x0400,1,1);

    clrscr();
    cputs("VDC Register read test:\n\r");
    cprintf("Display start address High  : %2X\n\r", VDC_ReadRegister(12));
    cprintf("Display start address Low   : %2X\n\r", VDC_ReadRegister(13));
    cprintf("Attribute start address High: %2X\n\r", VDC_ReadRegister(20));
    cprintf("Attribute start address Low : %2X\n\r", VDC_ReadRegister(21));
    cprintf("Character base address:       %2X\n\r", VDC_ReadRegister(28));
     
    cgetc();

    for(x=0;x<2048;x++)
    {
        VDC_Poke(x,102);
    }

    cgetc();

    gotoxy(10,0);
    cprintf("Screen value at 0,0 is: %2X", VDC_Peek(0));

    cgetc();

    clrscr();
    for(x=0;x<160;x++)
    {
        cprintf("%2X  ",x);
    }

    VDC_MemCopy(0,4096,640);
    cgetc();
    VDC_MemCopy(4096,800,640);
    cgetc();

    clrscr();
    VDC_HChar(5,5,100,40,VDC_Attribute(VDC_DRED,0,0,0,0));
    VDC_VChar(5,50,103,10,VDC_Attribute(VDC_DRED,0,0,0,0));
    VDC_PrintAt(0,0,"Text in dark blue standard",VDC_Attribute(VDC_DBLUE,0,0,0,0));
    VDC_PrintAt(1,1,"Text in Light Blue and blink",VDC_Attribute(VDC_LBLUE,1,0,0,0));
    VDC_PrintAt(2,2,"Text in Light Cyan and underline",VDC_Attribute(VDC_LCYAN,0,1,0,0));
    VDC_PrintAt(3,3,"Text in Dark Purple and reverse",VDC_Attribute(VDC_DPURPLE,0,0,1,0));
    VDC_PrintAt(4,4,"Text in Dark Cyan and alternate",VDC_Attribute(VDC_LPURPLE,0,0,0,1));
    cgetc();
    VDC_CopyVDCToMem(0,4096,1,400);
    VDC_CopyMemToVDC(400,4096,1,400);
    VDC_FillArea(10,10,95,60,10,VDC_DGREEN+128);
    cgetc();

    clrscr();
    for(x=0;x<256;x++)
    {
        VDC_Poke(x,x);
        VDC_Poke(x+0x800,VDC_Attribute(VDC_LYELLOW,0,0,0,0));
        VDC_Poke(x+800,x);
        VDC_Poke(x+800+0x800,VDC_Attribute(VDC_LYELLOW,0,0,0,1));
    }

    cgetc();

    clrscr();
    VDC_CopyMemToVDC(0,mainscreen,0,4096);
    //for(x=0;x<4096;x++)
    //{
    //    VDC_Poke(x,mainscreen[x]);
    //}
    cgetc();


    VDC_Exit();
}