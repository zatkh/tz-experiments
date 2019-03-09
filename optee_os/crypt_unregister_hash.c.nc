#include "tomcrypt.h"
int unregister_hash(const struct ltc_hash_descriptor *hash)
{
   int x;
   LTC_ARGCHK(hash != NULL);
   LTC_MUTEX_LOCK(&ltc_hash_mutex);
   for (x = 0; x < TAB_SIZE; x++) {
       if (hash_descriptor[x] == hash) {
          hash_descriptor[x] = NULL;
          LTC_MUTEX_UNLOCK(&ltc_hash_mutex);
          return CRYPT_OK;
       }
   }
   LTC_MUTEX_UNLOCK(&ltc_hash_mutex);
   return CRYPT_ERROR;
}
