#include "tomcrypt.h"
#ifdef LTC_HMAC
int hmac_memory(int hash, 
                const unsigned char *key,  unsigned long keylen,
                const unsigned char *in,   unsigned long inlen, 
                      unsigned char *out,  unsigned long *outlen)
{
    hmac_state *hmac;
    int         err;
    LTC_ARGCHK(key    != NULL);
    LTC_ARGCHK(in     != NULL);
    LTC_ARGCHK(out    != NULL); 
    LTC_ARGCHK(outlen != NULL);
    if ((err = hash_is_valid(hash)) != CRYPT_OK) {
       return err;
    }
    if (hash_descriptor[hash]->hmac_block != NULL) {
        return hash_descriptor[hash]->hmac_block(key, keylen, in, inlen, out, outlen);
    }
    hmac = XMALLOC(sizeof(hmac_state));
    if (hmac == NULL) {
       return CRYPT_MEM;
    }
    if ((err = hmac_init(hmac, hash, key, keylen)) != CRYPT_OK) {
       goto LBL_ERR;
    }
    if ((err = hmac_process(hmac, in, inlen)) != CRYPT_OK) {
       goto LBL_ERR;
    }
    if ((err = hmac_done(hmac, out, outlen)) != CRYPT_OK) {
       goto LBL_ERR;
    }
   err = CRYPT_OK;
LBL_ERR:
#ifdef LTC_CLEAN_STACK
   zeromem(hmac, sizeof(hmac_state));
#endif
   XFREE(hmac);
   return err;   
}
#endif
