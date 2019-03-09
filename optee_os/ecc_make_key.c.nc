#include "tomcrypt.h"
#ifdef LTC_MECC
int ecc_make_key(prng_state *prng, int wprng, int keysize, ecc_key *key)
{
   int x, err;
   for (x = 0; (keysize > ltc_ecc_sets[x].size) && (ltc_ecc_sets[x].size != 0); x++);
   keysize = ltc_ecc_sets[x].size;
   if (keysize > ECC_MAXSIZE || ltc_ecc_sets[x].size == 0) {
      return CRYPT_INVALID_KEYSIZE;
   }
   err = ecc_make_key_ex(prng, wprng, key, &ltc_ecc_sets[x]);
   key->idx = x;
   return err;
}
int ecc_make_key_ex(prng_state *prng, int wprng, ecc_key *key, const ltc_ecc_set_type *dp)
{
   int            err;
   ecc_point     *base;
   void          *prime, *order;
   unsigned char *buf;
   int            keysize;
   LTC_ARGCHK(key         != NULL);
   LTC_ARGCHK(ltc_mp.name != NULL);
   LTC_ARGCHK(dp          != NULL);
   if ((err = prng_is_valid(wprng)) != CRYPT_OK) {
      return err;
   }
   key->idx = -1;
   key->dp  = dp;
   keysize  = dp->size;
   base = NULL;
   buf  = XMALLOC(ECC_MAXSIZE);
   if (buf == NULL) {
      return CRYPT_MEM;
   }
   if (prng_descriptor[wprng]->read(buf, (unsigned long)keysize, prng) != (unsigned long)keysize) {
      err = CRYPT_ERROR_READPRNG;
      goto ERR_BUF;
   }
   if ((err = mp_init_multi(&key->pubkey.x, &key->pubkey.y, &key->pubkey.z, &key->k, &prime, &order, NULL)) != CRYPT_OK) {
      goto ERR_BUF;
   }
   base = ltc_ecc_new_point();
   if (base == NULL) {
      err = CRYPT_MEM;
      goto errkey;
   }
   if ((err = mp_read_radix(prime,   (char *)key->dp->prime, 16)) != CRYPT_OK)                  { goto errkey; }
   if ((err = mp_read_radix(order,   (char *)key->dp->order, 16)) != CRYPT_OK)                  { goto errkey; }
   if ((err = mp_read_radix(base->x, (char *)key->dp->Gx, 16)) != CRYPT_OK)                     { goto errkey; }
   if ((err = mp_read_radix(base->y, (char *)key->dp->Gy, 16)) != CRYPT_OK)                     { goto errkey; }
   if ((err = mp_set(base->z, 1)) != CRYPT_OK)                                                  { goto errkey; }
   if ((err = mp_read_unsigned_bin(key->k, (unsigned char *)buf, keysize)) != CRYPT_OK)         { goto errkey; }
   if (mp_cmp(key->k, order) != LTC_MP_LT) {
       if((err = mp_mod(key->k, order, key->k)) != CRYPT_OK)                                    { goto errkey; }
   }
   if ((err = ltc_mp.ecc_ptmul(key->k, base, &key->pubkey, prime, 1)) != CRYPT_OK)              { goto errkey; }
   key->type = PK_PRIVATE;
   err = CRYPT_OK;
   goto cleanup;
errkey:
   mp_clear_multi(key->pubkey.x, key->pubkey.y, key->pubkey.z, key->k, NULL);
cleanup:
   ltc_ecc_del_point(base);
   mp_clear_multi(prime, order, NULL);
ERR_BUF:
#ifdef LTC_CLEAN_STACK
   zeromem(buf, ECC_MAXSIZE);
#endif
   XFREE(buf);
   return err;
}
#endif
