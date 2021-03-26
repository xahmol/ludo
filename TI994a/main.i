# 1 "main.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "main.c"
# 60 "main.c"
# 1 "/home/xahmol/libti99/system.h" 1
# 9 "/home/xahmol/libti99/system.h"
void halt() __attribute__ ((noreturn));


void exit() __attribute__ ((noreturn));
# 61 "main.c" 2
# 1 "/home/xahmol/libti99/files.h" 1
# 60 "/home/xahmol/libti99/files.h"
struct __attribute__((__packed__)) PAB {
 unsigned char OpCode;
 unsigned char Status;
 unsigned int VDPBuffer;
 unsigned char RecordLength;
 unsigned char CharCount;
 unsigned int RecordNumber;
 unsigned char ScreenOffset;
 unsigned char NameLength;
 unsigned char *pName;
};




void files(unsigned char count);
# 88 "/home/xahmol/libti99/files.h"
unsigned char dsrlnk(struct PAB *pab, unsigned int vdp);





void dsrlnkraw(unsigned int vdppab);
# 62 "main.c" 2
# 1 "/home/xahmol/libti99/conio.h" 1
# 15 "/home/xahmol/libti99/conio.h"
# 1 "/home/xahmol/libti99/vdp.h" 1
# 27 "/home/xahmol/libti99/vdp.h"
inline void VDP_SET_ADDRESS(unsigned int x) { *((volatile unsigned char*)0x8C02)=((x)&0xff); *((volatile unsigned char*)0x8C02)=((x)>>8); }


inline void VDP_SET_ADDRESS_WRITE(unsigned int x) { *((volatile unsigned char*)0x8C02)=((x)&0xff); *((volatile unsigned char*)0x8C02)=(((x)>>8)|0x40); }


inline void VDP_SET_REGISTER(unsigned char r, unsigned char v) { *((volatile unsigned char*)0x8C02)=(v); *((volatile unsigned char*)0x8C02)=(0x80|(r)); }


inline int VDP_SCREEN_POS(unsigned int r, unsigned int c) { return (((r)<<5)+(c)); }


inline int VDP_SCREEN_TEXT(unsigned int r, unsigned int c) { return (((r)<<5)+((r)<<3)+(c)); }


inline int VDP_SCREEN_TEXT80(unsigned int r, unsigned int c) { return (((r)<<6)+((r)<<4)+(c)); }




inline int VDP_SCREEN_TEXT64(unsigned int r, unsigned int c) { return (((r)<<6)+(c)); }
# 174 "/home/xahmol/libti99/vdp.h"
int set_graphics_raw(int sprite_mode);

void set_graphics(int sprite_mode);





int set_text_raw();

void set_text();





int set_text80_raw();

void set_text80();







int set_text80_color_raw();

void set_text80_color();







int set_text80x30_color_raw();

void set_text80x30_color();





void set_text64_color();







int set_multicolor_raw(int sprite_mode);

void set_multicolor(int sprite_mode);





int set_bitmap_raw(int sprite_mode);

void set_bitmap(int sprite_mode);




void writestring(int row, int col, char *pStr);



void vdpmemset(int pAddr, int ch, int cnt);



void vdpmemcpy(int pAddr, const unsigned char *pSrc, int cnt);



void vdpmemread(int pAddr, unsigned char *pDest, int cnt);





void vdpwriteinc(int pAddr, int nStart, int cnt);




extern void (*vdpchar)(int pAddr, int ch);
void vdpchar_default(int pAddr, int ch);




unsigned char vdpreadchar(int pAddr);



void vdpwritescreeninc(int pAddr, int nStart, int cnt);



void vdpscreenchar(int pAddr, int ch);



void vdpwaitvint();







int putchar(int x);







void putstring(char *s);



int puts(char *s);






int printf(char *str, ...);


void hexprint(unsigned char x);



void fast_hexprint(unsigned char x);



void faster_hexprint(unsigned char x);



void scrn_scroll_default();
extern void (*scrn_scroll)();


void fast_scrn_scroll();




void hchar(int r, int c, int ch, int cnt);




void vchar(int r, int c, int ch, int cnt);




unsigned char gchar(int r, int c);






void sprite(int n, int ch, int col, int r, int c);



void delsprite(int n);



void charset();




void charsetlc();
# 372 "/home/xahmol/libti99/vdp.h"
void gplvdp(int vect, int adr, int cnt);


void bm_setforeground(int c);


void bm_setbackground(int c);



void bm_clearscreen();




void bm_setpixel(unsigned int x, unsigned int y);




void bm_clearpixel(unsigned int x, unsigned int y);


void bm_drawline(int x0, int y0, int x1, int y1);







void bm_drawlinefast(int x0, int y0, int x1, int y1, int mode);



void bm_sethlinefast(unsigned int x0, unsigned int y0, unsigned int x1);


void bm_clearhlinefast(unsigned int x0, unsigned int y0, unsigned int x1);




void bm_consolefont();




void bm_putc(int c, int r, unsigned char alphanum);





void bm_puts(int c, int r, unsigned char* str);




void bm_placetile(int c, int r, const unsigned char* pattern);






extern unsigned char gBitmapColor;





extern unsigned char* gBmFont;




extern unsigned int gImage;
extern unsigned int gColor;
extern unsigned int gPattern;
extern unsigned int gSprite;
extern unsigned int gSpritePat;


extern int nTextRow,nTextEnd;
extern int nTextPos,nTextFlags;
# 472 "/home/xahmol/libti99/vdp.h"
extern unsigned char gSaveIntCnt;


extern const unsigned int byte2hex[256];



void unlock_f18a();


void lock_f18a();
# 16 "/home/xahmol/libti99/conio.h" 2
# 1 "/home/xahmol/tms9900gcc/lib/gcc/tms9900/4.4.0/include/stdarg.h" 1 3 4
# 40 "/home/xahmol/tms9900gcc/lib/gcc/tms9900/4.4.0/include/stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 102 "/home/xahmol/tms9900gcc/lib/gcc/tms9900/4.4.0/include/stdarg.h" 3 4
typedef __gnuc_va_list va_list;
# 17 "/home/xahmol/libti99/conio.h" 2


extern int conio_x,conio_y;
unsigned int conio_getvram();


extern unsigned int conio_scrnCol;
unsigned int bgcolor(unsigned int color);


unsigned int bordercolor(unsigned int x);


void cclear(unsigned int length);


void cclearxy(int col, int row, int v);


extern int conio_cursorFlag;
extern int conio_cursorChar;
unsigned char cgetc();


void chline(int v);


void chlinexy(int xx, int yy, int v);


void clrscr();


int cprintf(const char *fmt, ...);


void cputc(int ch);


void cputcxy(int xx, int yy, int ch);


void cputs(const char *s);


void cputsxy(int xx, int yy, const char *s);





void cvline(int len);


void cvlinexy(int x, int y, int len);
# 83 "/home/xahmol/libti99/conio.h"
unsigned char kbhit();


unsigned char reverse(unsigned char x);


void screensize(unsigned char *x, unsigned char *y);



unsigned int textcolor(unsigned int color);


int vcprintf(const char *fmt, va_list argp);


inline int wherex() { return conio_x; }


inline int wherey() { return conio_y; }
# 63 "main.c" 2
# 1 "/home/xahmol/libti99/kscan.h" 1
# 54 "/home/xahmol/libti99/kscan.h"
unsigned char kscan(unsigned char mode);





void kscanfast(int mode);



void joystfast(int unit);
# 64 "main.c" 2
# 1 "/home/xahmol/libti99/string.h" 1







int strlen(const char *s);



int atoi(char *s);


char *strcpy(char *d, const char *s);



int strcmp(const char *s1, const char *s2);



int memcmp(const void *s1, const void *s2, int n);


void *memcpy(void *dest, const void *src, int cnt);


void *memset(void *dest, int src, int cnt);



char *uint2str(unsigned int x);



char *int2str(int x);



char* uint2hex(unsigned int x);




void gets(char *buf, int maxlen);
# 65 "main.c" 2
# 1 "/home/xahmol/libti99/vdp.h" 1
# 66 "main.c" 2
# 1 "/home/xahmol/vgmcomp2/Players/libtivgm2/TISNPlay.h" 1
# 13 "/home/xahmol/vgmcomp2/Players/libtivgm2/TISNPlay.h"
typedef int int16;
typedef unsigned int uint16;
typedef unsigned char uint8;
typedef unsigned char uWordSize;



typedef struct STRTYPE STREAM;
struct STRTYPE {
    uint8 *curPtr;
    uint8 *mainPtr;
    uint8 (*curType)(STREAM*, uint8*);
    uWordSize curBytes;

    uWordSize framesLeft;
};




void StartSong(const unsigned char *pSbf, uWordSize songNum);


void StopSong();


void SongLoop();


void SongLoop30();
# 54 "/home/xahmol/vgmcomp2/Players/libtivgm2/TISNPlay.h"
extern uint8 songVol[4];
# 64 "/home/xahmol/vgmcomp2/Players/libtivgm2/TISNPlay.h"
extern uint16 songNote[4];
# 67 "main.c" 2
# 1 "/home/xahmol/libti99/sound.h" 1
# 40 "/home/xahmol/libti99/sound.h"
inline void SET_SOUND_PTR(unsigned int x) { *((volatile unsigned int*)0x83cc) = x; }


inline void SET_SOUND_VDP() { *((volatile unsigned char*)0x83fd) |= 0x01; }


inline void SET_SOUND_GROM() { *((volatile unsigned char*)0x83fd) &= ~0x01; }


inline void START_SOUND() { *((volatile unsigned char*)0x83ce) = 1; }


