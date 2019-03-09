#include <mm/core_mmu.h>
#include <platform_config.h>
#include <util.h>
#define TEE_RAM_VA_START        TEE_RAM_START
#define TEE_TEXT_VA_START       (TEE_RAM_VA_START + \
					(TEE_LOAD_ADDR - TEE_RAM_START))
OUTPUT_FORMAT(CFG_KERN_LINKER_FORMAT)
OUTPUT_ARCH(CFG_KERN_LINKER_ARCH)
ENTRY(_start)
SECTIONS
{
	. = TEE_TEXT_VA_START;
#ifdef ARM32
	ASSERT(!(TEE_TEXT_VA_START & 31), "text start should align to 32bytes")
#endif
#ifdef ARM64
	ASSERT(!(TEE_TEXT_VA_START & 127), "text start should align to 128bytes")
#endif
	__text_start = .;
	__flatmap_unpg_rx_start = ROUNDDOWN(__text_start, SMALL_PAGE_SIZE);
	.text : {
		KEEP(*(.text._start))
		KEEP(*(.text.init .text.plat_cpu_reset_early \
		       .text.reset .text.reset_primary .text.unhandled_cpu \
		       .text.__assert_flat_mapped_range))
		. = ALIGN(8);
		__initcall_start = .;
		KEEP(*(.initcall1))
		KEEP(*(.initcall2))
		KEEP(*(.initcall3))
		KEEP(*(.initcall4))
		__initcall_end = .;
#ifdef CFG_WITH_PAGER
		*(.text)
#include <text_unpaged.ld.S>
#else
		*(.text .text.*)
#endif
		*(.sram.text.glue_7* .gnu.linkonce.t.*)
		. = ALIGN(8);
	}
	__text_end = .;
#ifdef CFG_CORE_RODATA_NOEXEC
	. = ALIGN(SMALL_PAGE_SIZE);
#endif
	__flatmap_unpg_rx_size = . - __flatmap_unpg_rx_start;
	__flatmap_unpg_ro_start = .;
	.rodata : ALIGN(8) {
		__rodata_start = .;
		*(.gnu.linkonce.r.*)
#ifdef CFG_WITH_PAGER
		*(.rodata .rodata.__unpaged)
#include <rodata_unpaged.ld.S>
#else
#ifdef CFG_DT
		__rodata_dtdrv_start = .;
		KEEP(*(.rodata.dtdrv))
		__rodata_dtdrv_end = .;
#endif
#ifdef CFG_EARLY_TA
		. = ALIGN(8);
		__rodata_early_ta_start = .;
		KEEP(*(.rodata.early_ta))
		__rodata_early_ta_end = .;
#endif
		*(.rodata .rodata.*)
		. = ALIGN(8);
		__start_ta_head_section = . ;
		KEEP(*(ta_head_section))
		__stop_ta_head_section = . ;
		. = ALIGN(8);
		__start_phys_mem_map_section = . ;
		KEEP(*(phys_mem_map_section))
		__end_phys_mem_map_section = . ;
		. = ALIGN(8);
		__start_phys_sdp_mem_section = . ;
		KEEP(*(phys_sdp_mem_section))
		__end_phys_sdp_mem_section = . ;
		. = ALIGN(8);
		__start_phys_nsec_ddr_section = . ;
		KEEP(*(phys_nsec_ddr_section))
		__end_phys_nsec_ddr_section = . ;
		. = ALIGN(8);
		__start_phys_ddr_overall_section = . ;
		KEEP(*(phys_ddr_overall_section))
		__end_phys_ddr_overall_section = . ;
#endif
		. = ALIGN(8);
		__rodata_end = .;
	}
	.interp : { *(.interp) }
	.hash : { *(.hash) }
	.dynsym : { *(.dynsym) }
	.dynstr : { *(.dynstr) }
	.rel.text : { *(.rel.text) *(.rel.gnu.linkonce.t*) }
	.rela.text : { *(.rela.text) *(.rela.gnu.linkonce.t*) }
	.rel.data : { *(.rel.data) *(.rel.gnu.linkonce.d*) }
	.rela.data : { *(.rela.data) *(.rela.gnu.linkonce.d*) }
	.rel.rodata : { *(.rel.rodata) *(.rel.gnu.linkonce.r*) }
	.rela.rodata : { *(.rela.rodata) *(.rela.gnu.linkonce.r*) }
	.rel.got : { *(.rel.got) }
	.rela.got : { *(.rela.got) }
	.rel.ctors : { *(.rel.ctors) }
	.rela.ctors : { *(.rela.ctors) }
	.rel.dtors : { *(.rel.dtors) }
	.rela.dtors : { *(.rela.dtors) }
	.rel.init : { *(.rel.init) }
	.rela.init : { *(.rela.init) }
	.rel.fini : { *(.rel.fini) }
	.rela.fini : { *(.rela.fini) }
	.rel.bss : { *(.rel.bss) }
	.rela.bss : { *(.rela.bss) }
	.rel.plt : { *(.rel.plt) }
	.rela.plt : { *(.rela.plt) }
	.init : { *(.init) } =0x9090
	.plt : { *(.plt) }
	.ARM.exidx : {
		__exidx_start = .;
		*(.ARM.exidx* .gnu.linkonce.armexidx.*)
		__exidx_end = .;
	}
	.ARM.extab : {
		__extab_start = .;
		*(.ARM.extab*)
		__extab_end = .;
	}
#ifdef CFG_CORE_RWDATA_NOEXEC
	. = ALIGN(SMALL_PAGE_SIZE);
#endif
	__flatmap_unpg_ro_size = . - __flatmap_unpg_ro_start;
	__flatmap_unpg_rw_start = .;
	.data : ALIGN(8) {
		__data_start_rom = .;
		__data_start = .;
		*(.data .data.* .gnu.linkonce.d.*)
		. = ALIGN(8);
	}
	.ctors : ALIGN(8) {
		__ctor_list = .;
		KEEP(*(.ctors .ctors.* .init_array .init_array.*))
		__ctor_end = .;
	}
	.dtors : ALIGN(8) {
		__dtor_list = .;
		KEEP(*(.dtors .dtors.* .fini_array .fini_array.*))
		__dtor_end = .;
	}
	.got : { *(.got.plt) *(.got) }
	.dynamic : { *(.dynamic) }
	.bss : {
		__data_end = .;
		__bss_start = .;
		*(.bss .bss.*)
		*(.gnu.linkonce.b.*)
		*(COMMON)
		. = ALIGN(8);
		__bss_end = .;
	}
	.heap1 (NOLOAD) : {
		__heap1_start = .;
#ifndef CFG_WITH_PAGER
		. += CFG_CORE_HEAP_SIZE;
#endif
		. = ALIGN(16 * 1024);
		__heap1_end = .;
	}
	.nozi (NOLOAD) : {
		__nozi_start = .;
		ASSERT(!(__nozi_start & (16 * 1024 - 1)), "align nozi to 16kB");
		KEEP(*(.nozi .nozi.*))
		. = ALIGN(16);
		__nozi_end = .;
		__nozi_stack_start = .;
		KEEP(*(.nozi_stack))
		. = ALIGN(8);
		__nozi_stack_end = .;
	}
#ifdef CFG_WITH_PAGER
	.heap2 (NOLOAD) : {
		__heap2_start = .;
		. += CFG_CORE_HEAP_SIZE - (__heap1_end - __heap1_start);
		. = ALIGN(SMALL_PAGE_SIZE);
		__heap2_end = .;
	}
	__flatmap_unpg_rw_size = . - __flatmap_unpg_rw_start;
	__init_start = .;
	__flatmap_init_rx_start = .;
	ASSERT(!(__flatmap_init_rx_start & (SMALL_PAGE_SIZE - 1)),
		"read-write memory is not paged aligned")
	.text_init : {
#include <text_init.ld.S>
		KEEP(*(.text.startup.*));
		KEEP(*(.text._GLOBAL__sub_*));
		. = ALIGN(8);
	}
#ifdef CFG_CORE_RODATA_NOEXEC
	. = ALIGN(SMALL_PAGE_SIZE);
#endif
	__flatmap_init_rx_size = . - __flatmap_init_rx_start;
	__flatmap_init_ro_start = .;
	.rodata_init : {
#include <rodata_init.ld.S>
		. = ALIGN(8);
		__start_phys_mem_map_section = . ;
		KEEP(*(phys_mem_map_section))
		__end_phys_mem_map_section = . ;
		. = ALIGN(8);
		__start_phys_sdp_mem_section = . ;
		KEEP(*(phys_sdp_mem_section))
		__end_phys_sdp_mem_section = . ;
		. = ALIGN(8);
		__start_phys_nsec_ddr_section = . ;
		KEEP(*(phys_nsec_ddr_section))
		__end_phys_nsec_ddr_section = . ;
		. = ALIGN(8);
		__start_phys_ddr_overall_section = . ;
		KEEP(*(phys_ddr_overall_section))
		__end_phys_ddr_overall_section = . ;
		. = ALIGN(8);
		__rodata_init_end = .;
	}
	__rodata_init_end = .;
	__init_end = ROUNDUP(__rodata_init_end, SMALL_PAGE_SIZE);
	__init_size = __init_end - __init_start;
	__flatmap_init_ro_size = __init_end - __flatmap_init_ro_start;
	.rodata_pageable : ALIGN(8) {
#ifdef CFG_DT
		__rodata_dtdrv_start = .;
		KEEP(*(.rodata.dtdrv))
		__rodata_dtdrv_end = .;
#endif
#ifdef CFG_EARLY_TA
		. = ALIGN(8);
		__rodata_early_ta_start = .;
		KEEP(*(.rodata.early_ta))
		__rodata_early_ta_end = .;
#endif
		*(.rodata*)
		. = ALIGN(8);
		__start_ta_head_section = . ;
		KEEP(*(ta_head_section))
		__stop_ta_head_section = . ;
	}
#ifdef CFG_CORE_RODATA_NOEXEC
	. = ALIGN(SMALL_PAGE_SIZE);
#endif
	.text_pageable : ALIGN(8) {
		*(.text*)
		. = ALIGN(SMALL_PAGE_SIZE);
	}
	__pageable_part_end = .;
	__pageable_part_start = __init_end;
	__pageable_start = __init_start;
	__pageable_end = __pageable_part_end;
	__tmp_hashes_start = __init_end;
	__tmp_hashes_size = ((__pageable_end - __pageable_start) /
				SMALL_PAGE_SIZE) * 32;
	__tmp_hashes_end = __tmp_hashes_start + __tmp_hashes_size;
	__init_mem_usage = __tmp_hashes_end - TEE_TEXT_VA_START;
	ASSERT(TEE_LOAD_ADDR >= TEE_RAM_START,
		"Load address before start of physical memory")
	ASSERT(TEE_LOAD_ADDR < (TEE_RAM_START + TEE_RAM_PH_SIZE),
		"Load address after end of physical memory")
	ASSERT(__tmp_hashes_end < (TEE_RAM_VA_START + TEE_RAM_PH_SIZE),
		"OP-TEE can't fit init part into available physical memory")
	ASSERT((TEE_RAM_VA_START + TEE_RAM_PH_SIZE - __init_end) >
		SMALL_PAGE_SIZE, "Too few free pages to initialize paging")
#endif 
#ifdef CFG_CORE_SANITIZE_KADDRESS
	. = TEE_RAM_VA_START + (TEE_RAM_VA_SIZE * 8) / 9 - 8;
	. = ALIGN(8);
	.asan_shadow : {
		__asan_shadow_start = .;
		. += TEE_RAM_VA_SIZE / 9;
		__asan_shadow_end = .;
		__asan_shadow_size = __asan_shadow_end - __asan_shadow_start;
	}
#endif 
	__end = .;
#ifndef CFG_WITH_PAGER
	__init_size = __data_end - TEE_TEXT_VA_START;
	__init_mem_usage = __end - TEE_TEXT_VA_START;
#endif
	ASSERT(. <= (TEE_RAM_VA_START + TEE_RAM_VA_SIZE),
		"TEE_RAM_VA_SIZE is too small")
	. = TEE_RAM_VA_START + TEE_RAM_VA_SIZE;
	_end_of_ram = .;
#ifndef CFG_WITH_PAGER
	__flatmap_unpg_rw_size = _end_of_ram - __flatmap_unpg_rw_start;
#endif
	/DISCARD/ : {
		*(.comment .note .eh_frame)
		*(__keep_meta_vars*)
	}
}
__vcore_unpg_rx_start = __flatmap_unpg_rx_start;
__vcore_unpg_ro_start = __flatmap_unpg_ro_start;
#ifdef CFG_CORE_RODATA_NOEXEC
__vcore_unpg_rx_size = __flatmap_unpg_rx_size;
__vcore_unpg_ro_size = __flatmap_unpg_ro_size;
#else
__vcore_unpg_rx_size = __flatmap_unpg_rx_size + __flatmap_unpg_ro_size;
__vcore_unpg_ro_size = 0;
#endif
__vcore_unpg_rw_start = __flatmap_unpg_rw_start;
__vcore_unpg_rw_size = __flatmap_unpg_rw_size;
#ifdef CFG_WITH_PAGER
#define __FLATMAP_PAGER_TRAILING_SPACE	\
	(TEE_RAM_START + TEE_RAM_PH_SIZE - \
		(__flatmap_init_ro_start + __flatmap_init_ro_size))
__vcore_init_rx_start = __flatmap_init_rx_start;
__vcore_init_ro_start = __flatmap_init_ro_start;
#ifdef CFG_CORE_RODATA_NOEXEC
__vcore_init_rx_size = __flatmap_init_rx_size;
__vcore_init_ro_size = __flatmap_init_ro_size + __FLATMAP_PAGER_TRAILING_SPACE;
#else
__vcore_init_rx_size = __flatmap_init_rx_size + __flatmap_init_ro_size +
		       __FLATMAP_PAGER_TRAILING_SPACE;
__vcore_init_ro_size = 0;
#endif 
#endif 
#ifdef CFG_CORE_SANITIZE_KADDRESS
__asan_map_start = (__asan_shadow_start / SMALL_PAGE_SIZE) *
		   SMALL_PAGE_SIZE;
__asan_map_end = ((__asan_shadow_end - 1) / SMALL_PAGE_SIZE) *
		 SMALL_PAGE_SIZE + SMALL_PAGE_SIZE;
__asan_map_size = __asan_map_end - __asan_map_start;
#endif 
