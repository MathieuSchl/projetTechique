provider "azurerm" {
  client_id     = var.client_id
  client_secret = var.client_secret
  
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

resource "azurerm_resource_group" "aks" {
  name     = "my-aks-resource-group"
  location = "westeurope"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "my-aks-cluster"
  location            = "${azurerm_resource_group.aks.location}"
  resource_group_name = "${azurerm_resource_group.aks.name}"
  dns_prefix          = "my-aks-dns"

  default_node_pool {
    name            = "agentpool"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

terraform {
  backend "azurerm" {
    ressource_group_name = "my-aks-resource-group"
    storage_account_name = "tfstateforterraform"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}