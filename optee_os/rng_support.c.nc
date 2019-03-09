#include <io.h>
#include <kernel/panic.h>
#include <mm/core_mmu.h>
#include <mm/core_memprot.h>
#include <platform_config.h>
#include <trace.h>
#include "rng_support.h"
#define RNG_VAL_OFFSET             0x24
#define RNG_STATUS_OFFSET          0x20
#define RNG_STATUS_ERR0		BIT32(0)
#define RNG_STATUS_ERR1		BIT32(1)
#define RNG_STATUS_FULL		BIT32(5)
static vaddr_t rng_base(void)
{
	static void *va;
	if (cpu_mmu_enabled()) {
		if (!va)
			va = phys_to_virt(RNG_BASE, MEM_AREA_IO_SEC);
		return (vaddr_t)va;
	}
	return RNG_BASE;
}
static inline int hwrng_waithost_fifo_full(void)
{
	uint32_t status;
	do {
		status = read32(rng_base() + RNG_STATUS_OFFSET);
	} while (!(status & RNG_STATUS_FULL));
	if (status & (RNG_STATUS_ERR0 | RNG_STATUS_ERR1))
		return 1;
	return 0;
}
uint8_t hw_get_random_byte(void)
{
#define _LOCAL_FIFO_SIZE 8     
	static uint8_t lfifo[_LOCAL_FIFO_SIZE];     
	static int pos = -1;
	static int nbcall;  
	volatile uint32_t tmpval[_LOCAL_FIFO_SIZE/2];
	uint8_t value;
	int i;
	nbcall++;
	if (pos >= 0) {
		pos++;
		value = lfifo[pos];
		if (pos == (_LOCAL_FIFO_SIZE - 1))
			pos = -1;
		return value;
	}
	if (hwrng_waithost_fifo_full())
		return 0;
	for (i = 0; i < _LOCAL_FIFO_SIZE / 2; i++)
		tmpval[i] = read32(rng_base() + RNG_VAL_OFFSET) & 0xFFFF;
	pos = 0;
	for (i = 0; i < _LOCAL_FIFO_SIZE / 2; i++) {
		lfifo[pos] = tmpval[i] & 0xFF;
		pos++;
		lfifo[pos] = (tmpval[i] >> 8) & 0xFF;
		pos++;
	};
	pos = 0;
	return lfifo[pos];
}
