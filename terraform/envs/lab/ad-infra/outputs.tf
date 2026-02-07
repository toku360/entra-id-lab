output "vm_id" {
  value = azurerm_windows_virtual_machine.vm.id
}

output "vm_private_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}

output "ad_subnet_id" {
  value = azurerm_subnet.ad.id
}
