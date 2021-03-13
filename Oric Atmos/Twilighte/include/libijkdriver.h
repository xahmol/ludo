/*               _
 **  ___ ___ _ _|_|___ ___
 ** |  _| .'|_'_| |_ -|_ -|
 ** |_| |__,|_,_|_|___|___|
 **         raxiss (c) 2021
 **
 ** GNU General Public License v3.0
 ** See https://github.com/iss000/oricOpenLibrary/blob/main/LICENSE
 **
 */

#ifndef __LIBIJKDRIVER_H_
#define __LIBIJKDRIVER_H_

// ---------------------------------------------------------------------
// IJK driver API prototypes
void ijk_detect(void);
void ijk_read(void);
extern unsigned char ijk_present;
extern unsigned char ijk_ljoy;
extern unsigned char ijk_rjoy;

#endif // __LIBIJKDRIVER_H_