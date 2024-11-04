#!/bin/bash

__JOB_SCRIPT_DIR=$(
    cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd
)

#SBATCH -A ntrain1
#SBATCH -C cpu
#SBATCH -q regular
#SBATCH --output=slurm_mpi_singlenode.out
#SBATCH --time=00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks=4

ml load julia
source ${__JOB_SCRIPT_DIR}/../../activate.sh

srun julia diffusion_2d_mpi.jl
