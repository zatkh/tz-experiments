#!/bin/bash
BUILDPATH="$PWD/build"
BUILDROOTPATH="$PWD/buildroot"

#build your rootfs
cd $BUILDROOTPATH
rm -rf .config
make clean
cp TFA.config .config
#  or just
#make qemu_aarch64_virt_defconfig
#make menuconfig
make -j$(nproc)
mv $BUILDROOTPATH/output/images/rootfs.cpio.gz $BUILDROOTPATH/output/images/rootfs_copy.cpio.gz

#run qemu
cd $BUILDPATH

make -j$(nproc) ta-targets=ta_arm64 run-TF
# two opened terminals, one NW the other SW
# in the NW one type: root for login
