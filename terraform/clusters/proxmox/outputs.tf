output "controllers_ips" {
  value = [for i, vm in proxmox_vm_qemu.controller : "controller${i + 1} ${vm.default_ipv4_address}" ]
}

output "workers_ips" {
  value = [for i, vm in proxmox_vm_qemu.worker : "worker${i + 1} ${vm.default_ipv4_address}" ]
}