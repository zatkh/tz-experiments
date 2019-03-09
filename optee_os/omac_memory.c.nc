#include "tomcrypt.h"
#ifdef LTC_OMAC
int omac_memory(int cipher, 
                const unsigned char *key, unsigned long keylen,
                const unsigned char *in,  unsigned long inlen,
                      unsigned char *out, unsigned long *outlen)
{
   int err;
   omac_state *omac;
   LTC_ARGCHK(key    != NULL);
   LTC_ARGCHK(in     != NULL);
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   if ((err = cipher_is_valid(cipher)) != CRYPT_OK) {
      return err;
   }
   if (cipher_descriptor[cipher]->omac_memory != NULL) {
      return cipher_descriptor[cipher]->omac_memory(key, keylen, in, inlen, out, outlen);
   }
   omac = XMALLOC(sizeof(omac_state));
   if (omac == NULL) {
      return CRYPT_MEM;
   }
   if ((err = omac_init(omac, cipher, key, keylen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   if ((err = omac_process(omac, in, inlen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   if ((err = omac_done(omac, out, outlen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   err = CRYPT_OK;
LBL_ERR:
#ifdef LTC_CLEAN_STACK
   zeromem(omac, sizeof(omac_state));
#endif
   XFREE(omac);
   return err;   
}
#endif
