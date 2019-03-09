#include "tomcrypt.h"
#ifdef LTC_DER
static int ltc_to_asn1(ltc_asn1_type v)
{
   switch (v) {
      case LTC_ASN1_BOOLEAN:                 return 0x01;
      case LTC_ASN1_INTEGER:
      case LTC_ASN1_SHORT_INTEGER:           return 0x02;
      case LTC_ASN1_RAW_BIT_STRING:
      case LTC_ASN1_BIT_STRING:              return 0x03;
      case LTC_ASN1_OCTET_STRING:            return 0x04;
      case LTC_ASN1_NULL:                    return 0x05;
      case LTC_ASN1_OBJECT_IDENTIFIER:       return 0x06;
      case LTC_ASN1_UTF8_STRING:             return 0x0C;
      case LTC_ASN1_PRINTABLE_STRING:        return 0x13;
      case LTC_ASN1_TELETEX_STRING:          return 0x14;
      case LTC_ASN1_IA5_STRING:              return 0x16;
      case LTC_ASN1_UTCTIME:                 return 0x17;
      case LTC_ASN1_SEQUENCE:                return 0x30;
      case LTC_ASN1_SET:
      case LTC_ASN1_SETOF:                   return 0x31;
      case LTC_ASN1_CHOICE:
      case LTC_ASN1_CONSTRUCTED:
      case LTC_ASN1_CONTEXT_SPECIFIC:
      case LTC_ASN1_EOL:                     return -1;
      default:                               return -1;
   }
   return -1;
}
static int qsort_helper(const void *a, const void *b)
{
   ltc_asn1_list *A = (ltc_asn1_list *)a, *B = (ltc_asn1_list *)b;
   int            r;
   r = ltc_to_asn1(A->type) - ltc_to_asn1(B->type);
   if (r == 0) {
      return A->used - B->used;
   } else {
      return r;
   }
}
int der_encode_set(ltc_asn1_list *list, unsigned long inlen,
                   unsigned char *out,  unsigned long *outlen)
{
   ltc_asn1_list  *copy;
   unsigned long   x;
   int             err;
   copy = XCALLOC(inlen, sizeof(*copy));
   if (copy == NULL) {
      return CRYPT_MEM;
   }
   for (x = 0; x < inlen; x++) {
       copy[x]      = list[x];
       copy[x].used = x;
   }
   XQSORT(copy, inlen, sizeof(*copy), &qsort_helper);
   err = der_encode_sequence_ex(copy, inlen, out, outlen, LTC_ASN1_SET);
   XFREE(copy);
   return err;
}
#endif
