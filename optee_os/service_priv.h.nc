#ifndef TEE_SE_SERVICE_PRIV_H
#define TEE_SE_SERVICE_PRIV_H
TAILQ_HEAD(se_session_head, tee_se_session);
struct tee_se_service {
	struct se_session_head opened_sessions;
	struct se_session_head closed_sessions;
	struct mutex mutex;
};
#endif
