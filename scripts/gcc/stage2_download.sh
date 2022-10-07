#!/bin/bash

if [ -e "${GCC_STAGE2_SOURCE_DIR}" ]; then
    exit 0
fi


if [ ! -e "${CACHE_DIR}/${GCC_STAGE2_ARCHIVE}" ]; then
    echo "Downloading ${GCC_STAGE2_DOWNLOAD_URL} into ${CACHE_DIR}/"

    curl -L -o "${CACHE_DIR}/${GCC_STAGE2_ARCHIVE}"  "${GCC_STAGE2_DOWNLOAD_URL}"
    if [ ! "${?}" -eq 0 ]; then
        echo -e "${COLOR_RED}Failed.${COLOR_DEFAULT}"
        exit 1
    fi
fi


echo -e "${COLOR_GREEN}Extracting ${GCC_STAGE2_ARCHIVE}${COLOR_DEFAULT}"

tar -C "${CACHE_DIR}" -xf "${CACHE_DIR}/${GCC_STAGE2_ARCHIVE}"
if [ ! "${?}" -eq 0 ]; then
    echo -e "${COLOR_RED}Failed.${COLOR_DEFAULT}"
    exit 1
fi


echo -e "${COLOR_GREEN}Downloading prerequisites${COLOR_DEFAULT}"

(cd "${GCC_STAGE2_SOURCE_DIR}" && ./contrib/download_prerequisites)
if [ ! "${?}" -eq 0 ]; then
    echo -e "${COLOR_RED}Failed.${COLOR_DEFAULT}"
    exit 1
fi
