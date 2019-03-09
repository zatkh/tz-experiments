#ifndef _OPTEE_MSG_H
#define _OPTEE_MSG_H
#include <compiler.h>
#include <types_ext.h>
#include <util.h>
#define OPTEE_MSG_ATTR_TYPE_NONE		0x0
#define OPTEE_MSG_ATTR_TYPE_VALUE_INPUT		0x1
#define OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT	0x2
#define OPTEE_MSG_ATTR_TYPE_VALUE_INOUT		0x3
#define OPTEE_MSG_ATTR_TYPE_RMEM_INPUT		0x5
#define OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT		0x6
#define OPTEE_MSG_ATTR_TYPE_RMEM_INOUT		0x7
#define OPTEE_MSG_ATTR_TYPE_TMEM_INPUT		0x9
#define OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT		0xa
#define OPTEE_MSG_ATTR_TYPE_TMEM_INOUT		0xb
#define OPTEE_MSG_ATTR_TYPE_MASK		GENMASK_32(7, 0)
#define OPTEE_MSG_ATTR_META			BIT(8)
#define OPTEE_MSG_ATTR_NONCONTIG		BIT(9)
#define OPTEE_MSG_ATTR_CACHE_SHIFT		16
#define OPTEE_MSG_ATTR_CACHE_MASK		GENMASK_32(2, 0)
#define OPTEE_MSG_ATTR_CACHE_PREDEFINED		0
#define OPTEE_MSG_LOGIN_PUBLIC			0x00000000
#define OPTEE_MSG_LOGIN_USER			0x00000001
#define OPTEE_MSG_LOGIN_GROUP			0x00000002
#define OPTEE_MSG_LOGIN_APPLICATION		0x00000004
#define OPTEE_MSG_LOGIN_APPLICATION_USER	0x00000005
#define OPTEE_MSG_LOGIN_APPLICATION_GROUP	0x00000006
#define OPTEE_MSG_NONCONTIG_PAGE_SIZE		4096
#ifndef ASM
struct optee_msg_param_tmem {
	uint64_t buf_ptr;
	uint64_t size;
	uint64_t shm_ref;
};
struct optee_msg_param_rmem {
	uint64_t offs;
	uint64_t size;
	uint64_t shm_ref;
};
struct optee_msg_param_value {
	uint64_t a;
	uint64_t b;
	uint64_t c;
};
struct optee_msg_param {
	uint64_t attr;
	union {
		struct optee_msg_param_tmem tmem;
		struct optee_msg_param_rmem rmem;
		struct optee_msg_param_value value;
	} u;
};
struct optee_msg_arg {
	uint32_t cmd;
	uint32_t func;
	uint32_t session;
	uint32_t cancel_id;
	uint32_t pad;
	uint32_t ret;
	uint32_t ret_origin;
	uint32_t num_params;
	struct optee_msg_param params[];
};
#define OPTEE_MSG_GET_ARG_SIZE(num_params) \
	(sizeof(struct optee_msg_arg) + \
	 sizeof(struct optee_msg_param) * (num_params))
#endif 
#define OPTEE_MSG_UID_0			0x384fb3e0
#define OPTEE_MSG_UID_1			0xe7f811e3
#define OPTEE_MSG_UID_2			0xaf630002
#define OPTEE_MSG_UID_3			0xa5d5c51b
#define OPTEE_MSG_FUNCID_CALLS_UID	0xFF01
#define OPTEE_MSG_REVISION_MAJOR	2
#define OPTEE_MSG_REVISION_MINOR	0
#define OPTEE_MSG_FUNCID_CALLS_REVISION	0xFF03
#define OPTEE_MSG_OS_OPTEE_UUID_0	0x486178e0
#define OPTEE_MSG_OS_OPTEE_UUID_1	0xe7f811e3
#define OPTEE_MSG_OS_OPTEE_UUID_2	0xbc5e0002
#define OPTEE_MSG_OS_OPTEE_UUID_3	0xa5d5c51b
#define OPTEE_MSG_FUNCID_GET_OS_UUID	0x0000
#define OPTEE_MSG_FUNCID_GET_OS_REVISION	0x0001
#define OPTEE_MSG_CMD_OPEN_SESSION	0
#define OPTEE_MSG_CMD_INVOKE_COMMAND	1
#define OPTEE_MSG_CMD_CLOSE_SESSION	2
#define OPTEE_MSG_CMD_CANCEL		3
#define OPTEE_MSG_CMD_REGISTER_SHM	4
#define OPTEE_MSG_CMD_UNREGISTER_SHM	5
#define OPTEE_MSG_FUNCID_CALL_WITH_ARG	0x0004
#define OPTEE_MSG_RPC_CMD_GET_TIME	3
#define OPTEE_MSG_RPC_CMD_WAIT_QUEUE	4
#define OPTEE_MSG_RPC_WAIT_QUEUE_SLEEP	0
#define OPTEE_MSG_RPC_WAIT_QUEUE_WAKEUP	1
#define OPTEE_MSG_RPC_CMD_SUSPEND	5
#define OPTEE_MSG_RPC_CMD_SHM_ALLOC	6
#define OPTEE_MSG_RPC_SHM_TYPE_APPL	0
#define OPTEE_MSG_RPC_SHM_TYPE_KERNEL	1
#define OPTEE_MSG_RPC_CMD_SHM_FREE	7
#define OPTEE_MSG_RPC_CMD_BENCH_REG	20
#endif 
