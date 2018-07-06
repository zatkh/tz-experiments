	.arch armv8-a
	.file	"bounds.c"
// GNU C89 (Linaro GCC 6.2-2016.11) version 6.2.1 20161016 (aarch64-linux-gnu)
//	compiled by GNU C version 4.8.4, GMP version 6.1.0, MPFR version 3.1.4, MPC version 1.0.3, isl version none
// GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
// options passed:  -nostdinc -I ./arch/arm64/include
// -I arch/arm64/include/generated/uapi -I arch/arm64/include/generated
// -I include -I ./arch/arm64/include/uapi
// -I arch/arm64/include/generated/uapi -I ./include/uapi
// -I include/generated/uapi -imultiarch aarch64-linux-gnu
// -iprefix /home/zt233/Documents/test-tz/toolchains/aarch64/bin/../lib/gcc/aarch64-linux-gnu/6.2.1/
// -isysroot /home/zt233/Documents/test-tz/toolchains/aarch64/bin/../aarch64-linux-gnu/libc
// -D __KERNEL__ -D CONFIG_AS_LSE=1 -D CC_HAVE_ASM_GOTO -D KBUILD_STR(s)=#s
// -D KBUILD_BASENAME=KBUILD_STR(bounds)
// -D KBUILD_MODNAME=KBUILD_STR(bounds)
// -isystem /home/zt233/Documents/test-tz/toolchains/aarch64/bin/../lib/gcc/aarch64-linux-gnu/6.2.1/include
// -include ./include/linux/kconfig.h -MD kernel/.bounds.s.d
// kernel/bounds.c -mlittle-endian -mgeneral-regs-only
// -mpc-relative-literal-loads -march=armv8-a -mabi=lp64
// -auxbase-strip kernel/bounds.s -g -O2 -Wall -Wundef -Wstrict-prototypes
// -Wno-trigraphs -Werror=implicit-function-declaration
// -Wno-format-security -Wframe-larger-than=2048
// -Wno-unused-but-set-variable -Wdeclaration-after-statement
// -Wno-pointer-sign -Werror=implicit-int -Werror=strict-prototypes
// -Werror=date-time -std=gnu90 -fno-strict-aliasing -fno-common
// -fno-asynchronous-unwind-tables -fno-delete-null-pointer-checks
// -fno-stack-protector -fno-omit-frame-pointer -fno-optimize-sibling-calls
// -fno-var-tracking-assignments -fno-strict-overflow -fconserve-stack
// -fverbose-asm --param allow-store-data-races=0
// options enabled:  -faggressive-loop-optimizations -falign-labels
// -fauto-inc-dec -fbranch-count-reg -fcaller-saves
// -fchkp-check-incomplete-type -fchkp-check-read -fchkp-check-write
// -fchkp-instrument-calls -fchkp-narrow-bounds -fchkp-optimize
// -fchkp-store-bounds -fchkp-use-static-bounds
// -fchkp-use-static-const-bounds -fchkp-use-wrappers
// -fcombine-stack-adjustments -fcompare-elim -fcprop-registers
// -fcrossjumping -fcse-follow-jumps -fdefer-pop -fdevirtualize
// -fdevirtualize-speculatively -fdwarf2-cfi-asm -fearly-inlining
// -feliminate-unused-debug-types -fexpensive-optimizations
// -fforward-propagate -ffunction-cse -fgcse -fgcse-lm -fgnu-runtime
// -fgnu-unique -fguess-branch-probability -fhoist-adjacent-loads -fident
// -fif-conversion -fif-conversion2 -findirect-inlining -finline
// -finline-atomics -finline-functions-called-once -finline-small-functions
// -fipa-cp -fipa-cp-alignment -fipa-icf -fipa-icf-functions
// -fipa-icf-variables -fipa-profile -fipa-pure-const -fipa-ra
// -fipa-reference -fipa-sra -fira-hoist-pressure -fira-share-save-slots
// -fira-share-spill-slots -fisolate-erroneous-paths-dereference -fivopts
// -fkeep-static-consts -fleading-underscore -flifetime-dse -flra-remat
// -flto-odr-type-merging -fmath-errno -fmerge-constants
// -fmerge-debug-strings -fmove-loop-invariants -fomit-frame-pointer
// -foptimize-strlen -fpartial-inlining -fpeephole -fpeephole2 -fplt
// -fprefetch-loop-arrays -free -freg-struct-return -freorder-blocks
// -freorder-functions -frerun-cse-after-loop
// -fsched-critical-path-heuristic -fsched-dep-count-heuristic
// -fsched-group-heuristic -fsched-interblock -fsched-last-insn-heuristic
// -fsched-pressure -fsched-rank-heuristic -fsched-spec
// -fsched-spec-insn-heuristic -fsched-stalled-insns-dep -fschedule-fusion
// -fschedule-insns -fschedule-insns2 -fsection-anchors
// -fsemantic-interposition -fshow-column -fshrink-wrap -fsigned-zeros
// -fsplit-ivs-in-unroller -fsplit-wide-types -fssa-backprop -fssa-phiopt
// -fstdarg-opt -fstrict-volatile-bitfields -fsync-libcalls -fthread-jumps
// -ftoplevel-reorder -ftrapping-math -ftree-bit-ccp
// -ftree-builtin-call-dce -ftree-ccp -ftree-ch -ftree-coalesce-vars
// -ftree-copy-prop -ftree-cselim -ftree-dce -ftree-dominator-opts
// -ftree-dse -ftree-forwprop -ftree-fre -ftree-loop-if-convert
// -ftree-loop-im -ftree-loop-ivcanon -ftree-loop-optimize
// -ftree-parallelize-loops= -ftree-phiprop -ftree-pre -ftree-pta
// -ftree-reassoc -ftree-scev-cprop -ftree-sink -ftree-slsr -ftree-sra
// -ftree-switch-conversion -ftree-tail-merge -ftree-ter -ftree-vrp
// -funit-at-a-time -fvar-tracking -fverbose-asm -fzero-initialized-in-bss
// -mfix-cortex-a53-835769 -mfix-cortex-a53-843419 -mgeneral-regs-only
// -mglibc -mlittle-endian -momit-leaf-frame-pointer
// -mpc-relative-literal-loads

	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.align	2
	.p2align 3,,7
	.global	foo
	.type	foo, %function
