enum {
   PK_PUBLIC=0,
   PK_PRIVATE=1
};
#define PK_STD          0x1000
int rand_prime(void *N, long len, prng_state *prng, int wprng);
int rand_bn_bits(void *N, int bits, prng_state *prng, int wprng);
int rand_bn_range(void *N, void *limit, prng_state *prng, int wprng);
enum {
   PKA_RSA,
   PKA_DSA
};
typedef struct Oid {
    unsigned long OID[16];
    unsigned long OIDlen;
} oid_st;
int pk_get_oid(int pk, oid_st *st);
#ifdef LTC_MRSA
#define MIN_RSA_SIZE 256
#define MAX_RSA_SIZE 4096
typedef struct Rsa_key {
    int type;
    void *e; 
    void *d; 
    void *N; 
    void *p; 
    void *q; 
    void *qP; 
    void *dP; 
    void *dQ;
} rsa_key;
int rsa_make_key(prng_state *prng, int wprng, int size, long e, rsa_key *key);
int rsa_exptmod(const unsigned char *in,   unsigned long inlen,
                      unsigned char *out,  unsigned long *outlen, int which,
                      rsa_key *key);
void rsa_free(rsa_key *key);
#define rsa_encrypt_key(_in, _inlen, _out, _outlen, _lparam, _lparamlen, _prng, _prng_idx, _hash_idx, _key) \
  rsa_encrypt_key_ex(_in, _inlen, _out, _outlen, _lparam, _lparamlen, _prng, _prng_idx, _hash_idx, LTC_PKCS_1_OAEP, _key)
#define rsa_decrypt_key(_in, _inlen, _out, _outlen, _lparam, _lparamlen, _hash_idx, _stat, _key) \
  rsa_decrypt_key_ex(_in, _inlen, _out, _outlen, _lparam, _lparamlen, _hash_idx, LTC_PKCS_1_OAEP, _stat, _key)
#define rsa_sign_hash(_in, _inlen, _out, _outlen, _prng, _prng_idx, _hash_idx, _saltlen, _key) \
  rsa_sign_hash_ex(_in, _inlen, _out, _outlen, LTC_PKCS_1_PSS, _prng, _prng_idx, _hash_idx, _saltlen, _key)
#define rsa_verify_hash(_sig, _siglen, _hash, _hashlen, _hash_idx, _saltlen, _stat, _key) \
  rsa_verify_hash_ex(_sig, _siglen, _hash, _hashlen, LTC_PKCS_1_PSS, _hash_idx, _saltlen, _stat, _key)
int rsa_encrypt_key_ex(const unsigned char *in,     unsigned long inlen,
                             unsigned char *out,    unsigned long *outlen,
                       const unsigned char *lparam, unsigned long lparamlen,
                       prng_state *prng, int prng_idx, int hash_idx, int padding, rsa_key *key);
int rsa_decrypt_key_ex(const unsigned char *in,       unsigned long  inlen,
                             unsigned char *out,      unsigned long *outlen,
                       const unsigned char *lparam,   unsigned long  lparamlen,
                             int            hash_idx, int            padding,
                             int           *stat,     rsa_key       *key);
int rsa_sign_hash_ex(const unsigned char *in,       unsigned long  inlen,
                           unsigned char *out,      unsigned long *outlen,
                           int            padding,
                           prng_state    *prng,     int            prng_idx,
                           int            hash_idx, unsigned long  saltlen,
                           rsa_key *key);
int rsa_verify_hash_ex(const unsigned char *sig,      unsigned long siglen,
                       const unsigned char *hash,     unsigned long hashlen,
                             int            padding,
                             int            hash_idx, unsigned long saltlen,
                             int           *stat,     rsa_key      *key);
int rsa_export(unsigned char *out, unsigned long *outlen, int type, rsa_key *key);
int rsa_import(const unsigned char *in, unsigned long inlen, rsa_key *key);
#endif
#ifdef LTC_MKAT
#define MIN_KAT_SIZE 1024
#define MAX_KAT_SIZE 4096
typedef struct KAT_key {
    int type;
    void *d; 
    void *N; 
    void *p; 
    void *q; 
    void *qP; 
    void *dP; 
    void *dQ;
    void *pq;
} katja_key;
int katja_make_key(prng_state *prng, int wprng, int size, katja_key *key);
int katja_exptmod(const unsigned char *in,   unsigned long inlen,
                        unsigned char *out,  unsigned long *outlen, int which,
                        katja_key *key);
