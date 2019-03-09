#ifndef KERNEL_UNWIND
#define KERNEL_UNWIND
#ifndef ASM
#include <compiler.h>
#include <tee_api_types.h>
#include <types_ext.h>
struct unwind_state_arm32 {
	uint32_t registers[16];
	uint32_t start_pc;
	uint32_t *insn;
	unsigned entries;
	unsigned byte;
	uint16_t update_mask;
};
bool unwind_stack_arm32(struct unwind_state_arm32 *state, uaddr_t exidx,
			size_t exidx_sz);
#ifdef ARM64
struct unwind_state_arm64 {
	uint64_t fp;
	uint64_t sp;
	uint64_t pc;
};
bool unwind_stack_arm64(struct unwind_state_arm64 *state, uaddr_t stack,
			size_t stack_size);
#endif 
#if defined(CFG_UNWIND) && (TRACE_LEVEL > 0)
#ifdef ARM64
void print_stack_arm64(int level, struct unwind_state_arm64 *state, uaddr_t exidx,
		       size_t exidx_sz);
#endif
void print_stack_arm32(int level, struct unwind_state_arm32 *state, uaddr_t exidx,
		       size_t exidx_sz);
void print_kernel_stack(int level);
#else 
#ifdef ARM64
static inline void print_stack_arm64(int level __unused,
				     struct unwind_state_arm64 *state __unused,
				     uaddr_t exidx __unused,
				     size_t exidx_sz __unused)
{
}
#endif
static inline void print_stack_arm32(int level __unused,
				     struct unwind_state_arm32 *state __unused,
				     uaddr_t exidx __unused,
				     size_t exidx_sz __unused)
{
}
static inline void print_kernel_stack(int level __unused)
{
}
#endif 
#ifdef CFG_UNWIND
TEE_Result relocate_exidx(void *exidx, size_t exidx_sz, int32_t offset);
#else
static inline TEE_Result relocate_exidx(void *exidx __unused,
					size_t exidx_sz __unused,
					int32_t offset __unused)
{
	return TEE_ERROR_NOT_SUPPORTED;
}
#endif 
#endif 
#ifdef CFG_UNWIND
#define UNWIND(...)	__VA_ARGS__
#else
#define UNWIND(...)
#endif
#endif 
