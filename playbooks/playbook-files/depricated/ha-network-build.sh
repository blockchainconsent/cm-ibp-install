#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

COMMAND=$1
if [ "${COMMAND}" = "build" ]; then
    set -x
    ansible-playbook -vvv create-ca-01.yml
    ansible-playbook -vvv create-ca-ord-01.yml
elif [ "${COMMAND}" = "destroy" ]; then
    echo "this isn't ready yet"
fi