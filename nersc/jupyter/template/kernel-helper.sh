#!/bin/bash

module load PrgEnv-gnu
module load python
module load julia

ml use /global/common/software/nersc/julia_hpc_24/modules/
ml load cray-hdf5-parallel
ml load adios2

export JULIA_PROJECT={{TUTORIAL_REPO_DIR}}
export JULIA_DEPOT_PATH=${SCRATCH}/depot
export JULIA_NUM_THREADS={{THREADS_CT}}

readarray -t ijulia_boostrap < <(julia {{NERSC_RESOURCE_DIR}}/bootstrap.jl)

echo "Check-and-install returned following output:"
_IFS=$IFS
IFS=$'\n'
for each in ${ijulia_boostrap[*]}
do
    echo $each
done
IFS=$_IFS

JULIA_EXEC=$(which julia)
KERNEL="${ijulia_boostrap[-1]}"

echo "Connecting using JULIA_EXEC=$JULIA_EXEC and KERNEL=$KERNEL"
exec $JULIA_EXEC -i --startup-file=yes --color=yes $KERNEL "$@"
