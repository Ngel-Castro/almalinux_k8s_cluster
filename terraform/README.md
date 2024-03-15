# TERRAFORM homelab

```
source ~/.personal_vault/todopoderoso
export tfvar=/Users/angel.castrobasurto/Projects/almalinux_k8s_cluster/terraform/clusters/proxmox/env/homelab/terraform.tfvars

terraform init
terraform plan -var-file=$tfvars -var="proxmox_token_id=${PROXMOX_TOKEN_ID}" -var="proxmox_token_secret=${PROXMOX_TOKEN_SECRET}"
```
