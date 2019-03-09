#include "tomcrypt.h"
#ifdef LTC_OFB_MODE
int ofb_encrypt(const unsigned char *pt, unsigned char *ct, unsigned long len, symmetric_OFB *ofb)
{
   int err;
   LTC_ARGCHK(pt != NULL);
   LTC_ARGCHK(ct != NULL);
   LTC_ARGCHK(ofb != NULL);
   if ((err = cipher_is_valid(ofb->cipher)) != CRYPT_OK) {
       return err;
   }
   if (ofb->blocklen < 0 || ofb->blocklen > (int)sizeof(ofb->IV) ||
       ofb->padlen   < 0 || ofb->padlen   > (int)sizeof(ofb->IV)) {
      return CRYPT_INVALID_ARG;
   }
   while (len-- > 0) {
       if (ofb->padlen == ofb->blocklen) {
          if ((err = cipher_descriptor[ofb->cipher].ecb_encrypt(ofb->IV, ofb->IV, &ofb->key)) != CRYPT_OK) {
             return err;
          }
          ofb->padlen = 0;
       }
       *ct++ = *pt++ ^ ofb->IV[(ofb->padlen)++];
   }
   return CRYPT_OK;
}
#endif
