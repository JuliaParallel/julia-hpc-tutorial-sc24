#!/bin/bash

#SBATCH -J smoke_cmpi
#SBATCH -A ntrain1
#SBATCH -q shared
#SBATCH -C cpu
#SBATCH -N 1
#SBATCH -n 2
#SBATCH -c 64
#SBATCH -t 02:00:00
#SBATCH -o smoke_cpu_mpi.log

set -eu

module load julia/1.10

export JULIA_NUM_THREADS=64

srun julia --project=$PWD run_smoketest.jl CPU
