#include "tomcrypt.h"
#ifdef LTC_OMAC
int omac_process(omac_state *omac, const unsigned char *in, unsigned long inlen)
{
   unsigned long n, x;
   int           err;
   LTC_ARGCHK(omac  != NULL);
   LTC_ARGCHK(in    != NULL);
   if ((err = cipher_is_valid(omac->cipher_idx)) != CRYPT_OK) {
      return err;
   }
   if ((omac->buflen > (int)sizeof(omac->block)) || (omac->buflen < 0) ||
       (omac->blklen > (int)sizeof(omac->block)) || (omac->buflen > omac->blklen)) {
      return CRYPT_INVALID_ARG;
   }
#ifdef LTC_FAST
   unsigned long blklen = cipher_descriptor[omac->cipher_idx]->block_length;
   if (omac->buflen == 0 && inlen > blklen) {
      unsigned long y;
      for (x = 0; x < (inlen - blklen); x += blklen) {
          for (y = 0; y < blklen; y += sizeof(LTC_FAST_TYPE)) {
              *((LTC_FAST_TYPE*)(&omac->prev[y])) ^= *((LTC_FAST_TYPE*)(&in[y]));
          }
          in += blklen;
          if ((err = cipher_descriptor[omac->cipher_idx]->ecb_encrypt(omac->prev, omac->prev, &omac->key)) != CRYPT_OK) {
             return err;
          }
      }
      inlen -= x;
    }
#endif
   while (inlen != 0) { 
       if (omac->buflen == omac->blklen) {
          for (x = 0; x < (unsigned long)omac->blklen; x++) {
              omac->block[x] ^= omac->prev[x];
          }
          if ((err = cipher_descriptor[omac->cipher_idx]->ecb_encrypt(omac->block, omac->prev, &omac->key)) != CRYPT_OK) {
             return err;
          }
          omac->buflen = 0;
       }
       n = MIN(inlen, (unsigned long)(omac->blklen - omac->buflen));
       XMEMCPY(omac->block + omac->buflen, in, n);
       omac->buflen  += n;
       inlen         -= n;
       in            += n;
   }
   return CRYPT_OK;
}
#endif
