#ifndef __KERNEL_REFCOUNT_H
#define __KERNEL_REFCOUNT_H
#include <atomic.h>
struct refcount {
	unsigned int val;
};
bool refcount_inc(struct refcount *r);
bool refcount_dec(struct refcount *r);
static inline void refcount_set(struct refcount *r, unsigned int val)
{
	atomic_store_uint(&r->val, val);
}
static inline unsigned int refcount_val(struct refcount *r)
{
	return atomic_load_uint(&r->val);
}
#endif 
