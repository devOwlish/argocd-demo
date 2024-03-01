locals {
  infra_prefix   = "${var.prefix}-infra"
  clusters_names = toset([for name in var.cluster_names : "${var.prefix}-${name}"])

}

resource "azurerm_resource_group" "rg" {
  for_each = setunion(local.clusters_names, [local.infra_prefix])

  location = var.location
  name     = each.value
}

resource "azurerm_virtual_network" "shared" {
  name                = "${local.infra_prefix}-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg[local.infra_prefix].name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "cluster" {
  for_each = local.clusters_names

  name                 = each.value
  resource_group_name  = azurerm_resource_group.rg[local.infra_prefix].name
  virtual_network_name = azurerm_virtual_network.shared.name
  address_prefixes     = ["10.1.${index(tolist(local.clusters_names), each.value) + 1}.0/24"]
}

resource "azurerm_kubernetes_cluster" "cluster" {
  for_each = local.clusters_names

  name                = each.value
  dns_prefix          = each.value
  location            = var.location
  resource_group_name = azurerm_resource_group.rg[each.value].name

  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_B2ms"
    vnet_subnet_id = azurerm_subnet.cluster[each.value].id
  }

  identity {
    type = "SystemAssigned"
  }

}