inline void MUTE_SOUND() { *((volatile unsigned char*)0x8400)=0x90|0x0f; *((volatile unsigned char*)0x8400)=0xB0|0x0f; *((volatile unsigned char*)0x8400)=0xD0|0x0f; *((volatile unsigned char*)0x8400)=0xF0|0x0f; }
# 68 "main.c" 2
# 1 "graphics.h" 1
static const unsigned char colorset[] = {
0x81,
0x1f,
0x1f,
0x1f,
0xb1,
0xb1,
0xb1,
0xb1,
0xb1,
0xb1,
0xb1,
0xb1,
0xb1,
0xb1,
0xb1,
0xb1,
0x21,
0x81,
0x41,
0xa1,
0xf1,
0x21,
0x81,
0x41,
0xa1,
};
static const unsigned char patterns[] = {
0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,
0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x01,
0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,
0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x80,
0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x03,
0x00,0x00,0x00,0x00,0x00,0x00,0x80,0xc0,
0x03,0x01,0x00,0x00,0x00,0x00,0x00,0x00,
0xc0,0x80,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x0c,0x1e,0x1e,0x0c,0x00,0x00,0x00,
0x00,0x00,0x00,0x30,0x78,0x78,0x30,0x00,
0x00,0x0c,0x1e,0x1e,0x0c,0x00,0x80,0xc0,
0x03,0x01,0x00,0x30,0x78,0x78,0x30,0x00,
0x00,0x30,0x78,0x78,0x30,0x00,0x00,0x00,
0x00,0x00,0x00,0x0c,0x1e,0x1e,0x0c,0x00,
0x00,0x30,0x78,0x78,0x30,0x00,0x01,0x03,
0xc0,0x80,0x00,0x0c,0x1e,0x1e,0x0c,0x00,
0x00,0x30,0x78,0x78,0x30,0x00,0x30,0x78,
0x00,0x0c,0x1e,0x1e,0x0c,0x00,0x0c,0x1e,
0x78,0x30,0x00,0x30,0x78,0x78,0x30,0x00,
0x1e,0x0c,0x00,0x0c,0x1e,0x1e,0x0c,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x18,0x3c,0x3c,0x18,0x18,0x00,0x18,0x00,
0x6c,0x6c,0x00,0x00,0x00,0x00,0x00,0x00,
0x6c,0x6c,0xfe,0x6c,0xfe,0x6c,0x6c,0x00,
0x18,0x3e,0x60,0x3c,0x06,0x7c,0x18,0x00,
0x00,0xc6,0xcc,0x18,0x30,0x66,0xc6,0x00,
0x38,0x6c,0x68,0x76,0xdc,0xcc,0x76,0x00,
0x0c,0x0c,0x10,0x00,0x00,0x00,0x00,0x00,
0x0c,0x18,0x30,0x30,0x30,0x18,0x0c,0x00,
0x30,0x18,0x0c,0x0c,0x0c,0x18,0x30,0x00,
0x00,0x66,0x3c,0xff,0x3c,0x66,0x00,0x00,
0x00,0x18,0x18,0x7e,0x18,0x18,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x18,0x18,0x30,
0x00,0x00,0x00,0x7e,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x18,0x18,0x00,
0x03,0x06,0x0c,0x18,0x30,0x60,0xc0,0x00,
0x3c,0x66,0x6e,0x7e,0x76,0x66,0x3c,0x00,
0x18,0x18,0x38,0x18,0x18,0x18,0x7e,0x00,
0x3c,0x66,0x06,0x0c,0x30,0x66,0x7e,0x00,
0x3c,0x66,0x06,0x1c,0x06,0x66,0x3c,0x00,
0x1c,0x3c,0x6c,0xcc,0xfe,0x0c,0x1e,0x00,
0x7e,0x60,0x7c,0x06,0x06,0x66,0x3c,0x00,
0x1c,0x30,0x60,0x7c,0x66,0x66,0x3c,0x00,
0x7e,0x66,0x06,0x0c,0x18,0x18,0x18,0x00,
0x3c,0x66,0x66,0x3c,0x66,0x66,0x3c,0x00,
0x3c,0x66,0x66,0x3e,0x06,0x0c,0x38,0x00,
0x00,0x18,0x18,0x00,0x18,0x18,0x00,0x00,
0x00,0x18,0x18,0x00,0x00,0x18,0x18,0x30,
0x0c,0x18,0x30,0x60,0x30,0x18,0x0c,0x00,
0x00,0x00,0x7e,0x00,0x7e,0x00,0x00,0x00,
0x30,0x18,0x0c,0x06,0x0c,0x18,0x30,0x00,
0x3c,0x66,0x06,0x0c,0x18,0x00,0x18,0x00,
0x3c,0x42,0x99,0xa1,0xa1,0x99,0x42,0x3c,
0x18,0x3c,0x3c,0x66,0x7e,0xc3,0xc3,0x00,
0xfc,0x66,0x66,0x7c,0x66,0x66,0xfc,0x00,
0x3c,0x66,0xc0,0xc0,0xc0,0x66,0x3c,0x00,
0xf8,0x6c,0x66,0x66,0x66,0x6c,0xf8,0x00,
0xfe,0x66,0x60,0x78,0x60,0x66,0xfe,0x00,
0xfe,0x66,0x60,0x78,0x60,0x60,0xf0,0x00,
0x3c,0x66,0xc0,0xce,0xc6,0x66,0x3c,0x00,
0x66,0x66,0x66,0x7e,0x66,0x66,0x66,0x00,
0x7e,0x18,0x18,0x18,0x18,0x18,0x7e,0x00,
0x3c,0x0c,0x0c,0x0c,0xcc,0xcc,0x78,0x00,
0xe6,0x66,0x6c,0x70,0x6c,0x66,0xe6,0x00,
0xf0,0x60,0x60,0x60,0x62,0x66,0xfe,0x00,
0x82,0xc6,0xee,0xfe,0xd6,0xc6,0xc6,0x00,
0xc6,0xe6,0xf6,0xde,0xce,0xc6,0xc6,0x00,
0x38,0x6c,0xc6,0xc6,0xc6,0x6c,0x38,0x00,
0xfc,0x66,0x66,0x7c,0x60,0x60,0xf0,0x00,
0x38,0x6c,0xc6,0xc6,0xc6,0x6c,0x3c,0x06,
0xfc,0x66,0x66,0x7c,0x6c,0x66,0xe3,0x00,
0x3c,0x66,0x70,0x38,0x0e,0x66,0x3c,0x00,
0x7e,0x5a,0x18,0x18,0x18,0x18,0x3c,0x00,
0x66,0x66,0x66,0x66,0x66,0x66,0x3e,0x00,
0xc3,0xc3,0x66,0x66,0x3c,0x3c,0x18,0x00,
0xc6,0xc6,0xc6,0xd6,0xfe,0xee,0xc6,0x00,
0xc3,0x66,0x3c,0x18,0x3c,0x66,0xc3,0x00,
0xc3,0xc3,0x66,0x3c,0x18,0x18,0x3c,0x00,
0xfe,0xc6,0x8c,0x18,0x32,0x66,0xfe,0x00,
0x3c,0x30,0x30,0x30,0x30,0x30,0x3c,0x00,
0xc0,0x60,0x30,0x18,0x0c,0x06,0x03,0x00,
0x3c,0x0c,0x0c,0x0c,0x0c,0x0c,0x3c,0x00,
0x10,0x38,0x6c,0xc6,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,
0x00,0x00,0x20,0x10,0x08,0x00,0x00,0x00,
0x00,0x00,0x78,0x0c,0x7c,0xcc,0x76,0x00,
0xe0,0x60,0x6c,0x76,0x66,0x66,0x3c,0x00,
0x00,0x00,0x3c,0x66,0x60,0x66,0x3c,0x00,
0x1c,0x0c,0x6c,0xdc,0xcc,0xcc,0x76,0x00,
0x00,0x00,0x3c,0x66,0x7e,0x60,0x3c,0x00,
0x1c,0x36,0x30,0x78,0x30,0x30,0x78,0x00,
0x00,0x00,0x3b,0x66,0x66,0x3c,0xc6,0x7c,
0xe0,0x60,0x6c,0x76,0x66,0x66,0xe6,0x00,
0x18,0x00,0x38,0x18,0x18,0x18,0x3c,0x00,
0x0c,0x00,0x0c,0x0c,0x0c,0x0c,0xcc,0x78,
0xe0,0x60,0x66,0x6c,0x78,0x6c,0xe6,0x00,
0x38,0x18,0x18,0x18,0x18,0x18,0x3c,0x00,
0x00,0x00,0xcc,0xee,0xd6,0xc6,0xc6,0x00,
0x00,0x00,0x7c,0x66,0x66,0x66,0x66,0x00,
0x00,0x00,0x3c,0x66,0x66,0x66,0x3c,0x00,
0x00,0x00,0xbc,0x66,0x66,0x7c,0x60,0xf0,
0x00,0x00,0x7a,0xcc,0xcc,0x7c,0x0c,0x0e,
0x00,0x00,0xac,0x76,0x66,0x60,0xf0,0x00,
0x00,0x00,0x3e,0x60,0x3c,0x06,0x7c,0x00,
0x10,0x30,0x7c,0x30,0x30,0x34,0x18,0x00,
0x00,0x00,0xcc,0xcc,0xcc,0xcc,0x72,0x00,
0x00,0x00,0x66,0x66,0x66,0x3c,0x18,0x00,
0x00,0x00,0xc6,0xd6,0xd6,0x6c,0x6c,0x00,
0x00,0x00,0xc6,0x6c,0x38,0x6c,0xc6,0x00,
0x00,0x00,0x66,0x66,0x66,0x3c,0x18,0x70,
0x00,0x00,0x7e,0x4c,0x18,0x32,0x7e,0x00,
0x18,0x20,0x20,0x40,0x20,0x20,0x18,0x00,
0x10,0x10,0x10,0x00,0x10,0x10,0x10,0x00,
0x30,0x08,0x08,0x04,0x08,0x08,0x30,0x00,
0x00,0x20,0x54,0x08,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x03,0x0f,0x1f,0x3f,0x1f,0x0f,0x07,0x0f,
0xc0,0xf0,0xf8,0xfc,0xf8,0xf0,0xe0,0xf0,
0x07,0x0f,0x1f,0x1f,0x3f,0x3f,0x3f,0x00,
0xe0,0xf0,0xf8,0xf8,0xfc,0xfc,0xfc,0x00,
0x00,0x00,0x01,0x07,0x0f,0x1f,0x1f,0x3f,
0x00,0x00,0x80,0xe0,0xf0,0xf8,0xf8,0xfc,
0x3f,0x1f,0x1f,0x0f,0x07,0x01,0x00,0x00,
0xfc,0xf8,0xf8,0xf0,0xe0,0x80,0x00,0x00,
0x03,0x0f,0x1f,0x3f,0x1f,0x0f,0x07,0x0f,
0xc0,0xf0,0xf8,0xfc,0xf8,0xf0,0xe0,0xf0,
0x07,0x0f,0x1f,0x1f,0x3f,0x3f,0x3f,0x00,
0xe0,0xf0,0xf8,0xf8,0xfc,0xfc,0xfc,0x00,
0x00,0x00,0x01,0x07,0x0f,0x1f,0x1f,0x3f,
0x00,0x00,0x80,0xe0,0xf0,0xf8,0xf8,0xfc,
0x3f,0x1f,0x1f,0x0f,0x07,0x01,0x00,0x00,
0xfc,0xf8,0xf8,0xf0,0xe0,0x80,0x00,0x00,
0x03,0x0f,0x1f,0x3f,0x1f,0x0f,0x07,0x0f,
0xc0,0xf0,0xf8,0xfc,0xf8,0xf0,0xe0,0xf0,
0x07,0x0f,0x1f,0x1f,0x3f,0x3f,0x3f,0x00,
0xe0,0xf0,0xf8,0xf8,0xfc,0xfc,0xfc,0x00,
0x00,0x00,0x01,0x07,0x0f,0x1f,0x1f,0x3f,
0x00,0x00,0x80,0xe0,0xf0,0xf8,0xf8,0xfc,
0x3f,0x1f,0x1f,0x0f,0x07,0x01,0x00,0x00,
0xfc,0xf8,0xf8,0xf0,0xe0,0x80,0x00,0x00,
0x03,0x0f,0x1f,0x3f,0x1f,0x0f,0x07,0x0f,
0xc0,0xf0,0xf8,0xfc,0xf8,0xf0,0xe0,0xf0,
0x07,0x0f,0x1f,0x1f,0x3f,0x3f,0x3f,0x00,
0xe0,0xf0,0xf8,0xf8,0xfc,0xfc,0xfc,0x00,
0x00,0x00,0x01,0x07,0x0f,0x1f,0x1f,0x3f,
0x00,0x00,0x80,0xe0,0xf0,0xf8,0xf8,0xfc,
0x3f,0x1f,0x1f,0x0f,0x07,0x01,0x00,0x00,
0xfc,0xf8,0xf8,0xf0,0xe0,0x80,0x00,0x00,
0x03,0x0f,0x1f,0x3f,0x1f,0x0f,0x07,0x0f,
0xc0,0xf0,0xf8,0xfc,0xf8,0xf0,0xe0,0xf0,
0x07,0x0f,0x1f,0x1f,0x3f,0x3f,0x3f,0x00,
0xe0,0xf0,0xf8,0xf8,0xfc,0xfc,0xfc,0x00,
0x00,0x00,0x01,0x06,0x08,0x10,0x10,0x20,
0x00,0x00,0x80,0x60,0x10,0x08,0x08,0x04,
0x20,0x10,0x10,0x08,0x06,0x01,0x00,0x00,
0x04,0x08,0x08,0x10,0x60,0x80,0x00,0x00,
0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x01,0x07,0x0f,0x1f,0x1f,0x38,
0x00,0x00,0x80,0xe0,0xf0,0x78,0x38,0x1c,
0x38,0x1f,0x1f,0x0f,0x07,0x01,0x00,0x00,
0x1c,0x38,0x78,0xf0,0xe0,0x80,0x00,0x00,
0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
0x00,0x08,0x0c,0x7e,0x7e,0x0c,0x08,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x01,0x07,0x0f,0x1e,0x1e,0x3e,
0x00,0x00,0x80,0xe0,0xf0,0x78,0x78,0x7c,
0x38,0x1c,0x1e,0x0f,0x07,0x01,0x00,0x00,
0x1c,0x38,0x78,0xf0,0xe0,0x80,0x00,0x00,
0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x01,0x07,0x0f,0x1e,0x1c,0x38,
0x00,0x00,0x80,0xe0,0xf0,0xf8,0xf8,0x1c,
0x38,0x1c,0x1e,0x0f,0x07,0x01,0x00,0x00,
0x1c,0xf8,0xf8,0xf0,0xe0,0x80,0x00,0x00,
0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x01,0x07,0x0f,0x1e,0x1c,0x38,
0x00,0x00,0x80,0xe0,0xf0,0x78,0x38,0x1c,
0x3e,0x1e,0x1e,0x0f,0x07,0x01,0x00,0x00,
0x7c,0x78,0x78,0xf0,0xe0,0x80,0x00,0x00,
};
static const unsigned char mainscreen[] = {
0x4c,0x55,0x44,0x4f,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x80,0x81,0x80,0x81,0x20,0x20,0x20,0x20,0xa4,0xa5,0xa4,0xa5,0xb4,0xb5,0x20,0x20,0x20,0x20,0x88,0x89,0x88,0x89,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x82,0x83,0x82,0x83,0x20,0x20,0x20,0x20,0xa6,0xa7,0xa6,0xa7,0xb6,0xb7,0x20,0x20,0x20,0x20,0x8a,0x8b,0x8a,0x8b,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x80,0x81,0x80,0x81,0x20,0x20,0x20,0x20,0xa4,0xa5,0x8c,0x8d,0xa4,0xa5,0x20,0x20,0x20,0x20,0x88,0x89,0x88,0x89,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x82,0x83,0x82,0x83,0x20,0x20,0x20,0x20,0xa6,0xa7,0x8e,0x8f,0xa6,0xa7,0x20,0x20,0x20,0x20,0x8a,0x8b,0x8a,0x8b,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0xa4,0xa5,0x8c,0x8d,0xa4,0xa5,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0xa6,0xa7,0x8e,0x8f,0xa6,0xa7,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0xa4,0xa5,0x8c,0x8d,0xa4,0xa5,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0xa6,0xa7,0x8e,0x8f,0xa6,0xa7,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0xac,0xad,0xa4,0xa5,0xa4,0xa5,0xa4,0xa5,0xa4,0xa5,0x8c,0x8d,0xa4,0xa5,0xa4,0xa5,0xa4,0xa5,0xa4,0xa5,0xa4,0xa5,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0xae,0xaf,0xa6,0xa7,0xa6,0xa7,0xa6,0xa7,0xa6,0xa7,0x8e,0x8f,0xa6,0xa7,0xa6,0xa7,0xa6,0xa7,0xa6,0xa7,0xa6,0xa7,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0xa4,0xa5,0x84,0x85,0x84,0x85,0x84,0x85,0x84,0x85,0x20,0x20,0x94,0x95,0x94,0x95,0x94,0x95,0x94,0x95,0xa4,0xa5,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0xa6,0xa7,0x86,0x87,0x86,0x87,0x86,0x87,0x86,0x87,0x20,0x20,0x96,0x97,0x96,0x97,0x96,0x97,0x96,0x97,0xa6,0xa7,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0xa4,0xa5,0xa4,0xa5,0xa4,0xa5,0xa4,0xa5,0xa4,0xa5,0x9c,0x9d,0xa4,0xa5,0xa4,0xa5,0xa4,0xa5,0xa4,0xa5,0xbc,0xbd,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0xa6,0xa7,0xa6,0xa7,0xa6,0xa7,0xa6,0xa7,0xa6,0xa7,0x9e,0x9f,0xa6,0xa7,0xa6,0xa7,0xa6,0xa7,0xa6,0xa7,0xbe,0xbf,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0xa4,0xa5,0x9c,0x9d,0xa4,0xa5,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0xa6,0xa7,0x9e,0x9f,0xa6,0xa7,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0xa4,0xa5,0x9c,0x9d,0xa4,0xa5,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0xa6,0xa7,0x9e,0x9f,0xa6,0xa7,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x98,0x99,0x98,0x99,0x20,0x20,0x20,0x20,0xa4,0xa5,0x9c,0x9d,0xa4,0xa5,0x20,0x20,0x20,0x20,0x90,0x91,0x90,0x91,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x9a,0x9b,0x9a,0x9b,0x20,0x20,0x20,0x20,0xa6,0xa7,0x9e,0x9f,0xa6,0xa7,0x20,0x20,0x20,0x20,0x92,0x93,0x92,0x93,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x98,0x99,0x98,0x99,0x20,0x20,0x20,0x20,0xc4,0xc5,0xa4,0xa5,0xa4,0xa5,0x20,0x20,0x20,0x20,0x90,0x91,0x90,0x91,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x9a,0x9b,0x9a,0x9b,0x20,0x20,0x20,0x20,0xc6,0xc7,0xa6,0xa7,0xa6,0xa7,0x20,0x20,0x20,0x20,0x92,0x93,0x92,0x93,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
};
static const unsigned char titlescreen[] = {
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x49,0x44,0x72,0x65,0x61,0x6d,0x74,0x49,0x6e,0x38,0x42,0x69,0x74,0x73,0x2e,0x63,0x6f,0x6d,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x70,0x72,0x65,0x73,0x65,0x6e,0x74,0x73,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x80,0x81,0x20,0x20,0x9c,0x9d,0x20,0x20,0x20,0x9c,0x9d,0x20,0x9c,0x9d,0x20,0x9c,0xc0,0xc0,0xc0,0x9d,0x20,0x20,0x9c,0xc0,0xc0,0xc0,0x9d,0x20,0x88,0x89,0x20,
0x20,0x82,0x83,0x20,0x20,0xc0,0xc0,0x20,0x20,0x20,0xc0,0xc0,0x20,0xc0,0xc0,0x20,0xc0,0xc0,0x20,0x20,0x9e,0x9d,0x20,0xc0,0xc0,0x20,0xc0,0xc0,0x20,0x8a,0x8b,0x20,
0x20,0x20,0x20,0x20,0x20,0xa8,0xa8,0x20,0x20,0x20,0xa8,0xa8,0x20,0xa8,0xa8,0x20,0xa8,0xa8,0x20,0x20,0x20,0xa8,0x20,0xa8,0xa8,0x20,0xa8,0xa8,0x20,0x20,0x20,0x20,
0x20,0x98,0x99,0x20,0x20,0xa8,0xa8,0x20,0x20,0x20,0xa8,0xa8,0x20,0xa8,0xa8,0x20,0xa8,0xa8,0x20,0x20,0x84,0x87,0x20,0xa8,0xa8,0x20,0xa8,0xa8,0x20,0x90,0x91,0x20,
0x20,0x9a,0x9b,0x20,0x20,0x96,0xb8,0xb8,0xb8,0x20,0x96,0xb8,0xb8,0xb8,0x97,0x20,0x96,0xb8,0xb8,0xb8,0x97,0x20,0x20,0x96,0xb8,0xb8,0xb8,0x97,0x20,0x92,0x93,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x57,0x72,0x69,0x74,0x74,0x65,0x6e,0x20,0x62,0x79,0x20,0x58,0x61,0x6e,0x64,0x65,0x72,0x20,0x4d,0x6f,0x6c,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x08,0x09,0x20,0x15,0x16,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x0a,0x0b,0x20,0x17,0x18,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
};
# 69 "main.c" 2
# 1 "defines.h" 1
# 70 "main.c" 2




