#include <assert.h>
#include <drivers/atmel_uart.h>
#include <io.h>
#include <keep.h>
#include <util.h>
#define ATMEL_UART_CR		0x0000 
#define ATMEL_UART_MR		0x0004 
#define ATMEL_UART_IER		0x0008 
#define ATMEL_UART_IDR		0x000c 
#define ATMEL_UART_IMR		0x0010 
#define ATMEL_UART_SR		0x0014 
	#define	ATMEL_SR_RXRDY		BIT(0)	
	#define	ATMEL_SR_TXRDY		BIT(1)	
	#define	ATMEL_SR_TXEMPTY	BIT(1)	
#define ATMEL_UART_RHR		0x0018 
#define ATMEL_UART_THR		0x001c 
#define ATMEL_UART_BRGR		0x0020 
#define ATMEL_UART_CMPR		0x0024 
#define ATMEL_UART_RTOR		0x0028 
#define ATMEL_UART_WPMR		0x00e4 
static vaddr_t chip_to_base(struct serial_chip *chip)
{
	struct atmel_uart_data *pd =
		container_of(chip, struct atmel_uart_data, chip);
	return io_pa_or_va(&pd->base);
}
static void atmel_uart_flush(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	while (!(read32(base + ATMEL_UART_SR) & ATMEL_SR_TXEMPTY))
		;
}
static int atmel_uart_getchar(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	while (read32(base + ATMEL_UART_SR) & ATMEL_SR_RXRDY)
		;
	return read32(base + ATMEL_UART_RHR);
}
static void atmel_uart_putc(struct serial_chip *chip, int ch)
{
	vaddr_t base = chip_to_base(chip);
	while (!(read32(base + ATMEL_UART_SR) & ATMEL_SR_TXRDY))
		;
	write32(ch, base + ATMEL_UART_THR);
}
static const struct serial_ops atmel_uart_ops = {
	.flush = atmel_uart_flush,
	.getchar = atmel_uart_getchar,
	.putc = atmel_uart_putc,
};
void atmel_uart_init(struct atmel_uart_data *pd, paddr_t base)
{
	pd->base.pa = base;
	pd->chip.ops = &atmel_uart_ops;
}
