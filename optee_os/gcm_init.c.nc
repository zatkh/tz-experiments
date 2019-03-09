#include "tomcrypt.h"
#ifdef LTC_GCM_MODE
int gcm_init(gcm_state *gcm, int cipher, 
             const unsigned char *key,  int keylen)
{
   int           err;
   unsigned char B[16];
#ifdef LTC_GCM_TABLES
   int           x, y, z, t;
#endif
   LTC_ARGCHK(gcm != NULL);
   LTC_ARGCHK(key != NULL);
#ifdef LTC_FAST
   if (16 % sizeof(LTC_FAST_TYPE)) {
      return CRYPT_INVALID_ARG;
   }
#endif
   if ((err = cipher_is_valid(cipher)) != CRYPT_OK) {
      return err;
   }
   if (cipher_descriptor[cipher]->block_length != 16) {
      return CRYPT_INVALID_CIPHER;
   }
   if ((err = cipher_descriptor[cipher]->setup(key, keylen, 0, &gcm->K)) != CRYPT_OK) {
      return err;
   }
   zeromem(B, 16);
   if ((err = cipher_descriptor[cipher]->ecb_encrypt(B, gcm->H, &gcm->K)) != CRYPT_OK) {
      return err;
   }
   zeromem(gcm->buf, sizeof(gcm->buf));
   zeromem(gcm->X,   sizeof(gcm->X));
   gcm->cipher   = cipher;
   gcm->mode     = LTC_GCM_MODE_IV;
   gcm->ivmode   = 0;
   gcm->buflen   = 0;
   gcm->totlen   = 0;
   gcm->pttotlen = 0;
#ifdef LTC_GCM_TABLES
   zeromem(B, 16);
   for (y = 0; y < 256; y++) {
        B[0] = y;
        gcm_gf_mult(gcm->H, B, &gcm->PC[0][y][0]);
   }
   for (x = 1; x < 16; x++) {
      for (y = 0; y < 256; y++) {
         t = gcm->PC[x-1][y][15];
         for (z = 15; z > 0; z--) {
             gcm->PC[x][y][z] = gcm->PC[x-1][y][z-1];
         }
         gcm->PC[x][y][0] = gcm_shift_table[t<<1];
         gcm->PC[x][y][1] ^= gcm_shift_table[(t<<1)+1];
     }
  }
#endif
   return CRYPT_OK;
}
#endif
