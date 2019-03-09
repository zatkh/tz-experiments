#ifndef TEE_ARCH_SVC_H
#define TEE_ARCH_SVC_H
struct thread_svc_regs;
void tee_svc_handler(struct thread_svc_regs *regs);
uint32_t tee_svc_sys_return_helper(uint32_t ret, bool panic,
			uint32_t panic_code, struct thread_svc_regs *regs);
#endif 
