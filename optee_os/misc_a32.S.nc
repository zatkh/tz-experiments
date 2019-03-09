#include <asm.S>
#include <arm.h>
#include <arm32_macros.S>
#include <kernel/unwind.h>
#include <platform_config.h>
.weak get_core_pos_mpidr
FUNC __get_core_pos , :
UNWIND(	.fnstart)
	read_mpidr r0
	b get_core_pos_mpidr
UNWIND(	.fnend)
END_FUNC __get_core_pos
FUNC get_core_pos_mpidr , :
UNWIND(	.fnstart)
	and	r1, r0, #MPIDR_CPU_MASK
	and	r0, r0, #MPIDR_CLUSTER_MASK
	add	r0, r1, r0, LSR #(MPIDR_CLUSTER_SHIFT - CFG_CORE_CLUSTER_SHIFT)
	bx	lr
UNWIND(	.fnend)
END_FUNC get_core_pos_mpidr
LOCAL_FUNC temp_set_mode , :
UNWIND(	.fnstart)
	mov	r1, r0
	cmp	r1, #CPSR_MODE_USR	
	moveq	r1, #CPSR_MODE_SYS
	cpsid	aif			
	mrs	r0, cpsr		
	bic	r0, #CPSR_MODE_MASK	
	orr	r0, r1			
	bx	lr
UNWIND(	.fnend)
END_FUNC temp_set_mode
FUNC read_mode_sp , :
UNWIND(	.fnstart)
	push	{r4, lr}
UNWIND(	.save	{r4, lr})
	mrs	r4, cpsr		
	bl	temp_set_mode
	msr	cpsr, r0		
	mov	r0, sp			
	msr	cpsr, r4		
	pop	{r4, pc}
UNWIND(	.fnend)
END_FUNC read_mode_sp
FUNC read_mode_lr , :
UNWIND(	.fnstart)
	push	{r4, lr}
UNWIND(	.save	{r4, lr})
	mrs	r4, cpsr		
	bl	temp_set_mode
	msr	cpsr, r0		
	mov	r0, lr			
	msr	cpsr, r4		
	pop	{r4, pc}
UNWIND(	.fnend)
END_FUNC read_mode_lr
