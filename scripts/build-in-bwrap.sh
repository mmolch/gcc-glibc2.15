#!/bin/bash

export PATH=/usr/sbin:/usr/bin:/sbin:/bin
export SOURCE_DIR=$(cd "$(dirname "${0}")" && pwd)
. "${SOURCE_DIR}/vars.sh"


# gcc stage 1 =================================================================

bash "${SCRIPT_DIR}/gcc/stage1_build.sh"
if [ ! "${?}" -eq 0 ]; then
    echo "Error building gcc stage1"

    bash
    exit 1
fi

export PATH="${GCC_STAGE1_BIN_DIR}:${PATH}"
export LD_LIBRARY_PATH="${GCC_STAGE1_LIB_DIR}:${LD_LIBRARY_PATH}"


# binutils stage 1 ============================================================

bash "${SCRIPT_DIR}/binutils/stage1_build.sh"
if [ ! "${?}" -eq 0 ]; then
    echo "Error building binutils stage1"

    bash
    exit 1
fi

export PATH="${BINUTILS_STAGE1_BIN_DIR}:${PATH}"


# gcc stage 2 =================================================================

bash "${SCRIPT_DIR}/gcc/stage2_build.sh"
if [ ! "${?}" -eq 0 ]; then
    echo "Error building gcc stage2"

    bash
    exit 1
fi

export PATH="${GCC_STAGE2_BIN_DIR}:${PATH}"
export LD_LIBRARY_PATH="${GCC_STAGE2_LIB_DIR}:${LD_LIBRARY_PATH}"


# binutils stage 2 ============================================================

bash "${SCRIPT_DIR}/binutils/stage2_build.sh"
if [ ! "${?}" -eq 0 ]; then
    echo "Error building binutils stage2"

    bash
    exit 1
fi

export PATH="${BINUTILS_STAGE2_BIN_DIR}:${PATH}"


# make stage 1 ================================================================

bash "${SCRIPT_DIR}/make/stage1_build.sh"
if [ ! "${?}" -eq 0 ]; then
    echo "Error building make stage1"
    exit 1
fi

export PATH="${MAKE_STAGE1_BIN_DIR}:${PATH}"


# cmake stage 1 ================================================================

bash "${SCRIPT_DIR}/cmake/stage1_build.sh"
if [ ! "${?}" -eq 0 ]; then
    echo "Error building cmake stage1"
    exit 1
fi

export PATH="${CMAKE_STAGE1_BIN_DIR}:${PATH}"


# ninja stage 1 ================================================================

bash "${SCRIPT_DIR}/ninja/stage1_build.sh"
if [ ! "${?}" -eq 0 ]; then
    echo "Error building ninja stage1"
    exit 1
fi

export PATH="${NINJA_STAGE1_BIN_DIR}:${PATH}"
