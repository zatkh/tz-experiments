#include "tomcrypt.h"
int find_prng(const char *name)
{
   int x;
   LTC_ARGCHK(name != NULL);
   LTC_MUTEX_LOCK(&ltc_prng_mutex);
   for (x = 0; x < TAB_SIZE; x++) {
       if ((prng_descriptor[x] != NULL) && XSTRCMP(prng_descriptor[x]->name, name) == 0) {
          LTC_MUTEX_UNLOCK(&ltc_prng_mutex);
          return x;
       }
   }
   LTC_MUTEX_UNLOCK(&ltc_prng_mutex);
   return -1;
}
