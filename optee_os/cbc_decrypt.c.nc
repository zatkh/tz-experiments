#include "tomcrypt.h"
#ifdef LTC_CBC_MODE
int cbc_decrypt(const unsigned char *ct, unsigned char *pt, unsigned long len, symmetric_CBC *cbc)
{
   int x, err;
   unsigned char tmp[16];
#ifdef LTC_FAST
   LTC_FAST_TYPE tmpy;
#else
   unsigned char tmpy;
#endif         
   LTC_ARGCHK(pt  != NULL);
   LTC_ARGCHK(ct  != NULL);
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
   if (cipher_descriptor[cbc->cipher]->accel_cbc_decrypt != NULL) {
      return cipher_descriptor[cbc->cipher]->accel_cbc_decrypt(ct, pt, len / cbc->blocklen, cbc->IV, &cbc->key);
   } else {
      while (len) {
         if ((err = cipher_descriptor[cbc->cipher]->ecb_decrypt(ct, tmp, &cbc->key)) != CRYPT_OK) {
            return err;
         }
         #if defined(LTC_FAST)
        for (x = 0; x < cbc->blocklen; x += sizeof(LTC_FAST_TYPE)) {
            tmpy = *((LTC_FAST_TYPE*)((unsigned char *)cbc->IV + x)) ^ *((LTC_FAST_TYPE*)((unsigned char *)tmp + x));
       *((LTC_FAST_TYPE*)((unsigned char *)cbc->IV + x)) = *((LTC_FAST_TYPE*)((unsigned char *)ct + x));
       *((LTC_FAST_TYPE*)((unsigned char *)pt + x)) = tmpy;
        }
    #else 
            for (x = 0; x < cbc->blocklen; x++) {
               tmpy       = tmp[x] ^ cbc->IV[x];
               cbc->IV[x] = ct[x];
               pt[x]      = tmpy;
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
