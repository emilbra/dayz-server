resource "azurerm_virtual_network" "default" {
  name                = "default-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# resource "azurerm_network_security_group" "default_nsg" {
#   name = "default_nsg"
#   location = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   security_rule = [ {
#     access = "value"
#     description = "value"
#     destination_address_prefix = "value"
#     destination_address_prefixes = [ "value" ]
#     destination_application_security_group_ids = [ "value" ]
#     destination_port_range = "value"
#     destination_port_ranges = [ "value" ]
#     direction = "value"
#     name = "value"
#     priority = 1
#     protocol = "value"
#     source_address_prefix = "value"
#     source_address_prefixes = [ "value" ]
#     source_application_security_group_ids = [ "value" ]
#     source_port_range = "*"
#   },
#    ]
# }

resource "azurerm_subnet" "default" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "server" {
  name                = "server-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.default.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}

resource "azurerm_public_ip" "pip" {
  name                = "serverpublicpip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
}
