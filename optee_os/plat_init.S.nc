#include <arm32.h>
#include <arm32_macros.S>
#include <arm32_macros_cortex_a9.S>
#include <asm.S>
#include <kernel/tz_ssvce_def.h>
#include <kernel/unwind.h>
#include <platform_config.h>
#define ZYNQ_SLCR_L2C_RAM	0xF8000A1C
.section .text
.balign 4
.code 32
FUNC plat_cpu_reset_early , :
UNWIND(	.fnstart)
	mov r0, #SCR_AW
	write_scr r0		
	mov_imm r0, 0x00004000
	write_sctlr r0
	mov_imm r0, 0x00000041
	write_actlr r0
	mov_imm r0, 0x00020C00
	write_nsacr r0
	mov_imm r0, 0x00000001
	write_pcr r0
	mov pc, lr
UNWIND(	.fnend)
END_FUNC plat_cpu_reset_early
