#include <arm.h>
#include <arm32.h>
#include <console.h>
#include <drivers/imx_uart.h>
#include <io.h>
#include <imx.h>
#include <imx_pm.h>
#include <kernel/panic.h>
#include <kernel/cache_helpers.h>
#include <kernel/generic_boot.h>
#include <kernel/misc.h>
#include <mm/core_mmu.h>
#include <mm/core_memprot.h>
#include <sm/sm.h>
#include <sm/pm.h>
#include <sm/psci.h>
#include <stdint.h>
static int suspended_init;
int imx7_cpu_suspend(uint32_t power_state __unused, uintptr_t entry,
		     uint32_t context_id __unused, struct sm_nsec_ctx *nsec)
{
	uint32_t suspend_ocram_base = core_mmu_get_va(TRUSTZONE_OCRAM_START +
						      SUSPEND_OCRAM_OFFSET,
						      MEM_AREA_TEE_COHERENT);
	struct imx7_pm_info *p = (struct imx7_pm_info *)suspend_ocram_base;
	int ret;
	if (!suspended_init) {
		imx7_suspend_init();
		suspended_init = 1;
	}
	sm_save_modes_regs(&nsec->mode_regs);
	ret = sm_pm_cpu_suspend((uint32_t)p, (int (*)(uint32_t))
				(suspend_ocram_base + sizeof(*p)));
	if (ret < 0) {
		DMSG("=== Not suspended, GPC IRQ Pending ===\n");
		return 0;
	}
	plat_cpu_reset_late();
	sm_restore_modes_regs(&nsec->mode_regs);
	nsec->mon_lr = (uint32_t)entry;
	main_init_gic();
	DMSG("=== Back from Suspended ===\n");
	return 0;
}
