#include "tomcrypt.h"
#ifdef LTC_PKCS_1
int pkcs_1_v1_5_decode(const unsigned char *msg, 
                             unsigned long  msglen,
                                       int  block_type,
                             unsigned long  modulus_bitlen,
                             unsigned char *out, 
                             unsigned long *outlen,
                                       int *is_valid)
{
  unsigned long modulus_len, ps_len, i;
  int result;
  *is_valid = 0;
  modulus_len = (modulus_bitlen >> 3) + (modulus_bitlen & 7 ? 1 : 0);
  if ((msglen > modulus_len) || (modulus_len < 11)) {
    return CRYPT_PK_INVALID_SIZE;
  }
  result = CRYPT_OK;
  if ((msg[0] != 0x00) || (msg[1] != (unsigned char)block_type)) {
    result = CRYPT_INVALID_PACKET;
  }
  if (block_type == LTC_PKCS_1_EME) {
    for (i = 2; i < modulus_len; i++) {
      if (msg[i] == 0x00) { break; }
    }
    ps_len = i++ - 2;
    if (i >= modulus_len) {
      result = CRYPT_INVALID_PACKET;
    }
  } else {
    for (i = 2; i < modulus_len - 1; i++) {
       if (msg[i] != 0xFF) { break; }
    }
    if (msg[i] != 0) {
      result = CRYPT_INVALID_PACKET;
    }
    ps_len = i - 2;
  }
  if (ps_len < 8)
  {
    result = CRYPT_INVALID_PACKET;
  }
  if (*outlen < (msglen - (2 + ps_len + 1))) {
    result = CRYPT_INVALID_PACKET;
  }
  if (result == CRYPT_OK) {
     *outlen = (msglen - (2 + ps_len + 1));
     XMEMCPY(out, &msg[2 + ps_len + 1], *outlen);
     *is_valid = 1;
  }
  return result;
} 
#endif 
