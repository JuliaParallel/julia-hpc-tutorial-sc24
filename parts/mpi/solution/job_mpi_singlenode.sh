#!/bin/bash
#SBATCH -A ntrain1
#SBATCH -C cpu
#SBATCH -q regular
#SBATCH --output=slurm_mpi_singlenode.out
#SBATCH --time=00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks=4

# Load the latest Julia Module
ml load julia

# This will load the activate.sh in the root path of this repository
# IMPORTATION: for this relative path to work, you need to be in this
# directory when running `sbatch`
# NOTE: because the `solution folder is at a deeper level from the project root
# as the excercise, we've added an additional `/..` to get back to the
# `activate.sh`
source ../../../activate.sh

# Run the Julia code -- we're usign `srun` to launch Julia. This is necessary
# to configure MPI. If you tried to use `MPI.Init()` outside of an srun, then
# the program will crash. Note also that you can't run an srun _insite_ of
# another srun.
srun julia diffusion_2d_mpi.jl
