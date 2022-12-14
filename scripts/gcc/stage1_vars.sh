export GCC_STAGE1_VERSION="10.3.0"
export GCC_STAGE1_ARCHIVE="gcc-${GCC_STAGE1_VERSION}.tar.xz"
export GCC_STAGE1_DOWNLOAD_URL="https://ftp.gnu.org/gnu/gcc/gcc-${GCC_STAGE1_VERSION}/${GCC_STAGE1_ARCHIVE}"
export GCC_STAGE1_SOURCE_DIR="${SOURCE_DIR}/cache/gcc-${GCC_STAGE1_VERSION}"
export GCC_STAGE1_INSTALL_DIR="${CACHE_INSTALL_DIR}/gcc/stage1"
export GCC_STAGE1_BIN_DIR="${GCC_STAGE1_INSTALL_DIR}/bin"
if [ "${TARGET_MACHINE}" = "x86_64" ]; then
    export GCC_STAGE1_LIB_DIR="${GCC_STAGE1_INSTALL_DIR}/lib64"
else
    export GCC_STAGE1_LIB_DIR="${GCC_STAGE1_INSTALL_DIR}/lib"
fi
