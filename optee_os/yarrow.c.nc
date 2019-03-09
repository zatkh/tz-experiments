#include "tomcrypt.h"
#ifdef LTC_YARROW
const struct ltc_prng_descriptor yarrow_desc =
{
    "yarrow", 64,
    &yarrow_start,
    &yarrow_add_entropy,
    &yarrow_ready,
    &yarrow_read,
    &yarrow_done,
    &yarrow_export,
    &yarrow_import,
    &yarrow_test
};
int yarrow_start(prng_state *prng)
{
   int err;
   LTC_ARGCHK(prng != NULL);
#ifdef LTC_RIJNDAEL
#if    LTC_YARROW_AES==0
   prng->yarrow.cipher = register_cipher(&rijndael_enc_desc);
#elif  LTC_YARROW_AES==1
   prng->yarrow.cipher = register_cipher(&aes_enc_desc);
#elif  LTC_YARROW_AES==2
   prng->yarrow.cipher = register_cipher(&rijndael_desc);
#elif  LTC_YARROW_AES==3
   prng->yarrow.cipher = register_cipher(&aes_desc);
#endif
#elif defined(LTC_BLOWFISH)
   prng->yarrow.cipher = register_cipher(&blowfish_desc);
#elif defined(LTC_TWOFISH)
   prng->yarrow.cipher = register_cipher(&twofish_desc);
#elif defined(LTC_RC6)
   prng->yarrow.cipher = register_cipher(&rc6_desc);
#elif defined(LTC_RC5)
   prng->yarrow.cipher = register_cipher(&rc5_desc);
#elif defined(LTC_SAFERP)
   prng->yarrow.cipher = register_cipher(&saferp_desc);
#elif defined(LTC_RC2)
   prng->yarrow.cipher = register_cipher(&rc2_desc);
#elif defined(LTC_NOEKEON)   
   prng->yarrow.cipher = register_cipher(&noekeon_desc);
#elif defined(LTC_ANUBIS)   
   prng->yarrow.cipher = register_cipher(&anubis_desc);
#elif defined(LTC_KSEED)   
   prng->yarrow.cipher = register_cipher(&kseed_desc);
#elif defined(LTC_KHAZAD)   
   prng->yarrow.cipher = register_cipher(&khazad_desc);
#elif defined(LTC_CAST5)
   prng->yarrow.cipher = register_cipher(&cast5_desc);
#elif defined(LTC_XTEA)
   prng->yarrow.cipher = register_cipher(&xtea_desc);
#elif defined(LTC_SAFER)
   prng->yarrow.cipher = register_cipher(&safer_sk128_desc);
#elif defined(LTC_DES)
   prng->yarrow.cipher = register_cipher(&des3_desc);
#else
   #error LTC_YARROW needs at least one CIPHER
#endif
   if ((err = cipher_is_valid(prng->yarrow.cipher)) != CRYPT_OK) {
      return err;
   }
#ifdef LTC_SHA256
   prng->yarrow.hash   = register_hash(&sha256_desc);
#elif defined(LTC_SHA512)
   prng->yarrow.hash   = register_hash(&sha512_desc);
#elif defined(LTC_TIGER)
   prng->yarrow.hash   = register_hash(&tiger_desc);
#elif defined(LTC_SHA1)
   prng->yarrow.hash   = register_hash(&sha1_desc);
#elif defined(LTC_RIPEMD320)
   prng->yarrow.hash   = register_hash(&rmd320_desc);
#elif defined(LTC_RIPEMD256)
   prng->yarrow.hash   = register_hash(&rmd256_desc);
#elif defined(LTC_RIPEMD160)
   prng->yarrow.hash   = register_hash(&rmd160_desc);
#elif defined(LTC_RIPEMD128)
   prng->yarrow.hash   = register_hash(&rmd128_desc);
#elif defined(LTC_MD5)
   prng->yarrow.hash   = register_hash(&md5_desc);
#elif defined(LTC_MD4)
   prng->yarrow.hash   = register_hash(&md4_desc);
#elif defined(LTC_MD2)
   prng->yarrow.hash   = register_hash(&md2_desc);
#elif defined(LTC_WHIRLPOOL)
   prng->yarrow.hash   = register_hash(&whirlpool_desc);
#else
   #error LTC_YARROW needs at least one HASH
#endif
   if ((err = hash_is_valid(prng->yarrow.hash)) != CRYPT_OK) {
      return err;
   }
   zeromem(prng->yarrow.pool, sizeof(prng->yarrow.pool));
   LTC_MUTEX_INIT(&prng->yarrow.prng_lock)
   return CRYPT_OK;
}
int yarrow_add_entropy(const unsigned char *in, unsigned long inlen, prng_state *prng)
{
   hash_state md;
   int err;
   LTC_ARGCHK(in  != NULL);
   LTC_ARGCHK(prng != NULL);
   LTC_MUTEX_LOCK(&prng->yarrow.prng_lock);
   if ((err = hash_is_valid(prng->yarrow.hash)) != CRYPT_OK) {
      LTC_MUTEX_UNLOCK(&prng->yarrow.prng_lock);
      return err;
   }
   if ((err = hash_descriptor[prng->yarrow.hash].init(&md)) != CRYPT_OK) {
      LTC_MUTEX_UNLOCK(&prng->yarrow.prng_lock);
      return err; 
   }
   if ((err = hash_descriptor[prng->yarrow.hash].process(&md, prng->yarrow.pool, 
                                                        hash_descriptor[prng->yarrow.hash].hashsize)) != CRYPT_OK) {
      LTC_MUTEX_UNLOCK(&prng->yarrow.prng_lock);
      return err;
   }
   if ((err = hash_descriptor[prng->yarrow.hash].process(&md, in, inlen)) != CRYPT_OK) {
      LTC_MUTEX_UNLOCK(&prng->yarrow.prng_lock);
      return err;
   }
   if ((err = hash_descriptor[prng->yarrow.hash].done(&md, prng->yarrow.pool)) != CRYPT_OK) {
      LTC_MUTEX_UNLOCK(&prng->yarrow.prng_lock);
      return err;
   }
   LTC_MUTEX_UNLOCK(&prng->yarrow.prng_lock);
   return CRYPT_OK;
}
int yarrow_ready(prng_state *prng)
{
   int ks, err;
   LTC_ARGCHK(prng != NULL);
   LTC_MUTEX_LOCK(&prng->yarrow.prng_lock);
   if ((err = hash_is_valid(prng->yarrow.hash)) != CRYPT_OK) {
      LTC_MUTEX_UNLOCK(&prng->yarrow.prng_lock);
      return err;
   }
   if ((err = cipher_is_valid(prng->yarrow.cipher)) != CRYPT_OK) {
      LTC_MUTEX_UNLOCK(&prng->yarrow.prng_lock);
      return err;
   }
   ks = (int)hash_descriptor[prng->yarrow.hash].hashsize;
   if ((err = cipher_descriptor[prng->yarrow.cipher].keysize(&ks)) != CRYPT_OK) {
      LTC_MUTEX_UNLOCK(&prng->yarrow.prng_lock);
      return err;
   }
   if ((err = ctr_start(prng->yarrow.cipher,     
                        prng->yarrow.pool,       
                        prng->yarrow.pool, ks,   
                        0,                       
                        CTR_COUNTER_LITTLE_ENDIAN, 
                        &prng->yarrow.ctr)) != CRYPT_OK) {
      LTC_MUTEX_UNLOCK(&prng->yarrow.prng_lock);
      return err;
   }
   LTC_MUTEX_UNLOCK(&prng->yarrow.prng_lock);
   return CRYPT_OK;
}
unsigned long yarrow_read(unsigned char *out, unsigned long outlen, prng_state *prng)
{
   LTC_ARGCHK(out  != NULL);
   LTC_ARGCHK(prng != NULL);
   LTC_MUTEX_LOCK(&prng->yarrow.prng_lock);
   zeromem(out, outlen);
   if (ctr_encrypt(out, out, outlen, &prng->yarrow.ctr) != CRYPT_OK) {
      LTC_MUTEX_UNLOCK(&prng->yarrow.prng_lock);
      return 0;
   }
   LTC_MUTEX_UNLOCK(&prng->yarrow.prng_lock);
   return outlen;
}
int yarrow_done(prng_state *prng)
{
   int err;
   LTC_ARGCHK(prng != NULL);
   LTC_MUTEX_LOCK(&prng->yarrow.prng_lock);
   err = ctr_done(&prng->yarrow.ctr);
   LTC_MUTEX_UNLOCK(&prng->yarrow.prng_lock);
   return err;
}
int yarrow_export(unsigned char *out, unsigned long *outlen, prng_state *prng)
{
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   LTC_ARGCHK(prng   != NULL);
   LTC_MUTEX_LOCK(&prng->yarrow.prng_lock);
   if (*outlen < 64) {
      LTC_MUTEX_UNLOCK(&prng->yarrow.prng_lock);
      *outlen = 64;
      return CRYPT_BUFFER_OVERFLOW;
   }
   if (yarrow_read(out, 64, prng) != 64) {
      LTC_MUTEX_UNLOCK(&prng->yarrow.prng_lock);
      return CRYPT_ERROR_READPRNG;
   }
   *outlen = 64;
   return CRYPT_OK;
}
int yarrow_import(const unsigned char *in, unsigned long inlen, prng_state *prng)
{
   int err;
   LTC_ARGCHK(in   != NULL);
   LTC_ARGCHK(prng != NULL);
   LTC_MUTEX_LOCK(&prng->yarrow.prng_lock);
   if (inlen != 64) {
      LTC_MUTEX_UNLOCK(&prng->yarrow.prng_lock);
      return CRYPT_INVALID_ARG;
   }
   if ((err = yarrow_start(prng)) != CRYPT_OK) {
      LTC_MUTEX_UNLOCK(&prng->yarrow.prng_lock);
      return err;
   }
   err = yarrow_add_entropy(in, 64, prng);
   LTC_MUTEX_UNLOCK(&prng->yarrow.prng_lock);
   return err;
}
int yarrow_test(void)
{
#ifndef LTC_TEST
   return CRYPT_NOP;
#else
   int err;
   prng_state prng;
   if ((err = yarrow_start(&prng)) != CRYPT_OK) {
      return err;
   }
   if (cipher_descriptor[prng.yarrow.cipher].test &&
       ((err = cipher_descriptor[prng.yarrow.cipher].test()) != CRYPT_OK)) {
      return err;
   }
   if (hash_descriptor[prng.yarrow.hash].test &&
       ((err = hash_descriptor[prng.yarrow.hash].test()) != CRYPT_OK)) {
      return err;
   }
   return CRYPT_OK;
#endif
}
#endif
