#include "tomcrypt.h"
#ifdef LTC_MECC
int ltc_ecc_is_valid_idx(int n)
{
   int x;
   for (x = 0; ltc_ecc_sets[x].size != 0; x++);
   if ((n >= -1) && (n < x)) {
      return 1;
   }
   return 0;
}
#endif
