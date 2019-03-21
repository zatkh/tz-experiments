global-incdirs-y += include
BRUNPATH=../libcamlrun/
incdirs-y += $(BRUNPATH)

UNIX_OR_WIN32=unix
MODEL=default
SYSTEM=elf
IFLEXDIR=
LIBUNWIND_INCLUDE_FLAGS=
TARGET=aarch64-linux-gnu

cppflags-y +=-DNATIVE_CODE -DTARGET_arm64

ifeq "$(UNIX_OR_WIN32)" "unix"
cppflags-y += -DMODEL_$(MODEL)
endif

cppflags-y += -DSYS_$(SYSTEM) $(IFLEXDIR) $(LIBUNWIND_INCLUDE_FLAGS)
cppflags-y += -g

srcs-y += build_test.c
srcs-y += $(BRUNPATH)startup_aux.c
srcs-y += startup.c
srcs-y += $(BRUNPATH)main.c
srcs-y +=  fail.c
srcs-y +=  roots.c
srcs-y += $(BRUNPATH)signals.c
srcs-y += signals_asm.c
srcs-y += $(BRUNPATH)misc.c
srcs-y += $(BRUNPATH)freelist.c	
srcs-y += $(BRUNPATH)major_gc.c
srcs-y += $(BRUNPATH)minor_gc.c
srcs-y += $(BRUNPATH)memory.c
srcs-y += $(BRUNPATH)alloc.c
srcs-y += $(BRUNPATH)compare.c
srcs-y += $(BRUNPATH)ints.c
srcs-y += $(BRUNPATH)floats.c
srcs-y += $(BRUNPATH)str.c
srcs-y += $(BRUNPATH)array.c
srcs-y += $(BRUNPATH)io.c
srcs-y += $(BRUNPATH)extern.c
srcs-y += $(BRUNPATH)intern.c
srcs-y += $(BRUNPATH)hash.c
srcs-y += $(BRUNPATH)sys.c
srcs-y += $(BRUNPATH)parsing.c
srcs-y += $(BRUNPATH)gc_ctrl.c
srcs-y += $(BRUNPATH)terminfo.c
srcs-y += $(BRUNPATH)md5.c
srcs-y += $(BRUNPATH)obj.c
srcs-y += $(BRUNPATH)lexing.c
srcs-y += $(BRUNPATH)$(UNIX_OR_WIN32).c
srcs-y += $(BRUNPATH)printexc.c
srcs-y += $(BRUNPATH)callback.c
srcs-y += $(BRUNPATH)weak.c
srcs-y += $(BRUNPATH)compact.c 
srcs-y += $(BRUNPATH)finalise.c
srcs-y += $(BRUNPATH)custom.c
srcs-y += $(BRUNPATH)globroots.c
srcs-y += backtrace_prim.c
srcs-y += $(BRUNPATH)backtrace.c	
srcs-y += natdynlink.c
srcs-y += $(BRUNPATH)debugger.c
srcs-y += $(BRUNPATH)meta.c
srcs-y += $(BRUNPATH)dynlink.c
srcs-y += clambda_checks.c 
srcs-y += spacetime.c
srcs-y += spacetime_snapshot.c
srcs-y += spacetime_offline.c
srcs-y += $(BRUNPATH)afl.c
srcs-y += $(BRUNPATH)bigarray.c


srcs-y +=arm64.S

cflags-lib-y =-nostdlib -u call_user_start_cpu0 -Wl,--gc-sections -Wl,-static -Wl,--start-group -lgcc -lstdc++ -lgcov -Wl,--end-group -Wl,-EL -Os -fno-strict-aliasing -fwrapv -Wall
cppflags-lib-y =-Os -D_FILE_OFFSET_BITS=64 -DCAML_NAME_SPACE 

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