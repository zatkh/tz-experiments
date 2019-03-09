#include "tomcrypt.h"
#ifdef LTC_DER
int der_encode_short_integer(unsigned long num, unsigned char *out, unsigned long *outlen)
{  
   unsigned long len, x, y, z;
   int           err;
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   num &= 0xFFFFFFFFUL;
   if ((err = der_length_short_integer(num, &len)) != CRYPT_OK) {
      return err;
   }
   if (*outlen < len) {
      *outlen = len;
      return CRYPT_BUFFER_OVERFLOW;
   }
   z = 0;
   y = num;
   while (y) {
     ++z;
     y >>= 8;
   }
   if (z == 0) {
      z = 1;
   }
   z += (num&(1UL<<((z<<3) - 1))) ? 1 : 0;
   for (x = 0; (z <= 4) && (x < (4 - z)); x++) {
      num <<= 8;
   }
   x = 0;
   out[x++] = 0x02;
   out[x++] = (unsigned char)z;
   if (z == 5) {
      out[x++] = 0;
      --z;
   }
   for (y = 0; y < z; y++) {
      out[x++] = (unsigned char)((num >> 24) & 0xFF);
      num    <<= 8;
   }
   *outlen = x;
   return CRYPT_OK;
}
#endif
