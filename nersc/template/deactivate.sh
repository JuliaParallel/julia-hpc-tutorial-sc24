#!/usr/bin/env sh

ml unload julia

if [[ "${JULIA_PROJECT}" == "{{TUTORIAL_REPO_DIR}}" ]]
then
    unset JULIA_PROJECT
fi

if [[ "${JULIA_DEPOT_PATH}" == "${SCRATCH}/depot" ]]
then
    unset JULIA_DEPOT_PATH
fi

ml unload adios2
ml unload cray-hdf5-parallel
ml unuse /global/common/software/nersc/julia_hpc_24/modules/
