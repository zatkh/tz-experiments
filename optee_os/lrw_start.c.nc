#include "tomcrypt.h"
#ifdef LTC_LRW_MODE
int lrw_start(               int   cipher,
              const unsigned char *IV,
              const unsigned char *key,       int keylen,
              const unsigned char *tweak,
                             int  num_rounds, 
                   symmetric_LRW *lrw)
{
   int           err;
#ifdef LTC_LRW_TABLES
   unsigned char B[16];
   int           x, y, z, t;
#endif
  LTC_ARGCHK(IV    != NULL);
  LTC_ARGCHK(key   != NULL);
  LTC_ARGCHK(tweak != NULL);
  LTC_ARGCHK(lrw   != NULL);
#ifdef LTC_FAST
   if (16 % sizeof(LTC_FAST_TYPE)) {
      return CRYPT_INVALID_ARG;
   }
#endif
   if ((err = cipher_is_valid(cipher)) != CRYPT_OK) {
      return err;
   }
   if (cipher_descriptor[cipher].block_length != 16) {
      return CRYPT_INVALID_CIPHER;
   }
   if ((err = cipher_descriptor[cipher].setup(key, keylen, num_rounds, &lrw->key)) != CRYPT_OK) {
      return err;
   }
   lrw->cipher = cipher;
   XMEMCPY(lrw->tweak, tweak, 16);
#ifdef LTC_LRW_TABLES
   zeromem(B, 16);
   for (y = 0; y < 256; y++) {
        B[0] = y;
        gcm_gf_mult(tweak, B, &lrw->PC[0][y][0]);
   }
   for (x = 1; x < 16; x++) {
      for (y = 0; y < 256; y++) {
         t = lrw->PC[x-1][y][15];
         for (z = 15; z > 0; z--) {
             lrw->PC[x][y][z] = lrw->PC[x-1][y][z-1];
         }
         lrw->PC[x][y][0]  = gcm_shift_table[t<<1];
         lrw->PC[x][y][1] ^= gcm_shift_table[(t<<1)+1];
     }
  }
#endif
   return lrw_setiv(IV, 16, lrw);
}
#endif
