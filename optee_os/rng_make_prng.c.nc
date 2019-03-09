#include "tomcrypt.h"
int rng_make_prng(int bits, int wprng, prng_state *prng, 
                  void (*callback)(void))
{
   unsigned char buf[256];
   int err;
   LTC_ARGCHK(prng != NULL);
   if ((err = prng_is_valid(wprng)) != CRYPT_OK) {
      return err;
   }
   if (bits < 64 || bits > 1024) {
      return CRYPT_INVALID_PRNGSIZE;
   }
   if ((err = prng_descriptor[wprng]->start(prng)) != CRYPT_OK) {
      return err;
   }
   bits = ((bits/8)+((bits&7)!=0?1:0)) * 2;
   if (rng_get_bytes(buf, (unsigned long)bits, callback) != (unsigned long)bits) {
      return CRYPT_ERROR_READPRNG;
   }
   if ((err = prng_descriptor[wprng]->add_entropy(buf, (unsigned long)bits, prng)) != CRYPT_OK) {
      return err;
   }
   if ((err = prng_descriptor[wprng]->ready(prng)) != CRYPT_OK) {
      return err;
   }
   #ifdef LTC_CLEAN_STACK
      zeromem(buf, sizeof(buf));
   #endif
   return CRYPT_OK;
}
