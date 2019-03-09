#include "tomcrypt.h"
#ifdef LTC_XCBC
int xcbc_done(xcbc_state *xcbc, unsigned char *out, unsigned long *outlen)
{
   int err, x;
   LTC_ARGCHK(xcbc != NULL);
   LTC_ARGCHK(out  != NULL);
   if ((err = cipher_is_valid(xcbc->cipher)) != CRYPT_OK) {
      return err;
   }
   if ((xcbc->blocksize > cipher_descriptor[xcbc->cipher].block_length) || (xcbc->blocksize < 0) ||
       (xcbc->buflen > xcbc->blocksize) || (xcbc->buflen < 0)) {
      return CRYPT_INVALID_ARG;
   }
   if (xcbc->buflen == xcbc->blocksize) {
      for (x = 0; x < xcbc->blocksize; x++) {
         xcbc->IV[x] ^= xcbc->K[1][x];
      }
   } else {
      xcbc->IV[xcbc->buflen] ^= 0x80;
      for (x = 0; x < xcbc->blocksize; x++) {
         xcbc->IV[x] ^= xcbc->K[2][x];
      }
   }
   cipher_descriptor[xcbc->cipher].ecb_encrypt(xcbc->IV, xcbc->IV, &xcbc->key);
   cipher_descriptor[xcbc->cipher].done(&xcbc->key);
   for (x = 0; x < xcbc->blocksize && (unsigned long)x < *outlen; x++) {
      out[x] = xcbc->IV[x];
   }
   *outlen = x;
#ifdef LTC_CLEAN_STACK
   zeromem(xcbc, sizeof(*xcbc));
#endif
   return CRYPT_OK;
}
#endif
