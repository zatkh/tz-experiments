#ifndef TEE_OBJ_H
#define TEE_OBJ_H
#include <tee_api_types.h>
#include <kernel/tee_ta_manager.h>
#include <sys/queue.h>
#define TEE_USAGE_DEFAULT   0xffffffff
struct tee_obj {
	TAILQ_ENTRY(tee_obj) link;
	TEE_ObjectInfo info;
	bool busy;		
	uint32_t have_attrs;	
	void *attr;
	size_t ds_pos;
	struct tee_pobj *pobj;	
	struct tee_file_handle *fh;
	uint32_t flags;		
};
void tee_obj_add(struct user_ta_ctx *utc, struct tee_obj *o);
TEE_Result tee_obj_get(struct user_ta_ctx *utc, uint32_t obj_id,
		       struct tee_obj **obj);
void tee_obj_close(struct user_ta_ctx *utc, struct tee_obj *o);
void tee_obj_close_all(struct user_ta_ctx *utc);
TEE_Result tee_obj_verify(struct tee_ta_session *sess, struct tee_obj *o);
struct tee_obj *tee_obj_alloc(void);
void tee_obj_free(struct tee_obj *o);
#endif
