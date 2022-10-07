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


_mount
sudo mount --bind "${SOURCE_DIR}" "${TARGET_ROOT_DIR}/gcc-glibc2.15"
sudo mount --bind "${TARGET_DIR}${INSTALL_DIR}" "${TARGET_ROOT_DIR}${INSTALL_DIR}"
sudo chroot "${TARGET_ROOT_DIR}" linux32 "${@}"
sudo umount "${TARGET_ROOT_DIR}${INSTALL_DIR}"
sudo umount "${TARGET_ROOT_DIR}/gcc-glibc2.15"
_unmount
