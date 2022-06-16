
resource "proxmox_vm_qemu" "samba_server" {
  name        = "samba-server"
  target_node = var.node_name

  full_clone = false
  onboot = true

  cores  = var.samba_cores
  memory = var.samba_memory

  cipassword = var.ssh_password
  ciuser     = var.ssh_user
  sshkeys    = var.ssh_keys
  ipconfig0  = "ip=${var.samba_ip}/24,gw=${var.gateway}"

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  connection {
    type     = "ssh"
    user     = var.ssh_user
    password = var.ssh_password
    host     = var.ssh_forward_ip
  }

  disk {
    backup = 0
    cache = "writeback"
    file = "vm-101-disk-0"
    format = "raw"
    size = "115G"
    storage = "local-lvm"
    type = "scsi"
    volume = "local-lvm:vm-101-disk-0"
  }

  
}

resource "proxmox_vm_qemu" "dns1" {
  name        = "ns1"
  target_node = var.node_name

  full_clone = true
  clone = var.template_name
  onboot = true

  cores  = var.dns_cores
  memory = var.dns_memory

  cipassword = var.ssh_password
  ciuser     = var.ssh_user
  sshkeys    = var.ssh_keys
  ipconfig0  = "ip=${var.dns_ip}/24,gw=${var.gateway}"

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  connection {
    type     = "ssh"
    user     = var.ssh_user
    password = var.ssh_password
    host     = var.ssh_forward_ip
  }


  provisioner "remote-exec" {
    inline = [
      "sudo sed -e 's/${var.ssh_forward_ip}/${var.dns_ip}/g' -i /etc/netplan/00-installer-config.yaml",
      "netplan apply &"
    ]
  }
}


