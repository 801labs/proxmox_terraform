
resource "proxmox_vm_qemu" "vms" {
	for_each = var.vms
	name = each.value.name	
	target_node = each.value.target_node	
	iso = each.value.iso
	
}
