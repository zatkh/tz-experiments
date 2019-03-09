#ifndef KERNEL_MSG_PARAM_H
#define KERNEL_MSG_PARAM_H
#include <optee_msg.h>
#include <stdio.h>
#include <types_ext.h>
#include <kernel/msg_param.h>
#include <mm/mobj.h>
enum msg_param_mem_dir {
	MSG_PARAM_MEM_DIR_IN = 0,
	MSG_PARAM_MEM_DIR_OUT,
	MSG_PARAM_MEM_DIR_INOUT,
};
struct mobj *msg_param_mobj_from_noncontig(paddr_t buf_ptr, size_t size,
					   uint64_t shm_ref, bool map_buffer);
bool msg_param_init_memparam(struct optee_msg_param *param, struct mobj *mobj,
			     size_t offset, size_t size,
			     uint64_t cookie, enum msg_param_mem_dir dir);
static inline size_t msg_param_get_buf_size(const struct optee_msg_param *param)
{
	switch (param->attr & OPTEE_MSG_ATTR_TYPE_MASK) {
	case OPTEE_MSG_ATTR_TYPE_TMEM_INPUT:
	case OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT:
	case OPTEE_MSG_ATTR_TYPE_TMEM_INOUT:
		return param->u.tmem.size;
	case OPTEE_MSG_ATTR_TYPE_RMEM_INPUT:
	case OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT:
	case OPTEE_MSG_ATTR_TYPE_RMEM_INOUT:
		return param->u.rmem.size;
	default:
		return 0;
	}
}
static inline bool msg_param_attr_is_tmem(uint64_t attr)
{
	switch (attr & OPTEE_MSG_ATTR_TYPE_MASK) {
	case OPTEE_MSG_ATTR_TYPE_TMEM_INPUT:
	case OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT:
	case OPTEE_MSG_ATTR_TYPE_TMEM_INOUT:
		return true;
	default:
		return false;
	}
}
#endif	
