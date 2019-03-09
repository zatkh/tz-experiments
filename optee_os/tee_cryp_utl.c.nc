#include <crypto/crypto.h>
#include <initcall.h>
#include <kernel/tee_time.h>
#include <rng_support.h>
#include <stdlib.h>
#include <string_ext.h>
#include <string.h>
#include <tee/tee_cryp_utl.h>
#include <utee_defines.h>
#if !defined(CFG_WITH_SOFTWARE_PRNG)
TEE_Result get_rng_array(void *buffer, int len)
{
	char *buf_char = buffer;
	int i;
	if (buf_char == NULL)
		return TEE_ERROR_BAD_PARAMETERS;
	for (i = 0; i < len; i++)
		buf_char[i] = hw_get_random_byte();
	return TEE_SUCCESS;
}
#endif
TEE_Result tee_hash_get_digest_size(uint32_t algo, size_t *size)
{
	switch (algo) {
	case TEE_ALG_MD5:
	case TEE_ALG_HMAC_MD5:
		*size = TEE_MD5_HASH_SIZE;
		break;
	case TEE_ALG_SHA1:
	case TEE_ALG_HMAC_SHA1:
	case TEE_ALG_DSA_SHA1:
		*size = TEE_SHA1_HASH_SIZE;
		break;
	case TEE_ALG_SHA224:
	case TEE_ALG_HMAC_SHA224:
	case TEE_ALG_DSA_SHA224:
		*size = TEE_SHA224_HASH_SIZE;
		break;
	case TEE_ALG_SHA256:
	case TEE_ALG_HMAC_SHA256:
	case TEE_ALG_DSA_SHA256:
		*size = TEE_SHA256_HASH_SIZE;
		break;
	case TEE_ALG_SHA384:
	case TEE_ALG_HMAC_SHA384:
		*size = TEE_SHA384_HASH_SIZE;
		break;
	case TEE_ALG_SHA512:
	case TEE_ALG_HMAC_SHA512:
		*size = TEE_SHA512_HASH_SIZE;
		break;
	default:
		return TEE_ERROR_NOT_SUPPORTED;
	}
	return TEE_SUCCESS;
}
TEE_Result tee_hash_createdigest(uint32_t algo, const uint8_t *data,
				 size_t datalen, uint8_t *digest,
				 size_t digestlen)
{
	TEE_Result res;
	void *ctx = NULL;
	res = crypto_hash_alloc_ctx(&ctx, algo);
	if (res)
		return res;
	res = crypto_hash_init(ctx, algo);
	if (res)
		goto out;
	if (datalen != 0) {
		res = crypto_hash_update(ctx, algo, data, datalen);
		if (res)
			goto out;
	}
	res = crypto_hash_final(ctx, algo, digest, digestlen);
out:
	crypto_hash_free_ctx(ctx, algo);
	return res;
}
TEE_Result tee_mac_get_digest_size(uint32_t algo, size_t *size)
{
	switch (algo) {
	case TEE_ALG_HMAC_MD5:
	case TEE_ALG_HMAC_SHA224:
	case TEE_ALG_HMAC_SHA1:
	case TEE_ALG_HMAC_SHA256:
	case TEE_ALG_HMAC_SHA384:
	case TEE_ALG_HMAC_SHA512:
		return tee_hash_get_digest_size(algo, size);
	case TEE_ALG_AES_CBC_MAC_NOPAD:
	case TEE_ALG_AES_CBC_MAC_PKCS5:
	case TEE_ALG_AES_CMAC:
		*size = TEE_AES_BLOCK_SIZE;
		return TEE_SUCCESS;
	case TEE_ALG_DES_CBC_MAC_NOPAD:
	case TEE_ALG_DES_CBC_MAC_PKCS5:
	case TEE_ALG_DES3_CBC_MAC_NOPAD:
	case TEE_ALG_DES3_CBC_MAC_PKCS5:
		*size = TEE_DES_BLOCK_SIZE;
		return TEE_SUCCESS;
	default:
		return TEE_ERROR_NOT_SUPPORTED;
	}
}
TEE_Result tee_cipher_get_block_size(uint32_t algo, size_t *size)
{
	switch (algo) {
	case TEE_ALG_AES_CBC_MAC_NOPAD:
	case TEE_ALG_AES_CBC_MAC_PKCS5:
	case TEE_ALG_AES_CMAC:
	case TEE_ALG_AES_ECB_NOPAD:
	case TEE_ALG_AES_CBC_NOPAD:
	case TEE_ALG_AES_CTR:
	case TEE_ALG_AES_CTS:
	case TEE_ALG_AES_XTS:
	case TEE_ALG_AES_CCM:
	case TEE_ALG_AES_GCM:
		*size = 16;
		break;
	case TEE_ALG_DES_CBC_MAC_NOPAD:
	case TEE_ALG_DES_CBC_MAC_PKCS5:
	case TEE_ALG_DES_ECB_NOPAD:
	case TEE_ALG_DES_CBC_NOPAD:
	case TEE_ALG_DES3_CBC_MAC_NOPAD:
	case TEE_ALG_DES3_CBC_MAC_PKCS5:
	case TEE_ALG_DES3_ECB_NOPAD:
	case TEE_ALG_DES3_CBC_NOPAD:
		*size = 8;
		break;
	default:
		return TEE_ERROR_NOT_SUPPORTED;
	}
	return TEE_SUCCESS;
}
TEE_Result tee_do_cipher_update(void *ctx, uint32_t algo,
				TEE_OperationMode mode, bool last_block,
				const uint8_t *data, size_t len, uint8_t *dst)
{
	TEE_Result res;
	size_t block_size;
	if (mode != TEE_MODE_ENCRYPT && mode != TEE_MODE_DECRYPT)
		return TEE_ERROR_BAD_PARAMETERS;
	res = tee_cipher_get_block_size(algo, &block_size);
	if (res != TEE_SUCCESS)
		return res;
	if ((len % block_size) != 0) {
		if (!last_block && algo != TEE_ALG_AES_CTR)
			return TEE_ERROR_BAD_PARAMETERS;
		switch (algo) {
		case TEE_ALG_AES_ECB_NOPAD:
		case TEE_ALG_DES_ECB_NOPAD:
		case TEE_ALG_DES3_ECB_NOPAD:
		case TEE_ALG_AES_CBC_NOPAD:
		case TEE_ALG_DES_CBC_NOPAD:
		case TEE_ALG_DES3_CBC_NOPAD:
			return TEE_ERROR_BAD_PARAMETERS;
		case TEE_ALG_AES_CTR:
		case TEE_ALG_AES_XTS:
		case TEE_ALG_AES_CTS:
			break;
		default:
			return TEE_ERROR_NOT_SUPPORTED;
		}
	}
	return crypto_cipher_update(ctx, algo, mode, last_block, data, len,
				    dst);
}
TEE_Result tee_aes_cbc_cts_update(void *cbc_ctx, void *ecb_ctx,
				  TEE_OperationMode mode, bool last_block,
				  const uint8_t *data, size_t len,
				  uint8_t *dst)
{
	TEE_Result res;
	int nb_blocks, len_last_block, block_size = 16;
	uint8_t tmp_block[64], tmp2_block[64];
	if (!last_block)
		return tee_do_cipher_update(cbc_ctx, TEE_ALG_AES_CBC_NOPAD,
					     mode, last_block, data, len, dst);
	nb_blocks = ((len + block_size - 1) / block_size);
	if (nb_blocks < 2)
		return TEE_ERROR_BAD_STATE;
	len_last_block = len % block_size;
	if (len_last_block == 0)
		len_last_block = block_size;
	if (mode == TEE_MODE_ENCRYPT) {
		memcpy(tmp_block,
		       data + ((nb_blocks - 1) * block_size),
		       len_last_block);
		memset(tmp_block + len_last_block,
		       0,
		       block_size - len_last_block);
		res = tee_do_cipher_update(cbc_ctx, TEE_ALG_AES_CBC_NOPAD,
					   mode, 0, data,
					   (nb_blocks - 1) * block_size, dst);
		if (res != TEE_SUCCESS)
			return res;
		memcpy(dst + (nb_blocks - 1) * block_size,
		       dst + (nb_blocks - 2) * block_size,
		       len_last_block);
		res = tee_do_cipher_update(cbc_ctx, TEE_ALG_AES_CBC_NOPAD,
					   mode, 0, tmp_block, block_size,
					   dst + (nb_blocks - 2) * block_size);
		if (res != TEE_SUCCESS)
			return res;
	} else {
		res = tee_do_cipher_update(ecb_ctx, TEE_ALG_AES_ECB_NOPAD,
					   mode, 0,
					   data + (nb_blocks - 2) * block_size,
					   block_size, tmp2_block);
		if (res != TEE_SUCCESS)
			return res;
		memcpy(tmp_block, data + ((nb_blocks - 1) * block_size),
		       len_last_block);
		memcpy(tmp_block + len_last_block, tmp2_block + len_last_block,
		       block_size - len_last_block);
		if (nb_blocks > 2) {
			res = tee_do_cipher_update(cbc_ctx,
						   TEE_ALG_AES_CBC_NOPAD, mode,
						   0, data,
						   (nb_blocks - 2) *
						   block_size, dst);
			if (res != TEE_SUCCESS)
				return res;
		}
		res = tee_do_cipher_update(cbc_ctx, TEE_ALG_AES_CBC_NOPAD,
					   mode, 0, tmp_block, block_size,
					   dst +
					   ((nb_blocks - 2) * block_size));
		if (res != TEE_SUCCESS)
			return res;
		res = tee_do_cipher_update(cbc_ctx, TEE_ALG_AES_CBC_NOPAD,
					   mode, 0, data +
					   ((nb_blocks - 2) * block_size),
					   block_size, tmp_block);
		if (res != TEE_SUCCESS)
			return res;
		memcpy(dst + (nb_blocks - 1) * block_size, tmp_block,
		       len_last_block);
	}
	return TEE_SUCCESS;
}
TEE_Result tee_prng_add_entropy(const uint8_t *in, size_t len)
{
	return crypto_rng_add_entropy(in, len);
}
__weak void plat_prng_add_jitter_entropy(void)
{
	TEE_Time current;
	if (tee_time_get_sys_time(&current) == TEE_SUCCESS)
		tee_prng_add_entropy((uint8_t *)&current, sizeof(current));
}
__weak void plat_prng_add_jitter_entropy_norpc(void)
{
#ifndef CFG_SECURE_TIME_SOURCE_REE
	plat_prng_add_jitter_entropy();
#endif
}
static TEE_Result tee_cryp_init(void)
{
	return crypto_init();
}
service_init(tee_cryp_init);
