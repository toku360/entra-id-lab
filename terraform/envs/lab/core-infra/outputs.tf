output "resource_group_name" { value = azurerm_resource_group.rg.name }
output "vnet_name" { value = azurerm_virtual_network.vnet.name }
output "subnet_name" { value = azurerm_subnet.subnet.name }
output "law_id" { value = azurerm_log_analytics_workspace.law.id }
output "bastion_id" { value = azurerm_bastion_host.bastion.id }
