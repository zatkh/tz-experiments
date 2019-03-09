#include <tomcrypt.h>
#ifdef LTC_PKCS_5
int pkcs_5_alg1(const unsigned char *password, unsigned long password_len, 
                const unsigned char *salt, 
                int iteration_count,  int hash_idx,
                unsigned char *out,   unsigned long *outlen)
{
   int err;
   unsigned long x;
   hash_state    *md;
   unsigned char *buf;
   LTC_ARGCHK(password != NULL);
   LTC_ARGCHK(salt     != NULL);
   LTC_ARGCHK(out      != NULL);
   LTC_ARGCHK(outlen   != NULL);
   if ((err = hash_is_valid(hash_idx)) != CRYPT_OK) {
      return err;
   }
   md  = XMALLOC(sizeof(hash_state));
   buf = XMALLOC(MAXBLOCKSIZE);
   if (md == NULL || buf == NULL) {
      if (md != NULL) {
         XFREE(md);
      }
      if (buf != NULL) { 
         XFREE(buf);
      }
      return CRYPT_MEM;
   }        
   if ((err = hash_descriptor[hash_idx].init(md)) != CRYPT_OK) {
       goto LBL_ERR;
   }
   if ((err = hash_descriptor[hash_idx].process(md, password, password_len)) != CRYPT_OK) {
       goto LBL_ERR;
   }
   if ((err = hash_descriptor[hash_idx].process(md, salt, 8)) != CRYPT_OK) {
       goto LBL_ERR;
   }
   if ((err = hash_descriptor[hash_idx].done(md, buf)) != CRYPT_OK) {
       goto LBL_ERR;
   }
   while (--iteration_count) {
      x = MAXBLOCKSIZE;
      if ((err = hash_memory(hash_idx, buf, hash_descriptor[hash_idx].hashsize, buf, &x)) != CRYPT_OK) {
         goto LBL_ERR;
      }
   }
   for (x = 0; x < hash_descriptor[hash_idx].hashsize && x < *outlen; x++) {
       out[x] = buf[x];
   }
   *outlen = x;
   err = CRYPT_OK;
LBL_ERR:
#ifdef LTC_CLEAN_STACK 
   zeromem(buf, MAXBLOCKSIZE);
   zeromem(md, sizeof(hash_state));
#endif
   XFREE(buf);
   XFREE(md);
   return err;
}
#endif
