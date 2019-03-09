#include "tomcrypt.h"
#ifdef LTC_CTR_MODE
static int ctr_encrypt_sub(const unsigned char *pt, unsigned char *ct, unsigned long len, symmetric_CTR *ctr)
{
   int x, err;
   while (len) {
      if (ctr->padlen == ctr->blocklen) {
         if (ctr->mode == CTR_COUNTER_LITTLE_ENDIAN) {
            for (x = 0; x < ctr->ctrlen; x++) {
               ctr->ctr[x] = (ctr->ctr[x] + (unsigned char)1) & (unsigned char)255;
               if (ctr->ctr[x] != (unsigned char)0) {
                  break;
               }
            }
         } else {
            for (x = ctr->blocklen-1; x >= ctr->ctrlen; x--) {
               ctr->ctr[x] = (ctr->ctr[x] + (unsigned char)1) & (unsigned char)255;
               if (ctr->ctr[x] != (unsigned char)0) {
                  break;
               }
            }
         }
         if ((err = cipher_descriptor[ctr->cipher]->ecb_encrypt(ctr->ctr, ctr->pad, &ctr->key)) != CRYPT_OK) {
            return err;
         }
         ctr->padlen = 0;
      }
#ifdef LTC_FAST
      if (ctr->padlen == 0 && len >= (unsigned long)ctr->blocklen) {
         for (x = 0; x < ctr->blocklen; x += sizeof(LTC_FAST_TYPE)) {
            *((LTC_FAST_TYPE*)((unsigned char *)ct + x)) = *((LTC_FAST_TYPE*)((unsigned char *)pt + x)) ^
                                                           *((LTC_FAST_TYPE*)((unsigned char *)ctr->pad + x));
         }
       pt         += ctr->blocklen;
       ct         += ctr->blocklen;
       len        -= ctr->blocklen;
       ctr->padlen = ctr->blocklen;
       continue;
      }
#endif    
      *ct++ = *pt++ ^ ctr->pad[ctr->padlen++];
      --len;
   }
   return CRYPT_OK;
}
int ctr_encrypt(const unsigned char *pt, unsigned char *ct, unsigned long len, symmetric_CTR *ctr)
{
   int err, fr;
   LTC_ARGCHK(pt != NULL);
   LTC_ARGCHK(ct != NULL);
   LTC_ARGCHK(ctr != NULL);
   if ((err = cipher_is_valid(ctr->cipher)) != CRYPT_OK) {
       return err;
   }
   if (ctr->blocklen < 1 || ctr->blocklen > (int)sizeof(ctr->ctr) ||
       ctr->padlen   < 0 || ctr->padlen   > (int)sizeof(ctr->pad)) {
      return CRYPT_INVALID_ARG;
   }
#ifdef LTC_FAST
   if (ctr->blocklen % sizeof(LTC_FAST_TYPE)) {
      return CRYPT_INVALID_ARG;
   }
#endif
   if (cipher_descriptor[ctr->cipher]->accel_ctr_encrypt != NULL && len >= (unsigned long)ctr->blocklen) {
     if (ctr->padlen < ctr->blocklen) {
       fr = ctr->blocklen - ctr->padlen;
       if ((err = ctr_encrypt_sub(pt, ct, fr, ctr)) != CRYPT_OK) {
	 return err;
       }
       pt += fr;
       ct += fr;
       len -= fr;
     }
     if (len >= (unsigned long)ctr->blocklen) {
       if ((err = cipher_descriptor[ctr->cipher]->accel_ctr_encrypt(pt, ct, len/ctr->blocklen, ctr->ctr, ctr->mode, &ctr->key)) != CRYPT_OK) {
       return err;
       }
       pt += (len / ctr->blocklen) * ctr->blocklen;
       ct += (len / ctr->blocklen) * ctr->blocklen;
       len %= ctr->blocklen;
     }
   }
   return ctr_encrypt_sub(pt, ct, len, ctr);
}
#endif
