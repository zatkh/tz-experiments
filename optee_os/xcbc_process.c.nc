#include "tomcrypt.h"
#ifdef LTC_XCBC
int xcbc_process(xcbc_state *xcbc, const unsigned char *in, unsigned long inlen)
{
   int err;
#ifdef LTC_FAST
   int x;
#endif
   LTC_ARGCHK(xcbc != NULL);
   LTC_ARGCHK(in   != NULL);
   if ((err = cipher_is_valid(xcbc->cipher)) != CRYPT_OK) {
      return err;
   }
   if ((xcbc->blocksize > cipher_descriptor[xcbc->cipher].block_length) || (xcbc->blocksize < 0) ||
       (xcbc->buflen > xcbc->blocksize) || (xcbc->buflen < 0)) {
      return CRYPT_INVALID_ARG;
   }
#ifdef LTC_FAST
   if (xcbc->buflen == 0) {
       while (inlen > (unsigned long)xcbc->blocksize) {
           for (x = 0; x < xcbc->blocksize; x += sizeof(LTC_FAST_TYPE)) {
              *((LTC_FAST_TYPE*)&(xcbc->IV[x])) ^= *((LTC_FAST_TYPE*)&(in[x]));
           }
           cipher_descriptor[xcbc->cipher].ecb_encrypt(xcbc->IV, xcbc->IV, &xcbc->key);
           in    += xcbc->blocksize;
           inlen -= xcbc->blocksize;
       }
  }
#endif
   while (inlen) {
     if (xcbc->buflen == xcbc->blocksize) {
         cipher_descriptor[xcbc->cipher].ecb_encrypt(xcbc->IV, xcbc->IV, &xcbc->key);
         xcbc->buflen = 0;
     }
     xcbc->IV[xcbc->buflen++] ^= *in++;
     --inlen;
  }
  return CRYPT_OK;       
}
#endif
