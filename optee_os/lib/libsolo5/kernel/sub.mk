srcs-y += abort.c
srcs-y += cpu_aarch64.c
srcs-$(CFG_ARM64_$(sm)) += cpu_vectors_aarch64.S
srcs-y += ee_printf.c
srcs-y += intr.c
srcs-y += lib.c
srcs-y += mem.c
srcs-y += exit.c
srcs-y += log.c
srcs-y += cmdline.c



#cflags-lib-y += -Wno-implicit-function-declaration
cflags-cpu_aarch64.c-y += -Wno-missing-prototypes -Wno-missing-declarations -Wno-suggest-attribute=noreturn
cflags-ee_printf.c-y += -Wno-discarded-qualifiers -Wno-missing-prototypes -Wno-switch-default -Wno-missing-declarations
cflags-intr.c-y += -Wno-declaration-after-statement
cflags-lib.c-y += -Wno-cast-align -Wno-error
cflags-mem.c-y += -Wno-error

subdirs-y += ukvm

# Exported to OPAM via pkg-config.
MD_CFLAGS= -ffreestanding
# Likewise.
link-ldflags +=-nostdlib -z max-page-size=0x1000 -static
# CFLAGS used for building kernel/ and in-tree tests.
cflags-lib-y += -D__SOLO5_KERNEL__ $(MD_CFLAGS) -std=gnu99 -Wall -Wextra -Werror -O2 -g
