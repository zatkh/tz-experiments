
include lib/libbmfs/config.mk

VPATH += include/bmfs
global-incdirs-y += include

cflags-y += -Wall -Wextra -Werror -Wfatal-errors -std=gnu99 -Wno-declaration-after-statement -Wno-missing-prototypes -Wno-missing-declarations -Wno-pedantic
cflags-y += -O3
cflags-y += -fPIC
cflags-y += -ffreestanding


srcs-y += crc32.c
srcs-y += dir.c
srcs-y += disk.c
srcs-y += encoding.c
srcs-y += entry.c
srcs-y += errno.c
srcs-y += file.c
srcs-y += fs.c
srcs-y += header.c
srcs-y += host.c
srcs-y += memcpy.c
srcs-y += path.c
srcs-y += status.c
srcs-y += table.c

#srcs-y += time.c





#srcs-y :=
#cflags-y :=
#cflags-lib-y :=
#cppflags-y :=
#cppflags-lib-y :=
#aflags-y :=
#cflags-remove-y :=
#subdirs-y :=
#global-incdirs-y :=
#incdirs-lib-y :=
#incdirs-y :=
#gensrcs-y :=
#this-out-dir :=
#asm-defines-y :=