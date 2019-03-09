#include "tomcrypt.h"
#ifdef LTC_FORTUNA
#if !(defined(LTC_RIJNDAEL) && defined(LTC_SHA256))
   #error LTC_FORTUNA requires LTC_SHA256 and LTC_RIJNDAEL (AES)
#endif
#ifndef LTC_FORTUNA_POOLS
   #warning LTC_FORTUNA_POOLS was not previously defined (old headers?)
   #define LTC_FORTUNA_POOLS 32
#endif
#if LTC_FORTUNA_POOLS < 4 || LTC_FORTUNA_POOLS > 32
   #error LTC_FORTUNA_POOLS must be in [4..32]
#endif
const struct ltc_prng_descriptor fortuna_desc = {
    "fortuna", 1024,
    &fortuna_start,
    &fortuna_add_entropy,
    &fortuna_ready,
    &fortuna_read,
    &fortuna_done,
    &fortuna_export,
    &fortuna_import,
    &fortuna_test
};
static void fortuna_update_iv(prng_state *prng)
{
   int            x;
   unsigned char *IV;
   IV = prng->fortuna.IV;
   for (x = 0; x < 16; x++) {
      IV[x] = (IV[x] + 1) & 255;
      if (IV[x] != 0) break;
   }
}
static int fortuna_reseed(prng_state *prng)
{
   unsigned char tmp[MAXBLOCKSIZE];
   hash_state    md;
   int           err, x;
   ++prng->fortuna.reset_cnt;
   sha256_init(&md);
   if ((err = sha256_process(&md, prng->fortuna.K, 32)) != CRYPT_OK) {
      sha256_done(&md, tmp);
      return err;
   }
   for (x = 0; x < LTC_FORTUNA_POOLS; x++) {
       if (x == 0 || ((prng->fortuna.reset_cnt >> (x-1)) & 1) == 0) {
          if ((err = sha256_done(&prng->fortuna.pool[x], tmp)) != CRYPT_OK) {
             sha256_done(&md, tmp);
             return err;
          }
          if ((err = sha256_process(&md, tmp, 32)) != CRYPT_OK) {
             sha256_done(&md, tmp);
             return err;
          }
          if ((err = sha256_init(&prng->fortuna.pool[x])) != CRYPT_OK) {
             sha256_done(&md, tmp);
             return err;
          }
       } else {
          break;
       }
   }
   if ((err = sha256_done(&md, prng->fortuna.K)) != CRYPT_OK) {
      return err;
   }
   if ((err = rijndael_setup(prng->fortuna.K, 32, 0, &prng->fortuna.skey)) != CRYPT_OK) {
      return err;
   }
   fortuna_update_iv(prng);
   prng->fortuna.pool0_len = 0;
   prng->fortuna.wd        = 0;
#ifdef LTC_CLEAN_STACK
   zeromem(&md, sizeof(md));
   zeromem(tmp, sizeof(tmp));
#endif
   return CRYPT_OK;
}
int fortuna_start(prng_state *prng)
{
   int err, x, y;
   unsigned char tmp[MAXBLOCKSIZE];
   LTC_ARGCHK(prng != NULL);
   for (x = 0; x < LTC_FORTUNA_POOLS; x++) {
       if ((err = sha256_init(&prng->fortuna.pool[x])) != CRYPT_OK) {
          for (y = 0; y < x; y++) {
              sha256_done(&prng->fortuna.pool[y], tmp);
          }
          return err;
       }
   }
   prng->fortuna.pool_idx = prng->fortuna.pool0_len = prng->fortuna.wd = 0;
   prng->fortuna.reset_cnt = 0;
   zeromem(prng->fortuna.K, 32);
   if ((err = rijndael_setup(prng->fortuna.K, 32, 0, &prng->fortuna.skey)) != CRYPT_OK) {
      for (x = 0; x < LTC_FORTUNA_POOLS; x++) {
          sha256_done(&prng->fortuna.pool[x], tmp);
      }
      return err;
   }
   zeromem(prng->fortuna.IV, 16);
   LTC_MUTEX_INIT(&prng->fortuna.prng_lock)
   return CRYPT_OK;
}
int fortuna_add_entropy(const unsigned char *in, unsigned long inlen, prng_state *prng)
{
   unsigned char tmp[2];
   int           err;
   LTC_ARGCHK(in  != NULL);
   LTC_ARGCHK(prng != NULL);
   LTC_MUTEX_LOCK(&prng->fortuna.prng_lock);
   if (inlen > 32) {
      LTC_MUTEX_UNLOCK(&prng->fortuna.prng_lock);
      return CRYPT_INVALID_ARG;
   }
   tmp[0] = 0;
   tmp[1] = (unsigned char)inlen;
   if ((err = sha256_process(&prng->fortuna.pool[prng->fortuna.pool_idx], tmp, 2)) != CRYPT_OK) {
      LTC_MUTEX_UNLOCK(&prng->fortuna.prng_lock);
      return err;
   }
   if ((err = sha256_process(&prng->fortuna.pool[prng->fortuna.pool_idx], in, inlen)) != CRYPT_OK) {
      LTC_MUTEX_UNLOCK(&prng->fortuna.prng_lock);
      return err;
   }
   if (prng->fortuna.pool_idx == 0) {
      prng->fortuna.pool0_len += inlen;
   }
   if (++(prng->fortuna.pool_idx) == LTC_FORTUNA_POOLS) {
      prng->fortuna.pool_idx = 0;
   }
   LTC_MUTEX_UNLOCK(&prng->fortuna.prng_lock);
   return CRYPT_OK;
}
int fortuna_ready(prng_state *prng)
{
   return fortuna_reseed(prng);
}
unsigned long fortuna_read(unsigned char *out, unsigned long outlen, prng_state *prng)
{
   unsigned char tmp[16];
   unsigned long tlen;
   LTC_ARGCHK(out  != NULL);
   LTC_ARGCHK(prng != NULL);
   LTC_MUTEX_LOCK(&prng->fortuna.prng_lock);
   if (++prng->fortuna.wd == LTC_FORTUNA_WD || prng->fortuna.pool0_len >= 64) {
      if (fortuna_reseed(prng) != CRYPT_OK) {
         LTC_MUTEX_UNLOCK(&prng->fortuna.prng_lock);
         return 0;
      }
   }
   tlen = outlen;
   while (outlen >= 16) {
      rijndael_ecb_encrypt(prng->fortuna.IV, out, &prng->fortuna.skey);
      out += 16;
      outlen -= 16;
      fortuna_update_iv(prng);
   }
   if (outlen > 0) {
      rijndael_ecb_encrypt(prng->fortuna.IV, tmp, &prng->fortuna.skey);
      XMEMCPY(out, tmp, outlen);
      fortuna_update_iv(prng);
   }
   rijndael_ecb_encrypt(prng->fortuna.IV, prng->fortuna.K   , &prng->fortuna.skey);
   fortuna_update_iv(prng);
   rijndael_ecb_encrypt(prng->fortuna.IV, prng->fortuna.K+16, &prng->fortuna.skey);
   fortuna_update_iv(prng);
   if (rijndael_setup(prng->fortuna.K, 32, 0, &prng->fortuna.skey) != CRYPT_OK) {
      LTC_MUTEX_UNLOCK(&prng->fortuna.prng_lock);
      return 0;
   }
#ifdef LTC_CLEAN_STACK
   zeromem(tmp, sizeof(tmp));
#endif
   LTC_MUTEX_UNLOCK(&prng->fortuna.prng_lock);
   return tlen;
}
int fortuna_done(prng_state *prng)
{
   int           err, x;
   unsigned char tmp[32];
   LTC_ARGCHK(prng != NULL);
   LTC_MUTEX_LOCK(&prng->fortuna.prng_lock);
   for (x = 0; x < LTC_FORTUNA_POOLS; x++) {
       if ((err = sha256_done(&(prng->fortuna.pool[x]), tmp)) != CRYPT_OK) {
          LTC_MUTEX_UNLOCK(&prng->fortuna.prng_lock);
          return err;
       }
   }
#ifdef LTC_CLEAN_STACK
   zeromem(tmp, sizeof(tmp));
#endif
   LTC_MUTEX_UNLOCK(&prng->fortuna.prng_lock);
   return CRYPT_OK;
}
int fortuna_export(unsigned char *out, unsigned long *outlen, prng_state *prng)
{
   int         x, err;
   hash_state *md;
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   LTC_ARGCHK(prng   != NULL);
   LTC_MUTEX_LOCK(&prng->fortuna.prng_lock);
   if (*outlen < 32*LTC_FORTUNA_POOLS) {
      LTC_MUTEX_UNLOCK(&prng->fortuna.prng_lock);
      *outlen = 32*LTC_FORTUNA_POOLS;
      return CRYPT_BUFFER_OVERFLOW;
   }
   md = XMALLOC(sizeof(hash_state));
   if (md == NULL) {
      LTC_MUTEX_UNLOCK(&prng->fortuna.prng_lock);
      return CRYPT_MEM;
   }
   for (x = 0; x < LTC_FORTUNA_POOLS; x++) {
      XMEMCPY(md, &(prng->fortuna.pool[x]), sizeof(*md));
      if ((err = sha256_done(md, out+x*32)) != CRYPT_OK) {
         goto LBL_ERR;
      }
      if ((err = sha256_init(md)) != CRYPT_OK) {
         goto LBL_ERR;
      }
      if ((err = sha256_process(md, out+x*32, 32)) != CRYPT_OK) {
         goto LBL_ERR;
      }
      if ((err = sha256_done(md, out+x*32)) != CRYPT_OK) {
         goto LBL_ERR;
      }
   }
   *outlen = 32*LTC_FORTUNA_POOLS;
   err = CRYPT_OK;
LBL_ERR:
#ifdef LTC_CLEAN_STACK
   zeromem(md, sizeof(*md));
#endif
   XFREE(md);
   LTC_MUTEX_UNLOCK(&prng->fortuna.prng_lock);
   return err;
}
int fortuna_import(const unsigned char *in, unsigned long inlen, prng_state *prng)
{
   int err, x;
   LTC_ARGCHK(in   != NULL);
   LTC_ARGCHK(prng != NULL);
   if (inlen != 32*LTC_FORTUNA_POOLS) {
      return CRYPT_INVALID_ARG;
   }
   if ((err = fortuna_start(prng)) != CRYPT_OK) {
      return err;
   }
   for (x = 0; x < LTC_FORTUNA_POOLS; x++) {
      if ((err = fortuna_add_entropy(in+x*32, 32, prng)) != CRYPT_OK) {
         return err;
      }
   }
   return err;
}
int fortuna_test(void)
{
#ifndef LTC_TEST
   return CRYPT_NOP;
#else
   int err;
   if ((err = sha256_test()) != CRYPT_OK) {
      return err;
   }
   return rijndael_test();
#endif
}
#endif
