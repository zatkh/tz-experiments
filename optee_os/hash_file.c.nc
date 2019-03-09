#include "tomcrypt.h"
#ifndef LTC_NO_FILE
int hash_file(int hash, const char *fname, unsigned char *out, unsigned long *outlen)
{
    FILE *in;
    int err;
    LTC_ARGCHK(fname  != NULL);
    LTC_ARGCHK(out    != NULL);
    LTC_ARGCHK(outlen != NULL);
    if ((err = hash_is_valid(hash)) != CRYPT_OK) {
        return err;
    }
    in = fopen(fname, "rb");
    if (in == NULL) { 
       return CRYPT_FILE_NOTFOUND;
    }
    err = hash_filehandle(hash, in, out, outlen);
    if (fclose(in) != 0) {
       return CRYPT_ERROR;
    }
    return err;
}
#endif 
