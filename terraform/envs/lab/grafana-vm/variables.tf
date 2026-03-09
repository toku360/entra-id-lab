variable "location" {
  type    = string
  default = "Japan East"
}

variable "resource_group_name" {
  type    = string
  default = "rg-entra-id-lab"
}

variable "vnet_name" {
  type    = string
  default = "vnet-lab"
}

variable "subnet_name" {
  type    = string
  default = "subnet-lab"
}

# Grafana VM
variable "vm_name" {
  type    = string
  default = "vm-grafana01"
}

variable "vm_size" {
  type    = string
  default = "Standard_D2as_v4"
}

variable "admin_username" {
  type    = string
  default = "localadmin"
}

variable "admin_password" {
  type      = string
  sensitive = true
}

# 証跡として tag を揃える
variable "tags" {
  type = map(string)
  default = {
    project = "entra-id-lab"
    phase   = "phase3"
    role    = "grafana"
  }
}

