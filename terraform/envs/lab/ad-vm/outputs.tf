output "ad_vm_name" {
  value = azurerm_windows_virtual_machine.ad_vm.name
}

output "ad_vm_private_ip" {
  value = azurerm_network_interface.ad_nic.private_ip_address
}

