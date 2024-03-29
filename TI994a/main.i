# 1 "main.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "main.c"
# 75 "main.c"
# 1 "/home/xahmol/libti99/system.h" 1
# 9 "/home/xahmol/libti99/system.h"
void halt() __attribute__ ((noreturn));


void exit() __attribute__ ((noreturn));
# 76 "main.c" 2
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
# 77 "main.c" 2
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


void bm_drawline(int x0, int y0, int x1, int y1, int mode);







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
# 78 "main.c" 2
# 1 "/home/xahmol/libti99/kscan.h" 1
# 54 "/home/xahmol/libti99/kscan.h"
unsigned char kscan(unsigned char mode);





void kscanfast(int mode);



void joystfast(int unit);
# 79 "main.c" 2
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
# 80 "main.c" 2
# 1 "/home/xahmol/libti99/vdp.h" 1
# 81 "main.c" 2
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
# 82 "main.c" 2
# 1 "/home/xahmol/libti99/sound.h" 1
# 40 "/home/xahmol/libti99/sound.h"
inline void SET_SOUND_PTR(unsigned int x) { *((volatile unsigned int*)0x83cc) = x; }


inline void SET_SOUND_VDP() { *((volatile unsigned char*)0x83fd) |= 0x01; }


inline void SET_SOUND_GROM() { *((volatile unsigned char*)0x83fd) &= ~0x01; }


inline void START_SOUND() { *((volatile unsigned char*)0x83ce) = 1; }


inline void MUTE_SOUND() { *((volatile unsigned char*)0x8400)=0x90|0x0f; *((volatile unsigned char*)0x8400)=0xB0|0x0f; *((volatile unsigned char*)0x8400)=0xD0|0x0f; *((volatile unsigned char*)0x8400)=0xF0|0x0f; }
# 83 "main.c" 2
# 1 "speech.h" 1
# 33 "speech.h"
void speech_reset();





int detect_speech();





void say_vocab(int phrase_addr);




void say_data(const char* addr, int len);




void speech_wait();

typedef void (*read_func)();
# 68 "speech.h"
void safe_read() {
  __asm__(
    "MOVB @>9000,@%0\n\t"
    "NOP\n\t"
    "NOP\n\t"
    : : "i" (0x8320)
  );
}

void delay_asm_12() {
  __asm__(
    "NOP\n\t"
    "NOP"
  );
}

void delay_asm_42() {
  __asm__(
    "\tLI r12,10\n"
    "loop%=\n\t"
    "DEC r12\n\t"
    "JNE loop%="
    : : : "r12"
  );
}

void copy_safe_read() {
  int* source = (int*) safe_read;
  int* target = (int*) (0x8320 +2);
  int len = 12;
  while(len) {
    *target++ = *source++;
    len -= 2;
  }
}

unsigned char __attribute__((noinline)) call_safe_read() {
  ((read_func)(0x8320 +2))();
  return *((volatile unsigned char*)(0x8320));
}

void load_speech_addr(int phrase_addr) {
  *((volatile unsigned char*)0x9400) = 0x40 | (char)(phrase_addr & 0x000F);
  *((volatile unsigned char*)0x9400) = 0x40 | (char)((phrase_addr >> 4) & 0x000F);
  *((volatile unsigned char*)0x9400) = 0x40 | (char)((phrase_addr >> 8) & 0x000F);
  *((volatile unsigned char*)0x9400) = 0x40 | (char)((phrase_addr >> 12) & 0x000F);

  *((volatile unsigned char*)0x9400) = 0x40;
  delay_asm_42();
}

void say_vocab(int phrase_addr) {
  load_speech_addr(phrase_addr);
  *((volatile unsigned char*)0x9400) = 0x50;
  delay_asm_12();
}

void say_data(const char* addr, int len) {
  *((volatile unsigned char*)0x9400) = 0x60;
  delay_asm_12();

  int i = 16;
  while(i > 0 && len > 0) {
    *((volatile unsigned char*)0x9400) = *addr++;
    len--;
    i--;
  }

  while(len > 0) {
    int statusLow = 0;
    while (!statusLow) {
      statusLow = ((int)call_safe_read()) & 0x40;
    }

    i = 8;
    while(i > 0 && len > 0) {
      *((volatile unsigned char*)0x9400) = *addr++;
      len--;
      i--;
    }
  }
}