struct WindowStruct
{
    unsigned int address;
    unsigned char ypos;
    unsigned char height;
};
struct WindowStruct Window[9];

unsigned int windowaddress;
unsigned char windowmemory[768];
unsigned char windownumber = 0;


unsigned char menubaroptions = 4;
unsigned char pulldownmenunumber = 8;
unsigned char menubartitles[4][12] = {"Game","Disc","Music","Info"};
unsigned char menubarcoords[4] = {6,11,16,22};
unsigned char pulldownmenuoptions[8] = {3,3,3,1,2,2,3,5};
unsigned char pulldownmenutitles[8][5][16] = {
    {"Throw dice",
     "Restart   ",
     "Stop      "},
    {"Save game   ",
     "Load game   ",
     "Autosave off"},
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
    {"Autosave       ",
     "Slot 1: Empty  ",
     "Slot 2: Empty  ",
     "Slot 3: Empty  ",
     "Slot 4: Empty  "}
};


unsigned char numbers[11]="0123456789";
unsigned char letters[53]="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
unsigned char updownenter[4] = {10,11,13,0};
unsigned char leftright[3] = {8,9,0};


unsigned char fieldcoords[40][2] = {
     { 0,10}, { 2,10}, { 4,10}, { 6,10}, { 8,10},
     { 8, 8}, { 8, 6}, { 8, 4}, { 8, 2}, {10, 2},
     {12, 2}, {12, 4}, {12, 6}, {12, 8}, {12,10},
     {14,10}, {16,10}, {18,10}, {20,10}, {20,12},
     {20,14}, {18,14}, {16,14}, {14,14}, {12,14},
     {12,16}, {12,18}, {12,20}, {12,22}, {10,22},
     { 8,22}, { 8,20}, { 8,18}, { 8,16}, { 8,14},
     { 6,14}, { 4,14}, { 2,14}, { 0,14}, { 0,12}
};

