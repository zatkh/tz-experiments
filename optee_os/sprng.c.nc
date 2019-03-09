#include "tomcrypt.h"
#ifdef LTC_SPRNG
const struct ltc_prng_descriptor sprng_desc =
{
    "sprng", 0,
    &sprng_start,
    &sprng_add_entropy,
    &sprng_ready,
    &sprng_read,
    &sprng_done,
    &sprng_export,
    &sprng_import,
    &sprng_test
};
int sprng_start(prng_state *prng)
{
   LTC_UNUSED_PARAM(prng);
   return CRYPT_OK;
}
int sprng_add_entropy(const unsigned char *in, unsigned long inlen, prng_state *prng)
{
   LTC_UNUSED_PARAM(in);
   LTC_UNUSED_PARAM(inlen);
   LTC_UNUSED_PARAM(prng);
   return CRYPT_OK;
}
int sprng_ready(prng_state *prng)
{
   LTC_UNUSED_PARAM(prng);
   return CRYPT_OK;
}
unsigned long sprng_read(unsigned char *out, unsigned long outlen, prng_state *prng)
{
   LTC_ARGCHK(out != NULL);
   LTC_UNUSED_PARAM(prng);
   return rng_get_bytes(out, outlen, NULL);
}
int sprng_done(prng_state *prng)
{
   LTC_UNUSED_PARAM(prng);
   return CRYPT_OK;
}
int sprng_export(unsigned char *out, unsigned long *outlen, prng_state *prng)
{
   LTC_ARGCHK(outlen != NULL);
   LTC_UNUSED_PARAM(out);
   LTC_UNUSED_PARAM(prng);
   *outlen = 0;
   return CRYPT_OK;
}
int sprng_import(const unsigned char *in, unsigned long inlen, prng_state *prng)
{
  LTC_UNUSED_PARAM(in);
  LTC_UNUSED_PARAM(inlen);
  LTC_UNUSED_PARAM(prng);
   return CRYPT_OK;
}
int sprng_test(void)
{
   return CRYPT_OK;
}
#endif
