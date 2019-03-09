#include "tomcrypt.h"
#ifdef LTC_DER
int der_length_utctime(ltc_utctime *utctime, unsigned long *outlen)
{
   LTC_ARGCHK(outlen  != NULL);
   LTC_ARGCHK(utctime != NULL);
   if (utctime->off_hh == 0 && utctime->off_mm == 0) {
      *outlen = 2 + 13;
   } else {
      *outlen = 2 + 17;
   }
   return CRYPT_OK;
}
#endif
