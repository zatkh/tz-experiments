#ifndef KERNEL_VFP_H
#define KERNEL_VFP_H
#include <types_ext.h>
#include <compiler.h>
#ifdef ARM32
#define VFP_NUM_REGS	32
struct vfp_reg {
	uint64_t v;
};
struct vfp_state {
	uint32_t fpexc;
	uint32_t fpscr;
	struct vfp_reg reg[VFP_NUM_REGS];
};
#endif
#ifdef ARM64
#define VFP_NUM_REGS	32
struct vfp_reg {
	uint8_t v[16];
} __aligned(16);
struct vfp_state {
	struct vfp_reg reg[VFP_NUM_REGS];
	uint32_t fpsr;
	uint32_t fpcr;
	uint32_t cpacr_el1;
	bool force_save; 
};
#endif
#ifdef CFG_WITH_VFP
bool vfp_is_enabled(void);
void vfp_enable(void);
void vfp_disable(void);
#else
static inline bool vfp_is_enabled(void)
{
	return false;
}
static inline void vfp_enable(void)
{
}
static inline void vfp_disable(void)
{
}
#endif
void vfp_lazy_save_state_init(struct vfp_state *state);
void vfp_lazy_save_state_final(struct vfp_state *state);
void vfp_lazy_restore_state(struct vfp_state *state, bool full_state);
#endif 
