#!/bin/bash

RUNTIME_DIR="${TARGET_DIR}/glibc-2.15"

mkdir "${RUNTIME_DIR}" 2>/dev/null

case "${TARGET_MACHINE}" in
    i686)
        ARCHITECTURE=i386
        ;;
    x86_64)
        ARCHITECTURE=amd64
        ;;
    *)
        exit 1
esac

PACKAGES="dash_0.5.7-2ubuntu2_${ARCHITECTURE}.deb
libc6_2.15-0ubuntu10_${ARCHITECTURE}.deb
libc6-dev_2.15-0ubuntu10_${ARCHITECTURE}.deb
libc-bin_2.15-0ubuntu10_${ARCHITECTURE}.deb
linux-libc-dev_3.2.0-23.36_${ARCHITECTURE}.deb"

for package in $PACKAGES; do
    (cd "${RUNTIME_DIR}" && ar x "${CACHE_DIR}/${TARGET_MACHINE}/packages/${package}" "data.tar.gz") && \
    tar -C "${RUNTIME_DIR}" -xf "${RUNTIME_DIR}/data.tar.gz" && \
    rm "${RUNTIME_DIR}/data.tar.gz"
done

rm -r "${RUNTIME_DIR}/etc"/*

case "${TARGET_MACHINE}" in
    i686)
        echo "${INSTALL_DIR}/lib" > "${RUNTIME_DIR}/etc/ld.so.conf"
        ;;
    x86_64)
        echo "${INSTALL_DIR}/lib64" > "${RUNTIME_DIR}/etc/ld.so.conf"
        ;;
    *)
        exit 1
esac

echo "/usr/lib/${TARGET_MACHINE}-linux-gnu" >> "${RUNTIME_DIR}/etc/ld.so.conf"

cp -RT "${RUNTIME_DIR}/lib/" "${RUNTIME_DIR}/usr/lib/"
rm -r "${RUNTIME_DIR}/lib/"
rm -r "${RUNTIME_DIR}/lib64/"

cp -RT "${RUNTIME_DIR}/bin/" "${RUNTIME_DIR}/usr/bin/"
rm -r "${RUNTIME_DIR}/bin/"

cp -RT "${RUNTIME_DIR}/sbin/" "${RUNTIME_DIR}/usr/bin/"
rm -r "${RUNTIME_DIR}/sbin/"

cp -RT "${RUNTIME_DIR}/usr/sbin/" "${RUNTIME_DIR}/usr/bin/"
rm -r "${RUNTIME_DIR}/usr/sbin/"

rm "${RUNTIME_DIR}/usr/lib/${TARGET_MACHINE}-linux-gnu/libnss_db.so"
ln -fs "libcidn.so.1" "${RUNTIME_DIR}/usr/lib/${TARGET_MACHINE}-linux-gnu/libcidn.so"