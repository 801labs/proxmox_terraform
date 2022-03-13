resource "proxmox_vm_qemu" "ubuntu_vms" {
  for_each    = var.vms
  name        = each.value.name
  target_node = var.node_name

  iso = var.ubuntu_cloud_iso

  cores  = each.value.cores
  memory = each.value.memory

  os_type  = each.value.os_type
  boot     = "cdn"
  sshkeys  = var.ssh_keys
  ssh_user = "root"

  connection {
    type        = "ssh"
    user        = self.ssh_user
    private_key = self.ssh_private_key
  }


  disk {
    size    = each.value.disk_size
    storage = each.value.disk_datastore
    type    = each.value.disk_type
  }

}


data "template_file" "user_data" {
  count = var.vm_count

}
