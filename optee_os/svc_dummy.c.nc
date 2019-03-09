#include <kernel/thread.h>
#include <kernel/panic.h>
#include <tee/arch_svc.h>
void __weak __noreturn tee_svc_handler(struct thread_svc_regs *regs __unused)
{
	panic();
}
