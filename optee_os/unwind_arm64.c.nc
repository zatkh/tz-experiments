#include <arm.h>
#include <kernel/unwind.h>
#include <kernel/thread.h>
#include <string.h>
#include <trace.h>
bool unwind_stack_arm64(struct unwind_state_arm64 *frame, uaddr_t stack,
		      size_t stack_size)
{
	uint64_t fp;
	fp = frame->fp;
	if (fp < stack || fp >= stack + stack_size)
		return false;
	frame->sp = fp + 0x10;
	frame->fp = *(uint64_t *)(fp);
	frame->pc = *(uint64_t *)(fp + 8) - 4;
	return true;
}
#if defined(CFG_UNWIND) && (TRACE_LEVEL > 0)
void print_stack_arm64(int level, struct unwind_state_arm64 *state,
		       uaddr_t stack, size_t stack_size)
{
	trace_printf_helper_raw(level, true, "Call stack:");
	do {
		trace_printf_helper_raw(level, true, " 0x%016" PRIx64,
					state->pc);
	} while (stack && unwind_stack_arm64(state, stack, stack_size));
}
void print_kernel_stack(int level)
{
	struct unwind_state_arm64 state;
	uaddr_t stack = thread_stack_start();
	size_t stack_size = thread_stack_size();
	memset(&state, 0, sizeof(state));
	state.pc = read_pc();
	state.fp = read_fp();
	print_stack_arm64(level, &state, stack, stack_size);
}
#endif
