#include "tomcrypt.h"
#if !defined LTC_NO_MATH && !defined LTC_NO_PRNGS
#define USE_BBS 1
int rand_prime(void *N, long len, prng_state *prng, int wprng)
{
   int            err, res, type;
   unsigned char *buf;
   LTC_ARGCHK(N != NULL);
   if (len < 0) {
      type = USE_BBS;
      len = -len;
   } else {
      type = 0;
   }
   if (len < 2 || len > 512) { 
      return CRYPT_INVALID_PRIME_SIZE;
   }
   if ((err = prng_is_valid(wprng)) != CRYPT_OK) {
      return err; 
   }
   buf = XCALLOC(1, len);
   if (buf == NULL) {
       return CRYPT_MEM;
   }
   do {
      if (prng_descriptor[wprng]->read(buf, len, prng) != (unsigned long)len) {
         XFREE(buf);
         return CRYPT_ERROR_READPRNG;
      }
      buf[0]     |= 0x80 | 0x40;
      buf[len-1] |= 0x01 | ((type & USE_BBS) ? 0x02 : 0x00);
      if ((err = mp_read_unsigned_bin(N, buf, len)) != CRYPT_OK) {
         XFREE(buf);
         return err;
      }
      if ((err = mp_prime_is_prime(N, 8, &res)) != CRYPT_OK) {
         XFREE(buf);
         return err;
      }
   } while (res == LTC_MP_NO);
#ifdef LTC_CLEAN_STACK
   zeromem(buf, len);
#endif
   XFREE(buf);
   return CRYPT_OK;
}
#endif 
