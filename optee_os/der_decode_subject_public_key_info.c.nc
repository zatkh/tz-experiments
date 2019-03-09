#include "tomcrypt.h"
#ifdef LTC_DER
int der_decode_subject_public_key_info(const unsigned char *in, unsigned long inlen,
        unsigned int algorithm, void* public_key, unsigned long* public_key_len,
        unsigned long parameters_type, ltc_asn1_list* parameters, unsigned long parameters_len)
{
   int err;
   unsigned long len;
   oid_st oid;
   unsigned char *tmpbuf;
   unsigned long  tmpoid[16];
   ltc_asn1_list alg_id[2];
   ltc_asn1_list subject_pubkey[2];
   LTC_ARGCHK(in    != NULL);
   LTC_ARGCHK(inlen != 0);
   LTC_ARGCHK(public_key_len != NULL);
   err = pk_get_oid(algorithm, &oid);
   if (err != CRYPT_OK) {
        return err;
   }
   tmpbuf = XCALLOC(1, LTC_DER_MAX_PUBKEY_SIZE*8);
   if (tmpbuf == NULL) {
       err = CRYPT_MEM;
       goto LBL_ERR;
   }
   LTC_SET_ASN1(alg_id, 0, LTC_ASN1_OBJECT_IDENTIFIER, tmpoid, sizeof(tmpoid)/sizeof(tmpoid[0]));
   LTC_SET_ASN1(alg_id, 1, parameters_type, parameters, parameters_len);
   LTC_SET_ASN1(subject_pubkey, 0, LTC_ASN1_SEQUENCE, alg_id, 2);
   LTC_SET_ASN1(subject_pubkey, 1, LTC_ASN1_RAW_BIT_STRING, tmpbuf, LTC_DER_MAX_PUBKEY_SIZE*8);
   err=der_decode_sequence(in, inlen, subject_pubkey, 2UL);
   if (err != CRYPT_OK) {
           goto LBL_ERR;
   }
   if ((alg_id[0].size != oid.OIDlen) ||
        XMEMCMP(oid.OID, alg_id[0].data, oid.OIDlen * sizeof(oid.OID[0]))) {
        err = CRYPT_PK_INVALID_TYPE;
        goto LBL_ERR;
   }
   len = subject_pubkey[1].size/8;
   if (*public_key_len > len) {
       XMEMCPY(public_key, subject_pubkey[1].data, len);
       *public_key_len = len;
    } else {
        *public_key_len = len;
        err = CRYPT_BUFFER_OVERFLOW;
        goto LBL_ERR;
    }
    err = CRYPT_OK;
LBL_ERR:
    XFREE(tmpbuf);
    return err;
}
#endif
