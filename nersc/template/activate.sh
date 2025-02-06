#!/usr/bin/env sh

ml load julia

export JULIA_PROJECT={{TUTORIAL_REPO_DIR}}
export JULIA_DEPOT_PATH=/global/cfs/projectdirs/m4746/Users/nora/.julia

ml use /global/common/software/nersc/julia_hpc_24/modules/
ml load cray-hdf5-parallel
ml load adios2
