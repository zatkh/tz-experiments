#include "tomcrypt.h"
#include <stdarg.h>
#ifdef LTC_DER
int der_encode_sequence_ex(ltc_asn1_list *list, unsigned long inlen,
                           unsigned char *out,  unsigned long *outlen, int type_of)
{
   int           err;
   ltc_asn1_type type;
   unsigned long size, x, y, z, i;
   void          *data;
   LTC_ARGCHK(list    != NULL);
   LTC_ARGCHK(out     != NULL);
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
               if ((err = der_length_short_integer(*((unsigned long*)data), &x)) != CRYPT_OK) {
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
           case LTC_ASN1_PRINTABLE_STRING:
               if ((err = der_length_printable_string(data, size, &x)) != CRYPT_OK) {
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
           case LTC_ASN1_UTCTIME:
               if ((err = der_length_utctime(data, &x)) != CRYPT_OK) {
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
           case LTC_ASN1_TELETEX_STRING:
               err = CRYPT_INVALID_ARG;
               goto LBL_ERR;
           default:
               err = CRYPT_INVALID_ARG;
               goto LBL_ERR;
       }
   }
   z = y;
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
   if (*outlen < y) {
      *outlen = y;
      err = CRYPT_BUFFER_OVERFLOW;
      goto LBL_ERR;
   }
   x = 0;
   out[x++] = (type_of == LTC_ASN1_SEQUENCE) ? 0x30 : 0x31;
   if (z < 128) {
      out[x++] = (unsigned char)z;
   } else if (z < 256) {
      out[x++] = 0x81;
      out[x++] = (unsigned char)z;
   } else if (z < 65536UL) {
      out[x++] = 0x82;
      out[x++] = (unsigned char)((z>>8UL)&255);
      out[x++] = (unsigned char)(z&255);
   } else if (z < 16777216UL) {
      out[x++] = 0x83;
      out[x++] = (unsigned char)((z>>16UL)&255);
      out[x++] = (unsigned char)((z>>8UL)&255);
      out[x++] = (unsigned char)(z&255);
   }
   *outlen -= x;
   for (i = 0; i < inlen; i++) {
       type = list[i].type;
       size = list[i].size;
       data = list[i].data;
       if (type == LTC_ASN1_EOL) {
          break;
       }
       switch (type) {
            case LTC_ASN1_BOOLEAN:
               z = *outlen;
               if ((err = der_encode_boolean(*((int *)data), out + x, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               x       += z;
               *outlen -= z;
               break;
           case LTC_ASN1_INTEGER:
               z = *outlen;
               if ((err = der_encode_integer(data, out + x, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               x       += z;
               *outlen -= z;
               break;
           case LTC_ASN1_SHORT_INTEGER:
               z = *outlen;
               if ((err = der_encode_short_integer(*((unsigned long*)data), out + x, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               x       += z;
               *outlen -= z;
               break;
           case LTC_ASN1_BIT_STRING:
               z = *outlen;
               if ((err = der_encode_bit_string(data, size, out + x, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               x       += z;
               *outlen -= z;
               break;
           case LTC_ASN1_RAW_BIT_STRING:
               z = *outlen;
               if ((err = der_encode_raw_bit_string(data, size, out + x, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               x       += z;
               *outlen -= z;
               break;
           case LTC_ASN1_OCTET_STRING:
               z = *outlen;
               if ((err = der_encode_octet_string(data, size, out + x, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               x       += z;
               *outlen -= z;
               break;
           case LTC_ASN1_NULL:
               out[x++] = 0x05;
               out[x++] = 0x00;
               *outlen -= 2;
               break;
           case LTC_ASN1_OBJECT_IDENTIFIER:
               z = *outlen;
               if ((err = der_encode_object_identifier(data, size, out + x, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               x       += z;
               *outlen -= z;
               break;
           case LTC_ASN1_IA5_STRING:
               z = *outlen;
               if ((err = der_encode_ia5_string(data, size, out + x, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               x       += z;
               *outlen -= z;
               break;
           case LTC_ASN1_PRINTABLE_STRING:
               z = *outlen;
               if ((err = der_encode_printable_string(data, size, out + x, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               x       += z;
               *outlen -= z;
               break;
           case LTC_ASN1_UTF8_STRING:
               z = *outlen;
               if ((err = der_encode_utf8_string(data, size, out + x, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               x       += z;
               *outlen -= z;
               break;
           case LTC_ASN1_UTCTIME:
               z = *outlen;
               if ((err = der_encode_utctime(data, out + x, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               x       += z;
               *outlen -= z;
               break;
           case LTC_ASN1_SET:
               z = *outlen;
               if ((err = der_encode_set(data, size, out + x, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               x       += z;
               *outlen -= z;
               break;
           case LTC_ASN1_SETOF:
               z = *outlen;
               if ((err = der_encode_setof(data, size, out + x, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               x       += z;
               *outlen -= z;
               break;
           case LTC_ASN1_SEQUENCE:
               z = *outlen;
               if ((err = der_encode_sequence_ex(data, size, out + x, &z, type)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               x       += z;
               *outlen -= z;
               break;
           case LTC_ASN1_CHOICE:
           case LTC_ASN1_CONSTRUCTED:
           case LTC_ASN1_CONTEXT_SPECIFIC:
           case LTC_ASN1_EOL:
           case LTC_ASN1_TELETEX_STRING:
               err = CRYPT_INVALID_ARG;
               goto LBL_ERR;
           default:
               err = CRYPT_INVALID_ARG;
               goto LBL_ERR;
       }
   }
   *outlen = x;
   err = CRYPT_OK;
LBL_ERR:
   return err;
}
#endif
