#include "tomcrypt.h"
#include <stdarg.h>
#ifdef LTC_XCBC
int xcbc_memory_multi(int cipher, 
                const unsigned char *key, unsigned long keylen,
                      unsigned char *out, unsigned long *outlen,
                const unsigned char *in,  unsigned long inlen, ...)
{
   int                  err;
   xcbc_state          *xcbc;
   va_list              args;
   const unsigned char *curptr;
   unsigned long        curlen;
   LTC_ARGCHK(key    != NULL);
   LTC_ARGCHK(in     != NULL);
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   xcbc = XMALLOC(sizeof(xcbc_state));
   if (xcbc == NULL) {
      return CRYPT_MEM;
   }
   if ((err = xcbc_init(xcbc, cipher, key, keylen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   va_start(args, inlen);
   curptr = in; 
   curlen = inlen;
   for (;;) {
      if ((err = xcbc_process(xcbc, curptr, curlen)) != CRYPT_OK) {
         goto LBL_ERR;
      }
      curptr = va_arg(args, const unsigned char*);
      if (curptr == NULL) {
         break;
      }
      curlen = va_arg(args, unsigned long);
   }
   if ((err = xcbc_done(xcbc, out, outlen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
LBL_ERR:
#ifdef LTC_CLEAN_STACK
   zeromem(xcbc, sizeof(xcbc_state));
#endif
   XFREE(xcbc);
   va_end(args);
   return err;   
}
#endif
