#ifndef __DEFINES_H_
#define __DEFINES_H_

/* VDP memory assignments */
/* Done by vdp.h lib setting set_graphics(0): */
/* gImage           0x0000                        */
/* gColor           0x0380                        */
/* gPattern         0x0800                        */

#define WINDOWBASE  0x1000      // Window save memory base
#define VPAB        0x1800      // PAB memory base
#define FBUF        0x1A00      // Filebuffer memory base

/* References to redefined chars */
/* Dice graphics */
#define C_DICE01    8
#define C_DICE02    9
#define C_DICE03    10
#define C_DICE04    11
#define C_DICE05    12
#define C_DICE06    13
#define C_DICE07    14
#define C_DICE08    15
#define C_DICE09    16
#define C_DICE09    16
#define C_DICE10    17
#define C_DICE11    18
#define C_DICE12    19
#define C_DICE13    20
#define C_DICE14    21
#define C_DICE15    22
#define C_DICE16    23
#define C_DICE17    24

/* Frame border graphics */
#define C_RIGHTLINE 2
#define C_LEFTLINE  3
#define C_UPLINE    0
#define C_LOWLINE   1
#define C_UPRIGHT   4
#define C_UPLEFT    5
#define C_LOWRIGHT  6  
#define C_LOWLEFT   7
#define C_ARROW     177

/* Field and pawn graphics */
/* Empty field */
#define C_EFIELDUL  164
#define C_EFIELDUR  165
#define C_EFIELDLL  166
#define C_EFIELDLR  167
/* Filled field green */
#define C_GFIELDUL  132
#define C_GFIELDUR  133
#define C_GFIELDLL  134
#define C_GFIELDLR  135
/* Filled field red */
#define C_RFIELDUL  140
#define C_RFIELDUR  141
#define C_RFIELDLL  142
#define C_RFIELDLR  143
/* Filled field green */
#define C_BFIELDUL  148
#define C_BFIELDUR  149
#define C_BFIELDLL  150
#define C_BFIELDLR  151
/* Filled field yellow */
#define C_YFIELDUL  156
#define C_YFIELDUR  157
#define C_YFIELDLL  158
#define C_YFIELDLR  159
/* Pawn green*/
#define C_GPAWNUL   128
#define C_GPAWNUR   129
#define C_GPAWNLL   130
#define C_GPAWNLR   131
/* Pawn red*/
#define C_RPAWNUL   136
#define C_RPAWNUR   137
#define C_RPAWNLL   138
#define C_RPAWNLR   139
/* Pawn blue*/
#define C_BPAWNUL   144
#define C_BPAWNUR   145
#define C_BPAWNLL   146
#define C_BPAWNLR   147
/* Pawn yellow*/
#define C_YPAWNUL   152
#define C_YPAWNUR   153
#define C_YPAWNLL   154
#define C_YPAWNLR   155
/* Pawn white*/
#define C_WPAWNUL   160
#define C_WPAWNUR   161
#define C_WPAWNLL   162
#define C_WPAWNLR   163
/* Start field green */
#define C_GSTARTUL  172
#define C_GSTARTUR  173
#define C_GSTARTLL  174
#define C_GSTARTLR  175
/* Start field red */
#define C_RSTARTUL  180
#define C_RSTARTUR  181
#define C_RSTARTLL  182
#define C_RSTARTLR  183
/* Start field blue */
#define C_BSTARTUL  188
#define C_BSTARTUR  189
#define C_BSTARTLL  190
#define C_BSTARTLR  191
/* Start field yellow */
#define C_YSTARTUL  196
#define C_YSTARTUR  197
#define C_YSTARTLL  198
#define C_YSTARTLR  199

/* References to player color spaces */
#define C_GINVSPACE 168
#define C_RINVSPACE 176
#define C_BINVSPACE 184
#define C_YINVSPACE 192

