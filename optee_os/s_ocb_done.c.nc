#include "tomcrypt.h"
#ifdef LTC_OCB_MODE
int s_ocb_done(ocb_state *ocb, const unsigned char *pt, unsigned long ptlen,
               unsigned char *ct, unsigned char *tag, unsigned long *taglen, int mode)
{
   unsigned char *Z, *Y, *X;
   int err, x;
   LTC_ARGCHK(ocb    != NULL);
   LTC_ARGCHK(pt     != NULL);
   LTC_ARGCHK(ct     != NULL);
   LTC_ARGCHK(tag    != NULL);
   LTC_ARGCHK(taglen != NULL);
   if ((err = cipher_is_valid(ocb->cipher)) != CRYPT_OK) {
      return err;
   }
   if (ocb->block_len != cipher_descriptor[ocb->cipher].block_length ||
       (int)ptlen > ocb->block_len || (int)ptlen < 0) {
      return CRYPT_INVALID_ARG;
   }
   Z = XMALLOC(MAXBLOCKSIZE);
   Y = XMALLOC(MAXBLOCKSIZE);
   X = XMALLOC(MAXBLOCKSIZE);
   if (X == NULL || Y == NULL || Z == NULL) {
      if (X != NULL) {
         XFREE(X);
      }
      if (Y != NULL) {
         XFREE(Y);
      }
      if (Z != NULL) {
         XFREE(Z);
      }
      return CRYPT_MEM;
   }
   ocb_shift_xor(ocb, X); 
   XMEMCPY(Z, X, ocb->block_len);
   X[ocb->block_len-1] ^= (ptlen*8)&255;
   X[ocb->block_len-2] ^= ((ptlen*8)>>8)&255;
   for (x = 0; x < ocb->block_len; x++) {
       X[x] ^= ocb->Lr[x]; 
   }
   if ((err = cipher_descriptor[ocb->cipher].ecb_encrypt(X, Y, &ocb->key)) != CRYPT_OK) {
      goto error;
   }
   if (mode == 1) {
      for (x = 0; x < (int)ptlen; x++) {
         ocb->checksum[x] ^= ct[x];
      }  
   }
   for (x = 0; x < (int)ptlen; x++) {
       ct[x] = pt[x] ^ Y[x];
   }
   if (mode == 0) {
      for (x = 0; x < (int)ptlen; x++) {
          ocb->checksum[x] ^= ct[x];
      }
   }
   for (x = 0; x < ocb->block_len; x++) {
       ocb->checksum[x] ^= Y[x] ^ Z[x];
   }
   if ((err = cipher_descriptor[ocb->cipher].ecb_encrypt(ocb->checksum, X, &ocb->key)) != CRYPT_OK) {
      goto error;
   }
   cipher_descriptor[ocb->cipher].done(&ocb->key);
   for (x = 0; x < ocb->block_len && x < (int)*taglen; x++) {
       tag[x] = X[x];
   }
   *taglen = x;
#ifdef LTC_CLEAN_STACK
   zeromem(X, MAXBLOCKSIZE);
   zeromem(Y, MAXBLOCKSIZE);
   zeromem(Z, MAXBLOCKSIZE);
   zeromem(ocb, sizeof(*ocb));
#endif
error:   
   XFREE(X);
   XFREE(Y);
   XFREE(Z);
   return err;
}
#endif
