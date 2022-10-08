export GCC_STAGE2_VERSION="12.2.0"
export GCC_STAGE2_ARCHIVE="gcc-${GCC_STAGE2_VERSION}.tar.xz"
export GCC_STAGE2_DOWNLOAD_URL="https://ftp.gnu.org/gnu/gcc/gcc-${GCC_STAGE2_VERSION}/${GCC_STAGE2_ARCHIVE}"
export GCC_STAGE2_SOURCE_DIR="${SOURCE_DIR}/cache/gcc-${GCC_STAGE2_VERSION}"
export GCC_STAGE2_INSTALL_DIR="${INSTALL_DIR}"
export GCC_STAGE2_BIN_DIR="${GCC_STAGE2_INSTALL_DIR}/bin"
if [ "${TARGET_MACHINE}" = "x86_64" ]; then
    export GCC_STAGE2_LIB_DIR="${GCC_STAGE2_INSTALL_DIR}/lib64"
else
    export GCC_STAGE2_LIB_DIR="${GCC_STAGE2_INSTALL_DIR}/lib"
fi
