#include "tomcrypt.h"
#ifdef LTC_MDSA
static int dsa_make_params(prng_state *prng, int wprng, int group_size, int modulus_size, void *p, void *q, void *g)
{
  unsigned long L, N, n, outbytes, seedbytes, counter, j, i;
  int err, res, mr_tests_q, mr_tests_p, found_p, found_q, hash;
  unsigned char *wbuf, *sbuf, digest[MAXBLOCKSIZE];
  void *t2L1, *t2N1, *t2q, *t2seedlen, *U, *W, *X, *c, *h, *e, *seedinc;
  if (group_size >= LTC_MDSA_MAX_GROUP || group_size < 1 || group_size >= modulus_size) {
    return CRYPT_INVALID_ARG;
  }
  seedbytes = group_size;
  L = modulus_size * 8;
  N = group_size * 8;
  mr_tests_p = (L <= 2048) ? 3 : 2;
  if      (N <= 160)  { mr_tests_q = 19; }
  else if (N <= 224)  { mr_tests_q = 24; }
  else                { mr_tests_q = 27; }
  if (N <= 256) {
    hash = register_hash(&sha256_desc);
  }
  else if (N <= 384) {
    hash = register_hash(&sha384_desc);
  }
  else if (N <= 512) {
    hash = register_hash(&sha512_desc);
  }
  else {
    return CRYPT_INVALID_ARG; 
  }
  if ((err = hash_is_valid(hash)) != CRYPT_OK)                                   { return err; }
  outbytes = hash_descriptor[hash]->hashsize;
  n = ((L + outbytes*8 - 1) / (outbytes*8)) - 1;
  if ((wbuf = XMALLOC((n+1)*outbytes)) == NULL)                                  { err = CRYPT_MEM; goto cleanup3; }
  if ((sbuf = XMALLOC(seedbytes)) == NULL)                                       { err = CRYPT_MEM; goto cleanup2; }
  err = mp_init_multi(&t2L1, &t2N1, &t2q, &t2seedlen, &U, &W, &X, &c, &h, &e, &seedinc, NULL);
  if (err != CRYPT_OK)                                                           { goto cleanup1; }
  if ((err = mp_2expt(t2L1, L-1)) != CRYPT_OK)                                   { goto cleanup; }
  if ((err = mp_2expt(t2N1, N-1)) != CRYPT_OK)                                   { goto cleanup; }
  if ((err = mp_2expt(t2seedlen, seedbytes*8)) != CRYPT_OK)                      { goto cleanup; }
  for(found_p=0; !found_p;) {
    for(found_q=0; !found_q;) {
      if (prng_descriptor[wprng]->read(sbuf, seedbytes, prng) != seedbytes)       { err = CRYPT_ERROR_READPRNG; goto cleanup; }
      i = outbytes;
      if ((err = hash_memory(hash, sbuf, seedbytes, digest, &i)) != CRYPT_OK)    { goto cleanup; }
      if ((err = mp_read_unsigned_bin(U, digest, outbytes)) != CRYPT_OK)         { goto cleanup; }
      if ((err = mp_mod(U, t2N1, U)) != CRYPT_OK)                                { goto cleanup; }
      if ((err = mp_add(t2N1, U, q)) != CRYPT_OK)                                { goto cleanup; }
      if (!mp_isodd(q)) mp_add_d(q, 1, q);
      if ((err = mp_prime_is_prime(q, mr_tests_q, &res)) != CRYPT_OK)            { goto cleanup; }       
      if (res == LTC_MP_YES) found_q = 1;
    }
    if ((err = mp_read_unsigned_bin(seedinc, sbuf, seedbytes)) != CRYPT_OK)      { goto cleanup; }
    if ((err = mp_add(q, q, t2q)) != CRYPT_OK)                                   { goto cleanup; }
    for(counter=0; counter < 4*L && !found_p; counter++) {
      for(j=0; j<=n; j++) {
        if ((err = mp_add_d(seedinc, 1, seedinc)) != CRYPT_OK)                   { goto cleanup; }
        if ((err = mp_mod(seedinc, t2seedlen, seedinc)) != CRYPT_OK)             { goto cleanup; }
        if ((i = mp_unsigned_bin_size(seedinc)) > seedbytes)                     { err = CRYPT_INVALID_ARG; goto cleanup; }
        zeromem(sbuf, seedbytes);
        if ((err = mp_to_unsigned_bin(seedinc, sbuf + seedbytes-i)) != CRYPT_OK) { goto cleanup; }
        i = outbytes;
        err = hash_memory(hash, sbuf, seedbytes, wbuf+(n-j)*outbytes, &i);
        if (err != CRYPT_OK)                                                     { goto cleanup; }
      }
      if ((err = mp_read_unsigned_bin(W, wbuf, (n+1)*outbytes)) != CRYPT_OK)     { goto cleanup; }
      if ((err = mp_mod(W, t2L1, W)) != CRYPT_OK)                                { goto cleanup; }
      if ((err = mp_add(W, t2L1, X)) != CRYPT_OK)                                { goto cleanup; }
      if ((err = mp_mod(X, t2q, c))  != CRYPT_OK)                                { goto cleanup; }
      if ((err = mp_sub_d(c, 1, p))  != CRYPT_OK)                                { goto cleanup; }
      if ((err = mp_sub(X, p, p))    != CRYPT_OK)                                { goto cleanup; }
      if (mp_cmp(p, t2L1) != LTC_MP_LT) {
        if ((err = mp_prime_is_prime(p, mr_tests_p, &res)) != CRYPT_OK)          { goto cleanup; }       
        if (res == LTC_MP_YES) {
          found_p = 1;
        }
      }
    }
  }
  if ((err = mp_sub_d(p, 1, e)) != CRYPT_OK)                                     { goto cleanup; }
  if ((err = mp_div(e, q, e, c)) != CRYPT_OK)                                    { goto cleanup; }
  i = mp_count_bits(p);
  do {
    do {
      if ((err = rand_bn_bits(h, i, prng, wprng)) != CRYPT_OK)                   { goto cleanup; }
    } while (mp_cmp(h, p) != LTC_MP_LT || mp_cmp_d(h, 2) != LTC_MP_GT);
    if ((err = mp_sub_d(h, 1, h)) != CRYPT_OK)                                   { goto cleanup; }
    if ((err = mp_exptmod(h, e, p, g)) != CRYPT_OK)                              { goto cleanup; }
  } while (mp_cmp_d(g, 1) == LTC_MP_EQ);
  err = CRYPT_OK;
cleanup:
  mp_clear_multi(t2L1, t2N1, t2q, t2seedlen, U, W, X, c, h, e, seedinc, NULL);
cleanup1:
  XFREE(sbuf);
cleanup2:
  XFREE(wbuf);
cleanup3:
  return err;
}
static int dsa_make_key_ex(prng_state *prng, int wprng, int group_size, int modulus_size, dsa_key *key, char* p_hex, char* q_hex, char* g_hex)
{
  int err, qbits;
  LTC_ARGCHK(key  != NULL);
  if ((err = mp_init_multi(&key->g, &key->q, &key->p, &key->x, &key->y, NULL)) != CRYPT_OK) {
    return err;
  }
  if (p_hex == NULL || q_hex == NULL || g_hex == NULL) {
    err = dsa_make_params(prng, wprng, group_size, modulus_size, key->p, key->q, key->g);
    if (err != CRYPT_OK)                                                         { goto cleanup; }
  }
  else {
    if ((err = mp_read_radix(key->p, p_hex, 16)) != CRYPT_OK)                    { goto cleanup; }
    if ((err = mp_read_radix(key->q, q_hex, 16)) != CRYPT_OK)                    { goto cleanup; }
    if ((err = mp_read_radix(key->g, g_hex, 16)) != CRYPT_OK)                    { goto cleanup; }
  }
  qbits = mp_count_bits(key->q);
  do {
     if ((err = rand_bn_bits(key->x, qbits, prng, wprng)) != CRYPT_OK)                  { goto cleanup; }
  } while (mp_cmp_d(key->x, 0) != LTC_MP_GT || mp_cmp(key->x, key->q) != LTC_MP_LT);
  if ((err = mp_exptmod(key->g, key->x, key->p, key->y)) != CRYPT_OK)                   { goto cleanup; }
  key->type = PK_PRIVATE;
  key->qord = group_size;
  return CRYPT_OK;
cleanup:
  mp_clear_multi(key->g, key->q, key->p, key->x, key->y, NULL);
  return err;
}
int dsa_make_key(prng_state *prng, int wprng, int group_size, int modulus_size, dsa_key *key)
{
  return dsa_make_key_ex(prng, wprng, group_size, modulus_size, key, NULL, NULL, NULL);
}
#endif
