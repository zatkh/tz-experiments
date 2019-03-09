#include "tomcrypt.h"
#ifdef LTC_PKCS_1
int pkcs_1_oaep_encode(const unsigned char *msg,    unsigned long msglen,
                       const unsigned char *lparam, unsigned long lparamlen,
                             unsigned long modulus_bitlen, prng_state *prng,
                             int           prng_idx,         int  hash_idx,
                             unsigned char *out,    unsigned long *outlen)
{
   unsigned char *DB, *seed, *mask;
   unsigned long hLen, x, y, modulus_len;
   int           err;
   LTC_ARGCHK(msg    != NULL);
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   if ((err = hash_is_valid(hash_idx)) != CRYPT_OK) { 
      return err;
   }
   if ((err = prng_is_valid(prng_idx)) != CRYPT_OK) {
      return err;
   }
   hLen        = hash_descriptor[hash_idx]->hashsize;
   modulus_len = (modulus_bitlen >> 3) + (modulus_bitlen & 7 ? 1 : 0);
   if ((2*hLen >= (modulus_len - 2)) || (msglen > (modulus_len - 2*hLen - 2))) {
      return CRYPT_PK_INVALID_SIZE;
   }
   DB   = XMALLOC(modulus_len);
   mask = XMALLOC(modulus_len);
   seed = XMALLOC(hLen);
   if (DB == NULL || mask == NULL || seed == NULL) {
      if (DB != NULL) {
         XFREE(DB);
      }
      if (mask != NULL) {
         XFREE(mask);
      }
      if (seed != NULL) {
         XFREE(seed);
      }
      return CRYPT_MEM;
   }
   x = modulus_len;
   if (lparam != NULL) {
      if ((err = hash_memory(hash_idx, lparam, lparamlen, DB, &x)) != CRYPT_OK) {
         goto LBL_ERR;
      }
   } else {
      if ((err = hash_memory(hash_idx, DB, 0, DB, &x)) != CRYPT_OK) {
         goto LBL_ERR;
      }
   }
   x = hLen;
   y = modulus_len - msglen - 2*hLen - 2;
   XMEMSET(DB+x, 0, y);
   x += y;
   DB[x++] = 0x01;
   XMEMCPY(DB+x, msg, msglen);
   x += msglen;
   if (prng_descriptor[prng_idx]->read(seed, hLen, prng) != hLen) {
      err = CRYPT_ERROR_READPRNG;
      goto LBL_ERR;
   }
   if ((err = pkcs_1_mgf1(hash_idx, seed, hLen, mask, modulus_len - hLen - 1)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   for (y = 0; y < (modulus_len - hLen - 1); y++) {
       DB[y] ^= mask[y]; 
   }
   if ((err = pkcs_1_mgf1(hash_idx, DB, modulus_len - hLen - 1, mask, hLen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   for (y = 0; y < hLen; y++) {
      seed[y] ^= mask[y];
   }
   if (*outlen < modulus_len) {
      *outlen = modulus_len;
      err = CRYPT_BUFFER_OVERFLOW;
      goto LBL_ERR;
   }
   x = 0;
   out[x++] = 0x00;
   XMEMCPY(out+x, seed, hLen);
   x += hLen;
   XMEMCPY(out+x, DB, modulus_len - hLen - 1);
   x += modulus_len - hLen - 1;
   *outlen = x;
   err = CRYPT_OK;
LBL_ERR:
#ifdef LTC_CLEAN_STACK
   zeromem(DB,   modulus_len);
   zeromem(seed, hLen);
   zeromem(mask, modulus_len);
#endif
   XFREE(seed);
   XFREE(mask);
   XFREE(DB);
   return err;
}
#endif 
