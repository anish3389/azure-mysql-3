resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet.name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.main.name
  address_space       = local.vnet.address_space

  tags = var.default_tags
}

resource "azurerm_subnet" "subnet_public" {
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.main.name

  count            = length(local.vnet.public_subnets)
  name             = "${var.prefix}-public-subnet${count.index}"
  address_prefixes = local.vnet.public_subnets[count.index].address_prefixes
}

resource "azurerm_subnet" "subnet_private0" {
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.main.name

  name             = "${var.prefix}-private-subnet0"
  address_prefixes = local.vnet.private_subnets[0].address_prefixes
}

resource "azurerm_subnet" "subnet_private1" {
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.main.name

  name             = "${var.prefix}-private-subnet1"
  address_prefixes = local.vnet.private_subnets[1].address_prefixes
}

resource "azurerm_subnet" "subnet_private2" {
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.main.name

  name             = "${var.prefix}-private-subnet2"
  address_prefixes = local.vnet.private_subnets[2].address_prefixes

  delegation {
    name = "Delegation_db"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]

    }
  }
}
