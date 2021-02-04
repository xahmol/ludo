/*
L U D O   MAIN PROGRAM
WRITTEN BY XANDER MOL
CONVERTED TO ORIC ATMOS BASIC IN 2020
CONVERTED TO ORIC ATMOS C IN 2021
ORIGINAL WRITTEN IN 1992 FOR COMMODORE 128
(C)2020 IDREAMTIN8BITS.COM
*/

/* Includes */
#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <string.h>
#include "defines.h"
#include "osdklib.h"
#include "libsedoric.h"
#include "libmymplayer.h"

/* Functions */
void loadintro();
void loadmainscreen();
void gamereset();
void inputofnames();
void turnhuman();
void savegame(unsigned char autosave);
void musicnext();
void windowsave(unsigned char ypos, unsigned char height);
void windowrestore();
void menumakeborder(unsigned char xpos, unsigned char ypos, unsigned char height, unsigned char width);
void menuplacebar();
unsigned char menupulldown(unsigned char xpos, unsigned char ypos, unsigned char menunumber);
unsigned char menumain();
unsigned char areyousure();
unsigned char getkey(unsigned char* allowedkeys, unsigned char joyallowed);
int input(unsigned char xpos, unsigned char ypos, unsigned char *str, unsigned char size);
void wait(unsigned int wait_cs);

/* Variables */

//Window data
struct WindowStruct
{
    unsigned int address;
    unsigned char ypos;
    unsigned char height;
};
struct WindowStruct Window[9];

unsigned int windowaddress = 0xa100;
unsigned char windownumber = 1;

//Menu data
unsigned char menubaroptions = 4;
unsigned char pulldownmenunumber = 8;
unsigned char menubartitles[4][12] = {"Game","Disc","Music","Information"};
unsigned char menubarcoords[4] = {1,6,11,17};
unsigned char pulldownmenuoptions[8] = {3,2,3,1,2,2,3,4};
unsigned char pulldownmenutitles[8][4][16] = {
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
     "Stop         "},
    {"Slot 1: Empty  ",
     "Slot 2: Empty  ",
     "Slot 3: Empty  ",
     "Slot 4: Empty  "}
};

//Input validation strings
unsigned char numbers[11]="0123456789";
unsigned char letters[53]="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
unsigned char updownenter[4] = {C_DOWN,C_UP,C_ENTER,0};
unsigned char leftright[3] = {C_LEFT,C_RIGHT,0};

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
    {{C_DICE01,C_DICE02,0},{C_DICE03,C_DICE04,0}},
    {{C_DICE05,C_DICE06,0},{C_DICE06,C_DICE07,0}},
    {{C_DICE08,C_DICE02,0},{C_DICE03,C_DICE09,0}},
    {{C_DICE05,C_DICE10,0},{C_DICE11,C_DICE07,0}},
    {{C_DICE08,C_DICE12,0},{C_DICE13,C_DICE09,0}},
    {{C_DICE14,C_DICE14,0},{C_DICE15,C_DICE15,0}}
};
unsigned char sc[4][4][2];
unsigned char pm[4];
unsigned char sps[4][21];
unsigned char dp[4];
char np[4];
int pw[3];
unsigned char ei;
unsigned char bs;
unsigned char joyinterface;
unsigned char musicnumber;

/* Main routine */

void main()
{
    unsigned char x, choice;

    joyinterface = 0;
    musicnumber = 1;
    ei = 0;

    //Game intro
    clrscr();
    bgcolor(0);    
    textcolor(3);

    loadintro();

    //Ask for loading save game
    menumakeborder(18,8,6,20);
    gotoxy(20,11);
    cprintf("%cLoad old game?%c",A_FWYELLOW, A_FWRED);
    choice = menupulldown(27,11,5);
    windowrestore();
    //if(choice==1) { loadgame(); }

    //Main game loop
    do
    {
        loadmainscreen();
        if(ei==2)
        {
            ei = 0;
            //placepawnsafterload();
        }
        else
        {
            gamereset();
            inputofnames();
        }
        do
        {
            turnhuman();
        } while (ei==0);
    } while (ei!=1); 

    //End of game
    clrscr();
    bgcolor(0);    
    textcolor(3);
    gotoxy(0,0);
    for(x=0;x<40;x++) { cputc(0); }
    gotoxy(0,1);
    cprintf("%cThanks for playing, goodbye.",A_FWCYAN);
    endmusic();
}

