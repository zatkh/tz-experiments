#include <asm.S>
#include <arm.h>
#include <platform_config.h>
.weak get_core_pos_mpidr
FUNC __get_core_pos , :
	mrs	x0, mpidr_el1
	b get_core_pos_mpidr
END_FUNC __get_core_pos
FUNC get_core_pos_mpidr , :
	and	x1, x0, #MPIDR_CPU_MASK
	and	x0, x0, #MPIDR_CLUSTER_MASK
	add	x0, x1, x0, LSR #(MPIDR_CLUSTER_SHIFT - CFG_CORE_CLUSTER_SHIFT)
	ret
END_FUNC get_core_pos_mpidr