unsigned char homedestcoords[4][8][2] = {
    {{ 0, 2}, { 2, 2}, { 0, 4}, { 2, 4}, { 2,12}, { 4,12}, { 6,12}, { 8,12}},
    {{18, 2}, {20, 2}, {18, 4}, {20, 4}, {10, 4}, {10, 6}, {10, 8}, {10,10}},
    {{18,20}, {20,20}, {18,22}, {20,22}, {18,12}, {16,12}, {14,12}, {12,12}},
    {{ 0,20}, { 2,20}, { 0,22}, { 2,22}, {10,20}, {10,18}, {10,16}, {10,14}}
};






unsigned char playerdata[4][4] = {
    {0,4,168,4},
    {0,4,176,4},
    {0,4,184,4},
    {0,4,192,4}
};





unsigned char playerpos[4][4][2] = {
    {{1,0}, {1,1}, {1,2}, {1,3}},
    {{1,0}, {1,1}, {1,2}, {1,3}},
    {{1,0}, {1,1}, {1,2}, {1,3}},
    {{1,0}, {1,1}, {1,2}, {1,3}}
};

unsigned char playername[4][9] = { "","","","" };

signed char np[4] = { -1, -1, -1, -1};
unsigned char dp[4] = { 8, 8, 8, 8 };


unsigned char dicegraphics[6][4] = {
    {8,9,10,11},
    {12,13,14,12},
    {8,15,16,11},
    {17,13,14,18},
    {19,15,16,20},
    {21,22,23,24}
};


unsigned char endofgameflag = 0;
unsigned char turnofplayernr = 0;
unsigned char zv = 0;
unsigned char ns = 0;
unsigned char throw;
unsigned char musicnumber = 1;
unsigned char joyinterface = 1;
unsigned char autosavetoggle = 1;


unsigned char saveslots[85];
unsigned char savegamemem[136];


unsigned char musicmem[3200];


unsigned char* strcat(unsigned char *dest, unsigned const char *src)
{



    strcpy (dest + strlen (dest), src);
    return dest;
}

unsigned char* strchr(unsigned register const char *s, unsigned int c)
{





    do {
      if (*s == c)
        {
          return (char*)s;
        }
    } while (*s++);
    return (0);
}

static unsigned int random(void)
{



 static unsigned int seed = 0xaaaa;
 static const unsigned int random_mask = 0xb400;

 __asm__(
  "srl %0,1  \n\t"
  "jnc 1f    \n\t"
  "xor %2,%0 \n\t"
  "1:        \n\t"
  : "=r"(seed)
  : "0"(seed),"m"(random_mask)
 );
 return seed;
}

void wait(unsigned int jiffies)
{




    for(int i=0; i < jiffies; i++) {
        __asm__( "clr r12\n\ttb 2\n\tjeq -4\n\tmovb @>8802,r12" : : : "r12" );;
        if(musicnumber)
        {
            __asm__( "bl @SongLoop" : : : "r0","r1","r2","r3","r4","r5","r6","r7","r8","r9","r11","r12","r13","r14","r15","cc" );
            if (!((songNote[3]&0x01) != 0)) { StartSong(musicmem,0); }
        }
    }
}



unsigned char dsr_load(unsigned char* filename, unsigned char* dest, unsigned int numbytes)
{




    struct PAB pab;
    unsigned char ferr;


    pab.ScreenOffset = 0;
    pab.Status = 0;
    pab.RecordLength = 0;
    pab.CharCount = 0;

    pab.OpCode = 0x05;
    pab.VDPBuffer = 0x1A00;
    pab.RecordNumber = numbytes;
    pab.NameLength = strlen(filename);
    pab.pName = filename;

    ferr = dsrlnk(&pab, 0x1800);
    if(!ferr) { vdpmemread(0x1A00, dest, numbytes); }
    return ferr;
}

unsigned char dsr_save(unsigned char* filename, unsigned char* source, unsigned int numbytes)
{




    struct PAB pab;


    pab.ScreenOffset = 0;
    pab.Status = 0;
    pab.RecordLength = 0;
    pab.CharCount = 0;

    pab.OpCode = 0x06;
    pab.VDPBuffer = 0x1A00;
    pab.RecordNumber = numbytes;
    pab.NameLength = strlen(filename);
    pab.pName = filename;

    vdpmemcpy(0x1A00, source, numbytes);
    return dsrlnk(&pab, 0x1800);
}


void cspaces(unsigned char number)
{


    unsigned char x;

    for(x=0;x<number;x++) { cputc(32); }
}

void cleararea(unsigned char xpos, unsigned char ypos, unsigned char height, unsigned char width)
{


    unsigned char x;

    for(x=0;x<height;x++)
    {
        conio_x = (xpos); conio_y = (ypos+x);
        cspaces(width);
    }
}

void printcentered(unsigned char* text, unsigned char xpos, unsigned char ypos, unsigned char width)
{






    conio_x = (xpos); conio_y = (ypos);

    if(strlen(text)<width)
    {
        cspaces((width-strlen(text))/2-1);
    }
    cputs(text);
}


unsigned char getkey(unsigned char* allowedkeys, unsigned char joyallowed)
{





    unsigned char key, joy1x, joy1y, joy1b, joy2x, joy2y, joy2b, debounce;

    do
    {
        random();
        if(musicnumber)
        {
            vdpwaitvint();
            __asm__( "bl @SongLoop" : : : "r0","r1","r2","r3","r4","r5","r6","r7","r8","r9","r11","r12","r13","r14","r15","cc" );
            if (!((songNote[3]&0x01) != 0)) { StartSong(musicmem,0); }
        }

        key = 0;
        if(joyinterface && joyallowed)
        {
            joystfast(1);
            kscanfast(1);
            joy1x = *((volatile unsigned char*)0x8377);
            joy1y = *((volatile unsigned char*)0x8376);
            joy1b = *((volatile unsigned char*)0x8375);
            joystfast(2);
            kscanfast(2);
            joy2x = *((volatile unsigned char*)0x8377);
            joy2y = *((volatile unsigned char*)0x8376);
            joy2b = *((volatile unsigned char*)0x8375);
            if(joy1b != 0xff || joy2b != 0xff ) { key = 13; }
            if(joy1x == 0x04 || joy2x == 0x04 ) { key = 9; }
            if(joy1x == 0xfc || joy2x == 0xfc ) { key = 8; }
            if(joy1y == 0xfc || joy2y == 0xfc ) { key = 10; }
            if(joy1y == 0x04 || joy2y == 0x04 ) { key = 11; }
            if(key){
                do
                {
                    debounce = 0;
                    joystfast(1);
                    kscanfast(1);
                    joy1x = *((volatile unsigned char*)0x8377);
                    joy1y = *((volatile unsigned char*)0x8376);
                    joy1b = *((volatile unsigned char*)0x8375);
                    joystfast(2);
                    kscanfast(2);
                    joy2x = *((volatile unsigned char*)0x8377);
                    joy2y = *((volatile unsigned char*)0x8376);
                    joy2b = *((volatile unsigned char*)0x8375);
                    if(joy1b != 0xff || joy2b != 0xff ) { debounce=1; }
                    if(joy1x == 0x04 || joy2x == 0x04 ) { debounce=1; }
                    if(joy1x == 0xfc || joy2x == 0xfc ) { debounce=1; }
                    if(joy1y == 0xfc || joy2y == 0xfc ) { debounce=1; }
                    if(joy1y == 0x04 || joy2y == 0x04 ) { debounce=1; }
                } while (debounce == 1);
            }
        }
        if(key == 0)
        {
            if(kbhit())
            {
                key = cgetc();
                if(strlen(allowedkeys)==0) { key = 13; }
            }
        }
    } while ( (strchr(allowedkeys, key)==0 && key != 13) || key == 0);
    return key;
}

