# Terraform Settings Block
terraform {
  required_version = ">= 1.0.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.20.1" # "~> 4.14"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23" #"~> 2.11"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.4.0" # "~> 3.2.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11" #version = "2.5"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }

  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "test-***-eks"
    key    = "terraform.tfstate"
    region = "us-east-1"

    # For State Locking
    dynamodb_table = "test-****-eks"
  }

}

# Terraform Provider Block
provider "aws" {
  region = var.aws_region
}
# Terraform HTTP Provider Block
provider "http" {
  # Configuration options
}
# Datasource: 
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

# Terraform Kubernetes Provider
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", "${var.project}-${var.cluster_name}"]
    command     = "aws"
  }
}
# Terraform kubectl Provider
provider "kubectl" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", "${var.project}-${var.cluster_name}"]
    command     = "aws"
  }
}

# HELM Provider
provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
