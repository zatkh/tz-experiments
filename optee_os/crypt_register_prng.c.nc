#include "tomcrypt.h"
int register_prng(const struct ltc_prng_descriptor *prng)
{
   int x;
   LTC_ARGCHK(prng != NULL);
   LTC_MUTEX_LOCK(&ltc_prng_mutex);
   for (x = 0; x < TAB_SIZE; x++) {
       if (prng_descriptor[x] == prng) {
          LTC_MUTEX_UNLOCK(&ltc_prng_mutex);
          return x;
       }
   }
   for (x = 0; x < TAB_SIZE; x++) {
       if (prng_descriptor[x] == NULL) {
	  prng_descriptor[x] = prng;
          LTC_MUTEX_UNLOCK(&ltc_prng_mutex);
          return x;
       }
   }
   LTC_MUTEX_UNLOCK(&ltc_prng_mutex);
   return -1;
}
