#ifndef BENCH_H
#define BENCH_H
#include <inttypes.h>
#include <mm/core_memprot.h>
#include <mm/core_mmu.h>
#include <optee_msg.h>
#define TEE_BENCH_DIVIDER		64
#define TEE_BENCH_MAX_STAMPS	32
#define TEE_BENCH_MAX_MASK		(TEE_BENCH_MAX_STAMPS - 1)
#define OPTEE_MSG_RPC_CMD_BENCH_REG_NEW		0
#define OPTEE_MSG_RPC_CMD_BENCH_REG_DEL		1
#define TEE_BENCH_CLIENT	0x10000000
#define TEE_BENCH_KMOD		0x20000000
#define TEE_BENCH_CORE		0x30000000
#define TEE_BENCH_UTEE		0x40000000
#define TEE_BENCH_DUMB_TA	0xF0000001
struct tee_time_st {
	uint64_t cnt;	
	uint64_t addr;	
	uint64_t src;	
};
struct tee_ts_cpu_buf {
	uint64_t head;
	uint64_t tail;
	struct tee_time_st stamps[TEE_BENCH_MAX_STAMPS];
};
struct tee_ts_global {
	uint64_t cores;
	struct tee_ts_cpu_buf cpu_buf[];
};
#ifdef CFG_TEE_BENCHMARK
void bm_timestamp(void);
#else
static inline void bm_timestamp(void) {}
#endif 
#endif 
