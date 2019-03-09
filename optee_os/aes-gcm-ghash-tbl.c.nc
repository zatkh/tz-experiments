#include <crypto/aes-gcm.h>
#include <io.h>
#include <kernel/panic.h>
#include <string.h>
#include <tee_api_types.h>
#include <types_ext.h>
#include "aes-gcm-private.h"
void internal_aes_gcm_ghash_gen_tbl(struct internal_aes_gcm_state *state,
				    const struct internal_aes_gcm_key *ek)
{
	int i, j;
	uint64_t vl, vh;
	unsigned char h[16];
	memset(h, 0, 16);
	internal_aes_gcm_encrypt_block(ek, h, h);
	vh = get_be64(h);
	vl = get_be64(h + 8);
	state->HL[8] = vl;
	state->HH[8] = vh;
	state->HH[0] = 0;
	state->HL[0] = 0;
	for (i = 4; i > 0; i >>= 1) {
		uint32_t T = (vl & 1) * 0xe1000000U;
		vl  = (vh << 63) | (vl >> 1);
		vh  = (vh >> 1) ^ ((uint64_t)T << 32);
		state->HL[i] = vl;
		state->HH[i] = vh;
	}
	for (i = 2; i <= 8; i *= 2) {
		uint64_t *HiL = state->HL + i, *HiH = state->HH + i;
		vh = *HiH;
		vl = *HiL;
		for (j = 1; j < i; j++) {
			HiH[j] = vh ^ state->HH[j];
			HiL[j] = vl ^ state->HL[j];
		}
	}
}
static const uint64_t last4[16] = {
	0x0000, 0x1c20, 0x3840, 0x2460,
	0x7080, 0x6ca0, 0x48c0, 0x54e0,
	0xe100, 0xfd20, 0xd940, 0xc560,
	0x9180, 0x8da0, 0xa9c0, 0xb5e0
};
static void gcm_mult(struct internal_aes_gcm_state *state,
		     const unsigned char x[16], unsigned char output[16])
{
	int i = 0;
	unsigned char lo, hi, rem;
	uint64_t zh, zl;
	lo = x[15] & 0xf;
	zh = state->HH[lo];
	zl = state->HL[lo];
	for (i = 15; i >= 0; i--) {
		lo = x[i] & 0xf;
		hi = x[i] >> 4;
		if (i != 15) {
			rem = (unsigned char)zl & 0xf;
			zl = (zh << 60) | (zl >> 4);
			zh = (zh >> 4);
			zh ^= (uint64_t)last4[rem] << 48;
			zh ^= state->HH[lo];
			zl ^= state->HL[lo];
		}
		rem = (unsigned char)zl & 0xf;
		zl = (zh << 60) | (zl >> 4);
		zh = (zh >> 4);
		zh ^= (uint64_t)last4[rem] << 48;
		zh ^= state->HH[hi];
		zl ^= state->HL[hi];
	}
	put_be64(output, zh);
	put_be64(output + 8, zl);
}
void internal_aes_gcm_ghash_update_block(struct internal_aes_gcm_state *state,
					 const void *data)
{
	void *y = state->hash_state;
	internal_aes_gcm_xor_block(y, data);
	gcm_mult(state, y, y);
}
