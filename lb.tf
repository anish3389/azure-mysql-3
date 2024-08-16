resource "azurerm_application_gateway" "network" {
  name                = "${var.prefix}appgateway"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.main.name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.subnet_public[2].id
  }

  frontend_port {
    name = "fe-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "fe-ip"
    public_ip_address_id = azurerm_public_ip.lb_ip.id
  }

  backend_address_pool {
    name = "be-pool"
    ip_addresses = [
        azurerm_public_ip.vm_ip_a.ip_address,
        azurerm_public_ip.vm_ip_b.ip_address
    ]
  }

  backend_http_settings {
    name                  = "http_setting"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "http_listener"
    frontend_ip_configuration_name = "fe-ip"
    frontend_port_name             = "fe-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "routing-rule"
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = "http_listener"
    backend_address_pool_name  = "be-pool"
    backend_http_settings_name = "http_setting"
  }
}

# resource "azurerm_lb" "main" {
#   name                = "${var.prefix}lb"
#   location            = var.location
#   resource_group_name = data.azurerm_resource_group.main.name
#   sku = "Standard"

#   frontend_ip_configuration {
#     name                 = "PublicIPAddress"
#     public_ip_address_id = azurerm_public_ip.lb_ip.id
#   }
# }

# resource "azurerm_lb_backend_address_pool" "main" {
#   name                = "${var.prefix}lb_pool"
#   loadbalancer_id = azurerm_lb.main.id
# }

# resource "azurerm_lb_backend_address_pool_address" "ip_a" {
#   name                = "${var.prefix}lb_address_a"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.main.id
#   virtual_network_id      = azurerm_virtual_network.vnet.id
#   ip_address              = azurerm_public_ip.vm_ip_a.ip_address
# }

# resource "azurerm_lb_backend_address_pool_address" "ip_b" {
#   name                = "${var.prefix}lb_address_b"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.main.id
#   virtual_network_id      = azurerm_virtual_network.vnet.id
#   ip_address              = azurerm_public_ip.vm_ip_b.ip_address
# }

# resource "azurerm_lb_probe" "main" {
#   loadbalancer_id = azurerm_lb.main.id
#   name            = "${var.prefix}probe"
#   port            = 80 
# }

# resource "azurerm_lb_rule" "main" {
#   loadbalancer_id                = azurerm_lb.main.id
#   name                           = "${var.prefix}lb-rule"
#   protocol                       = "Tcp"
#   frontend_port                  = 80
#   backend_port                   = 80
#   frontend_ip_configuration_name = "PublicIPAddress"
#   probe_id = azurerm_lb_probe.main.id
# }
