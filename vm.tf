data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content = templatefile("./cloud-init.cfg", {
      DB_HOST = azurerm_mysql_flexible_server.main.fqdn 
      DB_PASSWORD = azurerm_mysql_flexible_server.main.administrator_password
      DB_USERNAME = azurerm_mysql_flexible_server.main.administrator_login
      DB_NAME = "wp"
      APACHE_LOG_DIR = "/var/log/apache2"
    })
  }
}

resource "azurerm_linux_virtual_machine" "publica" {
  name                = "${var.prefix}_vm_public_a"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.main.name

  network_interface_ids = [azurerm_network_interface.public_a.id]
  size                  = "Standard_B2ts_v2"
  zone                  = "2"

  custom_data = data.template_cloudinit_config.config.rendered

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  os_disk {
    name                 = "vmdisk1"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  computer_name = "zone2"
  admin_username = "ubuntu"
  admin_ssh_key {
    public_key = file("/home/anishs/.ssh/id_rsa.pub")
    username   = "ubuntu"
  }

  tags = var.default_tags
}

resource "azurerm_linux_virtual_machine" "publicb" {
  name                = "${var.prefix}_vm_public_b"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.main.name

  network_interface_ids = [azurerm_network_interface.public_b.id]
  size                  = "Standard_B2ts_v2"
  zone                  = "1"

  custom_data = data.template_cloudinit_config.config.rendered

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  os_disk {
    name                 = "vmdisk2ss"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  computer_name = "zone1"
  admin_username = "ubuntu"
  admin_ssh_key {
    public_key = file("/home/anishs/.ssh/id_rsa.pub")
    username   = "ubuntu"
  }

  tags = var.default_tags
}