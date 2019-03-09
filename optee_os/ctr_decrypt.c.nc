#include "tomcrypt.h"
#ifdef LTC_CTR_MODE
int ctr_decrypt(const unsigned char *ct, unsigned char *pt, unsigned long len, symmetric_CTR *ctr)
{
   LTC_ARGCHK(pt != NULL);
   LTC_ARGCHK(ct != NULL);
   LTC_ARGCHK(ctr != NULL);
   return ctr_encrypt(ct, pt, len, ctr);
}
#endif
