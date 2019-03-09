#ifndef KERNEL_HANDLE_H
#define KERNEL_HANDLE_H
#include <stdint.h>
struct handle_db {
	void **ptrs;
	size_t max_ptrs;
};
#define HANDLE_DB_INITIALIZER { NULL, 0 }
void handle_db_destroy(struct handle_db *db);
int handle_get(struct handle_db *db, void *ptr);
void *handle_put(struct handle_db *db, int handle);
void *handle_lookup(struct handle_db *db, int handle);
#endif 
