#ifndef ELF_LOAD_H
#define ELF_LOAD_H
#include <sys/queue.h>
#include <types_ext.h>
#include <tee_api_types.h>
struct elf_load_state;
struct user_ta_elf_head;
struct user_ta_store_handle;
struct user_ta_store_ops {
	const char *description;
	TEE_Result (*open)(const TEE_UUID *uuid,
			   struct user_ta_store_handle **h);
	TEE_Result (*get_size)(const struct user_ta_store_handle *h,
			       size_t *size);
	TEE_Result (*read)(struct user_ta_store_handle *h, void *data,
			   size_t len);
	void (*close)(struct user_ta_store_handle *h);
	SLIST_ENTRY(user_ta_store_ops) link;
	int priority;
};
TEE_Result elf_load_init(const struct user_ta_store_ops *ta_store,
			 struct user_ta_store_handle *ta_handle, bool is_main,
			 struct user_ta_elf_head *elfs,
			 TEE_Result (*resolve_sym)(struct user_ta_elf_head *,
						   const char *, uintptr_t *),
			 struct elf_load_state **state);
TEE_Result elf_load_head(struct elf_load_state *state, size_t head_size,
			void **head, size_t *vasize, bool *is_32bit);
TEE_Result elf_load_body(struct elf_load_state *state, vaddr_t vabase);
TEE_Result elf_load_get_next_segment(struct elf_load_state *state, size_t *idx,
			vaddr_t *vaddr, size_t *size, uint32_t *flags,
			uint32_t *type);
TEE_Result elf_process_rel(struct elf_load_state *state, vaddr_t vabase);
void elf_load_final(struct elf_load_state *state);
#endif 