foo:
.LFB252:
	.file 1 "kernel/bounds.c"
	.loc 1 16 0
	.cfi_startproc
	.loc 1 18 0
#APP
// 18 "kernel/bounds.c" 1
	
->NR_PAGEFLAGS 21 __NR_PAGEFLAGS	//
// 0 "" 2
	.loc 1 19 0
// 19 "kernel/bounds.c" 1
	
->MAX_NR_ZONES 3 __MAX_NR_ZONES	//
// 0 "" 2
	.loc 1 21 0
// 21 "kernel/bounds.c" 1
	
->NR_CPUS_BITS 6 ilog2(CONFIG_NR_CPUS)	//
// 0 "" 2
	.loc 1 23 0
// 23 "kernel/bounds.c" 1
	
->SPINLOCK_SIZE 4 sizeof(spinlock_t)	//
// 0 "" 2
#NO_APP
	ret
	.cfi_endproc
.LFE252:
	.size	foo, .-foo
.Letext0:
	.file 2 "include/linux/types.h"
	.file 3 "./arch/arm64/include/asm/memory.h"
	.file 4 "./arch/arm64/include/asm/hwcap.h"
	.file 5 "include/linux/init.h"
	.file 6 "./arch/arm64/include/asm/cachetype.h"
	.file 7 "include/linux/printk.h"
	.file 8 "include/linux/kernel.h"
	.file 9 "include/linux/page-flags.h"
	.file 10 "include/linux/mmzone.h"
	.file 11 "include/linux/lockdep.h"
	.file 12 "include/asm-generic/int-ll64.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x438
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.4byte	.LASF99
	.byte	0x1
	.4byte	.LASF100
	.4byte	.LASF101
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.4byte	.LASF0
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF1
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF2
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF3
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF4
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF5
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF6
	.uleb128 0x4
	.string	"u64"
	.byte	0xc
	.byte	0x19
	.4byte	0x5e
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF7
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF8
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF9
	.uleb128 0x5
	.4byte	0x7e
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF10
	.uleb128 0x6
	.byte	0x8
	.4byte	0x7e
	.uleb128 0x7
	.4byte	.LASF11
	.byte	0x2
	.byte	0x1d
	.4byte	0xa2
	.uleb128 0x2
	.byte	0x1
	.byte	0x2
	.4byte	.LASF12
	.uleb128 0x7
	.4byte	.LASF13
	.byte	0x2
	.byte	0xa2
	.4byte	0x65
	.uleb128 0x8
	.byte	0x4
	.byte	0x2
	.byte	0xaf
	.4byte	0xc9
	.uleb128 0x9
	.4byte	.LASF102
	.byte	0x2
	.byte	0xb0
	.4byte	0x49
	.byte	0
	.byte	0
	.uleb128 0x7
	.4byte	.LASF14
	.byte	0x2
	.byte	0xb1
	.4byte	0xb4
	.uleb128 0xa
	.4byte	.LASF15
	.byte	0x3
	.byte	0x69
	.4byte	0xa9
	.uleb128 0xa
	.4byte	.LASF16
	.byte	0x4
	.byte	0x34
	.4byte	0x50
	.uleb128 0xa
	.4byte	.LASF17
	.byte	0x4
	.byte	0x34
	.4byte	0x50
	.uleb128 0xa
	.4byte	.LASF18
	.byte	0x4
	.byte	0x3f
	.4byte	0x70
	.uleb128 0x2
	.byte	0x10
	.byte	0x7
	.4byte	.LASF19
	.uleb128 0x7
	.4byte	.LASF20
	.byte	0x5
	.byte	0x7c
	.4byte	0x112
	.uleb128 0x6
	.byte	0x8
	.4byte	0x118
	.uleb128 0xb
	.4byte	0x49
	.uleb128 0x6
	.byte	0x8
	.4byte	0x123
	.uleb128 0xc
	.uleb128 0xd
	.4byte	0x107
	.4byte	0x12f
	.uleb128 0xe
	.byte	0
	.uleb128 0xa
	.4byte	.LASF21
	.byte	0x5
	.byte	0x7f
	.4byte	0x124
	.uleb128 0xa
	.4byte	.LASF22
	.byte	0x5
	.byte	0x7f
	.4byte	0x124
	.uleb128 0xa
	.4byte	.LASF23
	.byte	0x5
	.byte	0x80
	.4byte	0x124
	.uleb128 0xa
	.4byte	.LASF24
	.byte	0x5
	.byte	0x80
	.4byte	0x124
	.uleb128 0xd
	.4byte	0x7e
	.4byte	0x166
	.uleb128 0xe
	.byte	0
	.uleb128 0xa
	.4byte	.LASF25
	.byte	0x5
	.byte	0x87
	.4byte	0x15b
	.uleb128 0xa
	.4byte	.LASF26
	.byte	0x5
	.byte	0x88
	.4byte	0x91
	.uleb128 0xa
	.4byte	.LASF27
	.byte	0x5
	.byte	0x89
	.4byte	0x50
	.uleb128 0xa
	.4byte	.LASF28
	.byte	0x5
	.byte	0x91
	.4byte	0x11d
	.uleb128 0xa
	.4byte	.LASF29
	.byte	0x5
	.byte	0x93
	.4byte	0x97
	.uleb128 0xa
	.4byte	.LASF30
	.byte	0x6
	.byte	0x28
	.4byte	0x70
	.uleb128 0xd
	.4byte	0x85
	.4byte	0x1b3
	.uleb128 0xe
	.byte	0
	.uleb128 0x5
	.4byte	0x1a8
	.uleb128 0xa
	.4byte	.LASF31
	.byte	0x7
	.byte	0xa
	.4byte	0x1b3
	.uleb128 0xa
	.4byte	.LASF32
	.byte	0x7
	.byte	0xb
	.4byte	0x1b3
	.uleb128 0xd
	.4byte	0x49
	.4byte	0x1d9
	.uleb128 0xe
	.byte	0
	.uleb128 0xa
	.4byte	.LASF33
	.byte	0x7
	.byte	0x2e
	.4byte	0x1ce
	.uleb128 0xa
	.4byte	.LASF34
	.byte	0x7
	.byte	0x9f
	.4byte	0x49
	.uleb128 0xa
	.4byte	.LASF35
	.byte	0x7
	.byte	0xa0
	.4byte	0x49
	.uleb128 0xa
	.4byte	.LASF36
	.byte	0x7
	.byte	0xa1
	.4byte	0x49
	.uleb128 0xf
	.4byte	.LASF38
	.uleb128 0x5
	.4byte	0x205
	.uleb128 0x10
	.4byte	.LASF37
	.byte	0x7
	.2byte	0x1a4
	.4byte	0x20a
	.uleb128 0xf
	.4byte	.LASF39
	.uleb128 0xa
	.4byte	.LASF40
	.byte	0x8
	.byte	0xfd
	.4byte	0x21b
	.uleb128 0x11
	.4byte	0x8a
	.4byte	0x23a
	.uleb128 0x12
	.4byte	0x49
	.byte	0
	.uleb128 0xa
	.4byte	.LASF41
	.byte	0x8
	.byte	0xfe
	.4byte	0x245
	.uleb128 0x6
	.byte	0x8
	.4byte	0x22b
	.uleb128 0x10
	.4byte	.LASF42
	.byte	0x8
	.2byte	0x1b7
	.4byte	0x49
	.uleb128 0x10
	.4byte	.LASF43
	.byte	0x8
	.2byte	0x1b8
	.4byte	0x49
	.uleb128 0x10
	.4byte	.LASF44
	.byte	0x8
	.2byte	0x1b9
	.4byte	0x49
	.uleb128 0x10
	.4byte	.LASF45
	.byte	0x8
	.2byte	0x1ba
	.4byte	0x49
	.uleb128 0x10
	.4byte	.LASF46
	.byte	0x8
	.2byte	0x1bb
	.4byte	0x49
	.uleb128 0x10
	.4byte	.LASF47
	.byte	0x8
	.2byte	0x1bc
	.4byte	0x49
	.uleb128 0x10
	.4byte	.LASF48
	.byte	0x8
	.2byte	0x1bd
	.4byte	0x49
	.uleb128 0x10
	.4byte	.LASF49
	.byte	0x8
	.2byte	0x1bf
	.4byte	0x97
	.uleb128 0x10
	.4byte	.LASF50
	.byte	0x8
	.2byte	0x1c6
	.4byte	0xc9
	.uleb128 0x10
	.4byte	.LASF51
	.byte	0x8
	.2byte	0x1ed
	.4byte	0x49
	.uleb128 0x10
	.4byte	.LASF52
	.byte	0x8
	.2byte	0x1ef
	.4byte	0x97
	.uleb128 0x13
	.4byte	.LASF61
	.byte	0x4
	.4byte	0x50
	.byte	0x8
	.2byte	0x1f2
	.4byte	0x2ff
	.uleb128 0x14
	.4byte	.LASF53
	.byte	0
	.uleb128 0x14
	.4byte	.LASF54
	.byte	0x1
	.uleb128 0x14
	.4byte	.LASF55
	.byte	0x2
	.uleb128 0x14
	.4byte	.LASF56
	.byte	0x3
	.uleb128 0x14
	.4byte	.LASF57
	.byte	0x4
	.byte	0
	.uleb128 0x10
	.4byte	.LASF58
	.byte	0x8
	.2byte	0x1f8
	.4byte	0x2cf
	.uleb128 0x10
	.4byte	.LASF59
	.byte	0x8
	.2byte	0x20b
	.4byte	0x1b3
	.uleb128 0x10
	.4byte	.LASF60
	.byte	0x8
	.2byte	0x216
	.4byte	0x1b3
	.uleb128 0x15
	.4byte	.LASF62
	.byte	0x4
	.4byte	0x50
	.byte	0x9
	.byte	0x4a
	.4byte	0x3e2
	.uleb128 0x14
	.4byte	.LASF63
	.byte	0
	.uleb128 0x14
	.4byte	.LASF64
	.byte	0x1
	.uleb128 0x14
	.4byte	.LASF65
	.byte	0x2
	.uleb128 0x14
	.4byte	.LASF66
	.byte	0x3
	.uleb128 0x14
	.4byte	.LASF67
	.byte	0x4
	.uleb128 0x14
	.4byte	.LASF68
	.byte	0x5
	.uleb128 0x14
	.4byte	.LASF69
	.byte	0x6
	.uleb128 0x14
	.4byte	.LASF70
	.byte	0x7
	.uleb128 0x14
	.4byte	.LASF71
	.byte	0x8
	.uleb128 0x14
	.4byte	.LASF72
	.byte	0x9
	.uleb128 0x14
	.4byte	.LASF73
	.byte	0xa
	.uleb128 0x14
	.4byte	.LASF74
	.byte	0xb
	.uleb128 0x14
	.4byte	.LASF75
	.byte	0xc
	.uleb128 0x14
	.4byte	.LASF76
	.byte	0xd
	.uleb128 0x14
	.4byte	.LASF77
	.byte	0xe
	.uleb128 0x14
	.4byte	.LASF78
	.byte	0xf
	.uleb128 0x14
	.4byte	.LASF79
	.byte	0x10
	.uleb128 0x14
	.4byte	.LASF80
	.byte	0x11
	.uleb128 0x14
	.4byte	.LASF81
	.byte	0x12
	.uleb128 0x14
	.4byte	.LASF82
	.byte	0x13
	.uleb128 0x14
	.4byte	.LASF83
	.byte	0x14
	.uleb128 0x14
	.4byte	.LASF84
	.byte	0x15
	.uleb128 0x14
	.4byte	.LASF85
	.byte	0x8
	.uleb128 0x14
	.4byte	.LASF86
	.byte	0xc
	.uleb128 0x14
	.4byte	.LASF87
	.byte	0x8
	.uleb128 0x14
	.4byte	.LASF88
	.byte	0x4
	.uleb128 0x14
	.4byte	.LASF89
	.byte	0x8
	.uleb128 0x14
	.4byte	.LASF90
	.byte	0xb
	.uleb128 0x14
	.4byte	.LASF91
	.byte	0xc
	.byte	0
	.uleb128 0x13
	.4byte	.LASF92
	.byte	0x4
	.4byte	0x50
	.byte	0xa
	.2byte	0x10d
	.4byte	0x40c
	.uleb128 0x14
	.4byte	.LASF93
	.byte	0
	.uleb128 0x14
	.4byte	.LASF94
	.byte	0x1
	.uleb128 0x14
	.4byte	.LASF95
	.byte	0x2
	.uleb128 0x14
	.4byte	.LASF96
	.byte	0x3
	.byte	0
	.uleb128 0xa
	.4byte	.LASF97
	.byte	0xb
	.byte	0x10
	.4byte	0x49
	.uleb128 0xa
	.4byte	.LASF98
	.byte	0xb
	.byte	0x11
	.4byte	0x49
	.uleb128 0x16
	.string	"foo"
	.byte	0x1
	.byte	0xf
	.8byte	.LFB252
	.8byte	.LFE252-.LFB252
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
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
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
	.uleb128 0x8
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
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
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
	.uleb128 0x8
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
	.uleb128 0x9
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
	.uleb128 0xa
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
	.uleb128 0xb
	.uleb128 0x15
	.byte	0
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x15
	.byte	0
	.uleb128 0x27
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x11
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
	.uleb128 0x12
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
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
	.uleb128 0x5
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
	.uleb128 0x16
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
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
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.8byte	0
	.8byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF38:
	.string	"file_operations"
