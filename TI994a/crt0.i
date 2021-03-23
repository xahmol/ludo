# 1 "crt0.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "crt0.c"




extern int main(void);





void _start2(void)
{

  {
    extern int __VAL_START;
    extern int __DATA_START;
    extern int __DATA_END;
    char *src = (char*)&__VAL_START;
    char *dst = (char*)&__DATA_START;
    while(dst < (char*)&__DATA_END)
    {
      *dst++ = *src++;
    }
  }


  {
    extern int __BSS_START;
    extern int __BSS_END;
    char *dst = (char*)&__BSS_START;
    while(dst < (char*)&__BSS_END)
    {
      *dst++ = 0;
    }
  }
# 54 "crt0.c"
  main();



  while(1);
}




void _start(void)
{





  __asm__("\tlimi 0");




  __asm__("\tlwpi >8300");


  __asm__("\tli sp, >4000");


  __asm__("\tb @_start2");
}
