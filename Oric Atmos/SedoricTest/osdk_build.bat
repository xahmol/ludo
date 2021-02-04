@ECHO OFF


::
:: Initial check.
:: Verify if the SDK is correctly configurated
::
IF "%OSDK%"=="" GOTO ErCfg

%OSDK%\bin\header build\sedorictest.bin build\SEDTEST.tap $0501

::
:: Convert musics
:: ym1.mym -> 8699 bytes
:: ym2.mym -> 7293 bytes
:: ym3.mym -> 7956 bytes
::
:: HIRES last usable memory area is $9800 / 38912
:: - 8657 -> $762f / 30255
:: Round to -> $7600 / 30208 this gives us $2200 / 8704 bytes for the music
::
:: TEXT last usable memory area is $B400 / 46080
:: $B400-$7600  gives us $3E00 / 15872 bytes for the music
::
:: So we make each music load in $7600
::
:: The depacking buffer for the music requires 256 bytes per register, so 256*14 bytes = $e00 / 3584 bytes
:: If we place the buffer just before the music file, it will start at the location $7600-$e00 = $6800 / 26624
::
:: And just before that we put the music player binary file, which will start by two JMP:
:: - (+0) JMP StartMusic
:: - (+3) JMP StopMusic
::
:: The music player itself is less than 512 bytes without counting the IRQ installation and what nots so could start in $6600, say $6500 for security
::

ECHO Building DSK file
%OSDK%\bin\tap2dsk -c20:3 -nSEDORICTEST build\SEDTEST.tap build\SEDTEST.dsk
%OSDK%\bin\old2mfm build\SEDTEST.dsk

GOTO End

::
:: Outputs an error message
::
:ErCfg
ECHO == ERROR ==
ECHO The Oric SDK was not configured properly
ECHO You should have a OSDK environment variable setted to the location of the SDK
IF "%OSDKBRIEF%"=="" PAUSE
GOTO End


:End
pause