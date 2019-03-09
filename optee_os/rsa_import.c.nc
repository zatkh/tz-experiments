#include "tomcrypt.h"
#ifdef LTC_MRSA
int rsa_import(const unsigned char *in, unsigned long inlen, rsa_key *key)
{
   int           err;
   void         *zero;
   unsigned char *tmpbuf=NULL;
   unsigned long tmpbuf_len;
   LTC_ARGCHK(in          != NULL);
   LTC_ARGCHK(key         != NULL);
   LTC_ARGCHK(ltc_mp.name != NULL);
   if ((err = mp_init_multi(&key->e, &key->d, &key->N, &key->dQ, 
                            &key->dP, &key->qP, &key->p, &key->q, NULL)) != CRYPT_OK) {
      return err;
   }
   tmpbuf_len = MAX_RSA_SIZE * 8;
   tmpbuf = XCALLOC(1, tmpbuf_len);
   if (tmpbuf == NULL) {
       err = CRYPT_MEM;
       goto LBL_ERR;
   }
   err = der_decode_subject_public_key_info(in, inlen,
        PKA_RSA, tmpbuf, &tmpbuf_len,
        LTC_ASN1_NULL, NULL, 0);
   if (err == CRYPT_OK) { 
      if ((err = der_decode_sequence_multi(tmpbuf, tmpbuf_len,
                                           LTC_ASN1_INTEGER, 1UL, key->N,
                                           LTC_ASN1_INTEGER, 1UL, key->e,
                                           LTC_ASN1_EOL,     0UL, NULL)) != CRYPT_OK) {
         goto LBL_ERR;
      }
      key->type = PK_PUBLIC;
      err = CRYPT_OK;
      goto LBL_FREE;
   }
   if ((err = der_decode_sequence_multi(in, inlen, 
                                  LTC_ASN1_INTEGER, 1UL, key->N, 
                                  LTC_ASN1_EOL,     0UL, NULL)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   if (mp_cmp_d(key->N, 0) == LTC_MP_EQ) {
      if ((err = mp_init(&zero)) != CRYPT_OK) { 
         goto LBL_ERR;
      }
      if ((err = der_decode_sequence_multi(in, inlen, 
                          LTC_ASN1_INTEGER, 1UL, zero, 
                          LTC_ASN1_INTEGER, 1UL, key->N, 
                          LTC_ASN1_INTEGER, 1UL, key->e,
                          LTC_ASN1_INTEGER, 1UL, key->d, 
                          LTC_ASN1_INTEGER, 1UL, key->p, 
                          LTC_ASN1_INTEGER, 1UL, key->q, 
                          LTC_ASN1_INTEGER, 1UL, key->dP,
                          LTC_ASN1_INTEGER, 1UL, key->dQ, 
                          LTC_ASN1_INTEGER, 1UL, key->qP, 
                          LTC_ASN1_EOL,     0UL, NULL)) != CRYPT_OK) {
         mp_clear(zero);
         goto LBL_ERR;
      }
      mp_clear(zero);
      key->type = PK_PRIVATE;
   } else if (mp_cmp_d(key->N, 1) == LTC_MP_EQ) {
      err = CRYPT_PK_INVALID_TYPE;
      goto LBL_ERR;
   } else {
      if ((err = der_decode_sequence_multi(in, inlen, 
                                     LTC_ASN1_INTEGER, 1UL, key->N, 
                                     LTC_ASN1_INTEGER, 1UL, key->e, 
                                     LTC_ASN1_EOL,     0UL, NULL)) != CRYPT_OK) {
         goto LBL_ERR;
      }
      key->type = PK_PUBLIC;
   }
   err = CRYPT_OK;
   goto LBL_FREE;
LBL_ERR:
   mp_clear_multi(key->d,  key->e, key->N, key->dQ, key->dP, key->qP, key->p, key->q, NULL);
LBL_FREE:
   if (tmpbuf != NULL)
     XFREE(tmpbuf);
   return err;
}
#endif 
