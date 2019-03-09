#include "tomcrypt.h"
#ifdef LTC_MECC
int ecc_decrypt_key(const unsigned char *in,  unsigned long  inlen,
                          unsigned char *out, unsigned long *outlen, 
                          ecc_key *key)
{
   unsigned char *ecc_shared, *skey, *pub_expt;
   unsigned long  x, y, hashOID[32];
   int            hash, err;
   ecc_key        pubkey;
   ltc_asn1_list  decode[3];
   LTC_ARGCHK(in     != NULL);
   LTC_ARGCHK(out    != NULL);
   LTC_ARGCHK(outlen != NULL);
   LTC_ARGCHK(key    != NULL);
   if (key->type != PK_PRIVATE) {
      return CRYPT_PK_NOT_PRIVATE;
   }
   LTC_SET_ASN1(decode, 0, LTC_ASN1_OBJECT_IDENTIFIER, hashOID, sizeof(hashOID)/sizeof(hashOID[0]));
   if ((err = der_decode_sequence(in, inlen, decode, 1)) != CRYPT_OK) {
      return err;
   }
   hash = find_hash_oid(hashOID, decode[0].size);                   
   if (hash_is_valid(hash) != CRYPT_OK) {
      return CRYPT_INVALID_PACKET;
   }
   pub_expt   = XMALLOC(ECC_BUF_SIZE);
   ecc_shared = XMALLOC(ECC_BUF_SIZE);
   skey       = XMALLOC(MAXBLOCKSIZE);
   if (pub_expt == NULL || ecc_shared == NULL || skey == NULL) {
      if (pub_expt != NULL) {
         XFREE(pub_expt);
      }
      if (ecc_shared != NULL) {
         XFREE(ecc_shared);
      }
      if (skey != NULL) {
         XFREE(skey);
      }
      return CRYPT_MEM;
   }
   LTC_SET_ASN1(decode, 1, LTC_ASN1_OCTET_STRING,      pub_expt,  ECC_BUF_SIZE);
   LTC_SET_ASN1(decode, 2, LTC_ASN1_OCTET_STRING,      skey,      MAXBLOCKSIZE);
   if ((err = der_decode_sequence(in, inlen, decode, 3)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   if ((err = ecc_import(decode[1].data, decode[1].size, &pubkey)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   x = ECC_BUF_SIZE;
   if ((err = ecc_shared_secret(key, &pubkey, ecc_shared, &x)) != CRYPT_OK) {
      ecc_free(&pubkey);
      goto LBL_ERR;
   }
   ecc_free(&pubkey);
   y = MIN(ECC_BUF_SIZE, MAXBLOCKSIZE);
   if ((err = hash_memory(hash, ecc_shared, x, ecc_shared, &y)) != CRYPT_OK) {
      goto LBL_ERR;
   }
   if (decode[2].size > y) {
      err = CRYPT_INVALID_PACKET;
      goto LBL_ERR;
   }
   if (*outlen < decode[2].size) {
      *outlen = decode[2].size;
      err = CRYPT_BUFFER_OVERFLOW;
      goto LBL_ERR;
   }
   for (x = 0; x < decode[2].size; x++) {
     out[x] = skey[x] ^ ecc_shared[x];
   }
   *outlen = x;
   err = CRYPT_OK;
LBL_ERR:
#ifdef LTC_CLEAN_STACK
   zeromem(pub_expt,   ECC_BUF_SIZE);
   zeromem(ecc_shared, ECC_BUF_SIZE);
   zeromem(skey,       MAXBLOCKSIZE);
#endif
   XFREE(pub_expt);
   XFREE(ecc_shared);
   XFREE(skey);
   return err;
}
#endif
