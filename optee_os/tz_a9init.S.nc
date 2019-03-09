#include <arm32.h>
#include <arm32_macros.S>
#include <arm32_macros_cortex_a9.S>
#include <asm.S>
#include <kernel/tz_ssvce_def.h>
#include <kernel/unwind.h>
#include <platform_config.h>
.section .text
.balign 4
.code 32
FUNC arm_cl2_enable , :
UNWIND(	.fnstart)
	mov  r1, #0x1
	str  r1, [r0, #PL310_CTRL]
	ldr  r1, [r0, #PL310_AUX_CTRL]
	tst  r1, #(1 << 0) 
	read_actlr r0
	orrne r0, r0, #(1 << 3) 
	write_actlr r0
	mov pc, lr
UNWIND(	.fnend)
END_FUNC arm_cl2_enable
FUNC plat_cpu_reset_early , :
UNWIND(	.fnstart)
	mov_imm r0, CPU_SCTLR_INIT
	write_sctlr r0
	mov_imm r0, CPU_ACTLR_INIT
	write_actlr r0
	mov_imm r0, CPU_NSACR_INIT
	write_nsacr r0
	mov_imm r0, CPU_PCR_INIT
	write_pcr r0
	mov pc, lr
UNWIND(	.fnend)
END_FUNC plat_cpu_reset_early
