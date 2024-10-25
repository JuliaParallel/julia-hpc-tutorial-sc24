#!/bin/sh

# Set `JULIA_CPU_TARGET`, to ensure we don't specialise pkgimages to the build
# host CPU.  Loosely based on
# https://github.com/JuliaCI/julia-buildkite/blob/ea50eb719242bc3e844227a2ebf54a49d308bafc/utilities/build_envs.sh#L25-L32
# https://github.com/JuliaCI/julia-buildkite/blob/ea50eb719242bc3e844227a2ebf54a49d308bafc/utilities/build_envs.sh#L58-L69
if [ "$(arch)" = "x86_64" ]; then
    export JULIA_CPU_TARGET='generic;sandybridge,-xsaveopt,clone_all;haswell,-rdrnd,base(1)'
elif [ "$(arch)" = "aarch64" ]; then
    export JULIA_CPU_TARGET='generic;carmel,clone_all;apple-m1,base(1)'
fi
