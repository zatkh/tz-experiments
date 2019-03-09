#include <assert.h>
#include <atomic.h>
#include <kernel/refcount.h>
bool refcount_inc(struct refcount *r)
{
	unsigned int nval;
	unsigned int oval = atomic_load_uint(&r->val);
	while (true) {
		nval = oval + 1;
		if (!oval)
			return false;
		if (atomic_cas_uint(&r->val, &oval, nval))
			return true;
	}
}
bool refcount_dec(struct refcount *r)
{
	unsigned int nval;
	unsigned int oval = atomic_load_uint(&r->val);
	while (true) {
		assert(oval);
		nval = oval - 1;
		if (atomic_cas_uint(&r->val, &oval, nval)) {
			return !nval;
		}
	}
}
