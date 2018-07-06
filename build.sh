#!/bin/bash

sudo apt-get update
sudo apt-get install -y --force-yes \
    build-essential git android-tools-adb android-tools-fastboot autoconf \
	automake bc bison build-essential cscope curl device-tree-compiler \
	expect flex ftp-upload gdisk iasl libattr1-dev libc6:i386 libcap-dev \
	libfdt-dev libftdi-dev libglib2.0-dev libhidapi-dev libncurses5-dev \
	libpixman-1-dev libssl-dev libstdc++6:i386 libtool libz1:i386 make \
	mtools netcat python-crypto python-serial python-wand unzip uuid-dev \
	xdg-utils xterm xz-utils zlib1g-dev 

git clone --depth=1 https://github.com/qemu/qemu.git -b v2.12.0

BUILDPATH="$PWD/build"

make -C $BUILDPATH toolchains -j$(nproc)
#just to make sure there is no cached config file in the repo
make -C $BUILDPATH clean
make -C $BUILDPATH ta-targets=ta_arm64 run -j$(nproc)
# two opened terminals, one NW the other SW
# in the NW one type: root for login
# then type minor_test (or other examples in optee_example dir)
# check the results in the both terminals

