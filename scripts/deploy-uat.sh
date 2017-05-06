#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
project_home="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )"

ansible-playbook -i profiles/uat/hosts playbooks/itzero.yml -e "WORKSPACE=\"${project_home}\"" -e "PROFILE=uat"