#!/bin/sh
set -e

ENV_ID=$1
ansible-playbook -v -e env_id=${ENV_ID} /opt/playbooks/provision/playbook.yml
sleep 120
ansible-playbook -v -e env_id=${ENV_ID} /opt/playbooks/workflow/prepare.yml
ansible-playbook -v -e env_id=${ENV_ID} /opt/playbooks/workflow/deployment.yml
ansible-playbook -v -e env_id=${ENV_ID} /opt/playbooks/workflow/configure.yml
ansible-playbook -v -e env_id=${ENV_ID} /opt/playbooks/workflow/migrate.yml
