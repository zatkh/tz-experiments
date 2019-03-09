#include "tomcrypt.h"
void zeromem(volatile void *out, size_t outlen)
{
   volatile char *mem = out;
   LTC_ARGCHKVD(out != NULL);
   while (outlen-- > 0) {
      *mem++ = 0;
   }
}
