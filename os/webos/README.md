# webos openttd

## Building FluidSynth

> Do these in a different folder, outside of the OpenTTD folder.

```sh
git clone https://github.com/FluidSynth/fluidsynth
cd fluidsynth
mkdir build
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=/opt/arm-webos-linux-gnueabi_sdk-buildroot/share/buildroot/toolchainfile.cmake -DCMAKE_INSTALL_PREFIX=/opt/arm-webos-linux-gnueabi_sdk-buildroot/arm-webos-linux-gnueabi/sysroot/usr
make
make install
```

## Building OpenTTD

```sh
# Build an AMD64 version for your local computer
mkdir build-native
cd build-native
cmake .. -DOPTION_TOOLS_ONLY=ON
make -j
```

```sh
# Build an ARM64 version for your television
# Tips!
#   Adjust CMAKE_TOOLCHAIN_FILE to wherever yours is stored
#   Adjust `-j9` to "around" the number of threads you have
#   Don't run in Visual Studio Code terminal if you have less than 64GB RAM
#   Adjust WSL swap space so you have 64GB of pagable memory space
mkdir build
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=/opt/arm-webos-linux-gnueabi_sdk-buildroot/share/buildroot/toolchainfile.cmake -DHOST_BINARY_DIR=../build-native -DCMAKE_BUILD_TYPE=RelWithDebInfo -DWEBOS=ON -DOPTION_PACKAGE_DEPENDENCIES=ON
make -j9
```

## Packaging OpenTTD

Download either...
- `FluidR3_GM.sf2` from the ZIP file on this website: https://member.keymusician.com/Member/FluidR3_GM/index.html
- `TimGM6mb.sf2` from the Debian `timgm6mb-soundfont` repository: https://salsa.debian.org/multimedia-team/timgm6mb-soundfont

Put the file in the `public/` folder.

```sh
./package.sh
# ares-package .
```

## Debugging OpenTTD

```sh
XDG_RUNTIME_DIR=/tmp/xdg /usr/bin/jailer -t native_devmode -i com.leondrolio.x.openttd -p /media/developer/apps/usr/palm/applications/com.leondrolio.x.openttd /media/developer/apps/usr/palm/applications/com.leondrolio.x.openttd/openttd '{"@system_native_app":true,"nid":"com.leondrolio.x.openttd"}'
```
