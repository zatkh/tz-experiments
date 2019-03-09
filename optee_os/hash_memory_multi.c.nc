#include "tomcrypt.h"
#include <stdarg.h>
int hash_memory_multi(int hash, unsigned char *out, unsigned long *outlen,
                      const unsigned char *in, unsigned long inlen, ...)
{
    hash_state          *md;
    int                  err;
    va_list              args;
    const unsigned char *curptr;
    unsigned long        curlen;
    LTC_ARGCHK(in     != NULL);
    LTC_ARGCHK(out    != NULL);
    LTC_ARGCHK(outlen != NULL);
    if ((err = hash_is_valid(hash)) != CRYPT_OK) {
        return err;
    }
    if (*outlen < hash_descriptor[hash]->hashsize) {
       *outlen = hash_descriptor[hash]->hashsize;
       return CRYPT_BUFFER_OVERFLOW;
    }
    md = XMALLOC(sizeof(hash_state));
    if (md == NULL) {
       return CRYPT_MEM;
    }
    if ((err = hash_descriptor[hash]->init(md)) != CRYPT_OK) {
       goto LBL_ERR;
    }
    va_start(args, inlen);
    curptr = in; 
    curlen = inlen;
    for (;;) {
       if ((err = hash_descriptor[hash]->process(md, curptr, curlen)) != CRYPT_OK) {
          goto LBL_ERR;
       }
       curptr = va_arg(args, const unsigned char*);
       if (curptr == NULL) {
          break;
       }
       curlen = va_arg(args, unsigned long);
    }
    err = hash_descriptor[hash]->done(md, out);
    *outlen = hash_descriptor[hash]->hashsize;
LBL_ERR:
#ifdef LTC_CLEAN_STACK
    zeromem(md, sizeof(hash_state));
#endif
    XFREE(md);
    va_end(args);
    return err;
}
