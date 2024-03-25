proxmox_host      =   "https://192.168.0.131:8006/api2/json"
controller        = 2
worker            = 2
target_node       = "proxmox"
storage           = "samsung-ssd"
full_clone        = true
template_name     = "alma-cluster-stable"

# TODO: Separate values for each type of node `controller` and `worker`
