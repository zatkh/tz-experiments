#include "tomcrypt.h"
#ifdef LTC_DER
int der_length_octet_string(unsigned long noctets, unsigned long *outlen)
{
   LTC_ARGCHK(outlen != NULL);
   if (noctets < 128) {
      *outlen = 2 + noctets;
   } else if (noctets < 256) {
      *outlen = 3 + noctets;
   } else if (noctets < 65536UL) {
      *outlen = 4 + noctets;
   } else if (noctets < 16777216UL) {
      *outlen = 5 + noctets;
   } else {
      return CRYPT_INVALID_ARG;
   }
   return CRYPT_OK;
}
#endif
