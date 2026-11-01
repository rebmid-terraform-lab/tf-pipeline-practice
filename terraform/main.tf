terraform {
  required_version = ">= 1.9, < 2.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # Backend values are passed at init time with -backend-config, so nothing environment-specific is committed.
  backend "azurerm" {
    use_azuread_auth = true
    use_oidc         = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
  # subscription_id, client_id and tenant_id come from the ARM_* environment variables.
}

variable "location" {
  type    = string
  default = "westus3"
}

variable "environment" {
  type    = string
  default = "nonprod"
}

resource "azurerm_resource_group" "practice" {
  name     = "rg-ailz-practice-${var.environment}"
  location = var.location

  tags = {
    purpose = "pipeline-practice"
  }
}

output "resource_group_name" {
  value = azurerm_resource_group.practice.name
}
