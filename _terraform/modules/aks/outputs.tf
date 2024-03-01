output "ingress_ip" {
  value = azurerm_public_ip.ingress.ip_address
}

output "host" {
  value = azurerm_kubernetes_cluster.cluster.kube_config.0.host
}

output "identity" {
  value = azurerm_kubernetes_cluster.cluster.kubelet_identity.0.object_id
}

output "id" {
  value = azurerm_kubernetes_cluster.cluster.id
}
