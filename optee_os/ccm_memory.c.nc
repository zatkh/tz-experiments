#include "tomcrypt.h"
#ifdef LTC_CCM_MODE
int ccm_memory(int cipher,
    const unsigned char *key,    unsigned long keylen,
    symmetric_key       *uskey,
    const unsigned char *nonce,  unsigned long noncelen,
    const unsigned char *header, unsigned long headerlen,
          unsigned char *pt,     unsigned long ptlen,
          unsigned char *ct,
          unsigned char *tag,    unsigned long *taglen,
                    int  direction)
{
   unsigned char  PAD[16], ctr[16], CTRPAD[16], ptTag[16], b, *pt_real;
   unsigned char *pt_work = NULL;
   symmetric_key *skey;
   int            err;
   unsigned long  len, L, x, y, z, CTRlen;
#ifdef LTC_FAST
   LTC_FAST_TYPE fastMask = -1; 
#endif
   unsigned char mask = 0xff; 
   if (uskey == NULL) {
      LTC_ARGCHK(key    != NULL);
   }
   LTC_ARGCHK(nonce  != NULL);
   if (headerlen > 0) {
      LTC_ARGCHK(header != NULL);
   }
   LTC_ARGCHK(pt     != NULL);
   LTC_ARGCHK(ct     != NULL);
   LTC_ARGCHK(tag    != NULL);
   LTC_ARGCHK(taglen != NULL);
   pt_real = pt;
#ifdef LTC_FAST
   if (16 % sizeof(LTC_FAST_TYPE)) {
      return CRYPT_INVALID_ARG;
   }
#endif
   if ((err = cipher_is_valid(cipher)) != CRYPT_OK) {
      return err;
   }
   if (cipher_descriptor[cipher].block_length != 16) {
      return CRYPT_INVALID_CIPHER;
   }
   *taglen &= ~1;
   if (*taglen > 16) {
      *taglen = 16;
   }
   if (*taglen < 4) {
      return CRYPT_INVALID_ARG;
   }
   if (cipher_descriptor[cipher].accel_ccm_memory != NULL) {
       return cipher_descriptor[cipher].accel_ccm_memory(
           key,    keylen,
           uskey,
           nonce,  noncelen,
           header, headerlen,
           pt,     ptlen,
           ct,
           tag,    taglen,
           direction);
   }
   len = ptlen;
   L   = 0;
   while (len) {
      ++L;
      len >>= 8;
   }
   if (L <= 1) {
      L = 2;
   }
   noncelen = (noncelen > 13) ? 13 : noncelen;
   if ((15 - noncelen) > L) {
      L = 15 - noncelen;
   }
   if (uskey == NULL) {
      skey = XMALLOC(sizeof(*skey));
      if (skey == NULL) {
         return CRYPT_MEM;
      }
      if ((err = cipher_descriptor[cipher].setup(key, keylen, 0, skey)) != CRYPT_OK) {
         XFREE(skey);
         return err;
      }
   } else {
      skey = uskey;
   }
   if (direction == CCM_DECRYPT) {
      pt_work = XMALLOC(ptlen);
      if (pt_work == NULL) {
         goto error;
      }
      pt = pt_work;
   }
   x = 0;
   PAD[x++] = (unsigned char)(((headerlen > 0) ? (1<<6) : 0) |
            (((*taglen - 2)>>1)<<3)        |
            (L-1));
   for (y = 0; y < (16 - (L + 1)); y++) {
       PAD[x++] = nonce[y];
   }
   len = ptlen;
   for (y = L; y < 4; y++) {
       len <<= 8;
   }
   for (y = 0; L > 4 && (L-y)>4; y++) {
       PAD[x++] = 0;
   }
   for (; y < L; y++) {
       PAD[x++] = (unsigned char)((len >> 24) & 255);
       len <<= 8;
   }
   if ((err = cipher_descriptor[cipher].ecb_encrypt(PAD, PAD, skey)) != CRYPT_OK) {
       goto error;
   }
   if (headerlen > 0) {
      x = 0;
      if (headerlen < ((1UL<<16) - (1UL<<8))) {
         PAD[x++] ^= (headerlen>>8) & 255;
         PAD[x++] ^= headerlen & 255;
      } else {
         PAD[x++] ^= 0xFF;
         PAD[x++] ^= 0xFE;
         PAD[x++] ^= (headerlen>>24) & 255;
         PAD[x++] ^= (headerlen>>16) & 255;
         PAD[x++] ^= (headerlen>>8) & 255;
         PAD[x++] ^= headerlen & 255;
      }
      for (y = 0; y < headerlen; y++) {
          if (x == 16) {
             if ((err = cipher_descriptor[cipher].ecb_encrypt(PAD, PAD, skey)) != CRYPT_OK) {
                goto error;
             }
             x = 0;
          }
          PAD[x++] ^= header[y];
      }
      if ((err = cipher_descriptor[cipher].ecb_encrypt(PAD, PAD, skey)) != CRYPT_OK) {
         goto error;
      }
   }
   x = 0;
   ctr[x++] = (unsigned char)L-1;
   for (y = 0; y < (16 - (L+1)); ++y) {
      ctr[x++] = nonce[y];
   }
   while (x < 16) {
      ctr[x++] = 0;
   }
   x      = 0;
   CTRlen = 16;
   if (ptlen > 0) {
      y = 0;
#ifdef LTC_FAST
      if (ptlen & ~15)  {
          if (direction == CCM_ENCRYPT) {
             for (; y < (ptlen & ~15); y += 16) {
                for (z = 15; z > 15-L; z--) {
                    ctr[z] = (ctr[z] + 1) & 255;
                    if (ctr[z]) break;
                }
                if ((err = cipher_descriptor[cipher].ecb_encrypt(ctr, CTRPAD, skey)) != CRYPT_OK) {
                   goto error;
                }
                for (z = 0; z < 16; z += sizeof(LTC_FAST_TYPE)) {
                    *((LTC_FAST_TYPE*)(&PAD[z]))  ^= *((LTC_FAST_TYPE*)(&pt[y+z]));
                    *((LTC_FAST_TYPE*)(&ct[y+z])) = *((LTC_FAST_TYPE*)(&pt[y+z])) ^ *((LTC_FAST_TYPE*)(&CTRPAD[z]));
                }
                if ((err = cipher_descriptor[cipher].ecb_encrypt(PAD, PAD, skey)) != CRYPT_OK) {
                   goto error;
                }
             }
          } else { 
             for (; y < (ptlen & ~15); y += 16) {
                for (z = 15; z > 15-L; z--) {
                    ctr[z] = (ctr[z] + 1) & 255;
                    if (ctr[z]) break;
                }
                if ((err = cipher_descriptor[cipher].ecb_encrypt(ctr, CTRPAD, skey)) != CRYPT_OK) {
                   goto error;
                }
                for (z = 0; z < 16; z += sizeof(LTC_FAST_TYPE)) {
                    *((LTC_FAST_TYPE*)(&pt[y+z])) = *((LTC_FAST_TYPE*)(&ct[y+z])) ^ *((LTC_FAST_TYPE*)(&CTRPAD[z]));
                    *((LTC_FAST_TYPE*)(&PAD[z]))  ^= *((LTC_FAST_TYPE*)(&pt[y+z]));
                }
                if ((err = cipher_descriptor[cipher].ecb_encrypt(PAD, PAD, skey)) != CRYPT_OK) {
                   goto error;
                }
             }
         }
     }
#endif
      for (; y < ptlen; y++) {
          if (CTRlen == 16) {
             for (z = 15; z > 15-L; z--) {
                 ctr[z] = (ctr[z] + 1) & 255;
                 if (ctr[z]) break;
             }
             if ((err = cipher_descriptor[cipher].ecb_encrypt(ctr, CTRPAD, skey)) != CRYPT_OK) {
                goto error;
             }
             CTRlen = 0;
          }
          if (direction == CCM_ENCRYPT) {
             b     = pt[y];
             ct[y] = b ^ CTRPAD[CTRlen++];
          } else {
             b     = ct[y] ^ CTRPAD[CTRlen++];
             pt[y] = b;
          }
          if (x == 16) {
             if ((err = cipher_descriptor[cipher].ecb_encrypt(PAD, PAD, skey)) != CRYPT_OK) {
                goto error;
             }
             x = 0;
          }
          PAD[x++] ^= b;
      }
      if (x != 0) {
         if ((err = cipher_descriptor[cipher].ecb_encrypt(PAD, PAD, skey)) != CRYPT_OK) {
            goto error;
         }
      }
   }
   for (y = 15; y > 15 - L; y--) {
      ctr[y] = 0x00;
   }
   if ((err = cipher_descriptor[cipher].ecb_encrypt(ctr, CTRPAD, skey)) != CRYPT_OK) {
      goto error;
   }
   if (skey != uskey) {
      cipher_descriptor[cipher].done(skey);
   }
   if (direction == CCM_ENCRYPT) {
      for (x = 0; x < 16 && x < *taglen; x++) {
          tag[x] = PAD[x] ^ CTRPAD[x];
      }
      *taglen = x;
   } else { 
      for (x = 0; x < 16 && x < *taglen; x++) {
         ptTag[x] = tag[x] ^ CTRPAD[x];
      }
      *taglen = x;
      err = XMEM_NEQ(ptTag, PAD, *taglen);
      if (ptlen > 0) {
         y = 0;
         mask *= 1 - err; 
#ifdef LTC_FAST
         fastMask *= 1 - err;
         if (ptlen & ~15) {
            for (; y < (ptlen & ~15); y += 16) {
              for (z = 0; z < 16; z += sizeof(LTC_FAST_TYPE)) {
                *((LTC_FAST_TYPE*)(&pt_real[y+z])) = *((LTC_FAST_TYPE*)(&pt[y+z])) & fastMask;
              }
            }
         }
#endif
         for (; y < ptlen; y++) {
            pt_real[y] = pt[y] & mask;
         }
      }
   }
#ifdef LTC_CLEAN_STACK
   fastMask = 0;
   mask = 0;
   zeromem(skey,   sizeof(*skey));
   zeromem(PAD,    sizeof(PAD));
   zeromem(CTRPAD, sizeof(CTRPAD));
   if (pt_work != NULL) {
     zeromem(pt_work, ptlen);
   }
#endif
error:
   if (pt_work) {
      XFREE(pt_work);
   }
   if (skey != uskey) {
      XFREE(skey);
   }
   return err;
}
#endif
