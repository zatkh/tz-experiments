#include <drivers/scif.h>
#include <io.h>
#include <keep.h>
#include <util.h>
#define SCIF_SCSCR		(0x08)
#define SCIF_SCFSR		(0x10)
#define SCIF_SCFTDR		(0x0C)
#define SCIF_SCFCR		(0x18)
#define SCIF_SCFDR		(0x1C)
#define SCSCR_TE		BIT(5)
#define SCFSR_TDFE		BIT(5)
#define SCFSR_TEND		BIT(6)
#define SCFDR_T_SHIFT		8
#define SCIF_TX_FIFO_SIZE	16
static vaddr_t chip_to_base(struct serial_chip *chip)
{
	struct scif_uart_data *pd =
		container_of(chip, struct scif_uart_data, chip);
	return io_pa_or_va(&pd->base);
}
static void scif_uart_flush(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	while (!(read16(base + SCIF_SCFSR) & SCFSR_TEND))
		;
}
static void scif_uart_putc(struct serial_chip *chip, int ch)
{
	vaddr_t base = chip_to_base(chip);
	while ((read16(base + SCIF_SCFDR) >> SCFDR_T_SHIFT) >=
		SCIF_TX_FIFO_SIZE)
		;
	write8(ch, base + SCIF_SCFTDR);
	write16(read16(base + SCIF_SCFSR) & ~(SCFSR_TEND | SCFSR_TDFE),
		base + SCIF_SCFSR);
}
static const struct serial_ops scif_uart_ops = {
	.flush = scif_uart_flush,
	.putc = scif_uart_putc,
};
KEEP_PAGER(scif_uart_ops);
void scif_uart_init(struct scif_uart_data *pd, paddr_t base)
{
	pd->base.pa = base;
	pd->chip.ops = &scif_uart_ops;
	write16(read16(base + SCIF_SCSCR) | SCSCR_TE, base + SCIF_SCSCR);
	scif_uart_flush(&pd->chip);
}
