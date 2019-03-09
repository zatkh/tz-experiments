#ifdef LTC_YARROW
struct yarrow_prng {
    int                   cipher, hash;
    unsigned char         pool[MAXBLOCKSIZE];
    symmetric_CTR         ctr;
    LTC_MUTEX_TYPE(prng_lock)
};
#endif
#ifdef LTC_RC4
struct rc4_prng {
    int x, y;
    unsigned char buf[256];
};
#endif
#ifdef LTC_FORTUNA
struct fortuna_prng {
    hash_state pool[LTC_FORTUNA_POOLS];     
    symmetric_key skey;
    unsigned char K[32],      
                  IV[16];     
    unsigned long pool_idx,   
                  pool0_len,  
                  wd;            
    ulong64       reset_cnt;  
    LTC_MUTEX_TYPE(prng_lock)
};
#endif
#ifdef LTC_SOBER128
struct sober128_prng {
    ulong32      R[17],          
                 initR[17],       
                 konst,          
                 sbuf;           
    int          nbuf,           
                 flag,           
                 set;            
};
#endif
typedef union Prng_state {
    char dummy[1];
#ifdef LTC_YARROW
    struct yarrow_prng    yarrow;
#endif
#ifdef LTC_RC4
    struct rc4_prng       rc4;
#endif
#ifdef LTC_FORTUNA
    struct fortuna_prng   fortuna;
#endif
#ifdef LTC_SOBER128
    struct sober128_prng  sober128;
#endif
} prng_state;
extern const struct ltc_prng_descriptor {
    const char *name;
    int  export_size;
    int (*start)(prng_state *prng);
    int (*add_entropy)(const unsigned char *in, unsigned long inlen, prng_state *prng);
    int (*ready)(prng_state *prng);
    unsigned long (*read)(unsigned char *out, unsigned long outlen, prng_state *prng);
    int (*done)(prng_state *prng);
    int (*pexport)(unsigned char *out, unsigned long *outlen, prng_state *prng);
    int (*pimport)(const unsigned char *in, unsigned long inlen, prng_state *prng);
    int (*test)(void);
} *prng_descriptor[];
#ifdef LTC_YARROW
int yarrow_start(prng_state *prng);
int yarrow_add_entropy(const unsigned char *in, unsigned long inlen, prng_state *prng);
int yarrow_ready(prng_state *prng);
unsigned long yarrow_read(unsigned char *out, unsigned long outlen, prng_state *prng);
int yarrow_done(prng_state *prng);
int  yarrow_export(unsigned char *out, unsigned long *outlen, prng_state *prng);
int  yarrow_import(const unsigned char *in, unsigned long inlen, prng_state *prng);
int  yarrow_test(void);
extern const struct ltc_prng_descriptor yarrow_desc;
#endif
#ifdef LTC_FORTUNA
int fortuna_start(prng_state *prng);
int fortuna_add_entropy(const unsigned char *in, unsigned long inlen, prng_state *prng);
int fortuna_ready(prng_state *prng);
unsigned long fortuna_read(unsigned char *out, unsigned long outlen, prng_state *prng);
int fortuna_done(prng_state *prng);
int  fortuna_export(unsigned char *out, unsigned long *outlen, prng_state *prng);
int  fortuna_import(const unsigned char *in, unsigned long inlen, prng_state *prng);
int  fortuna_test(void);
extern const struct ltc_prng_descriptor fortuna_desc;
#endif
#ifdef LTC_RC4
int rc4_start(prng_state *prng);
int rc4_add_entropy(const unsigned char *in, unsigned long inlen, prng_state *prng);
int rc4_ready(prng_state *prng);
unsigned long rc4_read(unsigned char *out, unsigned long outlen, prng_state *prng);
int  rc4_done(prng_state *prng);
int  rc4_export(unsigned char *out, unsigned long *outlen, prng_state *prng);
int  rc4_import(const unsigned char *in, unsigned long inlen, prng_state *prng);
int  rc4_test(void);
extern const struct ltc_prng_descriptor rc4_desc;
#endif
#ifdef LTC_SPRNG
int sprng_start(prng_state *prng);
int sprng_add_entropy(const unsigned char *in, unsigned long inlen, prng_state *prng);
int sprng_ready(prng_state *prng);
unsigned long sprng_read(unsigned char *out, unsigned long outlen, prng_state *prng);
int sprng_done(prng_state *prng);
int  sprng_export(unsigned char *out, unsigned long *outlen, prng_state *prng);
int  sprng_import(const unsigned char *in, unsigned long inlen, prng_state *prng);
int  sprng_test(void);
extern const struct ltc_prng_descriptor sprng_desc;
#endif
#ifdef LTC_SOBER128
int sober128_start(prng_state *prng);
int sober128_add_entropy(const unsigned char *in, unsigned long inlen, prng_state *prng);
int sober128_ready(prng_state *prng);
unsigned long sober128_read(unsigned char *out, unsigned long outlen, prng_state *prng);
int sober128_done(prng_state *prng);
int  sober128_export(unsigned char *out, unsigned long *outlen, prng_state *prng);
int  sober128_import(const unsigned char *in, unsigned long inlen, prng_state *prng);
int  sober128_test(void);
extern const struct ltc_prng_descriptor sober128_desc;
#endif
int find_prng(const char *name);
int register_prng(const struct ltc_prng_descriptor *prng);
int unregister_prng(const struct ltc_prng_descriptor *prng);
int prng_is_valid(int idx);
LTC_MUTEX_PROTO(ltc_prng_mutex)
unsigned long rng_get_bytes(unsigned char *out, 
                            unsigned long outlen, 
                            void (*callback)(void));
int rng_make_prng(int bits, int wprng, prng_state *prng, void (*callback)(void));
