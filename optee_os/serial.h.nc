#ifndef __DRIVERS_SERIAL_H
#define __DRIVERS_SERIAL_H
#include <assert.h>
#include <stdbool.h>
#include <types_ext.h>
#include <mm/core_memprot.h>
#include <mm/core_mmu.h>
struct serial_chip {
	const struct serial_ops *ops;
};
struct serial_ops {
	void (*putc)(struct serial_chip *chip, int ch);
	void (*flush)(struct serial_chip *chip);
	bool (*have_rx_data)(struct serial_chip *chip);
	int (*getchar)(struct serial_chip *chip);
};
struct serial_driver {
	struct serial_chip *(*dev_alloc)(void);
	int (*dev_init)(struct serial_chip *dev, const void *fdt,
			int offset, const char *parms);
	void (*dev_free)(struct serial_chip *dev);
};
struct io_pa_va {
	paddr_t pa;
	vaddr_t va;
};
static inline vaddr_t io_pa_or_va(struct io_pa_va *p)
{
	assert(p->pa);
	if (cpu_mmu_enabled()) {
		if (!p->va)
			p->va = (vaddr_t)phys_to_virt_io(p->pa);
		assert(p->va);
		return p->va;
	}
	return p->pa;
}
#endif 
