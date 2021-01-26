#include <lib.h>

/* Functions */
void windowsave(unsigned char ypos, unsigned char height);
void windowrestore();
void menumakeborder(unsigned char xpos, unsigned char ypos, unsigned char height, unsigned char width);
char* screenpos(unsigned char xpos, unsigned char ypos);

/* Variables */
struct WindowStruct
{
    int address;
    unsigned char ypos;
    unsigned char height;
};
struct WindowStruct Window[9];

int windowaddress = 0xa100;
unsigned char windownumber;

void windowsave(unsigned char ypos, unsigned char height)
{
    /* Function to save a window
       Input:
       - ypos: startline of window
       - height: height of window    */
    
    Window[windownumber].address = windowaddress;
    Window[windownumber].ypos = ypos;
    Window[windownumber].height = height;
    memcpy((char*)0xbba8 + Window[windownumber].ypos*40 , (char*)windowaddress, Window[windownumber].height*40);
    windowaddress += Window[windownumber++].height*40;
}

void windowrestore()
{
    /* Function to restore a window */

    windowaddress = Window[--windownumber].address;
    memcpy((char*)windowaddress, (char*)0xbba8 + Window[windownumber].ypos*40, Window[windownumber].height*40);
}

void menumakeborder(unsigned char xpos, unsigned char ypos, unsigned char height, unsigned char width)
{
    windowsave(ypos, height);
    sprintf(screenpos(xpos-2,ypos),"%c%c%c", A_STD, A_FWRED, 125);
}

char* screenpos(unsigned char xpos, unsigned char ypos)
{
    return (char*)0xbba8 + ypos*40 + xpos;
}