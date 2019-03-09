#include "tomcrypt.h"
#ifdef LTC_XTS_MODE
void xts_mult_x(unsigned char *I)
{
  int x;
  unsigned char t, tt;
  for (x = t = 0; x < 16; x++) {
     tt   = I[x] >> 7;
     I[x] = ((I[x] << 1) | t) & 0xFF;
     t    = tt;
  }
  if (tt) {
     I[0] ^= 0x87;
  } 
}
#endif
