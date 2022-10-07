#!/bin/bash

if [ -e "${MAKE_STAGE1_INSTALL_DIR}/bin/make" ]; then
    echo "make stage1 is already installed. Skipping."
    exit 0
fi

mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

echo "stage1: make: configure"

#export CFLAGS="-std=gnu99"

"${MAKE_STAGE1_SOURCE_DIR}/configure" --prefix="${MAKE_STAGE1_INSTALL_DIR}"

if [ ! "${?}" -eq 0 ]; then
    echo "Configure failed. Abort."
    exit 1
fi

echo "stage1: make: build"
make -j$(nproc)

if [ ! "${?}" -eq 0 ]; then
    echo "Build failed. Abort."
    exit 1
fi

make install-strip

if [ ! "${?}" -eq 0 ]; then
    echo "Install failed. Abort."
    exit 1
fi

rm -rf "${BUILD_DIR}"
