terraform {
    backend "azurerm" {
        resource_group_name = "tfstatestoragestg1"
        storage_account_name = "tfstatestorageus1"
        container_name = "prod2"
        key = "terraform.prod2"
        access_key = "ZPxpNfV6uBi7j7ZaccrTQcCJ2Zp5thorYu6cCcPmVH4wiRstYeMYorEScNiuLzLyAhfeHaweigYqANzj5b27Pw=="
      
    }
}

variable "subscription_id" {
    type =  string
    default = "049cc0b9-2696-4e70-871b-4366be487c19"
}

variable "tenant_id" {
    type =  string
    default = "477cf0a5-266c-4331-8f0a-865f4622d888"
}

variable "client_id" {
    type =  string
    default = "e9b84595-b15d-49d7-bd26-3d650fb8c5fc"
}

variable "client_secret" {
    type =  string
    default = "bKRQK~f~~7RSlLlnmB275r8_vHS6k61_Hn"
}

locals {
  setup_name = "practice-hyd1"
}

provider "azurerm" {
    features {}
    subscription_id = var.subscription_id
    tenant_id = var.tenant_id
    client_id = var.client_id
    client_secret = var.client_secret
}

resource "azurerm_resource_group" "staging" {
  name = "stagingrg"
  location = "east us"
  tags = {
    "name" = "${local.setup_name}-rg"
  }
}

resource "azurerm_app_service_plan" "stagingplan" {
    name = "appplan-staging"
    resource_group_name = azurerm_resource_group.staging.name
    location = azurerm_resource_group.staging.location

    sku {
      tier = "Standard"
      size = "S1"
    }
    tags = {
      "name" = "${local.setup_name}-appplan"
    }
  
}

resource "azurerm_app_service" "stagingapp" {
  name = "stagingwebapp47895"
  location = azurerm_resource_group.staging.location
  resource_group_name = azurerm_resource_group.staging.name
  app_service_plan_id = azurerm_app_service_plan.stagingplan.id
  depends_on = [
    azurerm_app_service_plan.stagingplan
  ]
  tags = {
    "name" = "${local.setup_name}-webapp"
  }
}
