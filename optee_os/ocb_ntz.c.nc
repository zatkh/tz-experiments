#include "tomcrypt.h"
#ifdef LTC_OCB_MODE
int ocb_ntz(unsigned long x)
{
   int c;
   x &= 0xFFFFFFFFUL;
   c = 0;
   while ((x & 1) == 0) {
      ++c;
      x >>= 1;
   }
   return c;
}
#endif
