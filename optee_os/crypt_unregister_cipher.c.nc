#include "tomcrypt.h"
int unregister_cipher(const struct ltc_cipher_descriptor *cipher)
{
   int x;
   LTC_ARGCHK(cipher != NULL);
   LTC_MUTEX_LOCK(&ltc_cipher_mutex);
   for (x = 0; x < TAB_SIZE; x++) {
       if (cipher_descriptor[x] == cipher) {
          cipher_descriptor[x] = NULL;
          LTC_MUTEX_UNLOCK(&ltc_cipher_mutex);
          return CRYPT_OK;
       }
   }
   LTC_MUTEX_UNLOCK(&ltc_cipher_mutex);
   return CRYPT_ERROR;
}