.LASF70:
	.string	"PG_slab"
.LASF53:
	.string	"SYSTEM_BOOTING"
.LASF21:
	.string	"__con_initcall_start"
.LASF20:
	.string	"initcall_t"
.LASF79:
	.string	"PG_mappedtodisk"
.LASF31:
	.string	"linux_banner"
.LASF43:
	.string	"panic_timeout"
.LASF19:
	.string	"__int128 unsigned"
.LASF88:
	.string	"PG_savepinned"
.LASF89:
	.string	"PG_foreign"
.LASF74:
	.string	"PG_private"
.LASF2:
	.string	"short int"
.LASF50:
	.string	"panic_cpu"
.LASF32:
	.string	"linux_proc_banner"
.LASF58:
	.string	"system_state"
.LASF8:
	.string	"sizetype"
.LASF87:
	.string	"PG_pinned"
.LASF56:
	.string	"SYSTEM_POWER_OFF"
.LASF36:
	.string	"kptr_restrict"
.LASF80:
	.string	"PG_reclaim"
.LASF98:
	.string	"lock_stat"
.LASF39:
	.string	"atomic_notifier_head"
.LASF86:
	.string	"PG_fscache"
.LASF93:
	.string	"ZONE_DMA"
.LASF46:
	.string	"panic_on_io_nmi"
