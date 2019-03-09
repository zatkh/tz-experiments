#include "tomcrypt.h"
#ifdef LTC_EAX_MODE
int eax_init(eax_state *eax, int cipher, 
             const unsigned char *key,    unsigned long keylen,
             const unsigned char *nonce,  unsigned long noncelen,
             const unsigned char *header, unsigned long headerlen)
{
   unsigned char *buf;
   int           err, blklen;
   omac_state    *omac;
   unsigned long len;
   LTC_ARGCHK(eax   != NULL);
   LTC_ARGCHK(key   != NULL);
   LTC_ARGCHK(nonce != NULL);
   if (headerlen > 0) {
      LTC_ARGCHK(header != NULL);
   }
   if ((err = cipher_is_valid(cipher)) != CRYPT_OK) {
      return err;
   }
   blklen = cipher_descriptor[cipher].block_length;
   buf  = XMALLOC(MAXBLOCKSIZE);
   omac = XMALLOC(sizeof(*omac));
   if (buf == NULL || omac == NULL) {
      if (buf != NULL) {
         XFREE(buf);
      }
      if (omac != NULL) {
         XFREE(omac);
      }
      return CRYPT_MEM;
   }
   zeromem(buf, MAXBLOCKSIZE);
   if ((err = omac_init(omac, cipher, key, keylen)) != CRYPT_OK) {
      goto LBL_ERR; 
   }
   if ((err = omac_process(omac, buf, blklen)) != CRYPT_OK) {
      goto LBL_ERR; 
   }
   if ((err = omac_process(omac, nonce, noncelen)) != CRYPT_OK) {
      goto LBL_ERR; 
   }
   len = sizeof(eax->N);
   if ((err = omac_done(omac, eax->N, &len)) != CRYPT_OK) {
      goto LBL_ERR; 
   }
   zeromem(buf, MAXBLOCKSIZE);
   buf[blklen - 1] = 1;
   if ((err = omac_init(&eax->headeromac, cipher, key, keylen)) != CRYPT_OK) {
      goto LBL_ERR; 
   }
   if ((err = omac_process(&eax->headeromac, buf, blklen)) != CRYPT_OK) {
      goto LBL_ERR; 
   }
   if (headerlen != 0) {
      if ((err = omac_process(&eax->headeromac, header, headerlen)) != CRYPT_OK) {
          goto LBL_ERR; 
      }
   }
   if ((err = ctr_start(cipher, eax->N, key, keylen, 0, CTR_COUNTER_BIG_ENDIAN, &eax->ctr)) != CRYPT_OK) {
      goto LBL_ERR; 
   }
   if ((err = omac_init(&eax->ctomac, cipher, key, keylen)) != CRYPT_OK) { 
      goto LBL_ERR; 
   }
   zeromem(buf, MAXBLOCKSIZE);
   buf[blklen-1] = 2;
   if ((err = omac_process(&eax->ctomac, buf, blklen)) != CRYPT_OK) {
      goto LBL_ERR; 
   }
   err = CRYPT_OK;
LBL_ERR:
#ifdef LTC_CLEAN_STACK
   zeromem(buf,  MAXBLOCKSIZE);
   zeromem(omac, sizeof(*omac));
#endif
   XFREE(omac);
   XFREE(buf);
   return err;
}
#endif 
