#!/bin/bash -xe

project_home="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../../" && pwd )"

user_home="$(eval echo ~${USER})"

artifact_repository_base_url="http://localhost:8081"

function _build_dir {
    build_dir=$1

    if [ "${build_dir}x" = "x" ]; then echo "Please specify the relevant build directory"; return 1; fi

    echo "${project_home}/${build_dir}"
}

function _artifact_build_number_file_path {
    echo "$(_build_dir $1)/version"
}

function read_artifact_build_number {
    artifact_build_number_file=$(_artifact_build_number_file_path $1)

    echo $(cat "${artifact_build_number_file}")
}

function fetch_artifact {
    artifact_build_number=$(read_artifact_build_number $1)
    echo "artifact build number extracted: ${artifact_build_number}"


    group=$2
    artifact=$3
    version=${artifact_build_number}
    packaging=$4

    build_dir=$(_build_dir $1)

    mkdir -p "${build_dir}/libs"

    wget \
    --user="${artifact_repository_user}" \
    --password=${artifact_repository_password} \
    -O "${build_dir}/libs/${artifact}.${packaging}" \
    "${artifact_repository_base_url}/repository/maven-public/${group}/${artifact}/${artifact_build_number}/${artifact}-${artifact_build_number}.${packaging}"

}
