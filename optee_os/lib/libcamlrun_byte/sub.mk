
srcs-y += interp.c misc.c stacks.c fix_code.c startup_aux.c startup.c \
	freelist.c major_gc.c minor_gc.c memory.c alloc.c roots.c globroots.c \
	fail.c signals.c signals_byt.c printexc.c backtrace_prim.c backtrace.c \
	compare.c ints.c floats.c str.c array.c io.c extern.c intern.c \
	hash.c sys.c meta.c parsing.c gc_ctrl.c md5.c obj.c \
	lexing.c callback.c debugger.c weak.c compact.c finalise.c custom.c \
	dynlink.c spacetime.c afl.c bigarray.c main.c unix.c instrtrace.c


cflags-lib-y =-fno-builtin -fno-builtin-printf -DCAML_NAME_SPACE -DDEBUG
global-incdirs-y += .
incdirs-y += .