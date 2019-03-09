#include "tomcrypt.h"
#ifdef LTC_MECC
int ltc_ecc_map(ecc_point *P, void *modulus, void *mp)
{
   void *t1, *t2;
   int   err;
   LTC_ARGCHK(P       != NULL);
   LTC_ARGCHK(modulus != NULL);
   LTC_ARGCHK(mp      != NULL);
   if ((err = mp_init_multi(&t1, &t2, NULL)) != CRYPT_OK) {
      return CRYPT_MEM;
   }
   if ((err = mp_montgomery_reduce(P->z, modulus, mp)) != CRYPT_OK)           { goto done; }
   if ((err = mp_invmod(P->z, modulus, t1)) != CRYPT_OK)                      { goto done; }
   if ((err = mp_sqr(t1, t2)) != CRYPT_OK)                                    { goto done; }
   if ((err = mp_mod(t2, modulus, t2)) != CRYPT_OK)                           { goto done; }
   if ((err = mp_mul(t1, t2, t1)) != CRYPT_OK)                                { goto done; }
   if ((err = mp_mod(t1, modulus, t1)) != CRYPT_OK)                           { goto done; }
   if ((err = mp_mul(P->x, t2, P->x)) != CRYPT_OK)                            { goto done; }
   if ((err = mp_montgomery_reduce(P->x, modulus, mp)) != CRYPT_OK)           { goto done; }
   if ((err = mp_mul(P->y, t1, P->y)) != CRYPT_OK)                            { goto done; }
   if ((err = mp_montgomery_reduce(P->y, modulus, mp)) != CRYPT_OK)           { goto done; }
   if ((err = mp_set(P->z, 1)) != CRYPT_OK)                                   { goto done; }
   err = CRYPT_OK;
done:
   mp_clear_multi(t1, t2, NULL);
   return err;
}
#endif
