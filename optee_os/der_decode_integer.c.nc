#include "tomcrypt.h"
#ifdef LTC_DER
int der_decode_integer(const unsigned char *in, unsigned long inlen, void *num)
{
   unsigned long x, y, z;
   int           err;
   LTC_ARGCHK(num    != NULL);
   LTC_ARGCHK(in     != NULL);
   if (inlen < (1 + 1 + 1)) {
      return CRYPT_INVALID_PACKET;
   }
   x = 0;
   if ((in[x++] & 0x1F) != 0x02) {
      return CRYPT_INVALID_PACKET;
   }
   z = in[x++];
   if ((z & 0x80) == 0x00) {
      if (x + z > inlen) {
         return CRYPT_INVALID_PACKET;
      }
      if ((err = mp_read_unsigned_bin(num, (unsigned char *)in + x, z)) != CRYPT_OK) {
         return err;
      }
   } else {
      z &= 0x7F;
      if (((x + z) > inlen) || (z > 4) || (z == 0)) {
         return CRYPT_INVALID_PACKET;
      }
      y = 0;
      while (z--) {
         y = ((unsigned long)(in[x++])) | (y << 8);
      }
      if ((x + y) > inlen) {
         return CRYPT_INVALID_PACKET;
      }
      if ((err = mp_read_unsigned_bin(num, (unsigned char *)in + x, y)) != CRYPT_OK) {
         return err;
      }
   }
   if (in[x] & 0x80) {
      void *tmp;
      if (mp_init(&tmp) != CRYPT_OK) {
         return CRYPT_MEM;
      }
      if (mp_2expt(tmp, mp_count_bits(num)) != CRYPT_OK || mp_sub(num, tmp, num) != CRYPT_OK) {
         mp_clear(tmp);
         return CRYPT_MEM;
      }
      mp_clear(tmp);
   } 
   return CRYPT_OK;
}
#endif
