resource "azurerm_mysql_flexible_server_configuration" "main" {
  name                = "require_secure_transport"
  resource_group_name = data.azurerm_resource_group.main.name
  server_name         = azurerm_mysql_flexible_server.main.name
  value               = "OFF"
}

resource "azurerm_mysql_flexible_server" "main" {
  name                   = "${var.prefix}-dbserver"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.main.name

  administrator_login    = "sqladmin"
  administrator_password = "H@Sh1CoR3!"
  backup_retention_days  = 7
  delegated_subnet_id    = azurerm_subnet.subnet_private2.id
  sku_name = "GP_Standard_D4ds_v4"
  zone = 2
  version = "8.0.21"

  high_availability {
    mode = "SameZone"
    standby_availability_zone = 2
  }
}

resource "azurerm_mysql_flexible_database" "example" {
  name                   = "${var.prefix}-db"
  resource_group_name = data.azurerm_resource_group.main.name
  server_name         = azurerm_mysql_flexible_server.main.name
  charset             = "utf8mb3"
  collation           = "utf8mb3_unicode_ci"
}
