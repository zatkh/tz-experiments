#ifndef CONSOLE_H
#define CONSOLE_H
#include <compiler.h>
void console_init(void);
void console_putc(int ch);
void console_flush(void);
int console_getc(void);
struct serial_chip;
void register_serial_console(struct serial_chip *chip);
#ifdef CFG_DT
void configure_console_from_dt(void);
#else
static inline void configure_console_from_dt(void)
{}
#endif 
#endif 
