#ifndef KERNEL_DT_H
#define KERNEL_DT_H
#include <compiler.h>
#include <stdint.h>
#include <types_ext.h>
#include <util.h>
#define DT_STATUS_DISABLED 0
#define DT_STATUS_OK_NSEC  BIT(0)
#define DT_STATUS_OK_SEC   BIT(1)
#if defined(CFG_DT)
struct dt_device_match {
	const char *compatible;
};
struct dt_driver {
	const char *name;
	const struct dt_device_match *match_table; 
	const void *driver;
};
#define __dt_driver __section(".rodata.dtdrv")
const struct dt_driver *dt_find_compatible_driver(const void *fdt, int offs);
const struct dt_driver *__dt_driver_start(void);
const struct dt_driver *__dt_driver_end(void);
int dt_map_dev(const void *fdt, int offs, vaddr_t *base, size_t *size);
bool dt_have_prop(const void *fdt, int offs, const char *propname);
paddr_t _fdt_reg_base_address(const void *fdt, int offs);
ssize_t _fdt_reg_size(const void *fdt, int offs);
int _fdt_get_status(const void *fdt, int offs);
#else 
static inline const struct dt_driver *__dt_driver_start(void)
{
	return NULL;
}
static inline const struct dt_driver *__dt_driver_end(void)
{
	return NULL;
}
static inline const struct dt_driver *dt_find_compatible_driver(
					const void *fdt __unused,
					int offs __unused)
{
	return NULL;
}
static inline int dt_map_dev(const void *fdt __unused, int offs __unused,
			     vaddr_t *vbase __unused, size_t *size __unused)
{
	return -1;
}
static inline paddr_t _fdt_reg_base_address(const void *fdt __unused,
					    int offs __unused)
{
	return (paddr_t)-1;
}
static inline ssize_t _fdt_reg_size(const void *fdt __unused,
				    int offs __unused)
{
	return -1;
}
static inline int _fdt_get_status(const void *fdt __unused, int offs __unused)
{
	return -1;
}
#endif 
#define for_each_dt_driver(drv) \
	for (drv = __dt_driver_start(); drv < __dt_driver_end(); drv++)
#endif 
