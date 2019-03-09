#include "tomcrypt.h"
#ifdef LTC_XCBC
int xcbc_memory(int cipher, 
               const unsigned char *key, unsigned long keylen,
               const unsigned char *in,  unsigned long inlen,
                     unsigned char *out, unsigned long *outlen)
{
   xcbc_state *xcbc;
   int         err;
   if ((err = cipher_is_valid(cipher)) != CRYPT_OK) {
      return err;
   }
   if (cipher_descriptor[cipher].xcbc_memory != NULL) {
      return cipher_descriptor[cipher].xcbc_memory(key, keylen, in, inlen, out, outlen);
   }
   xcbc = XCALLOC(1, sizeof(*xcbc));
   if (xcbc == NULL) {
      return CRYPT_MEM;
   }
   if ((err = xcbc_init(xcbc, cipher, key, keylen)) != CRYPT_OK) {
     goto done;
   }
   if ((err = xcbc_process(xcbc, in, inlen)) != CRYPT_OK) {
     goto done;
   }
   err = xcbc_done(xcbc, out, outlen);
done:
   XFREE(xcbc);
   return err;
}
#endif
