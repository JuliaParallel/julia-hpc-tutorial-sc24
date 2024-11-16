#!/bin/bash
#SBATCH -A ntrain1
#SBATCH -C gpu
#SBATCH -q regular
#SBATCH -J gs-julia-1MPI-1GPU
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err
#SBATCH -t 0:60:00
#SBATCH -N 4
#SBATCH -c 32
#SBATCH --reservation=julia_MIT_2

#export SLURM_CPU_BIND="cores"
GS_DIR=$SCRATCH/$USER/GrayScott.jl
GS_EXE=$GS_DIR/gray-scott.jl

srun -n 16 -G 16 julia --project=$GS_DIR $GS_EXE settings-files.json
