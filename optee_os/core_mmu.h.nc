#ifndef CORE_MMU_H
#define CORE_MMU_H
#ifndef ASM
#include <assert.h>
#include <compiler.h>
#include <kernel/user_ta.h>
#include <mm/tee_mmu_types.h>
#include <types_ext.h>
#include <util.h>
#endif
#include <platform_config.h>
#define SMALL_PAGE_SHIFT	12
#define SMALL_PAGE_MASK		0x00000fff
#define SMALL_PAGE_SIZE		0x00001000
#ifdef CFG_WITH_LPAE
#define CORE_MMU_PGDIR_SHIFT	21
#define CORE_MMU_PGDIR_LEVEL	3
#else
#define CORE_MMU_PGDIR_SHIFT	20
#define CORE_MMU_PGDIR_LEVEL	2
#endif
#define CORE_MMU_PGDIR_SIZE		(1 << CORE_MMU_PGDIR_SHIFT)
#define CORE_MMU_PGDIR_MASK		(CORE_MMU_PGDIR_SIZE - 1)
#define CORE_MMU_DEVICE_SHIFT		CORE_MMU_PGDIR_SHIFT
#define CORE_MMU_DEVICE_SIZE		(1 << CORE_MMU_DEVICE_SHIFT)
#define CORE_MMU_DEVICE_MASK		(CORE_MMU_DEVICE_SIZE - 1)
#define CORE_MMU_USER_CODE_SHIFT	SMALL_PAGE_SHIFT
#define CORE_MMU_USER_CODE_SIZE		(1 << CORE_MMU_USER_CODE_SHIFT)
#define CORE_MMU_USER_CODE_MASK		(CORE_MMU_USER_CODE_SIZE - 1)
#define CORE_MMU_USER_PARAM_SHIFT	SMALL_PAGE_SHIFT
#define CORE_MMU_USER_PARAM_SIZE	(1 << CORE_MMU_USER_PARAM_SHIFT)
#define CORE_MMU_USER_PARAM_MASK	(CORE_MMU_USER_PARAM_SIZE - 1)
#ifdef CFG_WITH_LPAE
#define CORE_MMU_L1_TBL_OFFSET		(CFG_TEE_CORE_NB_CORE * 4 * 8)
#else
#define CORE_MMU_L1_TBL_OFFSET		(4096 * 4)
#endif
#ifndef TEE_RAM_VA_SIZE
#define TEE_RAM_VA_SIZE			CORE_MMU_PGDIR_SIZE
#endif
#ifndef TEE_LOAD_ADDR
#define TEE_LOAD_ADDR			TEE_RAM_START
#endif
#define TEE_RAM_VA_START		TEE_RAM_START
#define TEE_TEXT_VA_START		(TEE_RAM_VA_START + \
					 (TEE_LOAD_ADDR - TEE_RAM_START))
#ifndef STACK_ALIGNMENT
#define STACK_ALIGNMENT			(sizeof(long) * 2)
#endif
#ifndef ASM
enum teecore_memtypes {
	MEM_AREA_END = 0,
	MEM_AREA_TEE_RAM,
	MEM_AREA_TEE_RAM_RX,
	MEM_AREA_TEE_RAM_RO,
	MEM_AREA_TEE_RAM_RW,
	MEM_AREA_TEE_COHERENT,
	MEM_AREA_TEE_ASAN,
	MEM_AREA_TA_RAM,
	MEM_AREA_NSEC_SHM,
	MEM_AREA_RAM_NSEC,
	MEM_AREA_RAM_SEC,
	MEM_AREA_IO_NSEC,
	MEM_AREA_IO_SEC,
	MEM_AREA_RES_VASPACE,
	MEM_AREA_SHM_VASPACE,
	MEM_AREA_TA_VASPACE,
	MEM_AREA_PAGER_VASPACE,
	MEM_AREA_SDP_MEM,
	MEM_AREA_DDR_OVERALL,
	MEM_AREA_MAXTYPE
};
static inline const char *teecore_memtype_name(enum teecore_memtypes type)
{
	static const char * const names[] = {
		[MEM_AREA_END] = "END",
		[MEM_AREA_TEE_RAM] = "TEE_RAM_RWX",
		[MEM_AREA_TEE_RAM_RX] = "TEE_RAM_RX",
		[MEM_AREA_TEE_RAM_RO] = "TEE_RAM_RO",
		[MEM_AREA_TEE_RAM_RW] = "TEE_RAM_RW",
		[MEM_AREA_TEE_ASAN] = "TEE_ASAN",
		[MEM_AREA_TEE_COHERENT] = "TEE_COHERENT",
		[MEM_AREA_TA_RAM] = "TA_RAM",
		[MEM_AREA_NSEC_SHM] = "NSEC_SHM",
		[MEM_AREA_RAM_NSEC] = "RAM_NSEC",
		[MEM_AREA_RAM_SEC] = "RAM_SEC",
		[MEM_AREA_IO_NSEC] = "IO_NSEC",
		[MEM_AREA_IO_SEC] = "IO_SEC",
		[MEM_AREA_RES_VASPACE] = "RES_VASPACE",
		[MEM_AREA_SHM_VASPACE] = "SHM_VASPACE",
		[MEM_AREA_TA_VASPACE] = "TA_VASPACE",
		[MEM_AREA_PAGER_VASPACE] = "PAGER_VASPACE",
		[MEM_AREA_SDP_MEM] = "SDP_MEM",
		[MEM_AREA_DDR_OVERALL] = "DDR_OVERALL"
	};
	COMPILE_TIME_ASSERT(ARRAY_SIZE(names) == MEM_AREA_MAXTYPE);
	return names[type];
}
#ifdef CFG_CORE_RWDATA_NOEXEC
#define MEM_AREA_TEE_RAM_RW_DATA	MEM_AREA_TEE_RAM_RW
#else
#define MEM_AREA_TEE_RAM_RW_DATA	MEM_AREA_TEE_RAM
#endif
struct core_mmu_phys_mem {
	const char *name;
	enum teecore_memtypes type;
	__extension__ union {
#if __SIZEOF_LONG__ != __SIZEOF_PADDR__
		struct {
			uint32_t lo_addr;
			uint32_t hi_addr;
		};
#endif
		paddr_t addr;
	};
	__extension__ union {
#if __SIZEOF_LONG__ != __SIZEOF_PADDR__
		struct {
			uint32_t lo_size;
			uint32_t hi_size;
		};
#endif
		paddr_size_t size;
	};
};
#define __register_memory2(_name, _type, _addr, _size, _section, _id) \
	static const struct core_mmu_phys_mem __phys_mem_ ## _id \
		__used __section(_section) = \
		{ .name = _name, .type = _type, .addr = _addr, .size = _size }
