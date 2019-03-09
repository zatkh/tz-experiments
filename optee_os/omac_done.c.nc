#include "tomcrypt.h"
#ifdef LTC_OMAC
int omac_done(omac_state *omac, unsigned char *out, unsigned long *outlen)
{
   int       err, mode;
   unsigned  x;
   LTC_ARGCHK(omac   != NULL);
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   if ((err = cipher_is_valid(omac->cipher_idx)) != CRYPT_OK) {
      return err;
   }
   if ((omac->buflen > (int)sizeof(omac->block)) || (omac->buflen < 0) ||
       (omac->blklen > (int)sizeof(omac->block)) || (omac->buflen > omac->blklen)) {
      return CRYPT_INVALID_ARG;
   }
   if (omac->buflen != omac->blklen) {
      omac->block[omac->buflen++] = 0x80;
      while (omac->buflen < omac->blklen) {
         omac->block[omac->buflen++] = 0x00;
      }
      mode = 1;
   } else {
      mode = 0;
   }
   for (x = 0; x < (unsigned)omac->blklen; x++) {
       omac->block[x] ^= omac->prev[x] ^ omac->Lu[mode][x];
   }
   if ((err = cipher_descriptor[omac->cipher_idx]->ecb_encrypt(omac->block, omac->block, &omac->key)) != CRYPT_OK) {
      return err;
   }
   cipher_descriptor[omac->cipher_idx]->done(&omac->key);
   for (x = 0; x < (unsigned)omac->blklen && x < *outlen; x++) {
       out[x] = omac->block[x];
   }
   *outlen = x;
#ifdef LTC_CLEAN_STACK
   zeromem(omac, sizeof(*omac));
#endif
   return CRYPT_OK;
}
#endif
