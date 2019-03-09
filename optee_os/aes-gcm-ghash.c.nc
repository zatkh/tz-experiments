#include <crypto/internal_aes-gcm.h>
#include <kernel/panic.h>
#include <string.h>
#include <tee_api_types.h>
#include <types_ext.h>
#include "aes-gcm-private.h"
static void gfmul(const uint64_t X[2], const uint64_t Y[2], uint64_t product[2])
{
	uint64_t y[2];
	uint64_t z[2] = { 0 };
	const uint8_t *x = (const uint8_t *)X;
	uint32_t mul;
	size_t n;
	y[0] = TEE_U64_FROM_BIG_ENDIAN(Y[0]);
	y[1] = TEE_U64_FROM_BIG_ENDIAN(Y[1]);
	for (n = 0; n < TEE_AES_BLOCK_SIZE * 8; n++) {
		if (x[n >> 3] & (1 << (~n & 7)))
			internal_aes_gcm_xor_block(z, y);
		mul = y[1] & 1;
		y[1] = (y[0] << 63) | (y[1] >> 1);
		y[0] = (y[0] >> 1) ^ (0xe100000000000000 * mul);
	}
	product[0] = TEE_U64_TO_BIG_ENDIAN(z[0]);
	product[1] = TEE_U64_TO_BIG_ENDIAN(z[1]);
}
void internal_aes_gcm_ghash_update_block(struct internal_aes_gcm_state *state,
					 const void *data)
{
	void *y = state->hash_state;
	internal_aes_gcm_xor_block(y, data);
	gfmul((void *)state->hash_subkey, y, y);
}
