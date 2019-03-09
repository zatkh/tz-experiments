#ifndef KERNEL_USER_TA_H
#define KERNEL_USER_TA_H
#include <assert.h>
#include <kernel/tee_ta_manager.h>
#include <kernel/thread.h>
#include <mm/tee_mm.h>
#include <tee_api_types.h>
#include <types_ext.h>
#include <util.h>
TAILQ_HEAD(tee_cryp_state_head, tee_cryp_state);
TAILQ_HEAD(tee_obj_head, tee_obj);
TAILQ_HEAD(tee_storage_enum_head, tee_storage_enum);
TAILQ_HEAD(user_ta_elf_head, user_ta_elf);
struct user_ta_ctx {
	uaddr_t entry_func;
	uaddr_t exidx_start;
	size_t exidx_size;
	struct mobj *mobj_exidx;
	bool is_32bit;
	struct tee_ta_session_head open_sessions;
	struct tee_cryp_state_head cryp_states;
	struct tee_obj_head objects;
	struct tee_storage_enum_head storage_enums;
	struct user_ta_elf_head elfs;
	struct mobj *mobj_stack;
	vaddr_t stack_addr;
	vaddr_t load_addr;
	struct vm_info *vm_info;
	void *ta_time_offs;
	struct tee_pager_area_head *areas;
#if defined(CFG_SE_API)
	struct tee_se_service *se_service;
#endif
#if defined(CFG_WITH_VFP)
	struct thread_user_vfp_state vfp;
#endif
	struct tee_ta_ctx ctx;
};
#ifdef CFG_WITH_USER_TA
bool is_user_ta_ctx(struct tee_ta_ctx *ctx);
#else
static inline bool is_user_ta_ctx(struct tee_ta_ctx *ctx __unused)
{
	return false;
}
#endif
static inline struct user_ta_ctx *to_user_ta_ctx(struct tee_ta_ctx *ctx)
{
	assert(is_user_ta_ctx(ctx));
	return container_of(ctx, struct user_ta_ctx, ctx);
}
struct user_ta_store_ops;
#ifdef CFG_WITH_USER_TA
TEE_Result tee_ta_init_user_ta_session(const TEE_UUID *uuid,
			struct tee_ta_session *s);
TEE_Result tee_ta_register_ta_store(struct user_ta_store_ops *ops);
#else
static inline TEE_Result tee_ta_init_user_ta_session(
			const TEE_UUID *uuid __unused,
			struct tee_ta_session *s __unused)
{
	return TEE_ERROR_ITEM_NOT_FOUND;
}
static inline TEE_Result tee_ta_register_ta_store(
			struct user_ta_store_ops *ops __unused)
{
	return TEE_ERROR_NOT_SUPPORTED;
}
#endif
#endif 
