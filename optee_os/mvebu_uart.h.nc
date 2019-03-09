#ifndef MVEBU_UART_H
#define MVEBU_UART_H
#include <types_ext.h>
#include <drivers/serial.h>
struct mvebu_uart_data {
	struct io_pa_va base;
	struct serial_chip chip;
};
void mvebu_uart_init(struct mvebu_uart_data *pd, paddr_t pbase,
		uint32_t uart_clk, uint32_t baud_rate);
#endif 