#if __SIZEOF_LONG__ != __SIZEOF_PADDR__
#define __register_memory2_ul(_name, _type, _addr, _size, _section, _id) \
	static const struct core_mmu_phys_mem __phys_mem_ ## _id \
		__used __section(_section) = \
		{ .name = _name, .type = _type, .lo_addr = _addr, \
		  .lo_size = _size }
#else
#define __register_memory2_ul(_name, _type, _addr, _size, _section, _id) \
		__register_memory2(_name, _type, _addr, _size, _section, _id)
#endif
#define __register_memory1(name, type, addr, size, section, id) \
		__register_memory2(name, type, addr, size, #section, id)
#define __register_memory1_ul(name, type, addr, size, section, id) \
		__register_memory2_ul(name, type, addr, size, #section, id)
#define register_phys_mem(type, addr, size) \
		__register_memory1(#addr, (type), (addr), (size), \
				   phys_mem_map_section, __COUNTER__)
#define register_phys_mem_ul(type, addr, size) \
		__register_memory1_ul(#addr, (type), (addr), (size), \
				   phys_mem_map_section, __COUNTER__)
#ifdef CFG_SECURE_DATA_PATH
#define register_sdp_mem(addr, size) \
		__register_memory1(#addr, MEM_AREA_SDP_MEM, (addr), (size), \
				   phys_sdp_mem_section, __COUNTER__)
#else
#define register_sdp_mem(addr, size) \
		static int CONCAT(__register_sdp_mem_unused, __COUNTER__) \
			__unused
#endif
#define register_dynamic_shm(addr, size) \
		__register_memory1(#addr, MEM_AREA_RAM_NSEC, (addr), (size), \
				   phys_nsec_ddr_section, __COUNTER__)
#define register_ddr(addr, size) \
		__register_memory1(#addr, MEM_AREA_DDR_OVERALL, (addr), \
				   (size), phys_ddr_overall_section,\
				   __COUNTER__)
extern unsigned long default_nsec_shm_paddr;
extern unsigned long default_nsec_shm_size;
void core_init_mmu_map(void);
void core_init_mmu_regs(void);
bool core_mmu_place_tee_ram_at_top(paddr_t paddr);
#ifdef CFG_WITH_LPAE
struct core_mmu_user_map {
	uint64_t user_map;
	uint32_t asid;
};
#else
struct core_mmu_user_map {
	uint32_t ttbr0;
	uint32_t ctxid;
};
#endif
#ifdef CFG_WITH_LPAE
bool core_mmu_user_va_range_is_defined(void);
#else
static inline bool core_mmu_user_va_range_is_defined(void)
{
	return true;
}
#endif
void core_mmu_get_user_va_range(vaddr_t *base, size_t *size);
enum core_mmu_fault {
	CORE_MMU_FAULT_ALIGNMENT,
	CORE_MMU_FAULT_DEBUG_EVENT,
	CORE_MMU_FAULT_TRANSLATION,
	CORE_MMU_FAULT_WRITE_PERMISSION,
	CORE_MMU_FAULT_READ_PERMISSION,
	CORE_MMU_FAULT_ASYNC_EXTERNAL,
	CORE_MMU_FAULT_ACCESS_BIT,
	CORE_MMU_FAULT_OTHER,
};
enum core_mmu_fault core_mmu_get_fault_type(uint32_t fault_descr);
uint32_t core_mmu_type_to_attr(enum teecore_memtypes t);
void core_mmu_create_user_map(struct user_ta_ctx *utc,
			      struct core_mmu_user_map *map);
void core_mmu_get_user_map(struct core_mmu_user_map *map);
void core_mmu_set_user_map(struct core_mmu_user_map *map);
struct core_mmu_table_info {
	void *table;
	vaddr_t va_base;
	unsigned level;
	unsigned shift;
	unsigned num_entries;
};
bool core_mmu_find_table(vaddr_t va, unsigned max_level,
		struct core_mmu_table_info *tbl_info);
bool core_mmu_entry_to_finer_grained(struct core_mmu_table_info *tbl_info,
				     unsigned int idx, bool secure);
void core_mmu_set_entry_primitive(void *table, size_t level, size_t idx,
				  paddr_t pa, uint32_t attr);
void core_mmu_get_user_pgdir(struct core_mmu_table_info *pgd_info);
void core_mmu_set_entry(struct core_mmu_table_info *tbl_info, unsigned idx,
			paddr_t pa, uint32_t attr);
void core_mmu_get_entry_primitive(const void *table, size_t level, size_t idx,
				  paddr_t *pa, uint32_t *attr);
void core_mmu_get_entry(struct core_mmu_table_info *tbl_info, unsigned idx,
			paddr_t *pa, uint32_t *attr);
static inline unsigned core_mmu_va2idx(struct core_mmu_table_info *tbl_info,
			vaddr_t va)
{
	return (va - tbl_info->va_base) >> tbl_info->shift;
}
static inline vaddr_t core_mmu_idx2va(struct core_mmu_table_info *tbl_info,
			unsigned idx)
{
	return (idx << tbl_info->shift) + tbl_info->va_base;
}
static inline size_t core_mmu_get_block_offset(
			struct core_mmu_table_info *tbl_info, paddr_t pa)
{
	return pa & ((1 << tbl_info->shift) - 1);
}
static inline bool core_mmu_is_dynamic_vaspace(struct tee_mmap_region *mm)
{
	return mm->type == MEM_AREA_RES_VASPACE ||
		mm->type == MEM_AREA_SHM_VASPACE;
}
TEE_Result core_mmu_map_pages(vaddr_t vstart, paddr_t *pages, size_t num_pages,
			      enum teecore_memtypes memtype);
void core_mmu_unmap_pages(vaddr_t vstart, size_t num_pages);
bool core_mmu_user_mapping_is_active(void);
bool core_mmu_mattr_is_ok(uint32_t mattr);
void core_mmu_get_mem_by_type(enum teecore_memtypes type, vaddr_t *s,
			      vaddr_t *e);
enum teecore_memtypes core_mmu_get_type_by_pa(paddr_t pa);
static inline bool core_mmu_is_shm_cached(void)
{
	return core_mmu_type_to_attr(MEM_AREA_NSEC_SHM) &
		(TEE_MATTR_CACHE_CACHED << TEE_MATTR_CACHE_SHIFT);
}
bool core_mmu_add_mapping(enum teecore_memtypes type, paddr_t addr, size_t len);
enum teecore_tlb_op {
	TLBINV_UNIFIEDTLB,	
	TLBINV_CURRENT_ASID,	
	TLBINV_BY_ASID,		
	TLBINV_BY_MVA,		
};
void tlbi_mva_range(vaddr_t va, size_t size, size_t granule);
int core_tlb_maintenance(int op, unsigned long a) __deprecated;
enum cache_op {
	DCACHE_CLEAN,
	DCACHE_AREA_CLEAN,
	DCACHE_INVALIDATE,
	DCACHE_AREA_INVALIDATE,
	ICACHE_INVALIDATE,
	ICACHE_AREA_INVALIDATE,
	DCACHE_CLEAN_INV,
	DCACHE_AREA_CLEAN_INV,
};
TEE_Result cache_op_inner(enum cache_op op, void *va, size_t len);
#ifdef CFG_PL310
TEE_Result cache_op_outer(enum cache_op op, paddr_t pa, size_t len);
#else
static inline TEE_Result cache_op_outer(enum cache_op op __unused,
						paddr_t pa __unused,
						size_t len __unused)
{
	return TEE_SUCCESS;
}
#endif
bool cpu_mmu_enabled(void);
void map_memarea_sections(const struct tee_mmap_region *mm, uint32_t *ttb);
bool core_mmu_nsec_ddr_is_defined(void);
void core_mmu_set_discovered_nsec_ddr(struct core_mmu_phys_mem *start,
				      size_t nelems);
#ifdef CFG_SECURE_DATA_PATH
struct mobj **core_sdp_mem_create_mobjs(void);
#endif
#endif 
#endif 
