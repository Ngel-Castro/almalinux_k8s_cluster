terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }

  backend "s3" {
    bucket         = "proxmox-s3-backend"
    key            = "proxmox/terraform.tfstate"
    region         = "us-east-1"  # Change this to your bucket's region
    dynamodb_table = "TerraformLocks"
    encrypt        = true
  }

}

provider "proxmox" {
  pm_api_url = var.proxmox_host
  pm_api_token_id = var.proxmox_token_id
  pm_api_token_secret = var.proxmox_token_secret
  pm_tls_insecure = true
  pm_debug = true
}
