#ifndef TEE_ENTRY_FAST_H
#define TEE_ENTRY_FAST_H
#include <kernel/thread.h>
void tee_entry_get_api_call_count(struct thread_smc_args *args);
void tee_entry_get_api_uuid(struct thread_smc_args *args);
void tee_entry_get_api_revision(struct thread_smc_args *args);
void tee_entry_get_os_uuid(struct thread_smc_args *args);
void tee_entry_get_os_revision(struct thread_smc_args *args);
size_t tee_entry_generic_get_api_call_count(void);
void tee_entry_fast(struct thread_smc_args *args);
#endif 
