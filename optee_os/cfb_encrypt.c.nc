#include "tomcrypt.h"
#ifdef LTC_CFB_MODE
int cfb_encrypt(const unsigned char *pt, unsigned char *ct, unsigned long len, symmetric_CFB *cfb)
{
   int err;
   LTC_ARGCHK(pt != NULL);
   LTC_ARGCHK(ct != NULL);
   LTC_ARGCHK(cfb != NULL);
   if ((err = cipher_is_valid(cfb->cipher)) != CRYPT_OK) {
       return err;
   }
   if (cfb->blocklen < 0 || cfb->blocklen > (int)sizeof(cfb->IV) ||
       cfb->padlen   < 0 || cfb->padlen   > (int)sizeof(cfb->pad)) {
      return CRYPT_INVALID_ARG;
   }
   while (len-- > 0) {
       if (cfb->padlen == cfb->blocklen) {
          if ((err = cipher_descriptor[cfb->cipher].ecb_encrypt(cfb->pad, cfb->IV, &cfb->key)) != CRYPT_OK) {
             return err;
          }
          cfb->padlen = 0;
       }
       cfb->pad[cfb->padlen] = (*ct = *pt ^ cfb->IV[cfb->padlen]);
       ++pt; 
       ++ct;
       ++(cfb->padlen);
   }
   return CRYPT_OK;
}
#endif
