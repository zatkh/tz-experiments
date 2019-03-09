#ifndef TEE_MMU_H
#define TEE_MMU_H
#include <tee_api_types.h>
#include <kernel/tee_ta_manager.h>
#include <kernel/user_ta.h>
TEE_Result vm_info_init(struct user_ta_ctx *utc);
void vm_info_final(struct user_ta_ctx *utc);
TEE_Result vm_map(struct user_ta_ctx *utc, vaddr_t *va, size_t len,
		  uint32_t prot, struct mobj *mobj, size_t offs);
TEE_Result vm_set_prot(struct user_ta_ctx *utc, vaddr_t va, size_t len,
		       uint32_t prot);
TEE_Result tee_mmu_map_stack(struct user_ta_ctx *utc, struct mobj *mobj);
TEE_Result tee_mmu_map_add_segment(struct user_ta_ctx *utc, struct mobj *mobj,
				   size_t offs, size_t size, uint32_t prot,
				   vaddr_t *va);
TEE_Result tee_mmu_map_param(struct user_ta_ctx *utc,
		struct tee_ta_param *param, void *param_va[TEE_NUM_PARAMS]);
TEE_Result tee_mmu_add_rwmem(struct user_ta_ctx *utc, struct mobj *mobj,
			     vaddr_t *va);
void tee_mmu_rem_rwmem(struct user_ta_ctx *utc, struct mobj *mobj, vaddr_t va);
bool tee_mmu_is_vbuf_inside_ta_private(const struct user_ta_ctx *utc,
				       const void *va, size_t size);
bool tee_mmu_is_vbuf_intersect_ta_private(const struct user_ta_ctx *utc,
					  const void *va, size_t size);
TEE_Result tee_mmu_vbuf_to_mobj_offs(const struct user_ta_ctx *utc,
				     const void *va, size_t size,
				     struct mobj **mobj, size_t *offs);
TEE_Result tee_mmu_user_va2pa_helper(const struct user_ta_ctx *utc, void *ua,
				     paddr_t *pa);
TEE_Result tee_mmu_user_pa2va_helper(const struct user_ta_ctx *utc,
				     paddr_t pa, void **va);
TEE_Result tee_mmu_check_access_rights(const struct user_ta_ctx *utc,
				       uint32_t flags, uaddr_t uaddr,
				       size_t len);
void tee_mmu_set_ctx(struct tee_ta_ctx *ctx);
struct tee_ta_ctx *tee_mmu_get_ctx(void);
uintptr_t tee_mmu_get_load_addr(const struct tee_ta_ctx *const ctx);
void teecore_init_ta_ram(void);
void teecore_init_pub_ram(void);
uint32_t tee_mmu_user_get_cache_attr(struct user_ta_ctx *utc, void *va);
TEE_Result tee_mmu_register_shm(paddr_t pa, size_t len, uint32_t attr);
#endif
