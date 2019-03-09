#include "tomcrypt.h"
#ifdef LTC_MRSA
int rsa_sign_hash_ex(const unsigned char *in,       unsigned long  inlen,
                           unsigned char *out,      unsigned long *outlen,
                           int            padding,
                           prng_state    *prng,     int            prng_idx,
                           int            hash_idx, unsigned long  saltlen,
                           rsa_key *key)
{
   unsigned long modulus_bitlen, modulus_bytelen, x, y;
   int           err;
   LTC_ARGCHK(in       != NULL);
   LTC_ARGCHK(out      != NULL);
   LTC_ARGCHK(outlen   != NULL);
   LTC_ARGCHK(key      != NULL);
   if ((padding != LTC_PKCS_1_V1_5) && (padding != LTC_PKCS_1_PSS)) {
     return CRYPT_PK_INVALID_PADDING;
   }
   if (padding == LTC_PKCS_1_PSS) {
     if ((err = prng_is_valid(prng_idx)) != CRYPT_OK) {
        return err;
     }
     if ((err = hash_is_valid(hash_idx)) != CRYPT_OK) {
        return err;
     }
   }
   modulus_bitlen = mp_count_bits((key->N));
  modulus_bytelen = mp_unsigned_bin_size((key->N));
  if (modulus_bytelen > *outlen) {
     *outlen = modulus_bytelen;
     return CRYPT_BUFFER_OVERFLOW;
  }
  if (padding == LTC_PKCS_1_PSS) {
    x = *outlen;
    if ((err = pkcs_1_pss_encode(in, inlen, saltlen, prng, prng_idx,
                                 hash_idx, modulus_bitlen, out, &x)) != CRYPT_OK) {
       return err;
    }
  } else {
    unsigned char *tmpin;
    ltc_asn1_list digestinfo[2], siginfo[2];
    if (hash_descriptor[hash_idx]->OIDlen == 0) {
       return CRYPT_INVALID_ARG;
    }
    LTC_SET_ASN1(digestinfo, 0, LTC_ASN1_OBJECT_IDENTIFIER, hash_descriptor[hash_idx]->OID, hash_descriptor[hash_idx]->OIDlen);
    LTC_SET_ASN1(digestinfo, 1, LTC_ASN1_NULL,              NULL,                          0);
    LTC_SET_ASN1(siginfo,    0, LTC_ASN1_SEQUENCE,          digestinfo,                    2);
    LTC_SET_ASN1(siginfo,    1, LTC_ASN1_OCTET_STRING,      in,                            inlen);
    y = mp_unsigned_bin_size(key->N);
    tmpin = XMALLOC(y);
    if (tmpin == NULL) {
       return CRYPT_MEM;
    }
    if ((err = der_encode_sequence(siginfo, 2, tmpin, &y)) != CRYPT_OK) {
       XFREE(tmpin);
       return err;
    }
    x = *outlen;
    if ((err = pkcs_1_v1_5_encode(tmpin, y, LTC_PKCS_1_EMSA,
                                  modulus_bitlen, NULL, 0,
                                  out, &x)) != CRYPT_OK) {
      XFREE(tmpin);
      return err;
    }
    XFREE(tmpin);
  }
  return ltc_mp.rsa_me(out, x, out, outlen, PK_PRIVATE, key);
}
#endif 
