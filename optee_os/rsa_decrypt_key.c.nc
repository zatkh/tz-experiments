#include "tomcrypt.h"
#ifdef LTC_MRSA
int rsa_decrypt_key_ex(const unsigned char *in,       unsigned long  inlen,
                             unsigned char *out,      unsigned long *outlen,
                       const unsigned char *lparam,   unsigned long  lparamlen,
                             int            hash_idx, int            padding,
                             int           *stat,     rsa_key       *key)
{
  unsigned long modulus_bitlen, modulus_bytelen, x;
  int           err;
  unsigned char *tmp;
  LTC_ARGCHK(out    != NULL);
  LTC_ARGCHK(outlen != NULL);
  LTC_ARGCHK(key    != NULL);
  LTC_ARGCHK(stat   != NULL);
  *stat = 0;
  if ((padding != LTC_PKCS_1_V1_5) &&
      (padding != LTC_PKCS_1_OAEP)) {
    return CRYPT_PK_INVALID_PADDING;
  }
  if (padding == LTC_PKCS_1_OAEP) {
    if ((err = hash_is_valid(hash_idx)) != CRYPT_OK) {
       return err;
    }
  }
  modulus_bitlen = mp_count_bits( (key->N));
  modulus_bytelen = mp_unsigned_bin_size( (key->N));
  if (modulus_bytelen != inlen) {
     return CRYPT_INVALID_PACKET;
  }
  tmp = XMALLOC(inlen);
  if (tmp == NULL) {
     return CRYPT_MEM;
  }
  x = inlen;
  if ((err = ltc_mp.rsa_me(in, inlen, tmp, &x, PK_PRIVATE, key)) != CRYPT_OK) {
     XFREE(tmp);
     return err;
  }
  if (padding == LTC_PKCS_1_OAEP) {
    err = pkcs_1_oaep_decode(tmp, x, lparam, lparamlen, modulus_bitlen, hash_idx,
                             out, outlen, stat);
  } else {
    err = pkcs_1_v1_5_decode(tmp, x, LTC_PKCS_1_EME, modulus_bitlen, out, outlen, stat);
  }
  XFREE(tmp);
  return err;
}
#endif 
