variable "vms" {
  type = map(
    object(
      {
        name           = string
        os_type        = string
        memory         = number
        agent          = bool
        disk_datastore = string
        disk_size      = number
        disk_format    = string
        cores          = number
        ssh_user       = string
      }

    )
  )
  default = {
    "ubuntu-test-1" = {
      name           = "ubuntu-test-1"
      os_type        = "l26"
      agent          = true
      cores          = 2
      memory         = 2048
      disk_datastore = "local-lvm"
      disk_size      = 30
      disk_format    = "raw"
      ssh_user       = "chad"

    },
    "ubuntu-test-2" = {
      name           = "ubuntu-test-2"
      disk_datastore = "local-lvm"
      agent          = true
      os_type        = "l26"
      cores          = 2
      memory         = 2048
      disk_size      = 30
      disk_format    = "raw"
      ssh_user       = "cwayment"

    }
  }
}

variable "ssh_key_user1" {}
variable "pm_user" {}
variable "pm_password" {}
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
  default     = "https://192.168.40.201:8006"
  description = "Proxmox url for connecting to api"
}


