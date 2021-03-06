#ifndef __IMX_WDOG_H
#define __IMX_WDOG_H
#define WDT_WCR		0x00
#define WDT_WCR_WDA	BIT(5)
#define WDT_WCR_SRS	BIT(4)
#define WDT_WCR_WRE	BIT(3)
#define WDT_WCR_WDE	BIT(2)
#define WDT_WCR_WDZST	BIT(0)
#define WDT_WSR		0x02
#define WDT_SEQ1	0x5555
#define WDT_SEQ2	0xAAAA
void imx_wdog_restart(void);
#endif
