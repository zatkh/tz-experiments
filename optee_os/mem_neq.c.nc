#include "tomcrypt.h"
int mem_neq(const void *a, const void *b, size_t len)
{
   unsigned char ret = 0;
   const unsigned char* pa;
   const unsigned char* pb;
   LTC_ARGCHK(a != NULL);
   LTC_ARGCHK(b != NULL);
   pa = a;
   pb = b;
   while (len-- > 0) {
      ret |= *pa ^ *pb;
      ++pa;
      ++pb;
   }
   ret |= ret >> 4;
   ret |= ret >> 2;
   ret |= ret >> 1;
   ret &= 1;
   return ret;
}
