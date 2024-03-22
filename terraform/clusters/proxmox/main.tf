resource "proxmox_vm_qemu" "controller" {
    count       = var.controller
    name        = "controller${count.index + 1}"
    target_node = var.target_node
    memory      = 3072
    cores       = 2
    scsihw      = "virtio-scsi-single"
    full_clone  = var.full_clone
    agent       = 1
    #ipconfig0   = "dhcp"

    ### or for a Clone VM operation
    clone = var.template_name
    disks {
        scsi {
            scsi0 {
                disk {
                    backup             = true
                    cache              = "none"
                    discard            = true
                    emulatessd         = true
                    iothread           = true
                    mbps_r_burst       = 0.0
                    mbps_r_concurrent  = 0.0
                    mbps_wr_burst      = 0.0
                    mbps_wr_concurrent = 0.0
                    replicate          = true
                    size               = 32
                    storage            = var.storage
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
    count       = var.worker
    name        = "worker${count.index + 1}"
    target_node = "proxmox"
    memory      = 4096
    cores       = 2
    scsihw      = "virtio-scsi-single"
    full_clone  = var.full_clone
    agent       = 1
    #ipconfig0   = "dhcp"

    ### or for a Clone VM operation
    clone = var.template_name
    disks {
        scsi {
            scsi0 {
                disk {
                    backup             = true
                    cache              = "none"
                    discard            = true
                    emulatessd         = true
                    iothread           = true
                    mbps_r_burst       = 0.0
                    mbps_r_concurrent  = 0.0
                    mbps_wr_burst      = 0.0
                    mbps_wr_concurrent = 0.0
                    replicate          = true
                    size               = 32
                    storage            = var.storage
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