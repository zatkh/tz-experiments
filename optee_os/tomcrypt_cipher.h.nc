#ifdef LTC_RIJNDAEL
struct rijndael_key {
   ulong32 eK[60], dK[60];
   int Nr;
};
#endif
#ifdef LTC_DES
struct des_key {
    ulong32 ek[32], dk[32];
};
struct des3_key {
    ulong32 ek[3][32], dk[3][32];
};
#endif
typedef union Symmetric_key {
#ifdef LTC_DES
   struct des_key des;
   struct des3_key des3;
#endif
#ifdef LTC_RIJNDAEL
   struct rijndael_key rijndael;
#endif
   void   *data;
} symmetric_key;
#ifdef LTC_ECB_MODE
typedef struct {
   int                 cipher, 
                       blocklen;
   symmetric_key       key;
} symmetric_ECB;
#endif
#ifdef LTC_CFB_MODE
typedef struct {
   int                 cipher, 
                       blocklen, 
                       padlen;
   unsigned char       IV[MAXBLOCKSIZE], 
                       pad[MAXBLOCKSIZE];
   symmetric_key       key;
} symmetric_CFB;
#endif
#ifdef LTC_OFB_MODE
typedef struct {
   int                 cipher, 
                       blocklen, 
                       padlen;
   unsigned char       IV[MAXBLOCKSIZE];
   symmetric_key       key;
} symmetric_OFB;
#endif
#ifdef LTC_CBC_MODE
typedef struct {
   int                 cipher, 
                       blocklen;
   unsigned char       IV[MAXBLOCKSIZE];
   symmetric_key       key;
} symmetric_CBC;
#endif
#ifdef LTC_CTR_MODE
typedef struct {
   int                 cipher,
                       blocklen, 
                       padlen, 
                       mode,
                       ctrlen;
   unsigned char       ctr[MAXBLOCKSIZE], 
                       pad[MAXBLOCKSIZE];
   symmetric_key       key;
} symmetric_CTR;
#endif
#ifdef LTC_LRW_MODE
typedef struct {
    int               cipher;
    unsigned char     IV[16],
                      tweak[16],
                      pad[16];
    symmetric_key     key;
#ifdef LTC_LRW_TABLES
    unsigned char     PC[16][256][16];
#endif
} symmetric_LRW;
#endif
#ifdef LTC_F8_MODE
typedef struct {
   int                 cipher, 
                       blocklen, 
                       padlen;
   unsigned char       IV[MAXBLOCKSIZE],
                       MIV[MAXBLOCKSIZE];
   ulong32             blockcnt;
   symmetric_key       key;
} symmetric_F8;
#endif
extern const struct ltc_cipher_descriptor {
   const char *name;
   unsigned char ID;
   int  min_key_length, 
        max_key_length, 
        block_length, 
        default_rounds;
   int  (*setup)(const unsigned char *key, int keylen, int num_rounds, symmetric_key *skey);
   int (*ecb_encrypt)(const unsigned char *pt, unsigned char *ct, symmetric_key *skey);
   int (*ecb_decrypt)(const unsigned char *ct, unsigned char *pt, symmetric_key *skey);
   int (*test)(void);
   void (*done)(symmetric_key *skey);      
   int  (*keysize)(int *keysize);
   int (*accel_ecb_encrypt)(const unsigned char *pt, unsigned char *ct, unsigned long blocks, symmetric_key *skey);
   int (*accel_ecb_decrypt)(const unsigned char *ct, unsigned char *pt, unsigned long blocks, symmetric_key *skey);
   int (*accel_cbc_encrypt)(const unsigned char *pt, unsigned char *ct, unsigned long blocks, unsigned char *IV, symmetric_key *skey);
   int (*accel_cbc_decrypt)(const unsigned char *ct, unsigned char *pt, unsigned long blocks, unsigned char *IV, symmetric_key *skey);
   int (*accel_ctr_encrypt)(const unsigned char *pt, unsigned char *ct, unsigned long blocks, unsigned char *IV, int mode, symmetric_key *skey);
   int (*accel_lrw_encrypt)(const unsigned char *pt, unsigned char *ct, unsigned long blocks, unsigned char *IV, const unsigned char *tweak, symmetric_key *skey);
   int (*accel_lrw_decrypt)(const unsigned char *ct, unsigned char *pt, unsigned long blocks, unsigned char *IV, const unsigned char *tweak, symmetric_key *skey);
   int (*accel_ccm_memory)(
       const unsigned char *key,    unsigned long keylen,
       symmetric_key       *uskey,
       const unsigned char *nonce,  unsigned long noncelen,
       const unsigned char *header, unsigned long headerlen,
             unsigned char *pt,     unsigned long ptlen,
             unsigned char *ct,
             unsigned char *tag,    unsigned long *taglen,
                       int  direction);
   int (*accel_gcm_memory)(
       const unsigned char *key,    unsigned long keylen,
       const unsigned char *IV,     unsigned long IVlen,
       const unsigned char *adata,  unsigned long adatalen,
             unsigned char *pt,     unsigned long ptlen,
             unsigned char *ct, 
             unsigned char *tag,    unsigned long *taglen,
                       int direction);
   int (*omac_memory)(
       const unsigned char *key, unsigned long keylen,
       const unsigned char *in,  unsigned long inlen,
             unsigned char *out, unsigned long *outlen);
   int (*xcbc_memory)(
       const unsigned char *key, unsigned long keylen,
       const unsigned char *in,  unsigned long inlen,
             unsigned char *out, unsigned long *outlen);
   int (*f9_memory)(
       const unsigned char *key, unsigned long keylen,
       const unsigned char *in,  unsigned long inlen,
             unsigned char *out, unsigned long *outlen);
    int (*accel_xts_encrypt)(const unsigned char *pt, unsigned char *ct,
        unsigned long blocks, unsigned char *tweak, symmetric_key *skey1,
        symmetric_key *skey2);
     int (*accel_xts_decrypt)(const unsigned char *ct, unsigned char *pt,
         unsigned long blocks, unsigned char *tweak, symmetric_key *skey1,
         symmetric_key *skey2);
} *cipher_descriptor[];
#define aes_setup           rijndael_setup
#define aes_ecb_encrypt     rijndael_ecb_encrypt
#define aes_ecb_decrypt     rijndael_ecb_decrypt
#define aes_test            rijndael_test
#define aes_done            rijndael_done
#define aes_keysize         rijndael_keysize
#define aes_enc_setup           rijndael_enc_setup
#define aes_enc_ecb_encrypt     rijndael_enc_ecb_encrypt
#define aes_enc_keysize         rijndael_enc_keysize
int rijndael_setup(const unsigned char *key, int keylen, int num_rounds, symmetric_key *skey);
int rijndael_ecb_encrypt(const unsigned char *pt, unsigned char *ct, symmetric_key *skey);
int rijndael_ecb_decrypt(const unsigned char *ct, unsigned char *pt, symmetric_key *skey);
int rijndael_test(void);
void rijndael_done(symmetric_key *skey);
int rijndael_keysize(int *keysize);
int rijndael_enc_setup(const unsigned char *key, int keylen, int num_rounds, symmetric_key *skey);
int rijndael_enc_ecb_encrypt(const unsigned char *pt, unsigned char *ct, symmetric_key *skey);
void rijndael_enc_done(symmetric_key *skey);
int rijndael_enc_keysize(int *keysize);
extern const struct ltc_cipher_descriptor rijndael_desc, aes_desc;
extern const struct ltc_cipher_descriptor rijndael_enc_desc, aes_enc_desc;
int des_setup(const unsigned char *key, int keylen, int num_rounds, symmetric_key *skey);
int des_ecb_encrypt(const unsigned char *pt, unsigned char *ct, symmetric_key *skey);
int des_ecb_decrypt(const unsigned char *ct, unsigned char *pt, symmetric_key *skey);
int des_test(void);
void des_done(symmetric_key *skey);
int des_keysize(int *keysize);
int des3_setup(const unsigned char *key, int keylen, int num_rounds, symmetric_key *skey);
int des3_ecb_encrypt(const unsigned char *pt, unsigned char *ct, symmetric_key *skey);
int des3_ecb_decrypt(const unsigned char *ct, unsigned char *pt, symmetric_key *skey);
int des3_test(void);
void des3_done(symmetric_key *skey);
int des3_keysize(int *keysize);
extern const struct ltc_cipher_descriptor des_desc, des3_desc;
#ifdef LTC_ECB_MODE
int ecb_start(int cipher, const unsigned char *key, 
              int keylen, int num_rounds, symmetric_ECB *ecb);
