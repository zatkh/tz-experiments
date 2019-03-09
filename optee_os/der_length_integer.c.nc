#include "tomcrypt.h"
#ifdef LTC_DER
int der_length_integer(void *num, unsigned long *outlen)
{
   unsigned long z, len;
   int           leading_zero;
   LTC_ARGCHK(num     != NULL);
   LTC_ARGCHK(outlen  != NULL);
   if (mp_cmp_d(num, 0) != LTC_MP_LT) {
      if ((mp_count_bits(num) & 7) == 0 || mp_iszero(num) == LTC_MP_YES) {
         leading_zero = 1;
      } else {
         leading_zero = 0;
      }
      z = len = leading_zero + mp_unsigned_bin_size(num);
   } else {
      z = mp_count_bits(num);
      z = z + (8 - (z & 7));
      if (((mp_cnt_lsb(num)+1)==mp_count_bits(num)) && ((mp_count_bits(num)&7)==0)) --z;
      len = z = z >> 3;
   }
   if (z < 128) {
      ++len;
   } else {
      ++len;
      while (z) {
         ++len;
         z >>= 8;
      }
   }
   ++len;
   *outlen = len;
   return CRYPT_OK;
}
#endif
