#include <arm32.h>
#include <console.h>
#include <drivers/imx_uart.h>
#include <drivers/tzc380.h>
#include <io.h>
#include <kernel/generic_boot.h>
#include <kernel/panic.h>
#include <kernel/misc.h>
#include <kernel/pm_stubs.h>
#include <mm/core_mmu.h>
#include <mm/core_memprot.h>
#include <platform_config.h>
#include <imx.h>
#include <stdint.h>
#include <sm/optee_smc.h>
#include <sm/psci.h>
#include <tee/entry_std.h>
#include <tee/entry_fast.h>
#include <util.h>
void plat_cpu_reset_late(void)
{
	uintptr_t addr;
	uint32_t val;
	if (get_core_pos() != 0)
		return;
	for (addr = CSU_CSL_START; addr != CSU_CSL_END; addr += 4)
		write32(CSU_ACCESS_ALL, core_mmu_get_va(addr, MEM_AREA_IO_SEC));
	dsb();
	write32(0x003300FF, core_mmu_get_va(CSU_CSL_59, MEM_AREA_IO_SEC));
	write32(0x00FF0033, core_mmu_get_va(CSU_CSL_28, MEM_AREA_IO_SEC));
	write32(0x00FF0033, core_mmu_get_va(CSU_CSL_15, MEM_AREA_IO_SEC));
	dsb();
	for (addr = CSU_CSL_START; addr != CSU_CSL_END; addr += 4) {
		val = read32(core_mmu_get_va(addr, MEM_AREA_IO_SEC));
		write32(val | CSU_SETTING_LOCK,
			core_mmu_get_va(addr, MEM_AREA_IO_SEC));
	}
}
