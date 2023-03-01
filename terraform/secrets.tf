resource "random_pet" "pet" {
  length = 1
}

resource "azurerm_key_vault" "keyvault" {
  name                = "keyvault-${random_pet.pet.id}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "Basic"
  tenant_id           = var.tenant_id
}

resource "azurerm_key_vault_secret" "admin_password" {
  name     = "admin-password"
  value    = random_password.password.id
  senstive = true
}

# Not "SAFE"
resource "random_password" "password" {
  length  = 16
  special = true
}