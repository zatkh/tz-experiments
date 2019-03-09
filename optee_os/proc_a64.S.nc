#include <arm64.h>
#include <asm.S>
FUNC cpu_mmu_enable , :
	tlbi	vmalle1
	dsb	sy
	isb
	mrs	x0, sctlr_el1
	orr	x0, x0, #SCTLR_M
	msr	sctlr_el1, x0
	isb
	ret
END_FUNC cpu_mmu_enable
FUNC cpu_mmu_enable_icache , :
	ic	iallu
	isb
	mrs	x0, sctlr_el1
	orr	x0, x0, #SCTLR_I
	msr	sctlr_el1, x0
	isb
	ret
END_FUNC cpu_mmu_enable_icache
FUNC cpu_mmu_enable_dcache , :
	mrs	x0, sctlr_el1
	orr	x0, x0, #SCTLR_C
	msr	sctlr_el1, x0
	isb
	ret
END_FUNC cpu_mmu_enable_dcache
