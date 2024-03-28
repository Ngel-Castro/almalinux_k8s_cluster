<<<<<<< HEAD
output "hosts_map" {
    value = local.hosts_map
}
=======
output "controllers_ips" {
  value = [for i, vm in proxmox_vm_qemu.controller : "controller${i + 1} ${vm.default_ipv4_address}" ]
}

output "workers_ips" {
  value = [for i, vm in proxmox_vm_qemu.worker : "worker${i + 1} ${vm.default_ipv4_address}" ]
}
>>>>>>> 9efb264 (handling qemu agents and getting outputs after creating a VM)
