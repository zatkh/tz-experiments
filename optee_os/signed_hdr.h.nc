#ifndef SIGNED_HDR_H
#define SIGNED_HDR_H
#include <inttypes.h>
#include <tee_api_types.h>
#include <stdlib.h>
enum shdr_img_type {
	SHDR_TA = 0,
	SHDR_BOOTSTRAP_TA = 1,
};
#define SHDR_MAGIC	0x4f545348
struct shdr {
	uint32_t magic;
	uint32_t img_type;
	uint32_t img_size;
	uint32_t algo;
	uint16_t hash_size;
	uint16_t sig_size;
};
#define SHDR_GET_SIZE(x)	(sizeof(struct shdr) + (x)->hash_size + \
				 (x)->sig_size)
#define SHDR_GET_HASH(x)	(uint8_t *)(((struct shdr *)(x)) + 1)
#define SHDR_GET_SIG(x)		(SHDR_GET_HASH(x) + (x)->hash_size)
struct shdr_bootstrap_ta {
	uint8_t uuid[sizeof(TEE_UUID)];
	uint32_t version;
};
struct shdr *shdr_alloc_and_copy(const struct shdr *img, size_t img_size);
static inline void shdr_free(struct shdr *shdr)
{
	free(shdr);
}
TEE_Result shdr_verify_signature(const struct shdr *shdr);
#endif 
