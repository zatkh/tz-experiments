#include "tomcrypt.h"
#ifdef LTC_F8_MODE
int f8_start(                int  cipher, const unsigned char *IV, 
             const unsigned char *key,                    int  keylen, 
             const unsigned char *salt_key,               int  skeylen,
                             int  num_rounds,   symmetric_F8  *f8)
{
   int           x, err;
   unsigned char tkey[MAXBLOCKSIZE];
   LTC_ARGCHK(IV       != NULL);
   LTC_ARGCHK(key      != NULL);
   LTC_ARGCHK(salt_key != NULL);
   LTC_ARGCHK(f8       != NULL);
   if ((err = cipher_is_valid(cipher)) != CRYPT_OK) {
      return err;
   }
#ifdef LTC_FAST
   if (cipher_descriptor[cipher].block_length % sizeof(LTC_FAST_TYPE)) {
      return CRYPT_INVALID_ARG;
   }
#endif
   f8->blockcnt = 0;
   f8->cipher   = cipher;
   f8->blocklen = cipher_descriptor[cipher].block_length;
   f8->padlen   = f8->blocklen;
   zeromem(tkey, sizeof(tkey));
   for (x = 0; x < keylen && x < (int)sizeof(tkey); x++) {
       tkey[x] = key[x];
   }
   for (x = 0; x < skeylen && x < (int)sizeof(tkey); x++) {
       tkey[x] ^= salt_key[x];
   }       
   for (; x < keylen && x < (int)sizeof(tkey); x++) {
       tkey[x] ^= 0x55;
   }
   if ((err = cipher_descriptor[cipher].setup(tkey, keylen, num_rounds, &f8->key)) != CRYPT_OK) {
      return err;
   }
   if ((err = cipher_descriptor[f8->cipher].ecb_encrypt(IV, f8->MIV, &f8->key)) != CRYPT_OK) {
      cipher_descriptor[f8->cipher].done(&f8->key);
      return err;
   }
   zeromem(tkey, sizeof(tkey));
   zeromem(f8->IV, sizeof(f8->IV));
   cipher_descriptor[f8->cipher].done(&f8->key);
   return cipher_descriptor[cipher].setup(key, keylen, num_rounds, &f8->key);
}
#endif
