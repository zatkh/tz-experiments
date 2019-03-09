#include "tomcrypt.h"
#ifdef LTC_MECC
#ifndef LTC_ECC_TIMING_RESISTANT
#define WINSIZE 4
#define WINVARS (1 << (WINSIZE - 1))
int ltc_ecc_mulmod(void *k, ecc_point *G, ecc_point *R, void *modulus, int map)
{
   ecc_point *tG, *M[WINVARS];
   int        i, j, err;
   void       *mu, *mp;
   ltc_mp_digit buf;
   int        first, bitbuf, bitcpy, bitcnt, mode, digidx;
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
      mp_montgomery_free(mp);
      mp_clear(mu);
      return err;
   }
  for (i = 0; i < WINVARS; i++) {
      M[i] = ltc_ecc_new_point();
      if (M[i] == NULL) {
         for (j = 0; j < i; j++) {
             ltc_ecc_del_point(M[j]);
         }
         mp_montgomery_free(mp);
         mp_clear(mu);
         return CRYPT_MEM;
      }
  }
   tG = ltc_ecc_new_point();
   if (tG == NULL)                                                                   { err = CRYPT_MEM; goto done; }
   if (mp_cmp_d(mu, 1) == LTC_MP_EQ) {
      if ((err = mp_copy(G->x, tG->x)) != CRYPT_OK)                                  { goto done; }
      if ((err = mp_copy(G->y, tG->y)) != CRYPT_OK)                                  { goto done; }
      if ((err = mp_copy(G->z, tG->z)) != CRYPT_OK)                                  { goto done; }
   } else {
      if ((err = mp_mulmod(G->x, mu, modulus, tG->x)) != CRYPT_OK)                   { goto done; }
      if ((err = mp_mulmod(G->y, mu, modulus, tG->y)) != CRYPT_OK)                   { goto done; }
      if ((err = mp_mulmod(G->z, mu, modulus, tG->z)) != CRYPT_OK)                   { goto done; }
   }
   mp_clear(mu);
   mu = NULL;
   if ((err = ltc_mp.ecc_ptdbl(tG, M[0], modulus, mp)) != CRYPT_OK)                 { goto done; }
   for (j = 1; j < (WINSIZE-1); ++j) {
       if ((err = ltc_mp.ecc_ptdbl(M[0], M[0], modulus, mp)) != CRYPT_OK)               { goto done; }
   }
   for (j = (WINVARS + 1); j < (2*WINVARS); j++) {
       if ((err = ltc_mp.ecc_ptadd(M[j-(WINVARS + 1)], tG, M[j-WINVARS], modulus, mp)) != CRYPT_OK)   { goto done; }
   }
   mode   = 0;
   bitcnt = 1;
   buf    = 0;
   digidx = mp_get_digit_count(k) - 1;
   bitcpy = bitbuf = 0;
   first  = 1;
   for (;;) {
     if (--bitcnt == 0) {
       if (digidx == -1) {
          break;
       }
       buf    = mp_get_digit(k, digidx);
       bitcnt = (int) ltc_mp.bits_per_digit;
       --digidx;
     }
     i = (buf >> (ltc_mp.bits_per_digit - 1)) & 1;
     buf <<= 1;
     if (mode == 0 && i == 0) {
        continue;
     }
     if (mode == 1 && i == 0) {
        if ((err = ltc_mp.ecc_ptdbl(R, R, modulus, mp)) != CRYPT_OK)                 { goto done; }
        continue;
     }
     bitbuf |= (i << (WINSIZE - ++bitcpy));
     mode = 2;
     if (bitcpy == WINSIZE) {
       if (first == 1) {
          if ((err = mp_copy(M[bitbuf-WINVARS]->x, R->x)) != CRYPT_OK)                     { goto done; }
          if ((err = mp_copy(M[bitbuf-WINVARS]->y, R->y)) != CRYPT_OK)                     { goto done; }
          if ((err = mp_copy(M[bitbuf-WINVARS]->z, R->z)) != CRYPT_OK)                     { goto done; }
          first = 0;
       } else {
         for (j = 0; j < WINSIZE; j++) {
           if ((err = ltc_mp.ecc_ptdbl(R, R, modulus, mp)) != CRYPT_OK)              { goto done; }
         }
         if ((err = ltc_mp.ecc_ptadd(R, M[bitbuf-WINVARS], R, modulus, mp)) != CRYPT_OK)   { goto done; }
       }
       bitcpy = bitbuf = 0;
       mode = 1;
    }
  }
   if (mode == 2 && bitcpy > 0) {
     for (j = 0; j < bitcpy; j++) {
       if (first == 0) {
          if ((err = ltc_mp.ecc_ptdbl(R, R, modulus, mp)) != CRYPT_OK)              { goto done; }
       }
       bitbuf <<= 1;
       if ((bitbuf & (1 << WINSIZE)) != 0) {
         if (first == 1){
            if ((err = mp_copy(tG->x, R->x)) != CRYPT_OK)                           { goto done; }
            if ((err = mp_copy(tG->y, R->y)) != CRYPT_OK)                           { goto done; }
            if ((err = mp_copy(tG->z, R->z)) != CRYPT_OK)                           { goto done; }
            first = 0;
         } else {
            if ((err = ltc_mp.ecc_ptadd(R, tG, R, modulus, mp)) != CRYPT_OK)        { goto done; }
         }
       }
     }
   }
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
   for (i = 0; i < WINVARS; i++) {
       ltc_ecc_del_point(M[i]);
   }
   return err;
}
#endif
#undef WINSIZE
#endif
