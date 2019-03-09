#ifndef SM_PM_H
#define SM_PM_H
#include <stdint.h>
#include <types_ext.h>
struct sm_pm_ctx {
	uint32_t sp;
	paddr_t cpu_resume_addr;
	uint32_t suspend_regs[16];
};
void sm_pm_cpu_suspend_save(struct sm_pm_ctx *ptr, uint32_t sp);
void sm_pm_cpu_do_suspend(uint32_t *ptr);
void sm_pm_cpu_do_resume(void);
int sm_pm_cpu_suspend(uint32_t arg, int (*fn)(uint32_t));
#endif
