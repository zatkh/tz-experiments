#include "tomcrypt.h"
#ifdef LTC_MDSA
int dsa_verify_key(dsa_key *key, int *stat)
{
   void   *tmp, *tmp2;
   int    res, err;
   LTC_ARGCHK(key  != NULL);
   LTC_ARGCHK(stat != NULL);
   *stat = 0;
   if ((err = mp_prime_is_prime(key->q, 8, &res)) != CRYPT_OK) {
      return err;
   }
   if (res == 0) {
      return CRYPT_OK;
   }
   if ((err = mp_prime_is_prime(key->p, 8, &res)) != CRYPT_OK) {
      return err;
   }
   if (res == 0) {
      return CRYPT_OK;
   }
   if (mp_cmp_d(key->g, 0) == LTC_MP_EQ || mp_cmp_d(key->g, 1) == LTC_MP_EQ) {
      return CRYPT_OK;
   }
   if ((err = mp_init_multi(&tmp, &tmp2, NULL)) != CRYPT_OK)               { return err; }
   if ((err = mp_sub_d(key->p, 1, tmp)) != CRYPT_OK)                       { goto error; }
   if (mp_cmp(tmp, key->g) == LTC_MP_EQ || mp_cmp(key->g, key->p) != LTC_MP_LT) {
      err = CRYPT_OK;
      goto error;
   }
   if (!(mp_cmp_d(key->y, 1) == LTC_MP_GT && mp_cmp(key->y, tmp) == LTC_MP_LT)) {
      err = CRYPT_OK;
      goto error;
   }
   if ((err = mp_div(tmp, key->q, tmp, tmp2)) != CRYPT_OK)             { goto error; }
   if (mp_iszero(tmp2) != LTC_MP_YES) {
      err = CRYPT_OK;
      goto error;
   }
   if ((err = mp_exptmod(key->g, key->q, key->p, tmp)) != CRYPT_OK)    { goto error; }
   if (mp_cmp_d(tmp, 1) != LTC_MP_EQ) {
      err = CRYPT_OK;
      goto error;
   }
   if ((err = mp_exptmod(key->y, key->q, key->p, tmp)) != CRYPT_OK)       { goto error; }
   if (mp_cmp_d(tmp, 1) != LTC_MP_EQ) {
      err = CRYPT_OK;
      goto error;
   }
   err   = CRYPT_OK;
   *stat = 1;
error: 
   mp_clear_multi(tmp, tmp2, NULL);
   return err;
}
#endif