/* Game routines */
void loadintro()
{
    /* Game intro */

    int rc;
    int len = 0;

    rc = loadfile("LUDOTITL.BIN", (void*)0xb500, &len);
    rc = loadfile("LUDOMUS1.BIN", (void*)0x7600, &len);
    rc = loadfile("LUDODATA.COM", (void*)0xb000, &len);
    startmusic();
    cgetc();
}

void loadmainscreen()
{
    /* Function to load main screen and print menu bar */

    int rc;
    int len = 0;
    rc = loadfile("LUDOSCRM.BIN", (void*)0xb500, &len);
    menuplacebar();
}

void gamereset()
{
    /* Reset all player data */

    unsigned char n,m;

    bs=0;
    ei=0;
    for(n=0;n<4;n++)
    {
        sp[n][1]=4;
        sp[n][3]=4;
        np[n]=-1;
        dp[n]=8;
        for(m=0;m<4;m++)
        {
            sc[n][m][0]=1;
            sc[n][m][1]=1;
        }
    }
}

void inputofnames()
{
    /* Enter player nanes */
    unsigned char x, choice;

    menumakeborder(4,8,6,34);
    for(x=0;x<4;x++)
    {
        gotoxy(6,11);
        cprintf("%cComputer plays for player%c %d%c?%c",A_FWYELLOW,A_FWCYAN,x+1,A_FWYELLOW,A_FWRED);
        choice = menupulldown(28,11,5);
        if(choice==1)
        {
            sp[x][0]=1;
        }
        else
        {
            sp[x][0]=0;
        }
        gotoxy(6,11);
        cprintf("%cInput name for player%c %d%c:    %c",A_FWYELLOW,A_FWCYAN,x+1,A_FWYELLOW,A_FWRED);
        input(6,12,sps[x],20);
    }
    windowrestore();
}

void turnhuman()
{
    /* Turn for the human players */

    unsigned char choice;
    unsigned char yesno;

    do
    {
        choice = menumain();
        switch (choice)
        {
            case 12:
                yesno = areyousure();
                if(yesno==1) { ei=3; }
                break;

            case 13:
                yesno = areyousure();
                if(yesno==1) { ei=1; }
                break;

            case 21:
                savegame(0);
                break;

            case 31:
                musicnext();
                break;

            case 32:
                endmusic();
                break;

            case 33:
                endmusic();
                startmusic();
                break;

            default:
                break;
        }
    } while (choice!=C_UP && choice!=12 && choice!=C_ENTER && choice!=22);
}

