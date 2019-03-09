#include "tomcrypt.h"
#ifdef LTC_F8_MODE
int f8_setiv(const unsigned char *IV, unsigned long len, symmetric_F8 *f8)
{
   int err;
   LTC_ARGCHK(IV != NULL);
   LTC_ARGCHK(f8 != NULL);
   if ((err = cipher_is_valid(f8->cipher)) != CRYPT_OK) {
       return err;
   }
   if (len != (unsigned long)f8->blocklen) {
      return CRYPT_INVALID_ARG;
   }
   f8->padlen = 0;
   return cipher_descriptor[f8->cipher].ecb_encrypt(IV, f8->IV, &f8->key);
}
#endif 
