#ifndef ATMEL_UART_H
#define ATMEL_UART_H
#include <types_ext.h>
#include <drivers/serial.h>
struct atmel_uart_data {
	struct io_pa_va base;
	struct serial_chip chip;
};
void atmel_uart_init(struct atmel_uart_data *pd, paddr_t base);
#endif 
