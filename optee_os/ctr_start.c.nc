#include "tomcrypt.h"
#ifdef LTC_CTR_MODE
int ctr_start(               int   cipher, 
              const unsigned char *IV, 
              const unsigned char *key,       int keylen, 
                             int  num_rounds, int ctr_mode,
                   symmetric_CTR *ctr)
{
   int x, err;
   LTC_ARGCHK(IV  != NULL);
   LTC_ARGCHK(key != NULL);
   LTC_ARGCHK(ctr != NULL);
   if ((err = cipher_is_valid(cipher)) != CRYPT_OK) {
      return err;
   }
   ctr->ctrlen   = (ctr_mode & 255) ? (ctr_mode & 255) : cipher_descriptor[cipher]->block_length;
   if (ctr->ctrlen > cipher_descriptor[cipher]->block_length) {
      return CRYPT_INVALID_ARG;
   }
   if ((ctr_mode & 0x1000) == CTR_COUNTER_BIG_ENDIAN) {
      ctr->ctrlen = cipher_descriptor[cipher]->block_length - ctr->ctrlen;
   }
   if ((err = cipher_descriptor[cipher]->setup(key, keylen, num_rounds, &ctr->key)) != CRYPT_OK) {
      return err;
   }
   ctr->blocklen = cipher_descriptor[cipher]->block_length;
   ctr->cipher   = cipher;
   ctr->padlen   = 0;
   ctr->mode     = ctr_mode & 0x1000;
   for (x = 0; x < ctr->blocklen; x++) {
       ctr->ctr[x] = IV[x];
   }
   if (ctr_mode & LTC_CTR_RFC3686) {
      if (ctr->mode == CTR_COUNTER_LITTLE_ENDIAN) {
         for (x = 0; x < ctr->ctrlen; x++) {
             ctr->ctr[x] = (ctr->ctr[x] + (unsigned char)1) & (unsigned char)255;
             if (ctr->ctr[x] != (unsigned char)0) {
                break;
             }
         }
      } else {
         for (x = ctr->blocklen-1; x >= ctr->ctrlen; x--) {
             ctr->ctr[x] = (ctr->ctr[x] + (unsigned char)1) & (unsigned char)255;
             if (ctr->ctr[x] != (unsigned char)0) {
                break;
             }
         }
      }
   }
   return cipher_descriptor[ctr->cipher]->ecb_encrypt(ctr->ctr, ctr->pad, &ctr->key); 
}
#endif
