resource "azurerm_network_security_group" "allow_http_ssh" {
  name                = "${var.prefix}vnet_sg"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.main.name

  tags = var.default_tags
}

resource "azurerm_network_security_rule" "nsg_rule" {
  for_each                    = local.nsg.security_rule

  name                        = each.key
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  access                      = each.value.access
  direction                   = each.value.direction
  priority                    = each.value.priority

  resource_group_name         = data.azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.allow_http_ssh.name
}


resource "azurerm_subnet_network_security_group_association" "az-nsg-associate_public" {
  subnet_id                 = azurerm_subnet.subnet_public[0].id
  network_security_group_id = azurerm_network_security_group.allow_http_ssh.id
}

resource "azurerm_subnet_network_security_group_association" "az-nsg-associate_public1" {
  subnet_id                 = azurerm_subnet.subnet_public[1].id
  network_security_group_id = azurerm_network_security_group.allow_http_ssh.id
}