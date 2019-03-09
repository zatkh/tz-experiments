#include <stdlib.h>
#include <string.h>
#include <kernel/handle.h>
#define HANDLE_DB_INITIAL_MAX_PTRS	4
void handle_db_destroy(struct handle_db *db)
{
	if (db) {
		free(db->ptrs);
		db->ptrs = NULL;
		db->max_ptrs = 0;
	}
}
int handle_get(struct handle_db *db, void *ptr)
{
	size_t n;
	void *p;
	size_t new_max_ptrs;
	if (!db || !ptr)
		return -1;
	for (n = 0; n < db->max_ptrs; n++) {
		if (!db->ptrs[n]) {
			db->ptrs[n] = ptr;
			return n;
		}
	}
	if (db->max_ptrs)
		new_max_ptrs = db->max_ptrs * 2;
	else
		new_max_ptrs = HANDLE_DB_INITIAL_MAX_PTRS;
	p = realloc(db->ptrs, new_max_ptrs * sizeof(void *));
	if (!p)
		return -1;
	db->ptrs = p;
	memset(db->ptrs + db->max_ptrs, 0,
	       (new_max_ptrs - db->max_ptrs) * sizeof(void *));
	db->max_ptrs = new_max_ptrs;
	db->ptrs[n] = ptr;
	return n;
}
void *handle_put(struct handle_db *db, int handle)
{
	void *p;
	if (!db || handle < 0 || (size_t)handle >= db->max_ptrs)
		return NULL;
	p = db->ptrs[handle];
	db->ptrs[handle] = NULL;
	return p;
}
void *handle_lookup(struct handle_db *db, int handle)
{
	if (!db || handle < 0 || (size_t)handle >= db->max_ptrs)
		return NULL;
	return db->ptrs[handle];
}
