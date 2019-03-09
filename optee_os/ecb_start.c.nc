#include "tomcrypt.h"
#ifdef LTC_ECB_MODE
int ecb_start(int cipher, const unsigned char *key, int keylen, int num_rounds, symmetric_ECB *ecb)
{
   int err;
   LTC_ARGCHK(key != NULL);
   LTC_ARGCHK(ecb != NULL);
   if ((err = cipher_is_valid(cipher)) != CRYPT_OK) {
      return err;
   }
   ecb->cipher = cipher;
   ecb->blocklen = cipher_descriptor[cipher]->block_length;
   return cipher_descriptor[cipher]->setup(key, keylen, num_rounds, &ecb->key);
}
#endif