int input(unsigned char xpos, unsigned char ypos, unsigned char *str, unsigned char size)
{
# 436 "main.c"
    unsigned char idx = strlen(str);
    unsigned char c, x, b, flag;
    unsigned char validkeys[70] = {32 ,3,0};

    strcat(validkeys,numbers);
    strcat(validkeys,letters);
    strcat(validkeys,updownenter);
    strcat(validkeys,leftright);

    for(x=0;x<size+1;x++) { vdpchar(gImage+xpos+x+(ypos*32),26); }

    cputsxy(xpos, ypos, str);
    vdpchar(gImage+xpos+strlen(str)+(ypos*32),25);

    while(1)
    {
        c = getkey(validkeys,0);
        switch (c)
        {
            case 13:
                idx = strlen(str);
                str[idx] = 0;
                conio_x = (xpos); conio_y = (ypos);
                cspaces(size+1);
                cputsxy(xpos, ypos, str);
                return idx;

            case 3:
                if (idx)
                {
                    --idx;
                    cputcxy(xpos+idx, ypos, 32);
                    for(x = idx; 1; ++x)
                    {
                        b = str[x+1];
                        str[x] = b;
                        vdpchar(gImage+xpos+x+(ypos*32), b ? b : 26);
                        if (b == 0) { break; }
                    }
                    vdpchar(gImage+xpos+idx+(ypos*32),25);
                    vdpchar(gImage+xpos+idx+1+(ypos*32),str[idx+1] ? str[idx+1] : 26);
                    conio_x = (xpos+idx); conio_y = (ypos);
                }
                break;

            case 4:
                c = strlen(str);
                if (c < size && c > 0 && idx < c)
                {
                    ++c;
                    while(c >= idx)
                    {
                        str[c+1] = str[c];
                        if (c == 0) { break; }
                        --c;
                    }
                    str[idx] = ' ';
                    cputsxy(xpos, ypos, str);
                    conio_x = (xpos + idx); conio_y = (ypos);
                }
                break;

            case 8:
                if (idx)
                {
                    --idx;
                    vdpchar(gImage+xpos+idx+(ypos*32),25);
                    vdpchar(gImage+xpos+idx+1+(ypos*32),str[idx+1] ? str[idx+1] : 26);
                    conio_x = (xpos+idx); conio_y = (ypos);
                }
                break;

            case 9:
                if (idx < strlen(str) && idx < size)
                {
                    ++idx;
                    conio_x = (xpos+idx-1); conio_y = (ypos);
                    cputc(str[idx-1]);
                    vdpchar(gImage+xpos+idx+(ypos*32),25);
                    conio_x = (xpos + idx); conio_y = (ypos);
                }
                break;

            default:
                if (idx < size)
                {
                    flag = (str[idx] == 0);
                    str[idx] = c;
                    conio_x = (xpos+idx); conio_y = (ypos);
                    cputc(c);
                    vdpchar(gImage+xpos+idx+1+(ypos*32),25);
                    ++idx;
                    if (flag) { str[idx+1] = 0; }
                }
                break;
        }
    }
    return 0;
}



void windowsave(unsigned char ypos, unsigned char height)
{





    Window[windownumber].address = windowaddress;
    Window[windownumber].ypos = ypos;
    Window[windownumber].height = height;
    vdpmemread(gImage+Window[windownumber].ypos*32, windowmemory, Window[windownumber].height*32);
    vdpmemcpy(windowaddress, windowmemory, Window[windownumber].height*32);
    windowaddress += Window[windownumber++].height*32;
}

void windowrestore()
{

    windowaddress = Window[--windownumber].address;
    vdpmemread(windowaddress, windowmemory, Window[windownumber].height*32);
    vdpmemcpy(gImage+Window[windownumber].ypos*32, windowmemory, Window[windownumber].height*32);
}

void menumakeborder(unsigned char xpos, unsigned char ypos, unsigned char height, unsigned char width)
{







    unsigned char x, y;

    windowsave(ypos, height+2);

    vdpchar(gImage+xpos+(ypos*32),6);
    for(x=0;x<width;x++) {vdpchar(gImage+(xpos+x+1)+(ypos*32),1); }
    vdpchar(gImage+(xpos+width)+(ypos*32),7);
    for(y=0;y<height;y++)
    {
        vdpchar(gImage+xpos+(ypos+y+1)*32,2);
        conio_x = (xpos+1); conio_y = (ypos+y+1);
        cspaces(width);
        vdpchar(gImage+(xpos+width)+(ypos+y+1)*32,3);
    }
    vdpchar(gImage+xpos+(ypos+height+1)*32,4);
    for(x=0;x<width;x++) { vdpchar(gImage+(xpos+x+1)+(ypos+height+1)*32,0); }
    vdpchar(gImage+(xpos+width)+(ypos+height+1)*32,5);
}

void menuplacebar()
{


    unsigned char x;

    conio_x = (6); conio_y = (0);
    for(x=0;x<menubaroptions;x++)
    {
        cprintf("%s ",menubartitles[x]);
    }
}

