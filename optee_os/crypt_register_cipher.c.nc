#include "tomcrypt.h"
int register_cipher(const struct ltc_cipher_descriptor *cipher)
{
   int x;
   LTC_ARGCHK(cipher != NULL);
   LTC_MUTEX_LOCK(&ltc_cipher_mutex);
   for (x = 0; x < TAB_SIZE; x++) {
       if (cipher_descriptor[x] != NULL && cipher_descriptor[x]->ID == cipher->ID) {
          LTC_MUTEX_UNLOCK(&ltc_cipher_mutex);
          return x;
       }
   }
   for (x = 0; x < TAB_SIZE; x++) {
       if (cipher_descriptor[x] == NULL) {
          cipher_descriptor[x] = cipher;
          LTC_MUTEX_UNLOCK(&ltc_cipher_mutex);
          return x;
       }
   }
   LTC_MUTEX_UNLOCK(&ltc_cipher_mutex);
   return -1;
}
