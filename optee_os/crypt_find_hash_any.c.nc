#include "tomcrypt.h"
int find_hash_any(const char *name, int digestlen)
{
   int x, y, z;
   LTC_ARGCHK(name != NULL);
   x = find_hash(name);
   if (x != -1) return x;
   LTC_MUTEX_LOCK(&ltc_hash_mutex);
   y = MAXBLOCKSIZE+1;
   z = -1;
   for (x = 0; x < TAB_SIZE; x++) {
       if (hash_descriptor[x] == NULL) {
          continue;
       }
       if ((int)hash_descriptor[x]->hashsize >= digestlen && (int)hash_descriptor[x]->hashsize < y) {
          z = x;
          y = hash_descriptor[x]->hashsize;
       }
   }
   LTC_MUTEX_UNLOCK(&ltc_hash_mutex);
   return z;
}
