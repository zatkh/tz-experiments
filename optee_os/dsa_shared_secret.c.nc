#include "tomcrypt.h"
#ifdef LTC_MDSA
int dsa_shared_secret(void          *private_key, void *base,
                      dsa_key       *public_key,
                      unsigned char *out,         unsigned long *outlen)
{
   unsigned long  x;
   void          *res;
   int            err;
   LTC_ARGCHK(private_key != NULL);
   LTC_ARGCHK(public_key  != NULL);
   LTC_ARGCHK(out         != NULL);
   LTC_ARGCHK(outlen      != NULL);
   if ((err = mp_init(&res)) != CRYPT_OK) {
      return err;
   }
   if ((err = mp_exptmod(base, private_key, public_key->p, res)) != CRYPT_OK) {
      mp_clear(res);
      return err;
   }
   x = (unsigned long)mp_unsigned_bin_size(res);
   if (*outlen < x) {
      *outlen = x;
      err = CRYPT_BUFFER_OVERFLOW;
      goto done;
   }
   zeromem(out, x);
   if ((err = mp_to_unsigned_bin(res, out + (x - mp_unsigned_bin_size(res))))   != CRYPT_OK)          { goto done; }
   err     = CRYPT_OK;
   *outlen = x;
done:
   mp_clear(res);
   return err;
}
#endif
