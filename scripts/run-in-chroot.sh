#!/bin/bash

MOUNTDIRS="/dev /dev/pts /sys /proc"
UMOUNTDIRS="/proc /sys /dev/pts /dev"

_mount() {
    for dir in ${MOUNTDIRS}; do
        sudo mount --bind "${dir}" "${TARGET_ROOT_DIR}${dir}"
    done
}

_unmount() {
    for dir in ${UMOUNTDIRS}; do
        sudo umount "${TARGET_ROOT_DIR}${dir}"
    done
}

case "${TARGET_MACHINE}" in
    i686)
        ENV_ARCH=linux32
        ;;

    x86_64)
        ENV_ARCH=linux64
        ;;
esac


_mount
sudo mount --bind "${SOURCE_DIR}" "${TARGET_ROOT_DIR}/gcc-glibc2.15"
sudo mount --bind "${TARGET_DIR}${INSTALL_DIR}" "${TARGET_ROOT_DIR}${INSTALL_DIR}"
sudo chroot --userspec=$(id -u):$(id -g) "${TARGET_ROOT_DIR}" ${ENV_ARCH} "${@}"
sudo umount "${TARGET_ROOT_DIR}${INSTALL_DIR}"
sudo umount "${TARGET_ROOT_DIR}/gcc-glibc2.15"
_unmount
