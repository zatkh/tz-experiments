#include <arm.h>
#include <arm32_macros.S>
#include <asm.S>
#include <keep.h>
#include <kernel/unwind.h>
FUNC cpu_mmu_enable , :
UNWIND(	.fnstart)
	write_tlbiall
	read_sctlr r0
	orr	r0, r0, #SCTLR_M
	write_sctlr r0
	dsb
	isb
	bx	lr
UNWIND(	.fnend)
END_FUNC cpu_mmu_enable
KEEP_PAGER cpu_mmu_enable
FUNC cpu_mmu_enable_icache , :
UNWIND(	.fnstart)
	write_iciallu
	write_bpiall
	read_sctlr r1
	orr	r1, r1, #SCTLR_I
	write_sctlr r1
	dsb
	isb
	bx	lr
UNWIND(	.fnend)
END_FUNC cpu_mmu_enable_icache
KEEP_PAGER cpu_mmu_enable_icache
FUNC cpu_mmu_enable_dcache , :
UNWIND(	.fnstart)
	read_sctlr r0
	orr	r0, r0, #SCTLR_C
	write_sctlr r0
	dsb
	isb
	bx	lr
UNWIND(	.fnend)
END_FUNC cpu_mmu_enable_dcache
KEEP_PAGER cpu_mmu_enable_dcache
