#include <arm.h>
#include <arm32.h>
#include <arm32_macros.S>
#include <asm.S>
#include <kernel/unwind.h>
#include <platform_config.h>
.section .text
.balign 4
.code 32
FUNC plat_cpu_reset_early , :
UNWIND(	.fnstart)
	mov_imm r0, 0x00000040
	write_actlr r0
	mov_imm r0, 0x00040C00
	write_nsacr r0
	bx	lr
UNWIND(	.fnend)
END_FUNC plat_cpu_reset_early
FUNC get_core_pos_mpidr , :
UNWIND(	.fnstart)
	and	r0, r0, #MPIDR_CPU_MASK
	bx	lr
UNWIND(	.fnend)
END_FUNC get_core_pos_mpidr
