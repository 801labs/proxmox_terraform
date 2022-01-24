
resource "proxmox_vm_qemu" "vms" {
	for_each = var.vms
	name = each.value.name	
	target_node = each.value.target_node	
	iso = each.value.iso
	cores = each.value.cores
	os_type = each.value.os_type
	

	connection {
		type = "ssh"
		user = "${self.ssh_user}"
		private_key = var.ssh_key
		host = "${self.ssh_host}"
	}
}
