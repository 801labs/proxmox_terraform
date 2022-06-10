variable "samba_cores" {
  default = 2
}

variable "samba_memory" {
  default = 4096
}

variable "samba_disk_size" {
  default = "100G"
}

variable "samba_storage_pool" {
  default = "local-lvm"
}

variable "samba_ip" {
  default = "192.168.40.5"
}

variable "samba_vlan" {
  default = 40
}

variable "pm_user" {}
variable "pm_password" {}
variable "ssh_keys" {}
variable "ssh_user" {}
variable "ssh_password" {}
variable "datastore_name" {
  default     = "local"
  description = "name of datastore for storing images and local data"
}
#variable "pm_api_token_secret" {}
#variable "pm_api_token_id" {}

variable "node_name" {
  default     = "proxmox1"
  description = "name of proxmox node"
}

variable "proxmox_url" {
  default     = "https://192.168.40.201:8006/api2/json"
  description = "Proxmox url for connecting to api"
}

variable "template_name" {
  default = "ubuntu-20.04-template"
}

variable "gateway" {
  default = "192.168.40.1"
}

variable "ssh_forward_ip" {
  default = "192.168.40.254"
}