void speech_reset() {
  copy_safe_read();
  *((volatile unsigned char*)0x9400) = 0x70;
  ((read_func)(0x8320 +2))();
}

int detect_speech() {
  speech_reset();
  load_speech_addr(0);
  *((volatile unsigned char*)0x9400) = 0x10;
  delay_asm_12();
  ((read_func)(0x8320 +2))();
  return *((volatile unsigned char*)(0x8320)) == 0xAA;
}

void speech_wait() {
  delay_asm_42();
  delay_asm_12();
  *((volatile unsigned char*)(0x8320)) = 0x80;
  while (*((volatile unsigned char*)(0x8320)) & 0x80) {
    ((read_func)(0x8320 +2))();
  }
}
# 84 "main.c" 2
# 1 "defines.h" 1
# 85 "main.c" 2




const char speech_intro[] = {0xC4,0x35,0x2F,0x34,0xAD,0xA9,0xBB,0x54,0x4D,0x57,0x97,0x14,0x12,0x32,0x95,0x53,0x8C,0x3D,0x70,0x4A,0x55,0x75,0x77,0x88,0xA0,0x29,0x95,0xC5,0x2D,0xC9,0x8C,0xA6,0x54,0x14,0xCD,0xC2,0x10,0x1A,0x32,0x9E,0xAC,0x06,0x5D,0xB2,0xC9,0x48,0x8C,0x78,0x54,0xDA,0xA8,0x06,0x3D,0xB2,0xC1,0xA4,0x20,0x1B,0x98,0xCE,0x70,0xA3,0x6C,0x82,0x42,0xC3,0xC5,0xC4,0xB2,0x0A,0x0A,0x4B,0x67,0x17,0x37,0xCC,0x83,0x2A,0x2D,0xCC,0x93,0x98,0x88,0xA4,0xD4,0x70,0xB5,0x1C,0x32,0xDA,0xB4,0x52,0xCC,0x68,0xCA,0x79,0xD3,0x4A,0x36,0xA1,0xA9,0x60,0x4D,0xCB,0xD9,0x85,0xBA,0x12,0xB5,0x68,0xD5,0xB0,0x62,0x4A,0x54,0xE2,0x50,0x23,0xA5,0xAA,0x60,0x8B,0x43,0xCE,0x58,0xA2,0x41,0x35,0x4B,0x49,0x12,0x05,0x25,0xA9,0x28,0x63,0xB3,0x6B,0x80,0x29,0x3C,0xC2,0xC6,0x7C,0x64,0x59,0x92,0x09,0x35,0xC9,0x19,0x25,0x0E,0x4C,0xD5,0xB0,0xE7,0x08,0x8C,0x12,0x53,0xC2,0x16,0x8F,0x92,0x2A,0x54,0x81,0x4A,0x3C,0x49,0x68,0x20,0x25,0xBC,0x99,0x06,0x87,0x00,0x10,0x68,0x9D,0xF9,0x72,0xD1,0x36,0xB5,0x0A,0xDE,0x4B,0x09,0x25,0xA4,0xCA,0x5B,0xB5,0x24,0xE4,0x92,0x1A,0x47,0x53,0x5E,0xB0,0x4B,0xAA,0x1C,0x5F,0x7B,0x40,0x2E,0x89,0xB0,0x3A,0x6F,0x06,0x39,0x25,0xCC,0x7B,0xBD,0x28,0x68,0x93,0xE2,0x10,0xB5,0xE2,0xA0,0x90,0x06,0xDA,0xDA,0x80,0x22,0x02,0xE2,0x49,0x9D,0x96,0x1A,0xB2,0xD2,0x42,0x93,0x4D,0x99,0x8A,0x2E,0x3B,0x8B,0x3A,0xAD,0x4A,0xA9,0x14,0x22,0x48,0x1D,0x07,0x65,0x57,0x50,0xE7,0xF6,0xEC,0x64,0x58,0x0F,0xE5,0x78,0x25,0xD1,0x56,0x4E,0x00,0x66,0xA2,0x69,0x47,0x01,0x93,0x9A,0x22,0xBF,0x32,0x95,0x64,0xB7,0x63,0xE6,0xAA,0xBD,0x5D,0xC5,0x49,0xCA,0xAD,0xEA,0x34,0x76,0xC7,0xA9,0xE2,0x23,0xC8,0xAC,0x22,0x98,0x1A,0x2F,0xE3,0xF0,0xB4,0x20,0x3A,0x10,0x27,0x24,0xC2,0x91,0x32,0x39,0xD3,0x16,0xD7,0xAC,0xC6,0x91,0xC2,0x13,0x59,0xBC,0x21,0x0F,0xBC,0x11,0xD7,0xA2,0x81,0x7C,0x10,0xD6,0x42,0xD3,0xB3,0xB0,0x75,0x1C,0x25,0xE5,0xCA,0x2A,0xA1,0x2F,0xC8,0xC2,0x43,0x9A,0x92,0x3C,0x23,0x2D,0x0B,0xA0,0x2A,0xF2,0x59,0xC5,0xD3,0x90,0xA9,0xF1,0x37,0xC7,0x08,0x89,0xA6,0x46,0x57,0x8D,0xBC,0x6D,0x9A,0x1A,0x2D,0x73,0xF4,0x4A,0xE4,0x6A,0x3C,0x3C,0x40,0xCB,0x95,0x69,0xE0,0xF0,0x24,0xEE,0x4A,0xA4,0x01,0x33,0x5D,0x21,0x62,0xA1,0x16,0xF5,0xE1,0x80,0xB2,0x05,0x40,0x34,0xE3,0xC2,0x54,0x4C,0xB5,0x29,0x70,0x89,0x08,0x77,0x0A,0xA1,0xA6,0x36,0x3A,0x42,0x45,0x87,0x86,0x98,0xE8,0x0A,0x25,0xE5,0x5A,0x2A,0x3B,0xBB,0x55,0x90,0x71,0x2D,0x30,0xB7,0x1E,0x0B,0x0E,0xE8,0x38,0x38,0xD4,0x5C,0xA7,0xB5,0xBB,0xE0,0x52,0xD3,0xE4,0x95,0xE6,0x50,0x4A,0xCD,0x93,0x46,0x69,0x40,0x2E,0x0D,0x4F,0xE6,0xCD,0x01,0x39,0x35,0xB4,0xB8,0x0D,0x04,0x34,0xD7,0xA0,0x92,0x19,0x30,0xAC,0x4D,0x03,0x5B,0x2C,0xAA,0x3B,0x30,0x0D,0xCC,0xF1,0x60,0xEE,0xC2,0x34,0x48,0x6D,0x24,0xB2,0x1B,0x65,0x26,0xA0,0x1D,0xA6,0x4A,0x0C,0x70,0x28,0x9B,0x01,0xAE,0x36,0x37,0xC0,0xD5,0x96,0x06,0x38,0xD6,0x52,0x00,0x5D,0x44,0xA2,0xDD,0xF3,0x76,0x31,0x95,0x05,0x00,0x00,0x00,0x00,0x00,0x00,0x80,0x72,0x1A,0xC2,0x8A,0xC7,0x22,0xAB,0xC0,0xCE,0x4C,0x4A,0x92,0xAA,0x04,0x2D,0xA2,0xB5,0x05,0x9A,0x12,0x8C,0x8C,0xB6,0x14,0x11,0x72,0x5C,0xB3,0x92,0x52,0x52,0x4A,0x71,0xAF,0x70,0x4A,0x43,0x29,0xC5,0x23,0x4B,0xCD,0x23,0x84,0x14,0xAF,0x68,0xAA,0x08,0x60,0x52,0xDC,0xAD,0x69,0x9B,0xA4,0x29,0x49,0xF4,0x61,0x2F,0x93,0xA9,0xA2,0x25,0x5B,0xC2,0x43,0xA4,0x9A,0xD6,0x34,0x4D,0x33,0x91,0x3A,0xDE,0x5D,0x34,0xC5,0x60,0xEA,0xC4,0x32,0x37,0x73,0x13,0xA1,0xE7,0x4B,0xCD,0x2C,0x04,0x98,0x9E,0x6D,0x31,0xB5,0x12,0xA8,0x06,0xB6,0x51,0x43,0x87,0x00,0x1B,0xD0,0x43,0xF5,0x08,0x81,0x68,0x04,0x0F,0x3C,0xD3,0x08,0x03,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xA2,0x8D,0x2C,0x29,0x4A,0x56,0x6E,0x73,0x49,0xBC,0x78,0x6C,0xB9,0x54,0x26,0xAD,0xE2,0x22,0x9D,0x2A,0x9E,0xB5,0x53,0x8D,0x74,0xAA,0x69,0xB6,0x4A,0x13,0xC1,0xAE,0x86,0xA9,0x2A,0x59,0x49,0xB3,0x16,0xB4,0x1E,0x07,0xA5,0x8D,0x5C,0xD0,0x9E,0x0B,0x1C,0xB1,0xB1,0xAD,0x54,0x75,0x51,0xC9,0x49,0xF6,0xCA,0x3C,0xCD,0xEC,0x84,0x82,0x7B,0xD9,0x15,0x85,0x9C,0x4A,0xEA,0x75,0x1A,0x1D,0x76,0xAA,0x58,0xD4,0x4D,0x72,0x38,0xA9,0x62,0xD1,0xA6,0xC0,0xE1,0xA6,0x82,0x05,0xDB,0x06,0x63,0x96,0x0A,0x9A,0xF4,0x1C,0x5D,0x4E,0xC8,0x71,0xB5,0xC3,0x68,0x87,0xAE,0xC0,0x53,0x1B,0x7B,0x14,0x98,0x02,0x6D,0x2D,0xCE,0xA3,0x21,0x2A,0xF0,0x24,0xCC,0x86,0x14,0x6B,0xC1,0x35,0x4D,0x4B,0x8B,0xA1,0x12,0x5B,0xDC,0xB5,0x8C,0x94,0x5A,0x0E,0x17,0x67,0x0F,0x9C,0x1A,0xD9,0x92,0x43,0x25,0x70,0x6A,0x44,0x97,0x72,0x0E,0x62,0xA9,0x11,0x59,0x33,0x29,0x89,0x86,0x96,0x04,0xCF,0x05,0x93,0x22,0x5A,0x50,0xDA,0x87,0x58,0x0E,0x72,0x41,0xAE,0x48,0x15,0x46,0xC1,0xAB,0x26,0x1D,0x5D,0x1D,0x07,0xA0,0xFB,0xAA,0x04,0x4C,0x1F,0x15,0xF0,0x6A,0xC2,0x59,0xD9,0x65,0xC8,0xF8,0xB0,0x30,0x2E,0xA3,0x21,0xE7,0x5B,0xC5,0x25,0x83,0x9A,0x92,0x3E,0xD2,0xD4,0x14,0x22,0x0A,0xF8,0xC2,0x95,0xCB,0x94,0x2A,0xE0,0xD3,0xE4,0x4A,0x4B,0xA6,0x80,0x57,0x43,0xA2,0x6D,0x86,0x02,0xCD,0x14,0xD7,0xA8,0x98,0x0A,0xBE,0x55,0xDD,0x3C,0x50,0x28,0xD9,0x15,0x37,0x73,0xC3,0xAE,0xA4,0x47,0x5C,0xB4,0x02,0xBB,0x0A,0x2F,0x53,0xD5,0x18,0xED,0x2A,0xBC,0x55,0xD4,0xB3,0xB4,0xAB,0xD0,0x0A,0x11,0xF7,0x4A,0xAE,0x26,0x3B,0x99,0x52,0x43,0x9A,0x86,0xDC,0x40,0x1A,0x0D,0x69,0x5A,0xBC,0x13,0xA9,0xDC,0x81,0xEA,0xD0,0x29,0x90,0x76,0x8A,0xAC,0x47,0x67,0x80,0xC6,0x48,0xB1,0x01,0xBD,0x46,0x52,0xB7,0x4C,0x46,0xF0,0x0A,0xD9,0xC2,0x32,0x8A,0x40,0x58,0x65,0x0F,0x55,0x68,0x06,0xBE,0xC4,0xD9,0x1D,0x02};
const unsigned int speech_playercolor[4] = { 0x321d, 0x57c1, 0x1b8a, 0x7cf8 };
const unsigned char speech_ohoh[] = {0x60,0x3C,0x39,0x9A,0x32,0x4D,0x4A,0xF0,0x64,0x3D,0xB5,0x66,0xDB,0xC1,0x15,0xB3,0x39,0x86,0x15,0x39,0x5B,0xEC,0x21,0x1F,0x76,0x68,0x6C,0x71,0x9A,0x72,0xCD,0x21,0x29,0xC4,0x1B,0xF1,0x57,0x8B,0x00,0x22,0x14,0xFD,0x58,0xD7,0x65,0xB8,0x98,0xAF,0x13,0x2D,0xB3,0xE1,0x62,0x36,0x5F,0x35,0xD5,0x41,0x88,0xD9,0x7A,0xB1,0x50,0x1B,0x21,0x66,0xE7,0xD8,0x53,0x6D,0xB8,0x85,0xBD,0xE6,0x74,0x0B,0xE1,0x62,0xF6,0x9A,0x23,0x34,0x80,0x89,0xE9,0x0F,0x2E,0x73,0x83,0x2A,0xA6,0xDF,0x29,0x5D,0x05,0x89,0x98,0xFE,0x60,0xE3,0x08,0x28,0x12,0xFA,0x93,0x8D,0x33,0x00,0x4A,0xF0,0x57,0x76,0x6B,0xC3};


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


