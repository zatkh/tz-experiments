#ifndef TEE_MISC_H
#define TEE_MISC_H
#include <types_ext.h>
#define TEE_B2HS_HSBUF_SIZE(x) ((x) * 2 + 1)
#define TEE_HS2B_BBUF_SIZE(x) ((x + 1) >> 1)
uint32_t tee_b2hs(uint8_t *b, uint8_t *hs, uint32_t blen, uint32_t hslen);
uint32_t tee_hs2b(uint8_t *hs, uint8_t *b, uint32_t hslen, uint32_t blen);
#define core_is_buffer_inside(b, bl, a, al) \
	_core_is_buffer_inside((vaddr_t)(b), (size_t)(bl), \
				(vaddr_t)(a), (size_t)(al))
#define core_is_buffer_outside(b, bl, a, al) \
	_core_is_buffer_outside((vaddr_t)(b), (size_t)(bl), \
				(vaddr_t)(a), (size_t)(al))
#define core_is_buffer_intersect(b, bl, a, al) \
	_core_is_buffer_intersect((vaddr_t)(b), (size_t)(bl), \
				(vaddr_t)(a), (size_t)(al))
bool _core_is_buffer_inside(vaddr_t b, size_t bl, vaddr_t a, size_t al);
bool _core_is_buffer_outside(vaddr_t b, size_t bl, vaddr_t a, size_t al);
bool _core_is_buffer_intersect(vaddr_t b, size_t bl, vaddr_t a, size_t al);
#endif 
