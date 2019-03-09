#include "tomcrypt.h"
#ifdef LTC_HMAC
int hmac_process(hmac_state *hmac, const unsigned char *in, unsigned long inlen)
{
    int err;
    LTC_ARGCHK(hmac != NULL);
    LTC_ARGCHK(in != NULL);
    if ((err = hash_is_valid(hmac->hash)) != CRYPT_OK) {
        return err;
    }
    return hash_descriptor[hmac->hash]->process(&hmac->md, in, inlen);
}
#endif
