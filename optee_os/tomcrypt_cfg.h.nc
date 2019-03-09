#ifndef TOMCRYPT_CFG_H
#define TOMCRYPT_CFG_H
#if defined(_WIN32) || defined(_MSC_VER)
#define LTC_CALL __cdecl
#else
#ifndef LTC_CALL
   #define LTC_CALL
#endif
#endif
#ifndef LTC_EXPORT
#define LTC_EXPORT
#endif
#ifndef LTC_NO_PROTOTYPES
LTC_EXPORT void * LTC_CALL XMALLOC(size_t n);
LTC_EXPORT void * LTC_CALL XREALLOC(void *p, size_t n);
LTC_EXPORT void * LTC_CALL XCALLOC(size_t n, size_t s);
LTC_EXPORT void LTC_CALL XFREE(void *p);
LTC_EXPORT void LTC_CALL XQSORT(void *base, size_t nmemb, size_t size, int(*compar)(const void *, const void *));
LTC_EXPORT clock_t LTC_CALL XCLOCK(void);
LTC_EXPORT void * LTC_CALL XMEMCPY(void *dest, const void *src, size_t n);
LTC_EXPORT int   LTC_CALL XMEMCMP(const void *s1, const void *s2, size_t n);
LTC_EXPORT void * LTC_CALL XMEMSET(void *s, int c, size_t n);
LTC_EXPORT int   LTC_CALL XSTRCMP(const char *s1, const char *s2);
#endif
#define ARGTYPE  4
#ifndef ARGTYPE
   #define ARGTYPE  0
#endif
#if !defined(__STRICT_ANSI__) && !defined(__x86_64__) && !defined(_WIN64) && ((defined(_MSC_VER) && defined(WIN32)) || (defined(__GNUC__) && (defined(__DJGPP__) || defined(__CYGWIN__) || defined(__MINGW32__) || defined(__i386__))))
   #define ENDIAN_LITTLE
   #define ENDIAN_32BITWORD
   #define LTC_FAST
#endif
#if (defined(__R5900) || defined(R5900) || defined(__R5900__)) && (defined(_mips) || defined(__mips__) || defined(mips))
   #define ENDIAN_LITTLE
   #define ENDIAN_64BITWORD
#endif
#if !defined(__STRICT_ANSI__) && defined(__x86_64__)
   #define ENDIAN_LITTLE
   #define ENDIAN_64BITWORD
   #define LTC_FAST
#endif
#if !defined(__STRICT_ANSI__) && defined(LTC_PPC32)
   #define ENDIAN_BIG
   #define ENDIAN_32BITWORD
   #define LTC_FAST
#endif   
#if defined(__sparc__)
  #define ENDIAN_BIG
  #if defined(__arch64__)
    #define ENDIAN_64BITWORD
  #else
    #define ENDIAN_32BITWORD
  #endif
#endif
#ifdef LTC_NO_FAST
   #ifdef LTC_FAST
      #undef LTC_FAST
   #endif
#endif
#ifdef LTC_FAST
#if __GNUC__ < 4 
#error the LTC_FAST hack is only available on compilers that support __attribute__((may_alias)) - disable it for your compiler, and dont worry, it won`t buy you much anyway
#else
#ifdef ENDIAN_64BITWORD
typedef ulong64 __attribute__((__may_alias__)) LTC_FAST_TYPE;
#else
typedef ulong32 __attribute__((__may_alias__)) LTC_FAST_TYPE;
#endif
#endif
#endif 
#ifdef LTC_NO_ASM
   #undef ENDIAN_LITTLE
   #undef ENDIAN_BIG
   #undef ENDIAN_32BITWORD
   #undef ENDIAN_64BITWORD
   #undef LTC_FAST
   #undef LTC_FAST_TYPE
   #define LTC_NO_ROLC
	#define LTC_NO_BSWAP
#endif
#if (defined(ENDIAN_BIG) || defined(ENDIAN_LITTLE)) && !(defined(ENDIAN_32BITWORD) || defined(ENDIAN_64BITWORD))
    #error You must specify a word size as well as endianess in tomcrypt_cfg.h
#endif
#if !(defined(ENDIAN_BIG) || defined(ENDIAN_LITTLE))
   #define ENDIAN_NEUTRAL
#endif
#if (defined(ENDIAN_32BITWORD) && defined(ENDIAN_64BITWORD))
    #error Can not be 32 and 64 bit words...
#endif
#ifndef __has_builtin
   #define __has_builtin(x) 0
#endif
#if !defined(LTC_NO_BSWAP) && defined(__GNUC__) &&                      \
   ((__GNUC__ * 100 + __GNUC_MINOR__ >= 403) ||                         \
    (__has_builtin(__builtin_bswap32) && __has_builtin(__builtin_bswap64)))
   #define LTC_HAVE_BSWAP_BUILTIN
#endif
#endif
