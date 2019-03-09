#include "tomcrypt.h"
#ifdef LTC_EAX_MODE
int eax_encrypt_authenticate_memory(int cipher,
    const unsigned char *key,    unsigned long keylen,
    const unsigned char *nonce,  unsigned long noncelen,
    const unsigned char *header, unsigned long headerlen,
    const unsigned char *pt,     unsigned long ptlen,
          unsigned char *ct,
          unsigned char *tag,    unsigned long *taglen)
{
   int err;
   eax_state *eax;
   LTC_ARGCHK(key    != NULL);
   LTC_ARGCHK(pt     != NULL);
   LTC_ARGCHK(ct     != NULL);
   LTC_ARGCHK(tag    != NULL);
   LTC_ARGCHK(taglen != NULL);
   eax = XMALLOC(sizeof(*eax));
   if ((err = eax_init(eax, cipher, key, keylen, nonce, noncelen, header, headerlen)) != CRYPT_OK) {
      goto LBL_ERR; 
   }
   if ((err = eax_encrypt(eax, pt, ct, ptlen)) != CRYPT_OK) {
      goto LBL_ERR; 
   }
   if ((err = eax_done(eax, tag, taglen)) != CRYPT_OK) {
      goto LBL_ERR; 
   }
   err = CRYPT_OK;
LBL_ERR:
#ifdef LTC_CLEAN_STACK
   zeromem(eax, sizeof(*eax));
#endif
   XFREE(eax);
   return err;   
}
#endif
