#include "tomcrypt.h"
#ifdef LTC_MRSA
void rsa_free(rsa_key *key)
{
   LTC_ARGCHKVD(key != NULL);
   mp_clear_multi(key->e, key->d, key->N, key->dQ, key->dP, key->qP, key->p, key->q, NULL);
}
#endif
