#!/bin/bash

SCRIPT_DIR=${BASH_SOURCE%/*}

bash "${SCRIPT_DIR}/binutils/stage1_download.sh"
if [ ! "${?}" -eq 0 ]; then
    exit 1
fi

bash "${SCRIPT_DIR}/gcc/stage1_download.sh"
if [ ! "${?}" -eq 0 ]; then
    exit 1
fi

bash "${SCRIPT_DIR}/gcc/stage2_download.sh"
if [ ! "${?}" -eq 0 ]; then
    exit 1
fi

bash "${SCRIPT_DIR}/make/stage1_download.sh"
if [ ! "${?}" -eq 0 ]; then
    exit 1
fi

bash "${SCRIPT_DIR}/cmake/stage1_download.sh"
if [ ! "${?}" -eq 0 ]; then
    exit 1
fi

bash "${SCRIPT_DIR}/ninja/stage1_download.sh"
if [ ! "${?}" -eq 0 ]; then
    exit 1
fi
