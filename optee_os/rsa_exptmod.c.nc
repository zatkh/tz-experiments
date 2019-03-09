#include "tomcrypt.h"
#ifdef LTC_MRSA
int rsa_exptmod(const unsigned char *in,   unsigned long inlen,
                      unsigned char *out,  unsigned long *outlen, int which,
                      rsa_key *key)
{
   void         *tmp, *tmpa, *tmpb;
#ifdef LTC_RSA_BLINDING
   void        *rnd, *rndi ;
#endif
   unsigned long x;
   int           err, no_crt;
   LTC_ARGCHK(in     != NULL);
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   LTC_ARGCHK(key    != NULL);
   if (which == PK_PRIVATE && (key->type != PK_PRIVATE)) {
      return CRYPT_PK_NOT_PRIVATE;
   }
   if (which != PK_PRIVATE && which != PK_PUBLIC) {
      return CRYPT_PK_INVALID_TYPE;
   }
   if ((err = mp_init_multi(&tmp, &tmpa, &tmpb,
#ifdef LTC_RSA_BLINDING
                                               &rnd, &rndi,
#endif 
                                                           NULL)) != CRYPT_OK)
        { return err; }
   if ((err = mp_read_unsigned_bin(tmp, (unsigned char *)in, (int)inlen)) != CRYPT_OK)
        { goto error; }
   if (mp_cmp(key->N, tmp) == LTC_MP_LT) {
      err = CRYPT_PK_INVALID_SIZE;
      goto error;
   }
   if (which == PK_PRIVATE) {
#ifdef LTC_RSA_BLINDING
      err = mp_rand(rnd, mp_get_digit_count(key->N));
      if (err != CRYPT_OK) {
             goto error;
      }
      err = mp_invmod(rnd, key->N, rndi);
      if (err != CRYPT_OK) {
             goto error;
      }
      err = mp_exptmod( rnd, key->e, key->N, rnd);
      if (err != CRYPT_OK) {
             goto error;
      }
      err = mp_mulmod( tmp, rnd, key->N, tmp);
      if (err != CRYPT_OK) {
             goto error;
      }
#endif 
      no_crt = (key->dP == NULL) || (mp_get_digit_count(key->dP) == 0);
      if (no_crt) {
         if ((err = mp_exptmod(tmp, key->d, key->N, tmp)) != CRYPT_OK)                              { goto error; }
      } else {
         if ((err = mp_exptmod(tmp, key->dP, key->p, tmpa)) != CRYPT_OK)                            { goto error; }
         if ((err = mp_exptmod(tmp, key->dQ, key->q, tmpb)) != CRYPT_OK)                            { goto error; }
         if ((err = mp_sub(tmpa, tmpb, tmp)) != CRYPT_OK)                                           { goto error; }
         if ((err = mp_mulmod(tmp, key->qP, key->p, tmp)) != CRYPT_OK)                              { goto error; }
         if ((err = mp_mul(tmp, key->q, tmp)) != CRYPT_OK)                                          { goto error; }
         if ((err = mp_add(tmp, tmpb, tmp)) != CRYPT_OK)                                            { goto error; }
      }
      #ifdef LTC_RSA_BLINDING
      err = mp_mulmod( tmp, rndi, key->N, tmp);
      if (err != CRYPT_OK) {
             goto error;
      }
      #endif
      #ifdef LTC_RSA_CRT_HARDENING
      if (!no_crt) {
         if ((err = mp_exptmod(tmp, key->e, key->N, tmpa)) != CRYPT_OK)                              { goto error; }
         if ((err = mp_read_unsigned_bin(tmpb, (unsigned char *)in, (int)inlen)) != CRYPT_OK)        { goto error; }
         if (mp_cmp(tmpa, tmpb) != LTC_MP_EQ)                                     { err = CRYPT_ERROR; goto error; }
      }
      #endif
   } else {
      if ((err = mp_exptmod(tmp, key->e, key->N, tmp)) != CRYPT_OK)                                { goto error; }
   }
   x = (unsigned long)mp_unsigned_bin_size(key->N);
   if (x > *outlen) {
      *outlen = x;
      err = CRYPT_BUFFER_OVERFLOW;
      goto error;
   }
   if (mp_unsigned_bin_size(tmp) > mp_unsigned_bin_size(key->N)) {
      err = CRYPT_ERROR;
      goto error;
   }
   *outlen = x;
   zeromem(out, x);
   if ((err = mp_to_unsigned_bin(tmp, out+(x-mp_unsigned_bin_size(tmp)))) != CRYPT_OK)               { goto error; }
   err = CRYPT_OK;
error:
   mp_clear_multi(
#ifdef LTC_RSA_BLINDING
                  rndi, rnd,
#endif 
                             tmpb, tmpa, tmp, NULL);
   return err;
}
#endif
