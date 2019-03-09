#include "tomcrypt.h"
#ifdef LTC_CBC_MODE
int cbc_getiv(unsigned char *IV, unsigned long *len, symmetric_CBC *cbc)
{
   LTC_ARGCHK(IV  != NULL);
   LTC_ARGCHK(len != NULL);
   LTC_ARGCHK(cbc != NULL);
   if ((unsigned long)cbc->blocklen > *len) {
      *len = cbc->blocklen;
      return CRYPT_BUFFER_OVERFLOW;
   }
   XMEMCPY(IV, cbc->IV, cbc->blocklen);
   *len = cbc->blocklen;
   return CRYPT_OK;
}
#endif
