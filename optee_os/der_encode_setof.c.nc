#include "tomcrypt.h"
#ifdef LTC_DER
struct edge {
   unsigned char *start;
   unsigned long  size;
};
static int qsort_helper(const void *a, const void *b)
{
   struct edge   *A = (struct edge *)a, *B = (struct edge *)b;
   int            r;
   unsigned long  x;
   r = XMEMCMP(A->start, B->start, MIN(A->size, B->size));
   if (r == 0 && A->size != B->size) {
      if (A->size > B->size) {
         for (x = B->size; x < A->size; x++) {
            if (A->start[x]) {
               return 1;
            }
         }
      } else {
         for (x = A->size; x < B->size; x++) {
            if (B->start[x]) {
               return -1;
            }
         }
      }
   }
   return r;
}
int der_encode_setof(ltc_asn1_list *list, unsigned long inlen,
                     unsigned char *out,  unsigned long *outlen)
{
   unsigned long  x, y, z;
   ptrdiff_t hdrlen;
   int            err;
   struct edge   *edges;
   unsigned char *ptr, *buf;
   for (x = 1; x < inlen; x++) {
      if (list[x].type != list[x-1].type) {
         return CRYPT_INVALID_ARG;
      }
   }
   buf = XCALLOC(1, *outlen);
   if (buf == NULL) {
      return CRYPT_MEM;
   }
   if ((err = der_encode_sequence_ex(list, inlen, buf, outlen, LTC_ASN1_SETOF)) != CRYPT_OK) {
       XFREE(buf);
       return err;
   }
   edges = XCALLOC(inlen, sizeof(*edges));
   if (edges == NULL) {
      XFREE(buf);
      return CRYPT_MEM;
   }
      ptr = buf + 1;
      x = *ptr++;
      if (x >= 0x80) {
         ptr += (x & 0x7F);
      }
      hdrlen = ptr - buf;
   x = 0;
   while (ptr < (buf + *outlen)) {
      edges[x].start = ptr;
      z = 1;
      y = ptr[z++];
      if (y < 128) {
         edges[x].size = y;
      } else {
         y &= 0x7F;
         edges[x].size = 0;
         while (y--) {
            edges[x].size = (edges[x].size << 8) | ((unsigned long)ptr[z++]);
         }
      }
      edges[x].size += z;
      ptr           += edges[x].size;
      ++x;
   }
   XQSORT(edges, inlen, sizeof(*edges), &qsort_helper);
   XMEMCPY(out, buf, hdrlen);
   for (y = hdrlen, x = 0; x < inlen; x++) {
      XMEMCPY(out+y, edges[x].start, edges[x].size);
      y += edges[x].size;
   }
#ifdef LTC_CLEAN_STACK
   zeromem(buf, *outlen);
#endif
   XFREE(edges);
   XFREE(buf);
   return CRYPT_OK;
}
#endif