.LASF73:
	.string	"PG_reserved"
.LASF40:
	.string	"panic_notifier_list"
.LASF33:
	.string	"console_printk"
.LASF18:
	.string	"elf_hwcap"
.LASF54:
	.string	"SYSTEM_RUNNING"
.LASF63:
	.string	"PG_locked"
.LASF16:
	.string	"compat_elf_hwcap"
.LASF84:
	.string	"__NR_PAGEFLAGS"
.LASF11:
	.string	"bool"
.LASF0:
	.string	"signed char"
.LASF81:
	.string	"PG_swapbacked"
.LASF57:
	.string	"SYSTEM_RESTART"
.LASF91:
	.string	"PG_double_map"
.LASF34:
	.string	"printk_delay_msec"
.LASF5:
	.string	"long long int"
.LASF49:
	.string	"crash_kexec_post_notifiers"
.LASF95:
	.string	"ZONE_MOVABLE"
.LASF59:
	.string	"hex_asc"
.LASF75:
	.string	"PG_private_2"
.LASF37:
	.string	"kmsg_fops"
.LASF41:
	.string	"panic_blink"
.LASF27:
	.string	"reset_devices"
.LASF94:
	.string	"ZONE_NORMAL"
.LASF72:
	.string	"PG_arch_1"
.LASF23:
	.string	"__security_initcall_start"
