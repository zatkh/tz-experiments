#include "tomcrypt.h"
#ifdef LTC_DER
int der_encode_subject_public_key_info(unsigned char *out, unsigned long *outlen,
        unsigned int algorithm, void* public_key, unsigned long public_key_len,
        unsigned long parameters_type, void* parameters, unsigned long parameters_len)
{
   int           err;
   ltc_asn1_list alg_id[2];
   oid_st oid;
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   err = pk_get_oid(algorithm, &oid);
   if (err != CRYPT_OK) {
        return err;
   }
   LTC_SET_ASN1(alg_id, 0, LTC_ASN1_OBJECT_IDENTIFIER, oid.OID,    oid.OIDlen);
   LTC_SET_ASN1(alg_id, 1, parameters_type,            parameters, parameters_len);
   return der_encode_sequence_multi(out, outlen,
        LTC_ASN1_SEQUENCE, (unsigned long)sizeof(alg_id)/sizeof(alg_id[0]), alg_id,
        LTC_ASN1_RAW_BIT_STRING, (unsigned long)(public_key_len*8), public_key,
        LTC_ASN1_EOL,     0UL, NULL);
}
#endif
