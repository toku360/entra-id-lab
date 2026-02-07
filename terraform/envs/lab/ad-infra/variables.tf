variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID for this environment"
}

variable "location" {
  type    = string
  default = "japaneast"
}

# 既存リソース（Phase1）
variable "rg_name" {
  type    = string
  default = "rg-entra-id-lab"
}
variable "vnet_name" {
  type    = string
  default = "vnet-lab"
}

# Phase2 追加
variable "ad_subnet_name" {
  type    = string
  default = "snet-ad"
}

variable "ad_subnet_cidr" {
  type    = string
  default = "10.10.10.0/24"
}

variable "vm_name" {
  type    = string
  default = "vm-dc01"
}

variable "vm_size" {
  type    = string
  default = "Standard_D2as_v4"
}

variable "admin_username" {
  type    = string
  default = "adadmin"
}

# パスワードは tfvars で渡す（Gitに上げない）
variable "admin_password" {
  type      = string
  sensitive = true
}

# NSG：BastionSubnet からのみ RDP 許可（安全）
# Phase1で Bastion を vnet-lab に置いていない場合があるため、
# vnet-lab 内に "AzureBastionSubnet" が無い場合は Step2-1-4で検証して分岐する
