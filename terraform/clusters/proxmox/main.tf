resource "proxmox_vm_qemu" "controller" {
    count       = var.controller
    name        = "controller${count.index + 1}"
    target_node = "proxmox"
    memory      = 3072
    cores       = 2

    ### or for a Clone VM operation
    clone = "cluster-template"

    disks {
        scsi {
            scsi0 {
                disk {
                size = 32
                storage = "local-lvm"
                }
            }
        }
    }
    network {
        bridge    = "vmbr0"
        firewall  = false
        link_down = false
        model     = "virtio"
    }
}

resource "proxmox_vm_qemu" "worker" {
    count       = var.controller
    name        = "worker${count.index + 1}"
    target_node = "proxmox"
    memory      = 4096
    cores       = 2

    ### or for a Clone VM operation
    clone = "cluster-template"

    disks {
        scsi {
            scsi0 {
                disk {
                size = 32
                storage = "local-lvm"
                }
            }
        }
    }
    network {
        bridge    = "vmbr0"
        firewall  = false
        link_down = false
        model     = "virtio"
    }
}