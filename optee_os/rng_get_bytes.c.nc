#include "tomcrypt.h"
#ifdef LTC_DEVRANDOM
static unsigned long rng_nix(unsigned char *buf, unsigned long len, 
                             void (*callback)(void))
{
#ifdef LTC_NO_FILE
    LTC_UNUSED_PARAM(callback);
    LTC_UNUSED_PARAM(buf);
    LTC_UNUSED_PARAM(len);
    return 0;
#else
    FILE *f;
    unsigned long x;
    LTC_UNUSED_PARAM(callback);
#ifdef LTC_TRY_URANDOM_FIRST
    f = fopen("/dev/urandom", "rb");
    if (f == NULL)
#endif 
       f = fopen("/dev/random", "rb");
    if (f == NULL) {
       return 0;
    }
    if (setvbuf(f, NULL, _IONBF, 0) != 0) {
       fclose(f);
       return 0;
    }   
    x = (unsigned long)fread(buf, 1, (size_t)len, f);
    fclose(f);
    return x;
#endif 
}
#endif 
#if defined(CLOCKS_PER_SEC) && !defined(WINCE)
#define ANSI_RNG
static unsigned long rng_ansic(unsigned char *buf, unsigned long len, 
                               void (*callback)(void))
{
   clock_t t1;
   int l, acc, bits, a, b;
   if (XCLOCKS_PER_SEC < 100 || XCLOCKS_PER_SEC > 10000) {
      return 0;
   }
   l = len;
   bits = 8;
   acc  = a = b = 0;
   while (len--) {
       if (callback != NULL) callback();
       while (bits--) {
          do {
             t1 = XCLOCK(); while (t1 == XCLOCK()) a ^= 1;
             t1 = XCLOCK(); while (t1 == XCLOCK()) b ^= 1;
          } while (a == b);
          acc = (acc << 1) | a;
       }
       *buf++ = acc; 
       acc  = 0;
       bits = 8;
   }
   acc = bits = a = b = 0;
   return l;
}
#endif 
#if defined(WIN32) || defined(_WIN32) || defined(WINCE)
#ifndef _WIN32_WINNT
  #define _WIN32_WINNT 0x0400
#endif
#ifdef WINCE
   #define UNDER_CE
   #define ARM
#endif
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <wincrypt.h>
static unsigned long rng_win32(unsigned char *buf, unsigned long len, 
                               void (*callback)(void))
{
   HCRYPTPROV hProv = 0;
   LTC_UNUSED_PARAM(callback);
   if (!CryptAcquireContext(&hProv, NULL, MS_DEF_PROV, PROV_RSA_FULL, 
                            (CRYPT_VERIFYCONTEXT | CRYPT_MACHINE_KEYSET)) && 
       !CryptAcquireContext (&hProv, NULL, MS_DEF_PROV, PROV_RSA_FULL, 
                            CRYPT_VERIFYCONTEXT | CRYPT_MACHINE_KEYSET | CRYPT_NEWKEYSET))
      return 0;
   if (CryptGenRandom(hProv, len, buf) == TRUE) {
      CryptReleaseContext(hProv, 0);
      return len;
   } else {
      CryptReleaseContext(hProv, 0);
      return 0;
   }
}
#endif 
unsigned long rng_get_bytes(unsigned char *out, unsigned long outlen, 
                            void (*callback)(void))
{
   unsigned long x;
   LTC_ARGCHK(out != NULL);
#if defined(LTC_DEVRANDOM)
   x = rng_nix(out, outlen, callback);   if (x != 0) { return x; }
#endif
#if defined(WIN32) || defined(_WIN32) || defined(WINCE)
   x = rng_win32(out, outlen, callback); if (x != 0) { return x; }
#endif
#ifdef ANSI_RNG
   x = rng_ansic(out, outlen, callback); if (x != 0) { return x; }
#endif
   return 0;
}
