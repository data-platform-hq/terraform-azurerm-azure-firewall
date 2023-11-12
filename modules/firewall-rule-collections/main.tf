resource "azurerm_firewall_network_rule_collection" "network_rule_collection" {
  for_each = { for collection in var.network_rule_collections : collection.name => collection if collection.name != null }

  name                = each.key
  azure_firewall_name = var.firewall_name
  resource_group_name = var.resource_group
  priority            = each.value.priority
  action              = each.value.action

  dynamic "rule" {
    for_each = each.value.rules
    content {
      name                  = rule.value.name
      source_addresses      = rule.value.source_addresses
      source_ip_groups      = rule.value.source_ip_groups
      destination_addresses = rule.value.destination_addresses
      destination_ip_groups = rule.value.destination_ip_groups
      destination_fqdns     = rule.value.destination_fqdns
      destination_ports     = rule.value.destination_ports
      protocols             = rule.value.protocols
    }
  }
}
