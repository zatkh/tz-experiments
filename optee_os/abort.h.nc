#ifndef KERNEL_ABORT_H
#define KERNEL_ABORT_H
#define ABORT_TYPE_UNDEF	0
#define ABORT_TYPE_PREFETCH	1
#define ABORT_TYPE_DATA		2
#define ABORT_TYPE_TA_PANIC	3 
#ifndef ASM
#include <compiler.h>
#include <types_ext.h>
struct abort_info {
	uint32_t abort_type;
	uint32_t fault_descr;	
	vaddr_t va;
	uint32_t pc;
	struct thread_abort_regs *regs;
};
void abort_print(struct abort_info *ai);
void abort_print_error(struct abort_info *ai);
void abort_handler(uint32_t abort_type, struct thread_abort_regs *regs);
bool abort_is_user_exception(struct abort_info *ai);
#endif 
#endif 
