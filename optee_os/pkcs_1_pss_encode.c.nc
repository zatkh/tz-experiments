#include "tomcrypt.h"
#ifdef LTC_PKCS_1
int pkcs_1_pss_encode(const unsigned char *msghash, unsigned long msghashlen,
                            unsigned long saltlen,  prng_state   *prng,     
                            int           prng_idx, int           hash_idx,
                            unsigned long modulus_bitlen,
                            unsigned char *out,     unsigned long *outlen)
{
   unsigned char *DB, *mask, *salt, *hash;
   unsigned long x, y, hLen, modulus_len;
   int           err;
   hash_state    md;
   LTC_ARGCHK(msghash != NULL);
   LTC_ARGCHK(out     != NULL);
   LTC_ARGCHK(outlen  != NULL);
   if ((err = hash_is_valid(hash_idx)) != CRYPT_OK) {
      return err;
   }
   if ((err = prng_is_valid(prng_idx)) != CRYPT_OK) {
      return err;
   }
   hLen        = hash_descriptor[hash_idx]->hashsize;
   modulus_bitlen--;
   modulus_len = (modulus_bitlen>>3) + (modulus_bitlen & 7 ? 1 : 0);
   if ((saltlen > modulus_len) || (modulus_len < hLen + saltlen + 2)) {
      return CRYPT_PK_INVALID_SIZE;
   }
   DB   = XMALLOC(modulus_len);
   mask = XMALLOC(modulus_len);
   salt = XMALLOC(modulus_len);
   hash = XMALLOC(modulus_len);
   if (DB == NULL || mask == NULL || salt == NULL || hash == NULL) {
      if (DB != NULL) {
         XFREE(DB);
      }
      if (mask != NULL) {
         XFREE(mask);
      }
      if (salt != NULL) {
         XFREE(salt);
      }
      if (hash != NULL) {
         XFREE(hash);
      }
      return CRYPT_MEM;
   }
   if (saltlen > 0) {
      if (prng_descriptor[prng_idx]->read(salt, saltlen, prng) != saltlen) {
         err = CRYPT_ERROR_READPRNG;
         goto LBL_ERR;
      }
   }
   if ((err = hash_descriptor[hash_idx]->init(&md)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   zeromem(DB, 8);
   if ((err = hash_descriptor[hash_idx]->process(&md, DB, 8)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   if ((err = hash_descriptor[hash_idx]->process(&md, msghash, msghashlen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   if ((err = hash_descriptor[hash_idx]->process(&md, salt, saltlen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   if ((err = hash_descriptor[hash_idx]->done(&md, hash)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   x = 0;
   XMEMSET(DB + x, 0, modulus_len - saltlen - hLen - 2);
   x += modulus_len - saltlen - hLen - 2;
   DB[x++] = 0x01;
   XMEMCPY(DB + x, salt, saltlen);
   if ((err = pkcs_1_mgf1(hash_idx, hash, hLen, mask, modulus_len - hLen - 1)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   for (y = 0; y < (modulus_len - hLen - 1); y++) {
      DB[y] ^= mask[y];
   }
   if (*outlen < modulus_len) {
      *outlen = modulus_len;
      err = CRYPT_BUFFER_OVERFLOW;
      goto LBL_ERR;
   }
   y = 0;
   XMEMCPY(out + y, DB, modulus_len - hLen - 1);
   y += modulus_len - hLen - 1;
   XMEMCPY(out + y, hash, hLen);
   y += hLen;
   out[y] = 0xBC;
   out[0] &= 0xFF >> ((modulus_len<<3) - modulus_bitlen);
   *outlen = modulus_len;
   err = CRYPT_OK;
LBL_ERR:
#ifdef LTC_CLEAN_STACK
   zeromem(DB,   modulus_len);   
   zeromem(mask, modulus_len);   
   zeromem(salt, modulus_len);   
   zeromem(hash, modulus_len);   
#endif
   XFREE(hash);
   XFREE(salt);
   XFREE(mask);
   XFREE(DB);
   return err;
}
#endif 
