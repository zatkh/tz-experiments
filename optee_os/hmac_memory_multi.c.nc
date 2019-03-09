#include "tomcrypt.h"
#include <stdarg.h>
#ifdef LTC_HMAC
int hmac_memory_multi(int hash, 
                const unsigned char *key,  unsigned long keylen,
                      unsigned char *out,  unsigned long *outlen,
                const unsigned char *in,   unsigned long inlen, ...)
{
    hmac_state          *hmac;
    int                  err;
    va_list              args;
    const unsigned char *curptr;
    unsigned long        curlen;
    LTC_ARGCHK(key    != NULL);
    LTC_ARGCHK(in     != NULL);
    LTC_ARGCHK(out    != NULL); 
    LTC_ARGCHK(outlen != NULL);
    hmac = XMALLOC(sizeof(hmac_state));
    if (hmac == NULL) {
       return CRYPT_MEM;
    }
    if ((err = hmac_init(hmac, hash, key, keylen)) != CRYPT_OK) {
       goto LBL_ERR;
    }
    va_start(args, inlen);
    curptr = in; 
    curlen = inlen;
    for (;;) {
       if ((err = hmac_process(hmac, curptr, curlen)) != CRYPT_OK) {
          goto LBL_ERR;
       }
       curptr = va_arg(args, const unsigned char*);
       if (curptr == NULL) {
          break;
       }
       curlen = va_arg(args, unsigned long);
    }
    if ((err = hmac_done(hmac, out, outlen)) != CRYPT_OK) {
       goto LBL_ERR;
    }
LBL_ERR:
#ifdef LTC_CLEAN_STACK
   zeromem(hmac, sizeof(hmac_state));
#endif
   XFREE(hmac);
   va_end(args);
   return err;   
}
#endif
