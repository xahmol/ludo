// ====================================================================================
// sidplay.c
// Helper functions for sidplay core assembly code
// =====================================================================================

//Includes
#include <stdio.h>
#include <string.h>
#include <peekpoke.h>
#include <cbm.h>
#include <conio.h>
#include <stdlib.h>
#include <errno.h>
#include <ctype.h>
#include <device.h>
#include <accelerator.h>
#include <c128.h>
#include <time.h>
#include <joystick.h>
#include "vdc_core.h"
#include "sidplay.h"
#include "defines.h"

void LoadMusic(char* filename)
{
	// Function to load a SID from disk and store to memory
	// Input: filename

	// Set device ID
	cbm_k_setlfs(0, getcurrentdevice(), 0);

	// Set filename
	cbm_k_setnam(filename);

	// Set bank
	SetLoadSaveBank(1);
	
	// Load from file to memory
	cbm_k_load(0,SIDBASEADDRESS);

	// Restore I/O bank to 0
	SetLoadSaveBank(0);

    // Start playing music
    PlayMusic();
}