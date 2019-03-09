#include "tomcrypt.h"
#ifdef LTC_MDSA
int dsa_verify_hash_raw(         void   *r,          void   *s,
                    const unsigned char *hash, unsigned long hashlen, 
                                    int *stat,      dsa_key *key)
{
   void          *w, *v, *u1, *u2;
   int           err;
   LTC_ARGCHK(r    != NULL);
   LTC_ARGCHK(s    != NULL);
   LTC_ARGCHK(hash != NULL);
   LTC_ARGCHK(stat != NULL);
   LTC_ARGCHK(key  != NULL);
   *stat = 0;
   if ((err = mp_init_multi(&w, &v, &u1, &u2, NULL)) != CRYPT_OK) {
      return err;
   }
   if (mp_iszero(r) == LTC_MP_YES || mp_iszero(s) == LTC_MP_YES || mp_cmp(r, key->q) != LTC_MP_LT || mp_cmp(s, key->q) != LTC_MP_LT) {
      err = CRYPT_INVALID_PACKET;
      goto error;
   }
   if ((err = mp_invmod(s, key->q, w)) != CRYPT_OK)                                       { goto error; }
   if ((err = mp_read_unsigned_bin(u1, (unsigned char *)hash, hashlen)) != CRYPT_OK)      { goto error; }
   if ((err = mp_mulmod(u1, w, key->q, u1)) != CRYPT_OK)                                  { goto error; }
   if ((err = mp_mulmod(r, w, key->q, u2)) != CRYPT_OK)                                   { goto error; } 
   if ((err = mp_exptmod(key->g, u1, key->p, u1)) != CRYPT_OK)                            { goto error; }
   if ((err = mp_exptmod(key->y, u2, key->p, u2)) != CRYPT_OK)                            { goto error; }
   if ((err = mp_mulmod(u1, u2, key->p, v)) != CRYPT_OK)                                  { goto error; }
   if ((err = mp_mod(v, key->q, v)) != CRYPT_OK)                                          { goto error; }
   if (mp_cmp(r, v) == LTC_MP_EQ) {
      *stat = 1;
   }
   err = CRYPT_OK;
error:
   mp_clear_multi(w, v, u1, u2, NULL);
   return err;
}
int dsa_verify_hash(const unsigned char *sig, unsigned long siglen,
                    const unsigned char *hash, unsigned long hashlen, 
                    int *stat, dsa_key *key)
{
   int    err;
   void   *r, *s;
   if ((err = mp_init_multi(&r, &s, NULL)) != CRYPT_OK) {
      return CRYPT_MEM;
   }
   if ((err = der_decode_sequence_multi(sig, siglen,
                                  LTC_ASN1_INTEGER, 1UL, r, 
                                  LTC_ASN1_INTEGER, 1UL, s, 
                                  LTC_ASN1_EOL,     0UL, NULL)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   err = dsa_verify_hash_raw(r, s, hash, hashlen, stat, key);
LBL_ERR:
   mp_clear_multi(r, s, NULL);
   return err;
}
#endif
