provider "aws" {
  region  = "us-west-2"
}

# VPC Module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  # Update with your values
}

# EKS Module
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  # Update with your values
}

# IAM role for EKS 
resource "aws_iam_role" "demo" {
  name = "example"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Kubernetes provider
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = module.eks.cluster_token
  load_config_file       = false
  version                = "~> 2.3"
}

# AWS IAM Authenticator
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

# Configure kubectl
data "template_file" "kubeconfig" {
  template = file("${path.module}/templates/kubeconfig.tpl")

  vars = {
    cluster_name = var.cluster_name
    aws_region   = var.aws_region
    cluster_id   = module.eks.cluster_id
  }
}
