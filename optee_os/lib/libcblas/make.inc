FORTRAN     = /home/zt233/devel/optee/toolchains/aarch64/bin/aarch64-linux-gnu-gfortran
OPTS        = -O2 -Wall -fPIC -march=armv8-a
POPTS       = -Wall -fPIC -march=armv8-a -pg -fno-inline
NOOPT       = -O0 -Wall -fPIC -march=armv8-a
PNOOPT      = -Wall -fPIC -march=armv8-a -pg -fno-inline -O0
LOADOPTS    = -O2 -Wall -fPIC -march=armv8-a -lm -lpthread -lgfortran
CC          = /home/zt233/devel/optee/toolchains/aarch64/bin/aarch64-linux-gnu-gcc
override CFLAGS      = -O2 -DMAX_STACK_ALLOC=2048 -Wall -DF_INTERFACE_GFORT -fPIC -DSMP_SERVER -DNO_WARMUP -DMAX_CPU_NUMBER=8 -DMAX_PARALLEL_NUMBER=1 -march=armv8-a -DASMNAME= -DASMFNAME=_ -DNAME=_ -DCNAME= -DCHAR_NAME="_" -DCHAR_CNAME="" -DNO_AFFINITY -I. -DHAVE_LAPACK_CONFIG_H
ARCH        = /home/zt233/devel/optee/toolchains/aarch64/bin/aarch64-linux-gnu-ar
ARCHFLAGS   =  -ru
RANLIB      = /home/zt233/devel/optee/toolchains/aarch64/bin/aarch64-linux-gnu-ranlib
LAPACKLIB   = ../libopenblas_armv8p-r0.3.3.dev.a
TMGLIB      = ../libopenblas_armv8p-r0.3.3.dev.a
BLASLIB     = ../../../libopenblas_armv8p-r0.3.3.dev.a
LAPACKELIB  = ../libopenblas_armv8p-r0.3.3.dev.a
LAPACKLIB_P = ../libopenblas_armv8p-r0.3.3.dev_p.a
SUFFIX      = o
PSUFFIX     = po
CEXTRALIB   = -lm -lpthread -lgfortran
TIMER       = INT_ETIME
LOADER      = /home/zt233/devel/optee/toolchains/aarch64/bin/aarch64-linux-gnu-gfortran -pthread
BUILD_DEPRECATED      = 1
LAPACKE_WITH_TMG      = 1
SHELL = /bin/sh
PLAT = _LINUX
DRVOPTS  = $(NOOPT)
#ARCHFLAGS= $(ARFLAGS) -ru
#RANLIB   = ranlib