.LASF1:
	.string	"unsigned char"
.LASF102:
	.string	"counter"
.LASF66:
	.string	"PG_uptodate"
.LASF83:
	.string	"PG_mlocked"
.LASF30:
	.string	"__icache_flags"
.LASF6:
	.string	"long long unsigned int"
.LASF4:
	.string	"unsigned int"
.LASF22:
	.string	"__con_initcall_end"
.LASF90:
	.string	"PG_slob_free"
.LASF65:
	.string	"PG_referenced"
.LASF67:
	.string	"PG_dirty"
.LASF26:
	.string	"saved_command_line"
.LASF61:
	.string	"system_states"
.LASF3:
	.string	"short unsigned int"
.LASF85:
	.string	"PG_checked"
.LASF9:
	.string	"char"
.LASF10:
	.string	"long int"
.LASF62:
	.string	"pageflags"
.LASF44:
	.string	"panic_on_oops"
.LASF45:
	.string	"panic_on_unrecovered_nmi"
.LASF52:
	.string	"early_boot_irqs_disabled"
.LASF12:
	.string	"_Bool"
.LASF68:
	.string	"PG_lru"
.LASF96:
	.string	"__MAX_NR_ZONES"
.LASF82:
	.string	"PG_unevictable"
.LASF55:
	.string	"SYSTEM_HALT"