unsigned char dsrpath[15];
unsigned char saveslots[85];
unsigned char savegamemem[136];


unsigned char musicmem[3200];


unsigned char mainscreen[768];


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



void getconfigfilepath()
{





    unsigned char dsrname[6] = { 0,0,0,0,'.',0 };
    unsigned char x;
    unsigned int crubase;
    unsigned int romaddress;
    unsigned char fname[25];

    crubase = ( *((unsigned int*)0x83d0) );
    romaddress = ( *((unsigned int*)0x83d2) );
    romaddress += 5;

    __asm__("mov %0,r12\n\tsbo 0" : : "r"(crubase) : "r12");

    for(x=0;x<4;x++)
    {
        dsrname[x] = ( *((unsigned char*)romaddress+x) );
    }

    __asm__("mov %0,r12\n\tsbz 0" : : "r"(crubase) : "r12");


    if(dsrname[0] != 'D' || dsrname[1] != 'S' || dsrname[2] != 'K')
    {
        strcpy(dsrname,"DSK1.");
    }

    strcpy(dsrpath,dsrname);
    strcpy(fname,dsrpath);
    strcat(fname,"LUDOCFG");
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
        hchar(ypos+x,xpos,32,width);
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
# 496 "main.c"
    unsigned char idx = strlen(str);
    unsigned char c, x, b, flag;
    unsigned char validkeys[70] = {32 ,3,0};

    strcat(validkeys,numbers);
    strcat(validkeys,letters);
    strcat(validkeys,updownenter);
    strcat(validkeys,leftright);

    VDP_SET_ADDRESS_WRITE(gImage+xpos+x+(ypos*32));
    for(x=0;x<size+1;x++) { *((volatile unsigned char*)0x8C00) = 26; }

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







    windowsave(ypos, height+2);

    cleararea(xpos+1,ypos+1,height,width);
    VDP_SET_ADDRESS_WRITE(gImage+xpos+(ypos*32));
    *((volatile unsigned char*)0x8C00) = 6;
    hchar(ypos,xpos+1,1,width);
    *((volatile unsigned char*)0x8C00) = 7;
    vchar(ypos+1,xpos,2,height);
    vchar(ypos+1,xpos+width+1,3,height);
    VDP_SET_ADDRESS_WRITE(gImage+xpos+(ypos+height+1)*32);
    *((volatile unsigned char*)0x8C00) = 4;
    hchar(ypos+height+1,xpos+1,0,width);
    *((volatile unsigned char*)0x8C00) = 5;
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
        VDP_SET_ADDRESS_WRITE(gImage+xpos+(ypos*32));
        *((volatile unsigned char*)0x8C00) = 6;
        hchar(ypos,xpos+1,1,strlen(pulldownmenutitles[menunumber-1][0])+2);
    }
    for(x=0;x<pulldownmenuoptions[menunumber-1];x++)
    {
        vdpchar(gImage+xpos+(ypos+x+1)*32,2);
        conio_x = (xpos+1); conio_y = (ypos+x+1);
        cprintf(" %s ",pulldownmenutitles[menunumber-1][x]);
        vdpchar(gImage+xpos+strlen(pulldownmenutitles[menunumber-1][x])+2+(ypos+x+1)*32,2);
    }
    VDP_SET_ADDRESS_WRITE(gImage+xpos+(ypos+pulldownmenuoptions[menunumber-1]+1)*32);
    *((volatile unsigned char*)0x8C00) = 4;
    hchar(ypos+pulldownmenuoptions[menunumber-1]+1,xpos+1,0,strlen(pulldownmenutitles[menunumber-1][0])+2);
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
            hchar(1,menubarcoords[menubarchoice-1],0,strlen(menubartitles[menubarchoice-1]));
            key = getkey(validkeys,joyinterface);
            hchar(1,menubarcoords[menubarchoice-1],32,strlen(menubartitles[menubarchoice-1]));
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

    menumakeborder(10,5,6,19);
    cputsxy(12,7,"Are you sure?");
    choice = menupulldown(20,8,5);
    windowrestore();
    return choice;
}

