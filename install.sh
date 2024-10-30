#!/usr/bin/env sh
set -eu

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

JUPYTER_KERNEL_DIR=${SCRIPT_DIR}/nersc/jupyter
declare -a JUPYTER_KERNELS=(
    "julia-tutorial-single-threaded"
    "julia-tutorial-multi-threaded"
)

for kernel in "${JUPYTER_KERNELS[@]}"
do
    cp -r ${JUPYTER_KERNEL_DIR}/${kernel} ${HOME}/.local/share/jupyter/kernels
done


echo "Done"
