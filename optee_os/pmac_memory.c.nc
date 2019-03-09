#include "tomcrypt.h"
#ifdef LTC_PMAC
int pmac_memory(int cipher, 
                const unsigned char *key, unsigned long keylen,
                const unsigned char *in, unsigned long inlen,
                      unsigned char *out, unsigned long *outlen)
{
   int err;
   pmac_state *pmac;
   LTC_ARGCHK(key    != NULL);
   LTC_ARGCHK(in    != NULL);
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   pmac = XMALLOC(sizeof(pmac_state));
   if (pmac == NULL) {
      return CRYPT_MEM;
   }
   if ((err = pmac_init(pmac, cipher, key, keylen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   if ((err = pmac_process(pmac, in, inlen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   if ((err = pmac_done(pmac, out, outlen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   err = CRYPT_OK;
LBL_ERR:
#ifdef LTC_CLEAN_STACK
   zeromem(pmac, sizeof(pmac_state));
#endif
   XFREE(pmac);
   return err;   
}
#endif
