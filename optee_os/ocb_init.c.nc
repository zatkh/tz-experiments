#include "tomcrypt.h"
#ifdef LTC_OCB_MODE
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
int ocb_init(ocb_state *ocb, int cipher, 
             const unsigned char *key, unsigned long keylen, const unsigned char *nonce)
{
   int poly, x, y, m, err;
   LTC_ARGCHK(ocb   != NULL);
   LTC_ARGCHK(key   != NULL);
   LTC_ARGCHK(nonce != NULL);
   if ((err = cipher_is_valid(cipher)) != CRYPT_OK) {
      return err;
   }
   ocb->block_len = cipher_descriptor[cipher].block_length;
   x = (int)(sizeof(polys)/sizeof(polys[0]));
   for (poly = 0; poly < x; poly++) {
       if (polys[poly].len == ocb->block_len) { 
          break;
       }
   }
   if (poly == x) {
      return CRYPT_INVALID_ARG; 
   }
   if (polys[poly].len != ocb->block_len) {
      return CRYPT_INVALID_ARG;
   }   
   if ((err = cipher_descriptor[cipher].setup(key, keylen, 0, &ocb->key)) != CRYPT_OK) {
      return err;
   }
   zeromem(ocb->L, ocb->block_len);
   if ((err = cipher_descriptor[cipher].ecb_encrypt(ocb->L, ocb->L, &ocb->key)) != CRYPT_OK) {
      return err;
   }
   for (x = 0; x < ocb->block_len; x++) {
       ocb->R[x] = ocb->L[x] ^ nonce[x];
   }
   if ((err = cipher_descriptor[cipher].ecb_encrypt(ocb->R, ocb->R, &ocb->key)) != CRYPT_OK) {
      return err;
   }
   XMEMCPY(ocb->Ls[0], ocb->L, ocb->block_len);
   for (x = 1; x < 32; x++) {
       m = ocb->Ls[x-1][0] >> 7;
       for (y = 0; y < ocb->block_len-1; y++) {
           ocb->Ls[x][y] = ((ocb->Ls[x-1][y] << 1) | (ocb->Ls[x-1][y+1] >> 7)) & 255;
       }
       ocb->Ls[x][ocb->block_len-1] = (ocb->Ls[x-1][ocb->block_len-1] << 1) & 255;
       if (m == 1) {
          for (y = 0; y < ocb->block_len; y++) {
              ocb->Ls[x][y] ^= polys[poly].poly_mul[y];
          }
       }
    }
    m = ocb->L[ocb->block_len-1] & 1;
    for (x = ocb->block_len - 1; x > 0; x--) {
        ocb->Lr[x] = ((ocb->L[x] >> 1) | (ocb->L[x-1] << 7)) & 255;
    }
    ocb->Lr[0] = ocb->L[0] >> 1;
    if (m == 1) {
       for (x = 0; x < ocb->block_len; x++) {
           ocb->Lr[x] ^= polys[poly].poly_div[x];
       }
    }
    zeromem(ocb->Li,       ocb->block_len);
    zeromem(ocb->checksum, ocb->block_len);
    ocb->block_index = 1;
    ocb->cipher      = cipher;
    return CRYPT_OK;
}
#endif