void katja_free(katja_key *key);
int katja_encrypt_key(const unsigned char *in,     unsigned long inlen,
                            unsigned char *out,    unsigned long *outlen,
                      const unsigned char *lparam, unsigned long lparamlen,
                      prng_state *prng, int prng_idx, int hash_idx, katja_key *key);
int katja_decrypt_key(const unsigned char *in,       unsigned long inlen,
                            unsigned char *out,      unsigned long *outlen, 
                      const unsigned char *lparam,   unsigned long lparamlen,
                            int            hash_idx, int *stat,
                            katja_key       *key);
int katja_export(unsigned char *out, unsigned long *outlen, int type, katja_key *key);
int katja_import(const unsigned char *in, unsigned long inlen, katja_key *key);
#endif
#ifdef LTC_LINARO_FIX_DH
#ifdef LTC_MDH
typedef struct Dh_key {
    int type;	
    void *x;	
    void *y;	
    void *g;	
    void *p;	
} dh_key;
int dh_make_key(prng_state *prng, int wprng, void *q, int xbits, dh_key *key);
void dh_free(dh_key *key);
int dh_shared_secret(dh_key *private_key, void *public_key, void *secret);
#endif
#endif
#ifdef LTC_MECC
#define ECC_BUF_SIZE 256
#define ECC_MAXSIZE  66
typedef struct {
   int size;
   const char *name;
   const char *prime;
   const char *B;
   const char *order;
   const char *Gx;
   const char *Gy;
} ltc_ecc_set_type;
typedef struct {
    void *x;
    void *y;
    void *z;
} ecc_point;
typedef struct {
    int type;
    int idx;
	const ltc_ecc_set_type *dp;
    ecc_point pubkey;
    void *k;
} ecc_key;
extern const ltc_ecc_set_type ltc_ecc_sets[];
int  ecc_test(void);
void ecc_sizes(int *low, int *high);
int  ecc_get_size(ecc_key *key);
int  ecc_make_key(prng_state *prng, int wprng, int keysize, ecc_key *key);
int  ecc_make_key_ex(prng_state *prng, int wprng, ecc_key *key, const ltc_ecc_set_type *dp);
void ecc_free(ecc_key *key);
int  ecc_export(unsigned char *out, unsigned long *outlen, int type, ecc_key *key);
int  ecc_import(const unsigned char *in, unsigned long inlen, ecc_key *key);
int  ecc_import_ex(const unsigned char *in, unsigned long inlen, ecc_key *key, const ltc_ecc_set_type *dp);
int ecc_ansi_x963_export(ecc_key *key, unsigned char *out, unsigned long *outlen);
int ecc_ansi_x963_import(const unsigned char *in, unsigned long inlen, ecc_key *key);
int ecc_ansi_x963_import_ex(const unsigned char *in, unsigned long inlen, ecc_key *key, ltc_ecc_set_type *dp);
int  ecc_shared_secret(ecc_key *private_key, ecc_key *public_key, 
                       unsigned char *out, unsigned long *outlen);
int  ecc_encrypt_key(const unsigned char *in,   unsigned long inlen,
                           unsigned char *out,  unsigned long *outlen, 
                           prng_state *prng, int wprng, int hash, 
                           ecc_key *key);
int  ecc_decrypt_key(const unsigned char *in,  unsigned long  inlen,
                           unsigned char *out, unsigned long *outlen, 
                           ecc_key *key);
int ecc_sign_hash_raw(const unsigned char *in,  unsigned long inlen,
                            void   *r,   void *s,
                            prng_state *prng, int wprng, ecc_key *key);
int  ecc_sign_hash(const unsigned char *in,  unsigned long inlen, 
                         unsigned char *out, unsigned long *outlen, 
                         prng_state *prng, int wprng, ecc_key *key);
int ecc_verify_hash_raw(      void   *r, void   *s,
                        const unsigned char *hash, unsigned long hashlen,
                        int *stat, ecc_key *key);
