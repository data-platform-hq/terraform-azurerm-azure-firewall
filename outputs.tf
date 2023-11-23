output "id" {
  value       = try(azurerm_firewall.this.id, null)
  description = "Azure Firewall id"
}

output "subnet_id" {
  value       = try(module.subnet.id, null)
  description = "Azure Firewall subnet id"
}

output "subnet_mgmt_id" {
  value       = try(module.subnet_mgmt[0].id, null)
  description = "Azure Firewall Management subnet id"
}

output "name" {
  value       = try(azurerm_firewall.this.name, null)
  description = "Azure Firewall name"
}

output "resource_group" {
  value       = try(azurerm_firewall.this.resource_group_name, null)
  description = "Azure Firewall resource group"
}

output "private_ip_address" {
  value       = try(azurerm_firewall.this.ip_configuration[0].private_ip_address, null)
  description = "Azure Firewall private ip address"
}

output "public_ip_address" {
  value       = try(azurerm_public_ip.fw.ip_address, null)
  description = "Azure Firewall public ip address"
}

output "public_ip_id" {
  value = try(azurerm_public_ip.fw.id, null)
  description = "Azure Firewall public ip address id"
}

output "public_ip_name" {
  value = try(azurerm_public_ip.fw.name, null)
  description = "Azure Firewall public ip address name"
}

output "public_mgmt_ip_name" {
  value = try(azurerm_public_ip.mgmt[0].name, null)
  description = "Azure Firewall public mgmt ip address name"
}
