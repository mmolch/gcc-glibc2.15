#!/bin/bash

if [ -e "${BINUTILS_STAGE1_INSTALL_DIR}/bin/ar" ]; then
    echo "binutils stage1: already installed."
    exit 0
fi

echo "binutils stage1: configure"

mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

"${BINUTILS_STAGE1_SOURCE_DIR}/configure" \
    --prefix="${BINUTILS_STAGE1_INSTALL_DIR}" \
    --build=${TARGET_MACHINE}-linux-gnu \
    --host=${TARGET_MACHINE}-linux-gnu \
    --target=${TARGET_MACHINE}-linux-gnu \

if [ ! "${?}" -eq 0 ]; then
    echo "Configure failed. Abort."
    exit 1
fi

echo "binutils stage1: build"

make -j$(nproc)

if [ ! "${?}" -eq 0 ]; then
    echo "Build failed. Abort."
    exit 1
fi

echo "binutils stage1: install"

make install-strip

if [ ! "${?}" -eq 0 ]; then
    echo "Install failed. Abort."
    exit 1
fi

rm -rf "${BUILD_DIR}"
