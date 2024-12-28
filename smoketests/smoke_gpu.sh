#!/bin/bash

#SBATCH -J smoke_gpu
#SBATCH -A ntrain1
#SBATCH -q shared
#SBATCH -C gpu
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 32
#SBATCH -t 02:00:00
#SBATCH -o smoke_gpu.log

set -eu

module load julia/1.10

export JULIA_NUM_THREADS=32

julia --project=$PWD run_smoketest.jl CUDA
