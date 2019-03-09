#ifndef TEE_TA_MANAGER_H
#define TEE_TA_MANAGER_H
#include <types_ext.h>
#include <sys/queue.h>
#include <tee_api_types.h>
#include <utee_types.h>
#include <kernel/tee_common.h>
#include <kernel/mutex.h>
#include <tee_api_types.h>
#include <user_ta_header.h>
#define KERN_IDENTITY	((TEE_Identity *)-1)
#define NSAPP_IDENTITY	(NULL)
TAILQ_HEAD(tee_ta_session_head, tee_ta_session);
TAILQ_HEAD(tee_ta_ctx_head, tee_ta_ctx);
struct mobj;
struct param_val {
	uint32_t a;
	uint32_t b;
};
struct param_mem {
	struct mobj *mobj;
	size_t size;
	size_t offs;
};
struct tee_ta_param {
	uint32_t types;
	union {
		struct param_val val;
		struct param_mem mem;
	} u[TEE_NUM_PARAMS];
};
struct tee_ta_ctx;
struct user_ta_ctx;
struct pseudo_ta_ctx;
struct tee_ta_ops {
	TEE_Result (*enter_open_session)(struct tee_ta_session *s,
			struct tee_ta_param *param, TEE_ErrorOrigin *eo);
	TEE_Result (*enter_invoke_cmd)(struct tee_ta_session *s, uint32_t cmd,
			struct tee_ta_param *param, TEE_ErrorOrigin *eo);
	void (*enter_close_session)(struct tee_ta_session *s);
	void (*dump_state)(struct tee_ta_ctx *ctx);
	void (*destroy)(struct tee_ta_ctx *ctx);
	uint32_t (*get_instance_id)(struct tee_ta_ctx *ctx);
};
#if defined(CFG_TA_GPROF_SUPPORT)
struct sample_buf {
	uint32_t nsamples;	
	uint32_t offset;	
	uint32_t scale;		
	uint32_t count;		
	bool enabled;		
	uint16_t *samples;
	uint64_t usr;		
	uint64_t usr_entered;	
	uint32_t freq;		
};
#endif
struct tee_ta_ctx {
	TEE_UUID uuid;
	const struct tee_ta_ops *ops;
	uint32_t flags;		
	TAILQ_ENTRY(tee_ta_ctx) link;
	uint32_t panicked;	
	uint32_t panic_code;	
	uint32_t ref_count;	
	bool busy;		
	struct condvar busy_cv;	
};
struct tee_ta_session {
	TAILQ_ENTRY(tee_ta_session) link;
	TAILQ_ENTRY(tee_ta_session) link_tsd;
	struct tee_ta_ctx *ctx;	
	TEE_Identity clnt_id;	
	bool cancel;		
	bool cancel_mask;	
	TEE_Time cancel_time;	
	void *user_ctx;		
	uint32_t ref_count;	
	struct condvar refc_cv;	
	struct condvar lock_cv;	
	int lock_thread;	
	bool unlink;		
#if defined(CFG_TA_GPROF_SUPPORT)
	struct sample_buf *sbuf; 
#endif
};
extern struct tee_ta_ctx_head tee_ctxes;
extern struct mutex tee_ta_mutex;
TEE_Result tee_ta_open_session(TEE_ErrorOrigin *err,
			       struct tee_ta_session **sess,
			       struct tee_ta_session_head *open_sessions,
			       const TEE_UUID *uuid,
			       const TEE_Identity *clnt_id,
			       uint32_t cancel_req_to,
			       struct tee_ta_param *param);
TEE_Result tee_ta_invoke_command(TEE_ErrorOrigin *err,
				 struct tee_ta_session *sess,
				 const TEE_Identity *clnt_id,
				 uint32_t cancel_req_to, uint32_t cmd,
				 struct tee_ta_param *param);
TEE_Result tee_ta_cancel_command(TEE_ErrorOrigin *err,
				 struct tee_ta_session *sess,
				 const TEE_Identity *clnt_id);
bool tee_ta_session_is_cancelled(struct tee_ta_session *s, TEE_Time *curr_time);
TEE_Result tee_ta_close_session(struct tee_ta_session *sess,
				struct tee_ta_session_head *open_sessions,
				const TEE_Identity *clnt_id);
TEE_Result tee_ta_get_current_session(struct tee_ta_session **sess);
void tee_ta_push_current_session(struct tee_ta_session *sess);
struct tee_ta_session *tee_ta_pop_current_session(void);
struct tee_ta_session *tee_ta_get_calling_session(void);
TEE_Result tee_ta_get_client_id(TEE_Identity *id);
struct tee_ta_session *tee_ta_get_session(uint32_t id, bool exclusive,
			struct tee_ta_session_head *open_sessions);
void tee_ta_put_session(struct tee_ta_session *sess);
void tee_ta_dump_current(void);
#if defined(CFG_TA_GPROF_SUPPORT)
void tee_ta_gprof_sample_pc(vaddr_t pc);
void tee_ta_update_session_utime_suspend(void);
void tee_ta_update_session_utime_resume(void);
#else
static inline void tee_ta_gprof_sample_pc(vaddr_t pc __unused) {}
static inline void tee_ta_update_session_utime_suspend(void) {}
static inline void tee_ta_update_session_utime_resume(void) {}
#endif
#endif
