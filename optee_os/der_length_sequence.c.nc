#include "tomcrypt.h"
#ifdef LTC_DER
int der_length_sequence(ltc_asn1_list *list, unsigned long inlen,
                        unsigned long *outlen)
{
   int           err;
   ltc_asn1_type type;
   unsigned long size, x, y, i;
   void          *data;
   LTC_ARGCHK(list    != NULL);
   LTC_ARGCHK(outlen  != NULL);
   y = 0;
   for (i = 0; i < inlen; i++) {
       type = list[i].type;
       size = list[i].size;
       data = list[i].data;
       if (type == LTC_ASN1_EOL) {
          break;
       }
       switch (type) {
           case LTC_ASN1_BOOLEAN:
              if ((err = der_length_boolean(&x)) != CRYPT_OK) {
                 goto LBL_ERR;
              }
              y += x;
              break;
           case LTC_ASN1_INTEGER:
               if ((err = der_length_integer(data, &x)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               y += x;
               break;
           case LTC_ASN1_SHORT_INTEGER:
               if ((err = der_length_short_integer(*((unsigned long *)data), &x)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               y += x;
               break;
           case LTC_ASN1_BIT_STRING:
           case LTC_ASN1_RAW_BIT_STRING:
               if ((err = der_length_bit_string(size, &x)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               y += x;
               break;
           case LTC_ASN1_OCTET_STRING:
               if ((err = der_length_octet_string(size, &x)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               y += x;
               break;
           case LTC_ASN1_NULL:
               y += 2;
               break;
           case LTC_ASN1_OBJECT_IDENTIFIER:
               if ((err = der_length_object_identifier(data, size, &x)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               y += x;
               break;
           case LTC_ASN1_IA5_STRING:
               if ((err = der_length_ia5_string(data, size, &x)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               y += x;
               break;
           case LTC_ASN1_TELETEX_STRING:
               if ((err = der_length_teletex_string(data, size, &x)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               y += x;
               break;
           case LTC_ASN1_PRINTABLE_STRING:
               if ((err = der_length_printable_string(data, size, &x)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               y += x;
               break;
           case LTC_ASN1_UTCTIME:
               if ((err = der_length_utctime(data, &x)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               y += x;
               break;
           case LTC_ASN1_UTF8_STRING:
               if ((err = der_length_utf8_string(data, size, &x)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               y += x;
               break;
           case LTC_ASN1_SET:
           case LTC_ASN1_SETOF:
           case LTC_ASN1_SEQUENCE:
               if ((err = der_length_sequence(data, size, &x)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               y += x;
               break;
           case LTC_ASN1_CHOICE:
           case LTC_ASN1_CONSTRUCTED:
           case LTC_ASN1_CONTEXT_SPECIFIC:
           case LTC_ASN1_EOL:
               err = CRYPT_INVALID_ARG;
               goto LBL_ERR;
           default:
               err = CRYPT_INVALID_ARG;
               goto LBL_ERR;
       }
   }
   if (y < 128) {
      y += 2;
   } else if (y < 256) {
      y += 3;
   } else if (y < 65536UL) {
      y += 4;
   } else if (y < 16777216UL) {
      y += 5;
   } else {
      err = CRYPT_INVALID_ARG;
      goto LBL_ERR;
   }
   *outlen = y;
   err     = CRYPT_OK;
LBL_ERR:
   return err;
}
#endif
