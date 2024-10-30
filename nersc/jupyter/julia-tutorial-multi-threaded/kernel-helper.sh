#!/bin/bash

module load PrgEnv-gnu
module load julia


export JULIA_DEPOT_PATH=$SCRATCH/depot
export JULIA_NUM_THREADS=4

readarray -t ijulia_boostrap < <(julia /global/cfs/cdirs/nstaff/blaschke/julia/kernels/bootstrap.jl)

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
