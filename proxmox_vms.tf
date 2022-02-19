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

resource "tls_private_key" "ubuntu_vm_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "proxmox_virtual_environment_file" "ubuntu_server_image" {
  content_type = "iso"
  datastore_id = var.datastore_name
  node_name    = var.node_name
  source_file {
    path = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
  }
}

output "ubuntu_vm_private_key" {
  value     = tls_private_key.ubuntu_vm_key.private_key_pem
  sensitive = true
}

output "ubuntu_vm_public_key" {
  value = tls_private_key.ubuntu_vm_key.public_key_openssh
}
