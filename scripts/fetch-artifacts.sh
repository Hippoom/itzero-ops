#!/bin/bash -xe

# script to publish artifacts to the artifacts repository with a unique build number
# the subsequent pipeline stages should fetch the built artifacts from the repository rather then re-build them

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "$script_dir"/artifacts/artifacts.sh #use quote here to compliant with space in dir


fetch_artifact "build" "spikes" "itzero" "jar"