#!/bin/bash

if [ -e "${BINUTILS_STAGE2_SOURCE_DIR}" ]; then
    exit 0
fi


if [ ! -e "${CACHE_DIR}/${BINUTILS_STAGE2_ARCHIVE}" ]; then
    echo -e "${COLOR_GREEN}Downloading ${BINUTILS_STAGE2_DOWNLOAD_URL}${COLOR_DEFAULT}"

    curl -L -o "${CACHE_DIR}/${BINUTILS_STAGE2_ARCHIVE}" "${BINUTILS_STAGE2_DOWNLOAD_URL}"
    if [ ! "${?}" -eq 0 ]; then
        echo -e "${COLOR_RED}Failed.${COLOR_DEFAULT}"
        exit 1
    fi
fi


echo -e "${COLOR_GREEN}Extracting ${BINUTILS_STAGE2_ARCHIVE}${COLOR_DEFAULT}"

tar -C "${CACHE_DIR}" -xf "${CACHE_DIR}/${BINUTILS_STAGE2_ARCHIVE}"
if [ ! "${?}" -eq 0 ]; then
    echo -e "${COLOR_RED}Failed.${COLOR_DEFAULT}"
    exit 1
fi
