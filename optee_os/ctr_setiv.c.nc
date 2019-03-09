#include "tomcrypt.h"
#ifdef LTC_CTR_MODE
int ctr_setiv(const unsigned char *IV, unsigned long len, symmetric_CTR *ctr)
{
   int err;
   LTC_ARGCHK(IV  != NULL);
   LTC_ARGCHK(ctr != NULL);
   if ((err = cipher_is_valid(ctr->cipher)) != CRYPT_OK) {
      return err;
   }
   if (len != (unsigned long)ctr->blocklen) {
      return CRYPT_INVALID_ARG;
   }
   XMEMCPY(ctr->ctr, IV, len);
   ctr->padlen = 0;
   return cipher_descriptor[ctr->cipher]->ecb_encrypt(IV, ctr->pad, &ctr->key);
}
#endif 
