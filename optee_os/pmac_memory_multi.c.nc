#include "tomcrypt.h"
#include <stdarg.h>
#ifdef LTC_PMAC
int pmac_memory_multi(int cipher, 
                const unsigned char *key, unsigned long  keylen,
                      unsigned char *out, unsigned long *outlen,
                const unsigned char *in,  unsigned long  inlen, ...)
{
   int                  err;
   pmac_state          *pmac;
   va_list              args;
   const unsigned char *curptr;
   unsigned long        curlen;
   LTC_ARGCHK(key    != NULL);
   LTC_ARGCHK(in     != NULL);
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   pmac = XMALLOC(sizeof(pmac_state));
   if (pmac == NULL) {
      return CRYPT_MEM;
   }
   if ((err = pmac_init(pmac, cipher, key, keylen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   va_start(args, inlen);
   curptr = in; 
   curlen = inlen;
   for (;;) {
      if ((err = pmac_process(pmac, curptr, curlen)) != CRYPT_OK) {
         goto LBL_ERR;
      }
      curptr = va_arg(args, const unsigned char*);
      if (curptr == NULL) {
         break;
      }
      curlen = va_arg(args, unsigned long);
   }
   if ((err = pmac_done(pmac, out, outlen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
LBL_ERR:
#ifdef LTC_CLEAN_STACK
   zeromem(pmac, sizeof(pmac_state));
#endif
   XFREE(pmac);
   va_end(args);
   return err;   
}
#endif