int  ecc_verify_hash(const unsigned char *sig,  unsigned long siglen,
                     const unsigned char *hash, unsigned long hashlen, 
                     int *stat, ecc_key *key);
ecc_point *ltc_ecc_new_point(void);
void       ltc_ecc_del_point(ecc_point *p);
int        ltc_ecc_is_valid_idx(int n);
#if !defined(LTC_MECC_ACCEL) || defined(LTM_DESC) || defined(GMP_DESC)
int ltc_ecc_projective_dbl_point(ecc_point *P, ecc_point *R, void *modulus, void *mp);
int ltc_ecc_projective_add_point(ecc_point *P, ecc_point *Q, ecc_point *R, void *modulus, void *mp);
#endif
#if defined(LTC_MECC_FP)
int ltc_ecc_fp_mulmod(void *k, ecc_point *G, ecc_point *R, void *modulus, int map);
int ltc_ecc_fp_save_state(unsigned char **out, unsigned long *outlen);
int ltc_ecc_fp_restore_state(unsigned char *in, unsigned long inlen);
void ltc_ecc_fp_free(void);
int ltc_ecc_fp_add_point(ecc_point *g, void *modulus, int lock);
void ltc_ecc_fp_tablelock(int lock);
#endif
int ltc_ecc_mulmod(void *k, ecc_point *G, ecc_point *R, void *modulus, int map);
#ifdef LTC_ECC_SHAMIR
int ltc_ecc_mul2add(ecc_point *A, void *kA,
                    ecc_point *B, void *kB,
                    ecc_point *C,
                         void *modulus);
#ifdef LTC_MECC_FP
int ltc_ecc_fp_mul2add(ecc_point *A, void *kA,
                       ecc_point *B, void *kB,
                       ecc_point *C, void *modulus);
#endif
#endif
int ltc_ecc_map(ecc_point *P, void *modulus, void *mp);
#endif
#ifdef LTC_MDSA
#define LTC_MDSA_DELTA     512
#define LTC_MDSA_MAX_GROUP 512
typedef struct {
   int type; 
   int qord;
   void *g;
   void *q;
   void *p;
   void *x;
   void *y;
} dsa_key;
int dsa_make_key(prng_state *prng, int wprng, int group_size, int modulus_size, dsa_key *key);
void dsa_free(dsa_key *key);
int dsa_sign_hash_raw(const unsigned char *in,  unsigned long inlen,
                                   void *r,   void *s,
                               prng_state *prng, int wprng, dsa_key *key);
int dsa_sign_hash(const unsigned char *in,  unsigned long inlen,
                        unsigned char *out, unsigned long *outlen,
                        prng_state *prng, int wprng, dsa_key *key);
int dsa_verify_hash_raw(         void *r,          void *s,
                    const unsigned char *hash, unsigned long hashlen, 
                                    int *stat,      dsa_key *key);
int dsa_verify_hash(const unsigned char *sig,  unsigned long siglen,
                    const unsigned char *hash, unsigned long hashlen, 
                          int           *stat, dsa_key       *key);
int dsa_encrypt_key(const unsigned char *in,   unsigned long inlen,
                          unsigned char *out,  unsigned long *outlen, 
                          prng_state *prng, int wprng, int hash, 
                          dsa_key *key);
int dsa_decrypt_key(const unsigned char *in,  unsigned long  inlen,
                          unsigned char *out, unsigned long *outlen, 
                          dsa_key *key);
int dsa_import(const unsigned char *in, unsigned long inlen, dsa_key *key);
int dsa_export(unsigned char *out, unsigned long *outlen, int type, dsa_key *key);
int dsa_verify_key(dsa_key *key, int *stat);
int dsa_shared_secret(void          *private_key, void *base,
                      dsa_key       *public_key,
                      unsigned char *out,         unsigned long *outlen);
