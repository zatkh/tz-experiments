	.arch armv8-a
	.file	"asm-defines.c"
// GNU C99 (Linaro GCC 6.2-2016.11) version 6.2.1 20161016 (aarch64-linux-gnu)
//	compiled by GNU C version 4.8.4, GMP version 6.1.0, MPFR version 3.1.4, MPC version 1.0.3, isl version none
// GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
// options passed:  -nostdinc -I lib/libutils/isoc/include
// -I lib/libutils/isoc/../../libopenlibm/include
// -I lib/libutils/isoc/../../libopenlibm/src -I lib/libutils/ext/include
// -I lib/libmpa/include -I core/lib/libtomcrypt/include
// -I core/lib/libfdt/include -I core/arch/arm/plat-vexpress/.
// -I core/include -I out/arm/core/include -I core/arch/arm/include
// -I lib/libutee/include -imultiarch aarch64-linux-gnu
// -iprefix /home/zt233/Documents/test-tz/toolchains/aarch64/bin/../lib/gcc/aarch64-linux-gnu/6.2.1/
// -isysroot /home/zt233/Documents/test-tz/toolchains/aarch64/bin/../aarch64-linux-gnu/libc
// -MD out/arm/core/include/generated/.asm-defines.d
// -MF out/arm/core/include/generated/.asm-defines.s.d
// -MT out/arm/core/include/generated/.asm-defines.s -D __KERNEL__
// -D ARM64=1 -D __LP64__=1 -D TRACE_LEVEL=3
// -isystem /home/zt233/Documents/test-tz/toolchains/aarch64/bin/../lib/gcc/aarch64-linux-gnu/6.2.1/include
// -include out/arm/include/generated/conf.h
// core/arch/arm/kernel/asm-defines.c -mstrict-align -mgeneral-regs-only
// -march=armv8-a -mlittle-endian -mabi=lp64
// -auxbase-strip out/arm/core/include/generated/.asm-defines.s -g -g3 -Os
// -Wall -Wcast-align -Werror=implicit-function-declaration -Wextra
// -Wfloat-equal -Wformat-nonliteral -Wformat-security -Wformat=2
// -Winit-self -Wmissing-declarations -Wsuggest-attribute=format
// -Wmissing-include-dirs -Wsuggest-attribute=noreturn -Wmissing-prototypes
// -Wnested-externs -Wpointer-arith -Wshadow -Wstrict-prototypes
// -Wswitch-default -Wwrite-strings -Wno-missing-field-initializers
// -Wno-format-zero-length -Waggregate-return -Wredundant-decls
// -Wold-style-definition -Wstrict-aliasing=2 -Wundef -Wpedantic
// -Wdeclaration-after-statement -std=gnu99 -fdiagnostics-show-option
// -ffunction-sections -fdata-sections -fverbose-asm
// options enabled:  -faggressive-loop-optimizations -falign-functions
// -falign-jumps -falign-labels -falign-loops -fauto-inc-dec
// -fbranch-count-reg -fcaller-saves -fchkp-check-incomplete-type
// -fchkp-check-read -fchkp-check-write -fchkp-instrument-calls
// -fchkp-narrow-bounds -fchkp-optimize -fchkp-store-bounds
// -fchkp-use-static-bounds -fchkp-use-static-const-bounds
// -fchkp-use-wrappers -fcombine-stack-adjustments -fcommon -fcompare-elim
// -fcprop-registers -fcrossjumping -fcse-follow-jumps -fdata-sections
// -fdefer-pop -fdelete-null-pointer-checks -fdevirtualize
// -fdevirtualize-speculatively -fdwarf2-cfi-asm -fearly-inlining
// -feliminate-unused-debug-types -fexpensive-optimizations
// -fforward-propagate -ffunction-cse -ffunction-sections -fgcse -fgcse-lm
// -fgnu-runtime -fgnu-unique -fguess-branch-probability
// -fhoist-adjacent-loads -fident -fif-conversion -fif-conversion2
// -findirect-inlining -finline -finline-atomics -finline-functions
// -finline-functions-called-once -finline-small-functions -fipa-cp
// -fipa-cp-alignment -fipa-icf -fipa-icf-functions -fipa-icf-variables
// -fipa-profile -fipa-pure-const -fipa-ra -fipa-reference -fipa-sra
// -fira-hoist-pressure -fira-share-save-slots -fira-share-spill-slots
// -fisolate-erroneous-paths-dereference -fivopts -fkeep-static-consts
// -fleading-underscore -flifetime-dse -flra-remat -flto-odr-type-merging
// -fmath-errno -fmerge-constants -fmerge-debug-strings
// -fmove-loop-invariants -fomit-frame-pointer -foptimize-sibling-calls
// -fpartial-inlining -fpeephole -fpeephole2 -fplt -fprefetch-loop-arrays
// -free -freg-struct-return -freorder-blocks -freorder-functions
// -frerun-cse-after-loop -fsched-critical-path-heuristic
// -fsched-dep-count-heuristic -fsched-group-heuristic -fsched-interblock
// -fsched-last-insn-heuristic -fsched-pressure -fsched-rank-heuristic
// -fsched-spec -fsched-spec-insn-heuristic -fsched-stalled-insns-dep
// -fschedule-fusion -fschedule-insns2 -fsection-anchors
// -fsemantic-interposition -fshow-column -fshrink-wrap -fsigned-zeros
// -fsplit-ivs-in-unroller -fsplit-wide-types -fssa-backprop -fssa-phiopt
// -fstdarg-opt -fstrict-aliasing -fstrict-overflow
// -fstrict-volatile-bitfields -fsync-libcalls -fthread-jumps
// -ftoplevel-reorder -ftrapping-math -ftree-bit-ccp
// -ftree-builtin-call-dce -ftree-ccp -ftree-ch -ftree-coalesce-vars
// -ftree-copy-prop -ftree-cselim -ftree-dce -ftree-dominator-opts
// -ftree-dse -ftree-forwprop -ftree-fre -ftree-loop-if-convert
// -ftree-loop-im -ftree-loop-ivcanon -ftree-loop-optimize
// -ftree-parallelize-loops= -ftree-phiprop -ftree-pre -ftree-pta
// -ftree-reassoc -ftree-scev-cprop -ftree-sink -ftree-slsr -ftree-sra
// -ftree-switch-conversion -ftree-tail-merge -ftree-ter -ftree-vrp
// -funit-at-a-time -fvar-tracking -fvar-tracking-assignments -fverbose-asm
// -fzero-initialized-in-bss -mfix-cortex-a53-835769
// -mfix-cortex-a53-843419 -mgeneral-regs-only -mglibc -mlittle-endian
// -momit-leaf-frame-pointer -mpc-relative-literal-loads -mstrict-align

	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.section	.text.__defines,"ax",@progbits
	.align	2
	.global	__defines
	.type	__defines, %function
__defines:
.LFB64:
	.file 1 "core/arch/arm/kernel/asm-defines.c"
	.loc 1 14 0
	.cfi_startproc
	.loc 1 41 0
#APP
// 41 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_SMC_ARGS_X0 0 offsetof(struct thread_smc_args, a0)	//
// 0 "" 2
	.loc 1 42 0
// 42 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_SMC_ARGS_SIZE 64 sizeof(struct thread_smc_args)	//
// 0 "" 2
	.loc 1 44 0
// 44 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_SVC_REG_X0 16 offsetof(struct thread_svc_regs, x0)	//
// 0 "" 2
	.loc 1 45 0
// 45 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_SVC_REG_X2 32 offsetof(struct thread_svc_regs, x2)	//
// 0 "" 2
	.loc 1 46 0
// 46 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_SVC_REG_X5 56 offsetof(struct thread_svc_regs, x5)	//
// 0 "" 2
	.loc 1 47 0
// 47 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_SVC_REG_X6 64 offsetof(struct thread_svc_regs, x6)	//
// 0 "" 2
	.loc 1 48 0
// 48 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_SVC_REG_X30 136 offsetof(struct thread_svc_regs, x30)	//
// 0 "" 2
	.loc 1 49 0
// 49 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_SVC_REG_ELR 0 offsetof(struct thread_svc_regs, elr)	//
// 0 "" 2
	.loc 1 50 0
// 50 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_SVC_REG_SPSR 8 offsetof(struct thread_svc_regs, spsr)	//
// 0 "" 2
	.loc 1 51 0
// 51 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_SVC_REG_SP_EL0 144 offsetof(struct thread_svc_regs, sp_el0)	//
// 0 "" 2
	.loc 1 52 0
// 52 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_SVC_REG_SIZE 160 sizeof(struct thread_svc_regs)	//
// 0 "" 2
	.loc 1 55 0
// 55 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_ABT_REG_X0 0 offsetof(struct thread_abort_regs, x0)	//
// 0 "" 2
	.loc 1 56 0
// 56 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_ABT_REG_X2 16 offsetof(struct thread_abort_regs, x2)	//
// 0 "" 2
	.loc 1 57 0
// 57 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_ABT_REG_X30 240 offsetof(struct thread_abort_regs, x30)	//
// 0 "" 2
	.loc 1 58 0
// 58 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_ABT_REG_SPSR 256 offsetof(struct thread_abort_regs, spsr)	//
// 0 "" 2
	.loc 1 59 0
// 59 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_ABT_REGS_SIZE 272 sizeof(struct thread_abort_regs)	//
// 0 "" 2
	.loc 1 62 0
// 62 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_CTX_KERN_SP 320 offsetof(struct thread_ctx, kern_sp)	//
// 0 "" 2
	.loc 1 63 0
// 63 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_CTX_SIZE 1536 sizeof(struct thread_ctx)	//
// 0 "" 2
	.loc 1 66 0
// 66 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_CTX_REGS_SP 0 offsetof(struct thread_ctx_regs, sp)	//
// 0 "" 2
	.loc 1 67 0
// 67 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_CTX_REGS_X0 24 offsetof(struct thread_ctx_regs, x[0])	//
// 0 "" 2
	.loc 1 68 0
// 68 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_CTX_REGS_X1 32 offsetof(struct thread_ctx_regs, x[1])	//
// 0 "" 2
	.loc 1 69 0
// 69 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_CTX_REGS_X4 56 offsetof(struct thread_ctx_regs, x[4])	//
// 0 "" 2
	.loc 1 70 0
// 70 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_CTX_REGS_X19 176 offsetof(struct thread_ctx_regs, x[19])	//
// 0 "" 2
	.loc 1 73 0
// 73 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_USER_MODE_REC_EXIT_STATUS0_PTR 0 offsetof(struct thread_user_mode_rec, exit_status0_ptr)	//
// 0 "" 2
	.loc 1 75 0
// 75 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_USER_MODE_REC_X19 16 offsetof(struct thread_user_mode_rec, x[0])	//
// 0 "" 2
	.loc 1 77 0
// 77 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_USER_MODE_REC_SIZE 112 sizeof(struct thread_user_mode_rec)	//
// 0 "" 2
	.loc 1 80 0
// 80 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_CORE_LOCAL_X0 0 offsetof(struct thread_core_local, x[0])	//
// 0 "" 2
	.loc 1 81 0
// 81 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_CORE_LOCAL_X2 16 offsetof(struct thread_core_local, x[2])	//
// 0 "" 2
	.loc 1 85 0
// 85 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_CORE_LOCAL_TMP_STACK_VA_END 32 offsetof(struct thread_core_local, tmp_stack_va_end)	//
// 0 "" 2
	.loc 1 87 0
// 87 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_CORE_LOCAL_CURR_THREAD 40 offsetof(struct thread_core_local, curr_thread)	//
// 0 "" 2
	.loc 1 89 0
// 89 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_CORE_LOCAL_FLAGS 44 offsetof(struct thread_core_local, flags)	//
// 0 "" 2
	.loc 1 91 0
// 91 "core/arch/arm/kernel/asm-defines.c" 1
	
==>THREAD_CORE_LOCAL_ABT_STACK_VA_END 48 offsetof(struct thread_core_local, abt_stack_va_end)	//
// 0 "" 2
#NO_APP
	ret
	.cfi_endproc
.LFE64:
	.size	__defines, .-__defines
	.text
.Letext0:
	.file 2 "lib/libutils/isoc/include/stdint.h"
	.file 3 "/home/zt233/Documents/test-tz/toolchains/aarch64/lib/gcc/aarch64-linux-gnu/6.2.1/include/stddef.h"
	.file 4 "lib/libutils/ext/include/types_ext.h"
	.file 5 "core/arch/arm/include/kernel/wait_queue.h"
	.file 6 "core/arch/arm/include/kernel/mutex.h"
	.file 7 "core/arch/arm/include/kernel/vfp.h"
	.file 8 "lib/libutee/include/tee_api_types.h"
	.file 9 "lib/libutee/include/user_ta_header.h"
	.file 10 "lib/libutils/isoc/include/malloc.h"
	.file 11 "core/include/kernel/tee_ta_manager.h"
	.file 12 "core/arch/arm/include/mm/pgt_cache.h"
	.file 13 "core/arch/arm/include/kernel/thread.h"
	.file 14 "lib/libutils/ext/include/trace.h"
	.file 15 "core/include/mm/tee_mm.h"
	.file 16 "core/arch/arm/include/mm/core_mmu.h"
	.file 17 "core/arch/arm/kernel/thread_private.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0xdd9
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.4byte	.LASF1712
	.byte	0xc
	.4byte	.LASF1713
	.4byte	.LASF1714
	.4byte	.Ldebug_ranges0+0
	.8byte	0
	.4byte	.Ldebug_line0
	.4byte	.Ldebug_macro0
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.4byte	.LASF1525
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF1526
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF1527
	.uleb128 0x4
	.4byte	.LASF1529
	.byte	0x2
	.byte	0x37
	.4byte	0x54
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF1528
	.uleb128 0x4
	.4byte	.LASF1530
	.byte	0x2
	.byte	0x38
	.4byte	0x66
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF1531
	.uleb128 0x4
	.4byte	.LASF1532
	.byte	0x2
	.byte	0x3a
	.4byte	0x7d
	.uleb128 0x5
	.4byte	0x6d
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF1533
	.uleb128 0x4
	.4byte	.LASF1534
	.byte	0x2
	.byte	0x42
	.4byte	0x8f
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF1535
	.uleb128 0x4
	.4byte	.LASF1536
	.byte	0x2
	.byte	0x5b
	.4byte	0x8f
	.uleb128 0x4
	.4byte	.LASF1537
	.byte	0x3
	.byte	0xd8
	.4byte	0x8f
	.uleb128 0x5
	.4byte	0xa1
	.uleb128 0x4
	.4byte	.LASF1538
	.byte	0x4
	.byte	0x11
	.4byte	0x96
	.uleb128 0x4
	.4byte	.LASF1539
	.byte	0x4
	.byte	0x1b
	.4byte	0x96
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF1540
	.uleb128 0x6
	.4byte	.LASF1541
	.byte	0x8
	.byte	0x5
	.byte	0xc
	.4byte	0xe7
	.uleb128 0x7
	.4byte	.LASF1543
	.byte	0x5
	.byte	0xc
	.4byte	0x12f
	.byte	0
	.byte	0
	.uleb128 0x6
	.4byte	.LASF1542
	.byte	0x18
	.byte	0x5
	.byte	0x11
	.4byte	0x12f
	.uleb128 0x7
	.4byte	.LASF1544
	.byte	0x5
	.byte	0x12
	.4byte	0x34
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1545
	.byte	0x5
	.byte	0x13
	.4byte	0x14a
	.byte	0x2
	.uleb128 0x7
	.4byte	.LASF1546
	.byte	0x5
	.byte	0x14
	.4byte	0x14a
	.byte	0x3
	.uleb128 0x8
	.string	"cv"
	.byte	0x5
	.byte	0x15
	.4byte	0x174
	.byte	0x8
	.uleb128 0x7
	.4byte	.LASF1547
	.byte	0x5
	.byte	0x16
	.4byte	0x135
	.byte	0x10
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.4byte	0xe7
	.uleb128 0xa
	.byte	0x8
	.byte	0x5
	.byte	0x16
	.4byte	0x14a
	.uleb128 0x7
	.4byte	.LASF1548
	.byte	0x5
	.byte	0x16
	.4byte	0x12f
	.byte	0
	.byte	0
	.uleb128 0x2
	.byte	0x1
	.byte	0x2
	.4byte	.LASF1549
	.uleb128 0x6
	.4byte	.LASF1550
	.byte	0x10
	.byte	0x6
	.byte	0x40
	.4byte	0x174
	.uleb128 0x7
	.4byte	.LASF1551
	.byte	0x6
	.byte	0x41
	.4byte	0x7d
	.byte	0
	.uleb128 0x8
	.string	"m"
	.byte	0x6
	.byte	0x42
	.4byte	0x1e3
	.byte	0x8
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.4byte	0x151
	.uleb128 0xa
	.byte	0x10
	.byte	0x6
	.byte	0x1a
	.4byte	0x19b
	.uleb128 0x7
	.4byte	.LASF1552
	.byte	0x6
	.byte	0x1a
	.4byte	0x1e3
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1553
	.byte	0x6
	.byte	0x1a
	.4byte	0x1e9
	.byte	0x8
	.byte	0
	.uleb128 0x6
	.4byte	.LASF1554
	.byte	0x28
	.byte	0x6
	.byte	0x15
	.4byte	0x1e3
	.uleb128 0x7
	.4byte	.LASF1551
	.byte	0x6
	.byte	0x16
	.4byte	0x7d
	.byte	0
	.uleb128 0x8
	.string	"wq"
	.byte	0x6
	.byte	0x17
	.4byte	0xce
	.byte	0x8
	.uleb128 0x7
	.4byte	.LASF1555
	.byte	0x6
	.byte	0x18
	.4byte	0x34
	.byte	0x10
	.uleb128 0x7
	.4byte	.LASF1556
	.byte	0x6
	.byte	0x19
	.4byte	0x34
	.byte	0x12
	.uleb128 0x7
	.4byte	.LASF1547
	.byte	0x6
	.byte	0x1a
	.4byte	0x17a
	.byte	0x18
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.4byte	0x19b
	.uleb128 0x9
	.byte	0x8
	.4byte	0x1e3
	.uleb128 0x6
	.4byte	.LASF1557
	.byte	0x10
	.byte	0x6
	.byte	0x1f
	.4byte	0x214
	.uleb128 0x7
	.4byte	.LASF1558
	.byte	0x6
	.byte	0x1f
	.4byte	0x1e3
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1559
	.byte	0x6
	.byte	0x1f
	.4byte	0x1e9
	.byte	0x8
	.byte	0
	.uleb128 0x6
	.4byte	.LASF1560
	.byte	0x10
	.byte	0x7
	.byte	0x2c
	.4byte	0x22b
	.uleb128 0x8
	.string	"v"
	.byte	0x7
	.byte	0x2d
	.4byte	0x22b
	.byte	0
	.byte	0
	.uleb128 0xb
	.4byte	0x49
	.4byte	0x23b
	.uleb128 0xc
	.4byte	0xc7
	.byte	0xf
	.byte	0
	.uleb128 0xd
	.4byte	.LASF1561
	.2byte	0x210
	.byte	0x7
	.byte	0x30
	.4byte	0x289
	.uleb128 0x8
	.string	"reg"
	.byte	0x7
	.byte	0x31
	.4byte	0x289
	.byte	0
	.uleb128 0xe
	.4byte	.LASF1562
	.byte	0x7
	.byte	0x32
	.4byte	0x6d
	.2byte	0x200
	.uleb128 0xe
	.4byte	.LASF1563
	.byte	0x7
	.byte	0x33
	.4byte	0x6d
	.2byte	0x204
	.uleb128 0xe
	.4byte	.LASF1564
	.byte	0x7
	.byte	0x34
	.4byte	0x6d
	.2byte	0x208
	.uleb128 0xe
	.4byte	.LASF1565
	.byte	0x7
	.byte	0x35
	.4byte	0x14a
	.2byte	0x20c
	.byte	0
	.uleb128 0xb
	.4byte	0x214
	.4byte	0x299
	.uleb128 0xc
	.4byte	0xc7
	.byte	0x1f
	.byte	0
	.uleb128 0x4
	.4byte	.LASF1566
	.byte	0x8
	.byte	0x14
	.4byte	0x6d
	.uleb128 0xa
	.byte	0x10
	.byte	0x8
	.byte	0x16
	.4byte	0x2dd
	.uleb128 0x7
	.4byte	.LASF1567
	.byte	0x8
	.byte	0x17
	.4byte	0x6d
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1568
	.byte	0x8
	.byte	0x18
	.4byte	0x5b
	.byte	0x4
	.uleb128 0x7
	.4byte	.LASF1569
	.byte	0x8
	.byte	0x19
	.4byte	0x5b
	.byte	0x6
	.uleb128 0x7
	.4byte	.LASF1570
	.byte	0x8
	.byte	0x1a
	.4byte	0x2dd
	.byte	0x8
	.byte	0
	.uleb128 0xb
	.4byte	0x49
	.4byte	0x2ed
	.uleb128 0xc
	.4byte	0xc7
	.byte	0x7
	.byte	0
	.uleb128 0x4
	.4byte	.LASF1571
	.byte	0x8
	.byte	0x1b
	.4byte	0x2a4
	.uleb128 0xa
	.byte	0x14
	.byte	0x8
	.byte	0x22
	.4byte	0x319
	.uleb128 0x7
	.4byte	.LASF1572
	.byte	0x8
	.byte	0x23
	.4byte	0x6d
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1573
	.byte	0x8
	.byte	0x24
	.4byte	0x2ed
	.byte	0x4
	.byte	0
	.uleb128 0x4
	.4byte	.LASF1574
	.byte	0x8
	.byte	0x25
	.4byte	0x2f8
	.uleb128 0xa
	.byte	0x10
	.byte	0x8
	.byte	0x32
	.4byte	0x345
	.uleb128 0x7
	.4byte	.LASF1575
	.byte	0x8
	.byte	0x33
	.4byte	0x345
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1576
	.byte	0x8
	.byte	0x34
	.4byte	0x6d
	.byte	0x8
	.byte	0
	.uleb128 0xf
	.byte	0x8
	.uleb128 0xa
	.byte	0x8
	.byte	0x8
	.byte	0x36
	.4byte	0x364
	.uleb128 0x8
	.string	"a"
	.byte	0x8
	.byte	0x37
	.4byte	0x6d
	.byte	0
	.uleb128 0x8
	.string	"b"
	.byte	0x8
	.byte	0x38
	.4byte	0x6d
	.byte	0x4
	.byte	0
	.uleb128 0x10
	.byte	0x10
	.byte	0x8
	.byte	0x31
	.4byte	0x383
	.uleb128 0x11
	.4byte	.LASF1577
	.byte	0x8
	.byte	0x35
	.4byte	0x324
	.uleb128 0x11
	.4byte	.LASF1578
	.byte	0x8
	.byte	0x39
	.4byte	0x347
	.byte	0
	.uleb128 0x4
	.4byte	.LASF1579
	.byte	0x8
	.byte	0x3a
	.4byte	0x364
	.uleb128 0xa
	.byte	0x8
	.byte	0x8
	.byte	0xa0
	.4byte	0x3af
	.uleb128 0x7
	.4byte	.LASF1580
	.byte	0x8
	.byte	0xa1
	.4byte	0x6d
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1581
	.byte	0x8
	.byte	0xa2
	.4byte	0x6d
	.byte	0x4
	.byte	0
	.uleb128 0x4
	.4byte	.LASF1582
	.byte	0x8
	.byte	0xa3
	.4byte	0x38e
	.uleb128 0x4
	.4byte	.LASF1583
	.byte	0x8
	.byte	0xc0
	.4byte	0x6d
	.uleb128 0x12
	.4byte	.LASF1594
	.byte	0xa
	.byte	0xb
	.4byte	0x7d
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF1584
	.uleb128 0x5
	.4byte	0x3d0
	.uleb128 0x13
	.4byte	.LASF1678
	.byte	0x4
	.4byte	0x7d
	.byte	0x9
	.byte	0x39
	.4byte	0x411
	.uleb128 0x14
	.4byte	.LASF1585
	.byte	0
	.uleb128 0x14
	.4byte	.LASF1586
	.byte	0x1
	.uleb128 0x14
	.4byte	.LASF1587
	.byte	0x2
	.uleb128 0x14
	.4byte	.LASF1588
	.byte	0x3
	.uleb128 0x14
	.4byte	.LASF1589
	.byte	0x4
	.uleb128 0x14
	.4byte	.LASF1590
	.byte	0x5
	.byte	0
	.uleb128 0x6
	.4byte	.LASF1591
	.byte	0x18
	.byte	0x9
	.byte	0x48
	.4byte	0x442
	.uleb128 0x7
	.4byte	.LASF1592
	.byte	0x9
	.byte	0x49
	.4byte	0x447
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1593
	.byte	0x9
	.byte	0x4a
	.4byte	0x3dc
	.byte	0x8
	.uleb128 0x7
	.4byte	.LASF1578
	.byte	0x9
	.byte	0x4b
	.4byte	0x44d
	.byte	0x10
	.byte	0
	.uleb128 0x5
	.4byte	0x411
	.uleb128 0x9
	.byte	0x8
	.4byte	0x3d7
	.uleb128 0x9
	.byte	0x8
	.4byte	0x453
	.uleb128 0x15
	.uleb128 0xb
	.4byte	0x442
	.4byte	0x45f
	.uleb128 0x16
	.byte	0
	.uleb128 0x5
	.4byte	0x454
	.uleb128 0x12
	.4byte	.LASF1595
	.byte	0x9
	.byte	0x4e
	.4byte	0x45f
	.uleb128 0x12
	.4byte	.LASF1596
	.byte	0x9
	.byte	0x4f
	.4byte	0xac
	.uleb128 0x12
	.4byte	.LASF1597
	.byte	0x9
	.byte	0x52
	.4byte	0x6d
	.uleb128 0xb
	.4byte	0x383
	.4byte	0x495
	.uleb128 0xc
	.4byte	0xc7
	.byte	0x3
	.byte	0
	.uleb128 0x12
	.4byte	.LASF1598
	.byte	0x9
	.byte	0x53
	.4byte	0x485
	.uleb128 0x6
	.4byte	.LASF1599
	.byte	0x80
	.byte	0xb
	.byte	0x5a
	.4byte	0x549
	.uleb128 0x7
	.4byte	.LASF1547
	.byte	0xb
	.byte	0x5b
	.4byte	0x7b5
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1600
	.byte	0xb
	.byte	0x5c
	.4byte	0x7d6
	.byte	0x10
	.uleb128 0x8
	.string	"ctx"
	.byte	0xb
	.byte	0x5d
	.4byte	0x5f3
	.byte	0x20
	.uleb128 0x7
	.4byte	.LASF1601
	.byte	0xb
	.byte	0x5e
	.4byte	0x319
	.byte	0x28
	.uleb128 0x7
	.4byte	.LASF1602
	.byte	0xb
	.byte	0x5f
	.4byte	0x14a
	.byte	0x3c
	.uleb128 0x7
	.4byte	.LASF1603
	.byte	0xb
	.byte	0x60
	.4byte	0x14a
	.byte	0x3d
	.uleb128 0x7
	.4byte	.LASF1604
	.byte	0xb
	.byte	0x61
	.4byte	0x3af
	.byte	0x40
	.uleb128 0x7
	.4byte	.LASF1605
	.byte	0xb
	.byte	0x62
	.4byte	0x345
	.byte	0x48
	.uleb128 0x7
	.4byte	.LASF1606
	.byte	0xb
	.byte	0x63
	.4byte	0x6d
	.byte	0x50
	.uleb128 0x7
	.4byte	.LASF1607
	.byte	0xb
	.byte	0x64
	.4byte	0x151
	.byte	0x58
	.uleb128 0x7
	.4byte	.LASF1608
	.byte	0xb
	.byte	0x65
	.4byte	0x151
	.byte	0x68
	.uleb128 0x7
	.4byte	.LASF1609
	.byte	0xb
	.byte	0x66
	.4byte	0x3b
	.byte	0x78
	.uleb128 0x7
	.4byte	.LASF1610
	.byte	0xb
	.byte	0x67
	.4byte	0x14a
	.byte	0x7c
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.4byte	0x4a0
	.uleb128 0x9
	.byte	0x8
	.4byte	0x549
	.uleb128 0x6
	.4byte	.LASF1611
	.byte	0x10
	.byte	0xb
	.byte	0x19
	.4byte	0x57a
	.uleb128 0x7
	.4byte	.LASF1558
	.byte	0xb
	.byte	0x19
	.4byte	0x5f3
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1559
	.byte	0xb
	.byte	0x19
	.4byte	0x5f9
	.byte	0x8
	.byte	0
	.uleb128 0x6
	.4byte	.LASF1612
	.byte	0x50
	.byte	0xb
	.byte	0x4e
	.4byte	0x5f3
	.uleb128 0x7
	.4byte	.LASF1573
	.byte	0xb
	.byte	0x4f
	.4byte	0x2ed
	.byte	0
	.uleb128 0x8
	.string	"ops"
	.byte	0xb
	.byte	0x50
	.4byte	0x7af
	.byte	0x10
	.uleb128 0x7
	.4byte	.LASF1613
	.byte	0xb
	.byte	0x51
	.4byte	0x6d
	.byte	0x18
	.uleb128 0x7
	.4byte	.LASF1547
	.byte	0xb
	.byte	0x52
	.4byte	0x78e
	.byte	0x20
	.uleb128 0x7
	.4byte	.LASF1614
	.byte	0xb
	.byte	0x53
	.4byte	0x6d
	.byte	0x30
	.uleb128 0x7
	.4byte	.LASF1615
	.byte	0xb
	.byte	0x54
	.4byte	0x6d
	.byte	0x34
	.uleb128 0x7
	.4byte	.LASF1606
	.byte	0xb
	.byte	0x55
	.4byte	0x6d
	.byte	0x38
	.uleb128 0x7
	.4byte	.LASF1616
	.byte	0xb
	.byte	0x56
	.4byte	0x14a
	.byte	0x3c
	.uleb128 0x7
	.4byte	.LASF1617
	.byte	0xb
	.byte	0x57
	.4byte	0x151
	.byte	0x40
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.4byte	0x57a
	.uleb128 0x9
	.byte	0x8
	.4byte	0x5f3
	.uleb128 0x6
	.4byte	.LASF1618
	.byte	0x8
	.byte	0xb
	.byte	0x1d
	.4byte	0x620
	.uleb128 0x8
	.string	"a"
	.byte	0xb
	.byte	0x1e
	.4byte	0x6d
	.byte	0
	.uleb128 0x8
	.string	"b"
	.byte	0xb
	.byte	0x1f
	.4byte	0x6d
	.byte	0x4
	.byte	0
	.uleb128 0x6
	.4byte	.LASF1619
	.byte	0x18
	.byte	0xb
	.byte	0x22
	.4byte	0x651
	.uleb128 0x7
	.4byte	.LASF1620
	.byte	0xb
	.byte	0x23
	.4byte	0x656
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1576
	.byte	0xb
	.byte	0x24
	.4byte	0xa1
	.byte	0x8
	.uleb128 0x7
	.4byte	.LASF1621
	.byte	0xb
	.byte	0x25
	.4byte	0xa1
	.byte	0x10
	.byte	0
	.uleb128 0x17
	.4byte	.LASF1620
	.uleb128 0x9
	.byte	0x8
	.4byte	0x651
	.uleb128 0x10
	.byte	0x18
	.byte	0xb
	.byte	0x2a
	.4byte	0x67b
	.uleb128 0x18
	.string	"val"
	.byte	0xb
	.byte	0x2b
	.4byte	0x5ff
	.uleb128 0x18
	.string	"mem"
	.byte	0xb
	.byte	0x2c
	.4byte	0x620
	.byte	0
	.uleb128 0x6
	.4byte	.LASF1622
	.byte	0x68
	.byte	0xb
	.byte	0x28
	.4byte	0x69e
	.uleb128 0x7
	.4byte	.LASF1623
	.byte	0xb
	.byte	0x29
	.4byte	0x6d
	.byte	0
	.uleb128 0x8
	.string	"u"
	.byte	0xb
	.byte	0x2d
	.4byte	0x69e
	.byte	0x8
	.byte	0
	.uleb128 0xb
	.4byte	0x65c
	.4byte	0x6ae
	.uleb128 0xc
	.4byte	0xc7
	.byte	0x3
	.byte	0
	.uleb128 0x6
	.4byte	.LASF1624
	.byte	0x30
	.byte	0xb
	.byte	0x34
	.4byte	0x703
	.uleb128 0x7
	.4byte	.LASF1625
	.byte	0xb
	.byte	0x35
	.4byte	0x72d
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1626
	.byte	0xb
	.byte	0x37
	.4byte	0x751
	.byte	0x8
	.uleb128 0x7
	.4byte	.LASF1627
	.byte	0xb
	.byte	0x39
	.4byte	0x762
	.byte	0x10
	.uleb128 0x7
	.4byte	.LASF1628
	.byte	0xb
	.byte	0x3a
	.4byte	0x773
	.byte	0x18
	.uleb128 0x7
	.4byte	.LASF1629
	.byte	0xb
	.byte	0x3b
	.4byte	0x773
	.byte	0x20
	.uleb128 0x7
	.4byte	.LASF1630
	.byte	0xb
	.byte	0x3c
	.4byte	0x788
	.byte	0x28
	.byte	0
	.uleb128 0x5
	.4byte	0x6ae
	.uleb128 0x19
	.4byte	0x299
	.4byte	0x721
	.uleb128 0x1a
	.4byte	0x549
	.uleb128 0x1a
	.4byte	0x721
	.uleb128 0x1a
	.4byte	0x727
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.4byte	0x67b
	.uleb128 0x9
	.byte	0x8
	.4byte	0x3ba
	.uleb128 0x9
	.byte	0x8
	.4byte	0x708
	.uleb128 0x19
	.4byte	0x299
	.4byte	0x751
	.uleb128 0x1a
	.4byte	0x549
	.uleb128 0x1a
	.4byte	0x6d
	.uleb128 0x1a
	.4byte	0x721
	.uleb128 0x1a
	.4byte	0x727
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.4byte	0x733
	.uleb128 0x1b
	.4byte	0x762
	.uleb128 0x1a
	.4byte	0x549
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.4byte	0x757
	.uleb128 0x1b
	.4byte	0x773
	.uleb128 0x1a
	.4byte	0x5f3
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.4byte	0x768
	.uleb128 0x19
	.4byte	0x6d
	.4byte	0x788
	.uleb128 0x1a
	.4byte	0x5f3
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.4byte	0x779
	.uleb128 0xa
	.byte	0x10
	.byte	0xb
	.byte	0x52
	.4byte	0x7af
	.uleb128 0x7
	.4byte	.LASF1552
	.byte	0xb
	.byte	0x52
	.4byte	0x5f3
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1553
	.byte	0xb
	.byte	0x52
	.4byte	0x5f9
	.byte	0x8
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.4byte	0x703
	.uleb128 0xa
	.byte	0x10
	.byte	0xb
	.byte	0x5b
	.4byte	0x7d6
	.uleb128 0x7
	.4byte	.LASF1552
	.byte	0xb
	.byte	0x5b
	.4byte	0x549
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1553
	.byte	0xb
	.byte	0x5b
	.4byte	0x54f
	.byte	0x8
	.byte	0
	.uleb128 0xa
	.byte	0x10
	.byte	0xb
	.byte	0x5c
	.4byte	0x7f7
	.uleb128 0x7
	.4byte	.LASF1552
	.byte	0xb
	.byte	0x5c
	.4byte	0x549
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1553
	.byte	0xb
	.byte	0x5c
	.4byte	0x54f
	.byte	0x8
	.byte	0
	.uleb128 0x12
	.4byte	.LASF1631
	.byte	0xb
	.byte	0x6e
	.4byte	0x555
	.uleb128 0x12
	.4byte	.LASF1632
	.byte	0xb
	.byte	0x70
	.4byte	0x19b
	.uleb128 0xa
	.byte	0x8
	.byte	0xc
	.byte	0x21
	.4byte	0x822
	.uleb128 0x7
	.4byte	.LASF1548
	.byte	0xc
	.byte	0x21
	.4byte	0x847
	.byte	0
	.byte	0
	.uleb128 0x1c
	.string	"pgt"
	.byte	0x10
	.byte	0xc
	.byte	0x15
	.4byte	0x847
	.uleb128 0x8
	.string	"tbl"
	.byte	0xc
	.byte	0x16
	.4byte	0x345
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1547
	.byte	0xc
	.byte	0x21
	.4byte	0x80d
	.byte	0x8
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.4byte	0x822
	.uleb128 0x6
	.4byte	.LASF1633
	.byte	0x8
	.byte	0xc
	.byte	0x2d
	.4byte	0x866
	.uleb128 0x7
	.4byte	.LASF1543
	.byte	0xc
	.byte	0x2d
	.4byte	0x847
	.byte	0
	.byte	0
	.uleb128 0x6
	.4byte	.LASF1634
	.byte	0x24
	.byte	0xd
	.byte	0x36
	.4byte	0x8df
	.uleb128 0x7
	.4byte	.LASF1635
	.byte	0xd
	.byte	0x37
	.4byte	0x6d
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1636
	.byte	0xd
	.byte	0x38
	.4byte	0x6d
	.byte	0x4
	.uleb128 0x7
	.4byte	.LASF1637
	.byte	0xd
	.byte	0x39
	.4byte	0x6d
	.byte	0x8
	.uleb128 0x7
	.4byte	.LASF1638
	.byte	0xd
	.byte	0x3a
	.4byte	0x6d
	.byte	0xc
	.uleb128 0x7
	.4byte	.LASF1639
	.byte	0xd
	.byte	0x3b
	.4byte	0x6d
	.byte	0x10
	.uleb128 0x7
	.4byte	.LASF1640
	.byte	0xd
	.byte	0x3c
	.4byte	0x6d
	.byte	0x14
	.uleb128 0x7
	.4byte	.LASF1641
	.byte	0xd
	.byte	0x3d
	.4byte	0x6d
	.byte	0x18
	.uleb128 0x7
	.4byte	.LASF1642
	.byte	0xd
	.byte	0x3e
	.4byte	0x6d
	.byte	0x1c
	.uleb128 0x7
	.4byte	.LASF1643
	.byte	0xd
	.byte	0x3f
	.4byte	0x6d
	.byte	0x20
	.byte	0
	.uleb128 0x12
	.4byte	.LASF1634
	.byte	0xd
	.byte	0x41
	.4byte	0x866
	.uleb128 0xa
	.byte	0x10
	.byte	0xd
	.byte	0x44
	.4byte	0x90b
	.uleb128 0x7
	.4byte	.LASF1558
	.byte	0xd
	.byte	0x44
	.4byte	0x549
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1559
	.byte	0xd
	.byte	0x44
	.4byte	0x54f
	.byte	0x8
	.byte	0
	.uleb128 0x6
	.4byte	.LASF1644
	.byte	0x40
	.byte	0xd
	.byte	0x43
	.4byte	0x96c
	.uleb128 0x7
	.4byte	.LASF1645
	.byte	0xd
	.byte	0x44
	.4byte	0x8ea
	.byte	0
	.uleb128 0x8
	.string	"ctx"
	.byte	0xd
	.byte	0x45
	.4byte	0x5f3
	.byte	0x10
	.uleb128 0x7
	.4byte	.LASF1633
	.byte	0xd
	.byte	0x46
	.4byte	0x84d
	.byte	0x18
	.uleb128 0x7
	.4byte	.LASF1646
	.byte	0xd
	.byte	0x47
	.4byte	0x345
	.byte	0x20
	.uleb128 0x7
	.4byte	.LASF1647
	.byte	0xd
	.byte	0x48
	.4byte	0x656
	.byte	0x28
	.uleb128 0x7
	.4byte	.LASF1648
	.byte	0xd
	.byte	0x49
	.4byte	0x84
	.byte	0x30
	.uleb128 0x7
	.4byte	.LASF1649
	.byte	0xd
	.byte	0x4a
	.4byte	0xa1
	.byte	0x38
	.byte	0
	.uleb128 0xd
	.4byte	.LASF1650
	.2byte	0x220
	.byte	0xd
	.byte	0x4d
	.4byte	0x9a0
	.uleb128 0x8
	.string	"vfp"
	.byte	0xd
	.byte	0x4e
	.4byte	0x23b
	.byte	0
	.uleb128 0xe
	.4byte	.LASF1651
	.byte	0xd
	.byte	0x4f
	.4byte	0x14a
	.2byte	0x210
	.uleb128 0xe
	.4byte	.LASF1652
	.byte	0xd
	.byte	0x50
	.4byte	0x14a
	.2byte	0x211
	.byte	0
	.uleb128 0x6
	.4byte	.LASF1653
	.byte	0x40
	.byte	0xd
	.byte	0x60
	.4byte	0xa05
	.uleb128 0x8
	.string	"a0"
	.byte	0xd
	.byte	0x61
	.4byte	0x84
	.byte	0
	.uleb128 0x8
	.string	"a1"
	.byte	0xd
	.byte	0x62
	.4byte	0x84
	.byte	0x8
	.uleb128 0x8
	.string	"a2"
	.byte	0xd
	.byte	0x63
	.4byte	0x84
	.byte	0x10
	.uleb128 0x8
	.string	"a3"
	.byte	0xd
	.byte	0x64
	.4byte	0x84
	.byte	0x18
	.uleb128 0x8
	.string	"a4"
	.byte	0xd
	.byte	0x65
	.4byte	0x84
	.byte	0x20
	.uleb128 0x8
	.string	"a5"
	.byte	0xd
	.byte	0x66
	.4byte	0x84
	.byte	0x28
	.uleb128 0x8
	.string	"a6"
	.byte	0xd
	.byte	0x67
	.4byte	0x84
	.byte	0x30
	.uleb128 0x8
	.string	"a7"
	.byte	0xd
	.byte	0x68
	.4byte	0x84
	.byte	0x38
	.byte	0
	.uleb128 0x4
	.4byte	.LASF1654
	.byte	0xd
	.byte	0xd2
	.4byte	0xa10
	.uleb128 0x9
	.byte	0x8
	.4byte	0xa16
	.uleb128 0x1b
	.4byte	0xa21
	.uleb128 0x1a
	.4byte	0xa21
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.4byte	0x9a0
	.uleb128 0x4
	.4byte	.LASF1655
	.byte	0xd
	.byte	0xd3
	.4byte	0xa32
	.uleb128 0x9
	.byte	0x8
	.4byte	0xa38
	.uleb128 0x1d
	.uleb128 0x4
	.4byte	.LASF1656
	.byte	0xd
	.byte	0xd4
	.4byte	0xa44
	.uleb128 0x9
	.byte	0x8
	.4byte	0xa4a
	.uleb128 0x19
	.4byte	0x8f
	.4byte	0xa5e
	.uleb128 0x1a
	.4byte	0x8f
	.uleb128 0x1a
	.4byte	0x8f
	.byte	0
	.uleb128 0x12
	.4byte	.LASF1657
	.byte	0xe
	.byte	0x17
	.4byte	0x3b
	.uleb128 0xb
	.4byte	0x3d7
	.4byte	0xa74
	.uleb128 0x16
	.byte	0
	.uleb128 0x5
	.4byte	0xa69
	.uleb128 0x12
	.4byte	.LASF1658
	.byte	0xe
	.byte	0x18
	.4byte	0xa74
	.uleb128 0x6
	.4byte	.LASF1659
	.byte	0x18
	.byte	0xf
	.byte	0x11
	.4byte	0xac1
	.uleb128 0x7
	.4byte	.LASF1660
	.byte	0xf
	.byte	0x12
	.4byte	0xb20
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1661
	.byte	0xf
	.byte	0x13
	.4byte	0xb26
	.byte	0x8
	.uleb128 0x7
	.4byte	.LASF1662
	.byte	0xf
	.byte	0x14
	.4byte	0x6d
	.byte	0x10
	.uleb128 0x7
	.4byte	.LASF1576
	.byte	0xf
	.byte	0x15
	.4byte	0x6d
	.byte	0x14
	.byte	0
	.uleb128 0x6
	.4byte	.LASF1663
	.byte	0x30
	.byte	0xf
	.byte	0x19
	.4byte	0xb20
	.uleb128 0x7
	.4byte	.LASF1664
	.byte	0xf
	.byte	0x1a
	.4byte	0xb37
	.byte	0
	.uleb128 0x8
	.string	"lo"
	.byte	0xf
	.byte	0x1b
	.4byte	0xbc
	.byte	0x8
	.uleb128 0x8
	.string	"hi"
	.byte	0xf
	.byte	0x1c
	.4byte	0xbc
	.byte	0x10
	.uleb128 0x7
	.4byte	.LASF1613
	.byte	0xf
	.byte	0x1d
	.4byte	0x6d
	.byte	0x18
	.uleb128 0x7
	.4byte	.LASF1665
	.byte	0xf
	.byte	0x1e
	.4byte	0x49
	.byte	0x1c
	.uleb128 0x7
	.4byte	.LASF1666
	.byte	0xf
	.byte	0x1f
	.4byte	0x7d
	.byte	0x20
	.uleb128 0x7
	.4byte	.LASF1667
	.byte	0xf
	.byte	0x21
	.4byte	0xa1
	.byte	0x28
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.4byte	0xac1
	.uleb128 0x9
	.byte	0x8
	.4byte	0xa84
	.uleb128 0x4
	.4byte	.LASF1668
	.byte	0xf
	.byte	0x17
	.4byte	0xa84
	.uleb128 0x9
	.byte	0x8
	.4byte	0xb2c
	.uleb128 0x4
	.4byte	.LASF1669
	.byte	0xf
	.byte	0x24
	.4byte	0xac1
	.uleb128 0x12
	.4byte	.LASF1670
	.byte	0xf
	.byte	0x27
	.4byte	0xb3d
	.uleb128 0x12
	.4byte	.LASF1671
	.byte	0xf
	.byte	0x2a
	.4byte	0xb3d
	.uleb128 0x12
	.4byte	.LASF1672
	.byte	0xf
	.byte	0x2d
	.4byte	0xb3d
	.uleb128 0x12
	.4byte	.LASF1673
	.byte	0x10
	.byte	0xf2
	.4byte	0x8f
	.uleb128 0x12
	.4byte	.LASF1674
	.byte	0x10
	.byte	0xf3
	.4byte	0x8f
	.uleb128 0x1e
	.4byte	.LASF1675
	.byte	0x10
	.byte	0x10
	.2byte	0x103
	.4byte	0xba7
	.uleb128 0x1f
	.4byte	.LASF1676
	.byte	0x10
	.2byte	0x104
	.4byte	0x84
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF1677
	.byte	0x10
	.2byte	0x105
	.4byte	0x6d
	.byte	0x8
	.byte	0
	.uleb128 0x13
	.4byte	.LASF1679
	.byte	0x4
	.4byte	0x7d
	.byte	0x11
	.byte	0x12
	.4byte	0xbca
	.uleb128 0x14
	.4byte	.LASF1680
	.byte	0
	.uleb128 0x14
	.4byte	.LASF1681
	.byte	0x1
	.uleb128 0x14
	.4byte	.LASF1682
	.byte	0x2
	.byte	0
	.uleb128 0xd
	.4byte	.LASF1683
	.2byte	0x110
	.byte	0x11
	.byte	0x32
	.4byte	0xc04
	.uleb128 0x8
	.string	"sp"
	.byte	0x11
	.byte	0x33
	.4byte	0x84
	.byte	0
	.uleb128 0x8
	.string	"pc"
	.byte	0x11
	.byte	0x34
	.4byte	0x84
	.byte	0x8
	.uleb128 0x7
	.4byte	.LASF1684
	.byte	0x11
	.byte	0x35
	.4byte	0x84
	.byte	0x10
	.uleb128 0x8
	.string	"x"
	.byte	0x11
	.byte	0x36
	.4byte	0xc04
	.byte	0x18
	.byte	0
	.uleb128 0xb
	.4byte	0x84
	.4byte	0xc14
	.uleb128 0xc
	.4byte	0xc7
	.byte	0x1e
	.byte	0
	.uleb128 0xd
	.4byte	.LASF1685
	.2byte	0x440
	.byte	0x11
	.byte	0x43
	.4byte	0xc6b
	.uleb128 0x7
	.4byte	.LASF1686
	.byte	0x11
	.byte	0x44
	.4byte	0x14a
	.byte	0
	.uleb128 0x7
	.4byte	.LASF1687
	.byte	0x11
	.byte	0x45
	.4byte	0x14a
	.byte	0x1
	.uleb128 0x7
	.4byte	.LASF1688
	.byte	0x11
	.byte	0x46
	.4byte	0x14a
	.byte	0x2
	.uleb128 0x8
	.string	"ns"
	.byte	0x11
	.byte	0x47
	.4byte	0x23b
	.byte	0x10
	.uleb128 0x20
	.string	"sec"
	.byte	0x11
	.byte	0x48
	.4byte	0x23b
	.2byte	0x220
	.uleb128 0xe
	.4byte	.LASF1689
	.byte	0x11
	.byte	0x49
	.4byte	0xc6b
	.2byte	0x430
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.4byte	0x96c
	.uleb128 0xd
	.4byte	.LASF1690
	.2byte	0x600
	.byte	0x11
	.byte	0x4e
	.4byte	0xd34
	.uleb128 0x7
	.4byte	.LASF1691
	.byte	0x11
	.byte	0x4f
	.4byte	0xbca
	.byte	0
	.uleb128 0xe
	.4byte	.LASF1555
	.byte	0x11
	.byte	0x50
	.4byte	0xba7
	.2byte	0x110
	.uleb128 0xe
	.4byte	.LASF1692
	.byte	0x11
	.byte	0x51
	.4byte	0xb1
	.2byte	0x118
	.uleb128 0xe
	.4byte	.LASF1693
	.byte	0x11
	.byte	0x52
	.4byte	0x6d
	.2byte	0x120
	.uleb128 0xe
	.4byte	.LASF1613
	.byte	0x11
	.byte	0x53
	.4byte	0x6d
	.2byte	0x124
	.uleb128 0xe
	.4byte	.LASF1676
	.byte	0x11
	.byte	0x54
	.4byte	0xb7f
	.2byte	0x128
	.uleb128 0xe
	.4byte	.LASF1694
	.byte	0x11
	.byte	0x55
	.4byte	0x14a
	.2byte	0x138
	.uleb128 0xe
	.4byte	.LASF1695
	.byte	0x11
	.byte	0x57
	.4byte	0xb1
	.2byte	0x140
	.uleb128 0xe
	.4byte	.LASF1561
	.byte	0x11
	.byte	0x5a
	.4byte	0xc14
	.2byte	0x150
	.uleb128 0xe
	.4byte	.LASF1696
	.byte	0x11
	.byte	0x5c
	.4byte	0x345
	.2byte	0x590
	.uleb128 0xe
	.4byte	.LASF1697
	.byte	0x11
	.byte	0x5d
	.4byte	0x84
	.2byte	0x598
	.uleb128 0xe
	.4byte	.LASF1698
	.byte	0x11
	.byte	0x5e
	.4byte	0x656
	.2byte	0x5a0
	.uleb128 0xe
	.4byte	.LASF1699
	.byte	0x11
	.byte	0x5f
	.4byte	0x1ef
	.2byte	0x5a8
	.uleb128 0x20
	.string	"tsd"
	.byte	0x11
	.byte	0x60
	.4byte	0x90b
	.2byte	0x5b8
	.byte	0
	.uleb128 0x12
	.4byte	.LASF1700
	.byte	0x11
	.byte	0x7c
	.4byte	0x44d
	.uleb128 0x12
	.4byte	.LASF1701
	.byte	0x11
	.byte	0x7d
	.4byte	0x78
	.uleb128 0xb
	.4byte	0xc71
	.4byte	0xd55
	.uleb128 0x16
	.byte	0
	.uleb128 0x12
	.4byte	.LASF1702
	.byte	0x11
	.byte	0x7e
	.4byte	0xd4a
	.uleb128 0x12
	.4byte	.LASF1703
	.byte	0x11
	.byte	0x7f
	.4byte	0xa05
	.uleb128 0x12
	.4byte	.LASF1704
	.byte	0x11
	.byte	0x80
	.4byte	0xa27
	.uleb128 0x12
	.4byte	.LASF1705
	.byte	0x11
	.byte	0x81
	.4byte	0xa39
	.uleb128 0x12
	.4byte	.LASF1706
	.byte	0x11
	.byte	0x82
	.4byte	0xa39
	.uleb128 0x12
	.4byte	.LASF1707
	.byte	0x11
	.byte	0x83
	.4byte	0xa39
	.uleb128 0x12
	.4byte	.LASF1708
	.byte	0x11
	.byte	0x84
	.4byte	0xa39
	.uleb128 0x12
	.4byte	.LASF1709
	.byte	0x11
	.byte	0x85
	.4byte	0xa39
	.uleb128 0x12
	.4byte	.LASF1710
	.byte	0x11
	.byte	0x86
	.4byte	0xa39
	.uleb128 0x12
	.4byte	.LASF1711
	.byte	0x11
	.byte	0x8f
	.4byte	0x42
	.uleb128 0x21
	.4byte	.LASF1715
	.byte	0x1
	.byte	0xd
	.8byte	.LFB64
	.8byte	.LFE64-.LFB64
	.uleb128 0x1
	.byte	0x9c
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.uleb128 0x2119
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0x5
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x17
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x26
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x15
	.byte	0
	.uleb128 0x27
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x2c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x8
	.byte	0
	.2byte	0
	.2byte	0
	.8byte	.LFB64
	.8byte	.LFE64-.LFB64
	.8byte	0
	.8byte	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.8byte	.LFB64
	.8byte	.LFE64
	.8byte	0
	.8byte	0
	.section	.debug_macro,"",@progbits
.Ldebug_macro0:
	.2byte	0x4
	.byte	0x2
	.4byte	.Ldebug_line0
	.byte	0x7
	.4byte	.Ldebug_macro1
	.byte	0x3
	.uleb128 0
	.uleb128 0x1
	.file 18 "./out/arm/include/generated/conf.h"
	.byte	0x3
	.uleb128 0
	.uleb128 0x12
	.byte	0x7
	.4byte	.Ldebug_macro2
	.byte	0x4
	.file 19 "core/include/gen-asm-defines.h"
	.byte	0x3
	.uleb128 0x6
	.uleb128 0x13
	.byte	0x7
	.4byte	.Ldebug_macro3
	.byte	0x4
	.byte	0x3
	.uleb128 0x7
	.uleb128 0xd
	.byte	0x5
	.uleb128 0x8
	.4byte	.LASF379
	.file 20 "core/arch/arm/include/arm.h"
	.byte	0x3
	.uleb128 0xb
	.uleb128 0x14
	.byte	0x5
	.uleb128 0x6
	.4byte	.LASF380
	.file 21 "lib/libutils/ext/include/util.h"
	.byte	0x3
	.uleb128 0x8
	.uleb128 0x15
	.byte	0x5
	.uleb128 0x6
	.4byte	.LASF381
	.file 22 "lib/libutils/ext/include/compiler.h"
	.byte	0x3
	.uleb128 0x8
	.uleb128 0x16
	.byte	0x7
	.4byte	.Ldebug_macro4
	.byte	0x4
	.byte	0x3
	.uleb128 0x9
	.uleb128 0x2
	.file 23 "lib/libutils/isoc/include/limits.h"
	.byte	0x3
	.uleb128 0x6
	.uleb128 0x17
	.byte	0x7
	.4byte	.Ldebug_macro5
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro6
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro7
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro8
	.file 24 "core/arch/arm/include/arm64.h"
	.byte	0x3
	.uleb128 0x56
	.uleb128 0x18
	.byte	0x5
	.uleb128 0x6
	.4byte	.LASF579
	.file 25 "lib/libutils/isoc/include/sys/cdefs.h"
	.byte	0x3
	.uleb128 0x8
	.uleb128 0x19
	.byte	0x7
	.4byte	.Ldebug_macro9
	.byte	0x4
	.byte	0x3
	.uleb128 0x9
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro10
	.byte	0x4
	.byte	0x4
	.byte	0x3
	.uleb128 0xc
	.uleb128 0x4
	.byte	0x5
	.uleb128 0x6
	.4byte	.LASF722
	.byte	0x3
	.uleb128 0x9
	.uleb128 0x3
	.byte	0x7
	.4byte	.Ldebug_macro11
	.byte	0x4
	.file 26 "lib/libutils/isoc/include/inttypes.h"
	.byte	0x3
	.uleb128 0xa
	.uleb128 0x1a
	.byte	0x5
	.uleb128 0x6
	.4byte	.LASF775
	.byte	0x3
	.uleb128 0x8
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro12
	.byte	0x4
	.file 27 "/home/zt233/Documents/test-tz/toolchains/aarch64/lib/gcc/aarch64-linux-gnu/6.2.1/include/stdbool.h"
	.byte	0x3
	.uleb128 0xb
	.uleb128 0x1b
	.byte	0x7
	.4byte	.Ldebug_macro13
	.byte	0x4
	.file 28 "lib/libutils/isoc/include/unistd.h"
	.byte	0x3
	.uleb128 0xc
	.uleb128 0x1c
	.byte	0x5
	.uleb128 0x6
	.4byte	.LASF813
	.byte	0x3
	.uleb128 0x8
	.uleb128 0x2
	.byte	0x4
	.byte	0x3
	.uleb128 0x9
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.uleb128 0xb
	.4byte	.LASF814
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro14
	.byte	0x4
	.file 29 "core/include/optee_msg.h"
	.byte	0x3
	.uleb128 0xe
	.uleb128 0x1d
	.byte	0x7
	.4byte	.Ldebug_macro15
	.byte	0x4
	.byte	0x3
	.uleb128 0xf
	.uleb128 0x6
	.byte	0x5
	.uleb128 0x6
	.4byte	.LASF876
	.file 30 "lib/libutils/isoc/include/sys/queue.h"
	.byte	0x3
	.uleb128 0x9
	.uleb128 0x1e
	.byte	0x7
	.4byte	.Ldebug_macro16
	.byte	0x4
	.byte	0x3
	.uleb128 0xa
	.uleb128 0x5
	.byte	0x7
	.4byte	.Ldebug_macro17
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro18
	.byte	0x4
	.byte	0x3
	.uleb128 0x10
	.uleb128 0x7
	.byte	0x7
	.4byte	.Ldebug_macro19
	.byte	0x4
	.byte	0x3
	.uleb128 0x11
	.uleb128 0xc
	.byte	0x7
	.4byte	.Ldebug_macro20
	.byte	0x3
	.uleb128 0x10
	.uleb128 0xb
	.byte	0x5
	.uleb128 0x8
	.4byte	.LASF992
	.byte	0x3
	.uleb128 0xc
	.uleb128 0x8
	.byte	0x5
	.uleb128 0x8
	.4byte	.LASF993
	.byte	0x3
	.uleb128 0xb
	.uleb128 0x2
	.byte	0x4
	.byte	0x3
	.uleb128 0xd
	.uleb128 0x3
	.byte	0x4
	.file 31 "lib/libutee/include/tee_api_defines.h"
	.byte	0x3
	.uleb128 0xe
	.uleb128 0x1f
	.byte	0x7
	.4byte	.Ldebug_macro21
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro22
	.byte	0x4
	.file 32 "lib/libutee/include/utee_types.h"
	.byte	0x3
	.uleb128 0xd
	.uleb128 0x20
	.byte	0x5
	.uleb128 0x7
	.4byte	.LASF1340
	.byte	0x4
	.file 33 "core/include/kernel/tee_common.h"
	.byte	0x3
	.uleb128 0xe
	.uleb128 0x21
	.byte	0x5
	.uleb128 0x6
	.4byte	.LASF1341
	.file 34 "lib/libutils/isoc/include/stdlib.h"
	.byte	0x3
	.uleb128 0x8
	.uleb128 0x22
	.byte	0x5
	.uleb128 0xc
	.4byte	.LASF1342
	.byte	0x3
	.uleb128 0xf
	.uleb128 0x3
	.byte	0x4
	.byte	0x3
	.uleb128 0x10
	.uleb128 0xa
	.byte	0x5
	.uleb128 0x6
	.4byte	.LASF1343
	.byte	0x3
	.uleb128 0x8
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro23
	.byte	0x4
	.byte	0x5
	.uleb128 0x1a
	.4byte	.LASF1346
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro24
	.byte	0x4
	.byte	0x3
	.uleb128 0x11
	.uleb128 0x9
	.byte	0x7
	.4byte	.Ldebug_macro25
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro26
	.byte	0x4
	.byte	0x5
	.uleb128 0x2a
	.4byte	.LASF1374
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro27
	.byte	0x4
	.file 35 "core/arch/arm/include/sm/pm.h"
	.byte	0x3
	.uleb128 0x8
	.uleb128 0x23
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF1382
	.byte	0x3
	.uleb128 0x1f
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.file 36 "core/arch/arm/include/sm/sm.h"
	.byte	0x3
	.uleb128 0x9
	.uleb128 0x24
	.byte	0x7
	.4byte	.Ldebug_macro28
	.byte	0x4
	.byte	0x3
	.uleb128 0xb
	.uleb128 0x11
	.byte	0x5
	.uleb128 0x8
	.4byte	.LASF1385
	.byte	0x3
	.uleb128 0xc
	.uleb128 0x10
	.byte	0x5
	.uleb128 0x7
	.4byte	.LASF1386
	.file 37 "lib/libutils/isoc/include/assert.h"
	.byte	0x3
	.uleb128 0xa
	.uleb128 0x25
	.byte	0x5
	.uleb128 0x6
	.4byte	.LASF1387
	.byte	0x3
	.uleb128 0x9
	.uleb128 0xe
	.byte	0x5
	.uleb128 0x6
	.4byte	.LASF1388
	.byte	0x3
	.uleb128 0x9
	.uleb128 0x3
	.byte	0x4
	.file 38 "lib/libutils/ext/include/trace_levels.h"
	.byte	0x3
	.uleb128 0xb
	.uleb128 0x26
	.byte	0x7
	.4byte	.Ldebug_macro29
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro30
	.file 39 "core/arch/arm/include/kernel/unwind.h"
	.byte	0x3
	.uleb128 0x95
	.uleb128 0x27
	.byte	0x7
	.4byte	.Ldebug_macro31
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro32
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro33
	.byte	0x4
	.file 40 "core/arch/arm/include/kernel/user_ta.h"
	.byte	0x3
	.uleb128 0xc
	.uleb128 0x28
	.byte	0x5
	.uleb128 0x6
	.4byte	.LASF1426
	.byte	0x3
	.uleb128 0xb
	.uleb128 0xf
	.byte	0x7
	.4byte	.Ldebug_macro34
	.byte	0x4
	.byte	0x4
	.file 41 "core/include/mm/tee_mmu_types.h"
	.byte	0x3
	.uleb128 0xd
	.uleb128 0x29
	.byte	0x5
	.uleb128 0x6
	.4byte	.LASF1430
	.byte	0x3
	.uleb128 0x8
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro35
	.byte	0x4
	.file 42 "core/arch/arm/plat-vexpress/./platform_config.h"
	.byte	0x3
	.uleb128 0x12
	.uleb128 0x2a
	.byte	0x5
	.uleb128 0x7
	.4byte	.LASF1463
	.file 43 "core/arch/arm/include/mm/generic_ram_layout.h"
	.byte	0x3
	.uleb128 0x9
	.uleb128 0x2b
	.byte	0x7
	.4byte	.Ldebug_macro36
	.byte	0x4
	.byte	0x3
	.uleb128 0xa
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro37
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro38
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro39
	.byte	0x4
	.byte	0x4
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.0.ebd604b5708aef918f382c8766ecb2eb,comdat
.Ldebug_macro1:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0
	.4byte	.LASF0
	.byte	0x5
	.uleb128 0
	.4byte	.LASF1
	.byte	0x5
	.uleb128 0
	.4byte	.LASF2
	.byte	0x5
	.uleb128 0
	.4byte	.LASF3
	.byte	0x5
	.uleb128 0
	.4byte	.LASF4
	.byte	0x5
	.uleb128 0
	.4byte	.LASF5
	.byte	0x5
	.uleb128 0
	.4byte	.LASF6
	.byte	0x5
	.uleb128 0
	.4byte	.LASF7
	.byte	0x5
	.uleb128 0
	.4byte	.LASF8
	.byte	0x5
	.uleb128 0
	.4byte	.LASF9
	.byte	0x5
	.uleb128 0
	.4byte	.LASF10
	.byte	0x5
	.uleb128 0
	.4byte	.LASF11
	.byte	0x5
	.uleb128 0
	.4byte	.LASF12
	.byte	0x5
	.uleb128 0
	.4byte	.LASF13
	.byte	0x5
	.uleb128 0
	.4byte	.LASF14
	.byte	0x5
	.uleb128 0
	.4byte	.LASF15
	.byte	0x5
	.uleb128 0
	.4byte	.LASF16
	.byte	0x5
	.uleb128 0
	.4byte	.LASF17
	.byte	0x5
	.uleb128 0
	.4byte	.LASF18
	.byte	0x5
	.uleb128 0
	.4byte	.LASF19
	.byte	0x5
	.uleb128 0
	.4byte	.LASF20
	.byte	0x5
	.uleb128 0
	.4byte	.LASF21
	.byte	0x5
	.uleb128 0
	.4byte	.LASF22
	.byte	0x5
	.uleb128 0
	.4byte	.LASF23
	.byte	0x5
	.uleb128 0
	.4byte	.LASF24
	.byte	0x5
	.uleb128 0
	.4byte	.LASF25
	.byte	0x5
	.uleb128 0
	.4byte	.LASF26
	.byte	0x5
	.uleb128 0
	.4byte	.LASF27
	.byte	0x5
	.uleb128 0
	.4byte	.LASF28
	.byte	0x5
	.uleb128 0
	.4byte	.LASF29
	.byte	0x5
	.uleb128 0
	.4byte	.LASF30
	.byte	0x5
	.uleb128 0
	.4byte	.LASF31
	.byte	0x5
	.uleb128 0
	.4byte	.LASF32
	.byte	0x5
	.uleb128 0
	.4byte	.LASF33
	.byte	0x5
	.uleb128 0
	.4byte	.LASF34
	.byte	0x5
	.uleb128 0
	.4byte	.LASF35
	.byte	0x5
	.uleb128 0
	.4byte	.LASF36
	.byte	0x5
	.uleb128 0
	.4byte	.LASF37
	.byte	0x5
	.uleb128 0
	.4byte	.LASF38
	.byte	0x5
	.uleb128 0
	.4byte	.LASF39
	.byte	0x5
	.uleb128 0
	.4byte	.LASF40
	.byte	0x5
	.uleb128 0
	.4byte	.LASF41
	.byte	0x5
	.uleb128 0
	.4byte	.LASF42
	.byte	0x5
	.uleb128 0
	.4byte	.LASF43
	.byte	0x5
	.uleb128 0
	.4byte	.LASF44
	.byte	0x5
	.uleb128 0
	.4byte	.LASF45
	.byte	0x5
	.uleb128 0
	.4byte	.LASF46
	.byte	0x5
	.uleb128 0
	.4byte	.LASF47
	.byte	0x5
	.uleb128 0
	.4byte	.LASF48
	.byte	0x5
	.uleb128 0
	.4byte	.LASF49
	.byte	0x5
	.uleb128 0
	.4byte	.LASF50
	.byte	0x5
	.uleb128 0
	.4byte	.LASF51
	.byte	0x5
	.uleb128 0
	.4byte	.LASF52
	.byte	0x5
	.uleb128 0
	.4byte	.LASF53
	.byte	0x5
	.uleb128 0
	.4byte	.LASF54
	.byte	0x5
	.uleb128 0
	.4byte	.LASF55
	.byte	0x5
	.uleb128 0
	.4byte	.LASF56
	.byte	0x5
	.uleb128 0
	.4byte	.LASF57
	.byte	0x5
	.uleb128 0
	.4byte	.LASF58
	.byte	0x5
	.uleb128 0
	.4byte	.LASF59
	.byte	0x5
	.uleb128 0
	.4byte	.LASF60
	.byte	0x5
	.uleb128 0
	.4byte	.LASF61
	.byte	0x5
	.uleb128 0
	.4byte	.LASF62
	.byte	0x5
	.uleb128 0
	.4byte	.LASF63
	.byte	0x5
	.uleb128 0
	.4byte	.LASF64
	.byte	0x5
	.uleb128 0
	.4byte	.LASF65
	.byte	0x5
	.uleb128 0
	.4byte	.LASF66
	.byte	0x5
	.uleb128 0
	.4byte	.LASF67
	.byte	0x5
	.uleb128 0
	.4byte	.LASF68
	.byte	0x5
	.uleb128 0
	.4byte	.LASF69
	.byte	0x5
	.uleb128 0
	.4byte	.LASF70
	.byte	0x5
	.uleb128 0
	.4byte	.LASF71
	.byte	0x5
	.uleb128 0
	.4byte	.LASF72
	.byte	0x5
	.uleb128 0
	.4byte	.LASF73
	.byte	0x5
	.uleb128 0
	.4byte	.LASF74
	.byte	0x5
	.uleb128 0
	.4byte	.LASF75
	.byte	0x5
	.uleb128 0
	.4byte	.LASF76
	.byte	0x5
	.uleb128 0
	.4byte	.LASF77
	.byte	0x5
	.uleb128 0
	.4byte	.LASF78
	.byte	0x5
	.uleb128 0
	.4byte	.LASF79
	.byte	0x5
	.uleb128 0
	.4byte	.LASF80
	.byte	0x5
	.uleb128 0
	.4byte	.LASF81
	.byte	0x5
	.uleb128 0
	.4byte	.LASF82
	.byte	0x5
	.uleb128 0
	.4byte	.LASF83
	.byte	0x5
	.uleb128 0
	.4byte	.LASF84
	.byte	0x5
	.uleb128 0
	.4byte	.LASF85
	.byte	0x5
	.uleb128 0
	.4byte	.LASF86
	.byte	0x5
	.uleb128 0
	.4byte	.LASF87
	.byte	0x5
	.uleb128 0
	.4byte	.LASF88
	.byte	0x5
	.uleb128 0
	.4byte	.LASF89
	.byte	0x5
	.uleb128 0
	.4byte	.LASF90
	.byte	0x5
	.uleb128 0
	.4byte	.LASF91
	.byte	0x5
	.uleb128 0
	.4byte	.LASF92
	.byte	0x5
	.uleb128 0
	.4byte	.LASF93
	.byte	0x5
	.uleb128 0
	.4byte	.LASF94
	.byte	0x5
	.uleb128 0
	.4byte	.LASF95
	.byte	0x5
	.uleb128 0
	.4byte	.LASF96
	.byte	0x5
	.uleb128 0
	.4byte	.LASF97
	.byte	0x5
	.uleb128 0
	.4byte	.LASF98
	.byte	0x5
	.uleb128 0
	.4byte	.LASF99
	.byte	0x5
	.uleb128 0
	.4byte	.LASF100
	.byte	0x5
	.uleb128 0
	.4byte	.LASF101
	.byte	0x5
	.uleb128 0
	.4byte	.LASF102
	.byte	0x5
	.uleb128 0
	.4byte	.LASF103
	.byte	0x5
	.uleb128 0
	.4byte	.LASF104
	.byte	0x5
	.uleb128 0
	.4byte	.LASF105
	.byte	0x5
	.uleb128 0
	.4byte	.LASF106
	.byte	0x5
	.uleb128 0
	.4byte	.LASF107
	.byte	0x5
	.uleb128 0
	.4byte	.LASF108
	.byte	0x5
	.uleb128 0
	.4byte	.LASF109
	.byte	0x5
	.uleb128 0
	.4byte	.LASF110
	.byte	0x5
	.uleb128 0
	.4byte	.LASF111
	.byte	0x5
	.uleb128 0
	.4byte	.LASF112
	.byte	0x5
	.uleb128 0
	.4byte	.LASF113
	.byte	0x5
	.uleb128 0
	.4byte	.LASF114
	.byte	0x5
	.uleb128 0
	.4byte	.LASF115
	.byte	0x5
	.uleb128 0
	.4byte	.LASF116
	.byte	0x5
	.uleb128 0
	.4byte	.LASF117
	.byte	0x5
	.uleb128 0
	.4byte	.LASF118
	.byte	0x5
	.uleb128 0
	.4byte	.LASF119
	.byte	0x5
	.uleb128 0
	.4byte	.LASF120
	.byte	0x5
	.uleb128 0
	.4byte	.LASF121
	.byte	0x5
	.uleb128 0
	.4byte	.LASF122
	.byte	0x5
	.uleb128 0
	.4byte	.LASF123
	.byte	0x5
	.uleb128 0
	.4byte	.LASF124
	.byte	0x5
	.uleb128 0
	.4byte	.LASF125
	.byte	0x5
	.uleb128 0
	.4byte	.LASF126
	.byte	0x5
	.uleb128 0
	.4byte	.LASF127
	.byte	0x5
	.uleb128 0
	.4byte	.LASF128
	.byte	0x5
	.uleb128 0
	.4byte	.LASF129
	.byte	0x5
	.uleb128 0
	.4byte	.LASF130
	.byte	0x5
	.uleb128 0
	.4byte	.LASF131
	.byte	0x5
	.uleb128 0
	.4byte	.LASF132
	.byte	0x5
	.uleb128 0
	.4byte	.LASF133
	.byte	0x5
	.uleb128 0
	.4byte	.LASF134
	.byte	0x5
	.uleb128 0
	.4byte	.LASF135
	.byte	0x5
	.uleb128 0
	.4byte	.LASF136
	.byte	0x5
	.uleb128 0
	.4byte	.LASF137
	.byte	0x5
	.uleb128 0
	.4byte	.LASF138
	.byte	0x5
	.uleb128 0
	.4byte	.LASF139
	.byte	0x5
	.uleb128 0
	.4byte	.LASF140
	.byte	0x5
	.uleb128 0
	.4byte	.LASF141
	.byte	0x5
	.uleb128 0
	.4byte	.LASF142
	.byte	0x5
	.uleb128 0
	.4byte	.LASF143
	.byte	0x5
	.uleb128 0
	.4byte	.LASF144
	.byte	0x5
	.uleb128 0
	.4byte	.LASF145
	.byte	0x5
	.uleb128 0
	.4byte	.LASF146
	.byte	0x5
	.uleb128 0
	.4byte	.LASF147
	.byte	0x5
	.uleb128 0
	.4byte	.LASF148
	.byte	0x5
	.uleb128 0
	.4byte	.LASF149
	.byte	0x5
	.uleb128 0
	.4byte	.LASF150
	.byte	0x5
	.uleb128 0
	.4byte	.LASF151
	.byte	0x5
	.uleb128 0
	.4byte	.LASF152
	.byte	0x5
	.uleb128 0
	.4byte	.LASF153
	.byte	0x5
	.uleb128 0
	.4byte	.LASF154
	.byte	0x5
	.uleb128 0
	.4byte	.LASF155
	.byte	0x5
	.uleb128 0
	.4byte	.LASF156
	.byte	0x5
	.uleb128 0
	.4byte	.LASF157
	.byte	0x5
	.uleb128 0
	.4byte	.LASF158
	.byte	0x5
	.uleb128 0
	.4byte	.LASF159
	.byte	0x5
	.uleb128 0
	.4byte	.LASF160
	.byte	0x5
	.uleb128 0
	.4byte	.LASF161
	.byte	0x5
	.uleb128 0
	.4byte	.LASF162
	.byte	0x5
	.uleb128 0
	.4byte	.LASF163
	.byte	0x5
	.uleb128 0
	.4byte	.LASF164
	.byte	0x5
	.uleb128 0
	.4byte	.LASF165
	.byte	0x5
	.uleb128 0
	.4byte	.LASF166
	.byte	0x5
	.uleb128 0
	.4byte	.LASF167
	.byte	0x5
	.uleb128 0
	.4byte	.LASF168
	.byte	0x5
	.uleb128 0
	.4byte	.LASF169
	.byte	0x5
	.uleb128 0
	.4byte	.LASF170
	.byte	0x5
	.uleb128 0
	.4byte	.LASF171
	.byte	0x5
	.uleb128 0
	.4byte	.LASF172
	.byte	0x5
	.uleb128 0
	.4byte	.LASF173
	.byte	0x5
	.uleb128 0
	.4byte	.LASF174
	.byte	0x5
	.uleb128 0
	.4byte	.LASF175
	.byte	0x5
	.uleb128 0
	.4byte	.LASF176
	.byte	0x5
	.uleb128 0
	.4byte	.LASF177
	.byte	0x5
	.uleb128 0
	.4byte	.LASF178
	.byte	0x5
	.uleb128 0
	.4byte	.LASF179
	.byte	0x5
	.uleb128 0
	.4byte	.LASF180
	.byte	0x5
	.uleb128 0
	.4byte	.LASF181
	.byte	0x5
	.uleb128 0
	.4byte	.LASF182
	.byte	0x5
	.uleb128 0
	.4byte	.LASF183
	.byte	0x5
	.uleb128 0
	.4byte	.LASF184
	.byte	0x5
	.uleb128 0
	.4byte	.LASF185
	.byte	0x5
	.uleb128 0
	.4byte	.LASF186
	.byte	0x5
	.uleb128 0
	.4byte	.LASF187
	.byte	0x5
	.uleb128 0
	.4byte	.LASF188
	.byte	0x5
	.uleb128 0
	.4byte	.LASF189
	.byte	0x5
	.uleb128 0
	.4byte	.LASF190
	.byte	0x5
	.uleb128 0
	.4byte	.LASF191
	.byte	0x5
	.uleb128 0
	.4byte	.LASF192
	.byte	0x5
	.uleb128 0
	.4byte	.LASF193
	.byte	0x5
	.uleb128 0
	.4byte	.LASF194
	.byte	0x5
	.uleb128 0
	.4byte	.LASF195
	.byte	0x5
	.uleb128 0
	.4byte	.LASF196
	.byte	0x5
	.uleb128 0
	.4byte	.LASF197
	.byte	0x5
	.uleb128 0
	.4byte	.LASF198
	.byte	0x5
	.uleb128 0
	.4byte	.LASF199
	.byte	0x5
	.uleb128 0
	.4byte	.LASF200
	.byte	0x5
	.uleb128 0
	.4byte	.LASF201
	.byte	0x5
	.uleb128 0
	.4byte	.LASF202
	.byte	0x5
	.uleb128 0
	.4byte	.LASF203
	.byte	0x5
	.uleb128 0
	.4byte	.LASF204
	.byte	0x5
	.uleb128 0
	.4byte	.LASF205
	.byte	0x5
	.uleb128 0
	.4byte	.LASF206
	.byte	0x5
	.uleb128 0
	.4byte	.LASF207
	.byte	0x5
	.uleb128 0
	.4byte	.LASF208
	.byte	0x5
	.uleb128 0
	.4byte	.LASF209
	.byte	0x5
	.uleb128 0
	.4byte	.LASF210
	.byte	0x5
	.uleb128 0
	.4byte	.LASF211
	.byte	0x5
	.uleb128 0
	.4byte	.LASF212
	.byte	0x5
	.uleb128 0
	.4byte	.LASF213
	.byte	0x5
	.uleb128 0
	.4byte	.LASF214
	.byte	0x5
	.uleb128 0
	.4byte	.LASF215
	.byte	0x5
	.uleb128 0
	.4byte	.LASF216
	.byte	0x5
	.uleb128 0
	.4byte	.LASF217
	.byte	0x5
	.uleb128 0
	.4byte	.LASF218
	.byte	0x5
	.uleb128 0
	.4byte	.LASF219
	.byte	0x5
	.uleb128 0
	.4byte	.LASF220
	.byte	0x5
	.uleb128 0
	.4byte	.LASF221
	.byte	0x5
	.uleb128 0
	.4byte	.LASF222
	.byte	0x5
	.uleb128 0
	.4byte	.LASF223
	.byte	0x5
	.uleb128 0
	.4byte	.LASF224
	.byte	0x5
	.uleb128 0
	.4byte	.LASF225
	.byte	0x5
	.uleb128 0
	.4byte	.LASF226
	.byte	0x5
	.uleb128 0
	.4byte	.LASF227
	.byte	0x5
	.uleb128 0
	.4byte	.LASF228
	.byte	0x5
	.uleb128 0
	.4byte	.LASF229
	.byte	0x5
	.uleb128 0
	.4byte	.LASF230
	.byte	0x5
	.uleb128 0
	.4byte	.LASF231
	.byte	0x6
	.uleb128 0
	.4byte	.LASF232
	.byte	0x5
	.uleb128 0
	.4byte	.LASF233
	.byte	0x5
	.uleb128 0
	.4byte	.LASF234
	.byte	0x6
	.uleb128 0
	.4byte	.LASF235
	.byte	0x6
	.uleb128 0
	.4byte	.LASF236
	.byte	0x5
	.uleb128 0
	.4byte	.LASF237
	.byte	0x6
	.uleb128 0
	.4byte	.LASF238
	.byte	0x6
	.uleb128 0
	.4byte	.LASF239
	.byte	0x6
	.uleb128 0
	.4byte	.LASF240
	.byte	0x6
	.uleb128 0
	.4byte	.LASF241
	.byte	0x6
	.uleb128 0
	.4byte	.LASF242
	.byte	0x6
	.uleb128 0
	.4byte	.LASF243
	.byte	0x6
	.uleb128 0
	.4byte	.LASF244
	.byte	0x6
	.uleb128 0
	.4byte	.LASF245
	.byte	0x6
	.uleb128 0
	.4byte	.LASF246
	.byte	0x6
	.uleb128 0
	.4byte	.LASF247
	.byte	0x5
	.uleb128 0
	.4byte	.LASF248
	.byte	0x6
	.uleb128 0
	.4byte	.LASF249
	.byte	0x6
	.uleb128 0
	.4byte	.LASF250
	.byte	0x6
	.uleb128 0
	.4byte	.LASF251
	.byte	0x6
	.uleb128 0
	.4byte	.LASF252
	.byte	0x5
	.uleb128 0
	.4byte	.LASF253
	.byte	0x5
	.uleb128 0
	.4byte	.LASF254
	.byte	0x5
	.uleb128 0
	.4byte	.LASF255
	.byte	0x5
	.uleb128 0
	.4byte	.LASF256
	.byte	0x5
	.uleb128 0
	.4byte	.LASF257
	.byte	0x5
	.uleb128 0
	.4byte	.LASF258
	.byte	0x5
	.uleb128 0
	.4byte	.LASF259
	.byte	0x5
	.uleb128 0
	.4byte	.LASF260
	.byte	0x5
	.uleb128 0
	.4byte	.LASF261
	.byte	0x5
	.uleb128 0
	.4byte	.LASF262
	.byte	0x5
	.uleb128 0
	.4byte	.LASF21
	.byte	0x5
	.uleb128 0
	.4byte	.LASF263
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.conf.h.2.8c52b60b1f07953d60c6eef1ea8b7a5b,comdat
.Ldebug_macro2:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x2
	.4byte	.LASF264
	.byte	0x5
	.uleb128 0x3
	.4byte	.LASF265
	.byte	0x5
	.uleb128 0x4
	.4byte	.LASF266
	.byte	0x5
	.uleb128 0x5
	.4byte	.LASF267
	.byte	0x5
	.uleb128 0x7
	.4byte	.LASF268
	.byte	0x5
	.uleb128 0x8
	.4byte	.LASF269
	.byte	0x5
	.uleb128 0x9
	.4byte	.LASF270
	.byte	0x5
	.uleb128 0xc
	.4byte	.LASF271
	.byte	0x5
	.uleb128 0xf
	.4byte	.LASF272
	.byte	0x5
	.uleb128 0x10
	.4byte	.LASF273
	.byte	0x5
	.uleb128 0x11
	.4byte	.LASF274
	.byte	0x5
	.uleb128 0x12
	.4byte	.LASF275
	.byte	0x5
	.uleb128 0x13
	.4byte	.LASF276
	.byte	0x5
	.uleb128 0x14
	.4byte	.LASF277
	.byte	0x5
	.uleb128 0x15
	.4byte	.LASF278
	.byte	0x5
	.uleb128 0x16
	.4byte	.LASF279
	.byte	0x5
	.uleb128 0x18
	.4byte	.LASF280
	.byte	0x5
	.uleb128 0x19
	.4byte	.LASF281
	.byte	0x5
	.uleb128 0x1a
	.4byte	.LASF282
	.byte	0x5
	.uleb128 0x1b
	.4byte	.LASF283
	.byte	0x5
	.uleb128 0x1c
	.4byte	.LASF284
	.byte	0x5
	.uleb128 0x1d
	.4byte	.LASF285
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF286
	.byte	0x5
	.uleb128 0x1f
	.4byte	.LASF287
	.byte	0x5
	.uleb128 0x20
	.4byte	.LASF288
	.byte	0x5
	.uleb128 0x21
	.4byte	.LASF289
	.byte	0x5
	.uleb128 0x22
	.4byte	.LASF290
	.byte	0x5
	.uleb128 0x23
	.4byte	.LASF291
	.byte	0x5
	.uleb128 0x24
	.4byte	.LASF292
	.byte	0x5
	.uleb128 0x25
	.4byte	.LASF293
	.byte	0x5
	.uleb128 0x26
	.4byte	.LASF294
	.byte	0x5
	.uleb128 0x27
	.4byte	.LASF295
	.byte	0x5
	.uleb128 0x28
	.4byte	.LASF296
	.byte	0x5
	.uleb128 0x29
	.4byte	.LASF297
	.byte	0x5
	.uleb128 0x2a
	.4byte	.LASF298
	.byte	0x5
	.uleb128 0x2b
	.4byte	.LASF299
	.byte	0x5
	.uleb128 0x2c
	.4byte	.LASF300
	.byte	0x5
	.uleb128 0x2d
	.4byte	.LASF301
	.byte	0x5
	.uleb128 0x2e
	.4byte	.LASF302
	.byte	0x5
	.uleb128 0x2f
	.4byte	.LASF303
	.byte	0x5
	.uleb128 0x30
	.4byte	.LASF304
	.byte	0x5
	.uleb128 0x31
	.4byte	.LASF305
	.byte	0x5
	.uleb128 0x32
	.4byte	.LASF306
	.byte	0x5
	.uleb128 0x33
	.4byte	.LASF307
	.byte	0x5
	.uleb128 0x37
	.4byte	.LASF308
	.byte	0x5
	.uleb128 0x38
	.4byte	.LASF309
	.byte	0x5
	.uleb128 0x39
	.4byte	.LASF310
	.byte	0x5
	.uleb128 0x3a
	.4byte	.LASF311
	.byte	0x5
	.uleb128 0x3b
	.4byte	.LASF312
	.byte	0x5
	.uleb128 0x3c
	.4byte	.LASF313
	.byte	0x5
	.uleb128 0x3d
	.4byte	.LASF314
	.byte	0x5
	.uleb128 0x3e
	.4byte	.LASF315
	.byte	0x5
	.uleb128 0x3f
	.4byte	.LASF316
	.byte	0x5
	.uleb128 0x40
	.4byte	.LASF317
	.byte	0x5
	.uleb128 0x41
	.4byte	.LASF318
	.byte	0x5
	.uleb128 0x42
	.4byte	.LASF319
	.byte	0x5
	.uleb128 0x43
	.4byte	.LASF320
	.byte	0x5
	.uleb128 0x44
	.4byte	.LASF321
	.byte	0x5
	.uleb128 0x45
	.4byte	.LASF322
	.byte	0x5
	.uleb128 0x46
	.4byte	.LASF323
	.byte	0x5
	.uleb128 0x48
	.4byte	.LASF324
	.byte	0x5
	.uleb128 0x49
	.4byte	.LASF325
	.byte	0x5
	.uleb128 0x4a
	.4byte	.LASF326
	.byte	0x5
	.uleb128 0x4b
	.4byte	.LASF327
	.byte	0x5
	.uleb128 0x4c
	.4byte	.LASF328
	.byte	0x5
	.uleb128 0x4d
	.4byte	.LASF329
	.byte	0x5
	.uleb128 0x4f
	.4byte	.LASF330
	.byte	0x5
	.uleb128 0x51
	.4byte	.LASF331
	.byte	0x5
	.uleb128 0x52
	.4byte	.LASF332
	.byte	0x5
	.uleb128 0x53
	.4byte	.LASF333
	.byte	0x5
	.uleb128 0x55
	.4byte	.LASF334
	.byte	0x5
	.uleb128 0x56
	.4byte	.LASF335
	.byte	0x5
	.uleb128 0x57
	.4byte	.LASF336
	.byte	0x5
	.uleb128 0x58
	.4byte	.LASF337
	.byte	0x5
	.uleb128 0x59
	.4byte	.LASF338
	.byte	0x5
	.uleb128 0x5a
	.4byte	.LASF339
	.byte	0x5
	.uleb128 0x5c
	.4byte	.LASF340
	.byte	0x5
	.uleb128 0x5d
	.4byte	.LASF341
	.byte	0x5
	.uleb128 0x5e
	.4byte	.LASF342
	.byte	0x5
	.uleb128 0x5f
	.4byte	.LASF343
	.byte	0x5
	.uleb128 0x61
	.4byte	.LASF344
	.byte	0x5
	.uleb128 0x62
	.4byte	.LASF345
	.byte	0x5
	.uleb128 0x63
	.4byte	.LASF346
	.byte	0x5
	.uleb128 0x65
	.4byte	.LASF347
	.byte	0x5
	.uleb128 0x66
	.4byte	.LASF348
	.byte	0x5
	.uleb128 0x67
	.4byte	.LASF349
	.byte	0x5
	.uleb128 0x68
	.4byte	.LASF350
	.byte	0x5
	.uleb128 0x69
	.4byte	.LASF351
	.byte	0x5
	.uleb128 0x6a
	.4byte	.LASF352
	.byte	0x5
	.uleb128 0x6b
	.4byte	.LASF353
	.byte	0x5
	.uleb128 0x6c
	.4byte	.LASF354
	.byte	0x5
	.uleb128 0x6e
	.4byte	.LASF355
	.byte	0x5
	.uleb128 0x6f
	.4byte	.LASF356
	.byte	0x5
	.uleb128 0x71
	.4byte	.LASF357
	.byte	0x5
	.uleb128 0x72
	.4byte	.LASF358
	.byte	0x5
	.uleb128 0x73
	.4byte	.LASF359
	.byte	0x5
	.uleb128 0x75
	.4byte	.LASF360
	.byte	0x5
	.uleb128 0x76
	.4byte	.LASF361
	.byte	0x5
	.uleb128 0x77
	.4byte	.LASF362
	.byte	0x5
	.uleb128 0x78
	.4byte	.LASF363
	.byte	0x5
	.uleb128 0x79
	.4byte	.LASF364
	.byte	0x5
	.uleb128 0x7a
	.4byte	.LASF365
	.byte	0x5
	.uleb128 0x7b
	.4byte	.LASF366
	.byte	0x5
	.uleb128 0x7c
	.4byte	.LASF367
	.byte	0x5
	.uleb128 0x7d
	.4byte	.LASF368
	.byte	0x5
	.uleb128 0x7e
	.4byte	.LASF369
	.byte	0x5
	.uleb128 0x7f
	.4byte	.LASF370
	.byte	0x5
	.uleb128 0x80
	.4byte	.LASF371
	.byte	0x5
	.uleb128 0x81
	.4byte	.LASF372
	.byte	0x5
	.uleb128 0x82
	.4byte	.LASF373
	.byte	0x5
	.uleb128 0x83
	.4byte	.LASF374
	.byte	0x5
	.uleb128 0x84
	.4byte	.LASF375
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.genasmdefines.h.5.b82f74ca44ad3cc64aa45e1bcc2a28c6,comdat
.Ldebug_macro3:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x5
	.4byte	.LASF376
	.byte	0x5
	.uleb128 0x7
	.4byte	.LASF377
	.byte	0x5
	.uleb128 0x9
	.4byte	.LASF378
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.compiler.h.7.785519f5a0d664085e8ebc4ac1430440,comdat
.Ldebug_macro4:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x7
	.4byte	.LASF382
	.byte	0x5
	.uleb128 0x12
	.4byte	.LASF383
	.byte	0x5
	.uleb128 0x14
	.4byte	.LASF384
	.byte	0x5
	.uleb128 0x16
	.4byte	.LASF385
	.byte	0x5
	.uleb128 0x18
	.4byte	.LASF386
	.byte	0x5
	.uleb128 0x1a
	.4byte	.LASF387
	.byte	0x5
	.uleb128 0x1b
	.4byte	.LASF388
	.byte	0x5
	.uleb128 0x1c
	.4byte	.LASF389
	.byte	0x5
	.uleb128 0x1d
	.4byte	.LASF390
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF391
	.byte	0x5
	.uleb128 0x20
	.4byte	.LASF392
	.byte	0x5
	.uleb128 0x22
	.4byte	.LASF393
	.byte	0x5
	.uleb128 0x24
	.4byte	.LASF394
	.byte	0x5
	.uleb128 0x26
	.4byte	.LASF395
	.byte	0x5
	.uleb128 0x27
	.4byte	.LASF396
	.byte	0x5
	.uleb128 0x28
	.4byte	.LASF397
	.byte	0x5
	.uleb128 0x29
	.4byte	.LASF398
	.byte	0x5
	.uleb128 0x2a
	.4byte	.LASF399
	.byte	0x5
	.uleb128 0x2b
	.4byte	.LASF400
	.byte	0x5
	.uleb128 0x2c
	.4byte	.LASF401
	.byte	0x5
	.uleb128 0x2d
	.4byte	.LASF402
	.byte	0x5
	.uleb128 0x2e
	.4byte	.LASF403
	.byte	0x5
	.uleb128 0x30
	.4byte	.LASF404
	.byte	0x5
	.uleb128 0x31
	.4byte	.LASF405
	.byte	0x5
	.uleb128 0x32
	.4byte	.LASF406
	.byte	0x5
	.uleb128 0x34
	.4byte	.LASF407
	.byte	0x5
	.uleb128 0x38
	.4byte	.LASF408
	.byte	0x5
	.uleb128 0x3c
	.4byte	.LASF409
	.byte	0x5
	.uleb128 0x3f
	.4byte	.LASF410
	.byte	0x5
	.uleb128 0x42
	.4byte	.LASF411
	.byte	0x5
	.uleb128 0xdd
	.4byte	.LASF412
	.byte	0x5
	.uleb128 0xe1
	.4byte	.LASF413
	.byte	0x5
	.uleb128 0xe2
	.4byte	.LASF414
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.limits.h.6.179d73e9ad99bbd139283748ee9b6c90,comdat
.Ldebug_macro5:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x6
	.4byte	.LASF415
	.byte	0x5
	.uleb128 0x8
	.4byte	.LASF416
	.byte	0x5
	.uleb128 0xb
	.4byte	.LASF417
	.byte	0x5
	.uleb128 0xc
	.4byte	.LASF418
	.byte	0x5
	.uleb128 0x12
	.4byte	.LASF419
	.byte	0x5
	.uleb128 0x13
	.4byte	.LASF420
	.byte	0x5
	.uleb128 0x15
	.4byte	.LASF421
	.byte	0x5
	.uleb128 0x16
	.4byte	.LASF422
	.byte	0x5
	.uleb128 0x18
	.4byte	.LASF423
	.byte	0x5
	.uleb128 0x19
	.4byte	.LASF424
	.byte	0x5
	.uleb128 0x1b
	.4byte	.LASF425
	.byte	0x5
	.uleb128 0x1d
	.4byte	.LASF426
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF427
	.byte	0x5
	.uleb128 0x20
	.4byte	.LASF428
	.byte	0x5
	.uleb128 0x21
	.4byte	.LASF429
	.byte	0x5
	.uleb128 0x26
	.4byte	.LASF430
	.byte	0x5
	.uleb128 0x2c
	.4byte	.LASF431
	.byte	0x5
	.uleb128 0x2f
	.4byte	.LASF432
	.byte	0x5
	.uleb128 0x31
	.4byte	.LASF433
	.byte	0x5
	.uleb128 0x32
	.4byte	.LASF434
	.byte	0x5
	.uleb128 0x34
	.4byte	.LASF435
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.stdint.h.14.75cb69346940ebc01d258c33d4b0bdf5,comdat
.Ldebug_macro6:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0xe
	.4byte	.LASF436
	.byte	0x5
	.uleb128 0xf
	.4byte	.LASF437
	.byte	0x5
	.uleb128 0x29
	.4byte	.LASF438
	.byte	0x5
	.uleb128 0x3b
	.4byte	.LASF439
	.byte	0x5
	.uleb128 0x68
	.4byte	.LASF440
	.byte	0x5
	.uleb128 0x69
	.4byte	.LASF441
	.byte	0x5
	.uleb128 0x6a
	.4byte	.LASF442
	.byte	0x5
	.uleb128 0x6b
	.4byte	.LASF443
	.byte	0x5
	.uleb128 0x6d
	.4byte	.LASF444
	.byte	0x5
	.uleb128 0x6e
	.4byte	.LASF445
	.byte	0x5
	.uleb128 0x6f
	.4byte	.LASF446
	.byte	0x5
	.uleb128 0x70
	.4byte	.LASF447
	.byte	0x5
	.uleb128 0x72
	.4byte	.LASF448
	.byte	0x5
	.uleb128 0x73
	.4byte	.LASF449
	.byte	0x5
	.uleb128 0x74
	.4byte	.LASF450
	.byte	0x5
	.uleb128 0x75
	.4byte	.LASF451
	.byte	0x5
	.uleb128 0x79
	.4byte	.LASF452
	.byte	0x5
	.uleb128 0x7a
	.4byte	.LASF453
	.byte	0x5
	.uleb128 0x7b
	.4byte	.LASF454
	.byte	0x5
	.uleb128 0x7c
	.4byte	.LASF455
	.byte	0x5
	.uleb128 0x7e
	.4byte	.LASF456
	.byte	0x5
	.uleb128 0x7f
	.4byte	.LASF457
	.byte	0x5
	.uleb128 0x80
	.4byte	.LASF458
	.byte	0x5
	.uleb128 0x81
	.4byte	.LASF459
	.byte	0x5
	.uleb128 0x83
	.4byte	.LASF460
	.byte	0x5
	.uleb128 0x84
	.4byte	.LASF461
	.byte	0x5
	.uleb128 0x85
	.4byte	.LASF462
	.byte	0x5
	.uleb128 0x86
	.4byte	.LASF463
	.byte	0x5
	.uleb128 0x8a
	.4byte	.LASF464
	.byte	0x5
	.uleb128 0x8b
	.4byte	.LASF465
	.byte	0x5
	.uleb128 0x8c
	.4byte	.LASF466
	.byte	0x5
	.uleb128 0x8d
	.4byte	.LASF467
	.byte	0x5
	.uleb128 0x8f
	.4byte	.LASF468
	.byte	0x5
	.uleb128 0x90
	.4byte	.LASF469
	.byte	0x5
	.uleb128 0x91
	.4byte	.LASF470
	.byte	0x5
	.uleb128 0x92
	.4byte	.LASF471
	.byte	0x5
	.uleb128 0x94
	.4byte	.LASF472
	.byte	0x5
	.uleb128 0x95
	.4byte	.LASF473
	.byte	0x5
	.uleb128 0x96
	.4byte	.LASF474
	.byte	0x5
	.uleb128 0x97
	.4byte	.LASF475
	.byte	0x5
	.uleb128 0x9b
	.4byte	.LASF476
	.byte	0x5
	.uleb128 0x9c
	.4byte	.LASF477
	.byte	0x5
	.uleb128 0x9d
	.4byte	.LASF478
	.byte	0x5
	.uleb128 0xa0
	.4byte	.LASF479
	.byte	0x5
	.uleb128 0xa1
	.4byte	.LASF480
	.byte	0x5
	.uleb128 0xa2
	.4byte	.LASF481
	.byte	0x5
	.uleb128 0xa5
	.4byte	.LASF482
	.byte	0x5
	.uleb128 0xad
	.4byte	.LASF483
	.byte	0x5
	.uleb128 0xae
	.4byte	.LASF484
	.byte	0x5
	.uleb128 0xaf
	.4byte	.LASF485
	.byte	0x5
	.uleb128 0xb0
	.4byte	.LASF486
	.byte	0x5
	.uleb128 0xb1
	.4byte	.LASF487
	.byte	0x5
	.uleb128 0xb2
	.4byte	.LASF488
	.byte	0x5
	.uleb128 0xb8
	.4byte	.LASF489
	.byte	0x5
	.uleb128 0xb9
	.4byte	.LASF490
	.byte	0x5
	.uleb128 0xbf
	.4byte	.LASF491
	.byte	0x5
	.uleb128 0xc4
	.4byte	.LASF492
	.byte	0x5
	.uleb128 0xc5
	.4byte	.LASF493
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.util.h.11.1d9dd09617f7f6518027fa7eb2cc9aa9,comdat
.Ldebug_macro7:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0xb
	.4byte	.LASF494
	.byte	0x5
	.uleb128 0xc
	.4byte	.LASF495
	.byte	0x5
	.uleb128 0xd
	.4byte	.LASF496
	.byte	0x5
	.uleb128 0xe
	.4byte	.LASF497
	.byte	0x5
	.uleb128 0xf
	.4byte	.LASF498
	.byte	0x5
	.uleb128 0x10
	.4byte	.LASF499
	.byte	0x5
	.uleb128 0x14
	.4byte	.LASF500
	.byte	0x5
	.uleb128 0x19
	.4byte	.LASF501
	.byte	0x5
	.uleb128 0x23
	.4byte	.LASF502
	.byte	0x5
	.uleb128 0x27
	.4byte	.LASF503
	.byte	0x5
	.uleb128 0x2b
	.4byte	.LASF504
	.byte	0x5
	.uleb128 0x32
	.4byte	.LASF505
	.byte	0x5
	.uleb128 0x34
	.4byte	.LASF506
	.byte	0x5
	.uleb128 0x37
	.4byte	.LASF507
	.byte	0x5
	.uleb128 0x38
	.4byte	.LASF508
	.byte	0x5
	.uleb128 0x3a
	.4byte	.LASF509
	.byte	0x5
	.uleb128 0x3b
	.4byte	.LASF510
	.byte	0x5
	.uleb128 0x3d
	.4byte	.LASF511
	.byte	0x5
	.uleb128 0x43
	.4byte	.LASF512
	.byte	0x5
	.uleb128 0x4b
	.4byte	.LASF513
	.byte	0x5
	.uleb128 0x4c
	.4byte	.LASF514
	.byte	0x5
	.uleb128 0x4d
	.4byte	.LASF515
	.byte	0x5
	.uleb128 0x4e
	.4byte	.LASF516
	.byte	0x5
	.uleb128 0x50
	.4byte	.LASF517
	.byte	0x5
	.uleb128 0x57
	.4byte	.LASF518
	.byte	0x5
	.uleb128 0x5a
	.4byte	.LASF519
	.byte	0x5
	.uleb128 0x64
	.4byte	.LASF520
	.byte	0x5
	.uleb128 0x65
	.4byte	.LASF521
	.byte	0x5
	.uleb128 0x66
	.4byte	.LASF522
	.byte	0x5
	.uleb128 0x69
	.4byte	.LASF523
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.arm.h.11.4b7ba2a358d1c34e0977b72b3a2068e5,comdat
.Ldebug_macro8:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0xb
	.4byte	.LASF524
	.byte	0x5
	.uleb128 0xc
	.4byte	.LASF525
	.byte	0x5
	.uleb128 0xd
	.4byte	.LASF526
	.byte	0x5
	.uleb128 0xf
	.4byte	.LASF527
	.byte	0x5
	.uleb128 0x10
	.4byte	.LASF528
	.byte	0x5
	.uleb128 0x11
	.4byte	.LASF529
	.byte	0x5
	.uleb128 0x12
	.4byte	.LASF530
	.byte	0x5
	.uleb128 0x14
	.4byte	.LASF531
	.byte	0x5
	.uleb128 0x15
	.4byte	.LASF532
	.byte	0x5
	.uleb128 0x16
	.4byte	.LASF533
	.byte	0x5
	.uleb128 0x17
	.4byte	.LASF534
	.byte	0x5
	.uleb128 0x18
	.4byte	.LASF535
	.byte	0x5
	.uleb128 0x19
	.4byte	.LASF536
	.byte	0x5
	.uleb128 0x1a
	.4byte	.LASF537
	.byte	0x5
	.uleb128 0x1b
	.4byte	.LASF538
	.byte	0x5
	.uleb128 0x1c
	.4byte	.LASF539
	.byte	0x5
	.uleb128 0x1f
	.4byte	.LASF540
	.byte	0x5
	.uleb128 0x20
	.4byte	.LASF541
	.byte	0x5
	.uleb128 0x21
	.4byte	.LASF542
	.byte	0x5
	.uleb128 0x24
	.4byte	.LASF543
	.byte	0x5
	.uleb128 0x25
	.4byte	.LASF544
	.byte	0x5
	.uleb128 0x26
	.4byte	.LASF545
	.byte	0x5
	.uleb128 0x29
	.4byte	.LASF546
	.byte	0x5
	.uleb128 0x2c
	.4byte	.LASF547
	.byte	0x5
	.uleb128 0x2d
	.4byte	.LASF548
	.byte	0x5
	.uleb128 0x2e
	.4byte	.LASF549
	.byte	0x5
	.uleb128 0x2f
	.4byte	.LASF550
	.byte	0x5
	.uleb128 0x30
	.4byte	.LASF551
	.byte	0x5
	.uleb128 0x31
	.4byte	.LASF552
	.byte	0x5
	.uleb128 0x32
	.4byte	.LASF553
	.byte	0x5
	.uleb128 0x33
	.4byte	.LASF554
	.byte	0x5
	.uleb128 0x34
	.4byte	.LASF555
	.byte	0x5
	.uleb128 0x35
	.4byte	.LASF556
	.byte	0x5
	.uleb128 0x36
	.4byte	.LASF557
	.byte	0x5
	.uleb128 0x38
	.4byte	.LASF558
	.byte	0x5
	.uleb128 0x39
	.4byte	.LASF559
	.byte	0x5
	.uleb128 0x3a
	.4byte	.LASF560
	.byte	0x5
	.uleb128 0x3b
	.4byte	.LASF561
	.byte	0x5
	.uleb128 0x3c
	.4byte	.LASF562
	.byte	0x5
	.uleb128 0x3d
	.4byte	.LASF563
	.byte	0x5
	.uleb128 0x3e
	.4byte	.LASF564
	.byte	0x5
	.uleb128 0x3f
	.4byte	.LASF565
	.byte	0x5
	.uleb128 0x40
	.4byte	.LASF566
	.byte	0x5
	.uleb128 0x42
	.4byte	.LASF567
	.byte	0x5
	.uleb128 0x43
	.4byte	.LASF568
	.byte	0x5
	.uleb128 0x44
	.4byte	.LASF569
	.byte	0x5
	.uleb128 0x45
	.4byte	.LASF570
	.byte	0x5
	.uleb128 0x46
	.4byte	.LASF571
	.byte	0x5
	.uleb128 0x47
	.4byte	.LASF572
	.byte	0x5
	.uleb128 0x48
	.4byte	.LASF573
	.byte	0x5
	.uleb128 0x49
	.4byte	.LASF574
	.byte	0x5
	.uleb128 0x4a
	.4byte	.LASF575
	.byte	0x5
	.uleb128 0x4b
	.4byte	.LASF576
	.byte	0x5
	.uleb128 0x4e
	.4byte	.LASF577
	.byte	0x5
	.uleb128 0x4f
	.4byte	.LASF578
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.cdefs.h.6.216810ff45474094d4f2557fb832b9f7,comdat
.Ldebug_macro9:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x6
	.4byte	.LASF580
	.byte	0x5
	.uleb128 0x12
	.4byte	.LASF581
	.byte	0x5
	.uleb128 0x16
	.4byte	.LASF582
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.arm64.h.12.71943ed1ab9da8730b4526f5056399f7,comdat
.Ldebug_macro10:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0xc
	.4byte	.LASF583
	.byte	0x5
	.uleb128 0xd
	.4byte	.LASF584
	.byte	0x5
	.uleb128 0xe
	.4byte	.LASF585
	.byte	0x5
	.uleb128 0xf
	.4byte	.LASF586
	.byte	0x5
	.uleb128 0x10
	.4byte	.LASF587
	.byte	0x5
	.uleb128 0x11
	.4byte	.LASF588
	.byte	0x5
	.uleb128 0x13
	.4byte	.LASF589
	.byte	0x5
	.uleb128 0x14
	.4byte	.LASF590
	.byte	0x5
	.uleb128 0x16
	.4byte	.LASF543
	.byte	0x5
	.uleb128 0x17
	.4byte	.LASF544
	.byte	0x5
	.uleb128 0x18
	.4byte	.LASF545
	.byte	0x5
	.uleb128 0x1a
	.4byte	.LASF546
	.byte	0x5
	.uleb128 0x1c
	.4byte	.LASF591
	.byte	0x5
	.uleb128 0x1d
	.4byte	.LASF592
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF593
	.byte	0x5
	.uleb128 0x1f
	.4byte	.LASF594
	.byte	0x5
	.uleb128 0x20
	.4byte	.LASF595
	.byte	0x5
	.uleb128 0x23
	.4byte	.LASF596
	.byte	0x5
	.uleb128 0x24
	.4byte	.LASF597
	.byte	0x5
	.uleb128 0x25
	.4byte	.LASF598
	.byte	0x5
	.uleb128 0x26
	.4byte	.LASF599
	.byte	0x5
	.uleb128 0x27
	.4byte	.LASF600
	.byte	0x5
	.uleb128 0x28
	.4byte	.LASF601
	.byte	0x5
	.uleb128 0x2a
	.4byte	.LASF602
	.byte	0x5
	.uleb128 0x2b
	.4byte	.LASF603
	.byte	0x5
	.uleb128 0x2c
	.4byte	.LASF604
	.byte	0x5
	.uleb128 0x2d
	.4byte	.LASF605
	.byte	0x5
	.uleb128 0x2f
	.4byte	.LASF606
	.byte	0x5
	.uleb128 0x30
	.4byte	.LASF607
	.byte	0x5
	.uleb128 0x31
	.4byte	.LASF608
	.byte	0x5
	.uleb128 0x32
	.4byte	.LASF609
	.byte	0x5
	.uleb128 0x34
	.4byte	.LASF610
	.byte	0x5
	.uleb128 0x35
	.4byte	.LASF611
	.byte	0x5
	.uleb128 0x36
	.4byte	.LASF612
	.byte	0x5
	.uleb128 0x37
	.4byte	.LASF613
	.byte	0x5
	.uleb128 0x39
	.4byte	.LASF614
	.byte	0x5
	.uleb128 0x3a
	.4byte	.LASF615
	.byte	0x5
	.uleb128 0x3c
	.4byte	.LASF616
	.byte	0x5
	.uleb128 0x3d
	.4byte	.LASF617
	.byte	0x5
	.uleb128 0x3f
	.4byte	.LASF618
	.byte	0x5
	.uleb128 0x40
	.4byte	.LASF619
	.byte	0x5
	.uleb128 0x41
	.4byte	.LASF620
	.byte	0x5
	.uleb128 0x42
	.4byte	.LASF621
	.byte	0x5
	.uleb128 0x44
	.4byte	.LASF622
	.byte	0x5
	.uleb128 0x45
	.4byte	.LASF623
	.byte	0x5
	.uleb128 0x46
	.4byte	.LASF624
	.byte	0x5
	.uleb128 0x47
	.4byte	.LASF625
	.byte	0x5
	.uleb128 0x49
	.4byte	.LASF626
	.byte	0x5
	.uleb128 0x4a
	.4byte	.LASF627
	.byte	0x5
	.uleb128 0x4b
	.4byte	.LASF628
	.byte	0x5
	.uleb128 0x4e
	.4byte	.LASF629
	.byte	0x5
	.uleb128 0x54
	.4byte	.LASF630
	.byte	0x5
	.uleb128 0x5c
	.4byte	.LASF631
	.byte	0x5
	.uleb128 0x5d
	.4byte	.LASF632
	.byte	0x5
	.uleb128 0x5e
	.4byte	.LASF633
	.byte	0x5
	.uleb128 0x5f
	.4byte	.LASF634
	.byte	0x5
	.uleb128 0x60
	.4byte	.LASF635
	.byte	0x5
	.uleb128 0x61
	.4byte	.LASF636
	.byte	0x5
	.uleb128 0x62
	.4byte	.LASF637
	.byte	0x5
	.uleb128 0x63
	.4byte	.LASF638
	.byte	0x5
	.uleb128 0x64
	.4byte	.LASF639
	.byte	0x5
	.uleb128 0x65
	.4byte	.LASF640
	.byte	0x5
	.uleb128 0x66
	.4byte	.LASF641
	.byte	0x5
	.uleb128 0x67
	.4byte	.LASF642
	.byte	0x5
	.uleb128 0x68
	.4byte	.LASF643
	.byte	0x5
	.uleb128 0x69
	.4byte	.LASF644
	.byte	0x5
	.uleb128 0x6d
	.4byte	.LASF645
	.byte	0x5
	.uleb128 0x6f
	.4byte	.LASF646
	.byte	0x5
	.uleb128 0x71
	.4byte	.LASF647
	.byte	0x5
	.uleb128 0x73
	.4byte	.LASF648
	.byte	0x5
	.uleb128 0x76
	.4byte	.LASF649
	.byte	0x5
	.uleb128 0x78
	.4byte	.LASF650
	.byte	0x5
	.uleb128 0x7a
	.4byte	.LASF651
	.byte	0x5
	.uleb128 0x7c
	.4byte	.LASF652
	.byte	0x5
	.uleb128 0x7d
	.4byte	.LASF653
	.byte	0x5
	.uleb128 0x7f
	.4byte	.LASF654
	.byte	0x5
	.uleb128 0x80
	.4byte	.LASF655
	.byte	0x5
	.uleb128 0x81
	.4byte	.LASF656
	.byte	0x5
	.uleb128 0x82
	.4byte	.LASF657
	.byte	0x5
	.uleb128 0x83
	.4byte	.LASF658
	.byte	0x5
	.uleb128 0x84
	.4byte	.LASF659
	.byte	0x5
	.uleb128 0x85
	.4byte	.LASF660
	.byte	0x5
	.uleb128 0x86
	.4byte	.LASF661
	.byte	0x5
	.uleb128 0x87
	.4byte	.LASF662
	.byte	0x5
	.uleb128 0x88
	.4byte	.LASF663
	.byte	0x5
	.uleb128 0x89
	.4byte	.LASF664
	.byte	0x5
	.uleb128 0x8a
	.4byte	.LASF665
	.byte	0x5
	.uleb128 0x8b
	.4byte	.LASF666
	.byte	0x5
	.uleb128 0x8c
	.4byte	.LASF667
	.byte	0x5
	.uleb128 0x8d
	.4byte	.LASF668
	.byte	0x5
	.uleb128 0x8e
	.4byte	.LASF669
	.byte	0x5
	.uleb128 0x8f
	.4byte	.LASF670
	.byte	0x5
	.uleb128 0x90
	.4byte	.LASF671
	.byte	0x5
	.uleb128 0x91
	.4byte	.LASF672
	.byte	0x5
	.uleb128 0x92
	.4byte	.LASF673
	.byte	0x5
	.uleb128 0x93
	.4byte	.LASF674
	.byte	0x5
	.uleb128 0x94
	.4byte	.LASF675
	.byte	0x5
	.uleb128 0x95
	.4byte	.LASF676
	.byte	0x5
	.uleb128 0x96
	.4byte	.LASF677
	.byte	0x5
	.uleb128 0x97
	.4byte	.LASF678
	.byte	0x5
	.uleb128 0x98
	.4byte	.LASF679
	.byte	0x5
	.uleb128 0x99
	.4byte	.LASF680
	.byte	0x5
	.uleb128 0x9a
	.4byte	.LASF681
	.byte	0x5
	.uleb128 0x9b
	.4byte	.LASF682
	.byte	0x5
	.uleb128 0x9c
	.4byte	.LASF683
	.byte	0x5
	.uleb128 0x9f
	.4byte	.LASF684
	.byte	0x5
	.uleb128 0xa0
	.4byte	.LASF685
	.byte	0x5
	.uleb128 0xa1
	.4byte	.LASF686
	.byte	0x5
	.uleb128 0xa2
	.4byte	.LASF687
	.byte	0x5
	.uleb128 0xa3
	.4byte	.LASF688
	.byte	0x5
	.uleb128 0xa4
	.4byte	.LASF689
	.byte	0x5
	.uleb128 0xa5
	.4byte	.LASF690
	.byte	0x5
	.uleb128 0xa6
	.4byte	.LASF691
	.byte	0x5
	.uleb128 0xa7
	.4byte	.LASF692
	.byte	0x5
	.uleb128 0xa8
	.4byte	.LASF693
	.byte	0x5
	.uleb128 0xa9
	.4byte	.LASF694
	.byte	0x5
	.uleb128 0xaa
	.4byte	.LASF695
	.byte	0x5
	.uleb128 0xab
	.4byte	.LASF696
	.byte	0x5
	.uleb128 0xac
	.4byte	.LASF697
	.byte	0x5
	.uleb128 0xad
	.4byte	.LASF698
	.byte	0x5
	.uleb128 0xae
	.4byte	.LASF699
	.byte	0x5
	.uleb128 0xb1
	.4byte	.LASF700
	.byte	0x5
	.uleb128 0xb3
	.4byte	.LASF701
	.byte	0x5
	.uleb128 0xb4
	.4byte	.LASF702
	.byte	0x5
	.uleb128 0xb5
	.4byte	.LASF703
	.byte	0x5
	.uleb128 0xb6
	.4byte	.LASF704
	.byte	0x5
	.uleb128 0xb7
	.4byte	.LASF705
	.byte	0x5
	.uleb128 0xb8
	.4byte	.LASF706
	.byte	0x5
	.uleb128 0xbc
	.4byte	.LASF707
	.byte	0x5
	.uleb128 0xbd
	.4byte	.LASF708
	.byte	0x5
	.uleb128 0xbe
	.4byte	.LASF709
	.byte	0x5
	.uleb128 0xc0
	.4byte	.LASF710
	.byte	0x5
	.uleb128 0xc1
	.4byte	.LASF711
	.byte	0x5
	.uleb128 0xc2
	.4byte	.LASF712
	.byte	0x5
	.uleb128 0xff
	.4byte	.LASF713
	.byte	0x5
	.uleb128 0x108
	.4byte	.LASF714
	.byte	0x5
	.uleb128 0x10e
	.4byte	.LASF715
	.byte	0x5
	.uleb128 0x111
	.4byte	.LASF716
	.byte	0x5
	.uleb128 0x114
	.4byte	.LASF717
	.byte	0x5
	.uleb128 0x118
	.4byte	.LASF718
	.byte	0x5
	.uleb128 0x11b
	.4byte	.LASF719
	.byte	0x5
	.uleb128 0x11e
	.4byte	.LASF720
	.byte	0x5
	.uleb128 0x13d
	.4byte	.LASF721
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.stddef.h.39.99b5021e28f91cdb161c889e07266673,comdat
.Ldebug_macro11:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x27
	.4byte	.LASF723
	.byte	0x5
	.uleb128 0x28
	.4byte	.LASF724
	.byte	0x5
	.uleb128 0x2a
	.4byte	.LASF725
	.byte	0x5
	.uleb128 0x89
	.4byte	.LASF726
	.byte	0x5
	.uleb128 0x8a
	.4byte	.LASF727
	.byte	0x5
	.uleb128 0x8b
	.4byte	.LASF728
	.byte	0x5
	.uleb128 0x8c
	.4byte	.LASF729
	.byte	0x5
	.uleb128 0x8d
	.4byte	.LASF730
	.byte	0x5
	.uleb128 0x8e
	.4byte	.LASF731
	.byte	0x5
	.uleb128 0x8f
	.4byte	.LASF732
	.byte	0x5
	.uleb128 0x90
	.4byte	.LASF733
	.byte	0x5
	.uleb128 0x91
	.4byte	.LASF734
	.byte	0x6
	.uleb128 0xa1
	.4byte	.LASF735
	.byte	0x5
	.uleb128 0xbb
	.4byte	.LASF736
	.byte	0x5
	.uleb128 0xbc
	.4byte	.LASF737
	.byte	0x5
	.uleb128 0xbd
	.4byte	.LASF738
	.byte	0x5
	.uleb128 0xbe
	.4byte	.LASF739
	.byte	0x5
	.uleb128 0xbf
	.4byte	.LASF740
	.byte	0x5
	.uleb128 0xc0
	.4byte	.LASF741
	.byte	0x5
	.uleb128 0xc1
	.4byte	.LASF742
	.byte	0x5
	.uleb128 0xc2
	.4byte	.LASF743
	.byte	0x5
	.uleb128 0xc3
	.4byte	.LASF744
	.byte	0x5
	.uleb128 0xc4
	.4byte	.LASF745
	.byte	0x5
	.uleb128 0xc5
	.4byte	.LASF746
	.byte	0x5
	.uleb128 0xc6
	.4byte	.LASF747
	.byte	0x5
	.uleb128 0xc7
	.4byte	.LASF748
	.byte	0x5
	.uleb128 0xc8
	.4byte	.LASF749
	.byte	0x5
	.uleb128 0xc9
	.4byte	.LASF750
	.byte	0x5
	.uleb128 0xca
	.4byte	.LASF751
	.byte	0x5
	.uleb128 0xd2
	.4byte	.LASF752
	.byte	0x6
	.uleb128 0xee
	.4byte	.LASF753
	.byte	0x5
	.uleb128 0x10b
	.4byte	.LASF754
	.byte	0x5
	.uleb128 0x10c
	.4byte	.LASF755
	.byte	0x5
	.uleb128 0x10d
	.4byte	.LASF756
	.byte	0x5
	.uleb128 0x10e
	.4byte	.LASF757
	.byte	0x5
	.uleb128 0x10f
	.4byte	.LASF758
	.byte	0x5
	.uleb128 0x110
	.4byte	.LASF759
	.byte	0x5
	.uleb128 0x111
	.4byte	.LASF760
	.byte	0x5
	.uleb128 0x112
	.4byte	.LASF761
	.byte	0x5
	.uleb128 0x113
	.4byte	.LASF762
	.byte	0x5
	.uleb128 0x114
	.4byte	.LASF763
	.byte	0x5
	.uleb128 0x115
	.4byte	.LASF764
	.byte	0x5
	.uleb128 0x116
	.4byte	.LASF765
	.byte	0x5
	.uleb128 0x117
	.4byte	.LASF766
	.byte	0x5
	.uleb128 0x118
	.4byte	.LASF767
	.byte	0x5
	.uleb128 0x119
	.4byte	.LASF768
	.byte	0x6
	.uleb128 0x126
	.4byte	.LASF769
	.byte	0x6
	.uleb128 0x15b
	.4byte	.LASF770
	.byte	0x6
	.uleb128 0x191
	.4byte	.LASF771
	.byte	0x5
	.uleb128 0x196
	.4byte	.LASF772
	.byte	0x6
	.uleb128 0x19c
	.4byte	.LASF773
	.byte	0x5
	.uleb128 0x1a1
	.4byte	.LASF774
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.inttypes.h.14.04e955cd15f1a1b81e8c7d766922740b,comdat
.Ldebug_macro12:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0xe
	.4byte	.LASF776
	.byte	0x5
	.uleb128 0x10
	.4byte	.LASF777
	.byte	0x5
	.uleb128 0x12
	.4byte	.LASF778
	.byte	0x5
	.uleb128 0x13
	.4byte	.LASF779
	.byte	0x5
	.uleb128 0x14
	.4byte	.LASF780
	.byte	0x5
	.uleb128 0x15
	.4byte	.LASF781
	.byte	0x5
	.uleb128 0x16
	.4byte	.LASF782
	.byte	0x5
	.uleb128 0x18
	.4byte	.LASF783
	.byte	0x5
	.uleb128 0x19
	.4byte	.LASF784
	.byte	0x5
	.uleb128 0x1a
	.4byte	.LASF785
	.byte	0x5
	.uleb128 0x1b
	.4byte	.LASF786
	.byte	0x5
	.uleb128 0x1c
	.4byte	.LASF787
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF788
	.byte	0x5
	.uleb128 0x1f
	.4byte	.LASF789
	.byte	0x5
	.uleb128 0x20
	.4byte	.LASF790
	.byte	0x5
	.uleb128 0x21
	.4byte	.LASF791
	.byte	0x5
	.uleb128 0x22
	.4byte	.LASF792
	.byte	0x5
	.uleb128 0x24
	.4byte	.LASF793
	.byte	0x5
	.uleb128 0x25
	.4byte	.LASF794
	.byte	0x5
	.uleb128 0x26
	.4byte	.LASF795
	.byte	0x5
	.uleb128 0x27
	.4byte	.LASF796
	.byte	0x5
	.uleb128 0x28
	.4byte	.LASF797
	.byte	0x5
	.uleb128 0x2a
	.4byte	.LASF798
	.byte	0x5
	.uleb128 0x2b
	.4byte	.LASF799
	.byte	0x5
	.uleb128 0x2c
	.4byte	.LASF800
	.byte	0x5
	.uleb128 0x2d
	.4byte	.LASF801
	.byte	0x5
	.uleb128 0x2e
	.4byte	.LASF802
	.byte	0x5
	.uleb128 0x30
	.4byte	.LASF803
	.byte	0x5
	.uleb128 0x31
	.4byte	.LASF804
	.byte	0x5
	.uleb128 0x32
	.4byte	.LASF805
	.byte	0x5
	.uleb128 0x33
	.4byte	.LASF806
	.byte	0x5
	.uleb128 0x34
	.4byte	.LASF807
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.stdbool.h.29.07dce69c3b78884144b7f7bd19483461,comdat
.Ldebug_macro13:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x1d
	.4byte	.LASF808
	.byte	0x5
	.uleb128 0x21
	.4byte	.LASF809
	.byte	0x5
	.uleb128 0x22
	.4byte	.LASF810
	.byte	0x5
	.uleb128 0x23
	.4byte	.LASF811
	.byte	0x5
	.uleb128 0x34
	.4byte	.LASF812
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.types_ext.h.15.db0baf8d49a762fe2f98d9de4bafc9d7,comdat
.Ldebug_macro14:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0xf
	.4byte	.LASF815
	.byte	0x5
	.uleb128 0x12
	.4byte	.LASF816
	.byte	0x5
	.uleb128 0x1d
	.4byte	.LASF817
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF818
	.byte	0x5
	.uleb128 0x1f
	.4byte	.LASF819
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.optee_msg.h.6.db7a9923cd2db32b336dc53a0324a559,comdat
.Ldebug_macro15:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x6
	.4byte	.LASF820
	.byte	0x5
	.uleb128 0x1b
	.4byte	.LASF821
	.byte	0x5
	.uleb128 0x1c
	.4byte	.LASF822
	.byte	0x5
	.uleb128 0x1d
	.4byte	.LASF823
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF824
	.byte	0x5
	.uleb128 0x1f
	.4byte	.LASF825
	.byte	0x5
	.uleb128 0x20
	.4byte	.LASF826
	.byte	0x5
	.uleb128 0x21
	.4byte	.LASF827
	.byte	0x5
	.uleb128 0x22
	.4byte	.LASF828
	.byte	0x5
	.uleb128 0x23
	.4byte	.LASF829
	.byte	0x5
	.uleb128 0x24
	.4byte	.LASF830
	.byte	0x5
	.uleb128 0x26
	.4byte	.LASF831
	.byte	0x5
	.uleb128 0x2e
	.4byte	.LASF832
	.byte	0x5
	.uleb128 0x4a
	.4byte	.LASF833
	.byte	0x5
	.uleb128 0x53
	.4byte	.LASF834
	.byte	0x5
	.uleb128 0x54
	.4byte	.LASF835
	.byte	0x5
	.uleb128 0x55
	.4byte	.LASF836
	.byte	0x5
	.uleb128 0x5a
	.4byte	.LASF837
	.byte	0x5
	.uleb128 0x5b
	.4byte	.LASF838
	.byte	0x5
	.uleb128 0x5c
	.4byte	.LASF839
	.byte	0x5
	.uleb128 0x5d
	.4byte	.LASF840
	.byte	0x5
	.uleb128 0x5e
	.4byte	.LASF841
	.byte	0x5
	.uleb128 0x5f
	.4byte	.LASF842
	.byte	0x5
	.uleb128 0x64
	.4byte	.LASF843
	.byte	0x5
	.uleb128 0xd7
	.4byte	.LASF844
	.byte	0x5
	.uleb128 0xe8
	.4byte	.LASF845
	.byte	0x5
	.uleb128 0xe9
	.4byte	.LASF846
	.byte	0x5
	.uleb128 0xea
	.4byte	.LASF847
	.byte	0x5
	.uleb128 0xeb
	.4byte	.LASF848
	.byte	0x5
	.uleb128 0xec
	.4byte	.LASF849
	.byte	0x5
	.uleb128 0xf3
	.4byte	.LASF850
	.byte	0x5
	.uleb128 0xf4
	.4byte	.LASF851
	.byte	0x5
	.uleb128 0xf5
	.4byte	.LASF852
	.byte	0x5
	.uleb128 0x100
	.4byte	.LASF853
	.byte	0x5
	.uleb128 0x101
	.4byte	.LASF854
	.byte	0x5
	.uleb128 0x102
	.4byte	.LASF855
	.byte	0x5
	.uleb128 0x103
	.4byte	.LASF856
	.byte	0x5
	.uleb128 0x104
	.4byte	.LASF857
	.byte	0x5
	.uleb128 0x110
	.4byte	.LASF858
	.byte	0x5
	.uleb128 0x138
	.4byte	.LASF859
	.byte	0x5
	.uleb128 0x139
	.4byte	.LASF860
	.byte	0x5
	.uleb128 0x13a
	.4byte	.LASF861
	.byte	0x5
	.uleb128 0x13b
	.4byte	.LASF862
	.byte	0x5
	.uleb128 0x13c
	.4byte	.LASF863
	.byte	0x5
	.uleb128 0x13d
	.4byte	.LASF864
	.byte	0x5
	.uleb128 0x13e
	.4byte	.LASF865
	.byte	0x5
	.uleb128 0x158
	.4byte	.LASF866
	.byte	0x5
	.uleb128 0x16a
	.4byte	.LASF867
	.byte	0x5
	.uleb128 0x16b
	.4byte	.LASF868
	.byte	0x5
	.uleb128 0x16c
	.4byte	.LASF869
	.byte	0x5
	.uleb128 0x173
	.4byte	.LASF870
	.byte	0x5
	.uleb128 0x18c
	.4byte	.LASF871
	.byte	0x5
	.uleb128 0x18e
	.4byte	.LASF872
	.byte	0x5
	.uleb128 0x190
	.4byte	.LASF873
	.byte	0x5
	.uleb128 0x19b
	.4byte	.LASF874
	.byte	0x5
	.uleb128 0x1a4
	.4byte	.LASF875
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.queue.h.36.9fa6792e0efd412331b2097a60408d34,comdat
.Ldebug_macro16:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x24
	.4byte	.LASF877
	.byte	0x5
	.uleb128 0x59
	.4byte	.LASF878
	.byte	0x5
	.uleb128 0x5e
	.4byte	.LASF879
	.byte	0x5
	.uleb128 0x61
	.4byte	.LASF880
	.byte	0x5
	.uleb128 0x7a
	.4byte	.LASF881
	.byte	0x5
	.uleb128 0x7b
	.4byte	.LASF882
	.byte	0x5
	.uleb128 0x7c
	.4byte	.LASF883
	.byte	0x5
	.uleb128 0x7f
	.4byte	.LASF884
	.byte	0x5
	.uleb128 0x83
	.4byte	.LASF885
	.byte	0x5
	.uleb128 0x8c
	.4byte	.LASF886
	.byte	0x5
	.uleb128 0x94
	.4byte	.LASF887
	.byte	0x5
	.uleb128 0x9c
	.4byte	.LASF888
	.byte	0x5
	.uleb128 0xa5
	.4byte	.LASF889
	.byte	0x5
	.uleb128 0xad
	.4byte	.LASF890
	.byte	0x5
	.uleb128 0xae
	.4byte	.LASF891
	.byte	0x5
	.uleb128 0xaf
	.4byte	.LASF892
	.byte	0x5
	.uleb128 0xb4
	.4byte	.LASF893
	.byte	0x5
	.uleb128 0xb9
	.4byte	.LASF894
	.byte	0x5
	.uleb128 0xbc
	.4byte	.LASF895
	.byte	0x5
	.uleb128 0xc4
	.4byte	.LASF896
	.byte	0x5
	.uleb128 0xc8
	.4byte	.LASF897
	.byte	0x5
	.uleb128 0xcd
	.4byte	.LASF898
	.byte	0x5
	.uleb128 0xd2
	.4byte	.LASF899
	.byte	0x5
	.uleb128 0xd6
	.4byte	.LASF900
	.byte	0x5
	.uleb128 0xe3
	.4byte	.LASF901
	.byte	0x5
	.uleb128 0xe8
	.4byte	.LASF902
	.byte	0x5
	.uleb128 0xee
	.4byte	.LASF903
	.byte	0x5
	.uleb128 0xef
	.4byte	.LASF904
	.byte	0x5
	.uleb128 0xf0
	.4byte	.LASF905
	.byte	0x5
	.uleb128 0xf5
	.4byte	.LASF906
	.byte	0x5
	.uleb128 0xfb
	.4byte	.LASF907
	.byte	0x5
	.uleb128 0xfe
	.4byte	.LASF908
	.byte	0x5
	.uleb128 0x106
	.4byte	.LASF909
	.byte	0x5
	.uleb128 0x10b
	.4byte	.LASF910
	.byte	0x5
	.uleb128 0x111
	.4byte	.LASF911
	.byte	0x5
	.uleb128 0x117
	.4byte	.LASF912
	.byte	0x5
	.uleb128 0x11d
	.4byte	.LASF913
	.byte	0x5
	.uleb128 0x122
	.4byte	.LASF914
	.byte	0x5
	.uleb128 0x12f
	.4byte	.LASF915
	.byte	0x5
	.uleb128 0x134
	.4byte	.LASF916
	.byte	0x5
	.uleb128 0x13f
	.4byte	.LASF917
	.byte	0x5
	.uleb128 0x140
	.4byte	.LASF918
	.byte	0x5
	.uleb128 0x141
	.4byte	.LASF919
	.byte	0x5
	.uleb128 0x146
	.4byte	.LASF920
	.byte	0x5
	.uleb128 0x14c
	.4byte	.LASF921
	.byte	0x5
	.uleb128 0x14f
	.4byte	.LASF922
	.byte	0x5
	.uleb128 0x157
	.4byte	.LASF923
	.byte	0x5
	.uleb128 0x15c
	.4byte	.LASF924
	.byte	0x5
	.uleb128 0x162
	.4byte	.LASF925
	.byte	0x5
	.uleb128 0x168
	.4byte	.LASF926
	.byte	0x5
	.uleb128 0x16e
	.4byte	.LASF927
	.byte	0x5
	.uleb128 0x173
	.4byte	.LASF928
	.byte	0x5
	.uleb128 0x180
	.4byte	.LASF929
	.byte	0x5
	.uleb128 0x188
	.4byte	.LASF930
	.byte	0x5
	.uleb128 0x189
	.4byte	.LASF931
	.byte	0x5
	.uleb128 0x18a
	.4byte	.LASF932
	.byte	0x5
	.uleb128 0x18f
	.4byte	.LASF933
	.byte	0x5
	.uleb128 0x194
	.4byte	.LASF934
	.byte	0x5
	.uleb128 0x196
	.4byte	.LASF935
	.byte	0x5
	.uleb128 0x199
	.4byte	.LASF936
	.byte	0x5
	.uleb128 0x19e
	.4byte	.LASF937
	.byte	0x5
	.uleb128 0x1bb
	.4byte	.LASF938
	.byte	0x5
	.uleb128 0x1bc
	.4byte	.LASF939
	.byte	0x5
	.uleb128 0x1bd
	.4byte	.LASF940
	.byte	0x5
	.uleb128 0x1be
	.4byte	.LASF941
	.byte	0x5
	.uleb128 0x1bf
	.4byte	.LASF942
	.byte	0x5
	.uleb128 0x1c2
	.4byte	.LASF943
	.byte	0x5
	.uleb128 0x1c7
	.4byte	.LASF944
	.byte	0x5
	.uleb128 0x1d2
	.4byte	.LASF945
	.byte	0x5
	.uleb128 0x1da
	.4byte	.LASF946
	.byte	0x5
	.uleb128 0x1e5
	.4byte	.LASF947
	.byte	0x5
	.uleb128 0x1ed
	.4byte	.LASF948
	.byte	0x5
	.uleb128 0x1f9
	.4byte	.LASF949
	.byte	0x5
	.uleb128 0x1fe
	.4byte	.LASF950
	.byte	0x5
	.uleb128 0x203
	.4byte	.LASF951
	.byte	0x5
	.uleb128 0x208
	.4byte	.LASF952
	.byte	0x5
	.uleb128 0x20d
	.4byte	.LASF953
	.byte	0x5
	.uleb128 0x219
	.4byte	.LASF954
	.byte	0x5
	.uleb128 0x21a
	.4byte	.LASF955
	.byte	0x5
	.uleb128 0x21b
	.4byte	.LASF956
	.byte	0x5
	.uleb128 0x21d
	.4byte	.LASF957
	.byte	0x5
	.uleb128 0x21f
	.4byte	.LASF958
	.byte	0x5
	.uleb128 0x246
	.4byte	.LASF959
	.byte	0x5
	.uleb128 0x247
	.4byte	.LASF960
	.byte	0x5
	.uleb128 0x248
	.4byte	.LASF961
	.byte	0x5
	.uleb128 0x24b
	.4byte	.LASF962
	.byte	0x5
	.uleb128 0x251
	.4byte	.LASF963
	.byte	0x5
	.uleb128 0x254
	.4byte	.LASF964
	.byte	0x5
	.uleb128 0x25d
	.4byte	.LASF965
	.byte	0x5
	.uleb128 0x262
	.4byte	.LASF966
	.byte	0x5
	.uleb128 0x26e
	.4byte	.LASF967
	.byte	0x5
	.uleb128 0x27a
	.4byte	.LASF968
	.byte	0x5
	.uleb128 0x285
	.4byte	.LASF969
	.byte	0x5
	.uleb128 0x290
	.4byte	.LASF970
	.byte	0x5
	.uleb128 0x2a0
	.4byte	.LASF971
	.byte	0x5
	.uleb128 0x2a5
	.4byte	.LASF972
	.byte	0x5
	.uleb128 0x2ad
	.4byte	.LASF973
	.byte	0x5
	.uleb128 0x2ae
	.4byte	.LASF974
	.byte	0x5
	.uleb128 0x2af
	.4byte	.LASF975
	.byte	0x5
	.uleb128 0x2b0
	.4byte	.LASF976
	.byte	0x5
	.uleb128 0x2b1
	.4byte	.LASF977
	.byte	0x5
	.uleb128 0x2b3
	.4byte	.LASF978
	.byte	0x5
	.uleb128 0x2b7
	.4byte	.LASF979
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.wait_queue.h.6.1d15308850bd16fe033b2da42ed89366,comdat
.Ldebug_macro17:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x6
	.4byte	.LASF980
	.byte	0x5
	.uleb128 0xe
	.4byte	.LASF981
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.mutex.h.17.43c97ef626a55c49cbb2f3c49d828773,comdat
.Ldebug_macro18:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x11
	.4byte	.LASF982
	.byte	0x5
	.uleb128 0x12
	.4byte	.LASF983
	.byte	0x5
	.uleb128 0x13
	.4byte	.LASF984
	.byte	0x5
	.uleb128 0x1c
	.4byte	.LASF985
	.byte	0x5
	.uleb128 0x44
	.4byte	.LASF986
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.vfp.h.7.40102f62ceedfa411b9ce74931a268c6,comdat
.Ldebug_macro19:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x7
	.4byte	.LASF987
	.byte	0x5
	.uleb128 0x2a
	.4byte	.LASF988
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.pgt_cache.h.6.c8088feaa7aee519ace6e2089734334e,comdat
.Ldebug_macro20:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x6
	.4byte	.LASF989
	.byte	0x5
	.uleb128 0x9
	.4byte	.LASF990
	.byte	0x5
	.uleb128 0xa
	.4byte	.LASF991
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.tee_api_defines.h.9.7efb8401b1f9bc34546b5ad5612e403e,comdat
.Ldebug_macro21:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x9
	.4byte	.LASF994
	.byte	0x5
	.uleb128 0xb
	.4byte	.LASF995
	.byte	0x5
	.uleb128 0xd
	.4byte	.LASF996
	.byte	0x5
	.uleb128 0xf
	.4byte	.LASF997
	.byte	0x5
	.uleb128 0x12
	.4byte	.LASF998
	.byte	0x5
	.uleb128 0x13
	.4byte	.LASF999
	.byte	0x5
	.uleb128 0x14
	.4byte	.LASF1000
	.byte	0x5
	.uleb128 0x15
	.4byte	.LASF1001
	.byte	0x5
	.uleb128 0x16
	.4byte	.LASF1002
	.byte	0x5
	.uleb128 0x17
	.4byte	.LASF1003
	.byte	0x5
	.uleb128 0x18
	.4byte	.LASF1004
	.byte	0x5
	.uleb128 0x19
	.4byte	.LASF1005
	.byte	0x5
	.uleb128 0x1a
	.4byte	.LASF1006
	.byte	0x5
	.uleb128 0x1b
	.4byte	.LASF1007
	.byte	0x5
	.uleb128 0x1c
	.4byte	.LASF1008
	.byte	0x5
	.uleb128 0x1d
	.4byte	.LASF1009
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF1010
	.byte	0x5
	.uleb128 0x1f
	.4byte	.LASF1011
	.byte	0x5
	.uleb128 0x20
	.4byte	.LASF1012
	.byte	0x5
	.uleb128 0x21
	.4byte	.LASF1013
	.byte	0x5
	.uleb128 0x22
	.4byte	.LASF1014
	.byte	0x5
	.uleb128 0x23
	.4byte	.LASF1015
	.byte	0x5
	.uleb128 0x24
	.4byte	.LASF1016
	.byte	0x5
	.uleb128 0x25
	.4byte	.LASF1017
	.byte	0x5
	.uleb128 0x26
	.4byte	.LASF1018
	.byte	0x5
	.uleb128 0x27
	.4byte	.LASF1019
	.byte	0x5
	.uleb128 0x28
	.4byte	.LASF1020
	.byte	0x5
	.uleb128 0x29
	.4byte	.LASF1021
	.byte	0x5
	.uleb128 0x2a
	.4byte	.LASF1022
	.byte	0x5
	.uleb128 0x2b
	.4byte	.LASF1023
	.byte	0x5
	.uleb128 0x2c
	.4byte	.LASF1024
	.byte	0x5
	.uleb128 0x2d
	.4byte	.LASF1025
	.byte	0x5
	.uleb128 0x2e
	.4byte	.LASF1026
	.byte	0x5
	.uleb128 0x2f
	.4byte	.LASF1027
	.byte	0x5
	.uleb128 0x32
	.4byte	.LASF1028
	.byte	0x5
	.uleb128 0x33
	.4byte	.LASF1029
	.byte	0x5
	.uleb128 0x34
	.4byte	.LASF1030
	.byte	0x5
	.uleb128 0x35
	.4byte	.LASF1031
	.byte	0x5
	.uleb128 0x36
	.4byte	.LASF1032
	.byte	0x5
	.uleb128 0x37
	.4byte	.LASF1033
	.byte	0x5
	.uleb128 0x38
	.4byte	.LASF1034
	.byte	0x5
	.uleb128 0x3b
	.4byte	.LASF1035
	.byte	0x5
	.uleb128 0x3c
	.4byte	.LASF1036
	.byte	0x5
	.uleb128 0x3d
	.4byte	.LASF1037
	.byte	0x5
	.uleb128 0x3e
	.4byte	.LASF1038
	.byte	0x5
	.uleb128 0x3f
	.4byte	.LASF1039
	.byte	0x5
	.uleb128 0x40
	.4byte	.LASF1040
	.byte	0x5
	.uleb128 0x41
	.4byte	.LASF1041
	.byte	0x5
	.uleb128 0x44
	.4byte	.LASF1042
	.byte	0x5
	.uleb128 0x45
	.4byte	.LASF1043
	.byte	0x5
	.uleb128 0x46
	.4byte	.LASF1044
	.byte	0x5
	.uleb128 0x47
	.4byte	.LASF1045
	.byte	0x5
	.uleb128 0x4a
	.4byte	.LASF1046
	.byte	0x5
	.uleb128 0x4b
	.4byte	.LASF1047
	.byte	0x5
	.uleb128 0x4c
	.4byte	.LASF1048
	.byte	0x5
	.uleb128 0x4f
	.4byte	.LASF1049
	.byte	0x5
	.uleb128 0x50
	.4byte	.LASF1050
	.byte	0x5
	.uleb128 0x51
	.4byte	.LASF1051
	.byte	0x5
	.uleb128 0x54
	.4byte	.LASF1052
	.byte	0x5
	.uleb128 0x57
	.4byte	.LASF1053
	.byte	0x5
	.uleb128 0x59
	.4byte	.LASF1054
	.byte	0x5
	.uleb128 0x5a
	.4byte	.LASF1055
	.byte	0x5
	.uleb128 0x5b
	.4byte	.LASF1056
	.byte	0x5
	.uleb128 0x5c
	.4byte	.LASF1057
	.byte	0x5
	.uleb128 0x5d
	.4byte	.LASF1058
	.byte	0x5
	.uleb128 0x5e
	.4byte	.LASF1059
	.byte	0x5
	.uleb128 0x5f
	.4byte	.LASF1060
	.byte	0x5
	.uleb128 0x60
	.4byte	.LASF1061
	.byte	0x5
	.uleb128 0x61
	.4byte	.LASF1062
	.byte	0x5
	.uleb128 0x62
	.4byte	.LASF1063
	.byte	0x5
	.uleb128 0x63
	.4byte	.LASF1064
	.byte	0x5
	.uleb128 0x64
	.4byte	.LASF1065
	.byte	0x5
	.uleb128 0x65
	.4byte	.LASF1066
	.byte	0x5
	.uleb128 0x66
	.4byte	.LASF1067
	.byte	0x5
	.uleb128 0x67
	.4byte	.LASF1068
	.byte	0x5
	.uleb128 0x68
	.4byte	.LASF1069
	.byte	0x5
	.uleb128 0x69
	.4byte	.LASF1070
	.byte	0x5
	.uleb128 0x6a
	.4byte	.LASF1071
	.byte	0x5
	.uleb128 0x6b
	.4byte	.LASF1072
	.byte	0x5
	.uleb128 0x6c
	.4byte	.LASF1073
	.byte	0x5
	.uleb128 0x6d
	.4byte	.LASF1074
	.byte	0x5
	.uleb128 0x6e
	.4byte	.LASF1075
	.byte	0x5
	.uleb128 0x6f
	.4byte	.LASF1076
	.byte	0x5
	.uleb128 0x70
	.4byte	.LASF1077
	.byte	0x5
	.uleb128 0x71
	.4byte	.LASF1078
	.byte	0x5
	.uleb128 0x72
	.4byte	.LASF1079
	.byte	0x5
	.uleb128 0x73
	.4byte	.LASF1080
	.byte	0x5
	.uleb128 0x74
	.4byte	.LASF1081
	.byte	0x5
	.uleb128 0x77
	.4byte	.LASF1082
	.byte	0x5
	.uleb128 0x78
	.4byte	.LASF1083
	.byte	0x5
	.uleb128 0x79
	.4byte	.LASF1084
	.byte	0x5
	.uleb128 0x7a
	.4byte	.LASF1085
	.byte	0x5
	.uleb128 0x7b
	.4byte	.LASF1086
	.byte	0x5
	.uleb128 0x7c
	.4byte	.LASF1087
	.byte	0x5
	.uleb128 0x7d
	.4byte	.LASF1088
	.byte	0x5
	.uleb128 0x7e
	.4byte	.LASF1089
	.byte	0x5
	.uleb128 0x7f
	.4byte	.LASF1090
	.byte	0x5
	.uleb128 0x80
	.4byte	.LASF1091
	.byte	0x5
	.uleb128 0x81
	.4byte	.LASF1092
	.byte	0x5
	.uleb128 0x82
	.4byte	.LASF1093
	.byte	0x5
	.uleb128 0x83
	.4byte	.LASF1094
	.byte	0x5
	.uleb128 0x84
	.4byte	.LASF1095
	.byte	0x5
	.uleb128 0x85
	.4byte	.LASF1096
	.byte	0x5
	.uleb128 0x86
	.4byte	.LASF1097
	.byte	0x5
	.uleb128 0x87
	.4byte	.LASF1098
	.byte	0x5
	.uleb128 0x88
	.4byte	.LASF1099
	.byte	0x5
	.uleb128 0x89
	.4byte	.LASF1100
	.byte	0x5
	.uleb128 0x8a
	.4byte	.LASF1101
	.byte	0x5
	.uleb128 0x8b
	.4byte	.LASF1102
	.byte	0x5
	.uleb128 0x8c
	.4byte	.LASF1103
	.byte	0x5
	.uleb128 0x8d
	.4byte	.LASF1104
	.byte	0x5
	.uleb128 0x8e
	.4byte	.LASF1105
	.byte	0x5
	.uleb128 0x8f
	.4byte	.LASF1106
	.byte	0x5
	.uleb128 0x90
	.4byte	.LASF1107
	.byte	0x5
	.uleb128 0x91
	.4byte	.LASF1108
	.byte	0x5
	.uleb128 0x92
	.4byte	.LASF1109
	.byte	0x5
	.uleb128 0x93
	.4byte	.LASF1110
	.byte	0x5
	.uleb128 0x94
	.4byte	.LASF1111
	.byte	0x5
	.uleb128 0x95
	.4byte	.LASF1112
	.byte	0x5
	.uleb128 0x96
	.4byte	.LASF1113
	.byte	0x5
	.uleb128 0x97
	.4byte	.LASF1114
	.byte	0x5
	.uleb128 0x98
	.4byte	.LASF1115
	.byte	0x5
	.uleb128 0x99
	.4byte	.LASF1116
	.byte	0x5
	.uleb128 0x9a
	.4byte	.LASF1117
	.byte	0x5
	.uleb128 0x9b
	.4byte	.LASF1118
	.byte	0x5
	.uleb128 0x9c
	.4byte	.LASF1119
	.byte	0x5
	.uleb128 0x9d
	.4byte	.LASF1120
	.byte	0x5
	.uleb128 0x9e
	.4byte	.LASF1121
	.byte	0x5
	.uleb128 0x9f
	.4byte	.LASF1122
	.byte	0x5
	.uleb128 0xa0
	.4byte	.LASF1123
	.byte	0x5
	.uleb128 0xa1
	.4byte	.LASF1124
	.byte	0x5
	.uleb128 0xa2
	.4byte	.LASF1125
	.byte	0x5
	.uleb128 0xa3
	.4byte	.LASF1126
	.byte	0x5
	.uleb128 0xa4
	.4byte	.LASF1127
	.byte	0x5
	.uleb128 0xa5
	.4byte	.LASF1128
	.byte	0x5
	.uleb128 0xa6
	.4byte	.LASF1129
	.byte	0x5
	.uleb128 0xa7
	.4byte	.LASF1130
	.byte	0x5
	.uleb128 0xa8
	.4byte	.LASF1131
	.byte	0x5
	.uleb128 0xa9
	.4byte	.LASF1132
	.byte	0x5
	.uleb128 0xaa
	.4byte	.LASF1133
	.byte	0x5
	.uleb128 0xab
	.4byte	.LASF1134
	.byte	0x5
	.uleb128 0xac
	.4byte	.LASF1135
	.byte	0x5
	.uleb128 0xb7
	.4byte	.LASF1136
	.byte	0x5
	.uleb128 0xb8
	.4byte	.LASF1137
	.byte	0x5
	.uleb128 0xb9
	.4byte	.LASF1138
	.byte	0x5
	.uleb128 0xba
	.4byte	.LASF1139
	.byte	0x5
	.uleb128 0xbb
	.4byte	.LASF1140
	.byte	0x5
	.uleb128 0xbc
	.4byte	.LASF1141
	.byte	0x5
	.uleb128 0xbd
	.4byte	.LASF1142
	.byte	0x5
	.uleb128 0xbe
	.4byte	.LASF1143
	.byte	0x5
	.uleb128 0xbf
	.4byte	.LASF1144
	.byte	0x5
	.uleb128 0xc0
	.4byte	.LASF1145
	.byte	0x5
	.uleb128 0xc4
	.4byte	.LASF1146
	.byte	0x5
	.uleb128 0xc5
	.4byte	.LASF1147
	.byte	0x5
	.uleb128 0xc6
	.4byte	.LASF1148
	.byte	0x5
	.uleb128 0xc7
	.4byte	.LASF1149
	.byte	0x5
	.uleb128 0xc8
	.4byte	.LASF1150
	.byte	0x5
	.uleb128 0xc9
	.4byte	.LASF1151
	.byte	0x5
	.uleb128 0xca
	.4byte	.LASF1152
	.byte	0x5
	.uleb128 0xcb
	.4byte	.LASF1153
	.byte	0x5
	.uleb128 0xcc
	.4byte	.LASF1154
	.byte	0x5
	.uleb128 0xcd
	.4byte	.LASF1155
	.byte	0x5
	.uleb128 0xce
	.4byte	.LASF1156
	.byte	0x5
	.uleb128 0xcf
	.4byte	.LASF1157
	.byte	0x5
	.uleb128 0xd0
	.4byte	.LASF1158
	.byte	0x5
	.uleb128 0xd1
	.4byte	.LASF1159
	.byte	0x5
	.uleb128 0xd2
	.4byte	.LASF1160
	.byte	0x5
	.uleb128 0xd3
	.4byte	.LASF1161
	.byte	0x5
	.uleb128 0xd4
	.4byte	.LASF1162
	.byte	0x5
	.uleb128 0xd5
	.4byte	.LASF1163
	.byte	0x5
	.uleb128 0xd6
	.4byte	.LASF1164
	.byte	0x5
	.uleb128 0xd7
	.4byte	.LASF1165
	.byte	0x5
	.uleb128 0xd8
	.4byte	.LASF1166
	.byte	0x5
	.uleb128 0xdc
	.4byte	.LASF1167
	.byte	0x5
	.uleb128 0xdd
	.4byte	.LASF1168
	.byte	0x5
	.uleb128 0xde
	.4byte	.LASF1169
	.byte	0x5
	.uleb128 0xdf
	.4byte	.LASF1170
	.byte	0x5
	.uleb128 0xe0
	.4byte	.LASF1171
	.byte	0x5
	.uleb128 0xe1
	.4byte	.LASF1172
	.byte	0x5
	.uleb128 0xe2
	.4byte	.LASF1173
	.byte	0x5
	.uleb128 0xe3
	.4byte	.LASF1174
	.byte	0x5
	.uleb128 0xe4
	.4byte	.LASF1175
	.byte	0x5
	.uleb128 0xe5
	.4byte	.LASF1176
	.byte	0x5
	.uleb128 0xe6
	.4byte	.LASF1177
	.byte	0x5
	.uleb128 0xe7
	.4byte	.LASF1178
	.byte	0x5
	.uleb128 0xe8
	.4byte	.LASF1179
	.byte	0x5
	.uleb128 0xe9
	.4byte	.LASF1180
	.byte	0x5
	.uleb128 0xea
	.4byte	.LASF1181
	.byte	0x5
	.uleb128 0xeb
	.4byte	.LASF1182
	.byte	0x5
	.uleb128 0xec
	.4byte	.LASF1183
	.byte	0x5
	.uleb128 0xed
	.4byte	.LASF1184
	.byte	0x5
	.uleb128 0xee
	.4byte	.LASF1185
	.byte	0x5
	.uleb128 0xef
	.4byte	.LASF1186
	.byte	0x5
	.uleb128 0xf0
	.4byte	.LASF1187
	.byte	0x5
	.uleb128 0xf1
	.4byte	.LASF1188
	.byte	0x5
	.uleb128 0xf2
	.4byte	.LASF1189
	.byte	0x5
	.uleb128 0xf3
	.4byte	.LASF1190
	.byte	0x5
	.uleb128 0xf4
	.4byte	.LASF1191
	.byte	0x5
	.uleb128 0xf5
	.4byte	.LASF1192
	.byte	0x5
	.uleb128 0xf7
	.4byte	.LASF1193
	.byte	0x5
	.uleb128 0xf8
	.4byte	.LASF1194
	.byte	0x5
	.uleb128 0xfb
	.4byte	.LASF1195
	.byte	0x5
	.uleb128 0xfc
	.4byte	.LASF1196
	.byte	0x5
	.uleb128 0xfd
	.4byte	.LASF1197
	.byte	0x5
	.uleb128 0xfe
	.4byte	.LASF1198
	.byte	0x5
	.uleb128 0xff
	.4byte	.LASF1199
	.byte	0x5
	.uleb128 0x104
	.4byte	.LASF1200
	.byte	0x5
	.uleb128 0x105
	.4byte	.LASF1201
	.byte	0x5
	.uleb128 0x106
	.4byte	.LASF1202
	.byte	0x5
	.uleb128 0x107
	.4byte	.LASF1203
	.byte	0x5
	.uleb128 0x108
	.4byte	.LASF1204
	.byte	0x5
	.uleb128 0x10a
	.4byte	.LASF1205
	.byte	0x5
	.uleb128 0x10b
	.4byte	.LASF1206
	.byte	0x5
	.uleb128 0x10c
	.4byte	.LASF1207
	.byte	0x5
	.uleb128 0x10d
	.4byte	.LASF1208
	.byte	0x5
	.uleb128 0x10e
	.4byte	.LASF1209
	.byte	0x5
	.uleb128 0x10f
	.4byte	.LASF1210
	.byte	0x5
	.uleb128 0x110
	.4byte	.LASF1211
	.byte	0x5
	.uleb128 0x111
	.4byte	.LASF1212
	.byte	0x5
	.uleb128 0x112
	.4byte	.LASF1213
	.byte	0x5
	.uleb128 0x113
	.4byte	.LASF1214
	.byte	0x5
	.uleb128 0x114
	.4byte	.LASF1215
	.byte	0x5
	.uleb128 0x115
	.4byte	.LASF1216
	.byte	0x5
	.uleb128 0x117
	.4byte	.LASF1217
	.byte	0x5
	.uleb128 0x119
	.4byte	.LASF1218
	.byte	0x5
	.uleb128 0x11a
	.4byte	.LASF1219
	.byte	0x5
	.uleb128 0x11b
	.4byte	.LASF1220
	.byte	0x5
	.uleb128 0x11d
	.4byte	.LASF1221
	.byte	0x5
	.uleb128 0x11e
	.4byte	.LASF1222
	.byte	0x5
	.uleb128 0x11f
	.4byte	.LASF1223
	.byte	0x5
	.uleb128 0x121
	.4byte	.LASF1224
	.byte	0x5
	.uleb128 0x122
	.4byte	.LASF1225
	.byte	0x5
	.uleb128 0x123
	.4byte	.LASF1226
	.byte	0x5
	.uleb128 0x124
	.4byte	.LASF1227
	.byte	0x5
	.uleb128 0x125
	.4byte	.LASF1228
	.byte	0x5
	.uleb128 0x126
	.4byte	.LASF1229
	.byte	0x5
	.uleb128 0x127
	.4byte	.LASF1230
	.byte	0x5
	.uleb128 0x128
	.4byte	.LASF1231
	.byte	0x5
	.uleb128 0x129
	.4byte	.LASF1232
	.byte	0x5
	.uleb128 0x12b
	.4byte	.LASF1233
	.byte	0x5
	.uleb128 0x12c
	.4byte	.LASF1234
	.byte	0x5
	.uleb128 0x12e
	.4byte	.LASF1235
	.byte	0x5
	.uleb128 0x12f
	.4byte	.LASF1236
	.byte	0x5
	.uleb128 0x131
	.4byte	.LASF1237
	.byte	0x5
	.uleb128 0x132
	.4byte	.LASF1238
	.byte	0x5
	.uleb128 0x133
	.4byte	.LASF1239
	.byte	0x5
	.uleb128 0x135
	.4byte	.LASF1240
	.byte	0x5
	.uleb128 0x137
	.4byte	.LASF1241
	.byte	0x5
	.uleb128 0x138
	.4byte	.LASF1242
	.byte	0x5
	.uleb128 0x139
	.4byte	.LASF1243
	.byte	0x5
	.uleb128 0x13a
	.4byte	.LASF1244
	.byte	0x5
	.uleb128 0x13b
	.4byte	.LASF1245
	.byte	0x5
	.uleb128 0x13c
	.4byte	.LASF1246
	.byte	0x5
	.uleb128 0x13d
	.4byte	.LASF1247
	.byte	0x5
	.uleb128 0x13e
	.4byte	.LASF1248
	.byte	0x5
	.uleb128 0x141
	.4byte	.LASF1249
	.byte	0x5
	.uleb128 0x142
	.4byte	.LASF1250
	.byte	0x5
	.uleb128 0x143
	.4byte	.LASF1251
	.byte	0x5
	.uleb128 0x144
	.4byte	.LASF1252
	.byte	0x5
	.uleb128 0x145
	.4byte	.LASF1253
	.byte	0x5
	.uleb128 0x147
	.4byte	.LASF1254
	.byte	0x5
	.uleb128 0x148
	.4byte	.LASF1255
	.byte	0x5
	.uleb128 0x149
	.4byte	.LASF1256
	.byte	0x5
	.uleb128 0x14a
	.4byte	.LASF1257
	.byte	0x5
	.uleb128 0x14b
	.4byte	.LASF1258
	.byte	0x5
	.uleb128 0x14d
	.4byte	.LASF1259
	.byte	0x5
	.uleb128 0x14e
	.4byte	.LASF1260
	.byte	0x5
	.uleb128 0x14f
	.4byte	.LASF1261
	.byte	0x5
	.uleb128 0x150
	.4byte	.LASF1262
	.byte	0x5
	.uleb128 0x152
	.4byte	.LASF1263
	.byte	0x5
	.uleb128 0x153
	.4byte	.LASF1264
	.byte	0x5
	.uleb128 0x154
	.4byte	.LASF1265
	.byte	0x5
	.uleb128 0x155
	.4byte	.LASF1266
	.byte	0x5
	.uleb128 0x156
	.4byte	.LASF1267
	.byte	0x5
	.uleb128 0x157
	.4byte	.LASF1268
	.byte	0x5
	.uleb128 0x158
	.4byte	.LASF1269
	.byte	0x5
	.uleb128 0x159
	.4byte	.LASF1270
	.byte	0x5
	.uleb128 0x15b
	.4byte	.LASF1271
	.byte	0x5
	.uleb128 0x15c
	.4byte	.LASF1272
	.byte	0x5
	.uleb128 0x15e
	.4byte	.LASF1273
	.byte	0x5
	.uleb128 0x15f
	.4byte	.LASF1274
	.byte	0x5
	.uleb128 0x160
	.4byte	.LASF1275
	.byte	0x5
	.uleb128 0x162
	.4byte	.LASF1276
	.byte	0x5
	.uleb128 0x163
	.4byte	.LASF1277
	.byte	0x5
	.uleb128 0x164
	.4byte	.LASF1278
	.byte	0x5
	.uleb128 0x165
	.4byte	.LASF1279
	.byte	0x5
	.uleb128 0x167
	.4byte	.LASF1280
	.byte	0x5
	.uleb128 0x168
	.4byte	.LASF1281
	.byte	0x5
	.uleb128 0x169
	.4byte	.LASF1282
	.byte	0x5
	.uleb128 0x16a
	.4byte	.LASF1283
	.byte	0x5
	.uleb128 0x16b
	.4byte	.LASF1284
	.byte	0x5
	.uleb128 0x16d
	.4byte	.LASF1285
	.byte	0x5
	.uleb128 0x16e
	.4byte	.LASF1286
	.byte	0x5
	.uleb128 0x16f
	.4byte	.LASF1287
	.byte	0x5
	.uleb128 0x170
	.4byte	.LASF1288
	.byte	0x5
	.uleb128 0x172
	.4byte	.LASF1289
	.byte	0x5
	.uleb128 0x174
	.4byte	.LASF1290
	.byte	0x5
	.uleb128 0x176
	.4byte	.LASF1291
	.byte	0x5
	.uleb128 0x177
	.4byte	.LASF1292
	.byte	0x5
	.uleb128 0x178
	.4byte	.LASF1293
	.byte	0x5
	.uleb128 0x179
	.4byte	.LASF1294
	.byte	0x5
	.uleb128 0x17a
	.4byte	.LASF1295
	.byte	0x5
	.uleb128 0x17c
	.4byte	.LASF1296
	.byte	0x5
	.uleb128 0x17d
	.4byte	.LASF1297
	.byte	0x5
	.uleb128 0x17f
	.4byte	.LASF1298
	.byte	0x5
	.uleb128 0x180
	.4byte	.LASF1299
	.byte	0x5
	.uleb128 0x181
	.4byte	.LASF1300
	.byte	0x5
	.uleb128 0x183
	.4byte	.LASF1301
	.byte	0x5
	.uleb128 0x184
	.4byte	.LASF1302
	.byte	0x5
	.uleb128 0x185
	.4byte	.LASF1303
	.byte	0x5
	.uleb128 0x186
	.4byte	.LASF1304
	.byte	0x5
	.uleb128 0x188
	.4byte	.LASF1305
	.byte	0x5
	.uleb128 0x189
	.4byte	.LASF1306
	.byte	0x5
	.uleb128 0x18a
	.4byte	.LASF1307
	.byte	0x5
	.uleb128 0x18b
	.4byte	.LASF1308
	.byte	0x5
	.uleb128 0x18c
	.4byte	.LASF1309
	.byte	0x5
	.uleb128 0x18e
	.4byte	.LASF1310
	.byte	0x5
	.uleb128 0x18f
	.4byte	.LASF1311
	.byte	0x5
	.uleb128 0x190
	.4byte	.LASF1312
	.byte	0x5
	.uleb128 0x191
	.4byte	.LASF1313
	.byte	0x5
	.uleb128 0x192
	.4byte	.LASF1314
	.byte	0x5
	.uleb128 0x193
	.4byte	.LASF1315
	.byte	0x5
	.uleb128 0x195
	.4byte	.LASF1316
	.byte	0x5
	.uleb128 0x196
	.4byte	.LASF1317
	.byte	0x5
	.uleb128 0x197
	.4byte	.LASF1318
	.byte	0x5
	.uleb128 0x198
	.4byte	.LASF1319
	.byte	0x5
	.uleb128 0x199
	.4byte	.LASF1320
	.byte	0x5
	.uleb128 0x19a
	.4byte	.LASF1321
	.byte	0x5
	.uleb128 0x19c
	.4byte	.LASF1322
	.byte	0x5
	.uleb128 0x19d
	.4byte	.LASF1323
	.byte	0x5
	.uleb128 0x19e
	.4byte	.LASF1324
	.byte	0x5
	.uleb128 0x1a0
	.4byte	.LASF1325
	.byte	0x5
	.uleb128 0x1a1
	.4byte	.LASF1326
	.byte	0x5
	.uleb128 0x1a2
	.4byte	.LASF1327
	.byte	0x5
	.uleb128 0x1ae
	.4byte	.LASF1328
	.byte	0x5
	.uleb128 0x1b5
	.4byte	.LASF1329
	.byte	0x5
	.uleb128 0x1bb
	.4byte	.LASF1330
	.byte	0x5
	.uleb128 0x1be
	.4byte	.LASF1331
	.byte	0x5
	.uleb128 0x1c2
	.4byte	.LASF1332
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.tee_api_types.h.195.70f88af562e4de06db5cb96bde92609f,comdat
.Ldebug_macro22:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0xc3
	.4byte	.LASF1333
	.byte	0x5
	.uleb128 0xc4
	.4byte	.LASF1334
	.byte	0x5
	.uleb128 0xc6
	.4byte	.LASF1335
	.byte	0x5
	.uleb128 0xc7
	.4byte	.LASF1336
	.byte	0x5
	.uleb128 0xc8
	.4byte	.LASF1337
	.byte	0x5
	.uleb128 0xc9
	.4byte	.LASF1338
	.byte	0x5
	.uleb128 0xcb
	.4byte	.LASF1339
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.malloc.h.40.41c4294a7bc2e0afebb2a2e57712b495,comdat
.Ldebug_macro23:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x28
	.4byte	.LASF1344
	.byte	0x5
	.uleb128 0x47
	.4byte	.LASF1345
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.tee_common.h.32.e3e16e2e9a1728f6eed2b7aa0525ca57,comdat
.Ldebug_macro24:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x20
	.4byte	.LASF1347
	.byte	0x5
	.uleb128 0x21
	.4byte	.LASF1348
	.byte	0x5
	.uleb128 0x22
	.4byte	.LASF1349
	.byte	0x5
	.uleb128 0x23
	.4byte	.LASF1350
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.user_ta_header.h.8.2781ab383cd2d7335511ecf829b9df5e,comdat
.Ldebug_macro25:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x8
	.4byte	.LASF1351
	.byte	0x5
	.uleb128 0xd
	.4byte	.LASF1352
	.byte	0x5
	.uleb128 0xe
	.4byte	.LASF1353
	.byte	0x5
	.uleb128 0xf
	.4byte	.LASF1354
	.byte	0x5
	.uleb128 0x10
	.4byte	.LASF1355
	.byte	0x5
	.uleb128 0x11
	.4byte	.LASF1356
	.byte	0x5
	.uleb128 0x12
	.4byte	.LASF1357
	.byte	0x5
	.uleb128 0x17
	.4byte	.LASF1358
	.byte	0x5
	.uleb128 0x19
	.4byte	.LASF1359
	.byte	0x5
	.uleb128 0x1c
	.4byte	.LASF1360
	.byte	0x5
	.uleb128 0x1d
	.4byte	.LASF1361
	.byte	0x5
	.uleb128 0x2e
	.4byte	.LASF1362
	.byte	0x5
	.uleb128 0x2f
	.4byte	.LASF1363
	.byte	0x5
	.uleb128 0x30
	.4byte	.LASF1364
	.byte	0x5
	.uleb128 0x31
	.4byte	.LASF1365
	.byte	0x5
	.uleb128 0x32
	.4byte	.LASF1366
	.byte	0x5
	.uleb128 0x33
	.4byte	.LASF1367
	.byte	0x5
	.uleb128 0x34
	.4byte	.LASF1368
	.byte	0x5
	.uleb128 0x35
	.4byte	.LASF1369
	.byte	0x5
	.uleb128 0x36
	.4byte	.LASF1370
	.byte	0x5
	.uleb128 0x37
	.4byte	.LASF1371
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.tee_ta_manager.h.20.09b399e1a72b591aff87629f67e7fe65,comdat
.Ldebug_macro26:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x14
	.4byte	.LASF1372
	.byte	0x5
	.uleb128 0x16
	.4byte	.LASF1373
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.thread.h.20.656e13173040eba2ae866f653ea07a3f,comdat
.Ldebug_macro27:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x14
	.4byte	.LASF1375
	.byte	0x5
	.uleb128 0x15
	.4byte	.LASF1376
	.byte	0x5
	.uleb128 0x17
	.4byte	.LASF1377
	.byte	0x5
	.uleb128 0x20
	.4byte	.LASF1378
	.byte	0x5
	.uleb128 0x13f
	.4byte	.LASF1379
	.byte	0x5
	.uleb128 0x140
	.4byte	.LASF1380
	.byte	0x5
	.uleb128 0x142
	.4byte	.LASF1381
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.sm.h.8.c59077c656111167184e969341f630c4,comdat
.Ldebug_macro28:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x8
	.4byte	.LASF1383
	.byte	0x5
	.uleb128 0x57
	.4byte	.LASF1384
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.trace_levels.h.6.fb4a96e7699f1e5d69a583f32404a6b0,comdat
.Ldebug_macro29:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x6
	.4byte	.LASF1389
	.byte	0x5
	.uleb128 0x1a
	.4byte	.LASF1390
	.byte	0x5
	.uleb128 0x1b
	.4byte	.LASF1391
	.byte	0x5
	.uleb128 0x1c
	.4byte	.LASF1392
	.byte	0x5
	.uleb128 0x1d
	.4byte	.LASF1393
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF1394
	.byte	0x5
	.uleb128 0x1f
	.4byte	.LASF1395
	.byte	0x5
	.uleb128 0x22
	.4byte	.LASF1396
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.trace.h.13.7176813e306718695a633d8e924001f2,comdat
.Ldebug_macro30:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0xd
	.4byte	.LASF1397
	.byte	0x5
	.uleb128 0xe
	.4byte	.LASF1398
	.byte	0x5
	.uleb128 0x22
	.4byte	.LASF1399
	.byte	0x5
	.uleb128 0x2a
	.4byte	.LASF1400
	.byte	0x5
	.uleb128 0x31
	.4byte	.LASF1401
	.byte	0x5
	.uleb128 0x38
	.4byte	.LASF1402
	.byte	0x5
	.uleb128 0x3f
	.4byte	.LASF1403
	.byte	0x5
	.uleb128 0x44
	.4byte	.LASF1404
	.byte	0x5
	.uleb128 0x4a
	.4byte	.LASF1405
	.byte	0x5
	.uleb128 0x4c
	.4byte	.LASF1406
	.byte	0x5
	.uleb128 0x4f
	.4byte	.LASF1407
	.byte	0x5
	.uleb128 0x5a
	.4byte	.LASF1408
	.byte	0x5
	.uleb128 0x61
	.4byte	.LASF1409
	.byte	0x5
	.uleb128 0x68
	.4byte	.LASF1410
	.byte	0x5
	.uleb128 0x6f
	.4byte	.LASF1411
	.byte	0x5
	.uleb128 0x76
	.4byte	.LASF1412
	.byte	0x5
	.uleb128 0x7d
	.4byte	.LASF1413
	.byte	0x5
	.uleb128 0x82
	.4byte	.LASF1414
	.byte	0x5
	.uleb128 0x8f
	.4byte	.LASF1415
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.unwind.h.34.a262572c2eb53b0e863d58f2125d1209,comdat
.Ldebug_macro31:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x22
	.4byte	.LASF1416
	.byte	0x5
	.uleb128 0x79
	.4byte	.LASF1417
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.trace.h.150.6ceff30e88656027a4b8063cf061bf35,comdat
.Ldebug_macro32:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x96
	.4byte	.LASF1418
	.byte	0x5
	.uleb128 0x9a
	.4byte	.LASF1419
	.byte	0x5
	.uleb128 0xa0
	.4byte	.LASF1420
	.byte	0x5
	.uleb128 0xa6
	.4byte	.LASF1421
	.byte	0x5
	.uleb128 0xae
	.4byte	.LASF1422
	.byte	0x6
	.uleb128 0xb2
	.4byte	.LASF1423
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.assert.h.19.d5c5642ae191d5539a96347cd4ce4641,comdat
.Ldebug_macro33:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x13
	.4byte	.LASF1424
	.byte	0x5
	.uleb128 0x1c
	.4byte	.LASF1425
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.tee_mm.h.7.2d440fbfd4b160010e5a0b9cf4990537,comdat
.Ldebug_macro34:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x7
	.4byte	.LASF1427
	.byte	0x5
	.uleb128 0xd
	.4byte	.LASF1428
	.byte	0x5
	.uleb128 0xf
	.4byte	.LASF1429
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.tee_mmu_types.h.12.6ac4e0f8d5daf3bf710dcb339ab7e558,comdat
.Ldebug_macro35:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0xc
	.4byte	.LASF1431
	.byte	0x5
	.uleb128 0xd
	.4byte	.LASF1432
	.byte	0x5
	.uleb128 0xe
	.4byte	.LASF1433
	.byte	0x5
	.uleb128 0xf
	.4byte	.LASF1434
	.byte	0x5
	.uleb128 0x10
	.4byte	.LASF1435
	.byte	0x5
	.uleb128 0x11
	.4byte	.LASF1436
	.byte	0x5
	.uleb128 0x12
	.4byte	.LASF1437
	.byte	0x5
	.uleb128 0x13
	.4byte	.LASF1438
	.byte	0x5
	.uleb128 0x14
	.4byte	.LASF1439
	.byte	0x5
	.uleb128 0x15
	.4byte	.LASF1440
	.byte	0x5
	.uleb128 0x16
	.4byte	.LASF1441
	.byte	0x5
	.uleb128 0x17
	.4byte	.LASF1442
	.byte	0x5
	.uleb128 0x18
	.4byte	.LASF1443
	.byte	0x5
	.uleb128 0x19
	.4byte	.LASF1444
	.byte	0x5
	.uleb128 0x1a
	.4byte	.LASF1445
	.byte	0x5
	.uleb128 0x1b
	.4byte	.LASF1446
	.byte	0x5
	.uleb128 0x1c
	.4byte	.LASF1447
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF1448
	.byte	0x5
	.uleb128 0x1f
	.4byte	.LASF1449
	.byte	0x5
	.uleb128 0x21
	.4byte	.LASF1450
	.byte	0x5
	.uleb128 0x22
	.4byte	.LASF1451
	.byte	0x5
	.uleb128 0x24
	.4byte	.LASF1452
	.byte	0x5
	.uleb128 0x25
	.4byte	.LASF1453
	.byte	0x5
	.uleb128 0x27
	.4byte	.LASF1454
	.byte	0x5
	.uleb128 0x2c
	.4byte	.LASF1455
	.byte	0x5
	.uleb128 0x31
	.4byte	.LASF1456
	.byte	0x5
	.uleb128 0x34
	.4byte	.LASF1457
	.byte	0x5
	.uleb128 0x35
	.4byte	.LASF1458
	.byte	0x5
	.uleb128 0x39
	.4byte	.LASF1459
	.byte	0x5
	.uleb128 0x3a
	.4byte	.LASF1460
	.byte	0x5
	.uleb128 0x3c
	.4byte	.LASF1461
	.byte	0x5
	.uleb128 0x3e
	.4byte	.LASF1462
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.generic_ram_layout.h.7.e23ccc93421ef2c87da315f8b03435ea,comdat
.Ldebug_macro36:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x7
	.4byte	.LASF1464
	.byte	0x5
	.uleb128 0x7a
	.4byte	.LASF1465
	.byte	0x5
	.uleb128 0x7e
	.4byte	.LASF1466
	.byte	0x5
	.uleb128 0x82
	.4byte	.LASF1467
	.byte	0x5
	.uleb128 0x8f
	.4byte	.LASF1468
	.byte	0x5
	.uleb128 0x90
	.4byte	.LASF1469
	.byte	0x5
	.uleb128 0xa2
	.4byte	.LASF1470
	.byte	0x5
	.uleb128 0xa3
	.4byte	.LASF1471
	.byte	0x5
	.uleb128 0xa4
	.4byte	.LASF1472
	.byte	0x5
	.uleb128 0xa6
	.4byte	.LASF1473
	.byte	0x5
	.uleb128 0xb6
	.4byte	.LASF1474
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.platform_config.h.13.5cf91b5ab01eefcec4c26c2ea462ac99,comdat
.Ldebug_macro37:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0xd
	.4byte	.LASF1475
	.byte	0x5
	.uleb128 0x46
	.4byte	.LASF1476
	.byte	0x5
	.uleb128 0x47
	.4byte	.LASF1477
	.byte	0x5
	.uleb128 0x49
	.4byte	.LASF1478
	.byte	0x5
	.uleb128 0x85
	.4byte	.LASF1479
	.byte	0x5
	.uleb128 0x88
	.4byte	.LASF1480
	.byte	0x5
	.uleb128 0x8d
	.4byte	.LASF1481
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.core_mmu.h.21.42c5e4e499827236c4135a16aa0603d3,comdat
.Ldebug_macro38:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x15
	.4byte	.LASF1482
	.byte	0x5
	.uleb128 0x16
	.4byte	.LASF1483
	.byte	0x5
	.uleb128 0x17
	.4byte	.LASF1484
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF1485
	.byte	0x5
	.uleb128 0x1f
	.4byte	.LASF1486
	.byte	0x5
	.uleb128 0x24
	.4byte	.LASF1487
	.byte	0x5
	.uleb128 0x25
	.4byte	.LASF1488
	.byte	0x5
	.uleb128 0x28
	.4byte	.LASF1489
	.byte	0x5
	.uleb128 0x29
	.4byte	.LASF1490
	.byte	0x5
	.uleb128 0x2a
	.4byte	.LASF1491
	.byte	0x5
	.uleb128 0x2d
	.4byte	.LASF1492
	.byte	0x5
	.uleb128 0x2e
	.4byte	.LASF1493
	.byte	0x5
	.uleb128 0x2f
	.4byte	.LASF1494
	.byte	0x5
	.uleb128 0x32
	.4byte	.LASF1495
	.byte	0x5
	.uleb128 0x33
	.4byte	.LASF1496
	.byte	0x5
	.uleb128 0x34
	.4byte	.LASF1497
	.byte	0x5
	.uleb128 0x3d
	.4byte	.LASF1498
	.byte	0x5
	.uleb128 0x4f
	.4byte	.LASF1499
	.byte	0x5
	.uleb128 0x52
	.4byte	.LASF1500
	.byte	0x5
	.uleb128 0x53
	.4byte	.LASF1501
	.byte	0x5
	.uleb128 0xa4
	.4byte	.LASF1502
	.byte	0x5
	.uleb128 0xc0
	.4byte	.LASF1503
	.byte	0x5
	.uleb128 0xcc
	.4byte	.LASF1504
	.byte	0x5
	.uleb128 0xd0
	.4byte	.LASF1505
	.byte	0x5
	.uleb128 0xd3
	.4byte	.LASF1506
	.byte	0x5
	.uleb128 0xd6
	.4byte	.LASF1507
	.byte	0x5
	.uleb128 0xda
	.4byte	.LASF1508
	.byte	0x5
	.uleb128 0xe3
	.4byte	.LASF1509
	.byte	0x5
	.uleb128 0xe8
	.4byte	.LASF1510
	.byte	0x5
	.uleb128 0xec
	.4byte	.LASF1511
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.thread_private.h.102.511550c2c8493ef49b9ba2085aefe761,comdat
.Ldebug_macro39:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x66
	.4byte	.LASF1512
	.byte	0x5
	.uleb128 0x6e
	.4byte	.LASF1513
	.byte	0x5
	.uleb128 0x6f
	.4byte	.LASF1514
	.byte	0x5
	.uleb128 0x70
	.4byte	.LASF1515
	.byte	0x5
	.uleb128 0x71
	.4byte	.LASF1516
	.byte	0x5
	.uleb128 0x72
	.4byte	.LASF1517
	.byte	0x5
	.uleb128 0x73
	.4byte	.LASF1518
	.byte	0x5
	.uleb128 0x74
	.4byte	.LASF1519
	.byte	0x5
	.uleb128 0x76
	.4byte	.LASF1520
	.byte	0x5
	.uleb128 0x77
	.4byte	.LASF1521
	.byte	0x5
	.uleb128 0x78
	.4byte	.LASF1522
	.byte	0x5
	.uleb128 0x79
	.4byte	.LASF1523
	.byte	0x5
	.uleb128 0xde
	.4byte	.LASF1524
	.byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF995:
	.string	"TEE_INT_CORE_API_SPEC_VERSION 0x0000000A"
.LASF1508:
	.string	"register_phys_mem_ul(type,addr,size) __register_memory1_ul(#addr, (type), (addr), (size), phys_mem_map_section, __COUNTER__)"
.LASF1543:
	.string	"slh_first"
.LASF900:
	.ascii	"SLIST_REMOVE(head,elm,type,field) do { if ((head)->s"
	.string	"lh_first == (elm)) { SLIST_REMOVE_HEAD((head), field); } else { struct type *curelm = (head)->slh_first; while(curelm->field.sle_next != (elm)) curelm = curelm->field.sle_next; curelm->field.sle_next = curelm->field.sle_next->field.sle_next; } } while ( 0)"
.LASF1270:
	.string	"TEE_PANIC_ID_TEE_GETOPERATIONINFOMULTIPLE 0x00000C08"
.LASF36:
	.string	"__FLOAT_WORD_ORDER__ __ORDER_LITTLE_ENDIAN__"
.LASF1533:
	.string	"unsigned int"
.LASF1633:
	.string	"pgt_cache"
.LASF960:
	.string	"QUEUEDEBUG_CIRCLEQ_ELM(head,elm,field) "
.LASF1602:
	.string	"cancel"
.LASF1147:
	.string	"TEE_TYPE_DES 0xA0000011"
.LASF1697:
	.string	"rpc_carg"
.LASF854:
	.string	"OPTEE_MSG_OS_OPTEE_UUID_1 0xe7f811e3"
.LASF994:
	.string	"TEE_API_DEFINES_H "
.LASF934:
	.string	"TAILQ_HEAD(name,type) _TAILQ_HEAD(name, struct type,)"
.LASF763:
	.string	"_WCHAR_T_DEFINED "
.LASF630:
	.string	"SPSR_32(mode,isa,aif) (SPSR_MODE_RW_32 << SPSR_MODE_RW_SHIFT | SPSR_32_E_LITTLE << SPSR_32_E_SHIFT | ((mode) & SPSR_32_MODE_MASK) << SPSR_32_MODE_SHIFT | ((isa) & SPSR_32_T_MASK) << SPSR_32_T_SHIFT | ((aif) & SPSR_32_AIF_MASK) << SPSR_32_AIF_SHIFT)"
.LASF341:
	.string	"CFG_TA_MBEDTLS_SELF_TEST 1"
.LASF1433:
	.string	"TEE_MATTR_HIDDEN_DIRTY_BLOCK BIT(2)"
.LASF428:
	.string	"SHRT_MAX __SHRT_MAX__"
.LASF814:
	.string	"__ssize_t_defined "
.LASF306:
	.string	"CFG_DTB_MAX_SIZE 0x10000"
.LASF620:
	.string	"SPSR_32_E_LITTLE 0x0"
.LASF280:
	.string	"CFG_CRYPTO_CBC 1"
.LASF1297:
	.string	"TEE_PANIC_ID_TEE_BIGINTFMMSIZEINU32 0x00001502"
.LASF781:
	.string	"PRId64 __PRI64_PREFIX \"d\""
.LASF896:
	.string	"SLIST_INIT(head) do { (head)->slh_first = NULL; } while ( 0)"
.LASF137:
	.string	"__FLT_MAX_10_EXP__ 38"
.LASF1544:
	.string	"handle"
.LASF902:
	.string	"SLIST_FOREACH(var,head,field) for((var) = (head)->slh_first; (var); (var) = (var)->field.sle_next)"
.LASF1017:
	.string	"TEE_ERROR_COMMUNICATION 0xFFFF000E"
.LASF501:
	.string	"MIN(a,b) (__extension__({ __typeof__(a) _a = (a); __typeof__(b) _b = (b); _a < _b ? _a : _b; }))"
.LASF1109:
	.string	"TEE_ALG_RSASSA_PKCS1_PSS_MGF1_SHA256 0x70414930"
.LASF709:
	.string	"PAR_PA_MASK (BIT64(36) - 1)"
.LASF1332:
	.string	"TEE_BigIntSizeInU32(n) ((((n)+31)/32)+2)"
.LASF568:
	.string	"ARM32_CPSR_F_SHIFT 6"
.LASF850:
	.string	"OPTEE_MSG_REVISION_MAJOR 2"
.LASF557:
	.string	"CTR_IMINLINE_MASK 0xf"
.LASF1568:
	.string	"timeMid"
.LASF1657:
	.string	"trace_level"
.LASF652:
	.string	"ESR_EC_SHIFT 26"
.LASF461:
	.string	"UINT_LEAST16_MAX UINT16_MAX"
.LASF546:
	.string	"CSSELR_LEVEL_SHIFT 1"
.LASF938:
	.string	"QUEUEDEBUG_TAILQ_INSERT_HEAD(head,elm,field) "
.LASF85:
	.string	"__PTRDIFF_MAX__ 0x7fffffffffffffffL"
.LASF675:
	.string	"ESR_EC_SERROR 0x2f"
.LASF0:
	.string	"__STDC__ 1"
.LASF943:
	.string	"TAILQ_INIT(head) do { (head)->tqh_first = NULL; (head)->tqh_last = &(head)->tqh_first; } while ( 0)"
.LASF1549:
	.string	"_Bool"
.LASF1370:
	.string	"TA_PROP_STR_REMAP \"op-tee.remap\""
.LASF1263:
	.string	"TEE_PANIC_ID_TEE_ALLOCATEOPERATION 0x00000C01"
.LASF26:
	.string	"__SIZEOF_FLOAT__ 4"
.LASF122:
	.string	"__UINT_FAST16_MAX__ 0xffffffffffffffffUL"
.LASF189:
	.string	"__DEC128_MIN_EXP__ (-6142)"
.LASF1197:
	.string	"TEE_ECC_CURVE_NIST_P256 0x00000003"
.LASF269:
	.string	"CFG_CORE_CLUSTER_SHIFT 2"
.LASF843:
	.string	"OPTEE_MSG_NONCONTIG_PAGE_SIZE 4096"
.LASF151:
	.string	"__DBL_MAX_10_EXP__ 308"
.LASF1707:
	.string	"thread_cpu_suspend_handler_ptr"
.LASF1418:
	.string	"_PRINT_STACK "
.LASF1542:
	.string	"wait_queue_elem"
.LASF1259:
	.string	"TEE_PANIC_ID_TEE_READOBJECTDATA 0x00000B01"
.LASF228:
	.string	"__ARM_FEATURE_IDIV 1"
.LASF249:
	.string	"_ILP32"
.LASF40:
	.string	"__WCHAR_TYPE__ unsigned int"
.LASF260:
	.string	"__ELF__ 1"
.LASF845:
	.string	"OPTEE_MSG_UID_0 0x384fb3e0"
.LASF1649:
	.string	"rpc_fs_payload_size"
.LASF1451:
	.string	"TEE_MATTR_CACHE_SHIFT 12"
.LASF23:
	.string	"__SIZEOF_LONG__ 8"
.LASF1096:
	.string	"TEE_ALG_DES3_ECB_NOPAD 0x10000013"
.LASF233:
	.string	"__ARM_ARCH 8"
.LASF1640:
	.string	"cpu_suspend_entry"
.LASF1545:
	.string	"done"
.LASF494:
	.string	"SIZE_4K UINTPTR_C(0x1000)"
.LASF1223:
	.string	"TEE_PANIC_ID_TEE_UNMASKCANCELLATION 0x00000503"
.LASF755:
	.string	"__WCHAR_T__ "
.LASF1327:
	.string	"TEE_PANIC_ID_TEE_BIGINTCONVERTTOFMM 0x00001C03"
.LASF388:
	.string	"__aligned(x) __attribute__((aligned(x)))"
.LASF1345:
	.string	"TEE_ALLOCATOR_DESC_LENGTH 32"
.LASF775:
	.string	"INTTYPES_H "
.LASF575:
	.string	"ARM32_CPSR_IT_MASK1 0x06000000"
.LASF502:
	.string	"ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))"
.LASF518:
	.string	"GENMASK_32(h,l) (((~UINT32_C(0)) << (l)) & (~UINT32_C(0) >> (32 - 1 - (h))))"
.LASF808:
	.string	"_STDBOOL_H "
.LASF426:
	.string	"SCHAR_MAX __SCHAR_MAX__"
.LASF1374:
	.string	"PGT_CACHE_SIZE ROUNDUP(CFG_NUM_THREADS * 2, PGT_NUM_PGT_PER_PAGE)"
.LASF479:
	.string	"INTMAX_MAX INT64_MAX"
.LASF432:
	.string	"UINT_MAX (INT_MAX * 2U + 1U)"
.LASF454:
	.string	"INT_LEAST32_MIN INT32_MIN"
.LASF1098:
	.string	"TEE_ALG_DES3_CBC_MAC_NOPAD 0x30000113"
.LASF598:
	.string	"DAIF_I BIT32(7)"
.LASF467:
	.string	"INT_FAST64_MIN INT64_MIN"
.LASF463:
	.string	"UINT_LEAST64_MAX UINT64_MAX"
.LASF144:
	.string	"__FLT_HAS_INFINITY__ 1"
.LASF1272:
	.string	"TEE_PANIC_ID_TEE_DIGESTUPDATE 0x00000D02"
.LASF1530:
	.string	"uint16_t"
.LASF1188:
	.string	"TEE_ATTR_RSA_PSS_SALT_LENGTH 0xF0000A30"
.LASF912:
	.string	"STAILQ_INSERT_AFTER(head,listelm,elm,field) do { if (((elm)->field.stqe_next = (listelm)->field.stqe_next) == NULL) (head)->stqh_last = &(elm)->field.stqe_next; (listelm)->field.stqe_next = (elm); } while ( 0)"
.LASF256:
	.string	"linux 1"
.LASF182:
	.string	"__DEC64_MIN_EXP__ (-382)"
.LASF1219:
	.string	"TEE_PANIC_ID_TEE_INVOKETACOMMAND 0x00000402"
.LASF870:
	.string	"OPTEE_MSG_RPC_CMD_SUSPEND 5"
.LASF717:
	.string	"DEFINE_U32_REG_READWRITE_FUNCS(reg) DEFINE_U32_REG_READ_FUNC(reg) DEFINE_U32_REG_WRITE_FUNC(reg)"
.LASF1221:
	.string	"TEE_PANIC_ID_TEE_GETCANCELLATIONFLAG 0x00000501"
.LASF889:
	.string	"LIST_FOREACH(var,head,field) for ((var) = ((head)->lh_first); (var); (var) = ((var)->field.le_next))"
.LASF329:
	.string	"CFG_RESERVED_VASPACE_SIZE (1024 * 1024 * 10)"
.LASF980:
	.string	"KERNEL_WAIT_QUEUE_H "
.LASF1428:
	.string	"TEE_MM_POOL_NO_FLAGS 0"
.LASF252:
	.string	"__ARM_FEATURE_QRDMX"
.LASF481:
	.string	"UINTMAX_MAX UINT64_MAX"
.LASF1267:
	.string	"TEE_PANIC_ID_TEE_RESETOPERATION 0x00000C05"
.LASF806:
	.string	"PRIX64 __PRI64_PREFIX \"X\""
.LASF379:
	.string	"KERNEL_THREAD_H "
.LASF1404:
	.string	"FMSG(...) (void)0"
.LASF727:
	.string	"_T_PTRDIFF_ "
.LASF161:
	.string	"__LDBL_DIG__ 33"
.LASF507:
	.string	"TO_STR(x) _TO_STR(x)"
.LASF1243:
	.string	"TEE_PANIC_ID_TEE_GENERATEKEY 0x00000804"
.LASF1650:
	.string	"thread_user_vfp_state"
.LASF846:
	.string	"OPTEE_MSG_UID_1 0xe7f811e3"
.LASF337:
	.string	"CFG_TA_BIGNUM_MAX_BITS 2048"
.LASF1184:
	.string	"TEE_ATTR_DH_X_BITS 0xF0001332"
.LASF1268:
	.string	"TEE_PANIC_ID_TEE_SETOPERATIONKEY 0x00000C06"
.LASF470:
	.string	"INT_FAST32_MAX INT32_MAX"
.LASF267:
	.string	"CFG_ARM64_ta_arm64 1"
.LASF909:
	.string	"STAILQ_INIT(head) do { (head)->stqh_first = NULL; (head)->stqh_last = &(head)->stqh_first; } while ( 0)"
.LASF972:
	.string	"CIRCLEQ_FOREACH_REVERSE(var,head,field) for ((var) = ((head)->cqh_last); (var) != (const void *)(head); (var) = ((var)->field.cqe_prev))"
.LASF1614:
	.string	"panicked"
.LASF613:
	.string	"SPSR_64_MODE_EL0 0x0"
.LASF1700:
	.string	"stack_tmp_export"
.LASF661:
	.string	"ESR_EC_AARCH32_CP10_ID 0x08"
.LASF1523:
	.string	"THREAD_CLF_FIQ (1 << THREAD_CLF_FIQ_SHIFT)"
.LASF158:
	.string	"__DBL_HAS_INFINITY__ 1"
.LASF124:
	.string	"__UINT_FAST64_MAX__ 0xffffffffffffffffUL"
.LASF538:
	.string	"CORTEX_A73_PART_NUM 0xD09"
.LASF265:
	.string	"CFG_AES_GCM_TABLE_BASED 1"
.LASF255:
	.string	"__linux__ 1"
.LASF1518:
	.string	"THREAD_CLF_IRQ_SHIFT 2"
.LASF892:
	.string	"LIST_NEXT(elm,field) ((elm)->field.le_next)"
.LASF1186:
	.string	"TEE_ATTR_DH_PRIVATE_VALUE 0xC0000232"
.LASF1207:
	.string	"TEE_PANIC_ID_TEE_GETNEXTPROPERTY 0x00000203"
.LASF77:
	.string	"__SHRT_MAX__ 0x7fff"
.LASF266:
	.string	"CFG_ARM64_core 1"
.LASF1092:
	.string	"TEE_ALG_DES_ECB_NOPAD 0x10000011"
.LASF71:
	.string	"__INTPTR_TYPE__ long int"
.LASF754:
	.string	"__wchar_t__ "
.LASF1394:
	.string	"TRACE_FLOW 4"
.LASF346:
	.string	"CFG_TEE_CORE_LOG_LEVEL 3"
.LASF15:
	.string	"__ATOMIC_ACQ_REL 4"
.LASF307:
	.string	"CFG_DYN_SHM_CAP 1"
.LASF446:
	.string	"INT32_MAX 0x7fffffff"
.LASF1641:
	.string	"fiq_entry"
.LASF1009:
	.string	"TEE_ERROR_BAD_PARAMETERS 0xFFFF0006"
.LASF58:
	.string	"__INT_LEAST64_TYPE__ long int"
.LASF95:
	.string	"__INT32_MAX__ 0x7fffffff"
.LASF1264:
	.string	"TEE_PANIC_ID_TEE_COPYOPERATION 0x00000C02"
.LASF1066:
	.string	"TEE_USAGE_SIGN 0x00000010"
.LASF7:
	.string	"__GNUC_PATCHLEVEL__ 1"
.LASF716:
	.string	"DEFINE_U32_REG_WRITE_FUNC(reg) DEFINE_REG_WRITE_FUNC_(reg, uint32_t, reg)"
.LASF641:
	.string	"TCR_SH1_SHIFT 28"
.LASF204:
	.string	"__GCC_ATOMIC_CHAR_LOCK_FREE 2"
.LASF1129:
	.string	"TEE_ALG_MD5SHA1 0x5000000F"
.LASF313:
	.string	"CFG_KERN_LINKER_ARCH aarch64"
.LASF1644:
	.string	"thread_specific_data"
.LASF69:
	.string	"__UINT_FAST32_TYPE__ long unsigned int"
.LASF1123:
	.string	"TEE_ALG_MD5 0x50000001"
.LASF237:
	.string	"__AARCH64EL__ 1"
.LASF22:
	.string	"__SIZEOF_INT__ 4"
.LASF188:
	.string	"__DEC128_MANT_DIG__ 34"
.LASF1659:
	.string	"_tee_mm_entry_t"
.LASF355:
	.string	"CFG_TZDRAM_SIZE 0x00f00000"
.LASF714:
	.string	"DEFINE_REG_WRITE_FUNC_(reg,type,asmreg) static inline void write_ ##reg(type val) { asm volatile(\"msr \" #asmreg \", %0\" : : \"r\" (val)); }"
.LASF1023:
	.string	"TEE_ERROR_STORAGE_NO_SPACE 0xFFFF3041"
.LASF1599:
	.string	"tee_ta_session"
.LASF46:
	.string	"__SIG_ATOMIC_TYPE__ int"
.LASF747:
	.string	"_BSD_SIZE_T_DEFINED_ "
.LASF31:
	.string	"__BIGGEST_ALIGNMENT__ 16"
.LASF1636:
	.string	"fast_smc_entry"
.LASF1214:
	.string	"TEE_PANIC_ID_TEE_GETPROPERTYNAME 0x0000020A"
.LASF1589:
	.string	"USER_TA_PROP_TYPE_STRING"
.LASF86:
	.string	"__SIZE_MAX__ 0xffffffffffffffffUL"
.LASF1638:
	.string	"cpu_off_entry"
.LASF686:
	.string	"ESR_FSC_SIZE_L1 0x01"
.LASF215:
	.string	"__PRAGMA_REDEFINE_EXTNAME 1"
.LASF1008:
	.string	"TEE_ERROR_BAD_FORMAT 0xFFFF0005"
.LASF530:
	.string	"MIDR_IMPLEMENTER_ARM 0x41"
.LASF1110:
	.string	"TEE_ALG_RSASSA_PKCS1_PSS_MGF1_SHA384 0x70515930"
.LASF1328:
	.string	"TEE_PARAM_TYPES(t0,t1,t2,t3) ((t0) | ((t1) << 4) | ((t2) << 8) | ((t3) << 12))"
.LASF765:
	.string	"___int_wchar_t_h "
.LASF961:
	.string	"QUEUEDEBUG_CIRCLEQ_POSTREMOVE(elm,field) "
.LASF291:
	.string	"CFG_CRYPTO_ECC 1"
.LASF694:
	.string	"ESR_FSC_ACCF_L2 0x0a"
.LASF1408:
	.string	"DHEXDUMP(buf,len) dhex_dump(__func__, __LINE__, TRACE_DEBUG, buf, len)"
.LASF72:
	.string	"__UINTPTR_TYPE__ long unsigned int"
.LASF155:
	.string	"__DBL_EPSILON__ ((double)2.22044604925031308084726333618164062e-16L)"
.LASF898:
	.string	"SLIST_INSERT_HEAD(head,elm,field) do { (elm)->field.sle_next = (head)->slh_first; (head)->slh_first = (elm); } while ( 0)"
.LASF1077:
	.string	"TEE_OPERATION_ASYMMETRIC_CIPHER 6"
.LASF1594:
	.string	"__malloc_spinlock"
.LASF685:
	.string	"ESR_FSC_SIZE_L0 0x00"
.LASF885:
	.ascii	"LIST_INSERT_AFTER(listelm,elm,field) do { QUEUE"
	.string	"DEBUG_LIST_OP((listelm), field) if (((elm)->field.le_next = (listelm)->field.le_next) != NULL) (listelm)->field.le_next->field.le_prev = &(elm)->field.le_next; (listelm)->field.le_next = (elm); (elm)->field.le_prev = &(listelm)->field.le_next; } while ( 0)"
.LASF1603:
	.string	"cancel_mask"
.LASF693:
	.string	"ESR_FSC_ACCF_L1 0x09"
.LASF540:
	.string	"MPIDR_CPU_MASK 0xff"
.LASF51:
	.string	"__UINT8_TYPE__ unsigned char"
.LASF1487:
	.string	"CORE_MMU_PGDIR_SIZE (1 << CORE_MMU_PGDIR_SHIFT)"
.LASF1162:
	.string	"TEE_TYPE_ECDH_PUBLIC_KEY 0xA0000042"
.LASF367:
	.string	"PLATFORM_vexpress 1"
.LASF596:
	.string	"DAIF_F_SHIFT 6"
.LASF1291:
	.string	"TEE_PANIC_ID_TEE_GETREETIME 0x00001401"
.LASF1324:
	.string	"TEE_PANIC_ID_TEE_BIGINTRELATIVEPRIME 0x00001B03"
.LASF1632:
	.string	"tee_ta_mutex"
.LASF992:
	.string	"TEE_TA_MANAGER_H "
.LASF834:
	.string	"OPTEE_MSG_ATTR_CACHE_SHIFT 16"
.LASF935:
	.string	"TAILQ_HEAD_INITIALIZER(head) { NULL, &(head).tqh_first }"
.LASF946:
	.ascii	"TAILQ_INSERT_AFTER(head,listelm,elm,field) do { QUEUEDEBUG_T"
	.ascii	"AILQ_OP((listelm), field) if (((elm)->field.tq"
	.string	"e_next = (listelm)->field.tqe_next) != NULL) (elm)->field.tqe_next->field.tqe_prev = &(elm)->field.tqe_next; else (head)->tqh_last = &(elm)->field.tqe_next; (listelm)->field.tqe_next = (elm); (elm)->field.tqe_prev = &(listelm)->field.tqe_next; } while ( 0)"
.LASF867:
	.string	"OPTEE_MSG_RPC_CMD_WAIT_QUEUE 4"
.LASF3:
	.string	"__STDC_UTF_32__ 1"
.LASF103:
	.string	"__INT_LEAST16_MAX__ 0x7fff"
.LASF1010:
	.string	"TEE_ERROR_BAD_STATE 0xFFFF0007"
.LASF1222:
	.string	"TEE_PANIC_ID_TEE_MASKCANCELLATION 0x00000502"
.LASF330:
	.string	"CFG_RPMB_FS_DEV_ID 0"
.LASF343:
	.string	"CFG_TEE_API_VERSION GPD-1.1-dev"
.LASF526:
	.string	"MIDR_PRIMARY_PART_NUM_MASK (BIT(MIDR_PRIMARY_PART_NUM_WIDTH) - 1)"
.LASF708:
	.string	"PAR_PA_SHIFT 12"
.LASF1576:
	.string	"size"
.LASF907:
	.string	"STAILQ_HEAD_INITIALIZER(head) { NULL, &(head).stqh_first }"
.LASF981:
	.string	"WAIT_QUEUE_INITIALIZER { .slh_first = NULL }"
.LASF1606:
	.string	"ref_count"
.LASF290:
	.string	"CFG_CRYPTO_ECB 1"
.LASF492:
	.string	"INTMAX_C(v) INT64_C(v)"
.LASF52:
	.string	"__UINT16_TYPE__ short unsigned int"
.LASF238:
	.string	"__ARM_FEATURE_FMA"
.LASF1276:
	.string	"TEE_PANIC_ID_TEE_MACCOMPAREFINAL 0x00000F01"
.LASF1570:
	.string	"clockSeqAndNode"
.LASF1497:
	.string	"CORE_MMU_USER_PARAM_MASK (CORE_MMU_USER_PARAM_SIZE - 1)"
.LASF285:
	.string	"CFG_CRYPTO_CTR 1"
.LASF424:
	.string	"LLONG_MIN (-LLONG_MAX - 1LL)"
.LASF1627:
	.string	"enter_close_session"
.LASF740:
	.string	"_T_SIZE_ "
.LASF1355:
	.string	"TA_FLAG_SECURE_DATA_PATH (1 << 5)"
.LASF974:
	.string	"CIRCLEQ_FIRST(head) ((head)->cqh_first)"
.LASF325:
	.string	"CFG_PM_DEBUG 0"
.LASF102:
	.string	"__INT8_C(c) c"
.LASF793:
	.string	"PRIu8 \"u\""
.LASF567:
	.string	"ARM32_CPSR_T (1 << 5)"
.LASF1527:
	.string	"long int"
.LASF700:
	.string	"ESR_ABT_WNR BIT32(6)"
.LASF1021:
	.string	"TEE_ERROR_OVERFLOW 0xFFFF300F"
.LASF1654:
	.string	"thread_smc_handler_t"
.LASF100:
	.string	"__UINT64_MAX__ 0xffffffffffffffffUL"
.LASF1130:
	.string	"TEE_ALG_HMAC_MD5 0x30000001"
.LASF459:
	.string	"INT_LEAST64_MAX INT64_MAX"
.LASF1024:
	.string	"TEE_ERROR_MAC_INVALID 0xFFFF3071"
.LASF1504:
	.string	"__register_memory2_ul(_name,_type,_addr,_size,_section,_id) __register_memory2(_name, _type, _addr, _size, _section, _id)"
.LASF884:
	.string	"LIST_INIT(head) do { (head)->lh_first = NULL; } while ( 0)"
.LASF1191:
	.string	"TEE_ATTR_ECC_PRIVATE_VALUE 0xC0000341"
.LASF923:
	.string	"SIMPLEQ_INIT(head) do { (head)->sqh_first = NULL; (head)->sqh_last = &(head)->sqh_first; } while ( 0)"
.LASF1691:
	.string	"regs"
.LASF1362:
	.string	"TA_PROP_STR_SINGLE_INSTANCE \"gpd.ta.singleInstance\""
.LASF1502:
	.string	"MEM_AREA_TEE_RAM_RW_DATA MEM_AREA_TEE_RAM_RW"
.LASF985:
	.string	"MUTEX_INITIALIZER { .owner_id = MUTEX_OWNER_ID_NONE, .wq = WAIT_QUEUE_INITIALIZER, }"
.LASF1290:
	.string	"TEE_PANIC_ID_TEE_GENERATERANDOM 0x00001301"
.LASF1229:
	.string	"TEE_PANIC_ID_TEE_MEMFILL 0x00000606"
.LASF811:
	.string	"false 0"
.LASF1440:
	.string	"TEE_MATTR_PRWX (TEE_MATTR_PRW | TEE_MATTR_PX)"
.LASF1699:
	.string	"mutexes"
.LASF821:
	.string	"OPTEE_MSG_ATTR_TYPE_NONE 0x0"
.LASF10:
	.string	"__LINARO_SPIN__ 0"
.LASF1688:
	.string	"sec_lazy_saved"
.LASF750:
	.string	"_GCC_SIZE_T "
.LASF1389:
	.string	"TRACE_LEVELS_H "
.LASF1422:
	.string	"FPRINT_STACK() (void)0"
.LASF1224:
	.string	"TEE_PANIC_ID_TEE_CHECKMEMORYACCESSRIGHTS 0x00000601"
.LASF1044:
	.string	"TEE_ORIGIN_TEE 0x00000003"
.LASF988:
	.string	"VFP_NUM_REGS 32"
.LASF525:
	.string	"MIDR_PRIMARY_PART_NUM_WIDTH 12"
.LASF1622:
	.string	"tee_ta_param"
.LASF1094:
	.string	"TEE_ALG_DES_CBC_MAC_NOPAD 0x30000111"
.LASF527:
	.string	"MIDR_IMPLEMENTER_SHIFT 24"
.LASF1580:
	.string	"seconds"
.LASF147:
	.string	"__DBL_DIG__ 15"
.LASF1070:
	.string	"TEE_HANDLE_FLAG_INITIALIZED 0x00020000"
.LASF1557:
	.string	"mutex_head"
.LASF1392:
	.string	"TRACE_INFO 2"
.LASF88:
	.string	"__INTMAX_C(c) c ## L"
.LASF976:
	.string	"CIRCLEQ_NEXT(elm,field) ((elm)->field.cqe_next)"
.LASF647:
	.string	"TCR_XRGNX_WT 0x2"
.LASF735:
	.string	"__need_ptrdiff_t"
.LASF305:
	.string	"CFG_DT 1"
.LASF682:
	.string	"ESR_EC_AARCH32_BKPT 0x38"
.LASF797:
	.string	"PRIuPTR __PRIPTR_PREFIX \"u\""
.LASF1381:
	.string	"THREAD_EXCP_ALL (THREAD_EXCP_FOREIGN_INTR | THREAD_EXCP_NATIVE_INTR | (ARM32_CPSR_A >> ARM32_CPSR_F_SHIFT))"
.LASF1280:
	.string	"TEE_PANIC_ID_TEE_AEDECRYPTFINAL 0x00001001"
.LASF1252:
	.string	"TEE_PANIC_ID_TEE_RENAMEPERSISTENTOBJECT 0x00000904"
.LASF128:
	.string	"__GCC_IEC_559_COMPLEX 0"
.LASF1447:
	.string	"TEE_MATTR_PROT_MASK (TEE_MATTR_PRWX | TEE_MATTR_URWX)"
.LASF1114:
	.string	"TEE_ALG_RSAES_PKCS1_OAEP_MGF1_SHA224 0x60310230"
.LASF1301:
	.string	"TEE_PANIC_ID_TEE_BIGINTCONVERTFROMOCTETSTRING 0x00001701"
.LASF1333:
	.string	"TEE_MEM_INPUT 0x00000001"
.LASF1363:
	.string	"TA_PROP_STR_MULTI_SESSION \"gpd.ta.multiSession\""
.LASF1379:
	.string	"THREAD_EXCP_FOREIGN_INTR (ARM32_CPSR_I >> ARM32_CPSR_F_SHIFT)"
.LASF1169:
	.string	"TEE_ATTR_RSA_PUBLIC_EXPONENT 0xD0000230"
.LASF1573:
	.string	"uuid"
.LASF415:
	.string	"LIMITS_H "
.LASF1059:
	.string	"TEE_DATA_FLAG_OVERWRITE 0x00000400"
.LASF196:
	.string	"__USER_LABEL_PREFIX__ "
.LASF824:
	.string	"OPTEE_MSG_ATTR_TYPE_VALUE_INOUT 0x3"
.LASF640:
	.string	"TCR_ORGN1_SHIFT 26"
.LASF1550:
	.string	"condvar"
.LASF748:
	.string	"_SIZE_T_DECLARED "
.LASF1250:
	.string	"TEE_PANIC_ID_TEE_CREATEPERSISTENTOBJECT 0x00000902"
.LASF1341:
	.string	"TEE_COMMON_H "
.LASF1663:
	.string	"_tee_mm_pool_t"
.LASF1163:
	.string	"TEE_TYPE_ECDH_KEYPAIR 0xA1000042"
.LASF636:
	.string	"TCR_T1SZ_SHIFT 16"
.LASF1138:
	.string	"TEE_ALG_ECDSA_P256 0x70003041"
.LASF1686:
	.string	"ns_saved"
.LASF562:
	.string	"ARM32_CPSR_MODE_SVC 0x13"
.LASF600:
	.string	"DAIF_D BIT32(9)"
.LASF1256:
	.string	"TEE_PANIC_ID_TEE_GETNEXTPERSISTENTOBJECT 0x00000A03"
.LASF990:
	.string	"PGT_SIZE (4 * 1024)"
.LASF1620:
	.string	"mobj"
.LASF1652:
	.string	"saved"
.LASF202:
	.string	"__GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 1"
.LASF1231:
	.string	"TEE_PANIC_ID_TEE_REALLOC 0x00000608"
.LASF756:
	.string	"_WCHAR_T "
.LASF1668:
	.string	"tee_mm_entry_t"
.LASF365:
	.string	"PLATFORM_FLAVOR qemu_armv8a"
.LASF684:
	.string	"ESR_FSC_MASK 0x3f"
.LASF1235:
	.string	"TEE_PANIC_ID_TEE_GETOBJECTINFO 0x00000703"
.LASF130:
	.string	"__DEC_EVAL_METHOD__ 2"
.LASF1318:
	.string	"TEE_PANIC_ID_TEE_BIGINTMOD 0x00001A03"
.LASF534:
	.string	"CORTEX_A15_PART_NUM 0xC0F"
.LASF1302:
	.string	"TEE_PANIC_ID_TEE_BIGINTCONVERTFROMS32 0x00001702"
.LASF511:
	.string	"container_of(ptr,type,member) (__extension__({ const typeof(((type *)0)->member) *__ptr = (ptr); (type *)((unsigned long)(__ptr) - offsetof(type, member)); }))"
.LASF1597:
	.string	"ta_param_types"
.LASF1125:
	.string	"TEE_ALG_SHA224 0x50000003"
.LASF1016:
	.string	"TEE_ERROR_BUSY 0xFFFF000D"
.LASF1593:
	.string	"type"
.LASF1480:
	.string	"CONSOLE_BAUDRATE UART_BAUDRATE"
.LASF1069:
	.string	"TEE_HANDLE_FLAG_PERSISTENT 0x00010000"
.LASF1323:
	.string	"TEE_PANIC_ID_TEE_BIGINTISPROBABLEPRIME 0x00001B02"
.LASF166:
	.string	"__DECIMAL_DIG__ 36"
.LASF1610:
	.string	"unlink"
.LASF149:
	.string	"__DBL_MIN_10_EXP__ (-307)"
.LASF1013:
	.string	"TEE_ERROR_NOT_SUPPORTED 0xFFFF000A"
.LASF321:
	.string	"CFG_OPTEE_REVISION_MAJOR 3"
.LASF1269:
	.string	"TEE_PANIC_ID_TEE_SETOPERATIONKEY2 0x00000C07"
.LASF376:
	.string	"GEN_ASM_DEFINES_H "
.LASF442:
	.string	"INT32_MIN (-0x7fffffff-1)"
.LASF363:
	.string	"CFG_WITH_USER_TA 1"
.LASF135:
	.string	"__FLT_MIN_10_EXP__ (-37)"
.LASF932:
	.string	"SIMPLEQ_NEXT(elm,field) ((elm)->field.sqe_next)"
.LASF572:
	.string	"ARM32_CPSR_E (1 << 9)"
.LASF882:
	.string	"QUEUEDEBUG_LIST_OP(elm,field) "
.LASF416:
	.string	"CHAR_BIT __CHAR_BIT__"
.LASF120:
	.string	"__INT_FAST64_MAX__ 0x7fffffffffffffffL"
.LASF1675:
	.string	"core_mmu_user_map"
.LASF719:
	.string	"DEFINE_U64_REG_WRITE_FUNC(reg) DEFINE_REG_WRITE_FUNC_(reg, uint64_t, reg)"
.LASF1087:
	.string	"TEE_ALG_AES_CBC_MAC_NOPAD 0x30000110"
.LASF766:
	.string	"__INT_WCHAR_T_H "
.LASF1271:
	.string	"TEE_PANIC_ID_TEE_DIGESTDOFINAL 0x00000D01"
.LASF179:
	.string	"__DEC32_EPSILON__ 1E-6DF"
.LASF338:
	.string	"CFG_TA_DYNLINK 1"
.LASF1359:
	.string	"TA_FLAGS_MASK GENMASK_32(8, 2)"
.LASF336:
	.string	"CFG_SHMEM_START 0x42000000"
.LASF125:
	.string	"__INTPTR_MAX__ 0x7fffffffffffffffL"
.LASF1095:
	.string	"TEE_ALG_DES_CBC_MAC_PKCS5 0x30000511"
.LASF668:
	.string	"ESR_EC_IABT_EL1 0x21"
.LASF354:
	.string	"CFG_TEE_TA_LOG_LEVEL 1"
.LASF1139:
	.string	"TEE_ALG_ECDSA_P384 0x70004041"
.LASF561:
	.string	"ARM32_CPSR_MODE_IRQ 0x12"
.LASF83:
	.string	"__WINT_MAX__ 0xffffffffU"
.LASF1702:
	.string	"threads"
.LASF1040:
	.string	"TEE_LOGIN_APPLICATION_GROUP 0x00000006"
.LASF1212:
	.string	"TEE_PANIC_ID_TEE_GETPROPERTYASU32 0x00000208"
.LASF332:
	.string	"CFG_SECSTOR_TA 1"
.LASF1608:
	.string	"lock_cv"
.LASF1501:
	.string	"TEE_TEXT_VA_START (TEE_RAM_VA_START + (TEE_LOAD_ADDR - TEE_RAM_START))"
.LASF1015:
	.string	"TEE_ERROR_OUT_OF_MEMORY 0xFFFF000C"
.LASF1091:
	.string	"TEE_ALG_AES_GCM 0x40000810"
.LASF1241:
	.string	"TEE_PANIC_ID_TEE_COPYOBJECTATTRIBUTES 0x00000802"
.LASF212:
	.string	"__GCC_ATOMIC_TEST_AND_SET_TRUEVAL 1"
.LASF1373:
	.string	"NSAPP_IDENTITY (NULL)"
.LASF777:
	.string	"__PRIPTR_PREFIX \"l\""
.LASF959:
	.string	"QUEUEDEBUG_CIRCLEQ_HEAD(head,field) "
.LASF1356:
	.string	"TA_FLAG_REMAP_SUPPORT (1 << 6)"
.LASF1347:
	.string	"tee_mtime_init() do { } while (0)"
.LASF110:
	.string	"__UINT8_C(c) c"
.LASF1689:
	.string	"uvfp"
.LASF1189:
	.string	"TEE_ATTR_ECC_PUBLIC_VALUE_X 0xD0000141"
.LASF1317:
	.string	"TEE_PANIC_ID_TEE_BIGINTINVMOD 0x00001A02"
.LASF1410:
	.string	"MSG_RAW(...) trace_printf_helper_raw(0, false, __VA_ARGS__)"
.LASF242:
	.string	"__ARM_FEATURE_NUMERIC_MAXMIN"
.LASF225:
	.string	"__ARM_ARCH_8A 1"
.LASF603:
	.string	"SPSR_MODE_RW_MASK 0x1"
.LASF590:
	.string	"TTBR_ASID_SHIFT 48"
.LASF853:
	.string	"OPTEE_MSG_OS_OPTEE_UUID_0 0x486178e0"
.LASF1498:
	.string	"CORE_MMU_L1_TBL_OFFSET (CFG_TEE_CORE_NB_CORE * 4 * 8)"
.LASF1439:
	.string	"TEE_MATTR_PRX (TEE_MATTR_PR | TEE_MATTR_PX)"
.LASF465:
	.string	"INT_FAST16_MIN INT16_MIN"
.LASF42:
	.string	"__INTMAX_TYPE__ long int"
.LASF1053:
	.string	"TEE_STORAGE_PRIVATE 0x00000001"
.LASF361:
	.string	"CFG_WITH_STACK_CANARIES 1"
.LASF466:
	.string	"INT_FAST32_MIN INT32_MIN"
.LASF1144:
	.string	"TEE_ALG_ECDH_P384 0x80004042"
.LASF744:
	.string	"_BSD_SIZE_T_ "
.LASF711:
	.string	"TLBI_ASID_SHIFT 48"
.LASF1528:
	.string	"unsigned char"
.LASF842:
	.string	"OPTEE_MSG_LOGIN_APPLICATION_GROUP 0x00000006"
.LASF1227:
	.string	"TEE_PANIC_ID_TEE_MALLOC 0x00000604"
.LASF1462:
	.string	"TEE_MMU_UMAP_MAX_ENTRIES (TEE_MMU_UMAP_PARAM_IDX + TEE_NUM_PARAMS)"
.LASF286:
	.string	"CFG_CRYPTO_CTS 1"
.LASF584:
	.string	"SCTLR_A BIT32(1)"
.LASF1274:
	.string	"TEE_PANIC_ID_TEE_CIPHERINIT 0x00000E02"
.LASF32:
	.string	"__ORDER_LITTLE_ENDIAN__ 1234"
.LASF734:
	.string	"_PTRDIFF_T_DECLARED "
.LASF978:
	.string	"CIRCLEQ_LOOP_NEXT(head,elm,field) (((elm)->field.cqe_next == (void *)(head)) ? ((head)->cqh_first) : (elm->field.cqe_next))"
.LASF1474:
	.string	"TEE_SDP_TEST_MEM_SIZE 0"
.LASF703:
	.string	"CPACR_EL1_FPEN_NONE 0x0"
.LASF982:
	.string	"MUTEX_OWNER_ID_NONE -1"
.LASF718:
	.string	"DEFINE_U64_REG_READ_FUNC(reg) DEFINE_REG_READ_FUNC_(reg, uint64_t, reg)"
.LASF1027:
	.string	"TEE_ERROR_TIME_NEEDS_RESET 0xFFFF5001"
.LASF1513:
	.string	"THREAD_CLF_SAVED_SHIFT 4"
.LASF919:
	.string	"STAILQ_NEXT(elm,field) ((elm)->field.stqe_next)"
.LASF628:
	.string	"SPSR_32_MODE_USR 0x0"
.LASF133:
	.string	"__FLT_DIG__ 6"
.LASF1320:
	.string	"TEE_PANIC_ID_TEE_BIGINTSQUAREMOD 0x00001A05"
.LASF1432:
	.string	"TEE_MATTR_HIDDEN_BLOCK BIT(1)"
.LASF132:
	.string	"__FLT_MANT_DIG__ 24"
.LASF1309:
	.string	"TEE_PANIC_ID_TEE_BIGINTSHIFTRIGHT 0x00001805"
.LASF150:
	.string	"__DBL_MAX_EXP__ 1024"
.LASF1199:
	.string	"TEE_ECC_CURVE_NIST_P521 0x00000005"
.LASF111:
	.string	"__UINT_LEAST16_MAX__ 0xffff"
.LASF925:
	.string	"SIMPLEQ_INSERT_TAIL(head,elm,field) do { (elm)->field.sqe_next = NULL; *(head)->sqh_last = (elm); (head)->sqh_last = &(elm)->field.sqe_next; } while ( 0)"
.LASF1042:
	.string	"TEE_ORIGIN_API 0x00000001"
.LASF633:
	.string	"TCR_IRGN0_SHIFT 8"
.LASF623:
	.string	"SPSR_32_T_MASK 0x1"
.LASF1400:
	.string	"MSG(...) trace_printf_helper(0, false, __VA_ARGS__)"
.LASF399:
	.string	"__bss __section(\".bss\")"
.LASF91:
	.string	"__SIG_ATOMIC_MAX__ 0x7fffffff"
.LASF484:
	.string	"UINT8_C(v) v"
.LASF333:
	.string	"CFG_SECSTOR_TA_MGMT_PTA 1"
.LASF29:
	.string	"__SIZEOF_SIZE_T__ 8"
.LASF192:
	.string	"__DEC128_MAX__ 9.999999999999999999999999999999999E6144DL"
.LASF317:
	.string	"CFG_LTC_OPTEE_THREAD 1"
.LASF1617:
	.string	"busy_cv"
.LASF377:
	.string	"DEFINES void __defines(void); void __defines(void)"
.LASF726:
	.string	"_PTRDIFF_T "
.LASF1569:
	.string	"timeHiAndVersion"
.LASF264:
	.string	"_out_arm_include_generated_conf_h_ "
.LASF429:
	.string	"SHRT_MIN (-SHRT_MAX - 1)"
.LASF1180:
	.string	"TEE_ATTR_DSA_PRIVATE_VALUE 0xC0000231"
.LASF973:
	.string	"CIRCLEQ_EMPTY(head) ((head)->cqh_first == (void *)(head))"
.LASF258:
	.string	"__unix__ 1"
.LASF1088:
	.string	"TEE_ALG_AES_CBC_MAC_PKCS5 0x30000510"
.LASF1605:
	.string	"user_ctx"
.LASF1411:
	.string	"EMSG_RAW(...) trace_printf_helper_raw(TRACE_ERROR, true, __VA_ARGS__)"
.LASF894:
	.string	"SLIST_HEAD_INITIALIZER(head) { NULL }"
.LASF477:
	.string	"INTPTR_MAX LONG_MAX"
.LASF639:
	.string	"TCR_IRGN1_SHIFT 24"
.LASF445:
	.string	"INT16_MAX 0x7fff"
.LASF1150:
	.string	"TEE_TYPE_HMAC_SHA1 0xA0000002"
.LASF1553:
	.string	"tqe_prev"
.LASF953:
	.string	"TAILQ_CONCAT(head1,head2,field) do { if (!TAILQ_EMPTY(head2)) { *(head1)->tqh_last = (head2)->tqh_first; (head2)->tqh_first->field.tqe_prev = (head1)->tqh_last; (head1)->tqh_last = (head2)->tqh_last; TAILQ_INIT((head2)); } } while ( 0)"
.LASF1548:
	.string	"sle_next"
.LASF689:
	.string	"ESR_FSC_TRANS_L0 0x04"
.LASF916:
	.string	"STAILQ_CONCAT(head1,head2) do { if (!STAILQ_EMPTY((head2))) { *(head1)->stqh_last = (head2)->stqh_first; (head1)->stqh_last = (head2)->stqh_last; STAILQ_INIT((head2)); } } while ( 0)"
.LASF1348:
	.string	"tee_mtime_stamp(descr) do { } while (0)"
.LASF1117:
	.string	"TEE_ALG_RSAES_PKCS1_OAEP_MGF1_SHA512 0x60610230"
.LASF1319:
	.string	"TEE_PANIC_ID_TEE_BIGINTMULMOD 0x00001A04"
.LASF152:
	.string	"__DBL_DECIMAL_DIG__ 17"
.LASF24:
	.string	"__SIZEOF_LONG_LONG__ 8"
.LASF1567:
	.string	"timeLow"
.LASF778:
	.string	"PRId8 \"d\""
.LASF789:
	.string	"PRIo16 \"o\""
.LASF563:
	.string	"ARM32_CPSR_MODE_MON 0x16"
.LASF1299:
	.string	"TEE_PANIC_ID_TEE_BIGINTINITFMM 0x00001602"
.LASF1534:
	.string	"uint64_t"
.LASF1175:
	.string	"TEE_ATTR_RSA_COEFFICIENT 0xC0000830"
.LASF805:
	.string	"PRIX32 \"X\""
.LASF782:
	.string	"PRIdPTR __PRIPTR_PREFIX \"d\""
.LASF1084:
	.string	"TEE_ALG_AES_CTR 0x10000210"
.LASF226:
	.string	"__ARM_ARCH_PROFILE 65"
.LASF609:
	.string	"SPSR_64_MODE_SP_ELX 0x1"
.LASF1298:
	.string	"TEE_PANIC_ID_TEE_BIGINTINIT 0x00001601"
.LASF1039:
	.string	"TEE_LOGIN_APPLICATION_USER 0x00000005"
.LASF1134:
	.string	"TEE_ALG_HMAC_SHA384 0x30000005"
.LASF1194:
	.string	"TEE_ATTR_BIT_VALUE (1 << 29)"
.LASF712:
	.string	"TLBI_ASID_MASK 0xff"
.LASF1515:
	.string	"THREAD_CLF_MASK 0xf"
.LASF1000:
	.string	"TEE_ERROR_CORRUPT_OBJECT_2 0xF0100002"
.LASF831:
	.string	"OPTEE_MSG_ATTR_TYPE_MASK GENMASK_32(7, 0)"
.LASF1233:
	.string	"TEE_PANIC_ID_TEE_CLOSEOBJECT 0x00000701"
.LASF577:
	.string	"CNTKCTL_PL0PCTEN BIT(0)"
.LASF1279:
	.string	"TEE_PANIC_ID_TEE_MACUPDATE 0x00000F04"
.LASF1234:
	.string	"TEE_PANIC_ID_TEE_GETOBJECTBUFFERATTRIBUTE 0x00000702"
.LASF1075:
	.string	"TEE_OPERATION_AE 4"
.LASF986:
	.string	"CONDVAR_INITIALIZER { .m = NULL }"
.LASF1574:
	.string	"TEE_Identity"
.LASF1081:
	.string	"TEE_OPERATION_STATE_ACTIVE 0x00000001"
.LASF118:
	.string	"__INT_FAST16_MAX__ 0x7fffffffffffffffL"
.LASF650:
	.string	"TCR_SHX_OSH 0x2"
.LASF864:
	.string	"OPTEE_MSG_CMD_UNREGISTER_SHM 5"
.LASF1492:
	.string	"CORE_MMU_USER_CODE_SHIFT SMALL_PAGE_SHIFT"
.LASF940:
	.string	"QUEUEDEBUG_TAILQ_OP(elm,field) "
.LASF828:
	.string	"OPTEE_MSG_ATTR_TYPE_TMEM_INPUT 0x9"
.LASF451:
	.string	"UINT64_MAX 0xffffffffffffffffUL"
.LASF792:
	.string	"PRIoPTR __PRIPTR_PREFIX \"o\""
.LASF142:
	.string	"__FLT_DENORM_MIN__ 1.40129846432481707092372958328991613e-45F"
.LASF1423:
	.string	"_PRINT_STACK"
.LASF1133:
	.string	"TEE_ALG_HMAC_SHA256 0x30000004"
.LASF1201:
	.string	"TEE_PANIC_ID_TA_CREATEENTRYPOINT 0x00000102"
.LASF887:
	.ascii	"LIST_INSERT_HEAD(head,el"
	.string	"m,field) do { QUEUEDEBUG_LIST_INSERT_HEAD((head), (elm), field) if (((elm)->field.le_next = (head)->lh_first) != NULL) (head)->lh_first->field.le_prev = &(elm)->field.le_next; (head)->lh_first = (elm); (elm)->field.le_prev = &(head)->lh_first; } while ( 0)"
.LASF533:
	.string	"CORTEX_A9_PART_NUM 0xC09"
.LASF936:
	.string	"_TAILQ_ENTRY(type,qual) struct { qual type *tqe_next; qual type *qual *tqe_prev; }"
.LASF274:
	.string	"CFG_CORE_WORKAROUND_SPECTRE_BP 1"
.LASF1294:
	.string	"TEE_PANIC_ID_TEE_SETTAPERSISTENTTIME 0x00001404"
.LASF1265:
	.string	"TEE_PANIC_ID_TEE_FREEOPERATION 0x00000C03"
.LASF611:
	.string	"SPSR_64_MODE_EL_MASK 0x3"
.LASF819:
	.string	"__SIZEOF_PADDR__ __SIZEOF_POINTER__"
.LASF299:
	.string	"CFG_CRYPTO_SHA224 1"
.LASF1609:
	.string	"lock_thread"
.LASF764:
	.string	"_WCHAR_T_H "
.LASF177:
	.string	"__DEC32_MIN__ 1E-95DF"
.LASF920:
	.string	"SIMPLEQ_HEAD(name,type) struct name { struct type *sqh_first; struct type **sqh_last; }"
.LASF1618:
	.string	"param_val"
.LASF1696:
	.string	"rpc_arg"
.LASF851:
	.string	"OPTEE_MSG_REVISION_MINOR 0"
.LASF35:
	.string	"__BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__"
.LASF1656:
	.string	"thread_pm_handler_t"
.LASF1331:
	.string	"TEE_NUM_PARAMS 4"
.LASF131:
	.string	"__FLT_RADIX__ 2"
.LASF106:
	.string	"__INT32_C(c) c"
.LASF1438:
	.string	"TEE_MATTR_PRW (TEE_MATTR_PR | TEE_MATTR_PW)"
.LASF331:
	.string	"CFG_SCTLR_ALIGNMENT_CHECK 1"
.LASF217:
	.string	"__SIZEOF_WCHAR_T__ 4"
.LASF1459:
	.string	"TEE_MMU_UMAP_CODE_IDX (TEE_MMU_UMAP_STACK_IDX + 1)"
.LASF1637:
	.string	"cpu_on_entry"
.LASF1475:
	.string	"STACK_ALIGNMENT 64"
.LASF455:
	.string	"INT_LEAST64_MIN INT64_MIN"
.LASF1076:
	.string	"TEE_OPERATION_DIGEST 5"
.LASF393:
	.string	"__maybe_unused __attribute__((unused))"
.LASF1397:
	.string	"MAX_PRINT_SIZE 256"
.LASF815:
	.string	"PRIxUA PRIxPTR"
.LASF1479:
	.string	"UART_BAUDRATE 115200"
.LASF1202:
	.string	"TEE_PANIC_ID_TA_DESTROYENTRYPOINT 0x00000103"
.LASF1086:
	.string	"TEE_ALG_AES_XTS 0x10000410"
.LASF190:
	.string	"__DEC128_MAX_EXP__ 6145"
.LASF1559:
	.string	"tqh_last"
.LASF287:
	.string	"CFG_CRYPTO_DES 1"
.LASF1261:
	.string	"TEE_PANIC_ID_TEE_TRUNCATEOBJECTDATA 0x00000B03"
.LASF62:
	.string	"__UINT_LEAST64_TYPE__ long unsigned int"
.LASF1056:
	.string	"TEE_DATA_FLAG_ACCESS_WRITE_META 0x00000004"
.LASF914:
	.ascii	"STAILQ_REMOVE(head,elm,type,field) do { if ((head)->stqh_fir"
	.ascii	"st == (elm)) { STAILQ_REMOVE_HEAD((head), field); } else { s"
	.ascii	"truc"
	.string	"t type *curelm = (head)->stqh_first; while (curelm->field.stqe_next != (elm)) curelm = curelm->field.stqe_next; if ((curelm->field.stqe_next = curelm->field.stqe_next->field.stqe_next) == NULL) (head)->stqh_last = &(curelm)->field.stqe_next; } } while ( 0)"
.LASF878:
	.string	"LIST_HEAD(name,type) struct name { struct type *lh_first; }"
.LASF615:
	.string	"SPSR_64_DAIF_MASK 0xf"
.LASF180:
	.string	"__DEC32_SUBNORMAL_MIN__ 0.000001E-95DF"
.LASF312:
	.string	"CFG_HWSUPP_MEM_PERM_WXN 1"
.LASF1547:
	.string	"link"
.LASF1413:
	.string	"DMSG_RAW(...) trace_printf_helper_raw(TRACE_DEBUG, true, __VA_ARGS__)"
.LASF67:
	.string	"__UINT_FAST8_TYPE__ unsigned char"
.LASF483:
	.string	"INT8_C(v) v"
.LASF541:
	.string	"MPIDR_CLUSTER_SHIFT 8"
.LASF1583:
	.string	"TEE_ErrorOrigin"
.LASF425:
	.string	"MB_LEN_MAX 1"
.LASF1249:
	.string	"TEE_PANIC_ID_TEE_CLOSEANDDELETEPERSISTENTOBJECT 0x00000901"
.LASF54:
	.string	"__UINT64_TYPE__ long unsigned int"
.LASF1665:
	.string	"shift"
.LASF433:
	.string	"ULONG_MAX (LONG_MAX * 2UL + 1UL)"
.LASF289:
	.string	"CFG_CRYPTO_DSA 1"
.LASF1251:
	.string	"TEE_PANIC_ID_TEE_OPENPERSISTENTOBJECT 0x00000903"
.LASF458:
	.string	"INT_LEAST32_MAX INT32_MAX"
.LASF1554:
	.string	"mutex"
.LASF1565:
	.string	"force_save"
.LASF471:
	.string	"INT_FAST64_MAX INT64_MAX"
.LASF1461:
	.string	"TEE_MMU_UMAP_PARAM_IDX (TEE_MMU_UMAP_CODE_IDX + TEE_MMU_UMAP_NUM_CODE_SEGMENTS)"
.LASF1655:
	.string	"thread_nintr_handler_t"
.LASF1028:
	.string	"TEE_PARAM_TYPE_NONE 0"
.LASF1468:
	.string	"TZDRAM_BASE CFG_TZDRAM_START"
.LASF21:
	.string	"__LP64__ 1"
.LASF243:
	.string	"__ARM_NEON"
.LASF1493:
	.string	"CORE_MMU_USER_CODE_SIZE (1 << CORE_MMU_USER_CODE_SHIFT)"
.LASF1253:
	.string	"TEE_PANIC_ID_TEE_CLOSEANDDELETEPERSISTENTOBJECT1 0x00000905"
.LASF496:
	.string	"SIZE_2M UINTPTR_C(0x200000)"
.LASF1647:
	.string	"rpc_fs_payload_mobj"
.LASF104:
	.string	"__INT16_C(c) c"
.LASF82:
	.string	"__WCHAR_MIN__ 0U"
.LASF1030:
	.string	"TEE_PARAM_TYPE_VALUE_OUTPUT 2"
.LASF1182:
	.string	"TEE_ATTR_DH_SUBPRIME 0xD0001132"
.LASF206:
	.string	"__GCC_ATOMIC_CHAR32_T_LOCK_FREE 2"
.LASF586:
	.string	"SCTLR_SA BIT32(3)"
.LASF48:
	.string	"__INT16_TYPE__ short int"
.LASF221:
	.string	"__ARM_64BIT_STATE 1"
.LASF350:
	.string	"CFG_TEE_FW_MANUFACTURER FW_MAN_UNDEF"
.LASF1470:
	.string	"TEE_RAM_START TZDRAM_BASE"
.LASF918:
	.string	"STAILQ_FIRST(head) ((head)->stqh_first)"
.LASF1073:
	.string	"TEE_OPERATION_CIPHER 1"
.LASF1693:
	.string	"hyp_clnt_id"
.LASF61:
	.string	"__UINT_LEAST32_TYPE__ unsigned int"
.LASF674:
	.string	"ESR_EC_AARCH64_FP 0x2c"
.LASF745:
	.string	"_SIZE_T_DEFINED_ "
.LASF1254:
	.string	"TEE_PANIC_ID_TEE_ALLOCATEPERSISTENTOBJECTENUMERATOR 0x00000A01"
.LASF1537:
	.string	"size_t"
.LASF210:
	.string	"__GCC_ATOMIC_LONG_LOCK_FREE 2"
.LASF1607:
	.string	"refc_cv"
.LASF1444:
	.string	"TEE_MATTR_URW (TEE_MATTR_UR | TEE_MATTR_UW)"
.LASF1621:
	.string	"offs"
.LASF1529:
	.string	"uint8_t"
.LASF397:
	.string	"__section(x) __attribute__((section(x)))"
.LASF1420:
	.string	"IPRINT_STACK() print_kernel_stack(TRACE_INFO)"
.LASF510:
	.string	"_CONCAT(x,y) x ##y"
.LASF1629:
	.string	"destroy"
.LASF771:
	.string	"NULL"
.LASF915:
	.string	"STAILQ_FOREACH(var,head,field) for ((var) = ((head)->stqh_first); (var); (var) = ((var)->field.stqe_next))"
.LASF1552:
	.string	"tqe_next"
.LASF968:
	.ascii	"CIRCLEQ_INSERT_HEAD(head,elm,field) do { QUEUEDEBUG_CIRCLEQ_"
	.string	"HEAD((head), field) (elm)->field.cqe_next = (head)->cqh_first; (elm)->field.cqe_prev = (void *)(head); if ((head)->cqh_last == (void *)(head)) (head)->cqh_last = (elm); else (head)->cqh_first->field.cqe_prev = (elm); (head)->cqh_first = (elm); } while ( 0)"
.LASF403:
	.string	"__noprof __attribute__((no_instrument_function))"
.LASF324:
	.string	"CFG_PL011 1"
.LASF595:
	.string	"DAIFBIT_ALL (DAIFBIT_FIQ | DAIFBIT_IRQ | DAIFBIT_ABT | DAIFBIT_DBG)"
.LASF1431:
	.string	"TEE_MATTR_VALID_BLOCK BIT(0)"
.LASF649:
	.string	"TCR_SHX_NSH 0x0"
.LASF1002:
	.string	"TEE_ERROR_STORAGE_NOT_AVAILABLE_2 0xF0100004"
.LASF1611:
	.string	"tee_ta_ctx_head"
.LASF1210:
	.string	"TEE_PANIC_ID_TEE_GETPROPERTYASIDENTITY 0x00000206"
.LASF413:
	.string	"__compiler_atomic_load(p) __atomic_load_n((p), __ATOMIC_RELAXED)"
.LASF1179:
	.string	"TEE_ATTR_DSA_PUBLIC_VALUE 0xD0000131"
.LASF370:
	.string	"_CFG_CRYPTO_WITH_AUTHENC 1"
.LASF1524:
	.string	"THREAD_RPC_NUM_ARGS 6"
.LASF873:
	.string	"OPTEE_MSG_RPC_SHM_TYPE_KERNEL 1"
.LASF1211:
	.string	"TEE_PANIC_ID_TEE_GETPROPERTYASSTRING 0x00000207"
.LASF1452:
	.string	"TEE_MATTR_CACHE_NONCACHE 0"
.LASF767:
	.string	"_GCC_WCHAR_T "
.LASF762:
	.string	"_WCHAR_T_DEFINED_ "
.LASF101:
	.string	"__INT_LEAST8_MAX__ 0x7f"
.LASF749:
	.string	"___int_size_t_h "
.LASF656:
	.string	"ESR_EC_AARCH32_CP15_32 0x03"
.LASF439:
	.string	"__uint32_t_defined "
.LASF1142:
	.string	"TEE_ALG_ECDH_P224 0x80002042"
.LASF1334:
	.string	"TEE_MEM_OUTPUT 0x00000002"
.LASF880:
	.string	"LIST_ENTRY(type) struct { struct type *le_next; struct type **le_prev; }"
.LASF168:
	.string	"__LDBL_MIN__ 3.36210314311209350626267781732175260e-4932L"
.LASF574:
	.string	"ARM32_CPSR_IT_MASK (ARM32_CPSR_IT_MASK1 | ARM32_CPSR_IT_MASK2)"
.LASF1090:
	.string	"TEE_ALG_AES_CCM 0x40000710"
.LASF1460:
	.string	"TEE_MMU_UMAP_NUM_CODE_SEGMENTS 3"
.LASF1137:
	.string	"TEE_ALG_ECDSA_P224 0x70002041"
.LASF352:
	.string	"CFG_TEE_MANUFACTURER LINARO"
.LASF1560:
	.string	"vfp_reg"
.LASF198:
	.string	"__CHAR_UNSIGNED__ 1"
.LASF1255:
	.string	"TEE_PANIC_ID_TEE_FREEPERSISTENTOBJECTENUMERATOR 0x00000A02"
.LASF448:
	.string	"UINT8_MAX 0xff"
.LASF162:
	.string	"__LDBL_MIN_EXP__ (-16381)"
.LASF991:
	.string	"PGT_NUM_PGT_PER_PAGE 1"
.LASF769:
	.string	"_BSD_WCHAR_T_"
.LASF76:
	.string	"__SCHAR_MAX__ 0x7f"
.LASF214:
	.string	"__GCC_HAVE_DWARF2_CFI_ASM 1"
.LASF1436:
	.string	"TEE_MATTR_PW BIT(5)"
.LASF848:
	.string	"OPTEE_MSG_UID_3 0xa5d5c51b"
.LASF967:
	.ascii	"CIRCLEQ_INSERT_BEFORE(head,listelm,elm,field) do { QUEUEDEBU"
	.ascii	"G_CIRCLEQ_HEAD((head), field) QUEUEDEBUG_CIRCLEQ_ELM((head),"
	.ascii	" (listelm), field) (elm)->fi"
	.string	"eld.cqe_next = (listelm); (elm)->field.cqe_prev = (listelm)->field.cqe_prev; if ((listelm)->field.cqe_prev == (void *)(head)) (head)->cqh_first = (elm); else (listelm)->field.cqe_prev->field.cqe_next = (elm); (listelm)->field.cqe_prev = (elm); } while ( 0)"
.LASF357:
	.string	"CFG_UNWIND 1"
.LASF665:
	.string	"ESR_EC_AARCH64_SVC 0x15"
.LASF1132:
	.string	"TEE_ALG_HMAC_SHA224 0x30000003"
.LASF1672:
	.string	"tee_mm_shm"
.LASF1055:
	.string	"TEE_DATA_FLAG_ACCESS_WRITE 0x00000002"
.LASF753:
	.string	"__need_size_t"
.LASF1353:
	.string	"TA_FLAG_MULTI_SESSION (1 << 3)"
.LASF605:
	.string	"SPSR_MODE_RW_32 0x1"
.LASF987:
	.string	"KERNEL_VFP_H "
.LASF886:
	.ascii	"LIST"
	.string	"_INSERT_BEFORE(listelm,elm,field) do { QUEUEDEBUG_LIST_OP((listelm), field) (elm)->field.le_prev = (listelm)->field.le_prev; (elm)->field.le_next = (listelm); *(listelm)->field.le_prev = (elm); (listelm)->field.le_prev = &(elm)->field.le_next; } while ( 0)"
.LASF400:
	.string	"__rodata __section(\".rodata\")"
.LASF94:
	.string	"__INT16_MAX__ 0x7fff"
.LASF419:
	.string	"INT_MAX __INT_MAX__"
.LASF73:
	.string	"__has_include(STR) __has_include__(STR)"
.LASF1176:
	.string	"TEE_ATTR_DSA_PRIME 0xD0001031"
.LASF1671:
	.string	"tee_mm_vcore"
.LASF191:
	.string	"__DEC128_MIN__ 1E-6143DL"
.LASF612:
	.string	"SPSR_64_MODE_EL1 0x1"
.LASF802:
	.string	"PRIxPTR __PRIPTR_PREFIX \"x\""
.LASF384:
	.string	"__packed __attribute__((packed))"
.LASF822:
	.string	"OPTEE_MSG_ATTR_TYPE_VALUE_INPUT 0x1"
.LASF1260:
	.string	"TEE_PANIC_ID_TEE_SEEKOBJECTDATA 0x00000B02"
.LASF181:
	.string	"__DEC64_MANT_DIG__ 16"
.LASF127:
	.string	"__GCC_IEC_559 0"
.LASF801:
	.string	"PRIx64 __PRI64_PREFIX \"x\""
.LASF145:
	.string	"__FLT_HAS_QUIET_NAN__ 1"
.LASF813:
	.string	"UNISTD_H "
.LASF587:
	.string	"SCTLR_I BIT32(12)"
.LASF874:
	.string	"OPTEE_MSG_RPC_CMD_SHM_FREE 7"
.LASF696:
	.string	"ESR_FSC_PERMF_L1 0x0d"
.LASF381:
	.string	"UTIL_H "
.LASF288:
	.string	"CFG_CRYPTO_DH 1"
.LASF1705:
	.string	"thread_cpu_on_handler_ptr"
.LASF348:
	.string	"CFG_TEE_CORE_TA_TRACE 1"
.LASF1701:
	.string	"stack_tmp_stride"
.LASF456:
	.string	"INT_LEAST8_MAX INT8_MAX"
.LASF679:
	.string	"ESR_EC_SOFTSTP_EL1 0x33"
.LASF671:
	.string	"ESR_EC_DABT_EL1 0x25"
.LASF899:
	.string	"SLIST_REMOVE_HEAD(head,field) do { (head)->slh_first = (head)->slh_first->field.sle_next; } while ( 0)"
.LASF1166:
	.string	"TEE_TYPE_DATA 0xA00000BF"
.LASF757:
	.string	"_T_WCHAR_ "
.LASF883:
	.string	"QUEUEDEBUG_LIST_POSTREMOVE(elm,field) "
.LASF632:
	.string	"TCR_EPD0 BIT32(7)"
.LASF1004:
	.string	"TEE_ERROR_ACCESS_DENIED 0xFFFF0001"
.LASF34:
	.string	"__ORDER_PDP_ENDIAN__ 3412"
.LASF263:
	.string	"TRACE_LEVEL 3"
.LASF1601:
	.string	"clnt_id"
.LASF672:
	.string	"ESR_EC_SP_ALIGN 0x26"
.LASF838:
	.string	"OPTEE_MSG_LOGIN_USER 0x00000001"
.LASF1185:
	.string	"TEE_ATTR_DH_PUBLIC_VALUE 0xD0000132"
.LASF1667:
	.string	"max_allocated"
.LASF1442:
	.string	"TEE_MATTR_UW BIT(8)"
.LASF1384:
	.string	"SM_STACK_TMP_RESERVE_SIZE sizeof(struct sm_ctx)"
.LASF1072:
	.string	"TEE_HANDLE_FLAG_EXPECT_TWO_KEYS 0x00080000"
.LASF1311:
	.string	"TEE_PANIC_ID_TEE_BIGINTDIV 0x00001902"
.LASF691:
	.string	"ESR_FSC_TRANS_L2 0x06"
.LASF1049:
	.string	"TEE_MEMORY_ACCESS_READ 0x00000001"
.LASF666:
	.string	"ESR_EC_AARCH64_SYS 0x18"
.LASF999:
	.string	"TEE_ERROR_CORRUPT_OBJECT 0xF0100001"
.LASF1521:
	.string	"THREAD_CLF_ABORT (1 << THREAD_CLF_ABORT_SHIFT)"
.LASF1045:
	.string	"TEE_ORIGIN_TRUSTED_APP 0x00000004"
.LASF678:
	.string	"ESR_EC_SOFTSTP_EL0 0x32"
.LASF670:
	.string	"ESR_EC_DABT_EL0 0x24"
.LASF1402:
	.string	"IMSG(...) trace_printf_helper(TRACE_INFO, true, __VA_ARGS__)"
.LASF787:
	.string	"PRIiPTR __PRIPTR_PREFIX \"i\""
.LASF351:
	.string	"CFG_TEE_IMPL_DESCR OPTEE"
.LASF634:
	.string	"TCR_ORGN0_SHIFT 10"
.LASF485:
	.string	"INT16_C(v) v"
.LASF1237:
	.string	"TEE_PANIC_ID_TEE_RESTRICTOBJECTUSAGE 0x00000705"
.LASF107:
	.string	"__INT_LEAST64_MAX__ 0x7fffffffffffffffL"
.LASF359:
	.string	"CFG_WITH_LPAE 1"
.LASF1064:
	.string	"TEE_USAGE_DECRYPT 0x00000004"
.LASF1065:
	.string	"TEE_USAGE_MAC 0x00000008"
.LASF852:
	.string	"OPTEE_MSG_FUNCID_CALLS_REVISION 0xFF03"
.LASF1578:
	.string	"value"
.LASF662:
	.string	"ESR_EC_AARCH32_CP14_64 0x0c"
.LASF1349:
	.string	"tee_mtime_report() do { } while (0)"
.LASF619:
	.string	"SPSR_32_E_MASK 0x1"
.LASF220:
	.string	"__aarch64__ 1"
.LASF491:
	.string	"UINTPTR_C(v) v ## LU"
.LASF11:
	.string	"__ATOMIC_RELAXED 0"
.LASF631:
	.string	"TCR_T0SZ_SHIFT 0"
.LASF1472:
	.string	"TA_RAM_START ROUNDUP(TZDRAM_BASE + TEE_RAM_VA_SIZE, CORE_MMU_PGDIR_SIZE)"
.LASF89:
	.string	"__UINTMAX_MAX__ 0xffffffffffffffffUL"
.LASF395:
	.string	"__must_check __attribute__((warn_unused_result))"
.LASF1450:
	.string	"TEE_MATTR_CACHE_MASK 0x7"
.LASF1043:
	.string	"TEE_ORIGIN_COMMS 0x00000002"
.LASF1367:
	.string	"TA_PROP_STR_VERSION \"gpd.ta.version\""
.LASF1625:
	.string	"enter_open_session"
.LASF917:
	.string	"STAILQ_EMPTY(head) ((head)->stqh_first == NULL)"
.LASF1509:
	.string	"register_sdp_mem(addr,size) static int CONCAT(__register_sdp_mem_unused, __COUNTER__) __unused"
.LASF383:
	.string	"__deprecated __attribute__((deprecated))"
.LASF441:
	.string	"INT16_MIN (-0x7fff-1)"
.LASF945:
	.string	"TAILQ_INSERT_TAIL(head,elm,field) do { QUEUEDEBUG_TAILQ_INSERT_TAIL((head), (elm), field) (elm)->field.tqe_next = NULL; (elm)->field.tqe_prev = (head)->tqh_last; *(head)->tqh_last = (elm); (head)->tqh_last = &(elm)->field.tqe_next; } while ( 0)"
.LASF156:
	.string	"__DBL_DENORM_MIN__ ((double)4.94065645841246544176568792868221372e-324L)"
.LASF519:
	.string	"GENMASK_64(h,l) (((~UINT64_C(0)) << (l)) & (~UINT64_C(0) >> (64 - 1 - (h))))"
.LASF556:
	.string	"CTR_IMINLINE_SHIFT 0"
.LASF667:
	.string	"ESR_EC_IABT_EL0 0x20"
.LASF476:
	.string	"INTPTR_MIN LONG_MIN"
.LASF947:
	.ascii	"TAILQ_INSERT"
	.string	"_BEFORE(listelm,elm,field) do { QUEUEDEBUG_TAILQ_OP((listelm), field) (elm)->field.tqe_prev = (listelm)->field.tqe_prev; (elm)->field.tqe_next = (listelm); *(listelm)->field.tqe_prev = (elm); (listelm)->field.tqe_prev = &(elm)->field.tqe_next; } while ( 0)"
.LASF1692:
	.string	"stack_va_end"
.LASF1127:
	.string	"TEE_ALG_SHA384 0x50000005"
.LASF447:
	.string	"INT64_MAX 0x7fffffffffffffffL"
.LASF895:
	.string	"SLIST_ENTRY(type) struct { struct type *sle_next; }"
.LASF564:
	.string	"ARM32_CPSR_MODE_ABT 0x17"
.LASF374:
	.string	"_CFG_CRYPTO_WITH_HASH 1"
.LASF500:
	.string	"MAX(a,b) (__extension__({ __typeof__(a) _a = (a); __typeof__(b) _b = (b); _a > _b ? _a : _b; }))"
.LASF879:
	.string	"LIST_HEAD_INITIALIZER(head) { NULL }"
.LASF1443:
	.string	"TEE_MATTR_UX BIT(9)"
.LASF28:
	.string	"__SIZEOF_LONG_DOUBLE__ 16"
.LASF386:
	.string	"__noreturn __attribute__((noreturn))"
.LASF1704:
	.string	"thread_nintr_handler_ptr"
.LASF422:
	.string	"LONG_MIN (-LONG_MAX - 1L)"
.LASF1546:
	.string	"wait_read"
.LASF382:
	.string	"COMPILER_H "
.LASF1284:
	.string	"TEE_PANIC_ID_TEE_AEUPDATEAAD 0x00001005"
.LASF768:
	.string	"_WCHAR_T_DECLARED "
.LASF275:
	.string	"CFG_CORE_WORKAROUND_SPECTRE_BP_SEC 1"
.LASF901:
	.string	"SLIST_REMOVE_AFTER(slistelm,field) do { (slistelm)->field.sle_next = SLIST_NEXT(SLIST_NEXT((slistelm), field), field); } while ( 0)"
.LASF14:
	.string	"__ATOMIC_RELEASE 3"
.LASF96:
	.string	"__INT64_MAX__ 0x7fffffffffffffffL"
.LASF375:
	.string	"_CFG_CRYPTO_WITH_MAC 1"
.LASF910:
	.string	"STAILQ_INSERT_HEAD(head,elm,field) do { if (((elm)->field.stqe_next = (head)->stqh_first) == NULL) (head)->stqh_last = &(elm)->field.stqe_next; (head)->stqh_first = (elm); } while ( 0)"
.LASF241:
	.string	"__ARM_FEATURE_FP16_VECTOR_ARITHMETIC"
.LASF1681:
	.string	"THREAD_STATE_SUSPENDED"
.LASF278:
	.string	"CFG_CRYPTOLIB_NAME tomcrypt"
.LASF1050:
	.string	"TEE_MEMORY_ACCESS_WRITE 0x00000002"
.LASF438:
	.string	"__int8_t_defined "
.LASF715:
	.string	"DEFINE_U32_REG_READ_FUNC(reg) DEFINE_REG_READ_FUNC_(reg, uint32_t, reg)"
.LASF939:
	.string	"QUEUEDEBUG_TAILQ_INSERT_TAIL(head,elm,field) "
.LASF1456:
	.string	"TEE_MATTR_PERMANENT BIT(17)"
.LASF1369:
	.string	"TA_PROP_STR_UNSAFE_PARAM \"op-tee.unsafe_param\""
.LASF245:
	.string	"__AARCH64_CMODEL_TINY__"
.LASF282:
	.string	"CFG_CRYPTO_CCM 1"
.LASF273:
	.string	"CFG_CORE_UNMAP_CORE_AT_EL0 1"
.LASF1685:
	.string	"thread_vfp_state"
.LASF659:
	.string	"ESR_EC_AARCH32_CP14_LS 0x06"
.LASF1343:
	.string	"MALLOC_H "
.LASF1642:
	.string	"system_off_entry"
.LASF1247:
	.string	"TEE_PANIC_ID_TEE_RESETTRANSIENTOBJECT 0x00000808"
.LASF1315:
	.string	"TEE_PANIC_ID_TEE_BIGINTSUB 0x00001906"
.LASF731:
	.string	"_BSD_PTRDIFF_T_ "
.LASF1071:
	.string	"TEE_HANDLE_FLAG_KEY_SET 0x00040000"
.LASF859:
	.string	"OPTEE_MSG_CMD_OPEN_SESSION 0"
.LASF629:
	.string	"SPSR_64(el,sp,daif) (SPSR_MODE_RW_64 << SPSR_MODE_RW_SHIFT | ((el) & SPSR_64_MODE_EL_MASK) << SPSR_64_MODE_EL_SHIFT | ((sp) & SPSR_64_MODE_SP_MASK) << SPSR_64_MODE_SP_SHIFT | ((daif) & SPSR_64_DAIF_MASK) << SPSR_64_DAIF_SHIFT)"
.LASF1499:
	.string	"TEE_LOAD_ADDR TEE_RAM_START"
.LASF1122:
	.string	"TEE_ALG_DH_DERIVE_SHARED_SECRET 0x80000032"
.LASF780:
	.string	"PRId32 \"d\""
.LASF78:
	.string	"__INT_MAX__ 0x7fffffff"
.LASF75:
	.string	"__GXX_ABI_VERSION 1010"
.LASF9:
	.string	"__LINARO_RELEASE__ 201611"
.LASF1119:
	.string	"TEE_ALG_DSA_SHA1 0x70002131"
.LASF55:
	.string	"__INT_LEAST8_TYPE__ signed char"
.LASF956:
	.string	"TAILQ_NEXT(elm,field) ((elm)->field.tqe_next)"
.LASF975:
	.string	"CIRCLEQ_LAST(head) ((head)->cqh_last)"
.LASF1683:
	.string	"thread_ctx_regs"
.LASF1190:
	.string	"TEE_ATTR_ECC_PUBLIC_VALUE_Y 0xD0000241"
.LASF1082:
	.string	"TEE_ALG_AES_ECB_NOPAD 0x10000010"
.LASF1383:
	.string	"SM_SM_H "
.LASF868:
	.string	"OPTEE_MSG_RPC_WAIT_QUEUE_SLEEP 0"
.LASF1579:
	.string	"TEE_Param"
.LASF966:
	.ascii	"CIRCLEQ_INSERT_AFTER(head,listelm,elm,field) do { QUEUEDEBUG"
	.ascii	"_CIRCLEQ_HEAD((head), field) QUEUEDEBUG_CIRCLEQ_ELM((head), "
	.ascii	"(listelm), field) (elm)->f"
	.string	"ield.cqe_next = (listelm)->field.cqe_next; (elm)->field.cqe_prev = (listelm); if ((listelm)->field.cqe_next == (void *)(head)) (head)->cqh_last = (elm); else (listelm)->field.cqe_next->field.cqe_prev = (elm); (listelm)->field.cqe_next = (elm); } while ( 0)"
.LASF1220:
	.string	"TEE_PANIC_ID_TEE_OPENTASESSION 0x00000403"
.LASF1035:
	.string	"TEE_LOGIN_PUBLIC 0x00000000"
.LASF129:
	.string	"__FLT_EVAL_METHOD__ 0"
.LASF70:
	.string	"__UINT_FAST64_TYPE__ long unsigned int"
.LASF84:
	.string	"__WINT_MIN__ 0U"
.LASF921:
	.string	"SIMPLEQ_HEAD_INITIALIZER(head) { NULL, &(head).sqh_first }"
.LASF93:
	.string	"__INT8_MAX__ 0x7f"
.LASF1564:
	.string	"cpacr_el1"
.LASF924:
	.string	"SIMPLEQ_INSERT_HEAD(head,elm,field) do { if (((elm)->field.sqe_next = (head)->sqh_first) == NULL) (head)->sqh_last = &(elm)->field.sqe_next; (head)->sqh_first = (elm); } while ( 0)"
.LASF1336:
	.string	"TEE_MEMREF_1_USED 0x00000002"
.LASF760:
	.string	"_WCHAR_T_ "
.LASF13:
	.string	"__ATOMIC_ACQUIRE 2"
.LASF440:
	.string	"INT8_MIN (-0x7f-1)"
.LASF1453:
	.string	"TEE_MATTR_CACHE_CACHED 1"
.LASF515:
	.string	"SHIFT_U32(v,shift) ((uint32_t)(v) << (shift))"
.LASF1631:
	.string	"tee_ctxes"
.LASF827:
	.string	"OPTEE_MSG_ATTR_TYPE_RMEM_INOUT 0x7"
.LASF248:
	.string	"__AARCH64_CMODEL_SMALL__ 1"
.LASF1612:
	.string	"tee_ta_ctx"
.LASF498:
	.string	"SIZE_8M UINTPTR_C(0x800000)"
.LASF554:
	.string	"CTR_L1IP_SHIFT 14"
.LASF1478:
	.string	"CONSOLE_UART_BASE UART1_BASE"
.LASF705:
	.string	"CPACR_EL1_FPEN_EL0EL1 0x3"
.LASF739:
	.string	"_SYS_SIZE_T_H "
.LASF366:
	.string	"PLATFORM_FLAVOR_qemu_armv8a 1"
.LASF487:
	.string	"INT32_C(v) v"
.LASF570:
	.string	"ARM32_CPSR_I (1 << 7)"
.LASF958:
	.string	"TAILQ_PREV(elm,headname,field) (*(((struct headname *)((elm)->field.tqe_prev))->tqh_last))"
.LASF1412:
	.string	"IMSG_RAW(...) trace_printf_helper_raw(TRACE_INFO, true, __VA_ARGS__)"
.LASF1424:
	.string	"assert(expr) do { if (!(expr)) { _assert_log(#expr, __FILE__, __LINE__, __func__); _assert_break(); } } while (0)"
.LASF594:
	.string	"DAIFBIT_DBG BIT32(3)"
.LASF593:
	.string	"DAIFBIT_ABT BIT32(2)"
.LASF250:
	.string	"__ILP32__"
.LASF1177:
	.string	"TEE_ATTR_DSA_SUBPRIME 0xD0001131"
.LASF421:
	.string	"LONG_MAX __LONG_MAX__"
.LASF904:
	.string	"SLIST_FIRST(head) ((head)->slh_first)"
.LASF1018:
	.string	"TEE_ERROR_SECURITY 0xFFFF000F"
.LASF473:
	.string	"UINT_FAST16_MAX UINT16_MAX"
.LASF1358:
	.string	"TA_FLAG_CONCURRENT (1 << 8)"
.LASF800:
	.string	"PRIx32 \"x\""
.LASF816:
	.string	"PRIxVA PRIxPTR"
.LASF1592:
	.string	"name"
.LASF1300:
	.string	"TEE_PANIC_ID_TEE_BIGINTINITFMMCONTEXT 0x00001603"
.LASF926:
	.string	"SIMPLEQ_INSERT_AFTER(head,listelm,elm,field) do { if (((elm)->field.sqe_next = (listelm)->field.sqe_next) == NULL) (head)->sqh_last = &(elm)->field.sqe_next; (listelm)->field.sqe_next = (elm); } while ( 0)"
.LASF597:
	.string	"DAIF_F BIT32(6)"
.LASF1503:
	.string	"__register_memory2(_name,_type,_addr,_size,_section,_id) static const struct core_mmu_phys_mem __phys_mem_ ## _id __used __section(_section) = { .name = _name, .type = _type, .addr = _addr, .size = _size }"
.LASF1619:
	.string	"param_mem"
.LASF475:
	.string	"UINT_FAST64_MAX UINT64_MAX"
.LASF1012:
	.string	"TEE_ERROR_NOT_IMPLEMENTED 0xFFFF0009"
.LASF276:
	.string	"CFG_CRYPTO 1"
.LASF1623:
	.string	"types"
.LASF303:
	.string	"CFG_CRYPTO_SIZE_OPTIMIZATION 1"
.LASF1135:
	.string	"TEE_ALG_HMAC_SHA512 0x30000006"
.LASF571:
	.string	"ARM32_CPSR_A (1 << 8)"
.LASF654:
	.string	"ESR_EC_UNKNOWN 0x00"
.LASF954:
	.string	"TAILQ_EMPTY(head) ((head)->tqh_first == NULL)"
.LASF319:
	.string	"CFG_MSG_LONG_PREFIX_MASK 0x1a"
.LASF657:
	.string	"ESR_EC_AARCH32_CP15_64 0x04"
.LASF862:
	.string	"OPTEE_MSG_CMD_CANCEL 3"
.LASF773:
	.string	"__need_NULL"
.LASF1178:
	.string	"TEE_ATTR_DSA_BASE 0xD0001231"
.LASF996:
	.string	"TEE_HANDLE_NULL 0"
.LASF1173:
	.string	"TEE_ATTR_RSA_EXPONENT1 0xC0000630"
.LASF660:
	.string	"ESR_EC_FP_ASIMD 0x07"
.LASF301:
	.string	"CFG_CRYPTO_SHA384 1"
.LASF1153:
	.string	"TEE_TYPE_HMAC_SHA384 0xA0000005"
.LASF505:
	.string	"IS_POWER_OF_TWO(x) (((x) != 0) && (((x) & (~(x) + 1)) == (x)))"
.LASF1467:
	.string	"TEE_SHMEM_START CFG_SHMEM_START"
.LASF783:
	.string	"PRIi8 \"i\""
.LASF1172:
	.string	"TEE_ATTR_RSA_PRIME2 0xC0000530"
.LASF1371:
	.string	"TA_PROP_STR_CACHE_SYNC \"op-tee.cache_sync\""
.LASF592:
	.string	"DAIFBIT_IRQ BIT32(1)"
.LASF585:
	.string	"SCTLR_C BIT32(2)"
.LASF418:
	.string	"CHAR_MIN 0"
.LASF199:
	.string	"__GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 1"
.LASF1469:
	.string	"TZDRAM_SIZE CFG_TZDRAM_SIZE"
.LASF1089:
	.string	"TEE_ALG_AES_CMAC 0x30000610"
.LASF1465:
	.string	"TEE_RAM_VA_SIZE CORE_MMU_PGDIR_SIZE"
.LASF578:
	.string	"CNTKCTL_PL0VCTEN BIT(1)"
.LASF1080:
	.string	"TEE_OPERATION_STATE_INITIAL 0x00000000"
.LASF1085:
	.string	"TEE_ALG_AES_CTS 0x10000310"
.LASF1326:
	.string	"TEE_PANIC_ID_TEE_BIGINTCONVERTFROMFMM 0x00001C02"
.LASF53:
	.string	"__UINT32_TYPE__ unsigned int"
.LASF327:
	.string	"CFG_REE_FS 1"
.LASF688:
	.string	"ESR_FSC_SIZE_L3 0x03"
.LASF1653:
	.string	"thread_smc_args"
.LASF621:
	.string	"SPSR_32_E_BIG 0x1"
.LASF1160:
	.string	"TEE_TYPE_ECDSA_PUBLIC_KEY 0xA0000041"
.LASF79:
	.string	"__LONG_MAX__ 0x7fffffffffffffffL"
.LASF1041:
	.string	"TEE_LOGIN_TRUSTED_APP 0xF0000000"
.LASF223:
	.string	"__ARM_ALIGN_MAX_PWR 28"
.LASF871:
	.string	"OPTEE_MSG_RPC_CMD_SHM_ALLOC 6"
.LASF165:
	.string	"__LDBL_MAX_10_EXP__ 4932"
.LASF1541:
	.string	"wait_queue"
.LASF576:
	.string	"ARM32_CPSR_IT_MASK2 0x0000fc00"
.LASF565:
	.string	"ARM32_CPSR_MODE_UND 0x1b"
.LASF1540:
	.string	"sizetype"
.LASF296:
	.string	"CFG_CRYPTO_PBKDF2 1"
.LASF1360:
	.string	"TA_FLAG_USER_MODE 0"
.LASF1385:
	.string	"THREAD_PRIVATE_H "
.LASF240:
	.string	"__ARM_FEATURE_FP16_SCALAR_ARITHMETIC"
.LASF176:
	.string	"__DEC32_MAX_EXP__ 97"
.LASF222:
	.string	"__ARM_ARCH_ISA_A64 1"
.LASF1690:
	.string	"thread_ctx"
.LASF535:
	.string	"CORTEX_A17_PART_NUM 0xC0E"
.LASF499:
	.string	"SIZE_2G UINTPTR_C(0x80000000)"
.LASF713:
	.string	"DEFINE_REG_READ_FUNC_(reg,type,asmreg) static inline type read_ ##reg(void) { type val; asm volatile(\"mrs %0, \" #asmreg : \"=r\" (val)); return val; }"
.LASF646:
	.string	"TCR_XRGNX_WB 0x1"
.LASF687:
	.string	"ESR_FSC_SIZE_L2 0x02"
.LASF951:
	.string	"TAILQ_FOREACH_REVERSE(var,head,headname,field) for ((var) = (*(((struct headname *)((head)->tqh_last))->tqh_last)); (var); (var) = (*(((struct headname *)((var)->field.tqe_prev))->tqh_last)))"
.LASF1033:
	.string	"TEE_PARAM_TYPE_MEMREF_OUTPUT 6"
.LASF216:
	.string	"__SIZEOF_INT128__ 16"
.LASF1531:
	.string	"short unsigned int"
.LASF710:
	.string	"TLBI_MVA_SHIFT 12"
.LASF1525:
	.string	"signed char"
.LASF1382:
	.string	"SM_PM_H "
.LASF944:
	.ascii	"TAILQ_INSERT_HEAD(head,elm,field) do { QUEUEDEBUG_TAILQ_INSE"
	.ascii	"RT_HEAD((head), (elm),"
	.string	" field) if (((elm)->field.tqe_next = (head)->tqh_first) != NULL) (head)->tqh_first->field.tqe_prev = &(elm)->field.tqe_next; else (head)->tqh_last = &(elm)->field.tqe_next; (head)->tqh_first = (elm); (elm)->field.tqe_prev = &(head)->tqh_first; } while ( 0)"
.LASF8:
	.string	"__VERSION__ \"6.2.1 20161016\""
.LASF930:
	.string	"SIMPLEQ_EMPTY(head) ((head)->sqh_first == NULL)"
.LASF736:
	.string	"__size_t__ "
.LASF544:
	.string	"CLIDR_LOC_SHIFT 24"
.LASF468:
	.string	"INT_FAST8_MAX INT8_MAX"
.LASF648:
	.string	"TCR_XRGNX_WBWA 0x3"
.LASF644:
	.string	"TCR_RES1 BIT32(31)"
.LASF695:
	.string	"ESR_FSC_ACCF_L3 0x0b"
.LASF1288:
	.string	"TEE_PANIC_ID_TEE_ASYMMETRICVERIFYDIGEST 0x00001104"
.LASF508:
	.string	"_TO_STR(x) #x"
.LASF320:
	.string	"CFG_NUM_THREADS 2"
.LASF30:
	.string	"__CHAR_BIT__ 8"
.LASF1099:
	.string	"TEE_ALG_DES3_CBC_MAC_PKCS5 0x30000513"
.LASF1146:
	.string	"TEE_TYPE_AES 0xA0000010"
.LASF1335:
	.string	"TEE_MEMREF_0_USED 0x00000001"
.LASF877:
	.string	"_SYS_QUEUE_H_ "
.LASF532:
	.string	"CORTEX_A8_PART_NUM 0xC08"
.LASF503:
	.string	"ROUNDUP(v,size) (((v) + ((__typeof__(v))(size) - 1)) & ~((__typeof__(v))(size) - 1))"
.LASF542:
	.string	"MPIDR_CLUSTER_MASK (0xff << MPIDR_CLUSTER_SHIFT)"
.LASF1148:
	.string	"TEE_TYPE_DES3 0xA0000013"
.LASF340:
	.string	"CFG_TA_MBEDTLS 1"
.LASF860:
	.string	"OPTEE_MSG_CMD_INVOKE_COMMAND 1"
.LASF906:
	.string	"STAILQ_HEAD(name,type) struct name { struct type *stqh_first; struct type **stqh_last; }"
.LASF74:
	.string	"__has_include_next(STR) __has_include_next__(STR)"
.LASF1051:
	.string	"TEE_MEMORY_ACCESS_ANY_OWNER 0x00000004"
.LASF43:
	.string	"__UINTMAX_TYPE__ long unsigned int"
.LASF49:
	.string	"__INT32_TYPE__ int"
.LASF1195:
	.string	"TEE_ECC_CURVE_NIST_P192 0x00000001"
.LASF965:
	.string	"CIRCLEQ_INIT(head) do { (head)->cqh_first = (void *)(head); (head)->cqh_last = (void *)(head); } while ( 0)"
.LASF213:
	.string	"__GCC_ATOMIC_POINTER_LOCK_FREE 2"
.LASF858:
	.string	"OPTEE_MSG_FUNCID_GET_OS_REVISION 0x0001"
.LASF1181:
	.string	"TEE_ATTR_DH_PRIME 0xD0001032"
.LASF582:
	.string	"__always_inline __attribute__((always_inline)) inline"
.LASF262:
	.string	"ARM64 1"
.LASF617:
	.string	"SPSR_32_AIF_MASK 0x7"
.LASF804:
	.string	"PRIX16 \"X\""
.LASF1430:
	.string	"TEE_MMU_TYPES_H "
.LASF504:
	.string	"ROUNDDOWN(v,size) ((v) & ~((__typeof__(v))(size) - 1))"
.LASF1061:
	.string	"TEE_OBJECT_ID_MAX_LEN 64"
.LASF314:
	.string	"CFG_KERN_LINKER_FORMAT elf64-littleaarch64"
.LASF1248:
	.string	"TEE_PANIC_ID_TEE_COPYOBJECTATTRIBUTES1 0x00000809"
.LASF1057:
	.string	"TEE_DATA_FLAG_SHARE_READ 0x00000010"
.LASF1209:
	.string	"TEE_PANIC_ID_TEE_GETPROPERTYASBOOL 0x00000205"
.LASF1416:
	.string	"KERNEL_UNWIND "
.LASF302:
	.string	"CFG_CRYPTO_SHA512 1"
.LASF436:
	.string	"STDINT_H "
.LASF183:
	.string	"__DEC64_MAX_EXP__ 385"
.LASF1555:
	.string	"state"
.LASF1538:
	.string	"vaddr_t"
.LASF1448:
	.string	"TEE_MATTR_GLOBAL BIT(10)"
.LASF1104:
	.string	"TEE_ALG_RSASSA_PKCS1_V1_5_SHA384 0x70005830"
.LASF284:
	.string	"CFG_CRYPTO_CONCAT_KDF 1"
.LASF1157:
	.string	"TEE_TYPE_DSA_PUBLIC_KEY 0xA0000031"
.LASF1715:
	.string	"__defines"
.LASF171:
	.string	"__LDBL_HAS_DENORM__ 1"
.LASF1628:
	.string	"dump_state"
.LASF725:
	.string	"_ANSI_STDDEF_H "
.LASF1295:
	.string	"TEE_PANIC_ID_TEE_WAIT 0x00001405"
.LASF1067:
	.string	"TEE_USAGE_VERIFY 0x00000020"
.LASF803:
	.string	"PRIX8 \"X\""
.LASF1445:
	.string	"TEE_MATTR_URX (TEE_MATTR_UR | TEE_MATTR_UX)"
.LASF1421:
	.string	"DPRINT_STACK() print_kernel_stack(TRACE_DEBUG)"
.LASF1321:
	.string	"TEE_PANIC_ID_TEE_BIGINTSUBMOD 0x00001A06"
.LASF224:
	.string	"__ARM_ALIGN_MAX_STACK_PWR 16"
.LASF209:
	.string	"__GCC_ATOMIC_INT_LOCK_FREE 2"
.LASF114:
	.string	"__UINT32_C(c) c ## U"
.LASF119:
	.string	"__INT_FAST32_MAX__ 0x7fffffffffffffffL"
.LASF1624:
	.string	"tee_ta_ops"
.LASF405:
	.string	"__compiler_bswap32(x) __builtin_bswap32((x))"
.LASF195:
	.string	"__REGISTER_PREFIX__ "
.LASF1198:
	.string	"TEE_ECC_CURVE_NIST_P384 0x00000004"
.LASF1304:
	.string	"TEE_PANIC_ID_TEE_BIGINTCONVERTTOS32 0x00001704"
.LASF517:
	.string	"BIT(nr) BIT32(nr)"
.LASF342:
	.string	"CFG_TA_PTA_TEST 1"
.LASF1477:
	.string	"UART1_BASE 0x09040000"
.LASF1454:
	.string	"TEE_MATTR_LOCKED BIT(15)"
.LASF1046:
	.string	"TEE_PROPSET_TEE_IMPLEMENTATION (TEE_PropSetHandle)0xFFFFFFFD"
.LASF364:
	.string	"CFG_WITH_VFP 1"
.LASF539:
	.string	"CORTEX_A75_PART_NUM 0xD0A"
.LASF1078:
	.string	"TEE_OPERATION_ASYMMETRIC_SIGNATURE 7"
.LASF1183:
	.string	"TEE_ATTR_DH_BASE 0xD0001232"
.LASF638:
	.string	"TCR_EPD1 BIT32(23)"
.LASF606:
	.string	"SPSR_64_MODE_SP_SHIFT 0"
.LASF430:
	.string	"UCHAR_MAX (SCHAR_MAX * 2 + 1)"
.LASF1258:
	.string	"TEE_PANIC_ID_TEE_STARTPERSISTENTOBJECTENUMERATOR 0x00000A05"
.LASF1111:
	.string	"TEE_ALG_RSASSA_PKCS1_PSS_MGF1_SHA512 0x70616930"
.LASF1604:
	.string	"cancel_time"
.LASF604:
	.string	"SPSR_MODE_RW_64 0x0"
.LASF844:
	.string	"OPTEE_MSG_GET_ARG_SIZE(num_params) (sizeof(struct optee_msg_arg) + sizeof(struct optee_msg_param) * (num_params))"
.LASF105:
	.string	"__INT_LEAST32_MAX__ 0x7fffffff"
.LASF849:
	.string	"OPTEE_MSG_FUNCID_CALLS_UID 0xFF01"
.LASF624:
	.string	"SPSR_32_T_ARM 0x0"
.LASF931:
	.string	"SIMPLEQ_FIRST(head) ((head)->sqh_first)"
.LASF730:
	.string	"_PTRDIFF_T_ "
.LASF1112:
	.string	"TEE_ALG_RSAES_PKCS1_V1_5 0x60000130"
.LASF261:
	.string	"__KERNEL__ 1"
.LASF1161:
	.string	"TEE_TYPE_ECDSA_KEYPAIR 0xA1000041"
.LASF1346:
	.string	"RAND_MAX __INT_MAX__"
.LASF1273:
	.string	"TEE_PANIC_ID_TEE_CIPHERDOFINAL 0x00000E01"
.LASF4:
	.string	"__STDC_HOSTED__ 1"
.LASF1005:
	.string	"TEE_ERROR_CANCEL 0xFFFF0002"
.LASF474:
	.string	"UINT_FAST32_MAX UINT32_MAX"
.LASF187:
	.string	"__DEC64_SUBNORMAL_MIN__ 0.000000000000001E-383DD"
.LASF65:
	.string	"__INT_FAST32_TYPE__ long int"
.LASF1031:
	.string	"TEE_PARAM_TYPE_VALUE_INOUT 3"
.LASF528:
	.string	"MIDR_IMPLEMENTER_WIDTH 8"
.LASF1159:
	.string	"TEE_TYPE_DH_KEYPAIR 0xA1000032"
.LASF360:
	.string	"CFG_WITH_SOFTWARE_PRNG 1"
.LASF1401:
	.string	"EMSG(...) trace_printf_helper(TRACE_ERROR, true, __VA_ARGS__)"
.LASF163:
	.string	"__LDBL_MIN_10_EXP__ (-4931)"
.LASF788:
	.string	"PRIo8 \"o\""
.LASF922:
	.string	"SIMPLEQ_ENTRY(type) struct { struct type *sqe_next; }"
.LASF512:
	.string	"MEMBER_SIZE(type,member) sizeof(((type *)0)->member)"
.LASF1151:
	.string	"TEE_TYPE_HMAC_SHA224 0xA0000003"
.LASF1287:
	.string	"TEE_PANIC_ID_TEE_ASYMMETRICSIGNDIGEST 0x00001103"
.LASF157:
	.string	"__DBL_HAS_DENORM__ 1"
.LASF453:
	.string	"INT_LEAST16_MIN INT16_MIN"
.LASF99:
	.string	"__UINT32_MAX__ 0xffffffffU"
.LASF1646:
	.string	"rpc_fs_payload"
.LASF1208:
	.string	"TEE_PANIC_ID_TEE_GETPROPERTYASBINARYBLOCK 0x00000204"
.LASF908:
	.string	"STAILQ_ENTRY(type) struct { struct type *stqe_next; }"
.LASF784:
	.string	"PRIi16 \"i\""
.LASF205:
	.string	"__GCC_ATOMIC_CHAR16_T_LOCK_FREE 2"
.LASF573:
	.string	"ARM32_CPSR_FIA (ARM32_CPSR_F | ARM32_CPSR_I | ARM32_CPSR_A)"
.LASF1313:
	.string	"TEE_PANIC_ID_TEE_BIGINTNEG 0x00001904"
.LASF197:
	.string	"__GNUC_STDC_INLINE__ 1"
.LASF548:
	.string	"CTR_CWG_MASK 0xf"
.LASF785:
	.string	"PRIi32 \"i\""
.LASF506:
	.string	"ALIGNMENT_IS_OK(p,type) (((uintptr_t)(p) & (__alignof__(type) - 1)) == 0)"
.LASF1351:
	.string	"USER_TA_HEADER_H "
.LASF239:
	.string	"__ARM_FP"
.LASF971:
	.string	"CIRCLEQ_FOREACH(var,head,field) for ((var) = ((head)->cqh_first); (var) != (const void *)(head); (var) = ((var)->field.cqe_next))"
.LASF1131:
	.string	"TEE_ALG_HMAC_SHA1 0x30000002"
.LASF373:
	.string	"_CFG_CRYPTO_WITH_FORTUNA_PRNG 1"
.LASF356:
	.string	"CFG_TZDRAM_START 0x0e100000"
.LASF1216:
	.string	"TEE_PANIC_ID_TEE_STARTPROPERTYENUMERATOR 0x0000020C"
.LASF1257:
	.string	"TEE_PANIC_ID_TEE_RESETPERSISTENTOBJECTENUMERATOR 0x00000A04"
.LASF989:
	.string	"MM_PGT_CACHE_H "
.LASF1449:
	.string	"TEE_MATTR_SECURE BIT(11)"
.LASF1361:
	.string	"TA_FLAG_EXEC_DDR 0"
.LASF1285:
	.string	"TEE_PANIC_ID_TEE_ASYMMETRICDECRYPT 0x00001101"
.LASF699:
	.string	"ESR_FSC_ALIGN 0x21"
.LASF1427:
	.string	"TEE_MM_H "
.LASF729:
	.string	"__PTRDIFF_T "
.LASF391:
	.string	"__attr_const __attribute__((__const__))"
.LASF799:
	.string	"PRIx16 \"x\""
.LASF796:
	.string	"PRIu64 __PRI64_PREFIX \"u\""
.LASF251:
	.string	"__ARM_FEATURE_CRYPTO"
.LASF469:
	.string	"INT_FAST16_MAX INT16_MAX"
.LASF378:
	.string	"DEFINE(def,val) asm volatile(\"\\n==>\" #def \" %0 \" #val : : \"i\" (val))"
.LASF599:
	.string	"DAIF_A BIT32(8)"
.LASF1339:
	.string	"TEE_SE_READER_NAME_MAX 20"
.LASF903:
	.string	"SLIST_EMPTY(head) ((head)->slh_first == NULL)"
.LASF1116:
	.string	"TEE_ALG_RSAES_PKCS1_OAEP_MGF1_SHA384 0x60510230"
.LASF1380:
	.string	"THREAD_EXCP_NATIVE_INTR (ARM32_CPSR_F >> ARM32_CPSR_F_SHIFT)"
.LASF911:
	.string	"STAILQ_INSERT_TAIL(head,elm,field) do { (elm)->field.stqe_next = NULL; *(head)->stqh_last = (elm); (head)->stqh_last = &(elm)->field.stqe_next; } while ( 0)"
.LASF1108:
	.string	"TEE_ALG_RSASSA_PKCS1_PSS_MGF1_SHA224 0x70313930"
.LASF167:
	.string	"__LDBL_MAX__ 1.18973149535723176508575932662800702e+4932L"
.LASF1329:
	.string	"TEE_PARAM_TYPE_GET(t,i) ((((uint32_t)t) >> ((i)*4)) & 0xF)"
.LASF1403:
	.string	"DMSG(...) trace_printf_helper(TRACE_DEBUG, true, __VA_ARGS__)"
.LASF627:
	.string	"SPSR_32_MODE_MASK 0xf"
.LASF1532:
	.string	"uint32_t"
.LASF742:
	.string	"__SIZE_T "
.LASF134:
	.string	"__FLT_MIN_EXP__ (-125)"
.LASF1630:
	.string	"get_instance_id"
.LASF1486:
	.string	"CORE_MMU_PGDIR_LEVEL 3"
.LASF913:
	.string	"STAILQ_REMOVE_HEAD(head,field) do { if (((head)->stqh_first = (head)->stqh_first->field.stqe_next) == NULL) (head)->stqh_last = &(head)->stqh_first; } while ( 0)"
.LASF208:
	.string	"__GCC_ATOMIC_SHORT_LOCK_FREE 2"
.LASF1240:
	.string	"TEE_PANIC_ID_TEE_ALLOCATETRANSIENTOBJECT 0x00000801"
.LASF1466:
	.string	"TEE_SHMEM_SIZE CFG_SHMEM_SIZE"
.LASF977:
	.string	"CIRCLEQ_PREV(elm,field) ((elm)->field.cqe_prev)"
.LASF1494:
	.string	"CORE_MMU_USER_CODE_MASK (CORE_MMU_USER_CODE_SIZE - 1)"
.LASF1536:
	.string	"uintptr_t"
.LASF37:
	.string	"__SIZEOF_POINTER__ 8"
.LASF1239:
	.string	"TEE_PANIC_ID_TEE_RESTRICTOBJECTUSAGE1 0x00000707"
.LASF1034:
	.string	"TEE_PARAM_TYPE_MEMREF_INOUT 7"
.LASF1682:
	.string	"THREAD_STATE_ACTIVE"
.LASF1368:
	.string	"TA_PROP_STR_DESCRIPTION \"gpd.ta.description\""
.LASF1581:
	.string	"millis"
.LASF741:
	.string	"_T_SIZE "
.LASF1510:
	.string	"register_dynamic_shm(addr,size) __register_memory1(#addr, MEM_AREA_RAM_NSEC, (addr), (size), phys_nsec_ddr_section, __COUNTER__)"
.LASF1278:
	.string	"TEE_PANIC_ID_TEE_MACINIT 0x00000F03"
.LASF1377:
	.string	"THREAD_RPC_MAX_NUM_PARAMS 4"
.LASF794:
	.string	"PRIu16 \"u\""
.LASF1484:
	.string	"SMALL_PAGE_SIZE 0x00001000"
.LASF1489:
	.string	"CORE_MMU_DEVICE_SHIFT CORE_MMU_PGDIR_SHIFT"
.LASF830:
	.string	"OPTEE_MSG_ATTR_TYPE_TMEM_INOUT 0xb"
.LASF1429:
	.string	"TEE_MM_POOL_HI_ALLOC (1u << 0)"
.LASF1713:
	.string	"core/arch/arm/kernel/asm-defines.c"
.LASF1103:
	.string	"TEE_ALG_RSASSA_PKCS1_V1_5_SHA256 0x70004830"
.LASF791:
	.string	"PRIo64 __PRI64_PREFIX \"o\""
.LASF1535:
	.string	"long unsigned int"
.LASF1387:
	.string	"ASSERT_H "
.LASF414:
	.string	"__compiler_atomic_store(p,val) __atomic_store_n((p), (val), __ATOMIC_RELAXED)"
.LASF1060:
	.string	"TEE_DATA_MAX_POSITION 0xFFFFFFFF"
.LASF80:
	.string	"__LONG_LONG_MAX__ 0x7fffffffffffffffLL"
.LASF1378:
	.string	"THREAD_CORE_LOCAL_ALIGNED __aligned(16)"
.LASF318:
	.string	"CFG_MMAP_REGIONS 13"
.LASF1115:
	.string	"TEE_ALG_RSAES_PKCS1_OAEP_MGF1_SHA256 0x60410230"
.LASF941:
	.string	"QUEUEDEBUG_TAILQ_PREREMOVE(head,elm,field) "
.LASF1128:
	.string	"TEE_ALG_SHA512 0x50000006"
.LASF1238:
	.string	"TEE_PANIC_ID_TEE_GETOBJECTINFO1 0x00000706"
.LASF115:
	.string	"__UINT_LEAST64_MAX__ 0xffffffffffffffffUL"
.LASF1:
	.string	"__STDC_VERSION__ 199901L"
.LASF1664:
	.string	"entry"
.LASF645:
	.string	"TCR_XRGNX_NC 0x0"
.LASF876:
	.string	"KERNEL_MUTEX_H "
.LASF861:
	.string	"OPTEE_MSG_CMD_CLOSE_SESSION 2"
.LASF942:
	.string	"QUEUEDEBUG_TAILQ_POSTREMOVE(elm,field) "
.LASF112:
	.string	"__UINT16_C(c) c"
.LASF1651:
	.string	"lazy_saved"
.LASF616:
	.string	"SPSR_32_AIF_SHIFT 6"
.LASF1225:
	.string	"TEE_PANIC_ID_TEE_FREE 0x00000602"
.LASF692:
	.string	"ESR_FSC_TRANS_L3 0x07"
.LASF839:
	.string	"OPTEE_MSG_LOGIN_GROUP 0x00000002"
.LASF126:
	.string	"__UINTPTR_MAX__ 0xffffffffffffffffUL"
.LASF1388:
	.string	"TRACE_H "
.LASF1463:
	.string	"PLATFORM_CONFIG_H "
.LASF552:
	.string	"CTR_DMINLINE_WIDTH 4"
.LASF1205:
	.string	"TEE_PANIC_ID_TEE_ALLOCATEPROPERTYENUMERATOR 0x00000201"
.LASF1393:
	.string	"TRACE_DEBUG 3"
.LASF311:
	.string	"CFG_HWSUPP_MEM_PERM_PXN 1"
.LASF1600:
	.string	"link_tsd"
.LASF881:
	.string	"QUEUEDEBUG_LIST_INSERT_HEAD(head,elm,field) "
.LASF139:
	.string	"__FLT_MAX__ 3.40282346638528859811704183484516925e+38F"
.LASF589:
	.string	"TTBR_ASID_MASK 0xff"
.LASF955:
	.string	"TAILQ_FIRST(head) ((head)->tqh_first)"
.LASF369:
	.string	"_CFG_CRYPTO_WITH_ASN1 1"
.LASF1712:
	.string	"GNU C99 6.2.1 20161016 -mstrict-align -mgeneral-regs-only -march=armv8-a -mlittle-endian -mabi=lp64 -g -g3 -Os -std=gnu99 -ffunction-sections -fdata-sections"
.LASF1584:
	.string	"char"
.LASF520:
	.string	"ADD_OVERFLOW(a,b,res) __compiler_add_overflow((a), (b), (res))"
.LASF681:
	.string	"ESR_EC_WATCHPT_EL1 0x35"
.LASF1242:
	.string	"TEE_PANIC_ID_TEE_FREETRANSIENTOBJECT 0x00000803"
.LASF495:
	.string	"SIZE_1M UINTPTR_C(0x100000)"
.LASF1289:
	.string	"TEE_PANIC_ID_TEE_DERIVEKEY 0x00001201"
.LASF1196:
	.string	"TEE_ECC_CURVE_NIST_P224 0x00000002"
.LASF1038:
	.string	"TEE_LOGIN_APPLICATION 0x00000004"
.LASF1648:
	.string	"rpc_fs_payload_cookie"
.LASF493:
	.string	"UINTMAX_C(v) UINT64_C(v)"
.LASF349:
	.string	"CFG_TEE_FW_IMPL_VERSION FW_IMPL_UNDEF"
.LASF60:
	.string	"__UINT_LEAST16_TYPE__ short unsigned int"
.LASF45:
	.string	"__CHAR32_TYPE__ unsigned int"
.LASF173:
	.string	"__LDBL_HAS_QUIET_NAN__ 1"
.LASF890:
	.string	"LIST_EMPTY(head) ((head)->lh_first == NULL)"
.LASF1556:
	.string	"owner_id"
.LASF1437:
	.string	"TEE_MATTR_PX BIT(6)"
.LASF81:
	.string	"__WCHAR_MAX__ 0xffffffffU"
.LASF786:
	.string	"PRIi64 __PRI64_PREFIX \"i\""
.LASF738:
	.string	"_SIZE_T "
.LASF558:
	.string	"ARM32_CPSR_MODE_MASK 0x1f"
.LASF1703:
	.string	"thread_std_smc_handler_ptr"
.LASF1414:
	.string	"FMSG_RAW(...) (void)0"
.LASF294:
	.string	"CFG_CRYPTO_HMAC 1"
.LASF1585:
	.string	"USER_TA_PROP_TYPE_BOOL"
.LASF658:
	.string	"ESR_EC_AARCH32_CP14_MR 0x05"
.LASF680:
	.string	"ESR_EC_WATCHPT_EL0 0x34"
.LASF810:
	.string	"true 1"
.LASF404:
	.string	"__compiler_bswap64(x) __builtin_bswap64((x))"
.LASF690:
	.string	"ESR_FSC_TRANS_L1 0x05"
.LASF1485:
	.string	"CORE_MMU_PGDIR_SHIFT 21"
.LASF1149:
	.string	"TEE_TYPE_HMAC_MD5 0xA0000001"
.LASF664:
	.string	"ESR_EC_AARCH32_SVC 0x11"
.LASF1083:
	.string	"TEE_ALG_AES_CBC_NOPAD 0x10000110"
.LASF746:
	.string	"_SIZE_T_DEFINED "
.LASF326:
	.string	"CFG_PM_STUBS 1"
.LASF825:
	.string	"OPTEE_MSG_ATTR_TYPE_RMEM_INPUT 0x5"
.LASF449:
	.string	"UINT16_MAX 0xffff"
.LASF136:
	.string	"__FLT_MAX_EXP__ 128"
.LASF1014:
	.string	"TEE_ERROR_NO_DATA 0xFFFF000B"
.LASF812:
	.string	"__bool_true_false_are_defined 1"
.LASF1512:
	.string	"THREAD_VFP_STATE_SIZE (16 + (16 * 32 + 16) * 2 + 16)"
.LASF1455:
	.string	"TEE_MATTR_EPHEMERAL BIT(16)"
.LASF66:
	.string	"__INT_FAST64_TYPE__ long int"
.LASF752:
	.string	"__size_t "
.LASF837:
	.string	"OPTEE_MSG_LOGIN_PUBLIC 0x00000000"
.LASF1687:
	.string	"sec_saved"
.LASF1281:
	.string	"TEE_PANIC_ID_TEE_AEENCRYPTFINAL 0x00001002"
.LASF701:
	.string	"CPACR_EL1_FPEN_SHIFT 20"
.LASF1314:
	.string	"TEE_PANIC_ID_TEE_BIGINTSQUARE 0x00001905"
.LASF962:
	.string	"CIRCLEQ_HEAD(name,type) struct name { struct type *cqh_first; struct type *cqh_last; }"
.LASF728:
	.string	"_T_PTRDIFF "
.LASF488:
	.string	"UINT32_C(v) v ## U"
.LASF1577:
	.string	"memref"
.LASF772:
	.string	"NULL ((void *)0)"
.LASF1121:
	.string	"TEE_ALG_DSA_SHA256 0x70004131"
.LASF857:
	.string	"OPTEE_MSG_FUNCID_GET_OS_UUID 0x0000"
.LASF1048:
	.string	"TEE_PROPSET_CURRENT_TA (TEE_PropSetHandle)0xFFFFFFFF"
.LASF1476:
	.string	"UART0_BASE 0x09000000"
.LASF33:
	.string	"__ORDER_BIG_ENDIAN__ 4321"
.LASF344:
	.string	"CFG_TEE_CORE_DEBUG 1"
.LASF292:
	.string	"CFG_CRYPTO_GCM 1"
.LASF253:
	.string	"__gnu_linux__ 1"
.LASF464:
	.string	"INT_FAST8_MIN INT8_MIN"
.LASF297:
	.string	"CFG_CRYPTO_RSA 1"
.LASF1375:
	.string	"THREAD_ID_0 0"
.LASF200:
	.string	"__GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 1"
.LASF268:
	.string	"CFG_CORE_BIGNUM_MAX_BITS 4096"
.LASF1490:
	.string	"CORE_MMU_DEVICE_SIZE (1 << CORE_MMU_DEVICE_SHIFT)"
.LASF92:
	.string	"__SIG_ATOMIC_MIN__ (-__SIG_ATOMIC_MAX__ - 1)"
.LASF489:
	.string	"INT64_C(v) v ## L"
.LASF1275:
	.string	"TEE_PANIC_ID_TEE_CIPHERUPDATE 0x00000E03"
.LASF545:
	.string	"CLIDR_FIELD_WIDTH 3"
.LASF1364:
	.string	"TA_PROP_STR_KEEP_ALIVE \"gpd.ta.instanceKeepAlive\""
.LASF1488:
	.string	"CORE_MMU_PGDIR_MASK (CORE_MMU_PGDIR_SIZE - 1)"
.LASF1407:
	.string	"OUTRMSG(r) do { OUTMSG(\"r=[%x]\", r); return r; } while (0)"
.LASF310:
	.string	"CFG_GP_SOCKETS 1"
.LASF1396:
	.string	"TRACE_PRINTF_LEVEL TRACE_ERROR"
.LASF1666:
	.string	"lock"
.LASF1520:
	.string	"THREAD_CLF_TMP (1 << THREAD_CLF_TMP_SHIFT)"
.LASF1338:
	.string	"TEE_MEMREF_3_USED 0x00000008"
.LASF409:
	.string	"__compiler_add_overflow(a,b,res) __builtin_add_overflow((a), (b), (res))"
.LASF770:
	.string	"__need_wchar_t"
.LASF138:
	.string	"__FLT_DECIMAL_DIG__ 9"
.LASF602:
	.string	"SPSR_MODE_RW_SHIFT 4"
.LASF1645:
	.string	"sess_stack"
.LASF1074:
	.string	"TEE_OPERATION_MAC 3"
.LASF1154:
	.string	"TEE_TYPE_HMAC_SHA512 0xA0000006"
.LASF462:
	.string	"UINT_LEAST32_MAX UINT32_MAX"
.LASF964:
	.string	"CIRCLEQ_ENTRY(type) struct { struct type *cqe_next; struct type *cqe_prev; }"
.LASF1217:
	.string	"TEE_PANIC_ID_TEE_PANIC 0x00000301"
.LASF1658:
	.string	"trace_ext_prefix"
.LASF452:
	.string	"INT_LEAST8_MIN INT8_MIN"
.LASF555:
	.string	"CTR_L1IP_MASK 0x3"
.LASF1457:
	.string	"TEE_MMU_UMAP_KCODE_IDX 0"
.LASF580:
	.string	"SYS_CDEFS_H "
.LASF1507:
	.string	"register_phys_mem(type,addr,size) __register_memory1(#addr, (type), (addr), (size), phys_mem_map_section, __COUNTER__)"
.LASF407:
	.string	"__GCC_VERSION (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__)"
.LASF983:
	.string	"MUTEX_OWNER_ID_CONDVAR_SLEEP -2"
.LASF733:
	.string	"_GCC_PTRDIFF_T "
.LASF1575:
	.string	"buffer"
.LASF254:
	.string	"__linux 1"
.LASF450:
	.string	"UINT32_MAX 0xffffffffU"
.LASF1187:
	.string	"TEE_ATTR_RSA_OAEP_LABEL 0xD0000930"
.LASF897:
	.string	"SLIST_INSERT_AFTER(slistelm,elm,field) do { (elm)->field.sle_next = (slistelm)->field.sle_next; (slistelm)->field.sle_next = (elm); } while ( 0)"
.LASF19:
	.string	"__FINITE_MATH_ONLY__ 0"
.LASF390:
	.string	"__noinline __attribute__((noinline))"
.LASF984:
	.string	"MUTEX_OWNER_ID_MUTEX_UNLOCK -3"
.LASF1694:
	.string	"have_user_map"
.LASF1036:
	.string	"TEE_LOGIN_USER 0x00000001"
.LASF1171:
	.string	"TEE_ATTR_RSA_PRIME1 0xC0000430"
.LASF372:
	.string	"_CFG_CRYPTO_WITH_CIPHER 1"
.LASF841:
	.string	"OPTEE_MSG_LOGIN_APPLICATION_USER 0x00000005"
.LASF1582:
	.string	"TEE_Time"
.LASF1684:
	.string	"cpsr"
.LASF1215:
	.string	"TEE_PANIC_ID_TEE_RESETPROPERTYENUMERATOR 0x0000020B"
.LASF1372:
	.string	"KERN_IDENTITY ((TEE_Identity *)-1)"
.LASF836:
	.string	"OPTEE_MSG_ATTR_CACHE_PREDEFINED 0"
.LASF334:
	.string	"CFG_SECURE_TIME_SOURCE_CNTPCT 1"
.LASF1306:
	.string	"TEE_PANIC_ID_TEE_BIGINTCMPS32 0x00001802"
.LASF1616:
	.string	"busy"
.LASF1316:
	.string	"TEE_PANIC_ID_TEE_BIGINTADDMOD 0x00001A01"
.LASF234:
	.string	"__ARM_SIZEOF_MINIMAL_ENUM 4"
.LASF721:
	.string	"read_midr() read_midr_el1()"
.LASF271:
	.string	"CFG_CORE_RWDATA_NOEXEC 1"
.LASF1495:
	.string	"CORE_MMU_USER_PARAM_SHIFT SMALL_PAGE_SHIFT"
.LASF608:
	.string	"SPSR_64_MODE_SP_EL0 0x0"
.LASF295:
	.string	"CFG_CRYPTO_MD5 1"
.LASF1200:
	.string	"TEE_PANIC_ID_TA_CLOSESESSIONENTRYPOINT 0x00000101"
.LASF614:
	.string	"SPSR_64_DAIF_SHIFT 6"
.LASF872:
	.string	"OPTEE_MSG_RPC_SHM_TYPE_APPL 0"
.LASF203:
	.string	"__GCC_ATOMIC_BOOL_LOCK_FREE 2"
.LASF185:
	.string	"__DEC64_MAX__ 9.999999999999999E384DD"
.LASF855:
	.string	"OPTEE_MSG_OS_OPTEE_UUID_2 0xbc5e0002"
.LASF1417:
	.string	"UNWIND(...) __VA_ARGS__"
.LASF579:
	.string	"ARM64_H "
.LASF1001:
	.string	"TEE_ERROR_STORAGE_NOT_AVAILABLE 0xF0100003"
.LASF969:
	.ascii	"CIRCLEQ_INSERT_TAIL(head,elm,field) do { QUEUEDEBUG_CIRCLEQ"
	.string	"_HEAD((head), field) (elm)->field.cqe_next = (void *)(head); (elm)->field.cqe_prev = (head)->cqh_last; if ((head)->cqh_first == (void *)(head)) (head)->cqh_first = (elm); else (head)->cqh_last->field.cqe_next = (elm); (head)->cqh_last = (elm); } while ( 0)"
.LASF154:
	.string	"__DBL_MIN__ ((double)2.22507385850720138309023271733240406e-308L)"
.LASF1558:
	.string	"tqh_first"
.LASF444:
	.string	"INT8_MAX 0x7f"
.LASF497:
	.string	"SIZE_4M UINTPTR_C(0x400000)"
.LASF482:
	.string	"SIZE_MAX ULONG_MAX"
.LASF818:
	.string	"PRIxPASZ PRIxPTR"
.LASF513:
	.string	"BIT32(nr) (UINT32_C(1) << (nr))"
.LASF559:
	.string	"ARM32_CPSR_MODE_USR 0x10"
.LASF437:
	.string	"_STDINT_H "
.LASF929:
	.string	"SIMPLEQ_FOREACH(var,head,field) for ((var) = ((head)->sqh_first); (var); (var) = ((var)->field.sqe_next))"
.LASF1587:
	.string	"USER_TA_PROP_TYPE_UUID"
.LASF1266:
	.string	"TEE_PANIC_ID_TEE_GETOPERATIONINFO 0x00000C04"
.LASF1143:
	.string	"TEE_ALG_ECDH_P256 0x80003042"
.LASF1506:
	.string	"__register_memory1_ul(name,type,addr,size,section,id) __register_memory2_ul(name, type, addr, size, #section, id)"
.LASF1140:
	.string	"TEE_ALG_ECDSA_P521 0x70005041"
.LASF230:
	.string	"__ARM_PCS_AAPCS64 1"
.LASF1192:
	.string	"TEE_ATTR_ECC_CURVE 0xF0000441"
.LASF1236:
	.string	"TEE_PANIC_ID_TEE_GETOBJECTVALUEATTRIBUTE 0x00000704"
.LASF420:
	.string	"INT_MIN (-INT_MAX - 1)"
.LASF1365:
	.string	"TA_PROP_STR_DATA_SIZE \"gpd.ta.dataSize\""
.LASF231:
	.string	"__ARM_SIZEOF_WCHAR_T 4"
.LASF1491:
	.string	"CORE_MMU_DEVICE_MASK (CORE_MMU_DEVICE_SIZE - 1)"
.LASF27:
	.string	"__SIZEOF_DOUBLE__ 8"
.LASF316:
	.string	"CFG_LPAE_ADDR_SPACE_SIZE (1ull << 32)"
.LASF1391:
	.string	"TRACE_ERROR TRACE_MIN"
.LASF480:
	.string	"INTMAX_MIN INT64_MIN"
.LASF891:
	.string	"LIST_FIRST(head) ((head)->lh_first)"
.LASF761:
	.string	"_BSD_WCHAR_T_ "
.LASF607:
	.string	"SPSR_64_MODE_SP_MASK 0x1"
.LASF618:
	.string	"SPSR_32_E_SHIFT 9"
.LASF663:
	.string	"ESR_EC_ILLEGAL 0x0e"
.LASF723:
	.string	"_STDDEF_H "
.LASF1435:
	.string	"TEE_MATTR_PR BIT(4)"
.LASF626:
	.string	"SPSR_32_MODE_SHIFT 0"
.LASF410:
	.string	"__compiler_sub_overflow(a,b,res) __builtin_sub_overflow((a), (b), (res))"
.LASF774:
	.string	"offsetof(TYPE,MEMBER) __builtin_offsetof (TYPE, MEMBER)"
.LASF170:
	.string	"__LDBL_DENORM_MIN__ 6.47517511943802511092443895822764655e-4966L"
.LASF1615:
	.string	"panic_code"
.LASF1517:
	.string	"THREAD_CLF_ABORT_SHIFT 1"
.LASF211:
	.string	"__GCC_ATOMIC_LLONG_LOCK_FREE 2"
.LASF1218:
	.string	"TEE_PANIC_ID_TEE_CLOSETASESSION 0x00000401"
.LASF1170:
	.string	"TEE_ATTR_RSA_PRIVATE_EXPONENT 0xC0000330"
.LASF1473:
	.string	"TA_RAM_SIZE (ROUNDDOWN(TZDRAM_BASE + (TZDRAM_SIZE - TEE_RAM_VA_SIZE - TEE_SDP_TEST_MEM_SIZE), CORE_MMU_PGDIR_SIZE) - TA_RAM_START)"
.LASF549:
	.string	"CTR_ERG_SHIFT 20"
.LASF1446:
	.string	"TEE_MATTR_URWX (TEE_MATTR_URW | TEE_MATTR_UX)"
.LASF1516:
	.string	"THREAD_CLF_TMP_SHIFT 0"
.LASF1352:
	.string	"TA_FLAG_SINGLE_INSTANCE (1 << 2)"
.LASF1007:
	.string	"TEE_ERROR_EXCESS_DATA 0xFFFF0004"
.LASF1409:
	.string	"trace_printf_helper_raw(level,level_ok,...) trace_printf(NULL, 0, (level), (level_ok), __VA_ARGS__)"
.LASF1245:
	.string	"TEE_PANIC_ID_TEE_INITVALUEATTRIBUTE 0x00000806"
.LASF18:
	.string	"__OPTIMIZE__ 1"
.LASF643:
	.string	"TCR_TG1_4KB SHIFT_U32(2, 30)"
.LASF1063:
	.string	"TEE_USAGE_ENCRYPT 0x00000002"
.LASF840:
	.string	"OPTEE_MSG_LOGIN_APPLICATION 0x00000004"
.LASF1562:
	.string	"fpsr"
.LASF281:
	.string	"CFG_CRYPTO_CBC_MAC 1"
.LASF673:
	.string	"ESR_EC_AARCH32_FP 0x28"
.LASF776:
	.string	"__PRI64_PREFIX \"l\""
.LASF347:
	.string	"CFG_TEE_CORE_NB_CORE 2"
.LASF323:
	.string	"CFG_OS_REV_REPORTS_GIT_SHA1 1"
.LASF1496:
	.string	"CORE_MMU_USER_PARAM_SIZE (1 << CORE_MMU_USER_PARAM_SHIFT)"
.LASF246:
	.string	"__AARCH64_CMODEL_SMALL__"
.LASF566:
	.string	"ARM32_CPSR_MODE_SYS 0x1f"
.LASF1709:
	.string	"thread_system_off_handler_ptr"
.LASF653:
	.string	"ESR_EC_MASK 0x3f"
.LASF581:
	.string	"__restrict restrict"
.LASF521:
	.string	"SUB_OVERFLOW(a,b,res) __compiler_sub_overflow((a), (b), (res))"
.LASF531:
	.string	"CORTEX_A7_PART_NUM 0xC07"
.LASF1669:
	.string	"tee_mm_pool_t"
.LASF17:
	.string	"__OPTIMIZE_SIZE__ 1"
.LASF385:
	.string	"__weak __attribute__((weak))"
.LASF560:
	.string	"ARM32_CPSR_MODE_FIQ 0x11"
.LASF820:
	.string	"_OPTEE_MSG_H "
.LASF933:
	.string	"_TAILQ_HEAD(name,type,qual) struct name { qual type *tqh_first; qual type *qual *tqh_last; }"
.LASF948:
	.ascii	"TAILQ_REMOVE(head,elm,field) do { QUEUEDEBUG_TAILQ_PREREMOVE"
	.ascii	"((head), (elm), field) QUEUEDEBUG_TAILQ_OP((elm), f"
	.string	"ield) if (((elm)->field.tqe_next) != NULL) (elm)->field.tqe_next->field.tqe_prev = (elm)->field.tqe_prev; else (head)->tqh_last = (elm)->field.tqe_prev; *(elm)->field.tqe_prev = (elm)->field.tqe_next; QUEUEDEBUG_TAILQ_POSTREMOVE((elm), field); } while ( 0)"
.LASF1357:
	.string	"TA_FLAG_CACHE_MAINTENANCE (1 << 7)"
.LASF293:
	.string	"CFG_CRYPTO_HKDF 1"
.LASF387:
	.string	"__pure __attribute__((pure))"
.LASF847:
	.string	"OPTEE_MSG_UID_2 0xaf630002"
.LASF758:
	.string	"_T_WCHAR "
.LASF751:
	.string	"_SIZET_ "
.LASF47:
	.string	"__INT8_TYPE__ signed char"
.LASF524:
	.string	"MIDR_PRIMARY_PART_NUM_SHIFT 4"
.LASF201:
	.string	"__GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 1"
.LASF371:
	.string	"_CFG_CRYPTO_WITH_CBC 1"
.LASF724:
	.string	"_STDDEF_H_ "
.LASF698:
	.string	"ESR_FSC_PERMF_L3 0x0f"
.LASF1026:
	.string	"TEE_ERROR_TIME_NOT_SET 0xFFFF5000"
.LASF993:
	.string	"TEE_API_TYPES_H "
.LASF707:
	.string	"PAR_F BIT32(0)"
.LASF949:
	.string	"TAILQ_FOREACH(var,head,field) for ((var) = ((head)->tqh_first); (var); (var) = ((var)->field.tqe_next))"
.LASF1337:
	.string	"TEE_MEMREF_2_USED 0x00000004"
.LASF229:
	.string	"__ARM_FEATURE_UNALIGNED 1"
.LASF1522:
	.string	"THREAD_CLF_IRQ (1 << THREAD_CLF_IRQ_SHIFT)"
.LASF1395:
	.string	"TRACE_MAX TRACE_FLOW"
.LASF1481:
	.string	"CONSOLE_UART_CLK_IN_HZ 1"
.LASF1203:
	.string	"TEE_PANIC_ID_TA_INVOKECOMMANDENTRYPOINT 0x00000104"
.LASF1158:
	.string	"TEE_TYPE_DSA_KEYPAIR 0xA1000031"
.LASF1698:
	.string	"rpc_mobj"
.LASF1595:
	.string	"ta_props"
.LASF625:
	.string	"SPSR_32_T_THUMB 0x1"
.LASF1405:
	.string	"INMSG(...) FMSG(\"> \" __VA_ARGS__)"
.LASF63:
	.string	"__INT_FAST8_TYPE__ signed char"
.LASF304:
	.string	"CFG_CRYPTO_XTS 1"
.LASF637:
	.string	"TCR_A1 BIT32(22)"
.LASF622:
	.string	"SPSR_32_T_SHIFT 5"
.LASF1155:
	.string	"TEE_TYPE_RSA_PUBLIC_KEY 0xA0000030"
.LASF1398:
	.string	"MAX_FUNC_PRINT_SIZE 32"
.LASF697:
	.string	"ESR_FSC_PERMF_L2 0x0e"
.LASF1514:
	.string	"THREAD_CLF_CURR_SHIFT 0"
.LASF1102:
	.string	"TEE_ALG_RSASSA_PKCS1_V1_5_SHA224 0x70003830"
.LASF1006:
	.string	"TEE_ERROR_ACCESS_CONFLICT 0xFFFF0003"
.LASF835:
	.string	"OPTEE_MSG_ATTR_CACHE_MASK GENMASK_32(2, 0)"
.LASF232:
	.string	"__ARM_FP_FAST"
.LASF601:
	.string	"DAIF_AIF (DAIF_A | DAIF_I | DAIF_F)"
.LASF1097:
	.string	"TEE_ALG_DES3_CBC_NOPAD 0x10000113"
.LASF1710:
	.string	"thread_system_reset_handler_ptr"
.LASF236:
	.string	"__ARM_BIG_ENDIAN"
.LASF1678:
	.string	"user_ta_prop_type"
.LASF1322:
	.string	"TEE_PANIC_ID_TEE_BIGINTCOMPUTEEXTENDEDGCD 0x00001B01"
.LASF963:
	.string	"CIRCLEQ_HEAD_INITIALIZER(head) { (void *)&head, (void *)&head }"
.LASF50:
	.string	"__INT64_TYPE__ long int"
.LASF875:
	.string	"OPTEE_MSG_RPC_CMD_BENCH_REG 20"
.LASF591:
	.string	"DAIFBIT_FIQ BIT32(0)"
.LASF184:
	.string	"__DEC64_MIN__ 1E-383DD"
.LASF720:
	.string	"DEFINE_U64_REG_READWRITE_FUNCS(reg) DEFINE_U64_REG_READ_FUNC(reg) DEFINE_U64_REG_WRITE_FUNC(reg)"
.LASF1165:
	.string	"TEE_TYPE_CORRUPTED_OBJECT 0xA00000BE"
.LASF1390:
	.string	"TRACE_MIN 1"
.LASF41:
	.string	"__WINT_TYPE__ unsigned int"
.LASF732:
	.string	"___int_ptrdiff_t_h "
.LASF1020:
	.string	"TEE_ERROR_EXTERNAL_CANCEL 0xFFFF0011"
.LASF1305:
	.string	"TEE_PANIC_ID_TEE_BIGINTCMP 0x00001801"
.LASF117:
	.string	"__INT_FAST8_MAX__ 0x7f"
.LASF1052:
	.string	"TEE_MALLOC_FILL_ZERO 0x00000000"
.LASF553:
	.string	"CTR_DMINLINE_MASK ((1 << 4) - 1)"
.LASF259:
	.string	"unix 1"
.LASF522:
	.string	"MUL_OVERFLOW(a,b,res) __compiler_mul_overflow((a), (b), (res))"
.LASF1639:
	.string	"cpu_resume_entry"
.LASF25:
	.string	"__SIZEOF_SHORT__ 2"
.LASF1662:
	.string	"offset"
.LASF1354:
	.string	"TA_FLAG_INSTANCE_KEEP_ALIVE (1 << 4)"
.LASF68:
	.string	"__UINT_FAST16_TYPE__ long unsigned int"
.LASF460:
	.string	"UINT_LEAST8_MAX UINT8_MAX"
.LASF1226:
	.string	"TEE_PANIC_ID_TEE_GETINSTANCEDATA 0x00000603"
.LASF1635:
	.string	"std_smc_entry"
.LASF97:
	.string	"__UINT8_MAX__ 0xff"
.LASF417:
	.string	"CHAR_MAX UCHAR_MAX"
.LASF1101:
	.string	"TEE_ALG_RSASSA_PKCS1_V1_5_SHA1 0x70002830"
.LASF1232:
	.string	"TEE_PANIC_ID_TEE_SETINSTANCEDATA 0x00000609"
.LASF406:
	.string	"__compiler_bswap16(x) __builtin_bswap16((x))"
.LASF1011:
	.string	"TEE_ERROR_ITEM_NOT_FOUND 0xFFFF0008"
.LASF1386:
	.string	"CORE_MMU_H "
.LASF1441:
	.string	"TEE_MATTR_UR BIT(7)"
.LASF1296:
	.string	"TEE_PANIC_ID_TEE_BIGINTFMMCONTEXTSIZEINU32 0x00001501"
.LASF345:
	.string	"CFG_TEE_CORE_EMBED_INTERNAL_TESTS 1"
.LASF121:
	.string	"__UINT_FAST8_MAX__ 0xff"
.LASF866:
	.string	"OPTEE_MSG_RPC_CMD_GET_TIME 3"
.LASF1714:
	.string	"/home/zt233/Documents/test-tz/optee_os"
.LASF704:
	.string	"CPACR_EL1_FPEN_EL1 0x1"
.LASF550:
	.string	"CTR_ERG_MASK 0xf"
.LASF952:
	.string	"TAILQ_FOREACH_REVERSE_SAFE(var,head,headname,field,prev) for ((var) = TAILQ_LAST((head), headname); (var) && ((prev) = TAILQ_PREV((var), headname, field), 1); (var) = (prev))"
.LASF279:
	.string	"CFG_CRYPTO_AES 1"
.LASF218:
	.string	"__SIZEOF_WINT_T__ 4"
.LASF113:
	.string	"__UINT_LEAST32_MAX__ 0xffffffffU"
.LASF434:
	.string	"ULLONG_MAX (LLONG_MAX * 2ULL + 1ULL)"
.LASF1277:
	.string	"TEE_PANIC_ID_TEE_MACCOMPUTEFINAL 0x00000F02"
.LASF1660:
	.string	"pool"
.LASF1105:
	.string	"TEE_ALG_RSASSA_PKCS1_V1_5_SHA512 0x70006830"
.LASF1136:
	.string	"TEE_ALG_ECDSA_P192 0x70001041"
.LASF536:
	.string	"CORTEX_A57_PART_NUM 0xD07"
.LASF1519:
	.string	"THREAD_CLF_FIQ_SHIFT 3"
.LASF1054:
	.string	"TEE_DATA_FLAG_ACCESS_READ 0x00000001"
.LASF817:
	.string	"PRIxPA PRIxPTR"
.LASF315:
	.string	"CFG_LIBUTILS_WITH_ISOC 1"
.LASF1539:
	.string	"paddr_t"
.LASF516:
	.string	"SHIFT_U64(v,shift) ((uint64_t)(v) << (shift))"
.LASF116:
	.string	"__UINT64_C(c) c ## UL"
.LASF16:
	.string	"__ATOMIC_CONSUME 1"
.LASF56:
	.string	"__INT_LEAST16_TYPE__ short int"
.LASF1674:
	.string	"default_nsec_shm_size"
.LASF865:
	.string	"OPTEE_MSG_FUNCID_CALL_WITH_ARG 0x0004"
.LASF309:
	.string	"CFG_GIC 1"
.LASF1058:
	.string	"TEE_DATA_FLAG_SHARE_WRITE 0x00000020"
.LASF207:
	.string	"__GCC_ATOMIC_WCHAR_T_LOCK_FREE 2"
.LASF833:
	.string	"OPTEE_MSG_ATTR_NONCONTIG BIT(9)"
.LASF368:
	.string	"_CFG_CRYPTO_WITH_ACIPHER 1"
.LASF1695:
	.string	"kern_sp"
.LASF57:
	.string	"__INT_LEAST32_TYPE__ int"
.LASF1511:
	.string	"register_ddr(addr,size) __register_memory1(#addr, MEM_AREA_DDR_OVERALL, (addr), (size), phys_ddr_overall_section, __COUNTER__)"
.LASF1307:
	.string	"TEE_PANIC_ID_TEE_BIGINTGETBIT 0x00001803"
.LASF1145:
	.string	"TEE_ALG_ECDH_P521 0x80005042"
.LASF1711:
	.string	"thread_user_kcode_offset"
.LASF823:
	.string	"OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT 0x2"
.LASF335:
	.string	"CFG_SHMEM_SIZE 0x00200000"
.LASF1093:
	.string	"TEE_ALG_DES_CBC_NOPAD 0x10000111"
.LASF443:
	.string	"INT64_MIN (-0x7fffffffffffffffL-1)"
.LASF270:
	.string	"CFG_CORE_HEAP_SIZE 65536"
.LASF1350:
	.string	"tee_mtime_perftest() do { } while (0)"
.LASF1141:
	.string	"TEE_ALG_ECDH_P192 0x80001042"
.LASF826:
	.string	"OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT 0x6"
.LASF1230:
	.string	"TEE_PANIC_ID_TEE_MEMMOVE 0x00000607"
.LASF1113:
	.string	"TEE_ALG_RSAES_PKCS1_OAEP_MGF1_SHA1 0x60210230"
.LASF339:
	.string	"CFG_TA_FLOAT_SUPPORT 1"
.LASF642:
	.string	"TCR_EL1_IPS_SHIFT 32"
.LASF148:
	.string	"__DBL_MIN_EXP__ (-1021)"
.LASF722:
	.string	"TYPES_EXT_H "
.LASF1303:
	.string	"TEE_PANIC_ID_TEE_BIGINTCONVERTTOOCTETSTRING 0x00001703"
.LASF1596:
	.string	"ta_num_props"
.LASF651:
	.string	"TCR_SHX_ISH 0x3"
.LASF1019:
	.string	"TEE_ERROR_SHORT_BUFFER 0xFFFF0010"
.LASF1425:
	.string	"COMPILE_TIME_ASSERT(x) do { switch (0) { case 0: case ((x) ? 1: 0): default : break; } } while (0)"
.LASF1047:
	.string	"TEE_PROPSET_CURRENT_CLIENT (TEE_PropSetHandle)0xFFFFFFFE"
.LASF1344:
	.string	"mdbg_check(x) do { } while (0)"
.LASF1366:
	.string	"TA_PROP_STR_STACK_SIZE \"gpd.ta.stackSize\""
.LASF547:
	.string	"CTR_CWG_SHIFT 24"
.LASF1626:
	.string	"enter_invoke_cmd"
.LASF402:
	.string	"__early_ta __section(\".rodata.early_ta\")"
.LASF1561:
	.string	"vfp_state"
.LASF779:
	.string	"PRId16 \"d\""
.LASF1308:
	.string	"TEE_PANIC_ID_TEE_BIGINTGETBITCOUNT 0x00001804"
.LASF244:
	.string	"__ARM_FEATURE_CRC32"
.LASF178:
	.string	"__DEC32_MAX__ 9.999999E96DF"
.LASF490:
	.string	"UINT64_C(v) v ## UL"
.LASF283:
	.string	"CFG_CRYPTO_CMAC 1"
.LASF759:
	.string	"__WCHAR_T "
.LASF1282:
	.string	"TEE_PANIC_ID_TEE_AEINIT 0x00001003"
.LASF809:
	.string	"bool _Bool"
.LASF435:
	.string	"NL_ARGMAX 9"
.LASF869:
	.string	"OPTEE_MSG_RPC_WAIT_QUEUE_WAKEUP 1"
.LASF1590:
	.string	"USER_TA_PROP_TYPE_BINARY_BLOCK"
.LASF1068:
	.string	"TEE_USAGE_DERIVE 0x00000040"
.LASF1193:
	.string	"TEE_ATTR_BIT_PROTECTED (1 << 28)"
.LASF1168:
	.string	"TEE_ATTR_RSA_MODULUS 0xD0000130"
.LASF1330:
	.string	"TEE_PARAM_TYPE_SET(t,i) (((uint32_t)(t) & 0xF) << ((i)*4))"
.LASF308:
	.string	"CFG_GENERIC_BOOT 1"
.LASF583:
	.string	"SCTLR_M BIT32(0)"
.LASF537:
	.string	"CORTEX_A72_PART_NUM 0xD08"
.LASF394:
	.string	"__used __attribute__((__used__))"
.LASF328:
	.string	"CFG_REE_FS_TA 1"
.LASF1126:
	.string	"TEE_ALG_SHA256 0x50000004"
.LASF1706:
	.string	"thread_cpu_off_handler_ptr"
.LASF1204:
	.string	"TEE_PANIC_ID_TA_OPENSESSIONENTRYPOINT 0x00000105"
.LASF358:
	.string	"CFG_WITH_ARM_TRUSTED_FW 1"
.LASF635:
	.string	"TCR_SH0_SHIFT 12"
.LASF529:
	.string	"MIDR_IMPLEMENTER_MASK (BIT(MIDR_IMPLEMENTER_WIDTH) - 1)"
.LASF610:
	.string	"SPSR_64_MODE_EL_SHIFT 2"
.LASF543:
	.string	"CLIDR_LOUIS_SHIFT 21"
.LASF322:
	.string	"CFG_OPTEE_REVISION_MINOR 1"
.LASF655:
	.string	"ESR_EC_WFI 0x01"
.LASF1124:
	.string	"TEE_ALG_SHA1 0x50000002"
.LASF380:
	.string	"ARM_H "
.LASF1677:
	.string	"asid"
.LASF979:
	.string	"CIRCLEQ_LOOP_PREV(head,elm,field) (((elm)->field.cqe_prev == (void *)(head)) ? ((head)->cqh_last) : (elm->field.cqe_prev))"
.LASF1634:
	.string	"thread_vector_table"
.LASF1399:
	.string	"trace_printf_helper(level,level_ok,...) trace_printf(__func__, __LINE__, (level), (level_ok), __VA_ARGS__)"
.LASF1376:
	.string	"THREAD_ID_INVALID -1"
.LASF893:
	.string	"SLIST_HEAD(name,type) struct name { struct type *slh_first; }"
.LASF194:
	.string	"__DEC128_SUBNORMAL_MIN__ 0.000000000000000000000000000000001E-6143DL"
.LASF1566:
	.string	"TEE_Result"
.LASF227:
	.string	"__ARM_FEATURE_CLZ 1"
.LASF1434:
	.string	"TEE_MATTR_TABLE BIT(3)"
.LASF551:
	.string	"CTR_DMINLINE_SHIFT 16"
.LASF509:
	.string	"CONCAT(x,y) _CONCAT(x, y)"
.LASF1118:
	.string	"TEE_ALG_RSA_NOPAD 0x60000030"
.LASF1571:
	.string	"TEE_UUID"
.LASF175:
	.string	"__DEC32_MIN_EXP__ (-94)"
.LASF87:
	.string	"__INTMAX_MAX__ 0x7fffffffffffffffL"
.LASF1482:
	.string	"SMALL_PAGE_SHIFT 12"
.LASF408:
	.string	"__HAVE_BUILTIN_OVERFLOW 1"
.LASF98:
	.string	"__UINT16_MAX__ 0xffff"
.LASF970:
	.ascii	"CIRCLEQ_REMOVE(head,elm,field) do { QUEUEDEBUG_CIRCLEQ_HEAD("
	.ascii	"(head), field) QUEUEDEBUG_CIRCLEQ_ELM((head), (elm), field) "
	.ascii	"if ((elm)->field.cqe_next == (void *)(head)) (head)->cqh_las"
	.ascii	"t = (elm)->field.cqe_prev; else (elm)->field.cqe_ne"
	.string	"xt->field.cqe_prev = (elm)->field.cqe_prev; if ((elm)->field.cqe_prev == (void *)(head)) (head)->cqh_first = (elm)->field.cqe_next; else (elm)->field.cqe_prev->field.cqe_next = (elm)->field.cqe_next; QUEUEDEBUG_CIRCLEQ_POSTREMOVE((elm), field) } while ( 0)"
.LASF856:
	.string	"OPTEE_MSG_OS_OPTEE_UUID_3 0xa5d5c51b"
.LASF1228:
	.string	"TEE_PANIC_ID_TEE_MEMCOMPARE 0x00000605"
.LASF1029:
	.string	"TEE_PARAM_TYPE_VALUE_INPUT 1"
.LASF1464:
	.string	"__MM_GENERIC_RAM_LAYOUT_H "
.LASF423:
	.string	"LLONG_MAX __LONG_LONG_MAX__"
.LASF1213:
	.string	"TEE_PANIC_ID_TEE_GETPROPERTYASUUID 0x00000209"
.LASF396:
	.string	"__cold __attribute__((__cold__))"
.LASF1676:
	.string	"user_map"
.LASF159:
	.string	"__DBL_HAS_QUIET_NAN__ 1"
.LASF401:
	.string	"__rodata_unpaged __section(\".rodata.__unpaged\")"
.LASF174:
	.string	"__DEC32_MANT_DIG__ 7"
.LASF1426:
	.string	"KERNEL_USER_TA_H "
.LASF677:
	.string	"ESR_EC_BREAKPT_EL1 0x31"
.LASF169:
	.string	"__LDBL_EPSILON__ 1.92592994438723585305597794258492732e-34L"
.LASF1643:
	.string	"system_reset_entry"
.LASF141:
	.string	"__FLT_EPSILON__ 1.19209289550781250000000000000000000e-7F"
.LASF1283:
	.string	"TEE_PANIC_ID_TEE_AEUPDATE 0x00001004"
.LASF743:
	.string	"_SIZE_T_ "
.LASF427:
	.string	"SCHAR_MIN (-SCHAR_MAX - 1)"
.LASF257:
	.string	"__unix 1"
.LASF172:
	.string	"__LDBL_HAS_INFINITY__ 1"
.LASF153:
	.string	"__DBL_MAX__ ((double)1.79769313486231570814527423731704357e+308L)"
.LASF1107:
	.string	"TEE_ALG_RSASSA_PKCS1_PSS_MGF1_SHA1 0x70212930"
.LASF353:
	.string	"CFG_TEE_SDP_MEM_SIZE 0x00400000"
.LASF1563:
	.string	"fpcr"
.LASF411:
	.string	"__compiler_mul_overflow(a,b,res) __builtin_mul_overflow((a), (b), (res))"
.LASF1572:
	.string	"login"
.LASF277:
	.string	"CFG_CRYPTOLIB_DIR core/lib/libtomcrypt"
.LASF1292:
	.string	"TEE_PANIC_ID_TEE_GETSYSTEMTIME 0x00001402"
.LASF1003:
	.string	"TEE_ERROR_GENERIC 0xFFFF0000"
.LASF997:
	.string	"TEE_TIMEOUT_INFINITE 0xFFFFFFFF"
.LASF928:
	.ascii	"SIMPLEQ_REMOVE(head,elm,type,field) do { if ((head)->sqh_fir"
	.ascii	"st == (elm)) { SIMPLEQ_REMOVE_HEAD((head), field); } else"
	.string	" { struct type *curelm = (head)->sqh_first; while (curelm->field.sqe_next != (elm)) curelm = curelm->field.sqe_next; if ((curelm->field.sqe_next = curelm->field.sqe_next->field.sqe_next) == NULL) (head)->sqh_last = &(curelm)->field.sqe_next; } } while ( 0)"
.LASF569:
	.string	"ARM32_CPSR_F (1 << 6)"
.LASF1598:
	.string	"ta_params"
.LASF472:
	.string	"UINT_FAST8_MAX UINT8_MAX"
.LASF1167:
	.string	"TEE_ATTR_SECRET_VALUE 0xC0000000"
.LASF798:
	.string	"PRIx8 \"x\""
.LASF676:
	.string	"ESR_EC_BREAKPT_EL0 0x30"
.LASF1293:
	.string	"TEE_PANIC_ID_TEE_GETTAPERSISTENTTIME 0x00001403"
.LASF64:
	.string	"__INT_FAST16_TYPE__ long int"
.LASF832:
	.string	"OPTEE_MSG_ATTR_META BIT(8)"
.LASF1661:
	.string	"next"
.LASF1415:
	.string	"SMSG(...) trace_printf(__func__, __LINE__, TRACE_ERROR, true, __VA_ARGS__)"
.LASF1262:
	.string	"TEE_PANIC_ID_TEE_WRITEOBJECTDATA 0x00000B04"
.LASF298:
	.string	"CFG_CRYPTO_SHA1 1"
.LASF143:
	.string	"__FLT_HAS_DENORM__ 1"
.LASF1673:
	.string	"default_nsec_shm_paddr"
.LASF1310:
	.string	"TEE_PANIC_ID_TEE_BIGINTADD 0x00001901"
.LASF146:
	.string	"__DBL_MANT_DIG__ 53"
.LASF300:
	.string	"CFG_CRYPTO_SHA256 1"
.LASF683:
	.string	"ESR_EC_AARCH64_BRK 0x3c"
.LASF1174:
	.string	"TEE_ATTR_RSA_EXPONENT2 0xC0000730"
.LASF1325:
	.string	"TEE_PANIC_ID_TEE_BIGINTCOMPUTEFMM 0x00001C01"
.LASF927:
	.string	"SIMPLEQ_REMOVE_HEAD(head,field) do { if (((head)->sqh_first = (head)->sqh_first->field.sqe_next) == NULL) (head)->sqh_last = &(head)->sqh_first; } while ( 0)"
.LASF1022:
	.string	"TEE_ERROR_TARGET_DEAD 0xFFFF3024"
.LASF392:
	.string	"__unused __attribute__((unused))"
.LASF412:
	.string	"__compiler_compare_and_swap(p,oval,nval) __atomic_compare_exchange_n((p), (oval), (nval), true, __ATOMIC_ACQUIRE, __ATOMIC_RELAXED)"
.LASF1679:
	.string	"thread_state"
.LASF457:
	.string	"INT_LEAST16_MAX INT16_MAX"
.LASF478:
	.string	"UINTPTR_MAX ULONG_MAX"
.LASF193:
	.string	"__DEC128_EPSILON__ 1E-33DL"
.LASF737:
	.string	"__SIZE_T__ "
.LASF160:
	.string	"__LDBL_MANT_DIG__ 113"
.LASF59:
	.string	"__UINT_LEAST8_TYPE__ unsigned char"
.LASF937:
	.string	"TAILQ_ENTRY(type) _TAILQ_ENTRY(struct type,)"
.LASF1037:
	.string	"TEE_LOGIN_GROUP 0x00000002"
.LASF219:
	.string	"__SIZEOF_PTRDIFF_T__ 8"
.LASF1246:
	.string	"TEE_PANIC_ID_TEE_POPULATETRANSIENTOBJECT 0x00000807"
.LASF669:
	.string	"ESR_EC_PC_ALIGN 0x22"
.LASF44:
	.string	"__CHAR16_TYPE__ short unsigned int"
.LASF1500:
	.string	"TEE_RAM_VA_START TEE_RAM_START"
.LASF1032:
	.string	"TEE_PARAM_TYPE_MEMREF_INPUT 5"
.LASF1152:
	.string	"TEE_TYPE_HMAC_SHA256 0xA0000004"
.LASF795:
	.string	"PRIu32 \"u\""
.LASF1079:
	.string	"TEE_OPERATION_KEY_DERIVATION 8"
.LASF790:
	.string	"PRIo32 \"o\""
.LASF247:
	.string	"__AARCH64_CMODEL_LARGE__"
.LASF807:
	.string	"PRIXPTR __PRIPTR_PREFIX \"X\""
.LASF1025:
	.string	"TEE_ERROR_SIGNATURE_INVALID 0xFFFF3072"
.LASF398:
	.string	"__data __section(\".data\")"
.LASF950:
	.string	"TAILQ_FOREACH_SAFE(var,head,field,next) for ((var) = ((head)->tqh_first); (var) != NULL && ((next) = TAILQ_NEXT(var, field), 1); (var) = (next))"
.LASF431:
	.string	"USHRT_MAX (SHRT_MAX * 2 + 1)"
.LASF1340:
	.string	"UTEE_TYPES_H "
.LASF1244:
	.string	"TEE_PANIC_ID_TEE_INITREFATTRIBUTE 0x00000805"
.LASF1419:
	.string	"EPRINT_STACK() print_kernel_stack(TRACE_ERROR)"
.LASF1406:
	.string	"OUTMSG(...) FMSG(\"< \" __VA_ARGS__)"
.LASF140:
	.string	"__FLT_MIN__ 1.17549435082228750796873653722224568e-38F"
.LASF1551:
	.string	"spin_lock"
.LASF1206:
	.string	"TEE_PANIC_ID_TEE_FREEPROPERTYENUMERATOR 0x00000202"
.LASF1106:
	.string	"TEE_ALG_RSASSA_PKCS1_V1_5_MD5SHA1 0x7000F830"
.LASF1483:
	.string	"SMALL_PAGE_MASK 0x00000fff"
.LASF362:
	.string	"CFG_WITH_STATS 1"
.LASF38:
	.string	"__SIZE_TYPE__ long unsigned int"
.LASF164:
	.string	"__LDBL_MAX_EXP__ 16384"
.LASF706:
	.string	"CPACR_EL1_FPEN(x) ((x) >> CPACR_EL1_FPEN_SHIFT & CPACR_EL1_FPEN_MASK)"
.LASF1526:
	.string	"short int"
.LASF1505:
	.string	"__register_memory1(name,type,addr,size,section,id) __register_memory2(name, type, addr, size, #section, id)"
.LASF6:
	.string	"__GNUC_MINOR__ 2"
.LASF1680:
	.string	"THREAD_STATE_FREE"
.LASF1120:
	.string	"TEE_ALG_DSA_SHA224 0x70003131"
.LASF2:
	.string	"__STDC_UTF_16__ 1"
.LASF1591:
	.string	"user_ta_property"
.LASF1471:
	.string	"TEE_RAM_PH_SIZE TEE_RAM_VA_SIZE"
.LASF863:
	.string	"OPTEE_MSG_CMD_REGISTER_SHM 4"
.LASF1588:
	.string	"USER_TA_PROP_TYPE_IDENTITY"
.LASF20:
	.string	"_LP64 1"
.LASF998:
	.string	"TEE_SUCCESS 0x00000000"
.LASF186:
	.string	"__DEC64_EPSILON__ 1E-15DD"
.LASF486:
	.string	"UINT16_C(v) v"
.LASF1100:
	.string	"TEE_ALG_RSASSA_PKCS1_V1_5_MD5 0x70001830"
.LASF123:
	.string	"__UINT_FAST32_MAX__ 0xffffffffffffffffUL"
.LASF5:
	.string	"__GNUC__ 6"
.LASF1458:
	.string	"TEE_MMU_UMAP_STACK_IDX 1"
.LASF1342:
	.string	"STDLIB_H "
.LASF1164:
	.string	"TEE_TYPE_GENERIC_SECRET 0xA0000000"
.LASF90:
	.string	"__UINTMAX_C(c) c ## UL"
.LASF829:
	.string	"OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT 0xa"
.LASF957:
	.string	"TAILQ_LAST(head,headname) (*(((struct headname *)((head)->tqh_last))->tqh_last))"
.LASF1312:
	.string	"TEE_PANIC_ID_TEE_BIGINTMUL 0x00001903"
.LASF905:
	.string	"SLIST_NEXT(elm,field) ((elm)->field.sle_next)"
.LASF39:
	.string	"__PTRDIFF_TYPE__ long int"
.LASF1586:
	.string	"USER_TA_PROP_TYPE_U32"
.LASF109:
	.string	"__UINT_LEAST8_MAX__ 0xff"
.LASF12:
	.string	"__ATOMIC_SEQ_CST 5"
.LASF1286:
	.string	"TEE_PANIC_ID_TEE_ASYMMETRICENCRYPT 0x00001102"
.LASF514:
	.string	"BIT64(nr) (UINT64_C(1) << (nr))"
.LASF1613:
	.string	"flags"
.LASF1670:
	.string	"tee_mm_sec_ddr"
.LASF1708:
	.string	"thread_cpu_resume_handler_ptr"
.LASF108:
	.string	"__INT64_C(c) c ## L"
.LASF702:
	.string	"CPACR_EL1_FPEN_MASK 0x3"
.LASF888:
	.string	"LIST_REMOVE(elm,field) do { QUEUEDEBUG_LIST_OP((elm), field) if ((elm)->field.le_next != NULL) (elm)->field.le_next->field.le_prev = (elm)->field.le_prev; *(elm)->field.le_prev = (elm)->field.le_next; QUEUEDEBUG_LIST_POSTREMOVE((elm), field) } while ( 0)"
.LASF523:
	.string	"CMP_TRILEAN(a,b) (__extension__({ __typeof__(a) _a = (a); __typeof__(b) _b = (b); _a > _b ? 1 : _a < _b ? -1 : 0; }))"
.LASF588:
	.string	"SCTLR_WXN BIT32(19)"
.LASF235:
	.string	"__AARCH64EB__"
.LASF272:
	.string	"CFG_CORE_TZSRAM_EMUL_SIZE 458752"
.LASF1156:
	.string	"TEE_TYPE_RSA_KEYPAIR 0xA1000030"
.LASF1062:
	.string	"TEE_USAGE_EXTRACTABLE 0x00000001"
.LASF389:
	.string	"__printf(a,b) __attribute__((format(printf, a, b)))"
	.ident	"GCC: (Linaro GCC 6.2-2016.11) 6.2.1 20161016"
	.section	.note.GNU-stack,"",@progbits
