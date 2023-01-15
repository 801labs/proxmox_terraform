resource "proxmox_lxc" "lxcs" {
   for_each      = var.lxcs
   target_node   = each.value.node_name
   hostname      = each.value.name
   searchdomain  = each.value.searchdomain
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

   connection {
       host = self.network[0].ip
       user = "root"
       password = var.lxc_password 
       type = "ssh"
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
     } 
   }

   provisioner "remote-exec" {
        inline = each.value.inline
   }

   features {
      keyctl    = each.value.keyctl
      nesting   = each.value.nesting
      mount     = each.value.mount 
   }
}

resource "null_resource" "ns_file" {
   connection {
       host = "192.168.40.2"
       type = "ssh"
       user = "root"
       password = var.lxc_password 
   }

   provisioner "file" {
       source = "dns/root-auto-trust-anchor-file.conf"
       destination = "/etc/unbound/unbound.conf.d/root-auto-trust-anchor-file.conf"
   }
   
   depends_on = [proxmox_lxc.lxcs["ns1"]]
}
