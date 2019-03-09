#include "tomcrypt.h"
#include <stdarg.h>
int crypt_fsa(void *mp, ...)
{
   va_list  args;
   void     *p;
   va_start(args, mp);
   if (mp != NULL) {
      XMEMCPY(&ltc_mp, mp, sizeof(ltc_mp));
   }
   while ((p = va_arg(args, void*)) != NULL) {
      if (register_cipher(p) == -1) {
         va_end(args);
         return CRYPT_INVALID_CIPHER;
      }
   }
   while ((p = va_arg(args, void*)) != NULL) {
      if (register_hash(p) == -1) {
         va_end(args);
         return CRYPT_INVALID_HASH;
      }
   }
   while ((p = va_arg(args, void*)) != NULL) {
      if (register_prng(p) == -1) {
         va_end(args);
         return CRYPT_INVALID_PRNG;
      }
   }
   va_end(args);
   return CRYPT_OK;   
}
