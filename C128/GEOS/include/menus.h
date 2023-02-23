#ifndef __MENUS_H_
#define __MENUS_H_

// Declare functions prototype
unsigned char VDC_DetectVDCMemSize();
void InitVideomode();
void ReinitScreen(char *s);
void geosSwitch4080();
void gameRestart();
void gameColor();
void fileLoad();
void fileSave();
void fileAutosaveToggle();
void informationCredits();
void savegame(unsigned char autosave);
void loadgame();
void ShowCredits();
void AutosaveToggle();
void MonochromeToggle();
void Switch4080();

#endif