#include "tomcrypt.h"
int unregister_prng(const struct ltc_prng_descriptor *prng)
{
   int x;
   LTC_ARGCHK(prng != NULL);
   LTC_MUTEX_LOCK(&ltc_prng_mutex);
   for (x = 0; x < TAB_SIZE; x++) {
       if (prng_descriptor[x] == prng) {
          prng_descriptor[x] = NULL;
          LTC_MUTEX_UNLOCK(&ltc_prng_mutex);
          return CRYPT_OK;
       }
   }
   LTC_MUTEX_UNLOCK(&ltc_prng_mutex);
   return CRYPT_ERROR;
}
