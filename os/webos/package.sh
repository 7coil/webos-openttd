#!/bin/bash

TOOLCHAIN_DIRECTORY=/opt/arm-webos-linux-gnueabi_sdk-buildroot

rm -rf dist/
mkdir dist/
cp -r ../../build/ai dist/ai
cp -r ../../build/baseset dist/baseset
cp -r ../../build/game dist/game
cp -r ../../build/lang dist/lang
cp -r ../../build/openttd dist/openttd
cp -r public/* dist/

mkdir dist/lib
cp $TOOLCHAIN_DIRECTORY/arm-webos-linux-gnueabi/sysroot/usr/lib/libicudata.so.70.1 dist/lib
ln -rs dist/lib/libicudata.so.70.1 dist/lib/libicudata.so.70
cp $TOOLCHAIN_DIRECTORY/arm-webos-linux-gnueabi/sysroot/usr/lib/libicui18n.so.70.1 dist/lib
ln -rs dist/lib/libicui18n.so.70.1 dist/lib/libicui18n.so.70
cp $TOOLCHAIN_DIRECTORY/arm-webos-linux-gnueabi/sysroot/usr/lib/libicuuc.so.70.1 dist/lib
ln -rs dist/lib/libicuuc.so.70.1 dist/lib/libicuuc.so.70
cp $TOOLCHAIN_DIRECTORY/arm-webos-linux-gnueabi/sysroot/usr/lib/libstdc++.so.6.0.30 dist/lib
ln -rs dist/lib/libstdc++.so.6.0.30 dist/lib/libstdc++.so.6
cp $TOOLCHAIN_DIRECTORY/arm-webos-linux-gnueabi/sysroot/usr/lib/libfluidsynth.so.3.2.2 dist/lib
ln -rs dist/lib/libfluidsynth.so.3.2.2 dist/lib/libfluidsynth.so.3
cp $TOOLCHAIN_DIRECTORY/arm-webos-linux-gnueabi/sysroot/usr/lib/libreadline.so.8.1 dist/lib
ln -rs dist/lib/libreadline.so.8.1 dist/lib/libreadline.so.8

ares-package dist/
