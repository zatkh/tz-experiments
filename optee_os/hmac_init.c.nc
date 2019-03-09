#include "tomcrypt.h"
#ifdef LTC_HMAC
#define LTC_HMAC_BLOCKSIZE hash_descriptor[hash]->blocksize
int hmac_init(hmac_state *hmac, int hash, const unsigned char *key, unsigned long keylen)
{
    unsigned char *buf;
    unsigned long hashsize;
    unsigned long i, z;
    int err;
    LTC_ARGCHK(hmac != NULL);
    LTC_ARGCHK(key  != NULL);
    if ((err = hash_is_valid(hash)) != CRYPT_OK) {
        return err;
    }
    hmac->hash = hash;
    hashsize   = hash_descriptor[hash]->hashsize;
    if (keylen == 0) {
        return CRYPT_INVALID_KEYSIZE;
    }
    buf = XMALLOC(LTC_HMAC_BLOCKSIZE);
    if (buf == NULL) {
       return CRYPT_MEM;
    }
    if (sizeof(hmac->key) < LTC_HMAC_BLOCKSIZE) {
        err = CRYPT_BUFFER_OVERFLOW;
        goto LBL_ERR;
    }
    if(keylen > LTC_HMAC_BLOCKSIZE) {
        z = LTC_HMAC_BLOCKSIZE;
        if ((err = hash_memory(hash, key, keylen, hmac->key, &z)) != CRYPT_OK) {
           goto LBL_ERR;
        }
        keylen = hashsize;
    } else {
        XMEMCPY(hmac->key, key, (size_t)keylen);
    }
    if(keylen < LTC_HMAC_BLOCKSIZE) {
       zeromem((hmac->key) + keylen, (size_t)(LTC_HMAC_BLOCKSIZE - keylen));
    }
    for(i=0; i < LTC_HMAC_BLOCKSIZE;   i++) {
       buf[i] = hmac->key[i] ^ 0x36;
    }
    if ((err = hash_descriptor[hash]->init(&hmac->md)) != CRYPT_OK) {
       goto LBL_ERR;
    }
    if ((err = hash_descriptor[hash]->process(&hmac->md, buf, LTC_HMAC_BLOCKSIZE)) != CRYPT_OK) {
       goto LBL_ERR;
    }
    goto done;
LBL_ERR:
done:
#ifdef LTC_CLEAN_STACK
   zeromem(buf, LTC_HMAC_BLOCKSIZE);
#endif
   XFREE(buf);
   return err;    
}
#endif
