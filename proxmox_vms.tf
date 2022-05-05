
resource "proxmox_vm_qemu" "ubuntu_vms" {
  for_each    = var.vms
  name        = "${each.value.name}-${each.value.index}"
  target_node = var.node_name

  clone      = var.template_name
  full_clone = true

  cores  = each.value.cores
  memory = each.value.memory

  os_type = each.value.os_type
  boot    = "cd"

  cipassword = var.ssh_password
  ciuser     = var.ssh_user
  sshkeys    = var.ssh_keys
  ipconfig0  = "ip=${each.value.ip}/24,gw=${var.gateway}"

  network {
    bridge = each.value.network_bridge
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
      "sudo sed -e 's/${var.ssh_forward_ip}/${each.value.ip}/g' -i /etc/netplan/00-installer-config.yaml",
      "netplan apply &"
    ]
  }
}
