#ifndef KERNEL_EARLY_TA_H
#define KERNEL_EARLY_TA_H
#include <compiler.h>
#include <stdint.h>
#include <tee_api_types.h>
struct early_ta {
	TEE_UUID uuid;
	uint32_t size;
	uint32_t uncompressed_size; 
	const uint8_t ta[]; 
};
#endif 
