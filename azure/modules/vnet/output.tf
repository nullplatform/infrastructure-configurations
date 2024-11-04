output "vnet_name" {
  description = "The name of the created Virtual Network"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "The ID of the created Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_address_space" {
  description = "The address space of the Virtual Network"
  value       = azurerm_virtual_network.vnet.address_space
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = azurerm_subnet.private[*].id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = azurerm_subnet.public[*].id
}
