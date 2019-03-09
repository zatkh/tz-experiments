#include <assert.h>
#include <drivers/pl011.h>
#include <io.h>
#include <keep.h>
#include <kernel/dt.h>
#include <stdlib.h>
#include <trace.h>
#include <types_ext.h>
#include <util.h>
#define UART_DR		0x00 
#define UART_RSR_ECR	0x04 
#define UART_DMAWM	0x08 
#define UART_TIMEOUT	0x0C 
#define UART_FR		0x18 
#define UART_ILPR	0x20 
#define UART_IBRD	0x24 
#define UART_FBRD	0x28 
#define UART_LCR_H	0x2C 
#define UART_CR		0x30 
#define UART_IFLS	0x34 
#define UART_IMSC	0x38 
#define UART_RIS	0x3C 
#define UART_MIS	0x40 
#define UART_ICR	0x44 
#define UART_DMACR	0x48 
#define UART_FR_RTXDIS	(1 << 13)
#define UART_FR_TERI	(1 << 12)
#define UART_FR_DDCD	(1 << 11)
#define UART_FR_DDSR	(1 << 10)
#define UART_FR_DCTS	(1 << 9)
#define UART_FR_RI	(1 << 8)
#define UART_FR_TXFE	(1 << 7)
#define UART_FR_RXFF	(1 << 6)
#define UART_FR_TXFF	(1 << 5)
#define UART_FR_RXFE	(1 << 4)
#define UART_FR_BUSY	(1 << 3)
#define UART_FR_DCD	(1 << 2)
#define UART_FR_DSR	(1 << 1)
#define UART_FR_CTS	(1 << 0)
#define UART_LCRH_SPS		(1 << 7)
#define UART_LCRH_WLEN_8	(3 << 5)
#define UART_LCRH_WLEN_7	(2 << 5)
#define UART_LCRH_WLEN_6	(1 << 5)
#define UART_LCRH_WLEN_5	(0 << 5)
#define UART_LCRH_FEN		(1 << 4)
#define UART_LCRH_STP2		(1 << 3)
#define UART_LCRH_EPS		(1 << 2)
#define UART_LCRH_PEN		(1 << 1)
#define UART_LCRH_BRK		(1 << 0)
#define UART_CR_CTSEN		(1 << 15)
#define UART_CR_RTSEN		(1 << 14)
#define UART_CR_OUT2		(1 << 13)
#define UART_CR_OUT1		(1 << 12)
#define UART_CR_RTS		(1 << 11)
#define UART_CR_DTR		(1 << 10)
#define UART_CR_RXE		(1 << 9)
#define UART_CR_TXE		(1 << 8)
#define UART_CR_LPE		(1 << 7)
#define UART_CR_OVSFACT		(1 << 3)
#define UART_CR_UARTEN		(1 << 0)
#define UART_IMSC_RTIM		(1 << 6)
#define UART_IMSC_RXIM		(1 << 4)
static vaddr_t chip_to_base(struct serial_chip *chip)
{
	struct pl011_data *pd =
		container_of(chip, struct pl011_data, chip);
	return io_pa_or_va(&pd->base);
}
static void pl011_flush(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	while ((read32(base + UART_CR) & UART_CR_UARTEN) &&
	       !(read32(base + UART_FR) & UART_FR_TXFE))
		;
}
static bool pl011_have_rx_data(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	return !(read32(base + UART_FR) & UART_FR_RXFE);
}
static int pl011_getchar(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	while (!pl011_have_rx_data(chip))
		;
	return read32(base + UART_DR) & 0xff;
}
static void pl011_putc(struct serial_chip *chip, int ch)
{
	vaddr_t base = chip_to_base(chip);
	while (read32(base + UART_FR) & UART_FR_TXFF)
		;
	write32(ch, base + UART_DR);
}
static const struct serial_ops pl011_ops = {
	.flush = pl011_flush,
	.getchar = pl011_getchar,
	.have_rx_data = pl011_have_rx_data,
	.putc = pl011_putc,
};
KEEP_PAGER(pl011_ops);
void pl011_init(struct pl011_data *pd, paddr_t pbase, uint32_t uart_clk,
		uint32_t baud_rate)
{
	vaddr_t base;
	pd->base.pa = pbase;
	pd->chip.ops = &pl011_ops;
	base = io_pa_or_va(&pd->base);
	write32(0, base + UART_RSR_ECR);
	write32(0, base + UART_CR);
	if (baud_rate) {
		uint32_t divisor = (uart_clk * 4) / baud_rate;
		write32(divisor >> 6, base + UART_IBRD);
		write32(divisor & 0x3f, base + UART_FBRD);
	}
	write32(UART_LCRH_WLEN_8, base + UART_LCR_H);
	write32(UART_IMSC_RXIM | UART_IMSC_RTIM, base + UART_IMSC);
	write32(UART_CR_UARTEN | UART_CR_TXE | UART_CR_RXE, base + UART_CR);
	pl011_flush(&pd->chip);
}
#ifdef CFG_DT
static struct serial_chip *pl011_dev_alloc(void)
{
	struct pl011_data *pd = malloc(sizeof(*pd));
	if (!pd)
		return NULL;
	return &pd->chip;
}
static int pl011_dev_init(struct serial_chip *chip, const void *fdt, int offs,
			  const char *parms)
{
	struct pl011_data *pd = container_of(chip, struct pl011_data, chip);
	vaddr_t vbase;
	paddr_t pbase;
	size_t size;
	if (parms && parms[0])
		IMSG("pl011: device parameters ignored (%s)", parms);
	if (dt_map_dev(fdt, offs, &vbase, &size) < 0)
		return -1;
	if (size != 0x1000) {
		EMSG("pl011: unexpected register size: %zx", size);
		return -1;
	}
	pbase = virt_to_phys((void *)vbase);
	pl011_init(pd, pbase, 0, 0);
	return 0;
}
static void pl011_dev_free(struct serial_chip *chip)
{
	struct pl011_data *pd = container_of(chip, struct pl011_data, chip);
	free(pd);
}
static const struct serial_driver pl011_driver = {
	.dev_alloc = pl011_dev_alloc,
	.dev_init = pl011_dev_init,
	.dev_free = pl011_dev_free,
};
static const struct dt_device_match pl011_match_table[] = {
	{ .compatible = "arm,pl011" },
	{ 0 }
};
const struct dt_driver pl011_dt_driver __dt_driver = {
	.name = "pl011",
	.match_table = pl011_match_table,
	.driver = &pl011_driver,
};
#endif 
