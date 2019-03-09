srcs-y += ccv_cache.c 
srcs-y += ccv_memory.c 
srcs-y += 3rdparty/siphash/siphash24.c
srcs-y += 3rdparty/kissfft/kiss_fft.c 
srcs-y += 3rdparty/kissfft/kiss_fftnd.c 
srcs-y += 3rdparty/kissfft/kiss_fftr.c
srcs-y += 3rdparty/kissfft/kiss_fftndr.c 
srcs-y += 3rdparty/kissfft/kissf_fft.c 
srcs-y += 3rdparty/kissfft/kissf_fftnd.c 
srcs-y += 3rdparty/kissfft/kissf_fftr.c 
srcs-y += 3rdparty/kissfft/kissf_fftndr.c 
srcs-y += 3rdparty/dsfmt/dSFMT.c 
srcs-y += 3rdparty/sfmt/SFMT.c 
#srcs-y += 3rdparty/sqlite3/sqlite3.c 
#srcs-y += ccv_io.c 
srcs-y += ccv_numeric.c 
srcs-y += ccv_algebra.c 
srcs-y += ccv_util.c 
srcs-y += ccv_basic.c 
srcs-y += ccv_image_processing.c 
srcs-y += ccv_resample.c 
srcs-y += ccv_transform.c 
srcs-y += ccv_classic.c 
srcs-y += ccv_daisy.c 
srcs-y += ccv_sift.c 
#srcs-y += ccv_bbf.c 
srcs-y += ccv_mser.c 
srcs-y += ccv_swt.c 
#srcs-y += ccv_dpm.c 
srcs-y += ccv_tld.c 
srcs-y += ccv_ferns.c 
srcs-y += ccv_icf.c 
srcs-y += ccv_scd.c 
srcs-y += ccv_convnet.c 
srcs-y += ccv_output.c

cflags-lib-y += -O3 -Wall
#cflags-3rdparty/sqlite3/sqlite3.c-y += -D SQLITE_THREADSAFE=0 -D SQLITE_OMIT_LOAD_EXTENSION

subdirs-y += nnc



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