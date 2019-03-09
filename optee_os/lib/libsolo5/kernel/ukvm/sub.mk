srcs-y += kernel.c
srcs-y += platform.c
srcs-y += platform_intr.c
srcs-y += time.c
srcs-y += platform_lifecycle.c
srcs-y += yield.c
srcs-y += tscclock.c
srcs-y += console.c
srcs-y += net.c
srcs-y += block.c


cflags-kernel.c-y += -Wno-missing-prototypes -Wno-missing-declarations -Wno-suggest-attribute=noreturn
cflags-tscclock.c-y += -Wno-declaration-after-statement
cflags-console.c-y += -Wno-missing-prototypes -Wno-missing-declarations
cflags-block.c-y += -Wno-missing-prototypes -Wno-declaration-after-statement -Wno-missing-declarations

