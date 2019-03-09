#ifndef ARCH_SVC_PRIVATE_H
#define ARCH_SVC_PRIVATE_H
#include <tee_api_types.h>
typedef TEE_Result (*syscall_t)(void);
uint32_t tee_svc_do_call(struct thread_svc_regs *regs, syscall_t func);
#endif 
