#include <drivers/ns16550.h>
#include <io.h>
#include <keep.h>
#include <util.h>
#define UART_RBR	0x0
#define UART_THR	0x0
#define UART_IER	0x1
#define UART_FCR	0x2
#define UART_LCR	0x3
#define UART_MCR	0x4
#define UART_LSR	0x5
#define UART_MSR	0x6
#define UART_SPR	0x7
#define UART_LSR_THRE	0x20 
static vaddr_t chip_to_base(struct serial_chip *chip)
{
	struct ns16550_data *pd =
		container_of(chip, struct ns16550_data, chip);
	return io_pa_or_va(&pd->base);
}
static void ns16550_flush(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	while ((read8(base + UART_LSR) & UART_LSR_THRE) == 0)
		;
}
static void ns16550_putc(struct serial_chip *chip, int ch)
{
	vaddr_t base = chip_to_base(chip);
	ns16550_flush(chip);
	write8(ch, base + UART_THR);
}
static const struct serial_ops ns16550_ops = {
	.flush = ns16550_flush,
	.putc = ns16550_putc,
};
KEEP_PAGER(ns16550_ops);
void ns16550_init(struct ns16550_data *pd, paddr_t base)
{
	pd->base.pa = base;
	pd->chip.ops = &ns16550_ops;
}
