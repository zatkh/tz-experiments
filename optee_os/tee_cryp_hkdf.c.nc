#include <crypto/crypto.h>
#include <stdlib.h>
#include <string.h>
#include <tee/tee_cryp_hkdf.h>
#include <tee/tee_cryp_utl.h>
#include <utee_defines.h>
static const uint8_t zero_salt[TEE_MAX_HASH_SIZE];
static TEE_Result hkdf_extract(uint32_t hash_id, const uint8_t *ikm,
			       size_t ikm_len, const uint8_t *salt,
			       size_t salt_len, uint8_t *prk, size_t *prk_len)
{
	TEE_Result res;
	void *ctx = NULL;
	uint32_t hash_algo = TEE_ALG_HASH_ALGO(hash_id);
	uint32_t hmac_algo = (TEE_OPERATION_MAC << 28) | hash_id;
	if (!salt || !salt_len) {
		salt = zero_salt;
		res = tee_hash_get_digest_size(hash_algo, &salt_len);
		if (res != TEE_SUCCESS)
			goto out;
	}
	res = crypto_mac_alloc_ctx(&ctx, hmac_algo);
	if (res)
		goto out;
	res = crypto_mac_init(ctx, hmac_algo, salt, salt_len);
	if (res != TEE_SUCCESS)
		goto out;
	res = crypto_mac_update(ctx, hmac_algo, ikm, ikm_len);
	if (res != TEE_SUCCESS)
		goto out;
	res = crypto_mac_final(ctx, hmac_algo, prk, *prk_len);
	if (res != TEE_SUCCESS)
		goto out;
	res = tee_hash_get_digest_size(hash_algo, prk_len);
out:
	crypto_mac_free_ctx(ctx, hmac_algo);
	return res;
}
static TEE_Result hkdf_expand(uint32_t hash_id, const uint8_t *prk,
			      size_t prk_len, const uint8_t *info,
			      size_t info_len, uint8_t *okm, size_t okm_len)
{
	uint8_t tn[TEE_MAX_HASH_SIZE];
	size_t tn_len, hash_len, i, n, where;
	TEE_Result res = TEE_SUCCESS;
	void *ctx = NULL;
	uint32_t hash_algo = TEE_ALG_HASH_ALGO(hash_id);
	uint32_t hmac_algo = TEE_ALG_HMAC_ALGO(hash_id);
	res = tee_hash_get_digest_size(hash_algo, &hash_len);
	if (res != TEE_SUCCESS)
		goto out;
	if (!okm || prk_len < hash_len) {
		res = TEE_ERROR_BAD_STATE;
		goto out;
	}
	if (!info)
		info_len = 0;
	res = crypto_mac_alloc_ctx(&ctx, hmac_algo);
	if (res)
		goto out;
	n = okm_len / hash_len;
	if ((okm_len % hash_len) != 0)
		n++;
	if (n > 255) {
		res = TEE_ERROR_BAD_PARAMETERS;
		goto out;
	}
	tn_len = 0;
	where = 0;
	for (i = 1; i <= n; i++) {
		uint8_t c = i;
		res = crypto_mac_init(ctx, hmac_algo, prk, prk_len);
		if (res != TEE_SUCCESS)
			goto out;
		res = crypto_mac_update(ctx, hmac_algo, tn, tn_len);
		if (res != TEE_SUCCESS)
			goto out;
		res = crypto_mac_update(ctx, hmac_algo, info, info_len);
		if (res != TEE_SUCCESS)
			goto out;
		res = crypto_mac_update(ctx, hmac_algo, &c, 1);
		if (res != TEE_SUCCESS)
			goto out;
		res = crypto_mac_final(ctx, hmac_algo, tn, sizeof(tn));
		if (res != TEE_SUCCESS)
			goto out;
		memcpy(okm + where, tn, (i < n) ? hash_len : (okm_len - where));
		where += hash_len;
		tn_len = hash_len;
	}
out:
	crypto_mac_free_ctx(ctx, hmac_algo);
	return res;
}
TEE_Result tee_cryp_hkdf(uint32_t hash_id, const uint8_t *ikm, size_t ikm_len,
			 const uint8_t *salt, size_t salt_len,
			 const uint8_t *info, size_t info_len, uint8_t *okm,
			 size_t okm_len)
{
	TEE_Result res;
	uint8_t prk[TEE_MAX_HASH_SIZE];
	size_t prk_len = sizeof(prk);
	res = hkdf_extract(hash_id, ikm, ikm_len, salt, salt_len, prk,
			   &prk_len);
	if (res != TEE_SUCCESS)
		return res;
	res = hkdf_expand(hash_id, prk, prk_len, info, info_len, okm,
			  okm_len);
	return res;
}
