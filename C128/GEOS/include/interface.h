#ifndef __INTERFACE_H_
#define __INTERFACE_H_

// Defines
// Values for SetColorMode
#define VDC_CLR0            0       // Monochrome
#define VDC_CLR1            1       // 640x176 8x8 color cards, 16 KB VDC limited to 176 lines
#define VDC_CLR2            2       // 640x200 8x8 color cards, 64 KB VDC
#define VDC_CLR3            3       // 640x200 8x4 color cards, 64 KB VDC
#define VDC_CLR4            4       // 640x200 8x2 color cards, 64 KB VDC

// VDC color values
#define VDC_BLACK	        0
#define VDC_DGREY	        1
#define VDC_DBLUE	        2
#define VDC_LBLUE	        3
#define VDC_DGREEN	        4
#define VDC_LGREEN	        5
#define VDC_DCYAN	        6
#define VDC_LCYAN	        7
#define VDC_DRED	        8
#define VDC_LRED	        9
#define VDC_DPURPLE	        10
#define VDC_LPURPLE	        11
#define VDC_DYELLOW	        12
#define VDC_LYELLOW	        13
#define VDC_LGREY	        14
#define VDC_WHITE	        15

// TED color values
#define TED_BLACK           0
#define TED_WHITE           1
#define TED_RED             2
#define TED_CYAN            3
#define TED_VIOLET          4
#define TED_GREEN           5
#define TED_BLUE            6
#define TED_YELLOW          7
#define TED_ORANGE          8
#define TED_BROWN           9
#define TED_LEMON           10
#define TED_LIGHTVIOLET     11
#define TED_BLUEGREEN       12
#define TED_LIGHTBLUE       13
#define TED_DARKBLUE        14
#define TED_LIGHTGREEN      15

// Global variables
extern char version[25];
extern unsigned char monochromeflag;
extern unsigned char screen_colormode;
extern unsigned int screen_pixel_width;
extern unsigned char screen_pixel_height;
extern unsigned char screen_doubleb;
extern unsigned int screen_doublew;
extern unsigned char color_foreground;
extern unsigned char color_background;
extern unsigned short hdrY;
extern unsigned char osType;
extern unsigned char vdc;
extern unsigned char vdcsize;
extern unsigned char modelines[4];
extern unsigned char cardheigth[4];
extern char appname[21];
extern unsigned char ted_color[16][2];
extern unsigned char gameflag;

// Window definitions
extern struct window *winMain;
extern struct window *winHeader;
extern struct window *winInterface;
extern struct window *winIntShadow;
extern struct window *winIntRecover;

extern struct window vic_winHdr;
extern struct window vic_winMain;
extern struct window vic_winInt;
extern struct window vic_winShd;
extern struct window vic_winRec;

extern struct window vdc_winHdr;
extern struct window vdc_winMain;
extern struct window vdc_winInt;
extern struct window vdc_winShd;
extern struct window vdc_winRec;

// Icons
extern char IconOK[];
extern struct icontab *icons;
extern struct icontab *mainicons;
extern struct icontab *winOK;
extern struct icontab noicons;
extern struct icontab vic_winOK;
extern struct icontab vdc_winOK;

// Import assembly core Functions
void SetColorModeCore();
void ColorCardSetCore();
void ColorCardGetCore();
void ColorRectangleCore();

void VDC_ReadRegister_core();
void VDC_WriteRegister_core();
void VDC_Poke_core();
void VDC_Peek_core();
void VDC_DetectVDCMemSize_core();
void VDC_HChar_core();
void VDC_FillArea_core();
void VIC_HChar_core();
void VIC_FillArea_core();

void enableIO();
void restoreIO();
void primeRnd();
void sidRndCore();

// Variables in core functions
extern unsigned char a_tmp;

extern unsigned char VDC_regadd;
extern unsigned char VDC_regval;
extern unsigned char VDC_addrh;
extern unsigned char VDC_addrl;
extern unsigned char VDC_desth;
extern unsigned char VDC_destl;
extern unsigned char VDC_strideh;
extern unsigned char VDC_stridel;
extern unsigned char VDC_value;
extern unsigned char VDC_tmp1;
extern unsigned char VDC_tmp2;
extern unsigned char VDC_tmp3;
extern unsigned char VDC_tmp4;

// Function prototypes
unsigned int ColorAddress(unsigned int xcoord, unsigned char ycoord);
void SetRectangleCoords(unsigned char top, unsigned char bottom, unsigned int left, unsigned int right);
int StringLength (char* inputstring);
void PutStringCentered(char* inputstring, unsigned char bottom, unsigned int left, unsigned int right);
void PutStringRight(char* inputstring, unsigned char bottom, unsigned int left, unsigned int right);
int CreateWindow(void);
void WinOKButton(void);
void CloseWindow (void);
void ColorRectangle(unsigned char foreground, unsigned char background, unsigned char top, unsigned char bottom, unsigned int left, unsigned int right);
void SetColorMode(unsigned char colormode);
void ColorCardSet(unsigned int xcoord, unsigned char ycoord, unsigned char foreground, unsigned char background );
unsigned char ColorCardGet(unsigned int xcoord, unsigned char ycoord);
void DialogueClearColor();
void DrawBoard(unsigned char coloronly);
unsigned int sidRnd(unsigned int limit);

#endif