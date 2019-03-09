#include "tomcrypt.h"
#ifdef LTC_MRSA
int rsa_export(unsigned char *out, unsigned long *outlen, int type, rsa_key *key)
{
   unsigned long zero=0;
   int err;
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   LTC_ARGCHK(key    != NULL);
   if (!(key->type == PK_PRIVATE) && (type == PK_PRIVATE)) {
      return CRYPT_PK_INVALID_TYPE;
   }
   if (type == PK_PRIVATE) {
      return der_encode_sequence_multi(out, outlen, 
                          LTC_ASN1_SHORT_INTEGER, 1UL, &zero, 
                          LTC_ASN1_INTEGER, 1UL,  key->N, 
                          LTC_ASN1_INTEGER, 1UL,  key->e,
                          LTC_ASN1_INTEGER, 1UL,  key->d, 
                          LTC_ASN1_INTEGER, 1UL,  key->p, 
                          LTC_ASN1_INTEGER, 1UL,  key->q, 
                          LTC_ASN1_INTEGER, 1UL,  key->dP,
                          LTC_ASN1_INTEGER, 1UL,  key->dQ, 
                          LTC_ASN1_INTEGER, 1UL,  key->qP, 
                          LTC_ASN1_EOL,     0UL, NULL);
   } else {
      unsigned long tmplen, *ptmplen;
      unsigned char* tmp = NULL;
      if (type & PK_STD) {
          tmplen = (mp_count_bits(key->N)/8)*2+8;
          tmp = XMALLOC(tmplen);
          ptmplen = &tmplen;
          if (tmp == NULL) {
              return CRYPT_MEM;
          }
      }
      else {
          tmp = out;
          ptmplen = outlen;
      }
      err = der_encode_sequence_multi(tmp, ptmplen,
                                 LTC_ASN1_INTEGER, 1UL,  key->N,
                                 LTC_ASN1_INTEGER, 1UL,  key->e,
                                 LTC_ASN1_EOL,     0UL, NULL);
      if ((err != CRYPT_OK) || !(type & PK_STD)) {
          goto finish;
      }
      err = der_encode_subject_public_key_info(out, outlen,
        PKA_RSA, tmp, tmplen, LTC_ASN1_NULL, NULL, 0);
finish:
      if (tmp != out)
        XFREE(tmp);
      return err;
   }
}
#endif 
