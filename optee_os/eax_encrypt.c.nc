#include "tomcrypt.h"
#ifdef LTC_EAX_MODE
int eax_encrypt(eax_state *eax, const unsigned char *pt, unsigned char *ct, 
                unsigned long length)
{
   int err;
   LTC_ARGCHK(eax != NULL);
   LTC_ARGCHK(pt  != NULL);
   LTC_ARGCHK(ct  != NULL);
   if ((err = ctr_encrypt(pt, ct, length, &eax->ctr)) != CRYPT_OK) {
      return err;
   }
   return omac_process(&eax->ctomac, ct, length);
}
#endif
