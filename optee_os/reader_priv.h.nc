#ifndef TEE_SE_READER_PRIV_H
#define TEE_SE_READER_PRIV_H
struct tee_se_reader_proxy {
	struct tee_se_reader *reader;
	int refcnt;
	bool basic_channel_locked;
	struct mutex mutex;
	TAILQ_ENTRY(tee_se_reader_proxy) link;
};
TEE_Result tee_se_reader_check_state(struct tee_se_reader_proxy *proxy);
int tee_se_reader_get_refcnt(struct tee_se_reader_proxy *proxy);
#endif
