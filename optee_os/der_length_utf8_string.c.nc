#include "tomcrypt.h"
#ifdef LTC_DER
unsigned long der_utf8_charsize(const wchar_t c)
{
   if (c <= 0x7F) {
      return 1;
   } else if (c <= 0x7FF) {
      return 2;
   } else if (c <= 0xFFFF) {
      return 3;
   } else {
      return 4;
   }
}
int der_length_utf8_string(const wchar_t *in, unsigned long noctets, unsigned long *outlen)
{
   unsigned long x, len;
   LTC_ARGCHK(in     != NULL);
   LTC_ARGCHK(outlen != NULL);
   len = 0;
   for (x = 0; x < noctets; x++) {
      if (in[x] < 0 || in[x] > 0x10FFFF) {
         return CRYPT_INVALID_ARG;
      }
      len += der_utf8_charsize(in[x]);
   }
   if (len < 128) {
      *outlen = 2 + len;
   } else if (len < 256) {
      *outlen = 3 + len;
   } else if (len < 65536UL) {
      *outlen = 4 + len;
   } else if (len < 16777216UL) {
      *outlen = 5 + len;
   } else {
      return CRYPT_INVALID_ARG;
   }
   return CRYPT_OK;
}
#endif
