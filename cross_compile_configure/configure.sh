#!/bin/bash
# configure Xenomai 3.0 for cross compiling for the ARM.
#
# can be adapted to other projects requiring cross-compilation, with small changes
#
# 2015 Alexandre Lopes

export CROSS_COMPILE=~/gcc-linaro-arm-linux-gnueabihf-4.8-2013.12_linux/bin/arm-linux-gnueabihf-

export CPP=${CROSS_COMPILE}cpp
export AR=${CROSS_COMPILE}ar
export AS=${CROSS_COMPILE}as
export NM=${CROSS_COMPILE}nm
export CC=${CROSS_COMPILE}gcc
export CXX=${CROSS_COMPILE}g++
export LD=${CROSS_COMPILE}ld

export INSTALL_DIR=$(pwd)/install_arm

./configure --host=arm-linux-gnueabihf --prefix=$INSTALL_DIR --with-core=cobalt --build=x86 --enable-smp