void savegame(unsigned char autosave)
{
    unsigned int baseaddress = 0xb000;
    unsigned char filename[15];
    unsigned char slot, x;
    unsigned char yesno = 1;

    gotoxy(1,3);
        cprintf("%X,%X,%X", baseaddress, baseaddress+1, peek(baseaddress+slot));
        cgetc();

    if(autosave)
    {
        strcpy(filename,"LUDOSAV0.SAV");
    }
    else
    {
        menumakeborder(7,5,12,31);
        gotoxy(9,8);
        cprintf("%cSave game.%c", A_FWGREEN, A_FWRED);
        gotoxy(9,10);
        cprintf("%cChoose slot:%c", A_FWYELLOW, A_FWRED);
        slot = menupulldown(15,10,8);
        gotoxy(1,3);
        cprintf("%u,%X,%X,%X", slot, baseaddress, baseaddress+slot, peek(baseaddress+slot));
        cgetc();
        if(peek(baseaddress+slot)==1)
        {
            gotoxy(9,10);
            cprintf("%cSlot not empty. Sure?%c", A_FWYELLOW, A_FWRED);
            yesno = menupulldown(15,10,5);
        }
        if(yesno==1)
        {
            gotoxy(9,10);
            cprintf("%cChoose name of save. %c", A_FWYELLOW, A_FWRED);
            input(9,10,pulldownmenutitles[7][slot-1],15);
            for(x=strlen(pulldownmenutitles[7][slot-1]);x<15;x++)
            {
                pulldownmenutitles[7][slot-1][x] = C_SPACE;
            }
            pulldownmenutitles[7][slot-1][15] = 0;
            windowrestore();
            sprintf(filename,"LUDOSAV%d.SAV", slot);
            poke(baseaddress+slot,1);
            for(x=0;x<16;x++)
            {
                poke(baseaddress+(slot*16)+5,pulldownmenutitles[7][slot-1][x]);
            }
            savefile("LUDODATA.COM", (void*)baseaddress, 85);
        }
    }
}

void musicnext()
{
    /* Funtion to load and start next music track */

    int rc;
    int len = 0;
    unsigned char musicfilename[15];

    endmusic();
    if(++musicnumber>3) { musicnumber = 1;}
    sprintf((char*)musicfilename,"LUDOMUS%d.BIN", musicnumber);
    rc = loadfile(musicfilename, (void*)0x7600, &len);
    startmusic();
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
    
    windowsave(ypos, height+2);

    gotoxy(xpos-2,ypos+1);
    cputc(A_STD);
    cputc(A_FWRED);
    cputc(C_LOWRIGHT);
    for(x=0;x<width;x++) {cputc(C_LOWLINE); }
    cputc(C_LOWLEFT);
    for(y=0;y<height;y++)
    {
        gotoxy(xpos-2,ypos+y+2);
        cputc(A_STD);
        cputc(A_FWRED);
        cputc(C_RIGHTLINE);
        for(x=0;x<width;x++) { cputc(C_SPACE ); }
        cputc(C_LEFTLINE);
    }
    gotoxy(xpos-2,ypos+height+2);
    cputc(A_STD);
    cputc(A_FWRED);
    cputc(C_UPRIGHT);
    for(x=0;x<width;x++) { cputc(C_UPLINE); }
    cputc(C_UPLEFT);
}

void menuplacebar()
{
    /* Function to print menu bar */

    unsigned char x;

    gotoxy(0,1);
    cputc(A_FWBLACK);
    cputc(A_BGGREEN);
    for(x=0;x<menubaroptions;x++)
    {
        cprintf("%s ",menubartitles[x]);
    }
}

