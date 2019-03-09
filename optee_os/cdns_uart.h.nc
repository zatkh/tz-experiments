#ifndef CDNS_UART_H
#define CDNS_UART_H
#include <types_ext.h>
#include <drivers/serial.h>
struct cdns_uart_data {
	struct io_pa_va base;
	struct serial_chip chip;
};
void cdns_uart_init(struct cdns_uart_data *pd, paddr_t base, uint32_t uart_clk,
		uint32_t baud_rate);
#endif 
