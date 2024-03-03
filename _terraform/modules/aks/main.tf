resource "azurerm_resource_group" "cluster" {
  location = var.location
  name     = var.name
}

resource "azurerm_virtual_network" "cluster" {
  name                = var.name
  location            = azurerm_resource_group.cluster.location
  resource_group_name = azurerm_resource_group.cluster.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "cluster" {
  name                 = var.name
  resource_group_name  = azurerm_resource_group.cluster.name
  virtual_network_name = azurerm_virtual_network.cluster.name
  address_prefixes     = var.subnet_cidr
}


resource "azurerm_kubernetes_cluster" "cluster" {
  name                = var.name
  dns_prefix          = var.name
  location            = azurerm_resource_group.cluster.location
  resource_group_name = azurerm_resource_group.cluster.name
  node_resource_group = "${azurerm_resource_group.cluster.name}-nodepool"


  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_DS2_v2"
    vnet_subnet_id = azurerm_subnet.cluster.id
  }

  identity {
    type = "SystemAssigned"
  }

  azure_active_directory_role_based_access_control {
    azure_rbac_enabled = true
    managed            = true
  }
}

resource "azurerm_public_ip" "ingress" {
  name                = "ingress-pip"
  location            = azurerm_kubernetes_cluster.cluster.location
  resource_group_name = "${azurerm_resource_group.cluster.name}-nodepool"
  sku                 = "Standard"
  allocation_method   = "Static"
}
