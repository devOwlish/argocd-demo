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

  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_B2ms"
    vnet_subnet_id = azurerm_subnet.cluster.id
  }

  identity {
    type = "SystemAssigned"
  }
}

data "azurerm_resource_group" "nodepool" {
  name = "MC_${var.name}_${var.name}_eastus2"

  depends_on = [azurerm_kubernetes_cluster.cluster]
}

resource "azurerm_public_ip" "ingress" {
  name                = var.name
  location            = data.azurerm_resource_group.nodepool.location
  resource_group_name = data.azurerm_resource_group.nodepool.name
  sku                 = "Standard"
  allocation_method   = "Static"
}
