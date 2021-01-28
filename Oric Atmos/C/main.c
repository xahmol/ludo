/*
L U D O   MAIN PROGRAM
WRITTEN BY XANDER MOL
CONVERTED TO ORIC ATMOS BASIC IN 2020
CONVERTED TO ORIC ATMOS C IN 2021
ORIGINAL WRITTEN IN 1992 FOR COMMODORE 128
(C)2020 IDREAMTIN8BITS.COM
*/

/* Defines */
#include <lib.h>
#include "libsedoric.h"

/* External functions */
extern char *strchr(char *s,char c); /* from string.h */
extern char *strcat(char *s1,char *s2); /* from string.h */

/* Functions */
void loadmainscreen();
void windowsave(unsigned char ypos, unsigned char height);
void windowrestore();
void menumakeborder(unsigned char xpos, unsigned char ypos, unsigned char height, unsigned char width);
void menuplacebar();
char menupulldown(char xpos, char ypos, char menunumber);
char menumain();
char* screenpos(unsigned char xpos, unsigned char ypos);
char getkey(char* allowedkeys, char joystickmask);
void wait(unsigned int wait_cs);

/* Variables */

//Window data
struct WindowStruct
{
    int address;
    unsigned char ypos;
    unsigned char height;
};
struct WindowStruct Window[9];

int windowaddress = 0xa100;
unsigned char windownumber = 1;

//Menu data
char menubaroptions = 4;
char pulldownmenunumber = 7;
char menubartitles[4][12] = {"Game","Disc","Music","Information"};
char menubarcoords[4] = {1,6,11,17};
char pulldownmenuoptions[7] = {3,2,3,1,2,2,3};
char pulldownmenutitles[7][3][15] = {
    {"Throw dice",
     "Restart   ",
     "Stop      "},
    {"Save game",
     "Load game"},
    {"Next   ",
     "Stop   ",
     "Restart"},
    {"Credits"},
    {"Yes",
     "No "},
    {"Restart"
    ,"Stop   "},
    {"Continue game",
     "New game     ",
     "Stop         "}
};

//Input validation strings
char numbers[11]="0123456789";
char letters[53]="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
char updownenter[4] = {10,11,13,0};
char leftright[3] = {8,9,0};

//Pawn position co-ords main field
unsigned char vc[40][2] = {
     { 2,13}, { 5,13}, { 8,13}, {11,13}, {14,13},
     {14,11}, {14, 9}, {14, 7}, {14, 5}, {17, 5},
     {20, 5}, {20, 7}, {20, 9}, {20,11}, {20,13},
     {23,13}, {26,13}, {29,13}, {32,13}, {32,15},
     {32,17}, {29,17}, {26,17}, {23,17}, {20,17},
     {20,19}, {20,21}, {20,23}, {20,25}, {17,25},
     {14,25}, {14,23}, {14,21}, {14,19}, {14,17},
     {11,17}, { 8,17}, { 5,17}, { 2,17}, { 2,15}
};
//Pawn posiiion co-ords start and destination
unsigned char rc[4][8][2] = {
    {{ 2, 5}, { 5, 5}, { 2, 7}, { 5, 7}, { 5,15}, { 8,15}, {11,15}, {14,15}},
    {{29, 5}, {32, 5}, {29, 7}, {32, 7}, {17, 7}, {17, 9}, {17,11}, {17,13}},
    {{29,23}, {32,23}, {29,25}, {32,25}, {29,15}, {26,15}, {23,15}, {20,15}},
    {{ 2,23}, { 5,23}, { 2,25}, { 5,25}, {17,23}, {17,21}, {17,19}, {17,17}}
};
//Player data
unsigned char sp[4][4] = {
    {0,0,2,0},
    {0,0,1,0},
    {0,0,4,0},
    {0,0,3,0}
};
//Dice graphics string data
unsigned char dns[6][2][3] = {
    {{188,189,0},{190,191,0}},
    {{192,193,0},{193,194,0}},
    {{195,189,0},{190,196,0}},
    {{192,197,0},{198,194,0}},
    {{195,199,0},{200,196,0}},
    {{201,201,0},{202,202,0}}
};
unsigned char sc[4][4][2];
unsigned char pm[4];
unsigned char np[4];
int pw[3];
unsigned char ei = 0;

/* Main routine */

void main()
{
    int x;

    setflags(SCREEN);

    //Game start
    paper(0);
    ink(3);
    cls();

    //Ask for loading save game
    menumakeborder(18,8,6,20);
    sprintf(screenpos(20,10),"%cLoad old game?%c",A_FWYELLOW, A_FWRED);
    menupulldown(27,11,5);
    windowrestore();
    
    //Main game loop
    do
    {
        loadmainscreen();
        
    } while (ei != 1);
    
    //End of game
    cls();
    paper(0);
    ink(3);
    for(x=0;x<40;x++) { poke(0xbb80+x,0); }
    sprintf(screenpos(1,0),"%cThanks for playing, goodbye.",A_FWCYAN);
    //call(0x6503);
}