#endif
#ifdef LTC_DER
typedef enum ltc_asn1_type_ {
 LTC_ASN1_EOL,
 LTC_ASN1_BOOLEAN,
 LTC_ASN1_INTEGER,
 LTC_ASN1_SHORT_INTEGER,
 LTC_ASN1_BIT_STRING,
 LTC_ASN1_OCTET_STRING,
 LTC_ASN1_NULL,
 LTC_ASN1_OBJECT_IDENTIFIER,
 LTC_ASN1_IA5_STRING,
 LTC_ASN1_PRINTABLE_STRING,
 LTC_ASN1_UTF8_STRING,
 LTC_ASN1_UTCTIME,
 LTC_ASN1_CHOICE,
 LTC_ASN1_SEQUENCE,
 LTC_ASN1_SET,
 LTC_ASN1_SETOF,
 LTC_ASN1_RAW_BIT_STRING,
 LTC_ASN1_TELETEX_STRING,
 LTC_ASN1_CONSTRUCTED,
 LTC_ASN1_CONTEXT_SPECIFIC,
} ltc_asn1_type;
typedef struct ltc_asn1_list_ {
   ltc_asn1_type type;
   void         *data;
   unsigned long size;
   int           used;
   struct ltc_asn1_list_ *prev, *next, *child, *parent;
} ltc_asn1_list;
#define LTC_SET_ASN1(list, index, Type, Data, Size)  \
   do {                                              \
      int LTC_MACRO_temp            = (index);       \
      ltc_asn1_list *LTC_MACRO_list = (list);        \
      LTC_MACRO_list[LTC_MACRO_temp].type = (Type);  \
      LTC_MACRO_list[LTC_MACRO_temp].data = (void*)(Data);  \
      LTC_MACRO_list[LTC_MACRO_temp].size = (Size);  \
      LTC_MACRO_list[LTC_MACRO_temp].used = 0;       \
   } while (0)
int der_encode_sequence_ex(ltc_asn1_list *list, unsigned long inlen,
                           unsigned char *out,  unsigned long *outlen, int type_of);
#define der_encode_sequence(list, inlen, out, outlen) der_encode_sequence_ex(list, inlen, out, outlen, LTC_ASN1_SEQUENCE)
int der_decode_sequence_ex(const unsigned char *in, unsigned long  inlen,
                           ltc_asn1_list *list,     unsigned long  outlen, int ordered);
#define der_decode_sequence(in, inlen, list, outlen) der_decode_sequence_ex(in, inlen, list, outlen, 1)
int der_length_sequence(ltc_asn1_list *list, unsigned long inlen,
                        unsigned long *outlen);
int der_encode_subject_public_key_info(unsigned char *out, unsigned long *outlen,
        unsigned int algorithm, void* public_key, unsigned long public_key_len,
        unsigned long parameters_type, void* parameters, unsigned long parameters_len);
int der_decode_subject_public_key_info(const unsigned char *in, unsigned long inlen,
        unsigned int algorithm, void* public_key, unsigned long* public_key_len,
        unsigned long parameters_type, ltc_asn1_list* parameters, unsigned long parameters_len);
#define der_decode_set(in, inlen, list, outlen) der_decode_sequence_ex(in, inlen, list, outlen, 0)
#define der_length_set der_length_sequence
int der_encode_set(ltc_asn1_list *list, unsigned long inlen,
                   unsigned char *out,  unsigned long *outlen);
int der_encode_setof(ltc_asn1_list *list, unsigned long inlen,
                     unsigned char *out,  unsigned long *outlen);
int der_encode_sequence_multi(unsigned char *out, unsigned long *outlen, ...);
int der_decode_sequence_multi(const unsigned char *in, unsigned long inlen, ...);
int  der_decode_sequence_flexi(const unsigned char *in, unsigned long *inlen, ltc_asn1_list **out);
#define der_free_sequence_flexi         der_sequence_free
void der_sequence_free(ltc_asn1_list *in);
int der_length_boolean(unsigned long *outlen);
int der_encode_boolean(int in, 
                       unsigned char *out, unsigned long *outlen);
int der_decode_boolean(const unsigned char *in, unsigned long inlen,
                                       int *out);		       
int der_encode_integer(void *num, unsigned char *out, unsigned long *outlen);
int der_decode_integer(const unsigned char *in, unsigned long inlen, void *num);
int der_length_integer(void *num, unsigned long *len);
int der_decode_short_integer(const unsigned char *in, unsigned long inlen, unsigned long *num);
int der_encode_short_integer(unsigned long num, unsigned char *out, unsigned long *outlen);
int der_length_short_integer(unsigned long num, unsigned long *outlen);
int der_encode_bit_string(const unsigned char *in, unsigned long inlen,
                                unsigned char *out, unsigned long *outlen);
