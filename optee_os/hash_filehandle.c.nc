#include "tomcrypt.h"
#ifndef LTC_NO_FILE
int hash_filehandle(int hash, FILE *in, unsigned char *out, unsigned long *outlen)
{
    hash_state md;
    unsigned char buf[512];
    size_t x;
    int err;
    LTC_ARGCHK(out    != NULL);
    LTC_ARGCHK(outlen != NULL);
    LTC_ARGCHK(in     != NULL);
    if ((err = hash_is_valid(hash)) != CRYPT_OK) {
        return err;
    }
    if (*outlen < hash_descriptor[hash].hashsize) {
       *outlen = hash_descriptor[hash].hashsize;
       return CRYPT_BUFFER_OVERFLOW;
    }
    if ((err = hash_descriptor[hash].init(&md)) != CRYPT_OK) {
       return err;
    }
    *outlen = hash_descriptor[hash].hashsize;
    do {
        x = fread(buf, 1, sizeof(buf), in);
        if ((err = hash_descriptor[hash].process(&md, buf, x)) != CRYPT_OK) {
           return err;
        }
    } while (x == sizeof(buf));
    err = hash_descriptor[hash].done(&md, out);
#ifdef LTC_CLEAN_STACK
    zeromem(buf, sizeof(buf));
#endif
    return err;
}
#endif 
