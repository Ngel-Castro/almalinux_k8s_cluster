#!/bin/bash
source ~/.personal_vault/todopoderoso
export tfvars=/Users/angel.castrobasurto/Projects/almalinux_k8s_cluster/terraform/clusters/proxmox/env/homelab/terraform.tfvars

# This should be migrated to github actions

cd terraform/clusters/proxmox
terraform init
terraform apply --auto-approve -var-file=$tfvars -var="proxmox_token_id=${PROXMOX_TOKEN_ID}" -var="proxmox_token_secret=${PROXMOX_TOKEN_SECRET}"
terraform output -json hosts_map > hosts_map.json
python ../../../scripts/create_invetory.py
mv inventory.yml ../../../ansible/inventory/alma_cluster/inventory.yml
cd ../../../
ansible-playbook site.yml --extra-vars "cluster_password=$CLUSTER_PASSWORD ansible_sudo_pass=$CLUSTER_PASSWORD"

#TODO:
#git checkouts ansible/inventory/alma_cluster/inventory.yml
#creates a branch and pull request for main
