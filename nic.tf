resource "azurerm_network_interface" "public_a" {
  name                = "${var.prefix}vnet_public_nic_a"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                          = "public_ip_config"
    subnet_id                     = azurerm_subnet.subnet_public[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.vm_ip_a.id
  }

  tags = var.default_tags
}

resource "azurerm_network_interface" "public_b" {
  name                = "${var.prefix}vnet_public_nic_b"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                          = "public_ip_config"
    subnet_id                     = azurerm_subnet.subnet_public[1].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.vm_ip_b.id
  }

  tags = var.default_tags
}