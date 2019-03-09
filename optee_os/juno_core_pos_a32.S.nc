#include <asm.S>
#include <arm.h>
#include <arm32_macros.S>
#include <kernel/unwind.h>
FUNC get_core_pos_mpidr , :
UNWIND(	.fnstart)
	and	r1, r0, #MPIDR_CPU_MASK
	and	r0, r0, #MPIDR_CLUSTER_MASK
	eor	r0, r0, #(1 << MPIDR_CLUSTER_SHIFT)
	add	r0, r1, r0, LSR #6
	bx	lr
UNWIND(	.fnend)
END_FUNC get_core_pos_mpidr
