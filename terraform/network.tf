resource "azurerm_virtual_network" "default" {
  name                = "default-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_group" "default_nsg" {
  name                = "default_nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_rule" "allow_inbound_2302_UDP" {
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.default_nsg.name
  access                      = "Allow"
  description                 = "Allow_inbound_2302_UDP_Default_GamePort"
  destination_address_prefix  = "VirtualNetwork"
  destination_port_range      = "*"
  direction                   = "Inbound"
  name                        = "Inbound_2302_UDP"
  priority                    = 100
  protocol                    = "Udp"
  source_address_prefix       = "*"
  source_port_range           = "*"
}

resource "azurerm_network_security_rule" "allow_inbound_27016_UDP" {
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.default_nsg.name
  access                      = "Allow"
  description                 = "Allow_inbound_27016_UDP_Steam_Query_Port"
  destination_address_prefix  = "VirtualNetwork"
  destination_port_range      = "*"
  direction                   = "Inbound"
  name                        = "Inbound_27016_UDP"
  priority                    = 150
  protocol                    = "Udp"
  source_address_prefix       = "*"
  source_port_range           = "*"
}

resource "azurerm_network_security_rule" "allow_inbound_2312_TCP" {
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.default_nsg.name
  access                      = "Allow"
  description                 = "Allow_inbound_2312_TCP_DZSALauncher"
  destination_address_prefix  = "VirtualNetwork"
  destination_port_range      = "*"
  direction                   = "Inbound"
  name                        = "Inbound_2312_TCP_for_DZSALauncher"
  priority                    = 200
  protocol                    = "Tcp"
  source_address_prefix       = "*"
  source_port_range           = "*"
}

resource "azurerm_network_security_rule" "deny_default_all_inbound" {
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.default_nsg.name
  access                      = "Deny"
  description                 = "Deny Default All Inbound communication that does not match other rules"
  destination_address_prefix  = "*"
  destination_port_range      = "*"
  direction                   = "Inbound"
  name                        = "Deny_all"
  priority                    = 999
  protocol                    = "Tcp"
  source_address_prefix       = "*"
  source_port_range           = "*"
}

resource "azurerm_subnet_network_security_group_association" "nsg_subnet_assoc" {
  network_security_group_id = azurerm_network_security_group.default_nsg.id
  subnet_id                 = azurerm_subnet.default.id
}

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
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_public_ip" "pip" {
  name                = "serverpublicpip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
}
