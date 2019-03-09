#include "tomcrypt.h"
#ifdef LTC_MECC
int ecc_ansi_x963_export(ecc_key *key, unsigned char *out, unsigned long *outlen)
{
   unsigned char buf[ECC_BUF_SIZE];
   unsigned long numlen, xlen, ylen;
   LTC_ARGCHK(key    != NULL);
   LTC_ARGCHK(outlen != NULL);
   if (ltc_ecc_is_valid_idx(key->idx) == 0) {
      return CRYPT_INVALID_ARG;
   }
   numlen = key->dp->size;
   xlen = mp_unsigned_bin_size(key->pubkey.x);
   ylen = mp_unsigned_bin_size(key->pubkey.y);
   if (xlen > numlen || ylen > numlen || sizeof(buf) < numlen) {
      return CRYPT_BUFFER_OVERFLOW;
   }
   if (*outlen < (1 + 2*numlen)) {
      *outlen = 1 + 2*numlen;
      return CRYPT_BUFFER_OVERFLOW;
   }
   LTC_ARGCHK(out    != NULL);
   out[0] = 0x04;
   zeromem(buf, sizeof(buf));
   mp_to_unsigned_bin(key->pubkey.x, buf + (numlen - xlen));
   XMEMCPY(out+1, buf, numlen);
   zeromem(buf, sizeof(buf));
   mp_to_unsigned_bin(key->pubkey.y, buf + (numlen - ylen));
   XMEMCPY(out+1+numlen, buf, numlen);
   *outlen = 1 + 2*numlen;
   return CRYPT_OK;
}
#endif
