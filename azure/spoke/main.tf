module "naming" {
  source        = "Azure/naming/azurerm"
  version       = "0.4.2"
  suffix        = [ "${var.name}", "${var.environment}" ]
  unique-length = 8
}

resource "azurerm_resource_group" "this" {
  name     = module.naming.resource_group.name
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  name                = module.naming.virtual_network.name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [var.vnet]

}

resource "azurerm_subnet" "this" {
  name                 = module.naming.subnet.name
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [cidrsubnet(var.vnet, 8, 1)]
}

resource "azurerm_storage_account" "this" {
  name                     = module.naming.storage_account.name.unique
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "this" {
  name                  = "terraform"
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"
}
