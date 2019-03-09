#include "tomcrypt.h"
#ifdef LTC_CBC_MODE
int cbc_done(symmetric_CBC *cbc)
{
   int err;
   LTC_ARGCHK(cbc != NULL);
   if ((err = cipher_is_valid(cbc->cipher)) != CRYPT_OK) {
      return err;
   }
   cipher_descriptor[cbc->cipher]->done(&cbc->key);
   return CRYPT_OK;
}
#endif
