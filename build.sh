#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Usage: build.sh [i686|x86_64]"
    exit 1
fi

case "${1}" in
    i686|x86_64)
        export TARGET_MACHINE="${1}"
        ;;
    *)
        echo "Usage: build.sh [i686|x86_64]"
        exit 1
        ;;
esac



export SOURCE_DIR=$(cd "$(dirname "${0}")" && pwd)
. "${SOURCE_DIR}/scripts/vars.sh"

mkdir -p "${TARGET_DIR}"
mkdir -p "${CACHE_DIR}"


"${SOURCE_DIR}/scripts/debootstrap-ubuntu-1204.sh"
if [ ! "${?}" -eq 0 ]; then
    echo "Debootstrap failed."
    exit 1
fi


"${SOURCE_DIR}/scripts/download.sh"
if [ ! "${?}" -eq 0 ]; then
    echo "Download failed."
    exit 1
fi


#"${SOURCE_DIR}/scripts/run-in-bwrap.sh" "/gcc-glibc2.15/scripts/build.sh"
"${SOURCE_DIR}/scripts/run-in-chroot.sh" "/gcc-glibc2.15/scripts/build.sh"
