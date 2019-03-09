#ifndef SCIF_H
#define SCIF_H
#include <types_ext.h>
#include <drivers/serial.h>
#define SCIF_REG_SIZE	0x1000
struct scif_uart_data {
	struct io_pa_va base;
	struct serial_chip chip;
};
void scif_uart_init(struct scif_uart_data *pd, paddr_t base);
#endif 