unsigned char menupulldown(unsigned char xpos, unsigned char ypos, unsigned char menunumber)
{







    unsigned char x;
    unsigned char validkeys[6];
    unsigned char key;
    unsigned char exit = 0;
    unsigned char menuchoice = 1;

    windowsave(ypos, pulldownmenuoptions[menunumber-1]+4);
    if(menunumber>menubaroptions)
    {
        vdpchar(gImage+xpos+(ypos*32),6);
        for(x=0;x<strlen(pulldownmenutitles[menunumber-1][0])+2;x++) { vdpchar(gImage+xpos+x+1+(ypos*32),1); }
    }
    for(x=0;x<pulldownmenuoptions[menunumber-1];x++)
    {
        vdpchar(gImage+xpos+(ypos+x+1)*32,2);
        conio_x = (xpos+1); conio_y = (ypos+x+1);
        cprintf(" %s ",pulldownmenutitles[menunumber-1][x]);
        vdpchar(gImage+xpos+strlen(pulldownmenutitles[menunumber-1][x])+2+(ypos+x+1)*32,2);
    }
    vdpchar(gImage+xpos+(ypos+pulldownmenuoptions[menunumber-1]+1)*32,4);
    for(x=0;x<strlen(pulldownmenutitles[menunumber-1][0])+2;x++)
    {
        vdpchar(gImage+xpos+x+1+(ypos+pulldownmenuoptions[menunumber-1]+1)*32,0);
    }

    strcpy(validkeys, updownenter);
    if(menunumber<=menubaroptions)
    {
        strcat(validkeys, leftright);
    }

    do
    {
        vdpchar(gImage+xpos+1+(ypos+menuchoice)*32,177);
        key = getkey(validkeys,joyinterface);
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
            vdpchar(gImage+xpos+1+(ypos+menuchoice)*32,32);
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

unsigned char menumain()
{


    unsigned char menubarchoice = 1;
    unsigned char menuoptionchoice = 0;
    unsigned char key, x;
    unsigned char validkeys[4] = {8,9,13,0};
    unsigned char xpos;

    do
    {
        do
        {
            for(x=0;x<strlen(menubartitles[menubarchoice-1]);x++)
            {
                vdpchar(gImage+menubarcoords[menubarchoice-1]+x+32,0);
            }
            key = getkey(validkeys,joyinterface);
            conio_x = (menubarcoords[menubarchoice-1]); conio_y = (1);
            cspaces(strlen(menubartitles[menubarchoice-1]));
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

unsigned char areyousure()
{

    unsigned char choice;

    menumakeborder(10,5,6,20);
    cputsxy(12,7,"Are you sure?");
    choice = menupulldown(20,8,5);
    windowrestore();
    return choice;
}

void fileerrormessage(unsigned char ferr)
{


    menumakeborder(10,5,6,20);
    cputsxy(12,7,"File error!");
    conio_x = (12); conio_y = (8);
    cprintf("Error nr.: %2X",ferr);
    cputsxy(12,10,"Press key.");
    getkey("",1);
    windowrestore();
}



void saveconfigfile()
{


    unsigned char fname[13] = "DSK1.LUDOCFG";

    unsigned char ferr = dsr_save(fname,saveslots,85);
    if (ferr) { fileerrormessage(ferr); }
}

void loadconfigfile()
{


    unsigned char fname[13] = "DSK1.LUDOCFG";
    unsigned char x,y;

    unsigned char ferr = dsr_load(fname,saveslots,85);
    if (ferr) { fileerrormessage(ferr); }
    else
    {
        for(y=0;y<5;y++)
        {
            for(x=0;x<16;x++)
            {
                pulldownmenutitles[7][y][x]=saveslots[(y*16)+5+x];
            }
        }
    }
}



void graphicsinit()
{


    set_graphics(0);
    windowaddress = 0x1000;
    bgcolor(0x01);
    vdpmemcpy(gColor, colorset, sizeof(colorset));
    vdpmemcpy(gPattern, patterns, sizeof(patterns));
    clrscr();
}

void loadmainscreen()
{


    vdpmemcpy(gImage, mainscreen, sizeof(mainscreen));
    menuplacebar();
}



unsigned char dicethrow()
{


    unsigned char dicethrow, x;

    menumakeborder(22,10,6,7);
    for(x=0;x<10;x++)
    {
        if(musicnumber)
        {
            vdpwaitvint();
            __asm__( "bl @SongLoop" : : : "r0","r1","r2","r3","r4","r5","r6","r7","r8","r9","r11","r12","r13","r14","r15","cc" );
            if (!((songNote[3]&0x01) != 0)) { StartSong(musicmem,0); }
        }
        dicethrow = random()%6+1;
        vdpchar(gImage+25+(12*32),dicegraphics[dicethrow-1][0]);
        vdpchar(gImage+26+(12*32),dicegraphics[dicethrow-1][1]);
        vdpchar(gImage+25+(13*32),dicegraphics[dicethrow-1][2]);
        vdpchar(gImage+26+(13*32),dicegraphics[dicethrow-1][3]);
        wait(5);
    }
    cputsxy(24,15,"Key.");
    getkey("",1);
    windowrestore();
    return dicethrow;
}

unsigned char pawncoord(unsigned char playernumber, unsigned char pawnnumber, unsigned char xy)
{






    if(playerpos[playernumber][pawnnumber][0]==0)
    {
        return fieldcoords[playerpos[playernumber][pawnnumber][1]][xy];
    }
    else
    {
        return homedestcoords[playernumber][playerpos[playernumber][pawnnumber][1]][xy];
    }
}

void pawnerase(unsigned char playernumber, unsigned char pawnnumber)
{



    unsigned char xpos, ypos, boardpos;

    xpos = pawncoord(playernumber, pawnnumber, 0);
    ypos = pawncoord(playernumber, pawnnumber, 1);
    boardpos = playerpos[playernumber][pawnnumber][1];
    if(playerpos[playernumber][pawnnumber][0]==0 && (boardpos==0 || boardpos==10 || boardpos==20 || boardpos==30 ))
    {

        switch (playerpos[playernumber][pawnnumber][1]/10)
        {
        case 0:
            cputcxy(xpos,ypos,172);
            cputcxy(xpos+1,ypos,173);
            cputcxy(xpos,ypos+1,174);
            cputcxy(xpos+1,ypos+1,175);
            break;

        case 1:
            cputcxy(xpos,ypos,180);
            cputcxy(xpos+1,ypos,181);
            cputcxy(xpos,ypos+1,182);
            cputcxy(xpos+1,ypos+1,183);
            break;

        case 2:
            cputcxy(xpos,ypos,188);
            cputcxy(xpos+1,ypos,189);
            cputcxy(xpos,ypos+1,190);
            cputcxy(xpos+1,ypos+1,191);
            break;

        case 3:
            cputcxy(xpos,ypos,196);
            cputcxy(xpos+1,ypos,197);
            cputcxy(xpos,ypos+1,198);
            cputcxy(xpos+1,ypos+1,199);
            break;

        default:
            break;
        }
    }
    else
    {
        if(playerpos[playernumber][pawnnumber][0]==0)
        {

            cputcxy(xpos,ypos,164);
            cputcxy(xpos+1,ypos,165);
            cputcxy(xpos,ypos+1,166);
            cputcxy(xpos+1,ypos+1,167);
        }
        else
        {

            switch (playernumber)
            {
            case 0:
                cputcxy(xpos,ypos,132);
                cputcxy(xpos+1,ypos,133);
                cputcxy(xpos,ypos+1,134);
                cputcxy(xpos+1,ypos+1,135);
                break;

            case 1:
                cputcxy(xpos,ypos,140);
                cputcxy(xpos+1,ypos,141);
                cputcxy(xpos,ypos+1,142);
                cputcxy(xpos+1,ypos+1,143);
                break;

            case 2:
                cputcxy(xpos,ypos,148);
                cputcxy(xpos+1,ypos,149);
                cputcxy(xpos,ypos+1,150);
                cputcxy(xpos+1,ypos+1,151);
                break;

            case 3:
                cputcxy(xpos,ypos,156);
                cputcxy(xpos+1,ypos,157);
                cputcxy(xpos,ypos+1,158);
                cputcxy(xpos+1,ypos+1,159);
                break;

            default:
                break;
            }
        }
    }
}

void pawnplace(unsigned char playernumber, unsigned char pawnnumber, unsigned char selected)
{



    unsigned char xpos, ypos, color;

    xpos = pawncoord(playernumber, pawnnumber, 0);
    ypos = pawncoord(playernumber, pawnnumber, 1);

    if(selected)
    {
        cputcxy(xpos,ypos,160);
        cputcxy(xpos+1,ypos,161);
        cputcxy(xpos,ypos+1,162);
        cputcxy(xpos+1,ypos+1,163);
    }
    else
    {
        switch (playernumber)
        {
        case 0:
            cputcxy(xpos,ypos,128);
            cputcxy(xpos+1,ypos,129);
            cputcxy(xpos,ypos+1,130);
            cputcxy(xpos+1,ypos+1,131);
            break;

        case 1:
            cputcxy(xpos,ypos,136);
            cputcxy(xpos+1,ypos,137);
            cputcxy(xpos,ypos+1,138);
            cputcxy(xpos+1,ypos+1,139);
            break;

        case 2:
            cputcxy(xpos,ypos,144);
            cputcxy(xpos+1,ypos,145);
            cputcxy(xpos,ypos+1,146);
            cputcxy(xpos+1,ypos+1,147);
            break;

        case 3:
            cputcxy(xpos,ypos,152);
            cputcxy(xpos+1,ypos,153);
            cputcxy(xpos,ypos+1,154);
            cputcxy(xpos+1,ypos+1,155);
            break;

        default:
            break;
        }
    }
}

void savegame(unsigned char autosave)
{



    unsigned char fname[14] = "DSK1.LUDOSAV";
    unsigned char slot = 0;
    unsigned char x, y, len, ferr;
    unsigned char yesno = 1;

    len = strlen(fname);

    if(autosave==1)
    {
        fname[len]=48;
        fname[len+1]=0;
    }
    else
    {
        menumakeborder(2,5,12,28);
        cputsxy(4,7,"Save game.");
        cputsxy(4,8,"Choose slot:");
        do
        {
            slot = menupulldown(10,10,8) - 1;
        } while (slot<1);
        if(saveslots[slot]==1)
        {
            cputsxy(4,9,"Slot not empty. Sure?");
            yesno = menupulldown(15,10,5);
        }
        if(yesno==1)
        {
            cputsxy(4,9,"Choose name of save. ");
            if(saveslots[slot]==1) { pulldownmenutitles[7][slot][0]=0; }
            input(4,10,pulldownmenutitles[7][slot],15);
            for(x=strlen(pulldownmenutitles[7][slot]);x<15;x++)
            {
                pulldownmenutitles[7][slot][x] = 32;
            }
            pulldownmenutitles[7][slot][15] = 0;
            fname[len]=48+slot;
            fname[len+1]=0;
            for(x=0;x<16;x++)
            {
                saveslots[(slot*16)+5+x]=pulldownmenutitles[7][slot][x];
            }
        }
        windowrestore();
    }
    if(yesno==1)
    {
        saveslots[slot]=1;
        saveconfigfile();
        savegamemem[0]=turnofplayernr;
        for(x=0;x<4;x++)
        {
            savegamemem[x+1] = np[x];
        }
        for(x=0;x<4;x++)
        {
            for(y=0;y<4;y++)
            {
                savegamemem[5+(x*4)+y]=playerdata[x][y];
            }
        }
        for(x=0;x<4;x++)
        {
            for(y=0;y<4;y++)
            {
                savegamemem[21+(x*8)+(y*2)]=playerpos[x][y][0];
                savegamemem[22+(x*8)+(y*2)]=playerpos[x][y][1];
            }
        }
        for(x=0;x<4;x++)
        {
            for(y=0;y<21;y++)
            {
                savegamemem[53+(x*21)+y]=playername[x][y];
            }
        }
        ferr = dsr_save(fname,savegamemem,136);
        if (ferr) { fileerrormessage(ferr); }
    }
}

void loadgame()
{


    unsigned char fname[14] = "DSK1.LUDOSAV";
    unsigned char slot, x, y, ferr, len;
    unsigned char yesno = 1;

    len = strlen(fname);

    menumakeborder(2,5,12,28);
    cputsxy(4,7,"Load game.");
    cputsxy(4,9,"Choose slot:");
    slot = menupulldown(10,10,8) - 1;
    if(saveslots[slot]==0)
    {
        cputsxy(4,9,"Slot empty.");
        cputsxy(4,10,"Press key.");
        getkey("",1);
    }
    windowrestore();
    if(saveslots[slot]==1)
    {
        fname[len]=48+slot;
        fname[len+1]=0;
        ferr = dsr_load(fname,savegamemem,136);
        if (ferr) { fileerrormessage(ferr); return; }

        turnofplayernr=savegamemem[0];
        for(x=0;x<4;x++)
        {
            np[x]=savegamemem[1+x];
        }
        for(x=0;x<4;x++)
        {
            for(y=0;y<4;y++)
            {
                playerdata[x][y]=savegamemem[5+(x*4)+y];
            }
        }
        for(x=0;x<4;x++)
        {
            for(y=0;y<4;y++)
            {
                pawnerase(x,y);
                playerpos[x][y][0]=savegamemem[21+(x*8)+(y*2)];
                playerpos[x][y][1]=savegamemem[22+(x*8)+(y*2)];
                pawnplace(x,y,0);
            }
        }
        for(x=0;x<4;x++)
        {
            for(y=0;y<21;y++)
            {
                playername[x][y]=savegamemem[53+(x*21)+y];
            }
        }
        endofgameflag = 2;
    }
}

void inputofnames()
{

    unsigned char x, choice;

    menumakeborder(2,8,6,28);
    for(x=0;x<4;x++)
    {
        conio_x = (4); conio_y = (10);
        cprintf("Computer plays player %d?",x+1);
        choice = menupulldown(20,11,5);
        if(choice==1)
        {
            playerdata[x][0]=1;
        }
        else
        {
            playerdata[x][0]=0;
        }
        conio_x = (4); conio_y = (10);
        cprintf("Input name player %d:    ",x+1);
        input(4,12,playername[x],8);
    }
    windowrestore();
}

void musicnext()
{


    unsigned char fname[14] = "DSK1.LUDOMUS";
    unsigned char len, ferr;

    len = strlen(fname);

    StopSong();
    if(++musicnumber>3) { musicnumber = 1;}
    fname[len]=48+musicnumber;
    fname[len+1]=0;
    memset(musicmem,0,3200);
    ferr = dsr_load(fname,musicmem,3200);
    if (ferr) { fileerrormessage(ferr); }
    StartSong(musicmem,0);
}

void informationcredits()
{


    unsigned char version[30] = {
        'v','1','9','9',' ','-',' ',
        ("Mar 26 2021"[ 7]),("Mar 26 2021"[ 8]),("Mar 26 2021"[ 9]),("Mar 26 2021"[10]),
        ((("Mar 26 2021"[0] == 'O') || ("Mar 26 2021"[0] == 'N') || ("Mar 26 2021"[0] == 'D')) ? '1' : '0'),( (("Mar 26 2021"[0] == 'J' && "Mar 26 2021"[1] == 'a' && "Mar 26 2021"[2] == 'n')) ? '1' : (("Mar 26 2021"[0] == 'F')) ? '2' : (("Mar 26 2021"[0] == 'M' && "Mar 26 2021"[1] == 'a' && "Mar 26 2021"[2] == 'r')) ? '3' : (("Mar 26 2021"[0] == 'A' && "Mar 26 2021"[1] == 'p')) ? '4' : (("Mar 26 2021"[0] == 'M' && "Mar 26 2021"[1] == 'a' && "Mar 26 2021"[2] == 'y')) ? '5' : (("Mar 26 2021"[0] == 'J' && "Mar 26 2021"[1] == 'u' && "Mar 26 2021"[2] == 'n')) ? '6' : (("Mar 26 2021"[0] == 'J' && "Mar 26 2021"[1] == 'u' && "Mar 26 2021"[2] == 'l')) ? '7' : (("Mar 26 2021"[0] == 'A' && "Mar 26 2021"[1] == 'u')) ? '8' : (("Mar 26 2021"[0] == 'S')) ? '9' : (("Mar 26 2021"[0] == 'O')) ? '0' : (("Mar 26 2021"[0] == 'N')) ? '1' : (("Mar 26 2021"[0] == 'D')) ? '2' : '?' ),(("Mar 26 2021"[4] >= '0') ? ("Mar 26 2021"[4]) : '0'),("Mar 26 2021"[ 5]),'-',
        ("18:56:11"[0]),("18:56:11"[1]),("18:56:11"[3]),("18:56:11"[4]) };
    menumakeborder(0,5,14,30);
    printcentered("L U D O",2,7,28);
    printcentered(version,2,8,28);
    printcentered("Written by Xander Mol",2,10,28);
    printcentered("Converted TI-99/4a, 2021",2,11,28);
    printcentered("From Commodore 128 1992",2,12,28);
    printcentered("Build with/using code of",2,14,28);
    printcentered("TMS9900-GCC by Insomnia",2,15,28);
    printcentered("Libti99 lib by Tursi",2,16,28);
    printcentered("Jedimatt42 help/code",2,17,28);
    printcentered("Press a key.",2,18,28);
    getkey("",1);
    windowrestore();
}

void gamereset()
{


    unsigned char n;

    loadmainscreen();
    turnofplayernr=0;
    for(n=0;n<4;n++)
    {
        playerdata[n][1]=4;
        playerdata[n][3]=4;
        np[n]=-1;
        dp[n]=8;
    }
}

void turnhuman()
{


    unsigned char choice;
    unsigned char yesno;

    do
    {
        choice = menumain();
        switch (choice)
        {
            case 12:
                yesno = areyousure();
                if(yesno==1) { endofgameflag=3; gamereset(); }
                break;

            case 13:
                yesno = areyousure();
                if(yesno==1) { endofgameflag=1; }
                break;

            case 21:
                savegame(0);
                break;

            case 22:
                yesno = areyousure();
                if(yesno==1) { loadgame(); }
                break;

            case 23:
                if(autosavetoggle==1)
                {
                    autosavetoggle=0;
                    strcpy(pulldownmenutitles[1][2],"Autosave on ");
                }
                else
                {
                    autosavetoggle=1;
                    strcpy(pulldownmenutitles[1][2],"Autosave off");
                }
                break;

            case 31:
                musicnext();
                break;

            case 32:
                StopSong();
                MUTE_SOUND();
                musicnumber=0;
                break;

            case 33:
                if(musicnumber)
                {
                    StopSong();
                }
                else
                {
                    musicnumber=1;
                }
                StartSong(musicmem,0);
                break;

            case 41:
                informationcredits();
                break;

            default:
                break;
        }
    } while (choice!=11 && choice!=12 && choice!=13 && choice!=22);
}

unsigned char humanchoosepawn(unsigned char playernumber, unsigned char possible[4])
{


    signed char pawnnumber = 0;
    signed char direction;
    unsigned char key;
    unsigned char validkeys[5] = { 8, 9, 11, 10, 13 };

    menumakeborder(22,6,2,9);
    cputsxy(24,7,"Pawn?");
    conio_x = (24); conio_y = (8);
    cprintf("Dice=%d", throw);
    while (possible[++pawnnumber]!=1 && pawnnumber<4);
    do
    {
        pawnplace(playernumber,pawnnumber,1);
        key = getkey(validkeys,1);
        pawnplace(playernumber,pawnnumber,0);
        if(key==8 || key==10) { pawnnumber--; direction=-1; }
        if(key==9 || key==11) { pawnnumber++; direction=1; }
        if(key!=13)
        {
            if(pawnnumber>3) { pawnnumber = 0; }
            if(pawnnumber<0) { pawnnumber = 3; }
            do
            {
                if(possible[pawnnumber]!=1)
                {
                    pawnnumber+=direction;
                    if(pawnnumber>3) { pawnnumber = 0; }
                    if(pawnnumber<0) { pawnnumber = 3; }
                }
            } while (possible[pawnnumber]!=1);
        }
    } while (key!=13);
    windowrestore();
    return pawnnumber;
}

void playerwins()
{
    unsigned char choice;

    menumakeborder(3,5,10,25);
    conio_x = (5); conio_y = (7);
    cprintf("%s has won!", playername[turnofplayernr]);
    cputsxy(5,9,"Your choice?");
    do
    {
        choice = menupulldown(10,10,7);
        if(choice==2) { endofgameflag=3; gamereset(); zv=1; }
        if(choice==3) { endofgameflag=1; zv=1; }
    } while (choice==1 && playerdata[0][1]==0 && playerdata[1][1]==0 && playerdata[2][1]==0 && playerdata[3][1]==0);
    windowrestore();
}

unsigned char computerchoosepawn(unsigned char playernumber, unsigned char possible[4])
{


    signed int pawnscore[4] = { 0,0,0,0 };
    unsigned char pawnnumber = 0;
    signed int minimumpawnscore;
    unsigned char vr, vn, nn, no, nr, x,y,z ;

    for(x=0;x<4;x++)
    {
        if(possible[x]==0)
        {
            pawnscore[x]=-10000;
        }
        else{
            vr=playerpos[playernumber][x][0];
            vn=playerpos[playernumber][x][1];
            nn=vn+throw;
            no=nn;
            nr=vr;
            if(vr==0)
            {
                if(playernumber==0 && nn>39 && vn<40) { nn-=36; nr=1; }
                if(playernumber==1 && nn> 9 && vn<10) { nn-= 6; nr=1; }
                if(playernumber==2 && nn>19 && vn<20) { nn-=16; nr=1; }
                if(playernumber==3 && nn>29 && vn<30) { nn-=26; nr=1; }
            }
            if(nr==0 && nn>39) { nn-=40; }
            if(nr==1 && nn>3 && playerdata[playernumber][1]==1) { pawnscore[x]=10000; x=3; }
            else
            {
                if(nr==1 && nn>3) { pawnscore[x]+=6000; }
                for(y=0;y<4;y++)
                {
                    for(z=0;z<4;z++)
                    {
                        if(playernumber==y && playerpos[y][z][0]==nr && playerpos[y][z][1]==nn) { pawnscore[x]-=8000; }
                        if(playernumber!=y && playerpos[y][z][0]==nr && playerpos[y][z][1]==nn)
                        {
                            pawnscore[x]+=4000;
                            if(playerpos[y][z][0]==0)
                            {
                                if(y==0 && playerpos[y][z][1]>33) { pawnscore[x]+=3000; }
                                if(y==1 && playerpos[y][z][1]> 3) { pawnscore[x]+=3000; }
                                if(y==2 && playerpos[y][z][1]>13) { pawnscore[x]+=3000; }
                                if(y==3 && playerpos[y][z][1]>23) { pawnscore[x]+=3000; }
                            }
                        }
                        if(playerpos[y][z][0]==0 && nr==0 && playernumber!=y)
                        {
                            if((vn-playerpos[y][z][1])<6 && vn-playerpos[y][z][1]>0) { pawnscore[x]+=400; }
                            if((no-playerpos[y][z][1])<6 && no-playerpos[y][z][1]>0) { pawnscore[x]-=200; }
                            if((playerpos[y][z][1]-nn)<6 && (playerpos[y][z][1]-nn)>0) { pawnscore[x]+=100; }
                        }
                    }
                }
                if(nr==0 && (nn==0 || nn==10 || nn==20 || nn==30)) { pawnscore[x]-=4000; }
                if(vr==0 && (vn==0 || vn==10 || vn==20 || vn==30)) { pawnscore[x]+=2000; }
                if(playernumber==0) { pawnscore[x]+=nn; }
                if(playernumber==1) { pawnscore[x]+=no-10; }
                if(playernumber==2) { pawnscore[x]+=no-20; }
                if(playernumber==3) { pawnscore[x]+=no-30; }
            }
        }
    }
    minimumpawnscore=-20000;
    for(x=0;x<4;x++)
    {
        if(pawnscore[x]>minimumpawnscore && possible[x]==1) { minimumpawnscore=pawnscore[x]; pawnnumber=x; }
    }

    return pawnnumber;
}

void turngeneric()
{


    unsigned char pawnpossible[4] = { 0,0,0,0 };
    unsigned char dicethrows = 1;
    unsigned char noturnpossible = 0;
    unsigned char mp = 0;
    signed char pawnnumber = -1;
    unsigned char ap = 0;
    signed char as;
    unsigned char vr, vl, vn, nr, gv, ov, ro, x,y;

    if(playerdata[turnofplayernr][3]==playerdata[turnofplayernr][1])
    {
        dicethrows = 3;
        for(x=0;x<4;x++)
        {
            if(playerpos[turnofplayernr][x][0]==0)
            {
                dicethrows = 1;
            }
            if(playerpos[turnofplayernr][x][0]==1 && playerpos[turnofplayernr][x][1]<playerdata[turnofplayernr][1]+4 && playerpos[turnofplayernr][x][1]<playerdata[turnofplayernr][1]>3)
            {
                dicethrows = 1;
            }
        }
        if(dicethrows == 3)
        {
            cputsxy(23,7,"Throw 3x");
        }
    }
    for(x=0;x<dicethrows;x++)
    {
        throw = dicethrow();
        if(throw==6) { break; }
    }
    cputsxy(23,7,"        ");
    if(playerdata[turnofplayernr][3]==playerdata[turnofplayernr][1] && dicethrows == 3 && throw!=6) { noturnpossible=1; }
    if(np[turnofplayernr]>=0)
    {
        if(playerdata[turnofplayernr][3]>0)
        {
            pawnnumber=np[turnofplayernr];
        }
        np[turnofplayernr]=-1;
    }
    if(noturnpossible==0 && pawnnumber==-1)
    {
        for(x=0;x<4;x++)
        {
            vr=playerpos[turnofplayernr][x][0];
            vl=playerpos[turnofplayernr][x][1];
            gv=0;
            if(vr==1 && vl<4)
            {
                gv=1;
                if(throw==6)
                {
                    pawnnumber=x;
                    np[turnofplayernr]=x;
                    x=3;
                }
            }
            if(gv==0)
            {
                vn=vl+throw;
                nr=vr;
                if(vr==0)
                {
                    if(turnofplayernr==0 && vn>39 && vl<40) { vn-=36; nr=1; }
                    if(turnofplayernr==1 && vn> 9 && vl<10) { vn-= 6; nr=1; }
                    if(turnofplayernr==2 && vn>19 && vl<20) { vn-=16; nr=1; }
                    if(turnofplayernr==3 && vn>29 && vl<30) { vn-=26; nr=1; }
                }
                if(nr==1)
                {
                    if(vn>7) { gv=1; }
                    else
                    {
                        for(y=0;y<4;y++)
                        {
                            if(x!=y && playerpos[turnofplayernr][y][0]==1 && playerpos[turnofplayernr][y][1]<=vn && playerpos[turnofplayernr][y][1]>3)
                            {
                                gv=1;
                                y=3;
                            }
                        }
                    }
                }
                if(gv==0) { pawnpossible[x]=1; }
            }
        }
    }
    if(pawnnumber==-1)
    {
        for(x=0;x<4;x++)
        {
            if(pawnpossible[x]==1) { ap++; pawnnumber=x; }
        }
    }
    else { ap=1; }
    if(ap>1)
    {
        if(playerdata[turnofplayernr][0]==0) { pawnnumber = humanchoosepawn(turnofplayernr,pawnpossible); }
        else { pawnnumber = computerchoosepawn(turnofplayernr,pawnpossible); }
    }
    if(throw==6) { zv=1; }
    if(ap==0 || noturnpossible==1)
    {
        cputsxy(23,7,"No move");
        cputsxy(23,8,"Key.");
        getkey("",1);
        return;
    }
    pawnerase(turnofplayernr,pawnnumber);
    ov=playerpos[turnofplayernr][pawnnumber][1];
    ro=playerpos[turnofplayernr][pawnnumber][0];
    if(ro==1 && ov<4)
    {
        playerpos[turnofplayernr][pawnnumber][0]=0;
        playerpos[turnofplayernr][pawnnumber][1]=turnofplayernr*10;
        playerdata[turnofplayernr][3]--;
    }
    else { playerpos[turnofplayernr][pawnnumber][1]+=throw; }
    if(turnofplayernr==0 && playerpos[turnofplayernr][pawnnumber][1]>39 && ov<40 && ro==0)
        { playerpos[turnofplayernr][pawnnumber][0]=1; playerpos[turnofplayernr][pawnnumber][1]-=36; }
    if(turnofplayernr==1 && playerpos[turnofplayernr][pawnnumber][1]> 9 && ov<10 && ro==0)
        { playerpos[turnofplayernr][pawnnumber][0]=1; playerpos[turnofplayernr][pawnnumber][1]-= 6; }
    if(turnofplayernr==2 && playerpos[turnofplayernr][pawnnumber][1]>19 && ov<20 && ro==0)
        { playerpos[turnofplayernr][pawnnumber][0]=1; playerpos[turnofplayernr][pawnnumber][1]-=16; }
    if(turnofplayernr==3 && playerpos[turnofplayernr][pawnnumber][1]>29 && ov<30 && ro==0)
        { playerpos[turnofplayernr][pawnnumber][0]=1; playerpos[turnofplayernr][pawnnumber][1]-=26; }
    if(playerpos[turnofplayernr][pawnnumber][0]==1 && playerpos[turnofplayernr][pawnnumber][1]>3)
        { dp[turnofplayernr]=playerpos[turnofplayernr][pawnnumber][1]; }
    if(playerpos[turnofplayernr][pawnnumber][1]==playerdata[turnofplayernr][1]+3 && playerpos[turnofplayernr][pawnnumber][0]==1)
        { playerdata[turnofplayernr][1]--; }
    if(playerpos[turnofplayernr][pawnnumber][1]>39) { playerpos[turnofplayernr][pawnnumber][1]-=40; }
    ap=0;
    as=-1;
    for(x=0;x<4;x++)
    {
        for(y=0;y<4;y++)
        {
            if(y!=pawnnumber || x!=turnofplayernr)
            {
                if(playerpos[x][y][0]==0 && playerpos[turnofplayernr][pawnnumber][0]==0)
                {
                    if(playerpos[x][y][1]==playerpos[turnofplayernr][pawnnumber][1])
                    {
                        ap=y;
                        as=x;
                        y=3;
                        x=3;
                    }
                }
            }
        }
    }
    if(as!=-1)
    {
        pawnerase(as,ap);
        playerpos[as][ap][0]=1;
        playerpos[as][ap][1]=ap;
        playerdata[as][3]++;
        pawnplace(as,ap,0);
    }
    pawnplace(turnofplayernr,pawnnumber,0);
    if(playerdata[turnofplayernr][0]==0 && autosavetoggle==1)
    {
        savegame(1);
    }
    else
    {
        cputsxy(23,7,"Key.");
        getkey("",1);
    }
}

void loadintro()
{


    int x, y, ferr;
    int len = 0;
    unsigned char validkeys[4] = {'m', 'M', 13, 0 };
    unsigned char key;


    vdpmemcpy(gImage, titlescreen, sizeof(titlescreen));


    loadconfigfile();


    ferr = dsr_load("DSK1.LUDOMUS1",musicmem,3200);
    if (ferr) { fileerrormessage(ferr); }
    StartSong(musicmem,0);



    cputsxy(1,21,"Press ENTER/FIRE to start game.");
    cputsxy(1,22,"M=toggle music.");

    do
    {
        cputsxy(1,20,"Music: ");
        if(musicnumber) { cputs("Yes "); } else { cputs("No "); }
        key = getkey(validkeys,1);
        switch (key)
        {
        case 'm':
        case 'M':
            if(musicnumber)
            {
                StopSong();
                MUTE_SOUND();
                musicnumber = 0;
            }
            else{
                musicnumber = 1;
                StartSong(musicmem,0);
            }
            break;

        default:
            break;
        }
    } while (key != 13);
}



int main()
{
    unsigned char x, choice;


    graphicsinit();

    loadintro();


    menumakeborder(8,5,6,20);
    cputsxy(10,7,"Load old game?");
    choice = menupulldown(17,8,5);
    windowrestore();
    if(choice==1) { loadmainscreen(); loadgame(); }

    if(endofgameflag==0) { loadmainscreen(); }


    do
    {
        if(endofgameflag>0)
        {
            endofgameflag = 0;
        }
        else
        {
            inputofnames();
        }
        do
        {
            cleararea(23,2,8,8);
            conio_x = (23); conio_y = (2);
            cprintf("Player %d", turnofplayernr+1);
            cputsxy(23,3,"Color");
            cputcxy(30,3,playerdata[turnofplayernr][2]);
            cputsxy(23,4,playername[turnofplayernr]);
            if(playerdata[turnofplayernr][0]==0)
            {
                turnhuman();
            }
            else
            {
                cputsxy(23,5,"Computer");
            }
            if(endofgameflag!=0) { break; }
            turngeneric();

            if(playerdata[turnofplayernr][1]==0) { playerwins(); }
            do
            {
                if(zv==1)
                {
                    zv=0;
                }
                else
                {
                    np[turnofplayernr]=-1;
                    turnofplayernr++;
                    if(turnofplayernr>3) { turnofplayernr=0; }
                }
            } while (zv==0 && playerdata[turnofplayernr][1]==0);
        } while (endofgameflag==0);
    } while (endofgameflag!=1);


    clrscr();
    bgcolor(0);
    cputsxy(0,0,"Thanks for playing, goodbye.");


    return 0;
}
