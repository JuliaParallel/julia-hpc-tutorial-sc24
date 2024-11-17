#!/bin/bash
#SBATCH -A ntrain1
#SBATCH -C cpu
#SBATCH -q regular
#SBATCH --output=slurm_mpi_multinode.out
#SBATCH --time=00:05:00
#SBATCH --nodes=4
#SBATCH --ntasks=16

# Load the latest Julia Module
ml load julia

# NOTE: because the `solution folder is at a deeper level from the project root
# as the excercise, we've added an additional `/..` to get back to the
# `activate.sh`
source ../../../activate.sh

# Run the Julia code -- we're usign `srun` to launch Julia. This is necessary
# to configure MPI. If you tried to use `MPI.Init()` outside of an srun, then
# the program will crash. Note also that you can't run an srun _insite_ of
# another srun.
srun julia -e 'do_save=false; include("diffusion_2d_mpi.jl");'
