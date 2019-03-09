#include "tomcrypt.h"
#ifdef LTC_XTS_MODE
static int tweak_uncrypt(const unsigned char *C, unsigned char *P, unsigned char *T, symmetric_xts *xts)
{
   unsigned long x;
   int err;
#ifdef LTC_FAST
   for (x = 0; x < 16; x += sizeof(LTC_FAST_TYPE)) {
      *((LTC_FAST_TYPE*)&P[x]) = *((LTC_FAST_TYPE*)&C[x]) ^ *((LTC_FAST_TYPE*)&T[x]);
   }
#else
   for (x = 0; x < 16; x++) {
       P[x] = C[x] ^ T[x];
   }
#endif
   err = cipher_descriptor[xts->cipher]->ecb_decrypt(P, P, &xts->key1);  
#ifdef LTC_FAST
   for (x = 0; x < 16; x += sizeof(LTC_FAST_TYPE)) {
      *((LTC_FAST_TYPE*)&P[x]) ^=  *((LTC_FAST_TYPE*)&T[x]);
   }
#else
   for (x = 0; x < 16; x++) {
       P[x] = P[x] ^ T[x];
   }
#endif
   xts_mult_x(T);
   return err;
}   
int xts_decrypt(const unsigned char *ct, unsigned long ptlen, unsigned char *pt, unsigned char *tweak,
         symmetric_xts *xts)
{
   const struct ltc_cipher_descriptor *desc;
   unsigned char PP[16], CC[16], T[16];
   unsigned long i, m, mo, lim;
   int           err;
   LTC_ARGCHK(pt    != NULL);
   LTC_ARGCHK(ct    != NULL);
   LTC_ARGCHK(tweak != NULL);
   LTC_ARGCHK(xts   != NULL);
   if ((err = cipher_is_valid(xts->cipher)) != CRYPT_OK) {
      return err;
   }
   m  = ptlen >> 4;
   mo = ptlen & 15;
   if (m == 0) {
      return CRYPT_INVALID_ARG;
   }
   if (mo == 0) {
      lim = m;
   } else {
      lim = m - 1;
   }
   desc = cipher_descriptor[xts->cipher];
   if (desc->accel_xts_decrypt && lim > 0) {
	   if ((err = desc->accel_xts_decrypt(ct, pt, lim, tweak, &xts->key1,
					      &xts->key2) != CRYPT_OK)) {
	      return err;
	   }
	   ct += lim * 16;
	   pt += lim * 16;
	   XMEMCPY(T, tweak, sizeof(T));
   } else {
      if ((err = desc->ecb_encrypt(tweak, T, &xts->key2)) != CRYPT_OK) {
	 return err;
      }
      for (i = 0; i < lim; i++) {
         if ((err = tweak_uncrypt(ct, pt, T, xts)) != CRYPT_OK) {
            return err;
         }
         ct += 16;
         pt += 16;
      }
   }
   if (mo > 0) {
      XMEMCPY(CC, T, 16);
      xts_mult_x(CC);
      if ((err = tweak_uncrypt(ct, PP, CC, xts)) != CRYPT_OK) {
         return err;
      }
      for (i = 0; i < mo; i++) {
          CC[i]    = ct[16+i];
          pt[16+i] = PP[i];
      }
      for (; i < 16; i++) {
          CC[i] = PP[i];
      }
      if ((err = tweak_uncrypt(CC, pt, T, xts)) != CRYPT_OK) {
         return err;
      }
   }
   if ((err = desc->ecb_decrypt(T, tweak, &xts->key2)) != CRYPT_OK) {
      return err;
   }
   return CRYPT_OK;
}
#endif
