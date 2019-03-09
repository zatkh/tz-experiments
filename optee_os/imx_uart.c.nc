#include <assert.h>
#include <drivers/imx_uart.h>
#include <io.h>
#include <keep.h>
#include <util.h>
#define URXD  0x0  
#define UTXD  0x40 
#define UCR1  0x80 
#define UCR2  0x84 
#define UCR3  0x88 
#define UCR4  0x8c 
#define UFCR  0x90 
#define USR1  0x94 
#define USR2  0x98 
#define UESC  0x9c 
#define UTIM  0xa0 
#define UBIR  0xa4 
#define UBMR  0xa8 
#define UBRC  0xac 
#define UTS   0xb4 
#define  URXD_CHARRDY    (1<<15)
#define  URXD_ERR        (1<<14)
#define  URXD_OVRRUN     (1<<13)
#define  URXD_FRMERR     (1<<12)
#define  URXD_BRK        (1<<11)
#define  URXD_PRERR      (1<<10)
#define  URXD_RX_DATA    (0xFF)
#define  UCR1_ADEN       (1<<15) 
#define  UCR1_ADBR       (1<<14) 
#define  UCR1_TRDYEN     (1<<13) 
#define  UCR1_IDEN       (1<<12) 
#define  UCR1_RRDYEN     (1<<9)	 
#define  UCR1_RDMAEN     (1<<8)	 
#define  UCR1_IREN       (1<<7)	 
#define  UCR1_TXMPTYEN   (1<<6)	 
#define  UCR1_RTSDEN     (1<<5)	 
#define  UCR1_SNDBRK     (1<<4)	 
#define  UCR1_TDMAEN     (1<<3)	 
#define  UCR1_UARTCLKEN  (1<<2)	 
#define  UCR1_DOZE       (1<<1)	 
#define  UCR1_UARTEN     (1<<0)	 
#define  UTS_FRCPERR	 (1<<13) 
#define  UTS_LOOP        (1<<12) 
#define  UTS_TXEMPTY	 (1<<6)	 
#define  UTS_RXEMPTY	 (1<<5)	 
#define  UTS_TXFULL	 (1<<4)	 
#define  UTS_RXFULL	 (1<<3)	 
#define  UTS_SOFTRST	 (1<<0)	 
static vaddr_t chip_to_base(struct serial_chip *chip)
{
	struct imx_uart_data *pd =
		container_of(chip, struct imx_uart_data, chip);
	return io_pa_or_va(&pd->base);
}
static void imx_uart_flush(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	while (!(read32(base + UTS) & UTS_TXEMPTY))
		;
}
static int imx_uart_getchar(struct serial_chip *chip)
{
	vaddr_t base = chip_to_base(chip);
	while (read32(base + UTS) & UTS_RXEMPTY)
		;
	return (read32(base + URXD) & URXD_RX_DATA);
}
static void imx_uart_putc(struct serial_chip *chip, int ch)
{
	vaddr_t base = chip_to_base(chip);
	write32(ch, base + UTXD);
	while (!(read32(base + UTS) & UTS_TXEMPTY))
		;
}
static const struct serial_ops imx_uart_ops = {
	.flush = imx_uart_flush,
	.getchar = imx_uart_getchar,
	.putc = imx_uart_putc,
};
KEEP_PAGER(imx_uart_ops);
void imx_uart_init(struct imx_uart_data *pd, paddr_t base)
{
	pd->base.pa = base;
	pd->chip.ops = &imx_uart_ops;
}
