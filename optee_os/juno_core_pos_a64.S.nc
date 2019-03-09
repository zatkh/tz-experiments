#include <asm.S>
#include <arm.h>
FUNC get_core_pos_mpidr , :
	and	x1, x0, #MPIDR_CPU_MASK
	and	x0, x0, #MPIDR_CLUSTER_MASK
	eor	x0, x0, #(1 << MPIDR_CLUSTER_SHIFT)
	add	x0, x1, x0, LSR #6
	ret
END_FUNC get_core_pos_mpidr