unsigned char menupulldown(unsigned char xpos, unsigned char ypos, unsigned char menunumber)
{
    /* Function for pull down menu
       Input:
       - xpos = x-coordinate of upper left corner
       - ypos = y-coordinate of upper left corner
       - menunumber = 
         number of the menu as defined in pulldownmenuoptions array */

    unsigned char x;
    unsigned char validkeys[6];
    unsigned char key;
    unsigned char exit = 0;
    unsigned char menuchoice = 1;

    windowsave(ypos, pulldownmenuoptions[menunumber]+4);
    if(menunumber>menubaroptions)
    {
        gotoxy(xpos,ypos+1);
        cputc(A_FWRED);
        cputc(C_LOWRIGHT);
        for(x=0;x<strlen(pulldownmenutitles[menunumber-1][0])+4;x++) { cputc(C_LOWLINE); }
    }
    for(x=0;x<pulldownmenuoptions[menunumber-1];x++)
    {
        gotoxy(xpos,ypos+x+2);
        cprintf("%c%c%c", A_FWRED,C_RIGHTLINE, A_BGCYAN);
        cputc(A_FWBLACK);
        cprintf("%s%c%c%c",            
            pulldownmenutitles[menunumber-1][x],A_FWRED,C_RIGHTLINE,A_BGBLACK);
    }
    gotoxy(xpos,ypos+pulldownmenuoptions[menunumber-1]+2);
    cputc(A_FWRED);
    cputc(C_UPRIGHT);
    for(x=0;x<strlen(pulldownmenutitles[menunumber-1][0])+4;x++) { cputc(C_UPLINE); }

    strcpy(validkeys, updownenter);
    if(menunumber<=menubaroptions)
    {
        strcat(validkeys, leftright);
    }
    
    do
    {
        gotoxy(xpos+2,ypos+menuchoice+1);
        cputc(A_BGYELLOW);
        cputc(A_FWBLACK);
        cprintf("%s%c%c%c",pulldownmenutitles[menunumber-1][menuchoice-1], A_FWRED,C_RIGHTLINE,A_BGBLACK);
        key = getkey(validkeys,joyinterface);
        switch (key)
        {
        case C_ENTER:
            exit = 1;
            break;
        
        case C_LEFT:
        case C_RIGHT:
            exit = 1;
            menuchoice = 10 + key;
            break;

        case C_DOWN:
        case C_UP:
            gotoxy(xpos+2,ypos+menuchoice+1);
            cputc(A_BGCYAN);
            cputc(A_FWBLACK);
            cprintf("%s%c%c%c",pulldownmenutitles[menunumber-1][menuchoice-1],A_FWRED,C_RIGHTLINE,A_BGBLACK);
            if(key==C_UP)
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

unsigned char menumain()
{
    /* Function for main menu selection */

    unsigned char menubarchoice = 1;
    unsigned char menuoptionchoice = 0;
    unsigned char key;
    unsigned char validkeys[4] = {8,9,13,0};
    unsigned char xpos;

    do
    {
        do
        {
            gotoxy(menubarcoords[menubarchoice-1],1);
            cprintf("%c%s%c", A_BGWHITE,menubartitles[menubarchoice-1], A_BGGREEN);
            key = getkey(validkeys,joyinterface);
            gotoxy(menubarcoords[menubarchoice-1],1);
            cprintf("%c%s", A_BGGREEN,menubartitles[menubarchoice-1]);
            if(key==C_LEFT)
            {
                menubarchoice--;
                if(menubarchoice<1)
                {
                    menubarchoice = menubaroptions;
                }
            }
            else if (key==C_RIGHT)
            {
                menubarchoice++;
                if(menubarchoice>menubaroptions)
                {
                    menubarchoice = 1;
                }
            }
        } while (key!=C_ENTER);
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

unsigned char areyousure()
{
    /* Pull down menu to verify if player is sure */
    unsigned char choice;

    menumakeborder(8,8,6,30);
    gotoxy(10,11);
    cprintf("%cAre you sure ?%c", A_FWYELLOW, A_FWRED);
    choice = menupulldown(25,11,5);
    windowrestore();
    return choice;
}

/* Generic input routines */

unsigned char getkey(unsigned char* allowedkeys, unsigned char joyallowed)
{
    /* Function to wait on valid key or joystick press/move
       Input: allowedkeys = string with valid key press options
       Output: key value (or joystick converted to key value)    */

    unsigned char key;

    do
    {
        key = 0;
        /*if(ijk_present && joyallowed)
        {
            ijk_read();
            if(ijk_ljoy&4) { key = C_ENTER; }
            if(ijk_ljoy&1) { key = C_RIGHT; }
            if(ijk_ljoy&2) { key = C_LEFT; }
            if(ijk_ljoy&8) { key = C_DOWN; }
            if(ijk_ljoy&16) { key = C_UP; }
            if(ijk_rjoy&4) { key = C_ENTER; }
            if(ijk_rjoy&1) { key = C_RIGHT; }
            if(ijk_rjoy&2) { key = C_LEFT; }
            if(ijk_rjoy&8) { key = 10; }
            if(ijk_rjoy&16) { key = 11; }
            if(key){
                do
                {
                   ijk_read();
                } while (ijk_ljoy || ijk_rjoy);
            }
        }*/
        if(key == 0)
        {
            if(kbhit()) { key = cgetc();}
        }
    } while (strchr(allowedkeys, key)==0 || key == 0);
    return key;
}

int input(unsigned char xpos, unsigned char ypos, unsigned char *str, unsigned char size)
{
    /**
    * input/modify a string.
    * based on version DraCopy 1.0e, then modified.
    * Created 2009 by Sascha Bader.
    * @param[in] xpos screen x where input starts.
    * @param[in] ypos screen y where input starts.
    * @param[in,out] str string that is edited, it can have content and must have at   least @p size + 1 bytes. Maximum size if 255 bytes.
    * @param[in] size maximum length of @p str in bytes.
    * @return -1 if input was aborted.
    * @return >= 0 length of edited string @p str.
    */

    unsigned char idx = strlen(str);
    unsigned char c, x, b, flag;
    unsigned char validkeys[70] = {C_SPACE ,C_DELETE,0};

    strcat(validkeys,numbers);
    strcat(validkeys,letters);
    strcat(validkeys,updownenter);
    strcat(validkeys,leftright);
  
    gotoxy(xpos,ypos+1);
    cputc(A_FWWHITE);
    for(x=0;x<size;x++) { cputc(C_LOWLINE); }
    cputc(A_FWRED);

    cputsxy(xpos+1, ypos+1, str);
    cputc(C_INVSPACE);
  
    while(1)
    {
        c = getkey(validkeys,0);
        switch (c)
        {
            case C_ENTER:
                idx = strlen(str);
                str[idx] = 0;
                gotoxy(xpos+1,ypos+1);
                for(x=0;x<size;x++) {cputc(C_SPACE ); }
                cputsxy(xpos+1, ypos+1, str);
                return idx;
  
            case C_DELETE:
                if (idx)
                {
                    --idx;
                    cputcxy(xpos+idx+1, ypos+1, ' ');
                    for(x = idx; 1; ++x)
                    {
                        b = str[x+1];
                        str[x] = b;
                        cputcxy(xpos+x+1, ypos+1, b ? b : C_LOWLINE);
                        if (b == 0) { break; }
                    }
                    gotoxy(xpos+idx+1, ypos+1);
                    cputc(str[idx] ? 128+str[idx] : C_INVSPACE);
                    cputc(str[idx+1] ? str[idx+1] : C_LOWLINE);
                    gotoxy(xpos+idx+1, ypos+1);
                }
                break;
  
            case C_LEFT:
                if (idx)
                {
                    --idx;
                    gotoxy(xpos+idx+1, ypos+1);
                    cputc(str[idx] ? 128+str[idx] : C_INVSPACE);
                    cputc(str[idx+1] ? str[idx+1] : C_LOWLINE);
                    gotoxy(xpos+idx+1, ypos+1);
                }
                break;

            case C_RIGHT:
                if (idx < strlen(str) && idx < size)
                {
                    ++idx;
                    gotoxy(xpos+idx, ypos+1);
                    cputc(str[idx-1]);
                    cputc(str[idx] ? 128+str[idx] : C_INVSPACE);
                    gotoxy(xpos + idx + 1, ypos+1);
                }
                break;
  
            default:
                if (idx < size)
                {
                    flag = (str[idx] == 0);
                    str[idx] = c;
                    gotoxy(xpos+idx+1, ypos+1);
                    cputc(c);
                    cputc(C_INVSPACE);
                    ++idx;
                    if (flag) { str[idx+1] = 0; }
                }
                break;
        }
    }
    return 0;
}  

void wait(unsigned int wait_cs)
 {
 	//we use TIMER3 at adress #276-#277
	doke(0x0276,wait_cs);
	while ( deek(0x0276)>0){};
}