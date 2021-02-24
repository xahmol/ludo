/*From OSDK lib.h */

#ifndef __OSDKLIB_H_
#define __OSDKLIB_H_

/* PEEK POKE */
#define peek(address)		( *((unsigned char*)address) )
#define poke(address,value)	( *((unsigned char*)address)=(unsigned char)value )

#define deek(address)		( *((unsigned int*)address) )
#define doke(address,value)	( *((unsigned int*)address)=(unsigned int)value )


/* System data */

#define TEXTVRAM    0xbb80
#define STDCHRTABLE 0xb400
#define ALTCHRTABLE 0xb800


#define GETPAPER    (peek(0x26b)-16)   /* return current paper colour */
#define GETINK	    peek(0x26c)        /* return current ink colour */


/* This returns which dead key is currently pressed */
/* Use the #defines below to check for the keys     */

#define getdeadkeys() peek(0x209)

#define NOKEY	    0x38
#define ALTGR	    0xa0   /* Euphoric only */
#define CTRL	    0xa2
#define LSHIFT	    0xa4
#define FUNC	    0xa5   /* Atmos only (and Euphoric, of course) */
#define RSHIFT	    0xa7


/* Serial Attributes, curses style :-| */

#define A_FWBLACK    0
#define A_FWRED 	 1
#define A_FWGREEN	 2
#define A_FWYELLOW	 3
#define A_FWBLUE	 4
#define A_FWMAGENTA	 5
#define A_FWCYAN	 6
#define A_FWWHITE	 7
#define A_BGBLACK	16
#define A_BGRED 	17
#define A_BGGREEN	18
#define A_BGYELLOW	19
#define A_BGBLUE	20
#define A_BGMAGENTA	21
#define A_BGCYAN	22
#define A_BGWHITE	23
#define A_STD		 8
#define A_ALT		 9
#define A_STD2H 	10
#define A_ALT2H 	11
#define A_STDFL 	12
#define A_ALTFL 	13
#define A_STD2HFL	14
#define A_ALT2HFL	15
#define A_TEXT60	24
#define A_TEXT50	26
#define A_HIRES60	28
#define A_HIRES50	30


/* This gets and sets some system flags    */
/* Use the #defines below to set the flags */

#define getflags()  peek(0x26a)
#define setflags(x) poke(0x26a,x)

#define CURSOR	   0x01  /* Cursor on		  (ctrl-q) */
#define SCREEN	   0x02  /* Printout to screen on (ctrl-s) */
#define NOKEYCLICK 0x08  /* Turn keyclick off	  (ctrl-f) */
#define PROTECT    0x20  /* Protect columns 0-1   (ctrl-]) */

 #endif // __OSDKLIB_H_