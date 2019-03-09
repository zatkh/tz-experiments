#ifndef KERNEL_THREAD_H
#define KERNEL_THREAD_H
#ifndef ASM
#include <arm.h>
#include <types_ext.h>
#include <compiler.h>
#include <optee_msg.h>
#include <kernel/mutex.h>
#include <kernel/vfp.h>
#include <mm/pgt_cache.h>
#endif
#define THREAD_ID_0		0
#define THREAD_ID_INVALID	-1
#define THREAD_RPC_MAX_NUM_PARAMS	4
#ifndef ASM
#ifdef ARM64
#define THREAD_CORE_LOCAL_ALIGNED __aligned(16)
#else
#define THREAD_CORE_LOCAL_ALIGNED __aligned(8)
#endif
struct thread_core_local {
#ifdef ARM32
	uint32_t r[2];
	paddr_t sm_pm_ctx_phys;
#endif
#ifdef ARM64
	uint64_t x[4];
#endif
	vaddr_t tmp_stack_va_end;
	int curr_thread;
	uint32_t flags;
	vaddr_t abt_stack_va_end;
#ifdef CFG_TEE_CORE_DEBUG
	unsigned int locked_count; 
#endif
} THREAD_CORE_LOCAL_ALIGNED;
struct thread_vector_table {
	uint32_t std_smc_entry;
	uint32_t fast_smc_entry;
	uint32_t cpu_on_entry;
	uint32_t cpu_off_entry;
	uint32_t cpu_resume_entry;
	uint32_t cpu_suspend_entry;
	uint32_t fiq_entry;
	uint32_t system_off_entry;
	uint32_t system_reset_entry;
};
extern struct thread_vector_table thread_vector_table;
struct thread_specific_data {
	TAILQ_HEAD(, tee_ta_session) sess_stack;
	struct tee_ta_ctx *ctx;
	struct pgt_cache pgt_cache;
	void *rpc_fs_payload;
	struct mobj *rpc_fs_payload_mobj;
	uint64_t rpc_fs_payload_cookie;
	size_t rpc_fs_payload_size;
};
struct thread_user_vfp_state {
	struct vfp_state vfp;
	bool lazy_saved;
	bool saved;
};
#ifdef ARM32
struct thread_smc_args {
	uint32_t a0;	
	uint32_t a1;	
	uint32_t a2;	
	uint32_t a3;	
	uint32_t a4;	
	uint32_t a5;	
	uint32_t a6;	
	uint32_t a7;	
};
#endif 
#ifdef ARM64
struct thread_smc_args {
	uint64_t a0;	
	uint64_t a1;	
	uint64_t a2;	
	uint64_t a3;	
	uint64_t a4;	
	uint64_t a5;	
	uint64_t a6;	
	uint64_t a7;	
};
#endif 
#ifdef ARM32
struct thread_abort_regs {
	uint32_t usr_sp;
	uint32_t usr_lr;
	uint32_t pad;
	uint32_t spsr;
	uint32_t elr;
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
	uint32_t ip;
};
#endif 
#ifdef ARM64
struct thread_abort_regs {
	uint64_t x0;	
	uint64_t x1;	
	uint64_t x2;	
	uint64_t x3;	
	uint64_t x4;	
	uint64_t x5;	
	uint64_t x6;	
	uint64_t x7;	
	uint64_t x8;	
	uint64_t x9;	
	uint64_t x10;	
	uint64_t x11;	
	uint64_t x12;	
	uint64_t x13;	
	uint64_t x14;	
	uint64_t x15;
	uint64_t x16;
	uint64_t x17;
	uint64_t x18;
	uint64_t x19;
	uint64_t x20;
	uint64_t x21;
	uint64_t x22;
	uint64_t x23;
	uint64_t x24;
	uint64_t x25;
	uint64_t x26;
	uint64_t x27;
	uint64_t x28;
	uint64_t x29;
	uint64_t x30;
	uint64_t elr;
	uint64_t spsr;
	uint64_t sp_el0;
};
#endif 
#ifdef ARM32
struct thread_svc_regs {
	uint32_t spsr;
	uint32_t r0;
	uint32_t r1;
	uint32_t r2;
	uint32_t r3;
	uint32_t r4;
	uint32_t r5;
	uint32_t r6;
	uint32_t r7;
	uint32_t lr;
};
#endif 
#ifdef ARM64
struct thread_svc_regs {
	uint64_t elr;
	uint64_t spsr;
	uint64_t x0;	
	uint64_t x1;	
	uint64_t x2;	
	uint64_t x3;	
	uint64_t x4;	
	uint64_t x5;	
	uint64_t x6;	
	uint64_t x7;	
	uint64_t x8;	
	uint64_t x9;	
	uint64_t x10;	
	uint64_t x11;	
	uint64_t x12;	
	uint64_t x13;	
	uint64_t x14;	
	uint64_t x30;
	uint64_t sp_el0;
	uint64_t pad;
} __aligned(16);
#endif 
#endif 
#ifndef ASM
typedef void (*thread_smc_handler_t)(struct thread_smc_args *args);
typedef void (*thread_nintr_handler_t)(void);
typedef unsigned long (*thread_pm_handler_t)(unsigned long a0,
					     unsigned long a1);
