#include "tomcrypt.h"
#ifdef LTC_MECC
ecc_point *ltc_ecc_new_point(void)
{
   ecc_point *p;
   p = XCALLOC(1, sizeof(*p));
   if (p == NULL) {
      return NULL;
   }
   if (mp_init_multi_size(LTC_MAX_ECC * 2,
			  &p->x, &p->y, &p->z, NULL) != CRYPT_OK) {
      XFREE(p);
      return NULL;
   }
   return p;
}
void ltc_ecc_del_point(ecc_point *p)
{
   if (p != NULL) {
      mp_clear_multi(p->x, p->y, p->z, NULL); 
      XFREE(p);
   }
}
#endif
