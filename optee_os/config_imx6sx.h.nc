#ifndef __CONFIG_IMX6SX_H
#define __CONFIG_IMX6SX_H
#ifndef CFG_UART_BASE
#define CFG_UART_BASE	(UART1_BASE)
#endif
#ifndef CFG_DDR_SIZE
#error "CFG_DDR_SIZE not defined"
#endif
#define DRAM0_SIZE		CFG_DDR_SIZE
#define TZDRAM_BASE		(DRAM0_BASE - 32 * 1024 * 1024 + CFG_DDR_SIZE)
#define TZDRAM_SIZE		(30 * 1024 * 1024)
#define TEE_SHMEM_START		(TZDRAM_BASE + TZDRAM_SIZE)
#define TEE_SHMEM_SIZE		0x200000
#define TEE_RAM_VA_SIZE		(1024 * 1024)
#define TEE_RAM_PH_SIZE		TEE_RAM_VA_SIZE
#define TEE_RAM_START		TZDRAM_BASE
#define TA_RAM_START		ROUNDUP((TZDRAM_BASE + TEE_RAM_VA_SIZE), \
					CORE_MMU_DEVICE_SIZE)
#define TA_RAM_SIZE		ROUNDDOWN((TZDRAM_SIZE - TEE_RAM_VA_SIZE), \
					  CORE_MMU_DEVICE_SIZE)
#ifdef CFG_TEE_LOAD_ADDR
#define TEE_LOAD_ADDR		CFG_TEE_LOAD_ADDR
#else
#define TEE_LOAD_ADDR		TEE_RAM_START
#endif
#define CONSOLE_UART_BASE	(CFG_UART_BASE)
#ifndef PL310_TAG_RAM_CTRL_INIT
#define PL310_TAG_RAM_CTRL_INIT		0x00000132
#endif
#ifndef PL310_DATA_RAM_CTRL_INIT
#define PL310_DATA_RAM_CTRL_INIT	0x00000232
#endif
#define PL310_AUX_CTRL_INIT		0x3C430800
#define PL310_PREFETCH_CTRL_INIT	0x31000007
#define PL310_POWER_CTRL_INIT		0x00000003
#define	SCU_INV_CTRL_INIT		0xFFFFFFFF
#define SCU_SAC_CTRL_INIT		0x0000000F
#define SCU_NSAC_CTRL_INIT		0x00000FFF
#endif