#include "tomcrypt.h"
#ifdef LTC_OFB_MODE
int ofb_getiv(unsigned char *IV, unsigned long *len, symmetric_OFB *ofb)
{
   LTC_ARGCHK(IV  != NULL);
   LTC_ARGCHK(len != NULL);
   LTC_ARGCHK(ofb != NULL);
   if ((unsigned long)ofb->blocklen > *len) {
      *len = ofb->blocklen;
      return CRYPT_BUFFER_OVERFLOW;
   }
   XMEMCPY(IV, ofb->IV, ofb->blocklen);
   *len = ofb->blocklen;
   return CRYPT_OK;
}
#endif