/* Game routines */
void loadmainscreen()
{
    int rc;
    int len = 0;
    rc = loadfile("LUDOSCRM.BIN", (void*)0xb500, &len);
    menuplacebar();
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

char menupulldown(char xpos, char ypos, char menunumber)
{
    char* screen;
    char x;
    char validkeys[6];
    char key;
    char joymask = 3;
    char exit = 0;
    char menuchoice = 1;

    windowsave(ypos, pulldownmenuoptions[menunumber]+4);
    if(menunumber>menubaroptions)
    {
        screen = screenpos(xpos,ypos);
        sprintf(screen,"%c%c",A_FWRED,125);
        screen+=2;
        for(x=0;x<strlen(pulldownmenutitles[menunumber-1][0])+4;x++) { sprintf(screen++,"%c",94); }
    }
    screen = screenpos(xpos,ypos+1);
    for(x=0;x<pulldownmenuoptions[menunumber-1];x++)
    {
        sprintf(screen,"%c%c%c%c%s%c%c%c",
            A_FWRED,91, A_BGCYAN,A_FWBLACK,
            pulldownmenutitles[menunumber-1][x],
            A_FWRED,91,A_BGBLACK);
        screen+=40;
    }
    sprintf(screen,"%c%c",A_FWRED,123);
    screen+=2;
    for(x=0;x<strlen(pulldownmenutitles[menunumber-1][0])+4;x++) { sprintf(screen++,"%c",93); }

    strcpy(validkeys, updownenter);
    if(menunumber<=menubaroptions)
    {
        strcat(validkeys, leftright);
        joymask+=12;
    }
    
    do
    {
        screen = screenpos(xpos+2,ypos+menuchoice);
        sprintf(screen,"%c%c%s%c%c%c",
            A_BGYELLOW,A_FWBLACK,
            pulldownmenutitles[menunumber-1][menuchoice-1],
            A_FWRED,91,A_BGBLACK);
        key = getkey(validkeys, joymask);
        switch (key)
        {
        case 13:
            exit = 1;
            break;
        
        case 8:
        case 9:
            exit = 1;
            menuchoice = 10 + key;
            break;

        case 10:
        case 11:
            screen = screenpos(xpos+2,ypos+menuchoice);
            sprintf(screen,"%c%c%s%c%c%c",
                A_BGCYAN,A_FWBLACK,
                pulldownmenutitles[menunumber-1][menuchoice-1],
                A_FWRED,91,A_BGBLACK);
            if(key==11)
            {
                menuchoice--;
                if(menuchoice<1)
                {
                    menuchoice=pulldownmenuoptions[menunumber-1];
                }
            }
            else
            {
                menuchoice++;
                if(menuchoice>pulldownmenuoptions[menunumber-1])
                {
                    menuchoice = 1;
                }
            }
            break;

        default:
            break;
        }
    } while (exit==0);
    windowrestore();    
    return menuchoice;
}

char menumain()
{
    char menubarchoice = 1;
    char menuoptionchoice = 0;
    char key;
    char validkeys[4] = {8,9,13,0};
    char xpos;

    do
    {
        do
        {
            sprintf(screenpos(menubarcoords[menubarchoice-1],0),
                "%c%s%c", A_BGWHITE,
                menubartitles[menubarchoice-1], A_BGGREEN);
            key = getkey(validkeys, 12);
            sprintf(screenpos(menubarcoords[menubarchoice-1],0),
                "%c%s", A_BGGREEN,
                menubartitles[menubarchoice-1]);
            if(key==8)
            {
                menubarchoice--;
                if(menubarchoice<1)
                {
                    menubarchoice = menubaroptions;
                }
            }
            else if (key==9)
            {
                menubarchoice++;
                if(menubarchoice>menubaroptions)
                {
                    menubarchoice = 1;
                }
            }
        } while (key!=13);
        xpos=menubarcoords[menubarchoice-1]-1;
        if(xpos+strlen(pulldownmenutitles[menubarchoice-1][0])>38)
        {
            xpos=menubarcoords[menubarchoice-1]+strlen(menubartitles[menubarchoice-1])-strlen(pulldownmenutitles[menubarchoice-1][0]);
        }
        menuoptionchoice = menupulldown(xpos,0,menubarchoice);
        if(menuoptionchoice==18)
        {
            menuoptionchoice=0;
            menubarchoice--;
            if(menubarchoice<1)
            {
                    menubarchoice = menubaroptions;
            }
        }
        if(menuoptionchoice==19)
        {
            menuoptionchoice=0;
            menubarchoice++;
            if(menubarchoice>menubaroptions)
            {
                menubarchoice = 1;
            }
        }
    } while (menuoptionchoice==0);
    return menubarchoice*10+menuoptionchoice;    
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

/* Generic input routines */

char getkey(char* allowedkeys, char joystickmask)
{
    char key;

    do
    {
        key = get();
    } while (strchr(allowedkeys, key)==0);
    return key;
}

void wait(unsigned int wait_cs)
 {
 	//we use TIMER3 at adress #276-#277
	doke(0x0276,wait_cs);
	while ( deek(0x0276)>0){};
}