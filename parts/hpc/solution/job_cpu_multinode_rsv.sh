#!/bin/bash
#SBATCH -A ntrain1
#SBATCH -C gpu
#SBATCH -q regular
#SBATCH --output=slurm_cpu_multinode.out
#SBATCH --time=00:05:00
#SBATCH --nodes=4
#SBATCH --ntasks=16
#SBATCH --reservation=julia_MIT_1

# Load the latest Julia Module
ml load julia

# this will load the activate.sh in the root path of this repository -- the
# __job_script_dir points to the location of _this_ file in the file system (
# the bash invocation is a bit of arcane code to convert bash_source to a
# reasonable path on the file system). things like this are not strictly
# necessary, but they reduce the likelihood of mishaps (eg. forgetting to
# source activate.sh, or running this script from a different working
# directory)
__job_script_dir=$(
    cd -- "$( dirname -- "${bash_source[0]}" )" &> /dev/null && pwd
)
# NOTE: because the `solution folder is at a deeper level from the project root
# as the excercise, we've added an additional `/..` to get back to the
# `activate.sh`
source ${__job_script_dir}/../../../activate.sh

# Run the Julia code -- we're usign `srun` to launch Julia. This is necessary
# to configure MPI. If you tried to use `MPI.Init()` outside of an srun, then
# the program will crash. Note also that you can't run an srun _insite_ of
# another srun.

# NOTE: when you specify --ntasks or --ntasks-per-node in the jobscript header,
# then srun inherits these. The command below is equivalent to: `srun -n 16`
srun julia hello_world.jl
