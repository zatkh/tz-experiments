#include "tomcrypt.h"
#ifdef LTC_MDSA
int dsa_import(const unsigned char *in, unsigned long inlen, dsa_key *key)
{
   int           err;
   unsigned long zero = 0;
   unsigned char* tmpbuf = NULL;
   unsigned char flags[1];
   LTC_ARGCHK(in  != NULL);
   LTC_ARGCHK(key != NULL);
   LTC_ARGCHK(ltc_mp.name != NULL);
   if (mp_init_multi(&key->p, &key->g, &key->q, &key->x, &key->y, NULL) != CRYPT_OK) {
      return CRYPT_MEM;
   }
   if ((err = der_decode_sequence_multi(in, inlen,
                                  LTC_ASN1_BIT_STRING, 1UL, flags,
                                  LTC_ASN1_EOL, 0UL, NULL)) == CRYPT_OK) {
       if (flags[0]) {
           if ((err = der_decode_sequence_multi(in, inlen,
                                  LTC_ASN1_BIT_STRING,   1UL, flags,
                                  LTC_ASN1_INTEGER,      1UL, key->g,
                                  LTC_ASN1_INTEGER,      1UL, key->p,
                                  LTC_ASN1_INTEGER,      1UL, key->q,
                                  LTC_ASN1_INTEGER,      1UL, key->y,
                                  LTC_ASN1_INTEGER,      1UL, key->x,
                                  LTC_ASN1_EOL,          0UL, NULL)) != CRYPT_OK) {
               goto LBL_ERR;
           }
           key->type = PK_PRIVATE;
           goto LBL_OK;
       }
       else {
           if ((err = der_decode_sequence_multi(in, inlen,
                                      LTC_ASN1_BIT_STRING,   1UL, flags,
                                      LTC_ASN1_INTEGER,      1UL, key->g,
                                      LTC_ASN1_INTEGER,      1UL, key->p,
                                      LTC_ASN1_INTEGER,      1UL, key->q,
                                      LTC_ASN1_INTEGER,      1UL, key->y,
                                      LTC_ASN1_EOL,          0UL, NULL)) != CRYPT_OK) {
               goto LBL_ERR;
           }
           key->type = PK_PUBLIC;
           goto LBL_OK;
       }
   }
   if ((err = der_decode_sequence_multi(in, inlen,
                          LTC_ASN1_SHORT_INTEGER, 1UL, &zero,
                          LTC_ASN1_INTEGER,      1UL, key->p,
                          LTC_ASN1_INTEGER,      1UL, key->q,
                          LTC_ASN1_INTEGER,      1UL, key->g,
                          LTC_ASN1_INTEGER,      1UL, key->y,
                          LTC_ASN1_INTEGER,      1UL, key->x,
                          LTC_ASN1_EOL,          0UL, NULL)) == CRYPT_OK) {
       key->type = PK_PRIVATE;
   } else { 
      ltc_asn1_list params[3];
      unsigned long tmpbuf_len = MAX_RSA_SIZE*8;
      LTC_SET_ASN1(params, 0, LTC_ASN1_INTEGER, key->p, 1UL);
      LTC_SET_ASN1(params, 1, LTC_ASN1_INTEGER, key->q, 1UL);
      LTC_SET_ASN1(params, 2, LTC_ASN1_INTEGER, key->g, 1UL);
      tmpbuf = XCALLOC(1, tmpbuf_len);
      if (tmpbuf == NULL) {
          err = CRYPT_MEM;
          goto LBL_ERR;
      }
      err = der_decode_subject_public_key_info(in, inlen,
        PKA_DSA, tmpbuf, &tmpbuf_len,
        LTC_ASN1_SEQUENCE, params, 3);
      if (err != CRYPT_OK) {
         XFREE(tmpbuf);
         goto LBL_ERR;
      }
      if ((err=der_decode_integer(tmpbuf, tmpbuf_len, key->y)) != CRYPT_OK) {
         XFREE(tmpbuf);
         goto LBL_ERR;
      }
      XFREE(tmpbuf);
      key->type = PK_PUBLIC;
  }
LBL_OK:
  key->qord = mp_unsigned_bin_size(key->q);
  if (key->qord >= LTC_MDSA_MAX_GROUP || key->qord <= 15 ||
      (unsigned long)key->qord >= mp_unsigned_bin_size(key->p) || (mp_unsigned_bin_size(key->p) - key->qord) >= LTC_MDSA_DELTA) {
      err = CRYPT_INVALID_PACKET;
      goto LBL_ERR;
   }
  return CRYPT_OK;
LBL_ERR:
   mp_clear_multi(key->p, key->g, key->q, key->x, key->y, NULL);
   return err;
}
#endif