int der_decode_bit_string(const unsigned char *in, unsigned long inlen,
                                unsigned char *out, unsigned long *outlen);
int der_encode_raw_bit_string(const unsigned char *in, unsigned long inlen,
                                unsigned char *out, unsigned long *outlen);
int der_decode_raw_bit_string(const unsigned char *in, unsigned long inlen,
                                unsigned char *out, unsigned long *outlen);
int der_length_bit_string(unsigned long nbits, unsigned long *outlen);
int der_encode_octet_string(const unsigned char *in, unsigned long inlen,
                                  unsigned char *out, unsigned long *outlen);
int der_decode_octet_string(const unsigned char *in, unsigned long inlen,
                                  unsigned char *out, unsigned long *outlen);
int der_length_octet_string(unsigned long noctets, unsigned long *outlen);
int der_encode_object_identifier(unsigned long *words, unsigned long  nwords,
                                 unsigned char *out,   unsigned long *outlen);
int der_decode_object_identifier(const unsigned char *in,    unsigned long  inlen,
                                       unsigned long *words, unsigned long *outlen);
int der_length_object_identifier(unsigned long *words, unsigned long nwords, unsigned long *outlen);
unsigned long der_object_identifier_bits(unsigned long x);
int der_encode_ia5_string(const unsigned char *in, unsigned long inlen,
                                unsigned char *out, unsigned long *outlen);
int der_decode_ia5_string(const unsigned char *in, unsigned long inlen,
                                unsigned char *out, unsigned long *outlen);
int der_length_ia5_string(const unsigned char *octets, unsigned long noctets, unsigned long *outlen);
int der_ia5_char_encode(int c);
int der_ia5_value_decode(int v);
int der_decode_teletex_string(const unsigned char *in, unsigned long inlen,
                                unsigned char *out, unsigned long *outlen);
int der_length_teletex_string(const unsigned char *octets, unsigned long noctets, unsigned long *outlen);
int der_teletex_char_encode(int c);
int der_teletex_value_decode(int v);
int der_encode_printable_string(const unsigned char *in, unsigned long inlen,
                                unsigned char *out, unsigned long *outlen);
int der_decode_printable_string(const unsigned char *in, unsigned long inlen,
                                unsigned char *out, unsigned long *outlen);
int der_length_printable_string(const unsigned char *octets, unsigned long noctets, unsigned long *outlen);
int der_printable_char_encode(int c);
int der_printable_value_decode(int v);
#if (defined(SIZE_MAX) || __STDC_VERSION__ >= 199901L || defined(WCHAR_MAX) || defined(_WCHAR_T) || defined(_WCHAR_T_DEFINED) || defined (__WCHAR_TYPE__)) && !defined(LTC_NO_WCHAR) 
#include <wchar.h>
#else
typedef ulong32 wchar_t;
#endif
int der_encode_utf8_string(const wchar_t *in,  unsigned long inlen,
                           unsigned char *out, unsigned long *outlen);
int der_decode_utf8_string(const unsigned char *in,  unsigned long inlen,
                                       wchar_t *out, unsigned long *outlen);
unsigned long der_utf8_charsize(const wchar_t c);
int der_length_utf8_string(const wchar_t *in, unsigned long noctets, unsigned long *outlen);
int der_decode_choice(const unsigned char *in,   unsigned long *inlen,
                            ltc_asn1_list *list, unsigned long  outlen);
typedef struct {
   unsigned YY, 
            MM, 
            DD, 
            hh, 
            mm, 
            ss, 
            off_dir, 
            off_hh, 
            off_mm; 
} ltc_utctime;
int der_encode_utctime(ltc_utctime *utctime, 
                       unsigned char *out,   unsigned long *outlen);
int der_decode_utctime(const unsigned char *in, unsigned long *inlen,
                             ltc_utctime   *out);
int der_length_utctime(ltc_utctime *utctime, unsigned long *outlen);
#endif
