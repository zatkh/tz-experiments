#include <asm.S>
#include <arm.h>
#include <arm32_macros.S>
#include <kernel/unwind.h>
FUNC get_core_pos_mpidr , :
UNWIND(	.fnstart)
	and	r0, r0, #MPIDR_CPU_MASK
	bx	lr
UNWIND(	.fnend)
END_FUNC get_core_pos_mpidr
