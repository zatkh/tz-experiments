#ifndef HI16XX_UART_H
#define HI16XX_UART_H
#include <types_ext.h>
#include <drivers/serial.h>
#define HI16XX_UART_REG_SIZE 0xF8
struct hi16xx_uart_data {
	struct io_pa_va base;
	struct serial_chip chip;
};
void hi16xx_uart_init(struct hi16xx_uart_data *pd, paddr_t base,
		      uint32_t uart_clk, uint32_t baud_rate);
#endif 
