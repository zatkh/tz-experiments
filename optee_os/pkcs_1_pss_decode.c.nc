#include "tomcrypt.h"
#ifdef LTC_PKCS_1
int pkcs_1_pss_decode(const unsigned char *msghash, unsigned long msghashlen,
                      const unsigned char *sig,     unsigned long siglen,
                            unsigned long saltlen,  int           hash_idx,
                            unsigned long modulus_bitlen, int    *res)
{
   unsigned char *DB, *mask, *salt, *hash;
   unsigned long x, y, hLen, modulus_len;
   int           err;
   hash_state    md;
   LTC_ARGCHK(msghash != NULL);
   LTC_ARGCHK(res     != NULL);
   *res = 0;
   if ((err = hash_is_valid(hash_idx)) != CRYPT_OK) {
      return err;
   }
   hLen        = hash_descriptor[hash_idx]->hashsize;
   modulus_bitlen--;
   modulus_len = (modulus_bitlen>>3) + (modulus_bitlen & 7 ? 1 : 0);
   if ((saltlen > modulus_len) || 
       (modulus_len < hLen + saltlen + 2)) {
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
   if (sig[siglen-1] != 0xBC) {
      err = CRYPT_INVALID_PACKET;
      goto LBL_ERR;
   }
   x = 0;
   XMEMCPY(DB, sig + x, modulus_len - hLen - 1);
   x += modulus_len - hLen - 1;
   XMEMCPY(hash, sig + x, hLen);
   if ((sig[0] & ~(0xFF >> ((modulus_len<<3) - (modulus_bitlen)))) != 0) {
      err = CRYPT_INVALID_PACKET;
      goto LBL_ERR;
   }
   if ((err = pkcs_1_mgf1(hash_idx, hash, hLen, mask, modulus_len - hLen - 1)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   for (y = 0; y < (modulus_len - hLen - 1); y++) {
      DB[y] ^= mask[y];
   }
   DB[0] &= 0xFF >> ((modulus_len<<3) - (modulus_bitlen));
   for (x = 0; x < modulus_len - saltlen - hLen - 2; x++) {
       if (DB[x] != 0x00) {
          err = CRYPT_INVALID_PACKET;
          goto LBL_ERR;
       }
   }
   if (DB[x++] != 0x01) {
      err = CRYPT_INVALID_PACKET;
      goto LBL_ERR;
   }
   if ((err = hash_descriptor[hash_idx]->init(&md)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   zeromem(mask, 8);
   if ((err = hash_descriptor[hash_idx]->process(&md, mask, 8)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   if ((err = hash_descriptor[hash_idx]->process(&md, msghash, msghashlen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   if ((err = hash_descriptor[hash_idx]->process(&md, DB+x, saltlen)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   if ((err = hash_descriptor[hash_idx]->done(&md, mask)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   if (XMEM_NEQ(mask, hash, hLen) == 0) {
      *res = 1;
   }
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
