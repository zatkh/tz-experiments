#include "tomcrypt.h"
#ifdef LTC_EAX_MODE
int eax_decrypt_verify_memory(int cipher,
    const unsigned char *key,    unsigned long keylen,
    const unsigned char *nonce,  unsigned long noncelen,
    const unsigned char *header, unsigned long headerlen,
    const unsigned char *ct,     unsigned long ctlen,
          unsigned char *pt,
          unsigned char *tag,    unsigned long taglen,
          int           *stat)
{
   int            err;
   eax_state     *eax;
   unsigned char *buf;
   unsigned long  buflen;
   LTC_ARGCHK(stat != NULL);
   LTC_ARGCHK(key  != NULL);
   LTC_ARGCHK(pt   != NULL);
   LTC_ARGCHK(ct   != NULL);
   LTC_ARGCHK(tag  != NULL);
   *stat = 0;
   buf = XMALLOC(taglen);
   eax = XMALLOC(sizeof(*eax));
   if (eax == NULL || buf == NULL) {
      if (eax != NULL) {
         XFREE(eax);
      }
      if (buf != NULL) {
         XFREE(buf);
      }
      return CRYPT_MEM;
   }
   if ((err = eax_init(eax, cipher, key, keylen, nonce, noncelen, header, headerlen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   if ((err = eax_decrypt(eax, ct, pt, ctlen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   buflen = taglen;
   if ((err = eax_done(eax, buf, &buflen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   if (buflen >= taglen && XMEMCMP(buf, tag, taglen) == 0) {
      *stat = 1;
   }
   err = CRYPT_OK;
LBL_ERR:
#ifdef LTC_CLEAN_STACK
   zeromem(buf, taglen);
   zeromem(eax, sizeof(*eax));
#endif
   XFREE(eax);
   XFREE(buf);
   return err;
}
#endif
