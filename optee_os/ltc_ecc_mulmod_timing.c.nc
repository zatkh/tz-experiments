#include "tomcrypt.h"
#ifdef LTC_MECC
#ifdef LTC_ECC_TIMING_RESISTANT
int ltc_ecc_mulmod(void *k, ecc_point *G, ecc_point *R, void *modulus, int map)
{
   ecc_point *tG, *M[3];
   int        i, j, err;
   void       *mu, *mp;
   ltc_mp_digit buf;
   int        bitcnt, mode, digidx;
   LTC_ARGCHK(k       != NULL);
   LTC_ARGCHK(G       != NULL);
   LTC_ARGCHK(R       != NULL);
   LTC_ARGCHK(modulus != NULL);
   if ((err = mp_montgomery_setup(modulus, &mp)) != CRYPT_OK) {
      return err;
   }
   if ((err = mp_init(&mu)) != CRYPT_OK) {
      mp_montgomery_free(mp);
      return err;
   }
   if ((err = mp_montgomery_normalization(mu, modulus)) != CRYPT_OK) {
      mp_clear(mu);
      mp_montgomery_free(mp);
      return err;
   }
  for (i = 0; i < 3; i++) {
      M[i] = ltc_ecc_new_point();
      if (M[i] == NULL) {
         for (j = 0; j < i; j++) {
             ltc_ecc_del_point(M[j]);
         }
         mp_clear(mu);
         mp_montgomery_free(mp);
         return CRYPT_MEM;
      }
  }
   tG = ltc_ecc_new_point();
   if (tG == NULL)                                                                   { err = CRYPT_MEM; goto done; }
   if ((err = mp_mulmod(G->x, mu, modulus, tG->x)) != CRYPT_OK)                      { goto done; }
   if ((err = mp_mulmod(G->y, mu, modulus, tG->y)) != CRYPT_OK)                      { goto done; }
   if ((err = mp_mulmod(G->z, mu, modulus, tG->z)) != CRYPT_OK)                      { goto done; }
   mp_clear(mu);
   mu = NULL;
   if ((err = mp_copy(tG->x, M[0]->x)) != CRYPT_OK)                                  { goto done; }
   if ((err = mp_copy(tG->y, M[0]->y)) != CRYPT_OK)                                  { goto done; }
   if ((err = mp_copy(tG->z, M[0]->z)) != CRYPT_OK)                                  { goto done; }
   if ((err = ltc_mp.ecc_ptdbl(tG, M[1], modulus, mp)) != CRYPT_OK)                  { goto done; }
   mode   = 0;
   bitcnt = 1;
   buf    = 0;
   digidx = mp_get_digit_count(k) - 1;
   for (;;) {
      if (--bitcnt == 0) {
         if (digidx == -1) {
            break;
         }
         buf    = mp_get_digit(k, digidx);
         bitcnt = (int) MP_DIGIT_BIT;
         --digidx;
      }
      i = (buf >> (MP_DIGIT_BIT - 1)) & 1;
      buf <<= 1;
      if (mode == 0 && i == 0) {
         if ((err = ltc_mp.ecc_ptadd(M[0], M[1], M[2], modulus, mp)) != CRYPT_OK)    { goto done; }
         if ((err = ltc_mp.ecc_ptdbl(M[1], M[2], modulus, mp)) != CRYPT_OK)          { goto done; }
         continue;
      }
      if (mode == 0 && i == 1) {
         mode = 1;
         if ((err = ltc_mp.ecc_ptadd(M[0], M[1], M[2], modulus, mp)) != CRYPT_OK)    { goto done; }
         if ((err = ltc_mp.ecc_ptdbl(M[1], M[2], modulus, mp)) != CRYPT_OK)          { goto done; }
         continue;
      }
      if ((err = ltc_mp.ecc_ptadd(M[0], M[1], M[i^1], modulus, mp)) != CRYPT_OK)     { goto done; }
      if ((err = ltc_mp.ecc_ptdbl(M[i], M[i], modulus, mp)) != CRYPT_OK)             { goto done; }
   }
   if ((err = mp_copy(M[0]->x, R->x)) != CRYPT_OK)                                   { goto done; }
   if ((err = mp_copy(M[0]->y, R->y)) != CRYPT_OK)                                   { goto done; }
   if ((err = mp_copy(M[0]->z, R->z)) != CRYPT_OK)                                   { goto done; }
   if (map) {
      err = ltc_ecc_map(R, modulus, mp);
   } else {
      err = CRYPT_OK;
   }
done:
   if (mu != NULL) {
      mp_clear(mu);
   }
   mp_montgomery_free(mp);
   ltc_ecc_del_point(tG);
   for (i = 0; i < 3; i++) {
       ltc_ecc_del_point(M[i]);
   }
   return err;
}
#endif
#endif
