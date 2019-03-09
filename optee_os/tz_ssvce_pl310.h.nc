#ifndef TZ_SSVCE_PL310_H
#define TZ_SSVCE_PL310_H
#include <util.h>
#include <kernel/tz_ssvce_def.h>
#include <types_ext.h>
vaddr_t pl310_base(void);
void arm_cl2_cleaninvbyway(vaddr_t pl310_base);
void arm_cl2_invbyway(vaddr_t pl310_base);
void arm_cl2_cleanbyway(vaddr_t pl310_base);
void arm_cl2_cleanbypa(vaddr_t pl310_base, paddr_t start, paddr_t end);
void arm_cl2_invbypa(vaddr_t pl310_base, paddr_t start, paddr_t end);
void arm_cl2_cleaninvbypa(vaddr_t pl310_base, paddr_t start, paddr_t end);
#endif 
