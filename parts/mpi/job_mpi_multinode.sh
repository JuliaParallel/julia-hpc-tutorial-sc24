#!/bin/bash

__JOB_SCRIPT_DIR=$(
    cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd
)

#SBATCH -A ntrain1
#SBATCH -C cpu
#SBATCH -q regular
#SBATCH --output=slurm_mpi_multinode.out
#SBATCH --time=00:05:00
#SBATCH --nodes=4
#SBATCH --ntasks=16

ml load julia
source ${__JOB_SCRIPT_DIR}/../../activate.sh

srun julia -e 'do_save=false; include("diffusion_2d_mpi.jl");'
