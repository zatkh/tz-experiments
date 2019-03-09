#define LTC_MP_LT   -1
#define LTC_MP_EQ    0
#define LTC_MP_GT    1
#define LTC_MP_NO    0
#define LTC_MP_YES   1
#ifndef LTC_MECC
   typedef void ecc_point;
#endif
#ifndef LTC_MRSA
   typedef void rsa_key;
#endif
typedef struct {
   const char *name;
   int  bits_per_digit;
   int (*init)(void **a);
   int (*init_size)(int size_bits, void **a);
   int (*init_copy)(void **dst, void *src);
   void (*deinit)(void *a);
   int (*neg)(void *src, void *dst);
   int (*copy)(void *src, void *dst);
   int (*set_int)(void *a, unsigned long n);
   unsigned long (*get_int)(void *a);
   ltc_mp_digit (*get_digit)(void *a, int n);
   int (*get_digit_count)(void *a);
   int (*compare)(void *a, void *b);
   int (*compare_d)(void *a, unsigned long n);
   int (*count_bits)(void * a);
   int (*count_lsb_bits)(void *a);
   int (*twoexpt)(void *a , int n);
   int (*read_radix)(void *a, const char *str, int radix);
   int (*write_radix)(void *a, char *str, int radix);
   unsigned long (*unsigned_size)(void *a);
   int (*unsigned_write)(void *src, unsigned char *dst);
   int (*unsigned_read)(void *dst, unsigned char *src, unsigned long len);
   int (*add)(void *a, void *b, void *c);
   int (*addi)(void *a, unsigned long b, void *c);
   int (*sub)(void *a, void *b, void *c);
   int (*subi)(void *a, unsigned long b, void *c);
   int (*mul)(void *a, void *b, void *c);
   int (*muli)(void *a, unsigned long b, void *c);
   int (*sqr)(void *a, void *b);
   int (*mpdiv)(void *a, void *b, void *c, void *d);
   int (*div_2)(void *a, void *b);
   int (*modi)(void *a, unsigned long b, unsigned long *c);
   int (*gcd)(void *a, void *b, void *c);
   int (*lcm)(void *a, void *b, void *c);
   int (*mod)(void *a, void *b, void *c);
   int (*mulmod)(void *a, void *b, void *c, void *d);
   int (*sqrmod)(void *a, void *b, void *c);
   int (*invmod)(void *, void *, void *);
   int (*montgomery_setup)(void *a, void **b);
   int (*montgomery_normalization)(void *a, void *b);
   int (*montgomery_reduce)(void *a, void *b, void *c);
   void (*montgomery_deinit)(void *a);
   int (*exptmod)(void *a, void *b, void *c, void *d);
   int (*isprime)(void *a, int b, int *c);
   int (*ecc_ptmul)(void *k, ecc_point *G, ecc_point *R, void *modulus, int map);
   int (*ecc_ptadd)(ecc_point *P, ecc_point *Q, ecc_point *R, void *modulus, void *mp);
   int (*ecc_ptdbl)(ecc_point *P, ecc_point *R, void *modulus, void *mp);
   int (*ecc_map)(ecc_point *P, void *modulus, void *mp);
   int (*ecc_mul2add)(ecc_point *A, void *kA,
                      ecc_point *B, void *kB,
                      ecc_point *C,
                           void *modulus);
    int (*rsa_keygen)(prng_state *prng, int wprng, int size, long e, rsa_key *key);
   int (*rsa_me)(const unsigned char *in,   unsigned long inlen,
                       unsigned char *out,  unsigned long *outlen, int which,
                       rsa_key *key);
   int (*rand)(void *a, int size);
} ltc_math_descriptor;
extern ltc_math_descriptor ltc_mp;
int ltc_init_multi(void **a, ...);
int ltc_init_multi_size(int size_bits, void **a, ...);
void ltc_deinit_multi(void *a, ...);
#ifdef LTM_DESC
extern const ltc_math_descriptor ltm_desc;
#endif
#ifdef TFM_DESC
extern const ltc_math_descriptor tfm_desc;
#endif
#ifdef GMP_DESC
extern const ltc_math_descriptor gmp_desc;
#endif
#if !defined(DESC_DEF_ONLY) && defined(LTC_SOURCE)
#define MP_DIGIT_BIT                 ltc_mp.bits_per_digit
#define mp_init(a)                   ltc_mp.init(a)
#define mp_init_multi                ltc_init_multi
#define mp_init_size(a, b)           ltc_mp.init_size(a, b)
#define mp_init_multi_size           ltc_init_multi_size
#define mp_clear(a)                  ltc_mp.deinit(a)
#define mp_clear_multi               ltc_deinit_multi
#define mp_init_copy(a, b)           ltc_mp.init_copy(a, b)
#define mp_neg(a, b)                 ltc_mp.neg(a, b)
#define mp_copy(a, b)                ltc_mp.copy(a, b)
#define mp_set(a, b)                 ltc_mp.set_int(a, b)
#define mp_set_int(a, b)             ltc_mp.set_int(a, b)
#define mp_get_int(a)                ltc_mp.get_int(a)
#define mp_get_digit(a, n)           ltc_mp.get_digit(a, n)
#define mp_get_digit_count(a)        ltc_mp.get_digit_count(a)
#define mp_cmp(a, b)                 ltc_mp.compare(a, b)
#define mp_cmp_d(a, b)               ltc_mp.compare_d(a, b)
#define mp_count_bits(a)             ltc_mp.count_bits(a)
#define mp_cnt_lsb(a)                ltc_mp.count_lsb_bits(a)
#define mp_2expt(a, b)               ltc_mp.twoexpt(a, b)
#define mp_read_radix(a, b, c)       ltc_mp.read_radix(a, b, c)
#define mp_toradix(a, b, c)          ltc_mp.write_radix(a, b, c)
#define mp_unsigned_bin_size(a)      ltc_mp.unsigned_size(a)
#define mp_to_unsigned_bin(a, b)     ltc_mp.unsigned_write(a, b)
#define mp_read_unsigned_bin(a, b, c) ltc_mp.unsigned_read(a, b, c)
#define mp_add(a, b, c)              ltc_mp.add(a, b, c)
#define mp_add_d(a, b, c)            ltc_mp.addi(a, b, c)
#define mp_sub(a, b, c)              ltc_mp.sub(a, b, c)
#define mp_sub_d(a, b, c)            ltc_mp.subi(a, b, c)
#define mp_mul(a, b, c)              ltc_mp.mul(a, b, c)
#define mp_mul_d(a, b, c)            ltc_mp.muli(a, b, c)
#define mp_sqr(a, b)                 ltc_mp.sqr(a, b)
#define mp_div(a, b, c, d)           ltc_mp.mpdiv(a, b, c, d)
#define mp_div_2(a, b)               ltc_mp.div_2(a, b)
#define mp_mod(a, b, c)              ltc_mp.mod(a, b, c)
#define mp_mod_d(a, b, c)            ltc_mp.modi(a, b, c)
#define mp_gcd(a, b, c)              ltc_mp.gcd(a, b, c)
#define mp_lcm(a, b, c)              ltc_mp.lcm(a, b, c)
#define mp_mulmod(a, b, c, d)        ltc_mp.mulmod(a, b, c, d)
#define mp_sqrmod(a, b, c)           ltc_mp.sqrmod(a, b, c)
#define mp_invmod(a, b, c)           ltc_mp.invmod(a, b, c)
#define mp_montgomery_setup(a, b)    ltc_mp.montgomery_setup(a, b)
#define mp_montgomery_normalization(a, b) ltc_mp.montgomery_normalization(a, b)
#define mp_montgomery_reduce(a, b, c)   ltc_mp.montgomery_reduce(a, b, c)
#define mp_montgomery_free(a)        ltc_mp.montgomery_deinit(a)
#define mp_exptmod(a,b,c,d)          ltc_mp.exptmod(a,b,c,d)
#define mp_prime_is_prime(a, b, c)   ltc_mp.isprime(a,b,c)
#define mp_iszero(a)                 (mp_cmp_d(a, 0) == LTC_MP_EQ ? LTC_MP_YES : LTC_MP_NO)
#define mp_isodd(a)                  (mp_get_digit_count(a) > 0 ? (mp_get_digit(a, 0) & 1 ? LTC_MP_YES : LTC_MP_NO) : LTC_MP_NO)
#define mp_exch(a, b)                do { void *ABC__tmp = a; a = b; b = ABC__tmp; } while(0);
#define mp_tohex(a, b)               mp_toradix(a, b, 16)
#define mp_rand(a, b)                ltc_mp.rand(a, b)
#endif
