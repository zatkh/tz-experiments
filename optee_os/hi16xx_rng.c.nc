#include <initcall.h>
#include <io.h>
#include <kernel/mutex.h>
#include <kernel/tee_time.h>
#include <mm/core_memprot.h>
#include <mm/core_mmu.h>
#include <platform_config.h>
#include <rng_support.h>
#include <trace.h>
#include <types_ext.h>
#include <util.h>
#define ALG_SC_RNG_RESET_DREQ	0xAB4	
#  define ALG_SC_SRST_DREQ_RNG	BIT(0)
#define	RNG_SEED	0x0	
#define RNG_CTRL	0x4	
#  define RNG_SEED_SEL	BIT(2)	
#  define RNG_RING_EN	BIT(1)	
#  define RNG_EN	BIT(0)	
#define RNG_NUM		0x10	
#define RNG_PHY_SEED	0x14	
register_phys_mem(MEM_AREA_IO_SEC, ALG_SC_BASE, ALG_SC_REG_SIZE);
register_phys_mem(MEM_AREA_IO_SEC, RNG_BASE, RNG_REG_SIZE);
static struct mutex rng_mutex = MUTEX_INITIALIZER;
static TEE_Result hi16xx_rng_init(void)
{
	vaddr_t alg = (vaddr_t)phys_to_virt(ALG_SC_BASE, MEM_AREA_IO_SEC);
	vaddr_t rng = (vaddr_t)phys_to_virt(RNG_BASE, MEM_AREA_IO_SEC);
	TEE_Time time;
	write32(ALG_SC_SRST_DREQ_RNG, alg + ALG_SC_RNG_RESET_DREQ);
	tee_time_get_sys_time(&time);
	write32(time.seconds * 1000 + time.millis, rng + RNG_SEED);
	write32(RNG_EN | RNG_RING_EN | RNG_SEED_SEL, rng + RNG_CTRL);
	IMSG("Hi16xx RNG initialized");
	return TEE_SUCCESS;
}
uint8_t hw_get_random_byte(void)
{
	static vaddr_t r;
	static int pos;
	static union {
		uint32_t val;
		uint8_t byte[4];
	} random;
	uint8_t ret;
	mutex_lock(&rng_mutex);
	if (!r)
		r = (vaddr_t)phys_to_virt(RNG_BASE, MEM_AREA_IO_SEC) + RNG_NUM;
	if (!pos)
		random.val = read32(r);
	ret = random.byte[pos++];
	if (pos == 4)
		pos = 0;
	mutex_unlock(&rng_mutex);
	return ret;
}
driver_init(hi16xx_rng_init);
