#include <arm.h>
#include <kernel/linker.h>
#include <kernel/misc.h>
#include <kernel/unwind.h>
#include <string.h>
#include <tee_api_types.h>
#include <trace.h>
#define	FP	11
#define	SP	13
#define	LR	14
#define	PC	15
#define	EXIDX_CANTUNWIND	1
#define	ENTRY_MASK	0xff000000
#define	ENTRY_ARM_SU16	0x80000000
#define	ENTRY_ARM_LU16	0x81000000
#define	INSN_VSP_MASK		0xc0
#define	INSN_VSP_SIZE_MASK	0x3f
#define	INSN_STD_MASK		0xf0
#define	INSN_STD_DATA_MASK	0x0f
#define	INSN_POP_TYPE_MASK	0x08
#define	INSN_POP_COUNT_MASK	0x07
#define	INSN_VSP_LARGE_INC_MASK	0xff
#define	INSN_VSP_INC		0x00
#define	INSN_VSP_DEC		0x40
#define	INSN_POP_MASKED		0x80
#define	INSN_VSP_REG		0x90
#define	INSN_POP_COUNT		0xa0
#define	INSN_FINISH		0xb0
#define	INSN_POP_REGS		0xb1
#define	INSN_VSP_LARGE_INC	0xb2
struct unwind_idx {
	uint32_t offset;
	uint32_t insn;
};
static int32_t expand_prel31(uint32_t prel31)
{
	return prel31 | SHIFT_U32(prel31 & BIT32(30), 1);
}
static struct unwind_idx *find_index(uint32_t addr, vaddr_t exidx,
				     size_t exidx_sz)
{
	vaddr_t idx_start, idx_end;
	unsigned int min, mid, max;
	struct unwind_idx *start;
	struct unwind_idx *item;
	int32_t prel31_addr;
	vaddr_t func_addr;
	start = (struct unwind_idx *)exidx;
	idx_start = exidx;
	idx_end = exidx + exidx_sz;
	min = 0;
	max = (idx_end - idx_start) / sizeof(struct unwind_idx);
	while (min != max) {
		mid = min + (max - min + 1) / 2;
		item = &start[mid];
		prel31_addr = expand_prel31(item->offset);
		func_addr = (vaddr_t)&item->offset + prel31_addr;
		if (func_addr <= addr) {
			min = mid;
		} else {
			max = mid - 1;
		}
	}
	return &start[min];
}
static uint8_t unwind_exec_read_byte(struct unwind_state_arm32 *state)
{
	uint8_t insn;
	insn = (*state->insn) >> (state->byte * 8);
	if (state->byte == 0) {
		state->byte = 3;
		state->insn++;
		state->entries--;
	} else
		state->byte--;
	return insn;
}
static bool unwind_exec_insn(struct unwind_state_arm32 *state)
{
	unsigned int insn;
	uint32_t *vsp = (uint32_t *)(uintptr_t)state->registers[SP];
	int update_vsp = 0;
	if (state->entries == 0)
		return false;
	insn = unwind_exec_read_byte(state);
	if ((insn & INSN_VSP_MASK) == INSN_VSP_INC) {
		state->registers[SP] += ((insn & INSN_VSP_SIZE_MASK) << 2) + 4;
	} else if ((insn & INSN_VSP_MASK) == INSN_VSP_DEC) {
		state->registers[SP] -= ((insn & INSN_VSP_SIZE_MASK) << 2) + 4;
	} else if ((insn & INSN_STD_MASK) == INSN_POP_MASKED) {
		unsigned int mask, reg;
		mask = unwind_exec_read_byte(state);
		mask |= (insn & INSN_STD_DATA_MASK) << 8;
		if (mask == 0)
			return false;
		update_vsp = 1;
		for (reg = 4; mask && reg < 16; mask >>= 1, reg++) {
			if (mask & 1) {
				state->registers[reg] = *vsp++;
				state->update_mask |= 1 << reg;
				if (reg == SP)
					update_vsp = 0;
			}
		}
	} else if ((insn & INSN_STD_MASK) == INSN_VSP_REG &&
	    ((insn & INSN_STD_DATA_MASK) != 13) &&
	    ((insn & INSN_STD_DATA_MASK) != 15)) {
		state->registers[SP] =
		    state->registers[insn & INSN_STD_DATA_MASK];
	} else if ((insn & INSN_STD_MASK) == INSN_POP_COUNT) {
		unsigned int count, reg;
		count = insn & INSN_POP_COUNT_MASK;
		update_vsp = 1;
		for (reg = 4; reg <= 4 + count; reg++) {
			state->registers[reg] = *vsp++;
			state->update_mask |= 1 << reg;
		}
		if ((insn & INSN_POP_TYPE_MASK) != 0) {
			state->registers[14] = *vsp++;
		}
	} else if (insn == INSN_FINISH) {
		state->entries = 0;
	} else if (insn == INSN_POP_REGS) {
		unsigned int mask, reg;
		mask = unwind_exec_read_byte(state);
		if (mask == 0 || (mask & 0xf0) != 0)
			return false;
		update_vsp = 1;
		for (reg = 0; mask && reg < 4; mask >>= 1, reg++) {
			if (mask & 1) {
				state->registers[reg] = *vsp++;
				state->update_mask |= 1 << reg;
			}
		}
	} else if ((insn & INSN_VSP_LARGE_INC_MASK) == INSN_VSP_LARGE_INC) {
		unsigned int uleb128;
		uleb128 = unwind_exec_read_byte(state);
		state->registers[SP] += 0x204 + (uleb128 << 2);
	} else {
		DMSG("Unhandled instruction %.2x\n", insn);
		return false;
	}
	if (update_vsp) {
		state->registers[SP] = (uint32_t)(uintptr_t)vsp;
	}
	return true;
}
static bool unwind_tab(struct unwind_state_arm32 *state)
{
	uint32_t entry;
	state->registers[PC] = 0;
	entry = *state->insn & ENTRY_MASK;
	if (entry == ENTRY_ARM_SU16) {
		state->byte = 2;
		state->entries = 1;
	} else if (entry == ENTRY_ARM_LU16) {
		state->byte = 1;
		state->entries = ((*state->insn >> 16) & 0xFF) + 1;
	} else {
		DMSG("Unknown entry: %x\n", entry);
		return true;
	}
	while (state->entries > 0) {
		if (!unwind_exec_insn(state))
			return true;
	}
	if (state->registers[PC] == 0) {
		state->registers[PC] = state->registers[LR];
		if (state->start_pc != state->registers[PC])
			state->update_mask |= 1 << PC;
	}
	return false;
}
bool unwind_stack_arm32(struct unwind_state_arm32 *state, uaddr_t exidx,
			size_t exidx_sz)
{
	struct unwind_idx *index;
	bool finished;
	state->update_mask = 0;
	state->start_pc = state->registers[PC];
	index = find_index(state->start_pc, exidx, exidx_sz);
	finished = false;
	if (index->insn != EXIDX_CANTUNWIND) {
		if (index->insn & (1U << 31)) {
			state->insn = &index->insn;
		} else {
			state->insn = (uint32_t *)
			    ((uintptr_t)&index->insn +
			     expand_prel31(index->insn));
		}
		finished = unwind_tab(state);
	}
	if (index->insn == EXIDX_CANTUNWIND)
		finished = true;
	return !finished;
}
static uint32_t offset_prel31(uint32_t addr, int32_t offset)
{
	return (addr + offset) & 0x7FFFFFFFUL;
}
TEE_Result relocate_exidx(void *exidx, size_t exidx_sz, int32_t offset)
{
	size_t num_items = exidx_sz / sizeof(struct unwind_idx);
	struct unwind_idx *start = (struct unwind_idx *)exidx;
	size_t n;
	for (n = 0; n < num_items; n++) {
		struct unwind_idx *item = &start[n];
		if (item->offset & BIT32(31))
			return TEE_ERROR_BAD_FORMAT;
		item->offset = offset_prel31(item->offset, offset);
		if (item->insn == EXIDX_CANTUNWIND)
			continue;
		if (item->insn & BIT32(31)) {
			continue;
		}
		item->insn = offset_prel31(item->insn, offset);
	}
	return TEE_SUCCESS;
}
#if defined(CFG_UNWIND) && (TRACE_LEVEL > 0)
void print_stack_arm32(int level, struct unwind_state_arm32 *state, uaddr_t exidx,
		       size_t exidx_sz)
{
	trace_printf_helper_raw(level, true, "Call stack:");
	do {
		trace_printf_helper_raw(level, true, " 0x%08" PRIx32,
					state->registers[PC]);
	} while (unwind_stack_arm32(state, exidx, exidx_sz));
}
#endif
#if defined(CFG_UNWIND) && defined(ARM32) && (TRACE_LEVEL > 0)
void print_kernel_stack(int level)
{
	struct unwind_state_arm32 state;
	uaddr_t exidx = (vaddr_t)__exidx_start;
	size_t exidx_sz = (vaddr_t)__exidx_end - (vaddr_t)__exidx_start;
	memset(state.registers, 0, sizeof(state.registers));
	state.registers[7] = read_r7();
	state.registers[FP] = read_fp();
	state.registers[SP] = read_sp();
	state.registers[LR] = read_lr();
	state.registers[PC] = (uint32_t)print_kernel_stack;
	print_stack_arm32(level, &state, exidx, exidx_sz);
}
#endif
