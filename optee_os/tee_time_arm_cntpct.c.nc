#include <kernel/misc.h>
#include <kernel/tee_time.h>
#include <trace.h>
#include <kernel/time_source.h>
#include <mm/core_mmu.h>
#include <utee_defines.h>
#include <tee/tee_cryp_utl.h>
#include <stdint.h>
#include <mpa.h>
#include <arm.h>
static TEE_Result arm_cntpct_get_sys_time(TEE_Time *time)
{
	uint64_t cntpct = read_cntpct();
	uint32_t cntfrq = read_cntfrq();
	time->seconds = cntpct / cntfrq;
	time->millis = (cntpct % cntfrq) / (cntfrq / TEE_TIME_MILLIS_BASE);
	return TEE_SUCCESS;
}
static const struct time_source arm_cntpct_time_source = {
	.name = "arm cntpct",
	.protection_level = 1000,
	.get_sys_time = arm_cntpct_get_sys_time,
};
REGISTER_TIME_SOURCE(arm_cntpct_time_source)
void plat_prng_add_jitter_entropy(void)
{
	uint64_t tsc = read_cntpct();
	int bytes = 0, n;
	static uint8_t first, bits;
	static uint16_t acc;
	if (!first) {
		acc = tsc;
		bytes = 2;
		first = 1;
	} else {
		acc = (acc << 2) | ((acc >> 6) & 3);
		for (n = 0; n < 64; n += 2)
			acc ^= (tsc >> n) & 3;
		bits += 2;
		if (bits >= 8) {
			bits = 0;
			bytes = 1;
		}
	}
	if (bytes) {
		FMSG("%s: 0x%02X\n", __func__,
		     (int)acc & ((1 << (bytes * 8)) - 1));
		tee_prng_add_entropy((uint8_t *)&acc, bytes);
	}
}
