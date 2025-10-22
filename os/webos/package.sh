#!/bin/bash

TOOLCHAIN_DIR="${TOOLCHAIN_DIR:-"/opt/arm-webos-linux-gnueabi_sdk-buildroot"}"

rm -rf dist/
mkdir dist/
cp -r ../../build/ai dist/ai
cp -r ../../build/baseset dist/baseset
cp -r ../../build/game dist/game
cp -r ../../build/lang dist/lang
cp -r ../../build/openttd dist/openttd
cp -r public/. dist/

mkdir dist/lib
cp $TOOLCHAIN_DIR/arm-webos-linux-gnueabi/sysroot/usr/lib/libicudata.so.70.1 dist/libicudata.so.70
cp $TOOLCHAIN_DIR/arm-webos-linux-gnueabi/sysroot/usr/lib/libicui18n.so.70.1 dist/libicui18n.so.70
cp $TOOLCHAIN_DIR/arm-webos-linux-gnueabi/sysroot/usr/lib/libicuuc.so.70.1 dist/libicuuc.so.70
cp $TOOLCHAIN_DIR/arm-webos-linux-gnueabi/sysroot/usr/lib/libstdc++.so.6.0.30 dist/libstdc++.so.6
cp $TOOLCHAIN_DIR/arm-webos-linux-gnueabi/sysroot/usr/lib/libfluidsynth.so.3.4.0 dist/libfluidsynth.so.3
cp $TOOLCHAIN_DIR/arm-webos-linux-gnueabi/sysroot/usr/lib/libreadline.so.8.1 dist/libreadline.so.8
cp $TOOLCHAIN_DIR/arm-webos-linux-gnueabi/sysroot/lib/libatomic.so.1.2.0 dist/libatomic.so.1

ares-package dist/
