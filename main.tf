terraform {
  required_providers {
    proxmox = {
      source = "blz-ea/proxmox"
      version = "0.3.3"
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
