#include "tomcrypt.h"
#ifdef LTC_OMAC
int omac_init(omac_state *omac, int cipher, const unsigned char *key, unsigned long keylen)
{
   int err, x, y, mask, msb, len;
   LTC_ARGCHK(omac != NULL);
   LTC_ARGCHK(key  != NULL);
   if ((err = cipher_is_valid(cipher)) != CRYPT_OK) {
      return err;
   }
#ifdef LTC_FAST
   if (cipher_descriptor[cipher]->block_length % sizeof(LTC_FAST_TYPE)) {
       return CRYPT_INVALID_ARG;
   }
#endif
   switch (cipher_descriptor[cipher]->block_length) {
       case 8:  mask = 0x1B;
                len  = 8;
                break;
       case 16: mask = 0x87;
                len  = 16;
                break;
       default: return CRYPT_INVALID_ARG;
   }
   if ((err = cipher_descriptor[cipher]->setup(key, keylen, 0, &omac->key)) != CRYPT_OK) {
      return err;
   }
   zeromem(omac->Lu[0], cipher_descriptor[cipher]->block_length);
   if ((err = cipher_descriptor[cipher]->ecb_encrypt(omac->Lu[0], omac->Lu[0], &omac->key)) != CRYPT_OK) {
      return err;
   }
   for (x = 0; x < 2; x++) {
       msb = omac->Lu[x][0] >> 7;
       for (y = 0; y < (len - 1); y++) {
           omac->Lu[x][y] = ((omac->Lu[x][y] << 1) | (omac->Lu[x][y+1] >> 7)) & 255;
       }
       omac->Lu[x][len - 1] = ((omac->Lu[x][len - 1] << 1) ^ (msb ? mask : 0)) & 255;
       if (x == 0) {
          XMEMCPY(omac->Lu[1], omac->Lu[0], sizeof(omac->Lu[0]));
       }
   }
   omac->cipher_idx = cipher;
   omac->buflen     = 0;
   omac->blklen     = len;
   zeromem(omac->prev,  sizeof(omac->prev));
   zeromem(omac->block, sizeof(omac->block));
   return CRYPT_OK;
}
#endif
