resource "azurerm_public_ip" "vm_ip_a" {
  name                = "${var.prefix}ip_vm_a"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.main.name

  allocation_method   = local.ip.allocation_method
  sku = local.ip.sku

  tags = var.default_tags
}

resource "azurerm_public_ip" "vm_ip_b" {
  name                = "${var.prefix}ip_vm_b"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.main.name

  allocation_method   = local.ip.allocation_method
  sku = local.ip.sku

  tags = var.default_tags
}

resource "azurerm_public_ip" "lb_ip" {
  name                = "${var.prefix}ip_lb"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.main.name

  allocation_method   = local.ip.allocation_method
  sku = local.ip.sku

  tags = var.default_tags
}