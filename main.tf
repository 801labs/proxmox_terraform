terraform {
  required_version = ">= 0.13"
  required_providers {
    proxmox = {
      source  = "blz-ea/proxmox"
      version = "99.0.0"
    }
  }
}

provider "proxmox" {
  virtual_environment {
    endpoint = var.proxmox_url
    username = var.pm_user
    password = var.pm_password
    insecure = true
  }
}
