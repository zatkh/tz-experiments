#include "tomcrypt.h"
#ifdef LTC_MRSA
int rsa_encrypt_key_ex(const unsigned char *in,     unsigned long inlen,
                             unsigned char *out,    unsigned long *outlen,
                       const unsigned char *lparam, unsigned long lparamlen,
                       prng_state *prng, int prng_idx, int hash_idx, int padding, rsa_key *key)
{
  unsigned long modulus_bitlen, modulus_bytelen, x;
  int           err;
  LTC_ARGCHK(in     != NULL);
  LTC_ARGCHK(out    != NULL);
  LTC_ARGCHK(outlen != NULL);
  LTC_ARGCHK(key    != NULL);
  if ((padding != LTC_PKCS_1_V1_5) &&
      (padding != LTC_PKCS_1_OAEP)) {
    return CRYPT_PK_INVALID_PADDING;
  }
  if ((err = prng_is_valid(prng_idx)) != CRYPT_OK) {
     return err;
  }
  if (padding == LTC_PKCS_1_OAEP) {
    if ((err = hash_is_valid(hash_idx)) != CRYPT_OK) {
       return err;
    }
  }
  modulus_bitlen = mp_count_bits( (key->N));
  modulus_bytelen = mp_unsigned_bin_size( (key->N));
  if (modulus_bytelen > *outlen) {
     *outlen = modulus_bytelen;
     return CRYPT_BUFFER_OVERFLOW;
  }
  if (padding == LTC_PKCS_1_OAEP) {
    x = *outlen;
    if ((err = pkcs_1_oaep_encode(in, inlen, lparam,
                                  lparamlen, modulus_bitlen, prng, prng_idx, hash_idx,
                                  out, &x)) != CRYPT_OK) {
       return err;
    }
  } else {
    x = *outlen;
    if ((err = pkcs_1_v1_5_encode(in, inlen, LTC_PKCS_1_EME,
                                  modulus_bitlen, prng, prng_idx,
                                  out, &x)) != CRYPT_OK) {
      return err;
    }
  }
  return ltc_mp.rsa_me(out, x, out, outlen, PK_PUBLIC, key);
}
#endif 
