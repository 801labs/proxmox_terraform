resource "proxmox_lxc" "bashs_lxc" {
   target_node = var.node_name
   hostname = "fog"
   password = var.lxc_password

   ostemplate = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"

   rootfs {
     storage = var.samba_storage_pool
     size = "15G"
   }

   mountpoint {
     slot = "0"
     key = "0"
     mp = "/appdata"
     storage = var.samba_storage_pool
     size = "8G"
   }

   mountpoint {
     slot = "1"
     key = "1"
     storage = var.lxc_slow_storage
     mp = "/images"
     size = "500G"
   }
   
   network {
     name = "eth0"
     bridge = "vmbr0"
     ip = "dhcp"
   }

}
