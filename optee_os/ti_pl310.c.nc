#include <arm32.h>
#include <io.h>
#include <kernel/generic_boot.h>
#include <kernel/tz_ssvce_def.h>
#include <kernel/tz_ssvce_pl310.h>
#include <mm/core_memprot.h>
#include <platform_config.h>
register_phys_mem(MEM_AREA_IO_SEC, PL310_BASE, PL310_SIZE);
vaddr_t pl310_base(void)
{
	static void *va;
	if (cpu_mmu_enabled()) {
		if (!va)
			va = phys_to_virt(PL310_BASE, MEM_AREA_IO_SEC);
		return (vaddr_t)va;
	}
	return PL310_BASE;
}
void arm_cl2_config(vaddr_t pl310_base)
{
	(void)pl310_base;
}
void arm_cl2_enable(vaddr_t pl310_base)
{
	(void)pl310_base;
}
