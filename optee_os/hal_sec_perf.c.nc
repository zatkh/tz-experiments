#include <initcall.h>
#include <io.h>
#include <kernel/panic.h>
#include <mm/core_memprot.h>
#include <util.h>
#define PHY_2_VIR(addr)	((vaddr_t)phys_to_virt((addr), MEM_AREA_IO_SEC))
#define MCU_MC_CONTROL_0_REG	PHY_2_VIR(MCU_BASE + 0x044)
#define TRUSTZONE_LOCK			BIT(31)
#define MCU_TZ_RANGE_HIGH_REG(x)	PHY_2_VIR(MCU_BASE + 0x84 + ((x) << 3))
#define MCU_TZ_RANGE_LOW_REG(x)		PHY_2_VIR(MCU_BASE + 0x80 + ((x) << 3))
#define RW_PERM	0x0
#define RO_PERM	0x1
#define WO_PERM	0x2
#define ABORT_PERM	0x3
#define MAX_RANGE_NUM   16
#define INVALID_SIZE_CODE   0xff
#ifdef TEE_RES_CFG_16M
#define RSVD_SEC_MEM    (SIZE_8M + SIZE_8M)
#elif defined(TEE_RES_CFG_24M)
#define RSVD_SEC_MEM    (SIZE_8M + SIZE_8M + SIZE_8M)
#elif defined(TEE_RES_CFG_8M)
#define RSVD_SEC_MEM    SIZE_8M
#else
#error "no reserved secure memory defined."
#endif
#define RA_ADDR	TZDRAM_BASE
#define RA_SIZE	TZDRAM_SIZE
#define RA_PERM	ABORT_PERM
#define TZ_IS_VALID(data)		((data) & (0x1))
#define TZ_SET_VALID(data)		((data) |= (0x1))
#define TZ_GET_PERM(data, ret)		((ret) = (((data) & (0x3 << 1)) >> 1))
#define TZ_SET_PERM(data, val)		\
	do {	\
		(data) &= (~(0x3 << 1)); \
		(data) |= (((val) & 0x3) << 1);	\
	} while (0)
#define TZ_GET_RZ_EN(data, ret)		((ret) = (((data) & (0x1 << 3)) >> 3))
#define TZ_SET_RZ_EN(data, val)		\
	do {	\
		(data) &= (~(0x1 << 3)); \
		(data) |= (((val) & 0x1) << 3);	\
	} while (0)
#define TZ_GET_AREA_LEN_CODE(data, ret)	((ret) = (((data) & (0x1F << 7)) >> 7))
#define TZ_SET_AREA_LEN_CODE(data, val)	\
	do {	\
		(data) &= (~(0x1F << 7));	\
		(data) |= (((val) & 0x1F) << 7);		\
	} while (0)
#define TZ_GET_START_ADDR_L(data, ret)	\
	((ret) = (((data) & 0xFFFFF000)))
#define TZ_SET_START_ADDR_L(data, val)		\
	do {	\
		(data) &= (~0xFFFFF000);		\
		(data) |= (((val) & 0xFFFFF000));	\
	} while (0)
#define TZ_GET_UR_PERM(data, val)	((ret) = (((data) & (0x3 << 4)) >> 4))
#define TZ_SET_UR_PERM(data, val)	\
	do {	\
		(data) &= (~(0x3 << 4)); \
		(data) |= (((val) & 0x3) << 4);	\
	} while (0)
#define TZ_GET_UR_RZ_EN(data, val)		\
	((ret) = (((data) & (0x1 << 6)) >> 6))
#define TZ_SET_UR_RZ_EN(data, val)		\
	do {	\
		(data) &= (~(0x1 << 6)); \
		(data) |= (((val) & 0x1) << 6);	\
	} while (0)
#define RANGE_SIZE_TO_CODE(size, code, i)	\
	do {	\
		(code) = INVALID_SIZE_CODE;	\
		for ((i) = 8; (i) <= 0x1f; (i)++) {	   \
			if (((uint32_t)0x1 << (i)) == ((size) >> 12)) { \
				(code) = (i);	\
				break;	\
			}	\
		}	\
	} while (0)
#define RANGE_CODE_TO_SIZE_K(code, sizek)	((sizek) = ((4) << (code)))
#define TZ_LOCK_MC(x)		\
	do {	\
		(x) = read32(MCU_MC_CONTROL_0_REG);	\
		(x) |= (TRUSTZONE_LOCK);	\
		 write32((x), MCU_MC_CONTROL_0_REG);	\
	} while (0)
