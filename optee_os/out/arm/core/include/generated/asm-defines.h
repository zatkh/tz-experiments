#ifndef out_arm_core_include_generated_asm_defines_h
#define out_arm_core_include_generated_asm_defines_h
#define THREAD_SMC_ARGS_X0	0	/* offsetof(struct thread_smc_args, a0)	*/
#define THREAD_SMC_ARGS_SIZE	64	/* sizeof(struct thread_smc_args)	*/
#define THREAD_SVC_REG_X0	16	/* offsetof(struct thread_svc_regs, x0)	*/
#define THREAD_SVC_REG_X2	32	/* offsetof(struct thread_svc_regs, x2)	*/
#define THREAD_SVC_REG_X5	56	/* offsetof(struct thread_svc_regs, x5)	*/
#define THREAD_SVC_REG_X6	64	/* offsetof(struct thread_svc_regs, x6)	*/
#define THREAD_SVC_REG_X30	136	/* offsetof(struct thread_svc_regs, x30)	*/
#define THREAD_SVC_REG_ELR	0	/* offsetof(struct thread_svc_regs, elr)	*/
#define THREAD_SVC_REG_SPSR	8	/* offsetof(struct thread_svc_regs, spsr)	*/
#define THREAD_SVC_REG_SP_EL0	144	/* offsetof(struct thread_svc_regs, sp_el0)	*/
#define THREAD_SVC_REG_SIZE	160	/* sizeof(struct thread_svc_regs)	*/
#define THREAD_ABT_REG_X0	0	/* offsetof(struct thread_abort_regs, x0)	*/
#define THREAD_ABT_REG_X2	16	/* offsetof(struct thread_abort_regs, x2)	*/
#define THREAD_ABT_REG_X30	240	/* offsetof(struct thread_abort_regs, x30)	*/
#define THREAD_ABT_REG_SPSR	256	/* offsetof(struct thread_abort_regs, spsr)	*/
#define THREAD_ABT_REGS_SIZE	272	/* sizeof(struct thread_abort_regs)	*/
#define THREAD_CTX_KERN_SP	320	/* offsetof(struct thread_ctx, kern_sp)	*/
#define THREAD_CTX_SIZE	1536	/* sizeof(struct thread_ctx)	*/
#define THREAD_CTX_REGS_SP	0	/* offsetof(struct thread_ctx_regs, sp)	*/
#define THREAD_CTX_REGS_X0	24	/* offsetof(struct thread_ctx_regs, x[0])	*/
#define THREAD_CTX_REGS_X1	32	/* offsetof(struct thread_ctx_regs, x[1])	*/
#define THREAD_CTX_REGS_X4	56	/* offsetof(struct thread_ctx_regs, x[4])	*/
#define THREAD_CTX_REGS_X19	176	/* offsetof(struct thread_ctx_regs, x[19])	*/
#define THREAD_USER_MODE_REC_EXIT_STATUS0_PTR	0	/* offsetof(struct thread_user_mode_rec, exit_status0_ptr)	*/
#define THREAD_USER_MODE_REC_X19	16	/* offsetof(struct thread_user_mode_rec, x[0])	*/
#define THREAD_USER_MODE_REC_SIZE	112	/* sizeof(struct thread_user_mode_rec)	*/
#define THREAD_CORE_LOCAL_X0	0	/* offsetof(struct thread_core_local, x[0])	*/
#define THREAD_CORE_LOCAL_X2	16	/* offsetof(struct thread_core_local, x[2])	*/
#define THREAD_CORE_LOCAL_TMP_STACK_VA_END	32	/* offsetof(struct thread_core_local, tmp_stack_va_end)	*/
#define THREAD_CORE_LOCAL_CURR_THREAD	40	/* offsetof(struct thread_core_local, curr_thread)	*/
#define THREAD_CORE_LOCAL_FLAGS	44	/* offsetof(struct thread_core_local, flags)	*/
#define THREAD_CORE_LOCAL_ABT_STACK_VA_END	48	/* offsetof(struct thread_core_local, abt_stack_va_end)	*/
#endif
