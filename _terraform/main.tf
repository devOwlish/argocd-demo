locals {
  clusters_names = toset([for name in var.cluster_names : "${var.prefix}-${name}"])
}

module "aks" {
  source = "./modules/aks"

  for_each = local.clusters_names

  location = var.location
  name     = each.value
}


resource "azurerm_role_assignment" "worker1" {
  scope                            = module.aks["demo-worker1"].id
  role_definition_name             = "Azure Kubernetes Service RBAC Cluster Admin"
  principal_id                     = module.aks["demo-argocd"].identity
  skip_service_principal_aad_check = true
}


resource "azurerm_role_assignment" "worker2" {
  scope                            = module.aks["demo-worker2"].id
  role_definition_name             = "Azure Kubernetes Service RBAC Cluster Admin"
  principal_id                     = module.aks["demo-argocd"].identity
  skip_service_principal_aad_check = true
}
