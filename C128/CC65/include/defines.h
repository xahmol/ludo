#ifndef __DEFINES_H_
#define __DEFINES_H_

/* Extended memory driver define */
extern char c128_ram;

/* References to redefined chars */
/* Dice graphics */
#define C_DICE01    188
#define C_DICE02    189
#define C_DICE03    190
#define C_DICE04    191
#define C_DICE05    192
#define C_DICE06    193
#define C_DICE07    194
#define C_DICE08    195
#define C_DICE09    196
#define C_DICE09    196
#define C_DICE10    197
#define C_DICE11    198
#define C_DICE12    199
#define C_DICE13    200
#define C_DICE14    201
#define C_DICE15    202

/* Frame border graphics */
#define C_RIGHTLINE 91
#define C_LEFTLINE  92
#define C_UPLINE    93
#define C_LOWLINE   94
#define C_UPRIGHT   123
#define C_UPLEFT    124
#define C_LOWRIGHT  125
#define C_LOWLEFT   126

/* Field and pawn graphics */
/* Empty field */
#define C_EFIELDUL  32
#define C_EFIELDUR  33
#define C_EFIELDLL  34
#define C_EFIELDLR  35
/* Filled field */
#define C_FFIELDUL  36
#define C_FFIELDUR  37
#define C_FFIELDLL  38
#define C_FFIELDLR  39
/* Pawn */
#define C_PAWNUL    40
#define C_PAWNUR    41
#define C_PAWNLL    42
#define C_PAWNLR    43
/* Start field green */
#define C_GSTARTUL  44
#define C_GSTARTUR  45
#define C_GSTARTLL  46
#define C_GSTARTLR  47
/* Start field red */
#define C_RSTARTUL  48
#define C_RSTARTUR  49
#define C_RSTARTLL  50
#define C_RSTARTLR  51
/* Start field blue */
#define C_BSTARTUL  52
#define C_BSTARTUR  53
#define C_BSTARTLL  54
#define C_BSTARTLR  55
/* Start field yellow */
#define C_YSTARTUL  56
#define C_YSTARTUR  57
#define C_YSTARTLL  58
#define C_YSTARTLR  59

/* References to steering chars */
#define C_LEFT      8
#define C_RIGHT     9
#define C_DOWN      10
#define C_UP        11
#define C_ENTER     13
#define C_SPACE     32
#define C_DELETE    127
#define C_INVSPACE  160

/* Defines for versioning */
/* Version number */
#define VERSION_MAJOR 1
#define VERSION_MINOR 99
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