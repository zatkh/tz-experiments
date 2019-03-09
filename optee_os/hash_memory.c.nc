#include "tomcrypt.h"
int hash_memory(int hash, const unsigned char *in, unsigned long inlen, unsigned char *out, unsigned long *outlen)
{
    hash_state *md;
    int err;
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
    if ((err = hash_descriptor[hash]->process(md, in, inlen)) != CRYPT_OK) {
       goto LBL_ERR;
    }
    err = hash_descriptor[hash]->done(md, out);
    *outlen = hash_descriptor[hash]->hashsize;
LBL_ERR:
#ifdef LTC_CLEAN_STACK
    zeromem(md, sizeof(hash_state));
#endif
    XFREE(md);
    return err;
}
