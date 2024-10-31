#!/usr/bin/env sh
set -eu

__INSTALL_SH_DIR=$(
    cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd
)

JUPYTER_KERNEL_DIR=${__INSTALL_SH_DIR}/nersc
declare -a JUPYTER_KERNELS=(
    "julia-tutorial-single-threaded"
    "julia-tutorial-multi-threaded"
)
declare -a JUPYTER_THREADS_CT=(
    "1"
    "4"
)
declare -a JUPYTER_THREADS_NAME=(
    "Single"
    "Multi"
)

for kernel in {0..1}
do
    kernel_dir=${HOME}/.local/share/jupyter/kernels/${JUPYTER_KERNELS[$kernel]}
    mkdir -p ${kernel_dir}
    echo "Creating Kernel at: ${kernel_dir}"

    \
        THREADS_NAME=${JUPYTER_THREADS_NAME[$kernel]} \
        ${__INSTALL_SH_DIR}/lib/mo \
        ${__INSTALL_SH_DIR}/nersc/jupyter/template/kernel.json \
        > ${kernel_dir}/kernel.json

    \
        THREADS_CT=${JUPYTER_THREADS_CT[$kernel]} \
        KERNEL_RESOURCE_DIR=${__INSTALL_SH_DIR}/nersc/ \
        ${__INSTALL_SH_DIR}/lib/mo \
        ${__INSTALL_SH_DIR}/nersc/jupyter/template/kernel-helper.sh \
        > ${kernel_dir}/kernel-helper.sh

    chmod u+x ${kernel_dir}/kernel-helper.sh
    cp ${__INSTALL_SH_DIR}/nersc/jupyter/template/logo-32x32.png ${kernel_dir}
    cp ${__INSTALL_SH_DIR}/nersc/jupyter/template/logo-64x64.png ${kernel_dir}
done


echo "Done"
