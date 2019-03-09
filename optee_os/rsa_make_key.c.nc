#include "tomcrypt.h"
#ifdef LTC_MRSA
int rsa_make_key(prng_state *prng, int wprng, int size, long e, rsa_key *key)
{
   void *p, *q, *tmp1, *tmp2, *tmp3;
   int    err;
   LTC_ARGCHK(ltc_mp.name != NULL);
   LTC_ARGCHK(key         != NULL);
   if ((size < (MIN_RSA_SIZE/8)) || (size > (MAX_RSA_SIZE/8))) {
      return CRYPT_INVALID_KEYSIZE;
   }
   if ((e < 3) || ((e & 1) == 0)) {
      return CRYPT_INVALID_ARG;
   }
   if ((err = prng_is_valid(wprng)) != CRYPT_OK) {
      return err;
   }
   if ((err = mp_init_multi(&p, &q, &tmp1, &tmp2, &tmp3, NULL)) != CRYPT_OK) {
      return err;
   }
   if ((err = mp_set_int(tmp3, e)) != CRYPT_OK)                      { goto cleanup; }  
   do {
       if ((err = rand_prime( p, size/2, prng, wprng)) != CRYPT_OK)  { goto cleanup; }
       if ((err = mp_sub_d( p, 1,  tmp1)) != CRYPT_OK)               { goto cleanup; }  
       if ((err = mp_gcd( tmp1,  tmp3,  tmp2)) != CRYPT_OK)          { goto cleanup; }  
   } while (mp_cmp_d( tmp2, 1) != 0);                                                  
   do {
       if ((err = rand_prime( q, size/2, prng, wprng)) != CRYPT_OK)  { goto cleanup; }
       if ((err = mp_sub_d( q, 1,  tmp1)) != CRYPT_OK)               { goto cleanup; } 
       if ((err = mp_gcd( tmp1,  tmp3,  tmp2)) != CRYPT_OK)          { goto cleanup; } 
   } while (mp_cmp_d( tmp2, 1) != 0);                                                 
   if ((err = mp_sub_d( p, 1,  tmp2)) != CRYPT_OK)                   { goto cleanup; } 
   if ((err = mp_lcm( tmp1,  tmp2,  tmp1)) != CRYPT_OK)              { goto cleanup; } 
   if ((err = mp_init_multi(&key->e, &key->d, &key->N, &key->dQ, &key->dP, &key->qP, &key->p, &key->q, NULL)) != CRYPT_OK) {
      goto errkey;
   }
   if ((err = mp_set_int( key->e, e)) != CRYPT_OK)                     { goto errkey; } 
   if ((err = mp_invmod( key->e,  tmp1,  key->d)) != CRYPT_OK)         { goto errkey; } 
   if ((err = mp_mul( p,  q,  key->N)) != CRYPT_OK)                    { goto errkey; } 
   if ((err = mp_sub_d( p, 1,  tmp1)) != CRYPT_OK)                     { goto errkey; } 
   if ((err = mp_sub_d( q, 1,  tmp2)) != CRYPT_OK)                     { goto errkey; } 
   if ((err = mp_mod( key->d,  tmp1,  key->dP)) != CRYPT_OK)           { goto errkey; } 
   if ((err = mp_mod( key->d,  tmp2,  key->dQ)) != CRYPT_OK)           { goto errkey; } 
   if ((err = mp_invmod( q,  p,  key->qP)) != CRYPT_OK)                { goto errkey; } 
   if ((err = mp_copy( p,  key->p)) != CRYPT_OK)                       { goto errkey; }
   if ((err = mp_copy( q,  key->q)) != CRYPT_OK)                       { goto errkey; }
   key->type = PK_PRIVATE;
   err       = CRYPT_OK;
   goto cleanup;
errkey:
   mp_clear_multi(key->q, key->p, key->qP, key->dP, key->dQ, key->N, key->d, key->e, NULL);
cleanup:
   mp_clear_multi(tmp3, tmp2, tmp1, q, p, NULL);
   return err;
}
#endif
