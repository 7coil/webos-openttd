# webos openttd

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

```sh
ares-package .
```

```sh
XDG_RUNTIME_DIR=/tmp/xdg /usr/bin/jailer -t native_devmode -i com.leondrolio.x.openttd -p /media/developer/apps/usr/palm/applications/com.leondrolio.x.openttd /media/developer/apps/usr/palm/applications/com.leondrolio.x.openttd/openttd '{"@system_native_app":true,"nid":"com.leondrolio.x.openttd"}'
```

```sh
LD_LIBRARY_PATH=/media/developer/apps/usr/palm/applications/com.leondrolio.x.openttd/lib XDG_RUNTIME_DIR=/tmp/xdg /usr/bin/jailer -t native_devmode -i com.leondrolio.x.openttd -p /media/developer/apps/usr/palm/applications/com.leondrolio.x.openttd
 /media/developer/apps/usr/palm/applications/com.leondrolio.x.openttd/openttd
```
