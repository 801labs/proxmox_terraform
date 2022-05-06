variable "vms" {
  type = map(
    object(
      {
        index          = number
        name           = string
        os_type        = string
        qemu_os        = string
        ip             = string
        memory         = number
        onboot         = bool
        agent          = number
        disk_datastore = string
        disk_size      = string
        disk_type      = string
        disk_format    = string
        cores          = number
        network_bridge = string
      }

    )
  )
  default = {
    "ubuntu-test-1" = {
      index          = "1"
      name           = "ubuntu-test"
      os_type        = "cloud-init"
      qemu_os        = "l26"
      agent          = 0
      cores          = 2
      onboot         = true
      memory         = 2048
      disk_datastore = "local-lvm"
      disk_size      = "30G"
      ip             = "192.168.40.2"
      disk_type      = "sata"
      disk_format    = "raw"
      network_bridge = "vmbr0"

    },
    "ubuntu-test-2" = {
      index          = "2"
      name           = "ubuntu-test"
      disk_datastore = "local-lvm"
      agent          = 0
      onboot         = true
      os_type        = "cloud-init"
      qemu_os        = "l26"
      cores          = 2
      memory         = 2048
      disk_size      = "30G"
      disk_type      = "sata"
      disk_format    = "raw"
      ip             = "192.168.40.3"
      network_bridge = "vmbr0"

    }
  }
}

variable "pm_user" {}
variable "pm_ssh_user" {}
variable "pm_host" {}
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
