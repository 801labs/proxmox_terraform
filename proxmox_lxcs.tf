resource "proxmox_lxc" "lxcs" {
   for_each      = var.lxcs
   target_node   = each.value.node_name
   hostname      = each.value.name
   searchdomain  = each.value.searchdomain
   nameserver    = each.value.nameserver
   unprivileged  = each.value.unprivileged
   ostemplate    = var.lxc_ubuntu_22
   start         = true
   onboot        = true
   password      = var.lxc_password

   ssh_public_keys = <<-EOT
	${var.ssh_keys}
   EOT
   
   cores        = each.value.cores
   memory       = each.value.memory
   
   rootfs {
       storage  = each.value.storage
       size     = each.value.rootfs_size 
   }

   dynamic "mountpoint" {
     for_each = each.value.mountpoint
     content {
       slot       = mountpoint.value.slot
       key        = mountpoint.value.key
       storage    = mountpoint.value.storage
       mp         = mountpoint.value.mp
       size       = mountpoint.value.size
     }
   }

   dynamic "network" {
     for_each = each.value.network
     content {
       name       = network.value.name
       bridge     = network.value.bridge
       ip         = network.value.ip
       gw         = network.value.gw
     } 
   }

   features {
      keyctl    = each.value.keyctl
      nesting   = each.value.nesting
      mount     = each.value.mount 
   }
}
