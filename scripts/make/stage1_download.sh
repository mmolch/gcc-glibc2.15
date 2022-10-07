#!/bin/bash

if [ -e "${MAKE_STAGE1_SOURCE_DIR}" ]; then
    exit 0
fi


if [ ! -e "${CACHE_DIR}/${MAKE_STAGE1_ARCHIVE}" ]; then
    echo -e "${COLOR_GREEN}Downloading ${MAKE_STAGE1_DOWNLOAD_URL}${COLOR_DEFAULT}"

    curl -L -o "${CACHE_DIR}/${MAKE_STAGE1_ARCHIVE}" "${MAKE_STAGE1_DOWNLOAD_URL}"
    if [ ! "${?}" -eq 0 ]; then
        echo -e "${COLOR_RED}Failed.${COLOR_DEFAULT}"
        exit 1
    fi
fi


echo -e "${COLOR_GREEN}Extracting ${MAKE_STAGE1_ARCHIVE}${COLOR_DEFAULT}"

tar -C "${CACHE_DIR}" -xf "${CACHE_DIR}/${MAKE_STAGE1_ARCHIVE}"
if [ ! "${?}" -eq 0 ]; then
    echo -e "${COLOR_RED}Failed.${COLOR_DEFAULT}"
    exit 1
fi
