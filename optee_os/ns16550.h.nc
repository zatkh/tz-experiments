#ifndef NS16550_H
#define NS16550_H
#include <types_ext.h>
#include <drivers/serial.h>
struct ns16550_data {
	struct io_pa_va base;
	struct serial_chip chip;
};
void ns16550_init(struct ns16550_data *pd, paddr_t base);
#endif 
