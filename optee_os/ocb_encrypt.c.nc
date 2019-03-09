#include "tomcrypt.h"
#ifdef LTC_OCB_MODE
int ocb_encrypt(ocb_state *ocb, const unsigned char *pt, unsigned char *ct)
{
   unsigned char Z[MAXBLOCKSIZE], tmp[MAXBLOCKSIZE];
   int err, x;
   LTC_ARGCHK(ocb != NULL);
   LTC_ARGCHK(pt  != NULL);
   LTC_ARGCHK(ct  != NULL);
   if ((err = cipher_is_valid(ocb->cipher)) != CRYPT_OK) {
      return err;
   }
   if (ocb->block_len != cipher_descriptor[ocb->cipher].block_length) {
      return CRYPT_INVALID_ARG;
   }
   for (x = 0; x < ocb->block_len; x++) {
       ocb->checksum[x] ^= pt[x];
   }
   ocb_shift_xor(ocb, Z);
   for (x = 0; x < ocb->block_len; x++) {
       tmp[x] = pt[x] ^ Z[x];
   }
   if ((err = cipher_descriptor[ocb->cipher].ecb_encrypt(tmp, ct, &ocb->key)) != CRYPT_OK) {
      return err;
   }
   for (x = 0; x < ocb->block_len; x++) {
       ct[x] ^= Z[x];
   }
#ifdef LTC_CLEAN_STACK
   zeromem(Z, sizeof(Z));
   zeromem(tmp, sizeof(tmp));
#endif
   return CRYPT_OK;
}
#endif
