#include "tomcrypt.h"
#ifdef LTC_MECC
#ifdef LTC_ECC_SHAMIR
int ltc_ecc_mul2add(ecc_point *A, void *kA,
                    ecc_point *B, void *kB,
                    ecc_point *C,
                         void *modulus)
{
  ecc_point     *precomp[16];
  unsigned       bitbufA, bitbufB, lenA, lenB, len, x, y, nA, nB, nibble;
  unsigned char *tA, *tB;
  int            err, first;
  void          *mp, *mu;
  LTC_ARGCHK(A       != NULL);
  LTC_ARGCHK(B       != NULL);
  LTC_ARGCHK(C       != NULL);
  LTC_ARGCHK(kA      != NULL);
  LTC_ARGCHK(kB      != NULL);
  LTC_ARGCHK(modulus != NULL);
  tA = XCALLOC(1, ECC_BUF_SIZE);
  if (tA == NULL) {
     return CRYPT_MEM;
  }
  tB = XCALLOC(1, ECC_BUF_SIZE);
  if (tB == NULL) {
     XFREE(tA);
     return CRYPT_MEM;
  }
  lenA = mp_unsigned_bin_size(kA);
  lenB = mp_unsigned_bin_size(kB);
  len  = MAX(lenA, lenB);
  if ((lenA > ECC_BUF_SIZE) || (lenB > ECC_BUF_SIZE)) {
     err = CRYPT_INVALID_ARG;
     goto ERR_T;
  }
  mp_to_unsigned_bin(kA, (len - lenA) + tA);
  mp_to_unsigned_bin(kB, (len - lenB) + tB);
  for (x = 0; x < 16; x++) {
     precomp[x] = ltc_ecc_new_point();
     if (precomp[x] == NULL) {
         for (y = 0; y < x; ++y) {
            ltc_ecc_del_point(precomp[y]);
         }
         err = CRYPT_MEM;
         goto ERR_T;
     }
  }
   if ((err = mp_montgomery_setup(modulus, &mp)) != CRYPT_OK) {
      goto ERR_P;
   }
   if ((err = mp_init(&mu)) != CRYPT_OK) {
      goto ERR_MP;
   }
   if ((err = mp_montgomery_normalization(mu, modulus)) != CRYPT_OK) {
      goto ERR_MU;
   }
  if ((err = mp_mulmod(A->x, mu, modulus, precomp[1]->x)) != CRYPT_OK)                                         { goto ERR_MU; }
  if ((err = mp_mulmod(A->y, mu, modulus, precomp[1]->y)) != CRYPT_OK)                                         { goto ERR_MU; }
  if ((err = mp_mulmod(A->z, mu, modulus, precomp[1]->z)) != CRYPT_OK)                                         { goto ERR_MU; }
  if ((err = mp_mulmod(B->x, mu, modulus, precomp[1<<2]->x)) != CRYPT_OK)                                      { goto ERR_MU; }
  if ((err = mp_mulmod(B->y, mu, modulus, precomp[1<<2]->y)) != CRYPT_OK)                                      { goto ERR_MU; }
  if ((err = mp_mulmod(B->z, mu, modulus, precomp[1<<2]->z)) != CRYPT_OK)                                      { goto ERR_MU; }
  if ((err = ltc_mp.ecc_ptdbl(precomp[1], precomp[2], modulus, mp)) != CRYPT_OK)                               { goto ERR_MU; }
  if ((err = ltc_mp.ecc_ptadd(precomp[1], precomp[2], precomp[3], modulus, mp)) != CRYPT_OK)                   { goto ERR_MU; }
  if ((err = ltc_mp.ecc_ptdbl(precomp[1<<2], precomp[2<<2], modulus, mp)) != CRYPT_OK)                         { goto ERR_MU; }
  if ((err = ltc_mp.ecc_ptadd(precomp[1<<2], precomp[2<<2], precomp[3<<2], modulus, mp)) != CRYPT_OK)          { goto ERR_MU; }
  for (x = 1; x < 4; x++) {
     for (y = 1; y < 4; y++) {
        if ((err = ltc_mp.ecc_ptadd(precomp[x], precomp[(y<<2)], precomp[x+(y<<2)], modulus, mp)) != CRYPT_OK) { goto ERR_MU; }
     }
  }   
  nibble  = 3;
  first   = 1;
  bitbufA = tA[0];
  bitbufB = tB[0];
  for (x = -1;; ) {
     if (++nibble == 4) {
        ++x; if (x == len) break;
        bitbufA = tA[x];
        bitbufB = tB[x];
        nibble  = 0;
     }
     nA = (bitbufA >> 6) & 0x03;
     nB = (bitbufB >> 6) & 0x03;
     bitbufA = (bitbufA << 2) & 0xFF;   
     bitbufB = (bitbufB << 2) & 0xFF;   
     if ((nA == 0) && (nB == 0) && (first == 1)) {
        continue;
     }
     if (first == 0) {
        if ((err = ltc_mp.ecc_ptdbl(C, C, modulus, mp)) != CRYPT_OK)                  { goto ERR_MU; }
        if ((err = ltc_mp.ecc_ptdbl(C, C, modulus, mp)) != CRYPT_OK)                  { goto ERR_MU; }
     }
     if ((nA != 0) || (nB != 0)) {
        if (first == 1) {
           first = 0;
           if ((err = mp_copy(precomp[nA + (nB<<2)]->x, C->x)) != CRYPT_OK)           { goto ERR_MU; }
           if ((err = mp_copy(precomp[nA + (nB<<2)]->y, C->y)) != CRYPT_OK)           { goto ERR_MU; }
           if ((err = mp_copy(precomp[nA + (nB<<2)]->z, C->z)) != CRYPT_OK)           { goto ERR_MU; }
        } else {
           if ((err = ltc_mp.ecc_ptadd(C, precomp[nA + (nB<<2)], C, modulus, mp)) != CRYPT_OK) { goto ERR_MU; }
        }
     }
  }
  err = ltc_ecc_map(C, modulus, mp);
ERR_MU:
   mp_clear(mu);
ERR_MP:
   mp_montgomery_free(mp);
ERR_P:
   for (x = 0; x < 16; x++) {
       ltc_ecc_del_point(precomp[x]);
   }
ERR_T:
#ifdef LTC_CLEAN_STACK
   zeromem(tA, ECC_BUF_SIZE);
   zeromem(tB, ECC_BUF_SIZE);
#endif
   XFREE(tA);
   XFREE(tB);
   return err;
}
#endif
#endif
