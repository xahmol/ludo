#include <lib.h>

/* Functions */
void loadmainscreen();
void windowsave(unsigned char ypos, unsigned char height);
void windowrestore();
void menumakeborder(unsigned char xpos, unsigned char ypos, unsigned char height, unsigned char width);
void menuplacebar();
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
unsigned char windownumber = 1;

char menubaroptions = 4;
char menubartitles[4][12] = {"Game","Disc","Music","Information"};
char submenuoptions[4] = {3,2,3,1};
char submenutitles[4][3][11] = {
    {"Throw dice","Restart","Stop"},
    {"Save game","Load game"},
    {"Next","Stop","Restart"},
    {"Credits"}
};

char pulldownmenunumber = 3;
char pulldownmenuoptions[3] = {2,2,3};
char pulldownmenutitles[3][3][15] = {
    {"Yes","No"},
    {"Restart","Stop"},
    {"Continue game","New game","Stop"}
};

/* Main routine */

void main()
{
    unsigned char x;

    setflags(SCREEN);
    paper(0);
    ink(1);
    cls();

    loadmainscreen();
    menuplacebar();

    for(x=0; x<5 ; x++)
    {
        menumakeborder(18,2+x*2,6,20);
        sprintf(screenpos(20,4+x*2),"%cWindow %d%c", A_FWYELLOW, x+1, A_FWRED);
        sprintf(screenpos(20,5+x*2),"%cPress a key.%c", A_FWYELLOW, A_FWRED);
        get();
    }
    for(x=0; x<5 ; x++)
    {
        windowrestore();
        get();
    }
}

/* Game routines */
void loadmainscreen()
{
    sedoric("!LOAD \"LUDOSCRM.BIN\"");
    /*GOSUB funcMenuplacebar*/
}

/* Functions for windowing and menu system */

void windowsave(unsigned char ypos, unsigned char height)
{
    /* Function to save a window
       Input:
       - ypos: startline of window
       - height: height of window    */
    
    Window[windownumber].address = windowaddress;
    Window[windownumber].ypos = ypos;
    Window[windownumber].height = height;
    memcpy((char*)windowaddress, (char*)0xbba8 + Window[windownumber].ypos*40, Window[windownumber].height*40);
    windowaddress += Window[windownumber++].height*40;
}

void windowrestore()
{
    /* Function to restore a window */

    windowaddress = Window[--windownumber].address;
    memcpy((char*)0xbba8 + Window[windownumber].ypos*40, (char*)windowaddress, Window[windownumber].height*40);
}

void menumakeborder(unsigned char xpos, unsigned char ypos, unsigned char height, unsigned char width)
{
    /* Function to make menu border
       Input:
       - xpos: x-coordinate of left upper corner
       - ypos: y-coordinate of right upper corner
       - height: number of rows in window
       - width: window width in characters        */

    unsigned char x, y;
    char* screen;
    
    windowsave(ypos, height+2);
    screen = screenpos(xpos-2,ypos);
    sprintf(screen,"%c%c%c",A_STD,A_FWRED,125);
    screen+=3;
    for(x=0;x<width;x++) { sprintf(screen++,"%c",94); }
    sprintf(screen,"%c",126);
    for(y=0;y<height;y++)
    {
        screen = screenpos(xpos-2,ypos+y+1);
        sprintf(screen,"%c%c%c",A_STD,A_FWRED,91);
        screen+=3;
        for(x=0;x<width;x++) { sprintf(screen++,"%c", 32); }
        sprintf(screen,"%c",92);
    }
    screen = screenpos(xpos-2,ypos+height+1);
    sprintf(screen,"%c%c%c",A_STD,A_FWRED,123);
    screen+=3;
    for(x=0;x<width;x++) { sprintf(screen++,"%c",93); }
    sprintf(screen,"%c",124);
}

void menuplacebar()
{
    char* screen = (char*)0xbba8;
    char x;

    sprintf(screen,"%c%c", A_FWBLACK, A_BGGREEN);
    screen+=2;
    for(x=0;x<menubaroptions;x++)
    {
        sprintf(screen,"%s ",menubartitles[x]);
        screen+=strlen(menubartitles[x])+1;
    }
}

/* Generic screen functions */

char* screenpos(unsigned char xpos, unsigned char ypos)
{
    /* Function to calculate screen memory position of 
       given x,y co-ordinates.
       Input:
       - xpos: x-co-ordinate
       - ypos: y-co-ordinate
       Output: pointer to correct screen memoery position */
       
    return (char*)0xbba8 + ypos*40 + xpos;
}