#include <initcall.h>
#include <io.h>
#include <mm/core_memprot.h>
#include <platform_config.h>
#include <stdint.h>
#if defined(PLATFORM_FLAVOR_rk322x)
#define SGRF_SOC_CON(n)		((n) * 4)
#define DDR_SGRF_DDR_CON(n)	((n) * 4)
#define DDR_RGN0_NS		BIT32(30)
#define SLAVE_ALL_NS		0xffff0000
static TEE_Result platform_init(void)
{
	vaddr_t sgrf_base = (vaddr_t)phys_to_virt_io(SGRF_BASE);
	vaddr_t ddrsgrf_base = (vaddr_t)phys_to_virt_io(DDRSGRF_BASE);
	write32(DDR_RGN0_NS, ddrsgrf_base + DDR_SGRF_DDR_CON(0));
	write32(SLAVE_ALL_NS, sgrf_base + SGRF_SOC_CON(7));
	write32(SLAVE_ALL_NS, sgrf_base + SGRF_SOC_CON(8));
	write32(SLAVE_ALL_NS, sgrf_base + SGRF_SOC_CON(9));
	write32(SLAVE_ALL_NS, sgrf_base + SGRF_SOC_CON(10));
	return TEE_SUCCESS;
}
#endif
service_init(platform_init);
