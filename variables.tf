variable "sku" {
  description = "SKU tier of the Firewall. Possible values are Premium, Standard and Basic."
  type        = string
  default     = "Basic"
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "firewall_name" {
  description = "Specifies the name of the Firewall."
  type        = string
}

variable "resource_group" {
  description = "The name of the resource group in which to create the resource. Has to be the same resource group as the VNet."
  type        = string
}

variable "vnet_name" {
  description = "Name of VNet where Firewall would be created."
  type        = string
}

variable "subnet_cidr" {
  description = "IP addresses range of 'AzureFirewallSubnet', has to be at least /26"
  type        = string
}

variable "subnet_management_cidr" {
  description = "IP addresses range of 'AzureFirewallManagementSubnet', has to be at least /26. This subnet created only when SKU is set to 'Basic'"
  type        = string
  default     = null
}

variable "dns_servers" {
  description = "A list of DNS servers that the Azure Firewall will direct DNS traffic to the for name resolution."
  type        = list(string)
  default     = []
}

variable "network_rule_collections" {
  description = "List of object with parameters to create network rule collections"
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
