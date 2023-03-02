resource "random_pet" "pet" {
  length = 1
}

resource "azurerm_key_vault" "keyvault" {
  name                      = "keyvault-${random_pet.pet.id}"
  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name
  sku_name                  = "standard"
  tenant_id                 = var.tenant_id
  enable_rbac_authorization = true
}

# Not "SAFE"
resource "azurerm_key_vault_secret" "admin_password" {
  name         = "admin-password"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.keyvault.id
}

# Not "SAFE"
resource "random_password" "password" {
  length      = 16
  special     = true
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}