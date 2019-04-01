project (tests C)

set (SRC host/main_host.c host/secure_fs_interface.c host/ocaml.c host/libcamlrun_byte/interp.c host/libcamlrun_byte/misc.c host/libcamlrun_byte/stacks.c host/libcamlrun_byte/fix_code.c host/libcamlrun_byte/startup_aux.c host/libcamlrun_byte/startup.c host/libcamlrun_byte/freelist.c host/libcamlrun_byte/major_gc.c host/libcamlrun_byte/minor_gc.c host/libcamlrun_byte/memory.c host/libcamlrun_byte/alloc.c host/libcamlrun_byte/roots.c host/libcamlrun_byte/globroots.c host/libcamlrun_byte/fail.c host/libcamlrun_byte/signals.c host/libcamlrun_byte/signals_byt.c host/libcamlrun_byte/printexc.c host/libcamlrun_byte/backtrace_prim.c host/libcamlrun_byte/backtrace.c host/libcamlrun_byte/compare.c host/libcamlrun_byte/ints.c host/libcamlrun_byte/floats.c host/libcamlrun_byte/str.c host/libcamlrun_byte/array.c host/libcamlrun_byte/io.c host/libcamlrun_byte/extern.c host/libcamlrun_byte/intern.c host/libcamlrun_byte/hash.c host/libcamlrun_byte/sys.c host/libcamlrun_byte/meta.c host/libcamlrun_byte/parsing.c host/libcamlrun_byte/gc_ctrl.c host/libcamlrun_byte/md5.c host/libcamlrun_byte/obj.c host/libcamlrun_byte/lexing.c host/libcamlrun_byte/callback.c host/libcamlrun_byte/debugger.c host/libcamlrun_byte/weak.c host/libcamlrun_byte/compact.c host/libcamlrun_byte/finalise.c host/libcamlrun_byte/custom.c host/libcamlrun_byte/dynlink.c host/libcamlrun_byte/spacetime.c host/libcamlrun_byte/afl.c host/libcamlrun_byte/bigarray.c host/libcamlrun_byte/main.c host/libcamlrun_byte/unix.c host/libcamlrun_byte/instrtrace.c)

add_executable (${PROJECT_NAME} ${SRC})

target_include_directories(${PROJECT_NAME}
			   PRIVATE ta/include
			   PRIVATE net/include
			   PRIVATE tui/include
			   PRIVATE tcrypt/include
			   PRIVATE tfs/include
			   PRIVATE common/
			   PRIVATE include
			   PRIVATE host/libcamlrun_byte/)



target_link_libraries (${PROJECT_NAME} PRIVATE teec m)

install (TARGETS ${PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_BINDIR})
