terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.6"
    }
  }
}

provider "proxmox" {
  pm_api_url      = var.proxmox_url
  pm_tls_insecure = true
  pm_password     = var.pm_password
  pm_user         = var.pm_user
  pm_log_file     = "terraform_proxmox.log"
  pm_log_enable   = false
  pm_debug        = false
  pm_log_levels = {
    _default    = "false"
    _capturelog = ""
  }
}
