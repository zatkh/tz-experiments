#include "tomcrypt.h"
#ifdef LTC_PKCS_1
int pkcs_1_os2ip(void *n, unsigned char *in, unsigned long inlen)
{
   return mp_read_unsigned_bin(n, in, inlen);
}
#endif 
