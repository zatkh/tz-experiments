#include <assert.h>
#include <drivers/hi16xx_uart.h>
#include <io.h>
#include <keep.h>
#include <mm/core_mmu.h>
#include <util.h>
#define UART_RBR	0x00	
#define UART_THR	0x00	
#define UART_DLL	0x00	
#define UART_IEL	0x04	
#define UART_DLH	0x04	
#define UART_FCR	0x08	
#define UART_LCR	0x0C	
#define UART_LSR	0x14	
#define UART_USR	0x7C	
#define UART_LCR_DLS5	0x0	
#define UART_LCR_DLS6	0x1	
#define UART_LCR_DLS7	0x2	
#define UART_LCR_DLS8	0x3	
#define UART_LCR_DLAB	0x80
#define UART_FCR_FIFO_EN	0x1	
#define UART_FCR_RX_FIFO_RST	0x2	
#define UART_FCR_TX_FIFO_RST	0x4	
#define UART_USR_BUSY_BIT	0	
#define UART_USR_TFNF_BIT	1	
#define UART_USR_TFE_BIT	2	
#define UART_USR_RFNE_BIT	3	
#define UART_USR_RFF_BIT	4	
static vaddr_t chip_to_base(struct serial_chip *chip)
{
	struct hi16xx_uart_data *pd =
		container_of(chip, struct hi16xx_uart_data, chip);
	return io_pa_or_va(&pd->base);
}
static void hi16xx_uart_flush(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	while (!(read32(base + UART_USR) & UART_USR_TFE_BIT))
		;
}
static void hi16xx_uart_putc(struct serial_chip *chip, int ch)
{
	vaddr_t base = chip_to_base(chip);
	while (!(read32(base + UART_USR) & UART_USR_TFE_BIT))
		;
	write32(ch & 0xFF, base + UART_THR);
}
static bool hi16xx_uart_have_rx_data(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	return (read32(base + UART_USR) & UART_USR_RFNE_BIT);
}
static int hi16xx_uart_getchar(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	while (!hi16xx_uart_have_rx_data(chip))
		;
	return read32(base + UART_RBR) & 0xFF;
}
static const struct serial_ops hi16xx_uart_ops = {
	.flush = hi16xx_uart_flush,
	.getchar = hi16xx_uart_getchar,
	.have_rx_data = hi16xx_uart_have_rx_data,
	.putc = hi16xx_uart_putc,
};
KEEP_PAGER(hi16xx_uart_ops);
void hi16xx_uart_init(struct hi16xx_uart_data *pd, paddr_t base,
		      uint32_t uart_clk, uint32_t baud_rate)
{
	uint16_t freq_div = uart_clk / (16 * baud_rate);
	pd->base.pa = base;
	pd->chip.ops = &hi16xx_uart_ops;
	write32(UART_FCR_FIFO_EN, base + UART_FCR);
	write32(UART_LCR_DLAB, base + UART_LCR);
	write32(freq_div & 0xFF, base + UART_DLL);
	write32((freq_div >> 8) & 0xFF, base + UART_DLH);
	write32(UART_LCR_DLS8, base + UART_LCR);
	write32(0, base + UART_IEL);
	hi16xx_uart_flush(&pd->chip);
}
