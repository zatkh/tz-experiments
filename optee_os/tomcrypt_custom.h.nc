#ifndef TOMCRYPT_CUSTOM_H_
#define TOMCRYPT_CUSTOM_H_
#define LTC_NO_PROTOTYPES
#define LTC_SOURCE
#define LTC_NO_TABLES
#define LTC_NO_TEST
#ifndef XMALLOC
   #ifdef malloc 
   #define LTC_NO_PROTOTYPES
   #endif
#define XMALLOC  malloc
#endif
#ifndef XREALLOC
   #ifdef realloc 
   #define LTC_NO_PROTOTYPES
   #endif
#define XREALLOC realloc
#endif
#ifndef XCALLOC
   #ifdef calloc 
   #define LTC_NO_PROTOTYPES
   #endif
#define XCALLOC  calloc
#endif
#ifndef XFREE
   #ifdef free
   #define LTC_NO_PROTOTYPES
   #endif
#define XFREE    free
#endif
#ifndef XMEMSET
   #ifdef memset
   #define LTC_NO_PROTOTYPES
   #endif
#define XMEMSET  memset
#endif
#ifndef XMEMCPY
   #ifdef memcpy
   #define LTC_NO_PROTOTYPES
   #endif
#define XMEMCPY  memcpy
#endif
#ifndef XMEMCMP
   #ifdef memcmp 
   #define LTC_NO_PROTOTYPES
   #endif
#define XMEMCMP  memcmp
#endif
#ifndef XMEM_NEQ
#include <string_ext.h>
#define XMEM_NEQ  buf_compare_ct
#endif
#ifndef XSTRCMP
   #ifdef strcmp
   #define LTC_NO_PROTOTYPES
   #endif
#define XSTRCMP strcmp
#endif
#ifndef XCLOCK
#define XCLOCK   clock
#endif
#ifndef XCLOCKS_PER_SEC
#define XCLOCKS_PER_SEC CLOCKS_PER_SEC
#endif
#ifndef XQSORT
   #ifdef qsort
   #define LTC_NO_PROTOTYPES
   #endif
#define XQSORT qsort
#endif
#ifdef LTC_EASY
   #define LTC_NO_CIPHERS
   #define LTC_RIJNDAEL
   #define LTC_BLOWFISH
   #define LTC_DES
   #define LTC_CAST5
   #define LTC_NO_MODES
   #define LTC_ECB_MODE
   #define LTC_CBC_MODE
   #define LTC_CTR_MODE
   #define LTC_NO_HASHES
   #define LTC_SHA1
   #define LTC_SHA512
   #define LTC_SHA384
   #define LTC_SHA256
   #define LTC_SHA224
   #define LTC_NO_MACS
   #define LTC_HMAC
   #define LTC_OMAC
   #define LTC_CCM_MODE
   #define LTC_NO_PRNGS
   #define LTC_SPRNG
   #define LTC_DEVRANDOM
   #define LTC_TRY_URANDOM_FIRST
   #define LTC_NO_PK
   #define LTC_MRSA
   #define LTC_MECC
#endif   
#define LTC_NO_CIPHERS
#ifdef CFG_CRYPTO_AES
   #define LTC_RIJNDAEL
#endif
#ifdef CFG_CRYPTO_DES
   #define LTC_DES
#endif
#define LTC_NO_MODES
#ifdef CFG_CRYPTO_ECB
   #define LTC_ECB_MODE
#endif
#if defined(CFG_CRYPTO_CBC) || defined(CFG_CRYPTO_CBC_MAC)
   #define LTC_CBC_MODE
#endif
#ifdef CFG_CRYPTO_CTR
   #define LTC_CTR_MODE
#endif
#ifdef CFG_CRYPTO_XTS
   #define LTC_XTS_MODE
#endif
#define LTC_NO_HASHES
#ifdef CFG_CRYPTO_MD5
#define LTC_MD5
#endif
#ifdef CFG_CRYPTO_SHA1
#define LTC_SHA1
#endif
#ifdef CFG_CRYPTO_SHA1_ARM32_CE
#define LTC_SHA1_ARM32_CE
#endif
#ifdef CFG_CRYPTO_SHA1_ARM64_CE
#define LTC_SHA1_ARM64_CE
#endif
#ifdef CFG_CRYPTO_SHA224
#define LTC_SHA224
#endif
#ifdef CFG_CRYPTO_SHA256
#define LTC_SHA256
#endif
#ifdef CFG_CRYPTO_SHA256_ARM32_CE
#define LTC_SHA256_ARM32_CE
#endif
#ifdef CFG_CRYPTO_SHA256_ARM64_CE
#define LTC_SHA256_ARM64_CE
#endif
#ifdef CFG_CRYPTO_SHA384
#define LTC_SHA384
#endif
#ifdef CFG_CRYPTO_SHA512
#define LTC_SHA512
#endif
#define LTC_NO_MACS
#ifdef CFG_CRYPTO_HMAC
   #define LTC_HMAC
#endif
#ifdef CFG_CRYPTO_CMAC
   #define LTC_OMAC
#endif
#ifdef CFG_CRYPTO_CCM
   #define LTC_CCM_MODE
#endif
#ifdef CFG_CRYPTO_AES_GCM_FROM_CRYPTOLIB
   #define LTC_GCM_MODE
#endif
#define LTC_NO_PK
#ifdef CFG_CRYPTO_RSA
   #define LTC_MRSA
#endif
#ifdef CFG_CRYPTO_DSA
   #define LTC_MDSA
#endif
#ifdef CFG_CRYPTO_DH
   #define LTC_MDH
