#include "tomcrypt.h"
#ifdef LTC_MDSA
int dsa_encrypt_key(const unsigned char *in,   unsigned long inlen,
                          unsigned char *out,  unsigned long *outlen, 
                          prng_state *prng, int wprng, int hash, 
                          dsa_key *key)
{
    unsigned char *expt, *skey;
    void          *g_pub, *g_priv;
    unsigned long  x, y;
    int            err, qbits;
    LTC_ARGCHK(in      != NULL);
    LTC_ARGCHK(out     != NULL);
    LTC_ARGCHK(outlen  != NULL);
    LTC_ARGCHK(key     != NULL);
    if ((err = prng_is_valid(wprng)) != CRYPT_OK) {
       return err;
    }
    if ((err = hash_is_valid(hash)) != CRYPT_OK) {
       return err;
    }
    if (inlen > hash_descriptor[hash]->hashsize) {
       return CRYPT_INVALID_HASH;
    }
    if ((err = mp_init_multi(&g_pub, &g_priv, NULL)) != CRYPT_OK) {
       return err;
    }
    expt       = XMALLOC(mp_unsigned_bin_size(key->p) + 1);
    skey       = XMALLOC(MAXBLOCKSIZE);
    if (expt == NULL  || skey == NULL) {
       if (expt != NULL) {
          XFREE(expt);
       }
       if (skey != NULL) {
          XFREE(skey);
       }
       mp_clear_multi(g_pub, g_priv, NULL);
       return CRYPT_MEM;
    }
    qbits = mp_count_bits(key->q);
    do {
      if ((err = rand_bn_bits(g_priv, qbits, prng, wprng)) != CRYPT_OK) {
        goto LBL_ERR;
      }
    } while (mp_cmp_d(g_priv, 0) != LTC_MP_GT || mp_cmp(g_priv, key->q) != LTC_MP_LT);
    if ((err = mp_exptmod(key->g, g_priv, key->p, g_pub)) != CRYPT_OK) {
       goto LBL_ERR;
    }
    x        = mp_unsigned_bin_size(key->p) + 1;
    if ((err = dsa_shared_secret(g_priv, key->y, key, expt, &x)) != CRYPT_OK) {
       goto LBL_ERR;
    }
    y = MAXBLOCKSIZE;
    if ((err = hash_memory(hash, expt, x, skey, &y)) != CRYPT_OK) {
       goto LBL_ERR;
    }
    for (x = 0; x < inlen; x++) {
      skey[x] ^= in[x];
    }
    err = der_encode_sequence_multi(out, outlen,
                                    LTC_ASN1_OBJECT_IDENTIFIER,  hash_descriptor[hash]->OIDlen,   hash_descriptor[hash]->OID,
                                    LTC_ASN1_INTEGER,            1UL,                            g_pub,
                                    LTC_ASN1_OCTET_STRING,       inlen,                          skey,
                                    LTC_ASN1_EOL,                0UL,                            NULL);
LBL_ERR:
#ifdef LTC_CLEAN_STACK
    zeromem(expt,   mp_unsigned_bin_size(key->p) + 1);
    zeromem(skey,   MAXBLOCKSIZE);
#endif
    XFREE(skey);
    XFREE(expt);
    mp_clear_multi(g_pub, g_priv, NULL);
    return err;
}
#endif
