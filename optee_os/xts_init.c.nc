#include "tomcrypt.h"
#ifdef LTC_XTS_MODE
int xts_start(                int  cipher,
              const unsigned char *key1, 
              const unsigned char *key2, 
                    unsigned long  keylen,
                              int  num_rounds, 
                    symmetric_xts *xts)
{
   int err;
   LTC_ARGCHK(key1  != NULL);
   LTC_ARGCHK(key2  != NULL);
   LTC_ARGCHK(xts   != NULL);
   if ((err = cipher_is_valid(cipher)) != CRYPT_OK) {
      return err;
   }
   if (cipher_descriptor[cipher]->block_length != 16) {
      return CRYPT_INVALID_ARG;
   }
   if ((err = cipher_descriptor[cipher]->setup(key1, keylen, num_rounds, &xts->key1)) != CRYPT_OK) {
      return err;
   }
   if ((err = cipher_descriptor[cipher]->setup(key2, keylen, num_rounds, &xts->key2)) != CRYPT_OK) {
      return err;
   }
   xts->cipher = cipher;
   return err;
}
#endif
