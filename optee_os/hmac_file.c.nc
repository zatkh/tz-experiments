#include "tomcrypt.h"
#ifdef LTC_HMAC
int hmac_file(int hash, const char *fname, 
              const unsigned char *key, unsigned long keylen, 
                    unsigned char *out, unsigned long *outlen)
{
#ifdef LTC_NO_FILE
    return CRYPT_NOP;
#else
   hmac_state hmac;
   FILE *in;
   unsigned char buf[512];
   size_t x;
   int err;
   LTC_ARGCHK(fname  != NULL);
   LTC_ARGCHK(key    != NULL);
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   if((err = hash_is_valid(hash)) != CRYPT_OK) {
       return err;
   }
   if ((err = hmac_init(&hmac, hash, key, keylen)) != CRYPT_OK) {
       return err;
   }
   in = fopen(fname, "rb");
   if (in == NULL) {
      return CRYPT_FILE_NOTFOUND;
   }
   do {
      x = fread(buf, 1, sizeof(buf), in);
      if ((err = hmac_process(&hmac, buf, (unsigned long)x)) != CRYPT_OK) {
         fclose(in);
         return err;
      }
   } while (x == sizeof(buf));
   if (fclose(in) != 0) {
      return CRYPT_ERROR;
   }
   if ((err = hmac_done(&hmac, out, outlen)) != CRYPT_OK) {
      return err;
   }
#ifdef LTC_CLEAN_STACK
   zeromem(buf, sizeof(buf));
#endif   
   return CRYPT_OK;
#endif
}
#endif
