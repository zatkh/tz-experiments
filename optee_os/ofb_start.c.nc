#include "tomcrypt.h"
#ifdef LTC_OFB_MODE
int ofb_start(int cipher, const unsigned char *IV, const unsigned char *key, 
              int keylen, int num_rounds, symmetric_OFB *ofb)
{
   int x, err;
   LTC_ARGCHK(IV != NULL);
   LTC_ARGCHK(key != NULL);
   LTC_ARGCHK(ofb != NULL);
   if ((err = cipher_is_valid(cipher)) != CRYPT_OK) {
      return err;
   }
   ofb->cipher = cipher;
   ofb->blocklen = cipher_descriptor[cipher].block_length;
   for (x = 0; x < ofb->blocklen; x++) {
       ofb->IV[x] = IV[x];
   }
   ofb->padlen = ofb->blocklen;
   return cipher_descriptor[cipher].setup(key, keylen, num_rounds, &ofb->key);
}
#endif
