#ifndef __DRIVERS_TZC400_H
#define __DRIVERS_TZC400_H
#include <stdint.h>
#include <types_ext.h>
#include <trace_levels.h>
#define TZC400_REG_SIZE		0x1000
#define BUILD_CONFIG_OFF	0x000
#define ACTION_OFF		0x004
#define GATE_KEEPER_OFF		0x008
#define SPECULATION_CTRL_OFF	0x00c
#define INT_STATUS		0x010
#define INT_CLEAR		0x014
#define FAIL_ADDRESS_LOW_OFF	0x020
#define FAIL_ADDRESS_HIGH_OFF	0x024
#define FAIL_CONTROL_OFF	0x028
#define FAIL_ID			0x02c
#define REGION_BASE_LOW_OFF	0x100
#define REGION_BASE_HIGH_OFF	0x104
#define REGION_TOP_LOW_OFF	0x108
#define REGION_TOP_HIGH_OFF	0x10c
#define REGION_ATTRIBUTES_OFF	0x110
#define REGION_ID_ACCESS_OFF	0x114
#define REGION_NUM_OFF(region)  (0x20 * region)
#define PID0_OFF		0xfe0
#define PID1_OFF		0xfe4
#define PID2_OFF		0xfe8
#define PID3_OFF		0xfec
#define PID4_OFF		0xfd0
#define PID5_OFF		0xfd4
#define PID6_OFF		0xfd8
#define PID7_OFF		0xfdc
#define CID0_OFF		0xff0
#define CID1_OFF		0xff4
#define CID2_OFF		0xff8
#define CID3_OFF		0xffc
#define BUILD_CONFIG_NF_SHIFT	24
#define BUILD_CONFIG_NF_MASK	0x3
#define BUILD_CONFIG_AW_SHIFT	8
#define BUILD_CONFIG_AW_MASK	0x3f
#define BUILD_CONFIG_NR_SHIFT	0
#define BUILD_CONFIG_NR_MASK	0x1f
#define ACTION_RV_SHIFT		0
#define ACTION_RV_MASK		0x3
#define  ACTION_RV_LOWOK	0x0
#define  ACTION_RV_LOWERR	0x1
#define  ACTION_RV_HIGHOK	0x2
#define  ACTION_RV_HIGHERR	0x3
#define GATE_KEEPER_OS_SHIFT	16
#define GATE_KEEPER_OS_MASK	0xf
#define GATE_KEEPER_OR_SHIFT	0
#define GATE_KEEPER_OR_MASK	0xf
#define GATE_KEEPER_FILTER_MASK	0x1
#define SPECULATION_CTRL_WRITE_DISABLE	(1 << 1)
#define SPECULATION_CTRL_READ_DISABLE	(1 << 0)
#define INT_STATUS_OVERLAP_SHIFT	16
#define INT_STATUS_OVERLAP_MASK		0xf
#define INT_STATUS_OVERRUN_SHIFT	8
#define INT_STATUS_OVERRUN_MASK		0xf
#define INT_STATUS_STATUS_SHIFT		0
#define INT_STATUS_STATUS_MASK		0xf
#define INT_CLEAR_CLEAR_SHIFT		0
#define INT_CLEAR_CLEAR_MASK		0xf
#define FAIL_CONTROL_DIR_SHIFT		(1 << 24)
#define  FAIL_CONTROL_DIR_READ		0x0
#define  FAIL_CONTROL_DIR_WRITE		0x1
#define FAIL_CONTROL_NS_SHIFT		(1 << 21)
#define  FAIL_CONTROL_NS_SECURE		0x0
#define  FAIL_CONTROL_NS_NONSECURE	0x1
#define FAIL_CONTROL_PRIV_SHIFT		(1 << 20)
#define  FAIL_CONTROL_PRIV_PRIV		0x0
#define  FAIL_CONTROL_PRIV_UNPRIV	0x1
#define FAIL_ID_VNET_SHIFT		24
#define FAIL_ID_VNET_MASK		0xf
#define FAIL_ID_ID_SHIFT		0
#define REG_ATTR_SEC_SHIFT		30
#define REG_ATTR_F_EN_SHIFT		0
#define REG_ATTR_F_EN_MASK		0xf
#define REG_ATTR_FILTER_BIT(x)		((1 << x) << REG_ATTR_F_EN_SHIFT)
#define REG_ATTR_FILTER_BIT_ALL		(REG_ATTR_F_EN_MASK << \
					REG_ATTR_F_EN_SHIFT)
#define REGION_ID_ACCESS_NSAID_WR_EN_SHIFT	16
#define REGION_ID_ACCESS_NSAID_RD_EN_SHIFT	0
#define REGION_ID_ACCESS_NSAID_ID_MASK		0xf
#define TZC_REGION_ACCESS_RD(id)					\
		((1 << (id & REGION_ID_ACCESS_NSAID_ID_MASK)) <<	\
		 REGION_ID_ACCESS_NSAID_RD_EN_SHIFT)
#define TZC_REGION_ACCESS_WR(id)					\
		((1 << (id & REGION_ID_ACCESS_NSAID_ID_MASK)) <<	\
		 REGION_ID_ACCESS_NSAID_WR_EN_SHIFT)
#define TZC_REGION_ACCESS_RDWR(id)					\
		(TZC_REGION_ACCESS_RD(id) | TZC_REGION_ACCESS_WR(id))
#define TZC400_COMPONENT_ID	0xb105f00d
enum tzc_action {
	TZC_ACTION_NONE = 0,
	TZC_ACTION_ERR = 1,
	TZC_ACTION_INT = 2,
	TZC_ACTION_ERR_INT = (TZC_ACTION_ERR | TZC_ACTION_INT)
};
enum tzc_region_attributes {
	TZC_REGION_S_NONE = 0,
	TZC_REGION_S_RD = 1,
	TZC_REGION_S_WR = 2,
	TZC_REGION_S_RDWR = (TZC_REGION_S_RD | TZC_REGION_S_WR)
};
void tzc_init(vaddr_t base);
void tzc_configure_region(uint32_t filters, uint8_t region,
			  vaddr_t region_base, vaddr_t region_top,
			  enum tzc_region_attributes sec_attr,
			  uint32_t ns_device_access);
void tzc_enable_filters(void);
void tzc_disable_filters(void);
void tzc_set_action(enum tzc_action action);
#if TRACE_LEVEL >= TRACE_DEBUG
void tzc_dump_state(void);
#else
static inline void tzc_dump_state(void)
{
}
#endif
#endif 
