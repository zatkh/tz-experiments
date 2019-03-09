#include "tomcrypt.h"
#ifdef LTC_CBC_MODE
int cbc_encrypt(const unsigned char *pt, unsigned char *ct, unsigned long len, symmetric_CBC *cbc)
{
   int x, err;
   LTC_ARGCHK(pt != NULL);
   LTC_ARGCHK(ct != NULL);
   LTC_ARGCHK(cbc != NULL);
   if ((err = cipher_is_valid(cbc->cipher)) != CRYPT_OK) {
       return err;
   }
   if (cbc->blocklen < 1 || cbc->blocklen > (int)sizeof(cbc->IV)) {
      return CRYPT_INVALID_ARG;
   }    
   if (len % cbc->blocklen) {
      return CRYPT_INVALID_ARG;
   }
#ifdef LTC_FAST
   if (cbc->blocklen % sizeof(LTC_FAST_TYPE)) {   
      return CRYPT_INVALID_ARG;
   }
#endif
   if (cipher_descriptor[cbc->cipher]->accel_cbc_encrypt != NULL) {
      return cipher_descriptor[cbc->cipher]->accel_cbc_encrypt(pt, ct, len / cbc->blocklen, cbc->IV, &cbc->key);
   } else {
      while (len) {
         #if defined(LTC_FAST)
        for (x = 0; x < cbc->blocklen; x += sizeof(LTC_FAST_TYPE)) {
            *((LTC_FAST_TYPE*)((unsigned char *)cbc->IV + x)) ^= *((LTC_FAST_TYPE*)((unsigned char *)pt + x));
        }
    #else 
            for (x = 0; x < cbc->blocklen; x++) {
               cbc->IV[x] ^= pt[x];
            }
    #endif
         if ((err = cipher_descriptor[cbc->cipher]->ecb_encrypt(cbc->IV, ct, &cbc->key)) != CRYPT_OK) {
            return err;
         }
         #if defined(LTC_FAST)
        for (x = 0; x < cbc->blocklen; x += sizeof(LTC_FAST_TYPE)) {
            *((LTC_FAST_TYPE*)((unsigned char *)cbc->IV + x)) = *((LTC_FAST_TYPE*)((unsigned char *)ct + x));
        }
    #else 
             for (x = 0; x < cbc->blocklen; x++) {
                cbc->IV[x] = ct[x];
             }
    #endif
        ct  += cbc->blocklen;
        pt  += cbc->blocklen;
        len -= cbc->blocklen;
     }
   }
   return CRYPT_OK;
}
#endif
