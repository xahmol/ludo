#ifndef __SIDPLAY_H_
#define __SIDPLAY_H_

extern unsigned char PlayMusicCore;
extern unsigned char StopMusicCore;
extern unsigned char musicPaused;

void PlayMusic(void);
void StopMusic(void);

void LoadMusic(char* filename);

#endif // __SIDPLAY_H_