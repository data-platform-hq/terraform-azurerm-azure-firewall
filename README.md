# Azure Firewall Terraform module
Terraform module for creation Azure Firewall

## Usage
This module is provisioning Azure Firewall
```hcl
data "azurerm_virtual_network" "example" {
  name                = "example-name"
  resource_group_name = "example-rg"
}

data "azurerm_resource_group" "example" {
  name = "example-rg"
}

module "firewall" {
  source = "data-platform-hq/firewall/azurerm"

  firewall_name  = "fw-data-hq-dev-example"
  resource_group = data.azurerm_resource_group.example.name
  location       = "eastus"
  vnet_name      = data.azurerm_virtual_network.example.name
  subnet_cidr    = "10.0.0.0/8"
  sku            = "Standard"
  dns_servers    = ["1.1.1.1"]
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements
| Name                                                                      | Version   |
|---------------------------------------------------------------------------|-----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | >= 3.65.0 |

## Providers

| Name                                                           | Version   |
|----------------------------------------------------------------|-----------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm)  | >= 3.65.0 |

## Modules
| Module                                                                      | Version   |
|---------------------------------------------------------------------------|-----------|
[Firewall Rule Collections](https://github.com/data-platform-hq/terraform-azurerm-firewall/tree/init/modules/firewall-rule-collections) | local |

## Resources

| Name                                                                                                                                                          | Type     |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [azurerm_public_ip.fw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip)                                       | resource |
| [azurerm_public_ip.mgmt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip)                                                   | resource |
| [azurerm_firewall.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall) | resource |


## Inputs

| Name                                                                                                                            | Description                                                                                               | Type                                                                                                                            | Default | Required |
|---------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|---------|:--------:|
| <a name="input_sku"></a> [sku](#input\_sku)| SKU tier of the Firewall. Possible values are Premium, Standard and Basic. | `string`| n/a |   yes    |
| <a name="input_location"></a> [location](#input\_location)| Azure location| `string`| n/a |   yes    |
| <a name="input_firewall_name"></a> [firewall\_name](#input\_firewall\_name)| Specifies the name of the Firewall. | `string`| n/a |   yes    |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group)| The name of the resource group in which to create the Azure firewall| `string` | n/a     |   yes    |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name)| Name of VNet where Firewall would be created. | `string`| n/a |   yes    |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr)| IP addresses range of 'AzureFirewallSubnet', has to be at least /26 | `string`| n/a |   yes    |
| <a name="input_subnet_management_cidr"></a> [subnet\_management\_cidr](#input\_subnet\_management\_cidr)| IP addresses range of 'AzureFirewallManagementSubnet', has to be at least /26. This subnet created only when SKU is set to 'Basic' | `string`| null |   no    |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers)| A list of DNS servers that the Azure Firewall will direct DNS traffic to the for name resolution. | `list(string)`| [] | no |
| <a name="input_network_rule_collections"></a> [network\_rule\_collections](#input\_network\_rule\_collections)| List of object with parameters to create network rule collections. |  <pre>list(object({<br>  name     = string,<br>  priority = number,<br>  action   = string,<br>  rules    = list(object({<br>    name                  = string,<br>    source_addresses      = optional(list(string)),<br>    source_ip_groups      = optional(list(string)),<br>    destination_ports     = optional(list(string)),<br>    destination_addresses = optional(list(string)),<br>    destination_ip_groups = optional(list(string)),<br>    destination_fqdns     = optional(list(string)),<br>    protocols             = optional(list(string))<br>  }))<br>}))</pre> | [] |   no    |



## Outputs

| Name                                                               | Description                          |
|--------------------------------------------------------------------|--------------------------------------|
| <a name="subnet_id"></a> [subnet\_id](#output\_subnet\_id)   | Azure Firewall subnet id. |
| <a name="subnet_mgmt_id"></a> [subnet\_mgmt\_id](#output\_subnet\_mgmt\_id)   | Azure Firewall Management subnet id. |
| <a name="name"></a> [name](#output\_name)   | Azure Firewall name. |
| <a name="resource_group"></a> [resource\_group](#output\_resource\_group)   | Azure Firewall resource group. |
| <a name="private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address)   | Azure Firewall private ip address. |
| <a name="public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address)   | Azure Firewall public ip address. |
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azurerm-firewall/blob/init/LICENSE)
