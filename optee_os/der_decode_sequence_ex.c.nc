#include "tomcrypt.h"
#include <stdarg.h>
#ifdef LTC_DER
int der_decode_sequence_ex(const unsigned char *in, unsigned long  inlen,
                           ltc_asn1_list *list,     unsigned long  outlen, int ordered)
{
   int           err, i;
   ltc_asn1_type type;
   unsigned long size, x, y, z, blksize;
   void          *data;
   LTC_ARGCHK(in   != NULL);
   LTC_ARGCHK(list != NULL);
   if (inlen < 2) {
      return CRYPT_INVALID_PACKET;
   }
   x = 0;
   if (in[x] != 0x30 && in[x] != 0x31) {
      return CRYPT_INVALID_PACKET;
   }
   ++x;
   if (in[x] < 128) {
      blksize = in[x++];
   } else {
      if (in[x] < 0x81 || in[x] > 0x83) {
         return CRYPT_INVALID_PACKET;
      }
      y = in[x++] & 0x7F;
      if (x + y > inlen) {
         return CRYPT_INVALID_PACKET;
      }
      blksize = 0;
      while (y--) {
          blksize = (blksize << 8) | (unsigned long)in[x++];
      }
  }
  if (x + blksize > inlen) {
     return CRYPT_INVALID_PACKET;
  }
   for (i = 0; i < (int)outlen; i++) {
       list[i].used = 0;
   }
   inlen = blksize;
   for (i = 0; i < (int)outlen; i++) {
       z    = 0;
       type = list[i].type;
       size = list[i].size;
       data = list[i].data;
       if (!ordered && list[i].used == 1) { continue; }
       if (type == LTC_ASN1_EOL) {
          break;
       }
       switch (type) {
           case LTC_ASN1_BOOLEAN:
               z = inlen;
               if ((err = der_decode_boolean(in + x, z, ((int *)data))) != CRYPT_OK) {
                   goto LBL_ERR;
               }
               if ((err = der_length_boolean(&z)) != CRYPT_OK) {
                   goto LBL_ERR;
                }
                break;
           case LTC_ASN1_INTEGER:
               z = inlen;
               if ((err = der_decode_integer(in + x, z, data)) != CRYPT_OK) {
                  if (!ordered) {  continue; }
                  goto LBL_ERR;
               }
               if ((err = der_length_integer(data, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               break;
           case LTC_ASN1_SHORT_INTEGER:
               z = inlen;
               if ((err = der_decode_short_integer(in + x, z, data)) != CRYPT_OK) {
                  if (!ordered) { continue; }
                  goto LBL_ERR;
               }
               if ((err = der_length_short_integer(((unsigned long*)data)[0], &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               break;
           case LTC_ASN1_BIT_STRING:
               z = inlen;
               if ((err = der_decode_bit_string(in + x, z, data, &size)) != CRYPT_OK) {
                  if (!ordered) { continue; }
                  goto LBL_ERR;
               }
               list[i].size = size;
               if ((err = der_length_bit_string(size, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               break;
           case LTC_ASN1_RAW_BIT_STRING:
               z = inlen;
               if ((err = der_decode_raw_bit_string(in + x, z, data, &size)) != CRYPT_OK) {
                  if (!ordered) { continue; }
                  goto LBL_ERR;
               }
               list[i].size = size;
               if ((err = der_length_bit_string(size, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               break;
           case LTC_ASN1_OCTET_STRING:
               z = inlen;
               if ((err = der_decode_octet_string(in + x, z, data, &size)) != CRYPT_OK) {
                  if (!ordered) { continue; }
                  goto LBL_ERR;
               }
               list[i].size = size;
               if ((err = der_length_octet_string(size, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               break;
           case LTC_ASN1_NULL:
               if (inlen < 2 || in[x] != 0x05 || in[x+1] != 0x00) {
                  if (!ordered) { continue; }
                  err = CRYPT_INVALID_PACKET;
                  goto LBL_ERR;
               }
               z = 2;
               break;
           case LTC_ASN1_OBJECT_IDENTIFIER:
               z = inlen;
               if ((err = der_decode_object_identifier(in + x, z, data, &size)) != CRYPT_OK) {
                  if (!ordered) { continue; }
                  goto LBL_ERR;
               }
               list[i].size = size;
               if ((err = der_length_object_identifier(data, size, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               break;
           case LTC_ASN1_TELETEX_STRING:
               z = inlen;
               if ((err = der_decode_teletex_string(in + x, z, data, &size)) != CRYPT_OK) {
                  if (!ordered) { continue; }
                  goto LBL_ERR;
               }
               list[i].size = size;
               if ((err = der_length_teletex_string(data, size, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               break;
           case LTC_ASN1_IA5_STRING:
               z = inlen;
               if ((err = der_decode_ia5_string(in + x, z, data, &size)) != CRYPT_OK) {
                  if (!ordered) { continue; }
                  goto LBL_ERR;
               }
               list[i].size = size;
               if ((err = der_length_ia5_string(data, size, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               break;
           case LTC_ASN1_PRINTABLE_STRING:
               z = inlen;
               if ((err = der_decode_printable_string(in + x, z, data, &size)) != CRYPT_OK) {
                  if (!ordered) { continue; }
                  goto LBL_ERR;
               }
               list[i].size = size;
               if ((err = der_length_printable_string(data, size, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               break;
           case LTC_ASN1_UTF8_STRING:
               z = inlen;
               if ((err = der_decode_utf8_string(in + x, z, data, &size)) != CRYPT_OK) {
                  if (!ordered) { continue; }
                  goto LBL_ERR;
               }
               list[i].size = size;
               if ((err = der_length_utf8_string(data, size, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               break;
           case LTC_ASN1_UTCTIME:
               z = inlen;
               if ((err = der_decode_utctime(in + x, &z, data)) != CRYPT_OK) {
                  if (!ordered) { continue; }
                  goto LBL_ERR;
               }
               break;
           case LTC_ASN1_SET:
               z = inlen;
               if ((err = der_decode_set(in + x, z, data, size)) != CRYPT_OK) {
                  if (!ordered) { continue; }
                  goto LBL_ERR;
               }
               if ((err = der_length_sequence(data, size, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               break;
           case LTC_ASN1_SETOF:
           case LTC_ASN1_SEQUENCE:
               if ((type == LTC_ASN1_SETOF && (in[x] & 0x3F) != 0x31) || (type == LTC_ASN1_SEQUENCE && (in[x] & 0x3F) != 0x30)) {
                  err = CRYPT_INVALID_PACKET;
                  goto LBL_ERR;
               }
               z = inlen;
               if ((err = der_decode_sequence(in + x, z, data, size)) != CRYPT_OK) {
                  if (!ordered) { continue; }
                  goto LBL_ERR;
               }
               if ((err = der_length_sequence(data, size, &z)) != CRYPT_OK) {
                  goto LBL_ERR;
               }
               break;
           case LTC_ASN1_CHOICE:
               z = inlen;
               if ((err = der_decode_choice(in + x, &z, data, size)) != CRYPT_OK) {
                  if (!ordered) { continue; }
                  goto LBL_ERR;
               }
               break;
           case LTC_ASN1_CONSTRUCTED:
           case LTC_ASN1_CONTEXT_SPECIFIC:
           case LTC_ASN1_EOL:
               err = CRYPT_INVALID_ARG;
               goto LBL_ERR;
           default:
               err = CRYPT_INVALID_ARG;
               goto LBL_ERR;
       }
       x           += z;
       inlen       -= z;
       list[i].used = 1;
       if (!ordered) {
          i = -1;
       }
   }
   for (i = 0; i < (int)outlen; i++) {
      if (list[i].used == 0) {
          err = CRYPT_INVALID_PACKET;
          goto LBL_ERR;
      }
   }
   err = CRYPT_OK;
LBL_ERR:
   return err;
}
#endif
