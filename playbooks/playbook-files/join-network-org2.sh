#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
set -x
ansible-playbook -vvv 11-create-endorsing.yml
ansible-playbook -vvv 14-add-organization-to-channel.yml
ansible-playbook -vvv 16-join-peer-to-channel.yml
ansible-playbook -vvv 17-add-anchor-peer-to-channel.yml