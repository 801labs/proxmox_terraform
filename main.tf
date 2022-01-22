terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.9.4"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://proxmox1:8006/api2/json"
}
