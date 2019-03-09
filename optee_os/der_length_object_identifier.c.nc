#include "tomcrypt.h"
#ifdef LTC_DER
unsigned long der_object_identifier_bits(unsigned long x)
{
   unsigned long c;
   x &= 0xFFFFFFFF;
   c  = 0;
   while (x) {
     ++c;
     x >>= 1;
   }
   return c;
}
int der_length_object_identifier(unsigned long *words, unsigned long nwords, unsigned long *outlen)
{
   unsigned long y, z, t, wordbuf;   
   LTC_ARGCHK(words  != NULL);
   LTC_ARGCHK(outlen != NULL);
   if (nwords < 2) {
      return CRYPT_INVALID_ARG;
   }
   if (words[0] > 3 || (words[0] < 2 && words[1] > 39)) {
      return CRYPT_INVALID_ARG;
   }
   z = 0;
   wordbuf = words[0] * 40 + words[1];
   for (y = 1; y < nwords; y++) {
       t = der_object_identifier_bits(wordbuf);
       z += t/7 + ((t%7) ? 1 : 0) + (wordbuf == 0 ? 1 : 0);
       if (y < nwords - 1) {
          wordbuf = words[y+1];
       }
   }
   if (z < 128) {
      z += 2;
   } else if (z < 256) {
      z += 3;
   } else if (z < 65536UL) {
      z += 4;
   } else {
      return CRYPT_INVALID_ARG;
   }
   *outlen = z;
   return CRYPT_OK;
}
#endif
