#ifndef SPRD_UART_H
#define SPRD_UART_H
#include <types_ext.h>
#include <drivers/serial.h>
struct sprd_uart_data {
	struct io_pa_va base;
	struct serial_chip chip;
};
void sprd_uart_init(struct sprd_uart_data *pd, paddr_t base);
#endif 
