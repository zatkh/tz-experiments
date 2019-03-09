#include <assert.h>
#include <drivers/mvebu_uart.h>
#include <io.h>
#include <keep.h>
#include <kernel/dt.h>
#include <stdlib.h>
#include <trace.h>
#include <types_ext.h>
#include <util.h>
#define UART_RX_REG		0x00
#define UART_TX_REG		0x04
#define UART_CTRL_REG		0x08
#define UART_STATUS_REG		0x0c
#define UART_BAUD_REG		0x10
#define UART_POSSR_REG		0x14
#define UARTLSR_TXFIFOFULL	(1 << 11)       
#define UARTLSR_TXFIFOEMPTY	(1 << 13)
#define UARTLSR_TXEMPTY		(1 << 6)
#define UART_RX_READY		(1 << 4)
#define UART_CTRL_RXFIFO_RESET	(1 << 14)
#define UART_CTRL_TXFIFO_RESET	(1 << 15)
static vaddr_t chip_to_base(struct serial_chip *chip)
{
	struct mvebu_uart_data *pd =
		container_of(chip, struct mvebu_uart_data, chip);
	return io_pa_or_va(&pd->base);
}
static void mvebu_uart_flush(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	while (!(read32(base + UART_STATUS_REG) & UARTLSR_TXFIFOEMPTY))
		;
}
static bool mvebu_uart_have_rx_data(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	return (read32(base + UART_STATUS_REG) & UART_RX_READY);
}
static int mvebu_uart_getchar(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	while (!mvebu_uart_have_rx_data(chip))
		;
	return read32(base + UART_RX_REG) & 0xff;
}
static void mvebu_uart_putc(struct serial_chip *chip, int ch)
{
	vaddr_t base = chip_to_base(chip);
	uint32_t tmp;
	do {
		tmp = read32(base + UART_STATUS_REG);
		tmp &= UARTLSR_TXFIFOFULL;
	} while (tmp == UARTLSR_TXFIFOFULL);
	write32(ch, base + UART_TX_REG);
}
static const struct serial_ops mvebu_uart_ops = {
	.flush = mvebu_uart_flush,
	.getchar = mvebu_uart_getchar,
	.have_rx_data = mvebu_uart_have_rx_data,
	.putc = mvebu_uart_putc,
};
KEEP_PAGER(mvebu_uart_ops);
void mvebu_uart_init(struct mvebu_uart_data *pd, paddr_t pbase,
		uint32_t uart_clk, uint32_t baud_rate)
{
	vaddr_t base;
	uint32_t tmp = 0;
	uint32_t dll = 0;
	pd->base.pa = pbase;
	pd->chip.ops = &mvebu_uart_ops;
	base = io_pa_or_va(&pd->base);
	dll = (uart_clk / (baud_rate << 4)) & 0x3FF;
	tmp = read32(base + UART_BAUD_REG);
	tmp &= ~0x3FF;
	tmp |= dll;
	write32(tmp, base + UART_BAUD_REG);   
	write32(0, base + UART_POSSR_REG);
	write32((UART_CTRL_RXFIFO_RESET | UART_CTRL_TXFIFO_RESET),
		base + UART_CTRL_REG);
	write32(0, base + UART_CTRL_REG);
	mvebu_uart_flush(&pd->chip);
}