void fileerrormessage(unsigned char ferr)
{


    menumakeborder(10,5,6,19);
    cputsxy(12,7,"File error!");
    conio_x = (12); conio_y = (8);
    cprintf("Error nr.: %2X",ferr);
    cputsxy(12,10,"Press key.");
    getkey("",1);
    windowrestore();
}



void saveconfigfile()
{


    unsigned char fname[25];
    unsigned char ferr;

    strcpy(fname,dsrpath);
    strcat(fname,"LUDOFG");

    ferr = dsr_save(fname,saveslots,85);
    if (ferr) { fileerrormessage(ferr); }
}

void loadconfigfile()
{


    unsigned char fname[25];
    unsigned char x,y;

    getconfigfilepath();

    strcpy(fname,dsrpath);
    strcat(fname,"LUDOCFG");

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


    unsigned char ferr;
    unsigned char fname[25];

    set_graphics(0);
    windowaddress = 0x1000;
    bgcolor(0x01);
    clrscr();


    loadconfigfile();


    strcpy(fname,dsrpath);
    strcat(fname,"LUDOCHR");
    ferr = dsr_load(fname,musicmem,1600);
    if (ferr) { fileerrormessage(ferr); halt(); }
    vdpmemcpy(gPattern,musicmem,1600);


    strcpy(fname,dsrpath);
    strcat(fname,"LUDOCOL");
    ferr = dsr_load(fname,musicmem,25);
    if (ferr) { fileerrormessage(ferr); halt(); }
    vdpmemcpy(gColor,musicmem,25);


    strcpy(fname,dsrpath);
    strcat(fname,"LUDOMSC");
    ferr = dsr_load(fname,mainscreen,768);
    if (ferr) { fileerrormessage(ferr); halt(); }


    strcpy(fname,dsrpath);
    strcat(fname,"LUDOTIT");
    ferr = dsr_load(fname,musicmem,576);
    if (ferr) { fileerrormessage(ferr); halt(); }
    vdpmemcpy(gImage,musicmem,576);
}

