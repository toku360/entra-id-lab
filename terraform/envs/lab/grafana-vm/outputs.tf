output "grafana_vm_id" {
  value = azurerm_windows_virtual_machine.vm.id
}

output "grafana_private_ip" {
  value = azurerm_network_interface.nic.ip_configuration[0].private_ip_address
}

output "grafana_nsg_id" {
  value = azurerm_network_security_group.nsg.id
}

