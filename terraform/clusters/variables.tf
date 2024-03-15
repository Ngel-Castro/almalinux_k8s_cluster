variable "proxmox_host" {
  description = "Value for proxmox cluster/server"
  type        = string
  default     = "https://192.168.0.131:8006/api2/json"
}

variable "proxmox_token_id" {
  description = "Proxmox Token user@pam!token_id"
  type        = string
  default     = "terraform-admin@pam!terraform"
}

variable "proxmox_token_secret" {
  description = "Proxmox token secret"
  type        = string
}