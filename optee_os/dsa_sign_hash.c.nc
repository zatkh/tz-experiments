#include "tomcrypt.h"
#ifdef LTC_MDSA
int dsa_sign_hash_raw(const unsigned char *in,  unsigned long inlen,
                                   void   *r,   void *s,
                               prng_state *prng, int wprng, dsa_key *key)
{
   void         *k, *kinv, *tmp;
   unsigned char *buf;
   int            err, qbits;
   LTC_ARGCHK(in  != NULL);
   LTC_ARGCHK(r   != NULL);
   LTC_ARGCHK(s   != NULL);
   LTC_ARGCHK(key != NULL);
   if ((err = prng_is_valid(wprng)) != CRYPT_OK) {
      return err;
   }
   if (key->type != PK_PRIVATE) {
      return CRYPT_PK_NOT_PRIVATE;
   }
   if (key->qord >= LTC_MDSA_MAX_GROUP) {
      return CRYPT_INVALID_ARG;
   }
   buf = XMALLOC(LTC_MDSA_MAX_GROUP);
   if (buf == NULL) {
      return CRYPT_MEM;
   }
   if ((err = mp_init_multi(&k, &kinv, &tmp, NULL)) != CRYPT_OK)                       { goto ERRBUF; }
   qbits = mp_count_bits(key->q);
retry:
   do {
      if ((err = rand_bn_bits(k, qbits, prng, wprng)) != CRYPT_OK)                     { goto error; }
      if (mp_cmp_d(k, 0) != LTC_MP_GT || mp_cmp(k, key->q) != LTC_MP_LT)               { goto retry; }
      if ((err = mp_gcd(k, key->q, tmp)) != CRYPT_OK)                                  { goto error; }
   } while (mp_cmp_d(tmp, 1) != LTC_MP_EQ);
   if ((err = mp_invmod(k, key->q, kinv)) != CRYPT_OK)                                 { goto error; }
   if ((err = mp_exptmod(key->g, k, key->p, r)) != CRYPT_OK)                           { goto error; }
   if ((err = mp_mod(r, key->q, r)) != CRYPT_OK)                                       { goto error; }
   if (mp_iszero(r) == LTC_MP_YES)                                                     { goto retry; }
   if ((err = mp_read_unsigned_bin(tmp, (unsigned char *)in, inlen)) != CRYPT_OK)      { goto error; }
   if ((err = mp_mul(key->x, r, s)) != CRYPT_OK)                                       { goto error; }
   if ((err = mp_add(s, tmp, s)) != CRYPT_OK)                                          { goto error; }
   if ((err = mp_mulmod(s, kinv, key->q, s)) != CRYPT_OK)                              { goto error; }
   if (mp_iszero(s) == LTC_MP_YES)                                                     { goto retry; }
   err = CRYPT_OK;
error: 
   mp_clear_multi(k, kinv, tmp, NULL);
ERRBUF:
#ifdef LTC_CLEAN_STACK
   zeromem(buf, LTC_MDSA_MAX_GROUP);
#endif
   XFREE(buf);
   return err;
}
int dsa_sign_hash(const unsigned char *in,  unsigned long inlen,
                        unsigned char *out, unsigned long *outlen,
                        prng_state *prng, int wprng, dsa_key *key)
{
   void         *r, *s;
   int           err;
   LTC_ARGCHK(in      != NULL);
   LTC_ARGCHK(out     != NULL);
   LTC_ARGCHK(outlen  != NULL);
   LTC_ARGCHK(key     != NULL);
   if (mp_init_multi(&r, &s, NULL) != CRYPT_OK) {
      return CRYPT_MEM;
   }
   if ((err = dsa_sign_hash_raw(in, inlen, r, s, prng, wprng, key)) != CRYPT_OK) {
      goto error;
   }
   err = der_encode_sequence_multi(out, outlen, 
                             LTC_ASN1_INTEGER, 1UL, r, 
                             LTC_ASN1_INTEGER, 1UL, s, 
                             LTC_ASN1_EOL,     0UL, NULL);
error:
   mp_clear_multi(r, s, NULL);
   return err;
}
#endif
