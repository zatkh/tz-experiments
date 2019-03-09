#include "tomcrypt.h"
#if defined(LTC_BASE64) || defined (LTC_BASE64_URL)
#if defined(LTC_BASE64)
static const char *codes_base64 =
"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
#endif 
#if defined(LTC_BASE64_URL)
static const char *codes_base64url =
"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
#endif 
static int _base64_encode_internal(const unsigned char *in,  unsigned long inlen,
                                 unsigned char *out, unsigned long *outlen,
                                 const char *codes, int pad)
{
   unsigned long i, len2, leven;
   unsigned char *p;
   LTC_ARGCHK(in     != NULL);
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   len2 = 4 * ((inlen + 2) / 3);
   if (*outlen < len2 + 1) {
      *outlen = len2 + 1;
      return CRYPT_BUFFER_OVERFLOW;
   }
   p = out;
   leven = 3*(inlen / 3);
   for (i = 0; i < leven; i += 3) {
       *p++ = codes[(in[0] >> 2) & 0x3F];
       *p++ = codes[(((in[0] & 3) << 4) + (in[1] >> 4)) & 0x3F];
       *p++ = codes[(((in[1] & 0xf) << 2) + (in[2] >> 6)) & 0x3F];
       *p++ = codes[in[2] & 0x3F];
       in += 3;
   }
   if (i < inlen) {
       unsigned a = in[0];
       unsigned b = (i+1 < inlen) ? in[1] : 0;
       *p++ = codes[(a >> 2) & 0x3F];
       *p++ = codes[(((a & 3) << 4) + (b >> 4)) & 0x3F];
       if (pad) {
         *p++ = (i+1 < inlen) ? codes[(((b & 0xf) << 2)) & 0x3F] : '=';
         *p++ = '=';
       }
       else {
         if (i+1 < inlen) *p++ = codes[(((b & 0xf) << 2)) & 0x3F];
       }
   }
   *p = '\0';
   *outlen = p - out;
   return CRYPT_OK;
}
#if defined(LTC_BASE64)
int base64_encode(const unsigned char *in,  unsigned long inlen,
                        unsigned char *out, unsigned long *outlen)
{
    return _base64_encode_internal(in, inlen, out, outlen, codes_base64, 1);
}
#endif 
#if defined(LTC_BASE64_URL)
int base64url_encode(const unsigned char *in,  unsigned long inlen,
                           unsigned char *out, unsigned long *outlen)
{
    return _base64_encode_internal(in, inlen, out, outlen, codes_base64url, 0);
}
#endif 
#endif
