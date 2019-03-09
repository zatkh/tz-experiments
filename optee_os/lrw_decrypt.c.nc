#include "tomcrypt.h"
#ifdef LTC_LRW_MODE
int lrw_decrypt(const unsigned char *ct, unsigned char *pt, unsigned long len, symmetric_LRW *lrw)
{
   int err;
   LTC_ARGCHK(pt  != NULL);
   LTC_ARGCHK(ct  != NULL);
   LTC_ARGCHK(lrw != NULL);
   if ((err = cipher_is_valid(lrw->cipher)) != CRYPT_OK) {
      return err;
   }
   if (cipher_descriptor[lrw->cipher].accel_lrw_decrypt != NULL) {
      return cipher_descriptor[lrw->cipher].accel_lrw_decrypt(ct, pt, len, lrw->IV, lrw->tweak, &lrw->key);
   }
   return lrw_process(ct, pt, len, LRW_DECRYPT, lrw);
}
#endif
