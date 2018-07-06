global-incdirs-y += include


srcs-y += ctype.c
srcs-y += dtoa.c
srcs-y += memchr.c
srcs-y += memmove.c
srcs-y += strtol.c
srcs-y += strchr.c
srcs-y += strchrnul.c
srcs-y += strncpy.c
srcs-y += stpncpy.c
srcs-y += strstr.c
#srcs-y += stubs.c
srcs-y += fprintf.c



cflags-lib-y += -Wno-implicit-function-declaration
cflags-dtoa.c-y += -fno-strict-aliasing
#cflags-lib-$(CFG_ULIBS_GPROF) += -pg





