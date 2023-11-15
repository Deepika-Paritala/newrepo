terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "Paritala"
    storage_account_name = "casestudy3sa"
    container_name       = "newcon1"
    key                  = "terraform.tfstate"
  }
}
provider "azurerm" {
  features {}
  subscription_id = "77a80280-88a5-4f2d-ae33-c108e45bd54f"
  client_id       = "b67a0672-8756-4b98-b0db-552044015d62"
  tenant_id       = "a00090b1-2689-4928-845c-92491870d7ab"
  client_secret   = "G0H8Q~z0HruA0N1FWfFI8nZFqdm69wtT3TZywdbo"
}


data "azurerm_resource_group" "rg" {
  name = "Paritala"
}


resource "azurerm_service_plan" "plan" {
  name                = "${var.planname}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku_name            = "S1"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "app" {
  name                = "${var.appname}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    always_on = true
  }
}