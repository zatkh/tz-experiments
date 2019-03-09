#ifndef __CRYPTO_CRYPTO_H
#define __CRYPTO_CRYPTO_H
#include <tee_api_types.h>
TEE_Result crypto_init(void);
TEE_Result crypto_hash_alloc_ctx(void **ctx, uint32_t algo);
TEE_Result crypto_hash_init(void *ctx, uint32_t algo);
TEE_Result crypto_hash_update(void *ctx, uint32_t algo, const uint8_t *data,
			      size_t len);
TEE_Result crypto_hash_final(void *ctx, uint32_t algo, uint8_t *digest,
			     size_t len);
void crypto_hash_free_ctx(void *ctx, uint32_t algo);
void crypto_hash_copy_state(void *dst_ctx, void *src_ctx, uint32_t algo);
TEE_Result crypto_cipher_alloc_ctx(void **ctx, uint32_t algo);
TEE_Result crypto_cipher_init(void *ctx, uint32_t algo, TEE_OperationMode mode,
			      const uint8_t *key1, size_t key1_len,
			      const uint8_t *key2, size_t key2_len,
			      const uint8_t *iv, size_t iv_len);
TEE_Result crypto_cipher_update(void *ctx, uint32_t algo,
				TEE_OperationMode mode, bool last_block,
				const uint8_t *data, size_t len, uint8_t *dst);
void crypto_cipher_final(void *ctx, uint32_t algo);
TEE_Result crypto_cipher_get_block_size(uint32_t algo, size_t *size);
void crypto_cipher_free_ctx(void *ctx, uint32_t algo);
void crypto_cipher_copy_state(void *dst_ctx, void *src_ctx, uint32_t algo);
TEE_Result crypto_mac_alloc_ctx(void **ctx, uint32_t algo);
TEE_Result crypto_mac_init(void *ctx, uint32_t algo, const uint8_t *key,
			   size_t len);
TEE_Result crypto_mac_update(void *ctx, uint32_t algo, const uint8_t *data,
			     size_t len);
TEE_Result crypto_mac_final(void *ctx, uint32_t algo, uint8_t *digest,
			    size_t digest_len);
void crypto_mac_free_ctx(void *ctx, uint32_t algo);
void crypto_mac_copy_state(void *dst_ctx, void *src_ctx, uint32_t algo);
TEE_Result crypto_authenc_alloc_ctx(void **ctx, uint32_t algo);
TEE_Result crypto_authenc_init(void *ctx, uint32_t algo, TEE_OperationMode mode,
			       const uint8_t *key, size_t key_len,
			       const uint8_t *nonce, size_t nonce_len,
			       size_t tag_len, size_t aad_len,
			       size_t payload_len);
TEE_Result crypto_authenc_update_aad(void *ctx, uint32_t algo,
				     TEE_OperationMode mode,
				     const uint8_t *data, size_t len);
TEE_Result crypto_authenc_update_payload(void *ctx, uint32_t algo,
					 TEE_OperationMode mode,
					 const uint8_t *src_data,
					 size_t src_len, uint8_t *dst_data,
					 size_t *dst_len);
TEE_Result crypto_authenc_enc_final(void *ctx, uint32_t algo,
				    const uint8_t *src_data, size_t src_len,
				    uint8_t *dst_data, size_t *dst_len,
				    uint8_t *dst_tag, size_t *dst_tag_len);
TEE_Result crypto_authenc_dec_final(void *ctx, uint32_t algo,
				    const uint8_t *src_data, size_t src_len,
				    uint8_t *dst_data, size_t *dst_len,
				    const uint8_t *tag, size_t tag_len);
void crypto_authenc_final(void *ctx, uint32_t algo);
void crypto_authenc_free_ctx(void *ctx, uint32_t algo);
void crypto_authenc_copy_state(void *dst_ctx, void *src_ctx, uint32_t algo);
struct bignum *crypto_bignum_allocate(size_t size_bits);
TEE_Result crypto_bignum_bin2bn(const uint8_t *from, size_t fromsize,
				struct bignum *to);
size_t crypto_bignum_num_bytes(struct bignum *a);
size_t crypto_bignum_num_bits(struct bignum *a);
void crypto_bignum_bn2bin(const struct bignum *from, uint8_t *to);
void crypto_bignum_copy(struct bignum *to, const struct bignum *from);
void crypto_bignum_free(struct bignum *a);
void crypto_bignum_clear(struct bignum *a);
int32_t crypto_bignum_compare(struct bignum *a, struct bignum *b);
struct rsa_keypair {
	struct bignum *e;	
	struct bignum *d;	
	struct bignum *n;	
	struct bignum *p;	
	struct bignum *q;
	struct bignum *qp;	
	struct bignum *dp;	
	struct bignum *dq;	
};
struct rsa_public_key {
	struct bignum *e;	
	struct bignum *n;	
};
struct dsa_keypair {
	struct bignum *g;	
	struct bignum *p;	
	struct bignum *q;	
	struct bignum *y;	
	struct bignum *x;	
};
struct dsa_public_key {
	struct bignum *g;	
	struct bignum *p;	
	struct bignum *q;	
	struct bignum *y;	
};
struct dh_keypair {
	struct bignum *g;	
	struct bignum *p;	
	struct bignum *x;	
	struct bignum *y;	
	struct bignum *q;	
	uint32_t xbits;		
};
struct ecc_public_key {
	struct bignum *x;	
	struct bignum *y;	
	uint32_t curve;	        
};
struct ecc_keypair {
	struct bignum *d;	
	struct bignum *x;	
	struct bignum *y;	
	uint32_t curve;	        
};
TEE_Result crypto_acipher_alloc_rsa_keypair(struct rsa_keypair *s,
				size_t key_size_bits);
