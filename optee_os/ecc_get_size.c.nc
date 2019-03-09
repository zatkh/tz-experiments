#include "tomcrypt.h"
#ifdef LTC_MECC
int ecc_get_size(ecc_key *key)
{
   LTC_ARGCHK(key != NULL);
   if (ltc_ecc_is_valid_idx(key->idx))
      return key->dp->size;
   else
      return INT_MAX; 
}
#endif
