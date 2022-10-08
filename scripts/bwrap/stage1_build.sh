#!/bin/bash

if [ -e "${BWRAP_STAGE1_INSTALL_DIR}/bin/bwrap" ]; then
    echo "bwrap stage1: already installed."
    exit 0
fi


echo "bwrap stage1: configure"

mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

"${BWRAP_STAGE1_SOURCE_DIR}/configure" \
    --prefix="${BWRAP_STAGE1_INSTALL_DIR}" \


if [ ! "${?}" -eq 0 ]; then
    echo "Configure failed. Abort."
    exit 1
fi

echo "bwrap stage1: build"

make -j$(nproc)

if [ ! "${?}" -eq 0 ]; then
    echo "Build failed. Abort."
    exit 1
fi

echo "bwrap stage1: install"

make install-strip

if [ ! "${?}" -eq 0 ]; then
    echo "Install failed. Abort."
    exit 1
fi

rm -rf "${BUILD_DIR}"
