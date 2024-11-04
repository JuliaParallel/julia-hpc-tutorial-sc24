#!/bin/bash

#SBATCH -J smoke_cpu
#SBATCH -A ntrain1
#SBATCH -q shared
#SBATCH -C cpu
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 128
#SBATCH -t 02:00:00
#SBATCH -o smoke_cpu.log

set -eu

module load julia/1.10

export JULIA_NUM_THREADS=128

julia --project=$PWD run_smoketest.jl CPU
