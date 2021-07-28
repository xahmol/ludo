#ifndef __DEFINES_H_
#define __DEFINES_H_

/* Machine code area addresses mapping */
#define MACOSTART           0x1300      // Start of machine code area
#define MACOSIZE            0x0800      // Length of machine code area

/* Bank 1 memory addresses mapping */
#define SIDBASEADDRESS      0x2000      // 8 Kilobytes for SID data
#define LOADSAVEBUFFER      0x4000      // 4 Kilobytes load and save buffer
#define MAINSCREENADDRESS   0x5000      // 4 Kilobytes to store main screen
#define WINDOWBASEADDRESS   0x6000      // Base address for windows system data

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
#define C_RIGHTLINE 0x67
#define C_LEFTLINE  0x74
#define C_UPLINE    0x63
#define C_LOWLINE   0x64
#define C_UPRIGHT   0x6D
#define C_UPLEFT    0x6E
#define C_LOWRIGHT  0x69
#define C_LOWLEFT   0x6B

/* References to steering chars */
#define C_LEFT      157
#define C_RIGHT     29
#define C_DOWN      17
#define C_UP        145
#define C_ENTER     13
#define C_SPACE     32
#define C_DELETE    20
#define C_INSERT    148
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