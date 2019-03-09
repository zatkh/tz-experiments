#include "tomcrypt.h"
#ifdef LTC_CCM_MODE
int ccm_add_aad(ccm_state *ccm,
                const unsigned char *adata,  unsigned long adatalen)
{
   unsigned long y;
   int            err;
   LTC_ARGCHK(ccm   != NULL);
   LTC_ARGCHK(adata != NULL);
   if (ccm->aadlen < ccm->current_aadlen + adatalen) {
      return CRYPT_INVALID_ARG;
   }
   ccm->current_aadlen += adatalen;
   for (y = 0; y < adatalen; y++) {
      if (ccm->x == 16) {
         if ((err = cipher_descriptor[ccm->cipher]->ecb_encrypt(ccm->PAD, ccm->PAD, &ccm->K)) != CRYPT_OK) {
            return CRYPT_ERROR;
         }
         ccm->x = 0;
      }
      ccm->PAD[ccm->x++] ^= adata[y];
   }
   if (ccm->aadlen == ccm->current_aadlen) {
      if (ccm->x != 0) {
         if ((err = cipher_descriptor[ccm->cipher]->ecb_encrypt(ccm->PAD, ccm->PAD, &ccm->K)) != CRYPT_OK) {
            return CRYPT_ERROR;
         }
      }
      ccm->x = 0;
   }
   return CRYPT_OK;
}
#endif
