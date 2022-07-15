terraform {
  required_providers {
    aws        = {
      source  = "hashicorp/aws"
      version = ">= 3.39.0"
    }
    kubectl    = {
      source  = "gavinbunney/kubectl"
      version = "1.10.0"
    }
    null       = ">= 3.1.0"
    template   = ">= 2.2.0"
    kubernetes = ">= 2.1.0"
    helm       = ">= 2.2.0"
  }
}
