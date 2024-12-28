#!/bin/bash

#SBATCH -J smoke_gmpi
#SBATCH -A ntrain1
#SBATCH -q shared
#SBATCH -C gpu
#SBATCH -n 2
#SBATCH -c 32
#SBATCH --gpus-per-task=1
#SBATCH -t 02:00:00
#SBATCH -o smoke_gpu_mpi.log

set -eu

module load julia/1.10

export JULIA_NUM_THREADS=32

srun julia --project=$PWD run_smoketest.jl CUDA