TEE_Result crypto_acipher_alloc_rsa_public_key(struct rsa_public_key *s,
				   size_t key_size_bits);
void crypto_acipher_free_rsa_public_key(struct rsa_public_key *s);
TEE_Result crypto_acipher_alloc_dsa_keypair(struct dsa_keypair *s,
				size_t key_size_bits);
TEE_Result crypto_acipher_alloc_dsa_public_key(struct dsa_public_key *s,
				   size_t key_size_bits);
TEE_Result crypto_acipher_alloc_dh_keypair(struct dh_keypair *s,
			       size_t key_size_bits);
TEE_Result crypto_acipher_alloc_ecc_public_key(struct ecc_public_key *s,
				   size_t key_size_bits);
TEE_Result crypto_acipher_alloc_ecc_keypair(struct ecc_keypair *s,
				size_t key_size_bits);
void crypto_acipher_free_ecc_public_key(struct ecc_public_key *s);
TEE_Result crypto_acipher_gen_rsa_key(struct rsa_keypair *key, size_t key_size);
TEE_Result crypto_acipher_gen_dsa_key(struct dsa_keypair *key, size_t key_size);
TEE_Result crypto_acipher_gen_dh_key(struct dh_keypair *key, struct bignum *q,
				     size_t xbits);
TEE_Result crypto_acipher_gen_ecc_key(struct ecc_keypair *key);
TEE_Result crypto_acipher_dh_shared_secret(struct dh_keypair *private_key,
					   struct bignum *public_key,
					   struct bignum *secret);
TEE_Result crypto_acipher_rsanopad_decrypt(struct rsa_keypair *key,
					   const uint8_t *src, size_t src_len,
					   uint8_t *dst, size_t *dst_len);
TEE_Result crypto_acipher_rsanopad_encrypt(struct rsa_public_key *key,
					   const uint8_t *src, size_t src_len,
					   uint8_t *dst, size_t *dst_len);
TEE_Result crypto_acipher_rsaes_decrypt(uint32_t algo, struct rsa_keypair *key,
					const uint8_t *label, size_t label_len,
					const uint8_t *src, size_t src_len,
					uint8_t *dst, size_t *dst_len);
TEE_Result crypto_acipher_rsaes_encrypt(uint32_t algo,
					struct rsa_public_key *key,
					const uint8_t *label, size_t label_len,
					const uint8_t *src, size_t src_len,
					uint8_t *dst, size_t *dst_len);
TEE_Result crypto_acipher_rsassa_sign(uint32_t algo, struct rsa_keypair *key,
				      int salt_len, const uint8_t *msg,
				      size_t msg_len, uint8_t *sig,
				      size_t *sig_len);
TEE_Result crypto_acipher_rsassa_verify(uint32_t algo,
					struct rsa_public_key *key,
					int salt_len, const uint8_t *msg,
					size_t msg_len, const uint8_t *sig,
					size_t sig_len);
TEE_Result crypto_acipher_dsa_sign(uint32_t algo, struct dsa_keypair *key,
				   const uint8_t *msg, size_t msg_len,
				   uint8_t *sig, size_t *sig_len);
TEE_Result crypto_acipher_dsa_verify(uint32_t algo, struct dsa_public_key *key,
				     const uint8_t *msg, size_t msg_len,
				     const uint8_t *sig, size_t sig_len);
TEE_Result crypto_acipher_ecc_sign(uint32_t algo, struct ecc_keypair *key,
				   const uint8_t *msg, size_t msg_len,
				   uint8_t *sig, size_t *sig_len);
TEE_Result crypto_acipher_ecc_verify(uint32_t algo, struct ecc_public_key *key,
				     const uint8_t *msg, size_t msg_len,
				     const uint8_t *sig, size_t sig_len);
TEE_Result crypto_acipher_ecc_shared_secret(struct ecc_keypair *private_key,
					    struct ecc_public_key *public_key,
					    void *secret,
					    unsigned long *secret_len);
TEE_Result hash_sha256_check(const uint8_t *hash, const uint8_t *data,
		size_t data_size);
TEE_Result crypto_rng_add_entropy(const uint8_t *inbuf, size_t len);
TEE_Result crypto_rng_read(void *buf, size_t blen);
TEE_Result rng_generate(void *buffer, size_t len);
TEE_Result crypto_aes_expand_enc_key(const void *key, size_t key_len,
				     void *enc_key, unsigned int *rounds);
void crypto_aes_enc_block(const void *enc_key, unsigned int rounds,
			  const void *src, void *dst);
#endif 
