#include "tomcrypt.h"
#ifdef LTC_DER
int der_length_short_integer(unsigned long num, unsigned long *outlen)
{
   unsigned long z, y, len;
   LTC_ARGCHK(outlen  != NULL);
   num &= 0xFFFFFFFFUL;
   z = 0;
   y = num;
   while (y) {
     ++z;
     y >>= 8;
   }
   if (z == 0) {
      z = 1;
   }
   len = 1;
   ++len;
   len += z;
   len += (num&(1UL<<((z<<3) - 1))) ? 1 : 0;
   *outlen = len; 
   return CRYPT_OK;
}
#endif
