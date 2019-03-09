#include "tomcrypt.h"
#ifdef LTC_CCM_MODE
int ccm_init(ccm_state *ccm, int cipher,
             const unsigned char *key, int keylen, int ptlen, int taglen, int aadlen)
{
   int            err;
   LTC_ARGCHK(ccm    != NULL);
   LTC_ARGCHK(key    != NULL);
   LTC_ARGCHK(taglen != 0);
   XMEMSET(ccm, 0, sizeof(ccm_state));
   if ((err = cipher_is_valid(cipher)) != CRYPT_OK) {
      return err;
   }
   if (cipher_descriptor[cipher]->block_length != 16) {
      return CRYPT_INVALID_CIPHER;
   }
   ccm->taglen = taglen;
   ccm->taglen &= ~1;
   if (ccm->taglen > 16) {
      ccm->taglen = 16;
   }
   if (ccm->taglen < 4) {
      return CRYPT_INVALID_ARG;
   }
   if ((err = cipher_descriptor[cipher]->setup(key, keylen, 0, &ccm->K)) != CRYPT_OK) {
      return err;
   }
   ccm->cipher = cipher;
   ccm->ptlen = ptlen;
   ccm->L   = 0;
   while (ptlen) {
      ++ccm->L;
      ptlen >>= 8;
   }
   if (ccm->L <= 1) {
      ccm->L = 2;
   }
   ccm->aadlen = aadlen;
   return CRYPT_OK;
}
#endif
