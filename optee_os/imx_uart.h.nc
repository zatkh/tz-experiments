#ifndef IMX_UART_H
#define IMX_UART_H
#include <types_ext.h>
#include <drivers/serial.h>
struct imx_uart_data {
	struct io_pa_va base;
	struct serial_chip chip;
};
void imx_uart_init(struct imx_uart_data *pd, paddr_t base);
#endif 
