locals {
  ip = {
    sku               = "Standard"
    allocation_method = "Static"
  }

  nsg = {
    security_rule = {
      Allow_HTTP = {
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        access                     = "Allow"
        direction                  = "Inbound"
        priority                   = 1000
      },

      Allow_HTTPS = {
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        access                     = "Allow"
        direction                  = "Inbound"
        priority                   = 1001
      },

      Allow_SSH = {
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        access                     = "Allow"
        direction                  = "Inbound"
        priority                   = 1002
      },

      Allow_AG = {
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "65200 - 65535"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        access                     = "Allow"
        direction                  = "Inbound"
        priority                   = 1003
      }
    }
  }

  nat = {
    name = "${var.prefix}nat"
  }
  vnet = {
    name          = "${var.prefix}vnet"
    address_space = ["10.1.0.0/20"]

    private_subnets = [{
      address_prefixes = ["10.1.0.0/24"]
      }, {
      address_prefixes = ["10.1.1.0/24"]
      }, {
      address_prefixes = ["10.1.2.0/24"]
      },
    ]
    public_subnets = [{
      address_prefixes = ["10.1.10.0/24"]
      }, {
      address_prefixes = ["10.1.11.0/24"]
      }, {
      address_prefixes = ["10.1.12.0/24"]
      }
    ]
  }
}
