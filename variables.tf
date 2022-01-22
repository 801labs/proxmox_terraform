variable "vms" {
	type = map(
		object(
			{
				name = string
				target_node = string
				iso = string
			},
					
		)
	)
	default = { 
		"ubuntu-test-1" = {
			name = "ubuntu-test-1"
			target_node = "proxtest1"
			iso = "ubuntu-20.04.3-live-server-amd64.iso"
		},
		"ubuntu-test-2" = {
			name = "ubuntu-test-2"
			target_node = "proxtest1"
			iso = "ubuntu-20.04.3-live-server-amd64.iso"
		}
	}
}
