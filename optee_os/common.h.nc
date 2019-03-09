#ifndef PLAT_ROCKCHIP_COMMON_H
#define PLAT_ROCKCHIP_COMMON_H
#define LOCK_TAG		0xDEADBEAF
#define LOCK_ADDR_OFFSET	4
#define BOOT_ADDR_OFFSET	8
#define REG_MSK_SHIFT		16
#define WMSK_BIT(nr)		BIT((nr) + REG_MSK_SHIFT)
#define BIT_WITH_WMSK(nr)	(BIT(nr) | WMSK_BIT(nr))
#define BITS_WMSK(msk, shift)	SHIFT_U32(msk, (shift) + REG_MSK_SHIFT)
#define BITS_WITH_WMASK(bits, msk, shift) \
				(SHIFT_U32(bits, shift) | BITS_WMSK(msk, shift))
#endif
