variable "firewall_name" {
  description = "Target Azure Firewall name where collection rules would be created"
  type        = string
}
variable "resource_group" {
  description = "Target Azure Firewall Resource Group"
  type        = string
}

variable "network_rule_collections" {
  description = "Creates a network rule collection"
  type = list(object({
    name     = string,
    priority = number,
    action   = string,
    rules = list(object({
      name                  = string,
      source_addresses      = optional(list(string), null),
      source_ip_groups      = optional(list(string), null),
      destination_ports     = optional(list(string), null),
      destination_addresses = optional(list(string), null),
      destination_ip_groups = optional(list(string), null),
      destination_fqdns     = optional(list(string), null),
      protocols             = optional(list(string), ["TCP"])
    }))
  }))
  default = []
}
