#ifndef THREAD_PRIVATE_H
#define THREAD_PRIVATE_H
#ifndef ASM
#include <mm/core_mmu.h>
#include <mm/pgt_cache.h>
#include <kernel/vfp.h>
#include <kernel/mutex.h>
#include <kernel/thread.h>
enum thread_state {
	THREAD_STATE_FREE,
	THREAD_STATE_SUSPENDED,
	THREAD_STATE_ACTIVE,
};
#ifdef ARM32
struct thread_ctx_regs {
	uint32_t r0;
	uint32_t r1;
	uint32_t r2;
	uint32_t r3;
	uint32_t r4;
	uint32_t r5;
	uint32_t r6;
	uint32_t r7;
	uint32_t r8;
	uint32_t r9;
	uint32_t r10;
	uint32_t r11;
	uint32_t r12;
	uint32_t usr_sp;
	uint32_t usr_lr;
	uint32_t svc_spsr;
	uint32_t svc_sp;
	uint32_t svc_lr;
	uint32_t pc;
	uint32_t cpsr;
};
#endif 
#ifdef ARM64
struct thread_ctx_regs {
	uint64_t sp;
	uint64_t pc;
	uint64_t cpsr;
	uint64_t x[31];
};
#endif 
#ifdef ARM64
struct thread_user_mode_rec {
	uint64_t exit_status0_ptr;
	uint64_t exit_status1_ptr;
	uint64_t x[31 - 19]; 
};
#endif 
#ifdef CFG_WITH_VFP
struct thread_vfp_state {
	bool ns_saved;
	bool sec_saved;
	bool sec_lazy_saved;
	struct vfp_state ns;
	struct vfp_state sec;
	struct thread_user_vfp_state *uvfp;
};
#endif 
struct thread_ctx {
	struct thread_ctx_regs regs;
	enum thread_state state;
	vaddr_t stack_va_end;
	uint32_t hyp_clnt_id;
	uint32_t flags;
	struct core_mmu_user_map user_map;
	bool have_user_map;
#ifdef ARM64
	vaddr_t kern_sp;	
#endif
#ifdef CFG_WITH_VFP
	struct thread_vfp_state vfp_state;
#endif
	void *rpc_arg;
	uint64_t rpc_carg;
	struct mobj *rpc_mobj;
	struct mutex_head mutexes;
	struct thread_specific_data tsd;
};
#endif 
#ifdef ARM64
#ifdef CFG_WITH_VFP
#define THREAD_VFP_STATE_SIZE				\
	(16 + (16 * 32 + 16) * 2 + 16)
#else
#define THREAD_VFP_STATE_SIZE				0
#endif
#endif 
#define THREAD_CLF_SAVED_SHIFT			4
#define THREAD_CLF_CURR_SHIFT			0
#define THREAD_CLF_MASK				0xf
#define THREAD_CLF_TMP_SHIFT			0
#define THREAD_CLF_ABORT_SHIFT			1
#define THREAD_CLF_IRQ_SHIFT			2
#define THREAD_CLF_FIQ_SHIFT			3
#define THREAD_CLF_TMP				(1 << THREAD_CLF_TMP_SHIFT)
#define THREAD_CLF_ABORT			(1 << THREAD_CLF_ABORT_SHIFT)
#define THREAD_CLF_IRQ				(1 << THREAD_CLF_IRQ_SHIFT)
#define THREAD_CLF_FIQ				(1 << THREAD_CLF_FIQ_SHIFT)
#ifndef ASM
extern const void *stack_tmp_export;
extern const uint32_t stack_tmp_stride;
extern struct thread_ctx threads[];
extern thread_smc_handler_t thread_std_smc_handler_ptr;
extern thread_nintr_handler_t thread_nintr_handler_ptr;
extern thread_pm_handler_t thread_cpu_on_handler_ptr;
extern thread_pm_handler_t thread_cpu_off_handler_ptr;
extern thread_pm_handler_t thread_cpu_suspend_handler_ptr;
extern thread_pm_handler_t thread_cpu_resume_handler_ptr;
extern thread_pm_handler_t thread_system_off_handler_ptr;
extern thread_pm_handler_t thread_system_reset_handler_ptr;
extern long thread_user_kcode_offset;
void thread_init_vbar(vaddr_t addr);
void thread_excp_vect(void);
void thread_excp_vect_workaround(void);
void thread_excp_vect_workaround_a15(void);
void thread_excp_vect_end(void);
void thread_std_smc_entry(void);
void thread_resume(struct thread_ctx_regs *regs);
uint32_t __thread_enter_user_mode(unsigned long a0, unsigned long a1,
		unsigned long a2, unsigned long a3, unsigned long user_sp,
		unsigned long user_func, unsigned long spsr,
		uint32_t *exit_status0, uint32_t *exit_status1);
void *thread_get_tmp_sp(void);
int thread_state_suspend(uint32_t flags, uint32_t cpsr, vaddr_t pc);
void thread_state_free(void);
struct thread_ctx_regs *thread_get_ctx_regs(void);
#ifdef ARM32
void thread_set_abt_sp(vaddr_t sp);
void thread_set_und_sp(vaddr_t sp);
void thread_set_irq_sp(vaddr_t sp);
void thread_set_fiq_sp(vaddr_t sp);
#endif 
void thread_handle_fast_smc(struct thread_smc_args *args);
void thread_handle_std_smc(struct thread_smc_args *args);
#define THREAD_RPC_NUM_ARGS     6
void thread_rpc(uint32_t rv[THREAD_RPC_NUM_ARGS]);
void thread_check_canaries(void);
void __thread_std_smc_entry(struct thread_smc_args *args);
#endif 
#endif 
