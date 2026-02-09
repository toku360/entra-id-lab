variable "location" {
  default = "Japan East"
}

variable "resource_group_name" {
  default = "rg-entra-id-lab"
}

variable "vnet_name" {
  default = "vnet-lab"
}

variable "subnet_name" {
  default = "snet-ad"
}

variable "vm_admin_username" {
  default = "localadmin"
}

variable "vm_admin_password" {
  description = "VM local admin password"
  sensitive   = true
}

