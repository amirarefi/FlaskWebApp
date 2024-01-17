variable "subscription_id" {}
variable "client_id" {}
variable "tenant_id" {}
variable "location" {}

terraform {
  backend "azurerm" {
    resource_group_name  = "your resource group"
    storage_account_name = "your storage account"
    container_name       = "amirtest"
    key                  = "amir_apptest.terraform.tfstate"
  }
}

resource "azurerm_kubernetes_cluster" "Test_WebApp" {
  name                = "Test_WebApp"
  location            = "East US"
  resource_group_name = "Amir_Test"
  dns_prefix          = "testwebapp-dns"

  default_node_pool {
    name       = "linux"
    node_count = 1
    vm_size    = "Standard_B2s"
    os_sku     = "Ubuntu"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "test"
  }

  local_account_disabled = false

  network_profile {
    network_plugin     = "kubenet"
    dns_service_ip     = "10.0.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    outbound_type      = "loadBalancer"
    pod_cidr           = "10.244.0.0/16"
    service_cidr       = "10.0.0.0/16"
    load_balancer_profile {
      managed_outbound_ip_count = 1
      idle_timeout_in_minutes   = 4
    }
  }
}