struct thread_handlers {
	thread_smc_handler_t std_smc;
	thread_smc_handler_t fast_smc;
	thread_nintr_handler_t nintr;
	thread_pm_handler_t cpu_on;
	thread_pm_handler_t cpu_off;
	thread_pm_handler_t cpu_suspend;
	thread_pm_handler_t cpu_resume;
	thread_pm_handler_t system_off;
	thread_pm_handler_t system_reset;
};
void thread_init_primary(const struct thread_handlers *handlers);
void thread_init_per_cpu(void);
struct thread_core_local *thread_get_core_local(void);
bool thread_init_stack(uint32_t stack_id, vaddr_t sp);
void thread_init_boot_thread(void);
void thread_clr_boot_thread(void);
int thread_get_id(void);
int thread_get_id_may_fail(void);
struct thread_specific_data *thread_get_tsd(void);
void thread_set_foreign_intr(bool enable);
void thread_restore_foreign_intr(void);
#if defined(CFG_ARM_GICV3)
#define THREAD_EXCP_FOREIGN_INTR	(ARM32_CPSR_F >> ARM32_CPSR_F_SHIFT)
#define THREAD_EXCP_NATIVE_INTR		(ARM32_CPSR_I >> ARM32_CPSR_F_SHIFT)
#else
#define THREAD_EXCP_FOREIGN_INTR	(ARM32_CPSR_I >> ARM32_CPSR_F_SHIFT)
#define THREAD_EXCP_NATIVE_INTR		(ARM32_CPSR_F >> ARM32_CPSR_F_SHIFT)
#endif
#define THREAD_EXCP_ALL			(THREAD_EXCP_FOREIGN_INTR	\
					| THREAD_EXCP_NATIVE_INTR	\
					| (ARM32_CPSR_A >> ARM32_CPSR_F_SHIFT))
uint32_t thread_get_exceptions(void);
void thread_set_exceptions(uint32_t exceptions);
uint32_t thread_mask_exceptions(uint32_t exceptions);
void thread_unmask_exceptions(uint32_t state);
static inline bool thread_foreign_intr_disabled(void)
{
	return !!(thread_get_exceptions() & THREAD_EXCP_FOREIGN_INTR);
}
#ifdef CFG_WITH_VFP
uint32_t thread_kernel_enable_vfp(void);
void thread_kernel_disable_vfp(uint32_t state);
void thread_kernel_save_vfp(void);
void thread_kernel_restore_vfp(void);
void thread_user_enable_vfp(struct thread_user_vfp_state *uvfp);
#else 
static inline void thread_kernel_save_vfp(void)
{
}
static inline void thread_kernel_restore_vfp(void)
{
}
#endif 
#ifdef CFG_WITH_VFP
void thread_user_save_vfp(void);
#else
static inline void thread_user_save_vfp(void)
{
}
#endif
#ifdef CFG_WITH_VFP
void thread_user_clear_vfp(struct thread_user_vfp_state *uvfp);
#else
static inline void thread_user_clear_vfp(
			struct thread_user_vfp_state *uvfp __unused)
{
}
#endif
uint32_t thread_enter_user_mode(unsigned long a0, unsigned long a1,
		unsigned long a2, unsigned long a3, unsigned long user_sp,
		unsigned long entry_func, bool is_32bit,
		uint32_t *exit_status0, uint32_t *exit_status1);
void thread_unwind_user_mode(uint32_t ret, uint32_t exit_status0,
		uint32_t exit_status1);
#ifdef ARM64
vaddr_t thread_get_saved_thread_sp(void);
#endif 
#ifdef CFG_CORE_UNMAP_CORE_AT_EL0
void thread_get_user_kcode(struct mobj **mobj, size_t *offset,
			  vaddr_t *va, size_t *sz);
#else
static inline void thread_get_user_kcode(struct mobj **mobj, size_t *offset,
					 vaddr_t *va, size_t *sz)
{
	*mobj = NULL;
	*offset = 0;
	*va = 0;
	*sz = 0;
}
#endif
#if defined(CFG_CORE_UNMAP_CORE_AT_EL0) && \
	defined(CFG_CORE_WORKAROUND_SPECTRE_BP_SEC) && defined(ARM64)
void thread_get_user_kdata(struct mobj **mobj, size_t *offset,
			  vaddr_t *va, size_t *sz);
#else
static inline void thread_get_user_kdata(struct mobj **mobj, size_t *offset,
					 vaddr_t *va, size_t *sz)
{
	*mobj = NULL;
	*offset = 0;
	*va = 0;
	*sz = 0;
}
#endif
vaddr_t thread_stack_start(void);
size_t thread_stack_size(void);
bool thread_is_in_normal_mode(void);
bool thread_is_from_abort_mode(void);
void thread_add_mutex(struct mutex *m);
void thread_rem_mutex(struct mutex *m);
bool thread_disable_prealloc_rpc_cache(uint64_t *cookie);
bool thread_enable_prealloc_rpc_cache(void);
struct mobj *thread_rpc_alloc_arg(size_t size, uint64_t *cookie);
void thread_rpc_free_arg(uint64_t cookie);
struct mobj *thread_rpc_alloc_payload(size_t size, uint64_t *cookie);
void thread_rpc_free_payload(uint64_t cookie, struct mobj *mobj);
uint32_t thread_rpc_cmd(uint32_t cmd, size_t num_params,
		struct optee_msg_param *params);
unsigned long thread_smc(unsigned long func_id, unsigned long a1,
			 unsigned long a2, unsigned long a3);
#endif 
#endif 