#define _IS_ALIGNED(_addr, _algn)	(!((_addr) & ((_algn) - 1)))
register_phys_mem(MEM_AREA_IO_SEC, MCU_BASE, CORE_MMU_DEVICE_SIZE);
register_phys_mem(MEM_AREA_IO_SEC, MC_SCR_REGISTER, CORE_MMU_DEVICE_SIZE);
static int32_t _find_valid_range(void)
{
	uint32_t i;
	uint32_t tmp;
	for (i = 0; i < MAX_RANGE_NUM; i++) {
		tmp = read32(MCU_TZ_RANGE_LOW_REG(i));
		if (!TZ_IS_VALID(tmp))
			return i;
	}
	return -1;
}
static int32_t set_range(uint32_t addr, uint32_t size, uint32_t perm)
{
	uint32_t data;
	uint32_t sizecode;
	int32_t valid_range;
	uint32_t i;
	if (!_IS_ALIGNED(addr, SIZE_1M)) {
		EMSG("region addr(0x%" PRIx32 ") is not aligned with 1M!",
			addr);
		return -1;
	}
	if (!_IS_ALIGNED(size, SIZE_1M)) {
		EMSG("region size(0x%" PRIx32 ") is not aligned with 1M!",
			size);
		return -1;
	}
	if (!_IS_ALIGNED(addr, size)) {
		EMSG("region size(0x%" PRIx32
			") not align with addr(0x%" PRIx32 ")",
			size, addr);
		return -1;
	}
	RANGE_SIZE_TO_CODE(size, sizecode, i);
	if (sizecode == INVALID_SIZE_CODE) {
		EMSG("not valid region size(2^n)! size:0x%" PRIx32, size);
		return -1;
	}
	valid_range = _find_valid_range();
	if (valid_range == -1) {
		EMSG("ERR: can't find valid range!");
		return -1;
	}
	data = read32(MCU_TZ_RANGE_LOW_REG(valid_range));
	TZ_SET_VALID(data);
	TZ_SET_PERM(data, perm);
	TZ_SET_AREA_LEN_CODE(data, sizecode);
	TZ_SET_START_ADDR_L(data, addr);
	if (!valid_range) {
		TZ_SET_UR_PERM(data, RW_PERM);
		TZ_SET_UR_RZ_EN(data, 0);
	}
	write32(data, MCU_TZ_RANGE_LOW_REG(valid_range));
	return 0;
}
static void  _dump_range(void)
{
	uint32_t i;
	uint32_t tmp;
	uint32_t sizek;
	uint32_t sizecode_read;
	uint32_t __maybe_unused sizem;
	uint32_t __maybe_unused addr_read;
	uint32_t __maybe_unused perm_read;
	for (i = 0; i < MAX_RANGE_NUM; i++) {
		tmp = read32(MCU_TZ_RANGE_LOW_REG(i));
		if (TZ_IS_VALID(tmp)) {
			TZ_GET_PERM(tmp, perm_read);
			TZ_GET_AREA_LEN_CODE(tmp, sizecode_read);
			TZ_GET_START_ADDR_L(tmp, addr_read);
			DMSG("Range Num%" PRIu32
				": Reg 0x%" PRIx64 " = 0x%" PRIx32,
				i, MCU_TZ_RANGE_LOW_REG(i), tmp);
			DMSG("AddrL: 0x%08" PRIx32, addr_read);
			RANGE_CODE_TO_SIZE_K(sizecode_read, sizek);
			sizem = sizek >> 10;
			DMSG("Size: %" PRIu32 "K, %" PRIu32 "M", sizek, sizem);
			DMSG("Perm: %" PRIu32, perm_read);
		}
	}
}
static uint32_t _find_granule(uint32_t addr, uint32_t size)
{
	uint32_t max_granule = SIZE_2G;
	while (max_granule >= SIZE_4K) {	
		if (max_granule <= size && _IS_ALIGNED(addr, max_granule))
			return max_granule;
		max_granule >>= 1;
	}
	return 0;	
}
static void _set_range(uint32_t addr, uint32_t size, uint32_t perm)
{
	uint32_t rgn_addr = addr;
	uint32_t rgn_size = size;
	uint32_t p;
	while (rgn_size) {
		p = _find_granule(rgn_addr, rgn_size);
		if (!p)
			panic("cannot find a suitable granule!");
		if (set_range(rgn_addr, p, perm))
			panic("set_range failed!");
		rgn_addr += p;
		rgn_size -= p;
	}
}
static TEE_Result init_sec_perf(void)
{
	uint32_t tmp;
	tmp = read32(PHY_2_VIR(MC_SCR_REGISTER));
	tmp |= 0x1;
	write32(tmp, PHY_2_VIR(MC_SCR_REGISTER));
	DMSG("sec-rgn size: ra = 0x%08" PRIx32 ", size = 0x%" PRIx32,
		RA_ADDR, RA_SIZE);
	_set_range(RA_ADDR, RA_SIZE, RA_PERM);
	TZ_LOCK_MC(tmp);
	_dump_range();
	return TEE_SUCCESS;
}
service_init(init_sec_perf);
