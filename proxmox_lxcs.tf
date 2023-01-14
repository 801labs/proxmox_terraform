resource "proxmox_lxc" "bashs_lxc" {
   target_node = var.node_name
   hostname = "fog"
   password = var.lxc_password
   unprivileged = true

   ostemplate = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
   cores = "4"
   memory = "4096"
   start = true
    

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

   features {
     nesting = true
     mount = "nfs"
   }
   
   network {
     name = "eth0"
     bridge = "vmbr0"
     ip = "dhcp"
   }

}

reosource "proxmox_lxc" "lxcs" {
   foreach      = var.lxcs
   name         = each.value.name
   unprivileged = each.value.unprivileged
   ostemplate   = var.lxc_ubuntu_22
   start        = true
   
   cores        = each.value.cores
   memory       = each.value.memory
   
   rootfs {
       storage  = each.value.storage
       size     = each.value.rootfs_size 
   }
   
   features {
      keyctl    = each.value.keyctl
      nesting   = each.value.nesting
      mount     = each.value.mount 
   }

   dynamic "network" {
     for_each = each.value.network
     network {
       name       = each.value.interface_name
       bridge     = each.value.bridge
       ip         = each.value.ip_type
     } 
   }

   dynamic "mountpoint" {
     for_each = each.value.mountpoint
     mountpoint {
       slot       = each.value.slot
       key        = each.value.key
       storage    = each.value.storage
       mp         = each.value.location
       size       = each.value.size
     }
   }

}


