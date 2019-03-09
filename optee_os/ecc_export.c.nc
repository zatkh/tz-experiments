#include "tomcrypt.h"
#ifdef LTC_MECC
int ecc_export(unsigned char *out, unsigned long *outlen, int type, ecc_key *key)
{
   int           err;
   unsigned char flags[1];
   unsigned long key_size;
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   LTC_ARGCHK(key    != NULL);
   if (key->type != PK_PRIVATE && type == PK_PRIVATE) {
      return CRYPT_PK_TYPE_MISMATCH;
   }
   if (ltc_ecc_is_valid_idx(key->idx) == 0) {
      return CRYPT_INVALID_ARG;
   }
   key_size = key->dp->size;
   if (type == PK_PRIVATE) {
       flags[0] = 1;
       err = der_encode_sequence_multi(out, outlen,
                                 LTC_ASN1_BIT_STRING,      1UL, flags,
                                 LTC_ASN1_SHORT_INTEGER,   1UL, &key_size,
                                 LTC_ASN1_INTEGER,         1UL, key->pubkey.x,
                                 LTC_ASN1_INTEGER,         1UL, key->pubkey.y,
                                 LTC_ASN1_INTEGER,         1UL, key->k,
                                 LTC_ASN1_EOL,             0UL, NULL);
   } else {
       flags[0] = 0;
       err = der_encode_sequence_multi(out, outlen,
                                 LTC_ASN1_BIT_STRING,      1UL, flags,
                                 LTC_ASN1_SHORT_INTEGER,   1UL, &key_size,
                                 LTC_ASN1_INTEGER,         1UL, key->pubkey.x,
                                 LTC_ASN1_INTEGER,         1UL, key->pubkey.y,
                                 LTC_ASN1_EOL,             0UL, NULL);
   }
   return err;
}
#endif
