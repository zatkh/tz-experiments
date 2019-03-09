#include <assert.h>
#include <drivers/cdns_uart.h>
#include <io.h>
#include <keep.h>
#include <mm/core_mmu.h>
#include <util.h>
#define CDNS_UART_CONTROL		0
#define CDNS_UART_MODE			4
#define CDNS_UART_IEN			8
#define CDNS_UART_IRQ_STATUS		0x14
#define CDNS_UART_CHANNEL_STATUS	0x2c
#define CDNS_UART_FIFO			0x30
#define CDNS_UART_CONTROL_RXRES		BIT(0)
#define CDNS_UART_CONTROL_TXRES		BIT(1)
#define CDNS_UART_CONTROL_RXEN		BIT(2)
#define CDNS_UART_CONTROL_TXEN		BIT(4)
#define CDNS_UART_MODE_8BIT		(0 << 1)
#define CDNS_UART_MODE_PARITY_NONE	(0x4 << 3)
#define CDNS_UART_MODE_1STP		(0 << 6)
#define CDNS_UART_CHANNEL_STATUS_TFUL	BIT(4)
#define CDNS_UART_CHANNEL_STATUS_TEMPTY	BIT(3)
#define CDNS_UART_CHANNEL_STATUS_REMPTY	BIT(1)
#define CDNS_UART_IRQ_RXTRIG		BIT(0)
#define CDNS_UART_IRQ_RXTOUT		BIT(8)
static vaddr_t chip_to_base(struct serial_chip *chip)
{
	struct cdns_uart_data *pd =
		container_of(chip, struct cdns_uart_data, chip);
	return io_pa_or_va(&pd->base);
}
static void cdns_uart_flush(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	while (!(read32(base + CDNS_UART_CHANNEL_STATUS) &
		 CDNS_UART_CHANNEL_STATUS_TEMPTY))
		;
}
static bool cdns_uart_have_rx_data(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	return !(read32(base + CDNS_UART_CHANNEL_STATUS) &
			CDNS_UART_CHANNEL_STATUS_REMPTY);
}
static int cdns_uart_getchar(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	while (!cdns_uart_have_rx_data(chip))
		;
	return read32(base + CDNS_UART_FIFO) & 0xff;
}
static void cdns_uart_putc(struct serial_chip *chip, int ch)
{
	vaddr_t base = chip_to_base(chip);
	while (read32(base + CDNS_UART_CHANNEL_STATUS) &
			CDNS_UART_CHANNEL_STATUS_TFUL)
		;
	write32(ch, base + CDNS_UART_FIFO);
}
static const struct serial_ops cdns_uart_ops = {
	.flush = cdns_uart_flush,
	.getchar = cdns_uart_getchar,
	.have_rx_data = cdns_uart_have_rx_data,
	.putc = cdns_uart_putc,
};
KEEP_PAGER(cdns_uart_ops);
void cdns_uart_init(struct cdns_uart_data *pd, paddr_t base, uint32_t uart_clk,
		uint32_t baud_rate)
{
	pd->base.pa = base;
	pd->chip.ops = &cdns_uart_ops;
	if (!uart_clk || !baud_rate)
		return;
	write32(CDNS_UART_CONTROL_RXEN | CDNS_UART_CONTROL_TXEN,
		base + CDNS_UART_CONTROL);
	cdns_uart_flush(&pd->chip);
}
