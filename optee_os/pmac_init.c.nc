#include "tomcrypt.h"
#ifdef LTC_PMAC
static const struct {
    int           len;
    unsigned char poly_div[MAXBLOCKSIZE], 
                  poly_mul[MAXBLOCKSIZE];
} polys[] = {
{
    8,
    { 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0D },
    { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1B }
}, {
    16, 
    { 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x43 },
    { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87 }
}
};
int pmac_init(pmac_state *pmac, int cipher, const unsigned char *key, unsigned long keylen)
{
   int poly, x, y, m, err;
   unsigned char *L;
   LTC_ARGCHK(pmac  != NULL);
   LTC_ARGCHK(key   != NULL);
   if ((err = cipher_is_valid(cipher)) != CRYPT_OK) {
      return err;
   }
   pmac->block_len = cipher_descriptor[cipher].block_length;
   for (poly = 0; poly < (int)(sizeof(polys)/sizeof(polys[0])); poly++) {
       if (polys[poly].len == pmac->block_len) { 
          break;
       }
   }
   if (poly >= (int)(sizeof(polys)/sizeof(polys[0]))) {
      return CRYPT_INVALID_ARG;
    }
   if (polys[poly].len != pmac->block_len) {
      return CRYPT_INVALID_ARG;
   }
#ifdef LTC_FAST
   if (pmac->block_len % sizeof(LTC_FAST_TYPE)) {
      return CRYPT_INVALID_ARG;
   }
#endif
   if ((err = cipher_descriptor[cipher].setup(key, keylen, 0, &pmac->key)) != CRYPT_OK) {
      return err;
   }
   L = XMALLOC(pmac->block_len);
   if (L == NULL) {
      return CRYPT_MEM;
   }
   zeromem(L, pmac->block_len);
   if ((err = cipher_descriptor[cipher].ecb_encrypt(L, L, &pmac->key)) != CRYPT_OK) {
      goto error;
   }
   XMEMCPY(pmac->Ls[0], L, pmac->block_len);
   for (x = 1; x < 32; x++) {
       m = pmac->Ls[x-1][0] >> 7;
       for (y = 0; y < pmac->block_len-1; y++) {
           pmac->Ls[x][y] = ((pmac->Ls[x-1][y] << 1) | (pmac->Ls[x-1][y+1] >> 7)) & 255;
       }
       pmac->Ls[x][pmac->block_len-1] = (pmac->Ls[x-1][pmac->block_len-1] << 1) & 255;
       if (m == 1) {
          for (y = 0; y < pmac->block_len; y++) {
              pmac->Ls[x][y] ^= polys[poly].poly_mul[y];
          }
       }
    }
    m = L[pmac->block_len-1] & 1;
    for (x = pmac->block_len - 1; x > 0; x--) {
        pmac->Lr[x] = ((L[x] >> 1) | (L[x-1] << 7)) & 255;
    }
    pmac->Lr[0] = L[0] >> 1;
    if (m == 1) {
       for (x = 0; x < pmac->block_len; x++) {
           pmac->Lr[x] ^= polys[poly].poly_div[x];
       }
    }
    pmac->block_index = 1;
    pmac->cipher_idx  = cipher;
    pmac->buflen      = 0;
    zeromem(pmac->block,    sizeof(pmac->block));
    zeromem(pmac->Li,       sizeof(pmac->Li));
    zeromem(pmac->checksum, sizeof(pmac->checksum));
    err = CRYPT_OK;
error:
#ifdef LTC_CLEAN_STACK
    zeromem(L, pmac->block_len);
#endif
    XFREE(L);
    return err;
}
#endif
