#!/bin/bash -xe

project_home="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )"

user_home="$(eval echo ~$USER)"

main_image="spikes/itzero"

test_image="spikes/itzero-test"



