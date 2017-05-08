#!/bin/bash -xe

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "$script_dir"/common.sh #use quote here to compliant with space in dir

profile=$1
version=$2
host=$3
port=$4


docker rm -vf $profile-itzero-test | true

docker run \
           --rm \
           --name $profile-itzero-test \
           -t \
           -v "$user_home"/.gradle:/root/.gradle \
           -v "$project_home"/build/reports:/project/build/reports \
           -e ITZERO_BASE_URI=${host} \
           -e ITZERO_PORT=${port} \
           $test_image:$version \
           smokeTest --no-daemon
