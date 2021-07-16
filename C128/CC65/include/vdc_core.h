// ====================================================================================
// vdc_core.h
//
// Functions and definitions which make working with the Commodore 128's VDC easier
//
// Code is released under the GPL
// Scott Hutter - 2010
//
// =====================================================================================

#ifndef _VDC_CORE_
#define _VDC_CORE_


#define VDC_BLACK	0
#define VDC_DGREY	1
#define VDC_DBLUE	2
#define VDC_LBLUE	3
#define VDC_DGREEN	4
#define VDC_LGREEN	5
#define VDC_DCYAN	6
#define VDC_LCYAN	7
#define VDC_DRED	8
#define VDC_LRED	9
#define VDC_DPURPLE	10
#define VDC_LPURPLE	11
#define VDC_DYELLOW	12
#define VDC_LYELLOW	13
#define VDC_LGREY	14
#define VDC_WHITE	15

#define VDC_CURSORMODE_SOLID      0
#define VDC_CURSORMODE_NONE       1
#define VDC_CURSORMODE_FAST       2
#define VDC_CURSORMODE_NORMAL     3

// Variables in core Functions
extern unsigned char VDC_regadd;
extern unsigned char VDC_regval;
extern unsigned char VDC_addrh;
extern unsigned char VDC_addrl;
extern unsigned char VDC_desth;
extern unsigned char VDC_destl;
extern unsigned char VDC_value;
extern unsigned char VDC_tmp1;
extern unsigned char VDC_tmp2;
extern unsigned char VDC_tmp3;
extern unsigned char VDC_tmp4;

// Import assembly core Functions
void VDC_ReadRegister_core();
void VDC_WriteRegister_core();
void VDC_Poke_core();
void VDC_Peek_core();
void VDC_MemCopy_core();
void VDC_HChar_core();
void VDC_VChar_core();
void VDC_CopyMemToVDC_core();
void VDC_CopyVDCToMem_core();
void VDC_RedefineCharset_core();
void VDC_FillArea_core();
void SetLoadSaveBank_core();

// Function Prototypes
unsigned char VDC_ReadRegister(unsigned char registeraddress);
void VDC_WriteRegister(unsigned char registeraddress, unsigned char registervalue);
void VDC_Poke(int address,  unsigned char value);
unsigned char VDC_Peek(int address);
void VDC_MemCopy(unsigned int sourceaddr, unsigned int destaddr, unsigned int length);
void VDC_HChar(unsigned char row, unsigned char col, unsigned char character, unsigned char length, unsigned char attribute);
void VDC_VChar(unsigned char row, unsigned char col, unsigned char character, unsigned char length, unsigned char attribute);
void VDC_CopyMemToVDC(unsigned int vdcAddress, unsigned int memAddress, unsigned char memBank, unsigned int length);
void VDC_CopyVDCToMem(unsigned int vdcAddress, unsigned int memAddress, unsigned char memBank, unsigned int length);
void VDC_RedefineCharset(unsigned int source, unsigned char sourcebank, unsigned int dest, unsigned char lengthinchars);
void VDC_FillArea(unsigned char row, unsigned char col, unsigned char character, unsigned char length, unsigned char heigth, unsigned char attribute);

void VDC_Init(void);
void VDC_Exit(void);
unsigned char VDC_PetsciiToScreenCode(unsigned char p);
unsigned char VDC_PetsciiToScreenCodeRvs(unsigned char p);
unsigned int VDC_RowColToAddress(unsigned char row, unsigned char col);
void VDC_BackColor(unsigned char color);
unsigned char VDC_CursorAt(unsigned char row, unsigned char col);
unsigned char VDC_PrintAt(unsigned char row, unsigned char col, char *text, unsigned char attribute);
//void VDC_SetCursorMode(int cursorMode);
//int VDC_CopyMemToVDC(int memAddress, int vdcAddress, int length);
void VDC_LoadCharset(char* filename, unsigned int source, unsigned char sourcebank, unsigned char stdoralt);
unsigned char VDC_Attribute(unsigned char textcolor, unsigned char blink, unsigned char underline, unsigned char reverse, unsigned char alternate);
void SetLoadSaveBank(unsigned char bank);

#endif