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

variable "lxc_ubuntu_22" { 
   default = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
}

variable "lxcs" {
   type = map(object(
        {
           name            = string
           node_name       = string
           cores           = string
           memory          = string
           keyctl          = optional(bool, null)
           unprivileged    = optional(bool, true)
           nesting         = optional(bool, null)
           mount           = optional(string, null)
           storage         = string
           rootfs_size     = string
           password        = optional(string, null)
           network         = optional(list(object({
                name   = string
                bridge = string
                ip     = string
           })), [])
           mountpoint  = optional(list(object({
                slot    = string
                key     = string
                storage = string
                mp      = string
                size    = string
           })), [])
        }
    )) 
    default = {
        "apt_cache" = {
            name         = "apt-cache"
            node_name    = "dc801srv"
            cores        = "2"
            memory       = "2048"
            keyctl       = true
            unprivileged = true
            nesting      = true
            storage      = "local-lvm"
            rootfs_size  = "15G"
            network      = [{
                name   = "eth0"
                bridge = "vmbr0"
                ip     = "dhcp"
            }]
            mountpoint = [{
                slot    = "0"
                key     = "0"
                storage = "LVM-SLOW"
                size    = "100G"
                mp      = "/cache"
            }]
        },    
        "ns1" = {
            name         = "ns1"
            node_name    = "dc801srv"
            cores        = "2"
            memory       = "2048"
            keyctl       = true
            unprivileged = true
            nesting      = true
            storage      = "local-lvm"
            rootfs_size  = "15G"
            network      = [{
                name   = "eth0"
                bridge = "vmbr0"
                ip     = "dhcp"
            }]
        },
        "ansible" = {
            name         = "ansible"
            node_name    = "dc801srv"
            cores        = "2"
            memory       = "2048"
            keyctl       = true
            unprivileged = true
            nesting      = true
            storage      = "local-lvm"
            rootfs_size  = "15G"
            network      = [{
                name   = "eth0"
                bridge = "vmbr0"
                ip     = "dhcp"
            }]
        },
        "samba" = {
            name         = "samba"
            node_name    = "dc801srv"
            cores        = "4"
            memory       = "4096"
            keyctl       = true
            unprivileged = true
            nesting      = true
            storage      = "local-lvm"
            rootfs_size  = "15G"
            network      = [{
                name   = "eth0"
                bridge = "vmbr0"
                ip     = "dhcp"
            }]
            mountpoint = [{
	        slot    = "0"
	        key     = "0"
	        storage = "LVM-SLOW"
	        size    = "100G"
	        mp      = "/cache"
            }]	
        },
	"fog" = {
            name         = "fog"
            node_name    = "dc801srv"
            cores        = "4"
            memory       = "4096"
            unprivileged = true
            nesting      = true
            mount        = "nfs" 
            storage      = "local-lvm"
            rootfs_size  = "15G"
            network      = [{
                name   = "eth0"
                bridge = "vmbr0"
                ip     = "dhcp"
            }]
            mountpoint = [{
                slot    = "0"
                key     = "0"
                storage = "local-lvm"
                size    = "8G"
                mp      = "/images"
            },
            {
                slot    = "1"
                key     = "1"
                storage = "LVM-SLOW"
                size    = "500G"
                mp      = "/images"
            }]
        }
    }
}

variable "dns_cores" {
  default = 2
}

variable "dns_memory" {
  default = 2048
}


variable "nginx_cache_ip" {
  default = "192.168.40.10"
}

variable "nginx_cache_cores" {
  default = 2
}

variable "nginx_cache_memory" {
  default = 2048
}

variable "dns_ip" {
  default = "192.168.40.2"
}

variable "saltmaster_cores" {
  default = 2
}

variable "saltmaster_memory" {
  default = 2048
}

variable "saltmaster_ip" {
  default = "192.168.40.6"
}


variable "pm_user" {}
variable "pm_password" {}
variable "lxc_password" {}
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

variable "lxc_slow_storage" {
  default = "LVM-SLOW"
}
variable "gateway" {
  default = "192.168.40.1"
}

variable "ssh_forward_ip" {
  default = "192.168.40.254"
}
