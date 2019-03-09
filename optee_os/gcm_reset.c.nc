#include "tomcrypt.h"
#ifdef LTC_GCM_MODE
int gcm_reset(gcm_state *gcm)
{
   LTC_ARGCHK(gcm != NULL);
   zeromem(gcm->buf, sizeof(gcm->buf));
   zeromem(gcm->X,   sizeof(gcm->X));
   gcm->mode     = LTC_GCM_MODE_IV;
   gcm->ivmode   = 0;
   gcm->buflen   = 0;
   gcm->totlen   = 0;
   gcm->pttotlen = 0;
   return CRYPT_OK;
}
#endif
