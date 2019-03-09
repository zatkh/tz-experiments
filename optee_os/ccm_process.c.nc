#include "tomcrypt.h"
#ifdef LTC_CCM_MODE
int ccm_process(ccm_state *ccm,
                unsigned char *pt,     unsigned long ptlen,
                unsigned char *ct,
                int direction)
{
   unsigned char z, b;
   unsigned long y;
   int err;
   LTC_ARGCHK(ccm != NULL);
   if (ccm->aadlen != ccm->current_aadlen) {
      return CRYPT_ERROR;
   }
   if (ccm->ptlen < ccm->current_ptlen + ptlen) {
      return CRYPT_ERROR;
   }
   ccm->current_ptlen += ptlen;
   if (ptlen > 0) {
      LTC_ARGCHK(pt != NULL);
      LTC_ARGCHK(ct != NULL);
      for (y = 0; y < ptlen; y++) {
         if (ccm->CTRlen == 16) {
            for (z = 15; z > 15-ccm->L; z--) {
               ccm->ctr[z] = (ccm->ctr[z] + 1) & 255;
               if (ccm->ctr[z]) break;
            }
            if ((err = cipher_descriptor[ccm->cipher]->ecb_encrypt(ccm->ctr, ccm->CTRPAD, &ccm->K)) != CRYPT_OK) {
               return err;
            }
            ccm->CTRlen = 0;
         }
         if (direction == CCM_ENCRYPT) {
            b     = pt[y];
            ct[y] = b ^ ccm->CTRPAD[ccm->CTRlen++];
         } else {
            b     = ct[y] ^ ccm->CTRPAD[ccm->CTRlen++];
            pt[y] = b;
         }
         if (ccm->x == 16) {
            if ((err = cipher_descriptor[ccm->cipher]->ecb_encrypt(ccm->PAD, ccm->PAD, &ccm->K)) != CRYPT_OK) {
               return err;
            }
            ccm->x = 0;
         }
         ccm->PAD[ccm->x++] ^= b;
      }
   }
   return CRYPT_OK;
}
#endif
