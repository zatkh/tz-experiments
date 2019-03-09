#include "tomcrypt.h"
#include <stdarg.h>
#ifdef LTC_OMAC
int omac_memory_multi(int cipher, 
                const unsigned char *key, unsigned long keylen,
                      unsigned char *out, unsigned long *outlen,
                const unsigned char *in,  unsigned long inlen, ...)
{
   int                  err;
   omac_state          *omac;
   va_list              args;
   const unsigned char *curptr;
   unsigned long        curlen;
   LTC_ARGCHK(key    != NULL);
   LTC_ARGCHK(in     != NULL);
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   omac = XMALLOC(sizeof(omac_state));
   if (omac == NULL) {
      return CRYPT_MEM;
   }
   if ((err = omac_init(omac, cipher, key, keylen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   va_start(args, inlen);
   curptr = in; 
   curlen = inlen;
   for (;;) {
      if ((err = omac_process(omac, curptr, curlen)) != CRYPT_OK) {
         goto LBL_ERR;
      }
      curptr = va_arg(args, const unsigned char*);
      if (curptr == NULL) {
         break;
      }
      curlen = va_arg(args, unsigned long);
   }
   if ((err = omac_done(omac, out, outlen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
LBL_ERR:
#ifdef LTC_CLEAN_STACK
   zeromem(omac, sizeof(omac_state));
#endif
   XFREE(omac);
   va_end(args);
   return err;   
}
#endif