#endif
#ifdef CFG_CRYPTO_ECC
   #define LTC_MECC
   #define LTC_ECC_SHAMIR
   #if defined(TFM_LTC_DESC) && defined(LTC_MECC)
   #define LTC_MECC_ACCEL
   #endif
   #define LTC_ECC_TIMING_RESISTANT
   #define LTC_ECC192
   #define LTC_ECC224
   #define LTC_ECC256
   #define LTC_ECC384
   #define LTC_ECC521
   #define LTC_MAX_ECC 521
#endif
#define LTC_NO_PKCS
#if defined(CFG_CRYPTO_RSA) || defined(CFG_CRYPTO_DSA) || \
	    defined(CFG_CRYPTO_ECC)
   #define LTC_DER
#endif
#ifndef LTC_NO_TEST
   #define LTC_TEST
#endif
#define LTC_NO_FILE
#define LTC_NO_ASM
#ifndef LTC_NO_CIPHERS
#define LTC_RIJNDAEL
#define LTC_DES
#endif
#ifndef LTC_NO_MODES
#define LTC_CFB_MODE
#define LTC_OFB_MODE
#define LTC_ECB_MODE
#define LTC_CBC_MODE
#define LTC_CTR_MODE
#define LTC_F8_MODE
#define LTC_LRW_MODE
#ifndef LTC_NO_TABLES
   #define LTC_LRW_TABLES
#endif
#define LTC_XTS_MODE
#endif 
#ifndef LTC_NO_HASHES 
#define LTC_SHA512
#define LTC_SHA384
#define LTC_SHA256
#define LTC_SHA224
#define LTC_SHA1
#define LTC_MD5
#endif 
#ifndef LTC_NO_MACS
#define LTC_HMAC
#define LTC_OMAC
#define LTC_PMAC
#define LTC_XCBC
#define LTC_EAX_MODE
#if defined(LTC_EAX_MODE) && !(defined(LTC_CTR_MODE) && defined(LTC_OMAC))
   #error LTC_EAX_MODE requires CTR and LTC_OMAC mode
#endif
#define LTC_OCB_MODE
#define LTC_CCM_MODE
#define LTC_GCM_MODE
#ifndef LTC_NO_TABLES
   #define LTC_GCM_TABLES 
#endif
#ifdef LTC_GCM_TABLES
#endif
#endif 
#define LTC_BASE64
#ifndef LTC_NO_PRNGS
#define LTC_SPRNG
#define LTC_RC4
#define LTC_FORTUNA
#define LTC_FORTUNA_WD    10
#define LTC_FORTUNA_POOLS 32
#define LTC_DEVRANDOM
#define LTC_TRY_URANDOM_FIRST
#endif 
#ifndef LTC_NO_PK
#define LTC_MRSA
#define LTC_MDH
#define LTC_MDSA
#define LTC_MECC
#define LTC_ECC_SHAMIR
#if defined(TFM_LTC_DESC) && defined(LTC_MECC)
   #define LTC_MECC_ACCEL
#endif   
#endif 
#if defined(LTC_MRSA)
#define LTC_DER_MAX_PUBKEY_SIZE MAX_RSA_SIZE
#elif !defined(LTC_DER_MAX_PUBKEY_SIZE)
#define LTC_DER_MAX_PUBKEY_SIZE 1024
#endif
#ifndef LTC_NO_PKCS
#define LTC_PKCS_1
#define LTC_PKCS_5
#define LTC_DER
#endif 
#if defined(LTC_MECC) || defined(LTC_MRSA) || defined(LTC_MDSA) || \
	defined(MKATJA) || defined(LTC_MDH)
   #define LTC_MPI
#endif
#ifdef LTC_MRSA
   #define LTC_PKCS_1
#endif   
#if defined(LTC_DER) && !defined(LTC_MPI)
   #error ASN.1 DER requires MPI functionality
#endif
#if (defined(LTC_MDSA) || defined(LTC_MRSA) || defined(LTC_MECC) || defined(MKATJA)) && !defined(LTC_DER)
   #error PK requires ASN.1 DER functionality, make sure LTC_DER is enabled
#endif
#if defined(CFG_LTC_OPTEE_THREAD)
#include <kernel/mutex.h>
#define LTC_MUTEX_GLOBAL(x)   struct mutex x = MUTEX_INITIALIZER;
#define LTC_MUTEX_PROTO(x)    extern struct mutex x;
#define LTC_MUTEX_TYPE(x)     struct mutex x;
#define LTC_MUTEX_INIT(x)     mutex_init(x);
#define LTC_MUTEX_LOCK(x)     mutex_lock(x);
#define LTC_MUTEX_UNLOCK(x)   mutex_unlock(x);
#elif defined(LTC_PTHREAD)
#include <pthread.h>
#define LTC_MUTEX_GLOBAL(x)   pthread_mutex_t x = PTHREAD_MUTEX_INITIALIZER;
#define LTC_MUTEX_PROTO(x)    extern pthread_mutex_t x;
#define LTC_MUTEX_TYPE(x)     pthread_mutex_t x;
#define LTC_MUTEX_INIT(x)     pthread_mutex_init(x, NULL);
#define LTC_MUTEX_LOCK(x)     pthread_mutex_lock(x);
#define LTC_MUTEX_UNLOCK(x)   pthread_mutex_unlock(x);
#else
#define LTC_MUTEX_GLOBAL(x)
#define LTC_MUTEX_PROTO(x)
#define LTC_MUTEX_TYPE(x)
#define LTC_MUTEX_INIT(x)
#define LTC_MUTEX_LOCK(x)
#define LTC_MUTEX_UNLOCK(x)
#endif
#define LTC_LINARO_FIX_DH
#define LTC_LINARO_FIX_XTS
#endif
