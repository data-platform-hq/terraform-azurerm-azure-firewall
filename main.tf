module "subnet" {
  source  = "data-platform-hq/subnet/azurerm"
  version = "1.2.6"

  name           = "AzureFirewallSubnet"
  network        = var.vnet_name
  resource_group = var.resource_group
  cidr           = var.subnet_cidr
}

module "subnet_mgmt" {
  count   = var.sku == "Basic" ? 1 : 0
  source  = "data-platform-hq/subnet/azurerm"
  version = "1.2.6"

  name           = "AzureFirewallManagementSubnet"
  network        = var.vnet_name
  resource_group = var.resource_group
  cidr           = var.subnet_management_cidr
}

resource "azurerm_public_ip" "fw" {
  name                = "ip-${var.firewall_name}"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "mgmt" {
  count = var.sku == "Basic" ? 1 : 0

  name                = "ip-mgmt-${var.firewall_name}"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "this" {
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group
  sku_name            = "AZFW_VNet"
  sku_tier            = var.sku
  private_ip_ranges   = ["IANAPrivateRanges"]
  dns_servers         = var.sku != "Basic" ? var.dns_servers : null

  ip_configuration {
    name                 = "AzureFirewallIpConfiguration0"
    subnet_id            = module.subnet.id
    public_ip_address_id = azurerm_public_ip.fw.id
  }

  dynamic "management_ip_configuration" {
    for_each = var.sku == "Basic" ? [1] : []
    content {
      name                 = "management_configuration"
      subnet_id            = module.subnet_mgmt[0].id
      public_ip_address_id = azurerm_public_ip.mgmt[0].id
    }
  }
}

module "firewall_rule_collections" {
  source = "./modules/firewall-rule-collections"

  firewall_name            = azurerm_firewall.this.name
  resource_group           = var.resource_group
  network_rule_collections = var.network_rule_collections
}
