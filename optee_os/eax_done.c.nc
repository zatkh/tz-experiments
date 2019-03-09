#include "tomcrypt.h"
#ifdef LTC_EAX_MODE
int eax_done(eax_state *eax, unsigned char *tag, unsigned long *taglen)
{
   int           err;
   unsigned char *headermac, *ctmac;
   unsigned long x, len;
   LTC_ARGCHK(eax    != NULL);
   LTC_ARGCHK(tag    != NULL);
   LTC_ARGCHK(taglen != NULL);
   headermac = XMALLOC(MAXBLOCKSIZE);
   ctmac     = XMALLOC(MAXBLOCKSIZE);
   if (headermac == NULL || ctmac == NULL) {
      if (headermac != NULL) {
         XFREE(headermac);
      }
      if (ctmac != NULL) {
         XFREE(ctmac);
      }
      return CRYPT_MEM;
   }
   len = MAXBLOCKSIZE;
   if ((err = omac_done(&eax->ctomac, ctmac, &len)) != CRYPT_OK) {
      goto LBL_ERR; 
   }
   if ((err = omac_done(&eax->headeromac, headermac, &len)) != CRYPT_OK) {
      goto LBL_ERR; 
   }
   if ((err = ctr_done(&eax->ctr)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   for (x = 0; x < len && x < *taglen; x++) {
       tag[x] = eax->N[x] ^ headermac[x] ^ ctmac[x];
   }
   *taglen = x;
   err = CRYPT_OK;
LBL_ERR:
#ifdef LTC_CLEAN_STACK
   zeromem(ctmac,     MAXBLOCKSIZE);
   zeromem(headermac, MAXBLOCKSIZE);
   zeromem(eax,       sizeof(*eax));
#endif
   XFREE(ctmac);
   XFREE(headermac);
   return err;
}
#endif
