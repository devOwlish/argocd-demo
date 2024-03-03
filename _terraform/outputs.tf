output "argocd_identity" {
  value = module.aks["demo-argocd"].identity
}
output "worker1_host" {
  value     = module.aks["demo-worker1"].host
  sensitive = true
}
output "worker2_host" {
  value     = module.aks["demo-worker2"].host
  sensitive = true
}
