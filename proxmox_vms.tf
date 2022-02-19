resource "proxmox_virtual_environment_vm" "ubuntu_vms" {
  for_each  = var.vms
  name      = each.value.name
  node_name = var.node_name
  cpu {
    cores = each.value.cores
  }

  agent {
    enabled = each.value.agent
    timeout = "15m"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id

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

  network_device {}

  serial_device {}

}

resource "tls_private_key" "ubuntu_vm_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "random_password" "ubuntu_vm_password" {
  length  = 30
  special = true
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = var.datastore_name
  node_name    = var.node_name
  source_raw {
    file_name = "cloud_init"
    data      = <<EOF
    #!/usr/bin/env basho
    sudo apt-update 
    sudo apt-upgrade -y 
    sudo apt install nginx
    EOF
  }
}

resource "proxmox_virtual_environment_file" "ubuntu_server_image" {
  content_type = "iso"
  datastore_id = var.datastore_name
  node_name    = var.node_name
  source_file {
    path = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
  }
}

output "ubuntu_vm_pass" {
  value     = random_password.ubuntu_vm_password.result
  sensitive = true
}


