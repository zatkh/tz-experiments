#include "tomcrypt.h"
#ifdef LTC_XTS_MODE
void xts_done(symmetric_xts *xts)
{
   LTC_ARGCHKVD(xts != NULL);
   cipher_descriptor[xts->cipher]->done(&xts->key1);
   cipher_descriptor[xts->cipher]->done(&xts->key2);
}
#endif
