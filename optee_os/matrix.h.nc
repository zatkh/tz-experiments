#ifndef MATRIX_H
#define MATRIX_H
extern void matrix_write_protect_enable(unsigned int matrix_base);
extern void matrix_write_protect_disable(unsigned int matrix_base);
extern void matrix_configure_slave_security(unsigned int matrix_base,
				unsigned int slave,
				unsigned int srtop_setting,
				unsigned int srsplit_setting,
				unsigned int ssr_setting);
extern int matrix_configure_peri_security(unsigned int *peri_id_array,
					unsigned int size);
vaddr_t matrix32_base(void);
vaddr_t matrix64_base(void);
#endif 
