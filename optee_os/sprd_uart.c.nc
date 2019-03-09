#include <drivers/sprd_uart.h>
#include <io.h>
#include <keep.h>
#include <util.h>
#define UART_TXD		0x0000
#define UART_RXD		0x0004
#define UART_STS1		0x000C 
#define STS1_RXF_CNT_MASK	0x00ff  
#define STS1_TXF_CNT_MASK	0xff00 
static vaddr_t chip_to_base(struct serial_chip *chip)
{
	struct sprd_uart_data *pd =
		container_of(chip, struct sprd_uart_data, chip);
	return io_pa_or_va(&pd->base);
}
static void sprd_uart_flush(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	while (read32(base + UART_STS1) & STS1_TXF_CNT_MASK)
		;
}
static bool sprd_uart_have_rx_data(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	return !!(read32(base + UART_STS1) & STS1_RXF_CNT_MASK);
}
static void sprd_uart_putc(struct serial_chip *chip, int ch)
{
	vaddr_t base = chip_to_base(chip);
	sprd_uart_flush(chip);
	write32(base + UART_TXD, ch);
}
static int sprd_uart_getchar(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	while (!sprd_uart_have_rx_data(chip))
		;
	return read32(base + UART_RXD) & 0xff;
}
static const struct serial_ops sprd_uart_ops = {
	.flush = sprd_uart_flush,
	.getchar = sprd_uart_getchar,
	.have_rx_data = sprd_uart_have_rx_data,
	.putc = sprd_uart_putc,
};
KEEP_PAGER(sprd_uart_ops);
void sprd_uart_init(struct sprd_uart_data *pd, paddr_t base)
{
	pd->base.pa = base;
	pd->chip.ops = &sprd_uart_ops;
}
