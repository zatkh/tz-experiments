#include "tomcrypt.h"
int register_hash(const struct ltc_hash_descriptor *hash)
{
   int x;
   LTC_ARGCHK(hash != NULL);
   LTC_MUTEX_LOCK(&ltc_hash_mutex);
   for (x = 0; x < TAB_SIZE; x++) {
       if (hash_descriptor[x] == hash) {
          LTC_MUTEX_UNLOCK(&ltc_hash_mutex);
          return x;
       }
   }
   for (x = 0; x < TAB_SIZE; x++) {
       if (hash_descriptor[x] == NULL) {
          hash_descriptor[x] = hash;
          LTC_MUTEX_UNLOCK(&ltc_hash_mutex);
          return x;
       }
   }
   LTC_MUTEX_UNLOCK(&ltc_hash_mutex);
   return -1;
}
