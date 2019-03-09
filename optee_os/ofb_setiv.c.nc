#include "tomcrypt.h"
#ifdef LTC_OFB_MODE
int ofb_setiv(const unsigned char *IV, unsigned long len, symmetric_OFB *ofb)
{
   int err;
   LTC_ARGCHK(IV  != NULL);
   LTC_ARGCHK(ofb != NULL);
   if ((err = cipher_is_valid(ofb->cipher)) != CRYPT_OK) {
       return err;
   }
   if (len != (unsigned long)ofb->blocklen) {
      return CRYPT_INVALID_ARG;
   }
   ofb->padlen = 0;
   return cipher_descriptor[ofb->cipher].ecb_encrypt(IV, ofb->IV, &ofb->key);
}
#endif 
