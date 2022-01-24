variable "vms" {
	type = map(
		object(
			{
				name = string
				target_node = string
				iso = string
				os_type = string
				cores = number
				ssh_user = string
				ssh_host = string
			}
					
		)
	)
	default = { 
		"ubuntu-test-1" = {
			name = "ubuntu-test-1"
			target_node = "proxtest1"
			iso = "ubuntu-20.04.3-live-server-amd64.iso"
			os_type = "ubuntu"
			cores = 2
			ssh_user = "terraform"
			ssh_host = "ubuntu-test-1"

		},
		"ubuntu-test-2" = {
			name = "ubuntu-test-2"
			target_node = "proxtest1"
			iso = "ubuntu-20.04.3-live-server-amd64.iso"
			os_type = "ubuntu"
			cores = 2
			ssh_user = "jack"
			ssh_host = "ubuntu-test-2"
				
		}
	}
}

variable "ssh_key" {}
