#include "tee_syscall_numbers.h"
#include "trace_levels.h"
#include <arm.h>
#include <asm.S>
#include <generated/asm-defines.h>
#include <kernel/thread.h>
#include <kernel/unwind.h>
#include <tee_api_defines.h>
	.section .text.arch_svc_asm
FUNC tee_svc_do_call , :
UNWIND(	.fnstart)
UNWIND(	.cantunwind)
	push	{r5-r9, lr}
	mov	r7, sp
	mov	r8, r0
	mov	r9, r1
	ldr	r5, [r8, #THREAD_SVC_REG_R5]
	ldr	r6, [r8, #THREAD_SVC_REG_R6]
	cmp     r6, #0
	beq     .Lno_args
	sub     sp, sp, r6, lsl #2
	bic	sp, sp, #7	
	mov     r0, sp
	mov     r1, r5
	mov     r2, r6, lsl #2
	ldr     lr, =tee_svc_copy_from_user
	blx     lr
	cmp     r0, #0
	bne     .Lret
.Lno_args:
	add	lr, r8, #THREAD_SVC_REG_R0
	ldm	lr, {r0-r3}
	blx	r9
.Lret:
	mov	sp, r7
	pop	{r5-r9, pc}
UNWIND(	.fnend)
END_FUNC tee_svc_do_call
FUNC syscall_sys_return , :
UNWIND(	.fnstart)
	mov	r1, #0	
	mov	r2, #0	
	mov	r3, r8	
	b	tee_svc_sys_return_helper
UNWIND(	.fnend)
END_FUNC syscall_sys_return
FUNC syscall_panic , :
UNWIND(	.fnstart)
	mov	r1, #1	
	mov	r2, r0	
	mov	r3, r8	
	ldr	r0, =TEE_ERROR_TARGET_DEAD
	b	tee_svc_sys_return_helper
UNWIND(	.fnend)
END_FUNC syscall_panic
