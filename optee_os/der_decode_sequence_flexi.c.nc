#include "tomcrypt.h"
#ifdef LTC_DER
static unsigned long fetch_length(const unsigned char *in, unsigned long inlen, unsigned long *data_offset)
{
   unsigned long x, z;
   *data_offset = 0;
   if (inlen < 2) {
      return 0xFFFFFFFF;
   }
   ++in; ++(*data_offset);
   x = *in++; ++(*data_offset);
   if (x < 128) {
      return x+*data_offset;
   }
   x     &= 0x7F; 
   inlen -= 2;
   if (x == 0 || x > 4 || x > inlen) {
      return 0xFFFFFFFF;
   }
   *data_offset += x;
   z = 0;
   while (x--) {
      z = (z<<8) | ((unsigned long)*in);
      ++in;
   }
   return z+*data_offset;
}
int der_decode_sequence_flexi(const unsigned char *in, unsigned long *inlen, ltc_asn1_list **out)
{
   ltc_asn1_list *l;
   unsigned long err, type, len, totlen, data_offset;
   void          *realloc_tmp;
   LTC_ARGCHK(in    != NULL);
   LTC_ARGCHK(inlen != NULL);
   LTC_ARGCHK(out   != NULL);
   l = NULL;
   totlen = 0;
   while (*inlen) {
      type = *in;
      len = fetch_length(in, *inlen, &data_offset);
      if (len > *inlen) {
         err = CRYPT_INVALID_PACKET;
         goto error;
      }
      if (l == NULL) {
         l = XCALLOC(1, sizeof(*l));
         if (l == NULL) {
            err = CRYPT_MEM;
            goto error;
         }
      } else {
         l->next = XCALLOC(1, sizeof(*l));
         if (l->next == NULL) {
            err = CRYPT_MEM;
            goto error;
         }
         l->next->prev = l;
         l = l->next;
      }
      if ((type & 0x20) && (type != 0x30) && (type != 0x31)) {
         l->used = type;
         type = 0x20;
      }
      else if ((type & 0xC0) == 0x80) {
         l->used = type;
         type = 0x80;
      }
      switch (type) {
         case 0x01: 
            l->type = LTC_ASN1_BOOLEAN;
            l->size = 1;
            l->data = XCALLOC(1, sizeof(int));
            if ((err = der_decode_boolean(in, *inlen, l->data)) != CRYPT_OK) {
               goto error;
            }
            if ((err = der_length_boolean(&len)) != CRYPT_OK) {
               goto error;
            }
            break;
         case 0x02: 
             l->type = LTC_ASN1_INTEGER;
             l->size = 1;
             if ((err = mp_init(&l->data)) != CRYPT_OK) {
                 goto error;
             }
             if ((err = der_decode_integer(in, *inlen, l->data)) != CRYPT_OK) {
                 goto error;
             }
             if ((err = der_length_integer(l->data, &len)) != CRYPT_OK) {
                 goto error;
             }
             break;
         case 0x03: 
            l->type = LTC_ASN1_BIT_STRING;
            l->size = len * 8; 
            if ((l->data = XCALLOC(1, l->size)) == NULL) {
               err = CRYPT_MEM;
               goto error;
            }
            if ((err = der_decode_bit_string(in, *inlen, l->data, &l->size)) != CRYPT_OK) {
               goto error;
            }
            if ((err = der_length_bit_string(l->size, &len)) != CRYPT_OK) {
               goto error;
            }
            break;
         case 0x04: 
            l->type = LTC_ASN1_OCTET_STRING;
            l->size = len;
            if ((l->data = XCALLOC(1, l->size)) == NULL) {
               err = CRYPT_MEM;
               goto error;
            }
            if ((err = der_decode_octet_string(in, *inlen, l->data, &l->size)) != CRYPT_OK) {
               goto error;
            }
            if ((err = der_length_octet_string(l->size, &len)) != CRYPT_OK) {
               goto error;
            }
            break;
         case 0x05: 
            if (in[0] != 0x05 || in[1] != 0x00) {
               err = CRYPT_INVALID_PACKET;
               goto error;
            }
            l->type = LTC_ASN1_NULL;
            l->data = NULL;
            l->size = 0;
            len     = 2;
            break;
         case 0x06: 
            l->type = LTC_ASN1_OBJECT_IDENTIFIER;
            l->size = len;
            if ((l->data = XCALLOC(len, sizeof(unsigned long))) == NULL) {
               err = CRYPT_MEM;
               goto error;
            }
            if ((err = der_decode_object_identifier(in, *inlen, l->data, &l->size)) != CRYPT_OK) {
               goto error;
            }
            if ((err = der_length_object_identifier(l->data, l->size, &len)) != CRYPT_OK) {
               goto error;
            }
            if ((realloc_tmp = XREALLOC(l->data, l->size * sizeof(unsigned long))) == NULL) {
               break;
            }
            l->data = realloc_tmp;
            break;
         case 0x0C: 
            l->type = LTC_ASN1_UTF8_STRING;
            l->size = len;
            if ((l->data = XCALLOC(sizeof(wchar_t), l->size)) == NULL) {
               err = CRYPT_MEM;
               goto error;
            }
            if ((err = der_decode_utf8_string(in, *inlen, l->data, &l->size)) != CRYPT_OK) {
               goto error;
            }
            if ((err = der_length_utf8_string(l->data, l->size, &len)) != CRYPT_OK) {
               goto error;
            }
            break;
         case 0x13: 
            l->type = LTC_ASN1_PRINTABLE_STRING;
            l->size = len;
            if ((l->data = XCALLOC(1, l->size)) == NULL) {
               err = CRYPT_MEM;
               goto error;
            }
            if ((err = der_decode_printable_string(in, *inlen, l->data, &l->size)) != CRYPT_OK) {
               goto error;
            }
            if ((err = der_length_printable_string(l->data, l->size, &len)) != CRYPT_OK) {
               goto error;
            }
            break;
         case 0x14: 
            l->type = LTC_ASN1_TELETEX_STRING;
            l->size = len;
            if ((l->data = XCALLOC(1, l->size)) == NULL) {
               err = CRYPT_MEM;
               goto error;
            }
            if ((err = der_decode_teletex_string(in, *inlen, l->data, &l->size)) != CRYPT_OK) {
               goto error;
            }
            if ((err = der_length_teletex_string(l->data, l->size, &len)) != CRYPT_OK) {
               goto error;
            }
            break;
         case 0x16: 
            l->type = LTC_ASN1_IA5_STRING;
            l->size = len;
            if ((l->data = XCALLOC(1, l->size)) == NULL) {
               err = CRYPT_MEM;
               goto error;
            }
            if ((err = der_decode_ia5_string(in, *inlen, l->data, &l->size)) != CRYPT_OK) {
               goto error;
            }
            if ((err = der_length_ia5_string(l->data, l->size, &len)) != CRYPT_OK) {
               goto error;
            }
            break;
         case 0x17: 
            l->type = LTC_ASN1_UTCTIME;
            l->size = 1;
            if ((l->data = XCALLOC(1, sizeof(ltc_utctime))) == NULL) {
               err = CRYPT_MEM;
               goto error;
            }
            len = *inlen;
            if ((err = der_decode_utctime(in, &len, l->data)) != CRYPT_OK) {
               goto error;
            }
            if ((err = der_length_utctime(l->data, &len)) != CRYPT_OK) {
               goto error;
            }
            break;
         case 0x20: 
         case 0x30: 
         case 0x31: 
             if (type == 0x20) {
                l->type = LTC_ASN1_CONSTRUCTED;
             }
             else if (type == 0x30) {
                l->type = LTC_ASN1_SEQUENCE;
             }
             else {
                l->type = LTC_ASN1_SET;
             }
             in     += data_offset;
             *inlen -= data_offset;
             len = len - data_offset;
             if ((err = der_decode_sequence_flexi(in, &len, &(l->child))) != CRYPT_OK) {
                goto error;
             }
             totlen += data_offset;
             if (l->child) {
                l->child->parent = l;
             }
             break;
         case 0x80: 
             l->type = LTC_ASN1_CONTEXT_SPECIFIC;
             if ((l->data = XCALLOC(1, len - data_offset)) == NULL) {
                err = CRYPT_MEM;
                goto error;
             }
             XMEMCPY(l->data, in + data_offset, len - data_offset);
             l->size = len - data_offset;
             break;
         default:
           if (l->prev) {
              l       = l->prev;
              XFREE(l->next);
              l->next = NULL;
           }
           goto outside;
      }
      totlen  += len;
      in      += len;
      *inlen  -= len;
   }
outside:
   if (totlen) {
      while (l->prev != NULL || l->parent != NULL) {
         if (l->parent != NULL) {
            l = l->parent;
         } else {
            l = l->prev;
         }
      }
   }
   *out   = l;
   *inlen = totlen;
   return CRYPT_OK;
error:
   der_sequence_free(l);
   return err;
}
#endif
