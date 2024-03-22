locals {
  controller_ips = { for i, vm in proxmox_vm_qemu.controller : "controller${i + 1}" => vm.default_ipv4_address }
  worker_ips = { for i, vm in proxmox_vm_qemu.worker : "worker${i + 1}" => vm.default_ipv4_address }
  hosts_map = tomap({"controllers" = local.controller_ips, "workers" = local.worker_ips})
}
