__SCRIPT_DIR=${BASH_SOURCE%/*}

. "${__SCRIPT_DIR}/stage1_vars.sh"
. "${__SCRIPT_DIR}/stage2_vars.sh"

export GCC_VERSION="${GCC_STAGE2_VERSION}"
