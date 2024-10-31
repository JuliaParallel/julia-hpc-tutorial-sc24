#!/usr/bin/env sh
set -eu

__GET_EXT_SH_DIR=$(
    cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd 
)

pushd $__GET_EXT_SH_DIR

# Download
curl -sSL \
    https://raw.githubusercontent.com/tests-always-included/mo/master/mo -o mo

# Make executable
chmod +x mo

# Test
echo "works" | ./mo

popd
