variable "location" {
  description = "The location/region where the AKS clusters will be created"
  default     = "eastus2"
}

variable "name" {
  description = "The name of the AKS cluster"
}

variable "subnet_cidr" {
  description = "The CIDR block for the AKS subnet"
  default     = ["10.1.1.0/24"]
}