int ecb_encrypt(const unsigned char *pt, unsigned char *ct, unsigned long len, symmetric_ECB *ecb);
int ecb_decrypt(const unsigned char *ct, unsigned char *pt, unsigned long len, symmetric_ECB *ecb);
int ecb_done(symmetric_ECB *ecb);
#endif
#ifdef LTC_CFB_MODE
int cfb_start(int cipher, const unsigned char *IV, const unsigned char *key, 
              int keylen, int num_rounds, symmetric_CFB *cfb);
int cfb_encrypt(const unsigned char *pt, unsigned char *ct, unsigned long len, symmetric_CFB *cfb);
int cfb_decrypt(const unsigned char *ct, unsigned char *pt, unsigned long len, symmetric_CFB *cfb);
int cfb_getiv(unsigned char *IV, unsigned long *len, symmetric_CFB *cfb);
int cfb_setiv(const unsigned char *IV, unsigned long len, symmetric_CFB *cfb);
int cfb_done(symmetric_CFB *cfb);
#endif
#ifdef LTC_OFB_MODE
int ofb_start(int cipher, const unsigned char *IV, const unsigned char *key, 
              int keylen, int num_rounds, symmetric_OFB *ofb);
int ofb_encrypt(const unsigned char *pt, unsigned char *ct, unsigned long len, symmetric_OFB *ofb);
int ofb_decrypt(const unsigned char *ct, unsigned char *pt, unsigned long len, symmetric_OFB *ofb);
int ofb_getiv(unsigned char *IV, unsigned long *len, symmetric_OFB *ofb);
int ofb_setiv(const unsigned char *IV, unsigned long len, symmetric_OFB *ofb);
int ofb_done(symmetric_OFB *ofb);
#endif
#ifdef LTC_CBC_MODE
int cbc_start(int cipher, const unsigned char *IV, const unsigned char *key,
               int keylen, int num_rounds, symmetric_CBC *cbc);
