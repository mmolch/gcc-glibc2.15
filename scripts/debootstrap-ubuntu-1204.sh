#!/bin/sh

case "${TARGET_MACHINE}" in
    amd64|x86_64)
        ARCHITECTURE=amd64
        ;;

    i686|x86)
        ARCHITECTURE=i386
        ;;

    *)
        echo "Unknown architecture: ${1}"
        exit
        ;;
esac

if [ -e "${TARGET_ROOT_DIR}" ]; then
    echo "Directory already exists: ${TARGET_ROOT_DIR}"
    echo "Skipping debootstrap."
    exit
fi

echo "Debootstrapping for ${ARCHITECTURE} into ${TARGET_ROOT_DIR}"

# binutils 2.38 fail to build without makeinfo (texinfo)
# libcap-dev for bubblewrap
EXTRA_PACKAGES=build-essential,texinfo,libcap-dev

mkdir -p "${CACHE_DIR}/${TARGET_MACHINE}/packages" 2>/dev/null
sudo debootstrap --cache-dir="${CACHE_DIR}/${TARGET_MACHINE}/packages" --no-check-gpg --variant=minbase --include=${EXTRA_PACKAGES} --arch=${ARCHITECTURE} precise "${TARGET_ROOT_DIR}"
if [ "$?" != 0 ]; then
    echo "Debootstrap failed."
    exit 1
fi

echo "Changing ownership to uid $(id -u) and gid $(id -g)"
sudo chown -R $(id -u):$(id -g) "${TARGET_ROOT_DIR}"

echo "Cleaning up"
rm "${TARGET_ROOT_DIR}/var/cache/apt/archives"/*.deb

echo "Setting up directories"
mkdir -p "${TARGET_ROOT_DIR}/gcc-glibc2.15"
mkdir -p "${TARGET_DIR}/${TARGET_MACHINE}-${GCC_VERSION}-linux-glibc2.15"
mkdir -p "${TARGET_ROOT_DIR}/${TARGET_MACHINE}-${GCC_VERSION}-linux-glibc2.15"

echo "Debootstrap finished"
