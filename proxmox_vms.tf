resource "proxmox_vm_qemu" "ubuntu_vms" {
  for_each    = var.vms
  name        = each.value.name
  target_node = var.node_name

  clone = var.template_name

  cores  = each.value.cores
  memory = each.value.memory

  os_type  = each.value.os_type
  boot     = "c"
  sshkeys  = var.ssh_keys
  ssh_user = "chad"

  network {
    bridge = each.value.network_bridge
    model  = "virtio"
  }

  connection {
    type        = "ssh"
    user        = self.ssh_user
    private_key = self.ssh_private_key
    host        = var.ipv4_address
  }

  disk {
    size    = each.value.disk_size
    storage = each.value.disk_datastore
    type    = each.value.disk_type
  }
}

