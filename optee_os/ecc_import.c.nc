#include "tomcrypt.h"
#ifdef LTC_MECC
static int is_point(ecc_key *key)
{
   void *prime, *b, *t1, *t2;
   int err;
   if ((err = mp_init_multi(&prime, &b, &t1, &t2, NULL)) != CRYPT_OK) {
      return err;
   }
   if ((err = mp_read_radix(prime, key->dp->prime, 16)) != CRYPT_OK)                          { goto error; }
   if ((err = mp_read_radix(b, key->dp->B, 16)) != CRYPT_OK)                                  { goto error; }
   if ((err = mp_sqr(key->pubkey.y, t1)) != CRYPT_OK)                                         { goto error; }
   if ((err = mp_sqr(key->pubkey.x, t2)) != CRYPT_OK)                                         { goto error; }
   if ((err = mp_mod(t2, prime, t2)) != CRYPT_OK)                                             { goto error; }
   if ((err = mp_mul(key->pubkey.x, t2, t2)) != CRYPT_OK)                                     { goto error; }
   if ((err = mp_sub(t1, t2, t1)) != CRYPT_OK)                                                { goto error; }
   if ((err = mp_add(t1, key->pubkey.x, t1)) != CRYPT_OK)                                     { goto error; }
   if ((err = mp_add(t1, key->pubkey.x, t1)) != CRYPT_OK)                                     { goto error; }
   if ((err = mp_add(t1, key->pubkey.x, t1)) != CRYPT_OK)                                     { goto error; }
   if ((err = mp_mod(t1, prime, t1)) != CRYPT_OK)                                             { goto error; }
   while (mp_cmp_d(t1, 0) == LTC_MP_LT) {
      if ((err = mp_add(t1, prime, t1)) != CRYPT_OK)                                          { goto error; }
   }
   while (mp_cmp(t1, prime) != LTC_MP_LT) {
      if ((err = mp_sub(t1, prime, t1)) != CRYPT_OK)                                          { goto error; }
   }
   if (mp_cmp(t1, b) != LTC_MP_EQ) {
      err = CRYPT_INVALID_PACKET;
   } else {
      err = CRYPT_OK;
   }
error:
   mp_clear_multi(prime, b, t1, t2, NULL);
   return err;
}
int ecc_import(const unsigned char *in, unsigned long inlen, ecc_key *key)
{
   return ecc_import_ex(in, inlen, key, NULL);
}
int ecc_import_ex(const unsigned char *in, unsigned long inlen, ecc_key *key, const ltc_ecc_set_type *dp)
{
   unsigned long key_size;
   unsigned char flags[1];
   int           err;
   LTC_ARGCHK(in  != NULL);
   LTC_ARGCHK(key != NULL);
   LTC_ARGCHK(ltc_mp.name != NULL);
   if (mp_init_multi(&key->pubkey.x, &key->pubkey.y, &key->pubkey.z, &key->k, NULL) != CRYPT_OK) {
      return CRYPT_MEM;
   }
   if ((err = der_decode_sequence_multi(in, inlen, 
                                  LTC_ASN1_BIT_STRING, 1UL, &flags,
                                  LTC_ASN1_EOL,        0UL, NULL)) != CRYPT_OK) {
      goto done;
   }
   if (flags[0] == 1) {
      key->type = PK_PRIVATE;
      if ((err = der_decode_sequence_multi(in, inlen,
                                     LTC_ASN1_BIT_STRING,      1UL, flags,
                                     LTC_ASN1_SHORT_INTEGER,   1UL, &key_size,
                                     LTC_ASN1_INTEGER,         1UL, key->pubkey.x,
                                     LTC_ASN1_INTEGER,         1UL, key->pubkey.y,
                                     LTC_ASN1_INTEGER,         1UL, key->k,
                                     LTC_ASN1_EOL,             0UL, NULL)) != CRYPT_OK) {
         goto done;
      }
   } else {
      key->type = PK_PUBLIC;
      if ((err = der_decode_sequence_multi(in, inlen,
                                     LTC_ASN1_BIT_STRING,      1UL, flags,
                                     LTC_ASN1_SHORT_INTEGER,   1UL, &key_size,
                                     LTC_ASN1_INTEGER,         1UL, key->pubkey.x,
                                     LTC_ASN1_INTEGER,         1UL, key->pubkey.y,
                                     LTC_ASN1_EOL,             0UL, NULL)) != CRYPT_OK) {
         goto done;
      }
   }
   if (dp == NULL) {
     for (key->idx = 0; ltc_ecc_sets[key->idx].size && (unsigned long)ltc_ecc_sets[key->idx].size != key_size; ++key->idx);
     if (ltc_ecc_sets[key->idx].size == 0) {
       err = CRYPT_INVALID_PACKET;
       goto done;
     }
     key->dp = &ltc_ecc_sets[key->idx];
   } else {
     key->idx = -1;
     key->dp = dp;
   }
   if ((err = mp_set(key->pubkey.z, 1)) != CRYPT_OK) { goto done; }
   if ((err = is_point(key)) != CRYPT_OK) {
      goto done;
   }
   return CRYPT_OK;
done:
   mp_clear_multi(key->pubkey.x, key->pubkey.y, key->pubkey.z, key->k, NULL);
   return err;
}
#endif
