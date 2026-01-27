variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID for this environment"
}

variable "location" {
  type    = string
  default = "japaneast"
}

variable "rg_name" {
  type    = string
  default = "rg-entra-id-lab"
}

variable "vnet_name" {
  type    = string
  default = "vnet-lab"
}

variable "vnet_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "subnet_name" {
  type    = string
  default = "subnet-lab"
}

variable "subnet_cidr" {
  type    = string
  default = "10.10.1.0/24"
}

variable "law_name" {
  type    = string
  default = "law-entra-id-lab"
}

variable "bastion_name" {
  type    = string
  default = "bas-entra-id-lab"
}

variable "bastion_pip_name" {
  type    = string
  default = "pip-bas-entra-id-lab"
}

