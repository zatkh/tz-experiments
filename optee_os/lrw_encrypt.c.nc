#include "tomcrypt.h"
#ifdef LTC_LRW_MODE
int lrw_encrypt(const unsigned char *pt, unsigned char *ct, unsigned long len, symmetric_LRW *lrw)
{
   int err;
   LTC_ARGCHK(pt  != NULL);
   LTC_ARGCHK(ct  != NULL);
   LTC_ARGCHK(lrw != NULL);
   if ((err = cipher_is_valid(lrw->cipher)) != CRYPT_OK) {
      return err;
   }
   if (cipher_descriptor[lrw->cipher].accel_lrw_encrypt != NULL) {
      return cipher_descriptor[lrw->cipher].accel_lrw_encrypt(pt, ct, len, lrw->IV, lrw->tweak, &lrw->key);
   }
   return lrw_process(pt, ct, len, LRW_ENCRYPT, lrw);
}
#endif
