variable "lxc_ubuntu_22" { 
   default = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
}

variable "lxcs" {
   type = map(object(
        {
           name            = string
           searchdomain    = string
           nameserver      = string
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
                gw     = optional(string)
           })), [])
           mountpoint  = optional(list(object({
                slot    = string
                key     = string
                storage = string
                mp      = string
                size    = string
           })), [])
           inline          = list(string)
        }
    )) 
    default = {
        "ns1" = {
            name         = "ns1"
            searchdomain = "801labs.org"
            nameserver   = "192.168.40.2"
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
                ip     = "192.168.40.2/24"
                gw     = "192.168.40.1"
            }]
            inline   = [
                 "sudo apt update && sudo apt upgrade -y",
                 "sudo apt install -y bind9-utils dnsutils net-tools unbound"
            ]
        },
        "ansible" = {
            name         = "ansible"
            searchdomain = "801labs.org"
            nameserver   = "192.168.40.2"
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
                ip     = "192.168.40.4/24"
                gw     = "192.168.40.1"
            }]
            inline   = [
                 "apt update",
                 "apt install software-properties-common",
                 "apt-add-repository ppa:ansible/ansible",
                 "apt update && sudo apt install -y ansible",
                 "apt upgrade -y"
            ]
        },
	"apt_cache" = {
            name         = "apt-cache"
            searchdomain = "801labs.org"
            nameserver   = "192.168.40.2"
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
                ip     = "192.168.40.11/24"
                gw     = "192.168.40.1"
            }]
            mountpoint = [{
                slot    = "0"
                key     = "0"
                storage = "LVM-SLOW"
                size    = "100G"
                mp      = "/appdata"
            }]
            inline     = [
                 "sudo mkdir -p /etc/apt/keyrings",
                 "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
                 "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu && $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
                 "sudo apt update",
                 "sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin",
                 "docker run --name apt-cacher-ng --init -d --restart=always --publish 80:3142 --volume /appdata/apt-cacher-ng:/var/cache/apt-cacher-ng sameersbn/apt-cacher-ng"
            ]
        },    
	"drone" = {
            name         = "drone"
            searchdomain = "801labs.org"
            nameserver   = "192.168.40.2"
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
                ip     = "192.168.40.12/24"
                gw     = "192.168.40.1"
            }]
            inline     = [
                 "sudo mkdir -p /etc/apt/keyrings",
                 "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
                 "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu && $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
                 "sudo apt update",
                 "sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin",
            ]
        },
        "nginx_cache" = {
            name         = "nginx-cache"
            searchdomain = "801labs.org"
            nameserver   = "192.168.40.2"
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
                ip     = "192.168.40.10/24"
                gw     = "192.168.40.1"
            }]
            mountpoint = [{
                slot    = "0"
                key     = "0"
                storage = "LVM-SLOW"
                size    = "55G"
                mp      = "/cache"
            }]
            inline     = [
                 "sudo mkdir -p /etc/apt/keyrings",
                 "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
                 "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu && $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
                 "sudo apt update",
                 "sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin",
                 "sudo docker run -d --restart always --name lancache -v /cache/data:/data/cache -v /cache/logs:/data/logs -p 80:80 -p 443:443 -e CACHE_MAX_AGE=3560d -e CACHE_DISK_SIZE=1000000m lancachenet/monolithic:latest"
            ]
        },
        "nextcloud" = {
            name         = "nextcloud"
            searchdomain = "801labs.org"
            nameserver   = "192.168.40.2"
            node_name    = "dc801srv"
            cores        = "4"
            memory       = "4096"
            unprivileged = true
            nesting      = true
            storage      = "local-lvm"
            rootfs_size  = "15G"
            network      = [{
                name   = "eth0"
                bridge = "vmbr0"
                ip     = "192.168.40.7/24"
                gw     = "192.168.40.1"
            }]
            mountpoint = [{
	        slot    = "0"
	        key     = "0"
	        storage = "LVM-SLOW"
	        size    = "100G"
	        mp      = "/var/lib/docker/volumes/nextcloud"
            }]	
            inline   = [
		 "sudo mkdir -p /etc/apt/keyrings",
                 "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
                 "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu && $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
                 "sudo apt update",
                 "sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin",
                 "docker run -d -v nextlcloud:/var/www/html nextcloud -e NEXT_CLOUD_ADMIN_USER=nextcloud"
            ]
        }
    }
}


variable "pm_user" {}
variable "pm_password" {}
variable "lxc_password" {}
variable "ssh_keys" {}
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

variable "lxc_slow_storage" {
  default = "LVM-SLOW"
}
