resource "proxmox_virtual_environment_vm" "ubuntu_vms" {
  for_each  = var.vms
  name      = each.value.name
  node_name = var.node_name
  cpu {
    cores = each.value.cores
  }

  agent {
    enabled = each.value.agent
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      username = each.value.ssh_user
      keys     = [var.ssh_key_user1]
    }
  }
  memory {
    dedicated = each.value.memory
  }
  operating_system {
    type = each.value.os_type
  }
  disk {
    size         = each.value.disk_size
    datastore_id = each.value.disk_datastore
    file_id      = proxmox_virtual_environment_file.ubuntu_server_image.id
    file_format  = each.value.disk_format
  }

}

resource "proxmox_virtual_environment_file" "ubuntu_server_image" {
  content_type = "iso"
  datastore_id = var.datastore_name
  node_name    = var.node_name
  source_file {
    path = "https://releases.ubuntu.com/20.04/ubuntu-20.04.3-live-server-amd64.iso"
  }
}
