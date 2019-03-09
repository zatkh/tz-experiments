#include "tomcrypt.h"
#ifdef LTC_PKCS_1
int pkcs_1_oaep_decode(const unsigned char *msg,    unsigned long msglen,
                       const unsigned char *lparam, unsigned long lparamlen,
                             unsigned long modulus_bitlen, int hash_idx,
                             unsigned char *out,    unsigned long *outlen,
                             int           *res)
{
   unsigned char *DB, *seed, *mask;
   unsigned long hLen, x, y, modulus_len;
   int           err, ret;
   LTC_ARGCHK(msg    != NULL);
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   LTC_ARGCHK(res    != NULL);
   *res = 0;
   if ((err = hash_is_valid(hash_idx)) != CRYPT_OK) { 
      return err;
   }
   hLen        = hash_descriptor[hash_idx]->hashsize;
   modulus_len = (modulus_bitlen >> 3) + (modulus_bitlen & 7 ? 1 : 0);
   if ((2*hLen >= (modulus_len - 2)) || (msglen != modulus_len)) {
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
   ret = CRYPT_OK;
   if (msg[0] != 0x00) {
      ret = CRYPT_INVALID_PACKET;
   }
   x = 1;
   XMEMCPY(seed, msg + x, hLen);
   x += hLen;
   XMEMCPY(DB, msg + x, modulus_len - hLen - 1);
   x += modulus_len - hLen - 1;
   if ((err = pkcs_1_mgf1(hash_idx, DB, modulus_len - hLen - 1, mask, hLen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   for (y = 0; y < hLen; y++) {
      seed[y] ^= mask[y];
   }
   if ((err = pkcs_1_mgf1(hash_idx, seed, hLen, mask, modulus_len - hLen - 1)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   for (y = 0; y < (modulus_len - hLen - 1); y++) {
       DB[y] ^= mask[y]; 
   }
   x = modulus_len;
   if (lparam != NULL) {
      if ((err = hash_memory(hash_idx, lparam, lparamlen, seed, &x)) != CRYPT_OK) {
         goto LBL_ERR;
      }
   } else {
      if ((err = hash_memory(hash_idx, DB, 0, seed, &x)) != CRYPT_OK) {
         goto LBL_ERR;
      }
   }
   if (XMEM_NEQ(seed, DB, hLen) != 0) {
      ret = CRYPT_INVALID_PACKET;
   }
   for (x = hLen; x < (modulus_len - hLen - 1) && DB[x] == 0x00; x++) {
   }
   if (x == (modulus_len - hLen - 1) || DB[x] != 0x01) {
      ret = CRYPT_INVALID_PACKET;
   }
   if ((modulus_len - hLen - 1 - ++x) > *outlen) {
      ret = CRYPT_INVALID_PACKET;
   }
   if (ret == CRYPT_OK) {
      *outlen = modulus_len - hLen - 1 - x;
      XMEMCPY(out, DB + x, modulus_len - hLen - 1 - x);
      x += modulus_len - hLen - 1;
      *res = 1;
   }
   err = ret;
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
