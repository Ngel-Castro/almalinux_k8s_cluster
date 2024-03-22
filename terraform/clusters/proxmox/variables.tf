variable "proxmox_host" {
  description = "Value for proxmox cluster/server"
  type        = string
  default     = "https://192.168.0.131:8006/api2/json"
}

variable "proxmox_token_id" {
  description = "Proxmox Token user@pam!token_id"
  type        = string
  default     = "terraform-prov@pve!terraform"
}

variable "proxmox_token_secret" {
  description = "Proxmox token secret"
  type        = string
}

variable "controller" {
  description = "Number of controllers"
  type        = number
  default      = 1
}

variable "worker" {
  description = "Number of workers"
  type        = number
  default     = 1
}

variable "target_node" {
  description = "Target node where the VM will be allocated"
  type        = string
  default     = "proxmox"
}

variable "storage" {
  description = "Storage location in PROXMOX node"
  type        = string
  default     = "samsung_ssd"
}

variable "full_clone" {
  description = "If you required full clone or not"
  type        = bool
  default     = false
}

variable "template_name" {
  description = "If you required full clone or not"
  type        = string
  default     = "cluster-template"
}
