#include "tomcrypt.h"
#ifdef LTC_DER
void der_sequence_free(ltc_asn1_list *in)
{
   ltc_asn1_list *l;
   if (!in) return;
   while (in->prev != NULL || in->parent != NULL) {
      if (in->parent != NULL) {
          in = in->parent;
      } else {
          in = in->prev;
      }
   }
   while (in != NULL) {
      if (in->child) {
         in->child->parent = NULL;
         der_sequence_free(in->child);
      }
      switch (in->type) { 
         case LTC_ASN1_SET:
         case LTC_ASN1_SETOF:
         case LTC_ASN1_SEQUENCE: break;
         case LTC_ASN1_INTEGER : if (in->data != NULL) { mp_clear(in->data); } break;
         default               : if (in->data != NULL) { XFREE(in->data);    }
      }
      l = in->next;
      XFREE(in);
      in = l;
   }     
}
#endif
