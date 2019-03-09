#ifndef __TEE_UUID
#define __TEE_UUID
#include <optee_msg.h>
#include <tee_api_types.h>
#include <types_ext.h>
void tee_uuid_to_octets(uint8_t *dst, const TEE_UUID *src);
void tee_uuid_from_octets(TEE_UUID *dst, const uint8_t *src);
#endif 
