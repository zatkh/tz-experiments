#include <optee_msg.h>
#include <stdio.h>
#include <types_ext.h>
#include <kernel/msg_param.h>
#include <mm/mobj.h>
static bool msg_param_extract_pages(paddr_t buffer, paddr_t *pages,
				       size_t num_pages)
{
	size_t cnt;
	struct mobj *mobj;
	paddr_t page;
	uint64_t *va;
	bool ret = false;
	if (buffer & SMALL_PAGE_MASK)
		return false;
	mobj = mobj_mapped_shm_alloc(&buffer, 1, 0, 0);
	if (!mobj)
		return false;
	va = mobj_get_va(mobj, 0);
	assert(va);
	for (cnt = 0; cnt < num_pages; cnt++, va++) {
		if (!((vaddr_t)(va + 1) & SMALL_PAGE_MASK)) {
			page = *va;
			if (page & SMALL_PAGE_MASK)
				goto out;
			mobj_free(mobj);
			mobj = mobj_mapped_shm_alloc(&page, 1, 0, 0);
			if (!mobj)
				goto out;
			va = mobj_get_va(mobj, 0);
			assert(va);
		}
		pages[cnt] = *va;
		if (pages[cnt] & SMALL_PAGE_MASK)
			goto out;
	}
	ret = true;
out:
	mobj_free(mobj);
	return ret;
}
struct mobj *msg_param_mobj_from_noncontig(paddr_t buf_ptr, size_t size,
					   uint64_t shm_ref, bool map_buffer)
{
	struct mobj *mobj = NULL;
	paddr_t *pages;
	paddr_t page_offset;
	size_t num_pages;
	page_offset = buf_ptr & SMALL_PAGE_MASK;
	num_pages = (size + page_offset - 1) / SMALL_PAGE_SIZE + 1;
	pages = malloc(num_pages * sizeof(paddr_t));
	if (!pages)
		return NULL;
	if (!msg_param_extract_pages(buf_ptr & ~SMALL_PAGE_MASK,
				     pages, num_pages))
		goto out;
	if (map_buffer)
		mobj = mobj_mapped_shm_alloc(pages, num_pages, page_offset,
					     shm_ref);
	else
		mobj = mobj_reg_shm_alloc(pages, num_pages, page_offset,
					  shm_ref);
out:
	free(pages);
	return mobj;
}
bool msg_param_init_memparam(struct optee_msg_param *param, struct mobj *mobj,
			     size_t offset, size_t size,
			     uint64_t cookie, enum msg_param_mem_dir dir)
{
	if (mobj_matches(mobj, CORE_MEM_REG_SHM)) {
		switch (dir) {
		case MSG_PARAM_MEM_DIR_IN:
			param->attr = OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
			break;
		case MSG_PARAM_MEM_DIR_OUT:
			param->attr = OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT;
			break;
		case MSG_PARAM_MEM_DIR_INOUT:
			param->attr = OPTEE_MSG_ATTR_TYPE_RMEM_INOUT;
			break;
		default:
			return false;
		}
		param->u.rmem.size = size;
		param->u.rmem.offs = offset;
		param->u.rmem.shm_ref = cookie;
	} else if (mobj_matches(mobj, CORE_MEM_NSEC_SHM)) {
		paddr_t pa;
		if (mobj_get_pa(mobj, 0, 0, &pa) != TEE_SUCCESS)
			return false;
		switch (dir) {
		case MSG_PARAM_MEM_DIR_IN:
			param->attr = OPTEE_MSG_ATTR_TYPE_TMEM_INPUT;
			break;
		case MSG_PARAM_MEM_DIR_OUT:
			param->attr = OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT;
			break;
		case MSG_PARAM_MEM_DIR_INOUT:
			param->attr = OPTEE_MSG_ATTR_TYPE_TMEM_INOUT;
			break;
		default:
			return false;
		}
		param->u.tmem.buf_ptr = pa + offset;
		param->u.tmem.shm_ref = cookie;
		param->u.tmem.size = size;
	} else
		return false;
	return true;
}