void loadmainscreen()
{


    vdpmemcpy(gImage, mainscreen, sizeof(mainscreen));
    menuplacebar();
}



unsigned char dicethrow()
{


    unsigned char dicethrow, x;

    menumakeborder(22,10,6,6);
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



    unsigned char fname[25];
    unsigned char slot = 0;
    unsigned char x, y, len, ferr;
    unsigned char yesno = 1;

    strcpy(fname,dsrpath);
    strcat(fname,"LUDOSAV");

    len = strlen(fname);

    if(autosave==1)
    {
        fname[len]=48;
        fname[len+1]=0;
    }
    else
    {
        menumakeborder(2,5,12,27);
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
            if(saveslots[slot]==0) { memset(pulldownmenutitles[7][slot],0,15); }
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


    unsigned char fname[25];
    unsigned char slot, x, y, ferr, len;
    unsigned char yesno = 1;

    strcpy(fname,dsrpath);
    strcat(fname,"LUDOSAV");

    len = strlen(fname);

    menumakeborder(2,5,12,27);
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

    menumakeborder(2,8,6,27);
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


    unsigned char fname[25];
    unsigned char len, ferr;

    strcpy(fname,dsrpath);
    strcat(fname,"LUDOMUS");

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
        ("Aug 22 2021"[ 7]),("Aug 22 2021"[ 8]),("Aug 22 2021"[ 9]),("Aug 22 2021"[10]),
        ((("Aug 22 2021"[0] == 'O') || ("Aug 22 2021"[0] == 'N') || ("Aug 22 2021"[0] == 'D')) ? '1' : '0'),( (("Aug 22 2021"[0] == 'J' && "Aug 22 2021"[1] == 'a' && "Aug 22 2021"[2] == 'n')) ? '1' : (("Aug 22 2021"[0] == 'F')) ? '2' : (("Aug 22 2021"[0] == 'M' && "Aug 22 2021"[1] == 'a' && "Aug 22 2021"[2] == 'r')) ? '3' : (("Aug 22 2021"[0] == 'A' && "Aug 22 2021"[1] == 'p')) ? '4' : (("Aug 22 2021"[0] == 'M' && "Aug 22 2021"[1] == 'a' && "Aug 22 2021"[2] == 'y')) ? '5' : (("Aug 22 2021"[0] == 'J' && "Aug 22 2021"[1] == 'u' && "Aug 22 2021"[2] == 'n')) ? '6' : (("Aug 22 2021"[0] == 'J' && "Aug 22 2021"[1] == 'u' && "Aug 22 2021"[2] == 'l')) ? '7' : (("Aug 22 2021"[0] == 'A' && "Aug 22 2021"[1] == 'u')) ? '8' : (("Aug 22 2021"[0] == 'S')) ? '9' : (("Aug 22 2021"[0] == 'O')) ? '0' : (("Aug 22 2021"[0] == 'N')) ? '1' : (("Aug 22 2021"[0] == 'D')) ? '2' : '?' ),(("Aug 22 2021"[4] >= '0') ? ("Aug 22 2021"[4]) : '0'),("Aug 22 2021"[ 5]),'-',
        ("16:06:55"[0]),("16:06:55"[1]),("16:06:55"[3]),("16:06:55"[4]) };
    menumakeborder(0,5,14,30);
    printcentered("L U D O",2,7,30);
    printcentered(version,2,8,30);
    printcentered("Written by Xander Mol",2,10,30);
    printcentered("Converted TI-99/4a, 2021",2,11,30);
    printcentered("From Commodore 128 1992",2,12,30);
    printcentered("Build with/using code of",2,14,30);
    printcentered("TMS9900-GCC by Insomnia",2,15,30);
    printcentered("Libti99 lib by Tursi",2,16,30);
    printcentered("Jedimatt42 help/code",2,17,30);
    printcentered("Press a key.",2,18,30);
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

    menumakeborder(22,6,2,8);
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

    menumakeborder(3,5,10,24);
    conio_x = (5); conio_y = (7);
    cprintf("%s has won!", playername[turnofplayernr]);

    if (detect_speech())
    {
        MUTE_SOUND();
        say_vocab(speech_playercolor[turnofplayernr]);
        speech_wait();
        speech_reset();
        say_vocab(0x7ddb);
        speech_wait();
    }

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
                            if(vr==1)
                            {
                                if(x!=y && playerpos[turnofplayernr][y][0]==1 && playerpos[turnofplayernr][y][1]<=vn && playerpos[turnofplayernr][y][1]>3 && playerpos[turnofplayernr][x][1] < playerpos[turnofplayernr][y][1])
                                {
                                    gv=1;
                                    y=3;
                                }
                            }
                            else{
                                if(x!=y && playerpos[turnofplayernr][y][0]==1 && playerpos[turnofplayernr][y][1]<=vn && playerpos[turnofplayernr][y][1]>3)
                                {
                                    gv=1;
                                    y=3;
                                }
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
        if (detect_speech())
        {
            MUTE_SOUND();
            say_data(speech_ohoh, sizeof(speech_ohoh));
            speech_wait();
        }

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
    unsigned char fname[25];
    unsigned char key;


    copy_safe_read();

    if (!detect_speech()) {
      cprintf("No speech synthesizer detected :(\n");
    }
    else
    {
        say_data(speech_intro, sizeof(speech_intro));
        speech_wait();
    }


    memset(musicmem,0,3200);
    strcpy(fname,dsrpath);
    strcat(fname,"LUDOMUS1");
    ferr = dsr_load(fname,musicmem,3200);
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


    menumakeborder(8,5,6,19);
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


            if (detect_speech())
            {
                MUTE_SOUND();
                say_vocab(speech_playercolor[turnofplayernr]);
                speech_wait();
            }

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
    StopSong();
    MUTE_SOUND();
    halt();
}
