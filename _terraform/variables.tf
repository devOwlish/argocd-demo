variable "tenant_id" {}
variable "subscription_id" {}
variable "cloudflare_api_token" {}
variable "cloudflare_account_id" {}
variable "cloudflare_zone_name" {}
##
variable "location" {
  description = "The location/region where the AKS clusters will be created"
  default     = "eastus2"
}

variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default     = "demo"
}

variable "cluster_names" {
  type        = set(string)
  description = "Names of the AKS clusters to create"
  default = [
    "argocd",
    "worker1",
    "worker2"
  ]
}

