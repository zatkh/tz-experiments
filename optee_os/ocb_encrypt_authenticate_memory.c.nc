#include "tomcrypt.h"
#ifdef LTC_OCB_MODE
int ocb_encrypt_authenticate_memory(int cipher,
    const unsigned char *key,    unsigned long keylen,
    const unsigned char *nonce,  
    const unsigned char *pt,     unsigned long ptlen,
          unsigned char *ct,
          unsigned char *tag,    unsigned long *taglen)
{
   int err;
   ocb_state *ocb;
   LTC_ARGCHK(key    != NULL);
   LTC_ARGCHK(nonce  != NULL);
   LTC_ARGCHK(pt     != NULL);
   LTC_ARGCHK(ct     != NULL);
   LTC_ARGCHK(tag    != NULL);
   LTC_ARGCHK(taglen != NULL);
   ocb = XMALLOC(sizeof(ocb_state));
   if (ocb == NULL) {
      return CRYPT_MEM;
   }
   if ((err = ocb_init(ocb, cipher, key, keylen, nonce)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   while (ptlen > (unsigned long)ocb->block_len) {
        if ((err = ocb_encrypt(ocb, pt, ct)) != CRYPT_OK) {
           goto LBL_ERR;
        }
        ptlen   -= ocb->block_len;
        pt      += ocb->block_len;
        ct      += ocb->block_len;
   }
   err = ocb_done_encrypt(ocb, pt, ptlen, ct, tag, taglen);
LBL_ERR:
#ifdef LTC_CLEAN_STACK
   zeromem(ocb, sizeof(ocb_state));
#endif
   XFREE(ocb);
   return err;
}
#endif
