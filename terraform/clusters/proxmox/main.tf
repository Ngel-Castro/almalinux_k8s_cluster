resource "proxmox_vm_qemu" "controller" {
    count       = var.controller
    name        = "controller${count.index + 1}"
    target_node = "proxmox"
    memory      = 3072
    cores       = 2
    full_clone  = true

    ### or for a Clone VM operation
    clone = "cluster-template"

    disks {
        virtio {
            virtio0 {
                disk {
                iothread = true
                size     = 32
                storage  = "local-lvm"
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
    full_clone  = true

    ### or for a Clone VM operation
    clone = "cluster-template"

    disks {
        virtio {
            virtio0 {
                disk {
                iothread = true
                size     = 32
                storage  = "local-lvm"
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