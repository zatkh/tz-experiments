#include "tomcrypt.h"
#ifdef LTC_PKCS_1
int pkcs_1_v1_5_encode(const unsigned char *msg, 
                             unsigned long  msglen,
                                       int  block_type,
                             unsigned long  modulus_bitlen,
                                prng_state *prng, 
                                       int  prng_idx,
                             unsigned char *out, 
                             unsigned long *outlen)
{
  unsigned long modulus_len, ps_len, i;
  unsigned char *ps;
  int result;
  if ((block_type != LTC_PKCS_1_EMSA) &&
      (block_type != LTC_PKCS_1_EME)) {
     return CRYPT_PK_INVALID_PADDING;
  }
  if (block_type == LTC_PKCS_1_EME) {    
    if ((result = prng_is_valid(prng_idx)) != CRYPT_OK) {
       return result;
    }
  }
  modulus_len = (modulus_bitlen >> 3) + (modulus_bitlen & 7 ? 1 : 0);
  if ((msglen + 11) > modulus_len) {
    return CRYPT_PK_INVALID_SIZE;
  }
  if (*outlen < modulus_len) {
    *outlen = modulus_len;
    result = CRYPT_BUFFER_OVERFLOW;
    goto bail;
  }
  ps = &out[2];
  ps_len = modulus_len - msglen - 3;
  if (block_type == LTC_PKCS_1_EME) {
    if (prng_descriptor[prng_idx]->read(ps, ps_len, prng) != ps_len) {
      result = CRYPT_ERROR_READPRNG;
      goto bail;
    }
    for (i = 0; i < ps_len; i++) {
      while (ps[i] == 0) {
        if (prng_descriptor[prng_idx]->read(&ps[i], 1, prng) != 1) {
          result = CRYPT_ERROR_READPRNG;
          goto bail;
        }
      }
    }
  } else {
    XMEMSET(ps, 0xFF, ps_len);
  }
  out[0]          = 0x00;
  out[1]          = (unsigned char)block_type;  
  out[2 + ps_len] = 0x00;
  XMEMCPY(&out[2 + ps_len + 1], msg, msglen);
  *outlen = modulus_len;
  result  = CRYPT_OK;
bail:
  return result;
} 
#endif 
