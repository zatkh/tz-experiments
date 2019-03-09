#include "tomcrypt.h"
#ifdef LTC_PKCS_1
int pkcs_1_i2osp(void *n, unsigned long modulus_len, unsigned char *out)
{
   unsigned long size;
   size = mp_unsigned_bin_size(n);
   if (size > modulus_len) {
      return CRYPT_BUFFER_OVERFLOW;
   }
   zeromem(out, modulus_len);
   return mp_to_unsigned_bin(n, out+(modulus_len-size));
}
#endif 
