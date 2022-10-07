#!/bin/bash

if [ -e "${NINJA_STAGE1_INSTALL_DIR}/bin/ninja" ]; then
    echo "ninja stage1: already installed."
    exit 0
fi


echo "ninja stage1: configure"

mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

cmake "${NINJA_STAGE1_SOURCE_DIR}" \
    -DCMAKE_INSTALL_PREFIX="${NINJA_STAGE1_INSTALL_DIR}" \
    -DCMAKE_BUILD_TYPE=MinSizeRel

if [ ! "${?}" -eq 0 ]; then
    echo "Configure failed. Abort."
    exit 1
fi

echo "ninja stage1: build"

make -j$(nproc)

if [ ! "${?}" -eq 0 ]; then
    echo "Build failed. Abort."
    exit 1
fi

echo "ninja stage1: install"

make install

if [ ! "${?}" -eq 0 ]; then
    echo "Install failed. Abort."
    exit 1
fi

rm -rf "${BUILD_DIR}"
