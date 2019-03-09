#include "tomcrypt.h"
#ifdef LTC_DER
int der_length_boolean(unsigned long *outlen)
{
   LTC_ARGCHK(outlen != NULL);
   *outlen = 3;
   return CRYPT_OK;
}
#endif
