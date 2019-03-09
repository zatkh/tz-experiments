#include "tomcrypt.h"
int find_cipher_any(const char *name, int blocklen, int keylen)
{
   int x;
   LTC_ARGCHK(name != NULL);
   x = find_cipher(name);
   if (x != -1) return x;
   LTC_MUTEX_LOCK(&ltc_cipher_mutex);
   for (x = 0; x < TAB_SIZE; x++) {
       if (cipher_descriptor[x] == NULL) {
          continue;
       }
       if (blocklen <= (int)cipher_descriptor[x]->block_length && keylen <= (int)cipher_descriptor[x]->max_key_length) {
          LTC_MUTEX_UNLOCK(&ltc_cipher_mutex);
          return x;
       }
   }
   LTC_MUTEX_UNLOCK(&ltc_cipher_mutex);
   return -1;
}
