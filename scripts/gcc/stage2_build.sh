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
    --build=${TARGET_MACHINE}-linux-gnu \
    --host=${TARGET_MACHINE}-linux-gnu \
    --target=${TARGET_MACHINE}-linux-gnu \
    --disable-multilib \
    --enable-checking=release \
    --enable-languages=c,c++

if [ ! "${?}" -eq 0 ]; then
    echo "Configure failed. Abort."
    exit 1
fi

echo "gcc stage2: build"

make BOOT_CFLAGS='-Os' -j$(nproc)

if [ ! "${?}" -eq 0 ]; then
    echo "Build failed. Abort."
    exit 1
fi

echo "gcc stage2: install"

make install-strip

if [ ! "${?}" -eq 0 ]; then
    echo "Install failed. Abort."
    exit 1
fi

rm -rf "${BUILD_DIR}"
