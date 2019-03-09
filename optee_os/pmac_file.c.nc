#include "tomcrypt.h"
#ifdef LTC_PMAC
int pmac_file(int cipher, 
              const unsigned char *key, unsigned long keylen,
              const char *filename, 
                    unsigned char *out, unsigned long *outlen)
{
#ifdef LTC_NO_FILE
   return CRYPT_NOP;
#else
   int err, x;
   pmac_state pmac;
   FILE *in;
   unsigned char buf[512];
   LTC_ARGCHK(key      != NULL);
   LTC_ARGCHK(filename != NULL);
   LTC_ARGCHK(out      != NULL);
   LTC_ARGCHK(outlen   != NULL);
   in = fopen(filename, "rb");
   if (in == NULL) {
      return CRYPT_FILE_NOTFOUND;
   }
   if ((err = pmac_init(&pmac, cipher, key, keylen)) != CRYPT_OK) {
      fclose(in);
      return err;
   }
   do {
      x = fread(buf, 1, sizeof(buf), in);
      if ((err = pmac_process(&pmac, buf, x)) != CRYPT_OK) {
         fclose(in);
         return err;
      }
   } while (x == sizeof(buf));
   fclose(in);
   if ((err = pmac_done(&pmac, out, outlen)) != CRYPT_OK) {
      return err;
   }
#ifdef LTC_CLEAN_STACK
   zeromem(buf, sizeof(buf));
#endif
   return CRYPT_OK;
#endif
}
#endif
