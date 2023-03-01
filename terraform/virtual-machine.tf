resource "azurerm_windows_virtual_machine" "vm" {
  name                = "primary-server"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vmsize
  admin_username      = "serveradmin"
  admin_password      = random_password.password.id
  network_interface_ids = [
    azurerm_network_interface.server.id
  ]
  os_disk {
    storage_account_type = "Premium_SSD"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}