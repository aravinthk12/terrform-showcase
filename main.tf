
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.1.0"
    }
  }
}

variable "client_secret" {
  type = string
  description = "Please provide Client secret"
}

variable "client_id" {
  type = string
  description = "Please provide Client id"
}

variable "subscription_id" {
  type = string
  description = "Please provide subscription_id"
}

variable "tenant_id" {
  type = string
  description = "Please provide tenant_id"
}

locals {
  databricks_show = "data-engineering-showcase"
  location = "North Europe"
}


# Configure the Microsoft Azure Provider
provider "azurerm" {
    subscription_id = var.subscription_id
    client_id = var.client_id
    client_secret = var.client_secret
    tenant_id = var.tenant_id
    features {}
}


resource "azurerm_resource_group" "terraform_showcase_automated" {
    name = local.databricks_show
    location = local.location
}

resource "azurerm_databricks_workspace" "db_automated" {
  name = "db-1"
  resource_group_name = local.databricks_show
  location = local.location
  sku = "trial"
  managed_resource_group_name  = "db-managed-rg"
}

resource "azurerm_storage_account" "aravinth2505adls" {
  name = "aravinth2505adls"
  resource_group_name = local.databricks_show
  location = local.location
  account_tier = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_key_vault" "key_vault" {
  name = "show-kv"
  resource_group_name = local.databricks_show
  location = local.location
  tenant_id = var.tenant_id
  sku_name = "standard"
}

resource "azurerm_data_factory" "adf" {
  name = "adf-2505"
  resource_group_name = local.databricks_show
  location = local.location
  
}

