#include <asm.S>
#include <arm.h>
FUNC get_core_pos_mpidr , :
	and	x0, x0, #MPIDR_CPU_MASK
	ret
END_FUNC get_core_pos_mpidr