.LASF17:
	.string	"compat_elf_hwcap2"
.LASF7:
	.string	"long unsigned int"
.LASF97:
	.string	"prove_locking"
.LASF78:
	.string	"PG_swapcache"
.LASF69:
	.string	"PG_active"
.LASF77:
	.string	"PG_head"
.LASF101:
	.string	"/home/zt233/Documents/test-tz/linux"
.LASF92:
	.string	"zone_type"
.LASF25:
	.string	"boot_command_line"
.LASF28:
	.string	"late_time_init"
.LASF71:
	.string	"PG_owner_priv_1"
.LASF100:
	.string	"kernel/bounds.c"
.LASF47:
	.string	"panic_on_warn"
.LASF99:
	.ascii	"GNU C89 6.2.1 20161016 -mlittle-endian -mgeneral-regs-only -"
	.ascii	"mpc-relative-literal-loads -march=armv8-a -mabi=lp64 -g -O2 "
	.ascii	"-std=gnu90 -fno-strict-al"
	.string	"iasing -fno-common -fno-asynchronous-unwind-tables -fno-delete-null-pointer-checks -fno-stack-protector -fno-omit-frame-pointer -fno-optimize-sibling-calls -fno-var-tracking-assignments -fno-strict-overflow -fconserve-stack --param allow-store-data-races=0"
.LASF29:
	.string	"initcall_debug"
.LASF64:
	.string	"PG_error"
.LASF76:
	.string	"PG_writeback"
.LASF24:
	.string	"__security_initcall_end"
.LASF15:
	.string	"memstart_addr"
.LASF35:
	.string	"dmesg_restrict"
.LASF51:
	.string	"root_mountflags"
.LASF42:
	.string	"oops_in_progress"
.LASF13:
	.string	"phys_addr_t"
.LASF48:
	.string	"sysctl_panic_on_stackoverflow"
.LASF14:
	.string	"atomic_t"
.LASF60:
	.string	"hex_asc_upper"
	.ident	"GCC: (Linaro GCC 6.2-2016.11) 6.2.1 20161016"
	.section	.note.GNU-stack,"",@progbits
