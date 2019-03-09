#include "tomcrypt.h"
#ifdef LTC_MECC
int ecc_sign_hash_raw(const unsigned char *in,  unsigned long inlen,
                            void *r, void *s,
                            prng_state *prng, int wprng, ecc_key *key)
{
   ecc_key       pubkey;
   void          *e, *p;
   int           err;
   LTC_ARGCHK(in  != NULL);
   LTC_ARGCHK(r   != NULL);
   LTC_ARGCHK(s   != NULL);
   LTC_ARGCHK(key != NULL);
   if (key->type != PK_PRIVATE) {
      return CRYPT_PK_NOT_PRIVATE;
   }
   if (ltc_ecc_is_valid_idx(key->idx) != 1) {
      return CRYPT_PK_INVALID_TYPE;
   }
   if ((err = prng_is_valid(wprng)) != CRYPT_OK) {
      return err;
   }
   if ((err = mp_init_multi(&p, &e, NULL)) != CRYPT_OK) {
      return err;
   }
   if ((err = mp_read_radix(p, (char *)key->dp->order, 16)) != CRYPT_OK)                      { goto errnokey; }
   if ((err = mp_read_unsigned_bin(e, (unsigned char *)in, (int)inlen)) != CRYPT_OK)          { goto errnokey; }
   for (;;) {
      if ((err = ecc_make_key_ex(prng, wprng, &pubkey, key->dp)) != CRYPT_OK) {
         goto errnokey;
      }
      if ((err = mp_mod(pubkey.pubkey.x, p, r)) != CRYPT_OK)                 { goto error; }
      if (mp_iszero(r) == LTC_MP_YES) {
         ecc_free(&pubkey);
      } else { 
        if ((err = mp_invmod(pubkey.k, p, pubkey.k)) != CRYPT_OK)            { goto error; } 
        if ((err = mp_mulmod(key->k, r, p, s)) != CRYPT_OK)                  { goto error; } 
        if ((err = mp_add(e, s, s)) != CRYPT_OK)                             { goto error; } 
        if ((err = mp_mod(s, p, s)) != CRYPT_OK)                             { goto error; } 
        if ((err = mp_mulmod(s, pubkey.k, p, s)) != CRYPT_OK)                { goto error; } 
        ecc_free(&pubkey);
        if (mp_iszero(s) == LTC_MP_NO) {
           break;
        }
      }
   }
   err = CRYPT_OK;
   goto errnokey;
error:
   ecc_free(&pubkey);
errnokey:
   mp_clear_multi(p, e, NULL);
   return err;
}
int ecc_sign_hash(const unsigned char *in,  unsigned long inlen,
                        unsigned char *out, unsigned long *outlen,
                        prng_state *prng, int wprng, ecc_key *key)
{
   void          *r, *s;
   int           err;
   LTC_ARGCHK(in     != NULL);
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   LTC_ARGCHK(key    != NULL);
   if (mp_init_multi(&r, &s, NULL) != CRYPT_OK) {
      return CRYPT_MEM;
   }
   if ((err = ecc_sign_hash_raw(in, inlen, r, s, prng, wprng, key)) != CRYPT_OK) {
      goto error;
   }
   err = der_encode_sequence_multi(out, outlen,
                             LTC_ASN1_INTEGER, 1UL, r,
                             LTC_ASN1_INTEGER, 1UL, s,
                             LTC_ASN1_EOL, 0UL, NULL);
error:
   mp_clear_multi(r, s, NULL);
   return err;   
}
#endif