int cbc_encrypt(const unsigned char *pt, unsigned char *ct, unsigned long len, symmetric_CBC *cbc);
int cbc_decrypt(const unsigned char *ct, unsigned char *pt, unsigned long len, symmetric_CBC *cbc);
int cbc_getiv(unsigned char *IV, unsigned long *len, symmetric_CBC *cbc);
int cbc_setiv(const unsigned char *IV, unsigned long len, symmetric_CBC *cbc);
int cbc_done(symmetric_CBC *cbc);
#endif
#ifdef LTC_CTR_MODE
#define CTR_COUNTER_LITTLE_ENDIAN    0x0000
#define CTR_COUNTER_BIG_ENDIAN       0x1000
#define LTC_CTR_RFC3686              0x2000
int ctr_start(               int   cipher,
              const unsigned char *IV,
              const unsigned char *key,       int keylen,
                             int  num_rounds, int ctr_mode,
                   symmetric_CTR *ctr);
int ctr_encrypt(const unsigned char *pt, unsigned char *ct, unsigned long len, symmetric_CTR *ctr);
int ctr_decrypt(const unsigned char *ct, unsigned char *pt, unsigned long len, symmetric_CTR *ctr);
int ctr_getiv(unsigned char *IV, unsigned long *len, symmetric_CTR *ctr);
int ctr_setiv(const unsigned char *IV, unsigned long len, symmetric_CTR *ctr);
int ctr_done(symmetric_CTR *ctr);
int ctr_test(void);
#endif
#ifdef LTC_LRW_MODE
#define LRW_ENCRYPT 0
#define LRW_DECRYPT 1
int lrw_start(               int   cipher,
              const unsigned char *IV,
              const unsigned char *key,       int keylen,
              const unsigned char *tweak,
                             int  num_rounds, 
                   symmetric_LRW *lrw);
int lrw_encrypt(const unsigned char *pt, unsigned char *ct, unsigned long len, symmetric_LRW *lrw);
int lrw_decrypt(const unsigned char *ct, unsigned char *pt, unsigned long len, symmetric_LRW *lrw);
int lrw_getiv(unsigned char *IV, unsigned long *len, symmetric_LRW *lrw);
int lrw_setiv(const unsigned char *IV, unsigned long len, symmetric_LRW *lrw);
int lrw_done(symmetric_LRW *lrw);
int lrw_test(void);
int lrw_process(const unsigned char *pt, unsigned char *ct, unsigned long len, int mode, symmetric_LRW *lrw);
#endif    
#ifdef LTC_F8_MODE
int f8_start(                int  cipher, const unsigned char *IV, 
             const unsigned char *key,                    int  keylen, 
             const unsigned char *salt_key,               int  skeylen,
                             int  num_rounds,   symmetric_F8  *f8);
int f8_encrypt(const unsigned char *pt, unsigned char *ct, unsigned long len, symmetric_F8 *f8);
int f8_decrypt(const unsigned char *ct, unsigned char *pt, unsigned long len, symmetric_F8 *f8);
int f8_getiv(unsigned char *IV, unsigned long *len, symmetric_F8 *f8);
int f8_setiv(const unsigned char *IV, unsigned long len, symmetric_F8 *f8);
int f8_done(symmetric_F8 *f8);
int f8_test_mode(void);
#endif
#ifdef LTC_XTS_MODE
typedef struct {
   symmetric_key  key1, key2;
   int            cipher;
} symmetric_xts;
int xts_start(                int  cipher,
              const unsigned char *key1, 
              const unsigned char *key2, 
                    unsigned long  keylen,
                              int  num_rounds, 
                    symmetric_xts *xts);
int xts_encrypt(
   const unsigned char *pt, unsigned long ptlen,
         unsigned char *ct,
         unsigned char *tweak,
         symmetric_xts *xts);
int xts_decrypt(
   const unsigned char *ct, unsigned long ptlen,
         unsigned char *pt,
         unsigned char *tweak,
         symmetric_xts *xts);
void xts_done(symmetric_xts *xts);
int  xts_test(void);
void xts_mult_x(unsigned char *I);
#endif
int find_cipher(const char *name);
int find_cipher_any(const char *name, int blocklen, int keylen);
int find_cipher_id(unsigned char ID);
int register_cipher(const struct ltc_cipher_descriptor *cipher);
int unregister_cipher(const struct ltc_cipher_descriptor *cipher);
int cipher_is_valid(int idx);
LTC_MUTEX_PROTO(ltc_cipher_mutex)
