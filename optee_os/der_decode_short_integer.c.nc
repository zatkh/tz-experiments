#include "tomcrypt.h"
#ifdef LTC_DER
int der_decode_short_integer(const unsigned char *in, unsigned long inlen, unsigned long *num)
{
   unsigned long len, x, y;
   LTC_ARGCHK(num    != NULL);
   LTC_ARGCHK(in     != NULL);
   if (inlen < 2) {
      return CRYPT_INVALID_PACKET;
   }
   x = 0;
   if ((in[x++] & 0x1F) != 0x02) {
      return CRYPT_INVALID_PACKET;
   }
   len = in[x++];
   if (x + len > inlen) {
      return CRYPT_INVALID_PACKET;
   }
   y = 0;
   while (len--) {
      y = (y<<8) | (unsigned long)in[x++];
   }
   *num = y;
   return CRYPT_OK;
}
#endif
