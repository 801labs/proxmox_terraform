# proxmox_terraform

First install terraform for your local machine https://www.terraform.io/downloads

Next configure your local credentials to manage the proxmox with your permissions by copying the init_example.sh to anything *init.sh and replacing the <terrafom_user> and <terraform_pass> values with your credentials to your proxmox instance. *Make sure to use this convention so you don't accidentally commit your local creds to the repo.*

Next run 
```
myinit.sh
```


