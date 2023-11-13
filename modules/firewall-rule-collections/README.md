# Azure Firewall Rule Collections Terraform module
Terraform module for creation Azure Firewall Rule Collections

## Usage
This module is provisioning Azure Firewall
```hcl
data "azurerm_firewall" "example" {
  name                = "example-name"
  resource_group_name = "example-rg"
}

module "firewall_rule_collections" {
  source = "./modules/firewall-rule-collections"

  firewall_name  = data.azurerm_firewall.example.name
  resource_group = "example-rg"
  action         = "Allow"
  priority       = 100
  network_rule_collections = {
    name                  = "example-rg",
    source_addresses      = [10.0.0.0/8],
    destination_ports     = ["53"],
    destination_addresses = ["8.8.8.8", "8.8.4.4",]
    protocols             = ["TCP", "UDP"]
    }
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

No modules.

## Resources

| Name                                                                                                                                                          | Type     |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [azurerm_firewall_network_rule_collection.network_rule_collection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_network_rule_collection)| resource |



## Inputs

| Name                                                                                                                            | Description                                                                                               | Type                                                                                                                            | Default | Required |
|---------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|---------|:--------:|
| <a name="input_firewall_name"></a> [firewall\_name](#input\_firewall\_name)| Target Azure Firewall name where collection rules would be created. | `string`| n/a |   yes    |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group)| Target Azure Firewall Resource Group | `string`| n/a |   yes    |
| <a name="input_network_rule_collections"></a> [network\_rule\_collections](#input\_network\_rule\_collections)| Creates a network rule collection. |  <pre>list(object({<br>  name     = string,<br>  priority = number,<br>  action   = string,<br>  rules = list(object({<br>    name                  = string,<br>    source_addresses      = optional(list(string)),<br>    source_ip_groups      = optional(list(string)),<br>    destination_ports     = optional(list(string)),<br>    destination_addresses = optional(list(string)),<br>    destination_ip_groups = optional(list(string)),<br>    destination_fqdns     = optional(list(string)),<br>    protocols             = optional(list(string))<br>  }))<br>  }))</pre> | [] |   no    |

## Outputs

| Name                                                               | Description                          |
|--------------------------------------------------------------------|--------------------------------------|

<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azurerm<>/tree/master/LICENSE)
