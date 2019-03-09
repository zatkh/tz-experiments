project (tests C)

set (SRC host/main.c host/secure_fs_interface.c host/ukvm_cpu_aarch64.c host/ukvm_hv_kvm_aarch64.c host/ukvm_hv_kvm.c host/ukvm_core.c host/ukvm_elf.c host/ukvm_module_blk.c host/ukvm_module_net.c host/micro_bench.c)

add_executable (${PROJECT_NAME} ${SRC})

target_include_directories(${PROJECT_NAME}
			   PRIVATE ta/include
			   PRIVATE net/include
			   PRIVATE tui/include
			   PRIVATE tcrypt/include
			   PRIVATE tfs/include
			   PRIVATE common/
			   PRIVATE include)



target_link_libraries (${PROJECT_NAME} PRIVATE teec)

install (TARGETS ${PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_BINDIR})
