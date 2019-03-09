#include "tomcrypt.h"
#ifdef LTC_OCB_MODE
int ocb_decrypt(ocb_state *ocb, const unsigned char *ct, unsigned char *pt)
{
   unsigned char Z[MAXBLOCKSIZE], tmp[MAXBLOCKSIZE];
   int err, x;
   LTC_ARGCHK(ocb != NULL);
   LTC_ARGCHK(pt  != NULL);
   LTC_ARGCHK(ct  != NULL);
   if ((err = cipher_is_valid(ocb->cipher)) != CRYPT_OK) {
      return err;
   }
   LTC_ARGCHK(cipher_descriptor[ocb->cipher].ecb_decrypt != NULL);
   if (ocb->block_len != cipher_descriptor[ocb->cipher].block_length) {
      return CRYPT_INVALID_ARG;
   }
   ocb_shift_xor(ocb, Z);
   for (x = 0; x < ocb->block_len; x++) {
       tmp[x] = ct[x] ^ Z[x];
   }
   if ((err = cipher_descriptor[ocb->cipher].ecb_decrypt(tmp, pt, &ocb->key)) != CRYPT_OK) {
      return err;
   }
   for (x = 0; x < ocb->block_len; x++) {
       pt[x] ^= Z[x];
   }
   for (x = 0; x < ocb->block_len; x++) {
       ocb->checksum[x] ^= pt[x];
   }
#ifdef LTC_CLEAN_STACK
   zeromem(Z, sizeof(Z));
   zeromem(tmp, sizeof(tmp));
#endif
   return CRYPT_OK;
}
#endif
