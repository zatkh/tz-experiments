#include "tomcrypt.h"
#ifdef LTC_ECB_MODE
int ecb_encrypt(const unsigned char *pt, unsigned char *ct, unsigned long len, symmetric_ECB *ecb)
{
   int err;
   LTC_ARGCHK(pt != NULL);
   LTC_ARGCHK(ct != NULL);
   LTC_ARGCHK(ecb != NULL);
   if ((err = cipher_is_valid(ecb->cipher)) != CRYPT_OK) {
       return err;
   }
   if (len % cipher_descriptor[ecb->cipher]->block_length) {
      return CRYPT_INVALID_ARG;
   }
   if (cipher_descriptor[ecb->cipher]->accel_ecb_encrypt != NULL) {
      return cipher_descriptor[ecb->cipher]->accel_ecb_encrypt(pt, ct, len / cipher_descriptor[ecb->cipher]->block_length, &ecb->key);
   } else {
      while (len) {
         if ((err = cipher_descriptor[ecb->cipher]->ecb_encrypt(pt, ct, &ecb->key)) != CRYPT_OK) {
            return err;
         }
         pt  += cipher_descriptor[ecb->cipher]->block_length;
         ct  += cipher_descriptor[ecb->cipher]->block_length;
         len -= cipher_descriptor[ecb->cipher]->block_length;
      }
   }
   return CRYPT_OK;
}
#endif
