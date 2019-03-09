#include "tomcrypt.h"
#ifdef LTC_DER
int der_length_bit_string(unsigned long nbits, unsigned long *outlen)
{
   unsigned long nbytes;
   LTC_ARGCHK(outlen != NULL);
   nbytes = (nbits >> 3) + ((nbits & 7) ? 1 : 0) + 1;
   if (nbytes < 128) {
      *outlen = 2 + nbytes;
   } else if (nbytes < 256) {
      *outlen = 3 + nbytes;
   } else if (nbytes < 65536) {
      *outlen = 4 + nbytes;
   } else {
      return CRYPT_INVALID_ARG;
   }
   return CRYPT_OK;
}
#endif