/* References to steering chars */
#define C_LEFT      8
#define C_RIGHT     9
#define C_DOWN      10
#define C_UP        11
#define C_ENTER     13
#define C_SPACE     32
#define C_DELETE    3
#define C_INSERT    4
#define C_ESCAPE    27

/* References to white input chars */
#define C_INVSPACE  25
#define C_WUNDERL   26

/* Defines for versioning */
/* Version number */
#define VERSION_MAJOR_CH0   '1'
#define VERSION_MINOR_CH0   '9'
#define VERSION_MINOR_CH1   '9'

/* Build year */
#define BUILD_YEAR_CH0 (__DATE__[ 7])
#define BUILD_YEAR_CH1 (__DATE__[ 8])
#define BUILD_YEAR_CH2 (__DATE__[ 9])
#define BUILD_YEAR_CH3 (__DATE__[10])
/* Build month */
#define BUILD_MONTH_IS_JAN (__DATE__[0] == 'J' && __DATE__[1] == 'a' && __DATE__[2] == 'n')
#define BUILD_MONTH_IS_FEB (__DATE__[0] == 'F')
#define BUILD_MONTH_IS_MAR (__DATE__[0] == 'M' && __DATE__[1] == 'a' && __DATE__[2] == 'r')
#define BUILD_MONTH_IS_APR (__DATE__[0] == 'A' && __DATE__[1] == 'p')
#define BUILD_MONTH_IS_MAY (__DATE__[0] == 'M' && __DATE__[1] == 'a' && __DATE__[2] == 'y')
#define BUILD_MONTH_IS_JUN (__DATE__[0] == 'J' && __DATE__[1] == 'u' && __DATE__[2] == 'n')
#define BUILD_MONTH_IS_JUL (__DATE__[0] == 'J' && __DATE__[1] == 'u' && __DATE__[2] == 'l')
#define BUILD_MONTH_IS_AUG (__DATE__[0] == 'A' && __DATE__[1] == 'u')
#define BUILD_MONTH_IS_SEP (__DATE__[0] == 'S')
#define BUILD_MONTH_IS_OCT (__DATE__[0] == 'O')
#define BUILD_MONTH_IS_NOV (__DATE__[0] == 'N')
#define BUILD_MONTH_IS_DEC (__DATE__[0] == 'D')
#define BUILD_MONTH_CH0 \
    ((BUILD_MONTH_IS_OCT || BUILD_MONTH_IS_NOV || BUILD_MONTH_IS_DEC) ? '1' : '0')
#define BUILD_MONTH_CH1 \
    ( \
        (BUILD_MONTH_IS_JAN) ? '1' : \
        (BUILD_MONTH_IS_FEB) ? '2' : \
        (BUILD_MONTH_IS_MAR) ? '3' : \
        (BUILD_MONTH_IS_APR) ? '4' : \
        (BUILD_MONTH_IS_MAY) ? '5' : \
        (BUILD_MONTH_IS_JUN) ? '6' : \
        (BUILD_MONTH_IS_JUL) ? '7' : \
        (BUILD_MONTH_IS_AUG) ? '8' : \
        (BUILD_MONTH_IS_SEP) ? '9' : \
        (BUILD_MONTH_IS_OCT) ? '0' : \
        (BUILD_MONTH_IS_NOV) ? '1' : \
        (BUILD_MONTH_IS_DEC) ? '2' : \
        /* error default */    '?' \
    )
/* Build day */
#define BUILD_DAY_CH0 ((__DATE__[4] >= '0') ? (__DATE__[4]) : '0')
#define BUILD_DAY_CH1 (__DATE__[ 5])
/* Build hour */
#define BUILD_HOUR_CH0 (__TIME__[0])
#define BUILD_HOUR_CH1 (__TIME__[1])
/* Build minute */
#define BUILD_MIN_CH0 (__TIME__[3])
#define BUILD_MIN_CH1 (__TIME__[4])

#endif // __DEFINES_H_