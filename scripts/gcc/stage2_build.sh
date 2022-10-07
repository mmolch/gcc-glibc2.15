#!/bin/bash

if [ -e "${GCC_STAGE2_INSTALL_DIR}/bin/gcc" ]; then
    echo "gcc stage2: already installed."
    exit 0
fi


echo "gcc stage2: configure"

mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

"${GCC_STAGE2_SOURCE_DIR}/configure" \
    --prefix="${GCC_STAGE2_INSTALL_DIR}" \
    --build=$(gcc -dumpmachine) \
    --host=$(gcc -dumpmachine) \
    --target=$(gcc -dumpmachine) \
    --disable-multilib \
    --enable-checking=release \
    --enable-languages=c,c++

if [ ! "${?}" -eq 0 ]; then
    echo "Configure failed. Abort."
    exit 1
fi

echo "gcc stage2: build"

make BOOT_CFLAGS='-Os' -j$(nproc)
#make -j$(nproc)

if [ ! "${?}" -eq 0 ]; then
    # possible virtual memory exhausted: Operation not permitted when building
    # for i686. Trying again works (sometimes)
    make BOOT_CFLAGS='-Os' -j1
    if [ ! "${?}" -eq 0 ]; then
        echo "Build failed. Abort."
        exit 1
    fi
fi

echo "gcc stage2: install"

make install-strip

if [ ! "${?}" -eq 0 ]; then
    echo "Install failed. Abort."
    exit 1
fi

rm -rf "${BUILD_DIR}"
