
output "argocd" {
  value     = module.aks["demo-argocd"].host
  sensitive = true
}
output "worker1" {
  value     = module.aks["demo-worker1"].host
  sensitive = true
}
output "worker2" {
  value     = module.aks["demo-worker2"].host
  sensitive = true
}
