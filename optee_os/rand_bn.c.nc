#include "tomcrypt.h"
#ifdef LTC_MDSA
int rand_bn_bits(void *N, int bits, prng_state *prng, int wprng)
{
   int res, bytes;
   unsigned char *buf, mask;
   LTC_ARGCHK(N != NULL);
   LTC_ARGCHK(bits > 1);
   if ((res = prng_is_valid(wprng)) != CRYPT_OK) return res;
   bytes = (bits+7) >> 3;
   mask = 0xff << (8 - bits % 8);
   if ((buf = XCALLOC(1, bytes)) == NULL) return CRYPT_MEM;
   if (prng_descriptor[wprng]->read(buf, bytes, prng) != (unsigned long)bytes) {
      res = CRYPT_ERROR_READPRNG;
      goto cleanup;
   }
   buf[0] &= ~mask;
   if ((res = mp_read_unsigned_bin(N, buf, bytes)) != CRYPT_OK) goto cleanup;
   res = CRYPT_OK;
cleanup:
#ifdef LTC_CLEAN_STACK
   zeromem(buf, bytes);
#endif
   XFREE(buf);
   return res;
}
int rand_bn_range(void *N, void *limit, prng_state *prng, int wprng)
{
   int res;
   LTC_ARGCHK(N != NULL);
   LTC_ARGCHK(limit != NULL);
   do {
     res = rand_bn_bits(N, mp_count_bits(limit), prng, wprng);
     if (res != CRYPT_OK) return res;
   } while (mp_cmp(N, limit) != LTC_MP_LT);
   return CRYPT_OK;
}
#endif
