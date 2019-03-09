#include "tomcrypt.h"
#ifdef LTC_OFB_MODE
int ofb_done(symmetric_OFB *ofb)
{
   int err;
   LTC_ARGCHK(ofb != NULL);
   if ((err = cipher_is_valid(ofb->cipher)) != CRYPT_OK) {
      return err;
   }
   cipher_descriptor[ofb->cipher].done(&ofb->key);
   return CRYPT_OK;
}
#endif
