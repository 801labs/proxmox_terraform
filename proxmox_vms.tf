resource "proxmox_vm_qemu" "ubuntu_vms" {
  for_each    = var.vms
  name        = "${each.value.name}-${each.value.index}"
  target_node = var.node_name

  clone = var.template_name

  cores  = each.value.cores
  memory = each.value.memory

  os_type  = each.value.os_type
  boot     = "cdn"
  sshkeys  = var.ssh_keys
  ssh_user = var.ssh_user

  network {
    bridge = each.value.network_bridge
    model  = "virtio"
  }

  connection {
    type        = "ssh"
    user        = self.ssh_user
    private_key = self.ssh_private_key
    host        = "${each.value.name}-${each.value.index}"
  }

  disk {
    size    = each.value.disk_size
    storage = each.value.disk_datastore
    type    = each.value.disk_type
  }

  depends_on = [
    null_resource.cloud_init_config_files
  ]

  cicustom                = "user=local:snippets/user_data_${each.value.name}-${each.value.index}.yml"
  cloudinit_cdrom_storage = each.value.disk_datastore

  provisioner "remote-exec" {
    inline = [
      "ip a"
    ]
  }
}


data "template_file" "user_data" {
  for_each = var.vms
  template = file("${path.module}/cloud_init/user_data.cfg")
  vars = {
    pubkey   = file(pathexpand("~/.ssh/id_rsa.pub"))
    hostname = "${each.value.name}-${each.value.index}"
    username = var.ssh_user
  }
}

resource "local_file" "cloud_init_user_data_file" {
  for_each = var.vms
  content  = data.template_file.user_data["${each.value.name}-${each.value.index}"].rendered
  filename = "${path.module}/files/user_data_${each.value.index}.cfg"
}

resource "null_resource" "cloud_init_config_files" {
  for_each = var.vms
  connection {
    type     = "ssh"
    user     = var.pm_user
    password = var.pm_password
    host     = "${each.value.name}-${each.value.index}"
  }

  provisioner "file" {
    source      = local_file.cloud_init_user_data_file["${each.value.name}-${each.value.index}"].filename
    destination = "/var/lib/vz/snippets/user_data_${each.value.name}-${each.value.index}.yml"
  }
}

