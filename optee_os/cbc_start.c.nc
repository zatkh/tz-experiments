#include "tomcrypt.h"
#ifdef LTC_CBC_MODE
int cbc_start(int cipher, const unsigned char *IV, const unsigned char *key, 
              int keylen, int num_rounds, symmetric_CBC *cbc)
{
   int x, err;
   LTC_ARGCHK(IV != NULL);
   LTC_ARGCHK(key != NULL);
   LTC_ARGCHK(cbc != NULL);
   if ((err = cipher_is_valid(cipher)) != CRYPT_OK) {
      return err;
   }
   if ((err = cipher_descriptor[cipher]->setup(key, keylen, num_rounds, &cbc->key)) != CRYPT_OK) {
      return err;
   }
   cbc->blocklen = cipher_descriptor[cipher]->block_length;
   cbc->cipher   = cipher;
   for (x = 0; x < cbc->blocklen; x++) {
       cbc->IV[x] = IV[x];
   }
   return CRYPT_OK;
}
#endif
