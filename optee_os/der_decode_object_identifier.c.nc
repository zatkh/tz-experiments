#include "tomcrypt.h"
#ifdef LTC_DER
int der_decode_object_identifier(const unsigned char *in,    unsigned long  inlen,
                                       unsigned long *words, unsigned long *outlen)
{
   unsigned long x, y, t, len;
   LTC_ARGCHK(in     != NULL);
   LTC_ARGCHK(words  != NULL);
   LTC_ARGCHK(outlen != NULL);
   if (inlen < 3) {
      return CRYPT_INVALID_PACKET;
   }
   if (*outlen < 2) {
      return CRYPT_BUFFER_OVERFLOW;
   }
   x = 0;
   if ((in[x++] & 0x1F) != 0x06) {
      return CRYPT_INVALID_PACKET;
   }
   if (in[x] < 128) {
      len = in[x++]; 
   } else {
       if (in[x] < 0x81 || in[x] > 0x82) {
          return CRYPT_INVALID_PACKET;
       }
       y   = in[x++] & 0x7F;
       len = 0;
       while (y--) {
          len = (len << 8) | (unsigned long)in[x++];
       }
   }
   if (len < 1 || (len + x) > inlen) {
      return CRYPT_INVALID_PACKET;
   }
   y = 0;
   t = 0;
   while (len--) {
       t = (t << 7) | (in[x] & 0x7F);
       if (!(in[x++] & 0x80)) {
           if (y >= *outlen) {
              return CRYPT_BUFFER_OVERFLOW;
           }
      if (y == 0) {
         words[0] = t / 40;
         words[1] = t % 40;
         y = 2;
      } else {
              words[y++] = t;
      }
           t          = 0;
       }
   }
   *outlen = y;
   return CRYPT_OK;
}
#endif
