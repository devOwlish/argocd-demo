data "cloudflare_zone" "owlish" {
  name = var.cloudflare_zone_name
}

resource "cloudflare_record" "argocd" {
  zone_id = data.cloudflare_zone.owlish.id
  name    = "argocd"
  value   = module.aks["demo-argocd"].ingress_ip
  type    = "A"
  ttl     = 1
  proxied = true
}
