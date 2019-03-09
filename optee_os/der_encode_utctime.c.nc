#include "tomcrypt.h"
#ifdef LTC_DER
static const char *baseten = "0123456789";
#define STORE_V(y) \
    out[x++] = der_ia5_char_encode(baseten[(y/10) % 10]); \
    out[x++] = der_ia5_char_encode(baseten[y % 10]);
int der_encode_utctime(ltc_utctime *utctime, 
                       unsigned char *out,   unsigned long *outlen)
{
    unsigned long x, tmplen;
    int           err;
    LTC_ARGCHK(utctime != NULL);
    LTC_ARGCHK(out     != NULL);
    LTC_ARGCHK(outlen  != NULL);
    if ((err = der_length_utctime(utctime, &tmplen)) != CRYPT_OK) {
       return err;
    }
    if (tmplen > *outlen) {
        *outlen = tmplen;
        return CRYPT_BUFFER_OVERFLOW;
    }
    out[0] = 0x17;
    x = 2;
    STORE_V(utctime->YY);
    STORE_V(utctime->MM);
    STORE_V(utctime->DD);
    STORE_V(utctime->hh);
    STORE_V(utctime->mm);
    STORE_V(utctime->ss);
    if (utctime->off_mm || utctime->off_hh) {
       out[x++] = der_ia5_char_encode(utctime->off_dir ? '-' : '+');
       STORE_V(utctime->off_hh);
       STORE_V(utctime->off_mm);
    } else {
       out[x++] = der_ia5_char_encode('Z');
    }
    out[1] = (unsigned char)(x - 2);
    *outlen = x;
    return CRYPT_OK;
}
#endif
