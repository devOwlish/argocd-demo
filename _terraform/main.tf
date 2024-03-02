locals {
  clusters_names = toset([for name in var.cluster_names : "${var.prefix}-${name}"])
}

module "aks" {
  source = "./modules/aks"

  for_each = local.clusters_names

  location = var.location
  name     = each.value
}
