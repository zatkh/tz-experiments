#include "tomcrypt.h"
#ifdef LTC_DER
int der_decode_octet_string(const unsigned char *in, unsigned long inlen,
                                  unsigned char *out, unsigned long *outlen)
{
   unsigned long x, y, len;
   LTC_ARGCHK(in     != NULL);
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   if (inlen < 2) {
      return CRYPT_INVALID_PACKET;
   }
   if ((in[0] & 0x1F) != 0x04) {
      return CRYPT_INVALID_PACKET;
   }
   x = 1;
   if (in[x] & 0x80) {
      y = in[x] & 0x7F;
      if ((y == 0) || (y > 3) || ((x + y) > inlen)) {
         return CRYPT_INVALID_PACKET;
      }
      len = 0;
      ++x;
      while (y--) {
         len = (len << 8) | in[x++];
      }
   } else {
      len = in[x++] & 0x7F;
   }
   if (len > *outlen) {
      *outlen = len;
      return CRYPT_BUFFER_OVERFLOW;
   }
   if (len + x > inlen) {
      return CRYPT_INVALID_PACKET;
   }
   for (y = 0; y < len; y++) {
       out[y] = in[x++];
   }
   *outlen = y;
   return CRYPT_OK;
}
#endif
