#!/bin/bash

case "${TARGET_MACHINE}" in
    i686)
        ENV_ARCH=linux32
        ;;

    x86_64)
        ENV_ARCH=linux64
        ;;
esac

bwrap \
    --unshare-all \
    --hostname ubuntu1204 \
    --uid 0 \
    --gid 0 \
    --ro-bind "${TARGET_ROOT_DIR}" / \
    --bind "${SOURCE_DIR}" /gcc-glibc2.15 \
    --bind "${SOURCE_DIR}/${TARGET_MACHINE}/${TARGET_MACHINE}-${GCC_VERSION}-linux-glibc2.15" /${TARGET_MACHINE}-${GCC_VERSION}-linux-glibc2.15 \
    --dev /dev \
    --proc /proc \
    --tmpfs /tmp \
    --setenv PATH /usr/sbin:/usr/bin:/sbin:/bin \
    -- env -i ${ENV_ARCH} ${@}
