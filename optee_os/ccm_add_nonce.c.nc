#include "tomcrypt.h"
#ifdef LTC_CCM_MODE
int ccm_add_nonce(ccm_state *ccm,
                  const unsigned char *nonce,     unsigned long noncelen)
{
   unsigned long x, y, len;
   int           err;
   LTC_ARGCHK(ccm   != NULL);
   LTC_ARGCHK(nonce != NULL);
   ccm->noncelen = (noncelen > 13) ? 13 : noncelen;
   if ((15 - ccm->noncelen) > ccm->L) {
      ccm->L = 15 - ccm->noncelen;
   }
   if ((ccm->noncelen + ccm->L) > 15) {
      ccm->noncelen = 15 - ccm->L;
   }
   x = 0;
   ccm->PAD[x++] = (unsigned char)(((ccm->aadlen > 0) ? (1<<6) : 0) |
		   (((ccm->taglen - 2)>>1)<<3)        |
		   (ccm->L-1));
   for (y = 0; y < (16 - (ccm->L + 1)); y++) {
      ccm->PAD[x++] = nonce[y];
   }
   len = ccm->ptlen;
   for (y = ccm->L; y < 4; y++) {
      len <<= 8;
   }
   for (y = 0; ccm->L > 4 && (ccm->L-y)>4; y++) {
      ccm->PAD[x++] = 0;
   }
   for (; y < ccm->L; y++) {
      ccm->PAD[x++] = (unsigned char)((len >> 24) & 255);
      len <<= 8;
   }
   if ((err = cipher_descriptor[ccm->cipher]->ecb_encrypt(ccm->PAD, ccm->PAD, &ccm->K)) != CRYPT_OK) {
      return err;
   }
   ccm->x = 0;
   if (ccm->aadlen > 0) {
      if (ccm->aadlen < ((1UL<<16) - (1UL<<8))) {
         ccm->PAD[ccm->x++] ^= (ccm->aadlen>>8) & 255;
         ccm->PAD[ccm->x++] ^= ccm->aadlen & 255;
      } else {
         ccm->PAD[ccm->x++] ^= 0xFF;
         ccm->PAD[ccm->x++] ^= 0xFE;
         ccm->PAD[ccm->x++] ^= (ccm->aadlen>>24) & 255;
         ccm->PAD[ccm->x++] ^= (ccm->aadlen>>16) & 255;
         ccm->PAD[ccm->x++] ^= (ccm->aadlen>>8) & 255;
         ccm->PAD[ccm->x++] ^= ccm->aadlen & 255;
      }
   }
   x = 0;
   ccm->ctr[x++] = (unsigned char)ccm->L-1;
   for (y = 0; y < (16 - (ccm->L+1)); ++y) {
      ccm->ctr[x++] = nonce[y];
   }
   while (x < 16) {
      ccm->ctr[x++] = 0;
   }
   ccm->CTRlen = 16;
   return CRYPT_OK;
}
#endif
