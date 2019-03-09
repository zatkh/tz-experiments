#ifndef TOMCRYPT_H_
#define TOMCRYPT_H_
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <limits.h>
#include <stddef.h>  // for ptrdiff_t
#include <tomcrypt_custom.h>
#ifdef __cplusplus
extern "C" {
#endif
#define CRYPT   0x0117
#define SCRYPT  "1.17"
#define MAXBLOCKSIZE  128
#define TAB_SIZE      32
enum {
   CRYPT_OK=0,             
   CRYPT_ERROR,            
   CRYPT_NOP,              
   CRYPT_INVALID_KEYSIZE,  
   CRYPT_INVALID_ROUNDS,   
   CRYPT_FAIL_TESTVECTOR,  
   CRYPT_BUFFER_OVERFLOW,  
   CRYPT_INVALID_PACKET,   
   CRYPT_INVALID_PRNGSIZE, 
   CRYPT_ERROR_READPRNG,   
   CRYPT_INVALID_CIPHER,   
   CRYPT_INVALID_HASH,     
   CRYPT_INVALID_PRNG,     
   CRYPT_MEM,              
   CRYPT_PK_TYPE_MISMATCH, 
   CRYPT_PK_NOT_PRIVATE,   
   CRYPT_INVALID_ARG,      
   CRYPT_FILE_NOTFOUND,    
   CRYPT_PK_INVALID_TYPE,  
   CRYPT_PK_INVALID_SYSTEM,
   CRYPT_PK_DUP,           
   CRYPT_PK_NOT_FOUND,     
   CRYPT_PK_INVALID_SIZE,  
   CRYPT_INVALID_PRIME_SIZE,
   CRYPT_PK_INVALID_PADDING, 
   CRYPT_HASH_OVERFLOW      
};
#include <tomcrypt_cfg.h>
#include <tomcrypt_macros.h>
#include <tomcrypt_cipher.h>
#include <tomcrypt_hash.h>
#include <tomcrypt_mac.h>
#include <tomcrypt_prng.h>
#include <tomcrypt_pk.h>
#include <tomcrypt_math.h>
#include <tomcrypt_misc.h>
#include <tomcrypt_argchk.h>
#include <tomcrypt_pkcs.h>
#ifdef __cplusplus
   }
#endif
#endif 
