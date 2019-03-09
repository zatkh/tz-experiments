#include "tomcrypt.h"
#ifdef LTC_EAX_MODE
int eax_decrypt(eax_state *eax, const unsigned char *ct, unsigned char *pt, 
                unsigned long length)
{
   int err;
   LTC_ARGCHK(eax != NULL);
   LTC_ARGCHK(pt  != NULL);
   LTC_ARGCHK(ct  != NULL);
   if ((err = omac_process(&eax->ctomac, ct, length)) != CRYPT_OK) {
      return err;
   }
   return ctr_decrypt(ct, pt, length, &eax->ctr);
}
#endif
