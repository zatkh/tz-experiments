#include "tomcrypt.h"
#ifdef LTC_OCB_MODE
int ocb_done_decrypt(ocb_state *ocb, 
                     const unsigned char *ct,  unsigned long ctlen,
                           unsigned char *pt, 
                     const unsigned char *tag, unsigned long taglen, int *stat)
{
   int err;
   unsigned char *tagbuf;
   unsigned long tagbuflen;
   LTC_ARGCHK(ocb  != NULL);
   LTC_ARGCHK(pt   != NULL);
   LTC_ARGCHK(ct   != NULL);
   LTC_ARGCHK(tag  != NULL);
   LTC_ARGCHK(stat != NULL);
   *stat = 0;
   tagbuf = XMALLOC(MAXBLOCKSIZE);
   if (tagbuf == NULL) {
      return CRYPT_MEM;
   }
   tagbuflen = MAXBLOCKSIZE;
   if ((err = s_ocb_done(ocb, ct, ctlen, pt, tagbuf, &tagbuflen, 1)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   if (taglen <= tagbuflen && XMEMCMP(tagbuf, tag, taglen) == 0) {
      *stat = 1;
   }
   err = CRYPT_OK;
LBL_ERR:
#ifdef LTC_CLEAN_STACK
   zeromem(tagbuf, MAXBLOCKSIZE);
#endif
   XFREE(tagbuf);
   return err;
}
#endif
