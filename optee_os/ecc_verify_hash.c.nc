#include "tomcrypt.h"
#ifdef LTC_MECC
int ecc_verify_hash_raw(      void   *r, void   *s,
                        const unsigned char *hash, unsigned long hashlen,
                        int *stat, ecc_key *key)
{
   ecc_point    *mG, *mQ;
   void          *v, *w, *u1, *u2, *e, *p, *m;
   void          *mp = NULL;
   int           err;
   LTC_ARGCHK(r    != NULL);
   LTC_ARGCHK(s    != NULL);
   LTC_ARGCHK(hash != NULL);
   LTC_ARGCHK(stat != NULL);
   LTC_ARGCHK(key  != NULL);
   *stat = 0;
   mp    = NULL;
   if (ltc_ecc_is_valid_idx(key->idx) != 1) {
      return CRYPT_PK_INVALID_TYPE;
   }
   if ((err = mp_init_multi(&v, &w, &u1, &u2, &p, &e, &m, NULL)) != CRYPT_OK) {
      return CRYPT_MEM;
   }
   mG = ltc_ecc_new_point();
   mQ = ltc_ecc_new_point();
   if (mQ  == NULL || mG == NULL) {
      err = CRYPT_MEM;
      goto error;
   }
   if ((err = mp_read_radix(p, (char *)key->dp->order, 16)) != CRYPT_OK)                                { goto error; }
   if ((err = mp_read_radix(m, (char *)key->dp->prime, 16)) != CRYPT_OK)                                { goto error; }
   if (mp_iszero(r) || mp_iszero(s) || mp_cmp(r, p) != LTC_MP_LT || mp_cmp(s, p) != LTC_MP_LT) {
      err = CRYPT_INVALID_PACKET;
      goto error;
   }
   if ((err = mp_read_unsigned_bin(e, (unsigned char *)hash, (int)hashlen)) != CRYPT_OK)                { goto error; }
   if ((err = mp_invmod(s, p, w)) != CRYPT_OK)                                                          { goto error; }
   if ((err = mp_mulmod(e, w, p, u1)) != CRYPT_OK)                                                      { goto error; }
   if ((err = mp_mulmod(r, w, p, u2)) != CRYPT_OK)                                                      { goto error; }
   if ((err = mp_read_radix(mG->x, (char *)key->dp->Gx, 16)) != CRYPT_OK)                               { goto error; }
   if ((err = mp_read_radix(mG->y, (char *)key->dp->Gy, 16)) != CRYPT_OK)                               { goto error; }
   if ((err = mp_set(mG->z, 1)) != CRYPT_OK)                                                            { goto error; }
   if ((err = mp_copy(key->pubkey.x, mQ->x)) != CRYPT_OK)                                               { goto error; }
   if ((err = mp_copy(key->pubkey.y, mQ->y)) != CRYPT_OK)                                               { goto error; }
   if ((err = mp_copy(key->pubkey.z, mQ->z)) != CRYPT_OK)                                               { goto error; }
   if (ltc_mp.ecc_mul2add == NULL) {
      if ((err = ltc_mp.ecc_ptmul(u1, mG, mG, m, 0)) != CRYPT_OK)                                       { goto error; }
      if ((err = ltc_mp.ecc_ptmul(u2, mQ, mQ, m, 0)) != CRYPT_OK)                                       { goto error; }
      if ((err = mp_montgomery_setup(m, &mp)) != CRYPT_OK)                                              { goto error; }
      if ((err = ltc_mp.ecc_ptadd(mQ, mG, mG, m, mp)) != CRYPT_OK)                                      { goto error; }
      if ((err = ltc_mp.ecc_map(mG, m, mp)) != CRYPT_OK)                                                { goto error; }
   } else {
      if ((err = ltc_mp.ecc_mul2add(mG, u1, mQ, u2, mG, m)) != CRYPT_OK)                                { goto error; }
   }
   if ((err = mp_mod(mG->x, p, v)) != CRYPT_OK)                                                         { goto error; }
   if (mp_cmp(v, r) == LTC_MP_EQ) {
      *stat = 1;
   }
   err = CRYPT_OK;
error:
   ltc_ecc_del_point(mG);
   ltc_ecc_del_point(mQ);
   mp_clear_multi(v, w, u1, u2, p, e, m, NULL);
   if (mp != NULL) { 
      mp_montgomery_free(mp);
   }
   return err;
}
int ecc_verify_hash(const unsigned char *sig,  unsigned long siglen,
                    const unsigned char *hash, unsigned long hashlen,
                    int *stat, ecc_key *key)
{
   void          *r, *s;
   int           err;
   LTC_ARGCHK(sig  != NULL);
   LTC_ARGCHK(hash != NULL);
   LTC_ARGCHK(stat != NULL);
   LTC_ARGCHK(key  != NULL);
   if ((err = mp_init_multi(&r, &s, NULL)) != CRYPT_OK) {
      return CRYPT_MEM;
   }
   if ((err = der_decode_sequence_multi(sig, siglen,
                                  LTC_ASN1_INTEGER, 1UL, r,
                                  LTC_ASN1_INTEGER, 1UL, s,
                                  LTC_ASN1_EOL, 0UL, NULL)) != CRYPT_OK) {
      goto error;
   }
   err = ecc_verify_hash_raw(r, s, hash, hashlen, stat, key);
error:
   mp_clear_multi(r, s, NULL);
   return err;
}
#endif
