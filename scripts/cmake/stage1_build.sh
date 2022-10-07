#!/bin/bash

if [ -e "${CMAKE_STAGE1_INSTALL_DIR}/bin/cmake" ]; then
    echo "cmake stage1: already installed."
    exit 0
fi


echo "cmake stage1: configure"

mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

"${CMAKE_STAGE1_SOURCE_DIR}/configure" \
    --prefix="${CMAKE_STAGE1_INSTALL_DIR}" \
    -- -DCMAKE_USE_OPENSSL=OFF -DCMAKE_BUILD_TYPE=MinSizeRel

if [ ! "${?}" -eq 0 ]; then
    echo "Configure failed. Abort."
    exit 1
fi

echo "cmake stage1: build"

make -j$(nproc)

if [ ! "${?}" -eq 0 ]; then
    echo "Build failed. Abort."
    exit 1
fi

echo "cmake stage1: install"

make install

if [ ! "${?}" -eq 0 ]; then
    echo "Install failed. Abort."
    exit 1
fi

rm -rf "${BUILD_DIR}"
