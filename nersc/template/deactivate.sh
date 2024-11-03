#!/usr/bin/env sh

if [[ "${JULIA_PROJECT}" == "{{TUTORIAL_REPO_DIR}}" ]]
then
    unset JULIA_PROJECT
fi

if [[ "${JULIA_DEPOT_PATH}" == "${SCRATCH}/depot" ]]
then
    unset JULIA_DEPOT_PATH
fi
