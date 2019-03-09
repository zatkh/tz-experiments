#include "tomcrypt.h"
#ifdef LTC_DER
int der_encode_ia5_string(const unsigned char *in, unsigned long inlen,
                                unsigned char *out, unsigned long *outlen)
{
   unsigned long x, y, len;
   int           err;
   LTC_ARGCHK(in     != NULL);
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   if ((err = der_length_ia5_string(in, inlen, &len)) != CRYPT_OK) {
      return err; 
   }
   if (len > *outlen) {
      *outlen = len;
      return CRYPT_BUFFER_OVERFLOW;
   }
   x = 0;
   out[x++] = 0x16;
   if (inlen < 128) {
      out[x++] = (unsigned char)inlen;
   } else if (inlen < 256) {
      out[x++] = 0x81;
      out[x++] = (unsigned char)inlen;
   } else if (inlen < 65536UL) {
      out[x++] = 0x82;
      out[x++] = (unsigned char)((inlen>>8)&255);
      out[x++] = (unsigned char)(inlen&255);
   } else if (inlen < 16777216UL) {
      out[x++] = 0x83;
      out[x++] = (unsigned char)((inlen>>16)&255);
      out[x++] = (unsigned char)((inlen>>8)&255);
      out[x++] = (unsigned char)(inlen&255);
   } else {
      return CRYPT_INVALID_ARG;
   }
   for (y = 0; y < inlen; y++) {
       out[x++] = der_ia5_char_encode(in[y]);
   }
   *outlen = x;
   return CRYPT_OK;
}
#endif
