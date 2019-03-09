#include "tomcrypt.h"
#ifdef LTC_CCM_MODE
int ccm_done(ccm_state *ccm,
             unsigned char *tag,    unsigned long *taglen)
{
   unsigned long x, y;
   int            err;
   LTC_ARGCHK(ccm != NULL);
   if (ccm->ptlen != ccm->current_ptlen) {
      return CRYPT_ERROR;
   }
   LTC_ARGCHK(tag    != NULL);
   LTC_ARGCHK(taglen != NULL);
   if (ccm->x != 0) {
      if ((err = cipher_descriptor[ccm->cipher]->ecb_encrypt(ccm->PAD, ccm->PAD, &ccm->K)) != CRYPT_OK) {
         return err;
      }
   }
   for (y = 15; y > 15 - ccm->L; y--) {
      ccm->ctr[y] = 0x00;
   }
   if ((err = cipher_descriptor[ccm->cipher]->ecb_encrypt(ccm->ctr, ccm->CTRPAD, &ccm->K)) != CRYPT_OK) {
      return err;
   }
   cipher_descriptor[ccm->cipher]->done(&ccm->K);
   for (x = 0; x < 16 && x < *taglen; x++) {
      tag[x] = ccm->PAD[x] ^ ccm->CTRPAD[x];
   }
   *taglen = x;
   return CRYPT_OK;
}
#endif
