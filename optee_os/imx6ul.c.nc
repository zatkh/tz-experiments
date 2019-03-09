#include <arm32.h>
#include <io.h>
#include <kernel/generic_boot.h>
#include <platform_config.h>
#include <stdint.h>
static void init_csu(void)
{
	uintptr_t addr;
	for (addr = CSU_BASE + CSU_CSL_START;
	     addr != CSU_BASE + CSU_CSL_END;
	     addr += 4)
		write32(CSU_ACCESS_ALL, addr);
	for (addr = CSU_BASE + CSU_CSL_START;
	     addr != CSU_BASE + CSU_CSL_END;
	     addr += 4)
		write32(read32(addr) | CSU_SETTING_LOCK, addr);
}
void plat_cpu_reset_late(void)
{
	init_csu();
}
