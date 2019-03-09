#include "tomcrypt.h"
#ifdef LTC_HMAC
#define LTC_HMAC_BLOCKSIZE hash_descriptor[hash]->blocksize
int hmac_done(hmac_state *hmac, unsigned char *out, unsigned long *outlen)
{
    unsigned char *buf, *isha;
    unsigned long hashsize, i;
    int hash, err;
    LTC_ARGCHK(hmac  != NULL);
    LTC_ARGCHK(out   != NULL);
    hash = hmac->hash;
    if((err = hash_is_valid(hash)) != CRYPT_OK) {
        return err;
    }
    hashsize = hash_descriptor[hash]->hashsize;
    buf  = XMALLOC(LTC_HMAC_BLOCKSIZE);
    isha = XMALLOC(hashsize);
    if (buf == NULL || isha == NULL) { 
       if (buf != NULL) {
          XFREE(buf);
       } 
       if (isha != NULL) {
          XFREE(isha);
       }  
       return CRYPT_MEM;
    }
    if ((err = hash_descriptor[hash]->done(&hmac->md, isha)) != CRYPT_OK) {
       goto LBL_ERR;
    }
    for(i=0; i < LTC_HMAC_BLOCKSIZE; i++) {
        buf[i] = hmac->key[i] ^ 0x5C;
    }
    if ((err = hash_descriptor[hash]->init(&hmac->md)) != CRYPT_OK) {
       goto LBL_ERR;
    }
    if ((err = hash_descriptor[hash]->process(&hmac->md, buf, LTC_HMAC_BLOCKSIZE)) != CRYPT_OK) {
       goto LBL_ERR;
    }
    if ((err = hash_descriptor[hash]->process(&hmac->md, isha, hashsize)) != CRYPT_OK) {
       goto LBL_ERR;
    }
    if ((err = hash_descriptor[hash]->done(&hmac->md, buf)) != CRYPT_OK) {
       goto LBL_ERR;
    }
    for (i = 0; i < hashsize && i < *outlen; i++) {
        out[i] = buf[i];
    }
    *outlen = i;
    err = CRYPT_OK;
LBL_ERR:
#ifdef LTC_CLEAN_STACK
    zeromem(isha, hashsize);
    zeromem(buf,  hashsize);
    zeromem(hmac, sizeof(*hmac));
#endif
    XFREE(isha);
    XFREE(buf);
    return err;
}
#endif
