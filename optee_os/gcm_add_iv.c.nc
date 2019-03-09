#include "tomcrypt.h"
#ifdef LTC_GCM_MODE
int gcm_add_iv(gcm_state *gcm, 
               const unsigned char *IV,     unsigned long IVlen)
{
   unsigned long x, y;
   int           err;
   LTC_ARGCHK(gcm != NULL);
   if (IVlen > 0) {
      LTC_ARGCHK(IV  != NULL);
   }
   if (gcm->mode != LTC_GCM_MODE_IV) {
      return CRYPT_INVALID_ARG;
   }
   if (gcm->buflen >= 16 || gcm->buflen < 0) {
      return CRYPT_INVALID_ARG;
   }
   if ((err = cipher_is_valid(gcm->cipher)) != CRYPT_OK) {
      return err;
   }
   if (IVlen + gcm->buflen > 12) {
      gcm->ivmode |= 1;
   }
   x = 0;
#ifdef LTC_FAST
   if (gcm->buflen == 0) {
      for (x = 0; x < (IVlen & ~15); x += 16) {
          for (y = 0; y < 16; y += sizeof(LTC_FAST_TYPE)) {
              *((LTC_FAST_TYPE*)(&gcm->X[y])) ^= *((LTC_FAST_TYPE*)(&IV[x + y]));
          }
          gcm_mult_h(gcm, gcm->X);
          gcm->totlen += 128;
      }
      IV += x;
   }
#endif
   for (; x < IVlen; x++) {
       gcm->buf[gcm->buflen++] = *IV++;
       if (gcm->buflen == 16) {
         for (y = 0; y < 16; y++) {
             gcm->X[y] ^= gcm->buf[y];
         }
         gcm_mult_h(gcm, gcm->X);
         gcm->buflen = 0;
         gcm->totlen += 128;
      }
   }
   return CRYPT_OK;
}
#endif
