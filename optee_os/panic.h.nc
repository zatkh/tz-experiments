#ifndef KERNEL_PANIC_H
#define KERNEL_PANIC_H
#include <compiler.h>
#if defined(CFG_TEE_CORE_DEBUG)
#define __panic(str)	__do_panic(__FILE__, __LINE__, __func__, str)
#else
#define __panic(str)	__do_panic((void *)0, 0, (void *)0, (void *)0)
#endif
void __do_panic(const char *file, const int line, const char *func,
		const char *msg) __noreturn;
#pragma GCC system_header
#define _panic0()	__panic((void *)0)
#define _panic1(s)	__panic(s)
#define _panic_fn(a, b, name, ...) name
#define panic(...) _panic_fn("", ##__VA_ARGS__, _panic1, _panic0)(__VA_ARGS__)
#endif 
