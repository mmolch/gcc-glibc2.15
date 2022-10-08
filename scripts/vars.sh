
export COLOR_RED='\033[0;31m'
export COLOR_GREEN='\033[1;32m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_DEFAULT='\033[0m'


if [ -e "/gcc-glibc2.15" ]; then
    export SOURCE_DIR="/gcc-glibc2.15"
    export TARGET_MACHINE=$(gcc -dumpmachine | cut -d '-' -f 1)
else
    export SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE}")/.." && pwd)"
    export TARGET_DIR="${SOURCE_DIR}/${TARGET_MACHINE}"
    export TARGET_ROOT_DIR="${TARGET_DIR}/root"
fi


export SCRIPT_DIR="${SOURCE_DIR}/scripts"
export CACHE_DIR="${SOURCE_DIR}/cache"
export CACHE_INSTALL_DIR="${CACHE_DIR}/${TARGET_MACHINE}"
export BUILD_DIR="${CACHE_DIR}/${TARGET_MACHINE}/build"
#export BUILD_DIR="/tmp/build"


export CFLAGS="-Os"
export CXXFLAGS="-Os"

. "${SOURCE_DIR}/scripts/gcc/vars.sh"
export INSTALL_DIR="/${TARGET_MACHINE}-${GCC_VERSION}-linux-glibc2.15"

. "${SOURCE_DIR}/scripts/binutils/vars.sh"
. "${SOURCE_DIR}/scripts/bwrap/vars.sh"
. "${SOURCE_DIR}/scripts/cmake/vars.sh"
. "${SOURCE_DIR}/scripts/gcc/vars.sh"
. "${SOURCE_DIR}/scripts/make/vars.sh"
. "${SOURCE_DIR}/scripts/ninja/vars.sh"
